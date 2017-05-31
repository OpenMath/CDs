<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:f="http://fxsl.sf.net/"
xmlns:minimum-fold-func="minimum-fold-func"
xmlns:minimum-pick-smaller="minimum-pick-smaller"
xmlns:minimum-own-compare="minimum-own-compare"
exclude-result-prefixes="f minimum-fold-func minimum-own-compare minimum-pick-smaller"
>
   <xsl:import href="foldl.xsl"/>

   <minimum-fold-func:minimum-fold-func/>
   <minimum-pick-smaller:minimum-pick-smaller/>
   <minimum-own-compare:minimum-own-compare/>

    <xsl:template name="minimum">
      <xsl:param name="pList" select="/.."/>
      <xsl:param name="pCMPFun" select="/.."/>

      <xsl:variable name="vdfCMPFun" select="document('')/*/minimum-own-compare:*[1]"/>
      <xsl:variable name="vFoldFun" select="document('')/*/minimum-pick-smaller:*[1]"/>
      
      <xsl:if test="$pList">
          <xsl:variable name="vCMPFun" select="$pCMPFun | $vdfCMPFun[not($pCMPFun)]"/>
          <xsl:variable name="vFuncList">
            <xsl:copy-of select="$vFoldFun"/> <!-- Pick Smaller -->
            <xsl:copy-of select="$vCMPFun"/>  <!-- Compare -->
          </xsl:variable>

          <xsl:call-template name="foldl">
            <xsl:with-param name="pFunc" select="$vFuncList/*"/>
            <xsl:with-param name="pList" select="$pList"/>
            <xsl:with-param name="pA0" select="$pList[1]"/>
          </xsl:call-template>
      </xsl:if>
    </xsl:template>

    <xsl:template name="pickSmaller" mode="f:FXSL"
     match="*[namespace-uri() = 'minimum-pick-smaller']">
         <xsl:param name="arg0"/>
         <xsl:param name="arg1"/>
         <xsl:param name="arg2"/>

         <xsl:variable name="vIsSmaller">
           <xsl:apply-templates select="$arg0" mode="f:FXSL">
             <xsl:with-param name="arg1" select="$arg1"/>
             <xsl:with-param name="arg2" select="$arg2"/>
           </xsl:apply-templates>
         </xsl:variable>
         <xsl:choose>
           <xsl:when test="$vIsSmaller = 1">
             <xsl:copy-of select="$arg1"/>
           </xsl:when>
           <xsl:otherwise>
             <xsl:copy-of select="$arg2"/>
           </xsl:otherwise>
         </xsl:choose>
    </xsl:template>

    <xsl:template name="isSmallerDefault" mode="f:FXSL"
     match="*[namespace-uri() = 'minimum-own-compare']">
         <xsl:param name="arg1"/>
         <xsl:param name="arg2"/>

         <xsl:choose>
          <xsl:when test="$arg1 &lt; $arg2">1</xsl:when>
          <xsl:otherwise>0</xsl:otherwise>
         </xsl:choose>
    </xsl:template>
</xsl:stylesheet>