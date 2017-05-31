<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="xs f"
>

 <xsl:import href="func-Operators.xsl"/>
 <xsl:import href="func-partitionCC.xsl"/>
 
 <xsl:function name="f:qsort" as="item()*">
   <xsl:param name="pSeq"/>
    
   <xsl:if test="exists($pSeq)">
     <xsl:variable name="v1st" select="$pSeq[1]"/>
      
     <xsl:variable name="vTail" select="remove($pSeq, 1)" as="item()*"/>
     
<!--
     <xsl:sequence select="f:qsort(f:filter($vTail, f:gt($v1st)) ), 
                           $v1st,
                           f:qsort(f:filter($vTail, f:le($v1st)) )
      "/>
-->      
      <xsl:sequence select=
        "f:partitionCC($vTail, f:gt($v1st), $v1st, f:qsort(), f:qsort())"/>
   </xsl:if>
 </xsl:function>
 
 <xsl:variable name="vfunQSort" as="element()">
   <f:qsort/>
 </xsl:variable>
 
 <xsl:function name="f:qsort" as="item()*">
   <xsl:sequence select="$vfunQSort"/>
 </xsl:function>
 
 <xsl:template match="f:qsort" as="item()*" mode="f:FXSL">
   <xsl:param name="arg1" as="item()*"/>
   <xsl:sequence select="f:qsort($arg1)"/>
 </xsl:template>
</xsl:stylesheet>