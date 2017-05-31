<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:f="http://fxsl.sf.net/"
exclude-result-prefixes="f xs"
>
  <xsl:import href="func-map.xsl"/>
  <xsl:import href="func-allTrue.xsl"/>

  <f:allTrueP/>
  <xsl:template match="f:allTrueP" mode="f:FXSL">
    <xsl:param name="arg1" as="node()*"/>
    <xsl:param name="arg2" as="element()"/>
    
    <xsl:sequence select="f:allTrueP($arg1, $arg2)"/>
  </xsl:template>
  
  <xsl:function name="f:allTrueP" as="node()">
    <xsl:sequence select="document('')/*/f:allTrueP[1]"/>
  </xsl:function>
  
  <xsl:function name="f:allTrueP" as="xs:boolean">
    <xsl:param name="pList" as="item()*"/>
    <xsl:param name="pPredicate" as="element()"/>

    <xsl:value-of 
      select="f:allTrue(f:map($pPredicate, $pList))"/>
  </xsl:function>
</xsl:stylesheet>