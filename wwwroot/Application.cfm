<cfsilent>
<cfprocessingdirective suppresswhitespace="Yes">
<cfscript>
	SoftwareVersion = '4_8_0' ;
	CoreFolder = 'core' ;
	ApplicationName = 'cartfusion' ;
	if ( CGI.HTTP_HOST CONTAINS 'localhost' ) {
		ConfigurationFile = '_config\_serverSpecificVars2.xml.cfm' ;
		SubDomainLevels = 1 ;
	} else {
		ConfigurationFile = '_config\_serverSpecificVars.xml.cfm' ;
		SubDomainLevels = 1 ;
	}
</cfscript>
<cfparam name="debug" type="boolean" default="false">
<cfparam name="DisplayMessage" type="string" default="">
<!--- OPTIONAL - SECURE HTTPS ALWAYS ON
<cfif cgi.https is "off">
    <cflocation url="https://#cgi.server_name##cgi.path_info#" addtoken="no">
    <cfabort>
</cfif>
--->

<cfscript>
	prefix = hash(getCurrentTemplatePath()) ;
	prefix = reReplace(prefix, "[^a-zA-Z]","","all") ;
	prefix = right(prefix, 64 - len("_cf_#ApplicationName#")) ;
</cfscript>
<cfapplication name="#prefix#_cf_#ApplicationName#"
			   clientmanagement="YES"
               sessionmanagement="YES"
			   setclientcookies="YES"
			   setdomaincookies="NO"
               sessiontimeout="#CreateTimeSpan(0,0,30,0)#"
               applicationtimeout="#CreateTimeSpan(1,0,0,0)#">

<!--- ERROR HANDLER --->
<cfif debug >
	<!--- <cferror template="bughandler.cfm" type="exception" exception="any" mailto="bugs@tradestudios.com"> --->
<cfelse>
	<!--- <cferror template="bughandler.cfm" type="exception" exception="any" mailto="bugs@tradestudios.com"> --->
</cfif>

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
<cfif not StructKeyExists(application, "init") OR StructKeyExists(url, "reinit") OR application.LastInitialized NEQ Day(NOW()) >

	<cfscript>
        xmlFile = "" ;
        xmlData = "" ;
        rootDir = getDirectoryFromPath(getCurrentTemplatePath()) ;
        rootDirConfig = ListDeleteAt(rootDir, ListLen(rootDir, "\"), '\') ;
		for(index = 1; index LT SubDomainLevels; index = index + 1)
			rootDirConfig = ListDeleteAt(rootDirConfig, ListLen(rootDirConfig, "\"), '\') ;
        key = "" ;
        groups = "" ;
    </cfscript>
    
    <!--- Load settings from XML file--->
    <cffile action="read" file="#rootDirConfig#\#CoreFolder#\#SoftwareVersion#\#ConfigurationFile#" variable="xmlFile">
    
    <cfscript>
        // Removes Comments
        xmlFile = replace(xmlFile, "<!---","") ;
		xmlFile = trim(replace(xmlFile, "--->","")) ;
        // Parse XML File
        xmlData = xmlParse(xmlFile) ;
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
		application.LastInitialized = Day(NOW()) ;
		
		// Load commonly used application-wide components
		application.Config = CreateObject("component", "#application.Components#.config.config").init(dsn=application.dsn,SiteID=application.SiteID) ;
		//application.Layout = CreateObject("component", "#application.Components#.layout.layout").init(dsn=application.dsn) ;
		application.Cart = CreateObject("component", "#application.Components#.cart.cart").init(dsn=application.dsn) ;
		application.Common = CreateObject("component", "#application.Components#.common.common").init(dsn=application.dsn) ;
		application.Queries = CreateObject("component", "#application.Components#.queries.queries").init(dsn=application.dsn) ;
		application.Shipping = CreateObject("component", "#application.Components#.shipping.shipping").init(dsn=application.dsn,SiteID=application.SiteID) ;
		application.Shipping.Airborne = CreateObject("component", "#application.Components#.shipping.airborne").init(dsn=application.dsn,SiteID=application.SiteID) ;		
		application.Shipping.AussiePost = CreateObject("component", "#application.Components#.shipping.aussiepost").init(dsn=application.dsn,SiteID=application.SiteID) ;
		application.Shipping.DHL = CreateObject("component", "#application.Components#.shipping.dhl").init(dsn=application.dsn,SiteID=application.SiteID) ;
		application.Shipping.FedEx = CreateObject("component", "#application.Components#.shipping.fedex").init(dsn=application.dsn,SiteID=application.SiteID) ;
		application.Shipping.UKPost = CreateObject("component", "#application.Components#.shipping.ukpost").init(dsn=application.dsn,SiteID=application.SiteID) ;
		application.Shipping.UPS = CreateObject("component", "#application.Components#.shipping.ups").init(dsn=application.dsn,SiteID=application.SiteID) ;
		application.Shipping.USPS = CreateObject("component", "#application.Components#.shipping.usps").init(dsn=application.dsn,SiteID=application.SiteID) ;
		// AUTHORIZE.NET ?
		// application.AuthNet = CreateObject("component", "#application.Components#.payment.AuthorizeNet").init(dsn=application.dsn) ;
		// 
		//		TRADE STUDIOS MODULE - EXAMPLE OF MODULARIZATION	//
		// application.TS = CreateObject("component", "#application.Components#.ts.ts").init(dsn=application.dsn) ;
		
		// Create commonly used application-wide variables
		application.SiteConfig = application.Config.getSiteSettings(dsn=application.dsn,SiteID=application.SiteID) ;
		
		// Set application initialized
		application.init = true ;
	</cfscript>

</cfif><!--- Initialize Application --->

<cfscript>
	// SESSION
	if ( StructKeyExists(url, "delsesh") )
	{
		 structClear(session);
	}
	// Initialize session-wide components and variables
	if ( NOT StructKeyExists(session, "#application.sessionVarAdmin#") )
	{
		session[application.sessionVarAdmin] = StructNew() ;
		session[application.sessionVarAdmin].Users = StructNew() ;
		session[application.sessionVarAdmin].Users.isLoggedIn = false ;
	}
	/* Set Custom Session Variables
	if ( StructKeyExists(url, "vip") AND TRIM(url.vip) NEQ '' )
	{
		session[application.sessionVarAdmin].Customers.VIPCode = TRIM(url.vip) ;
	}
	*/
</cfscript>
<!---
<!--- 1 - HANDLE LOGOUT --->
<cfif StructKeyExists(url, "logout") >
	<cfscript>
		StructDelete(session[application.sessionVarAdmin], "Users") ;
		session[application.sessionVarAdmin].Users = StructNew() ;
		session[application.sessionVarAdmin].Users.ISLoggedIn = false ;
	</cfscript>
    <cflocation url="login.cfm?1" addtoken="no">
</cfif>

<!--- 2 - HANDLE LOGIN --->
<cfscript>
	if ( StructKeyExists(url, "1") AND CGI.SCRIPT_NAME CONTAINS 'login.cfm' )
		DisplayMessage = 'You have successfully logged out' ;
</cfscript>
<cfif StructKeyExists(form, "signin") AND NOT session[application.sessionVarAdmin].Users.ISLoggedIn >
	<cfif TRIM(form.username) EQ '' OR TRIM(form.password) EQ '' >
		<cfset DisplayMessage = 'Username and Password Required' >
        <cfinclude template="Login.cfm">
        <cfabort>
    <cfelse>
		<cfscript>
            AuthenticateUser = application.Modules.AdminUsers.AuthenticateUser(UserName=TRIM(form.username),Password=TRIM(form.password)) ;
        </cfscript>
        <cfif AuthenticateUser.bSuccess >
            <cfscript>
                session[application.sessionVarAdmin].Users.AdminUser_Name = AuthenticateUser.data.AdminUsers_Username ;
                session[application.sessionVarAdmin].Users.AdminUser_Role = AuthenticateUser.data.AdminUsers_Roles ;
                session[application.sessionVarAdmin].Users.ISLoggedIn = true ;
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


<!--- <cfdump var="#application.Shipping#">
<cfdump var="#application#"> --->

		
<!--- START: OLDER CODE ------------------------------------------------------------------->

<!--- TEMP FIX - NOW CAN DELETE INCLUDES/DATASOURCE.CFM --->
<cfset datasource = application.dsn >

<!--- BEGIN: Load Configuration and Layout --->

<!--- Commented out by Carl to see if used in site as I am converting to css --->

<!--- <cfquery name="config" datasource="#application.dsn#" cachedwithin="#CreateTimeSpan(0,0,0,0)#">
	SELECT 	*
	FROM	Config
	WHERE	SiteID = 1
</cfquery>
<cfquery name="layout" datasource="#application.dsn#" cachedwithin="#CreateTimeSpan(0,0,0,0)#">
	SELECT 	*
	FROM	Layout
	WHERE	SiteID = 1
</cfquery> --->
<!--- END: Load Configuration and Layout --->

<!--- OPEN COMPONENTS AS OBJECTS FOR USE IN PAGES
<cfobject component="CFCs/Cart" name="theCart">
<cfobject component="CFCs/Common" name="theCommon">
<cfobject component="CFCs/Queries" name="Queries"> --->
<cfset theCart = application.Cart >
<cfset theCommon = application.Common >
<cfset Queries = application.Queries >

<!--- BEGIN: Instanstiate CustomerArray IF SESSION HAS NOT BEEN INITIALIZED --->
<cflock timeout="10" type="exclusive" scope="session">
	<cfparam name="session.Initialized" default="false" type="boolean">
	<cfif session.Initialized EQ false>
		<cfset session.CustomerArray = ArrayNew(1)>
		<cfset session.Initialized = true>
	</cfif>
</cflock>
<!--- END: Instanstiate CustomerArray IF SESSION HAS NOT BEEN INITIALIZED --->

<!--- BEGIN: Instanstiate CustomerArray AND ELEMENTS USING CFPARAM --->
<cflock timeout="10" type="exclusive" scope="session">	
	<cfparam name="session.CustomerArray" type="array">
	<cfloop index="loopcount" from="1" to="38">
		<cfparam name="session.CustomerArray[loopcount]" default="">
	</cfloop>
	<cfif session.CustomerArray[28] EQ ''>
		<cfset session.CustomerArray[28] = 1>
	</cfif>
	<cfif isDefined('URL.AFID') AND URL.AFID NEQ ''><!--- AND session.CustomerArray[36] EQ '' --->
		<cfset session.CustomerArray[36] = URL.AFID >
	</cfif>
</cflock>
<!--- END: Instanstiate CustomerArray AND ELEMENTS USING CFPARAM --->

<!---  BEGIN NEW COOKIE CODE TO HANDLE THE SSL INTEGRATION  ---
<cflock timeout="10" type="exclusive" scope="session">
	<CFIF (#CGI.HTTP_COOKIE# NEQ '')>
		<CFIF isDefined("sessionID")>
			<cfset sessionID = #URLDecode(sessionID)#>
			<CFCOOKIE NAME="CartFusion" VALUE="#sessionID#" expires="1">
		<CFELSE>
			<cfset sessionID = session.CFToken>
		</CFIF>
	<CFELSE>
		<CFIF isDefined("sessionID")>
			<cfset sessionid = #URLDecode(sessionID)#>
			<CFCOOKIE NAME="CartFusion" VALUE="#sessionID#" expires="1">
		<CFELSE>
			<cfset sessionID = #CGI.REMOTE_ADDR#>
			<!---<cfinclude template="NoCookies.cfm">
			<cfabort>--->
		</CFIF>
	</CFIF>
</cflock>
---  END NEW COOKIE CODE TO HANDLE THE SSL INTEGRATION  --->

<!--- STOP: OLDER CODE ------------------------------------------------------------------->

</cfprocessingdirective>
</cfsilent>