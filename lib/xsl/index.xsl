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
<table border="1">
  <tr>
    <th>Symbol</th>
    <th>CD</th>
    <th>Description</th>
  </tr>
  <xsl:for-each select="CDS/OCD/cd:CD/cd:CDDefinition">
    <xsl:sort select="cd:Name"/>
    <tr>
      <td><xsl:value-of select="cd:Name"/></td>
      <td><a href="{substring-before(../../@path,'.ocd')}.xhtml"><xsl:value-of select="../cd:CDName"/></a></td>
      <td><xsl:copy-of select="(Description|cd:Description)/node()"/></td>
    </tr>
  </xsl:for-each>
</table>
</xsl:template>





</xsl:stylesheet>

