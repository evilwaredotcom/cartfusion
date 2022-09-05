<cfprocessingdirective pageencoding="utf-8">
<!---<cfmodule template="templates/#application.SiteTemplate#/layout.cfm">--->
<cfoutput>
<!--- Display friendly error --->
<div align="center">	
	<h2>An error has occured while processing your request...</h2>
	<br/>
	<br/>	
</div>
<div class="cfErrorMsg">
	<p>We are very sorry, but a technical problem prevents us from showing you what you were looking for. That said, we will naturally try to correct this problem as soon as we possible can (an email has now been sent to the administrator). Please try again shortly. Thank You</p>
	
	<p>Page: #cgi.script_name#?#cgi.query_string#<br>
	Time: #dateFormat(now())# #timeFormat(now())#<br></p>
</div>
</cfoutput>

<!--- If debugging, show error in browser --->
<cfif debug >
	<cfoutput>
	An Error Has Occured:<br>
	
		<h2>An error occured!</h2>
		<p>
		Page: #cgi.script_name#?#cgi.query_string#<br>
		Time: #dateFormat(now())# #timeFormat(now())#<br>
		</p>
		
		<cfdump var="#error#" label="Exception">
		<cfdump var="#application#" label="Application">
		<cfdump var="#session#" label="Session">
		<cfdump var="#request#" label="Request">
		<cfdump var="#url#" label="URL">
		<cfdump var="#form#" label="Form">
		<cfdump var="#cgi#" label="CGI">
	
	</cfoutput>
	
<!--- If not debugging, send error to administrator via email --->
<cfelse>

	<!--- Send the error report --->
	<cfsavecontent variable="mail">
	<cfoutput>
	An Error Has Occured:<br>
	
		<h2>An error occured!</h2>
		<p>
		Page: #cgi.script_name#?#cgi.query_string#<br>
		Time: #dateFormat(now())# #timeFormat(now())#<br>
		</p>
		
		<cfdump var="#error#" label="Exception">
		<cfdump var="#application#" label="Application">
		<cfdump var="#session#" label="Session">
		<cfdump var="#request#" label="Request">
		<cfdump var="#url#" label="URL">
		<cfdump var="#form#" label="Form">
		<cfdump var="#cgi#" label="CGI">
	
	</cfoutput>
	</cfsavecontent>
	
	<!--- You can put if tags around this if you have different mail server from local to live server 
	<cfmail to="mcgee.marty@gmail.com" from="errors@greenpeaksupply.com" subject="Error in #application.title#" type="html">
	#mail#
	</cfmail>--->
	
	<cfoutput>#mail#</cfoutput>

</cfif>

<!---</cfmodule>--->