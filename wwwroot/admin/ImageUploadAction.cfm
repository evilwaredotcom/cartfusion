<!--- Check the CGI environment variable content_length to make sure the file
	  being uploaded is less than 100k in size.  If it is not, halt 
	  processing --->
<cfif Val(CGI.content_length) gt 1000000>
	The file you are attempting to upload exceeds the maximum allowable size of 
	100k and cannot be uploaded to this server!  Please choose a smaller file and 
	try again.
	<cfabort>
</cfif>

<!--- IMAGE FOR PRODUCT MATRIX --->
<cfif URL.Image EQ 'Matrix'>

	<!--- Use the cffile tag to upload the file passed from the form to our ColdFusion server --->
	<cfif isUserInRole('Administrator')>
		<cftry>
			
			<cffile action="Upload"
				filefield="FileToUpload"
				destination="#application.ImageServerPath#/#URL.ImageDir#"
				nameconflict="Overwrite"
				accept="image/gif,image/jpg,image/jpeg,image/pjpeg,image/png,image/bmp"
				attributes="Normal">
				
			<cfquery name="updateImage" datasource="#application.dsn#">
				UPDATE 	ItemClassComponents
				SET		Image = '#cffile.ServerFile#'
				WHERE	ICCID = #URL.ImageID#
			</cfquery>
			
			<cfcatch>
				<!--- UPDATE IMAGE FAIL --->
				<cfoutput>
					<cflocation url="ProductMatrix.cfm?ItemID=#URL.ItemID#&ErrorMsg=2" addtoken="no">
				</cfoutput>
			</cfcatch>
		</cftry>
		
		<!--- UPDATE IMAGE SUCCESSFUL --->
		<cfoutput>
			<cflocation url="ProductMatrix.cfm?ItemID=#URL.ItemID#" addtoken="no">
		</cfoutput>
	
	<cfelse>
		<!--- USER NOT ALLOWED TO ADD IMAGE --->
		<cfoutput>
			<cflocation url="ProductMatrix.cfm?ItemID=#URL.ItemID#&ErrorMsg=1" addtoken="no">
		</cfoutput>
	</cfif>

<!--- IMAGE NOT FOR PRODUCT MATRIX --->
<cfelse>
	<!--- Use the cffile tag to upload the file passed from the form to our ColdFusion server --->
	<cfif isUserInRole('Administrator')>
		<cftry>
			
			<cffile action="Upload"
				filefield="FileToUpload"
				destination="#application.ImageServerPath#/#URL.ImageDir#"
				nameconflict="Overwrite"
				accept="image/gif,image/jpg,image/jpeg,image/pjpeg,image/png,image/bmp"
				attributes="Normal">
				
			<cfquery name="updateImage" datasource="#application.dsn#">
				UPDATE 	#URL.Table#
				SET		#URL.Image# = '#cffile.ServerFile#'
				WHERE	#URL.ColumnID# = #URL.ImageID#
			</cfquery>
			
			<cfcatch>
				<!--- UPDATE IMAGE FAIL --->
				<cfoutput>
				<cfswitch expression="#URL.Table#">
					<cfcase value="Products">
						<cflocation url="ProductDetail.cfm?ItemID=#URL.ImageID#&ErrorMsg=2" addtoken="no">
					</cfcase>
					<cfcase value="Categories">
						<cflocation url="CategoryDetail.cfm?CatID=#URL.ImageID#&ErrorMsg=2" addtoken="no">
					</cfcase>
					<cfcase value="Sections">
						<cflocation url="SectionDetail.cfm?SectionID=#URL.ImageID#&ErrorMsg=2" addtoken="no">
					</cfcase>
					<cfcase value="ParentCategories">
						<cflocation url="ParentCategoryDetail.cfm?PCID=#URL.ImageID#&ErrorMsg=2" addtoken="no">
					</cfcase>
					<cfcase value="ParentSections">
						<cflocation url="ParentSectionDetail.cfm?PSID=#URL.ImageID#&ErrorMsg=2" addtoken="no">
					</cfcase>
				</cfswitch>
				</cfoutput>
			</cfcatch>
		</cftry>
		
		<!--- UPDATE IMAGE SUCCESSFUL --->
		<cfoutput>
		<cfswitch expression="#URL.Table#">
			<cfcase value="Products">
				<cflocation url="ProductDetail.cfm?ItemID=#URL.ImageID#" addtoken="no">
			</cfcase>
			<cfcase value="Categories">
				<cflocation url="CategoryDetail.cfm?CatID=#URL.ImageID#" addtoken="no">
			</cfcase>
			<cfcase value="Sections">
				<cflocation url="SectionDetail.cfm?SectionID=#URL.ImageID#" addtoken="no">
			</cfcase>
			<cfcase value="ParentCategories">
				<cflocation url="ParentCategoryDetail.cfm?PCID=#URL.ImageID#" addtoken="no">
			</cfcase>
			<cfcase value="ParentSections">
				<cflocation url="ParentSectionDetail.cfm?PSID=#URL.ImageID#" addtoken="no">
			</cfcase>
		</cfswitch>
		</cfoutput>
	
	<cfelse>
		<!--- USER NOT ALLOWED TO ADD IMAGE --->
		<cfoutput>
		<cfswitch expression="#URL.Table#">
			<cfcase value="Products">
				<cflocation url="ProductDetail.cfm?ItemID=#URL.ImageID#&ErrorMsg=1" addtoken="no">
			</cfcase>
			<cfcase value="Categories">
				<cflocation url="CategoryDetail.cfm?CatID=#URL.ImageID#&ErrorMsg=1" addtoken="no">
			</cfcase>
			<cfcase value="Sections">
				<cflocation url="SectionDetail.cfm?SectionID=#URL.ImageID#&ErrorMsg=1" addtoken="no">
			</cfcase>
			<cfcase value="ParentCategories">
				<cflocation url="ParentCategoryDetail.cfm?PCID=#URL.ImageID#&ErrorMsg=1" addtoken="no">
			</cfcase>
			<cfcase value="ParentSections">
				<cflocation url="ParentSectionDetail.cfm?PSID=#URL.ImageID#&ErrorMsg=1" addtoken="no">
			</cfcase>
		</cfswitch>
		</cfoutput>
	</cfif>
</cfif><!--- IMAGE FOR PRODUCT MATRIX ??? --->