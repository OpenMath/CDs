<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 xmlns:fLRaux="http://fxsl.sf.net/LR/AUX"
 exclude-result-prefixes="f fLRaux xs"
 >
 <xsl:import href="../f/func-apply.xsl"/>
 
 <xsl:variable name="pDebug" as="xs:boolean" select="false()"/>
 <xsl:variable name="pDebugLex" as="xs:boolean" select="false()"/>
 
 <xsl:output omit-xml-declaration="yes" indent="yes"/>
 
 <xsl:key name="kActByStateSymb" match="@act" 
          use="concat(../../@number,'T', ..)"/>
 
 <xsl:key name="kRuleByPos" match="r"
          use="count(preceding-sibling::r)"/>
          
 <xsl:key name="kGotoState" match="@newState"
          use="concat(../@number,'NT',../@NT)"/>
 <xsl:function name="f:lrParse" as="element()*">
   <xsl:param name="ppTables" as="element()"/>
   <xsl:param name="pInput" as="xs:string*"/>
   <xsl:param name="pFunLex" as="element()"/>
   <xsl:param name="pFunOnRuleReduced" as="element()"/>
   
   <xsl:sequence select=
    "fLRaux:lrParse($ppTables,$pInput,1,
                    (),(0),(),
                    $pFunLex,$pFunOnRuleReduced
                    )"
    />
 </xsl:function>
 
 <xsl:function name="fLRaux:lrParse" as="element()*">
   <xsl:param name="ppTables" as="element()"/>
   <xsl:param name="pInput" as="xs:string*"/>
   <xsl:param name="pInputInd" as="xs:integer"/>
   <xsl:param name="pCurLexeme" as="element()?"/>
   <xsl:param name="pStack" as="xs:integer+"/>
   <xsl:param name="pValStack" as="element()*"/>
   <xsl:param name="pFunLex" as="element()"/>
   <xsl:param name="pFunOnRuleReduced" as="element()"/>

<!-- Call Lexer here! -->
  
  <xsl:variable name="vLexResults" as="item()*"
   select="if(empty($pCurLexeme))
              then
                 f:apply($pFunLex, $pInput, $pInputInd)
               else ()
            "/>
<!--            
     <xsl:message>
       $pCurLexeme: '<xsl:sequence select="$pCurLexeme"/>'
       
       vLexResults: '<xsl:sequence select="$vLexResults"/>'
     </xsl:message>
-->   
     <xsl:variable name="vToken" as="xs:string"
     select="if(empty($pCurLexeme))
              then
                 $vLexResults[2]
               else $pCurLexeme/@name
              "/>
     
    <xsl:variable name="vValue" as="item()?"
     select="if(empty($pCurLexeme))
               then $vLexResults[3]
               else string($pCurLexeme)"/>
     
    <xsl:variable name="vnewIndex" as="xs:integer"
     select="if(empty($pCurLexeme))
               then $vLexResults[1]
               else $pInputInd"/>
  
    <xsl:variable name="vCurLexeme2" as="element()?">
	    <xsl:if test="empty($pCurLexeme)">
		    <term name="{$vToken}">
		      <xsl:choose>
				    <xsl:when test="$vToken eq 'error'">
				      <xsl:attribute name="at" select="$pInputInd"/>
				    </xsl:when>
				    <xsl:otherwise>
				      <xsl:sequence select="$vValue"/>
				    </xsl:otherwise>
		      </xsl:choose>
		    </term>
	    </xsl:if>
    </xsl:variable>
    
    <xsl:if test="$pDebugLex">
      <xsl:if test="empty($pCurLexeme)">
        <xsl:message>
          New Lexeme: <xsl:sequence select="$vCurLexeme2"/>
        </xsl:message>
      </xsl:if>
    </xsl:if>

    <xsl:variable name="vCurLexeme" as="element()"
     select="if(empty($pCurLexeme))
               then $vCurLexeme2
               else $pCurLexeme"
    />
<xsl:if test="$pDebug">
    <xsl:message>
      $vCurLexeme: '<xsl:sequence select="$vCurLexeme"/>'
      
      $pStack: '<xsl:sequence select="$pStack"/>'
      
      $pValStack: '<xsl:sequence select="$pValStack"/>'
      
    </xsl:message>
</xsl:if>    
   <xsl:choose>
    <xsl:when test="$vToken eq 'error'">
<xsl:if test="$pDebug">
      <xsl:message>$vToken = 'error'  !!!!!</xsl:message>
</xsl:if>
      <xsl:sequence select=
        "$pCurLexeme, $pValStack"/>
    </xsl:when>
    
    <xsl:otherwise>
		   <xsl:variable name="vAct" as="xs:string?"
		     select="key('kActByStateSymb',
		                  concat($pStack[1],'T', 
		                         $vToken
		                         ),
		                  $ppTables
		                 )[1]"
		   />
		   <xsl:variable name="vAct2" as="xs:string?"
		     select=
		      "if($vAct != '')
		        then 
		          $vAct
		        else
		          key('kActByStateSymb',
		                  concat($pStack[1],'T', 
		                         '.'
		                         ),
		                  $ppTables
		          )
		     "
		   />
<xsl:if test="$pDebug">
		   <xsl:message>
		      $vAct2: '<xsl:sequence select="$vAct2"/>'
		   </xsl:message>
</xsl:if>
		   <xsl:choose>
		     <xsl:when test="not($vAct2)">
		       <xsl:variable name="verrNT" as="element()">
		         <NonTerminal name="Error" at="{$pInputInd}"/>
		       </xsl:variable>
		       <xsl:sequence select="$verrNT, $pValStack"/>
		     </xsl:when>
		     <!-- acc, shift or reduce -->
		     <xsl:when test="$vAct2 = 'acc'">
		        <xsl:sequence select="$pValStack"/> 
		     </xsl:when>
		     
		     <!-- Shift N -->
		     <xsl:when test="starts-with($vAct2, 's')">
<xsl:if test="$pDebug">
		       <xsl:message>
		         Shift '<xsl:sequence select="substring($vAct2,2)"/>'
		       </xsl:message>
</xsl:if>		     
		       <xsl:sequence select=
		       "fLRaux:lrParse($ppTables,$pInput,$vnewIndex,
		                  (),
		                  (xs:integer(substring($vAct2,2)),
		                   $pStack),
		                   ($vCurLexeme, $pValStack),
		                   $pFunLex,
		                   $pFunOnRuleReduced
		                  )"
		       />
		     </xsl:when>
		     <!-- Reduce K -->
		     <xsl:otherwise>
		       <xsl:variable name="vRuleNo" as="xs:integer"
		            select="xs:integer(substring($vAct2,2))"/>
		       
		       <xsl:variable name="vRule" as="element()"
		        select="key('kRuleByPos',$vRuleNo,$ppTables)"/>
		                     
		       <!-- <xsl:sequence select="$vRuleNo"/> -->
<xsl:if test="$pDebug">
		       <xsl:message>
		         Before Reduce '<xsl:sequence select="$vRuleNo"/>'
		         $vRule: '<xsl:sequence select="$vRule"/>'
		         $pValStack: '<xsl:sequence select="$pValStack"/>'
		       </xsl:message>
</xsl:if>		       		       
		       <xsl:variable name="vRuleOutput" as="element()"
		         select="f:apply($pFunOnRuleReduced, 
		                         $vRule, $pValStack
		                         )"
		       />
		        
		       <xsl:variable name="vredcStack" as="xs:integer+"
		        select="subsequence($pStack,1 + $vRule/@length)"/>
		        
		       <xsl:variable name="vredcValStack" as="item()*"
		        select="subsequence($pValStack,1 + $vRule/@length)"/>
		       
		       <xsl:variable name="vNewState" as="xs:integer"
		        select="xs:integer(
				                key('kGotoState', 
				                     concat($vredcStack[1],'NT',
				                            $vRule/@left
				                            ),
				                     $ppTables)
				                        )"/>
<xsl:if test="$pDebug">
		       <xsl:message>
		         Reduced '<xsl:sequence select="$vRuleNo"/>'
		         $vRule: '<xsl:sequence select="$vRule"/>'
		         Reduced Stack: '<xsl:sequence 
		            select="$vNewState,$vredcStack"/>'
		         Reduced ValStack: '<xsl:sequence 
		            select="$vRuleOutput, $vredcValStack"/>'
		       </xsl:message>
</xsl:if>	        		       
		       <xsl:sequence select=
		       "fLRaux:lrParse($ppTables,$pInput,$vnewIndex,
		                  $vCurLexeme,
		                  ($vNewState,$vredcStack),
		                  ($vRuleOutput, $vredcValStack),
		                   $pFunLex,
		                   $pFunOnRuleReduced
		                  )"
		       />
		     </xsl:otherwise>
		   </xsl:choose>
    </xsl:otherwise>
   </xsl:choose>
 </xsl:function>

</xsl:stylesheet>