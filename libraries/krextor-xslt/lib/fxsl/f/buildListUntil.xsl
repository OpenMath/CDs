<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f"
>
  <xsl:template name="buildListUntil">
    <xsl:param name="pGenerator" select="/.."/>
    <xsl:param name="pController" select="/.."/>
    <xsl:param name="pParam0" select="/.."/>
    <xsl:param name="pParamGenerator" select="/.."/>
    <xsl:param name="pElementName" select="'el'"/>
    <xsl:param name="pList" select="/.."/>

    <xsl:if test="not($pController)">
      <xsl:message terminate="yes">
      [buildListUntil]Error: No pController specified:
         would cause infinite processing.
      </xsl:message>
    </xsl:if>   
    
    <xsl:variable name="vElement">
      <xsl:element name="{$pElementName}">
      <xsl:apply-templates select="$pGenerator" mode="f:FXSL">
        <xsl:with-param name="pParams" select="$pParam0"/>
        <xsl:with-param name="pList" select="$pList"/>
      </xsl:apply-templates>
      </xsl:element>
    </xsl:variable>
    
    <xsl:variable name="newList">
      <xsl:copy-of select="$pList"/>
      <xsl:copy-of select="$vElement/*"/>
    </xsl:variable>
    
    <xsl:variable name="vResultList" select="$newList/*"/>
    
    <xsl:variable name="vShouldStop">
      <xsl:apply-templates select="$pController" mode="f:FXSL">
        <xsl:with-param name="pList" select="$vResultList"/>
        <xsl:with-param name="pParams" select="$pParam0"/>
      </xsl:apply-templates>
    </xsl:variable>
    
    <xsl:choose>
      <xsl:when test="string($vShouldStop)">
        <xsl:copy-of select="$vResultList"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="vNewParams">
          <xsl:apply-templates select="$pParamGenerator" mode="f:FXSL">
	        <xsl:with-param name="pList" select="$vResultList"/>
	        <xsl:with-param name="pParams" select="$pParam0"/>
          </xsl:apply-templates>
        </xsl:variable>
        
        <xsl:call-template name="buildListUntil">
		    <xsl:with-param name="pGenerator" select="$pGenerator"/>
		    <xsl:with-param name="pController" select="$pController"/>
		    <xsl:with-param name="pParam0" select="$vNewParams/*"/>
		    <xsl:with-param name="pParamGenerator" select="$pParamGenerator"/>
		    <xsl:with-param name="pElementName" select="$pElementName"/>
		    <xsl:with-param name="pList" select="$vResultList" />
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>