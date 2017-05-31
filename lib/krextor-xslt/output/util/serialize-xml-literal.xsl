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
    xmlns:xd="http://www.pnp-software.com/XSLTdoc"
    xmlns:krextor="http://kwarc.info/projects/krextor"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    version="2.0">
    <import href="../../extract/util/openmath/verb.xsl"/>

    <xd:doc type="stylesheet">
	<xd:short>Serialize XML literals into strings</xd:short>
	<xd:author>Christoph Lange</xd:author>
	<xd:copyright>Christoph Lange, 2011</xd:copyright>
	<xd:svnId>$Id: serialize-xml-literal.xsl 1972 2011-04-16 23:11:44Z clange $</xd:svnId>
    </xd:doc>

    <template name="krextor:preprocess-object-for-output">
       <param name="object"/>
       <choose>
           <when test="$object instance of element()">
               <variable name="temp">
                   <apply-templates mode="verb" select="$object"/>
               </variable>
               <!-- we need this because 'verb' returns a sequence -->
               <value-of select="$temp"/>
           </when>
           <otherwise>
               <value-of select="$object"/>
           </otherwise>
       </choose>
    </template>
</stylesheet>
