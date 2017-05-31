<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:f="http://fxsl.sf.net/"
exclude-result-prefixes="f"
>
    <xsl:import href="func-apply.xsl"/>
    
    <xsl:function name="f:scanl">
      <xsl:param name="pFunc" as="element()"/>
      <xsl:param name="pA0"/>
      <xsl:param name="pList" as="item()*"/>

      <xsl:sequence select=
             "$pA0,
             (if (exists($pList))
               then
                 f:scanl($pFunc, 
                         f:apply($pFunc, $pA0, $pList[1]), 
                         $pList[position() > 1]
                         )
               else ()             
             )"
      />
    </xsl:function>

  <xsl:function name="f:scanl1">
    <xsl:param name="pFun" as="element()"/>
    <xsl:param name="pList" as="item()+"/>
    
    <xsl:sequence select="f:scanl($pFun, $pList[1], $pList[position() > 1])"/>
  </xsl:function>
</xsl:stylesheet>