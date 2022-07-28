<cfcomponent displayname="DHL Online Tools Module">

	<cfscript>
		variables.dsn = "";
	</cfscript>

	<cffunction name="init" returntype="DHL" output="no">
		<cfargument name="dsn" required="true">
		<cfscript>
			variables.dsn = arguments.dsn ;
		</cfscript>
		<cfreturn this />
	</cffunction>
    
	<cffunction name="myFunction" access="public" returntype="string">
		<cfargument name="myArgument" type="string" required="yes">
		<cfset myResult="foo">
		<cfreturn myResult>
	</cffunction>
    
</cfcomponent>