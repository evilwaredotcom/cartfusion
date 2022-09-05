<cfsilent>
<cfprocessingdirective suppresswhitespace="Yes">
<cfscript>
	SoftwareVersion = "4_8_1";
	CoreFolder = "core";
	ApplicationName = "gps481";
	
	// CREATE UNIQUE APPLICATION NAME
	prefix = hash(getCurrentTemplatePath());
	prefix = reReplace(prefix, "[^a-zA-Z]","","all");
	prefix = right(prefix, 64 - len("_cf_#ApplicationName#"));
	
	// LOAD DIFFERENT CONFIGURATION FILES BASED ON SERVER YOU ARE ON
	// SET NUMBER OF LEVELS APPLICATION IS BELOW THE ROOT DIRECTORY
	// SPECIFY WHETHER SSL URL IS USED ALWAYS (not recommended)
	if (CGI.HTTP_HOST CONTAINS "localhost" OR CGI.HTTP_HOST CONTAINS "192.168." OR CGI.HTTP_HOST CONTAINS "127.0.0.") {
		ConfigurationFile = "config\config_local.xml.cfm";
		SubDomainLevels = 1;
		SSLAlwaysOn = false;
		debug = true;
	} else {
		ConfigurationFile = "config\config_local.xml.cfm";
		SubDomainLevels = 1;
		SSLAlwaysOn = false;
		debug = false;
	}
</cfscript>

<!--- SECURE HTTPS ALWAYS ON? : RELOCATE TO HTTPS:// --->
<cfif SSLAlwaysOn AND cgi.https is "off">
	<cflocation url="https://#cgi.server_name##cgi.path_info#" addtoken="false"><cfabort>
</cfif>

<cfapplication name="#prefix#_cf_#ApplicationName#"
			   clientmanagement="YES"
			   sessionmanagement="YES"
			   setclientcookies="YES"
			   setdomaincookies="YES"
			   sessiontimeout="#CreateTimeSpan(0,0,30,0)#"
			   applicationtimeout="#CreateTimeSpan(0,24,0,0)#">
			   
<!--- GLOBAL VARIABLE TO WRITE TO SCREEN --->
<cfparam name="DisplayMessage" type="string" default="">

<!--- ERROR HANDLER
<cferror template="error.cfm" type="exception" exception="any"> --->

<!--- COOKIE settings for IE to logout if browser is closed --->
<cfif isDefined("Cookie.CFID") AND isDefined("Cookie.CFTOKEN")>
	<cfset localCFID = Cookie.CFID>
	<cfset localCFTOKEN = Cookie.CFTOKEN>
<!--- TEMP !!!! !  ! ! ! ! ! ! !  ! ---><cfset sessionID = Cookie.CFTOKEN>
	<cfcookie name="CFID" value="#localCFID#">
	<cfcookie name="CFTOKEN" value="#localCFTOKEN#">
<cfelse>
	<cfinclude template="Login.cfm">
	<cfabort>
</cfif>

<!--- LOAD APPLICATION --->
<cfif NOT structKeyExists(application, "init") OR structKeyExists(url, "reinit")>
	<cfscript>
		xmlFile = "";
		xmlData = "";
		rootDir = getDirectoryFromPath(getCurrentTemplatePath());
		rootDirConfig = listDeleteAt(rootDir, listLen(rootDir,"\"), "\");
		for(index = 1; index LT SubDomainLevels; index = index + 1){
			rootDirConfig = listDeleteAt(rootDirConfig, listLen(rootDirConfig,"\"), "\");
		}
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
		//
		// APPLICATION
		//
		// commonly used components
		//application.Config = CreateObject("component", "#application.Components#.config.config").init(dsn=application.dsn,SiteID=application.SiteID);
		//application.Layout = CreateObject("component", "#application.Components#.layout.layout").init(dsn=application.dsn);
		application.Cart = CreateObject("component", "#application.Components#.cart.cart").init(dsn=application.dsn);
		application.Common = CreateObject("component", "#application.Components#.common.common").init(dsn=application.dsn);
		application.Queries = CreateObject("component", "#application.Components#.queries.queries").init(dsn=application.dsn);
		application.Shipping = CreateObject("component", "#application.Components#.shipping.shipping").init(dsn=application.dsn,SiteID=application.SiteID);
		application.Shipping.Airborne = CreateObject("component", "#application.Components#.shipping.airborne").init(dsn=application.dsn,SiteID=application.SiteID);		
		application.Shipping.AussiePost = CreateObject("component", "#application.Components#.shipping.aussiepost").init(dsn=application.dsn,SiteID=application.SiteID);
		application.Shipping.DHL = CreateObject("component", "#application.Components#.shipping.dhl").init(dsn=application.dsn,SiteID=application.SiteID);
		application.Shipping.FedEx = CreateObject("component", "#application.Components#.shipping.fedex").init(dsn=application.dsn,SiteID=application.SiteID);
		application.Shipping.UKPost = CreateObject("component", "#application.Components#.shipping.ukpost").init(dsn=application.dsn,SiteID=application.SiteID);
		application.Shipping.UPS = CreateObject("component", "#application.Components#.shipping.ups").init(dsn=application.dsn,SiteID=application.SiteID);
		application.Shipping.USPS = CreateObject("component", "#application.Components#.shipping.usps").init(dsn=application.dsn,SiteID=application.SiteID);
		// AUTHORIZE.NET?
		//application.AuthNet = CreateObject("component", "#application.Components#.payment.AuthorizeNet").init(dsn=application.dsn);
		// TS MODULE?
		//application.TS = CreateObject("component", "#application.Components#.ts.ts").init(dsn=application.dsn);
		
		// set application initialized
		application.init = true;
		
		// set day to test for last time app was initialized
		application.LastInitialized = NOW();
	</cfscript>
</cfif><!--- end initialize application --->
<cfscript>
	// old skool
	theCart = application.Cart;
	theCommon = application.Common;
	Queries = application.Queries;
</cfscript>
<cfscript>
	//
	// SESSION
	//
	if (structKeyExists(url, "delsesh")){
		 structClear(session);
	}
	// Initialize session-wide components and variables
	if (NOT structKeyExists(session, "#application.sessionVar#")){
		session[application.sessionVar] = structNew();
		session[application.sessionVar].Customers = structNew();
		session[application.sessionVar].Customers.isLoggedIn = false;
	}
	/* Set Custom Session Variables
	if (structKeyExists(url, "vip") AND TRIM(url.vip) NEQ ""){
		session[application.sessionVar].Customers.VIPCode = TRIM(url.vip);
	}*/
</cfscript>

<!--- instanstiate CustomerArray --->
<cflock timeout="10" type="exclusive" scope="session">
	<cfparam name="session.Initialized" default="false" type="boolean">
	<cfif session.Initialized EQ false>
		<cfset session.CustomerArray = ArrayNew(1)>
		<cfset session.Initialized = true>
	</cfif>
</cflock>
<!--- populate CustomerArray --->
<cflock timeout="10" type="exclusive" scope="session">	
	<cfparam name="session.CustomerArray" type="array">
	<cfloop index="loopcount" from="1" to="38">
		<cfparam name="session.CustomerArray[loopcount]" default="">
	</cfloop>
	<cfif session.CustomerArray[28] EQ "">
		<cfset session.CustomerArray[28] = 1>
	</cfif>
	<cfif isDefined("URL.AFID") AND URL.AFID NEQ ""><!--- AND session.CustomerArray[36] EQ "" --->
		<cfset session.CustomerArray[36] = URL.AFID>
	</cfif>
</cflock>

<!---  BEGIN NEW COOKIE CODE TO HANDLE THE SSL INTEGRATION  ---
<cflock timeout="10" type="exclusive" scope="session">
	<CFIF (#CGI.HTTP_COOKIE# NEQ "")>
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

</cfprocessingdirective>
</cfsilent>