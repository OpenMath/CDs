<!--
===========================================================================
 Stylesheet: iter.xsl       General Iteration of a Function                
    Version: 1.0 (2002-03-16)                                              
     Author: Dimitre Novatchev                                             
     Notice: Copyright (c)2002 D.Novatchev  ALL RIGHTS RESERVED.           
             No limitation on use - except this code may not be published, 
             in whole or in part, without prior written consent of the     
             copyright owner.                                              
===========================================================================-->
<xsl:stylesheet version="2.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f xs"
 >
 <xsl:import href="func-apply.xsl"/>

  
<!-- reference to Iter-->  
  <f:iter/>

<!--
 f:iter() - convenience function,                                            
                returns a reference to f:iter()                                  
                when called with no arguments                                
-->  
  <xsl:function name="f:iter" as="node()">
    <xsl:sequence select="document('')/*/f:iter[1]"/>
  </xsl:function>

  <xsl:template match="f:iter" mode="f:FXSL">
    <xsl:param name="pTimes" as="xs:integer"/>
    <xsl:param name="pFun" as="element()"/>
    <xsl:param name="pX" />
    
    <xsl:sequence select="f:iter(pTimes, pFun, pX)"/>  
  </xsl:template>

<!--
===========================================================================
       this implements functional power composition,                       
       that is f(f(...f(x)))))...)                                         
                                                                           
       f composed with itself n - 1 times                                  
                                                                           
       The corresponding Haskell code is:                                  
        > iter :: (Ord a, Num a) => a -> (b -> b) -> b -> b                
        > iter n f                                                         
        >    | n > 0     = f . iter (n-1) f                                
        >    | otherwise = id                                              
===========================================================================-->
<!--
    Function: iter($pTimes, $pFun, $pX)                                      
     Purpose: Iterate (compose a function with itself) N times               
  Parameters:-                                                               
    $pTimes - number of times to iterate                                     
    $pFun   - a template reference to the function that's to be iterated     
    $pX     - an initial argument to the function                            
  ========================================================================== -->

  <xsl:function name="f:iter">
    <xsl:param name="pTimes" as="xs:integer"/>
    <xsl:param name="pFun" as="element()"/>
    <xsl:param name="pX" />
    
    <xsl:sequence select=
     "if($pTimes = 0)
        then
          $pX
        else
          if($pTimes = 1)
            then
              f:apply($pFun, $pX)
            else
              if($pTimes > 1)
                then
                  for $vHalfTimes in $pTimes idiv 2 return
                    f:iter($pTimes - $vHalfTimes, 
                           $pFun, 
                            f:iter($vHalfTimes, $pFun, $pX)
                           )
                else
                  error((),'[iter]Error: the $pTimes argument must be
                      a positive integer or 0.')"
    />
  </xsl:function>

<!-- reference to Iter-->  
  <f:iterUntil/>

<!--
 f:iterUntil() - convenience function,                                            
                returns a reference to f:iterUntil()                                  
                when called with no arguments                                
-->  
  <xsl:function name="f:iterUntil" as="node()">
    <xsl:sequence select="document('')/*/f:iterUntil[1]"/>
  </xsl:function>

  <xsl:template match="f:iterUntil" mode="f:FXSL">
    <xsl:param name="pCond" as="element()"/>
    <xsl:param name="pFun" as="element()"/>
    <xsl:param name="arg1" />
    
    <xsl:sequence select="f:iterUntil(pCond, pFun, arg1)"/>  
  </xsl:template>

<!--
===========================================================================
       This is a variation of the iter function.                           
       Iterations are performed only while the predicate p                 
       is true on the argument of the iteration                            
===========================================================================-->
<!--
    Function: iterUntil                                                      
     Purpose: Iterate (compose a function with itself)                       
              until a condition is satisfied                                 
  Parameters:-                                                               
    $pCond  - a template reference to a predicate that tests                 
              the iteration stop-condition. Returns 0 or 1                   
    $pFun   - a template reference to the function that's to be iterated     
    $arg1   - an initial argument to the function                            
  ========================================================================== -->
   <xsl:function name="f:iterUntil">
    <xsl:param name="pCond" as="element()"/>
    <xsl:param name="pFun" as="element()"/>
    <xsl:param name="arg1" />

    <xsl:variable name="vFunResult" 
         select="f:apply($pFun, $arg1)"/>
    <xsl:sequence select=
     "if(xs:boolean(f:apply($pCond, $vFunResult)))
         then
           $vFunResult
         else
           f:iterUntil($pCond, $pFun, $vFunResult)"
     />
  </xsl:function>
  
<!-- reference to scanIter-->  
  <f:scanIter/>

<!--
 f:scanIter() - convenience function,                                            
                returns a reference to f:scanIter()                                  
                when called with no arguments                                
-->  
  <xsl:function name="f:scanIter" as="node()">
    <xsl:sequence select="document('')/*/f:scanIter[1]"/>
  </xsl:function>

  <xsl:template match="f:scanIter" mode="f:FXSL">
    <xsl:param name="arg1" as="xs:integer"/> <!-- n -->
    <xsl:param name="arg2" as="element()"/>  <!-- f -->
    <xsl:param name="arg3"/>                 <!-- x -->
    
    <xsl:sequence select="f:scanIter(arg1, arg2, arg3)"/>  
  </xsl:template>

<!--
  This function implements the scanIter function                            
  defined in Haskell as:                                                    
                                                                            
  > scanIter :: (Ord a, Num a) => a -> (b -> b) -> b -> [b]                 
  > scanIter n f x                                                          
  >    | n == 0  = [x]                                                      
  >    | n > 0   = result ++ [f(last result)]                               
  >                  where result = scanIter (n-1) f x                      
  ==========================================================================-->

  
<!--
    Function: scanIter                                                      
     Purpose: Iterate (compose a function with itself) N times              
              and produce a list, whose elements are the results            
              from the partial iterations                                   
  Parameters:-                                                              
    $arg1   - the number of times to iterate                                
    $arg2   - a template reference to the function that's to be iterated    
    $arg3   - an initial argument to the function                           
  ==========================================================================-->
  <xsl:function name="f:scanIter" as="item()*">
    <xsl:param name="arg1" as="xs:integer"/> <!-- n -->
    <xsl:param name="arg2" as="element()"/>  <!-- f -->
    <xsl:param name="arg3"/>                 <!-- x -->

    <xsl:choose>
      <xsl:when test="$arg1 > 0">
         <xsl:variable name="vIterMinus" 
                       select="f:scanIter($arg1 - 1, $arg2, $arg3)"/>
         <xsl:sequence select=
          "$vIterMinus, f:apply($arg2, $vIterMinus[last()])"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:sequence select=
         "if($arg1 = 0) then $arg3
            else error((),'[scanIter]Error: Negative value for n.')"
         />
      </xsl:otherwise> 
    </xsl:choose>
  </xsl:function>

  <xsl:function name="f:scanIterDVC" as="item()*">
    <xsl:param name="arg1" as="xs:integer"/> <!-- n -->
    <xsl:param name="arg2" as="element()"/>  <!-- f -->
    <xsl:param name="arg3"/>                 <!-- x -->
    
    <xsl:choose>
      <xsl:when test="$arg1 eq 0">
        <xsl:sequence select="$arg3"/>
      </xsl:when>
      <xsl:when test="$arg1 eq 1">
        <xsl:sequence select="f:apply($arg2, $arg3)"/>
      </xsl:when>
      <xsl:when test="$arg1 gt 1">
         <xsl:variable name="vHalfTimes" as="xs:integer" select=
          "$arg1 idiv 2"/>
          
         <xsl:variable name="vFirstResult" select=
          "f:scanIterDVC($vHalfTimes, $arg2, $arg3)"
          />
          
          <xsl:sequence select=
           "$vFirstResult,
            f:scanIterDVC($arg1 - $vHalfTimes, 
                          $arg2, 
                          $vFirstResult[last()]
                          )
           "
           />
      </xsl:when>
      <xsl:otherwise>
        <xsl:sequence select=
         "error((),'[scanIter]Error: Negative value for n.')"
         />
      </xsl:otherwise> 
    </xsl:choose>
</xsl:function>
</xsl:stylesheet>