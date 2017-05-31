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
      "if(not($pStr))
         then
            $pA0
         else
            for $vcntList in string-length($pStr) return
               if($vcntList = 1)
                 then
                    f:apply($pFunc, $pA0, substring($pStr,1,1))
                 else
                    for $vHalfLen in floor($vcntList div 2) return
                      f:str-foldl($pFunc, 
                                  f:str-foldl($pFunc, 
                                              $pA0, 
                                              substring($pStr, 1, $vHalfLen)
                                              ),
                                  substring($pStr,$vHalfLen+1)
                                  )"
      />
<!--      
        <xsl:choose>
          <xsl:when test="not($pStr)">
            <xsl:sequence select="$pA0"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="vcntList" select="string-length($pStr)"/>
            <xsl:choose>
              <xsl:when test="$vcntList = 1">
                <xsl:sequence select=
                  "f:apply($pFunc, $pA0, substring($pStr,1,1))"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:variable name="vHalfLen" select="$vcntList idiv 2"/>
                <xsl:variable name="vHalfResult" select=
                      "f:str-foldl($pFunc, 
                                   $pA0, 
                                   substring($pStr, 1, $vHalfLen)
                                   )"
                 />
                <xsl:sequence select="
                    f:str-foldl($pFunc, 
                                $vHalfResult,
                                substring($pStr,$vHalfLen+1)
                                )"
                />                 
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
-->        
    </xsl:function>
</xsl:stylesheet>