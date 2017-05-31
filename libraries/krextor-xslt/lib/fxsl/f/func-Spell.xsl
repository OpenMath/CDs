<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:saxon="http://saxon.sf.net/"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f xs saxon"
 >
 <xsl:import href="../f/func-binSearch.xsl"/>
 
 <xsl:variable name="vDict" as="xs:string+"
  select="document('../data/dictEnglish.xml')/*/*"/>
 <xsl:variable name="vcntWords" select="count($vDict)"/>

 <xsl:function name="f:spell" as="xs:boolean" saxon:memo-function="yes">
  <xsl:param name="vWord" as="xs:string"/>
  
  <xsl:sequence select=
   "f:binSearch($vDict, xs:string($vWord), 1, $vcntWords)"
   />
 </xsl:function>
</xsl:stylesheet>