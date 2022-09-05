<cfdump var="#Form#">
<cfscript>
	InstID = '' ; // Your Account Installation ID
	Currency = 'USD' ; // CAD | USD | EUR
	TestMode = 100 ; // 100 = Test Always Successful | 101 = Test Always Fail
	CallBackPW = '' ; // Your Account Callback Password
	MD5Hash = '' ; // Your Account MD5 Hash Value
	Signature = MD5Hash & ':' & Replace(DecimalFormat(RunningTotal),',','') & ':' & Currency & ':' & OrderID ;
	MD5 = Hash(Signature) ;
</cfscript>

<cfoutput>
<form action="https://select.worldpay.com/wcc/purchase" method="post" target="_blank">
	<cfif RunningTotal GT 0>
		<input type="hidden" name="ProcessPayment" value="1">
	</cfif>
	<input type="hidden" name="instId" value="#InstID#">
	<input type="hidden" name="cartId" value="#OrderID#">
	<input type="hidden" name="amount" value="#Replace(DecimalFormat(RunningTotal),',','')#">
	<input type="hidden" name="currency" value="#Currency#">
	<input type="hidden" name="desc" value="Baci Connections Canada Merchandise">
	<input type="hidden" name="testMode" value="#TestMode#">
	<input type="hidden" name="name" value="#FirstName# #LastName#">
	<input type="hidden" name="address" value="#Address1#&##10;<cfif Address2 NEQ ''>#Address2#&##10;</cfif>#City#, #State#"><!--- NEW LINE = &##10; --- Address1 Address2 City --->
	<input type="hidden" name="postcode" value="#Zip#">
	<input type="hidden" name="country" value="#Country#">
	<input type="hidden" name="tel" value="#OrderPhone#">
	<!--- DO NOT PROVIDE EMAIL - CONFIRMATION GETS SENT TO CUSTOMER'S EMAIL ADDRESS --->
	<input type="hidden" name="email" value="#Email#">
	<input type="hidden" name="callbackPW" value="#CallBackPW#">
	<input type="hidden" name="signatureFields" value="amount:currency:cartId">
	<input type="hidden" name="signature" value="#MD5#">
	<cfif isDefined('BackOrderCC')>
		<input type="hidden" name="M_TypeOfOrder" value="BackOrder" />
		<input type="hidden" name="M_Items" value="#session.StoredBackOrders.ItemSelect#" />
		<input type="hidden" name="M_CustomerID" value="#CustomerID#" />
		<cfif isDefined('Form.DiscountToApply') AND Form.DiscountToApply GT 0>
			<input type="hidden" name="M_Discount" value="#FormattedDiscount#">
		</cfif>
		<cfif isDefined('Form.CreditApplied') AND Form.CreditApplied GT 0>
			<input type="hidden" name="M_Credit" value="#Replace(DecimalFormat(Form.CreditApplied),',','')#">
		</cfif>
		<input type="button" name="GoBack" value="<< GO BACK" alt="Go Back to Previous Page" class="cfAdminButton"
			onclick="document.location.href='BackOrders.cfm'">
		<input type="button" name="PrintInvoice" value="PRINT INVOICE" alt="Print Back Order Invoice" class="cfAdminButton"
			onclick="NewWindow('BackOrdersPrint.cfm?OrderID=#OrderID#&CustomerID=#CustomerID#&ItemSelect=#FORM.ItemSelect#<cfif isDefined('Form.DiscountToApply') AND Form.DiscountToApply GT 0>&DiscountToApply=#Form.DiscountToApply#</cfif><cfif isDefined('Form.CreditApplied') AND Form.CreditApplied GT 0>&CreditApplied=#Form.CreditApplied#</cfif>','BACKORDER','1000','700','yes');">
		<input type="submit" name="Process" value="PROCESS PAYMENT" alt="Process Payment for Back Orders" class="cfAdminButton"
			onclick="return confirm('BACI CONNECTIONS CANADA\n\nAre you sure you want to process a backorder payment of #LSCurrencyFormat(RunningTotal)# for Order #OrderID#?')">
	<cfelse>
		<input type="hidden" name="M_TypeOfOrder" value="Order" />
		<input type="submit" name="Process" value="PROCESS PAYMENT" alt="Process Credit Card Payment" class="cfAdminButton"
			onclick="return confirm('Are you sure you want to process a payment of #LSCurrencyFormat(RunningTotal)# for Order #OrderID#?\n\nBefore proceeding, make sure you have clicked \'Refresh Total\' after making any changes to Order Items.')">
	</cfif>
</form>
</cfoutput>