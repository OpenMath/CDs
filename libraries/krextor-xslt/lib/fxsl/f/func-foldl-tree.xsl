<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:f="http://fxsl.sf.net/"
xmlns:int="http://fxsl.sf.net/int/folfl-tree"
exclude-result-prefixes="f int"
>
    <xsl:import href="func-apply.xsl"/>

    <xsl:function name="f:foldl-tree">
      <xsl:param name="pFuncNode" as="element()"/>
      <xsl:param name="pFuncSubtrees" as="element()"/>
      <xsl:param name="pA0"/>
      <xsl:param name="pNode" as="element()"/>

      <xsl:choose>
         <xsl:when test="not($pNode)">
            <xsl:copy-of select="$pA0"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:variable name="vSubtrees" select="$pNode/*"/>
            
            <xsl:sequence select=
             "f:apply($pFuncNode, 
                      $pNode/@tree-nodeLabel,
                      int:foldl-tree_($pFuncNode, $pFuncSubtrees, $pA0, 
                                      $vSubtrees)
                      )"
            />
         </xsl:otherwise>
      </xsl:choose>
    </xsl:function>
    
    <xsl:function name="int:foldl-tree_">
      <xsl:param name="pFuncNode" as="element()"/>
      <xsl:param name="pFuncSubtrees" as="element()"/>
      <xsl:param name="pA0"/>
      <xsl:param name="pSubTrees" as="element()*"/>
      
      <xsl:sequence select=
       "if(empty($pSubTrees))
         then $pA0
         else
           f:apply($pFuncSubtrees, 
               f:foldl-tree($pFuncNode, $pFuncSubtrees, $pA0, $pSubTrees[1]),
               int:foldl-tree_($pFuncNode, $pFuncSubtrees, $pA0, $pSubTrees[position() > 1])
                   )"
       />
    </xsl:function>
</xsl:stylesheet>