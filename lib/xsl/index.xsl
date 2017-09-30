<xsl:stylesheet 
  version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>
  <xsl:strip-space elements="*"/>
  <xsl:output method="xml" omit-xml-declaration="yes" indent="yes"/>
  <xsl:template match="/">
<!-- -
layout: page
title: OpenMath Symbols
- -->

<h1>OpenMath Symbols</h1>
<xsl:variable name="s" select="CDS/OCD/*:CD/*:CDDefinition"/>
<xsl:message select="'cdsymbols:',count($s)"/>
<p>A combined list of all <xsl:value-of select="count($s)"/> symbols defined in this Content Dictionary collection.</p>

<table>
  <tr>
    <th>Symbol</th>
    <th>Description</th>
  </tr>
  <xsl:for-each select="$s">
    <xsl:sort select="lower-case(normalize-space(*:Name))"/>
    <xsl:sort select="lower-case(normalize-space(../*:CDName))"/>
    <xsl:sort select="lower-case(normalize-space(../../*/@path))"/>
    <tr>
     <td>
      <a href="../cd/{normalize-space(../*:CDName)}.html#{normalize-space(*:Name)}">
       <xsl:value-of select="normalize-space(../*:CDName)"/>
       <xsl:text>/</xsl:text><br/>
       <xsl:value-of select="normalize-space(*:Name)"/>
      </a>
      </td>
      <td>
	<xsl:copy-of select="normalize-space((Description|*:Description)/node())"/>
      </td>
    </tr>
  </xsl:for-each>
</table>
</xsl:template>
</xsl:stylesheet>

