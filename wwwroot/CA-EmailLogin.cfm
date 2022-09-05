

<cfscript>
	if( structKeyExists(form, 'EmailAddress') )	{
		login = application.Common.login(form.EmailAddress);
	}
</cfscript>


<cfmodule template="templates/#application.SiteTemplate#/layout.cfm" CurrentTab="MyAccount" PageTitle="Customer Email Login Info">

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
	<cfset Decrypted_Password = DECRYPT(login.Password, application.CryptKey, "CFMX_COMPAT", "Hex") >
	<div class="cfMessageTwo" align="center">Your Password has been emailed to #form.EmailAddress#.<br><br>
	<a href="CA-Login.cfm">Return to Customer Area</a><br>
	<a href="index.cfm">Return to Store</a></div>

	<cfmail from="#application.NotifyEmail#"
			to="#form.EmailAddress#"
			subject="#application.DomainName# Customer Login Information"
			type="html">
		
		<div class="cfMessageThree">
		Customer Login Information for #application.DomainName#<br><br>
		<cfloop query="login">	
			Username: #login.UserName#<br>
			Password: #decrypted_password#<br><br>
		</cfloop>
		<a href="http://www.#application.DomainName#">Visit #application.DomainName# Now</a>
		</div>
	</cfmail>
</cfif>

	<cfelse>
		<br/>
	<div class="cfErrorMsg" align="center">We're sorry but an Email address was not passed in the form.</div>
	<div align="center">
		<br/>
		<br/>
		<hr class="snip" />
		<br/>
		<input type="button" name="GoBack" value="&lt; BACK" class="button2" onclick="javascript:history.back();"> 
		<input type="button" name="GoHome" value="HOME &gt;" class="button2" onclick="javascript:document.location.href='index.cfm';">	</div>

</cfif>
</cfoutput>

</cfmodule>
