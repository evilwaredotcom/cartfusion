<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<cfoutput>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td width="70%" height="20" align="left" class="cfAdminTitle">
			<cfif isDefined('BannerTitle') AND BannerTitle NEQ ''><img src="images/banner-#BannerTitle#.gif">
			<cfelseif isDefined('PageTitle') AND PageTitle NEQ ''>#UCASE(PageTitle)#
			<cfelse>CARTFUSION
			</cfif>
			<cfif isDefined('AdminMsg')>&nbsp; <img src="images/image-Message.gif"> <font class="cfAdminError">#AdminMsg#</font></cfif>
		</td>
		<td width="30%" align="right">
			<cfif isDefined('AddAButton') AND isDefined('AddAButtonLoc') >
				<input type="button" name="AddThisButton" value="#AddAButton#" class="cfAdminButton"
					onClick="document.location.href='#AddAButtonLoc#'">
			</cfif>
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