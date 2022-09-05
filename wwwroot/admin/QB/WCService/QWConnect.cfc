<cfcomponent>
<cffunction name="authenticate" returntype="any" access="remote" output="no">
<cfargument name="strUserName" type="string">
<cfargument name="strPassword" type="string">
<cfinclude template="QBWCLogic/authenticate.cfm">
<cfreturn mydoc>
</cffunction>

<cffunction name="sendRequestXML" returntype="any" access="remote" output="no">
<cfargument name="ticket" type="string">
<cfargument name="strHCPResponse" type="string">
<cfargument name="strCompanyFileName" type="string">
<cfargument name="qbXMLCountry" type="string">
<cfargument name="qbXMLMajorVers" type="numeric">
<cfargument name="qbXMLMinorVers" type="numeric">
<cfinclude template="QBWCLogic/sendRequestXML.cfm">
<cfreturn mydoc>
</cffunction>

<cffunction name="receiveResponseXML" returntype="any" access="remote" output="no">
<cfargument name="ticket" type="string">
<cfargument name="response" type="string">
<cfargument name="hresult" type="string">
<cfargument name="message" type="string">
<cfinclude template="QBWCLogic/receiveResponseXML.cfm">
<cfreturn mydoc>
</cffunction>

<cffunction name="connectionError" returntype="any" access="remote" output="no">
<cfargument name="ticket" type="string">
<cfargument name="hresult" type="string">
<cfargument name="message" type="string">
<cfinclude template="QBWCLogic/connectionError.cfm">
<cfreturn mydoc>
</cffunction>

<cffunction name="getLastError" returntype="any" access="remote" output="no">
<cfargument name="ticket" type="string">
<cfinclude template="QBWCLogic/getLastError.cfm">
<cfreturn mydoc>
</cffunction>

<cffunction name="closeConnection" returntype="any" access="remote" output="no">
<cfargument name="ticket" type="string">
<cfinclude template="QBWCLogic/closeConnection.cfm">
<cfreturn mydoc>
</cffunction>
</cfcomponent>