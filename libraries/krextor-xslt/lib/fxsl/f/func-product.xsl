<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:f="http://fxsl.sf.net/"
exclude-result-prefixes="f xs"
>
   <xsl:import href="func-foldl.xsl"/>
   <xsl:import href="../f/func-Operators.xsl"/>

    <xsl:function name="f:product">
      <xsl:param name="pList"/>
      <xsl:sequence select="f:foldl(f:mult(), 1, $pList)"/>
    </xsl:function>

</xsl:stylesheet>