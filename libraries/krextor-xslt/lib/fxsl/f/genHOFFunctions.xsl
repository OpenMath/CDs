<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 xmlns:fint="http://fxsl.sf.net/internal"
 xmlns:xxx="xxx"
 >
  <xsl:output omit-xml-declaration="yes" indent="yes"/>
  <xsl:namespace-alias stylesheet-prefix="xxx" result-prefix="xsl"/>
  
  <xsl:template match="/">
    <xxx:stylesheet version="2.0"
     xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
     xmlns:xs="http://www.w3.org/2001/XMLSchema"
     xmlns:f="http://fxsl.sf.net/"
     exclude-result-prefixes="f xs"
    >
    <xxx:import href="func-curry.xsl"/>
    
      <xsl:apply-templates/>
    </xxx:stylesheet>

  </xsl:template>

 <xsl:template match="f">
   <xsl:comment>

   ----------------------------------------------------
      Function: <xsl:value-of select="@name"/>()
   </xsl:comment><xsl:text>&#xA;</xsl:text>
   <xxx:template match="f:{@name}" mode="f:FXSL">
     <xsl:sequence select="fint:makeType(@type)"/>
   
     <xsl:for-each select="*[not(self::fCode)]">
       <xxx:param name="arg{position()}">
       <xsl:sequence select="fint:makeType(@type)"/>
       </xxx:param>
     </xsl:for-each>
     
     <xsl:variable name="vFuncCall" as="xs:string">
	     <xsl:value-of separator="" select=
	        "('f:',@name, '(',
	                 for $cnt in count(*[not(self::fCode)]),
	                     $i in 1 to $cnt
	                     return (concat('$arg', $i),
	                             if($i lt $cnt)
	                                then ','
	                                else ()
	                            ),
	                  ')'          
	                )
	        "
	        />
        </xsl:variable>
      <xxx:sequence select="{$vFuncCall}"/>
   </xxx:template>
   
   <xxx:function name="f:{@name}" as="element()">
     <xsl:element name="f:{@name}"/>
   </xxx:function>
   
   <xsl:variable name="vFNode" select="." as="element()"/>
   <xsl:for-each select="1 to count(*[not(self::fCode)]) - 1">
     <xsl:sequence select="fint:makePartApp($vFNode,.)"/>
   </xsl:for-each>

   <xsl:sequence select="fint:makeFuncCode($vFNode)"/>
  
 </xsl:template>
 
 <xsl:function name="fint:makeType" as="attribute()">
   <xsl:param name="pType" as="attribute()"/>
   
     <xsl:attribute name="as" select=
       "if(string($pType))
          then string($pType)
          else 'xs:untyped'
       "/>
 
 </xsl:function>
 
  <xsl:function name="fint:makePartApp" as="element()">
    <xsl:param name="pFNode" as="element()"/>
    <xsl:param name="pNumArgs" as="xs:integer"/>

    <xxx:function name="f:{$pFNode/@name}" as="element()">
     <xsl:for-each select="$pFNode/*[not(self::fCode)]">
       <xsl:if test="position() le $pNumArgs">
	       <xxx:param name="{name(.)}">
	          <xsl:sequence select="fint:makeType(@type)"/>
	       </xxx:param>
       </xsl:if>
     </xsl:for-each>
     
     <xsl:variable name="vCurriedCall" as="xs:string">
	     <xsl:value-of separator="" select=
	        "('f:curry(','f:', $pFNode/@name, '(),',
	                 count($pFNode/*[not(self::fCode)]), ',',
	                 for $cnt in count($pFNode/*[not(self::fCode)]),
	                     $i in 1 to $pNumArgs
	                     return ('$',name($pFNode/*[not(self::fCode)][$i]),
	                             if($i lt $pNumArgs)
	                                then ','
	                                else ()
	                            ),
	                  ')'          
	                )
	        "
	        />
        </xsl:variable>
     
     
      <xxx:sequence select="{$vCurriedCall}"/>
    </xxx:function>
  </xsl:function>
  
  <xsl:function name="fint:makeFuncCode" as="element()">
    <xsl:param name="pFNode" as="element()"/>

    <xxx:function name="f:{$pFNode/@name}">
      <xsl:sequence select="fint:makeType($pFNode/@type)"/>
     
     <xsl:for-each select="$pFNode/*[not(self::fCode)]">
	       <xxx:param name="{name(.)}">
	          <xsl:sequence select="fint:makeType(@type)"/>
	       </xxx:param>
     </xsl:for-each>
     
      <xsl:sequence select="$pFNode/fCode/node()"/>
    </xxx:function>
  
  </xsl:function>
  

</xsl:stylesheet>