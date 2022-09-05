<!---
	CartFusion 4.6 - Copyright � 2001-2007 Trade Studios, LLC.
	This copyright notice MUST stay intact for use (see license.txt).
	It is against the law to copy, distribute, gift, bundle or give away this code 
	without written consent from Trade Studios, LLC.

	NOTES
	-
	-
--->

<!--- SETUP TRACKING VARIABLES --->
<cfscript>
	Preview = 0 ;
	PreviewMode = 0 ;
	MainProductsAdded = 0 ;
	MainProductsUpdated = 0 ;
	MainCategoriesAdded = 0 ;
	CategoriesAdded = 0 ;
	CustomersAdded = 0 ;
	CustomersUpdated = 0 ;
	DistributorsAdded = 0 ;
	DistributorsUpdated = 0 ;
	AffiliatesAdded = 0 ;
	AffiliatesUpdated = 0 ;
	InsertErrors = 0 ;
	UpdateErrors = 0 ;
	CategoryErrors = 0 ;
	OtherErrors = 0 ;
	ShowResults = 0 ;
	DateUpdated = Now() ;
	UpdatedBy = GetAuthUser() ;
	// DEFAULT QUICKBOOKS ACCOUNTS & VARIABLES
	DefaultShippingAcct = 'Shipping and Handling' ;
	DefaultTaxAcct = 'Sales Tax Payable' ;
	DefaultDiscountAcct = 'Discounts Given' ;
	DefaultCreditAcct = 'Other Expenses' ;
	DefaultInventoryItemType = 'SERV' ; // INVENTORY, PART, etc.
</cfscript>

<cfif isDefined('form.filename') AND form.filename NEQ '' >
	<!--- ITEMS --->
	<cfif isDefined('form.ImportItemsFile') >
		
		<cfoutput>
		
		<cfquery name="getProducts" datasource="#application.dsn#">
			SELECT 	ItemID, QB
			FROM	Products
		</cfquery>
		<cfquery name="getCategories" datasource="#application.dsn#">
			SELECT	CatID, CatName, SubCategoryOf
			FROM	Categories
		</cfquery>
		<cfquery name="getMainCategories" dbtype="query">
			SELECT	CatID, CatName
			FROM	getCategories
			WHERE	SubCategoryOf IS NULL
			OR		SubCategoryOf = 0
		</cfquery>
								
		<cfx_text2Query
			file="#form.filename#"
			ColumnNames="INVITEM,NAME,REFNUM,TIMESTAMP,INVITEMTYPE,DESC,PURCHASEDESC,ACCNT,ASSETACCNT,COGSACCNT,QNTY,QNTY2,PRICE,COST,TAXABLE,SALESTAXCODE,PAYMETH,TAXVEND,PREFVEND,REORDERPOINT,EXTRA,CUSTFLD1,CUSTFLD2,CUSTFLD3,CUSTFLD4,CUSTFLD5,DEP_TYPE,ISPASSEDTHRU,HIDDEN,DELCOUNT,USEID,ISNEW,PO_NUM,SERIALNUM,WARRANTY,LOCATION,VENDOR,ASSETDESC,SALEDATE,SALEEXPENSE,NOTES,ASSETNUM,COSTBASIS,ACCUMDEPR,UNRECBASIS,PURCHASEDATE"
			firstRowIsHeader="false"
			qualifier="#chr(34)#"
			delimiter="#chr(9)#"
			maxrows="100000"
			startrow="12"
			rQuery="resultsQuery">
		
		<cfif Preview EQ 1 >
			<cfdump var="#resultsQuery#"><cfif PreviewMode EQ 0 ><cfabort></cfif>
		</cfif>
		
		<cfloop query="resultsQuery">
			<cfif isDefined('resultsQuery.INVITEM')
			  AND resultsQuery.INVITEM EQ 'INVITEM'
			  AND resultsQuery.INVITEMTYPE EQ DefaultInventoryItemType
			  AND TRIM(resultsQuery.PURCHASEDESC) NEQ '' >
			  
				<cftry>			
					<cfquery name="FindProductMain" dbtype="query">
						SELECT 	ItemID, QB
						FROM	getProducts
						WHERE	QB = <cfqueryparam value="#resultsQuery.REFNUM#" cfsqltype="CF_SQL_VARCHAR">
					</cfquery>
						
					<!--- <cfdump var="#FindProductMain.ItemID#"> <cfdump var="#FindProductMain.QB#"><br> --->
						
					<cfcatch>
						<cfset OtherErrors = OtherErrors + 1 >
						COULDN'T FIND PRODUCT AT RECORD NUMBER <b>#CurrentRow#</b> (#resultsQuery.NAME#):<br/>
						#cfcatch.Message#<br/>
					</cfcatch>
				</cftry>
				<cfif FindProductMain.RecordCount EQ 0 >
					<cftry>
						<cfquery name="getMainCategoryID" dbtype="query">
							SELECT	CatID
							FROM	getMainCategories
							WHERE	CatName = <cfqueryparam value="#TRIM(resultsQuery.PREFVEND)#" cfsqltype="CF_SQL_VARCHAR">
						</cfquery>
						
						<!--- <cfdump var="#getMainCategoryID.CatID#"><br> --->
						
						<cfcatch>
							<cfset OtherErrors = OtherErrors + 1 >
							COULDN'T FIND MAIN CATEGORY AT RECORD NUMBER <b>#CurrentRow#</b> (#resultsQuery.PREFVEND#):<br/>
							#cfcatch.Message#<br/>
						</cfcatch>
					</cftry>
					<cftry>	
						<cfif getMainCategoryID.RecordCount EQ 0 >
							<!--- <b>#TRIM(resultsQuery.PREFVEND)#</b><br> --->
							<cfset MainCatToAdd = TRIM(resultsQuery.PREFVEND) >
							
							<cfquery name="insertMainCategory" datasource="#application.dsn#">
								SET NOCOUNT ON
								INSERT INTO Categories ( SiteID, CatName, CatFeaturedDir, CatFeaturedID )
								VALUES (
										<cfqueryparam value="1" cfsqltype="CF_SQL_INTEGER">,
										<cfqueryparam value="#MainCatToAdd#" cfsqltype="CF_SQL_VARCHAR">,
										<cfqueryparam value="products" cfsqltype="CF_SQL_VARCHAR">,
										<cfqueryparam value="#resultsQuery.NAME#.jpg" cfsqltype="CF_SQL_VARCHAR">
										)
								SELECT @@Identity AS CatID
								SET NOCOUNT OFF
							</cfquery>
							
							<cfif isDefined('insertMainCategory.CatID')>
								<!--- UPDATE QofQ --->
								<cfset temp = QueryAddRow(getMainCategories)>
								<cfset Temp = QuerySetCell(getMainCategories,"CatID",insertMainCategory.CatID) >
								<cfset Temp = QuerySetCell(getMainCategories,"CatName",MainCatToAdd) >
								<!--- UPDATE QofQ --->
								
								<cfset MainCategoryID = insertMainCategory.CatID >
								<cfset MainCategoriesAdded = MainCategoriesAdded + 1 >
							<cfelse>
								<cfset MainCategoryID = 0 >
							</cfif>
							
						<cfelse>
							<cfset MainCategoryID = getMainCategoryID.CatID >
						</cfif>
						
						<cfcatch>	
							ERROR OCCURED ADDING MAIN CATEGORY AT RECORD NUMBER <b>#CurrentRow#</b> (#resultsQuery.PREFVEND#):<br/>
							#cfcatch.Message#<br/>
							<cfset CategoryErrors = CategoryErrors + 1 >
						</cfcatch>
					</cftry>
					<cftry>
						<cfquery name="getCategoryID" dbtype="query">
							SELECT	CatID
							FROM	getCategories
							WHERE	CatName = <cfqueryparam value="#TRIM(resultsQuery.PURCHASEDESC)#" cfsqltype="CF_SQL_VARCHAR">
							AND	   	SubCategoryOf = <cfqueryparam value="#MainCategoryID#" cfsqltype="CF_SQL_INTEGER">			
						</cfquery>
						
						<!--- <cfdump var="#getCategoryID.CatID#"><br> --->
						
						<cfcatch>
							<cfset OtherErrors = OtherErrors + 1 >
							COULDN'T FIND PRODUCT-LEVEL CATEGORY AT RECORD NUMBER <b>#CurrentRow#</b> (#resultsQuery.PURCHASEDESC#):<br/>
							#cfcatch.Message#<br/>
						</cfcatch>
					</cftry>
					<cftry>	
						<cfif getCategoryID.RecordCount EQ 0 AND TRIM(resultsQuery.PURCHASEDESC) NEQ '' >
							
							<!--- <b>- #TRIM(resultsQuery.PURCHASEDESC)#</b><br> --->
							<cfset CatToAdd = TRIM(resultsQuery.PURCHASEDESC) >
							
							<cfquery name="insertCategory" datasource="#application.dsn#">
								SET NOCOUNT ON
								INSERT INTO Categories ( SiteID, CatName, SubCategoryOf, CatFeaturedDir, CatFeaturedID )
								VALUES (
										<cfqueryparam value="1" cfsqltype="CF_SQL_INTEGER">,
										<cfqueryparam value="#TRIM(resultsQuery.PURCHASEDESC)#" cfsqltype="CF_SQL_VARCHAR">,
										<cfqueryparam value="#MainCategoryID#" cfsqltype="CF_SQL_INTEGER">,
										<cfqueryparam value="products" cfsqltype="CF_SQL_VARCHAR">,
										<cfqueryparam value="#resultsQuery.NAME#.jpg" cfsqltype="CF_SQL_VARCHAR">
										)
								SELECT @@Identity AS CatID
								SET NOCOUNT OFF
							</cfquery>
							
							<cfif isDefined('insertCategory.CatID')>
								<!--- UPDATE QofQ --->
								<cfset temp = QueryAddRow(getCategories)>
								<cfset Temp = QuerySetCell(getCategories,"CatID",insertCategory.CatID) >
								<cfset Temp = QuerySetCell(getCategories,"CatName",CatToAdd) >
								<cfset Temp = QuerySetCell(getCategories,"SubCategoryOf",MainCategoryID) >
								<!--- UPDATE QofQ --->
								
								<cfset CategoryID = insertCategory.CatID >
								<cfset CategoriesAdded = CategoriesAdded + 1 >
							<cfelse>
								<cfset CategoryID = 0 >
							</cfif>
							
						<cfelse>
							<cfset CategoryID = getCategoryID.CatID >
						</cfif>
						
						<cfcatch>
							ERROR OCCURED ADDING PRODUCT-LEVEL CATEGORY AT RECORD NUMBER <b>#CurrentRow#</b> (#TRIM(resultsQuery.PURCHASEDESC)#):<br/>
							#cfcatch.Message#<br/>
							<cfset CategoryErrors = CategoryErrors + 1 >
						</cfcatch>
					</cftry>
					
					<!--- <cftry> --->
						<cfquery name="InsertProductMain" datasource="#application.dsn#">
							SET NOCOUNT ON
							INSERT INTO Products
								   (
									SiteID, SKU, ItemName, ItemDescription, Category,
									StockQuantity, Price1, <!---Price2,---> CostPrice, Volume,
									UseMatrix, SellByStock, ItemStatus, Weight, fldShipWeight,
									Hide1, Taxable, Comments,
									ImageDir, Image, ImageSmall,
									QB, QB_ACCNT, QB_ASSETACCNT, QB_COGSACCNT, QB_SALESTAXCODE,
									QB_PREFVEND, QB_SUBITEM, QB_REORDERPOINT, QB_PAYMETH, QB_TAXVEND,
									DateUpdated, UpdatedBy
								   )
							VALUES (
									<cfqueryparam value="1" cfsqltype="CF_SQL_INTEGER">,
									<cfqueryparam value="#TRIM(resultsQuery.NAME)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.DESC)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.CUSTFLD3)#" cfsqltype="CF_SQL_LONGVARCHAR">,
									<cfqueryparam value="#CategoryID#" cfsqltype="CF_SQL_INTEGER">,
									
									<cfif resultsQuery.QNTY NEQ '' ><cfqueryparam value="#Replace(resultsQuery.QNTY,',','','ALL')#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
									<!--- 1st PRICE --->
									<cfif resultsQuery.PRICE NEQ '' ><cfqueryparam value="#Replace(resultsQuery.PRICE,',','','ALL')#" cfsqltype="CF_SQL_MONEY4"><cfelse>0</cfif>,
									<!--- 2nd PRICE
									<cfif resultsQuery.CUSTFLD1 NEQ '' ><cfqueryparam value="#Replace(resultsQuery.CUSTFLD1,',','','ALL')#" cfsqltype="CF_SQL_MONEY4"><cfelse>0</cfif>, --->
									<cfif resultsQuery.COST NEQ '' ><cfqueryparam value="#Replace(resultsQuery.COST,',','','ALL')#" cfsqltype="CF_SQL_MONEY4"><cfelse>0</cfif>,
									<cfif resultsQuery.CUSTFLD2 NEQ '' ><cfqueryparam value="#Replace(resultsQuery.CUSTFLD2,',','','ALL')#" cfsqltype="CF_SQL_MONEY4"><cfelse>0</cfif>,
									
									<cfqueryparam value="0" cfsqltype="CF_SQL_BIT">,
									<cfqueryparam value="1" cfsqltype="CF_SQL_BIT">,
									<cfqueryparam value="IS" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#resultsQuery.CUSTFLD4#" cfsqltype="CF_SQL_FLOAT">,
									<cfqueryparam value="#resultsQuery.CUSTFLD4#" cfsqltype="CF_SQL_FLOAT">,
									
									<cfif resultsQuery.HIDDEN EQ 'N' ><cfqueryparam value="0" cfsqltype="CF_SQL_BIT">,
									<cfelse><cfqueryparam value="1" cfsqltype="CF_SQL_BIT">,
									</cfif>
									<cfif resultsQuery.TAXABLE EQ 'N' ><cfqueryparam value="0" cfsqltype="CF_SQL_BIT">,
									<cfelse><cfqueryparam value="1" cfsqltype="CF_SQL_BIT">,
									</cfif>
									<cfqueryparam value="#TRIM(resultsQuery.NOTES)#" cfsqltype="CF_SQL_VARCHAR">,
									
									<cfqueryparam value="products" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#resultsQuery.NAME#.jpg" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#resultsQuery.NAME#.jpg" cfsqltype="CF_SQL_VARCHAR">,
									
									<!--- QUICKBOOKS-SPECIFIC VALUES - used for exporting from CF --->
									<cfqueryparam value="#TRIM(resultsQuery.REFNUM)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.ACCNT)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.ASSETACCNT)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.COGSACCNT)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.SALESTAXCODE)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.PREFVEND)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#LEFT(TRIM(resultsQuery.NAME),2)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.REORDERPOINT)#" cfsqltype="CF_SQL_INTEGER">,
									<cfqueryparam value="#TRIM(resultsQuery.PAYMETH)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.TAXVEND)#" cfsqltype="CF_SQL_VARCHAR">,
									
									<cfqueryparam value="#DateUpdated#" cfsqltype="CF_SQL_DATE">,
									<cfqueryparam value="#UpdatedBy#" cfsqltype="CF_SQL_VARCHAR">
									)
							SELECT @@Identity AS ItemID
							SET NOCOUNT OFF
						</cfquery>
					
						<cfset MainProductsAdded = MainProductsAdded + 1 >
						<!--- <i>--- #resultsQuery.NAME#</i><br> --->
						
						<!--- <cfcatch>
							INSERT ERROR AT RECORD NUMBER <b>#CurrentRow#</b> (#resultsQuery.NAME#):<br/>
							#cfcatch.Message#<br/>
							<cfset InsertErrors = InsertErrors + 1 >
						</cfcatch>
					</cftry> --->
				
				<cfelse>
					<!--- <cftry> --->
						<cfquery name="UpdateProductMain" datasource="#application.dsn#">
							UPDATE	Products
							SET		SKU = <cfqueryparam value="#TRIM(resultsQuery.NAME)#" cfsqltype="CF_SQL_VARCHAR">,
									ItemName = <cfqueryparam value="#TRIM(resultsQuery.DESC)#" cfsqltype="CF_SQL_VARCHAR">,
									ItemDescription = <cfqueryparam value="#TRIM(resultsQuery.CUSTFLD3)#" cfsqltype="CF_SQL_LONGVARCHAR">,
									<!--- Category = <cfqueryparam value="#CategoryID#" cfsqltype="CF_SQL_INTEGER">, --->
									StockQuantity = <cfif resultsQuery.QNTY NEQ '' ><cfqueryparam value="#Replace(resultsQuery.QNTY,',','','ALL')#" cfsqltype="CF_SQL_INTEGER"><cfelse>0</cfif>,
									Price1 = <cfif resultsQuery.PRICE NEQ '' ><cfqueryparam value="#Replace(resultsQuery.PRICE,',','','ALL')#" cfsqltype="CF_SQL_MONEY4"><cfelse>0</cfif>,
									<!---Price2 = <cfif resultsQuery.CUSTFLD1 NEQ '' ><cfqueryparam value="#Replace(resultsQuery.CUSTFLD1,',','','ALL')#" cfsqltype="CF_SQL_MONEY4"><cfelse>0</cfif>,--->
									CostPrice = <cfif resultsQuery.COST NEQ '' ><cfqueryparam value="#Replace(resultsQuery.COST,',','','ALL')#" cfsqltype="CF_SQL_MONEY4"><cfelse>0</cfif>,
									Volume = <cfif resultsQuery.CUSTFLD2 NEQ '' ><cfqueryparam value="#Replace(resultsQuery.CUSTFLD2,',','','ALL')#" cfsqltype="CF_SQL_MONEY4"><cfelse>0</cfif>,
									Weight = <cfqueryparam value="#resultsQuery.CUSTFLD4#" cfsqltype="CF_SQL_FLOAT">,
									fldShipWeight = <cfqueryparam value="#resultsQuery.CUSTFLD4#" cfsqltype="CF_SQL_FLOAT">,
									Hide1 = <cfif resultsQuery.HIDDEN EQ 'N' ><cfqueryparam value="0" cfsqltype="CF_SQL_BIT">,
											<cfelse><cfqueryparam value="1" cfsqltype="CF_SQL_BIT">,
											</cfif>
									Taxable = <cfif resultsQuery.TAXABLE EQ 'N' ><cfqueryparam value="0" cfsqltype="CF_SQL_BIT">,
											<cfelse><cfqueryparam value="1" cfsqltype="CF_SQL_BIT">,
											</cfif>
									Comments = <cfqueryparam value="#TRIM(resultsQuery.NOTES)#" cfsqltype="CF_SQL_VARCHAR">,
									QB = <cfqueryparam value="#TRIM(resultsQuery.REFNUM)#" cfsqltype="CF_SQL_VARCHAR">,
									QB_ACCNT = <cfqueryparam value="#TRIM(resultsQuery.ACCNT)#" cfsqltype="CF_SQL_VARCHAR">,
									QB_ASSETACCNT = <cfqueryparam value="#TRIM(resultsQuery.ASSETACCNT)#" cfsqltype="CF_SQL_VARCHAR">,
									QB_COGSACCNT = <cfqueryparam value="#TRIM(resultsQuery.COGSACCNT)#" cfsqltype="CF_SQL_VARCHAR">,
									QB_SALESTAXCODE = <cfqueryparam value="#TRIM(resultsQuery.SALESTAXCODE)#" cfsqltype="CF_SQL_VARCHAR">,
									QB_PREFVEND = <cfqueryparam value="#TRIM(resultsQuery.PREFVEND)#" cfsqltype="CF_SQL_VARCHAR">,
									QB_SUBITEM = <cfqueryparam value="#LEFT(TRIM(resultsQuery.NAME),2)#" cfsqltype="CF_SQL_VARCHAR">,
									QB_REORDERPOINT = <cfqueryparam value="#TRIM(resultsQuery.REORDERPOINT)#" cfsqltype="CF_SQL_INTEGER">,
									QB_PAYMETH = <cfqueryparam value="#TRIM(resultsQuery.PAYMETH)#" cfsqltype="CF_SQL_VARCHAR">,
									QB_TAXVEND = <cfqueryparam value="#TRIM(resultsQuery.TAXVEND)#" cfsqltype="CF_SQL_VARCHAR">,
									DateUpdated = <cfqueryparam value="#DateUpdated#" cfsqltype="CF_SQL_DATE">,
									UpdatedBy = <cfqueryparam value="#UpdatedBy#" cfsqltype="CF_SQL_VARCHAR">
							WHERE	ItemID = <cfqueryparam value="#FindProductMain.ItemID#" cfsqltype="CF_SQL_INTEGER">
						</cfquery>
							
						<cfset MainProductsUpdated = MainProductsUpdated + 1 >
						
						<!--- <cfcatch>
							UPDATE ERROR AT RECORD NUMBER <b>#CurrentRow#</b> (#TRIM(resultsQuery.NAME)#):<br/>
							#cfcatch.Message#<br/>
							<cfset UpdateErrors = UpdateErrors + 1 >
						</cfcatch>
					</cftry> --->
				</cfif>
		
			</cfif>
		</cfloop>
		
		<cfset AdminMsg = 'Products Imported From QuickBooks' >
		<cfset ShowResults = 1 >
		
		</cfoutput>
		
		
		
	<!--- CUSTOMERS --->
	<cfelseif isDefined('form.ImportCustomersFile') >
		
		<cfoutput>
		
		<cfquery name="getCustomers" datasource="#application.dsn#">
			SELECT 	CustomerID, QB
			FROM	Customers
		</cfquery>
								
		<cfx_text2Query
			file="#form.filename#"
			ColumnNames="CUST,NAME,REFNUM,TIMESTAMP,BADDR1,BADDR2,BADDR3,BADDR4,BADDR5,SADDR1,SADDR2,SADDR3,SADDR4,SADDR5,PHONE1,PHONE2,FAXNUM,EMAIL,NOTE,CONT1,CONT2,CTYPE,TERMS,TAXABLE,SALESTAXCODE,LIMIT,RESALENUM,REP,TAXITEM,NOTEPAD,SALUTATION,COMPANYNAME,FIRSTNAME,MIDINIT,LASTNAME,CUSTFLD1,CUSTFLD2,CUSTFLD3,CUSTFLD4,CUSTFLD5,CUSTFLD6,CUSTFLD7,CUSTFLD8,CUSTFLD9,CUSTFLD10,CUSTFLD11,CUSTFLD12,CUSTFLD13,CUSTFLD14,CUSTFLD15,JOBDESC,JOBTYPE,JOBSTATUS,JOBSTART,JOBPROJEND,JOBEND,HIDDEN,DELCOUNT,PRICELEVEL"
			firstRowIsHeader="false"
			qualifier="#chr(34)#"
			delimiter="#chr(9)#"
			maxrows="1000000"
			startrow="22"
			rQuery="resultsQuery">
		
		<cfif Preview EQ 1 >
			<cfdump var="#resultsQuery#"><cfif PreviewMode EQ 0 ><cfabort></cfif>
		</cfif>
		
		<cfloop query="resultsQuery">
			<cfif isDefined('resultsQuery.CUST')
			  AND resultsQuery.CUST EQ 'CUST'
			  AND TRIM(resultsQuery.NAME) NEQ ''
			  AND TRIM(resultsQuery.CUSTFLD2) NEQ '' >
			  
				<cftry>			
					<cfquery name="FindCustomerMain" dbtype="query">
						SELECT 	CustomerID
						FROM	getCustomers
						WHERE	<!--- CustomerID = <cfqueryparam value="#TRIM(resultsQuery.CUSTFLD2)#" cfsqltype="CF_SQL_VARCHAR">
						AND		 --->QB = <cfqueryparam value="#TRIM(resultsQuery.REFNUM)#" cfsqltype="CF_SQL_VARCHAR">
					</cfquery>
						
					<cfcatch>
						<cfset OtherErrors = OtherErrors + 1 >
						COULDN'T FIND CUSTOMER AT RECORD NUMBER <b>#CurrentRow#</b> (#resultsQuery.NAME#) (#resultsQuery.CUSTFLD2#):<br/>
						#cfcatch.Message#<br/>
					</cfcatch>
				</cftry>
				<cfif FindCustomerMain.RecordCount EQ 0 >
					<cftry>
						<cfquery name="InsertCustomerMain" datasource="#application.dsn#">
							INSERT INTO Customers
								   (
									CustomerID, CustomerName, FirstName, MiddleName, LastName, CompanyName,
									Address1, Address2, City, State, Zip, Country, 
									Phone, Fax, Email,
									ShipFirstName, ShipLastName, ShipCompanyName, 
									ShipAddress1, ShipAddress2, ShipCity, ShipState, ShipZip, ShipCountry, ShipPhone, 
									UserName, Password, 
									PriceToUse, EmailOK, Comments, Deleted, AffiliateCode, 
									PaymentTerms, CreditLimit, Credit,
									QB, QB_CONT1, QB_CONT2, QB_TAXABLE, QB_SALESTAXCODE, 
					  				QB_RESALENUM, QB_REP, QB_TAXITEM, QB_JOBDESC, QB_JOBTYPE, 
									QB_JOBSTATUS, QB_JOBSTART, QB_JOBPROJEND, QB_JOBEND,
									DateUpdated, UpdatedBy
								   )
							VALUES (
									<cfqueryparam value="#TRIM(resultsQuery.CUSTFLD2)#" cfsqltype="CF_SQL_VARCHAR">,									 
									<cfqueryparam value="#TRIM(resultsQuery.NAME)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.FIRSTNAME)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.MIDINIT)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.LASTNAME)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.COMPANYNAME)#" cfsqltype="CF_SQL_VARCHAR">,
									
									<cfqueryparam value="#TRIM(resultsQuery.BADDR1)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.BADDR2)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.BADDR3)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.BADDR4)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.BADDR5)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="US" cfsqltype="CF_SQL_VARCHAR">,
									
									<cfqueryparam value="#TRIM(resultsQuery.PHONE1)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.FAXNUM)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfif TRIM(resultsQuery.EMAIL) EQ '' AND TRIM(resultsQuery.FAXNUM) NEQ '' >
										<cfqueryparam value="#TRIM(resultsQuery.FAXNUM)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfelse>
										<cfqueryparam value="#TRIM(resultsQuery.EMAIL)#" cfsqltype="CF_SQL_VARCHAR">,
									</cfif>
									
									<cfqueryparam value="#TRIM(resultsQuery.FIRSTNAME)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.LASTNAME)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.COMPANYNAME)#" cfsqltype="CF_SQL_VARCHAR">,
									
									<cfqueryparam value="#TRIM(resultsQuery.SADDR1)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.SADDR2)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.SADDR3)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.SADDR4)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.SADDR5)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="US" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.PHONE2)#" cfsqltype="CF_SQL_VARCHAR">,
									
									<cfif TRIM(resultsQuery.EMAIL) NEQ '' >
										<cfqueryparam value="#TRIM(resultsQuery.EMAIL)##RandRange(1000,9999)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfelseif TRIM(resultsQuery.FAXNUM) NEQ '' >
										<cfqueryparam value="#TRIM(resultsQuery.FAXNUM)##RandRange(1000,9999)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfelse>
										<cfqueryparam value="CartFusion#RandRange(1000,9999)#" cfsqltype="CF_SQL_VARCHAR">,
									</cfif>
									<cfqueryparam value="#ENCRYPT(RandRange(100000,999999), application.CryptKey, 'CFMX_COMPAT', 'Hex')#" cfsqltype="CF_SQL_VARCHAR">,
									
									<cfqueryparam value="1" cfsqltype="CF_SQL_INTEGER">,
									<cfqueryparam value="1" cfsqltype="CF_SQL_BIT">,
									<cfif TRIM(resultsQuery.NOTE) NEQ '' >
										<cfqueryparam value="#TRIM(resultsQuery.NOTE)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfelse>
										<cfqueryparam value="#TRIM(resultsQuery.JOBDESC)#" cfsqltype="CF_SQL_VARCHAR">,
									</cfif>
									<cfqueryparam value="0" cfsqltype="CF_SQL_BIT">,
									<cfqueryparam value="#TRIM(resultsQuery.CUSTFLD4)#" cfsqltype="CF_SQL_VARCHAR">,
									
									<cfqueryparam value="#TRIM(resultsQuery.TERMS)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfif TRIM(resultsQuery.LIMIT) NEQ '' >
										<cfqueryparam value="#TRIM(Replace(resultsQuery.LIMIT,',','','ALL'))#" cfsqltype="CF_SQL_FLOAT">,
										<cfqueryparam value="#TRIM(Replace(resultsQuery.LIMIT,',','','ALL'))#" cfsqltype="CF_SQL_FLOAT">,
									<cfelse>
										<cfqueryparam value="0" cfsqltype="CF_SQL_FLOAT">,
										<cfqueryparam value="0" cfsqltype="CF_SQL_FLOAT">,
									</cfif>
									
									<cfqueryparam value="#TRIM(resultsQuery.REFNUM)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.CONT1)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.CONT2)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.TAXABLE)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.SALESTAXCODE)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.RESALENUM)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.REP)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.TAXITEM)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.JOBDESC)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.JOBTYPE)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.JOBSTATUS)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.JOBSTART)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.JOBPROJEND)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.JOBEND)#" cfsqltype="CF_SQL_VARCHAR">,
									
									<cfqueryparam value="#DateUpdated#" cfsqltype="CF_SQL_DATE">,
									<cfqueryparam value="#UpdatedBy#" cfsqltype="CF_SQL_VARCHAR">
									)
						</cfquery>
					
						<cfset CustomersAdded = CustomersAdded + 1 >
						
						<cfcatch>
							INSERT ERROR AT RECORD NUMBER <b>#CurrentRow#</b> (#resultsQuery.NAME#):<br/>
							#cfcatch.Message#<br/>
							<cfset InsertErrors = InsertErrors + 1 >
						</cfcatch>
					</cftry>
				
				<cfelse>
					<!--- <cftry> --->
						<cfquery name="UpdateCustomerMain" datasource="#application.dsn#">
							UPDATE 	Customers
							SET		CustomerName = <cfqueryparam value="#TRIM(resultsQuery.NAME)#" cfsqltype="CF_SQL_VARCHAR">,
									FirstName = <cfqueryparam value="#TRIM(resultsQuery.FIRSTNAME)#" cfsqltype="CF_SQL_VARCHAR">,
									MiddleName = <cfqueryparam value="#TRIM(resultsQuery.MIDINIT)#" cfsqltype="CF_SQL_VARCHAR">,
									LastName = <cfqueryparam value="#TRIM(resultsQuery.LASTNAME)#" cfsqltype="CF_SQL_VARCHAR">,
									CompanyName = <cfqueryparam value="#TRIM(resultsQuery.COMPANYNAME)#" cfsqltype="CF_SQL_VARCHAR">,
									Address1 = <cfqueryparam value="#TRIM(resultsQuery.BADDR1)#" cfsqltype="CF_SQL_VARCHAR">,
									Address2 = <cfqueryparam value="#TRIM(resultsQuery.BADDR2)#" cfsqltype="CF_SQL_VARCHAR">,
									City = <cfqueryparam value="#TRIM(resultsQuery.BADDR3)#" cfsqltype="CF_SQL_VARCHAR">,
									State = <cfqueryparam value="#TRIM(resultsQuery.BADDR4)#" cfsqltype="CF_SQL_VARCHAR">,
									Zip = <cfqueryparam value="#TRIM(resultsQuery.BADDR5)#" cfsqltype="CF_SQL_VARCHAR">,
									Country = <cfqueryparam value="US" cfsqltype="CF_SQL_VARCHAR">,
									Phone = <cfqueryparam value="#TRIM(resultsQuery.PHONE1)#" cfsqltype="CF_SQL_VARCHAR">,
									Fax = <cfqueryparam value="#TRIM(resultsQuery.PHONE2)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfif TRIM(resultsQuery.EMAIL) EQ '' AND TRIM(resultsQuery.FAXNUM) NEQ '' >
									Email = <cfqueryparam value="#TRIM(resultsQuery.FAXNUM)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfelse>
									Email = <cfqueryparam value="#TRIM(resultsQuery.EMAIL)#" cfsqltype="CF_SQL_VARCHAR">,
									</cfif>									
									ShipFirstName = <cfqueryparam value="#TRIM(resultsQuery.FIRSTNAME)#" cfsqltype="CF_SQL_VARCHAR">,
									ShipLastName = <cfqueryparam value="#TRIM(resultsQuery.LASTNAME)#" cfsqltype="CF_SQL_VARCHAR">,
									ShipCompanyName = <cfqueryparam value="#TRIM(resultsQuery.COMPANYNAME)#" cfsqltype="CF_SQL_VARCHAR">,
									ShipAddress1 = <cfqueryparam value="#TRIM(resultsQuery.SADDR1)#" cfsqltype="CF_SQL_VARCHAR">,
									ShipAddress2 = <cfqueryparam value="#TRIM(resultsQuery.SADDR2)#" cfsqltype="CF_SQL_VARCHAR">,
									ShipCity = <cfqueryparam value="#TRIM(resultsQuery.SADDR3)#" cfsqltype="CF_SQL_VARCHAR">,
									ShipState = <cfqueryparam value="#TRIM(resultsQuery.SADDR4)#" cfsqltype="CF_SQL_VARCHAR">,
									ShipZip = <cfqueryparam value="#TRIM(resultsQuery.SADDR5)#" cfsqltype="CF_SQL_VARCHAR">,
									ShipCountry = <cfqueryparam value="US" cfsqltype="CF_SQL_VARCHAR">,
									ShipPhone = <cfqueryparam value="#TRIM(resultsQuery.PHONE1)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfif TRIM(resultsQuery.NOTE) NEQ '' >
									Comments = <cfqueryparam value="#TRIM(resultsQuery.NOTE)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfelse>
									Comments = <cfqueryparam value="#TRIM(resultsQuery.JOBDESC)#" cfsqltype="CF_SQL_VARCHAR">,
									</cfif>
									Deleted = <cfqueryparam value="0" cfsqltype="CF_SQL_BIT">,
									AffiliateCode = <cfqueryparam value="#TRIM(resultsQuery.CUSTFLD4)#" cfsqltype="CF_SQL_VARCHAR">,
									PaymentTerms = <cfqueryparam value="#TRIM(resultsQuery.TERMS)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfif TRIM(resultsQuery.LIMIT) NEQ '' >
										CreditLimit = <cfqueryparam value="#TRIM(Replace(resultsQuery.LIMIT,',','','ALL'))#" cfsqltype="CF_SQL_FLOAT">,
										Credit = <cfqueryparam value="#TRIM(Replace(resultsQuery.LIMIT,',','','ALL'))#" cfsqltype="CF_SQL_FLOAT">,
									<cfelse>
										CreditLimit = <cfqueryparam value="0" cfsqltype="CF_SQL_FLOAT">,
										Credit = <cfqueryparam value="0" cfsqltype="CF_SQL_FLOAT">,
									</cfif>
									QB_CONT1 = <cfqueryparam value="#TRIM(resultsQuery.CONT1)#" cfsqltype="CF_SQL_VARCHAR">,
									QB_CONT2 = <cfqueryparam value="#TRIM(resultsQuery.CONT2)#" cfsqltype="CF_SQL_VARCHAR">,
									QB_TAXABLE = <cfqueryparam value="#TRIM(resultsQuery.TAXABLE)#" cfsqltype="CF_SQL_VARCHAR">,
									QB_SALESTAXCODE = <cfqueryparam value="#TRIM(resultsQuery.SALESTAXCODE)#" cfsqltype="CF_SQL_VARCHAR">,
									QB_RESALENUM = <cfqueryparam value="#TRIM(resultsQuery.RESALENUM)#" cfsqltype="CF_SQL_VARCHAR">,
									QB_REP = <cfqueryparam value="#TRIM(resultsQuery.REP)#" cfsqltype="CF_SQL_VARCHAR">,
									QB_TAXITEM = <cfqueryparam value="#TRIM(resultsQuery.TAXITEM)#" cfsqltype="CF_SQL_VARCHAR">,
									QB_JOBDESC = <cfqueryparam value="#TRIM(resultsQuery.JOBDESC)#" cfsqltype="CF_SQL_VARCHAR">,
									QB_JOBTYPE = <cfqueryparam value="#TRIM(resultsQuery.JOBTYPE)#" cfsqltype="CF_SQL_VARCHAR">,
									QB_JOBSTATUS = <cfqueryparam value="#TRIM(resultsQuery.JOBSTATUS)#" cfsqltype="CF_SQL_VARCHAR">,
									QB_JOBSTART = <cfqueryparam value="#TRIM(resultsQuery.JOBSTART)#" cfsqltype="CF_SQL_VARCHAR">,
									QB_JOBPROJEND = <cfqueryparam value="#TRIM(resultsQuery.JOBPROJEND)#" cfsqltype="CF_SQL_VARCHAR">,
									QB_JOBEND = <cfqueryparam value="#TRIM(resultsQuery.JOBEND)#" cfsqltype="CF_SQL_VARCHAR">,
									DateUpdated = <cfqueryparam value="#DateUpdated#" cfsqltype="CF_SQL_DATE">,
									UpdatedBy = <cfqueryparam value="#UpdatedBy#" cfsqltype="CF_SQL_VARCHAR">
							WHERE	CustomerID = <cfqueryparam value="#FindCustomerMain.CustomerID#" cfsqltype="CF_SQL_VARCHAR">
						</cfquery>
							
						<cfset CustomersUpdated = CustomersUpdated + 1 >
						
						<!--- <cfcatch>
							UPDATE ERROR AT RECORD NUMBER <b>#CurrentRow#</b> (#TRIM(resultsQuery.NAME)#):<br/>
							#cfcatch.Message#<br/>
							<cfset UpdateErrors = UpdateErrors + 1 >
						</cfcatch>
					</cftry> --->
				</cfif>
				
			</cfif>
		</cfloop>
		
		<cfset AdminMsg = 'Customers Imported From QuickBooks' >
		<cfset ShowResults = 4 >
		
		</cfoutput>
		
		
	
	<!--- VENDORS (AS DISTRIBUTORS) --->
	<cfelseif isDefined('form.ImportDistributorsFile') >
		
		<cfoutput>
		
		<cfquery name="getDistributors" datasource="#application.dsn#">
			SELECT 	DistributorID, QB
			FROM	Distributors
		</cfquery>
								
		<cfx_text2Query
			file="#form.filename#"
			ColumnNames="VEND,NAME,REFNUM,TIMESTAMP,PRINTAS,ADDR1,ADDR2,ADDR3,ADDR4,ADDR5,VTYPE,CONT1,CONT2,PHONE1,PHONE2,FAXNUM,EMAIL,NOTE,TAXID,LIMIT,TERMS,NOTEPAD,SALUTATION,COMPANYNAME,FIRSTNAME,MIDINIT,LASTNAME,CUSTFLD1,CUSTFLD2,CUSTFLD3,CUSTFLD4,CUSTFLD5,CUSTFLD6,CUSTFLD7,CUSTFLD8,CUSTFLD9,CUSTFLD10,CUSTFLD11,CUSTFLD12,CUSTFLD13,CUSTFLD14,CUSTFLD15,1099,HIDDEN,DELCOUNT"
			firstRowIsHeader="false"
			qualifier="#chr(34)#"
			delimiter="#chr(9)#"
			maxrows="1000000"
			startrow="22"
			rQuery="resultsQuery">
		
		<cfif Preview EQ 1 >
			<cfdump var="#resultsQuery#"><cfif PreviewMode EQ 0 ><cfabort></cfif>
		</cfif>
		
		<cfloop query="resultsQuery">
			<cfif isDefined('resultsQuery.VEND')
			  AND resultsQuery.VEND EQ 'VEND'
			  AND TRIM(resultsQuery.VTYPE) NEQ 'Sales Rep' >
			  
				<cftry>			
					<cfquery name="FindDistributorMain" dbtype="query">
						SELECT 	DistributorID
						FROM	getDistributors
						WHERE	QB = <cfqueryparam value="#TRIM(resultsQuery.REFNUM)#" cfsqltype="CF_SQL_VARCHAR">
					</cfquery>
						
					<cfcatch>
						<cfset OtherErrors = OtherErrors + 1 >
						COULDN'T FIND DISTRIBUTOR AT RECORD NUMBER <b>#CurrentRow#</b> (#resultsQuery.NAME#) (#resultsQuery.CUSTFLD2#):<br/>
						#cfcatch.Message#<br/>
					</cfcatch>
				</cftry>
				<cfif FindDistributorMain.RecordCount EQ 0 >
					<cftry>
						<cfquery name="InsertDistributorMain" datasource="#application.dsn#">
							INSERT INTO Distributors
								   (
									DistributorName, FirstName, LastName, 
									Address1, Address2, City, State, Zipcode, Country, 
									RepName, Email, Phone, AltPhone, Fax,
									Deleted, Comments, WebSiteURL,
									QB, QB_LIMIT, QB_TERMS, QB_VTYPE, QB_1099,
									DateUpdated, UpdatedBy
								   )
							VALUES (
									<cfqueryparam value="#TRIM(resultsQuery.NAME)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.FIRSTNAME)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.LASTNAME)#" cfsqltype="CF_SQL_VARCHAR">,									
									
									<cfqueryparam value="#TRIM(resultsQuery.ADDR1)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.ADDR2)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.ADDR3)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.ADDR4)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.ADDR5)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="US" cfsqltype="CF_SQL_VARCHAR">,
									
									<cfqueryparam value="#TRIM(resultsQuery.CONT1)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.EMAIL)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.PHONE1)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.PHONE2)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.FAXNUM)#" cfsqltype="CF_SQL_VARCHAR">,
									
									<cfif TRIM(resultsQuery.CUSTFLD2) EQ '' >
										<cfqueryparam value="1" cfsqltype="CF_SQL_BIT">,
									<cfelse>
										<cfqueryparam value="0" cfsqltype="CF_SQL_BIT">,
									</cfif>
									<cfqueryparam value="#TRIM(resultsQuery.NOTE)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.CONT2)#" cfsqltype="CF_SQL_VARCHAR">,
									
									<cfqueryparam value="#TRIM(resultsQuery.REFNUM)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.LIMIT)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.TERMS)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.VTYPE)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.1099)#" cfsqltype="CF_SQL_VARCHAR">,
									
									<cfqueryparam value="#DateUpdated#" cfsqltype="CF_SQL_DATE">,
									<cfqueryparam value="#UpdatedBy#" cfsqltype="CF_SQL_VARCHAR">
									)
						</cfquery>
					
						<cfset DistributorsAdded = DistributorsAdded + 1 >
						
						<cfcatch>
							INSERT ERROR AT RECORD NUMBER <b>#CurrentRow#</b> (#resultsQuery.NAME#):<br/>
							#cfcatch.Message#<br/>
							<cfset InsertErrors = InsertErrors + 1 >
						</cfcatch>
					</cftry>
				
				<cfelse>
					<cftry>
						<cfquery name="UpdateDistributorMain" datasource="#application.dsn#">
							UPDATE 	Distributors
							SET		DistributorName = <cfqueryparam value="#TRIM(resultsQuery.NAME)#" cfsqltype="CF_SQL_VARCHAR">,
									FirstName = <cfqueryparam value="#TRIM(resultsQuery.FIRSTNAME)#" cfsqltype="CF_SQL_VARCHAR">,
									LastName = <cfqueryparam value="#TRIM(resultsQuery.LASTNAME)#" cfsqltype="CF_SQL_VARCHAR">,
									Address1 = <cfqueryparam value="#TRIM(resultsQuery.ADDR1)#" cfsqltype="CF_SQL_VARCHAR">,
									Address2 = <cfqueryparam value="#TRIM(resultsQuery.ADDR2)#" cfsqltype="CF_SQL_VARCHAR">,
									City = <cfqueryparam value="#TRIM(resultsQuery.ADDR3)#" cfsqltype="CF_SQL_VARCHAR">,
									State = <cfqueryparam value="#TRIM(resultsQuery.ADDR4)#" cfsqltype="CF_SQL_VARCHAR">,
									Zipcode = <cfqueryparam value="#TRIM(resultsQuery.ADDR5)#" cfsqltype="CF_SQL_VARCHAR">,
									Country = <cfqueryparam value="US" cfsqltype="CF_SQL_VARCHAR">,
									RepName = <cfqueryparam value="#TRIM(resultsQuery.CONT1)#" cfsqltype="CF_SQL_VARCHAR">,
									Email = <cfqueryparam value="#TRIM(resultsQuery.EMAIL)#" cfsqltype="CF_SQL_VARCHAR">,
									Phone = <cfqueryparam value="#TRIM(resultsQuery.PHONE1)#" cfsqltype="CF_SQL_VARCHAR">,
									AltPhone = <cfqueryparam value="#TRIM(resultsQuery.PHONE2)#" cfsqltype="CF_SQL_VARCHAR">,
									Fax = <cfqueryparam value="#TRIM(resultsQuery.FAXNUM)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfif TRIM(resultsQuery.CUSTFLD2) EQ '' >
									Deleted = <cfqueryparam value="1" cfsqltype="CF_SQL_BIT">,
									<cfelse>
									Deleted = <cfqueryparam value="0" cfsqltype="CF_SQL_BIT">,
									</cfif>
									Comments = <cfqueryparam value="#TRIM(resultsQuery.NOTE)#" cfsqltype="CF_SQL_VARCHAR">,
									WebSiteURL = <cfqueryparam value="#TRIM(resultsQuery.CONT2)#" cfsqltype="CF_SQL_VARCHAR">,
									QB_LIMIT = <cfqueryparam value="#TRIM(resultsQuery.LIMIT)#" cfsqltype="CF_SQL_VARCHAR">,
									QB_TERMS = <cfqueryparam value="#TRIM(resultsQuery.TERMS)#" cfsqltype="CF_SQL_VARCHAR">,
									QB_VTYPE = <cfqueryparam value="#TRIM(resultsQuery.VTYPE)#" cfsqltype="CF_SQL_VARCHAR">,
									QB_1099 = <cfqueryparam value="#TRIM(resultsQuery.1099)#" cfsqltype="CF_SQL_VARCHAR">,
									DateUpdated = <cfqueryparam value="#DateUpdated#" cfsqltype="CF_SQL_DATE">,
									UpdatedBy = <cfqueryparam value="#UpdatedBy#" cfsqltype="CF_SQL_VARCHAR">
							WHERE	DistributorID = <cfqueryparam value="#FindDistributorMain.DistributorID#" cfsqltype="CF_SQL_INTEGER">
						</cfquery>
							
						<cfset DistributorsUpdated = DistributorsUpdated + 1 >
						
						<cfcatch>
							UPDATE ERROR AT RECORD NUMBER <b>#CurrentRow#</b> (#TRIM(resultsQuery.NAME)#):<br/>
							#cfcatch.Message#<br/>
							<cfset UpdateErrors = UpdateErrors + 1 >
						</cfcatch>
					</cftry>
				</cfif>
				
			</cfif>
		</cfloop>
		
		<cfset AdminMsg = 'Distributors Imported From QuickBooks' >
		<cfset ShowResults = 5 >
		
		</cfoutput>
		
		
		
	<!--- VENDORS (AS AFFILIATES) --->
	<cfelseif isDefined('form.ImportAffiliatesFile') >
		
		<cfoutput>
		
		<cfquery name="getAffiliates" datasource="#application.dsn#">
			SELECT 	AFID, QB
			FROM	Affiliates
		</cfquery>
								
		<cfx_text2Query
			file="#form.filename#"
			ColumnNames="VEND,NAME,REFNUM,TIMESTAMP,PRINTAS,ADDR1,ADDR2,ADDR3,ADDR4,ADDR5,VTYPE,CONT1,CONT2,PHONE1,PHONE2,FAXNUM,EMAIL,NOTE,TAXID,LIMIT,TERMS,NOTEPAD,SALUTATION,COMPANYNAME,FIRSTNAME,MIDINIT,LASTNAME,CUSTFLD1,CUSTFLD2,CUSTFLD3,CUSTFLD4,CUSTFLD5,CUSTFLD6,CUSTFLD7,CUSTFLD8,CUSTFLD9,CUSTFLD10,CUSTFLD11,CUSTFLD12,CUSTFLD13,CUSTFLD14,CUSTFLD15,1099,HIDDEN,DELCOUNT"
			firstRowIsHeader="false"
			qualifier="#chr(34)#"
			delimiter="#chr(9)#"
			maxrows="1000000"
			startrow="22"
			rQuery="resultsQuery">
		
		<cfif Preview EQ 1 >
			<cfdump var="#resultsQuery#"><cfif PreviewMode EQ 0 ><cfabort></cfif>
		</cfif>
		
		<cfloop query="resultsQuery">
			<cfif isDefined('resultsQuery.VEND')
			  AND resultsQuery.VEND EQ 'VEND'
			  AND TRIM(resultsQuery.VTYPE) EQ 'Sales Rep' >
			  
				<cftry>			
					<cfquery name="FindAffiliateMain" dbtype="query">
						SELECT 	AFID
						FROM	getAffiliates
						WHERE	QB = <cfqueryparam value="#TRIM(resultsQuery.REFNUM)#" cfsqltype="CF_SQL_VARCHAR">
					</cfquery>
						
					<cfcatch>
						<cfset OtherErrors = OtherErrors + 1 >
						COULDN'T FIND SALES REP AT RECORD NUMBER <b>#CurrentRow#</b> (#resultsQuery.NAME#) (#resultsQuery.CUSTFLD1#):<br/>
						#cfcatch.Message#<br/>
					</cfcatch>
				</cftry>
				<cfif FindAffiliateMain.RecordCount EQ 0 >
					<!--- <cftry> --->
						<cfquery name="InsertAffiliateMain" datasource="#application.dsn#">
							INSERT INTO Affiliates
								   (
									AFID, QB, AffiliateName, CompanyName, FirstName, LastName, 
									Address1, Address2, City, State, Zip, Country, 
									Email, EmailOK, Phone, Fax, 
									Password, Authenticated, Comments, TaxID,
									MemberType, PaymentFrequency, AffiliateCode, SubAffiliateOf, Deleted, Disabled,
									DateUpdated, UpdatedBy
								   )
							VALUES (
									<cfqueryparam value="#TRIM(resultsQuery.CUSTFLD2)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.REFNUM)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.NAME)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.COMPANYNAME)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.FIRSTNAME)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.LASTNAME)#" cfsqltype="CF_SQL_VARCHAR">,									
									
									<cfqueryparam value="#TRIM(resultsQuery.ADDR1)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.ADDR2)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.ADDR3)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.ADDR4)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.ADDR5)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="US" cfsqltype="CF_SQL_VARCHAR">,
									
									<cfqueryparam value="#TRIM(resultsQuery.EMAIL)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="1" cfsqltype="CF_SQL_BIT">,
									<cfqueryparam value="#TRIM(resultsQuery.PHONE1)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.FAXNUM)#" cfsqltype="CF_SQL_VARCHAR">,
									
									<cfqueryparam value="#ENCRYPT(RandRange(100000,999999), application.CryptKey, 'CFMX_COMPAT', 'Hex')#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="1" cfsqltype="CF_SQL_BIT">,
									<cfqueryparam value="#TRIM(resultsQuery.NOTE)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.TAXID)#" cfsqltype="CF_SQL_VARCHAR">,
									
									<cfqueryparam value="#TRIM(resultsQuery.CUSTFLD3)#" cfsqltype="CF_SQL_INTEGER">,
									<cfqueryparam value="1" cfsqltype="CF_SQL_INTEGER">,
									<cfqueryparam value="#TRIM(resultsQuery.CUSTFLD1)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.CUSTFLD4)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="0" cfsqltype="CF_SQL_BIT">,
									<cfqueryparam value="0" cfsqltype="CF_SQL_BIT">,
									
									<cfqueryparam value="#TRIM(resultsQuery.LIMIT)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.TERMS)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.VTYPE)#" cfsqltype="CF_SQL_VARCHAR">,
									<cfqueryparam value="#TRIM(resultsQuery.1099)#" cfsqltype="CF_SQL_VARCHAR">,
									
									<cfqueryparam value="#DateUpdated#" cfsqltype="CF_SQL_DATE">,
									<cfqueryparam value="#UpdatedBy#" cfsqltype="CF_SQL_VARCHAR">
									)
						</cfquery>
					
						<cfset AffiliatesAdded = AffiliatesAdded + 1 >
						
						<!--- <cfcatch>
							INSERT ERROR AT RECORD NUMBER <b>#CurrentRow#</b> (#resultsQuery.NAME#):<br/>
							#cfcatch.Message#<br/>
							<cfset InsertErrors = InsertErrors + 1 >
						</cfcatch>
					</cftry> --->
				
				<cfelse>
					<cftry>
						<cfquery name="UpdateAffiliateMain" datasource="#application.dsn#">
							UPDATE 	Affiliates
							SET		AffiliateName = <cfqueryparam value="#TRIM(resultsQuery.NAME)#" cfsqltype="CF_SQL_VARCHAR">,
									CompanyName = <cfqueryparam value="#TRIM(resultsQuery.COMPANYNAME)#" cfsqltype="CF_SQL_VARCHAR">,
									FirstName = <cfqueryparam value="#TRIM(resultsQuery.FIRSTNAME)#" cfsqltype="CF_SQL_VARCHAR">,
									LastName = <cfqueryparam value="#TRIM(resultsQuery.LASTNAME)#" cfsqltype="CF_SQL_VARCHAR">,
									Address1 = <cfqueryparam value="#TRIM(resultsQuery.ADDR1)#" cfsqltype="CF_SQL_VARCHAR">,
									Address2 = <cfqueryparam value="#TRIM(resultsQuery.ADDR2)#" cfsqltype="CF_SQL_VARCHAR">,
									City = <cfqueryparam value="#TRIM(resultsQuery.ADDR3)#" cfsqltype="CF_SQL_VARCHAR">,
									State = <cfqueryparam value="#TRIM(resultsQuery.ADDR4)#" cfsqltype="CF_SQL_VARCHAR">,
									Zip = <cfqueryparam value="#TRIM(resultsQuery.ADDR5)#" cfsqltype="CF_SQL_VARCHAR">,
									Country = <cfqueryparam value="US" cfsqltype="CF_SQL_VARCHAR">,
									Email = <cfqueryparam value="#TRIM(resultsQuery.EMAIL)#" cfsqltype="CF_SQL_VARCHAR">,
									Phone = <cfqueryparam value="#TRIM(resultsQuery.PHONE1)#" cfsqltype="CF_SQL_VARCHAR">,
									Fax = <cfqueryparam value="#TRIM(resultsQuery.FAXNUM)#" cfsqltype="CF_SQL_VARCHAR">,
									Comments = <cfqueryparam value="#TRIM(resultsQuery.NOTE)#" cfsqltype="CF_SQL_VARCHAR">,
									TaxID = <cfqueryparam value="#TRIM(resultsQuery.TAXID)#" cfsqltype="CF_SQL_VARCHAR">,
									MemberType = <cfqueryparam value="#TRIM(resultsQuery.CUSTFLD3)#" cfsqltype="CF_SQL_INTEGER">,
									PaymentFrequency = <cfqueryparam value="1" cfsqltype="CF_SQL_INTEGER">,
									AffiliateCode = <cfqueryparam value="#TRIM(resultsQuery.CUSTFLD1)#" cfsqltype="CF_SQL_VARCHAR">,
									SubAffiliateOf = <cfqueryparam value="#TRIM(resultsQuery.CUSTFLD4)#" cfsqltype="CF_SQL_VARCHAR">,
									Deleted = <cfqueryparam value="0" cfsqltype="CF_SQL_BIT">,
									Disabled = <cfqueryparam value="0" cfsqltype="CF_SQL_BIT">,
									QB_LIMIT = <cfqueryparam value="#TRIM(resultsQuery.LIMIT)#" cfsqltype="CF_SQL_VARCHAR">,
									QB_TERMS = <cfqueryparam value="#TRIM(resultsQuery.TERMS)#" cfsqltype="CF_SQL_VARCHAR">,
									QB_VTYPE = <cfqueryparam value="#TRIM(resultsQuery.VTYPE)#" cfsqltype="CF_SQL_VARCHAR">,
									QB_1099 = <cfqueryparam value="#TRIM(resultsQuery.1099)#" cfsqltype="CF_SQL_VARCHAR">,
									DateUpdated = <cfqueryparam value="#DateUpdated#" cfsqltype="CF_SQL_DATE">,
									UpdatedBy = <cfqueryparam value="#UpdatedBy#" cfsqltype="CF_SQL_VARCHAR">
							WHERE	AFID = <cfqueryparam value="#FindAffiliateMain.AFID#" cfsqltype="CF_SQL_INTEGER">
						</cfquery>
							
						<cfset AffiliatesUpdated = AffiliatesUpdated + 1 >
						
						<cfcatch>
							UPDATE ERROR AT RECORD NUMBER <b>#CurrentRow#</b> (#TRIM(resultsQuery.NAME)#):<br/>
							#cfcatch.Message#<br/>
							<cfset UpdateErrors = UpdateErrors + 1 >
						</cfcatch>
					</cftry>
				</cfif>
				
			</cfif>
		</cfloop>
		
		<cfset AdminMsg = 'Sales Reps Imported From QuickBooks' >
		<cfset ShowResults = 6 >
		
		</cfoutput>
		
	</cfif><!--- isDefined('form.ImportItemsFile') --->
</cfif><!--- isDefined('form.filename') AND form.filename NEQ '' --->








<cfscript>
	PageTitle = 'QuickBooks-2-CartFusion Data Importer';
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

<script language="javascript">
<!--
function doConfirm(btnWaiter) {
	if (confirm("Are you sure you want to import the selected QuickBooks IIF file into CartFusion?")) { 
		btnWaiter.setAttribute("value","PROCESSING FILE...");
		document.body.style.cursor="wait";
		return true;
	} 
	return false;
}
-->
</script>

<table width="100%" border="1" bordercolor="FFFFFF" cellpadding="7" cellspacing="0">
	<tr>
		<td width="33%" class="cfAdminHeader1" bordercolor="EFEFEF">CUSTOMER IMPORTER</td>
		<td width="1" rowspan="2" bordercolor="FFFFFF"><img src="images/spacer.gif" width="1" height="1" /></td>
		<td width="33%" class="cfAdminHeader1" bordercolor="EFEFEF">VENDOR/DISTRIBUTOR IMPORTER</td>
		<td width="1" rowspan="2" bordercolor="FFFFFF"><img src="images/spacer.gif" width="1" height="1" /></td>
		<td width="33%" class="cfAdminHeader1" bordercolor="EFEFEF">VENDOR/SALES REP IMPORTER</td>
	</tr>
	<tr>
		<!--- CUSTOMER IMPORTER --->
		<cfform name="frmData4" action="QB-ImportFrom.cfm" method="post">
		<td width="33%" align="center" bgcolor="F1FCE4" bordercolor="EFEFEF">
			Import ALL QuickBooks Customer Data to CartFusion<br><br>
			<table width="100%">
				<tr>
					<td width="100%" align="center" colspan="2">
						Customers IIF File: <cfinput type="file" name="filename" size="50" required="yes" message="Please select a file to import" class="cfAdminDefault"><br/>
					</td>
				</tr>
				<tr>
					<td width="100%" align="center" colspan="2">
						<input type="submit" name="ImportCustomersFile" value="IMPORT FILE" style="width:200px;" class="cfAdminButton" onclick="return doConfirm(this);">
					</td>
				</tr>
			</table>
		</td>
		</cfform>
		<!--- DISTRIBUTOR UPDATER --->
		<cfform name="frmData5" action="QB-ImportFrom.cfm" method="post">
		<td width="33%" align="center" bgcolor="FFF7F0" bordercolor="EFEFEF">
			Import ALL QuickBooks Vendor/Distributor Data to CartFusion<br><br>
			<table width="100%">
				<tr>
					<td width="100%" align="center" colspan="2">
						Vendors IIF File: <cfinput type="file" name="filename" size="50" required="yes" message="Please select a file to import" class="cfAdminDefault"><br/>
					</td>
				</tr>
				<tr>
					<td width="100%" align="center" colspan="2">
						<input type="submit" name="ImportDistributorsFile" value="IMPORT FILE" style="width:200px;" class="cfAdminButton" onclick="return doConfirm(this);">
					</td>
				</tr>
			</table>
		</td>
		</cfform>
		<!--- AFFILIATES UPDATER --->
		<cfform name="frmData6" action="QB-ImportFrom.cfm" method="post">
		<td width="33%" align="center" bgcolor="FFEDE1" bordercolor="EFEFEF">
			Import ALL QuickBooks Vendor/Sales Rep Data to CartFusion<br><br>
			<table width="100%">
				<tr>
					<td width="100%" align="center" colspan="2">
						Vendors IIF File: <cfinput type="file" name="filename" size="50" required="yes" message="Please select a file to import" class="cfAdminDefault"><br/>
					</td>
				</tr>
				<tr>
					<td width="100%" align="center" colspan="2">
						<input type="submit" name="ImportAffiliatesFile" value="IMPORT FILE" style="width:200px;" class="cfAdminButton" onclick="return doConfirm(this);">
					</td>
				</tr>
			</table>
		</td>
		</cfform>
	</tr>
</table>

<br/><br/>

<table width="100%" border="1" bordercolor="FFFFFF" cellpadding="7" cellspacing="0">
	<tr>
		<td width="33%" class="cfAdminHeader1" bordercolor="EFEFEF">ITEM IMPORTER</td>
		<td width="1" rowspan="2" bordercolor="FFFFFF"><img src="images/spacer.gif" width="1" height="1" /></td>
		<td width="33%" class="cfAdminHeader1" bordercolor="EFEFEF">ITEM STOCK QUANTITY IMPORTER</td>
		<td width="1" rowspan="2" bordercolor="FFFFFF"><img src="images/spacer.gif" width="1" height="1" /></td>
		<td width="33%" class="cfAdminHeader1" bordercolor="EFEFEF">ITEM PRICE<font class="cfAdminError">1</font> IMPORTER</td>
	</tr>
	<tr>
		<!--- PRODUCT IMPORTER --->
		<cfform name="frmData1" action="QB-ImportFrom.cfm" method="post">
		<td width="33%" align="center" bgcolor="E7F2F8" bordercolor="EFEFEF">
			Import ALL QuickBooks Item Data to CartFusion<br><br>
			<table width="100%">
				<tr>
					<td width="100%" align="center" colspan="2">
						Items IIF File: <cfinput type="file" name="filename" size="50" required="yes" message="Please select a file to import" class="cfAdminDefault"><br/>
					</td>
				</tr>
				<tr>
					<td width="100%" align="center" colspan="2">
						<input type="submit" name="ImportItemsFile" value="IMPORT FILE" style="width:200px;" class="cfAdminButton" onclick="return doConfirm(this);">
					</td>
				</tr>
			</table>
		</td>
		</cfform>
		<!--- STOCK QUANTITY UPDATER --->
		<cfform name="frmData2" action="QB-ImportFrom.cfm" method="post">
		<td width="33%" align="center" bgcolor="E7F2F8" bordercolor="EFEFEF">
			<!--- Import QuickBooks Item Quantities on Hand to CartFusion<br><br>
			<table width="100%">
				<tr>
					<td width="100%" align="center" colspan="2">
						Items IIF File: <cfinput type="file" name="filename" size="50" required="yes" message="Please select a file to import" class="cfAdminDefault"><br/>
					</td>
				</tr>
				<tr>
					<td width="100%" align="center" colspan="2">
						<input type="submit" name="UpdateInventory" value="IMPORT FILE" style="width:200px;" class="cfAdminButton" onclick="return doConfirm(this);">
					</td>
				</tr>
			</table> --->
		</td>
		</cfform>
		<!--- RETAIL PRICE UPDATER --->
		<cfform name="frmData3" action="QB-ImportFrom.cfm" method="post">
		<td width="33%" align="center" bgcolor="E7F2F8" bordercolor="EFEFEF">
			<!--- Import QuickBooks Item Prices to CartFusion<br><br>
			<table width="100%">
				<tr>
					<td width="100%" align="center" colspan="2">
						Items IIF File: <cfinput type="file" name="filename" size="50" required="yes" message="Please select a file to import" class="cfAdminDefault"><br/>
					</td>
				</tr>
				<tr>
					<td width="100%" align="center" colspan="2">
						<input type="submit" name="UpdatePrices" value="IMPORT FILE" style="width:200px;" class="cfAdminButton" onclick="return doConfirm(this);">
					</td>
				</tr>
			</table> --->
		</td>
		</cfform>
	</tr>
</table>

<!--- RESULTS --->
<cfif ShowResults EQ 1 >
	<cfoutput>
	<br/><br/>
	<table width="50%" border="1" bordercolor="EFEFEF" cellpadding="7" cellspacing="0" align="center">
		<tr>
			<td width="100%" colspan="2" align="center" class="cfAdminTitle" bgcolor="E7F2F8">
				ITEM IMPORT RESULTS
			</td>
		</tr>
		<tr>
			<td width="100%" colspan="2" align="center" class="cfAdminTitle">
				<table width="100%" cellpadding="2" cellspacing="0" border="0">
					<tr>
						<td width="100%" align="center" colspan="2">File Imported:<br/><a>#form.filename#</a><br/><br/></td>
					</tr>
					<tr>
						<td width="50%" align="right">Total Records Retrieved:</td>
						<td width="50%" class="cfAdminError">#resultsQuery.RecordCount#</td>
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
	<table width="50%" border="1" bordercolor="EFEFEF" cellpadding="7" cellspacing="0" align="center">
		<tr>
			<td width="100%" colspan="2" align="center" class="cfAdminTitle" bgcolor="E7F2F8">
				STOCK QUANTITY UPDATE RESULTS
			</td>
		</tr>
		<tr>
			<td width="100%" colspan="2" align="center" class="cfAdminTitle">
				<table width="100%" cellpadding="2" cellspacing="0" border="0">
					<tr>
						<td width="100%" align="center" colspan="2">File Imported:<br/><a>#form.filename#</a><br/><br/></td>
					</tr>
					<tr>
						<td width="50%" align="right">Total Records Retrieved:</td>
						<td width="50%" class="cfAdminError">#resultsQuery.RecordCount#</td>
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
<cfelseif ShowResults EQ 3 >
	<cfoutput>
	<br/><br/>
	<table width="50%" border="1" bordercolor="EFEFEF" cellpadding="7" cellspacing="0" align="center">
		<tr>
			<td width="100%" colspan="2" align="center" class="cfAdminTitle" bgcolor="E7F2F8">
				PRICE1 UPDATE RESULTS
			</td>
		</tr>
		<tr>
			<td width="100%" colspan="2" align="center" class="cfAdminTitle">
				<table width="100%" cellpadding="2" cellspacing="0" border="0">
					<tr>
						<td width="100%" align="center" colspan="2">File Imported:<br/><a>#form.filename#</a><br/><br/></td>
					</tr>
					<tr>
						<td width="50%" align="right">Total Records Retrieved:</td>
						<td width="50%" class="cfAdminError">#resultsQuery.RecordCount#</td>
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
<cfelseif ShowResults EQ 4 >
	<cfoutput>
	<br/><br/>
	<table width="50%" border="1" bordercolor="EFEFEF" cellpadding="7" cellspacing="0" align="center">
		<tr>
			<td width="100%" colspan="2" align="center" class="cfAdminTitle" bgcolor="F1FCE4">
				CUSTOMER IMPORT RESULTS
			</td>
		</tr>
		<tr>
			<td width="100%" colspan="2" align="center" class="cfAdminTitle">
				<table width="100%" cellpadding="2" cellspacing="0" border="0">
					<tr>
						<td width="100%" align="center" colspan="2">File Imported:<br/><a>#form.filename#</a><br/><br/></td>
					</tr>
					<tr>
						<td width="50%" align="right">Total Records Retrieved:</td>
						<td width="50%" class="cfAdminError">#resultsQuery.RecordCount#</td>
					</tr>
					<tr>
						<td width="50%" align="right">Customers Added:</td>
						<td width="50%" class="cfAdminError">#CustomersAdded#</td>
					</tr>
					<tr>
						<td width="50%" align="right">Customers Updated:</td>
						<td width="50%" class="cfAdminError">#CustomersUpdated#</td>
					</tr>
					<tr>
						<td width="50%" align="right">Insert Errors:</td>
						<td width="50%" class="cfAdminError">#InsertErrors#</td>
					</tr>
					<tr>
						<td width="50%" align="right">Update Errors:</td>
						<td width="50%" class="cfAdminError">#UpdateErrors#</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	</cfoutput>
<cfelseif ShowResults EQ 5 >
	<cfoutput>
	<br/><br/>
	<table width="50%" border="1" bordercolor="EFEFEF" cellpadding="7" cellspacing="0" align="center">
		<tr>
			<td width="100%" colspan="2" align="center" class="cfAdminTitle" bgcolor="FFF7F0">
				DISTRIBUTOR IMPORT RESULTS
			</td>
		</tr>
		<tr>
			<td width="100%" colspan="2" align="center" class="cfAdminTitle">
				<table width="100%" cellpadding="2" cellspacing="0" border="0">
					<tr>
						<td width="100%" align="center" colspan="2">File Imported:<br/><a>#form.filename#</a><br/><br/></td>
					</tr>
					<tr>
						<td width="50%" align="right">Total Records Retrieved:</td>
						<td width="50%" class="cfAdminError">#resultsQuery.RecordCount#</td>
					</tr>
					<tr>
						<td width="50%" align="right">Distributors Added:</td>
						<td width="50%" class="cfAdminError">#DistributorsAdded#</td>
					</tr>
					<tr>
						<td width="50%" align="right">Distributors Updated:</td>
						<td width="50%" class="cfAdminError">#DistributorsUpdated#</td>
					</tr>
					<tr>
						<td width="50%" align="right">Insert Errors:</td>
						<td width="50%" class="cfAdminError">#InsertErrors#</td>
					</tr>
					<tr>
						<td width="50%" align="right">Update Errors:</td>
						<td width="50%" class="cfAdminError">#UpdateErrors#</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	</cfoutput>
<cfelseif ShowResults EQ 6 >
	<cfoutput>
	<br/><br/>
	<table width="50%" border="1" bordercolor="EFEFEF" cellpadding="7" cellspacing="0" align="center">
		<tr>
			<td width="100%" colspan="2" align="center" class="cfAdminTitle" bgcolor="FFEDE1">
				SALES REP IMPORT RESULTS
			</td>
		</tr>
		<tr>
			<td width="100%" colspan="2" align="center" class="cfAdminTitle">
				<table width="100%" cellpadding="2" cellspacing="0" border="0">
					<tr>
						<td width="100%" align="center" colspan="2">File Imported:<br/><a>#form.filename#</a><br/><br/></td>
					</tr>
					<tr>
						<td width="50%" align="right">Total Records Retrieved:</td>
						<td width="50%" class="cfAdminError">#resultsQuery.RecordCount#</td>
					</tr>
					<tr>
						<td width="50%" align="right">Sales Reps Added:</td>
						<td width="50%" class="cfAdminError">#AffiliatesAdded#</td>
					</tr>
					<tr>
						<td width="50%" align="right">Sales Reps Updated:</td>
						<td width="50%" class="cfAdminError">#AffiliatesUpdated#</td>
					</tr>
					<tr>
						<td width="50%" align="right">Insert Errors:</td>
						<td width="50%" class="cfAdminError">#InsertErrors#</td>
					</tr>
					<tr>
						<td width="50%" align="right">Update Errors:</td>
						<td width="50%" class="cfAdminError">#UpdateErrors#</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	</cfoutput>
</cfif>


<cfinclude template="../LayoutAdminFooter.cfm">