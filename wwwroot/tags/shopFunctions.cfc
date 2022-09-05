<cfcomponent displayname="shop Functions" hint="This component handles common function calls from a CartFusion site.">

	<cfscript>
		variables.dsn = "";
	</cfscript>
	

	<cffunction name="init" returntype="Common" output="false">
		<cfargument name="dsn" required="true">
	
		<cfscript>
			variables.dsn = arguments.dsn;
		</cfscript>
		
		<cfreturn this />
	</cffunction>


	<!--- Use This Price --->
	<cffunction name="useThisPrice">
		

	</cffunction>
	
	
	<!--- Get Cart Contents --->
	<cffunction name="getCartContents">
	
	</cffunction>
	
	<!--- Cart Minimums --->
	<cffunction name="cartMinimums">
	
	</cffunction>

</cfcomponent>