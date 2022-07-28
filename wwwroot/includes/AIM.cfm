<cftry>

<!---
	Merchant Account Information
--->
<cfparam name="ATTRIBUTES.Version" default="3.1">
<cfparam name="ATTRIBUTES.Login" default="">
<cfparam name="ATTRIBUTES.Password" default="">
<cfparam name="ATTRIBUTES.TransactionKey" default="">
<cfparam name="ATTRIBUTES.TestRequest" default="False"> <!--- [True | False] --->
<cfif ATTRIBUTES.TestRequest EQ "True">
	<cfparam name="ATTRIBUTES.AuthServer" default="https://certification.authorize.net/gateway/transact.dll">
<cfelse>
	<cfparam name="ATTRIBUTES.AuthServer" default="https://secure.authorize.net/gateway/transact.dll">
</cfif>
<!--- ECHO URL
	https://developer.authorize.net/param_dump.asp
 --->

<!---
	Gateway Response Configuration
--->
<cfparam name="ATTRIBUTES.DelimReturnData" default="True">
<cfparam name="ATTRIBUTES.DelimChar" default=",">
<cfparam name="ATTRIBUTES.EncapChar" default="">
<cfparam name="ATTRIBUTES.RelayResponse" default="False">
<cfparam name="ATTRIBUTES.hashValue" default="">

<!---
	Customer Name and Billing Address
--->
<cfparam name="ATTRIBUTES.FName" default="">
<cfparam name="ATTRIBUTES.LName" default="">
<cfparam name="ATTRIBUTES.Company" default="">
<cfparam name="ATTRIBUTES.StreetAddress" default=""> <!--- 1 line only accepted --->
<cfparam name="ATTRIBUTES.City" default="">
<cfparam name="ATTRIBUTES.State" default="">
<cfparam name="ATTRIBUTES.Zip" default="">
<cfparam name="ATTRIBUTES.Country" default=""> <!--- 2 letter abbreviation --->
<cfparam name="ATTRIBUTES.Phone" default=""> <!--- Recommended format is (123)123-1234 --->
<cfparam name="ATTRIBUTES.Fax" default=""> <!--- Recommended format is (123)123-1234 --->

<!---
	Additional Customer Data
--->
<cfparam name="ATTRIBUTES.CustID" default="001">
<cfparam name="ATTRIBUTES.CustIP" default="#CGI.REMOTE_ADDR#">
<cfparam name="ATTRIBUTES.CustTaxID" default="">

<!---
	Email Settings
--->
<cfparam name="ATTRIBUTES.EmailReceiptToCustomer" default="False"> <!--- [True | False] --->
<cfparam name="ATTRIBUTES.AdditionalMerchantEmail" default=""> <!--- Additional email address to send merchant email confirmation to --->
<cfparam name="ATTRIBUTES.Email" default="">

<!---
	Invoice Information
--->
<cfparam name="ATTRIBUTES.InvoiceNum" default="">
<cfparam name="ATTRIBUTES.Description" default="">

<!---
	Customer Shipping Address
--->
<cfparam name="ATTRIBUTES.ShipToFName" default="">
<cfparam name="ATTRIBUTES.ShipToLName" default="">
<cfparam name="ATTRIBUTES.ShipToCompany" default="">
<cfparam name="ATTRIBUTES.ShipToStreetAddress" default=""> <!--- 1 line only accepted --->
<cfparam name="ATTRIBUTES.ShipToCity" default="">
<cfparam name="ATTRIBUTES.ShipToState" default="">
<cfparam name="ATTRIBUTES.ShipToZip" default="">
<cfparam name="ATTRIBUTES.ShipToCountry" default=""> <!--- 2 letter abbreviation --->

<!---
	Transaction Data
--->
<cfparam name="ATTRIBUTES.InvoiceAmt" default="">
<cfparam name="ATTRIBUTES.RecurringBilling" default="NO"> <!--- [YES | NO] --->
<cfparam name="ATTRIBUTES.CurrencyCode" default="USD">
<cfparam name="ATTRIBUTES.CardNumber" default="">
	<!--- 	Valid Test Card numbers
	370000000000002 - American Express
	6011000000000012 - Discover
	5424000000000015 - MasterCard
	4007000000027 - Visa --->
<cfparam name="ATTRIBUTES.CardExpiration" default="">
	<!--- MMYY, MM/YY, MM-YY, MMYYYY, MM/YYYY, MM-YYYY, YYYY-MM-DD, YYYY/MM/DD --->
<cfparam name="ATTRIBUTES.CardCode" default=""> <!--- 3 or 4 digit number only - valid cvv --->
<cfparam name="ATTRIBUTES.ChargeMethod" default="CC">
<!--- [CC | ECHECK] --->
<cfparam name="ATTRIBUTES.ChargeType" default="AUTH_CAPTURE">
<!--- [AUTH_CAPTURE | AUTH_ONLY | CAPTURE_ONLY | CREDIT | VOID | PRIOR_AUTH_CAPTURE] --->
<cfparam name="ATTRIBUTES.ChargeID" default="">
	<!--- ID of a transaction previously authorized by the gateway if ChargeType
	is CREDIT, VOID, or PRIOR_AUTH_CAPTURE --->
<cfparam name="ATTRIBUTES.ChargeAuthCode" default="">
<!--- Authorization code for a previous transaction not authorized on the gateway 
that is being submitted for capture. if ChargeType is CAPTURE_ONLY --->
	
<cfparam name="ATTRIBUTES.ABACode" default="">
<cfparam name="ATTRIBUTES.BankACNum" default="">
<cfparam name="ATTRIBUTES.BankACType" default=""> <!--- [CHECKING | SAVINGS] defaults to CHECKING --->
<cfparam name="ATTRIBUTES.BankName" default="">
<cfparam name="ATTRIBUTES.BankACHolderName" default="">
<cfparam name="ATTRIBUTES.EcheckType" default="WEB">
<!--- _Bank_ABA_Code *required for x_Method = ECHECK*
Valid routing number 9 max chars
x_Bank_Acct_Num *required for x_Method = ECHECK*
20 max chars
x_Bank_Acct_Type *required for x_Method = ECHECK*
8 max chars
x_Bank_Name *required for x_Method = ECHECK*
50 max chars - Contains the name of the customer�s financial institution.
 x_Bank_Acct_Name *required for x_Method = ECHECK* --->

<!---
	Level 2 Data (OPTIONAL DATA)
--->
<cfparam name="ATTRIBUTES.PONum" default="">
<cfparam name="ATTRIBUTES.Tax" default="">
<cfparam name="ATTRIBUTES.TaxExempt" default="False"> <!--- [True | False] --->
<cfparam name="ATTRIBUTES.Freight" default="">
<cfparam name="ATTRIBUTES.Duty" default="">

<!---
	Wells Fargo SecureSource
--->
<cfparam name="ATTRIBUTES.UseWellsFargo" default="0"> <!--- 0 = NO, 1 = YES --->
<cfparam name="ATTRIBUTES.CustOrgType" default="I"> <!--- I = Individual, B = Business --->
<cfparam name="ATTRIBUTES.DriversLicenseNum" default="">
<cfparam name="ATTRIBUTES.DriversLicenseState" default="">
<cfparam name="ATTRIBUTES.DriversLicenseDOB" default="">


<cfparam name="CALLER.Error" default="0">
<!--- certification https://certification.authorize.net/gateway/transact.dll --->
<!--- live https://secure.quickcommerce.net/gateway/transact.dll --->
<cfhttp method="post" port="443" url="#ATTRIBUTES.AuthServer#">
   
   	<!---
   		Merchant Account Information
	--->
	<cfhttpparam name="x_Version" type="formfield" value="#ATTRIBUTES.Version#">
	<cfhttpparam name="x_Login" type="formfield" value="#ATTRIBUTES.Login#">
	<!---<cfhttpparam name="x_Password" type="formfield" value="#ATTRIBUTES.Password#">---><!--- Trans Key now in place of Password --->
	<cfhttpparam name="x_Tran_Key" type="formfield" value="#ATTRIBUTES.TransactionKey#">
	<cfhttpparam name="x_Test_Request" type="formfield" value="#ATTRIBUTES.TestRequest#">

	<!---
   		Gateway Response Configuration
	--->
	<cfhttpparam name="x_Delim_Data" type="formfield" value="#ATTRIBUTES.DelimReturnData#">
	<cfhttpparam name="x_Delim_Char" type="formfield" value="#ATTRIBUTES.DelimChar#">
	<cfhttpparam name="x_Encap_Char" type="formfield" value="#ATTRIBUTES.EncapChar#">
	<cfhttpparam name="x_Relay_Response" type="formfield" value="#ATTRIBUTES.RelayResponse#">
	
	<!---
   		Customer Name and Billing Address
	--->
	<cfhttpparam name="x_First_Name" type="formfield" value="#ATTRIBUTES.FName#">
	<cfhttpparam name="x_Last_Name" type="formfield" value="#ATTRIBUTES.LName#">
	<cfhttpparam name="x_Company" type="formfield" value="#ATTRIBUTES.Company#">
	<cfhttpparam name="x_Address" type="formfield" value="#ATTRIBUTES.StreetAddress#">
	<cfhttpparam name="x_City" type="formfield" value="#ATTRIBUTES.City#">
	<cfhttpparam name="x_State" type="formfield" value="#ATTRIBUTES.State#">
	<cfhttpparam name="x_Zip" type="formfield" value="#ATTRIBUTES.Zip#">
	<cfhttpparam name="x_Country" type="formfield" value="#ATTRIBUTES.Country#">
	<cfhttpparam name="x_Phone" type="formfield" value="#ATTRIBUTES.Phone#">
	<cfhttpparam name="x_Fax" type="formfield" value="#ATTRIBUTES.Fax#">
	
	<!---
   		Additional Customer Data
	--->
	<cfhttpparam name="x_Cust_ID" type="formfield" value="#ATTRIBUTES.CustID#">
	<cfhttpparam name="x_Customer_IP" type="formfield" value="#ATTRIBUTES.CustIP#">
	<cfhttpparam name="x_Customer_Tax_ID" type="formfield" value="#ATTRIBUTES.CustTaxID#"> <!--- Wells Fargo Echeck Required if no Driver's License info --->
	
	<!---
   		Email Settings
	--->
	<cfhttpparam name="x_Email_Customer" type="formfield" value="#ATTRIBUTES.EmailReceiptToCustomer#">
	<cfhttpparam name="x_Email" type="formfield" value="#ATTRIBUTES.Email#">
	<cfhttpparam name="x_Merchant_Email" type="formfield" value="#ATTRIBUTES.AdditionalMerchantEmail#">
	
	<!---
		Invoice Information
	--->
	<cfhttpparam name="x_Invoice_Num" type="formfield" value="#ATTRIBUTES.invoiceNum#">
	<cfhttpparam name="x_Description" type="formfield" value="#ATTRIBUTES.description#">
	
	<!---
		Customer Shipping Address
	--->
	<cfhttpparam name="x_Ship_To_First_Name" type="formfield" value="#ATTRIBUTES.ShipToFName#">
	<cfhttpparam name="x_Ship_To_Last_Name" type="formfield" value="#ATTRIBUTES.ShipToLName#">
	<cfhttpparam name="x_Ship_To_Company" type="formfield" value="#ATTRIBUTES.ShipToCompany#">
	<cfhttpparam name="x_Ship_To_Address" type="formfield" value="#ATTRIBUTES.ShipToStreetAddress#">
	<cfhttpparam name="x_Ship_To_City" type="formfield" value="#ATTRIBUTES.ShipToCity#">
	<cfhttpparam name="x_Ship_To_State" type="formfield" value="#ATTRIBUTES.ShipToState#">
	<cfhttpparam name="x_Ship_To_Zip" type="formfield" value="#ATTRIBUTES.ShipToZip#">
	<cfhttpparam name="x_Ship_To_Country" type="formfield" value="#ATTRIBUTES.ShipToCountry#">
	
	<!---
		Transaction Data
	--->
	<cfhttpparam name="x_Amount" type="formfield" value="#ATTRIBUTES.invoiceAmt#">
	<cfhttpparam name="x_Currency_Code" type="formfield" value="#ATTRIBUTES.currencyCode#">
	<cfhttpparam name="x_Method" type="formfield" value="#ATTRIBUTES.ChargeMethod#">
	<cfhttpparam name="x_Type" type="formfield" value="#ATTRIBUTES.ChargeType#">
	<cfhttpparam name="x_Recurring_Billing" type="formfield" value="#ATTRIBUTES.RecurringBilling#">		
	<cfif ATTRIBUTES.ChargeMethod eq "CC">
		<cfhttpparam name="x_Card_Num" type="formfield" value="#ATTRIBUTES.CardNumber#">
		<cfhttpparam name="x_Exp_Date" type="formfield" value="#ATTRIBUTES.CardExpiration#">
		<cfif ATTRIBUTES.ChargeType eq "CREDIT" OR ATTRIBUTES.ChargeType eq "VOID" OR ATTRIBUTES.ChargeType eq "PRIOR_AUTH_CAPTURE" OR ATTRIBUTES.ChargeType eq "CAPTURE_ONLY">
			<cfhttpparam name="x_trans_id" type="formfield" value="#ATTRIBUTES.ChargeID#"> 	
		</cfif>
		<cfif ATTRIBUTES.ChargeType eq "CAPTURE_ONLY">
			<cfhttpparam name="x_auth_code" type="formfield" value="#ATTRIBUTES.ChargeAuthCode#">
		</cfif>
		<cfif (Len(ATTRIBUTES.CardCode) eq 3) OR (Len(ATTRIBUTES.CardCode) eq 4)>	
			<cfhttpparam name="x_Card_Code" type="formfield" value="#ATTRIBUTES.CardCode#">
		</cfif>  
	<cfelseif ATTRIBUTES.ChargeMethod eq "ECHECK">
		<cfhttpparam name="x_Bank_ABA_Code" type="formfield" value="#ATTRIBUTES.ABACode#">
		<cfhttpparam name="x_Bank_Acct_Num" type="formfield" value="#ATTRIBUTES.BankACNum#">
		<cfhttpparam name="x_Bank_Acct_Type" type="formfield" value="#ATTRIBUTES.BankACType#">
		<cfhttpparam name="x_Bank_Name" type="formfield" value="#ATTRIBUTES.BankName#">
		<cfhttpparam name="x_Bank_Acct_Name" type="formfield" value="#ATTRIBUTES.BankACHolderName#">
		<cfhttpparam name="x_Echeck_Type" type="formfield" value="#ATTRIBUTES.EcheckType#">
	<cfelse>
	</cfif>
	
	<!---
		Level 2 Data (OPTIONAL DATA)
	--->
	<cfhttpparam name="x_po_num" type="formfield" value="#ATTRIBUTES.PONum#">
	<cfhttpparam name="x_tax" type="formfield" value="#ATTRIBUTES.Tax#">
	<cfhttpparam name="x_tax_exempt" type="formfield" value="#ATTRIBUTES.TaxExempt#">
	<cfhttpparam name="x_freight" type="formfield" value="#ATTRIBUTES.Freight#">
	<cfhttpparam name="x_duty" type="formfield" value="#ATTRIBUTES.Duty#">
	
	<!---
		Wells Fargo SecureSource
	--->
	<cfif ATTRIBUTES.UseWellsFargo EQ "1">
		<cfhttpparam name="x_customer_organization_type" type="formfield" value="#ATTRIBUTES.CustOrgType#">
		<cfhttpparam name="x_drivers_license_num" type="formfield" value="#ATTRIBUTES.DriversLicenseNum#">
		<cfhttpparam name="x_drivers_license_state" type="formfield" value="#ATTRIBUTES.DriversLicenseState#">
		<cfhttpparam name="x_drivers_license_dob" type="formfield" value="#ATTRIBUTES.DriversLicenseDOB#">
	</cfif>
</cfhttp>

<cfoutput>
	<cfset CALLER.FullResponse = #cfhttp.fileContent#>
	<cfset CALLER.FullResponse = Replace(CALLER.FullResponse,",",",-","ALL")>
	<cfset CALLER.ResponseCode = "#ListGetAt(CALLER.FullResponse, 1, ATTRIBUTES.DelimChar)#">  <!--- 1 = Approved | 2 = Declined | 3 = Error --->
	<cfif Left(CALLER.ResponseCode, 1) eq "-">
		<cfset CALLER.ResponseCode = Replace(CALLER.ResponseCode, "-", "")>
	</cfif>
	<cfset CALLER.ResponseSubCode = "#ListGetAt(CALLER.FullResponse, 2, ATTRIBUTES.DelimChar)#">
	<cfif Left(CALLER.ResponseSubCode, 1) eq "-">
		<cfset CALLER.ResponseSubCode = Replace(CALLER.ResponseSubCode, "-", "")>
	</cfif>
	<cfset CALLER.ResponseReasonCode = "#ListGetAt(CALLER.FullResponse, 3, ATTRIBUTES.DelimChar)#">
	<cfif Left(CALLER.ResponseReasonCode, 1) eq "-">
		<cfset CALLER.ResponseReasonCode = Replace(CALLER.ResponseReasonCode, "-", "")>
	</cfif>
	<cfset CALLER.ResponseReasonText = "#ListGetAt(CALLER.FullResponse, 4, ATTRIBUTES.DelimChar)#">
	<cfif Left(CALLER.ResponseReasonText, 1) eq "-">
		<cfset CALLER.ResponseReasonText = Replace(CALLER.ResponseReasonText, "-", "")>
	</cfif>
	<cfset CALLER.ApprovalCode = "#ListGetAt(CALLER.FullResponse, 5, ATTRIBUTES.DelimChar)#">
	<cfif Left(CALLER.ApprovalCode, 1) eq "-">
		<cfset CALLER.ApprovalCode = Replace(CALLER.ApprovalCode, "-", "")>
	</cfif>
	<cfset CALLER.AVSResultCode = "#ListGetAt(CALLER.FullResponse, 6, ATTRIBUTES.DelimChar)#"> 
	<cfif Left(CALLER.AVSResultCode, 1) eq "-">
		<cfset CALLER.AVSResultCode = Replace(CALLER.AVSResultCode, "-", "")>
	</cfif>
	<cfset CALLER.TransactionID = "#ListGetAt(CALLER.FullResponse, 7)#">
	<cfif Left(CALLER.TransactionID, 1) eq "-">
		<cfset CALLER.TransactionID = Replace(CALLER.TransactionID, "-", "")>
	</cfif>
	<cfset CALLER.MD5HashCode = "#ListGetAt(CALLER.FullResponse, 38)#">
	<cfif Left(CALLER.MD5HashCode, 1) eq "-">
		<cfset CALLER.MD5HashCode = Replace(CALLER.MD5HashCode, "-", "")>
	</cfif>
	<cfset CALLER.CardCodeResponse = "#ListGetAt(CALLER.FullResponse, 39)#">
	<cfif Left(CALLER.CardCodeResponse, 1) eq "-">
		<cfset CALLER.CardCodeResponse = Replace(CALLER.CardCodeResponse, "-", "")>
	</cfif>
	<!--- Actual md5 hash used to authenticate md5 hash returned by server --->
	<cfset CALLER.md5original = #hash(ATTRIBUTES.hashValue&ATTRIBUTES.Login&CALLER.TransactionID&DecimalFormat(ATTRIBUTES.invoiceAmt))#>
</cfoutput>

<cfcatch type="any">
	<div class="cfErrorMsg" align="center">There has been an error...</div>
</cfcatch>

</cftry>