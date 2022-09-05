<cfmodule template="templates/#application.SiteTemplate#/layout.cfm" CurrentTab="Affiliates">

<!--- Start Breadcrumb --->
<cfmodule template="tags/breadCrumbs.cfm" CrumbLevel='1' showLinkCrumb="Affiliate Sign Up Success" />
<!--- End BreadCrumb --->


<cfif structKeyExists(url, 'AFID') AND structKeyExists(url, 'Email') AND url.AFID neq '' AND url.Email NEQ ''>

	<cfscript>
		isAuthenticated = false;
		// Check to see if affiliate is in the database
		getThisAffiliateInfo = application.queries.getAffiliateInfo(afid=url.afid, email='#url.email#');
		// Then if they are not authenticated, then authenticate them
		if( getThisAffiliateInfo.RecordCount)	{
			isAuthenticated = true;
				application.queries.authenticateAffiliate(afid=url.afid, email='#url.email#');
			}
	</cfscript>

<cfoutput>


	<cfif isAuthenticated>
		<div id="AffiliateOutput">
			<br>
			<p><strong>THANK YOU</strong></p><!---<img src="images/image-RegComplete.gif">--->
			<p>Affiliate registration is now complete.  Thank you for signing up as an affiliate with #application.DomainName#.<br/><br/>
			
			<strong>Your Affiliate ID:</strong> #URL.AFID#<br/><br/>
			
			Easily collect your commissions by offering your customers the following link to <cfoutput>#application.DomainName#</cfoutput>:<br>
			<a href="#application.RootURL#/?AFID=#URL.AFID#">#application.RootURL#/?AFID=#URL.AFID#</a><br/><br/>
			You and your customers may also type in your Affiliate ID during the order checkout process to ensure you receive a commission.</p>
		</div>
		
	<cfelse>
		
		<div align="center" class="cfErrorMsg">UNABLE TO AUTHENTICATE</div>
	
	</cfif>
</cfoutput>
</cfif>

	<br/>
	<br/>
	<hr class="snip" />
	<br/>
	<div align="center">
		<input type="button" name="GoBack" value="&lt; BACK" class="button2" onclick="javascript:history.back();"> 
		<input type="button" name="GoHome" value="HOME &gt;" class="button2" onclick="javascript:document.location.href='index.cfm';">	</div>

</cfmodule>
