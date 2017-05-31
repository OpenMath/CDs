<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="xs f"
>

 <xsl:import href="func-Operators.xsl"/>
 <xsl:import href="func-map.xsl"/>
 <xsl:import href="func-flip.xsl"/>
 <xsl:import href="func-pick.xsl"/>
 
 <xsl:function name="f:qsort" as="item()*">
   <xsl:param name="pSeq" as="item()*"/>
    
   <xsl:if test="exists($pSeq)">
     <xsl:variable name="v1st" select="$pSeq[1]"/>
      
     <xsl:variable name="vTail" select="remove($pSeq, 1)" as="item()*"/>
      
     <xsl:sequence select=
      "f:qsort(f:map( f:flip( f:pick(),f:g-ge($v1st) ),  
                     $vTail
                     )
               ),
                           
       $v1st,
                           
       f:qsort(f:map( f:flip( f:pick(),f:g-lt($v1st) ),  
                      $vTail
                     )                                   
               )
      "/>
   </xsl:if>
 </xsl:function>
</xsl:stylesheet>