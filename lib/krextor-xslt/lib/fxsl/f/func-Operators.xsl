<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="xs f"
>

 <xsl:import href="func-curry.xsl"/>
 <xsl:import href="func-apply.xsl"/>

 
<!--
       This module contains the FXSL versions of the "builtin" XPath operators
                                                                              
       These are intended as convenience functions, so that they can be passed
       as parameters to other functions (e.g. to f:zipWith())                 
       or curried and passed as parameters (e.g. to f:map())                  
-->

<!--
       Arithmetic operators: +, -, *, div, idiv, mod                          
-->

 
 <xsl:template match="f:add" mode="f:FXSL">
   <xsl:param name="arg1"/>
   <xsl:param name="arg2"/>
   
   <xsl:sequence select="f:add($arg1, $arg2)"/>
 </xsl:template>
 
 <xsl:function name="f:add" as="element()">
   <f:add/>
 </xsl:function>
 
 <xsl:function name="f:add" as="node()">
   <xsl:param name="arg1" as="item()"/>
   
   <xsl:sequence select="f:curry(f:add(), 2, $arg1)"/>
 </xsl:function>

 <xsl:function name="f:add" as="item()">
   <xsl:param name="arg1" as="item()"/>
   <xsl:param name="arg2" as="item()"/>
   
   <xsl:sequence select="$arg1+$arg2"/>
 </xsl:function>
 
 
 <xsl:template match="f:subtract" mode="f:FXSL">
   <xsl:param name="arg1"/>
   <xsl:param name="arg2"/>
   
   <xsl:sequence select="f:subtract($arg1, $arg2)"/>
 </xsl:template>
 
 <xsl:function name="f:subtr" as="element()">
   <f:subtract/>
 </xsl:function>

 <xsl:function name="f:subtr" as="node()">
   <xsl:param name="arg1" as="item()"/>
   
   <xsl:sequence select="f:subtract($arg1)"/>
 </xsl:function>

 <xsl:function name="f:subtr" as="item()">
   <xsl:param name="arg1" as="item()"/>
   <xsl:param name="arg2" as="item()"/>
   
   <xsl:sequence select="f:subtract($arg1,$arg2)"/>
 </xsl:function>

 <xsl:function name="f:subtract" as="element()">
   <f:subtract/>
 </xsl:function>
 
 <xsl:function name="f:subtract" as="node()">
   <xsl:param name="arg1" as="item()"/>
   
   <xsl:sequence select="f:curry(f:subtract(), 2, $arg1)"/>
 </xsl:function>

 <xsl:function name="f:subtract" as="item()">
   <xsl:param name="arg1" as="item()"/>
   <xsl:param name="arg2" as="item()"/>
   
   <xsl:sequence select="$arg1 - $arg2"/>
 </xsl:function>


 <xsl:template match="f:multiply" mode="f:FXSL">
   <xsl:param name="arg1"/>
   <xsl:param name="arg2"/>
   
   <xsl:sequence select="f:multiply($arg1, $arg2)"/>
 </xsl:template>
 
 <xsl:function name="f:multiply" as="node()">
   <f:multiply/>
 </xsl:function>
 
 <xsl:function name="f:multiply" as="node()">
   <xsl:param name="arg1" as="item()"/>
   
   <xsl:sequence select="f:curry(f:multiply(), 2, $arg1)"/>
 </xsl:function>

 <xsl:function name="f:multiply" as="item()">
   <xsl:param name="arg1" as="item()"/>
   <xsl:param name="arg2" as="item()"/>
   
   <xsl:sequence select="$arg1*$arg2"/>
 </xsl:function>

  <xsl:function name="f:mult" as="element()">
   <xsl:sequence select="f:multiply()"/>
 </xsl:function>
 
 <xsl:function name="f:mult" as="node()">
   <xsl:param name="arg1" as="item()"/>
   
   <xsl:sequence select="f:multiply($arg1)"/>
 </xsl:function>

 <xsl:function name="f:mult" as="item()">
   <xsl:param name="arg1" as="item()"/>
   <xsl:param name="arg2" as="item()"/>
   
   <xsl:sequence select="f:multiply($arg1, $arg2)"/>
 </xsl:function>
 
  <xsl:template match="f:liftMult" mode="f:FXSL">
    <xsl:param name="arg1" as="node()"/>
    <xsl:param name="arg2" as="node()"/>
    <xsl:param name="arg3"/>
    
    <xsl:sequence select=
     "f:liftMult($arg1, $arg2, $arg3)"
     />
  </xsl:template>
  
  <xsl:function name="f:liftMult" as="item()">
    <xsl:param name="arg1" as="node()"/>
    <xsl:param name="arg2" as="node()"/>
    <xsl:param name="arg3"/>
    
    <xsl:sequence select=
     "f:apply($arg1, $arg3) * f:apply($arg2, $arg3)"
     />
  </xsl:function>
  
  <xsl:function name="f:liftMult" as="element()">
     <f:liftMult/>
  </xsl:function>

  <xsl:function name="f:liftMult" as="node()">
    <xsl:param name="arg1" as="node()"/>
    <xsl:param name="arg2" as="node()"/>
  
   <xsl:sequence select="f:curry(f:liftMult(), 3, $arg1, $arg2)"/>
  </xsl:function>
 
 
 <xsl:template match="f:div" mode="f:FXSL">
   <xsl:param name="arg1"/>
   <xsl:param name="arg2"/>
   
   <xsl:sequence select="f:div($arg1, $arg2)"/>
 </xsl:template>
 
 <xsl:function name="f:div" as="element()">
   <f:div/>
 </xsl:function>
 
 <xsl:function name="f:div" as="node()">
   <xsl:param name="arg1" as="item()"/>
   
   <xsl:sequence select="f:curry(f:div(), 2, $arg1)"/>
 </xsl:function>

 <xsl:function name="f:div" as="item()">
   <xsl:param name="arg1" as="item()"/>
   <xsl:param name="arg2" as="item()"/>
   
   <xsl:sequence select="$arg1 div $arg2"/>
 </xsl:function>

 
 <xsl:template match="f:idiv" mode="f:FXSL">
   <xsl:param name="arg1"/>
   <xsl:param name="arg2"/>
   
   <xsl:sequence select="f:idiv($arg1, $arg2)"/>
 </xsl:template>
 
 <xsl:function name="f:idiv" as="element()">
   <f:idiv/>
 </xsl:function>
 
 <xsl:function name="f:idiv" as="node()">
   <xsl:param name="arg1" as="item()"/>
   
   <xsl:sequence select="f:curry(f:idiv(), 2, $arg1)"/>
 </xsl:function>

 <xsl:function name="f:idiv" as="xs:integer">
   <xsl:param name="arg1" as="item()"/>
   <xsl:param name="arg2" as="item()"/>
   
   <xsl:sequence select="$arg1 idiv $arg2"/>
 </xsl:function>

 
 <xsl:template match="f:mod" mode="f:FXSL">
   <xsl:param name="arg1"/>
   <xsl:param name="arg2"/>
   
   <xsl:sequence select="f:mod($arg1, $arg2)"/>
 </xsl:template>
 
 <xsl:function name="f:mod" as="element()">
   <f:mod/>
 </xsl:function>
 
 <xsl:function name="f:mod" as="node()">
   <xsl:param name="arg1" as="item()"/>
   
   <xsl:sequence select="f:curry(f:mod(), 2, $arg1)"/>
 </xsl:function>

 <xsl:function name="f:mod" as="item()">
   <xsl:param name="arg1" as="item()"/>
   <xsl:param name="arg2" as="item()"/>
   
   <xsl:sequence select="$arg1 mod $arg2"/>
 </xsl:function>

<!--
       Value comparison operators: eq, ne, lt, le, gt, ge                          
-->

 
 <xsl:template match="f:eq" mode="f:FXSL">
   <xsl:param name="arg1"/>
   <xsl:param name="arg2"/>
   
   <xsl:sequence select="f:eq($arg1, $arg2)"/>
 </xsl:template>
 
 <xsl:function name="f:eq" as="element()">
   <f:eq/>
 </xsl:function>
 
 <xsl:function name="f:eq" as="node()">
   <xsl:param name="arg1" as="item()"/>
   
   <xsl:sequence select="f:curry(f:eq(), 2, $arg1)"/>
 </xsl:function>

 <xsl:function name="f:eq" as="xs:boolean">
   <xsl:param name="arg1" as="item()"/>
   <xsl:param name="arg2" as="item()"/>
   
   <xsl:sequence select="$arg1 eq $arg2"/>
 </xsl:function>

 
 <xsl:template match="f:ne" mode="f:FXSL">
   <xsl:param name="arg1"/>
   <xsl:param name="arg2"/>
   
   <xsl:sequence select="f:ne($arg1, $arg2)"/>
 </xsl:template>
 
 <xsl:function name="f:ne" as="element()">
   <f:ne/>
 </xsl:function>
 
 <xsl:function name="f:ne" as="node()">
   <xsl:param name="arg1" as="item()"/>
   
   <xsl:sequence select="f:curry(f:ne(), 2, $arg1)"/>
 </xsl:function>

 <xsl:function name="f:ne" as="xs:boolean">
   <xsl:param name="arg1" as="item()"/>
   <xsl:param name="arg2" as="item()"/>
   
   <xsl:sequence select="$arg1 ne $arg2"/>
 </xsl:function>

 
 <xsl:template match="f:lt" mode="f:FXSL">
   <xsl:param name="arg1"/>
   <xsl:param name="arg2"/>
   
   <xsl:sequence select="f:lt($arg1, $arg2)"/>
 </xsl:template>
 
 <xsl:function name="f:lt" as="element()">
   <f:lt/>
 </xsl:function>
 
 <xsl:function name="f:lt" as="node()">
   <xsl:param name="arg1" as="item()"/>
   
   <xsl:sequence select="f:curry(f:lt(), 2, $arg1)"/>
 </xsl:function>

 <xsl:function name="f:lt" as="xs:boolean">
   <xsl:param name="arg1" as="item()"/>
   <xsl:param name="arg2" as="item()"/>
   
   <xsl:sequence select="$arg1 lt $arg2"/>
 </xsl:function>

 
 <xsl:template match="f:le" mode="f:FXSL">
   <xsl:param name="arg1"/>
   <xsl:param name="arg2"/>
   
   <xsl:sequence select="f:le($arg1, $arg2)"/>
 </xsl:template>
 
 <xsl:function name="f:le" as="element()">
   <f:le/>
 </xsl:function>
 
 <xsl:function name="f:le" as="node()">
   <xsl:param name="arg1" as="item()"/>
   
   <xsl:sequence select="f:curry(f:le(), 2, $arg1)"/>
 </xsl:function>

 <xsl:function name="f:le" as="xs:boolean">
   <xsl:param name="arg1" as="item()"/>
   <xsl:param name="arg2" as="item()"/>
   
   <xsl:sequence select="$arg1 le $arg2"/>
 </xsl:function>

 
 <xsl:template match="f:gt" mode="f:FXSL">
   <xsl:param name="arg1"/>
   <xsl:param name="arg2"/>
   
   <xsl:sequence select="f:gt($arg1, $arg2)"/>
 </xsl:template>
 
 <xsl:function name="f:gt" as="element()">
   <f:gt/>
 </xsl:function>
 
 <xsl:function name="f:gt" as="node()">
   <xsl:param name="arg1" as="item()"/>
   
   <xsl:sequence select="f:curry(f:gt(), 2, $arg1)"/>
 </xsl:function>

 <xsl:function name="f:gt" as="xs:boolean">
   <xsl:param name="arg1" as="item()"/>
   <xsl:param name="arg2" as="item()"/>
   
   <xsl:sequence select="$arg1 gt $arg2"/>
 </xsl:function>

 
 <xsl:template match="f:ge" mode="f:FXSL">
   <xsl:param name="arg1"/>
   <xsl:param name="arg2"/>
   
   <xsl:sequence select="f:ge($arg1, $arg2)"/>
 </xsl:template>
 
 <xsl:function name="f:ge" as="element()">
   <f:ge/>
 </xsl:function>
 
 <xsl:function name="f:ge" as="node()">
   <xsl:param name="arg1" as="item()"/>
   
   <xsl:sequence select="f:curry(f:ge(), 2, $arg1)"/>
 </xsl:function>

 <xsl:function name="f:ge" as="xs:boolean">
   <xsl:param name="arg1" as="item()"/>
   <xsl:param name="arg2" as="item()"/>
   
   <xsl:sequence select="$arg1 ge $arg2"/>
 </xsl:function>

<!--
       General comparison operators: =, !=, <, <=, >, >=                          
-->

 
 <xsl:template match="f:g-eq" mode="f:FXSL">
   <xsl:param name="arg1"/>
   <xsl:param name="arg2"/>
   
   <xsl:sequence select="f:g-eq($arg1, $arg2)"/>
 </xsl:template>
 
 <xsl:function name="f:g-eq" as="element()">
   <f:g-eq/>
 </xsl:function>
 
 <xsl:function name="f:g-eq" as="node()">
   <xsl:param name="arg1" as="item()*"/>
   
   <xsl:sequence select="f:curry(f:g-eq(), 2, $arg1)"/>
 </xsl:function>

 <xsl:function name="f:g-eq" as="xs:boolean">
   <xsl:param name="arg1" as="item()*"/>
   <xsl:param name="arg2" as="item()*"/>
   
   <xsl:sequence select="$arg1 = $arg2"/>
 </xsl:function>

 
 <xsl:template match="f:g-ne" mode="f:FXSL">
   <xsl:param name="arg1"/>
   <xsl:param name="arg2"/>
   
   <xsl:sequence select="f:g-ne($arg1, $arg2)"/>
 </xsl:template>
 
 <xsl:function name="f:g-ne" as="element()">
   <f:g-ne/>
 </xsl:function>
 
 <xsl:function name="f:g-ne" as="node()">
   <xsl:param name="arg1" as="item()*"/>
   
   <xsl:sequence select="f:curry(f:g-ne(), 2, $arg1)"/>
 </xsl:function>

 <xsl:function name="f:g-ne" as="xs:boolean">
   <xsl:param name="arg1" as="item()*"/>
   <xsl:param name="arg2" as="item()*"/>
   
   <xsl:sequence select="$arg1 != $arg2"/>
 </xsl:function>

 
 <xsl:template match="f:g-lt" mode="f:FXSL">
   <xsl:param name="arg1"/>
   <xsl:param name="arg2"/>
   
   <xsl:sequence select="f:g-lt($arg1, $arg2)"/>
 </xsl:template>
 
 <xsl:function name="f:g-lt" as="element()">
   <f:g-lt/>
 </xsl:function>
 
 <xsl:function name="f:g-lt" as="node()">
   <xsl:param name="arg1" as="item()*"/>
   
   <xsl:sequence select="f:curry(f:g-lt(), 2, $arg1)"/>
 </xsl:function>

 <xsl:function name="f:g-lt" as="xs:boolean">
   <xsl:param name="arg1" as="item()*"/>
   <xsl:param name="arg2" as="item()*"/>
   
   <xsl:sequence select="$arg1 &lt; $arg2"/>
 </xsl:function>

 
 <xsl:template match="f:g-le" mode="f:FXSL">
   <xsl:param name="arg1"/>
   <xsl:param name="arg2"/>
   
   <xsl:sequence select="f:g-le($arg1, $arg2)"/>
 </xsl:template>
 
 <xsl:function name="f:g-le" as="element()">
   <f:g-le/>
 </xsl:function>
 
 <xsl:function name="f:g-le" as="node()">
   <xsl:param name="arg1" as="item()*"/>
   
   <xsl:sequence select="f:curry(f:g-le(), 2, $arg1)"/>
 </xsl:function>

 <xsl:function name="f:g-le" as="xs:boolean">
   <xsl:param name="arg1" as="item()*"/>
   <xsl:param name="arg2" as="item()*"/>
   
   <xsl:sequence select="$arg1 &lt;= $arg2"/>
 </xsl:function>

 
 <xsl:template match="f:g-gt" mode="f:FXSL">
   <xsl:param name="arg1"/>
   <xsl:param name="arg2"/>
   
   <xsl:sequence select="f:g-gt($arg1, $arg2)"/>
 </xsl:template>
 
 <xsl:function name="f:g-gt" as="element()">
   <f:g-gt/>
 </xsl:function>
 
 <xsl:function name="f:g-gt" as="node()">
   <xsl:param name="arg1" as="item()*"/>
   
   <xsl:sequence select="f:curry(f:g-gt(), 2, $arg1)"/>
 </xsl:function>

 <xsl:function name="f:g-gt" as="xs:boolean">
   <xsl:param name="arg1" as="item()*"/>
   <xsl:param name="arg2" as="item()*"/>
   
   <xsl:sequence select="$arg1 > $arg2"/>
 </xsl:function>

 
 <xsl:template match="f:g-ge" mode="f:FXSL">
   <xsl:param name="arg1"/>
   <xsl:param name="arg2"/>
   
   <xsl:sequence select="f:g-ge($arg1, $arg2)"/>
 </xsl:template>
 
 <xsl:function name="f:g-ge" as="element()">
   <f:g-ge/>
 </xsl:function>
 
 <xsl:function name="f:g-ge" as="node()">
   <xsl:param name="arg1" as="item()*"/>
   
   <xsl:sequence select="f:curry(f:g-ge(), 2, $arg1)"/>
 </xsl:function>

 <xsl:function name="f:g-ge" as="xs:boolean">
   <xsl:param name="arg1" as="item()*"/>
   <xsl:param name="arg2" as="item()*"/>
   
   <xsl:sequence select="$arg1 >= $arg2"/>
 </xsl:function>
 
<!--
       Node identity/ordering operators: is, <<, >>                          
-->
 
 <xsl:template match="f:is" mode="f:FXSL">
   <xsl:param name="arg1"/>
   <xsl:param name="arg2"/>
   
   <xsl:sequence select="f:is($arg1, $arg2)"/>
 </xsl:template>
 
 <xsl:function name="f:is" as="element()">
   <f:is/>
 </xsl:function>
 
 <xsl:function name="f:is" as="xs:boolean">
   <xsl:param name="arg1" as="node()?"/>
   <xsl:param name="arg2" as="node()?"/>
   
   <xsl:sequence select="$arg1 is $arg2"/>
 </xsl:function>
 
 
 <xsl:template match="f:prec" mode="f:FXSL">
   <xsl:param name="arg1"/>
   <xsl:param name="arg2"/>
   
   <xsl:sequence select="f:prec($arg1, $arg2)"/>
 </xsl:template>
 
 <xsl:function name="f:prec" as="element()">
   <f:prec/>
 </xsl:function>
 
 <xsl:function name="f:prec" as="xs:boolean">
   <xsl:param name="arg1" as="node()?"/>
   <xsl:param name="arg2" as="node()?"/>
   
   <xsl:sequence select="$arg1 &lt;&lt; $arg2"/>
 </xsl:function>
 
 
 <xsl:template match="f:succ" mode="f:FXSL">
   <xsl:param name="arg1"/>
   <xsl:param name="arg2"/>
   
   <xsl:sequence select="f:succ($arg1, $arg2)"/>
 </xsl:template>
 
 <xsl:function name="f:succ" as="element()">
   <f:succ/>
 </xsl:function>
 
 <xsl:function name="f:succ" as="xs:boolean">
   <xsl:param name="arg1" as="node()?"/>
   <xsl:param name="arg2" as="node()?"/>
   
   <xsl:sequence select="$arg1 >> $arg2"/>
 </xsl:function>

<!--
       Boolean operators: and, or                              
-->
 
 <xsl:template match="f:and" mode="f:FXSL">
   <xsl:param name="arg1"/>
   <xsl:param name="arg2"/>
   
   <xsl:sequence select="f:and($arg1, $arg2)"/>
 </xsl:template>
 
 <xsl:function name="f:and" as="element()">
   <f:and/>
 </xsl:function>
 
 <xsl:function name="f:and" as="node()">
   <xsl:param name="arg1" as="item()*"/>
   
   <xsl:sequence select="f:curry(f:and(), 2, $arg1)"/>
 </xsl:function>

 <xsl:function name="f:and" as="xs:boolean">
   <xsl:param name="arg1" as="item()*"/>
   <xsl:param name="arg2" as="item()*"/>
   
   <xsl:sequence select="$arg1 and $arg2"/>
 </xsl:function>
 
 
 <xsl:template match="f:or" mode="f:FXSL">
   <xsl:param name="arg1"/>
   <xsl:param name="arg2"/>
   
   <xsl:sequence select="f:or($arg1, $arg2)"/>
 </xsl:template>
 
 <xsl:function name="f:or" as="element()">
   <f:or/>
 </xsl:function>
 
 <xsl:function name="f:or" as="node()">
   <xsl:param name="arg1" as="item()*"/>
   
   <xsl:sequence select="f:curry(f:or(), 2, $arg1)"/>
 </xsl:function>

 <xsl:function name="f:or" as="xs:boolean">
   <xsl:param name="arg1" as="item()*"/>
   <xsl:param name="arg2" as="item()*"/>
   
   <xsl:sequence select="$arg1 or $arg2"/>
 </xsl:function>
 
</xsl:stylesheet>