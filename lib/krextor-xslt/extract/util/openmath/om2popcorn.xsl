
<!--

Use and distribution of this code are permitted under the terms of the <a
href="http://www.w3.org/Consortium/Legal/copyright-software-19980720"
>W3C Software Notice and License</a>.

David Carlisle July 2009

for details of popcorn format, see
http://java.symcomp.org/FormalPopcorn.html
-->

<xsl:stylesheet version="2.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:om="http://www.openmath.org/OpenMath"
		>

<xsl:import href="verb.xsl"/>
<!-- the templates for the "pop" mode -->
<xsl:import href="omobj2popcorn.xsl"/>

<xsl:output method="text"/>


<xsl:template match="/">
  <xsl:for-each select="//om:OMOBJ">
    <xsl:text>&#10;</xsl:text>
    <xsl:apply-templates mode="pop" select="."/>
    <xsl:text>&#10;</xsl:text>
  </xsl:for-each>
</xsl:template>

</xsl:stylesheet>
