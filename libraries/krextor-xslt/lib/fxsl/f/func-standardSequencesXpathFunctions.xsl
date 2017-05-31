<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="xs f"
>

 <xsl:import href="func-curry.xsl"/>
 <xsl:import href="func-compose-flist.xsl"/>

<!--
       Functions on sequences:                                                 
                         boolean(), index-of(),                                
                         empty(), exists(),                                    
                         distinct-values(), insert-before(),                   
                         remove(), reverse(),                                  
                         subsequence(), unordered()                            
-->

 <xsl:template match="f:boolean" mode="f:FXSL">
   <xsl:param name="arg1" as="item()*"/>
   
   <xsl:sequence select="f:boolean($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:boolean" as="element()">
   <f:boolean/>
 </xsl:function>
 
 <xsl:function name="f:boolean" as="xs:boolean">
   <xsl:param name="arg1" as="item()*"/>
   
   <xsl:sequence select="boolean($arg1)"/>
 </xsl:function>
 
 <xsl:template match="f:index-of" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:anyAtomicType*"/>
   <xsl:param name="arg2" as="xs:anyAtomicType"/>
   
   <xsl:sequence select="f:index-of($arg1,$arg2)"/>
 </xsl:template>
 
 <xsl:function name="f:index-of" as="element()">
   <f:index-of/>
 </xsl:function>
 
 <xsl:function name="f:index-of" as="node()">
   <xsl:param name="arg1" as="xs:anyAtomicType*"/>
   
   <xsl:sequence select="f:curry(f:index-of(),2,$arg1)"/>
 </xsl:function>
 
 <xsl:function name="f:index-of" as="xs:integer*">
   <xsl:param name="arg1" as="xs:anyAtomicType*"/>
   <xsl:param name="arg2" as="xs:anyAtomicType"/>
   
   <xsl:sequence select="index-of($arg1,$arg2)"/>
 </xsl:function>
    
 <xsl:template match="f:empty" mode="f:FXSL">
   <xsl:param name="arg1" as="item()*"/>
   
   <xsl:sequence select="f:empty($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:empty" as="element()">
   <f:empty/>
 </xsl:function>
 
 <xsl:function name="f:empty" as="xs:boolean">
   <xsl:param name="arg1" as="item()*"/>
   
   <xsl:sequence select="empty($arg1)"/>
 </xsl:function>
     
 <xsl:template match="f:exists" mode="f:FXSL">
   <xsl:param name="arg1" as="item()*"/>
   
   <xsl:sequence select="f:exists($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:exists" as="element()">
   <f:exists/>
 </xsl:function>
 
 <xsl:function name="f:exists" as="xs:boolean">
   <xsl:param name="arg1" as="item()*"/>
   
   <xsl:sequence select="exists($arg1)"/>
 </xsl:function>
     
 <xsl:template match="f:distinct-values" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:anyAtomicType*"/>
   
   <xsl:sequence select="f:distinct-values($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:distinct-values" as="element()">
   <f:distinct-values/>
 </xsl:function>
 
 <xsl:function name="f:distinct-values" as="xs:anyAtomicType*">
   <xsl:param name="arg1" as="xs:anyAtomicType*"/>
   
   <xsl:sequence select="distinct-values($arg1)"/>
 </xsl:function>

 <xsl:template match="f:insert-before" mode="f:FXSL">
   <xsl:param name="arg1" as="item()*"/>
   <xsl:param name="arg2" as="xs:integer"/>
   <xsl:param name="arg3" as="item()*"/>
   
   <xsl:sequence select="f:insert-before($arg1,$arg2,$arg3)"/>
 </xsl:template>
 
 <xsl:function name="f:insert-before" as="element()">
   <f:insert-before/>
 </xsl:function>
 
 <xsl:function name="f:insert-before" as="node()">
   <xsl:param name="arg1" as="item()*"/>
   
   <xsl:sequence select="f:curry(f:insert-before(),3,$arg1)"/>
 </xsl:function>
 
 <xsl:function name="f:insert-before" as="node()">
   <xsl:param name="arg1" as="item()*"/>
   <xsl:param name="arg2" as="xs:integer"/>
   
   <xsl:sequence select="f:curry(f:insert-before(),3,$arg1,$arg2)"/>
 </xsl:function>
 
 <xsl:function name="f:insert-before" as="item()*">
   <xsl:param name="arg1" as="item()*"/>
   <xsl:param name="arg2" as="xs:integer"/>
   <xsl:param name="arg3" as="item()*"/>
  
   <xsl:sequence select="insert-before($arg1,$arg2,$arg3)"/>
 </xsl:function>

 <xsl:template match="f:remove" mode="f:FXSL">
   <xsl:param name="arg1" as="item()*"/>
   <xsl:param name="arg2" as="xs:integer"/>
   
   <xsl:sequence select="f:remove($arg1,$arg2)"/>
 </xsl:template>
 
 <xsl:function name="f:remove" as="element()">
   <f:remove/>
 </xsl:function>
 
 <xsl:function name="f:remove" as="node()">
   <xsl:param name="arg1" as="item()*"/>
   
   <xsl:sequence select="f:curry(f:remove(),2,$arg1)"/>
 </xsl:function>
 
 <xsl:function name="f:remove" as="item()*">
   <xsl:param name="arg1" as="item()*"/>
   <xsl:param name="arg2" as="xs:integer"/>
   
   <xsl:sequence select="remove($arg1,$arg2)"/>
 </xsl:function>
    
 <xsl:template match="f:x-reverse" mode="f:FXSL">
   <xsl:param name="arg1" as="item()*"/>
   
   <xsl:sequence select="f:x-reverse($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:x-reverse" as="element()">
   <f:x-reverse/>
 </xsl:function>
 
 <xsl:function name="f:x-reverse" as="item()*">
   <xsl:param name="arg1" as="item()*"/>
   
   <xsl:sequence select="reverse($arg1)"/>
 </xsl:function>

 <xsl:template match="f:subsequence" mode="f:FXSL">
   <xsl:param name="arg1" as="item()*"/>
   <xsl:param name="arg2" as="xs:double"/>
   <xsl:param name="arg3" as="xs:double"/>
   
   <xsl:sequence select="f:subsequence($arg1,$arg2,$arg3)"/>
 </xsl:template>
 
 <xsl:function name="f:subsequence" as="element()">
   <f:subsequence/>
 </xsl:function>
 
 <xsl:function name="f:subsequence" as="node()">
   <xsl:param name="arg1" as="item()*"/>
   
   <xsl:sequence select="f:curry(f:subsequence(),3,$arg1)"/>
 </xsl:function>
 
 <xsl:function name="f:subsequence" as="node()">
   <xsl:param name="arg1" as="item()*"/>
   <xsl:param name="arg2" as="xs:double"/>
   
   <xsl:sequence select="f:curry(f:subsequence(),3,$arg1,$arg2)"/>
 </xsl:function>
 
 <xsl:function name="f:subsequence" as="item()*">
   <xsl:param name="arg1" as="item()*"/>
   <xsl:param name="arg2" as="xs:double"/>
   <xsl:param name="arg3" as="xs:double"/>
   
   <xsl:sequence select="subsequence($arg1,$arg2,$arg3)"/>
 </xsl:function>

 <xsl:template match="f:unordered" mode="f:FXSL">
   <xsl:param name="arg1" as="item()*"/>
   
   <xsl:sequence select="f:unordered($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:unordered" as="element()">
   <f:unordered/>
 </xsl:function>
 
 <xsl:function name="f:unordered" as="item()*">
   <xsl:param name="arg1" as="item()*"/>
   
   <xsl:sequence select="unordered($arg1)"/>
 </xsl:function>

<!--
       Functions on sequences:                                                 
                 zero-or-one(), one-or-more(), exactly-one()                   
-->

 <xsl:template match="f:zero-or-one" mode="f:FXSL">
   <xsl:param name="arg1" as="item()*"/>
   
   <xsl:sequence select="f:zero-or-one($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:zero-or-one" as="element()">
   <f:zero-or-one/>
 </xsl:function>
 
 <xsl:function name="f:zero-or-one" as="item()?">
   <xsl:param name="arg1" as="item()*"/>
   
   <xsl:sequence select="zero-or-one($arg1)"/>
 </xsl:function>

 <xsl:template match="f:one-or-more" mode="f:FXSL">
   <xsl:param name="arg1" as="item()*"/>
   
   <xsl:sequence select="f:one-or-more($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:one-or-more" as="element()">
   <f:one-or-more/>
 </xsl:function>
 
 <xsl:function name="f:one-or-more" as="item()+">
   <xsl:param name="arg1" as="item()*"/>
   
   <xsl:sequence select="one-or-more($arg1)"/>
 </xsl:function>

 <xsl:template match="f:exactly-one" mode="f:FXSL">
   <xsl:param name="arg1" as="item()*"/>
   
   <xsl:sequence select="f:exactly-one($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:exactly-one" as="element()">
   <f:exactly-one/>
 </xsl:function>
 
 <xsl:function name="f:exactly-one" as="item()">
   <xsl:param name="arg1" as="item()*"/>
   
   <xsl:sequence select="exactly-one($arg1)"/>
 </xsl:function>

<!--
       Functions on sequences:                                                 
                         deep-equal()                                          
-->

 <xsl:template match="f:deep-equal" mode="f:FXSL">
   <xsl:param name="arg1" as="item()*"/>
   <xsl:param name="arg2" as="item()*"/>
   
   <xsl:sequence select="f:deep-equal($arg1,$arg2)"/>
 </xsl:template>
 
 <xsl:function name="f:deep-equal" as="element()">
   <f:deep-equal/>
 </xsl:function>
 
 <xsl:function name="f:deep-equal" as="node()">
   <xsl:param name="arg1" as="item()*"/>
   
   <xsl:sequence select="f:curry(f:deep-equal(),2,$arg1)"/>
 </xsl:function>
 
 <xsl:function name="f:deep-equal" as="xs:boolean">
   <xsl:param name="arg1" as="item()*"/>
   <xsl:param name="arg2" as="item()*"/>
   
   <xsl:sequence select="deep-equal($arg1,$arg2)"/>
 </xsl:function>

 <xsl:function name="f:data" as="element()">
   <f:data/>
 </xsl:function>
 
 <xsl:function name="f:data" as="xs:anyAtomicType*">
   <xsl:param name="seq" as="item()*"/>
   <xsl:sequence select="data($seq)"/>
 </xsl:function>
 
 <xsl:template match="f:data" mode="f:FXSL">
   <xsl:param name="arg1" as="item()*"/>
   <xsl:sequence select="f:data($arg1)"/>
 </xsl:template>
 
</xsl:stylesheet>