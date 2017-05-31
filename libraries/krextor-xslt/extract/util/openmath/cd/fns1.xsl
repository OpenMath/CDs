

<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:om="http://www.openmath.org/OpenMath"
  xmlns="http://www.w3.org/1998/Math/MathML"
  version="1.0"
>




<xsl:template match="om:OMS[@cd='fns1' and @name='identity']" >
  <xsl:call-template name="prefix">
   <xsl:with-param name="mo">
    <mi>Id</mi>
   </xsl:with-param>
  </xsl:call-template>
</xsl:template>


<xsl:template match="om:OMS[@cd='fns1' and @name='inverse']" >
<xsl:call-template name="msup">
 <xsl:with-param name="script">
   <mn>-1</mn>
  </xsl:with-param>
</xsl:call-template>
</xsl:template>

<xsl:template match="om:OMS[@cd='fns1' and @name='left_compose']" >
  <xsl:param name="p"/>
  <xsl:call-template name="infix">
    <xsl:with-param name="mo"><mo>o</mo></xsl:with-param>
    <xsl:with-param name="p" select="$p"/>
    <xsl:with-param name="this-p" select="2"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="om:OMS[@cd='fns1' and @name='lambda']">
  <xsl:call-template name="prefix">
    <xsl:with-param name="mo"><mo>&#x3BB;</mo></xsl:with-param>
  </xsl:call-template>
</xsl:template>


</xsl:stylesheet>



