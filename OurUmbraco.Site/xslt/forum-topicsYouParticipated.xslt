<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#x00A0;">
]>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:msxml="urn:schemas-microsoft-com:xslt"
	xmlns:umbraco.library="urn:umbraco.library" xmlns:Exslt.ExsltCommon="urn:Exslt.ExsltCommon" xmlns:Exslt.ExsltDatesAndTimes="urn:Exslt.ExsltDatesAndTimes" xmlns:Exslt.ExsltMath="urn:Exslt.ExsltMath" xmlns:Exslt.ExsltRegularExpressions="urn:Exslt.ExsltRegularExpressions" xmlns:Exslt.ExsltStrings="urn:Exslt.ExsltStrings" xmlns:Exslt.ExsltSets="urn:Exslt.ExsltSets" xmlns:uForum="urn:uForum" xmlns:uForum.raw="urn:uForum.raw" xmlns:uWiki="urn:uWiki" xmlns:uSearh="urn:uSearh" xmlns:uPowers="urn:uPowers" xmlns:MemberLocator="urn:MemberLocator"
	exclude-result-prefixes="msxml umbraco.library Exslt.ExsltCommon Exslt.ExsltDatesAndTimes Exslt.ExsltMath Exslt.ExsltRegularExpressions Exslt.ExsltStrings Exslt.ExsltSets uForum uForum.raw uWiki uSearh uPowers MemberLocator ">


	<xsl:output method="xml" omit-xml-declaration="yes"/>

	<xsl:param name="currentPage"/>

<xsl:variable name="recordsPerPage" select="15"/>
<xsl:variable name="pageNumber" >
<xsl:choose>
<xsl:when test="umbraco.library:RequestQueryString('p') &lt;= 0 or string(umbraco.library:RequestQueryString('p')) = '' or string(umbraco.library:RequestQueryString('page')) = 'NaN'">0</xsl:when>
<xsl:otherwise>
<xsl:value-of select="umbraco.library:RequestQueryString('p')"/>
</xsl:otherwise>
</xsl:choose>
</xsl:variable>

	<xsl:template match="/">

		<div id="forum">
			<xsl:choose>
				<xsl:when test="umbraco.library:IsLoggedOn()">
					<xsl:variable name="mem">
						<xsl:if test="umbraco.library:IsLoggedOn()">
							<xsl:value-of select="umbraco.library:GetCurrentMember()/@id"/>
						</xsl:if>
					</xsl:variable>

					<xsl:variable name="topics" select="uForum.raw:TopicsWithParticipation($mem)/topics" />
					<xsl:variable name="numberOfRecords" select="count($topics/topic)"/>

					<table cellspacing="0" class="forumList">
						<thead>
							<tr>
								<th>Topic</th>
								<th class="replies">Replies</th>
								<th>Last post</th>
							</tr>
						</thead>
						<tbody>
							<xsl:for-each select="$topics/topic">
								<xsl:sort select="updated" order ="descending"/>

<xsl:if test="position() &gt; $recordsPerPage * number($pageNumber) and
position() &lt;= number($recordsPerPage * number($pageNumber) +
$recordsPerPage )">

								<tr id="topic{@id}">
<xsl:if test="answer != 0">
<xsl:attribute name="class">solved</xsl:attribute>
</xsl:if>

									<th class="title">
										<a href="{uForum:NiceTopicUrl(id)}">
											<xsl:value-of select="title"/>
										</a>
										<small>
											Started by: <xsl:value-of select="umbraco.library:GetMemberName(memberId)" />
											- <xsl:value-of select="uForum:TimeDiff(created)"/>
											<xsl:if test="answer != 0">
												<em>&nbsp; - Topic has been solved</em>
											</xsl:if>
										</small>
									</th>
									<td class="replies">
										<xsl:value-of select ="replies"/>
									</td>
									<td class="latestComment">
										<a href="{uForum:NiceTopicUrl(id)}">
											<xsl:value-of select="uForum:TimeDiff(updated)"/>
										</a> by

										<xsl:choose>
											<xsl:when test="number(latestReplyAuthor) &gt; 0">
												<xsl:value-of select="umbraco.library:GetMemberName(latestReplyAuthor)"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="umbraco.library:GetMemberName(memberId)"/>
											</xsl:otherwise>
										</xsl:choose>
									</td>
								</tr>
</xsl:if>
							</xsl:for-each>
						</tbody>
					</table>

				<xsl:if test="$numberOfRecords &gt; $recordsPerPage">
				<strong>Pages: </strong>
				<ul id="projectPager" class="pager">

				<xsl:call-template name="paging.loop">
					<xsl:with-param name="i">0</xsl:with-param>
					<xsl:with-param name="count" select="ceiling($numberOfRecords div $recordsPerPage)"></xsl:with-param>
				</xsl:call-template>

				</ul>
				</xsl:if>
				</xsl:when>
				<xsl:otherwise>
					<h3>Error</h3>
					You have to be logged in to view your posts!
				</xsl:otherwise>
			</xsl:choose>
		</div>



	</xsl:template>


<xsl:template name="paging.loop">
                <xsl:param name="i"/>
                <xsl:param name="count"/>
                
                <xsl:if test="$i &lt; $count">

				<li>
				<xsl:if test="$pageNumber = $i ">
		                  <xsl:attribute name="class">
                                    <xsl:text>current</xsl:text>
                                  </xsl:attribute>
                                </xsl:if>
                                <a href="?p={$i}">
                                        <xsl:value-of select="$i + 1" />
                                </a>
				</li>

                        <xsl:call-template name="paging.loop">
                                <xsl:with-param name="i" select="$i + 1" />
                                <xsl:with-param name="count" select="$count">
                                </xsl:with-param>
                        </xsl:call-template>
                </xsl:if>
</xsl:template>

</xsl:stylesheet>