<!--- 
|| LEGAL ||
$CartFusion - Copyright © 2001-2007 Trade Studios, LLC.$
$This copyright notice MUST stay intact for use (see license.txt).$
$It is against the law to copy, distribute, gift, bundle or give away this code$
$without written consent from Trade Studios, LLC.$

|| VERSION CONTROL ||
$Id: $
$Date: $
$Revision: $

|| DESCRIPTION || 
$Description: $
$TODO: $

|| DEVELOPER ||
$Developer: Trade Studios, LLC (webmaster@tradestudios.com)$

|| SUPPORT ||
$Support Email: support@tradestudios.com$
$Support Website: http://support.tradestudios.com$

|| ATTRIBUTES ||
$in: $
$out:$
--->

<cfcomponent displayname="Colors Module">
	
	<cfscript>
		variables.dsn = "";
	</cfscript>

	<cffunction name="init" returntype="Colors" output="false">
		<cfargument name="dsn" required="true">
	
		<cfscript>
			variables.dsn = arguments.dsn;
		</cfscript>
		
		<cfreturn this />
	</cffunction>


	<cffunction name="GetSchoolColors" output="false">
		
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
				SELECT 		Schools_ID, Schools_ColorLink, Schools_ColorHeader, Schools_ColorFooter, Schools_ColorLeft
				FROM 		barket_Schools
			</cfquery>
			
			<cfscript>
				if ( NOT data.RecordCount )
				{
					stReturn.bSuccess = False ;
					stReturn.Message = "I am sorry but no colors were found" ;
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