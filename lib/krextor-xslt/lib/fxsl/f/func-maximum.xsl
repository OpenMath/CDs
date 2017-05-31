<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:f="http://fxsl.sf.net/"
xmlns:maximum-pick-bigger="f:maximum-pick-bigger"
exclude-result-prefixes="f xs maximum-pick-bigger"
>
   <xsl:import href="func-dvc-foldl.xsl"/>


    <xsl:function name="f:maximum" as="item()">
      <xsl:param name="pList" as="item()+"/>
      <xsl:param name="pCMPFun" as="element()"/>

      <xsl:sequence select="f:foldl($pCMPFun, $pList[1], $pList)"/>
    </xsl:function>

    <xsl:function name="f:maximum" as="item()">
      <xsl:param name="pList" as="item()+"/>
<!--
      <xsl:message>
        $pList: '<xsl:copy-of select="$pList"/>'
      </xsl:message>      
-->      
      <xsl:variable name="vCMPFun" as="element()">
        <maximum-pick-bigger:maximum-pick-bigger/>
      </xsl:variable> 

      <xsl:sequence select="f:maximum($pList, $vCMPFun)"/>
    </xsl:function>

    
    <xsl:template name="pickBigger" match="maximum-pick-bigger:*"
     mode="f:FXSL">
      <xsl:param name="arg1"/>
      <xsl:param name="arg2"/>

      <xsl:sequence select="if($arg1 > $arg2)
                              then $arg1
                              else $arg2"/>
    </xsl:template>
</xsl:stylesheet>