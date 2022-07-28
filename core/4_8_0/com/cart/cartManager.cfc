<cfcomponent hint="I am a Facade object that manages interactions with a session-scoped shopping cart object.">
	
	<cffunction name="init" access="public" output="false" returntype="cartManager">
		<cfreturn this />
	</cffunction>
	
	<cffunction name="createUserCart" output="false" access="public" returntype="void">
   		<cfset var checkSessionCartLoad = false />
		<cflock scope="session" timeout="10" type="readonly">
			<cfif not structKeyExists( session, 'cart' )>
				<cfset checkSessionCartLoad = true />
			</cfif>
		</cflock>
		<cfif checkSessionCartLoad>
			<cflock scope="session" timeout="10" type="exclusive">
				<cfset session.cart = createObject( 'component', 'cart' ).init() />
			</cflock>
		</cfif>
   	</cffunction>
	
	<cffunction name="populateCartItems" access="public" output="false" returntype="void">
		<cflock scope="session" timeout="10" type="exclusive">
			<cfset session.cart.populateCartItems() />
		</cflock>
	</cffunction>
	
	<cffunction name="getCartItems" access="public" output="false" returntype="array">
		<cflock scope="session" timeout="10" type="readonly">
			<cfreturn session.cart.getCartItems() />
		</cflock>
	</cffunction>
	
	<cffunction name="clearCartItems" access="public" output="false" returntype="void">
		<cflock scope="session" timeout="10" type="exclusive">
			<cfset session.cart.clearCartItems() />
		</cflock>
	</cffunction>
	
</cfcomponent>