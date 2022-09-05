<cfinclude template="MWP-ErrorChecking.cfm">
<cfinclude template="MWP-QueryCode.cfm">

<cfif NOT isDefined('getMWP') AND Form.SearchCriteria EQ 'ByEmail' AND Form.EmailsProvided NEQ ''>
	<cfset EmailList = Form.EmailsProvided >  <!--- CREATE LIST FROM FORM --->
	
<cfelseif getMWP.RecordCount EQ 0>
	<cfif Form.SearchCriteria EQ 'ByCriteria' AND isDefined('Form.ByIncludeEmails') AND Form.ByIncludeEmails NEQ 'on' AND Form.IncludeEmails NEQ ''>
		<cfset EmailList = #Form.IncludeEmails# ><!--- CREATE LIST FROM WRITTEN-IN EMAILS --->
	<cfelse>
		<cfset ErrorMsg = 8 > <!--- NO LIST CAN BE CREATED --->
		<cfinclude template="MWP-Home.cfm">
		<cfabort>
	</cfif>
	
<cfelseif getMWP.RecordCount NEQ 0>
	<cfset EmailList = ValueList(getMWP.Email)>  <!--- CREATE LIST FROM QUERY --->
	<cfif Form.SearchCriteria EQ 'ByCriteria' AND isDefined('Form.ByIncludeEmails') AND Form.ByIncludeEmails EQ 'on' AND Form.IncludeEmails NEQ ''>
		<cfset EmailList = ListAppend(EmailList, '#Form.IncludeEmails#')>  <!--- APPEND WRITTEN-IN EMAILS TO THE QUERY LIST --->
	</cfif>

<cfelse>
	<cfset ErrorMsg = 8 > <!--- NO LIST CAN BE CREATED --->
	<cfinclude template="MWP-Home.cfm">
	<cfabort>
</cfif>

<cfscript>
	PageTitle = 'CREATE EMAIL MESSAGE' ;
	BannerTitle = 'MailWizardPro' ;
	AddAButton = 'RETURN TO MAIL WIZARD' ;
	AddAButtonLoc = 'MWP-Home.cfm' ;
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">

<table width="100%" border="0" cellpadding="3" cellspacing="0" align="center">
<cfform name="SearchCriteriaSend" action="MWP-EmailSend.cfm" method="post">
	<tr><td colspan="2" height="20" class="cfAdminHeader1">&nbsp; EMAIL MESSAGE</td></tr>
	<cfif isDefined('ErrorMsg') AND ErrorMsg EQ 7>
	<tr>
		<td colspan="2" height="20" class="red" align="center">
			ERROR: Please fill in all fields.
		</td>		
	</tr>
	</cfif>
	<tr><td colspan="2" height="20"></td></tr>
	<tr>
		<td width="10%" align="right"><b>From: </b></td>
		<td><cfinput type="text" size="100" name="EmailFrom" required="yes" message="Please supply a FROM email address" value="#application.StoreNameShort# <#application.EmailInfo#>" class="cfAdminDefault"></td>
	</tr>
	<tr>
		<td width="10%" align="right"><b>To (BCC): </b></td>
		<td><textarea name="EmailTo" cols="100" rows="3" class="cfAdminDefault"><cfoutput>#EmailList#</cfoutput></textarea></td>
	</tr>
	<tr>
		<td width="10%" align="right" class="cfAdminDefault"><b>Subject: </b></td>
		<td><cfinput type="text" size="100" name="Subject" required="yes" message="Please supply a subject for this email" class="cfAdminDefault"></td>
	</tr>
	<tr>
		<td width="10%" align="right" class="cfAdminDefault" valign="top"><b>Message: </b></td>
		<td>
			<cfmodule 
				template="FCKeditor/fckeditor.cfm"
				basePath="FCKeditor/"
				instanceName="Message"
				value=''
				width="523"
				height="350"
				ToolbarSet="CartFusion"
			>
		</td>
	</tr>
	<tr><td colspan="2" height="20"></td></tr>	
	<tr>
		<td></td>
		<td style="padding-bottom:15px;">
			<input type="reset" name="resetBulk" value="RESET" class="cfAdminButton">
			<input type="submit" name="submitBulk" value="SEND EMAIL" style="color:FF6600;" class="cfAdminButton">
		</td>
	</tr>
</table>
</cfform>


<cfinclude template="LayoutAdminFooter.cfm">

