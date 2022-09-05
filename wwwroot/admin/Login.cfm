<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<cfoutput>
<html>
<head>
<cfset PageTitle = 'CARTFUSION ADMINISTRATION LOGIN'>
<cfinclude template="css.cfm">
</head>

<body onLoad="document.LoginForm.j_username.focus();">
<br>

<cfscript>
	if ( application.EnableSSL EQ 1 )
	{
		WriteOutput('<div align="center"><img src="#application.SSLURL#/admin/images/image-CartFusion.gif" alt="CartFusion Ecommerce Login Screen"><br></div>');
		URLFIN = "#application.SSLURL#/admin/index.cfm" ;
	}
	else
	{
		WriteOutput('<div align="center"><img src="#application.RootURL#/admin/images/image-CartFusion.gif" alt="CartFusion Ecommerce Login Screen"><br></div>');
		URLFIN = "#application.RootURL#/admin/index.cfm" ;
	}
	if ( CGI.QUERY_STRING NEQ '' )
		URLFIN = URLFIN & "?#CGI.QUERY_STRING#" ;
</cfscript>

<br><br>
 
<form action="#URLFIN#" method="Post" name="LoginForm"> 
<table align="center" width="300" cellspacing="0" cellpadding="3" border="0" class="cfAdminDefault">
	<tr>
		<td align="right" class="cfAdminDefault">User Name:</td>
		<td align="left"><input type="text" name="j_username" value="<cfif CGI.HTTP_HOST CONTAINS 'cartfusion.net'>demo</cfif>" size="20" class="cfAdminDefault" tabindex="1"></td>
	</tr>
	<tr>
		<td align="right" width="50%" class="cfAdminDefault">Password:</td>
		<td align="left" width="50%"><input type="password" name="j_password" value="<cfif CGI.HTTP_HOST CONTAINS 'cartfusion.net'>demo</cfif>" size="20" class="cfAdminDefault" tabindex="2"></td>
	</tr>
	<tr>
		<td align="center" colspan="2"><input type="submit" value="Log In" class="cfAdminDefault" tabindex="3"></td>
	</tr>
</table>
</form>
</cfoutput>
</div>


</font> 
</body>
</html>