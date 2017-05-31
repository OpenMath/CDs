<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="xs f"
>

 <xsl:import href="func-curry.xsl"/>
 <xsl:import href="func-compose-flist.xsl"/>

<!--
       Aggregate functions:                                                    
                     count(), avg(),                                           
                     x-max(), x-min(), x-sum()                                 
-->

 <xsl:template match="f:count" mode="f:FXSL">
   <xsl:param name="arg1" as="item()*"/>
   
   <xsl:sequence select="f:count($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:count" as="element()">
   <f:count/>
 </xsl:function>
 
 <xsl:function name="f:count" as="xs:integer">
   <xsl:param name="arg1" as="item()*"/>
   
   <xsl:sequence select="count($arg1)"/>
 </xsl:function>

 <xsl:template match="f:avg" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:anyAtomicType*"/>
   
   <xsl:sequence select="f:avg($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:avg" as="element()">
   <f:avg/>
 </xsl:function>
 
 <xsl:function name="f:avg" as="xs:anyAtomicType?">
   <xsl:param name="arg1" as="xs:anyAtomicType*"/>
   
   <xsl:sequence select="avg($arg1)"/>
 </xsl:function>

 <xsl:template match="f:x-max" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:anyAtomicType*"/>
   
   <xsl:sequence select="f:x-max($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:x-max" as="element()">
   <f:x-max/>
 </xsl:function>
 
 <xsl:function name="f:x-max" as="xs:anyAtomicType?">
   <xsl:param name="arg1" as="xs:anyAtomicType*"/>
   
   <xsl:sequence select="max($arg1)"/>
 </xsl:function>

 <xsl:template match="f:x-min" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:anyAtomicType*"/>
   
   <xsl:sequence select="f:x-min($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:x-min" as="element()">
   <f:x-min/>
 </xsl:function>
 
 <xsl:function name="f:x-min" as="xs:anyAtomicType?">
   <xsl:param name="arg1" as="xs:anyAtomicType*"/>
   
   <xsl:sequence select="min($arg1)"/>
 </xsl:function>

 <xsl:template match="f:x-sum" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:anyAtomicType*"/>
   
   <xsl:sequence select="f:x-sum($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:x-sum" as="element()">
   <f:x-sum/>
 </xsl:function>
 
 <xsl:function name="f:x-sum" as="xs:anyAtomicType">
   <xsl:param name="arg1" as="xs:anyAtomicType*"/>
   
   <xsl:sequence select="sum($arg1)"/>
 </xsl:function>


</xsl:stylesheet>