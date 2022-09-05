

<cfif application.EmailInvoiceToCustomer EQ 1 >
	<cfinclude template="Includes/CO-EmailOrder.cfm">
<cfelse>
	<cfmail from="#application.EmailSales#" to="#session.CustomerArray[11]#" bcc="#application.NotifyEmail#" subject="#application.StoreNameShort# Order ###OrderID# Received" type="html">
	<table width="600" border=0>
		<tr>
			<td>
				Date: #DateFormat(Now(),"d-mmm-yyyy")#
				<br><br>
				Dear #session.CustomerArray[1]# #session.CustomerArray[2]#,
				<br><br>
				The order you have placed with #application.StoreNameShort#, 
				Order ###OrderID#, has been received by our sales department and is currently being fulfilled.  You may track the status of your order(s) by
				visiting our website at <a href="#application.RootURL#">#application.DomainName#</a> and logging in using your site username and password.
				<br><br>
				Thank you for shopping with #application.StoreNameShort#.  Please visit us soon at <a href="#application.RootURL#">#application.DomainName#</a>.
			</td>
		</tr>
	</table>
	</cfmail>
</cfif>

<cfset AutoEmailDist = 0 >
<cfif FormOfPayment EQ 1 AND AutoEmailDist EQ 1 >
	<cfquery name="getDistributors" datasource="#application.dsn#">	
		SELECT 	*
		FROM	Distributors
	</cfquery>
	<cfloop query="getDistributors">		
		
		<cfscript>
			getOrderDistSend = application.Queries.getOrderDistSend(DistributorID=DistributorID,OrderID=OrderID);
		</cfscript>
		
		
		<cfif getOrderDistSend.RecordCount>
			<cfmail from="#application.EmailSales#" to="#getDistributors.Email#" bcc="#application.NotifyEmail#" 
				subject="#application.StoreNameShort# Order #OrderID# for #DateFormat(NOW(),'d-mmm-yyyy')#" type="HTML">
			<html>
			<head></head>
			<body>
			<table width="700" border="1" cellpadding="7" cellspacing="0"><tr><td width="100%">
			<cfoutput>
			<table border="0" cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<td colspan="2"><img src="#application.RootURL#/images/image-CompanyLogo.gif" vspace="3"></td>
				</tr>
				<tr>
					<td width="40%" valign="top" class="cfAdminDefault">
						#application.StoreNameShort#<br>
						#application.CompanyAddress1#<br>
						<cfif application.CompanyAddress2 NEQ ''>
						#application.CompanyAddress2#<br>
						</cfif>
						#application.CompanyCity#, #application.CompanyState# #application.CompanyZIP#<br>
						Phone: #application.CompanyPhone#<br>
						Tax ID: #application.TaxID# 
					</td>
					<td width="40%" valign="top" class="cfAdminDefault">
						DISTRIBUTOR: #getDistributors.DistributorName#<br>
						REP NAME: #getDistributors.RepName#<br>
						PHONE: #getDistributors.Phone#<br>
						FAX: #getDistributors.Fax#<br>
						EMAIL: #getDistributors.Email#
					</td>
					<td width="20%" valign="top" class="cfAdminDefault">
						PRODUCTS ORDERED: #getOrderDistSend.RecordCount#<br>
						DATE: #DateFormat(Now(), "d-mmm-yyyy")#
					</td>
				</tr>
			</table>
			</cfoutput>
			<br>
			<cfset ThisOrderID = 0 >
			<cfloop query="getOrderDistSend">
				<cfscript>
					getOrderInfo = application.Queries.getOrderInfo(OrderID=OrderID);
				</cfscript>
				
				<!--- TO GROUP BY ORDERID IN CFLOOP --->
				<cfif OrderID neq ThisOrderID >
					<cfloop query="getOrderInfo">
						
						<cfscript>
							getShippingMethod = application.Queries.getShippingMethod(ShippingCode=getOrderInfo.ShippingMethod);
						</cfscript>
						
						
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
						
						<!--- Added by Carl Vanderpal 5 June 2007 - TODO: Convert to CFC --->
						<cfquery name="getOrderItems" dbtype="query">
							SELECT	OrderItemsID, ItemID, SKU, ItemName, Qty, OptionName1, OptionName2, OptionName3
							FROM	getOrderDistSend
							WHERE	OrderID = #getOrderInfo.OrderID#
							ORDER BY	SKU
						</cfquery>
						
						<table border="0" cellpadding="0" cellspacing="0" width="100%">
							<tr style="background-color:##F27028;">
								<td width="10%" height="20" class="cfAdminHeader4" align="center">Quantity</td>
								<td width="10%" height="20" class="cfAdminHeader4">SKU</td>
								<td width="70%" height="20" class="cfAdminHeader4">Item Name/Description</td>
							</tr>
							<cfloop query="getOrderItems">	
							<tr>
								<td height="20" align="center">#getOrderItems.Qty#</td>
								<td>#getOrderItems.SKU#</td>
								<td>#getOrderItems.ItemName# 
									<cfif getOrderItems.OptionName1 NEQ ''>: #getOrderItems.OptionName1#</cfif>
									<cfif getOrderItems.OptionName2 NEQ ''>, #getOrderItems.OptionName2#</cfif>
									<cfif getOrderItems.OptionName3 NEQ ''>, #getOrderItems.OptionName3#</cfif>
								</td>
							</tr>
							<tr>
								<td colspan="7" height="1" bgcolor="##CCCCCC"></td>
							</tr>
							</cfloop>
						</table>
						<br>
						<hr class="snip">
					</cfloop>
					<cfset ThisOrderID = getOrderInfo.OrderID >
				</cfif><!--- TO GROUP BY ORDERID IN CFLOOP --->
			</cfloop>
			</td></tr></table>
			<br/>
			</body>
			</html>
			</cfmail>
			<!--- UPDATE DATABASE: ORDER --->
			<!--- Added by Carl Vanderpal 5 June 2007 - TODO: Convert to CFC --->
			<cfquery name="updateOrderItems" datasource="#application.dsn#">
				UPDATE	OrderItems
				SET		StatusCode = 'PR'
				WHERE	OrderID = #OrderID#
			</cfquery>
			<!--- Added by Carl Vanderpal 5 June 2007 - TODO: Convert to CFC --->
			<cfquery name="updateOrder" datasource="#application.dsn#">
				UPDATE	Orders
				SET		OrderStatus = 'PR'
				WHERE	OrderID = #OrderID#
			</cfquery>			
		</cfif>
	</cfloop>
</cfif>
