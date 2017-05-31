<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:f="http://fxsl.sf.net/"
exclude-result-prefixes="f"
>
 
  <xsl:template name="buildListWhileMap">
    <xsl:param name="pGenerator" select="/.."/>
    <xsl:param name="pParam0" select="/.."/>
    <xsl:param name="pController" select="/.."/>
    <xsl:param name="pContollerParam" select="/.."/>
    <xsl:param name="pMap" select="/.."/>
    <xsl:param name="pMapParams" select="/.."/>
    <xsl:param name="pElementName" select="'el'"/>
    <xsl:param name="pList" select="/.."/>
    <xsl:param name="pBaseList" select="/.."/>

    <xsl:if test="not($pController)">
      <xsl:message terminate="yes">
      [buildListWhileMap]Error: No pController specified:
         would cause infinite processing.
      </xsl:message>
    </xsl:if>   
    
    <xsl:variable name="vNewBaseListElement">
      <xsl:if test="$pMap">
	      <xsl:element name="{$pElementName}">
		      <xsl:apply-templates select="$pGenerator" mode="f:FXSL">
		        <xsl:with-param name="pParams" select="$pParam0"/>
		        <xsl:with-param name="pList" select="$pBaseList"/>
		      </xsl:apply-templates>
	      </xsl:element>
      </xsl:if>
    </xsl:variable>
    
    
    <xsl:variable name="vElement">
      <xsl:element name="{$pElementName}">
        <xsl:choose>
	        <xsl:when test="not($pMap)">
		      <xsl:apply-templates select="$pGenerator" mode="f:FXSL">
		        <xsl:with-param name="pParams" select="$pParam0"/>
		        <xsl:with-param name="pList" select="$pList"/>
		      </xsl:apply-templates>
	       </xsl:when>
	       <xsl:otherwise>
		      <xsl:apply-templates select="$pMap" mode="f:FXSL">
		        <xsl:with-param name="pParams" select="$pMapParams"/>
		        <xsl:with-param name="pDynParams" select="$vNewBaseListElement/*"/>
		        <xsl:with-param name="pList" select="$pList"/>
		      </xsl:apply-templates>
	      </xsl:otherwise>
      </xsl:choose>
      </xsl:element>
    </xsl:variable>
    
    <xsl:variable name="newList">
      <xsl:copy-of select="$pList"/>
      <xsl:copy-of select="$vElement/*"/>
    </xsl:variable>
     
     <xsl:variable name="newRTFBaseList">
      <xsl:copy-of select="$pBaseList"/>
      <xsl:copy-of select="$vNewBaseListElement/*"/>
    </xsl:variable>
    
    <xsl:variable name="vResultList" select="$newList/*"/>
    <xsl:variable name="vResultBaseList" select="$newRTFBaseList/*"/>
    
    <xsl:variable name="vAccept">
      <xsl:apply-templates select="$pController" mode="f:FXSL">
        <xsl:with-param name="pList" select="$vResultList"/>
        <xsl:with-param name="pParams" select="$pContollerParam"/>
      </xsl:apply-templates>
    </xsl:variable>
    
    <xsl:choose>
      <xsl:when test="not(string($vAccept))">
        <xsl:copy-of select="$pList"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="buildListWhileMap">
		    <xsl:with-param name="pGenerator" select="$pGenerator"/>
		    <xsl:with-param name="pParam0" select="$pParam0"/>
		    <xsl:with-param name="pController" select="$pController"/>
	        <xsl:with-param name="pContollerParam" select="$pContollerParam"/>
		    <xsl:with-param name="pMap" select="$pMap"/>
		    <xsl:with-param name="pMapParams" select="$pMapParams"/>
		    <xsl:with-param name="pElementName" select="$pElementName"/>
		    <xsl:with-param name="pList" select="$vResultList" />
	        <xsl:with-param name="pBaseList" select="$vResultBaseList"/>

        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>
</xsl:stylesheet>