<!---
Inbound variables. You may check that the username and password are recognized with these variables.
1 - "arguments.strUserName"
2 - "arguments.strPassword"

Outbound variables you must create:
1 - "mytoken" - A UUID identifying this session. This will be included in every subsequent call to the service to allow
	 you to identify the current session.
1 - "mystring" - A string letting Web Connector know what to do next. The possible values are:
	A) - "" (an empty string). Use this if the Web Connector is authenticated based on the inbound variables
		  and you DO have data to export to QuickBooks. This will export to the QuickBooks company file you have open when
		  you run the Web Connector.
	B) - "none" - Use this if the Web Connector is authenticated based on the inbound variables and you DO NOT have
		  data to export to QuickBooks.
	C) - "nvu" - Short for non-valid user. Use this if the authentication (login) fails.
	D) - "C:\path\to\companyfile.QBW" - This will use the QBW file it's pointing to, even if closed.
--->

<!--- Your code goes here. To get you started, I'm simply going to create mytoken and set mystring to "none"
indictaing to QuickBooks that there is no data to transfer. --->
<cfset mytoken = "{#ucase(createuuid())#}">">
<CFIF arguments.strPassword is "test"><cfset mystring = "none"><CFELSE><cfset mystring = "nvu"></CFIF>

<!--- No need to touch the code below --->
<cfset mydoc = '<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
	<authenticateResponse xmlns="http://developer.intuit.com/">
	  <authenticateResult>
		<string>#mytoken#</string>
		<string>#mystring#</string>
	  </authenticateResult>
	</authenticateResponse>
  </soap:Body>
</soap:Envelope>'><cfset mydoc = xmlparse(mydoc)>