<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<cfscript>
	PageTitle = 'TRANSACTION SEARCH RESULTS' ;
	BannerTitle = 'PayPal' ;
</cfscript>
<cfinclude template="LayoutPPHeader.cfm">
<cfinclude template="LayoutPPBanner.cfm">

<cfinvoke component="paypal" method="TransactionSearch" returnvariable="transactionSearchResponse">
	<cfinvokeargument name="startDate" value=#ParseDateTime(startDateStr)#/>
	<cfinvokeargument name="endDate" value=#DateAdd("d", 1, ParseDateTime(endDateStr))#/>  
</cfinvoke>

<cfscript>
	// Get response objects
	results = transactionSearchResponse.getPaymentTransactions();
</cfscript>

<!--- Make sure results is defined --->
<cfif Not IsDefined("results")>
	<h1>Your search did not match any transactions!</h1>
	<cfabort>
</cfif>
	
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td class="cfAdminHeader1" width="2%" height="20"></td>
		<td class="cfAdminHeader1" width="15%">ID</td>
		<td class="cfAdminHeader1" width="10%">Time</td>
		<td class="cfAdminHeader1" width="15%">Status</td>
		<td class="cfAdminHeader1" width="15%">Payer Name</td>
		<td class="cfAdminHeader1" width="10%">Gross Amount</td>
		<td class="cfAdminHeader1" width="10%">Fee Amount</td>
		<td class="cfAdminHeader1" width="23%"></td>
	</tr>
	<cfoutput>
	<cfloop index = "count" from = "1" to = #ArrayLen(results)#>
		<tr>
			<td height="20">#count#</td>
			<td><a href="TransactionDetails.cfm?trxID=#results[count].getTransactionID()#">#results[count].getTransactionID()#</a></td>
			<td>#DateFormat(results[count].getTimestamp(), "mm/dd/yyyy")#</td>
			<td>#results[count].getStatus()#</td>
			<td>#results[count].getPayerDisplayName()#</td>
			<td><cfif Left(results[count].getTransactionID(), 1) NEQ 'S'>#results[count].getGrossAmount().getCurrencyID()# #results[count].getGrossAmount().get_value()#<cfelse>---</cfif></td>
			<td><cfif Left(results[count].getTransactionID(), 1) NEQ 'S'>#results[count].getFeeAmount().getCurrencyID()# #results[count].getFeeAmount().get_value()#<cfelse>---</cfif></td>
			<td></td>
		</tr>
		<!--- DIVIDER --->
		<tr><td height="1" colspan="8"><img src="../images/image-LineGray.gif" width="100%" height="1"></td></tr>
	</cfloop>
	</cfoutput>
</table>
<br>
<!---<cfoutput>Results 1 - #ArrayLen(results)#</cfoutput>--->
<input type="button" name="Home" value="HOME" alt="PAYPAL PRO HOME" class="cfAdminButton"
	onClick="document.location.href='index.cfm'">
<input type="button" value="BACK" class="cfAdminButton" onClick="javascript:history.back()">

<cfinclude template="LayoutPPFooter.cfm">