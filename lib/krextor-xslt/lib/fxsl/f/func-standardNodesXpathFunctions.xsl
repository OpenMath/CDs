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
       Functions on nodes: name(), local-name()                                
                         namespace-uri(), number(),                            
                         lang(), root()                                        
-->

 <xsl:template match="f:name" mode="f:FXSL">
   <xsl:param name="arg1" as="node()?"/>
   
   <xsl:sequence select="f:name($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:name" as="node()">
   <f:name/>
 </xsl:function>
 
 <xsl:function name="f:name" as="xs:string">
   <xsl:param name="arg1" as="node()?"/>
   
   <xsl:sequence select="name($arg1)"/>
 </xsl:function>
 
 <xsl:template match="f:local-name" mode="f:FXSL">
   <xsl:param name="arg1" as="node()?"/>
   
   <xsl:sequence select="f:local-name($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:local-name" as="node()">
   <f:local-name/>
 </xsl:function>
 
 <xsl:function name="f:local-name" as="xs:string">
   <xsl:param name="arg1" as="node()?"/>
   
   <xsl:sequence select="local-name($arg1)"/>
 </xsl:function>
 
 <xsl:template match="f:namespace-uri" mode="f:FXSL">
   <xsl:param name="arg1" as="node()?"/>
   
   <xsl:sequence select="f:namespace-uri($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:namespace-uri" as="element()">
   <f:namespace-uri/>
 </xsl:function>
 
 <xsl:function name="f:namespace-uri" as="xs:anyURI">
   <xsl:param name="arg1" as="node()?"/>
   
   <xsl:sequence select="namespace-uri($arg1)"/>
 </xsl:function>
 

 <xsl:template match="f:number" mode="f:FXSL">
   <xsl:param name="arg1" as="item()?"/>
   
   <xsl:sequence select="f:number($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:number" as="element()">
   <f:number/>
 </xsl:function>
 
 <xsl:function name="f:number" as="xs:double">
   <xsl:param name="arg1" as="item()?"/>
   
   <xsl:sequence select="number($arg1)"/>
 </xsl:function>

 <xsl:template match="f:lang" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:string?"/>
   <xsl:param name="arg2" as="node()"/>
   
   <xsl:sequence select="f:lang($arg1,$arg2)"/>
 </xsl:template>
 
 <xsl:function name="f:lang" as="element()">
   <f:lang/>
 </xsl:function>
 
 <xsl:function name="f:lang" as="node()">
   <xsl:param name="arg1" as="xs:string?"/>
   
   <xsl:sequence select="f:curry(f:lang(),2,$arg1)"/>
 </xsl:function>
 
 <xsl:function name="f:lang" as="xs:boolean">
   <xsl:param name="arg1" as="xs:string?"/>
   <xsl:param name="arg2" as="node()"/>
   
   <xsl:sequence select="lang($arg1,$arg2)"/>
 </xsl:function>
    
 <xsl:template match="f:root" mode="f:FXSL">
   <xsl:param name="arg1" as="node()?"/>
   
   <xsl:sequence select="f:root($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:root" as="element()">
   <f:root/>
 </xsl:function>
 
 <xsl:function name="f:root" as="node()?">
   <xsl:param name="arg1" as="node()?"/>
   
   <xsl:sequence select="root($arg1)"/>
 </xsl:function>
 

</xsl:stylesheet>