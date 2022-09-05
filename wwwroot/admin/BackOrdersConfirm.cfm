<!--- 
|| MIT LICENSE
|| CartFusion.com
--->



<!--- BEGIN: HEADER --->
<cfscript>
	PageTitle = 'BACK ORDER DETAIL';
	QuickSearch = 1;
	QuickSearchPage = 'BackOrders.cfm';
</cfscript>
<cfinclude template="BackOrdersJS.cfm">
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">
<!--- END: HEADER --->


<!------------>
<cfset RunningTotal = 0 >
<!------------>

<!--- Must create this default structure or we pull an error ---> 
<cfparam name="session.StoredBackOrders" default=""> 
<cfif NOT IsStruct(session.StoredBackOrders)> 
	<cfset session.StoredBackOrders = StructNew()> 
</cfif> 

<!--- Now we create default variable using cfparam ---> 
<cfparam name="session.StoredBackOrders.ItemSelect" default=""> 

<cfif NOT isDefined('form.ItemSelect')>
	<cflocation url="BackOrders.cfm" addtoken="no">
<cfelse>
	<!---store user-selected form variables into session struct ---> 
	<cfset session.StoredBackOrders.ItemSelect=form.ItemSelect> 
</cfif>

<cflock timeout="5">
	<cfquery name="getOrder" datasource="#application.dsn#">
		SELECT	*, Orders.DateEntered as OrderDate, Orders.Comments AS OrderComments,
				Orders.Phone AS OrderPhone, Customers.Phone AS CustomerPhone
		FROM 	Orders, Customers
		WHERE	Orders.CustomerID = '#CustomerID#'
		AND		Customers.CustomerID = '#CustomerID#'
		AND 	Orders.OrderID = #OrderID#
	</cfquery>
</cflock>

<br>

<!--- CUSTOM FILE
<cfinclude template="CustomFiles/BackOrdersConfirmHeader.cfm">
--->
 
<!--- CARTFUSION DEFAULT --->
<cfoutput>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td width="33%">
			<b>#UCase(application.storename)# INVOICE</b><br>
			Order ## #OrderID#<br>
			Customer ID: #getOrder.CustomerID#<br>
			Order Date: #DateFormat(getOrder.OrderDate, "d-mmm-yyyy")#<br>
			Process Date: #DateFormat(Now(), "d-mmm-yyyy")#
		</td>
		<td width="33%">
			#application.CompanyName#<br>
			#application.CompanyAddress1#<br>
			<cfif #application.CompanyAddress2# NEQ ''>
			#application.CompanyAddress2#<br>
			</cfif>
			#application.CompanyCity#, #application.CompanyState# #application.CompanyZIP#<br>
			Phone: #application.CompanyPhone#
		</td>
		<td width="33%" align="right">
			<img src="../images/image-CompanyLogo.gif" border="0">
		</td>
	</tr>
</table>
</cfoutput>

<br>

<cfoutput query="getOrder" group="OrderID">

	<cfscript>			
		if ( getOrder.CCNum NEQ '') Decrypted_CCNum = DECRYPT(getOrder.CCNum, application.CryptKey, "CFMX_COMPAT", "Hex") ;
		else Decrypted_CCNum = '';
		if ( getOrder.CCExpDate NEQ '') Decrypted_CCExpDate = DECRYPT(getOrder.CCExpDate, application.CryptKey, "CFMX_COMPAT", "Hex") ;
		else Decrypted_CCExpDate = '';
	</cfscript>
	
	<cfinvoke component="#application.Queries#" method="getPaymentType" returnvariable="getPaymentType">
		<cfinvokeargument name="Type" value="#getOrder.CCName#">
	</cfinvoke>
	
	<cfinvoke component="#application.Queries#" method="getShippingMethod" returnvariable="getShippingMethod">
		<cfinvokeargument name="ShippingCode" value="#getOrder.ShippingMethod#">
	</cfinvoke>
			
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr class="cfAdminHeader1" style="background-color:##65ADF1;">
		<td width="33%" colspan="2" height="20" class="cfAdminHeader1">&nbsp; BILLING INFORMATION</td>
		<td rowspan="12" width="1%" style="background-color:##FFFFFF;">&nbsp;</td>
		<td width="32%" colspan="2" class="cfAdminHeader1">&nbsp; SHIPPING INFORMATION</td>
		<td rowspan="12" width="1%" style="background-color:##FFFFFF;">&nbsp;</td>
		<td width="33%" colspan="2" class="cfAdminHeader1">&nbsp; PAYMENT INFORMATION</td>
	</tr>
	<tr>
		<td colspan="6" height="5">&nbsp;</td>
	</tr>
	<tr>
		<td width="15%">First Name:</td>
		<td width="15%">#FirstName#</td>
		<td width="15%">First Name:</td>
		<td width="15%">#OShipFirstName#</td>
		<td width="15%"></td>
		<td width="25%"></td>
		<!---<td width="15%">Payment Processed:</td>
		<td width="25%">
			<cfif PaymentVerified EQ 1>Yes
			<cfelse>No
			</cfif>
		</td>--->
	</tr>
	<tr>
		<td>Last Name:</td>
		<td>#LastName#</td>
		<td>Last Name:</td>
		<td>#OShipLastName#</td>
		<td colspan="2"></td>
	</tr>
	<tr>
		<td>Company Name:</td>
		<td>#CompanyName#</td>
		<td>Company Name:</td>
		<td>#OShipCompanyName#</td>
		<td>Form of Payment:</td>
		<td>
			<cfif FormOfPayment EQ 1 >Credit Card
			<cfelseif FormOfPayment EQ 2 >PayPal
			<cfelseif FormOfPayment EQ 3 >E-Check
			<cfelseif FormOfPayment EQ 4 >Order Form
			<cfelse>On File
			</cfif>
		</td>
	</tr>
	<tr>
		<td>Address 1:</td>
		<td>#Address1#</td>
		<td>Address 1:</td>
		<td>#OShipAddress1#</td>
		<cfif FormOfPayment EQ 1 >
		<td width="15%">Card Name:</td>
		<td width="25%">#getPaymentType.Display#</td>
		<cfelse>
		<td width="40%" colspan="2" rowspan="3">
		</cfif>
	</tr>
	<tr>
		<td>Address 2:</td>
		<td>#Address2#</td>
		<td>Address 2:</td>
		<td>#OShipAddress2#</td>
		<cfif FormOfPayment EQ 1 >
		<td>Card Number:</td>
	  	<td>#decrypted_CCNum#</td>
		</cfif>
	</tr>
	<tr>	
		<td>City:</td>
		<td>#City#</td>
		<td>City:</td>
		<td>#OShipCity#</td>
		<cfif FormOfPayment EQ 1 >
		<td>Exp. Date:</td>
		<td>#decrypted_CCexpdate#</td>
		</cfif>
	</tr>
	<tr>	
		<td>State:</td>
		<td>#State#</td>
		<td>State:</td>
		<td>#OShipState#</td>
		<td>CVV:</td>
		<td>#CCCVV#</td>
	</tr>
	<tr>	
		<td>Zip/Postal:</td>
		<td>#Zip#</td>
		<td>Zip/Postal:</td>
		<td>#OShipZip#</td>
		<td colspan="2"></td>
	</tr>
	<tr>	
		<td>Country:</td>
		<td>#Country#</td>
		<td>Country:</td>
		<td>#OShipCountry#</td>
		<td colspan="2"></td>
	</tr>
	<tr>	
		<td>Phone:</td>
		<td>#OrderPhone#</td>
		<td>Phone:</td>
		<td>#CustomerPhone#</td>
		<td>Shipping Method:</td>
		<td>#getShippingMethod.ShippingMessage#</td>
	</tr>
</table>	

<br>
<hr color="##CCCCCC" width="100%">
<!--- ORDERED ITEMS ----------------------------------------------------------------->

<div align="left" class="cfAdminHeader1">BACK ORDERED ITEMS PROCESSED</div>
<br>

<table border="0" cellpadding="3" cellspacing="0" width="100%">
	<tr style="background-color:##CCCCCC;">
		<td height="1" colspan="8"></td>
	</tr>
	<tr class="cfAdminHeader1" style="background-color:##65ADF1;">
		<td width="10%" class="cfAdminHeader1">Order ID</td>
		<td width="10%" class="cfAdminHeader1">Action Date</td>
		<td width="10%" class="cfAdminHeader1" height="20">SKU</td>
		<td width="30%" class="cfAdminHeader1">Item Name/Description</td>
		<td width="5%"  class="cfAdminHeader1">Qty</td>
		<td width="10%" class="cfAdminHeader1">Unit Price</td>
		<td width="10%" class="cfAdminHeader1" align="right">Tax </td>
		<td width="10%" class="cfAdminHeader1" align="right">Total</td>
	</tr>
	<tr style="background-color:##CCCCCC;">
		<td height="1" colspan="8"></td>
	</tr>
<cfloop index="OrderItemsID" list="#session.StoredBackOrders.ItemSelect#"> 

	<cfquery name="getBackOrderedItems" datasource="#application.dsn#">	
		SELECT 	*
		FROM	OrderItems
		WHERE	OrderItemsID = #OrderItemsID#
	</cfquery>
		
	<cfloop query="getBackOrderedItems">	
	<!--- BEGIN: GET ALL ORDER & CUSTOMER INFO FOR BACKORDERED ITEM --->
		<cfquery name="getProductInfo" datasource="#application.dsn#">
			SELECT  ItemID, SKU, ItemName
			FROM	Products
			WHERE	ItemID = #getBackOrderedItems.ItemID#
			ORDER BY SKU
		</cfquery>
	<tr>
		<td><b>#OrderID#</b></td>
		<td>#DateFormat(Now(), "d-mmm-yyyy")#</td>
		<td>#getProductInfo.SKU#</td>
		<td>#getProductInfo.ItemName#
			<!--- TOMKATZ ONLY
			<cfinclude template="CustomFiles/BackOrdersConfirm.cfm">
			--->
			<!--- CARTFUSION DEFAULT --->
			<cfif OptionName1 NEQ ''>: #OptionName1#</cfif>
			<cfif OptionName2 NEQ ''>, #OptionName2#</cfif>
			<cfif OptionName3 NEQ ''>, #OptionName3#</cfif>					
		</td>
		<td>#Qty#</td>
		<td align="left">
			 #LSCurrencyFormat(ItemPrice, "local")#
		</td>
		<td></td>
		<td align="right">#LSCurrencyFormat(Val(ItemPrice * Qty), "local")#
			<cfset RunningTotal = RunningTotal + #Val(ItemPrice * Qty)#>
		</td>
	</tr>
	<tr style="background-color:##CCCCCC;">
		<td height="1" colspan="9"></td>
	</tr>
	</cfloop>
</cfloop>
	
<!--- TOTALS ---------------------------------------------------------------------->
	<tr>
		<td colspan="6" height="20">&nbsp;</td>
		<td align="right">SubTotal:</td>
		<td align="right">#LSCurrencyFormat(RunningTotal, "local")#</td>
	</tr>
	<!--- BEGIN: APPLY DISCOUNT AFTER SUBTOTAL SHOWN, THEN SET PAYMENT GATEWAY TOTAL --->
	<cfif isDefined('Form.DiscountToApply') AND DiscountToApply GT 0>
		<cfif DiscountToApply GTE 10>
			<cfset FormattedDiscount = DecimalFormat(('0.' & DiscountToApply) * RunningTotal) >
		<cfelse>
			<cfset FormattedDiscount = DecimalFormat(('0.0' & DiscountToApply) * RunningTotal) >
		</cfif>
	<tr>
		<td colspan="6" height="20">&nbsp;</td>
		<td align="right" class="cfAdminError">#Form.DiscountToApply#% Discount:</td>
		<td align="right" class="cfAdminError">#LSCurrencyFormat(FormattedDiscount, "local")#</td>
	</tr>	
	<cfset RunningTotal = RunningTotal - FormattedDiscount>
	</cfif>
	<!--- END: APPLY DISCOUNT AFTER SUBTOTAL SHOWN, THEN SET PAYMENT GATEWAY TOTAL --->

	<cfif isDefined('Form.CreditApplied') AND Form.CreditApplied GT 0>
		<cfif Form.CreditApplied GT RunningTotal>
			<cfset Form.CreditApplied = RunningTotal>
			<script>
				alert('Pot O\' Gold has been adjusted so this transaction does not have a negative total.'); 
			</script>
		</cfif>
	<tr>
		<td colspan="5" height="20">&nbsp;</td>
		<td align="right" colspan="2" class="cfAdminError">Credit Applied:</td>
		<td align="right" class="cfAdminError">#LSCurrencyFormat(Replace(Form.CreditApplied,',',''), "local")#</td>
	</tr>
	<cfset RunningTotal = RunningTotal - Replace(Form.CreditApplied,',','') >
	</cfif>
	<tr>
		<td colspan="8" height="5"></td>
	</tr>
	<tr style="background-color:##CCCCCC;">
		<td height="1" colspan="8"></td>
	</tr>
	<!--- AFTER DISCOUNT AND CREDIT IS SUBTRACTED FROM RUNNING TOTAL, SET PAYMENT GATEWAY TOTAL --->
	<tr class="cfAdminHeader1" style="background-color:##65ADF1;">
		<td colspan="6" height="20" class="cfAdminHeader1">&nbsp;</td>
		<td align="right" valign="middle" class="cfAdminHeader1"><b>Total:</b></td>
		<td align="right" valign="middle" class="cfAdminHeader1"><b>#LSCurrencyFormat(RunningTotal, "local")#</b></td>
	</tr>
	<tr style="background-color:##CCCCCC;">
		<td height="1" colspan="8"></td>
	</tr>
</table>

<table border="0" cellpadding="7" cellspacing="0" width="100%">
	<tr>
		<td colspan="4" height="20"></td>
	</tr>	
	<tr class="cfAdminDefault" valign="top">
		<td width="10">Store Comments:</td>
		<td width="40%">
			NOTE: We reserve the right to substitute a product ordered with another product of similar style.<br>
			RETURNS: There will be a 15% restocking fee for all returned merchandise (excludes defective merchandise).<br>
			<textarea name="Comments" rows="6" cols="70" class="cfAdminDefault">#OrderComments#</textarea></td>
		<td width="10%">Customer Comments:</td>
		<td width="40%">#CustomerComments#</td>
	</tr>
</table>

<br><br>

<table align="center" width="100%">
	<tr>
		<td align="center">
			<!--- TELL PAYMENT GATEWAY THIS IS A BACK ORDER --->
			<cfset BackOrderCC = 1 >
			
			<!--- PROCESS PAYMENT BUTTON --->
			<cfif FormOfPayment EQ 1 >
				
				<!--- MANUAL ORDER HANDLING --->
				<cfif application.PaymentSystem EQ 1 >
					<!--- DO NOTHING --->
				
				<!--- AUTHORIZE.NET --->
				<cfelseif application.PaymentSystem EQ 2 >
					<cfinclude template="Includes/PG-AuthorizeNet.cfm">
				
				<!--- USAePay --->
				<cfelseif application.PaymentSystem EQ 3 >
					<cfinclude template="Includes/PG-USAePay.cfm">
					
				<!--- PAYFLOW LINK --->
				<cfelseif application.PaymentSystem EQ 4 >
					<cfinclude template="Includes/PG-PayFlowLink.cfm">
				
				<!--- WORLDPAY --->
				<cfelseif application.PaymentSystem EQ 6 >
					<cfinclude template="Includes/PG-WorldPay.cfm">
					
				</cfif>
				
			</cfif>
		</td>
	</tr>
</table>
</cfoutput>

<cfinclude template="LayoutAdminFooter.cfm">