<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:f="http://fxsl.sf.net/"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:pGenerator="pGenerator"
xmlns:pController="pController"
xmlns:IntervalParams="IntervalParams"
xmlns:mapEasyIntegrate="mapEasyIntegrate"
xmlns:easy-integrate="easy-integrate"
exclude-result-prefixes="f xs pGenerator pController IntervalParams easy-integrate"
>
  <xsl:import href="buildListWhileMap.xsl"/>
  <xsl:import href="foldl.xsl"/>

  
  <xsl:output indent="yes" omit-xml-declaration="yes"/>
  
  <pGenerator:pGenerator/>
  <pController:pController/>
  <mapEasyIntegrate:mapEasyIntegrate/>
  <easy-integrate:easy-integrate/>


  <xsl:template name="partialSumsList">
    <xsl:param name="pFun" select="/.."/>
    <xsl:param name="pA" as="xs:double"/>
    <xsl:param name="pB" as="xs:double"/>
    <xsl:param name="pEps" as="xs:double" select="0.001E0"/>

  <xsl:variable name="vMyGenerator" select="document('')/*/pGenerator:*[1]"/>
  <xsl:variable name="vMyController" select="document('')/*/pController:*[1]"/>
  <xsl:variable name="vmyEasyIntegrateMap" select="document('')/*/mapEasyIntegrate:*[1]"/>

    <xsl:variable name="vrtfvIntervalParams">
      <IntervalParams:IntervalParams>
        <Interval>
          <el><xsl:value-of select="$pA"/></el>
          <el><xsl:value-of select="$pB"/></el>
        </Interval>
        <xsl:copy-of select="$pFun"/>
      </IntervalParams:IntervalParams>
    </xsl:variable>

    <xsl:variable name="vIntervalParams" select="$vrtfvIntervalParams/*"/>


    <xsl:variable name="vrtfResultIntervalList">
      <xsl:call-template name="buildListWhileMap">
        <xsl:with-param name="pGenerator" select="$vMyGenerator"/>
        <xsl:with-param name="pController" select="$vMyController"/>
        <xsl:with-param name="pParam0" select="$vIntervalParams"/>
        <xsl:with-param name="pContollerParam" select="$pEps"/>
	    <xsl:with-param name="pMap" select="$vmyEasyIntegrateMap"/>
	  </xsl:call-template>
    </xsl:variable>

    <xsl:copy-of select="$vrtfResultIntervalList"/>

    <xsl:variable name="vResultIntervalList"
       select="$vrtfResultIntervalList/*[last()]/*"/>

  </xsl:template>

  <xsl:template name="listGenerator" mode="f:FXSL"
   match="*[namespace-uri()='pGenerator']">
     <xsl:param name="pList" select="/.."/>
     <xsl:param name="pParams"/>

     <xsl:variable name="pA0" as="xs:double" select="number($pParams/*[1]/*[1])"/>
     <xsl:variable name="pB0" as="xs:double" select="number($pParams/*[1]/*[2])"/>
     <xsl:variable name="pFun" select="$pParams/*[2]"/>

     <xsl:choose>
       <xsl:when test="not($pList)">
         <xsl:variable as="xs:double" name="vFa">
           <xsl:apply-templates select="$pFun" mode="f:FXSL">
             <xsl:with-param name="pX" select="$pA0"/>
           </xsl:apply-templates>
         </xsl:variable>

         <xsl:variable as="xs:double" name="vFb">
           <xsl:apply-templates select="$pFun" mode="f:FXSL">
             <xsl:with-param name="pX" select="$pB0"/>
           </xsl:apply-templates>
         </xsl:variable>

         <e><xsl:value-of select="number($pB0) - number($pA0)"/></e>
         <e><xsl:value-of select="$vFa"/></e>
         <e><xsl:value-of select="$vFb"/></e>
       </xsl:when>
       <xsl:otherwise>
          <xsl:variable name="vprevH" as="xs:double" select="$pList[last()]/*[1]"/>
          <xsl:variable name="vH" select="number($vprevH) div 2"/>
          <e><xsl:value-of select="$vH"/></e>
          <xsl:for-each select="$pList[last()]/*[position() > 1
                                             and position() != last()]">
           <xsl:variable name="vA" as="xs:double" 
           select="number($pA0) + (position() - 1) * number($vprevH)"/>

           <xsl:variable name="vMid" as="xs:double" select="number($vA) + number($vH)"/>

           <xsl:variable name="vF_mid" as="xs:double">
             <xsl:apply-templates select="$pFun" mode="f:FXSL">
               <xsl:with-param name="pX" select="$vMid"/>
             </xsl:apply-templates>
           </xsl:variable>

           <xsl:copy-of select="."/>
           <e><xsl:value-of select="$vF_mid"/></e>
         </xsl:for-each>
         <xsl:copy-of select="$pList[last()]/*[last()]"/>
       </xsl:otherwise>
     </xsl:choose>

  </xsl:template>

  <xsl:template name="listController" mode="f:FXSL"
   match="*[namespace-uri()='pController']">
     <xsl:param name="pList" select="/.."/>
     <xsl:param name="pParams" as="xs:double"/>

     <xsl:choose>
         <xsl:when test="count($pList) &lt; 2">1</xsl:when>
         <xsl:otherwise>
             <xsl:variable name="vLastDiff" as="xs:double"
             select="$pList[last()] - $pList[last() - 1]"/>

             <xsl:if test="not($vLastDiff &lt; $pParams
                       and $vLastDiff > (0 - $pParams))">1</xsl:if>
         </xsl:otherwise>
     </xsl:choose>
  </xsl:template>

  <xsl:template name="mapEasyIntegrate" mode="f:FXSL"
   match="*[namespace-uri()='mapEasyIntegrate']">
     <xsl:param name="pParams" select="/.."/> <!-- pMapParams -->
     <xsl:param name="pDynParams" select="/.."/> <!-- NewBaseListElement -->
     <xsl:param name="pList" select="/.."/>

     <xsl:variable name="vResult" as="xs:double">
     	<xsl:call-template name="multiIntegrate">
	      <xsl:with-param name="pList" select="$pDynParams/*"/>
	    </xsl:call-template>
	 </xsl:variable>

	 <xsl:copy-of select="$vResult"/>
  </xsl:template>

  <xsl:template name="multiIntegrate">
    <xsl:param name="pList" select="/*/*"/>

    <xsl:variable name="vmyeasyIntegrateFn" select="document('')/*/easy-integrate:*[1]"/>

      <xsl:call-template name="foldl">
        <xsl:with-param name="pFunc" select="$vmyeasyIntegrateFn"/>
        <xsl:with-param name="pList" select="$pList[position() > 1
                                              and position() &lt; last()]"/>
        <xsl:with-param name="pA0" select="0.0E0"/>
      </xsl:call-template>

  </xsl:template>

  <xsl:template name="myEasyIntegrateFn" mode="f:FXSL"
   match="*[namespace-uri()='easy-integrate']">
    <xsl:param name="arg1" as="xs:double" select="0.0E0"/> <!-- pA0 -->
    <xsl:param name="arg2" select="/.."/> <!-- node -->

    <xsl:value-of
       select="$arg1
             +
               ((number($arg2) + number($arg2/following-sibling::*[1]))
                 div 2
                ) * number($arg2/../*[1])"/>

  </xsl:template>

</xsl:stylesheet>