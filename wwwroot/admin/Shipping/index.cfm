<!--- HEADER --->
<!--- HEADER --->
<cfscript>
	PageTitle = 'SHIPPING WIZARD PRO' ;
	BannerTitle = 'ShipWizard' ;
</cfscript>
<cfinclude template="LayoutShipHeader.cfm">
<cfinclude template="LayoutShipBanner.cfm">

<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td colspan="3">&nbsp;</td>
	</tr>
	<tr>
		<td width="33%" align="center"><a href="indexUSPS.cfm"><img src="images/Logos/logo-USPS.jpg" border="0"></a></td>
		<td width="33%" align="center"><a href="indexUPS.cfm"><img src="images/Logos/logo-UPSlg.gif" border="0"></a></td>
		<td width="33%" align="center"><a href="indexFEDEX.cfm"><img src="images/Logos/logo-FedEx.gif" border="0"></a></td>
	</tr>
</table>


<cfinclude template="LayoutShipFooter.cfm">