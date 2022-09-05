<!---
Inbound variables:
1 - "arguments.ticket" - The unique identifier for this session.  This is the mytoken variable created during
	 the authenticate method and passed back to the Web Connector.

Outbound variables:
1 - "getLastErrorResult" - A string containing the last error that was logged.
--->

<!--- your code goes here. --->

<!--- No need to touch the code below --->
<cfset mydoc = '<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
	<getLastErrorResponse xmlns="http://developer.intuit.com/">
	  <getLastErrorResult>#getLastErrorResult#</getLastErrorResult>
	</getLastErrorResponse>
  </soap:Body>
</soap:Envelope>'><cfset mydoc = xmlparse(mydoc)>