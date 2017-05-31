<xsl:stylesheet version="2.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 xmlns:myTrimDropController="f:myTrimDropController" 
 xmlns:myTrim1="f:myTrim1" 
 xmlns:myReverse="f:myReverse" 
 exclude-result-prefixes="f xsl myTrimDropController myTrim1 myReverse"
>
  <xsl:import href="func-str-dropWhile.xsl"/>
  <xsl:import href="func-compose-flist.xsl"/>
  <xsl:import href="func-str-reverse.xsl"/>
  
  <myTrimDropController:myTrimDropController/>
  
  <xsl:function name="f:trim">
    <xsl:param name="pStr" as="xs:string"/>
    
    <xsl:variable name="vFunctions" as="element()*">
      <myReverse:myReverse/>
      <myTrim1:myTrim1/>
      <myReverse:myReverse/>
      <myTrim1:myTrim1/>
    </xsl:variable>

    <xsl:value-of select="f:compose-flist($vFunctions, $pStr)"/>
  </xsl:function>
  
  <xsl:template name="trim1" match="myTrim1:*" mode="f:FXSL">
    <xsl:param name="arg1"/>
    
  <xsl:variable name="vTab" select="'&#9;'"/>
  <xsl:variable name="vNL" select="'&#10;'"/>
  <xsl:variable name="vCR" select="'&#13;'"/>
  <xsl:variable name="vWhitespace" 
                select="concat(' ', $vTab, $vNL, $vCR)"/>

    <xsl:variable name="vFunController" 
                  select="document('')/*/myTrimDropController:*[1]"/>
           
    
    <xsl:value-of select="f:str-dropWhile($arg1, $vFunController, $vWhitespace)"/>
  </xsl:template>
  
  <xsl:template match="myTrimDropController:*" mode="f:FXSL">
    <xsl:param name="arg1"/>
    <xsl:param name="arg2"/>
    
    <xsl:value-of select="number(contains($arg2, $arg1))"/>
  </xsl:template>
  
  <xsl:template name="myReverse" match="myReverse:*" mode="f:FXSL">
    <xsl:param name="arg1"/>
    <xsl:value-of select="f:str-reverse($arg1)"/>
</xsl:template>
</xsl:stylesheet>