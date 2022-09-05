<cfif isDefined('URL.ErrorMsg') AND URL.ErrorMsg EQ 1>
	<script language="JavaScript">
		{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
	</script>
</cfif>

<!--- BEGIN: QUERIES ------------------------------------->

<cfif isDefined('Form.CustomerID')>
	<cfinvoke component="#application.Queries#" method="getCustomer" returnvariable="getCustomer">
		<cfinvokeargument name="CustomerID" value="#Form.CustomerID#">
	</cfinvoke>
	<cfscript>
		Form.DateUpdated = #Now()# ;
		Form.UpdatedBy = #GetAuthUser()# ;
		if ( getCustomer.Password NEQ '') decrypted_Password = DECRYPT(getCustomer.Password, application.CryptKey, "CFMX_COMPAT", "Hex") ;
		else decrypted_Password = '';
	</cfscript>
</cfif>
<cfinvoke component="#application.Queries#" method="getCustomers" returnvariable="getCustomers"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getAFLevels" returnvariable="getAFLevels"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getStates" returnvariable="getStates"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getCountries" returnvariable="getCountries"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getPaymentTypes" returnvariable="getPaymentTypes"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getUsers" returnvariable="getUsers"></cfinvoke>

<cfquery name="getAffiliates" datasource="#application.dsn#">
	SELECT	AFID, convert(varchar, AFID) + ': ' + LastName + ', ' + FirstName AS AffiliateName
	FROM	Affiliates
	WHERE	(Deleted = 0 OR Deleted IS NULL)
	AND		Authenticated = 1
	ORDER BY LastName
</cfquery>

<!--- END: QUERIES ------------------------------------->

<!--- BEGIN: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<cfif isDefined('Form.AddAffiliate') AND isDefined('Form.Password') AND Form.Password NEQ ''>
	
	<cfif Form.Password NEQ Form.PasswordCheck >
		<cfset AdminMsg = 'ERROR: Confirm Password does not match Password' >
	<cfelse>
		<cftry>
			<cfquery name="checkDuplicate" datasource="#application.dsn#">
				SELECT	AFID
				FROM	Affiliates
				WHERE	Email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Form.Email#">
				OR		TaxID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Form.TaxID#">
			</cfquery>
			
			<cfif checkDuplicate.RecordCount EQ 0 >
				
				<cfscript>
					Form.DateUpdated = #Now()# ;
					Form.UpdatedBy = #GetAuthUser()# ;
					
					if ( isDefined('Form.EmailOK') ) Form.EmailOK = 1;
					else Form.EmailOK = 0;
					if ( isDefined('Form.Authenticated') ) Form.Authenticated = 1;
					else Form.Authenticated = 0;
					
					if ( Form.Password NEQ '') Form.Password = ENCRYPT(Form.Password, application.CryptKey, "CFMX_COMPAT", "Hex") ;
					else Form.Password = '';
					
					Form.PaymentFrequency = 0 ;
					Form.EmailPayPal = 1 ;
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
				
				<cfinvoke component="#application.Queries#" method="getAFLevel" returnvariable="getAFLevel">
					<cfinvokeargument name="CommID" value="#Form.MemberType#">
				</cfinvoke>
				
				<cfquery name="updateAFHistory" datasource="#application.dsn#">
					INSERT INTO AffiliateHistory
							( AFID, L1, L2, L3, DateEntered )
					VALUES	( #getLastAFID.AFID#, #getAFLevel.L1#, #getAFLevel.L2#, #getAFLevel.L3#, #Now()# )
				</cfquery>
	
				<cfif getLastAFID.RecordCount EQ 1>
					<cfset AdminMsg = 'Affiliate Added Successfully' >
					<cfset AFID = getLastAFID.AFID >
					<cfmail to="#Form.Email#" from="#application.EmailSupport#" failto="#application.NotifyEmail#"
						subject="Affiliate Registration Confirmation for #application.DomainName#">
Thank you for registering as an affiliate with 
#application.StoreName# at #application.DomainName#.  
In order to authenticate your application, please 
click on the following link.

#application.RootURL#/affiliates/AF-Authenticate.cfm?AFID=#getLastAFID.AFID#&Email=#Form.Email#
					</cfmail>
					<cflocation url="AffiliateDetail.cfm?AFID=#AFID#&AdminMsg=#URLEncodedFormat(AdminMsg)#" addtoken="no">
					<cfabort>
				<cfelse>
					<cfset AdminMsg = 'ERROR: Affiliate NOT Added.  Please try again.' >
				</cfif>
			<cfelse>
				<cfset AdminMsg = 'EXCEPTION: Email already linked to existing affiliate.' >
			</cfif>

			<cfcatch>
				<cfset AdminMsg = 'FAIL: Affiliate NOT Added - #cfcatch.Message#' >
			</cfcatch>
		</cftry>

	</cfif>
</cfif>
			
<!--- END: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<!--- BEGIN: HEADER --->
<cfscript>
	PageTitle = 'ADD AFFILIATE';
	QuickSearch = 1;
	QuickSearchPage = 'Affiliates.cfm';
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">
<cfif isDefined('RefreshPage') AND RefreshPage EQ 1 >
	<cfset BodyOptions = 'history.go();' >
	<cfset RefreshPage = 0 >
</cfif>
<!--- END: HEADER --->

<cfoutput>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td width="33%" height="20">
			<table cellpadding="3" cellspacing="0">
				<tr>
					<cfform action="#CGI.SCRIPT_NAME#" method="post" name="ApplyCustomerID">				
					<td class="cfAdminDefault" style="padding-right:10">
						<b>APPLY CUSTOMER INFO:</b>
						<cfselect name="CustomerID" query="getCustomers" value="CustomerID" display="CustomerInfo" size="1" class="cfAdminDefault" onChange="this.form.submit();" tabindex="1">
							<option value="" <cfif NOT isDefined('Form.CustomerID') OR Form.CustomerID EQ ''>selected</cfif> >--- New Customer ---</option>
						</cfselect>
					</td>
					</cfform>
				</tr>
			</table>
		</td>
</cfoutput>

<!--- MAIN FORM --->		
<cfform action="#CGI.SCRIPT_NAME#" method="post" name="OrderForm">			
<cfoutput>

		<td width="33%" align="center" valign="middle" class="cfAdminDefault">
			<b>Member Type:</b>
			<cfselect query="getAFLevels" name="MemberType" value="CommID" display="LevelName" class="cfAdminDefault" size="1" required="yes" message="Affiliate Level is Required." tabindex="17" />
		</td>
		<td width="33%" align="right"></td>
	</tr>
</table>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr style="background-color:##65ADF1;">
		<td width="49%" colspan="2" height="20" class="cfAdminHeader1">&nbsp; BILLING INFORMATION</td>
		<td width="1%"  rowspan="26" style="background-color:##FFFFFF;">&nbsp;</td>
		<td width="50%" colspan="2" class="cfAdminHeader1">&nbsp; AFFILIATE INFORMATION</td>
	</tr>
	<tr>
		<td colspan="5" height="5"></td>
	</tr>
</cfoutput>

<cfif isDefined('Form.CustomerID') AND isDefined('getCustomer') AND Form.CustomerID NEQ ''>
	<cfoutput query="getCustomer">
	<tr>
		<td width="10%" height="20">Affiliate ID:</td>
		<td width="39%">TBD</td>
		<td width="10%">Authenticated</td>
		<td width="40%"><cfinput type="checkbox" name="Authenticated" tabindex="14" checked="yes"></td>
	</tr>
	<tr>
		<td><b>First Name:</b></td>
		<td><cfinput class="cfAdminDefault" type="text" name="FirstName" value="#FirstName#" size="35" maxlength="25" required="yes" message="Affiliate's First Name is Required." tabindex="1"></td>
		<td>Website Name:</td>
		<td><cfinput class="cfAdminDefault" type="text" name="WebsiteName" size="35" maxlength="50" required="no" tabindex="15"></td>
	</tr>
	<tr>
		<td><b>Last Name:</b></td>
		<td><cfinput class="cfAdminDefault" type="text" name="LastName" value="#LastName#" size="35" maxlength="35" required="yes" message="Affiliate's Last Name is Required." tabindex="2"></td>
		<td>Website URL:</td>
		<td><cfinput class="cfAdminDefault" type="text" name="WebsiteURL" value="http://" size="35" maxlength="50" required="no" tabindex="16"></td>
	</tr>
	<tr>
		<td>Company Name:</td>
		<td><cfinput class="cfAdminDefault" type="text" name="CompanyName" value="#CompanyName#" size="35" maxlength="50" required="no" tabindex="3"></td>
		<td>Website Category:</td>
		<td>
			<select name="WebsiteCategory" class="cfAdminDefault" size="1" tabindex="17">
				<option value="">--- Select ---</option>
				<option value="Online Store" >Online Store</option>
				<option value="Retail Store" >Retail Store</option>
				<option value="Individual" >Individual</option>
				<option value="Fund Raiser" >Fund Raiser</option>
				<option value="Other" >Other</option>
			</select>
		</td>
	</tr>
	<tr>
		<td><b>Address 1:</b></td>
		<td><cfinput class="cfAdminDefault" type="text" name="Address1" value="#Address1#" size="35" maxlength="35" required="yes" message="Affiliate's Address 1 is Required." tabindex="4"></td>
		<td></td>
		<td></td>
	</tr>
	<tr>
		<td>Address 2:</td>
		<td><cfinput class="cfAdminDefault" type="text" name="Address2" value="#Address2#" size="35" maxlength="35" required="no" tabindex="5"></td>
		<td><!---<b>Membership Type:</b>---></td>
		<td><!---
			<select name="MemberType" class="cfAdminDefault" size="1" tabindex="17">
				<option value="1" >Silver</option>
				<option value="2" >Gold</option>
				<option value="3" >Platinum</option>
			</select>
			--->
		</td>
	</tr>
	<tr>
		<td><b>City:</b></td>
		<td><cfinput class="cfAdminDefault" type="text" name="City" value="#City#" size="35" maxlength="35" required="yes" message="Affiliate's City is Required." tabindex="6"></td>
		<td>Customer Discount Rate:</td>
		<td><cfinput class="cfAdminDefault" type="text" name="CustomerDiscount" value="0" size="10" maxlength="5" required="yes" message="Customer Discount Rate is Required. Enter 0 for no discount." validate="float" tabindex="18">%</td>
	</tr>
	<tr>
		<td><b>State:</b></td>
		<td><cfselect query="getStates" name="State" value="StateCode" selected="#State#" display="State" class="cfAdminDefault" size="1" required="yes" message="Affiliate's State is Required." tabindex="7" /></td>
		<td>Tax ID/SSN:</td>
		<td><cfinput class="cfAdminDefault" type="text" name="TaxID" size="20" maxlength="20" required="no" message="Affiliate's Tax ID or Social Security Number is Required." tabindex="21"> Enter X if unknown</td>
	</tr>
	<tr>
		<td><b>ZIP Code:</b></td>
		<td><cfinput class="cfAdminDefault" type="text" name="ZIP" value="#Zip#" size="10" maxlength="10" required="yes" message="Affiliate's ZIP Code is Required." tabindex="8"></td>
		<td><!---Referral Rate:---></td>
		<td><!---<cfinput class="cfAdminDefault" type="text" name="ReferralRate" value="0" size="10" maxlength="10" required="yes" message="Affiliate's Referral Rate is Required." validate="float" tabindex="20">$--->
			<!---(coming soon)---><input type="hidden" name="ReferralRate" value="0"></td>
	</tr>
	<tr>
		<td><b>Country:</b></td>
		<td><cfselect query="getCountries" name="Country" value="CountryCode" selected="#Country#" display="Country" class="cfAdminDefault" size="1" required="yes" message="Affiliate's Country is Required." tabindex="9" /></td>
		<td><b>Password:</b></td>
		<td><cfinput class="cfAdminDefault" type="text" name="Password" value="#decrypted_Password#" size="20" maxlength="16" required="yes" message="Affiliate's Password is Required." tabindex="22"> 16-Character Max.</td>
	</tr>
	<tr>
		<td><b>Phone:</b></td>
		<td><cfinput class="cfAdminDefault" type="text" name="Phone" value="#Phone#" size="20" maxlength="20" required="yes" message="Affiliate's Phone Number is Required." tabindex="10"></td>
		<td><b>Confirm Password:</b></td>
		<td><cfinput class="cfAdminDefault" type="text" name="PasswordCheck" value="#decrypted_Password#" size="20" maxlength="16" required="yes" message="Please confirm affiliate's password." tabindex="23"> 16-Character Max.</td>
	</tr>
	<tr>
		<td>Fax:</td>
		<td><cfinput class="cfAdminDefault" type="text" name="Fax" value="#Fax#" size="20" maxlength="20" required="no" tabindex="11"></td>
		<td></td>
		<td></td>
	</tr>
	<tr>
		<td><b>Email Address:</b></td>
		<td><cfinput class="cfAdminDefault" type="text" name="Email" value="#Email#" size="35" maxlength="50" required="yes" message="Affiliate's Email Address is Required." tabindex="12"></td>
		<td></td>
		<td></td>
	</tr>
	<tr>
		<td>Bulk Email OK?:</td>
		<td><input type="checkbox" name="EmailOK" <cfif EmailOK EQ 1 >checked</cfif> tabindex="13"></td>
		<td></td>
		<td></td>
	</tr>
	<tr>
		<td colspan="5" height="20"></td>
	</tr>
	<tr>
		<td height="20" style="background-color:##65ADF1;" colspan="2" class="cfAdminHeader1">&nbsp; PARENT AFFILIATE</td>
		<td height="20" style="background-color:##65ADF1;" colspan="2" class="cfAdminHeader1">&nbsp; COMMENTS</td>
	</tr>
	<tr>
		<td colspan="5" height="5"></td>
	</tr>
	<tr>
		<td colspan="2" valign="top">
			<cfselect query="getAffiliates" name="SubAffiliateOf" value="AFID" selected="#AffiliateID#" display="AffiliateName" class="cfAdminDefault" size="1">
				<option value="" selected>-- SELECT PARENT AFFILIATE --</option>
			</cfselect>
		</td>
		<td>Internal Comments:</td>
		<td><textarea name="Comments" rows="3" cols="50" class="cfAdminDefault" tabindex="24"></textarea></td>
	</tr>
	<tr>
		<td height="20" colspan="5"></td>
	</tr>
	<tr style="background-color:##F27028;">
		<td colspan="5" height="20" class="cfAdminHeader3" align="center">
			ADD THIS AFFILIATE
		</td>
	</tr>
	<tr>
		<td height="20" colspan="5"></td>
	</tr>
	<tr>
		<td colspan="5" align="center">
			<input type="submit" name="AddAffiliate" value="ADD AFFILIATE" alt="Add This Affiliate" class="cfAdminButton">
		</td>
	</tr>
	<tr>
		<td height="20" colspan="5"></td>
	</tr>
	<input type="hidden" name="CustomerID" value="#CustomerID#">
	</cfoutput>


<!--- CUSTOMERID NOT DEFINED --->


<cfelse>
	<cfoutput>
	<tr>
		<td width="10%" height="20">Affiliate ID:</td>
		<td width="39%">TBD</td>
		<td width="10%">Authenticated</td>
		<td width="40%"><cfinput type="checkbox" name="Authenticated" tabindex="14"></td>
	</tr>
	<tr>
		<td><b>First Name:</b></td>
		<td><cfinput class="cfAdminDefault" type="text" name="FirstName" size="35" maxlength="25" required="yes" message="Affiliate's First Name is Required." tabindex="1"></td>
		<td>Website Name:</td>
		<td><cfinput class="cfAdminDefault" type="text" name="WebsiteName" size="35" maxlength="50" required="no" tabindex="15"></td>
	</tr>
	<tr>
		<td><b>Last Name:</b></td>
		<td><cfinput class="cfAdminDefault" type="text" name="LastName" size="35" maxlength="35" required="yes" message="Affiliate's Last Name is Required." tabindex="2"></td>
		<td>Website URL:</td>
		<td><cfinput class="cfAdminDefault" type="text" name="WebsiteURL" value="http://" size="35" maxlength="50" required="no" tabindex="16"></td>
	</tr>
	<tr>
		<td>Company Name:</td>
		<td><cfinput class="cfAdminDefault" type="text" name="CompanyName" size="35" maxlength="50" required="no" tabindex="3"></td>
		<td>Website Category:</td>
		<td>
			<select name="WebsiteCategory" class="cfAdminDefault" size="1" tabindex="17">
				<option value="">--- Select ---</option>
				<option value="Online Store" >Online Store</option>
				<option value="Retail Store" >Retail Store</option>
				<option value="Individual" >Individual</option>
				<option value="Fund Raiser" >Fund Raiser</option>
				<option value="Other" >Other</option>
			</select>
		</td>
	</tr>
	<tr>
		<td><b>Address 1:</b></td>
		<td><cfinput class="cfAdminDefault" type="text" name="Address1" size="35" maxlength="35" required="yes" message="Affiliate's Address 1 is Required." tabindex="4"></td>
		<td></td>
		<td></td>
	</tr>
	<tr>
		<td>Address 2:</td>
		<td><cfinput class="cfAdminDefault" type="text" name="Address2" size="35" maxlength="35" required="no" tabindex="5"></td>
		<td><!---<b>Membership Type:</b>---></td>
		<td><!---
			<select name="MemberType" class="cfAdminDefault" size="1" tabindex="17">
				<option value="1" >Silver</option>
				<option value="2" >Gold</option>
				<option value="3" >Platinum</option>
			</select>
			--->
		</td>
	</tr>
	<tr>
		<td><b>City:</b></td>
		<td><cfinput class="cfAdminDefault" type="text" name="City" size="35" maxlength="35" required="yes" message="Affiliate's City is Required." tabindex="6"></td>
		<td>Customer Discount Rate:</td>
		<td><cfinput class="cfAdminDefault" type="text" name="CustomerDiscount" value="0" size="10" maxlength="5" required="yes" message="Customer Discount Rate is Required. Enter 0 for no discount." validate="float" tabindex="18">%</td>
	</tr>
	<tr>
		<td><b>State:</b></td>
		<td><cfselect query="getStates" name="State" value="StateCode" display="State" class="cfAdminDefault" size="1" required="yes" message="Affiliate's State is Required." tabindex="7" /></td>
		<td>Tax ID/SSN:</td>
		<td><cfinput class="cfAdminDefault" type="text" name="TaxID" size="20" maxlength="20" required="no" message="Affiliate's Tax ID or Social Security Number is Required." tabindex="21"> Enter X if unknown</td>
	</tr>
	<tr>
		<td><b>ZIP Code:</b></td>
		<td><cfinput class="cfAdminDefault" type="text" name="ZIP" size="10" maxlength="10" required="yes" message="Affiliate's ZIP Code is Required." tabindex="8"></td>
		<td><!---Referral Rate:---></td>
		<td><!---<cfinput class="cfAdminDefault" type="text" name="ReferralRate" value="0" size="10" maxlength="10" required="yes" message="Affiliate's Referral Rate is Required." validate="float" tabindex="20">$--->
			<!---(coming soon)---><input type="hidden" name="ReferralRate" value="0"></td>
	</tr>
	<tr>
		<td><b>Country:</b></td>
		<td><cfselect query="getCountries" name="Country" value="CountryCode" display="Country" selected="#application.CompanyCountry#" class="cfAdminDefault" size="1" required="yes" message="Affiliate's Country is Required." tabindex="9" /></td>
		<td><b>Password:</b></td>
		<td><cfinput class="cfAdminDefault" type="text" name="Password" size="20" maxlength="16" required="yes" message="Affiliate's Password is Required." tabindex="22"> 16-Character Max.</td>
	</tr>
	<tr>
		<td><b>Phone:</b></td>
		<td><cfinput class="cfAdminDefault" type="text" name="Phone" size="20" maxlength="20" required="yes" message="Affiliate's Phone Number is Required." tabindex="10"></td>
		<td><b>Confirm Password:</b></td>
		<td><cfinput class="cfAdminDefault" type="text" name="PasswordCheck"  size="20" maxlength="16" required="yes" message="Please confirm affiliate's password." tabindex="23"> 16-Character Max.</td>
	</tr>
	<tr>
		<td>Fax:</td>
		<td><cfinput class="cfAdminDefault" type="text" name="Fax" size="20" maxlength="20" required="no" tabindex="11"></td>
		<td></td>
		<td></td>
	</tr>
	<tr>
		<td><b>Email Address:</b></td>
		<td><cfinput class="cfAdminDefault" type="text" name="Email" size="35" maxlength="50" required="yes" message="Affiliate's Email Address is Required." tabindex="12"></td>
		<td></td>
		<td></td>
	</tr>
	<tr>
		<td>Bulk Email OK?:</td>
		<td><input type="checkbox" name="EmailOK" checked tabindex="13"></td>
		<td></td>
		<td></td>
	</tr>
	<tr>
		<td colspan="5" height="20"></td>
	</tr>
	<tr>
		<td height="20" style="background-color:##65ADF1;" colspan="2" class="cfAdminHeader1">&nbsp; PARENT AFFILIATE</td>
		<td height="20" style="background-color:##65ADF1;" colspan="2" class="cfAdminHeader1">&nbsp; COMMENTS</td>
	</tr>
	<tr>
		<td colspan="5" height="5"></td>
	</tr>
	<tr>
		<td colspan="2" valign="top">
			<cfselect query="getAffiliates" name="SubAffiliateOf" value="AFID" display="AffiliateName" class="cfAdminDefault" size="1">
				<option value="" selected>-- SELECT PARENT AFFILIATE --</option>
			</cfselect>
		</td>
		<td>Internal Comments:</td>
		<td><textarea name="Comments" rows="3" cols="50" class="cfAdminDefault" tabindex="24"></textarea></td>
	</tr>
	<tr>
		<td height="20" colspan="5"></td>
	</tr>
	<tr style="background-color:##F27028;">
		<td colspan="5" height="20" class="cfAdminHeader3" align="center">
			ADD THIS AFFILIATE
		</td>
	</tr>
	<tr>
		<td height="20" colspan="5"></td>
	</tr>
	<tr>
		<td colspan="5" align="center">
			<input type="submit" name="AddAffiliate" value="ADD AFFILIATE" alt="Add This Affiliate" class="cfAdminButton">
		</td>
	</tr>
	<tr>
		<td height="20" colspan="5"></td>
	</tr>
	</cfoutput>
</cfif>
</table>
</cfform>

<br><br><br>

<cfinclude template="LayoutAdminFooter.cfm">