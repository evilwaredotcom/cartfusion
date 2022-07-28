<cfcomponent displayname="Common Functions Module" hint="This component handles common function calls from a CartFusion site.">
	
    <cfscript>
		variables.dsn = "";
	</cfscript>
    
    <cffunction name="init" returntype="Common" output="false">
		<cfargument name="dsn" required="true">
	
		<cfscript>
			variables.dsn = arguments.dsn;
		</cfscript>
		
		<cfreturn this />
	</cffunction>
    
    
	<!--- 
		GET ALL PRODUCTS
		Used in: ProductList.cfm
	--->
	<cffunction name="getAllProducts" displayname="Get All Products" hint="Function to retrieve all products information." access="public" returntype="query">
		<cfargument name="UserID" displayname="UserID" hint="The Price and Hide Columns of the Products to get, depending on User" type="numeric" required="yes">
		<cfargument name="SiteID" displayname="SiteID" hint="The CartFusion Site ID of the Products to get" type="numeric" required="yes">
		<cfargument name="CatDisplay" displayname="CatDisplay" hint="Category chosen by visitor" required="no">
		<cfargument name="SecDisplay" displayname="SecDisplay" hint="Section chosen by visitor" required="no">
		<cfargument name="CatFilter" displayname="CatFilter" hint="Category to filter Section by" required="no">
		<cfargument name="SecFilter" displayname="SecFilter" hint="Section to filter Category by" required="no">
		<cfargument name="SMC" displayname="Show Me These Categories" hint="Shows only the selected categories by visitor" required="no">
		<cfargument name="SMS" displayname="Show Me These Sections" hint="Shows only the selected sections by visitor" required="no">
		<cfargument name="SortOption" displayname="Sort By This Cat/Sec" hint="Sorts query results by selected category/section" type="string" required="no">
		<cfargument name="SortAscending" displayname="Sort Ascending" hint="Sorts query results ascending or descending" type="numeric" required="no">
		
		<CFQUERY NAME="getProducts" DATASOURCE="#application.dsn#">
			SELECT 	ItemID, SKU, ItemName, ItemDescription, Category, SectionID, Attribute1, Attribute2, Attribute3, 
					Price#arguments.UserID#, ItemStatus, ImageSmall, ImageDir, CompareType, SellByStock, StockQuantity
			FROM 	Products
			WHERE	(Hide#arguments.UserID# = 0 OR Hide#arguments.UserID# IS NULL)
			AND		(Deleted = 0 OR Deleted IS NULL)
			AND		SiteID = #arguments.SiteID#
			
			<!--- DISPLAY --->
			<cfif isDefined('arguments.CatDisplay') AND arguments.CatDisplay NEQ ''>
				AND 	(Category = #arguments.CatDisplay# 
				OR 		OtherCategories LIKE '%,#arguments.CatDisplay#,%')
			<cfelseif isDefined('arguments.SecDisplay') AND arguments.SecDisplay NEQ ''>
				AND 	(SectionID = #arguments.SecDisplay#
				OR 		OtherSections LIKE '%,#arguments.SecDisplay#,%')
			</cfif>
			
			<!--- FILTER --->
			<cfif isDefined('arguments.CatFilter') AND arguments.CatFilter NEQ ''>
				AND 	(Category = #arguments.CatFilter# 
				OR 		OtherCategories LIKE '%,#arguments.CatFilter#,%')
			<cfelseif isDefined('arguments.SecFilter') AND arguments.SecFilter NEQ ''>
				AND 	(SectionID = #arguments.SecFilter#
				OR 		OtherSections LIKE '%,#arguments.SecFilter#,%')
			</cfif>
				
			<!--- SHOW ME --->
			<cfif isDefined('arguments.SMC') AND arguments.SMC NEQ ''>
				AND ((
					<cfloop index="i" list="#arguments.SMC#" delimiters="," >
						Category = #i# <cfif i NEQ ListLast(arguments.SMC)> OR </cfif>
					</cfloop> )
				OR (
					<cfloop index="i" list="#arguments.SMC#" delimiters="," >
						OtherCategories LIKE '%,#i#,%' <cfif i NEQ ListLast(arguments.SMC)> OR </cfif>
					</cfloop> ))
			<cfelseif isDefined('arguments.SMS') AND arguments.SMS NEQ ''>
				AND ((
					<cfloop index="i" list="#arguments.SMS#" delimiters="," >
						SectionID = #i# <cfif i NEQ ListLast(arguments.SMS)> OR </cfif>
					</cfloop> )
				OR (
					<cfloop index="i" list="#arguments.SMS#" delimiters="," >
						OtherSections LIKE '%,#i#,%' <cfif i NEQ ListLast(arguments.SMS)> OR </cfif>
					</cfloop> ))
			</cfif>
			
			ORDER BY 
			<cfif isDefined('arguments.SortOption')> DisplayOrder, #arguments.SortOption# <cfelse> Category, DisplayOrder, SKU </cfif>
			<cfif isDefined('arguments.SortAscending') AND arguments.SortAscending EQ 1 > ASC <cfelse> DESC </cfif>
		</CFQUERY>
		
		<cfreturn getProducts>
	</cffunction>
	
	
	<!--- 
		GET PRODUCT DETAIL
		Used in: ProductDetail.cfm
	--->
	<cffunction name="getProductDetail" displayname="Get Product Detail" hint="Function to retrieve specific product information." access="public" returntype="query">
		<cfargument name="ItemID" displayname="Product ID" hint="The ID of the Product to get" type="numeric" required="yes">
		
		<cfquery name="getProduct" datasource="#application.dsn#">
			SELECT	*
			FROM	Products
			WHERE	ItemID = #arguments.ItemID#
			AND		(Deleted = 0 OR Deleted IS NULL)
		</cfquery>
		
		<cfreturn getProduct>
	</cffunction>
	
	
	<!--- 
		GET ALL CATEGORIES
		Used in: CategoryList.cfm
	--->
	<cffunction name="getCategories" displayname="Get All Categories" hint="Function to retrieve all category information." access="public" returntype="query">
		<cfargument name="UserID" displayname="UserID" hint="The Price and Hide Columns of the Categories to get, depending on User" type="numeric" required="yes">
		<cfargument name="SiteID" displayname="SiteID" hint="The CartFusion Site ID of the Categories to get" type="numeric" required="yes">
		<cfargument name="PCID" displayname="Parent Category ID" hint="The Parent Category ID of the Category to get" type="numeric" required="no">
		<cfargument name="CatID" displayname="Category ID" hint="The Category ID of the Category to retrieve sub-categories of" type="string" required="no">
		<cfargument name="OnlyMainCategories" displayname="Get Main Categories" hint="Only retrieve categories with no sub-categories, i.e., Main Categories" type="string" required="no">
		
		<CFQUERY NAME="getCategories" DATASOURCE="#application.dsn#">
			SELECT 		* 
			FROM 		Categories
			WHERE		Hide#arguments.UserID# != 1
			AND			SiteID = #arguments.SiteID#
			<cfif isDefined('arguments.CatID') AND arguments.CatID NEQ ''>
			AND			SubCategoryOf = #arguments.CatID#
			</cfif>
			<cfif isDefined('arguments.OnlyMainCategories') AND arguments.OnlyMainCategories NEQ ''>
			AND			(SubCategoryOf = ''
			OR			 SubCategoryOf = 0
			OR			 SubCategoryOf IS NULL)
			</cfif>
			ORDER BY 	DisplayOrder, CatName
		</CFQUERY>

		<cfreturn getCategories>
	</cffunction>
	

	<!--- 
		GET CATEGORY DETAIL
		Used in: ProductList.cfm
	--->
	<cffunction name="getCategoryDetail" displayname="Get Category Detail" hint="Function to retrieve specific category information." access="public" returntype="query">
		<cfargument name="CatID" displayname="Category ID" hint="The ID of the Category to get" type="numeric" required="yes">
	
		<cfquery name="getCategory" datasource="#application.dsn#">
			SELECT	*
			FROM	Categories
			WHERE	CatID = #arguments.CatID#
		</cfquery>
		
		<cfreturn getCategory>
	</cffunction>
	
	
	<!--- 
		GET ALL SECTIONS
		Used in: SectionList.cfm
	--->
	<cffunction name="getSections" displayname="Get All Sections" hint="Function to retrieve all section information." access="public" returntype="query">
		<cfargument name="UserID" displayname="UserID" hint="The Price and Hide Columns of the Sections to get, depending on User" type="numeric" required="yes">
		<cfargument name="SiteID" displayname="SiteID" hint="The CartFusion Site ID of the Sections to get" type="numeric" required="yes">
		<cfargument name="PSID" displayname="Parent Section ID" hint="The Parent Section ID of the Section to get" type="numeric" required="no">
		<cfargument name="SectionID" displayname="Section ID" hint="The Section ID of the Section to retrieve sub-Sections of" type="string" required="no">
		<cfargument name="OnlyMainSections" displayname="Get Main Sections" hint="Only retrieve Sections with no sub-Sections, i.e., Main Sections" type="string" required="no">
		
		<CFQUERY NAME="getSections" DATASOURCE="#application.dsn#">
			SELECT 		* 
			FROM 		Sections
			WHERE		Hide#arguments.UserID# != 1
			AND			SiteID = #arguments.SiteID#
			<cfif isDefined('arguments.SectionID') AND arguments.SectionID NEQ ''>
			AND			SubSectionOf = #arguments.SectionID#
			</cfif>
			<cfif isDefined('arguments.OnlyMainSections') AND arguments.OnlyMainSections NEQ ''>
			AND			(SubSectionOf = ''
			OR			 SubSectionOf = 0
			OR			 SubSectionOf IS NULL)
			</cfif>
			ORDER BY 	DisplayOrder, SecName
		</CFQUERY>

		<cfreturn getSections>
	</cffunction>
	
	
	<!--- 
		GET SECTION DETAIL
		Used in: ProductList.cfm
	--->
	<cffunction name="getSectionDetail" displayname="Get Section Detail" hint="Function to retrieve specific Section information." access="public" returntype="query">
		<cfargument name="SectionID" displayname="Section ID" hint="The ID of the Section to get" type="numeric" required="yes">
	
		<cfquery name="getSection" datasource="#application.dsn#">
			SELECT	*
			FROM	Sections
			WHERE	SectionID = #arguments.SectionID#
		</cfquery>
		
		<cfreturn getSection>
	</cffunction>
	
	
	<!--- 
		GET CATEGORIES SELECTED
		Used in: ProductList.cfm
	--->
	<cffunction name="getTheseCategories" displayname="Get These Categories" hint="Function to retrieve selected list of Categories." access="public" returntype="query">
		<cfargument name="SMC" displayname="Show Me These Categories" hint="The IDs of the Categories to get" type="string" required="yes">
	
		<cfquery name="getCategory" datasource="#application.dsn#">
			SELECT	*
			FROM	Categories
			WHERE	
			<cfloop index="i" list="#arguments.SMC#" delimiters="," >
				CatID = #i# <cfif i NEQ ListLast(arguments.SMC)> OR </cfif>
			</cfloop>
		</cfquery>
		
		<cfreturn getCategory>		
	</cffunction>
	
	
	<!--- 
		GET SECTIONS SELECTED
		Used in: ProductList.cfm
	--->
	<cffunction name="getTheseSections" displayname="Get These Sections" hint="Function to retrieve selected list of Sections." access="public" returntype="query">
		<cfargument name="SMS" displayname="Show Me These Sections" hint="The IDs of the Sections to get" type="string" required="yes">
	
		<cfquery name="getSection" datasource="#application.dsn#">
			SELECT	*
			FROM	Sections
			WHERE	
			<cfloop index="i" list="#arguments.SMS#" delimiters="," >
				SectionID = #i# <cfif i NEQ ListLast(arguments.SMS)> OR </cfif>
			</cfloop>
		</cfquery>
		
		<cfreturn getSection>		
	</cffunction>
	
	
	<!--- 
		GET RELATED ITEMS
		Used in: Includes/ProductRelated.cfm
	--->
	<cffunction name="getRelatedItems" displayname="Get Product Related Items" hint="Function to retrieve all related items of a product." access="public" returntype="query">
		<cfargument name="UserID" displayname="UserID" hint="The Price and Hide Columns of the Products to get, depending on User" type="numeric" required="yes">
		<cfargument name="ItemID" displayname="Product ID" hint="The ID of the Product the related items refer to" type="numeric" required="yes">
		
		<cfquery name="relatedList" datasource="#application.dsn#">
			SELECT 	p.ItemID, p.SKU, p.ItemName, p.ShortDescription, p.Category, p.Attribute1, p.Attribute2, p.Attribute3, 
					p.Price#arguments.UserID#, p.ItemStatus, p.ImageSmall, p.ImageDir, p.SellByStock, p.StockQuantity,
					ri.RelatedItemID 
			FROM 	Products p, RelatedItems ri
			WHERE 	(ri.ItemID = #arguments.ItemID#
			AND		p.ItemID = ri.RelatedItemID)
			OR		(ri.ItemID = p.ItemID
			AND		ri.RelatedItemID = #arguments.ItemID#)
			AND		p.Hide#arguments.UserID# != 1
			ORDER BY p.ItemName
		</cfquery>
		
		<cfreturn relatedList>		
	</cffunction>
	
	
	
<!--- CART & WISHLIST FUNCTIONS --->

	<!--- 
		GET CART ITEM(S)
		Used in: WishEdit.cfm, CartUpdate.cfm, WishToCart.cfm, WishUpdate.cfm
	--->
	<cffunction name="getCart" displayname="Get Items in Customer Cart" hint="Function to retrieve all items in customer's Cart." access="public" returntype="query">
		<cfargument name="SessionID" displayname="SessionID" hint="SessionID related to Cart" type="string" required="yes">
		<cfargument name="SiteID" displayname="SiteID" hint="The CartFusion Site ID of the Products to get" type="numeric" required="yes">
		<cfargument name="ItemID" displayname="Product ID" hint="The ID of the Product in the Cart" type="numeric" required="no">
		<cfargument name="OptionName1" displayname="Option Name 1" hint="Product option value 1 in Cart" type="string" required="no">
		<cfargument name="OptionName2" displayname="Option Name 2" hint="Product option value 2 in Cart" type="string" required="no">
		<cfargument name="OptionName3" displayname="Option Name 3" hint="Product option value 3 in Cart" type="string" required="no">

		<CFQUERY NAME="getCart" DATASOURCE="#application.dsn#">
			SELECT 	c.CartItemID, c.CustomerID, c.SessionID, c.ItemID, c.Qty, c.OptionName1, c.OptionName2, c.OptionName3,
					c.DateEntered, c.AffiliateID, c.BackOrdered, c.SiteID,
					p.SKU, p.ItemName, p.Price#session.CustomerArray[28]#, p.Weight
			FROM 	Cart c, Products p
			WHERE 	c.ItemID = p.ItemID
			AND 	c.SessionID = '#arguments.SessionID#'
			AND		c.SiteID = #arguments.SiteID#
			<cfif isDefined("arguments.ItemID") AND arguments.ItemID NEQ ''>
			AND		c.ItemID = #arguments.ItemID#
			</cfif>
			<cfif isDefined("arguments.OptionName1") AND arguments.OptionName1 NEQ ''>
			AND 	c.OptionName1 = '#arguments.OptionName1#'
			</cfif>
			<cfif isDefined("arguments.OptionName2") AND arguments.OptionName2 NEQ ''>
			AND 	c.OptionName2 = '#arguments.OptionName2#'
			</cfif>
			<cfif isDefined("arguments.OptionName3") AND arguments.OptionName3 NEQ ''>
			AND 	c.OptionName3 = '#arguments.OptionName3#'
			</cfif>
			ORDER BY p.SKU
		</cfquery>
		
		<cfreturn getCart>		
	</cffunction>
	
	
	<!--- 
		INSERT INTO CART
		Used in: CartUpdate.cfm, WishUpdate.cfm
	--->
	<cffunction name="insertCart" displayname="Update Items in Cart" hint="Function to update items in customer's Cart." access="public">
		<cfargument name="SessionID" displayname="SessionID" hint="SessionID related to Cart" type="string" required="yes">
		<cfargument name="CustomerID" displayname="Customer ID" hint="Customer ID related to Cart" type="string" required="no">
		<cfargument name="SiteID" displayname="SiteID" hint="The CartFusion Site ID of the Products to update" type="numeric" required="yes">
		<cfargument name="Quantity" displayname="Quantity" hint="The Quantity of Products to update" type="numeric" required="yes">
		<cfargument name="ItemID" displayname="ItemID" hint="The Item ID of the item in the Cart to update" type="numeric" required="no">
		<cfargument name="BackOrdered" displayname="Item is Backordered" hint="Cart keeps track if item is backordered" type="numeric" required="no">
		<cfargument name="OptionName1" displayname="Option Name 1" hint="Product option value 1 in Cart" type="string" required="no">
		<cfargument name="OptionName2" displayname="Option Name 2" hint="Product option value 2 in Cart" type="string" required="no">
		<cfargument name="OptionName3" displayname="Option Name 3" hint="Product option value 3 in Cart" type="string" required="no">
		
		<cfquery name="insertCart" DATASOURCE="#application.dsn#">
			INSERT INTO Cart 
			(	
				SessionID, 
				Qty, 
				ItemID,
				SiteID
				<cfif isDefined("arguments.CustomerID") AND arguments.CustomerID NEQ ''>, CustomerID</cfif>
				<cfif isDefined("arguments.OptionName1") AND arguments.OptionName1 NEQ ''>, OptionName1</cfif>
				<cfif isDefined("arguments.OptionName2") AND arguments.OptionName2 NEQ ''>, OptionName2</cfif>
				<cfif isDefined("arguments.OptionName3") AND arguments.OptionName3 NEQ ''>, OptionName3</cfif>
				<cfif isDefined("arguments.Backordered") AND arguments.Backordered NEQ ''>, BackOrdered</cfif>
			) 
			VALUES
			(
				'#arguments.SessionID#', 
				#arguments.Quantity#, 
				#arguments.ItemID#,
				#arguments.SiteID#
				<cfif isDefined("arguments.CustomerID") AND arguments.CustomerID NEQ ''>, '#arguments.CustomerID#'</cfif>
				<cfif isDefined("arguments.OptionName1") AND arguments.OptionName1 NEQ ''>, '#arguments.OptionName1#'</cfif>
				<cfif isDefined("arguments.OptionName2") AND arguments.OptionName2 NEQ ''>, '#arguments.OptionName2#'</cfif>
				<cfif isDefined("arguments.OptionName3") AND arguments.OptionName3 NEQ ''>, '#arguments.OptionName3#'</cfif>
				<cfif isDefined("arguments.Backordered") AND arguments.Backordered NEQ ''>,  #arguments.Backordered# </cfif>
			)
		</cfquery>
	
	</cffunction>
	
	
	<!--- 
		UPDATE CUSTOMER CART
		Used in: CartUpdate.cfm
	--->
	<cffunction name="updateCart" displayname="Update Items in Cart" hint="Function to update items in customer's Cart." access="public">
		<cfargument name="SiteID" displayname="SiteID" hint="The CartFusion Site ID of the Products to update" type="numeric" required="yes">
		<cfargument name="Quantity" displayname="Quantity" hint="The Quantity of Products to update" type="numeric" required="yes">
		<cfargument name="ItemID" displayname="ItemID" hint="The Item ID of the item in the Cart to update" type="numeric" required="no">
		<cfargument name="CartItemID" displayname="Cart Item ID" hint="Unique Cart Item ID in Cart" type="numeric" required="no">
		<cfargument name="CustomerID" displayname="Customer ID" hint="Customer ID related to Cart" type="string" required="no">
		<cfargument name="OptionName1" displayname="Option Name 1" hint="Product option value 1 in Cart" type="string" required="no">
		<cfargument name="OptionName2" displayname="Option Name 2" hint="Product option value 2 in Cart" type="string" required="no">
		<cfargument name="OptionName3" displayname="Option Name 3" hint="Product option value 3 in Cart" type="string" required="no">
		
		<cfquery name="updateCart" DATASOURCE="#application.dsn#">
			UPDATE 	Cart
			SET		Qty = #arguments.Quantity#
			<cfif isDefined("arguments.CustomerID") AND arguments.CustomerID NEQ ''>
					, CustomerID = '#arguments.CustomerID#'
			</cfif>
			<cfif isDefined("arguments.ItemID") AND arguments.ItemID NEQ ''>		
					, ItemID = #arguments.ItemID#
			</cfif>
			WHERE 	SessionID = '#arguments.SessionID#'
			<cfif isDefined("arguments.CustomerID") AND arguments.CustomerID NEQ ''>
			AND 	CustomerID = '#arguments.CustomerID#'
			</cfif>
			<cfif isDefined("arguments.ItemID") AND arguments.ItemID NEQ ''>
			AND 	ItemID = #arguments.ItemID#
			</cfif>
			<cfif isDefined("arguments.CartItemID") AND arguments.CartItemID NEQ ''>
			AND 	CartItemID = #arguments.CartItemID#
			</cfif>			
			<cfif isDefined("arguments.OptionName1") AND arguments.OptionName1 NEQ ''>
			AND 	OptionName1 = '#arguments.OptionName1#'
			</cfif>
			<cfif isDefined("arguments.OptionName2") AND arguments.OptionName2 NEQ ''>
			AND 	OptionName2 = '#arguments.OptionName2#'
			</cfif>
			<cfif isDefined("arguments.OptionName3") AND arguments.OptionName3 NEQ ''>
			AND 	OptionName3 = '#arguments.OptionName3#'
			</cfif>				
		</cfquery>	
	
	</cffunction>
	
	
	<!--- 
		DELETE CART ITEM
		Used in: CartUpdate.cfm
	--->
	<cffunction name="deleteCart" displayname="Delete Items in Customer Cart" hint="Function to delete all items in customer's cart." access="public">
		<cfargument name="SessionID" displayname="SessionID" hint="SessionID related to Cart" type="string" required="yes">
		<cfargument name="SiteID" displayname="SiteID" hint="The CartFusion Site ID of the Products to delete" type="numeric" required="yes">
		<cfargument name="ItemID" displayname="ItemID" hint="The ItemID of the item in the Cart to delete" type="numeric" required="no">
		<cfargument name="OptionName1" displayname="Option Name 1" hint="Product option value 1 in Cart" type="string" required="no">
		<cfargument name="OptionName2" displayname="Option Name 2" hint="Product option value 2 in Cart" type="string" required="no">
		<cfargument name="OptionName3" displayname="Option Name 3" hint="Product option value 3 in Cart" type="string" required="no">
		
		<cfquery name="cleanCart" DATASOURCE="#application.dsn#">
			DELETE 
			FROM 	Cart
			WHERE 	SessionID = '#arguments.SessionID#'
			<cfif isDefined("arguments.ItemID") AND arguments.ItemID NEQ ''>
			AND 	ItemID = #arguments.ItemID#
			</cfif>
			<cfif isDefined("arguments.OptionName1") AND arguments.OptionName1 NEQ ''>
			AND 	OptionName1 = '#arguments.OptionName1#'
			</cfif>
			<cfif isDefined("arguments.OptionName2") AND arguments.OptionName2 NEQ ''>
			AND 	OptionName2 = '#arguments.OptionName2#'
			</cfif>
			<cfif isDefined("arguments.OptionName3") AND arguments.OptionName3 NEQ ''>
			AND 	OptionName3 = '#arguments.OptionName3#'
			</cfif>		
		</cfquery>
	
	</cffunction>
	
	<!--- 
		GET CUSTOMER WISHLIST
		Used in: WishEdit.cfm, CartUpdate.cfm, WishToCart.cfm, WishUpdate.cfm
	--->
	<cffunction name="getCustomerWishList" displayname="Get Items in Customer Wishlist" hint="Function to retrieve all items in customer's wishlist." access="public" returntype="query">
		<cfargument name="CustomerID" displayname="Customer ID" hint="Customer ID related to wishlist" type="string" required="yes">
		<cfargument name="SiteID" displayname="SiteID" hint="The CartFusion Site ID of the Products to get" type="numeric" required="yes">
		<cfargument name="ItemID" displayname="Product ID" hint="The ID of the Product in the wishlist" type="numeric" required="no">
		<cfargument name="OptionName1" displayname="Option Name 1" hint="Product option value 1 in wishlist" type="string" required="no">
		<cfargument name="OptionName2" displayname="Option Name 2" hint="Product option value 2 in wishlist" type="string" required="no">
		<cfargument name="OptionName3" displayname="Option Name 3" hint="Product option value 3 in wishlist" type="string" required="no">

		<CFQUERY NAME="getWishList" DATASOURCE="#application.dsn#">
			SELECT 	w.WishListItemID, w.CustomerID, w.SessionID, w.ItemID, w.Qty, w.OptionName1, w.OptionName2, w.OptionName3,
					w.DateEntered, w.AffiliateID, w.BackOrdered, w.SiteID,
					p.SKU, p.ItemName, p.Price#session.CustomerArray[28]#, p.Weight
			FROM 	Wishlist w, Products p
			WHERE 	w.ItemID = p.ItemID
			AND 	w.CustomerID = '#arguments.CustomerID#'
			AND		w.SiteID = #arguments.SiteID#
			<cfif isDefined("arguments.ItemID") AND arguments.ItemID NEQ ''>
			AND		w.ItemID = #arguments.ItemID#
			</cfif>
			<cfif isDefined("arguments.OptionName1") AND arguments.OptionName1 NEQ ''>
			AND 	w.OptionName1 = '#arguments.OptionName1#'
			</cfif>
			<cfif isDefined("arguments.OptionName2") AND arguments.OptionName2 NEQ ''>
			AND 	w.OptionName2 = '#arguments.OptionName2#'
			</cfif>
			<cfif isDefined("arguments.OptionName3") AND arguments.OptionName3 NEQ ''>
			AND 	w.OptionName3 = '#arguments.OptionName3#'
			</cfif>
			ORDER BY p.SKU
		</cfquery>
		
		<cfreturn getWishList>		
	</cffunction>
	
	<!--- 
		INSERT INTO CUSTOMER WISHLIST
		Used in: CartUpdate.cfm, WishUpdate.cfm
	--->
	<cffunction name="insertWishList" displayname="Update Items in Customer Wishlist" hint="Function to update items in customer's wishlist." access="public">
		<cfargument name="CustomerID" displayname="Customer ID" hint="Customer ID related to wishlist" type="string" required="yes">
		<cfargument name="SiteID" displayname="SiteID" hint="The CartFusion Site ID of the Products to update" type="numeric" required="yes">
		<cfargument name="Quantity" displayname="Quantity" hint="The Quantity of Products to update" type="numeric" required="yes">
		<cfargument name="ItemID" displayname="ItemID" hint="The Item ID of the item in the wishlist to update" type="numeric" required="no">
		<cfargument name="BackOrdered" displayname="Item is Backordered" hint="Wishlist keeps track if item is backordered" type="numeric" required="no">
		<cfargument name="OptionName1" displayname="Option Name 1" hint="Product option value 1 in wishlist" type="string" required="no">
		<cfargument name="OptionName2" displayname="Option Name 2" hint="Product option value 2 in wishlist" type="string" required="no">
		<cfargument name="OptionName3" displayname="Option Name 3" hint="Product option value 3 in wishlist" type="string" required="no">
		
		<cfquery name="insertWishList" DATASOURCE="#application.dsn#">
			INSERT INTO Wishlist 
			(	
				CustomerID, 
				Qty, 
				ItemID,
				SiteID
				<cfif isDefined("arguments.OptionName1") AND arguments.OptionName1 NEQ ''>, OptionName1</cfif>
				<cfif isDefined("arguments.OptionName2") AND arguments.OptionName2 NEQ ''>, OptionName2</cfif>
				<cfif isDefined("arguments.OptionName3") AND arguments.OptionName3 NEQ ''>, OptionName3</cfif>
				<cfif isDefined("arguments.Backordered") AND arguments.Backordered NEQ ''>, BackOrdered</cfif>
			) 
			VALUES
			(
				'#arguments.CustomerID#', 
				#arguments.Quantity#, 
				#arguments.ItemID#,
				#arguments.SiteID#
				<cfif isDefined("arguments.OptionName1") AND arguments.OptionName1 NEQ ''>, '#arguments.OptionName1#'</cfif>
				<cfif isDefined("arguments.OptionName2") AND arguments.OptionName2 NEQ ''>, '#arguments.OptionName2#'</cfif>
				<cfif isDefined("arguments.OptionName3") AND arguments.OptionName3 NEQ ''>, '#arguments.OptionName3#'</cfif>
				<cfif isDefined("arguments.Backordered") AND arguments.Backordered NEQ ''>,  #arguments.Backordered# </cfif>
			)
		</cfquery>
	
	</cffunction>
	
	
	<!--- 
		UPDATE CUSTOMER WISHLIST
		Used in: WishUpdate.cfm
	--->
	<cffunction name="updateWishList" displayname="Update Items in Customer Wishlist" hint="Function to update items in customer's wishlist." access="public">
		<cfargument name="CustomerID" displayname="Customer ID" hint="Customer ID related to wishlist" type="string" required="yes">
		<cfargument name="SiteID" displayname="SiteID" hint="The CartFusion Site ID of the Products to update" type="numeric" required="yes">
		<cfargument name="Quantity" displayname="Quantity" hint="The Quantity of Products to update" type="numeric" required="yes">
		<cfargument name="ItemID" displayname="ItemID" hint="The Item ID of the item in the wishlist to update" type="numeric" required="no">
		<cfargument name="WishlistItemID" displayname="Wishlist ID" hint="The Wishlist ID of the item in the wishlist to update" type="numeric" required="no">
		<cfargument name="OptionName1" displayname="Option Name 1" hint="Product option value 1 in wishlist" type="string" required="no">
		<cfargument name="OptionName2" displayname="Option Name 2" hint="Product option value 2 in wishlist" type="string" required="no">
		<cfargument name="OptionName3" displayname="Option Name 3" hint="Product option value 3 in wishlist" type="string" required="no">
		
		<cfquery name="updateWishlist" DATASOURCE="#application.dsn#">
			UPDATE 	Wishlist
			SET		Qty = #arguments.Quantity#
			<cfif arguments.CustomerID NEQ ''>
					, CustomerID = '#arguments.CustomerID#'
			</cfif>
			WHERE 	CustomerID = '#arguments.CustomerID#'
			<cfif isDefined("arguments.ItemID") AND arguments.ItemID NEQ ''>
			AND 	ItemID = #arguments.ItemID#
			</cfif>
			<cfif isDefined("arguments.WishlistItemID") AND arguments.WishlistItemID NEQ ''>
			AND 	WishlistItemID = #arguments.WishlistItemID#
			</cfif>			
			<cfif isDefined("arguments.OptionName1") AND arguments.OptionName1 NEQ ''>
			AND 	OptionName1 = '#arguments.OptionName1#'
			</cfif>
			<cfif isDefined("arguments.OptionName2") AND arguments.OptionName2 NEQ ''>
			AND 	OptionName2 = '#arguments.OptionName2#'
			</cfif>
			<cfif isDefined("arguments.OptionName3") AND arguments.OptionName3 NEQ ''>
			AND 	OptionName3 = '#arguments.OptionName3#'
			</cfif>				
		</cfquery>
	
	</cffunction>
	
	
	<!--- 
		DELETE CUSTOMER WISHLIST
		Used in: WishUpdate.cfm
	--->
	<cffunction name="deleteWishList" displayname="Delete Items in Customer Wishlist" hint="Function to delete all items in customer's wishlist." access="public">
		<cfargument name="CustomerID" displayname="Customer ID" hint="Customer ID related to wishlist" type="string" required="yes">
		<cfargument name="SiteID" displayname="SiteID" hint="The CartFusion Site ID of the Products to delete" type="numeric" required="yes">
		<cfargument name="WishlistItemID" displayname="Wishlist ID" hint="The ID of the item in the wishlist to delete" type="numeric" required="no">
		<cfargument name="OptionName1" displayname="Option Name 1" hint="Product option value 1 in wishlist" type="string" required="no">
		<cfargument name="OptionName2" displayname="Option Name 2" hint="Product option value 2 in wishlist" type="string" required="no">
		<cfargument name="OptionName3" displayname="Option Name 3" hint="Product option value 3 in wishlist" type="string" required="no">
		
		<cfquery name="cleanWishlist" DATASOURCE="#application.dsn#">
			DELETE 
			FROM 	Wishlist
			WHERE 	CustomerID = '#arguments.CustomerID#'
			<cfif isDefined("arguments.WishlistItemID") AND arguments.WishlistItemID NEQ ''>
			AND 	WishlistItemID = #arguments.WishlistItemID#
			</cfif>
		</cfquery>
	
	</cffunction>
	
	
</cfcomponent>

