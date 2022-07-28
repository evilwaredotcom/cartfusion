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

<cfmail query="getOrder" group="OrderID" from="#config.EmailSales#" to="#session.CustomerArray[11]#" bcc="#config.NotifyEmail#"
	subject="#config.StoreNameShort# Order ###OrderID# Received" type="HTML">

<html>
<head>

<cfinclude template="../css.cfm">
<style type="text/css">
	TD, DIV, TEXTAREA
	{ color:##000000; }
</style>

</head>

<body>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td width="33%">
			<b>#UCase(config.storename)# INVOICE</b><br>
			Order ## #OrderID#<br>
			Customer ID: #getOrder.CustomerID#<br>
			Order Date: #DateFormat(getOrder.OrderDate, "d-mmm-yyyy")#
		</td>
		<td width="33%">
			#config.CompanyName#<br>
			#config.CompanyAddress1#<br>
			<cfif #config.CompanyAddress2# NEQ ''>
			#config.CompanyAddress2#<br>
			</cfif>
			#config.CompanyCity#, #config.CompanyState# #config.CompanyZIP#
		</td>
		<td width="33%" align="right"></td>
	</tr>
</table>

<br>
<cfscript>
	if ( getOrder.CCNum NEQ '') Decrypted_CCNum = DECRYPT(getOrder.CCNum, config.CryptKey, "CFMX_COMPAT", "Hex") ;
	else Decrypted_CCNum = '';
	if ( getOrder.CCExpDate NEQ '') Decrypted_CCExpDate = DECRYPT(getOrder.CCExpDate, config.CryptKey, "CFMX_COMPAT", "Hex") ;
	else Decrypted_CCExpDate = '';
</cfscript>

<cfinvoke component="#application.Queries#" method="getPaymentType" returnvariable="getPaymentType">
	<cfinvokeargument name="Type" value="#getOrder.CCName#">
</cfinvoke>

<cfinvoke component="#application.Queries#" method="getShippingMethod" returnvariable="getShippingMethod">
	<cfinvokeargument name="ShippingCode" value="#getOrder.ShippingMethod#">
</cfinvoke>
			
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr bgcolor="<cfoutput>#layout.TableHeadingBGColor#</cfoutput>">
		<td width="33%" colspan="2" height="20" class="cfTableHeading">&nbsp; BILLING INFORMATION</td>
		<td rowspan="11" width="1%" bgcolor="FFFFFF">&nbsp;</td>
		<td width="32%" colspan="2" class="cfTableHeading">&nbsp; SHIPPING INFORMATION</td>
		<td rowspan="11" width="1%" bgcolor="FFFFFF">&nbsp;</td>
		<td width="33%" colspan="2" class="cfTableHeading">&nbsp; PAYMENT INFORMATION</td>
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
</table>	


<br>
<hr color="CCCCCC" width="100%">
<!--- ORDERED ITEMS ----------------------------------------------------------------->

<div align="left" class="cfTableHeading">ORDER ITEMS</div><br>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr bgcolor="CCCCCC">
		<td height="1" colspan="7"></td>
	</tr>
	<tr bgcolor="<cfoutput>#layout.TableHeadingBGColor#</cfoutput>">
		<td width="1%" height="20" class="cfTableHeading"></td>
		<td width="39%" class="cfTableHeading">Item Name/Description</td>
		<td width="5%"  class="cfTableHeading" align="center">Qty</td>
		<td width="15%" class="cfTableHeading">Unit Price</td>
		<td width="15%" class="cfTableHeading">Item Status</td>
		<td width="10%" class="cfTableHeading">Action Date</td>
		<td width="10%" align="right" class="cfTableHeading">Price</td>
	</tr>
	<tr bgcolor="CCCCCC">
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
	
		<cfinvoke component="#application.Queries#" method="getOrderItemsStatusCode" returnvariable="getOrderItemsStatusCode">
			<cfinvokeargument name="StatusCode" value="#StatusCode#">
		</cfinvoke>
		<cfscript>
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
	<tr bgcolor="CCCCCC">
		<td height="1" colspan="7"></td>
	</tr>	
	<tr bgcolor="<cfoutput>#layout.TableHeadingBGColor#</cfoutput>">
		<td colspan="5" height="20">&nbsp;</td>
		<td align="right" valign="middle" class="cfTableHeading">&nbsp; Total:</td>
		<td align="right" valign="middle" class="cfTableHeading">&nbsp; #LSCurrencyFormat(runningtotal, "local")#</td>
	</tr>
	<tr bgcolor="CCCCCC">
		<td height="1" colspan="7"></td>
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

