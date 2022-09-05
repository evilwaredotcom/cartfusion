<!--- 
|| LEGAL ||
$CartFusion - Copyright � 2001-2007 Trade Studios, LLC.$
$This copyright notice MUST stay intact for use (see license.txt).$
$It is against the law to copy, distribute, gift, bundle or give away this code$
$without written consent from Trade Studios, LLC.$

|| VERSION CONTROL ||
$Id: $
$Date: $
$Revision: $

|| DESCRIPTION || 
$Description: $
$TODO: 
	Carl Vanderpal: 18th May 2007 - Convert Image to database for the 
	integration of multiple domains pointing to the one site $
--->


<cfif structKeyExists(form, 'OfferSuggestion') AND form.Suggestion neq ''>

<cfmail to="#application.NotifyEmail#" from="#application.NotifyEmail#" subject="Website Suggestion Offer" timeout="5" type="html">
		<strong>OFFER SUGGESTION FROM #UCASE(application.DomainName)# WEBSITE VISITOR</strong><br><br>
		<cfif isDefined('form.SuggestorName') AND Form.SuggestorName NEQ '' >
		<strong>NAME:</strong> #Form.SuggestorName#<br><br>
		</cfif>
		<strong>SUGGESTION:</strong> #form.Suggestion#
	</cfmail>
	THANK YOU FOR YOUR SUGGESTION !!!
	<script language="javascript">
		window.close();
	</script>
	<cfabort>
</cfif>

<cfoutput>

<html>
<head>
	<title>Offer Suggestions to #application.DomainName#</title>
		<link rel="stylesheet" type="text/css" href="templates/#application.SiteTemplate#/screen_layout.css">
		<link rel="stylesheet" type="text/css" href="templates/#application.SiteTemplate#/screen_formatting.css">
		<link rel="stylesheet" type="text/css" href="templates/#application.SiteTemplate#/screen_design.css">
</head>

<body>

<img src="images/image-CompanyLogo.gif"><br>
<img src="images/spacer.gif" height="7" width="1"><br>

<table width="100%" cellpadding="3" cellspacing="0" border="0">
<form name="Suggestion" method="post" action="Suggestions.cfm">
	<tr>
		<td class="cfFormLabel" valign="top">
			Your Name (optional): 
		</td>
		<td class="cfFormLabel" valign="top">
			<input type="text" name="SuggestorName" size="30" class="cfFormField" align="absmiddle" 
			<cfif isDefined('Form.SuggestorName') AND Form.SuggestorName NEQ ''>
				value="#Form.SuggestorName#"
			</cfif>
			>
		</td>
	</tr>
	<tr>
		<td class="cfFormLabel" valign="top">
			Suggestion:
		</td>
		<td class="cfFormLabel" valign="top">
			<textarea name="Suggestion" cols="40" rows="5" class="cfDefault"></textarea> 
		</td>
	</tr>
	<tr>
		<td class="cfFormLabel" colspan="2" align="center">
			<input type="submit" name="OfferSuggestion" value="Offer Suggestion" size="10" class="cfButton" align="absmiddle">
		</td>
	</tr>
	<tr>
		<td class="cfFormLabel" colspan="2" align="center">
			PLEASE NOTE: Suggestions are totally anonymous.  Your email address is not captured.
			However, you may supply us with your name and phone number or email address if you wish to be contacted.
		</td>
	</tr>
</form>

</table>
</cfoutput>

</body>
</html>