<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="xs f"
>

  <xsl:function name="f:repeat" as="item()+">
    <xsl:param name="pThis" as="item()"/>
    <xsl:param name="pTimes" as="xs:integer"/>
    
    <xsl:for-each select="1 to $pTimes">
      <xsl:sequence select="$pThis"/>
    </xsl:for-each>
  </xsl:function>
</xsl:stylesheet>