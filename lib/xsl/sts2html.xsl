<xsl:stylesheet 
  version="2.0"
  xmlns:om="http://www.openmath.org/OpenMath"
  xmlns:sts="http://www.openmath.org/OpenMathCDS"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="om sts"
  >

<!-- verb mode -->
<xsl:import href="verb.xsl"/>

<xsl:output method="xml"
	    indent="yes"
	    omit-xml-declaration="yes"
	    encoding="US-ASCII"/>


<xsl:template match="sts:CDSignatures">
 <xsl:value-of disable-output-escaping="yes" select="'&lt;!DOCTYPE html&gt;'"/>
 <xsl:text>&#10;</xsl:text>
  <html>
  <head>
  <link rel="stylesheet" href="https://openmath.org/public/css/hyde.css"/>
  <link rel="stylesheet" href="https://openmath.org/public/css/main.css"/>
  <link rel="shortcut icon" sizes="144x144" type="image/png" href="/public/favicon.png"/>
  <title><xsl:value-of select="@cd"/></title>
    <link rel="stylesheet" href="../cd/omcd.css" type="text/css"/>
  </head>
  <body class="theme-base-odk">
    <div class="sidebar">
  <div class="container">
    <div class="sidebar-about">
      <h1>
        <a href="/">
            <img src="https://openmath.org/public/logo.png" alt="OpenMath" width="100%"/>
        </a>
      </h1>
      <p class="lead">OpenMath is an extensible standard for representing the semantics of mathematical objects.</p>
      <p class="site-url lead"><a href="https://openmath.github.io/">https://openmath.github.io</a></p>
    </div>

<nav class="sidebar-nav">
<a class="sidebar-nav-item"
   href="https://openmath.org/">Home</a> ,
<a class="sidebar-nav-item"
   href="https://openmath.org/about/">OpenMath</a>
<br/>
<a class="sidebar-nav-item"
   href="https://openmath.org/society/">OM Society</a> , 
<a class="sidebar-nav-item"
   href="https://openmath.org/meetings/">Meetings</a>
<br/>
<a class="sidebar-nav-item"
   href="https://openmath.org/standard/">Standards</a> ,
<a class="sidebar-nav-item"
   href="https://openmath.org/documents/">Documents</a> , 
<a class="sidebar-nav-item"
   href="https://openmath.org/cd/">CDs</a>
<br/>
<a class="sidebar-nav-item"
   href="https://openmath.org/development/">Development</a> , 
<a class="sidebar-nav-item"
   href="https://openmath.org/projects/">Projects</a> , 
<a class="sidebar-nav-item"
   href="https://openmath.org/software/">Software &amp; Tools</a>
<br/>
<a class="sidebar-nav-item"
   href="https://openmath.org/news/">News</a> ,
<a class="sidebar-nav-item"
   href="https://openmath.org/follow/">Follow &amp; Contact us</a>
&#160;&#160;
      <span class="sidebar-nav-item">
        <a href="https://openmath.org/atom.xml"><img class="icon" src="https://openmath.org/public/feed_w.png" alt="atom feed"/></a>
        <a href="https://twitter.com/openmath"><img class="icon" src="https://openmath.org/public/twitter_w.png" alt="twitter"/></a>
        <a href="https://github.com/OpenMath"><img class="icon" src="https://openmath.org/public/github_w.png" alt="github"/></a>
      </span><br/>

      
  </nav>
  </div>
</div>


    <div class="content container">
      <div class="page">
    <h1>OpenMath Signatures</h1>
    <hr/>
    <p>
      Type System:
      <a href="../cd/{@type}.html"><xsl:value-of select="@type"/></a>
      <br/>
      Content Dictionary:
      <a href="../cd/{@cd}.html"><xsl:value-of select="@cd"/></a>
      <br/>
      CD Signature File:
      <a href="{@cd}.sts"><xsl:value-of select="@cd"/>.sts</a>
<!--
      <br/>
      CD Signature as XML Encoded OpenMath: 
      <a href="{@cd}.omsts"><xsl:value-of select="@cd"/>.omsts</a>
-->
    </p>
    <hr/>
    <xsl:apply-templates/>
      </div>
    </div>
  </body>
  </html>
</xsl:template>

<xsl:template match="sts:CDSComment">
  <pre>
  <b>
  <xsl:apply-templates/>
  </b>
  </pre>
</xsl:template>


<xsl:template match="sts:Signature">
  <hr/>
  <h2><a name="{@name}"><xsl:value-of select="@name"/></a></h2>
  <pre>
  <xsl:apply-templates mode="verb"/>
  </pre>
  <xsl:apply-templates mode="display"/>
  <p>
     <a href="../cd/{../@cd}.html#{@name}">Content Dictionary Entry.</a> 
  </p>
  <hr/>
  <table width="100%">
    <tr>
    <td align="right"><font size="-1">
    <xsl:variable name="n"
        select="normalize-space(following-sibling::Signature[1]/@name)"/>
      <xsl:choose>
        <xsl:when test="''=$n">
          <xsl:variable name="n2"
              select="normalize-space(../Signature[1]/@name)"/>
          [First:
          <a href="#{$n2}"><xsl:value-of select="$n"/></a>]
        </xsl:when>
        <xsl:otherwise>
          [Next:
          <a href="#{$n}"><xsl:value-of select="$n"/></a>]
        </xsl:otherwise>
      </xsl:choose>
    <xsl:variable name="p"
       select="normalize-space(preceding-sibling::Signature[1]/@name)"/>
      <xsl:choose>
        <xsl:when test="''=$p">
          <xsl:variable name="p2"
              select="normalize-space(../Signature[last()]/@name)"/>
          [Last:
          <a href="#{$p2}"><xsl:value-of select="$p"/></a>]
        </xsl:when>
        <xsl:otherwise>
          [Previous:
          <a href="#{$p}"><xsl:value-of select="$p"/></a>]
        </xsl:otherwise>
      </xsl:choose>
      [<a href="#top">Top</a>]
    </font>
    </td>
    </tr>
  </table>
  <hr/>
</xsl:template>





<!--  display mode    -->

<xsl:template mode="display" match="om:OMOBJ">
  <xsl:apply-templates mode="display"/>
</xsl:template>



<xsl:template mode="display" match="om:OMA[om:OMS[@name='mapsto']]">
(
<xsl:apply-templates mode="display" select="*[not(position()=last())]"/>
 >>
<xsl:apply-templates mode="display"  select="*[position()=last()]"/>
)
</xsl:template>

<xsl:template mode="display" match="om:OMA[om:OMS[@name='nassoc']]">
(
<xsl:apply-templates mode="display"  select="*[position()=last()]"/>
<sup>*assoc</sup>
)
</xsl:template>

<xsl:template mode="display" match="om:OMA[om:OMS[@name='nary']]">
(
<xsl:apply-templates mode="display"  select="*[position()=last()]"/>
<sup>*</sup>
)
</xsl:template>



<xsl:template mode="display" match="om:OMV">
  <xsl:text> </xsl:text>
  <xsl:value-of select="@name"/>
  <xsl:text> </xsl:text>
</xsl:template>



<xsl:template mode="display" match="om:OMS[not(@cd='sts')]">
  <xsl:text> </xsl:text>
  <a href="../cd/{@cd}.html#{@name}"><xsl:value-of select="@name"/></a>
  <xsl:text> </xsl:text>
</xsl:template>

<xsl:template mode="display"
      match="om:OMS[@name='attribution']|
             om:OMS[@name='binder']|
             om:OMS[@name='Object']|
             om:OMS[@name='NumericalValue']">
  <xsl:text> </xsl:text>
  <b><xsl:value-of select="@name"/></b>
  <xsl:text> </xsl:text>
</xsl:template>




</xsl:stylesheet>

