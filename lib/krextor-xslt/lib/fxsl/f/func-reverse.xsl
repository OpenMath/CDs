<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:f="http://fxsl.sf.net/"
xmlns:str-reverse-func="f:str-reverse-func"
exclude-result-prefixes="f xs str-reverse-func"
>

   <xsl:import href="func-dvc-str-foldl.xsl"/>

    <xsl:function name="f:reverse">
      <xsl:param name="pSeq" as="item()*"/>
      
      <xsl:sequence select=
              "for $i in 1 to count($pSeq) return
                  $pSeq[count($pSeq) - $i + 1]"
      />
    </xsl:function>
    
    <xsl:function name="f:reverse2">
      <xsl:param name="pSeq" as="item()*"/>
      
      <xsl:sequence select=
        "if(count($pSeq) = 1)
            then $pSeq
            else
              for $half in count($pSeq) idiv 2
                return
		              (f:reverse2(subsequence($pSeq,$half+1)), 
		               f:reverse2(subsequence($pSeq,1,$half))
		               )"
      />
    </xsl:function>
    
    <xsl:function name="f:reverse3">
      <xsl:param name="pSeq" as="item()*"/>
      
      <xsl:sequence select=
       "for $cnt in count($pSeq)
           return
             if($cnt gt 1)
                then
                 (
                  $pSeq[$cnt], 
                  f:reverse3(remove($pSeq,$cnt))
                  )
                else
                  $pSeq  
                  "
      />
    </xsl:function>

    <xsl:function name="f:reverse4">
      <xsl:param name="pSeq" as="item()*"/>
      
      <xsl:sequence select=
       "for $cnt in count($pSeq)
           return
             if($cnt gt 1)
                then
                 (
                  f:reverse4(remove($pSeq,1)),
                  $pSeq[1]
                  )
                else
                  $pSeq  
                  "
      />
    </xsl:function>

    <xsl:function name="f:reverse5">
      <xsl:param name="pSeq" as="item()*"/>
      
      <xsl:sequence select=
        "if(count($pSeq) le 1000)
            then f:reverse4($pSeq)
            else
              for $half in count($pSeq) idiv 2
                return
		              (f:reverse4(subsequence($pSeq,$half+1)), 
		               f:reverse4(subsequence($pSeq,1,$half))
		               )"
      />
    </xsl:function>
</xsl:stylesheet>