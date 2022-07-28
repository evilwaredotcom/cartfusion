<!--- 
	init
	AddSchool
	EditSchool
	DeleteSchool
	GetSchool
	ViewAllSchools
	GetSchoolCount
	GetClass
	GetClasses
--->

<cfcomponent displayname="Schools Module">
	
	<cfscript>
		variables.dsn = "";
	</cfscript>

	<cffunction name="init" returntype="Schools" output="false">
		<cfargument name="dsn" required="true">
	
		<cfscript>
			variables.dsn = arguments.dsn;
		</cfscript>
		
		<cfreturn this />
	</cffunction>


	<cffunction name="AddSchool" output="false">
	
		<cfscript>
			var data = ""; 
			var stReturn = StructNew();
			stReturn.bSuccess = True;
			stReturn.message = "";
			stReturn.data = "";
			stReturn.stError = structNew();
		</cfscript>

		<cfreturn stReturn>
	</cffunction>



	<cffunction name="EditSchool" output="false">
	
		<cfscript>
			var data = ""; 
			var stReturn = StructNew();
			stReturn.bSuccess = True;
			stReturn.message = "";
			stReturn.data = "";
			stReturn.stError = structNew();
		</cfscript>

		<cfreturn stReturn>
	</cffunction>



	<cffunction name="DeleteSchool" output="false">
	
		<cfscript>
			var data = ""; 
			var stReturn = StructNew();
			stReturn.bSuccess = True;
			stReturn.message = "";
			stReturn.data = "";
			stReturn.stError = structNew();
		</cfscript>

		<cfreturn stReturn>
	</cffunction>



	<cffunction name="GetSchool" output="false">
		<cfargument name="Schools_ID" required="yes">
		
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
				SELECT 		* 
				FROM 		Schools
				WHERE		Schools_ID = #arguments.Schools_ID#
				ORDER BY 	Schools_Name
			</cfquery>
			
			<cfscript>
				if ( NOT data.RecordCount )
				{
					stReturn.bSuccess = False ;
					stReturn.Message = "I am sorry but no schools were found" ;
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



	<cffunction name="ViewAllSchools" output="false">
		
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
				SELECT 		* 
				FROM 		Schools
				WHERE		Schools_Hidden IS NULL
				OR			Schools_Hidden = 0
				ORDER BY 	Schools_Name
			</cfquery>
			
			<cfscript>
				if ( NOT data.RecordCount )
				{
					stReturn.bSuccess = False ;
					stReturn.Message = "I am sorry but no schools were found" ;
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



	<cffunction name="GetSchoolCount" output="false">
	
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
				SELECT 		COUNT (*) AS SchoolCount
				FROM 		Schools
			</cfquery>
			
			<cfscript>
				if ( NOT data.RecordCount )
				{
					stReturn.bSuccess = False ;
					stReturn.Message = "I am sorry but no schools were found" ;
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



	<cffunction name="GetClasses" output="false">
		<cfargument name="Schools_ID" required="no">
		
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
				SELECT 		* 
				FROM 		Classes
				WHERE		1 = 1
				<cfif isDefined('arguments.Schools_ID') >
				AND		Classes_School = #arguments.Schools_ID#
				</cfif>
				ORDER BY 	Classes_School, Classes_Term, Classes_Department, Classes_Course, Classes_Section, Classes_Professor
			</cfquery>
			
			<cfscript>
				if ( NOT data.RecordCount )
				{
					stReturn.bSuccess = False ;
					stReturn.Message = "I am sorry but no classes were found" ;
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
	
	
	
	<cffunction name="GetClassBooks" output="false">
		<cfargument name="ClassBooks_ID" required="no">
		<cfargument name="ClassBooks_ClassID" required="no">
		
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
				SELECT 		* 
				FROM 		ClassBooks
				WHERE		1 = 1
				<cfif isDefined('arguments.ClassBooks_ID') >
				AND		ClassBooks_ID = #arguments.ClassBooks_ID#
				</cfif>
				<cfif isDefined('arguments.ClassBooks_ClassID') >
				AND		ClassBooks_ClassID = #arguments.ClassBooks_ClassID#
				</cfif>
				ORDER BY 	ClassBooks_Title, ClassBooks_Author, ClassBooks_Edition
			</cfquery>
			
			<cfscript>
				if ( NOT data.RecordCount )
				{
					stReturn.bSuccess = False ;
					stReturn.Message = "I am sorry but no classes were found" ;
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