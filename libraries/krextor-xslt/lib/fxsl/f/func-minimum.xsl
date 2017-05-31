<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:f="http://fxsl.sf.net/"
xmlns:minimum-pick-smaller="minimum-pick-smaller"
exclude-result-prefixes="f xs minimum-pick-smaller"
>
   <xsl:import href="func-dvc-foldl.xsl"/>

    <xsl:function name="f:minimum" as="item()">
      <xsl:param name="pList" as="item()+"/>
      <xsl:param name="pCMPFun" as="element()"/>

      <xsl:sequence select="f:foldl($pCMPFun, $pList[1], $pList)"/>
    </xsl:function>

    <xsl:function name="f:minimum" as="item()">
      <xsl:param name="pList" as="item()+"/>
      
      <xsl:variable name="vCMPFun" 
           select="document('')/*/minimum-pick-smaller:*[1]"/>

      <xsl:sequence select="f:minimum($pList, $vCMPFun)"/>
    </xsl:function>

    <minimum-pick-smaller:minimum-pick-smaller/>
    <xsl:template name="pickSmaller" match="minimum-pick-smaller:*"
     mode="f:FXSL">
       <xsl:param name="arg1"/>
       <xsl:param name="arg2"/>

      <xsl:sequence select="if($arg1 &lt; $arg2)
                              then $arg1
                              else $arg2"/>
    </xsl:template>
</xsl:stylesheet>