<cfset PageTitle = 'SHIPPING CONFIGURATION'>
<cfset BannerTitle = 'ShippingConfig'>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">

<table width="500" border="0" cellspacing="0" cellpadding="0" style="padding-left:30px;">
	<tr>
		<td colspan="2"><img src="images/spacer.gif" height="20" width="1"></td>
	</tr>
	<tr>
		<td align="center"><a href="Config-ShipByCalc.cfm"><img src="images/icon-ShipByC.jpg" border="0"></a></td>
		<td align="center"><a href="Config-ShipByLoc.cfm"><img src="images/icon-ShipByL.jpg" border="0"></a></td>
	</tr>
	<tr>
		<td colspan="2"><img src="images/spacer.gif" height="20" width="1"></td>
	</tr>
	<tr>
		<td align="center"><a href="Config-ShipByPrice.cfm"><img src="images/icon-ShipByP.jpg" border="0"></a></td>
		<td align="center"><a href="Config-ShipByWeight.cfm"><img src="images/icon-ShipByW.jpg" border="0"></a></td>
	</tr>
	<tr>
		<td colspan="2"><img src="images/spacer.gif" height="20" width="1"></td>
	</tr>
	<tr>
		<td align="center"><a href="Config-ShipByCustomP.cfm"><img src="images/icon-ShipByCP.jpg" border="0"></a></td>
		<td align="center"><a href="Config-ShipByCustomW.cfm"><img src="images/icon-ShipByCW.jpg" border="0"></a></td>
	</tr>
		<tr>
		<td colspan="2"><img src="images/spacer.gif" height="20" width="1"></td>
	</tr>
	<tr>
		<td align="center" colspan="2"><a href="Config-ShipCodes.cfm"><img src="images/icon-ShipCodes.jpg" border="0"></a></td>
	</tr>
	<tr>
		<td colspan="2"><img src="images/spacer.gif" height="10" width="1"></td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<input type="button" name="GoBack" value="<< GO BACK" alt="Go Back To Configuration Screen" class="cfAdminButton"
				onClick="document.location.href='Configuration.cfm'">
			<input type="button" name="ReturnHome" value="RETURN HOME >>" alt="Go To Home Page" class="cfAdminButton"
				onClick="document.location.href='home.cfm'">
		</td>
	</tr>
</table>


<cfinclude template="LayoutAdminFooter.cfm">