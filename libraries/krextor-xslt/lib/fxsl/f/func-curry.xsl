<xsl:stylesheet version="2.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 xmlns:int="http://fxsl.sf.net/internal/curry"
 xmlns:f-curry="http://fxsl.sf.net/curry"
 exclude-result-prefixes="xs f f-curry int"
 >
  <xsl:import href="../f/func-type.xsl"/>

  <xsl:function name="f:curry">
    <xsl:param name="pFun" as="node()"/>
    <xsl:param name="pNargs" as="xs:integer"/>
    <xsl:param name="arg1"/>
    
    <xsl:if test="$pNargs &lt; 2 or $pNargs > 10">
      <xsl:message terminate="yes">
         [curry]Error: pNargs (number of arguments) of a fn to be 
                       curried must be between 2 and 10 inclusive
      </xsl:message>
    </xsl:if>
    <!-- else                                   -->
    <f-curry:f-curry>
      <fun><xsl:sequence select="$pFun"/></fun>
		    <cnArgs><xsl:value-of select="$pNargs"/></cnArgs>
        <xsl:sequence select="int:makeArg($arg1)"/>
    </f-curry:f-curry>    
  </xsl:function>
  
  <xsl:function name="f:curry">
    <xsl:param name="pFun" as="node()"/>
    <xsl:param name="pNargs" as="xs:integer"/>
    <xsl:param name="arg1"/>
    <xsl:param name="arg2"/>
    
    <xsl:if test="$pNargs &lt; 2 or $pNargs > 10">
      <xsl:message terminate="yes">
         [curry]Error: pNargs (number of arguments) of a fn to be 
                       curried must be between 2 and 10 inclusive
      </xsl:message>
    </xsl:if>
    <xsl:if test="$pNargs &lt; 3">
      <xsl:message terminate="yes">
         [curry]Error: pNargs (number of arguments) of a fn to be 
                       curried must be greater than the number of 
                       partial applications.
      </xsl:message>
    </xsl:if>
    <!-- else                                   -->
    <f-curry:f-curry>
      <fun><xsl:sequence select="$pFun"/></fun>
		    <cnArgs><xsl:value-of select="$pNargs"/></cnArgs>
        <xsl:sequence select="int:makeArg($arg1)"/>
        <xsl:sequence select="int:makeArg($arg2)"/>
    </f-curry:f-curry>    
  </xsl:function>
  
  <xsl:function name="f:curry">
    <xsl:param name="pFun" as="node()"/>
    <xsl:param name="pNargs" as="xs:integer"/>
    <xsl:param name="arg1"/>
    <xsl:param name="arg2"/>
    <xsl:param name="arg3"/>
    
    <xsl:if test="$pNargs &lt; 2 or $pNargs > 10">
      <xsl:message terminate="yes">
         [curry]Error: pNargs (number of arguments) of a fn to be 
                       curried must be between 2 and 10 inclusive
      </xsl:message>
    </xsl:if>
    <xsl:if test="$pNargs &lt; 4">
      <xsl:message terminate="yes">
         [curry]Error: pNargs (number of arguments) of a fn to be 
                       curried must be greater than the number of 
                       partial applications.
      </xsl:message>
    </xsl:if>
    <!-- else                                   -->
    <f-curry:f-curry>
      <fun><xsl:sequence select="$pFun"/></fun>
		    <cnArgs><xsl:value-of select="$pNargs"/></cnArgs>
        <xsl:sequence select="int:makeArg($arg1)"/>
        <xsl:sequence select="int:makeArg($arg2)"/>
        <xsl:sequence select="int:makeArg($arg3)"/>
    </f-curry:f-curry>    
  </xsl:function>
  
  <xsl:function name="f:curry">
    <xsl:param name="pFun" as="node()"/>
    <xsl:param name="pNargs" as="xs:integer"/>
    <xsl:param name="arg1"/>
    <xsl:param name="arg2"/>
    <xsl:param name="arg3"/>
    <xsl:param name="arg4"/>
    
    <xsl:if test="$pNargs &lt; 2 or $pNargs > 10">
      <xsl:message terminate="yes">
         [curry]Error: pNargs (number of arguments) of a fn to be 
                       curried must be between 2 and 10 inclusive
      </xsl:message>
    </xsl:if>
    <xsl:if test="$pNargs &lt; 5">
      <xsl:message terminate="yes">
         [curry]Error: pNargs (number of arguments) of a fn to be 
                       curried must be greater than the number of 
                       partial applications.
      </xsl:message>
    </xsl:if>
    <!-- else                                   -->
    <f-curry:f-curry>
      <fun><xsl:sequence select="$pFun"/></fun>
		    <cnArgs><xsl:value-of select="$pNargs"/></cnArgs>
        <xsl:sequence select="int:makeArg($arg1)"/>
        <xsl:sequence select="int:makeArg($arg2)"/>
        <xsl:sequence select="int:makeArg($arg3)"/>
        <xsl:sequence select="int:makeArg($arg4)"/>
    </f-curry:f-curry>    
  </xsl:function>
  
  <xsl:function name="f:curry">
    <xsl:param name="pFun" as="node()"/>
    <xsl:param name="pNargs" as="xs:integer"/>
    <xsl:param name="arg1"/>
    <xsl:param name="arg2"/>
    <xsl:param name="arg3"/>
    <xsl:param name="arg4"/>
    <xsl:param name="arg5"/>
    
    <xsl:if test="$pNargs &lt; 2 or $pNargs > 10">
      <xsl:message terminate="yes">
         [curry]Error: pNargs (number of arguments) of a fn to be 
                       curried must be between 2 and 10 inclusive
      </xsl:message>
    </xsl:if>
    <xsl:if test="$pNargs &lt; 6">
      <xsl:message terminate="yes">
         [curry]Error: pNargs (number of arguments) of a fn to be 
                       curried must be greater than the number of 
                       partial applications.
      </xsl:message>
    </xsl:if>
    <!-- else                                   -->
    <f-curry:f-curry>
      <fun><xsl:sequence select="$pFun"/></fun>
		    <cnArgs><xsl:value-of select="$pNargs"/></cnArgs>
        <xsl:sequence select="int:makeArg($arg1)"/>
        <xsl:sequence select="int:makeArg($arg2)"/>
        <xsl:sequence select="int:makeArg($arg3)"/>
        <xsl:sequence select="int:makeArg($arg4)"/>
        <xsl:sequence select="int:makeArg($arg5)"/>
    </f-curry:f-curry>    
  </xsl:function>
  
  <xsl:function name="f:curry">
    <xsl:param name="pFun" as="node()"/>
    <xsl:param name="pNargs" as="xs:integer"/>
    <xsl:param name="arg1"/>
    <xsl:param name="arg2"/>
    <xsl:param name="arg3"/>
    <xsl:param name="arg4"/>
    <xsl:param name="arg5"/>
    <xsl:param name="arg6"/>
    
    <xsl:if test="$pNargs &lt; 2 or $pNargs > 10">
      <xsl:message terminate="yes">
         [curry]Error: pNargs (number of arguments) of a fn to be 
                       curried must be between 2 and 10 inclusive
      </xsl:message>
    </xsl:if>
    <xsl:if test="$pNargs &lt; 7">
      <xsl:message terminate="yes">
         [curry]Error: pNargs (number of arguments) of a fn to be 
                       curried must be greater than the number of 
                       partial applications.
      </xsl:message>
    </xsl:if>
    <!-- else                                   -->
    <f-curry:f-curry>
      <fun><xsl:sequence select="$pFun"/></fun>
		    <cnArgs><xsl:value-of select="$pNargs"/></cnArgs>
        <xsl:sequence select="int:makeArg($arg1)"/>
        <xsl:sequence select="int:makeArg($arg2)"/>
        <xsl:sequence select="int:makeArg($arg3)"/>
        <xsl:sequence select="int:makeArg($arg4)"/>
        <xsl:sequence select="int:makeArg($arg5)"/>
        <xsl:sequence select="int:makeArg($arg6)"/>
    </f-curry:f-curry>    
  </xsl:function>
  
  <xsl:function name="f:curry">
    <xsl:param name="pFun" as="node()"/>
    <xsl:param name="pNargs" as="xs:integer"/>
    <xsl:param name="arg1"/>
    <xsl:param name="arg2"/>
    <xsl:param name="arg3"/>
    <xsl:param name="arg4"/>
    <xsl:param name="arg5"/>
    <xsl:param name="arg6"/>
    <xsl:param name="arg7"/>
    
    <xsl:if test="$pNargs &lt; 2 or $pNargs > 10">
      <xsl:message terminate="yes">
         [curry]Error: pNargs (number of arguments) of a fn to be 
                       curried must be between 2 and 10 inclusive
      </xsl:message>
    </xsl:if>
    <xsl:if test="$pNargs &lt; 8">
      <xsl:message terminate="yes">
         [curry]Error: pNargs (number of arguments) of a fn to be 
                       curried must be greater than the number of 
                       partial applications.
      </xsl:message>
    </xsl:if>
    <!-- else                                   -->
    <f-curry:f-curry>
      <fun><xsl:sequence select="$pFun"/></fun>
		    <cnArgs><xsl:value-of select="$pNargs"/></cnArgs>
        <xsl:sequence select="int:makeArg($arg1)"/>
        <xsl:sequence select="int:makeArg($arg2)"/>
        <xsl:sequence select="int:makeArg($arg3)"/>
        <xsl:sequence select="int:makeArg($arg4)"/>
        <xsl:sequence select="int:makeArg($arg5)"/>
        <xsl:sequence select="int:makeArg($arg6)"/>
        <xsl:sequence select="int:makeArg($arg7)"/>
    </f-curry:f-curry>    
  </xsl:function>
  
  <xsl:function name="f:curry">
    <xsl:param name="pFun" as="node()"/>
    <xsl:param name="pNargs" as="xs:integer"/>
    <xsl:param name="arg1"/>
    <xsl:param name="arg2"/>
    <xsl:param name="arg3"/>
    <xsl:param name="arg4"/>
    <xsl:param name="arg5"/>
    <xsl:param name="arg6"/>
    <xsl:param name="arg7"/>
    <xsl:param name="arg8"/>
    
    <xsl:if test="$pNargs &lt; 2 or $pNargs > 10">
      <xsl:message terminate="yes">
         [curry]Error: pNargs (number of arguments) of a fn to be 
                       curried must be between 2 and 10 inclusive
      </xsl:message>
    </xsl:if>
    <xsl:if test="$pNargs &lt; 9">
      <xsl:message terminate="yes">
         [curry]Error: pNargs (number of arguments) of a fn to be 
                       curried must be greater than the number of 
                       partial applications.
      </xsl:message>
    </xsl:if>
    <!-- else                                   -->
    <f-curry:f-curry>
      <fun><xsl:sequence select="$pFun"/></fun>
		    <cnArgs><xsl:value-of select="$pNargs"/></cnArgs>
        <xsl:sequence select="int:makeArg($arg1)"/>
        <xsl:sequence select="int:makeArg($arg2)"/>
        <xsl:sequence select="int:makeArg($arg3)"/>
        <xsl:sequence select="int:makeArg($arg4)"/>
        <xsl:sequence select="int:makeArg($arg5)"/>
        <xsl:sequence select="int:makeArg($arg6)"/>
        <xsl:sequence select="int:makeArg($arg7)"/>
        <xsl:sequence select="int:makeArg($arg8)"/>
    </f-curry:f-curry>    
  </xsl:function>
  
  <xsl:function name="f:curry">
    <xsl:param name="pFun" as="node()"/>
    <xsl:param name="pNargs" as="xs:integer"/>
    <xsl:param name="arg1"/>
    <xsl:param name="arg2"/>
    <xsl:param name="arg3"/>
    <xsl:param name="arg4"/>
    <xsl:param name="arg5"/>
    <xsl:param name="arg6"/>
    <xsl:param name="arg7"/>
    <xsl:param name="arg8"/>
    <xsl:param name="arg9"/>
    
    <xsl:if test="$pNargs &lt; 2 or $pNargs > 10">
      <xsl:message terminate="yes">
         [curry]Error: pNargs (number of arguments) of a fn to be 
                       curried must be between 2 and 10 inclusive
      </xsl:message>
    </xsl:if>
    <xsl:if test="$pNargs &lt; 10">
      <xsl:message terminate="yes">
         [curry]Error: pNargs (number of arguments) of a fn to be 
                       curried must be greater than the number of 
                       partial applications.
      </xsl:message>
    </xsl:if>
    <!-- else                                   -->
    <f-curry:f-curry>
      <fun><xsl:sequence select="$pFun"/></fun>
		    <cnArgs><xsl:value-of select="$pNargs"/></cnArgs>
        <xsl:sequence select="int:makeArg($arg1)"/>
        <xsl:sequence select="int:makeArg($arg2)"/>
        <xsl:sequence select="int:makeArg($arg3)"/>
        <xsl:sequence select="int:makeArg($arg4)"/>
        <xsl:sequence select="int:makeArg($arg5)"/>
        <xsl:sequence select="int:makeArg($arg6)"/>
        <xsl:sequence select="int:makeArg($arg7)"/>
        <xsl:sequence select="int:makeArg($arg8)"/>
        <xsl:sequence select="int:makeArg($arg9)"/>
    </f-curry:f-curry>    
  </xsl:function>
  
  <xsl:function name="int:makeArg" as="element()">
    <xsl:param name="arg1"/>
    <arg>
      <xsl:choose>
        <xsl:when test="exists($arg1[2])">
          <xsl:attribute name="s"/>
          
          <xsl:for-each select="$arg1">
            <e t="{f:type(.)}"><xsl:sequence select="."/></e>
          </xsl:for-each>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="t" select="f:type($arg1)"/>
          <xsl:sequence select="$arg1"/>
        </xsl:otherwise>
      </xsl:choose>
    </arg>
  </xsl:function>
  
  <xsl:function name="int:getArg">
    <xsl:param name="pargNode" as="element()*"/>
    
    <xsl:sequence select=
     "if(not($pargNode/@s))
        then 
           if(not($pargNode/@t) or $pargNode/@t = 'xml:node')
              then $pargNode/node()
              else
                f:apply(f:Constructor($pargNode/@t), $pargNode/node() )
        else
          for $varg in $pargNode/e/node()
            return  
               if(not($varg/../@t) or $varg/../@t = 'xml:node')
                  then $varg
                  else
                     f:apply(f:Constructor($varg/../@t), $varg )
     "
    />
  </xsl:function>

  <xsl:template match="f-curry:*" mode="f:FXSL">
    <xsl:param name="arg1" select="()"/>
    <xsl:param name="arg2" select="()"/>
    <xsl:param name="arg3" select="()"/>
    <xsl:param name="arg4" select="()"/>
    <xsl:param name="arg5" select="()"/>
    <xsl:param name="arg6" select="()"/>
    <xsl:param name="arg7" select="()"/>
    <xsl:param name="arg8" select="()"/>
    <xsl:param name="arg9" select="()"/>
    
    <xsl:variable name="vLastArg" as="xs:integer"
     select="if(exists($arg9)) then 9
               else if(exists($arg8)) then 8
               else if(exists($arg7)) then 7
               else if(exists($arg6)) then 6
               else if(exists($arg5)) then 5
               else if(exists($arg4)) then 4
               else if(exists($arg3)) then 3
               else if(exists($arg2)) then 2
               else if(exists($arg1)) then 1
               else 
                error((), 
                 '[Error]Currying: At least one non-empty argument must be provided to a curried function.'
                     )"
     />
     
     <xsl:variable name="vTotalArgs" as="xs:integer"
      select="$vLastArg + count(arg)"/>
      
      <xsl:choose>
        <xsl:when test="$vTotalArgs > 10">
          <xsl:sequence select=
          "error((), '[Error]Currying: More than 10 arguments provided')"/>
        </xsl:when>
        
        <xsl:otherwise>
          <xsl:variable name="vCurried" as="element()">
            <f-curry:f-curry>
              <xsl:copy-of select="*"/>
              <xsl:for-each select="1 to $vLastArg">
                <xsl:sequence select=
                "int:makeArg(if(. eq 1)then $arg1
                           else if(. eq 2) then $arg2
                           else if(. eq 3) then $arg3
                           else if(. eq 4) then $arg4
                           else if(. eq 5) then $arg5
                           else if(. eq 6) then $arg6
                           else if(. eq 7) then $arg7
                           else if(. eq 8) then $arg8
                           else if(. eq 9) then $arg9
                           else(error((),'[Error]Currying: Must not happen 1'))
                           )"
                />
              </xsl:for-each>
            </f-curry:f-curry>
          </xsl:variable>
          
          <xsl:choose>
          <xsl:when test="$vTotalArgs eq xs:integer(cnArgs)">
            <xsl:apply-templates select="fun/*[1]" mode="f:FXSL">
              <xsl:with-param name="arg1" select="int:getArg($vCurried/arg[1])"/>
              <xsl:with-param name="arg2" select="int:getArg($vCurried/arg[2])"/>
              <xsl:with-param name="arg3" select="int:getArg($vCurried/arg[3])"/>
              <xsl:with-param name="arg4" select="int:getArg($vCurried/arg[4])"/>
              <xsl:with-param name="arg5" select="int:getArg($vCurried/arg[5])"/>
              <xsl:with-param name="arg6" select="int:getArg($vCurried/arg[6])"/>
              <xsl:with-param name="arg7" select="int:getArg($vCurried/arg[7])"/>
              <xsl:with-param name="arg8" select="int:getArg($vCurried/arg[8])"/>
              <xsl:with-param name="arg9" select="int:getArg($vCurried/arg[9])"/>
              <xsl:with-param name="arg10" select="int:getArg($vCurried/arg[10])"/>
            </xsl:apply-templates>
          </xsl:when>
          <xsl:otherwise>
            <xsl:sequence select="$vCurried"/>
          </xsl:otherwise>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
  </xsl:template>
  
</xsl:stylesheet>
