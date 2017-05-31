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
    xpath-default-namespace="http://www.w3.org/1999/XSL/Transform"
    xmlns:krextor="http://kwarc.info/projects/krextor"
    xmlns:xi="http://www.w3.org/2001/XInclude"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xd="http://www.pnp-software.com/XSLTdoc"
    xmlns:f="http://fxsl.sf.net/"
    exclude-result-prefixes="krextor xi xs xd"
    version="2.0">

    <import href="../lib/fxsl/f/func-apply.xsl"/>
    <import href="../lib/fxsl/f/func-apply2.xsl"/>
    <import href="../lib/fxsl/f/func-curry.xsl"/>

    <xd:doc type="stylesheet">
	<xd:short>Various utility functions</xd:short>
	<xd:detail><p>This stylesheet provides various utility functions</p></xd:detail>
	<xd:author>Christoph Lange</xd:author>
	<xd:copyright>Christoph Lange, 2009</xd:copyright>
	<xd:svnId>$Id: util.xsl 1968 2011-04-11 08:20:37Z clange $</xd:svnId>
    </xd:doc>

    <xd:doc>Add a possibly given XML language to any top-level element of an XML literal.</xd:doc>
    <template match="node()|@*" mode="krextor:prepare-xml-literal">
	<param name="lang" tunnel="yes"/>
	<copy>
	    <if test="$lang">
		<attribute name="xml:lang" select="$lang"/>
	    </if>
	    <apply-templates select="node()|@*" mode="krextor:prepare-xml-literal"/>
	</copy>
    </template>

    <xd:doc>For each element <i>e</i> of a list, apply a given function <i>f</i> to it in the way <i>f(e, …)</i>, and return the first result that evaluates to <code>true</code>.
	<xd:param name="function">a reference to the function</xd:param>
	<xd:param name="iterate-params">a sequence representing the list of elements to test</xd:param>
	<xd:param name="static-params">a sequence of further parameters passed to every call of the function</xd:param>
    </xd:doc>
    <function name="f:return-first">
	<param name="function"/>
	<param name="iterate-params"/>
	<param name="static-params"/>
	<sequence select="f:return-first-step(
	    $function,
	    $iterate-params[1],
	    subsequence($iterate-params, 2),
	    $static-params)"/>
    </function>

    <xd:doc>One iteration of the whole loop of running
	<code>f:return-first</code>.  If the return value of the function, when
	passed the given first argument and optionally further arguments,
	evaluates to <code>true</code>, then return that value, otherwise
	proceed to the next iteration.
	<xd:param name="function">a reference to the function</xd:param>
	<xd:param name="head">the first argument to pass to the function</xd:param>
	<xd:param name="tail">the other elements to use as first argument to
	    the function each in subsequent function calls if this one did not
	    succeed</xd:param>
	<xd:param name="static-params">a sequence of further parameters passed to every call of the function</xd:param>
    </xd:doc>
    <function name="f:return-first-step">
	<param name="function"/>
	<param name="head"/>
	<param name="tail"/>
	<param name="static-params"/>
	<variable name="result" select="f:apply($function, $head, $static-params)"/>
	<sequence select="if ($result) then $result
	    else if (exists($tail))
	    then f:return-first-step(
		$function,
		$tail[1],
		subsequence($tail, 2),
		$static-params)
	    else ()"/>
    </function>

    <xd:doc>Queries some triple store.  The actual implementation has to be provided by a template of the same name.  Returns a set of <code>rxr:triple</code> elements.</xd:doc>
    <function name="krextor:query-triples" as="node()*">
	<param name="subject" as="xs:string*"/>
	<param name="subject-type" as="xs:string"/>
	<param name="predicate" as="xs:string*"/>
	<param name="object" as="xs:string*"/>
	<param name="object-type" as="xs:string"/>
	<param name="object-language" as="xs:string"/>
	<param name="object-datatype" as="xs:string"/>
	<call-template name="krextor:query-triples">
	    <with-param name="subject" select="$subject"/>
	    <with-param name="subject-type" select="$subject-type"/>
	    <with-param name="predicate" select="$predicate"/>
	    <with-param name="object" select="$object"/>
	    <with-param name="object-type" select="$object-type"/>
	    <with-param name="object-language" select="$object-language"/>
	    <with-param name="object-datatype" select="$object-datatype"/>
	</call-template>
    </function>

    <xd:doc>Convenience function that calls <code>krextor:query-triples</code> with the given <code>subject</code>, <code>subject-type</code>, and <code>predicate</code>, defaulting all other parameters to empty sequences or strings</xd:doc>
    <function name="krextor:query-triples-by-subject-predicate" as="node()*">
	<param name="subject" as="xs:string*"/>
	<param name="subject-type" as="xs:string"/>
	<param name="predicate" as="xs:string*"/>
	<copy-of select="krextor:query-triples($subject, $subject-type,
	    $predicate, (), '', '', '')"/>
    </function>

    <xd:doc>Convenience function that calls <code>krextor:query-triples-by-subject-predicate</code> with the given <code>subject</code>, and <code>predicate</code>, defaulting <code>subject-type</code> to <code>'uri'</code></xd:doc>
    <function name="krextor:query-triples-by-subject-predicate" as="node()*">
	<param name="subject" as="xs:string*"/>
	<param name="predicate" as="xs:string*"/>
	<copy-of select="krextor:query-triples-by-subject-predicate($subject, 'uri', $predicate)"/>
    </function>

    <xd:doc>Convenience function that calls <code>krextor:query-triples</code> with the given <code>subject</code> and <code>subject-type</code>, defaulting all other parameters to empty sequences or strings</xd:doc>
    <function name="krextor:query-triples-by-subject" as="node()*">
	<param name="subject" as="xs:string*"/>
	<param name="subject-type" as="xs:string"/>
	<copy-of select="krextor:query-triples($subject, $subject-type,
	    '', (), '', '', '')"/>
    </function>

    <xd:doc>Convenience function that calls <code>krextor:query-triples-by-subject</code> with the given <code>subject</code>, defaulting <code>subject-type</code> to <code>'uri'</code></xd:doc>
    <function name="krextor:query-triples-by-subject" as="node()*">
	<param name="subject" as="xs:string*"/>
	<copy-of select="krextor:query-triples-by-subject($subject, 'uri')"/>
    </function>

    <xd:doc>No-op implementation of a the same-named function.  Importing stylesheets will have to override this.</xd:doc>
    <template name="krextor:query-triples" as="node()*">
	<param name="subject" as="xs:string*"/>
	<param name="subject-type" as="xs:string"/>
	<param name="predicate" as="xs:string*"/>
	<param name="object" as="xs:string*"/>
	<param name="object-type" as="xs:string"/>
	<param name="object-language" as="xs:string"/>
	<param name="object-datatype" as="xs:string"/>
    </template>

    <!-- not used at the moment -->
    <function name="f:generate-id" as="element()">
	<f:generate-id/>
    </function>

    <template match="f:generate-id" mode="f:FXSL">
	<param name="arg1"/>
	<sequence select="f:generate-id($arg1)"/>
    </template>

    <function name="f:generate-id">
	<param name="node"/>
	<sequence select="generate-id($node)"/>
    </function>

    <!-- not used at the moment -->
    <function name="f:apply2" as="element()">
	<f:apply2/>
    </function>

    <template match="f:apply2" mode="f:FXSL">
	<param name="arg1"/>
	<param name="arg2"/>
	<sequence select="f:apply2($arg1, $arg2)"/>
    </template>

    <function name="f:apply2" as="element()">
	<param name="pFunc"/>
	<sequence select="f:curry(f:apply2(), 2, $pFunc)"/>
    </function>
</stylesheet>

