<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:f="http://fxsl.sf.net/"
exclude-result-prefixes="f"
>
    <xsl:template name="map">
      <xsl:param name="pFun" select="/.."/>
      <xsl:param name="pList1" select="/.."/>
      
      <xsl:for-each select="$pList1">
        <xsl:copy>
          <xsl:apply-templates select="$pFun" mode="f:FXSL">
            <xsl:with-param name="arg1" select="."/>
          </xsl:apply-templates>
        </xsl:copy>
      </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>