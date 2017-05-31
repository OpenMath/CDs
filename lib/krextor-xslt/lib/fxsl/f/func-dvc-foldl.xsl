<xsl:stylesheet version="2.0"
 xmlns:f="http://fxsl.sf.net/"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 exclude-result-prefixes="f">
 
    <xsl:import href="func-apply.xsl"/>
    <xsl:import href="func-drop.xsl"/>
    
    <xsl:function name="f:foldl">
      <xsl:param name="pFunc" as="element()"/>
      <xsl:param name="pA0"/>
      <xsl:param name="pList" as="item()*"/>

      <xsl:sequence select=
       "if(empty($pList))
          then 
             $pA0
          else
             for $vcntList in count($pList) return
               if($vcntList = 1)
                  then
                     f:apply($pFunc, $pA0, $pList[1])
                  else
                     for $vHalfLen in ($vcntList idiv 2) return
                       f:foldl($pFunc, 
                             f:foldl($pFunc, $pA0, $pList[position() le $vHalfLen]),
                             f:drop($vHalfLen, $pList)
                             )"/>

    </xsl:function>

</xsl:stylesheet>