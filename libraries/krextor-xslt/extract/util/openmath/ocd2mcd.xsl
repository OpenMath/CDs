<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
  xmlns:ocd="http://www.openmath.org/OpenMathCD"
  xmlns:mcd="http://www.w3.org/ns/mathml-cd"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  exclude-result-prefixes="ocd mcd">

  <xsl:output method="xml" indent="yes"/>
  <xsl:include href="om2mml.xsl"/>
  <xsl:template match="/">
    <xsl:comment>This MathML CD is automatically generated from an OpenMath CD. Edit at your own risk.</xsl:comment>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="ocd:CD">
    <mcd:mcd version="3.0">
      <xsl:attribute name="xml:id"><xsl:value-of select="ocd:CDName"/></xsl:attribute>
      <xsl:attribute name="review-date"><xsl:value-of select="ocd:CDReviewdate"/></xsl:attribute>
      <xsl:attribute name="revision-date"><xsl:value-of select="ocd:CDRevisiondate"/></xsl:attribute>
      <xsl:attribute name="cdbase"><xsl:value-of select="ocd:CDBase"/></xsl:attribute>
      <xsl:attribute name="status"><xsl:value-of select="ocd:CDStatus"/></xsl:attribute>
      <xsl:attribute name="date"><xsl:value-of select="ocd:CDDate"/></xsl:attribute>
      <xsl:apply-templates select="ocd:Description"/>
      <xsl:apply-templates select="ocd:CDDefinition"/>
    </mcd:mcd>
  </xsl:template>

  <xsl:template match="ocd:CDDefinition">
    <mcd:MMLDefinition>
      <xsl:attribute name="xml:id"><xsl:value-of select="ocd:CDName"/></xsl:attribute>
      <xsl:attribute name="cdrole"><xsl:value-of select="ocd:Role"/></xsl:attribute>
      <xsl:apply-templates select="ocd:description"/>
      <xsl:apply-templates select="ocd:CMP"/>
    </mcd:MMLDefinition>
  </xsl:template>
  
  <xsl:template match="ocd:Description">
    <mcd:description><xsl:apply-templates/></mcd:description>
  </xsl:template>

  <xsl:template match="ocd:CMP">
    <mcd:property>
      <mcd:description><p><xsl:apply-templates/></p></mcd:description>
      <mcd:formal><xsl:apply-templates select="following-sibling::ocd:FMP[1]" mode="o2m"/></mcd:formal>
    </mcd:property>
  </xsl:template>
  
</xsl:stylesheet>
