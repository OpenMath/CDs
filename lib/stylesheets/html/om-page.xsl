<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE xsl:stylesheet>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.1">

<xsl:output method="html" indent="yes" encoding="utf-8"
  doctype-system="http://www.w3.org/TR/REC-html40/strict.dtd"
  doctype-public="-//W3C//DTD HTML 4.0//EN"
/>


<!-- Produce a set of links for placing at the top and bottom of each page -->
<xsl:template name="navigation">
  <hr/>
  <table width="100%" border="0" cellspacing="0" cellpadding="5" title ="Site Navigation Links" summary="Site Navigation Links">
    <tr bgcolor="#FFCC33">
     <b>
       <td align="center"><A HREF="/index.html">Home</A></td> 
       <td align="center"><A HREF="/overview/index.html">Overview</A></td> 
       <td align="center"><A HREF="/documents/index.html">Documents</A></td> 
       <td align="center"><A HREF="/cd/index.html">Content Dictionaries</A></td> 
       <td align="center"><A HREF="/software/index.html">Software &amp; Tools</A></td> 
       <td align="center"><A HREF="/society/index.html">The OpenMath Society</A></td> 
       <td align="center"><A HREF="/projects/index.html">OpenMath Projects</A></td> 
       <td align="center"><A HREF="/lists/index.html">OpenMath Discussion Lists</A></td> 
       <td align="center"><A HREF="/meetings/index.html">OpenMath Meetings</A></td> 
       <td align="center"><A HREF="/links.html">Links</A></td> 
     </b>
   </tr>
  </table>
  <hr/>
</xsl:template>

<!-- Output standard footer -->
<xsl:template name="footer">
  <p/>
  <xsl:call-template name="navigation"/>
  <br/>
  <i>
  <div align="center">© The OpenMath Society 2001–2016</div> 
  <div align="center">Maintained by
       <a href="/infrastructure/">the OpenMath Infrastructure Team</a></div> 
  </i>
</xsl:template>

<!-- Output standard header -->
<xsl:template name="header">
  <xsl:param name="title" select="'OpenMath'"/>

  <head>
  <title>
  <xsl:choose>
    <xsl:when test="string-length($title) > 0">
      <xsl:value-of select="$title"/>
    </xsl:when>
    <xsl:otherwise>
      OpenMath
    </xsl:otherwise>
  </xsl:choose>
  </title>
  <link rel="stylesheet" type="text/css" href="/openmath-site.css"/>
  <link rel="shortcut icon" type="image/png" href="/keylogo-small.png" />
  <xsl:copy-of select="/page/page-head/node()"/>
  </head>

</xsl:template>

<xsl:template match="page-head"/>

<!-- Annotation for a broken link.  -->
<xsl:template match="broken-link">
  <strong>(This link is currently broken)</strong>
</xsl:template>

<!-- Sub-headings.  -->
<xsl:template match="h2">
  <h2 style="text-align:center"><xsl:copy-of select="@*"/>
   <xsl:apply-templates/></h2>
</xsl:template>

<!-- Create a local link.  -->
<xsl:template match="link">
  <a href="{@uri}"><xsl:apply-templates/></a>
</xsl:template>

<!-- Recursive copy -->
<xsl:template match="*">
  <xsl:copy>
    <xsl:copy-of select="@*"/>
    <xsl:apply-templates/>
  </xsl:copy>
</xsl:template>

<!-- Output a page -->
<xsl:template name="main">
  <xsl:param name="title" select="'OpenMath'"/>

  <html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">

  <xsl:call-template name="header">
    <xsl:with-param name="title" select="$title" />
  </xsl:call-template>

  <body bgcolor="#FFFFFF" text="#000000" link="#0033FF" alink="#006699"
        vlink="#330066">
  <xsl:call-template name="navigation"/>
  <br/>
  <xsl:if test="string($title)">
   <div align="center"><h1><xsl:value-of select="$title"/></h1></div>
  </xsl:if>

  <xsl:apply-templates/>
  <xsl:call-template name="footer"/>
  </body>

  </html>

</xsl:template>

<!-- Begin Bibliography Stuff -->
<xsl:template match="bibliography">
  <ol>
    <xsl:for-each select="bibitem">
      <xsl:sort select="year" order="descending"/>
      <xsl:sort select="title" order="ascending"/>
      <li>
        <xsl:value-of select="author"/>
        <xsl:text>, </xsl:text>
        <xsl:choose>
          <xsl:when test="collection">
            <xsl:call-template name="bib-title"/>
            <xsl:text>.  In </xsl:text>
            <i><xsl:value-of select="collection"/></i>
            <xsl:if test="editor">
              <xsl:text>, </xsl:text>
              <xsl:value-of select="editor"/>
              <xsl:text> ed.</xsl:text>
            </xsl:if>
            <xsl:if test="volume">
              <xsl:text>, </xsl:text>
              <xsl:value-of select="volume"/>
            </xsl:if>
            <xsl:if test="pages">
              <xsl:text>, pages </xsl:text>
              <xsl:value-of select="pages"/>
            </xsl:if>
          </xsl:when>
          <xsl:otherwise>
            <i> <xsl:call-template name="bib-title"/> </i>
            <xsl:if test="description">
              <xsl:text>, </xsl:text>
              <xsl:value-of select="description"/>
            </xsl:if>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="publisher">
          <xsl:text>, </xsl:text>
          <xsl:value-of select="publisher"/>
        </xsl:if>
        <xsl:if test="year">
          <xsl:text>, </xsl:text>
          <xsl:value-of select="year"/>
        </xsl:if>
        <xsl:text>.  </xsl:text>
      </li>
    </xsl:for-each>
  </ol> 
</xsl:template>

<xsl:template name="bib-title">
  <xsl:choose>
    <xsl:when test="uri">
      <a href="{uri}">
        <xsl:value-of select="title"/>
      </a>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="title"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- End Bibliography Stuff -->

<!-- Templates to turn membership elements into a bulleted list -->
<xsl:template match="member">
  <li>
    <xsl:choose>
      <xsl:when test="@uri">
        <a href="{@uri}"><xsl:apply-templates/></a>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:if test="@location">
      <xsl:text> (</xsl:text>
      <xsl:value-of select="@location"/>
      <xsl:text>)</xsl:text>
    </xsl:if>
  </li>
</xsl:template>
<xsl:template match="membership-list">
  <xsl:if test="not(@omitheading='yes')">
    <div align="center"><H2>Members</H2></div>
  </xsl:if>
  <ul>
    <xsl:apply-templates/>
  </ul>
</xsl:template>


<xsl:template match="almnui-list">
  <xsl:if test="not(@omitheading='yes')">
    <div align="center"><H2>Alumni Members</H2></div>
  </xsl:if>
  <ul>
    <xsl:apply-templates/>
  </ul>
</xsl:template>

<!-- Templates to turn news elements into a bulleted list -->
<xsl:template match="news-item">
  <li>
    <xsl:apply-templates/>
  </li>
</xsl:template>
<xsl:template match="news">
  <div align="center"><H2>News</H2></div>
  <ul>
    <xsl:apply-templates/>
  </ul>
</xsl:template>

<!-- Don't generate text for page-title, it's used by the page template -->
<xsl:template match="page-title"/>

<!-- Top level template, checks whether there is an explicit page-title or
     not.
-->
<xsl:template match="page">
  <xsl:choose>
    <xsl:when test="/page/page-title">
      <xsl:call-template name="main">
        <xsl:with-param name="title" select="/page/page-title"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="main">
        <xsl:with-param name="title" select="'The OpenMath Home Page'"/>
      </xsl:call-template>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- Process contents of @name -->
<xsl:template match="include-file">
  <xsl:apply-templates select="document(@name)/*"/>
</xsl:template>

</xsl:stylesheet>
