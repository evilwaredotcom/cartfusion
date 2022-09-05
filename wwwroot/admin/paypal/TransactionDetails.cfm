<cfinclude template="paypal-util.cfm">

<cfscript>
	PageTitle = 'TRANSACTION DETAILS' ;
	BannerTitle = 'PayPal' ;
</cfscript>
<cfinclude template="LayoutPPHeader.cfm">
<cfinclude template="LayoutPPBanner.cfm">

<cfinvoke component="paypal" method="GetTransactionDetails" returnvariable="getTransactionDetailsResponse">
	<cfinvokeargument name="trxID" value=#trxID#/>
</cfinvoke>


<!--- Make sure results is defined --->
<cfscript>
	If (Not IsTrxSuccessful(getTransactionDetailsResponse)) {
		PrintErrorMessages(getTransactionDetailsResponse);
	}
</cfscript>

<cfoutput>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="2" class="cfAdminTitle">Payer Info: </td>
	</tr>
	<tr>
		<td width="15%">Payer: </td>
		<td>#getTransactionDetailsResponse.getPaymentTransactionDetails().getPayerInfo().getPayer()#</td>
	</tr>
	<tr>
		<td>Payer ID: </td>
		<td>#getTransactionDetailsResponse.getPaymentTransactionDetails().getPayerInfo().getPayerID()#</td>
	</tr>
	<tr>
		<td>First Name: </td>
		<td>#getTransactionDetailsResponse.getPaymentTransactionDetails().getPayerInfo().getPayerName().getFirstName()#</td>
	</tr>
	<tr>
		<td>Last Name: </td>
		<td>#getTransactionDetailsResponse.getPaymentTransactionDetails().getPayerInfo().getPayerName().getLastName()#</td>
	</tr>
	<tr><td height="20">&nbsp;</td></tr>
	<tr>
		<td colspan="2" class="cfAdminTitle">Payment Info: </td>
	</tr>
	<tr>
		<td>Transaction ID: </td> 
		<td>#getTransactionDetailsResponse.getPaymentTransactionDetails().getPaymentInfo().getTransactionID()#</td>
	</tr>
	<tr>
		<td>Parent Transaction ID (if any): </td> 
		<td>#getTransactionDetailsResponse.getPaymentTransactionDetails().getPaymentInfo().getParentTransactionID()#</td>
	</tr>
	<tr>
		<td>Gross Amount: </td>
		<td>#getTransactionDetailsResponse.getPaymentTransactionDetails().getPaymentInfo().getGrossAmount().getCurrencyID()# 
		#getTransactionDetailsResponse.getPaymentTransactionDetails().getPaymentInfo().getGrossAmount().get_value()#</td>
	</tr>
	<tr>
		<td>Payment Status: </td> 
		<td>#getTransactionDetailsResponse.getPaymentTransactionDetails().getPaymentInfo().getPaymentStatus()#</td>
	</tr>
</table><br>

<input type="button" name="Refund" value="REFUND" alt="REFUND TRANSACTION" class="cfAdminButton"
	onClick="document.location.href='RefundTransaction.cfm?trxID=#getTransactionDetailsResponse.getPaymentTransactionDetails().getPaymentInfo().getTransactionID()#&amount=#getTransactionDetailsResponse.getPaymentTransactionDetails().getPaymentInfo().getGrossAmount().get_value()#'">
<input type="button" name="Cancel" value="CANCEL" class="cfAdminButton" onClick="javascript:history.back()">

</cfoutput>

<cfinclude template="LayoutPPFooter.cfm">