


<cfif NOT isDefined('session.AffiliateArray') OR session.AffiliateArray[1] EQ ''>
	<cflocation url="AF-Login.cfm" addtoken="no">
</cfif>


<cfoutput>

<cfscript>
	getAffiliate = application.Queries.getAffiliate(AFID=session.AffiliateArray[1]);
	getStates = application.Queries.getStates();
	getCountries = application.Queries.getCountries();
	// Decrypt Password
	Decrypted_Password = DECRYPT(getAffiliate.Password, application.CryptKey, "CFMX_COMPAT", "Hex") ;
</cfscript>


<cfmodule template="templates/#application.SiteTemplate#/layout.cfm" currenttab="Affiliates" pagetitle="Update Affiliate Details" showexpireheaders="True">

<!--- Start Breadcrumb --->
<cfmodule template="tags/breadCrumbs.cfm" crumblevel='1' showlinkcrumb="Affiliates|Update Affiliate Details" />
<!--- End BreadCrumb --->


<cfif structKeyExists(form, 'UpdateAffiliate') AND structKeyExists(form, 'AFID')>
	<cfscript>
		if ( isDefined('Form.EmailOK') )
			Form.EmailOK = 1 ;
		else
			Form.EmailOK = 0 ;	
		Form.DateUpdated = #Now()# ;
		Form.UpdatedBy = 'Affiliate' ;
		if ( Form.Password NEQ '' ) 
			Form.Password = ENCRYPT(Form.Password, application.CryptKey, "CFMX_COMPAT", "Hex") ;
	</cfscript>
	<cftry>
		<cfupdate datasource="#application.dsn#" tablename="Affiliates" 
		formfields="AFID, FirstName, LastName, Address1, Address2, City, State, Zip, Country, CompanyName, 
					Phone, Fax, Email, EmailOK, WebSiteName, WebSiteURL, WebSiteCategory, 
					TaxID, Password, DateUpdated, UpdatedBy">
			<cfset ErrorMsg = 'Your affiliate information has been updated successfully.'>
		<cfcatch>
			<cfset ErrorMsg = 'ERROR: Your affiliate information has NOT been updated.'>
		</cfcatch>
	</cftry>
</cfif>
	<cfif isDefined("ErrorMsg")>
		<div class="cfErrorMsg">
			#ErrorMsg#
		</div>
		<br/>		
	</cfif>


<div class="myaccount">
	<img src="images/icon-down.gif" align="absmiddle" /> &nbsp;My Profile
</div>

<br/>
<cfloop query="getAffiliate">

<div id="formContainer">

<cfform action="#CGI.SCRIPT_NAME#" method="post" class="formWrap1">

	<div class="req"><b>*</b> Indicates required field</div>
	
	<fieldset>
	
	<h3>Update Affiliate Details</h3>
	
	<label for="firstname"><b><span class="req">*</span>First name:</b>
		<cfinput class="f-name" id="FirstName" type="text" value="#FirstName#" name="FirstName" size="35" maxlength="25" required="yes" message="First Name Required"><br/>
	</label>
	
	<label for="lastname"><b><span class="req">*</span>Last name:</b>
		<cfinput class="f-name" id="LastName" type="text" value="#LastName#" name="LastName" size="35" maxlength="35" required="yes" message="Last Name Required"><br/>
	</label>
	
	<label for="emailaddress"><b><span class="req">*</span>Email Address:</b>
		<cfinput class="f-email" type="text" value="#Email#" name="Email" size="35" maxlength="50" required="yes" message="Email Address Required"><br/>
	</label>
	
	</fieldset>
	
	<fieldset id="Address">

		<label for="CompanyName"><b>Company Name:</b>
			<cfinput class="f-name" type="text" value="#CompanyName#" name="CompanyName" size="35" maxlength="50" required="no"><br/>
		</label>
		
		<label for="Address1"><b><span class="req">*</span>Address 1:</b>
			<cfinput class="f-name" value="#Address1#" id="Address1" type="text" name="Address1" size="35" maxlength="35" required="yes" message="Address Line 1 Required"><br/>
		</label>
		
		<label for="Address2"><b>Address 2:</b>
			<cfinput class="f-name" value="#Address2#" id="Address2" type="text" name="Address2" size="35" maxlength="35" ><br/>
		</label>
		
		<label for="City"><b><span class="req">*</span>City:</b>
			<cfinput class="f-name" value="#City#" id="City" type="text" name="City" size="35" maxlength="35" required="yes" message="City Required"><br/>
		</label>
		
		<label for="StateCode"><b><span class="req">*</span>State:</b>
			<cfselect query="getStates" name="State" value="StateCode" display="State" selected="#State#" size="1" required="yes" /><br/>
		</label>
		
		<label for="ZipCode"><b><span class="req">*</span>Post/ZipCode:</b>
			<cfinput class="f-name" type="text" name="ZIP" value="#ZIP#" size="10" maxlength="10" required="yes" message="Zip/Postal Code Required"><br/>
		</label>
		
		<label for="Country"><b><span class="req">*</span>Country:</b>
			<cfselect query="getCountries" name="Country" value="CountryCode" display="Country" selected="#Country#" class="cfFormField" size="1" required="yes" /><br/>
		</label>
		
	</fieldset>
	
	
	<fieldset>
		<label for="Phone"><b><span class="req">*</span>Phone:</b>
			<cfinput class="f-name" type="text" value="#Phone#" name="Phone" size="20" maxlength="20" required="yes" message="Phone Number Required"><br/>
		</label>
	
		<label for="Fax"><b>Fax:</b>
			<cfinput class="f-name" type="text" value="#Fax#" name="Fax" size="20" maxlength="20" required="no" ><br/>
		</label>
		
		<label for="TaxID"><b>Tax ID/SSN:</b>
			<cfinput class="f-name" type="text" value="#TaxID#" name="TaxID" size="35" maxlength="50" required="no"><br/>
		</label>
	
	
	</fieldset>
	
	<fieldset>
		
		<label for="WebsiteName"><b>Website Name:</b>
			<cfinput type="text" value="#WebsiteName#" name="WebsiteName" size="35" maxlength="50" required="no"><br/>
		</label>
		
		<label for="WebsiteUrl"><b>Website Url:</b>
			<cfinput type="text" value="#WebsiteURL#" name="WebsiteURL" size="35" maxlength="50" required="no"><br/>
		</label>
	
		<label for="WebsiteCategory"><b>Website Category:</b>
			<select name="WebsiteCategory" size="1">
				<option value="">--- Select ---</option>
				<option value="Online Store" <cfif WebsiteCategory EQ 'Online Store'>selected</cfif>>Online Store</option>
				<option value="Retail Store" <cfif WebsiteCategory EQ 'Retail Store'>selected</cfif>>Retail Store</option>
				<option value="Individual" <cfif WebsiteCategory EQ 'Individual'>selected</cfif>>Individual</option>
				<option value="Fund Raiser" <cfif WebsiteCategory EQ 'Fund Raiser'>selected</cfif>>Fund Raiser</option>
				<option value="Other" <cfif WebsiteCategory EQ 'Other'>selected</cfif>>Other</option>
			</select>
			<br/>
		</label>
		
	</fieldset>
	
	<fieldset>
		
		<label for="password"><b><span class="req">*</span>Password:</b>
			<cfinput class="f-password" value="#decrypted_Password#" type="password" name="Password" size="20" maxlength="16" required="yes" message="Please enter a password">&nbsp;16-Character Max.<br/>
		</label>
		
		<label for="Notify"><b>Notify Me:</b>
			<input type="checkbox" name="EmailOK" <cfif EmailOK EQ 1> checked </cfif> >
		</label>
		
	</fieldset>
	
	
	<fieldset>
		
	<div class="f-submit-wrap">
		<input type="submit" name="UpdateAffiliate" value="Update Details" class="button" /><br/>
		<input type="hidden" name="AFID" value="#AFID#">
	</div>
	</fieldset>
	</cfform>
</div>

</cfloop>

<div align="center">
	<br/>
	<hr class="snip" />
	<br/>
	<input type="button" name="GoBack" value="&lt; BACK" class="button2" onclick="javascript:document.location.href='AF-Main.cfm?show4=1';">
	<input type="button" name="GoHome" value="HOME &gt;" class="button2" onclick="javascript:document.location.href='AF-Main.cfm?show4=1';">
</div>

</cfmodule>

</cfoutput>
