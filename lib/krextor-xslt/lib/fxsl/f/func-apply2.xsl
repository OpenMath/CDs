<xsl:stylesheet version="2.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f"
>

  <xsl:function name="f:apply2">
   <xsl:param name="pFunc" as="element()"/>
   <xsl:param name="pArgs" as="item()*"/>
   
    <xsl:if test="count($pArgs) > 10">
      <xsl:message terminate="yes">
        [fxsl:apply]Error: More than 10 arguments specified.
      </xsl:message>
    </xsl:if>
    <xsl:apply-templates select="$pFunc" mode="f:FXSL">
      <xsl:with-param name="arg1"   select="$pArgs[1]"/>
      <xsl:with-param name="arg2"   select="$pArgs[2]"/>
      <xsl:with-param name="arg3"   select="$pArgs[3]"/>
      <xsl:with-param name="arg4"   select="$pArgs[4]"/>
      <xsl:with-param name="arg5"   select="$pArgs[5]"/>
      <xsl:with-param name="arg6"   select="$pArgs[6]"/>
      <xsl:with-param name="arg7"   select="$pArgs[7]"/>
      <xsl:with-param name="arg8"   select="$pArgs[8]"/>
      <xsl:with-param name="arg9"   select="$pArgs[9]"/>
      <xsl:with-param name="arg10" select="$pArgs[10]"/>
    </xsl:apply-templates>
  </xsl:function>

</xsl:stylesheet>
