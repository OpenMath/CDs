<xsl:stylesheet version="2.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f"
>
    <xsl:import href="func-apply.xsl"/>
    
    <xsl:function name="f:foldr">
      <xsl:param name="pFunc" as="element()"/>
      <xsl:param name="pA0"/>
      <xsl:param name="pList" as="item()*"/>

      <xsl:sequence select=
             "if (empty($pList))
                  then 
                      $pA0
                  else
                      f:foldr($pFunc, 
                              f:apply($pFunc, $pList[last()], $pA0), 
                              $pList[position() &lt; last()]
                              )"/>
    </xsl:function>
</xsl:stylesheet>