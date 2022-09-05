<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<cfscript>
	PageTitle = 'Transaction Details' ;
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">

<cfif isDefined('Form.ProcessPayment') AND Form.ProcessPayment EQ 1>

	<!--- AUTHORIZE.NET --->
	<cfif application.PaymentSystem EQ 2 >
		<cftry>
			<!--- SET UP ALL VARIABLES FOR PAYMENT SYSTEM --->
			
			<cfinvoke component="#application.Queries#" method="getAN" returnvariable="getAN">
				<cfinvokeargument name="SiteID" value="#application.SiteID#">
			</cfinvoke>
			<cfinvoke component="#application.Queries#" method="getANTK" returnvariable="getANTK">
				<cfinvokeargument name="SiteID" value="#application.SiteID#">
			</cfinvoke>
			
			<cfscript>
				decrypted_LOGIN = DECRYPT(getAN.Login, application.CryptKey, "CFMX_COMPAT", "Hex") ;
				decrypted_TK = DECRYPT(getANTK.TransKey, application.CryptKey, "CFMX_COMPAT", "Hex") ;
				decrypted_HASH = "";
				if (getAN.Hash IS NOT "")
					decrypted_HASH = DECRYPT(getAN.Hash, application.CryptKey, "CFMX_COMPAT", "Hex") ;
			</cfscript>
			
			<cfif isDefined('Form.AuthType') AND Form.AuthType EQ 'AUTH_ONLY'>
				<!--- AUTH_ONLY --->
				<cfmodule template="Includes/AIM.cfm"
					login="#decrypted_LOGIN#"
					transactionkey="#decrypted_TK#" 
					hashvalue="#decrypted_HASH#"
					invoicenum="#Form.x_Invoice_Num#" 
					invoiceamt="#Form.x_Amount#"
					description="#Form.x_Description#" 
					chargemethod="CC"
					chargetype="AUTH_ONLY"
					cardnumber="#Form.x_Card_Num#"				
					cardexpiration="#Form.x_Exp_Date#"
					cardcode="#Form.x_Card_Code#"
					custid="#Form.x_Cust_ID#"
					fname="#Form.x_First_Name#"
					lname="#Form.x_Last_Name#" 
					streetaddress="#Form.x_Address#"
					city="#Form.x_City#"
					state="#Form.x_State#" 
					zip="#Form.x_Zip#"
					country="#Form.x_Country#"
					shiptofname="#Form.x_Ship_To_First_Name#"
					shiptolname="#Form.x_Ship_To_Last_Name#" 
					shiptostreetaddress="#Form.x_Ship_To_Address#"
					shiptocity="#Form.x_Ship_To_City#"
					shiptostate="#Form.x_Ship_To_State#" 
					shiptozip="#Form.x_Ship_To_Zip#"
					shiptocountry="#Form.x_Ship_To_Country#"
					phone="#Form.x_Phone#"
					email="#Form.x_Email#"
					testrequest="#application.pgTestMode#" 
				>
			<cfelseif isDefined('Form.AuthType') AND Form.AuthType EQ 'VOID'>
				<!--- VOID AUTH_ONLY --->
				<cfmodule template="Includes/AIM.cfm"
					login="#decrypted_LOGIN#"
					transactionkey="#decrypted_TK#"
					hashvalue="#decrypted_HASH#"
					chargemethod="CC"
					chargetype="VOID"
					chargeid="#Form.x_trans_id#"
					testrequest="#application.pgTestMode#" 
				>
			<cfelseif isDefined('Form.AuthType') AND Form.AuthType EQ 'PRIOR_AUTH_CAPTURE'>
				<!--- PRIOR_AUTH_CAPTURE --->
				<cfmodule template="Includes/AIM.cfm"
					login="#decrypted_LOGIN#"
					transactionkey="#decrypted_TK#" 
					hashvalue="#decrypted_HASH#"
					invoicenum="#Form.x_Invoice_Num#" 
					invoiceamt="#Form.x_Amount#"
					description="#Form.x_Description#" 
					chargemethod="CC"
					chargetype="PRIOR_AUTH_CAPTURE"
					chargeid="#Form.x_trans_id#"
					cardnumber="#Form.x_Card_Num#"				
					cardexpiration="#Form.x_Exp_Date#"
					cardcode="#Form.x_Card_Code#" 
					custid="#Form.x_Cust_ID#"
					fname="#Form.x_First_Name#"
					lname="#Form.x_Last_Name#" 
					streetaddress="#Form.x_Address#"
					city="#Form.x_City#"
					state="#Form.x_State#" 
					zip="#Form.x_Zip#"
					country="#Form.x_Country#"
					shiptofname="#Form.x_Ship_To_First_Name#"
					shiptolname="#Form.x_Ship_To_Last_Name#" 
					shiptostreetaddress="#Form.x_Ship_To_Address#"
					shiptocity="#Form.x_Ship_To_City#"
					shiptostate="#Form.x_Ship_To_State#" 
					shiptozip="#Form.x_Ship_To_Zip#"
					shiptocountry="#Form.x_Ship_To_Country#"
					phone="#Form.x_Phone#"
					email="#Form.x_Email#"
					testrequest="#application.pgTestMode#" 
				>
			<cfelse>
				<!--- AUTH_CAPTURE --->
				<cfmodule template="Includes/AIM.cfm"
					login="#decrypted_LOGIN#"
					transactionkey="#decrypted_TK#" 
					hashvalue="#decrypted_HASH#"
					invoicenum="#Form.x_Invoice_Num#" 
					invoiceamt="#Form.x_Amount#"
					description="#Form.x_Description#" 
					chargemethod="CC"
					chargetype="AUTH_CAPTURE"
					cardnumber="#Form.x_Card_Num#"				
					cardexpiration="#Form.x_Exp_Date#"
					cardcode="#Form.x_Card_Code#" 
					custid="#Form.x_Cust_ID#"
					fname="#Form.x_First_Name#"
					lname="#Form.x_Last_Name#" 
					streetaddress="#Form.x_Address#"
					city="#Form.x_City#"
					state="#Form.x_State#" 
					zip="#Form.x_Zip#"
					country="#Form.x_Country#"					
					shiptofname="#Form.x_Ship_To_First_Name#"
					shiptolname="#Form.x_Ship_To_Last_Name#" 
					shiptostreetaddress="#Form.x_Ship_To_Address#"
					shiptocity="#Form.x_Ship_To_City#"
					shiptostate="#Form.x_Ship_To_State#" 
					shiptozip="#Form.x_Ship_To_Zip#"
					shiptocountry="#Form.x_Ship_To_Country#"					
					phone="#Form.x_Phone#"
					email="#Form.x_Email#"
					testrequest="#application.pgTestMode#" 
				>
			</cfif>
			
			<cfcatch type="any">
				<cfset AdminMsg = 'There has been an error in credit card processing ...' >
				<cfoutput>
				#cfcatch.message#<br>
				#cfcatch.detail# 
				</cfoutput>
		  </cfcatch>
		</cftry>
		
	<!--- USAePay --->
	<cfelseif application.PaymentSystem EQ 3 >
		<cftry>
			<!--- SET UP ALL VARIABLES FOR PAYMENT SYSTEM --->
			
			<cfinvoke component="#application.Queries#" method="getUSAePay" returnvariable="getUSAePay">
				<cfinvokeargument name="SiteID" value="#application.SiteID#">
			</cfinvoke>
			
			<cfscript>
				decrypted_TK = DECRYPT(getUSAePay.TransKey, application.CryptKey, "CFMX_COMPAT", "Hex") ;
			</cfscript>
			
			<cfif isDefined('Form.AuthType') AND Form.AuthType EQ 'AUTH_ONLY'>
				<cfmodule template="Includes/USAePay.cfm"
					queryname="q_auth"
					key="#decrypted_TK#"
					command="authonly"
					cardnum="#Form.x_Card_Num#"
					expdate="#Form.x_Exp_Date#"
					amount="#Form.x_Amount#"
					custid="#Form.x_Cust_ID#"
					invoice="#Form.x_Invoice_Num#"
					description="#Form.x_Description#"
					cvv="#Form.x_Card_Code#"
					email="#Form.x_Email#"
					emailcustomer="FALSE"
					custname="#Form.x_First_Name# #Form.x_Last_Name#"
					avsstreet="#Form.x_Address#"
					avszip="#Form.x_Zip#"
					clientip="#CGI.REMOTE_ADDR#"
					testrequest="#application.pgTestMode#"
				>
			<!---
			<cfelseif isDefined('Form.AuthVoid') AND isDefined('Form.TypeOfOrder') AND Form.TypeOfOrder EQ 'VOID'>
				<!--- VOID AUTH_ONLY --->
			--->
			<cfelse>
				<cfmodule template="Includes/USAePay.cfm"
					queryname="q_auth"
					key="#decrypted_TK#"
					command="sale"
					cardnum="#Form.x_Card_Num#"
					expdate="#Form.x_Exp_Date#"
					amount="#Form.x_Amount#"
					custid="#Form.x_Cust_ID#"
					invoice="#Form.x_Invoice_Num#"
					description="#Form.x_Description#"
					cvv="#Form.x_Card_Code#"
					email="#Form.x_Email#"
					emailcustomer="FALSE"
					custname="#Form.x_First_Name# #Form.x_Last_Name#"
					avsstreet="#Form.x_Address#"
					avszip="#Form.x_Zip#"
					clientip="#CGI.REMOTE_ADDR#"
					testrequest="#application.pgTestMode#"
				>
			</cfif>
			
			<cfcatch type="any">
				<cfset AdminMsg = 'There has been an error in credit card processing ...' >
				<cfoutput>
				#cfcatch.message#<br>
				#cfcatch.detail# 
				</cfoutput>
		  </cfcatch>
		</cftry>
		
	<!--- PAYFLOW LINK --->
	<cfelseif application.PaymentSystem EQ 4 >
		<!--- ACTION ALREADY TAKEN - PROCEED TO UPDATE CARTFUSION --->
		
	
	<!--- LinkPoint/YourPay API --->
	<cfelseif application.PaymentSystem EQ 7 >
		<cftry>						
			<cfif isDefined('Form.AuthType') AND Form.AuthType EQ 'AUTH_ONLY'>
				<!--- PREAUTH --->
				<cfscript>
					ordertype = "PREAUTH" ;
					reference_number = "#TRIM(Form.x_Invoice_Num)#" ;
					name = "#TRIM(Form.x_First_Name)# #TRIM(Form.x_Last_Name)#" ;
					address = "#TRIM(Form.x_Address)#" ;
					city = "#TRIM(Form.x_City)#" ;
					state = "#TRIM(Form.x_State)#" ;
					zip = "#TRIM(Form.x_Zip)#" ; // Required for AVS. If not provided, transactions will downgrade.
					phone = "#TRIM(Form.x_Phone)#" ;
					email = "#TRIM(Form.x_Email)#" ;
					comments = "OrderID: #TRIM(Form.x_Invoice_Num)# -- CustomerID: #TRIM(Form.x_Cust_ID)#" ;
					cardnumber = "#TRIM(Form.x_Card_Num)#" ;
					cardexpmonth = "#TRIM(Left(Form.x_Exp_Date,2))#" ;
					cardexpyear = "#TRIM(Right(Form.x_Exp_Date,2))#" ;
					cvmvalue = "#TRIM(Form.x_Card_Code)#" ;
					chargetotal = "#TRIM(Form.x_Amount)#" ;
					if ( Form.x_Address NEQ '' )
						addrnum = "#listgetat(trim(Form.x_Address), 1,' ')#" ; // Required for AVS. If not provided, transactions will downgrade.
				</cfscript>
				<!--- BUILD THE ORDER TO SEND --->
				<cfinclude template = "YourPay/lpcfm.cfm">
				
			<cfelseif isDefined('Form.AuthType') AND Form.AuthType EQ 'VOID'>
				<!--- VOID PREAUTH --->
				<cfscript>
					ordertype = "VOID" ;
					OID = "#Form.x_trans_id#" ;
					reference_number = "#TRIM(Form.x_Invoice_Num)#" ;
					cardnumber = "#TRIM(Form.x_Card_Num)#" ;
					cardexpmonth = "#TRIM(Left(Form.x_Exp_Date,2))#" ;
					cardexpyear = "#TRIM(Right(Form.x_Exp_Date,2))#" ;
					cvmvalue = "#TRIM(Form.x_Card_Code)#" ;
					chargetotal = "#TRIM(Form.x_Amount)#" ;
				</cfscript>
				<!--- BUILD THE ORDER TO SEND --->
				<cfinclude template = "YourPay/lpcfm.cfm">
				
			<cfelseif isDefined('Form.AuthType') AND Form.AuthType EQ 'PRIOR_AUTH_CAPTURE'>
				<!--- POSTAUTH --->
				<cfscript>
					ordertype = "POSTAUTH" ;
					OID = "#Form.x_trans_id#" ;
					reference_number = "#TRIM(Form.x_Invoice_Num)#" ;
					name = "#TRIM(Form.x_First_Name)# #TRIM(Form.x_Last_Name)#" ;
					address = "#TRIM(Form.x_Address)#" ;
					city = "#TRIM(Form.x_City)#" ;
					state = "#TRIM(Form.x_State)#" ;
					zip = "#TRIM(Form.x_Zip)#" ; // Required for AVS. If not provided, transactions will downgrade.
					phone = "#TRIM(Form.x_Phone)#" ;
					email = "#TRIM(Form.x_Email)#" ;
					comments = "OrderID: #TRIM(Form.x_Invoice_Num)# -- CustomerID: #TRIM(Form.x_Cust_ID)#" ;
					cardnumber = "#TRIM(Form.x_Card_Num)#" ;
					cardexpmonth = "#TRIM(Left(Form.x_Exp_Date,2))#" ;
					cardexpyear = "#TRIM(Right(Form.x_Exp_Date,2))#" ;
					cvmvalue = "#TRIM(Form.x_Card_Code)#" ;
					chargetotal = "#TRIM(Form.x_Amount)#" ;
					if ( Form.x_Address NEQ '' )
						addrnum = "#listgetat(trim(Form.x_Address), 1,' ')#" ; // Required for AVS. If not provided, transactions will downgrade.
				</cfscript>
				<!--- BUILD THE ORDER TO SEND --->
				<cfinclude template = "YourPay/lpcfm.cfm">
								
			<cfelse>
				<!--- SALE / AUTH_CAPTURE --->
				<cfscript>
					ordertype = "SALE" ;
					reference_number = "#TRIM(Form.x_Invoice_Num)#" ;
					name = "#TRIM(Form.x_First_Name)# #TRIM(Form.x_Last_Name)#" ;
					address = "#TRIM(Form.x_Address)#" ;
					city = "#TRIM(Form.x_City)#" ;
					state = "#TRIM(Form.x_State)#" ;
					zip = "#TRIM(Form.x_Zip)#" ; // Required for AVS. If not provided, transactions will downgrade.
					phone = "#TRIM(Form.x_Phone)#" ;
					email = "#TRIM(Form.x_Email)#" ;
					comments = "OrderID: #TRIM(Form.x_Invoice_Num)# -- CustomerID: #TRIM(Form.x_Cust_ID)#" ;
					cardnumber = "#TRIM(Form.x_Card_Num)#" ;
					cardexpmonth = "#TRIM(Left(Form.x_Exp_Date,2))#" ;
					cardexpyear = "#TRIM(Right(Form.x_Exp_Date,2))#" ;
					cvmvalue = "#TRIM(Form.x_Card_Code)#" ;
					chargetotal = "#TRIM(Form.x_Amount)#" ;
					if ( Form.x_Address NEQ '' )
						addrnum = "#listgetat(trim(Form.x_Address), 1,' ')#" ; // Required for AVS. If not provided, transactions will downgrade.
				</cfscript>
				<!--- BUILD THE ORDER TO SEND --->
				<cfinclude template = "YourPay/lpcfm.cfm">
								
			</cfif>
			
			<cfcatch type="any">
				<cfset AdminMsg = 'There has been an error in credit card processing ...' >
				<cfoutput>
				#cfcatch.message#<br>
				#cfcatch.detail# 
				</cfoutput>
		  </cfcatch>
		</cftry>
		
		
	</cfif><!--- PaymentSystem --->
</cfif>


<!--- UPDATE CARTFUSION VARIABLES --->
<!--- FROM PAYMENT GATEWAY QUERY OR FORM VARIABLES --->
<cfscript>
	// Authorize.Net OR USA ePay
	if ( application.PaymentSystem EQ 2 OR application.PaymentSystem EQ 3 )
	{
		if (IsDefined("x_Invoice_Num"))
		{
			OrderID = x_Invoice_Num;
			CustomerID = x_Cust_ID;
			Email = x_Email;
			// Authorize.Net
			if ( isDefined('TransactionID') )
				TransactionID = TransactionID ;
			// USA ePay
			else if ( isDefined('q_auth.UMrefNum') )
				TransactionID = q_auth.UMrefNum ;
			else
				TransactionID = 'not processed' ; // Internal note that transaction was not processed by payment gateway
			
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
		}
	}
	// PayFlow Link
	else if ( application.PaymentSystem EQ 4 )
	{
		if (IsDefined("FORM.INVOICE"))
		{
			OrderID = FORM.INVOICE ;
			CustomerID = FORM.CUSTID ;
			Email = FORM.EMAIL ;
			if ( isDefined('FORM.PNREF') )
				TransactionID = FORM.PNREF ;
			else
				TransactionID = 'not processed' ; // Internal note that transaction was not processed by payment gateway
			// SHOULD THIS BE HERE? ---
			if ( FORM.USER1 EQ 'ProcessPayment' )
				Form.ProcessPayment = 1 ;
			else
				Form.ProcessPayment = 0 ;
			// ---
			if ( FORM.USER2 NEQ '' )
				Form.TypeOfOrder = FORM.USER2 ;
			else
				Form.TypeOfOrder = '' ;
			if ( FORM.RESPMSG EQ 'Approved' )
				ResponseCode = 1 ;
			// else
			//  ResponseCode = ? ;
		}
		else
		{
			WriteOutput('ERROR: No FORM data returned from PayFlow Link') ;
		}
	}
	// LinkPoint/YourPay API
	if ( application.PaymentSystem EQ 7 )
	{
		if ( IsDefined('rootResp') AND IsDefined('Form.x_Invoice_Num') )
		{
			OrderID = Form.x_Invoice_Num ;
			CustomerID = Form.x_Cust_ID ;
			Email = Form.x_Email ;
			
			if ( r_ordernum NEQ '' )
				TransactionID = r_ordernum ;
			else
				TransactionID = 'not processed' ; // Internal note that transaction was not processed by payment gateway
			
			if ( r_approved EQ 'APPROVED' )
				ResponseCode = 1 ; // 1 = Approved
			else if ( r_approved NEQ 'APPROVED' ) // OR r_approved EQ 'FRAUD' OR r_approved EQ 'DECLINED'
				ResponseCode = 2 ; // 2 = Declined
			else
				ResponseCode = 0 ; // 0 = Default Approved
		}
	}
</cfscript>



<!--- BEGIN: ORDER PROCESSED (NOT BACK ORDERS) --->
<cfif isDefined('OrderID') 
  AND isDefined('Form.TypeOfOrder') 
  AND Form.TypeOfOrder EQ 'Order' 
  AND ResponseCode LTE 1 
  AND TransactionID NEQ 'not processed' > 
	<cftransaction>
		<!--- UPDATE ORDER BILLING STATUS --->
		<cfquery name="updateOrder" datasource="#application.dsn#">
			UPDATE 	Orders
			SET 	PaymentVerified = 1,
					BillingStatus = 'PA',
					TransactionID = '#TransactionID#'
			WHERE 	OrderID = #OrderID#
		</cfquery>
		<!--- BEGIN: RECALCULATE CREDIT IF APPLICABLE --->
		<!--- GETS CREDIT APPLIED TO ORDER DETAIL AND CUSTOMER'S CREDIT AMOUNT --->
		<cfquery name="getCreditApplied" datasource="#application.dsn#">
			SELECT	Orders.CreditApplied, Customers.Credit
			FROM	Orders, Customers
			WHERE	Orders.OrderID = #OrderID#
			AND		Customers.CustomerID = '#CustomerID#'
		</cfquery>
		<cfoutput query="getCreditApplied">
		<!--- IF CREDIT APPLIED TO ORDER DETAIL IS GREATER THAN 0, SUBTRACT THAT AMOUNT FROM THE CUSTOMER'S CREDIT AMOUNT --->
			<cfif CreditApplied NEQ 0>
				<cfquery name="updateCredit" datasource="#application.dsn#">
					UPDATE 	Customers
					SET 	Credit = #Val(Credit - CreditApplied)#
					WHERE 	CustomerID = '#CustomerID#'
				</cfquery>
			</cfif>
		</cfoutput>
		<!--- END: RECALCULATE CREDIT IF APPLICABLE --->
	</cftransaction>
	
	<!--- WRITE OUTPUT MESSAGE --->
	<div class="cfAdminError" align="center">
		<br><br>
		<cfif isDefined('TransactionID') AND TransactionID EQ 0 >
			<font size='+2'><b>TEST MODE</b></font><br><br>
		</cfif>
		Order <cfoutput>#OrderID#</cfoutput> has been processed.<br>
		<cfif isDefined('ResponseCode') AND ResponseCode EQ 1 >
			Payment information has been sent to your payment gateway for processing.<br><br>
		<cfelse>
			No payment was applied during this transaction.<br><br>
		</cfif>
	</div>
	
<!--- END: ORDER PROCESSED (NOT BACK ORDERS) --->		
	
	
	
<!--- BEGIN: BACK ORDER PROCESSED --->	
<cfelseif isDefined('OrderID') AND isDefined('session.StoredBackOrders') AND NOT StructIsEmpty(session.StoredBackOrders) AND TransactionID NEQ 'not processed' 
	AND isDefined('Form.TypeOfOrder') AND Form.TypeOfOrder EQ 'BackOrder' AND ResponseCode LTE 1>
	<cftransaction>	
		<!--- INSERT DISTINCT BACK ORDER ID AND VARIABLES --->
		<cfquery name="getLastBOID" datasource="#application.dsn#">
			SELECT 	MAX(BOID) AS LastBOID
			FROM	BackOrders
		</cfquery>
		<cfscript>
			if ( getLastBOID.RecordCount EQ 0 OR getLastBOID.LastBOID EQ '' )
				NewBOID = 1 ;
			else
				NewBOID = getLastBOID.LastBOID + 1 ;
		</cfscript>
		<cfquery name="logBackOrder" datasource="#application.dsn#">
			INSERT INTO BackOrders (BOID, BOOrderID, BODateEntered, BOTransID, BOTotal <cfif isDefined('Form.Discount')>, BODiscount</cfif><cfif isDefined('Form.Credit')>, BOCredit</cfif>)
			VALUES	(#NewBOID#, #OrderID#, #CreateODBCDate(Now())#, #TransactionID#, #x_Amount# <cfif isDefined('Form.Discount')>, #Form.Discount#</cfif><cfif isDefined('Form.Credit')>, #Form.Credit#</cfif>)
		</cfquery>
		<!--- BEGIN: INSERT LINE ITEMS FROM BACK ORDER PROCESSED --->
		<cfloop index="OrderItemsID" list="#session.StoredBackOrders.ItemSelect#">
			<cfquery name="updateOrderItems" datasource="#application.dsn#">
				UPDATE 	OrderItems
				SET		StatusCode = 'BP',
						DateUpdated = #Now()#,
						UpdatedBy = '#GetAuthUser()#',
						DateEntered = #Now()#
				WHERE	OrderItemsID = #OrderItemsID#		
			</cfquery>
			<cfquery name="getItemID" datasource="#application.dsn#">
				SELECT 	ItemID, Qty, ItemPrice 
				FROM	OrderItems
				WHERE	OrderItemsID = #OrderItemsID#
			</cfquery>			
			<cfquery name="logBackOrderItems" datasource="#application.dsn#">
				INSERT INTO BackOrderItems (BOID, BOItemID, BOQty, BOItemPrice)
				VALUES	(#NewBOID#, #getItemID.ItemID#, #getItemID.Qty#, #getItemID.ItemPrice#)
			</cfquery>
		</cfloop>
		<!--- END: INSERT LINE ITEMS FROM BACK ORDER PROCESSED --->
		<!--- BEGIN: RECALCULATE CREDIT IF APPLICABLE --->
		<!--- IF CREDIT APPLIED TO BACK ORDER PROCESSED IS GREATER THAN 0, SUBTRACT THAT AMOUNT FROM THE CUSTOMER'S CREDIT AMOUNT --->
		<cfif isDefined('Form.Credit') AND Form.Credit GT 0>
			<cfquery name="getCredit" datasource="#application.dsn#">
				SELECT	Credit
				FROM	Customers
				WHERE 	CustomerID = '#CustomerID#'
			</cfquery>
			<cfquery name="updateCredit" datasource="#application.dsn#">
				UPDATE 	Customers
				SET 	Credit = #Val(getCredit.Credit - Form.Credit)#
				WHERE 	CustomerID = '#CustomerID#'
			</cfquery>
		</cfif>
		<!--- END: RECALCULATE CREDIT IF APPLICABLE --->
	</cftransaction>
	
	<!--- WRITE OUTPUT MESSAGE --->
	<div class="cfAdminError" align="center">
		<br><br>
		<cfif isDefined('TransactionID') AND TransactionID EQ 0 >
			<font size='+2'><b>TEST MODE</b></font><br><br>
		</cfif>
		Back orders for Order <cfoutput>#OrderID#</cfoutput> has been processed.<br>
		<cfif isDefined('ResponseCode') AND ResponseCode EQ 1 >
			Payment information has been sent to your payment gateway for processing.<br><br>
		<cfelse>
			No payment was applied during this transaction.<br><br>
		</cfif>
	</div>
	
	<cfscript>StructDelete(session, "StoredBackOrders");</cfscript>
<!--- END: BACK ORDER PROCESSED --->	



<!--- AUTHORIZE ONLY --->
<cfelseif isDefined('Form.AuthType') AND Form.AuthType EQ 'AUTH_ONLY' AND ResponseCode LTE 1 AND TransactionID NEQ 'not processed' > 
	<!--- UPDATE ORDER BILLING STATUS --->
	<cfquery name="updateOrder" datasource="#application.dsn#">
		UPDATE 	Orders
		SET 	PaymentVerified = 0,
				BillingStatus = 'AU',
				TransactionID = '#TransactionID#'
		WHERE 	OrderID = #OrderID#
	</cfquery>
	
	<!--- WRITE OUTPUT MESSAGE --->
	<div class="cfAdminError" align="center">
		<br><br>
		<cfif isDefined('TransactionID') AND TransactionID EQ 0 >
			<font size='+2'><b>TEST MODE</b></font><br><br>
		</cfif>
		Order <cfoutput>#OrderID#</cfoutput> has been processed.<br>
		<cfif isDefined('ResponseCode') AND ResponseCode EQ 1 >
			Credit card authorization has been sent to your payment gateway.<br><br>
		<cfelse>
			No payment was authorized during this transaction.<br><br>
		</cfif>
	</div>
	

<!--- VOID TRANSACTION --->
<cfelseif isDefined('Form.AuthType') AND Form.AuthType EQ 'VOID' AND ResponseCode LTE 1 > 
	<!--- UPDATE ORDER BILLING STATUS --->
	<cfquery name="updateOrder" datasource="#application.dsn#">
		UPDATE 	Orders
		SET 	PaymentVerified = 0,
				BillingStatus = 'VO',
				TransactionID = NULL
		WHERE 	OrderID = #OrderID#
	</cfquery>
	
	<!--- WRITE OUTPUT MESSAGE --->
	<div class="cfAdminError" align="center">
		<br><br>
		<cfif isDefined('TransactionID') AND TransactionID EQ 0 >
			<font size='+2'><b>TEST MODE</b></font><br><br>
		</cfif>
		Order <cfoutput>#OrderID#</cfoutput> has been processed.<br>
		<cfif isDefined('ResponseCode') AND ResponseCode EQ 1 >
			Transaction Void request has been sent to your payment gateway.<br><br>
		<cfelse>
			No transaction has been voided.<br><br>
		</cfif>
	</div>
</cfif>
<!--- END: IF ResponseCode EQ 1 --->



<!--- AUTHORIZE.NET --->
<cfif application.PaymentSystem EQ 2 >
	<cfinclude template="Includes/OrderAIMResponse.cfm">
<!--- USAePay --->
<cfelseif application.PaymentSystem EQ 3 >
	<cfinclude template="Includes/OrderUSAePayResponse.cfm">
<!--- PAYFLOW LINK --->
<cfelseif application.PaymentSystem EQ 4 >
	<cfinclude template="Includes/OrderPFLResponse.cfm">
<!--- LINKPOINT/YOURPAY API --->
<cfelseif application.PaymentSystem EQ 7 >
	<cfinclude template="Includes/OrderYPAPIResponse.cfm">
</cfif>

<cfinclude template="LayoutAdminFooter.cfm">