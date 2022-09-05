<cfscript>
	PageTitle = 'TRANSACTION SEARCH' ;
	BannerTitle = 'PayPal' ;
</cfscript>
<cfinclude template="LayoutPPHeader.cfm">
<cfinclude template="LayoutPPBanner.cfm">

<cfform action="TransactionSearchResults.cfm" method="post">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td width="12%" nowrap>Start Date (mm/dd/yyyy): </td>
		<td><cfinput type="text" class="cfAdminDefault" name="startDateStr" message="Enter search start date, formatted mm/dd/yyyy (e.g. 12/31/2005)" 
			validate="date" required="Yes" value="#DateFormat(DateAdd("m", -1, Now()), "mm/dd/yyyy")#"> <font size=-2 color=red>required</font></td>
	</tr>
	<tr>
		<td width="12%" nowrap>End Date (mm/dd/yyyy): </td>
		<td><cfinput type="text" class="cfAdminDefault" name="endDateStr" message="Enter search end date, formatted mm/dd/yyyy (e.g. 12/31/2005)" 
			validate="date" required="Yes" value=#DateFormat(Now(), "mm/dd/yyyy")#> <font size=-2 color=red>required</font></td>
	</tr>
</table><br>
<input type="submit" value="SEARCH" class="cfAdminButton">
<input type="button" value="BACK" class="cfAdminButton" onClick="javascript:history.back()">
<input type="button" value="CANCEL" class="cfAdminButton" onClick="javascript:history.back()">
</cfform>

<cfinclude template="LayoutPPFooter.cfm">