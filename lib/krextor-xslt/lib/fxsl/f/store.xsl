<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:f="http://fxsl.sf.net/"
xmlns:getInitialStore="f:getInitialStore"
xmlns:getValue="f:getValue0"
xmlns:upd-getValue="f:upd-getValue"
xmlns:updateStore="f:updateStore"
>
  
  
  <xsl:template name="getInitialStore" match="getInitialStore:*" mode="f:FXSL">
    <store>
      <getInitialStore:getInitialStore/>
      <getValue:getValue/>
      <updateStore:updateStore/>
    </store>
  </xsl:template>
  
  <xsl:template match="getValue:*" mode="f:FXSL">
     <xsl:value-of select="0"/>
  </xsl:template>
  
  <xsl:template match="updateStore:*" mode="f:FXSL">
    <xsl:param name="pName"/>
    <xsl:param name="pValue"/>
    
    <store>
      <getInitialStore:getInitialStore/>
      <upd-getValue:getValue>
        <store><xsl:copy-of select="../*"/></store>
        <name><xsl:value-of select="$pName"/></name>
        <value><xsl:value-of select="$pValue"/></value>
      </upd-getValue:getValue> 
      <updateStore:updateStore/>
    </store>
  </xsl:template>
  
  <xsl:template match="upd-getValue:*" mode="f:FXSL">
    <xsl:param name="pName"/>
    
    <xsl:choose>
      <xsl:when test="$pName = name">
        <xsl:value-of select="value"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="store/*[local-name()='getValue']"
         mode="f:FXSL">
           <xsl:with-param name="pName" select="$pName"/>
        </xsl:apply-templates>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>