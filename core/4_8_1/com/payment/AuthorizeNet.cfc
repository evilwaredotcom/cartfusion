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