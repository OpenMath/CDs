<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f xs"
 >
  <xsl:import href="../f/func-XpathConstructors.xsl"/>

  <xsl:output omit-xml-declaration="yes"/>
  
  <xsl:key name="kConstructor" match="*" use="@t"/>
  
  <xsl:variable name="f:vTypeConstructors">
    <f:unsignedByte t="xs:unsignedByte"/>
    <f:unsignedShort t="xs:unsignedShort"/>
    <f:unsignedInt t="xs:unsignedInt"/>
    <f:unsignedLong t="xs:unsignedLong"/>
    <f:positiveInteger t="xs:positiveInteger"/>
    <f:nonNegativeInteger t="xs:nonNegativeInteger"/>
    <f:nonPositiveInteger t="xs:nonPositiveInteger"/>
    <f:byte t="xs:byte"/>
    <f:short t="xs:short"/>
    <f:int t="xs:int"/>
    <f:long t="xs:long"/>
    <f:integer t="xs:integer"/>
    <f:decimal t="xs:decimal"/>
    <f:double t="xs:double"/>
    <f:float t="xs:float"/>
    <f:NMTOKEN t="xs:NMTOKEN"/>
    <f:NMTOKENS t="xs:NMTOKENS"/>
    <f:ENTITIES t="xs:ENTITIES"/>
    <f:ENTITY t="xs:ENTITY"/>
    <f:IDREF t="xs:IDREF"/>
    <f:IDREFS t="xs:IDREFS"/>
    <f:ID t="xs:ID"/>
    <f:NCName t="xs:NCName"/>
    <f:Name t="xs:Name"/>
    <f:language t="xs:language"/>
    <f:token t="xs:token"/>
    <f:normalizedString t="xs:normalizedString"/>
    <f:boolean t="xs:boolean"/>
    <f:duration t="xs:duration"/>
    <f:dateTime t="xs:dateTime"/>
    <f:time t="xs:time"/>
    <f:date t="xs:date"/>
    <f:gYearMonth t="xs:gYearMonth"/>
    <f:gYear t="xs:gYear"/>
    <f:gMonthDay t="xs:gMonthDay"/>
    <f:gDay t="xs:gDay"/>
    <f:gMonth t="xs:gMonth"/>
    <f:base64Binary t="xs:base64Binary"/>
    <f:hexBinary t="xs:hexBinary"/>
    <f:anyURI t="xs:anyURI"/>
    <f:QName t="xs:QName"/>
    <f:NOTATION t="xs:NOTATION"/>
    <f:string t="xs:string"/>
    <f:yearMonthDuration t="xs:yearMonthDuration"/>
    <f:dayTimeDuration t="xs:dayTimeDuration"/>
  </xsl:variable>
 
  <xsl:function name="f:Constructor" as="element()">
    <xsl:param name="pTypename" as="xs:string"/>

    <xsl:sequence select="key('kConstructor', $pTypename,$f:vTypeConstructors)"/>  
  </xsl:function>
  
  <xsl:function name="f:typeConstructor" as="element()">
    <xsl:param name="pThis"/>

    <xsl:sequence select="key('kConstructor', f:type($pThis),$f:vTypeConstructors)"/>  
  </xsl:function>
  
  <xsl:function name="f:type" as="xs:string">
    <xsl:param name="pThis"/>
    
    <xsl:choose>
      <xsl:when test="$pThis instance of xs:decimal">
        <xsl:choose>
          <xsl:when use-when="system-property('xsl:is-schema-aware')='yes'"  test="true()">
		        <xsl:choose>
<!--       Not supported by a Basic XSLT Processor -->        
		          <xsl:when test="$pThis instance of xs:unsignedByte">xs:unsignedByte</xsl:when>
		          <xsl:when test="$pThis instance of xs:unsignedShort">xs:unsignedShort</xsl:when>
		          <xsl:when test="$pThis instance of xs:unsignedInt">xs:unsignedInt</xsl:when>
		          <xsl:when test="$pThis instance of xs:unsignedLong">xs:unsignedLong</xsl:when>
		    
		          <xsl:when test="$pThis instance of xs:positiveInteger">xs:positiveInteger</xsl:when>
		          <xsl:when test="$pThis instance of xs:nonNegativeInteger">xs:nonNegativeInteger</xsl:when>
		    
		          <xsl:when test="$pThis instance of xs:negativeInteger">xs:negativeInteger</xsl:when>
		          <xsl:when test="$pThis instance of xs:nonPositiveInteger">xs:nonPositiveInteger</xsl:when>
		          
		          <xsl:when test="$pThis instance of xs:byte">xs:byte</xsl:when>
		          <xsl:when test="$pThis instance of xs:short">xs:short</xsl:when>
		          <xsl:when test="$pThis instance of xs:int">xs:int</xsl:when>
		          <xsl:when test="$pThis instance of xs:long">xs:long</xsl:when>
	          </xsl:choose>
<!--      End of SA only types  -->
					</xsl:when>
          <xsl:when test="$pThis instance of xs:integer">xs:integer</xsl:when>
          
          <xsl:otherwise>xs:decimal</xsl:otherwise>
        
        </xsl:choose>
      </xsl:when>

      <xsl:when test="$pThis instance of xs:double">xs:double</xsl:when>
      <xsl:when test="$pThis instance of xs:float">xs:float</xsl:when>

      <xsl:when test="$pThis instance of xs:string">
        <xsl:choose>
          <xsl:when use-when="system-property('xsl:is-schema-aware')='yes'"  test="true()">
<!--       Not supported by a Basic XSLT Processor -->        
            <xsl:choose>
              <xsl:when test="$pThis instance of xs:NMTOKEN">xs:NMTOKEN</xsl:when>
              <xsl:when test="$pThis instance of xs:ENTITY">xs:ENTITY</xsl:when>
              <xsl:when test="$pThis instance of xs:IDREF">xs:IDREF</xsl:when>

              <!-- TODO: What to do with list simple types?
              <xsl:when test="$pThis instance of xs:NMTOKEN+">xs:NMTOKENS</xsl:when>
              <xsl:when test="$pThis instance of xs:ENTITY+">xs:ENTITIES</xsl:when>
              <xsl:when test="$pThis instance of xs:IDREF+">xs:IDREFS</xsl:when> 
              -->

              <xsl:when test="$pThis instance of xs:ID">xs:ID</xsl:when>
              <xsl:when test="$pThis instance of xs:NCName">xs:NCName</xsl:when>
              <xsl:when test="$pThis instance of xs:Name">xs:Name</xsl:when>

              <xsl:when test="$pThis instance of xs:language">xs:language</xsl:when>
              <xsl:when test="$pThis instance of xs:token">xs:token</xsl:when>
              <xsl:when test="$pThis instance of xs:normalizedString">xs:normalizedString</xsl:when>
              <xsl:otherwise>xs:string</xsl:otherwise>
            </xsl:choose>
          </xsl:when> 
          <xsl:when test="true()">xs:string</xsl:when> 
        </xsl:choose>
      </xsl:when>
    
      <xsl:when test="$pThis instance of xs:boolean">xs:boolean</xsl:when>

      <xsl:when test="$pThis instance of xs:duration">xs:duration</xsl:when>

      <xsl:when test="$pThis instance of xs:dateTime">xs:dateTime</xsl:when>

      <xsl:when test="$pThis instance of xs:time">xs:time</xsl:when>

      <xsl:when test="$pThis instance of xs:date">xs:date</xsl:when>

      <xsl:when test="$pThis instance of xs:gYearMonth">xs:gYearMonth</xsl:when>

      <xsl:when test="$pThis instance of xs:gYear">xs:gYear</xsl:when>

      <xsl:when test="$pThis instance of xs:gMonthDay">xs:gMonthDay</xsl:when>

      <xsl:when test="$pThis instance of xs:gDay">xs:gDay</xsl:when>

      <xsl:when test="$pThis instance of xs:gMonth">xs:gMonth</xsl:when>
      
      <xsl:when test="$pThis instance of xs:yearMonthDuration">xs:yearMonthDuration</xsl:when>
      
      <xsl:when test="$pThis instance of xs:dayTimeDuration">xs:dayTimeDuration</xsl:when>
      
      <xsl:when test="$pThis instance of xs:base64Binary">xs:base64Binary</xsl:when>

      <xsl:when test="$pThis instance of xs:hexBinary">xs:hexBinary</xsl:when>

      <xsl:when test="$pThis instance of xs:anyURI">xs:anyURI</xsl:when>

      <xsl:when test="$pThis instance of xs:QName">xs:QName</xsl:when>

      <xsl:when use-when="system-property('xsl:is-schema-aware')='yes'"
           test="$pThis instance of xs:NOTATION">xs:NOTATION</xsl:when>

<!--
      <xsl:when test="$pThis instance of xs:untypedAtomic">xs:untypedAtomic</xsl:when>
      <xsl:otherwise>Unknown xs:untypedAtomic</xsl:otherwise>
-->
      <xsl:when test="$pThis[1] instance of node()">xml:node</xsl:when>
      <xsl:otherwise>xs:string</xsl:otherwise>      
    </xsl:choose>
  </xsl:function>
</xsl:stylesheet>