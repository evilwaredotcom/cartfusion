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
		}
	return (true);
	}
</script>

<cfif isDefined('URL.ErrorMsg') AND URL.ErrorMsg EQ 1>
	<script language="JavaScript">
		{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
	</script>
</cfif>

<!--- BEGIN: QUERIES ------------------------------------->

<cfinvoke component="#application.Queries#" method="getStates" returnvariable="getStates"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getCountries" returnvariable="getCountries"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getPaymentTypes" returnvariable="getPaymentTypes"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getUsers" returnvariable="getUsers"></cfinvoke>

<!--- END: QUERIES ------------------------------------->

<!--- BEGIN: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<cfif isDefined('Form.AddCustomerInfo')>
	<cfif isUserInRole('Administrator')>
	
		<!--- PREVENT DUPLICATE USERNAME --->
		<cfif isDefined('Form.UserName') AND Form.UserName NEQ ''>
			<cfquery name="preventDuplicate" datasource="#application.dsn#">
				SELECT	UserName
				FROM	Customers
				WHERE	UserName = '#Form.UserName#'
				AND		CustomerID != '#Form.CustomerID#'
			</cfquery>
		</cfif>
		
		<cfif isDefined('preventDuplicate') AND preventDuplicate.RecordCount NEQ 0 >
			<cfset AdminMsg = 'ERROR: UserName Already Taken. Please choose an alternate username.'>
		<cfelseif form.PasswordCheck NEQ form.Password >
			<cfset AdminMsg = 'ERROR: Confirm Password does not match Password' >
		<cfelse>
			<cftry>
				<cfscript>
					Form.DateUpdated = #Now()# ;
					Form.UpdatedBy = #GetAuthUser()# ;
					if ( Form.CardNum NEQ '') Form.CardNum = TRIM(ENCRYPT(Form.CardNum, application.CryptKey, "CFMX_COMPAT", "Hex")) ;
					else Form.CardNum = '';
					if ( Form.ExpDate NEQ '') Form.ExpDate = TRIM(ENCRYPT(Form.ExpDate, application.CryptKey, "CFMX_COMPAT", "Hex")) ;
					else Form.ExpDate = '';
					if ( Form.Password NEQ '') Form.Password = ENCRYPT(Form.Password, application.CryptKey, "CFMX_COMPAT", "Hex") ;
					else Form.Password = '';
				</cfscript>
			
				<cfinsert datasource="#application.dsn#" tablename="Customers" 
					formfields="CustomerID, FirstName, LastName, CompanyName, Address1, Address2, City, State, Zip, Country, 
					ShipFirstName, ShipLastName, ShipCompanyName, ShipAddress1, ShipAddress2, ShipCity, 
					ShipState, ShipZip, ShipCountry, Phone, Fax, Email, EmailOK, Comments, DateUpdated, UpdatedBy,
					CardName, CardNum, ExpDate, CardCVV, PriceToUse, UserName, Password, Deleted, Credit">
				
				<cfset AdminMsg = 'Customer Added Successfully' >
				<cflocation url="CustomerDetail.cfm?CustomerID=#Form.CustomerID#&AdminMsg=#URLEncodedFormat(AdminMsg)#" addtoken="no">
				<cfabort>
			
				<cfcatch>
					<cfset AdminMsg = 'FAIL: Customer NOT Added - #cfcatch.Message#' >
				</cfcatch>
			</cftry>
		</cfif>
	<cfelse>
		<script language="JavaScript">
			{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
		</script>	
	</cfif>
</cfif>
			
<!--- END: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<!--- BEGIN: HEADER --->
<cfscript>
	PageTitle = 'ADD CUSTOMER';
	QuickSearch = 1;
	QuickSearchPage = 'Customers.cfm';
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">
<!--- END: HEADER --->

<cfoutput>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<cfform action="CustomerAdd.cfm" method="post" name="CustomerForm">
	<tr style="background-color:##65ADF1;">
		<td width="49%" colspan="2" height="20" class="cfAdminHeader1">&nbsp; CUSTOMER INFORMATION</td>
		<td width="1%"  rowspan="26" style="background-color:##FFFFFF;">&nbsp;</td>
		<td width="50%" colspan="2" class="cfAdminHeader1">&nbsp; SHIPPING INFORMATION (Same as billing info: <input type="checkbox" name="ShippingEqualsBilling" value="ON" onclick="copyshipping(CustomerForm);">)</td>
	</tr>
	<tr>
		<td colspan="5" height="5"></td>
	</tr>
	<tr>
		<td width="10%">Customer ID:</td>
		<td width="25%">TBD</td>
		<td width="10%"></td>
		<td width="25%"></td>
	</tr>
	<tr>
		<td>First Name:</td>
		<td><cfinput type="text" name="FirstName" size="40" class="cfAdminDefault" tabindex="1"></td>
		<td>First Name:</td>
		<td><cfinput type="text" name="ShipFirstName" size="40" class="cfAdminDefault" tabindex="10"></td>
	</tr>
	<tr>
		<td>Last Name:</td>
		<td><cfinput type="text" name="LastName" size="40" class="cfAdminDefault" tabindex="2"></td>
		<td>Last Name:</td>
		<td><cfinput type="text" name="ShipLastName" size="40" class="cfAdminDefault" tabindex="11"></td>
	</tr>
	<tr>
		<td>Company Name:</td>
		<td><cfinput type="text" name="CompanyName" size="40" class="cfAdminDefault" tabindex="3"></td>
		<td>Company Name:</td>
		<td><cfinput type="text" name="ShipCompanyName" size="40" class="cfAdminDefault" tabindex="12"></td>
	</tr>
	<tr>
		<td>Address 1:</td>
		<td><cfinput type="text" name="Address1" size="40" class="cfAdminDefault" tabindex="4"></td>
		<td>Address 1:</td>
		<td><cfinput type="text" name="ShipAddress1" size="40" class="cfAdminDefault" tabindex="13"></td>
	</tr>
	<tr>
		<td>Address 2:</td>
		<td><cfinput type="text" name="Address2" size="40" class="cfAdminDefault" tabindex="5"></td>
		<td>Address 2:</td>
		<td><cfinput type="text" name="ShipAddress2" size="40" class="cfAdminDefault" tabindex="14"></td>
	</tr>
	<tr>
		<td>City:</td>
		<td><cfinput type="text" name="City" size="40" class="cfAdminDefault" tabindex="6"></td>
		<td>City:</td>
		<td><cfinput type="text" name="ShipCity" size="40" class="cfAdminDefault" tabindex="15"></td>
	</tr>
	<tr>
		<td>State:</td>
		<td><cfselect name="State" query="getStates" size="1" value="StateCode" display="State" class="cfAdminDefault" tabindex="7">
				<cfif NOT isDefined('Form.State') OR Form.State EQ ''><option value="" selected>--- Select ---</option></cfif>
			</cfselect></td>
		<td>State:</td>
		<td><cfselect name="ShipState" query="getStates" size="1" value="StateCode" display="State" class="cfAdminDefault" tabindex="16">
				<cfif NOT isDefined('Form.ShipState') OR Form.ShipState EQ ''><option value="" selected>--- Select ---</option></cfif>
			</cfselect></td>
	</tr>
	<tr>
		<td>ZIP/Postal Code:</td>
		<td><cfinput type="text" name="Zip" size="20" class="cfAdminDefault" tabindex="8"></td>
		<td>ZIP/Postal Code:</td>
		<td><cfinput type="text" name="ShipZip" size="20" class="cfAdminDefault" tabindex="17"></td>
	</tr>
	<tr>
		<td>Country:</td>
		<td><cfselect name="Country" query="getCountries" size="1" value="CountryCode" display="Country" class="cfAdminDefault" tabindex="9">
				<cfif NOT isDefined('Form.Country') OR Form.Country EQ ''><option value="" selected>--- Select ---</option></cfif>
			</cfselect></td>
		<td>Country:</td>
		<td><cfselect name="ShipCountry" query="getCountries" size="1" value="CountryCode" display="Country" class="cfAdminDefault" tabindex="18">
				<cfif NOT isDefined('Form.ShipCountry') OR Form.ShipCountry EQ ''><option value="" selected>--- Select ---</option></cfif>
			</cfselect></td>
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
		<td>Phone:</td>
		<td><cfinput type="text" name="Phone" size="20" class="cfAdminDefault" tabindex="19"></td>
		<td>Card Type:</td>
		<td><cfselect name="CardName" query="getPaymentTypes" size="1" value="Type" display="Display" class="cfAdminDefault" tabindex="23">
				<cfif NOT isDefined('Form.CardName') OR Form.CardName EQ ''><option value="" selected>--- Select ---</option></cfif>
			</cfselect></td>
	</tr>
	<tr>
		<td>Fax:</td>
		<td><cfinput type="text" name="Fax" size="20" class="cfAdminDefault" tabindex="20"></td>
		<td>Card Number:</td>
		<td><cfinput type="text" name="CardNum" size="20" class="cfAdminDefault" tabindex="24"></td>
	</tr>
	<tr>
		<td>Email Address:</td>
		<td><cfinput type="text" name="Email" size="40" class="cfAdminDefault" tabindex="21"></td>
		<td>Expiration Date:</td>
		<td>
			<cfinput type="text" name="ExpDate" size="10" class="cfAdminDefault" tabindex="25"> mm/yy &nbsp;&nbsp;&nbsp;
			CVV ##: <cfinput type="text" name="CardCVV" size="5" class="cfAdminDefault" tabindex="26">
		</td>
	</tr>
	<tr>
		<td>Bulk Email OK?</td>
		<td><cfinput type="checkbox" name="EmailOK" tabindex="22"></td>
		<td>Credit Account Value: </td>
		<td>$<cfinput type="text" name="Credit" validate="float" message="Credit must be a POSITIVE number." class="cfAdminDefault" size="9" tabindex="26"></td>
	</tr>
	<tr>
		<td colspan="5" height="5"></td>
	</tr>
	<tr>
		<td height="20" style="background-color:##65ADF1;" colspan="2" class="cfAdminHeader1">&nbsp; USER INFORMATION</td>
		<td style="background-color:##65ADF1;" colspan="2" class="cfAdminHeader1">&nbsp; HISTORY INFORMATION</td>
	</tr>
	<tr>
		<td colspan="5" height="5"></td>
	</tr>
	<tr>
		<td>Customer Type:</td>
		<td><cfselect query="getUsers" name="PriceToUse" value="UID" display="UName" size="1" class="cfAdminDefault" tabindex="27">
				<cfif NOT isDefined('Form.PriceToUse') OR Form.PriceToUse EQ ''><option value="" selected>--- Select ---</option></cfif>
			</cfselect></td>
		<td>Date Created:</td>
		<td>#DateFormat(Now(), "d-mmm-yyyy")# #TimeFormat(Now(), "@ hh:mm tt")#</td>
	</tr>
	<tr>
		<td>Username:</td>
		<td><cfinput type="text" name="UserName" size="20" class="cfAdminDefault" tabindex="28"></td>
		<td>Input By:</td>
		<td>#GetAuthUser()#</td>
	</tr>
	<tr>
		<td>Password:</td>
		<td><cfinput type="text" name="Password" size="20" maxlength="100" class="cfAdminDefault" tabindex="29"></td>
		<td>Disable Customer?</td>
		<td><cfinput type="checkbox" name="Deleted" tabindex="31"></td>
	</tr>
	<tr>
		<td>Confirm Password:</td>
		<td><cfinput type="text" name="PasswordCheck" size="20" class="cfAdminDefault" tabindex="30"></td>
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
		<td><textarea name="Comments" rows="3" cols="50" tabindex="32" class="cfAdminDefault"><cfif isDefined('Form.Comments')>#Form.Comments#</cfif></textarea></td>
		<td colspan="2" align="center"></td>
	</tr>
	<tr>
		<td height="20" colspan="5"></td>
	</tr>
	<tr style="background-color:##F27028;">
		<td colspan="5" height="20" class="cfAdminHeader3" align="center">
			ADD THIS CUSTOMER
		</td>
	</tr>
	<tr>
		<td height="20" colspan="5"></td>
	</tr>
	<tr>
		<td colspan="5" align="center">
			<input type="submit" name="AddCustomerInfo" value="ADD CUSTOMER" alt="Add Customer" class="cfAdminButton" tabindex="36">
		</td>
	</tr>
	<tr>
		<td height="20" colspan="5"></td>
	</tr>
</table>

	<cfscript>
		CustomerID = FormatBaseN(Now(),10) & RandRange(100,999) & Second(Now()) + 10 ;
	</cfscript>
	<input type="hidden" name="CustomerID" value="#CustomerID#">	
</cfform>

</cfoutput>

<br><br><br>

<cfinclude template="LayoutAdminFooter.cfm">