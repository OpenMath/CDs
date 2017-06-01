<xsl:stylesheet 
  version="1.0"
  xmlns:cdg="http://www.openmath.org/OpenMathCDG"
  xmlns:cd="http://www.openmath.org/OpenMathCD"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:x="http://xml.apache.org/xalan"
   xmlns:xx="http://icl.com/saxon"
  xmlns:exslt='http://exslt.org/common'
>
  <xsl:strip-space elements="*"/>
  <xsl:output method="text"/>
  <xsl:template match="/">
    <xsl:text>---
layout: page
title: OpenMath Content Dictionaries by name
---
|Symbol|CD|Description|</xsl:text>
  <xsl:for-each select="CDS/OCD/cd:CD/cd:CDDefinition">
    <xsl:sort select="cd:Name"/>
    <xsl:text>|</xsl:text>
    <xsl:value-of select="cd:Name"/>
    <xsl:text>|[</xsl:text>
    <xsl:value-of select="../cd:CDName"/>
    <xsl:text>](../</xsl:text>
    <xsl:value-of select="substring-before(../../@path,'.ocd')"/>
    <xsl:text>.xhtml)|</xsl:text>
    <xsl:copy-of select="normalize-space((Description|cd:Description)/node())"/>
    <xsl:text>|&#xA;</xsl:text>
  </xsl:for-each>
</xsl:template>





</xsl:stylesheet>

