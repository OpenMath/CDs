<xsl:stylesheet version="2.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f"
>

  <xsl:import href="func-apply.xsl"/>
  <xsl:import href="func-curry.xsl"/>

  <f:flip/>
  <xsl:function name="f:flip" as="element()">
    <xsl:sequence select="document('')/*/f:flip[1]"/>
  </xsl:function>
  
  <xsl:function name="f:flip">
   <xsl:param name="pFunc" as="element()"/>
   <xsl:param name="arg1" />
   <xsl:param name="arg2"/>
   
   <xsl:sequence select="f:apply($pFunc, $arg2, $arg1)"/>
  </xsl:function>
  
  <xsl:function name="f:flip" as="element()">
   <xsl:param name="pFunc" as="element()"/>
   
   <xsl:sequence select="f:curry(f:flip(), 3, $pFunc)"/>
  </xsl:function>
  
  <xsl:template match="f:flip" mode="f:FXSL">
    <xsl:param name="arg1"/>
    <xsl:param name="arg2"/>
    <xsl:param name="arg3"/>
    <xsl:sequence select="f:flip($arg1, $arg2, $arg3)"/>
  </xsl:template>
  
  <xsl:function name="f:flip" as="element()">
   <xsl:param name="pFunc" as="element()"/>
   <xsl:param name="arg1" />
   
   <xsl:sequence select="f:curry(f:flip(), 3, $pFunc, $arg1)"/>
  </xsl:function>
  
</xsl:stylesheet>