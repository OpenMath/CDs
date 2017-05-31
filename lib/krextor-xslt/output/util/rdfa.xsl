<?xml version="1.0" encoding="UTF-8"?>

<!--
    *  Copyright (C) 2009
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
    <!ENTITY rdf "http://www.w3.org/1999/02/22-rdf-syntax-ns#">
]>

<stylesheet xmlns="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xd="http://www.pnp-software.com/XSLTdoc"
    xmlns:rxr="http://ilrt.org/discovery/2004/03/rxr/"
    xmlns:krextor="http://kwarc.info/projects/krextor"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    version="2.0">
    <import href="../../generic/uri.xsl"/>
    <import href="prefix.xsl"/>

    <xd:doc type="stylesheet">
	<xd:short>Output module for RDFa in XHTML</xd:short>
	<xd:detail>This stylesheet contains utility functions for generating RDFa output.  It is intended to be imported into an XSLT that generates XHTML, usually from the same source where the RDF is extracted from.
	    <ul>
		<li><a href="http://www.w3.org/TR/2008/REC-rdfa-syntax-20081014">Specification of XHTML+RDFa</a></li>
	    </ul>
	</xd:detail>
	<xd:author>Christoph Lange</xd:author>
	<xd:copyright>Christoph Lange, 2009</xd:copyright>
	<xd:svnId>$Id: rdfa.xsl 1548 2010-05-07 20:58:20Z clange $</xd:svnId>
    </xd:doc>

    <output method="xml" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>

    <!--
    <namespace-alias stylesheet-prefix="h" result-prefix="#default"/>
    -->

    <xd:doc>Adds RDFa attributes to the current element in the output tree,
	depending on the RDF extracted from the current node in the input
	tree.</xd:doc>
    <template name="krextor:rdfa">
	<variable name="uri" select="krextor:generate-uri(., krextor:base-uri(.))"/>
	<!-- TODO make this work for blank nodes too -->
	<if test="$uri">
	    <attribute name="about" select="$uri"/>
	    <!-- all triples having this resource as subject -->
	    <variable name="properties" select="krextor:query-triples-by-subject($uri)"/>
	    <!-- @typeof -->
	    <variable name="type" select="$properties[rxr:predicate[@uri eq '&rdf;type']]/rxr:object/@uri"/>
	    <if test="$type">
		<attribute name="typeof" select="
		    for $t in $type
		    return krextor:uri-to-curie($t)"/>
	    </if>
	    <!-- all other properties, literals and URIs -->
	    <!-- TODO group by common properties -->
	    <!-- TODO put all into <div>...</div> if browser shows whitespace -->
	    <apply-templates select="$properties[rxr:predicate[@uri ne '&rdf;type']]" mode="krextor:rdfa"/>
	</if>
    </template>

    <xd:doc>Adds RDFa attributes to the current element in the output tree,
	depending on the RDF extracted from the current node in the input
	tree.</xd:doc>
    <template match="node()" mode="krextor:rdfa">
	<call-template name="krextor:rdfa"/>
    </template>

    <xd:doc>Outputs an empty <code>span</code> element with RDFa attributes for
	a literal-valued property</xd:doc>
    <template match="rxr:triple[rxr:object[text()]]" mode="krextor:rdfa">
	<!-- TODO does not yet work for rdf:XMLLiteral datatype -->
	<span xmlns="http://www.w3.org/1999/xhtml" property="{krextor:uri-to-curie(rxr:predicate/@uri)}" content="{rxr:object}">
	    <if test="rxr:object/@xml:lang" xmlns="http://www.w3.org/1999/XSL/Transform">
		<attribute name="xml:lang" select="rxr:object/@xml:lang"/>
	    </if>
	    <if test="rxr:object/@datatype" xmlns="http://www.w3.org/1999/XSL/Transform">
		<attribute name="datatype"
		    select="krextor:uri-to-curie(rxr:object/@datatype)"/>
	    </if>
	</span>
    </template>

    <xd:doc>Outputs an empty <code>span</code> element with RDFa attributes for  a URI-valued property</xd:doc>
    <template match="rxr:triple[rxr:object[not(text())]]" mode="krextor:rdfa">
	<!-- TODO does not yet work for blank nodes -->
	<span xmlns="http://www.w3.org/1999/xhtml" rel="{krextor:uri-to-curie(rxr:predicate/@uri)}" resource="{rxr:object/@uri}"/>
    </template>
</stylesheet>
