<cfoutput>
<title>Large View</title>
<!--- <CFINCLUDE Template="css.cfm"> --->
<link rel="stylesheet" type="text/css" href="templates/#application.SiteTemplate#/screen_layout.css">
<link rel="stylesheet" type="text/css" href="templates/#application.SiteTemplate#/screen_formatting.css">
<link rel="stylesheet" type="text/css" href="templates/#application.SiteTemplate#/screen_design.css">
<CFINCLUDE Template="Includes/JSCode.cfm">

<table width="100%" height="100%" align="center" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td width="50%" class="cfHeading">
			&nbsp;&nbsp;#application.CompanyName#
		</td>
		<td width="50%" align="right">
			<a href="javascript:self.close()">X - Close Window</a>&nbsp;&nbsp;
		</td>
	</tr>
	<tr>
		<td valign="middle" align="center" colspan="2">
			<img src="images/#URL.id#/#URL.i#" border="0" alt="#application.CompanyName#">			
		</td>
	</tr>
</table>
</cfoutput>