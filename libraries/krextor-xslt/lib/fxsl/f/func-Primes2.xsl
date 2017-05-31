<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:saxon="http://saxon.sf.net/"
 xmlns:gexslt="http://www.gobosoft.com/eiffel/gobo/gexslt/extension"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="xs saxon f gexslt" 
 >
  <xsl:import href="func-sqrt.xsl"/>

 <xsl:output method="text"/>
 
  <xsl:template match="/*">
   <xsl:value-of select="f:allPrimes(100000)" separator="&#xA;"/>
  </xsl:template>
  
  <xsl:function name="f:isPrime" as="xs:boolean"  saxon:memo-function="yes" gexslt:memo-function="yes">
    <xsl:param name="pNum" />
    
    <xsl:variable name="vstrNum" select="string($pNum)" as="xs:string"/>
    <xsl:variable name="vLastDigit" 
                  select="substring($vstrNum, string-length($vstrNum))"/>
                  
    
    <xsl:value-of select=
           "if(not(translate($vLastDigit, '024568', '')) )
               then false()
               else
                empty(
                      (f:allPrimes(xs:integer(round(f:sqrt($pNum, 0.1E0)))))
                                                           [f:divisor(., $pNum)]
                       )
            "/>

  </xsl:function>

  <xsl:function name="f:allPrimes" as="xs:integer*"  saxon:memo-function="yes" gexslt:memo-function="yes">
    <xsl:param name="pN" as="xs:integer"/>
    <xsl:sequence select="(2,3,5,7)[. le $pN], ((11 to $pN)[f:isPrime(.)])"/> 
  </xsl:function>

  
  <xsl:function name="f:divisor" as="xs:boolean"  saxon:memo-function="yes" gexslt:memo-function="yes">
    <xsl:param name="pK" as="xs:integer"/>
    <xsl:param name="pN" as="xs:integer"/>
    
    <xsl:sequence select="$pN mod $pK = 0"/>
  </xsl:function>
</xsl:stylesheet>