<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<cfscript>
	PageTitle = 'REFUND TRANSACTION' ;
	BannerTitle = 'PayPal' ;
</cfscript>
<cfinclude template="LayoutPPHeader.cfm">
<cfinclude template="LayoutPPBanner.cfm">

<cfform action="RefundReceipt.cfm" method="post">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td width="10%">Transaction ID: </td>
		<cfif IsDefined("trxID")>
			<td><cfinput type="text" class="cfAdminDefault" name="trxID" message="Enter a transaction ID" required="Yes" value="#trxID#"> <font size=-2 color=red>Required</font></td>
		<cfelse>
			<td><cfinput type="text" class="cfAdminDefault" name="trxID" message="Enter a transaction ID" required="Yes"> <font size=-2 color=red>Required</font></td>
		</cfif>
	</tr>
	<tr>
		<td>Refund Type: </td>
		<td>
			<select name="refundType" class="cfAdminDefault">
				<option>Full</option>
				<option>Partial</option>
			</select> <font size=-2 color=red>Required</font>
		</td>
	</tr>
	<tr>
		<td>Amount: </td>
		<cfif IsDefined("amount")>
			<td><cfinput type="text" class="cfAdminDefault" name="amount" required="No" value="#amount#"> $USD</td>
		<cfelse>
			<td><cfinput type="text" class="cfAdminDefault" name="amount" required="No"> $USD</td>
		</cfif>
	</tr>
</table><br>
<input type="submit" value="REFUND PAYMENT" class="cfAdminButton">
<input type="button" value="BACK" class="cfAdminButton" onClick="javascript:history.back()">
<input type="button" value="CANCEL" class="cfAdminButton" onClick="javascript:history.back()">

</cfform>

<cfinclude template="LayoutPPFooter.cfm">