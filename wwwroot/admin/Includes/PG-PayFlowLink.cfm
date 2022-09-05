<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<cfinvoke component="#application.Queries#" method="getPFL" returnvariable="getPFL">
	<cfinvokeargument name="SiteID" value="#application.SiteID#">
</cfinvoke>

<cfscript>
	decrypted_LOGIN = DECRYPT(getPFL.Login, application.CryptKey, "CFMX_COMPAT", "Hex") ;
	decrypted_PARTNER = DECRYPT(getPFL.Partner, application.CryptKey, "CFMX_COMPAT", "Hex") ;
</cfscript>

<cfoutput>
<!--- PAYFLOW LINK SUBMITTAL FORM --->
<form method="POST" action="https://payments.verisign.com/payflowlink">
	<td width="100">
		<input type="hidden" name="LOGIN" value="#decrypted_LOGIN#">
		<input type="hidden" name="PARTNER" value="#decrypted_PARTNER#">
		<input type="hidden" name="AMOUNT" value="#NumberFormat(runningtotal,9.99)#">
		<input type="hidden" name="TYPE" value="S"><!--- S = Sale/Payment | A = Authorization Only --->
		<input type="hidden" name="INVOICE" value="#OrderID#">
		<input type="hidden" name="DESCRIPTION" value="#application.storename# Merchandise">
		<input type="hidden" name="NAME" value="#firstname# #lastname#">
		<input type="hidden" name="ADDRESS" value="#address1# #address2#">
		<input type="hidden" name="CITY" value="#city#">
		<input type="hidden" name="STATE" value="#Ucase(state)#">
		<input type="hidden" name="ZIP" value="#zip#">
		<input type="hidden" name="COUNTRY" value="#country#">
		<input type="hidden" name="PHONE" value="#OrderPhone#">
		<cfif getOrder.Email NEQ ''>
			<input type="hidden" name="EMAIL" value="#email#">
		<cfelse>
			<input type="hidden" name="EMAIL" value="#application.NotifyEmail#">
		</cfif>
		
		<!--- USER1 thru USER10 & CUSTID are string type parameters are intended to store temporary data (for example, variables, session IDs, order
			  numbers, and so on). These parameters enable you to return the values to your server by using the Post or Silent Post feature. --->
		<input type="hidden" name="CUSTID" value="#CustomerID#">
		<cfif RunningTotal GT 0>
			<input type="hidden" name="USER1" value="ProcessPayment">
		</cfif>
		<input type="hidden" name="USER2" value="Order"> <!--- Tells OrderComplete what type of order to process --->
		
		<input type="hidden" name="METHOD" value="CC"><!--- CC = Credit Card | ECHECK = TeleCheck/eCheck --->
		<input type="hidden" name="CARDNUM" value="#decrypted_CCnum#">
		<input type="hidden" name="EXPDATE" value="#decrypted_CCexpdate#">
		<input type="hidden" name="CSC" value="#CCCVV#">
		
		<input type="submit" name="ProcessPayment" value="PROCESS PAYMENT" alt="Process Credit Card Payment" class="cfAdminButton"
			onClick="return confirm('Are you sure you want to process a payment of #LSCurrencyFormat(runningtotal)# for Order #OrderID#?\n\nBefore proceeding, make sure you have clicked \'Refresh Total\' after making any changes to Order Items.')">&nbsp;
	</td>
</form>


<!--- AUTHORIZE ONLY --->
<form method="POST" action="https://payments.verisign.com/payflowlink">
	<td width="100">				
		<cfif RunningTotal GT 0>
			<input type="hidden" name="ProcessPayment" value="1">
		</cfif>
		<input type="hidden" name="TypeOfOrder" value="VOID"> <!--- Tells OrderComplete what type of order to process --->

		<input type="hidden" name="LOGIN" value="#decrypted_LOGIN#">
		<input type="hidden" name="PARTNER" value="#decrypted_PARTNER#">
		<input type="hidden" name="AMOUNT" value="#NumberFormat(runningtotal,9.99)#">
		<input type="hidden" name="TYPE" value="A"><!--- S = Sale/Payment | A = Authorization Only --->
		<input type="hidden" name="INVOICE" value="#OrderID#">
		<input type="hidden" name="DESCRIPTION" value="#application.storename# Merchandise">
		<input type="hidden" name="NAME" value="#firstname# #lastname#">
		<input type="hidden" name="ADDRESS" value="#address1# #address2#">
		<input type="hidden" name="CITY" value="#city#">
		<input type="hidden" name="STATE" value="#Ucase(state)#">
		<input type="hidden" name="ZIP" value="#zip#">
		<input type="hidden" name="COUNTRY" value="#country#">
		<input type="hidden" name="PHONE" value="#OrderPhone#">
		<!--- USER1 thru USER10 & CUSTID are string type parameters are intended to store temporary data (for example, variables, session IDs, order
			  numbers, and so on). These parameters enable you to return the values to your server by using the Post or Silent Post feature. --->
		<input type="hidden" name="CUSTID" value="#CustomerID#">
		
		<cfif getOrder.Email NEQ ''>
			<input type="hidden" name="EMAIL" value="#email#">
		<cfelse>
			<input type="hidden" name="EMAIL" value="#application.NotifyEmail#">
		</cfif>
		
		<input type="hidden" name="METHOD" value="CC"><!--- CC = Credit Card | ECHECK = TeleCheck/eCheck --->
		<input type="hidden" name="CARDNUM" value="#decrypted_CCnum#">
		<input type="hidden" name="EXPDATE" value="#decrypted_CCexpdate#">
		<input type="hidden" name="CSC" value="#CCCVV#">				

		<input type="submit" name="AuthPayment" value="AUTHORIZE PAYMENT" alt="Process Credit Card Payment" class="cfAdminButton"
			onClick="return confirm('Are you sure you want to authorize a payment of #LSCurrencyFormat(runningtotal)# for Order #OrderID#?\n\nBefore proceeding, make sure you have clicked \'Refresh Total\' after making any changes to Order Items.')">
	</td>
</form>
</cfoutput>