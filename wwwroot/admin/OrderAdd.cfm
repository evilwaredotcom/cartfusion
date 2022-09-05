<script type="text/javascript" language="JavaScript">
function copyshipping(theForm){
	if (theForm.ShippingEqualsBilling.checked){
		theForm.OShipFirstName.value = theForm.FirstName.value;
		theForm.OShipLastName.value = theForm.LastName.value;
		theForm.OShipCompanyName.value = theForm.CompanyName.value;
		theForm.OShipAddress1.value = theForm.Address1.value;
		theForm.OShipAddress2.value = theForm.Address2.value;
		theForm.OShipCity.value = theForm.City.value;
		theForm.OShipState.selectedIndex = theForm.State.selectedIndex;
		theForm.OShipZip.value = theForm.Zip.value;
		theForm.OShipCountry.selectedIndex = theForm.Country.selectedIndex;
		theForm.Phone.value = theForm.CustomerPhone.value;
	}
	return (true);
}
</script>

<!--- BEGIN: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<!--- ORDER INFO UPDATE --->
<cfif isDefined('Form.AddOrderInfo') AND IsDefined("Form.FirstName")>
	<!---<cftry>--->
		<cfinvoke component="#application.Queries#" method="getLastOrderID" returnvariable="getLastOrderID"></cfinvoke>
		
		<cfscript>
			// SET ORDER ID
			if (getLastOrderID.RecordCount NEQ 0 AND getLastOrderID.LastOrderID NEQ '')
				Form.OrderID = getLastOrderID.LastOrderID + 1;
			else
				Form.OrderID = '1002700';
			
			// SET BIT	
			if ( isDefined('Form.PaymentVerified') )
				Form.PaymentVerified = 1;
			else
				Form.PaymentVerified = 0;	
			
			if ( Form.CCNum NEQ '' )
				Form.CCNum = TRIM(ENCRYPT(Form.CCNum, application.CryptKey, "CFMX_COMPAT", "Hex")) ;
			if ( Form.CCExpDate NEQ '' ) 
				Form.CCExpDate = TRIM(ENCRYPT(Form.CCExpDate, application.CryptKey, "CFMX_COMPAT", "Hex")) ;		
		</cfscript>
		
		<cfoutput>
		<cfif NOT isDefined('Form.CustomerID')>
			
			<cfscript>
				Form.CustomerID = FormatBaseN(Now(),10) & RandRange(100,999) & Second(Now()) + 10 ;
			</cfscript>
		
			<!---
			<cfinvoke component="#application.Queries#" method="insertCustomer" returnvariable="insertCustomer">
				<cfinvokeargument name="CustomerID" value="#Form.CustomerID#">
				<cfinvokeargument name="FirstName" value="#Form.FirstName#">
				<cfinvokeargument name="LastName" value="#Form.LastName#">
				<cfinvokeargument name="CompanyName" value="#Form.CompanyName#">
				<cfinvokeargument name="Address1" value="#Form.Address1#">
				<cfinvokeargument name="Address2" value="#Form.Address2#">
				<cfinvokeargument name="City" value="#Form.City#">
				<cfinvokeargument name="State" value="#Form.State#">
				<cfinvokeargument name="Zip" value="#Form.Zip#">
				<cfinvokeargument name="Country" value="#Form.Country#">
				<cfinvokeargument name="ShipFirstName" value="#Form.oShipFirstName#">
				<cfinvokeargument name="ShipLastName" value="#Form.oShipLastName#">
				<cfinvokeargument name="ShipCompanyName" value="#Form.oShipCompanyName#">
				<cfinvokeargument name="ShipAddress1" value="#Form.oShipAddress1#">
				<cfinvokeargument name="ShipAddress2" value="#Form.oShipAddress2#">
				<cfinvokeargument name="ShipCity" value="#Form.oShipCity#">
				<cfinvokeargument name="ShipState" value="#Form.oShipState#">
				<cfinvokeargument name="ShipZip" value="#Form.oShipZip#">
				<cfinvokeargument name="ShipCountry" value="#Form.oShipCountry#">
				<cfinvokeargument name="Phone" value="#Form.CustomerPhone#">
				<cfinvokeargument name="Fax" value="#Form.Fax#">
				<cfinvokeargument name="DateUpdated" value="#Now()#">
				<cfinvokeargument name="UpdatedBy" value="#GetAuthUser()#">
				<cfinvokeargument name="CardName" value="#Form.CCName#">
				<cfinvokeargument name="CardNum" value="#Form.CCNum#">
				<cfinvokeargument name="ExpDate" value="#Form.CCExpDate#">
				<cfinvokeargument name="CardCVV" value="#Form.CCCVV#">
				<cfinvokeargument name="PriceToUse" value="#Form.PriceToUse#">
			</cfinvoke>
			--->
			
			<cfquery name="insertCustomer" datasource="#application.dsn#">
				INSERT INTO	Customers
						( 
						CustomerID, 
						FirstName, 
						LastName, 
						CompanyName, 
						Address1, 
						Address2, 
						City, 
						State, 
						Zip, 
						Country, 
						ShipFirstName, 
						ShipLastName, 
						ShipCompanyName, 
						ShipAddress1, 
						ShipAddress2, 
						ShipCity, 
						ShipState, 
						ShipZip, 
						ShipCountry, 
						Phone, 
						Fax, 
						DateUpdated, 
						UpdatedBy,
						CardName, 
						CardNum, 
						ExpDate, 
						CardCVV,
						PriceToUse 
						)
				VALUES	( 
						'#FORM.CustomerID#', 
						'#FORM.FirstName#', 
						'#FORM.LastName#', 
						'#FORM.CompanyName#', 
						'#FORM.Address1#', 
						'#FORM.Address2#', 
						'#FORM.City#', 
						'#FORM.State#', 
						'#FORM.Zip#', 
						'#FORM.Country#', 
						'#FORM.oShipFirstName#', 
						'#FORM.oShipLastName#', 
						'#FORM.oShipCompanyName#', 
						'#FORM.oShipAddress1#', 
						'#FORM.oShipAddress2#', 
						'#FORM.oShipCity#', 
						'#FORM.oShipState#', 
						'#FORM.oShipZip#', 
						'#FORM.oShipCountry#', 
						'#FORM.Phone#', 
						'#FORM.Fax#', 
						#Now()#, 
						'#GetAuthUser()#',
						'#FORM.CCName#', 
						'#FORM.CCNum#', 
						'#FORM.CCExpDate#', 
						'#FORM.CCCVV#',
						#FORM.PriceToUse#
						)
			</cfquery>
		</cfif>
			<!---
			<cfinvoke component="#application.Queries#" method="insertOrder" returnvariable="insertOrder">
				<cfinvokeargument name="SiteID" value="1">
				<cfinvokeargument name="OrderID" value="#Form.OrderID#">
				<cfinvokeargument name="CustomerID" value="#Form.CustomerID#">
				<cfinvokeargument name="OrderStatus" value="#Form.OrderStatus#">
				<cfinvokeargument name="BillingStatus" value="#Form.BillingStatus#">
				<cfinvokeargument name="ShipDate" value="#Form.ShipDate#">
				<cfinvokeargument name="Phone" value="#Form.Phone#">
				<cfinvokeargument name="DateUpdated" value="#Now()#">
				<cfinvokeargument name="UpdatedBy" value="#GetAuthUser()#">
				<cfinvokeargument name="oShipFirstName" value="#Form.oShipFirstName#">
				<cfinvokeargument name="oShipLastName" value="#Form.oShipLastName#">
				<cfinvokeargument name="oShipCompanyName" value="#Form.oShipCompanyName#">
				<cfinvokeargument name="oShipAddress1" value="#Form.oShipAddress1#">
				<cfinvokeargument name="oShipAddress2" value="#Form.oShipAddress2#">
				<cfinvokeargument name="oShipCity" value="#Form.oShipCity#">
				<cfinvokeargument name="oShipState" value="#Form.oShipState#">
				<cfinvokeargument name="oShipZip" value="#Form.oShipZip#">
				<cfinvokeargument name="oShipCountry" value="#Form.oShipCountry#">
				<cfinvokeargument name="CCName" value="#Form.CCName#">
				<cfinvokeargument name="CCNum" value="#Form.CCNum#">
				<cfinvokeargument name="CCExpDate" value="#Form.CCExpDate#">
				<cfinvokeargument name="CCCVV" value="#Form.CCCVV#">
				<cfinvokeargument name="PaymentVerified" value="#Form.PaymentVerified#">
				<cfinvokeargument name="CustomerComments" value="#Form.CustomerComments#">
				<cfinvokeargument name="Comments" value="#Form.Comments#">
				<cfinvokeargument name="ShippingMethod" value="#Form.ShippingMethod#">
				<cfinvokeargument name="TrackingNumber" value="#Form.TrackingNumber#">
				<cfinvokeargument name="FormOfPayment" value="#Form.FormOfPayment#">
				<cfinvokeargument name="IPAddress" value="#CGI.REMOTE_ADDR#">
			</cfinvoke>
			--->
			
			<cfquery name="insertOrder" datasource="#application.dsn#">
				INSERT INTO	Orders
						( 
						SiteID,
						OrderID,
						CustomerID,
						OrderStatus, 
						BillingStatus, 
						<cfif FORM.ShipDate NEQ ''>
						ShipDate,
						</cfif>
						Phone, 
						DateUpdated, 
						UpdatedBy,
						OShipFirstName, 
						OShipLastName, 
						OShipCompanyName, 
						OShipAddress1, 
						OShipAddress2, 
						OShipCity, 
						OShipState, 
						OShipZip, 
						OShipCountry,
						CCName, 
						CCNum, 
						CCExpDate, 
						CCCVV,
						PaymentVerified, 
						CustomerComments, 
						Comments, 
						ShippingMethod, 
						TrackingNumber,
						FormOfPayment,
						IPAddress
						)
				VALUES	( 
						#application.SiteID#,
						#FORM.OrderID#,
						'#FORM.CustomerID#',
						'#FORM.OrderStatus#', 
						'#FORM.BillingStatus#', 
						<cfif FORM.ShipDate NEQ ''>
						#FORM.ShipDate#,
						</cfif>
						'#FORM.Phone#', 
						#Now()#, 
						'#GetAuthUser()#', 
						'#FORM.oShipFirstName#', 
						'#FORM.oShipLastName#', 
						'#FORM.oShipCompanyName#', 
						'#FORM.oShipAddress1#', 
						'#FORM.oShipAddress2#', 
						'#FORM.oShipCity#', 
						'#FORM.oShipState#', 
						'#FORM.oShipZip#', 
						'#FORM.oShipCountry#', 
						'#FORM.CCName#', 
						'#FORM.CCNum#', 
						'#FORM.CCExpDate#', 
						'#FORM.CCCVV#',
						#FORM.PaymentVerified#,
						'#FORM.CustomerComments#', 
						'#FORM.Comments#', 
						'#FORM.ShippingMethod#', 
						'#FORM.TrackingNumber#',
						#FORM.FormOfPayment#,
						'#CGI.REMOTE_ADDR#'
						)
			</cfquery>
		
		<cfset AdminMsg = 'Order #Form.OrderID# Added Successfully. You may add products to this order now.' >
		<cfinclude template="OrderDetail.cfm"><cfabort>
		</cfoutput>
	<!---
		<cfcatch>
			Order NOT Added
		</cfcatch>
	</cftry>--->

</cfif>

<!--- END: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<!--- BEGIN: QUERIES ------------------------------------------------------------->
<cfif isDefined('Form.CustomerID')>
	<cfinvoke component="#application.Queries#" method="getCustomer" returnvariable="getCustomer">
		<cfinvokeargument name="CustomerID" value="#Form.CustomerID#">
	</cfinvoke>
</cfif>
<cfinvoke component="#application.Queries#" method="getCustomers" returnvariable="getCustomers"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getOrderStatusCodes" returnvariable="getOrderStatusCodes"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getBillingStatusCodes" returnvariable="getBillingStatusCodes"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getOrderItemsStatusCodes" returnvariable="getOrderItemsStatusCodes"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getStates" returnvariable="getStates"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getCountries" returnvariable="getCountries"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getPaymentTypes" returnvariable="getPaymentTypes"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getUsers" returnvariable="getUsers"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getShippingMethods" returnvariable="getShippingMethods"></cfinvoke>

<!--- END: QUERIES ------------------------------------------------------------->

<cfscript>
	if ( isDefined('getCustomer.CardNum') AND getCustomer.CardNum NEQ '' ) Decrypted_CardNum = DECRYPT(getCustomer.CardNum, application.CryptKey, "CFMX_COMPAT", "Hex") ;
	else Decrypted_CardNum = '' ;
	if ( isDefined('getCustomer.ExpDate') AND getCustomer.ExpDate NEQ '' ) Decrypted_ExpDate = DECRYPT(getCustomer.ExpDate, application.CryptKey, "CFMX_COMPAT", "Hex") ;
	else Decrypted_ExpDate = '' ;
</cfscript>

<!--- BEGIN: HEADER --->
<cfscript>
	PageTitle = 'ADD ORDER';
	QuickSearch = 1;
	QuickSearchPage = 'Orders.cfm';
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
						APPLY CUSTOMER INFO: 
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
			Customer Type:
			<cfif isDefined('Form.CustomerID') AND Form.CustomerID NEQ ''>
				<cfselect name="PriceToUse" query="getUsers" value="UID" display="UName" selected="#getCustomer.PriceToUse#" size="1" class="cfAdminDefault" tabindex="2" />
			<cfelse>
				<cfselect name="PriceToUse" query="getUsers" value="UID" display="UName" size="1" class="cfAdminDefault" tabindex="2" /> 
			</cfif>
		</td>
		<td width="33%" align="right"><!---&nbsp;It took #getOrderExecutionTime# milliseconds to execute this query---></td>
	</tr>
</table>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr><td align="left" colspan="5"></td></tr>
	<tr><td height="3"></td></tr>
	<tr class="cfAdminHeader1" style="background-color:##65ADF1;">
		<td width="32%" colspan="2" height="20" class="cfAdminHeader1">&nbsp;&nbsp;&nbsp; BILLING INFORMATION</td>
		<td rowspan="15" width="1%" style="background-color:##FFFFFF;">&nbsp;</td>
		<td width="32%" colspan="2" class="cfAdminHeader1">&nbsp;&nbsp;&nbsp; SHIPPING INFORMATION (Same as billing:<input type="checkbox" name="ShippingEqualsBilling" align="bottom" value="ON" onclick="copyshipping(OrderForm);">)</td>
		<td rowspan="15" width="1%" style="background-color:##FFFFFF;">&nbsp;</td>
		<td width="34%" colspan="2" class="cfAdminHeader1">&nbsp;&nbsp;&nbsp; PAYMENT INFORMATION</td>
	</tr>
	<tr>
		<td colspan="8" height="5">&nbsp;</td>
	</tr>
</cfoutput>	

<!--- CUSTOMER IS DEFINED --->


<cfif isDefined('Form.CustomerID') AND isDefined('getCustomer') AND Form.CustomerID NEQ ''>
	<cfoutput query="getCustomer">
		
		<tr>
			<td width="10%"><b>First Name:</b></td>
			<td width="23%"><cfinput type="text" name="FirstName" value="#FirstName#" size="30" class="cfAdminDefault" required="yes" message="Billing First Name Required" tabindex="3"></td>
			<td width="10%"><b>First Name:</b></td>
			<td width="23%"><cfinput type="text" name="OShipFirstName" value="#ShipFirstName#" size="30" class="cfAdminDefault" required="yes" message="Shipping First Name Required" tabindex="14"></td>
			<cfif application.AllowCreditCards EQ 1 >	
				<td width="10%">Card Name:</td>
				<td width="24%">
					<cfselect name="CCName" query="getPaymentTypes" size="1" value="Type" display="Display" selected="#CardName#" class="cfAdminDefault" tabindex="26">
						<option value="" <cfif NOT isDefined('Form.CustomerID')>selected</cfif> >--- Select ---</option>
					</cfselect>
				</td>
			<cfelse>
				<input type="hidden" name="CCName" value=""> <!--- SET Form.CCnum TO BLANK FOR DATABASE UPDATE --->
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</cfif>
		</tr>
		<tr>
			<td><b>Last Name:</b></td>
			<td><cfinput type="text" name="LastName" value="#LastName#" size="30" class="cfAdminDefault" required="yes" message="Billing Last Name Required" tabindex="4"></td>
			<td><b>Last Name:</b></td>
			<td><cfinput type="text" name="OShipLastName" value="#ShipLastName#" size="30" class="cfAdminDefault" required="yes" message="Shipping Last Name Required" tabindex="15"></td>
			<cfif application.AllowCreditCards EQ 1 >
				<td>Card Number:</td>
				<td>
					<cfinput type="text" name="CCnum" value="#Decrypted_CardNum#" size="30" class="cfAdminDefault" tabindex="27" 
						required="no" message="Please enter a valid credit card number">
				</td>
			<cfelse>
				<input type="hidden" name="CCnum" value=""> <!--- SET Form.CCnum TO BLANK FOR DATABASE UPDATE --->
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</cfif>
		</tr>
		<tr>
			<td>Company Name:</td>
			<td><cfinput type="text" name="CompanyName" value="#CompanyName#" size="30" class="cfAdminDefault" tabindex="5"></td>
			<td>Company Name:</td>
			<td><cfinput type="text" name="OShipCompanyName" value="#ShipCompanyName#" size="30" class="cfAdminDefault" tabindex="16"></td>
			<cfif application.AllowCreditCards EQ 1 >
				<td>Exp. Date:</td>
				<td><cfinput type="text" name="CCexpdate" value="#Decrypted_ExpDate#" size="10" class="cfAdminDefault" tabindex="28"
						required="no" message="Please enter a valid expiration date in mm/yy format">&nbsp;&nbsp; 
					CVV ##:
					<cfinput type="text" name="CCCVV" value="#getCustomer.CardCVV#" size="5" class="cfAdminDefault" maxlength="4" tabindex="29"
						required="no" message="Please enter a valid 3 or 4 digit CVV number">
				</td>
			<cfelse>
				<input type="hidden" name="CCexpdate" value=""> <!--- SET Form.CCexpdate TO BLANK FOR DATABASE UPDATE --->
				<input type="hidden" name="CCCVV" value=""> <!--- SET Form.CCCVV TO BLANK FOR DATABASE UPDATE --->
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</cfif>
		</tr>
		<tr>
			<td><b>Address 1:</b></td>
			<td><cfinput type="text" name="Address1" value="#Address1#" size="30" class="cfAdminDefault" required="yes" message="Billing Address 1 Required" tabindex="6"></td>
			<td><b>Address 1:</b></td>
			<td><cfinput type="text" name="OShipAddress1" value="#ShipAddress1#" size="30" class="cfAdminDefault" required="yes" message="Shipping Address 1 Required" tabindex="17"></td>
			<td>Payment Processed:</td>
			<td valign="middle"><cfinput type="checkbox" name="PaymentVerified" tabindex="30"></td>
		</tr>
		<tr>
			<td>Address 2:</td>
			<td><cfinput type="text" name="Address2" value="#Address2#" size="30" class="cfAdminDefault" tabindex="7"></td>
			<td>Address 2:</td>
			<td><cfinput type="text" name="OShipAddress2" value="#ShipAddress2#" size="30" class="cfAdminDefault" tabindex="18"></td>
			<td>Form of Payment:</td>
			<td valign="top">
				<input type="radio" name="FormOfPayment" value="1" <cfif application.AllowCreditCards NEQ 1> disabled <cfelse> checked </cfif> ><img src="images/logos/logo-ODCreditCard.gif"> Credit Card
			</td>
		</tr>
		<tr>	
			<td><b>City:</b></td>
			<td><cfinput type="text" name="City" value="#City#" size="30" class="cfAdminDefault" required="yes" message="Billing City Required" tabindex="8"></td>
			<td><b>City:</b></td>
			<td><cfinput type="text" name="OShipCity" value="#ShipCity#" size="30" class="cfAdminDefault" required="yes" message="Shipping City Required" tabindex="19"></td>
			<td></td>
			<td>
				<input type="radio" name="FormOfPayment" value="2" <cfif application.AllowPayPal NEQ 1> disabled </cfif> ><img src="images/logos/logo-ODPayPal.gif"> PayPal
			</td>
		</tr>
		<tr>	
			<td><b>State:</b></td>
			<td><cfselect query="getStates" name="State" value="StateCode" display="State" selected="#State#" size="1" class="cfAdminDefault" tabindex="9" /></td>
			<td><b>State:</b></td>
			<td><cfselect query="getStates" name="OShipState" value="StateCode" display="State" selected="#ShipState#" size="1" class="cfAdminDefault" tabindex="20" /></td>
			<td></td>
			<td>
				<input type="radio" name="FormOfPayment" value="3" <cfif application.AllowECheck NEQ 1> disabled </cfif> ><img src="images/logos/logo-ODECheck.gif"> E-Check
			</td>
		</tr>
		<tr>	
			<td><b>Zip/Postal:</b></td>
			<td><cfinput type="text" name="Zip" value="#Zip#" size="30" class="cfAdminDefault" required="yes" message="Billing Zip/Postal Code Required" tabindex="10"></td>
			<td><b>Zip/Postal:</b></td>
			<td><cfinput type="text" name="OShipZip" value="#ShipZip#" size="30" class="cfAdminDefault" required="yes" message="Shipping Zip/Postal Code Required" tabindex="21"></td>
			<td></td>
			<td>
				<input type="radio" name="FormOfPayment" value="4" <cfif application.AllowOrderForm NEQ 1> disabled </cfif> ><img src="images/logos/logo-ODOrderForm.gif"> Invoice
			</td>
		</tr>
		<tr>	
			<td><b>Country:</b></td>
			<td><cfselect query="getCountries" name="Country" value="CountryCode" display="Country" selected="#Country#" size="1" class="cfAdminDefault" tabindex="11" /></td>
			<td><b>Country:</b></td>
			<td><cfselect query="getCountries" name="OShipCountry" value="CountryCode" display="Country" selected="#ShipCountry#" size="1" class="cfAdminDefault" tabindex="22" /></td>
			<td></td>
			<td></td>
		</tr>
		<tr>	
			<td><b>Phone:</b></td>
			<td><cfinput type="text" name="CustomerPhone" value="#Phone#" size="30" class="cfAdminDefault" required="yes" message="Billing Phone Required" tabindex="12"></td>
			<td><b>Phone:</b></td>
			<td><cfinput type="text" name="Phone" size="30" value="#Phone#" class="cfAdminDefault" required="yes" message="Shipping Phone Required" tabindex="23"></td>
			<td class="cfAdminHeader1" style="background-color:##65ADF1;" colspan="2">
				&nbsp;&nbsp;&nbsp; STATUS INFORMATION
			</td>
		</tr>
		<tr>	
			<td>Fax:</td>
			<td><cfinput type="text" name="Fax" value="#Fax#" size="30" class="cfAdminDefault" tabindex="13"></td>
			<td>Shipping Method:</td>
			<td><cfselect query="getShippingMethods" name="ShippingMethod" value="ShippingCode" display="ShippingMessage" selected="3" size="1" class="cfAdminDefault" tabindex="24" /></td>
			<td>Order Status:</td>
			<td><cfselect name="OrderStatus" query="getOrderStatusCodes" size="1" value="StatusCode" display="StatusMessage" selected="OD" class="cfAdminDefault" tabindex="31" /></td>
		</tr>
		<tr>
			<td></td>	
			<td></td>
			<td>Tracking ##:</td>
			<td><cfinput type="text" name="TrackingNumber" size="30" class="cfAdminDefault" tabindex="25"></td>
			<td>Ship Date:</td>
			<td><cfinput type="text" name="ShipDate" size="10" validate="date" class="cfAdminDefault" tabindex="32"></td>
		</tr>
		<tr>
			<td height="20" colspan="6"></td>
			<td>Billing Status:</td>
			<td><cfselect name="BillingStatus" query="getBillingStatusCodes" size="1" value="StatusCode" display="StatusMessage" selected="NB" class="cfAdminDefault" tabindex="33" /></td>
		</tr>
		<tr>
			<td colspan="2" height="20" class="cfAdminHeader1">CUSTOMER COMMENTS</td>
			<td></td>
			<td colspan="2" class="cfAdminHeader1">STORE COMMENTS</td>
			<td></td>
			<td colspan="2"></td>			
		</tr>
		<tr>	
			<td colspan="2" rowspan="3">
				<textarea name="CustomerComments" rows="4" cols="45" class="cfAdminDefault" tabindex="34"></textarea></td>	
			<td rowspan="3"></td>
			<td colspan="2" rowspan="3">
				<textarea name="Comments" rows="4" cols="45" class="cfAdminDefault" tabindex="35"></textarea></td>
			<td rowspan="3"></td>
			<td>Date Input:</td>
			<td height="22">#DateFormat(Now(), "d-mmm-yyyy")# #TimeFormat(Now(), "@ hh:mm tt")#</td>
		</tr>
		<tr>
			<td>Input By:</td>
			<td height="22">#GetAuthUser()#</td>
		</tr>
		<tr>
			<td></td>
			<td></td>
		</tr>
		<tr>
			<td height="20" colspan="8"></td>
		</tr>
		<tr style="background-color:##F27028;">
			<td colspan="8" height="20" class="cfAdminHeader3" align="center">
				CONTINUE WITH ABOVE INFORMATION
			</td>
		</tr>
		<tr>
			<td height="20" colspan="8"></td>
		</tr>
		<tr>
			<td colspan="8" align="center">
				<input type="submit" name="AddOrderInfo" value="CONTINUE WITH ORDER" alt="Add Order" class="cfAdminButton" tabindex="36">
			</td>
		</tr>
		<cfif isDefined('CustDetailComments') AND CustDetailComments NEQ ''>
			<tr style="background-color:##CCCCCC;">
				<td height="1" colspan="8"></td>
			</tr>
			<tr>
				<td class="cfAdminHeader1" style="background-color:##65ADF1;" colspan="8" height="20">NOTES ON CUSTOMER</td>
			</tr>
			<tr style="background-color:##CCCCCC;">
				<td height="1" colspan="8"></td>
			</tr>
			<tr class="cfAdminError" style="PADDING: 4px">	
				<td colspan="8">#CustDetailComments#</td>	
			</tr>
		</cfif>
		<input type="hidden" name="CustomerID" value="#CustomerID#">
	</cfoutput>


<!--- CUSTOMERID NOT DEFINED --->


<cfelse>
	<cfoutput>
		<tr>
			<td width="10%"><b>First Name:</b></td>
			<td width="23%"><cfinput type="text" name="FirstName" size="30" class="cfAdminDefault" required="yes" message="Billing First Name Required" tabindex="3"></td>
			<td width="10%"><b>First Name:</b></td>
			<td width="23%"><cfinput type="text" name="OShipFirstName" size="30" class="cfAdminDefault" required="yes" message="Shipping First Name Required" tabindex="14"></td>
			<cfif application.AllowCreditCards EQ 1 >
				<td width="10%">Card Name:</td>
				<td width="24%">
					<cfselect name="CCName" query="getPaymentTypes" size="1" value="Type" display="Display" class="cfAdminDefault" tabindex="26">
						<option value="" selected>--- Select ---</option>
					</cfselect>
				</td>
			<cfelse>
				<input type="hidden" name="CCName" value=""> <!--- SET Form.CCnum TO BLANK FOR DATABASE UPDATE --->
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</cfif>
		</tr>
		<tr>
			<td><b>Last Name:</b></td>
			<td><cfinput type="text" name="LastName" size="30" class="cfAdminDefault" required="yes" message="Billing Last Name Required" tabindex="4"></td>
			<td><b>Last Name:</b></td>
			<td><cfinput type="text" name="OShipLastName" size="30" class="cfAdminDefault" required="yes" message="Shipping Last Name Required" tabindex="15"></td>
			<cfif application.AllowCreditCards EQ 1 >
				<td>Card Number:</td>
				<td><cfinput type="text" name="CCnum" size="30" class="cfAdminDefault" tabindex="27"
						required="no" message="Please enter a valid credit card number"></td>
			<cfelse>
				<input type="hidden" name="CCnum" value=""> <!--- SET Form.CCnum TO BLANK FOR DATABASE UPDATE --->
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</cfif>
		</tr>
		<tr>
			<td>Company Name:</td>
			<td><cfinput type="text" name="CompanyName" size="30" class="cfAdminDefault" tabindex="5"></td>
			<td>Company Name:</td>
			<td><cfinput type="text" name="OShipCompanyName" size="30" class="cfAdminDefault" tabindex="16"></td>
			<cfif application.AllowCreditCards EQ 1 >
				<td>Exp. Date:</td>
				<td><cfinput type="text" name="CCexpdate" size="10" class="cfAdminDefault" tabindex="28"
						required="no" message="Please enter a valid expiration date in mm/yy format">&nbsp;&nbsp; 
					CVV ##:
					<cfinput type="text" name="CCCVV" value="" size="5" class="cfAdminDefault" maxlength="4" tabindex="29"
						required="no" message="Please enter a valid 3 or 4 digit CVV number">				
				</td>
			<cfelse>
				<input type="hidden" name="CCexpdate" value=""> <!--- SET Form.CCexpdate TO BLANK FOR DATABASE UPDATE --->
				<input type="hidden" name="CCCVV" value=""> <!--- SET Form.CCCVV TO BLANK FOR DATABASE UPDATE --->
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</cfif>
		</tr>
		<tr>
			<td><b>Address 1:</b></td>
			<td><cfinput type="text" name="Address1" size="30" class="cfAdminDefault" required="yes" message="Billing Address 1 Required" tabindex="6"></td>
			<td><b>Address 1:</b></td>
			<td><cfinput type="text" name="OShipAddress1" size="30" class="cfAdminDefault" required="yes" message="Shipping Address 1 Required" tabindex="17"></td>
			<td>Payment Processed:</td>
			<td valign="middle"><cfinput type="checkbox" name="PaymentVerified" tabindex="30"></td>
		</tr>
		<tr>
			<td>Address 2:</td>
			<td><cfinput type="text" name="Address2" size="30" class="cfAdminDefault" tabindex="7"></td>
			<td>Address 2:</td>
			<td><cfinput type="text" name="OShipAddress2" size="30" class="cfAdminDefault" tabindex="18"></td>
			<td>Form of Payment:</td>
			<td valign="top">
				<input type="radio" name="FormOfPayment" value="1" <cfif application.AllowCreditCards NEQ 1> disabled <cfelse> checked </cfif> ><img src="images/logos/logo-ODCreditCard.gif"> Credit Card
			</td>
		</tr>
		<tr>	
			<td><b>City:</b></td>
			<td><cfinput type="text" name="City" size="30" class="cfAdminDefault" required="yes" message="Billing City Required" tabindex="8"></td>
			<td><b>City:</b></td>
			<td><cfinput type="text" name="OShipCity" size="30" class="cfAdminDefault" required="yes" message="Shipping City Required" tabindex="19"></td>
			<td></td>
			<td>
				<input type="radio" name="FormOfPayment" value="2" <cfif application.AllowPayPal NEQ 1> disabled </cfif> ><img src="images/logos/logo-ODPayPal.gif"> PayPal
			</td>
		</tr>
		<tr>	
			<td><b>State:</b></td>
			<td><cfselect query="getStates" name="State" value="StateCode" display="State" size="1" class="cfAdminDefault" tabindex="9" /></td>
			<td><b>State:</b></td>
			<td><cfselect query="getStates" name="OShipState" value="StateCode" display="State" size="1" class="cfAdminDefault" tabindex="20" /></td>
			<td></td>
			<td>
				<input type="radio" name="FormOfPayment" value="3" <cfif application.AllowECheck NEQ 1> disabled </cfif> ><img src="images/logos/logo-ODECheck.gif"> E-Check
			</td>
		</tr>
		<tr>	
			<td><b>Zip/Postal:</b></td>
			<td><cfinput type="text" name="Zip" size="30" class="cfAdminDefault" required="yes" message="Billing Zip/Postal Code Required" tabindex="10"></td>
			<td><b>Zip/Postal:</b></td>
			<td><cfinput type="text" name="OShipZip" size="30" class="cfAdminDefault" required="yes" message="Shipping Zip/Postal Code Required" tabindex="21"></td>
			<td></td>
			<td>
				<input type="radio" name="FormOfPayment" value="4" <cfif application.AllowOrderForm NEQ 1> disabled </cfif> ><img src="images/logos/logo-ODOrderForm.gif"> Invoice
			</td>
		</tr>
		<tr>	
			<td><b>Country:</b></td>
			<td><cfselect query="getCountries" name="Country" value="CountryCode" display="Country" selected="US" size="1" class="cfAdminDefault" tabindex="11" /></td>
			<td><b>Country:</b></td>
			<td><cfselect query="getCountries" name="OShipCountry" value="CountryCode" display="Country" selected="US" size="1" class="cfAdminDefault" tabindex="22" /></td>
			<td></td>
			<td></td>
		</tr>
		<tr>	
			<td><b>Phone:</b></td>
			<td><cfinput type="text" name="CustomerPhone" size="30" class="cfAdminDefault" required="yes" message="Billing Phone Required" tabindex="12"></td>
			<td><b>Phone:</b></td>
			<td><cfinput type="text" name="Phone" size="30" class="cfAdminDefault" required="yes" message="Shipping Phone Required" tabindex="23"></td>
			<td class="cfAdminHeader1" style="background-color:##65ADF1;" colspan="2">
				&nbsp;&nbsp;&nbsp; STATUS INFORMATION
			</td>
		</tr>
		<tr>	
			<td>Fax:</td>
			<td><cfinput type="text" name="Fax" size="30" class="cfAdminDefault" tabindex="13"></td>
			<td>Shipping Method:</td>
			<td><cfselect query="getShippingMethods" name="ShippingMethod" value="ShippingCode" display="ShippingMessage" selected="3" size="1" class="cfAdminDefault" tabindex="24" /></td>
			<td>Order Status:</td>
			<td><cfselect name="OrderStatus" query="getOrderStatusCodes" size="1" value="StatusCode" display="StatusMessage" selected="OD" class="cfAdminDefault" tabindex="31" /></td>			
		</tr>
		<tr>
			<td></td>	
			<td></td>
			<td>Tracking ##:</td>
			<td><cfinput type="text" name="TrackingNumber" size="30" class="cfAdminDefault" tabindex="25"></td>
			<td>Ship Date:</td>
			<td><cfinput type="text" validate="date" name="ShipDate" size="10" class="cfAdminDefault" tabindex="32"></td>			
		</tr>
		<tr>
			<td height="20" colspan="6"></td>
			<td>Billing Status:</td>
			<td><cfselect name="BillingStatus" query="getBillingStatusCodes" size="1" value="StatusCode" display="StatusMessage" selected="NB" class="cfAdminDefault" tabindex="33" /></td>
		</tr>
		<tr>
			<td colspan="2" height="20" class="cfAdminHeader1">CUSTOMER COMMENTS</td>
			<td></td>
			<td colspan="2" class="cfAdminHeader1">STORE COMMENTS</td>
			<td></td>
			<td colspan="2"></td>			
		</tr>
		<tr>	
			<td colspan="2" rowspan="3">
				<textarea name="CustomerComments" rows="4" cols="45" class="cfAdminDefault" tabindex="34"></textarea></td>	
			<td rowspan="3"></td>
			<td colspan="2" rowspan="3">
				<textarea name="Comments" rows="4" cols="45" class="cfAdminDefault" tabindex="35"></textarea></td>
			<td rowspan="3"></td>
			<td>Date Input:</td>
			<td height="22">#DateFormat(Now(), "d-mmm-yyyy")# #TimeFormat(Now(), "@ hh:mm tt")#</td>
		</tr>
		<tr>
			<td>Input By:</td>
			<td height="22">#GetAuthUser()#</td>
		</tr>
		<tr>
			<td></td>
			<td></td>
		</tr>
		<tr>
			<td height="20" colspan="8"></td>
		</tr>
		<tr style="background-color:##F27028;">
			<td colspan="8" height="20" class="cfAdminHeader3" align="center">
				CONTINUE WITH ABOVE INFORMATION
			</td>
		</tr>
		<tr>
			<td height="20" colspan="8"></td>
		</tr>
		<tr>
			<td colspan="8" align="center">
				<input type="submit" name="AddOrderInfo" value="CONTINUE WITH ORDER" alt="Add Order" class="cfAdminButton" tabindex="36">
			</td>
		</tr>
		<cfif isDefined('CustDetailComments') AND CustDetailComments NEQ ''>
			<tr style="background-color:##CCCCCC;">
				<td height="1" colspan="8"></td>
			</tr>
			<tr>
				<td class="cfAdminHeader1" style="background-color:##65ADF1;" colspan="8" height="20">NOTES ON CUSTOMER</td>
			</tr>
			<tr style="background-color:##CCCCCC;">
				<td height="1" colspan="8"></td>
			</tr>
			<tr class="cfAdminError" style="PADDING: 4px">	
				<td colspan="8">#CustDetailComments#</td>	
			</tr>
		</cfif>
	</cfoutput>
</cfif>
</table>

</cfform><!--- MAIN FORM --->

<cfinclude template="LayoutAdminFooter.cfm">