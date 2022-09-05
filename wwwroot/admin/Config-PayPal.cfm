<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<!--- BEGIN: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->
<cfif isDefined('Form.UpdatePayPal') AND Form.PPID NEQ ''>
	<cfif isUserInRole('Administrator')>
		
		<!--- INSERT NEW PAYPAL INFO --->
		<cfif isDefined('Form.New') AND Form.New EQ 1 >
			<cfinsert datasource="#application.dsn#" tablename="PGPayPal" 
				formfields="PayPalAccount, PayPalLogo">
		<!--- UPDATE EXISTING PAYPAL INFO --->
		<cfelse>
			<cfupdate datasource="#application.dsn#" tablename="PGPayPal" 
				formfields="PPID, PayPalAccount, PayPalLogo">
		</cfif>
		
		<cfset AdminMsg = 'PayPal Information Updated Successfully' >

	<cfelse>
		<SCRIPT LANGUAGE="JavaScript">
			{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
		</SCRIPT>
	</cfif>
	
</cfif>
<!--- END: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<cfquery name="getPayPalInfo" datasource="#application.dsn#" cachedwithin="#CreateTimeSpan(-7,0,0,0)#">
	SELECT	*
	FROM	PGPayPal
</cfquery>

<!--- HEADER --->
<cfscript>
	PageTitle = 'PAYPAL CONFIGURATION';
	AddAButton = 'RETURN TO CONFIGURATION' ;
	AddAButtonLoc = 'Configuration.cfm' ;
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">

<div style="padding:10px;"><img src="images/logos/logo-pgPayPal.gif"></div>

<table width="60%" cellpadding="3" cellspacing="0" border="0">
	<tr height="20" style="background-color:##65ADF1;">
		<td class="cfAdminHeader2" width="50%" nowrap>PayPal Account ID/Email Address*</td>
		<td class="cfAdminHeader2" width="50%" nowrap>PayPal Logo</td>
	</tr>
	<cfif getPayPalInfo.RecordCount NEQ 0 >
		<cfoutput query="getPayPalInfo">
		<cfform action="Config-PayPal.cfm" method="post">
			<tr>
				<td nowrap><cfinput type="text" name="PayPalAccount" value="#getPayPalInfo.PayPalAccount#" size="35" class="cfAdminDefault" required="yes" message="PayPal Account Required" ></td>
				<td nowrap>admin/images/logos/<cfinput type="text" name="PayPalLogo" value="#getPayPalInfo.PayPalLogo#" size="25" class="cfAdminDefault" required="no"  ></td>
			</tr>
			<tr><td height="1" colspan="10" style="background-color:##CCCCCC;"></td></tr>
			<tr><td height="10" colspan="10"></td></tr>
			<tr>
				<td width="100%" colspan="4" align="center">
					<input type="hidden" name="PPID" value="#getPayPalInfo.PPID#">
					<input type="submit" name="UpdatePayPal" value="UPDATE PAYPAL" alt="Update PayPal Account Information" class="cfAdminButton"
						onClick="return confirm('Are you sure you want to UPDATE PAYPAL ACCOUNT INFORMATION with the changes you have made?')">
				</td>
			</tr>
		</cfform>
		</cfoutput>
	<cfelse>
		<cfoutput>
		<cfform action="Config-PayPal.cfm" method="post">
			<tr>
				<td nowrap><cfinput type="text" name="PayPalAccount" value="" size="35" class="cfAdminDefault" required="yes" message="PayPal Account Required" ></td>
				<td nowrap>admin/images/logos/<cfinput type="text" name="PayPalLogo" value="" size="25" class="cfAdminDefault" required="no"  ></td>
			</tr>
			<tr><td height="1" colspan="10" style="background-color:##CCCCCC;"></td></tr>
			<tr><td height="10" colspan="10"></td></tr>
			<tr>
				<td width="100%" colspan="4" align="center">
					<input type="hidden" name="PPID" value="1">
					<input type="hidden" name="New" value="1">
					<input type="submit" name="UpdatePayPal" value="UPDATE PAYPAL" alt="Update PayPal Account Information" class="cfAdminButton"
						onClick="return confirm('Are you sure you want to UPDATE PAYPAL ACCOUNT INFORMATION with the changes you have made?')">
				</td>
			</tr>
		</cfform>
		</cfoutput>
	</cfif>
	<tr>
		<td colspan="2">* Required</td>
	</tr>
</table>

<cfinclude template="LayoutAdminFooter.cfm">