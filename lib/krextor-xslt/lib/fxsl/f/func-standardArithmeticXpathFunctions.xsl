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
       Arithmetic functions: abs(), ceiling(), floor(), round(),               
       round-half-to-even()                                                    
-->


 <xsl:template match="f:abs" mode="f:FXSL">
   <xsl:param name="arg1" as="item()?"/>
   
   <xsl:sequence select="f:abs($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:abs" as="element()">
   <f:abs/>
 </xsl:function>
 

 <xsl:function name="f:abs" as="item()?">
   <xsl:param name="arg1" as="item()?"/>
   
   <xsl:sequence select="abs($arg1)"/>
 </xsl:function>
 

 <xsl:template match="f:ceiling" mode="f:FXSL">
   <xsl:param name="arg1" as="item()?"/>
   
   <xsl:sequence select="f:ceiling($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:ceiling" as="element()">
   <f:ceiling/>
 </xsl:function>
 

 <xsl:function name="f:ceiling" as="item()?">
   <xsl:param name="arg1" as="item()?"/>
   
   <xsl:sequence select="ceiling($arg1)"/>
 </xsl:function>


 <xsl:template match="f:floor" mode="f:FXSL">
   <xsl:param name="arg1" as="item()?"/>
   
   <xsl:sequence select="f:floor($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:floor" as="element()">
   <f:floor/>
 </xsl:function>
 

 <xsl:function name="f:floor" as="item()?">
   <xsl:param name="arg1" as="item()?"/>
   
   <xsl:sequence select="floor($arg1)"/>
 </xsl:function>


 <xsl:template match="f:round" mode="f:FXSL">
   <xsl:param name="arg1" as="item()?"/>
   
   <xsl:sequence select="f:round($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:round" as="element()">
  <f:round/>
 </xsl:function>
 

 <xsl:function name="f:round" as="item()?">
   <xsl:param name="arg1" as="item()?"/>
   
   <xsl:sequence select="round($arg1)"/>
 </xsl:function>
   


 <xsl:template match="f:round-half-to-even" mode="f:FXSL">
   <xsl:param name="arg1" as="item()?"/>
   <xsl:param name="arg2" as="xs:integer"/>
   
   <xsl:sequence select="f:round-half-to-even($arg1,$arg2)"/>
 </xsl:template>
 
 <xsl:function name="f:round-half-to-even" as="element()">
  <f:round-half-to-even/>
 </xsl:function>
 

 <xsl:function name="f:round-half-to-even" as="node()">
   <xsl:param name="arg1" as="item()"/>
   
   <xsl:sequence select="f:curry(f:round-half-to-even(), 2, $arg1)"/>
 </xsl:function>
   
 <xsl:function name="f:round-half-to-even" as="item()?">
   <xsl:param name="arg1" as="item()?"/>
   <xsl:param name="arg2" as="xs:integer"/>
   
   <xsl:sequence select="round-half-to-even($arg1,$arg2)"/>
 </xsl:function>

</xsl:stylesheet>