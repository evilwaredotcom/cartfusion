<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<!--- PROCESS LOGOUT --->
<cfif isDefined('Logout')>
	<cflock scope="session" timeout="30" type="exclusive">
		<cfloop index="loopcount" from="1" to="#ArrayLen(session.CustomerArray)#">
			<cfset session.CustomerArray[loopcount] = ''>
		</cfloop>
	</cflock>
	<cfoutput><cflocation url="#CGI.HTTP_REFERER#" addtoken="no"></cfoutput>
	<cfabort>
</cfif>

<!--- SET GoToPage IF NOT SET --->
<cfif not isDefined('GoToPage')>
	<cfset GoToPage = 'index.cfm'>
</cfif>

<!--- USER HAS ATTEMPTED TO LOGIN AS A REGISTERED CUSTOMER --->
<cfif structKeyExists(form, 'CustUser') AND form.CustUser neq '' AND not structKeyExists(form, 'CreateNewUser')>
	
	<cfscript>
		getCustomerInfo = application.Queries.getCustomerInfo(CustUser=Form.CustUser);
		getUser = application.Queries.getUser(UUserName=form.CustUser);
	</cfscript>
	
	
	<!--- IF NO ID WAS FOUND IN EITHER CUSTOMERS OR USERS, RETURN ERROR --->
	<cfif not getCustomerInfo.RecordCount and not getUser.RecordCount>
		<cfset errorLogin = 7>
		<cfoutput><cflocation url="CA-Login.cfm?goToPage=#goToPage#&errorLogin=#errorLogin#"></cfoutput>
		<!--- OTHERWISE, CHECK TO SEE IF PASSWORD SUPPLIED MATCHES THE ONE IN EITHER TABLE --->
		
	<!--- IF USER IS FOUND IN Customers TABLE, CHECK DECRYPTED PASSWORD AND MOVE ON WITH SETTING CUSTOMER INFO IN Session.CustomerArray --->
	<cfelseif getCustomerInfo.RecordCount AND not getUser.RecordCount>
		<cfset Decrypted_Password = DECRYPT(getCustomerInfo.Password, application.CryptKey, "CFMX_COMPAT", "Hex") >
		
		<!--- PASSWORD MATCH UNSUCCESSFUL, THROW ERROR --->
		<cfif Decrypted_Password NEQ Form.CustPassword >
			<cfset errorLogin = 1>
			<cfoutput><cflocation url="CA-Login.cfm?goToPage=#goToPage#&errorLogin=#errorLogin#"></cfoutput>	
		</cfif>	
		<!--- PASSWORD MATCH SUCCESSFUL, BEGIN SETTING CUSTOMER INFO INTO SESSION.CUSTOMERARRAY --->
		<cfoutput query="getCustomerInfo">
			<cflock scope="session" timeout="30" type="exclusive">
				<cfscript>
					session.CustomerArray[1]  = FirstName ;
					session.CustomerArray[2]  = LastName ;
					session.CustomerArray[3]  = Address1 ;
					session.CustomerArray[4]  = Address2 ;
					session.CustomerArray[5]  = City ;
					session.CustomerArray[6]  = State ;
					session.CustomerArray[7]  = Zip ;
					session.CustomerArray[8]  = Country ;
					session.CustomerArray[9]  = Phone ;
					session.CustomerArray[10] = Fax ;
					session.CustomerArray[11] = Email ;
					session.CustomerArray[12] = CompanyName ;
					// CARTFUSION 4.6
					if ( application.SaveCreditCard EQ 1 and application.ShowCreditCard EQ 1 )
					{
						session.CustomerArray[13] = CardName ;
						session.CustomerArray[14] = CardNum ;
						session.CustomerArray[15] = ExpDate ;
					}
					// session.CustomerArray[16] = nothing ;
					session.CustomerArray[17] = CustomerID ;					
					session.CustomerArray[18] = ShipFirstName ;
					session.CustomerArray[19] = ShipLastName ;
					session.CustomerArray[34] = ShipCompanyName ;
					session.CustomerArray[20] = ShipAddress1 ;
					session.CustomerArray[21] = ShipAddress2 ;
					session.CustomerArray[22] = ShipCity ;
					session.CustomerArray[23] = ShipState ;
					session.CustomerArray[24] = ShipZip ;
					session.CustomerArray[25] = ShipCountry ;
					session.CustomerArray[35] = ShipPhone ;
					session.CustomerArray[31] = ShipEmail ;				
					session.CustomerArray[26] = UserName ;
					session.CustomerArray[27] = Password ; // encrypted
					session.CustomerArray[28] = PriceToUse ;
					session.CustomerArray[29] = sessionID ;
					session.CustomerArray[30] = EmailOK ;
					session.CustomerArray[32] = IPAddress ;
					session.CustomerArray[33] = DateCreated ;
					if ( session.CustomerArray[36] EQ '' )
						session.CustomerArray[36] = AffiliateID ;
				</cfscript>
				
				<!--- REPLACE THE ANNOYING APOSTROPHE THAT CAUSES DB ERROR THROWS --->
				<cfloop index="loopcount" from=1 to="#ArrayLen(session.CustomerArray)#">
					<cfif session.CustomerArray[loopcount] CONTAINS "'">
						<cfset session.CustomerArray[loopcount] = Replace(session.CustomerArray[loopcount], "'", "", "ALL")>
					</cfif>
				</cfloop>
			</cflock>
		</cfoutput>
		<cfset errorLogin = 0>		
		
	<!--- IF USER NOT FOUND IN Customers TABLE, BUT FOUND IN Users TABLE, CHECK PASSWORD AND SET Session.CustomerArray[28] TO PriceToUse --->
	<cfelseif getUser.RecordCount>
		<!--- PASSWORD MATCH UNSUCCESSFUL, THROW ERROR --->
		<cfif getUser.UPassword neq form.CustPassword>
			<cfset errorLogin = 1>
			<cfoutput><cflocation url="CA-Login.cfm?goToPage=#goToPage#&errorLogin=#errorLogin#"></cfoutput>		
		<!--- PASSWORD MATCH SUCCESSFUL, SET SESSION.CUSTOMERARRAY[28] to PriceToUse --->	
		<cfelse>			
			<cflock scope="session" timeout="10" type="exclusive">
				<cfset session.CustomerArray[28] = getUser.UID>
			</cflock>
		</cfif>
		<cfset errorLogin = 0>
	</cfif>
	
	<!--- SSL PATH --->
	<cfif application.EnableSSL EQ 1 AND application.SSLURL NEQ '' AND ( findnocase("CA-CustomerArea.cfm",GoToPage) GT 0 OR findnocase("CO-Billing.cfm",GoToPage) GT 0 ) >
		<cfoutput><cflocation url="#application.SSLURL#/#goToPage#" addtoken="no"></cfoutput>
	<cfelse>
		<cfoutput><cflocation url="#goToPage#" addtoken="no"></cfoutput>
	</cfif>


<!--- USER ATTEMPTING TO REGISTER AS NEW CUSTOMER --->
<cfelseif isDefined('Form.CreateNewUser') AND Form.CreateNewUser EQ 1 AND IsDefined('Form.UserName') AND IsDefined('Form.Password')>
	
	<!--- Make sure customer has specified a valid UserName & password --->
	<cfif Form.Password EQ '' >
		<cfset errorLogin = 3 >
		<cfoutput><cflocation url="CA-Login.cfm?goToPage=#goToPage#&errorLogin=#errorLogin#"></cfoutput>
	</cfif>
	<cfif Form.UserName EQ '' >
		<cfset errorLogin = 4 >
		<cfoutput><cflocation url="CA-Login.cfm?goToPage=#goToPage#&errorLogin=#errorLogin#"></cfoutput>
	</cfif>
	<cfif Form.Password NEQ Form.Password1 >
		<cfset errorLogin = 2 >
		<cfoutput><cflocation url="CA-Login.cfm?goToPage=#goToPage#&errorLogin=#errorLogin#"></cfoutput>
	</cfif>
	
	<cfif isDefined('Form.Notify') AND Form.Notify EQ 'on' >
		<cfset Form.Notify = 1 >
	<cfelse>
		<cfset Form.Notify = 0 >
	</cfif>
	
	<!--- Enforce uniqueness of UserName --->
	<cfquery name="GetUserNames" datasource="#application.dsn#">
		SELECT 	C.UserName AS CUserName, C.Email, U.UUserName AS UUserName
		FROM 	Customers C, Users U
		WHERE 	
		(
			C.UserName = '#Form.UserName#' 
			AND 	C.UserName != ''
			AND 	C.CustomerID != '#session.CustomerArray[17]#'
		)
		OR
		(
			U.UUserName = '#Form.UserName#'
			AND		U.UUserName != ''
		)
	</cfquery>
	
	<cfquery name="GetEmail" datasource="#application.dsn#">
		SELECT 	Email 
		FROM 	Customers
		WHERE	Email = '#form.Email#'
	</cfquery>
	
	<cfif GetEmail.RecordCount NEQ 0>
		<!--- They've already created a username with that email address --->
		<cfset errorLogin = "6">
		<cfoutput><cflocation url="CA-Login.cfm?goToPage=#goToPage#&errorLogin=#errorLogin#"></cfoutput>
	
	<cfelseif GetUserNames.RecordCount>
		<cfif GetUserNames.CUserName eq form.UserName OR getUserNames.UUserName EQ form.UserName>
			<!--- UserName already in use, tell them to try another one --->
			<cfset errorLogin = "5">
			<cfoutput><cflocation url="CA-Login.cfm?goToPage=#goToPage#&errorLogin=#errorLogin#"></cfoutput>
		</cfif>
	
	<cfelse>				
		<!--- CREATE CUSTOMERID --->
		<cfscript>
			CustomerID = FormatBaseN(Now(),10) & RandRange(100,999) & Second(Now()) + 10 ;			
			Encrypted_Password = TRIM(ENCRYPT(Form.Password, application.CryptKey, "CFMX_COMPAT", "Hex")) ;
		</cfscript>
				
		<cfquery name="newUserRegistration" datasource="#application.dsn#">
			INSERT INTO Customers
				( CustomerID, IPAddress, FirstName, LastName, Email, UserName, EmailOK, Password, PriceToUse )
			VALUES 
				( '#CustomerID#', '#CGI.REMOTE_ADDR#', '#Form.FirstName#', '#Form.LastName#', '#Form.Email#', '#Form.UserName#', #Form.Notify#, 
					<cfif application.DBIsMySQL>'#Replace(Encrypted_Password, "\", "\\", "ALL")#'<cfelse>'#Encrypted_Password#'</cfif>, 
					<cfif session.CustomerArray[28] EQ '' > 1 <cfelse> #session.CustomerArray[28]# </cfif>
				)
		</cfquery>
		
		<cflock scope="session" type="exclusive" timeout="30">
			<cfscript>
				session.CustomerArray[1]  = Form.FirstName ;
				session.CustomerArray[2]  = Form.LastName ;
				session.CustomerArray[8]  = application.BaseCountry ;
				session.CustomerArray[11] = Email ;
				session.CustomerArray[17] = CustomerID ;
				session.CustomerArray[26] = Form.UserName ;
				session.CustomerArray[27] = Encrypted_Password ;
				session.CustomerArray[30] = Form.Notify ;
				session.CustomerArray[32] = CGI.REMOTE_ADDR ;
			</cfscript>
		</cflock>
		
		<!--- SSL PATH --->
		<cfif application.EnableSSL EQ 1 AND application.SSLURL NEQ '' AND ( findnocase("CA-CustomerArea.cfm",GoToPage) GT 0 OR findnocase("CO-Billing.cfm",GoToPage) GT 0 ) >
			<cfoutput><cflocation url="#application.SSLURL#/#goToPage#" addtoken="no"></cfoutput>
		<cfelse>
			<cfoutput><cflocation url="#goToPage#" addtoken="no"></cfoutput>
		</cfif>
	</cfif>
	
	<cfif isDefined("errorLogin")>
		<cfoutput><cflocation url="CA-Login.cfm?goToPage=#goToPage#&errorLogin=#errorLogin#"></cfoutput>
	</cfif>

<cfelse>
	<!--- SSL PATH --->
	<cfif application.EnableSSL EQ 1 AND application.SSLURL NEQ '' AND ( findnocase("CA-CustomerArea.cfm",GoToPage) GT 0 OR findnocase("CO-Billing.cfm",GoToPage) GT 0 ) >
		<cfoutput><cflocation url="#application.SSLURL#/#goToPage#" addtoken="no"></cfoutput>
	<cfelse>
		<cfoutput><cflocation url="#goToPage#" addtoken="no"></cfoutput>
	</cfif>
</cfif>