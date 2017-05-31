<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:f="http://fxsl.sf.net/"
exclude-result-prefixes="f xs"
>
  <xsl:import href="func-apply.xsl"/>

  <xsl:function name="f:str-takeWhile">
    <xsl:param name="pStr" as="xs:string"/>
    <xsl:param name="pController" as="element()"/>
    <xsl:param name="pContollerParam"/>

	  <xsl:if test="$pStr">
    <xsl:sequence select=
      "for $vFirstChar in substring($pStr, 1, 1) return
         if(f:apply($pController, $vFirstChar, $pContollerParam) != 1)
           then ()
           else
             concat($vFirstChar, 
                    f:str-takeWhile(substring($pStr, 2), 
                                    $pController, 
                                    $pContollerParam
                                    )
                    )"
     />
     </xsl:if>
  </xsl:function>

</xsl:stylesheet>