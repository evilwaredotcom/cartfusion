<cfscript>
	PageTitle = 'CONTROL PANEL' ;
	BannerTitle = 'PayPal' ;
</cfscript>
<cfinclude template="LayoutPPHeader.cfm">
<cfinclude template="LayoutPPBanner.cfm">

<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td colspan="3">
			<ul>
				<li><strong><img src="../images/spacer.gif" height="20" width="1">
					<a href="TransactionSearch.cfm"><b>TRANSACTION SEARCH</b></a>
				</strong></li>
				<li><strong><img src="../images/spacer.gif" height="20" width="1">
					<a href="GetTransactionDetails.cfm"><b>GET TRANSACTION DETAILS</b></a>
				</strong></li>
				<li><strong><img src="../images/spacer.gif" height="20" width="1">
					<a href="RefundTransaction.cfm"><b>REFUND TRANSACTION</b></a>
				</strong></li>
				<li><strong><img src="../images/spacer.gif" height="20" width="1">
					<a href="DirectPayment.cfm"><b>DIRECT PAYMENT</b></a>
				</strong></li>		
			</ul>
		</td>
	</tr>
</table>

<cfinclude template="LayoutPPFooter.cfm">