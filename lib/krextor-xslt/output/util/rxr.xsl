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
    xmlns:rxr="http://ilrt.org/discovery/2004/03/rxr/"
    xmlns:krextor="http://kwarc.info/projects/krextor"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    version="2.0">
    <import href="prefix.xsl"/>

    <xd:doc type="stylesheet">
	<xd:short>Functions for querying RDF graphs encoded as RXR</xd:short>
	<xd:detail>Functions for querying RDF graphs encoded as RXR (Regular
	    XML RDF).  References:
	    <ul>
		<li><a href="http://www.idealliance.org/papers/dx_xmle04/papers/03-08-03/03-08-03.html">David Beckett: Modernising Semantic Web Markup</a></li>
		<li><a href="http://ilrt.org/discovery/2004/03/rxr/">XML schemas for RXR</a></li>
	    </ul>
	</xd:detail>
	<xd:author>Christoph Lange</xd:author>
	<xd:copyright>Christoph Lange, 2008</xd:copyright>
	<xd:svnId>$Id: rxr.xsl 842 2009-11-28 23:10:35Z clange $</xd:svnId>
    </xd:doc>

    <output method="xml" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>

    <xd:doc>Generates namespace prefixes from all URIs that occur in the given RXR graph; calls <code>krextor:generate-namespaces-from-uris</code> and returns a sequence of <code>krextor:namespace</code> elements.</xd:doc>
    <function name="krextor:generate-namespaces-from-rxr" as="node()*">
	<param name="rxr" as="node()"/>
	<copy-of select="krextor:generate-namespaces-from-uris(
			(
				(: all places where RDFa only allows CURIEs :)
				$rxr/rxr:graph/rxr:triple/rxr:predicate/@uri,
				$rxr/rxr:graph/rxr:triple[rxr:predicate/@uri eq '&rdf;type']/rxr:object/@uri,
				$rxr/rxr:graph/rxr:triple/rxr:object/@datatype
			)
		)"/>
    </function>

    <xd:doc>Implementation of <code>krextor:query-triples</code> for RXR graphs
	<xd:param name="rxr">the RXR graph, a sequence of <code>rxr:triple</code> nodes</xd:param>
    </xd:doc>
    <function name="krextor:query-rxr-graph" as="node()*">
	<param name="rxr" as="node()"/>
	<param name="subject" as="xs:string*"/>
    	<param name="subject-type" as="xs:string"/>
    	<param name="predicate" as="xs:string*"/>
    	<param name="object" as="xs:string*"/>
    	<param name="object-type" as="xs:string"/>
    	<param name="object-language" as="xs:string"/>
    	<param name="object-datatype" as="xs:string"/>
	<copy-of select="$rxr/rxr:graph/rxr:triple[
	    (
		(: restrictions on the subject :)
		not($subject)
		or (
		    if ($subject-type eq 'blank')
		    then $subject = rxr:subject/@blank
		    else $subject = rxr:subject/@uri
		)
	    ) and (
		(: restrictions on the predicate :)
		not($predicate)
		or (
		    $predicate = rxr:predicate/@uri
		)
	    ) and (
		(: restrictions on the object :)
		(
		    not($object)
		    or (
			if ($object-type eq 'blank')
			then $object = rxr:object/@blank
			else $object = rxr:object/@uri
		    )
		) and (
		    not($object-language) 
		    or $object-language eq rxr:object/@xml:lang
		)
		and
		(
		    not($object-datatype)
		    or $object-datatype eq rxr:object/@datatype
		)
	    )
	    ]"/>
    </function>
</stylesheet>
