<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:f="http://fxsl.sf.net/"
exclude-result-prefixes="f xs"
>
  <xsl:import href="func-foldr.xsl"/>
  <xsl:import href="func-Operators.xsl"/>
  
  <xsl:function name="f:someTrue">
    <xsl:param name="pList" as="item()*"/>
    
    <xsl:sequence select="f:foldr(f:or(), false(), $pList)"/>
  </xsl:function>
</xsl:stylesheet>