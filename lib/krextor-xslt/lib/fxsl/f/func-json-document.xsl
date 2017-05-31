<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f xs"
 >
 <xsl:import href="../f/func-lrParse.xsl"/>
 
 <xsl:variable name="vJSDebug" as="xs:boolean" select="false()"/>
 
 <xsl:output omit-xml-declaration="yes" indent="yes"/>
 
 <xsl:variable name="vJasonPPTables" select=
  "document('parseTables-Jason.xml')/*"/>
 
 <xsl:function name="f:json-document" as="document-node()?">
   <xsl:param name="pstrJson" as="xs:string"/>
   
   <xsl:variable name="vparseResult">
	   <xsl:sequence select=
	    "f:lrParse($vJasonPPTables,
	                    $pstrJson,
	                    f:lexer-JSON(),
	                    f:OnJSONRuleReduced() 
	               )
	               /computedValue/node() 
     "
	    />
    </xsl:variable>
    
    <xsl:sequence select="$vparseResult"/>
 </xsl:function>
 
 <xsl:function name="f:json-file-document" as="document-node()?">
   <xsl:param name="pFileURL" as="xs:string"/>
   
   <xsl:sequence select="f:json-document(unparsed-text($pFileURL))"/>
 </xsl:function>

 <xsl:function name="f:OnJSONRuleReduced" as="element()">
   <f:OnJSONRuleReduced/>
 </xsl:function>
 
 <xsl:template match="f:OnJSONRuleReduced" mode="f:FXSL"
  as="element()">
   <xsl:param name="arg1" as="element()"/>
   <xsl:param name="arg2" as="element()*"/>
  
   <xsl:sequence select="f:OnJSONRuleReduced($arg1,$arg2)"/>
 </xsl:template>
 
 <xsl:function name="f:OnJSONRuleReduced" as="element()">
   <xsl:param name="pRule" as="element()"/>
   <xsl:param name="pValStack" as="element()*"/>

   <xsl:variable name="vCompValues" as="element()*"
    select="$pValStack[position() le xs:integer($pRule/@length)]"/>
   
   <sym name="{$pRule/@left}">

    <computedValue>
      <xsl:sequence select=
      "f:computedValue($vCompValues,$pRule)"/>
    
    </computedValue>
    <components>
       <xsl:sequence select=
        "for $len in count($vCompValues),
             $i in 0 to $len - 1
                return $vCompValues[$len - $i]
        "/>
    </components>
   </sym>
 </xsl:function>

 <xsl:function name="f:computedValue" as="item()*">
   <xsl:param name="pComponents" as="element()*"/>
   <xsl:param name="pRule" as="element()"/>

<xsl:if test="$vJSDebug">
   <xsl:message>
     Rule<xsl:sequence select="count($pRule/preceding-sibling::*)"/>: '<xsl:sequence select="$pRule"/>'
     
     Components: '<xsl:sequence select="$pComponents"/>'
   </xsl:message>
</xsl:if>
   <xsl:variable name="vruleLength" as="xs:integer"
        select="$pRule/@length"/>
   
   <xsl:variable name="vLen1" as="xs:integer" 
        select="$vruleLength+1"/>
   
   <xsl:variable name="vlhsName" select="$pRule/@left"/>
   
   <xsl:variable name="vResult">
   <xsl:if test="$vruleLength gt 0">
     <xsl:choose>
       <xsl:when test="$vlhsName eq 'OBJECT'">
         <xsl:if test="$vruleLength eq 3">
           <xsl:sequence select="$pComponents[2]/computedValue/node()"/>
         </xsl:if>
       </xsl:when>
       <xsl:when test="$vlhsName eq 'MEMBERS'">
         <xsl:sequence select=
          "if($vruleLength eq 1)
             then $pComponents[1]/computedValue/node()
             else
               if($vruleLength eq 3)
                  then
                    ($pComponents[3]/computedValue/node(),
                     $pComponents[1]/computedValue/node()
                    )
                   else 'MEMBERS rule Error!!!'
          "
          />
       </xsl:when>

       <xsl:when test="$vlhsName eq 'PAIR'">
       
         <xsl:variable name="vPairValue" 
          select="$pComponents[$vLen1 - 3]/computedValue/node()"/>
         
         <xsl:variable name="vFst" as="xs:string"
          select="$pComponents[$vLen1 - 1]"/>
         
         <xsl:variable name="vNameTail" as="xs:string"
          select="substring($vFst,2)"/>
             
         <xsl:variable name="vElName2" as="xs:string"
          select="translate($vNameTail, 
                            replace($vNameTail, 
                                    '[\c-[:]]+',
                                    ''
                                    ), 
                            '_________________________________________________'
                            )
                       "
               />
         <xsl:variable name="vFstNameChar" as="xs:string"
          select="substring($vFst,1,1)"/>

         <xsl:variable name="vElName" as="xs:string"
          select="concat(
                         (if(not(matches($vFstNameChar, '[\c-[:]]')))
                            then '_'
                            else
                              if(matches($vFstNameChar, '[\i-[:]]'))
                                then $vFstNameChar
                                else concat('_',$vFstNameChar)
                          )
                         ,
                         $vElName2
                         ) 
                 "
          />
         
         <xsl:choose>
           <xsl:when test="not($vPairValue/self::jsonauxARRAY)">
	           <xsl:element name="{$vElName}">
			           <xsl:sequence select=
			              "$pComponents[$vLen1 - 3]/computedValue/node()"/>
		         </xsl:element>
           </xsl:when>
           <xsl:otherwise>
             <xsl:for-each select=
             "$pComponents[$vLen1 - 3]/computedValue/jsonauxARRAY/jsonauxElem">
               <xsl:element name="{$vElName}">
                 <xsl:sequence select="node()"/>
               </xsl:element>
             </xsl:for-each>
           </xsl:otherwise>
         </xsl:choose>
       </xsl:when>

       <xsl:when test="$vlhsName eq 'ARRAY'">
         <xsl:sequence select=
          "if($vruleLength eq 2)
             then ()
             else
               if($vruleLength eq 3)
                  then
                    $pComponents[2]/computedValue/node()
                   else 'ELEMENTS rule Error!!!'
          "
          />
       </xsl:when>
       <xsl:when test="$vlhsName eq 'ELEMENTS'">
         <xsl:choose>
           <xsl:when test="$vruleLength eq 1">
             <jsonauxElem>
               <xsl:sequence select=
               "$pComponents[1]/computedValue/node()"/>
             </jsonauxElem>
           </xsl:when>
           <xsl:when test="$vruleLength eq 3">
             <xsl:sequence select=
               "$pComponents[3]/computedValue/jsonauxElem"/>
             
             <jsonauxElem>
               <xsl:sequence select=
               "$pComponents[1]/computedValue/node()"/>
             </jsonauxElem>
           </xsl:when>
         </xsl:choose>
       </xsl:when>

       <xsl:when test="$vlhsName eq 'VALUE'">
         <xsl:choose>
	         <xsl:when test="not($pRule/right = ('OBJECT','ARRAY'))">
	           <xsl:sequence select="$pComponents[1]/node()"/>
	         </xsl:when>
	         <xsl:when test="$pRule/right eq 'OBJECT'">
	           <xsl:sequence select="$pComponents[1]/computedValue/node()"/>
	         </xsl:when>
	         <xsl:when test="$pRule/right eq 'ARRAY'">
	           <jsonauxARRAY>
	             <xsl:sequence select=
	               "$pComponents[1]/computedValue/node()"/>
	           </jsonauxARRAY>
	         </xsl:when>
         </xsl:choose>
       </xsl:when>
     </xsl:choose>
   </xsl:if>
   </xsl:variable>

<xsl:if test="$vJSDebug">
   <xsl:message>
     Computed Result:
       '<xsl:sequence select="$vResult/node()"/>'
   </xsl:message>
</xsl:if>   
   <xsl:sequence select="$vResult/node()"/>
 </xsl:function>

 <xsl:variable name="vRegExJSON" as="xs:string">
   ([\s]*)          <!-- Skip leading whitespace -->
                    <!-- Followed by: -->
   (  
     ("[^"\\]*( ( ((\\[\\/bfnrt"]) | (\\u([0-9A-Fa-f]{4})) )[^"\\]*)*")) <!-- A string -->
    |                           <!-- Or a Number -->
      ((([-]?[0-9]+)?\.)?[-]?[0-9]+([eE][-+]?[0-9]+)? )
    |
      ((true)|(false)|(null)  <!-- Or true 
                                   or false or null -->
         )
                    
       | 
         ([{},:\[\]])            <!-- Or one of these:
                                   '{', '}', ':',
                                   '[', ']' -->
                    
      )            <!-- These are all our token types -->
      (.*)$        <!-- Only get the first token,
                        Skip the rest for the future -->
 </xsl:variable>
 
 <xsl:function name="f:lexer-JSON" as="element()">
  <f:lexer-JSON/>
 </xsl:function>
 
 <xsl:variable name="vescRepl" 
 as="xs:string">(\\("|\\|/))|(\\(b|f))</xsl:variable>
 
 <xsl:template match="f:lexer-JSON" as="item()*"
    mode="f:FXSL">
   <xsl:param name="arg1" as="xs:string"/>
   <xsl:param name="arg2" as="xs:integer"/>
   
   <xsl:sequence select="f:lexer-JSON($arg1, $arg2)"/>
 </xsl:template>
 
 <xsl:function name="f:lexer-JSON" as="item()*">
   <xsl:param name="pstrInput" as="xs:string"/>
   <xsl:param name="pinpIndex" as="xs:integer"/>
   
   <xsl:variable name="vstrInput" select=
     "substring($pstrInput, $pinpIndex)"/>
   
     <xsl:choose>
       <xsl:when test="not($vstrInput)">
         <xsl:sequence select=
          "$pinpIndex,'$end'"/>
       </xsl:when>
       <xsl:otherwise>

		     <xsl:analyze-string select="$vstrInput"  flags="mx"
		       regex="{$vRegExJSON}">

		      <xsl:matching-substring>
            <xsl:variable name="vToken" 
             select="regex-group(2)"/>
             
            <xsl:variable name="vToken2" select=
            "if(regex-group(12))
              then substring($vToken, 1, string-length($vToken) - 1)
              else if(regex-group(7))
                     then
                       replace(
		                        replace( 
		                            replace(replace($vToken,$vescRepl, '$2$3'),
		                                    '\\r','&#13;'
		                                   ),
		                            '\\n', '&#10;'       
		                                ),
		                        '\\t', '&#9;'
                                ) 
(:
              else if(regex-group(8))
              then
                 replace($vToken,
                         '\\u(([0-9A-Fa-f]){4})',
                          codepoints-to-string
                              (xs:integer(substring(regex-group(8),3)))
                         )
:)                         
              else $vToken
            "/>

            <xsl:variable name="vregexEscUni" 
             as="xs:string">\\u(([0-9A-Fa-f]){4})</xsl:variable>
             
            <xsl:variable name="vescUnicode" as="xs:string?"
              select="regex-group(8)"/>
            
            <xsl:variable name="vToken3" as="xs:string*">
              <xsl:if test="$vescUnicode">
	              <xsl:analyze-string select="$vToken2"
	                regex="{$vregexEscUni}">
	                
	                <xsl:matching-substring>
	                  <xsl:sequence select=
	                    "codepoints-to-string
	                            (xs:integer(substring(.,3)))
	                  "/>
	                </xsl:matching-substring>
	                
	                <xsl:non-matching-substring>
	                  <xsl:sequence select="."/>
	                </xsl:non-matching-substring>
	              </xsl:analyze-string>
              </xsl:if>
            </xsl:variable>
            
            <xsl:variable name="vToken4" as="xs:string"
              select="if($vToken3[1])
                        then string-join($vToken3, '')
                        else $vToken2
                      "
             />
             
            <xsl:sequence select=
            "$pinpIndex
            +
             string-length(substring-before($vstrInput,$vToken))
            +
             string-length($vToken)
             
             - 1 * (if(regex-group(11)) then 1 else 0)
               ,
               
             if(regex-group(3))
               then 'STRING'
               else if(regex-group(10))
                 then 'NUMBER'
                 else if(regex-group(14)) 
                   then upper-case($vToken2)
                  else if(regex-group(18))
                    then $vToken2
                   else 'RegEx-Error',
                   
             if(regex-group(3))
                then f:unQuote($vToken4)
                else $vToken4		            
            "
            />
		      </xsl:matching-substring>
		      
		      
		      <xsl:non-matching-substring>
		        <xsl:choose>
	            <xsl:when test="normalize-space()">
		            <xsl:sequence select=
		             "$pinpIndex, 'error'
		             "/>
	             </xsl:when>
	             <xsl:otherwise>
		            <xsl:sequence select=
		             "$pinpIndex, '$end'
		             "/>
	             </xsl:otherwise>
		        </xsl:choose>
		      </xsl:non-matching-substring>
		     </xsl:analyze-string>
	     </xsl:otherwise>
     </xsl:choose>    
 </xsl:function>
 
 <xsl:function name="f:unQuote" as="xs:string?">
   <xsl:param name="pStr" as="xs:string?"/>
   
   <xsl:variable name="vQ" as="xs:string">"</xsl:variable>
    
   <xsl:choose>
	   <xsl:when test="starts-with($pStr,$vQ)">
		   <xsl:variable name="vTail" as="xs:string"
		     select="substring($pStr,2)"/>
		   
		   <xsl:sequence select=
		    "substring($vTail,1,string-length($vTail)-1)"/>
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:sequence select="$pStr"/>
	    </xsl:otherwise>
    </xsl:choose>
 </xsl:function>

</xsl:stylesheet>