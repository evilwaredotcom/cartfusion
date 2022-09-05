<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<link rel="shortcut icon" href="images/favicon.ico" />

<cfif isDefined('Logout') AND GetAuthUser() NEQ ''> 
	<cflogout>
</cfif>

<cflocation url="Main.cfm" addtoken="no">