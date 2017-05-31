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
    xpath-default-namespace="http://www.w3.org/1999/XSL/Transform"
    xmlns:krextor="http://kwarc.info/projects/krextor"
    xmlns:xi="http://www.w3.org/2001/XInclude"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xd="http://www.pnp-software.com/XSLTdoc"
    xmlns:f="http://fxsl.sf.net/"
    exclude-result-prefixes="#all"
    version="2.0">

    <import href="uri.xsl"/>

    <xd:doc type="stylesheet">
	<xd:short>Convenience functions and templates for extracting RDF from XML languages, independent both from the XML input language and from the RDF output notation</xd:short>
	<xd:detail><p>This stylesheet provides convenience functions and templates for an RDF extraction from XML languages.  It is independent of any RDF output notation.</p></xd:detail>
	<xd:author>Christoph Lange</xd:author>
	<xd:copyright>Christoph Lange, 2008</xd:copyright>
	<xd:svnId>$Id: generic.xsl 2014 2011-07-27 16:48:43Z clange $</xd:svnId>
    </xd:doc>

    <include href="../extract/util/rdf-xml.xsl"/>

    <xd:doc>Enable debug output?</xd:doc>
    <param name="debug" as="xs:boolean" select="false()"/>

    <xd:doc>Configures whether XIncludes should be traversed.  Note that templates for nodes in XIncluded documents are matched in <code>krextor:included</code> mode.</xd:doc>
    <param name="traverse-xincludes" as="xs:boolean" select="true()"/>

    <!-- Points to an RDF/XML document whose data should be merged with the data extracted from the current input -->
    <param name="merge-url-pattern-match" as="xs:string"/>
    <param name="merge-url-pattern-replace" as="xs:string"/>

    <variable name="krextor:resources" as="element()*" select="()"/>
    <variable name="krextor:literal-properties" as="element()*" select="()"/>

    <xd:doc>Checks whether a given node is a text node, an attribute, or an atomic value</xd:doc>
    <function name="krextor:is-text-or-attribute-or-atomic" as="xs:boolean">
	<!-- can be of almost any type -->
	<param name="node"/>
        <value-of select="$node instance of xs:anyAtomicType
            or $node instance of text()
            or $node instance of attribute()"/>
    </function>

    <function name="krextor:is-single-element" as="xs:boolean">
        <param name="node"/>
        <value-of select="$node/self::document-node()
            and count($node/node()) eq 1
            and $node/node()/self::element()"/>
    </function>

    <function name="krextor:normalize-single-element">
        <param name="node"/>
        <copy-of select="if (krextor:is-single-element($node))
                         then $node/node()/self::element()
                         else $node"/>
    </function>

    <xd:doc>
      <xd:short>Calls the output module template that outputs one RDF triple</xd:short>
      <xd:detail>Calls the output module template that outputs one RDF triple.  URIs are resolved against the base URI before, if there is a base
	URI.
        <xd:param name="subject">the identifier of the subject, either a URI or a blank node ID</xd:param>
        <xd:param name="subject-type">the type of the subject identifier, either <code>'uri'</code> or <code>'blank'</code></xd:param>
        <xd:param name="predicate">the identifier of the predicate, always a URI</xd:param>
        <xd:param name="object">the value of the object, either a URI or a blank node ID or a literal</xd:param>
        <xd:param name="object-type">the type of the object, either <code>'uri'</code> or <code>'blank'</code>, or nothing for literal objects.  A literal can be given as a string (or text node), or as any other XML</xd:param>
        <xd:param name="object-language">the language of a literal object.  Language annotation is only supported on the object,
	     but neither on triples nor on graphs, as in RXR</xd:param>
        <xd:param name="object-datatype">the datatype of a literal object</xd:param>
        <xd:param name="krextor:base-uri">a static base URI (as, e.g., defined by <code>base/@href</code> in XHTML), against which every URL is resolved</xd:param>
      </xd:detail>
    </xd:doc>
    <template name="krextor:output-triple-impl">
	<param name="subject" as="xs:string" required="yes"/>
	<param name="subject-type" as="xs:string" select="'uri'"/>

	<param name="predicate" as="xs:anyURI" required="yes"/>

	<param name="object" required="yes"/>
	<param name="object-type" as="xs:string" select="''"/>
	<param name="object-language" as="xs:string?"/>
	<param name="object-datatype" as="xs:string?"/>

	<param name="krextor:base-uri" as="xs:anyURI" tunnel="yes"/>

	<!-- for debugging:
	<message>NEW RDF TRIPLE</message>
	<message>subject = <value-of select="$subject"/></message>
	<message>subject-type = <value-of select="$subject-type"/></message>
	<message>predicate = <value-of select="$predicate"/></message>
	<message>object = <value-of select="$object"/></message>
	<message>object-type = <value-of select="$object-type"/></message>
	<message>object-language = <value-of select="$object-language"/></message>
	<message>object-datatype = <value-of select="$object-datatype"/></message>
	<message>krextor:base-uri = <value-of select="$krextor:base-uri"/></message>
	-->

	<!-- Some sanity checks -->
	<if test="not($subject-type = ('uri', 'blank'))">
	    <message terminate="yes" select="concat('Invalid subject type: ', $subject-type)"/>
	</if>
	<if test="not($object-type = ('uri', 'blank', ''))">
	    <message terminate="yes" select="concat('Invalid object type: ', $subject-type)"/>
	</if>

	<!-- Call the output module -->
	<call-template name="krextor:output-triple">
	    <with-param name="subject" select="if ($subject-type eq 'uri' and $krextor:base-uri)
		then resolve-uri($subject, $krextor:base-uri)
		else $subject"/>
	    <with-param name="subject-type" select="$subject-type"/>
	    <with-param name="predicate" select="$predicate"/>
	    <with-param name="object" select="if ($object-type eq 'uri' and $krextor:base-uri)
		then resolve-uri($object, $krextor:base-uri)
		else krextor:preprocess-object-for-output($object)"/>
	    <with-param name="object-type" select="$object-type"/>
	    <with-param name="object-language" select="$object-language"/>
	    <with-param name="object-datatype" select="$object-datatype"/>
	</call-template>
    </template>

    <function name="krextor:preprocess-object-for-output">
       <param name="object"/>
       <call-template name="krextor:preprocess-object-for-output">
         <with-param name="object" select="$object"/>
       </call-template>
    </function>

    <template name="krextor:preprocess-object-for-output">
       <param name="object"/>
       <copy-of select="$object"/>
    </template>

    <xd:doc>
      <xd:short>Relates the current resource to its parent resource via some properties</xd:short>
      <xd:detail>Relates the current resource to the "parent" resource, i.e. the nearest resource created from a template lower in the call stack, via some RDF properties or their inverses.
        <xd:param name="properties">a sequence of property URIs</xd:param>
        <xd:param name="inverse">By default, this is <code>false()</code>, and the relation is created in parent→current direction.  If this is set to <code>true()</code>, the relation is created in inverse direction, i.e. current→parent.</xd:param>
      </xd:detail>
    </xd:doc>
    <template name="krextor:related-via-properties">
	<param name="properties" as="xs:string*" select="()"/>
	<param name="inverse" as="xs:boolean" select="false()"/>

	<!-- The identifier of the current resource -->
	<param name="blank-node" as="xs:boolean"/>
	<param name="generated-blank-node-id" as="xs:string"/>
	<param name="generated-uri" as="xs:anyURI"/>
	<for-each select="$properties">
	    <if test=".">
		<choose>
		    <when test="$blank-node">
			<call-template name="krextor:add-uri-property">
			    <with-param name="property" select="."/>
			    <with-param name="inverse" select="$inverse"/>
			    <with-param name="blank" select="$generated-blank-node-id"/>
			</call-template>
		    </when>
		    <otherwise>
			<call-template name="krextor:add-uri-property">
			    <with-param name="property" select="."/>
			    <with-param name="inverse" select="$inverse"/>
			    <with-param name="object" select="$generated-uri"/>
			</call-template>
		    </otherwise>
		</choose>
	    </if>
	</for-each>
    </template>

    <xd:doc>
	<xd:short>Creates an RDF resource from the current element</xd:short>
	<xd:detail><p>Creates an RDF resource of some type from the current
		element, and probably creates related triples having this
		resource as a subject or object.  Then, matching extraction
		templates are applied to the child elements.  A call to
		create-resource defines a scope in which the created resource
		is the default subject of any other triple created using these
		templates, unless another resource is created from some child
		element.  The type (i.e. a URI of some class in some ontology)
		has to be specified.</p>
	    <p>This resource is assumed the default subject of all triples
		extracted from descendant elements and attributes using the
		add-literal-property and add-uri-property templates.
		Optionally, a sequence of properties can be passed by which
		this resource is related to the resource created by the
		invoking template (in most cases the resource created from the
		parent XML element).  Additional properties of this resource
		can be passed, if it is not possible to have them generated by
		templates matching some attributes or children of this
		element.</p>
		<xd:param name="subject"></xd:param>
		<xd:param name="related-via-properties"></xd:param>
		<xd:param name="related-via-inverse-properties"></xd:param>
		<xd:param name="type"></xd:param>
		<xd:param name="properties">additional properties of this resource, encoded as
		<code>&lt;krextor:property uri="property-uri" object="object-uri"/&gt;</code> or
		<code>&lt;krextor:property uri="property-uri" value="object-literal"/&gt;</code> or
		<code>&lt;krextor:property uri="property-uri"&gt;object-literal&lt;/krextor:property&gt;</code>.
		On literal-valued objects, the attributes <code>@language</code> and <code>@datatype</code>
		are also allowed.  Support for blank node objects is not yet implemented.
		</xd:param>
		<xd:param name="process-next">The node set to which further extraction templates are applied (via <code>xsl:apply-templates</code>).  The default value is <code>*|@*</code>, i.e. we also process attributes, as they may represent properties of the current resource.</xd:param>
		<xd:param name="subject-uri"></xd:param>
		<xd:param name="blank-node"><code>true()</code> if this resource is a blank node</xd:param>
		<xd:param name="this-blank-node-id"></xd:param>
		<xd:param name="collection"><code>true()</code> if this resource is an RDF collection</xd:param>
	</xd:detail>
    </xd:doc>
    <template name="krextor:create-resource">
	<param name="subject" select="()" as="xs:string?"/>
	<param name="related-via-properties" as="xs:string*" select="()" tunnel="yes"/>
	<param name="related-via-inverse-properties" as="xs:string*" select="()" tunnel="yes"/>
	<param name="type" select="()" as="xs:string*"/>
	<param name="properties" as="node()*"/>
	<param name="process-next" as="node()*" select="*|@*"/>
	<!-- We pass the subject URI as a parameter into templates.  This is because we need to tweak the subject URI when processing transcluded documents; in this case, the transcluding document's URI should still be considered the subject URI, instead of the URI of the transcluded document. -->
	<param name="subject-uri" as="xs:string" tunnel="yes"/>
	<param name="blank-node" as="xs:boolean" select="false()"/>
	<param name="this-blank-node-id" select="()" as="xs:string?"/>
	<param name="collection" as="xs:boolean" select="false()"/>
	<param name="nested-call" as="xs:boolean" select="false()" tunnel="yes"/>

	<variable name="autogenerate-fragment-uri" as="xs:string*" select="krextor:uri-generation-method(.)"/>
	<!-- If we are to autogenerate the URI for this node, then we call the krextor:generate-uri function to generate one, unless an explicit subject URI has been passed
	  -->
	<variable name="generated-uri" as="xs:anyURI" select="if ($blank-node) then xs:anyURI($subject-uri)
	    else if (exists($subject)) then xs:anyURI($subject)
	    else if (exists($autogenerate-fragment-uri)) 
		then krextor:generate-uri(., $autogenerate-fragment-uri, xs:anyURI($subject-uri))
	    else xs:anyURI($subject-uri)"/>
	<variable name="generated-blank-node" as="xs:boolean" select="$blank-node or $collection"/>
	<!-- TODO introduce auto-blank node if no xml:id given
	     if auto-blank-node isn't desired, skip elements without xml:id altogether -->
	<variable name="generated-blank-node-id" as="xs:string" select="
	    if ($generated-blank-node) then
		concat(if ($collection and not(starts-with($this-blank-node-id, 'collection-'))) then 'collection-' else '',
		    if ($this-blank-node-id) then $this-blank-node-id else generate-id())
	    else ''"/>
	<variable name="subject" as="xs:string" select="if ($generated-blank-node) then $generated-blank-node-id else $generated-uri"/>
	<variable name="subject-type" as="xs:string" select="if ($generated-blank-node) then 'blank' else 'uri'"/>
	<if test="exists($generated-uri)">
	    <if test="$nested-call">
		<!-- Relate this resource to its parent, if it has a parent -->
		<!-- not(parent::node() instance of document-node()) would not work,
		     as we may have document nodes synthesized by the extraction module -->
		<call-template name="krextor:related-via-properties">
		    <with-param name="properties" select="$related-via-properties"/>
		    <with-param name="blank-node" select="$generated-blank-node"/>
		    <with-param name="generated-blank-node-id" select="$generated-blank-node-id"/>
		    <with-param name="generated-uri" select="$generated-uri"/>
		</call-template>
		<call-template name="krextor:related-via-properties">
		    <with-param name="properties" select="$related-via-inverse-properties"/>
		    <with-param name="inverse" select="true()"/>
		    <with-param name="blank-node" select="$generated-blank-node"/>
		    <with-param name="generated-blank-node-id" select="$generated-blank-node-id"/>
		    <with-param name="generated-uri" select="$generated-uri"/>
		</call-template>
	    </if>

	    <!-- Create the triple(s) that instantiates this resource -->
	    <for-each select="$type">
		<call-template name="krextor:output-triple-impl">
		    <with-param name="subject" select="$subject"/>
		    <with-param name="subject-type" select="$subject-type"/>
		    <with-param name="predicate" select="xs:anyURI('&rdf;type')"/>
		    <with-param name="object" select="."/>
		    <with-param name="object-type" select="'uri'"/>
		</call-template>
	    </for-each>

	    <!-- Add additional properties to this resource -->
	    <if test="$properties">
		<for-each select="$properties/krextor:property[@uri]">
		    <variable name="object" select="if (@object) then @object
                        else if (@value) then @value
			else if (node()) then node() (: this covers text content and XML literals :)
			else ''"/>
		    <if test="$object">
			<call-template name="krextor:output-triple-impl">
			    <with-param name="subject" select="$subject"/>
			    <with-param name="subject-type" select="$subject-type"/>
			    <with-param name="predicate" select="@uri"/>
			    <with-param name="object" select="$object"/>
			    <with-param name="object-type" select="if (@object) then 'uri'
				else ''"/>
			    <with-param name="object-language" select="@language"/>
			    <with-param name="object-datatype" select="@datatype"/>
			</call-template>
		    </if>
		</for-each>
	    </if>

	    <choose>
		<when test="$collection">
		    <call-template name="krextor:create-collection">
			<with-param name="blank-node-id" select="$generated-blank-node-id" tunnel="yes"/>
			<with-param name="rest" select="$process-next"/>
		    </call-template>
		</when>
		<otherwise>
		    <!-- Process the children of this element, or whichever nodes desired -->
		    <apply-templates select="$process-next" mode="krextor:main">
			<!-- pass on the generated subject URI or blank node ID.  For resolving relative URIs, an appended fragment does
			     not matter, but for generating property triples for this resource it does. -->
			<with-param name="subject-uri" select="$generated-uri" tunnel="yes"/>
			<!-- Pass the information what type this is; this might help to disambiguate triple generation from children of the element that represents the resource of that type. -->
                        <with-param name="type" select="$type" tunnel="yes"/>
			<with-param name="blank-node-id" select="$generated-blank-node-id" tunnel="yes"/>
			<!-- FIXME test whether it is sufficient to set this parameter just here -->
			<with-param name="nested-call" select="true()" tunnel="yes"/>
		    </apply-templates>
		</otherwise>
	    </choose>
	</if>
    </template>

    <variable name="krextor:dummy-node" as="element(krextor:dummy-node)">
	<krextor:dummy-node/>
    </variable>

    <xd:doc>applies Krextor templates to a given node (usually one that has been synthesized, i.e. that does not exist in the input XML, but is needed to achieve a structure that better matches the desired RDF)</xd:doc>
    <template name="krextor:apply-templates">
        <param name="node" as="node()*" select=".|@*"/>
        <!-- when processing a single synthesized element (which is complex content according to http://www.w3.org/TR/xslt20/#constructing-complex-content), it usually does not make sense to let Krextor process the document node -->
        <param name="skip-document-node" as="xs:boolean" select="true()"/>
        <apply-templates mode="krextor:main"
                         select="if ($skip-document-node) then $node/*[1] else $node"/>
    </template>

    <xd:doc>we hope that this slightly speeds up search</xd:doc>
    <key name="krextor:resources" match="*" use="resolve-QName(name(), .)"/>

    <xd:doc>Creates a resource from an element for which a mapping to an ontology class has been declared in the variable <code>krextor:resources</code>.</xd:doc>
    <template match="*" mode="krextor:create-resource">
	<choose>
	    <when test="not(empty($krextor:resources))">
		<!-- variant without key: compare local-name and namespace-uri -->
		<variable name="mapping" as="element()" select="key('krextor:resources',
		    resolve-QName(name(), .),
		    if (not(empty($krextor:resources)))
		    then $krextor:resources
		    else $krextor:dummy-node)"/>
		<!-- we need this to trap the pre-computation of the key hashes -->
		<call-template name="krextor:create-resource">
		    <with-param name="type" select="tokenize($mapping/@type, '\s+')"/>
		    <with-param name="related-via-properties" select="tokenize($mapping/@related-via-properties, '\s+')" tunnel="yes"/>
		    <with-param name="related-via-inverse-properties" select="tokenize($mapping/@related-via-inverse-properties, '\s+')" tunnel="yes"/>
		</call-template>
	    </when>
	    <otherwise>
		<message terminate="yes">No mappings from XML elements to resources declared</message>
	    </otherwise>
	</choose>
    </template>

    <xd:doc>Adds a literal-valued property to the resource in whose
	create-resource scope this template was called.</xd:doc>
    <template name="krextor:add-literal-property">
	<param name="subject-uri" as="xs:anyURI" tunnel="yes"/>
	<param name="blank-node-id" as="xs:string?" tunnel="yes"/>
	<!-- TODO allow for a sequence of properties here -->
	<param name="property"/>
	<!-- property from incomplete triples -->
	<param name="tunneled-property" as="xs:anyURI*" tunnel="yes"/>
	<param name="object">
	    <choose>
                <when test="element()">
                    <copy-of select="node()"/>
                </when>
		<otherwise>
		    <value-of select="."/>
		</otherwise>
	    </choose>
	</param>
	<!-- Is the object a whitespace-separated list or a sequence? -->
	<param name="object-is-list" select="false()" as="xs:boolean"/>
	<!-- Normalize whitespace around the value of the object? -->
	<param name="normalize-space" select="false()" as="xs:boolean"/>
	<param name="language" as="xs:string?" select="''"/>
	<param name="datatype" as="xs:string?"
               select="if ($object/self::element() or krextor:is-single-element($object)) then '&rdf;XMLLiteral' else ''"/>

	<variable name="actual-property" as="xs:anyURI" select="if (exists($property))
	    then xs:anyURI($property)
	    else $tunneled-property"/>
	<choose>
	    <!-- If the "object" is a whitespace-separated list or a sequence of actual objects, we recursively generate one triple for each object. -->
	    <when test="$object-is-list">
		<for-each select="if (count($object) gt 0) 
		    then $object
		    else tokenize($object, '\s+')">
		    <call-template name="krextor:add-literal-property">
			<with-param name="property" select="$actual-property"/>
			<with-param name="object" select="."/>
			<!-- Make sure that we don't run into an infinite loop ;-) -->
			<with-param name="object-is-list" select="false()"/>
		    </call-template>
		</for-each>
	    </when>
	    <otherwise>
		<for-each select="$actual-property">
		    <call-template name="krextor:output-triple-impl">
			<with-param name="subject" select="if ($blank-node-id) then $blank-node-id
			    else $subject-uri"/>
			<with-param name="subject-type" select="if ($blank-node-id) then 'blank'
			    else 'uri'"/>
			<with-param name="predicate" select="."/>
			<with-param name="object" select="if ($normalize-space) then normalize-space($object)
			    else krextor:normalize-single-element($object)"/>
			<with-param name="object-language" select="$language"/>
			<with-param name="object-datatype" select="$datatype"/>
		    </call-template>
		</for-each>
	    </otherwise>
	</choose>
    </template>    

    <xd:doc>we hope that this slightly speeds up search</xd:doc>
    <key name="krextor:literal-properties" match="*" use="resolve-QName(name(), .)"/>

    <xd:doc>Creates a literal property from a child element or attribute for which a mapping to an ontology property has been declared in the variable <code>krextor:literal-properties</code>.</xd:doc>
    <template match="*|@*" mode="krextor:add-literal-property">
	<choose>
	    <when test="not(empty($krextor:literal-properties))">
		<!-- variant without key: compare local-name and namespace-uri -->
		<variable name="mapping" as="element()" select="key('krextor:literal-properties',
		    resolve-QName(name(), if (. instance of attribute()) then parent::node() else .), 
		    if (not(empty($krextor:literal-properties)))
		    then $krextor:literal-properties
		    else $krextor:dummy-node)"/>
		<!-- we need this to trap the pre-computation of the key hashes -->
		<if test=". instance of attribute() and not($mapping/@krextor:attribute)">
		    <message terminate="yes">No mapping found for attribute <copy-of select="."/></message>
		</if>
		<call-template name="krextor:add-literal-property">
		    <!-- TODO allow for a sequence of properties here (cf. krextor:create-resource/type) -->
		    <with-param name="property" select="$mapping/@property"/>
		    <with-param name="object-is-list" select="boolean($mapping/@list)"/>
		    <with-param name="normalize-space" select="boolean($mapping/@normalize-space)"/>
		</call-template>
	    </when>
	    <otherwise>
		<message terminate="yes">No mappings from XML to literal properties declared</message>
	    </otherwise>
	</choose>
    </template>

    <xd:doc>Adds a URI-valued property to the resource in whose
	<code>create-resource</code> scope this template was called.</xd:doc>
    <template name="krextor:add-uri-property">
	<param name="subject-uri" as="xs:anyURI" tunnel="yes"/>
	<param name="blank-node-id" as="xs:string?" tunnel="yes"/>
	<param name="property"/>
	<!-- property from incomplete triples -->
	<param name="tunneled-property" as="xs:anyURI*" tunnel="yes"/>
	<!-- Should the property be applied in inverse direction? -->
	<param name="inverse" as="xs:boolean" select="false()"/>
	<!-- inverse information from incomplete triples -->
	<param name="tunneled-inverse" as="xs:boolean" select="false()" tunnel="yes"/>
	<!-- Is the object a whitespace-separated list or a 
	multi-element sequence?  Use the empty sequence () instead
	of the empty string in order to pass something that is not an object -->
	<param name="object-is-list" as="xs:boolean" select="false()"/>
	<!-- Currently we assume that, if no explicit link target is given, we are either:
	1. in the root element R of an XIncluded document and that a relationship between the parent of the xi:include and the XIncluded document is to be expressed.
	2. or we are in an attribute or a text node or any item of a whitespace-separated list,
	   and a relationship between the current subject URI and the URIref in the attribute value is to be expressed. -->
	<param name="object" select="if (krextor:is-text-or-attribute-or-atomic(.))
	    then if ($object-is-list) then . else krextor:resolve-uri(., $subject-uri)
	    (: What is this resolution good for? MMT?
	       Anyway, if needed, we could also resolve each list
	       item by for - in - return :)
	    else if (parent::node() instance of document-node()) then krextor:base-uri(.)
	    else ''"/>
	<!-- node ID, if the object is a blank node -->
	<param name="blank" as="xs:string?"/>
	<if test="($blank or exists($object)) and (exists($property) or exists($tunneled-property))">
	    <variable name="actual-object" select="if ($blank) then $blank
		else $object"/>
	    <variable name="actual-property" as="xs:anyURI" select="if (exists($property))
		then xs:anyURI($property)
		else $tunneled-property"/>
	    <variable name="actual-inverse" as="xs:boolean" select="if (exists($property)) then $inverse
		else $tunneled-inverse"/>
	    <choose>
		<!-- If the "object" is a whitespace-separated list of actual objects, we recursively generate one triple for each object. -->
		<when test="$object-is-list">
		    <for-each select="if (count($actual-object) gt 1)
			then $actual-object
			else tokenize($actual-object, '\s+')">
			<call-template name="krextor:add-uri-property">
			    <with-param name="property" select="$actual-property"/>
			    <with-param name="inverse" select="$actual-inverse"/>
			    <!-- Make sure that we don't run into an infinite loop ;-) -->
			    <with-param name="object-is-list" select="false()"/>
			</call-template>
		    </for-each>
		</when>
		<otherwise>
		    <choose>
			<when test="$actual-inverse">
			    <for-each select="$actual-property">
				<call-template name="krextor:output-triple-impl">
				    <with-param name="subject" select="$actual-object"/>
				    <with-param name="subject-type" select="if ($blank) then 'blank' else 'uri'"/>
				    <with-param name="predicate" select="."/>
				    <with-param name="object" select="if ($blank-node-id) then $blank-node-id
					else $subject-uri"/>
				    <with-param name="object-type" select="if ($blank-node-id) then 'blank'
					else 'uri'"/>
				</call-template>
			    </for-each>
			</when>
			<otherwise>
			    <for-each select="$actual-property">
				<call-template name="krextor:output-triple-impl">
				    <with-param name="subject" select="if ($blank-node-id) then $blank-node-id
					else $subject-uri"/>
				    <with-param name="subject-type" select="if ($blank-node-id) then 'blank'
					else 'uri'"/>
				    <with-param name="predicate" select="."/>
				    <with-param name="object" select="$actual-object"/>
				    <with-param name="object-type" select="if ($blank) then 'blank' else 'uri'"/>
				</call-template>
			    </for-each>
			</otherwise>
		    </choose>
		</otherwise>
	    </choose>
	</if>
    </template>    

    <xd:doc>Creates a property whose values are added by nested template calls</xd:doc>
    <template name="krextor:create-property">
	<param name="property" as="xs:anyURI" required="yes"/>
	<param name="inverse" as="xs:boolean" select="false()"/>
	<!-- The node set to which apply-templates is applied -->
	<!-- We also process attributes, as they may contain links to other resources -->
	<param name="process-next" as="node()*" select="*|@*"/>
	<apply-templates select="$process-next" mode="krextor:main">
	    <with-param name="tunneled-property" select="$property" tunnel="yes"/>
	    <with-param name="tunneled-inverse" select="$inverse" tunnel="yes"/>
	</apply-templates>
    </template>

    <xd:doc>Creates an rdf Collection</xd:doc>
    <template name="krextor:create-collection">
	<param name="rest" as="element()*"/>
	<param name="blank-node-id" as="xs:string" tunnel="yes"/>
	<param name="collection-id" as="xs:string?" select="()" tunnel="yes"/>
	<param name="collection-index" as="xs:integer" select="1" tunnel="yes"/>
	<variable name="new-collection-id" as="xs:string" select="if (exists($collection-id)) then $collection-id else $blank-node-id"/>
	<variable name="subject" as="xs:string" select="concat($new-collection-id, '-', $collection-index)"/>
	<apply-templates select="$rest[1]" mode="krextor:main">
	    <!-- if a resource is created from the first element, make it the first resource of this collection -->
	    <with-param name="related-via-properties" select="'&rdf;first'" tunnel="yes"/>
	</apply-templates>    	
    	
	<choose>
	    <when test="$rest[2]">
		<call-template name="krextor:create-resource">
		    <with-param name="this-blank-node-id" select="$subject"/>
		    <with-param name="related-via-properties" select="'&rdf;rest'" tunnel="yes"/>
		    <with-param name="collection" select="true()"/>
		    <with-param name="process-next" select="$rest[position() ge 2]"/>
		    <with-param name="collection-id" select="$new-collection-id" tunnel="yes"/>
		    <with-param name="collection-index" select="$collection-index + 1" tunnel="yes"/>
		</call-template>
	    </when>
	    <otherwise>
		<call-template name="krextor:create-resource">
		    <with-param name="subject-uri" select="xs:anyURI('&rdf;nil')" tunnel="yes"/>
		    <with-param name="related-via-properties" select="'&rdf;rest'" tunnel="yes"/>
		    <with-param name="process-next" select="()"/>
		</call-template>
	    </otherwise>
	</choose>
    </template>

    <xd:doc>
	<xd:short>Follows an XInclude (generally supported by Krextor)</xd:short>
	<xd:detail>
	    <p>Krextor supports the following generic inclusion mechanism for XML documents: A root element R of a transcluded documents will be treated like a direct child of the parent element P of the xi:include element.  If there is a relevant relationship between P and R, an according triple is generated, with the transcluded document's URI (not the URI of R!) being the object.  The transcluded document is loaded and its root node examined in order to find this out.  Any relationships between elements of the transcluding document and the transcluded document that are not direct relationships between P and R are not considered during RDF extraction.</p>
	    <p>Note: We're using XInclude because the semantics of <![CDATA[<element xlink:type="simple" xlink:show="embed" xlink:href="some-XML-resource"/>]]> is not yet clearly defined in the XLink specification.  Should the root element of the document pointed to replace the pointing element, or should it be transcluded into the pointing element as a child?</p>
	</xd:detail>
    </xd:doc>
    <template match="xi:include" mode="krextor:main">
	<if test="$traverse-xincludes">
	    <apply-templates select="document(@href, .)" mode="krextor:included">
		<with-param name="krextor:parent-element" select="." tunnel="yes"/>
	    </apply-templates>
	</if>
    </template>

    <xd:doc>Process the root element of an XIncluded document</xd:doc>
    <template match="/" mode="krextor:included">
	<apply-templates mode="krextor:included"/>
    </template>

    <xd:doc>Start processing in default mode; we switch to Krextor's main mode first</xd:doc>
    <template match="/">
	<apply-templates select="/" mode="krextor:main"/>
    </template>

    <xd:doc>Start processing; the current subject is identified by the base URI of the document.  Afterwards, if the <code>merge-url-pattern-*</code> parameters have been set, output the triples in the document at the URL obtained from the base URI of the current input after replacing <code>merge-url-pattern-match</code> with <code>merge-url-pattern-replace</code>.  In terms of the RDF semantics that means that those triples will be merged with the triples extracted from the primary input.</xd:doc>
    <template match="/" mode="krextor:main" name="krextor:main">
	<param name="krextor:base-uri" as="xs:string" select="krextor:base-uri(.)" tunnel="yes"/>
        <param name="merging-rdf" as="xs:boolean" select="$merge-url-pattern-match != ''" tunnel="yes"/>
	<apply-templates mode="krextor:main">
	    <with-param name="subject-uri" select="xs:anyURI($krextor:base-uri)" tunnel="yes"/>
	    <with-param name="krextor:base-uri" select="xs:anyURI($krextor:base-uri)" tunnel="yes"/>
	</apply-templates>
        <if test="$merging-rdf">
            <!-- we need to run it in this mode instead of krextor:main, as otherwise certain output modules would see another document node and thus create a second RDF graph -->
	    <!-- we are not reusing the rewritten base URI ($krextor:base-uri()), as the objective here is to get access to a physical file, whereas the rewritten base URI is about serving nice cool URIs -->
	    <variable name="merge-url" select="replace(base-uri(), $merge-url-pattern-match, $merge-url-pattern-replace)"/>
	    <if test="doc-available($merge-url)">
		<apply-templates select="document($merge-url)" mode="krextor:merge-rdf">
		    <!-- avoid infinite loop -->
		    <with-param name="merging-rdf" select="false()" tunnel="yes"/>
		</apply-templates>
	    </if>
        </if>
    </template>

    <template match="/" mode="krextor:merge-rdf">
        <call-template name="krextor:main"/>
    </template>

    <xd:doc>Do not extract RDF from attributes that are not matched by the
	language-specific templates, nor from text nodes (same for all Krextor modes).</xd:doc>
    <template match="@*|text()" mode="krextor:main"/>
</stylesheet>

<!--
Local Variables:
mode: nxml
nxml-child-indent: 4
End:
-->
