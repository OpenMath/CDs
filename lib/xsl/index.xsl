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


<table>
  <tr>
    <th>Symbol</th>
    <th>Description</th>
  </tr>
  <xsl:for-each select="CDS/OCD/*:CD/*:CDDefinition">
    <xsl:sort select="lower-case(normalize-space(*:Name))"/>
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

