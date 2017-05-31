<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:f="http://fxsl.sf.net/"
exclude-result-prefixes="f"
>
    <xsl:import href="func-apply.xsl"/>
    <xsl:import href="func-curry.xsl"/>
    
    <f:map/>
    <xsl:function name="f:map" as="item()*">
      <xsl:param name="pFun" as="element()"/>
      <xsl:param name="pList1" as="item()*"/>

      <xsl:sequence select=
       "for $this in $pList1 return
          f:apply($pFun, $this)"
      />
    </xsl:function>
    
 <xsl:function name="f:map" as="node()">
   <xsl:sequence select="document('')/*/f:map[1]"/>
 </xsl:function>
    
 <xsl:function name="f:map" as="node()">
   <xsl:param name="arg1" as="element()"/>
   
   <xsl:sequence select="f:curry(f:map(),2,$arg1)"/>
 </xsl:function>
 
 <xsl:template match="f:map" mode="f:FXSL">
   <xsl:param name="arg1" as="element()"/>
   <xsl:param name="arg2" as="item()*"/>
   
   <xsl:sequence select="f:map($arg1, $arg2)"/>
 </xsl:template>
</xsl:stylesheet>