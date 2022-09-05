<html>
<head>
<link rel="shortcut icon" href="images/favicon.ico" />
<META NAME="Author" CONTENT="Trade Studios - www.tradestudios.com">
<title>CARTFUSION: Top Frame</title>
<cfinclude template="css.cfm">
</head>

<body style="Margin: 0px">

<cfoutput>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr style="background-image:url(images/header-BG1.jpg); background-repeat:repeat-x;">
		<td width="130" height="38" align="center">
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr style="background-image:url(images/header-BG1L.jpg); background-repeat:no-repeat; background-position:left;">
					<td width="100%" height="38" align="center" class="cfAdminDefault">
						<a href="javascript:history.go();" target="main"><img src="images/button-Refresh.jpg" border="0" alt="Refresh Current Page"></a>
					</td>
				</tr>
			</table>
		</td>
		<td width="*" height="38" align="center">
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td width="25%" height="38" align="left" class="cfAdminDefault" style="padding-left:10px;">
						<font color="FFFFFF">Signed in as: #GetAuthUser()#</font>
					</td>
					<td width="50%" height="38" align="center" class="cfAdminDefault">
						<a href="Home.cfm" target="main"><b><font color="FFFFFF">#UCASE(application.CompanyName)# ADMINISTRATION PANEL</font></b></a>
					</td>
					<form action="./index.cfm" method="post" target="_top">
					<td width="25%" height="38" align="right" class="cfAdminDefault" style="background-image:url(images/header-BG1R.jpg); background-repeat:no-repeat; background-position:right; padding-right:14px;">
						<input type="hidden" name="Logout" value="Logout" />
						<input type="image" src="images/button-Logout.jpg" border="0" alt="Logout of Admin Panel" />
					</td>
					</form>
				</tr>
			</table>
		</td>
	</tr>
</table>
</cfoutput>

</font> 
</body>
</html>