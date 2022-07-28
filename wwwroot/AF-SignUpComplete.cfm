<cfmodule template="tags/layout.cfm" CurrentTab="CustomerService" PageTitle="Affiliate Sign Up Success">

<!--- Start Breadcrumb --->
<cfmodule template="tags/breadCrumbs.cfm" CrumbLevel='2' showLinkCrumb="Affiliates|Affiliate Sign Up Success" />
<!--- End BreadCrumb --->


	<cfif structKeyExists(url, 'AFID') and url.afid neq ''>
	
		<cfscript>
			getAffiliateInfo = application.Queries.getAffiliate(afid=url.afid);
		</cfscript>
		
		<cfif getAffiliateInfo.RecordCount>
		
			<cfmail to="#getAffiliateInfo.Email#" from="#application.siteConfig.data.EmailSupport#" failto="#application.siteConfig.data.NotifyEmail#"
				subject="Affiliate Registration Confirmation for #application.siteConfig.data.DomainName#" type="html" >
					Thank you for registering as an affiliate with #application.siteConfig.data.StoreName# at #application.siteConfig.data.DomainName#.  In order to authenticate your 
					application, please click on the following link.<br><br>
					<a href="#application.siteConfig.data.RootURL#/AF-Authenticate.cfm?AFID=#URL.AFID#&Email=#getAffiliateInfo.Email#">#application.siteConfig.data.RootURL#/AF-Authenticate.cfm?AFID=#URL.AFID#&Email=#getAffiliateInfo.Email#</a>
			</cfmail>
		
		</cfif>
	
		<div id="AffiliateConfirmation">
			<h3>Thank You</h3>
			
			<p>Thank you for signing up as an affiliate with <cfoutput>#application.siteConfig.data.DomainName#</cfoutput>.  We have sent you an email in order to confirm the information you have provided.
			Please follow the directions of this email to authenticate your affiliate account.</p>
		</div>
		
		<cfelse>
			<div class="cfErrorMsg">Your affiliate <u>registration</u> was not successful at this time.</div>
	
	</cfif>
	
	<br>
	<div align="center">
	<hr class="snip" />
	<br />
		<a href="javascript:history.back()"><img src="images/button-back.gif"></a>
		<a href="index.cfm"><img src="images/button-home.gif"></a>
	</div>

</cfmodule>

