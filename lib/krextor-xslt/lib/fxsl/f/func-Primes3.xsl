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
 
  <xsl:template match="/*">
   <!--<xsl:value-of select="f:isPrime(7427466391)" separator="&#xA;"/>-->
   <xsl:value-of select="f:allPrimes(100000)" separator="&#xA;"/>
  </xsl:template>
  
  <xsl:function name="f:isPrime" as="xs:integer+" gexslt:memo-function="yes" saxon:memo-function="yes">
    <xsl:param name="pNum" as="xs:integer" />
    
    <xsl:sequence select="f:isPrime($pNum, (2,3,5,7,11))"/>
 </xsl:function>   
    
  <xsl:function name="f:isPrime" as="xs:integer+"  gexslt:memo-function="yes" saxon:memo-function="yes">
    <xsl:param name="pNum" as="xs:integer" />
    <xsl:param name="pknownPrimes" as="xs:integer*" />
    
    <xsl:variable name="vstrNum" select="string($pNum)" as="xs:string"/>
    <xsl:variable name="vLastDigit" 
                  select="substring($vstrNum, string-length($vstrNum))"/>
                  
    
    <xsl:choose>
      <xsl:when test="not(translate($vLastDigit, '024568', ''))">
        <xsl:sequence select="(0,$pknownPrimes)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="vneededPrimes" as="xs:integer+" select=
        "f:allPrimes(xs:integer(round(f:sqrt($pNum, 0.1E0))), $pknownPrimes)"/>
        
        <xsl:sequence select=
         "xs:integer(empty($vneededPrimes[f:divisor(., $pNum)])),
          if(count($vneededPrimes) ge count($pknownPrimes))
            then $vneededPrimes
            else $pknownPrimes
         "/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>
  
  <xsl:function name="f:allPrimes" as="xs:integer+" gexslt:memo-function="yes"  saxon:memo-function="yes">
    <xsl:param name="pN" as="xs:integer"/>
    
    <xsl:sequence select="f:allPrimes($pN, (2,3,5,7,11))"/>
  </xsl:function>


  <xsl:function name="f:allPrimes" as="xs:integer+"  gexslt:memo-function="yes" saxon:memo-function="yes">
    <xsl:param name="pN" as="xs:integer"/>
    <xsl:param name="pKnownPrimes" as="xs:integer+"/>
    
    <xsl:variable name="vSqrt" as="xs:integer" 
                  select="xs:integer(round(f:sqrt($pN, 0.1E0)))"/>
    <xsl:variable name="vneededPrimes" as="xs:integer+" 
    select="if($vSqrt le $pKnownPrimes[last()])
               then $pKnownPrimes[. le $vSqrt]
               else
                  f:allPrimes($vSqrt, $pKnownPrimes)
            "/>
    
    <xsl:sequence select=
    "( $vneededPrimes, 
      (for $k in ($vSqrt to $pN) return
        $k[empty($vneededPrimes[f:divisor(., $k)])]
       )
     )"/> 
  </xsl:function>

  
  <xsl:function name="f:divisor" as="xs:boolean"  gexslt:memo-function="yes" saxon:memo-function="yes">
    <xsl:param name="pK" as="xs:integer"/>
    <xsl:param name="pN" as="xs:integer"/>
    
    <xsl:sequence select="$pN mod $pK = 0"/>
  </xsl:function>
</xsl:stylesheet>
