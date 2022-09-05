<!---
	CartFusion 4.6 - Copyright � 2005 Trade Studios, LLC.
	This copyright notice MUST stay intact for use (see license.txt).
	It is against the law to copy, distribute, gift, bundle or give away this code 
	without written consent from Trade Studios, LLC.
--->

<!--- SETUP TRACKING VARIABLES --->
<cfscript>
	ShowResults = 0 ;
	Blank = '' ;
</cfscript>

<!--- ITEMS --->
<cfif isDefined('form.ExportItemsFile') >
	
	<cfoutput>
	
	<cfquery name="getProducts" datasource="#application.dsn#">
		SELECT	*
		FROM	Products
		ORDER BY QB_SUBITEM, SKU
	</cfquery>
	<cfquery name="getCategories" datasource="#application.dsn#">
		SELECT	CatID, CatName, SubCategoryOf
		FROM	Categories
		ORDER BY CatName
	</cfquery>

	<!--- ONLY CREATE FILE IF RECORDS ARE RETURNED --->
	<cfif getProducts.RecordCount NEQ 0 >
	
		<!--- SET FILENAME FOR USE --->
		<cfscript>
			CF2QBfile = 'CF2QB Items #DateFormat(Now(),'yyyymmdd')# #TimeFormat(Now(),'HHmmss')#.IIF' ;
			CF2QBpath = '#getDirectoryFromPath(getCurrentTemplatePath())#docs\' ;
		</cfscript>
		
		<!--- CREATE BLANK FILE --->
		<cffile action="write" file="#CF2QBpath##CF2QBfile#" output="" addnewline="no">
		
		<!--- CREATE FILE HEADERS --->
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="!CUSTITEMDICT	INDEX	LABEL	INUSE">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="!ENDCUSTITEMDICT">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="CUSTITEMDICT	0	Retail Price	Y">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="CUSTITEMDICT	1	Volume (pts)	Y">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="CUSTITEMDICT	2	Internet Description	Y">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="CUSTITEMDICT	3	Weight (lbs)	Y">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="CUSTITEMDICT	4	CartFusion ID	Y">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="ENDCUSTITEMDICT">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="!INVITEM	NAME	REFNUM	TIMESTAMP	INVITEMTYPE	DESC	PURCHASEDESC	ACCNT	ASSETACCNT	COGSACCNT	QNTY	QNTY	PRICE	COST	TAXABLE	SALESTAXCODE	PAYMETH	TAXVEND	PREFVEND	REORDERPOINT	EXTRA	CUSTFLD1	CUSTFLD2	CUSTFLD3	CUSTFLD4	CUSTFLD5	DEP_TYPE	ISPASSEDTHRU	HIDDEN	DELCOUNT	USEID	ISNEW	PO_NUM	SERIALNUM	WARRANTY	LOCATION	VENDOR	ASSETDESC	SALEDATE	SALEEXPENSE	NOTES	ASSETNUM	COSTBASIS	ACCUMDEPR	UNRECBASIS	PURCHASEDATE">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="!TRNS	TRNSID	TRNSTYPE	DATE	ACCNT	NAME	CLASS	AMOUNT	DOCNUM	MEMO	CLEAR	TOPRINT	NAMEISTAXABLE	DUEDATE	TERMS	PAYMETH	SHIPVIA	SHIPDATE	REP	FOB	PONUM	INVMEMO	ADDR1	ADDR2	ADDR3	ADDR4	ADDR5	SADDR1	SADDR2	SADDR3	SADDR4	SADDR5">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="!SPL	SPLID	TRNSTYPE	DATE	ACCNT	NAME	CLASS	AMOUNT	DOCNUM	MEMO	CLEAR	QNTY	PRICE	INVITEM	PAYMETH	TAXABLE	EXTRA	VATCODE	VATRATE	VATAMOUNT	VALADJ	SERVICEDATE	TAXCODE	TAXRATE	TAXAMOUNT">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="!ENDTRNS">																																																						
		
		<!--- LOOP OVER EACH LINE AND INSERT DATA INTO FILE --->
		<cfloop query="getProducts">
			<cfif Taxable EQ 1 ><cfset IsTaxable = 'Y'><cfelse><cfset IsTaxable = 'N'></cfif>
			<cfif Hide1 EQ 1 ><cfset IsHidden = 'Y'><cfelse><cfset IsHidden = 'N'></cfif>
			<!--- CATEGORY NAMES --->
			<cfquery name="getCategoryName" dbtype="query">
				SELECT	CatID, CatName, SubCategoryOf
				FROM	getCategories
				WHERE	CatID = #Category#
			</cfquery>
			<cfif TRIM(getCategoryName.CatName) EQ 'Style' OR TRIM(getCategoryName.CatName) EQ '' >
				<cfset CatName = TRIM(ItemName) >
				<cfset MainCatName = 'Style' >
			<cfelseif TRIM(getCategoryName.CatName) NEQ '' >
				<cfset CatName = TRIM(getCategoryName.CatName) >
				<cfif TRIM(getCategoryName.SubCategoryOf) NEQ '' >
					<cfquery name="getMainCategoryName" dbtype="query">
						SELECT	CatName
						FROM	getCategories
						WHERE	CatID = #getCategoryName.SubCategoryOf#
					</cfquery>
					<cfif TRIM(getMainCategoryName.CatName) EQ 'Style' OR TRIM(getMainCategoryName.CatName) EQ '' >
						<cfset MainCatName = 'Style' >
					<cfelse>
						<cfset MainCatName = 'Style, ' & TRIM(getMainCategoryName.CatName) >
					</cfif>
				<cfelse>
					<cfset MainCatName = 'Style' >
				</cfif>
			</cfif>
			<!--- !CATEGORY NAMES --->
			
			
			<!--- QB_PREFVEND instead of MainCatName ? --->
			<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="INVITEM	#QB_SUBITEM#:#SKU#	#QB#	#Blank#	INVENTORY	#ItemName#	#CatName#	#QB_ACCNT#	#QB_ASSETACCNT#	#QB_COGSACCNT#	#StockQuantity#	0	#Price1#	#CostPrice#	#IsTaxable#	#QB_SALESTAXCODE#	#QB_PAYMETH#	#QB_TAXVEND#	#MainCatName#	#QB_REORDERPOINT#	#Blank#	#Price2#	#Volume#	#TRIM(Replace(ItemDescription,chr(9),' ','ALL'))#	#Weight#	#ItemID#	0	N	#IsHidden#	0	N	Y	#Blank#	#Blank#	#Blank#	#Blank#	#Blank#	#Blank#	#Blank#	0	#Comments#	#Blank#	0	0	0	#Blank#">
		</cfloop>
	
		<cfset AdminMsg = 'QuickBooks IIF File Created: "#CF2QBfile#"' >
		<cfset ShowResults = 1 >
	
	<cfelse>
		<cfset AdminMsg = 'No Products Available To Export' >	
	</cfif>
		
	</cfoutput>
	
	
	
<!--- CUSTOMERS --->
<cfelseif isDefined('form.ExportCustomersFile') >
			
	<cfoutput>
	
	<cfquery name="getCustomers" datasource="#application.dsn#">
		SELECT	*
		FROM	Customers
		ORDER BY CustomerName, LastName, FirstName, QB
	</cfquery>

	<!--- ONLY CREATE FILE IF RECORDS ARE RETURNED --->
	<cfif getCustomers.RecordCount NEQ 0 >
	
		<!--- SET FILENAME FOR USE --->
		<cfscript>
			CF2QBfile = 'CF2QB Customers #DateFormat(Now(),'yyyymmdd')# #TimeFormat(Now(),'HHmmss')#.IIF' ;
			CF2QBpath = '#getDirectoryFromPath(getCurrentTemplatePath())#docs\' ;
		</cfscript>
		
		<!--- CREATE BLANK FILE --->
		<cffile action="write" file="#CF2QBpath##CF2QBfile#" output="" addnewline="no">
		
		<!--- CREATE FILE HEADERS --->
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="!CUSTNAMEDICT	INDEX	LABEL	CUSTOMER	VENDOR	EMPLOYEE">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="!ENDCUSTNAMEDICT">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="CUSTNAMEDICT	0	AccPacID	Y	Y	N">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="CUSTNAMEDICT	1	CartFusionID	Y	Y	N">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="CUSTNAMEDICT	2	MemberType	Y	Y	N">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="CUSTNAMEDICT	3	SubOf	Y	Y	N">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="CUSTNAMEDICT	4		N	N	N">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="CUSTNAMEDICT	5		N	N	N">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="CUSTNAMEDICT	6		N	N	N">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="CUSTNAMEDICT	7		N	N	N">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="CUSTNAMEDICT	8		N	N	N">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="CUSTNAMEDICT	9		N	N	N">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="CUSTNAMEDICT	10		N	N	N">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="CUSTNAMEDICT	11		N	N	N">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="CUSTNAMEDICT	12		N	N	N">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="CUSTNAMEDICT	13		N	N	N">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="CUSTNAMEDICT	14		N	N	N">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="ENDCUSTNAMEDICT">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="!CUST	NAME	REFNUM	TIMESTAMP	BADDR1	BADDR2	BADDR3	BADDR4	BADDR5	SADDR1	SADDR2	SADDR3	SADDR4	SADDR5	PHONE1	PHONE2	FAXNUM	EMAIL	NOTE	CONT1	CONT2	CTYPE	TERMS	TAXABLE	SALESTAXCODE	LIMIT	RESALENUM	REP	TAXITEM	NOTEPAD	SALUTATION	COMPANYNAME	FIRSTNAME	MIDINIT	LASTNAME	CUSTFLD1	CUSTFLD2	CUSTFLD3	CUSTFLD4	CUSTFLD5	CUSTFLD6	CUSTFLD7	CUSTFLD8	CUSTFLD9	CUSTFLD10	CUSTFLD11	CUSTFLD12	CUSTFLD13	CUSTFLD14	CUSTFLD15	JOBDESC	JOBTYPE	JOBSTATUS	JOBSTART	JOBPROJEND	JOBEND	HIDDEN	DELCOUNT	PRICELEVEL">

		<!--- LOOP OVER EACH LINE AND INSERT DATA INTO FILE --->
		<cfloop query="getCustomers">
			<cfif Deleted EQ 1 ><cfset IsHidden = 'Y'><cfelse><cfset IsHidden = 'N'></cfif>
			
			<!--- QB_PREFVEND instead of MainCatName ? --->
			<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="CUST	#CustomerName#	#QB#	#Blank#	#Address1#	#Address2#	#City#	#State#	#Zip#	#ShipAddress1#	#ShipAddress2#	#ShipCity#	#ShipState#	#ShipZip#	#Phone#	#ShipPhone#	#Fax#	#Email#	#Comments#	#QB_CONT1#	#QB_CONT2#	#QB_CTYPE#	#PaymentTerms#	#QB_TAXABLE#	#QB_SALESTAXCODE#	#CreditLimit#	#QB_RESALENUM#	#QB_REP#	#QB_TAXITEM#	#Blank#	#Blank#	#CompanyName#	#FirstName#	#Blank#	#LastName#	#CustomerID#	#CustomerID#	#Blank#	#AffiliateCode#	#Blank#	#Blank#	#Blank#	#Blank#	#Blank#	#Blank#	#Blank#	#Blank#	#Blank#	#Blank# #Blank#	 	#QB_JOBDESC#	#QB_JOBTYPE#	#QB_JOBSTATUS#	#QB_JOBSTART#	#QB_JOBPROJEND#	#QB_JOBEND#	#IsHidden#	0	#Blank#">
		</cfloop>
	
		<cfset AdminMsg = 'QuickBooks IIF File Created: "#CF2QBfile#"' >
		<cfset ShowResults = 4 >
	
	<cfelse>
		<cfset AdminMsg = 'No Customers Available To Export' >	
	</cfif>
		
	</cfoutput>
	
	

<!--- VENDORS (AS DISTRIBUTORS) --->
<cfelseif isDefined('form.ExportDistributorsFile') >
	
	<cfoutput>
	
	<cfquery name="getDistributors" datasource="#application.dsn#">
		SELECT 	*
		FROM	Distributors
		ORDER BY DistributorName, QB
	</cfquery>

	<!--- ONLY CREATE FILE IF RECORDS ARE RETURNED --->
	<cfif getDistributors.RecordCount NEQ 0 >
	
		<!--- SET FILENAME FOR USE --->
		<cfscript>
			CF2QBfile = 'CF2QB Distributors #DateFormat(Now(),'yyyymmdd')# #TimeFormat(Now(),'HHmmss')#.IIF' ;
			CF2QBpath = '#getDirectoryFromPath(getCurrentTemplatePath())#docs\' ;
		</cfscript>
		
		<!--- CREATE BLANK FILE --->
		<cffile action="write" file="#CF2QBpath##CF2QBfile#" output="" addnewline="no">
		
		<!--- CREATE FILE HEADERS --->
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="!CUSTNAMEDICT	INDEX	LABEL	CUSTOMER	VENDOR	EMPLOYEE">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="!ENDCUSTNAMEDICT">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="CUSTNAMEDICT	0	AccPacID	Y	Y	N">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="CUSTNAMEDICT	1	CartFusionID	Y	Y	N">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="CUSTNAMEDICT	2	MemberType	Y	Y	N">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="CUSTNAMEDICT	3	SubOf	Y	Y	N">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="CUSTNAMEDICT	4		N	N	N">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="CUSTNAMEDICT	5		N	N	N">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="CUSTNAMEDICT	6		N	N	N">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="CUSTNAMEDICT	7		N	N	N">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="CUSTNAMEDICT	8		N	N	N">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="CUSTNAMEDICT	9		N	N	N">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="CUSTNAMEDICT	10		N	N	N">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="CUSTNAMEDICT	11		N	N	N">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="CUSTNAMEDICT	12		N	N	N">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="CUSTNAMEDICT	13		N	N	N">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="CUSTNAMEDICT	14		N	N	N">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="ENDCUSTNAMEDICT">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="!VEND	NAME	REFNUM	TIMESTAMP	PRINTAS	ADDR1	ADDR2	ADDR3	ADDR4	ADDR5	VTYPE	CONT1	CONT2	PHONE1	PHONE2	FAXNUM	EMAIL	NOTE	TAXID	LIMIT	TERMS	NOTEPAD	SALUTATION	COMPANYNAME	FIRSTNAME	MIDINIT	LASTNAME	CUSTFLD1	CUSTFLD2	CUSTFLD3	CUSTFLD4	CUSTFLD5	CUSTFLD6	CUSTFLD7	CUSTFLD8	CUSTFLD9	CUSTFLD10	CUSTFLD11	CUSTFLD12	CUSTFLD13	CUSTFLD14	CUSTFLD15	1099	HIDDEN	DELCOUNT">

		<!--- LOOP OVER EACH LINE AND INSERT DATA INTO FILE --->
		<cfloop query="getDistributors">
			<cfif Deleted EQ 1 ><cfset IsHidden = 'Y'><cfelse><cfset IsHidden = 'N'></cfif>
			
			<!--- QB_PREFVEND instead of MainCatName ? --->
			<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="VEND	#DistributorName#	#QB#	#Blank#	#DistributorName#	#Address1#	#Address2#	#City#	#State#	#Zipcode#	#Blank#	#RepName#	#WebSiteURL#	#Phone#	#AltPhone#	#Fax#	#Email#	#Comments#	#TaxID#	#QB_LIMIT#	#QB_TERMS#	#Blank#	#Blank#	#CompanyName#	#FirstName#	#Blank#	#LastName#	#Blank#	#DistributorID#	#Blank#	#Blank#	#Blank#	#Blank#	#Blank#	#Blank#	#Blank#	#Blank#	#Blank#	#Blank#	#Blank#	#Blank# #Blank#	 	#QB_1099#	#IsHidden#	0">
		</cfloop>
	
		<cfset AdminMsg = 'QuickBooks IIF File Created: "#CF2QBfile#"' >
		<cfset ShowResults = 5 >
	
	<cfelse>
		<cfset AdminMsg = 'No Vendors/Distributors Available To Export' >	
	</cfif>
		
	</cfoutput>

	
	
	
<!--- VENDORS (AS AFFILIATES) --->
<cfelseif isDefined('form.ExportAffiliatesFile') >
	
	<cfoutput>
	
	<cfquery name="getAffiliates" datasource="#application.dsn#">
		SELECT 	*
		FROM	Affiliates
		ORDER BY AffiliateName, LastName, FirstName, QB
	</cfquery>
							
	<!--- ONLY CREATE FILE IF RECORDS ARE RETURNED --->
	<cfif getAffiliates.RecordCount NEQ 0 >
	
		<!--- SET FILENAME FOR USE --->
		<cfscript>
			CF2QBfile = 'CF2QB Sales Reps #DateFormat(Now(),'yyyymmdd')# #TimeFormat(Now(),'HHmmss')#.IIF' ;
			CF2QBpath = '#getDirectoryFromPath(getCurrentTemplatePath())#docs\' ;
		</cfscript>
		
		<!--- CREATE BLANK FILE --->
		<cffile action="write" file="#CF2QBpath##CF2QBfile#" output="" addnewline="no">
		
		<!--- CREATE FILE HEADERS --->
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="!CUSTNAMEDICT	INDEX	LABEL	CUSTOMER	VENDOR	EMPLOYEE">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="!ENDCUSTNAMEDICT">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="CUSTNAMEDICT	0	AccPacID	Y	Y	N">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="CUSTNAMEDICT	1	CartFusionID	Y	Y	N">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="CUSTNAMEDICT	2	MemberType	Y	Y	N">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="CUSTNAMEDICT	3	SubOf	Y	Y	N">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="CUSTNAMEDICT	4		N	N	N">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="CUSTNAMEDICT	5		N	N	N">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="CUSTNAMEDICT	6		N	N	N">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="CUSTNAMEDICT	7		N	N	N">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="CUSTNAMEDICT	8		N	N	N">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="CUSTNAMEDICT	9		N	N	N">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="CUSTNAMEDICT	10		N	N	N">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="CUSTNAMEDICT	11		N	N	N">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="CUSTNAMEDICT	12		N	N	N">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="CUSTNAMEDICT	13		N	N	N">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="CUSTNAMEDICT	14		N	N	N">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="ENDCUSTNAMEDICT">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="!VEND	NAME	REFNUM	TIMESTAMP	PRINTAS	ADDR1	ADDR2	ADDR3	ADDR4	ADDR5	VTYPE	CONT1	CONT2	PHONE1	PHONE2	FAXNUM	EMAIL	NOTE	TAXID	LIMIT	TERMS	NOTEPAD	SALUTATION	COMPANYNAME	FIRSTNAME	MIDINIT	LASTNAME	CUSTFLD1	CUSTFLD2	CUSTFLD3	CUSTFLD4	CUSTFLD5	CUSTFLD6	CUSTFLD7	CUSTFLD8	CUSTFLD9	CUSTFLD10	CUSTFLD11	CUSTFLD12	CUSTFLD13	CUSTFLD14	CUSTFLD15	1099	HIDDEN	DELCOUNT">

		<!--- LOOP OVER EACH LINE AND INSERT DATA INTO FILE --->
		<cfloop query="getAffiliates">
			<cfif Deleted EQ 1 ><cfset IsHidden = 'Y'><cfelse><cfset IsHidden = 'N'></cfif>
			
			<!--- QB_PREFVEND instead of MainCatName ? --->
			<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="VEND	#AffiliateName#	#QB#	#Blank#	#AffiliateName#	#Address1#	#Address2#	#City#	#State#	#Zip#	#Blank#	#FirstName# #LastName#	#WebSiteURL#	#Phone#	#AltPhone#	#Fax#	#Email#	#Comments#	#TaxID#	#QB_LIMIT#	#QB_TERMS#	#Blank#	#Blank#	#CompanyName#	#FirstName#	#Blank#	#LastName#	#AffiliateCode#	#AFID#	#MemberType#	#SubAffiliateOf#	#Blank#	#Blank#	#Blank#	#Blank#	#Blank#	#Blank#	#Blank#	#Blank#	#Blank#	#Blank# #Blank#	 	#QB_1099#	#IsHidden#	0">
		</cfloop>
	
		<cfset AdminMsg = 'QuickBooks IIF File Created: "#CF2QBfile#"' >
		<cfset ShowResults = 6 >
	
	<cfelse>
		<cfset AdminMsg = 'No Vendors/Sales Reps Available To Export' >	
	</cfif>
		
	</cfoutput>



<!--- ORDERS --->
<cfelseif isDefined('form.ExportOrdersFile') >
			
	<cfoutput>
	
	<cfquery name="getOrders" datasource="#application.dsn#">
		SELECT	OrderID, DateEntered, CustomerID, ShippingTotal, TaxTotal, DiscountTotal, CreditApplied
		FROM	Orders
		ORDER BY OrderID
	</cfquery>

	<!--- ONLY CREATE FILE IF RECORDS ARE RETURNED --->
	<cfif getOrders.RecordCount NEQ 0 >
	
		<!--- SET FILENAME FOR USE --->
		<cfscript>
			CF2QBfile = 'CF2QB Orders #DateFormat(Now(),'yyyymmdd')# #TimeFormat(Now(),'HHmmss')#.IIF' ;
			CF2QBpath = '#getDirectoryFromPath(getCurrentTemplatePath())#docs\' ;
		</cfscript>
		
		<!--- CREATE BLANK FILE --->
		<cffile action="write" file="#CF2QBpath##CF2QBfile#" output="" addnewline="no">
		
		<!--- CREATE FILE HEADERS --->
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="!TRNS	TRNSID	TRNSTYPE	DATE	ACCNT	NAME	CLASS	AMOUNT	DOCNUM	MEMO	CLEAR	TOPRINT	NAMEISTAXABLE	ADDR1	ADDR2	ADDR3	ADDR4	DUEDATE	TERMS	OTHER1">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="!SPL	SPLID	TRNSTYPE	DATE	ACCNT	NAME	CLASS	AMOUNT	DOCNUM	MEMO	CLEAR	QNTY	PRICE	INVITEM	PAYMETH	TAXABLE	VALADJ	SERVICEDATE	OTHER2	EXTRA">
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="!ENDTRNS">
																					
		<!--- LOOP OVER EACH LINE AND INSERT DATA INTO FILE --->
		<cfloop query="getOrders">
	
			<cfquery name="getCustomer" datasource="#application.dsn#">
				SELECT	CustomerName, QB_TAXABLE, Address1, Address2, City, State, Zip, PaymentTerms
				FROM	Customers
				WHERE	CustomerID = <cfqueryparam value="#CustomerID#" cfsqltype="CF_SQL_VARCHAR">
			</cfquery>
			
			<cfquery name="getOrderItems" datasource="#application.dsn#">
				SELECT	*
				FROM	OrderItems
				WHERE	OrderID = <cfqueryparam value="#OrderID#" cfsqltype="CF_SQL_INTEGER">
			</cfquery>
			
			<cfscript>
				if ( Deleted EQ 1 ) IsHidden = 'Y' ;
				else IsHidden = 'N' ;
				DateOrdered = DateFormat(DateEntered,'mm/dd/yyyy') ;
				DateDue = DateAdd(d,90,DateOrdered) ;
			</cfscript>
			
			<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="TRNS	#Blank#	INVOICE	#DateOrdered#	Accounts Receivable	#getCustomer.CustomerName#	#Blank#	#AMOUNT#	#OrderID#	#application.StoreNameShort# Order #OrderID#	N	Y	#getCustomer.QB_TAXABLE#	#getCustomer.Address1# #getCustomer.Address2#	#getCustomer.City#	#getCustomer.State#	#getCustomer.Zip#	#DateDue#	#getCustomer.PaymentTerms#	#getCustomer.CustomerID#">
			<cfloop query="getOrderItems">
				<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="SPL	#Blank#	INVOICE	#DateOrdered#	#QB_ACCNT#	#Blank#	#Blank#	-#RunningTotal#	#Blank#	#ItemName#	N	#Qty#	#Price#	#QB_SUBITEM#:#SKU#	#getOrders.FormOfPayment#	#IsTaxable#	N	#DateDue#	#Blank#	#Blank#">
			</cfloop>
			<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="SPL	#Blank#	INVOICE	#DateOrdered#	Sales Tax Payable	Sales Tax	#Blank#	-#TaxTotal#	#OrderID#	#Blank#	N	#Blank#	10.00%	Sales Tax	N	N	#Blank#	#Blank#	AUTOSTAX">
			<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="ENDTRNS">
		</cfloop>
	
		<cfset AdminMsg = 'QuickBooks IIF File Created: "#CF2QBfile#"' >
		<cfset ShowResults = 4 >
	
	<cfelse>
		<cfset AdminMsg = 'No Orders Available To Export' >	
	</cfif>
		
	</cfoutput>
	
</cfif><!--- isDefined('form.ImportItemsFile') --->








<cfscript>
	PageTitle = 'CartFusion-2-QuickBooks Data Exporter';
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

<script language="javascript">
<!--
function doConfirm(btnWaiter) {
	if (confirm("CartFusion will now generate a QuickBooks IIF file. This may take a few minutes.")) { 
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
		<td width="33%" class="cfAdminHeader1" bordercolor="EFEFEF">ITEM EXPORTER</td>
		<td width="1" rowspan="2" bordercolor="FFFFFF"><img src="images/spacer.gif" width="1" height="1" /></td>
		<td width="33%" class="cfAdminHeader1" bordercolor="EFEFEF">ITEM STOCK QUANTITY EXPORTER</td>
		<td width="1" rowspan="2" bordercolor="FFFFFF"><img src="images/spacer.gif" width="1" height="1" /></td>
		<td width="33%" class="cfAdminHeader1" bordercolor="EFEFEF">ITEM PRICE<font class="cfAdminError">1</font> EXPORTER</td>
	</tr>
	<tr>
		<!--- PRODUCT EXPORTER --->
		<cfform name="frmData1" action="QB-ExportTo.cfm" method="post">
		<td width="33%" align="center" bgcolor="E7F2F8" bordercolor="EFEFEF">
			Export ALL CartFusion Item Data to a QuickBooks IIF File<br><br>
			<table width="100%">
				<tr>
					<td width="100%" align="center" colspan="2">
						<input type="submit" name="ExportItemsFile" value="EXPORT FILE" style="width:200px;" class="cfAdminButton" onclick="return doConfirm(this);">
					</td>
				</tr>
			</table>
		</td>
		</cfform>
		<!--- STOCK QUANTITY UPDATER --->
		<cfform name="frmData2" action="QB-ExportTo.cfm" method="post">
		<td width="33%" align="center" bgcolor="E7F2F8" bordercolor="EFEFEF">
			<br><br>
		</td>
		</cfform>
		<!--- RETAIL PRICE UPDATER --->
		<cfform name="frmData3" action="QB-ExportTo.cfm" method="post">
		<td width="33%" align="center" bgcolor="E7F2F8" bordercolor="EFEFEF">
			<br><br>
		</td>
		</cfform>
	</tr>
</table>

<br/><br/>

<table width="100%" border="1" bordercolor="FFFFFF" cellpadding="7" cellspacing="0">
	<tr>
		<td width="33%" class="cfAdminHeader1" bordercolor="EFEFEF">CUSTOMER EXPORTER</td>
		<td width="1" rowspan="2" bordercolor="FFFFFF"><img src="images/spacer.gif" width="1" height="1" /></td>
		<td width="33%" class="cfAdminHeader1" bordercolor="EFEFEF">VENDOR/DISTRIBUTOR EXPORTER</td>
		<td width="1" rowspan="2" bordercolor="FFFFFF"><img src="images/spacer.gif" width="1" height="1" /></td>
		<td width="33%" class="cfAdminHeader1" bordercolor="EFEFEF">VENDOR/SALES REP EXPORTER</td>
	</tr>
	<tr>
		<!--- CUSTOMER EXPORTER --->
		<cfform name="frmData4" action="QB-ExportTo.cfm" method="post">
		<td width="33%" align="center" bgcolor="F1FCE4" bordercolor="EFEFEF">
			Export ALL CartFusion Customer Data to a QuickBooks IIF File<br><br>
			<table width="100%">
				<tr>
					<td width="100%" align="center" colspan="2">
						<input type="submit" name="ExportCustomersFile" value="EXPORT FILE" style="width:200px;" class="cfAdminButton" onclick="return doConfirm(this);">
					</td>
				</tr>
			</table>
		</td>
		</cfform>
		<!--- DISTRIBUTOR EXPORTER --->
		<cfform name="frmData5" action="QB-ExportTo.cfm" method="post">
		<td width="33%" align="center" bgcolor="FFF7F0" bordercolor="EFEFEF">
			Export ALL CartFusion Vendor/Distributor Data to a QuickBooks IIF File<br><br>
			<table width="100%">
				<tr>
					<td width="100%" align="center" colspan="2">
						<input type="submit" name="ExportDistributorsFile" value="EXPORT FILE" style="width:200px;" class="cfAdminButton" onclick="return doConfirm(this);">
					</td>
				</tr>
			</table>
		</td>
		</cfform>
		<!--- AFFILIATES EXPORTER --->
		<cfform name="frmData6" action="QB-ExportTo.cfm" method="post">
		<td width="33%" align="center" bgcolor="FFEDE1" bordercolor="EFEFEF">
			Export ALL CartFusion Vendor/Sales Rep Data to a QuickBooks IIF File<br><br>
			<table width="100%">
				<tr>
					<td width="100%" align="center" colspan="2">
						<input type="submit" name="ExportAffiliatesFile" value="EXPORT FILE" style="width:200px;" class="cfAdminButton" onclick="return doConfirm(this);">
					</td>
				</tr>
			</table>
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
				ITEM EXPORT RESULTS
			</td>
		</tr>
		<tr>
			<td width="100%" colspan="2" align="center" class="cfAdminDefault">
				<table width="100%" border="0" align="center">
					<tr><td width="100%" align="center"><b>Your CartFusion-2-QuickBooks IIF file has been created and is located here:</b></td></tr>
					<tr><td width="100%" align="center"><a href="../QB/docs/#CF2QBfile#"></a><font color="006600"><u>#getDirectoryFromPath(getCurrentTemplatePath())#docs\#CF2QBfile#</u></font></td></tr>
					<tr><td width="100%" align="center"><br/>Right click the link and click "Save Target As...", then save the file to your computer as an .IIF file.</td></tr>
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
				STOCK QUANTITY EXPORTER RESULTS
			</td>
		</tr>
		<tr>
			<td width="100%" colspan="2" align="center" class="cfAdminDefault">
				<table width="100%" border="0" align="center">
					<tr><td width="100%" align="center"><b>Your CartFusion-2-QuickBooks IIF file has been created and is located here:</b></td></tr>
					<tr><td width="100%" align="center"><a href="../QB/docs/#CF2QBfile#"></a><font color="006600"><u>#getDirectoryFromPath(getCurrentTemplatePath())#docs\#CF2QBfile#</u></font></td></tr>
					<tr><td width="100%" align="center"><br/>Right click the link and click "Save Target As...", then save the file to your computer as an .IIF file.</td></tr>
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
				PRICE1 EXPORTER RESULTS
			</td>
		</tr>
		<tr>
			<td width="100%" colspan="2" align="center" class="cfAdminDefault">
				<table width="100%" border="0" align="center">
					<tr><td width="100%" align="center"><b>Your CartFusion-2-QuickBooks IIF file has been created and is located here:</b></td></tr>
					<tr><td width="100%" align="center"><a href="../QB/docs/#CF2QBfile#"></a><font color="006600"><u>#getDirectoryFromPath(getCurrentTemplatePath())#docs\#CF2QBfile#</u></font></td></tr>
					<tr><td width="100%" align="center"><br/>Right click the link and click "Save Target As...", then save the file to your computer as an .IIF file.</td></tr>
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
			<td width="100%" colspan="2" align="center" class="cfAdminTitle" bgcolor="EFFFDF">
				CUSTOMER EXPORT RESULTS
			</td>
		</tr>
		<tr>
			<td width="100%" colspan="2" align="center" class="cfAdminDefault">
				<table width="100%" border="0" align="center">
					<tr><td width="100%" align="center"><b>Your CartFusion-2-QuickBooks IIF file has been created and is located here:</b></td></tr>
					<tr><td width="100%" align="center"><a href="../QB/docs/#CF2QBfile#"></a><font color="006600"><u>#getDirectoryFromPath(getCurrentTemplatePath())#docs\#CF2QBfile#</u></font></td></tr>
					<tr><td width="100%" align="center"><br/>Right click the link and click "Save Target As...", then save the file to your computer as an .IIF file.</td></tr>
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
				DISTRIBUTOR EXPORTER RESULTS
			</td>
		</tr>
		<tr>
			<td width="100%" colspan="2" align="center" class="cfAdminDefault">
				<table width="100%" border="0" align="center">
					<tr><td width="100%" align="center"><b>Your CartFusion-2-QuickBooks IIF file has been created and is located here:</b></td></tr>
					<tr><td width="100%" align="center"><a href="../QB/docs/#CF2QBfile#"></a><font color="006600"><u>#getDirectoryFromPath(getCurrentTemplatePath())#docs\#CF2QBfile#</u></font></td></tr>
					<tr><td width="100%" align="center"><br/>Right click the link and click "Save Target As...", then save the file to your computer as an .IIF file.</td></tr>
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
				SALES REP EXPORTER RESULTS
			</td>
		</tr>
		<tr>
			<td width="100%" colspan="2" align="center" class="cfAdminDefault">
				<table width="100%" border="0" align="center">
					<tr><td width="100%" align="center"><b>Your CartFusion-2-QuickBooks IIF file has been created and is located here:</b></td></tr>
					<tr><td width="100%" align="center"><a href="../QB/docs/#CF2QBfile#"></a><font color="006600"><u>#getDirectoryFromPath(getCurrentTemplatePath())#docs\#CF2QBfile#</u></font></td></tr>
					<tr><td width="100%" align="center"><br/>Right click the link and click "Save Target As...", then save the file to your computer as an .IIF file.</td></tr>
				</table>
			</td>
		</tr>
	</table>
	</cfoutput>
</cfif>


<cfinclude template="../LayoutAdminFooter.cfm">