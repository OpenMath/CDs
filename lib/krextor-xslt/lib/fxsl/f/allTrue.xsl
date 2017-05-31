<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:f="http://fxsl.sf.net/"
xmlns:allTrue-And="f allTrue-And"
>
  <xsl:import href="foldr.xsl"/>
  
  <allTrue-And:allTrue-And/>
  
  <xsl:template name="allTrue">
    <xsl:param name="pList" select="/.."/>
    
    <xsl:variable name="vAnd" select="document('')/*/allTrue-And:*[1]"/>
  
    <xsl:call-template name="foldr">
      <xsl:with-param name="pFunc" select="$vAnd"/>
      <xsl:with-param name="pA0" select="1"/>
      <xsl:with-param name="pList" select="$pList"/>
      
    </xsl:call-template>
  </xsl:template>
  
  <xsl:template name="And" match="*[namespace-uri()='allTrue-And']"
   mode="f:FXSL">
    <xsl:param name="arg1"/>
    <xsl:param name="arg2"/>
    
    <xsl:if test="$arg1/node() and string($arg2)">1</xsl:if>
  </xsl:template>
</xsl:stylesheet>