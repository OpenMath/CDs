<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:f="http://fxsl.sf.net/"
xmlns:str-reverse-func="f:str-reverse-func"
exclude-result-prefixes="f xs str-reverse-func"
>

   <xsl:import href="func-dvc-str-foldl.xsl"/>

    <xsl:function name="f:str-reverse">
      <xsl:param name="pStr" as="xs:string"/>

      <xsl:variable name="vReverseFun" 
                    select="document('')/*/str-reverse-func:*[1]"/>

      <xsl:sequence select="f:str-foldl($vReverseFun, (), $pStr)"/>
    </xsl:function>

    <str-reverse-func:str-reverse-func/>
    <xsl:template match="str-reverse-func:*" mode="f:FXSL">
         <xsl:param name="arg1" select="0"/>
         <xsl:param name="arg2" select="0"/>

         <xsl:value-of select="concat($arg2,$arg1)"/>
    </xsl:template>
</xsl:stylesheet>