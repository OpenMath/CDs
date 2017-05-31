<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:f="http://fxsl.sf.net/"
xmlns:tr-sum="http://fxsl.sf.net/int/tr-sum"
exclude-result-prefixes="xs f tr-sum"
>
   <xsl:import href="func-dvc-foldl.xsl"/>
   
    <xsl:variable name="vfunTrSum" 
     select="document('')/*/tr-sum:*[1]"/>
     
    <xsl:function name="f:transform-and-sum">
      <xsl:param name="pFuncTransform" as="element()"/>
      <xsl:param name="pList" as="item()*"/>
      
      <xsl:sequence select=
       "f:foldl($vfunTrSum, ($pFuncTransform, 0), $pList)[2]"
      />
    
    </xsl:function>
    
    <tr-sum:tr-sum/>
    <xsl:template match="tr-sum:*" mode="f:FXSL">
      <xsl:param name="arg1"/>
      <xsl:param name="arg2"/>
      
      <xsl:sequence select=
      "$arg1[1], $arg1[2] + xs:double(f:apply($arg1[1], $arg2))"/>
    </xsl:template>
    
</xsl:stylesheet>