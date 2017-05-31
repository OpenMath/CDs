<?xml version="1.0" encoding="UTF-8"?>

<!--
    *  Copyright (C) 2010
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

<stylesheet xmlns="http://www.w3.org/1999/XSL/Transform" 
    xmlns:om="http://www.openmath.org/OpenMath"
    xmlns:m="http://www.w3.org/1998/Math/MathML"
    xmlns:xd="http://www.pnp-software.com/XSLTdoc"
    exclude-result-prefixes="#all"
    version="2.0">
  <xd:doc type="stylesheet">A collection of utility functions for <a href="http://www.omdoc.org">OMDoc</a>/<a href="http://www.openmath.org">OpenMath</a> notation definitions
	<xd:author>Christoph Lange</xd:author>
	<xd:copyright>Christoph Lange, 2010</xd:copyright>
	<xd:svnId>$Id: ntn.xsl 889 2010-01-11 12:21:01Z clange $</xd:svnId>
    </xd:doc>

    <xd:doc>Determine the symbol that a prototype element (OMDoc or MathML CD namespace) matches.  Returns a dummy element with @cdbase, @cd, and @name attributes.</xd:doc>
    <function name="om:matched-symbol">
    <!-- the mcd:prototype element -->
    <param name="prototype"/>
    <variable name="symbol" select="$prototype/(
        (: FIXME is this correct, or too simple? :)
        descendant::om:OMS
        (: TODO make OpenMath and MathML handling completely equivalent :)
        |descendant::m:csymbol|m:semantics/m:annotation-xml)[1]"/>
    <om:_>
        <for-each select="'cdbase', 'cd', 'name'">
        <variable name="attribute" select="$symbol/@*[local-name() eq current()]"/>
        <if test="$attribute">
            <attribute name="{current()}" select="$attribute"/>
        </if>
        </for-each>
    </om:_>
    </function>
</stylesheet>
