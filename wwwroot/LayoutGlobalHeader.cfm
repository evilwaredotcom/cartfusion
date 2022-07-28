<cfprocessingdirective suppresswhitespace="yes">
<cfif NOT isDefined("LoadedLayoutGlobalHeader") >
<cfoutput>
<html>
<head>
<link rel="shortcut icon" href="images/favicon.ico" />
<cfinclude template="LayoutGlobalMeta.cfm">
<cfinclude template="css.cfm">
<!--- <link rel="stylesheet" type="text/css" href="css.cfm"> --->
<cfinclude template="Includes/JSCode.cfm">
</head>

<body style="background-color: #layout.PrimaryBGColor#; margin: 0px; <cfif layout.PrimaryBGImage NEQ ''>background-image:url(#layout.PrimaryBGImage#);</cfif>" <cfif isDefined('BodyOptions')>#BodyOptions#</cfif> >

<table width="1020" align="center" border="0" cellpadding="0" cellspacing="0">
	<tr valign="top">
		<td align="center" width="1020" style="background-image:url(images/image-PageBackground.jpg); background-repeat:repeat-y;">
			<table width="1000" align="center" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td width="304" height="70" nowrap="nowrap"><img src="images/top-CompanyLogo.jpg" border="0"><a href="index.cfm"><img src="images/image-CompanyLogo.jpg" border="0" alt="#config.StoreName#"></a><img src="images/top-Green.jpg" border="0"></td>
					<td width="696" height="70" nowrap="nowrap">
						<table width="696" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td width="696" height="34" align="right"><img src="images/spacer.gif" height="34" width="1" alt="White Space"></td>
							</tr>
							<tr>
								<td width="696" height="4"><img src="images/top-SearchTop.jpg"></td>
							</tr>
							<tr>
								<td width="696" height="32" style="background-color:9EA6AD;">
									<table width="696" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td width="250" style="padding-left:8px;">
												<cfinclude template="Includes/CartSnapshot.cfm">
											</td>
											<td width="220" align="right" style="padding-right:8px;">
												<cfinclude template="Includes/WelcomeUser.cfm">
											</td>
											<script language="JavaScript">
												function resetBox()
												{
													document.SearchBox.string.value = "";
												}
											</script>
											<form action="SearchResults.cfm" name="SearchBox" id="SearchBox" method="GET" style="padding:0px; margin:0px;">
											<td width="226" align="right" style="padding-right:10px;">
												<img src="images/image-BoxSearch.jpg">&nbsp;
												<input type="text"   name="string" value="-- Keyword or SKU --" class="cfMini" size="30" align="absmiddle" onClick="resetBox();">&nbsp;&nbsp;
												<input NAME="button" TYPE="image" VALUE="Search" src="images/button-search.jpg" align="absmiddle">
												<input type="hidden" name="start" value="1">
												<input type="hidden" name="field" value="ItemAndID">
											</td>
											</form>
										</tr>
									</table>
								</td>
								
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td width="1000" height="38" colspan="2" align="right" valign="middle" style="background-image:url(images/top-Links.jpg); background-repeat:no-repeat; padding-right:13px;">
						<a href="index.cfm"><font class="cfWhite">HOME</font></a>
						<img src="images/top-Divider.jpg" hspace="13" align="absmiddle">
						<a href="AboutUs.cfm"><font class="cfWhite">ABOUT US</font></a>
						<img src="images/top-Divider.jpg" hspace="13" align="absmiddle">
						<a href="CategoryAll.cfm"><font class="cfWhite">PRODUCTS</font></a>
						<img src="images/top-Divider.jpg" hspace="13" align="absmiddle">
						<a href="SectionAll.cfm"><font class="cfWhite">DEPARTMENTS</font></a>
						<img src="images/top-Divider.jpg" hspace="13" align="absmiddle">
						<a href="CartEdit.cfm"><font class="cfWhite">VIEW CART</font></a>
						<img src="images/top-Divider.jpg" hspace="13" align="absmiddle">
						<a href="ContactUs.cfm"><font class="cfWhite">CUSTOMER SERVICE</font></a>
						<img src="images/top-Divider.jpg" hspace="13" align="absmiddle">
						<a href="AF-Main.cfm"><font class="cfWhite">AFFILIATES</font></a>
						<img src="images/top-Divider.jpg" hspace="13" align="absmiddle">
						<a href="CA-Login.cfm?goToPage=CA-CustomerArea.cfm"><font class="cfWhite">MY ACCOUNT</font></a>
						<img src="images/top-Divider.jpg" hspace="13" align="absmiddle">
						<a href="CA-Login.cfm?goToPage=#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#"><font class="cfWhite">LOGIN</font></a>
					</td>
				</tr>
				<tr>
					<td width="1000" height="5" colspan="2"><img src="images/top-LinksSub.jpg"></td>
				</tr>
			</table>
			
			<table width="1000" border="0" cellpadding="0" cellspacing="0">
				<tr valign="top"> 
					<cfif isDefined('HideLeftNav') AND HideLeftNav EQ 0 >
						<td width="195" valign="top">
							<img src="images/leftnav-Links.jpg" border="0"><br>
							<cfinclude template="LayoutLeftBrowser.cfm">
						</td>
						<td width="805" align="center" style="padding-top:10px;">
					<cfelse>
						<td width="1000" align="center" style="padding-top:10px; background-image:url(images/leftnav-Links.jpg); background-repeat:no-repeat;">
					</cfif>
					
					<cfif isDefined('BreadCrumbs')>
						<table width="805" border="0" cellspacing="0" cellpadding="0" style="padding-bottom:10px;">
							<tr>
								<td width="805" class="cfDefault">
									<cfinclude template="Includes/BreadCrumbs.cfm">
								</td>
							</tr>
						</table>
					</cfif>
					<cfif isDefined('ErrorMsg')>
						<div class='cfErrorMsg'><br>#ErrorMsg#</div><br>
					</cfif>
						
</cfoutput>				
<cfset LoadedLayoutGlobalHeader = True>
</cfif>
</cfprocessingdirective>