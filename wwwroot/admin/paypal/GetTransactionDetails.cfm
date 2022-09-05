<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<cfscript>
	PageTitle = 'GET TRANSACTION DETAILS' ;
	BannerTitle = 'PayPal' ;
</cfscript>
<cfinclude template="LayoutPPHeader.cfm">
<cfinclude template="LayoutPPBanner.cfm">

<cfform action="TransactionDetails.cfm" method="post">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td width="10%">Transaction ID: </td>
		<td><cfinput type="text" class="cfAdminDefault" name="trxID" message="Enter transaction ID" required="Yes"> <font size=-2 color=red>required</font></td>
	</tr>
</table><br>
<input type="submit" value="GET TRANSACTION DETAIL" class="cfAdminButton">
<input type="button" value="BACK" class="cfAdminButton" onClick="javascript:history.back()">
<input type="button" value="CANCEL" class="cfAdminButton" onClick="javascript:history.back()">
</cfform>

<cfinclude template="LayoutPPFooter.cfm">