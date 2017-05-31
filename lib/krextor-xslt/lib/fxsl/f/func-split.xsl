<xsl:stylesheet version="2.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f xs"
>
  <xsl:function name="f:split">
    <xsl:param name="pList" as="item()+"/>
    <xsl:param name="pN" as="xs:integer"/>
    <xsl:variable name="pDelim" select="number('x')"/>
    
    <xsl:sequence select="f:split($pList, $pN, $pDelim)"/>
  </xsl:function>
  
  <xsl:function name="f:split">
    <xsl:param name="pList" as="item()+"/>
    <xsl:param name="pN" as="xs:integer"/>
    <xsl:param name="pDelim" as="item()"/>
    
    <xsl:sequence select=
    "subsequence($pList, 1, $pN)
    , $pDelim ,
    subsequence($pList, $pN + 1)"
    />
  </xsl:function>
</xsl:stylesheet>