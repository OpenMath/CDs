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
    xmlns:krextor="http://kwarc.info/projects/krextor"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    version="2.0">
    <import href="../generic/generic.xsl"/>
    <import href="util/turtle.xsl"/>

    <xd:doc type="stylesheet">
	<xd:short>Output module for N-Triples</xd:short>
	<xd:detail>This stylesheet provides low-level triple-creation functions
	    and templates for an N-Triples extraction from XML languages.
	    <ul>
		<li><a href="http://www.w3.org/TR/rdf-testcases/#ntriples">Specification of N-Triples</a></li>
	    </ul>
	</xd:detail>
	<xd:author>Christoph Lange</xd:author>
	<xd:copyright>Christoph Lange, 2009</xd:copyright>
	<xd:svnId>$Id: ntriples.xsl 1972 2011-04-16 23:11:44Z clange $</xd:svnId>
    </xd:doc>

    <!-- TODO change to US-ASCII and implement encoding of all non-ASCII characters -->
    <output method="text" encoding="UTF-8"/>

    <xd:doc>Outputs one triple</xd:doc>
    <template name="krextor:output-triple">
	<param name="subject"/>
	<param name="subject-type"/>
	<param name="predicate"/>
	<param name="object"/>
	<param name="object-type"/>
	<param name="object-language"/>
	<param name="object-datatype"/>

	<value-of select="krextor:node-id-to-turtle($subject, $subject-type)"/>
	<text>&#x9;</text>
	<value-of select="concat('&lt;', $predicate, '&gt;')"/>
	<text>&#x9;</text>
	<value-of select="if ($object-type = ('uri', 'blank')) then
		krextor:node-id-to-turtle($object, $object-type)
	    else
		krextor:literal-to-ntriples($object, $object-language, $object-datatype)"/>
	<text> .&#xa;</text>
    </template>
</stylesheet>
