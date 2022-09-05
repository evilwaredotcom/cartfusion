<!--- BEGIN: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->
<!--- AUTHORIZE.NET UPDATE --->
<cfif isDefined('Form.UpdatePG') AND isDefined('Form.IDAN') AND Form.IDAN NEQ '' AND Form.IDANTK NEQ ''>
	<cfif isUserInRole('Administrator')>
		
		<cfscript>
			// encrypt info
			if ( Form.Login NEQ '' )	Form.Login = ENCRYPT(Form.Login, application.CryptKey, "CFMX_COMPAT", "Hex") ;
			else Form.Login = '' ;
			if ( Form.TransKey NEQ '' ) Form.TransKey = ENCRYPT(Form.TransKey, application.CryptKey, "CFMX_COMPAT", "Hex") ;
			else Form.TransKey = '' ;
			if ( Form.Hash NEQ '' )	 Form.Hash = ENCRYPT(Form.Hash, application.CryptKey, "CFMX_COMPAT", "Hex") ;
			else Form.Hash = '' ;
			if ( Form.Password NEQ '' ) Form.Password = ENCRYPT(Form.Password, application.CryptKey, "CFMX_COMPAT", "Hex") ;
			else Form.Password = '' ;
			// match IDs and set the update value
			if ( Form.IDAN EQ Form.IDANTK )
				Form.ID = Form.IDAN ;
			else
				Form.ID = '' ;
		</cfscript>
		
		<!--- INSERT NEW AUTHORIZE.NET ACCOUNT INFO --->
		<cfif isDefined('Form.New') AND Form.New EQ 1 >
			<cfinsert datasource="#application.dsn#" tablename="AuthorizeNet" 
				formfields="Login, Hash">
			<cfinsert datasource="#application.dsn#" tablename="AuthorizeNetTK" 
				formfields="TransKey, Password">
			<cfupdate datasource="#application.dsn#" tablename="config"
				formfields="SiteID, RealtimePayments">
		<!--- UPDATE EXISTING AUTHORIZE.NET ACCOUNT INFO --->
		<cfelse>
			<cfupdate datasource="#application.dsn#" tablename="AuthorizeNet" 
				formfields="ID, Login, Hash">
			<cfupdate datasource="#application.dsn#" tablename="AuthorizeNetTK" 
				formfields="ID, TransKey, Password">
			<cfupdate datasource="#application.dsn#" tablename="config"
				formfields="SiteID, RealtimePayments">
		</cfif>

<!--- RE-QUERY config --->
<cfquery name="config" datasource="#application.dsn#" cachedwithin="#CreateTimeSpan(-7,0,0,0)#">
	SELECT 	*
	FROM	Config
	WHERE	SiteID = #application.SiteID#
</cfquery>
<!--- RE-QUERY config --->

		<cfset AdminMsg = 'Payment Gateway Information Updated Successfully' >

	<cfelse>
		<SCRIPT LANGUAGE="JavaScript">
			{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
		</SCRIPT>
	</cfif>

<!--- USAePay UPDATE --->
<cfelseif isDefined('Form.UpdatePG') AND isDefined('Form.IDUSAePay') AND Form.IDUSAePay NEQ ''>
	<cfif isUserInRole('Administrator')>
		
		<cfscript>
			// Encrypt Info
			if ( Form.TransKey NEQ '' ) Form.TransKey = ENCRYPT(Form.TransKey, application.CryptKey, "CFMX_COMPAT", "Hex") ;
			else Form.TransKey = '' ;
			// Set ID
			Form.ID = Form.IDUSAePay ;
		</cfscript>
		
		<!--- INSERT NEW AUTHORIZE.NET ACCOUNT INFO --->
		<cfif isDefined('Form.New') AND Form.New EQ 1 >
			<cfinsert datasource="#application.dsn#" tablename="USAePay" 
				formfields="TransKey">
		<!--- UPDATE EXISTING AUTHORIZE.NET ACCOUNT INFO --->
		<cfelse>
			<cfupdate datasource="#application.dsn#" tablename="USAePay" 
				formfields="ID, TransKey">
		</cfif>
		
		<cfset AdminMsg = 'Payment Gateway Information Updated Successfully' >

	<cfelse>
		<SCRIPT LANGUAGE="JavaScript">
			{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
		</SCRIPT>
	</cfif>
	

<!--- PayFlowLink UPDATE --->
<cfelseif isDefined('Form.UpdatePG') AND isDefined('Form.IDPFL') AND Form.IDPFL NEQ ''>
	<cfif isUserInRole('Administrator')>
		
		<cfscript>
			// Encrypt Info
			if ( Form.Login NEQ '' ) Form.Login = ENCRYPT(Form.Login, application.CryptKey, "CFMX_COMPAT", "Hex") ;
			else Form.Login = '' ;
			if ( Form.Partner NEQ '' ) Form.Partner = ENCRYPT(Form.Partner, application.CryptKey, "CFMX_COMPAT", "Hex") ;
			else Form.Partner = '' ;
			// Set ID
			Form.ID = Form.IDPFL ;
		</cfscript>
		
		<!--- INSERT NEW AUTHORIZE.NET ACCOUNT INFO --->
		<cfif isDefined('Form.New') AND Form.New EQ 1 >
			<cfinsert datasource="#application.dsn#" tablename="PayFlowLink" 
				formfields="Login, Partner">
		<!--- UPDATE EXISTING AUTHORIZE.NET ACCOUNT INFO --->
		<cfelse>
			<cfupdate datasource="#application.dsn#" tablename="PayFlowLink" 
				formfields="ID, Login, Partner">
		</cfif>
		
		<cfset AdminMsg = 'Payment Gateway Information Updated Successfully' >

	<cfelse>
		<SCRIPT LANGUAGE="JavaScript">
			{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
		</SCRIPT>
	</cfif>
	
	
<!--- YourPay API UPDATE --->
<cfelseif isDefined('Form.UpdatePG') AND isDefined('Form.IDYP') AND Form.IDYP NEQ ''>
	<cfif isUserInRole('Administrator')>
		
		<cfscript>
			// Encrypt Info
			// if ( Form.Login NEQ '' ) Form.Login = ENCRYPT(Form.Login, application.CryptKey, "CFMX_COMPAT", "Hex") ;
			// else Form.Login = '' ;
			// if ( Form.Partner NEQ '' ) Form.Partner = ENCRYPT(Form.Partner, application.CryptKey, "CFMX_COMPAT", "Hex") ;
			// else Form.Partner = '' ;
			if ( NOT isDefined('Form.LiveMode') )
				Form.LiveMode = 0 ;
			if ( NOT isDefined('Form.InUse') )
				Form.InUse = 0 ;
			// Set ID
			Form.ID = Form.IDYP ;
		</cfscript>
		
		<!--- INSERT NEW AUTHORIZE.NET ACCOUNT INFO --->
		<cfif isDefined('Form.New') AND Form.New EQ 1 >
			<cfinsert datasource="#application.dsn#" tablename="PGYourPayAPI" 
				formfields="StoreNumber, PEMFileLocation, LiveMode, InUse">
			<cfupdate datasource="#application.dsn#" tablename="config"
				formfields="SiteID, RealtimePayments">
		<!--- UPDATE EXISTING AUTHORIZE.NET ACCOUNT INFO --->
		<cfelse>
			<cfupdate datasource="#application.dsn#" tablename="PGYourPayAPI" 
				formfields="ID, StoreNumber, PEMFileLocation, LiveMode, InUse">
			<cfupdate datasource="#application.dsn#" tablename="config"
				formfields="SiteID, RealtimePayments">
		</cfif>

<!--- RE-QUERY config --->
<cfquery name="config" datasource="#application.dsn#" cachedwithin="#CreateTimeSpan(-7,0,0,0)#">
	SELECT 	*
	FROM	Config
	WHERE	SiteID = #application.SiteID#
</cfquery>
<!--- RE-QUERY config --->
		
		<cfset AdminMsg = 'Payment Gateway Information Updated Successfully' >

	<cfelse>
		<SCRIPT LANGUAGE="JavaScript">
			{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
		</SCRIPT>
	</cfif>
	
</cfif>
<!--- END: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<!--- HEADER --->
<cfscript>
	PageTitle = 'PAYMENT SYSTEM';
	AddAButton = 'RETURN TO CONFIGURATION' ;
	AddAButtonLoc = 'Configuration.cfm' ;
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">

<!--- NO PAYMENT GATEWAY --->
<cfif application.PaymentSystem EQ 1 >
	<div class="cfAdminDefault">
		<br><br>
		<b>No payment gateway has been configured.</b><br><br>
		- Go back to CONFIGURATION<br>
		- SELECT a payment gateway<br>
		- UPDATE CHANGES<br>
		- Click SETUP again
	</div>
	
	
<!--- AUTHORIZE.NET --->
<cfelseif application.PaymentSystem EQ 2 >
	<cfinvoke component="#application.Queries#" method="getAN" returnvariable="getAN">
		<cfinvokeargument name="SiteID" value="#application.SiteID#">
	</cfinvoke>
	<cfinvoke component="#application.Queries#" method="getANTK" returnvariable="getANTK">
		<cfinvokeargument name="SiteID" value="#application.SiteID#">
	</cfinvoke>
	
	<cfscript>
		if ( isDefined('getAN.Login') AND getAN.Login NEQ '' ) decrypted_LOGIN = DECRYPT(getAN.Login, application.CryptKey, "CFMX_COMPAT", "Hex") ;
		else decrypted_LOGIN = '' ;
		if ( isDefined('getANTK.TransKey') AND getANTK.TransKey NEQ '' ) decrypted_TK = DECRYPT(getANTK.TransKey, application.CryptKey, "CFMX_COMPAT", "Hex") ;
		else decrypted_TK = '' ;
		if ( isDefined('getAN.Hash') AND getAN.Hash NEQ '' ) decrypted_HASH = DECRYPT(getAN.Hash, application.CryptKey, "CFMX_COMPAT", "Hex") ;
		else decrypted_HASH = '' ;
		if ( isDefined('getANTK.Password') AND getANTK.Password NEQ '' ) decrypted_PASS = DECRYPT(getANTK.Password, application.CryptKey, "CFMX_COMPAT", "Hex") ;
		else decrypted_PASS = '' ;
	</cfscript>
	
	<cfquery name="getPGLogo" datasource="#application.dsn#" cachedwithin="#CreateTimeSpan(7,0,0,0)#">
		SELECT	PSLogo
		FROM	PaymentSystems
		WHERE	PSID = #application.PaymentSystem#
	</cfquery>
	
	<cfif getPGLogo.PSLogo NEQ ''>
		<div style="padding:10px;"><img src="images/logos/<cfoutput>#getPGLogo.PSLogo#</cfoutput>"></div>
	</cfif>
	
	<table width="100%" cellpadding="3" cellspacing="0" border="0">
		<tr height="20" style="background-color:##65ADF1;">
			<td class="cfAdminHeader1" width="25%">Login *</td>
			<td class="cfAdminHeader1" width="25%">Password</td>
			<td class="cfAdminHeader1" width="25%">Transaction Key *</td>
			<td class="cfAdminHeader1" width="25%">MD5 Hash</td>
		</tr>
	
	<cfif getAN.RecordCount NEQ 0 >
		<cfoutput query="getAN">
		<cfform action="Config-PaymentSystem.cfm" method="post">
			<cfif isUserInRole('Administrator')>
			<tr>
				<td><cfinput type="text" name="Login"	value="#decrypted_LOGIN#" size="20" maxlength="50" class="cfAdminDefault" required="yes" message="Login Required" ></td>
				<td><cfinput type="text" name="Password" value="#decrypted_PASS#"  size="20" maxlength="50" class="cfAdminDefault" required="no"  ></td>
				<td><cfinput type="text" name="TransKey" value="#decrypted_TK#"	size="20" maxlength="50" class="cfAdminDefault" required="yes" message="Transaction Key Required" ></td>
				<td><cfinput type="text" name="Hash"	 value="#decrypted_HASH#"  size="20" maxlength="50" class="cfAdminDefault" required="no"  ></td>
			</tr>
			<cfelse>
			<tr>
				<td><cfinput type="text" name="Login"	value="Your Login"	size="20" maxlength="50" class="cfAdminDefault" required="yes" message="Login Required" onChange="alert('USER - #GetAuthUser()# - NOT PERMITTED TO PERFORM THE CHOSEN TASK');"></td>
				<td><cfinput type="text" name="Password" value="Your Password" size="20" maxlength="50" class="cfAdminDefault" required="no"  onChange="alert('USER - #GetAuthUser()# - NOT PERMITTED TO PERFORM THE CHOSEN TASK');"></td>
				<td><cfinput type="text" name="TransKey" value="Your Transaction Key"	size="20" maxlength="50" class="cfAdminDefault" required="yes" message="Transaction Key Required" onChange="alert('USER - #GetAuthUser()# - NOT PERMITTED TO PERFORM THE CHOSEN TASK');"></td>
				<td><cfinput type="text" name="Hash"	 value="Your Option Hash Value"  size="20" maxlength="50" class="cfAdminDefault" required="no"  onChange="alert('USER - #GetAuthUser()# - NOT PERMITTED TO PERFORM THE CHOSEN TASK');"></td>
			</tr>
			</cfif>
			<tr><td height="1" colspan="4" style="background-color:##CCCCCC;"></td></tr>
			<tr><td height="10" colspan="4"></td></tr>
			<tr height="20" style="background-color:##65ADF1;">
				<td class="cfAdminHeader1" colspan="4">Realtime Credit Card Processing</td>
			</tr>
			<tr>
				<td colspan="4">
					<input type="radio" name="RealtimePayments" value="0" class="cfAdminDefault" <cfif application.RealtimePayments EQ '' OR application.RealtimePayments EQ 0>checked</cfif>> None &nbsp;
					<input type="radio" name="RealtimePayments" value="1" class="cfAdminDefault" <cfif application.RealtimePayments EQ 1>checked</cfif>> Authorization Only &nbsp;
					<input type="radio" name="RealtimePayments" value="2" class="cfAdminDefault" <cfif application.RealtimePayments EQ 2>checked</cfif>> Authorization & Capture
				</td>
			</tr>
			<tr><td height="1" colspan="4" style="background-color:##CCCCCC;"></td></tr>
			<tr><td height="10" colspan="4"></td></tr>
			<tr>
				<td width="100%" colspan="4" align="center">
					<input type="hidden" name="IDAN"   value="#getAN.ID#">
					<input type="hidden" name="IDANTK" value="#getANTK.ID#">
					<input type="hidden" name="SiteID" value="#application.SiteID#">
					<input type="submit" name="UpdatePG" value="UPDATE PAYMENT GATEWAY" alt="Update Payment Gateway" class="cfAdminButton"
						onClick="return confirm('Are you sure you want to UPDATE AUTHORIZE.NET ACCOUNT with the changes you have made?')">
				</td>
			</tr>
		</cfform>
		</cfoutput>
	<cfelse>
		<cfoutput>
		<cfform action="Config-PaymentSystem.cfm" method="post">
			<cfif isUserInRole('Administrator')>
			<tr>
				<td><cfinput type="text" name="Login"	value="" size="20" maxlength="50" class="cfAdminDefault" required="yes" message="Login Required" ></td>
				<td><cfinput type="text" name="Password" value="" size="20" maxlength="50" class="cfAdminDefault" required="no"  ></td>
				<td><cfinput type="text" name="TransKey" value="" size="20" maxlength="50" class="cfAdminDefault" required="yes" message="Transaction Key Required" ></td>
				<td><cfinput type="text" name="Hash"	 value="" size="20" maxlength="50" class="cfAdminDefault" required="no"  ></td>
			</tr>
			<cfelse>
			<tr>
				<td><cfinput type="text" name="Login"	value="Your Login"	size="20" maxlength="50" class="cfAdminDefault" required="yes" message="Login Required" onChange="alert('USER - #GetAuthUser()# - NOT PERMITTED TO PERFORM THE CHOSEN TASK');"></td>
				<td><cfinput type="text" name="Password" value="Your Password" size="20" maxlength="50" class="cfAdminDefault" required="no"  onChange="alert('USER - #GetAuthUser()# - NOT PERMITTED TO PERFORM THE CHOSEN TASK');"></td>
				<td><cfinput type="text" name="TransKey" value="Your Transaction Key"	size="20" maxlength="50" class="cfAdminDefault" required="yes" message="Transaction Key Required" onChange="alert('USER - #GetAuthUser()# - NOT PERMITTED TO PERFORM THE CHOSEN TASK');"></td>
				<td><cfinput type="text" name="Hash"	 value="Your Option Hash Value"  size="20" maxlength="50" class="cfAdminDefault" required="no"  onChange="alert('USER - #GetAuthUser()# - NOT PERMITTED TO PERFORM THE CHOSEN TASK');"></td>
			</tr>
			</cfif>
			<tr><td height="1" colspan="4" style="background-color:##CCCCCC;"></td></tr>
			<tr><td height="10" colspan="4"></td></tr>
			<tr height="20" style="background-color:##65ADF1;">
				<td class="cfAdminHeader1" width="100%" colspan="4">Realtime Credit Card Processing</td>
			</tr>
			<tr>
				<td colspan="4">
					<input type="radio" name="RealtimePayments" value="0" class="cfAdminDefault" checked> None &nbsp;
					<input type="radio" name="RealtimePayments" value="1" class="cfAdminDefault" > Authorization Only &nbsp;
					<input type="radio" name="RealtimePayments" value="2" class="cfAdminDefault" > Authorization & Capture
				</td>
			</tr>
			<tr><td height="1" colspan="4" style="background-color:##CCCCCC;"></td></tr>
			<tr><td height="10" colspan="4"></td></tr>
			<tr>
				<td width="100%" colspan="4" align="center">
					<input type="hidden" name="IDAN"   value="1">
					<input type="hidden" name="IDANTK" value="1">
					<input type="hidden" name="New" value="1">
					<input type="hidden" name="SiteID" value="#application.SiteID#">
					<input type="submit" name="UpdatePG" value="UPDATE PAYMENT GATEWAY" alt="Update Payment Gateway" class="cfAdminButton"
						onClick="return confirm('Are you sure you want to UPDATE AUTHORIZE.NET ACCOUNT with the changes you have made?')">
				</td>
			</tr>
		</cfform>
		</cfoutput>
	</cfif>
		<tr>
			<td colspan="4">* Required</td>
		</tr>
	</table>



<!--- USAePay --->
<cfelseif application.PaymentSystem EQ 3 >
	<cfinvoke component="#application.Queries#" method="getUSAePay" returnvariable="getUSAePay">
		<cfinvokeargument name="SiteID" value="#application.SiteID#">
	</cfinvoke>
	
	<cfscript>
		if ( isDefined('getUSAePay.TransKey') AND getUSAePay.TransKey NEQ '' ) decrypted_TK = DECRYPT(getUSAePay.TransKey, application.CryptKey, "CFMX_COMPAT", "Hex") ;
		else decrypted_TK = '' ;
	</cfscript>
	
	<cfquery name="getPGLogo" datasource="#application.dsn#" cachedwithin="#CreateTimeSpan(7,0,0,0)#">
		SELECT	PSLogo
		FROM	PaymentSystems
		WHERE	PSID = #application.PaymentSystem#
	</cfquery>
	
	<cfif getPGLogo.PSLogo NEQ ''>
		<div style="padding:10px;"><img src="images/logos/<cfoutput>#getPGLogo.PSLogo#</cfoutput>"></div>
	</cfif>
	
	<table width="100%" cellpadding="3" cellspacing="0" border="0">
		<tr height="20" style="background-color:##65ADF1;">
			<td class="cfAdminHeader1" width="100%">Transaction Key *</td>
		</tr>
	
	<cfif getUSAePay.RecordCount NEQ 0 >
		<cfoutput query="getUSAePay">
		<cfform action="Config-PaymentSystem.cfm" method="post">
			<cfif isUserInRole('Administrator')>
			<tr>
				<td><cfinput type="text" name="TransKey" value="#decrypted_TK#" size="40" maxlength="50" class="cfAdminDefault" required="yes" message="Transaction Key Required" ></td>
			</tr>
			<cfelse>
			<tr>
				<td><cfinput type="text" name="TransKey" value="Your Transaction Key" size="40" maxlength="50" class="cfAdminDefault" required="yes" message="Transaction Key Required" onChange="alert('USER - #GetAuthUser()# - NOT PERMITTED TO PERFORM THE CHOSEN TASK');"></td>
			</tr>
			</cfif>
			<tr><td height="1" colspan="1" style="background-color:##CCCCCC;"></td></tr>
			<tr><td height="10" colspan="1"></td></tr>
			<tr>
				<td width="100%" colspan="1" align="center">
					<input type="hidden" name="IDUSAePay"   value="#getUSAePay.ID#">
					<input type="submit" name="UpdatePG" value="UPDATE PAYMENT GATEWAY" alt="Update Payment Gateway" class="cfAdminButton"
						onClick="return confirm('Are you sure you want to UPDATE USAePay ACCOUNT with the changes you have made?')">
				</td>
			</tr>
		</cfform>
		</cfoutput>
	<cfelse>
		<cfoutput>
		<cfform action="Config-PaymentSystem.cfm" method="post">
			<cfif isUserInRole('Administrator')>
			<tr>
				<td><cfinput type="text" name="TransKey" value="" size="40" maxlength="50" class="cfAdminDefault" required="yes" message="Transaction Key Required" ></td>
			</tr>
			<cfelse>
			<tr>
				<td><cfinput type="text" name="TransKey" value="Your Transaction Key" size="40" maxlength="50" class="cfAdminDefault" required="yes" message="Transaction Key Required" onChange="alert('USER - #GetAuthUser()# - NOT PERMITTED TO PERFORM THE CHOSEN TASK');"></td>
			</tr>
			</cfif>
			<tr><td height="1" colspan="1" style="background-color:##CCCCCC;"></td></tr>
			<tr><td height="10" colspan="1"></td></tr>
			<tr>
				<td width="100%" colspan="1" align="center">
					<input type="hidden" name="IDUSAePay" value="1">
					<input type="hidden" name="New" value="1">
					<input type="submit" name="UpdatePG" value="UPDATE PAYMENT GATEWAY" alt="Update Payment Gateway" class="cfAdminButton"
						onClick="return confirm('Are you sure you want to UPDATE USAePay ACCOUNT with the changes you have made?')">
				</td>
			</tr>
		</cfform>
		</cfoutput>
	</cfif>
		<tr>
			<td colspan="1">* Required</td>
		</tr>
	</table>


<!--- PayFlowLink --->
<cfelseif application.PaymentSystem EQ 4 >
	<cfinvoke component="#application.Queries#" method="getPFL" returnvariable="getPFL">
		<cfinvokeargument name="SiteID" value="#application.SiteID#">
	</cfinvoke>
	
	<cfscript>
		if ( isDefined('getPFL.Login') AND getPFL.Login NEQ '' ) decrypted_LOGIN = DECRYPT(getPFL.Login, application.CryptKey, "CFMX_COMPAT", "Hex") ;
		else decrypted_LOGIN = '' ;
		if ( isDefined('getPFL.Partner') AND getPFL.Partner NEQ '' ) decrypted_PARTNER = DECRYPT(getPFL.Partner, application.CryptKey, "CFMX_COMPAT", "Hex") ;
		else decrypted_PARTNER = '' ;
	</cfscript>
	
	<cfquery name="getPGLogo" datasource="#application.dsn#" cachedwithin="#CreateTimeSpan(7,0,0,0)#">
		SELECT	PSLogo
		FROM	PaymentSystems
		WHERE	PSID = #application.PaymentSystem#
	</cfquery>
	
	<cfif getPGLogo.PSLogo NEQ ''>
		<div style="padding:10px;"><img src="images/logos/<cfoutput>#getPGLogo.PSLogo#</cfoutput>"></div>
	</cfif>
	
	<table width="100%" cellpadding="3" cellspacing="0" border="0">
		<tr height="20" style="background-color:##65ADF1;">
			<td class="cfAdminHeader1" width="25%">Login *</td>
			<td class="cfAdminHeader1" width="25%">Partner *</td>
			<td class="cfAdminHeader1" width="50%"></td>
		</tr>
	
	<cfif getPFL.RecordCount NEQ 0 >
		<cfoutput query="getPFL">
		<cfform action="Config-PaymentSystem.cfm" method="post">
			<cfif isUserInRole('Administrator')>
			<tr>
				<td><cfinput type="text" name="Login"   value="#decrypted_LOGIN#"   size="20" maxlength="50" class="cfAdminDefault" required="yes" message="Login Required" ></td>
				<td><cfinput type="text" name="Partner" value="#decrypted_PARTNER#" size="20" maxlength="50" class="cfAdminDefault" required="yes" message="Partner Required"  ></td>
				<td></td>
			</tr>
			<cfelse>
			<tr>
				<td><cfinput type="text" name="Login"   value="Your Login"   size="20" maxlength="50" class="cfAdminDefault" required="yes" message="Login Required" onChange="alert('USER - #GetAuthUser()# - NOT PERMITTED TO PERFORM THE CHOSEN TASK');"></td>
				<td><cfinput type="text" name="Partner" value="Your Partner" size="20" maxlength="50" class="cfAdminDefault" required="yes" message="Partner Required"  onChange="alert('USER - #GetAuthUser()# - NOT PERMITTED TO PERFORM THE CHOSEN TASK');"></td>
				<td></td>
			</tr>
			</cfif>
			<tr><td height="1" colspan="3" style="background-color:##CCCCCC;"></td></tr>
			<tr><td height="10" colspan="3"></td></tr>
			<tr>
				<td width="100%" colspan="3" align="center">
					<input type="hidden" name="IDPFL"   value="#getPFL.ID#">
					<input type="submit" name="UpdatePG" value="UPDATE PAYMENT GATEWAY" alt="Update Payment Gateway" class="cfAdminButton"
						onClick="return confirm('Are you sure you want to UPDATE PAYFLOW LINK ACCOUNT with the changes you have made?')">
				</td>
			</tr>
		</cfform>
		</cfoutput>
	<cfelse>
		<cfoutput>
		<cfform action="Config-PaymentSystem.cfm" method="post">
			<cfif isUserInRole('Administrator')>
			<tr>
				<td><cfinput type="text" name="Login"   value=""  size="20" maxlength="50" class="cfAdminDefault" required="yes" message="Login Required" ></td>
				<td><cfinput type="text" name="Partner" value=""  size="20" maxlength="50" class="cfAdminDefault" required="yes" message="Partner Required"  ></td>
				<td></td>
			</tr>
			<cfelse>
			<tr>
				<td><cfinput type="text" name="Login"   value="Your Login"   size="20" maxlength="50" class="cfAdminDefault" required="yes" message="Login Required" onChange="alert('USER - #GetAuthUser()# - NOT PERMITTED TO PERFORM THE CHOSEN TASK');"></td>
				<td><cfinput type="text" name="Partner" value="Your Partner" size="20" maxlength="50" class="cfAdminDefault" required="yes" message="Partner Required"  onChange="alert('USER - #GetAuthUser()# - NOT PERMITTED TO PERFORM THE CHOSEN TASK');"></td>
				<td></td>
			</tr>
			</cfif>
			<tr><td height="1" colspan="3" style="background-color:##CCCCCC;"></td></tr>
			<tr><td height="10" colspan="3"></td></tr>
			<tr>
				<td width="100%" colspan="3" align="center">
					<input type="hidden" name="IDPFL"   value="1">
					<input type="hidden" name="New" value="1">
					<input type="submit" name="UpdatePG" value="UPDATE PAYMENT GATEWAY" alt="Update Payment Gateway" class="cfAdminButton"
						onClick="return confirm('Are you sure you want to UPDATE PAYFLOW LINK ACCOUNT with the changes you have made?')">
				</td>
			</tr>
		</cfform>
		</cfoutput>
	</cfif>
		<tr>
			<td colspan="3">* Required</td>
		</tr>
	</table>


<!--- YourPay API --->
<cfelseif application.PaymentSystem EQ 7 >
	<cfquery name="getYourPay" datasource="#application.dsn#">
		SELECT	*
		FROM	PGYourPayAPI
	</cfquery>
	
	<!---
	<cfscript>
		if ( isDefined('getUSAePay.TransKey') AND getUSAePay.TransKey NEQ '' ) decrypted_TK = DECRYPT(getUSAePay.TransKey, application.CryptKey, "CFMX_COMPAT", "Hex") ;
		else decrypted_TK = '' ;
	</cfscript>
	--->
	
	<cfquery name="getPGLogo" datasource="#application.dsn#" cachedwithin="#CreateTimeSpan(7,0,0,0)#">
		SELECT	PSLogo
		FROM	PaymentSystems
		WHERE	PSID = #application.PaymentSystem#
	</cfquery>
	
	<cfif getPGLogo.PSLogo NEQ ''>
		<div style="padding:10px;"><img src="images/logos/<cfoutput>#getPGLogo.PSLogo#</cfoutput>"></div>
	</cfif>
	
	<table width="100%" cellpadding="3" cellspacing="0" border="0">
		<tr height="20" style="background-color:##65ADF1;">
			<td class="cfAdminHeader1" width="25%">Store Number *</td>
			<td class="cfAdminHeader1" width="25%">PEM File Location *</td>
			<td class="cfAdminHeader1" width="25%" align="center">Live Mode *</td>
			<td class="cfAdminHeader1" width="25%" align="center">Use This One *</td>
		</tr>
	
	<cfif getYourPay.RecordCount NEQ 0 >
		<cfoutput query="getYourPay">
		<cfform action="Config-PaymentSystem.cfm" method="post">
			<cfif isUserInRole('Administrator')>
			<tr>
				<td><cfinput type="text" name="StoreNumber"   value="#StoreNumber#"   size="20" maxlength="50" class="cfAdminDefault" required="yes" message="Store Number Required" ></td>
				<td><cfinput type="text" name="PEMFileLocation" value="#PEMFileLocation#" size="80" maxlength="500" class="cfAdminDefault" required="yes" message="PEM File Location Required"  ></td>
				<td align="center"><input type="checkbox" name="LiveMode" <cfif LiveMode EQ 1 > checked </cfif> ></td>
				<td align="center"><input type="checkbox" name="InUse" <cfif InUse EQ 1 > checked </cfif> ></td>
			</tr>
			<cfelse>
			<tr>
				<td><cfinput type="text" name="StoreNumber"   value="Your Store Number"   size="20" maxlength="50" class="cfAdminDefault" required="yes" message="Store Number Required" onChange="alert('USER - #GetAuthUser()# - NOT PERMITTED TO PERFORM THE CHOSEN TASK');"></td>
				<td><cfinput type="text" name="PEMFileLocation" value="Your PEM File Location" size="80" maxlength="500" class="cfAdminDefault" required="yes" message="PEM File Location Required"  onChange="alert('USER - #GetAuthUser()# - NOT PERMITTED TO PERFORM THE CHOSEN TASK');"></td>
				<td align="center"><input type="checkbox" name="LiveMode" <cfif LiveMode EQ 1 > checked </cfif> ></td>
				<td align="center"><input type="checkbox" name="InUse" <cfif InUse EQ 1 > checked </cfif> ></td>
			</tr>
			</cfif>
			<tr><td height="1" colspan="4" style="background-color:##CCCCCC;"></td></tr>
			<tr><td height="10" colspan="4"></td></tr>
			<tr height="20" style="background-color:##65ADF1;">
				<td class="cfAdminHeader1" colspan="4">Realtime Credit Card Processing</td>
			</tr>
			<tr>
				<td colspan="4">
					<input type="radio" name="RealtimePayments" value="0" class="cfAdminDefault" <cfif application.RealtimePayments EQ '' OR application.RealtimePayments EQ 0>checked</cfif>> None &nbsp;
					<input type="radio" name="RealtimePayments" value="1" class="cfAdminDefault" <cfif application.RealtimePayments EQ 1>checked</cfif>> Authorization Only &nbsp;
					<input type="radio" name="RealtimePayments" value="2" class="cfAdminDefault" <cfif application.RealtimePayments EQ 2>checked</cfif>> Authorization & Capture
				</td>
			</tr>
			<tr><td height="1" colspan="4" style="background-color:##CCCCCC;"></td></tr>
			<tr><td height="10" colspan="4"></td></tr>
			<tr>
				<td width="100%" colspan="4" align="center">
					<input type="hidden" name="IDYP"   value="#getYourPay.ID#">
					<input type="hidden" name="SiteID" value="#application.SiteID#">
					<input type="submit" name="UpdatePG" value="UPDATE PAYMENT GATEWAY" alt="Update Payment Gateway" class="cfAdminButton"
						onClick="return confirm('Are you sure you want to UPDATE YOURPAY ACCOUNT with the changes you have made?')">
				</td>
			</tr>
		</cfform>
		</cfoutput>
	<cfelse>
		<cfoutput>
		<cfform action="Config-PaymentSystem.cfm" method="post">
			<cfif isUserInRole('Administrator')>
			<tr>
				<td><cfinput type="text" name="StoreNumber"   value="" size="20" maxlength="50" class="cfAdminDefault" required="yes" message="Store Number Required" ></td>
				<td><cfinput type="text" name="PEMFileLocation" value="" size="80" maxlength="500" class="cfAdminDefault" required="yes" message="PEM File Location Required"  ></td>
				<td align="center"><input type="checkbox" name="LiveMode" ></td>
				<td align="center"><input type="checkbox" name="InUse" checked ></td>
			</tr>
			<cfelse>
			<tr>
				<td><cfinput type="text" name="StoreNumber"   value="Your Store Number"   size="20" maxlength="50" class="cfAdminDefault" required="yes" message="Store Number Required" onChange="alert('USER - #GetAuthUser()# - NOT PERMITTED TO PERFORM THE CHOSEN TASK');"></td>
				<td><cfinput type="text" name="PEMFileLocation" value="Your PEM File Location" size="80" maxlength="500" class="cfAdminDefault" required="yes" message="PEM File Location Required"  onChange="alert('USER - #GetAuthUser()# - NOT PERMITTED TO PERFORM THE CHOSEN TASK');"></td>
				<td align="center"><input type="checkbox" name="LiveMode" ></td>
				<td align="center"><input type="checkbox" name="InUse" ></td>
			</tr>
			</cfif>
			<tr><td height="1" colspan="4" style="background-color:##CCCCCC;"></td></tr>
			<tr><td height="10" colspan="4"></td></tr>
			<tr height="20" style="background-color:##65ADF1;">
				<td class="cfAdminHeader1" colspan="4">Realtime Credit Card Processing</td>
			</tr>
			<tr>
				<td colspan="4">
					<input type="radio" name="RealtimePayments" value="0" class="cfAdminDefault" checked> None &nbsp;
					<input type="radio" name="RealtimePayments" value="1" class="cfAdminDefault" > Authorization Only &nbsp;
					<input type="radio" name="RealtimePayments" value="2" class="cfAdminDefault" > Authorization & Capture
				</td>
			</tr>
			<tr><td height="1" colspan="4" style="background-color:##CCCCCC;"></td></tr>
			<tr><td height="10" colspan="4"></td></tr>
			<tr>
				<td width="100%" colspan="4" align="center">
					<input type="hidden" name="IDYP"   value="1">
					<input type="hidden" name="New" value="1">
					<input type="hidden" name="SiteID" value="#application.SiteID#">
					<input type="submit" name="UpdatePG" value="UPDATE PAYMENT GATEWAY" alt="Update Payment Gateway" class="cfAdminButton"
						onClick="return confirm('Are you sure you want to UPDATE YOURPAY ACCOUNT with the changes you have made?')">
				</td>
			</tr>
		</cfform>
		</cfoutput>
	</cfif>
		<tr>
			<td colspan="4">* Required</td>
		</tr>
	</table>
	
	
</cfif>

<cfinclude template="LayoutAdminFooter.cfm">