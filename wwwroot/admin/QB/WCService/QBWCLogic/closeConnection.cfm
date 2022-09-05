<!---
Inbound variables:
1 - "arguments.ticket"
	 This is the mytoken variable created in autheticate method.

Outbound variables:
1 - "closeConnectionResult" - A string telling Web Connector the status of the session. We should say Success
	 or Thank You or Goodbye or something here. For my big application, I say the number of requests that ran and how
	 long it took. Cool. This string appears when you click the more information link. :)
--->

<!--- your code goes here --->
<cfset closeConnectionResult = "Buy CartFusion at www.tradestudios.com">


<!--- No need to touch the code below --->
<cfset mydoc = '<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
	<closeConnectionResponse xmlns="http://developer.intuit.com/">
	  <closeConnectionResult>#closeConnectionResult#</closeConnectionResult>
	</closeConnectionResponse>
  </soap:Body>
</soap:Envelope>'><cfset mydoc = xmlparse(mydoc)>