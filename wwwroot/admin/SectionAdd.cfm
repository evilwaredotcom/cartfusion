<!--- 
|| MIT LICENSE
|| CartFusion.com$This copyright notice MUST stay intact for use (see license.txt).$
$It is against the law to copy, distribute, gift, bundle or give away this code$
$without written consent from Trade Studios, LLC.$

|| VERSION CONTROL ||
$Id: 4.7.0.3b $
$Date: 26-Mar-07 $
$Revision: 1.0.0 $

|| DESCRIPTION ||
$Description: CARTFUSION 4.7 - CART CFC $
$TODO: $
--->

<!--- ! ABOVE DATABASE UPDATES ! --->
<!--- BEGIN: QUERIES ------------------------------------->
<cfinvoke component="#Queries#" method="getSites" returnvariable="getSites"></cfinvoke>
<cfinvoke component="#Queries#" method="getSections" returnvariable="getSections"></cfinvoke>
<cfinvoke component="#Queries#" method="getUsers" returnvariable="getUsers"></cfinvoke>
<!--- END: QUERIES ------------------------------------->

<!--- BEGIN: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<cfif isDefined('form.AddSection')>
	<cfif IsUserInRole('Administrator')>	
		<!--- PREVENT DUPLICATE --->
		<cfquery name="preventDuplicates" datasource="#application.dsn#">
			SELECT 	SecName
			FROM	Sections	
			WHERE	SecName = '#Form.SecName#'
			<cfif isDefined('Form.SubSectionOf') AND Form.SubSectionOf NEQ '' >
			AND		SubSectionOf = #Form.SubSectionOf#
			</cfif>
			AND		SiteID = #Form.SiteID#
		</cfquery>
		<cfif preventDuplicates.RecordCount EQ 0>
			<cftry>
				<cfscript>
					Form.SecName = Replace(Form.SecName, '"' , "''", "ALL") ;
					Form.DateCreated = Now() ;
					Form.DateUpdated = Now() ;
					Form.UpdatedBy = GetAuthUser() ;
				</cfscript>
				<cfinsert datasource="#application.dsn#" tablename="Sections" 
					formfields="SiteID, SecName, SubSectionOf, SecDescription, SecSummary, SecImage, SecImageDir, SecFeaturedDir, SecFeaturedID,
					SecMetaTitle, SecMetaDescription, SecMetaKeywords, SecMetaKeyphrases,
					SecBanner, AvailableCats, Comments, DisplayOrder, ShowColumns, ShowRows, Featured, DateCreated, DateUpdated, UpdatedBy ">
					
				<!--- GET NEWLY ASSIGNED SKU NUMBER --->
				<cfquery name="getAddedSectionID" datasource="#application.dsn#">
					SELECT	MAX(SectionID) AS SectionID
					FROM	Sections
				</cfquery>

				<cfif getAddedSectionID.RecordCount NEQ 0>
					<!--- UPDATE PRICES NOW --->
					<!--- SET HIDES TO 0 OR 1 --->
					<cfloop from="1" to="#getUsers.RecordCount#" index="i">
						<cfif isDefined('Form.Hide#i#')><cfset 'Form.Hide#i#' = 1>
						<cfelse><cfset 'Form.Hide#i#' = 0>
						</cfif>
					</cfloop>
					<cfquery name="setSectionHides" datasource="#application.dsn#">
						UPDATE 	Sections
						SET
						<cfloop from="1" to="#getUsers.RecordCount#" index="i">
							Hide#i#  = #Evaluate('Form.Hide' & i)#,
						</cfloop>
							UpdatedBy = '#Form.UpdatedBy#'
						WHERE	SectionID = #getAddedSectionID.SectionID#
					</cfquery>
				
					<cfset SectionID = getAddedSectionID.SectionID>
					<cfset AdminMsg = 'Section <cfoutput>#form.SecName#</cfoutput> Added Sucessfully' >
					<cflocation url="SectionDetail.cfm?SectionID=#SectionID#&AdminMsg=#URLEncodedFormat(AdminMsg)#" addtoken="no">
					<cfabort>
				</cfif>	
					
				<cfcatch>
					<cfset AdminMsg = 'FAIL: Section NOT Added - #cfcatch.Message#' >
				</cfcatch>	
			</cftry>
		<cfelse>
			<cfset AdminMsg = 'Section <cfoutput>#form.SecName#</cfoutput> Already Taken' >
		</cfif>
	<cfelse>			
		<script language="JavaScript">
			{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
		</script>
	</cfif>
</cfif>

<!--- END: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<!--- BEGIN: HEADER --->
<cfscript>
	PageTitle = 'ADD SECTION';
	QuickSearch = 1;
	QuickSearchPage = 'Sections.cfm';
	AddPage = 'SectionAdd.cfm';
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">
<!--- END: HEADER --->

<cfoutput>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr style="background-color:##65ADF1;">
		<td width="49%" colspan="2" height="20" class="cfAdminHeader1">&nbsp; SECTION INFORMATION</td>
		<td width="1%"  rowspan="20" style="background-color:##FFFFFF;">&nbsp;</td>
		<td width="50%" colspan="2" class="cfAdminHeader1">&nbsp; IMAGE INFORMATION</td>
	</tr>
	<tr>
		<td colspan="6" height="5">&nbsp;</td>
	</tr>

<cfform action="SectionAdd.cfm" method="post">
	<tr>
		<td width="10%">Site ID:</td>
		<td width="39%">
			<cfselect name="SiteID" query="getSites" size="1" value="SiteID" display="SiteName" class="cfAdminDefault" />
		</td>
		<td width="10%" rowspan="2" nowrap>Main Image Path:</td>
		<td width="40%">#application.ImagePath#/</td>
	</tr>
	<tr>
		<td>Section ID:</td>
		<td>TBD</td>
		<!---<td></td>--->
		<td><input type="text" name="SecImageDir" size="20" class="cfAdminDefault"> / not set </td>
	</tr>
	<tr>
		<td><b>Section Name:</b></td>
		<td><cfinput type="text" name="SecName" size="40" class="cfAdminDefault" required="yes" message="Section Description Required"></td>
		<td>Banner Image File:</td>
		<td><input type="text" name="SecBanner" size="20" class="cfAdminDefault"></td>
	</tr>
	<tr>
		<td><b>Parent Section:</b></td>
		<td>
			<select name="SubSectionOf" size="1" class="cfAdminDefault">
				<cfset EntryValue = '' >
				<cfinclude template="Includes/DDLSec.cfm">
			</select>
		</td>
		<td>Header Image File:</td>
		<td>
			<input type="text" name="SecImage" size="20" class="cfAdminDefault">
		</td
	></tr>
	<tr>
		<td nowrap>Available Category IDs:<br>(separated by commas) &nbsp;</td>
		<td><input type="text" name="AvailableCats" size="20" class="cfAdminDefault"> 
			<a href="##" onclick="window.open('CategoryList.cfm','CategoryList','width=425,height=375,resizable=1,scrollbars=yes')">View List</a></td>
		<td>List Image Path:</td>
		<td>#application.ImagePath#/
			<br><input type="text" name="SecFeaturedDir" size="20" class="cfAdminDefault"> / not set
		</td>
	</tr>
	<tr>
		<td>Featured On Homepage:</td>
		<td><input type="checkbox" name="Featured"></td>
		<td>List Image File:</td>
		<td>
			<input type="text" name="SecFeaturedID" size="20" class="cfAdminDefault">
		</td>
	</tr>
	<tr>
		<td>Display Order:</td>
		<td><input type="text" name="DisplayOrder" value="" size="5" class="cfAdminDefault"></td>
		<td rowspan="2">Image:</td>
		<td rowspan="2">You may upload images for this section AFTER you've added the section</td>
	</tr>
	<tr>
		<td><b>Show Product Columns:</b></td>
		<td><cfinput type="text" name="ShowColumns" size="5" class="cfAdminDefault" required="yes" message="Please enter how many product columns to show."></td>
	</tr>
	<tr>
		<td><b>Show Product Rows:</b></td>
		<td><cfinput type="text" name="ShowRows" size="5" class="cfAdminDefault" required="yes" message="Please enter how many product rows to show."></td>
		<td width="100%" colspan="2" height="20" style="background-color:##65ADF1;" class="cfAdminHeader1">&nbsp; META DATA/SEO INFORMATION</td>
	</tr>
	<tr>
		<td valign="top" colspan="2" rowspan="2">
			<br>
			Section Description:<br>
			<cfmodule 
				template="FCKeditor/fckeditor.cfm"
				basepath="FCKeditor/"
				instancename="SecDescription"
				value=''
				width="410"
				height="180"
				toolbarset="CartFusion"
			>
		</td>
		<td valign="top" colspan="2">
			<br>
			Page Title (200 characters or less recommended):<br>
			<textarea cols="50" rows="3" name="SecMetaTitle" id="SecMetaTitle"></textarea>
		</td>
	</tr>
	<tr>
		<td valign="top" colspan="2">
			Meta Description (200 characters or less recommended):<br>
			<textarea cols="50" rows="3" name="SecMetaDescription" id="SecMetaDescription"></textarea>
		</td>
	</tr>
	<tr>
		<td valign="top" colspan="2" rowspan="2">
			<br>
			Section Detail:<br>
			<cfmodule 
				template="FCKeditor/fckeditor.cfm"
				basepath="FCKeditor/"
				instancename="SecSummary"
				value=''
				width="410"
				height="180"
				toolbarset="CartFusion"
			>
		</td>
		<td colspan="2">
			Meta Keywords (1000 characters or less recommended):<br>
			<textarea cols="50" rows="3" name="SecMetaKeywords" id="SecMetaKeywords"></textarea>
		</td>
	</tr>
	<tr valign="top">
		<td colspan="2">
			Meta Keyphrases (1000 characters or less recommended):<br>
			<textarea cols="50" rows="3" name="SecMetaKeyphrases" id="SecMetaKeyphrases"></textarea>
   		</td>
	</tr>
	<tr>
		<td height="20" colspan="8"></td>
	</tr>
</table>


<!--- HIDE --->
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr><td height="20" class="cfAdminTitle">SECTION VISIBILITY</td></tr>
</table>

<table border="0" cellpadding="3" cellspacing="0">	
	<tr style="background-color:##65ADF1;">
		<cfloop query="getUsers">
			<td width="70" align="center" height="20" class="cfAdminHeader1" >
				<b>#UName#</b>
			</td>
		</cfloop>
			<td class="cfAdminHeader1"></td>
	</tr>
	<tr style="background-color:##CCCCCC;">
		<td height="1" colspan="#Val(getUsers.RecordCount + 1)#"></td>
	</tr>
	<tr class="cfAdminHeader1" bgcolor="#cfAdminHeaderColor#">
		<cfloop from="1" to="#getUsers.RecordCount#" index="i">
			<td align="center" bgcolor="<cfoutput>#IIF(((i MOD 2) is 0),DE('FFFFFF'),DE('E3E3E3'))#</cfoutput>" style="padding-left:10px; padding-right:10px;">Hide</td>
		</cfloop>
			<td bgcolor="FFFFFF">&nbsp;</td>
	</tr>	
	<tr style="background-color:##CCCCCC;">
		<td height="1" colspan="#Val(getUsers.RecordCount + 1)#"></td>
	</tr>
	<tr class="cfAdminHeader1" bgcolor="#cfAdminHeaderColor#">
		<cfloop from="1" to="#getUsers.RecordCount#" index="i">							
			<td align="center" bgcolor="#IIF(((i MOD 2) is 0),DE('FFFFFF'),DE('E3E3E3'))#">
				<input type="checkbox" name="Hide#i#" >
			</td>
		</cfloop>
			<td bgcolor="FFFFFF">&nbsp;</td>
	</tr>
	<tr style="background-color:##CCCCCC;">
		<td height="1" colspan="#Val(getUsers.RecordCount + 1)#"></td>
	</tr>
</table>

<br>

<!--- ADD Section BUTTON --->
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr style="background-color:##F27028;">
		<td colspan="5" height="20" class="cfAdminHeader3" align="center">
			ADD THIS SECTION
		</td>
	</tr>
	<tr>
		<td height="20" colspan="5"></td>
	</tr>
	<tr>
		<td colspan="5" align="center">
			<input type="submit" name="AddSection" value="ADD SECTION" alt="Add this section to the site" class="cfAdminButton">
		</td>
	</tr>
	<tr>
		<td height="20" colspan="5"></td>
	</tr>
</table>
</cfform>
</cfoutput>

<br><br><br>

<cfinclude template="LayoutAdminFooter.cfm">