<!--- 
|| MIT LICENSE
|| CartFusion.com
--->
<cfoutput>

<html>
<head>
<title>Invoice Order ###OrderID#</title>
<!--- <CFINCLUDE Template="css.cfm"> --->
<link rel="stylesheet" type="text/css" href="templates/#application.SiteTemplate#/screen_layout.css">
<link rel="stylesheet" type="text/css" href="templates/#application.SiteTemplate#/screen_formatting.css">
<link rel="stylesheet" type="text/css" href="templates/#application.SiteTemplate#/screen_design.css">

</head>

<cflock timeout="20">
	<cfscript>
		getOrder = application.Queries.getOrder(OrderID=OrderID);
		getOrderItems = application.Queries.getOrderItems(OrderID=OrderID);
		getBackOrders = application.Queries.getBackOrders(OrderID=OrderID);
	</cfscript>
	
</cflock>

<body style="margin:20px;" onLoad="window.print()">

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td width="33%">
			<b>SEND ORDER FORM TO:</b><br>
			#application.CompanyName#<br>
			#application.CompanyAddress1#<br>
			<cfif #application.CompanyAddress2# NEQ ''>
			#application.CompanyAddress2#<br>
			</cfif>
			#application.CompanyCity#, #application.CompanyState# #application.CompanyZIP#
		</td>
		<td width="33%">
			<font class="cfAdminHeader2"><b>#UCase(application.storename)# ORDER FORM</b></font><br>
			Order ## #OrderID#<br>
			Customer ID: #getOrder.CustomerID#<br>
			Order Date: #DateFormat(getOrder.OrderDate, "d-mmm-yyyy")#
		</td>
		<td width="33%" align="right">
			<img src="images/image-CompanyLogo.gif" border="0">
		</td>
	</tr>
</table>
</cfoutput>

<cfoutput query="getOrder">

<br>
<hr color="##CCCCCC" width="100%">

	<cfscript>
		if ( getOrder.CCNum NEQ '' ) 
			Decrypted_CCNum = DECRYPT(getOrder.CCNum, application.CryptKey, "CFMX_COMPAT", "Hex") ;
		else 
			Decrypted_CCNum = '' ;
		if ( getOrder.CCExpDate NEQ '' ) 
			Decrypted_CCExpDate = DECRYPT(getOrder.CCExpDate, application.CryptKey, "CFMX_COMPAT", "Hex") ;
		else 
			Decrypted_CCExpDate = '' ;
	</cfscript>
	
	<cfinvoke component="#application.Queries#" method="getPaymentType" returnvariable="getPaymentType">
		<cfinvokeargument name="Type" value="#getOrder.CCName#">
	</cfinvoke>
			
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr class="cfAdminHeader2" bgcolor="##CCCCCC">
		<td width="33%" colspan="2" height="20" class="cfAdminHeader2">&nbsp; <b>BILLING INFORMATION</b></td>
		<td rowspan="12" width="1%" bgcolor="##FFFFFF">&nbsp;</td>
		<td width="32%" colspan="2" class="cfAdminHeader2">&nbsp; <b>SHIPPING INFORMATION</b></td>
	</tr>
	<tr>
		<td colspan="4" height="5">&nbsp;</td>
	</tr>
	<tr>
		<td width="20%">First Name:</td>
		<td width="30%">#FirstName#</td>
		<td width="20%">First Name:</td>
		<td width="30%">#OShipFirstName#</td>
	</tr>
	<tr>
		<td>Last Name:</td>
		<td>#LastName#</td>
		<td>Last Name:</td>
		<td>#OShipLastName#</td>
	</tr>
	<tr>
		<td>Company:</td>
		<td>#CompanyName#</td>
		<td>Company:</td>
		<td>#OShipCompanyName#</td>
	</tr>
	<tr>
		<td>Address 1:</td>
		<td>#Address1#</td>
		<td>Address 1:</td>
		<td>#OShipAddress1#</td>
	</tr>
	<tr>
		<td>Address 2:</td>
		<td>#Address2#</td>
		<td>Address 2:</td>
		<td>#OShipAddress2#</td>
	</tr>
	<tr>	
		<td>City:</td>
		<td>#City#</td>
		<td>City:</td>
		<td>#OShipCity#</td>
	</tr>
	<tr>	
		<td>State:</td>
		<td>#State#</td>
		<td>State:</td>
		<td>#OShipState#</td>
	</tr>
	<tr>	
		<td>Zip/Postal:</td>
		<td>#Zip#</td>
		<td>Zip/Postal:</td>
		<td>#OShipZip#</td>
	</tr>
	<tr>	
		<td>Country:</td>
		<td>#Country#</td>
		<td>Country:</td>
		<td>#OShipCountry#</td>
	</tr>
	<tr>	
		<td>Phone:</td>
		<td>#OrderPhone#</td>
		<td>Phone:</td>
		<td>#CustomerPhone#</td>
	</tr>
</table>	
</cfoutput>

<cfoutput>
<br>
<hr color="##CCCCCC" width="100%">
<!--- ORDERED ITEMS ----------------------------------------------------------------->

<div align="left" class="cfAdminHeader2" width="100%"><b>ORDER ITEMS</b></div><br>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr bgcolor="##CCCCCC">
		<td height="1" colspan="7"></td>
	</tr>
	<tr bgcolor="##CCCCCC">
		<td width="10%" class="cfAdminHeader2" height="20">&nbsp;SKU</td>
		<td width="30%" class="cfAdminHeader2">Item Name/Description</td>
		<td width="5%"  class="cfAdminHeader2">Qty</td>
		<td width="15%" class="cfAdminHeader2">Unit Price</td>
		<td width="15%" class="cfAdminHeader2">Item Status</td>
		<td width="10%" class="cfAdminHeader2">Action Date</td>
		<td width="10%" class="cfAdminHeader2" align="right">Price&nbsp;</td>
	</tr>
	<tr bgcolor="##CCCCCC">
		<td height="1" colspan="7"></td>
	</tr>
</cfoutput>

<cfset runningtotal = 0>
	
<cfoutput query="getOrderItems">
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
				if ( StatusCode IS 'BO' OR StatusCode IS 'CA' ) {
					DisplayPrice = 0;
				} else {
					DisplayPrice = Val(ItemPrice * Qty);
					runningtotal = runningtotal + Val(ItemPrice * Qty);
				}
			</cfscript>
		<td>#getOrderItemsStatusCode.StatusMessage#</td>
		<td>#DateFormat(OrderItemDate, "mm/dd/yy")#</td>
		<td align="right">#LSCurrencyFormat(DisplayPrice, "local")#</td>
	</tr>
</cfoutput>



<!--- TOTALS ---------------------------------------------------------------------->
<cfoutput query="getOrder">
	<tr>
		<td align="right" colspan="6" height="20">SubTotal:</td>
		<td align="right">#LSCurrencyFormat(runningtotal, "local")#</td>
	</tr>
	<cfset runningtotal = runningtotal>
	
	<cfif ShippingTotal NEQ ''>
		<cfinvoke component="#application.Queries#" method="getShippingMethod" returnvariable="getShippingMethod">
			<cfinvokeargument name="ShippingCode" value="#ShippingMethod#">
		</cfinvoke>
	<tr>
		<td align="right" colspan="6">#getShippingMethod.ShippingMessage# Shipping:</td>
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
		<td align="right">#LSCurrencyFormat(DiscountTotal)#</td>
	</tr>
	<cfset runningtotal = runningtotal - DiscountTotal>
	</cfif>
	
	<cfif CreditApplied NEQ '' AND CreditApplied NEQ 0>
	<tr>
		<td align="right" colspan="6">Credit Applied:</td>
		<td align="right">#LSCurrencyFormat(CreditApplied)#</td>
	</tr>
	<cfset runningtotal = runningtotal - CreditApplied>
	</cfif>
	
	<tr>
		<td colspan="7" height="5"></td>
	</tr>
	<tr bgcolor="##CCCCCC">
		<td height="1" colspan="7"></td>
	</tr>	
	<tr bgcolor="##CCCCCC">
		<td colspan="5" height="20">&nbsp;</td>
		<td align="right" valign="middle" class="cfAdminHeader2"><b>Total:</b></td>
		<td align="right" valign="middle" class="cfAdminHeader2"><b>#LSCurrencyFormat(runningtotal, "local")#</b></td>
	</tr>
	<tr bgcolor="##CCCCCC">
		<td height="1" colspan="7"></td>
	</tr>
</table>

<table border="0" cellpadding="7" cellspacing="0" width="100%">
	<tr>
		<td colspan="2" height="20"></td>
	</tr>
	<tr class="cfAdminDefault" valign="top">
		<td width="10%"><b>Customer Comments:</b></td>
		<td width="90%"><cfif CustomerComments NEQ ''>#CustomerComments#<cfelse>None</cfif></td>
	</tr>	
</table>
</cfoutput>

</body>
</html>