<xsl:stylesheet 
  version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:om="http://www.openmath.org/OpenMath"
  xmlns:cd="http://www.openmath.org/OpenMathCD"
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:m="http://www.w3.org/1998/Math/MathML"
  exclude-result-prefixes="m cd om"
>


<!-- <xsl:import href="verb.xsl"/> already imported by om2popcorn.xsl-->
<xsl:import href="om2pmml.xsl"/>
<xsl:import href="om2popcorn.xsl"/>
<xsl:import href="om2cmml.xsl"/>

<xsl:param name="xsldir" select="'../xsl'"/>

<xsl:output method="xml"
	    omit-xml-declaration="yes"
	    encoding="US-ASCII"/>

<xsl:strip-space elements="cd:Name"/>


<xsl:template match="/">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="cd:CD">
  <xsl:variable name="cd" select="normalize-space(./cd:CDName)"/>
  <!--
      <xsl:processing-instruction name="xml-stylesheet"
      > type="text/xsl"  href="<xsl:value-of select="$xsldir"/>/pmathml.xsl"</xsl:processing-instruction>
  -->
<xsl:value-of disable-output-escaping="yes" select="'&lt;!DOCTYPE html&gt;'"/>
<xsl:text>&#10;</xsl:text>
<html>
 <head>
  <link rel="stylesheet" href="https://openmath.org/public/css/hyde.css"/>
  <link rel="stylesheet" href="https://openmath.org/public/css/main.css"/>
  <link rel="shortcut icon" sizes="144x144" type="image/png" href="/public/favicon.png"/>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.0/MathJax.js?config=TeX-AMS-MML_SVG"><xsl:text> </xsl:text></script>

    <script type="text/javascript"> function divfold(_Id){
     var thisLevel = document.getElementById(_Id);
     var thisLevela = document.getElementById(_Id.concat("a"))
     if(thisLevel.style.display != "none"){ 
      thisLevel.style.display = "none";
      thisLevela.style.backgroundColor = "#CCCCCC";} 
     else{
      thisLevel.style.display = "block";
      thisLevela.style.backgroundColor = "#AAFFAA";}  
       }
     </script>
     <title><xsl:value-of select="$cd"/>
     </title>    
     <link rel = "stylesheet"
	   href = "https://openmath.org/cd/omcd.css"
	   type = "text/css" ></link>
     
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
      <p class="site-url lead"><a href="https://openmath.org/">https://openmath.org</a></p>
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

    <a name="top"/>
    <h1>OpenMath Content Dictionary: <xsl:value-of select="$cd"/></h1>
    


    <dl>
      <dt><span class="dt">Canonical URL:</span></dt>
      <dd><a href="{normalize-space(./cd:CDURL)}">
	<xsl:value-of select="normalize-space(./cd:CDURL)"/>
      </a></dd>
      
      <xsl:if test="cd:CDBase">
	<dt><span class="dt">CD Base:</span></dt>
	<dd><a href="{normalize-space(./cd:CDBase)}">
	  <xsl:value-of select="normalize-space(./cd:CDBase)"/>
	</a></dd>
      </xsl:if>
      
      <dt><span class="dt">CD File:</span></dt> 
      <dd><a href="{$cd}.ocd">
	<xsl:value-of select="$cd"/>.ocd
      </a></dd>
      
      <dt><span class="dt">CD as XML Encoded OpenMath:</span></dt>  
      <dd><a href="{$cd}.omcd">
	<xsl:value-of select="$cd"/>.omcd
      </a>
      </dd>
      
      <dt><span class="dt">Defines:</span></dt>
      <dd><xsl:for-each select="cd:CDDefinition/cd:Name">
	<xsl:sort select="."/>
	<xsl:if test="position()>1">, </xsl:if>
	<xsl:variable name="n" select="normalize-space(.)"/>
	<a href="#{$n}"><xsl:value-of select="$n"/></a>
      </xsl:for-each>
  </dd>
  
  <dt><span class="dt">Date:</span></dt><dd> <xsl:value-of select="cd:CDDate"/></dd>
  <dt><span class="dt">Version:</span></dt><dd><xsl:value-of select="cd:CDVersion"/> 
  <xsl:if test="0 != number(cd:CDRevision)">
    (Revision <xsl:value-of select="normalize-space(cd:CDRevision)"/>)
  </xsl:if> </dd>
  <dt><span class="dt">Review Date:</span></dt><dd> <xsl:value-of select="cd:CDReviewDate"/></dd>
  <dt><span class="dt">Status:</span></dt><dd><xsl:value-of select="cd:CDStatus"/></dd>
  <xsl:if test="not(normalize-space(cd:CDUses)='')">
    <dt><span class="dt">Uses CD:</span></dt><dd>
    <xsl:for-each select="cd:CDUses/cd:CDName">
      <xsl:variable name="p">
      <xsl:if test="not(doc-available(resolve-uri(concat(.,'.ocd'),base-uri(/))))">../../../cd/</xsl:if>
      </xsl:variable>
      <xsl:variable name="n" select="normalize-space(.)"/>
      <a href="{$p}{$n}.html"><xsl:value-of select="$n"/></a>
      <xsl:if test="position() &lt; last()">, </xsl:if>
    </xsl:for-each></dd>
    </xsl:if></dl>
    <hr/>
    <xsl:apply-templates/>
      </div>
    </div>
      </body>
  </html>
</xsl:template>

<xsl:template match="cd:CDComment">
  <pre>
    <xsl:apply-templates/>
  </pre>
</xsl:template>

<xsl:template match="cd:CDComment/text()" name="url">
  <xsl:param name="t" select="."/>
  <xsl:analyze-string select="$t" regex="https?://[a-zA-Z:/_\-%0-9\.]+[a-zA-Z:/_\-%0-9]">
    <xsl:matching-substring>
      <a href="{.}"><xsl:value-of select="."/></a>
    </xsl:matching-substring>
    <xsl:non-matching-substring>
      <xsl:value-of select="."/>
    </xsl:non-matching-substring>
  </xsl:analyze-string>
</xsl:template>

<xsl:template match="cd:CDDefinition/cd:Description">
  <dl>
    <dt><span class="dt">Description:</span></dt>
    <dd>
      <xsl:call-template name="grab-para">
	<xsl:with-param name="string" select="."/>
      </xsl:call-template>
  </dd></dl>
</xsl:template>


<xsl:template match="cd:Description">
  <xsl:call-template name="grab-para">
    <xsl:with-param name="string" select="."/>
  </xsl:call-template>
</xsl:template>



<xsl:template match="cd:CDURL|cd:CDBase|cd:CDName|cd:CDDate|cd:CDReviewDate|cd:CDStatus|
		     cd:CDVersion|cd:CDRevision|cd:CDUses">
</xsl:template>



<xsl:template match="cd:CDDefinition">
  <hr/>
  <xsl:apply-templates/>
  <dl>
    <dt><span class="dt">Signatures:</span></dt>
    <dd>
      <xsl:element name="a">
	<xsl:attribute name="href">../../sts/<xsl:value-of 
	select="normalize-space((/cd:CD/cd:CDName)[1])"/>.html#<xsl:value-of
	select="normalize-space(cd:Name[1])"/></xsl:attribute>
	sts
      </xsl:element>
      <!-- not many ecc files so far -->
      <!--   <xsl:variable name="nm" select="normalize-space(/cd:CD/cd:CDName)"/>
	   <xsl:if test="$nm='logic1' or 
	   $nm='logic2' or 
	   $nm='quant1' or
	   $nm='setoid' or 
	   $nm='relation1' or 
	   $nm='relation0'">       
	   <xsl:element name="a">
	   <xsl:attribute name="href">../ecc/<xsl:value-of 
	   select="$nm"/>.html#<xsl:value-of
	   select="normalize-space(cd:Name)"/></xsl:attribute>
	   ,ecc
	   </xsl:element>
	   </xsl:if> -->
    </dd>
  </dl>
  <p/>
  <hr/>

  <table width="100%">
    <tr>
      <td align="right"><font size="-1">
	<xsl:variable name="n"
		      select="normalize-space(following-sibling::cd:CDDefinition[1]/cd:Name[1])"/>
	<xsl:choose>
	  <xsl:when test="''=$n">
	    <xsl:variable name="n2"
			  select="normalize-space(../cd:CDDefinition[1]/cd:Name)"/>
	    [First: <a href="#{$n2}"><xsl:value-of select="$n2"/></a>]
	  </xsl:when>
	  <xsl:otherwise>
	    [Next: <a href="#{$n}"><xsl:value-of select="$n"/></a>]
	  </xsl:otherwise>
	</xsl:choose>
	<xsl:variable name="p"
		      select="normalize-space(preceding-sibling::cd:CDDefinition[1]/cd:Name)"/>
	<xsl:choose>
	  <xsl:when test="''=$p">
	    <xsl:variable name="p2"
			  select="normalize-space(../cd:CDDefinition[last()]/cd:Name[1])"/>
	    [Last: <a href="#{$p2}"><xsl:value-of select="$p2"/></a>]
	  </xsl:when>
	  <xsl:otherwise>
	    [Previous: <a href="#{$p}"><xsl:value-of select="$p"/></a>]
	  </xsl:otherwise>
	</xsl:choose>
      [<a href="#top">Top</a>]</font></td>
    </tr>
  </table>
</xsl:template>


<xsl:template match="cd:CDDefinition/cd:Name">
  <h2><a name="{normalize-space(.)}"><xsl:apply-templates/></a></h2>
</xsl:template>


<xsl:template match="cd:CDDefinition/cd:Role">
  <dl>
    <dt><span class="dt">Role:</span></dt>
    <dd>
      <xsl:apply-templates/>
  </dd></dl>
</xsl:template>


<xsl:template match="cd:CDDefinition/cd:CMP">
  <dl>
    <dt><span class="dt">Commented Mathematical property (CMP):</span></dt>
    <dd>
      <xsl:apply-templates/>
  </dd></dl>
</xsl:template>


<xsl:template match="cd:CDDefinition/cd:FMP">
  <dl>
    <dt><span class="dt">Formal Mathematical property (FMP):</span></dt>
    <dd><xsl:apply-templates/>
  </dd></dl>
</xsl:template>


<xsl:template match="cd:CDDefinition/cd:Example">
  <dl>
    <dt><span class="dt">Example:</span></dt>
    <dd><xsl:apply-templates/>
  </dd></dl>
</xsl:template>

<xsl:template match="om:OMOBJ">


  <div>
    <button id="{om:id(.)}xmla" style="width:20em; background-color:#CCCCCC" onclick="divfold('{om:id(.)}xml')">OpenMath XML (source)</button>
    <pre id="{om:id(.)}xml" style="display:none">
      <xsl:copy-of select="preceding-sibling::node()[1][self::text()][not(normalize-space(.))]"/>
      <xsl:apply-templates mode="verb" select="."/>
    </pre>
  </div>

  <div>
    <button id="{om:id(.)}cmmla" style="width:20em; background-color:#CCCCCC" onclick="divfold('{om:id(.)}cmml')">Strict Content MathML</button>
    <pre id="{om:id(.)}cmml" style="display:none; margin-top: 0.5em">
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
  </div>

  <button id="{om:id(.)}prefa" style="width:20em; background-color:#CCCCCC" onclick="divfold('{om:id(.)}pref')">Prefix</button>
  <div id="{om:id(.)}pref" style="display:none; margin-top: 0.5em">
    <xsl:apply-templates mode="term" select="."/>
  </div>

  <div>
    <button id="{om:id(.)}popa" style="width:20em; background-color:#CCCCCC" onclick="divfold('{om:id(.)}pop')">Popcorn</button>
    <div id="{om:id(.)}pop" style="display:none; margin-top: 0.5em">
      <xsl:apply-templates mode="pop" select="."/>
    </div>
  </div>

  <div>
    <button id="{om:id(.)}mmla" style="width:20em; background-color:#AAFFAA" onclick="divfold('{om:id(.)}mml')">Rendered Presentation MathML</button>
    <div id="{om:id(.)}mml" style="display:block; margin-top: 0.5em">
     <div style="overflow:auto;font-size:90%">
      <math   xmlns="http://www.w3.org/1998/Math/MathML" display="block">
	<xsl:apply-templates/>
      </math>
     </div>
    </div>
  </div>


</xsl:template>


<!-- verb mode -->



<!--   term mode -->

<xsl:template mode="term" match="om:OMOBJ|om:OMBVAR">
  <xsl:apply-templates mode="term"/>
</xsl:template>


<xsl:template mode="term" match="om:OMSTR">
  <tt> "<xsl:apply-templates mode="term"/>" </tt>
</xsl:template>

<xsl:template mode="term" match="om:OMA">
  <xsl:apply-templates mode="term" select="./*[position()=1]"/>
  (<xsl:for-each  select="./*[position()>1]">
  <xsl:apply-templates mode="term" select="."/>
  <xsl:if test="position()&lt;last()">
    <xsl:text>, </xsl:text>
  </xsl:if>
  </xsl:for-each>)
</xsl:template>

<xsl:template mode="term" match="om:OMBIND">
  <xsl:apply-templates mode="term" select="./*[position()=1]"/>
  [<xsl:apply-templates mode="term" select="./*[position()=2]"/>] .
  (<xsl:apply-templates mode="term" select="./*[position()>2]"/>)
</xsl:template>


<xsl:template mode="term" match="om:OMV">
  <xsl:text> </xsl:text>
  <i><xsl:value-of select="@name"/></i>
</xsl:template>


<xsl:template mode="term" match="om:OMF">
  <xsl:text> </xsl:text>
  <xsl:value-of select="@*"/><xsl:text> </xsl:text>
</xsl:template>




<xsl:template mode="term" match="om:OMS">
  <xsl:variable name="p">
    <xsl:if test="not(doc-available(resolve-uri(concat(.,'.ocd'),base-uri(/))))">../../../cd/</xsl:if>
  </xsl:variable>
  <a href="{$p}{@cd}.html#{@name}"><xsl:value-of select="@name"/></a>
</xsl:template>

<xsl:template mode="term" match="om:OMATP">
  <xsl:apply-templates mode="term" />
</xsl:template>


<xsl:template mode="term" match="om:OMATTR">
  <b>Attrib</b>([<xsl:apply-templates mode="term" select="./*[position()=1]"/>],
  <xsl:apply-templates mode="term" select="./*[position()>1]"/>)
</xsl:template>

<xsl:template mode="term" match="om:OME">
  <b>Error</b>(<xsl:apply-templates mode="term" select="./*[position()=1]"/>,
  <xsl:apply-templates mode="term" select="./*[position()>1]"/>)
</xsl:template>

<!--   term mode -->


<xsl:template name="grab-para">
  <xsl:param name="string"/>
  <xsl:choose>
    <xsl:when test="contains($string, '&#10;&#10;')">
      <p>
	<xsl:call-template name="url">
	<xsl:with-param name="t" select="substring-before($string,'&#10;&#10;')"/>
	</xsl:call-template>
      </p>
      <xsl:call-template name="grab-para">
	<xsl:with-param name="string" select="substring-after($string,'&#10;&#10;')"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <p>
	<xsl:call-template name="url">
	<xsl:with-param name="t" select="$string"/>
	</xsl:call-template>
      </p>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>






<xsl:template match="*" mode="cleanc">
  <xsl:copy>
    <xsl:copy-of select="@*"/>
    <xsl:apply-templates mode="cleanc"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="text()" mode="cleanc" priority="20">
  <xsl:value-of select="normalize-space(.)"/>
</xsl:template>

<xsl:template match="m:cs/text()" mode="cleanc" priority="30">
  <xsl:value-of select="."/>
</xsl:template>



<xsl:template match="*" mode="pindent">
  <xsl:text>&#10;</xsl:text>
  <xsl:for-each select="ancestor::*"><xsl:text> </xsl:text></xsl:for-each>
  <xsl:copy>
    <xsl:copy-of select="@*"/>
    <xsl:choose>
      <xsl:when test="not((descendant::*/(.,@*))[6]) or text()[normalize-space()]">
	<xsl:copy-of select="*|text()[normalize-space()]"/>
      </xsl:when>
      <xsl:otherwise>
	<xsl:apply-templates mode="pindent"/>
	<xsl:text>&#10;</xsl:text>
	<xsl:for-each select="ancestor::*"><xsl:text> </xsl:text></xsl:for-each>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:copy>
</xsl:template>


<xsl:template match="m:csymbol[parent::m:apply or parent::m:bind][not(preceding-sibling::*)]" mode="pindent">
  <xsl:copy-of select="."/>
</xsl:template>


<xsl:function name="om:id">
 <xsl:param name="n"/>
 <xsl:sequence select="concat('id.om.',count($n/preceding::*))"/>
</xsl:function>

</xsl:stylesheet>
