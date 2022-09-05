<!--- BEGIN: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->
<cfif isDefined('form.UpdateDefaults') AND IsDefined("Form.SiteID") AND Form.SiteID NEQ ''>
	<cfif isUserInRole('Administrator')>
		<cfupdate datasource="#application.dsn#" tablename="Config" 
			formfields="SiteID, DefaultShipRateDom, DefaultShipRateInt, DefaultShipRateOver">
		<cfset AdminMsg = 'Default Rates Updated Successfully' >
	<cfelse>
		<script language="JavaScript">
			{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
		</script>
	</cfif>
<cfelseif isDefined('form.UpdateUSPS') AND IsDefined("Form.SCID") AND Form.SCID NEQ ''>
	<cfif isUserInRole('Administrator')>
		<cfif Form.NewRecord NEQ 1 >
			<cfupdate datasource="#application.dsn#" tablename="ShippingCompanies" 
				formfields="SCID, USPSUserID, USPSPassword">
		<cfelse>
			<cfinsert datasource="#application.dsn#" tablename="ShippingCompanies" 
				formfields="SCID, USPSUserID, USPSPassword">
		</cfif>
		<cfset AdminMsg = 'USPS Account Updated Successfully' >
	<cfelse>
		<script language="JavaScript">
			{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
		</script>
	</cfif>
<cfelseif isDefined('form.UpdateUPS') AND IsDefined("Form.SCID") AND Form.SCID NEQ ''>
	<cfif isUserInRole('Administrator')>
		<cfif Form.NewRecord NEQ 1 >
			<cfupdate datasource="#application.dsn#" tablename="ShippingCompanies" 
				formfields="SCID, UPSAccountNum, UPSAccessKey, UPSUserID, UPSPassword">
		<cfelse>
			<cfinsert datasource="#application.dsn#" tablename="ShippingCompanies" 
				formfields="SCID, UPSAccountNum, UPSAccessKey, UPSUserID, UPSPassword">
		</cfif>
		<cfset AdminMsg = 'UPS Online Tools Account Updated Successfully' >
	<cfelse>
		<script language="JavaScript">
			{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
		</script>
	</cfif>
<cfelseif isDefined('form.UpdateFEDEX') AND IsDefined("Form.SCID") AND Form.SCID NEQ ''>
	<cfif isUserInRole('Administrator')>
		<cfif Form.NewRecord NEQ 1 >
			<cfupdate datasource="#application.dsn#" tablename="ShippingCompanies" 
				formfields="SCID, FEDEXAccountNum, FEDEXIdentifier, FEDEXTestGateway, FEDEXProdGateway">
		<cfelse>
			<cfinsert datasource="#application.dsn#" tablename="ShippingCompanies" 
				formfields="SCID, FEDEXAccountNum, FEDEXIdentifier, FEDEXTestGateway, FEDEXProdGateway">
		</cfif>
		<cfset AdminMsg = 'FedEx Ship Manager Account Updated Successfully' >
	<cfelse>
		<script language="JavaScript">
			{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
		</script>
	</cfif>
</cfif>
<!--- END: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<!--- BEGIN: QUERIES ------------------------------------------------------------->
<!--- RE-QUERY config --->
<cfquery name="config" datasource="#application.dsn#" cachedwithin="#CreateTimeSpan(-7,0,0,0)#">
	SELECT 	*
	FROM	Config
	WHERE	SiteID = #application.SiteID#
</cfquery>
<!--- RE-QUERY config --->
<cfinvoke component="#Queries#" method="getShippingMethods" returnvariable="getShippingMethods"></cfinvoke>
<cfinvoke component="#Queries#" method="getShippingCos" returnvariable="getShippingCos">
	<cfinvokeargument name="SiteID" value="#application.SiteID#">
</cfinvoke>

<cfquery name="getShippingUSPS" datasource="#application.dsn#">
	SELECT	*
	FROM	ShippingMethods
	WHERE	ShippingCompany = 'USPS'	
</cfquery>
<cfquery name="getShippingUPS" datasource="#application.dsn#">
	SELECT	*
	FROM	ShippingMethods
	WHERE	ShippingCompany = 'UPS'	
</cfquery>
<cfquery name="getShippingFEDEX" datasource="#application.dsn#">
	SELECT	*
	FROM	ShippingMethods
	WHERE	ShippingCompany = 'FEDEX'	
</cfquery>
<!--- END: QUERIES --------------------------------------------------------------->

<!--- HEADER --->
<cfscript>
	PageTitle = 'REAL-TIME SHIPPING CONFIGURATION';
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">

<!--- DEFAULTS --->
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr height="20" style="background-color:##65ADF1;">
		<td width="3%"  class="cfAdminHeader1">&nbsp;</td>
		<td width="15%" class="cfAdminHeader1">&nbsp; Default Domestic Ship Rate</td>
		<td width="15%" class="cfAdminHeader1">Default Int'l Ship Rate</td>
		<td width="15%" class="cfAdminHeader1">Default Overweight Ship Rate</td>
		<td width="52%" class="cfAdminHeader1"></td>
	</tr>
	<cfoutput>
	<tr>
		<cfform action="Config-ShipByCalc.cfm" method="post">
		<td align="center">
			<input type="submit" name="UpdateDefaults" value="UPDATE" alt="Update Default Calculation Rates" class="cfAdminButton">&nbsp;
		</td>
		<td>$<cfinput type="text" name="DefaultShipRateDom" value="#DecimalFormat(application.DefaultShipRateDom)#" size="10" class="cfAdminDefault" required="yes" message="Please enter a Default Domestice Shipping Rate for unsucessful real-time calculations."> </td>
		<td>$<cfinput type="text" name="DefaultShipRateInt" value="#DecimalFormat(application.DefaultShipRateInt)#" size="10" class="cfAdminDefault" required="yes" message="Please enter a Default International Shipping Rate for unsucessful real-time calculations."> </td>
		<td>$<cfinput type="text" name="DefaultShipRateOver" value="#DecimalFormat(application.DefaultShipRateOver)#" size="10" class="cfAdminDefault" required="yes" message="Please enter a Default Shipping Rate for orders over 150 lbs."> </td>
		<td></td>
		<input type="hidden" name="SiteID" value="#application.SiteID#">
		</cfform>
	</tr>
	</cfoutput>
</table>

<br>

<!--- USPS --->
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="5" height="20"><img src="images/spacer.gif" width="1" height="20"></td>
	</tr>
	<tr>
		<td colspan="6"><img src="images/Logos/logo-USPS.jpg" vspace="5"></td>
	</tr>
	<tr height="20" style="background-color:##65ADF1;">
		<td width="3%"  class="cfAdminHeader1"></td>
		<td width="15%" class="cfAdminHeader1">&nbsp; User ID</td>
		<td width="15%" class="cfAdminHeader1">Password</td>
		<td width="67%" class="cfAdminHeader1" colspan="3"></td>
	</tr>
	<cfoutput>
	<tr>
		<form action="Config-ShipByCalc.cfm" method="post">
		<td align="center">
			<input type="submit" name="UpdateUSPS" value="UPDATE" alt="Update USPS Account Info" class="cfAdminButton"
				onclick="return confirm('Are you sure you want to UPDATE USPS Account Info with the changes you have made?')">&nbsp;
		</td>
		<td><input type="text" name="USPSUserID" value="#getShippingCos.USPSUserID#" size="20" class="cfAdminDefault"> </td>
		<td><input type="text" name="USPSPassword" value="#getShippingCos.USPSPassword#" size="20" class="cfAdminDefault"> </td>
		<td colspan="3"></td>
		<cfif getShippingCos.SCID NEQ '' >
			<input type="hidden" name="NewRecord" value="0">
			<input type="hidden" name="SCID" value="#getShippingCos.SCID#">
		<cfelse>
			<input type="hidden" name="NewRecord" value="1">
			<input type="hidden" name="SCID" value="1">
		</cfif>
		</form>
	</tr>
	</cfoutput>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="5" height="20"><img src="images/spacer.gif" width="1" height="20"></td>
	</tr>
	<tr height="20" style="background-color:##7DBF0E;">
		<td width="18%" class="cfAdminHeader2">&nbsp;Service</td>
		<td width="12%" class="cfAdminHeader2">Allow</td>
		<td width="18%" class="cfAdminHeader2">Service</td>
		<td width="12%" class="cfAdminHeader2">Allow</td>
		<td width="40%" class="cfAdminHeader2">&nbsp;</td>
	</tr>
	<tr>
		<td valign="top" colspan="2">
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<cfoutput query="getShippingUSPS" startrow="1" maxrows="9">
				<cfform action="Config-ShipByCalc.cfm" method="post">
					<tr>
						<td width="60%" bgcolor="#IIF(((CurrentRow MOD 2) is 0),de('EFEFEF'),de('FFFFFF'))#">#ShippingMessage#</td>
						<td width="40%">
							<input type="checkbox" name="Allow" onchange="updateInfo('#SMID#',this.value,'Allow','ShippingMethods');" <cfif Allow EQ 1 > checked </cfif> >
						</td>
					</tr>
				</cfform>
			</cfoutput>
			</table>
		</td>
		<td valign="top" colspan="2">
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<cfoutput query="getShippingUSPS" startrow="10" maxrows="8">
				<cfform action="Config-ShipByCalc.cfm" method="post">
					<tr>
						<td width="60%" bgcolor="#IIF(((CurrentRow MOD 2) is 0),de('EFEFEF'),de('FFFFFF'))#">#ShippingMessage#</td>
						<td width="40%">
							<input type="checkbox" name="Allow" onchange="updateInfo('#SMID#',this.value,'Allow','ShippingMethods');" <cfif Allow EQ 1 > checked </cfif> >
						</td>
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
</table>
	
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr><td height="1" colspan="5"><img src="images/image-LineGray.gif" width="100%" height="1"></td></tr>
	<tr><td height="1" colspan="5"><img src="images/image-LineWhite.gif" width="100%" height="1"></td></tr>
	<tr><td height="1" colspan="5"><img src="images/image-LineGray.gif" width="100%" height="1"></td></tr>
</table>

<!--- UPS --->
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="5" height="20"><img src="images/spacer.gif" width="1" height="20"></td>
	</tr>
	<tr>
		<td colspan="6"><img src="images/Logos/logo-UPSmed.gif" vspace="5"></td>
	</tr>
	<tr height="20" style="background-color:##65ADF1;">
		<td width="3%"  class="cfAdminHeader1"></td>
		<td width="15%" class="cfAdminHeader1">&nbsp; Account #</td>
		<td width="15%" class="cfAdminHeader1">Access Key</td>
		<td width="15%" class="cfAdminHeader1">User ID</td>
		<td width="15%" class="cfAdminHeader1">Password</td>
		<td width="37%" class="cfAdminHeader1"></td>
	</tr>
	<cfoutput>
	<tr>
		<form action="Config-ShipByCalc.cfm" method="post">
		<td align="center">
			<input type="submit" name="UpdateUPS" value="UPDATE" alt="Update UPS Online Tools Account Info" class="cfAdminButton"
				onclick="return confirm('Are you sure you want to UPDATE UPS Online Tools Account Info with the changes you have made?')">&nbsp;
		</td>
		<td><input type="text" name="UPSAccountNum" value="#getShippingCos.UPSAccountNum#" size="20" class="cfAdminDefault"> </td>
		<td><input type="text" name="UPSAccessKey" value="#getShippingCos.UPSAccessKey#" size="20" class="cfAdminDefault"> </td>
		<td><input type="text" name="UPSUserID" value="#getShippingCos.UPSUserID#" size="20" class="cfAdminDefault"> </td>
		<td><input type="text" name="UPSPassword" value="#getShippingCos.UPSPassword#" size="20" class="cfAdminDefault"> </td>
		<td></td>
		<cfif getShippingCos.SCID NEQ '' >
			<input type="hidden" name="NewRecord" value="0">
			<input type="hidden" name="SCID" value="#getShippingCos.SCID#">
		<cfelse>
			<input type="hidden" name="NewRecord" value="1">
			<input type="hidden" name="SCID" value="1">
		</cfif>
		</form>
	</tr>
	</cfoutput>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="5" height="20"><img src="images/spacer.gif" width="1" height="20"></td>
	</tr>
	<tr height="20" style="background-color:##7DBF0E;">
		<td width="18%" class="cfAdminHeader2">&nbsp;Service</td>
		<td width="12%" class="cfAdminHeader2">Allow</td>
		<td width="18%" class="cfAdminHeader2">Service</td>
		<td width="12%" class="cfAdminHeader2">Allow</td>
		<td width="40%" class="cfAdminHeader2">&nbsp;</td>
	</tr>
	<tr>
		<td valign="top" colspan="2">
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<cfoutput query="getShippingUPS" startrow="1" maxrows="6">
				<cfform action="Config-ShipByCalc.cfm" method="post">
					<tr>
						<td width="60%" bgcolor="#IIF(((CurrentRow MOD 2) is 0),de('EFEFEF'),de('FFFFFF'))#">#ShippingMessage#</td>
						<td width="40%">
							<input type="checkbox" name="Allow" onchange="updateInfo('#SMID#',this.value,'Allow','ShippingMethods');" <cfif Allow EQ 1 > checked </cfif> >
						</td>
					</tr>
				</cfform>
			</cfoutput>
			</table>
		</td>
		<td valign="top" colspan="2">
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<cfoutput query="getShippingUPS" startrow="7" maxrows="6">
				<cfform action="Config-ShipByCalc.cfm" method="post">
					<tr>
						<td width="60%" bgcolor="#IIF(((CurrentRow MOD 2) is 0),de('EFEFEF'),de('FFFFFF'))#">#ShippingMessage#</td>
						<td width="40%">
							<input type="checkbox" name="Allow" onchange="updateInfo('#SMID#',this.value,'Allow','ShippingMethods');" <cfif Allow EQ 1 > checked </cfif> >
						</td>
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
</table>
	
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr><td height="1" colspan="5"><img src="images/image-LineGray.gif" width="100%" height="1"></td></tr>
	<tr><td height="1" colspan="5"><img src="images/image-LineWhite.gif" width="100%" height="1"></td></tr>
	<tr><td height="1" colspan="5"><img src="images/image-LineGray.gif" width="100%" height="1"></td></tr>
</table>

<!--- FEDEX --->
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="5" height="20"><img src="images/spacer.gif" width="1" height="20"></td>
	</tr>
	<tr>
		<td colspan="6"><img src="images/Logos/logo-FEDEX.gif" vspace="5"></td>
	</tr>
	<tr height="20" style="background-color:##65ADF1;">
		<td width="3%"  class="cfAdminHeader1"></td>
		<td width="15%" class="cfAdminHeader1">&nbsp; Account #</td>
		<td width="15%" class="cfAdminHeader1">Identifier</td>
		<td width="30%" class="cfAdminHeader1">Test Gateway</td>
		<td width="30%" class="cfAdminHeader1">Production Gateway</td>
		<td width="7%"  class="cfAdminHeader1"></td>
	</tr>
	<cfoutput>
	<tr>
		<form action="Config-ShipByCalc.cfm" method="post">
		<td align="center">
			<input type="submit" name="UpdateFEDEX" value="UPDATE" alt="Update FedEx Ship Manager Account Info" class="cfAdminButton"
				onclick="return confirm('Are you sure you want to UPDATE FedEx Ship Manager Account Info with the changes you have made?')">&nbsp;
		</td>
		<td><input type="text" name="FEDEXAccountNum" value="#getShippingCos.FEDEXAccountNum#" size="20" class="cfAdminDefault"> </td>
		<td><input type="text" name="FEDEXIdentifier" value="#getShippingCos.FEDEXIdentifier#" size="20" class="cfAdminDefault"> </td>
		<td><input type="text" name="FEDEXTestGateway" value="#getShippingCos.FEDEXTestGateway#" size="47" class="cfAdminDefault"> </td>
		<td><input type="text" name="FEDEXProdGateway" value="#getShippingCos.FEDEXProdGateway#" size="47" class="cfAdminDefault"> </td>
		<td></td>
		<cfif getShippingCos.SCID NEQ '' >
			<input type="hidden" name="NewRecord" value="0">
			<input type="hidden" name="SCID" value="#getShippingCos.SCID#">
		<cfelse>
			<input type="hidden" name="NewRecord" value="1">
			<input type="hidden" name="SCID" value="1">
		</cfif>
		</form>
	</tr>
	</cfoutput>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="5" height="20"><img src="images/spacer.gif" width="1" height="20"></td>
	</tr>
	<tr height="20" style="background-color:##7DBF0E;">
		<td width="18%" class="cfAdminHeader2">&nbsp;Service</td>
		<td width="12%" class="cfAdminHeader2">Allow</td>
		<td width="18%" class="cfAdminHeader2">Service</td>
		<td width="12%" class="cfAdminHeader2">Allow</td>
		<td width="40%" class="cfAdminHeader2">&nbsp;</td>
	</tr>
	<tr>
		<td valign="top" colspan="2">
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<cfoutput query="getShippingFEDEX" startrow="1" maxrows="8">
				<cfform action="Config-ShipByCalc.cfm" method="post">
					<tr>
						<td width="60%" bgcolor="#IIF(((CurrentRow MOD 2) is 0),de('EFEFEF'),de('FFFFFF'))#">#ShippingMessage#</td>
						<td width="40%">
							<input type="checkbox" name="Allow" onchange="updateInfo('#SMID#',this.value,'Allow','ShippingMethods');" <cfif Allow EQ 1 > checked </cfif> >
						</td>
					</tr>
				</cfform>
			</cfoutput>
			</table>
		</td>
		<td valign="top" colspan="2">
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<cfoutput query="getShippingFEDEX" startrow="9" maxrows="7">
				<cfform action="Config-ShipByCalc.cfm" method="post">
					<tr>
						<td width="60%" bgcolor="#IIF(((CurrentRow MOD 2) is 0),de('EFEFEF'),de('FFFFFF'))#">#ShippingMessage#</td>
						<td width="40%">
							<input type="checkbox" name="Allow" onchange="updateInfo('#SMID#',this.value,'Allow','ShippingMethods');" <cfif Allow EQ 1 > checked </cfif> >
						</td>
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
</table>
	
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr><td height="1" colspan="5"><img src="images/image-LineGray.gif" width="100%" height="1"></td></tr>
	<tr><td height="1" colspan="5"><img src="images/image-LineWhite.gif" width="100%" height="1"></td></tr>
	<tr><td height="1" colspan="5"><img src="images/image-LineGray.gif" width="100%" height="1"></td></tr>
</table>

<!--- NAVIGATION --->
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="5" height="20"><img src="images/spacer.gif" width="1" height="20"></td>
	</tr>
	<tr>
		<td colspan="4" align="center">
			<input type="button" name="GoBack" value="<< GO BACK" alt="Go Back To Configuration Screen" class="cfAdminButton"
				onclick="document.location.href='Config-Shipping.cfm'">
			<input type="button" name="ReturnHome" value="RETURN HOME >>" alt="Go To Home Page" class="cfAdminButton"
				onclick="document.location.href='home.cfm'">
		</td>
		<td></td>
	</tr>
</table>

<cfinclude template="LayoutAdminFooter.cfm">