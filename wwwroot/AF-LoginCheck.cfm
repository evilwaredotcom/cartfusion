<!--- PROCESS LOGOUT --->
<cfif isDefined('Logout')>
	<cflock scope="session" timeout="30" type="exclusive">
		<cfloop index="loopcount" from="1" to="#ArrayLen(session.AffiliateArray)#">
			<cfset session.AffiliateArray[loopcount] = ''>
		</cfloop>
	</cflock>
	<cfoutput><cflocation url="#CGI.HTTP_REFERER#" addtoken="no"></cfoutput>
	<cfabort>
</cfif>


<!--- USER HAS ATTEMPTED TO LOGIN AS A REGISTERED CUSTOMER --->
<cfif structKeyExists(Form, 'AFID') AND Form.AFID NEQ ''>
	
	<!--- GET PASSWORD AND CUSTOMERID FOR ID CHECK --->
	<cftry>
		<cfscript>
			getAffiliate = application.Queries.getAffiliate(AFID=Form.AFID);
		</cfscript>
		
		<cfcatch>
			<cfset errorLogin = 5>
			<cfoutput><cflocation url="AF-Login.cfm?errorLogin=#errorLogin#"></cfoutput>
		</cfcatch>
	</cftry>
	
	<!--- IF NO ID WAS FOUND, RETURN ERROR --->
	<cfif getAffiliate.RecordCount EQ 0>
		<cfset errorLogin = 5>
		<cfoutput><cflocation url="AF-Login.cfm?errorLogin=#errorLogin#"></cfoutput>
		
	<!--- IF AFFILIATE IS FOUND, CHECK DECRYPTED PASSWORD AND MOVE ON WITH SETTING AFFILIATE INFO IN Session.AffiliateArray --->
	<cfelseif getAffiliate.RecordCount>
		
		<!--- NOT YET AUTHENTICATED, THROW ERROR --->
		<cfif getAffiliate.Authenticated NEQ 1 >
			<cfset errorLogin = 6 >
			<cfoutput><cflocation url="AF-Login.cfm?errorLogin=#errorLogin#"></cfoutput>	
		</cfif>	
		
		<cfset Decrypted_Password = DECRYPT(getAffiliate.Password, application.siteConfig.data.CryptKey, "CFMX_COMPAT", "Hex") >
		
		<!--- PASSWORD MATCH UNSUCCESSFUL, THROW ERROR --->
		<cfif Decrypted_Password NEQ Form.AffiliatePassword>
			<cfset errorLogin = 1>
			<cfoutput><cflocation url="AF-Login.cfm?errorLogin=#errorLogin#"></cfoutput>	
		</cfif>	
		
		<!--- PASSWORD MATCH SUCCESSFUL, BEGIN SETTING CUSTOMER INFO INTO SESSION.AffiliateArray --->
		<!--- BEGIN: Instanstiate CustomerArray AND ELEMENTS USING CFPARAM --->
		<cflock timeout="10" type="exclusive" scope="session">	
			<cfset session.AffiliateArray = ArrayNew(1)>
			<cfparam name="session.AffiliateArray" type="array">
			<cfloop index="loopcount" from="1" to="18">
				<cfparam name="session.AffiliateArray[loopcount]" default="">
			</cfloop>
			<cfset session.CustomerArray[38] = getAffiliate.AFID >
		</cflock>
		
		<cfoutput query="getAffiliate">
			<cflock scope="session" timeout="30" type="exclusive">
				<cfscript>
					session.AffiliateArray[1]  = AFID;
					session.AffiliateArray[2]  = FirstName;
					session.AffiliateArray[3]  = LastName;
					session.AffiliateArray[4]  = Address1;
					session.AffiliateArray[5]  = Address2;
					session.AffiliateArray[6]  = City;
					session.AffiliateArray[7]  = State;
					session.AffiliateArray[8]  = Zip;
					session.AffiliateArray[9]  = Country;
					session.AffiliateArray[10] = Phone;
					session.AffiliateArray[11] = Fax;
					session.AffiliateArray[12] = Email;						
					session.AffiliateArray[13] = CompanyName;									
					session.AffiliateArray[14] = Password;
					session.AffiliateArray[15] = sessionID;
					session.AffiliateArray[16] = EmailOK;
					session.AffiliateArray[17] = IPAddress;
					session.AffiliateArray[18] = DateCreated;
				</cfscript>
				
				<!--- REPLACE THE ANNOYING APOSTROPHE THAT CAUSES DB ERROR THROWS --->
				<cfloop index="loopcount" from=1 to="#ArrayLen(session.AffiliateArray)#">
					<cfif session.AffiliateArray[loopcount] CONTAINS "'">
						<cfset session.AffiliateArray[loopcount] = #Replace(session.AffiliateArray[loopcount], "'", "", "ALL")#>
					</cfif>
				</cfloop>
			</cflock>
		</cfoutput>
		<cfset errorLogin = 0>
	</cfif>
	
	<cfoutput><cflocation url="AF-Main.cfm" addtoken="no"></cfoutput>

<cfelse>
	<cfoutput><cflocation url="AF-Login.cfm" addtoken="no"></cfoutput>
</cfif>