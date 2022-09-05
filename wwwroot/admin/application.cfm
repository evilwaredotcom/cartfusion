<cfsilent>
<cfprocessingdirective suppresswhitespace="Yes">
<cfscript>
	SoftwareVersion = '4_8_1';
	CoreFolder = 'core';
	ApplicationName = 'phutureprimitive481';
	
	// CREATE UNIQUE APPLICATION NAME
	prefix = hash(getCurrentTemplatePath());
	prefix = reReplace(prefix, "[^a-zA-Z]","","all");
	prefix = right(prefix, 64 - len("_cfd_#ApplicationName#"));
	
	// LOAD DIFFERENT CONFIGURATION FILES BASED ON SERVER YOU'RE ON
	// SET NUMBER OF LEVELS APPLICATION IS BELOW THE ROOT DIRECTORY
	// SPECIFY WHETHER SSL URL IS USED ALWAYS (not recommended)
	if (CGI.HTTP_HOST DOES NOT CONTAIN '.com') {
		ConfigurationFile = 'config\config_local.xml.cfm';
		SubDomainLevels = 2; // 1 more than client side
		SSLAlwaysOn = false;
	} else {
		ConfigurationFile = 'config\config_production.xml.cfm';
		SubDomainLevels = 2; // 1 more than client side
		SSLAlwaysOn = false;
	}
</cfscript>
<!--- PROGRAMMERS, ARE WE IN DEBUG MODE? --->
<cfparam name="debug" type="boolean" default="false">
<!--- GLOBAL VARIABLE FOR MISCELLANEOUS MESSAGES TO WRITE TO SCREEN --->
<cfparam name="DisplayMessage" type="string" default="">

<!--- OPTIONAL - SECURE HTTPS ALWAYS ON, RELOCATE TO HTTPS://SITE --->
<cfif SSLAlwaysOn AND cgi.https is "off" >
	<cflocation url="https://#cgi.server_name##cgi.path_info#" addtoken="no">
	<cfabort>
</cfif>

<cfscript>
	prefix = hash(getCurrentTemplatePath());
	prefix = reReplace(prefix, "[^a-zA-Z]","","all");
	prefix = right(prefix, 64 - len("_cfd_#ApplicationName#"));
</cfscript>
<cfapplication name="#prefix#_cfd_#ApplicationName#"
			   clientmanagement="YES"
			   sessionmanagement="YES"
			   setclientcookies="YES"
			   setdomaincookies="NO"
			   sessiontimeout="#CreateTimeSpan(0,0,30,0)#"
			   applicationtimeout="#CreateTimeSpan(1,0,0,0)#">

<!--- ERROR HANDLER 
<cfif debug >
	<cferror template="error.cfm" type="exception" exception="any">
<cfelse>
	<cferror template="error.cfm" type="exception" exception="any">
</cfif>--->

<!--- Settings For IE to log out if browser is closed --->
<cfif IsDefined('Cookie.CFID') AND IsDefined('Cookie.CFTOKEN')>
	<cfset localCFID = Cookie.CFID>
	<cfset localCFTOKEN = Cookie.CFTOKEN>
	<!--- TEMP ---><cfset sessionID = Cookie.CFTOKEN>
	<cfcookie name="CFID" value="#localCFID#">
	<cfcookie name="CFTOKEN" value="#localCFTOKEN#">
<cfelse>
	<cfinclude template="Login.cfm">
	<cfabort>
</cfif>

<!--- LOAD APPLICATION --->
<cfif NOT StructKeyExists(application, "init") OR StructKeyExists(url, "reinit") OR application.LastInitialized NEQ Day(NOW()) OR CGI.HTTP_HOST CONTAINS 'localhost' >

	<cfscript>
		xmlFile = "";
		xmlData = "";
		rootDir = getDirectoryFromPath(getCurrentTemplatePath());
		rootDirConfig = ListDeleteAt(rootDir, ListLen(rootDir, "\"), '\');
		for(index = 1; index LT SubDomainLevels; index = index + 1)
			rootDirConfig = ListDeleteAt(rootDirConfig, ListLen(rootDirConfig, "\"), '\');
		key = "";
		groups = "";
	</cfscript>
	
	<!--- Load settings from XML file--->
	<cffile action="read" file="#rootDirConfig#\#CoreFolder#\#SoftwareVersion#\#ConfigurationFile#" variable="xmlFile">
	
	<cfscript>
		// Removes Comments
		xmlFile = replace(xmlFile, "<!---","");
		xmlFile = trim(replace(xmlFile, "--->",""));
		// Parse XML File
		xmlData = xmlParse(xmlFile);
	</cfscript>
	
	<!--- LOAD DEFAULT CONFIGURATION VARIABLES INTO APPLICATION SCOPE --->
	<cfloop item="key" collection="#xmlData.initvals.defaults#">
		<cfset application[key] = xmlData.initvals.defaults[key].xmlText>
	</cfloop>
	<!--- LOAD SITE CONFIGURATION VARIABLES INTO APPLICATION SCOPE --->
	<cfloop item="key" collection="#xmlData.initvals.config#">
		<cfset application[key] = xmlData.initvals.config[key].xmlText>
	</cfloop>

	<cfscript>
		// APPLICATION
		// Initialize application-wide components and variables
			
		// Set Day to test for last time app was initialized
		application.LastInitialized = Day(NOW());
		
		// Miscellaneous
		// application.Whatever = "Whatever";
		
		// Load commonly used application-wide components
		// application.Config = CreateObject("component", "#application.Components#.config.config").init(dsn=application.dsn,SiteID=application.SiteID);
		// application.Layout = CreateObject("component", "#application.Components#.layout.layout").init(dsn=application.dsn);
		// application.Cart = CreateObject("component", "#application.Components#.cart.cart").init(dsn=application.dsn);
		// application.Common = CreateObject("component", "#application.Components#.common.common").init(dsn=application.dsn);
		application.Queries = CreateObject("component", "#application.Components#.queries.queriesa").init(dsn=application.dsn);
		application.Shipping = CreateObject("component", "#application.Components#.shipping.shipping").init(dsn=application.dsn,SiteID=application.SiteID);
		application.Shipping.Airborne = CreateObject("component", "#application.Components#.shipping.airborne").init(dsn=application.dsn,SiteID=application.SiteID);		
		application.Shipping.AussiePost = CreateObject("component", "#application.Components#.shipping.aussiepost").init(dsn=application.dsn,SiteID=application.SiteID);
		application.Shipping.DHL = CreateObject("component", "#application.Components#.shipping.dhl").init(dsn=application.dsn,SiteID=application.SiteID);
		application.Shipping.FedEx = CreateObject("component", "#application.Components#.shipping.fedex").init(dsn=application.dsn,SiteID=application.SiteID);
		application.Shipping.UKPost = CreateObject("component", "#application.Components#.shipping.ukpost").init(dsn=application.dsn,SiteID=application.SiteID);
		application.Shipping.UPS = CreateObject("component", "#application.Components#.shipping.ups").init(dsn=application.dsn,SiteID=application.SiteID);
		application.Shipping.USPS = CreateObject("component", "#application.Components#.shipping.usps").init(dsn=application.dsn,SiteID=application.SiteID);
		// AUTHORIZE.NET ?
		// application.AuthNet = CreateObject("component", "#application.Components#.payment.AuthorizeNet").init(application.dsn);
		// 
		//		TRADE STUDIOS MODULE - EXAMPLE OF MODULARIZATION	//
		// application.TS = CreateObject("component", "#application.Components#.ts.ts").init(application.dsn);
		
		// Create commonly used application-wide variables
		// application.SiteConfig = application.application.getSiteSettings(dsn=application.dsn,SiteID=application.SiteID);
		
		// Set application initialized
		application.init = true;
	</cfscript>

</cfif><!--- Initialize Application --->

<cfscript>
	// SESSION
	if (StructKeyExists(url, "delsesh"))
	{
		 structClear(session);
	}
	// Initialize session-wide components and variables
	if (NOT StructKeyExists(session, "#application.sessionVarAdmin#"))
	{
		session[application.sessionVarAdmin] = StructNew();
		session[application.sessionVarAdmin].Users = StructNew();
		session[application.sessionVarAdmin].Users.ISLoggedIn = false;
	}
	/* Set Custom Session Variables
	if (StructKeyExists(url, "vip") AND TRIM(url.vip) NEQ '')
	{
		session[application.sessionVarAdmin].Customers.VIPCode = TRIM(url.vip);
	}
	*/
</cfscript>
<!---
<!--- 1 - HANDLE LOGOUT --->
<cfif StructKeyExists(url, "logout") >
	<cfscript>
		StructDelete(session[application.sessionVarAdmin], "Users");
		session[application.sessionVarAdmin].Users = StructNew();
		session[application.sessionVarAdmin].Users.ISLoggedIn = false;
	</cfscript>
	<cflocation url="login.cfm?1" addtoken="no">
</cfif>

<!--- 2 - HANDLE LOGIN --->
<cfscript>
	if (StructKeyExists(url, "1") AND CGI.SCRIPT_NAME CONTAINS 'login.cfm')
		DisplayMessage = 'You have successfully logged out';
</cfscript>
<cfif StructKeyExists(form, "signin") AND NOT session[application.sessionVarAdmin].Users.ISLoggedIn >
	<cfif TRIM(form.username) EQ '' OR TRIM(form.password) EQ '' >
		<cfset DisplayMessage = 'Username and Password Required' >
		<cfinclude template="Login.cfm">
		<cfabort>
	<cfelse>
		<cfscript>
			AuthenticateUser = application.Modules.AdminUsers.AuthenticateUser(UserName=TRIM(form.username),Password=TRIM(form.password));
		</cfscript>
		<cfif AuthenticateUser.bSuccess >
			<cfscript>
				session[application.sessionVarAdmin].Users.AdminUser_Name = AuthenticateUser.data.AdminUsers_Username;
				session[application.sessionVarAdmin].Users.AdminUser_Role = AuthenticateUser.data.AdminUsers_Roles;
				session[application.sessionVarAdmin].Users.ISLoggedIn = true;
			</cfscript>
		<cfelse>
			<cfset DisplayMessage = AuthenticateUser.Message > 
			<cfinclude template="Login.cfm">
			<cfabort>
		</cfif>
	</cfif>
</cfif>

<!--- 3 - ADDITIONAL SECURITY --->
<cfif (CGI.PATH_INFO does not contain "login.cfm" and CGI.SCRIPT_NAME does not contain "login.cfm")>
	<cfif NOT SESSION[application.sessionVarAdmin].Users.isLoggedIn >
		<cflocation url="login.cfm" addtoken="no">
	</cfif>
</cfif>
--->

<!--- STOP: NEWER CODE ------------------------------------------------------------------->


		
<!--- START: OLDER CODE ------------------------------------------------------------------->

<!--- OPEN COMPONENTS AS OBJECTS FOR USE IN PAGES --->
<cfset Queries = application.Queries >

<!--- BEGIN: CHECK LOGIN
<cfif IsDefined("logout")>
	<cflogout>
</cfif> --->

<cflogin>
  	<cfif NOT IsDefined("cflogin")>
		<cfinclude template="Login.cfm">
		<cfabort>
  	<cfelse>
		<cfif cflogin.name IS "" OR cflogin.password IS "">
			<div align="center" class="cfAdminError">You must enter text in both the User Name and Password fields</div>
			<cfinclude template="Login.cfm">
			<cfabort>
		<cfelse>
			<cfinvoke component="#application.Queries#" method="loginQuery" returnvariable="loginQuery">
				<cfinvokeargument name="UserName" value="#cflogin.name#">
				<cfinvokeargument name="Password" value="#cflogin.password#">
			</cfinvoke>
			<cfif loginQuery.Roles NEQ "">
				<cfloginuser name="#UCASE(cflogin.name)#" password="#cflogin.password#" roles="#loginQuery.Roles#">
			<cfelse>
				<div align="center" class="cfAdminError">INVALID LOGIN<br>Please Try again</div> 
				<cfinclude template="Login.cfm">
				<cfabort>
	  		</cfif>
		</cfif>  
  	</cfif>
</cflogin>

<!--- USPS --->
<cfif CGI.SCRIPT_NAME CONTAINS 'USPS'>
	<cfinvoke component="#application.Queries#" method="getShippingCos" returnvariable="getShippingCos">
		<cfinvokeargument name="SiteID" value="#application.SiteID#">
	</cfinvoke>
	<cfparam name="UserID" default="#getShippingCos.USPSUserID#">
	<cfparam name="Password" default="#getShippingCos.USPSPassword#">

<!--- UPS --->
<cfelseif CGI.SCRIPT_NAME CONTAINS 'UPS'>
	<cfinvoke component="#application.Queries#" method="getShippingCos" returnvariable="getShippingCos">
		<cfinvokeargument name="SiteID" value="#application.SiteID#">
	</cfinvoke>
	<cfparam name="AccessKey" default="#getShippingCos.UPSAccessKey#">
	<cfparam name="Userid" default="#getShippingCos.UPSUserID#">
	<cfparam name="Password" default="#getShippingCos.UPSPassword#">
	<cfparam name="AccountNumber" default="#getShippingCos.UPSAccountNum#">
	
<!--- FEDEX --->
<cfelseif CGI.SCRIPT_NAME CONTAINS 'FEDEX'>
	<cfinvoke component="#application.Queries#" method="getShippingCos" returnvariable="getShippingCos">
		<cfinvokeargument name="SiteID" value="#application.SiteID#">
	</cfinvoke>
	<cfparam name="fedexAcNum" default="#getShippingCos.FedexAccountNum#">
	<cfparam name="identifier" default="#getShippingCos.FedexIdentifier#">
	<cfparam name="TestGateway" default="#getShippingCos.FedexTestGateway#"> <!--- The full url will be provided to you by Fedex upon request and registration --->
	<cfparam name="ProductionGateway" default="#getShippingCos.FedexProdGateway#"> <!--- The full url will be provided to you by Fedex after testign is complete --->
</cfif>

<!--- STOP: OLDER CODE ------------------------------------------------------------------->

</cfprocessingdirective>
</cfsilent>