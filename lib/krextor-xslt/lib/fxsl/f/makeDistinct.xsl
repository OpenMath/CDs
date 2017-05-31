<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:f="http://fxsl.sf.net/"
xmlns:mytestElem="f:mytestElem"
exclude-result-prefixes="f mytestElem"
>
    <xsl:import href="foldl.xsl"/>
    
    <xsl:output indent="yes" omit-xml-declaration="yes"/>
    <mytestElem:mytestElem/>
    <xsl:template match="/">
      <xsl:variable name="vFun-testElem"
                    select="document('')/*/mytestElem:*[1]"/>

      <xsl:call-template name="foldl">
        <xsl:with-param name="pFunc" select="$vFun-testElem"/>
        <xsl:with-param name="pA0" select="/.."/>
        <xsl:with-param name="pList"
                        select="document('testDistinct1.xml')/p/person
                              | document('testDistinct2.xml')/p/person
                              | document('testDistinct3.xml')/p/person"
      />
      </xsl:call-template>
    </xsl:template>
    
    <xsl:template match="mytestElem:*" mode="f:FXSL">
      <xsl:param name="arg1" select="/.."/>
      <xsl:param name="arg2" select="/.."/>
 
      <xsl:copy-of select="$arg1"/>
      <xsl:if test="not($arg2/@id = $arg1/@id)">
        <xsl:copy-of select="$arg2"/>
      </xsl:if>
    </xsl:template>
</xsl:stylesheet>