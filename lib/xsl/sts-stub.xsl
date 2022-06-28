<xsl:stylesheet version="3.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:cd="http://www.openmath.org/OpenMathCD"
		>
 <xsl:output method="text"/>

 <xsl:template match="/">
<xsl:text>---&#10;</xsl:text>
<xsl:value-of select="'title: &quot;',normalize-space(*/cd:CDName),': STS Unavailable&quot;&#10;'" separator=""/>
<xsl:value-of select="'permalink: &quot;/sts/',normalize-space(*/cd:CDName),'.html&quot;&#10;'" separator=""/>
<xsl:text>---&#10;&#10;</xsl:text>

<!--<xsl:value-of select="'# ',*/cd:CDName,': STS Unavailable&#10;'" separator=""/>=-->

[<xsl:value-of select="normalize-space(*/cd:CDName)"/>](/cd/<xsl:value-of select="normalize-space(*/cd:CDName)"/>)
defines the following Names, but STS signatures are not currently available.

<xsl:for-each select="*/cd:CDDefinition">
 *  {: #<xsl:value-of select="normalize-space(cd:Name)"/> } <xsl:value-of select="normalize-space(cd:Name)"/>
</xsl:for-each>
 </xsl:template>


</xsl:stylesheet>

<!--
for i in `cat x.log`; do saxon9 ${i/.sts/.ocd}  sts-stub.xsl > ../sts/${i/.sts/.md}; done
-->
