<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<!--- BEGIN: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->
<cfif isDefined('form.DeleteRMA') AND IsDefined("form.OrderReturnID")>
	<cftry>
		<cftransaction>
			<cfquery name="deleteRMA" datasource="#application.dsn#">
				DELETE 
				FROM	OrderReturns
				WHERE	OrderReturnID = #Form.OrderReturnID#
			</cfquery>
			<cfquery name="deleteRMAItems" datasource="#application.dsn#">
				DELETE 
				FROM	OrderReturnItems
				WHERE	OrderReturnID = #Form.OrderReturnID#
			</cfquery>
		</cftransaction>
		
		<cfset AdminMsg = 'RMA #form.RMA# Deleted Successfully' >

		<cfcatch>
			<cfset AdminMsg = 'FAIL: RMA NOT Deleted' >
		</cfcatch>
	</cftry>
</cfif>
<!--- END: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<!--- SET DEFAULT PARAMETERS --->
<cfparam name="URL.StartRow" default="1" type="numeric">
<cfparam name="URL.SortOption" default="RMA" type="string">
<cfparam name="URL.SortAscending" default="1" type="numeric">
<cfparam name="Form.Field" default="ALL" type="string">
<cfparam name="Form.string" default="" type="string">
<cfset string = Trim(string)>
<cfparam name="RunningTotal" default="0" type="numeric">

<!--- BEGIN: SEARCH CRITERIA -------------------------------------------------->

<cflock timeout="10">	
	<cfquery name="getOrderReturns" datasource="#application.dsn#">	
		SELECT 	OrderReturnID, OrderID, RMA, RMADate, DateReceived, ReceivedTo, 
				RMAComplete, TaxReturned, ShippingReturned
		FROM	OrderReturns

		<!---
		<cfif Field EQ 'ALL'>
		FROM	Orders o, Customers c
		WHERE	o.CustomerID = c.CustomerID
		<cfelseif Field EQ 'New'>
		FROM	Orders o, Customers c
		WHERE	o.CustomerID = c.CustomerID
		AND	  ((o.BillingStatus = 'NB' 
		OR 		o.BillingStatus = 'AU')  <!--- NOT BILLED --->
		AND	   (o.OrderStatus = 'OD'))   <!--- ORDERED ( OR OrderStatus = 'PR' ) --->
		<cfelseif Field EQ 'Pending'>
		FROM	Orders o, Customers c
		WHERE	o.CustomerID = c.CustomerID
		AND   ((o.BillingStatus != 'PA' 
		AND 	o.BillingStatus != 'CA' 
		AND 	o.BillingStatus != 'RE' 
		AND 	o.BillingStatus != 'PK'
		AND 	o.BillingStatus != 'PC') <!--- NOT PAID --->
		OR	   (o.OrderStatus != 'SH'
		AND		o.OrderStatus != 'CA'
		AND		o.OrderStatus != 'IT'
		AND		o.OrderStatus != 'RE'))  <!--- NOT SHIPPED --->
		<cfelseif Field EQ 'Status'>
		FROM	Orders o, Customers c
		WHERE	o.CustomerID = c.CustomerID
			<cfif isDefined('Form.ShowOrderStatus') AND Form.ShowOrderStatus NEQ ''>
			AND o.OrderStatus = '#Form.ShowOrderStatus#'
			</cfif>
			<cfif isDefined('Form.ShowBillingStatus') AND Form.ShowBillingStatus NEQ ''>
			AND o.BillingStatus = '#Form.ShowBillingStatus#'
			</cfif>
		<cfelseif Field EQ 'AllFields'>
		FROM 	Orders o, Customers c
		WHERE	o.CustomerID = c.CustomerID 	
		AND		(o.OrderID like '%#string#%'
		OR 		o.CustomerID like '%#string#%'
		OR 		c.FirstName like '%#string#%'
		OR 		c.LastName like '%#string#%'
		OR 		c.City like '%#string#%'
		OR 		c.CompanyName like '%#string#%'
		<!---
		OR 		c.Address1 like '%#string#%'
		OR 		c.Address2 like '%#string#%'
		OR 		c.State like '%#string#%'
		OR 		c.Zip like '%#string#%'
		OR 		c.Country like '%#string#%'
		OR 		c.Phone like '%#string#%'
		OR 		c.UserName like '%#string#%'
		--->
		<!--- SEARCH BY PRODUCT PURCHASED
		OR		o.OrderID IN 
				(
				SELECT	OrderID
				FROM	OrderItems
				WHERE	ItemID = 
					(
					SELECT	ItemID
					FROM	Products
					WHERE	SKU = '#string#'
					)
				)
		--->
		)
		<cfelse>
		FROM 	Orders o, Customers c
		WHERE 	o.#Field# like '%#string#%'
		</cfif>
		--->
		ORDER BY
		<cfif isDefined('URL.SortOption')> #URL.SortOption# <cfelse> RMA </cfif>
		<cfif SortAscending EQ 1> ASC <cfelse> DESC </cfif>
	</cfquery>
</cflock>
<!--- EXECUTION TIME TEST
<cfset getOrderExecutionTime = #cfquery.ExecutionTime# >
--->

<cfinvoke component="#application.Queries#" method="getOrderStatusCodes" returnvariable="getOrderStatusCodes"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getBillingStatusCodes" returnvariable="getBillingStatusCodes"></cfinvoke>


<!--- END: SEARCH CRITERIA -------------------------------------------------->

<!--- NEXT N VALUES --->
<cfscript>
	RowsPerPage = 20;
	TotalRows = getOrderReturns.RecordCount;
	EndRow = Min(URL.StartRow + RowsPerPage - 1, TotalRows);
 	StartRowNext = EndRow + 1;
 	StartRowBack = URL.StartRow - RowsPerPage;
</cfscript>

<!--- BEGIN: HEADER --->
<cfscript>
	PageTitle = 'RETURN MERCHANDISE AUTHORIZATIONS (RMAs)' ;
	// ModeAllow = 0 ;
	QuickSearch = 0 ;
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">
<!--- END: HEADER --->

<cfoutput>

<table width="100%" border="0" cellpadding="2" cellspacing="0">
	<tr style="background-color:##7DBF0E;">
		<td width="4%"  class="cfAdminHeader2" height="20"></td><!--- EDIT --->
		<td width="1%"  class="cfAdminHeader2"></td><!--- Process --->
		<td width="13%" class="cfAdminHeader2" nowrap="nowrap">
			OrderID
			<a href="OrderReturns.cfm?SortOption=OrderID&SortAscending=1&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="OrderReturns.cfm?SortOption=OrderID&SortAscending=0&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td width="13%" class="cfAdminHeader2" nowrap="nowrap">
			RMA
			<a href="OrderReturns.cfm?SortOption=RMA&SortAscending=1&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="OrderReturns.cfm?SortOption=RMA&SortAscending=0&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td width="15%" class="cfAdminHeader2" nowrap="nowrap">
			Date Created
			<a href="OrderReturns.cfm?SortOption=RMADate&SortAscending=1&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="OrderReturns.cfm?SortOption=RMADate&SortAscending=0&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td width="15%" class="cfAdminHeader2" nowrap="nowrap">
			Date Received
			<a href="OrderReturns.cfm?SortOption=DateReceived&SortAscending=1&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="OrderReturns.cfm?SortOption=DateReceived&SortAscending=0&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td width="20%" class="cfAdminHeader2" nowrap="nowrap">
			Being Sent To
			<a href="OrderReturns.cfm?SortOption=ReceivedTo&SortAscending=1&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="OrderReturns.cfm?SortOption=ReceivedTo&SortAscending=0&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td width="9%" class="cfAdminHeader2" nowrap="nowrap">
			Complete
			<a href="OrderReturns.cfm?SortOption=RMAComplete&SortAscending=1&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="OrderReturns.cfm?SortOption=RMAComplete&SortAscending=0&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td width="10%" class="cfAdminHeader2" nowrap="nowrap" align="right">
			Amount
		</td>
	</tr>
</cfoutput>

<cfoutput query="getOrderReturns" startrow="#StartRow#" maxrows="#RowsPerPage#">
<cfset ReturnTotal = 0>
<cfset ThisOrderReturnID = getOrderReturns.OrderReturnID >
<cfset ThisOrderID = getOrderReturns.OrderID >
	<cfform action="OrderReturns.cfm?StartRow=#StartRow#&SortOption=#SortOption#&SortAscending=#SortAscending#&field=#field#&string=#string#" method="post">
	<tr>
		<td>
			<input type="button" name="ViewReturn" value="VIEW" alt="View Order Return" class="cfAdminButton"
				onclick="document.location.href='OrderReturnDetail.cfm?OrderID=#OrderID#'">
		</td>
		<td>
			<input type="submit" name="DeleteRMA" value="X" alt="Delete Order Return" class="cfAdminButton"
				onclick="return confirm('Are you sure you want to DELETE ORDER RETURN #RMA# ?')">
		</td>
		<td>#OrderID#</td>
		<td>#RMA#</td>
		<td>#DateFormat(RMADate, "mm/dd/yy")#</td>
		<td>#DateFormat(DateReceived, "mm/dd/yy")#</td>
		<td>#ReceivedTo#</td>
		<td><cfif RMAComplete EQ 1 > X <cfelse>  </cfif></td>
		
		<!--- CALCULATE ORDER RETURN AMOUNT --->
		<cfquery name="getOrderReturnItems" datasource="#application.dsn#">
			SELECT	*
			FROM	OrderReturnItems
			WHERE	OrderReturnID = #ThisOrderReturnID#
		</cfquery>
		<cfloop query="getOrderReturnItems">
			<cfset ThisOrderReturnItemID = getOrderReturnItems.OrderReturnItemID >
			<cfquery name="getItemPrice" datasource="#application.dsn#">
				SELECT	ItemPrice
				FROM	OrderItems
				WHERE	OrderID = #ThisOrderID#
				AND		ItemID = #ThisOrderReturnItemID#
			</cfquery>
			<cfif getItemPrice.ItemPrice NEQ '' >
				<cfset ReturnTotal = ReturnTotal + (QtyReturned * getItemPrice.ItemPrice) >
			</cfif>
		</cfloop>
		<cfif TaxReturned NEQ '' AND TaxReturned NEQ 0 >
			<cfset ReturnTotal = ReturnTotal + TaxReturned >
		</cfif>
		<cfif ShippingReturned NEQ '' AND ShippingReturned NEQ 0 >
			<cfset ReturnTotal = ReturnTotal + ShippingReturned >
		</cfif>
		<td align="right"><b>#LSCurrencyFormat(ReturnTotal, "local")#</b></td>

	</tr>
	<input type="hidden" name="OrderID" value="#OrderID#">
	</cfform>
	<!--- DIVIDER --->
	<tr><td height="1" colspan="11"><img src="images/image-LineGray.gif" width="100%" height="1"></td></tr>
</cfoutput>

<!--- NAVIGATION ------------------------------------->
	<tr>
		<td class="cfAdminDefault" colspan="7"><cfoutput>Displaying <b>#URL.StartRow#</b> to <b>#EndRow#</b> of <b>#TotalRows#</b> RMAs</cfoutput></td>
		<td align="right" colspan="4"><cfinclude template="NextNButtons.cfm"></td>
	</tr>
<!--- NAVIGATION ------------------------------------->
</table>
<br><br>


<cfinclude template="LayoutAdminFooter.cfm">