<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:msxsl="urn:schemas-microsoft-com:xslt"
xmlns:roundLog2="roundLog2"
>
  <xsl:template name="roundLog2">
    <xsl:param name="pX"/>
    <xsl:value-of select="roundLog2:roundLog2(string($pX))"/>
  </xsl:template>
  
 
  <msxsl:script language="JScript" implements-prefix="roundLog2">
     function roundLog2(x)
     {
        return Math.round(Math.log(x)/Math.LN2);
     }
  </msxsl:script>
</xsl:stylesheet>
