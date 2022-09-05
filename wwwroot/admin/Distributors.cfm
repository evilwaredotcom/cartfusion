<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<!--- BEGIN: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<cfif isDefined('form.DeleteDistributor') AND IsDefined("form.DistributorID")>
	<cfif IsUserInRole('Administrator')>
		<cftransaction>
			<cfquery name="deleteThisDistributor" datasource="#application.dsn#">
				DELETE
				FROM	Distributors
				WHERE	DistributorID = #Form.DistributorID#
			</cfquery>
			<cfquery name="updateProducts" datasource="#application.dsn#">
				UPDATE	Products
				SET		DistributorID = 0
				WHERE	DistributorID = #Form.DistributorID#
			</cfquery>
		</cftransaction>
		<cfset AdminMsg = 'Distributor Deleted Successfully' >
	<cfelse>			
		<script language="JavaScript">
			{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
		</script>
	</cfif>
</cfif>

<!--- END: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<!--- SET DEFAULT PARAMETERS --->
<cfparam name="URL.StartRow" default="1" type="numeric">
<cfparam name="URL.SortOption" default="DistributorName" type="string">
<cfparam name="URL.SortAscending" default="1" type="numeric">
<cfparam name="Form.Field" default="ALL" type="string">
<cfparam name="Form.string" default="" type="string">	
<cfset string = Trim(string)>

<!--- BEGIN: SEARCH CRITERIA -------------------------------------------------->
	
<cflock timeout="10">	
	<cfquery name="getDistributors" datasource="#application.dsn#">	
		SELECT 	*
		FROM	Distributors
		<CFIF Field IS 'All'>
		WHERE 	DistributorName like '%'
		<CFELSEIF Field IS 'AllFields'>
		WHERE 	(CustomerID like '%#string#%'
		OR 		DistributorName like '%#string#%'
		OR 		RepName like '%#string#%'
		OR 		Address1 like '%#string#%'
		OR 		City like '%#string#%'
		OR 		State like '%#string#%'
		OR 		Country like '%#string#%'
		OR 		Phone like '%#string#%'
		OR 		AltPhone like '%#string#%'
		OR 		Fax like '%#string#%'
		OR 		Email like '%#string#%'
		OR 		Comments like '%#string#%')
		<CFELSE>
		WHERE 	#Field# like '%#string#%'
		</CFIF>
		ORDER BY
		<cfif isDefined('URL.SortOption')> #URL.SortOption# <cfelse> DistributorName </cfif>
		<cfif SortAscending EQ 1> ASC <cfelse> DESC </cfif>
	</cfquery>
</cflock>

<!--- END: SEARCH CRITERIA -------------------------------------------------->

<!--- NEXT N VALUES --->
<cfscript>
	RowsPerPage = 15;
	TotalRows = getDistributors.RecordCount;
	EndRow = Min(URL.StartRow + RowsPerPage - 1, TotalRows);
 	StartRowNext = EndRow + 1;
 	StartRowBack = URL.StartRow - RowsPerPage;
</cfscript>

<!--- BEGIN: HEADER --->
<cfscript>
	PageTitle = 'DISTRIBUTORS';
	QuickSearch = 1;
	QuickSearchPage = 'Distributors.cfm';
	AddPage = 'DistributorAdd.cfm';
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">
<!--- END: HEADER --->

<cfoutput>

<table border="0" cellpadding="2" cellspacing="0" width="100%">
	<tr style="background-color:##65ADF1;">
		<td width="4%"  class="cfAdminHeader1" height="20"></td><!--- EDIT --->
		<td width="1%"  class="cfAdminHeader1"></td><!--- Process --->
		<td width="10%" class="cfAdminHeader1">
			DistributorID
			<a href="Customers.cfm?SortOption=CustomerID&SortAscending=1&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="Customers.cfm?SortOption=CustomerID&SortAscending=0&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td width="15%" class="cfAdminHeader1">
			Distributor Name
			<a href="Customers.cfm?SortOption=LastName&SortAscending=1&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="Customers.cfm?SortOption=LastName&SortAscending=0&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td width="15%" class="cfAdminHeader1">
			Rep Name
			<a href="Customers.cfm?SortOption=CompanyName&SortAscending=1&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="Customers.cfm?SortOption=CompanyName&SortAscending=0&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td width="15%" class="cfAdminHeader1">
			Location
			<a href="Customers.cfm?SortOption=City&SortAscending=1&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="Customers.cfm?SortOption=City&SortAscending=0&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td width="20%" class="cfAdminHeader1">
			Email Address
		</td>
		<td width="10%" class="cfAdminHeader1">
			Order Time
		</td>
		<td width="10%" class="cfAdminHeader1">
			Send Orders
		</td>
	</tr>
</cfoutput>

<!--- START LOOPING CUSTOMERS AND OUTPUTING THEIR ROWS --------------------->
<cfoutput query="getDistributors" startrow="#StartRow#" maxrows="#RowsPerPage#">
	<cfform action="Distributors.cfm?StartRow=#StartRow#&SortOption=#SortOption#&SortAscending=#SortAscending#&field=#field#&string=#string#" method="post">
	<tr>
		<td>
			<input type="button" name="ViewDistributor" value="VIEW" alt="View Distributor Detail" class="cfAdminButton"
				onclick="document.location.href='DistributorDetail.cfm?DistributorID=#DistributorID#'">
		</td>
		<td>
			<input type="submit" name="DeleteDistributor" value="X" alt="Delete Distributor" class="cfAdminButton"
				onclick="return confirm('Are you sure you want to COMPLETELY DELETE DISTRIBUTOR &quot;#DistributorName#&quot; ?')">
		</td>
		<td>#DistributorID#</td>
		<td><a href="DistributorDetail.cfm?DistributorID=#DistributorID#" class="cfAdminDefault">#DistributorName#</a></td>
		<td><a href="DistributorDetail.cfm?DistributorID=#DistributorID#" class="cfAdminDefault">#RepName#</a></td>
		<td>#City#, #State#</td>
		<td><a href="mailto:#Email#">#Email#</a></td>		
		<td>#OrdersAcceptedBy#</td>
		<td valign="middle">
			<cfinvoke component="#application.Queries#" method="getOrdersDistSend" returnvariable="getOrdersDistSend">
				<cfinvokeargument name="DistributorID" value="#DistributorID#">
			</cfinvoke>
			<cfif getOrdersDistSend.RecordCount NEQ 0 >
				<input type="button" name="SendOrders" value="PRINT/EMAIL" alt="Send orders to distributor via email or fax" class="cfAdminButton"
					onclick="document.location.href='DistOrdersSend.cfm?DistributorID=#DistributorID#'" style="color:FF6600;">
			</cfif>
		</td>
		<!---
		<td>
			<input type="image" onClick="submit" src="images/updatebutton.gif" name="Update" 
				value="Update" border="0" alt="Update Changes">
		</td>
		--->
	</tr>	
	<input type="hidden" name="DistributorID" value="#DistributorID#">
	</cfform>
	<!--- DIVIDER --->
	<tr><td height="1" colspan="11"><img src="images/image-LineGray.gif" width="100%" height="1"></td></tr>
</cfoutput>

<!--- NAVIGATION ------------------------------------->
	<tr>
		<td colspan="7"><cfoutput>Displaying <b>#URL.StartRow#</b> to <b>#EndRow#</b> of <b>#TotalRows#</b> Distributors</cfoutput></td>
		<td align="right" colspan="4">		
			<cfinclude template="NextNButtons.cfm">		
		</td>
	</tr>
<!--- NAVIGATION ------------------------------------->
</table>

<cfinclude template="LayoutAdminFooter.cfm">