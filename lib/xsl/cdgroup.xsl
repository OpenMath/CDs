<xsl:stylesheet 
  version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:om="http://www.openmath.org/OpenMath"
  xmlns:cd="http://www.openmath.org/OpenMathCDG"
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="om cd">


<xsl:output method="html" indent="yes"/>


<xsl:template match="cd:CDGroup">
  <html>
    <head>
      <title><xsl:value-of select="cd:CDGroupName"/></title>
    </head>
    <body bgcolor="#FFFFFF">
      <h1>OpenMath CD Group:
      <xsl:value-of select="cd:CDGroupName"/>
      </h1>
      <b>Version: </b><xsl:value-of select="cd:CDGroupVersion"/>
      <hr/>
      <xsl:value-of select="cd:CDGroupDescription"/>
      <hr/>
      <xsl:apply-templates/>
    </body>
  </html>
</xsl:template>

<xsl:template match="cd:CDComment"/>
<xsl:template match="cd:CDGroupURL|cd:CDGroupName"/>
<xsl:template match="cd:CDGroupDescription"/>
<xsl:template match="cd:CDGroupVersion"/>
<xsl:template match="cd:CDGroupRevision"/>
<xsl:template match="cd:CDGroupMember">
    <xsl:element name="a">
      <xsl:attribute name="href">../cd/<xsl:value-of 
      select="normalize-space(./cd:CDName)"/>.html</xsl:attribute>
      <xsl:value-of select="cd:CDGroupName"/>
      <xsl:value-of 
	  select="normalize-space(./cd:CDName)"/>
    </xsl:element>
    <xsl:value-of  select="normalize-space(./cd:CDGroupMember)"/>
    <br/>
</xsl:template>

<xsl:template match="cd:CDURL|cd:CDName"/>

</xsl:stylesheet>

