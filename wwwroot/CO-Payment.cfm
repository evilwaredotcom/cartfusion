


<cfif session.CustomerArray[26] EQ ''>
	<cflocation url="#application.RootURL#/CartEdit.cfm" addtoken="no">
</cfif>

<!--- VALIDATE OPTIONS INFORMATION ENTRIES --->
<cfif not isDefined('ErrorPayment') >
	<cfif not structKeyExists(form, 'ShippingMethod1') OR trim(form.ShippingMethod1) EQ '' >
		<cfset ErrorOptions = 1>
	</cfif>
</cfif>

<cfif isDefined('ErrorOptions')>
	<cflocation url="CO-Options.cfm?ErrorOptions=#ErrorOptions#" addtoken="no">
	<cfabort>
</cfif>

	<!--- BEGIN: CLICK BUTTON - COMPLETE ORDER --->
<cfif IsDefined('Form.Step4') and not isDefined('ErrorPayment')>
	
	<!--- STORE CREDIT --------------------------------------------------------------------------------------------------------->
	<cfif structKeyExists(form, 'CreditToApply') and form.CreditToApply NEQ 0 >
		<cfset form.CreditToApply = Replace(form.CreditToApply,',','','ALL') >
		<cfinclude template="Includes/CalculateTotal.cfm">
		
		<cfscript>
			// INVALID/NEGATIVE AMOUNT
			if( form.CreditToApply LT 0)	{
				ErrorPayment = 7;
			}
			// NOT ENOUGH AVAILABLE CREDIT
			else if( form.CreditToApply GT Form.AvailableCredit)	{
				ErrorPayment = 8;
			}
			// CREDIT WON'T COVER WHOLE ORDER, NEED ADDITIONAL FUNDING SOURCE
			else if( form.CreditToApply LT OrderTotal AND NOT structKeyExists(form, 'FormOfPayment') )	{
				ErrorPayment = 9;
			}
			// APPLY CREDIT TO WHOLE ORDER
			else if( form.CreditToApply GTE OrderTotal )	{
				if( form.CreditToApply GT OrderTotal )	{
					Form.CreditToApply = OrderTotal;
				}
				FullCreditAmount = 1;
				form.FormOfPayment = 0;
				BillingStatus = 'PA';					
			}
			// ALL IS GOOD, CONTINUE TO FUND WITH STORE CREDIT AND OTHER SOURCE
			else if( structKeyExists(form, 'FormOfPayment') )	{
				IncludeCredit = 1;
			} 
			else	{
				ErrorPayment = 9;
			}
		</cfscript>
	</cfif>
	
	<!--- CREDIT CARD ERROR CHECKING GOES HERE, BEFORE GOING TO CO-PLACEORDER.CFM ---------------------------------------------->
	<cfif structKeyExists(form, 'FormOfPayment') and form.FormOfPayment EQ 1 >
		<cfinclude template="includes/ValidateCC.cfm">
	</cfif>
	<!------------------------------------------------------------>
	<!--- IF CREDIT CARD IS ERROR FREE, CONTINUE PLACING ORDER --->
	<cfif not isDefined('ErrorPayment') AND structKeyExists(form, 'FormOfPayment') and ( not isDefined('FullCreditAmount') OR isDefined('IncludeCredit') ) >
		
		<!--- VALIDATE PAYMENT INFORMATION ENTRIES --->
		<cfif form.FormOfPayment EQ 1 AND
			 (form.CardName EQ '' OR
			  form.CardNum EQ '' OR
			  form.ExpDate EQ '' OR
			  form.CardCVV EQ '' ) >
			<cfset ErrorPayment = 4 >
		<cfelse>
			
		<!--- REALTIME CREDIT CARD PROCESSING --->
		
			<!--- AUTHORIZE.NET --->
			<cfif application.PaymentSystem eq 2 and FORM.FormOfPayment eq 1 
			   and (application.RealtimePayments eq 1 OR application.RealtimePayments eq 2)>
				<cftry>
					<!--- SET UP ALL VARIABLES FOR PAYMENT SYSTEM --->					
					<cfscript>
						getAN = application.Queries.getAN(SiteID=application.SiteID);
						getANTK = application.Queries.getANTK(SiteID=application.SiteID);
					</cfscript>
					
					
					<!--- GET NEXT ORDER ID FOR THIS ORDER --->
					<cfquery name="getNextOrderID" datasource="#application.dsn#">
						SELECT 	MAX(OrderID) + 1 AS NextOrderID
						FROM	Orders
					</cfquery>
					
					<cfscript>
						decrypted_LOGIN = DECRYPT(getAN.Login, application.CryptKey, "CFMX_COMPAT", "Hex") ;
						decrypted_TK = DECRYPT(getANTK.TransKey, application.CryptKey, "CFMX_COMPAT", "Hex") ;
						decrypted_HASH = "";
						if (getAN.Hash IS NOT "")
							decrypted_HASH = DECRYPT(getAN.Hash, application.CryptKey, "CFMX_COMPAT", "Hex") ;
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
					<cfif application.RealtimePayments EQ 1 >
						<cfmodule template="includes/AIM.cfm"
							login="#decrypted_LOGIN#"
							transactionkey="#decrypted_TK#" 
							hashvalue="#decrypted_HASH#"
							invoicenum="#NextOrderID#" 
							invoiceamt="#Replace(DecimalFormat(RunningTotal),',','')#"
							description="#application.StoreNameShort# Purchase" 
							chargemethod="CC"
							chargetype="AUTH_ONLY"
							cardnumber="#Form.CardNum#"				
							cardexpiration="#Form.ExpDate#"
							cardcode="#Form.CardCVV#"
							custid="#session.CustomerArray[17]#"
							fname="#session.CustomerArray[1]#"
							lname="#session.CustomerArray[2]#" 
							streetaddress="#StreetAddress#"
							city="#session.CustomerArray[5]#"
							state="#session.CustomerArray[6]#" 
							zip="#session.CustomerArray[7]#"
							country="#session.CustomerArray[8]#"
							shiptofname="#session.CustomerArray[18]#"
							shiptolname="#session.CustomerArray[19]#" 
							shiptostreetaddress="#ShipToStreetAddress#"
							shiptocity="#session.CustomerArray[22]#"
							shiptostate="#session.CustomerArray[23]#" 
							shiptozip="#session.CustomerArray[24]#"
							shiptocountry="#session.CustomerArray[25]#"
							phone="#session.CustomerArray[9]#"
							email="#session.CustomerArray[11]#"
							testrequest="#application.pgTestMode#"
						>
					<!--- AUTH_CAPTURE --->
					<cfelse>
						<cfmodule template="includes/AIM.cfm"
							login="#decrypted_LOGIN#"
							transactionkey="#decrypted_TK#" 
							hashvalue="#decrypted_HASH#"
							invoicenum="#NextOrderID#" 
							invoiceamt="#Replace(DecimalFormat(RunningTotal),',','')#"
							description="#application.StoreNameShort# Purchase" 
							chargemethod="CC"
							chargetype="AUTH_CAPTURE"
							cardnumber="#Form.CardNum#"				
							cardexpiration="#Form.ExpDate#"
							cardcode="#Form.CardCVV#"
							custid="#session.CustomerArray[17]#"
							fname="#session.CustomerArray[1]#"
							lname="#session.CustomerArray[2]#" 
							streetaddress="#StreetAddress#"
							city="#session.CustomerArray[5]#"
							state="#session.CustomerArray[6]#" 
							zip="#session.CustomerArray[7]#"
							country="#session.CustomerArray[8]#"
							shiptofname="#session.CustomerArray[18]#"
							shiptolname="#session.CustomerArray[19]#" 
							shiptostreetaddress="#ShipToStreetAddress#"
							shiptocity="#session.CustomerArray[22]#"
							shiptostate="#session.CustomerArray[23]#" 
							shiptozip="#session.CustomerArray[24]#"
							shiptocountry="#session.CustomerArray[25]#"
							phone="#session.CustomerArray[9]#"
							email="#session.CustomerArray[11]#"
							testrequest="#application.pgTestMode#"
						>
					</cfif>
					
					<cfcatch type="any">
						<cfset ErrorMsg = 'There has been an error in credit card processing ...' >
						
						<cfoutput>
						#cfcatch.message#<br>
						#cfcatch.detail# 
						</cfoutput>
						
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
						if ( application.RealtimePayments EQ 1 )
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
			<cfelseif application.PaymentSystem eq 7 and FORM.FormOfPayment eq 1 
			   and (application.RealtimePayments eq 1 or application.RealtimePayments eq 2)>
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
					<cfif application.RealtimePayments EQ 1 >
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
						<cfinclude template="admin/YourPay/lpcfm.cfm">
						
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
						<cfinclude template = "admin/YourPay/lpcfm.cfm">
						
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
							if ( application.RealtimePayments EQ 1 )
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
			</cfif><!--- IF application.REALTIMEPAYMENTS EQUALS 1 --->
			
			<cfif not isDefined('ErrorPayment') >
				
				<cfmodule template="templates/#application.SiteTemplate#/layout.cfm" currenttab="MyAccount" layoutstyle="Full" pagetitle="Check Out - Step 4 of 4" showcategories="false">
		
				<!--- Start Breadcrumb --->
				<cfmodule template="tags/breadCrumbs.cfm" crumblevel='2' showlinkcrumb="<a href=cartedit.cfm>Cart</a> | Check Out - Step 4 of 4 | Complete!" />
				<!--- End BreadCrumb --->
				
				<cfinclude template="CO-PlaceOrder.cfm">
				<cfabort>
				
			</cfif>
			
		</cfif>
	
	
	<cfelseif NOT isDefined('ErrorPayment') AND NOT isDefined('Form.FormOfPayment') AND NOT isDefined('FullCreditAmount') >
		
		<cfset ErrorPayment = 3 >
	
	<cfelseif isDefined('Form.FormOfPayment') AND Form.FormOfPayment EQ 0 >
		
		<cfmodule template="templates/#application.SiteTemplate#/layout.cfm" currenttab="MyAccount" layoutstyle="Full" pagetitle="Check Out - Step 4 of 4" showcategories="false">

		<!--- Start Breadcrumb --->
		<cfmodule template="tags/breadCrumbs.cfm" crumblevel='2' showlinkcrumb="<a href=cartedit.cfm>Cart</a> | Check Out - Step 4 of 4 | Complete!" />
		<!--- End BreadCrumb --->
		
		<cfinclude template="CO-PlaceOrder.cfm">
		<cfexit method="exittemplate">
		
	</cfif>
	
</cfif>
<!--- END: CLICK BUTTON - CONFIRM OR CANCEL ORDER --->



<cfoutput>

<cfmodule template="templates/#application.SiteTemplate#/layout.cfm" currenttab="MyAccount" layoutstyle="Full" pagetitle="Check Out - Step 3 of 4" showcategories="false">

<!--- Start Breadcrumb --->
<cfmodule template="tags/breadCrumbs.cfm" crumblevel='2' showlinkcrumb="<a href=cartedit.cfm>Cart</a> | <a href=co-billing.cfm>Check Out</a> - Step 3 of 4" />
<!--- End BreadCrumb --->



<!---<div align="right"><img src="images/image-CheckoutProcess3.gif" border="0" hspace="3" align="absmiddle"></div>--->



<cfparam name="ErrorPayment" default="0">

<cfif ErrorPayment neq 0 >

<!--- <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0"> --->
	<cfif ErrorPayment EQ 3 >
		<div align="center" class="cfErrorMsg"><u>ERROR: Please select a Form of Payment before proceeding.</u><br><br></div>
	</cfif>
	<cfif ErrorPayment EQ 4 >
		<div align="center" class="cfErrorMsg"><u>ERROR: Please enter all required (<u>underlined</u>) fields.</u><br><br></div>
	</cfif>
	<cfif ErrorPayment EQ 5 >
		<div align="center" class="cfErrorMsg"><u>ERROR: <cfif isDefined('ResponseReasonText')>#UCASE(ResponseReasonText)#<cfelse>We cannot accept this type of payment.<br/>Please try again.</cfif></u><br><br></div>
	</cfif>
	<cfif ErrorPayment EQ 6 >
		<div align="center" class="cfErrorMsg"><u>ERROR: Your credit card has been declined.</u><br><br></div>
	</cfif>
	<cfif ErrorPayment EQ 7 >
		<div align="center" class="cfErrorMsg"><u>ERROR: Please enter a positive amount of store credit to be applied<br/>and/or select an alternate Form of Payment.</u><br><br></div>
	</cfif>
	<cfif ErrorPayment EQ 8 >
		<div align="center" class="cfErrorMsg"><u>ERROR: You can not apply more than $#Form.AvailableCredit# store credit to this order.</u><br><br></div>
	</cfif>
	<cfif ErrorPayment EQ 9 >
		<div align="center" class="cfErrorMsg"><u>ERROR: In addition to applying store credit,<br/>please select a Form of Payment for the remaining balance of the order.</u><br><br></div>
	</cfif>
<!--- </table> --->
</cfif>

<!--- <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr><td style="padding-top:10px; padding-bottom:5px;" align="right"><img src="images/image-CheckoutProcess3.gif" hspace="3" align="absmiddle"><br><br></td></tr>
</table> --->


<cfform action="CO-Payment.cfm" method="POST">

	<!--- SHOW INFORMATION THUS FAR --->
	<table width="100%" cellpadding="5" cellspacing="0" class="cartLayoutTable">
		<tr>
			<th>Please review your order and enter payment information below.</th>
		</tr>
		<tr>
			<td align="center">
				<cfif not isDefined('Cart.CartTotal1')>
					<cfinclude template="includes/CartTotals.cfm">
				</cfif>
				<cfinclude template="includes/CO-InfoThusFar.cfm">
			</td>
		</tr>
	</table>
	<br/>
	
	<!--- PAYMENT METHODS --->
	<table width="100%" cellpadding="5" cellspacing="0" class="cartLayoutTable">
		<tr>
			<th>Form of <cfif cgi.https is "on" >SECURE </cfif>Payment</th>
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
	<br/>
	
	<!--- CUSTOMER COMMENTS --->
	<table width="100%" cellpadding="5" cellspacing="0" class="cartLayoutTable">
		<tr>
			<th>Order Comments, Questions, or Suggestions?</th>
		</tr>
		<tr><td height="1"><img src="images/spacer.gif" height="1" width="1" /></td></tr>
		<tr>
			<td>
				<textarea name="CustomerComments" style="width:90%; height:50px; background-color:##FFC;"></textarea>
			</td>
		</tr>
	</table>
	<br/>
	
	<!--- SHOW CART --->
	<cfinclude template="includes/CartView.cfm">
					
	<div class="smallFont" style="float:left; padding: 10px 0px;">
		Please make sure all of the above information is accurate, then click COMPLETE ORDER &gt; <br/>
		to finalize the checkout process and <cfif cgi.https is "on" >securely</cfif> complete your order.<br/>
		<a href="CartClean.cfm" tabindex="5000" onclick="return confirm('Are you sure you want to CANCEL THIS ORDER completely and remove all items from your shopping cart?')">Click here to cancel</a> the checkout process and delete your order.<br/>
	</div>
	<div class="smallFont" style="float:right; padding: 10px 0px;">
		<input type="submit" name="Step4" value="COMPLETE ORDER &gt;" class="finalizebutton"><br/>
		<!--- CARTFUSION 4.5 - MULTIPLE SHIPPING ADDRESSES --->	
		<cfloop from="1" to="#Cart.Packages#" index="cpi">
			<input type="hidden" name="ShippingMethod#cpi#" value="#Evaluate('Form.ShippingMethod' & cpi)#">
		</cfloop>
	</div>
</cfform>
	</cfmodule>
</cfoutput>
