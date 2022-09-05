<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<cfparam name="Form.ItemID" default="">
<cfparam name="OptionsRetrieved" default="0">

<!--- GET ALTERNATES --->
<cfif isDefined('form.checkAlternates') AND IsDefined("form.OrderID") AND Form.ItemID NEQ ''>
	<!-------------- BEGIN: ITEM OPTIONS --------------->
	<cfinvoke component="#application.Queries#" method="getProductOptions1" returnvariable="getProductOptions1">
		<cfinvokeargument name="ItemID" value="#ItemID#">
	</cfinvoke>
	<cfinvoke component="#application.Queries#" method="getProductOptions2" returnvariable="getProductOptions2">
		<cfinvokeargument name="ItemID" value="#ItemID#">
	</cfinvoke>
	<cfinvoke component="#application.Queries#" method="getProductOptions3" returnvariable="getProductOptions3">
		<cfinvokeargument name="ItemID" value="#ItemID#">
	</cfinvoke>
	<!-------------- END: ITEM OPTIONS --------------->
	<cfscript>
		if ( getProductOptions1.RecordCount NEQ 0 AND getProductOptions2.RecordCount NEQ 0 AND getProductOptions3.RecordCount NEQ 0 )
			OptionsRetrieved = 1;
	</cfscript>
</cfif>

<!--- ADD NEW ORDER ITEM --->
<cfif isDefined('form.AddOrderItem') AND IsDefined("form.OrderID") AND Form.ItemID NEQ '' AND isDefined('form.Qty')>	
	<cfinsert datasource="#application.dsn#" tablename="OrderItems" 
		formfields="OrderID, ItemID, OptionName1, OptionName2, OptionName3, Qty, ItemPrice, StatusCode" >
	<cfset AdminMsg = 'SUCCESS: New Item Added to Order <cfoutput>#OrderID#</cfoutput>' >
	<cfset Form.ItemID = '' >
</cfif>


<!--- BEGIN: QUERIES --->
<cfinvoke component="#application.Queries#" method="getSKUs" returnvariable="getSKUs"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getOrderItemsStatusCodes" returnvariable="getOrderItemsStatusCodes"></cfinvoke>
<!--- END: QUERIES --->


<!------------------------------------------------------------- ADD ORDER ITEM ---------------------------------------------------------------->

<html>
<head>
	<title>ADD ITEMS TO ORDER <cfoutput>#OrderID#</cfoutput></title>
	<cfinclude template="css.cfm">
</head>
<body bgcolor="#FFFFFF" onLoad="window.focus()">

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td class="cfAdminTitle">
			<cfoutput>
			ADD ITEMS TO ORDER #OrderID#
			<cfif isDefined('AdminMsg')>&nbsp; <img src="images/image-Message.gif"> <font class="cfAdminError">#AdminMsg#</font></cfif>
			</cfoutput>
		</td>
	</tr>
	<tr style="background-color:##CCCCCC;"><td height="1" colspan="7"></td></tr>
	<tr><td height="1" colspan="7"></td></tr>
	<tr style="background-color:##CCCCCC;"><td height="1" colspan="7"></td></tr>
	<tr><td height="15" colspan="7"></td></tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr><td colspan="7" height="20" class="cfAdminLink"><b>STEP 1: Select an item to add, then press CONTINUE</b></td></tr>

	<cfform action="OrderItemAdd.cfm" method="post" preservedata="true">
	<tr>
		<td nowrap>
			<cfif Form.ItemID EQ ''>
				<img src="images/spacer.gif" width="7" height="1" align="absmiddle">
				SKU: <cfselect query="getSKUs" name="ItemID" value="ItemID" display="SKUItemName" size="1" class="cfAdminDefault" />
				<input type="submit" name="checkAlternates" value="CONTINUE" alt="Continue to add this item to order #OrderID#" class="cfAdminButton">
			<cfelse>
				<img src="images/spacer.gif" width="7" height="1" align="absmiddle">
				SKU: <cfselect query="getSKUs" name="ItemID" value="ItemID" display="SKUItemName" size="1" class="cfAdminDefault" selected="#form.ItemID#" />
				<input type="submit" name="checkAlternates" value="CONTINUE" alt="Continue to add this item to order #OrderID#" class="cfAdminButton">
				<cfquery name="getPriceToUse" datasource="#application.dsn#">
					SELECT 	PriceToUse AS ThisPrice
					FROM 	Customers 
					WHERE 	CustomerID = '#CustomerID#' 
				</cfquery>
				<cfquery name="getProductInfo" datasource="#application.dsn#">
					SELECT 	ItemName, Price#getPriceToUse.ThisPrice# AS UseThisPrice
					FROM	Products
					WHERE	ItemID = #form.ItemID#	
				</cfquery>
			</cfif>	
		</td>
	</tr>
	<cfif Form.ItemID NEQ ''>
		<tr><td height="20" colspan="7">&nbsp;</td></tr>

		<tr><td colspan="7" class="cfAdminLink" height="20">STEP 2: Select item options, then click ADD</td></tr>
		<tr style="background-color:##65ADF1;">
			<td width="30%" class="cfAdminHeader1" height="20">Item Name/Description</td>
			<td width="30%" class="cfAdminHeader1">Product Options</td>
			<td width="7%"  class="cfAdminHeader1">Qty</td>
			<td width="12%" class="cfAdminHeader1">Unit Price</td>
			<td width="10%" class="cfAdminHeader1">Item Status</td>
			<td width="10%" class="cfAdminHeader1" align="center" colspan="2"></td>
		</tr>
		<cfoutput query="getProductInfo">
		<tr>
			<td>#getProductInfo.ItemName#</td>
			<td>
				<cfif isDefined('getProductOptions1') AND getProductOptions1.RecordCount NEQ 0 >			
					<cfselect name="OptionName1" query="getProductOptions1" size="1" class="cfAdminDefault" value="OptionName" />
				</cfif>
				<cfif isDefined('getProductOptions2') AND getProductOptions2.RecordCount NEQ 0 >
					<cfselect name="OptionName2" query="getProductOptions2" size="1" class="cfAdminDefault" value="OptionName" />
				</cfif>
				<cfif isDefined('getProductOptions3') AND getProductOptions3.RecordCount NEQ 0 >
					<cfselect name="OptionName3" query="getProductOptions3" size="1" class="cfAdminDefault" value="OptionName" />
				</cfif>
			</td>
			<td><cfinput type="text" name="Qty" size="1" class="cfAdminDefault" value="1"></td>		
			<td><input type="text" name="ItemPrice" value="#DecimalFormat(UseThisPrice)#" size="7" class="cfAdminDefault"></td>
			<td><cfselect query="getOrderItemsStatusCodes" selected="OD" name="StatusCode" value="StatusCode" display="StatusMessage"
					class="cfAdminDefault" /></td>
			<td></td>
			<td align="center">
				<input type="submit" name="AddOrderItem" value="ADD" alt="Add this item to order #OrderID#" class="cfAdminButton">
			</td>
		</tr>
		</cfoutput>
	</cfif>		
	<input type="hidden" name="OrderID" value="<cfoutput>#OrderID#</cfoutput>">
	<input type="hidden" name="CustomerID" value="<cfoutput>#CustomerID#</cfoutput>">
	</cfform>
	
	<!---
	<tr>
		<td colspan="7" class="cfAdminError" height="25"><b><cfoutput>#continueMessage#</cfoutput></b></td>
	</tr>
	--->
	<tr><td height="20" colspan="7">&nbsp;</td></tr>
	<tr style="background-color:##CCCCCC;"><td height="1" colspan="7"></td></tr>
	<tr><td height="1" colspan="7"></td></tr>
	<tr style="background-color:##CCCCCC;"><td height="1" colspan="7"></td></tr>
</table>
<br>

<div align="center">
	<form action="OrderDetail.cfm" target="main">
		<input type="submit" value="<< RETURN TO ORDER DETAIL" onClick="window.close();" class="cfAdminButton">
		<input type="hidden" name="RefreshPage" value="1">
		<input type="hidden" name="OrderID" value="<cfoutput>#OrderID#</cfoutput>">
		<input type="button" value="CANCEL ADDING ITEMS" onClick="window.close();" class="cfAdminButton">
	</form>
</div>

</body>
</html>
