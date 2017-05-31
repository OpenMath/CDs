<!--
===========================================================================
 Stylesheet: func-arcTrignm.xsl       INVERSE  TRIGONOMETRIC  FUNCTIONS    
    Version: 1.0 (2005-02-25)                                              
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
 xmlns:int="http://fxsl.sf.net/trig/internal"
 xmlns:mySinFun="f:mySinFun"
 xmlns:mySinFunPrim="f:mySinFunPrim" 
 xmlns:myTanFun="f:myTanFun"
 xmlns:myTanFunPrim="f:myTanFunPrim" 
 xmlns:myCotFun="f:myCotFun"
 xmlns:myCotFunPrim="f:myCotFunPrim" 
 xmlns:atrigSin="f:atrigSin" xmlns:atrigCos="f:atrigCos"
 xmlns:atrigTan="f:atrigTan" xmlns:atrigCot="f:atrigCot"
 xmlns:atrigSec="f:atrigSec" xmlns:atrigCsc="f:atrigCsc"
 xmlns:x="f:arcTrignm.xsl"
 exclude-result-prefixes=
 "f xs x int mySinFun mySinFunPrim myTanFun myTanFunPrim myCotFun 
  myCotFunPrim atrigSin atrigCos atrigTan atrigCot atrigSec atrigCsc"
 >

<!--
  ==========================================================================
    Imported files:                                                       
  ========================================================================== -->

  <xsl:import href="findRoot.xsl"/>
  <xsl:import href="func-trignm.xsl"/>
  <xsl:import href="curry.xsl"/>

<!--
  ==========================================================================
    Module Interface:                                                       
  ========================================================================== -->

<!--
    Function: f:arcsin                                                         
     Purpose: Return the angle, whose sine value is X                        
  Parameters:-                                                               
    $pX    - a value in the interval [-1, 1]                                 
    $pUnit - [optional] the unit in which                                    
             the result is to be returned                                    
             specify: 'deg' for degrees or                                   
                      'rad' for radians (default)                            
    $pEps  - [optional] accuracy required                                    
             increase the number of decimal places for greater accuracy but  
             at the expense of performance.                                  
  ========================================================================== -->
  <xsl:function name="f:arcsin" as="element()">
    <atrigSin:atrigSin/>
  </xsl:function>
  
  <xsl:function name="f:arcsin">
    <xsl:param name="pX"/>
    <xsl:variable name="pEps" as="xs:double" select="0.0000001"/>
    <xsl:variable name="pUnit" as="xs:string" select="'rad'"/>

    <xsl:sequence select=
     "f:arcsin($pX, $pEps, $pUnit)"/>
  </xsl:function>

  <xsl:function name="f:arcsin">
    <xsl:param name="pX"/>
    <xsl:param name="pEps" as="xs:double"/>
    <xsl:variable name="pUnit" as="xs:string" select="'rad'"/>

    <xsl:sequence select=
     "f:arcsin($pX, $pEps, $pUnit)"/>
  </xsl:function>

  <xsl:function name="f:arcsin">
    <xsl:param name="pX"/>
    <xsl:param name="pEps" as="xs:double"/>
    <xsl:param name="pUnit" as="xs:string"/>

    <xsl:sequence select=
     "int:_atrigWrapper(f:arcsin(), $pX, $pUnit, $pEps)"/>
  </xsl:function>

<!--
    Template: arccos                                                         
     Purpose: Return the angle, whose cosine value is X                      
  Parameters:-                                                               
    $pX    - a value in the interval [-1, 1]                                 
    $pUnit - [optional] the unit in which                                    
             the result is to be returned                                    
             specify: 'deg' for degrees or                                   
                      'rad' for radians (default)                            
    $pEps  - [optional] accuracy required                                    
             increase the number of decimal places for greater accuracy but  
             at the expense of performance.                                  
  ========================================================================== -->
  <xsl:function name="f:arccos" as="element()">
    <atrigCos:atrigCos/>
  </xsl:function>
  
  <xsl:function name="f:arccos">
    <xsl:param name="pX" as="xs:double"/>
    <xsl:variable name="pEps" as="xs:double" select="0.0000001"/>
    <xsl:variable name="pUnit" as="xs:string" select="'rad'"/>

   <xsl:sequence select=
   "f:arccos($pX, $pEps, $pUnit)"
   />
  </xsl:function>

  <xsl:function name="f:arccos">
    <xsl:param name="pX" as="xs:double"/>
    <xsl:param name="pEps" as="xs:double"/>
    <xsl:variable name="pUnit" as="xs:string" select="'rad'"/>

   <xsl:sequence select=
   "f:arccos($pX, $pEps, $pUnit)"
   />
  </xsl:function>

  <xsl:function name="f:arccos">
    <xsl:param name="pX" as="xs:double"/>
    <xsl:param name="pEps" as="xs:double"/>
    <xsl:param name="pUnit" as="xs:string"/>

   <xsl:sequence select=
   "int:_atrigWrapper(f:arccos(), $pX, $pUnit, $pEps)"
   />
  </xsl:function>

<!--
    Template: arctan                                                         
     Purpose: Return the angle, whose tangens value is X                     
  Parameters:-                                                               
    $pX    - any real value                                                  
    $pUnit - [optional] the unit in which                                    
             the result is to be returned                                    
             specify: 'deg' for degrees or                                   
                      'rad' for radians (default)                            
    $pEps  - [optional] accuracy required                                    
             increase the number of decimal places for greater accuracy but  
             at the expense of performance.                                  
  ========================================================================== -->
  <xsl:function name="f:arctan" as="element()">
    <atrigTan:atrigTan/>
  </xsl:function>
  
  <xsl:function name="f:arctan">
    <xsl:param name="pX" as="xs:double"/>
    <xsl:variable name="pEps" as="xs:double" select="0.0000001"/>
    <xsl:variable name="pUnit" as="xs:string" select="'rad'"/>

   <xsl:sequence select=
   "f:arctan($pX, $pEps, $pUnit)"
   />
  </xsl:function>

  <xsl:function name="f:arctan">
    <xsl:param name="pX" as="xs:double"/>
    <xsl:param name="pEps" as="xs:double"/>
    <xsl:variable name="pUnit" as="xs:string" select="'rad'"/>

   <xsl:sequence select=
   "f:arctan($pX, $pEps, $pUnit)"
   />
  </xsl:function>

  <xsl:function name="f:arctan">
    <xsl:param name="pX" as="xs:double"/>
    <xsl:param name="pEps" as="xs:double"/>
    <xsl:param name="pUnit" as="xs:string"/>

   <xsl:sequence select=
   "int:_atrigWrapper(f:arctan(), $pX, $pUnit, $pEps)"
   />
  </xsl:function>

<!--
    Template: arccot                                                         
     Purpose: Return the angle, whose cotangens value is X                   
  Parameters:-                                                               
    $pX    - any real value                                                  
    $pUnit - [optional] the unit in which                                    
             the result is to be returned                                    
             specify: 'deg' for degrees or                                   
                      'rad' for radians (default)                            
    $pEps  - [optional] accuracy required                                    
             increase the number of decimal places for greater accuracy but  
             at the expense of performance.                                  
  ========================================================================== -->
  <xsl:function name="f:arccot" as="element()">
    <atrigCot:atrigCot/>
  </xsl:function>
  
  <xsl:function name="f:arccot">
    <xsl:param name="pX" as="xs:double"/>
    <xsl:variable name="pEps" as="xs:double" select="0.0000001"/>
    <xsl:variable name="pUnit" as="xs:string" select="'rad'"/>

   <xsl:sequence select=
   "f:arccot($pX,  $pEps, $pUnit)"
   />
  </xsl:function>

  <xsl:function name="f:arccot">
    <xsl:param name="pX" as="xs:double"/>
    <xsl:param name="pEps" as="xs:double"/>
    <xsl:variable name="pUnit" as="xs:string" select="'rad'"/>

   <xsl:sequence select=
   "f:arccot($pX,  $pEps, $pUnit)"
   />
  </xsl:function>

  <xsl:function name="f:arccot">
    <xsl:param name="pX" as="xs:double"/>
    <xsl:param name="pEps" as="xs:double"/>
    <xsl:param name="pUnit" as="xs:string"/>

   <xsl:sequence select=
   "int:_atrigWrapper(f:arccot(), $pX, $pUnit, $pEps)"
   />
  </xsl:function>

<!--
    Template: arcsec                                                         
     Purpose: Return the angle, whose secant value is X                      
  Parameters:-                                                               
    $pX    - any real value not belonging to the interval (-1, 1)            
    $pUnit - [optional] the unit in which                                    
             the result is to be returned                                    
             specify: 'deg' for degrees or                                   
                      'rad' for radians (default)                            
    $pEps  - [optional] accuracy required                                    
             increase the number of decimal places for greater accuracy but  
             at the expense of performance.                                  
  ========================================================================== -->
  <xsl:function name="f:arcsec" as="element()">
    <atrigSec:atrigSec/>
  </xsl:function>
  
  <xsl:function name="f:arcsec">
    <xsl:param name="pX" as="xs:double"/>
    <xsl:variable name="pEps" as="xs:double" select="0.0000001"/>
    <xsl:variable name="pUnit" as="xs:string" select="'rad'"/>

   <xsl:sequence select=
   "f:arcsec($pX, $pEps, $pUnit)"
   />
  </xsl:function>

  <xsl:function name="f:arcsec">
    <xsl:param name="pX" as="xs:double"/>
    <xsl:param name="pEps" as="xs:double"/>
    <xsl:variable name="pUnit" as="xs:string" select="'rad'"/>

   <xsl:sequence select=
   "f:arcsec($pX, $pEps, $pUnit)"
   />
  </xsl:function>

  <xsl:function name="f:arcsec">
    <xsl:param name="pX" as="xs:double"/>
    <xsl:param name="pEps" as="xs:double"/>
    <xsl:param name="pUnit" as="xs:string"/>

   <xsl:sequence select=
   "int:_atrigWrapper(f:arcsec(), $pX, $pUnit, $pEps)"
   />
  </xsl:function>

<!--
    Template: arccsc                                                         
     Purpose: Return the angle, whose cosecant value is X                    
  Parameters:-                                                               
    $pX    - any real value not belonging to the interval (-1, 1)            
    $pUnit - [optional] the unit in which                                    
             the result is to be returned                                    
             specify: 'deg' for degrees or                                   
                      'rad' for radians (default)                            
    $pEps  - [optional] accuracy required                                    
             increase the number of decimal places for greater accuracy but  
             at the expense of performance.                                  
  ========================================================================== -->
  <xsl:function name="f:arccsc" as="element()">
    <atrigCsc:atrigCsc/>
  </xsl:function>
  
  <xsl:function name="f:arccsc">
    <xsl:param name="pX" as="xs:double"/>
    <xsl:variable name="pEps" as="xs:double" select="0.0000001"/>
    <xsl:variable name="pUnit" as="xs:string" select="'rad'"/>

   <xsl:sequence select=
   "f:arccsc($pX, $pEps, $pUnit)"
   />
  </xsl:function>

  <xsl:function name="f:arccsc">
    <xsl:param name="pX" as="xs:double"/>
    <xsl:param name="pEps" as="xs:double"/>
    <xsl:variable name="pUnit" as="xs:string" select="'rad'"/>

   <xsl:sequence select=
   "f:arccsc($pX, $pEps, $pUnit)"
   />
  </xsl:function>

  <xsl:function name="f:arccsc">
    <xsl:param name="pX" as="xs:double"/>
    <xsl:param name="pEps" as="xs:double"/>
    <xsl:param name="pUnit" as="xs:string"/>

   <xsl:sequence select=
   "int:_atrigWrapper(f:arccsc(), $pX, $pUnit, $pEps)"
   />
  </xsl:function>

  <!-- ************************************************************* -->
  <!-- ********************* INTERNAL USE ONLY ********************* -->
  <!-- ************************************************************* -->
  <!-- defined constants -->
  <xsl:variable name="rad2degs" select="180 div $pi"/>

  <!-- internally used templates -->
  <xsl:function name="int:_atrigWrapper">
    <xsl:param name="pFun" as="element()"/>
    <xsl:param name="pX" as="xs:double"/>
    <xsl:param name="pUnit" as="xs:string"/>
    <xsl:param name="pEps" as="xs:double"/>
    
    <xsl:variable name="vUnit" as="xs:string" select=
      "if(exists($pUnit))
         then $pUnit
         else 'rad'
      "/>

    <xsl:variable name="vEps" as="xs:double" select=
      "if(exists($pEps))
         then $pEps
         else '.00000001E0'
      "/>

    <!-- apply the appropriate function -->
    <xsl:variable name="vradResult" as="xs:double">
      <xsl:apply-templates select="$pFun" mode="f:FXSL">
        <xsl:with-param name="pX" select="$pX"/>
        <xsl:with-param name="pEps" select="$vEps"/>
      </xsl:apply-templates>
    </xsl:variable>
    <!-- convert radians to degrees (when 'deg' specified) -->
    <xsl:value-of select="if($vUnit = 'rad')
                            then $vradResult
                            else $vradResult * $rad2degs"/>

  </xsl:function>
    
  <xsl:template name="_arcsin" match="atrigSin:*" mode="f:FXSL">
    <xsl:param name="pX" as="xs:double"/>
    <xsl:param name="pEps" as="xs:double" select="0.0000001"/>
    
    <xsl:if test="not(-1 le $pX and $pX le 1)">
      <xsl:message terminate="yes">
        [Error]: arcSine argument must be within the interval [-1, 1]
      </xsl:message>
    </xsl:if>
    
    <xsl:choose>
      <xsl:when test="$pX = 0">0</xsl:when>
      <xsl:when test="$pX &lt; -0.99999999">
        <xsl:value-of select="3*$halfPi"/>
      </xsl:when>
      <xsl:otherwise>
		    <xsl:variable name="vSinFun" as="element()">
          <mySinFun:mySinFun/>
        </xsl:variable>
		    
        <xsl:variable name="vCoSFun">
          <mySinFunPrim:mySinFunPrim/>
        </xsl:variable>
		    
		    <xsl:variable name="vcurriedSinFun" as="element()">
		      <xsl:call-template name="curry">
		        <xsl:with-param name="pFun" select="$vSinFun"/>
		        <xsl:with-param name="pNargs" select="3"/>
		        <xsl:with-param name="arg2" select="$pX"/><!-- pC -->
		        <xsl:with-param name="arg3" select="$pEps"/>
		      </xsl:call-template>
		    </xsl:variable>
		    
		    <xsl:variable name="vcurriedCoSFun" as="element()">
		      <xsl:call-template name="curry">
		        <xsl:with-param name="pFun" select="$vCoSFun"/>
		        <xsl:with-param name="pNargs" select="2"/>
		        <xsl:with-param name="arg2" select="$pEps"/>
		      </xsl:call-template>
		    </xsl:variable>
		    
		    <xsl:call-template name="findRootNR">
		      <xsl:with-param name="pFun" select="$vcurriedSinFun"/>
		      <xsl:with-param name="pFunPrim" select="$vcurriedCoSFun"/>
		      <xsl:with-param name="pX0" select="$pi div 6"/>
		      <xsl:with-param name="pEps" select="0.0000001"/>
	      </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template name="_arccos" match="atrigCos:*" mode="f:FXSL">
    <xsl:param name="pX" as="xs:double"/>
    <xsl:param name="pEps" as="xs:double" select="0.0000001"/>

	  <xsl:value-of select="$halfPi - f:arcsin($pX, $pEps)"/>
  </xsl:template>
    
  <xsl:template name="_arctan" match="atrigTan:*" mode="f:FXSL">
    <xsl:param name="pX" as="xs:double"/>
    <xsl:param name="pEps" select="0.0000001"/>
    
    <xsl:choose>
	    <xsl:when test="$pX > 43 or $pX &lt; -43">
	      <xsl:sequence select="f:arccot(1 div $pX, $pEps)"/>
	    </xsl:when>
	    <xsl:otherwise>
		    <xsl:variable name="vTanFun" as="element()">
          <myTanFun:myTanFun/>
        </xsl:variable>
		    
        <xsl:variable name="vTanPrFun" as="element()">
          <myTanFunPrim:myTanFunPrim/>
        </xsl:variable>
		    
		    <xsl:variable name="vrtf-curriedTanFun">
		      <xsl:call-template name="curry">
		        <xsl:with-param name="pFun" select="$vTanFun"/>
		        <xsl:with-param name="pNargs" select="3"/>
		        <xsl:with-param name="arg2" select="$pX"/><!-- pC -->
		        <xsl:with-param name="arg3" select="$pEps"/>
		      </xsl:call-template>
		    </xsl:variable>
		    
		    <xsl:variable name="vrtf-curriedTanPrFun">
		      <xsl:call-template name="curry">
		        <xsl:with-param name="pFun" select="$vTanPrFun"/>
		        <xsl:with-param name="pNargs" select="2"/>
		        <xsl:with-param name="arg2" select="$pEps"/>
		      </xsl:call-template>
		    </xsl:variable>
		    
		    <xsl:variable name="vrawRoot">
			    <xsl:call-template name="findRootNR">
			      <xsl:with-param name="pFun" select="$vrtf-curriedTanFun/*"/>
			      <xsl:with-param name="pFunPrim" select="$vrtf-curriedTanPrFun/*"/>
			      <xsl:with-param name="pX0" select="3"/>
			      <xsl:with-param name="pEps" select="0.0000001"/>
		      </xsl:call-template>
	      </xsl:variable>

	      <xsl:sequence select="int:_cutIntervals($pi, $vrawRoot)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="_arccot" match="atrigCot:*" mode="f:FXSL">
    <xsl:param name="pX" as="xs:double"/>
    <xsl:param name="pEps" as="xs:double" select="0.0000001"/>
    
    <xsl:choose>
	    <xsl:when test="$pX > 43 or $pX &lt; -43">
	      <xsl:call-template name="_arctan">
	        <xsl:with-param name="pX" select="1 div $pX"/>
	        <xsl:with-param name="pEps" select="$pEps"/>
	      </xsl:call-template>
	    </xsl:when>
      <xsl:when test="$pX = 0">
        <xsl:value-of select="$halfPi"/>
      </xsl:when>
      <xsl:otherwise>
		    <xsl:variable name="vCotFun" as="element()">
          <myCotFun:myCotFun/>
        </xsl:variable>
		    
        <xsl:variable name="vCotPrFun" as="element()">
          <myCotFunPrim:myTanFunPrim/>
        </xsl:variable>
		    
		    <xsl:variable name="vrtf-curriedCotFun">
		      <xsl:call-template name="curry">
		        <xsl:with-param name="pFun" select="$vCotFun"/>
		        <xsl:with-param name="pNargs" select="3"/>
		        <xsl:with-param name="arg2" select="$pX"/><!-- pC -->
		        <xsl:with-param name="arg3" select="$pEps"/>
		      </xsl:call-template>
		    </xsl:variable>
		    
		    <xsl:variable name="vrtf-curriedCotPrFun">
		      <xsl:call-template name="curry">
		        <xsl:with-param name="pFun" select="$vCotPrFun"/>
		        <xsl:with-param name="pNargs" select="2"/>
		        <xsl:with-param name="arg2" select="$pEps"/>
		      </xsl:call-template>
		    </xsl:variable>
		    
		    <xsl:variable name="vrawRoot">
			    <xsl:call-template name="findRootNR">
			      <xsl:with-param name="pFun" select="$vrtf-curriedCotFun/*"/>
			      <xsl:with-param name="pFunPrim" select="$vrtf-curriedCotPrFun/*"/>
			      <xsl:with-param name="pX0" select="3"/>
			      <xsl:with-param name="pEps" select="0.0000001"/>
		      </xsl:call-template>
	      </xsl:variable>
		      
	      <xsl:sequence select="int:_cutIntervals($pi, $vrawRoot)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template name="_arcsec" match="atrigSec:*" mode="f:FXSL">
    <xsl:param name="pX" as="xs:double"/>
    <xsl:param name="pEps" as="xs:double" select="0.0000001"/>
    
    <xsl:if test="$pX = 0">
      <xsl:message terminate="yes">
        [Error]arcsec: The argument cannot be 0.
      </xsl:message>
    </xsl:if>
    
    <xsl:sequence select="f:arccos(1 div $pX, $pEps)"/>
  </xsl:template>

  <xsl:template name="_arccsc" match="atrigCsc:*" mode="f:FXSL">
    <xsl:param name="pX" as="xs:double"/>
    <xsl:param name="pEps" as="xs:double" select="0.0000001"/>
    
    <xsl:if test="$pX = 0">
      <xsl:message terminate="yes">
        [Error]arccsc: The argument cannot be 0.
      </xsl:message>
    </xsl:if>
    
    <xsl:sequence select="f:arcsin(1 div $pX, $pEps)"/>
  </xsl:template>

  <!-- this calculates sin(x) - C -->
  <xsl:template match="mySinFun:*" mode="f:FXSL">
    <xsl:param name="arg1" as="xs:double"/> <!-- pX -->
    <xsl:param name="arg2" as="xs:double"/> <!-- pC -->
    <xsl:param name="arg3" as="xs:double"/> <!-- pEps -->
    
    <xsl:sequence select="f:sin($arg1, $arg3) - $arg2"/>
  </xsl:template>

  <xsl:template match="mySinFunPrim:*" mode="f:FXSL">
    <xsl:param name="arg1" as="xs:double"/> <!-- pX -->
    <xsl:param name="arg2" as="xs:double"/> <!-- pEps -->

    <xsl:sequence select="f:cos($arg1, $arg2)"/>
  </xsl:template>
  
    <!-- this calculates tan(x) - C -->
  <xsl:template match="myTanFun:*" mode="f:FXSL">
    <xsl:param name="arg1" as="xs:double"/> <!-- pX -->
    <xsl:param name="arg2" as="xs:double"/> <!-- pC -->
    <xsl:param name="arg3" as="xs:double"/> <!-- pEps -->

    <xsl:sequence select="f:tan($arg1, $arg3) - $arg2"/>
  </xsl:template>

    <!-- this calculates tan'(x) = sec^2(x) -->
  <xsl:template match="myTanFunPrim:*" mode="f:FXSL">
    <xsl:param name="arg1" as="xs:double"/> <!-- pX -->
    <xsl:param name="arg2" as="xs:double"/> <!-- pEps -->

      <xsl:variable name="vSec" as="xs:double"
           select="f:sec($arg1, $arg2)"/>
      
      <xsl:value-of select="$vSec * $vSec"/>
  </xsl:template>

    <!-- this calculates cot(x) - C -->
  <xsl:template match="myCotFun:*" mode="f:FXSL">
    <xsl:param name="arg1" as="xs:double"/> <!-- pX -->
    <xsl:param name="arg2" as="xs:double"/> <!-- pC -->
    <xsl:param name="arg3" as="xs:double"/> <!-- pEps -->

    <xsl:sequence select="f:cot($arg1, $arg3) - $arg2"/>

  </xsl:template>

    <!-- this calculates cot'(x) = -csc^2(x) -->
  <xsl:template match="myCotFunPrim:*" mode="f:FXSL">
    <xsl:param name="arg1" as="xs:double"/> <!-- pX -->
    <xsl:param name="arg2" as="xs:double"/> <!-- pEps -->

      <xsl:variable name="vCsc" as="xs:double"
           select="f:csc($arg1, $arg2)"/>

      
      <xsl:sequence select="-$vCsc * $vCsc"/>
  </xsl:template>

</xsl:stylesheet>