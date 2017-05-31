<?xml version="1.0" encoding="UTF-8"?>

<!--
	*  Copyright (C) 2011
	*  Lucian Mocanu
	*  Jacobs University Bremen
	*  http://kwarc.info/projects/krextor/
	*
	*   Krextor is free software; you can redistribute it and/or
	* 	modify it under the terms of the GNU Lesser General Public
	* 	License as published by the Free Software Foundation; either
	* 	version 2 of the License, or (at your option) any later version.
	*
	* 	This program is distributed in the hope that it will be useful,
	* 	but WITHOUT ANY WARRANTY; without even the implied warranty of
	* 	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
	* 	Lesser General Public License for more details.
	*
	* 	You should have received a copy of the GNU Lesser General Public
	* 	License along with this library; if not, write to the
	* 	Free Software Foundation, Inc., 59 Temple Place - Suite 330,
	* 	Boston, MA 02111-1307, USA.
	* 
-->

<!DOCTYPE xsl:stylesheet [
	<!ENTITY lamapun "http://www.kwarc.info/projects/lamapun#">
	<!ENTITY dct "http://purl.org/dc/terms/">
	<!ENTITY xsd "http://www.w3.org/2001/XMLSchema#">
]>

<stylesheet xmlns="http://www.w3.org/1999/XSL/Transform" 
	xpath-default-namespace="http://dlmf.nist.gov/LaTeXML"
	xmlns:krextor="http://kwarc.info/projects/krextor"
	xmlns:krextor-genuri="http://kwarc.info/projects/krextor/genuri"
	xmlns:latexml="http://dlmf.nist.gov/LaTeXML"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:xd="http://www.pnp-software.com/XSLTdoc"
	exclude-result-prefixes="#all"
	version="2.0">

    <import href="util/rdfa.xsl"/>
    <import href="util/misc.xsl"/>

	<xd:doc type="stylesheet">
	<xd:short>Extraction module for <a href="http://dlmf.nist.gov/LaTeXML">LaTeXML</a>'s XMath format, as required for <a href="http://trac.kwarc.info/lamapun">LaMaPUn</a></xd:short>
	<xd:detail>https://svn.kwarc.info/repos/lamapun/projects/Ontology/LaMaPUn.owl</xd:detail>
	<xd:author>Lucian Mocanu, Christoph Lange</xd:author>
	<xd:copyright>Lucian Mocanu Christoph Lange, 2009-2011</xd:copyright>
	<xd:svnId>$Id: xmath.xsl 1998 2011-05-27 10:47:00Z lucianct $</xd:svnId>
	</xd:doc>

	<xd:doc>The way we want to generate URIs for resources of interest; can be
	a list of multiple ways. For every way that is not part of the Krextor
	core, we have to develop a <code>krextor-genuri:name</code> template
	implementing that particular URI generation.</xd:doc>
	<param name="autogenerate-fragment-uris" select="'xml-id'"/>

	<xd:doc>Extract the document element</xd:doc>
	<template match="document" mode="krextor:main">
		<call-template name="krextor:create-resource">
			<with-param name="type" select="'&lamapun;Document'"/>
			<with-param name="related-via-properties" select="'&lamapun;hasChild'" tunnel="yes"/>
			<with-param name="related-via-inverse-properties" select="'&lamapun;hasParent'" tunnel="yes"/>
		</call-template>
	</template>
	
	<xd:doc>Support for literal-valued RDFa metadata</xd:doc>
	<template match="keywords" mode="krextor:main">
		<apply-templates select="@property" mode="krextor:main"/>
	</template>
	
	<!-- TODO: extend to other roles -->
	<template match="date[@role='creation']" mode="krextor:main">
		<call-template name="krextor:add-literal-property">
			<with-param name="property" select="'&dct;created'"/>
		</call-template>
	</template>

	<!-- TODO: table, figure -->
	<xd:doc>Extract the main structural elements</xd:doc>
	<template match="abstract|chapter|section|subsection|subsubsection|definition|proof|theorem|sentence|word" mode="krextor:main">
		<call-template name="krextor:create-resource">
			<with-param name="type" select="concat('&lamapun;', krextor:ucfirst(local-name()))"/>
			<with-param name="related-via-properties" select="'&lamapun;hasChild'" tunnel="yes"/>
			<with-param name="related-via-inverse-properties" select="'&lamapun;hasParent'" tunnel="yes"/>
		</call-template>
	</template>

	<!-- Paragraphs are named differently by LaTeXML -->
	<template match="para" mode="krextor:main">
		<call-template name="krextor:create-resource">
			<with-param name="type" select="'&lamapun;Paragraph'"/>
			<with-param name="related-via-properties" select="'&lamapun;hasChild'" tunnel="yes"/>
			<with-param name="related-via-inverse-properties" select="'&lamapun;hasParent'" tunnel="yes"/>
		</call-template>
	</template>

	<!-- TODO: choose the subclass of Formula based on the child Math element -->
	<template match="formula">
		<call-template name="krextor:create-resource">
			<with-param name="type" select="'&lamapun;Formula'"/>
			<with-param name="related-via-properties" select="'&lamapun;hasChild'" tunnel="yes"/>
			<with-param name="related-via-inverse-properties" select="'&lamapun;hasParent'" tunnel="yes"/>
		</call-template>
		<!--
		<call-template name="krextor:add-literal-property">
		</call-teamplate>
		-->
	</template>

	<!--
	<template match="Math">
		<call-template name="krextor:create-resource">
			<with-param name="type" select="'&lamapun;Formula'"/>
			<with-param name="related-via-properties" select="'&lamapun;hasChild'" tunnel="yes"/>
			<with-param name="related-via-inverse-properties" select="'&lamapun;hasParent'" tunnel="yes"/>
		</call-template>
	</template>
	-->

	<template match="XMath">
		<call-template name="krextor:create-resource">
			<with-param name="type" select="'&lamapun;MathExpression'" />
			<with-param name="related-via-properties" select="'&lamapun;hasChild'" tunnel="yes"/>
			<with-param name="related-via-inverse-properties" select="'&lamapun;hasParent'" tunnel="yes"/>
		</call-template>
	</template>

	<template match="XMApp">
		<call-template name="krextor:create-resource">
			<with-param name="type" select="'&lamapun;MathApp'"/>
			<with-param name="related-via-properties" select="'&lamapun;hasChild'" tunnel="yes"/>
			<with-param name="related-via-inverse-properties" select="'&lamapun;hasParent'" tunnel="yes"/>
		</call-template>
	</template>

	<template match="XMArg">
		<call-template name="krextor:create-resource">
			<with-param name="type" select="'&lamapun;MathExpression'"/>
			<with-param name="related-via-properties" select="'&lamapun;hasChild'" tunnel="yes"/>
			<with-param name="related-via-inverse-properties" select="'&lamapun;hasParent'" tunnel="yes"/>
		</call-template>
	</template>
	
	<template match="token" mode="krextor:main">
		<call-template name="krextor:create-resource">
			<with-param name="type" select="if (ancestor::word) then '&lamapun;WordToken' else '&lamapun;MathToken'" />
			<with-param name="process-next" select="text()"/>
			<with-param name="related-via-properties" select="'&lamapun;hasChild'" tunnel="yes"/>
			<with-param name="related-via-inverse-properties" select="'&lamapun;hasParent'" tunnel="yes"/>
		</call-template>
	</template>

	<template match="token/text()" mode="krextor:main">
		<call-template name="krextor:add-literal-property">
			<with-param name="property" select="'&lamapun;content'"/>
		</call-template>
	</template>
	
	<template match="*" mode="krextor:main">
		<message>Warning! <value-of select="local-name()"/></message>
		<apply-templates mode="krextor:main"/>
	</template>
	
	
	<!--
	<xd:doc>
		The index of an XMath element among all XMath elements in the document. We assume that there are no nested XMath elements, is that correct?
		<xd:param name="node">the node, assumed to be an XMath element</xd:param>
	</xd:doc>
	<function name="krextor:xmath-index">
		<param name="node"/>
		<value-of select="count($node/preceding::XMath)"/>
	</function>

	<xd:doc>Our own generation of fragment URIs (index of the XMath element); only succeeds if we are on an XMath element</xd:doc>
	<template match="krextor-genuri:xmath-index" as="xs:string?">
		<param name="node"/>
		<param name="base-uri"/>
		<!- this could be implemented more efficiently by breaking XSLT 2.0 compliance and incrementing a global counter ->
		<sequence select="krextor:fragment-uri-or-null(
			if ($node/self::XMath) then
				concat('m', krextor:xmath-index($node))
			else (),
			$base-uri)"/>
	</template>
	-->

	<!--
	<!- When we see an XMath element ... ->
	<template match="XMath" mode="krextor:main">
	<!- ... we create an RDF resource (which can easily be declared an
	instance of some class) ... ->
	<call-template name="krextor:create-resource">
		<!- ... say how it is related to its parent resource (here: the whole document) ... ->
		<with-param name="related-via-properties" select="'&lamapun;hasMath'" tunnel="yes"/>
		<!- ... and give it some additional properties ... ->
		<with-param name="properties">
		<!- ... here: only a numeric ID ->
		<krextor:property
			uri="&lamapun;id"
			datatype="&xsd;integer">
			<!- this is computed twice, unfortunately ->
			<value-of select="krextor:xmath-index(.)"/>
		</krextor:property>
		</with-param>
	</call-template>
	</template>
	-->
</stylesheet>
