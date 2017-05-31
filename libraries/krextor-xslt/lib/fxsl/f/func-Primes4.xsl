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
 
 <xsl:variable name="vE" select=
 "concat('2.71828182845904523536',
         '02874713526624977572470',
         '93699959574966967627724',
         '07663035354759457138217',
         '8525166429320',
         '03059921817413596629043',
         '57290033429526059563073',
         '81323286279434907632338',
         '29880753195251019011573',
         '83418793070215408914993',
         '48841675092447614606680',
         '82264800168477411853742',
         '34544243710753907774499',
         '20695517027618'
 )"/>

  <xsl:template match="/*">

<!--
    <xsl:variable name="vPortions" 
    select="for $n in 3 to string-length($vE)-9
                    return(substring($vE, $n, 10))
           "/>

   <xsl:value-of select="$vPortions[f:isPrime(xs:integer(.))][1]"/>

   <xsl:value-of select="f:isPrime(7427466391)"/>
-->
   <xsl:value-of select="f:isPrime(111111)"/>

  </xsl:template>
  
  <xsl:function name="f:isPrime" as="xs:boolean" gexslt:memo-function="yes" saxon:memo-function="yes">
    <xsl:param name="pNum" />
    
    <xsl:variable name="vstrNum" select="string($pNum)" as="xs:string"/>
    <xsl:variable name="vLastDigit" 
                  select="substring($vstrNum, string-length($vstrNum))"/>
                  
    
    <xsl:value-of select=
           "if(not(translate($vLastDigit, '024568', '')) )
               then false()
               else
                empty(
                      f:allPrimes(xs:integer(round(f:sqrt($pNum,0.1))))[f:divisor(., $pNum)]
                       )
            "/>

  </xsl:function>

  <xsl:function name="f:allPrimes" as="xs:integer*">
    <xsl:param name="pN" as="xs:integer"/>
    <xsl:sequence select="if($pN = 2)
                             then 2
                             else if($pN > 2)
                                     then (f:allPrimes($pN -1), $pN[f:isPrime(.)])
                                     else ()
                                  "/> 
  </xsl:function>

  
  <xsl:function name="f:divisor" as="xs:boolean"  gexslt:memo-function="yes" saxon:memo-function="yes">
    <xsl:param name="pK" as="xs:integer"/>
    <xsl:param name="pN" as="xs:integer"/>
    
    <xsl:sequence select="$pN mod $pK = 0"/>
  </xsl:function>
</xsl:stylesheet>
