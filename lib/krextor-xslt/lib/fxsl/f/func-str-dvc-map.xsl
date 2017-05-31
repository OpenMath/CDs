<xsl:stylesheet version="1.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f xs" 
>
   <xsl:function name="f:str-map" as="xs:string">
    <xsl:param name="pFun" as="element()"/>
    <xsl:param name="pStr" as="xs:string"/>
    
    <xsl:if test="$pStr">
      <xsl:variable name="vLen" select="string-length($pStr)"/>
      <xsl:choose>
        <xsl:when test="$vLen = 1">
          <xsl:apply-templates select="$pFun" mode="f:FXSL">
            <xsl:with-param name="arg1" select="$pStr"/>
          </xsl:apply-templates>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="vHLen" select="floor($vLen div 2)"/>
          
          <xsl:value-of select=
          "concat(
                  f:str-map($pFun, substring($pStr, 1, $vHLen)),
                  f:str-map($pFun, substring($pStr, $vHLen + 1))
                  )"/>

        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:function>
</xsl:stylesheet>