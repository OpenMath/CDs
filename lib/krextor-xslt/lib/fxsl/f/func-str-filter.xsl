<xsl:stylesheet version="2.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f xs"
>
  <xsl:import href="func-apply.xsl"/>
  
  <xsl:function name="f:str-filter">
    <xsl:param name="pStr" as="xs:string"/>
    <xsl:param name="pController" as="element()"/>
    
    <xsl:sequence select=
     "if(string-length($pStr) = 0)
        then ()
        else
          (for $vthisChar in substring($pStr, 1, 1) return
            concat((if(f:apply($pController, $vthisChar) = 1)
                     then $vthisChar
                     else ()
                    )
                    ,
                    f:str-filter(substring($pStr, 2), $pController)
                  )                                                             
          )"
    />
  </xsl:function>    
</xsl:stylesheet>