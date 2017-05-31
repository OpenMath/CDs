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
       String functions: string-join(), substring()                            
                         string-length(), normalize-space()                    
                         normalize-unicode(), upper-case(),                    
                         lower-case(), translate(), escape-uri()               
-->
   

 <xsl:template match="f:string-join" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:string*"/>
   <xsl:param name="arg2" as="xs:string*"/>
   
   <xsl:sequence select="f:string-join($arg1, if(empty($arg2)) then '' else $arg2)"/>
 </xsl:template>
 
 <xsl:function name="f:string-join" as="element()">
  <f:string-join/>
 </xsl:function>
 

 <xsl:function name="f:string-join" as="node()">
   <xsl:param name="arg1" as="xs:string*"/>
   
   <xsl:sequence select="f:curry(f:string-join(), 2, $arg1)"/>
 </xsl:function>
   
 <xsl:function name="f:string-join" as="xs:string">
   <xsl:param name="arg1" as="xs:string*"/>
   <xsl:param name="arg2" as="xs:string"/>
   
   <xsl:sequence select="string-join($arg1,$arg2)"/>
 </xsl:function>
 
 <xsl:template match="f:substring" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:string"/>
   <xsl:param name="arg2" as="xs:double"/>
   <xsl:param name="arg3" as="xs:double"/>
   
   <xsl:sequence select="f:substring($arg1,$arg2,$arg3)"/>
 </xsl:template>
 
 <xsl:function name="f:substring" as="element()">
  <f:substring/>
 </xsl:function>
 

 <xsl:function name="f:substring" as="node()">
   <xsl:param name="arg1" as="xs:string"/>
   
   <xsl:sequence select="f:curry(f:substring(), 3, $arg1)"/>
 </xsl:function>
   
 <xsl:function name="f:substring" as="xs:string">
   <xsl:param name="arg1" as="xs:string"/>
   <xsl:param name="arg2" as="xs:double"/>
   <xsl:param name="arg3" as="xs:double"/>
   
   <xsl:sequence select="substring($arg1,$arg2,$arg3)"/>
 </xsl:function>
 
 <xsl:template match="f:string-length" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:string?"/>
   
   <xsl:sequence select="f:string-length($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:string-length" as="element()">
   <f:string-length/>
 </xsl:function>
 
 <xsl:function name="f:string-length" as="xs:integer">
   <xsl:param name="arg1" as="xs:string?"/>
   
   <xsl:sequence select="string-length($arg1)"/>
 </xsl:function>
 
 <xsl:template match="f:normalize-space" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:string?"/>
   
   <xsl:sequence select="f:normalize-space($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:normalize-space" as="element()">
   <f:normalize-space/>
 </xsl:function>
 
 <xsl:function name="f:normalize-space" as="xs:string">
   <xsl:param name="arg1" as="xs:string?"/>
   
   <xsl:sequence select="normalize-space($arg1)"/>
 </xsl:function>
 
 <xsl:template match="f:normalize-unicode" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:string?"/>
   <xsl:param name="arg2" as="xs:string"/>
   
   <xsl:sequence select="f:normalize-unicode($arg1,$arg2)"/>
 </xsl:template>
 
 <xsl:function name="f:normalize-unicode" as="element()">
   <f:normalize-unicode/>
 </xsl:function>
 
 <xsl:function name="f:normalize-unicode" as="node()">
   <xsl:param name="arg1" as="xs:string?"/>
   
   <xsl:sequence select="f:curry(f:normalize-unicode(),2,$arg1)"/>
 </xsl:function>
 
 <xsl:function name="f:normalize-unicode" as="xs:string">
   <xsl:param name="arg1" as="xs:string?"/>
   <xsl:param name="arg2" as="xs:string"/>
   
   <xsl:sequence select="normalize-unicode($arg1,$arg2)"/>
 </xsl:function>
 

 <xsl:template match="f:upper-case" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:string?"/>
   
   <xsl:sequence select="f:upper-case($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:upper-case" as="element()">
   <f:upper-case/>
 </xsl:function>
 
 <xsl:function name="f:upper-case" as="xs:string">
   <xsl:param name="arg1" as="xs:string?"/>
   
   <xsl:sequence select="upper-case($arg1)"/>
 </xsl:function>
 
 <xsl:template match="f:lower-case" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:string?"/>
   
   <xsl:sequence select="f:lower-case($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:lower-case" as="element()">
   <f:lower-case/>
 </xsl:function>
 
 <xsl:function name="f:lower-case" as="xs:string">
   <xsl:param name="arg1" as="xs:string?"/>
   
   <xsl:sequence select="lower-case($arg1)"/>
 </xsl:function>
 
 <xsl:template match="f:translate" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:string?"/>
   <xsl:param name="arg2" as="xs:string"/>
   <xsl:param name="arg3" as="xs:string"/>
   
   <xsl:sequence select="f:translate($arg1,$arg2,arg3)"/>
 </xsl:template>
 
 <xsl:function name="f:translate" as="element()">
   <f:translate/>
 </xsl:function>
 
 <xsl:function name="f:translate" as="node()">
   <xsl:param name="arg1" as="xs:string?"/>
   
   <xsl:sequence select="f:curry(f:translate(),3,$arg1)"/>
 </xsl:function>
 
 <xsl:function name="f:translate" as="node()">
   <xsl:param name="arg1" as="xs:string?"/>
   <xsl:param name="arg2" as="xs:string"/>
   
   <xsl:sequence select="f:curry(f:translate(),3,$arg1,$arg2)"/>
 </xsl:function>
 
 <xsl:function name="f:translate" as="xs:string">
   <xsl:param name="arg1" as="xs:string?"/>
   <xsl:param name="arg2" as="xs:string"/>
   <xsl:param name="arg3" as="xs:string"/>
   
   <xsl:sequence select="translate($arg1,$arg2,$arg3)"/>
 </xsl:function>
<!-- 
 <f:escape-uri/>
 <xsl:template match="f:escape-uri" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:string?"/>
   <xsl:param name="arg2" as="xs:boolean"/>
   
   <xsl:sequence select="f:escape-uri($arg1,$arg2)"/>
 </xsl:template>
 
 <xsl:function name="f:escape-uri" as="node()">
   <xsl:sequence select="document('')/*/f:escape-uri[1]"/>
 </xsl:function>
 
 <xsl:function name="f:escape-uri" as="node()">
   <xsl:param name="arg1" as="xs:string?"/>
   
   <xsl:sequence select="f:curry(f:escape-uri(),2,$arg1)"/>
 </xsl:function>
 

 <xsl:function name="f:escape-uri" as="xs:string">
   <xsl:param name="arg1" as="xs:string?"/>
   <xsl:param name="arg2" as="xs:boolean"/>
   
   <xsl:sequence select="escape-uri($arg1,$arg2)"/>
 </xsl:function>
--> 
<!--
  More String functions: contains(), starts-with()                             
                         ends-with(), substring-before(),                      
                         substring-after()                                     
-->

 <xsl:template match="f:contains" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:string?"/>
   <xsl:param name="arg2" as="xs:string?"/>
   
   <xsl:sequence select="f:contains($arg1,$arg2)"/>
 </xsl:template>
 
 <xsl:function name="f:contains" as="element()">
   <f:contains/>
 </xsl:function>
 
 <xsl:function name="f:contains" as="node()">
   <xsl:param name="arg1" as="xs:string?"/>
   
   <xsl:sequence select="f:curry(f:contains(),2,$arg1)"/>
 </xsl:function>
 
 <xsl:function name="f:contains" as="xs:boolean">
   <xsl:param name="arg1" as="xs:string?"/>
   <xsl:param name="arg2" as="xs:string?"/>
   
   <xsl:sequence select="contains($arg1,$arg2)"/>
 </xsl:function>
    
 <xsl:template match="f:starts-with" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:string?"/>
   <xsl:param name="arg2" as="xs:string?"/>
   
   <xsl:sequence select="f:starts-with($arg1,$arg2)"/>
 </xsl:template>
 
 <xsl:function name="f:starts-with" as="element()">
   <f:starts-with/>
 </xsl:function>
 
 <xsl:function name="f:starts-with" as="node()">
   <xsl:param name="arg1" as="xs:string?"/>
   
   <xsl:sequence select="f:curry(f:starts-with(),2,$arg1)"/>
 </xsl:function>
 
 <xsl:function name="f:starts-with" as="xs:boolean">
   <xsl:param name="arg1" as="xs:string?"/>
   <xsl:param name="arg2" as="xs:string?"/>
   
   <xsl:sequence select="starts-with($arg1,$arg2)"/>
 </xsl:function>
    
 <xsl:template match="f:ends-with" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:string?"/>
   <xsl:param name="arg2" as="xs:string?"/>
   
   <xsl:sequence select="f:ends-with($arg1,$arg2)"/>
 </xsl:template>
 
 <xsl:function name="f:ends-with" as="element()">
   <f:ends-with/>
 </xsl:function>
 
 <xsl:function name="f:ends-with" as="node()">
   <xsl:param name="arg1" as="xs:string?"/>
   
   <xsl:sequence select="f:curry(f:ends-with(),2,$arg1)"/>
 </xsl:function>
 
 <xsl:function name="f:ends-with" as="xs:boolean">
   <xsl:param name="arg1" as="xs:string?"/>
   <xsl:param name="arg2" as="xs:string?"/>
   
   <xsl:sequence select="ends-with($arg1,$arg2)"/>
 </xsl:function>
    

 <xsl:template match="f:substring-before" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:string?"/>
   <xsl:param name="arg2" as="xs:string?"/>

   <xsl:sequence select="f:substring-before($arg1,$arg2)"/>
 </xsl:template>
 
 <xsl:function name="f:substring-before" as="element()">
   <f:substring-before/>
 </xsl:function>
 
 <xsl:function name="f:substring-before" as="node()">
   <xsl:param name="arg1" as="xs:string?"/>
   
   <xsl:sequence select="f:curry(f:substring-before(),2,$arg1)"/>
 </xsl:function>
 
 <xsl:function name="f:substring-before" as="xs:string">
   <xsl:param name="arg1" as="xs:string?"/>
   <xsl:param name="arg2" as="xs:string?"/>
   
   <xsl:sequence select="substring-before($arg1,$arg2)"/>
 </xsl:function>
    
 <xsl:template match="f:substring-after" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:string?"/>
   <xsl:param name="arg2" as="xs:string?"/>
   
   <xsl:sequence select="f:substring-after($arg1,$arg2)"/>
 </xsl:template>
 
 <xsl:function name="f:substring-after" as="element()">
   <f:substring-after/>
 </xsl:function>
 
 <xsl:function name="f:substring-after" as="node()">
   <xsl:param name="arg1" as="xs:string?"/>
   
   <xsl:sequence select="f:curry(f:substring-after(),2,$arg1)"/>
 </xsl:function>
 
 <xsl:function name="f:substring-after" as="xs:string">
   <xsl:param name="arg1" as="xs:string?"/>
   <xsl:param name="arg2" as="xs:string?"/>
   
   <xsl:sequence select="substring-after($arg1,$arg2)"/>
 </xsl:function>
    
<!--
  More String functions: matches(), replace(), tokenize()                      
                                                                               
-->

 <xsl:template match="f:matches" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:string?"/>
   <xsl:param name="arg2" as="xs:string"/>
   <xsl:param name="arg3" as="xs:string"/>
   
   <xsl:sequence select="f:matches($arg1,$arg2,$arg3)"/>
 </xsl:template>
 
 <xsl:function name="f:matches" as="element()">
   <f:matches/>
 </xsl:function>
 
 <xsl:function name="f:matches" as="node()">
   <xsl:param name="arg1" as="xs:string?"/>
   
   <xsl:sequence select="f:curry(f:matches(),3,$arg1)"/>
 </xsl:function>
 
 <xsl:function name="f:matches" as="node()">
   <xsl:param name="arg1" as="xs:string?"/>
   <xsl:param name="arg2" as="xs:string"/>
   
   <xsl:sequence select="f:curry(f:matches(),3,$arg1,$arg2)"/>
 </xsl:function>
 
 <xsl:function name="f:matches" as="xs:boolean">
   <xsl:param name="arg1" as="xs:string?"/>
   <xsl:param name="arg2" as="xs:string?"/>
   <xsl:param name="arg3" as="xs:string"/>
   
   <xsl:sequence select="matches($arg1,$arg2,$arg3)"/>
 </xsl:function>
    
 <xsl:template match="f:replace" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:string?"/>
   <xsl:param name="arg2" as="xs:string"/>
   <xsl:param name="arg3" as="xs:string"/>
   <xsl:param name="arg4" as="xs:string"/>
   
   <xsl:sequence select="f:replace($arg1,$arg2,$arg3,$arg4)"/>
 </xsl:template>
 
 <xsl:function name="f:replace" as="element()">
   <f:replace/>
 </xsl:function>
 
 <xsl:function name="f:replace" as="node()">
   <xsl:param name="arg1" as="xs:string?"/>
   
   <xsl:sequence select="f:curry(f:replace(),4,$arg1)"/>
 </xsl:function>
 
 <xsl:function name="f:replace" as="node()">
   <xsl:param name="arg1" as="xs:string?"/>
   <xsl:param name="arg2" as="xs:string"/>
   
   <xsl:sequence select="f:curry(f:replace(),4,$arg1,$arg2)"/>
 </xsl:function>
 
 <xsl:function name="f:replace" as="node()">
   <xsl:param name="arg1" as="xs:string?"/>
   <xsl:param name="arg2" as="xs:string"/>
   <xsl:param name="arg3" as="xs:string"/>
   
   <xsl:sequence select="f:curry(f:replace(),4,$arg1,$arg2,$arg3)"/>
 </xsl:function>
 
 <xsl:function name="f:replace" as="xs:string">
   <xsl:param name="arg1" as="xs:string?"/>
   <xsl:param name="arg2" as="xs:string?"/>
   <xsl:param name="arg3" as="xs:string"/>
   <xsl:param name="arg4" as="xs:string"/>
   
   <xsl:sequence select="replace($arg1,$arg2,$arg3,$arg4)"/>
 </xsl:function>

 <xsl:template match="f:tokenize" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:string?"/>
   <xsl:param name="arg2" as="xs:string"/>
   <xsl:param name="arg3" as="xs:string"/>
   
   <xsl:sequence select="f:tokenize($arg1,$arg2,$arg3)"/>
 </xsl:template>
 
 <xsl:function name="f:tokenize" as="element()">
   <f:tokenize/>
 </xsl:function>
 
 <xsl:function name="f:tokenize" as="node()">
   <xsl:param name="arg1" as="xs:string?"/>
   
   <xsl:sequence select="f:curry(f:tokenize(),3,$arg1)"/>
 </xsl:function>
 
 <xsl:function name="f:tokenize" as="node()">
   <xsl:param name="arg1" as="xs:string?"/>
   <xsl:param name="arg2" as="xs:string"/>
   
   <xsl:sequence select="f:curry(f:tokenize(),3,$arg1,$arg2)"/>
 </xsl:function>
 
 <xsl:function name="f:tokenize" as="xs:string+">
   <xsl:param name="arg1" as="xs:string?"/>
   <xsl:param name="arg2" as="xs:string?"/>
   <xsl:param name="arg3" as="xs:string"/>
   
   <xsl:sequence select="tokenize($arg1,$arg2,$arg3)"/>
 </xsl:function>

<!--
  More String functions: codepoints-to-string(), string-to-codepoints()        
                                                                               
-->
 <xsl:template match="f:codepoints-to-string" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:integer*"/>
   
   <xsl:sequence select="f:codepoints-to-string($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:codepoints-to-string" as="element()">
   <f:codepoints-to-string/>
 </xsl:function>
 
 <xsl:function name="f:codepoints-to-string" as="xs:string">
   <xsl:param name="arg1" as="xs:integer*"/>
   
   <xsl:sequence select="codepoints-to-string($arg1)"/>
 </xsl:function>


 
 <xsl:template match="f:string-to-codepoints" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:string?"/>
   
   <xsl:sequence select="f:string-to-codepoints($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:string-to-codepoints" as="element()">
   <f:string-to-codepoints/>
 </xsl:function>
 
 <xsl:function name="f:string-to-codepoints" as="xs:integer*">
   <xsl:param name="arg1" as="xs:string?"/>
   
   <xsl:sequence select="string-to-codepoints($arg1)"/>
 </xsl:function>
 


</xsl:stylesheet>