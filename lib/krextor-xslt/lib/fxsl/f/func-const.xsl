<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:f="http://fxsl.sf.net/"
exclude-result-prefixes="f xs"
>
    <xsl:import href="func-curry.xsl"/>

    <xsl:function name="f:const" as="item()*">
      <xsl:param name="pConst" as="item()*"/>
      <xsl:param name="pArg" as="item()*"/>

      <xsl:sequence select="$pConst"/>
    </xsl:function>
    
 <xsl:function name="f:const" as="element()">
    <f:const/>
 </xsl:function>
    
 <xsl:function name="f:const" as="element()">
   <xsl:param name="arg1" as="item()*"/>
   
   <xsl:sequence select="f:curry(f:const(),2,$arg1)"/>
 </xsl:function>
 
 <xsl:template match="f:const"  as="item()*"
                mode="f:FXSL">
      <xsl:param name="arg1" as="item()*"/>
      <xsl:param name="arg2" as="item()*"/>
   
   <xsl:sequence select="f:const($arg1, $arg2)"/>
 </xsl:template>
</xsl:stylesheet>