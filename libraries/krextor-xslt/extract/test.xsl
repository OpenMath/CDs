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
    <!ENTITY test "http://kwarc.info/projects/krextor/test#">
]>

<stylesheet xmlns="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xd="http://www.pnp-software.com/XSLTdoc"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:krextor="http://kwarc.info/projects/krextor"
    exclude-result-prefixes="#all"
    version="2.0">

    <xd:doc type="stylesheet">
	Extraction module that simply generates one triple for testing purposes
	<xd:author>Christoph Lange</xd:author>
	<xd:copyright>Christoph Lange, 2010</xd:copyright>
	<xd:svnId>$Id: test.xsl 1529 2010-04-27 10:21:16Z clange $</xd:svnId>
    </xd:doc>

    <template match="/*[1]" mode="krextor:main">
        <!-- we can't simply match /, as that is matched by generic.xsl -->
        <call-template name="krextor:output-triple-impl">
            <with-param name="subject" select="'&test;subject'"/>
            <with-param name="predicate" select="xs:anyURI('&test;predicate')"/>
            <with-param name="object" select="'Hello, World!'"/>
        </call-template>
    </template>
</stylesheet>
