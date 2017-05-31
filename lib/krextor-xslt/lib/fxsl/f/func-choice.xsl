<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:f="http://fxsl.sf.net/"
exclude-result-prefixes="f xs"
>
    <xsl:import href="func-curry.xsl"/>

    <xsl:function name="f:choice" as="item()*">
      <xsl:param name="arg1" as="item()*"/>
      <xsl:param name="arg2" as="item()*"/>
      <xsl:param name="vals" as="item()*"/>
      <xsl:param name="actVal" as="item()"/>

      <xsl:sequence select=
      "$arg1[$actVal = $vals], 
       $arg2[not($actVal = $vals)]
       "/>
    </xsl:function>
    
 <xsl:function name="f:choice" as="element()">
    <f:choice/>
 </xsl:function>
    
 <xsl:function name="f:choice" as="element()">
   <xsl:param name="arg1" as="item()*"/>
   
   <xsl:sequence select="f:curry(f:choice(),4,$arg1)"/>
 </xsl:function>
 
 <xsl:function name="f:choice" as="element()">
   <xsl:param name="arg1" as="item()*"/>
   <xsl:param name="arg2" as="item()*"/>
   
   <xsl:sequence select="f:curry(f:choice(),4,$arg1,$arg2)"/>
 </xsl:function>
 
 <xsl:function name="f:choice" as="element()">
   <xsl:param name="arg1" as="item()*"/>
   <xsl:param name="arg2" as="item()*"/>
   <xsl:param name="arg3" as="item()*"/>
   
   <xsl:sequence select="f:curry(f:choice(),4,$arg1,$arg2,$arg3)"/>
 </xsl:function>
 
 <xsl:template match="f:choice"  as="item()*"
                mode="f:FXSL">
      <xsl:param name="arg1" as="item()*"/>
      <xsl:param name="arg2" as="item()*"/>
      <xsl:param name="arg3" as="item()*"/>
      <xsl:param name="arg4" as="item()"/>
   
   <xsl:sequence select="f:choice($arg1, $arg2, $arg3,$arg4)"/>
 </xsl:template>
</xsl:stylesheet>