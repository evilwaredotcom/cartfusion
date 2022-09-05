<!--- 
|| LEGAL ||
$CartFusion - Copyright � 2001-2007 Trade Studios, LLC.$
$This copyright notice MUST stay intact for use (see license.txt).$
$It is against the law to copy, distribute, gift, bundle or give away this code$
$without written consent from Trade Studios, LLC.$

|| VERSION CONTROL ||
$Id: 4.7.0.3b $
$Date: 26-Mar-07 $
$Revision: 1.0.0 $

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