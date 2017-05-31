<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f"
>
  <xsl:import href="func-apply.xsl"/>
  
  <xsl:function name="f:zipWith3">
    <xsl:param name="pFun" as="element()"/>
    <xsl:param name="pList1" as="item()*"/>
    <xsl:param name="pList2" as="item()*"/>
    <xsl:param name="pList3" as="item()*"/>

    <xsl:sequence select=
     "if(exists($pList1) and exists($pList2) and exists($pList3))
       then (f:apply($pFun, $pList1[1], $pList2[1], $pList3[1]))
             , 
             f:zipWith3($pFun, 
                       $pList1[position()>1], 
                       $pList2[position()>1],
                       $pList3[position()>1]
                       )
       else ()"
     />
  </xsl:function>
</xsl:stylesheet>