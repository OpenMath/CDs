<xsl:stylesheet version="2.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f"
>
  <xsl:import href="func-apply.xsl"/>
  <xsl:import href="func-curry.xsl"/>
  
 <xsl:template match="f:lift2" mode="f:FXSL">
   <xsl:param name="arg1" as="element()"/>
   <xsl:param name="arg2" as="element()"/>
   <xsl:param name="arg3" as="element()"/>
   <xsl:param name="arg4"/>
   
   <xsl:sequence select="f:lift2($arg1,$arg2,$arg3,$arg4)"/>
 </xsl:template>

  <xsl:function name="f:lift2" as="element()">
     <f:lift2/>
  </xsl:function>

 <xsl:function name="f:lift2" as="element()">
   <xsl:param name="arg1" as="element()"/>
   
   <xsl:sequence select="f:curry(f:lift2(),4,$arg1)"/>
 </xsl:function>

 <xsl:function name="f:lift2" as="element()">
   <xsl:param name="arg1" as="element()"/>
   <xsl:param name="arg2" as="element()"/>
   
   <xsl:sequence select="f:curry(f:lift2(),4,$arg1,$arg2)"/>
 </xsl:function>

 <xsl:function name="f:lift2" as="element()">
   <xsl:param name="arg1" as="element()"/>
   <xsl:param name="arg2" as="element()"/>
   <xsl:param name="arg3" as="element()"/>
   
   <xsl:sequence select="f:curry(f:lift2(),4,$arg1,$arg2,$arg3)"/>
 </xsl:function>

  <xsl:function name="f:lift2">
    <xsl:param name="pMainFun" as="element()"/>
    <xsl:param name="pFun1" as="element()"/>
    <xsl:param name="pFun2" as="element()"/>
    <xsl:param name="ptheArg"/>
    
    <xsl:sequence select=
     "f:apply($pMainFun, f:apply($pFun1, $ptheArg), f:apply($pFun2, $ptheArg))"
    />
  </xsl:function>

 <xsl:template match="f:lift3" mode="f:FXSL">
   <xsl:param name="arg1" as="element()"/>
   <xsl:param name="arg2" as="element()"/>
   <xsl:param name="arg3" as="element()"/>
   <xsl:param name="arg4" as="element()"/>
   <xsl:param name="arg5"/>
   
   <xsl:sequence select="f:lift3($arg1,$arg2,$arg3,$arg4,$arg5)"/>
 </xsl:template>

  <xsl:function name="f:lift3" as="element()">
     <f:lift3/>
  </xsl:function>

 <xsl:function name="f:lift3" as="element()">
   <xsl:param name="arg1" as="element()"/>
   
   <xsl:sequence select="f:curry(f:lift3(),5,$arg1)"/>
 </xsl:function>

 <xsl:function name="f:lift3" as="element()">
   <xsl:param name="arg1" as="element()"/>
   <xsl:param name="arg2" as="element()"/>
   
   <xsl:sequence select="f:curry(f:lift3(),5,$arg1,$arg2)"/>
 </xsl:function>

 <xsl:function name="f:lift3" as="element()">
   <xsl:param name="arg1" as="element()"/>
   <xsl:param name="arg2" as="element()"/>
   <xsl:param name="arg3" as="element()"/>
   
   <xsl:sequence select="f:curry(f:lift3(),5,$arg1,$arg2,$arg3)"/>
 </xsl:function>

 <xsl:function name="f:lift3" as="element()">
   <xsl:param name="arg1" as="element()"/>
   <xsl:param name="arg2" as="element()"/>
   <xsl:param name="arg3" as="element()"/>
   <xsl:param name="arg4" as="element()"/>
   
   <xsl:sequence select="f:curry(f:lift3(),5,$arg1,$arg2,$arg3,$arg4)"/>
 </xsl:function>

  <xsl:function name="f:lift3">
    <xsl:param name="pMainFun" as="element()"/>
    <xsl:param name="pFun1" as="element()"/>
    <xsl:param name="pFun2" as="element()"/>
    <xsl:param name="pFun3" as="element()"/>
    <xsl:param name="ptheArg"/>
    
    <xsl:sequence select=
     "f:apply($pMainFun, 
              f:apply($pFun1, $ptheArg), 
              f:apply($pFun2, $ptheArg),
              f:apply($pFun3, $ptheArg)
              )"
    />
  </xsl:function>

 <xsl:template match="f:lift4" mode="f:FXSL">
   <xsl:param name="arg1" as="element()"/>
   <xsl:param name="arg2" as="element()"/>
   <xsl:param name="arg3" as="element()"/>
   <xsl:param name="arg4" as="element()"/>
   <xsl:param name="arg5" as="element()"/>
   <xsl:param name="arg6"/>
   
   <xsl:sequence select="f:lift4($arg1,$arg2,$arg3,$arg4,$arg5, $arg6)"/>
 </xsl:template>

  <xsl:function name="f:lift4" as="element()">
     <f:lift4/>
  </xsl:function>

 <xsl:function name="f:lift4" as="element()">
   <xsl:param name="arg1" as="element()"/>
   
   <xsl:sequence select="f:curry(f:lift4(),6,$arg1)"/>
 </xsl:function>

 <xsl:function name="f:lift4" as="element()">
   <xsl:param name="arg1" as="element()"/>
   <xsl:param name="arg2" as="element()"/>
   
   <xsl:sequence select="f:curry(f:lift4(),6,$arg1,$arg2)"/>
 </xsl:function>

 <xsl:function name="f:lift4" as="element()">
   <xsl:param name="arg1" as="element()"/>
   <xsl:param name="arg2" as="element()"/>
   <xsl:param name="arg3" as="element()"/>
   
   <xsl:sequence select="f:curry(f:lift4(),6,$arg1,$arg2,$arg3)"/>
 </xsl:function>

 <xsl:function name="f:lift4" as="element()">
   <xsl:param name="arg1" as="element()"/>
   <xsl:param name="arg2" as="element()"/>
   <xsl:param name="arg3" as="element()"/>
   <xsl:param name="arg4" as="element()"/>
   
   <xsl:sequence select="f:curry(f:lift4(),6,$arg1,$arg2,$arg3,$arg4)"/>
 </xsl:function>

 <xsl:function name="f:lift4" as="element()">
   <xsl:param name="arg1" as="element()"/>
   <xsl:param name="arg2" as="element()"/>
   <xsl:param name="arg3" as="element()"/>
   <xsl:param name="arg4" as="element()"/>
   <xsl:param name="arg5" as="element()"/>
   
   <xsl:sequence select="f:curry(f:lift4(),6,$arg1,$arg2,$arg3,$arg4,$arg5)"/>
 </xsl:function>

  <xsl:function name="f:lift4">
    <xsl:param name="pMainFun" as="element()"/>
    <xsl:param name="pFun1" as="element()"/>
    <xsl:param name="pFun2" as="element()"/>
    <xsl:param name="pFun3" as="element()"/>
    <xsl:param name="pFun4" as="element()"/>
    <xsl:param name="ptheArg"/>
    
    <xsl:sequence select=
     "f:apply($pMainFun, 
              f:apply($pFun1, $ptheArg), 
              f:apply($pFun2, $ptheArg),
              f:apply($pFun3, $ptheArg),
              f:apply($pFun4, $ptheArg)
              )"
    />
  </xsl:function>

</xsl:stylesheet>