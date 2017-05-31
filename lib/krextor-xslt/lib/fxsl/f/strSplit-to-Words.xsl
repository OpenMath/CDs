<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:f="http://fxsl.sf.net/"
xmlns:str-split2words-func="f:str-split2words-func"
exclude-result-prefixes="f str-split2words-func"
>

    <!--<xsl:import href="str-foldl.xsl"/>-->
   <!--<xsl:import href="func-str-foldl.xsl"/>-->
   <xsl:import href="func-dvc-str-foldl.xsl"/>

   <!-- to be applied on words.xml -->


   <xsl:output indent="yes" omit-xml-declaration="yes"/>
   
    <xsl:template match="/">
      <xsl:call-template name="str-split-to-words">
        <xsl:with-param name="pStr" select="string(/)"/>
        <xsl:with-param name="pDelimiters" select="', &#9;&#10;&#13;'"/>
      </xsl:call-template>
    </xsl:template>

    <xsl:template name="str-split-to-words">
      <xsl:param name="pStr"/>
      <xsl:param name="pDelimiters"/>
      
      <xsl:variable name="vsplit2wordsFun" as="element()">
         <str-split2words-func:str-split2words-func/>
      </xsl:variable>
                    
      <xsl:variable name="vrtfParams">
       <delimiters><xsl:value-of select="$pDelimiters"/></delimiters>
      </xsl:variable>

      <xsl:variable name="vResult" 
       select="f:str-foldl($vsplit2wordsFun,$vrtfParams,$pStr)"/>
<!--       
      <xsl:variable name="vResult">
	      <xsl:call-template name="str-foldl">
	        <xsl:with-param name="pFunc" select="$vsplit2wordsFun"/>
	        <xsl:with-param name="pStr" select="$pStr"/>
	        <xsl:with-param name="pA0" select="$vrtfParams"/>
	      </xsl:call-template>
      </xsl:variable>
-->      
      <xsl:copy-of select="$vResult/word"/>

    </xsl:template>

    <xsl:template match="str-split2words-func:*" mode="f:FXSL">
      <xsl:param name="arg1" select="/.."/>
      <xsl:param name="arg2"/>
      <z>
      <xsl:copy-of select="$arg1/*[1]"/>
      <xsl:copy-of select="$arg1/word[position() != last()]"/>
      
      <xsl:choose>
        <xsl:when test="contains($arg1/*[1], $arg2)">
          <xsl:if test="string($arg1/word[last()])">
             <xsl:copy-of select="$arg1/word[last()]"/>
          </xsl:if>
          <word/>
        </xsl:when>
        <xsl:otherwise>
          <word><xsl:value-of select="concat($arg1/word[last()], $arg2)"/></word>
        </xsl:otherwise>
      </xsl:choose>
      </z>
    </xsl:template>

</xsl:stylesheet>