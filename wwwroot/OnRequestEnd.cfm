<cfprocessingdirective suppresswhitespace="Yes">
<!--- MUST BE A LINE ABOVE THIS LINE --->
<!--- <cfdump var="#Variables.SessionID#"> ---> 
<!--- <cfdump var="#session.CustomerArray#"> --->
<!--- <cfdump var="#CGI#"> --->
<!---<cfoutput><font color="EFEFEF">AFID 1:#session.CustomerArray[36]# &nbsp; AFID 2:#session.CustomerArray[38]#</font></cfoutput>--->
<!---
<cfif isDefined('session.TempWishlist')>
	<!---<cfscript>StructDelete(session, 'TempWishlist');</cfscript>--->
	<cfdump var="#session.TempWishlist#">	
</cfif>
--->
</cfprocessingdirective>