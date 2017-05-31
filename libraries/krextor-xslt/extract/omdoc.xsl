<?xml version="1.0" encoding="UTF-8"?>

<!--
    *  Copyright (C) 2008
    *  Christoph Lange
    *  Gordan Ristovski
    *  Andrei Ioniţă
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
    <!ENTITY oo "http://omdoc.org/ontology#">
    <!ENTITY dc "http://purl.org/dc/elements/1.1/">
    <!ENTITY sdoc "http://salt.semanticauthoring.org/onto/abstract-document-ontology#">
    <!ENTITY sr "http://salt.semanticauthoring.org/onto/rhetorical-ontology#">
]>

<stylesheet xmlns="http://www.w3.org/1999/XSL/Transform" 
    xpath-default-namespace="http://omdoc.org/ns"
    xmlns:krextor="http://kwarc.info/projects/krextor"
    xmlns:omdoc="http://omdoc.org/ns"
    xmlns:om="http://www.openmath.org/OpenMath"
    xmlns:m="http://www.w3.org/1998/Math/MathML"
    xmlns:xd="http://www.pnp-software.com/XSLTdoc"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    version="2.0">

    <include href="util/omdoc.xsl"/>

    <xd:doc type="stylesheet">
	<xd:short>Extraction module for <a href="http://www.omdoc.org">OMDoc</a></xd:short>
	<xd:detail>
	    <p>This stylesheet extracts RDF from <a href="http://www.omdoc.org">OpenMath</a> content dictionaries (CDs).</p>  
	    <p>Existing metadata vocabularies are reused, as documented here or in the ontology.</p>
            <p>See <a href="&oo;">&oo;</a> or the sources at <a href="https://svn.omdoc.org/repos/omdoc/trunk/owl">https://svn.omdoc.org/repos/omdoc/trunk/owl</a> for the corresponding ontology.</p>
	</xd:detail>
	<xd:author>Christoph Lange</xd:author>
	<xd:copyright>Christoph Lange, 2008–2010</xd:copyright>
	<xd:svnId>$Id: omdoc.xsl 1995 2011-05-26 19:23:51Z clange $</xd:svnId>
    </xd:doc>
    
    <!-- Note that this is not the global default; actually the 
         concrete way of URI generation is decided on element level -->
    <param name="autogenerate-fragment-uris" select="
	'xml-id',
	'document-root-base'"/>

    <!-- Other settings for testing -->
    <!--
    <param name="autogenerate-fragment-uris" select="
	'pseudo-xpath'
	"/>
    -->

    <param name="use-root-xmlid" select="false()"/>

    <xd:doc>Generate RDF for the document structure, in terms of the SALT document ontology?  Experimental feature.</xd:doc>
    <param name="use-document-ontology" select="false()"/>

    <include href="util/openmath.xsl"/>

    <template match="node()" mode="krextor:uri-generation-method">
	<param name="mmt" tunnel="yes"/>
        <sequence select="if ($mmt and @name)
	    then ('mmt', $autogenerate-fragment-uris)
	    else $autogenerate-fragment-uris"/>
    </template>
	
    <xd:doc>“Overridden” OMDoc-specific variant of <i>krextor:create-resource</i>, keeps track of a few OMDoc structures and notions that affect many OMDoc elements
	<xd:param name="formality-degree" type="string">the URI of a formality degree from the ontology</xd:param>
	<xd:param name="document-base">the URI of the current document section resource *tunneled)</xd:param>
	<xd:param name="knowledge-base">the URI of the current mathematical or rhetorical structure (tunneled)</xd:param>
	<xd:param name="ontologies" type="string*">a list of values from ('document', 'knowledge'), specifying whether a document section or a mathematical/rhetorical structure resource should be generated from this element</xd:param>
    </xd:doc>
    <template name="krextor:create-omdoc-resource">
	<param name="type"/>
	<param name="formality-degree"/>
	<param name="properties"/>
	<param name="subject-uri" as="xs:anyURI" tunnel="yes"/>
	<param name="document-base" tunnel="yes"/>
	<param name="knowledge-base" tunnel="yes"/>
	 <!-- <param name="ontologies" required="yes"/> -->
	<param name="ontologies" required="no"/>
	<param name="mmt" tunnel="yes"/>
	<!-- TODO does this work?  In generic.xsl we use
	     instance of document-node() -->
	<param name="use-document-uri" select="not($use-root-xmlid) and self::node() = /"/>
	<param name="process-next" select="*|@*"/>
	<param name="blank-node" select="false()"/>
	<!-- Check if we can at all generate a URI for the current element -->
	<if test="($mmt and @name) or $use-document-uri or @xml:id">
	    <call-template name="krextor:create-resource">
		<with-param name="properties">
		    <if test="$formality-degree">
			<krextor:property uri="&oo;formalityDegree" object="{$formality-degree}"/>
		    </if>
                    <copy-of select="$properties"/>
		</with-param>
		<with-param name="type" select="$type"/>
		<with-param name="blank-node" select="$blank-node"/>
		<with-param name="process-next" select="$process-next"/>
	    </call-template>
	</if>
    </template>

    <xd:doc>Converts a list of symbol names into a list of the URIs of the corresponding symbol elements</xd:doc>
    <function name="omdoc:symbol-uris" as="xs:string*">
      <param name="node" as="node()"/>
      <!-- TODO MMT URIs not yet supported; fix this together with the
           improved URI generation, https://trac.kwarc.info/krextor/ticket/16 -->
      <value-of select="for $id in $node/ancestor::theory[1]//
                          symbol[@name = tokenize($node, '\s+')]/@xml:id
                        return concat('#', $id)"/>
    </function>

    <function name="omdoc:symbol-uri" as="xs:string?">
      <param name="node" as="node()"/>
      <value-of select="concat('#', $node/ancestor::theory[1]//symbol[@name eq $node]/@xml:id)"/>
    </function>

    <!-- TODO: There can also be @for for the rhetorical types but it's not yet completely clear where
    the @for should point to and how to model it in the ontology. -->

    <xd:doc>Some SALT rhetorical block types (usable everywhere)</xd:doc>
    <variable name="salt-rhetorical-block-types" select="
	'introduction',
	'background',
	'motivation',
	'scenario',
	'contribution',
	'evaluation',
	'results',
	'discussion',
	'conclusion'"/>

    <xd:doc>All SALT rhetorical block types (usable only on top level)</xd:doc>
    <variable name="salt-rhetorical-block-types-all" select="
	$salt-rhetorical-block-types,
	'abstract',
	'entities'"/>

    <xd:doc>SALT RST-like rhetorical relation types</xd:doc>
    <variable name="salt-rhetorical-relation-types" select="
	'antithesis',
	'circumstance',
	'concession',
	'condition',
	'evidence',
	'means',
	'preparation',
	'purpose',
	'cause',
	'consequence',
	'elaboration',
	'restatement',
	'solutionhood'
	"/>

    <xd:doc>OMDoc assertion types</xd:doc>
    <variable name="omdoc-assertion-types" select="
	'theorem',
	'lemma',
	'corollary',
	'proposition',
	'conjecture',
	'false-conjecture',
	'obligation',
	'postulate',
	'formula',
	'assumption',
	'rule'
	"/>

    <xd:doc>OMDoc statement and assertion types</xd:doc>
    <variable name="omdoc-statement-types" select="
	$omdoc-assertion-types,
	'axiom',
	'definition',
	'example',
	'proof',
	'assertion',
	'rule',
	'hypothesis',
	'notation'
	"/>

    <xd:doc>*—homeTheory→Theory</xd:doc>
    <template match="omdoc:*/@theory" mode="krextor:main">
	<call-template name="krextor:add-uri-property">
	    <with-param name="property" select="'&oo;homeTheory'"/>
	</call-template>
    </template>

    <xd:doc>Document</xd:doc>
    <template match="omdoc" mode="krextor:main">
	<call-template name="krextor:create-omdoc-resource">
	    <with-param name="mmt" select="@version eq '1.6'" tunnel="yes"/>
	    <with-param name="type" select="'&oo;Document'"/>
            <with-param name="ontologies" select="'document'"/>
	</call-template>
    </template>

    <xd:doc>DocumentUnit</xd:doc>
    <template match="omgroup"
      mode="krextor:main">
	<call-template name="krextor:create-omdoc-resource">
	    <!-- FIXME documentUnit, rhetoricalBlock? -->
	    <with-param name="type" select="
		if (@type = $salt-rhetorical-block-types-all) then concat('&sr;', krextor:dashes-to-camelcase(@type))
		else '&oo;DocumentUnit'"/>
            <with-param name="related-via-properties" select="if ($use-document-ontology) then
                if(parent::omdoc) then '&sdoc;hasComposite' else '&sdoc;hasPart'
                else ''" tunnel="yes"/>
	</call-template>
    </template>

    <xd:doc>*—hasDirectPart→Reference</xd:doc>
    <template match="ref" mode="krextor:main">
	<call-template name="krextor:create-omdoc-resource">
	    <!-- FIXME documentUnit -->
	    <with-param name="type" select="'&oo;Reference'"/>
	    <with-param name="related-via-properties" select="'&oo;hasDirectPart'" tunnel="yes"/>
	</call-template>
    </template>

    <xd:doc>Reference—hasReference→*</xd:doc>
    <template match="ref/@xref" mode="krextor:main">
	<call-template name="krextor:add-uri-property">
	    <with-param name="property" select="'&oo;hasReference'"/>
	</call-template>
    </template>

    <xd:doc>Theory</xd:doc>
    <template match="theory" mode="krextor:main">	
	<call-template name="krextor:create-omdoc-resource">
	    <!-- FIXME documentUnit, mathematicalBlock -->
            <with-param name="related-via-properties" select="if (parent::theory) then '&oo;homeTheoryOf' else '&oo;hasDirectPart' , if ($use-document-ontology) then
                if (parent::omdoc) then '&sdoc;hasComposite' else '&sdoc;hasPart'
                else ''" tunnel="yes"/>
	    <with-param name="type" select="'&oo;Theory'"/>
	</call-template>
	<!-- TODO make this the home theory of any statement-level child
	and any subtheory, which is not in an XIncluded or ref-included document
	Probably use a separate mode for that, to be able to match e.g.
	match="definition" mode="child" and generate containsDefinition from that,
	instead of a generic contains relationship. -->
    </template>

    <xd:doc>Theory—metaTheory→Theory</xd:doc>
    <template match="theory/@meta" mode="krextor:main">
	<call-template name="krextor:add-uri-property">
	    <with-param name="property" select="'&oo;metaTheory'"/>
	</call-template>
    </template>

    <xd:doc>a plain OMDoc 1.2 import without morphism</xd:doc>
    <template match="imports[not(*)]" mode="krextor:main">
      <!-- We can't directly match the @from attribute, as 
           is it not processed by the parent apply-templates -->
      <call-template name="krextor:add-uri-property">
        <with-param name="property" select="'&oo;imports'"/>
        <with-param name="object" select="@from"/>
      </call-template>
    </template>

    <xd:doc>An MMT (OMDoc 1.6) import, or an OMDoc 1.2 import with morphism</xd:doc>
    <template match="import|
                     imports[*]"
      mode="krextor:main">
	<call-template name="krextor:create-omdoc-resource">
	    <!-- FIXME mathematicalBlock. Is it a document unit? -->
	    <with-param name="type" select="'&oo;Import'"/>
		<with-param name="related-via-properties" select="if (parent::theory) then '&oo;homeTheoryOf' else '&oo;hasImport' , if ($use-document-ontology) then '&sdoc;hasPart' else ''" tunnel="yes"/>
	</call-template>
    </template>    

    <template match="import/@from|
                     imports[*]/@from"
      mode="krextor:main">
	<call-template name="krextor:add-uri-property">
	    <with-param name="property" select="'&oo;importsFrom'"/>
	</call-template>
    </template>
	
	
    <template match="omtext/@verbalizes" mode="krextor:main">
	<call-template name="krextor:add-uri-property">
	    <with-param name="object-is-list" select="true()"/>
	    <with-param name="property" select="'&oo;verbalizes'"/>
	</call-template>
    </template>

    <template match="FMP/@logic" mode="krextor:main">
	<call-template name="krextor:add-literal-property">
	    <with-param name="property" select="'&oo;logic'"/>
	</call-template>
    </template>

    <template match="CMP/@xml:lang" mode="krextor:main">
	<call-template name="krextor:add-literal-property">
	    <with-param name="property" select="'&dc;language'"/>
	</call-template>
    </template>

    <template match="om:OMOBJ//om:OMS" mode="krextor:main">
	<call-template name="krextor:add-uri-property">
	    <with-param name="property" select="'&oo;usesSymbol'"/>
	    <!-- use the innermost cdbase attribute. At least the OMOBJ must have a cdbase attribute,
	    or otherwise the default is assumed -->
	    <with-param name="object" select="om:symbol-uri((ancestor-or-self::om:*/@cdbase)[last()], @cd, @name)"/>
	</call-template>
    </template>

    <!-- TODO: MMT imports: add Theory-hasImport-Import-importsFrom-Theory -->

    <!-- TODO adapt to further progress of the MMT (OMDoc 1.6) specification -->
    <template match="symbol[not(@role)]" mode="krextor:main">
	<call-template name="krextor:create-omdoc-resource">
	    <!-- FIXME mathematicalBlock. Is it a document unit? -->
		<with-param name="related-via-properties" select="if (parent::proof) then '&oo;hasStep' else if (parent::theory) then '&oo;homeTheoryOf' else '&oo;hasDirectPart' , if ($use-document-ontology) then '&sdoc;hasPart' else ''" tunnel="yes"/>
	    <with-param name="type" select="if (parent::proof)
then '&oo;ProofLocalSymbol'
else '&oo;Symbol'"/>
	</call-template>
    </template>

    <template match="symbol/type" mode="krextor:main">
      <call-template name="krextor:create-omdoc-resource">
        <with-param name="related-via-properties"
          select="'&oo;hasDeclaredType'"
          tunnel="yes"/>
        <with-param name="type" select="'&oo;DeclaredType'"/>
      </call-template>
    </template>

    <template match="type[not(parent::symbol)]" mode="krextor:main">
      <call-template name="krextor:create-omdoc-resource">
        <!-- FIXME documentUnit, mathematicalBlock -->
        <with-param name="related-via-properties"
          select="if (parent::theory) then '&oo;homeTheoryOf' else '&oo;hasDirectPart' ,
                  if ($use-document-ontology) then
                  if (parent::omdoc) then '&sdoc;hasComposite' else '&sdoc;hasPart'
                  else ''"
          tunnel="yes"/>
        <with-param name="type"
          select="if (@just-by) then '&oo;AssertedType'
                  else '&oo;DeclaredType'"/>
      </call-template>
    </template>
    
    <xd:doc>Symbol—has{Declared,Asserted}Type→Type</xd:doc>
    <template match="type/@for" mode="krextor:main">
      <call-template name="krextor:add-uri-property">
        <with-param name="property"
          select="if (../@just-by) then '&oo;hasAssertedType'
                  else '&oo;hasDeclaredType'"/>
        <with-param name="inverse" select="true()"/>
        <with-param name="object" select="omdoc:symbol-uri(.)"/>
      </call-template>
    </template>

    <xd:doc>AssertedType—typeJustifiedBy→Assertion</xd:doc>
    <template match="type/@just-by" mode="krextor:main">
      <call-template name="krextor:add-uri-property">
        <with-param name="property" select="'&oo;typeJustifiedBy'"/>
      </call-template>
    </template>

    <!-- TODO adapt to further progress of the MMT (OMDoc 1.6) specification -->
    <template match="symbol[@role eq 'axiom']|
                     axiom"
      mode="krextor:main">
	<!-- axiom/@for missing -->
	<call-template name="krextor:create-omdoc-resource">
	    <!-- FIXME documentUnit, mathematicalBlock (can contain CMPs) -->
		<with-param name="related-via-properties" select="if (parent::proof) then '&oo;hasStep' else if (parent::theory) then '&oo;homeTheoryOf' else '&oo;hasDirectPart' , if ($use-document-ontology) then '&sdoc;hasPart' else ''" tunnel="yes"/>
	    <with-param name="type" select="'&oo;Axiom'"/>
	    <with-param name="formality-degree" select="'&oo;Formal'"/>
	</call-template>
    </template>

    <template match="definition[@name or @xml:id]" mode="krextor:main">
	<call-template name="krextor:create-omdoc-resource">
	    <!-- FIXME documentUnit, mathematicalBlock -->
		<with-param name="related-via-properties" select="if (parent::proof) then '&oo;hasStep' else if (parent::theory) then '&oo;homeTheoryOf' else '&oo;hasDirectPart' , if ($use-document-ontology) then '&sdoc;hasPart' else ''" tunnel="yes"/>
	    <with-param name="type" select="if (parent::proof)
then '&oo;ProofLocalDefinition'
else '&oo;Definition'"/>
		<with-param name="formality-degree" select="'&oo;Formal'"/>
	</call-template>
    </template>

    <template match="definition/@for|
                     omtext[@type eq 'definition']/@for"
      mode="krextor:main">
	<call-template name="krextor:add-uri-property">
	    <with-param name="property" select="'&oo;defines'"/>
	    <with-param name="object" select="omdoc:symbol-uris(.)"/>
	    <with-param name="object-is-list" select="true()"/>
	</call-template>
    </template>

    <template match="example/@for|
                     omtext[@type eq 'example']/@for"
      mode="krextor:main">
	<call-template name="krextor:add-uri-property">
	    <with-param name="property" select="'&oo;exemplifies'"/>
	</call-template>
    </template>
	
    <template match="alternative" mode="krextor:main">
	<call-template name="krextor:create-omdoc-resource">
	    <!-- FIXME documentUnit, mathematicalBlock -->
            <with-param name="related-via-properties" select="if (parent::theory) then '&oo;homeTheoryOf' else '&oo;hasDirectPart' , if ($use-document-ontology) then
                if (parent::omdoc) then '&sdoc;hasComposite' else '&sdoc;hasPart'
                else ''" tunnel="yes"/>
	    <with-param name="type" select="'&oo;AlternativeDefinition'"/>
		<with-param name="formality-degree" select="'&oo;Formal'"/>
	</call-template>
    </template>

    <template match="assertion" mode="krextor:main">
	<call-template name="krextor:create-omdoc-resource">
	    <!-- FIXME documentUnit, mathematicalBlock -->
            <with-param name="related-via-properties" select="if (parent::theory) then '&oo;homeTheoryOf' else '&oo;hasDirectPart' , if ($use-document-ontology) then
                if (parent::omdoc) then '&sdoc;hasComposite' else '&sdoc;hasPart'
                else ''" tunnel="yes"/>
	    <with-param name="type" select="concat('&oo;',
		if (@type eq 'assumption') then 'AssumptionAssertion'
                else if (@type = $omdoc-assertion-types) then krextor:dashes-to-camelcase(@type)
		else 'Assertion')"/>
	    <with-param name="formality-degree" select="'&oo;Formal'"/>
	</call-template>
    </template>

    <template match="example" mode="krextor:main">
	<call-template name="krextor:create-omdoc-resource">
	    <!-- FIXME documentUnit, mathematicalBlock -->
            <with-param name="related-via-properties" select="if (parent::theory) then '&oo;homeTheoryOf' else '&oo;hasDirectPart' , if ($use-document-ontology) then
                if (parent::omdoc) then '&sdoc;hasComposite' else '&sdoc;hasPart'
                else ''" tunnel="yes"/>
	    <with-param name="type" select="'&oo;Example'"/>
            <with-param name="formality-degree" select="'&oo;Formal'"/>
	</call-template>
    </template>

    <template match="notation" mode="krextor:main">
	<call-template name="krextor:create-omdoc-resource">
	    <!-- FIXME documentUnit, mathematicalBlock -->
            <with-param name="related-via-properties" select="if (parent::theory) then '&oo;homeTheoryOf' else '&oo;hasDirectPart' , if ($use-document-ontology) then
                if (parent::omdoc) then '&sdoc;hasComposite' else '&sdoc;hasPart'
                else ''" tunnel="yes"/>
	    <with-param name="type" select="'&oo;NotationDefinition'"/>
            <with-param name="formality-degree" select="'&oo;Formal'"/>
	</call-template>
    </template>

    <template match="prototype[not(preceding-sibling::prototype)]" mode="krextor:main">
      <variable name="symbol" select="om:matched-symbol(.)"/>
      <!-- has attributes:
           @cdbase: usually empty (defaults to theory's cdbase) in OMDoc
           @cd: name of current theory, or empty?
           @name: name of symbol
           -->
      <call-template name="krextor:add-uri-property">
        <!-- the enclosing notation is the subject -->
        <with-param name="property" select="'&oo;rendersSymbol'"/>
        <!-- http://trac.kwarc.info/krextor/ticket/82 -->
        <with-param name="object" select="'FIXME'"/>
      </call-template>
    </template>

    <template match="proof|
                     proofobject"
      mode="krextor:main">
        <variable name="nested" select="parent::method[parent::derive]"/>
	<call-template name="krextor:create-omdoc-resource">
	    <!-- FIXME documentUnit, mathematicalBlock -->
	    <with-param name="related-via-properties" select="
                if ($nested) then '&oo;stepJustifiedBySubProof'
                else if (parent::theory) then '&oo;homeTheoryOf'
                else '&oo;hasDirectPart',
                if ($use-document-ontology) then
                if (parent::omdoc) then '&sdoc;hasComposite'
                else '&sdoc;hasPart'
                else ''" tunnel="yes"/>
	    <with-param name="type" select="if ($nested) then '&oo;NestedProof'
                                            else '&oo;Proof'"/>
	    <with-param name="formality-degree" select="if (self::proof)
                                                        then '&oo;Formal'
                                                        else '&oo;Computerized'"/>
	</call-template>
    </template>

    <template match="proof/@for|
                     omtext[@type eq 'proof']/@for"
      mode="krextor:main">
	<call-template name="krextor:add-uri-property">
	    <with-param name="property" select="'&oo;proves'"/>
	</call-template>
    </template>

    <!--TODO omtext/@type eq 'assumption' may have the inductive attribute-->
    <template match="omtext" mode="krextor:main">
    	<variable name="has-mathematical-type" select="@type = $omdoc-statement-types"/>
	<call-template name="krextor:create-omdoc-resource">
	    <!-- FIXME documentUnit, (mathematicalBlock|rhetoricalBlock)?
	    maybe split into multiple templates -->
	    <with-param name="related-via-properties" select="if (parent::theory and $has-mathematical-type) then '&oo;homeTheoryOf'
	    	else if (parent::proof) then '&oo;hasStep' else '&oo;hasDirectPart' ,
                if ($use-document-ontology) then
                if (parent::omdoc) then '&sdoc;hasComposite' else '&sdoc;hasPart'
                else ''" tunnel="yes"/>
	    <with-param name="type" select="
                (: This case needs special treatment, as notation is a mathematical type :)
                if (@type eq 'notation') then '&oo;NotationDefinition'
		else if ($has-mathematical-type) then concat('&oo;', krextor:dashes-to-camelcase(@type))
		else if (@type = $salt-rhetorical-block-types) then concat('&sr;', krextor:dashes-to-camelcase(@type))
		else if (@type eq 'derive') then '&oo;DerivationStep'
		else if (parent::proof) then '&oo;ProofText'
		else '&oo;Statement'"/>
	    <with-param name="formality-degree" select="'&oo;Informal'"/>
	</call-template>
    </template>

    <template match="CMP|
                     FMP"
      mode="krextor:main">
	<call-template name="krextor:create-omdoc-resource">
	    <!-- FIXME documentUnit, mathematicalBlock -->
	    <with-param name="related-via-properties" select="'&oo;hasProperty' , if ($use-document-ontology) then '&sdoc;hasInformationChunk' else ''" tunnel="yes"/>
	    <with-param name="type" select="'&oo;Property'"/>
	    <with-param name="formality-degree"
              select="if (self::CMP) then '&oo;Informal'
                      else '&oo;Formal'"/>
            <with-param name="properties">
                <!-- extract the full-text content of a CMP -->
                <if test="self::CMP">
                    <krextor:property uri="&oo;hasText">
                        <apply-templates mode="krextor:text"/>
                    </krextor:property>
                </if>
            </with-param>
	</call-template>
    </template>

    <!-- in full-text extraction (from CMPs), recurse into OMDoc elements -->
    <template match="*" mode="krextor:text">
        <apply-templates mode="krextor:text"/>
    </template>

    <!-- in full-text extraction, copy every text node -->
    <template match="text()" mode="krextor:text">
        <value-of select="."/>
    </template>

    <!-- when extracting the full-text content of a CMP, we are not interested in 
         strings in mathematical objects (in OpenMath usually numbers, in Content 
         MathML also symbols and variable names) -->
    <template match="m:*|om:*" mode="krextor:text"/>

    <!-- FIXME is it right to match omtext[@type eq 'assumption'] here?? -->
    <template match="FMP/assumption|
                     omtext[@type eq 'assumption']/@for"
      mode="krextor:main">
	<call-template name="krextor:create-omdoc-resource">
	    <!-- FIXME mathematicalBlock -->
	    <with-param name="related-via-properties" select="'&oo;assumes'" tunnel="yes"/>
	    <with-param name="type" select="'&oo;Assumption'"/>
	</call-template>
    </template>

    <template match="FMP/conclusion" mode="krextor:main">
	<call-template name="krextor:create-omdoc-resource">
	    <!-- FIXME mathematicalBlock -->
	    <with-param name="related-via-properties" select="'&oo;concludesWith'" tunnel="yes"/>
	    <with-param name="type" select="'&oo;Conclusion'"/>
	</call-template>
    </template>

    <template match="CMP//term[@role eq 'definiendum']" mode="krextor:main">
	<call-template name="krextor:add-uri-property">
	    <with-param name="property" select="'&oo;defines'"/>
	    <with-param name="object" select="om:symbol-uri((ancestor-or-self::om:*/@cdbase)[last()], @cd, @name)"/>
	</call-template>
    </template>

    <template match="CMP//term[@role eq 'definiens']" mode="krextor:main">
	<call-template name="krextor:add-uri-property">
	    <with-param name="property" select="'&oo;usesSymbol'"/>
	    <with-param name="object" select="om:symbol-uri((ancestor-or-self::om:*/@cdbase)[last()], @cd, @name)"/>
	</call-template>
    </template>

    <template match="phrase[@type eq 'nucleus']" mode="krextor:main">
	<!-- Here, we just create the resource.
	As it can be used in multiple rhetorical relations, we do that in a second pass -->
	<call-template name="krextor:create-omdoc-resource">
	    <!-- FIXME rhetoricalBlock.  No documentUnit, as below InformationChunk level -->
	    <with-param name="type" select="'&sr;Nucleus'"/>
	</call-template>
    </template>

    <template match="phrase[@type eq 'nucleus']" mode="second-pass">
	<param name="_omdoc-second-pass" tunnel="yes"/>
	<call-template name="krextor:create-omdoc-resource">
	    <!-- Here, we do not actually create the resource but abuse that
	    template to create an additional link from the rhetorical relation
	    to it. -->
	    <with-param name="related-via-properties" select="'&oo;hasNucleus'" tunnel="yes"/>
	</call-template>
    </template>

    <template match="phrase[@type eq 'satellite']" mode="second-pass">
	<call-template name="krextor:create-omdoc-resource">
	    <!-- FIXME rhetoricalBlock.  No documentUnit, as below InformationChunk level -->
	    <with-param name="related-via-properties" select="'&oo;hasSatellite'" tunnel="yes"/>
	    <with-param name="type" select="'&sr;Satellite'"/>
	</call-template>
    </template>

    <template match="phrase[@type eq 'satellite']/@for" mode="second-pass">
	<apply-templates select="document(.)" mode="second-pass"/>
    </template>

    <!-- We start processing phrases and rhetorical relations here -->
    <template match="phrase[@type eq 'satellite']" mode="krextor:main">
	<param name="_omdoc-second-pass" tunnel="yes"/>
	<choose>
	    <when test="$_omdoc-second-pass">
		<apply-templates select=".|@for" mode="second-pass">
		    <with-param name="_omdoc-second-pass" select="false()" tunnel="yes"/>
		</apply-templates>
	    </when>
	    <otherwise>
		<call-template name="krextor:create-omdoc-resource">
		    <!-- FIXME rhetoricalBlock.  No documentUnit, as below InformationChunk level -->
		    <with-param name="related-via-inverse-properties" select="'&sr;partOfRhetoricalStructure'" tunnel="yes"/>
		    <with-param name="type" select="concat('&sr;',
			if (@relation = $salt-rhetorical-relation-types) then krextor:dashes-to-camelcase(@relation)
			else 'RhetoricalRelation')"/>
		    <with-param name="blank-node" select="true()"/>
		    <with-param name="process-next" select="."/>
		    <with-param name="_omdoc-second-pass" select="true()" tunnel="yes"/>
		</call-template>
	    </otherwise>
	</choose>
    </template>

    <template match="derive/method/premise" mode="krextor:main">
	<!-- TODO @rank -->
	<!-- enforce the following template to be called -->
	<apply-templates select="@xref" mode="#current"/>
    </template>

    <template match="derive/method/premise/@xref" mode="krextor:main">
        <variable name="target-is-proof-step" select="document(.)/ancestor::proof[1] is ancestor::proof[1]"/>
	<call-template name="krextor:add-uri-property">
	    <with-param name="property" select="
                if ($target-is-proof-step) then '&oo;stepJustifiedByPrecedingStep'
                else '&oo;stepExternallyJustifiedBy'"/>
	    <!--<with-param name="formality-degree" select="'&oo;Informal'"/>-->
	</call-template>
    </template>

    <template match="derive[@type eq 'conclusion']" mode="krextor:main">
	<call-template name="krextor:create-omdoc-resource">
	    <!-- FIXME documentUnit, mathematicalBlock -->
	    <with-param name="related-via-properties" select="'&oo;hasConclusion' , if ($use-document-ontology) then '&sdoc;hasPart' else ''" tunnel="yes"/>
	    <with-param name="type" select="'&oo;DerivedConclusion'"/>
	</call-template>
    </template>

    <template match="derive[@type eq 'gap']" mode="krextor:main">
	<call-template name="krextor:create-omdoc-resource">
	    <!-- FIXME documentUnit, mathematicalBlock -->
	    <with-param name="related-via-properties" select="'&oo;hasStep' , if ($use-document-ontology) then '&sdoc;hasPart' else ''" tunnel="yes"/>
	    <with-param name="type" select="'&oo;Gap'"/>
	</call-template>
    </template>

    <template match="derive[not(@type eq 'conclusion') and not(@type eq 'gap')]" mode="krextor:main">
	<call-template name="krextor:create-omdoc-resource">
	    <!-- FIXME documentUnit, mathematicalBlock -->
	    <with-param name="related-via-properties" select="'&oo;hasStep' , if ($use-document-ontology) then '&sdoc;hasPart' else ''" tunnel="yes"/>
	    <with-param name="type" select="'&oo;DerivationStep'"/>
	</call-template>
    </template> 

    <template match="hypothesis" mode="krextor:main">
	<call-template name="krextor:create-omdoc-resource">
	    <!-- FIXME documentUnit, mathematicalBlock -->
	    <with-param name="related-via-properties" select="'&oo;hasStep' , if ($use-document-ontology) then '&sdoc;hasPart' else ''" tunnel="yes"/>
	    <with-param name="type" select="'&oo;Hypothesis'"/>
	</call-template>
    </template>

</stylesheet>
