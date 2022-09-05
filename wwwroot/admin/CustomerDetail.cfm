<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<script type="text/javascript" language="JavaScript">
	function copyshipping(theForm)
	{
	if (theForm.ShippingEqualsBilling.checked)
		{
		theForm.ShipFirstName.value = theForm.FirstName.value;
		theForm.ShipLastName.value = theForm.LastName.value;
		theForm.ShipCompanyName.value = theForm.CompanyName.value;
		theForm.ShipAddress1.value = theForm.Address1.value;
		theForm.ShipAddress2.value = theForm.Address2.value;
		theForm.ShipCity.value = theForm.City.value;
		theForm.ShipState.selectedIndex = theForm.State.selectedIndex;
		theForm.ShipZip.value = theForm.Zip.value;
		theForm.ShipCountry.selectedIndex = theForm.Country.selectedIndex;
		theForm.ShipPhone.value = theForm.Phone.value;
		}
	return (true);
	}
</script>


<!--- BEGIN: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<cfif isDefined('form.UpdateCustomerInfo') AND IsDefined("form.CustomerID")>
	<!--- PREVENT DUPLICATE USERNAME --->
	<cfquery name="preventDuplicate" datasource="#application.dsn#">
		SELECT	UserName
		FROM	Customers
		WHERE	UserName = '#Form.UserName#'
		AND		CustomerID != '#Form.CustomerID#'
	</cfquery>	
	
	<cfif preventDuplicate.RecordCount NEQ 0 >
		<cfset AdminMsg = 'ERROR: UserName Already Taken. Please choose an alternate username.' >
	<cfelseif form.PasswordCheck NEQ form.Password >
		<cfset AdminMsg = 'ERROR: Confirm Password does not match Password' >
	<cfelse>
		<cftry>			
			<!--- ADMINISTRATOR UPDATE --->
			<cfif isUserInRole('Administrator')>
				<cfscript>
					Form.DateUpdated = #Now()# ;
					Form.UpdatedBy = #GetAuthUser()# ;
					Form.Credit = Replace(Form.Credit,',','','ALL') ;
					// updating credit card info requires a secure connection
					if ( application.ShowCreditCardAdmin EQ 1 AND cgi.https is "on" AND Form.CardNum NEQ '' ) Form.CardNum = TRIM(ENCRYPT(Form.CardNum, application.CryptKey, "CFMX_COMPAT", "Hex")) ;
					else Form.CardNum = '';
					if ( application.ShowCreditCardAdmin EQ 1 AND cgi.https is "on" AND Form.ExpDate NEQ '' ) Form.ExpDate = TRIM(ENCRYPT(Form.ExpDate, application.CryptKey, "CFMX_COMPAT", "Hex")) ;
					else Form.ExpDate = '';
					if ( Form.Password NEQ '') Form.Password = ENCRYPT(Form.Password, application.CryptKey, "CFMX_COMPAT", "Hex") ;
					else Form.Password = '';
				</cfscript>
			
				<cfupdate datasource="#application.dsn#" tablename="Customers" 
					formfields="CustomerID, FirstName, LastName, CompanyName, Address1, Address2, City, State, Zip, Country, 
							ShipFirstName, ShipLastName, ShipCompanyName, ShipAddress1, ShipAddress2, ShipCity, ShipPhone, ShipEmail,
							ShipState, ShipZip, ShipCountry, Phone, Fax, Email, EmailOK, Comments, DateUpdated, UpdatedBy,
							CardName, CardNum, ExpDate, CardCVV, PriceToUse, UserName, Password, Deleted, Credit">
			
			<!--- USER UPDATE --->
			<cfelse>
				<cfscript>
					Form.DateUpdated = #Now()# ;
					Form.UpdatedBy = #GetAuthUser()# ;
					Form.Credit = Replace(DecimalFormat(Form.Credit),',','','ALL') ;
					if ( Form.Password NEQ '') Form.Password = ENCRYPT(Form.Password, application.CryptKey, "CFMX_COMPAT", "Hex") ;
					else Form.Password = '';
				</cfscript>
			
				<cfupdate datasource="#application.dsn#" tablename="Customers" 
					formfields="CustomerID, FirstName, LastName, CompanyName, Address1, Address2, City, State, Zip, Country, 
							ShipFirstName, ShipLastName, ShipCompanyName, ShipAddress1, ShipAddress2, ShipCity, ShipPhone, ShipEmail, 
							ShipState, ShipZip, ShipCountry, Phone, Fax, Email, EmailOK, Comments, DateUpdated, UpdatedBy,
							PriceToUse, UserName, Password, Deleted, Credit">
			</cfif>
			
			<cfset AdminMsg = 'Customer Information Updated Successfully' >
				
			<cfcatch>
				<cfset AdminMsg = 'FAIL: Customer NOT Updated. #cfcatch.Message#'>
			</cfcatch>
		</cftry>
	</cfif>
</cfif>
<!--- END: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<cfinvoke component="#application.Queries#" method="getCustomer" returnvariable="getCustomer">
	<cfinvokeargument name="CustomerID" value="#CustomerID#">
</cfinvoke>

<!---
<cfinvoke component="#application.Queries#" method="getCustomerOrders" returnvariable="getCustomerOrders">
	<cfinvokeargument name="CustomerID" value="#CustomerID#">
</cfinvoke>
--->

<cfinvoke component="#application.Queries#" method="getUsers" returnvariable="getUsers"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getStates" returnvariable="getStates"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getCountries" returnvariable="getCountries"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getPaymentTypes" returnvariable="getPaymentTypes"></cfinvoke>

<cfscript>
	if ( getCustomer.CardNum NEQ '') decrypted_CardNum = DECRYPT(getCustomer.CardNum, application.CryptKey, "CFMX_COMPAT", "Hex") ;
	else decrypted_CardNum = '';
	if ( getCustomer.ExpDate NEQ '') decrypted_ExpDate = DECRYPT(getCustomer.ExpDate, application.CryptKey, "CFMX_COMPAT", "Hex") ;
	else decrypted_ExpDate = '';
	if ( getCustomer.Password NEQ '') decrypted_Password = DECRYPT(getCustomer.Password, application.CryptKey, "CFMX_COMPAT", "Hex") ;
	else decrypted_Password = '';
</cfscript>

<!--- BEGIN: HEADER --->
<cfscript>
	PageTitle = 'CUSTOMER DETAIL';
	QuickSearch = 1;
	QuickSearchPage = 'Customers.cfm';
	AddPage = 'CustomerAdd.cfm';
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">
<!--- END: HEADER --->

<cfoutput query="getCustomer">
<table border="0" cellpadding="0" cellspacing="0" width="100%">		
<cfform action="CustomerDetail.cfm" method="post" name="CustomerForm">
	<tr style="background-color:##65ADF1;">
		<td width="49%" colspan="2" height="20" class="cfAdminHeader1">&nbsp; CUSTOMER INFORMATION</td>
		<td width="1%"  rowspan="26" style="background-color:##FFFFFF;">&nbsp;</td>
		<td width="50%" colspan="2" class="cfAdminHeader1">&nbsp; SHIPPING INFORMATION (Same as billing info: <input type="checkbox" name="ShippingEqualsBilling" value="ON" onclick="copyshipping(CustomerForm);">)</td>
	</tr>
	<tr>
		<td colspan="5" height="5"></td>
	</tr>
	<tr>
		<td width="10%" height="20">Customer ID:</td>
		<td width="39%"><a href="CustomerDetail.cfm?CustomerID=#CustomerID#">#CustomerID#</a></td>
		<td width="10%"></td>
		<td width="40%"></td>
	</tr>
	<tr>
		<td>First Name:</td>
		<td><input type="text" name="FirstName" value="#FirstName#" size="40" class="cfAdminDefault" tabindex="1"></td>
		<td>First Name:</td>
		<td><input type="text" name="ShipFirstName" value="#ShipFirstName#" size="40" class="cfAdminDefault" tabindex="10"></td>
	</tr>
	<tr>
		<td>Last Name:</td>
		<td><input type="text" name="LastName" value="#LastName#" size="40" class="cfAdminDefault" tabindex="2"></td>
		<td>Last Name:</td>
		<td><input type="text" name="ShipLastName" value="#ShipLastName#" size="40" class="cfAdminDefault" tabindex="11"></td>
	</tr>
	<tr>
		<td>Company Name:</td>
		<td><input type="text" name="CompanyName" value="#CompanyName#" size="40" class="cfAdminDefault" tabindex="3"></td>
		<td>Company Name:</td>
		<td><input type="text" name="ShipCompanyName" value="#ShipCompanyName#" size="40" class="cfAdminDefault" tabindex="12"></td>
	</tr>
	<tr>
		<td>Address 1:</td>
		<td><input type="text" name="Address1" value="#Address1#" size="40" class="cfAdminDefault" tabindex="4"></td>
		<td>Address 1:</td>
		<td><input type="text" name="ShipAddress1" value="#ShipAddress1#" size="40" class="cfAdminDefault" tabindex="13"></td>
	</tr>
	<tr>
		<td>Address 2:</td>
		<td><input type="text" name="Address2" value="#Address2#" size="40" class="cfAdminDefault" tabindex="5"></td>
		<td>Address 2:</td>
		<td><input type="text" name="ShipAddress2" value="#ShipAddress2#" size="40" class="cfAdminDefault" tabindex="14"></td>
	</tr>
	<tr>
		<td>City:</td>
		<td><input type="text" name="City" value="#City#" size="40" class="cfAdminDefault" tabindex="6"></td>
		<td>City:</td>
		<td><input type="text" name="ShipCity" value="#ShipCity#" size="40" class="cfAdminDefault" tabindex="15"></td>
	</tr>
	<tr>
		<td>State:</td>
		<td><cfselect name="State" query="getStates" size="1"  value="StateCode" display="State" selected="#State#" class="cfAdminDefault" tabindex="7" /></td>
		<td>State:</td>
		<td><cfselect name="ShipState" query="getStates" size="1" value="StateCode" display="State" selected="#ShipState#" class="cfAdminDefault" tabindex="16" /></td>
	</tr>
	<tr>
		<td>ZIP/Postal Code:</td>
		<td><input type="text" name="Zip" value="#Zip#" size="20" class="cfAdminDefault" tabindex="8"></td>
		<td>ZIP/Postal Code:</td>
		<td><input type="text" name="ShipZip" value="#ShipZip#" size="20" class="cfAdminDefault" tabindex="17"></td>
	</tr>
	<tr>
		<td>Country:</td>
		<td><cfselect name="Country" query="getCountries" size="1" value="CountryCode" display="Country" selected="#Country#" class="cfAdminDefault" tabindex="9" /></td>
		<td>Country:</td>
		<td><cfselect name="ShipCountry" query="getCountries" size="1" value="CountryCode" display="Country" selected="#ShipCountry#" class="cfAdminDefault" tabindex="18" /></td>
	</tr>
	<tr>
		<td>Phone:</td>
		<td><input type="text" name="Phone" value="#Phone#" size="20" class="cfAdminDefault" tabindex="9"></td>
		<td>Phone:</td>
		<td><input type="text" name="ShipPhone" value="#ShipPhone#" size="20" class="cfAdminDefault" tabindex="19"></td>
	</tr>
	<tr>
		<td colspan="5" height="5"></td>
	</tr>
	<tr>
		<td height="20" colspan="2" style="background-color:##65ADF1;" class="cfAdminHeader1">&nbsp; CONTACT INFORMATION</td>
		<td colspan="2" style="background-color:##65ADF1;" class="cfAdminHeader1">&nbsp; CREDIT CARD INFORMATION</td>
	</tr>
	<tr>
		<td colspan="5" height="5"></td>
	</tr>
	<tr>
		<td>Fax:</td>
		<td><input type="text" name="Fax" value="#Fax#" size="20" class="cfAdminDefault" tabindex="20"></td>
		<td>Card Type:</td>
		<td>
			<cfif isUserInRole('Administrator') AND application.ShowCreditCardAdmin EQ 1 AND cgi.https is "on" >
				<cfselect name="CardName" query="getPaymentTypes" size="1" value="Type" display="Display" selected="#CardName#" class="cfAdminDefault" tabindex="23">
					<option value="" <cfif CardName EQ ''> selected </cfif> >-- Select --</option>
				</cfselect>
			<cfelse>
				<cfinvoke component="#application.Queries#" method="getPaymentType" returnvariable="getPaymentType">
					<cfinvokeargument name="Type" value="#CardName#">
				</cfinvoke>
				#getPaymentType.Display#
			</cfif>
		</td>
	</tr>
	<tr>
		<td>Email Address:</td>
		<td><input type="text" name="Email" value="#Email#" size="40" class="cfAdminDefault" tabindex="21"></td>
		<td>Card Number:</td>
		<td>
			<cfif isUserInRole('Administrator') AND application.ShowCreditCardAdmin EQ 1 AND cgi.https is "on" >
				<input type="text" name="CardNum" value="#decrypted_CardNum#" size="30" class="cfAdminDefault" tabindex="24">
			<cfelse>
				XXXXXXXXXXXX#Right(decrypted_CardNum,4)#
			</cfif>
		</td>
	</tr>
	<tr>
		<td>Shipping Email Address:</td>
		<td><input type="text" name="ShipEmail" value="#ShipEmail#" size="40" class="cfAdminDefault" tabindex="21"></td>
		<td>Expiration Date:</td>
		<td>
			<cfif isUserInRole('Administrator') AND application.ShowCreditCardAdmin EQ 1 AND cgi.https is "on" >
				<input type="text" name="ExpDate" value="#decrypted_ExpDate#" size="10" class="cfAdminDefault" tabindex="25">&nbsp;&nbsp;&nbsp;
				CVV ##: <input type="text" name="CardCVV" value="#CardCVV#" size="5" class="cfAdminDefault" tabindex="25">
			<cfelse>
				#decrypted_ExpDate# &nbsp;&nbsp;&nbsp; CVV ##: XXXX
			</cfif>
		</td>
	</tr>
	<tr>
		<td>Bulk Email OK?</td>
		<td><input type="checkbox" name="EmailOK" <cfif EmailOK EQ 1> checked </cfif> tabindex="22"></td>
		<td>Credit Account Value:</td>
		<td>$<cfinput type="text" name="Credit" value="#Replace(DecimalFormat(Credit),',','','ALL')#" validate="float" message="Credit must be a POSITIVE number." class="cfAdminDefault" size="9" tabindex="26"></td>
	</tr>
	<tr>
		<td colspan="5" height="5"></td>
	</tr>
	<tr>
		<td height="20" style="background-color:##65ADF1;" colspan="2" class="cfAdminHeader1">&nbsp; USER INFORMATION</td>
		<td style="background-color:##65ADF1;" colspan="2" class="cfAdminHeader1">&nbsp; AUDIT TRAIL</td>
	</tr>
	<tr>
		<td colspan="5" height="5"></td>
	</tr>
	<tr>
		<td>Customer Type:</td>
		<td>
			<cfselect query="getUsers" name="PriceToUse" value="UID" display="UName" selected="#PriceToUse#" size="1" class="cfAdminDefault" tabindex="27" />
		</td>
		<td>Last Updated:</td>
		<td>#DateFormat(DateUpdated, "d-mmm-yyyy")# #TimeFormat(DateUpdated, "@ hh:mm tt")#</td>
	</tr>
	<tr>
		<td>Username:</td>
		<td><input type="text" name="UserName" value="#UserName#" size="20" class="cfAdminDefault" tabindex="28"></td>
		<td>Last Updated By:</td>
		<td>#UpdatedBy#</td>
	</tr>
	<tr>
		<td>Password:</td>
		<td>
			<cfif isUserInRole('Administrator')>
				<input type="text" name="Password" value="#decrypted_Password#" size="20" maxlength="100" class="cfAdminDefault" tabindex="29">
			<cfelse>
				<input type="password" name="Password" value="#decrypted_Password#" size="20" maxlength="100" class="cfAdminDefault" tabindex="29">
			</cfif>
		</td>
		<td>Disable Customer?</td>
		<td><input type="checkbox" name="Deleted" <cfif Deleted EQ 1> checked </cfif> tabindex="31"></td>
	</tr>
	<tr>
		<td>Confirm Password:</td>
		<td>
			<cfif isUserInRole('Administrator')>
				<input type="text" name="PasswordCheck" value="#decrypted_Password#" size="20" class="cfAdminDefault" tabindex="30">
			<cfelse>
				<input type="password" name="PasswordCheck" value="#decrypted_Password#" size="20" class="cfAdminDefault" tabindex="30">
			</cfif>
		</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td colspan="5" height="5"></td>
	</tr>
	<tr>
		<td height="20" style="background-color:##65ADF1;" colspan="5" class="cfAdminHeader1">&nbsp; COMMENTS</td>
	</tr>
	<tr>
		<td colspan="5" height="5"></td>
	</tr>
	<tr>
		<td>Internal Comments:</td>
		<td><textarea name="Comments" rows="3" cols="50" class="cfAdminDefault" tabindex="32">#Comments#</textarea></td>
		<td colspan="2" align="center"></td>
	</tr>
	<tr>
		<td height="20" colspan="5"></td>
	</tr>
	<tr style="background-color:##F27028;">
		<td colspan="5" height="20" class="cfAdminHeader3" align="center">
			UPDATE ABOVE INFORMATION
		</td>
	</tr>
	<tr>
		<td height="20" colspan="5"></td>
	</tr>
	<tr>
		<td colspan="5" align="center">
			<input type="submit" name="UpdateCustomerInfo" value="UPDATE CHANGES" alt="Update Customer Information" class="cfAdminButton">
		</td>
	</tr>
	<tr>
		<td height="20" colspan="5"></td>
	</tr>
</table>
<input type="hidden" name="CustomerID" value="#CustomerID#">	
</cfform>
</cfoutput>

<br><br><br>

<cfinclude template="LayoutAdminFooter.cfm">