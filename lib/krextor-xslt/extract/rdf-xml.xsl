<?xml version="1.0" encoding="UTF-8"?>

<!--
    *  Copyright (C) 2011
    *  Christoph Lange
    *  Universität Bremen and
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
    xmlns:krextor="http://kwarc.info/projects/krextor"
    xmlns:krextor-genuri="http://kwarc.info/projects/krextor/genuri"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xd="http://www.pnp-software.com/XSLTdoc"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    exclude-result-prefixes="#all"
    version="2.0">

    <xd:doc type="stylesheet">
        <xd:short>Extraction module for RDF/XML</xd:short>
	<xd:detail><p>a very simple and incomplete extraction module for RDF/XML</p></xd:detail>
        <xd:author>Christoph Lange</xd:author>
        <xd:copyright>Christoph Lange, 2011</xd:copyright>
        <xd:svnId>$Id: rdf-xml.xsl 2005 2011-07-17 11:21:45Z clange $</xd:svnId>
    </xd:doc>

    <include href="util/rdf-xml.xsl"/>
    
    <param name="autogenerate-fragment-uris" select="'rdf-xml'"/>
    <!--
    <param name="merge-rdf" select="'file:/mnt/data/svn/kwarc.info/swim/projects/krextor/trunk/test/unit/extract/rdf-xml/resource-merge.rdf'"/>
    -->

    <strip-space elements="*"/>
    
    <template match="krextor-genuri:rdf-xml" as="xs:string?">
        <param name="node"/>
        <param name="base-uri"/>
        <sequence select="krextor:rdf-xml-uri($node, $base-uri)"/>
    </template>
</stylesheet>
<!--
Local Variables:
mode: xsl
xsl-element-indent-step: 4
End:
-->
