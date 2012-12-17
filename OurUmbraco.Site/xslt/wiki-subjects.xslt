<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [ <!ENTITY nbsp "&#x00A0;"> ]>
<xsl:stylesheet 
  version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:msxml="urn:schemas-microsoft-com:xslt"
  xmlns:umbraco.library="urn:umbraco.library" xmlns:Exslt.ExsltCommon="urn:Exslt.ExsltCommon" xmlns:Exslt.ExsltDatesAndTimes="urn:Exslt.ExsltDatesAndTimes" xmlns:Exslt.ExsltMath="urn:Exslt.ExsltMath" xmlns:Exslt.ExsltRegularExpressions="urn:Exslt.ExsltRegularExpressions" xmlns:Exslt.ExsltStrings="urn:Exslt.ExsltStrings" xmlns:Exslt.ExsltSets="urn:Exslt.ExsltSets" xmlns:uForum="urn:uForum" xmlns:uForum.raw="urn:uForum.raw" xmlns:uWiki="urn:uWiki" 
  exclude-result-prefixes="msxml umbraco.library Exslt.ExsltCommon Exslt.ExsltDatesAndTimes Exslt.ExsltMath Exslt.ExsltRegularExpressions Exslt.ExsltStrings Exslt.ExsltSets uForum uForum.raw uWiki ">


<xsl:output method="html" omit-xml-declaration="yes"/>

<xsl:param name="currentPage"/>

<!-- This displays the top pages in the wiki, which serves as a starting point for creating pages -->
<!-- So new pages created has to stay within these boundries (a good limitation) -->

<xsl:template match="/">

<xsl:for-each select="$currentPage/ancestor-or-self::* [@isDoc and @level=2]/* [@isDoc and string(umbracoNaviHide) != '1']">


<h4><a href="{umbraco.library:NiceUrl(@id)}"><xsl:value-of select="./@nodeName" /></a></h4>  
<ul>
<xsl:for-each select="./node">
<xsl:sort select="@nodeName"/>
  <li><a href="{umbraco.library:NiceUrl(@id)}"><xsl:value-of select="./@nodeName" /></a></li>
</xsl:for-each>
</ul>


</xsl:for-each>


</xsl:template>

</xsl:stylesheet>