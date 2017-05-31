<xsl:stylesheet version="2.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:f="http://fxsl.sf.net/"
 xmlns:myAppend="f:fxsl-concat-append" 
 exclude-result-prefixes="f myAppend"
 >
 
 <xsl:import href="append.xsl"/>
 
 <myAppend:myAppend/>
 
  <xsl:template match="/">
  </xsl:template>
<!--  
  >  concat           :: [[a]] -> [a]
  >  concat            = foldr (++) []
-->  
  <xsl:template name="concat">
    <xsl:param name="arg1" select="/.."/> <!-- List of lists -->
    
    <xsl:call-template name="foldr">
      <xsl:with-param name="pFunc" select="document('')/*/myAppend:*[1]"/>
      <xsl:with-param name="pA0" select="/.."/>
      <xsl:with-param name="pList" select="$arg1"/>
    </xsl:call-template>
  </xsl:template>
  
  <xsl:template match="myAppend:*" mode="f:FXSL">
    <xsl:param name="arg1" select="/.."/> <!-- current list -->
    <xsl:param name="arg2" select="/.."/> <!-- current result list -->
    
	    <xsl:copy-of select="$arg1/*"/>
	    <xsl:copy-of select="$arg2"/>
    
  </xsl:template>
</xsl:stylesheet>