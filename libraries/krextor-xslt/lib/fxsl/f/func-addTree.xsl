<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:f="http://fxsl.sf.net/"
exclude-result-prefixes="xs f"
>
   <xsl:import href="func-foldl-tree.xsl"/>
   <xsl:import href="func-Operators.xsl"/>
    
   <f:add-tree/>
   <xsl:template match="f:add-tree" mode="f:FXSL">
     <xsl:param name="arg1"/>
     <xsl:sequence select="f:add-tree($arg1)"/>
   </xsl:template>
   
   <xsl:function name="f:add-tree" as="node()">
     <xsl:sequence select="document('')/*/f:add-tree[1]"/>
   </xsl:function>
   
   <xsl:function name="f:add-tree" as="xs:double">
      <xsl:param name="pRoot" as="element()"/>
      
      <xsl:value-of select=
       "f:foldl-tree(f:add(), f:add(), 0, $pRoot)"
       />
    </xsl:function>
</xsl:stylesheet>