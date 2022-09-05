<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<!--- Output <HTML><HEAD>...</head><BODY ...>, only if LayoutAdminHeader.cfm hasn't already been included --->
<cfif NOT isDefined("LoadedGlobalHeader")>

<html>
<head>
<META NAME="Author" CONTENT="Trade Studios - www.tradestudios.com">
<title><CFIF isDefined('PageTitle')><CFOUTPUT>#application.DomainName#: #PageTitle#</CFOUTPUT></CFIF></title>

<cfinclude template="../css.cfm">
<cfinclude template="../JSCode.cfm">

</head>


<body style="margin:0px;" <cfif isDefined('BodyOptions')><cfoutput>onLoad="#BodyOptions#"</cfoutput></cfif>>

<table border="0" cellpadding="0" cellspacing="0" width="100%" align="left" height="100%" style="padding:10px;">
	<tr valign="top">
		<td>
		
<cfset LoadedGlobalHeader = True>
</cfif>