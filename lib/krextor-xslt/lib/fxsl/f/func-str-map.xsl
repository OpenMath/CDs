<xsl:stylesheet version="1.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f xs" 
>
   <xsl:import href="func-apply.xsl"/>
   
   <xsl:function name="f:str-map" >
    <xsl:param name="pFun" as="element()"/>
    <xsl:param name="pStr" as="xs:string"/>

    <xsl:sequence select=
      "if($pStr)
         then
         (
          f:apply($pFun, substring($pStr, 1, 1))
          ,
          f:str-map($pFun, substring($pStr, 2))
         )
         else
           ()"
    />
  </xsl:function>
</xsl:stylesheet>