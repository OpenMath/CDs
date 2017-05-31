<?xml version="1.0" encoding="UTF-8"?>

<!--
    *  Copyright (C) 2008
    *  Christoph Lange
    *  KWARC, Jacobs University Bremen
    *  http://kwarc.info/projects/krextor/
    *
    *   Krextor is free software; you can redistribute it and/or
    * 	modify it under the terms of the GNU Lesser General Public
    * 	License as published by the Free Software Foundation; either
    * 	version 2 of the License, or (at your option) any later version.
    *
    * 	This program is distributed in the hope that it will be useful,
    * 	but WITHOUT ANY WARRANTY; without even the implied warranty of
    * 	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    * 	Lesser General Public License for more details.
    *
    * 	You should have received a copy of the GNU Lesser General Public
    * 	License along with this library; if not, write to the
    * 	Free Software Foundation, Inc., 59 Temple Place - Suite 330,
    * 	Boston, MA 02111-1307, USA.
    * 
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:om="http://www.openmath.org/OpenMath"
    xmlns:m="http://www.w3.org/1998/Math/MathML"
    xmlns:xd="http://www.pnp-software.com/XSLTdoc"
    exclude-result-prefixes="#all"
    version="2.0">
    <xsl:import href="misc.xsl"/>
    <!-- Render OpenMath to Content MathML -->
    <xsl:import href="openmath/om2cmml.xsl"/>
    <!-- Render OpenMath to Popcorn -->
    <xsl:import href="openmath/omobj2popcorn.xsl"/>

    <xsl:include href="ntn.xsl"/>

    <xd:doc type="stylesheet">A collection of utility functions for <a href="http://www.openmath.org">OpenMath</a> symbols and objects
	<xd:author>Christoph Lange</xd:author>
	<xd:copyright>Christoph Lange, 2008</xd:copyright>
	<xd:svnId>$Id: openmath.xsl 1969 2011-04-15 23:05:12Z clange $</xd:svnId>
    </xd:doc>

    <xsl:function name="om:cdbase-or-default">
	<xsl:param name="cdbase"/>
	<xsl:sequence select="if ($cdbase) then $cdbase else 'http://www.openmath.org/cd'"/>
    </xsl:function>

    <xd:doc>Canonical URI for a symbol (OpenMath 2.0 standard, section 2.3)</xd:doc>
    <xsl:function name="om:symbol-uri">
	<xsl:param name="cdbase"/>
	<xsl:param name="cd"/>
	<xsl:param name="name"/>
	<xsl:sequence select="concat(om:cdbase-or-default($cdbase), '/', $cd, '#', $name)"/>
    </xsl:function>

</xsl:stylesheet>
