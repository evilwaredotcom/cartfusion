<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<!--- AUTHORIZE.NET SUBMITTAL FORM --->
<cfoutput>

<!--- AUTH_CAPTURE --->
<form action="OrderComplete.cfm" method="post">
	<!--- IF TRANSACTION LESS THAN OR EQUAL TO $0.00, BYPASS PAYMENT GATEWAY AND LOG TRANSACTION --->
	<cfif RunningTotal GT 0>
		<input type="hidden" name="ProcessPayment" value="1">
	</cfif>
	<input type="hidden" name="x_Amount" value="#Replace(DecimalFormat(RunningTotal),',','')#">				
	<input type="hidden" name="x_Invoice_Num" value="#OrderID#">
	<input type="hidden" name="x_Cust_ID" value="#CustomerID#">
	<input type="hidden" name="x_First_Name" value="#firstname#">
	<input type="hidden" name="x_Last_Name" value="#lastname#">
	<input type="hidden" name="x_Address" value="#address1# #address2#">
	<input type="hidden" name="x_City" value="#city#">
	<input type="hidden" name="x_State" value="#Ucase(state)#">
	<input type="hidden" name="x_Zip" value="#zip#">
	<input type="hidden" name="x_Country" value="#country#">
	<input type="hidden" name="x_Ship_To_First_Name" value="#oShipFirstName#">
	<input type="hidden" name="x_Ship_To_Last_Name" value="#oShipLastName#">
	<input type="hidden" name="x_Ship_To_Address" value="#oShipAddress1# #oShipAddress2#">
	<input type="hidden" name="x_Ship_To_City" value="#oShipCity#">
	<input type="hidden" name="x_Ship_To_State" value="#oShipState#">
	<input type="hidden" name="x_Ship_To_Zip" value="#oShipZip#">
	<input type="hidden" name="x_Ship_To_Country" value="#oShipCountry#">
	
	<input type="hidden" name="x_Phone" value="#OrderPhone#">
	<cfif getOrder.Email NEQ ''>
		<input type="hidden" name="x_Email"	value="#email#">
	<cfelse>
		<input type="hidden" name="x_Email"	value="#application.NotifyEmail#">
	</cfif>
	<input type="hidden" name="x_Method" value="#CCname#">
	<input type="hidden" name="x_Card_Num" value="#decrypted_CCnum#">
	<input type="hidden" name="x_Exp_Date" value="#decrypted_CCexpdate#">
	<input type="hidden" name="x_Card_Code" value="#CCCVV#">				
	<input type="hidden" name="x_Description" value="#application.storename# Merchandise">
	<cfif isDefined('BackOrderCC')>
		<input type="hidden" name="AuthType" value="AUTH_CAPTURE">
		<input type="hidden" name="TypeOfOrder" value="BackOrder"> <!--- Tells OrderComplete what type of order to process --->
		<cfif isDefined('Form.DiscountToApply') AND Form.DiscountToApply GT 0>
			<input type="hidden" name="Discount" value="#FormattedDiscount#">
		</cfif>
		<cfif isDefined('Form.CreditApplied') AND Form.CreditApplied GT 0>
			<input type="hidden" name="Credit" value="#Replace(DecimalFormat(Form.CreditApplied),',','')#">
		</cfif>
		<input type="button" name="GoBack" value="<< GO BACK" alt="Go Back to Previous Page" class="cfAdminButton"
			onClick="document.location.href='BackOrders.cfm'">
		<input type="button" name="PrintInvoice" value="PRINT INVOICE" alt="Print Back Order Invoice" class="cfAdminButton"
			onClick="NewWindow('BackOrdersPrint.cfm?OrderID=#OrderID#&CustomerID=#CustomerID#&ItemSelect=#FORM.ItemSelect#<cfif isDefined('Form.DiscountToApply') AND Form.DiscountToApply GT 0>&DiscountToApply=#Form.DiscountToApply#</cfif><cfif isDefined('Form.CreditApplied') AND Form.CreditApplied GT 0>&CreditApplied=#Form.CreditApplied#</cfif>','BACKORDER','1000','700','yes');">
		<input type="submit" name="Process" value="PROCESS PAYMENT" alt="Process Payment for Back Orders" class="cfAdminButton">
	<cfelseif getOrder.PaymentVerified NEQ 1 >
		<td width="100">
		<cfif getOrder.TransactionID NEQ ''>
			<input type="hidden" name="AuthType" value="PRIOR_AUTH_CAPTURE">
			<input type="hidden" name="x_trans_id" value="#TransactionID#">
			<input type="hidden" name="TypeOfOrder" value="Order"> <!--- Tells OrderComplete what type of order to process --->
			<input type="submit" name="Process" value="CAPTURE PAYMENT" alt="Capture Pre-authorized Credit Card Payment" class="cfAdminButton"
				onClick="return confirm('Are you sure you want to capture pre-authorized payment of #LSCurrencyFormat(RunningTotal)# for Order #OrderID#?\n\nBefore proceeding, make sure you have clicked \'Refresh Total\' after making any changes to Order Items.')">&nbsp;
		<cfelse>
			<input type="hidden" name="AuthType" value="AUTH_CAPTURE">
			<input type="hidden" name="TypeOfOrder" value="Order"> <!--- Tells OrderComplete what type of order to process --->
			<input type="submit" name="Process" value="PROCESS PAYMENT" alt="Process Credit Card Payment" class="cfAdminButton"
				onClick="return confirm('Are you sure you want to process a payment of #LSCurrencyFormat(RunningTotal)# for Order #OrderID#?\n\nBefore proceeding, make sure you have clicked \'Refresh Total\' after making any changes to Order Items.')">&nbsp;
		</cfif>
		</td>	
	</cfif>
</form>
	
<!--- AUTH_ONLY --->
<cfif NOT isDefined('BackOrderCC') AND 
	  isDefined('getOrder.PaymentVerified') AND getOrder.PaymentVerified NEQ 1 AND getOrder.TransactionID EQ '' >
	<form action="OrderComplete.cfm" method="post">
		<!--- IF TRANSACTION LESS THAN OR EQUAL TO $0.00, BYPASS PAYMENT GATEWAY AND LOG TRANSACTION --->		
		<cfif RunningTotal GT 0>
			<input type="hidden" name="ProcessPayment" value="1">
		</cfif>
		<input type="hidden" name="x_Amount" value="#Replace(DecimalFormat(RunningTotal),',','')#">				
		<input type="hidden" name="x_Invoice_Num" value="#OrderID#">
		<input type="hidden" name="x_Cust_ID" value="#CustomerID#">
		<input type="hidden" name="x_First_Name" value="#firstname#">
		<input type="hidden" name="x_Last_Name" value="#lastname#">
		<input type="hidden" name="x_Address" value="#address1# #address2#">
		<input type="hidden" name="x_City" value="#city#">
		<input type="hidden" name="x_State" value="#Ucase(state)#">
		<input type="hidden" name="x_Zip" value="#zip#">
		<input type="hidden" name="x_Country" value="#country#">
		<input type="hidden" name="x_Phone" value="#OrderPhone#">
		<input type="hidden" name="x_Ship_To_First_Name" value="#oShipFirstName#">
		<input type="hidden" name="x_Ship_To_Last_Name" value="#oShipLastName#">
		<input type="hidden" name="x_Ship_To_Address" value="#oShipAddress1# #oShipAddress2#">
		<input type="hidden" name="x_Ship_To_City" value="#oShipCity#">
		<input type="hidden" name="x_Ship_To_State" value="#oShipState#">
		<input type="hidden" name="x_Ship_To_Zip" value="#oShipZip#">
		<input type="hidden" name="x_Ship_To_Country" value="#oShipCountry#">
		<cfif getOrder.Email NEQ ''>
			<input type="hidden" name="x_Email"	value="#email#">
		<cfelse>
			<input type="hidden" name="x_Email"	value="#application.NotifyEmail#">
		</cfif>
		<input type="hidden" name="x_Method" value="#CCname#">
		<input type="hidden" name="x_Card_Num" value="#decrypted_CCnum#">
		<input type="hidden" name="x_Exp_Date" value="#decrypted_CCexpdate#">
		<input type="hidden" name="x_Card_Code" value="#CCCVV#">				
		<input type="hidden" name="x_Description" value="#application.storename# Merchandise">
		<td width="100">
		<!--- AUTHORIZE ONLY --->
		<input type="hidden" name="AuthType" value="AUTH_ONLY">
		<input type="hidden" name="TypeOfOrder" value="Order"> <!--- Tells OrderComplete what type of order to process --->
		<input type="submit" name="AuthPayment" value="AUTHORIZE PAYMENT" alt="Process Credit Card Payment" class="cfAdminButton"
			onClick="return confirm('Are you sure you want to authorize a payment of #LSCurrencyFormat(runningtotal)# for Order #OrderID#?\n\nBefore proceeding, make sure you have clicked \'Refresh Total\' after making any changes to Order Items.')">
		</td>
	</form>
	
<!--- VOID AUTHORIZATION OR CAPTURE --->	
<cfelseif NOT isDefined('BackOrderCC') AND 
	  isDefined('getOrder.PaymentVerified') AND getOrder.PaymentVerified NEQ 1 AND getOrder.TransactionID NEQ '' >
	<form action="OrderComplete.cfm" method="post">
		<input type="hidden" name="ProcessPayment" value="1">
		<input type="hidden" name="x_trans_id" value="#TransactionID#">
		<input type="hidden" name="OrderID" value="#OrderID#">
		<input type="hidden" name="CustomerID" value="#CustomerID#">
		<td width="100">
		<input type="hidden" name="AuthType" value="VOID">
		<input type="hidden" name="TypeOfOrder" value="Void"> <!--- Tells OrderComplete what type of order to process --->
		<input type="submit" name="AuthVoid" value="VOID TRANSACTION" alt="Void Transaction" class="cfAdminButton"
			onClick="return confirm('Are you sure you want to VOID THIS TRANSACTION?')">
		</td>
	</form>
</cfif>

</cfoutput>

