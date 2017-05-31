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

<!DOCTYPE stylesheet [
    <!ENTITY ical "http://www.w3.org/2002/12/cal/ical#">
    <!ENTITY xsd  "http://www.w3.org/2001/XMLSchema#" >
]>

<stylesheet xmlns="http://www.w3.org/1999/XSL/Transform" 
    xpath-default-namespace="http://www.w3.org/1999/xhtml"
    xmlns:xd="http://www.pnp-software.com/XSLTdoc"
    xmlns:krextor="http://kwarc.info/projects/krextor"
    exclude-result-prefixes="#all"
    version="2.0">

    <xd:doc type="stylesheet">
	Extraction module for the <a href="http://microformats.org/wiki/hcalendar">hcalendar</a> microformat
	<xd:author>Christoph Lange</xd:author>
	<xd:copyright>Christoph Lange, 2009</xd:copyright>
	<xd:svnId>$Id: hcalendar.xsl 809 2009-11-19 14:32:27Z clange $</xd:svnId>
    </xd:doc>

    <param name="autogenerate-fragment-uris" select="()"/>

    <template match="*[@class='vevent']" mode="krextor:main">
	<variable name="subject" select="a[@class='url']/@href"/>
	<call-template name="krextor:create-resource">
	    <with-param name="subject" select="$subject"/>
	    <with-param name="blank-node" select="not($subject)"/>
	    <with-param name="type" select="'&ical;Vevent'"/>
	</call-template>
    </template>

    <template match="*[@class='summary']" mode="krextor:main">
	<call-template name="krextor:add-literal-property">
	    <with-param name="property" select="'&ical;summary'"/>
	</call-template>
    </template>

    <template match="*[@class='dtstart']" mode="krextor:main">
	<call-template name="krextor:add-literal-property">
	    <with-param name="property" select="'&ical;dtstart'"/>
	    <with-param name="datatype" select="'&xsd;date'"/>
	</call-template>
    </template>

    <template match="*[@class='dtend']" mode="krextor:main">
	<call-template name="krextor:add-literal-property">
	    <with-param name="property" select="'&ical;dtend'"/>
	    <with-param name="datatype" select="'&xsd;date'"/>
	</call-template>
    </template>

    <template match="*[@class='location']" mode="krextor:main">
	<call-template name="krextor:add-literal-property">
	    <with-param name="property" select="'&ical;location'"/>
	</call-template>
    </template>
</stylesheet>
