<?xml version="1.0" encoding="UTF-8"?>

<!--
    *  Copyright (C) 2008
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
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:xd="http://www.pnp-software.com/XSLTdoc"
    xmlns:rxr="http://ilrt.org/discovery/2004/03/rxr/"
    xmlns:krextor="http://kwarc.info/projects/krextor"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    version="2.0">
    <import href="../generic/generic.xsl"/>
    <import href="rxr.xsl"/>
    <import href="util/prefix.xsl"/>

    <xd:doc type="stylesheet">
	<xd:short>Output module for RDF/XML</xd:short>
	<xd:detail>This stylesheet provides low-level triple-creation functions
	    and templates for an RDF/XML extraction from XML languages.
	    <ul>
		<li><a href="http://www.w3.org/TR/2004/REC-rdf-syntax-grammar-20040210/">Specification of RDF/XML</a></li>
	    </ul>
	</xd:detail>
	<xd:author>Christoph Lange</xd:author>
	<xd:copyright>Christoph Lange, 2009</xd:copyright>
	<xd:svnId>$Id: rdf-xml.xsl 1967 2011-04-10 14:28:43Z clange $</xd:svnId>
    </xd:doc>

    <output method="xml" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>

    <xd:doc>Process a single triple, but only output predicate and object.  We assume that the enclosing <code>rdf:Description</code> for the subject has already been created, for this triple and all other triples with the same subject.
	<xd:param name="namespaces" type="node">Prefix to namespace URI mappings to respect (<code>krextor:namespace</code> data structure)</xd:param>
    </xd:doc>
    <template match="rxr:triple" mode="krextor:rxr">
	<param name="namespaces"/>

	<!-- TODO maybe use QName type instead -->
        <variable name="predicate-qname" select="krextor:uri-to-qname(rxr:predicate/@uri, $namespaces)"/>
	<!-- output the predicate(s) with their objects -->
	<element name="{$predicate-qname[2]}:{$predicate-qname[3]}" namespace="{$predicate-qname[1]}">
	    <if test="rxr:object/@xml:lang">
		<attribute name="xml:lang" select="rxr:object/@xml:lang"/>
	    </if>
	    <if test="rxr:object/@datatype">
		<choose>
		    <when test="rxr:object/@datatype eq '&rdf;XMLLiteral'">
			<attribute name="rdf:parseType">Literal</attribute>
		    </when>
		    <otherwise>
			<attribute name="rdf:datatype" select="rxr:object/@datatype"/>
		    </otherwise>
		</choose>
	    </if>
	    <choose>
		<when test="rxr:object/@uri">
		    <attribute name="rdf:resource" select="rxr:object/@uri"/>
		</when>
		<when test="rxr:object/@blank">
		    <attribute name="rdf:nodeID" select="rxr:object/@blank"/>
		</when>
		<otherwise>
		    <copy-of select="rxr:object/node()"/>
		</otherwise>
	    </choose>
	</element>
    </template>

    <xd:doc>We obtain the RDF graph as RXR and then regroup the triples
	by subject</xd:doc>
    <template match="/" mode="krextor:main">
	<variable name="rxr">
	    <apply-imports/>
	</variable>
	<!-- generate namespace prefixes from all properties and class names in the RXR graph -->
	<variable name="namespaces"
	    select="krextor:generate-namespaces-from-uris(
		$rxr/rxr:graph/rxr:triple/rxr:predicate/@uri|
		$rxr/rxr:graph/rxr:triple[rxr:predicate/@uri eq '&rdf;type']/rxr:object/@uri)"/>

	<rdf:RDF>
	    <!-- output generated namespace prefixes -->
	    <apply-templates select="$namespaces" mode="krextor:xmlns"/>

            <for-each-group select="$rxr/rxr:graph/rxr:triple" group-by="(rxr:subject/@blank|rxr:subject/@uri)[1]">
		<!-- if the subject has types, convert the first one into a QName, otherwise use rdf:Description -->
		<variable name="type-triple" select="current-group()[rxr:predicate/@uri eq '&rdf;type'][rxr:object/@uri][1]"/>
		<variable name="type-qname" as="xs:string*">
		    <choose>
			<when test="$type-triple">
			    <sequence select="krextor:uri-to-qname($type-triple/rxr:object/@uri, $namespaces)"/>
			</when>
			<otherwise>
			    <sequence select="('&rdf;', 'rdf', 'Description')"/>
			</otherwise>
		    </choose>
		</variable>
		<variable name="remaining-triples" select="current-group() except ($type-triple)"/>
		
		<!-- output an element representing the subject and its type -->
		<element name="{$type-qname[2]}:{$type-qname[3]}" namespace="{$type-qname[1]}">
		    <choose>
			<when test="current-group()/rxr:subject/@blank">
			    <attribute name="rdf:nodeID" select="current-grouping-key()"/>
			</when>
			<when test="current-group()/rxr:subject/@uri">
			    <attribute name="rdf:about" select="current-grouping-key()"/>
			</when>
		    </choose>
		    <apply-templates select="$remaining-triples" mode="krextor:rxr">
			<with-param name="namespaces" select="$namespaces"/>
		    </apply-templates>
		</element>
	    </for-each-group>
	</rdf:RDF>
    </template>
</stylesheet>
