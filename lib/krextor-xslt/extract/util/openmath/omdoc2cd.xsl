<!-- An XSL style sheet for creating OpenMath Content Dictionaries from OMDoc
     Initial version 20000718 by Michael Kohlhase 
     send bug-reports, patches, suggestions to kohlhase@mathweb.org

     Copyright (c) 2001 - 2002 Michael Kohlhase, 

     This library is free software; you can redistribute it and/or
     modify it under the terms of the GNU Lesser General Public
     License as published by the Free Software Foundation; either
     version 2.1 of the License, or (at your option) any later version.

     This library is distributed in the hope that it will be useful,
     but WITHOUT ANY WARRANTY; without even the implied warranty of
     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
     Lesser General Public License for more details.

     You should have received a copy of the GNU Lesser General Public
     License along with this library; if not, write to the Free Software
     Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.openmath.org/OpenMathCD"
  xmlns:om="http://www.openmath.org/OpenMath"
  xmlns:m="http://www.w3.org/1998/Math/MathML"
  xmlns:cd="http://www.openmath.org/OpenMathCD"
  xmlns:dc="http://purl.org/dc/elements/1.1/"
  xmlns:omdoc="http://omdoc.org/ns"
  xmlns:saxon="http://icl.com/saxon"
  extension-element-prefixes="saxon"
  version="1.0">
 
<xsl:output method="xml"
            version="1.0"
            indent="yes"
            standalone="yes"/>

<!-- for debugging -->
<xsl:template match="*">
  <xsl:message>warning: template for element <xsl:value-of select="local-name()"/> undefined in line <xsl:value-of select="saxon:line-number()"/></xsl:message>
</xsl:template>

<xsl:template match="/">
  <xsl:text>&#xA;&#xA;</xsl:text>
  <xsl:comment>
    This Content Dictionary file is automatically generated from the OpenMath Document
    "<xsl:value-of select="omdoc:omdoc/omdoc:metadata/dc:title"/>", do not edit!
    It may contain more than one Content Dictionary declaration.
  </xsl:comment>
  <xsl:text>&#xA;&#xA;</xsl:text>
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="omdoc:omdoc"><xsl:apply-templates/></xsl:template>

<xsl:template match="omdoc:metadata"></xsl:template>

<xsl:template match="omdoc:theory">
  <xsl:text>&#xA;&#xA;</xsl:text>
  <CD>
    <CDComment><xsl:value-of select="omdoc:metadata/dc:rights"/></CDComment>
    <CDName><xsl:value-of select="@xml:id"/></CDName>
    <CDURL><xsl:value-of select="@cdurl"/></CDURL>
    <CDReviewDate><xsl:value-of select="@cdreviewdate"/></CDReviewDate>
    <CDStatus><xsl:value-of select="@cdstatus"/></CDStatus>
    <CDDate><xsl:value-of select="@cddate"/></CDDate>
    <CDVersion><xsl:value-of select="@cdversion"/></CDVersion>
    <CDRevision><xsl:value-of select="@cdrevision"/></CDRevision>
    <xsl:if test="omdoc:imports">
      <CDUses>
	<xsl:for-each select="omdoc:imports">
	  <xsl:value-of select="@from"/>
	  <xsl:if test="position()!=last()"><xsl:text>, </xsl:text></xsl:if>
	</xsl:for-each>
      </CDUses>
    </xsl:if>
   <Description><xsl:value-of select="omdoc:metadata/dc:description"/></Description>
   <xsl:text>&#xA;</xsl:text>
    <xsl:apply-templates/>
  </CD>
</xsl:template>

 <xsl:template match="omdoc:tgroup[@cd:type='CDDefinition']">
  <CDDefinition><xsl:apply-templates/></CDDefinition>
</xsl:template>

<xsl:template match="omdoc:symbol">
  <Name><xsl:value-of select="@name"/></Name>
  <Description><xsl:value-of select="omdoc:metadata/dc:description"/></Description>
</xsl:template>

<xsl:template match="omdoc:assertion[@cd:type='property']">
  <property>
    <xsl:copy-of select="@xml:id"/>
    <xsl:apply-templates/>
  </property>
</xsl:template>

<xsl:template match="omdoc:example[@cd:type='MMLexample']">
  <MMLexample>
    <xsl:copy-of select="@xml:id"/>
    <xsl:apply-templates/>
  </MMLexample>
</xsl:template>

<xsl:template match="omdoc:example[@cd:type='Example']">
  <Example>
    <xsl:copy-of select="@xml:id"/>
    <xsl:value-of select="omdoc:CMP"/>
    <xsl:copy-of select="om:OMOBJ"/>
  </Example>
</xsl:template>

<xsl:template match="omdoc:omtext[@cd:type='description']">
  <description>
    <xsl:copy-of select="omdoc:p"/>
  </description>
</xsl:template>

<xsl:template match="omdoc:omtext[@cd:type='discussion']">
  <discussion>
    <xsl:copy-of select="omdoc:p"/>
  </discussion>
</xsl:template>

<xsl:template match="m:math">
  <xsl:copy-of select="."/>
</xsl:template>

<xsl:template match="omdoc:CMP">
  <CMP><xsl:value-of select="."/></CMP>
</xsl:template>

<xsl:template match="omdoc:FMP">
  <FMP><xsl:copy-of select="*"/></FMP>
</xsl:template>
</xsl:stylesheet>

