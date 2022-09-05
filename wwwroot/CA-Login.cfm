


<cfparam name="GoToPage" default="index.cfm" type="string">

<!--- SSL PATH --->
<cfif session.CustomerArray[26] NEQ '' AND ( findnocase("CA-CustomerArea.cfm",GoToPage) GT 0 OR findnocase("CO-Billing.cfm",GoToPage) GT 0 ) >
	<cfif application.EnableSSL EQ 1 AND application.SSLURL NEQ ''>
		<cfoutput><cflocation url="#application.SSLURL#/#goToPage#" addtoken="no"></cfoutput>
	<cfelse>
		<cfoutput><cflocation url="#application.RootURL#/#goToPage#" addtoken="no"></cfoutput>
	</cfif>
</cfif>


<cfmodule template="templates/#application.SiteTemplate#/layout.cfm" pagetitle="Customer Login" currenttab="MyAccount">

<!--- Start Breadcrumb --->
<cfmodule template="tags/breadCrumbs.cfm" crumblevel='1' showlinkcrumb="Customer Login" />
<!--- End BreadCrumb --->

<cfif isDefined("errorLogin")>		
	<div align="center" class="cfErrorMsg">
		<cfswitch expression="#errorLogin#">
			<cfcase value="1">ERROR: Password incorrect.<br>Please try again.</cfcase>
			<cfcase value="2">ERROR: The Password and its confirmation don't match.<br>Please try again.</cfcase>
			<cfcase value="3">ERROR: The password cannot be empty.<br>Please try again.</cfcase>
			<cfcase value="4">ERROR: The UserName cannot be empty.<br>Please try again.</cfcase>
			<cfcase value="5">ERROR: The UserName is already being used by another customer.<br>Please try another one.</cfcase>
			<cfcase value="6">ERROR: The UserName and/or Email Address is already registered.<br>Please try another one.</cfcase>
			<cfcase value="7">ERROR: The UserName cannot be found in our system.<br>Please try another one.</cfcase>
			<cfcase value="8"><u>YOU ARE ALREADY LOGGED IN.</u><br>You may login using your unique username and password under "Registered Customers"<br>OR<br>Create a new username and password under "New Customers"</cfcase>
		</cfswitch>	
	</div>
</cfif>

<div id="formContainer">
	<div id="column-A">
		<!--- Include Login Form for affiliates --->
		<cfinclude template="CA-LoginForm.cfm">
		<cfform method="post" action="CA-EmailLogin.cfm" class="formWrap1">
			<h3>Forgot Your Password?</h3>
			<fieldset>
				<label for="email"><b>Email address:</b></label>
				<cfinput type="text" name="EmailAddress" size="30" required="Yes" message="Email Address Is Required">
			</fieldset>
			<fieldset>
				<div class="f-submit-wrap">
					<cfinput type="submit" name="LoginButton" value="Email My Login Information" class="button small gray">
				</div>
			</fieldset>
		</cfform>
	</div>
	<div id="column-B">
		<cfform name="NewCustomers" class="formWrap1" action="CA-LoginCheck.cfm?goToPage=#goToPage#" method="post">
			<h3>New Customers</h3>
			If you are a new visitor to our website and have not placed an order, please create a unique account here.
			<fieldset>
				<label for="FirstName"><b><span class="req">*</span>First Name:</b></label>
				<cfinput class="cfFormField" type="text" name="FirstName" size="30" maxlength="35" required="yes">
				<label for="lastName"><b><span class="req">*</span>Last Name:</b></label>
				<cfinput class="cfFormField" type="text" name="LastName" size="30" maxlength="35" required="yes">
				<label for="email"><b><span class="req">*</span>Email:</b></label>
				<cfinput type="text" name="Email" size="30" maxlength="60" required="yes">
			</fieldset>
			<fieldset>
				<label for="username"><b><span class="req">*</span>Username:</b></label>
				<cfinput type="text" name="UserName" size="30" maxlength="12" required="yes">
				<label for="password"><b><span class="req">*</span>Password:</b></label>
				<cfinput type="password" name="Password" size="30" maxlength="12" required="yes">
				<label for="password1"><b><span class="req">*</span>Confirm Password:</b></label>
				<cfinput type="password" name="Password1" size="30" maxlength="12" required="yes">
			</fieldset>
			<fieldset>
				<div class="f-submit-wrap">
					<cfinput class="button large green" type="submit" name="Register" value="Register as a New Customer">
				</div>
			</fieldset>
			<cfinput type="hidden" name="CreateNewUser" value="1">
		</cfform>
	</div>
</div>
<br class="clear" />
<div align="center">
	<hr class="snip" />
	<input type="button" name="GoBack" value="&lt; BACK" class="button mini white" onclick="javascript:history.back();"> 
	<input type="button" name="GoHome" value="HOME &gt;" class="button mini white" onclick="javascript:document.location.href='index.cfm';">
</div>
</cfmodule>