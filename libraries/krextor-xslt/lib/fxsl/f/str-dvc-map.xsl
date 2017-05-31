<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:f="http://fxsl.sf.net/"
exclude-result-prefixes="f"
>
   <xsl:template name="str-map">
    <xsl:param name="pFun" select="/.."/>
    <xsl:param name="pStr" select="/.."/>
    
    <xsl:if test="$pStr">
      <xsl:variable name="vLen" select="string-length($pStr)"/>
      <xsl:choose>
        <xsl:when test="$vLen = 1">
          <xsl:apply-templates select="$pFun" mode="f:FXSL">
            <xsl:with-param name="arg1" select="$pStr"/>
          </xsl:apply-templates>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="vHLen" select="floor($vLen div 2)"/>
          
          <xsl:call-template name="str-map">
            <xsl:with-param name="pFun" select="$pFun"/>
            <xsl:with-param name="pStr" select="substring($pStr, 1, $vHLen)"/>
          </xsl:call-template>
          
          <xsl:call-template name="str-map">
            <xsl:with-param name="pFun" select="$pFun"/>
            <xsl:with-param name="pStr" select="substring($pStr, $vHLen + 1)"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>