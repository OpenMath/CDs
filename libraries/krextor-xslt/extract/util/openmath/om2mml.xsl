<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
  xmlns:m="http://www.w3.org/1998/Math/MathML"
  xmlns:om="http://www.openmath.org/OpenMath"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  exclude-result-prefixes="om m">

  <xsl:output method="xml" indent="yes"/>
  <xsl:template match="om:OMOBJ" mode="o2m">
    <m:math>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates mode="o2m"/>
    </m:math>
  </xsl:template>

  <xsl:template match="om:OMA" mode="o2m">
    <m:apply>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates mode="o2m"/>
    </m:apply>
  </xsl:template>

  <xsl:template match="om:OMBIND" mode="o2m">
    <m:bind>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates select="*[1]" mode="o2m"/>
      <xsl:for-each select="om:OMBVAR">
        <m:bvar>
          <xsl:copy-of select="@*"/>
          <xsl:apply-templates mode="o2m"/>
        </m:bvar>
      </xsl:for-each>
      <xsl:apply-templates select="om:OMC" mode="o2m"/>
      <xsl:apply-templates select="*[position()=last()]" mode="o2m"/>
    </m:bind>
  </xsl:template>

  <xsl:template match="om:OMC" mode="o2m">
    <m:condition>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates mode="o2m"/>
    </m:condition>
  </xsl:template>

  <xsl:template match="om:OMS" mode="o2m"> 
    <m:csymbol><xsl:copy-of select="@*"/></m:csymbol>
  </xsl:template>

  <xsl:template match="om:OMV" mode="o2m"> 
    <m:ci><xsl:value-of select="@name"/></m:ci>
  </xsl:template>

  <xsl:template match="om:OMI" mode="o2m">
    <m:cn><xsl:apply-templates mode="o2m"/></m:cn>
  </xsl:template>
</xsl:stylesheet>
