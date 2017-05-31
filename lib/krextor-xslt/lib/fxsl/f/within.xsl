<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:MyWithinEpsController="MyWithinEpsController"
xmlns:f="http://fxsl.sf.net/"
exclude-result-prefixes="f MyWithinEpsController" 
>

  <xsl:import href="buildListWhile.xsl"/>

  <MyWithinEpsController:MyWithinEpsController/>
  
<!--   <xsl:variable name="vMyWithinEpsController" select="document('')/*/MyWithinEpsController:*[1]"/> -->

   <xsl:variable name="vMyWithinEpsController" as="element()">
     <MyWithinEpsController:MyWithinEpsController/>
   </xsl:variable>
  
  <xsl:template name="within">
	 <xsl:param name="pGenerator" select="/.."/>
	 <xsl:param name="pParam0" select="/.."/>
	 <xsl:param name="Eps" select="0.1"/>
<!--
  <xsl:message>
  within
     $pGenerator: '<xsl:copy-of select="$pGenerator"/>'
     $pParam0: '<xsl:copy-of select="$pParam0"/>'
     $Eps: '<xsl:copy-of select="$Eps"/>'
     $vMyWithinEpsController: '<xsl:copy-of select="$vMyWithinEpsController"/>'
  </xsl:message>
-->  
	  <xsl:variable name="vResultList">
		  <xsl:call-template name="buildListWhile">
		    <xsl:with-param name="pGenerator" select="$pGenerator"/>
		    <xsl:with-param name="pParam0" select="$pParam0"/>
		    <xsl:with-param name="pController" select="$vMyWithinEpsController"/>
	      <xsl:with-param name="pContollerParam" select="$Eps"/>
		  </xsl:call-template>
	  </xsl:variable>
	  
	  <xsl:value-of select="$vResultList/*[last()]"/>
  </xsl:template>

  <xsl:template name="MyWithinEpsController" match="*[namespace-uri()='MyWithinEpsController']"
   mode="f:FXSL">
     <xsl:param name="pList" select="/.."/>
     <xsl:param name="pParams"/>
     
     <xsl:choose>
	     <xsl:when test="exists($pList[2])">
	       <xsl:variable name="lastDiff" select="$pList[last()] - $pList[last() - 1]"/>
	       
	       <xsl:if test="not($lastDiff &lt;= $pParams 
	                   and $lastDiff >= (0 - $pParams))">1</xsl:if>
	     </xsl:when>
       <xsl:otherwise>1</xsl:otherwise>
     </xsl:choose>
  </xsl:template>

</xsl:stylesheet>