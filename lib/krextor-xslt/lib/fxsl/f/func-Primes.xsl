<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:saxon="http://saxon.sf.net/"
 xmlns:gexslt="http://www.gobosoft.com/eiffel/gobo/gexslt/extension"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="xs saxon f" 
 >
  <xsl:import href="func-sqrt.xsl"/>

 <xsl:output method="text"/>

  <xsl:function name="f:isPrime" as="xs:boolean" saxon:memo-function="yes" gexslt:memo-function="yes">
    <xsl:param name="pNum" />
    
    <xsl:variable name="vstrNum" select="string($pNum)" as="xs:string"/>
    <xsl:variable name="vLastDigit" 
                  select="substring($vstrNum, string-length($vstrNum))"/>
                  
    <xsl:value-of select=
           "if(not(translate($vLastDigit, '024568', '')) )
               then false()
               else
                 if(f:pow2mod($pNum - 1, $pNum) ne 1)
                   then false()
                   else
		                empty(
		                   (3, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41,
		                     (43 to xs:integer(round(f:sqrt($pNum, 0.1E0)))) )
                                                       [f:divisor(., $pNum)]
		                       )
            "/>
  </xsl:function>

<!--
    f:pow2mod(K, N) = 2^K mod N
-->  
  <xsl:function name="f:pow2mod" as="xs:integer">
    <xsl:param name="pE" as="xs:integer"/>
    <xsl:param name="pN" as="xs:integer"/>
    
    <xsl:sequence select=
     "if($pE eq 1)
       then 2
       else
         for $half in f:pow2mod($pE idiv 2, $pN)
           return
              $half * $half * (1 + ($pE mod 2)) mod $pN
          
     "/>
  </xsl:function>

  <xsl:function name="f:allPrimes" as="xs:integer*" >
    <xsl:param name="pN" as="xs:integer"/>
    <xsl:sequence select="(2,3,5,7)[. le $pN], ((11 to $pN)[f:isPrime(.)])"/> 
  </xsl:function>
  
  <xsl:function name="f:divisor" as="xs:boolean"  saxon:memo-function="yes" gexslt:memo-function="yes">
    <xsl:param name="pK" as="xs:integer"/>
    <xsl:param name="pN" as="xs:integer"/>
    
    <xsl:sequence select="$pN mod $pK = 0"/>
  </xsl:function>
</xsl:stylesheet>