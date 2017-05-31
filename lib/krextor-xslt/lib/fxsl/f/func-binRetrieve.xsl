<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f xs"
 >
 
 <xsl:import href="../f/func-apply.xsl"/>
 
  <xsl:function name="f:binRetrieve" as="item()?">
   <xsl:param name="pSeq" as="item()+"/>
   <xsl:param name="pVal" as="item()"/>
   <xsl:sequence select="f:binRetrieve($pSeq,$pVal,1,count($pSeq))"/>
</xsl:function>
 
  <xsl:function name="f:binRetrieve" as="item()?">
   <xsl:param name="pEq" as="element()?"/>
   <xsl:param name="pLt" as="element()?"/>
   <xsl:param name="pSeq" as="item()+"/>
   <xsl:param name="pVal" as="item()"/>
   <xsl:param name="pStart" as="item()"/>
   <xsl:param name="pEnd" as="item()"/>

   <xsl:sequence select=
     "if($pStart gt $pEnd) then ()
       else
       if(empty(($pEq, $pLt)[2]))
        then f:binRetrieve($pSeq, $pVal, $pStart, $pEnd)
        else 
          for $mid in ($pStart + $pEnd) idiv 2,
               $sVal in $pSeq[$mid] 
             return
               if(f:apply($pEq,$sVal,$pVal) = true()) then $pSeq[$mid]
               else
                if(f:apply($pLt,$sVal,$pVal) = true())
                  then f:binRetrieve($pEq,$pLt,$pSeq,$pVal,$mid+1,$pEnd)
                else 
                  f:binRetrieve($pEq,$pLt,$pSeq,$pVal,$pStart,$mid - 1)
     "
   />
  </xsl:function>

 <xsl:function name="f:binRetrieve" as="item()?">
   <xsl:param name="pSeq" as="item()+"/>
   <xsl:param name="pVal" as="item()"/>
   <xsl:param name="pStart" as="item()"/>
   <xsl:param name="pEnd" as="item()"/>
   
   <xsl:sequence select=
    "if($pStart gt $pEnd) then ()
       else
        for $mid in ($pStart + $pEnd) idiv 2,
             $sVal in $pSeq[$mid] 
           return
             if($sVal eq $pVal) then $pSeq[$mid]
             else
                if($sVal lt $pVal)
                   then f:binRetrieve($pSeq, $pVal, $mid+1, $pEnd)
                else 
                  f:binRetrieve($pSeq, $pVal, $pStart, $mid - 1)
       "/>
 </xsl:function>
 
</xsl:stylesheet>