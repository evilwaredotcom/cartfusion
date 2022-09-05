<!--
|| INSTRUCTIONS ||

NOTE: It is highly recommended that you run this script on a TEST database before running it on your live one.
NOTE: Steps 2 and 3 are interchangeable.  Just make sure you do both of them.

1.  In your SQL database, make sure the Date Type for the field "CryptKey" in the table "config" is nvarchar(100).
2.	Run this script (cryptconverter.cfm) under your CartFusion Admin directory.
3.	Replace all instances of the following string in all of your CartFusion CFM pages:
		, '#application.CryptKey#'
	with this string:
		, application.CryptKey, "CFMX_COMPAT", "Hex"
4.	Delete this script file so that no one (accidentally) runs it again.
5.	That's it.  You may want to make a note of the new crypt key that is generated.

-->

<!--- TEST MODE - IF true, DB IS NOT AFFECTED --->
<cfset TestMode = true >
<!--- IF ERROR OCCURS, ROLLBACK DB UPDATES --->
<cfset ErrorOccurred = 0 >
<!--- NEW CRYPT KEY CreateUUID() --->
<cfset myKey = 'CBDE3FA0-3048-87FC-EE80FD70DE5C0861' > 

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>CartFusion Crypt() Converter</title>
</head>

<body>

<h1><cfif TestMode ><font color="red">TEST MODE </font></cfif>CartFusion Crypt() Converter</h1>

<cftransaction action="begin">
	
<cftry>
	
	<cfquery name="getEncryptedOrders" datasource="#application.dsn#">
		SELECT	OrderID, CCNum, CCExpDate
		FROM	Orders
	</cfquery>

	<table width="100%" border="1" bordercolor="#CCCCCC" cellpadding="2" cellspacing="0" style="margin-bottom:10px;">
		<tr><td colspan="5"><h2>Orders</h2></td></tr>
		<tr><td>Order ID</td><td>New Encrypted Value</td><td>New Decrypted Value</td><td>Old Decrypted Value</td><td>Successful</td></tr>
	<cfoutput query="getEncryptedOrders">
		
		<cfif TRIM(CCNum) NEQ '' >
			<cfset oldDecryptedData = Decrypt(CCNum, application.CryptKey)>
			<cfset newEncryptedData = Encrypt(oldDecryptedData, myKey, "CFMX_COMPAT", "Hex")>
			<cfset newDecryptedData = Decrypt(newEncryptedData, myKey, "CFMX_COMPAT", "Hex")>
			<cfif oldDecryptedData EQ newDecryptedData >
				<cfif NOT TestMode >
				<cfquery name="updateEncryptedData" datasource="#application.dsn#">
					UPDATE	Orders
					SET		CCNum = '#newEncryptedData#'
					WHERE	OrderID = #OrderID#
				</cfquery>
				</cfif>
				<tr><td>#OrderID#</td><td>#newEncryptedData#</td><td>#newDecryptedData#</td><td>#oldDecryptedData#</td><td>YES</td></tr>
			<cfelse>
				<cfset ErrorOccurred = 1 >
				<cftransaction action="rollback"/>
				<tr style="color:##FF0000"><td>#OrderID#</td><td>#newEncryptedData#</td><td>#newDecryptedData#</td><td>#oldDecryptedData#</td><td>NO</td></tr>
			</cfif>
		</cfif>
		
		<cfif TRIM(CCExpDate) NEQ '' >
			<cfset oldDecryptedData = Decrypt(CCExpDate, application.CryptKey)>
			<cfset newEncryptedData = Encrypt(oldDecryptedData, myKey, "CFMX_COMPAT", "Hex")>
			<cfset newDecryptedData = Decrypt(newEncryptedData, myKey, "CFMX_COMPAT", "Hex")>
			<cfif oldDecryptedData EQ newDecryptedData >
				<cfif NOT TestMode >
				<cfquery name="updateEncryptedData" datasource="#application.dsn#">
					UPDATE	Orders
					SET		CCExpDate = '#newEncryptedData#'
					WHERE	OrderID = #OrderID#
				</cfquery>
				</cfif>
				<tr><td>#OrderID#</td><td>#newEncryptedData#</td><td>#newDecryptedData#</td><td>#oldDecryptedData#</td><td>YES</td></tr>
			<cfelse>
				<cfset ErrorOccurred = 1 >
				<cftransaction action="rollback"/>
				<tr style="color:##FF0000"><td>#OrderID#</td><td>#newEncryptedData#</td><td>#newDecryptedData#</td><td>#oldDecryptedData#</td><td>NO</td></tr>
			</cfif>
		</cfif>
		
	</cfoutput>
	</table>
	
	<cfquery name="getEncryptedCustomers" datasource="#application.dsn#">
		SELECT	CustomerID, CardNum, ExpDate, Password
		FROM	Customers
	</cfquery>

	<table width="100%" border="1" bordercolor="#CCCCCC" cellpadding="2" cellspacing="0" style="margin-bottom:10px;">
		<tr><td colspan="5"><h2>Customers</h2></td></tr>
		<tr><td>Customer ID</td><td>New Encrypted Value</td><td>New Decrypted Value</td><td>Old Decrypted Value</td><td>Successful</td></tr>
	<cfoutput query="getEncryptedCustomers">
			
		<cfif TRIM(CardNum) NEQ '' >
			<cfset oldDecryptedData = Decrypt(CardNum, application.CryptKey)>
			<cfset newEncryptedData = Encrypt(oldDecryptedData, myKey, "CFMX_COMPAT", "Hex")>
			<cfset newDecryptedData = Decrypt(newEncryptedData, myKey, "CFMX_COMPAT", "Hex")>
			<cfif oldDecryptedData EQ newDecryptedData >
				<cfif NOT TestMode >
				<cfquery name="updateEncryptedData" datasource="#application.dsn#">
					UPDATE	Customers
					SET		CardNum = '#newEncryptedData#'
					WHERE	CustomerID = '#CustomerID#'
				</cfquery>
				</cfif>
				<tr><td>#CustomerID#</td><td>#newEncryptedData#</td><td>#newDecryptedData#</td><td>#oldDecryptedData#</td><td>YES</td></tr>
			<cfelse>
				<cfset ErrorOccurred = 1 >
				<cftransaction action="rollback"/>
				<tr style="color:##FF0000"><td>#CustomerID#</td><td>#newEncryptedData#</td><td>#newDecryptedData#</td><td>#oldDecryptedData#</td><td>NO</td></tr>
			</cfif>
		</cfif>
		
		<cfif TRIM(ExpDate) NEQ '' >
			<cfset oldDecryptedData = Decrypt(ExpDate, application.CryptKey)>
			<cfset newEncryptedData = Encrypt(oldDecryptedData, myKey, "CFMX_COMPAT", "Hex")>
			<cfset newDecryptedData = Decrypt(newEncryptedData, myKey, "CFMX_COMPAT", "Hex")>
			<cfif oldDecryptedData EQ newDecryptedData >
				<cfif NOT TestMode >
				<cfquery name="updateEncryptedData" datasource="#application.dsn#">
					UPDATE	Customers
					SET		ExpDate = '#newEncryptedData#'
					WHERE	CustomerID = '#CustomerID#'
				</cfquery>
				</cfif>
				<tr><td>#CustomerID#</td><td>#newEncryptedData#</td><td>#newDecryptedData#</td><td>#oldDecryptedData#</td><td>YES</td></tr>
			<cfelse>
				<cfset ErrorOccurred = 1 >
				<cftransaction action="rollback"/>
				<tr style="color:##FF0000"><td>#CustomerID#</td><td>#newEncryptedData#</td><td>#newDecryptedData#</td><td>#oldDecryptedData#</td><td>NO</td></tr>
			</cfif>
		</cfif>
		
		<cfif TRIM(Password) NEQ '' >
			<cfset oldDecryptedData = Decrypt(Password, application.CryptKey)>
			<cfset newEncryptedData = Encrypt(oldDecryptedData, myKey, "CFMX_COMPAT", "Hex")>
			<cfset newDecryptedData = Decrypt(newEncryptedData, myKey, "CFMX_COMPAT", "Hex")>
			<cfif oldDecryptedData EQ newDecryptedData >
				<cfif NOT TestMode >
				<cfquery name="updateEncryptedData" datasource="#application.dsn#">
					UPDATE	Customers
					SET		Password = '#newEncryptedData#'
					WHERE	CustomerID = '#CustomerID#'
				</cfquery>
				</cfif>
				<tr><td>#CustomerID#</td><td>#newEncryptedData#</td><td>#newDecryptedData#</td><td>#oldDecryptedData#</td><td>YES</td></tr>
			<cfelse>
				<cfset ErrorOccurred = 1 >
				<cftransaction action="rollback"/>
				<tr style="color:##FF0000"><td>#CustomerID#</td><td>#newEncryptedData#</td><td>#newDecryptedData#</td><td>#oldDecryptedData#</td><td>NO</td></tr>
			</cfif>
		</cfif>
		
	</cfoutput>
	</table>
	
	<cfquery name="getEncryptedAffiliates" datasource="#application.dsn#">
		SELECT	AFID, Password
		FROM	Affiliates
	</cfquery>

	<table width="100%" border="1" bordercolor="#CCCCCC" cellpadding="2" cellspacing="0" style="margin-bottom:10px;">
		<tr><td colspan="5"><h2>Affiliates</h2></td></tr>
		<tr><td>Affiliate ID</td><td>New Encrypted Value</td><td>New Decrypted Value</td><td>Old Decrypted Value</td><td>Successful</td></tr>
	<cfoutput query="getEncryptedAffiliates">
		
		<cfif TRIM(Password) NEQ '' >
			<cfset oldDecryptedData = Decrypt(Password, application.CryptKey)>
			<cfset newEncryptedData = Encrypt(oldDecryptedData, myKey, "CFMX_COMPAT", "Hex")>
			<cfset newDecryptedData = Decrypt(newEncryptedData, myKey, "CFMX_COMPAT", "Hex")>
			<cfif oldDecryptedData EQ newDecryptedData >
				<cfif NOT TestMode >
				<cfquery name="updateEncryptedData" datasource="#application.dsn#">
					UPDATE	Affiliates
					SET		Password = '#newEncryptedData#'
					WHERE	AFID = #AFID#
				</cfquery>
				</cfif>
				<tr><td>#AFID#</td><td>#newEncryptedData#</td><td>#newDecryptedData#</td><td>#oldDecryptedData#</td><td>YES</td></tr>
			<cfelse>
				<cfset ErrorOccurred = 1 >
				<cftransaction action="rollback"/>
				<tr style="color:##FF0000"><td>#AFID#</td><td>#newEncryptedData#</td><td>#newDecryptedData#</td><td>#oldDecryptedData#</td><td>NO</td></tr>
			</cfif>
		</cfif>
		
	</cfoutput>
	</table>
	
	<cfquery name="getEncryptedAuthorizeNet" datasource="#application.dsn#">
		SELECT	ID, Login, Hash
		FROM	AuthorizeNet
	</cfquery>

	<table width="100%" border="1" bordercolor="#CCCCCC" cellpadding="2" cellspacing="0" style="margin-bottom:10px;">
		<tr><td colspan="5"><h2>AuthorizeNet</h2></td></tr>
		<tr><td>AuthorizeNet ID</td><td>New Encrypted Value</td><td>New Decrypted Value</td><td>Old Decrypted Value</td><td>Successful</td></tr>
	<cfoutput query="getEncryptedAuthorizeNet">
		
		<cfif TRIM(Login) NEQ '' >
			<cfset oldDecryptedData = Decrypt(Login, application.CryptKey)>
			<cfset newEncryptedData = Encrypt(oldDecryptedData, myKey, "CFMX_COMPAT", "Hex")>
			<cfset newDecryptedData = Decrypt(newEncryptedData, myKey, "CFMX_COMPAT", "Hex")>
			<cfif oldDecryptedData EQ newDecryptedData >
				<cfif NOT TestMode >
				<cfquery name="updateEncryptedData" datasource="#application.dsn#">
					UPDATE	AuthorizeNet
					SET		Login = '#newEncryptedData#'
					WHERE	ID = #ID#
				</cfquery>
				</cfif>
				<tr><td>#ID#</td><td>#newEncryptedData#</td><td>#newDecryptedData#</td><td>#oldDecryptedData#</td><td>YES</td></tr>
			<cfelse>
				<cfset ErrorOccurred = 1 >
				<cftransaction action="rollback"/>
				<tr style="color:##FF0000"><td>#ID#</td><td>#newEncryptedData#</td><td>#newDecryptedData#</td><td>#oldDecryptedData#</td><td>NO</td></tr>
			</cfif>
		</cfif>
		
		<cfif TRIM(Hash) NEQ '' >
			<cfset oldDecryptedData = Decrypt(Hash, application.CryptKey)>
			<cfset newEncryptedData = Encrypt(oldDecryptedData, myKey, "CFMX_COMPAT", "Hex")>
			<cfset newDecryptedData = Decrypt(newEncryptedData, myKey, "CFMX_COMPAT", "Hex")>
			<cfif oldDecryptedData EQ newDecryptedData >
				<cfif NOT TestMode >
				<cfquery name="updateEncryptedData" datasource="#application.dsn#">
					UPDATE	AuthorizeNet
					SET		Hash = '#newEncryptedData#'
					WHERE	ID = #ID#
				</cfquery>
				</cfif>
				<tr><td>#ID#</td><td>#newEncryptedData#</td><td>#newDecryptedData#</td><td>#oldDecryptedData#</td><td>YES</td></tr>
			<cfelse>
				<cfset ErrorOccurred = 1 >
				<cftransaction action="rollback"/>
				<tr style="color:##FF0000"><td>#ID#</td><td>#newEncryptedData#</td><td>#newDecryptedData#</td><td>#oldDecryptedData#</td><td>NO</td></tr>
			</cfif>
		</cfif>
		
	</cfoutput>
	</table>
	
	<cfquery name="getEncryptedAuthorizeNetTK" datasource="#application.dsn#">
		SELECT	ID, TransKey, Password
		FROM	AuthorizeNetTK
	</cfquery>

	<table width="100%" border="1" bordercolor="#CCCCCC" cellpadding="2" cellspacing="0" style="margin-bottom:10px;">
		<tr><td colspan="5"><h2>AuthorizeNetTK</h2></td></tr>
		<tr><td>AuthorizeNetTK ID</td><td>New Encrypted Value</td><td>New Decrypted Value</td><td>Old Decrypted Value</td><td>Successful</td></tr>
	<cfoutput query="getEncryptedAuthorizeNetTK">
		
		<cfif TRIM(TransKey) NEQ '' >
			<cfset oldDecryptedData = Decrypt(TransKey, application.CryptKey)>
			<cfset newEncryptedData = Encrypt(oldDecryptedData, myKey, "CFMX_COMPAT", "Hex")>
			<cfset newDecryptedData = Decrypt(newEncryptedData, myKey, "CFMX_COMPAT", "Hex")>
			<cfif oldDecryptedData EQ newDecryptedData >
				<cfif NOT TestMode >
				<cfquery name="updateEncryptedData" datasource="#application.dsn#">
					UPDATE	AuthorizeNetTK
					SET		TransKey = '#newEncryptedData#'
					WHERE	ID = #ID#
				</cfquery>
				</cfif>
				<tr><td>#ID#</td><td>#newEncryptedData#</td><td>#newDecryptedData#</td><td>#oldDecryptedData#</td><td>YES</td></tr>
			<cfelse>
				<cfset ErrorOccurred = 1 >
				<cftransaction action="rollback"/>
				<tr style="color:##FF0000"><td>#ID#</td><td>#newEncryptedData#</td><td>#newDecryptedData#</td><td>#oldDecryptedData#</td><td>NO</td></tr>
			</cfif>
		</cfif>
		
		<cfif TRIM(Password) NEQ '' >
			<cfset oldDecryptedData = Decrypt(Password, application.CryptKey)>
			<cfset newEncryptedData = Encrypt(oldDecryptedData, myKey, "CFMX_COMPAT", "Hex")>
			<cfset newDecryptedData = Decrypt(newEncryptedData, myKey, "CFMX_COMPAT", "Hex")>
			<cfif oldDecryptedData EQ newDecryptedData >
				<cfif NOT TestMode >
				<cfquery name="updateEncryptedData" datasource="#application.dsn#">
					UPDATE	AuthorizeNetTK
					SET		Password = '#newEncryptedData#'
					WHERE	ID = #ID#
				</cfquery>
				</cfif>
				<tr><td>#ID#</td><td>#newEncryptedData#</td><td>#newDecryptedData#</td><td>#oldDecryptedData#</td><td>YES</td></tr>
			<cfelse>
				<cfset ErrorOccurred = 1 >
				<cftransaction action="rollback"/>
				<tr style="color:##FF0000"><td>#ID#</td><td>#newEncryptedData#</td><td>#newDecryptedData#</td><td>#oldDecryptedData#</td><td>NO</td></tr>
			</cfif>
		</cfif>
		
	</cfoutput>
	</table>
	
	<cfquery name="getEncryptedPayflowLink" datasource="#application.dsn#">
		SELECT	ID, Login, Partner
		FROM	PayflowLink
	</cfquery>

	<table width="100%" border="1" bordercolor="#CCCCCC" cellpadding="2" cellspacing="0" style="margin-bottom:10px;">
		<tr><td colspan="5"><h2>PayflowLink</h2></td></tr>
		<tr><td>PayflowLink ID</td><td>New Encrypted Value</td><td>New Decrypted Value</td><td>Old Decrypted Value</td><td>Successful</td></tr>
	<cfoutput query="getEncryptedPayflowLink">
		
		<cfif TRIM(Login) NEQ '' >
			<cfset oldDecryptedData = Decrypt(Login, application.CryptKey)>
			<cfset newEncryptedData = Encrypt(oldDecryptedData, myKey, "CFMX_COMPAT", "Hex")>
			<cfset newDecryptedData = Decrypt(newEncryptedData, myKey, "CFMX_COMPAT", "Hex")>
			<cfif oldDecryptedData EQ newDecryptedData >
				<cfif NOT TestMode >
				<cfquery name="updateEncryptedData" datasource="#application.dsn#">
					UPDATE	PayflowLink
					SET		Login = '#newEncryptedData#'
					WHERE	ID = #ID#
				</cfquery>
				</cfif>
				<tr><td>#ID#</td><td>#newEncryptedData#</td><td>#newDecryptedData#</td><td>#oldDecryptedData#</td><td>YES</td></tr>
			<cfelse>
				<cfset ErrorOccurred = 1 >
				<cftransaction action="rollback"/>
				<tr style="color:##FF0000"><td>#ID#</td><td>#newEncryptedData#</td><td>#newDecryptedData#</td><td>#oldDecryptedData#</td><td>NO</td></tr>
			</cfif>
		</cfif>
		
		<cfif TRIM(Partner) NEQ '' >
			<cfset oldDecryptedData = Decrypt(Partner, application.CryptKey)>
			<cfset newEncryptedData = Encrypt(oldDecryptedData, myKey, "CFMX_COMPAT", "Hex")>
			<cfset newDecryptedData = Decrypt(newEncryptedData, myKey, "CFMX_COMPAT", "Hex")>
			<cfif oldDecryptedData EQ newDecryptedData >
				<cfif NOT TestMode >
				<cfquery name="updateEncryptedData" datasource="#application.dsn#">
					UPDATE	PayflowLink
					SET		Partner = '#newEncryptedData#'
					WHERE	ID = #ID#
				</cfquery>
				</cfif>
				<tr><td>#ID#</td><td>#newEncryptedData#</td><td>#newDecryptedData#</td><td>#oldDecryptedData#</td><td>YES</td></tr>
			<cfelse>
				<cfset ErrorOccurred = 1 >
				<cftransaction action="rollback"/>
				<tr style="color:##FF0000"><td>#ID#</td><td>#newEncryptedData#</td><td>#newDecryptedData#</td><td>#oldDecryptedData#</td><td>NO</td></tr>
			</cfif>
		</cfif>
		
	</cfoutput>
	</table>
	
	<cfquery name="getEncryptedUSAePay" datasource="#application.dsn#">
		SELECT	ID, TransKey
		FROM	USAePay
	</cfquery>

	<table width="100%" border="1" bordercolor="#CCCCCC" cellpadding="2" cellspacing="0" style="margin-bottom:10px;">
		<tr><td colspan="5"><h2>USAePay</h2></td></tr>
		<tr><td>USAePay ID</td><td>New Encrypted Value</td><td>New Decrypted Value</td><td>Old Decrypted Value</td><td>Successful</td></tr>
	<cfoutput query="getEncryptedUSAePay">
		
		<cfif TRIM(TransKey) NEQ '' >
			<cfset oldDecryptedData = Decrypt(TransKey, application.CryptKey)>
			<cfset newEncryptedData = Encrypt(oldDecryptedData, myKey, "CFMX_COMPAT", "Hex")>
			<cfset newDecryptedData = Decrypt(newEncryptedData, myKey, "CFMX_COMPAT", "Hex")>
			<cfif oldDecryptedData EQ newDecryptedData >
				<cfif NOT TestMode >
				<cfquery name="updateEncryptedData" datasource="#application.dsn#">
					UPDATE	USAePay
					SET		TransKey = '#newEncryptedData#'
					WHERE	ID = #ID#
				</cfquery>
				</cfif>
				<tr><td>#ID#</td><td>#newEncryptedData#</td><td>#newDecryptedData#</td><td>#oldDecryptedData#</td><td>YES</td></tr>
			<cfelse>
				<cfset ErrorOccurred = 1 >
				<cftransaction action="rollback"/>
				<tr style="color:##FF0000"><td>#ID#</td><td>#newEncryptedData#</td><td>#newDecryptedData#</td><td>#oldDecryptedData#</td><td>NO</td></tr>
			</cfif>
		</cfif>
				
	</cfoutput>
	</table>
	
	<!--- IF NO ERRORS OCCURRED, UPDATE CRYPT KEY IN DATABASE --->
	<cfif NOT TestMode >
		<cfif ErrorOccurred EQ 0 >	
			<cfquery name="updateCryptKey" datasource="#application.dsn#">
				UPDATE	Config
				SET		CryptKey = '#myKey#'
				WHERE	SiteID = #application.SiteID#
			</cfquery>
			<!--- EXTRA PROTECTION --->
			<cfquery name="getNewCryptKey" datasource="#application.dsn#">
				SELECT	CryptKey
				FROM	Config
				WHERE	SiteID = #application.SiteID#
			</cfquery>
			<cfif getNewCryptKey.CryptKey NEQ myKey >
				<cfset ErrorOccurred = 1 >
				<cftransaction action="rollback"/>
				<table width="100%" border="1" bordercolor="#CCCCCC" cellpadding="2" cellspacing="0" style="margin-bottom:10px;">
					<tr><td><h2><font color="##FF0000">ERROR: While attempting to update your old CartFusion crypt key with the new crypt key,<br>an error occurred. Transactions have been rolled back (not committed to the database).</font></h2></td></tr>
				</table>
			<cfelse>
				<table width="100%" border="1" bordercolor="#CCCCCC" cellpadding="2" cellspacing="0" style="margin-bottom:10px;">
					<tr><td><font color="##009900">My new CartFusion crypt key is "<cfoutput>#myKey#</cfoutput>"</font></td></tr>
				</table>
			</cfif>
		</cfif>
	</cfif>
	
	<!--- IF NO ERRORS OCCURRED, COMMIT TRANSACTIONS TO THE DATABASE --->
	<cfif ErrorOccurred EQ 0 >
		<cftransaction action="commit"/>
		<table width="100%" border="1" bordercolor="#CCCCCC" cellpadding="2" cellspacing="0" style="margin-bottom:10px;">
			<tr><td><h2><font color="##009900">SUCCESS! All encrypted data in your CartFusion database has been converted successfully.</font></h2></td></tr>
		</table>
	</cfif>

	<cfcatch>
		<cftransaction action="rollback"/>
		<table width="100%" border="1" bordercolor="#CCCCCC" cellpadding="2" cellspacing="0" style="margin-bottom:10px;">
			<tr><td><h2><font color="##FF0000">A ColdFusion error has occurred. Transactions have been rolled back (not committed to the database).</font></h2></td></tr>
			<tr><td><cfdump var="#cfcatch#" label="CFCATCH" expand="no"></td></tr>
		</table>
	</cfcatch>
</cftry>
</cftransaction>

</body>
</html>
