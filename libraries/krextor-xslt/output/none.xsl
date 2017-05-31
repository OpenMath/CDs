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

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:rxr="http://ilrt.org/discovery/2004/03/rxr/"
    xmlns:krextor="http://kwarc.info/projects/krextor"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xd="http://www.pnp-software.com/XSLTdoc"
    exclude-result-prefixes="krextor xd xs"
    version="2.0">
    <xsl:import href="../generic/generic.xsl"/>

    <xd:doc type="stylesheet">This stylesheet does not create any output.  It is intended for debugging.
	<xd:author>Christoph Lange</xd:author>
	<xd:copyright>Christoph Lange, 2008</xd:copyright>
	<xd:svnId>$Id: none.xsl 847 2009-12-05 14:41:20Z clange $</xd:svnId>
    </xd:doc>

    <!-- Note that xml output is possible, too. -->
    <xsl:output method="text" encoding="UTF-8"/>

    <xd:doc>creates one RDF triple</xd:doc>
    <xsl:template name="krextor:output-triple">
	<!-- value of the subject -->
	<xsl:param name="subject" as="xs:string"/>
	<!-- type of the subject: either 'uri' or 'blank' -->
	<xsl:param name="subject-type" as="xs:string"/>

	<!-- value of the predicate -->
	<xsl:param name="predicate" as="xs:anyURI"/>

	<!-- value of the object -->
	<xsl:param name="object" as="xs:string"/>
	<!-- type of the object: either 'uri' or 'blank',
	     or nothing for literal objects -->
	<xsl:param name="object-type" as="xs:string?"/>
	<!-- language annotation is only supported on the object,
	     but neither on triples nor on graphs, as in RXR -->
	<xsl:param name="object-language" as="xs:string?"/>
	<!-- datatype of the (literal) object -->
	<xsl:param name="object-datatype" as="xs:string?"/>

	<!-- output the triple -->
    </xsl:template>

    <xsl:template match="/" mode="krextor:main">
	<!-- begin output -->
	<xsl:apply-imports/>
	<!-- end output -->
    </xsl:template>
</xsl:stylesheet>
