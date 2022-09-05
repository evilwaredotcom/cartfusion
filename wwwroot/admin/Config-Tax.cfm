<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<!--- HEADER --->
<cfscript>
	PageTitle = 'TAX SCHEDULE CONFIGURATION';
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">

<cfinvoke component="#application.Queries#" method="getStates" returnvariable="getStates"></cfinvoke>


<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr height="20" style="background-color:##7DBF0E;">
		<td width="18%" class="cfAdminHeader2">&nbsp; State/Province</td>
		<td width="12%" class="cfAdminHeader2">Tax Rate</td>
		<td width="18%" class="cfAdminHeader2">&nbsp; State/Province</td>
		<td width="12%" class="cfAdminHeader2">Tax Rate</td>
		<td width="40%" class="cfAdminHeader2">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="5" height="10"><img src="images/spacer.gif" width="1" height="10"></td>
	</tr>
	<tr>
		<td colspan="4" height="20" bgcolor="#FFF2FF"><b><font color="#FF9900">&nbsp; To use a flat rate tax for all states, check "Use Flat Rate Tax" and set "Flat Rate Tax" in <a href="Configuration.cfm">CONFIGURATION</a> page.</font></b></td>
		<td>&nbsp;</td>		
	</tr>
	<tr>
		<td colspan="5" height="20"><img src="images/spacer.gif" width="1" height="20"></td>
	</tr>
	<tr>
		<td valign="top" colspan="2">
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<cfoutput query="getStates" startrow="1" maxrows="37">
				<cfform action="Config-Tax.cfm" method="post">
					<tr>
						<td width="60%" bgcolor="#IIF(((CurrentRow MOD 2) is 0),de('EFEFEF'),de('FFFFFF'))#"><cfif StateCode EQ ''><b>#State#</b><cfelse>#State# (#StateCode#):</cfif></td>
						<td width="40%"><input type="text" name="T_Rate" value="#T_Rate#" class="cfAdminDefault" size="5" onChange="updateInfo('#SID#',this.value,'T_Rate','States');"></td>
					</tr>
				</cfform>
			</cfoutput>
			</table>
		</td>
		<td valign="top" colspan="2">
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<cfoutput query="getStates" startrow="38" maxrows="37">
				<cfform action="Config-Tax.cfm" method="post">
					<tr>
						<td width="60%" bgcolor="#IIF(((CurrentRow MOD 2) is 0),de('EFEFEF'),de('FFFFFF'))#"><cfif StateCode EQ ''><b>#State#</b><cfelse>#State# (#StateCode#):</cfif></td>
						<td width="40%"><input type="text" name="T_Rate" value="#T_Rate#" class="cfAdminDefault" size="5" onChange="updateInfo('#SID#',this.value,'T_Rate','States');"></td>
					</tr>
				</cfform>
			</cfoutput>
			</table>
		</td>
		<td></td>
	</tr>
	<tr>
		<td colspan="5" height="5"><img src="images/spacer.gif" width="1" height="5"></td>
	</tr>
	<tr>
		<td colspan="4" align="center">
			<input type="button" name="GoBack" value="<< GO BACK" alt="Go Back To Configuration Screen" class="cfAdminButton"
				onClick="document.location.href='Configuration.cfm'">
			<input type="button" name="ReturnHome" value="RETURN HOME >>" alt="Go To Home Page" class="cfAdminButton"
				onClick="document.location.href='home.cfm'">
		</td>
		<td></td>
	</tr>
</table>

<cfinclude template="LayoutAdminFooter.cfm">