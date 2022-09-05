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

<cfif isDefined('form.UpdateCategoryInfo') AND IsDefined("form.CatID")>
	<cfif IsUserInRole('Administrator')>
		<cftry>
			<cfscript>
				Form.CatName = Replace(Form.CatName, '"' , "''", "ALL") ;
				Form.DateUpdated = Now() ;
				Form.UpdatedBy = GetAuthUser() ;
			</cfscript>	
			<cfupdate datasource="#application.dsn#" tablename="Categories" 
				formfields="SiteID, CatID, SubCategoryOf, CatName, CatDescription, CatSummary, CatImageDir, CatImage, CatFeaturedDir, CatFeaturedID,
					CatMetaTitle, CatMetaDescription, CatMetaKeywords, CatMetaKeyphrases,
					CatBanner, AvailableSections, Comments, DisplayOrder, ShowColumns, ShowRows, Featured, DateUpdated, UpdatedBy">
				<cfset AdminMsg = 'Category #form.CatName# Information Updated' >
			
			<cfcatch>
				<cfset AdminMsg = 'FAIL: Category NOT Updated. Reason: #cfcatch#' >
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
<cfinvoke component="#Queries#" method="getCategory" returnvariable="getCategory">
	<cfinvokeargument name="CatID" value="#CatID#">
</cfinvoke>
<cfinvoke component="#Queries#" method="getSites" returnvariable="getSites"></cfinvoke>
<cfinvoke component="#Queries#" method="getUsers" returnvariable="getUsers"></cfinvoke>
<!--- END: QUERIES ------------------------------------->

<!--- BEGIN: HEADER --->
<cfscript>
	PageTitle = 'CATEGORY DETAIL';
	QuickSearch = 1;
	QuickSearchPage = 'Categories.cfm';
	AddPage = 'CategoryAdd.cfm';
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">
<!--- END: HEADER --->

<cfoutput>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr style="background-color:##65ADF1;">
		<td width="49%" colspan="2" height="20" class="cfAdminHeader1">&nbsp; CATEGORY INFORMATION</td>
		<td width="1%"  rowspan="15" style="background-color:##FFFFFF;">&nbsp;</td>
		<td width="50%" colspan="2" class="cfAdminHeader1">&nbsp; IMAGE INFORMATION</td>
	</tr>
	<tr>
		<td colspan="6" height="5">&nbsp;</td>
	</tr>
</cfoutput>

<cfoutput query="getCategory">			
<cfform action="CategoryDetail.cfm" method="post">
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
		<td>Category ID:</td>
		<td>#CatID#</td>
		<!---<td></td>--->
		<td>
			<input type="text" name="CatImageDir" value="#CatImageDir#" size="20" class="cfAdminDefault">
			<cfif CatImage IS ''>
				/ not set
			<cfelse>
				/ #CatImage#
			</cfif>
		</td>
	</tr>
	<tr>
		<td><b>Category Name:</b></td>
		<td><cfinput type="text" name="CatName" value="#CatName#" size="40" class="cfAdminDefault" required="yes" message="Category Description Required"></td>
		<td>Banner Image File:</td>
		<td>
			<input type="text" name="CatBanner" value="#CatBanner#" size="20" class="cfAdminDefault">
			<input type="button" name="NewCatBanner" value="UPLOAD" alt="Upload New Category Banner" class="cfAdminButton"
				onclick="document.location.href='ImageUpload.cfm?Image=CatBanner&ImageDir=#URLEncodedFormat(CatImageDir)#&ImageID=#CatID#&SiteID=#SiteID#&Table=Categories&ColumnID=CatID'">
		</td>
	</tr>
	<tr>
		<td><b>Parent Category:</b></td>
		<td>
			<select name="SubCategoryOf" size="1" class="cfAdminDefault">
				<cfset EntryValue = SubCategoryOf >
				<cfinclude template="Includes/DDLCat.cfm">
			</select>
		</td>
		<td>Header Image File:</td>
		<td>
			<input type="text" name="CatImage" value="#CatImage#" size="20" class="cfAdminDefault">
			<input type="button" name="NewCatImage" value="UPLOAD" alt="Upload New Category List Image" class="cfAdminButton"
				onclick="document.location.href='ImageUpload.cfm?Image=CatImage&ImageDir=#URLEncodedFormat(CatImageDir)#&ImageID=#CatID#&SiteID=#SiteID#&Table=Categories&ColumnID=CatID'">
		</td>
	</tr>
	<tr>
		<td nowrap>Available Section IDs:<br>(separated by commas) &nbsp;</td>
		<td><input type="text" name="AvailableSections" value="#AvailableSections#" size="20" class="cfAdminDefault"> 
			<a href="##" onclick="window.open('SectionList.cfm','SectionList','width=425,height=375,resizable=1,scrollbars=yes')">View List</a></td>
		<td>List Image Path:</td>
		<td>#application.ImagePath#/
			<br><input type="text" name="CatFeaturedDir" value="#CatFeaturedDir#" size="20" class="cfAdminDefault">
			<cfif CatImage IS ''>
				/ not set
			<cfelse>
				/ #CatFeaturedID#
			</cfif>
		</td>
	</tr>
	<tr>
		<td>Featured On Homepage:</td>
		<td><input type="checkbox" name="Featured" <cfif Featured EQ 1> checked </cfif>></td>
		<td>List Image File:</td>
		<td>
			<input type="text" name="CatFeaturedID" value="#CatFeaturedID#" size="20" class="cfAdminDefault">
			<input type="button" name="NewCatFeaturedID" value="UPLOAD" alt="Upload New Category Featured Item" class="cfAdminButton"
				onclick="document.location.href='ImageUpload.cfm?Image=CatFeaturedID&ImageDir=#URLEncodedFormat(CatFeaturedDir)#&ImageID=#CatID#&SiteID=#SiteID#&Table=Categories&ColumnID=CatID'">
		</td>
	</tr>
	<tr>
		<td>Display Order:</td>
		<td><input type="text" name="DisplayOrder" value="#DisplayOrder#" size="5" class="cfAdminDefault"></td>
		<td rowspan="2">Image:</td>
		<td rowspan="2">
			<cfif CatImage IS ''><b>NO IMAGE SET</b>
			<cfelse><a href="#application.ImagePath#/#CatImageDir#/#CatImage#" target="_blank"><img src="#application.ImagePath#/#CatImageDir#/#CatImage#" height="40" border="0"></a>
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
			Category Description:<br>
			<cfmodule 
				template="FCKeditor/fckeditor.cfm"
				basepath="FCKeditor/"
				instancename="CatDescription"
				value='#CatDescription#'
				width="410"
				height="180"
				toolbarset="CartFusion"
			>
		</td>
		<td valign="top" colspan="2">
			<br>
			Page Title (200 characters or less recommended):<br>
			<textarea cols="50" rows="3" name="CatMetaTitle" id="CatMetaTitle">#CatMetaTitle#</textarea>
		</td>
	</tr>
	<tr>
		<td valign="top" colspan="2">
			Meta Description (200 characters or less recommended):<br>
			<textarea cols="50" rows="3" name="CatMetaDescription" id="CatMetaDescription">#CatMetaDescription#</textarea>
		</td>
	</tr>
	<tr>
		<td valign="top" colspan="2" rowspan="2">
			<br>
			Category Detail:<br>
			<cfmodule 
				template="FCKeditor/fckeditor.cfm"
				basepath="FCKeditor/"
				instancename="CatSummary"
				value='#CatSummary#'
				width="410"
				height="180"
				toolbarset="CartFusion"
			>
		</td>
		<td colspan="2">
			Meta Keywords (1000 characters or less recommended):<br>
			<textarea cols="50" rows="3" name="CatMetaKeywords" id="CatMetaKeywords">#CatMetaKeywords#</textarea>
		</td>
	</tr>
	<tr valign="top">
		<td colspan="2">
			Meta Keyphrases (1000 characters or less recommended):<br>
			<textarea cols="50" rows="3" name="CatMetaKeyphrases" id="CatMetaKeyphrases">#CatMetaKeyphrases#</textarea>
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
			<input type="submit" name="UpdateCategoryInfo" value="UPDATE CHANGES" alt="Update Category Information" class="cfAdminButton">
		</td>
	</tr>
	<tr><td colspan="2" height="5">&nbsp;</td></tr>
</table>


<!--- HIDE --->
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr><td height="20" class="cfAdminTitle">CATEGORY VISIBILITY</td></tr>
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
	<tr style="background-color:#cfAdminHeaderColor#;">
		<cfloop from="1" to="#getUsers.RecordCount#" index="i">
			<td align="center" bgcolor="<cfoutput>#IIF(((i MOD 2) is 0),DE('FFFFFF'),DE('E3E3E3'))#</cfoutput>" style="padding-left:10px; padding-right:10px;">Hide</td>
		</cfloop>
			<td bgcolor="FFFFFF"></td>
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
				<input type="checkbox" name="Hide#i#" onclick="updateInfo(#CatID#,this.value,'Hide#i#','Categories');" <cfif ThisHide EQ 1> checked </cfif> >
			</td>
		</cfloop>
			<td bgcolor="FFFFFF"></td>
	</tr>
	<tr style="background-color:##CCCCCC;">
		<td height="1" colspan="#Val(getUsers.RecordCount + 1)#"></td>
	</tr>
</table>
<input type="hidden" name="CatID" value="#CatID#">
</cfform>
</cfoutput>

<br><br><br>

<cfinclude template="LayoutAdminFooter.cfm">