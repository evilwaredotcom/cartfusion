<!--- 
|| LEGAL ||
$CartFusion - Copyright � 2001-2007 Trade Studios, LLC.$
$This copyright notice MUST stay intact for use (see license.txt).$
$It is against the law to copy, distribute, gift, bundle or give away this code$
$without written consent from Trade Studios, LLC.$

|| VERSION CONTROL ||
$Id: $
$Date: $
$Revision: $

|| DESCRIPTION || 
$Description: 	Final Step 4 of 4 of the checkout process $
$TODO: 			Move all of these functions to a CFC and show Success/Fail $
$				confirmation message and print invoice on CO-Payment.cfm $
--->

<!--- INVOKE INSTANCE OF OBJECT - GET CART ITEMS --->
<!--- CARTFUSION 4.6 - CART CFC --->
<cfscript>
	if ( TRIM(session.CustomerArray[28]) NEQ '' ) {
		UserID = session.CustomerArray[28] ;
	} else {
		UserID = 1 ;
	}
	getCartItems = application.Cart.getCartItems(
		UserID=UserID,
		SiteID=application.SiteID,
		SessionID=SessionID) ;
</cfscript>

<!--- CHECK FOR MINIMUM ORDER REQUIREMENT --->
<cfinclude template="Includes/CartMinimums.cfm">

<cfif not getCartItems.data.RecordCount OR MinNotReached EQ 1 OR FirstOrder EQ 1 >
	<cflocation url="CartEdit.cfm" addtoken="no">
	
<!--- IF CART HAS STUFF... --->
<cfelse>
	
	<!--- IF WE'RE NOT ACCEPTING INTERNATIONAL SHIPMENTS AT THIS TIME --->
	<cfif session.CustomerArray[25] NEQ application.BaseCountry>
		<cfif application.AcceptIntShipment EQ 0 >	
			<div class="11pxDarkGray" align="center">
				<div class="13pxDarkGrayBold" align="center"><cfoutput>#application.StoreName#</cfoutput> Error</div><br>
				We are sorry...<br>
				At this moment we are not accepting international shipments.<br>
				You can go back and specify a national shipping address or cancel your order.<br>
				Thank you.
			</div>
			<form action="CartClean.cfm" method="post">
				<input class="10pxDarkGray" type="submit" name="CancelBt" value=" Cancel Order ">
			</form>
			<form action="CO-Billing.cfm?errorBilling=3" method="post">
				<input class="10pxDarkGray" type="submit" name="GoBack" value=" Change Shipping Address ">
			</form>
		<cfabort>
		<cfelse>
			<cfset IntShip = 1>
		</cfif>
	<cfelse>
		<cfset IntShip = 0>
	</cfif>
	
	<!--- APPLY FORM FIELDS TO CUSTOMER ARRAY --->
	<cfscript>
		if ( application.AllowCreditCards EQ 1 AND Form.FormOfPayment EQ 1 )
		{
			// ENCRYPT CARDNUMBER, EXPIRATION DATE
			Encrypted_CardNum = TRIM(ENCRYPT(Form.CardNum, application.CryptKey, "CFMX_COMPAT", "Hex")) ;
			Encrypted_ExpDate = TRIM(ENCRYPT(Form.ExpDate, application.CryptKey, "CFMX_COMPAT", "Hex")) ;
		}
	</cfscript>
		
	<!--- Check all the fields to see if they are there. If not set an error flag and report it. --->
	<!--- If all the required fields check out so far then do some other stuff. --->
	
	<cfquery name="SearchCustomer" datasource="#application.dsn#">
		SELECT 	CustomerID
		FROM 	Customers
		WHERE 	UserName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.CustomerArray[26]#" >
		OR		CustomerID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.CustomerArray[17]#" >
	</cfquery>
	
	<!--- SET CUSTOMER ID --->
	<cfscript>
		ReturningCustomer = 0;
		if (SearchCustomer.RecordCount NEQ 0 AND SearchCustomer.CustomerID NEQ '')
		{
			ReturningCustomer = 1;
			session.CustomerArray[17] = SearchCustomer.CustomerID;
		}
		else if (session.CustomerArray[17] EQ '')
		{	
			session.CustomerArray[17] = FormatBaseN(Now(),10) & RandRange(100,999) & Second(Now()) + 10 ;
		}
	</cfscript>
	
	<!--- 
		CALCULATE TOTAL 
	--->
	<cfinclude template="Includes/CalculateTotal.cfm">
	
	<!--- BEGIN: LEGITAMIZE AFFILIATE ID AND CALCULATE COMMISSION --->
	<cfif session.CustomerArray[36] NEQ '' >
		<cfquery name="getLegitAFID" datasource="#application.dsn#">
			SELECT	AFID
			FROM	Affiliates
			WHERE	AFID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.CustomerArray[36]#" >
			AND		Disabled != 1
		</cfquery>
		<cfscript>
			if ( getLegitAFID.RecordCount NEQ 0 )
			{
				UseAFID = 1 ;
				AffiliateTotal = 0 ;
			}
		</cfscript>
	</cfif>
	<!--- END: LEGITAMIZE AFFILIATE ID AND CALCULATE COMMISSION --->
	 
	<!--- REPLACE THE ANNOYING APOSTROPHE THAT CAUSES DB ERROR THROWS --->
	<cflock scope="session" timeout="5" type="exclusive">
		<cfloop index="loopcount" from=1 to="#ArrayLen(session.CustomerArray)#">
			<cfif session.CustomerArray[loopcount] CONTAINS "'">
				<cfset session.CustomerArray[loopcount] = #Replace(session.CustomerArray[loopcount], "'", "", "ALL")#>
			</cfif>
		</cfloop>
	</cflock>
			
	<!--- LAST ERROR CHECK --->	
	<cfif 	session.CustomerArray[1] EQ '' OR
			session.CustomerArray[2] EQ '' OR
			session.CustomerArray[3] EQ '' OR
			session.CustomerArray[5] EQ '' OR
			session.CustomerArray[6] EQ '' OR
			session.CustomerArray[7] EQ '' OR
			session.CustomerArray[8] EQ '' OR
			session.CustomerArray[9] EQ '' OR
			session.CustomerArray[11] EQ '' OR
			session.CustomerArray[17] EQ '' OR
			session.CustomerArray[18] EQ '' OR
			session.CustomerArray[19] EQ '' OR
			session.CustomerArray[20] EQ '' OR
			session.CustomerArray[22] EQ '' OR
			session.CustomerArray[23] EQ '' OR
			session.CustomerArray[24] EQ '' OR
			session.CustomerArray[25] EQ '' OR
			session.CustomerArray[29] EQ ''>
			<cfoutput>
			<div align="center" class="cfErrorMsg">
				ERROR OCCURRED DURING TRANSACTION: MISSING ORDER INFORMATION.<br>
				TRANSACTION HAS BEEN ROLLED BACK.  PLEASE CONTACT SYSTEM ADMINISTRATOR FOR SUPPORT.
			</div>
			</cfoutput>	
		<cfabort>
	<cfelse><!--- IF NO MISSING INFORMATION, TRY TRANSACTION --->
		
		<!--- BEGIN: TRANSACTION --->
		
		<cftransaction>
		<cflock timeout="20">
			<cfinvoke component="#application.Queries#" method="getLastOrderID" returnvariable="getLastOrderID"></cfinvoke>
		
			<cfscript>
				// SET ORDER ID
				if (getLastOrderID.RecordCount NEQ 0 AND getLastOrderID.LastOrderID NEQ '')
					OrderID = getLastOrderID.LastOrderID + 1;
				else
					OrderID = '1002700';
			</cfscript>
	
		<!--- ADD OR UPDATE CUSTOMER INFORMATION --->
		<cfif ReturningCustomer EQ 0>
			<cfquery name="AddCustomer" datasource="#application.dsn#">
				INSERT INTO Customers
				(
					CustomerID, 
					FirstName, LastName, Address1, Address2, 
					City, State, Zip, Country, 
					Phone, Fax, Email, CompanyName, 
					EmailOK, IPAddress,
					ShipFirstName, ShipLastName, ShipAddress1, ShipAddress2, 
					ShipCity, ShipState, ShipZip, ShipCountry,
					ShipCompanyName, ShipPhone, ShipEmail, 
					<cfif Form.FormOfPayment EQ 1 >
						Cardname, Cardnum, ExpDate, CardCVV, 
					</cfif>
					<cfif application.AffiliateToCustomer EQ 1 AND session.CustomerArray[36] NEQ '' >
						AffiliateID,
					</cfif>
					UserName, Password,
					PriceToUse
				)
				VALUES 
				(
					'#session.CustomerArray[17]#', 
					'#session.CustomerArray[1]#', '#session.CustomerArray[2]#', '#session.CustomerArray[3]#', '#session.CustomerArray[4]#',
					'#session.CustomerArray[5]#', '#Ucase(session.CustomerArray[6])#', '#session.CustomerArray[7]#', '#session.CustomerArray[8]#',
					'#session.CustomerArray[9]#', '#session.CustomerArray[10]#', '#session.CustomerArray[11]#', '#session.CustomerArray[12]#', 
					#session.CustomerArray[30]#, '#CGI.REMOTE_ADDR#', 
					'#session.CustomerArray[18]#', '#session.CustomerArray[19]#', '#session.CustomerArray[20]#', '#session.CustomerArray[21]#',
					'#session.CustomerArray[22]#', '#Ucase(session.CustomerArray[23])#', '#session.CustomerArray[24]#', '#session.CustomerArray[25]#',
					'#session.CustomerArray[34]#', '#session.CustomerArray[35]#', '#session.CustomerArray[31]#',
					<cfif Form.FormOfPayment EQ 1 >
						'#Form.CardName#', '#Encrypted_CardNum#', '#Encrypted_ExpDate#', '#Form.CardCVV#',
					</cfif>
					<cfif application.AffiliateToCustomer EQ 1 >
						#session.CustomerArray[36]#,
					</cfif>
					'#session.CustomerArray[26]#',				
					'#session.CustomerArray[27]#',
					<cfif session.CustomerArray[28] EQ ''> 1
					<cfelse> #session.CustomerArray[28]#
					</cfif>
				)
			</cfquery>
		<cfelse>
			<cfquery name="updateCustomer" datasource="#application.dsn#">
				UPDATE Customers
				SET
					CustomerID = '#session.CustomerArray[17]#',
					Firstname= '#session.CustomerArray[1]#',
					Lastname= '#session.CustomerArray[2]#',
					Address1 = '#session.CustomerArray[3]#',
					Address2 = '#session.CustomerArray[4]#',
					City = '#session.CustomerArray[5]#',
					State = '#Ucase(session.CustomerArray[6])#',
					Zip = '#session.CustomerArray[7]#',
					Country = '#session.CustomerArray[8]#',				
					Phone = '#session.CustomerArray[9]#',
					Fax = '#session.CustomerArray[10]#',
					Email = '#session.CustomerArray[11]#',
					Companyname= '#session.CustomerArray[12]#',
					EmailOK = '#session.CustomerArray[30]#',
					IPAddress = '#CGI.REMOTE_ADDR#',
					ShipFirstname= '#session.CustomerArray[18]#',
					ShipLastname= '#session.CustomerArray[19]#',
					ShipAddress1 = '#session.CustomerArray[20]#',
					ShipAddress2 = '#session.CustomerArray[21]#',
					ShipCity = '#session.CustomerArray[22]#',
					ShipState = '#UCase(session.CustomerArray[23])#',
					ShipZip = '#session.CustomerArray[24]#',
					ShipCountry = '#session.CustomerArray[25]#',
					ShipCompanyName = '#session.CustomerArray[34]#', 
					ShipPhone = '#session.CustomerArray[35]#', 
					ShipEmail = '#session.CustomerArray[31]#',
					<cfif Form.FormOfPayment EQ 1 >
					CardName= '#Form.CardName#',
					CardNum = '#Encrypted_CardNum#',
					ExpDate = '#Encrypted_ExpDate#',
					CardCVV= '#Form.CardCVV#',
					</cfif>
					<cfif application.AffiliateToCustomer EQ 1 AND session.CustomerArray[36] NEQ '' >
					AffiliateID = #session.CustomerArray[36]#,
					</cfif>
					<cfif isDefined('CreditToApply') >
					Credit = Credit - #CreditToApply#,
					</cfif>				
					UserName = '#session.CustomerArray[26]#',
					Password = '#session.CustomerArray[27]#',
					DateUpdated = #Now()#					
				WHERE CustomerID = '#session.CustomerArray[17]#'
			</cfquery>
		</cfif>
		
		<!--- INSERT ORDER INTO DATABASE --->
			<cfquery name="AddToOrders" datasource="#application.dsn#">
				INSERT INTO Orders 
				(
					SiteID, OrderID, CustomerID, IPAddress, ShippingMethod,
					<cfif Form.FormOfPayment EQ 1 >
						CCname, CCnum, CCexpdate, CCCVV, 
					</cfif>				
					oShipFirstName, oShipLastName, oShipAddress1, oShipAddress2,
					oShipCity, oShipState, oShipZip, oShipCountry,
					oShipCompanyName, oShipPhone, oShipEmail,
					orders_FirstName, orders_LastName, orders_Address1, orders_Address2, 
					orders_City, orders_State, orders_Zip, orders_Country, 
					orders_Phone, orders_CompanyName,
					Phone, OrderStatus,
					ShippingTotal, FormOfPayment
					<cfif IsDefined('UseAFID')>, AffiliateID, AffiliateTotal</cfif>
					<cfif IsDefined('TaxPrice')>, TaxTotal</cfif>
					<cfif IsDefined('CreditToApply')>, CreditApplied</cfif>
					<cfif isDefined('CustomerComments') AND CustomerComments NEQ ''>, CustomerComments</cfif>
					<cfif isDefined('DiscountTotal') AND DiscountTotal NEQ 0>, DiscountTotal</cfif>
					<cfif isDefined('DiscountUsed')>, DiscountUsed</cfif>
					
					<!--- REALTIME CREDIT CARD PROCESSING --->
					<cfif isDefined('TransactionID')>, TransactionID</cfif>
					<cfif isDefined('PaymentVerified')>, PaymentVerified</cfif>
					, BillingStatus
				)
				VALUES 
				(
					#application.SiteID#, #OrderID#, #session.CustomerArray[17]#, '#CGI.REMOTE_ADDR#', '#Form.ShippingMethod1#',
					<cfif Form.FormOfPayment EQ 1 >
					'#Form.CardName#', '#Encrypted_CardNum#', '#Encrypted_ExpDate#', '#Form.CardCVV#',
					</cfif>
					'#session.CustomerArray[18]#', '#session.CustomerArray[19]#', '#session.CustomerArray[20]#', '#session.CustomerArray[21]#',
					'#session.CustomerArray[22]#', '#session.CustomerArray[23]#', '#session.CustomerArray[24]#', '#session.CustomerArray[25]#',
					'#session.CustomerArray[34]#', '#session.CustomerArray[35]#', '#session.CustomerArray[31]#',
					'#session.CustomerArray[1]#', '#session.CustomerArray[2]#', '#session.CustomerArray[3]#', '#session.CustomerArray[4]#',
					'#session.CustomerArray[5]#', '#Ucase(session.CustomerArray[6])#', '#session.CustomerArray[7]#', '#session.CustomerArray[8]#',
					'#session.CustomerArray[9]#', '#session.CustomerArray[12]#',
					'#session.CustomerArray[9]#', 'OD',
					#ShippingPrice#, #FormOfPayment#
					<cfif IsDefined('UseAFID')>, #session.CustomerArray[36]#, #AffiliateTotal#</cfif>
					<cfif IsDefined('TaxPrice')>, #TaxPrice#</cfif>
					<cfif IsDefined('CreditToApply')>, #CreditToApply#</cfif>
					<cfif IsDefined('CustomerComments') AND CustomerComments NEQ ''>, '#CustomerComments#'</cfif>
					<cfif IsDefined('DiscountTotal') AND DiscountTotal NEQ 0>, #DiscountTotal#</cfif>
					<cfif isDefined('DiscountUsed')>, #DiscountUsed#</cfif>
					
					<!--- REALTIME CREDIT CARD PROCESSING --->
					<cfif isDefined('TransactionID')>, '#TransactionID#'</cfif>
					<cfif isDefined('PaymentVerified')>, #PaymentVerified#</cfif>
					<cfif isDefined('BillingStatus')>, '#BillingStatus#'<cfelse>, 'NB'</cfif>
				)
			</cfquery>
	
		<!--- INSERT ORDER ITEMS INTO DATABASE --->
		<cfoutput query="getCartItems.data">
		
			<!--- CARTFUSION 4.6 - CART CFC --->
			<cfscript>
				if ( TRIM(session.CustomerArray[28]) NEQ '' ) {
					UserID = session.CustomerArray[28] ;
				} else {
					UserID = 1 ;
				}
				UseThisPrice = application.Cart.getItemPrice(
									UserID=UserID,
									SiteID=application.SiteID,
									ItemID=ItemID,
									SessionID=SessionID,
									OptionName1=OptionName1,
									OptionName2=OptionName2,
									OptionName3=OptionName3
									) ;
			</cfscript>
			
			<cfif application.EnableMultiShip EQ 1 >
				<cfquery name="getDistinctAddresses" dbtype="query">
					SELECT 	DISTINCT ShippingID
					FROM	getCartItems.data
					WHERE	ShippingID != 0
					AND		ShippingID IS NOT NULL
				</cfquery>
				<cfquery name="getCustomerSH" datasource="#application.dsn#">
					SELECT	*
					FROM	CustomerSH
					WHERE	CustomerID = '#session.CustomerArray[17]#'
					AND		SHID = #getCartItems.data.ShippingID#
				</cfquery>
			</cfif>

			<cfscript>
				if (BackOrdered NEQ 1)
					StatusCode = 'OD';
				else
					StatusCode = 'BO';
			</cfscript>
	
			<cfquery name="AddToOrderItems" datasource="#application.dsn#">
				INSERT INTO OrderItems
					( OrderID, ItemID, Qty, ItemPrice, OptionName1, OptionName2, OptionName3, StatusCode
					  <cfif isDefined('getDistinctAddresses') AND getDistinctAddresses.RecordCount NEQ 0 >
							, ShippingID, orderitems_FirstName, orderitems_LastName, orderitems_CompanyName, 
							orderitems_Address1, orderitems_Address2, orderitems_City, orderitems_State, 
							orderitems_Zip, orderitems_Country, orderitems_Phone, orderitems_Email
					  </cfif>
					)
				VALUES 
					( #OrderID#, #ItemID#, #Qty#, #UseThisPrice#, '#OptionName1#', '#OptionName2#', '#OptionName3#', '#StatusCode#' 
					 <cfif isDefined('getDistinctAddresses') AND getDistinctAddresses.RecordCount NEQ 0 >
					  	<cfif isDefined('getCustomerSH') AND getCartItems.data.ShippingID GT 0 >
							, #getCartItems.data.ShippingID#, '#getCustomerSH.ShipFirstName#', '#getCustomerSH.ShipLastName#', '#getCustomerSH.ShipCompanyName#', 
							'#getCustomerSH.ShipAddress1#', '#getCustomerSH.ShipAddress2#', '#getCustomerSH.ShipCity#', '#getCustomerSH.ShipState#', 
							'#getCustomerSH.ShipZip#', '#getCustomerSH.ShipCountry#', '#getCustomerSH.ShipPhone#', '#getCustomerSH.ShipEmail#'
						<cfelse>
							, #getCartItems.data.ShippingID#, '#session.CustomerArray[18]#', '#session.CustomerArray[19]#', '#session.CustomerArray[34]#', 
							'#session.CustomerArray[20]#', '#session.CustomerArray[21]#', '#session.CustomerArray[22]#', '#session.CustomerArray[23]#', 
							'#session.CustomerArray[24]#', '#session.CustomerArray[25]#', '#session.CustomerArray[35]#', '#session.CustomerArray[31]#'
						</cfif>
					  </cfif>
					)
			</cfquery>
			
			<!--- BEGIN: EDIT STOCK QUANTITIES HERE ---------------------------------------------------------->
			<cfquery name="UpdateInventory" datasource="#application.dsn#">
				UPDATE	Products
				SET		StockQuantity = StockQuantity - #Qty#
				WHERE	ItemID = #ItemID#
			</cfquery>
			
			<!--- UPDATE STOCK QUANTITIES OF OPTIONS ---><!--- OPTIONAL --->
			<cfif OptionName1 NEQ '' OR OptionName2 NEQ '' OR OptionName3 NEQ ''>
				<cfquery name="getUseMatrix" datasource="#application.dsn#">
					SELECT	UseMatrix
					FROM	Products
					WHERE	ItemID = #ItemID#
					AND		UseMatrix = 1
				</cfquery>
				<!--- UPDATE PRODUCT OPTIONS TABLE --->
				<cfif getUseMatrix.RecordCount EQ 0 >
					<cfif OptionName1 NEQ ''>
						<cfquery name="UpdateOption1" datasource="#application.dsn#">
							UPDATE	ProductOptions
							SET		StockQuantity = StockQuantity - #Qty#
							WHERE	ItemID = #ItemID#
							AND		OptionColumn = 1
							AND		OptionName = '#OptionName1#'
						</cfquery>
					</cfif>
					<cfif OptionName2 NEQ ''>
						<cfquery name="UpdateOption2" datasource="#application.dsn#">
							UPDATE	ProductOptions
							SET		StockQuantity = StockQuantity - #Qty#
							WHERE	ItemID = #ItemID#
							AND		OptionColumn = 2
							AND		OptionName = '#OptionName2#'
						</cfquery>
					</cfif>
					<cfif OptionName3 NEQ ''>
						<cfquery name="UpdateOption3" datasource="#application.dsn#">
							UPDATE	ProductOptions
							SET		StockQuantity = StockQuantity - #Qty#
							WHERE	ItemID = #ItemID#
							AND		OptionColumn = 3
							AND		OptionName = '#OptionName3#'
						</cfquery>
					</cfif>
				<!--- UPDATE INVENTORY MATRIX TABLE --->
				<cfelse>
					<cfquery name="UpdateItemClassComponents" datasource="#application.dsn#">
						UPDATE	ItemClassComponents
						SET		CompQuantity = CompQuantity - #Qty#
						WHERE	ItemID = #ItemID#
						<cfif OptionName1 NEQ ''>
						AND		Detail1 = '#OptionName1#'
						</cfif>
						<cfif OptionName2 NEQ ''>
						AND		Detail2 = '#OptionName2#'
						</cfif>
						<cfif OptionName3 NEQ ''>
						AND		Detail3 = '#OptionName3#'
						</cfif>
					</cfquery>
				</cfif>
			</cfif>
			<!--- END: EDIT STOCK QUANTITIES HERE ---------------------------------------------------------->
				
		</cfoutput>
		
		<!--- LOG DISCOUNT USAGE USING LIST "DISCOUNTSUSED" FROM CALCULATETOTALS.CFM --->
		<cfif DiscountsUsed NEQ '' >
			<cfloop list="#DiscountsUsed#" index="ListElement" delimiters=",">
				<cfquery name="UpdateDiscounts" datasource="#application.dsn#">
					INSERT INTO DiscountUsage
						( CustomerID, DiscountID )
					VALUES 
						( '#session.CustomerArray[17]#', #ListElement# )
				</cfquery>
			</cfloop>
		</cfif>
		
		<!--- ORDER TRANSACTION COMPLETE - EMAIL ORDER CONFIRMATION --->
		<!--- IF PAYMENT IS NOT VIA PAYPAL STANDARD ------------------->
		<cfif FormOfPayment NEQ 2 >
			<cfinclude template="EmailOrder.cfm">
		</cfif>		
			
		</cflock>
		</cftransaction>	
	
		<!---------------------------------------------PAYPAL: GO --------------------------------------------------->
		<cfparam name="PayPalReturned" default="0" type="boolean">
		<cfif FormOfPayment EQ 2 >
			<cfset PayPalReturned = 0 > <!--- Have not returned from PayPal yet. --->
			
			<cfquery name="getPayPal" datasource="#application.dsn#">
				SELECT	PayPalAccount
				FROM	PGPayPal
				WHERE	PPID = 1
			</cfquery>
			
			<cfoutput>
				<form name="PP" action="https://www.paypal.com/cgi-bin/webscr" method="post">
					<input type="hidden" name="cmd" value="_ext-enter">
					<input type="hidden" name="redirect_cmd" value="_xclick">
					<input type="hidden" name="business" value="#getPayPal.PayPalAccount#">
					<input type="hidden" name="item_name" value="#application.StoreNameShort# Order #OrderID#">
					<input type="hidden" name="invoice" value="#OrderID#">
					<input type="hidden" name="amount" value="#DecimalFormat(RunningTotal - ShippingPrice)#">
					<input type="hidden" name="shipping" value="#DecimalFormat(ShippingPrice)#">
					<input type="hidden" name="no_shipping" value="0">
					<input type="hidden" name="return" value="#application.RootURL#/CO-PayPalSuccess.cfm?OrderID=#OrderID#">
					<input type="hidden" name="cancel_return" value="#application.RootURL#/CO-PayPalFail.cfm?OrderID=#OrderID#">
					<input type="hidden" name="image_URL" value="#application.RootURL#/images/logos/image-PayPal.jpg">
					<!--- PRE-POPULATE --->
					<input type="hidden" name="email" value="#session.CustomerArray[11]#">
					<input type="hidden" name="login_email" value="#session.CustomerArray[11]#">
					<input type="hidden" name="first_name" value="#session.CustomerArray[1]#">
					<input type="hidden" name="last_name" value="#session.CustomerArray[2]#">
					<input type="hidden" name="address1" value="#session.CustomerArray[3]#">
					<input type="hidden" name="address2" value="#session.CustomerArray[4]#">
					<input type="hidden" name="city" value="#session.CustomerArray[5]#">
					<input type="hidden" name="state" value="#session.CustomerArray[6]#">
					<input type="hidden" name="zip" value="#session.CustomerArray[7]#">
					<input type="hidden" name="night_phone_a" value="">
					<input type="hidden" name="night_phone_b" value="">
					<input type="hidden" name="night_phone_c" value="">
					<input type="hidden" name="day_phone_a" value="">
					<input type="hidden" name="day_phone_b" value="">
					<input type="hidden" name="day_phone_c" value="">
					<script language="javascript">
						document.PP.submit();
					</script>
				</form>
			</cfoutput>
			<cfabort>
		</cfif>
		<!---------------------------------------------PAYPAL: GO --------------------------------------------------->
		
		<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
			<tr>
				<td align="center">
					<cfinclude template="Includes/CO-PrintOrder.cfm">
				</td>
			</tr>
		</table>
		
		
		<cfif session.CustomerArray[36] NEQ ''>
			<div class="cfDefault" align="center">(Affiliate: <cfoutput>#session.CustomerArray[36]#</cfoutput>)</div><br>
		</cfif>
		
		<!--- EXPIRE GIFT CERTIFICATE IF ONE IS USED 
		<cfif isDefined('DiscountUsed')>
			<cfquery name="getDiscountType" datasource="#application.dsn#">
				SELECT	DiscountType
				FROM	Discounts
				WHERE	DiscountID = #DiscountUsed#
			</cfquery>
			<cfif getDiscountType.RecordCount NEQ 0 AND getDiscountType.DiscountType EQ 1 >
				<cfinvoke component="#application.Queries#" method="expireDiscountID" returnvariable="expireDiscountID">
					<cfinvokeargument name="DiscountID" value="#DiscountUsed#">
				</cfinvoke>
			</cfif>
		</cfif>
		--->	
		
		<!--- ORDER TRANSACTION COMPLETE - NOW CLEAN UP CART --->
		<cfinclude template="Includes/CartCleanPostOrder.cfm">
	
	</cfif><!--- END: IF MISSING INFORMATION - TRANSACTION --->
</cfif><!--- CART HAS STUFF IN IT --->

<!--- <cfinclude template="LayoutGlobalFooter.cfm"> --->