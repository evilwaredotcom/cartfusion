



<cfmodule template="templates/#application.SiteTemplate#/layout.cfm" currenttab="CustomerService" pagetitle="Store Privacy Policy">	

<!--- Start Breadcrumb --->
<cfmodule template="tags/breadCrumbs.cfm" crumblevel='1' showlinkcrumb="Store Privacy Policy" />
<!--- End BreadCrumb --->

<h3>Privacy Policy</h3>

<div align="justify"> 
	<p><b>Please read the following privacy policy before using this website.</b></p>
	<p><u><cfoutput>#application.StoreName#</cfoutput> will not share your name, address or email address with any third parties.</u><br/><br/>
	
	<cfoutput>#application.StoreName#</cfoutput> takes great care to ensure your personal information is 
	kept private. We store only the minimum amount of information from you necessary to make a 
	transaction. Your credit card information is encrypted using the highest level encryption based on 
	our secure server.<br><br>
									
	If you request it, we will send you infrequent newsletters on new products or services we offer 
	via email. You can request that we take you off our mailing list by setting the option in the 
	"My Account" section of the site.<br><br>								
	
	We consider information about you strictly confidential and will not make it available to anyone outside 
	our company.  Your submitted pictures will be archived in our database under your name and not shared with others.<br><br>
	
	<u>Cookies</u><br><br>
	When you log in to <cfoutput>#application.DomainName#</cfoutput> we place a small piece of information, a cookie, on your machine. 
	This is necessary so that we can track your shopping cart selections between pages and that we know 
	you are logged in to our site. None of your personal information is stored in this cookie and it is 
	removed from your machine as soon as you logout of the site.<br><br> 
	
	You will need to have cookies enabled on your browser in order to use our website.<br><br>
	</p>
</div>

<div align="center">
	<br/>
	<hr class="snip" />
	<br/>
	<input type="button" name="GoBack" value="&lt; BACK" class="button2" onclick="javascript:history.back();"> 
	<input type="button" name="GoHome" value="HOME &gt;" class="button2" onclick="javascript:document.location.href='index.cfm';">
</div>

</cfmodule>
