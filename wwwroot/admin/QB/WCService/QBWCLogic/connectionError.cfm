<!---
Inbound variables:
1 - "arguments.ticket" - The unique identifier for this session. Created during
	 the authenticate method and passed back to the Web Connector.
2 - "arguments.hresult" - The error sent from QuickBooks in Hex.
3 - "arguments.message" - The error message.

Outbound variables:
1 - "connectionErrorResult" - A string letting Web Connector what we want to do next. If you wish to end the session, send "done".
	Any other string, or nothing, and QuickBooks will call sendRequestXML again. I always just send "done".
--->

<!--- your code goes here. --->
<cfset connectionErrorResult = "done">

<!--- No need to touch the code below --->
<cfset mydoc = '<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
	<connectionErrorResponse xmlns="http://developer.intuit.com/">
	  <connectionErrorResult>#connectionErrorResult#</connectionErrorResult>
	</connectionErrorResponse>
  </soap:Body>
</soap:Envelope>'><cfset mydoc = xmlparse(mydoc)>