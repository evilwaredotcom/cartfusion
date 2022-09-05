<!---
Inbound variables:
1 - "arguments.ticket" - The unique identifier for this session. Created during
	 the authenticate method and passed back to the Web Connector. If this field
	 does not match the QB_Token field in the ExportTable database we quit the service.
2 - "arguments.strHCPResponse" - The is the QBXML response with HostQuery, CompanyQuery and PreferencesQuery.
	This will only be populated on quickbook's initial request for xml from the server. Subsequent requests
	will return a blank value.
3 - "arguments.strCompanyFileName" - Contains the path to the CompanyFile on the asking for the request.
4 - "arguments.qbXMLCountry" - This variable sometimes doesn't get returned while I was testing. If it's not there I hard
	 code it to "US" in the service.cfm file. Change if need be.
5 - "arguments.qbXMLMajorVers" - Major version number of QuickBooks you are using.
6 - "arguments.qbXMLMinorVers"- Minor version number of QuickBooks you are using.

Outbound variables:
1 - "SendQbXml" - This is the QBXML Xml document to send to QuickBooks. This can be an Add request, a Mod request,
	 or a Query request. If there are no requests to be sent to QuickBooks, set this as an empty
	 string, although in theory page should never be called if there are no requests.
 --->

<!--- your code goes here. --->

<!--- No need to touch the code below, We build the required container string. Then we parse it into an XML object (mydoc).
We then parse the QBXML document into an XML object. We then set the sendRequestXMLResult to the QBXML document object.
This causes the QBXML to be properly encoded for transport. Don't ask me why. It just works. :) --->
<cfset mydoc = '<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
	<sendRequestXMLResponse xmlns="http://developer.intuit.com/">
	  <sendRequestXMLResult></sendRequestXMLResult>
	</sendRequestXMLResponse>
  </soap:Body>
</soap:Envelope>'><cfset mydoc = xmlparse(mydoc)><CFIF isDefined('SendQbXml')><cfset mydoc.Envelope.Body.sendRequestXMLResponse.sendRequestXMLResult.xmltext = qbXmlOut></CFIF>