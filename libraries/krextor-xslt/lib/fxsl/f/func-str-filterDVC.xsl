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
    
    <xsl:variable name="vLen" select="string-length($pStr)"/>

    <xsl:sequence select=
     "for $vLen in string-length($pStr) return
       (if($vLen = 1)
          then
            for $vHolds in f:apply($pController, $pStr) return
              if($vHolds = 1)
                then $pStr
                else ()
          else
            if($vLen > 1)
              then
                for $vHalf in floor($vLen div 2) return
                  concat(f:str-filter(substring($pStr, 1, $vHalf), 
                                                 $pController
                                      ),
                         f:str-filter(substring($pStr, $vHalf + 1), 
                                                 $pController
                                      )
                         )
              else ()
        )
     "
    />

  </xsl:function>

</xsl:stylesheet>