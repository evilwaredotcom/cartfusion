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

<cfparam name="SetToProcessing" default="0">

<cfif SetToProcessing EQ 1 >
	<cfoutput query="getOrdersDistSend">
		<cfquery name="updateStatus" datasource="#application.dsn#">
			UPDATE	OrderItems
			SET		StatusCode = 'PR'
			WHERE	OrderItemsID = #getOrdersDistSend.OrderItemsID#
		</cfquery>
	</cfoutput>
	<cflocation url="DistributorDetail.cfm?DistributorID=#DistributorID#" addtoken="no">
</cfif>

<html>
<head>
<title>Send Orders to Distributor: <cfoutput>#getDistributor.DistributorName#</cfoutput></title>
<cfinclude template="css.cfm">
</head>

<body <cfif SetToProcessing NEQ 1 AND getOrdersDistSend.RecordCount NEQ 0 >onLoad="return confirm('IMPORTANT\nYou must click the &quot;Email Distributor&quot; OR &quot;Print &amp; Fax Distributor&quot;\nbutton for the system to update the order statuses.')" </cfif> >

<cfif getOrdersDistSend.RecordCount EQ 0 >
	<div align="center" class="cfAdminError">
		<br><br><b>There are no orders to send to this distributor at this time.</b><br><br>
		<input type="button" name="GoBack" value="<< GO BACK" alt="Go back to Distributors page" class="cfAdminButton"
			onClick="document.location.href='Distributors.cfm'">
		<input type="button" name="ReturnHome" value="RETURN HOME >>" alt="Go to home page" class="cfAdminButton"
			onClick="document.location.href='Orders.cfm'">
	</div><br>
<cfelse>

<cfoutput>
<table border="0" cellpadding="3" cellspacing="0" width="100%">
	<tr>
		<td colspan="2"><img src="images/image-CompanyLogo.gif" vspace="3"></td>
	</tr>
	<tr>
		<td width="40%" valign="top" class="cfAdminDefault">
			#application.StoreNameShort#<br>
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
</cfoutput>

<br>

<cfoutput QUERY="getOrdersDistSend" group="OrderID">
	<cfinvoke component="#application.Queries#" method="getOrderInfo" returnvariable="getOrderInfo">
		<cfinvokeargument name="OrderID" value="#OrderID#">
	</cfinvoke>

<cfloop query="getOrderInfo">
	<cfinvoke component="#application.Queries#" method="getShippingMethod" returnvariable="getShippingMethod">
		<cfinvokeargument name="ShippingCode" value="#getOrderInfo.ShippingMethod#">
	</cfinvoke>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td height="20" class="cfAdminTitle"><font size="+1">ORDER #getOrderInfo.OrderID#</font></td>
	</tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr class="cfAdminHeader4" style="background-color:##65ADF1;">
		<td width="49%" colspan="2" height="20" class="cfAdminHeader4">SHIPPING INFORMATION</td>
		<td rowspan="12" width="1%" style="background-color:##FFFFFF;">&nbsp;</td>
		<td width="50%" colspan="2" class="cfAdminHeader4">ORDER INFORMATION</td>
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
	SELECT	OrderItemsID, ItemID, SKU, ItemName, Qty, OptionName1, OptionName2, OptionName3
	FROM	getOrdersDistSend
	WHERE	OrderID = #getOrderInfo.OrderID#
	ORDER BY	SKU
</cfquery>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr style="background-color:##F27028;">
		<!---<td width="10%" height="20" class="cfAdminHeader4" align="center">Sent/Exclude</td>--->
		<td width="10%" height="20" class="cfAdminHeader4" align="center">Quantity</td>
		<td width="10%" height="20" class="cfAdminHeader4">SKU</td>
		<td width="70%" height="20" class="cfAdminHeader4">Item Name/Description</td>
	</tr>
	<cfloop QUERY="getItems">	
	<tr>
		<!---
		<form name="SetSent" action="DistOrdersSend.cfm?DistributorID=#DistributorID#&Sent=1&OIID=#getItems.OrderItemsID#" method="post">
		<td height="20" align="center">
			<input type="submit" name="Sent" value=" " class="cfAdminDefault" onClick="return confirm('Are you sure you want to COMPLETELY REMOVE this item from the list being sent to the distributor?');" >
		</td>
		</form>
		--->
		<td height="20" align="center">#getItems.Qty#</td>
		<td>#getItems.SKU#</td>
		<td>#getItems.ItemName# 
			<cfif getItems.OptionName1 NEQ ''>: #getItems.OptionName1#</cfif>
			<cfif getItems.OptionName2 NEQ ''>, #getItems.OptionName2#</cfif>
			<cfif getItems.OptionName3 NEQ ''>, #getItems.OptionName3#</cfif>
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
</cfoutput>

<!--- OPTIONS --->

<cfoutput query="getDistributor">
<cfform action="DistributorEmail.cfm?DistributorID=#DistributorID#" method="post">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<script language="JavaScript">
			function confirmPrint(FID,FValue,FColumn,FTable)
			{ if (confirm('Did these orders print properly?\nIf yes, their statuses will now be set to \'Processing\'.'))
			  document.location.href='DistOrdersSend.cfm?DistributorID=#DistributorID#&SetToProcessing=1'; }
		</script>
		<td align="center">
			Email: <cfinput type="text" name="EmailToDistributor" value="#Email#" size="35" class="cfAdminDefault" 
				required="yes" message="Distributor's Email is Required">
			<input type="submit" name="DistributorEmail" value="<< EMAIL TO DISTRIBUTOR" alt="Email distributor these orders" class="cfAdminButton"
				onClick="return confirm('These orders will now be emailed to the distributor \'#DistributorName#\' \nand their statuses will be set to \'Processing\'. ')" >
			<input type="button" name="DistributorPrint" value="PRINT &amp; FAX DISTRIBUTOR" alt="Print &amp; fax distributor these orders" class="cfAdminButton"
				onClick="window.print(); confirmPrint();" >
			<input type="button" name="DistributorPrintOnly" value="PRINT ONLY (NO PROCESS)" alt="Print these orders without processing them" class="cfAdminButton"
				onClick="window.print();" ><br><br>
			<font class="cfAdminError"><b>IMPORTANT:</b></font> 
			
			You must click the "Email Distributor" OR "Print &amp; Fax Distributor" button for the system to update the order statuses.<br><br>
			<input type="button" name="GoBack" value="<< GO BACK" alt="Go back to Distributors page" class="cfAdminButton"
				onClick="document.location.href='Distributors.cfm'">
			<input type="button" name="ReturnHome" value="RETURN HOME >>" alt="Go to home page" class="cfAdminButton"
				onClick="document.location.href='Orders.cfm'">
		</td>
	</tr>
</table>
</cfform>
</cfoutput>

</cfif><!--- NO ORDERS TO SEND --->
<br><br><br>

</body>
</html>