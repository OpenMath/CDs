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
        <xd:short>Utility functions for processing RDF/XML</xd:short>
        <xd:author>Christoph Lange</xd:author>
        <xd:copyright>Christoph Lange, 2011</xd:copyright>
        <xd:svnId>$Id: rdf-xml.xsl 2008 2011-07-18 23:13:06Z clange $</xd:svnId>
    </xd:doc>

    <template match="krextor-genuri:rdf-xml" as="xs:anyURI?">
        <param name="node"/>
        <param name="base-uri"/>
        <!-- TODO once we support rdf:ID, we need to take xml:base into account -->
        <sequence select="xs:anyURI($node[self::rdf:*]/@rdf:about)"/>
    </template>

    <template match="rdf:*" mode="krextor:uri-generation-method" as="xs:string*">
      <sequence select="'rdf-xml'"/>
    </template>

    <strip-space elements="*"/>

    <!-- we match everything against absolute XPaths, as this module is intended to be used from other extraction modules, for merging triples from an RDF/XML source into the RDF graph extracted from the primary input. -->
    <template match="/rdf:RDF" mode="krextor:main">
        <apply-templates mode="krextor:main"/>
        <!-- TODO reset xml:base -->
    </template>

    <template match="/rdf:RDF//rdf:Description" mode="krextor:main" priority="2">
        <call-template name="krextor:create-resource"/>
    </template>
    
    <template match="/rdf:RDF//*[@rdf:resource]" mode="krextor:main" priority="2">
        <call-template name="krextor:add-uri-property">
            <with-param name="property" select="concat(namespace-uri(), local-name())"/>
            <with-param name="object" select="@rdf:resource"/>
        </call-template>
    </template>
    
    <template match="/rdf:RDF//*" mode="krextor:main" priority="1.5">
        <call-template name="krextor:add-literal-property">
            <with-param name="property" select="concat(namespace-uri(), local-name())"/>
            <with-param name="object" select="text()"/>
        </call-template>
    </template>
</stylesheet>
<!--
Local Variables:
mode: xsl
xsl-element-indent-step: 4
End:
-->
