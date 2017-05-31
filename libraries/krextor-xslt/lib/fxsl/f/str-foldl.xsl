<xsl:stylesheet version="2.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f"
>
    <xsl:template name="str-foldl">
      <xsl:param name="pFunc" select="/.."/>
      <xsl:param name="pA0"/>
      <xsl:param name="pStr"/>

      <xsl:choose>
         <xsl:when test="not(string($pStr))">
            <xsl:copy-of select="$pA0"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:variable name="vFunResult">
              <xsl:apply-templates select="$pFunc[1]" mode="f:FXSL">
                <xsl:with-param name="arg0" select="$pFunc[position() > 1]"/>
                <xsl:with-param name="arg1" select="$pA0"/>
                <xsl:with-param name="arg2" select="substring($pStr,1,1)"/>
              </xsl:apply-templates>
            </xsl:variable>

            <xsl:call-template name="str-foldl">
      				<xsl:with-param name="pFunc" select="$pFunc"/>
      				<xsl:with-param name="pStr" 
                   select="substring($pStr,2)"/>
      				<xsl:with-param name="pA0" select="$vFunResult"/>
            </xsl:call-template>
         </xsl:otherwise>
      </xsl:choose>

    </xsl:template>
</xsl:stylesheet>