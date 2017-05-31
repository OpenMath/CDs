<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:f="http://fxsl.sf.net/"
exclude-result-prefixes="f"
>
  <xsl:import href="PartialSumsList.xsl"/>
  
  <xsl:template name="simpleIntegration">
    <xsl:param name="pFun" select="/.."/>
    <xsl:param name="pA"/>
    <xsl:param name="pB"/>
    <xsl:param name="pEpsRough" select="0.0001"/>

     <xsl:variable name="vrtfRoughResults">
	    <xsl:call-template name="partialSumsList">
		    <xsl:with-param name="pFun" select="$pFun"/>
		    <xsl:with-param name="pA" select="$pA"/>
		    <xsl:with-param name="pB" select="$pB"/>
		    <xsl:with-param name="pEps" select="$pEpsRough"/>
	    </xsl:call-template>
     </xsl:variable>

   	 <xsl:copy-of select="$vrtfRoughResults/node()"/>
	
  </xsl:template>

</xsl:stylesheet>