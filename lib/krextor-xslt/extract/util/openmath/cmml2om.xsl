<xsl:stylesheet version="2.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns="http://www.openmath.org/OpenMath"
		xmlns:m="http://www.w3.org/1998/Math/MathML"
 		exclude-result-prefixes="m"
>


  <xsl:param name="warn" select="false()"/>

  <xsl:template match="*" mode="cmml2om" priority="-1">
    <xsl:if test="$warn">
      <xsl:message>cmml2om: <xsl:value-of select="name()"/>
      <xsl:text>[[</xsl:text>
      <xsl:copy-of select="ancestor::m:math[1]"/>
      <xsl:text>]]</xsl:text>
      </xsl:message>
    </xsl:if>
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates mode="cmml2om"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="m:apply|m:reln" mode="cmml2om">
    <OMA>
      <xsl:apply-templates mode="cmml2om"/>
    </OMA>
  </xsl:template>

  <xsl:template match="m:fn[count(*)=1]" mode="cmml2om">
    <xsl:apply-templates mode="cmml2om"/>
  </xsl:template>

  <xsl:template match="m:apply[m:bvar]" mode="cmml2om" priority="10">
    <xsl:variable name="b" as="element()">
      <m:bind>
	<xsl:copy-of select="node()"/>
      </m:bind>
    </xsl:variable>
    <xsl:apply-templates select="$b" mode="cmml2om"/>
  </xsl:template>

  <xsl:template match="m:math" mode="cmml2om">
    <OMOBJ>
      <xsl:apply-templates mode="cmml2om"/>
    </OMOBJ>
  </xsl:template>



  <xsl:template match="m:csymbol" mode="cmml2om">
    <OMS cd="{normalize-space(@cd)}" name="{normalize-space(.)}"/>
  </xsl:template>

  <xsl:template match="m:ci" mode="cmml2om">
    <OMV name="{normalize-space(.)}"/>
  </xsl:template>


  <xsl:template match="m:cs" mode="cmml2om">
    <OMSTR>
      <xsl:copy-of select="@id"/>
      <xsl:value-of select="."/>
    </OMSTR>
  </xsl:template>



  <xsl:template match="m:cn[not(m:sep)][matches(.,'^[ 0-9.,-]+$')]" mode="cmml2om">
    <OMI>
      <xsl:value-of select="."/>
    </OMI>
  </xsl:template>

  <xsl:template match="m:cn[@type='integer'][@base]" mode="cmml2om" priority="2">
    <OMA>
      <OMS cd="nums1" name="based_integer"/>
      <xsl:choose>
	<xsl:when test="matches(@base,'^[ 0-9.,-]+$')">
	  <OMI><xsl:value-of select="@base"/></OMI>
	</xsl:when>
	<xsl:otherwise>
	  <OMV name="{@base}"/>
	</xsl:otherwise>
      </xsl:choose>
      <OMSTR><xsl:value-of select="normalize-space(.)"/></OMSTR>
    </OMA>
  </xsl:template>

  <xsl:template match="m:cn[@type='rational']" mode="cmml2om">
    <OMA>
      <OMS cd="nums1" name="rational"/>
      <xsl:apply-templates select="text()"  mode="cmml2om"/>
    </OMA>
  </xsl:template>

  <xsl:template match="m:cn[@type='complex-polar']" mode="cmml2om">
    <OMA>
      <OMS cd="complex1" name="complex_polar"/>
      <xsl:apply-templates select="text()"  mode="cmml2om"/>
    </OMA>
  </xsl:template>
  <xsl:template match="m:cn[@type='complex-cartesian']" mode="cmml2om">
    <OMA>
      <OMS cd="complex1" name="complex_cartesian"/>
      <xsl:apply-templates select="text()"  mode="cmml2om"/>
    </OMA>
  </xsl:template>
  <xsl:template match="m:cn/text()[matches(.,'^[ &#10;0-9-]+$')]" mode="cmml2om">
    <OMI>
      <xsl:value-of select="normalize-space(.)"/>
    </OMI>
  </xsl:template>
  <xsl:template match="m:cn/text()[matches(.,'^[ &#10;0-9.,-]+\.[ &#10;0-9.,-]+$')]" mode="cmml2om">
    <OMF dec="{.}"/>
  </xsl:template>
  <xsl:template match="m:cn/text()[matches(.,'^[ 0-9.,-]+$')]" mode="cmml2om" priority="2">
    <OMI><xsl:value-of select="."/></OMI>
  </xsl:template>
  <xsl:template match="m:cn[normalize-space(.)='&#960;']" mode="cmml2om">
    <OMS cd="nums1" name="pi"/>
  </xsl:template>
  <xsl:template match="m:cn[normalize-space(.)='&#8519;']" mode="cmml2om">
    <OMS cd="nums1" name="e"/>
  </xsl:template>
  <xsl:template match="m:cn[normalize-space(.)='&#947;']" mode="cmml2om">
    <OMS cd="nums1" name="gamma"/>
  </xsl:template>
  <xsl:template match="m:cn[normalize-space(.)='&#8520;']" mode="cmml2om">
    <OMS cd="nums1" name="i"/>
  </xsl:template>
  <xsl:template match="m:cn[normalize-space(.)='&#8734;']" mode="cmml2om">
    <OMS cd="nums1" name="infinity"/>
  </xsl:template>
  <xsl:template match="m:cn[@type='e-notation']" mode="cmml2om">
    <OMA>
      <OMS cd="bigfloat1" name="bigfloat"/>
      <OMF>
	<xsl:attribute name="dec">
	  <xsl:apply-templates select="text()[1]"  mode="cmml2om"/>
	</xsl:attribute>
      </OMF>
      <OMI>10</OMI>
      <OMI>
	<xsl:apply-templates select="text()[2]"  mode="cmml2om"/>
      </OMI>
    </OMA>
  </xsl:template>
  <xsl:template match="m:cn" mode="cmml2om">
    <!--    <xsl:message select="'cn: ',."/>-->
    <OMV name="{.}"/>
  </xsl:template>
  <xsl:template match="m:bind" mode="cmml2om">
    <OMBIND>
      <xsl:apply-templates select="*[1]" mode="cmml2om"/>
      <OMBVAR>
	<xsl:apply-templates select="m:bvar/*" mode="cmml2om"/>
      </OMBVAR>
      <xsl:apply-templates select="*[last()][not(self::m:bvar)]" mode="cmml2om"/>
    </OMBIND>
  </xsl:template>


  <xsl:template match="m:cerror" mode="cmml2om">
    <OME>
      <xsl:copy-of select="@id"/>
      <xsl:apply-templates mode="cmml2om"/>
    </OME>
  </xsl:template>

  <xsl:template match="m:cbytes" mode="cmml2om">
    <OMB>
      <xsl:copy-of select="@id"/>
      <xsl:apply-templates mode="cmml2om"/>
    </OMB>
  </xsl:template>




  <xsl:template match="m:lcm" mode="cmml2om">
    <OMS cd="arith1" name="lcm"/>
  </xsl:template>
  <xsl:template match="m:big_lcm" mode="cmml2om">
    <OMS cd="arith1" name="big_lcm"/>
  </xsl:template>
  <xsl:template match="m:gcd" mode="cmml2om">
    <OMS cd="arith1" name="gcd"/>
  </xsl:template>
  <xsl:template match="m:big_gcd" mode="cmml2om">
    <OMS cd="arith1" name="big_gcd"/>
  </xsl:template>
  <xsl:template match="m:plus" mode="cmml2om">
    <OMS cd="arith1" name="plus"/>
  </xsl:template>
  <xsl:template match="m:minus" mode="cmml2om">
    <OMS cd="arith1" name="minus"/>
  </xsl:template>
  <xsl:template match="m:apply[*[1][self::m:minus]][not(*[3])]" mode="cmml2om">
    <OMA>
      <OMS cd="arith1" name="unary_minus"/>
      <xsl:apply-templates select="*[2]" mode="cmml2om"/>
    </OMA>
  </xsl:template>

  <xsl:template match="m:times" mode="cmml2om">
    <OMS cd="arith1" name="times"/>
  </xsl:template>
  <xsl:template match="m:divide" mode="cmml2om">
    <OMS cd="arith1" name="divide"/>
  </xsl:template>
  <xsl:template match="m:power" mode="cmml2om">
    <OMS cd="arith1" name="power"/>
  </xsl:template>
  <xsl:template match="m:abs" mode="cmml2om">
    <OMS cd="arith1" name="abs"/>
  </xsl:template>
  <xsl:template match="m:root" mode="cmml2om">
    <OMS cd="arith1" name="root"/>
  </xsl:template>
  <xsl:template match="m:apply[*[1][self::m:root]][not(m:degree)]" mode="cmml2om">
    <OMA>
      <OMS cd="arith1" name="root"/>
      <xsl:apply-templates select="*[2]" mode="cmml2om"/>
      <OMI>2</OMI>
    </OMA>
  </xsl:template>
  <xsl:template match="m:apply[*[1][self::m:root]][m:degree]" mode="cmml2om">
    <OMA>
      <OMS cd="arith1" name="root"/>
      <xsl:apply-templates select="*[position()!=1 and not(self::m:degree)],m:degree/*" mode="cmml2om"/>
    </OMA>
  </xsl:template>
  <xsl:template match="m:sum" mode="cmml2om">
    <OMS cd="arith1" name="sum"/>
  </xsl:template>
  <xsl:template match="m:product" mode="cmml2om">
    <OMS cd="arith1" name="product"/>
  </xsl:template>

  <xsl:template match="m:apply[*[1][self::m:product]][m:bvar][m:lowlimit][m:uplimit]" mode="cmml2om" priority="26">
    <OMA>
      <OMS cd="arith1" name="product"/>
      <OMA>
	<OMS cs="interval1" name="integer_interval"/>
	<xsl:apply-templates select="m:lowlimit/*" mode="cmml2om"/>
	<xsl:apply-templates select="m:uplimit/*" mode="cmml2om"/>
      </OMA>
      <OMBIND>
	<OMS cd="fns1" name="lambda"/>
	<OMBVAR>
	  <xsl:apply-templates select="m:bvar/m:ci" mode="cmml2om"/>
	</OMBVAR>
	<xsl:apply-templates select="*[last()]" mode="cmml2om"/>
      </OMBIND>
    </OMA>
  </xsl:template>
  


  <xsl:template match="m:diff" mode="cmml2om">
    <OMS cd="calculus1" name="diff"/>
  </xsl:template>
  <xsl:template match="m:nthdiff" mode="cmml2om">
    <OMS cd="calculus1" name="nthdiff"/>
  </xsl:template>




  <xsl:template match="m:*[self::m:apply or self::m:bind][m:bvar][*[1][self::m:diff]]" mode="cmml2om">
    <OMA>
      <OMS cd="calculus1" name="diff"/>
      <OMBIND>
	<OMS cd="fns1" name="lambda"/>
	<OMBVAR>
	  <xsl:apply-templates select="m:bvar/m:ci" mode="cmml2om"/>
	</OMBVAR>
	<xsl:apply-templates select="*[last()]" mode="cmml2om"/>
      </OMBIND>
    </OMA>
  </xsl:template>


  <xsl:template match="m:*[self::m:apply or self::m:bind][*[1][self::m:diff]][m:degree]" priority="3" mode="cmml2om">
    <OMA>
      <OMS cd="calculus1" name="nthdiff"/>
      <xsl:apply-templates select="m:degree/*" mode="cmml2om"/>
      <OMBIND>
	<OMS cd="fns1" name="lambda"/>
	<OMBVAR>
	  <xsl:apply-templates select="m:bvar/m:ci" mode="cmml2om"/>
	</OMBVAR>
	<xsl:apply-templates select="*[last()]" mode="cmml2om"/>
      </OMBIND>
    </OMA>
  </xsl:template>


  <xsl:template match="m:*[self::m:apply or self::m:bind][*[1][self::m:diff]][m:bvar/m:degree]" priority="2" mode="cmml2om">
    <OMA>
      <OMS cd="calculus1" name="nthdiff"/>
      <xsl:apply-templates select="m:bvar/m:degree/*" mode="cmml2om"/>
      <OMBIND>
	<OMS cd="fns1" name="lambda"/>
	<OMBVAR>
	  <xsl:apply-templates select="m:bvar/m:ci" mode="cmml2om"/>
	</OMBVAR>
	<xsl:apply-templates select="*[last()]" mode="cmml2om"/>
      </OMBIND>
    </OMA>
  </xsl:template>



  <xsl:template match="m:partialdiff" mode="cmml2om">
    <OMS cd="calculus1" name="partialnthdiff"/>
  </xsl:template>


  <xsl:template match="m:*[self::m:apply or self::m:bind][*[1][self::m:partialdiff]][m:bvar]" mode="cmml2om">
    
    <OMA>
      <OMS cd="calculus1" name="partialnthdiff"/>
      <OMA>
	<OMS cd="list1" name="list"/>
	<xsl:apply-templates select="m:bvar" mode="cmml2ompd"/>
	<!-- lose total degree for now
	     <xsl:apply-templates select="m:degree/*" mode="cmml2om"/>
	-->
      </OMA>
      <OMBIND>
	<OMS cd="fns1" name="lambda"/>
	<OMBVAR>
	  <xsl:apply-templates select="m:bvar/m:ci" mode="cmml2om"/>
	</OMBVAR>
	<xsl:apply-templates select="*[last()]" mode="cmml2om"/>
      </OMBIND>
    </OMA>
  </xsl:template>
  
  <xsl:template match="*" mode="cmml2ompd">
    <xsl:message select="'partial diff ??? ',."/>
  </xsl:template>

  <xsl:template match="m:bvar[m:degree]" mode="cmml2ompd">
    <xsl:apply-templates select="m:degree/*" mode="cmml2om"/>
  </xsl:template>


  <xsl:template match="m:bvar" mode="cmml2ompd">
    <OMI>1</OMI>
  </xsl:template>

  <xsl:template match="m:*[self::m:apply or self::m:bind][*[1][self::m:partialdiff]][m:list]" mode="cmml2om">
    
    <OMA>
      <OMS cd="calculus1" name="partialnthdiff"/>
      <xsl:apply-templates select="m:list" mode="cmml2om"/>
      <xsl:apply-templates select="*[last()]" mode="cmml2om"/>
    </OMA>
  </xsl:template>
  
  
  <xsl:template match="m:int" mode="cmml2om">
    <OMS cd="calculus1" name="int"/>
  </xsl:template>



  <xsl:template match="m:apply[*[1][self::m:int]][m:domainofapplication|m:interval]" mode="cmml2om" priority="15">
    <OMA>
      <OMS cd="calculus1" name="defint"/>
      <xsl:apply-templates select="m:domainofapplication/*|m:interval" mode="cmml2om"/>
      <xsl:apply-templates select="*[last()]" mode="cmml2om"/>
    </OMA>
  </xsl:template>


  <xsl:template match="m:apply[*[1][self::m:int]][m:bvar][m:domainofapplication|m:interval]" mode="cmml2om" priority="20">
    <OMA>
      <OMS cd="calculus1" name="defint"/>
      <xsl:apply-templates select="m:domainofapplication/*|m:interval" mode="cmml2om"/>
      <OMBIND>
	<OMS cd="fns1" name="lambda"/>
	<OMBVAR>
	  <xsl:apply-templates select="m:bvar/m:ci" mode="cmml2om"/>
	</OMBVAR>
	<xsl:apply-templates select="*[last()]" mode="cmml2om"/>
      </OMBIND>
    </OMA>
  </xsl:template>
  

  <xsl:template match="m:apply[*[1][self::m:int]][m:bvar][m:condition]" mode="cmml2om" priority="20">
    <OMA>
      <OMS cd="calculus1" name="defint"/>
      <xsl:apply-templates select="m:condition/*" mode="cmml2om"/>
      <OMBIND>
	<OMS cd="fns1" name="lambda"/>
	<OMBVAR>
	  <xsl:apply-templates select="m:bvar/m:ci" mode="cmml2om"/>
	</OMBVAR>
	<xsl:apply-templates select="*[last()]" mode="cmml2om"/>
      </OMBIND>
    </OMA>
  </xsl:template>
  

  <xsl:template match="m:apply[*[1][self::m:int]][m:bvar][m:lowlimit and m:uplimit]" mode="cmml2om" priority="25">
    <OMA>
      <OMS cd="calculus1" name="defint"/>
      <OMA>
	<OMS cd="interval1" name="interval"/>
	<xsl:apply-templates select="m:lowlimit/*" mode="cmml2om"/>
	<xsl:apply-templates select="m:uplimit/*" mode="cmml2om"/>
      </OMA>
      <OMBIND>
	<OMS cd="fns1" name="lambda"/>
	<OMBVAR>
	  <xsl:apply-templates select="m:bvar/m:ci" mode="cmml2om"/>
	</OMBVAR>
	<xsl:apply-templates select="*[last()]" mode="cmml2om"/>
      </OMBIND>
    </OMA>
  </xsl:template>
  

  <xsl:template match="m:complex_cartesian" mode="cmml2om">
    <OMS cd="complex1" name="complex_cartesian"/>
  </xsl:template>
  <xsl:template match="m:real" mode="cmml2om">
    <OMS cd="complex1" name="real"/>
  </xsl:template>
  <xsl:template match="m:imaginary" mode="cmml2om">
    <OMS cd="complex1" name="imaginary"/>
  </xsl:template>
  <xsl:template match="m:complex_polar" mode="cmml2om">
    <OMS cd="complex1" name="complex_polar"/>
  </xsl:template>
  <xsl:template match="m:arg" mode="cmml2om">
    <OMS cd="complex1" name="argument"/>
  </xsl:template>
  <xsl:template match="m:conjugate" mode="cmml2om">
    <OMS cd="complex1" name="conjugate"/>
  </xsl:template>
  <xsl:template match="m:domain" mode="cmml2om">
    <OMS cd="fns1" name="domain"/>
  </xsl:template>
  <xsl:template match="m:codomain" mode="cmml2om">
    <OMS cd="fns1" name="range"/>
  </xsl:template>
  <xsl:template match="m:image" mode="cmml2om">
    <OMS cd="fns1" name="image"/>
  </xsl:template>
  <xsl:template match="m:ident" mode="cmml2om">
    <OMS cd="fns1" name="identity"/>
  </xsl:template>
  <xsl:template match="m:left_inverse" mode="cmml2om">
    <OMS cd="fns1" name="left_inverse"/>
  </xsl:template>
  <xsl:template match="m:right_inverse" mode="cmml2om">
    <OMS cd="fns1" name="right_inverse"/>
  </xsl:template>
  <xsl:template match="m:inverse" mode="cmml2om">
    <OMS cd="fns1" name="inverse"/>
  </xsl:template>
  <xsl:template match="m:compose" mode="cmml2om">
    <OMS cd="fns1" name="left_compose"/>
  </xsl:template>
  <xsl:template match="m:lambda" mode="cmml2om">
    <OMBIND>
      <OMS cd="fns1" name="lambda"/>
      <OMBVAR>
	<xsl:apply-templates select="m:bvar/*" mode="cmml2om"/>
      </OMBVAR>
      <xsl:apply-templates select="*[last()][not(self::m:bvar)]" mode="cmml2om"/>
    </OMBIND>
  </xsl:template>


  <xsl:template match="m:factorof" mode="cmml2om">
    <OMS cd="integer1" name="factorof"/>
  </xsl:template>
  <xsl:template match="m:factorial" mode="cmml2om">
    <OMS cd="integer1" name="factorial"/>
  </xsl:template>
  <xsl:template match="m:quotient" mode="cmml2om">
    <OMS cd="integer1" name="quotient"/>
  </xsl:template>
  <xsl:template match="m:rem" mode="cmml2om">
    <OMS cd="integer1" name="remainder"/>
  </xsl:template>

  <xsl:template match="m:interval" mode="cmml2om">
    <OMA>
      <OMS cd="interval1" name="interval">
	<xsl:apply-templates select="@closure" mode="cmml2om"/>
      </OMS>
      <xsl:apply-templates select="*" mode="cmml2om"/>
    </OMA>
  </xsl:template>

  <xsl:template match="m:interval/@closure[.='open']" mode="cmml2om">
    <xsl:attribute name="name" select="'interval_oo'"/>
  </xsl:template>
  <xsl:template match="m:interval/@closure[.='closed']" mode="cmml2om">
    <xsl:attribute name="name" select="'interval_cc'"/>
  </xsl:template>
  <xsl:template match="m:interval/@closure[.='open-closed']" mode="cmml2om">
    <xsl:attribute name="name" select="'interval_oc'"/>
  </xsl:template>
  <xsl:template match="m:interval/@closure[.='closed-open']" mode="cmml2om">
    <xsl:attribute name="name" select="'interval_co'"/>
  </xsl:template>

  <xsl:template match="m:limit" mode="cmml2om">
    <OMS cd="limit1" name="limit"/>
  </xsl:template>

<!--
  <xsl:template match="m:apply[*[1][self::m:tendsto]]|m:reln[*[1][self::m:tendsto]]" mode="cmml2om">
    <OMA>
      <OMS cd="limit1" name="tendsto"/>
      <OMS cd="limit1" name="{(@type,'null')[1]}"/>
      <xsl:apply-templates select="*[position()!=1]" mode="cmml2om"/>
    </OMA>
  </xsl:template>
-->
<xsl:template match="m:tendsto"  mode="cmml2om">
  <OMATTR>
    <OMATP>
      <OMS cd="altenc" name="MathML_encoding"/>
      <OMFOREIGN encoding="MathML-Content">
	<tendsto xmlns="http://www.w3.org/1998/Math/MathML"/>
      </OMFOREIGN>
    </OMATP>
    <OMV name="tendsto"/>
  </OMATTR>
</xsl:template>

  <xsl:template match="m:apply[*[1][self::m:limit]]" mode="cmml2om">
    <OMA>
      <xsl:apply-templates select="*[1]" mode="cmml2om"/>
      <OMS cd="limit1" name="null"/>
      <xsl:apply-templates select="*[last()]" mode="cmml2om"/>
    </OMA>
  </xsl:template>

  <xsl:template match="m:apply[*[1][self::m:limit]][m:condition]" priority="92" mode="cmml2om">
    <OMA>
      <xsl:apply-templates select="*[1]" mode="cmml2om"/>
      <xsl:apply-templates select="m:condition" mode="cmml2om"/>
      <OMBIND>
	<OMS cd="fns1" name="lambda"/>
	<OMBVAR>
	  <xsl:apply-templates select="m:condition/(m:apply|m:reln)/*[2]" mode="cmml2om"/>
	</OMBVAR>
	<xsl:apply-templates select="*[last()]" mode="cmml2om"/>
      </OMBIND>
    </OMA>
  </xsl:template>

  <xsl:template match="*[*[1][self::m:limit]]/m:condition[*/m:tendsto]" priority="42" mode="cmml2om">
    <xsl:apply-templates select="(m:apply|m:reln)/*[3]" mode="cmml2om"/>
    <xsl:apply-templates select="(m:apply|m:reln)/*[1]" mode="cmml2om"/>
  </xsl:template>

  <xsl:template match="m:apply[*[1][self::m:limit]][m:lowlimit]" priority="92" mode="cmml2om">
    <OMA>
      <xsl:apply-templates select="*[1]" mode="cmml2om"/>
      <xsl:apply-templates select="m:lowlimit/*" mode="cmml2om"/>
      <OMS cd="limit1" name="above"/>
      <OMBIND>
	<OMS cd="fns1" name="lambda"/>
	<OMBVAR>
	  <xsl:apply-templates select="m:bvar/*" mode="cmml2om"/>
	</OMBVAR>
	<xsl:apply-templates select="*[last()]" mode="cmml2om"/>
      </OMBIND>
    </OMA>
  </xsl:template>


  <xsl:template match="m:vectorproduct" mode="cmml2om">
    <OMS cd="linalg1" name="vectorproduct"/>
  </xsl:template>
  <xsl:template match="m:scalarproduct" mode="cmml2om">
    <OMS cd="linalg1" name="scalarproduct"/>
  </xsl:template>
  <xsl:template match="m:outerproduct" mode="cmml2om">
    <OMS cd="linalg1" name="outerproduct"/>
  </xsl:template>
  <xsl:template match="m:transpose" mode="cmml2om">
    <OMS cd="linalg1" name="transpose"/>
  </xsl:template>
  <xsl:template match="m:determinant" mode="cmml2om">
    <OMS cd="linalg1" name="determinant"/>
  </xsl:template>
  <xsl:template match="m:selector" mode="cmml2om">
    <OMS cd="linalg1" name="matrix_selector"/>
  </xsl:template>
  <xsl:template match="m:apply[*[1][self::m:selector]][count(*)=3]" mode="cmml2om">
    <OMA>
      <OMS cd="linalg1" name="vector_selector"/>
      <xsl:apply-templates select="*[3],*[2]" mode="cmml2om"/>
    </OMA>
  </xsl:template>
  <xsl:template match="m:apply[*[1][self::m:selector]][count(*)=4]" mode="cmml2om">
    <OMA>
      <OMS a="" cd="linalg1" name="matrix_selector"/>
      <xsl:apply-templates select="*[3],*[4],*[2]" mode="cmml2om"/>
    </OMA>
  </xsl:template>
  <xsl:template match="m:matrix_selector" mode="cmml2om">
    <OMS cd="linalg1" name="matrix_selector"/>
  </xsl:template>
  <xsl:template match="m:vector" mode="cmml2om">
    <OMA>
      <OMS cd="linalg2" name="vector"/>
      <xsl:apply-templates select="*" mode="cmml2om"/>
    </OMA>
  </xsl:template>
  <xsl:template match="m:matrixrow" mode="cmml2om">
    <OMA>
      <OMS cd="linalg2" name="matrixrow"/>
      <xsl:apply-templates select="*" mode="cmml2om"/>
    </OMA>
  </xsl:template>
  <xsl:template match="m:matrix" mode="cmml2om">
    <OMA>
      <OMS cd="linalg2" name="matrix"/>
      <xsl:apply-templates select="*" mode="cmml2om"/>
    </OMA>
  </xsl:template>
  <xsl:template match="m:map" mode="cmml2om">
    <OMS cd="list1" name="map"/>
  </xsl:template>
  <xsl:template match="m:suchthat" mode="cmml2om">
    <OMS cd="list1" name="suchthat"/>
  </xsl:template>
  <xsl:template match="m:list" mode="cmml2om">
    <OMA>
      <OMS cd="list1" name="list"/>
      <xsl:apply-templates select="*" mode="cmml2om"/>
    </OMA>
  </xsl:template>
  <xsl:template match="m:equivalent" mode="cmml2om">
    <OMS cd="logic1" name="equivalent"/>
  </xsl:template>
  <xsl:template match="m:not" mode="cmml2om">
    <OMS cd="logic1" name="not"/>
  </xsl:template>
  <xsl:template match="m:and" mode="cmml2om">
    <OMS cd="logic1" name="and"/>
  </xsl:template>
  <xsl:template match="m:xor" mode="cmml2om">
    <OMS cd="logic1" name="xor"/>
  </xsl:template>
  <xsl:template match="m:or" mode="cmml2om">
    <OMS cd="logic1" name="or"/>
  </xsl:template>
  <xsl:template match="m:implies" mode="cmml2om">
    <OMS cd="logic1" name="implies"/>
  </xsl:template>
  <xsl:template match="m:true" mode="cmml2om">
    <OMS cd="logic1" name="true"/>
  </xsl:template>
  <xsl:template match="m:false" mode="cmml2om">
    <OMS cd="logic1" name="false"/>
  </xsl:template>
  <xsl:template match="m:type" mode="cmml2om">
    <OMS cd="mathmltypes" name="type"/>
  </xsl:template>
  <xsl:template match="m:min" mode="cmml2om">
    <OMS cd="minmax1" name="min"/>
  </xsl:template>
  <xsl:template match="m:max" mode="cmml2om">
    <OMS cd="minmax1" name="max"/>
  </xsl:template>
  <xsl:template match="m:apply[*[1][self::m:min|self::m:max]][m:condition]" mode="cmml2om" priority="50">
    <OMA>
      <xsl:apply-templates select="*[1]" mode="cmml2om"/>
      <OMA>
	<OMS cd="set1" name="map"/>
	<OMBIND>
	  <OMS cd="fns1" name="lambda"/>
	  <OMBVAR>
	    <xsl:apply-templates select="m:bvar/*" mode="cmml2om"/>
	  </OMBVAR>
	  <xsl:apply-templates select="*[last()]" mode="cmml2om"/>
	</OMBIND>
	<xsl:apply-templates select="m:condition/*" mode="cmml2om"/>
      </OMA>
    </OMA>
  </xsl:template>
  <xsl:template match="m:card[@type='multiset']" mode="cmml2om">
    <OMS cd="multiset1" name="size"/>
  </xsl:template>
  <xsl:template match="m:cartesianproduct[@type='multiset']" mode="cmml2om">
    <OMS cd="multiset1" name="cartesian_product"/>
  </xsl:template>
  <xsl:template match="m:emptyset[@type='multiset']" mode="cmml2om">
    <OMS cd="multiset1" name="emptyset"/>
  </xsl:template>
  <xsl:template match="m:multiset" mode="cmml2om">
    <OMS cd="multiset1" name="multiset"/>
  </xsl:template>
  <xsl:template match="m:intersect[@type='multiset']" mode="cmml2om">
    <OMS cd="multiset1" name="intersect"/>
  </xsl:template>
  <xsl:template match="m:union[@type='multiset']" mode="cmml2om">
    <OMS cd="multiset1" name="union"/>
  </xsl:template>
  <xsl:template match="m:setdiff[@type='multiset']" mode="cmml2om">
    <OMS cd="multiset1" name="setdiff"/>
  </xsl:template>
  <xsl:template match="m:subset[@type='multiset']" mode="cmml2om">
    <OMS cd="multiset1" name="subset"/>
  </xsl:template>
  <xsl:template match="m:in[@type='multiset']" mode="cmml2om">
    <OMS cd="multiset1" name="in"/>
  </xsl:template>
  <xsl:template match="m:notin[@type='multiset']" mode="cmml2om">
    <OMS cd="multiset1" name="notin"/>
  </xsl:template>
  <xsl:template match="m:prsubset[@type='multiset']" mode="cmml2om">
    <OMS cd="multiset1" name="prsubset"/>
  </xsl:template>
  <xsl:template match="m:notsubset[@type='multiset']" mode="cmml2om">
    <OMS cd="multiset1" name="notsubset"/>
  </xsl:template>
  <xsl:template match="m:notprsubset[@type='multiset']" mode="cmml2om">
    <OMS cd="multiset1" name="notprsubset"/>
  </xsl:template>
  <xsl:template match="m:rational" mode="cmml2om">
    <OMS cd="nums1" name="rational"/>
  </xsl:template>
  <xsl:template match="m:infinity" mode="cmml2om">
    <OMS cd="nums1" name="infinity"/>
  </xsl:template>
  <xsl:template match="m:exponentiale" mode="cmml2om">
    <OMS cd="nums1" name="e"/>
  </xsl:template>
  <xsl:template match="m:imaginaryi" mode="cmml2om">
    <OMS cd="nums1" name="i"/>
  </xsl:template>
  <xsl:template match="m:pi" mode="cmml2om">
    <OMS cd="nums1" name="pi"/>
  </xsl:template>
  <xsl:template match="m:eulergamma" mode="cmml2om">
    <OMS cd="nums1" name="gamma"/>
  </xsl:template>
  <xsl:template match="m:NaN" mode="cmml2om">
    <OMS cd="nums1" name="NaN"/>
  </xsl:template>
  <xsl:template match="m:omtype" mode="cmml2om">
    <OMS cd="omtypes" name="omtype"/>
  </xsl:template>
  <xsl:template match="m:symtype" mode="cmml2om">
    <OMS cd="omtypes" name="symtype"/>
  </xsl:template>
  <xsl:template match="m:integer" mode="cmml2om">
    <OMS cd="omtypes" name="integer"/>
  </xsl:template>
  <xsl:template match="m:float" mode="cmml2om">
    <OMS cd="omtypes" name="float"/>
  </xsl:template>
  <xsl:template match="m:string" mode="cmml2om">
    <OMS cd="omtypes" name="string"/>
  </xsl:template>
  <xsl:template match="m:bytearray" mode="cmml2om">
    <OMS cd="omtypes" name="bytearray"/>
  </xsl:template>
  <xsl:template match="m:piecewise" mode="cmml2om">
    <OMA>
      <OMS cd="piece1" name="piecewise"/>
      <xsl:apply-templates select="*" mode="cmml2om"/>
    </OMA>
  </xsl:template>
  <xsl:template match="m:piece" mode="cmml2om">
    <OMA>
      <OMS cd="piece1" name="piece"/>
      <xsl:apply-templates select="*" mode="cmml2om"/>
    </OMA>
  </xsl:template>
  <xsl:template match="m:otherwise" mode="cmml2om">
    <OMA>
      <OMS cd="piece1" name="otherwise"/>
      <xsl:apply-templates select="*" mode="cmml2om"/>
    </OMA>
  </xsl:template>
  <xsl:template match="m:forall" mode="cmml2om">
    <OMS cd="quant1" name="forall"/>
  </xsl:template>
  <xsl:template match="m:exists" mode="cmml2om">
    <OMS cd="quant1" name="exists"/>
  </xsl:template>
  <xsl:template match="m:eq" mode="cmml2om">
    <OMS cd="relation1" name="eq"/>
  </xsl:template>
  <xsl:template match="m:lt" mode="cmml2om">
    <OMS cd="relation1" name="lt"/>
  </xsl:template>
  <xsl:template match="m:gt" mode="cmml2om">
    <OMS cd="relation1" name="gt"/>
  </xsl:template>
  <xsl:template match="m:neq" mode="cmml2om">
    <OMS cd="relation1" name="neq"/>
  </xsl:template>
  <xsl:template match="m:leq" mode="cmml2om">
    <OMS cd="relation1" name="leq"/>
  </xsl:template>
  <xsl:template match="m:geq" mode="cmml2om">
    <OMS cd="relation1" name="geq"/>
  </xsl:template>
  <xsl:template match="m:approx" mode="cmml2om">
    <OMS cd="relation1" name="approx"/>
  </xsl:template>
  <xsl:template match="m:ceiling" mode="cmml2om">
    <OMS cd="rounding1" name="ceiling"/>
  </xsl:template>
  <xsl:template match="m:floor" mode="cmml2om">
    <OMS cd="rounding1" name="floor"/>
  </xsl:template>
  <xsl:template match="m:trunc" mode="cmml2om">
    <OMS cd="rounding1" name="trunc"/>
  </xsl:template>
  <xsl:template match="m:round" mode="cmml2om">
    <OMS cd="rounding1" name="round"/>
  </xsl:template>
  <xsl:template match="m:mean" mode="cmml2om">
    <OMS cd="s_data1" name="mean"/>
  </xsl:template>
  <xsl:template match="m:sdev" mode="cmml2om">
    <OMS cd="s_data1" name="sdev"/>
  </xsl:template>
  <xsl:template match="m:variance" mode="cmml2om">
    <OMS cd="s_data1" name="variance"/>
  </xsl:template>
  <xsl:template match="m:mode" mode="cmml2om">
    <OMS cd="s_data1" name="mode"/>
  </xsl:template>
  <xsl:template match="m:median" mode="cmml2om">
    <OMS cd="s_data1" name="median"/>
  </xsl:template>
  <xsl:template match="m:moment" mode="cmml2om">
    <OMS cd="s_dist1" name="moment"/>
  </xsl:template>
  <xsl:template match="m:apply[*[1][self::m:moment]]" mode="cmml2om">
    <OMA g="">
      <xsl:apply-templates select="*[1]" mode="cmml2om"/>
      <xsl:choose>
	<xsl:when test="m:degree">
	  <xsl:apply-templates select="m:degree/*" mode="cmml2om"/>
	</xsl:when>
	<xsl:otherwise>
	  <OMI>1</OMI>
	</xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
	<xsl:when test="m:momentabout">
	  <xsl:apply-templates select="m:momentabout/*" mode="cmml2om"/>
	</xsl:when>
	<xsl:otherwise>
	  <OMI>0</OMI>
	</xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="*[last()]" mode="cmml2om"/>
    </OMA>
  </xsl:template>

  <!--
      <xsl:template match="m:mean" mode="cmml2om">
      <OMS cd="s_dist1" name="mean"/>
      </xsl:template>
      <xsl:template match="m:sdev" mode="cmml2om">
      <OMS cd="s_dist1" name="sdev"/>
      </xsl:template>
      <xsl:template match="m:variance" mode="cmml2om">
      <OMS cd="s_dist1" name="variance"/>
      </xsl:template>
      <xsl:template match="m:moment" mode="cmml2om">
      <OMS cd="s_dist1" name="moment"/>
      </xsl:template>
  -->
  <xsl:template match="m:cartesianproduct" mode="cmml2om">
    <OMS cd="set1" name="cartesian_product"/>
  </xsl:template>
  <xsl:template match="m:emptyset" mode="cmml2om">
    <OMS cd="set1" name="emptyset"/>
  </xsl:template>
  <xsl:template match="m:map" mode="cmml2om">
    <OMS cd="set1" name="map"/>
  </xsl:template>
  <xsl:template match="m:card" mode="cmml2om">
    <OMS cd="set1" name="size"/>
  </xsl:template>
  <xsl:template match="m:suchthat" mode="cmml2om">
    <OMS cd="set1" name="suchthat"/>
  </xsl:template>
  <xsl:template match="m:set" mode="cmml2om">
    <OMA>
      <OMS cd="set1" name="set"/>
      <xsl:apply-templates select="*" mode="cmml2om"/>
    </OMA>
  </xsl:template>
  <xsl:template match="m:intersect" mode="cmml2om">
    <OMS cd="set1" name="intersect"/>
  </xsl:template>
  <xsl:template match="m:union" mode="cmml2om">
    <OMS cd="set1" name="union"/>
  </xsl:template>
  <xsl:template match="m:setdiff" mode="cmml2om">
    <OMS cd="set1" name="setdiff"/>
  </xsl:template>
  <xsl:template match="m:subset" mode="cmml2om">
    <OMS cd="set1" name="subset"/>
  </xsl:template>
  <xsl:template match="m:in" mode="cmml2om">
    <OMS cd="set1" name="in"/>
  </xsl:template>
  <xsl:template match="m:notin" mode="cmml2om">
    <OMS cd="set1" name="notin"/>
  </xsl:template>
  <xsl:template match="m:prsubset" mode="cmml2om">
    <OMS cd="set1" name="prsubset"/>
  </xsl:template>
  <xsl:template match="m:notsubset" mode="cmml2om">
    <OMS cd="set1" name="notsubset"/>
  </xsl:template>
  <xsl:template match="m:notprsubset" mode="cmml2om">
    <OMS cd="set1" name="notprsubset"/>
  </xsl:template>
  <xsl:template match="m:P" mode="cmml2om">
    <OMS cd="setname1" name="P"/>
  </xsl:template>
  <xsl:template match="m:N" mode="cmml2om">
    <OMS cd="setname1" name="N"/>
  </xsl:template>
  <xsl:template match="m:Z" mode="cmml2om">
    <OMS cd="setname1" name="Z"/>
  </xsl:template>
  <xsl:template match="m:Q" mode="cmml2om">
    <OMS cd="setname1" name="Q"/>
  </xsl:template>
  <xsl:template match="m:R" mode="cmml2om">
    <OMS cd="setname1" name="R"/>
  </xsl:template>
  <xsl:template match="m:C" mode="cmml2om">
    <OMS cd="setname1" name="C"/>
  </xsl:template>
  <xsl:template match="m:type" mode="cmml2om">
    <OMS cd="sts" name="type"/>
  </xsl:template>
  <xsl:template match="m:mapsto" mode="cmml2om">
    <OMS cd="sts" name="mapsto"/>
  </xsl:template>
  <xsl:template match="m:nary" mode="cmml2om">
    <OMS cd="sts" name="nary"/>
  </xsl:template>
  <xsl:template match="m:nassoc" mode="cmml2om">
    <OMS cd="sts" name="nassoc"/>
  </xsl:template>
  <xsl:template match="m:error" mode="cmml2om">
    <OMS cd="sts" name="error"/>
  </xsl:template>
  <xsl:template match="m:structure" mode="cmml2om">
    <OMS cd="sts" name="structure"/>
  </xsl:template>
  <xsl:template match="m:binder" mode="cmml2om">
    <OMS cd="sts" name="binder"/>
  </xsl:template>
  <xsl:template match="m:attribution" mode="cmml2om">
    <OMS cd="sts" name="attribution"/>
  </xsl:template>
  <xsl:template match="m:Object" mode="cmml2om">
    <OMS cd="sts" name="Object"/>
  </xsl:template>
  <xsl:template match="m:NumericalValue" mode="cmml2om">
    <OMS cd="sts" name="NumericalValue"/>
  </xsl:template>
  <xsl:template match="m:SetNumericalValue" mode="cmml2om">
    <OMS cd="sts" name="SetNumericalValue"/>
  </xsl:template>
  <xsl:template match="m:log" mode="cmml2om">
    <OMS cd="transc1" name="log"/>
  </xsl:template>
  <xsl:template match="m:apply[*[1][self::m:log]][m:logbase]" mode="cmml2om">
    <OMA>
      <OMS cd="transc1" name="log"/>
      <xsl:apply-templates select="m:logbase/*,*[position()!=1] except m:logbase" mode="cmml2om"/>
    </OMA>
  </xsl:template>
  <xsl:template match="m:apply[*[1][self::m:log]][not(m:logbase)]" mode="cmml2om">
    <OMA>
      <OMS cd="transc1" name="log"/>
      <OMI>10</OMI>
      <xsl:apply-templates select="*[position()!=1]" mode="cmml2om"/>
    </OMA>
  </xsl:template>

  <xsl:template match="m:ln" mode="cmml2om">
    <OMS cd="transc1" name="ln"/>
  </xsl:template>
  <xsl:template match="m:exp" mode="cmml2om">
    <OMS cd="transc1" name="exp"/>
  </xsl:template>
  <xsl:template match="m:sin" mode="cmml2om">
    <OMS cd="transc1" name="sin"/>
  </xsl:template>
  <xsl:template match="m:cos" mode="cmml2om">
    <OMS cd="transc1" name="cos"/>
  </xsl:template>
  <xsl:template match="m:tan" mode="cmml2om">
    <OMS cd="transc1" name="tan"/>
  </xsl:template>
  <xsl:template match="m:sec" mode="cmml2om">
    <OMS cd="transc1" name="sec"/>
  </xsl:template>
  <xsl:template match="m:csc" mode="cmml2om">
    <OMS cd="transc1" name="csc"/>
  </xsl:template>
  <xsl:template match="m:cot" mode="cmml2om">
    <OMS cd="transc1" name="cot"/>
  </xsl:template>
  <xsl:template match="m:sinh" mode="cmml2om">
    <OMS cd="transc1" name="sinh"/>
  </xsl:template>
  <xsl:template match="m:cosh" mode="cmml2om">
    <OMS cd="transc1" name="cosh"/>
  </xsl:template>
  <xsl:template match="m:tanh" mode="cmml2om">
    <OMS cd="transc1" name="tanh"/>
  </xsl:template>
  <xsl:template match="m:sech" mode="cmml2om">
    <OMS cd="transc1" name="sech"/>
  </xsl:template>
  <xsl:template match="m:csch" mode="cmml2om">
    <OMS cd="transc1" name="csch"/>
  </xsl:template>
  <xsl:template match="m:coth" mode="cmml2om">
    <OMS cd="transc1" name="coth"/>
  </xsl:template>
  <xsl:template match="m:arcsin" mode="cmml2om">
    <OMS cd="transc1" name="arcsin"/>
  </xsl:template>
  <xsl:template match="m:arccos" mode="cmml2om">
    <OMS cd="transc1" name="arccos"/>
  </xsl:template>
  <xsl:template match="m:arctan" mode="cmml2om">
    <OMS cd="transc1" name="arctan"/>
  </xsl:template>
  <xsl:template match="m:arcsec" mode="cmml2om">
    <OMS cd="transc1" name="arcsec"/>
  </xsl:template>
  <xsl:template match="m:arccsc" mode="cmml2om">
    <OMS cd="transc1" name="arccsc"/>
  </xsl:template>
  <xsl:template match="m:arccot" mode="cmml2om">
    <OMS cd="transc1" name="arccot"/>
  </xsl:template>
  <xsl:template match="m:arcsinh" mode="cmml2om">
    <OMS cd="transc1" name="arcsinh"/>
  </xsl:template>
  <xsl:template match="m:arccosh" mode="cmml2om">
    <OMS cd="transc1" name="arccosh"/>
  </xsl:template>
  <xsl:template match="m:arctanh" mode="cmml2om">
    <OMS cd="transc1" name="arctanh"/>
  </xsl:template>
  <xsl:template match="m:arcsech" mode="cmml2om">
    <OMS cd="transc1" name="arcsech"/>
  </xsl:template>
  <xsl:template match="m:arccsch" mode="cmml2om">
    <OMS cd="transc1" name="arccsch"/>
  </xsl:template>
  <xsl:template match="m:arccoth" mode="cmml2om">
    <OMS cd="transc1" name="arccoth"/>
  </xsl:template>
  <xsl:template match="m:divergence" mode="cmml2om">
    <OMS cd="veccalc1" name="divergence"/>
  </xsl:template>
  <xsl:template match="m:grad" mode="cmml2om">
    <OMS cd="veccalc1" name="grad"/>
  </xsl:template>
  <xsl:template match="m:curl" mode="cmml2om">
    <OMS cd="veccalc1" name="curl"/>
  </xsl:template>
  <xsl:template match="m:laplacian" mode="cmml2om">
    <OMS cd="veccalc1" name="Laplacian"/>
  </xsl:template>


  <xsl:template match="m:notanumber" mode="cmml2om">
    <OMF dec="NaN"/>
  </xsl:template>

  <xsl:template match="m:reals" mode="cmml2om">
    <OMS cd="setname1" name="R"/>
  </xsl:template>

  <xsl:template match="m:complexes" mode="cmml2om">
    <OMS cd="setname1" name="C"/>
  </xsl:template>

  <xsl:template match="m:integers" mode="cmml2om">
    <OMS cd="setname1" name="Z"/>
  </xsl:template>

  <xsl:template match="m:naturalnumbers" mode="cmml2om">
    <OMS cd="setname1" name="N"/>
  </xsl:template>

  <xsl:template match="m:primes" mode="cmml2om">
    <OMS cd="setname1" name="P"/>
  </xsl:template>

  <xsl:template match="m:rationals" mode="cmml2om">
    <OMS cd="setname1" name="Q"/>
  </xsl:template>


  <xsl:template match="m:declare" mode="cmml2om"/>

  <xsl:template match="m:semantics" mode="cmml2om">
    <OMATTR>
      <OMATP>
	<xsl:apply-templates mode="cmml2om" select="m:annotation|m:annotation-xml"/>
      </OMATP>
      <xsl:apply-templates mode="cmml2om" select="*[1]"/>
    </OMATTR>
  </xsl:template>

  <xsl:template match="m:annotation" mode="cmml2om">
    <OMS name="{@encoding}"/>
    <OMSTR><xsl:value-of select="."/></OMSTR>
  </xsl:template>
  <xsl:template match="m:annotation-xml" mode="cmml2om">
    <OMS name="{@encoding}"/>
    <OMFOREIGN><xsl:copy-of select="node()"/></OMFOREIGN>
  </xsl:template>

  <xsl:template match="m:math//m:math" mode="cmml2om">
    <OMS cd="error1" name="nested"/>
  </xsl:template>

  <xsl:template match="m:apply[*[1][self::m:prsubset]][*[3]]" mode="cmml2om">
  <xsl:call-template name="liftedreln"/>
  </xsl:template>

  <xsl:template name="liftedreln">
    <OMA>
      <xsl:variable name="op">
	<xsl:apply-templates select="*[1]" mode="cmml2om"/>
      </xsl:variable>
      <OMS cd="logic1" name="and"/>
      <xsl:for-each select="*[position()!=1 and position()!=last()]">
	<xsl:variable name="p" select="position()"/>
	<OMA>
	  <xsl:copy-of select="$op"/>
	  <xsl:choose>
	    <xsl:when test="position()=1">
	      <xsl:apply-templates select="." mode="cmml2om"/>
	    </xsl:when>
	    <xsl:otherwise>
	      <OMR href="#{generate-id($op)}.{$p}"/>
	    </xsl:otherwise>
	  </xsl:choose>
	  <xsl:variable name="n">
	    <xsl:apply-templates select="following-sibling::*[1]" mode="cmml2om"/>
	  </xsl:variable>
	  <xsl:choose>
	    <xsl:when test="position()=last()">
	      <xsl:copy-of select="$n"/>
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:for-each select="$n/*">
		<xsl:copy>
		  <xsl:copy-of select="@*"/>
		  <xsl:attribute name="id" select="concat(
		    generate-id($op),'.',$p+1)"/>
		</xsl:copy>
	      </xsl:for-each>
	    </xsl:otherwise>
	  </xsl:choose>
	</OMA>
      </xsl:for-each>
    </OMA>
  </xsl:template>

  <xsl:template match="m:apply[*[1][self::m:forall]][m:bvar][m:condition]" mode="cmml2om" priority="20">
    <OMBIND>
      <OMS cd="quant1" name="forall"/>
      <OMBVAR>
	<xsl:apply-templates select="m:bvar/*" mode="cmml2om"/>
      </OMBVAR>
      <OMA>
	<OMS cd="logic1" name="implies"/>
	<xsl:apply-templates select="m:condition/*" mode="cmml2om"/>
	<xsl:apply-templates select="(* except (m:condition|m:bvar))[last()]" mode="cmml2om"/>
      </OMA>
    </OMBIND>
  </xsl:template>

  <xsl:template match="m:apply[*[1][self::m:exists]][m:bvar][m:condition]" mode="cmml2om" priority="21">
    <OMBIND>
      <OMS cd="quant1" name="exists"/>
      <OMBVAR>
	<xsl:apply-templates select="m:bvar/*" mode="cmml2om"/>
      </OMBVAR>
      <OMA>
	<OMS cd="logic1" name="and"/>
	<xsl:apply-templates select="m:condition/*" mode="cmml2om"/>
	<xsl:apply-templates select="(* except (m:condition|m:bvar))[last()]" mode="cmml2om"/>
      </OMA>
    </OMBIND>
  </xsl:template>

  <xsl:template match="m:list[m:bvar][m:condition]" mode="cmml2om" priority="21">
    <OMA><OMS cd="list1" name="suchthat"/>
    <xsl:apply-templates select="(* except (m:condition|m:bvar))[last()]" mode="cmml2om"/>
    <OMBIND>
      <OMS cd="fns1" name="lambda"/>
      <OMBVAR>
	<xsl:apply-templates select="m:bvar/*" mode="cmml2om"/>
      </OMBVAR>
      <xsl:apply-templates select="m:condition/*" mode="cmml2om"/>
    </OMBIND>
    </OMA>
  </xsl:template>

  <xsl:template match="m:set[m:bvar][m:condition]" mode="cmml2om" priority="21">
    <OMA><OMS cd="set1" name="suchthat"/>
    <xsl:apply-templates select="(* except (m:condition|m:bvar))[last()]" mode="cmml2om"/>
    <OMBIND>
      <OMS cd="fns1" name="lambda"/>
      <OMBVAR>
	<xsl:apply-templates select="m:bvar/*" mode="cmml2om"/>
      </OMBVAR>
      <xsl:apply-templates select="m:condition/*" mode="cmml2om"/>
    </OMBIND>
    </OMA>
  </xsl:template>

</xsl:stylesheet>
