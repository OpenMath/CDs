
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:om="http://www.openmath.org/OpenMath"
  xmlns="http://www.w3.org/1998/Math/MathML"
  version="1.0"
>




<xsl:template match="om:OMS[@cd='rounding1' and @name='floor']" >
<mrow>
<mo>&#8970;<!-- lfloor--></mo>
<xsl:apply-templates select="following-sibling::*"/>
<mo>&#8971;<!-- rfloor--></mo>
</mrow>
</xsl:template>



<xsl:template match="om:OMS[@cd='rounding1' and @name='ceiling']" >
<mrow>
<mo>&#8968;<!-- lceil--></mo>
<xsl:apply-templates select="following-sibling::*"/>
<mo>&#8969;<!-- rceil--></mo>
</mrow>

</xsl:template>


</xsl:stylesheet>



