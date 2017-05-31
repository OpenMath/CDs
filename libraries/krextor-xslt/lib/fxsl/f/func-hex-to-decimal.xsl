<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 xmlns:hex-converter="http://fxsl.sf.net/hex-converter"
 exclude-result-prefixes="f xs hex-converter"
>
  <xsl:import href="func-str-foldl.xsl"/>
  
  <hex-converter:hex-converter/>
  
  <xsl:variable name="f:hexDigits" select="'0123456789ABCDEF'"/>
  
  <xsl:function name="f:hex-to-decimal" as="xs:integer">
    <xsl:param name="pxNumber"/>
    
    <xsl:variable name="vFunXConvert" 
                  select="document('')/*/hex-converter:*[1]"/>
    
    <xsl:value-of select="f:str-foldl($vFunXConvert, 0, $pxNumber)"/>
  </xsl:function>
  
  <xsl:function name="f:hex-to-decimal" as="element()">
    <f:hex-to-decimal/>
  </xsl:function>
  
  <xsl:template match="f:hex-to-decimal" as="xs:integer" mode="f:FXSL">
    <xsl:param name="arg1"/>
    <xsl:sequence select="f:hex-to-decimal($arg1)"/>
  </xsl:template> 
  
  <xsl:template match="hex-converter:*" mode="f:FXSL" as="xs:integer">
    <xsl:param name="arg1"/> <!-- $pA0 -->
    <xsl:param name="arg2"/> <!-- a char (digit) -->
    
    <xsl:value-of select="16 * $arg1 
                        + string-length(substring-before($f:hexDigits, $arg2))"/>
  </xsl:template>
</xsl:stylesheet>