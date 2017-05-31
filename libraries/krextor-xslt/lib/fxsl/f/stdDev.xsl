<xsl:stylesheet version="1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:f="http://fxsl.sf.net/"
 xmlns:stdAccum="f:fxsl__stdAccum"
 exclude-result-prefixes="f stdAccum"
 >
 
 <xsl:import href="foldl.xsl"/>
 <xsl:import href="sqrt.xsl"/>

  <xsl:template name="stdDev">
    <xsl:param name="pNums" select="/.."/>
    
    <xsl:variable name="vCount" select="count($pNums)"/>
    
    <xsl:if test="not($vCount > 1)">
      <xsl:message terminate="yes">
      Error[stdDev]: Sample should have at least two numbers
      </xsl:message>
    </xsl:if>
   
    <xsl:variable name="vMean" select="sum($pNums) div $vCount"/>
    
    <xsl:variable name="vrtfParams">
      <mean><xsl:value-of select="$vMean"/></mean>
      <accum>0</accum>
    </xsl:variable>
    
    <xsl:variable name="stdFun" select="document('')/*/stdAccum:*[1]"/>
    
    <xsl:variable name="vsumSQ-Devs">
      <xsl:call-template name="foldl">
        <xsl:with-param name="pFunc" select="$stdFun"/>
        <xsl:with-param name="pA0" select="$vrtfParams/*"/>
        <xsl:with-param name="pList" select="$pNums"/>
      </xsl:call-template>
    </xsl:variable>
    
    <xsl:call-template name="sqrt">
      <xsl:with-param name="N" 
      select="$vsumSQ-Devs/accum div ($vCount - 1)"/>
      <xsl:with-param  name="Eps" select="0.00001"/>
    </xsl:call-template>
  </xsl:template>
  
  <stdAccum:stdAccum/>
  <xsl:template match="stdAccum:*" mode="f:FXSL">
    <xsl:param name="arg1" select="/.."/> <!-- pA0 -->
    <xsl:param name="arg2"/> <!--Current list-element -->
    
    <mean><xsl:value-of select="$arg1[self::mean]"/></mean>
    <accum>
      <xsl:value-of 
      select="$arg1[self::accum]
             + 
              ($arg2 - $arg1[self::mean]) * ($arg2 - $arg1[self::mean])"/>
    </accum>
  </xsl:template>
</xsl:stylesheet>