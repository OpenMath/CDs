<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:xdt="http://www.w3.org/2005/04/xpath-datatypes" 
 xmlns:xdtOld="http://www.w3.org/2005/02/xpath-datatypes" 
 xmlns:xdtOld2="http://www.w3.org/2004/10/xpath-datatypes" 
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="xs xdt f"
>

 <xsl:import href="func-curry.xsl"/>
 <xsl:import href="func-compose-flist.xsl"/>

<!--
       Boolean functions: not()                                                
-->


 <xsl:template match="f:not" mode="f:FXSL">
   <xsl:param name="arg1" as="item()*"/>
   
   <xsl:sequence select="f:not($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:not" as="element()">
  <f:not/>
 </xsl:function>
 
 <xsl:function name="f:not" as="xs:boolean">
   <xsl:param name="arg1" as="item()*"/>
   
   <xsl:sequence select="not($arg1)"/>
 </xsl:function>
   

</xsl:stylesheet>