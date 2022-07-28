<cfif structKeyExists(form, 'OfferSuggestion') AND form.Suggestion neq ''>

<cfmail to="#application.siteConfig.data.NotifyEmail#" from="#application.siteConfig.data.NotifyEmail#" subject="Website Suggestion Offer" timeout="5" type="html">
		<strong>OFFER SUGGESTION FROM #UCASE(application.siteConfig.data.DomainName)# WEBSITE VISITOR</strong><br><br>
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

<html>
<head>
	<title>Offer Suggestions to <cfoutput>#application.siteConfig.data.DomainName#</cfoutput></title>
		<link rel="stylesheet" type="text/css" href="css/cartfusion_screen_layout.css">
		<link rel="stylesheet" type="text/css" href="css/cartfusion_screen_formatting.css">
		<link rel="stylesheet" type="text/css" href="css/cartfusion_screen_design.css">
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
				value="<cfoutput>#Form.SuggestorName#</cfoutput>"
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

</body>
</html>












<!--- Old Code --->

<!--- <cfif isDefined('Form.OfferSuggestion') AND Form.Suggestion NEQ ''>
	<cfmail to="#config.NotifyEmail#" from="#config.NotifyEmail#" subject="Website Suggestion Offer" timeout="5" type="html">
		<b>OFFER SUGGESTION FROM #UCASE(config.DomainName)# WEBSITE VISITOR</b><br><br>
		<cfif isDefined('Form.SuggestorName') AND Form.SuggestorName NEQ '' >
		<b>NAME:</b> #Form.SuggestorName#<br><br>
		</cfif>
		<b>SUGGESTION:</b> #Form.Suggestion#
	</cfmail>
	THANK YOU FOR YOUR SUGGESTION !!!
	<script language="javascript">
		window.close();
	</script>
	<cfabort>
</cfif>

<html>
<head>
	<title>Offer Suggestions to <cfoutput>#config.DomainName#</cfoutput></title>
	<cfinclude template="css.cfm">
</head>

<body style="BACKGROUND-COLOR: <cfoutput>#layout.PrimaryBGColor#</cfoutput>">

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
				value="<cfoutput>#Form.SuggestorName#</cfoutput>"
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
</body>
</html> --->
