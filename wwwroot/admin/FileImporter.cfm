<!--- SETUP TRACKING VARIABLES --->
<cfscript>
	Preview = 0 ;
	RecordNumber = 0 ;
	MainProductsAdded = 0 ;
	MainProductsUpdated = 0 ;
	ProductOptionsAdded = 0 ;
	ProductOptionsUpdated = 0 ;
	CategoriesAdded = 0 ;
	MainCategoriesAdded = 0 ;
	DistributorsAdded = 0 ;
	InsertErrors = 0 ;
	UpdateErrors = 0 ;
	CategoryErrors = 0 ;
	DistributorErrors = 0 ;
	OtherErrors = 0 ;
	ShowResults = 0 ;
	DateUpdated = Now() ;
	UpdatedBy = GetAuthUser() ;
</cfscript>
				
<!--- PRODUCT IMPORT --->
<cfif isDefined('form.filename') AND isDefined('FORM.ImportFile') >
	<!--- UPLOAD FILE AND READ IT --->
	<cffile action="upload" destination="#getDirectoryFromPath(getCurrentTemplatePath())#\docs\" filefield="filename" nameconflict="overwrite" >
	<cffile action="read" file="#getDirectoryFromPath(getCurrentTemplatePath())#\docs\#cffile.ServerFile#" variable="fileData" >

	<!--- PREVIEW FILE CREATED --->
	<cfif Preview EQ 1 >
		<table width="70%" border="1" bordercolor="#EFEFEF" cellpadding="2" cellspacing="0">
			<cfoutput>			
			<cfloop index="record" list="#fileData#" delimiters='#chr(10)##chr(13)#'>
			<tr>
				<td nowrap="nowrap"><font size="-2">#TRIM(Replace(Listgetat(record,1,'|'),'*','','ALL'))#</font></td>
				<td nowrap="nowrap"><font size="-2">#TRIM(Replace(Listgetat(record,2,'|'),'*','','ALL'))#</font></td>
				<td nowrap="nowrap"><font size="-2">#TRIM(Replace(Listgetat(record,3,'|'),'*','','ALL'))#</font></td>
				<td nowrap="nowrap"><font size="-2">#TRIM(Replace(Listgetat(record,4,'|'),'*','','ALL'))#</font></td>
				<td nowrap="nowrap"><font size="-2">#TRIM(Replace(Listgetat(record,5,'|'),'*','','ALL'))#</font></td>
				<td nowrap="nowrap"><font size="-2">#TRIM(Replace(Listgetat(record,6,'|'),'*','','ALL'))#</font></td>
				<td nowrap="nowrap"><font size="-2">#TRIM(Replace(Listgetat(record,7,'|'),'*','','ALL'))#</font></td>
				<td nowrap="nowrap"><font size="-2">#TRIM(Replace(Listgetat(record,8,'|'),'*','','ALL'))#</font></td>
				<td nowrap="nowrap"><font size="-2">#TRIM(Replace(Listgetat(record,9,'|'),'*','','ALL'))#</font></td>
				<td nowrap="nowrap"><font size="-2">#TRIM(Replace(Listgetat(record,10,'|'),'*','','ALL'))#</font></td>
				<td nowrap="nowrap"><font size="-2">#TRIM(Replace(Listgetat(record,11,'|'),'*','','ALL'))#</font></td>
				<td nowrap="nowrap"><font size="-2">#TRIM(Replace(Listgetat(record,12,'|'),'*','','ALL'))#</font></td>
				<td nowrap="nowrap"><font size="-2">#TRIM(Replace(Listgetat(record,13,'|'),'*','','ALL'))#</font></td>
				<td nowrap="nowrap"><font size="-2">#TRIM(Replace(Listgetat(record,14,'|'),'*','','ALL'))#</font></td>
				<td nowrap="nowrap"><font size="-2">#TRIM(Replace(Listgetat(record,15,'|'),'*','','ALL'))#</font></td>
				<td nowrap="nowrap"><font size="-2">#TRIM(Replace(Listgetat(record,16,'|'),'*','','ALL'))#</font></td>
				<td nowrap="nowrap"><font size="-2">#TRIM(Replace(Listgetat(record,17,'|'),'*','','ALL'))#</font></td>
				<td nowrap="nowrap"><font size="-2">#TRIM(Replace(Listgetat(record,18,'|'),'*','','ALL'))#</font></td>
			</tr>
			</cfloop>			
			</cfoutput>
		</table>
		<cfabort>
	</cfif>
	
	
	
	<font size="-1">
	<cfoutput>
	<cftransaction>
	
	<!--- LOOP THROUGH UPLOADED FILE --->
	<cfloop index="record" list="#fileData#" delimiters='#chr(10)##chr(13)#'>
		
		<!--- IF THIS RECORD IS TO BE A MAIN PRODUCT --->
		<cfif listgetat(record,1,'|') EQ 1 >
			
			<cfset RecordNumber = RecordNumber + 1 >
			
			<!--- SEE IF THIS PRODUCT IS ALREADY IN THE CARTFUSION DATABASE --->
			<cftry>
				<cfquery name="FindProductMain" datasource="#application.dsn#">
					SELECT 	ItemID, QB
					FROM	Products
					WHERE	QB = <cfqueryparam value="#TRIM(Replace(ListGetAt(record,18,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_VARCHAR">
					AND		(Deleted = 0 OR Deleted IS NULL)
				</cfquery>
				
				<cfcatch>
					<cfset OtherErrors = OtherErrors + 1 >
					ERROR FINDING PRODUCT AT RECORD NUMBER <b>#RecordNumber#</b> (#TRIM(Replace(ListGetAt(record,18,'|'),'*','','ALL'))#):<br/>
					#cfcatch.Message#<br/>
				</cfcatch>
			</cftry>
			
			<!--- RETRIEVE AND INSERT MAIN CATEGORIES --->
			<cftry>
				<!--- SEE IF THIS MAIN CATEGORY IS ALREADY IN THE CARTFUSION DATABASE --->
				<cfquery name="getMainCategoryID" datasource="#application.dsn#">
					SELECT	CatID
					FROM	Categories
					WHERE	CatName = <cfqueryparam value="#TRIM(Replace(ListGetAt(record,5,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_VARCHAR">
					AND		SubCategoryOf IS NULL
				</cfquery>
				
				<cfcatch>
					<cfset OtherErrors = OtherErrors + 1 >
					ERROR FINDING CATEGORY AT RECORD NUMBER <b>#RecordNumber#</b> (#TRIM(Replace(ListGetAt(record,5,'|'),'*','','ALL'))#):<br/>
					#cfcatch.Message#<br/>
				</cfcatch>
			</cftry>
				
			<cftry>	
				<!--- IF THIS MAIN CATEGORY IS NOT ALREADY IN THE CARTFUSION DATABASE, ADD IT --->
				<cfif getMainCategoryID.RecordCount EQ 0 >
					<cfquery name="insertMainCategory" datasource="#application.dsn#">
						SET NOCOUNT ON
						INSERT INTO Categories
							   (
								SiteID, CatName
							   )
						VALUES (
								<cfqueryparam value="1" cfsqltype="CF_SQL_INTEGER">,
								<cfqueryparam value="#TRIM(Replace(ListGetAt(record,5,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_VARCHAR">
								)
						SELECT @@Identity AS CatID
						SET NOCOUNT OFF
					</cfquery>
					
					<cfif isDefined('insertMainCategory.CatID')>
						<cfset MainCategoryID = insertMainCategory.CatID >
						<cfset MainCategoriesAdded = MainCategoriesAdded + 1 >
					<cfelse>
						<cfset MainCategoryID = 0 >
					</cfif>
					
				<!--- OTHERWISE, IF THE MAIN CATEGORY IS IN THE CARTFUSION DATABASE, ASSIGN THIS PRODUCT TO IT --->
				<cfelse>
					<cfset MainCategoryID = getMainCategoryID.CatID >
				</cfif>
				
				<cfcatch>
	
					ERROR OCCURED ADDING MAIN CATEGORY AT RECORD NUMBER <b>#RecordNumber#</b> (#TRIM(Replace(ListGetAt(record,5,'|'),'*','','ALL'))#):<br/>
					#cfcatch.Message#<br/>
					<cfset CategoryErrors = CategoryErrors + 1 >
	
				</cfcatch>
			</cftry>
			
			<!--- RETRIEVE AND INSERT PRODUCT-LEVEL CATEGORIES --->
			<cfif TRIM(Replace(ListGetAt(record,6,'|'),'*','','ALL')) NEQ '' >
				<cftry>				
					<!--- SEE IF THIS PRODUCT'S CATEGORY IS ALREADY IN THE CARTFUSION DATABASE --->
					<cfquery name="getCategoryID" datasource="#application.dsn#">
						SELECT	CatID
						FROM	Categories
						WHERE	CatName = <cfqueryparam value="#TRIM(Replace(ListGetAt(record,6,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_VARCHAR">
						AND	   	SubCategoryOf = <cfqueryparam value="#MainCategoryID#" cfsqltype="CF_SQL_INTEGER">
					</cfquery>
					
					<cfcatch>
						<cfset OtherErrors = OtherErrors + 1 >
					</cfcatch>
				</cftry>
					
				<cftry>	
					<!--- IF THIS PRODUCT'S CATEGORY IS NOT ALREADY IN THE CARTFUSION DATABASE, ADD IT --->
					<cfif getCategoryID.RecordCount EQ 0 >
						<cfquery name="insertCategory" datasource="#application.dsn#">
							SET NOCOUNT ON
							INSERT INTO Categories
								   (
									SiteID, CatName, SubCategoryOf
								   )
							VALUES (
									<cfqueryparam value="1" cfsqltype="CF_SQL_INTEGER">,
									<cfqueryparam value="#TRIM(Replace(ListGetAt(record,6,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#MainCategoryID#" cfsqltype="CF_SQL_INTEGER">
									)
							SELECT @@Identity AS CatID
							SET NOCOUNT OFF
						</cfquery>
						
						<cfif isDefined('insertCategory.CatID')>
							<cfset CategoryID = insertCategory.CatID >
							<cfset CategoriesAdded = CategoriesAdded + 1 >
						<cfelse>
							<cfset CategoryID = 0 >
						</cfif>
						
					<!--- OTHERWISE, IF THE CATEGORY IS IN THE CARTFUSION DATABASE, ASSIGN THIS PRODUCT TO IT --->
					<cfelse>
						<cfset CategoryID = getCategoryID.CatID >
					</cfif>
					
					<cfcatch>
		
						ERROR OCCURED ADDING PRODUCT-LEVEL CATEGORY AT RECORD NUMBER <b>#RecordNumber#</b> (#TRIM(Replace(ListGetAt(record,6,'|'),'*','','ALL'))#):<br/>
						#cfcatch.Message#<br/>
						<cfset CategoryErrors = CategoryErrors + 1 >
		
					</cfcatch>
				</cftry>
			<cfelse>
				<cfset CategoryID = MainCategoryID >
			</cfif>
			
			<!--- RETRIEVE AND INSERT DISTRIBUTORS --->
			<cftry>				
				<!--- SEE IF THIS DISTRIBUTOR IS ALREADY IN THE CARTFUSION DATABASE --->
				<cfquery name="getDistributorID" datasource="#application.dsn#">
					SELECT	DistributorID
					FROM	Distributors
					WHERE	DistributorName = <cfqueryparam value="#TRIM(Replace(ListGetAt(record,17,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_VARCHAR">
				</cfquery>				
				<cfcatch>
					<cfset OtherErrors = OtherErrors + 1 >
				</cfcatch>
			</cftry>
				
			<cftry>	
				<!--- IF THIS DISTRIBUTOR IS NOT ALREADY IN THE CARTFUSION DATABASE, ADD IT --->
				<cfif getDistributorID.RecordCount EQ 0 >
					<cfquery name="insertDistributor" datasource="#application.dsn#">
						SET NOCOUNT ON
						INSERT INTO Distributors ( DistributorName )
						VALUES ( <cfqueryparam value="#TRIM(Replace(ListGetAt(record,17,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_VARCHAR"> )
						SELECT @@Identity AS DistributorID
						SET NOCOUNT OFF
					</cfquery>
					
					<cfif isDefined('insertDistributor.DistributorID')>
						<cfset DistributorID = insertDistributor.DistributorID >
						<cfset DistributorsAdded = DistributorsAdded + 1 >
					<cfelse>
						<cfset DistributorID = 0 >
					</cfif>
					
				<!--- OTHERWISE, IF THE DISTRIBUTOR IS IN THE CARTFUSION DATABASE, ASSIGN THIS PRODUCT TO IT --->
				<cfelse>
					<cfset DistributorID = getDistributorID.DistributorID >
				</cfif>
				
				<cfcatch>

					ERROR OCCURED AT RECORD NUMBER <b>#RecordNumber#</b> (#TRIM(Replace(ListGetAt(record,17,'|'),'*','','ALL'))#):<br/>
					#cfcatch.Message#<br/>
					<cfset DistributorErrors = DistributorErrors + 1 >

				</cfcatch>
			</cftry>
					
			<!--- IF THIS PRODUCT IS NOT ALREADY IN THE CARTFUSION DATABASE, ADD IT --->
			<cfif FindProductMain.RecordCount EQ 0 >
				<cftry>
					<cfquery name="InsertProductMain" datasource="#application.dsn#">
						SET NOCOUNT ON
						INSERT INTO Products
							   (
								SiteID, SKU, ItemName, ItemDescription, Category,
								StockQuantity, CostPrice, Price1, 
								Image, ImageSmall, ImageLarge, ImageDir,
								ItemClassID, DistributorID, QB,
								UseMatrix, SellByStock, ItemStatus,
								DateUpdated, UpdatedBy
							   )
						VALUES (
								<cfqueryparam value="1" cfsqltype="CF_SQL_INTEGER">,
								<cfqueryparam value="#TRIM(Replace(ListGetAt(record,2,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_VARCHAR">,
								<cfqueryparam value="#TRIM(Replace(ListGetAt(record,3,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_VARCHAR">,
								<cfqueryparam value="#TRIM(Replace(ListGetAt(record,4,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_LONGVARCHAR">,
								<cfqueryparam value="#CategoryID#" cfsqltype="CF_SQL_INTEGER">,
								
								<cfqueryparam value="#TRIM(Replace(ListGetAt(record,10,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_INTEGER">,
								<cfqueryparam value="#TRIM(Replace(ListGetAt(record,11,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_MONEY4">,
								<cfqueryparam value="#TRIM(Replace(ListGetAt(record,12,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_MONEY4">,
								
								<cfqueryparam value="#TRIM(Replace(ListGetAt(record,13,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_VARCHAR">,
								<cfqueryparam value="#TRIM(Replace(ListGetAt(record,14,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_VARCHAR">,
								<cfqueryparam value="#TRIM(Replace(ListGetAt(record,15,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_VARCHAR">,
								<cfqueryparam value="products" cfsqltype="CF_SQL_VARCHAR">,
								
								<cfif TRIM(Replace(ListGetAt(record,16,'|'),'*','','ALL')) EQ '' >
									<cfqueryparam value="0" cfsqltype="CF_SQL_INTEGER">,
								<cfelse>
									<cfqueryparam value="#TRIM(Replace(ListGetAt(record,16,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_INTEGER">,
								</cfif>
								<cfqueryparam value="#DistributorID#" cfsqltype="CF_SQL_INTEGER">,
								<cfqueryparam value="#TRIM(Replace(ListGetAt(record,18,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_VARCHAR">,
								
								<cfif TRIM(Replace(Replace(Replace(ListGetAt(record,16,'|'),'_*','','ALL'),'*','','ALL'),',',' - ','ALL')) EQ '' >
									<cfqueryparam value="0" cfsqltype="CF_SQL_BIT">,
								<cfelse>
									<cfqueryparam value="1" cfsqltype="CF_SQL_BIT">,
								</cfif>
								<cfqueryparam value="1" cfsqltype="CF_SQL_BIT">,
								<cfqueryparam value="IS" cfsqltype="CF_SQL_VARCHAR">,
								
								<cfqueryparam value="#DateUpdated#" cfsqltype="CF_SQL_DATE">,
								<cfqueryparam value="#UpdatedBy#" cfsqltype="CF_SQL_VARCHAR">
								)
						SELECT @@Identity AS ItemID
						SET NOCOUNT OFF
					</cfquery>
				
					<cfset MainProductsAdded = MainProductsAdded + 1 >
					
					<cfcatch>
						
						INSERT ERROR AT RECORD NUMBER <b>#RecordNumber#</b> (#TRIM(Replace(ListGetAt(record,2,'|'),'*','','ALL'))#):<br/>
						#cfcatch.Message#<br/>
						<cfset InsertErrors = InsertErrors + 1 >

					</cfcatch>
				</cftry>

			<!--- OTHERWISE, IF THIS PRODUCT IS ALREADY IN THE CARTFUSION DATABASE, UPDATE IT --->
			<cfelse>
				<cftry>
					<cfquery name="UpdateProductMain" datasource="#application.dsn#">
						UPDATE 	Products
						SET		SKU = <cfqueryparam value="#TRIM(Replace(ListGetAt(record,2,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_VARCHAR">,
								ItemName = <cfqueryparam value="#TRIM(Replace(ListGetAt(record,3,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_VARCHAR">,
								ItemDescription = <cfqueryparam value="#TRIM(Replace(ListGetAt(record,4,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_LONGVARCHAR">,
								Category = <cfqueryparam value="#CategoryID#" cfsqltype="CF_SQL_INTEGER">,
								
								StockQuantity = <cfqueryparam value="#TRIM(Replace(ListGetAt(record,10,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_INTEGER">,
								CostPrice = <cfqueryparam value="#TRIM(Replace(ListGetAt(record,11,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_MONEY4">,
								Price1 = <cfqueryparam value="#TRIM(Replace(ListGetAt(record,12,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_MONEY4">,
								
								Image = <cfqueryparam value="#TRIM(Replace(ListGetAt(record,13,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_VARCHAR">,
								ImageSmall = <cfqueryparam value="#TRIM(Replace(ListGetAt(record,14,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_VARCHAR">,
								ImageLarge = <cfqueryparam value="#TRIM(Replace(ListGetAt(record,15,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_VARCHAR">,
								ImageDir = <cfqueryparam value="products" cfsqltype="CF_SQL_VARCHAR">,
								
								<cfif TRIM(Replace(ListGetAt(record,16,'|'),'*','','ALL')) EQ ''>
									ItemClassID = <cfqueryparam value="0" cfsqltype="CF_SQL_INTEGER">,
								<cfelse>	
									ItemClassID = <cfqueryparam value="#TRIM(Replace(ListGetAt(record,16,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_INTEGER">,
								</cfif>
																
								DistributorID = <cfqueryparam value="#DistributorID#" cfsqltype="CF_SQL_INTEGER">,
								<cfif TRIM(Replace(Replace(Replace(ListGetAt(record,16,'|'),'_*','','ALL'),'*','','ALL'),',',' - ','ALL')) EQ '' >
									UseMatrix = <cfqueryparam value="0" cfsqltype="CF_SQL_BIT">,
								<cfelse>
									UseMatrix = <cfqueryparam value="1" cfsqltype="CF_SQL_BIT">,
								</cfif>
								SellByStock = <cfqueryparam value="1" cfsqltype="CF_SQL_BIT">,
								ItemStatus = <cfqueryparam value="IS" cfsqltype="CF_SQL_VARCHAR">,
								
								DateUpdated = <cfqueryparam value="#DateUpdated#" cfsqltype="CF_SQL_DATE">,
								UpdatedBy = <cfqueryparam value="#UpdatedBy#" cfsqltype="CF_SQL_VARCHAR">
								
						WHERE	QB = <cfqueryparam value="#TRIM(Replace(ListGetAt(record,18,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_VARCHAR">
					</cfquery>
					
					<cftry>			
						<!--- SEE IF THIS PRODUCT IS ALREADY IN THE CARTFUSION DATABASE --->
						<cfquery name="InsertProductMain" datasource="#application.dsn#">
							SELECT 	ItemID
							FROM	Products
							WHERE	QB = <cfqueryparam value="#TRIM(Replace(ListGetAt(record,18,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_VARCHAR">
						</cfquery>
						
						<cfcatch>
							<cfset OtherErrors = OtherErrors + 1 >
						</cfcatch>
					</cftry>
					
					<cfset MainProductsUpdated = MainProductsUpdated + 1 >
					
					<cfcatch>
						
						UPDATE ERROR AT RECORD NUMBER <b>#RecordNumber#</b> (#TRIM(Replace(ListGetAt(record,2,'|'),'*','','ALL'))#):<br/>
						#cfcatch.Message#<br/>
						<cfset UpdateErrors = UpdateErrors + 1 >
						
					</cfcatch>
				</cftry>
			</cfif>
			
			
			<!--- IF THIS MAIN PRODUCT HAS DETAILS/OPTIONS --->
			<!--- ADD THIS MAIN PRODUCT AS A PRODUCT OPTION --->
			<cfif TRIM(Replace(ListGetAt(record,7,'|'),'*','','ALL')) NEQ '' >

				<cftry>			
					<!--- SEE IF THIS PRODUCT IS ALREADY IN THE CARTFUSION DATABASE --->
					<cfquery name="FindProductOption" datasource="#application.dsn#">
						SELECT 	ItemID, QB
						FROM	ItemClassComponents
						WHERE	QB = <cfqueryparam value="#TRIM(Replace(ListGetAt(record,18,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_VARCHAR">
					</cfquery>
					
					<cfcatch>
						<cfset OtherErrors = OtherErrors + 1 >
					</cfcatch>
				</cftry>
				
				<!--- IF THIS PRODUCT IS NOT ALREADY IN THE CARTFUSION DATABASE, ADD IT --->
				<cfif FindProductOption.RecordCount EQ 0 >
					<cftry>
						<cfquery name="InsertProductOption" datasource="#application.dsn#">
							SET NOCOUNT ON
							INSERT INTO ItemClassComponents
								   (
									ItemClassID, ItemID, Detail1, Detail2, Detail3,
									CompPrice, 
									CompQuantity, CompStatus, CompSellByStock, Image, QB
								   )
							VALUES (
									<cfif TRIM(Replace(ListGetAt(record,16,'|'),'*','','ALL')) EQ ''>
										<cfqueryparam value="0" cfsqltype="CF_SQL_INTEGER">,
									<cfelse>	
										<cfqueryparam value="#TRIM(Replace(ListGetAt(record,16,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_INTEGER">,
									</cfif>
									<cfqueryparam value="#InsertProductMain.ItemID#" cfsqltype="CF_SQL_INTEGER">,
									<cfqueryparam value="#TRIM(Replace(ListGetAt(record,7,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(Replace(ListGetAt(record,8,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(Replace(ListGetAt(record,9,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_VARCHAR">,
									
									<!--- PRICE --->
									<!---<cfqueryparam value="#TRIM(Replace(ListGetAt(record,12,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_MONEY4">,--->
									<cfqueryparam value="0" cfsqltype="CF_SQL_MONEY4">,
									
									<cfqueryparam value="#TRIM(Replace(ListGetAt(record,10,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_INTEGER">,
									<cfqueryparam value="IS" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="1" cfsqltype="CF_SQL_BIT">,
									<cfqueryparam value="#TRIM(Replace(ListGetAt(record,13,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(Replace(ListGetAt(record,18,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_VARCHAR">
									)
							SELECT @@Identity AS ICCID
							SET NOCOUNT OFF
						</cfquery>
					
						<cfset ProductOptionsAdded = ProductOptionsAdded + 1 >
						
						<cfcatch>
							
							POM INSERT ERROR AT RECORD NUMBER <b>#RecordNumber#</b> (#InsertProductMain.ItemID#):<br/>
							#cfcatch.Message#<br/>
							<cfset InsertErrors = InsertErrors + 1 >
	
						</cfcatch>
					</cftry>
	
				<!--- OTHERWISE, IF THIS PRODUCT IS ALREADY IN THE CARTFUSION DATABASE, UPDATE IT --->
				<cfelse>
					<cftry>
						<cfquery name="InsertProductOption" datasource="#application.dsn#">
							UPDATE	ItemClassComponents
							
							SET		<cfif TRIM(Replace(ListGetAt(record,16,'|'),'*','','ALL')) EQ ''>
										ItemClassID = <cfqueryparam value="0" cfsqltype="CF_SQL_INTEGER">,
									<cfelse>	
										ItemClassID = <cfqueryparam value="#TRIM(Replace(ListGetAt(record,16,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_INTEGER">,
									</cfif>
									ItemID = <cfqueryparam value="#InsertProductMain.ItemID#" cfsqltype="CF_SQL_INTEGER">,
									Detail1 = <cfqueryparam value="#TRIM(Replace(ListGetAt(record,7,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_VARCHAR">,
									Detail2 = <cfqueryparam value="#TRIM(Replace(ListGetAt(record,8,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_VARCHAR">,
									Detail3 = <cfqueryparam value="#TRIM(Replace(ListGetAt(record,9,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_VARCHAR">,
									
									<!--- PRICE --->
									CompPrice = <cfqueryparam value="0" cfsqltype="CF_SQL_MONEY4">,
									<!---<cfqueryparam value="#TRIM(Replace(ListGetAt(record,12,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_MONEY4">,--->
									
									CompQuantity = <cfqueryparam value="#TRIM(Replace(ListGetAt(record,10,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_INTEGER">, 
									CompStatus = <cfqueryparam value="IS" cfsqltype="CF_SQL_VARCHAR">,
									CompSellByStock = <cfqueryparam value="1" cfsqltype="CF_SQL_BIT">,
									Image = <cfqueryparam value="#TRIM(Replace(ListGetAt(record,13,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_VARCHAR">
	
							WHERE	QB = <cfqueryparam value="#TRIM(Replace(ListGetAt(record,18,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_VARCHAR">
						</cfquery>
						
						<cfset ProductOptionsUpdated = ProductOptionsUpdated + 1 >
						
						<cfcatch>
							
							POM UPDATE ERROR AT RECORD NUMBER <b>#RecordNumber#</b> (#InsertProductMain.ItemID#):<br/>
							#cfcatch.Message#<br/>
							<cfset UpdateErrors = UpdateErrors + 1 >
	
						</cfcatch>
					</cftry>
				</cfif>
			</cfif>
		
		
		
		
<!--- PRODUCT OPTIONS --->
		
		
		
		
		<!--- PRODUCT IS NOT A MAIN PRODUCT, BUT A PRODUCT OPTION (IN THE INVENTORY MATRIX) --->
		<cfelseif listgetat(record,1,'|') EQ 2 AND isDefined('InsertProductMain.ItemID') >
			
			<cfset RecordNumber = RecordNumber + 1 >
			
			<cftry>			
				<!--- SEE IF THIS PRODUCT IS ALREADY IN THE CARTFUSION DATABASE --->
				<cfquery name="FindProductOption" datasource="#application.dsn#">
					SELECT 	ItemID, QB
					FROM	ItemClassComponents
					WHERE	QB = <cfqueryparam value="#TRIM(Replace(ListGetAt(record,18,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_VARCHAR">
				</cfquery>
				
				<cfcatch>
					<cfset OtherErrors = OtherErrors + 1 >
				</cfcatch>
			</cftry>
			
			<!--- IF THIS PRODUCT IS NOT ALREADY IN THE CARTFUSION DATABASE, ADD IT --->
			<cfif FindProductOption.RecordCount EQ 0 >
				<cftry>
					<cfquery name="InsertProductOption" datasource="#application.dsn#">
						SET NOCOUNT ON
						INSERT INTO ItemClassComponents
							   (
								ItemClassID, ItemID, Detail1, Detail2, Detail3,
								CompPrice, 
								CompQuantity, CompStatus, CompSellByStock, Image, QB
							   )
						VALUES (
								<cfif TRIM(Replace(ListGetAt(record,16,'|'),'*','','ALL')) EQ ''>
									<cfqueryparam value="0" cfsqltype="CF_SQL_INTEGER">,
								<cfelse>	
									<cfqueryparam value="#TRIM(Replace(ListGetAt(record,16,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_INTEGER">,
								</cfif>
								<cfqueryparam value="#InsertProductMain.ItemID#" cfsqltype="CF_SQL_INTEGER">,
								<cfqueryparam value="#TRIM(Replace(ListGetAt(record,7,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_VARCHAR">,
								<cfqueryparam value="#TRIM(Replace(ListGetAt(record,8,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_VARCHAR">,
								<cfqueryparam value="#TRIM(Replace(ListGetAt(record,9,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_VARCHAR">,
								
								<!--- PRICE --->
								<!---<cfqueryparam value="#TRIM(Replace(ListGetAt(record,12,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_MONEY4">,--->
								<cfqueryparam value="0" cfsqltype="CF_SQL_MONEY4">,
								
								<cfqueryparam value="#TRIM(Replace(ListGetAt(record,10,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_INTEGER">,
								<cfqueryparam value="IS" cfsqltype="CF_SQL_VARCHAR">,
								<cfqueryparam value="1" cfsqltype="CF_SQL_BIT">,
								<cfqueryparam value="#TRIM(Replace(ListGetAt(record,13,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_VARCHAR">,
								<cfqueryparam value="#TRIM(Replace(ListGetAt(record,18,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_VARCHAR">
								)
						SELECT @@Identity AS ICCID
						SET NOCOUNT OFF
					</cfquery>
				
					<cfset ProductOptionsAdded = ProductOptionsAdded + 1 >
					
					<cfcatch>
						
						PO INSERT ERROR AT RECORD NUMBER <b>#RecordNumber#</b> (#InsertProductMain.ItemID#):<br/>
						#cfcatch.Message#<br/>
						<cfset InsertErrors = InsertErrors + 1 >

					</cfcatch>
				</cftry>

			<!--- OTHERWISE, IF THIS PRODUCT IS ALREADY IN THE CARTFUSION DATABASE, UPDATE IT --->
			<cfelse>
				<cftry>
					<cfquery name="InsertProductOption" datasource="#application.dsn#">
						UPDATE	ItemClassComponents
						
						SET		<cfif TRIM(Replace(ListGetAt(record,16,'|'),'*','','ALL')) EQ ''>
									ItemClassID = <cfqueryparam value="0" cfsqltype="CF_SQL_INTEGER">,
								<cfelse>	
									ItemClassID = <cfqueryparam value="#TRIM(Replace(ListGetAt(record,16,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_INTEGER">,
								</cfif>
								ItemID = <cfqueryparam value="#InsertProductMain.ItemID#" cfsqltype="CF_SQL_INTEGER">,
								Detail1 = <cfqueryparam value="#TRIM(Replace(ListGetAt(record,7,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_VARCHAR">,
								Detail2 = <cfqueryparam value="#TRIM(Replace(ListGetAt(record,8,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_VARCHAR">,
								Detail3 = <cfqueryparam value="#TRIM(Replace(ListGetAt(record,9,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_VARCHAR">,
								
								<!--- PRICE --->
								CompPrice = <cfqueryparam value="0" cfsqltype="CF_SQL_MONEY4">,
								<!---<cfqueryparam value="#TRIM(Replace(ListGetAt(record,12,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_MONEY4">,--->
								
								CompQuantity = <cfqueryparam value="#TRIM(Replace(ListGetAt(record,10,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_INTEGER">, 
								CompStatus = <cfqueryparam value="IS" cfsqltype="CF_SQL_VARCHAR">,
								CompSellByStock = <cfqueryparam value="1" cfsqltype="CF_SQL_BIT">,
								Image = <cfqueryparam value="#TRIM(Replace(ListGetAt(record,13,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_VARCHAR">

						WHERE	QB = <cfqueryparam value="#TRIM(Replace(ListGetAt(record,18,'|'),'*','','ALL'))#" cfsqltype="CF_SQL_VARCHAR">
					</cfquery>
					
					<cfset ProductOptionsUpdated = ProductOptionsUpdated + 1 >
					
					<cfcatch>
						
						PO UPDATE ERROR AT RECORD NUMBER <b>#RecordNumber#</b> (#InsertProductMain.ItemID#):<br/>
						#cfcatch.Message#<br/>
						<cfset UpdateErrors = UpdateErrors + 1 >

					</cfcatch>
				</cftry>
			</cfif>
		</cfif>		
		
	</cfloop>
	</cftransaction>
	</cfoutput>
	</font>
		
	<cfset AdminMsg = 'Product Import Successful!' >
	<cfset ShowResults = 1 >




<!--- INVENTORY UPDATER --->	
<cfelseif isDefined('form.filename') AND isDefined('FORM.UpdateInventory') >

	<!--- UPLOAD FILE AND READ IT --->
	<cffile action="upload" destination="#getDirectoryFromPath(getCurrentTemplatePath())#\docs\" filefield="filename" nameconflict="overwrite">
	<cffile action="read" file="#getDirectoryFromPath(getCurrentTemplatePath())#\docs\#cffile.ServerFile#" variable="fileData">
	
	<!--- PREVIEW FILE CREATED --->
	<cfif Preview EQ 1 >
		<table width="100%" border="1" bordercolor="EFEFEF" cellpadding="2" cellspacing="0">
			<cfoutput>
			<cfloop index="record" list="#fileData#" delimiters='#chr(10)##chr(13)#'>
			<tr>
				<td nowrap="nowrap"><font size="-2">#TRIM(Replace(Replace(Replace(Listgetat(record,1,'|'),'_*','','ALL'),'*','','ALL'),',',' - ','ALL'))#</font></td>
				<td nowrap="nowrap"><font size="-2">#TRIM(Replace(Replace(Replace(Listgetat(record,2,'|'),'_*','','ALL'),'*','','ALL'),',',' - ','ALL'))#</font></td>
			</tr>
			</cfloop>
			</cfoutput>
		</table>
	</cfif>
	
	
	
	<font size="-1">
	<cfoutput>
	<cftransaction>
	
	<!--- LOOP THROUGH UPLOADED FILE --->
	<cfloop index="record" list="#fileData#" delimiters='#chr(10)##chr(13)#'>
		
		<cfif TRIM(Replace(ListGetAt(record,1,'|'),'*','','ALL')) NEQ '' >
			<cfset RecordNumber = RecordNumber + 1 >
			
			<!--- SEE IF THIS PRODUCT IS IN PRODUCTS TABLE --->
			<cftry>
				<cfquery name="FindProductMain" datasource="#application.dsn#">
					SELECT 	QB
					FROM	Products
					WHERE	QB = <cfqueryparam value="#TRIM(Replace(Replace(Replace(ListGetAt(record,1,'|'),'_*','','ALL'),'*','','ALL'),',',' - ','ALL'))#" cfsqltype="CF_SQL_VARCHAR">
				</cfquery>
				
				<cfcatch>
					<cfset OtherErrors = OtherErrors + 1 >
				</cfcatch>
			</cftry>
			
			<!--- SEE IF THIS PRODUCT IS IN ITEM CLASS COMPONENTS TABLE --->
			<cftry>
				<cfquery name="FindProductOption" datasource="#application.dsn#">
					SELECT 	QB
					FROM	ItemClassComponents
					WHERE	QB = <cfqueryparam value="#TRIM(Replace(Replace(Replace(ListGetAt(record,1,'|'),'_*','','ALL'),'*','','ALL'),',',' - ','ALL'))#" cfsqltype="CF_SQL_VARCHAR">
				</cfquery>
				
				<cfcatch>
					<cfset OtherErrors = OtherErrors + 1 >
				</cfcatch>
			</cftry>
			
			<!--- IF PRODUCT IS IN MAIN PRODUCTS TABLE, UPDATE QUANTITY THERE --->
			<cfif FindProductMain.RecordCount NEQ 0 >
				<cftry>
					<cfquery name="UpdateProductOption" datasource="#application.dsn#">
						UPDATE	Products
						SET		StockQuantity = <cfqueryparam value="#TRIM(Replace(Replace(Replace(ListGetAt(record,2,'|'),'_*','','ALL'),'*','','ALL'),',',' - ','ALL'))#" cfsqltype="CF_SQL_INTEGER">,
								DateUpdated = <cfqueryparam value="#DateUpdated#" cfsqltype="CF_SQL_DATE">,
								UpdatedBy = <cfqueryparam value="#UpdatedBy#" cfsqltype="CF_SQL_VARCHAR">
						WHERE	QB = <cfqueryparam value="#TRIM(Replace(Replace(Replace(ListGetAt(record,1,'|'),'_*','','ALL'),'*','','ALL'),',',' - ','ALL'))#" cfsqltype="CF_SQL_VARCHAR">
					</cfquery>
					
					<cfset MainProductsUpdated = MainProductsUpdated + 1 >
					
					<cfcatch>
						
						POM UPDATE ERROR AT RECORD NUMBER <b>#RecordNumber#</b> (#TRIM(Replace(Replace(Replace(ListGetAt(record,1,'|'),'_*','','ALL'),'*','','ALL'),',',' - ','ALL'))#):<br/>
						#cfcatch.Message#<br/>
						<cfset UpdateErrors = UpdateErrors + 1 >
	
					</cfcatch>
				</cftry>
			</cfif>
			
			<!--- IF PRODUCT IS IN ITEM CLASS COMPONENTS TABLE, UPDATE QUANTITY THERE --->
			<cfif FindProductOption.RecordCount NEQ 0 >
				<cftry>
					<cfquery name="UpdateProductOption" datasource="#application.dsn#">
						UPDATE	ItemClassComponents
						SET		CompQuantity = <cfqueryparam value="#TRIM(Replace(Replace(Replace(ListGetAt(record,2,'|'),'_*','','ALL'),'*','','ALL'),',',' - ','ALL'))#" cfsqltype="CF_SQL_INTEGER">
						WHERE	QB = <cfqueryparam value="#TRIM(Replace(Replace(Replace(ListGetAt(record,1,'|'),'_*','','ALL'),'*','','ALL'),',',' - ','ALL'))#" cfsqltype="CF_SQL_VARCHAR">
					</cfquery>
					
					<cfset ProductOptionsUpdated = ProductOptionsUpdated + 1 >
					
					<cfcatch>
						
						POP UPDATE ERROR AT RECORD NUMBER <b>#RecordNumber#</b> (#TRIM(Replace(Replace(Replace(ListGetAt(record,1,'|'),'_*','','ALL'),'*','','ALL'),',',' - ','ALL'))#):<br/>
						#cfcatch.Message#<br/>
						<cfset UpdateErrors = UpdateErrors + 1 >
	
					</cfcatch>
				</cftry>
			</cfif>
		</cfif>
	
	</cfloop>
	
	</cftransaction>
	</cfoutput>
	</font>
	
	
	<cfset AdminMsg = 'Inventory Updated Successfully!' >
	<cfset ShowResults = 2 >
	
</cfif>




<cfscript>
	PageTitle = 'CartFusion File Importer';
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">

<table width="75%" border="0" bordercolor="EFEFEF" cellpadding="7" cellspacing="0">
	<tr>
		<td width="100%" colspan="2" align="center">
			<img src="images/icon-FileImporter.gif" border="0"><br>
		</td>
	</tr>
</table>

<table width="75%" border="1" bordercolor="EFEFEF" cellpadding="7" cellspacing="0">
	<tr>
		<!--- PRODUCT IMPORTER --->
		<cfform name="frmData" action="FileImporter.cfm" method="post" enctype="multipart/form-data">
		<td width="50%" align="center">
			<div class="cfAdminHeader1">PRODUCT IMPORTER</div><br/>
			<table width="100%">
				<tr>
					<td width="100%" align="center" colspan="2">
						File: <cfinput type="file" name="filename" size="50" required="yes" message="Please select a file to import" class="cfAdminDefault"><br/>
					</td>
				</tr>
				<tr>
					<td width="100%" align="center" colspan="2">
						<input type="submit" name="ImportFile" value="IMPORT FILE" alt="Import File" class="cfAdminButton"  onclick="this.value='IMPORT FILE (PROCESSING...)'; return confirm('Are you sure you want to PROCESS THIS FILE FOR PRODUCT IMPORTING/UPDATING ?'); ">
					</td>
				</tr>
			</table>				
			<br><br>				
		</td>
		</cfform>
		<!--- STOCK QUANTITY UPDATER --->
		<cfform name="frmData" action="FileImporter.cfm" method="post" enctype="multipart/form-data">
		<td width="50%" align="center">
			<div class="cfAdminHeader1">INVENTORY UPDATER</div><br/>
			<table width="100%">
				<tr>
					<td width="100%" align="center" colspan="2">
						File: <cfinput type="file" name="filename" size="50" required="yes" message="Please select a file to import" class="cfAdminDefault"><br/>
					</td>
				</tr>
				<tr>
					<td width="100%" align="center" colspan="2">
						<input type="submit" name="UpdateInventory" value="IMPORT FILE" alt="Import File" class="cfAdminButton" onclick="this.value='IMPORT FILE (PROCESSING...)'; return confirm('Are you sure you want to PROCESS THIS FILE FOR INVENTORY UPDATING ?'); ">
					</td>
				</tr>
			</table>				
			<br><br>				
		</td>
		</cfform>
	</tr>
</table>




<!--- RESULTS --->
<cfif ShowResults EQ 1 >
<cfoutput>
<br/><br/>
<table width="75%" border="0" bordercolor="EFEFEF" cellpadding="7" cellspacing="0">
	<tr>
		<td width="100%" colspan="2" align="center" class="cfAdminTitle">
			IMPORT RESULTS
		</td>
	</tr>
</table>
<table width="75%" border="1" bordercolor="EFEFEF" cellpadding="7" cellspacing="0">
	<tr>
		<td width="100%" colspan="2" align="center" class="cfAdminTitle">
			<table width="100%" cellpadding="2" cellspacing="0" border="0">
				<tr>
					<td width="50%" align="right">Total Records Uploaded:</td>
					<td width="50%" class="cfAdminError">#RecordNumber#</td>
				</tr>
				<tr>
					<td width="50%" align="right">Main Products Added:</td>
					<td width="50%" class="cfAdminError">#MainProductsAdded#</td>
				</tr>
				<tr>
					<td width="50%" align="right">Main Products Updated:</td>
					<td width="50%" class="cfAdminError">#MainProductsUpdated#</td>
				</tr>
				<tr>
					<td width="50%" align="right">Product Options Added:</td>
					<td width="50%" class="cfAdminError">#ProductOptionsAdded#</td>
				</tr>
				<tr>
					<td width="50%" align="right">Product Options Updated:</td>
					<td width="50%" class="cfAdminError">#ProductOptionsUpdated#</td>
				</tr>
				<tr>
					<td width="50%" align="right">Main Categories Added:</td>
					<td width="50%" class="cfAdminError">#MainCategoriesAdded#</td>
				</tr>
				<tr>
					<td width="50%" align="right">Product-Level Categories Added:</td>
					<td width="50%" class="cfAdminError">#CategoriesAdded#</td>
				</tr>
				<tr>
					<td width="50%" align="right">Distributors Added:</td>
					<td width="50%" class="cfAdminError">#DistributorsAdded#</td>
				</tr>
				<tr>
					<td width="50%" align="right">Record Insert Errors:</td>
					<td width="50%" class="cfAdminError">#InsertErrors#</td>
				</tr>
				<tr>
					<td width="50%" align="right">Record Update Errors:</td>
					<td width="50%" class="cfAdminError">#UpdateErrors#</td>
				</tr>
				<tr>
					<td width="50%" align="right">Category Insert Errors:</td>
					<td width="50%" class="cfAdminError">#CategoryErrors#</td>
				</tr>
				<tr>
					<td width="50%" align="right">Distributor Insert Errors:</td>
					<td width="50%" class="cfAdminError">#DistributorErrors#</td>
				</tr>
				<tr>
					<td width="50%" align="right">Other Errors:</td>
					<td width="50%" class="cfAdminError">#OtherErrors#</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</cfoutput>
<cfelseif ShowResults EQ 2 >
<cfoutput>
<br/><br/>
<table width="75%" border="0" bordercolor="EFEFEF" cellpadding="7" cellspacing="0">
	<tr>
		<td width="100%" colspan="2" align="center" class="cfAdminTitle">
			IMPORT RESULTS
		</td>
	</tr>
</table>
<table width="75%" border="1" bordercolor="EFEFEF" cellpadding="7" cellspacing="0">
	<tr>
		<td width="100%" colspan="2" align="center" class="cfAdminTitle">
			<table width="100%" cellpadding="2" cellspacing="0" border="0">
				<tr>
					<td width="50%" align="right">Total Records Uploaded:</td>
					<td width="50%" class="cfAdminError">#RecordNumber#</td>
				</tr>
				<tr>
					<td width="50%" align="right">Main Products Added:</td>
					<td width="50%" class="cfAdminError">#MainProductsAdded#</td>
				</tr>
				<tr>
					<td width="50%" align="right">Main Products Updated:</td>
					<td width="50%" class="cfAdminError">#MainProductsUpdated#</td>
				</tr>
				<tr>
					<td width="50%" align="right">Product Options Added:</td>
					<td width="50%" class="cfAdminError">#ProductOptionsAdded#</td>
				</tr>
				<tr>
					<td width="50%" align="right">Product Options Updated:</td>
					<td width="50%" class="cfAdminError">#ProductOptionsUpdated#</td>
				</tr>
				<tr>
					<td width="50%" align="right">Record Insert Errors:</td>
					<td width="50%" class="cfAdminError">#InsertErrors#</td>
				</tr>
				<tr>
					<td width="50%" align="right">Record Update Errors:</td>
					<td width="50%" class="cfAdminError">#UpdateErrors#</td>
				</tr>
				<tr>
					<td width="50%" align="right">Other Errors:</td>
					<td width="50%" class="cfAdminError">#OtherErrors#</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</cfoutput>
</cfif>


<cfinclude template="LayoutAdminFooter.cfm">