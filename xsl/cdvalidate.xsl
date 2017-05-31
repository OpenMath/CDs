
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0"
		xmlns:cd="http://www.openmath.org/OpenMathCD"
		xmlns:om="http://www.openmath.org/OpenMath"
                >

<xsl:import href="omvalidate.xsl"/>

<xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>
<xsl:strip-space elements="*"/>

<xsl:param name="cdhome" 
           select="'http://openmath.org/cd/'"/>


<xsl:template match="/">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="cd:CD">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="cd:CD/cd:CDBase[not(*)]"/>
<xsl:template match="cd:CD/cd:CDURL[not(*)]"/>
<xsl:template match="cd:CD/cd:Description[not(*)]"/>
<xsl:template match="cd:CD/cd:CDComment[not(*)]"/>
<xsl:template match="cd:CDDefinition/cd:CDComment[not(*)]"/>

<xsl:template match="cd:CD/cd:CDReviewDate[not(*)]">
  <xsl:if test="translate(.,' &#10;0123456789-','')!=''">
  Bad cd:CD Review Date: (<xsl:value-of select="."/>)
 </xsl:if>
</xsl:template>

<xsl:template match="cd:CD/cd:CDDate[not(*)]">
  <xsl:if test="translate(.,' &#10;0123456789-','')!=''">
  Bad CD Date: (<xsl:value-of select="."/>)
 </xsl:if>
</xsl:template>


<xsl:template match="cd:CD/cd:CDDefinition">
  <xsl:apply-templates/>
</xsl:template>


<xsl:template match="text()">
 Bad text in <xsl:value-of select="name(..)"/>  element: 
 <xsl:value-of select="."/>
</xsl:template>


<xsl:template match="cd:CD/cd:CDName">
 <xsl:if test="translate(.,' &#10;abcdefghijklmnopqrstuvwxyz0123456789_','')!=''">
  Bad CDName: (<xsl:value-of select="."/>)
 </xsl:if>
</xsl:template>


<xsl:template match="cd:CDUses/cd:CDName">
 <xsl:variable name="x" select="normalize-space(.)"/>
 <xsl:if test="not(//om:OMS[@cd=$x])">
  Unused CD <xsl:value-of select="."/> in CDUses list.
 </xsl:if>
</xsl:template>

<xsl:template match="cd:CD/cd:CDVersion|cd:CD/cd:CDRevision">
 <xsl:if test="translate(.,' &#10;0123456789','')!=''">
  Bad CDVersion: (<xsl:value-of select="."/>)
 </xsl:if>
</xsl:template>

<xsl:template match="cd:CD/cd:CDStatus">
 <xsl:variable name="x" select="normalize-space(.)"/>
 <xsl:if test="$x != 'public' and
               $x != 'experimental' and 
               $x != 'official' and 
               $x !='private'">
   Bad status:  (<xsl:value-of select="."/>)
 </xsl:if>
</xsl:template>


<xsl:template match="cd:CD/cd:CDUses">
 <xsl:apply-templates/>
</xsl:template>


<xsl:template match="cd:CDDefinition/cd:Role[not(*)]"/>

<xsl:template match="cd:CDDefinition/cd:Name">
 <xsl:if test="translate(.,
   ' &#10;&#9;abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_',
   '')!=''">
  Bad Symbol Name: (<xsl:value-of select="."/>)
 </xsl:if>
</xsl:template>


<xsl:template match="cd:CDDefinition/cd:CMP[not(*)]">
</xsl:template>

<xsl:template match="cd:CDDefinition/cd:Description">
   <xsl:apply-templates/>
</xsl:template>

<xsl:template match="cd:CDDefinition/cd:FMP">
  <xsl:apply-templates/>
</xsl:template>
<xsl:template match="cd:CDDefinition/cd:Example">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="cd:Example/text()"/>
<xsl:template match="cd:Description/text()"/>




<xsl:template match="om:OMOBJ">
  <xsl:apply-imports/>
</xsl:template>

<xsl:key name="cduses" match="/cd:CD/cd:CDUses/cd:CDName|/cd:CD/cd:CDName" use="normalize-space(.)"/>

<xsl:template match="om:OMS">
  <xsl:if test="/cd:CD/cd:CDUses and not(key('cduses', @cd))">
   CD <xsl:value-of select="@cd"/> not listed in CDUses.
  <CDName><xsl:value-of select="@cd"/></CDName>
 </xsl:if>
 <xsl:choose>
 <xsl:when test="not(@cd and @name and count(@*)=2)">
 <OMS><xsl:copy-of select="@*"/>
  <xsl:text>
  OMS must have just cd and name attributes</xsl:text>
 </OMS>
 </xsl:when>
 <xsl:when test="count(*) != 0 or not(. = '')">
 <OMS><xsl:copy-of select="@*"/>
  <xsl:text>
  OMS must be EMPTY</xsl:text>
 </OMS>
 </xsl:when>
 <xsl:when test=
  "not(document(concat($cdhome,@cd,'.ocd'))
     /cd:CD/cd:CDDefinition[normalize-space(cd:Name) = current()/@name])">
 <OMS><xsl:copy-of select="@*"/>
  <xsl:text>
  Bad name: </xsl:text>
  <xsl:value-of select="@name"/>
 <xsl:text> not in </xsl:text>
  <xsl:value-of select="@cd"/>
 </OMS>
 </xsl:when>
 </xsl:choose>
</xsl:template>

</xsl:stylesheet>