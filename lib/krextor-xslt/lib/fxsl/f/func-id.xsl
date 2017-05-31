<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:f="http://fxsl.sf.net/"
exclude-result-prefixes="f xs"
>
    <f:id/>
    
    <xsl:function name="f:id" as="node()">
      <xsl:sequence select="document('')/*/f:id[1]"/>
    </xsl:function>
    
    <xsl:template match="f:id" mode="f:FXSL">
      <xsl:param name="arg1" as="item()*"/>
      
        <xsl:sequence select="f:id($arg1)"/>
    </xsl:template>

    <xsl:function name="f:id" as="item()*">
      <xsl:param name="arg1" as="item()*"/>

      <xsl:sequence select="$arg1"/>
    </xsl:function>
</xsl:stylesheet>