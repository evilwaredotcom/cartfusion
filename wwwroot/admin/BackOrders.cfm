<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<!--- SET DEFAULT PARAMETERS --->
<cfparam name="URL.StartRow" default="1" type="numeric">
<cfparam name="URL.PageRows" default="0" type="numeric">
<cfparam name="URL.SortOption" default="LastName" type="string">
<cfparam name="URL.SortAscending" default="1" type="numeric">
<cfparam name="Form.Field" default="ALL" type="string">
<cfparam name="Form.string" default="" type="string">
<cfset string = Trim(string)>

<cfif IsDefined("session.StoredBackOrders")> <cfset StructDelete(session, "StoredBackOrders")> </cfif>
<!--- Must create this default structure or we pull an error ---> 
<cfparam name="session.StoredBackOrders" default=""> 
<cfif NOT IsStruct(session.StoredBackOrders)> 
	<cfset session.StoredBackOrders = StructNew()> 
</cfif> 

<!--- Now we create default variable using cfparam ---> 
<cfparam name="session.StoredBackOrders.ItemSelect" default=""> 

<!--- BEGIN: SEARCH CRITERIA -------------------------------------------------->

<cfif isDefined('field')><!--- IF COMING IN FROM Search.cfm --->
	<cfquery name="getItemID" datasource="#application.dsn#">
		SELECT  ItemID
		FROM	Products
		WHERE	SKU like '%#string#%'
		ORDER BY SKU
	</cfquery>
<cfelse>
	<cfset field = ''>
</cfif>

<cflock timeout="10">	
	<cfquery name="getBackOrders" datasource="#application.dsn#">	
		SELECT 	o.OrderID, o.CustomerID, 
				oi.OrderItemsID, oi.ItemID, oi.Qty, oi.ItemPrice,  
				oi.OptionName1, oi.OptionName2, oi.OptionName3, oi.Deleted, 
				oi.DateEntered AS OriginalDate,
				c.LastName, c.CompanyName
		FROM	Orders o, OrderItems oi, Customers c
		WHERE	oi.StatusCode = 'BO'
		AND		o.OrderID = oi.OrderID
		AND		o.CustomerID = c.CustomerID
		<cfif field EQ 'AllFields'>
		AND		
		(		o.OrderID like '%#string#%'
		OR		o.OShipLastName like '%#string#%'
		OR		o.OShipFirstName like '%#string#%'
		OR		o.OShipCompanyName like '%#string#%'
		OR		o.CustomerID like '%#string#%'
		OR		c.CustomerID like '%#string#%'
		OR		c.LastName like '%#string#%'
		OR		c.FirstName like '%#string#%'
		OR		c.CompanyName like '%#string#%'
		OR		oi.ItemID IN (SELECT ItemID FROM Products WHERE SKU LIKE '%#string#%' OR ItemName LIKE '%#string#%')
		<cfif getItemID.RecordCount NEQ 0>
		OR		oi.ItemID = #getItemID.ItemID#
		</cfif>
		)		
		<cfelseif field EQ 'LastName'>
		AND		(o.OShipLastName like '%#string#%'
		OR		c.LastName like '%#string#%')
		<cfelseif field EQ 'CompanyName'>
		AND		(o.OShipCompanyName like '%#string#%'
		OR		c.CompanyName like '%#string#%')
		<cfelseif field EQ 'City'>
		AND		(o.OShipCity like '%#string#%'
		OR		c.City like '%#string#%')
		<cfelseif field IS 'SKU'>
		AND		oi.ItemID = #getItemID.ItemID#
		<cfelseif field EQ 'DateEntered'>
		AND 	(o.#field# >= #FROMDATE# 
		AND 	o.#field# <= #TODATE#)
		OR 		(oi.#field# >= #FROMDATE# 
		AND 	oi.#field# <= #TODATE#)
		</cfif>	
		ORDER BY	
		<cfif isDefined('URL.SortOption')> #URL.SortOption# <cfelse> c.LastName, o.OrderID </cfif>
		<cfif SortAscending EQ 1> ASC <cfelse> DESC </cfif>
	</cfquery>
</cflock>

<!--- END: SEARCH CRITERIA -------------------------------------------------->

<!--- NEXT N VALUES --->

<cfscript>
	PageRows = 0;
	RowsPerPage = 5;
	TotalRows = getBackOrders.RecordCount;
	// FIND THESE STATEMENTS AFTER PROCESSING PAGE
	// EndRow = Min(URL.StartRow + RowsPerPage - 1, TotalRows);
 	// StartRowNext = EndRow + 1;
 	// StartRowBack = URL.StartRow - RowsPerPage;
</cfscript>

<!--- BEGIN: HEADER --->
<cfscript>
	PageTitle = 'BACK ORDERS';
	QuickSearch = 1;
	QuickSearchPage = 'BackOrders.cfm';
</cfscript>
<cfinclude template="BackOrdersJS.cfm">
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">
<!--- END: HEADER --->

<!--- BEGIN ORDERS TABLE --->

<table border="0" cellpadding="3" cellspacing="0" width="100%">
<cfoutput query="getBackOrders" startrow="#StartRow#" maxrows="#RowsPerPage#" group="OrderID">

	<cfquery name="getOrderInfo" datasource="#application.dsn#">
		SELECT  *
		FROM	Orders
		WHERE	OrderID = #getBackOrders.OrderID#
	</cfquery>
	
	<cfquery name="getCustomerInfo" datasource="#application.dsn#">
		SELECT  *
		FROM	Customers
		WHERE	CustomerID = '#getOrderInfo.CustomerID#'
	</cfquery>
	
	<cfscript>
		// IMPORTANT ROW COUNTER - MUST GO HERE
		PageRows = PageRows + 1 ;
		
		if ( getOrderInfo.CCNum NEQ '' ) 
			Decrypted_CCNum = DECRYPT(getOrderInfo.CCNum, application.CryptKey, "CFMX_COMPAT", "Hex") ;
		else 
			Decrypted_CCNum = '' ;
		if ( getOrderInfo.CCExpDate NEQ '' ) 
			Decrypted_CCExpDate = DECRYPT(getOrderInfo.CCExpDate, application.CryptKey, "CFMX_COMPAT", "Hex") ;
		else 
			Decrypted_CCExpDate = '' ;
	</cfscript>
	
	<cfquery name="getPaymentTypes" datasource="#application.dsn#">
		SELECT 	Display
		FROM	Payment
		WHERE	Type = '#getOrderInfo.CCName#'			
	</cfquery>

	<tr class="cfAdminDefault" style="background-color:##65ADF1;">
		<td align="left" width="25%" colspan="2" class="cfAdminHeader4">
			<b><a href="CustomerDetail.cfm?CustomerID=#getOrderInfo.CustomerID#" class="cfAdminHeader4">
				#getCustomerInfo.LastName#</a>, #getCustomerInfo.FirstName#</b>
		</td>
		<td align="left" width="40%" colspan="4" class="cfAdminHeader4">
			<b><a href="CustomerDetail.cfm?CustomerID=#getOrderInfo.CustomerID#" class="cfAdminHeader4">#getCustomerInfo.CompanyName#</a></b>
		</td>
		<td align="left" width="35%" colspan="3" class="cfAdminHeader4"><!--- #Ucase(getPaymentTypes.Display)# #decrypted_CCnum# Exp. #decrypted_CCexpdate# ---></td>
	</tr>
	<tr style="background-color:CCCCCC;">
		<td class="cfAdminHeader1">Select</td>
		<td class="cfAdminHeader1">SKU</td>
		<td class="cfAdminHeader1">Item Name/Description</td>
		<td class="cfAdminHeader1">Qty</td>
		<td class="cfAdminHeader1">Price</td>
		<td class="cfAdminHeader1">Tax</td>
		<td class="cfAdminHeader1">Total</td>	
		<td class="cfAdminHeader1">Order ID</td>
		<td class="cfAdminHeader1">Date</td>
	</tr>
	
	<cfquery name="getBackOrderedItems" datasource="#application.dsn#">	
		SELECT 	*, OrderItems.DateEntered AS OriginalDate
		FROM	OrderItems
		WHERE	StatusCode = 'BO'
		AND		OrderID = #OrderID#
	</cfquery>
	
<cfform action="BackOrdersConfirm.cfm" method="post" name="formProcessPayment" onreset="InitForm();">	
<cfloop query="getBackOrderedItems">
	
<!--- BEGIN: GET ALL ORDER & CUSTOMER INFO FOR BACKORDERED ITEM --->
	<cfquery name="getProductInfo" datasource="#application.dsn#">
		SELECT  ItemID, SKU, ItemName
		FROM	Products
		WHERE	ItemID = #getBackOrderedItems.ItemID#
		ORDER BY SKU
	</cfquery>

<!--- END: GET ALL ORDER & CUSTOMER INFO FOR BACK ORDERED ITEM --->

<!--- BEGIN: PRINT INFORMATION ABOUT BACK ORDERED ITEM --->
	
	<cfscript>
		RunningTotal = 0 ;
		RunningTotal = RunningTotal + Val(ItemPrice * Qty) ;
	</cfscript>
	
	<tr>
		<!--- GET ORDER TOTAL --->
		<!--- 
		FUTURE CALCULATE TAX IF NECESSARY 
		<cfset runningtotal = runningtotal - getBackOrders.DiscountTotal + getBackOrders.ShippingTotal + getBackOrders.TaxTotal>
		--->
		<td align="left">
			<cfinput type="Checkbox" name="ItemSelect" value="#getBackOrderedItems.OrderItemsID#" onclick="this.form.LocalTotal.value=CheckChoice(this,#runningtotal#);"> 
		</td>	
		<td>
			<a href="ProductDetail.cfm?ItemID=#ItemID#" class="cfAdminDefault">#getProductInfo.SKU#</a>
		</td>
		<td>
			<a href="ProductDetail.cfm?ItemID=#ItemID#" class="cfAdminDefault">#getProductInfo.ItemName#</a>
				<cfif OptionName1 NEQ ''><b>: #OptionName1#</b></cfif>
				<cfif OptionName2 NEQ ''><b>; #OptionName2#</b></cfif> 
				<cfif OptionName3 NEQ ''><b>; #OptionName3#</b></cfif> 
		</td>
		<td>#Qty#</td>
		<td>#LSCurrencyFormat(ItemPrice, "local")#</td>
		<!--- GET ORDER TOTAL --->
		<!--- 
		FUTURE CALCULATE TAX IF NECESSARY 
		<cfset runningtotal = runningtotal - getBackOrders.DiscountTotal + getBackOrders.ShippingTotal + getBackOrders.TaxTotal>
		--->
		<td>&nbsp;</td>
		<td><b>#LSCurrencyFormat(runningtotal, "local")#</b></td>		
		<td><a href="OrderDetail.cfm?OrderID=#OrderID#" class="cfAdminDefault">#OrderID#</a></td>
		<td>#DateFormat(OriginalDate, "mm/dd/yy")#</td>				
	</tr>
</cfloop>

	<tr style="background-color:##CCCCCC;">
		<td height="1" colspan="9"></td>
	</tr>
	<tr>
		<td bgcolor="##EFEFEF" colspan="2" class="cfAdminDefault">
			<!--- SHOW Credit --->
			Credit Available: <font class="cfAdminError">#LSCurrencyFormat(getCustomerInfo.Credit)#</font>
		</td>
		<td align="right" bgcolor="##EFEFEF" colspan="7" class="cfAdminDefault">
			<!--- SHOW LOCAL TOTAL --->
			Subtotal: $<input type="text" name="LocalTotal" size="7" value="0.00" class="cfAdminError">
			&nbsp;&nbsp;&nbsp;			
			<!--- APPLY PERCENTAGE DISCOUNT --->
			Apply Discount: %<cfinput type="text" name="DiscountToApply" size="4" maxlength="2" class="cfAdminDefault" required="no" validate="integer" message="Discount must be a POSITIVE one- or two-digit number.">
			&nbsp;&nbsp;&nbsp;
			<!--- APPLY Credit --->
			Apply from Credit Account: $<cfinput type="text" name="CreditApplied" size="7" class="cfAdminDefault" validate="float" message="Credit amount should be a POSITIVE number.">
			
			<input type="hidden" name="hiddentotal" value="0.00">
			<input type="hidden" name="hiddenpriorradio" value=0>
			<!--- VARIABLES TO CONFIRMATION PAGE, THEN TO PAYMENT GATEWAY --->
			<input type="hidden" name="OrderID" value="#OrderID#">
			<input type="hidden" name="CustomerID" value="#getOrderInfo.CustomerID#">
			<input type="submit" name="ProcessPayment" value="PROCEED" alt="Proceed with back order process" class="cfAdminButton">
		</td>
	</tr>
</cfform>
	
	<!--- DIVIDER --->
	<tr style="background-color:##CCCCCC;">
		<td height="1" colspan="9"></td>
	</tr>
	<tr>
		<td height="10" colspan="9"></td>
	</tr>
</cfoutput><!--- END Customer Sorted OUTPUT --->

<!--- PROCESS THIS STATEMENT AFTER PROCESSING QUERIES AND LOOPS TO GET TOTAL ITEMS, NOT ORDERS, FOR NEXT/PREV NAVIGATION --->
<cfscript>
	EndRow = Min(URL.StartRow + PageRows - 1, TotalRows);
	StartRowNext = EndRow + 1;
	StartRowBack = URL.StartRow - URL.PageRows;
</cfscript>

<!--- NAVIGATION ------------------------------------->
	<tr>
		<td colspan="7"><cfoutput>Displaying <b>#URL.StartRow#</b> to <b>#EndRow#</b> of <b>#TotalRows#</b> Back Orders</cfoutput></td>
		<td align="right" colspan="4">		
			<cfinclude template="NextNButtons.cfm">		
		</td>
	</tr>
<!--- NAVIGATION ------------------------------------->
</table>

<br><br><br>
<cfinclude template="LayoutAdminFooter.cfm">