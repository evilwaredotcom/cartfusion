<cfscript>
	PageTitle = 'REPORT WIZARD PRO' ;
	BannerTitle = 'ReportWizard' ;
	ReportPage = 'RWP-ReportWizard.cfm' ;
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td colspan="5">&nbsp;</td>
	</tr>
	<tr>
		<td align="center"><a href="RWP-Revenue.cfm"><img src="images/icon-Revenue.jpg" border="0"></a></td>
		<td align="center"><a href="RWP-Store.cfm"><img src="images/icon-Store.jpg" border="0"></a></td>
		<td align="center"><a href="RWP-Customers.cfm"><img src="images/icon-Customers.jpg" border="0"></a></td>
		<td align="center"><a href="RWP-Affiliates.cfm"><img src="images/icon-Affiliates.jpg" border="0"></a></td>
	</tr>
</table>


<cfinclude template="LayoutAdminFooter.cfm">