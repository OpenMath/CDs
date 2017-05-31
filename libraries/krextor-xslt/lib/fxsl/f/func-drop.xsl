<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:f="http://fxsl.sf.net/"
exclude-result-prefixes="f xs"
>
  <xsl:function name="f:drop" as="item()*">
    <xsl:param name="pN" as="xs:integer"/>
    <xsl:param name="pList" as="item()*"/>
    
    <xsl:sequence select="$pList[position() > $pN]"/>
  </xsl:function>

</xsl:stylesheet>