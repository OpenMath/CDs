<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:f="http://fxsl.sf.net/"
xmlns:add-tree="add-tree" 
exclude-result-prefixes="f add-tree"
>
    <xsl:import href="foldl-tree.xsl"/>

    <add-tree:add-tree/>
    
    <xsl:output method="text"/>
    
    <xsl:template match="/">
      <xsl:variable name="vAdd" select="document('')/*/add-tree:*[1]"/>
      
      <xsl:call-template name="foldl-tree">
	    <xsl:with-param name="pFuncNode" select="$vAdd"/>
	    <xsl:with-param name="pFuncSubtrees" select="$vAdd"/>
	    <xsl:with-param name="pA0" select="0"/>
	    <xsl:with-param name="pNode" select="/*"/>
      </xsl:call-template>
    </xsl:template>

    <xsl:template match="*[namespace-uri()='add-tree']" mode="f:FXSL">
      <xsl:param name="arg1"/>
      <xsl:param name="arg2"/>
      
      <xsl:value-of select="$arg1 + $arg2"/>
    </xsl:template>

</xsl:stylesheet>