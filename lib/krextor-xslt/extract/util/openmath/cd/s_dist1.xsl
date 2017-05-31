

<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:om="http://www.openmath.org/OpenMath"
  xmlns="http://www.w3.org/1998/Math/MathML"
  version="1.0"
>

  <xsl:template match="om:OMS[@cd='s_dist1' and @name='moment']">
    <msub>
      <mrow>
	<mo>&#x27E8;</mo>
	<xsl:choose>
	  <xsl:when test="following-sibling::*[1]='1'">
	    <xsl:apply-templates select="following-sibling::*[3]"/>
	  </xsl:when>
	  <xsl:otherwise>
	    <msup>
	      <xsl:apply-templates select="following-sibling::*[3]"/>
	      <xsl:apply-templates select="following-sibling::*[1]"/>
	    </msup>
	  </xsl:otherwise>
	</xsl:choose>
	<mo>&#x27E9;</mo>
      </mrow>
      <xsl:apply-templates select="following-sibling::*[2]"/>
    </msub>
  </xsl:template>

</xsl:stylesheet>