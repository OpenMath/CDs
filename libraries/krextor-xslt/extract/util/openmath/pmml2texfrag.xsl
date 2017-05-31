<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:m="http://www.w3.org/1998/Math/MathML"
		exclude-result-prefixes="m">
  



<xsl:template mode="pmml2tex" match="m:math">
\[\let\par\empty 
<xsl:apply-templates mode="pmml2tex"/>
\]
</xsl:template>

<xsl:template mode="pmml2tex" match="m:mrow">
<xsl:text>{</xsl:text>
<xsl:apply-templates mode="pmml2tex"/>
<xsl:text>}</xsl:text>
</xsl:template>

<xsl:template mode="pmml2tex" match="m:mrow[m:mo=$stretchy]">
<xsl:text>{\left.</xsl:text>
<xsl:apply-templates mode="pmml2tex"/>
<xsl:text>\right.}</xsl:text>
</xsl:template>


<xsl:template mode="pmml2tex" match="m:none">
<xsl:text>\empty </xsl:text>
</xsl:template>

<xsl:template mode="pmml2tex" match="m:mglyph[@src]" priority="2">
  <xsl:text>\includeraphics{</xsl:text>
  <xsl:value-of select="@src"/>
  <xsl:text>}</xsl:text>
</xsl:template>

<xsl:template mode="pmml2tex" match="m:glyph" priority="1">
  <xsl:text>\mathrm{</xsl:text>
  <xsl:value-of select="replace(@alt,' ','~')"/>
  <xsl:text>}</xsl:text>
</xsl:template>

<xsl:template mode="pmml2tex" match="m:mfenced">
<xsl:text>{\left</xsl:text>
<xsl:choose>
  <xsl:when test="not(@open)">(</xsl:when>
  <xsl:when test="normalize-space(@open)=''">.</xsl:when>
  <xsl:otherwise>
    <xsl:value-of select="replace(@open,'[{}]','\\$0')"/>
  </xsl:otherwise>
</xsl:choose>
<xsl:variable name="s" select="for $s in string-to-codepoints((@separators,',')[1]) return codepoints-to-string($s)"/>
<xsl:for-each select="*">
  <xsl:apply-templates mode="pmml2tex" select="."/>
    <xsl:variable name="p" select="position()"/>
  <xsl:if test="position()!=last()">
    <xsl:if test="($s[$p],$s[last()])[1]=$stretchy">\middle </xsl:if>
    <xsl:value-of select="replace(($s[$p],$s[last()])[1],'[{}]','\\$0')"/>
  </xsl:if>
</xsl:for-each>
<xsl:text>\right</xsl:text>
<xsl:choose>
  <xsl:when test="not(@close)">)</xsl:when>
  <xsl:when test="normalize-space(@close)=''">.</xsl:when>
  <xsl:otherwise>
    <xsl:value-of select="replace(@close,'[{}]','\\$0')"/>
  </xsl:otherwise>
</xsl:choose>
<xsl:text>}</xsl:text>
</xsl:template>

<xsl:variable name="stretchy" select="'(',')','{','}','|'"/>

<xsl:template mode="pmml2tex" match="m:msqrt">
<xsl:text>\sqrt{</xsl:text>
<xsl:apply-templates mode="pmml2tex"/>
<xsl:text>}</xsl:text>
</xsl:template>

<xsl:template mode="pmml2tex" match="m:mphantom">
<xsl:text>\phantom{</xsl:text>
<xsl:apply-templates mode="pmml2tex"/>
<xsl:text>}</xsl:text>
</xsl:template>

<xsl:template mode="pmml2tex" match="m:mspace[@width]">
<xsl:text>{\hspace{</xsl:text>
 <xsl:value-of select="replace(@width,'px','pt')"/>
<xsl:text>}}</xsl:text>
</xsl:template>

<xsl:template mode="pmml2tex" match="m:maction">
<xsl:apply-templates mode="pmml2tex" select="*[1]"/>
</xsl:template>


<xsl:template mode="pmml2tex" match="m:menclose">
<xsl:message>
<menclose>
<xsl:copy-of select="@*"/>
</menclose>
</xsl:message>
<xsl:apply-templates mode="pmml2tex"/>
</xsl:template>


<xsl:template mode="pmml2tex" match="m:menclose[@notation]">
  <xsl:variable name="s" select="tokenize((@notation,'longdiv')[1],'\s+')"/>
  <xsl:text>{\menclosebox{</xsl:text>
  <xsl:if test="$s='radical'">\sqrt</xsl:if>
  <xsl:text>{</xsl:text>
  <xsl:apply-templates mode="pmml2tex"/>
  <xsl:text>}}{</xsl:text>
<xsl:for-each select="$s">
  <xsl:choose>
    <xsl:when test=".='longdiv'">
      <xsl:text>\hbox{\pdfliteral{q 0 \depth m  
   3 \hheight
   3 \hheight
   0 \height
   c
   \width \height
   l
   S Q}}</xsl:text>
    </xsl:when>
    <xsl:when test=".='actuarial'">
      <xsl:text>\hbox{\pdfliteral{q 0 \height m  
   \width \height
   l
   \width 0
   l
   S Q}}</xsl:text>
    </xsl:when>
    <xsl:when test=".='left'">
      <xsl:text>\hbox{\pdfliteral{q 0 \depth m 0 \height l S Q}}</xsl:text>
    </xsl:when>
    <xsl:when test=".='right'">
      <xsl:text>\hbox{\pdfliteral{q \width \depth m \width \height l S Q}}</xsl:text>
    </xsl:when>
    <xsl:when test=".='top'">
      <xsl:text>\hbox{\pdfliteral{q 0 \height m \width \height l S Q}}</xsl:text>
    </xsl:when>
    <xsl:when test=".='bottom'">
      <xsl:text>\hbox{\pdfliteral{q 0 \depth m \width\depth l S Q}}</xsl:text>
    </xsl:when>

    <xsl:when test=".='box'">
      <xsl:text>\hbox{\pdfliteral{q 0 \depth m 0 \height l </xsl:text>
      <xsl:text>\width \height l </xsl:text>
      <xsl:text>\width \depth l </xsl:text>
      <xsl:text>0 \depth l s Q}}</xsl:text>
    </xsl:when>



    <xsl:when test=".='updiagonalstrike'">
      <xsl:text>\hbox{\pdfliteral{q 0 \depth m \width\height l S Q}}</xsl:text>
    </xsl:when>
    <xsl:when test=".='downdiagonalstrike'">
      <xsl:text>\hbox{\pdfliteral{q 0 \height m \width\depth l S Q}}</xsl:text>
    </xsl:when>
    <xsl:when test=".='horizontalstrike'">
      <xsl:text>\hbox{\pdfliteral{q 0 \hheight m \width\hheight l S Q}}</xsl:text>
    </xsl:when>
    <xsl:when test=".='verticalstrike'">
      <xsl:text>\pdfliteral{q \hwidth \height m \hwidth\depth l S Q}</xsl:text>
    </xsl:when>
    <xsl:when test=".=('circle','roundedbox')">
      <xsl:text>\pdfliteral{q
     0  \hheight m
     0 \height
     0 \height
     \hwidth \height
     c 
     \width \height
     \width \height
     \width \hheight
     c
     \width \depth
     \width \depth
     \hwidth \space \depth
     c
     0 \depth  
     0 \depth  
     0 \hheight
     c
s Q}</xsl:text>
    </xsl:when>
    <xsl:when test=".='madruwb'">
\dimen0\wd0
\advance\dimen0-2pt
\dimen2\wd0
\advance\dimen2 1pt
\pdfliteral{
q \stripPT\dimen0 \space 0 m \stripPT\dimen2 \space -2 \hwidth -2   2 0 c
         \hwidth -3 \stripPT\dimen2 \space -3 \width 0 c
\stripPT\dimen0 \space \height l 
    h f
     Q}
    </xsl:when>
    <xsl:otherwise>
      <xsl:message select="'menclose: ',."/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:for-each>
  <xsl:text>}}</xsl:text>
</xsl:template>


<xsl:template mode="pmml2tex" match="m:mpadded">
<xsl:message>
<mpadded>
<xsl:copy-of select="@*"/>
</mpadded>
</xsl:message>
<xsl:apply-templates mode="pmml2tex"/>
</xsl:template>

<xsl:template mode="pmml2tex" match="m:merror">
{{\color{red}{\fbox{$<xsl:apply-templates mode="pmml2tex"/>$}}}}
</xsl:template>


<xsl:template mode="pmml2tex" match="m:mtext">
<xsl:text>{\mathrm{</xsl:text>
  <xsl:variable name="t"><xsl:apply-templates mode="pmml2tex"/></xsl:variable>
  <xsl:value-of select="replace(replace(replace($t,' ','~'),'&lt;','\\lt '),'&gt;','\\gt ')"/>
<xsl:text>}}</xsl:text>
</xsl:template>

<xsl:template mode="pmml2tex" match="m:mroot">
<xsl:text>\sqrt[{</xsl:text>
<xsl:apply-templates mode="pmml2tex" select="*[2]"/>
<xsl:text>}]{</xsl:text>
<xsl:apply-templates mode="pmml2tex" select="*[1]"/>
<xsl:text>}</xsl:text>
</xsl:template>


<xsl:template mode="pmml2tex" match="m:mfrac">
<xsl:text>{\frac{</xsl:text>
<xsl:apply-templates mode="pmml2tex" select="*[1]"/>
<xsl:text>}{</xsl:text>
<xsl:apply-templates mode="pmml2tex" select="*[2]"/>
<xsl:text>}}</xsl:text>
</xsl:template>


<xsl:template mode="pmml2tex" match="m:mfenced/m:mo[not(@*) and normalize-space(.)=$stretchy]" priority="2">
  <xsl:text>\middle</xsl:text>
  <xsl:value-of select="replace(.,'[{}]','\\$0')"/>
</xsl:template>

<xsl:template mode="pmml2tex" match="m:mrow/m:mo[not(@*) and normalize-space(.)=$stretchy]" priority="3">
  <xsl:text>\middle</xsl:text>
  <xsl:value-of select="replace(.,'[{}]','\\$0')"/>
</xsl:template>

<xsl:template mode="pmml2tex" match="m:mo[not(@*) and string-length(normalize-space(.))=1]">
  <xsl:apply-templates mode="pmml2tex"/>
</xsl:template>

<xsl:template mode="pmml2tex" match="m:mo">
  <xsl:text>{\mo{</xsl:text>
  <xsl:apply-templates mode="pmml2tex" select="@*"/>
  <xsl:apply-templates mode="pmml2tex"/>
  <xsl:text>}}</xsl:text>
</xsl:template>

<xsl:template mode="pmml2tex" match="m:mo[string-length(normalize-space(.)) gt 1]">
  <xsl:text>{\mo{\mathrm{</xsl:text>
  <xsl:apply-templates mode="pmml2tex" select="@*"/>
  <xsl:apply-templates mode="pmml2tex"/>
  <xsl:text>}}}</xsl:text>
</xsl:template>

<xsl:template mode="pmml2tex" match="m:mo[.='{']" priority="2">\{</xsl:template>
<xsl:template mode="pmml2tex" match="m:mo[.='}']" priority="2">\}</xsl:template>
<xsl:template mode="pmml2tex" match="m:mo[.='^']" priority="2">\hat{}</xsl:template>
<xsl:template mode="pmml2tex" match="m:mo[.='_']" priority="2">\_ </xsl:template>
<xsl:template mode="pmml2tex" match="m:mo[.='\']" priority="2">\backslash </xsl:template>
<xsl:template mode="pmml2tex" match="m:mo[.='&amp;']" priority="2">\ampersand </xsl:template>
<xsl:template mode="pmml2tex" match="m:mo[.='&lt;']" priority="2">\lt </xsl:template>
<xsl:template mode="pmml2tex" match="m:mo[.='&gt;']" priority="2">\gt </xsl:template>



<!--
  <xsl:value-of select="for $n in string-to-codepoints(.)
 return concat('\mo{',$n,'}')"/>
-->

<xsl:template mode="pmml2tex" match="m:mi[not(@*) and string-length(normalize-space(.))=1]">
  <xsl:apply-templates mode="pmml2tex"/>
</xsl:template>

<xsl:template mode="pmml2tex"
	      match="m:mo[.='&#8289;'][preceding-sibling::*[1][self::m:mi]]"
	      priority="3"/>


<xsl:template mode="pmml2tex" match="m:mi">
  <xsl:if test="following-sibling::*[1]='&#8289;'">\mathop</xsl:if>
  <xsl:text>{\mi</xsl:text>
  <xsl:value-of select="replace(@mathvariant,'-','')"/>
  <xsl:if test="not(@mathvariant) and string-length(.)&gt;1">normal</xsl:if>
  <xsl:text>{</xsl:text>
  <xsl:apply-templates mode="pmml2tex" select="@* except @mathvariant"/>
  <xsl:apply-templates mode="pmml2tex"/>
  <xsl:text>}}</xsl:text>
</xsl:template>

<xsl:template mode="pmml2tex" match="m:mn">
  <xsl:text>{\mn{</xsl:text>
  <xsl:apply-templates mode="pmml2tex" select="@*"/>
  <xsl:apply-templates mode="pmml2tex"/>
  <xsl:text>}}</xsl:text>
</xsl:template>

<xsl:template mode="pmml2tex" match="m:mn[matches(.,'^[0-9]*$')]">
  <xsl:text>{</xsl:text>
  <xsl:apply-templates mode="pmml2tex" select="@*"/>
  <xsl:apply-templates mode="pmml2tex"/>
  <xsl:text>}</xsl:text>
</xsl:template>

<xsl:template mode="pmml2tex" match="*">
<xsl:message select="'tex: ',name()"/>
</xsl:template>


<xsl:template mode="pmml2tex" match="m:msup">
<xsl:text>{\msup{</xsl:text>
<xsl:apply-templates mode="pmml2tex" select="*[1]"/>
<xsl:text>}{</xsl:text>
<xsl:apply-templates mode="pmml2tex" select="*[2]"/>
<xsl:text>}}</xsl:text>
</xsl:template>

<xsl:template mode="pmml2tex" match="m:msub">
<xsl:text>{{</xsl:text>
<xsl:apply-templates mode="pmml2tex" select="*[1]"/>
<xsl:text>}\sb{</xsl:text>
<xsl:apply-templates mode="pmml2tex" select="*[2]"/>
<xsl:text>}}</xsl:text>
</xsl:template>

<xsl:template mode="pmml2tex" match="m:msubsup">
  <xsl:text>{</xsl:text>
  <xsl:text>{</xsl:text>
  <xsl:apply-templates mode="pmml2tex" select="*[1]"/>
  <xsl:text>}</xsl:text>
  <xsl:text>\sb{</xsl:text>
  <xsl:apply-templates mode="pmml2tex" select="*[2]"/>
  <xsl:text>}</xsl:text>
  <xsl:text>\sp{</xsl:text>
  <xsl:apply-templates mode="pmml2tex" select="*[3]"/>
  <xsl:text>}</xsl:text>
  <xsl:text>}</xsl:text>
</xsl:template>

<xsl:template mode="pmml2tex" match="m:mmultiscripts">
  <xsl:text>\setbox0\hbox{$</xsl:text>
  <xsl:apply-templates mode="pmml2tex" select="*[1]"/>
  <xsl:text>$}</xsl:text>
  <xsl:for-each select="m:mprescripts/following-sibling::*[position() mod 2=1]">
   <xsl:text>\vphantom{pre\copy0}</xsl:text>
   <xsl:text>\sb{</xsl:text>
   <xsl:apply-templates mode="pmml2tex" select="."/>
   <xsl:text>}\sp{</xsl:text>
   <xsl:apply-templates mode="pmml2tex" select="following-sibling::*[1]"/>
   <xsl:text>}</xsl:text>
  </xsl:for-each>
  <xsl:text>{\copy0}</xsl:text>
  <xsl:for-each select="*[position()!=1][not(self::m:mprescripts)][not(preceding-sibling::m:mprescripts)][position() mod 2=1]">
   <xsl:text>\vphantom{post\copy0}</xsl:text>
   <xsl:text>\sb{</xsl:text>
   <xsl:apply-templates mode="pmml2tex" select="."/>
   <xsl:text>}\sp{</xsl:text>
   <xsl:apply-templates mode="pmml2tex" select="following-sibling::*[1]"/>
   <xsl:text>}</xsl:text>
  </xsl:for-each>
</xsl:template>

<xsl:template mode="pmml2tex" match="m:mtable">
<xsl:text>{\begin{matrix}&#10;</xsl:text>
<xsl:apply-templates mode="pmml2tex" select="m:mtr|m:mlabeledtr">
  <xsl:with-param name="cols" select="max(*/count(m:mtd/(@colspan/number(.),1)[1]))"/>
</xsl:apply-templates>
<xsl:text>&#10;\end{matrix}}</xsl:text>
</xsl:template>

<xsl:template mode="pmml2tex" match="m:mtr">
  <xsl:if test="../@side='left' and ../m:mlabeledtr">
    <xsl:text>{\relax}\endcell </xsl:text>
  </xsl:if>
  <xsl:apply-templates mode="pmml2tex" select="m:mtd"/>
  <xsl:if test="not(../@side='left') and ../m:mlabeledtr">
    <xsl:text>\endcell {\empty} </xsl:text>
  </xsl:if>
  <xsl:if test="position()!=last()">\\&#10;</xsl:if>
</xsl:template>

<xsl:template mode="pmml2tex" match="m:mlabeledtr">
  <xsl:param name="cols"/>
  <xsl:if test="../@side='left'">
    <xsl:apply-templates mode="pmml2tex" select="m:mtd[1]"/>
  </xsl:if>
  <xsl:apply-templates mode="pmml2tex" select="m:mtd[position()!=1]"/>
  <xsl:for-each select="-2 to ($cols - count(m:mtd/(@colspan/number(.),1)[1]))">
   <xsl:text>  \endcell </xsl:text>
  </xsl:for-each>
  <xsl:if test="not(../@side='left')">
    <xsl:apply-templates mode="pmml2tex" select="m:mtd[1]"/>
  </xsl:if>
  <xsl:if test="position()!=last()">\\&#10;</xsl:if>
</xsl:template>


<xsl:template mode="pmml2tex" match="m:mtd">
  <xsl:apply-templates mode="pmml2tex"/>
  <xsl:if test="position()!=last()"> \endcell </xsl:if>
</xsl:template>


<xsl:template mode="pmml2tex" match="m:ms">
  <xsl:text>\mbox{</xsl:text>
  <xsl:apply-templates mode="pmml2tex" select="@*"/>
  <xsl:text>\textquotedbl </xsl:text>
  <xsl:variable name="t"><xsl:apply-templates mode="pmml2tex"/></xsl:variable>
  <xsl:value-of select="replace($t,'&#160;','\\unicode{160}')"/>
  <xsl:text>\textquotedbl </xsl:text>
  <xsl:text>}</xsl:text>
</xsl:template>

<xsl:template mode="pmml2tex" match="m:mover">
  <xsl:text>{</xsl:text>
  <xsl:text>\mathop{</xsl:text>
  <xsl:apply-templates mode="pmml2tex" select="*[1]"/>
  <xsl:text>}\limits</xsl:text>
  <xsl:text>\sp{</xsl:text>
  <xsl:apply-templates mode="pmml2tex" select="*[2]"/>
  <xsl:text>}</xsl:text>
  <xsl:text>}</xsl:text>
</xsl:template>


<xsl:template mode="pmml2tex" match="m:mover[*[2]='&#175;']" priority="2">
  <xsl:text>{</xsl:text>
  <xsl:text>\overline{</xsl:text>
  <xsl:apply-templates mode="pmml2tex" select="*[1]"/>
  <xsl:text>}}</xsl:text>
</xsl:template>

<xsl:template mode="pmml2tex" match="m:munder">
  <xsl:text>{</xsl:text>
  <xsl:text>\mathop{</xsl:text>
  <xsl:apply-templates mode="pmml2tex" select="*[1]"/>
  <xsl:text>}\limits</xsl:text>
  <xsl:text>\sb{</xsl:text>
  <xsl:apply-templates mode="pmml2tex" select="*[2]"/>
  <xsl:text>}</xsl:text>
  <xsl:text>}</xsl:text>
</xsl:template>


<xsl:template mode="pmml2tex" match="m:munderover">
  <xsl:text>{</xsl:text>
  <xsl:text>\mathop{</xsl:text>
  <xsl:apply-templates mode="pmml2tex" select="*[1]"/>
  <xsl:text>}\limits</xsl:text>
  <xsl:text>\sb{</xsl:text>
  <xsl:apply-templates mode="pmml2tex" select="*[2]"/>
  <xsl:text>}</xsl:text>
  <xsl:text>\sp{</xsl:text>
  <xsl:apply-templates mode="pmml2tex" select="*[3]"/>
  <xsl:text>}</xsl:text>
  <xsl:text>}</xsl:text>
</xsl:template>


<xsl:template mode="pmml2tex" match="m:mstyle">
<xsl:text>{</xsl:text>
<xsl:apply-templates mode="pmml2tex" select="@*"/>
<xsl:apply-templates mode="pmml2tex"/>
  <xsl:text>}</xsl:text>
</xsl:template>


<xsl:template mode="pmml2tex" match="@*">
<xsl:message select="'attribute: ',../name(),name(),string(.)"/>
</xsl:template>
<xsl:template mode="pmml2tex" match="@mathbackground" priority="2"/>
<xsl:template mode="pmml2tex" match="@background" priority="2"/>

<xsl:template mode="pmml2tex" match="*[@mathbackground|@background]" priority="100">
  <xsl:text>{</xsl:text>
  <xsl:for-each select="(@mathbackground,@background)[1]">
  <xsl:call-template name="color">
    <xsl:with-param name="cmd" select="'\colorbox'"/>
  </xsl:call-template>
  </xsl:for-each>
  <xsl:text>{$</xsl:text>
  <xsl:next-match/>
  <xsl:text>$}</xsl:text>
  <xsl:text>}</xsl:text>
</xsl:template>

<xsl:template mode="pmml2tex" match="@color[../@mathcolor]" priority="20"/>
<xsl:template mode="pmml2tex" match="@mathcolor|@color" name="color" priority="2">
  <xsl:param name="cmd" select="'\color'"/>
  <xsl:value-of select="$cmd"/>
  <xsl:choose>
    <xsl:when test="starts-with(.,'#') and string-length(.)=4">
      <xsl:text>[xRGB]{</xsl:text>
      <xsl:value-of select="upper-case(replace(.,'#(.)(.)(.)','$1$1,$2$2,$3$3}'))"/>
    </xsl:when>
    <xsl:when test="starts-with(.,'#') and string-length(.)=7">
      <xsl:text>[xRGB]{</xsl:text>
      <xsl:value-of select="upper-case(replace(.,'#(..)(..)(..)','$1,$2,$3}'))"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:text>{</xsl:text>
      <xsl:value-of select="lower-case(.)"/>
      <xsl:text>}</xsl:text>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template mode="pmml2tex" match="m:mstyle/@displaysize[.='true']">
  \dislaystyle
</xsl:template>


<xsl:template mode="pmml2tex" match="m:mcolumn">
 <xsl:text>&#10;\begin{array}{@{}*{25}{c@{}c@{}}}&#10;</xsl:text>
<xsl:variable name="mc">
<mc>
 <xsl:apply-templates select="*" mode="mc"/>
</mc>
</xsl:variable>
<xsl:variable name="c" select="max($mc/m:mc/m:row/count(m:cell))"/>
<xsl:message select="'mcolumn: ',$c,$mc"/>
<xsl:for-each select="$mc/m:mc/(m:row|m:mline)">
 <xsl:if test="self::m:mline">\hline&#10;</xsl:if>
 <xsl:if test="self::m:row">
<xsl:for-each select="1 to $c - count(m:cell)">
<xsl:text> \endcell </xsl:text>
</xsl:for-each>
<xsl:for-each select="m:cell">
 <xsl:value-of select="."/>
 <xsl:if test="position()!=last()"> \endcell </xsl:if>
</xsl:for-each>
<xsl:if test="position()!=last()">\\&#10;</xsl:if>
 </xsl:if>
</xsl:for-each>
 <xsl:text>&#10;\end{array}&#10;</xsl:text>
</xsl:template>

<xsl:template match="*" mode="mc">
  <row>
    <xsl:apply-templates mode="mc2"/>
  </row>
</xsl:template>


<xsl:template match="m:mline" mode="mc">
 <xsl:copy-of select="."/>
</xsl:template>

<xsl:template match="*" mode="mc2">
    <cell><xsl:apply-templates mode="pmml2tex" select="."/></cell>
</xsl:template>

<xsl:template match="m:mstyle" mode="mc2">
    <xsl:apply-templates select="*" mode="mc2"/>
</xsl:template>

<xsl:template match="m:mrow" mode="mc2">
    <xsl:apply-templates select="*" mode="mc2"/>
</xsl:template>

<xsl:template match="m:mn|m:mi|m:mo|m:mtext" mode="mc">
 <row>
    <xsl:apply-templates select="." mode="mc2"/>
 </row>
</xsl:template>

<xsl:template match="m:mn" mode="mc2">
  <xsl:for-each select="string-to-codepoints(replace(normalize-space(.),'[&#824;]',''))">
  <cell><xsl:value-of select="codepoints-to-string(.)"/>  </cell>
  </xsl:for-each>
</xsl:template>

<xsl:template match="m:mtext" mode="mc2">
  <xsl:for-each select="string-to-codepoints(normalize-space(.))">
  <cell><xsl:value-of select="codepoints-to-string(.)"/></cell>
  </xsl:for-each>
</xsl:template>

<xsl:template match="m:mi" mode="mc2">
  <xsl:for-each select="string-to-codepoints(normalize-space(.))">
  <cell>
   <xsl:value-of select="codepoints-to-string(.)"/>
  </cell>
  </xsl:for-each>
</xsl:template>

<xsl:template match="m:mspace[@spacing]" mode="mc2">
  <xsl:for-each select="string-to-codepoints(normalize-space(@spacing))">
  <cell></cell>
  </xsl:for-each>
</xsl:template>


<xsl:template match="m:mo" mode="mc2">
  <xsl:for-each select="string-to-codepoints(normalize-space(.))">
  <cell><xsl:value-of select="codepoints-to-string(.)"/></cell>
  </xsl:for-each>
</xsl:template>


</xsl:stylesheet>