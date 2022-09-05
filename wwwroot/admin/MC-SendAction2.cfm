<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<!--- BEGIN: ERROR CHECKING --->
<cfif Form.Customers EQ '' OR Form.Message EQ ''>
	<cflocation url="MC-Send.cfm?ErrorMsg=7" addtoken="no">
	<cfabort>
</cfif>
<!--- END: ERROR CHECKING --->

<cfscript>
	if ( Form.ValidFromDate EQ '' )
		ValidFrom = '' ;
	else
		ValidFrom = Form.ValidFromDate & ' ' & Form.ValidFromHour & ':' & Form.ValidFromMin & ' ' & Form.ValidFromAMPM ;
	if ( Form.ValidToDate EQ '' )
		ValidTo = '' ;
	else
		ValidTo = Form.ValidToDate & ' ' & Form.ValidToHour & ':' & Form.ValidToMin & ' ' & Form.ValidToAMPM ;
</cfscript>


<cfquery name="insertMessage" datasource="#application.dsn#">
	INSERT INTO	MessageCenter
		( Message, Customers, ValidFrom, <cfif ValidTo NEQ ''>ValidTo,</cfif> CreatedBy )
	VALUES 
		( '#Form.Message#', '#Form.Customers#', '#ValidFrom#', <cfif ValidTo NEQ ''>'#ValidTo#',</cfif> '#GetAuthUser()#' )
</cfquery>

<cfscript>
	PageTitle = 'CARTFUSION MESSAGE CENTER - COMPLETE MESSAGE' ;
	BannerTitle = 'MessageCenterc' ;
	AddAButton = 'RETURN TO MESSAGE CENTER' ;
	AddAButtonLoc = 'MC-Home.cfm' ;
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">

<cfoutput>
<div align="center" class="default" style="padding:20px;">
	<b class="red">!!! DO NOT REFRESH THIS PAGE !!!</b><br><br>	
	The following Message with created for <b>#ListLen(Customers)#</b> customers successfully!<br><br>
		<table width="80%" align="center" border="1" bordercolor="000000" cellpadding="7" cellspacing="0"><tr><td>
		<cfoutput>#Form.Message#</cfoutput>
		</td></tr></table><br><br>
	<b class="red">!!! DO NOT REFRESH THIS PAGE !!!</b><br><br><br>
	<input type="button" name="ReturnHome" value="RETURN TO MESSAGE CENTER" alt="Return Home" class="cfAdminButton"
		onClick="document.location.href='MC-Main.cfm'">
</div>
</cfoutput>

<cfinclude template="LayoutAdminFooter.cfm">