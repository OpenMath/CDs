<xsl:stylesheet version="2.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f"
>
	<xsl:import href="func-map.xsl"/>
	
	<xsl:function name="f:closure" as="node()*">
		<xsl:param name="pFun" as="element()"/>
		<xsl:param name="pstartSet" as="node()*"/>
		
		<xsl:sequence select="f:closure2($pFun, $pstartSet,$pstartSet)"/>
	</xsl:function>
	
	<xsl:function name="f:closure2" as="node()*">
		<xsl:param name="pFun" as="element()"/>
		<xsl:param name="pCurClosure" as="node()*"/>
		<xsl:param name="pstartSet" as="node()*"/>
		
		<xsl:if test="exists($pstartSet)">
			<xsl:variable name="vNew" select=
		      "f:map($pFun,$pstartSet) except $pCurClosure"/>
			<xsl:sequence select=
		       "$pstartSet 
		       | $vNew 
		       | f:closure2($pFun,$pCurClosure | $vNew, $vNew)"/>
		</xsl:if>
	</xsl:function>
	
	<xsl:function name="f:closure" as="node()">
		<xsl:param name="pFun" as="element()"/>
		
		<xsl:sequence select="f:curry(f:closure(), 2, $pFun)"/>
	</xsl:function>
	
	<xsl:function name="f:closure" as="element()">
		<f:closure/>
	</xsl:function>
	
	<xsl:template match="f:closure" mode="f:FXSL"
	 as="node()*">
		<xsl:param name="arg1" as="element()"/>
		<xsl:param name="arg2" as="node()*"/>
		
		<xsl:sequence select="f:closure($arg1,$arg2)"/>
	</xsl:template>
</xsl:stylesheet>