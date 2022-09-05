<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<cfif NOT isDefined('URL.Image') OR
	  NOT isDefined('URL.ImageDir') OR
	  NOT isDefined('URL.ImageID') OR
	  NOT isDefined('URL.SiteID') OR
	  NOT isDefined('URL.Table')>
	<div align="center" class="cfAdminError">ALL INFORMATION NEEDED HAS NOT BEEN PROVIDED</div>
	<cfabort>
</cfif>

<!--- BEGIN: HEADER --->
<cfscript>
	PageTitle = 'IMAGE UPLOAD';
	QuickSearch = 0;
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">
<!--- END: HEADER --->


<!--- IMAGE FOR PRODUCT MATRIX --->
<cfif URL.Image EQ 'Matrix'>
	<!--- IF UPLOADING PRODUCT IMAGE --->
	<cfoutput>
	<form action="ImageUploadAction.cfm?ItemID=#URL.ItemID#&Image=#URL.Image#&ImageDir=#URL.ImageDir#&ImageID=#URL.ImageID#&SiteID=#URL.SiteID#&Table=#URL.Table#&ColumnID=#URL.ColumnID#" method="POST" enctype="multipart/form-data">
		<table>
			<tr>
				<td rowspan="3" style="padding:20px;">
					<cfquery name="getImage" datasource="#application.dsn#">
						SELECT  Image AS TheImage, Detail1 AS ImageBeingSet
						FROM	ItemClassComponents
						WHERE	ICCID = #URL.ImageID#
					</cfquery>
					
					Current <b>Product Option Image</b>
					
					File:<br><br>
					<cfif getImage.TheImage EQ ''>
						NO IMAGE SET 
						<cfif isDefined('getImage.ImageBeingSet') AND getImage.ImageBeingSet NEQ '' >
							FOR <b>#getImage.ImageBeingSet#</b>
						</cfif>
					<cfelse>
						<cfif getImage.ImageBeingSet NEQ '' >
							<img src="#application.ImagePath#/#URL.ImageDir#/#getImage.TheImage#" border="0"><br><br>
							IMAGE FOR <b>#getImage.ImageBeingSet#</b>
						</cfif>
						
					</cfif>
				</td>
			</tr>
			<tr>
				<td>New File:</td>
				<td><input type="file" name="FileToUpload" size="25" maxlength="255" class="cfAdminDefault"></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="submit" name="Submit" value="Upload" class="cfAdminDefault"></td>
			</tr>
		</table>
	</form>
	</cfoutput>

<!--- IMAGE NOT FOR PRODUCT MATRIX --->
<cfelse>
	<!--- IF UPLOADING PRODUCT IMAGE --->
	<cfoutput>
	<form action="ImageUploadAction.cfm?Image=#URL.Image#&ImageDir=#URL.ImageDir#&ImageID=#URL.ImageID#&SiteID=#URL.SiteID#&Table=#URL.Table#&ColumnID=#URL.ColumnID#" method="POST" enctype="multipart/form-data">
		<table>
			<tr>
				<td rowspan="3" style="padding:20px;">
					<cfquery name="getImage" datasource="#application.dsn#">
						SELECT  #URL.Image# AS TheImage, SiteID 
						<cfif URL.Table EQ 'Products' >
							, SKU + ': ' + ItemName AS ImageBeingSet
						<cfelseif URL.Table EQ 'Categories' >
							, CatName AS ImageBeingSet
						<cfelseif URL.Table EQ 'Sections' >
							, SecName AS ImageBeingSet
						<cfelseif URL.Table EQ 'ParentCategories' >
							, PCName AS ImageBeingSet
						<cfelseif URL.Table EQ 'ParentSections' >
							, PSName AS ImageBeingSet
						</cfif>
						FROM	#URL.Table#
						WHERE	#URL.ColumnID# = #URL.ImageID#
					</cfquery>
					
					Current 
						<cfswitch expression="#URL.Image#">
							<cfcase value="Image"><b>Main Image</b></cfcase>
							<cfcase value="ImageLarge"><b>Large Image</b></cfcase>
							<cfcase value="ImageSmall"><b>Small Image</b></cfcase>
							<cfcase value="CatImage"><b>Category Header Image</b></cfcase>
							<cfcase value="CatBanner"><b>Category Banner Image</b></cfcase>
							<cfcase value="CatFeaturedID"><b>Category List Image</b></cfcase>
							<cfcase value="SecImage"><b>Section Header Image</b></cfcase>
							<cfcase value="SecBanner"><b>Section Banner Image</b></cfcase>
							<cfcase value="SecFeaturedID"><b>Section List Image</b></cfcase>
							<cfcase value="PCImage"><b>Parent Category Image</b></cfcase>
							<cfcase value="PSImage"><b>Parent Section Image</b></cfcase>
							<cfdefaultcase>Image</cfdefaultcase>
						</cfswitch>
					File:<br><br>
					<cfif getImage.TheImage EQ ''>
						NO IMAGE SET 
						<cfif isDefined('getImage.ImageBeingSet') AND getImage.ImageBeingSet NEQ '' >
							FOR <b>#getImage.ImageBeingSet#</b>
						</cfif>
					<cfelse>
						<cfif getImage.ImageBeingSet NEQ '' >
							<img src="#application.ImagePath#/#URL.ImageDir#/#getImage.TheImage#" border="0"><br><br>
							IMAGE FOR <b>#getImage.ImageBeingSet#</b>
						</cfif>
						
					</cfif>
				</td>
			</tr>
			<tr>
				<td>New File:</td>
				<td><input type="file" name="FileToUpload" size="25" maxlength="255" class="cfAdminDefault"></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="submit" name="Submit" value="Upload" class="cfAdminDefault"></td>
			</tr>
		</table>
	</form>
	</cfoutput>   
</cfif><!--- IMAGE IS FOR PRODUCT MATRIX ? --->

<cfinclude template="LayoutAdminFooter.cfm">