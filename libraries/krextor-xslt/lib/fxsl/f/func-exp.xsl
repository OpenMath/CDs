<!--
===========================================================================
 Stylesheet: exp.xsl                                                       
    Version: 1.0 (2002-03-16)                                              
     Author: Dimitre Novatchev                                             
     Notice: Copyright (c)2002 D.Novatchev  ALL RIGHTS RESERVED.           
             No limitation on use - except this code may not be published, 
             in whole or in part, without prior written consent of the     
             copyright owner.                                              
===========================================================================-->
<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 xmlns:int="http://fxsl.sf.net/exp/int"
 xmlns:fCondInInterval="f:fCondInInterval"
 xmlns:fScaleByE="f:fScaleByE"
 xmlns:x="f:x-exp.xsl"
 exclude-result-prefixes="f x xs int fCondInInterval fScaleByE"
>

<!--
  ==========================================================================
    Imported files:                                                         
  ==========================================================================-->
   <xsl:import href="func-iter.xsl"/>
   <xsl:import href="func-curry.xsl"/>
   <xsl:import href="func-Operators.xsl"/>
   
<!--
 f:exp() -      convenience function,                                            
                returns a reference to f:exp()                                  
                when called with no arguments                                
-->  
  <xsl:function name="f:exp" as="element()">
    <f:exp/>
  </xsl:function>

  <xsl:template match="f:exp" mode="f:FXSL">
     <xsl:param name="arg1" as="xs:double"/>
     <xsl:param name="arg2" as="xs:double" select=".00000001E1"/>
    
    <xsl:sequence select="f:exp($arg1, $arg2)"/>  
  </xsl:template>

<!--
      Function: exp                                                          
      Purpose : Return the value of e^X                                      
    Parameters:                                                              
    $pX       - the real value X, to be used as the "power" in e^X           
  ========================================================================== -->
   <xsl:function name="f:exp" as="xs:double">
     <xsl:param name="pX" as="xs:double"/>
     <xsl:variable name="pEps" select=".00000001E1" as="xs:double"/>
     <xsl:value-of select="f:exp($pX, $pEps)"/>
   </xsl:function>
   
<!--
      Function: exp                                                          
      Purpose : Return the value of e^X                                      
    Parameters:                                                              
    $pX       - the real value X, to be used as the "power" in e^X           
    $pEps     - [optional] accuracy required                                 
                increase the number of decimal places for greater accuracy   
                but at the expense of performance.                           
  ========================================================================== -->
   <xsl:function name="f:exp" as="xs:double">
     <xsl:param name="pX" as="xs:double"/>
     <xsl:param name="pEps" as="xs:double"/>
     
<!--
     We represent $pX as m * 2^N, where 0 <= m < 1
-->     
     
     <xsl:variable name="vIntPart" as="xs:integer" 
       select="xs:integer(floor($pX))"/>
     
     <xsl:variable name="vFractX" select="$pX - $vIntPart"/>
     
     <xsl:variable name="vResultM" 
          select="int:expIter($vFractX, 1 + $vFractX, $vFractX, 1, $pEps)"/>
	     
     <xsl:sequence select=
      "$vResultM * f:ipow($vE, $vIntPart)"/>
	     
   </xsl:function>

   <xsl:function name="int:expIter" as="xs:double">
       <xsl:param name="pX" as="xs:double"/>
       <xsl:param name="pRslt" as="xs:double"/>
       <xsl:param name="pElem" as="xs:double"/>
       <xsl:param name="pN" as="xs:integer"/>
       <xsl:param name="pEps" as="xs:double"/>
       
       <xsl:variable name="vnextN" select="$pN+1"  as="xs:integer"/>
       
       <xsl:variable name="vnewElem"  as="xs:double"
                select="$pElem*$pX div $vnextN"/>
                
       <xsl:variable name="vnewResult"   as="xs:double"
         select="$pRslt + $vnewElem"/>
       
       <xsl:variable name="vdiffResult"  as="xs:double"
        select="$vnewResult - $pRslt"/>
       
       <xsl:value-of 
            select="if($vdiffResult > $pEps or $vdiffResult &lt; -$pEps)
                     then 
                      int:expIter($pX, $vnewResult, $vnewElem, $vnextN, $pEps)
                     else 
                      $vnewResult"/>
   </xsl:function>

<!-- reference to ln()-->  
  <f:ln/>

<!--
 f:ln() -       convenience function,                                            
                returns a reference to f:ln()                                  
                when called with no arguments                                
-->  
  <xsl:function name="f:ln" as="node()">
    <xsl:sequence select="document('')/*/f:ln[1]"/>
  </xsl:function>

  <xsl:template match="f:ln" mode="f:FXSL">
     <xsl:param name="arg1" as="xs:double"/>
     <xsl:param name="arg2" as="xs:double" select=".00000001E1"/>
    
    <xsl:sequence select="f:ln($arg1, $arg2)"/>  
  </xsl:template>

<!--
      Function: ln                                                           
      Purpose : Return the value of ln(X)                                    
    Parameters:                                                              
    $pX       - the real value X, to be used in calculating ln(X)            
  ========================================================================== -->
   <xsl:function name="f:ln" as="xs:double">
     <xsl:param name="pX" as="xs:double"/>
     <xsl:variable name="pEps" select=".00000001E0"  as="xs:double"/>
     
     <xsl:value-of select="f:ln($pX, $pEps)"/>
   </xsl:function>
   
<!--
      Function: ln                                                           
      Purpose : Return the value of ln(X)                                    
    Parameters:                                                              
    $pX       - the real value X, to be used in calculating ln(X)            
    $pEps     - [optional] accuracy required                                 
                increase the number of decimal places for greater accuracy   
                but at the expense of performance.                           
  ========================================================================== -->
   <xsl:function name="f:ln" as="xs:double">
     <xsl:param name="pX" as="xs:double"/>
     <xsl:param name="pEps" as="xs:double"/>
     
     <xsl:if test="not($pX > 0)">
       <xsl:message terminate="yes">
         <xsl:value-of
         select="concat('[Error]ln: non-positive argument passed:',
                        string($pX))"/>
       </xsl:message>
     </xsl:if>
     
     <xsl:variable name="vrtfReduceArg">
       <cnt>0</cnt>
       <x><xsl:value-of select="$pX"/></x>
     </xsl:variable>
     
     <xsl:variable name="vCondInInterval"
                   select="document('')/*/fCondInInterval:*[1]"/>
     <xsl:variable name="vScaleByE"
                   select="document('')/*/fScaleByE:*[1]"/>

     <xsl:variable name="vrtfScaledArg" 
      select="f:iterUntil($vCondInInterval, $vScaleByE, $vrtfReduceArg)"/>
      
     <xsl:variable name="vIntTerm"
     select="$vrtfScaledArg/cnt"/>

     <xsl:variable name="vFracTerm"
     select="$vrtfScaledArg/x"/>

     <xsl:variable name="vPartResult" 
     select="int:lnIter($vFracTerm - 1, $vFracTerm - 1, 
                        $vFracTerm - 1, 1, $pEps)"/>
     
     <xsl:value-of select="$vIntTerm + $vPartResult"/>
   </xsl:function>
   
<!-- reference to log()-->  
  <f:log/>

<!--
 f:log() -      convenience function,                                            
                returns a reference to f:log()                                  
                when called with no arguments                                
-->  
  <xsl:function name="f:log" as="node()">
    <xsl:sequence select="document('')/*/f:log[1]"/>
  </xsl:function>

  <xsl:template match="f:log" mode="f:FXSL">
     <xsl:param name="arg1" as="xs:double"/>
     <xsl:param name="arg2" as="xs:double"/>
     <xsl:variable name="arg3" as="xs:double" select=".00000001E1"/>
    
    <xsl:sequence select="f:log($arg1, $arg2, $arg3)"/>  
  </xsl:template>

<!--
      Function: log                                                          
      Purpose : Return the value of log(base, X)                             
                (the logarithm of X using base base)                         
    Parameters:                                                              
    $pX       - the real value X, to be used in calculating log(base, X)     
    $pBase    - [optional] the value for the base of the logarithm (10)      
    $pEps     - [optional] accuracy required                                 
                increase the number of decimal places for greater accuracy   
                but at the expense of performance.                           
  ========================================================================== -->
   <xsl:function name="f:log" as="xs:double">
     <xsl:param name="pX" as="xs:double"/>
     <xsl:param name="pBase" as="xs:double"/>
     <xsl:param name="pEps"  as="xs:double"/>
     
     <xsl:if test="not($pBase > 0 and $pBase != 1)">
       <xsl:message terminate="yes">
         <xsl:value-of select="concat('[Error]log: Invalid log base: ',
                                      string($pBase)
                                      )"/>
       </xsl:message>
     </xsl:if>
     
     <xsl:variable name="vLogBase" select="f:ln($pBase)"/>
     
     <xsl:variable name="vLnX" select="f:ln($pX)"/>
     
     <xsl:value-of select="$vLnX div $vLogBase"/>
   </xsl:function>

<!--
      Function: log                                                          
      Purpose : Return the value of log(base, X)                             
                (the logarithm of X using base base)                         
    Parameters:                                                              
    $pX       - the real value X, to be used in calculating log(base, X)     
    $pBase    - the value for the base of the logarithm (10)                 
  ========================================================================== -->
   <xsl:function name="f:log" as="xs:double">
     <xsl:param name="pX" as="xs:double"/>
     <xsl:param name="pBase" as="xs:double"/>
     <xsl:variable name="pEps" select=".00000001"/>
     
     <xsl:value-of select="f:log($pX, $pBase, $pEps)"/>
   </xsl:function>

   <xsl:function name="f:log" as="node()">
	   <xsl:param name="pX" as="xs:double"/>
    
       <xsl:sequence select="f:curry(f:log(), 2, $pX)"/>
   </xsl:function>

<!-- reference to log10()-->  
  <f:log10/>

<!--
 f:log10() -    convenience function,                                            
                returns a reference to f:log10()                                  
                when called with no arguments                                
-->  
  <xsl:function name="f:log10" as="node()">
    <xsl:sequence select="document('')/*/f:log10[1]"/>
  </xsl:function>

  <xsl:template match="f:log10" mode="f:FXSL">
     <xsl:param name="arg1" as="xs:double"/>
     <xsl:param name="arg2" as="xs:double" select=".00000001E1"/>
    
    <xsl:sequence select="f:log10($arg1, $arg2)"/>  
  </xsl:template>


<!--
      Function: log10                                                        
      Purpose : Return the value of the decimal logarithm of X               
                (the logarithm of X using base 10)                           
    Parameters:                                                              
    $pX       - the real value X, to be used in calculating log10(X)         
  ========================================================================== -->
   <xsl:function name="f:log10" as="xs:double">
     <xsl:param name="pX" as="xs:double"/>
     <xsl:variable name="pEps" select=".00000001"/>
	   
	   <xsl:value-of select="f:log($pX, 10E0, $pEps)"/>
	 </xsl:function>

<!--
      Function: log10                                                        
      Purpose : Return the value of the decimal logarithm of X               
                (the logarithm of X using base 10)                           
    Parameters:                                                              
    $pX       - the real value X, to be used in calculating log10(X)         
    $pEps     - [optional] accuracy required                                 
                increase the number of decimal places for greater accuracy   
                but at the expense of performance.                           
  ========================================================================== -->
   <xsl:function name="f:log10" as="xs:double">
     <xsl:param name="pX" as="xs:double"/>
     <xsl:param name="pEps" as="xs:double"/>
	   
	   <xsl:value-of select="f:log($pX, 10E0, $pEps)"/>
	 </xsl:function>

<!-- reference to log2()-->  
  <f:log2/>

<!--
 f:log2() -     convenience function,                                            
                returns a reference to f:log2()                                  
                when called with no arguments                                
-->  
  <xsl:function name="f:log2" as="node()">
    <xsl:sequence select="document('')/*/f:log2[1]"/>
  </xsl:function>

  <xsl:template match="f:log2" mode="f:FXSL">
     <xsl:param name="arg1" as="xs:double"/>
     <xsl:param name="arg2" as="xs:double" select=".00000001E1"/>
    
    <xsl:sequence select="f:log2($arg1, $arg2)"/>  
  </xsl:template>

<!--
      Function: log2                                                         
      Purpose : Return the value of the binary logarithm of X                
                (the logarithm of X using base 2)                            
    Parameters:                                                              
    $pX       - the real value X, to be used in calculating log2(X)          
  ========================================================================== -->
   <xsl:function name="f:log2" as="xs:double">
     <xsl:param name="pX" as="xs:double"/>
     <xsl:variable name="pEps" select=".00000001"/>
	   
	   <xsl:value-of select="f:log($pX, 2E0, $pEps)"/>
	 </xsl:function>
	 
<!--
      Function: log2                                                         
      Purpose : Return the value of the binary logarithm of X                
                (the logarithm of X using base 2)                            
    Parameters:                                                              
    $pX       - the real value X, to be used in calculating log2(X)          
    $pEps     - [optional] accuracy required                                 
                increase the number of decimal places for greater accuracy   
                but at the expense of performance.                           
  ========================================================================== -->
   <xsl:function name="f:log2" as="xs:double">
     <xsl:param name="pX" as="xs:double"/>
     <xsl:param name="pEps" as="xs:double"/>
	   
	   <xsl:value-of select="f:log($pX, 2E0, $pEps)"/>
	 </xsl:function>
	 
<!--
 f:ipow() -     convenience function,                                        
                returns a reference to f:ipow()                              
                when called with no arguments                                
-->  
  <xsl:function name="f:ipow" as="element()">
    <f:pow/>
  </xsl:function>

  <xsl:template match="f:ipow" mode="f:FXSL">
     <xsl:param name="arg1" as="xs:double"/>
     <xsl:param name="arg2" as="xs:integer"/>
    
    <xsl:sequence select="f:ipow($arg1,$arg2)"/>  
  </xsl:template>

<!--
      Function: ipow                                                         
      Purpose : Return the value of base^N (base to the power of N)          
    Parameters:                                                              
    $pBase    - the value for the base                                       
    $pPower   - the *integer* value N, to be used in calculating base^N      
  ========================================================================== -->
	 <xsl:function name="f:ipow" as="xs:double">
	   <xsl:param name="pBase" as="xs:double"/>
	   <xsl:param name="pPower" as="xs:integer"/>
	   
	   <xsl:variable name="vBase" as="xs:double"
	     select="if($pPower ge 0)
	               then $pBase
	               else 1 div $pBase
	     "/>
	     
	     <xsl:sequence select=
	       "f:ippow( $vBase, 
	                 ($pPower[. ge 0],
	                  (-$pPower)[. gt 0]
	                   )[1]
	                 )
	       " 
        />
   </xsl:function>
   
   <xsl:function name="f:ippow" as="xs:double">
     <xsl:param name="pBase" as="xs:double"/>
     <xsl:param name="pNPower" as="xs:integer"/> <!-- Positive -->
     
     <xsl:sequence select=
      "if($pNPower eq 0)
         then 1
         else if($pNPower eq 1)
                then $pBase
                else 
                  for $vSqrt in f:ippow($pBase, $pNPower idiv 2)
                    return
                      if($pNPower mod 2 eq 0)
                         then $vSqrt * $vSqrt
                         else $pBase * $vSqrt * $vSqrt
      "
      />
   </xsl:function>
   
<!--
 f:pow() -      convenience function,                                            
                returns a reference to f:pow()                                  
                when called with no arguments                                
-->  
  <xsl:function name="f:pow" as="element()">
    <f:pow/>
  </xsl:function>

  <xsl:template match="f:pow" mode="f:FXSL">
     <xsl:param name="arg1" as="xs:double"/>
     <xsl:param name="arg2" as="xs:double"/>
    
    <xsl:sequence select="f:pow($arg1, $arg2)"/>  
  </xsl:template>

<!--
      Function: pow                                                          
      Purpose : Return the value of base^X (base to the power of X)          
    Parameters:                                                              
    $pBase    - the value for the base                                       
    $pPower   - the real value X, to be used in calculating base^X           
    $pEps     - [optional] accuracy required                                 
                increase the number of decimal places for greater accuracy   
                but at the expense of performance.                           
  ========================================================================== -->
	 <xsl:function name="f:pow" as="xs:double">
	   <xsl:param name="pBase" as="xs:double"/>
	   <xsl:param name="pPower" as="xs:double"/>
     <xsl:param name="pEps" as="xs:double"/>
     
     <xsl:if test="not($pBase > 0)">
       <xsl:message terminate="yes">
         <xsl:value-of select="concat('[Error]pow: Non-positive pow base: ',
                                      string($pBase)
                                      )"/>
       </xsl:message>
     </xsl:if>
     
     <xsl:variable name="vLogBase" select="f:ln($pBase)" as="xs:double"/>
     
     <xsl:value-of select="f:exp($vLogBase * $pPower, $pEps)"/>
	 </xsl:function>
 <!--
      Function: pow                                                          
      Purpose : Return the value of base^X (base to the power of X)          
    Parameters:                                                              
    $pBase    - the value for the base                                       
    $pPower   - the real value X, to be used in calculating base^X           
  ========================================================================== -->
	 <xsl:function name="f:pow" as="xs:double">
	   <xsl:param name="pBase" as="xs:double"/>
	   <xsl:param name="pPower" as="xs:double"/>
     <xsl:variable name="pEps" select=".00000001E0" as="xs:double"/>
     
     <xsl:sequence select=
      "if($pPower eq floor($pPower))
         then f:ipow($pBase, xs:integer($pPower))
         else 
            f:pow($pBase, $pPower, $pEps)
      "
       />
     
<!--     <xsl:value-of select="f:pow($pBase, $pPower, $pEps)"/> -->
	 </xsl:function>
  
   <xsl:function name="f:pow" as="node()">
	   <xsl:param name="pBase" as="xs:double"/>
    
       <xsl:sequence select="f:curry(f:pow(), 2, $pBase)"/>
   </xsl:function>
   
  <!-- ************************************************************* -->
  <!-- ********************* INTERNAL USE ONLY ********************* -->
  <!-- ************************************************************* -->
  <!-- defined constants -->
   <xsl:variable name="vE" select="2.71828182845904"/>
   <xsl:variable name="x:st" select="document('')/*"/>

   <fCondInInterval:fCondInInterval/>
   <fScaleByE:fScaleByE/>

   <xsl:function name="int:lnIter">
       <xsl:param name="pX" as="xs:double"/>
       <xsl:param name="pRslt" as="xs:double"/>
       <xsl:param name="pElem" as="xs:double"/>
       <xsl:param name="pN" as="xs:integer"/>
       <xsl:param name="pEps" as="xs:double"/>

       <xsl:variable name="vnextN"  as="xs:integer"
                     select="$pN+1"/>

       <xsl:variable name="vnewElem"  as="xs:double"
                     select="-$pElem*$pX"/>

       <xsl:variable name="vnewResult" as="xs:double"
                     select="$pRslt + $vnewElem div $vnextN"/>

       <xsl:variable name="vdiffResult" as="xs:double"
                     select="$vnewResult - $pRslt"/>
                     
       <xsl:choose>
         <xsl:when test="$vdiffResult > $pEps or $vdiffResult &lt; -$pEps">
			     <xsl:value-of 
            select="int:lnIter($pX, $vnewResult, $vnewElem, $vnextN, $pEps)"/>
         </xsl:when>
         <xsl:otherwise>
           <xsl:value-of select="$vnewResult"/>
         </xsl:otherwise>
       </xsl:choose>
   </xsl:function>

   <xsl:template match="fCondInInterval:*" mode="f:FXSL">
     <xsl:param name="arg1" select="/.."/>
     
     <xsl:variable name="vX" select="number($arg1/x)"/>
     
     <xsl:choose>
       <xsl:when test="$vX >= 0.5 and $vX &lt;= 1.5">1</xsl:when>
       <xsl:otherwise>0</xsl:otherwise>
     </xsl:choose>
   </xsl:template>
   
   <xsl:template match="fScaleByE:*" mode="f:FXSL">
     <xsl:param name="arg1" select="/.."/>

     <xsl:variable name="vCnt" select="number($arg1/cnt)"/>
     <xsl:variable name="vX" select="number($arg1/x)"/>
     
     <xsl:choose>
       <xsl:when test="$vX > 1.5">
         <res>
           <cnt><xsl:value-of select="$vCnt + 1"/></cnt>
           <x><xsl:value-of select="$vX div $vE"/></x>
         </res>
       </xsl:when>
       <xsl:otherwise>
       <res>
         <cnt><xsl:value-of select="$vCnt - 1"/></cnt>
         <x><xsl:value-of select="$vX * $vE"/></x>
       </res>
       </xsl:otherwise>
     </xsl:choose>
   </xsl:template>
   
</xsl:stylesheet>