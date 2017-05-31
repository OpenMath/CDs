<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:someTrueP-Or="someTrueP-Or"
xmlns:f="http://fxsl.sf.net/"
exclude-result-prefixes="f someTrueP-Or">
  <xsl:import href="func-someTrue.xsl"/>
  <xsl:import href="func-map.xsl"/>
  
  <someTrueP-Or:someTrueP-Or/>
  
  <xsl:variable name="someTrueP-Or:vP-Or" 
   select="document('')/*/someTrueP-Or:*[1]"/>
  
  <xsl:function name="f:someTrueP">
    <xsl:param name="pList" as="item()*"/>
    <xsl:param name="pPredicate" as="element()"/>
    
    <xsl:value-of select="f:someTrue(f:map($pPredicate, $pList))"/>
  </xsl:function>
</xsl:stylesheet>