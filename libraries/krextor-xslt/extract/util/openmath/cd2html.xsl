<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
  version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:om="http://www.openmath.org/OpenMath"
  xmlns:m="http://www.w3.org/1998/Math/MathML"
  xmlns:cd="http://www.openmath.org/OpenMathCD"
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="#all">

<!-- Modes and templates used by this XSLT. -->
<xsl:import href="cd2html-util.xsl"/>
<!-- Render OpenMath to Presentation MathML -->
<xsl:import href="om2pmml.xsl"/>
<!-- Render OpenMath to Popcorn -->
<xsl:import href="om2popcorn.xsl"/>
<!-- Render OpenMath to Content MathML -->
<xsl:import href="om2cmml.xsl"/>
<!-- Render XML source of math object -->
<xsl:import href="verb.xsl"/>

<xsl:param  name="omnavigation" select="true()"/>

<!-- This file only implements templates for the CD root element and for
     mathematical objects.  Anything else is imported -->

<xsl:output method="xml" encoding="UTF-8"/>

<xsl:strip-space elements="cd:Name"/>

<xsl:template match="/">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template name="navigation">
  <xsl:if test="$omnavigation">
    <hr/>
    <table width="100%" border="0" cellspacing="0" cellpadding="5" title="Site Navigation Links" summary="Site Navigation Links">
      <tr bgcolor="#FFCC33">
	<b>
	  <td align="center"><a href="/index.html">Home</a></td> 
	  <td align="center"><a href="/overview/index.html">Overview</a></td> 
	  <td align="center"><a href="/documents/index.html">Documents</a></td> 
	  <td align="center"><a href="/cd/index.html">Content Dictionaries</a></td> 
	  <td align="center"><a href="/software/index.html">Software &amp; Tools</a></td> 
	  <td align="center"><a href="/society/index.html">The OpenMath Society</a></td> 
	  <td align="center"><a href="/projects/index.html">OpenMath Projects</a></td> 
	  <td align="center"><a href="/lists/index.html">OpenMath Discussion Lists</a></td> 
	  <td align="center"><a href="/meetings/index.html">OpenMath Meetings</a></td> 
	  <td align="center"><a href="/links.html">Links</a></td> 
	</b>
      </tr>
    </table>
    <hr/>
  </xsl:if>
</xsl:template>

<xsl:template match="cd:CD">
  <xsl:variable name="cd" select="normalize-space(./cd:CDName)"/>
  <xsl:text>&#10;</xsl:text>
  <xsl:processing-instruction name="xml-stylesheet">type="text/xsl" href="../../xsl/pmathml.xsl"</xsl:processing-instruction>
  <xsl:text>&#10;</xsl:text>
  <html>
    <head>

      <!-- this JavaScript is now located in ../lib/js.  You have to put a copy into 
           the same directory as the XHTML output of this XSLT. -->
      <script type="text/javascript" src="divfold.js"/>
      <title><xsl:value-of select="$cd"/>
      </title>    
      <!-- this stylesheet is now located in ../lib/css.  You have to put a copy into 
           the same directory as the XHTML output of this XSLT. -->
      <link rel = "stylesheet"
            href = "omcd.css"
            type = "text/css" ></link>

    </head>
    <body>
      <xsl:call-template name="navigation"/>
      <a name="top" id="top"/>
      <xsl:call-template name="wiki-link">
        <xsl:with-param name="title" select="$cd"/>
      </xsl:call-template>
      <h1>OpenMath Content Dictionary: <xsl:value-of select="$cd"/></h1>



      <dl>
        <xsl:apply-templates select="cd:CDURL"/>
        <xsl:apply-templates select="cd:CDBase"/>

        <xsl:call-template name="field">
          <xsl:with-param name="key">CD File</xsl:with-param>
          <xsl:with-param name="value" select="concat($cd, '.ocd')"/>
          <xsl:with-param name="normalize-space" select="false()" tunnel="yes"/>
          <xsl:with-param name="link" select="true()" tunnel="yes"/>
        </xsl:call-template>

        <xsl:call-template name="field">
          <xsl:with-param name="key">CD as XML Encoded OpenMath</xsl:with-param>
          <xsl:with-param name="value" select="concat($cd, '.omcd')"/>
          <xsl:with-param name="normalize-space" select="false()" tunnel="yes"/>
          <xsl:with-param name="link" select="true()" tunnel="yes"/>
        </xsl:call-template>

        <xsl:call-template name="field">
          <xsl:with-param name="key">Defines</xsl:with-param>
          <xsl:with-param name="value"><xsl:for-each select="cd:CDDefinition/cd:Name">
            <xsl:sort select="."/>
            <xsl:if test="position()>1">, </xsl:if>
            <xsl:variable name="n" select="normalize-space(.)"/>
            <a href="#{$n}"><xsl:value-of select="$n"/></a>
          </xsl:for-each>
          </xsl:with-param>
        </xsl:call-template>

        <xsl:apply-templates select="cd:CDDate"/>
        <xsl:apply-templates select="cd:CDVersion"/>
        <xsl:apply-templates select="cd:CDReviewDate"/>
        <xsl:apply-templates select="cd:CDStatus"/>

        <xsl:if test="normalize-space(cd:CDUses) ne ''">
          <xsl:call-template name="field">
            <xsl:with-param name="key">Uses CD</xsl:with-param>
            <xsl:with-param name="value">
              <xsl:for-each select="cd:CDUses/cd:CDName">
                <xsl:variable name="p"><xsl:text/>
                  <xsl:if test="not(om:test-file-exists(concat(., '.ocd'), .))">../../../cd/</xsl:if>
                </xsl:variable>
                <xsl:variable name="n" select="normalize-space(.)"/>
                <a href="{$p}{$n}.xhtml"><xsl:value-of select="$n"/></a>
                <xsl:if test="position() &lt; last()">, </xsl:if>
              </xsl:for-each>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </dl>
      <hr/>
      <!-- we have already dealt with these -->
      <xsl:apply-templates select="* except (cd:CDName|cd:CDURL|cd:CDBase|cd:CDDate|cd:CDVersion|cd:CDRevision|cd:CDReviewDate|cd:CDStatus|cd:CDUses)"/>
    </body>
  </html>
</xsl:template>

<xsl:template match="cd:CDVersion">
    <xsl:call-template name="cd-version-and-revision"/>
</xsl:template>

<xsl:template match="cd:CDDefinition">
  <div class="cddefinition">
  <xsl:call-template name="wiki-link">
    <xsl:with-param name="title" select="concat(normalize-space(/cd:CD/cd:CDName), '%2B', normalize-space(cd:Name))"/>
  </xsl:call-template>
  <xsl:apply-templates select="cd:Name"/>
  <dl>
    <xsl:apply-templates select="* except cd:Name"/>
    <xsl:call-template name="field">
        <xsl:with-param name="key">Signatures</xsl:with-param>
        <xsl:with-param name="value">
      <xsl:element name="a">
    <xsl:attribute name="href">../sts/<xsl:value-of 
    select="normalize-space((/cd:CD/cd:CDName)[1])"/>.xhtml#<xsl:value-of
    select="normalize-space(cd:Name[1])"/></xsl:attribute>
    sts
      </xsl:element>
        </xsl:with-param>
    </xsl:call-template>
  </dl>
  </div>

 <div>
	<xsl:variable name="n" select="normalize-space(following-sibling::cd:CDDefinition[1]/cd:Name[1])"/>
	<xsl:choose>
	  <xsl:when test="''=$n">
	    <xsl:variable name="n2" select="normalize-space(../cd:CDDefinition[1]/cd:Name)"/>
	    [First: <a href="#{$n2}"><xsl:value-of select="$n2"/></a>]
	  </xsl:when>
	  <xsl:otherwise>[Next: <a href="#{$n}"><xsl:value-of select="$n"/></a>]</xsl:otherwise>
	</xsl:choose>
	   [This: <a href="#{normalize-space(cd:Name)}"><xsl:value-of select="normalize-space(cd:Name)"/></a>]
	<xsl:variable name="p" select="normalize-space(preceding-sibling::cd:CDDefinition[1]/cd:Name)"/>
	<xsl:choose>
	  <xsl:when test="''=$p">
	    <xsl:variable name="p2" select="normalize-space(../cd:CDDefinition[last()]/cd:Name)"/>
	    [Last: <a href="#{$p2}"><xsl:value-of select="$p2"/></a>]
	  </xsl:when>
	  <xsl:otherwise>[Previous: <a href="#{$p}"><xsl:value-of select="$p"/></a>]</xsl:otherwise>
	</xsl:choose>
      [<a href="#top">Top</a>]
 </div>

</xsl:template>


<!--
	some syntax sanity checks (cd2html-util.xsl doesn't do them, it allows
	e.g. an example to occur everywhere, as that is needed for the document splitting employed by the OpenMath wiki)
-->
<xsl:template match="cd:CD/cd:Description|cd:CD/cd:discussion">
    <xsl:apply-imports/>
</xsl:template>
<xsl:template match="cd:CDDefinition/cd:Description|cd:CDDefinition/cd:description|cd:CDDefinition/cd:discussion|cd:CDDefinition/cd:Title">
    <xsl:apply-imports/>
</xsl:template>
<xsl:template match="cd:MMLexample/cd:description">
    <xsl:apply-imports/>
</xsl:template>
<xsl:template match="cd:Pragmatic/cd:description">
    <xsl:apply-imports/>
</xsl:template>
<xsl:template match="cd:property/cd:description">
    <xsl:apply-imports/>
</xsl:template>
<xsl:template match="cd:Description|cd:description|cd:discussion|cd:Title"/>

<xsl:template match="cd:CDDefinition/cd:Pragmatic">
    <xsl:apply-imports/>
</xsl:template>
<xsl:template match="cd:Pragmatic"/>

<xsl:template match="cd:CDDefinition/cd:MMLexample|cd:CDDefinition/cd:Example">
    <xsl:apply-imports/>
</xsl:template>
<xsl:template match="cd:MMLexample|cd:Example"/>

<xsl:template match="cd:property/cd:CMP|cd:property/cd:FMP">
    <xsl:apply-imports/>
</xsl:template>
<xsl:template match="cd:CDDefinition/cd:CMP|cd:CDDefinition/cd:FMP">
    <!-- abolish this template as soon as properties are universally used -->
    <xsl:apply-imports/>
</xsl:template>
<xsl:template match="cd:CMP|cd:FMP"/>

<!-- enforce them to be children of /cd:CD?
<xsl:template match="cd:CDURL|cd:CDBase|cd:CDName|cd:CDDate|cd:CDReviewDate|cd:CDStatus|
                     cd:CDVersion|cd:CDRevision|cd:CDUses"/>
-->    

<!-- Math Objects -->
<xsl:template match="om:OMOBJ">
  <!-- OpenMath XML (source) -->
  <xsl:call-template name="formula-button">
    <xsl:with-param name="id" select="concat(generate-id(), 'xml')"/>
    <xsl:with-param name="label">OpenMath XML (source)</xsl:with-param>
  </xsl:call-template>
  <pre id="{generate-id()}xml" style="display:none">
    <xsl:copy-of select="preceding-sibling::node()[1][self::text()][not(normalize-space(.))]"/>
    <xsl:apply-templates mode="verb" select="."/>
  </pre>
  <!-- Strict Content MathML -->
  <xsl:call-template name="formula-button">
    <xsl:with-param name="id" select="concat(generate-id(), 'cmml')"/>
    <xsl:with-param name="label">Content MathML</xsl:with-param>
  </xsl:call-template>
  <pre id="{generate-id()}cmml" style="display:none; margin-top: 0.5em">
    <xsl:variable name="c">
      <xsl:apply-templates  mode="om2cmml" select="."/>
    </xsl:variable>
    <xsl:variable name="c-s">
      <xsl:apply-templates  mode="cleanc" select="$c"/>
    </xsl:variable>
    <xsl:variable name="i-s-cmml">
      <xsl:apply-templates  mode="pindent" select="$c-s"/>
    </xsl:variable>	
    <xsl:apply-templates mode="verb" select="$i-s-cmml"/>
  </pre>
  <!-- Prefix -->
  <xsl:call-template name="formula-button">
    <xsl:with-param name="id" select="concat(generate-id(), 'pref')"/>
    <xsl:with-param name="label">Prefix form</xsl:with-param>
  </xsl:call-template>
  <div id="{generate-id()}pref" style="display:none; margin-top: 0.5em">
    <xsl:apply-templates mode="term" select="."/>
  </div>
  <!-- Popcorn -->
  <xsl:call-template name="formula-button">
    <xsl:with-param name="id" select="concat(generate-id(), 'pop')"/>
    <xsl:with-param name="label">Popcorn</xsl:with-param>
  </xsl:call-template>
  <div id="{generate-id()}pop" style="display:none; margin-top: 0.5em">
    <xsl:apply-templates mode="pop" select="."/>
  </div>
  <!-- Rendered Presentation MathML -->
  <xsl:call-template name="formula-button">
    <xsl:with-param name="id" select="concat(generate-id(), 'mml')"/>
    <xsl:with-param name="label">Rendered Presentation MathML</xsl:with-param>
    <xsl:with-param name="active" select="true()"/>
  </xsl:call-template>
  <div id="{generate-id()}mml" style="display:block; margin-top: 0.5em">
    <m:math   xmlns:m="http://www.w3.org/1998/Math/MathML" display="block">
      <xsl:apply-templates/>
    </m:math>
  </div>
</xsl:template>

<xsl:template match="m:math[not(parent::cd:p)]">
  <xsl:variable name="o">
    <xsl:apply-templates mode="cmml2om" select="."/>
  </xsl:variable>
  <xsl:variable name="c">
    <xsl:apply-templates  mode="om2cmml" select="$o"/>
  </xsl:variable>
  <xsl:variable name="strict" select="deep-equal($c/m:math,.)"/>
  <xsl:call-template name="formula-button">
    <xsl:with-param name="id" select="concat(generate-id(), 'xml')"/>
    <xsl:with-param name="label">XML (<xsl:if test="$strict">Strict </xsl:if>MathML)</xsl:with-param>
  </xsl:call-template>
  <pre id="{generate-id()}xml" style="display:none">
    <xsl:apply-templates mode="verb" select="."/>
  </pre>
  <xsl:if test="not($strict)">
    <xsl:call-template name="formula-button">
      <xsl:with-param name="id" select="concat(generate-id(), 'strict')"/>
      <xsl:with-param name="label">Strict Content MathML</xsl:with-param>
    </xsl:call-template>
    <pre id="{generate-id()}strict" style="display:none; margin-top: 0.5em">
      <xsl:apply-templates mode="verb" select="$c"/>
    </pre>  
  </xsl:if>
  <xsl:call-template name="formula-button">
    <xsl:with-param name="id" select="concat(generate-id(), 'cmml')"/>
    <xsl:with-param name="label">OpenMath</xsl:with-param>
  </xsl:call-template>
  <pre id="{generate-id()}cmml" style="display:none; margin-top: 0.5em">
    <xsl:apply-templates mode="verb" select="$o"/>
  </pre>
  <xsl:call-template name="formula-button">
    <xsl:with-param name="id" select="concat(generate-id(), 'pref')"/>
    <xsl:with-param name="label">Prefix form</xsl:with-param>
  </xsl:call-template>
  <div id="{generate-id()}pref" style="display:none; margin-top: 0.5em">
    <xsl:apply-templates mode="term" select="$o"/>
  </div>
  <xsl:call-template name="formula-button">
    <xsl:with-param name="id" select="concat(generate-id(), 'mml')"/>
    <xsl:with-param name="label">Presentation MathML</xsl:with-param>
    <xsl:with-param name="active" select="true()"/>
  </xsl:call-template>
  <div id="{generate-id()}mml" style="display:block; margin-top: 0.5em">
    <m:math   xmlns:m="http://www.w3.org/1998/Math/MathML" display="block">
      <xsl:apply-templates select="$o/*/*"/>
    </m:math>
  </div>
</xsl:template>

<!-- override "field" subtemplates from cd2html-util.xsl -->
<xsl:template name="field-value">
    <xsl:param name="value" tunnel="yes"/>
    <xsl:param name="normalize-space" select="true()" tunnel="yes"/>
    <xsl:call-template name="field-value-impl">
        <xsl:with-param name="value" select="if (not(*) and $normalize-space)
            then normalize-space($value)
            else $value" tunnel="yes"/>
    </xsl:call-template>
</xsl:template>

<xsl:template name="wiki-link">
  <xsl:param name="title" required="yes"/>
  <span class="link-to-this-fragment">
    <xsl:text>[</xsl:text>
    <a href="{concat('http://wiki.openmath.org/?title=cd%3A', $title)}">
      <xsl:text>browse/edit/discuss this in the wiki</xsl:text>
    </a>
    <xsl:text>]</xsl:text>
  </span>
</xsl:template>

</xsl:stylesheet>
