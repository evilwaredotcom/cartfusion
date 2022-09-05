<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<!--- BEGIN: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<cfif isDefined('Form.UpdateAffiliateInfo') AND IsDefined('Form.AFID')>
	<cfif isUserInRole('Administrator') OR isUserInRole('Affiliate') >
		<cfif Form.Password NEQ Form.PasswordCheck >
			<cfset AdminMsg = 'ERROR: Confirm Password does not match Password' >
		<cfelse>
			<cftry>
				<cfscript>
					Form.DateUpdated = #Now()# ;
					Form.UpdatedBy = #GetAuthUser()# ;
					
					if ( isDefined('Form.EmailOK') ) Form.EmailOK = 1;
					else Form.EmailOK = 0;
					if ( isDefined('Form.Authenticated') ) Form.Authenticated = 1;
					else Form.Authenticated = 0;
					
					if ( Form.Password NEQ '') Form.Password = ENCRYPT(Form.Password, application.CryptKey, "CFMX_COMPAT", "Hex") ;
					else Form.Password = '';
				</cfscript>
				
				<cfquery name="getCurrentMembership" datasource="#application.dsn#">
					SELECT	MemberType
					FROM	Affiliates
					WHERE	AFID = #Form.AFID#
				</cfquery>
				
				<cfupdate datasource="#application.dsn#" tablename="Affiliates" 
					formfields="AFID, FirstName, LastName, CompanyName, Address1, Address2, City, State, Zip, Country, 
					Phone, Fax, Email, EmailOK, TaxID, Password, WebsiteName, WebsiteURL, WebsiteCategory, Comments,
					CustomerID, MemberType, PaymentFrequency, EmailPayPal, 
					ReferralRate, CustomerDiscount, 
					Authenticated, DateUpdated, UpdatedBy">
				
				<cfif getCurrentMembership.MemberType NEQ Form.MemberType >
					<cfinvoke component="#application.Queries#" method="getAFLevel" returnvariable="getAFLevel">
						<cfinvokeargument name="CommID" value="#Form.MemberType#">
					</cfinvoke>					
					<cfquery name="updateAFHistory" datasource="#application.dsn#">
						INSERT INTO AffiliateHistory
								( AFID, L1, L2, L3, DateEntered )
						VALUES	( #Form.AFID#, #getAFLevel.L1#, #getAFLevel.L2#, #getAFLevel.L3#, #Now()# )
					</cfquery>
				</cfif>
				
				<cfset AdminMsg = 'Affiliate <cfoutput>#AFID#</cfoutput> Information Updated Successfully'>
				
				<cfcatch>
					<cfset AdminMsg = 'FAIL: Affiliate NOT Updated.' >
				</cfcatch>
			</cftry>
		</cfif>
	<cfelse>
		<script language="JavaScript">
			{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
		</script>
	</cfif>
</cfif>

<cfif isDefined('form.AddAFPayment') AND IsDefined("form.AFID") AND form.AFPAmount NEQ ''>
	<cfif isUserInRole('Administrator') OR isUserInRole('Affiliate') >
		<cfinsert datasource="#application.dsn#" tablename="AffiliatePayments" 
			formfields="AFID, AFPDate, AFPAmount, AFPCheck, AFPComments">
		<cfset AdminMsg = 'Affiliate Payment Added Successfully' >
	<cfelse>			
		<script language="JavaScript">
			{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
		</script>
	</cfif>
</cfif>

<cfif isDefined('form.DeleteAFPayment') AND IsDefined("form.AFPID") AND IsDefined("form.AFID")>
	<cfif isUserInRole('Administrator') OR isUserInRole('Affiliate') >
		<cfquery name="deleteAFPayment" datasource="#application.dsn#">
			DELETE
			FROM 	AffiliatePayments
			WHERE	AFPID = #form.AFPID#
			AND		AFID = #Form.AFID#
		</cfquery>			
		<cfset AdminMsg = 'Affiliate Payment Deleted Successfully' >
	<cfelse>			
		<script language="JavaScript">
			{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
		</script>
	</cfif>
</cfif>

<cfif isDefined('Form.UpdateParentAffiliate') AND IsDefined('Form.AFID') AND IsDefined('Form.SubAffiliateOf')>
	<cfif isUserInRole('Administrator') OR isUserInRole('Affiliate') >
		<cftry>	
			<cfset form.DateUpdated = #Now()# >
			<cfset form.UpdatedBy = #GetAuthUser()# >	
			<cfupdate datasource="#application.dsn#" tablename="Affiliates" 
				formfields="AFID, SubAffiliateOf, DateUpdated, UpdatedBy ">
			<cfset AdminMsg = 'Parent Affiliate Updated Successfully' >
			<cfcatch>
				<cfset AdminMsg = 'FAIL: Affiliate NOT Updated.' >
			</cfcatch>
		</cftry>
	<cfelse>			
		<script language="JavaScript">
			{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
		</script>
	</cfif>
</cfif>
<!--- END: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<!--- BEGIN: QUERIES ----------------------------------------------------->
<cfinvoke component="#application.Queries#" method="getCustomers" returnvariable="getCustomers"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getAFLevels" returnvariable="getAFLevels"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getAffiliate" returnvariable="getAffiliate">
	<cfinvokeargument name="AFID" value="#AFID#">
</cfinvoke>
<cfinvoke component="#application.Queries#" method="getOrdersAF" returnvariable="getOrdersAF">
	<cfinvokeargument name="AffiliateID" value="#AFID#">
</cfinvoke>
<cfinvoke component="#application.Queries#" method="getCustomersAF" returnvariable="getCustomersAF">
	<cfinvokeargument name="AffiliateID" value="#AFID#">
</cfinvoke>
<cfinvoke component="#application.Queries#" method="getPaymentsAF" returnvariable="getPaymentsAF">
	<cfinvokeargument name="AFID" value="#AFID#">
</cfinvoke>
<cfinvoke component="#application.Queries#" method="getStates" returnvariable="getStates"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getCountries" returnvariable="getCountries"></cfinvoke>
<cfquery name="getAffiliates" datasource="#application.dsn#">
	SELECT	AFID, convert(varchar, AFID) + ': ' + LastName + ', ' + FirstName AS AffiliateName
	FROM	Affiliates
	WHERE	(Deleted = 0 OR Deleted IS NULL)
	AND		Authenticated = 1
	AND		AFID <> #AFID#
	AND		AFID NOT IN (
			SELECT	a.AFID
			FROM	Affiliates a
			WHERE	a.SubAffiliateOf = #AFID# )
	ORDER BY LastName
</cfquery>

<cfquery name="getAFHistory" datasource="#application.dsn#">
	SELECT	*
	FROM	AffiliateHistory
	WHERE	AFID = #AFID#
	ORDER BY DateEntered DESC
</cfquery>
<!--- END: QUERIES ------------------------------------------------------->

<!--- VARIABLES USED IN THIS PAGE --->
<cfscript>
	if ( getAffiliate.Password NEQ '') decrypted_Password = DECRYPT(getAffiliate.Password, application.CryptKey, "CFMX_COMPAT", "Hex") ;
	else decrypted_Password = '';
	SubTotal = 0 ;
	AffiliateCommission = 0 ;
	CommissionTotal = 0 ;
	AFPaidTotal = 0 ;
	AFUnpaidTotal = 0 ;
</cfscript>

<!--- BEGIN: HEADER --->
<cfscript>
	PageTitle = 'AFFILIATE DETAIL';
	QuickSearch = 1;
	QuickSearchPage = 'Affiliates.cfm';
	AddPage = 'AffiliateAdd.cfm';
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">
<!--- END: HEADER --->

<cfoutput>

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

<cfoutput query="getAffiliate">
<cfform action="AffiliateDetail.cfm" method="post">
	<tr>
		<td width="10%" height="20">Affiliate ID:</td>
		<td width="39%">#AFID#</td>
		<td width="10%">Authenticated</td>
		<td width="40%"><input type="checkbox" name="Authenticated" tabindex="14" <cfif Authenticated EQ 1> checked </cfif> ></td>
	</tr>
	<tr>
		<td><b>First Name:</b></td>
		<td><cfinput class="cfAdminDefault" type="text" name="FirstName" value="#FirstName#" size="35" maxlength="25" required="yes" message="Affiliate's First Name is Required." tabindex="1"></td>
		<td>Website Name:</td>
		<td><cfinput class="cfAdminDefault" type="text" name="WebsiteName" value="#WebsiteName#" size="35" maxlength="50" required="no" tabindex="15"></td>
	</tr>
	<tr>
		<td><b>Last Name:</b></td>
		<td><cfinput class="cfAdminDefault" type="text" name="LastName" value="#LastName#" size="35" maxlength="35" required="yes" message="Affiliate's Last Name is Required." tabindex="2"></td>
		<td>Website URL:</td>
		<td><cfinput class="cfAdminDefault" type="text" name="WebsiteURL" value="#WebsiteURL#" size="35" maxlength="50" required="no" tabindex="16"></td>
	</tr>
	<tr>
		<td>Company Name:</td>
		<td><cfinput class="cfAdminDefault" type="text" name="CompanyName" value="#CompanyName#" size="35" maxlength="50" required="no" tabindex="3"></td>
		<td>Website Category:</td>
		<td>
			<select name="WebsiteCategory" class="cfAdminDefault" size="1" tabindex="17">
				<option value="">--- Select ---</option>
				<option value="Online Store" <cfif WebsiteCategory EQ 'Online Store'>selected</cfif>>Online Store</option>
				<option value="Retail Store" <cfif WebsiteCategory EQ 'Retail Store'>selected</cfif>>Retail Store</option>
				<option value="Individual" <cfif WebsiteCategory EQ 'Individual'>selected</cfif>>Individual</option>
				<option value="Fund Raiser" <cfif WebsiteCategory EQ 'Fund Raiser'>selected</cfif>>Fund Raiser</option>
				<option value="Other" <cfif WebsiteCategory EQ 'Other'>selected</cfif>>Other</option>
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
		<td><b>Membership Type:</b></td>
		<td><cfselect query="getAFLevels" name="MemberType" value="CommID" display="LevelName" selected="#MemberType#" class="cfAdminDefault" size="1" required="yes" message="Affiliate Level is Required." tabindex="18" /></td>
	</tr>
	<tr>
		<td><b>City:</b></td>
		<td><cfinput class="cfAdminDefault" type="text" name="City" value="#City#" size="35" maxlength="35" required="yes" message="Affiliate's City is Required." tabindex="6"></td>
		<td><b>Customer Relation:</b></td>
		<td>
			<cfselect name="CustomerID" query="getCustomers" value="CustomerID" selected="#CustomerID#" display="CustomerInfo" size="1" class="cfAdminDefault" tabindex="19">
				<option value="" <cfif CustomerID EQ ''>selected</cfif> >--- New Customer ---</option>
			</cfselect>
		</td>
	</tr>
	<tr>
		<td><b>State:</b></td>
		<td><cfselect query="getStates" name="State" value="StateCode" display="State" selected="#State#" class="cfAdminDefault" size="1" required="yes" message="Affiliate's State is Required." tabindex="7" /></td>
		<td></td>
		<td></td>
	</tr>
	<tr>
		<td><b>ZIP Code:</b></td>
		<td><cfinput class="cfAdminDefault" type="text" name="ZIP" value="#ZIP#" size="10" maxlength="10" required="yes" message="Affiliate's ZIP Code is Required." tabindex="8"></td>
		<td><!---Referral Rate---></td>
		<td><!---<cfinput class="cfAdminDefault" type="text" name="ReferralRate" value="#DecimalFormat(ReferralRate)#" size="10" maxlength="10" required="no" validate="float" tabindex="20">$--->
			<!---(coming soon)---><input type="hidden" name="ReferralRate" value="0"></td>
	</tr>
	<tr>
		<td><b>Country:</b></td>
		<td><cfselect query="getCountries" name="Country" value="CountryCode" display="Country" selected="#Country#" class="cfAdminDefault" size="1" required="yes" message="Affiliate's Country is Required." tabindex="9" /></td>
		<td>Customer Discount Rate:</td>
		<td><cfinput class="cfAdminDefault" type="text" name="CustomerDiscount" value="#DecimalFormat(CustomerDiscount)#" size="10" maxlength="5" required="yes" validate="float" message="Customer Discount is Required. Enter 0 for no discount." tabindex="19">%</td>
	</tr>
	<tr>
		<td><b>Phone:</b></td>
		<td><cfinput class="cfAdminDefault" type="text" name="Phone" value="#Phone#" size="20" maxlength="20" required="yes" message="Affiliate's Phone Number is Required." tabindex="10"></td>
		<td>Tax ID/SSN:</td>
		<td><cfinput class="cfAdminDefault" type="text" name="TaxID" value="#TaxID#" size="20" maxlength="11" required="no" tabindex="21"></td>
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
		<td><b>Password:</b></td>
		<td><cfinput class="cfAdminDefault" type="text" name="Password" value="#Decrypted_Password#" size="20" maxlength="16" required="yes" message="Password is Required." tabindex="22"> 16-Character Max.</td>
	</tr>
	<tr>
		<td>Bulk Email OK?:</td>
		<td><input type="checkbox" name="EmailOK" tabindex="13" <cfif EmailOK EQ 1> checked </cfif> ></td>
		<td><b>Confirm Password:</b></td>
		<td><cfinput class="cfAdminDefault" type="text" name="PasswordCheck" value="#Decrypted_Password#" size="20" maxlength="16" required="yes" message="Please confirm the password." tabindex="23"> 16-Character Max.</td>
	</tr>
	<tr>
		<td colspan="5" height="20"></td>
	</tr>
	<tr>
		<td height="20" colspan="2" style="background-color:##65ADF1;" class="cfAdminHeader1">&nbsp; COMMENTS</td>
		<td height="20" colspan="2" style="background-color:##65ADF1;" class="cfAdminHeader1">&nbsp; AUDIT TRAIL</td>
	</tr>
	<tr>
		<td colspan="5" height="5"></td>
	</tr>
	<tr>
		<td rowspan="3">Internal Comments:</td>
		<td rowspan="3"><textarea name="Comments" rows="3" cols="50" class="cfAdminDefault" tabindex="24">#Comments#</textarea></td>
		<td>Signup Date:</td>
		<td>#DateFormat(DateCreated, "d-mmm-yyyy")# #TimeFormat(DateCreated, "@ hh:mm tt")#</td>
	</tr>
	<tr>
		<td>Last Updated:</td>
		<td>#DateFormat(DateUpdated, "d-mmm-yyyy")# #TimeFormat(DateUpdated, "@ hh:mm tt")#</td>
	</tr>
	<tr>
		<td>Last Updated By:</td>
		<td>#UpdatedBy#</td>
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
			<input type="submit" name="UpdateAffiliateInfo" value="UPDATE CHANGES" alt="Update Affiliate Information" class="cfAdminButton">
		</td>
	</tr>
</table>
<input type="hidden" name="AFID" value="#AFID#">
</cfform>
</cfoutput>


<!------------------------------------------------- PAYMENTS TO AFFILIATE -------------------------------------------->
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr><td class="cfAdminTitle">PAYMENTS TO AFFILIATE</td></tr>
</table>

<table border="0" cellpadding="3" cellspacing="0" width="100%">
	<tr style="background-color:##7DBF0E;">
		<td width="5%"  class="cfAdminHeader1"></td>
		<td width="10%" class="cfAdminHeader1">Date</td>
		<td width="10%" class="cfAdminHeader1">Amount</td>
		<td width="10%" class="cfAdminHeader1">Check No.</td>
		<td width="30%" class="cfAdminHeader1">Comments</td>
		<td width="*"   class="cfAdminHeader1"></td>
	</tr>
	
	<cfoutput query="getPaymentsAF">
	<cfform action="AffiliateDetail.cfm" method="post">
		<tr>
			<td>
				<input type="submit" name="DeleteAFPayment" value="X" alt="Delete Affiliate Payment" class="cfAdminButton"
					onclick="return confirm('Are you sure you want to DELETE THIS AFFILIATE PAYMENT for $#DecimalFormat(AFPAmount)#?')">
			</td>
			<td>
				<cfinput type="text" name="AFPDate" value="#DateFormat(AFPDate,'mm/dd/yyyy')#" size="15" required="yes" message="Date Required (in mm/dd/yy format) for Affiliate Payment" validate="date" 
					onchange="updateInfo(#AFPID#,this.value,'AFPDate','AffiliatePayments');" class="cfAdminDefault">
			</td>
			<td>
				$ <cfinput type="text" name="AFPAmount" value="#DecimalFormat(AFPAmount)#" size="10" required="yes" message="Amount Required for Affiliate Payment" validate="float" 
					onchange="updateInfo(#AFPID#,this.value,'AFPAmount','AffiliatePayments');" class="cfAdminDefault">
			</td>
			<td><input type="text" name="AFPCheck" value="#AFPCheck#" size="15" onchange="updateInfo(#AFPID#,this.value,'AFPCheck','AffiliatePayments');" class="cfAdminDefault"></td>
			<td><input type="text" name="AFPComments" value="#AFPComments#" size="80" onchange="updateInfo(#AFPID#,this.value,'AFPComments','AffiliatePayments');" class="cfAdminDefault"></td>
			<td></td>
		</tr>
		<!--- DIVIDER --->
		<tr style="background-color:##CCCCCC;">
			<td height="1" colspan="6"></td>
		</tr>
		<input type="hidden" name="AFPID" value="#AFPID#">
		<input type="hidden" name="AFID" value="#AFID#">
	</cfform>
	<cfscript>
		AFPaidTotal = AFPaidTotal + AFPAmount ;
	</cfscript>
	</cfoutput>
	
	<cfform action="AffiliateDetail.cfm" method="post">
		<tr>
			<td>
				<input type="submit" name="AddAFPayment" value="ADD" alt="Add Affiliate Payment" class="cfAdminButton">
			</td>
			<td><cfinput type="text" name="AFPDate" value="#DateFormat(Now(),'mm/dd/yyyy')#" size="15" class="cfAdminDefault" required="yes" message="Date Required (in mm/dd/yy format) for Affiliate Payment" validate="date"></td>
			<td>$ <cfinput type="text" name="AFPAmount" size="10" class="cfAdminDefault" required="yes" message="Amount Required for Affiliate Payment" validate="float"></td>		
			<td><input type="text" name="AFPCheck" size="15" class="cfAdminDefault"></td>
			<td><input type="text" name="AFPComments" size="80" class="cfAdminDefault"></td>
			<td></td>
		</tr>
		<input type="hidden" name="AFID" value="<cfoutput>#AFID#</cfoutput>">
	</cfform>	
</table>
<br><br>


<!------------------------------------------------- AFFILIATE ORDERS -------------------------------------------->
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr><td class="cfAdminTitle">AFFILIATED ORDERS</td></tr>
</table>

<table border="0" cellpadding="3" cellspacing="0" width="100%">
	<tr style="background-color:##7DBF0E;">
		<td width="5%"  class="cfAdminHeader2"></td>
		<td width="10%" class="cfAdminHeader2" nowrap>Order ID</td>
		<td width="10%" class="cfAdminHeader2" nowrap>Order Date</td>
		<td width="12%" class="cfAdminHeader2" nowrap>Customer Billing Status</td>
		<td width="10%" class="cfAdminHeader2" align="center">Level</td>
		<td width="10%" class="cfAdminHeader2" align="right">Order Total</td>
		<td width="10%" class="cfAdminHeader2" align="right" nowrap>Commission %</td>
		<td width="10%" class="cfAdminHeader2" align="right" nowrap>Commission Total</td>
		<td width="23%" class="cfAdminHeader2" align="center"></td>
	</tr>
	<cfoutput query="getOrdersAF">
		<cfform action="AffiliateDetail.cfm" method="post">
			<cfset RunningTotal = 0 >
			<tr>
				<td>
					<input type="button" name="ViewAffiliatedOrder" value="VIEW" alt="View Affiliated Order" class="cfAdminButton"
						onclick="document.location.href='OrderDetail.cfm?OrderID=#OrderID#'">
				</td>
				<td>#OrderID#</td>
				<td>#DateFormat(OrderDate,"dd-mmm-yyyy")#</td>
				<cfinvoke component="#application.Queries#" method="getBillingStatusCode" returnvariable="getBillingStatus">
					<cfinvokeargument name="StatusCode" value="#getOrdersAF.BillingStatus#">
				</cfinvoke>
				<td>#getBillingStatus.StatusMessage#</td>
				
				<!--- AFFILIATE COMMISSION LEVEL --->
				<td align="center">1</td>
				
				<!--- GET ORDER TOTAL --->
				<cfinvoke component="#application.Queries#" method="getOrderTotal" returnvariable="getOrderTotal">
					<cfinvokeargument name="OrderID" value="#getOrdersAF.OrderID#">
				</cfinvoke>
				<cfquery name="getCommLevel1" dbtype="query" maxrows="1">
					SELECT 	L1
					FROM	getAFHistory
					WHERE	DateEntered <= '#OrderDate#'
				</cfquery>
				
				<cfif getCommLevel1.RecordCount EQ 0 >
					<cfset L1 = 0 >
				<cfelse>
					<cfset L1 = getCommLevel1.L1 >
				</cfif>
				
				<cfscript>
					if ( getOrderTotal.RunningTotal EQ '' )
						getOrderTotal.RunningTotal = 0 ;					
					// UPDATE VARIABLES
					RunningTotal = getOrderTotal.RunningTotal - DiscountTotal - CreditApplied ;
					SubTotal = SubTotal + RunningTotal ;
					// ONLY CALCULATE ORDER COMMISSION TOTAL IF ORDER HAS OR WILL BE PAID
					if ( getOrdersAF.BillingStatus EQ 'BI' OR getOrdersAF.BillingStatus EQ 'PA' OR getOrdersAF.BillingStatus EQ 'PP'
					  OR getOrdersAF.BillingStatus EQ 'BC' OR getOrdersAF.BillingStatus EQ 'PC' OR getOrdersAF.BillingStatus EQ 'PK'
					  OR getOrdersAF.BillingStatus EQ 'PK' )
						CommissionTotal = NumberFormat((L1 / 100) * RunningTotal,9.99) ;
					else
						CommissionTotal = 0.00 ;
					AffiliateCommission = AffiliateCommission + CommissionTotal ;
				</cfscript>
				<!--- ORDER TOTAL --->
				<td align="right">#LSCurrencyFormat(RunningTotal, "local")#</td>
				
				<!--- COMMISSION LEVEL PERCENTAGE --->
				<td align="right">#DecimalFormat(L1)#%</td>
				
				<!--- COMMISSION TOTAL --->
				<td align="right">
					$#CommissionTotal#
				</td>
				<td align="center"></td>
			</tr>
			<!--- DIVIDER --->
			<tr style="background-color:##CCCCCC;">
				<td height="1" colspan="9"></td>
			</tr>
		</cfform>
	</cfoutput>
	
	<!--- LEVEL 2 AFFILIATE ORDERS --->
	<cfquery name="getAffiliatesL2" datasource="#application.dsn#">
		SELECT	AFID
		FROM	Affiliates
		WHERE	SubAffiliateOf = #AFID#
	</cfquery>
	<cfif getAffiliatesL2.RecordCount NEQ 0 >
		<cfoutput query="getAffiliatesL2">
			<cfinvoke component="#application.Queries#" method="getOrdersAF" returnvariable="getOrdersAF">
				<cfinvokeargument name="AffiliateID" value="#getAffiliatesL2.AFID#">
			</cfinvoke>
			<cfloop query="getOrdersAF">
				<cfform action="AffiliateDetail.cfm" method="post">
					<cfset RunningTotal = 0 >
					<tr>
						<td>
							<input type="button" name="ViewAffiliatedOrder" value="VIEW" alt="View Affiliated Order" class="cfAdminButton"
								onclick="document.location.href='OrderDetail.cfm?OrderID=#OrderID#'">
						</td>
						<td>#OrderID#</td>
						<td>#DateFormat(OrderDate,"dd-mmm-yyyy")#</td>
						<cfinvoke component="#application.Queries#" method="getBillingStatusCode" returnvariable="getBillingStatus">
							<cfinvokeargument name="StatusCode" value="#getOrdersAF.BillingStatus#">
						</cfinvoke>
						<td>#getBillingStatus.StatusMessage#</td>
						
						<!--- AFFILIATE COMMISSION LEVEL --->
						<td align="center">2</td>
						
						<!--- GET ORDER TOTAL --->
						<cfinvoke component="#application.Queries#" method="getOrderTotal" returnvariable="getOrderTotal">
							<cfinvokeargument name="OrderID" value="#getOrdersAF.OrderID#">
						</cfinvoke>
						
						<cfquery name="getCommLevel2" dbtype="query" maxrows="1">
							SELECT 	L2
							FROM	getAFHistory
							WHERE	DateEntered <= '#OrderDate#'
						</cfquery>

						<cfif getCommLevel2.RecordCount EQ 0 >
							<cfset L2 = 0 >
						<cfelse>
							<cfset L2 = getCommLevel2.L2 >
						</cfif>
						
						<cfscript>
							if ( getOrderTotal.RunningTotal EQ '' )
								getOrderTotal.RunningTotal = 0 ;					
											
							RunningTotal = getOrderTotal.RunningTotal - DiscountTotal - CreditApplied ;
							SubTotal = SubTotal + RunningTotal ;
							// ONLY CALCULATE ORDER COMMISSION TOTAL IF ORDER HAS OR WILL BE PAID
							if ( getOrdersAF.BillingStatus EQ 'BI' OR getOrdersAF.BillingStatus EQ 'PA' OR getOrdersAF.BillingStatus EQ 'PP'
							  OR getOrdersAF.BillingStatus EQ 'BC' OR getOrdersAF.BillingStatus EQ 'PC' OR getOrdersAF.BillingStatus EQ 'PK'
							  OR getOrdersAF.BillingStatus EQ 'PK' )
								CommissionTotal = NumberFormat((L2 / 100) * RunningTotal,9.99) ;
							else
								CommissionTotal = 0.00 ;
							AffiliateCommission = AffiliateCommission + CommissionTotal ;
						</cfscript>
						<!--- ORDER TOTAL --->
						<td align="right">#LSCurrencyFormat(RunningTotal, "local")#</td>
						
						<!--- COMMISSION LEVEL PERCENTAGE --->
						<td align="right">#DecimalFormat(L2)#%</td>
						
						<!--- COMMISSION TOTAL --->
						<td align="right">
							$#CommissionTotal#
						</td>
						<td align="center"></td>
					</tr>
					<!--- DIVIDER --->
					<tr style="background-color:##CCCCCC;">
						<td height="1" colspan="9"></td>
					</tr>
				</cfform>
			</cfloop>
			
			<!--- LEVEL 3 AFFILIATE ORDERS --->
			<cfquery name="getAffiliatesL3" datasource="#application.dsn#">
				SELECT	AFID
				FROM	Affiliates
				WHERE	SubAffiliateOf = #AFID#
			</cfquery>
			<cfif getAffiliatesL3.RecordCount NEQ 0 >
				<cfloop query="getAffiliatesL3">
					<cfinvoke component="#application.Queries#" method="getOrdersAF" returnvariable="getOrdersAF">
						<cfinvokeargument name="AffiliateID" value="#getAffiliatesL3.AFID#">
					</cfinvoke>
					<cfloop query="getOrdersAF">
						<cfform action="AffiliateDetail.cfm" method="post">
							<cfset RunningTotal = 0 >
							<tr>
								<td>
									<input type="button" name="ViewAffiliatedOrder" value="VIEW" alt="View Affiliated Order" class="cfAdminButton"
										onclick="document.location.href='OrderDetail.cfm?OrderID=#OrderID#'">
								</td>
								<td>#OrderID#</td>
								<td>#DateFormat(OrderDate,"dd-mmm-yyyy")#</td>
								<cfinvoke component="#application.Queries#" method="getBillingStatusCode" returnvariable="getBillingStatus">
									<cfinvokeargument name="StatusCode" value="#getOrdersAF.BillingStatus#">
								</cfinvoke>
								<td>#getBillingStatus.StatusMessage#</td>
								
								<!--- AFFILIATE COMMISSION LEVEL --->
								<td align="center">3</td>
								
								<!--- GET ORDER TOTAL --->		
								<cfinvoke component="#application.Queries#" method="getOrderTotal" returnvariable="getOrderTotal">
									<cfinvokeargument name="OrderID" value="#getOrdersAF.OrderID#">
								</cfinvoke>				
								
								<cfquery name="getCommLevel3" dbtype="query" maxrows="1">
									SELECT 	L3
									FROM	getAFHistory
									WHERE	DateEntered <= '#OrderDate#'
								</cfquery>
								
								<cfif getCommLevel3.RecordCount EQ 0 >
									<cfset L3 = 0 >
								<cfelse>
									<cfset L3 = getCommLevel3.L3 >
								</cfif>
								
								<cfscript>
									if ( getOrderTotal.RunningTotal EQ '' )
										getOrderTotal.RunningTotal = 0 ;					
													
									RunningTotal = getOrderTotal.RunningTotal - DiscountTotal - CreditApplied ;
									SubTotal = SubTotal + RunningTotal ;
									// ONLY CALCULATE ORDER COMMISSION TOTAL IF ORDER HAS OR WILL BE PAID
									if ( getOrdersAF.BillingStatus EQ 'BI' OR getOrdersAF.BillingStatus EQ 'PA' OR getOrdersAF.BillingStatus EQ 'PP'
									  OR getOrdersAF.BillingStatus EQ 'BC' OR getOrdersAF.BillingStatus EQ 'PC' OR getOrdersAF.BillingStatus EQ 'PK'
									  OR getOrdersAF.BillingStatus EQ 'PK' )
										CommissionTotal = NumberFormat((L3 / 100) * RunningTotal,9.99) ;
									else
										CommissionTotal = 0.00 ;
									AffiliateCommission = AffiliateCommission + CommissionTotal ;
								</cfscript>
								<!--- ORDER TOTAL --->
								<td align="right">#LSCurrencyFormat(RunningTotal, "local")#</td>
								
								<!--- COMMISSION LEVEL PERCENTAGE --->
								<td align="right">#DecimalFormat(L3)#%</td>
								
								<!--- COMMISSION TOTAL --->
								<td align="right">
									$#CommissionTotal#
								</td>
								<td align="center"></td>
							</tr>
							<!--- DIVIDER --->
							<tr style="background-color:##CCCCCC;">
								<td height="1" colspan="9"></td>
							</tr>
						</cfform>
					</cfloop>
				</cfloop>
			</cfif>
		</cfoutput>
	</cfif>
	
	<cfoutput>
	<tr class="cfAdminDefault" style="background-color:CCCCCC;">
		<!--- REFRESH TOTAL --->
		<td align="right" colspan="5" height="20" class="cfAdminHeader4">
			<input type="button" value="REFRESH TOTALS >>" class="cfAdminButton" onclick="document.location.href='AffiliateDetail.cfm?AFID=#AFID#';">
		</td>
		<td class="cfAdminHeader4" align="right">ORDER TOTALS</td>
		<td class="cfAdminHeader4" align="right" colspan="2">COMMISSION TOTALS</td>
		<td class="cfAdminHeader4"></td>
	</tr>
	<tr>
		<td align="right" colspan="5"><b>TOTALS: ALL</b></td>
		<td align="right">#LSCurrencyFormat(SubTotal, "local")#</td>
		<td></td>
		<td align="right"><b>#LSCurrencyFormat(AffiliateCommission, "local")#</b></td>
		<td></td>
	</tr>
	<cfscript>
		AFUnpaidTotal = AffiliateCommission - AFPaidTotal ;
	</cfscript>
	<tr>
		<td align="right" class="cfAdminError" colspan="5"><b>TOTALS: UNPAID</b></td>
		<td align="right"></td>
		<td></td>
		<td align="right" class="cfAdminError"><b>#LSCurrencyFormat(AFUnpaidTotal, "local")#</b></td>
		<td></td>
	</tr>
	</cfoutput>	
</table>
<br><br>



<!------------------------------------------------- MULTI-TIERED AFFILIATE SYSTEM -------------------------------------------->

<cfquery name="getAffiliatesL2" datasource="#application.dsn#">
	SELECT	*
	FROM	Affiliates
	WHERE	SubAffiliateOf = #AFID#
</cfquery>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr><td class="cfAdminTitle">CHILD AFFILIATES</td></tr>
</table>
<cfif getAffiliatesL2.RecordCount NEQ 0 >
	<table border="0" cellpadding="3" cellspacing="0" width="100%">
		<tr style="background-color:##7DBF0E;">
			<td width="10%" class="cfAdminHeader1" nowrap>Affiliate ID</td>
			<td width="10%" class="cfAdminHeader1" nowrap>Name</td>
			<td width="10%" class="cfAdminHeader1" nowrap>Signup Date</td>
			<td width="10%" class="cfAdminHeader1" nowrap>Revenue Generated</td>
			<td width="5%"  class="cfAdminHeader1" nowrap align="center">Level</td>
			<td width="*"   class="cfAdminHeader1"></td>
		</tr>
		<cfset TotalRevenueGenerated = 0 >
	<!--- LEVEL 2 AFFILIATES --->
	<cfoutput query="getAffiliatesL2">
		<tr>
			<td><a href="AffiliateDetail.cfm?AFID=#getAffiliatesL2.AFID#">#AFID#</a></td>
			<td><a href="AffiliateDetail.cfm?AFID=#getAffiliatesL2.AFID#">#LastName#, #FirstName#</a></td>
			<td>#DateFormat(DateCreated, 'mm/dd/yyyy')#</td>
			<td>
				<cfscript>
					RunningTotal = 0 ;
					RevenueGenerated = 0 ;
				</cfscript>
				<cfinvoke component="#application.Queries#" method="getOrdersAF" returnvariable="getOrdersAF">
					<cfinvokeargument name="AffiliateID" value="#AFID#">
				</cfinvoke>
				<cfloop query="getOrdersAF">
					<!--- GET ORDER TOTAL --->
					<cfinvoke component="#application.Queries#" method="getOrderTotal" returnvariable="getOrderTotal">
						<cfinvokeargument name="OrderID" value="#getOrdersAF.OrderID#">
					</cfinvoke>
					
					<cfscript>
						if ( getOrderTotal.RunningTotal EQ '' )
							getOrderTotal.RunningTotal = 0 ;
						RunningTotal = getOrderTotal.RunningTotal - DiscountTotal - CreditApplied ;
						RevenueGenerated = RevenueGenerated + RunningTotal ;
					</cfscript>
				</cfloop>
				<cfset TotalRevenueGenerated = TotalRevenueGenerated + RevenueGenerated >
				#LSCurrencyFormat(RevenueGenerated, "local")#
			</td>
			<!--- LEVEL --->
			<td align="center">2</td>
			<td></td>
		</tr>
		<!--- DIVIDER --->
		<tr style="background-color:##CCCCCC;">
			<td height="1" colspan="6"></td>
		</tr>
		<!--- LEVEL 3 AFFILIATES --->
		<cfquery name="getAffiliatesL3" datasource="#application.dsn#">
			SELECT	*
			FROM	Affiliates
			WHERE	SubAffiliateOf = #AFID#
		</cfquery>
		<cfif getAffiliatesL3.RecordCount NEQ 0 >
			<cfloop query="getAffiliatesL3">
				<tr>
					<td><a href="AffiliateDetail.cfm?AFID=#getAffiliatesL3.AFID#">#AFID#</a></td>
					<td><a href="AffiliateDetail.cfm?AFID=#getAffiliatesL3.AFID#">#LastName#, #FirstName#</a></td>
					<td>#DateFormat(DateCreated, 'mm/dd/yyyy')#</td>
					<td>
						<cfscript>
							RunningTotal = 0 ;
							RevenueGenerated = 0 ;
						</cfscript>
						<cfinvoke component="#application.Queries#" method="getOrdersAF" returnvariable="getOrdersAF">
							<cfinvokeargument name="AffiliateID" value="#AFID#">
						</cfinvoke>
						<cfloop query="getOrdersAF">
							<!--- GET ORDER TOTAL --->
							<cfinvoke component="#application.Queries#" method="getOrderTotal" returnvariable="getOrderTotal">
								<cfinvokeargument name="OrderID" value="#getOrdersAF.OrderID#">
							</cfinvoke>
							
							<cfscript>
								if ( getOrderTotal.RunningTotal EQ '' )
									getOrderTotal.RunningTotal = 0 ;
								RunningTotal = getOrderTotal.RunningTotal - DiscountTotal - CreditApplied ;
								RevenueGenerated = RevenueGenerated + RunningTotal ;
							</cfscript>
						</cfloop>
						<cfset TotalRevenueGenerated = TotalRevenueGenerated + RevenueGenerated >
						#LSCurrencyFormat(RevenueGenerated, "local")#
					</td>
					<!--- LEVEL --->
					<td align="center">3</td>
					<td></td>
				</tr>
				<!--- DIVIDER --->
				<tr style="background-color:##CCCCCC;">
					<td height="1" colspan="6"></td>
				</tr>
			</cfloop>
		</cfif>
	</cfoutput>
	<cfoutput>	
		<tr>
			<td colspan="3"><b>TOTALS:</b></td>
			<td><b>#LSCurrencyFormat(TotalRevenueGenerated, "local")#</b></td>
			<td></td>
			<td></td>
		</tr>
	</cfoutput>
	</table>
	<br>
<cfelse>
	<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr><td class="cfAdminDefault">No Child Affiliates</td></tr>
	</table>
	<br>
</cfif>

<cfquery name="getParentAffiliate" datasource="#application.dsn#">
	SELECT	*
	FROM	Affiliates
	WHERE	AFID = '#getAffiliate.SubAffiliateOf#'
</cfquery>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr><td class="cfAdminTitle">PARENT AFFILIATE</td></tr>
</table>
<cfif getParentAffiliate.RecordCount NEQ 0 >		
	<table border="0" cellpadding="3" cellspacing="0" width="100%">
		<tr style="background-color:##7DBF0E;">
			<td width="10%" class="cfAdminHeader1">Affiliate ID</td>
			<td width="10%" class="cfAdminHeader1">Date Signed</td>
			<td width="10%" class="cfAdminHeader1">Name</td>
			<td width="15%" class="cfAdminHeader1">Revenue Generated</td>
			<td width="15%" class="cfAdminHeader1"></td>
			<td width="*"   class="cfAdminHeader1"></td>
		</tr>
	<cfoutput query="getParentAffiliate">
		<tr>
			<td><a href="AffiliateDetail.cfm?AFID=#getParentAffiliate.AFID#">#AFID#</a></td>
			<td>#DateFormat(DateCreated, 'mm/dd/yyyy')#</td>
			<td><a href="AffiliateDetail.cfm?AFID=#getParentAffiliate.AFID#">#LastName#, #FirstName#</a></td>
			<td>
				<cfscript>
					RevenueGenerated = 0 ;
					RunningTotal = 0 ;
				</cfscript>
				<cfinvoke component="#application.Queries#" method="getOrdersAF" returnvariable="getOrdersAF">
					<cfinvokeargument name="AffiliateID" value="#AFID#">
				</cfinvoke>
				<cfloop query="getOrdersAF">
					<!--- GET ORDER TOTAL --->
					<cfinvoke component="#application.Queries#" method="getOrderTotal" returnvariable="getOrderTotal">
						<cfinvokeargument name="OrderID" value="#getOrdersAF.OrderID#">
					</cfinvoke>
					
					<cfscript>
						if ( getOrderTotal.RunningTotal EQ '' )
							getOrderTotal.RunningTotal = 0 ;
						RunningTotal = getOrderTotal.RunningTotal - DiscountTotal - CreditApplied ;
						RevenueGenerated = RevenueGenerated + RunningTotal ;
					</cfscript>
				</cfloop>
				#LSCurrencyFormat(RevenueGenerated, "local")#
			</td>
			<td></td>
			<td></td>
		</tr>
		<!--- DIVIDER --->
		<tr style="background-color:##CCCCCC;">
			<td height="1" colspan="6"></td>
		</tr>
	</cfoutput>
	</table>
</cfif>
<!--- NO PARENT AFFILIATE ASSIGNED --->
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr><td height="1"><img src="images/image-LineWhite.gif" width="100%" height="1"></td></tr>
	<tr><td height="1"><img src="images/image-LineGray.gif" width="100%" height="1"></td></tr>
	<tr><td height="3"><img src="images/image-LineWhite.gif" width="100%" height="3"></td></tr>
	<cfform action="AffiliateDetail.cfm" method="post">
	<tr>
		<td class="cfAdminDefault">
			<cfselect query="getAffiliates" name="SubAffiliateOf" value="AFID" display="AffiliateName" 
				selected="#getAffiliate.SubAffiliateOf#" class="cfAdminDefault" size="1">
				<option value="" <cfif getAffiliate.SubAffiliateOf EQ ''>selected</cfif>>-- SELECT PARENT AFFILIATE --</option>
			</cfselect>
			<input type="submit" name="UpdateParentAffiliate" value="UPDATE" alt="Update Parent Affiliate" class="cfAdminButton">
		</td>
	</tr>
	<input type="hidden" name="AFID" value="<cfoutput>#AFID#</cfoutput>">
	</cfform>
</table>
<br><br>





<!------------------------------------------------- CUSTOMERS OF AFFILIATE -------------------------------------------->
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr><td class="cfAdminTitle">CUSTOMERS OF AFFILIATE</td></tr>
</table>

<table border="0" cellpadding="3" cellspacing="0" width="100%">
	<tr style="background-color:##7DBF0E;">
		<td width="5%"  class="cfAdminHeader1"></td>
		<td width="10%" class="cfAdminHeader1">Customer ID</td>
		<td width="10%" class="cfAdminHeader1">Customer Name</td>
		<td width="10%" class="cfAdminHeader1" align="center">No. of Orders</td>
		<td width="30%" class="cfAdminHeader1" align="center">Relate All Orders To Affiliate</td>
		<td width="*"   class="cfAdminHeader1"></td>
	</tr>
	
	<cfoutput query="getCustomersAF">
	<cfform action="AffiliateDetail.cfm" method="post">
		<tr>
			<td>
				<input type="button" name="ViewAffiliatedCust" value="VIEW" alt="View Affiliated Customer" class="cfAdminButton"
					onclick="document.location.href='CustomerDetail.cfm?CustomerID=#CustomerID#'">
			</td>
			<td>#CustomerID#</td>
			<td>#CustomerName#</td>
			<td align="center">#CustomerOrders#</td>
			<td align="center">(coming soon)</td>
			<td></td>
		</tr>
		<!--- DIVIDER --->
		<tr style="background-color:##CCCCCC;">
			<td height="1" colspan="6"></td>
		</tr>
		<input type="hidden" name="AFID" value="#AFID#">
	</cfform>
	</cfoutput>
	
</table>
<br><br><br>

<cfinclude template="LayoutAdminFooter.cfm">