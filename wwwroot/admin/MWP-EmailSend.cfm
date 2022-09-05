<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<!--- BEGIN: ERROR CHECKING --->
<cfif Form.EmailTo EQ '' OR Form.EmailFrom EQ '' OR Form.Subject EQ '' OR Form.Message EQ ''>
	<cfset ErrorMsg = 7>
	<cfinclude template="MWP-EmailMessage.cfm">
	<cfabort>
</cfif>
<!--- END: ERROR CHECKING --->

<cfset Form.EmailTo = #REReplace('#Form.EmailTo#', ';', ',', 'All')#> <!--- REPLACE ; with , --->
<cfset Form.EmailTo = #REReplace('#Form.EmailTo#', ' ', '', 'All')#>  <!--- REPLACE space with no space --->


<!--- Create a new column called EmailAddress and populate it with the data from
	  the Form.EmailTo List --->
<cfset EmailQuery = QueryNew('EID') >
<cfset NewRows = QueryAddRow(EmailQuery, ListLen('Form.EmailTo')) >
<cfset EmailArray = ListToArray(Form.EmailTo) >
<cfset MyNewColumn = QueryAddColumn(EmailQuery, "EmailAddress", EmailArray) >

<!--- Number of rows to send at a time  --->
<CFSET RowsToEmail = 10>
<!--- What row to start at? Assume first by default --->
<CFPARAM NAME="StartRow" DEFAULT="1" TYPE="numeric">
<CFSET TotalRows = EmailQuery.RecordCount>
<CFSET EndRow = Min(StartRow + RowsToEmail - 1, TotalRows)>
<CFSET StartRowNext = EndRow + 1>

<cfif isUserInRole('Administrator')>
	<cfloop from="#StartRow#" to="#TotalRows#" index="i" step="#RowsToEmail#">
		<cfset StartRowNext = i >
		<!---<cfset EndRowNext = StartRowNext + RowsPerPage >--->
		<cfif StartRowNext LTE TotalRows>		
			
			<cfprocessingdirective suppresswhitespace="yes">
				<cfmail query="EmailQuery" group="EmailAddress" startrow="#StartRowNext#" maxrows="#RowsToEmail#" timeout="360" 
					from="#Form.EmailFrom#" to="#EmailAddress#" charset="iso-8859-7" subject="#Form.Subject#" type="html">
				#ParagraphFormat(Form.Message)#
				</cfmail>
			</cfprocessingdirective>
	
		</cfif>
	</cfloop>
</cfif>

<cfscript>
	PageTitle = 'COMPLETE EMAIL MESSAGE' ;
	BannerTitle = 'MailWizardPro' ;
	AddAButton = 'RETURN TO MAIL WIZARD' ;
	AddAButtonLoc = 'MWP-Home.cfm' ;
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">

<cfoutput>
<div align="center" class="default" style="padding:20px;">
	<b class="red">!!! DO NOT REFRESH THIS PAGE !!!</b><br><br>	
	The following Email message with subject <b>"#Form.Subject#"</b> was sent to <b>#EmailQuery.RecordCount#</b> recipients successfully!<br><br>
		<table width="80%" align="center" border="1" bordercolor="000000" cellpadding="7" cellspacing="0"><tr><td>
		<cfoutput>#Form.Message#</cfoutput>
		</td></tr></table><br><br>
	<b class="red">!!! DO NOT REFRESH THIS PAGE !!!</b><br><br><br>
	<input type="button" name="ReturnHome" value="RETURN TO MAIL WIZARD" alt="Return Home" class="cfAdminButton"
		onClick="document.location.href='MWP-Home.cfm'">

</div>
</cfoutput>

<cfinclude template="LayoutAdminFooter.cfm">