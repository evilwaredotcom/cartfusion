<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<html>
<head>
<title>Invoice Order # <cfoutput>#OrderID#</cfoutput></title>

<cfinclude template="css.cfm">

<style type="text/css">
	td
	{ font-family: Verdana, Arial, Sans-Serif; font-size: 11px; font-weight: normal;
	  text-decoration: none; color: 000000; }
</style>

</head>

<cflock timeout="20">
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

<body onLoad="window.print()">

<cfoutput>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td width="33%">
			<b>#UCase(application.storename)# INVOICE</b><br>
			Order ## #OrderID#<br>
			Customer ID: #getOrder.CustomerID#<br>
			Customer Name: #getOrder.FirstName# #getOrder.LastName#<br>
			Customer Email: #getOrder.Email#<br>
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
		<td width="33%" align="right">
			<img src="../images/image-CompanyLogo.gif" border="0">
		</td>
	</tr>
</table>
</cfoutput>

<br>

<cfoutput query="getOrder">

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
	<tr class="cfAdminHeader4" style="background-color:##65ADF1;">
		<td width="33%" colspan="2" height="20" class="cfAdminHeader4">&nbsp; BILLING INFORMATION</td>
		<td rowspan="12" width="1%" style="background-color=FFFFFF;">&nbsp;</td>
		<td width="32%" colspan="2" class="cfAdminHeader4">&nbsp; SHIPPING INFORMATION</td>
		<td rowspan="12" width="1%" style="background-color=FFFFFF;">&nbsp;</td>
		<td width="33%" colspan="2" class="cfAdminHeader4">&nbsp; PAYMENT INFORMATION</td>
	</tr>
	<tr>
		<td colspan="6" height="5">&nbsp;</td>
	</tr>
	<tr>
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
	<tr>
		<td>Last Name:</td>
		<td>#LastName#</td>
		<td>Last Name:</td>
		<td>#OShipLastName#</td>
		<td colspan="2"></td>
	</tr>
	<tr>
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
	  	<td>XXXXXXXX#Right(decrypted_CCNum,4)#</td>
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
		<td colspan="2"></td>
	</tr>
	<tr>	
		<td>Zip/Postal:</td>
		<td>#Zip#</td>
		<td>Zip/Postal:</td>
		<td>#OShipZip#</td>
		<td>Shipping Method:</td>
		<td>#getShippingMethod.ShippingMessage#</td>
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
		<td colspan="2"></td>
	</tr>
</table>	
</cfoutput>

<br>
<hr color="##CCCCCC" width="100%">
<!--- ORDERED ITEMS ----------------------------------------------------------------->

<div align="left" class="cfAdminHeader4">ORDER ITEMS</div><br>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr style="background-color:##CCCCCC;">
		<td height="1" colspan="7"></td>
	</tr>
	<tr style="background-color:##65ADF1;">
		<td width="10%" class="cfAdminHeader4" height="20">&nbsp;SKU</td>
		<td width="30%" class="cfAdminHeader4">Item Name/Description</td>
		<td width="5%"  class="cfAdminHeader4">Qty</td>
		<td width="15%" class="cfAdminHeader4">Unit Price</td>
		<td width="15%" class="cfAdminHeader4">Item Status</td>
		<td width="10%" class="cfAdminHeader4">Action Date</td>
		<td width="10%" class="cfAdminHeader4" align="right">Price&nbsp;</td>
	</tr>
	<tr style="background-color:##CCCCCC;">
		<td height="1" colspan="7"></td>
	</tr>

<cfset runningtotal = 0>
	
<cfoutput query="getOrderItems">
	<cfif SKU NEQ 'SHIPPING' AND SKU NEQ 'TAX' AND SKU NEQ 'DISCOUNT'>
	<tr>
		<td>#SKU#</td>
		<td>#ItemName#
			<cfif OptionName1 NEQ ''><b>: #OptionName1#</b></cfif>
			<cfif OptionName2 NEQ ''><b>; #OptionName2#</b></cfif>
			<cfif OptionName3 NEQ ''><b>; #OptionName3#</b></cfif></td>
		<td>#Qty#</td>
		<td>#LSCurrencyFormat(ItemPrice)#</td>
			<cfinvoke component="#application.Queries#" method="getOrderItemsStatusCode" returnvariable="getOrderItemsStatusCode">
				<cfinvokeargument name="StatusCode" value="#StatusCode#">
			</cfinvoke>
			<cfscript>
				if ( StatusCode IS 'BO' OR StatusCode IS 'CA' OR StatusCode IS 'RE' )
					DisplayPrice = 0 ;
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
	</cfif>
</cfoutput>



<!--- TOTALS ---------------------------------------------------------------------->
<cfoutput query="getOrder">
	<tr>
		<td align="right" colspan="6" height="20">SubTotal:</td>
		<td align="right">#LSCurrencyFormat(runningtotal, "local")#</td>
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
	
	<tr>
		<td colspan="7" height="5"></td>
	</tr>
	<tr style="background-color:##CCCCCC;">
		<td height="1" colspan="7"></td>
	</tr>	
	<tr style="background-color:##65ADF1;">
		<td colspan="5" height="20" class="cfAdminHeader4">&nbsp;</td>
		<td align="right" class="cfAdminHeader4">Total:</td>
		<td align="right" class="cfAdminHeader4">#LSCurrencyFormat(runningtotal, "local")#</td>
	</tr>
	<tr style="background-color:##CCCCCC;">
		<td height="1" colspan="7"></td>
	</tr>
</table>

<table border="0" cellpadding="7" cellspacing="0" width="100%">
	<tr>
		<td colspan="2" height="20"></td>
	</tr>
	<tr class="cfAdminDefault" valign="top">
		<td width="10%">Customer Comments:</td>
		<td width="90%"><cfif CustomerComments NEQ ''>#CustomerComments#<cfelse>None</cfif></td>
	</tr>	
	<tr class="cfAdminDefault" valign="top">
		<td width="10">Store Comments:</td>
		<td width="90%"><textarea name="Comments" rows="12" cols="110" class="cfAdminDefault">#OrderComments#</textarea></td>
	</tr>
</table>
</cfoutput>

</body>
</html>