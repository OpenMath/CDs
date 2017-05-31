<?xml version="1.0" encoding="UTF-8"?>

<!--
    *  Copyright (C) 2010
    *  Christoph Lange
    *  KWARC, Jacobs University Bremen
    *  http://kwarc.info/projects/krextor/
    *
    *   Krextor is free software; you can redistribute it and/or
    * 	modify it under the terms of the GNU Lesser General Public
    * 	License as published by the Free Software Foundation; either
    * 	version 2 of the License, or (at your option) any later version.
    *
    * 	This program is distributed in the hope that it will be useful,
    * 	but WITHOUT ANY WARRANTY; without even the implied warranty of
    * 	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    * 	Lesser General Public License for more details.
    *
    * 	You should have received a copy of the GNU Lesser General Public
    * 	License along with this library; if not, write to the
    * 	Free Software Foundation, Inc., 59 Temple Place - Suite 330,
    * 	Boston, MA 02111-1307, USA.
    * 
-->

<!DOCTYPE stylesheet [
    <!ENTITY xml "http://example.org/xml#">
]>

<stylesheet xmlns="http://www.w3.org/1999/XSL/Transform" 
    xmlns:krextor="http://kwarc.info/projects/krextor"
    xmlns:krextor-genuri="http://kwarc.info/projects/krextor/genuri"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xd="http://www.pnp-software.com/XSLTdoc"
    exclude-result-prefixes="#all"
    version="2.0">

    <xd:doc type="stylesheet">
	<xd:short>Extraction module for generic XML</xd:short>
	<xd:author>Christoph Lange</xd:author>
	<xd:copyright>Christoph Lange, 2010</xd:copyright>
	<xd:svnId>$Id: xml.xsl 1771 2010-11-03 17:35:10Z clange $</xd:svnId>
    </xd:doc>
    
    <!-- Note that this is not the global default; actually the 
         concrete way of URI generation is decided on element level -->
    <!--
    <param name="autogenerate-fragment-uris" select="'pseudo-xpath', 'generate-id'"/>
    -->
    <param name="autogenerate-fragment-uris" select="'generate-id'"/>

    <strip-space elements="*"/>

    <template match="*" mode="krextor:main">
        <call-template name="krextor:create-resource">
            <with-param name="type" select="'&xml;Element'"/>
            <with-param name="properties">
                <krextor:property uri="&xml;namespaceURI" object="{namespace-uri()}"/>
                <krextor:property uri="&xml;localName" value="{local-name()}"/>
            </with-param>
            <!-- unordered; order does not work that easily -->
            <with-param name="related-via-properties" select="'&xml;child'" tunnel="yes"/>
            <with-param name="process-next" select="*|@*|text()|comment()"/>
        </call-template>
    </template>

    <template match="@*" mode="krextor:main">
        <call-template name="krextor:create-resource">
            <with-param name="type" select="'&xml;Attribute'"/>
            <with-param name="properties">
                <krextor:property uri="&xml;namespaceURI" object="{namespace-uri()}"/>
                <krextor:property uri="&xml;localName" value="{local-name()}"/>
                <krextor:property uri="&xml;string" value="{string()}"/>
            </with-param>
        </call-template>
    </template>

    <template match="text()" mode="krextor:main">
        <call-template name="krextor:create-resource">
            <with-param name="type" select="'&xml;Text'"/>
            <with-param name="properties">
                <krextor:property uri="&xml;string" value="{string()}"/>
            </with-param>
            <!-- unordered; order does not work that easily -->
            <with-param name="related-via-properties" select="'&xml;child'" tunnel="yes"/>
        </call-template>
    </template>

    <template match="comment()" mode="krextor:main">
        <call-template name="krextor:create-resource">
            <with-param name="type" select="'&xml;Comment'"/>
            <with-param name="properties">
                <krextor:property uri="&xml;string" value="{string()}"/>
            </with-param>
            <!-- unordered; order does not work that easily -->
            <with-param name="related-via-properties" select="'&xml;child'" tunnel="yes"/>
        </call-template>
    </template>
</stylesheet>
