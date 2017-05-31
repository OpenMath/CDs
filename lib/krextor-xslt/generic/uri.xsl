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
    xpath-default-namespace="http://www.w3.org/1999/XSL/Transform"
    xmlns:krextor="http://kwarc.info/projects/krextor"
    xmlns:krextor-genuri="http://kwarc.info/projects/krextor/genuri"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xd="http://www.pnp-software.com/XSLTdoc"
    xmlns:f="http://fxsl.sf.net/"
    exclude-result-prefixes="#all"
    version="2.0">
    <import href="util.xsl"/>

    <xd:doc type="stylesheet">
	<xd:short>Functions that generate URIs for resources found in documents</xd:short>
	<xd:detail><p>This stylesheet provides functions and templates that generate URIs for resources found in documents</p></xd:detail>
	<xd:author>Christoph Lange</xd:author>
	<xd:copyright>Christoph Lange, 2009</xd:copyright>
	<xd:svnId>$Id: uri.xsl 1771 2010-11-03 17:35:10Z clange $</xd:svnId>
    </xd:doc>

    <xd:doc>
	<xd:short>Should URIs like <code>document#fragment</code> automatically be
	    generated?  Sequence of string values out of <code>xml-id</code>, <code>document-root-base</code>, <code>generate-id</code>, <code>pseudo-xpath</code>, or additional custom values.</xd:short>
	<xd:detail><p>This parameter is a sequence of string values representing URI generation functions:</p>
	    <dl>
		<dt>xml-id</dt>
		<dd>use the <a href="http://www.w3.org/TR/xml-id/">xml:id</a> attribute if available, otherwise nothing</dd>
		<dt>document-root-base</dt>
		<dd>use the base URI if we are on the root element, otherwise nothing.  Note that for meaningful results you should not pass a manipulated base URI into <code>create-resource</code>.</dd>
		<dt>generate-id</dt>
		<dd>generate via <a href="http://www.w3.org/TR/xslt20/#generate-id">generate-id()</a> function (always succeeds)</dd>
		<dt>pseudo-xpath</dt>
		<dd>generate an <a
			href="http://www.w3.org/TR/xpath20/">XPath</a>-like
		    expression from the local names and local positions of the
		    element and its parents (always succeeds; can lead to clashes
		    if elements from different namespaces with the same local names
		    are used in the same context or if dashes are used within
		    element names; inefficient because the whole XPath
		    from the root is newly computed for every element); example:
		    <code>doc-section2-para1</code> =
		    <code>/doc/section[2]/para[1]</code></dd>
	    </dl>
	    <p>The default setting is <code>('xml-id' 'document-root-base')</code>.
		If one method fails to generate a URI, the next one in the list is
		tried, until one succeeds; otherwise, no resource is created for
		the respective node.</p>
	    <p>Note that there is no guarantee that <code>generate-id</code> and
		<code>pseudo-xpath</code> generate URIs that differ from all <a
		    href="http://www.w3.org/TR/xml-id/">xml:id</a>s in the
		document.  We leave the responsibility of not creating too obscure
		<code>xml:id</code>s to the document author.</p>
	    <p>Also note that any fragment ID that the base URI of the document
		already has is discarded and replaced by the generated fragment ID,
		if Krextor is instructed to generate one.  More than one fragment
		is not allowed by the <a
		    href="http://www.faqs.org/rfcs/rfc3986.html">URI RFC 3986</a>.
		See <a
		    href="http://www.aifb.uni-karlsruhe.de/pipermail/swikig/2006-February/000095.html">this
		    e-mail thread from the Semantic Wiki mailing list</a> for more
		background on this in a semantic web context.</p>
	</xd:detail>
    </xd:doc>
    <param name="autogenerate-fragment-uris" as="xs:string*" select="
	'xml-id',
	'document-root-base'"/>

    <xd:doc>Configures whether relative URIs should be resolved into absolute URIs when generating URIs for resources.  Setting it to <code>false</code> is experimental.</xd:doc>
    <param name="resolve-relative-uris" as="xs:boolean" select="true()"/>

    <xd:doc>Resolves a relative URI against a base URI, if URI resolution is globally turned on.</xd:doc>
    <function name="krextor:resolve-uri" as="xs:anyURI">
	<param name="relative" as="xs:string"/>
	<param name="base" as="xs:anyURI"/>
	<value-of select="if ($resolve-relative-uris)
	    then resolve-uri($relative, $base)
	    else $relative"/>
    </function>

    <xd:doc>Controls whether URIs of resources are rewritten from an internal
	representation into an external representation (which will be visible
	in the extracted RDF).  If set to false (default), the internal URIs of
	the input XML documents will also be used in the RDF output.  If true,
	any URI that is part of the output RDF will be rewritten.  The way how
	URIs are rewritten is determined by the implementation of the
	<code>krextor:external-uri</code> template in scope.  This module
	provides a default implementation that performs a regular expression
	replacement, based on the parameters
	<code>document-uri-pattern-match</code> and
	<code>document-uri-pattern-replace</code>.  In the interest of the <a
	    href="http://www.w3.org/DesignIssues/LinkedData.html">linked data
	    conventions</a>, the external URIs should be retrievable URLs
	(pointing to downloadable versions of the original XML
	documents).</xd:doc>
    <param name="rewrite-document-uris" as="xs:string" select="'false'"/>

    <xd:doc>Internal parameter holding the value of <code>rewrite-document-uris</code>, converted to a boolean</xd:doc>
    <param name="rewrite-document-uris-boolean" as="xs:boolean" select="$rewrite-document-uris eq 'true'"/>

    <xd:doc>Rewrites an internal into an external URI if the parameter <code>rewrite-document-uris</code> is set to <code>true</code>.  The actual implementation is provided by a template of the same name.</xd:doc>
    <function name="krextor:external-uri" as="xs:anyURI">
	<param name="internal-uri" as="xs:anyURI"/>
	<choose>
	    <when test="$rewrite-document-uris-boolean">
		<call-template name="krextor:external-uri">
		    <with-param name="internal-uri" select="$internal-uri"/>
		</call-template>
	    </when>
	    <otherwise>
		<value-of select="$internal-uri"/>
	    </otherwise>
	</choose>
    </function>

    <xd:doc>A regular expression pattern that is matched against any URI to be rewritten by the built-in default implementation of the <code>krextor:external-uri</code> template</xd:doc>
    <param name="document-uri-pattern-match" as="xs:string"/>

    <xd:doc>A replacement string (possibly including backreferences to substrings matched by <code>document-uri-pattern-match</code>) that controls how URIs are rewritten by the built-in default implementation of the <code>krextor:external-uri</code> template</xd:doc>
    <param name="document-uri-pattern-replace" as="xs:string"/>

    <xd:doc>Default implementation of the same-named function.  Rewrites an internal into an external URI by a string replacement according to the
	settings of the parameters <code>document-uri-pattern-match</code> and
	<code>document-uri-pattern-replace</code>.
    </xd:doc>
    <template name="krextor:external-uri" as="xs:anyURI">
	<param name="internal-uri" as="xs:anyURI"/>
	<value-of select="xs:anyURI(
	    replace($internal-uri,
		$document-uri-pattern-match,
		$document-uri-pattern-replace))"/>
    </template>

    <xd:doc>Returns the base URI of the given node, after URI rewriting, if rewriting is enabled via the <code>rewrite-document-uris</code> parameter.</xd:doc>
    <function name="krextor:base-uri" as="xs:anyURI">
	<param name="node" as="node()"/>
	<value-of select="krextor:external-uri(base-uri($node))"/>
    </function>

    <xd:doc>Generates a URI for a fragment of a document; returns the empty
	sequence if the fragment ID is empty.</xd:doc>
    <function name="krextor:fragment-uri-or-null" as="xs:anyURI?">
	<param name="fragment-id" as="xs:string?"/>
	<param name="base-uri" as="xs:anyURI"/>
	<value-of select="if ($fragment-id)
	    then krextor:resolve-uri(concat('#', $fragment-id), $base-uri)
	    else ()"/>
    </function>

    <xd:doc>creates an XPath-like string from the path to a node, 
	e.g. <code>doc-sect1-para2</code> for <code>/doc/sect[1]/para[2]</code></xd:doc>
    <function name="krextor:pseudo-xpath" as="xs:string?">
	<param name="node" as="node()"/>
	<!-- TODO maybe also for attribute nodes? -->
	<value-of select="if ($node/parent::node() instance of document-node())
		then local-name($node)
            else if ($node/self::*)
                then concat(
                    krextor:pseudo-xpath($node/parent::node()),
                    '-',
                    local-name($node),
                    count($node/preceding-sibling::node()) + 1
                    )
            else ()"/>
    </function>

    <xd:doc>Generates a URI for a resource using the default generation method and using the base URI of the given node</xd:doc>
    <function name="krextor:generate-uri" as="xs:anyURI">
        <param name="node" as="node()"/>
	<value-of select="krextor:generate-uri($node, krextor:base-uri($node))"/>
    </function>

    <xd:doc>Generates a URI for a resource using the default generation method</xd:doc>
    <function name="krextor:generate-uri" as="xs:anyURI">
        <param name="node" as="node()"/>
        <param name="base-uri" as="xs:anyURI"/>
	<value-of select="krextor:generate-uri($node, krextor:uri-generation-method($node), $base-uri)"/>
    </function>

    <xd:doc>Generates a URI for a resource</xd:doc>
    <function name="krextor:generate-uri" as="xs:anyURI?">
        <param name="node" as="node()"/>
        <param name="autogenerate-fragment-uri" as="xs:string*"/>
        <param name="base-uri" as="xs:anyURI"/>
	<!-- What we'd actually like to do is applying a series of _functions_
	to ($node, $base-uri), but that doesn't work.  It would involve
	currying, and the FXSL implementation of currying breaks nodes in XML
	documents -->
	<value-of select="f:return-first(krextor:generate-uri-impl(), $autogenerate-fragment-uri, ($node, $base-uri))"/>
    </function>

    <xd:doc>Generates a URI for a given node, using a given base URI as appropriate, using the given method
	<xd:param name="method" type="string">the identifier of the URI generation method</xd:param>
	<xd:param name="params">a two-item sequence (<code>node</code>, <code>base-uri</code>)</xd:param>
    </xd:doc>
    <!-- Altova XML reports XTTE0780
    <function name="krextor:generate-uri-impl" as="xs:anyURI?">
    -->
    <function name="krextor:generate-uri-impl">
	<param name="method" as="xs:string"/>
	<param name="params" as="item()+"/>
	<variable name="node" as="node()" select="$params[1]"/>
	<variable name="base-uri" as="xs:anyURI" select="$params[2]"/>
	<variable name="method-element" as="element()">
	    <element name="{concat('krextor-genuri:', $method)}"/>
	</variable>
	<apply-templates select="$method-element">
	    <with-param name="node" select="$node"/>
	    <with-param name="base-uri" select="$base-uri"/>
	</apply-templates>
    </function>

    <xd:doc>Returns the base URI of the document for the root node,
	otherwise the empty sequence.</xd:doc>
    <template match="krextor-genuri:document-root-base" as="xs:string?">
	<param name="node" as="node()"/>
	<param name="base-uri" as="xs:anyURI"/>
	<sequence select="
	    if ($node/parent::node() instance of document-node())
	    then $base-uri
	    else ()"/>
    </template>

    <xd:doc>Common implementation of the <code>xml-id</code>, <code>generate-id</code> and <code>pseudo-xpath</code> URI generation functions.  They all use the given base URI and append a fragment ID; they differ in how the fragment ID is generated.  The base URI is generally assumed to be the URI of the document that contains the given node.</xd:doc>
    <template match="krextor-genuri:xml-id|krextor-genuri:generate-id|krextor-genuri:pseudo-xpath" as="xs:string?">
	<param name="node" as="node()"/>
	<param name="base-uri" as="xs:anyURI"/>
	<sequence select="
	    krextor:fragment-uri-or-null(
		if (self::krextor-genuri:xml-id and $node/@xml:id)
		    then $node/@xml:id
		else if (self::krextor-genuri:generate-id)
		    then generate-id($node)
		else if (self::krextor-genuri:pseudo-xpath)
		    then krextor:pseudo-xpath($node)
		else (),
		$base-uri)"/>
    </template>

    <xd:doc>Returns an FXSL reference to the
	<code>krextor:generate-uri-impl</code> function.</xd:doc>
    <function name="krextor:generate-uri-impl" as="element(krextor:generate-uri-impl)">
	<krextor:generate-uri-impl/>
    </function>

    <xd:doc>FXSL template representing the two-argument <code>krextor:generate-uri-impl</code> function</xd:doc>
    <template match="krextor:generate-uri-impl" as="xs:anyURI?" mode="f:FXSL">
	<param name="arg1" as="xs:string"/>
	<param name="arg2" as="item()+"/>
	<sequence select="krextor:generate-uri-impl($arg1, $arg2)"/>
    </template>

    <xd:doc>Returns the method in which a URI will be generated for the current node unless a different explicit subject URI is passed to <code>krextor:create-resource</code>; extraction modules can override this.</xd:doc>
    <template match="node()" mode="krextor:uri-generation-method" as="xs:string*">
        <sequence select="$autogenerate-fragment-uris"/>
    </template>

    <xd:doc>Returns the method in which a URI will be generated for the given node unless a different explicit subject URI is passed to <code>krextor:create-resource</code>; this calls the template running in the namesake mode.</xd:doc>
    <function name="krextor:uri-generation-method" as="xs:string*">
	<param name="node" as="node()"/>
	<apply-templates select="$node"
	    mode="krextor:uri-generation-method"/>
    </function>
</stylesheet>

