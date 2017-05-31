<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:f="http://fxsl.sf.net/"
  xmlns:vendor="http://icl.com/saxon"
  xmlns:myIncrement="f:myIncrement" 
  exclude-result-prefixes="f vendor myIncrement" 
 >
 
 <xsl:import href="iter.xsl"/>
 <!-- To be applied on any xml file -->
 
 <xsl:output omit-xml-declaration="yes" indent="yes"/>
 
  <xsl:template match="/">
    <xsl:call-template name="generateBatch">
      <xsl:with-param name="pFrom" select="3"/>
      <xsl:with-param name="pTo" select="7"/>
    </xsl:call-template>
  </xsl:template>
  
  <myIncrement:myIncrement/>
  
  <xsl:template name="generateBatch">
    <xsl:param name="pFrom"/>
    <xsl:param name="pTo"/>
    
    <xsl:variable name="vFunIncr" 
         select="document('')/*/myIncrement:*[1]"/>
    
    <xsl:variable name="vResult">
      <xsl:call-template name="scanIter">
        <xsl:with-param name="arg1" select="$pTo - $pFrom + 1"/>
        <xsl:with-param name="arg2" select="$vFunIncr"/>
        <xsl:with-param name="arg3" select="$pFrom - 1"/>
        <xsl:with-param name="arg4" select="'obj'"/>
      </xsl:call-template>
    </xsl:variable>
    
    <xsl:copy-of select="$vResult/*[position() > 1]"/>
   </xsl:template>
   
   <xsl:template match="myIncrement:*" mode="f:FXSL">
     <xsl:param name="arg1"/>
       <childnode>
       <xsl:value-of select="$arg1 + 1"/>
       </childnode>
   </xsl:template>

</xsl:stylesheet>