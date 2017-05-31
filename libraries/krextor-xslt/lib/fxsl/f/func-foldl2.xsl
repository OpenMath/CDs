<xsl:stylesheet version="2.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f"
>
    <xsl:import href="func-apply2.xsl"/>
    
    <xsl:function name="f:foldl2">
      <xsl:param name="pFunc" as="element()"/>
      <xsl:param name="pA0"/>
      <xsl:param name="pList" as="item()*"/>

      <xsl:sequence select=
             "if (empty($pList))
                  then 
                      $pA0
                  else
                      f:foldl2($pFunc, 
                              f:apply2($pFunc, ($pA0, $pList[1])), 
                              $pList[position() > 1]
                              )"/>
    </xsl:function>
</xsl:stylesheet>