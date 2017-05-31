

<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:om="http://www.openmath.org/OpenMath"
  xmlns="http://www.w3.org/1998/Math/MathML"
  xmlns:m="http://www.w3.org/1998/Math/MathML"
  version="2.0"
  exclude-result-prefixes="m om"
>
<xsl:output method="xml" indent="yes"/>

<xsl:include href="omcore.xsl"/>

<xsl:include href="cd/altenc.xsl"/>
<xsl:include href="cd/arith1.xsl"/>
<xsl:include href="cd/arith2.xsl"/>
<xsl:include href="cd/transc1.xsl"/>
<!-- default OK
 <xsl:include href="minmax1.xsl"/>
-->
<xsl:include href="cd/alg1.xsl"/>
<xsl:include href="cd/complex1.xsl"/>
<xsl:include href="cd/integer1.xsl"/>
<xsl:include href="cd/interval1.xsl"/>
<xsl:include href="cd/nums1.xsl"/>
<xsl:include href="cd/rounding1.xsl"/>
<xsl:include href="cd/relation1.xsl"/>
<xsl:include href="cd/calculus1.xsl"/>
<xsl:include href="cd/fns1.xsl"/>
<xsl:include href="cd/quant1.xsl"/>
<xsl:include href="cd/logic1.xsl"/>
<xsl:include href="cd/bigfloat1.xsl"/>
<xsl:include href="cd/list1.xsl"/>
<xsl:include href="cd/limit1.xsl"/>
<xsl:include href="cd/linalg1.xsl"/>
<xsl:include href="cd/linalg2.xsl"/>
<xsl:include href="cd/linalg3.xsl"/>
<xsl:include href="cd/linalg5.xsl"/>
<xsl:include href="cd/set1.xsl"/>
<xsl:include href="cd/s_dist1.xsl"/>
<xsl:include href="cd/setname1.xsl"/>
<xsl:include href="cd/setname2.xsl"/>
<xsl:include href="cd/combinat1.xsl"/>
<xsl:include href="cd/piece1.xsl"/>
<!-- -->
<!-- -->
<xsl:include href="cd/fns2.xsl"/>
<xsl:include href="cd/sts.xsl"/>
<xsl:include href="cd/sts2.xsl"/>
<xsl:include href="cd/list2.xsl"/>

<!-- -->
<xsl:include href="omvar.xsl"/>
<!-- -->


<!-- RIACA CDs -->
<xsl:include href="cd/permgp2.xsl"/>
<xsl:include href="cd/set3.xsl"/>
<xsl:include href="cd/integer2.xsl"/>


<xsl:template match="m:*">
  <xsl:copy>
    <xsl:copy-of select="@*"/>
    <xsl:apply-templates/>
  </xsl:copy>
</xsl:template>

</xsl:stylesheet>
