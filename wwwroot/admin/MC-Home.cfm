<cfset PageTitle = 'MESSAGE CENTER'>
<cfset ReportPage = 'MC-Home.cfm'>
<cfinclude template="LayoutAdminHeader.cfm">

<cfoutput>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td width="100%" height="20">
			<img src="images/banner-MessageCenter.gif" border="0" align="bottom">
		</td>
	</tr>
	<tr style="background-color:##CCCCCC;"><td height="1" colspan="2"></td></tr>
	<tr><td height="1" colspan="2"></td></tr>
	<tr style="background-color:##CCCCCC;"><td height="1" colspan="2"></td></tr>
</table>

<table width="50%" border="0" cellspacing="0" cellpadding="0" align="center">
	<tr>
		<td colspan="4">&nbsp;</td>
	</tr>
	<tr>
		<td><a href="MC-Messages.cfm"><img src="images/icon-MCi.jpg" border="0" alt="INTERNAL MESSAGE CENTER"></a></td>
		<td><a href="MC-Main.cfm"><img src="images/icon-MCc.jpg" border="0" alt="CUSTOMER MESSAGE CENTER"></a></td>
	</tr>
</table>

</cfoutput>

<cfinclude template="LayoutAdminFooter.cfm">
