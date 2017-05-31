<xsl:stylesheet version="2.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="xs f"
>

  <xsl:template name="str-filter">
    <xsl:param name="pStr"/>
    <xsl:param name="pController" select="/.."/>
    <xsl:param name="pElName" select="'str'"/>
    
    <xsl:if test="not($pController)">
      <xsl:message terminate="yes">[str-filter]Error: pController not specified.</xsl:message>
    </xsl:if>
    
    <xsl:variable name="vStr" as="xs:string*">
      <xsl:call-template name="_str-filter">
        <xsl:with-param name="pStr" select="$pStr"/>
        <xsl:with-param name="pController" select="$pController"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:element name="{$pElName}">
      <xsl:value-of select="string-join($vStr, '')"/>
    </xsl:element>

  </xsl:template>    

  <xsl:template name="_str-filter">
    <xsl:param name="pStr" />
    <xsl:param name="pController" select="/.."/>

    <xsl:if test="$pStr">
      <xsl:variable name="vthisChar" select="substring($pStr, 1, 1)"/>
		  
		  <xsl:variable name="vHolds">
		    <xsl:apply-templates select="$pController" mode="f:FXSL">
		      <xsl:with-param name="arg1" select="$vthisChar"/>
		    </xsl:apply-templates>
		  </xsl:variable>
	    
	    <xsl:if test="string($vHolds)">
	      <xsl:copy-of select="$vthisChar"/>
	    </xsl:if>
	    
	    <xsl:call-template name="_str-filter">
	      <xsl:with-param name="pStr" select="substring($pStr, 2)"/>
	      <xsl:with-param name="pController" select="$pController"/>
	    </xsl:call-template>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>