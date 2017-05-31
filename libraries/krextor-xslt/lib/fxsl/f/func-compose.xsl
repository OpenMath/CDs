<xsl:stylesheet version="2.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f"
>
  <xsl:import href="func-apply.xsl"/>
  <xsl:import href="func-curry.xsl"/>
  
  <f:compose/>
 <xsl:template match="f:compose" mode="f:FXSL">
   <xsl:param name="arg1" as="element()"/>
   <xsl:param name="arg2" as="element()"/>
   <xsl:param name="arg3"/>
   
   <xsl:sequence select="f:compose($arg1,$arg2,$arg3)"/>
 </xsl:template>

  <xsl:function name="f:compose" as="element()">
   <xsl:sequence select="document('')/*/f:compose[1]"/>
  </xsl:function>

 <xsl:function name="f:compose" as="element()">
   <xsl:param name="arg1" as="element()"/>
   
   <xsl:sequence select="f:curry(f:compose(),3,$arg1)"/>
 </xsl:function>

 <xsl:function name="f:compose" as="element()">
   <xsl:param name="arg1" as="element()"/>
   <xsl:param name="arg2" as="element()"/>
   
   <xsl:sequence select="f:curry(f:compose(),3,$arg1,$arg2)"/>
 </xsl:function>

  <xsl:function name="f:compose">
    <xsl:param name="pFun1" as="element()"/>
    <xsl:param name="pFun2" as="element()"/>
    <xsl:param name="arg1"/>
    
    <xsl:sequence select=
     "f:apply($pFun1, f:apply($pFun2, $arg1))"
    />
  </xsl:function>

</xsl:stylesheet>