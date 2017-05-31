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
    xpath-default-namespace="http://www.w3.org/1999/xhtml"
    xmlns:xd="http://www.pnp-software.com/XSLTdoc"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:krextor="http://kwarc.info/projects/krextor"
    version="2.0">
    <xd:doc type="stylesheet">
	A collection of templates and utility functions for generic <a href="http://www.w3.org/TR/rdfa-primer/">RDFa</a> support, independently of the host language
	<xd:author>Christoph Lange</xd:author>
	<xd:copyright>Christoph Lange, 2008</xd:copyright>
	<xd:svnId>$Id: rdfa.xsl 1968 2011-04-11 08:20:37Z clange $</xd:svnId>
    </xd:doc>

    <xd:doc type="string">Returns the default namespace URI for a CURIE of the form <code>:localname</code>.  As this is up to the host language, this is an empty implementation and intended to be overridden by the importing template.
	<xd:param name="focus" type="node">the focus node, for the namespace context</xd:param>
    </xd:doc>
    <function name="krextor:default-curie-namespace">
	<param name="focus"/>
    </function>

    <xd:doc type="string">Returns the namespace URI that is bound to the empty prefix.
	<xd:param name="focus" type="node">the focus node, for the namespace context</xd:param>
    </xd:doc>
    <function name="krextor:default-namespace">
	<param name="focus"/>
	<value-of select="namespace-uri-from-QName(resolve-QName('dummy', $focus))"/>
    </function>

    <function name="krextor:curie-to-uri">
	<param name="focus" as="attribute()"/>
	<sequence select="krextor:curie-to-uri($focus/parent::*, $focus)"/>
    </function>

    <xd:doc type="string">Converts a CURIE to a URI, using the current namespace context.
	<xd:param name="focus" type="node">the focus node, for the namespace context</xd:param>
	<xd:param name="curie" type="string">the CURIE</xd:param>
    </xd:doc>
    <function name="krextor:curie-to-uri">
	<param name="focus"/>
	<param name="curie"/>
	<choose>
	    <when test="$curie">
		<analyze-string select="$curie" regex="^(([^:]*):)?(.+)$">
		    <matching-substring>
			<variable name="no-prefix" select="not(matches(regex-group(1), ':$'))"/>
			<variable name="prefix" select="regex-group(2)"/>
			<variable name="localname" select="regex-group(3)"/>
			<choose>
			    <!-- the "no prefix" case is special and may not be
			         supported by every host language -->
			    <when test="$no-prefix">
				<variable name="curie">
				    <krextor:curie>
					<!-- note that $localname is the same as $curie -->
					<value-of select="$localname"/>
				    </krextor:curie>
				</variable>
				<apply-templates mode="krextor:resolve-prefixless-curie" select="$curie"/>
			    </when>
			    <otherwise>
				<variable name="resolved-uri" select="resolve-QName(
				    if ($prefix eq '') then $localname
				    else $curie,
				    $focus)"/>
				<!-- the "empty prefix" case is special and may not be
				     supported by every host language -->
				<variable name="namespace-uri" select="
				    if ($prefix eq '')
				    then krextor:default-curie-namespace($focus)
				    else namespace-uri-from-QName($resolved-uri)"/>
				    
				<value-of select="if ($namespace-uri)
				    then concat($namespace-uri,
					local-name-from-QName($resolved-uri))
				    else ()"/>
			    </otherwise>
			</choose>
		    </matching-substring>
		</analyze-string>
	    </when>
	    <otherwise>
		<value-of select="()"/>
	    </otherwise>
	</choose>
    </function>

    <function name="krextor:curies-to-uris">
	<param name="focus" as="attribute()"/>
	<sequence select="krextor:curies-to-uris($focus/parent::*, $focus)"/>
    </function>

    <xd:doc type="string*">Converts a sequence of CURIEs to a sequence of URIs, using the current namespace context.
	<xd:param name="focus" type="node">the focus node, for the namespace context</xd:param>
	<xd:param name="curies" type="string*">the CURIEs</xd:param>
    </xd:doc>
    <function name="krextor:curies-to-uris">
	<param name="focus"/>
	<param name="curies"/>
	<choose>
	    <when test="matches($curies, ' ')">
		<sequence select="for $c in tokenize($curies, '\s+')
		    return krextor:curie-to-uri($focus, $c)"/>
	    </when>
	    <otherwise>
		<sequence select="krextor:curie-to-uri($focus, $curies)"/>
	    </otherwise>
	</choose>
    </function>

    <function name="krextor:safe-curie-to-uri" as="xs:anyURI">
	<param name="focus" as="attribute()"/>
	<sequence select="krextor:safe-curie-to-uri($focus/parent::*, $focus)"/>
    </function>

    <xd:doc type="string">Converts a safe CURIE to a URI, using the current namespace context if the safe CURIE actually is a CURIE.
	<xd:param name="focus" type="node">the focus node, for the namespace context</xd:param>
	<xd:param name="safe-curie" type="string*">the safe CURIE</xd:param>
    </xd:doc>
    <function name="krextor:safe-curie-to-uri" as="xs:anyURI">
	<param name="focus" as="node()"/>
	<param name="safe-curie" as="xs:string"/>
	<choose>
	    <when test="string-length($safe-curie) gt 0">
		<analyze-string select="$safe-curie" regex="^\[([^\]]+)\]$">
		    <matching-substring>
			<value-of select="krextor:curie-to-uri($focus, regex-group(1))"/>
		    </matching-substring>
		    <non-matching-substring>
			<value-of select="$safe-curie"/>
		    </non-matching-substring>
		</analyze-string>
	    </when>
	    <otherwise>
		<value-of select="$safe-curie"/>
	    </otherwise>
	</choose>
    </function>

    <xd:doc>Extracts a literal-valued property</xd:doc>
    <template match="@property" mode="krextor:main">
	<variable name="parent" select="parent::*"/>
	<variable name="object">
	    <choose>
		<!-- @content -->
		<when test="$parent/@content">
		    <value-of select="$parent/@content"/>
		</when>
		<!-- XML literal -->
		<when test="$parent/* and (not($parent/@datatype) or krextor:curie-to-uri($parent/@datatype) eq '&rdf;XMLLiteral')">
		    <!-- reparent node to facilitate processing
		         TODO is that really necessary? -->
		    <variable name="node">
			<copy-of select="$parent/node()"/>
		    </variable>
		    <apply-templates select="$node" mode="krextor:prepare-xml-literal">
			<with-param name="lang" select="ancestor::*/@xml:lang[1]" tunnel="yes"/>
		    </apply-templates>
		</when>
		<!-- XML content but no XMLLiteral datatype given -->
		<otherwise>
		    <apply-templates select="$parent/node()" mode="krextor:text"/>
		</otherwise>
	    </choose>
	</variable>

	<if test="$debug">
	    <message>adding</message>
	    <message select="."/>
	</if>

	<call-template name="krextor:add-literal-property">
	    <!-- this function returns NIL if there is no @property attribute.
	         Then, add-literal-property completes an incomplete triple -->
	    <with-param name="property" select="krextor:curies-to-uris(.)"/>
	    <with-param name="object" select="$object"/>
	    <with-param name="language" select="ancestor::*/@xml:lang[1]"/>
	    <!-- TODO test with datatype="" -->
	    <with-param name="datatype" select="if ($parent/* and not($parent/@datatype))
		then '&rdf;XMLLiteral'
		else if ($parent/@datatype) then krextor:curie-to-uri($parent, $parent/@datatype)
		else ()"/>
	    <!-- TODO implement other @datatype cases -->
	</call-template>
    </template>

    <template match="text()" mode="krextor:text">
	<value-of select="."/>
    </template>

    <template match="*" mode="krextor:text">
	<apply-templates mode="krextor:text"/>
    </template>

    <xd:doc>Extracts a URI-valued property (<code>rel</code>) whose object is not yet known</xd:doc>
    <template match="@rel[not(parent::*/@resource or parent::*/@href)]" mode="krextor:main">
	<param name="subject-uri" tunnel="yes"/>

	<if test="$debug">
	    <message>@rel[not(parent::*/@resource or parent::*/@href)]</message>
	    <message>REL</message>
	    <message select="."/>
	    <message>PARENT</message>
	    <message select="parent::*/*"/>
	    <message>NEXT</message>
	    <message select="parent::*/*"/>
	</if>

	<!--
	<call-template name="krextor:create-property">
	    <with-param name="property" select="krextor:curies-to-uris(.)"/>
	    <with-param name="process-next" select="parent::*/*"/>
	</call-template>
	-->
	<variable name="property" select="krextor:curies-to-uris(.)"/>
	<variable name="blank-node" select="not(parent::*/@about) or parent::*/@typeof"/>
	<call-template name="krextor:create-resource">
	    <with-param name="blank-node" select="$blank-node"/>
	    <with-param name="related-via-properties" select="if(not($blank-node)) then () else $property" tunnel="yes"/>
	    <with-param name="process-next" select="parent::*/*"/>
	    <with-param name="tunneled-property" select="$property" tunnel="yes"/>
	</call-template>
    </template>

    <xd:doc>Extracts a URI-valued inverse property (<code>rev</code>) whose object is not yet known</xd:doc>
    <template match="@rev[not(parent::*/@resource or parent::*/@href)]" mode="krextor:main">
	<!--
	<call-template name="krextor:create-property">
	    <with-param name="property" select="krextor:curies-to-uris(.)"/>
	    <with-param name="inverse" select="true()"/>
	    <with-param name="process-next" select="parent::*/*"/>
	</call-template>
	-->
	<variable name="property" select="krextor:curies-to-uris(.)"/>
	<call-template name="krextor:create-resource">
	    <with-param name="blank-node" select="not(parent::*/@about)"/>
	    <with-param name="related-via-inverse-properties" select="if(parent::*/@about) then () else $property" tunnel="yes"/>
	    <with-param name="process-next" select="parent::*/*"/>
	    <with-param name="tunneled-property" select="$property" tunnel="yes"/>
	    <with-param name="tunneled-inverse" select="true()" tunnel="yes"/>
	</call-template>
    </template>

    <template match="@rel|@rev" mode="krextor:main">
	<if test="$debug">
	    <message>PIVOTING RESOURCE</message>
	</if>

	<variable name="parent" select="parent::*"/>
	<apply-templates select="$parent/@resource|$parent/@href"/>
    </template>

    <function name="krextor:safe-curie-to-bnode-id" as="xs:string?">
	<param name="safe-curie"/>
	<analyze-string select="$safe-curie" regex="^\[_:(.+)\]$">
	    <matching-substring>
		<value-of select="regex-group(1)"/>
	    </matching-substring>
	</analyze-string>
    </function>

    <xd:doc>Extracts a URI-valued property</xd:doc>
    <template match="@resource|@src|@href[not(parent::*/@resource)]" mode="krextor:main">
	<variable name="parent" select="parent::*"/>
	<variable name="blank" select="if ($parent/@resource) then krextor:safe-curie-to-bnode-id($parent/@resource) else ()"/>
	<variable name="object" as="xs:anyURI" select="if ($parent/@resource and not($blank)) then krextor:safe-curie-to-uri($parent/@resource) else ."/>

	<if test="$debug">
	    <message>ME</message>
	    <message select="."/>
	    <message>OBJECT</message>
	    <message select="$object"/>
	    <message>BLANK</message>
	    <message select="$blank"/>
	</if>

	<if test="$parent/@rel">
	    <call-template name="krextor:add-uri-property">
		<with-param name="property" select="krextor:curies-to-uris($parent/@rel)"/>
		<with-param name="object" select="$object"/>
		<with-param name="blank" select="$blank"/>
	    </call-template>
	</if>
	<if test="$parent/@rev">
	    <call-template name="krextor:add-uri-property">
		<with-param name="property" select="krextor:curies-to-uris($parent/@rev)"/>
		<with-param name="inverse" select="true()"/>
		<with-param name="object" select="$object"/>
		<with-param name="blank" select="$blank"/>
	    </call-template>
	</if>
	<if test="not($parent/@rel|$parent/@rev)">
	    <call-template name="krextor:add-uri-property">
		<with-param name="object" select="$object"/>
		<with-param name="blank" select="$blank"/>
	    </call-template>
	</if>
	<if test="$parent/*">
	    <apply-templates select="$parent/*">
		<with-param name="subject-uri" select="$object" tunnel="yes"/>
		<with-param name="blank-node-id" select="()" tunnel="yes"/>
	    </apply-templates>
	</if>
    </template>
</stylesheet>
