<xsl:stylesheet version="2.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f"
>
  
  <xsl:template name="compose">
    <xsl:param name="pFun1" select="/.."/>
    <xsl:param name="pFun2" select="/.."/>
    <xsl:param name="pArg1"/>
    
    <xsl:variable name="vrtfFun2">
      <xsl:apply-templates select="$pFun2" mode="f:FXSL">
        <xsl:with-param name="pArg1" select="$pArg1"/>
      </xsl:apply-templates>
    </xsl:variable>
    
    <xsl:apply-templates select="$pFun1" mode="f:FXSL">
      <xsl:with-param name="pArg1" select="$vrtfFun2/node()"/>
    </xsl:apply-templates>
    
  </xsl:template>
</xsl:stylesheet>