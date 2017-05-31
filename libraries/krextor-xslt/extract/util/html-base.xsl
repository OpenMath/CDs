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

<stylesheet xmlns="http://www.w3.org/1999/XSL/Transform" 
    xpath-default-namespace="http://www.w3.org/1999/xhtml"
    xmlns:xd="http://www.pnp-software.com/XSLTdoc"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:krextor="http://kwarc.info/projects/krextor"
    version="2.0">
    <xd:doc type="stylesheet">
	Sets the base URI of the document according to the XHTML specification
	<xd:author>Christoph Lange</xd:author>
	<xd:copyright>Christoph Lange, 2009</xd:copyright>
	<xd:svnId>$Id: html-base.xsl 816 2009-11-21 16:50:57Z clange $</xd:svnId>
    </xd:doc>

    <xd:doc>Use the base URI from the <code>base</code> element in the <code>head</code>, if present</xd:doc>
    <template match="/" mode="krextor:main">
	<variable name="base-uri" select="/html/head/base[1]/@href"/>
	<choose>
	    <when test="$base-uri">
		<apply-imports>
		    <with-param name="krextor:base-uri" select="$base-uri" tunnel="yes"/>
		</apply-imports>
	    </when>
	    <otherwise>
		<apply-imports/>
	    </otherwise>
	</choose>
    </template>
</stylesheet>
