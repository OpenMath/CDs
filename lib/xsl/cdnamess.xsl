<xsl:stylesheet 
  version="2.0"
  xmlns:cdg="http://www.openmath.org/OpenMathCDG"
  xmlns:cd="http://www.openmath.org/OpenMathCD"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  exclude-result-prefixes="cdg cd">
 
<xsl:output method="html" indent="yes"/>
<xsl:template match="/">
<!-- -
layout: page
title: OpenMath Content Dictionaries by status
- -->
<xsl:comment>WARNING: This page is automatically generated, do not edit! WARNING</xsl:comment>
<xsl:text>&#xA; &#xA;</xsl:text>
<table border="1">
<tr>
<th><a href="../cdnames">Content Dictionary</a></th>
<th><a href="../cdnamess">Status</a></th>
</tr>
<xsl:for-each select="CDS/OCD">
 <xsl:sort select="concat(normalize-space(*:CD/*:CDStatus),contains(@path,'contrib/'))"/>
 <xsl:sort select="normalize-space(*:CD/*:CDName)"/>
 <xsl:variable name="status" select="normalize-space(*:CD/*:CDStatus)"/> 
 <xsl:variable name="name" select="normalize-space(*:CD/*:CDName)"/>
  <tr>
   <th style="text-align:left">
    <a href="../cd/{$name}.html"><xsl:value-of select="$name"/></a>
   </th>
   <td>
    <xsl:value-of select="$status"/>
    <xsl:if test="contains(@path,'contrib/')"> (contributed)</xsl:if>
   </td>
  </tr>
</xsl:for-each>
</table>
</xsl:template>
</xsl:stylesheet>

