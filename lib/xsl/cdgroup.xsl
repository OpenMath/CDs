<xsl:stylesheet 
  version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:om="http://www.openmath.org/OpenMath"
  xmlns:cd="http://www.openmath.org/OpenMathCDG"
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="om cd">


<xsl:output method="xhtml" indent="yes" omit-xml-declaration="yes"/>


<xsl:template match="cd:CDGroup">
 <xsl:value-of disable-output-escaping="yes" select="'&lt;!DOCTYPE html&gt;'"/>
 <xsl:text>&#10;</xsl:text>
  <html>
    <head>
  <link rel="stylesheet" href="https://openmath.github.io/public/css/hyde.css"/>
  <link rel="stylesheet" href="https://openmath.github.io/public/css/main.css"/>
  <link rel="shortcut icon" sizes="144x144" type="image/png" href="/public/favicon.png"/>
  <title><xsl:value-of select="cd:CDGroupName"/></title>
    </head>
      <body class="theme-base-odk">
    <div class="sidebar">
  <div class="container">
    <div class="sidebar-about">
      <h1>
        <a href="/">
            <img src="https://openmath.github.io/public/logo.png" alt="OpenMath" width="100%"/>
        </a>
      </h1>
      <p class="lead">OpenMath is an extensible standard for representing the semantics of mathematical objects.</p>
      <p class="site-url lead"><a href="http://openmath.github.io/">http://openmath.github.io</a></p>
    </div>

<nav class="sidebar-nav">
<a class="sidebar-nav-item"
   href="https://openmath.github.io/">Home</a> ,
<a class="sidebar-nav-item"
   href="https://openmath.github.io//about/">OpenMath</a>
<br/>
<a class="sidebar-nav-item"
   href="https://openmath.github.io//society/">OM Society</a> , 
<a class="sidebar-nav-item"
   href="https://openmath.github.io//meetings/">Meetings</a>
<br/>
<a class="sidebar-nav-item"
   href="https://openmath.github.io//standard/">Standards</a> ,
<a class="sidebar-nav-item"
   href="https://openmath.github.io//documents/">Documents</a> , 
<a class="sidebar-nav-item"
   href="https://openmath.github.io//cd/">CDs</a>
<br/>
<a class="sidebar-nav-item"
   href="https://openmath.github.io/development/">Development</a> , 
<a class="sidebar-nav-item"
   href="https://openmath.github.io/projects/">Projects</a> , 
<a class="sidebar-nav-item"
   href="https://openmath.github.io/software/">Software &amp; Tools</a>
<br/>
<a class="sidebar-nav-item"
   href="https://openmath.github.io/news/">News</a> ,
<a class="sidebar-nav-item"
   href="https://openmath.github.io/follow/">Follow &amp; Contact us</a>
&#160;&#160;
      <span class="sidebar-nav-item">
        <a href="https://openmath.github.io/atom.xml"><img class="icon" src="https://openmath.github.io/public/feed_w.png" alt="atom feed"/></a>
        <a href="https://twitter.com/openmath"><img class="icon" src="https://openmath.github.io/public/twitter_w.png" alt="twitter"/></a>
        <a href="https://github.com/OpenMath"><img class="icon" src="https://openmath.github.io/public/github_w.png" alt="github"/></a>
      </span><br/>

      
  </nav>
  </div>
</div>


    <div class="content container">
      <div class="page">

      <h1>OpenMath CD Group:
      <a href="{normalize-space(cd:CDGroupName)}.cdg"><xsl:value-of select="cd:CDGroupName"/></a>
      </h1>
      <b>Version: </b><xsl:value-of select="cd:CDGroupVersion"/>
      <hr/>
      <xsl:value-of select="cd:CDGroupDescription"/>
      <hr/>
      <table>
      <xsl:apply-templates/>
      </table>
      </div>
    </div>
      </body>
  </html>
</xsl:template>

<xsl:template match="cd:CDComment"/>
<xsl:template match="cd:CDGroupURL|cd:CDGroupName"/>
<xsl:template match="cd:CDGroupDescription"/>
<xsl:template match="cd:CDGroupVersion"/>
<xsl:template match="cd:CDGroupRevision"/>
<xsl:template match="cd:CDGroupMember">
 <tr>
  <td>
    <a>
     <xsl:attribute name="href">../cd/<xsl:value-of 
     select="normalize-space(cd:CDName)"/>.html</xsl:attribute>
      <xsl:value-of 
	  select="normalize-space(cd:CDName)"/>
    </a>
  </td>
  <td>
   <xsl:value-of select="normalize-space(preceding-sibling::*[1][self::cd:CDComment])"/>
  </td>
 </tr>
</xsl:template>

<xsl:template match="cd:CDURL|cd:CDName"/>

</xsl:stylesheet>

