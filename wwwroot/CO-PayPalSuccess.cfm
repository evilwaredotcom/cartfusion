<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<cfoutput>

<cfmodule template="templates/#application.SiteTemplate#/layout.cfm" CurrentTab="MyAccount" LayoutStyle="Full" PageTitle="Check Out - Step 4 of 4" showCategories="false">

<!--- Start Breadcrumb --->
<cfmodule template="tags/breadCrumbs.cfm" CrumbLevel='2' showLinkCrumb="Cart|Check Out - Step 4 of 4" />
<!--- End BreadCrumb --->

<!--- ONLY ALLOW ORDER UPDATE IF VARIABLES ARE PASSED --->
<cfif structKeyExists(url, 'OrderID') and structKeyExists(url, 'tx') AND structKeyExists(url, 'st') and structKeyExists(url, 'amt') >

	<cfquery name="getIDToken" datasource="#application.dsn#">
		SELECT	IDToken
		FROM	PGPayPal
		WHERE	PPID = 1
	</cfquery>
	
	<cfset authToken = getIDToken.IDToken >
	<cfset txToken = url.tx >
	<cfset query="cmd=_notify-synch&tx=" & txToken & "&at=" & authToken >
	
	<cfhttp url="https://www.paypal.com/cgi-bin/webscr?#query#" method="GET" resolveurl="false"></CFHTTP>
	
	<cfif getIDToken.RecordCount NEQ 0 AND getIDToken.IDToken NEQ '' AND left(#cfhttp.FileContent#,7) EQ 'SUCCESS' >
		<cfloop list="#cfhttp.fileContent#" index="curLine" delimiters="#chr(10)#">
			<cfif listGetAt(curLine,1,"=") IS "first_name">
				<cfset firstName=listGetAt(curLine,2,"=")>
			</cfif>
			<cfif listGetAt(curLine,1,"=") IS "last_name">
				<cfset lastName=listGetAt(curLine,2,"=")>
			</cfif>
			<cfif listGetAt(curLine,1,"=") IS "item_name">
				<cfset itemName=listGetAt(curLine,2,"=")>
			</cfif>
			<cfif listGetAt(curLine,1,"=") IS "mc_gross">
				<cfset mcGross=listGetAt(curLine,2,"=")>
			</cfif>
			<cfif listGetAt(curLine,1,"=") IS "mc_currency">
				<cfset mcCurrency=listGetAt(curLine,2,"=")>
			</cfif>
		</cfloop>
	
		<cfquery name="updateOrder" datasource="#application.dsn#">
			UPDATE	Orders
			SET		PaymentVerified = 1, BillingStatus = 'PA', TransactionID = '#URL.tx#'
			WHERE	OrderID = #URL.OrderID#
		</cfquery>

	
		<table width="98%" cellpadding="3" cellspacing="0" border="0">
			<tr> 
				<td width="100%" align="center" valign="top" class="cfDefault">
					<br>
					<p><h3>Your order has been received.</h3></p>
					<b>Thank You #firstName# #lastName#.<br><br>
					We will send your order as soon as we review and accept your PayPal payment request.</b>
				</td>
			</tr>
		</table>
		
	
		<!--- ORDER TRANSACTION COMPLETE - NOW EMAIL ORDER CONFIRMATION & CLEAN UP CART --->		
		<cfinclude template="EmailOrder.cfm">
		<cfinclude template="Includes/CartCleanPostOrder.cfm">
		
	<cfelse>
		
		<table width="98%" cellpadding="3" cellspacing="0" border="0">
			<tr> 
				<td width="100%" align="center" valign="top" class="cfDefault">
					<br>
					<p><h3>ERROR</h3></p>
					<b>Not enough information about your order has been provided.</b><br><br>
				</td>
			</tr>
		</table>
		
	</cfif>

<cfelse>
	<table width="98%" cellpadding="3" cellspacing="0" border="0">
		<tr> 
			<td width="100%" align="center" valign="top" class="cfDefault">
				<br>
				<p><h3>ERROR</h3></p>
				<b>Not enough information about your order has been provided.</b><br><br>
			</td>
		</tr>
	</table>
</cfif>

</cfmodule>
</cfoutput>
