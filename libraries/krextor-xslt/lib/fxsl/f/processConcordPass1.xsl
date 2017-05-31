<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output indent="yes"/>
	<xsl:template match="/">
		<concordance>
			<xsl:for-each-group select="/*/*/@str" group-by=".">
				<w t="{current-grouping-key()}">
				  <xsl:for-each select="current-group()">
				    <xsl:sequence select=
				    "concat(../@b,'+',../@c,'+',../@v, 
				            if(position()ne last()) then ',' else () 
				            )"/>
				  </xsl:for-each>
				</w>
			</xsl:for-each-group>
		</concordance>
	</xsl:template>
</xsl:stylesheet>