<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<!--- BEGIN: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<cfif isDefined('form.DeleteCategory') AND isDefined('Form.CatID')>
	<cfif IsUserInRole('Administrator')>
		<cfinvoke component="#application.Queries#" method="deleteCategory" returnvariable="deleteCategory">
			<cfinvokeargument name="CatID" value="#Form.CatID#">
		</cfinvoke>
		<cfset AdminMsg = 'Category Deleted Successfully' >
	<cfelse>			
		<script language="JavaScript">
			{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
		</script>
	</cfif>
</cfif>

<!--- END: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<!--- SET DEFAULT PARAMETERS --->
<cfparam name="URL.StartRow" default="1" type="numeric">
<cfparam name="URL.SortOption" default="CatName" type="string">
<cfparam name="URL.SortAscending" default="1" type="numeric">
<cfparam name="Form.Field" default="ALL" type="string">
<cfparam name="Form.string" default="" type="string">
<cfset string = Trim(string)>


<!--- BEGIN: SEARCH CRITERIA ----------------------------------------------------->		
<cfquery name="getCategories" datasource="#application.dsn#">	
	SELECT 	*
	FROM 	Categories
	<cfif #field# IS 'All'>
	WHERE 	CatName like '%'		
	<cfelseif #field# IS 'AllFields'>
	WHERE 	(CatID like '%#string#%'
	OR 		CatName like '%#string#%'
	OR 		CatDescription like '%#string#%')
	<cfelse>
	WHERE 	#field# like '%#string#%'
	</cfif>
	ORDER BY
	<cfif isDefined('URL.SortOption')> #URL.SortOption# <cfelse> CatName </cfif>
	<cfif SortAscending EQ 1> ASC <cfelse> DESC </cfif>
</cfquery>
<!--- END: SEARCH CRITERIA -------------------------------------------------->

<!--- NEXT N VALUES --->
<cfscript>
	RowsPerPage = 15;
	TotalRows = getCategories.RecordCount;
	EndRow = Min(URL.StartRow + RowsPerPage - 1, TotalRows);
 	StartRowNext = EndRow + 1;
 	StartRowBack = URL.StartRow - RowsPerPage;
</cfscript>

<!--- BEGIN: HEADER --->
<cfscript>
	PageTitle = 'CATEGORIES';
	ModeAllow = 1 ;
	QuickSearch = 1;
	QuickSearchPage = 'Categories.cfm';
	AddPage = 'CategoryAdd.cfm';
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">
<!--- END: HEADER --->

<cfoutput>

<!--- BEGIN TABLE --->
<table border="0" cellpadding="2" cellspacing="0" width="100%">
	<tr style="background-color:##7DBF0E;">
		<td width="4%" class="cfAdminHeader2" height="20"></td><!--- VIEW --->
		<td width="1%" class="cfAdminHeader2" height="20"></td><!--- DELETE --->
		<td width="5%" class="cfAdminHeader2" nowrap>
			Cat ID
			<a href="Categories.cfm?SortOption=CatID&SortAscending=1&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="Categories.cfm?SortOption=CatID&SortAscending=0&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td width="20%" class="cfAdminHeader2" nowrap>
			Category Description
			<a href="Categories.cfm?SortOption=CatName&SortAscending=1&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="Categories.cfm?SortOption=CatName&SortAscending=0&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td width="20%" class="cfAdminHeader2" nowrap>
			Parent Category
			<a href="Categories.cfm?SortOption=SubCategoryOf&SortAscending=1&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="Categories.cfm?SortOption=SubCategoryOf&SortAscending=0&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td width="20%" class="cfAdminHeader2" nowrap>
			Category List Item
			<a href="Categories.cfm?SortOption=CatFeaturedID&SortAscending=1&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="Categories.cfm?SortOption=CatFeaturedID&SortAscending=0&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td align="center" width="10%" class="cfAdminHeader2" nowrap>
			Display Order
		</td>
		<td align="center" width="10%" class="cfAdminHeader2" nowrap>
			Items In Cat
		</td>
		<td align="center" width="10%" class="cfAdminHeader2" nowrap>
			Site ID
			<a href="Categories.cfm?SortOption=SiteID&SortAscending=1&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="Categories.cfm?SortOption=SiteID&SortAscending=0&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
	</tr>
</cfoutput>

<!--- START: REGULAR MODE --------------------------------------------------------------------------------------------------->
<cfif Mode EQ 0 >
	<cfoutput query="getCategories" startrow="#URL.StartRow#" maxrows="#RowsPerPage#">
		<cfform action="Categories.cfm?StartRow=#StartRow#&SortOption=#SortOption#&SortAscending=#SortAscending#&field=#field#&string=#string#" method="post">
		<tr>
			<td>
				<input type="button" name="ViewCategory" value="VIEW" alt="View Category" class="cfAdminButton"
					onclick="document.location.href='CategoryDetail.cfm?CatID=#CatID#'">
			</td>
			<td>
				<input type="submit" name="DeleteCategory" value="X" alt="Delete Category" class="cfAdminButton"
					onclick="return confirm('Are you sure you want to DELETE CATEGORY #CatName# ?')">
			</td>
			<td align="center"><a href="CategoryDetail.cfm?CatID=#CatID#" class="cfAdminDefault">#CatID#</a></td>
			<td>#CatName#</td>
			<td>
				<cfif SubCategoryOf NEQ ''>
					<cfquery name="thisSubCategoryOf" datasource="#application.dsn#">
						SELECT	CatName
						FROM	Categories
						WHERE	CatID = #SubCategoryOf#
					</cfquery>
					#thisSubCategoryOf.CatName#
				<cfelse>
					TOP LEVEL CATEGORY
				</cfif>
			</td>
			<td>#CatFeaturedID#</td>
			<td align="center">#DisplayOrder#</td>
			<cfquery name="getItemsInCat" datasource="#application.dsn#">
				SELECT	COUNT(*) AS ItemCount
				FROM	Products
				WHERE	Category  = '#CatID#'
				OR		OtherCategories LIKE '%,#CatID#,%'
			</cfquery>
			<td align="center">#getItemsInCat.ItemCount#</td>
			<td align="center">#SiteID#</td>
			<!---
			<td>
				<input type="image" onClick="submit" src="images/updatebutton.gif" name="Update" 
					value="Update" border="0" alt="Update Changes">
			</td>
			--->
		</tr>	
		<input type="hidden" name="CatID" value="#CatID#">
		</cfform>
		<!--- DIVIDER --->
		<tr><td height="1" colspan="9"><img src="images/image-LineGray.gif" width="100%" height="1"></td></tr>
	</cfoutput>
<!--- END: REGULAR MODE --------------------------------------------------------------------------------------------------->
<!--- START: QUICK EDIT MODE --------------------------------------------------------------------------------------------------->
<cfelseif Mode EQ 1 >
	<cfoutput query="getCategories" startrow="#URL.StartRow#" maxrows="#RowsPerPage#">
		<cfform action="Categories.cfm?StartRow=#StartRow#&SortOption=#SortOption#&SortAscending=#SortAscending#&field=#field#&string=#string#" method="post">
		<tr>
			<td>
				<input type="button" name="ViewCategory" value="VIEW" alt="View Category" class="cfAdminButton"
					onclick="document.location.href='CategoryDetail.cfm?CatID=#CatID#'">
			</td>
			<td>
				<input type="submit" name="DeleteCategory" value="X" alt="Delete Category" class="cfAdminButton"
					onclick="return confirm('Are you sure you want to DELETE CATEGORY #CatName# ?')">
			</td>
			<td align="center"><a href="CategoryDetail.cfm?CatID=#CatID#" class="cfAdminDefault">#CatID#</a></td>
			<td><cfinput type="text" name="CatName" value="#CatName#" class="cfAdminDefault" size="30" onchange="updateInfo('#CatID#',this.value,'CatName','Categories');"></td>
			<td>
				<select name="SubCategoryOf" size="1" class="cfAdminDefault" onchange="updateInfo('#CatID#',this.value,'SubCategoryOf','Categories');">
					<cfset EntryValue = SubCategoryOf >
					<cfinclude template="Includes/DDLCat.cfm">
				</select>
			</td>
			<td><cfinput type="text" name="CatFeaturedID" value="#CatFeaturedID#" class="cfAdminDefault" size="30" onchange="updateInfo('#CatID#',this.value,'CatFeaturedID','Categories');"/></td>
			<td align="center"><input type="text" name="DisplayOrder" value="#DisplayOrder#" class="cfAdminDefault" size="3" onchange="updateInfo('#CatID#',this.value,'DisplayOrder','Categories');"></td>
			<cfquery name="getItemsInCat" datasource="#application.dsn#">
				SELECT	COUNT(*) AS ItemCount
				FROM	Products
				WHERE	Category  = '#CatID#'
				OR		OtherCategories LIKE '%,#CatID#,%'
			</cfquery>
			<td align="center">#getItemsInCat.ItemCount#</td>
			<td align="center">#SiteID#</td>
			<!---
			<td>
				<input type="image" onClick="submit" src="images/updatebutton.gif" name="Update" 
					value="Update" border="0" alt="Update Changes">
			</td>
			--->
		</tr>	
		<input type="hidden" name="CatID" value="#CatID#">
		</cfform>
		<!--- DIVIDER --->
		<tr><td height="1" colspan="9"><img src="images/image-LineGray.gif" width="100%" height="1"></td></tr>
	</cfoutput>
</cfif>
<!--- END: QUICK EDIT MODE --------------------------------------------------------------------------------------------------->

<!--- NAVIGATION ------------------------------------->
	<tr>
		<td colspan="5"><cfoutput>Displaying <b>#URL.StartRow#</b> to <b>#EndRow#</b> of <b>#TotalRows#</b> Categories</cfoutput></td>
		<td align="right" colspan="4"><cfinclude template="NextNButtons.cfm"></td>
	</tr>
<!--- NAVIGATION ------------------------------------->
</table>

<cfinclude template="LayoutAdminFooter.cfm">