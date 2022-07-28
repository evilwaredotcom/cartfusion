<!--- 
	init
	AddCustomer
	EditCustomer
	GetCustomer	
 --->

<cfcomponent displayname="Customers Module">
	
	<cfscript>
		variables.dsn = "";
	</cfscript>

	<cffunction name="init" returntype="Customers" output="false">
		<cfargument name="dsn" required="true">
	
		<cfscript>
			variables.dsn = arguments.dsn;
		</cfscript>
		
		<cfreturn this />
	</cffunction>


	<cffunction name="EditCustomer" output="false">
	
		<cfscript>
			var data = ""; 
			var stReturn = StructNew();
			stReturn.bSuccess = True;
			stReturn.message = "";
			stReturn.data = "";
			stReturn.stError = structNew();
		</cfscript>
		
		<cfreturn stReturn>
	</cffunction>
	
	
	<cffunction name="AddCustomer" output="false">
		<cfargument name="Customers_FirstName" required="yes">
		<cfargument name="Customers_LastName" required="yes">
		<cfargument name="Customers_Email" required="yes">
		<cfargument name="Customers_Username" required="yes">
		<cfargument name="Customers_Password" required="yes">
		<cfargument name="Customers_ConfirmPassword" required="yes">
		<cfargument name="Customers_IPAddress" required="yes">
		<cfargument name="Customers_SchoolID" required="yes">
		
		<cfscript>
			var data = "";
			var encryptedPassword = "";
			var stReturn = StructNew();
			stReturn.bSuccess = True;
			stReturn.message = "";
			stReturn.data = "";
			stReturn.stError = structNew();
		</cfscript>
		
		<cftry>
		
			<!--- Make sure customer has specified a valid username & password --->
			<cfif arguments.Customers_Password EQ '' >
				<cfscript>
					stReturn.bSuccess = False ;
					stReturn.Message = "Your password cannot be blank" ;
				</cfscript>
			<cfelseif arguments.Customers_UserName EQ '' >
				<cfscript>
					stReturn.bSuccess = False ;
					stReturn.Message = "Your username cannot be blank" ;
				</cfscript>
			<cfelseif arguments.Customers_Password NEQ arguments.Customers_ConfirmPassword >
				<cfscript>
					stReturn.bSuccess = False ;
					stReturn.Message = "Your password does not match your confirmation password" ;
				</cfscript>
			<cfelse>
				<!--- Enforce uniqueness of username --->
				<cfquery name="GetUserNames" datasource="#variables.dsn#">
					SELECT 	Customers_UserName, Customers_Email
					FROM 	Customers
					WHERE 	Customers_UserName = '#arguments.Customers_UserName#' 
					AND 	Customers_UserName != ''
					AND		Customers_UserName IS NOT NULL
				</cfquery>
				<!--- Enforce uniqueness of email address --->
				<cfquery name="GetEmail" datasource="#variables.dsn#">
					SELECT 	Customers_Email 
					FROM 	Customers
					WHERE	Customers_Email = '#arguments.Customers_Email#'
					AND 	Customers_Email != ''
					AND		Customers_Email IS NOT NULL
				</cfquery>			
				<cfif GetUserNames.RecordCount NEQ 0 >
					<cfscript>
						stReturn.bSuccess = False ;
						stReturn.Message = "I'm sorry, but that username is already taken. Please try another one." ;
					</cfscript>			
				<cfelseif GetEmail.RecordCount NEQ 0 >
					<cfscript>
						stReturn.bSuccess = False ;
						stReturn.Message = "Your email address has already been setup in a customer profile.  Please use the username/password retreival feature to sign in." ;
					</cfscript>
				<cfelse>		
					<!--- CREATE CUSTOMERID --->
					<cfscript>
						Customers_CustomerID = FormatBaseN(Now(),10) & RandRange(100,999) & Second(Now()) + 10 ;
						Customers_CustomerOID = CreateUUID() ;			
						encryptedPassword = ENCRYPT(arguments.Customers_Password, '#application.lockname#') ;
					</cfscript>
							
					<cfquery name="data" datasource="#variables.dsn#">
						INSERT INTO Customers
							( Customers_CustomerID,
							  Customers_CustomerOID,
							  Customers_IPAddress,
							  Customers_FirstName,
							  Customers_LastName,
							  Customers_Email,
							  Customers_EmailOK,
							  Customers_UserName,					  
							  Customers_Password,
							  Customers_Rating,
							  Customers_CashAccount,
							  Customers_Bucks,
							  Customers_SchoolID,
							  Customers_DateCreated )
						VALUES 
							( '#Customers_CustomerID#',
							  '#Customers_CustomerOID#',
							  '#arguments.Customers_IPAddress#',
							  '#arguments.Customers_FirstName#',
							  '#arguments.Customers_LastName#',
							  '#arguments.Customers_Email#',
							  1,
							  '#arguments.Customers_Username#',
							  '#encryptedPassword#',
							  4,
							  0,
							  0,
							  #arguments.Customers_SchoolID#,
							  '#DateFormat(NOW(),"mm/dd/yyyy")#'
							)
					</cfquery>
					
					<cfscript>
						// fill session-wide customer variables
						session[application.SessionVar].Customers_CustomerID = "#Customers_CustomerID#" ;
						session[application.SessionVar].Customers_CustomerOID = "#Customers_CustomerOID#" ;
						session[application.SessionVar].Customers_UserName = "#arguments.Customers_UserName#" ;
						session[application.SessionVar].Customers_Password = "#encryptedPassword#" ;
						session[application.SessionVar].Customers_FirstName = "#arguments.Customers_FirstName#" ;
						session[application.SessionVar].Customers_LastName = "#arguments.Customers_LastName#" ;
						session[application.SessionVar].Customers_Email = "#arguments.Customers_Email#" ;
						session[application.SessionVar].Customers_EmailOK = "1" ;
						session[application.SessionVar].Customers_DateCreated = "#DateFormat(NOW(),'mm/dd/yyyy')#" ;
						session[application.SessionVar].Customers_Rating = "4.0" ;
						session[application.SessionVar].Customers_CashAccount = "0.00" ;
						session[application.SessionVar].TotalFundsRequested = "0.00" ;
						session[application.SessionVar].Customers_Bucks = "0.00" ;
						session[application.SessionVar].Customers_DefaultPaymentTo = "1" ;
						session[application.SessionVar].Customers_DefaultPaymentFrom = "1" ;
						session[application.SessionVar].Customers_SchoolID = "#arguments.Customers_SchoolID#" ;
						session[application.SessionVar].Customers_Address1 = "" ;
						session[application.SessionVar].Customers_Address2 = "" ;
						session[application.SessionVar].Customers_City = "" ;
						session[application.SessionVar].Customers_State = "" ;
						session[application.SessionVar].Customers_Zip = "" ;
						session[application.SessionVar].Customers_Country = "" ;
						session[application.SessionVar].Customers_CompanyName = "" ;
						session[application.SessionVar].Customers_Phone = "" ;
						session[application.SessionVar].Customers_SMSPhone = "" ;
						session[application.SessionVar].Customers_SMSPhoneInactive = "0" ;
						session[application.SessionVar].Customers_Fax = "" ;
						session[application.SessionVar].Customers_CardName = "" ;
						session[application.SessionVar].Customers_CardNum = "" ;
						session[application.SessionVar].Customers_ExpDate = "" ;
						session[application.SessionVar].Customers_ACHAccountNumber = "" ;
						session[application.SessionVar].Customers_ACHRoutingNumber = "" ;
						session[application.SessionVar].Customers_ACHAccountActive = "" ;
						session[application.SessionVar].Customers_ACHBankName = "" ;
						session[application.SessionVar].Customers_PayPalAccount = "" ;
						session[application.SessionVar].Customers_Initials = "" ;
						session[application.SessionVar].Customers_Comments = "" ;
						session[application.SessionVar].ISLoggedIn = True ;

						stReturn.bSuccess = True ;
						stReturn.message = "Successful" ;
					</cfscript>
				</cfif>
			</cfif>
			
			<cfcatch>
				<cfscript>
					stReturn.bSuccess = False ;
					stReturn.message = cfcatch.message & "<br><br>" & cfcatch.detail ;
					stReturn.stError = cfcatch ;
				</cfscript>
			</cfcatch>
			
		</cftry>
		
		<cfreturn stReturn>
	</cffunction>



	<cffunction name="GetCustomer" output="false">
		<cfargument name="Customers_Username" required="no">
		<cfargument name="Customers_Password" required="no">
		<cfargument name="Customers_FirstName" required="no">
		<cfargument name="Customers_LastName" required="no">
		<cfargument name="Customers_Email" required="no">
		
		<cfscript>
			var data = "";
			var getPendingRequests = "";
			var decryptedPassword = "";
			var stReturn = StructNew();
			stReturn.bSuccess = True;
			stReturn.message = "";
			stReturn.data = "";
			stReturn.stError = structNew();
		</cfscript>
		
		<!--- IS A LOGIN --->
		<cfif StructKeyExists(arguments,'Customers_Password') >
			<cftry>
				<cfquery name="data" datasource="#variables.dsn#">
					SELECT 		*
					FROM		Customers
					WHERE 		Customers_Username = '#arguments.Customers_Username#'
					AND	   	   (Customers_Inactive = 0 OR Customers_Inactive IS NULL)
				</cfquery>
	
				<cfquery name="getPendingRequests" datasource="#variables.dsn#">
					SELECT		SUM(Funds_RequestedAmount) AS TotalFundsRequested
					FROM		Funds
					WHERE		Funds_CustomerID = '#TRIM(data.Customers_CustomerID)#'
					AND			(Funds_Complete = 0 OR Funds_Complete IS NULL)
					AND			Funds_InOut = 0
				</cfquery>
				
				<cfscript>
					if ( NOT data.RecordCount ) // AND NOT getUser.RecordCount
					{
						stReturn.bSuccess = False ;
						stReturn.Message = "I am sorry but the username you entered was not found" ;
					}
					else
					{
						decryptedPassword = decrypt(data.Customers_Password, '#application.lockname#') ;
						if ( decryptedPassword NEQ arguments.Customers_Password )
						{
							stReturn.bSuccess = False ;
							stReturn.Message = "I am sorry but the password you entered is incorrect" ;
						}
						else
						{
							// fill session-wide customer variables
							session[application.SessionVar].Customers_CustomerID = "#TRIM(data.Customers_CustomerID)#" ;
							session[application.SessionVar].Customers_CustomerOID = "#TRIM(data.Customers_CustomerOID)#" ;
							session[application.SessionVar].Customers_UserName = "#TRIM(data.Customers_UserName)#" ;
							session[application.SessionVar].Customers_Password = "#TRIM(data.Customers_Password)#" ;
							session[application.SessionVar].Customers_FirstName = "#TRIM(data.Customers_FirstName)#" ;
							session[application.SessionVar].Customers_LastName = "#TRIM(data.Customers_LastName)#" ;
							session[application.SessionVar].Customers_Address1 = "#TRIM(data.Customers_Address1)#" ;
							session[application.SessionVar].Customers_Address2 = "#TRIM(data.Customers_Address2)#" ;
							session[application.SessionVar].Customers_City = "#TRIM(data.Customers_City)#" ;
							session[application.SessionVar].Customers_State = "#TRIM(data.Customers_State)#" ;
							session[application.SessionVar].Customers_Zip = "#TRIM(data.Customers_Zip)#" ;
							session[application.SessionVar].Customers_Country = "#TRIM(data.Customers_Country)#" ;
							session[application.SessionVar].Customers_CompanyName = "#TRIM(data.Customers_CompanyName)#" ;
							session[application.SessionVar].Customers_Phone = "#TRIM(data.Customers_Phone)#" ;
							session[application.SessionVar].Customers_SMSPhone = "#TRIM(data.Customers_SMSPhone)#" ;
							session[application.SessionVar].Customers_SMSPhoneInactive = "#data.Customers_SMSPhoneInactive#" ;
							session[application.SessionVar].Customers_Fax = "#TRIM(data.Customers_Fax)#" ;
							session[application.SessionVar].Customers_Email = "#TRIM(data.Customers_Email)#" ;
							session[application.SessionVar].Customers_CardName = "#TRIM(data.Customers_CardName)#" ;
							session[application.SessionVar].Customers_CardNum = "#TRIM(data.Customers_CardNum)#" ;
							session[application.SessionVar].Customers_ExpDate = "#TRIM(data.Customers_ExpDate)#" ;
							session[application.SessionVar].Customers_ACHAccountNumber = "#TRIM(data.Customers_ACHAccountNumber)#" ;
							session[application.SessionVar].Customers_ACHRoutingNumber = "#TRIM(data.Customers_ACHRoutingNumber)#" ;
							session[application.SessionVar].Customers_ACHAccountActive = "#data.Customers_ACHAccountActive#" ;
							session[application.SessionVar].Customers_ACHBankName = "#TRIM(data.Customers_ACHBankName)#" ;
							session[application.SessionVar].Customers_EmailOK = "#data.Customers_EmailOK#" ;
							session[application.SessionVar].Customers_DateCreated = "#DateFormat(data.Customers_DateCreated,'mm/dd/yyyy')#" ;
							session[application.SessionVar].Customers_Rating = "#data.Customers_Rating#" ;
							session[application.SessionVar].Customers_CashAccount = "#data.Customers_CashAccount#" ;
							session[application.SessionVar].TotalFundsRequested = "#NumberFormat(getPendingRequests.TotalFundsRequested,9.99)#" ;
							session[application.SessionVar].Customers_Bucks = "#data.Customers_Bucks#" ;
							session[application.SessionVar].Customers_PayPalAccount = "#TRIM(data.Customers_PayPalAccount)#" ;
							session[application.SessionVar].Customers_DefaultPaymentTo = "#data.Customers_DefaultPaymentTo#" ;
							session[application.SessionVar].Customers_DefaultPaymentFrom = "#data.Customers_DefaultPaymentFrom#" ;
							session[application.SessionVar].Customers_SchoolID = "#data.Customers_SchoolID#" ;
							session[application.SessionVar].Customers_Initials = "#data.Customers_Initials#" ;
							session[application.SessionVar].Customers_Comments = "#TRIM(data.Customers_Comments)#" ;
							session[application.SessionVar].ISLoggedIn = True ;
							
							stReturn.bSuccess = True ;
							stReturn.message = "Successful" ;
						}
					}
				</cfscript>
				
				<cfcatch>
					<cfscript>
						stReturn.bSuccess = False ;
						stReturn.message = cfcatch.message & "<br><br>" & cfcatch.detail ;
						stReturn.stError = cfcatch ;
					</cfscript>
				</cfcatch>
				
			</cftry>
		
		<!--- IS A PASSWORD ONLY REQUEST --->
		<cfelseif StructKeyExists(arguments,'Customers_Username') AND StructKeyExists(arguments,'Customers_Email') >
			<cftry>
				<cfquery name="data" datasource="#variables.dsn#">
					SELECT 		Customers_Username, Customers_Password, Customers_FirstName, Customers_LastName, Customers_Email
					FROM		Customers
					WHERE 		Customers_Username = '#arguments.Customers_Username#'
					AND			Customers_Email = '#arguments.Customers_Email#'
					AND	   	   (Customers_Inactive = 0 OR Customers_Inactive IS NULL)
				</cfquery>
				
				<cfscript>
					if ( NOT data.RecordCount )
					{
						stReturn.bSuccess = False ;
						stReturn.Message = "I am sorry but the username and email address you entered did not find your password" ;
					}
					else
					{
						stReturn.bSuccess = True ;
						stReturn.data = data ;
					}
				</cfscript>
				
				<cfcatch>
					<cfscript>
						stReturn.bSuccess = False ;
						stReturn.message = cfcatch.message & "<br><br>" & cfcatch.detail ;
						stReturn.stError = cfcatch ;
					</cfscript>
				</cfcatch>
			</cftry>
		<!--- IS A USERNAME & PASSWORD REQUEST --->
		<cfelseif StructKeyExists(arguments,'Customers_FirstName') AND StructKeyExists(arguments,'Customers_LastName') AND StructKeyExists(arguments,'Customers_Email') >
			<cftry>
				<cfquery name="data" datasource="#variables.dsn#">
					SELECT 		Customers_Username, Customers_Password, Customers_FirstName, Customers_LastName, Customers_Email
					FROM		Customers
					WHERE 		Customers_FirstName = '#arguments.Customers_FirstName#'
					AND			Customers_LastName = '#arguments.Customers_LastName#'
					AND			Customers_Email = '#arguments.Customers_Email#'
					AND	   	   (Customers_Inactive = 0 OR Customers_Inactive IS NULL)
				</cfquery>
				
				<cfscript>
					if ( NOT data.RecordCount )
					{
						stReturn.bSuccess = False ;
						stReturn.Message = "I am sorry but the name and email address you entered did not find your username and password" ;
					}
					else
					{
						stReturn.bSuccess = True ;
						stReturn.data = data ;
					}
				</cfscript>
				
				<cfcatch>
					<cfscript>
						stReturn.bSuccess = False ;
						stReturn.message = cfcatch.message & "<br><br>" & cfcatch.detail ;
						stReturn.stError = cfcatch ;
					</cfscript>
				</cfcatch>
			</cftry>
		</cfif>

		<cfreturn stReturn>
	</cffunction>
	
	
	<cffunction name="GetOrders" output="false">
		<cfargument name="Customers_CustomerID" required="yes">
		
		<cfscript>
			var data = "";
			var stReturn = StructNew();
			stReturn.bSuccess = True;
			stReturn.message = "";
			stReturn.data = "";
			stReturn.stError = structNew();
		</cfscript>
		
		<cftry>	
			
			<cfquery name="data" datasource="#variables.dsn#">
				SELECT 		b.Books_ID, b.Books_ISBN, b.Books_Title, b.Books_ListPrice, l.Listings_SellingPrice,
							l.Listings_ID, l.Listings_Status, l.Listings_ProposedShipDate, l.Listings_BuyerPaymentType1, 
							l.Listings_BuyerPaymentAmount1, l.Listings_ActualShipDate, l.Listings_DateUpdated
				FROM 		Books b, Listings l
				WHERE		b.Books_ID = l.Listings_BookID
				AND			l.Listings_BuyerCustomerID = '#arguments.Customers_CustomerID#'
				ORDER BY 	l.Listings_DateUpdated DESC, l.Listings_ID DESC
			</cfquery>
			
			<cfscript>
				if ( NOT data.RecordCount )
				{
					stReturn.bSuccess = False ;
					stReturn.Message = "You have no orders" ;
				}
				else
				{
					stReturn.bSuccess = True ;
					stReturn.data = data ;
				}
			</cfscript>
			
			<cfcatch>
				<cfscript>
					stReturn.bSuccess = False ;
					stReturn.message = cfcatch.message & "<br><br>" & cfcatch.detail ;
					stReturn.stError = cfcatch ;
				</cfscript>
			</cfcatch>
			
		</cftry>

		<cfreturn stReturn>
	</cffunction>
	
	
	<cffunction name="GetListings" output="false">
		<cfargument name="Customers_CustomerID" required="yes">
		
		<cfscript>
			var data = "";
			var stReturn = StructNew();
			stReturn.bSuccess = True;
			stReturn.message = "";
			stReturn.data = "";
			stReturn.stError = structNew();
		</cfscript>
		
		<cftry>	
			
			<cfquery name="data" datasource="#variables.dsn#">
				SELECT 		b.Books_ID, b.Books_ISBN, b.Books_Title, b.Books_ListPrice,
							l.Listings_ID, l.Listings_Status, l.Listings_ProposedShipDate, l.Listings_SellingPrice,
							l.Listings_DateEntered, l.Listings_SaleTo, l.Listings_DispersalMethod, l.Listings_ActualShipDate,
							l.Listings_BuyBackPrice
				FROM 		Books b, Listings l
				WHERE		b.Books_ID = l.Listings_BookID
				AND			l.Listings_CustomerID = '#arguments.Customers_CustomerID#'
				ORDER BY 	l.Listings_ID DESC
			</cfquery>
			
			<cfscript>
				if ( NOT data.RecordCount )
				{
					stReturn.bSuccess = False ;
					stReturn.Message = "You have no listings" ;
				}
				else
				{
					stReturn.bSuccess = True ;
					stReturn.data = data ;
				}
			</cfscript>
			
			<cfcatch>
				<cfscript>
					stReturn.bSuccess = False ;
					stReturn.message = cfcatch.message & "<br><br>" & cfcatch.detail ;
					stReturn.stError = cfcatch ;
				</cfscript>
			</cfcatch>
			
		</cftry>

		<cfreturn stReturn>
	</cffunction>
	
</cfcomponent>