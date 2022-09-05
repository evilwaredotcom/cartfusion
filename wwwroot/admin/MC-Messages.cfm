<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<!--- BEGIN: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<cfif isDefined('form.UpdateMessage') AND IsDefined("form.MessageID") AND Form.Message NEQ ''>
	<cfif isDefined('form.Done')><cfset form.Done = 1>
	<cfelse><cfset form.Done = 0>
	</cfif>
	<cfset form.UpdatedBy = #GetAuthUser()#>	
	<cfupdate datasource="#application.dsn#" tablename="Messages" 
		formfields="MessageID, Message, Urgency, Done, UpdatedBy">
	<cfset AdminMsg = 'Message Updated Successfully' >
</cfif>

<cfif isDefined('form.AddMessage') AND Form.Message NEQ ''>
	<cfset form.CreatedBy = #GetAuthUser()#>
	<cfinsert datasource="#application.dsn#" tablename="Messages" 
		formfields="MessageID, Message, Urgency, CreatedBy">			
	<cfset AdminMsg = 'Message Added Successfully' >
</cfif>

<cfif isDefined('form.DeleteMessage') AND IsDefined("form.MessageID")>
	<cfinvoke component="#application.Queries#" method="deleteMessage" returnvariable="deleteMessage">
		<cfinvokeargument name="MessageID" value="#Form.MessageID#">
	</cfinvoke>
	<cfset AdminMsg = 'Message Deleted Successfully' >
</cfif>

<!--- END: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<!--- SET DEFAULT PARAMETERS --->
<cfparam name="URL.StartRow" default="1" type="numeric">
<cfparam name="URL.SortOption" default="MessageID" type="string">
<cfparam name="URL.SortAscending" default="0" type="numeric">
<cfparam name="Form.Field" default="ALL" type="string">
<cfparam name="Form.string" default="" type="string">
<cfset string = Trim(string)>

<!--- BEGIN: SEARCH CRITERIA -------------------------------------------------->
	
<cfquery name="getMessages" datasource="#application.dsn#">	
	SELECT 	*
	FROM 	Messages
	ORDER BY
	<cfif isDefined('URL.SortOption')> #URL.SortOption# <cfelse> MessageID </cfif>
	<cfif SortAscending EQ 1> ASC <cfelse> DESC </cfif>
</cfquery>

<!--- END: SEARCH CRITERIA -------------------------------------------------->

<!--- NEXT N VALUES --->
<cfscript>
	RowsPerPage = 15;
	TotalRows = getMessages.RecordCount;
	EndRow = Min(URL.StartRow + RowsPerPage - 1, TotalRows);
 	StartRowNext = EndRow + 1;
 	StartRowBack = URL.StartRow - RowsPerPage;
</cfscript>

<!--- HEADER --->
<cfscript>
	PageTitle = 'INTERNAL MESSAGE CENTER';
	BannerTitle = 'MessageCenteri' ;
	AddAButton = 'RETURN TO MESSAGE CENTER' ;
	AddAButtonLoc = 'MC-Home.cfm' ;
	QuickSearch = 0;
	QuickSearchPage = 'MC-Messages.cfm';
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">

<cfoutput>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td height="20" class="cfAdminTitle">ADD INTERNAL MESSAGE</td>
	</tr>
</table>

<table border="0" cellpadding="2" cellspacing="0" width="100%">	
<cfform action="MC-Messages.cfm" method="post">
	<tr style="background-color:##65ADF1;">
		<td width="8%"  class="cfAdminHeader1">Urgency</td>
		<td width="10%" class="cfAdminHeader1"></td>
		<td width="35%" class="cfAdminHeader1">Message</td>
		<td width="10%" class="cfAdminHeader1"></td>
		<td width="37%" class="cfAdminHeader1"></td>
	</tr>
	<tr>
		<td valign="middle">
			<select name="Urgency" class="cfAdminDefault">
				<option value="1" style="color:990000; font-weight:bold;" >Urgent</option>
				<option value="2" style="color:FF6600;" >Important</option>
				<option value="3" selected >Note</option>
			</select>
		</td>
		<td>&nbsp;</td>
		<td valign="top">
			<textarea name="Message" cols="70" rows="3" class="cfAdminDefault"></textarea>
		</td>
		<td valign="middle">
			<input type="submit" name="AddMessage" value="ADD" alt="Add Message" class="cfAdminButton">
		</td>
		<td>&nbsp;</td>
	</tr>
<input type="hidden" name="MessageID" value="">
</cfform>
</table>

<br>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr><td height="20" class="cfAdminTitle">INTERNAL MESSAGES</td></tr>
</table>

<table border="0" cellpadding="2" cellspacing="0" width="100%">	
	<tr style="background-color:##65ADF1;">
		<td width="8%" class="cfAdminHeader1" nowrap>
			Urgency
			<a href="MC-Messages.cfm?SortOption=Urgency&SortAscending=1"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="MC-Messages.cfm?SortOption=Urgency&SortAscending=0"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td width="10%" class="cfAdminHeader1" nowrap>
			Done
			<a href="MC-Messages.cfm?SortOption=Done&SortAscending=1"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="MC-Messages.cfm?SortOption=Done&SortAscending=0"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td width="42%" class="cfAdminHeader1" nowrap>
			Message
		</td>
		<td width="15%" class="cfAdminHeader1" nowrap>
			Date Created
			<a href="MC-Messages.cfm?SortOption=DateCreated&SortAscending=1"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="MC-Messages.cfm?SortOption=DateCreated&SortAscending=0"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td width="15%" class="cfAdminHeader1" nowrap>
			Created By
			<a href="MC-Messages.cfm?SortOption=CreatedBy&SortAscending=1"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="MC-Messages.cfm?SortOption=CreatedBy&SortAscending=0"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td width="10%" class="cfAdminHeader1" nowrap>&nbsp;</td><!--- DELETE --->
	</tr>
</cfoutput>

<cfoutput query="getMessages" startrow="#StartRow#" maxrows="#RowsPerPage#">
	<cfform action="MC-Messages.cfm?StartRow=#StartRow#&SortOption=#SortOption#&SortAscending=#SortAscending#&field=#field#&string=#string#" method="post">
	<tr>
		<td>
			<select name="Urgency" class="cfAdminDefault">
				<option value="1" <cfif Urgency EQ 1>selected</cfif> style="color:CC0000; font-weight:bold;" >Urgent</option>
				<option value="2" <cfif Urgency EQ 2>selected</cfif> style="color:FF6600;" >Important</option>
				<option value="3" <cfif Urgency EQ 3>selected</cfif> >Note</option>
			</select> 
		</td>
		<td>
			<input type="checkbox" name="Done" align="absmiddle" <cfif Done EQ 1> checked </cfif> >
		</td>
		<td>
			<textarea name="Message" cols="70" rows="3" class="cfAdminDefault">#Message#</textarea>
		</td>
		<td>#DateFormat(DateCreated, "mm/dd/yyyy")#<br>#TimeFormat(DateCreated, "@ hh:mm tt")#</td>
		<td>#CreatedBy#</td>
		<td align="right" nowrap>
			<input type="submit" name="UpdateMessage" value="UPDATE" alt="Update Message" class="cfAdminButton">
			<input type="submit" name="DeleteMessage" value="DELETE" alt="Delete Message" class="cfAdminButton"
				onclick="return confirm('Are you sure you want to DELETE THIS MESSAGE?')">
		</td>
	</tr>
	<!--- DIVIDER --->
	<tr><td height="1" colspan="6"><img src="images/image-LineGray.gif" width="100%" height="1"></td></tr>
	<input type="hidden" name="MessageID" value="#MessageID#">
	</cfform>
</cfoutput>


<!--- NAVIGATION ------------------------------------->
	<tr>
		<td colspan="3"><cfoutput>Displaying <b>#URL.StartRow#</b> to <b>#EndRow#</b> of <b>#TotalRows#</b> Messages</cfoutput></td>
		<td align="right" colspan="3"><cfinclude template="NextNButtons.cfm"></td>
	</tr>
<!--- NAVIGATION ------------------------------------->
</table>
	
<cfinclude template="LayoutAdminFooter.cfm">