<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:f="http://fxsl.sf.net/"
xmlns:maximum-pick-bigger="f:maximum-pick-bigger"
xmlns:maximum-own-compare="f:maximum-own-compare"
exclude-result-prefixes="f maximum-own-compare maximum-pick-bigger"
>
   <xsl:import href="dvc-foldl.xsl"/>

   <maximum-pick-bigger:maximum-pick-bigger/>
   <maximum-own-compare:maximum-own-compare/>

    <xsl:template name="maximum">
      <xsl:param name="pList" select="/.."/>
      <xsl:param name="pCMPFun" select="/.."/>

	  <xsl:variable name="vdfCMPFun" select="document('')/*/maximum-own-compare:*[1]"/>
	  <xsl:variable name="vFoldFun" select="document('')/*/maximum-pick-bigger:*[1]"/>
   
      <xsl:if test="$pList">
          <xsl:variable name="vCMPFun" select="$pCMPFun | $vdfCMPFun[not($pCMPFun)]"/>
          <xsl:variable name="vFuncList">
            <xsl:copy-of select="$vFoldFun"/> <!-- Pick Bigger -->
            <xsl:copy-of select="$vCMPFun"/>  <!-- Compare -->
          </xsl:variable>

          <xsl:variable name="vrtfResult">
            <xsl:call-template name="foldl">
              <xsl:with-param name="pFunc" select="$vFuncList/*"/>
              <xsl:with-param name="pList" select="$pList"/>
              <xsl:with-param name="pA0" select="$pList[1]"/>
            </xsl:call-template>
          </xsl:variable>
          
          <xsl:copy-of select="$vrtfResult/*"/>
      </xsl:if>
    </xsl:template>

    <xsl:template name="pickBigger" match="maximum-pick-bigger:*"
     mode="f:FXSL">
         <xsl:param name="arg0"/>
         <xsl:param name="arg1"/>
         <xsl:param name="arg2"/>

         <xsl:variable name="vIsGreater">
           <xsl:apply-templates select="$arg0" mode="f:FXSL">
             <xsl:with-param name="arg1" select="$arg1"/>
             <xsl:with-param name="arg2" select="$arg2"/>
           </xsl:apply-templates>
         </xsl:variable>

         <xsl:copy-of 
              select="$arg1[$vIsGreater = 1]
                     |
                      $arg2[not($vIsGreater = 1)]"/>
    </xsl:template>

    <xsl:template name="isGreaterDefault" match="maximum-own-compare:*"
     mode="f:FXSL">
         <xsl:param name="arg1"/>
         <xsl:param name="arg2"/>

         <xsl:choose>
          <xsl:when test="$arg1 > $arg2">1</xsl:when>
          <xsl:otherwise>0</xsl:otherwise>
         </xsl:choose>
    </xsl:template>
</xsl:stylesheet>