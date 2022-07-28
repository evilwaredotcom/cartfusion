<cflock scope="session" timeout="30" type="exclusive">
	<cfloop index="loopcount" from=1 to="#ArrayLen(session.CustomerArray)#">	
		<cfset session.CustomerArray[loopcount] = ''>
	</cfloop>
</cflock>

<cflocation url="index.cfm" addtoken="no">