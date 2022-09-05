<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<!--- BEGIN: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<cfif isDefined('form.DeleteSection') AND isDefined('Form.SectionID')>
	<cfif IsUserInRole('Administrator')>
		<cfinvoke component="#application.Queries#" method="deleteSection" returnvariable="deleteSection">
			<cfinvokeargument name="SectionID" value="#Form.SectionID#">
		</cfinvoke>
		<cfset AdminMsg = 'Section Deleted Successfully' >
	<cfelse>			
		<script language="JavaScript">
			{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
		</script>
	</cfif>
</cfif>

<!--- END: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<!--- SET DEFAULT PARAMETERS --->
<cfparam name="URL.StartRow" default="1" type="numeric">
<cfparam name="URL.SortOption" default="SecName" type="string">
<cfparam name="URL.SortAscending" default="1" type="numeric">
<cfparam name="Form.Field" default="ALL" type="string">
<cfparam name="Form.string" default="" type="string">
<cfset string = Trim(string)>


<!--- BEGIN: SEARCH CRITERIA ----------------------------------------------------->
		
<cfquery name="getSections" datasource="#application.dsn#">	
	SELECT 	*
	FROM 	Sections
	<cfif #field# IS 'All'>
	WHERE 	SecName like '%'		
	<cfelseif #field# IS 'AllFields'>
	WHERE 	(SectionID like '%#string#%'
	OR 		SecName like '%#string#%'
	OR 		SecDescription like '%#string#%')
	<cfelse>
	WHERE 	#field# like '%#string#%'
	</cfif>
	ORDER BY
	<cfif isDefined('URL.SortOption')> #URL.SortOption# <cfelse> SecName </cfif>
	<cfif SortAscending EQ 1> ASC <cfelse> DESC </cfif>
</cfquery>

<!--- END: SEARCH CRITERIA -------------------------------------------------->

<!--- NEXT N VALUES --->
<cfscript>
	RowsPerPage = 15;
	TotalRows = getSections.RecordCount;
	EndRow = Min(URL.StartRow + RowsPerPage - 1, TotalRows);
 	StartRowNext = EndRow + 1;
 	StartRowBack = URL.StartRow - RowsPerPage;
</cfscript>

<!--- BEGIN: HEADER --->
<cfscript>
	PageTitle = 'SECTIONS';
	ModeAllow = 1 ;
	QuickSearch = 1;
	QuickSearchPage = 'Sections.cfm';
	AddPage = 'SectionAdd.cfm';
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
		<td align="left" width="7%" class="cfAdminHeader2" nowrap>
			Sec ID
			<a href="Sections.cfm?SortOption=SectionID&SortAscending=1&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="Sections.cfm?SortOption=SectionID&SortAscending=0&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td align="left" width="20%" class="cfAdminHeader2" nowrap>
			Section Description
			<a href="Sections.cfm?SortOption=SecName&SortAscending=1&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="Sections.cfm?SortOption=SecName&SortAscending=0&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td align="left" width="15%" class="cfAdminHeader2" nowrap>
			Parent Section
			<a href="Sections.cfm?SortOption=SubSectionOf&SortAscending=1&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="Sections.cfm?SortOption=SubSectionOf&SortAscending=0&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td align="left" width="20%" class="cfAdminHeader2" nowrap>
			Section List Item
			<a href="Sections.cfm?SortOption=SecFeaturedID&SortAscending=1&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="Sections.cfm?SortOption=SecFeaturedID&SortAscending=0&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td align="center" width="10%" class="cfAdminHeader2" nowrap>
			Display Order
		</td>
		<td align="center" width="10%" class="cfAdminHeader2" nowrap>
			Items In Sec
		</td>
		<td align="center" width="10%" class="cfAdminHeader2" nowrap>
			Site ID
			<a href="Sections.cfm?SortOption=SiteID&SortAscending=1&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="Sections.cfm?SortOption=SiteID&SortAscending=0&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
	</tr>
</cfoutput>

<!--- START: REGULAR MODE --------------------------------------------------------------------------------------------------->
<cfif Mode EQ 0 >
	<cfoutput query="getSections" startrow="#URL.StartRow#" maxrows="#RowsPerPage#">
		<cfform action="Sections.cfm?StartRow=#StartRow#&SortOption=#SortOption#&SortAscending=#SortAscending#&field=#field#&string=#string#" method="post">
		<tr>
			<td>
				<input type="button" name="ViewSection" value="VIEW" alt="View Section" class="cfAdminButton"
					onclick="document.location.href='SectionDetail.cfm?SectionID=#SectionID#'">
			</td>
			<td>
				<input type="submit" name="DeleteSection" value="X" alt="Delete Section" class="cfAdminButton"
					onclick="return confirm('Are you sure you want to DELETE SECTION #SecName# ?')">
			</td>
			<td><a href="SectionDetail.cfm?SectionID=#SectionID#" class="cfAdminDefault">#SectionID#</a></td>
			<td>#SecName#</td>
			<td>
				<cfif SubSectionOf NEQ ''>
					<cfquery name="thisSubSectionOf" datasource="#application.dsn#">
						SELECT	SecName
						FROM	Sections
						WHERE	SectionID = #SubSectionOf#
					</cfquery>
					#thisSubSectionOf.SecName#
				<cfelse>
					TOP LEVEL SECTION
				</cfif>
			</td>
			<td>#SecFeaturedID#</td>
			<td align="center">#DisplayOrder#</td>
			<cfquery name="getItemsInSec" datasource="#application.dsn#">
				SELECT	COUNT(*) AS ItemCount
				FROM	Products
				WHERE	SectionID  = #SectionID#
			</cfquery>
			<td align="center">#getItemsInSec.ItemCount#</td>
			<td align="center">#SiteID#</td>
			<!---
			<td>
				<input type="image" onClick="submit" src="images/updatebutton.gif" name="Update" 
					value="Update" border="0" alt="Update Changes">
			</td>
			--->
		</tr>	
		<input type="hidden" name="SectionID" value="#SectionID#">
		</cfform>
		<!--- DIVIDER --->
		<tr><td height="1" colspan="9"><img src="images/image-LineGray.gif" width="100%" height="1"></td></tr>
	</cfoutput>
<!--- END: REGULAR MODE --------------------------------------------------------------------------------------------------->
<!--- START: QUICK EDIT MODE --------------------------------------------------------------------------------------------------->
<cfelseif Mode EQ 1 >
	<cfoutput query="getSections" startrow="#URL.StartRow#" maxrows="#RowsPerPage#">
		<cfform action="Sections.cfm?StartRow=#StartRow#&SortOption=#SortOption#&SortAscending=#SortAscending#&field=#field#&string=#string#" method="post">
		<tr>
			<td>
				<input type="button" name="ViewSection" value="VIEW" alt="View Section" class="cfAdminButton"
					onclick="document.location.href='SectionDetail.cfm?SectionID=#SectionID#'">
			</td>
			<td>
				<input type="submit" name="DeleteSection" value="X" alt="Delete Section" class="cfAdminButton"
					onclick="return confirm('Are you sure you want to DELETE SECTION #SecName# ?')">
			</td>
			<td><a href="SectionDetail.cfm?SectionID=#SectionID#" class="cfAdminDefault">#SectionID#</a></td>
			<td><cfinput type="text" name="SecName" value="#SecName#" class="cfAdminDefault" size="30" onchange="updateInfo('#SectionID#',this.value,'SecName','Sections');"></td>
			<td>
				<select name="SubSectionOf" size="1" class="cfAdminDefault" onchange="updateInfo('#SectionID#',this.value,'SubSectionOf','Sections');">
					<cfset EntryValue = SubSectionOf >
					<cfinclude template="Includes/DDLSec.cfm">
				</select>
			</td>
			<td><cfinput type="text" name="SecFeaturedID"  value="#SecFeaturedID#"  class="cfAdminDefault" size="30"  onchange="updateInfo('#SectionID#',this.value,'SecFeaturedID','Sections');"/></td>
			<td align="center"><input type="text" name="DisplayOrder" value="#DisplayOrder#" class="cfAdminDefault" size="3" onchange="updateInfo('#SectionID#',this.value,'DisplayOrder','Sections');"></td>
			<cfquery name="getItemsInSec" datasource="#application.dsn#">
				SELECT	COUNT(*) AS ItemCount
				FROM	Products
				WHERE	SectionID  = #SectionID#
			</cfquery>
			<td align="center">#getItemsInSec.ItemCount#</td>
			<td align="center">#SiteID#</td>
			<!---
			<td>
				<input type="image" onClick="submit" src="images/updatebutton.gif" name="Update" 
					value="Update" border="0" alt="Update Changes">
			</td>
			--->
		</tr>	
		<input type="hidden" name="SectionID" value="#SectionID#">
		</cfform>
		<!--- DIVIDER --->
		<tr><td height="1" colspan="9"><img src="images/image-LineGray.gif" width="100%" height="1"></td></tr>
	</cfoutput>
</cfif>
<!--- END: QUICK EDIT MODE --------------------------------------------------------------------------------------------------->

<!--- NAVIGATION ------------------------------------->
	<tr>
		<td colspan="5"><cfoutput>Displaying <b>#URL.StartRow#</b> to <b>#EndRow#</b> of <b>#TotalRows#</b> Sections</cfoutput></td>
		<td align="right" colspan="4"><cfinclude template="NextNButtons.cfm"></td>
	</tr>
<!--- NAVIGATION ------------------------------------->
</table>

<cfinclude template="LayoutAdminFooter.cfm">