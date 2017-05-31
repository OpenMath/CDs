<xsl:stylesheet version="2.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 xmlns:int="http://fxsl.sf.net/dvc-scanl/int"
 exclude-result-prefixes="f int xs"
>
  <xsl:import href="func-apply.xsl"/>
  
  <xsl:function name="f:scanl" as="item()*">
    <xsl:param name="pFun" as="element()"/>
    <xsl:param name="pQ0"/>
    <xsl:param name="pList" as="item()*"/>
    
    <xsl:sequence select="int:scanl($pFun, $pQ0, $pList, 1)"/>
  </xsl:function>    
  
  <xsl:function name="int:scanl" as="item()*">
    <xsl:param name="pFun" as="element()"/>
    <xsl:param name="pQ0"/>
    <xsl:param name="pList" as="item()*"/>
    <xsl:param name="pStarting" as="xs:integer"/>
    
    <xsl:variable name="vLength" select="count($pList)"/>
    
    <xsl:choose>
      <xsl:when test="$vLength > 1">
        <xsl:variable name="vHalf" select="$vLength idiv 2"/>

        <xsl:variable name="vResult1" 
           select="int:scanl($pFun, 
                             $pQ0, 
                             $pList[position() &lt;= $vHalf], 
                             $pStarting
                             )"/>
	      <xsl:sequence select=
         "($vResult1,
           int:scanl($pFun,
                     $vResult1[last()],
                     $pList[position() > $vHalf],
                     0)
          )"
         />
      </xsl:when>

      <xsl:otherwise>
		    <xsl:if test="$pStarting">
			    <xsl:sequence select="$pQ0"/>
		    </xsl:if>
    
        <xsl:if test="exists($pList)">
          <xsl:sequence select="f:apply($pFun, $pQ0, $pList[1])"/>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>
  
  <xsl:function name="f:scanl1">
    <xsl:param name="pFun" as="element()"/>
    <xsl:param name="pList" as="item()+"/>
    
    <xsl:sequence select="int:scanl($pFun, $pList[1], $pList[position() > 1], 1)"/>
  </xsl:function>
</xsl:stylesheet>