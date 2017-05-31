<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:f="http://fxsl.sf.net/"
xmlns:MyTakeController="f:MyTakeController" 
exclude-result-prefixes="xs f MyTakeController"
>

  <xsl:import href="../f/func-str-takeWhile.xsl"/>
    <xsl:function name="f:getWords" as="element()*">
      <xsl:param name="str" as="xs:string"/>
      <xsl:param name="delims" as="xs:string"/>
      <xsl:param name="start" as="xs:integer" />

      <xsl:sequence select=
      "for $len in (string-length($str)),
           $start in ($start),
           $word in (f:strGetWord($str,$delims,$start)),
           $wordlen in (string-length($word)),
           $nextStart in ($start + $wordlen+1)
           return
             ( (if ($wordlen)
                    then $word
                    else ()
                )
                ,
               (if($len > $nextStart)
                 then f:getWords($str,$delims,$nextStart)
                 else ()
                )
              )
             
      "/>
    </xsl:function>

      <xsl:variable name="vMyTakeController" as="element()">
        <MyTakeController:MyTakeController/>
      </xsl:variable>

    <xsl:function name="f:strGetWord" as="element()">
      <xsl:param name="pStr" as="xs:string"/>
      <xsl:param name="pDelimiters" as="xs:string"/>
      <xsl:param name="pStart" as="xs:integer"/>
      
      <w>
        <xsl:value-of select=
          "f:str-takeWhile(substring($pStr,$pStart), 
                           $vMyTakeController, $pDelimiters)"/>
      </w>
    </xsl:function>

  <xsl:template match="MyTakeController:*" mode="f:FXSL">
  	<xsl:param name="arg1" select="''"/>
    <xsl:param name="arg2" select="/.."/>
    
    <xsl:value-of select="number(not(contains(string($arg2), string($arg1))))"/>
  </xsl:template>

</xsl:stylesheet>