<cfsetting enablecfoutputonly="yes">
<cfheader name="content-type" value="text/xml">

<!--- Enter the secure URL path to the QWConnect.cfc. ---><!--- https://www.cartfusion.net/WCService/QWConnect.cfc --->
<cfset wspath = "https://localhost:8500/ponsard/ponsarditaly.com/httpdocs/admin/QB/WCService/QWConnect.cfc">

<!--- 
	to write the I/O requests to disk, enter a comma delimited list of the services to write in createxmlfiles.
	1 = authenticate
	2 = sendRequestXML
	3 = receiveResponseXML
	4 = connectionError
	5 = getLastError
	6 = closeConnection
	"1,2,3" would write all authenticate, sendRequestXML and receiveResponseXML requests to disk, in and out. 
--->
<cfset createxmlfiles = "1,2,3,4,5,6">

<CFPARAM NAME="wsmethod" DEFAULT="">

<!--- get the xml from the post --->
<cfset rd = GetHttpRequestData()>
<cfset xmlin = rd.content>
<CFIF not isXmlDoc(xmlin) and xmlin contains "<?xml">
	<cfset xmlin = xmlparse(xmlin)>
</CFIF>

<CFIF isXmlDoc(xmlin)>
	<cftry>
		<cfset writeoutfile = 0><cfset filetime = "#DateFormat(now(), "MMDD")#-#TimeFormat(now(), "HHmmss")#">
		<cfset wsmethod = xmlin.Envelope.Body.XmlChildren[1].XmlName>
		<cfswitch expression="#listlast(wsmethod, ':')#">

			<cfcase value = "authenticate">
				<!--- authenticate method --->
				<CFIF listlen(createxmlfiles) and listfindnocase(createxmlfiles, 1)><cfset writeoutfile = 1><cffile action="write" file="#expandpath('xmlfiles/#filetime#-#wsmethod#-i.xml')#" output="#rd.content#" addnewline="no"></CFIF>
				<cfset strUserName = xmlin.Envelope.Body.authenticate.strUserName.XmlText>
				<cfset strPassword = xmlin.Envelope.Body.authenticate.strPassword.XmlText>
				<cfinvoke webservice ="#wspath#?wsdl" method ="authenticate" returnVariable="xmlout">
				   <cfinvokeargument name="strUserName" value="#strUserName#">
				   <cfinvokeargument name="strPassword" value="#strPassword#">
				</cfinvoke><CFIF not isXmlDoc(xmlout) and xmlout contains "<?xml"></CFIF>
			</cfcase>
		
			<cfcase value = "sendRequestXML">
				<!--- sendRequestXML method --->
				<CFIF listlen(createxmlfiles) and listfindnocase(createxmlfiles, 2)><cfset writeoutfile = 1><cffile action="write" file="#expandpath('xmlfiles/#filetime#-#wsmethod#-i.xml')#" output="#rd.content#" addnewline="no"></CFIF>
				<cfset ticket = xmlin.Envelope.Body.sendRequestXML.ticket.XmlText>
				<cfset strHCPResponse = xmlin.Envelope.Body.sendRequestXML.strHCPResponse.XmlText>
				<cfset strCompanyFileName = xmlin.Envelope.Body.sendRequestXML.strCompanyFileName.XmlText>
				<cfset qbXMLCountry = "USA"><!--- change this to QuickBooks country --->
				<CFIF isDefined('xmlin.Envelope.Body.sendRequestXML.qbXMLCountry.XmlText')><cfset qbXMLCountry = xmlin.Envelope.Body.sendRequestXML.qbXMLCountry.XmlText></CFIF>
				<cfset qbXMLMajorVers = xmlin.Envelope.Body.sendRequestXML.qbXMLMajorVers.XmlText>
				<cfset qbXMLMinorVers = xmlin.Envelope.Body.sendRequestXML.qbXMLMinorVers.XmlText>
				<cfinvoke webservice ="#wspath#?wsdl" method ="sendRequestXML" returnVariable="xmlout">
				   <cfinvokeargument name="ticket" value="#ticket#">
				   <cfinvokeargument name="strHCPResponse" value="#strHCPResponse#">
				   <cfinvokeargument name="strCompanyFileName" value="#strCompanyFileName#">
				   <cfinvokeargument name="qbXMLCountry" value="#qbXMLCountry#">
				   <cfinvokeargument name="qbXMLMajorVers" value="#qbXMLMajorVers#">
				   <cfinvokeargument name="qbXMLMinorVers" value="#qbXMLMinorVers#">
				</cfinvoke><CFIF not isXmlDoc(xmlout) and xmlout contains "<?xml"></CFIF>
			</cfcase>
			
			<cfcase value = "receiveResponseXML">
				<!--- receiveResponseXML method --->
				<CFIF listlen(createxmlfiles) and listfindnocase(createxmlfiles, 3)><cfset writeoutfile = 1><cffile action="write" file="#expandpath('xmlfiles/#filetime#-#wsmethod#-i.xml')#" output="#rd.content#" addnewline="no"></CFIF>
				<cfset ticket = xmlin.Envelope.Body.receiveResponseXML.ticket.XmlText>
				<cfset response = xmlin.Envelope.Body.receiveResponseXML.response.XmlText>
				<cfset hresult = xmlin.Envelope.Body.receiveResponseXML.hresult.XmlText>
				<CFIF hresult IS "" and StructKeyExists(rd.headers, 'Test-Content')>
				<cfset message = "testing">
				<CFELSE>
				<cfset message = xmlin.Envelope.Body.receiveResponseXML.message.XmlText>
				</CFIF>
				<cfinvoke webservice ="#wspath#?wsdl" method ="receiveResponseXML" returnVariable="xmlout">
				   <cfinvokeargument name="ticket" value="#ticket#">
				   <cfinvokeargument name="response" value="#response#">
				   <cfinvokeargument name="hresult" value="#hresult#">
				   <cfinvokeargument name="message" value="#message#">
				</cfinvoke><CFIF not isXmlDoc(xmlout) and xmlout contains "<?xml"></CFIF>
			</cfcase>
			
			<cfcase value = "connectionError">
				<!--- connectionError method --->
				<CFIF listlen(createxmlfiles) and listfindnocase(createxmlfiles, 4)><cfset writeoutfile = 1><cffile action="write" file="#expandpath('xmlfiles/#filetime#-#wsmethod#-i.xml')#" output="#rd.content#" addnewline="no"></CFIF>
				<cfset ticket = xmlin.Envelope.Body.connectionError.ticket.XmlText>
				<cfset hresult = xmlin.Envelope.Body.connectionError.hresult.XmlText>
				<cfset message = xmlin.Envelope.Body.connectionError.message.XmlText>
				<cfinvoke webservice ="#wspath#?wsdl" method ="connectionError" returnVariable="xmlout">
				   <cfinvokeargument name="ticket" value="#ticket#">
				   <cfinvokeargument name="hresult" value="#hresult#">
				   <cfinvokeargument name="message" value="#message#">
				</cfinvoke><CFIF not isXmlDoc(xmlout) and xmlout contains "<?xml"></CFIF>
			</cfcase>
			
			<cfcase value = "getLastError">
				<!--- getLastError method --->
				<CFIF listlen(createxmlfiles) and listfindnocase(createxmlfiles, 5)><cfset writeoutfile = 1><cffile action="write" file="#expandpath('xmlfiles/#filetime#-#wsmethod#-i.xml')#" output="#rd.content#" addnewline="no"></CFIF>
				<cfset ticket = xmlin.Envelope.Body.getLastError.ticket.XmlText>
				<cfinvoke webservice ="#wspath#?wsdl" method ="getLastError" returnVariable="xmlout">
				   <cfinvokeargument name="ticket" value="#ticket#">
				</cfinvoke><CFIF not isXmlDoc(xmlout) and xmlout contains "<?xml"></CFIF>
			</cfcase>
			
			<cfcase value = "closeConnection">
				<!--- closeConnection method --->
				<CFIF listlen(createxmlfiles) and listfindnocase(createxmlfiles, 6)><cfset writeoutfile = 1><cffile action="write" file="#expandpath('xmlfiles/#filetime#-#wsmethod#-i.xml')#" output="#rd.content#" addnewline="no"></CFIF>
				<cfset ticket = xmlin.Envelope.Body.closeConnection.ticket.XmlText>
				<cfinvoke webservice ="#wspath#?wsdl" method ="closeConnection" returnVariable="xmlout">
				   <cfinvokeargument name="ticket" value="#ticket#">
				</cfinvoke><CFIF not isXmlDoc(xmlout) and xmlout contains "<?xml"></CFIF>
			</cfcase>
			
			<cfdefaultcase>
				<cfthrow message = "Method #wsmethod# unrecognized.">
			</cfdefaultcase>
		</cfswitch>
		
		<cfcatch type="any"><cfset myerror = "#cfcatch.message#<hr>#cfcatch.detail#">
			<cfset xmlout = '<?xml version="1.0" encoding="utf-8"?>
			<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
			  <soap:Body>
				<connectionErrorResponse xmlns="http://developer.intuit.com/">
				  <connectionErrorResult>#xmlformat(myerror)#</connectionErrorResult>
				</connectionErrorResponse>
			  </soap:Body>
			</soap:Envelope>'><CFIF not isXmlDoc(xmlout) and xmlout contains "<?xml"></CFIF>
		</cfcatch>
	</cftry>
	
	<CFIF listlen(createxmlfiles) and writeoutfile is 1>
		<cffile action="write" file="#expandpath('xmlfiles/#filetime#-#wsmethod#-o.xml')#" output="#toString(xmlout)#" addnewline="no">
	</CFIF>
	
	<CFOUTPUT>#xmlout#</CFOUTPUT>
	
<CFELSE>
	<CFOUTPUT><X>NO REQUEST</X></CFOUTPUT>
</CFIF>