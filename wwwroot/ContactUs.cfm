



<cfmodule template="templates/#application.SiteTemplate#/layout.cfm" currenttab="CustomerService" pagetitle="Contact Us">

<!--- Start Breadcrumb --->
<cfmodule template="tags/breadCrumbs.cfm" crumblevel='1' showlinkcrumb="Contact Us" />
<!--- End BreadCrumb --->

<cfoutput>
	<h3>Contact Us</h3>
	<p>At #application.DomainName#, we understand that although our website is an invaluable tool for ordering products, finding information about our products, keeping track of your orders, and staying informed about new products and events, we also offer fast and friendly phone and email support. Please feel free to call us or email us if you have any questions or simply want to place an order over the phone. We are here to help.</p>
	
	<cfif application.CompanyPhone NEQ '' >
		Phone: #application.CompanyPhone#<br/>
	</cfif>
	
	<cfif application.CompanyAltPhone NEQ '' >
		Alt. Phone: #application.CompanyAltPhone#<br/>
	</cfif>

	<cfif application.CompanyFax NEQ '' >
		Fax: #application.CompanyFax#<br/>
	</cfif>
	
	<br/>
	
	<cfif application.EmailInfo NEQ '' >
		For More Info: <a href="mailto:#application.EmailInfo#">#application.EmailInfo#</a><br/>
	</cfif>

	<cfif application.EmailSales NEQ '' >
		Sales Department: <a href="mailto:#application.EmailSales#">#application.EmailSales#</a><br/>
	</cfif>
	
	<cfif application.EmailSupport NEQ '' >
		Technical Support:<a href="mailto:#application.EmailSupport#">#application.EmailSupport#</a><br/>
	</cfif>
	
	<br/>
	
	Mailing Address:<br/>
		&nbsp;&nbsp;&nbsp;#application.CompanyName#<br/>
		&nbsp;&nbsp;&nbsp;#application.CompanyAddress1#<br/>
		
		<cfif application.CompanyAddress2 NEQ ''>
			&nbsp;&nbsp;&nbsp;#application.CompanyAddress2#<br/>
		</cfif>
			&nbsp;&nbsp;&nbsp;#application.CompanyCity#, #application.CompanyState# #application.CompanyZip#<br/>
			<!--- &nbsp;#getCountry.Country# --->

	<div align="center">
		
		<br/>
		<br/>
		<hr class="snip" />
		<br/>
		<input type="button" name="GoBack" value="&lt; BACK" class="button2" onclick="javascript:history.back();"> 
		<input type="button" name="GoHome" value="HOME &gt;" class="button2" onclick="javascript:document.location.href='index.cfm';">
	</div>			
</cfoutput>

</cfmodule>
