<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<!--- BEGIN: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<cfif isDefined('form.Update') AND IsDefined("form.OrderID")>	
	<cfupdate datasource="#application.dsn#" tablename="Orders" formfields="OrderID, OrderStatus, BillingStatus, ShipDate">
	<cfset AdminMsg = 'Order <cfoutput>#form.OrderID#</cfoutput> Updated' >
</cfif>

<cfif isDefined('form.DeleteOrder') AND IsDefined("form.OrderID")>
	<cfif IsUserInRole('Administrator')>
		<cftransaction>
			<cfinvoke component="#application.Queries#" method="deleteOrder" returnvariable="deleteOrder">
				<cfinvokeargument name="OrderID" value="#Form.OrderID#">
			</cfinvoke>
		</cftransaction>			
		<cfset AdminMsg = 'Order Deleted Successfully' >
	<cfelse>			
		<script language="JavaScript">
			{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
		</script>
	</cfif>
</cfif>

<!--- END: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<!--- SET DEFAULT PARAMETERS --->
<cfparam name="URL.StartRow" default="1" type="numeric">
<cfparam name="URL.SortOption" default="OrderID" type="string">
<cfparam name="URL.SortAscending" default="0" type="numeric">
<cfparam name="Form.Field" default="ALL" type="string">
<cfparam name="Form.string" default="" type="string">
<cfset string = Trim(string)>
<cfparam name="RunningTotal" default="0" type="numeric">

<!--- BEGIN: SEARCH CRITERIA -------------------------------------------------->

<cflock timeout="10">	
	<cfquery name="getOrders" datasource="#application.dsn#">	
		SELECT 	o.OrderID, o.DateEntered, o.OrderStatus, o.BillingStatus, o.ShipDate, 
				o.DiscountTotal, o.ShippingTotal, o.TaxTotal, o.CreditApplied,
				c.CustomerID, c.FirstName, c.LastName, c.CompanyName
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
		ORDER BY
		<cfif isDefined('URL.SortOption')> #URL.SortOption# <cfelse> OrderID </cfif>
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
	RowsPerPage = 15;
	TotalRows = getOrders.RecordCount;
	EndRow = Min(URL.StartRow + RowsPerPage - 1, TotalRows);
 	StartRowNext = EndRow + 1;
 	StartRowBack = URL.StartRow - RowsPerPage;
</cfscript>

<!--- BEGIN: HEADER --->
<cfscript>
	PageTitle = 'ORDERS' ;
	ModeAllow = 1 ;
	QuickSearch = 1 ;
	QuickSearchPage = 'Orders.cfm' ;
	AddPage = 'OrderAdd.cfm' ;
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">
<!--- END: HEADER --->

<cfoutput>

<!--- BEGIN ORDERS TABLE --->
<table width="100%" border="0" cellpadding="2" cellspacing="0">
	<tr style="background-color:##7DBF0E;">
		<td width="4%"  class="cfAdminHeader2" height="20"></td><!--- EDIT --->
		<td width="1%"  class="cfAdminHeader2"></td><!--- Process --->
		<td width="13%" class="cfAdminHeader2">
			OrderID
			<a href="Orders.cfm?SortOption=OrderID&SortAscending=1&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="Orders.cfm?SortOption=OrderID&SortAscending=0&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td width="10%" class="cfAdminHeader2">
			Date
		</td>
		<td width="15%" class="cfAdminHeader2">
			Customer
			<a href="Orders.cfm?SortOption=LastName&SortAscending=1&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="Orders.cfm?SortOption=LastName&SortAscending=0&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td width="20%" class="cfAdminHeader2">
			Company
			<a href="Orders.cfm?SortOption=CompanyName&SortAscending=1&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="Orders.cfm?SortOption=CompanyName&SortAscending=0&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td width="10%" class="cfAdminHeader2">
			Order Status
			<a href="Orders.cfm?SortOption=OrderStatus&SortAscending=1&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="Orders.cfm?SortOption=OrderStatus&SortAscending=0&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td width="10%" class="cfAdminHeader2">
			Ship Date
		</td>
		<td width="15%" class="cfAdminHeader2">
			Billing Status
			<a href="Orders.cfm?SortOption=BillingStatus&SortAscending=1&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="Orders.cfm?SortOption=BillingStatus&SortAscending=0&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td width="8%" class="cfAdminHeader2">
			Amount
		</td>
	</tr>
</cfoutput>

<!--- START: REGULAR MODE --------------------------------------------------------------------------------------------------->
<cfif Mode EQ 0 >
	<cfoutput query="getOrders" startrow="#StartRow#" maxrows="#RowsPerPage#">
	<cfset RunningTotal = 0>
		<cfform action="Orders.cfm?StartRow=#StartRow#&SortOption=#SortOption#&SortAscending=#SortAscending#&field=#field#&string=#string#" method="post">
		<tr>
			<td>
				<input type="button" name="ViewOrder" value="VIEW" alt="View Order Details" class="cfAdminButton"
					onclick="document.location.href='OrderDetail.cfm?OrderID=#OrderID#'">
			</td>
			<td>
				<input type="submit" name="DeleteOrder" value="X" alt="Delete Order" class="cfAdminButton"
					onclick="return confirm('Are you sure you want to DELETE ORDER #OrderID# ?')">
			</td>
			<td>#OrderID#</td>
			<td>#DateFormat(DateEntered, "mm/dd/yy")#</td>
			
			<cfinvoke component="#application.Queries#" method="getCustomer" returnvariable="getCustomer">
				<cfinvokeargument name="CustomerID" value="#getOrders.CustomerID#">
			</cfinvoke>
			
			<td><a href="CustomerDetail.cfm?CustomerID=#CustomerID#">#getCustomer.LastName#, #getCustomer.FirstName#</a></td>
			<td>#getCustomer.CompanyName#</td>
			<td>
				<cfquery name="thisOrderStatus" dbtype="query">
					SELECT	StatusMessage
					FROM	getOrderStatusCodes
					WHERE	StatusCode = '#OrderStatus#'
				</cfquery>
				#thisOrderStatus.StatusMessage#
			</td>
			<td>
				#DateFormat(ShipDate, "mm/dd/yy")#
			</td>
			<td>
				<cfquery name="thisBillingStatus" dbtype="query">
					SELECT	StatusMessage
					FROM	getBillingStatusCodes
					WHERE	StatusCode = '#BillingStatus#'
				</cfquery>
				#thisBillingStatus.StatusMessage#
			</td>
			
			<!--- GET ORDER TOTAL --->
			<cfinvoke component="#application.Queries#" method="getOrderTotal" returnvariable="getOrderTotal">
				<cfinvokeargument name="OrderID" value="#OrderID#">
			</cfinvoke>
			
			<cfscript>
				if ( getOrderTotal.RunningTotal EQ '' )
					getOrderTotal.RunningTotal = 0;
				RunningTotal = getOrderTotal.RunningTotal - getOrders.DiscountTotal + getOrders.ShippingTotal + getOrders.TaxTotal - getOrders.CreditApplied;
			</cfscript>
			
			<td><b>#LSCurrencyFormat(RunningTotal, "local")#</b></td>
			
		</tr>
		<input type="hidden" name="OrderID" value="#OrderID#">
		</cfform>
		<!--- DIVIDER --->
		<tr><td height="1" colspan="11"><img src="images/image-LineGray.gif" width="100%" height="1"></td></tr>
	</cfoutput>
<!--- END: REGULAR MODE --------------------------------------------------------------------------------------------------->
<!--- START: QUICK EDIT MODE --------------------------------------------------------------------------------------------------->
<cfelseif Mode EQ 1 >
	<cfoutput query="getOrders" startrow="#StartRow#" maxrows="#RowsPerPage#">
	<cfset RunningTotal = 0>
		<cfform action="Orders.cfm?StartRow=#StartRow#&SortOption=#SortOption#&SortAscending=#SortAscending#&field=#field#&string=#string#" method="post">
		<tr>
			<td>
				<input type="button" name="ViewOrder" value="VIEW" alt="View Order Details" class="cfAdminButton"
					onclick="document.location.href='OrderDetail.cfm?OrderID=#OrderID#'">
			</td>
			<td>
				<input type="submit" name="DeleteOrder" value="X" alt="Delete Order" class="cfAdminButton"
					onclick="return confirm('Are you sure you want to DELETE ORDER #OrderID# ?')">
			</td>
			<td><a href="OrderDetail.cfm?OrderID=#OrderID#" class="cfAdminDefault">#OrderID#</a></td>
			<td>#DateFormat(DateEntered, "mm/dd/yy")#</td>
			
			<cfinvoke component="#application.Queries#" method="getCustomer" returnvariable="getCustomer">
				<cfinvokeargument name="CustomerID" value="#getOrders.CustomerID#">
			</cfinvoke>
			
			<td>
				<a href="CustomerDetail.cfm?CustomerID=#CustomerID#" class="cfAdminDefault">#getCustomer.LastName#</a>, #getCustomer.FirstName#
			</td>
			<td>
				<a href="CustomerDetail.cfm?CustomerID=#CustomerID#" class="cfAdminDefault">#getCustomer.CompanyName#</a>
			</td>
			<td>
				<cfselect name="OrderStatus" query="getOrderStatusCodes" size="1" 
					value="StatusCode" display="StatusMessage" selected="#OrderStatus#" class="cfAdminDefault" onChange="updateInfo(#OrderID#,this.value,'OrderStatus','Orders');" />
			</td>
			<td>
				<cfinput type="text" validate="date" name="ShipDate" value="#DateFormat(ShipDate, "mm/dd/yy")#" size="10" class="cfAdminDefault" onchange="updateInfo(#OrderID#,this.value,'ShipDate','Orders');">
			</td>
			<td width="25%">
				<cfselect name="BillingStatus" query="getBillingStatusCodes" size="1" 
					value="StatusCode" display="StatusMessage" selected="#BillingStatus#" class="cfAdminDefault" onChange="updateInfo(#OrderID#,this.value,'BillingStatus','Orders');" />			
			</td>
			
			<!--- GET ORDER TOTAL --->		
			<cfinvoke component="#application.Queries#" method="getOrderTotal" returnvariable="getOrderTotal">
				<cfinvokeargument name="OrderID" value="#OrderID#">
			</cfinvoke>
			
			<cfscript>
				if ( getOrderTotal.RunningTotal EQ '' )
					getOrderTotal.RunningTotal = 0;
				RunningTotal = getOrderTotal.RunningTotal - getOrders.DiscountTotal + getOrders.ShippingTotal + getOrders.TaxTotal - getOrders.CreditApplied;
			</cfscript>
			
			<td><b>#LSCurrencyFormat(RunningTotal, "local")#</b></td>

		</tr>
		<input type="hidden" name="OrderID" value="#OrderID#">
		</cfform>
		<!--- DIVIDER --->
		<tr><td height="1" colspan="11"><img src="images/image-LineGray.gif" width="100%" height="1"></td></tr>
	</cfoutput>
</cfif>
<!--- END: QUICK EDIT MODE --------------------------------------------------------------------------------------------------->

<!--- NAVIGATION ------------------------------------->
	<tr>
		<td class="cfAdminDefault" colspan="7"><cfoutput>Displaying <b>#URL.StartRow#</b> to <b>#EndRow#</b> of <b>#TotalRows#</b> Orders</cfoutput></td>
		<td align="right" colspan="4"><cfinclude template="NextNButtons.cfm"></td>
	</tr>
	<!--- EXECUTION TIME TEST
	<tr>
		<td class="cfAdminDefault" colspan="11"><cfoutput>It took #getOrderExecutionTime# milliseconds to execute this query</cfoutput></td>
	</tr>
	--->
<!--- NAVIGATION ------------------------------------->
</table>
<br><br>

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
			<input type="button" name="NewOrders" value="NEW ORDERS" alt="Show Only New Orders" class="cfAdminButton"
				onclick="document.location.href='Orders.cfm?Field=New'">
			<input type="button" name="PendingOrders" value="PENDING ORDERS" alt="Show Only Pending Orders" class="cfAdminButton"
				onclick="document.location.href='Orders.cfm?Field=Pending'">
			<input type="button" name="AllOrders" value="ALL ORDERS" alt="Show All Orders" class="cfAdminButton"
				onclick="document.location.href='Orders.cfm'">
		</td>
	</tr>
	<tr><td height="1" style="border:0px;"><img src="images/image-LineGray.gif" width="100%" height="1"></td></tr>
	<cfform action="Orders.cfm?Field=Status" method="post">
	<tr>
		<td style="border:1px; border-color:000000;" align="center">
			Orders with Order Status: 
			<cfselect name="ShowOrderStatus" query="getOrderStatusCodes" size="1" value="StatusCode" display="StatusMessage" class="cfAdminDefault">
				<option value="" selected>-- SELECT --</option>
			</cfselect>
		</td>
	</tr>
	<tr>
		<td style="border:1px; border-color:000000;" align="center">
			Orders with Billing Status: 
			<cfselect name="ShowBillingStatus" query="getBillingStatusCodes" size="1" value="StatusCode" display="StatusMessage" class="cfAdminDefault">
				<option value="" selected>-- SELECT --</option>
			</cfselect>
		</td>
	</tr>
	<tr>
		<td style="border:1px; border-color:000000;" align="center">
			<input type="submit" name="GetOrders" value="GET ORDERS" alt="Get Orders" class="cfAdminButton">
		</td>
	</tr>
	</cfform>
</table>
<!--- QUICK LINKS --->

<cfinclude template="LayoutAdminFooter.cfm">