<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f xs"
 >
 
 <xsl:import href="func-curry.xsl"/>
  
 <xsl:function name="f:projection" as="item()">
   <xsl:param name="pList" as="item()*"/>
   <xsl:param name="pIndex" as="xs:integer"/>
   
   <xsl:sequence select="$pList[$pIndex]"/>
 </xsl:function>
 
  <xsl:function name="f:projection" as="element()">
    <f:projection/>
  </xsl:function>

 <xsl:function name="f:projection" as="item()">
   <xsl:param name="pList" as="item()*"/>
   
   <xsl:sequence select="f:curry(f:projection(),2, $pList)"/>
 </xsl:function>
 
 <xsl:template match="f:projection" mode="f:FXSL" as="item()">
   <xsl:param name="arg1" as="item()*"/>
   <xsl:param name="arg2" as="xs:integer"/>
 
   <xsl:sequence select="f:projection($arg1,$arg2)"/>
 </xsl:template>
 
 <xsl:function name="f:first" as="item()">
   <xsl:param name="pList" as="item()*"/>
   <xsl:sequence select="$pList[1]"/>
 </xsl:function>
 
  <xsl:function name="f:first" as="element()">
    <f:first/>
  </xsl:function>
  
  <xsl:template match="f:first" mode="f:FXSL" as="item()">
   <xsl:param name="arg1" as="item()*"/>
   
    <xsl:sequence select="f:first($arg1)"/>
  </xsl:template>

 <xsl:function name="f:second" as="item()">
   <xsl:param name="pList" as="item()*"/>
   <xsl:sequence select="$pList[2]"/>
 </xsl:function>
 
  <xsl:function name="f:second" as="element()">
    <f:second/>
  </xsl:function>

  <xsl:template match="f:second" mode="f:FXSL" as="item()">
   <xsl:param name="arg1" as="item()*"/>
    <xsl:sequence select="f:second($arg1)"/>
  </xsl:template>

 <xsl:function name="f:third" as="item()">
   <xsl:param name="pList" as="item()*"/>
   <xsl:sequence select="$pList[3]"/>
 </xsl:function>

  <xsl:function name="f:third" as="element()">
    <f:third/>
  </xsl:function>
 
  <xsl:template match="f:third" mode="f:FXSL" as="item()">
   <xsl:param name="arg1" as="item()*"/>
    <xsl:sequence select="f:third($arg1)"/>
  </xsl:template>

</xsl:stylesheet>