<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f xs"
>
  <xsl:import href="func-apply.xsl"/>
  
  <xsl:function name="f:zipWith">
    <xsl:param name="pFun" as="element()"/>
    <xsl:param name="pList1" as="item()*"/>
    <xsl:param name="pList2" as="item()*"/>

    <xsl:sequence select=
     "if(exists($pList1) and exists($pList2))
       then (f:apply($pFun, $pList1[1], $pList2[1])
             , 
             f:zipWith($pFun, $pList1[position()>1], $pList2[position()>1])
             )
       else ()"
     />
  </xsl:function>
  
  <xsl:function name="f:str-zipWith">
    <xsl:param name="pFun" as="element()"/>
    <xsl:param name="pList1" as="xs:string*"/>
    <xsl:param name="pList2" as="xs:string*"/>

    <xsl:sequence select=
     "if(string-length($pList1) > 0 and string-length($pList2) > 0)
       then concat(
             f:apply($pFun, substring($pList1,1,1), substring($pList2,1,1))
             , 
             f:str-zipWith($pFun,substring($pList1,2), substring($pList2,2))
             )
       else ()"
     />
  </xsl:function>
</xsl:stylesheet>