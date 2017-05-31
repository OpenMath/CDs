<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"

 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 xmlns:testmap="testmap"
exclude-result-prefixes="xs f"
>
 <xsl:import href="../f/func-curry.xsl"/>

 <!-- To be applied on text.xml -->
 <xsl:output omit-xml-declaration="yes" indent="yes"/>

  <xsl:function name="f:concat2" as="xs:string">
    <xsl:param name="pStr1" as="xs:string"/>
    <xsl:param name="pStr2" as="xs:string"/>

    <xsl:sequence select="concat($pStr1, $pStr2)"/>
  </xsl:function>

  <xsl:function name="f:concat2" as="element()">
    <xsl:param name="pStr1" as="xs:string"/>

    <xsl:sequence select="f:curry(f:concat2(),2,$pStr1)"/>
  </xsl:function>

  <xsl:function name="f:concat2" as="element()">
    <f:concat2/>
  </xsl:function>

  <xsl:template match="f:concat2" mode="f:FXSL">
    <xsl:param name="arg1" as="xs:string"/>
    <xsl:param name="arg2" as="xs:string"/>

    <xsl:sequence select="f:concat2($arg1, $arg2)"/>
  </xsl:template>

</xsl:stylesheet>
