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
    xmlns:xd="http://www.pnp-software.com/XSLTdoc"
    xmlns:krextor="http://kwarc.info/projects/krextor"
    exclude-result-prefixes="#all"
    version="2.0">
  <xd:doc type="stylesheet">A collection of miscellaneous utility functions
	<xd:author>Christoph Lange</xd:author>
	<xd:copyright>Christoph Lange, 2010</xd:copyright>
	<xd:svnId>$Id: misc.xsl 1964 2011-04-06 16:56:19Z lucianct $</xd:svnId>
    </xd:doc>

    <xd:doc>Changes the first character of a string to uppercase (returns a sequence, whose first item is the uppercased first character, and whose second item is the rest of the string)</xd:doc>
    <function name="krextor:ucfirst-as-sequence">
	<param name="string"/>
		<analyze-string select="$string" regex="^(.)">
		    <matching-substring>
			<value-of select="upper-case(regex-group(1))"/>
		    </matching-substring>
		    <non-matching-substring>
			<value-of select="."/>
		    </non-matching-substring>
		</analyze-string>
    </function>

    <xd:doc>Changes the first character of a string to uppercase (as <code>ucfirst</code> in Perl)</xd:doc>
    <function name="krextor:ucfirst">
	<param name="string"/>
	<value-of select="string-join(krextor:ucfirst-as-sequence($string), '')"/>
    </function>

    <xd:doc>Transforms e.g. false-conjecture → FalseConjecture</xd:doc>
    <function name="krextor:dashes-to-camelcase">
	<param name="type"/>
	<variable name="capitalized-tokens">
	    <for-each select="tokenize($type, '-')">
		<value-of select="krextor:ucfirst-as-sequence(.)"/>
	    </for-each>
	</variable>
	<value-of select="string-join($capitalized-tokens, '')"/>
    </function>
</stylesheet>
