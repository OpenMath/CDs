<xsl:stylesheet version="2.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f"
>

  <xsl:function name="f:apply">
   <xsl:param name="pFunc" as="element()"/>
   <xsl:param name="arg1"/>

    <xsl:apply-templates select="$pFunc" mode="f:FXSL">
      <xsl:with-param name="arg1" select="$arg1"/>
    </xsl:apply-templates>
  </xsl:function>

  <xsl:function name="f:apply">
   <xsl:param name="pFunc" as="element()"/>
   <xsl:param name="arg1"/>
   <xsl:param name="arg2"/>
   
    <xsl:apply-templates select="$pFunc" mode="f:FXSL">
      <xsl:with-param name="arg1" select="$arg1"/>
      <xsl:with-param name="arg2" select="$arg2"/>
    </xsl:apply-templates>
  </xsl:function>


  <xsl:function name="f:apply">
   <xsl:param name="pFunc" as="element()"/>
   <xsl:param name="arg1"/>
   <xsl:param name="arg2"/>
   <xsl:param name="arg3"/>

    <xsl:apply-templates select="$pFunc" mode="f:FXSL">
      <xsl:with-param name="arg1" select="$arg1"/>
      <xsl:with-param name="arg2" select="$arg2"/>
      <xsl:with-param name="arg3" select="$arg3"/>
    </xsl:apply-templates>
  </xsl:function>

  <xsl:function name="f:apply">
   <xsl:param name="pFunc" as="element()"/>
   <xsl:param name="arg1"/>
   <xsl:param name="arg2"/>
   <xsl:param name="arg3"/>
   <xsl:param name="arg4"/>
   
    <xsl:apply-templates select="$pFunc" mode="f:FXSL">
      <xsl:with-param name="arg1" select="$arg1"/>
      <xsl:with-param name="arg2" select="$arg2"/>
      <xsl:with-param name="arg3" select="$arg3"/>
      <xsl:with-param name="arg4" select="$arg4"/>
    </xsl:apply-templates>
  </xsl:function>

  <xsl:function name="f:apply">
   <xsl:param name="pFunc" as="element()"/>
   <xsl:param name="arg1"/>
   <xsl:param name="arg2"/>
   <xsl:param name="arg3"/>
   <xsl:param name="arg4"/>
   <xsl:param name="arg5"/>
   
    <xsl:apply-templates select="$pFunc" mode="f:FXSL">
      <xsl:with-param name="arg1" select="$arg1"/>
      <xsl:with-param name="arg2" select="$arg2"/>
      <xsl:with-param name="arg3" select="$arg3"/>
      <xsl:with-param name="arg4" select="$arg4"/>
      <xsl:with-param name="arg5" select="$arg5"/>
    </xsl:apply-templates>
  </xsl:function>

  <xsl:function name="f:apply">
   <xsl:param name="pFunc" as="element()"/>
   <xsl:param name="arg1"/>
   <xsl:param name="arg2"/>
   <xsl:param name="arg3"/>
   <xsl:param name="arg4"/>
   <xsl:param name="arg5"/>
   <xsl:param name="arg6"/>
   
    <xsl:apply-templates select="$pFunc" mode="f:FXSL">
      <xsl:with-param name="arg1" select="$arg1"/>
      <xsl:with-param name="arg2" select="$arg2"/>
      <xsl:with-param name="arg3" select="$arg3"/>
      <xsl:with-param name="arg4" select="$arg4"/>
      <xsl:with-param name="arg5" select="$arg5"/>
      <xsl:with-param name="arg6" select="$arg6"/>
    </xsl:apply-templates>
  </xsl:function>

  <xsl:function name="f:apply">
   <xsl:param name="pFunc" as="element()"/>
   <xsl:param name="arg1"/>
   <xsl:param name="arg2"/>
   <xsl:param name="arg3"/>
   <xsl:param name="arg4"/>
   <xsl:param name="arg5"/>
   <xsl:param name="arg6"/>
   <xsl:param name="arg7"/>
   
    <xsl:apply-templates select="$pFunc" mode="f:FXSL">
      <xsl:with-param name="arg1" select="$arg1"/>
      <xsl:with-param name="arg2" select="$arg2"/>
      <xsl:with-param name="arg3" select="$arg3"/>
      <xsl:with-param name="arg4" select="$arg4"/>
      <xsl:with-param name="arg5" select="$arg5"/>
      <xsl:with-param name="arg6" select="$arg6"/>
      <xsl:with-param name="arg7" select="$arg7"/>
    </xsl:apply-templates>
  </xsl:function>

  <xsl:function name="f:apply">
   <xsl:param name="pFunc" as="element()"/>
   <xsl:param name="arg1"/>
   <xsl:param name="arg2"/>
   <xsl:param name="arg3"/>
   <xsl:param name="arg4"/>
   <xsl:param name="arg5"/>
   <xsl:param name="arg6"/>
   <xsl:param name="arg7"/>
   <xsl:param name="arg8"/>
   
    <xsl:apply-templates select="$pFunc" mode="f:FXSL">
      <xsl:with-param name="arg1" select="$arg1"/>
      <xsl:with-param name="arg2" select="$arg2"/>
      <xsl:with-param name="arg3" select="$arg3"/>
      <xsl:with-param name="arg4" select="$arg4"/>
      <xsl:with-param name="arg5" select="$arg5"/>
      <xsl:with-param name="arg6" select="$arg6"/>
      <xsl:with-param name="arg7" select="$arg7"/>
      <xsl:with-param name="arg8" select="$arg8"/>
    </xsl:apply-templates>
  </xsl:function>

  <xsl:function name="f:apply">
   <xsl:param name="pFunc" as="element()"/>
   <xsl:param name="arg1"/>
   <xsl:param name="arg2"/>
   <xsl:param name="arg3"/>
   <xsl:param name="arg4"/>
   <xsl:param name="arg5"/>
   <xsl:param name="arg6"/>
   <xsl:param name="arg7"/>
   <xsl:param name="arg8"/>
   <xsl:param name="arg9"/>
   
    <xsl:apply-templates select="$pFunc" mode="f:FXSL">
      <xsl:with-param name="arg1" select="$arg1"/>
      <xsl:with-param name="arg2" select="$arg2"/>
      <xsl:with-param name="arg3" select="$arg3"/>
      <xsl:with-param name="arg4" select="$arg4"/>
      <xsl:with-param name="arg5" select="$arg5"/>
      <xsl:with-param name="arg6" select="$arg6"/>
      <xsl:with-param name="arg7" select="$arg7"/>
      <xsl:with-param name="arg8" select="$arg8"/>
      <xsl:with-param name="arg9" select="$arg9"/>
    </xsl:apply-templates>
  </xsl:function>

  <xsl:function name="f:apply">
   <xsl:param name="pFunc" as="element()"/>
   <xsl:param name="arg1"/>
   <xsl:param name="arg2"/>
   <xsl:param name="arg3"/>
   <xsl:param name="arg4"/>
   <xsl:param name="arg5"/>
   <xsl:param name="arg6"/>
   <xsl:param name="arg7"/>
   <xsl:param name="arg8"/>
   <xsl:param name="arg9"/>
   <xsl:param name="arg10"/>
   
    <xsl:apply-templates select="$pFunc" mode="f:FXSL">
      <xsl:with-param name="arg1" select="$arg1"/>
      <xsl:with-param name="arg2" select="$arg2"/>
      <xsl:with-param name="arg3" select="$arg3"/>
      <xsl:with-param name="arg4" select="$arg4"/>
      <xsl:with-param name="arg5" select="$arg5"/>
      <xsl:with-param name="arg6" select="$arg6"/>
      <xsl:with-param name="arg7" select="$arg7"/>
      <xsl:with-param name="arg8" select="$arg8"/>
      <xsl:with-param name="arg9" select="$arg9"/>
      <xsl:with-param name="arg10" select="$arg10"/>
    </xsl:apply-templates>
  </xsl:function>
</xsl:stylesheet>
