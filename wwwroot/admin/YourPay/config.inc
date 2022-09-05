<cfquery name="getYourPay" datasource="#application.dsn#">
	SELECT	TOP 1 *
	FROM	PGYourPayAPI
	WHERE	InUse = 1
</cfquery>

<cfif getYourPay.RecordCount NEQ 0 >
	
	<cfoutput query="getYourPay">
	
		<!--- Change to your store number --->
		<CFSET configfile = "#StoreNumber#">
	
		<!--- Include the full path to the pem file --->
		<CFSET Keyfile ="#PEMFileLocation#"> 
	
		<!--- Host: secure.linkpt.net for live accounts or staging.linkpt.net for valid test stores. To request a test store, visit www.linkpoint.com --->
		<CFSET host = "staging.linkpt.net">
	
		<!--- Leave the port at 1129 --->
		<CFSET port = "1129"> 
	
		<!--- Set to "Live" for real time processing, "GOOD" for testing --->
		<cfif LiveMode EQ 1 >
			<CFSET result="Live">
		<cfelse>
			<CFSET result="GOOD">
		</cfif>
		
	</cfoutput>
	
</cfif>