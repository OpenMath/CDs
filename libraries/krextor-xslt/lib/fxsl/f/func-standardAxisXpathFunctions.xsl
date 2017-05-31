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
       XPath Axis functions:                                                    
                     elements()                                               
-->
 <xsl:function name="f:elements" as="element()*">
   <xsl:param name="pNode" as="node()+"/>
   
   <xsl:sequence select="$pNode/*"/>
 </xsl:function>

 <xsl:function name="f:elements" as="element()">
   <f:elements/>
 </xsl:function>
 
 <xsl:template match="f:elements" mode="f:FXSL">
   <xsl:param name="arg1" as="node()+"/>
   
   <xsl:sequence select="f:elements($arg1)"/>
 </xsl:template>
     
 <xsl:function name="f:element" as="element()*">
   <xsl:param name="pNode" as="node()+"/>
   <xsl:param name="pName" as="xs:string"/>
   
   <xsl:sequence select="$pNode/*[name()=$pName]"/>
 </xsl:function>
 
 <xsl:function name="f:element" as="node()">
   <xsl:param name="pNode" as="node()+"/>
   
   <xsl:sequence select="f:curry(f:element(), 2, $pNode)"/>
 </xsl:function>
 
 <xsl:function name="f:element" as="element()">
   <f:element/>
 </xsl:function>
 
 <xsl:template match="f:element" mode="f:FXSL">
   <xsl:param name="arg1" as="node()+"/>
   <xsl:param name="arg2" as="xs:string"/>
   
   <xsl:sequence select="f:element($arg1,$arg2)"/>
 </xsl:template>
 

<!--
       XPath Axis functions:                                                    
                     attributes()                                               
-->

 <xsl:function name="f:attributes" as="attribute()*">
   <xsl:param name="pElement" as="element()+"/>
   
   <xsl:sequence select="$pElement/@*"/>
 </xsl:function>
 
 <xsl:function name="f:attributes" as="element()">
   <f:attributes/>
 </xsl:function>
 
 <xsl:template match="f:attributes" mode="f:FXSL">
   <xsl:param name="arg1" as="element()+"/>
   
   <xsl:sequence select="f:attributes($arg1)"/>
 </xsl:template>
     
 <xsl:function name="f:attribute" as="attribute()*">
   <xsl:param name="pElement" as="element()+"/>
   <xsl:param name="pName" as="xs:string"/>
   
   <xsl:sequence select="$pElement/@*[name()=$pName]"/>
 </xsl:function>
 
 <xsl:function name="f:attribute" as="element()">
   <f:attribute/>
 </xsl:function>
 
 <xsl:function name="f:attribute" as="node()">
   <xsl:param name="pElement" as="element()+"/>
   
   <xsl:sequence select="f:curry(f:attribute(), 2, $pElement)"/>
 </xsl:function>
 
 <xsl:template match="f:attribute" mode="f:FXSL">
   <xsl:param name="arg1" as="element()+"/>
   <xsl:param name="arg2" as="xs:string"/>
   
   <xsl:sequence select="f:attribute($arg1,$arg2)"/>
 </xsl:template>
     

</xsl:stylesheet>