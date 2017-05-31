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

<stylesheet xmlns="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xd="http://www.pnp-software.com/XSLTdoc"
    xmlns:krextor="http://kwarc.info/projects/krextor"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    version="2.0">
    <import href="serialize-xml-literal.xsl"/>
    <import href="../../extract/util/openmath/verb.xsl"/>

    <xd:doc type="stylesheet">
	<xd:short>Utility functions and templates for Turtle-like output</xd:short>
	<xd:detail>This stylesheet provides utility functions for creating output 
	    in Turtle-like RDF serializations.
	    <ul>
		<li><a href="http://www.w3.org/TeamSubmission/turtle/">Specification of Turtle</a></li>
	    </ul>
	</xd:detail>
	<xd:author>Christoph Lange</xd:author>
	<xd:copyright>Christoph Lange, 2009</xd:copyright>
	<xd:svnId>$Id: turtle.xsl 1972 2011-04-16 23:11:44Z clange $</xd:svnId>
    </xd:doc>

    <xd:doc>TODO</xd:doc>
    <function name="krextor:construct-turtle-uri" as="xs:string">
	<param name="uri"/>
        <value-of select="concat('&lt;', $uri, '&gt;')"/>
    </function>

    <xd:doc>TODO</xd:doc>
    <function name="krextor:node-id-to-turtle" as="xs:string">
	<param name="id" as="xs:string"/>
	<param name="type" as="xs:string"/>
	<choose>
	    <when test="$type eq 'uri'">
		<value-of select="krextor:construct-turtle-uri($id)"/>
	    </when>
	    <when test="$type eq 'blank'">
		<value-of select="concat('_:', $id)"/>
	    </when>
	    <!-- TODO verify bnode syntax -->
	    <!-- TODO fail in 'else' case -->
	    <otherwise>
		<value-of select="''"/>
	    </otherwise>
	</choose>
    </function>

    <xd:doc>TODO</xd:doc>
    <function name="krextor:lang-datatype-to-turtle" as="xs:string">
	<param name="lang"/>
	<param name="datatype"/>
	<!-- FIXME check if """...""" is allowed in N-Triples, otherwise move to Turtle -->
        <value-of select="
            if ($lang) then concat('@', $lang)
	    else if ($datatype) then concat('^^', krextor:construct-turtle-uri($datatype))
	    else ''"/>
    </function>

    <xd:doc>TODO</xd:doc>
    <function name="krextor:escape-turtle-string" as="xs:string">
	<param name="value" as="xs:string"/>
	<param name="allow-multiline" as="xs:boolean"/>
        <variable name="escaped-with-multiline" select="replace(
            replace(
            replace(
            replace($value,
            '\\', '\\\\'), (: this is evaluated first :)
            '&quot;', '\\&quot;'),
            '&#xd;', '\\r'),
            '&#x9;', '\\t')
            "/>
        <value-of select="if ($allow-multiline) then $escaped-with-multiline
            else replace($escaped-with-multiline, '&#xa;', '\\n')"/>
    </function>

    <xd:doc>TODO</xd:doc>
    <function name="krextor:construct-turtle-string" as="xs:string">
	<param name="value" as="xs:string"/>
	<param name="allow-multiline" as="xs:boolean"/>
        <value-of select="
            if ($allow-multiline and contains($value, '&#xa;'))
            then concat('&quot;&quot;&quot;', krextor:escape-turtle-string($value, true()), '&quot;&quot;&quot;')
            else concat('&quot;', krextor:escape-turtle-string($value, false()), '&quot;')
            "/>
    </function>

    <xd:doc>TODO</xd:doc>
    <function name="krextor:construct-turtle-string" as="xs:string">
	<param name="value" as="xs:string"/>
        <value-of select="
            krextor:construct-turtle-string($value, true())"/>
    </function>

    <xd:doc>Serializes a literal for Turtle
      <xd:param name="value">The value (“lexical form”) of the literal, as string</xd:param>
      <xd:param name="lang">The language annotation of the literal</xd:param>
      <xd:param name="datatype">The datatype of the literal (a URI)</xd:param>
    </xd:doc>
    <function name="krextor:literal-to-turtle" as="xs:string">
	<param name="value" as="xs:string"/>
	<param name="lang"/>
	<param name="datatype"/>
	<value-of select="concat(
	    (: the value :)
            krextor:construct-turtle-string($value),
	    (: the language or datatype annotation :)
	    krextor:lang-datatype-to-turtle($lang, $datatype))"/>
    </function>

    <xd:doc>Serializes a literal for N-Triples
      <xd:param name="value">The value of the literal, as string</xd:param>
      <xd:param name="lang">The language annotation of the literal</xd:param>
      <xd:param name="datatype">The datatype of the literal (a URI)</xd:param>
    </xd:doc>
    <function name="krextor:literal-to-ntriples" as="xs:string">
	<param name="value" as="xs:string"/>
	<param name="lang"/>
	<param name="datatype"/>
	<!-- FIXME check if """...""" is allowed in N-Triples, otherwise move to Turtle -->
	<value-of select="concat(
	    (: the value :)
            krextor:construct-turtle-string($value, false()),
	    (: the language or datatype annotation :)
	    krextor:lang-datatype-to-turtle($lang, $datatype))"/>
    </function>

</stylesheet>
