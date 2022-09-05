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

<!--- BEGIN: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<cfif isDefined('form.UpdateSectionInfo') AND IsDefined("form.SectionID")>
	<cfif IsUserInRole('Administrator')>
		<cftry>
			<cfscript>
				Form.SecName = Replace(Form.SecName, '"' , "''", "ALL") ;
				Form.DateUpdated = Now() ;
				Form.UpdatedBy = GetAuthUser() ;
			</cfscript>
			<cfupdate datasource="#application.dsn#" tablename="Sections" 
				formfields="SiteID, SectionID, SubSectionOf, SecName, SecDescription, SecSummary, SecImageDir, SecImage, SecFeaturedDir, SecFeaturedID,
					SecMetaTitle, SecMetaDescription, SecMetaKeywords, SecMetaKeyphrases,
					SecBanner, AvailableCats, Comments, DisplayOrder, ShowColumns, ShowRows, Featured, DateUpdated, UpdatedBy">
				<cfset AdminMsg = 'Section "#form.SecName#" Information Updated' >
			
			<cfcatch>
				<cfset AdminMsg = 'FAIL: Section NOT Updated. Reason: #cfcatch#' >
			</cfcatch>
		</cftry>
	<cfelse>			
		<script language="JavaScript">
			{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
		</script>
	</cfif>
</cfif>

<!--- END: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<!--- BEGIN: QUERIES ------------------------------------->
<cfinvoke component="#Queries#" method="getSection" returnvariable="getSection">
	<cfinvokeargument name="SectionID" value="#SectionID#">
</cfinvoke>
<cfinvoke component="#Queries#" method="getSites" returnvariable="getSites"></cfinvoke>
<cfinvoke component="#Queries#" method="getUsers" returnvariable="getUsers"></cfinvoke>

<!--- END: QUERIES ------------------------------------->

<!--- BEGIN: HEADER --->
<cfscript>
	PageTitle = 'SECTION DETAIL';
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
		<td width="1%"  rowspan="15" style="background-color:##FFFFFF;">&nbsp;</td>
		<td width="50%" colspan="2" class="cfAdminHeader1">&nbsp; IMAGE INFORMATION</td>
	</tr>
	<tr>
		<td colspan="6" height="5">&nbsp;</td>
	</tr>
</cfoutput>

<cfoutput query="getSection">			
<cfform action="SectionDetail.cfm" method="post">
	<tr>
		<td width="10%">Site ID:</td>
		<td width="39%">
			<cfselect name="SiteID" query="getSites" size="1"
				value="SiteID" display="SiteName" selected="#SiteID#" class="cfAdminDefault" />
		</td>
		<td width="10%" rowspan="2" nowrap>Main Image Path:</td>
		<td width="40%">#application.ImagePath#/</td>
	</tr>
	<tr>
		<td>Section ID:</td>
		<td>#SectionID#</td>
		<!---<td></td>--->
		<td>
			<input type="text" name="SecImageDir" value="#SecImageDir#" size="20" class="cfAdminDefault">
			<cfif SecImage IS ''>
				/ not set
			<cfelse>
				/ #SecImage#
			</cfif>
		</td>
	</tr>
	<tr>
		<td><b>Section Name:</b></td>
		<td><cfinput type="text" name="SecName" value="#SecName#" size="40" class="cfAdminDefault" required="yes" message="Section Description Required"></td>
		<td>Banner Image File:</td>
		<td>
			<input type="text" name="SecBanner" value="#SecBanner#" size="20" class="cfAdminDefault">
			<input type="button" name="NewSecBanner" value="UPLOAD" alt="Upload New Section Banner" class="cfAdminButton"
				onclick="document.location.href='ImageUpload.cfm?Image=SecBanner&ImageDir=#URLEncodedFormat(SecImageDir)#&ImageID=#SectionID#&SiteID=#SiteID#&Table=Sections&ColumnID=SectionID'">
		</td>
	</tr>
	<tr>
		<td><b>Parent Section:</b></td>
		<td>
			<select name="SubSectionOf" size="1" class="cfAdminDefault">
				<cfset EntryValue = SubSectionOf >
				<cfinclude template="Includes/DDLSec.cfm">
			</select>
		</td>
		<td>Header Image File:</td>
		<td>
			<input type="text" name="SecImage" value="#SecImage#" size="20" class="cfAdminDefault">
			<input type="button" name="NewSecImage" value="UPLOAD" alt="Upload New Section List Image" class="cfAdminButton"
				onclick="document.location.href='ImageUpload.cfm?Image=SecImage&ImageDir=#URLEncodedFormat(SecImageDir)#&ImageID=#SectionID#&SiteID=#SiteID#&Table=Sections&ColumnID=SectionID'">
		</td>
	</tr>
	<tr>
		<td nowrap>Available Category IDs:<br>(separated by commas) &nbsp;</td>
		<td><input type="text" name="AvailableCats" value="#AvailableCats#" size="20" class="cfAdminDefault"> 
			<a href="##" onclick="window.open('CategoryList.cfm','CategoryList','width=425,height=375,resizable=1,scrollbars=yes')">View List</a></td>
		<td>List Image Path:</td>
		<td>#application.ImagePath#/
			<br><input type="text" name="SecFeaturedDir" value="#SecFeaturedDir#" size="20" class="cfAdminDefault">
			<cfif SecImage IS ''>
				/ not set
			<cfelse>
				/ #SecFeaturedID#
			</cfif>
		</td>
	</tr>
	<tr>
		<td>Featured On Homepage:</td>
		<td><input type="checkbox" name="Featured" <cfif Featured EQ 1> checked </cfif>></td>
		<td>List Image File:</td>
		<td>
			<input type="text" name="SecFeaturedID" value="#SecFeaturedID#" size="20" class="cfAdminDefault">
			<input type="button" name="NewSecFeaturedID" value="UPLOAD" alt="Upload New Section Featured Item" class="cfAdminButton"
				onclick="document.location.href='ImageUpload.cfm?Image=SecFeaturedID&ImageDir=#URLEncodedFormat(SecFeaturedDir)#&ImageID=#SectionID#&SiteID=#SiteID#&Table=Sections&ColumnID=SectionID'">
		</td>
	</tr>
	<tr>
		<td>Display Order:</td>
		<td><input type="text" name="DisplayOrder" value="#DisplayOrder#" size="5" class="cfAdminDefault"></td>
		<td rowspan="2">Image:</td>
		<td rowspan="2">
			<cfif SecImage IS ''><b>NO IMAGE SET</b>
			<cfelse><a href="#application.ImagePath#/#SecImageDir#/#SecImage#" target="_blank"><img src="#application.ImagePath#/#SecImageDir#/#SecImage#" height="40" border="0"></a>
			</cfif>
		</td>
	</tr>
	<tr>
		<td><b>Show Product Columns:</b></td>
		<td><cfinput type="text" name="ShowColumns" value="#ShowColumns#" size="5" class="cfAdminDefault" required="yes" message="Please enter how many product columns to show."></td>
	</tr>
	<tr>
		<td><b>Show Product Rows:</b></td>
		<td><cfinput type="text" name="ShowRows" value="#ShowRows#" size="5" class="cfAdminDefault" required="yes" message="Please enter how many product rows to show."></td>
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
				value='#SecDescription#'
				width="410"
				height="180"
				toolbarset="CartFusion"
			>
		</td>
		<td valign="top" colspan="2">
			<br>
			Page Title (200 characters or less recommended):<br>
			<textarea cols="50" rows="3" name="SecMetaTitle" id="SecMetaTitle">#SecMetaTitle#</textarea>
		</td>
	</tr>
	<tr>
		<td valign="top" colspan="2">
			Meta Description (200 characters or less recommended):<br>
			<textarea cols="50" rows="3" name="SecMetaDescription" id="SecMetaDescription">#SecMetaDescription#</textarea>
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
				value='#SecSummary#'
				width="410"
				height="180"
				toolbarset="CartFusion"
			>
		</td>
		<td colspan="2">
			Meta Keywords (1000 characters or less recommended):<br>
			<textarea cols="50" rows="3" name="SecMetaKeywords" id="SecMetaKeywords">#SecMetaKeywords#</textarea>
		</td>
	</tr>
	<tr valign="top">
		<td colspan="2">
			Meta Keyphrases (1000 characters or less recommended):<br>
			<textarea cols="50" rows="3" name="SecMetaKeyphrases" id="SecMetaKeyphrases">#SecMetaKeyphrases#</textarea>
   		</td>
	</tr>
	<tr>
		<td height="20" colspan="8"></td>
	</tr>
	<tr style="background-color:##F27028;">
		<td colspan="8" height="20" class="cfAdminHeader3" align="center">
			UPDATE ABOVE INFORMATION
		</td>
	</tr>
	<tr>
		<td height="20" colspan="8"></td>
	</tr>
	<tr>
		<td colspan="8" align="center">
			<input type="submit" name="UpdateSectionInfo" value="UPDATE CHANGES" alt="Update Section Information" class="cfAdminButton">
		</td>
	</tr>
</table>


<!--- HIDE --->
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr><td height="20" class="cfAdminTitle">SECTION VISIBILITY</td></tr>
</table>

<table border="0" cellpadding="3" cellspacing="0">	
	<tr style="background-color:##7DBF0E;">
		<cfloop query="getUsers">
			<td width="70" align="center" height="20" class="cfAdminHeader2" >
				<b>#UName#</b>
			</td>
		</cfloop>
			<td class="cfAdminHeader2"></td>
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
			<cfscript>
				ThisHide  = #Evaluate("Hide" & i)#;
			</cfscript>										
			<td align="center" bgcolor="#IIF(((i MOD 2) is 0),DE('FFFFFF'),DE('E3E3E3'))#">
				<input type="checkbox" name="Hide#i#" onclick="updateInfo(#SectionID#,this.value,'Hide#i#','Sections');" <cfif ThisHide EQ 1> checked </cfif> >
			</td>
		</cfloop>
			<td bgcolor="FFFFFF">&nbsp;</td>
	</tr>
	<tr style="background-color:##CCCCCC;">
		<td height="1" colspan="#Val(getUsers.RecordCount + 1)#"></td>
	</tr>
</table>
<input type="hidden" name="SectionID" value="#SectionID#">
</cfform>
</cfoutput>

<br><br><br>

<cfinclude template="LayoutAdminFooter.cfm">