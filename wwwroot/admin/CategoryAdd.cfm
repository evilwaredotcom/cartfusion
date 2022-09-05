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
<cfinvoke component="#Queries#" method="getCategories" returnvariable="getCategories"></cfinvoke>
<cfinvoke component="#Queries#" method="getUsers" returnvariable="getUsers"></cfinvoke>
<!--- END: QUERIES ------------------------------------->

<!--- BEGIN: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<cfif isDefined('form.AddCategory')>
	<cfif IsUserInRole('Administrator')>	
		<!--- PREVENT DUPLICATE --->
		<cfquery name="preventDuplicates" datasource="#application.dsn#">
			SELECT 	CatName
			FROM	Categories	
			WHERE	CatName = '#Form.CatName#'
			<cfif isDefined('Form.SubCategoryOf') AND Form.SubCategoryOf NEQ '' >
			AND		SubCategoryOf = #Form.SubCategoryOf#
			</cfif>
			AND		SiteID = #Form.SiteID#
		</cfquery>
		<cfif preventDuplicates.RecordCount EQ 0>
			<cftry>
				<cfscript>
					Form.CatName = Replace(Form.CatName, '"' , "''", "ALL") ;
					Form.DateCreated = Now() ;
					Form.DateUpdated = Now() ;
					Form.UpdatedBy = GetAuthUser() ;
				</cfscript>
				<cfinsert datasource="#application.dsn#" tablename="Categories" 
					formfields="SiteID, CatName, SubCategoryOf, CatDescription, CatSummary, CatImage, CatImageDir, CatFeaturedDir, CatFeaturedID,
					CatMetaTitle, CatMetaDescription, CatMetaKeywords, CatMetaKeyphrases,
					CatBanner, AvailableSections, Comments, DisplayOrder, ShowColumns, ShowRows, Featured, DateCreated, DateUpdated, UpdatedBy ">
					
				<!--- GET NEWLY ASSIGNED SKU NUMBER --->
				<cfquery name="getAddedCategoryID" datasource="#application.dsn#">
					SELECT	MAX(CatID) AS CatID
					FROM	Categories
				</cfquery>

				<cfif getAddedCategoryID.RecordCount NEQ 0>
					<!--- UPDATE PRICES NOW --->
					<!--- SET HIDES TO 0 OR 1 --->
					<cfloop from="1" to="#getUsers.RecordCount#" index="i">
						<cfif isDefined('Form.Hide#i#')><cfset 'Form.Hide#i#' = 1>
						<cfelse><cfset 'Form.Hide#i#' = 0>
						</cfif>
					</cfloop>
					<cfquery name="setCategoryHides" datasource="#application.dsn#">
						UPDATE 	Categories
						SET
						<cfloop from="1" to="#getUsers.RecordCount#" index="i">
							Hide#i#  = #Evaluate('Form.Hide' & i)#,
						</cfloop>
							UpdatedBy = '#Form.UpdatedBy#'
						WHERE	CatID = #getAddedCategoryID.CatID#
					</cfquery>
				
					<cfset CatID = getAddedCategoryID.CatID>
					<cfset AdminMsg = 'Category <cfoutput>#form.CatName#</cfoutput> Added Sucessfully' >
					<cflocation url="CategoryDetail.cfm?CatID=#CatID#&AdminMsg=#URLEncodedFormat(AdminMsg)#" addtoken="no">
					<cfabort>
				</cfif>	
					
				<cfcatch>
					<cfset AdminMsg = 'FAIL: Category NOT Added - #cfcatch.Message#' >
				</cfcatch>	
			</cftry>
		<cfelse>
			<cfset AdminMsg = 'Category <cfoutput>#form.CatName#</cfoutput> Already Taken' >
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
	PageTitle = 'ADD CATEGORY';
	QuickSearch = 1;
	QuickSearchPage = 'Categories.cfm';
	AddPage = 'CategoryAdd.cfm';
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">
<!--- END: HEADER --->

<cfoutput>
<cfform action="CategoryAdd.cfm" method="post">

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr style="background-color:##65ADF1;">
		<td width="49%" colspan="2" height="20" class="cfAdminHeader1">&nbsp; CATEGORY INFORMATION</td>
		<td width="1%"  rowspan="20" style="background-color:##FFFFFF;">&nbsp;</td>
		<td width="50%" colspan="2" class="cfAdminHeader1">&nbsp; IMAGE INFORMATION</td>
	</tr>
	<tr>
		<td colspan="6" height="5">&nbsp;</td>
	</tr>
	<tr>
		<td width="10%">Site ID:</td>
		<td width="39%">
			<cfselect name="SiteID" query="getSites" size="1" value="SiteID" display="SiteName" class="cfAdminDefault" />
		</td>
		<td width="10%" rowspan="2" nowrap>Main Image Path:</td>
		<td width="40%">#application.ImagePath#/</td>
	</tr>
	<tr>
		<td>Category ID:</td>
		<td>TBD</td>
		<!---<td></td>--->
		<td><input type="text" name="CatImageDir" size="20" class="cfAdminDefault"> / not set </td>
	</tr>
	<tr>
		<td><b>Category Name:</b></td>
		<td><cfinput type="text" name="CatName" size="40" class="cfAdminDefault" required="yes" message="Category Description Required"></td>
		<td>Banner Image File:</td>
		<td><input type="text" name="CatBanner" size="20" class="cfAdminDefault"></td>
	</tr>
	<tr>
		<td><b>Parent Category:</b></td>
		<td>
			<select name="SubCategoryOf" size="1" class="cfAdminDefault">
				<cfset EntryValue = '' >
				<cfinclude template="Includes/DDLCat.cfm">
			</select>
		</td>
		<td>Header Image File:</td>
		<td>
			<input type="text" name="CatImage" size="20" class="cfAdminDefault">
		</td>
	</tr>
	<tr>
		<td nowrap>Available Section IDs:<br>(separated by commas) &nbsp;</td>
		<td><input type="text" name="AvailableSections" size="20" class="cfAdminDefault"> 
			<a href="##" onclick="window.open('SectionList.cfm','SectionList','width=425,height=375,resizable=1,scrollbars=yes')">View List</a></td>
		<td>List Image Path:</td>
		<td>#application.ImagePath#/
			<br><input type="text" name="CatFeaturedDir" size="20" class="cfAdminDefault"> / not set
		</td>
	</tr>
	<tr>
		<td>Featured On Homepage:</td>
		<td><input type="checkbox" name="Featured"></td>
		<td>List Image File:</td>
		<td>
			<input type="text" name="CatFeaturedID" size="20" class="cfAdminDefault">
		</td>
	</tr>
	<tr>
		<td>Display Order:</td>
		<td><input type="text" name="DisplayOrder" value="" size="5" class="cfAdminDefault"></td>
		<td rowspan="2">Image:</td>
		<td rowspan="2">You may upload images for this category AFTER you've added the category</td>
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
			Category Description:<br>
			<cfmodule 
				template="FCKeditor/fckeditor.cfm"
				basepath="FCKeditor/"
				instancename="CatDescription"
				value=''
				width="410"
				height="180"
				toolbarset="CartFusion"
			>
		</td>
		<td valign="top" colspan="2">
			<br>
			Page Title (200 characters or less recommended):<br>
			<textarea cols="50" rows="3" name="CatMetaTitle" id="CatMetaTitle"></textarea>
		</td>
	</tr>
	<tr>
		<td valign="top" colspan="2">
			Meta Description (200 characters or less recommended):<br>
			<textarea cols="50" rows="3" name="CatMetaDescription" id="CatMetaDescription"></textarea>
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
				value=''
				width="410"
				height="180"
				toolbarset="CartFusion"
			>
		</td>
		<td colspan="2">
			Meta Keywords (1000 characters or less recommended):<br>
			<textarea cols="50" rows="3" name="CatMetaKeywords" id="CatMetaKeywords"></textarea>
		</td>
	</tr>
	<tr valign="top">
		<td colspan="2">
			Meta Keyphrases (1000 characters or less recommended):<br>
			<textarea cols="50" rows="3" name="CatMetaKeyphrases" id="CatMetaKeyphrases"></textarea>
   		</td>
	</tr>
	<tr>
		<td height="20" colspan="8"></td>
	</tr>
</table>


<!--- HIDE --->
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr><td height="20" class="cfAdminTitle">CATEGORY VISIBILITY</td></tr>
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

<!--- ADD CATEGORY BUTTON --->
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr style="background-color:##F27028;">
		<td colspan="5" height="20" class="cfAdminHeader3" align="center">
			ADD THIS CATEGORY
		</td>
	</tr>
	<tr>
		<td height="20" colspan="5"></td>
	</tr>
	<tr>
		<td colspan="5" align="center">
			<input type="submit" name="AddCategory" value="ADD CATEGORY" alt="Add this category to the site" class="cfAdminButton">
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