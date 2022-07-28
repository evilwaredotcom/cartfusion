<cfprocessingdirective suppresswhitespace="Yes">
<!--- GET CATEGORIES --->
<CFQUERY NAME="getSubCategories" DATASOURCE="#application.dsn#" cachedwithin="#CreateTimeSpan(0,0,-10,0)#">
	SELECT 		CatID, CatName, SubCategoryOf
	FROM 		Categories
	WHERE		Hide#session.CustomerArray[28]# != 1
	AND			SiteID = #config.SiteID#
	ORDER BY 	DisplayOrder, CatName
</CFQUERY>

<!--- GET MAIN CATEGORIES (AFTER getSubCategories) --->
<cfquery name="getMainCategories" dbtype="query">
	SELECT 	*
	FROM 	getSubCategories
	WHERE	(SubCategoryOf = 0
	OR		 SubCategoryOf IS NULL)
</cfquery>

<!--- GET SECTIONS --->
<CFQUERY NAME="getSubSections" DATASOURCE="#application.dsn#" cachedwithin="#CreateTimeSpan(0,0,-10,0)#">
	SELECT 		SectionID, SecName, SubSectionOf
	FROM 		Sections
	WHERE		Hide#session.CustomerArray[28]# != 1
	AND			SiteID = #config.SiteID#
	ORDER BY 	DisplayOrder, SecName
</CFQUERY>

<!--- GET MAIN SECTIONS (AFTER getSubSections) --->
<cfquery name="getMainSections" dbtype="query">
	SELECT 	*
	FROM 	getSubSections
	WHERE	(SubSectionOf = 0
	OR		 SubSectionOf IS NULL)
</cfquery>

<table border="0" cellpadding="0" cellspacing="0" width="194" style="background-image:url(images/leftnav-BG.jpg); background-repeat:repeat-y;">
	<tr>
		<td><img src="images/leftnav-Top.jpg"></td>
	</tr>
	<tr>
		<td><img src="images/leftnav-Categories.jpg" border="0" alt="Shop by Category"></td>
	</tr>
	<tr>
		<td><img src="images/spacer.gif" height="3"></td>
	</tr>
	<tr>
		<td>
			<br />
			<cfoutput query="getMainCategories">
				<img src="images/spacer.gif" height="1" width="25"><img src="images/image-BoxGreen.jpg" align="absmiddle"> <a href="ProductList.cfm?CatDisplay=#CatID#"><font class="cfDefault"><b>#CatName#</b></font></a><br>
				<img src="images/spacer.gif" height="2"><br>
				<img src="images/leftnav-Line.jpg" vspace="5"><br>
				<img src="images/spacer.gif" height="2"><br>
				
				<cfquery name="getSubCategories1" dbtype="query">
					SELECT 	*
					FROM 	getSubCategories
					WHERE	SubCategoryOf = #getMainCategories.CatID#
				</cfquery>
				<cfloop query="getSubCategories1">
					<img src="images/spacer.gif" height="1" width="37"><a href="ProductList.cfm?CatDisplay=#CatID#">- #CatName#</a><br>
					<img src="images/spacer.gif" height="2"><br>
				</cfloop>
				<br />
			</cfoutput>
		</td>
	</tr>
	<tr>
		<td><img src="images/spacer.gif" height="10"></td>
	</tr>
	<tr>
		<td><img src="images/leftnav-Departments.jpg" border="0" alt="Shop by Departments"></td>
	</tr>
	<tr>
		<td><img src="images/spacer.gif" height="3"></td>
	</tr>
	<tr>
		<td>
			<cfoutput query="getMainSections">
				<br />
				<img src="images/spacer.gif" height="1" width="25"><img src="images/image-BoxGreen.jpg" align="absmiddle"> <a href="ProductList.cfm?SecDisplay=#SectionID#"><font class="cfDefault"><b>#SecName#</b></font></a><br>
				<img src="images/spacer.gif" height="2"><br>
				<img src="images/leftnav-Line.jpg" vspace="5"><br>
				<img src="images/spacer.gif" height="2"><br>
				
				<cfquery name="getSubSections1" dbtype="query">
					SELECT 	*
					FROM 	getSubSections
					WHERE	SubSectionOf = #getMainSections.SectionID#
				</cfquery>
				<cfloop query="getSubSections1">
					<img src="images/spacer.gif" height="1" width="37"><a href="ProductList.cfm?SecDisplay=#SectionID#">- #SecName#</a><br>
					<img src="images/spacer.gif" height="2"><br>
				</cfloop>
				<br />
			</cfoutput>
		</td>
	</tr>
	<tr>
		<td><img src="images/spacer.gif" height="10"></td>
	</tr>
	<tr>
		<td align="center"><img src="images/pic-FreeShipping.jpg" border="0"></td>
	</tr>
	<tr>
		<td><img src="images/leftnav-Bottom.jpg"></td>
	</tr>
</table>
</cfprocessingdirective>