<xsl:stylesheet version="2.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f"
>
  <xsl:import href="func-apply.xsl"/>
  
  <xsl:function name="f:compose-flist">
    <xsl:param name="pFunList" as="element()*"/>
    <xsl:param name="pArg1"/>
    
    <xsl:sequence select=
     "if(empty($pFunList))
       then $pArg1
       else
         f:apply($pFunList[1], f:compose-flist($pFunList[position() > 1], $pArg1))"
    />
  </xsl:function>
</xsl:stylesheet>