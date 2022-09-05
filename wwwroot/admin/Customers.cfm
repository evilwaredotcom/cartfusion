<!--- BEGIN: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<cfif isDefined('form.DeleteCustomer') AND IsDefined("form.CustomerID")>
	<cfif isUserInRole('Administrator')>
		<cfset form.Deleted = 1 >
		<cfset form.DateUpdated = #Now()# >
		<cfset form.UpdatedBy = #GetAuthUser()# >	
		<cfupdate datasource="#application.dsn#" tablename="Customers" 
			formfields="CustomerID, Deleted, DateUpdated, UpdatedBy ">
		<cfset AdminMsg = 'Customer <cfoutput>#form.CustomerID#</cfoutput> (Soft) Deleted Successfully' >
	<cfelse>			
		<script language="JavaScript">
			{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
		</script>
	</cfif>
</cfif>

<!--- END: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<!--- SET DEFAULT PARAMETERS --->
<cfparam name="URL.StartRow" default="1" type="numeric">
<cfparam name="URL.SortOption" default="LastName" type="string">
<cfparam name="URL.SortAscending" default="1" type="numeric">
<cfparam name="Form.Field" default="ALL" type="string">
<cfparam name="Form.string" default="" type="string">	
<cfset string = Trim(string)>

<!--- BEGIN: SEARCH CRITERIA -------------------------------------------------->
	
<cflock timeout="10">	
	<cfquery name="getCustomers" datasource="#application.dsn#">	
		SELECT 	*
		FROM 	Customers
		<CFIF Field IS 'All'>
		WHERE  (Deleted = 0 OR Deleted IS NULL)
		<CFELSEIF Field IS 'AllFields'>
		WHERE  (CustomerID like '%#string#%'
		OR 		FirstName like '%#string#%'
		OR 		LastName like '%#string#%'
		OR 		Address1 like '%#string#%'
		OR 		City like '%#string#%'
		OR 		State like '%#string#%'
		OR 		Country like '%#string#%'
		OR 		ShipFirstName like '%#string#%'
		OR		ShipLastName like '%#string#%'
		OR 		ShipAddress1 like '%#string#%'
		OR 		ShipAddress2 like '%#string#%'
		OR 		ShipCity like '%#string#%'
		OR 		ShipState like '%#string#%'
		OR 		ShipZip like '%#string#%'
		OR 		ShipCountry like '%#string#%'
		OR 		Phone like '%#string#%'
		OR 		Email like '%#string#%'
		OR 		CardNum like '%#string#%'
		OR 		UserName like '%#string#%'
		OR 		CompanyName like '%#string#%')
		AND		(Deleted = 0 OR Deleted IS NULL)
		<cfelseif Field IS 'ActiveCustomers'>
		WHERE  (Deleted = 0 OR Deleted IS NULL)
		AND		CustomerID IN
			   (SELECT 	o.CustomerID
				FROM 	Orders o
				WHERE	o.CustomerID = CustomerID )
		<cfelseif Field IS 'InactiveCustomers'>
		WHERE 	Deleted = 1
		OR		CustomerID NOT IN
			   (SELECT 	o.CustomerID
				FROM 	Orders o
				WHERE	o.CustomerID = CustomerID )
		<CFELSE>
		WHERE 	#Field# like '%#string#%'
		AND	   (Deleted = 0 OR Deleted IS NULL)
		</CFIF>
		ORDER BY
		<cfif isDefined('URL.SortOption')> #URL.SortOption# <cfelse> LastName </cfif>
		<cfif SortAscending EQ 1> ASC <cfelse> DESC </cfif>
	</cfquery>
</cflock>

<cfinvoke component="#application.Queries#" method="getUsers" returnvariable="getUsers"></cfinvoke>

<!--- END: SEARCH CRITERIA -------------------------------------------------->

<!--- NEXT N VALUES --->
<cfscript>
	RowsPerPage = 15;
	TotalRows = getCustomers.RecordCount;
	EndRow = Min(URL.StartRow + RowsPerPage - 1, TotalRows);
 	StartRowNext = EndRow + 1;
 	StartRowBack = URL.StartRow - RowsPerPage;
</cfscript>

<!--- BEGIN: HEADER --->
<cfscript>
	PageTitle = 'CUSTOMERS';
	ModeAllow = 1 ;
	QuickSearch = 1;
	QuickSearchPage = 'Customers.cfm';
	AddPage = 'CustomerAdd.cfm';
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">
<!--- END: HEADER --->
		
<cfoutput>

<!--- BEGIN CUSTOMERS TABLE --->
<table border="0" cellpadding="2" cellspacing="0" width="100%">
	<tr style="background-color:##7DBF0E;">
		<td width="3%"  class="cfAdminHeader2" height="20"></td><!--- EDIT --->
		<td width="1%"  class="cfAdminHeader2"></td><!--- DELETE --->
		<td width="10%" class="cfAdminHeader2" nowrap>
			Cust. ID
			<a href="Customers.cfm?SortOption=CustomerID&SortAscending=1&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="Customers.cfm?SortOption=CustomerID&SortAscending=0&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td width="18%" class="cfAdminHeader2" nowrap>
			Customer
			<a href="Customers.cfm?SortOption=LastName&SortAscending=1&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="Customers.cfm?SortOption=LastName&SortAscending=0&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td width="15%" class="cfAdminHeader2" nowrap>
			Company
			<a href="Customers.cfm?SortOption=CompanyName&SortAscending=1&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="Customers.cfm?SortOption=CompanyName&SortAscending=0&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td width="18%" class="cfAdminHeader2" nowrap>
			Location
			<a href="Customers.cfm?SortOption=City&SortAscending=1&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="Customers.cfm?SortOption=City&SortAscending=0&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td width="10%" class="cfAdminHeader2" nowrap>
			Created
			<a href="Customers.cfm?SortOption=DateCreated&SortAscending=1&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="Customers.cfm?SortOption=DateCreated&SortAscending=0&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td width="20%" class="cfAdminHeader2" nowrap>
			Email Address
		</td>
		<td width="8%" class="cfAdminHeader2" nowrap>
			Type
			<a href="Customers.cfm?SortOption=PriceToUse&SortAscending=1&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="Customers.cfm?SortOption=PriceToUse&SortAscending=0&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
	</tr>
</cfoutput>

<!--- START: REGULAR MODE --------------------------------------------------------------------------------------------------->
<cfif Mode EQ 0 >
	<cfoutput query="getCustomers" startrow="#StartRow#" maxrows="#RowsPerPage#">
		<cfform action="Customers.cfm?StartRow=#StartRow#&SortOption=#SortOption#&SortAscending=#SortAscending#&field=#field#&string=#string#" method="post">
		<tr>
			<td>
				<input type="button" name="ViewCustomerInfo" value="VIEW" alt="View Customer Information" class="cfAdminButton"
					onclick="document.location.href='CustomerDetail.cfm?CustomerID=#CustomerID#'">
			</td>
			<td>
				<input type="submit" name="DeleteCustomer" value="X" alt="Delete Customer (soft delete)" class="cfAdminButton"
					onclick="return confirm('Are you sure you want to DELETE CUSTOMER ID #CustomerID# ?')">
			</td>
			<td><a href="CustomerDetail.cfm?CustomerID=#CustomerID#" class="cfAdminDefault">#CustomerID#</a></td>
			<td><a href="CustomerDetail.cfm?CustomerID=#CustomerID#" class="cfAdminDefault">#LastName#</a>, #FirstName#</td>
			<td>#CompanyName#</td>
			<td><cfif City NEQ ''>#City#, #State#</cfif></td>
			<td>#DateFormat(DateCreated, "mm/dd/yy")#</td>		
			<td><a href="mailto:#Email#">#Email#</a></td>
			<td>
				<cfquery name="thisUser" dbtype="query">
					SELECT	UName
					FROM	getUsers
					WHERE	UID = #PriceToUse#
				</cfquery>
				#thisUser.UName#
			</td>
		</tr>	
		<input type="hidden" name="CustomerID" value="#CustomerID#">
		</cfform>
		<!--- DIVIDER --->
		<tr><td height="1" colspan="11"><img src="images/image-LineGray.gif" width="100%" height="1"></td></tr>
	</cfoutput>
<!--- END: REGULAR MODE --------------------------------------------------------------------------------------------------->
<!--- START: QUICK EDIT MODE --------------------------------------------------------------------------------------------------->
<cfelseif Mode EQ 1 >
	<cfoutput query="getCustomers" startrow="#StartRow#" maxrows="#RowsPerPage#">
		<cfform action="Customers.cfm?StartRow=#StartRow#&SortOption=#SortOption#&SortAscending=#SortAscending#&field=#field#&string=#string#" method="post">
		<tr>
			<td>
				<input type="button" name="ViewCustomerInfo" value="VIEW" alt="View Customer Information" class="cfAdminButton"
					onclick="document.location.href='CustomerDetail.cfm?CustomerID=#CustomerID#'">
			</td>
			<td>
				<input type="submit" name="DeleteCustomer" value="X" alt="Delete Customer (soft delete)" class="cfAdminButton"
					onclick="return confirm('Are you sure you want to DELETE CUSTOMER ID #CustomerID# ?')">
			</td>
			<td><a href="CustomerDetail.cfm?CustomerID=#CustomerID#" class="cfAdminDefault">#CustomerID#</a></td>
			<td><a href="CustomerDetail.cfm?CustomerID=#CustomerID#" class="cfAdminDefault">#LastName#</a>, #FirstName#</td>
			<td><cfinput type="text" name="CompanyName" value="#CompanyName#" class="cfAdminDefault" size="30" onchange="updateInfo(#CustomerID#,this.value,'CompanyName','Customers');"></td>
			<td>#City#, #State#</td>
			<td>#DateFormat(DateCreated, "mm/dd/yy")#</td>		
			<td><cfinput type="text" name="Email" value="#Email#" class="cfAdminDefault" size="30" onchange="updateInfo(#Email#,this.value,'Email','Customers');"></td>
			<td>
				<cfselect query="getUsers" name="PriceToUse" value="UID" display="UName" selected="#PriceToUse#" size="1" class="cfAdminDefault" onChange="updateInfo(#CustomerID#,this.value,'PriceToUse','Customers');" />
			</td>
		</tr>	
		<input type="hidden" name="CustomerID" value="#CustomerID#">
		</cfform>
		<!--- DIVIDER --->
		<tr><td height="1" colspan="11"><img src="images/image-LineGray.gif" width="100%" height="1"></td></tr>
	</cfoutput>
</cfif>
<!--- END: QUICK EDIT MODE --------------------------------------------------------------------------------------------------->

<!--- NAVIGATION ------------------------------------->
	<tr>
		<td colspan="7"><cfoutput>Displaying <b>#URL.StartRow#</b> to <b>#EndRow#</b> of <b>#TotalRows#</b> Customers</cfoutput></td>
		<td align="right" colspan="4">		
			<cfinclude template="NextNButtons.cfm">		
		</td>
	</tr>
<!--- NAVIGATION ------------------------------------->
</table>
<br/><br/>

<!--- QUICK LINKS --->
<table width="700" border="1" cellpadding="3" cellspacing="0" align="center">
	<tr>
		<td class="cfAdminHeader1" style="border:1px; border-color:000000;" align="center">
			QUICK LINKS
		</td>
	</tr>
	<tr>
		<td style="border:1px; border-color:000000;" align="center">
			Show Only: 
			<input type="button" name="ActiveCustomers" value="ACTIVE CUSTOMERS" alt="Show Only Active Customers" class="cfAdminButton"
				onclick="document.location.href='Customers.cfm?Field=ActiveCustomers'">
			<input type="button" name="InactiveCustomers" value="INACTIVE CUSTOMERS" alt="Show Only Inactive Customers" class="cfAdminButton"
				onclick="document.location.href='Customers.cfm?Field=InactiveCustomers'">
			<input type="button" name="AllCustomers" value="ALL CUSTOMERS" alt="Show All Customers" class="cfAdminButton"
				onclick="document.location.href='Customers.cfm'">
		</td>
	</tr>
</table>
<!--- QUICK LINKS --->

<cfinclude template="LayoutAdminFooter.cfm">