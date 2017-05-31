<xsl:stylesheet version="2.0"
 xmlns:f="http://fxsl.sf.net/"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 exclude-result-prefixes="f">
 
    <xsl:import href="func-apply.xsl"/>
 
    <xsl:function name="f:foldl">
      <xsl:param name="pFunc" as="element()"/>
      <xsl:param name="pA0"/>
      <xsl:param name="pList" as="item()*"/>

      <xsl:choose>
         <xsl:when test="not($pList)">
            <xsl:copy-of select="$pA0"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:variable name="vcntList" select="count($pList)"/>
            <xsl:choose>
              <xsl:when test="$vcntList = 1">
                <xsl:sequence select="f:apply($pFunc,$pA0, $pList[1])"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:variable name="vHalfLen"
                              select="floor($vcntList div 2)"/>

                <xsl:sequence select=
                "f:foldl($pFunc, 
                         f:foldl($pFunc, $pA0, $pList[position() &lt;= $vHalfLen]),
                         $pList[position() > $vHalfLen] 
                         )"/>
              </xsl:otherwise>
            </xsl:choose>
         </xsl:otherwise>
      </xsl:choose>
    </xsl:function>
</xsl:stylesheet>