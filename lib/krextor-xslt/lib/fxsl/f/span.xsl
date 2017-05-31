<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:f="http://fxsl.sf.net/"
exclude-result-prefixes="f"
>
  <xsl:import href="takeWhile.xsl"/>
  
  <xsl:template name="span">
    <xsl:param name="pList" select="/.."/>
    <xsl:param name="pController" select="/.."/>
    <xsl:param name="pContollerParam" select="/.."/>
    <xsl:param name="pParam0" select="/.."/>
    <xsl:param name="pElementName" select="'list'"/>
    
    <xsl:variable name="vRTF-Positive">
	    <xsl:call-template name="takeWhile">
		    <xsl:with-param name="pList" select="$pList"/>
		    <xsl:with-param name="pController" select="$pController"/>
		    <xsl:with-param name="pContollerParam" select="$pContollerParam"/>
		    <xsl:with-param name="pParam0" select="$pParam0"/>
	    </xsl:call-template>
    </xsl:variable>
    
    <xsl:variable name="vPositive" select="$vRTF-Positive/*"/>
    
    <xsl:element name="{$pElementName}">
      <xsl:copy-of select="$vPositive"/>
    </xsl:element>
    <xsl:element name="{$pElementName}">
	    <xsl:copy-of select="$pList[position() > count($vPositive)]"/>
    </xsl:element>
  </xsl:template>
</xsl:stylesheet>