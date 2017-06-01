<xsl:stylesheet 
  version="1.0"
  xmlns:cdg="http://www.openmath.org/OpenMathCDG"
  xmlns:cd="http://www.openmath.org/OpenMathCD"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:x="http://xml.apache.org/xalan"
   xmlns:xx="http://icl.com/saxon"
  xmlns:exslt='http://exslt.org/common'
>
<xsl:output method="html" indent="yes"/>
<xsl:template match="/">
---
layout: page
title: OpenMath Content Dictionaries by name
---
<xsl:comment>WARNING: This page is automatically generated, do not edit! WARNING</xsl:comment>
<xsl:text>&#xA; &#xA;</xsl:text>
<table border="1">
<tr>
<th><a href="cdnames.html">Content Dictionary</a></th>
<th><a href="cdnamess.html">Status</a></th>
<th>XHTML Presentation</th>
<th>XML CD File</th>
</tr>
<xsl:for-each select="CDS/OCD">
  <xsl:sort select="substring-after(substring-after(@path,'/'),'/')"/>
  <xsl:variable name="name" select="substring-before(substring-after(substring-after(@path,'/'),'/'),'.ocd')"/> 
  <xsl:variable name="basepath" select="substring-before(@path,'.ocd')"/> 
  <xsl:variable name="status" select="substring-before(substring-after(@path,'/'),'/')"/> 
  <tr>
    <th style="text-align:left"><xsl:value-of select="$name"/></th>
    <td><xsl:value-of select="$status"/></td>
    <td><a href="{$basepath}.xhtml"><xsl:value-of select="$name"/>.xhtml</a></td>
    <td><a href="{$basepath}.ocd"><xsl:value-of select="$name"/>.ocd</a></td>
  </tr>
</xsl:for-each>
</table>
</xsl:template>
</xsl:stylesheet>

