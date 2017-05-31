<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:f="http://fxsl.sf.net/"
exclude-result-prefixes="f xs"
>

  <xsl:import href="func-apply.xsl"/>
  
  <xsl:function name="f:filter" as="item()*">
    <xsl:param name="pList"  as="item()*"/>
    <xsl:param name="pController" as="element()"/>
    
    <xsl:sequence select="$pList[f:apply($pController, .)]"/>
  </xsl:function>
</xsl:stylesheet>