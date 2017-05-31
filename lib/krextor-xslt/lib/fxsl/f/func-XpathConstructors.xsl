<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="xs f"
>

 <xsl:import href="func-compose-flist.xsl"/>
 
<!--
       This module contains the FXSL versions of the "standard"                
       XPath constructors.                                                     
-->

<!--
       Numeric constructors: decimal(), integer(), double(), float()           
-->


 <xsl:template match="f:decimal" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="f:decimal($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:decimal" as="element()">
   <f:decimal/>
 </xsl:function>
 

 <xsl:function name="f:decimal" as="xs:decimal?">
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="xs:decimal($arg1)"/>
 </xsl:function>
 

 <xsl:template match="f:integer" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="f:integer($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:integer" as="element()">
   <f:integer/>
 </xsl:function>
 

 <xsl:function name="f:integer" as="xs:integer?">
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="xs:integer($arg1)"/>
 </xsl:function>
 

 <xsl:template match="f:double" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="f:double($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:double" as="element()">
   <f:double/>
 </xsl:function>
 

 <xsl:function name="f:double" as="xs:double?">
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="xs:double($arg1)"/>
 </xsl:function>
 

 <xsl:template match="f:float" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="f:float($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:float" as="element()">
   <f:float/>
 </xsl:function>
 

 <xsl:function name="f:float" as="xs:float?">
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="xs:float($arg1)"/>
 </xsl:function>


 <xsl:template match="f:nonPositiveInteger" mode="f:FXSL"
   use-when="system-property('xsl:is-schema-aware')='yes'" >
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="f:nonPositiveInteger($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:nonPositiveInteger" as="element()"
  use-when="system-property('xsl:is-schema-aware')='yes'" >
   <f:nonPositiveInteger/>
 </xsl:function>
 

 <xsl:function name="f:nonPositiveInteger" as="xs:nonPositiveInteger?"
  use-when="system-property('xsl:is-schema-aware')='yes'" >
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="xs:nonPositiveInteger($arg1)"/>
 </xsl:function>
 

 <xsl:template match="f:negativeInteger" mode="f:FXSL"
  use-when="system-property('xsl:is-schema-aware')='yes'">
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="f:negativeInteger($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:negativeInteger" as="element()"
  use-when="system-property('xsl:is-schema-aware')='yes'">
   <f:negativeInteger/>
 </xsl:function>
 

 <xsl:function name="f:negativeInteger" as="xs:negativeInteger?"
  use-when="system-property('xsl:is-schema-aware')='yes'">
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="xs:negativeInteger($arg1)"/>
 </xsl:function>
 

 <xsl:template match="f:nonNegativeInteger" mode="f:FXSL"
  use-when="system-property('xsl:is-schema-aware')='yes'" >
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="f:nonNegativeInteger($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:nonNegativeInteger" as="element()"
  use-when="system-property('xsl:is-schema-aware')='yes'" >
   <f:nonNegativeInteger/>
 </xsl:function>
 

 <xsl:function name="f:nonNegativeInteger" as="xs:nonNegativeInteger?"
  use-when="system-property('xsl:is-schema-aware')='yes'" >
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="xs:nonNegativeInteger($arg1)"/>
 </xsl:function>


 <xsl:template match="f:positiveInteger" mode="f:FXSL"
   use-when="system-property('xsl:is-schema-aware')='yes'" >
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="f:positiveInteger($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:positiveInteger" as="element()"
   use-when="system-property('xsl:is-schema-aware')='yes'" >
    <f:positiveInteger/>
 </xsl:function>
 

 <xsl:function name="f:positiveInteger" as="xs:positiveInteger?"
   use-when="system-property('xsl:is-schema-aware')='yes'" >
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="xs:positiveInteger($arg1)"/>
 </xsl:function>
 

 <xsl:template match="f:long" mode="f:FXSL"
  use-when="system-property('xsl:is-schema-aware')='yes'" >
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="f:long($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:long" as="element()"
  use-when="system-property('xsl:is-schema-aware')='yes'" >
    <f:long/>
 </xsl:function>
 

 <xsl:function name="f:long" as="xs:long?"
  use-when="system-property('xsl:is-schema-aware')='yes'" >
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="xs:long($arg1)"/>
 </xsl:function>


 <xsl:template match="f:int" mode="f:FXSL"
  use-when="system-property('xsl:is-schema-aware')='yes'" >
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="f:int($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:int" as="element()"
  use-when="system-property('xsl:is-schema-aware')='yes'" >
    <f:int/>
 </xsl:function>
 

 <xsl:function name="f:int" as="xs:int?"
  use-when="system-property('xsl:is-schema-aware')='yes'" >
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="xs:int($arg1)"/>
 </xsl:function>
 

 <xsl:template match="f:short" mode="f:FXSL"
  use-when="system-property('xsl:is-schema-aware')='yes'" >
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="f:short($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:short" as="element()"
  use-when="system-property('xsl:is-schema-aware')='yes'" >
    <f:short/>
 </xsl:function>
 

 <xsl:function name="f:short" as="xs:short?"
  use-when="system-property('xsl:is-schema-aware')='yes'" >
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="xs:short($arg1)"/>
 </xsl:function>
 

 <xsl:template match="f:byte" mode="f:FXSL"
  use-when="system-property('xsl:is-schema-aware')='yes'" >
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="f:byte($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:byte" as="element()"
  use-when="system-property('xsl:is-schema-aware')='yes'" >
    <f:byte/>
 </xsl:function>
 

 <xsl:function name="f:byte" as="xs:byte?"
  use-when="system-property('xsl:is-schema-aware')='yes'" >
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="xs:byte($arg1)"/>
 </xsl:function>
 

 <xsl:template match="f:unsignedLong" mode="f:FXSL"
  use-when="system-property('xsl:is-schema-aware')='yes'" >
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="f:unsignedLong($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:unsignedLong" as="element()"
  use-when="system-property('xsl:is-schema-aware')='yes'" >
    <f:unsignedLong/>
 </xsl:function>
 

 <xsl:function name="f:unsignedLong" as="xs:unsignedLong?"
  use-when="system-property('xsl:is-schema-aware')='yes'" >
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="xs:unsignedLong($arg1)"/>
 </xsl:function>
 

 <xsl:template match="f:unsignedInt" mode="f:FXSL"
  use-when="system-property('xsl:is-schema-aware')='yes'" >
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="f:unsignedInt($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:unsignedInt" as="element()"
  use-when="system-property('xsl:is-schema-aware')='yes'" >
    <f:unsignedInt/>
 </xsl:function>
 

 <xsl:function name="f:unsignedInt" as="xs:unsignedInt?"
  use-when="system-property('xsl:is-schema-aware')='yes'" >
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="xs:unsignedInt($arg1)"/>
 </xsl:function>
 

 <xsl:template match="f:unsignedShort" mode="f:FXSL"
  use-when="system-property('xsl:is-schema-aware')='yes'" >
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="f:unsignedShort($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:unsignedShort" as="element()"
  use-when="system-property('xsl:is-schema-aware')='yes'" >
    <f:unsignedShort/>
 </xsl:function>
 

 <xsl:function name="f:unsignedShort" as="xs:unsignedShort?"
  use-when="system-property('xsl:is-schema-aware')='yes'" >
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="xs:unsignedShort($arg1)"/>
 </xsl:function>
 

 <xsl:template match="f:unsignedByte" mode="f:FXSL"
  use-when="system-property('xsl:is-schema-aware')='yes'" >
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="f:unsignedByte($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:unsignedByte" as="element()"
  use-when="system-property('xsl:is-schema-aware')='yes'" >
    <f:unsignedByte/>
 </xsl:function>
 

 <xsl:function name="f:unsignedByte" as="xs:unsignedByte?"
  use-when="system-property('xsl:is-schema-aware')='yes'" >
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="xs:unsignedByte($arg1)"/>
 </xsl:function>
 
<!--
       Boolean constructors: boolean()           
-->

 <xsl:template match="f:boolean" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="f:boolean($arg1)"/>
 </xsl:template> 

 <xsl:function name="f:boolean" as="element()">
    <f:boolean/>
 </xsl:function>
 

 <xsl:function name="f:boolean" as="xs:boolean?">
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="xs:boolean($arg1)"/>
 </xsl:function>

<!--
       base64Binary()           
-->

 <xsl:template match="f:base64Binary" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="f:base64Binary($arg1)"/>
 </xsl:template> 

 <xsl:function name="f:base64Binary" as="element()">
    <f:base64Binary/>
 </xsl:function>
 

 <xsl:function name="f:base64Binary" as="xs:base64Binary?">
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="xs:base64Binary($arg1)"/>
 </xsl:function>
     
<!--
       hexBinary()           
-->

 <xsl:template match="f:hexBinary" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="f:hexBinary($arg1)"/>
 </xsl:template> 

 <xsl:function name="f:hexBinary" as="element()">
    <f:hexBinary/>
 </xsl:function>
 

 <xsl:function name="f:hexBinary" as="xs:hexBinary?">
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="xs:hexBinary($arg1)"/>
 </xsl:function>
     
<!--
       anyURI()           
-->

 <xsl:template match="f:anyURI" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="f:anyURI($arg1)"/>
 </xsl:template> 

 <xsl:function name="f:anyURI" as="element()">
    <f:anyURI/>
 </xsl:function>
 

 <xsl:function name="f:anyURI" as="xs:anyURI?">
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="xs:anyURI($arg1)"/>
 </xsl:function>
     
<!--
       f:string()           
-->

 <xsl:template match="f:string" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="f:string($arg1)"/>
 </xsl:template> 

 <xsl:function name="f:string" as="element()">
    <f:string/>
 </xsl:function>
 

 <xsl:function name="f:string" as="xs:string?">
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="xs:string($arg1)"/>
 </xsl:function>
     
<!--
       f:duration()           
-->

 <xsl:template match="f:duration" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="f:duration($arg1)"/>
 </xsl:template> 

 <xsl:function name="f:duration" as="element()">
    <f:duration/>
 </xsl:function>
 

 <xsl:function name="f:duration" as="xs:duration?">
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="xs:duration($arg1)"/>
 </xsl:function>
     
<!--
       f:dateTime()           
-->

 <xsl:template match="f:dateTime" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="f:dateTime($arg1)"/>
 </xsl:template> 

 <xsl:function name="f:dateTime" as="element()">
    <f:dateTime/>
 </xsl:function>
 

 <xsl:function name="f:dateTime" as="xs:dateTime?">
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="xs:dateTime($arg1)"/>
 </xsl:function>
     
<!--
       f:time()           
-->

 <xsl:template match="f:time" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="f:time($arg1)"/>
 </xsl:template> 

 <xsl:function name="f:time" as="element()">
    <f:time/>
 </xsl:function>
 

 <xsl:function name="f:time" as="xs:time?">
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="xs:time($arg1)"/>
 </xsl:function>
     
<!--
       f:date()           
-->

 <xsl:template match="f:date" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="f:date($arg1)"/>
 </xsl:template> 

 <xsl:function name="f:date" as="element()">
    <f:date/>
 </xsl:function>
 

 <xsl:function name="f:date" as="xs:date?">
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="xs:date($arg1)"/>
 </xsl:function>
     
<!--
       f:gYearMonth()           
-->

 <xsl:template match="f:gYearMonth" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="f:gYearMonth($arg1)"/>
 </xsl:template> 

 <xsl:function name="f:gYearMonth" as="element()">
    <f:gYearMonth/>
 </xsl:function>
 

 <xsl:function name="f:gYearMonth" as="xs:gYearMonth?">
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="xs:gYearMonth($arg1)"/>
 </xsl:function>
     
<!--
       f:gYear()           
-->

 <xsl:template match="f:gYear" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="f:gYear($arg1)"/>
 </xsl:template> 

 <xsl:function name="f:gYear" as="element()">
    <f:gYear/>
 </xsl:function>
 

 <xsl:function name="f:gYear" as="xs:gYear?">
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="xs:gYear($arg1)"/>
 </xsl:function>
     
<!--
       f:gMonthDay()           
-->

 <xsl:template match="f:gMonthDay" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="f:gMonthDay($arg1)"/>
 </xsl:template> 

 <xsl:function name="f:gMonthDay" as="element()">
    <f:gMonthDay/>
 </xsl:function>
 

 <xsl:function name="f:gMonthDay" as="xs:gMonthDay?">
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="xs:gMonthDay($arg1)"/>
 </xsl:function>
     
<!--
       f:gDay()           
-->

 <xsl:template match="f:gDay" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="f:gDay($arg1)"/>
 </xsl:template> 

 <xsl:function name="f:gDay" as="element()">
    <f:gDay/>
 </xsl:function>
 

 <xsl:function name="f:gDay" as="xs:gDay?">
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="xs:gDay($arg1)"/>
 </xsl:function>
 <!--
       f:gMonth()           
-->

 <xsl:template match="f:gMonth" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="f:gMonth($arg1)"/>
 </xsl:template> 

 <xsl:function name="f:gMonth" as="element()">
    <f:gMonth/>
 </xsl:function>
 

 <xsl:function name="f:gMonth" as="xs:gMonth?">
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="xs:gMonth($arg1)"/>
 </xsl:function>
     
 <!--
       f:yearMonthDuration()           
-->

 <xsl:template match="f:yearMonthDuration" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="f:yearMonthDuration($arg1)"/>
 </xsl:template> 

 <xsl:function name="f:yearMonthDuration" as="element()">
    <f:yearMonthDuration/>
 </xsl:function>
 

 <xsl:function name="f:yearMonthDuration" as="xs:yearMonthDuration?">
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="xs:yearMonthDuration($arg1)"/>
 </xsl:function>
     
 <!--
       f:dayTimeDuration()           
-->

 <xsl:template match="f:dayTimeDuration" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="f:dayTimeDuration($arg1)"/>
 </xsl:template> 

 <xsl:function name="f:dayTimeDuration" as="element()">
    <f:dayTimeDuration/>
 </xsl:function>
 

 <xsl:function name="f:dayTimeDuration" as="xs:dayTimeDuration?">
   <xsl:param name="arg1" as="xs:anyAtomicType?"/>
   
   <xsl:sequence select="xs:dayTimeDuration($arg1)"/>
 </xsl:function>
     
</xsl:stylesheet>