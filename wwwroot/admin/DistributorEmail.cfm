<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<cfinvoke component="#application.Queries#" method="getDistributor" returnvariable="getDistributor">
	<cfinvokeargument name="DistributorID" value="#DistributorID#">
</cfinvoke>
<cfinvoke component="#application.Queries#" method="getOrdersDistSend" returnvariable="getOrdersDistSend">
	<cfinvokeargument name="DistributorID" value="#DistributorID#">
</cfinvoke>

<cfmail from="#application.EmailSales#" to="#EmailToDistributor#" bcc="#application.NotifyEmail#" 
	SUBJECT="#application.StoreNameShort# Orders for #DateFormat(Now(), 'd-mmm-yyyy')#" TYPE="HTML">

<html>
<head>

<cfinclude template="css.cfm">

<cfif NOT isDefined('EmailToDistributor') OR EmailToDistributor EQ ''>
	<div class="cfAdminError">ERROR: No Email Address Specified</div>
	<cfabort>
</cfif>

</head>

<body>

<table border="0" cellpadding="3" cellspacing="0" width="100%">
	<tr>
		<td width="40%" valign="top" class="cfAdminDefault">
			CLIENT: #application.StoreNameShort#<br>
			#application.CompanyAddress1#<br>
			<cfif #application.CompanyAddress2# NEQ ''>
			#application.CompanyAddress2#<br>
			</cfif>
			#application.CompanyCity#, #application.CompanyState# #application.CompanyZIP#<br>
			Phone: #application.CompanyPhone#<br>
			Tax ID: #application.TaxID#
		</td>
		<td width="40%" valign="top" class="cfAdminDefault">
			DISTRIBUTOR: #getDistributor.DistributorName#<br>
			REP NAME: #getDistributor.RepName#<br>
			PHONE: #getDistributor.Phone#<br>
			FAX: #getDistributor.Fax#<br>
			EMAIL: #getDistributor.Email#
		</td>
		<td width="20%" valign="top" class="cfAdminDefault">
			PRODUCTS ORDERED: #getOrdersDistSend.RecordCount#<br>
			DATE: #DateFormat(Now(), "d-mmm-yyyy")#
		</td>
	</tr>
</table>

<br>

<cfset ThisOrderID = 0 >
<cfloop QUERY="getOrdersDistSend">

	<cfinvoke component="#application.Queries#" method="getOrderInfo" returnvariable="getOrderInfo">
		<cfinvokeargument name="OrderID" value="#OrderID#">
	</cfinvoke>
	
<cfif OrderID NEQ ThisOrderID >
<cfloop query="getOrderInfo">
	<cfinvoke component="#application.Queries#" method="getShippingMethod" returnvariable="getShippingMethod">
		<cfinvokeargument name="ShippingCode" value="#getOrderInfo.ShippingMethod#">
	</cfinvoke>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td height="20" class="cfAdminTitle"><font size="+1">ORDER #getOrderInfo.OrderID#</font></td>
	</tr>
	<tr style="background-color:##CCCCCC;"><td height="1" colspan="8"></td></tr>
	<tr><td height="1" colspan="8"></td></tr>
	<tr style="background-color:##CCCCCC;"><td height="1" colspan="8"></td></tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td width="49%" colspan="2" height="20"><b>SHIPPING INFORMATION</b></td>
		<td rowspan="12" width="1%">&nbsp;</td>
		<td width="50%" colspan="2"><b>ORDER INFORMATION</b></td>
	</tr>
	<tr>
		<td colspan="6" height="5">&nbsp;</td>
	</tr>
	<tr>
		<td width="25%">First Name:</td>
		<td width="25%">#getOrderInfo.OShipFirstName#</td>
		<td width="25%">Order ID:</td>
		<td width="25%">#getOrderInfo.OrderID#</td>
	</tr>
	<tr>
		<td>Last Name:</td>
		<td>#getOrderInfo.OShipLastName#</td>
		<td>Order Date:</td>
		<td>#DateFormat(getOrderInfo.DateEntered, 'd-mmm-yyyy')#</td>
	</tr>
	<tr>
		<td>Company Name:</td>
		<td>#getOrderInfo.OShipCompanyName#</td>
		<td></td>
		<td></td>
	</tr>
	<tr>
		<td>Address 1:</td>
		<td>#getOrderInfo.OShipAddress1#</td>
		<td>Shipping Method:</td>
		<td>#getShippingMethod.ShippingMessage#</td>
	</tr>
	<tr>
		<td>Address 2:</td>
		<td>#getOrderInfo.oShipAddress2#</td>
		<td></td>
		<td></td>
	</tr>
	<tr>	
		<td>City:</td>
		<td>#getOrderInfo.OShipCity#</td>
		<td></td>
		<td></td>
	</tr>
	<tr>	
		<td>State:</td>
		<td>#getOrderInfo.OShipState#</td>
		<td></td>
		<td></td>
	</tr>
	<tr>	
		<td>Zip/Postal:</td>
		<td>#getOrderInfo.OShipZip#</td>
		<td></td>
		<td></td>
	</tr>
	<tr>	
		<td>Country:</td>
		<td>#getOrderInfo.OShipCountry#</td>
		<td></td>
		<td></td>
	</tr>
	<tr>	
		<td>Phone:</td>
		<td>#getOrderInfo.OrderPhone#</td>
		<td></td>
		<td></td>
	</tr>
</table>
<br>
<hr color="##CCCCCC" width="100%">

<!--- ITEMS --->
	
<cfquery name="getItems" dbtype="query">
	SELECT	ItemID, SKU, ItemName, Qty, OptionName1, OptionName2, OptionName3
	FROM	getOrdersDistSend
	WHERE	OrderID = #getOrderInfo.OrderID#
	ORDER BY	SKU
</cfquery>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td width="10%" height="20" align="center"><b>Quantity</b></td>
		<td width="10%" height="20"><b>SKU</b></td>
		<td width="50%" height="20"><b>Item Name/Description</b></td>
	</tr>
	<cfloop QUERY="getItems">	
	<tr>
		<td height="20" align="center">#getItems.Qty#</td>
		<td>#getItems.SKU#</td>
		<td>#getItems.ItemName#
			<cfif getItems.OptionName1 NEQ ''><b>: #getItems.OptionName1#</b></cfif>
			<cfif getItems.OptionName2 NEQ ''><b>; #getItems.OptionName2#</b></cfif>
			<cfif getItems.OptionName3 NEQ ''><b>; #getItems.OptionName3#</b></cfif>
		</td>
	</tr>
	<tr>
		<td colspan="7" height="1" style="background-color:##CCCCCC;"></td>
	</tr>
	</cfloop>
</table>
<br>
<hr color="##CCCCCC" width="100%">	
</cfloop>
<cfset ThisOrderID = getOrderInfo.OrderID >
</cfif><!--- OrderID NEQ OrderID --->
</cfloop>

</body>
</html>

</cfmail>

<cfoutput query="getOrdersDistSend">
	<cfquery name="updateStatus" datasource="#application.dsn#">
		UPDATE	OrderItems
		SET		StatusCode = 'PR'
		WHERE	OrderItemsID = #getOrdersDistSend.OrderItemsID#
	</cfquery>
</cfoutput>
<cflocation url="DistributorDetail.cfm?DistributorID=#DistributorID#" addtoken="no">
