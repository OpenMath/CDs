<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="xs f"
>

 <xsl:import href="func-map.xsl"/>
 <xsl:import href="func-flip.xsl"/>

<!--
       XSLT functions:                                                    
                     xsltSort()                                               
-->

 <xsl:function name="f:xsltSort" as="item()*">
   <xsl:param name="pSeq" as="item()*"/>
   <xsl:param name="pCriteria" as="node()*"/>
   
   <xsl:perform-sort select="$pSeq">
     <xsl:sort select=
		  "string-join(
		              f:map(f:flip(f:map(), .), $pCriteria) 
						      ,
						      ''
							    )
      "
     />
   </xsl:perform-sort>
 </xsl:function> 

</xsl:stylesheet>