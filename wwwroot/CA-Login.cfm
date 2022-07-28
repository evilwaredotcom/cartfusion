<cfparam name="GoToPage" default="index.cfm" type="string">

<!--- SSL PATH --->
<cfif session.CustomerArray[26] NEQ '' AND ( findnocase("CA-CustomerArea.cfm",GoToPage) GT 0 OR findnocase("CO-Billing.cfm",GoToPage) GT 0 ) >
	<cfif application.siteConfig.data.EnableSSL EQ 1 AND config.SSL_Path NEQ ''>
		<cfoutput><cflocation url="#application.siteConfig.data.SSL_Path#/#goToPage#" addtoken="no"></cfoutput>
	<cfelse>
		<cfoutput><cflocation url="#application.siteConfig.data.RootURL#/#goToPage#" addtoken="no"></cfoutput>
	</cfif>
</cfif>


<cfmodule template="tags/layout.cfm" PageTitle="Customer Login" CurrentTab="MyAccount">

<!--- Start Breadcrumb --->
<cfmodule template="tags/breadCrumbs.cfm" CrumbLevel='1' showLinkCrumb="Customer Login" />
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
	</div><br /><br />
</cfif>

<div id="formContainer">
	<div id="column-A">
		<!--- Include Login Form for affiliates --->
		<cfinclude template="CA-LoginForm.cfm">
		<br />
		
		<cfform method="post" action="CA-EmailLogin.cfm" class="f-wrap-1">
			<fieldset>
				<h3>Forgot Your Password?</h3>
		
				<label for="email"><b>Email address:</b>
					<cfinput type="text" name="EmailAddress" size="30" required="Yes" message="Email Address Is Required"><br />
				</label>
				
			</fieldset>
	
			<fieldset>
			
				<div class="f-submit-wrap">
					<cfinput type="submit" name="LoginButton" value="Email My Login Information" class="button" style="width:200px;"><br />
				</div>
			
			</fieldset>
	</cfform>
	</div>
	
	<div id="column-B">
		<cfform name="NewCustomers" class="f-wrap-1" action="CA-LoginCheck.cfm?goToPage=#goToPage#" method="post" preservedata="yes">
			<fieldset>
				<h3>New Customers</h3> If you are a new visitor to our website and have not placed an order, please create a unique account here.<br />
				
				<label for="FirstName"><b><span class="req">*</span>First Name:</b>
					<cfinput class="cfFormField" type="text" name="FirstName" size="30" maxlength="35" required="yes"><br />
				</label>
				
				<label for="lastName"><b><span class="req">*</span>Last Name:</b>
					<cfinput class="cfFormField" type="text" name="LastName" size="30" maxlength="35" required="yes">
				</label>
				
				<label for="email"><b><span class="req">*</span>Email:</b>
					<cfinput type="text" name="Email" size="30" maxlength="60" required="yes">
				</label>
				
			</fieldset>
			
			<fieldset>
				<label for="username"><b><span class="req">*</span>Username:</b>
					<cfinput type="text" name="UserName" size="30" maxlength="12" required="yes">
				</label>
				
				<label for="password"><b><span class="req">*</span>Password:</b>
					<cfinput type="password" name="Password" size="30" maxlength="12" required="yes">
				</label>
			
				<label for="password1"><b><span class="req">*</span>Confim Password:</b>
					<cfinput type="password" name="Password1" size="30" maxlength="12" required="yes">
				</label>
				
			</fieldset>
			
			<fieldset>			
				<div class="f-submit-wrap">
					<cfinput class="button" type="submit" name="Register" value=" Register as a New Customer" style="width:200px;">
				</div>
			</fieldset>
		</cfform>
	</div>

</div>

<br class="clear" />

<div align="center">
	<br />
	<br />
	<hr class="snip" />
	<br />
	<a href="javascript:history.back()"><img src="images/button-back.gif"></a>
	<a href="index.cfm"><img src="images/button-home.gif"></a>
</div>

</cfmodule>
