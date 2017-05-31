<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>
 
  <xsl:import href="map.xsl"/>
  
  
  <xsl:template name="partition">
    <xsl:param name="pList" select="/.."/>
    <xsl:param name="pController" select="/.."/>
    <xsl:param name="pElementName" select="'list'"/>
    
    <xsl:variable name="vHoldsListRTF">
      <xsl:call-template name="map">
	      <xsl:with-param name="pFun" select="$pController"/>
	      <xsl:with-param name="pList1" select="$pList"/>
      </xsl:call-template>
    </xsl:variable>
    
    <xsl:variable name="vHoldsList" select="$vHoldsListRTF/*"/>
    
    <xsl:element name="{$pElementName}">
      <xsl:for-each select="$vHoldsList">
        <xsl:variable name="vPosition" select="position()"/>
        <xsl:if test="string(.)">
          <xsl:copy-of select="$pList[position()=$vPosition]"/>
        </xsl:if>
      </xsl:for-each>
    </xsl:element>
    
    <xsl:element name="{$pElementName}">
      <xsl:for-each select="$vHoldsList">
        <xsl:variable name="vPosition" select="position()"/>
        <xsl:if test="not(string(.))">
          <xsl:copy-of select="$pList[position()=$vPosition]"/>
        </xsl:if>
      </xsl:for-each>
    </xsl:element>
  </xsl:template>
</xsl:stylesheet>