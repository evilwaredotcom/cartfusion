<cfscript>
	if( structKeyExists(form, 'EmailAddress') )	{
		login = application.Common.login(form.EmailAddress);
	}
</cfscript>


<cfmodule template="tags/layout.cfm" CurrentTab="MyAccount" PageTitle="Customer Email Login Info">

<!--- Start Breadcrumb --->
<cfmodule template="tags/breadCrumbs.cfm" CrumbLevel='1' showLinkCrumb="Customer Email Login Info" />
<!--- End BreadCrumb --->

<cfoutput>

<!--- TODO: Check to see if form.EmailAddress has been passed first --->
<cfif structKeyExists(form, 'EmailAddress')>

<cfif not login.Recordcount>
	<div class="cfErrorMsg" align="center">The email address you entered does not appear in our database,
			or does not belong to a registered customer.<br><br>
	<a href="CA-Login.cfm">Please try again.</a></div>
<cfelse>
	<cfset Decrypted_Password = DECRYPT(login.Password, application.siteConfig.data.CryptKey, "CFMX_COMPAT", "Hex") >
	<div class="cfMessageTwo" align="center">Your Password has been emailed to #form.EmailAddress#.<br><br>
	<a href="CA-Login.cfm">Return to Customer Area</a><br>
	<a href="index.cfm">Return to Store</a></div>

	<cfmail from="#application.siteConfig.data.NotifyEmail#"
			to="#form.EmailAddress#"
			subject="#application.siteConfig.data.DomainName# Customer Login Information"
			type="html">
		
		<div class="cfMessageThree">
		Customer Login Information for #application.siteConfig.data.DomainName#<br><br>
		<cfloop query="login">	
			Username: #login.UserName#<br>
			Password: #decrypted_password#<br><br>
		</cfloop>
		<a href="http://www.#application.siteConfig.data.DomainName#">Visit #application.siteConfig.data.DomainName# Now</a>
		</div>
	</cfmail>
</cfif>

	<cfelse>
		<br />
	<div class="cfErrorMsg" align="center">We're sorry but an Email address was not passed in the form.</div>
	<div align="center">
		<br />
		<br />
		<hr class="snip" />
		<br />
		<a href="javascript:history.back()"><img src="images/button-back.gif"></a>
		<a href="index.cfm"><img src="images/button-home.gif"></a>
	</div>

</cfif>
</cfoutput>

</cfmodule>
