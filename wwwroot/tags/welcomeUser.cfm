<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<cfoutput>
<cfif session.CustomerArray[26] NEQ ''>
		Welcome #session.CustomerArray[1]#! (<a href="#application.RootURL#/CA-LoginCheck.cfm?Logout=1">logout</a>)
<cfelseif session.CustomerArray[28] NEQ '' AND session.CustomerArray[28] NEQ 1>
	<cfquery name="getUser" datasource="#application.dsn#">
		SELECT 	UName
		FROM	Users
		WHERE	UID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.CustomerArray[28]#">
	</cfquery>
	<cfif getUser.RecordCount NEQ 0>
		Welcome #getUser.UName#! (<a href="#application.RootURL#/CA-LoginCheck.cfm?Logout=1">logout</a>)
	</cfif>
<cfelse>
	<a href="#application.RootURL#/CA-Login.cfm?goToPage=#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#">Login</a>
</cfif>
</cfoutput>