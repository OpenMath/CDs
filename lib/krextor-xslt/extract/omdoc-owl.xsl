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
    <!ENTITY owl  "http://www.w3.org/2002/07/owl#">
    <!ENTITY rdfs "http://www.w3.org/2000/01/rdf-schema#">
    <!ENTITY rdf  "http://www.w3.org/1999/02/22-rdf-syntax-ns#">
    <!ENTITY xsd  "http://www.w3.org/2001/XMLSchema#" >
    <!ENTITY odo  "http://omdoc.org/ontology#">
]>

<stylesheet
    xpath-default-namespace="http://omdoc.org/ns"
    xmlns:krextor="http://kwarc.info/projects/krextor"
    xmlns:krextor-genuri="http://kwarc.info/projects/krextor/genuri"
    xmlns:xd="http://www.pnp-software.com/XSLTdoc"
    xmlns:om="http://www.openmath.org/OpenMath"
    xmlns:odo="http://omdoc.org/ontology#"
    xmlns:omdoc="http://omdoc.org/ns"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:f="http://fxsl.sf.net/"
    xmlns="http://www.w3.org/1999/XSL/Transform"
    exclude-result-prefixes="#all"
    version="2.0">

    <import href="util/omdoc.xsl"/>

    <xd:doc type="stylesheet">
	Extracts <a href="http://www.w3.org/2004/OWL/">OWL</a> ontologies from <a href="http://www.omdoc.org">OMDoc</a> documents by giving them a special interpretation
	<xd:author>Christoph Lange</xd:author>
	<xd:copyright>Christoph Lange, 2008</xd:copyright>
	<xd:svnId>$Id: omdoc-owl.xsl 1994 2011-05-26 16:51:09Z clange $</xd:svnId>
    </xd:doc>

    <strip-space elements="*"/>

    <param name="debug" select="true()"/>

    <param name="autogenerate-fragment-uris" select="()"/>

    <xd:doc>Creates a URI for a semantic web ontology entity by
	concatenating a given base URI and a given local name</xd:doc>
    <function name="krextor:ontology-uri" as="xs:anyURI">
	<param name="base-uri" as="xs:string"/>
	<param name="name" as="xs:string?"/>
	<value-of select="xs:anyURI(concat($base-uri, $name))"/>
    </function>

    <xd:doc>Creates a URI for a semantic web ontology entity by
	concatenating a given base URI and a given local name</xd:doc>
    <template match="krextor-genuri:ontology" as="xs:anyURI?">
	<param name="base-uri" as="xs:string"/>
	<param name="node" as="element()"/>
	<sequence select="krextor:ontology-uri($base-uri,
	    if ($node/self::theory) then '' else $node/@name)"/>
    </template>

    <template match="node()" mode="krextor:uri-generation-method">
	<param name="mmt" tunnel="yes"/>
        <value-of select="if ($mmt)
	    then ('mmt')
	    else ('ontology')"/>
    </template>

    <template name="krextor:create-ontology-resource">
	<param name="type" select="()"/>
	<call-template name="krextor:create-resource">
	    <with-param name="type" select="$type"/>
	</call-template>
    </template>

    <xd:doc type="element*">A sequence of mappings of CDs representing semantic web ontologies to their corresponding namespaces</xd:doc>
    <variable name="ontology-namespaces">
	<!-- TODO do this on the ref-normal form of the document (cf. $all in exincl.xsl -->
	<for-each select="/descendant::theory">
	    <!-- We collect the set of distinct symbols in this theory, not regarding nested theories -->
	    <variable name="cdus" as="node()*">
		<for-each-group select="descendant::om:OMS[ancestor::theory[1] is current() and not(ancestor::notation)]/@cd" group-by=".">
		    <sequence select="."/>
		</for-each-group>
	    </variable>
	    <!-- we determine those symbols whose symbol definition is not in this document -->
	    <variable name="todo" select="$cdus[not(. = /descendant::theory/@xml:id)]"/>

	    <variable name="catalogue">
		<!-- we search the import graph, starting with our theory. -->
		<call-template name="krextor:make-catalogue">
		    <with-param name="todo" select="$todo"/>
		    <with-param name="theory" select="."/>
		    <!-- don't use krextor:base-uri() here, as we rely on these
		         to be resolvable using document() -->
		    <with-param name="base-uri" select="base-uri()"/>
		</call-template>
	    </variable>

	    <apply-templates select="$catalogue" mode="krextor:post-process-catalogue">
		<with-param name="this-theory" select="@xml:id" tunnel="yes"/>
	    </apply-templates>
	</for-each>
    </variable>

    <template match="/" mode="krextor:post-process-catalogue">
	<param name="this-theory" tunnel="yes"/>
	<krextor:loc theory="{$this-theory}" omdoc="{concat('#', $this-theory)}">
	    <variable name="sem-web-base" select="krextor:sem-web-base[not(preceding-sibling::*)]"/>
	    <if test="$sem-web-base">
		<attribute name="sem-web-base" select="$sem-web-base"/>
	    </if>
	</krextor:loc>
	<apply-templates select="* except krextor:sem-web-base[not(preceding-sibling::*)]" mode="#current"/>
    </template>

    <template match="krextor:loc" mode="krextor:post-process-catalogue">
	<variable name="sem-web-base" as="xs:string">
	    <variable name="sem-web-base" select="following-sibling::krextor:sem-web-base[@omdoc eq current()/@omdoc]"/>
	    <value-of select="if ($sem-web-base)
		then $sem-web-base
		else if (not(following-sibling::krextor:visited[. eq current()/@omdoc]))
		then krextor:sem-web-base(document(@omdoc))
		else ''"/>
	</variable>
	<if test="$sem-web-base">
	    <copy>
		<copy-of select="@*"/>
		<attribute name="sem-web-base" select="$sem-web-base"/>
	    </copy>
	</if>
    </template>

    <template match="krextor:visited|krextor:sem-web-base" mode="krextor:post-process-catalogue"/>

    <xd:doc>Recursively examine the locally imported theories and locate all theories that still need a catalogue entry.  Each theory is only visited once.  Returns a set of <code>krextor:loc</code> elements.
	<xd:param name="todo">the theories that still need a catalogue entry</xd:param>
	<xd:param name="theory">the theory that is searched for them</xd:param>
	<xd:param name="base-uri">the base URI of the current theory, against which links to imported theories are resolved</xd:param>
	<xd:param name="visited">a set of theories already visited</xd:param>
	<xd:param name="top-level-call" type="boolean">indicates whether this is a top-level or a recursive call</xd:param>
    </xd:doc>
    <template name="krextor:make-catalogue">
	<param name="todo" as="node()*"/>
	<param name="theory" as="node()*"/>
	<param name="base-uri"/>
	<param name="visited" as="node()*" select="()"/>
	<param name="top-level-call" select="true()"/>
	
	<variable name="sem-web-base" select="krextor:sem-web-base($theory)"/>
	<if test="$sem-web-base ne ''">
	    <krextor:sem-web-base omdoc="{concat(base-uri($theory), '#', $theory/@xml:id)}"><value-of select="$sem-web-base"/></krextor:sem-web-base>
	</if>

	<!-- We build the local catalogue and put it in  a variable -->
	<variable name="local-cat">
	    <!-- search for imports in this theory.
	    TODO Are we considering nested theories?  If so, we'd need to
	    search their ancestors as well. -->
	    <for-each select="$theory/imports">
		<krextor:loc
		    theory="{substring-after(@from, '#')}"
		    omdoc="{resolve-uri(@from, $base-uri)}"/>
	    </for-each>
	</variable>

	<!-- those theories that are in the local catalogue of the theory specified by the parameter $theory -->
	<variable name="incat" select="$todo[. = $local-cat/krextor:loc/@theory]"/>

	<!-- ... and those that aren't -->
	<variable name="rest" select="$todo except $incat"/>

	<!-- output loc elements for those theories that are imported from
	other documents and that were searched for (note, this 
	differs from OMDoc's exincl.xsl) -->
	<copy-of select="$local-cat/krextor:loc[@theory = $incat]"/>

	<!-- if there are remaining theories that are not in the local catalogue, recurse to them -->
	<if test="$rest">
	    <variable name="follow" select="$local-cat/krextor:loc[not(@omdoc = $visited)]/@omdoc"/>
	    <!-- there is a catalogue of locally imported, still unvisited theories we can follow -->
	    <if test="$follow">
		<variable name="result">
		    <call-template name="krextor:make-catalogue-iteration">
			<with-param name="todo" select="$rest"/>
			<with-param name="head" select="$follow[1]"/>
			<with-param name="tail" select="$follow[position() gt 1]"/>
			<with-param name="base-uri" select="$base-uri"/>
			<with-param name="visited" select="$visited"/>
			<with-param name="top-level-call" select="$top-level-call"/>
		    </call-template>
		</variable>

		<copy-of select="$result"/>
	    </if>
	</if>
    </template>

    <xd:doc>
	<xd:param name="todo">the theories that still need a catalogue entry</xd:param>
	<xd:param name="head"></xd:param>
	<xd:param name="tail"></xd:param>
	<xd:param name="base-uri">the base URI of the current theory, against which links to imported theories are resolved</xd:param>
	<xd:param name="visited">a set of theories already visited</xd:param>
	<xd:param name="top-level-call" type="boolean">indicates whether this is a top-level or a recursive call</xd:param>
    </xd:doc>
    <template name="krextor:make-catalogue-iteration">
	<param name="todo" as="node()*"/>
	<param name="head" as="node()*"/>
	<param name="tail" as="node()*"/>
	<param name="base-uri"/>
	<param name="visited" as="node()*"/>
	<param name="top-level-call" as="xs:boolean"/>

	<variable name="new-base-uri" select="resolve-uri($head, $base-uri)"/>

	<variable name="recursive-call">
	    <!-- this generates a set of loc's, followed by a list of visited's -->
	    <call-template name="krextor:make-catalogue">
		<with-param name="todo" select="$todo"/>
		<with-param name="theory" select="document($head, .)"/>
		<with-param name="base-uri" select="$new-base-uri"/>
		<with-param name="visited" select="$visited"/>
		<with-param name="top-level-call" select="false()"/>
	    </call-template>
	    <krextor:visited><value-of select="$head"/></krextor:visited>
	</variable>

	<!-- output the output generated by the recursive call
	     (loc, visited, and sem-web-base) -->
	<copy-of select="$recursive-call"/>
	
	<!-- prepare next iteration: search still unvisited theories for imports still not found -->
	<variable name="next-tail" select="$tail[not(. = $recursive-call/krextor:visited)]"/>
	<variable name="next-todo" select="$todo[not(. = $recursive-call/krextor:loc/@theory)]"/>

	<!-- if there are imports to be found ... -->
	<if test="$next-todo">
	    <choose>
		<!-- ... and unvisited theories to search for them ... -->
		<when test="$next-tail">
		    <call-template name="krextor:make-catalogue-iteration">
			<with-param name="todo" select="$next-todo"/>
			<with-param name="head" select="$next-tail[1]"/>
			<with-param name="tail" select="$next-tail[position() gt 1]"/>
			<with-param name="visited" select="$visited|$recursive-call/visited"/>
			<with-param name="base-uri" select="$base-uri"/>
			<with-param name="top-level-call" select="$top-level-call"/>
		    </call-template>
		</when>
		<otherwise>
		    <if test="$top-level-call">
			<message terminate="yes">Cannot find locations for the theories <value-of select="$next-todo" separator=","/>!</message>
		    </if>
		</otherwise>
	    </choose>
	</if>
    </template>

    <xd:doc>Overridden imported function from <code>util/rdfa.xsl</code></xd:doc>
    <function name="krextor:default-curie-namespace">
	<param name="focus"/>
	<value-of select="krextor:default-namespace($focus)"/>
    </function>

    <!-- regular templates matching OMDoc start here -->
    
    <xd:doc>Create a resource from an OMDoc symbol</xd:doc>
    <template match="symbol" mode="krextor:main">
	<call-template name="krextor:create-ontology-resource"/>
    </template>

    <xd:doc>Make this property an instance of some relation type</xd:doc>
    <template match="
       symbol/type/om:OMOBJ/om:OMA[krextor:is-ontology-term(.)]
       |symbol/type/om:OMOBJ[krextor:is-from-ontology(om:OMS[1])]" mode="krextor:main">
	<if test="not(om:*[3] and om:OMS[1]/@cd eq 'rdf' and om:OMS[1]/@name eq 'Property')">
	    <!-- When domain and range are given, the triple
	         X rdf:type rdf:Property
		 is redundant, as it is entailed by the RDFS axiomatic triples,
		 so we don't generate it. -->
	    <apply-templates select="om:*[1]" mode="#current">
		<with-param name="related-via-properties" select="'&rdf;type'" tunnel="yes"/>
	    </apply-templates>
	</if>
	<if test="om:*[3]">
	    <!-- Handle rdfs:domain and rdfs:range, but only if they are both given -->
	    <!-- Note that, in this case, we should actually enforce that om:*[1] is
	         rdf:Property or a subproperty thereof, but during this translation we
		 don't have access to a reasoner :-( -->
	    <apply-templates select="om:*[2]" mode="#current">		
		<with-param name="related-via-properties" select="'&rdfs;domain'" tunnel="yes"/>
	    </apply-templates>
	    <apply-templates select="om:*[3]" mode="#current">
		<with-param name="related-via-properties" select="'&rdfs;range'" tunnel="yes"/>
	    </apply-templates>    	
	</if>
    </template>

    
    <!-- TODO implement syntactic sugar for rdfs:subClassOf and rdfs:subPropertyOf
         https://trac.kwarc.info/krextor/ticket/25
    -->

    <xd:doc>Returns the semantic web URI of a given symbol or theory element
    <xd:param name="node">either a symbol that is expected to have <code>@cd</code> and <code>@name</code> attributes (as in OpenMath), or a theory that is expected to have an <code>@xml:id</code></xd:param>
    </xd:doc>
    <function name="krextor:ontology-uri" as="xs:anyURI">
	<param name="node" as="node()"/>
        <variable name="theory"
          select="if ($node/self::om:OMS)
                  then $node/@cd
                  else $node/@xml:id"/>
        <variable name="local-name"
          select="if ($node/self::om:OMS)
                  then $node/@name
                  else ''"/>
        <variable name="sem-web-base" select="$ontology-namespaces/krextor:loc[@theory eq $theory][1]/@sem-web-base"/>
	<value-of select="if ($sem-web-base)
	    then krextor:ontology-uri($sem-web-base, $local-name)
	    else krextor:mmt-uri('MMT-FIXME', concat($theory, '?', $local-name))"/>
    </function>

    <xd:doc>Returns a semantic web URI for the given symbol, if the parameter is a symbol, otherwise the empty sequence.
	<xd:param name="sym">a symbol that is expected to have <code>@cd</code> and <code>@name</code> attributes (as in OpenMath)</xd:param>
    </xd:doc>
    <function name="krextor:ontology-uri-or-blank">
	<param name="sym"/>
	<value-of select="if ($sym/self::om:OMS)
	    then krextor:ontology-uri($sym)
	    else ()"/>
    </function>
	
	
    <xd:doc>Returns <code>true()</code> if the parameter is a symbol defined in an ontology.
	<xd:param name="sym">a symbol that is expected to have <code>@cd</code> and <code>@name</code> attributes (as in OpenMath)</xd:param>
    </xd:doc>
    <function name="krextor:is-from-ontology" as="xs:boolean">
	<param name="sym"/>
	<value-of select="boolean($ontology-namespaces/krextor:loc[@theory eq $sym/@cd]/@sem-web-base)"/>
    </function>

    <xd:doc>Returns whether the given term is an expression made in terms of an ontology
	<xd:param name="term">an OpenMath (sub)term whose topmost symbol (<code>OMS</code>) is checked with <code>krextor:is-from-ontology</code></xd:param>
    </xd:doc>
    <function name="krextor:is-ontology-term" as="xs:boolean">
	<param name="term"/>
	<value-of select="krextor:is-from-ontology(($term/descendant::om:OMS)[1])"/>
    </function>

    <xd:doc>Creates an RDF triple for a single OWL axiom given as a predicate(subject, object) triple</xd:doc>
    <template match="axiom/FMP/om:OMOBJ/om:OMA[count(om:*) eq 3 and krextor:is-ontology-term(.)]" mode="krextor:main">
	<variable name="sym" select="om:*[1]"/>

	<variable name="predicate-object-rewritten">
	    <krextor:dummy>
		<om:OMA>
		    <copy-of select="om:*[1]"/><!-- predicate -->
		    <copy-of select="om:*[3]"/><!-- object -->
		</om:OMA>
	    </krextor:dummy>
	</variable>
	<call-template name="krextor:create-resource">
	    <!-- TODO automate this by overriding create-resource -->
	    <with-param name="subject" select="krextor:ontology-uri-or-blank(om:*[2])"/>
	    <with-param name="process-next" select="om:*[2][not(self::om:OMS)]
		|$predicate-object-rewritten/*"/>
	</call-template>
    </template>

    <template match="krextor:dummy/om:OMA[count(om:*) eq 2][om:*[1][self::om:OMS]]" mode="krextor:main">
	<call-template name="krextor:create-resource">
	    <with-param name="related-via-properties" select="krextor:ontology-uri(om:*[1])" tunnel="yes"/>
	    <with-param name="subject" select="krextor:ontology-uri-or-blank(om:*[2])"/>
	    <with-param name="process-next" select="om:*[2][not(self::om:OMS)]"/>
	</call-template>
    </template>

    <xd:doc>Initiates the creation of a class definition</xd:doc>
    <template match="definition[@type eq 'simple' and krextor:is-ontology-term(om:OMOBJ)]" mode="krextor:main">
	<!-- we only consider definitions that define one symbol -->
	<variable name="symbol" select="ancestor::theory[1]//symbol[@name eq current()/@for]"/>
	<if test="$symbol">
	    <!-- construct an OpenMath symbol -->
	    <variable name="symbol-oms">
		<om:OMS cd="{ancestor::theory[1]/@xml:id}" name="{$symbol/@name}"/>
	    </variable>
	    <call-template name="krextor:create-resource">
	    	<with-param name="subject" select="krextor:ontology-uri($symbol-oms/om:OMS)"/>
	    </call-template>
	</if>
    </template>

    <xd:doc>Creates simple equivalence definitions (<i>owl:equivalentClass</i>, <i>owl:equivalentProperty</i>, <i>owl:sameAs</i>)</xd:doc>
    <template match="om:OMS[parent::om:OMOBJ[parent::definition[@type eq 'simple']]]" mode="krextor:main">
	<variable name="symbol-type" select="ancestor::theory[1]//symbol[@name eq current()/parent::om:OMOBJ/parent::definition/@for]/type/om:OMOBJ/descendant::om:OMS[1]"/>
	<call-template name="krextor:create-resource">
	    <with-param name="related-via-properties" tunnel="yes">
		<choose>
		    <!-- so far, we assume that owl:Class is the only known class type -->
		    <when test="$symbol-type/@cd eq 'owl' and $symbol-type/@name eq 'Class'">&owl;equivalentClass</when>
		    <!-- we recognize rdf:Property and owl:*Property as property types -->
		    <when test="($symbol-type/@cd eq 'rdf' and $symbol-type/@name eq 'Property') or ($symbol-type/@cd eq 'owl' and ends-with($symbol-type/@name, 'Property'))">&owl;equivalentProperty</when>
		    <!-- symbols of any other type, or without a type, are considered individuals -->
		    <otherwise>&owl;sameAs</otherwise>
		</choose>
	    </with-param>
	    <with-param name="subject" select="krextor:ontology-uri(.)"/>
	</call-template>
    </template>

    <xd:doc><i>owl:intersectionOf, owl:unionOf, owl:complementOf, owl:oneOf</i> constructor</xd:doc>
    <template match="om:OMA[om:*[1][self::om:OMS[@cd eq 'owl' and (@name = ('intersectionOf', 'complementOf', 'unionOf', 'oneOf')) ]]]" mode="krextor:main">
	<call-template name="krextor:create-resource">
	    <with-param name="related-via-properties" select="krextor:ontology-uri(om:*[1])" tunnel="yes"/>
	    <with-param name="collection" select="true()"/>
	    <with-param name="process-next" select="om:*[position() ge 2]"/>
	</call-template>
    </template>

    <xd:doc><i>owl:Restriction</i> constructor</xd:doc>
    <!-- TODO formally specify this as an OMDoc axiom: https://trac.kwarc.info/krextor/ticket/27 -->
    <template match="om:OMA[count(om:*) eq 3][om:*[1][self::om:OMS[@cd eq 'owl' and @name eq 'Restriction']]][om:*[2][self::om:OMS]]" mode="krextor:main">
	<call-template name="krextor:create-resource">
	    <with-param name="type" select="'&owl;Restriction'"/>
	    <with-param name="properties">
		<krextor:property uri="&owl;onProperty" object="{krextor:ontology-uri(om:*[2])}"/>
	    </with-param>
	    <with-param name="blank-node" select="true()"/>
	    <with-param name="process-next" select="om:*[3]"/>
	</call-template>
    </template>

    <xd:doc>Sets the cardinality of a property restriction</xd:doc>
    <template match="om:OMA[om:*[1][self::om:OMS[@cd eq 'owl' and @name = ('minCardinality', 'maxCardinality', 'cardinality')]]][om:*[2][self::om:OMI]]" mode="krextor:main">
	<call-template name="krextor:add-literal-property">
	    <with-param name="property" select="krextor:ontology-uri(om:*[1])"/>
	    <with-param name="object" select="om:*[2]/text()"/>
	    <with-param name="datatype" select="'&xsd;nonNegativeInteger'"/>
	</call-template>
    </template>
	
	<xd:doc>Sets the allValuesFrom, someValuesFrom, hasValue of a property restriction</xd:doc>
	<template match="om:OMA[om:*[1][self::om:OMS[@cd eq 'owl' and @name = ('allValuesFrom', 'someValuesFrom', 'hasValue')]]][om:*[2][self::om:OMS]]" mode="krextor:main">
		<call-template name="krextor:create-resource">
			<with-param name="related-via-properties" select="krextor:ontology-uri(om:*[1])" tunnel="yes"/>
			<with-param name="subject-uri" select="krextor:ontology-uri(om:*[2])" tunnel="yes"/>			
			<with-param name="process-next" select="om:*[3]"/>
		</call-template>		
	</template>
	
	<xd:doc>Sets hasValue of a DataType property restriction</xd:doc>
	<template match="om:OMA[om:*[1][self::om:OMS[@cd eq 'owl' and @name = ('hasValue')]]][om:*[2][not(self::om:OMS)]]" mode="krextor:main">
		<call-template name="krextor:add-literal-property">
			<with-param name="property" select="krextor:ontology-uri(om:*[1])"/>
			<with-param name="object" select="om:*[2]/text()"/>
		</call-template>
	</template>
	

    <xd:doc>Creates a resource from an individual symbol</xd:doc>
    <template match="om:OMS" mode="krextor:main">
	<call-template name="krextor:create-resource">
	    <with-param name="subject" select="krextor:ontology-uri(.)"/>
	</call-template>
    </template>

    <xd:doc>Creates an OWL import declaration for any semantic web ontology whose OMDoc theory we import</xd:doc>
    <template match="imports" mode="krextor:main">
      <param name="subject-uri" as="xs:anyURI" tunnel="yes"/>
      <variable name="imported-ontology" select="krextor:ontology-uri(document(@from))"/>
      <if test="not(xs:string($imported-ontology) = (
                '&owl;',
                '&rdfs;'
                ))">
        <call-template name="krextor:add-uri-property">
          <with-param name="property" select="'&owl;imports'"/>
          <with-param name="object" select="$imported-ontology"/>
        </call-template>
      </if>
    </template>

    <xd:doc>Creates an OWL ontology; tries to use its semantic web namespace URI</xd:doc>
    <template match="theory" mode="krextor:main">
	<variable name="sem-web-base" select="$ontology-namespaces/krextor:loc[@theory eq current()/@xml:id]/@sem-web-base"/>
	<variable name="type" select="'&owl;Ontology'"/>
	<choose>
	    <when test="exists($sem-web-base)">
		<call-template name="krextor:create-ontology-resource">
		    <with-param name="subject-uri" select="$sem-web-base"
			tunnel="yes"/>
		    <with-param name="type" select="$type"/>
		</call-template>
	    </when>
	    <otherwise>
		<call-template name="krextor:create-ontology-resource">
		    <with-param name="mmt" select="true()" tunnel="yes"/>
		    <with-param name="type" select="$type"/>
		</call-template>
	    </otherwise>
	</choose>
    </template>

    <xd:doc>Try to find the ontology namespace of a given theory (special
	metadata field <code>odo:vocab</code>)
	<xd:param name="theory" type="node">the theory</xd:param>
    </xd:doc>
    <function name="krextor:sem-web-base" as="xs:string">
	<param name="theory"/>
	<variable name="link" as="node()*">
	    <sequence select="$theory/metadata/link[krextor:curie-to-uri($theory, @rel) eq '&odo;vocab']"/>
	</variable>
        <value-of select="if ($link/@resource) then $link/@resource else if ($link/@href) then $link/@href else ''"/>
    </function>

    <xd:doc>We don't extract top-level metadata, as they do not correspond to
	anything in an ontology.</xd:doc>
    <template match="/omdoc/metadata" mode="krextor:main"/>

    <xd:doc>We don't extract the special annotation of the ontology namespace
	of a theory, as it is for internal use.</xd:doc>
    <template match="link[krextor:curie-to-uri(., @rel) eq '&odo;vocab']" mode="krextor:main"/>
</stylesheet>
