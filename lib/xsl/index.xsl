<xsl:stylesheet 
  version="2.0"
  xmlns:cdg="http://www.openmath.org/OpenMathCDG"
  xmlns:cd="http://www.openmath.org/OpenMathCD"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>
  <xsl:strip-space elements="*"/>
  <xsl:output method="xml" omit-xml-declaration="yes" indent="yes"/>
  <xsl:template match="/">
---
layout: page
title: OpenMath Symbols
---


<table>
  <tr>
    <th>Symbol</th>
    <th>CD</th>
    <th>Description</th>
  </tr>
  <xsl:for-each select="CDS/OCD/cd:CD/cd:CDDefinition">
    <xsl:sort select="lower-case(cd:Name)"/>
    <tr>
      <td><xsl:value-of select="cd:Name"/></td>
      <td><a href="cd/{../cd:CDName}.html">
	<xsl:value-of select="../cd:CDName"/>
      </a>
      </td>
      <td>
	<xsl:copy-of select="normalize-space((Description|cd:Description)/node())"/>
      </td>
    </tr>
  </xsl:for-each>
</table>
</xsl:template>
</xsl:stylesheet>

