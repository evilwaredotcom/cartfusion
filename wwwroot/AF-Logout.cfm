<cflock scope="session" timeout="30" type="exclusive">
	<cfloop index="loopcount" from=1 to="#ArrayLen(session.CustomerArray)#">	
		<cfset session.AffiliateArray[loopcount] = ''>
	</cfloop>
	<cfset session.CustomerArray[38] = ''>
</cflock>

<cflocation url="index.cfm" addtoken="no">