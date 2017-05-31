<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:f="http://fxsl.sf.net/"
                xmlns:fint="http://fxsl.sf.net/internal"
                version="2.0"
                exclude-result-prefixes="f xs">
   <xsl:import href="func-curry.xsl"/>
  <!--

   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      Function: years-from-duration()
   -->
<xsl:template match="f:years-from-duration" mode="f:FXSL" as="xs:integer?">
      <xsl:param name="arg1" as="xs:duration?"/>
      <xsl:sequence select="f:years-from-duration($arg1)"/>
   </xsl:template>
   <xsl:function name="f:years-from-duration" as="element()">
      <f:years-from-duration/>
   </xsl:function>
   <xsl:function name="f:years-from-duration" as="xs:integer?">
      <xsl:param name="pDuration" as="xs:duration?"/>
      <xsl:sequence select="years-from-duration($pDuration)"/>
    </xsl:function>
  <!--

   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      Function: months-from-duration()
   -->
<xsl:template match="f:months-from-duration" mode="f:FXSL" as="xs:integer?">
      <xsl:param name="arg1" as="xs:duration?"/>
      <xsl:sequence select="f:months-from-duration($arg1)"/>
   </xsl:template>
   <xsl:function name="f:months-from-duration" as="element()">
      <f:months-from-duration/>
   </xsl:function>
   <xsl:function name="f:months-from-duration" as="xs:integer?">
      <xsl:param name="pDuration" as="xs:duration?"/>
      <xsl:sequence select="months-from-duration($pDuration)"/>
    </xsl:function>
  <!--

   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      Function: days-from-duration()
   -->
<xsl:template match="f:days-from-duration" mode="f:FXSL" as="xs:integer?">
      <xsl:param name="arg1" as="xs:duration?"/>
      <xsl:sequence select="f:days-from-duration($arg1)"/>
   </xsl:template>
   <xsl:function name="f:days-from-duration" as="element()">
      <f:days-from-duration/>
   </xsl:function>
   <xsl:function name="f:days-from-duration" as="xs:integer?">
      <xsl:param name="pDuration" as="xs:duration?"/>
      <xsl:sequence select="days-from-duration($pDuration)"/>
    </xsl:function>
  <!--

   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      Function: hours-from-duration()
   -->
<xsl:template match="f:hours-from-duration" mode="f:FXSL" as="xs:integer?">
      <xsl:param name="arg1" as="xs:duration?"/>
      <xsl:sequence select="f:hours-from-duration($arg1)"/>
   </xsl:template>
   <xsl:function name="f:hours-from-duration" as="element()">
      <f:hours-from-duration/>
   </xsl:function>
   <xsl:function name="f:hours-from-duration" as="xs:integer?">
      <xsl:param name="pDuration" as="xs:duration?"/>
      <xsl:sequence select="hours-from-duration($pDuration)"/>
    </xsl:function>
  <!--

   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      Function: minutes-from-duration()
   -->
<xsl:template match="f:minutes-from-duration" mode="f:FXSL" as="xs:integer?">
      <xsl:param name="arg1" as="xs:duration?"/>
      <xsl:sequence select="f:minutes-from-duration($arg1)"/>
   </xsl:template>
   <xsl:function name="f:minutes-from-duration" as="element()">
      <f:minutes-from-duration/>
   </xsl:function>
   <xsl:function name="f:minutes-from-duration" as="xs:integer?">
      <xsl:param name="pDuration" as="xs:duration?"/>
      <xsl:sequence select="minutes-from-duration($pDuration)"/>
    </xsl:function>
  <!--

   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      Function: seconds-from-duration()
   -->
<xsl:template match="f:seconds-from-duration" mode="f:FXSL" as="xs:decimal?">
      <xsl:param name="arg1" as="xs:duration?"/>
      <xsl:sequence select="f:seconds-from-duration($arg1)"/>
   </xsl:template>
   <xsl:function name="f:seconds-from-duration" as="element()">
      <f:seconds-from-duration/>
   </xsl:function>
   <xsl:function name="f:seconds-from-duration" as="xs:decimal?">
      <xsl:param name="pDuration" as="xs:duration?"/>
      <xsl:sequence select="seconds-from-duration($pDuration)"/>
    </xsl:function>
  <!--

   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      Function: year-from-dateTime()
   -->
<xsl:template match="f:year-from-dateTime" mode="f:FXSL" as="xs:integer?">
      <xsl:param name="arg1" as="xs:dateTime?"/>
      <xsl:sequence select="f:year-from-dateTime($arg1)"/>
   </xsl:template>
   <xsl:function name="f:year-from-dateTime" as="element()">
      <f:year-from-dateTime/>
   </xsl:function>
   <xsl:function name="f:year-from-dateTime" as="xs:integer?">
      <xsl:param name="pDatetime" as="xs:dateTime?"/>
      <xsl:sequence select="year-from-dateTime($pDatetime)"/>
    </xsl:function>
  <!--

   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      Function: month-from-dateTime()
   -->
<xsl:template match="f:month-from-dateTime" mode="f:FXSL" as="xs:integer?">
      <xsl:param name="arg1" as="xs:dateTime?"/>
      <xsl:sequence select="f:month-from-dateTime($arg1)"/>
   </xsl:template>
   <xsl:function name="f:month-from-dateTime" as="element()">
      <f:month-from-dateTime/>
   </xsl:function>
   <xsl:function name="f:month-from-dateTime" as="xs:integer?">
      <xsl:param name="pDatetime" as="xs:dateTime?"/>
      <xsl:sequence select="month-from-dateTime($pDatetime)"/>
    </xsl:function>
  <!--

   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      Function: day-from-dateTime()
   -->
<xsl:template match="f:day-from-dateTime" mode="f:FXSL" as="xs:integer?">
      <xsl:param name="arg1" as="xs:dateTime?"/>
      <xsl:sequence select="f:day-from-dateTime($arg1)"/>
   </xsl:template>
   <xsl:function name="f:day-from-dateTime" as="element()">
      <f:day-from-dateTime/>
   </xsl:function>
   <xsl:function name="f:day-from-dateTime" as="xs:integer?">
      <xsl:param name="pDatetime" as="xs:dateTime?"/>
      <xsl:sequence select="day-from-dateTime($pDatetime)"/>
    </xsl:function>
  <!--

   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      Function: hours-from-dateTime()
   -->
<xsl:template match="f:hours-from-dateTime" mode="f:FXSL" as="xs:integer?">
      <xsl:param name="arg1" as="xs:dateTime?"/>
      <xsl:sequence select="f:hours-from-dateTime($arg1)"/>
   </xsl:template>
   <xsl:function name="f:hours-from-dateTime" as="element()">
      <f:hours-from-dateTime/>
   </xsl:function>
   <xsl:function name="f:hours-from-dateTime" as="xs:integer?">
      <xsl:param name="pDatetime" as="xs:dateTime?"/>
      <xsl:sequence select="hours-from-dateTime($pDatetime)"/>
    </xsl:function>
  <!--

   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      Function: minutes-from-dateTime()
   -->
<xsl:template match="f:minutes-from-dateTime" mode="f:FXSL" as="xs:integer?">
      <xsl:param name="arg1" as="xs:dateTime?"/>
      <xsl:sequence select="f:minutes-from-dateTime($arg1)"/>
   </xsl:template>
   <xsl:function name="f:minutes-from-dateTime" as="element()">
      <f:minutes-from-dateTime/>
   </xsl:function>
   <xsl:function name="f:minutes-from-dateTime" as="xs:integer?">
      <xsl:param name="pDatetime" as="xs:dateTime?"/>
      <xsl:sequence select="minutes-from-dateTime($pDatetime)"/>
    </xsl:function>
  <!--

   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      Function: seconds-from-dateTime()
   -->
<xsl:template match="f:seconds-from-dateTime" mode="f:FXSL" as="xs:decimal?">
      <xsl:param name="arg1" as="xs:dateTime?"/>
      <xsl:sequence select="f:seconds-from-dateTime($arg1)"/>
   </xsl:template>
   <xsl:function name="f:seconds-from-dateTime" as="element()">
      <f:seconds-from-dateTime/>
   </xsl:function>
   <xsl:function name="f:seconds-from-dateTime" as="xs:decimal?">
      <xsl:param name="pDatetime" as="xs:dateTime?"/>
      <xsl:sequence select="seconds-from-dateTime($pDatetime)"/>
    </xsl:function>
  <!--

   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      Function: timezone-from-dateTime()
   -->
<xsl:template match="f:timezone-from-dateTime" mode="f:FXSL" as="xs:dayTimeDuration?">
      <xsl:param name="arg1" as="xs:dateTime?"/>
      <xsl:sequence select="f:timezone-from-dateTime($arg1)"/>
   </xsl:template>
   <xsl:function name="f:timezone-from-dateTime" as="element()">
      <f:timezone-from-dateTime/>
   </xsl:function>
   <xsl:function name="f:timezone-from-dateTime" as="xs:dayTimeDuration?">
      <xsl:param name="pDatetime" as="xs:dateTime?"/>
      <xsl:sequence select="timezone-from-dateTime($pDatetime)"/>
    </xsl:function>
  <!--

   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      Function: year-from-date()
   -->
<xsl:template match="f:year-from-date" mode="f:FXSL" as="xs:integer?">
      <xsl:param name="arg1" as="xs:date?"/>
      <xsl:sequence select="f:year-from-date($arg1)"/>
   </xsl:template>
   <xsl:function name="f:year-from-date" as="element()">
      <f:year-from-date/>
   </xsl:function>
   <xsl:function name="f:year-from-date" as="xs:integer?">
      <xsl:param name="pDate" as="xs:date?"/>
      <xsl:sequence select="year-from-date($pDate)"/>
    </xsl:function>
  <!--

   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      Function: month-from-date()
   -->
<xsl:template match="f:month-from-date" mode="f:FXSL" as="xs:integer?">
      <xsl:param name="arg1" as="xs:date?"/>
      <xsl:sequence select="f:month-from-date($arg1)"/>
   </xsl:template>
   <xsl:function name="f:month-from-date" as="element()">
      <f:month-from-date/>
   </xsl:function>
   <xsl:function name="f:month-from-date" as="xs:integer?">
      <xsl:param name="pDate" as="xs:date?"/>
      <xsl:sequence select="month-from-date($pDate)"/>
    </xsl:function>
  <!--

   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      Function: day-from-date()
   -->
<xsl:template match="f:day-from-date" mode="f:FXSL" as="xs:integer?">
      <xsl:param name="arg1" as="xs:date?"/>
      <xsl:sequence select="f:day-from-date($arg1)"/>
   </xsl:template>
   <xsl:function name="f:day-from-date" as="element()">
      <f:day-from-date/>
   </xsl:function>
   <xsl:function name="f:day-from-date" as="xs:integer?">
      <xsl:param name="pDate" as="xs:date?"/>
      <xsl:sequence select="day-from-date($pDate)"/>
    </xsl:function>
  <!--

   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      Function: timezone-from-date()
   -->
<xsl:template match="f:timezone-from-date" mode="f:FXSL" as="xs:dayTimeDuration?">
      <xsl:param name="arg1" as="xs:date?"/>
      <xsl:sequence select="f:timezone-from-date($arg1)"/>
   </xsl:template>
   <xsl:function name="f:timezone-from-date" as="element()">
      <f:timezone-from-date/>
   </xsl:function>
   <xsl:function name="f:timezone-from-date" as="xs:dayTimeDuration?">
      <xsl:param name="pDate" as="xs:date?"/>
      <xsl:sequence select="timezone-from-date($pDate)"/>
    </xsl:function>
  <!--

   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      Function: hours-from-time()
   -->
<xsl:template match="f:hours-from-time" mode="f:FXSL" as="xs:integer?">
      <xsl:param name="arg1" as="xs:time?"/>
      <xsl:sequence select="f:hours-from-time($arg1)"/>
   </xsl:template>
   <xsl:function name="f:hours-from-time" as="element()">
      <f:hours-from-time/>
   </xsl:function>
   <xsl:function name="f:hours-from-time" as="xs:integer?">
      <xsl:param name="pTime" as="xs:time?"/>
      <xsl:sequence select="hours-from-time($pTime)"/>
    </xsl:function>
  <!--

   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      Function: minutes-from-time()
   -->
<xsl:template match="f:minutes-from-time" mode="f:FXSL" as="xs:integer?">
      <xsl:param name="arg1" as="xs:time?"/>
      <xsl:sequence select="f:minutes-from-time($arg1)"/>
   </xsl:template>
   <xsl:function name="f:minutes-from-time" as="element()">
      <f:minutes-from-time/>
   </xsl:function>
   <xsl:function name="f:minutes-from-time" as="xs:integer?">
      <xsl:param name="pTime" as="xs:time?"/>
      <xsl:sequence select="minutes-from-time($pTime)"/>
    </xsl:function>
  <!--

   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      Function: seconds-from-time()
   -->
<xsl:template match="f:seconds-from-time" mode="f:FXSL" as="xs:decimal?">
      <xsl:param name="arg1" as="xs:time?"/>
      <xsl:sequence select="f:seconds-from-time($arg1)"/>
   </xsl:template>
   <xsl:function name="f:seconds-from-time" as="element()">
      <f:seconds-from-time/>
   </xsl:function>
   <xsl:function name="f:seconds-from-time" as="xs:decimal?">
      <xsl:param name="pTime" as="xs:time?"/>
      <xsl:sequence select="seconds-from-time($pTime)"/>
    </xsl:function>
  <!--

   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      Function: timezone-from-time()
   -->
<xsl:template match="f:timezone-from-time" mode="f:FXSL" as="xs:dayTimeDuration?">
      <xsl:param name="arg1" as="xs:time?"/>
      <xsl:sequence select="f:timezone-from-time($arg1)"/>
   </xsl:template>
   <xsl:function name="f:timezone-from-time" as="element()">
      <f:timezone-from-time/>
   </xsl:function>
   <xsl:function name="f:timezone-from-time" as="xs:dayTimeDuration?">
      <xsl:param name="pTime" as="xs:time?"/>
      <xsl:sequence select="timezone-from-time($pTime)"/>
    </xsl:function>
  <!--

   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      Function: adjust-dateTime-to-timezone()
   -->
<xsl:template match="f:adjust-dateTime-to-timezone" mode="f:FXSL" as="xs:dateTime?">
      <xsl:param name="arg1" as="xs:dateTime?"/>
      <xsl:param name="arg2" as="xs:dayTimeDuration?"/>
      <xsl:sequence select="f:adjust-dateTime-to-timezone($arg1,$arg2)"/>
   </xsl:template>
   <xsl:function name="f:adjust-dateTime-to-timezone" as="element()">
      <f:adjust-dateTime-to-timezone/>
   </xsl:function>
   <xsl:function name="f:adjust-dateTime-to-timezone" as="element()">
      <xsl:param name="pdateTime" as="xs:dateTime?"/>
      <xsl:sequence select="f:curry(f:adjust-dateTime-to-timezone(),2,$pdateTime)"/>
   </xsl:function>
   <xsl:function name="f:adjust-dateTime-to-timezone" as="xs:dateTime?">
      <xsl:param name="pdateTime" as="xs:dateTime?"/>
      <xsl:param name="ptimeZone" as="xs:dayTimeDuration?"/>
      <xsl:sequence select="adjust-dateTime-to-timezone($pdateTime,$ptimeZone)"/>
    </xsl:function>
  <!--

   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      Function: adjust-date-to-timezone()
   -->
<xsl:template match="f:adjust-date-to-timezone" mode="f:FXSL" as="xs:date?">
      <xsl:param name="arg1" as="xs:date?"/>
      <xsl:param name="arg2" as="xs:dayTimeDuration?"/>
      <xsl:sequence select="f:adjust-date-to-timezone($arg1,$arg2)"/>
   </xsl:template>
   <xsl:function name="f:adjust-date-to-timezone" as="element()">
      <f:adjust-date-to-timezone/>
   </xsl:function>
   <xsl:function name="f:adjust-date-to-timezone" as="element()">
      <xsl:param name="pDate" as="xs:date?"/>
      <xsl:sequence select="f:curry(f:adjust-date-to-timezone(),2,$pDate)"/>
   </xsl:function>
   <xsl:function name="f:adjust-date-to-timezone" as="xs:date?">
      <xsl:param name="pDate" as="xs:date?"/>
      <xsl:param name="ptimeZone" as="xs:dayTimeDuration?"/>
      <xsl:sequence select="adjust-date-to-timezone($pDate,$ptimeZone)"/>
    </xsl:function>
  <!--

   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      Function: adjust-time-to-timezone()
   -->
<xsl:template match="f:adjust-time-to-timezone" mode="f:FXSL" as="xs:time?">
      <xsl:param name="arg1" as="xs:time?"/>
      <xsl:param name="arg2" as="xs:dayTimeDuration?"/>
      <xsl:sequence select="f:adjust-time-to-timezone($arg1,$arg2)"/>
   </xsl:template>
   <xsl:function name="f:adjust-time-to-timezone" as="element()">
      <f:adjust-time-to-timezone/>
   </xsl:function>
   <xsl:function name="f:adjust-time-to-timezone" as="element()">
      <xsl:param name="pTime" as="xs:time?"/>
      <xsl:sequence select="f:curry(f:adjust-time-to-timezone(),2,$pTime)"/>
   </xsl:function>
   <xsl:function name="f:adjust-time-to-timezone" as="xs:time?">
      <xsl:param name="pTime" as="xs:time?"/>
      <xsl:param name="ptimeZone" as="xs:dayTimeDuration?"/>
      <xsl:sequence select="adjust-time-to-timezone($pTime,$ptimeZone)"/>
    </xsl:function>
</xsl:stylesheet>