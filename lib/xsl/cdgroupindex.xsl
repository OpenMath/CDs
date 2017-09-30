<xsl:stylesheet 
  version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 >


<xsl:output method="text" indent="yes"/>

<xsl:param name="cdg" select="'mathml.cdg arith.cdg types1.cdg'"/>

<xsl:template name="cdg">---
layout: page
title: OpenMath Content Dictionaries - CD Groups
---

<xsl:variable name="cdgs" select="tokenize($cdg,'\s+')[.]"/>

<p><xsl:value-of select="count($cdgs)"/> Content Dictionary Groups available on this site.</p>

<xsl:for-each select="$cdgs">
 <xsl:text>&#10; |[</xsl:text>
 <xsl:value-of select="substring-before(.,'.cdg')"/>
 <xsl:text>](</xsl:text>
 <xsl:value-of select="substring-before(.,'.cdg')"/>
 <xsl:text>)|</xsl:text>
 <xsl:value-of select="normalize-space(doc(concat('../../cdgroups/',.))/*/*:CDGroupDescription)"/>
 <xsl:text>|</xsl:text>
</xsl:for-each>
<xsl:text>&#10;</xsl:text>
</xsl:template>
</xsl:stylesheet>

