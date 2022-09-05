<cfmodule template="templates/#application.SiteTemplate#/layout.cfm" pagetitle="Affiliate Sign Up" currenttab="Affiliates">
<!--- Start Breadcrumb --->
<cfmodule template="tags/breadCrumbs.cfm" crumblevel="1" showlinkcrumb="Affiliate Sign Up" />
<!--- End BreadCrumb --->
<cfscript>
	// Get All the states and countries
	getStates = application.Queries.getStates();
	getCountries = application.Queries.getCountries();
</cfscript>
<!--- BEGIN: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->
<cfif structKeyExists(form, 'RegisterAffiliate') AND structKeyExists(form, 'FirstName') AND form.FirstName NEQ ''>
	<cftry>
		<cfquery name="checkDuplicate" datasource="#application.dsn#">
			SELECT	AFID
			FROM	Affiliates
			WHERE	Email = '#Form.Email#'
		</cfquery>
		<cfif not checkDuplicate.recordCount>
			<cfquery name="getFirstMemberType" datasource="#application.dsn#">
				SELECT	TOP 1 CommID
				FROM	AffiliateCommissions
			</cfquery>
			<cfscript>
				Form.DateUpdated = #Now()# ;
				Form.UpdatedBy = #GetAuthUser()# ;
				//
				if ( isDefined('Form.EmailOK') ) Form.EmailOK = 1;
				else Form.EmailOK = 0;
				if ( isDefined('Form.Authenticated') ) Form.Authenticated = 1;
				else Form.Authenticated = 0;
				//
				if ( Form.Password NEQ '') Form.Password = ENCRYPT(Form.Password, application.CryptKey, "CFMX_COMPAT", "Hex") ;
				else Form.Password = '';
				//
				if ( getFirstMemberType.RecordCount NEQ 0 ) Form.MemberType = getFirstMemberType.CommID ;
				else Form.MemberType = 0 ;
				Form.PaymentFrequency = 0 ;
				Form.EmailPayPal = 1 ;
				Form.ReferralRate = 0 ;
				Form.SubAffiliateOf = session.CustomerArray[36] ;
			</cfscript>
			<cfinsert datasource="#application.dsn#" tablename="Affiliates" 
				formfields="FirstName, LastName, CompanyName, Address1, Address2, City, State, Zip, Country, 
				Phone, Fax, Email, EmailOK, TaxID, Password, WebsiteName, WebsiteURL, WebsiteCategory, Comments,
				CustomerID, MemberType, PaymentFrequency, EmailPayPal, 
				ReferralRate, CustomerDiscount, 
				Authenticated, SubAffiliateOf, DateUpdated, UpdatedBy">
			<!--- GET NEWLY ASSIGNED AFID --->
			<cfquery name="getLastAFID" datasource="#application.dsn#">
				SELECT	MAX(AFID) AS AFID
				FROM	Affiliates
				WHERE	FirstName = '#Form.FirstName#'	
			</cfquery>
			<cfscript>
				getAFLevel = application.Queries.getAFLevel(CommID=form.MemberType);
			</cfscript>
			<!--- <cfinvoke component="#application.Queries#" method="getAFLevel" returnvariable="getAFLevel">
				<cfinvokeargument name="CommID" value="#Form.MemberType#">
			</cfinvoke> --->
			<cfif Form.MemberType NEQ 0 >
				<cfquery name="updateAFHistory" datasource="#application.dsn#">
					INSERT INTO AffiliateHistory
							( AFID, L1, L2, L3, DateEntered )
					VALUES	( #getLastAFID.AFID#, #getAFLevel.L1#, #getAFLevel.L2#, #getAFLevel.L3#, #Now()# )
				</cfquery>
			<cfelse>
				<cfquery name="updateAFHistory" datasource="#application.dsn#">
					INSERT INTO AffiliateHistory
							( AFID, L1, L2, L3, DateEntered )
					VALUES	( #getLastAFID.AFID#, 0, 0, 0, #Now()# )
				</cfquery>
			</cfif>
			<cfoutput><cflocation url="AF-SignUpComplete.cfm?AFID=#getLastAFID.AFID#" addtoken="no"></cfoutput>
			<cfabort>
		<cfelse>
			<div class="cfErrorMsg">
				EXCEPTION: An affiliate ID has already been created with this email account.<br>
				Please login with your existing affiliate ID or create a new ID with a different email account.
			</div>
		</cfif>
		<cfcatch>
			<div class="cfErrorMsg">FAIL: Unable to sign up new affiliate.</div>
		</cfcatch>
	</cftry>
</cfif>
<!--- END: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->
<div id="formContainer">
<cfform action="AF-Signup.cfm" method="post" class="formWrap1">
	<div class="req"><b>*</b> Indicates required field</div>
	<h3>Affiliate Sign-Up</h3>
	<fieldset>
		<label for="firstname"><b><span class="req">*</span>First name:</b>
			<cfinput class="f-name" id="FirstName" type="text" name="FirstName" size="35" maxlength="25" required="yes" message="First Name Required"><br/>
		</label>
		<label for="lastname"><b><span class="req">*</span>Last name:</b>
			<cfinput class="f-name" id="LastName" type="text" name="LastName" size="35" maxlength="35" required="yes" message="Last Name Required"><br/>
		</label>
		<label for="emailaddress"><b><span class="req">*</span>Email Address:</b>
			<cfinput class="f-email" type="text" name="Email" size="35" maxlength="50" required="yes" message="Email Address Required"><br/>
		</label>
	</fieldset>
	<fieldset id="Address">
		<label for="CompanyName"><b>Company Name:</b>
			<cfinput class="f-name" type="text" name="CompanyName" size="35" maxlength="50" required="no"><br/>
		</label>
		<label for="Address1"><b><span class="req">*</span>Address 1:</b>
			<cfinput class="f-name" id="Address1" type="text" name="Address1" size="35" maxlength="35" required="yes" message="Address Line 1 Required"><br/>
		</label>
		<label for="Address2"><b>Address 2:</b>
			<cfinput class="f-name" id="Address2" type="text" name="Address2" size="35" maxlength="35" ><br/>
		</label>
		<label for="City"><b><span class="req">*</span>City:</b>
			<cfinput class="f-name" id="City" type="text" name="City" size="35" maxlength="35" required="yes" message="City Required"><br/>
		</label>
		<label for="StateCode"><b><span class="req">*</span>State:</b>
			<cfselect query="getStates" name="State" value="StateCode" display="State" selected="#application.CompanyState#" size="1" required="yes" /><br/>
		</label>
		<label for="ZipCode"><b><span class="req">*</span>Post/ZipCode:</b>
			<cfinput class="f-name" type="text" name="ZIP" size="10" maxlength="10" required="yes" message="Zip/Postal Code Required"><br/>
		</label>
		<label for="Country"><b><span class="req">*</span>Country:</b>
			<cfselect query="getCountries" name="Country" value="CountryCode" display="Country" selected="#application.CompanyCountry#" class="cfFormField" size="1" required="yes" /><br/>
		</label>
	</fieldset>
	<fieldset>
		<label for="Phone"><b><span class="req">*</span>Phone:</b>
			<cfinput class="f-name" type="text" name="Phone" size="20" maxlength="20" required="yes" message="Phone Number Required"><br/>
		</label>
		<label for="Fax"><b>Fax:</b>
			<cfinput class="f-name" type="text" name="Fax" size="20" maxlength="20" required="no" ><br/>
		</label>
		<label for="TaxID"><b>Tax ID/SSN:</b>
			<cfinput class="f-name" type="text" name="TaxID" size="35" maxlength="50" required="no"><br/>
		</label>
	</fieldset>
	<fieldset>
		<label for="WebsiteName"><b>Website Name:</b>
			<cfinput type="text" name="WebsiteName" size="35" maxlength="50" required="no"><br/>
		</label>
		<label for="WebsiteUrl"><b>Website Url:</b>
			<cfinput type="text" name="WebsiteURL" value="http://" size="35" maxlength="50" required="no"><br/>
		</label>
		<label for="WebsiteCategory"><b>Website Category:</b>
			<select name="WebsiteCategory" size="1">
				<option value="">--- Select ---</option>
				<option value="Online Store" selected>Online Store</option>
				<option value="Retail Store">Retail Store</option>
				<option value="Individual">Individual</option>
				<option value="Fund Raiser">Fund Raiser</option>
				<option value="Other">Other</option>
			</select>
			<br/>
		</label>
	</fieldset>
	<fieldset>
		<label for="password"><b><span class="req">*</span>Password:</b>
			<cfinput class="f-password" type="password" name="Password" size="20" maxlength="16" required="yes" message="Please enter a password">&nbsp;16-Character Max.<br/>
		</label>
		<label for="password2"><b><span class="req">*</span>Confirm Password:</b>
			<cfinput class="f-password" type="password" name="Password1"  size="20" maxlength="16" required="yes" message="Please confirm your password">&nbsp;16-Character Max.<br/>
		</label>
		<label for="AffiliateText">
			<p><strong><u>IT PAYS TO BE AN AFFILIATE</u></strong><br>
			As an affiliate of <cfoutput>#application.DomainName#</cfoutput>, you will receive a percentage of the net sales
			of orders placed using your affiliate ID.  No need to think about it - we'll send you a check when your account reaches $100.<br><br>
			<strong>PRIVACY NOTE:</strong> Your information will be kept in <i><u>strict confidence</u></i> in our encrypted database, and will only be used
			to setup and validate your account and issue your earned credit.</p>
		</label>
	</fieldset>
	<fieldset>
		<label for="comments"><b>Comments:</b>
			<textarea id="comments" name="comments" class="f-comments" rows="6" cols="20" tabindex="11"></textarea><br/>
		</label>
		<div class="f-submit-wrap">
			<input type="submit" name="RegisterAffiliate" value="SUBMIT APPLICATION" class="button" tabindex="12" /><br/>
		</div>
	</fieldset>
	</cfform>
</div>
<div align="center">
	<br/>
	<br/>
	<hr class="snip" />
	<br/>
	<input type="button" name="GoBack" value="&lt; BACK" class="button2" onclick="javascript:history.back();"> 
	<input type="button" name="GoHome" value="HOME &gt;" class="button2" onclick="javascript:document.location.href='index.cfm';">
</div>
</cfmodule>
