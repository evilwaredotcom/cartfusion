<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<cfif NOT isDefined('session.CustomerArray') OR session.CustomerArray[11] EQ '' OR NOT isDefined('OrderID')>
	<div class="cfErrorMsg">ERROR: No Email Address Specified</div>
	<cfabort>
</cfif>

<cflock timeout="5">
	<cfinvoke component="#application.Queries#" method="getOrder" returnvariable="getOrder">
		<cfinvokeargument name="OrderID" value="#OrderID#">
	</cfinvoke>
	<cfinvoke component="#application.Queries#" method="getOrderItems" returnvariable="getOrderItems">
		<cfinvokeargument name="OrderID" value="#OrderID#">
	</cfinvoke>
	<cfinvoke component="#application.Queries#" method="getBackOrders" returnvariable="getBackOrders">
		<cfinvokeargument name="OrderID" value="#OrderID#">
	</cfinvoke>
</cflock>

<cfmail query="getOrder" group="OrderID" from="#application.EmailSales#" to="#session.CustomerArray[11]#" bcc="webmaster@tradestudios.com,#application.NotifyEmail#"
	subject="#application.StoreNameShort# Order ###OrderID# Received" type="HTML">

<html>
<head>
<link rel="stylesheet" type="text/css" href="../templates/#application.SiteTemplate#/screen_layout.css">
<link rel="stylesheet" type="text/css" href="../templates/#application.SiteTemplate#/screen_formatting.css">
<link rel="stylesheet" type="text/css" href="../templates/#application.SiteTemplate#/screen_design.css">
<!--- <cfinclude template="../css.cfm"> --->
<style type="text/css">
	TD, DIV, TEXTAREA
	{ color:##000; }
</style>

</head>

<body>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td width="33%">
			<b>#UCase(application.storename)# INVOICE</b><br>
			Order ## #OrderID#<br>
			Customer ID: #getOrder.CustomerID#<br>
			Order Date: #DateFormat(getOrder.OrderDate, "d-mmm-yyyy")#
		</td>
		<td width="33%">
			#application.CompanyName#<br>
			#application.CompanyAddress1#<br>
			<cfif #application.CompanyAddress2# NEQ ''>
			#application.CompanyAddress2#<br>
			</cfif>
			#application.CompanyCity#, #application.CompanyState# #application.CompanyZIP#
		</td>
		<td width="33%" align="right"></td>
	</tr>
</table>

<br>
<cfscript>
	if ( getOrder.CCNum NEQ '') Decrypted_CCNum = DECRYPT(getOrder.CCNum, application.CryptKey, "CFMX_COMPAT", "Hex") ;
	else Decrypted_CCNum = '';
	if ( getOrder.CCExpDate NEQ '') Decrypted_CCExpDate = DECRYPT(getOrder.CCExpDate, application.CryptKey, "CFMX_COMPAT", "Hex") ;
	else Decrypted_CCExpDate = '';
	
	// Queries
	getPaymentType = application.Queries.getPaymentType(Type='#getOrder.CCName#');
	getShippingMethod = application.Queries.getShippingMethod(ShippingCode='#getOrder.ShippingMethod#');
</cfscript>

<!--- <cfinvoke component="#application.Queries#" method="getPaymentType" returnvariable="getPaymentType">
	<cfinvokeargument name="Type" value="#getOrder.CCName#">
</cfinvoke>

<cfinvoke component="#application.Queries#" method="getShippingMethod" returnvariable="getShippingMethod">
	<cfinvokeargument name="ShippingCode" value="#getOrder.ShippingMethod#">
</cfinvoke> --->
			
<table border="0" cellpadding="0" cellspacing="0" width="100%" class="cartLayoutTable">
	<tr>
		<th width="33%" colspan="2" height="20">&nbsp; BILLING INFORMATION</th>
		<td rowspan="11" width="1%" bgcolor="##FFF">&nbsp;</td>
		<th width="32%" colspan="2">&nbsp; SHIPPING INFORMATION</th>
		<td rowspan="11" width="1%" bgcolor="##FFF">&nbsp;</td>
		<th width="33%" colspan="2">&nbsp; PAYMENT INFORMATION</th>
	</tr>
	<tr>
		<td colspan="6" height="5">&nbsp;</td>
	</tr>
	<tr class="row0">
		<td width="15%">First Name:</td>
		<td width="15%">#FirstName#</td>
		<td width="15%">First Name:</td>
		<td width="15%">#OShipFirstName#</td>
		<td width="15%">Payment Processed:</td>
		<td width="25%">
			<cfif PaymentVerified EQ 1>Yes
			<cfelse>No
			</cfif>
		</td>
	</tr>
	<tr class="row1">
		<td>Last Name:</td>
		<td>#LastName#</td>
		<td>Last Name:</td>
		<td>#OShipLastName#</td>
		<td colspan="2"></td>
	</tr>
	<tr class="row0">
		<td>Company:</td>
		<td>#CompanyName#</td>
		<td>Company:</td>
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
	<tr class="row1">
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
	<tr class="row0">
		<td>Address 2:</td>
		<td>#Address2#</td>
		<td>Address 2:</td>
		<td>#OShipAddress2#</td>
		<cfif FormOfPayment EQ 1 >
		<td>Card Number:</td>
	  	<td>XXXXXXXX#Right(decrypted_CCNum,4)#</td>
		</cfif>
	</tr>
	<tr class="row1">	
		<td>City:</td>
		<td>#City#</td>
		<td>City:</td>
		<td>#OShipCity#</td>
		<cfif FormOfPayment EQ 1 >
		<td>Exp. Date:</td>
		<td>#decrypted_CCexpdate#</td>
		</cfif>
	</tr>
	<tr class="row0">
		<td>State:</td>
		<td>#State#</td>
		<td>State:</td>
		<td>#OShipState#</td>
		<td colspan="2"></td>
	</tr>
	<tr class="row1">
		<td>Zip/Postal:</td>
		<td>#Zip#</td>
		<td>Zip/Postal:</td>
		<td>#OShipZip#</td>
		<td>Shipping Method:</td>
		<td>#getShippingMethod.ShippingMessage#</td>
	</tr>
	<tr class="row0">
		<td>Country:</td>
		<td>#Country#</td>
		<td>Country:</td>
		<td>#OShipCountry#</td>
		<td colspan="2"></td>
	</tr>
</table>	


<br>
<hr class="snip">
<!--- ORDERED ITEMS ----------------------------------------------------------------->

<div align="left">ORDER ITEMS</div><br>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr bgcolor="##CCCCCC">
		<td height="1" colspan="7"></td>
	</tr>
	<tr>
		<th width="1%" height="20"></td>
		<th width="39%">Item Name/Description</td>
		<th width="5%"  align="center">Qty</td>
		<th width="15%">Unit Price</td>
		<th width="15%">Item Status</td>
		<th width="10%">Action Date</td>
		<th width="10%" align="right">Price</td>
	</tr>
	<tr bgcolor="##CCCCCC">
		<td height="1" colspan="7"></td>
	</tr>

<cfset runningtotal = 0>
	
<cfloop query="getOrderItems">
<tr>
	<td></td>
	<td>#ItemName#
			<cfif OptionName1 NEQ ''><b><br> #OptionName1#</b></cfif>
			<cfif OptionName2 NEQ ''><b>; #OptionName2#</b></cfif>
			<cfif OptionName3 NEQ ''><b>; #OptionName3#</b></cfif><br><br>
	</td>
	<td align="center">#Qty#</td>
	<td>#LSCurrencyFormat(ItemPrice)#</td>			
	
		<!--- <cfinvoke component="#application.Queries#" method="getOrderItemsStatusCode" returnvariable="getOrderItemsStatusCode">
			<cfinvokeargument name="StatusCode" value="#StatusCode#">
		</cfinvoke> --->
		
		
		<cfscript>
			// Get Query
			getOrderItemsStatusCode = application.Queries.getOrderItemsStatusCode(StatusCode=StatusCode);
			
			if ( StatusCode IS 'BO' OR StatusCode IS 'CA' OR StatusCode IS 'RE' )
				DisplayPrice = 0;
			else 
			{
				DisplayPrice = Val(ItemPrice * Qty);
				runningtotal = runningtotal + Val(ItemPrice * Qty);
			}
		</cfscript>
	<td>#getOrderItemsStatusCode.StatusMessage#</td>
	<td>#DateFormat(OrderItemDate, "mm/dd/yy")#</td>
	<td align="right">#LSCurrencyFormat(DisplayPrice, "local")#</td>
</tr>
</cfloop>



<!--- TOTALS ---------------------------------------------------------------------->

	<tr class="subTotal">
		<td align="right" colspan="6" height="20"><strong>SubTotal:</strong></td>
		<td align="right"><strong>#LSCurrencyFormat(runningtotal, "local")#</strong></td>
	</tr>
	<cfset runningtotal = runningtotal>
	
	<cfif ShippingTotal NEQ ''>
	<tr>
		<td align="right" colspan="6">Shipping:</td>
		<td align="right">#LSCurrencyFormat(ShippingTotal)#</td>
	</tr>
	<cfset runningtotal = runningtotal + ShippingTotal>
	</cfif>
	
	<cfif TaxTotal NEQ ''>
	<tr>
		<td align="right" colspan="6">Tax:</td>
		<td align="right">#LSCurrencyFormat(TaxTotal)#</td>
	</tr>
	<cfset runningtotal = runningtotal + TaxTotal>
	</cfif>
	
	<cfif DiscountTotal NEQ ''>
	<tr>
		<td align="right" colspan="6">Discount:</td>
		<td align="right">- #LSCurrencyFormat(DiscountTotal)#</td>
	</tr>
	<cfset runningtotal = runningtotal - DiscountTotal>
	</cfif>
	
	<cfif CreditApplied NEQ '' AND CreditApplied NEQ 0>
	<tr>
		<td align="right" colspan="6">Credit Applied:</td>
		<td align="right">- #LSCurrencyFormat(CreditApplied)#</td>
	</tr>
	<cfset runningtotal = runningtotal - CreditApplied>
	</cfif>
	
	
	<tr class="grandTotal">
		<td colspan="5" height="20">&nbsp;</td>
		<td align="right" valign="middle">&nbsp; Total:</td>
		<td align="right" valign="middle">&nbsp; #LSCurrencyFormat(runningtotal, "local")#</td>
	</tr>
</table>

<table border="0" cellpadding="7" cellspacing="0" width="100%">
	<tr>
		<td colspan="2" height="20"></td>
	</tr>
	<tr valign="top">
		<td width="10%">Customer Comments:</td>
		<td width="90%"><cfif CustomerComments NEQ ''>#CustomerComments#<cfelse>None</cfif></td>
	</tr>	
	<tr valign="top">
		<td width="10">Store Comments:</td>
		<td width="90%"><textarea name="Comments" rows="12" cols="110" class="cfDefault">#OrderComments#</textarea></td>
	</tr>
</table>
</body>
</html>

</cfmail>

