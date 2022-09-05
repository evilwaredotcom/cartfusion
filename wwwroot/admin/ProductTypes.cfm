<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<!--- BEGIN: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<cfif isDefined('form.DeleteProductType') AND isDefined('Form.TypeID')>
	<cfif IsUserInRole('Administrator')>
		<cfinvoke component="#application.Queries#" method="deleteProductType" returnvariable="deleteProductType">
			<cfinvokeargument name="TypeID" value="#Form.TypeID#">
		</cfinvoke>
		<cfset AdminMsg = 'Product Comparison Type Deleted Successfully' >
	<cfelse>			
		<script language="JavaScript">
			{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
		</script>
	</cfif>
</cfif>

<!--- END: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<!--- SET DEFAULT PARAMETERS --->
<cfparam name="URL.StartRow" default="1" type="numeric">
<cfparam name="URL.SortOption" default="TypeName" type="string">
<cfparam name="URL.SortAscending" default="1" type="numeric">
<cfparam name="Form.Field" default="ALL" type="string">
<cfparam name="Form.string" default="" type="string">
<cfset string = Trim(string)>


<!--- BEGIN: SEARCH CRITERIA ----------------------------------------------------->
<cfinvoke component="#application.Queries#" method="getProductTypes" returnvariable="getProductTypes"></cfinvoke>
<!--- END: SEARCH CRITERIA -------------------------------------------------->

<!--- NEXT N VALUES --->
<cfscript>
	RowsPerPage = 15;
	TotalRows = getProductTypes.RecordCount;
	EndRow = Min(URL.StartRow + RowsPerPage - 1, TotalRows);
 	StartRowNext = EndRow + 1;
 	StartRowBack = URL.StartRow - RowsPerPage;
</cfscript>

<!--- BEGIN: HEADER --->
<cfscript>
	PageTitle = 'PRODUCT COMPARISON TYPES';
	AddPage = 'ProductTypeAdd.cfm';
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">
<!--- END: HEADER --->

<cfoutput>

<!--- BEGIN TABLE --->
<table border="0" cellpadding="2" cellspacing="0" width="100%">
	<tr style="background-color:##65ADF1;">
		<td width="4%"  class="cfAdminHeader1" height="20"></td><!--- VIEW --->
		<td width="1%"  class="cfAdminHeader1" height="20"></td><!--- DELETE --->
		<td width="10%" class="cfAdminHeader1" align="center">
			Type ID
			<a href="ProductTypes.cfm?SortOption=TypeID&SortAscending=1&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="ProductTypes.cfm?SortOption=TypeID&SortAscending=0&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td width="10%" class="cfAdminHeader1">
			Type Name
			<a href="ProductTypes.cfm?SortOption=TypeName&SortAscending=1&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="ProductTypes.cfm?SortOption=TypeName&SortAscending=0&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td width="10%" class="cfAdminHeader1" align="center">
			Spec Count
		</td>
		<td width="*" class="cfAdminHeader1"></td>
	</tr>
</cfoutput>

<!--- START LOOPING CUSTOMERS AND OUTPUTING THEIR ROWS --------------------->
<cfoutput query="getProductTypes" startrow="#URL.StartRow#" maxrows="#RowsPerPage#">
	<cfform action="ProductTypes.cfm?StartRow=#StartRow#&SortOption=#SortOption#&SortAscending=#SortAscending#&field=#field#&string=#string#" method="post">
	<tr>
		<td>
			<input type="button" name="View" value="VIEW" alt="View Detail" class="cfAdminButton"
				onclick="document.location.href='ProductTypeDetail.cfm?TypeID=#TypeID#'">
		</td>
		<td>
			<input type="submit" name="DeleteProductType" value="X" alt="Delete Product Type" class="cfAdminButton"
				onclick="return confirm('Are you sure you want to DELETE PRODUCT TYPE #TypeName# ?')">
		</td>
		<td align="center"><a href="ProductTypeDetail.cfm?TypeID=#TypeID#">#TypeID#</a></td>
		<td>#TypeName#</td>
		<td align="center">#SpecCount#</td>
		<td>
		<!---
			<input type="image" onClick="submit" src="images/updatebutton.gif" name="Update" 
				value="Update" border="0" alt="Update Changes">
		--->
		</td>
	</tr>	
	<input type="hidden" name="TypeID" value="#TypeID#">
	</cfform>
	<!--- DIVIDER --->
	<tr><td height="1" colspan="6"><img src="images/image-LineGray.gif" width="100%" height="1"></td></tr>
</cfoutput>

<!--- NAVIGATION ------------------------------------->
	<tr>
		<td colspan="3"><cfoutput>Displaying <b>#URL.StartRow#</b> to <b>#EndRow#</b> of <b>#TotalRows#</b> Product Type Comparisons</cfoutput></td>
		<td align="right" colspan="3"><cfinclude template="NextNButtons.cfm"></td>
	</tr>
<!--- NAVIGATION ------------------------------------->
</table>

<cfinclude template="LayoutAdminFooter.cfm">