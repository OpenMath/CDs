

<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:om="http://www.openmath.org/OpenMath"
  xmlns="http://www.w3.org/1998/Math/MathML"
  version="2.0"
>


<xsl:template match="om:OMS[@cd='calculus1' and @name='diff']"  >
   <xsl:choose>
<!--
If the body is a lambda expression, put the bound variable in the
subscript, and just typeset the body of the lambda expression,
zap the lambda.
-->
   <xsl:when test="following-sibling::*[1]/self::om:OMBIND/*[1][self::om:OMS[@name='lambda']]">
    <mfrac>
     <mi>d</mi>
    <mrow>
     <mi>d</mi>
     <xsl:apply-templates select="following-sibling::om:OMBIND/om:OMBVAR"/>
    </mrow>
    </mfrac>
    <mrow>
     <mo>(</mo>
     <xsl:apply-templates select="following-sibling::om:OMBIND/*[3]"/>
     <mo>)</mo>
    </mrow>
   </xsl:when>
   <xsl:otherwise>
   <mo>D</mo>
   <mrow>
     <mo>(</mo>
     <xsl:apply-templates select="following-sibling::*[1]"/>
     <mo>)</mo>
   </mrow>
   </xsl:otherwise>
  </xsl:choose>
</xsl:template>


<xsl:template match="om:OMS[@cd='calculus1' and @name='nthdiff']"  >
   <xsl:choose>
<!--
If the body is a lambda expression, put the bound variable in the
subscript, and just typeset the body of the lambda expression,
zap the lambda.
-->
   <xsl:when test="following-sibling::*[2]/self::om:OMBIND/*[1][self::om:OMS[@name='lambda']]">
    <mfrac>
     <msup><mi>d</mi><xsl:apply-templates select="following-sibling::*[1]"/></msup>
    <mrow>
     <mi>d</mi>
     <msup>
        <xsl:apply-templates select="following-sibling::om:OMBIND/om:OMBVAR"/>
        <xsl:apply-templates select="following-sibling::*[1]"/>
     </msup>
    </mrow>
    </mfrac>
    <mrow>
     <mo>(</mo>
     <xsl:apply-templates select="following-sibling::om:OMBIND/*[3]"/>
     <mo>)</mo>
    </mrow>
   </xsl:when>
   <xsl:otherwise>
   <msup><mo>D</mo><xsl:apply-templates select="following-sibling::*[1]"/></msup>
   <mrow>
     <mo>(</mo>
     <xsl:apply-templates select="following-sibling::*[2]"/>
     <mo>)</mo>
   </mrow>
   </xsl:otherwise>
  </xsl:choose>
</xsl:template>



<xsl:template match="om:OMS[@cd='calculus1' and @name='int']"  >
   <xsl:choose>
<!--
If the body is a lambda expression, put the bound variable in the
subscript, and just typeset the body of the lambda expression,
zap the lambda.
-->
   <xsl:when test="following-sibling::*[1]/self::om:OMBIND/*[1][self::om:OMS[@name='lambda']]">
    <mo>&#x222B;</mo>
    <mrow>
     <xsl:apply-templates select="following-sibling::om:OMBIND/*[3]"/>
    </mrow>
    <mrow>
     <mi>d</mi>
     <xsl:apply-templates select="following-sibling::om:OMBIND/om:OMBVAR"/>
    </mrow>
   </xsl:when>
   <xsl:otherwise>
   <mo>&#x222B;</mo>
   <mrow>
     <mo>(</mo>
     <xsl:apply-templates select="following-sibling::*[1]"/>
     <mo>)</mo>
   </mrow>
   </xsl:otherwise>
  </xsl:choose>
</xsl:template>





<xsl:template
  match="om:OMS[@cd='calculus1' and @name='defint']"  >
   <xsl:choose>
<!--
If the body is a lambda expression, put the bound variable in the
subscript, and just typeset the body of the lambda expression,
zap the lambda.
-->
   <xsl:when test="following-sibling::*[2]/self::om:OMBIND/*[1][self::om:OMS[@name='lambda']]">

   <xsl:choose>
<!--
If there is an explicit interval put limits top and bottom
else put range of summation at bottom
-->
   <xsl:when test="following-sibling::*[1]/self::om:OMA/*[1][self::om:OMS[@name='interval']]">
   <munderover>
     <mo>&#x222B;</mo>
   <xsl:apply-templates select="following-sibling::om:OMA/*[2]"/>
   <xsl:apply-templates select="following-sibling::om:OMA/*[3]"/>
   </munderover>
   </xsl:when>
   <xsl:otherwise>
   <msub>
   <mo>&#x222B;</mo>
   <xsl:apply-templates select="following-sibling::*[1]"/>
   </msub>
   </xsl:otherwise>
   </xsl:choose>
   <mrow>
   <xsl:apply-templates select="following-sibling::om:OMBIND/*[3]"/>
   </mrow>
   <mrow>
     <mi>d</mi>
     <xsl:apply-templates select="following-sibling::om:OMBIND/om:OMBVAR"/>
   </mrow>
   </xsl:when>

<!--
 No lambda
-->
   <xsl:otherwise>
   <xsl:choose>
<!--
If there is an explicit interval put limits top and bottom
else put range of summation at bottom
-->
   <xsl:when test="following-sibling::*[1]/self::om:OMA/*[1][self::om:OMS[@name='interval']]">
   <munderover>
   <mo>&#x222B;</mo>
   <xsl:apply-templates select="following-sibling::om:OMA/*[2]"/>
   <xsl:apply-templates select="following-sibling::om:OMA/*[3]"/>
   </munderover>
   </xsl:when>
   <xsl:otherwise>
   <msub>
   <mo>&#x222B;</mo>
   <xsl:apply-templates select="following-sibling::*[1]"/>
   </msub>
   </xsl:otherwise>
   </xsl:choose>
   <xsl:apply-templates select="following-sibling::*[2]"/>
   </xsl:otherwise>
   </xsl:choose>
</xsl:template>




<xsl:template match="om:OMS[@cd='calculus1' and @name='partialnthdiff']"  >
   <xsl:choose>
<!--
If the body is a lambda expression, use d^2/dx/dy otherwise use D_1,2
-->
   <xsl:when test="following-sibling::*[2]/self::om:OMBIND/*[1][self::om:OMS[@name='lambda']]">
    <mfrac>
     <msup>
       <mi>&#x2202;</mi>
       <mrow>
	 <xsl:variable name="i" select="sum(following-sibling::*[1]/om:OMI)"/>
	 <xsl:for-each select="following-sibling::*[1]/*[position()!=1][not(self::om:OMI)]">
	   <xsl:apply-templates select="."/>
	   <xsl:if test="position()!=last() or $i!=0"><mo>+</mo></xsl:if>
	 </xsl:for-each>
	 <xsl:if test="$i!=0">
	   <mn><xsl:value-of select="$i"/></mn>
	 </xsl:if>
       </mrow>
     </msup>
    <mrow>
<!-- old bad? mode
      <xsl:apply-templates mode="dx" 
                           select="following-sibling::*[1]/om:OMI[1]"/>
-->
    <xsl:variable name="d" select="following-sibling::*[1]/*[position()!=1]"/>
    <xsl:for-each select="following-sibling::om:OMBIND/om:OMBVAR/*">
      <xsl:variable name="p" select="position()"/>
      <mrow>
	<mo>&#x2202;</mo>
	<xsl:choose>
	  <xsl:when test="$d[$p]='1'">
	    <xsl:apply-templates select="."/>
	  </xsl:when>
	  <xsl:otherwise>
	    <msup>
	      <xsl:apply-templates select="."/>
	      <xsl:apply-templates select="$d[$p]"/>
	    </msup>
	  </xsl:otherwise>
	</xsl:choose>
      </mrow>
    </xsl:for-each>
    </mrow>
    </mfrac>
    <mrow>
     <mo>(</mo>
     <xsl:apply-templates select="following-sibling::om:OMBIND/*[3]"/>
     <mo>)</mo>
    </mrow>
   </xsl:when>
   <xsl:otherwise>
     <mrow>
       <msub>
	 <mi>D</mi>
	 <mrow>
	   <mo>(</mo>
	   <xsl:apply-templates select="following-sibling::*[1]"/>
	   <mo>)</mo>
	 </mrow>
       </msub>
       <xsl:apply-templates select="following-sibling::*[last()]"/>
     </mrow>
   </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="om:OMS[@cd='calculus1' and @name='partialdiff']"  >
   <xsl:choose>
<!--
If the body is a lambda expression, use d^2/dx/dy otherwise use D_1,2
-->
   <xsl:when test="following-sibling::*[2]/self::om:OMBIND/*[1][self::om:OMS[@name='lambda']]">
    <mfrac>
     <msup>
       <mi>&#x2202;</mi>
       <mn><xsl:value-of select="count(following-sibling::*[1]/om:OMI)"/></mn>     
     </msup>
     <mrow>
       <xsl:apply-templates mode="dx" 
			    select="following-sibling::*[1]/om:OMI[1]"/>

    </mrow>
    </mfrac>
    <mrow>
     <mo>(</mo>
     <xsl:apply-templates select="following-sibling::om:OMBIND/*[3]"/>
     <mo>)</mo>
    </mrow>
   </xsl:when>
   <xsl:otherwise>
     <mrow>
       <msub>
	 <mi>D</mi>
	 <mrow>
	   <xsl:apply-templates select="following-sibling::*[1]"/>
	 </mrow>
       </msub>
       <xsl:apply-templates select="following-sibling::*[1]"/>
     </mrow>
   </xsl:otherwise>
   </xsl:choose>
</xsl:template>

<xsl:template mode="dx" match="om:OMI">
  <xsl:param name="n" select="1"/>
  <xsl:variable name="v" select="../following-sibling::om:OMBIND/om:OMBVAR"/>
  <xsl:choose>
    <xsl:when 
       test="following-sibling::om:OMI[1][number(.) = number(current())]">
     <xsl:apply-templates mode="dx" 
                           select="following-sibling::om:OMI[1]">
       <xsl:with-param name="n" select="$n+1"/>
     </xsl:apply-templates>
   </xsl:when>
   <xsl:otherwise>
     <mrow>
     <mi>&#x2202;</mi>
     <xsl:choose>
       <xsl:when test="$n=1">
         <xsl:apply-templates select="$v/*[position()=current()]"/>
       </xsl:when>
       <xsl:otherwise>
         <msup>
           <xsl:apply-templates select="$v/*[position()=current()]"/>
           <mn><xsl:value-of select="$n"/></mn>
         </msup>
       </xsl:otherwise>
     </xsl:choose>
     </mrow>
     <xsl:apply-templates mode="dx" 
                           select="following-sibling::om:OMI[1]"/>
   </xsl:otherwise>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>



