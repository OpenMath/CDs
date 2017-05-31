

<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:om="http://www.openmath.org/OpenMath"
  xmlns="http://www.w3.org/1998/Math/MathML"
  version="1.0"
>

<xsl:template match="om:OMS[@cd='transc1' and @name='log']"  priority="2">
 <mrow>
  <msub><mi>log</mi><xsl:apply-templates select="following-sibling::*[1]"/></msub>
  <mo><!-- AF --></mo>
   <mfenced><xsl:apply-templates select="following-sibling::*[2]"/></mfenced>
 </mrow>
</xsl:template>

<xsl:template match="om:OMS[@cd='transc1' and @name='exp']"  priority="2">
  <msup>
    <mi>e</mi>
    <xsl:apply-templates select="following-sibling::*[1]"/>
  </msup>
</xsl:template>



<xsl:template match="om:OMA[om:OMV|om:OMF]/om:OMS[@cd='transc1']"  >
<mrow>
  <mi><xsl:value-of  select="@name"/></mi>
  <mo><!-- AF --></mo>
 <xsl:apply-templates select="following-sibling::*"/>
</mrow>
</xsl:template>

</xsl:stylesheet>

