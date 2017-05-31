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
    xmlns:xd="http://www.pnp-software.com/XSLTdoc"
    xmlns:krextor="http://kwarc.info/projects/krextor"
    xmlns:TripleAdder="java:info.kwarc.krextor.TripleAdder"
    xmlns:jt="http://saxon.sf.net/java-type"
    exclude-result-prefixes="#all"
    version="2.0">
    <import href="util/serialize-xml-literal.xsl"/>
    <import href="../generic/generic.xsl"/>

    <xd:doc type="stylesheet">This stylesheet does not output anything but calls back a Java method that processes every triple.
	<xd:author>Christoph Lange</xd:author>
	<xd:copyright>Christoph Lange, 2008</xd:copyright>
	<xd:svnId>$Id: java.xsl 1969 2011-04-15 23:05:12Z clange $</xd:svnId>
    </xd:doc>

    <xd:doc>The callback object</xd:doc>
    <param name="triple-adder" required="yes" as="jt:info.kwarc.krextor.TripleAdder"/>

    <output method="text" encoding="UTF-8"/>

    <xd:doc>Calls the Java callback for one triple</xd:doc>
    <template name="krextor:output-triple">
	<param name="subject"/>
	<param name="subject-type"/>
	<param name="predicate"/>
	<param name="object"/>
	<param name="object-type"/>
	<param name="object-language"/>
	<param name="object-datatype"/>

	<value-of select="TripleAdder:addTriple($triple-adder,
	    $subject,
	    $subject-type,
	    $predicate,
	    $object,
	    $object-type,
	    $object-language,
	    $object-datatype)"/>
    </template>
</stylesheet>
