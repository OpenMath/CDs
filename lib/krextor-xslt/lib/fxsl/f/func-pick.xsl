<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="xs f"
>

 <xsl:import href="func-apply.xsl"/>
 <xsl:import href="func-curry.xsl"/>
 
 <f:pick/>
 
 <xsl:function name="f:pick" as="node()">
   <xsl:param name="pItem" as="item()?"/>
   
   <xsl:sequence select="f:curry(f:pick(), 2, $pItem)"/>
 </xsl:function>
 
 <xsl:function name="f:pick" as="node()">
   <xsl:sequence select="document('')/*/f:pick[1]"/>
 </xsl:function>
 
 <xsl:template match="f:pick" mode="f:FXSL" >
   <xsl:param name="arg2" as="node()"/>
   <xsl:param name="arg1" as="item()?"/>
   
   <xsl:sequence select="f:pick($arg1, $arg2)"/>
 </xsl:template>
 
 <xsl:function name="f:pick" as="item()?">
   <xsl:param name="pCondFun" as="node()"/>
   <xsl:param name="pItem" as="item()?"/>
   
   <xsl:sequence select="$pItem[f:apply($pCondFun, $pItem)]"/>
 </xsl:function>
</xsl:stylesheet>