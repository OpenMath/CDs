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

<!DOCTYPE xsl:stylesheet [
    <!ENTITY omo "http://www.openmath.org/ontology#">
    <!ENTITY rdfs "http://www.w3.org/2000/01/rdf-schema#">
    <!ENTITY dct "http://purl.org/dc/terms/">
    <!ENTITY xsd "http://www.w3.org/2001/XMLSchema#">
]>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xpath-default-namespace="http://www.openmath.org/OpenMathCD"
    xmlns:krextor="http://kwarc.info/projects/krextor"
    xmlns:krextor-genuri="http://kwarc.info/projects/krextor/genuri"
    xmlns="http://www.openmath.org/OpenMathCD"
    xmlns:om="http://www.openmath.org/OpenMath"
    xmlns:cds="http://www.openmath.org/OpenMathCDS"
    xmlns:cdg="http://www.openmath.org/OpenMathCDG"
    xmlns:m="http://www.w3.org/1998/Math/MathML"
    xmlns:mcd="http://www.w3.org/ns/mathml-cd"
    xmlns:xd="http://www.pnp-software.com/XSLTdoc"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xi="http://www.w3.org/2001/XInclude"
    exclude-result-prefixes="#all"
    version="2.0">

    <xd:doc type="stylesheet">
	<xd:short>Extraction module for <a href="http://www.openmath.org">OpenMath</a> content dictionaries (CDs)</xd:short>
	<xd:detail>
	    <p>This stylesheet extracts RDF from <a href="http://www.openmath.org">OpenMath</a> content dictionaries (CDs).</p>
            <p>CDs are either processed in their original form, or they are assumed to be split into fragments of interest, which are XIncluded by their parents (this corresponds to the way OpenMath CDs are used in the semantic wiki <a href="http://kwarc.info/projects/swim/">SWiM</a>).</p>
	    <p>Existing metadata vocabularies are reused, as documented in the ontology.</p>
	    <p>See <a href="https://svn.openmath.org/OpenMath3/owl">https://svn.openmath.org/OpenMath3/owl</a> for the corresponding ontology.</p>
	</xd:detail>
	<xd:author>Christoph Lange</xd:author>
	<xd:copyright>Christoph Lange, 2008</xd:copyright>
	<xd:svnId>$Id: ocd.xsl 2010 2011-07-20 15:17:57Z clange $</xd:svnId>
    </xd:doc>

    <xsl:include href="util/openmath.xsl"/>

    <xsl:strip-space elements="*"/>

    <xd:doc>
      <xd:short>Are input documents split into fragments?</xd:short>
      <xd:detail>
        <p>Do we assume that the input documents have been split into fragments of the size of knowledge items?</p>
        <p>See <a href="https://svn.salzburgresearch.at/svn/kiwi/IkeWiki/branches/SWiM/trunk/WEB-INF/src/at/srfg/ikewiki/render/import-ocd.xsl">https://svn.salzburgresearch.at/svn/kiwi/IkeWiki/branches/SWiM/trunk/WEB-INF/src/at/srfg/ikewiki/render/import-ocd.xsl</a> for an implementation of splitting CDs as required by this extraction module.</p>
      </xd:detail>
    </xd:doc>
    <xsl:param name="split-input" as="xs:boolean" select="false()"/>

    <xd:doc>
      <p>In case of split input, we assume that its document base URIs and <code>xml:id</code>s have been initialized correctly.  Otherwise we generate OpenMath-compliant URIs ourselves.</p>
    </xd:doc>
    <xsl:param name="autogenerate-fragment-uris" as="xs:string*">
      <xsl:if test="not($split-input)">
        <xsl:sequence select="'openmath'"/>
      </xsl:if>
      <xsl:sequence select="'xml-id'"/>
      <xsl:if test="$split-input">
        <xsl:sequence select="'document-root-base'"/>
      </xsl:if>
    </xsl:param>

    <xsl:param name="merge-url-pattern-match" as="xs:string" select="'\.ocd$'"/>
    <xsl:param name="merge-url-pattern-replace" as="xs:string" select="'-merge.rdf'"/>

    <xd:doc>
      Top-level implementation of OpenMath-compliant URI generation; we delegate to per-element templates.
    </xd:doc>
    <xsl:template match="krextor-genuri:openmath" as="xs:anyURI?">
      <xsl:param name="node"/>
      <xsl:param name="base-uri"/>
      <xsl:apply-templates select="$node" mode="krextor-genuri:openmath">
          <xsl:with-param name="openmath-cd-uri" select="$base-uri"/>
      </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="CD" mode="krextor-genuri:openmath" as="xs:anyURI?">
      <xsl:param name="openmath-cd-uri"/>
      <xsl:sequence select="$openmath-cd-uri"/>
    </xsl:template>

    <xsl:template match="CDDefinition" mode="krextor-genuri:openmath" as="xs:anyURI?">
      <xsl:param name="openmath-cd-uri"/>
      <xsl:sequence select="xs:anyURI(
                            concat(
                            $openmath-cd-uri,
                            '#',
                            normalize-space(Name[1])))"/>
    </xsl:template>

    <xsl:template match="Example" mode="krextor-genuri:openmath" as="xs:anyURI?">
      <xsl:param name="openmath-cd-uri"/>
      <xsl:sequence select="xs:anyURI(
			    concat($openmath-cd-uri, (: here, this is the URI of the symbol already :)
			    '.ex',
			    count(preceding-sibling::Example)))"/>
    </xsl:template>

    <xd:doc>Fail to generate an OpenMath URI for all elements for which none is specified, i.e. all elements except <code>CD</code> and <code>CDDefinition</code></xd:doc>
    <xsl:template match="*" mode="krextor-genuri:openmath" as="xs:anyURI?"/>
    
    <xd:doc>Easy XML → RDF mappings</xd:doc>
    <xsl:variable name="krextor:resources">
	<CD type="&omo;ContentDictionary"/>
	<CDDefinition type="&omo;SymbolDefinition"
	    related-via-properties="&omo;definesSymbol"/>
	<!-- OpenMath 3 transition: no specific types known yet -->
	<description type="&omo;OpenMathConcept"
	    related-via-properties="&omo;hasDirectPart"/>
	<!-- OpenMath 3 transition: no specific types known yet -->
	<discussion type="&omo;OpenMathConcept"
	    related-via-properties="&omo;hasDirectPart"/>
	<Pragmatic type="&omo;PragmaticSyntax"
	    related-via-properties="&omo;hasPragmaticSyntax"/>
	<Example type="&omo;Example"
	    related-via-properties="&omo;exemplifiedBy"/>
	<!-- OpenMath 3 transition: allow MMLexample here, too -->
	<MMLexample type="&omo;Example"
	    related-via-properties="&omo;exemplifiedBy"/>
	<cdg:CDGroup type="&omo;ContentDictionaryGroup"/>
	<cds:CDSignatures type="&omo;SignatureDictionary"/>
	<cds:Signature type="&omo;Signature"
	    related-via-properties="&omo;containsSignature"/>
	<mcd:notations type="&omo;NotationDictionary"/>
    </xsl:variable>

    <xsl:template match="(: for CD, see below; it gets special treatment :)
                         CD|
                         CDDefinition|
                         description|
                         discussion|
                         Pragmatic|
                         Example|
                         MMLexample|
                         cdg:CDGroup|
                         cds:CDSignatures|
                         cds:Signature|
                         mcd:notations"
                  mode="krextor:main">
	<xsl:apply-templates select="." mode="krextor:create-resource"/>
    </xsl:template>

    <xsl:template match="/" mode="krextor:main">
      <xsl:choose>
        <xsl:when test="not($split-input)">
          <xsl:apply-imports>
            <xsl:with-param
                name="krextor:base-uri"
                select="xs:anyURI(
                        concat(
                        normalize-space(/CD/CDBase[1]),
                        '/',
                        normalize-space(/CD/CDName[1])))"
                as="xs:anyURI"
                tunnel="yes"/>
          </xsl:apply-imports>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-imports/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:template>

    <xsl:variable name="krextor:literal-properties">
	<!-- TODO reconsider whether dct:identifier actually is the right property
	     See discussion in the OpenMath ontology source -->
	<Name property="&dct;identifier" normalize-space="true"/>
	<CDName property="&dct;identifier" normalize-space="true"/>
	<Description property="&dct;description" normalize-space="true"/>
	<Title property="&dct;title" normalize-space="true"/>
	<CDDate property="&dct;date" datatype="&xsd;date" normalize-space="true"/>
	<CDComment property="&rdfs;comment" normalize-space="true"/>
	<CDReviewDate property="&omo;reviewDate" normalize-space="true"/>
	<cds:CDSReviewDate property="&omo;reviewDate" normalize-space="true"/>
	<CDVersion property="&omo;version" normalize-space="true"/>
	<cdg:CDGroupVersion property="&omo;version" normalize-space="true"/>
	<CDRevision property="&omo;revision" normalize-space="true"/>
	<cdg:CDGroupRevision property="&omo;revision" normalize-space="true"/>
	<CDURL property="&omo;url" normalize-space="true"/>
	<cdg:CDGroupURL property="&omo;url" normalize-space="true"/>
	<!--  for now we store this as a literal, as SWiM does not yet support URI properties with external objects -->
	<CDBase property="&omo;base" normalize-space="true"/>
        <CMP property="&omo;text" normalize-space="true"/>
    </xsl:variable>

    <xsl:template match="Name|
	CDName|
	Description|
	Title|
	CDDate|
	CDComment|
	CDReviewDate|
	cds:CDSReviewDate|
	CDVersion|
	cdg:CDGroupVersion|
	CDRevision|
	cdg:CDGroupRevision|
	CDURL|
	cdg:CDGroupURL|
	(: for now we store this as a literal, as SWiM does not yet support URI
	   properties with external objects :)
	CDBase|
        CMP" mode="krextor:main">
	<xsl:apply-templates select="." mode="krextor:add-literal-property"/>
    </xsl:template>

    <!-- Special cases start here -->

    <xsl:template match="Role" mode="krextor:main">
        <xsl:call-template name="krextor:add-uri-property">
	    <xsl:with-param name="property" select="'&omo;role'"/>
	     <xsl:with-param name="object" select="concat('&omo;', krextor:dashes-to-camelcase(normalize-space(.)))"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="CDStatus|cds:CDSStatus" mode="krextor:main">
        <xsl:call-template name="krextor:add-uri-property">
	    <xsl:with-param name="property" select="'&omo;status'"/>
	     <xsl:with-param name="object" select="concat('&omo;', krextor:dashes-to-camelcase(normalize-space(.)))"/>
        </xsl:call-template>
    </xsl:template>

    <xd:doc>A property group as suggested for OpenMath 3:  <code><![CDATA[<property><CMP/><FMP/></property>]]></code></xd:doc>
    <xsl:template match="property" mode="krextor:main">
	<xsl:call-template name="krextor:create-resource">
	    <xsl:with-param name="related-via-properties" select="'&omo;hasProperty'" tunnel="yes"/>
	    <xsl:with-param name="type" select="'&omo;Property'"/>
	</xsl:call-template>
    </xsl:template>    

    <xd:doc>Groups ungrouped OpenMath-2-style properties</xd:doc>
    <xsl:template match="CDDefinition/*[self::CMP
                         or self::FMP[not(preceding-sibling::*[1][self::CMP])]]"
                  mode="krextor:main">
        <xsl:call-template name="krextor:apply-templates">
            <xsl:with-param name="node">
                <!-- create a synthetic property element -->
                <property xml:id="{normalize-space(parent::CDDefinition/Name)}.prop{count(preceding-sibling::CMP|preceding-sibling::FMP)}">
                    <!-- copy the currently matched element (CMP or FMP) -->
                    <xsl:copy-of select="."/> 
                    <!-- assume that an FMP following a CMP belongs to the same property -->
                    <xsl:if test="self::CMP">
                        <!-- if no following FMP exists, nothing is copied -->
                        <xsl:copy-of select="following-sibling::*[1][self::FMP]"/>
                    </xsl:if>
                </property>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <xd:doc>We assume that any FMP has been grouped with a CMP before</xd:doc>
    <xsl:template match="FMP" mode="krextor:main"/>
 
    <xd:doc>We assume that any FMP has been grouped with a CMP before</xd:doc>
    <xsl:template match="property/FMP" mode="krextor:main">
        <xsl:call-template name="krextor:add-literal-property">
	    <xsl:with-param name="property" select="'&omo;openMath'"/>
            <!-- here, the OMOBJ child becomes the object by default -->
        </xsl:call-template>
        <xsl:call-template name="krextor:add-literal-property">
	    <xsl:with-param name="property" select="'&omo;contentMathML'"/>
	    <xsl:with-param name="object">
              <xsl:apply-templates mode="om2cmml" select="om:OMOBJ"/>
            </xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="krextor:add-literal-property">
	    <xsl:with-param name="property" select="'&omo;popcorn'"/>
	    <xsl:with-param name="object">
              <xsl:apply-templates mode="pop" select="om:OMOBJ"/>
            </xsl:with-param>
        </xsl:call-template>
	<!-- this makes sure that omo:usesSymbol links are created correctly -->
	<xsl:apply-templates select="om:OMOBJ" mode="krextor:main"/>
    </xsl:template>    

    <xsl:template match="@type[parent::cds:CDSignatures]" mode="krextor:main">
	<!-- Currently we assume that @cd is a CD name (in fact a relative URI) to be resolved against the base URI. -->
	<xsl:call-template name="krextor:add-uri-property">
	    <xsl:with-param name="property" select="'&omo;typeSystem'"/>
	    <!-- resolve against the @cdbase if that is available.
		 We assume that @cdbase defines the base both for
		 @cd and for @type. -->
	     <xsl:with-param name="object" select="resolve-uri(., om:cdbase-or-default(../@cdbase))"/>
	</xsl:call-template>
    </xsl:template>

    <xsl:template match="@cd[parent::cds:CDSignatures]" mode="krextor:main">
	<xsl:call-template name="krextor:add-uri-property">
	    <xsl:with-param name="property" select="'&omo;containsSignaturesFor'"/>
	    <!-- resolve against the @cdbase if that is available.
	    We assume that @cdbase defines the base both for
	    @cd and for @type. -->
	    <xsl:with-param name="object" select="resolve-uri(., om:cdbase-or-default(../@cdbase))"/>
	</xsl:call-template>
    </xsl:template>

    <xsl:template match="@name[parent::cds:Signature[@cd]]" mode="krextor:main">
	<xsl:call-template name="krextor:add-uri-property">
	    <xsl:with-param name="property" select="'&omo;typesSymbol'"/>
	    <!-- In SWiM, a Signature element is assumed to carry @cdbase and @cd attributes, cf. the discussion of 2008/05/10 on the OM3 mailing list -->
	    <xsl:with-param name="object" select="om:symbol-uri((ancestor::*/@cdbase)[last()], ../@cd, .)"/>
	</xsl:call-template>
    </xsl:template>

    <xsl:template match="mcd:notation" mode="krextor:main">
	<xsl:if test="parent::mcd:notations and not(preceding-sibling::mcd:notation)">
	    <xsl:apply-templates select="." mode="krextor:link-notation-to-cd"/>
	</xsl:if>

	<xsl:call-template name="krextor:create-resource">
	    <xsl:with-param name="related-via-properties" select="'&omo;containsNotationDefinition'" tunnel="yes"/>
	    <xsl:with-param name="type" select="'&omo;Notation'"/>
	</xsl:call-template>
    </xsl:template>

    <xsl:template match="mcd:notation" mode="krextor:link-notation-to-cd">
	<!--
	Here we assume that the mcd:notations element itself does not point to
	a cdbase or a cd, that its mcd:notation children don't do it either,
	but that the prototypes do it (implicitly), and that, of course, there
	is a prototype.

	We assume that all prototypes in one notation dictionary point to to
	the same cdbase and cd, therefore we look up these targets from the
	first child.
	-->
	<xsl:variable name="symbol" select="om:matched-symbol(mcd:prototype[1])"/>
	<xsl:call-template name="krextor:add-uri-property">
	    <!-- implicit subject is the notation dictionary -->
	    <xsl:with-param name="property" select="'&omo;containsNotationsFor'"/>
	    <!-- resolve against the @cdbase if that is available -->
	    <xsl:with-param name="object" select="resolve-uri($symbol/@cd, om:cdbase-or-default($symbol/@cdbase))"/>
	</xsl:call-template>
    </xsl:template>

    <xsl:template match="mcd:prototype[not(preceding-sibling::mcd:prototype)]" mode="krextor:main">
	<xsl:variable name="symbol" select="om:matched-symbol(.)"/>
	<xsl:call-template name="krextor:add-uri-property">
	    <!-- the enclosing mcd:notation is the subject -->
	    <xsl:with-param name="property" select="'&omo;rendersSymbol'"/>
	    <xsl:with-param name="object" select="om:symbol-uri(om:cdbase-or-default($symbol/@cdbase), $symbol/@cd, $symbol/@name)"/>
	</xsl:call-template>
    </xsl:template>

    <!-- CDUses is not extracted but computed -->

    <!-- TODO for containment within the same file, either consider @xml:id or target of @href -->
	
    <xsl:template match="CDDefinition" mode="krextor:included">
	<xsl:call-template name="krextor:add-uri-property">
	    <xsl:with-param name="property" select="'&omo;containsSymbolDefinition'"/>
	</xsl:call-template>
    </xsl:template>

    <xsl:template match="description" mode="krextor:included">
	<xsl:call-template name="krextor:add-uri-property">
	    <!-- OpenMath 3 transition: no specific type known yet -->
	    <xsl:with-param name="property" select="'&omo;hasDirectPart'"/>
	</xsl:call-template>
    </xsl:template>

    <xsl:template match="discussion" mode="krextor:included">
	<xsl:call-template name="krextor:add-uri-property">
	    <!-- OpenMath 3 transition: no specific type known yet -->
	    <xsl:with-param name="property" select="'&omo;hasDirectPart'"/>
	</xsl:call-template>
    </xsl:template>

    <xsl:template match="property" mode="krextor:included">
	<xsl:call-template name="krextor:add-uri-property">
	    <xsl:with-param name="property" select="'&omo;hasProperty'"/>
	</xsl:call-template>
    </xsl:template>

    <xsl:template match="Pragmatic" mode="krextor:included">
	<xsl:call-template name="krextor:add-uri-property">
	    <xsl:with-param name="property" select="'&omo;hasPragmaticSyntax'"/>
	</xsl:call-template>
    </xsl:template>

    <!-- OpenMath 3 transition: allow MMLexample here, too -->
    <xsl:template match="MMLexample|Example" mode="krextor:included">
	<xsl:call-template name="krextor:add-uri-property">
	    <xsl:with-param name="property" select="'&omo;exemplifiedBy'"/>
	</xsl:call-template>
    </xsl:template>

    <xsl:template match="om:OMOBJ//om:OMS" mode="krextor:main">
	<xsl:call-template name="krextor:add-uri-property">
	    <xsl:with-param name="property" select="'&omo;usesSymbol'"/>
	    <!-- use the innermost cdbase attribute. At least the OMOBJ must have a cdbase attribute,
	         or otherwise the default is assumed -->
	    <xsl:with-param name="object" select="om:symbol-uri((ancestor-or-self::om:*/@cdbase)[last()], @cd, @name)"/>
	</xsl:call-template>
    </xsl:template>
	
    <xsl:template match="cdg:CDGroupMember" mode="krextor:main">
	<xsl:call-template name="krextor:add-uri-property">
	    <xsl:with-param name="property" select="'&omo;containsContentDictionary'"/>
	    <!-- We ignore the CDVersion for now -->
	    <!-- If the CDURL is given, use it. Otherwise, resolve CDName against the CDGroupURL, as specified in section 4.4.2.2 of the OpenMath 2.0 Specification. -->
	    <xsl:with-param name="object" select="if (cdg:CDURL) then cdg:CDURL/text() else resolve-uri(cdg:CDName/text(), ../cdg:CDGroupURL)"/>
	</xsl:call-template>
    </xsl:template>

    <xsl:template match="cds:Signature" mode="krextor:included">
	<xsl:call-template name="krextor:add-uri-property">
	    <xsl:with-param name="property" select="'&omo;containsSignature'"/>
	</xsl:call-template>
    </xsl:template>


    <xsl:template match="mcd:notation" mode="krextor:included">
	<xsl:param name="krextor:parent-element" tunnel="yes"/>

	<!--
	Here, we assume that mcd:notations cannot have children other than
	mcd:notation (which is the case in MathML 3).
	-->
	<xsl:if test="not($krextor:parent-element/preceding-sibling::mcd:notation|
	    $krextor:parent-element/preceding-sibling::xi:include)">
	    <xsl:apply-templates select="." mode="krextor:link-notation-to-cd"/>
	</xsl:if>

	<xsl:call-template name="krextor:add-uri-property">
	    <xsl:with-param name="property" select="'&omo;containsNotationDefinition'"/>
	</xsl:call-template>
    </xsl:template>

    <!-- TODO:
    Classes:
    CDBase
    -->
</xsl:stylesheet>
