<cfif session.CustomerArray[26] EQ ''>
	<cflocation url="#application.siteConfig.data.RootURL#/CartEdit.cfm" addtoken="no">
</cfif>

<!--- VALIDATE OPTIONS INFORMATION ENTRIES --->
<cfif NOT isDefined('ErrorPayment') >
	<cfif not structKeyExists(form, 'ShippingMethod1') OR trim(form.ShippingMethod1) EQ '' >
		<cfset ErrorOptions = 1 >
	</cfif>
</cfif>

<cfif isDefined('ErrorOptions')>
	<cflocation url="CO-Options.cfm?ErrorOptions=#ErrorOptions#" addtoken="no">
	<cfabort>
</cfif>

<cfoutput>
	<cfmodule template="tags/layout.cfm" CurrentTab="MyAccount" LayoutStyle="Full" PageTitle="Check Out - Step 4 of 4" showCategories="false">

	<!--- Start Breadcrumb --->
	<cfmodule template="tags/breadCrumbs.cfm" CrumbLevel='2' showLinkCrumb="Cart|Check Out - Step 3 of 4" />
	<!--- End BreadCrumb --->

	<table width="98%" align="center" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td style="padding-top:10px; padding-bottom:5px;" align="right">
				<img src="images/image-CheckoutProcess3.gif" border="0" hspace="3" align="absmiddle">
				<br>
				<br>
			</td>
		</tr>
	</table>


	<!--- BEGIN: CLICK BUTTON - CONFIRM OR CANCEL ORDER --->
<cfif IsDefined('Form.Step4.x') AND NOT isDefined('ErrorPayment')>
	
	<!--- STORE CREDIT --------------------------------------------------------------------------------------------------------->
	<cfif structKeyExists(form, 'CreditToApply') and form.CreditToApply NEQ 0 >
		<cfset form.CreditToApply = Replace(Form.CreditToApply,',','','ALL') >
		<cfinclude template="Includes/CalculateTotal.cfm">
		<!--- INVALID/NEGATIVE AMOUNT --->
		<cfif form.CreditToApply LT 0 >
			<cfset ErrorPayment = 7 >
		<!--- NOT ENOUGH AVAILABLE CREDIT --->
		<cfelseif form.CreditToApply GT Form.AvailableCredit >
			<cfset ErrorPayment = 8 >
		<!--- CREDIT WON'T COVER WHOLE ORDER, NEED ADDITIONAL FUNDING SOURCE --->
		<cfelseif form.CreditToApply LT OrderTotal AND NOT isDefined('Form.FormOfPayment') >
			<cfset ErrorPayment = 9 >
		<!--- APPLY CREDIT TO WHOLE ORDER --->
		<cfelseif form.CreditToApply GTE OrderTotal >
			<cfif form.CreditToApply GT OrderTotal >
				<cfset Form.CreditToApply = OrderTotal >
			</cfif>
			<cfset FullCreditAmount = 1 >
			<cfset FORM.FormOfPayment = 0 >
			<cfset BillingStatus = 'PA' >
		<!--- ALL IS GOOD, CONTINUE TO FUND WITH STORE CREDIT AND OTHER SOURCE --->
		<cfelseif isDefined('form.FormOfPayment') >
			<cfset IncludeCredit = 1 >
		<cfelse>
			<cfset ErrorPayment = 9 >
		</cfif>
	</cfif>
	
	<!--- CREDIT CARD ERROR CHECKING GOES HERE, BEFORE GOING TO CO-PLACEORDER.CFM ---------------------------------------------->
	<cfif structKeyExists(form, 'FormOfPayment') and form.FormOfPayment EQ 1 >
		<cfinclude template="Includes/ValidateCC.cfm">
	</cfif>
	<!------------------------------------------------------------>
	<!--- IF CREDIT CARD IS ERROR FREE, CONTINUE PLACING ORDER --->
	<cfif not isDefined('ErrorPayment') AND structKeyExists(form, 'FormOfPayment') and ( not isDefined('FullCreditAmount') OR isDefined('IncludeCredit') ) >
		
		<!--- VALIDATE PAYMENT INFORMATION ENTRIES --->
		<cfif Form.FormOfPayment EQ 1 AND
			 (Form.CardName EQ '' OR
			  Form.CardNum EQ '' OR
			  Form.ExpDate EQ '' OR
			  Form.CardCVV EQ '' ) >
			<cfset ErrorPayment = 4 >
		<cfelse>
			
		<!--- REALTIME CREDIT CARD PROCESSING --->
		
			<!--- AUTHORIZE.NET --->
			<cfif application.siteConfig.data.PaymentSystem EQ 2 AND FORM.FormOfPayment EQ 1 
			   AND (application.siteConfig.data.RealtimePayments EQ 1 OR application.siteConfig.data.RealtimePayments EQ 2)  >
				<cftry>
					<!--- SET UP ALL VARIABLES FOR PAYMENT SYSTEM --->					
					<cfscript>
						getAN = application.Queries.getAN(SiteID=application.siteConfig.data.SiteID);
						getANTK = application.Queries.getANTK(SiteID=application.siteConfig.data.SiteID);
					</cfscript>
					
					
					<!--- GET NEXT ORDER ID FOR THIS ORDER --->
					<cfquery name="getNextOrderID" datasource="#application.dsn#">
						SELECT 	MAX(OrderID) + 1 AS NextOrderID
						FROM	Orders
					</cfquery>
					
					<cfscript>
						decrypted_LOGIN = DECRYPT(getAN.Login, application.siteConfig.data.CryptKey, "CFMX_COMPAT", "Hex") ;
						decrypted_TK = DECRYPT(getANTK.TransKey, application.siteConfig.data.CryptKey, "CFMX_COMPAT", "Hex") ;
						decrypted_HASH = "";
						if (getAN.Hash IS NOT "")
							decrypted_HASH = DECRYPT(getAN.Hash, application.siteConfig.data.CryptKey, "CFMX_COMPAT", "Hex") ;
						if ( session.CustomerArray[4] NEQ '' )
							StreetAddress = '#session.CustomerArray[3]# #session.CustomerArray[4]#' ;
						else
							StreetAddress = '#session.CustomerArray[3]#' ;
						if ( session.CustomerArray[21] NEQ '' )
							ShipToStreetAddress = '#session.CustomerArray[20]#, #session.CustomerArray[21]#' ;
						else
							ShipToStreetAddress = '#session.CustomerArray[20]#' ;
						if ( getNextOrderID.RecordCount EQ 0 OR getNextOrderID.NextOrderID EQ '' )
							NextOrderID = 1002700 ;
						else
							NextOrderID = getNextOrderID.NextOrderID ;
					</cfscript>
					
					<!--- GET ORDER TOTAL --->
					<cfinclude template="Includes/CalculateTotal.cfm">					
					
					<!--- AUTH_ONLY --->
					<cfif application.siteConfig.data.RealtimePayments EQ 1 >
						<cfmodule template="Includes/AIM.cfm"
							Login="#decrypted_LOGIN#"
							TransactionKey="#decrypted_TK#" 
							hashValue="#decrypted_HASH#"
							invoiceNum="#NextOrderID#" 
							invoiceAmt="#Replace(DecimalFormat(RunningTotal),',','')#"
							Description="#application.siteConfig.data.StoreNameShort# Purchase" 
							ChargeMethod="CC"
							ChargeType="AUTH_ONLY"
							CardNumber="#Form.CardNum#"				
							CardExpiration="#Form.ExpDate#"
							CardCode="#Form.CardCVV#"
							CustID="#session.CustomerArray[17]#"
							FName="#session.CustomerArray[1]#"
							LName="#session.CustomerArray[2]#" 
							StreetAddress="#StreetAddress#"
							City="#session.CustomerArray[5]#"
							State="#session.CustomerArray[6]#" 
							Zip="#session.CustomerArray[7]#"
							Country="#session.CustomerArray[8]#"
							ShipToFName="#session.CustomerArray[18]#"
							ShipToLName="#session.CustomerArray[19]#" 
							ShipToStreetAddress="#ShipToStreetAddress#"
							ShipToCity="#session.CustomerArray[22]#"
							ShipToState="#session.CustomerArray[23]#" 
							ShipToZip="#session.CustomerArray[24]#"
							ShipToCountry="#session.CustomerArray[25]#"
							Phone="#session.CustomerArray[9]#"
							Email="#session.CustomerArray[11]#"
							TESTREQUEST="#TestMode#"
						>
					<!--- AUTH_CAPTURE --->
					<cfelse>
						<cfmodule template="Includes/AIM.cfm"
							Login="#decrypted_LOGIN#"
							TransactionKey="#decrypted_TK#" 
							hashValue="#decrypted_HASH#"
							invoiceNum="#NextOrderID#" 
							invoiceAmt="#Replace(DecimalFormat(RunningTotal),',','')#"
							Description="#application.siteConfig.data.StoreNameShort# Purchase" 
							ChargeMethod="CC"
							ChargeType="AUTH_CAPTURE"
							CardNumber="#Form.CardNum#"				
							CardExpiration="#Form.ExpDate#"
							CardCode="#Form.CardCVV#"
							CustID="#session.CustomerArray[17]#"
							FName="#session.CustomerArray[1]#"
							LName="#session.CustomerArray[2]#" 
							StreetAddress="#StreetAddress#"
							City="#session.CustomerArray[5]#"
							State="#session.CustomerArray[6]#" 
							Zip="#session.CustomerArray[7]#"
							Country="#session.CustomerArray[8]#"
							ShipToFName="#session.CustomerArray[18]#"
							ShipToLName="#session.CustomerArray[19]#" 
							ShipToStreetAddress="#ShipToStreetAddress#"
							ShipToCity="#session.CustomerArray[22]#"
							ShipToState="#session.CustomerArray[23]#" 
							ShipToZip="#session.CustomerArray[24]#"
							ShipToCountry="#session.CustomerArray[25]#"
							Phone="#session.CustomerArray[9]#"
							Email="#session.CustomerArray[11]#"
							TESTREQUEST="#TestMode#"
						>
					</cfif>
					
					<cfcatch type="any">
						<cfset ErrorMsg = 'There has been an error in credit card processing ...' >
						
						#cfcatch.message#<br>
						#cfcatch.detail# 
						
				  </cfcatch>
				</cftry>
				
				<!--- UPDATE CARTFUSION VARIABLES --->
				<!--- FROM PAYMENT GATEWAY QUERY OR FORM VARIABLES --->
				<cfscript>
					// Authorize.Net
					if ( isDefined('TransactionID') )
						TransactionID = TransactionID ;
					// USA ePay
					else if ( isDefined('q_auth.UMrefNum') )
						TransactionID = q_auth.UMrefNum ;
					else
						TransactionID = 1 ; // Internal note that transaction was not processed by payment gateway
					
					// Authorize.Net
					if ( isDefined('ResponseCode') )
						ResponseCode = ResponseCode ; // Will return 1 = Approved, 2 = Declined, or 3 = Error
					// USA ePay
					else if ( isDefined('q_auth.UMresult') )
					{
						// Approved
						if ( q_auth.UMresult EQ 'A' ) 
							ResponseCode = 1 ;
						// Declined
						else if ( q_auth.UMresult EQ 'D' )
							ResponseCode = 2 ;
						// Error
						else
							ResponseCode = 3 ;
					}
					// Default Approved
					else
						ResponseCode = 0 ;
					
					// SET VARIABLES TO PUT INTO ORDERS TABLE
					if ( TransactionID NEQ 1 AND ResponseCode LTE 1 )
					{
						// AUTH_ONLY
						if ( application.siteConfig.data.RealtimePayments EQ 1 )
						{	
							PaymentVerified = 0 ;
							BillingStatus = 'AU' ;
						}
						// AUTH_CAPTURE
						else
						{
							PaymentVerified = 1 ;
							BillingStatus = 'PA' ;
						}
					}
					else if ( TransactionID NEQ 1 AND ResponseCode EQ 3 )
					{
						ErrorPayment = 5 ;
					}
					else if ( ResponseCode EQ 2 )
					{
						ErrorPayment = 6 ;	
					}
				</cfscript>
			
			<!--- YOURPAY API --->
			<cfelseif application.siteConfig.data.PaymentSystem EQ 7 AND FORM.FormOfPayment EQ 1 
			   AND (application.siteConfig.data.RealtimePayments EQ 1 OR application.siteConfig.data.RealtimePayments EQ 2)  >
				<cftry>
					
					<!--- GET NEXT ORDER ID FOR THIS ORDER --->
					<cfquery name="getNextOrderID" datasource="#application.dsn#">
						SELECT 	MAX(OrderID) + 1 AS NextOrderID
						FROM	Orders
					</cfquery>
					
					<cfscript>
						if ( session.CustomerArray[4] NEQ '' )
							StreetAddress = '#session.CustomerArray[3]# #session.CustomerArray[4]#' ;
						else
							StreetAddress = '#session.CustomerArray[3]#' ;
						if ( getNextOrderID.RecordCount EQ 0 OR getNextOrderID.NextOrderID EQ '' )
							NextOrderID = 1002700 ;
						else
							NextOrderID = getNextOrderID.NextOrderID ;
					</cfscript>
					
					<!--- GET ORDER TOTAL --->
					<cfinclude template="Includes/CalculateTotal.cfm">					
					
					<!--- AUTH_ONLY --->
					<cfif application.siteConfig.data.RealtimePayments EQ 1 >
						<!--- PREAUTH --->
						<cfscript>
							ordertype = "PREAUTH" ;
							reference_number = "#TRIM(NextOrderID)#" ;
							name = "#TRIM(session.CustomerArray[1])# #TRIM(session.CustomerArray[2])#" ;
							address = "#TRIM(StreetAddress)#" ;
							city = "#TRIM(session.CustomerArray[5])#" ;
							state = "#TRIM(session.CustomerArray[6])#" ;
							zip = "#TRIM(session.CustomerArray[7])#" ; // Required for AVS. If not provided, transactions will downgrade.
							phone = "#TRIM(session.CustomerArray[9])#" ;
							email = "#TRIM(session.CustomerArray[11])#" ;
							comments = "OrderID: #TRIM(NextOrderID)# -- CustomerID: #TRIM(session.CustomerArray[17])#" ;
							cardnumber = "#TRIM(Form.CardNum)#" ;
							cardexpmonth = "#TRIM(Left(Form.ExpDate,2))#" ;
							cardexpyear = "#TRIM(Right(Form.ExpDate,2))#" ;
							cvmvalue = "#TRIM(Form.CardCVV)#" ;
							chargetotal = "#TRIM(Replace(DecimalFormat(RunningTotal),',',''))#" ;
							addrnum = "#listgetat(trim(StreetAddress), 1,' ')#" ; // Required for AVS. If not provided, transactions will downgrade.
						</cfscript>
						<!--- BUILD THE ORDER TO SEND --->
						<CFINCLUDE TEMPLATE = "admin/YourPay/lpcfm.cfm">
						
					<!--- AUTH_CAPTURE --->
					<cfelse>
						<!--- SALE --->
						<cfscript>
							ordertype = "SALE" ;
							reference_number = "#TRIM(NextOrderID)#" ;
							name = "#TRIM(session.CustomerArray[1])# #TRIM(session.CustomerArray[2])#" ;
							address = "#TRIM(StreetAddress)#" ;
							city = "#TRIM(session.CustomerArray[5])#" ;
							state = "#TRIM(session.CustomerArray[6])#" ;
							zip = "#TRIM(session.CustomerArray[7])#" ; // Required for AVS. If not provided, transactions will downgrade.
							phone = "#TRIM(session.CustomerArray[9])#" ;
							email = "#TRIM(session.CustomerArray[11])#" ;
							comments = "OrderID: #TRIM(NextOrderID)# -- CustomerID: #TRIM(session.CustomerArray[17])#" ;
							cardnumber = "#TRIM(Form.CardNum)#" ;
							cardexpmonth = "#TRIM(Left(Form.ExpDate,2))#" ;
							cardexpyear = "#TRIM(Right(Form.ExpDate,2))#" ;
							cvmvalue = "#TRIM(Form.CardCVV)#" ;
							chargetotal = "#TRIM(Replace(DecimalFormat(RunningTotal),',',''))#" ;
							addrnum = "#listgetat(trim(StreetAddress), 1,' ')#" ; // Required for AVS. If not provided, transactions will downgrade.
						</cfscript>
						<!--- BUILD THE ORDER TO SEND --->
						<CFINCLUDE TEMPLATE = "admin/YourPay/lpcfm.cfm">
						
					</cfif>
					
					<cfcatch type="any">
						<cfset ErrorMsg = 'There has been an error in credit card processing ...' >
						
						#cfcatch.message#<br>
						#cfcatch.detail# 
						
				  </cfcatch>
				</cftry>
				
				<!--- UPDATE CARTFUSION VARIABLES --->
				<!--- FROM PAYMENT GATEWAY QUERY OR FORM VARIABLES --->
				<cfscript>
					if ( IsDefined('rootResp') )
					{						
						if ( r_ref NEQ '' )
							Reference = r_ref ;
						
						if ( r_ordernum NEQ '' )
							TransactionID = r_ordernum ;
						else
							TransactionID = 1 ; // Internal note that transaction was not processed by payment gateway
						
						if ( r_approved EQ 'APPROVED' )
							ResponseCode = 1 ; // 1 = Approved
						else if ( r_approved NEQ 'APPROVED' ) // OR r_approved EQ 'FRAUD' OR r_approved EQ 'DECLINED'
							ResponseCode = 2 ; // 2 = Declined
						else
							ResponseCode = 0 ; // 0 = Default Approved
						
						// SET VARIABLES TO PUT INTO ORDERS TABLE
						if ( TransactionID NEQ 1 AND ResponseCode LTE 1 )
						{
							// AUTH_ONLY
							if ( application.siteConfig.data.RealtimePayments EQ 1 )
							{	
								PaymentVerified = 0 ;
								BillingStatus = 'AU' ;
							}
							// AUTH_CAPTURE
							else
							{
								PaymentVerified = 1 ;
								BillingStatus = 'PA' ;
							}
						}
						else if ( TransactionID NEQ 1 AND ResponseCode EQ 3 )
						{
							ErrorPayment = 5 ;
						}
						else if ( ResponseCode EQ 2 )
						{
							ErrorPayment = 6 ;	
						}
					}
					else
						ErrorPayment = 5 ;
				</cfscript>	
			</cfif><!--- IF application.siteConfig.data.REALTIMEPAYMENTS EQUALS 1 --->
			
			<cfif NOT isDefined('ErrorPayment') >
				<cfinclude template="CO-PlaceOrder.cfm">
				<cfabort>
			</cfif>
		</cfif>
	<cfelseif NOT isDefined('ErrorPayment') AND NOT isDefined('Form.FormOfPayment') AND NOT isDefined('FullCreditAmount') >
		<cfset ErrorPayment = 3 >
	<cfelseif isDefined('Form.FormOfPayment') AND Form.FormOfPayment EQ 0 >
		<cfinclude template="CO-PlaceOrder.cfm">
		<cfabort>
	</cfif>
	
</cfif>
<!--- END: CLICK BUTTON - CONFIRM OR CANCEL ORDER --->

<cfparam name="ErrorPayment" default="0">

<cfif ErrorPayment NEQ 0 >
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
	<cfif ErrorPayment EQ 3 >
		<tr><td><div align="center" class="cfErrorMsg"><u>ERROR: Please select a Form of Payment before proceeding.</u><br><br></div></td></tr>
	</cfif>
	<cfif ErrorPayment EQ 4 >
		<tr><td><div align="center" class="cfErrorMsg"><u>ERROR: Please enter all required (<u>underlined</u>) fields.</u><br><br></div></td></tr>
	</cfif>
	<cfif ErrorPayment EQ 5 >
		<tr><td><div align="center" class="cfErrorMsg"><u>ERROR: <cfif isDefined('ResponseReasonText')>#UCASE(ResponseReasonText)#<cfelse>We cannot accept this type of payment.<br />Please try again.</cfif></u><br><br></div></td></tr>
	</cfif>
	<cfif ErrorPayment EQ 6 >
		<tr><td><div align="center" class="cfErrorMsg"><u>ERROR: Your credit card has been declined.</u><br><br></div></td></tr>
	</cfif>
	<cfif ErrorPayment EQ 7 >
		<tr><td><div align="center" class="cfErrorMsg"><u>ERROR: Please enter a positive amount of store credit to be applied<br />and/or select an alternate Form of Payment.</u><br><br></div></td></tr>
	</cfif>
	<cfif ErrorPayment EQ 8 >
		<tr><td><div align="center" class="cfErrorMsg"><u>ERROR: You can not apply more than $#Form.AvailableCredit# store credit to this order.</u><br><br></div></td></tr>
	</cfif>
	<cfif ErrorPayment EQ 9 >
		<tr><td><div align="center" class="cfErrorMsg"><u>ERROR: In addition to applying store credit,<br />please select a Form of Payment for the remaining balance of the order.</u><br><br></div></td></tr>
	</cfif>
</table>
</cfif>

<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr><td style="padding-top:10px; padding-bottom:5px;" align="right"><img src="images/image-CheckoutProcess3.gif" border="0" hspace="3" align="absmiddle"><br><br></td></tr>
</table>

<table width="98%" align="center" border="0" cellpadding="0" cellspacing="0">
<cfform action="CO-Payment.cfm" method="POST" preservedata="yes">
	<tr>
		<td width="100%" valign="top">
			<!--- SHOW INFORMATION THUS FAR --->
			<table width="100%" cellpadding="0" cellspacing="0" border="1">
				<tr>
					<td style="padding-left:5px;">
						<div class="cfTableHeading" style="padding:5px;">Please review your order and enter credit card information below.</div>
					</td>
				</tr>
				<tr><td height="1"><img src="images/spacer.gif" height="1" width="1" /></td></tr>
				<tr>
					<td align="center">
						<cfif NOT isDefined('Cart.CartTotal1')>
							<cfinclude template="Includes/CartTotals.cfm">
						</cfif>
						<cfinclude template="Includes/CO-InfoThusFar.cfm">
					</td>
				</tr>
			</table>
			<br />
			
			<!--- PAYMENT METHODS --->
			<table width="100%" cellpadding="0" cellspacing="0" border="1">
				<tr>
					<td style="padding-left:5px;">
						<div class="cfTableHeading" style="padding:5px;">FORM OF <cfif application.siteConfig.data.EnableSSL EQ 1 >SECURE</cfif> PAYMENT</div>
					</td>
				</tr>
				<tr><td height="1"><img src="images/spacer.gif" height="1" width="1" /></td></tr>
				<tr>
					<td align="center">
						<cfinclude template="Includes/CO-FormsOfPayment.cfm">
						
						<cfif isDefined('Form.DiscountCode') AND Form.DiscountCode NEQ '' >
							<input type="hidden" name="DiscountCode" value="#Form.DiscountCode#">
						<cfelseif isDefined('Form.DiscountUsed') AND Form.DiscountUsed NEQ '' >
							<input type="hidden" name="DiscountUsed" value="#Form.DiscountUsed#">
						<cfelseif isDefined('checkAFID') AND checkAFID.RecordCount EQ 1 >
							<input type="hidden" name="DiscountCode" value="#Form.DiscountCode#">
						</cfif>
					</td>
				</tr>
			</table>
			<br />
			
			<!--- CUSTOMER COMMENTS --->
			<table width="100%" cellpadding="0" cellspacing="0" border="1">
				<tr>
					<td style="padding-left:5px;">
						<div class="cfTableHeading" style="padding:5px;">Order Comments, Questions, or Suggestions?</div>
					</td>
				</tr>
				<tr><td height="1"><img src="images/spacer.gif" height="1" width="1" /></td></tr>
				<tr>
					<td>
						<cftextarea name="CustomerComments" style="width:100%; height:50px;" class="cfFormField"></cftextarea>
					</td>
				</tr>
			</table>
			<br />
			
			<!--- SHOW CART --->
			<cfinclude template="Includes/CartView.cfm">
					
		</td>
	</tr>
</table>
<br />
<table width="98%" align="center" cellpadding="0" cellspacing="0" border="0">
	<tr>
		<td width="100%" align="center">
			<a href="CartClean.cfm" onClick="return confirm('Are you sure you want to CANCEL THIS ORDER completely?')"><img src="images/button-cancel.gif" border="0" alt="Cancel Order" align="absmiddle"></a>
			<img src="images/spacer.gif" width="3" height="1" align="absmiddle">
			<input type="Image" name="Step4" value="Step4" src="images/button-CompleteOrder.gif" alt="Complete Order" align="absbottom">
			<!--- CARTFUSION 4.5 - MULTIPLE SHIPPING ADDRESSES --->	
			<cfloop from="1" to="#Cart.Packages#" index="cpi">
				<input type="hidden" name="ShippingMethod#cpi#" value="#Evaluate('Form.ShippingMethod' & cpi)#">
			</cfloop>
		</td>
	</tr>
</table>
</cfform>
	</cfmodule>
</cfoutput>















<!--- Old Code --->
<!--- <cfoutput>
<cfif session.CustomerArray[26] EQ ''>
	<cflocation url="#application.siteConfig.data.RootURL#/CartEdit.cfm" addtoken="no">
</cfif>

<!--- VALIDATE OPTIONS INFORMATION ENTRIES --->
<cfif NOT isDefined('ErrorPayment') >
	<cfif not structKeyExists(form, 'ShippingMethod1') OR trim(form.ShippingMethod1) EQ '' >
		<cfset ErrorOptions = 1 >
	</cfif>
</cfif>

<cfif isDefined('ErrorOptions')>
	<cflocation url="CO-Options.cfm?ErrorOptions=#ErrorOptions#" addtoken="no">
	<cfabort>
</cfif>

<cfscript>
	PageTitle = 'Check Out - Step 3 of 4' ;
	BannerTitle = 'Checkout' ;
	HideLeftNav = 1 ;
	TestMode = true ;
</cfscript>
<cfinclude template="LayoutGlobalHeader.cfm">

<!--- BEGIN: CLICK BUTTON - CONFIRM OR CANCEL ORDER --->
<cfif IsDefined('Form.Step4.x') AND NOT isDefined('ErrorPayment')>
	
	<!--- STORE CREDIT --------------------------------------------------------------------------------------------------------->
	<cfif structKeyExists(form, 'CreditToApply') and form.CreditToApply NEQ 0 >
		<cfset form.CreditToApply = Replace(Form.CreditToApply,',','','ALL') >
		<cfinclude template="Includes/CalculateTotal.cfm">
		<!--- INVALID/NEGATIVE AMOUNT --->
		<cfif form.CreditToApply LT 0 >
			<cfset ErrorPayment = 7 >
		<!--- NOT ENOUGH AVAILABLE CREDIT --->
		<cfelseif form.CreditToApply GT Form.AvailableCredit >
			<cfset ErrorPayment = 8 >
		<!--- CREDIT WON'T COVER WHOLE ORDER, NEED ADDITIONAL FUNDING SOURCE --->
		<cfelseif form.CreditToApply LT OrderTotal AND NOT isDefined('Form.FormOfPayment') >
			<cfset ErrorPayment = 9 >
		<!--- APPLY CREDIT TO WHOLE ORDER --->
		<cfelseif form.CreditToApply GTE OrderTotal >
			<cfif form.CreditToApply GT OrderTotal >
				<cfset Form.CreditToApply = OrderTotal >
			</cfif>
			<cfset FullCreditAmount = 1 >
			<cfset FORM.FormOfPayment = 0 >
			<cfset BillingStatus = 'PA' >
		<!--- ALL IS GOOD, CONTINUE TO FUND WITH STORE CREDIT AND OTHER SOURCE --->
		<cfelseif isDefined('form.FormOfPayment') >
			<cfset IncludeCredit = 1 >
		<cfelse>
			<cfset ErrorPayment = 9 >
		</cfif>
	</cfif>
	
	<!--- CREDIT CARD ERROR CHECKING GOES HERE, BEFORE GOING TO CO-PLACEORDER.CFM ---------------------------------------------->
	<cfif structKeyExists(form, 'FormOfPayment') and form.FormOfPayment EQ 1 >
		<cfinclude template="Includes/ValidateCC.cfm">
	</cfif>
	<!------------------------------------------------------------>
	<!--- IF CREDIT CARD IS ERROR FREE, CONTINUE PLACING ORDER --->
	<cfif not isDefined('ErrorPayment') AND structKeyExists(form, 'FormOfPayment') and ( not isDefined('FullCreditAmount') OR isDefined('IncludeCredit') ) >
		
		<!--- VALIDATE PAYMENT INFORMATION ENTRIES --->
		<cfif Form.FormOfPayment EQ 1 AND
			 (Form.CardName EQ '' OR
			  Form.CardNum EQ '' OR
			  Form.ExpDate EQ '' OR
			  Form.CardCVV EQ '' ) >
			<cfset ErrorPayment = 4 >
		<cfelse>
			
		<!--- REALTIME CREDIT CARD PROCESSING --->
		
			<!--- AUTHORIZE.NET --->
			<cfif application.siteConfig.data.PaymentSystem EQ 2 AND FORM.FormOfPayment EQ 1 
			   AND (application.siteConfig.data.RealtimePayments EQ 1 OR application.siteConfig.data.RealtimePayments EQ 2)  >
				<cftry>
					<!--- SET UP ALL VARIABLES FOR PAYMENT SYSTEM --->					
					<cfscript>
						getAN = application.Queries.getAN(SiteID=application.siteConfig.data.SiteID);
						getANTK = application.Queries.getANTK(SiteID=application.siteConfig.data.SiteID);
					</cfscript>
					
					
					<!--- GET NEXT ORDER ID FOR THIS ORDER --->
					<cfquery name="getNextOrderID" datasource="#application.dsn#">
						SELECT 	MAX(OrderID) + 1 AS NextOrderID
						FROM	Orders
					</cfquery>
					
					<cfscript>
						decrypted_LOGIN = DECRYPT(getAN.Login, application.siteConfig.data.CryptKey, "CFMX_COMPAT", "Hex") ;
						decrypted_TK = DECRYPT(getANTK.TransKey, application.siteConfig.data.CryptKey, "CFMX_COMPAT", "Hex") ;
						decrypted_HASH = "";
						if (getAN.Hash IS NOT "")
							decrypted_HASH = DECRYPT(getAN.Hash, application.siteConfig.data.CryptKey, "CFMX_COMPAT", "Hex") ;
						if ( session.CustomerArray[4] NEQ '' )
							StreetAddress = '#session.CustomerArray[3]# #session.CustomerArray[4]#' ;
						else
							StreetAddress = '#session.CustomerArray[3]#' ;
						if ( session.CustomerArray[21] NEQ '' )
							ShipToStreetAddress = '#session.CustomerArray[20]#, #session.CustomerArray[21]#' ;
						else
							ShipToStreetAddress = '#session.CustomerArray[20]#' ;
						if ( getNextOrderID.RecordCount EQ 0 OR getNextOrderID.NextOrderID EQ '' )
							NextOrderID = 1002700 ;
						else
							NextOrderID = getNextOrderID.NextOrderID ;
					</cfscript>
					
					<!--- GET ORDER TOTAL --->
					<cfinclude template="Includes/CalculateTotal.cfm">					
					
					<!--- AUTH_ONLY --->
					<cfif application.siteConfig.data.RealtimePayments EQ 1 >
						<cfmodule template="Includes/AIM.cfm"
							Login="#decrypted_LOGIN#"
							TransactionKey="#decrypted_TK#" 
							hashValue="#decrypted_HASH#"
							invoiceNum="#NextOrderID#" 
							invoiceAmt="#Replace(DecimalFormat(RunningTotal),',','')#"
							Description="#application.siteConfig.data.StoreNameShort# Purchase" 
							ChargeMethod="CC"
							ChargeType="AUTH_ONLY"
							CardNumber="#Form.CardNum#"				
							CardExpiration="#Form.ExpDate#"
							CardCode="#Form.CardCVV#"
							CustID="#session.CustomerArray[17]#"
							FName="#session.CustomerArray[1]#"
							LName="#session.CustomerArray[2]#" 
							StreetAddress="#StreetAddress#"
							City="#session.CustomerArray[5]#"
							State="#session.CustomerArray[6]#" 
							Zip="#session.CustomerArray[7]#"
							Country="#session.CustomerArray[8]#"
							ShipToFName="#session.CustomerArray[18]#"
							ShipToLName="#session.CustomerArray[19]#" 
							ShipToStreetAddress="#ShipToStreetAddress#"
							ShipToCity="#session.CustomerArray[22]#"
							ShipToState="#session.CustomerArray[23]#" 
							ShipToZip="#session.CustomerArray[24]#"
							ShipToCountry="#session.CustomerArray[25]#"
							Phone="#session.CustomerArray[9]#"
							Email="#session.CustomerArray[11]#"
							TESTREQUEST="#TestMode#"
						>
					<!--- AUTH_CAPTURE --->
					<cfelse>
						<cfmodule template="Includes/AIM.cfm"
							Login="#decrypted_LOGIN#"
							TransactionKey="#decrypted_TK#" 
							hashValue="#decrypted_HASH#"
							invoiceNum="#NextOrderID#" 
							invoiceAmt="#Replace(DecimalFormat(RunningTotal),',','')#"
							Description="#application.siteConfig.data.StoreNameShort# Purchase" 
							ChargeMethod="CC"
							ChargeType="AUTH_CAPTURE"
							CardNumber="#Form.CardNum#"				
							CardExpiration="#Form.ExpDate#"
							CardCode="#Form.CardCVV#"
							CustID="#session.CustomerArray[17]#"
							FName="#session.CustomerArray[1]#"
							LName="#session.CustomerArray[2]#" 
							StreetAddress="#StreetAddress#"
							City="#session.CustomerArray[5]#"
							State="#session.CustomerArray[6]#" 
							Zip="#session.CustomerArray[7]#"
							Country="#session.CustomerArray[8]#"
							ShipToFName="#session.CustomerArray[18]#"
							ShipToLName="#session.CustomerArray[19]#" 
							ShipToStreetAddress="#ShipToStreetAddress#"
							ShipToCity="#session.CustomerArray[22]#"
							ShipToState="#session.CustomerArray[23]#" 
							ShipToZip="#session.CustomerArray[24]#"
							ShipToCountry="#session.CustomerArray[25]#"
							Phone="#session.CustomerArray[9]#"
							Email="#session.CustomerArray[11]#"
							TESTREQUEST="#TestMode#"
						>
					</cfif>
					
					<cfcatch type="any">
						<cfset ErrorMsg = 'There has been an error in credit card processing ...' >
						
						#cfcatch.message#<br>
						#cfcatch.detail# 
						
				  </cfcatch>
				</cftry>
				
				<!--- UPDATE CARTFUSION VARIABLES --->
				<!--- FROM PAYMENT GATEWAY QUERY OR FORM VARIABLES --->
				<cfscript>
					// Authorize.Net
					if ( isDefined('TransactionID') )
						TransactionID = TransactionID ;
					// USA ePay
					else if ( isDefined('q_auth.UMrefNum') )
						TransactionID = q_auth.UMrefNum ;
					else
						TransactionID = 1 ; // Internal note that transaction was not processed by payment gateway
					
					// Authorize.Net
					if ( isDefined('ResponseCode') )
						ResponseCode = ResponseCode ; // Will return 1 = Approved, 2 = Declined, or 3 = Error
					// USA ePay
					else if ( isDefined('q_auth.UMresult') )
					{
						// Approved
						if ( q_auth.UMresult EQ 'A' ) 
							ResponseCode = 1 ;
						// Declined
						else if ( q_auth.UMresult EQ 'D' )
							ResponseCode = 2 ;
						// Error
						else
							ResponseCode = 3 ;
					}
					// Default Approved
					else
						ResponseCode = 0 ;
					
					// SET VARIABLES TO PUT INTO ORDERS TABLE
					if ( TransactionID NEQ 1 AND ResponseCode LTE 1 )
					{
						// AUTH_ONLY
						if ( application.siteConfig.data.RealtimePayments EQ 1 )
						{	
							PaymentVerified = 0 ;
							BillingStatus = 'AU' ;
						}
						// AUTH_CAPTURE
						else
						{
							PaymentVerified = 1 ;
							BillingStatus = 'PA' ;
						}
					}
					else if ( TransactionID NEQ 1 AND ResponseCode EQ 3 )
					{
						ErrorPayment = 5 ;
					}
					else if ( ResponseCode EQ 2 )
					{
						ErrorPayment = 6 ;	
					}
				</cfscript>
			
			<!--- YOURPAY API --->
			<cfelseif application.siteConfig.data.PaymentSystem EQ 7 AND FORM.FormOfPayment EQ 1 
			   AND (application.siteConfig.data.RealtimePayments EQ 1 OR application.siteConfig.data.RealtimePayments EQ 2)  >
				<cftry>
					
					<!--- GET NEXT ORDER ID FOR THIS ORDER --->
					<cfquery name="getNextOrderID" datasource="#application.dsn#">
						SELECT 	MAX(OrderID) + 1 AS NextOrderID
						FROM	Orders
					</cfquery>
					
					<cfscript>
						if ( session.CustomerArray[4] NEQ '' )
							StreetAddress = '#session.CustomerArray[3]# #session.CustomerArray[4]#' ;
						else
							StreetAddress = '#session.CustomerArray[3]#' ;
						if ( getNextOrderID.RecordCount EQ 0 OR getNextOrderID.NextOrderID EQ '' )
							NextOrderID = 1002700 ;
						else
							NextOrderID = getNextOrderID.NextOrderID ;
					</cfscript>
					
					<!--- GET ORDER TOTAL --->
					<cfinclude template="Includes/CalculateTotal.cfm">					
					
					<!--- AUTH_ONLY --->
					<cfif application.siteConfig.data.RealtimePayments EQ 1 >
						<!--- PREAUTH --->
						<cfscript>
							ordertype = "PREAUTH" ;
							reference_number = "#TRIM(NextOrderID)#" ;
							name = "#TRIM(session.CustomerArray[1])# #TRIM(session.CustomerArray[2])#" ;
							address = "#TRIM(StreetAddress)#" ;
							city = "#TRIM(session.CustomerArray[5])#" ;
							state = "#TRIM(session.CustomerArray[6])#" ;
							zip = "#TRIM(session.CustomerArray[7])#" ; // Required for AVS. If not provided, transactions will downgrade.
							phone = "#TRIM(session.CustomerArray[9])#" ;
							email = "#TRIM(session.CustomerArray[11])#" ;
							comments = "OrderID: #TRIM(NextOrderID)# -- CustomerID: #TRIM(session.CustomerArray[17])#" ;
							cardnumber = "#TRIM(Form.CardNum)#" ;
							cardexpmonth = "#TRIM(Left(Form.ExpDate,2))#" ;
							cardexpyear = "#TRIM(Right(Form.ExpDate,2))#" ;
							cvmvalue = "#TRIM(Form.CardCVV)#" ;
							chargetotal = "#TRIM(Replace(DecimalFormat(RunningTotal),',',''))#" ;
							addrnum = "#listgetat(trim(StreetAddress), 1,' ')#" ; // Required for AVS. If not provided, transactions will downgrade.
						</cfscript>
						<!--- BUILD THE ORDER TO SEND --->
						<CFINCLUDE TEMPLATE = "admin/YourPay/lpcfm.cfm">
						
					<!--- AUTH_CAPTURE --->
					<cfelse>
						<!--- SALE --->
						<cfscript>
							ordertype = "SALE" ;
							reference_number = "#TRIM(NextOrderID)#" ;
							name = "#TRIM(session.CustomerArray[1])# #TRIM(session.CustomerArray[2])#" ;
							address = "#TRIM(StreetAddress)#" ;
							city = "#TRIM(session.CustomerArray[5])#" ;
							state = "#TRIM(session.CustomerArray[6])#" ;
							zip = "#TRIM(session.CustomerArray[7])#" ; // Required for AVS. If not provided, transactions will downgrade.
							phone = "#TRIM(session.CustomerArray[9])#" ;
							email = "#TRIM(session.CustomerArray[11])#" ;
							comments = "OrderID: #TRIM(NextOrderID)# -- CustomerID: #TRIM(session.CustomerArray[17])#" ;
							cardnumber = "#TRIM(Form.CardNum)#" ;
							cardexpmonth = "#TRIM(Left(Form.ExpDate,2))#" ;
							cardexpyear = "#TRIM(Right(Form.ExpDate,2))#" ;
							cvmvalue = "#TRIM(Form.CardCVV)#" ;
							chargetotal = "#TRIM(Replace(DecimalFormat(RunningTotal),',',''))#" ;
							addrnum = "#listgetat(trim(StreetAddress), 1,' ')#" ; // Required for AVS. If not provided, transactions will downgrade.
						</cfscript>
						<!--- BUILD THE ORDER TO SEND --->
						<CFINCLUDE TEMPLATE = "admin/YourPay/lpcfm.cfm">
						
					</cfif>
					
					<cfcatch type="any">
						<cfset ErrorMsg = 'There has been an error in credit card processing ...' >
						
						#cfcatch.message#<br>
						#cfcatch.detail# 
						
				  </cfcatch>
				</cftry>
				
				<!--- UPDATE CARTFUSION VARIABLES --->
				<!--- FROM PAYMENT GATEWAY QUERY OR FORM VARIABLES --->
				<cfscript>
					if ( IsDefined('rootResp') )
					{						
						if ( r_ref NEQ '' )
							Reference = r_ref ;
						
						if ( r_ordernum NEQ '' )
							TransactionID = r_ordernum ;
						else
							TransactionID = 1 ; // Internal note that transaction was not processed by payment gateway
						
						if ( r_approved EQ 'APPROVED' )
							ResponseCode = 1 ; // 1 = Approved
						else if ( r_approved NEQ 'APPROVED' ) // OR r_approved EQ 'FRAUD' OR r_approved EQ 'DECLINED'
							ResponseCode = 2 ; // 2 = Declined
						else
							ResponseCode = 0 ; // 0 = Default Approved
						
						// SET VARIABLES TO PUT INTO ORDERS TABLE
						if ( TransactionID NEQ 1 AND ResponseCode LTE 1 )
						{
							// AUTH_ONLY
							if ( application.siteConfig.data.RealtimePayments EQ 1 )
							{	
								PaymentVerified = 0 ;
								BillingStatus = 'AU' ;
							}
							// AUTH_CAPTURE
							else
							{
								PaymentVerified = 1 ;
								BillingStatus = 'PA' ;
							}
						}
						else if ( TransactionID NEQ 1 AND ResponseCode EQ 3 )
						{
							ErrorPayment = 5 ;
						}
						else if ( ResponseCode EQ 2 )
						{
							ErrorPayment = 6 ;	
						}
					}
					else
						ErrorPayment = 5 ;
				</cfscript>	
			</cfif><!--- IF application.siteConfig.data.REALTIMEPAYMENTS EQUALS 1 --->
			
			<cfif NOT isDefined('ErrorPayment') >
				<cfinclude template="CO-PlaceOrder.cfm">
				<cfabort>
			</cfif>
		</cfif>
	<cfelseif NOT isDefined('ErrorPayment') AND NOT isDefined('Form.FormOfPayment') AND NOT isDefined('FullCreditAmount') >
		<cfset ErrorPayment = 3 >
	<cfelseif isDefined('Form.FormOfPayment') AND Form.FormOfPayment EQ 0 >
		<cfinclude template="CO-PlaceOrder.cfm">
		<cfabort>
	</cfif>
	
</cfif>
<!--- END: CLICK BUTTON - CONFIRM OR CANCEL ORDER --->

<cfparam name="ErrorPayment" default="0">

<cfif ErrorPayment NEQ 0 >
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
	<cfif ErrorPayment EQ 3 >
		<tr><td><div align="center" class="cfErrorMsg"><u>ERROR: Please select a Form of Payment before proceeding.</u><br><br></div></td></tr>
	</cfif>
	<cfif ErrorPayment EQ 4 >
		<tr><td><div align="center" class="cfErrorMsg"><u>ERROR: Please enter all required (<u>underlined</u>) fields.</u><br><br></div></td></tr>
	</cfif>
	<cfif ErrorPayment EQ 5 >
		<tr><td><div align="center" class="cfErrorMsg"><u>ERROR: <cfif isDefined('ResponseReasonText')>#UCASE(ResponseReasonText)#<cfelse>We cannot accept this type of payment.<br />Please try again.</cfif></u><br><br></div></td></tr>
	</cfif>
	<cfif ErrorPayment EQ 6 >
		<tr><td><div align="center" class="cfErrorMsg"><u>ERROR: Your credit card has been declined.</u><br><br></div></td></tr>
	</cfif>
	<cfif ErrorPayment EQ 7 >
		<tr><td><div align="center" class="cfErrorMsg"><u>ERROR: Please enter a positive amount of store credit to be applied<br />and/or select an alternate Form of Payment.</u><br><br></div></td></tr>
	</cfif>
	<cfif ErrorPayment EQ 8 >
		<tr><td><div align="center" class="cfErrorMsg"><u>ERROR: You can not apply more than $#Form.AvailableCredit# store credit to this order.</u><br><br></div></td></tr>
	</cfif>
	<cfif ErrorPayment EQ 9 >
		<tr><td><div align="center" class="cfErrorMsg"><u>ERROR: In addition to applying store credit,<br />please select a Form of Payment for the remaining balance of the order.</u><br><br></div></td></tr>
	</cfif>
</table>
</cfif>

<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr><td style="padding-top:10px; padding-bottom:5px;" align="right"><img src="images/image-CheckoutProcess3.gif" border="0" hspace="3" align="absmiddle"><br><br></td></tr>
</table>

<table width="98%" align="center" border="0" cellpadding="0" cellspacing="0">
<cfform action="CO-Payment.cfm" method="POST" preservedata="yes">
	<tr>
		<td width="100%" valign="top">
			<!--- SHOW INFORMATION THUS FAR --->
			<table width="100%" cellpadding="0" cellspacing="0" border="1" bordercolor="#layout.TableHeadingBGColor#">
				<tr bordercolor="#layout.PrimaryBGColor#">
					<td style="padding-left:5px;" bgcolor="#layout.TableHeadingBGColor#">
						<div class="cfTableHeading" style="padding:5px;">Please review your order and enter credit card information below.</div>
					</td>
				</tr>
				<tr bgcolor="#layout.TableHeadingBGColor#"><td height="1"><img src="images/spacer.gif" height="1" width="1" /></td></tr>
				<tr bordercolor="#layout.PrimaryBGColor#">
					<td align="center">
						<cfif NOT isDefined('Cart.CartTotal1')>
							<cfinclude template="Includes/CartTotals.cfm">
						</cfif>
						<cfinclude template="Includes/CO-InfoThusFar.cfm">
					</td>
				</tr>
			</table>
			<br />
			
			<!--- PAYMENT METHODS --->
			<table width="100%" cellpadding="0" cellspacing="0" border="1" bordercolor="#layout.TableHeadingBGColor#">
				<tr bordercolor="#layout.PrimaryBGColor#">
					<td style="padding-left:5px;" bgcolor="#layout.TableHeadingBGColor#">
						<div class="cfTableHeading" style="padding:5px;">FORM OF <cfif application.siteConfig.data.EnableSSL EQ 1 >SECURE</cfif> PAYMENT</div>
					</td>
				</tr>
				<tr bgcolor="#layout.TableHeadingBGColor#"><td height="1"><img src="images/spacer.gif" height="1" width="1" /></td></tr>
				<tr bordercolor="#layout.PrimaryBGColor#">
					<td align="center">
						<cfinclude template="Includes/CO-FormsOfPayment.cfm">
						
						<cfif isDefined('Form.DiscountCode') AND Form.DiscountCode NEQ '' >
							<input type="hidden" name="DiscountCode" value="#Form.DiscountCode#">
						<cfelseif isDefined('Form.DiscountUsed') AND Form.DiscountUsed NEQ '' >
							<input type="hidden" name="DiscountUsed" value="#Form.DiscountUsed#">
						<cfelseif isDefined('checkAFID') AND checkAFID.RecordCount EQ 1 >
							<input type="hidden" name="DiscountCode" value="#Form.DiscountCode#">
						</cfif>
					</td>
				</tr>
			</table>
			<br />
			
			<!--- CUSTOMER COMMENTS --->
			<table width="100%" cellpadding="0" cellspacing="0" border="1" bordercolor="#layout.TableHeadingBGColor#">
				<tr bordercolor="#layout.PrimaryBGColor#">
					<td style="padding-left:5px;" bgcolor="#layout.TableHeadingBGColor#">
						<div class="cfTableHeading" style="padding:5px;">Order Comments, Questions, or Suggestions?</div>
					</td>
				</tr>
				<tr bgcolor="#layout.TableHeadingBGColor#"><td height="1"><img src="images/spacer.gif" height="1" width="1" /></td></tr>
				<tr bordercolor="#layout.PrimaryBGColor#">
					<td>
						<cftextarea name="CustomerComments" style="width:100%; height:50px;" class="cfFormField"></cftextarea>
					</td>
				</tr>
			</table>
			<br />
			
			<!--- SHOW CART --->
			<cfinclude template="Includes/CartView.cfm">
					
		</td>
	</tr>
</table>
<br />
<table width="98%" align="center" cellpadding="0" cellspacing="0" border="0">
	<tr>
		<td width="100%" align="center">
			<a href="CartClean.cfm" onClick="return confirm('Are you sure you want to CANCEL THIS ORDER completely?')"><img src="images/button-cancel.gif" border="0" alt="Cancel Order" align="absmiddle"></a>
			<img src="images/spacer.gif" width="3" height="1" align="absmiddle">
			<input type="Image" name="Step4" value="Step4" src="images/button-CompleteOrder.gif" alt="Complete Order" align="absbottom">
			<!--- CARTFUSION 4.5 - MULTIPLE SHIPPING ADDRESSES --->	
			<cfloop from="1" to="#Cart.Packages#" index="cpi">
				<input type="hidden" name="ShippingMethod#cpi#" value="#Evaluate('Form.ShippingMethod' & cpi)#">
			</cfloop>
		</td>
	</tr>
</table>
</cfform>
</cfoutput>
	
<cfinclude template="LayoutGlobalFooter.cfm"> --->


