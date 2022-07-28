<cfcomponent displayname="Config Module">
	
	<cfscript>
		variables.dsn = "";
		variables.dsnmbs = "";
		variables.SiteID = "";
	</cfscript>


	<cffunction name="init" returntype="Config" output="false">
		<cfargument name="dsn" required="true">
		<cfargument name="SiteID" required="true">
		
		<cfscript>
			variables.dsn = arguments.dsn;
			variables.SiteID = arguments.SiteID;
		</cfscript>
		
		<cfreturn this />
	</cffunction>
	
	
	<cffunction name="getSiteSettings" output="false">
		<cfargument name="dsn" required="true">
		<cfargument name="SiteID" required="true">
		
		<cfscript>
			var data = ""; 
			var stReturn = StructNew();
			stReturn.bSuccess = True;
			stReturn.message = "";
			stReturn.data = "";
			stReturn.stError = structNew();
		</cfscript>
		
		<cftry>
		
			<cfquery name="data" datasource="#variables.dsn#">
				SELECT 	*
				FROM	Config
				WHERE	SiteID = #arguments.SiteID#
			</cfquery>
			
			<cfscript>
				if ( NOT data.RecordCount )
				{
					stReturn.bSuccess = False ;
					stReturn.Message = "I am sorry but no configuration info was found" ;
				}
				else
				{
					stReturn.bSuccess = True ;
					stReturn.data = data ;
				}
			</cfscript>
			
			<cfcatch>
				<cfscript>
					stReturn.bSuccess = False ;
					stReturn.message = cfcatch.message & "<br><br>" & cfcatch.detail ;
					stReturn.stError = cfcatch ;
				</cfscript>
			</cfcatch>
			
		</cftry>
	
		<cfreturn stReturn>
	</cffunction>
			
			
	<cffunction name="getAccounts" output="false">
		
		<cfscript>
			var data = ""; 
			var stReturn = StructNew();
			stReturn.bSuccess = True;
			stReturn.message = "";
			stReturn.data = "";
			stReturn.stError = structNew();
		</cfscript>
		
		<cftry>
		
			<cfquery name="data" datasource="#variables.dsn#">
				SELECT	SUM(Accounts_Customers) AS Accounts_Customers, 
						SUM(Accounts_Revenue) AS Accounts_Revenue, 
						SUM(Accounts_Shipping) AS Accounts_Shipping, 
						SUM(Accounts_Checking) AS Accounts_Checking, 
						SUM(Accounts_Customers) + SUM(Accounts_Revenue) + SUM(Accounts_Shipping) + SUM(Accounts_Checking) AS Accounts_Total
				FROM	ts_Accounts
			</cfquery>
			
			<cfscript>
				if ( NOT data.RecordCount )
				{
					stReturn.bSuccess = False ;
					stReturn.Message = "I am sorry but no account data was found" ;
				}
				else
				{
					stReturn.bSuccess = True ;
					stReturn.data = data ;
				}
			</cfscript>
			
			<cfcatch>
				<cfscript>
					stReturn.bSuccess = False ;
					stReturn.message = cfcatch.message & "<br><br>" & cfcatch.detail ;
					stReturn.stError = cfcatch ;
				</cfscript>
			</cfcatch>
			
		</cftry>
	
		<cfreturn stReturn>
	</cffunction>		
			

</cfcomponent>