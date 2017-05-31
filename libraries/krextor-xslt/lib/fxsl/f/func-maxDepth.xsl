<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:f="http://fxsl.sf.net/"
xmlns:MyMaxDepth="MyMaxDepth"
exclude-result-prefixes="xs f MyMaxDepth"
>
   <xsl:import href="func-map.xsl"/>
   
    <xsl:variable name="vfunMaxDepth" 
                  select="document('')/*/MyMaxDepth:*[1]"/>
     
     <xsl:function name="f:maxDepth" as="xs:integer">
       <xsl:param name="pNode" as="node()"/>
       
       <xsl:value-of select=
       "if (not($pNode/node())) then 0
         else 
          max(f:map($vfunMaxDepth, $pNode/node())) + 1"/>
     </xsl:function>
     
     <MyMaxDepth:MyMaxDepth/>
     <xsl:template match="MyMaxDepth:*" mode="f:FXSL">
       <xsl:param name="arg1" as="node()"/>
       
       <xsl:sequence select="f:maxDepth($arg1)"/>
     </xsl:template>
</xsl:stylesheet>