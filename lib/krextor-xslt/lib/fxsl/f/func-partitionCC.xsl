<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:f="http://fxsl.sf.net/"
xmlns:int="http://fxsl.sf.net/partition/int"
exclude-result-prefixes="f int xs"
>
  <xsl:import href="func-partition.xsl"/>
  
  <xsl:function name="f:partitionCC">
    <xsl:param name="pList" as="item()*"/>
    <xsl:param name="pController" as="element()"/>
    <xsl:param name="pDelim" as="item()"/>
    <xsl:param name="pFunL" as="element()"/>
    <xsl:param name="pFunR" as="element()"/>
    
    <xsl:variable name="vS1" select="()"/>
    <xsl:variable name="vS2" select="()"/>
    
    <xsl:sequence select=
    "int:compMapCC2($pController, $vS1, $vS2, $pList, $pDelim, $pFunL, $pFunR)"/>
  </xsl:function>

    <xsl:function name="int:compMapCC2">
      <xsl:param name="pFunc" as="element()"/>
      <xsl:param name="pResult1"/>
      <xsl:param name="pResult2"/>
      <xsl:param name="pList" as="item()*"/>
      <xsl:param name="pDelim" as="item()"/>
	    <xsl:param name="pFunL" as="element()"/>
	    <xsl:param name="pFunR" as="element()"/>
<!--	    
	    <xsl:message>
	     Result1: <xsl:sequence select="$pResult1"/>
	     Result2: <xsl:sequence select="$pResult2"/>
	     Delim: '<xsl:sequence select="$pDelim"/>'
	    </xsl:message>
-->      
      <xsl:sequence select=
       "if(empty($pList))
         then 
           f:apply($pFunL,$pResult1), $pDelim, f:apply($pFunR,$pResult2)
         else
           for $vLast in $pList[last()] return
             for $vLastHolds in f:apply($pFunc, $vLast) return
               int:compMapCC2($pFunc,
                            if($vLastHolds)
                               then ($pResult1, $vLast)
                               else $pResult1,
                            if(not($vLastHolds))
                               then ($pResult2, $vLast)
                               else $pResult2,
                            $pList[position() &lt; last()],
                            $pDelim,
                            $pFunL,
                            $pFunR
                             )"

      />
    </xsl:function>
</xsl:stylesheet>