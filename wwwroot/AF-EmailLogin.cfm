<cfmodule template="tags/layout.cfm" CurrentTab="Affiliates" PageTitle="Affiliate Email Login Info">	

<!--- Start Breadcrumb --->
<cfmodule template="tags/breadCrumbs.cfm" CrumbLevel='1' showLinkCrumb="Affiliates|Affiliate Email Login Info" />
<!--- End BreadCrumb --->


<cfif structKeyExists(form, "EmailAddress")>

	<cfscript>
		getAffiliateInfo = application.queries.getAffiliateInfo(email='#form.EmailAddress#');
	</cfscript>


	<cfif getAffiliateInfo.RecordCount>
		
		<cfset Decrypted_Password = DECRYPT(getAffiliateInfo.Password, application.siteConfig.data.CryptKey, "CFMX_COMPAT", "Hex") >
	<div class="cfMessageTwo">Your Password has been emailed to <cfoutput>#form.EmailAddress#.</cfoutput><br><br>
	<a href="AF-Login.cfm">Return to Affiliate Area</a><br>
	<a href="index.cfm">Return to Store</a></div>

	<CFMAIL QUERY="getAffiliateInfo" GROUP="Email"
			FROM="#application.siteConfig.data.NotifyEmail#"
			TO="#form.EmailAddress#"
			SUBJECT="#application.siteConfig.data.DomainName# Affiliate Login Information"
			type="html">
		<cfoutput>	
		<div>
			Affiliate Login Information for #application.siteConfig.data.DomainName#<br><br>
				<cfloop query="getAffiliateInfo">	
					Affiliate ID: #getAffiliateInfo.AFID#<br>
					Password: #decrypted_password#<br><br>
				</cfloop>
				<a href="http://www.#application.siteConfig.data.DomainName#">Visit #application.siteConfig.data.DomainName# Now</a>
			</font>
		</div>
		</cfoutput>
	</CFMAIL>
	<cfelse>
		<div class="cfErrorMsg" align="center">
			The email address you entered does not appear in our database, or does not belong to a registered customer.<br><br>
			<a href="CA-Login.cfm">Please try again.</a></div>
	
	</cfif>

</cfif>

</cfmodule>
