<xsl:stylesheet version="2.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f"
>
   <xsl:template name="str-map">
    <xsl:param name="pFun" select="/.."/>
    <xsl:param name="pStr" select="/.."/>

    <xsl:if test="$pStr">
      <xsl:apply-templates select="$pFun" mode="f:FXSL">
        <xsl:with-param name="arg1" select="substring($pStr, 1, 1)"/>
      </xsl:apply-templates>
      
      <xsl:call-template name="str-map">
        <xsl:with-param name="pFun" select="$pFun"/>
        <xsl:with-param name="pStr" select="substring($pStr, 2)"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>