<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<cfinclude template="paypal-util.cfm">

<cfscript>
	PageTitle = 'REFUND TRANSACTION RECEIPT' ;
	BannerTitle = 'PayPal' ;
</cfscript>
<cfinclude template="LayoutPPHeader.cfm">
<cfinclude template="LayoutPPBanner.cfm">

<cfinvoke component="paypal" method="RefundTransaction" returnvariable="refundTransactionResponse">
	<cfinvokeargument name="trxID" value=#trxID#>
	<cfinvokeargument name="refundType" value=#refundType#>
	<cfinvokeargument name="partialAmount" value=#amount#>
</cfinvoke>

<!--- Check the Ack --->
<cfscript>
	If (Not IsTrxSuccessful(refundTransactionResponse)) {
		PrintErrorMessages(refundTransactionResponse);
	}
</cfscript>

<br><br>
<b>The transaction has been refunded!</b>
<br><br>
<input type="button" name="Home" value="HOME" alt="PAYPAL PRO HOME" class="cfAdminButton"
	onClick="document.location.href='index.cfm'">

<cfinclude template="LayoutPPFooter.cfm">