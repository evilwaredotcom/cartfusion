<!---
Inbound variables:
1 - "arguments.ticket" - The unique identifier for this session. Created during the authenticate
	 method and passed back to the Web Connector. If this field does not match the QB_Token
	 field in the ExportTable database we quit the service.
2 - "arguments.response" - Contains the qbXML response document from the last request sent to QuickBooks if no error occurred.
3 - "arguments.hresult" - If the request sent to QuickBooks from sendRequestXML resulted in an error (exception)
	 instead of a response, then the Web Connector will provide the HRESULT from the request.
4 - "arguments.message" - Same as HRESULT above but a message describing the error.

Outbound variables:
1 - "PercentComplete" - 3 possible values.
	A) A number between 0 and 99 means the job is that percent complete and sendRequestXML will be
	called again by the Web Connector. The web Connector status bar will be updated based on that number.
	B) 100 means we are 100% complete. The Web Connector will call the CloseConnection method.
	C) A negative number indicates an error, which you should log somewhere. The Web Connector will call
	the Web service�s getLastError method and the error will be presented to the user.
--->

<!--- your code goes here. --->

<!--- No need to touch the code below --->
<cfset mydoc = '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
	<receiveResponseXMLResponse xmlns="http://developer.intuit.com/">
	  <receiveResponseXMLResult></receiveResponseXMLResult>
	</receiveResponseXMLResponse>
  </soap:Body>
</soap:Envelope>'><cfset mydoc = xmlparse(mydoc)><cfset mydoc.Envelope.Body.receiveResponseXMLResponse.receiveResponseXMLResult.xmltext = PercentComplete>