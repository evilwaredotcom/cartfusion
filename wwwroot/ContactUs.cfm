<cfmodule template="tags/layout.cfm" CurrentTab="CustomerService" PageTitle="Contact Us">

<!--- Start Breadcrumb --->
<cfmodule template="tags/breadCrumbs.cfm" CrumbLevel='1' showLinkCrumb="Contact Us" />
<!--- End BreadCrumb --->

<cfoutput>
	<h3>Contact Us</h3>
	<p>At #application.siteconfig.data.DomainName#, we understand that although our website is an invaluable tool for ordering products, finding information about our products, keeping track of your orders, and staying informed about new products and events, we also offer fast and friendly phone and email support. Please feel free to call us or email us if you have any questions or simply want to place an order over the phone. We are here to help.</p>
	
	<cfif application.siteconfig.data.CompanyPhone NEQ '' >
		Phone: #application.siteconfig.data.CompanyPhone#<br />
	</cfif>
	
	<cfif application.siteconfig.data.CompanyAltPhone NEQ '' >
		Alt. Phone: #application.siteconfig.data.CompanyAltPhone#<br />
	</cfif>

	<cfif application.siteconfig.data.CompanyFax NEQ '' >
		Fax: #application.siteconfig.data.CompanyFax#<br />
	</cfif>

	<cfif application.siteconfig.data.EmailInfo NEQ '' >
		For More Info: <a href="mailto:#application.siteconfig.data.EmailInfo#">#application.siteconfig.data.EmailInfo#</a><br />
	</cfif>

	<cfif application.siteconfig.data.EmailSales NEQ '' >
		Sales Department: <a href="mailto:#application.siteconfig.data.EmailSales#">#application.siteconfig.data.EmailSales#</a><br />
	</cfif>
	
	<cfif application.siteconfig.data.EmailSupport NEQ '' >
		Technical Support:<a href="mailto:#application.siteconfig.data.EmailSupport#">#application.siteconfig.data.EmailSupport#</a><br />
	</cfif>
	
	Mailing Address:<br />
		&nbsp;#application.siteconfig.data.CompanyName#<br />
		&nbsp;#application.siteconfig.data.CompanyAddress1#<br />
		
		<cfif application.siteconfig.data.CompanyAddress2 NEQ ''>
			&nbsp;#application.siteconfig.data.CompanyAddress2#<br />
		</cfif>
			&nbsp;#application.siteconfig.data.CompanyCity#, #application.siteconfig.data.CompanyState# #application.siteconfig.data.CompanyZip#<br />
			<!--- &nbsp;#getCountry.Country# --->

	<div align="center">
		
		<br />
		<br />
		<hr class="snip" />
		<br />
		<a href="javascript:history.back()"><img src="images/button-back.gif"></a> 
		<a href="index.cfm"><img src="images/button-home.gif"></a> 
	</div>			
</cfoutput>

</cfmodule>
