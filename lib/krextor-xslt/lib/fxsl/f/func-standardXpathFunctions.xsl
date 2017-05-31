<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:xdt="http://www.w3.org/2005/04/xpath-datatypes" 
 xmlns:xdtOld="http://www.w3.org/2005/02/xpath-datatypes" 
 xmlns:xdtOld2="http://www.w3.org/2004/10/xpath-datatypes" 
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="xs xdt f"
>
<!--
       This module contains the FXSL versions of the "standard" XPath functions
                                                                               
       These are intended as convenience functions, so that they can be passed 
       as parameters to other functions (e.g. to f:zipWith())                  
       or curried and passed as parameters (e.g. to f:map())                   
-->

 <xsl:import href="func-curry.xsl"/>
 <xsl:import href="func-compose-flist.xsl"/>
 
 <xsl:import href="func-standardArithmeticXpathFunctions.xsl"/>
 <xsl:import href="func-standardBooleanXpathFunctions.xsl"/>
 <xsl:import href="func-standardStringXpathFunctions.xsl"/>
 <xsl:import href="func-standardNodesXpathFunctions.xsl"/>
 <xsl:import href="func-standardSequencesXpathFunctions.xsl"/>
 <xsl:import href="func-standardAggregateXpathFunctions.xsl"/>
 <xsl:import href="func-standardDateTimeXpathFunctions.xsl"/>
 <xsl:import href="func-standardXSLTXpathFunctions.xsl"/>
 <xsl:import href="func-standardAxisXpathFunctions.xsl"/>
 
</xsl:stylesheet>