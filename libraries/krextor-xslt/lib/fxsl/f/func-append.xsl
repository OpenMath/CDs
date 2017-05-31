<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:f="http://fxsl.sf.net/"
xmlns:append-foldr-func="append-foldr-func"
exclude-result-prefixes="f xs append-foldr-func"
>
   <xsl:import href="func-foldr.xsl"/>

   <append-foldr-func:append-foldr-func/>

    <f:append/>
    
    <xsl:function name="f:append" as="node()">
      <xsl:sequence select="document('')/*/f:append[1]"/>
    </xsl:function>
    
    <xsl:template match="f:append" mode="f:FXSL">
      <xsl:param name="arg1" as="item()*"/>
      <xsl:param name="arg2" as="item()*"/>
      
        <xsl:sequence select="f:append($arg1, $arg2)"/>
    </xsl:template>

    <xsl:function name="f:append" as="item()*">
      <xsl:param name="pList1" as="item()*"/>
      <xsl:param name="pList2" as="item()*"/>

      <xsl:variable name="vFoldrFun" select="document('')/*/append-foldr-func:*[1]"/>

      <xsl:sequence select="f:foldr($vFoldrFun, $pList2, $pList1)"/>
    </xsl:function>

    <xsl:template name="appendL" match="*[namespace-uri() = 'append-foldr-func']"
     mode="f:FXSL">
         <xsl:param name="arg1"/>
         <xsl:param name="arg2"/>
         
         <xsl:sequence select="$arg1, $arg2"/>
    </xsl:template>

</xsl:stylesheet>