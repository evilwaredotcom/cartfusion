<!--- 
	init
	AddCustomer
	EditCustomer
	GetCustomer	
--->

<cfcomponent displayname="AuthorizeNet Module">
	
	<cfscript>
		variables.dsn = "";
	</cfscript>

	<cffunction name="init" returntype="AuthorizeNet" output="false">
		<cfargument name="dsn" required="true">
	
		<cfscript>
			variables.dsn = arguments.dsn;
		</cfscript>
		
		<cfreturn this />
	</cffunction>
	
	<cffunction name="getAN" output="false">
		<cfargument name="SiteID" type="numeric" required="yes">
		
		<cfscript>
			var data = "";
		</cfscript>
		
		<cfquery name="data" datasource="#variables.dsn#">
			SELECT	Login
			FROM	AuthorizeNet
			WHERE	ID = #arguments.SiteID#
		</cfquery>
		
		<cfreturn data >
	</cffunction>
	
	<cffunction name="getANTK" output="false">
		<cfargument name="SiteID" type="numeric" required="yes">
		
		<cfscript>
			var data = "";
		</cfscript>
		
		<cfquery name="data" datasource="#variables.dsn#">
			SELECT	TransKey
			FROM	AuthorizeNetTK
			WHERE	ID = #arguments.SiteID#
		</cfquery>
		
		<cfreturn data >
	</cffunction>
	
</cfcomponent>