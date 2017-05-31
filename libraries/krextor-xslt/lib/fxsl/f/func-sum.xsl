<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:f="http://fxsl.sf.net/"
xmlns:sum-fold-func="sum-fold-func"
exclude-result-prefixes="f xs sum-fold-func"
>
   <xsl:import href="func-foldl.xsl"/>

    <xsl:function name="f:sum">
      <xsl:param name="pList"/>

      <xsl:variable name="sum-fold-func" 
                    select="document('')/*/sum-fold-func:*[1]"/>
      
      <xsl:sequence select="f:foldl($sum-fold-func, 0, $pList)"/>
    </xsl:function>

    <sum-fold-func:sum-fold-func/>
    <xsl:template name="add" match="sum-fold-func:*"
     mode="f:FXSL">
         <xsl:param name="arg1" select="0"/>
         <xsl:param name="arg2" select="0"/>
         
         <xsl:value-of select="$arg1 + $arg2"/>
    </xsl:template>


</xsl:stylesheet>