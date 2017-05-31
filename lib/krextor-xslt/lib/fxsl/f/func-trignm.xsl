<!--
===========================================================================
 Stylesheet: func-trignm.xsl                                               
    Version: 3.0 (2005-02-25)                                              
     Author: Dimitre Novatchev                                             
     Notice: Copyright (c)2002 D.Novatchev  ALL RIGHTS RESERVED.           
             No limitation on use - except this code may not be published, 
             in whole or in part, without prior written consent of the     
             copyright owner.                                              
                                                                           
     Acknowledgements:                                                     
             The documentation to this file, the general documenting style 
             and some efficiency optimisation are work of Martin Rowlinson 
===========================================================================-->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:f="http://fxsl.sf.net/"
  xmlns:int="http://fxsl.sf.net/trig/internal"
  xmlns:trigSin="f:trigSin" xmlns:trigCos="f:trigCos"
  xmlns:trigTan="f:trigTan" xmlns:trigCot="f:trigCot"
  xmlns:trigSec="f:trigSec" xmlns:trigCsc="f:trigCsc"
  xmlns:x="f:trig_lib.xsl"
  exclude-result-prefixes="f xs int trigSin trigCos trigTan trigCot trigSec trigCsc">
  
<!--
  ==========================================================================
    Module Interface:                                                       
  ==========================================================================-->

  <xsl:variable name="f:sin" as="element()">
    <f:sin/>
  </xsl:variable>
  
  <xsl:function name="f:sin" as="node()">
    <xsl:sequence select="$f:sin"/>
  </xsl:function>
  
  <xsl:template match="f:sin" mode="f:FXSL">
    <xsl:param name="arg1" as="xs:double"/>
    <xsl:sequence select="f:sin($arg1)"/>
  </xsl:template>
  
<!--
    Function: sin                                                            
     Purpose: Return the sine of X                                           
  Parameters:-                                                               
    $pX    - the angle (specified in radians)                                
  ========================================================================== -->
  <xsl:function name="f:sin" as="xs:double">
    <xsl:param name="pX" as="xs:double"/>
    
    <xsl:variable name="pEps" select=".00000001E0" as="xs:double"/>
    <xsl:variable name="pUnit" select="'rad'"/>
    
    <xsl:value-of select="f:sin($pX, $pEps, $pUnit)"/>
  </xsl:function>

<!--
    Function: sin                                                            
     Purpose: Return the sine of X                                           
  Parameters:-                                                               
    $pX    - the angle (specified in radians)                                
    $pEps  - [optional] accuracy required                                    
             increase the number of decimal places for greater accuracy but  
             at the expense of performance.                                  
  ========================================================================== -->
  <xsl:function name="f:sin" as="xs:double">
    <xsl:param name="pX" as="xs:double"/>
    <xsl:param name="pEps" as="xs:double"/>
    <xsl:variable name="pUnit" select="'rad'"/>
    
    <xsl:value-of select="f:sin($pX, $pEps, $pUnit)"/>
  </xsl:function>

<!--
    Function: sin                                                            
     Purpose: Return the sine of X                                           
  Parameters:-                                                               
    $pX    - the angle (specified in radians or degrees - see $pUnit)        
    $pEps  - [optional] accuracy required                                    
             increase the number of decimal places for greater accuracy but  
             at the expense of performance.                                  
    $pUnit - the unit of the given angle £pX                                 
             specify 'deg' for degrees or                                    
                     'rad' for radians (default)                             
  ========================================================================== -->
  <xsl:function name="f:sin" as="xs:double">
    <xsl:param name="pX" as="xs:double"/>
    <xsl:param name="pEps" as="xs:double"/>
    <xsl:param name="pUnit" as="xs:string"/>
    
    <xsl:value-of select="int:_trigWrapper($f:trigsin, $pX, $pEps, $pUnit)"/>
  </xsl:function>

  <xsl:variable name="f:cos" as="element()">
    <f:cos/>
  </xsl:variable>
  
  <xsl:function name="f:cos" as="node()">
    <xsl:sequence select="$f:cos"/>
  </xsl:function>
  
  <xsl:template match="f:cos" mode="f:FXSL">
    <xsl:param name="arg1" as="xs:double"/>
    <xsl:sequence select="f:cos($arg1)"/>
  </xsl:template>
  
  <!--
  ==========================================================================
    Function: cos                                                           
     Purpose: Return the cosine of X specified in radians                   
  Parameters:-                                                              
    $pX    - the angle (specified in radians)                               
  ==========================================================================-->
  <xsl:function name="f:cos" as="xs:double">
    <xsl:param name="pX" as="xs:double"/>
    <xsl:variable name="pUnit" select="'rad'"/>
    <xsl:variable name="pEps" select=".00000001E0" as="xs:double"/>
    
    <xsl:value-of select="f:cos($pX,$pEps, $pUnit)"/>
  </xsl:function>

  <!--
  ==========================================================================
    Function: cos                                                           
     Purpose: Return the cosine of X specified in radians                   
  Parameters:-                                                              
    $pX    - the angle (specified in radians)                               
    $pEps  - [optional] accuracy required                                   
             increase the number of decimal places for greater accuracy but 
             at the expense of performance.                                 
  ==========================================================================-->
  <xsl:function name="f:cos" as="xs:double">
    <xsl:param name="pX" as="xs:double"/>
    <xsl:param name="pEps" as="xs:double"/>
    <xsl:variable name="pUnit" select="'rad'"/>
    
    <xsl:value-of select="f:cos($pX,$pEps, $pUnit)"/>
  </xsl:function>

  <!--
  ==========================================================================
    Function: cos                                                           
     Purpose: Return the cosine of X specified in radians or degrees        
  Parameters:-                                                              
    $pX    - the angle (specified in radians or degrees - see $pUnit)       
    $pEps  - [optional] accuracy required                                   
             increase the number of decimal places for greater accuracy but 
             at the expense of performance.                                 
    $pUnit - the unit of the given angle £pX                                
             specify 'deg' for degrees or                                   
                     'rad' for radians (default)                            
  ==========================================================================-->
  <xsl:function name="f:cos" as="xs:double">
    <xsl:param name="pX" as="xs:double"/>
    <xsl:param name="pEps" as="xs:double"/>
    <xsl:param name="pUnit" as="xs:string"/>
    
    <xsl:value-of select="int:_trigWrapper($f:trigcos, $pX, $pEps, $pUnit)"/>
  </xsl:function>

  <xsl:variable name="f:tan" as="element()">
    <f:tan/>
  </xsl:variable>
  
  <xsl:function name="f:tan" as="node()">
    <xsl:sequence select="$f:tan"/>
  </xsl:function>
  
  <xsl:template match="f:tan" mode="f:FXSL">
    <xsl:param name="arg1" as="xs:double"/>
    <xsl:sequence select="f:tan($arg1)"/>
  </xsl:template>
  
<!--
  ==========================================================================
    Function: tan                                                           
     Purpose: Return the tangent of X specified in radians                  
  Parameters:-                                                              
    $pX    - the angle (specified in radians)                               
  ==========================================================================-->
  <xsl:function name="f:tan" as="xs:double">
    <xsl:param name="pX" as="xs:double"/>
    <xsl:variable name="pUnit" select="'rad'"/>
    <xsl:variable name="pEps" select=".00000001E0" as="xs:double"/>
    
    <xsl:value-of select="f:tan($pX, $pEps, $pUnit)"/>
  </xsl:function>

<!--
  ==========================================================================
    Function: tan                                                           
     Purpose: Return the tangent of X specified in radians                  
  Parameters:-                                                              
    $pX    - the angle (specified in radians)                               
    $pEps  - [optional] accuracy required                                   
             increase the number of decimal places for greater accuracy but 
             at the expense of performance.                                 
  ==========================================================================-->
  <xsl:function name="f:tan" as="xs:double">
    <xsl:param name="pX" as="xs:double"/>
    <xsl:param name="pEps" as="xs:double"/>
    <xsl:variable name="pUnit" select="'rad'"/>
    
    <xsl:value-of select="f:tan($pX, $pEps, $pUnit)"/>
  </xsl:function>

<!--
  ==========================================================================
    Function: tan                                                           
     Purpose: Return the tangent of X specified in radians or degrees       
  Parameters:-                                                              
    $pX    - the angle (specified in radians or degrees)                    
    $pEps  - [optional] accuracy required                                   
             increase the number of decimal places for greater accuracy but 
             at the expense of performance.                                 
    $pUnit - the unit of the given angle £pX                                
             specify 'deg' for degrees or                                   
                     'rad' for radians (default)                            
  ==========================================================================-->
  <xsl:function name="f:tan" as="xs:double">
    <xsl:param name="pX" as="xs:double"/>
    <xsl:param name="pEps" as="xs:double"/>
    <xsl:param name="pUnit" as="xs:string"/>
    
    <xsl:value-of select="int:_trigWrapper($f:trigtan, $pX, $pEps, $pUnit)"/>
  </xsl:function>

  <xsl:variable name="f:cot" as="element()">
    <f:cot/>
  </xsl:variable>
  
  <xsl:function name="f:cot" as="node()">
    <xsl:sequence select="$f:cot"/>
  </xsl:function>
  
  <xsl:template match="f:cot" mode="f:FXSL">
    <xsl:param name="arg1" as="xs:double"/>
    <xsl:sequence select="f:cot($arg1)"/>
  </xsl:template>
  
  <!--
  ==========================================================================
    Function: cot                                                           
     Purpose: Return the cotangent of X specified in radians                
  Parameters:-                                                              
    $pX    - the angle (specified in radians)                               
  ==========================================================================-->
  <xsl:function name="f:cot" as="xs:double">
    <xsl:param name="pX" as="xs:double"/>
    <xsl:variable name="pUnit" select="'rad'"/>
    <xsl:variable name="pEps" select=".00000001E0" as="xs:double"/>
    
    <xsl:value-of select="f:cot($pX, $pEps, $pUnit)"/>
  </xsl:function>

  <!--
  ==========================================================================
    Function: cot                                                           
     Purpose: Return the cotangent of X specified in radians                
  Parameters:-                                                              
    $pX    - the angle (specified in radians)                               
    $pEps  - [optional] accuracy required                                   
             increase the number of decimal places for greater accuracy but 
             at the expense of performance.                                 
  ==========================================================================-->
  <xsl:function name="f:cot" as="xs:double">
    <xsl:param name="pX" as="xs:double"/>
    <xsl:param name="pEps" as="xs:double"/>
    <xsl:variable name="pUnit" select="'rad'"/>
    
    <xsl:value-of select="f:cot($pX, $pEps, $pUnit)"/>
  </xsl:function>

  <!--
  ==========================================================================
    Function: cot                                                           
     Purpose: Return the cotangent of X specified in radians or degrees     
  Parameters:-                                                              
    $pX    - the angle (specified in radians or degrees)                    
    $pEps  - [optional] accuracy required                                   
             increase the number of decimal places for greater accuracy but 
             at the expense of performance.                                 
    $pUnit - the unit of the given angle £pX                                
             specify 'deg' for degrees or                                   
                     'rad' for radians (default)                            
  ==========================================================================-->
  <xsl:function name="f:cot" as="xs:double">
    <xsl:param name="pX" as="xs:double"/>
    <xsl:param name="pEps" as="xs:double"/>
    <xsl:param name="pUnit" as="xs:string"/>
    
    <xsl:value-of select="int:_trigWrapper($f:trigcot, $pX, $pEps, $pUnit)"/>
  </xsl:function>

  <xsl:variable name="f:sec" as="element()">
    <f:sec/>
  </xsl:variable>
  
  <xsl:function name="f:sec" as="node()">
    <xsl:sequence select="$f:sec"/>
  </xsl:function>
  
  <xsl:template match="f:sec" mode="f:FXSL">
    <xsl:param name="arg1" as="xs:double"/>
    <xsl:sequence select="f:sec($arg1)"/>
  </xsl:template>
  
  <!--
  ==========================================================================
    Function: sec                                                           
     Purpose: Return the secant of X specified in radians                   
  Parameters:-                                                              
    $pX    - the angle (specified in radians)                               
  ==========================================================================-->
  <xsl:function name="f:sec" as="xs:double">
    <xsl:param name="pX" as="xs:double"/>
    <xsl:variable name="pUnit" select="'rad'"/>
    <xsl:variable name="pEps" select=".00000001E0" as="xs:double"/>
    
    <xsl:value-of select="f:sec($pX, $pEps, $pUnit)"/>
  </xsl:function>

  <!--
  ==========================================================================
    Function: sec                                                           
     Purpose: Return the secant of X specified in radians                   
  Parameters:-                                                              
    $pX    - the angle (specified in radians)                               
    $pEps  - [optional] accuracy required                                   
             increase the number of decimal places for greater accuracy but 
             at the expense of performance.                                 
  ==========================================================================-->
  <xsl:function name="f:sec" as="xs:double">
    <xsl:param name="pX" as="xs:double"/>
    <xsl:param name="pEps" as="xs:double"/>
    <xsl:variable name="pUnit" select="'rad'"/>
    
    <xsl:value-of select="f:sec($pX, $pEps, $pUnit)"/>
  </xsl:function>

  <!--
  ==========================================================================
    Function: sec                                                           
     Purpose: Return the secant of X specified in radians or degrees        
  Parameters:-                                                              
    $pX    - the angle (specified in radians or degrees)                    
    $pEps  - [optional] accuracy required                                   
             increase the number of decimal places for greater accuracy but 
             at the expense of performance.                                 
    $pUnit - the unit of the given angle £pX                                
             specify 'deg' for degrees or                                   
                     'rad' for radians (default)                            
  ==========================================================================-->
  <xsl:function name="f:sec" as="xs:double">
    <xsl:param name="pX" as="xs:double"/>
    <xsl:param name="pEps" as="xs:double"/>
    <xsl:param name="pUnit" as="xs:string"/>
    
    <xsl:value-of select="int:_trigWrapper($f:trigsec, $pX, $pEps, $pUnit)"/>
  </xsl:function>

  <xsl:variable name="f:csc" as="element()">
    <f:csc/>
  </xsl:variable>
  
  <xsl:function name="f:csc" as="node()">
    <xsl:sequence select="$f:csc"/>
  </xsl:function>
  
  <xsl:template match="f:csc" mode="f:FXSL">
    <xsl:param name="arg1" as="xs:double"/>
    <xsl:sequence select="f:csc($arg1)"/>
  </xsl:template>
  
  <!--
  ==========================================================================
    Function: csc                                                           
     Purpose: Return the cosecant of X specified in radians                 
  Parameters:-                                                              
    $pX    - the angle (specified in radians)                               
  ==========================================================================-->
  <xsl:function name="f:csc" as="xs:double">
    <xsl:param name="pX" as="xs:double"/>
    <xsl:variable name="pUnit" select="'rad'"/>
    <xsl:variable name="pEps" select=".00000001E0" as="xs:double"/>
    
    <xsl:value-of select="f:csc($pX, $pEps, $pUnit)"/>
  </xsl:function>

  <!--
  ==========================================================================
    Function: csc                                                           
     Purpose: Return the cosecant of X specified in radians                 
  Parameters:-                                                              
    $pX    - the angle (specified in radians)                               
    $pEps  - [optional] accuracy required                                   
             increase the number of decimal places for greater accuracy but 
             at the expense of performance.                                 
  ==========================================================================-->
  <xsl:function name="f:csc" as="xs:double">
    <xsl:param name="pX" as="xs:double"/>
    <xsl:param name="pEps" as="xs:double"/>
    <xsl:variable name="pUnit" select="'rad'"/>
    
    <xsl:value-of select="f:csc($pX, $pEps, $pUnit)"/>
  </xsl:function>

  <!--
  ==========================================================================
    Function: csc                                                           
     Purpose: Return the cosecant of X specified in radians or degrees      
  Parameters:-                                                              
    $pX    - the angle (specified in radians or degrees)                    
    $pEps  - [optional] accuracy required                                   
             increase the number of decimal places for greater accuracy but 
             at the expense of performance.                                 
    $pUnit - the unit of the given angle £pX                                
             specify 'deg' for degrees or                                   
                     'rad' for radians (default)                            
  ==========================================================================-->
  <xsl:function name="f:csc" as="xs:double">
    <xsl:param name="pX" as="xs:double"/>
    <xsl:param name="pEps" as="xs:double"/>
    <xsl:param name="pUnit" as="xs:string"/>
    
    <xsl:value-of select="int:_trigWrapper($f:trigcsc, $pX, $pEps, $pUnit)"/>
  </xsl:function>
  
  <xsl:variable name="f:degrees" as="element()">
    <f:degrees/>
  </xsl:variable>
  
  <xsl:function name="f:degrees" as="node()">
    <xsl:sequence select="$f:degrees"/>
  </xsl:function>
  
  <xsl:template match="f:degrees" mode="f:FXSL">
    <xsl:param name="arg1" as="xs:double"/>
    <xsl:sequence select="f:degrees($arg1)"/>
  </xsl:template>
  
  <!--
  ==========================================================================
    Function: degrees                                                       
     Purpose: Return the degrees of X specified in radians                  
  Parameters:-                                                              
    $pX    - the angle specified in radians                                 
  ==========================================================================-->
  <xsl:function name="f:degrees" as="xs:double">
    <xsl:param name="pX" as="xs:double"/>
    <xsl:sequence select="$pX * $rad2degs"/>
  </xsl:function>
  
  <xsl:variable name="f:radians" as="element()">
    <f:radians/>
  </xsl:variable>
  
  <xsl:function name="f:radians" as="node()">
    <xsl:sequence select="$f:radians"/>
  </xsl:function>
  
  <xsl:template match="f:radians" mode="f:FXSL">
    <xsl:param name="arg1" as="xs:double"/>
    <xsl:sequence select="f:radians($arg1)"/>
  </xsl:template>
  
  <!--
  ==========================================================================
    Function: radians                                                       
     Purpose: Return the radians of X specified in degrees                  
  Parameters:-                                                              
    $pX    - the angle specified in degrees                                 
  ==========================================================================-->
  <xsl:function name="f:radians" as="xs:double">
    <xsl:param name="pX" as="xs:double"/>
    <xsl:sequence select="$pX * $deg2rads"/>
  </xsl:function>
  

  <!-- defined constant for pi -->
  <xsl:variable name="pi" select="3.1415926535897"/>

  <!-- ************************************************************* -->
  <!-- ********************* INTERNAL USE ONLY ********************* -->
  <!-- ************************************************************* -->
  <!-- defined constants -->
  <xsl:variable name="halfPi" select="$pi div 2"/>
  <xsl:variable name="twicePi" select="$pi*2"/>
  <xsl:variable name="deg2rads" select="$pi div 180"/>
  <xsl:variable name="rad2degs" select="180 div $pi"/>
  <!-- internal use only - for applying functions from central _trigWrapper -->
  <xsl:variable name="f:trigcos" as="element()">
    <trigCos:trigCos/>
  </xsl:variable>

  <xsl:variable name="f:trigsin" as="element()">
    <trigSin:trigSin/>
  </xsl:variable>

  <xsl:variable name="f:trigtan" as="element()">
    <trigTan:trigTan/>
  </xsl:variable>

  <xsl:variable name="f:trigcot" as="element()">
    <trigCot:trigCot/>
  </xsl:variable>

  <xsl:variable name="f:trigsec" as="element()">
    <trigSec:trigSec/>
  </xsl:variable>

  <xsl:variable name="f:trigcsc" as="element()">
    <trigCsc:trigCsc/>
  </xsl:variable>

  <!-- internally used templates -->
  <xsl:function name="int:_trigWrapper">
    <xsl:param name="pFun" as="element()"/>
    <xsl:param name="pX" as="xs:double"/>
    <xsl:param name="pEps" as="xs:double"/>
    <xsl:param name="pUnit" as="xs:string"/>
    <!-- convert degrees to radians (when 'deg' specified) -->
    <xsl:variable name="vRads" 
     select="(number(($pUnit = 'rad')) * number($pX))
             + 
              (number(not($pUnit = 'rad')) * (number($pX) * $deg2rads))"/>
    <!-- apply the appropriate function -->
    <xsl:apply-templates select="$pFun" mode="f:FXSL">
      <xsl:with-param name="pX" select="$vRads"/>
      <xsl:with-param name="pEps" select="$pEps"/>
    </xsl:apply-templates>
  </xsl:function>

  <xsl:function name="int:_sin" as="xs:double">
    <xsl:param name="pX" as="xs:double"/>
    <xsl:param name="pEps" as="xs:double"/>

    <xsl:variable name="pY" 
         select="if (not(0 &lt;= $pX and $twicePi > $pX))
                   then int:_cutIntervals($twicePi, $pX)
                   else $pX"
    />

    <xsl:value-of select="int:_sineIter($pY*$pY, $pY, $pY, 1, $pEps)"/>
  
  </xsl:function>
  
  <xsl:template name="_sin" match="trigSin:*" mode="f:FXSL">
    <xsl:param name="pX"/>
    <xsl:param name="pEps" select=".00000001" as="xs:double"/>
    
    <xsl:value-of select="int:_sin($pX, $pEps)"/>
  </xsl:template>

  <xsl:function name="int:_sineIter">
    <xsl:param name="pX2"/>
    <xsl:param name="pRslt"/>
    <xsl:param name="pElem"/>
    <xsl:param name="pN"/>
    <xsl:param name="pEps"/>
    <xsl:variable name="vnextN" select="$pN+2"/>
    <xsl:variable name="vnewElem" select="-$pElem*$pX2 div ($vnextN*($vnextN - 1))"/>
    <xsl:variable name="vnewResult" select="$pRslt + $vnewElem"/>
    <xsl:variable name="vdiffResult" select="$vnewResult - $pRslt"/>

    <xsl:value-of 
       select="
       if ($vdiffResult > $pEps or $vdiffResult &lt; -$pEps)
         then
            int:_sineIter($pX2, $vnewResult, $vnewElem, $vnextN, $pEps)
         else
            $vnewResult
       "/>
  </xsl:function>

  <xsl:function name="int:_cos" as="xs:double">
    <xsl:param name="pX" as="xs:double"/>
    <xsl:param name="pEps" as="xs:double"/>
    
    <xsl:value-of select="int:_sin($halfPi - $pX, $pEps)"/>
  </xsl:function>
  
  <xsl:template name="_cos" match="trigCos:*" mode="f:FXSL">
    <xsl:param name="pX"/>
    <xsl:param name="pEps" select=".00000001" as="xs:double"/>
    
    <xsl:value-of select="int:_cos($pX, $pEps)"/>
  </xsl:template>

  <xsl:template name="_tan" match="trigTan:*" mode="f:FXSL">
    <xsl:param name="pX"/>
    <xsl:param name="pEps" select=".00000001" as="xs:double"/>
    <xsl:param name="_pAbort" select="1"/>
    <xsl:variable name="vnumHalfPis" select="floor($pX div $halfPi)"/>
    <xsl:variable name="vdiffHalfPi" select="$pX - $halfPi*$vnumHalfPis"/>
    <xsl:choose>
      <xsl:when test="-$pEps &lt; $vdiffHalfPi and $vdiffHalfPi &lt; $pEps
                      and $vnumHalfPis mod 2 = 1">
        <xsl:choose>
          <xsl:when test="$_pAbort">
            <xsl:message terminate="yes">
              <xsl:value-of select="concat('[Error]tan() not defined for x=',$pX)"/>
            </xsl:message>
          </xsl:when>
          <xsl:otherwise>Infinity</xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="int:_sin($pX, $pEps) div int:_cos($pX, $pEps)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="_cot" match="trigCot:*" mode="f:FXSL">
    <xsl:param name="pX"/>
    <xsl:param name="pEps" select=".00000001"/>
    <xsl:variable name="vTan">
      <xsl:call-template name="_tan">
        <xsl:with-param name="pX" select="$pX"/>
        <xsl:with-param name="_pAbort" select="0"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="$vTan = 'Infinity'">0</xsl:when>
      <xsl:when test="-$pEps &lt; $vTan and $vTan &lt; $pEps">
        <xsl:message terminate="yes">
          <xsl:value-of select="concat('[Error]cot() not defined for x=',$pX)"/>
        </xsl:message>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="1 div $vTan"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="_sec" match="trigSec:*" mode="f:FXSL">
    <xsl:param name="pX"/>
    <xsl:param name="pEps" select=".00000001"/>

    <xsl:variable name="vCos" select="int:_cos($pX, $pEps)"/>

    <xsl:choose>
      <xsl:when test="-$pEps &lt; $vCos and $vCos &lt; $pEps">
        <xsl:message terminate="yes">
          <xsl:value-of select="concat('[Error]sec() not defined for x=',$pX)"/>
        </xsl:message>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="1 div $vCos"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="_csc" match="trigCsc:*" mode="f:FXSL">
    <xsl:param name="pX"/>
    <xsl:param name="pEps" select=".00000001"/>
    <xsl:call-template name="_sec">
      <xsl:with-param name="pX" select="$halfPi - $pX"/>
      <xsl:with-param name="pEps" select="$pEps"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:function name="int:_cutIntervals" as="xs:double">
    <xsl:param name="pLength"/>
    <xsl:param name="pX"/>
    <xsl:variable name="vsignX">
      <xsl:choose>
        <xsl:when test="$pX >= 0">1</xsl:when>
        <xsl:otherwise>-1</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="vdiff" select="$pLength*floor($pX div $pLength) -$pX"/>
    <xsl:choose>
      <xsl:when test="$vdiff*$pX > 0">
        <xsl:value-of select="$vsignX*$vdiff"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="-$vsignX*$vdiff"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>
</xsl:stylesheet>