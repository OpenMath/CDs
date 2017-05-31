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
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:xd="http://www.pnp-software.com/XSLTdoc"
    xmlns:krextor="http://kwarc.info/projects/krextor"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    version="2.0">

    <xd:doc type="stylesheet">
	<xd:short>Utility functions for generated namespace prefixes</xd:short>
	<xd:detail>This stylesheet provides utility functions that generate namespace prefixes and rewrites URIs.</xd:detail>
	<xd:author>Christoph Lange</xd:author>
	<xd:copyright>Christoph Lange, 2009</xd:copyright>
	<xd:svnId>$Id: prefix.xsl 1967 2011-04-10 14:28:43Z clange $</xd:svnId>
    </xd:doc>

    <output method="xml" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>

    <xd:doc>Returns the namespace prefix for a given URI from the default namespace mapping.  This can e.g. come from a triple store.  The actual implementation has to be provided by a template of the same name.</xd:doc>
    <function name="krextor:nsuri-to-prefix" as="xs:string">
	<param name="uri" as="xs:string"/>
	<call-template name="krextor:nsuri-to-prefix">
	    <with-param name="uri" select="$uri"/>
	</call-template>
    </function>

    <xd:doc>No-op implementation of a namespace prefix lookup.  Importing stylesheets will have to override this.</xd:doc>
    <template name="krextor:nsuri-to-prefix" as="xs:string">
	<param name="uri" as="xs:string"/>
	<value-of select="''"/>
    </template>

    <xd:doc>Converts a URI to CURIE (<code>nsprefix:localname</code>) syntax using the default namespace mapping.</xd:doc>
    <function name="krextor:uri-to-curie" as="xs:string">
	<param name="uri" as="xs:string"/>
	<variable name="nsuri-localname"
	    select="krextor:split-prefix-localname($uri)"/>
	<variable name="nsuri"
	    select="$nsuri-localname[1]"/>
	<variable name="localname"
	    select="$nsuri-localname[2]"/>
	<value-of select="concat(krextor:nsuri-to-prefix($nsuri), ':', $localname)"/>
    </function>

    <xd:doc>Naïvely split a given URI into a sequence of namespace prefix and localname; the substring up to and including the last <code>#</code> or <code>/</code> is treated as the namespace prefix.</xd:doc>
    <function name="krextor:split-prefix-localname" as="xs:string*">
	<param name="uri" as="xs:string"/>
	<analyze-string select="$uri" regex="^(.*[/#])([^/#]*)$">
	    <matching-substring>
		<sequence select="regex-group(1), regex-group(2)"/>
	    </matching-substring>
	    <non-matching-substring>
		<sequence select="'', $uri"/>
	    </non-matching-substring>
	</analyze-string>	
    </function>

    <xd:doc>Generates namespace prefixes from all given URIs; returns a sequence of <code>krextor:namespace</code> elements.</xd:doc>
    <function name="krextor:generate-namespaces-from-uris" as="node()*">
	<param name="uris" as="xs:string*"/>
	<krextor:namespace prefix="rdf" uri="&rdf;"/>
	<for-each-group select="$uris[not(starts-with(., '&rdf;'))]" group-by="krextor:split-prefix-localname(.)[1]">
	    <krextor:namespace prefix="ns{position()}" uri="{current-grouping-key()}"/>
	</for-each-group>
    </function>

    <xd:doc>Outputs namespace prefixes as XML namespace nodes (<code>xmlns</code>)</xd:doc>
    <template match="krextor:namespace" mode="krextor:xmlns">
	<namespace name="{@prefix}" select="@uri"/>
    </template>

    <xd:doc>Looks up a namespace prefix for a URI in the given <code>krextor:namespace</code> data structure
	<xd:param name="uri">the URI of the namespace</xd:param>
	<xd:param name="namespaces">the prefix→URI mappings for the namespaces</xd:param>
    </xd:doc>
    <function name="krextor:prefix-from-uri" as="xs:string">
	<param name="uri" as="xs:string"/>
	<param name="namespaces" as="node()*"/>
	<value-of select="$namespaces[@uri eq $uri][1]/@prefix"/>
    </function>

    <!-- TODO maybe use QName type instead -->
    <xd:doc>Rewrites a URI into a qualified name, using the given <code>krextor:namespace</code> mapping
	<xd:param name="uri">the URI</xd:param>
	<xd:param name="namespaces">the prefix→URI mappings for the namespaces</xd:param>
    </xd:doc>
    <function name="krextor:uri-to-qname" as="xs:string*">
	<param name="uri" as="xs:anyURI"/>
	<param name="namespaces" as="node()*"/>

	<variable name="split-uri" select="krextor:split-prefix-localname($uri)"/>
	<variable name="nsuri" select="$split-uri[1]"/>
	<variable name="nsprefix" select="krextor:prefix-from-uri($nsuri, $namespaces)"/>
	<variable name="localname" select="$split-uri[2]"/>

	<sequence select="($nsuri, $nsprefix, $localname)"/>
    </function>
</stylesheet>
