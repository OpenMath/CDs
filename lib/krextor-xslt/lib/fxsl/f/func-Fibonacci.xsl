<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:saxon="http://saxon.sf.net/"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f xs saxon"
 >
  
 <xsl:function name="f:fiboLimitedSeq" as="xs:integer*">
   <xsl:param name="pLimit" as="xs:double"/>
   <xsl:param name="pN"  as="xs:integer"/>
   
   <xsl:variable name="vVal" select="f:fibo($pN)"/>
   
   <xsl:if test="$vVal le $pLimit" >
     <xsl:sequence select=
     "$vVal, f:fiboLimitedSeq($pLimit, $pN+1)"
     />
   </xsl:if>
 </xsl:function>

 <xsl:function name="f:fibo" as="xs:integer" >
   <xsl:param name="pN" as="xs:integer"/>
   
   <xsl:sequence select=
    "if ($pN gt 10)
        then
          if($pN mod 2 = 0)
            then
               for $i in $pN idiv 2,
			             $fi in f:fibo($i),
			             $fi-1 in f:fibo($i -1)
			               return $fi*$fi + $fi-1*$fi-1
			      else
			         for $i in ($pN -1) idiv 2,
			             $fi in f:fibo($i),
			             $fi-1 in f:fibo($i -1)
			               return (2*$fi-1 + $fi) * $fi
			  else
			    (1,1,2,3,5,8,13,21,34,55,89)[$pN +1]
    "/>
 </xsl:function>
 
  <xsl:function name="f:fibo2" as="xs:integer">
   <xsl:param name="pN" as="xs:integer"/>
   
   <xsl:sequence select=
    "if ($pN gt 10)
        then
         for $m in $pN idiv 4,
             $k in $pN mod 4,
             $Fm in f:fibo2($m),
             $Fm-1 in f:fibo2($m - 1)
             return
               if($k eq 0)
                 then
                   for $Fm2  in $Fm*$Fm,
                       $Fm-1s2 in $Fm-1*$Fm-1,
                       $t1   in $Fm2+ $Fm-1s2,
                       $t2   in $t1*$t1,
                       $t3   in $Fm-1*($Fm + $Fm - $Fm-1),
                       $t4   in $t3*$t3
                      return
                         $t4 + $t2
                 else if($k eq 1)
                   then  
                     for $Fm2    in $Fm*$Fm,
                         $Fm-1s2 in $Fm-1*$Fm-1,
                         $t1     in $Fm*$Fm-1,
                         $t2     in $t1 + $t1,
                         $t4     in $t2 + $t2
                       return
                         ($Fm2+$Fm-1s2)*($Fm2 + $t4 - $Fm-1s2)
                 else if($k eq 2)
                   then
                     for $Fm2    in $Fm*$Fm,
                         $Fm-1s2 in $Fm-1*$Fm-1,
                         $t1     in $Fm*($Fm + $Fm-1 + $Fm-1),
                         $t2     in $Fm2 + $Fm-1s2
                       return
                         $t1*$t1 + $t2*$t2
                 else
                    for $Fm2    in $Fm*$Fm,
                        $Fm-1s2 in $Fm-1*$Fm-1,
                        $t1     in $Fm*($Fm + $Fm-1 + $Fm-1),
                        $t2     in $Fm2 + $Fm-1s2
                      return
                        $t1*($t1 + $t2 + $t2)
                   
        else
			    (1,1,2,3,5,8,13,21,34,55,89)[$pN +1]
    "/>
  </xsl:function>
 </xsl:stylesheet>