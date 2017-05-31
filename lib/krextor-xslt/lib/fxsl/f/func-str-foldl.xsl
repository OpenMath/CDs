<xsl:stylesheet version="2.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f xs"
>
    <xsl:import href="func-apply.xsl"/>
    <xsl:function name="f:str-foldl">
      <xsl:param name="pFunc" as="element()"/>
      <xsl:param name="pA0"/>
      <xsl:param name="pStr" as="xs:string"/>

      <xsl:sequence select=
       "if(not(string($pStr)))
          then
             $pA0
          else
             f:str-foldl($pFunc, 
                         f:apply($pFunc, $pA0, substring($pStr,1,1)), 
                         substring($pStr,2)
                         )
             "/>
    </xsl:function>
</xsl:stylesheet>