<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<cfinvoke component="#application.Queries#" method="getStates" returnvariable="getStates"></cfinvoke>

<!--- HEADER --->
<cfscript>
	PageTitle = 'SHIP BY LOCATION CONFIGURATION';
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr height="20" style="background-color:##7DBF0E;">
		<td width="18%" class="cfAdminHeader2">&nbsp; State/Province</td>
		<td width="12%" class="cfAdminHeader2">Shipping Rate</td>
		<td width="18%" class="cfAdminHeader2">&nbsp; State/Province</td>
		<td width="12%" class="cfAdminHeader2">Shipping Rate</td>
		<td width="40%" class="cfAdminHeader2">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="5" height="5"><img src="images/spacer.gif" width="1" height="5"></td>
	</tr>
	<tr>
		<td valign="top" colspan="2">
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<cfoutput query="getStates" startrow="1" maxrows="37">
				<cfform action="Config-ShipByLoc.cfm" method="post">
					<tr>
						<td width="60%" bgcolor="#IIF(((CurrentRow MOD 2) is 0),de('EFEFEF'),de('FFFFFF'))#"><cfif StateCode EQ ''><b>#State#</b><cfelse>#State# (#StateCode#):</cfif></td>
						<td width="40%"><input type="text" name="S_Rate" value="#DecimalFormat(S_Rate)#" class="cfAdminDefault" size="5" onChange="updateInfo('#SID#',this.value,'S_Rate','States');"></td>
					</tr>
				</cfform>
			</cfoutput>
			</table>
		</td>
		<td valign="top" colspan="2">
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<cfoutput query="getStates" startrow="38" maxrows="37">
				<cfform action="Config-ShipByLoc.cfm" method="post">
					<tr>
						<td width="60%" bgcolor="#IIF(((CurrentRow MOD 2) is 0),de('EFEFEF'),de('FFFFFF'))#"><cfif StateCode EQ ''><b>#State#</b><cfelse>#State# (#StateCode#):</cfif></td>
						<td width="40%"><input type="text" name="S_Rate" value="#DecimalFormat(S_Rate)#" class="cfAdminDefault" size="5" onChange="updateInfo('#SID#',this.value,'S_Rate','States');"></td>
					</tr>
				</cfform>
			</cfoutput>
			</table>
		</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td colspan="5" height="5"><img src="images/spacer.gif" width="1" height="5"></td>
	</tr>
	<tr>
		<td colspan="4" align="center">
			<input type="button" name="GoBack" value="<< GO BACK" alt="Go Back To Configuration Screen" class="cfAdminButton"
				onClick="document.location.href='Config-Shipping.cfm'">
			<input type="button" name="ReturnHome" value="RETURN HOME >>" alt="Go To Home Page" class="cfAdminButton"
				onClick="document.location.href='home.cfm'">
		</td>
		<td></td>
	</tr>
</table>

<cfinclude template="LayoutAdminFooter.cfm">