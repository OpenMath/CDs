<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:f="http://fxsl.sf.net/"
exclude-result-prefixes="f xs"
>
    <xsl:import href="func-map.xsl"/>
    <xsl:import href="func-flip.xsl"/>
    <xsl:import href="func-curry.xsl"/>
    
    <xsl:function name="f:multiMap" as="item()*">
      <xsl:param name="pDelimElem" as="element()"/>
      <xsl:param name="pFunList" as="element()*"/>
      <xsl:param name="pArgList" as="item()*"/>

      <xsl:sequence select=
       "($pDelimElem,
            for $arg in $pArgList
                 return
                   (
                    f:map(f:flip(f:map(),$arg), $pFunList),
                    $pDelimElem
                    )
         )
       "
       />
    </xsl:function>
    
 <xsl:function name="f:multiMap" as="element()">
    <f:multiMap/>
 </xsl:function>
    
 <xsl:function name="f:multiMap" as="element()">
   <xsl:param name="arg1" as="element()"/>
   
   <xsl:sequence select="f:curry(f:multiMap(),3,$arg1)"/>
 </xsl:function>
 
 <xsl:function name="f:multiMap" as="element()">
   <xsl:param name="arg1" as="element()"/>
   <xsl:param name="arg2" as="element()*"/>
   
   <xsl:sequence select="f:curry(f:multiMap(),3,$arg1, $arg2)"/>
 </xsl:function>
 
 <xsl:template match="f:multiMap"  as="item()*"
                mode="f:FXSL">
      <xsl:param name="arg1" as="element()"/>
      <xsl:param name="arg2" as="element()*"/>
      <xsl:param name="arg3" as="item()*"/>
   
   <xsl:sequence select="f:multiMap($arg1, $arg2, $arg3)"/>
 </xsl:template>
</xsl:stylesheet>