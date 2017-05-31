<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:f="http://fxsl.sf.net/"
  xmlns:myIncrement="f:myIncrement" 
  exclude-result-prefixes="f xs myIncrement" 
 >
 
 <xsl:import href="func-iter.xsl"/>
  
  <xsl:function name="f:arithmetic-progression">
    <xsl:param name="pFrom" as="xs:double"/>
    <xsl:param name="pTo" as="xs:double"/>
    <xsl:param name="pIncr" as="xs:double"/>
    
    <xsl:if test="$pIncr != 0">    
      <xsl:variable name="vFunIncr" 
           select="document('')/*/myIncrement:*[1]"/>
      
      <xsl:variable name="vRange" as="xs:integer"
           select="xs:integer(floor(($pTo - $pFrom) div $pIncr))"/>
      
        <xsl:for-each select=
        "f:scanIter($vRange, $vFunIncr, $pFrom)">
         
           <xsl:sequence select="$pFrom + (. - $pFrom)*$pIncr"/>
        </xsl:for-each>
    </xsl:if>
   </xsl:function>
   
   <myIncrement:myIncrement/>
   <xsl:template match="myIncrement:*" mode="f:FXSL">
     <xsl:param name="arg1"/>
       <xsl:value-of select="$arg1 + 1"/>
   </xsl:template>

</xsl:stylesheet>