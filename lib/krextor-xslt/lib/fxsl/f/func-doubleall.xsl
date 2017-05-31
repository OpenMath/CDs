<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:f="http://fxsl.sf.net/"
xmlns:doubleall="doubleall"
exclude-result-prefixes="f doubleall"
>
   <xsl:import href="func-map.xsl"/>
   
   <doubleall:doubleall/>
   
   <xsl:function name="f:doubleall">
     <xsl:param name="pList" as="node()*"/>
     
     <xsl:variable name="vFunDouble" select="document('')/*/doubleall:*[1]"/>
     
     <xsl:copy-of select="f:map($vFunDouble, $pList)"/>
   </xsl:function>

    <xsl:template name="double" match="*[namespace-uri() = 'doubleall']"
     mode="f:FXSL">
      <xsl:param name="arg1"/>
      
      <xsl:value-of select="2 * $arg1"/>
    </xsl:template>
</xsl:stylesheet>