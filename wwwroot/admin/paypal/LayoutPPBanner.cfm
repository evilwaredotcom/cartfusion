<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<cfoutput>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td width="70%" height="20" align="left" class="cfAdminTitle" valign="middle">
			<img src="images/banner-PayPal.gif" align="absmiddle">
			<cfif isDefined('PageTitle') AND PageTitle NEQ ''>#UCASE(PageTitle)#
			<cfelse>CARTFUSION PAYPAL PRO
			</cfif>
			<cfif isDefined('AdminMsg')>&nbsp; <img src="images/image-Message.gif"> <font class="cfAdminError">#AdminMsg#</font></cfif>
		</td>
		<td width="30%" align="right">
			<cfif isDefined('AddAButton') AND isDefined('AddAButtonLoc') >
				<input type="button" name="AddThisButton" value="#AddAButton#" class="cfAdminButton"
					onClick="document.location.href='#AddAButtonLoc#'">
			</cfif>
				<input type="button" name="Home" value="HOME" alt="PAYPAL PRO HOME" class="cfAdminButton"
					onClick="document.location.href='index.cfm'">
				<input type="button" name="Search" value="SEARCH" alt="SEARCH" class="cfAdminButton"
					onClick="document.location.href='../Search.cfm'">
				<input type="button" name="Help" value="HELP" alt="CartFusion Help Desk" class="cfAdminButton"
					onClick="document.location.href='http://support.tradestudios.com'">
		</td>
	</tr>
	<tr style="background-color:##CCCCCC;"><td height="1" colspan="2"></td></tr>
	<tr><td height="1" colspan="2"></td></tr>
	<tr style="background-color:##CCCCCC;"><td height="1" colspan="2"></td></tr>
</table>
</cfoutput>