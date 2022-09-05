<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<!--- BEGIN: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<cfif isDefined('form.UpdateMessage') AND IsDefined("form.MCID") AND Form.Message NEQ ''>
	<cfif isDefined('form.Done')><cfset form.Done = 1>
	<cfelse><cfset form.Done = 0>
	</cfif>
	<cfset form.UpdatedBy = #GetAuthUser()#>	
	<cfupdate datasource="#application.dsn#" tablename="Messages" 
		formfields="MCID, Message, Urgency, Done, UpdatedBy">
	<cfset AdminMsg = 'Message Updated Successfully' >
</cfif>

<cfif isDefined('form.AddMessage') AND Form.Message NEQ ''>
	<cfset form.CreatedBy = #GetAuthUser()#>
	<cfinsert datasource="#application.dsn#" tablename="Messages" 
		formfields="MCID, Message, Urgency, CreatedBy">			
	<cfset AdminMsg = 'Message Added Successfully' >
</cfif>

<cfif isDefined('form.DeleteMessage') AND IsDefined("form.MCID")>
	<cfinvoke component="#application.Queries#" method="deleteMessageCenter" returnvariable="deleteMessageCenter">
		<cfinvokeargument name="MCID" value="#Form.MCID#">
	</cfinvoke>
	<cfset AdminMsg = 'Message Deleted Successfully' >
</cfif>

<!--- END: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<!--- SET DEFAULT PARAMETERS --->
<cfparam name="URL.StartRow" default="1" type="numeric">
<cfparam name="URL.SortOption" default="MCID" type="string">
<cfparam name="URL.SortAscending" default="0" type="numeric">
<cfparam name="Form.Field" default="ALL" type="string">
<cfparam name="Form.string" default="" type="string">
<cfset string = Trim(string)>

<!--- BEGIN: SEARCH CRITERIA -------------------------------------------------->
	
<cfquery name="getMessageCenter" datasource="#application.dsn#">	
	SELECT 	*
	FROM 	MessageCenter
	ORDER BY
	<cfif isDefined('URL.SortOption')> #URL.SortOption# <cfelse> MCID </cfif>
	<cfif SortAscending EQ 1> ASC <cfelse> DESC </cfif>
</cfquery>

<!--- END: SEARCH CRITERIA -------------------------------------------------->

<!--- NEXT N VALUES --->
<cfscript>
	RowsPerPage = 15;
	TotalRows = getMessageCenter.RecordCount;
	EndRow = Min(URL.StartRow + RowsPerPage - 1, TotalRows);
 	StartRowNext = EndRow + 1;
 	StartRowBack = URL.StartRow - RowsPerPage;
</cfscript>

<!--- HEADER --->
<cfscript>
	PageTitle = 'CUSTOMER MESSAGE CENTER';
	BannerTitle = 'MessageCenterc' ;
	AddAButton = 'RETURN TO MESSAGE CENTER' ;
	AddAButtonLoc = 'MC-Home.cfm' ;
	QuickSearch = 0;
	QuickSearchPage = 'MC-Main.cfm';
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">

<cfoutput>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td>
			<input type="button" name="CreateNewMessage" value="CREATE NEW MESSAGE" alt="Create a new message for customers" class="cfAdminButton"
				onclick="document.location.href='MC-Send.cfm'">
		</td>
	</tr>
</table>
<br>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr><td height="20" class="cfAdminTitle">CUSTOMER MESSAGES</td></tr>
</table>

<table border="0" cellpadding="2" cellspacing="0" width="100%">	
	<tr style="background-color:##65ADF1;">
		<td width="5%" class="cfAdminHeader1" align="center" nowrap>
			ID
			<a href="MC-Main.cfm?SortOption=MCID&SortAscending=1"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="MC-Main.cfm?SortOption=MCID&SortAscending=0"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td width="10%" class="cfAdminHeader1" nowrap>
			Date Created
			<a href="MC-Main.cfm?SortOption=DateCreated&SortAscending=1"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="MC-Main.cfm?SortOption=DateCreated&SortAscending=0"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td width="10%" class="cfAdminHeader1" nowrap>
			Valid From
			<a href="MC-Main.cfm?SortOption=ValidFrom&SortAscending=1"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="MC-Main.cfm?SortOption=ValidFrom&SortAscending=0"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td width="10%" class="cfAdminHeader1" nowrap>
			Valid To
			<a href="MC-Main.cfm?SortOption=ValidTo&SortAscending=1"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="MC-Main.cfm?SortOption=ValidTo&SortAscending=0"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td width="40%" class="cfAdminHeader1" nowrap>
			Message
		</td>
		<td width="20%" class="cfAdminHeader1" nowrap>
			Sent To
		</td>
		<td width="5%" class="cfAdminHeader1" height="20"></td><!--- DELETE --->
	</tr>
</cfoutput>

<cfoutput query="getMessageCenter" startrow="#StartRow#" maxrows="#RowsPerPage#">
	<cfform action="MC-Main.cfm?StartRow=#StartRow#&SortOption=#SortOption#&SortAscending=#SortAscending#&field=#field#&string=#string#" method="post">
	<tr>
		<td align="center">
			#MCID#
		</td>
		<td>
			#DateFormat(DateCreated, "mm/dd/yyyy")#<br>#TimeFormat(DateCreated, "@ hh:mm tt")#
		</td>
		<td>
			#DateFormat(ValidFrom, "mm/dd/yyyy")#<br>#TimeFormat(ValidFrom, "@ hh:mm tt")#
		</td>
		<td>
			<cfif ValidTo NEQ ''>#DateFormat(ValidTo, "mm/dd/yyyy")#<br>#TimeFormat(ValidTo, "@ hh:mm tt")#</cfif>
		</td>
		<td>
			#Message#
		</td>
		<td>
			<textarea rows="3" name="Customers" class="cfAdminDefault">#Customers#</textarea>
		</td>
		<td>
			<input type="submit" name="DeleteMessage" value="DELETE" alt="Delete this message" class="cfAdminButton"
				onclick="return confirm('Are you sure you want to DELETE MESSAGE #MCID# ?')">
		</td>
	</tr>
	<!--- DIVIDER --->
	<tr><td height="1" colspan="8"><img src="images/image-LineGray.gif" width="100%" height="1"></td></tr>
	<input type="hidden" name="MCID" value="#MCID#">
	</cfform>
</cfoutput>


<!--- NAVIGATION ------------------------------------->
	<tr>
		<td colspan="4"><cfoutput>Displaying <b>#URL.StartRow#</b> to <b>#EndRow#</b> of <b>#TotalRows#</b> Messages</cfoutput></td>
		<td align="right" colspan="4"><cfinclude template="NextNButtons.cfm"></td>
	</tr>
<!--- NAVIGATION ------------------------------------->
</table>
	
<cfinclude template="LayoutAdminFooter.cfm">