<!---
	CartFusion 4.6 - Copyright � 2005 Trade Studios, LLC.
	This copyright notice MUST stay intact for use (see license.txt).
	It is against the law to copy, distribute, gift, bundle or give away this code 
	without written consent from Trade Studios, LLC.
--->

<!--- SETUP TRACKING VARIABLES --->
<cfscript>
	DefaultAssetAccount = 'Inventory Items' ;
	DefaultCOGSAccount = 'Cost of Goods Sold' ;
	DefaultSalesAccount = 'Sales' ;
	DefaultVendorAccount = 'Style' ;
	Preview = 0 ;
	PreviewOnly = 0 ;
	ThisStockQuantity = 0 ;
	RecordNumber = 1 ;
	RecordsAtATime = 500 ;
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
	DateUpdated = CreateODBCDate(Now()) ;
	UpdatedBy = GetAuthUser() ;
</cfscript>

<!--- VENDOR EXPORT --->
<cfif isDefined('FORM.ExportVendorsToQB') >
	<!--- <cftry> --->
		<!--- <cfquery name="ReloadVendors" datasource="#QBDSN#">
			sp_optimizefullsync Vendor
		</cfquery>
		<cfquery name="ReloadVendorz" datasource="#QBDSN#">
			sp_optimizeupdatesync Vendor
		</cfquery> --->
		
		<cfquery name="UpdateVendor" datasource="#QBDSN#">
			UPDATE 	Vendor
			SET		Name = CompanyName
			WHERE	VendorTypeRefListID = 'A0000-1162316191'
		</cfquery>dun<cfabort>
					
		<cfquery name="FindVendors" datasource="#QBDSN#">
			SELECT 	ListID, Name, <!--- IsActive, --->CompanyName, FirstName, LastName<!--- , --->
					<!--- VendorAddressAddr1, VendorAddressAddr2, VendorAddressAddr3, VendorAddressAddr4, 
					VendorAddressCity, VendorAddressState, VendorAddressPostalCode, VendorAddressCountry, 
					Phone, AltPhone, Fax, Email, Contact, AltContact, NameOnCheck, 
					AccountNumber, Notes, VendorTypeRefListID, VendorTypeRefFullName, TermsRefListID, CreditLimit, VendorTaxIdent, IsVendorEligibleFor1099,
					OpenBalance, OpenBalanceDate, Balance, CustomFieldAccPacID --->
			FROM	Vendor
			<!--- UNOPTIMIZED --->
			WHERE	VendorTypeRefListID = 'A0000-1162316191'
			AND		FirstName IS NULL
		</cfquery>
		<cfdump var="#FindVendors#"> <cfabort> --->
		
		<cfoutput>
		<cftransaction>
		
			<!--- LOOP THROUGH RECORDSET FROM QUICKBOOKS --->
			<cfloop query="FindVendors">
				<cfif TRIM(FindVendors.FirstName) NEQ '' AND TRIM(FindVendors.LastName) NEQ '' >
					<cfquery name="UpdateVendor" datasource="#QBDSN#">
						UPDATE 	Vendor
						SET		Name = FirstName + ' ' + LastName
					</cfquery>
				<cfelse>
					<cfquery name="UpdateItem" datasource="#QBDSN#">
						UPDATE 	Vendor
						SET		Name = '#FindVendors.CompanyName#'
						WHERE	Name = '#FindVendors.Name#'
					</cfquery>
				</cfif>
			</cfloop>
		
		</cftransaction>
		</cfoutput>
		<cfabort>
		
		<!--- <cfcatch>
			<table width="100%" border="1" bordercolor="EFEFEF" cellpadding="2" cellspacing="0">		
				<tr>
					<td nowrap="nowrap">
						There has been an error trying to communicate with your QuickBooks file.<br/><br/>
						<hr>
						Please make sure of the following:<br/>
						1) That the correct company file is open in QuickBooks<br/>
						2) That the QODBC DCOM Server is running<br/>
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
	
	

<!--- PRODUCT EXPORT --->
<cfelseif isDefined('FORM.ExportToQB') >
	<!--- GET DATA FROM CARTFUSION --->
	<cftry>
		<cfquery name="getMainCategoryIDs" datasource="#application.dsn#">
			SELECT	CatID, CatName, SubCategoryOf
			FROM	Categories
			WHERE	SubCategoryOf IS NULL
			OR		SubCategoryOf = ''
		</cfquery>
		<cfquery name="getCategoryIDs" datasource="#application.dsn#">
			SELECT	CatID, CatName, SubCategoryOf
			FROM	Categories
			WHERE	SubCategoryOf IS NOT NULL
			AND		SubCategoryOf != ''
		</cfquery>		
		<cfquery name="ItemsList" datasource="#application.dsn#">
			SELECT 	ItemID,
					SKU AS NAME,
					QB AS FULLNAME,
					Deleted <!---AS ISACTIVE - Have to reverse 0/1 --->,
					Category,
					CostPrice AS PURCHASECOST,
					ItemName AS SALESDESC,
					Price1 AS SALESPRICE, <!--- PONSARD PRICE - REVERSE Price1/Price2 FOR JARPY --->
					Price2 AS CUSTOMFIELDRETAILPRICE, <!--- PONSARD PRICE - REVERSE Price1/Price2 FOR JARPY --->
					ItemDescription AS CUSTOMFIELDINTERNETDESCRIPTION,
					Volume AS CUSTOMFIELDVOLUMEPTS,
					Weight AS CUSTOMFIELDWEIGHTLBS,
					StockQuantity AS QUANTITYONHAND,
					SubItem,
					Comments AS PURCHASEDESC
			FROM 	Products
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
	
	<!--- GET ALL-FIELDS DATA FROM QUICKBOOKS --->
	<cftry>
		<cfquery name="FindProducts" datasource="#QBDSN#">
			SELECT 	ListID, Name, FullName, ParentRefListID, ParentRefFullName, COGSAccountRefListID
			FROM	ItemInventory
			VERIFY	<!------>
		</cfquery>
		<cfquery name="FindaProduct" dbtype="query">
			SELECT 	ListID, Name, FullName, COGSAccountRefListID
			FROM	FindProducts
			WHERE	FullName = 'AC:16000'
		</cfquery>

		<cfquery name="UpdaterQuantity1" datasource="#QBDSN#">
			INSERT INTO InventoryAdjustmentLine
						( AccountRefListID, TxnDate, RefNumber, Memo, InventoryAdjustmentLineItemRefListID, 
						  InventoryAdjustmentLineQuantityAdjustmentNewQuantity, FQSaveToCache )
			VALUES		('#FindaProduct.COGSAccountRefListID#', {d'2006-10-30'}, '1', '#FindaProduct.FullName#', '#FindaProduct.ListID#', 200.0, 1)
		</cfquery>

		<cfquery name="getLastInsertID" datasource="#QBDSN#">
			sp_lastinsertid InventoryAdjustmentLine
		</cfquery>
		
		<cfdump var="LastInsertID #getLastInsertID.LastInsertID#"><br/><br/>
					
		<cfdump var="#FindaProduct#">
		
		<cfquery name="FindaInventoryAdjustmentLine" datasource="#QBDSN#">
			SELECT 	TOP 10 *
			FROM	InventoryAdjustmentLine
		</cfquery><cfdump var="#FindaInventoryAdjustmentLine#"><cfabort>
		
		
		<cfquery name="FindAccountListID" datasource="#QBDSN#">
			SELECT 	ListID, Name, FullName, ParentRefListID, AccountType
			FROM	Account
			VERIFY	<!------>
		</cfquery>
		<cfquery name="FindPrefVendorRefListID" datasource="#QBDSN#">
			SELECT 	ListID, Name
			FROM	Vendor
			VERIFY	<!------>
		</cfquery>
		
		<!--- <cfset newQuery = QueryNew("ListID, Name, Type","VarChar, VarChar, VarChar") ><!--- VarChar, Time, Bit --->
		<cfset newRow = QueryAddRow(FindPrefVendorRefListID) >
		<cfset temp = QuerySetCell(FindPrefVendorRefListID, "ListID", "Johnny Apes") >
		<cfdump var="#temp#"><cfdump var="#FindPrefVendorRefListID#"><cfabort> --->
		
		<cfcatch>
			<table width="100%" border="1" bordercolor="EFEFEF" cellpadding="2" cellspacing="0">		
				<tr>
					<td nowrap="nowrap">
						There has been an error trying to communicate with your QuickBooks file.<br/><br/>
						<hr>
						Please make sure of the following:<br/>
						1) That the correct company file is open in QuickBooks<br/>
						2) That the QODBC DCOM Server is running<br/>
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
	
	<!--- GET CUSTOM-VALUES DATA FROM QUICKBOOKS --->
	<cftry>
		<cfquery name="FindAssetAccountRefListID" dbtype="query">
			SELECT 	ListID
			FROM	FindAccountListID
			WHERE	Name = '#DefaultAssetAccount#'
			AND		AccountType = 'OtherCurrentAsset'
		</cfquery>
		<cfquery name="FindCOGSAccountRefListID" dbtype="query">
			SELECT 	ListID
			FROM	FindAccountListID
			WHERE	Name = '#DefaultCOGSAccount#'
			AND		AccountType = 'CostOfGoodsSold'
		</cfquery>
		<cfquery name="FindSalesAccountListID" dbtype="query">
			SELECT 	ListID
			FROM	FindAccountListID
			WHERE	Name = '#DefaultSalesAccount#'
			AND		AccountType = 'Income'
		</cfquery>
		<cfquery name="FindDefaultVendorListID" dbtype="query">
			SELECT 	ListID
			FROM	FindPrefVendorRefListID
			WHERE	Name = '#DefaultVendorAccount#'
		</cfquery>
		<!---
		<cfdump var="#FindAssetAccountRefListID.ListID#" label="FindAssetAccountRefListID"><br/>
		<cfdump var="#FindCOGSAccountRefListID.ListID#" label="FindCOGSAccountRefListID"><br/>
		<cfdump var="#FindSalesAccountListID.ListID#" label="FindSalesAccountListID"><br/>
		<cfdump var="#FindDefaultVendorListID.ListID#" label="FindDefaultVendorListID"><br/><br/>
		<cfabort>--->
		
		<!--- ERROR HANDLING --->
		<cfif FindAssetAccountRefListID.RecordCount EQ 0 OR TRIM(FindAssetAccountRefListID.ListID) EQ '' >
			<table width="100%" border="1" bordercolor="EFEFEF" cellpadding="2" cellspacing="0">		
				<tr>
					<td nowrap="nowrap">
						ERROR: There has been an error trying to locate the default <b>Asset Account</b> within your QuickBooks file.<br/><br/>
						<hr>
						Please make sure of the following:<br/>
						1) That you have set these defaults in CartFusion and they are in your QuickBooks file.<br/>
						&nbsp;&nbsp;- Asset Account<br/>
						&nbsp;&nbsp;- Cost Of Goods Sold (COGS) Account<br/>
						&nbsp;&nbsp;- Sales Account<br/>
						&nbsp;&nbsp;- Vendor Account<br/>
						2) That the correct company file is open in QuickBooks<br/>
						3) That the QODBC DCOM Server is running<br/>
						4) That the computer running the QuickBooks file is connected to the Internet.<br/><br/>
					</td>
				</tr>
			</table><cfabort>
		<cfelseif FindCOGSAccountRefListID.RecordCount EQ 0 OR TRIM(FindCOGSAccountRefListID.ListID) EQ '' >
			<table width="100%" border="1" bordercolor="EFEFEF" cellpadding="2" cellspacing="0">		
				<tr>
					<td nowrap="nowrap">
						ERROR: There has been an error trying to locate the default <b>Cost Of Goods Sold Account</b> within your QuickBooks file.<br/><br/>
						<hr>
						Please make sure of the following:<br/>
						1) That you have set these defaults in CartFusion and they are in your QuickBooks file.<br/>
						&nbsp;&nbsp;- Asset Account<br/>
						&nbsp;&nbsp;- Cost Of Goods Sold (COGS) Account<br/>
						&nbsp;&nbsp;- Sales Account<br/>
						&nbsp;&nbsp;- Vendor Account<br/>
						2) That the correct company file is open in QuickBooks<br/>
						3) That the QODBC DCOM Server is running<br/>
						4) That the computer running the QuickBooks file is connected to the Internet.<br/><br/>
					</td>
				</tr>
			</table><cfabort>
		<cfelseif FindSalesAccountListID.RecordCount EQ 0 OR TRIM(FindSalesAccountListID.ListID) EQ '' >
			<table width="100%" border="1" bordercolor="EFEFEF" cellpadding="2" cellspacing="0">		
				<tr>
					<td nowrap="nowrap">
						ERROR: There has been an error trying to locate the default <b>Sales Account</b> within your QuickBooks file.<br/><br/>
						<hr>
						Please make sure of the following:<br/>
						1) That you have set these defaults in CartFusion and they are in your QuickBooks file.<br/>
						&nbsp;&nbsp;- Asset Account<br/>
						&nbsp;&nbsp;- Cost Of Goods Sold (COGS) Account<br/>
						&nbsp;&nbsp;- Sales Account<br/>
						&nbsp;&nbsp;- Vendor Account<br/>
						2) That the correct company file is open in QuickBooks<br/>
						3) That the QODBC DCOM Server is running<br/>
						4) That the computer running the QuickBooks file is connected to the Internet.<br/><br/>
					</td>
				</tr>
			</table><cfabort>
		<cfelseif FindDefaultVendorListID.RecordCount EQ 0 OR TRIM(FindDefaultVendorListID.ListID) EQ '' >
			<table width="100%" border="1" bordercolor="EFEFEF" cellpadding="2" cellspacing="0">		
				<tr>
					<td nowrap="nowrap">
						ERROR: There has been an error trying to locate the default <b>Vendor Account</b> within your QuickBooks file.<br/><br/>
						<hr>
						Please make sure of the following:<br/>
						1) That you have set these defaults in CartFusion and they are in your QuickBooks file.<br/>
						&nbsp;&nbsp;- Asset Account<br/>
						&nbsp;&nbsp;- Cost Of Goods Sold (COGS) Account<br/>
						&nbsp;&nbsp;- Sales Account<br/>
						&nbsp;&nbsp;- Vendor Account<br/>
						2) That the correct company file is open in QuickBooks<br/>
						3) That the QODBC DCOM Server is running<br/>
						4) That the computer running the QuickBooks file is connected to the Internet.<br/><br/>
					</td>
				</tr>
			</table><cfabort>
		</cfif>
		
		<cfcatch>
			<table width="100%" border="1" bordercolor="EFEFEF" cellpadding="2" cellspacing="0">		
				<tr>
					<td nowrap="nowrap">
						ERROR: There has been an error trying to locate the default Asset Account, COGS Account, Sales Account, and/or Vendor Account within your QuickBooks file.<br/><br/>
						<hr>
						Please make sure of the following:<br/>
						1) That you have set these defaults in CartFusion and they are in your QuickBooks file.<br/>
						&nbsp;&nbsp;- Asset Account<br/>
						&nbsp;&nbsp;- Cost Of Goods Sold (COGS) Account<br/>
						&nbsp;&nbsp;- Sales Account<br/>
						&nbsp;&nbsp;- Vendor Account<br/>
						2) That the correct company file is open in QuickBooks<br/>
						3) That the QODBC DCOM Server is running<br/>
						4) That the computer running the QuickBooks file is connected to the Internet.<br/><br/> 
						
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
	<cfif Preview EQ 1 OR PreviewOnly EQ 1 >		
		<table width="100%" border="1" bordercolor="EFEFEF" cellpadding="2" cellspacing="0">		
			<tr>
				<td nowrap="nowrap">
					<cfdump var="#FindAssetAccountRefListID#" label="FindAssetAccountRefListID"><br/>
					<cfdump var="#FindCOGSAccountRefListID#" label="FindCOGSAccountRefListID"><br/>
					<cfdump var="#FindSalesAccountListID#" label="FindSalesAccountListID"><br/>
					<cfdump var="#FindDefaultVendorListID#" label="FindDefaultVendorListID"><br/>
					<cfdump var="#getMainCategoryIDs#" label="getMainCategoryIDs" expand="no"><br/>
					<cfdump var="#getCategoryIDs#" label="getCategoryIDs" expand="no"><br/>
					<!---<cfdump var="#ItemsList#" expand="no"><br/>
					<cfdump var="#FindProducts#" expand="yes"><br/>
					<cfdump var="#FindAccountListID#" expand="yes"><br/>
					<cfdump var="#FindPrefVendorRefListID#" expand="yes"><br/>
					<cfdump var="#FindAssetAccountRefListID#" expand="yes"><br/>--->
				</td>
			</tr>
		</table>
		<cfif PreviewOnly EQ 1 ><cfabort></cfif>
	</cfif>
	
	
	
	
	
	<!--- Loop in intervals of X records, by setting a "GoAhead" value after each transaction --->
	<font size="-1">
	<cfoutput>
	<cftransaction>
	
	<!--- LOOP THROUGH RECORDSET FROM QUICKBOOKS --->
	<cfloop query="ItemsList" startrow="#RecordNumber#" endrow="#(RecordNumber + RecordsAtATime)#">
				
		<!--- IF PRODUCT IS LEGIT --->
		<cfif TRIM(ItemsList.NAME) NEQ '' >
			
			<!--- SEE IF THIS PRODUCT IS ALREADY IN QUICKBOOKS --->
			<!---<cftry>--->
				<cfif (TRIM(ItemsList.SubItem) NEQ '' AND ItemsList.FULLNAME CONTAINS '#ItemsList.SubItem#:') 
				   OR (TRIM(ItemsList.SubItem) EQ '' AND TRIM(ItemsList.NAME) NEQ '' AND TRIM(ItemsList.FULLNAME) EQ TRIM(ItemsList.NAME))>
					<cfquery name="FindProductMain" dbtype="query">
						SELECT 	ListID, Name, ParentRefListID
						FROM	FindProducts
						WHERE	Name = <cfqueryparam value="#ItemsList.NAME#" cfsqltype="CF_SQL_VARCHAR">
						OR	   	FullName = <cfqueryparam value="#ItemsList.FULLNAME#" cfsqltype="CF_SQL_VARCHAR">
					</cfquery>
				<cfelseif TRIM(ItemsList.SubItem) EQ '' AND TRIM(ItemsList.NAME) NEQ '' >
					<cfquery name="FindProductMain" dbtype="query">
						SELECT 	ListID, Name, ParentRefListID
						FROM	FindProducts
						WHERE	Name = <cfqueryparam value="#ItemsList.NAME#" cfsqltype="CF_SQL_VARCHAR">
						AND	   	ParentRefFullName = ''
					</cfquery>
				<cfelse>
					<cfquery name="FindProductMain" dbtype="query">
						SELECT 	ListID, Name, ParentRefListID
						FROM	FindProducts
						<!---WHERE	FullName = <cfqueryparam value="#ItemsList.FULLNAME#" cfsqltype="CF_SQL_VARCHAR">
						OR	   (Name = <cfqueryparam value="#ItemsList.NAME#" cfsqltype="CF_SQL_VARCHAR">
						AND	   (ParentRefFullName = <cfqueryparam value="#ItemsList.SubItem#" cfsqltype="CF_SQL_VARCHAR">
						OR		ParentRefFullName = '' ))--->
						WHERE	Name = <cfqueryparam value="#ItemsList.NAME#" cfsqltype="CF_SQL_VARCHAR">
						OR	   	FullName = <cfqueryparam value="#ItemsList.FULLNAME#" cfsqltype="CF_SQL_VARCHAR">
					</cfquery>
				</cfif>
				<!---<cfdump var="#FindProductMain#" label="FindProductMain">--->
				<!---#ItemsList.FULLNAME# - #ItemsList.NAME# - (#ItemsList.SubItem#)<br/>--->
				
				<!---<cfcatch>
					COULDN'T FIND PRODUCT AT RECORD NUMBER <b>#RecordNumber#</b> (#ItemsList.FULLNAME#):<br/>
					#cfcatch.Message#<br/><cfset OtherErrors = OtherErrors + 1 >
				</cfcatch>
			</cftry>--->
			
			<!--- IF THIS PRODUCT IS NOT ALREADY IN QUICKBOOKS, ADD IT --->
			<cfif FindProductMain.RecordCount EQ 0 >
				<!--- RETRIEVE AND INSERT MAIN CATEGORIES --->
				<!---<cftry>--->
					<cfquery name="LookupMainCatName" dbtype="query">
						SELECT	CatID, CatName, SubCategoryOf
						FROM	getMainCategoryIDs
						WHERE	CatID = <cfqueryparam value="#ItemsList.Category#" cfsqltype="CF_SQL_INTEGER">
					</cfquery>
					<!------><cfdump var="LookupMainCatName.CatName #LookupMainCatName.CatName# (#ItemsList.Category#)"><br/>
					
					<cfquery name="getMainCategoryID" dbtype="query">
						SELECT 	ListID, Name
						FROM	FindPrefVendorRefListID
						<cfif LookupMainCatName.CatName NEQ '' >
						WHERE	Name = 'Style, #LookupMainCatName.CatName#'
						<cfelse>
						WHERE	Name = 'Style, #ItemsList.Category#'
						</cfif>
					</cfquery>
					<!------><cfdump var="getMainCategoryID.ListID #getMainCategoryID.ListID#"><br/>
					
					<!---<cfcatch>
						COULDN'T FIND MAIN CATEGORY AT RECORD NUMBER <b>#RecordNumber#</b> (#ItemsList.FULLNAME#):<br/>
						#cfcatch.Message#<br/><cfset OtherErrors = OtherErrors + 1 >
					</cfcatch>
				</cftry>--->
			
				<!--- IF THIS MAIN CATEGORY IS NOT ALREADY IN QUICKBOOKS, ADD IT --->
				<!--- Put main category in as a QuickBooks Vendor -- put in as "Style, #CatName#" --->
				<!---<cftry>--->
					<cfif getMainCategoryID.RecordCount NEQ 0 AND getMainCategoryID.ListID NEQ '' >
						<cfset MainCategoryID = getMainCategoryID.ListID >
					<cfelseif LookupMainCatName.RecordCount NEQ 0 AND TRIM(LookupMainCatName.CatName) NEQ '' AND TRIM(LookupMainCatName.CatName) NEQ ItemsList.Category >
						<cfquery name="insertMainCategory" datasource="#QBDSN#">
							INSERT INTO Vendor ( Name, IsActive )
							VALUES ( 'Style, #TRIM(LookupMainCatName.CatName)#', 1 )
						</cfquery>
						<cfquery name="getLastInsertID" datasource="#QBDSN#">
							sp_lastinsertid Vendor
						</cfquery><!------><cfdump var="Vendor: Style, #TRIM(LookupMainCatName.CatName)# #getLastInsertID.LastInsertID#"><br/>
						<cfscript>
							if ( isDefined('getLastInsertID.ListID') ){
								MainCategoryID = getLastInsertID.ListID ;
								MainCategoriesAdded = MainCategoriesAdded + 1 ; }
							else
								MainCategoryID = FindDefaultVendorListID.ListID ;
							newRow = QueryAddRow(FindPrefVendorRefListID) ;
							temp = QuerySetCell(FindPrefVendorRefListID, "ListID", MainCategoryID) ;
							temp = QuerySetCell(FindPrefVendorRefListID, "Name", TRIM(LookupMainCatName.CatName)) ;
						</cfscript>
					<cfelse>
						<cfquery name="insertMainCategory" datasource="#QBDSN#">
							INSERT INTO Vendor ( Name, IsActive )
							VALUES ( 'Style, #ItemsList.Category#', 1 )
						</cfquery>
						<cfquery name="getLastInsertID" datasource="#QBDSN#">
							sp_lastinsertid Vendor
						</cfquery><!------><cfdump var="Vendor: Style, #ItemsList.Category# #getLastInsertID.LastInsertID#"><br/>
						<cfscript>
							if ( isDefined('getLastInsertID.ListID') ){
								MainCategoryID = getLastInsertID.ListID ;
								MainCategoriesAdded = MainCategoriesAdded + 1 ; }
							else
								MainCategoryID = FindDefaultVendorListID.ListID ;
							newRow = QueryAddRow(FindPrefVendorRefListID) ;
							temp = QuerySetCell(FindPrefVendorRefListID, "ListID", MainCategoryID) ;
							temp = QuerySetCell(FindPrefVendorRefListID, "Name", "Style, #ItemsList.Category#") ;
						</cfscript>
					</cfif>
				
					<!---<cfcatch>
						ERROR OCCURED ADDING MAIN CATEGORY AT RECORD NUMBER <b>#RecordNumber#</b> (#ItemsList.FULLNAME# #TRIM(LookupMainCatName.CatName)#):<br/>
						#cfcatch.Message#<br/><cfset CategoryErrors = CategoryErrors + 1 >
					</cfcatch>
				</cftry>--->
				
				<!--- RETRIEVE AND INSERT PRODUCT-LEVEL CATEGORIES --->
				<!---<cftry>--->
					<cfquery name="LookupCatName" dbtype="query">
						SELECT	CatID, CatName, SubCategoryOf
						FROM	getCategoryIDs
						WHERE	CatID = <cfqueryparam value="#ItemsList.Category#" cfsqltype="CF_SQL_INTEGER">
					</cfquery>
					<!------><cfdump var="LookupCatName.CatName #LookupCatName.CatName# (#ItemsList.Category#)"><br/>
					<cfquery name="getCategoryID" dbtype="query">
						SELECT 	ListID, Name
						FROM	FindAccountListID
						<cfif LookupCatName.CatName NEQ '' >
						WHERE	Name = '#LookupCatName.CatName#'
						<cfelse>
						WHERE	Name = '#ItemsList.Category#'
						</cfif>
					</cfquery>
					<!------><cfdump var="getCategoryID.ListID #getCategoryID.ListID#"><br/>
				
					<!---<cfcatch>
						COULDN'T FIND PRODUCT-LEVEL CATEGORY AT RECORD NUMBER <b>#RecordNumber#</b> (#ItemsList.FULLNAME#):<br/>
						#cfcatch.Message#<br/><cfset OtherErrors = OtherErrors + 1 >
					</cfcatch>
				</cftry>--->
			
				<!--- IF THIS PRODUCT-LEVEL CATEGORY IS NOT ALREADY IN QUICKBOOKS, ADD IT --->
				<!--- Put product-level category in as a QuickBooks Income Account -- put in as "#CatName#" --->
				<!---<cftry>--->
					<cfif getCategoryID.RecordCount NEQ 0 AND getCategoryID.ListID NEQ '' >
						<cfset CategoryID = getCategoryID.ListID >
					<cfelseif LookupCatName.RecordCount NEQ 0 AND TRIM(LookupCatName.CatName) NEQ '' AND TRIM(LookupCatName.CatName) NEQ ItemsList.Category >
						<cfquery name="insertCategory" datasource="#QBDSN#">
							INSERT INTO Account
								   ( Name, AccountType, ParentRefListID )
							VALUES ( '#TRIM(LookupCatName.CatName)#', 'Income', '#FindSalesAccountListID.ListID#' )
						</cfquery>
						<cfquery name="getLastInsertID" datasource="#QBDSN#">
							sp_lastinsertid Account
						</cfquery>
						<cfscript>
							if ( isDefined('getLastInsertID.ListID') ){
								CategoryID = getLastInsertID.ListID ;
								CategoriesAdded = CategoriesAdded + 1 ; }
							else
								CategoryID = FindSalesAccountListID.ListID ;
							newRow = QueryAddRow(FindAccountListID) ;
							temp = QuerySetCell(FindAccountListID, "ListID", CategoryID) ;
							temp = QuerySetCell(FindAccountListID, "Name", TRIM(LookupCatName.CatName)) ;
						</cfscript>
					<cfelse>
						<cfquery name="insertCategory" datasource="#QBDSN#">
							INSERT INTO Account
								   ( Name, AccountType, ParentRefListID )
							VALUES ( '#ItemsList.Category#', 'Income', '#FindSalesAccountListID.ListID#' )
						</cfquery>						
						<cfquery name="getLastInsertID" datasource="#QBDSN#">
							sp_lastinsertid Account
						</cfquery>
						<cfscript>
							if ( isDefined('getLastInsertID.ListID') ){
								CategoryID = getLastInsertID.ListID ;
								CategoriesAdded = CategoriesAdded + 1 ; }
							else
								CategoryID = FindSalesAccountListID.ListID ;
							newRow = QueryAddRow(FindAccountListID) ;
							temp = QuerySetCell(FindAccountListID, "ListID", CategoryID) ;
							temp = QuerySetCell(FindAccountListID, "Name", ItemsList.Category) ;
						</cfscript>
					</cfif>
					
					<!---<cfcatch>
						ERROR OCCURED ADDING PRODUCT-LEVEL CATEGORY AT RECORD NUMBER <b>#RecordNumber#</b> (#ItemsList.FULLNAME# #TRIM(LookupCatName.CatName)#):<br/>
						#cfcatch.Message#<br/><cfset CategoryErrors = CategoryErrors + 1 >
					</cfcatch>
				</cftry>--->
				
				<!---<cfdump var="#FindAssetAccountRefListID#" label="FindAssetAccountRefListID"><br/>--->
				<!---<cfdump var="#FindSalesAccountListID#" label="FindSalesAccountListID"><br/>--->
				<!---<cfdump var="#FindDefaultVendorListID#" label="FindDefaultVendorListID"><br/>--->
				<!--- ADD THE PRODUCT TO QUICKBOOKS --->
				<!---<cftry>--->
					<cfquery name="InsertItem" datasource="#QBDSN#">
						INSERT INTO ItemInventory
							   (
								Name,
								IsActive,
								<cfif TRIM(FindProductMain.ParentRefListID) NEQ '' >
								ParentRefListID,
								</cfif>
								SalesDesc,
								SalesPrice,
								IncomeAccountRefListID,
								PurchaseDesc,
								PurchaseCost,
								COGSAccountRefListID,
								PrefVendorRefListID,
								AssetAccountRefListID,						
								<!---ReorderPoint,--->
								QuantityOnHand,
								<!---TotalValue,--->
								InventoryDate<!---,								
								CUSTOMFIELDRETAILPRICE,
								CUSTOMFIELDINTERNETDESCRIPTION,
								CUSTOMFIELDVOLUMEPTS,
								CUSTOMFIELDWEIGHTLBS--->
							   )
						VALUES (
								<cfqueryparam value="#ItemsList.NAME#" cfsqltype="CF_SQL_VARCHAR">,
								<cfif ItemsList.Deleted EQ 1 >
								FALSE,
								<cfelse>
								TRUE,
								</cfif>
								<cfif TRIM(FindProductMain.ParentRefListID) NEQ '' >
								<cfqueryparam value="#FindProductMain.ParentRefListID#" cfsqltype="CF_SQL_VARCHAR">,
								</cfif>
								<cfqueryparam value="#ItemsList.SALESDESC#" cfsqltype="CF_SQL_VARCHAR">,
								<cfqueryparam value="#NumberFormat(ItemsList.SALESPRICE,9.99)#" cfsqltype="CF_SQL_MONEY4">,
								<cfqueryparam value="#FindSalesAccountListID.ListID#" cfsqltype="CF_SQL_VARCHAR">,
								<cfqueryparam value="#ItemsList.PURCHASEDESC#" cfsqltype="CF_SQL_VARCHAR">,
								<cfqueryparam value="#NumberFormat(ItemsList.PURCHASECOST,9.99)#" cfsqltype="CF_SQL_MONEY4">,
								<cfqueryparam value="#FindCOGSAccountRefListID.ListID#" cfsqltype="CF_SQL_VARCHAR">,
								<cfqueryparam value="#FindDefaultVendorListID.ListID#" cfsqltype="CF_SQL_VARCHAR">,
								<cfqueryparam value="#FindAssetAccountRefListID.ListID#" cfsqltype="CF_SQL_VARCHAR">,
								<cfqueryparam value="#ItemsList.QUANTITYONHAND#" cfsqltype="CF_SQL_INTEGER">,
								<cfqueryparam value="#DateUpdated#" cfsqltype="CF_SQL_DATE">
								<!--- NOT ALLOWED
								<cfqueryparam value="#ItemsList.CUSTOMFIELDINTERNETDESCRIPTION#" cfsqltype="CF_SQL_VARCHAR">,
								<cfqueryparam value="#NumberFormat(ItemsList.CUSTOMFIELDRETAILPRICE,9.99)#" cfsqltype="CF_SQL_FLOAT">,
								<cfqueryparam value="#NumberFormat(ItemsList.CUSTOMFIELDVOLUMEPTS,9.99)#" cfsqltype="CF_SQL_FLOAT">,
								<cfqueryparam value="#NumberFormat(ItemsList.CUSTOMFIELDWEIGHTLBS,9.999)#" cfsqltype="CF_SQL_FLOAT">
								--->
								)
					</cfquery>
				
					<cfset MainProductsAdded = MainProductsAdded + 1 >
					
					<cfquery name="getLastInsertID" datasource="#QBDSN#">
						sp_lastinsertid ItemInventory
					</cfquery>
					
					<cfdump var="LastInsertID #getLastInsertID.LastInsertID#"><br/><br/>

					<!---<cfcatch>
						INSERT ERROR AT RECORD NUMBER <b>#RecordNumber#</b> (#ItemsList.NAME#):<br/>
						#cfcatch.Message#<br/><cfset InsertErrors = InsertErrors + 1 >
					</cfcatch>
				</cftry>--->
	
			<!--- OTHERWISE, IF THIS PRODUCT IS ALREADY IN QUICKBOOKS, UPDATE IT --->
			<cfelse>
				<!---<cftry>--->
					<cfquery name="UpdateItem" datasource="#QBDSN#">
						UPDATE 	ItemInventory
						SET		Name = <cfqueryparam value="#ItemsList.NAME#" cfsqltype="CF_SQL_VARCHAR">,
								<cfif ItemsList.Deleted EQ 1 >
								IsActive = FALSE,
								<cfelse>
								IsActive = TRUE,
								</cfif>
								<cfif TRIM(FindProductMain.ParentRefListID) NEQ '' >
								ParentRefListID = <cfqueryparam value="#FindProductMain.ParentRefListID#" cfsqltype="CF_SQL_VARCHAR">,
								</cfif>
								SalesDesc = <cfqueryparam value="#ItemsList.SALESDESC#" cfsqltype="CF_SQL_VARCHAR">,
								SalesPrice = <cfqueryparam value="#NumberFormat(ItemsList.SALESPRICE,9.99)#" cfsqltype="CF_SQL_MONEY4">,
								<!--- NOT ALLOWED
								IncomeAccountRefListID = <cfqueryparam value="#FindSalesAccountListID.ListID#" cfsqltype="CF_SQL_VARCHAR">,
								--->
								PurchaseDesc = <cfqueryparam value="#ItemsList.PURCHASEDESC#" cfsqltype="CF_SQL_VARCHAR">,
								PurchaseCost = <cfqueryparam value="#NumberFormat(ItemsList.PURCHASECOST,9.99)#" cfsqltype="CF_SQL_MONEY4">,
								<!--- Disabled - Needs accurate information gathered and set
								COGSAccountRefListID = <cfqueryparam value="#FindCOGSAccountRefListID.ListID#" cfsqltype="CF_SQL_VARCHAR">,
								PrefVendorRefListID = <cfqueryparam value="#FindDefaultVendorListID.ListID#" cfsqltype="CF_SQL_VARCHAR">,
								AssetAccountRefListID = <cfqueryparam value="#FindAssetAccountRefListID.ListID#" cfsqltype="CF_SQL_VARCHAR">,
								--->
								<!---ReorderPoint = ,--->
								<!--- NOT ALLOWED
								QuantityOnHand = <cfqueryparam value="#ItemsList.QUANTITYONHAND#" cfsqltype="CF_SQL_INTEGER">,
								<!---TotalValue = ,--->
								InventoryDate = <cfqueryparam value="#DateUpdated#" cfsqltype="CF_SQL_DATE">,
								--->
								<!--- CUSTOM FIELDS --->
								CUSTOMFIELDINTERNETDESCRIPTION = <cfqueryparam value="#ItemsList.CUSTOMFIELDINTERNETDESCRIPTION#" cfsqltype="CF_SQL_VARCHAR">,
								CUSTOMFIELDRETAILPRICE = <cfqueryparam value="#NumberFormat(ItemsList.CUSTOMFIELDRETAILPRICE,9.99)#" cfsqltype="CF_SQL_FLOAT">,
								CUSTOMFIELDVOLUMEPTS = <cfqueryparam value="#NumberFormat(ItemsList.CUSTOMFIELDVOLUMEPTS,9.99)#" cfsqltype="CF_SQL_FLOAT">,
								CUSTOMFIELDWEIGHTLBS = <cfqueryparam value="#NumberFormat(ItemsList.CUSTOMFIELDWEIGHTLBS,9.999)#" cfsqltype="CF_SQL_FLOAT">
								
						WHERE	LISTID = <cfqueryparam value="#FindProductMain.LISTID#" cfsqltype="CF_SQL_VARCHAR">
						<!---AND		FULLNAME = <cfqueryparam value="#ItemsList.FULLNAME#" cfsqltype="CF_SQL_VARCHAR">--->
					</cfquery>
					
					<cfset MainProductsUpdated = MainProductsUpdated + 1 >
					<!---
					<cfcatch>
						UPDATE ERROR AT RECORD NUMBER <b>#RecordNumber#</b> (#ItemsList.NAME#):<br/>
						#cfcatch.Message#<br/><cfset UpdateErrors = UpdateErrors + 1 >
					</cfcatch>
				</cftry>--->
			</cfif>
			
		</cfif><!--- IF PRODUCT IS LEGIT --->

		<cfset RecordNumber = RecordNumber + 1 >

	</cfloop>
	</cftransaction>
	</cfoutput>
	</font>
		
	<cfset AdminMsg = 'Product Import Successful!' >
	<cfset ShowResults = 1 >




<!--- INVENTORY UPDATER --->	
<cfelseif isDefined('FORM.UpdateInventory') >
	<!--- GET DATA --->
	<cftry>	
		<cfquery name="ItemsList" datasource="#QBDSN#">
			SELECT 	FULLNAME AS QB,
					ISACTIVE AS Deleted,
					LISTID
			FROM 	Item
		</cfquery>
	
		<cfquery name="ItemInventory" datasource="#QBDSN#">
			SELECT 	FULLNAME AS QB, 
					QUANTITYONHAND AS StockQuantity, 
					ListID
			FROM 	ItemInventory
		</cfquery>
		
		<cfcatch>
			<table width="100%" border="1" bordercolor="EFEFEF" cellpadding="2" cellspacing="0">		
				<tr>
					<td nowrap="nowrap">
						There has been an error trying to communicate with your QuickBooks file.<br/><br/>
						<hr>
						Please make sure of the following:<br/>
						1) That the correct company file is open in QuickBooks<br/>
						2) That the QODBC DCOM Server is running<br/>
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
			
			<!--- TRY TO GET INVENTORY AMOUNT FROM QUICKBOOKS --->
			<cftry>
				<cfquery name="ItemInventoryList" dbtype="query">
					SELECT 	*
					FROM 	ItemInventory
					WHERE	QB = <cfqueryparam value="#ItemsList.FULLNAME#" cfsqltype="CF_SQL_VARCHAR">
					AND		ListID = <cfqueryparam value="#ItemsList.ListID#" cfsqltype="CF_SQL_VARCHAR">
				</cfquery>
				
				<cfscript>
					if ( TRIM(ItemInventoryList.StockQuantity) EQ '' )
						ThisStockQuantity = 0 ;
					else
						ThisStockQuantity = NumberFormat(ItemInventoryList.StockQuantity,9) ;
				</cfscript>
				
				<cfcatch>
					<cfset OtherErrors = OtherErrors + 1 >
					COULDN'T GET STOCK QUANTITY AT RECORD NUMBER <b>#RecordNumber#</b> (#ItemsList.FULLNAME# - ThisStockQuantity: #ThisStockQuantity#):<br/>
					#cfcatch.Message#<br/>
				</cfcatch>
			</cftry>
			
			<cftry>
				<cfquery name="UpdateProductMain" datasource="#application.dsn#">
					UPDATE 	Products
					SET		StockQuantity = <cfqueryparam value="#NumberFormat(ThisStockQuantity,9)#" cfsqltype="CF_SQL_INTEGER">,
							DateUpdated = <cfqueryparam value="#DateUpdated#" cfsqltype="CF_SQL_DATE">,
							UpdatedBy = <cfqueryparam value="#UpdatedBy#" cfsqltype="CF_SQL_VARCHAR">
					WHERE	QB = <cfqueryparam value="#ItemsList.FULLNAME#" cfsqltype="CF_SQL_VARCHAR">
				</cfquery>

				<cfset MainProductsUpdated = MainProductsUpdated + 1 >
				
				<cfcatch>
					
					UPDATE ERROR AT RECORD NUMBER <b>#RecordNumber#</b> (#ItemsList.FULLNAME#):<br/>
					#cfcatch.Message#<br/>
					<cfset UpdateErrors = UpdateErrors + 1 >
					
				</cfcatch>
			</cftry>
			
		</cfif><!--- IF PRODUCT IS LEGIT --->
		
	</cfloop>
	</cftransaction>
	</cfoutput>
	</font>
		
	<cfset AdminMsg = 'Inventory Updated From QuickBooks Successfully!' >
	<cfset ShowResults = 2 >
	
	
	
<!--- PRICE UPDATER --->	
<cfelseif isDefined('FORM.UpdatePrices') >
	<!--- GET DATA --->
	<cftry>	
		<cfquery name="ItemsList" datasource="#QBDSN#">
			SELECT 	FULLNAME AS QB,
					ISACTIVE AS Deleted,
					CUSTOMFIELDRETAILPRICE AS Price1Jarpy,
					SALESPRICE AS Price1Ponsard,
					LISTID
			FROM 	Item
		</cfquery>
		
		<cfcatch>
			<table width="100%" border="1" bordercolor="EFEFEF" cellpadding="2" cellspacing="0">		
				<tr>
					<td nowrap="nowrap">
						There has been an error trying to communicate with your QuickBooks file.<br/><br/>
						<hr>
						Please make sure of the following:<br/>
						1) That the correct company file is open in QuickBooks<br/>
						2) That the QODBC DCOM Server is running<br/>
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
					WHERE	QB = <cfqueryparam value="#ItemsList.FULLNAME#" cfsqltype="CF_SQL_VARCHAR">
				</cfquery>
				
				<cfset MainProductsUpdated = MainProductsUpdated + 1 >
				
				<cfcatch>
					
					UPDATE ERROR AT RECORD NUMBER <b>#RecordNumber#</b> (#ItemsList.FULLNAME#):<br/>
					#cfcatch.Message#<br/>
					<cfset UpdateErrors = UpdateErrors + 1 >
					
				</cfcatch>
			</cftry>
			
		</cfif><!--- IF PRODUCT IS LEGIT --->
		
	</cfloop>
	</cftransaction>
	</cfoutput>
	</font>
		
	<cfset AdminMsg = 'Prices Updated From QuickBooks Successfully!' >
	<cfset ShowResults = 2 >
	
	
	
</cfif>



<cfscript>
	PageTitle = 'QuickBooks Data Exporter';
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
			<img src="../images/icon-FileExporter.gif" border="0" align="absmiddle"> <img src="../images/logos/logo-QuickBooksLogo.jpg" border="0" align="absmiddle"><br>
		</td>
	</tr>
</table>

<table width="100%" border="1" bordercolor="EFEFEF" cellpadding="7" cellspacing="0">
	<tr>
		<!--- PRODUCT EXPORTER --->
		<cfform name="frmData1" action="QB-ExportTo.cfm" method="post">
		<td width="33%" align="center">
			<div class="cfAdminHeader1">PRODUCT EXPORTER</div><br/>
			<table width="100%">
				<tr>
					<td width="100%" align="center" colspan="2">
						<input type="submit" name="ExportToQB" value="EXPORT ALL PRODUCTS TO QUICKBOOKS" alt="EXPORT ALL PRODUCTS FROM QUICKBOOKS" class="cfAdminButton"  onclick="this.value='(EXPORT PROCESSING...)'; return confirm('Are you sure you want to EXPORT ALL PRODUCTS FROM QUICKBOOKS?'); ">
					</td>
				</tr>
			</table>				
			<br><br>				
		</td>
		</cfform>
		<!--- STOCK QUANTITY UPDATER --->
		<cfform name="frmData2" action="QB-ExportTo.cfm" method="post">
		<td width="33%" align="center">
			<div class="cfAdminHeader1">STOCK QUANTITY EXPORTER</div><br/>
			<table width="100%">
				<tr>
					<td width="100%" align="center" colspan="2">
						<input type="submit" name="UpdateInventory" value="EXPORT INVENTORY TO QUICKBOOKS" alt="EXPORT INVENTORY FROM QUICKBOOKS" class="cfAdminButton" onclick="this.value='(EXPORT PROCESSING...)'; return confirm('Are you sure you want to EXPORT INVENTORY STOCK QUANTITIES FROM QUICKBOOKS?'); ">
					</td>
				</tr>
			</table>				
			<br><br>				
		</td>
		</cfform>
		<!--- RETAIL PRICE UPDATER --->
		<cfform name="frmData3" action="QB-ExportTo.cfm" method="post">
		<td width="33%" align="center">
			<div class="cfAdminHeader1">PRICE<font class="cfAdminError">1</font> EXPORTER</div><br/>
			<table width="100%">
				<tr>
					<td width="100%" align="center" colspan="2">
						<input type="submit" name="UpdatePrices" value="EXPORT PRICES TO QUICKBOOKS" alt="EXPORT PRICES FROM QUICKBOOKS" class="cfAdminButton" onclick="this.value='(EXPORT PROCESSING...)'; return confirm('Are you sure you want to EXPORT PRODUCT PRICES FROM QUICKBOOKS?'); ">
					</td>
				</tr>
			</table>				
			<br><br>				
		</td>
		</cfform>
	</tr>
	<tr>
		<!--- VENDOR EXPORTER --->
		<cfform name="frmData4" action="QB-ExportTo.cfm" method="post">
		<td width="33%" align="center">
			<div class="cfAdminHeader1">VENDOR EXPORTER</div><br/>
			<table width="100%">
				<tr>
					<td width="100%" align="center" colspan="2">
						<input type="submit" name="ExportVendorsToQB" value="EXPORT ALL VENDORS TO QUICKBOOKS" alt="EXPORT ALL VENDORS TO QUICKBOOKS" class="cfAdminButton"  onclick="this.value='(EXPORT PROCESSING...)'; return confirm('Are you sure you want to EXPORT ALL PRODUCTS FROM QUICKBOOKS?'); ">
					</td>
				</tr>
			</table>				
			<br><br>				
		</td>
		</cfform>
		<!--- --->
		<cfform name="frmData2" action="QB-ExportTo.cfm" method="post">
		<td width="33%" align="center">
			<div class="cfAdminHeader1"></div><br/>
			<table width="100%">
				<tr>
					<td width="100%" align="center" colspan="2">
						
					</td>
				</tr>
			</table>				
			<br><br>				
		</td>
		</cfform>
		<!--- --->
		<cfform name="frmData3" action="QB-ExportTo.cfm" method="post">
		<td width="33%" align="center">
			<div class="cfAdminHeader1"></div><br/>
			<table width="100%">
				<tr>
					<td width="100%" align="center" colspan="2">
						
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
				EXPORT RESULTS
			</td>
		</tr>
	</table>
	<table width="50%" border="1" bordercolor="EFEFEF" cellpadding="7" cellspacing="0" align="center">
		<tr>
			<td width="100%" colspan="2" align="center" class="cfAdminTitle">
				<table width="100%" cellpadding="2" cellspacing="0" border="0">
					<tr>
						<td width="50%" align="right">Total Records Retrieved:</td>
						<td width="50%" class="cfAdminError">#(RecordNumber - 1)#</td>
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
						<td width="50%" class="cfAdminError">#(RecordNumber - 1)#</td>
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