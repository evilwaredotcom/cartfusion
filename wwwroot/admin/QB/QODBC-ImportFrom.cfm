<!---
	CartFusion 4.6 - Copyright � 2005 Trade Studios, LLC.
	This copyright notice MUST stay intact for use (see license.txt).
	It is against the law to copy, distribute, gift, bundle or give away this code 
	without written consent from Trade Studios, LLC.
--->   

<!--- SETUP TRACKING VARIABLES --->
<cfscript>
	Preview = 0 ;
	ThisStockQuantity = 0 ;
	RecordNumber = 0 ;
	MainProductsAdded = 0 ;
	MainProductsUpdated = 0 ;
	ProductOptionsAdded = 0 ;
	ProductOptionsUpdated = 0 ;
	CategoriesAdded = 0 ;
	MainCategoriesAdded = 0 ;
	InsertErrors = 0 ;
	UpdateErrors = 0 ;
	CategoryErrors = 0 ;
	OtherErrors = 0 ;
	ShowResults = 0 ;
	DateUpdated = Now() ;
	UpdatedBy = GetAuthUser() ;
</cfscript>

<!--- PRODUCT IMPORT --->
<cfif isDefined('FORM.ImportFromQB') >
	<!--- GET DATA FROM QUICKBOOKS --->
	<!--- <cftry> --->
		<cfquery name="ItemsList" datasource="#QBDSN#">
			SELECT 	<!---TOP 500 --->
					LISTID,
					TIMECREATED AS DateCreated,
					TIMEMODIFIED AS DateUpdated,
					NAME AS SKU,
					FULLNAME AS QB,
					ISACTIVE AS Deleted,
					PARENTREFFULLNAME,
					SALESDESC AS ItemName,
					SALESPRICE AS Price1Ponsard,
					INCOMEACCOUNTREFFULLNAME AS Category,
					PURCHASEDESC AS Comments,
					PURCHASECOST AS CostPrice,
					COGSACCOUNTREFFULLNAME,
					PREFVENDORREFFULLNAME AS MainCategory, 
					ASSETACCOUNTREFFULLNAME, 
					QUANTITYONHAND AS StockQuantity,
					CUSTOMFIELDINTERNETDESCRIPTION AS ItemDescription,
					CUSTOMFIELDRETAILPRICE AS Price1Jarpy,
					CUSTOMFIELDVOLUMEPTS AS Volume,
					CUSTOMFIELDWEIGHTLBS AS Weight
			FROM 	ItemInventory
		</cfquery>
	
		<!--- <cfcatch>
			<table width="100%" border="1" bordercolor="EFEFEF" cellpadding="2" cellspacing="0">		
				<tr>
					<td nowrap="nowrap">
						There has been an error trying to communicate with your QuickBooks file.<br/><br/>
						Please make sure of the following:<br/>
						1) That the correct company file is open in QuickBooks<br/>
						2) That the QODBC Remote Connector is running<br/>
						3) That the computer running the QuickBooks file is connected to the Internet.<br/><br/>
						
						MESSAGE DETAILS:<br/>
						<cfoutput>
						#cfcatch.Message#<br/>
						#cfcatch.Detail#<br/>
						</cfoutput>
					</td>
				</tr>
			</table>
			<cfabort>			
		</cfcatch>
	</cftry> --->
	
	<!--- GET DATA FROM CARTFUSION --->
	<cftry>	
		<cfquery name="getCategoryIDs" datasource="#application.dsn#">
			SELECT	CatID, CatName, SubCategoryOf
			FROM	Categories
		</cfquery>
		
		<cfquery name="FindProducts" datasource="#application.dsn#">
			SELECT 	ItemID, QB
			FROM	Products
		</cfquery>
				
		<cfcatch>
			<table width="100%" border="1" bordercolor="EFEFEF" cellpadding="2" cellspacing="0">		
				<tr>
					<td nowrap="nowrap">
						There has been an error trying to communicate with your CartFusion database.<br/><br/>
						
						MESSAGE DETAILS:<br/>
						<cfoutput>
						#cfcatch.Message#<br/>
						#cfcatch.Detail#<br/>
						</cfoutput>
					</td>
				</tr>
			</table>
			<cfabort>			
		</cfcatch>
	</cftry>
	
	
					
	<!--- PREVIEW FILE CREATED --->
	<cfif Preview EQ 1 >		
		<table width="100%" border="1" bordercolor="EFEFEF" cellpadding="2" cellspacing="0">		
			<tr>
				<td nowrap="nowrap">
					<cfdump var="#ItemsList#" expand="no">
				</td>
			</tr>
		</table>
		<cfabort>
	</cfif>
	
	
	
	<font size="-1">
	<cfoutput>
	<cftransaction>
	
	<!--- LOOP THROUGH RECORDSET FROM QUICKBOOKS --->
	<cfloop query="ItemsList">

		<cfset RecordNumber = RecordNumber + 1 >
		
		<!--- IF PRODUCT IS LEGIT --->
		<cfif ItemsList.QB NEQ '' >
			
			<cfscript>
				if ( TRIM(ItemsList.StockQuantity) EQ '' )
					ThisStockQuantity = 0 ;
				else
					ThisStockQuantity = NumberFormat(ItemsList.StockQuantity,9) ;
			</cfscript>
				
			<!--- SEE IF THIS PRODUCT IS ALREADY IN THE CARTFUSION DATABASE --->
			<cftry>
				<cfquery name="FindProductMain" dbtype="query">
					SELECT 	ItemID, QB
					FROM	FindProducts
					WHERE	QB = <cfqueryparam value="#ItemsList.QB#" cfsqltype="CF_SQL_VARCHAR">
				</cfquery>
				
				<cfcatch>
					COULDN'T FIND PRODUCT AT RECORD NUMBER <b>#RecordNumber#</b> (#ItemsList.QB#):<br/>
					#cfcatch.Message#<br/><cfset OtherErrors = OtherErrors + 1 >
				</cfcatch>
			</cftry>
			
			<!--- IF THIS PRODUCT IS NOT ALREADY IN THE CARTFUSION DATABASE, ADD IT --->
			<cfif FindProductMain.RecordCount EQ 0 >
				<!--- RETRIEVE AND INSERT MAIN CATEGORIES --->
				<cftry>
					<!--- SEE IF THIS MAIN CATEGORY IS ALREADY IN THE CARTFUSION DATABASE --->
					<cfquery name="getMainCategoryID" dbtype="query">
						SELECT	CatID
						FROM	getCategoryIDs
						WHERE	CatName = <cfqueryparam value="#TRIM(Replace(ItemsList.MainCategory,'Style, ','','ALL'))#" cfsqltype="CF_SQL_VARCHAR">
						AND		SubCategoryOf IS NULL
					</cfquery>
					
					<cfcatch>
						COULDN'T FIND CATEGORY AT RECORD NUMBER <b>#RecordNumber#</b> (#ItemsList.QB#):<br/>
						#cfcatch.Message#<br/><cfset OtherErrors = OtherErrors + 1 >
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
									<cfqueryparam value="#TRIM(Replace(ItemsList.MainCategory,'Style, ','','ALL'))#" cfsqltype="CF_SQL_VARCHAR">
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
						ERROR OCCURED ADDING MAIN CATEGORY AT RECORD NUMBER <b>#RecordNumber#</b> (#ItemsList.QB# #TRIM(Replace(ItemsList.MainCategory,'Style, ','','ALL'))#):<br/>
						#cfcatch.Message#<br/><cfset CategoryErrors = CategoryErrors + 1 >
					</cfcatch>
				</cftry>
				
				<!--- RETRIEVE AND INSERT PRODUCT-LEVEL CATEGORIES --->
				<cftry>				
					<!--- SEE IF THIS PRODUCT'S CATEGORY IS ALREADY IN THE CARTFUSION DATABASE --->
					<cfquery name="getCategoryID" dbtype="query">
						SELECT	CatID
						FROM	getCategoryIDs
						WHERE	CatName = <cfqueryparam value="#TRIM(Replace(ItemsList.Category,'Cost of Goods Sold:, ','','ALL'))#" cfsqltype="CF_SQL_VARCHAR">
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
									<cfqueryparam value="#TRIM(Replace(ItemsList.Category,'Cost of Goods Sold:, ','','ALL'))#" cfsqltype="CF_SQL_VARCHAR">,
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
						ERROR OCCURED ADDING PRODUCT-LEVEL CATEGORY AT RECORD NUMBER <b>#RecordNumber#</b> (#TRIM(Replace(ItemsList.Category,'Cost of Goods Sold:, ','','ALL'))#):<br/>
						#cfcatch.Message#<br/><cfset CategoryErrors = CategoryErrors + 1 >
					</cfcatch>
				</cftry>
				
				<!---<cftry>--->
					<cfquery name="InsertProductMain" datasource="#application.dsn#">
						INSERT INTO Products
							   (
								SiteID,
								SubItem,
								SKU, QB, ItemName, ItemDescription, Category,
								StockQuantity, Price1, Volume,							
								UseMatrix, SellByStock, ItemStatus, Weight, fldShipWeight,
								DateCreated, DateUpdated, UpdatedBy
							   )
						VALUES (
								<cfqueryparam value="1" cfsqltype="CF_SQL_INTEGER">,
								<cfqueryparam value="#ItemsList.PARENTREFFULLNAME#" cfsqltype="CF_SQL_VARCHAR">,
								
								<cfqueryparam value="#ItemsList.SKU#" cfsqltype="CF_SQL_VARCHAR">,
								<cfqueryparam value="#ItemsList.QB#" cfsqltype="CF_SQL_VARCHAR">,
								<cfqueryparam value="#ItemsList.ItemName#" cfsqltype="CF_SQL_VARCHAR">,
								<cfqueryparam value="#ItemsList.ItemDescription#" cfsqltype="CF_SQL_LONGVARCHAR">,
								<cfqueryparam value="#CategoryID#" cfsqltype="CF_SQL_INTEGER">,
								
								<cfqueryparam value="#NumberFormat(ThisStockQuantity,9)#" cfsqltype="CF_SQL_INTEGER">,
								<cfqueryparam value="#NumberFormat(ItemsList.Price1Ponsard,9.99)#" cfsqltype="CF_SQL_MONEY4">,
								<cfqueryparam value="#NumberFormat(ItemsList.Volume,9.99)#" cfsqltype="CF_SQL_MONEY4">,
								
								<cfqueryparam value="0" cfsqltype="CF_SQL_BIT">,
								<cfqueryparam value="1" cfsqltype="CF_SQL_BIT">,
								<cfqueryparam value="IS" cfsqltype="CF_SQL_VARCHAR">,
								<cfqueryparam value="#NumberFormat(ItemsList.Weight,9.999)#" cfsqltype="CF_SQL_FLOAT">,
								<cfqueryparam value="#NumberFormat(ItemsList.Weight,9.999)#" cfsqltype="CF_SQL_FLOAT">,
								
								<cfqueryparam value="#DateFormat(ItemsList.DateCreated,'mm/dd/yyyy')#" cfsqltype="CF_SQL_DATE">,
								<cfqueryparam value="#DateFormat(ItemsList.DateUpdated,'mm/dd/yyyy')#" cfsqltype="CF_SQL_DATE">,
								<cfqueryparam value="#UpdatedBy#" cfsqltype="CF_SQL_VARCHAR">
								)
					</cfquery>
				
					<cfset MainProductsAdded = MainProductsAdded + 1 >
					
					<!---<cfcatch>
						INSERT ERROR AT RECORD NUMBER <b>#RecordNumber#</b> (#ItemsList.PARENTREFFULLNAME#):<br/>
						#cfcatch.Message#<br/><cfset InsertErrors = InsertErrors + 1 >
					</cfcatch>
				</cftry>--->
	
			<!--- OTHERWISE, IF THIS PRODUCT IS ALREADY IN THE CARTFUSION DATABASE, UPDATE IT --->
			<cfelse>
				
				<cftry>
					<cfquery name="UpdateProductMain" datasource="#application.dsn#">
						UPDATE 	Products
						SET		SiteID = <cfqueryparam value="1" cfsqltype="CF_SQL_INTEGER">,
								SubItem = <cfqueryparam value="#ItemsList.PARENTREFFULLNAME#" cfsqltype="CF_SQL_VARCHAR">,
								
								SKU = <cfqueryparam value="#ItemsList.SKU#" cfsqltype="CF_SQL_VARCHAR">,
								ItemName = <cfqueryparam value="#ItemsList.ItemName#" cfsqltype="CF_SQL_VARCHAR">,
								ItemDescription = <cfqueryparam value="#ItemsList.ItemDescription#" cfsqltype="CF_SQL_LONGVARCHAR">,
								<!--- NOT GOING TO GO THROUGH THE WHOLE PROCESS OF UPDATING THE CATEGORY, JUST YET
								Category = <cfqueryparam value="#CategoryID#" cfsqltype="CF_SQL_INTEGER">,--->
								
								StockQuantity = <cfqueryparam value="#NumberFormat(ThisStockQuantity,9)#" cfsqltype="CF_SQL_INTEGER">,
								Price1 = <cfqueryparam value="#NumberFormat(ItemsList.Price1Ponsard,9.99)#" cfsqltype="CF_SQL_MONEY4">,
								Volume = <cfqueryparam value="#NumberFormat(ItemsList.Volume,9.99)#" cfsqltype="CF_SQL_MONEY4">,
								
								UseMatrix = <cfqueryparam value="0" cfsqltype="CF_SQL_BIT">,
								SellByStock = <cfqueryparam value="1" cfsqltype="CF_SQL_BIT">,
								ItemStatus = <cfqueryparam value="IS" cfsqltype="CF_SQL_VARCHAR">,
								Weight = <cfqueryparam value="#NumberFormat(ItemsList.Weight,9.999)#" cfsqltype="CF_SQL_FLOAT">,
								fldShipWeight = <cfqueryparam value="#NumberFormat(ItemsList.Weight,9.999)#" cfsqltype="CF_SQL_FLOAT">,
								
								DateUpdated = <cfqueryparam value="#DateFormat(ItemsList.DateUpdated,'mm/dd/yyyy')#" cfsqltype="CF_SQL_DATE">,
								UpdatedBy = <cfqueryparam value="#UpdatedBy#" cfsqltype="CF_SQL_VARCHAR">
								
						WHERE	QB = <cfqueryparam value="#ItemsList.QB#" cfsqltype="CF_SQL_VARCHAR">
					</cfquery>
					
					<cfset MainProductsUpdated = MainProductsUpdated + 1 >
					
					<cfcatch>
						UPDATE ERROR AT RECORD NUMBER <b>#RecordNumber#</b> (#ItemsList.PARENTREFFULLNAME#):<br/>
						#cfcatch.Message#<br/><cfset UpdateErrors = UpdateErrors + 1 >
					</cfcatch>
				</cftry>
			</cfif>
			
		</cfif><!--- IF PRODUCT IS LEGIT --->
		
	</cfloop>
	</cftransaction>
	</cfoutput>
	</font>
		
	<cfset AdminMsg = 'Products Imported From QuickBooks' >
	<cfset ShowResults = 1 >




<!--- INVENTORY UPDATER --->	
<cfelseif isDefined('FORM.UpdateInventory') >
	<!--- GET DATA --->
	<cftry>	
		<cfquery name="ItemsList" datasource="#QBDSN#">
			SELECT 	LISTID,
					FULLNAME AS QB,
					ISACTIVE AS Deleted,
					QUANTITYONHAND AS StockQuantity
			FROM 	ItemInventory
		</cfquery>
		
		<cfcatch>
			<table width="100%" border="1" bordercolor="EFEFEF" cellpadding="2" cellspacing="0">		
				<tr>
					<td nowrap="nowrap">
						There has been an error trying to communicate with your QuickBooks file.<br/><br/>
						Please make sure of the following:<br/>
						1) That the correct company file is open in QuickBooks<br/>
						2) That the QODBC Remote Connector is running<br/>
						3) That the computer running the QuickBooks file is connected to the Internet.<br/><br/>
						
						MESSAGE DETAILS:<br/>
						<cfoutput>
						#cfcatch.Message#<br/>
						#cfcatch.Detail#<br/>
						</cfoutput>
					</td>
				</tr>
			</table>
			<cfabort>			
		</cfcatch>
	</cftry>
	
	<!--- PREVIEW FILE CREATED --->
	<cfif Preview EQ 1 >		
		<table width="70%" border="1" bordercolor="EFEFEF" cellpadding="2" cellspacing="0">		
			<tr>
				<td nowrap="nowrap">
					<cfdump var="#ItemsList#" expand="no">
				</td>
			</tr>
		</table>
		<cfabort>
	</cfif>
	
	
	
	<font size="-1">
	<cfoutput>
	<cftransaction>
	
	<!--- LOOP THROUGH RECORDSET FROM QUICKBOOKS --->
	<cfloop query="ItemsList">

		<cfset RecordNumber = RecordNumber + 1 >
		
		<!--- IF PRODUCT IS LEGIT --->
		<cfif ItemsList.QB NEQ '' >
			
			<cftry>
				<cfquery name="UpdateProductMain" datasource="#application.dsn#">
					UPDATE 	Products
					SET		StockQuantity = <cfqueryparam value="#NumberFormat(ItemsList.StockQuantity,9)#" cfsqltype="CF_SQL_INTEGER">,
							DateUpdated = <cfqueryparam value="#DateUpdated#" cfsqltype="CF_SQL_DATE">,
							UpdatedBy = <cfqueryparam value="#UpdatedBy#" cfsqltype="CF_SQL_VARCHAR">
					WHERE	QB = <cfqueryparam value="#ItemsList.QB#" cfsqltype="CF_SQL_VARCHAR">
				</cfquery>

				<cfset MainProductsUpdated = MainProductsUpdated + 1 >
				
				<cfcatch>
					
					UPDATE ERROR AT RECORD NUMBER <b>#RecordNumber#</b> (#ItemsList.QB#):<br/>
					#cfcatch.Message#<br/>
					<cfset UpdateErrors = UpdateErrors + 1 >
					
				</cfcatch>
			</cftry>
			
		</cfif><!--- IF PRODUCT IS LEGIT --->
		
	</cfloop>
	</cftransaction>
	</cfoutput>
	</font>
		
	<cfset AdminMsg = 'Inventory Updated From QuickBooks' >
	<cfset ShowResults = 2 >
	
	
	
<!--- PRICE UPDATER --->	
<cfelseif isDefined('FORM.UpdatePrices') >
	<!--- GET DATA --->
	<cftry>
		<cfquery name="ItemsList" datasource="#QBDSN#">
			SELECT 	LISTID,
					FULLNAME AS QB,
					ISACTIVE AS Deleted,
					SALESPRICE AS Price1Ponsard,
					CUSTOMFIELDRETAILPRICE AS Price1Jarpy
			FROM 	ItemInventory
		</cfquery>
		
		<cfcatch>
			<table width="100%" border="1" bordercolor="EFEFEF" cellpadding="2" cellspacing="0">		
				<tr>
					<td nowrap="nowrap">
						There has been an error trying to communicate with your QuickBooks file.<br/><br/>
						Please make sure of the following:<br/>
						1) That the correct company file is open in QuickBooks<br/>
						2) That the QODBC Remote Connector is running<br/>
						3) That the computer running the QuickBooks file is connected to the Internet.<br/><br/>
						
						MESSAGE DETAILS:<br/>
						<cfoutput>
						#cfcatch.Message#<br/>
						#cfcatch.Detail#<br/>
						</cfoutput>
					</td>
				</tr>
			</table>
			<cfabort>			
		</cfcatch>
	</cftry>
	
	<!--- PREVIEW FILE CREATED --->
	<cfif Preview EQ 1 >		
		<table width="70%" border="1" bordercolor="EFEFEF" cellpadding="2" cellspacing="0">		
			<tr>
				<td nowrap="nowrap">
					<cfdump var="#ItemsList#" expand="no">
				</td>
			</tr>
		</table>
		<cfabort>
	</cfif>
	
	
	
	<font size="-1">
	<cfoutput>
	<cftransaction>
	
	<!--- LOOP THROUGH RECORDSET FROM QUICKBOOKS --->
	<cfloop query="ItemsList">

		<cfset RecordNumber = RecordNumber + 1 >
		
		<!--- IF PRODUCT IS LEGIT --->
		<cfif ItemsList.QB NEQ '' AND ItemsList.Price1Ponsard NEQ '' >
			
			<cftry>
				<cfquery name="UpdateProductMain" datasource="#application.dsn#">
					UPDATE 	Products
					SET		Price1 = <cfqueryparam value="#NumberFormat(ItemsList.Price1Ponsard,9.99)#" cfsqltype="CF_SQL_MONEY4">,
							DateUpdated = <cfqueryparam value="#DateUpdated#" cfsqltype="CF_SQL_DATE">,
							UpdatedBy = <cfqueryparam value="#UpdatedBy#" cfsqltype="CF_SQL_VARCHAR">
					WHERE	QB = <cfqueryparam value="#ItemsList.QB#" cfsqltype="CF_SQL_VARCHAR">
				</cfquery>
				
				<cfset MainProductsUpdated = MainProductsUpdated + 1 >
				
				<cfcatch>
					
					UPDATE ERROR AT RECORD NUMBER <b>#RecordNumber#</b> (#ItemsList.QB#):<br/>
					#cfcatch.Message#<br/>
					<cfset UpdateErrors = UpdateErrors + 1 >
					
				</cfcatch>
			</cftry>
			
		</cfif><!--- IF PRODUCT IS LEGIT --->
		
	</cfloop>
	</cftransaction>
	</cfoutput>
	</font>
		
	<cfset AdminMsg = 'Prices Updated From QuickBooks' >
	<cfset ShowResults = 2 >
	
	
	
</cfif>



<cfscript>
	PageTitle = 'QuickBooks Data Importer';
</cfscript>
<cfinclude template="../LayoutAdminHeader.cfm">
<cfoutput>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td width="50%" height="20" align="left" class="cfAdminTitle">
			<cfif isDefined('BannerTitle') AND BannerTitle NEQ ''><img src="images/banner-#BannerTitle#.gif">
			<cfelseif isDefined('PageTitle') AND PageTitle NEQ ''>#UCASE(PageTitle)#
			<cfelse>CARTFUSION
			</cfif>
			<cfif isDefined('AdminMsg')>&nbsp; <img src="../images/image-Message.gif"> <font class="cfAdminError">#AdminMsg#</font></cfif>
		</td>
		<td width="50%" align="right">
			<input type="button" name="Help" value="HELP" alt="CartFusion Help Desk" class="cfAdminButton"
				onClick="document.location.href='http://support.tradestudios.com'">
		</td>
	</tr>
	<tr><td height="1" colspan="2"><img src="../images/image-LineGray.gif" width="100%" height="1"></td></tr>
	<tr><td height="1" colspan="2"><img src="../images/image-LineWhite.gif" width="100%" height="1"></td></tr>
	<tr><td height="1" colspan="2"><img src="../images/image-LineGray.gif" width="100%" height="1"></td></tr>
</table>
</cfoutput>

<table width="100%" border="0" bordercolor="EFEFEF" cellpadding="7" cellspacing="0">
	<tr>
		<td width="100%" colspan="2" align="center">
			<img src="../images/logos/logo-QuickBooksLogo.jpg" border="0" align="absmiddle"> <img src="../images/icon-FileImporter.gif" border="0" align="absmiddle"><br>
		</td>
	</tr>
</table>

<table width="100%" border="1" bordercolor="EFEFEF" cellpadding="7" cellspacing="0">
	<tr>
		<!--- PRODUCT IMPORTER --->
		<cfform name="frmData1" action="QB-ImportFrom.cfm" method="post">
		<td width="33%" align="center">
			<div class="cfAdminHeader1">PRODUCT IMPORTER</div><br/>
			<table width="100%">
				<tr>
					<td width="100%" align="center" colspan="2">
						<input type="submit" name="ImportFromQB" value="IMPORT ALL PRODUCTS FROM QUICKBOOKS" alt="IMPORT ALL PRODUCTS FROM QUICKBOOKS" class="cfAdminButton"  onclick="this.value='(IMPORT PROCESSING...)'; return confirm('Are you sure you want to IMPORT ALL PRODUCTS FROM QUICKBOOKS?'); ">
					</td>
				</tr>
			</table>				
			<br><br>				
		</td>
		</cfform>
		<!--- STOCK QUANTITY UPDATER --->
		<cfform name="frmData2" action="QB-ImportFrom.cfm" method="post">
		<td width="33%" align="center">
			<div class="cfAdminHeader1">STOCK QUANTITY IMPORTER</div><br/>
			<table width="100%">
				<tr>
					<td width="100%" align="center" colspan="2">
						<input type="submit" name="UpdateInventory" value="IMPORT INVENTORY FROM QUICKBOOKS" alt="IMPORT INVENTORY FROM QUICKBOOKS" class="cfAdminButton" onclick="this.value='(IMPORT PROCESSING...)'; return confirm('Are you sure you want to IMPORT INVENTORY STOCK QUANTITIES FROM QUICKBOOKS?'); ">
					</td>
				</tr>
			</table>				
			<br><br>				
		</td>
		</cfform>
		<!--- RETAIL PRICE UPDATER --->
		<cfform name="frmData3" action="QB-ImportFrom.cfm" method="post">
		<td width="33%" align="center">
			<div class="cfAdminHeader1">PRICE<font class="cfAdminError">1</font> IMPORTER</div><br/>
			<table width="100%">
				<tr>
					<td width="100%" align="center" colspan="2">
						<input type="submit" name="UpdatePrices" value="IMPORT PRICES FROM QUICKBOOKS" alt="IMPORT PRICES FROM QUICKBOOKS" class="cfAdminButton" onclick="this.value='(IMPORT PROCESSING...)'; return confirm('Are you sure you want to IMPORT PRODUCT PRICES FROM QUICKBOOKS?'); ">
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
	<table width="50%" border="0" bordercolor="EFEFEF" cellpadding="7" cellspacing="0" align="center">
		<tr>
			<td width="100%" colspan="2" align="center" class="cfAdminTitle">
				IMPORT RESULTS
			</td>
		</tr>
	</table>
	<table width="50%" border="1" bordercolor="EFEFEF" cellpadding="7" cellspacing="0" align="center">
		<tr>
			<td width="100%" colspan="2" align="center" class="cfAdminTitle">
				<table width="100%" cellpadding="2" cellspacing="0" border="0">
					<tr>
						<td width="50%" align="right">Total Records Retrieved:</td>
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
	<table width="50%" border="0" bordercolor="EFEFEF" cellpadding="7" cellspacing="0" align="center">
		<tr>
			<td width="100%" colspan="2" align="center" class="cfAdminTitle">
				UPDATE RESULTS
			</td>
		</tr>
	</table>
	<table width="50%" border="1" bordercolor="EFEFEF" cellpadding="7" cellspacing="0" align="center">
		<tr>
			<td width="100%" colspan="2" align="center" class="cfAdminTitle">
				<table width="100%" cellpadding="2" cellspacing="0" border="0">
					<tr>
						<td width="50%" align="right">Total Records Retrieved:</td>
						<td width="50%" class="cfAdminError">#RecordNumber#</td>
					</tr>
					<tr>
						<td width="50%" align="right">Main Products Updated:</td>
						<td width="50%" class="cfAdminError">#MainProductsUpdated#</td>
					</tr>
					<tr>
						<td width="50%" align="right">Errors:</td>
						<td width="50%" class="cfAdminError">#OtherErrors#</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	</cfoutput>
</cfif>


<cfinclude template="../LayoutAdminFooter.cfm">