<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:f="http://fxsl.sf.net/"
xmlns:int="http://fxsl.sf.net/partition/int"
exclude-result-prefixes="f int xs"
>
  <xsl:import href="func-apply.xsl"/>
  
  <xsl:function name="f:partition">
    <xsl:param name="pList" as="item()*"/>
    <xsl:param name="pController" as="element()"/>
    <xsl:param name="pDelim"/>
    
    <xsl:variable name="vS1" select="()"/>
    <xsl:variable name="vS2" select="()"/>
    
    <xsl:sequence select=
    "int:compMap2($pController, $vS1, $vS2, $pList, $pDelim)"/>
  </xsl:function>

  <xsl:function name="f:partition">
    <xsl:param name="pList" as="item()*"/>
    <xsl:param name="pController" as="element()"/>
    <xsl:variable name="pDelim" select="number('x')"/>
    
    <xsl:variable name="vS1" select="()"/>
    <xsl:variable name="vS2" select="()"/>
    
    <xsl:sequence select=
    "int:compMap2($pController, $vS1, $vS2, $pList, $pDelim)"/>
  </xsl:function>

    <xsl:function name="int:compMap2">
      <xsl:param name="pFunc" as="element()"/>
      <xsl:param name="pResult1"/>
      <xsl:param name="pResult2"/>
      <xsl:param name="pList" as="item()*"/>
      <xsl:param name="pDelim"/>
      
      <xsl:sequence select=
      "if(empty($pList))
         then 
           $pResult1, $pDelim, $pResult2
         else
           for $vLast in $pList[last()] return
             for $vLastHolds in f:apply($pFunc, $vLast) return
               int:compMap2($pFunc,
                            if($vLastHolds)
                               then insert-before($pResult1, 1, $vLast)
                               else $pResult1,
                            if(not($vLastHolds))
                               then insert-before($pResult2, 1, $vLast)
                               else $pResult2,
                            $pList[position() &lt; last()],
                            $pDelim
                             )"
      />
    </xsl:function>
</xsl:stylesheet>