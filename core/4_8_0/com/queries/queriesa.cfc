<cfcomponent displayname="Queries Dashboard Module" hint="This component handles the DB queries throughout a CartFusion Dashboard site.">
	
    <cfscript>
		variables.dsn = "";
	</cfscript>
    
    <cffunction name="init" returntype="QueriesA" output="false">
		<cfargument name="dsn" required="true">
	
		<cfscript>
			variables.dsn = arguments.dsn;
		</cfscript>
		
		<cfreturn this />
	</cffunction>
    
    
    
<!---
		loginQuery
		Used in:
			admin/Application.cfm
	--->
	<cffunction name="loginQuery" access="public">
		<cfargument name="UserName" type="string" required="yes">
		<cfargument name="Password" type="string" required="yes">

		<cfquery name="loginQuery" datasource="#variables.dsn#">
			SELECT 	UserID, UserName, Roles
			FROM 	AdminUsers
			WHERE	UserName = '#arguments.UserName#'
			AND 	Password = '#arguments.Password#'
			AND		(Disabled = 0 OR Disabled IS NULL)
		</cfquery>
		
		<cfreturn loginQuery >
	</cffunction>
	
	<!---
		deleteAdminUser
		Used in:
			admin/AdminUsers.cfm
	--->
	<cffunction name="deleteAdminUser" access="public">
		<cfargument name="UserID" type="numeric" required="yes">

		<cfquery name="deleteAdminUser" datasource="#variables.dsn#">
			DELETE FROM	AdminUsers
			WHERE		UserID = #arguments.UserID#
		</cfquery>

	</cffunction>
	
	<!---
		deleteCategory
		Used in:
			admin/Categories.cfm
	--->
	<cffunction name="deleteCategory" access="public">
		<cfargument name="CatID" type="numeric" required="yes">

		<cfquery name="deleteCategory" datasource="#variables.dsn#">
			DELETE FROM	Categories
			WHERE		CatID = #arguments.CatID#
		</cfquery>

	</cffunction>
	
	<!---
		deleteMessage
		Used in:
			admin/MC-Messages.cfm
	--->
	<cffunction name="deleteMessage" access="public">
		<cfargument name="MessageID" type="numeric" required="yes">

		<cfquery name="deleteMessage" datasource="#variables.dsn#">
			DELETE FROM	Messages
			WHERE		MessageID = #arguments.MessageID#
		</cfquery>

	</cffunction>
	
	<!---
		deleteMessageCenter
		Used in:
			admin/MC-Main.cfm
	--->
	<cffunction name="deleteMessageCenter" access="public">
		<cfargument name="MCID" type="numeric" required="yes">

		<cfquery name="deleteMessageCenter" datasource="#variables.dsn#">
			DELETE FROM	MessageCenter
			WHERE		MCID = #arguments.MCID#
		</cfquery>

	</cffunction>
	
	<!---
		deleteOrder
		Used in:
			admin/Orders.cfm
	--->
	<cffunction name="deleteOrder" access="public">
		<cfargument name="OrderID" type="numeric" required="yes">

		<cfquery name="deleteOrder" datasource="#variables.dsn#">
			DELETE FROM	Orders
			WHERE		OrderID = #arguments.OrderID#
			
			DELETE FROM	OrderItems
			WHERE		OrderID = #arguments.OrderID#
		</cfquery>

	</cffunction>
	
	<!---
		deleteOrderItem
		Used in:
			admin/OrderDetail.cfm
	--->
	<cffunction name="deleteOrderItem" access="public">
		<cfargument name="OrderItemsID" type="numeric" required="yes">
		<cfargument name="ItemID" type="numeric" required="yes">

		<cfquery name="deleteOrderItem" datasource="#variables.dsn#">
			DELETE FROM	OrderItems
			WHERE		OrderItemsID = #arguments.OrderItemsID#
			AND			ItemID = #arguments.ItemID#
		</cfquery>

	</cffunction>
	
	<!---
		deleteProductType
		Used in:
			admin/ProductTypes.cfm
	--->
	<cffunction name="deleteProductType" access="public">
		<cfargument name="TypeID" type="numeric" required="yes">

		<cfquery name="deleteProductType" datasource="#variables.dsn#">
			DELETE FROM	ProductTypes
			WHERE		TypeID = #arguments.TypeID#
		</cfquery>

	</cffunction>
	
	<!---
		deleteReview
		Used in:
			admin/ProductReviews.cfm
	--->
	<cffunction name="deleteReview" access="public">
		<cfargument name="PRID" type="numeric" required="yes">

		<cfquery name="deleteReview" datasource="#variables.dsn#">
			DELETE FROM	ProductReviews
			WHERE		PRID = #arguments.PRID#
		</cfquery>

	</cffunction>
	
	<!---
		deleteSection
		Used in:
			admin/Sections.cfm
	--->
	<cffunction name="deleteSection" access="public">
		<cfargument name="SectionID" type="numeric" required="yes">

		<cfquery name="deleteSection" datasource="#variables.dsn#">
			DELETE FROM	Sections
			WHERE		SectionID = #arguments.SectionID#
		</cfquery>

	</cffunction>
	
	<!---
		getAdminUser
		Used in:

			admin/AdminUserDetail.cfm
	--->
	<cffunction name="getAdminUser" access="public">
		<cfargument name="UserID" type="numeric" required="yes">

		<cfquery name="getAdminUser" datasource="#variables.dsn#">
			SELECT 	*
			FROM 	AdminUsers
			WHERE	UserID = #arguments.UserID#
		</cfquery>
		
		<cfreturn getAdminUser >
	</cffunction>
	
	<!---
		getAdminUsers
		Used in:
			admin/AdminUsers.cfm
	--->
	<cffunction name="getAdminUsers" access="public">

		<cfquery name="getAdminUsers" datasource="#variables.dsn#">
			SELECT 		*
			FROM 		AdminUsers
			ORDER BY 	UserID
		</cfquery>
		
		<cfreturn getAdminUsers >
	</cffunction>
	
	<!---
		getAffiliate
		Used in:
			admin/AffiliateDetail.cfm
	--->
	<cffunction name="getAffiliate" access="public">
		<cfargument name="AFID" type="numeric" required="yes">

		<cfquery name="getAffiliate" datasource="#variables.dsn#">
			SELECT 	*
			FROM 	Affiliates
			WHERE	AFID = #arguments.AFID#
		</cfquery>
		
		<cfreturn getAffiliate >
	</cffunction>
	
	<!---
		getAffiliatesDDL
		Used in:
			admin/OrderDetail.cfm
	--->
	<cffunction name="getAffiliatesDDL" access="public">

		<cfquery name="getAffiliatesDDL" datasource="#variables.dsn#">
			SELECT		AFID, convert(varchar, AFID) + ': ' + LastName + ', ' + FirstName AS AffiliateName
			FROM		Affiliates
			WHERE		Deleted = 0
			OR			Deleted IS NULL
			ORDER BY 	AFID DESC
		</cfquery>
		
		<cfreturn getAffiliatesDDL >
	</cffunction>
	
	<!---
		getAFLevel
		Used in:
			admin/RWP-AffiliatesAction.cfm
			OTHERS
	--->
	<cffunction name="getAFLevel" access="public">
		<cfargument name="CommID" type="numeric" required="yes">
		
		<cfquery name="getAFLevel" datasource="#variables.dsn#">
			SELECT	*
			FROM	AffiliateCommissions
			WHERE 	CommID = #arguments.CommID#
		</cfquery>
		
		<cfreturn getAFLevel >
	</cffunction>
	
	<!---
		getAFLevels
		Used in:
			admin/AffiliateLevels.cfm
			admin/AffiliateAdd.cfm
			admin/AffiliateDetail.cfm
	--->
	<cffunction name="getAFLevels" access="public">
		
		<cfquery name="getAFLevels" datasource="#variables.dsn#">
			SELECT	*
			FROM	AffiliateCommissions
			ORDER BY CommID
		</cfquery>
		
		<cfreturn getAFLevels >
	</cffunction>
	
	<!---
		getAN
		Used in:
			admin/Config-PaymentSystem.cfm
			admin/OrderComplete.cfm
	--->
	<cffunction name="getAN" access="public">
		<cfargument name="SiteID" type="numeric" required="yes">
		
		<cfquery name="getAN" datasource="#variables.dsn#">
			SELECT	*
			FROM	AuthorizeNet
			WHERE	ID = #arguments.SiteID#
		</cfquery>
		
		<cfreturn getAN >		
	</cffunction>
	
	<!---
		getANTK
		Used in:
			admin/Config-PaymentSystem.cfm
			admin/OrderComplete.cfm
	--->
	<cffunction name="getANTK" access="public">
		<cfargument name="SiteID" type="numeric" required="yes">
		
		<cfquery name="getANTK" datasource="#variables.dsn#">
			SELECT	*
			FROM	AuthorizeNetTK
			WHERE	ID = #arguments.SiteID#
		</cfquery>
		
		<cfreturn getANTK >		
	</cffunction>
	
	<!---
		getBackOrderItems
		Used in:
			admin/OrderDetail.cfm
	--->
	<cffunction name="getBackOrderItems" access="public">
		<cfargument name="BOID" type="numeric" required="yes">
		
		<cfquery name="getBackOrderItems" datasource="#variables.dsn#">
			SELECT		*
			FROM		BackOrderItems
			WHERE		BOID = #arguments.BOID#
			ORDER BY 	BOItemID
		</cfquery>
		
		<cfreturn getBackOrderItems >		
	</cffunction>
	
	<!---
		getBackOrders
		Used in:
			admin/OrderDetail.cfm
			admin/OrderEmail.cfm
			admin/OrderPrint.cfm
			admin/RWP-StoreAction.cfm
	--->
	<cffunction name="getBackOrders" access="public">
		<cfargument name="OrderID" type="numeric" required="yes">
		
		<cfquery name="getBackOrders" datasource="#variables.dsn#">
			SELECT	*
			FROM 	BackOrders
			WHERE	BOOrderID = #arguments.OrderID#
		</cfquery>
		
		<cfreturn getBackOrders >
	</cffunction>
	
	<!---
		getBillingStatusCode
		Used in:
			admin/AffiliateDetail.cfm
	--->
	<cffunction name="getBillingStatusCode" access="public">
		<cfargument name="StatusCode" type="string" required="yes">
		
		<cfquery name="getBillingStatusCode" datasource="#variables.dsn#" cachedwithin="#CreateTimeSpan(0,0,2,0)#">
			SELECT 	StatusMessage
			FROM	BillingStatusCodes
			WHERE	StatusCode = '#arguments.StatusCode#'
		</cfquery>
		
		<cfreturn getBillingStatusCode >
	</cffunction>
	
	<!---
		getBillingStatusCodes
		Used in:
			admin/Configuration.cfm
			admin/OrderAdd.cfm
			admin/OrderDetail.cfm
			admin/Orders.cfm
	--->
	<cffunction name="getBillingStatusCodes" access="public">

		<cfquery name="getBillingStatusCodes" datasource="#variables.dsn#" cachedwithin="#CreateTimeSpan(-0,0,2,0)#">
			SELECT 		*
			FROM		BillingStatusCodes
			ORDER BY 	StatusMessage
		</cfquery>
		
		<cfreturn getBillingStatusCodes >
	</cffunction>
	
	<!---
		getCategories
		Used in:
			admin/CategoryAdd.cfm
			admin/CategoryList.cfm
			admin/MC-Send.cfm
			admin/MWP-Home.cfm
	--->
	<cffunction name="getCategories" access="public">

		<cfquery name="getCategories" datasource="#variables.dsn#" cachedwithin="#CreateTimeSpan(0,0,2,0)#">
			SELECT 		*
			FROM		Categories
			ORDER BY 	DisplayOrder, CatName
		</cfquery>
		
		<cfreturn getCategories >
	</cffunction>
	
	<!---
		getCategory
		Used in:
			admin/CategoryDetail.cfm
	--->
	<cffunction name="getCategory" access="public">
		<cfargument name="CatID" type="numeric" required="yes">
		
		<cfquery name="getCategory" datasource="#variables.dsn#">
			SELECT	*
			FROM	Categories
			WHERE	CatID = #arguments.CatID#
		</cfquery>
		
		<cfreturn getCategory >		
	</cffunction>
	
	<!---
		getCities
		Used in:
			admin/MC-Send.cfm
			admin/MWP-Home.cfm
	--->
	<cffunction name="getCities" access="public">

		<cfquery name="getCities" datasource="#variables.dsn#" cachedwithin="#CreateTimeSpan(0,0,2,0)#">
			SELECT DISTINCT City
			FROM 			Customers
			ORDER BY 		City
		</cfquery>
		
		<cfreturn getCities >
	</cffunction>
	
	<!---
		getCountries
		Used in:
			A LOT
	--->
	<cffunction name="getCountries" access="public">

		<cfquery name="getCountries" datasource="#variables.dsn#" cachedwithin="#CreateTimeSpan(0,0,2,0)#">
			SELECT		*
			FROM		Countries
			ORDER BY 	Country
		</cfquery>
		
		<cfreturn getCountries >
	</cffunction>
	
	<!---
		getCurrencies
		Used in:
			admin/Configuration.cfm
	--->
	<cffunction name="getCurrencies" access="public">

		<cfquery name="getCurrencies" datasource="#variables.dsn#" cachedwithin="#CreateTimeSpan(0,0,2,0)#">
			SELECT 		*
			FROM		Currencies	
			ORDER BY 	CurrencyMessage
		</cfquery>
		
		<cfreturn getCurrencies >
	</cffunction>
	
	<!---
		getCustomer
		Used in:
			admin/CustomerDetail.cfm
			admin/OrderAdd.cfm
			admin/Orders.cfm
	--->
	<cffunction name="getCustomer" access="public">
		<cfargument name="CustomerID" type="string" required="yes">
		
		<cfquery name="getCustomer" datasource="#variables.dsn#">
			SELECT	*
			FROM	Customers
			WHERE	CustomerID = '#arguments.CustomerID#'
		</cfquery>
		
		<cfreturn getCustomer >		
	</cffunction>
	
	<!---
		getCustomerOrders
		Used in:
			admin/CustomerDetail.cfm
	--->
	<cffunction name="getCustomerOrders" access="public">
		<cfargument name="CustomerID" type="string" required="yes">
		
		<cfquery name="getCustomerOrders" datasource="#variables.dsn#">
			SELECT	*
			FROM	Orders
			WHERE	CustomerID = '#arguments.CustomerID#'
		</cfquery>
		
		<cfreturn getCustomerOrders >		
	</cffunction>
	
	<!---
		getCustomers
		Used in:
			admin/MC-Send.cfm
			admin/OrderAdd.cfm
	--->
	<cffunction name="getCustomers" access="public">
		
		<cfquery name="getCustomers" datasource="#variables.dsn#">
			SELECT 		*, LastName + ', ' + FirstName + ': ' + CustomerID AS CustomerInfo
			FROM		Customers
			ORDER BY	LastName
		</cfquery>
		
		<cfreturn getCustomers >		
	</cffunction>
	
	<!---
		getCustomersAF
		Used in:
			admin/AffiliateDetail.cfm
	--->
	<cffunction name="getCustomersAF" access="public">
		<cfargument name="AffiliateID" type="numeric" required="yes">
		
		<cfquery name="getCustomersAF" datasource="#variables.dsn#">
			SELECT 	c.CustomerID, c.FirstName + ' ' + c.LastName AS CustomerName, 
					( SELECT Count(*) FROM Orders WHERE CustomerID = c.CustomerID AND AffiliateID = #arguments.AffiliateID# ) 
					AS CustomerOrders
			FROM 		Customers c
			WHERE	c.CustomerID IN ( SELECT CustomerID FROM Orders WHERE AffiliateID = #arguments.AffiliateID# )
		</cfquery>
		
		<cfreturn getCustomersAF >		
	</cffunction>
	
	<!---
		getDiscount
		Used in:
			admin/DiscountDetail.cfm
	--->
	<cffunction name="getDiscount" access="public">
		<cfargument name="DiscountID" type="numeric" required="yes">
		
		<cfquery name="getDiscount" datasource="#variables.dsn#">
			SELECT	*
			FROM	Discounts
			WHERE	DiscountID = #arguments.DiscountID#
		</cfquery>
		
		<cfreturn getDiscount >
	</cffunction>
	
	<!---
		getDistributor
		Used in:
			admin/DistOrdersSend.cfm
			admin/DistributorDetail.cfm
			admin/DistributorEmail.cfm
	--->
	<cffunction name="getDistributor" access="public">
		<cfargument name="DistributorID" type="numeric" required="yes">
		
		<cfquery name="getDistributor" datasource="#variables.dsn#">
			SELECT	*
			FROM	Distributors
			WHERE	DistributorID = #arguments.DistributorID#
		</cfquery>
		
		<cfreturn getDistributor >
	</cffunction>

	<!---
		getDistributors
		Used in:
			admin/Prices.cfm
			admin/ProductAdd.cfm
			admin/ProductDetail.cfm
	--->
	<cffunction name="getDistributors" access="public">
		
		<cfquery name="getDistributors" datasource="#variables.dsn#">
			SELECT		DistributorID, DistributorName
			FROM		Distributors
			ORDER BY	DistributorName
		</cfquery>
		
		<cfreturn getDistributors >
	</cffunction>	
	
	<!---
		getItemClass
		Used in:
			admin/ProductMatrix.cfm
	--->
	<cffunction name="getItemClass" access="public">
		<cfargument name="ICID" type="numeric" required="yes">
		
		<cfquery name="getItemClass" datasource="#variables.dsn#">
			SELECT	*
			FROM	ItemClasses
			WHERE	ICID = #arguments.ICID#
		</cfquery>
		
		<cfreturn getItemClass >
	</cffunction>
	
	<!---
		getItemClassComponent
		Used in:
			???
	--->
	<cffunction name="getItemClassComponent" access="public">
		<cfargument name="ICCID" type="numeric" required="yes">
		
		<cfquery name="getItemClassComponent" datasource="#variables.dsn#">
			SELECT	*
			FROM	ItemClassComponents
			WHERE	ICCID = #arguments.ICCID#
		</cfquery>
		
		<cfreturn getItemClassComponent >
	</cffunction>
	
	<!---
		getItemClassComponents
		Used in:
			admin/ProductMatrix.cfm
	--->
	<cffunction name="getItemClassComponents" access="public">
		<cfargument name="ItemID" type="numeric" required="yes">
		
		<cfquery name="getItemClassComponents" datasource="#variables.dsn#">
			SELECT	*
			FROM	ItemClassComponents
			WHERE	ItemID = #arguments.ItemID#
		</cfquery>
		
		<cfreturn getItemClassComponents >
	</cffunction>
	
	<!---
		getItemClasses
		Used in:
			admin/ProductAdd.cfm
			admin/ProductClasses.cfm
			admin/ProductDetail.cfm
			admin/ProductMatrix.cfm
	--->
	<cffunction name="getItemClasses" access="public">
		
		<cfquery name="getItemClasses" datasource="#variables.dsn#" cachedwithin="#CreateTimeSpan(0,0,2,0)#">
			SELECT 		*, ItemCode + ': ' + Description AS ICDescription
			FROM		ItemClasses
			ORDER BY 	ItemCode
		</cfquery>
		
		<cfreturn getItemClasses >
	</cffunction>

	<!---
		getItemNames
		Used in:
			admin/OrderDetail.cfm
	--->
	<cffunction name="getItemNames" access="public">
		<cfargument name="ItemID" type="numeric" required="yes">
		
		<cfquery name="getItemNames" datasource="#variables.dsn#">
			SELECT	SKU, ItemName 
			FROM 	Products 
			WHERE 	ItemID = #arguments.ItemID#
		</cfquery>
		
		<cfreturn getItemNames >
	</cffunction>
	
	<!---
		getItemStatusCodes
		Used in:
			admin/ProductAdd.cfm
			admin/ProductDetail.cfm
			admin/ProductMatrix.cfm
			admin/ProductOptions.cfm
			admin/Products.cfm
	--->
	<cffunction name="getItemStatusCodes" access="public">
		
		<cfquery name="getItemStatusCodes" datasource="#variables.dsn#" cachedwithin="#CreateTimeSpan(0,0,2,0)#">
			SELECT 		*
			FROM		ItemStatusCodes
			ORDER BY 	StatusMessage
		</cfquery>
		
		<cfreturn getItemStatusCodes >
	</cffunction>
	
	<!---
		getLastOrderID
		Used in:
			admin/OrderAdd.cfm
	--->
	<cffunction name="getLastOrderID" access="public">
		
		<cfquery name="getLastOrderID" datasource="#variables.dsn#">
			SELECT 	MAX(OrderID) as LastOrderID
			FROM	Orders
		</cfquery>
		
		<cfreturn getLastOrderID >
	</cffunction>
	
	<!---
		getOptionCategories
		Used in:
			admin/ProductDetail.cfm
			admin/ProductOptions.cfm
	--->
	<cffunction name="getOptionCategories" access="public">
		<cfargument name="ItemID" type="numeric" required="yes">
		
		<cfquery name="getOptionCategories" datasource="#variables.dsn#">
			SELECT	OptionName1, OptionName2, OptionName3
			FROM 	Products
			WHERE 	ItemID = #arguments.ItemID#
		</cfquery>
		
		<cfreturn getOptionCategories >
	</cffunction>
	
	<!---
		getOptions
		Used in:
			admin/ProductDetail.cfm
			admin/ProductOptions.cfm
	--->
	<cffunction name="getOptions" access="public">
		<cfargument name="ItemID" type="numeric" required="yes">
		
		<cfquery name="getOptions" datasource="#variables.dsn#">
			SELECT	*
			FROM 	ProductOptions
			WHERE 	ItemID = #arguments.ItemID#
		</cfquery>
		
		<cfreturn getOptions >
	</cffunction>
	
	<!---
		getOrder
		Used in:
			admin/OrderDetail.cfm
			admin/OrderEmail.cfm
			admin/OrderPrint.cfm
			admin/RWP-StoreAction.cfm
	--->
	<cffunction name="getOrder" access="public">
		<cfargument name="OrderID" type="numeric" required="yes">
		
		<cfquery name="getOrder" datasource="#variables.dsn#">
			SELECT	c.CustomerID, c.FirstName, c.LastName, c.CompanyName, c.Address1, c.Address2, c.City, c.State, c.Zip, c.Country, c.Email, 
					c.Credit, c.PriceToUse, c.Phone AS CustomerPhone, c.Comments AS CustDetailComments,				
					o.SiteID, o.OrderID, o.PaymentVerified, o.CCName, o.CCNum, o.CCExpDate, o.CCCVV, o.ShippingTotal, o.TaxTotal, o.DiscountTotal, 
					o.CreditApplied, o.ShippingMethod, o.TrackingNumber, o.AffiliateID, o.BillingStatus, o.OrderStatus, o.ShipDate, o.TransactionID,
					o.oShipFirstName, o.oShipLastName, o.oShipCompanyName, o.oShipAddress1, o.oShipAddress2, 
					o.oShipCity, o.oShipState, o.oShipZip, o.oShipCountry,
					o.CustomerComments, o.Phone AS OrderPhone, o.Comments AS OrderComments, o.DateEntered AS OrderDate, 
					o.DateUpdated AS OrderUpdated, o.UpdatedBy AS OrderUpdatedBy, o.FormOfPayment
					
			FROM 	Customers c, Orders o
			WHERE	c.CustomerID = o.CustomerID
			AND		o.OrderID = #arguments.OrderID#
		</cfquery>
		
		<cfreturn getOrder >
	</cffunction>
	
	<!---
		getOrderInfo
		Used in:
			admin/DistOrdersSend.cfm
			admin/DistributorEmail.cfm
	--->
	<cffunction name="getOrderInfo" access="public">
		<cfargument name="OrderID" type="numeric" required="yes">
		
		<cfquery name="getOrderInfo" datasource="#variables.dsn#">
			SELECT	o.OrderID, o.Phone AS OrderPhone, o.DateEntered, o.oShipFirstName, o.oShipLastName, o.oShipCompanyName, 
					o.oShipAddress1, o.oShipAddress2, o.oShipCity, o.oShipState, o.oShipZip, o.oShipCountry, o.ShippingMethod
			FROM	Orders o
			WHERE	o.OrderID = #arguments.OrderID#
		</cfquery>
		
		<cfreturn getOrderInfo >
	</cffunction>
	
	<!---
		getOrderItems
		Used in:
			admin/OrderDetail.cfm
			admin/OrderEmail.cfm
			admin/OrderPrint.cfm
			admin/RWP-StoreAction.cfm
	--->
	<cffunction name="getOrderItems" access="public">
		<cfargument name="OrderID" type="numeric" required="yes">
		
		<cfquery name="getOrderItems" datasource="#variables.dsn#">
			SELECT	oi.OrderItemsID, oi.Qty, oi.ItemPrice, oi.StatusCode, oi.OptionName1, oi.OptionName2, oi.OptionName3, 
					oi.DateEntered AS OrderItemDate, oi.OITrackingNumber,
					p.ItemID, p.SKU, p.ItemName
			FROM	OrderItems oi, Products p
			WHERE	oi.OrderID = #arguments.OrderID#
			AND		oi.ItemID = p.ItemID
			ORDER BY p.SKU
		</cfquery>
		
		<cfreturn getOrderItems >
	</cffunction>
	
	<!---
		getOrderItemsStatusCode
		Used in:
			admin/OrderEmail.cfm
			admin/OrderPrint.cfm
	--->
	<cffunction name="getOrderItemsStatusCode" access="public">
		<cfargument name="StatusCode" type="string" required="yes">
		
		<cfquery name="getOrderItemsStatusCode" datasource="#variables.dsn#">
			SELECT	StatusMessage
			FROM	OrderItemsStatusCodes
			WHERE	StatusCode = '#arguments.StatusCode#'
		</cfquery>
		
		<cfreturn getOrderItemsStatusCode >
	</cffunction>
	
	<!---
		getOrderItemsStatusCodes
		Used in:
			admin/OrderAdd.cfm
			admin/OrderDetail.cfm
			admin/OrderItemAdd.cfm
	--->
	<cffunction name="getOrderItemsStatusCodes" access="public">

		<cfquery name="getOrderItemsStatusCodes" datasource="#variables.dsn#" cachedwithin="#CreateTimeSpan(0,0,2,0)#">
			SELECT 		*
			FROM		OrderItemsStatusCodes
			ORDER BY 	StatusMessage
		</cfquery>
		
		<cfreturn getOrderItemsStatusCodes >
	</cffunction>
	
	<!---
		getOrdersAF
		Used in:
			admin/AffiliateDetail.cfm
			admin/Affiliates.cfm
	--->
	<cffunction name="getOrdersAF" access="public">
		<cfargument name="AffiliateID" type="numeric" required="yes">
		
		<cfquery name="getOrdersAF" datasource="#variables.dsn#">
			SELECT		OrderID, BillingStatus, DateEntered AS OrderDate, DiscountTotal, CreditApplied, 
						AffiliatePaid, AffiliateTotal
			FROM 		Orders
			WHERE 		AffiliateID = #arguments.AffiliateID#
			ORDER BY 	OrderID, DateEntered ASC
		</cfquery>
		
		<cfreturn getOrdersAF >
	</cffunction>
	
	<!---
		getOrdersDist
		Used in:
			admin/AffiliateDetail.cfm
			admin/Affiliates.cfm
	--->
	<cffunction name="getOrdersDist" access="public">
		<cfargument name="DistributorID" type="numeric" required="yes">
		
		<cfquery name="getOrdersDist" datasource="#variables.dsn#">
			SELECT	oi.OrderItemsID, oi.OrderID, oi.ItemID, oi.DateEntered, oi.StatusCode,
					(
					SELECT	SUM(Qty)
					FROM		OrderItems oo, Products pp
					WHERE	oo.StatusCode <> 'OD' 
					AND		oo.StatusCode <> 'BO'
					AND		oo.OrderID = oi.OrderID
					AND		oo.ItemID = pp.ItemID
					AND		pp.DistributorID = #arguments.DistributorID#
					) AS QtySum,
					(
					SELECT	SUM(CostPrice)
					FROM		OrderItems oo, Products pp
					WHERE	oo.StatusCode <> 'OD' 
					AND		oo.StatusCode <> 'BO'
					AND		oo.OrderID = oi.OrderID
					AND		oo.ItemID = pp.ItemID
					AND		pp.DistributorID = #arguments.DistributorID#
					) AS CostSum,
					(
					SELECT	OrderStatus
					FROM		Orders
					WHERE	OrderID = oi.OrderID
					) AS FulFilled,
					(
					SELECT	CustomerID
					FROM		Orders
					WHERE	OrderID = oi.OrderID
					) AS CustomerID
			FROM	OrderItems oi, Products p
			WHERE	p.DistributorID = #arguments.DistributorID#
			AND		oi.StatusCode <> 'OD' 
			AND		oi.StatusCode <> 'BO'
			AND		oi.ItemID = p.ItemID
			ORDER BY oi.OrderID DESC, SKU ASC
		</cfquery>
		
		<cfreturn getOrdersDist >
	</cffunction>
	
	<!---
		getOrdersDistSend
		Used in:
			admin/DistOrdersSend.cfm
			admin/DistributorEmail.cfm
			admin/Distributors.cfm
	--->
	<cffunction name="getOrdersDistSend" access="public">
		<cfargument name="DistributorID" type="numeric" required="yes">
		
		<cfquery name="getOrdersDistSend" datasource="#variables.dsn#">
			SELECT	oi.OrderItemsID, oi.OrderID, oi.ItemID, oi.Qty, oi.DateEntered, oi.StatusCode,
					oi.OptionName1, oi.OptionName2, oi.OptionName3,
					p.SKU, p.ItemName,
					(
					SELECT	CustomerID
					FROM	Orders
					WHERE	OrderID = oi.OrderID
					) AS CustomerID
			FROM		OrderItems oi, Products p
			WHERE	p.DistributorID = #arguments.DistributorID#
			AND		(
					oi.StatusCode = 'OD' OR
					oi.StatusCode = 'BO'
					)
			AND		oi.ItemID = p.ItemID
			AND		oi.OrderID IN
					(
					SELECT	OrderID
					FROM	Orders
					WHERE	OrderID = oi.OrderID
					AND		(
							OrderStatus = 'OD' OR
							OrderStatus = 'BO' OR
							OrderStatus = 'SP'
							)
					)
			ORDER BY 	oi.OrderID DESC, SKU ASC
		</cfquery>
		

		<cfreturn getOrdersDistSend >
	</cffunction>
	
	<!---
		getOrderStatusCode
		Used in:
			???
	--->
	<cffunction name="getOrderStatusCode" access="public">
		<cfargument name="StatusCode" type="string" required="yes">
		
		<cfquery name="getOrderStatusCode" datasource="#variables.dsn#">
			SELECT	StatusMessage
			FROM	OrderStatusCodes
			WHERE	StatusCode = '#arguments.StatusCode#'
		</cfquery>
		
		<cfreturn getOrderStatusCode >
	</cffunction>
	
	<!---
		getOrderStatusCodes
		Used in:
			admin/Configuration.cfm
			admin/OrderAdd.cfm
			admin/OrderDetail.cfm
			admin/Orders.cfm
	--->
	<cffunction name="getOrderStatusCodes" access="public">

		<cfquery name="getOrderStatusCodes" datasource="#variables.dsn#" cachedwithin="#CreateTimeSpan(0,0,2,0)#">
			SELECT 		*
			FROM		OrderStatusCodes
			ORDER BY 	StatusMessage
		</cfquery>
		
		<cfreturn getOrderStatusCodes >
	</cffunction>
	
	<!---
		getOrderTotal
		Used in:
			admin/AffiliateDetail.cfm
			admin/Orders.cfm
	--->
	<cffunction name="getOrderTotal" access="public">
		<cfargument name="OrderID" type="numeric" required="yes">
		
		<cfquery name="getOrderTotal" datasource="#variables.dsn#">
			SELECT	SUM( ItemPrice * Qty ) AS RunningTotal, SUM(Qty) AS Items
			FROM	OrderItems
			WHERE	OrderID = #arguments.OrderID#
			AND		StatusCode != 'BO'
			AND		StatusCode != 'CA'
		</cfquery>
		
		<cfreturn getOrderTotal >
	</cffunction>
	
	<!---
		getPaymentsAF
		Used in:
			AF-Main.cfm
	--->
	<cffunction name="getPaymentsAF" access="public">
		<cfargument name="AFID" type="numeric" required="yes">
		
		<cfquery name="getPaymentsAF" datasource="#variables.dsn#">
			SELECT	*
			FROM	AffiliatePayments
			WHERE	AFID = #arguments.AFID#
		</cfquery>
		
		<cfreturn getPaymentsAF >
	</cffunction>
		
	<!---
		getPaymentSystems
		Used in:
			admin/Configuration.cfm
	--->
	<cffunction name="getPaymentSystems" access="public">

		<cfquery name="getPaymentSystems" datasource="#variables.dsn#">
			SELECT		*
			FROM		PaymentSystems	
			ORDER BY	DisplayOrder, PaymentSystemMessage
		</cfquery>
		
		<cfreturn getPaymentSystems >
	</cffunction>
	
	<!---
		getPaymentType
		Used in:
			admin/BackOrdersConfirm.cfm
			admin/OrderEmail.cfm
			admin/OrderPrint.cfm
	--->
	<cffunction name="getPaymentType" access="public">
		<cfargument name="Type" type="string" required="yes">
		
		<cfquery name="getPaymentType" datasource="#variables.dsn#">
			SELECT 	Display
			FROM	Payment	
			WHERE	Type = '#arguments.Type#'
		</cfquery>
		
		<cfreturn getPaymentType >
	</cffunction>
	
	<!---
		getPaymentTypes
		Used in:
			admin/AffiliateAdd.cfm
			admin/Configuration.cfm
			admin/CustomerAdd.cfm
			admin/CustomerDetail.cfm
			admin/DistributorAdd.cfm
			admin/OrderAdd.cfm
			admin/OrderDetail.cfm
	--->
	<cffunction name="getPaymentTypes" access="public">

		<cfquery name="getPaymentTypes" datasource="#variables.dsn#" cachedwithin="#CreateTimeSpan(0,0,2,0)#">
			SELECT		*
			FROM		Payment
			WHERE		Allow = 1
		</cfquery>
		
		<cfreturn getPaymentTypes >
	</cffunction>
	
	<!---
		getPFL
		Used in:
			admin/Config-PaymentSystem.cfm
			admin/PG-PayFlowLink.cfm
	--->
	<cffunction name="getPFL" access="public">
		<cfargument name="SiteID" type="numeric" required="yes">
		
		<cfquery name="getPFL" datasource="#variables.dsn#">
			SELECT	*
			FROM	PayFlowLink
			WHERE	ID = #arguments.SiteID#
		</cfquery>
		
		<cfreturn getPFL >		
	</cffunction>
	
	<!---
		getProduct
		Used in:
			admin/ProductDetail.cfm
			admin/ProductMatrix.cfm
			admin/ProductOptions.cfm
	--->
	<cffunction name="getProduct" access="public">
		<cfargument name="ItemID" type="numeric" required="yes">
		
		<cfquery name="getProduct" datasource="#variables.dsn#">
			SELECT	*
			FROM	Products
			WHERE	ItemID = #arguments.ItemID#
		</cfquery>
		
		<cfreturn getProduct >		
	</cffunction>
	
	<!---
		getProductOptions1
		Used in:
			admin/OrderDetail.cfm
			admin/OrderItemAdd.cfm
	--->
	<cffunction name="getProductOptions1" access="public">
		<cfargument name="ItemID" type="numeric" required="yes">
		
		<cfquery name="getProductOptions1" datasource="#variables.dsn#">
			SELECT 	*
			FROM	ProductOptions
			WHERE	ItemID = #arguments.ItemID#
			AND		OptionColumn = 1
			AND		(Hide = 0 OR Hide IS NULL)
		</cfquery>
		
		<cfreturn getProductOptions1 >		
	</cffunction>
	
	<!---
		getProductOptions2
		Used in:
			admin/OrderDetail.cfm
			admin/OrderItemAdd.cfm
	--->
	<cffunction name="getProductOptions2" access="public">
		<cfargument name="ItemID" type="numeric" required="yes">
		
		<cfquery name="getProductOptions2" datasource="#variables.dsn#">
			SELECT 	*
			FROM	ProductOptions
			WHERE	ItemID = #arguments.ItemID#
			AND		OptionColumn = 2
			AND		(Hide = 0 OR Hide IS NULL)
		</cfquery>
		
		<cfreturn getProductOptions2 >		
	</cffunction>
	
	<!---
		getProductOptions3
		Used in:
			admin/OrderDetail.cfm
			admin/OrderItemAdd.cfm
	--->
	<cffunction name="getProductOptions3" access="public">
		<cfargument name="ItemID" type="numeric" required="yes">
		
		<cfquery name="getProductOptions3" datasource="#variables.dsn#">
			SELECT 	*
			FROM	ProductOptions
			WHERE	ItemID = #arguments.ItemID#
			AND		OptionColumn = 3
			AND		(Hide = 0 OR Hide IS NULL)
		</cfquery>
		
		<cfreturn getProductOptions3 >		
	</cffunction>

	<!---
		getProductType
		Used in:
			admin/ProductSpecs.cfm
			admin/ProductTypeDetail.cfm
	--->
	<cffunction name="getProductType" access="public">
		<cfargument name="TypeID" type="numeric" required="yes">
		
		<cfquery name="getProductType" datasource="#variables.dsn#">
			SELECT 	*
			FROM	ProductTypes
			WHERE	TypeID = #arguments.TypeID#
		</cfquery>
		
		<cfreturn getProductType >		
	</cffunction>
	
	<!---
		getProductTypes
		Used in:
			admin/ProductAdd.cfm
			admin/ProductDetail.cfm
			admin/ProductTypes.cfm
	--->
	<cffunction name="getProductTypes" access="public">
		
		<cfquery name="getProductTypes" datasource="#variables.dsn#">
			SELECT 	*
			FROM	ProductTypes
		</cfquery>
		
		<cfreturn getProductTypes >		
	</cffunction>
	
	<!---
		getRelatedItems
		Used in:
			admin/ProductDetail.cfm
	--->
	<cffunction name="getRelatedItems" access="public">
		<cfargument name="ItemID" type="numeric" required="yes">
		
		<cfquery name="getRelatedItems" datasource="#variables.dsn#">
			SELECT 	*
			FROM	RelatedItems
			WHERE	ItemID = #arguments.ItemID#
		</cfquery>
		
		<cfreturn getRelatedItems >		
	</cffunction>
	
	<!---
		getRoles
		Used in:
			admin/AdminUserAdd.cfm
			admin/AdminUserDetail.cfm
			admin/AdminUsers.cfm
	--->
	<cffunction name="getRoles" access="public">
		
		<cfquery name="getRoles" datasource="#variables.dsn#">
			SELECT 	*
			FROM	Roles
		</cfquery>
		
		<cfreturn getRoles >		
	</cffunction>
	
	<!---
		getSection
		Used in:
			admin/SectionDetail.cfm
	--->
	<cffunction name="getSection" access="public">
		<cfargument name="SectionID" type="numeric" required="yes">
		
		<cfquery name="getSection" datasource="#variables.dsn#">
			SELECT	*
			FROM	Sections
			WHERE	SectionID = #arguments.SectionID#
		</cfquery>
		
		<cfreturn getSection >		
	</cffunction>
	
	<!---
		getSections
		Used in:
			admin/SectionAdd.cfm
			admin/SectionList.cfm
	--->
	<cffunction name="getSections" access="public">

		<cfquery name="getSections" datasource="#variables.dsn#" cachedwithin="#CreateTimeSpan(0,0,2,0)#">
			SELECT 		*
			FROM		Sections
			ORDER BY 	DisplayOrder, SecName
		</cfquery>
		
		<cfreturn getSections >
	</cffunction>
	
	<!---
		getShippingCos
		Used in:
			admin/Application.cfm
			admin/Config-ShipByCalc.cfm
	--->
	<cffunction name="getShippingCos" access="public">
		<cfargument name="SiteID" type="numeric" required="yes">
		
		<cfquery name="getShippingCos" datasource="#variables.dsn#">
			SELECT	*
			FROM	ShippingCompanies
			WHERE	SCID = #arguments.SiteID#
		</cfquery>
		
		<cfreturn getShippingCos >		
	</cffunction>
	
	<!---
		getShippingMethod
		Used in:
			admin/BackOrdersConfirm.cfm
			admin/DistOrdersSend.cfm
			admin/DistributorEmail.cfm
			admin/OrderEmail.cfm
			admin/OrderPrint.cfm
	--->
	<cffunction name="getShippingMethod" access="public">
		<cfargument name="ShippingCode" type="string" required="yes">
		
		<cfquery name="getShippingMethod" datasource="#variables.dsn#">
			SELECT	*
			FROM	ShippingMethods
			WHERE	ShippingCode = '#arguments.ShippingCode#'
		</cfquery>
		
		<cfreturn getShippingMethod >		
	</cffunction>
	
	<!---
		getShippingMethods
		Used in:
			admin/Config-ShipByCalc.cfm
			admin/DiscountAdd.cfm
			admin/DiscountDetail.cfm
			admin/OrderAdd.cfm
			admin/OrderDetail.cfm
	--->
	<cffunction name="getShippingMethods" access="public">
		
		<cfquery name="getShippingMethods" datasource="#variables.dsn#" cachedwithin="#CreateTimeSpan(0,0,0,0)#">
			SELECT	*
			FROM	ShippingMethods
			WHERE	Allow = 1
		</cfquery>
		
		<cfreturn getShippingMethods >		
	</cffunction>
	
	<!---
		getSites
		Used in:
			A LOT
	--->
	<cffunction name="getSites" access="public">
		
		<cfquery name="getSites" datasource="#variables.dsn#" cachedwithin="#CreateTimeSpan(0,0,2,0)#">
			SELECT		SiteID, convert(varchar, SiteID) + ': ' + StoreNameShort AS SiteName
			FROM		Config
			ORDER BY	SiteID
		</cfquery>
		
		<cfreturn getSites >		
	</cffunction>
	
	<!---
		getSKUs
		Used in:
			A LOT
	--->
	<cffunction name="getSKUs" access="public">
		
		<cfquery name="getSKUs" datasource="#variables.dsn#" cachedwithin="#CreateTimeSpan(0,0,2,0)#">
			SELECT		ItemID, SKU, ItemName, SKU + ': ' + ItemName AS SKUItemName
			FROM		Products
			ORDER BY	SKU
		</cfquery>
		
		<cfreturn getSKUs >		
	</cffunction>
	
	<!---
		getStates
		Used in:
			A LOT
	--->
	<cffunction name="getStates" access="public">
		
		<cfquery name="getStates" datasource="#variables.dsn#" cachedwithin="#CreateTimeSpan(0,0,2,0)#">
			SELECT		*
			FROM		States
		</cfquery>
		
		<cfreturn getStates >		
	</cffunction>
	
	<!---
		getUSAePay
		Used in:
			admin/Config-PaymentSystem.cfm
			admin/OrderComplete.cfm
	--->
	<cffunction name="getUSAePay" access="public">
		<cfargument name="SiteID" type="numeric" required="yes">
		
		<cfquery name="getUSAePay" datasource="#variables.dsn#">
			SELECT	*
			FROM	USAePay
			WHERE	ID = #arguments.SiteID#
		</cfquery>
		
		<cfreturn getUSAePay >		
	</cffunction>
	
	<!---
		getUser
		Used in:
			admin/PrintPrices.cfm
			admin/PrintPricesOLD.cfm
	--->
	<cffunction name="getUser" access="public">
		<cfargument name="UID" type="numeric" required="yes">
		
		<cfquery name="getUser" datasource="#variables.dsn#">
			SELECT	*
			FROM	Users
			WHERE	UID = #arguments.UID#
		</cfquery>
		
		<cfreturn getUser >		
	</cffunction>
	
	<!---
		getUsers
		Used in:
			A LOT
	--->
	<cffunction name="getUsers" access="public">
		
		<cfquery name="getUsers" datasource="#variables.dsn#">
			SELECT	*
			FROM	Users
		</cfquery>
		
		<cfreturn getUsers >		
	</cffunction>
	
	<!---
		insertCustomer
		Used in:
			admin/OrderAdd.cfm
	--->
	<cffunction name="insertCustomer" access="public">
		<cfargument name="CustomerID" type="string" required="no"> 
		<cfargument name="FirstName" type="string" required="no"> 
		<cfargument name="LastName" type="string" required="no"> 
		<cfargument name="CompanyName" type="string" required="no"> 
		<cfargument name="Address1" type="string" required="no"> 
		<cfargument name="Address2" type="string" required="no"> 
		<cfargument name="City" type="string" required="no"> 
		<cfargument name="State" type="string" required="no"> 
		<cfargument name="Zip" type="string" required="no"> 
		<cfargument name="Country" type="string" required="no"> 
		<cfargument name="ShipFirstName" type="string" required="no"> 
		<cfargument name="ShipLastName" type="string" required="no"> 
		<cfargument name="ShipCompanyName" type="string" required="no"> 
		<cfargument name="ShipAddress1" type="string" required="no"> 
		<cfargument name="ShipAddress2" type="string" required="no"> 
		<cfargument name="ShipCity" type="string" required="no"> 
		<cfargument name="ShipState" type="string" required="no"> 
		<cfargument name="ShipZip" type="string" required="no"> 
		<cfargument name="ShipCountry" type="string" required="no"> 
		<cfargument name="Phone" type="string" required="no"> 
		<cfargument name="Fax" type="string" required="no"> 
		<cfargument name="DateUpdated" type="date" required="no"> 
		<cfargument name="UpdatedBy" type="string" required="no">
		<cfargument name="CardName" type="string" required="no"> 
		<cfargument name="CardNum" type="string" required="no"> 
		<cfargument name="ExpDate" type="string" required="no"> 
		<cfargument name="CardCVV" type="string" required="no">
		<cfargument name="PriceToUse" type="numeric" required="no">
		
		<cfquery name="insertCustomer" datasource="#variables.dsn#">
			INSERT INTO	Customers
					( 
					CustomerID, 
					FirstName, 
					LastName, 
					CompanyName, 
					Address1, 
					Address2, 
					City, 
					State, 
					Zip, 
					Country, 
					ShipFirstName, 
					ShipLastName, 
					ShipCompanyName, 
					ShipAddress1, 
					ShipAddress2, 
					ShipCity, 
					ShipState, 
					ShipZip, 
					ShipCountry, 
					Phone, 
					Fax, 
					DateUpdated, 
					UpdatedBy,
					CardName, 
					CardNum, 
					ExpDate, 
					CardCVV,
					PriceToUse 
					)
			VALUES	( 
					'#arguments.CustomerID#', 
					'#arguments.FirstName#', 
					'#arguments.LastName#', 
					'#arguments.CompanyName#', 
					'#arguments.Address1#', 
					'#arguments.Address2#', 
					'#arguments.City#', 
					'#arguments.State#', 
					'#arguments.Zip#', 
					'#arguments.Country#', 
					'#arguments.ShipFirstName#', 
					'#arguments.ShipLastName#', 
					'#arguments.ShipCompanyName#', 
					'#arguments.ShipAddress1#', 
					'#arguments.ShipAddress2#', 
					'#arguments.ShipCity#', 
					'#arguments.ShipState#', 
					'#arguments.ShipZip#', 
					'#arguments.ShipCountry#', 
					'#arguments.Phone#', 
					'#arguments.Fax#', 
					#arguments.DateUpdated#, 
					'#arguments.UpdatedBy#',
					'#arguments.CardName#', 
					'#arguments.CardNum#', 
					'#arguments.ExpDate#', 
					'#arguments.CardCVV#',
					#arguments.PriceToUse#
					)
		</cfquery>
				
	</cffunction>
	
	<!---
		insertOrder
		Used in:
			admin/OrderAdd.cfm
	--->
	<cffunction name="insertOrder" access="public">
		<cfargument name="SiteID" type="numeric" required="no">
		<cfargument name="OrderID" type="numeric" required="no">
		<cfargument name="CustomerID" type="string" required="no">
		<cfargument name="OrderStatus" type="string" required="no"> 
		<cfargument name="BillingStatus" type="string" required="no"> 
		<cfargument name="ShipDate" required="no" default=""> 
		<cfargument name="Phone" type="string" required="no" default=""> 
		<cfargument name="DateUpdated" type="date" required="no"> 
		<cfargument name="UpdatedBy" type="string" required="no"> 
		<cfargument name="oShipFirstName" type="string" required="no" default=""> 
		<cfargument name="oShipLastName" type="string" required="no" default=""> 
		<cfargument name="oShipCompanyName" type="string" required="no" default=""> 
		<cfargument name="oShipAddress1" type="string" required="no" default=""> 
		<cfargument name="oShipAddress2" type="string" required="no" default=""> 
		<cfargument name="oShipCity" type="string" required="no" default=""> 
		<cfargument name="oShipState" type="string" required="no" default=""> 
		<cfargument name="oShipZip" type="string" required="no" default=""> 
		<cfargument name="oShipCountry" type="string" required="no" default=""> 
		<cfargument name="CCName" type="string" required="no" default=""> 
		<cfargument name="CCNum" type="string" required="no" default=""> 
		<cfargument name="CCExpDate" type="string" required="no" default=""> 
		<cfargument name="CCCVV" type="string" required="no" default="">
		<cfargument name="PaymentVerified" type="boolean" required="no" default="0">
		<cfargument name="CustomerComments" type="string" required="no" default=""> 
		<cfargument name="Comments" type="string" required="no" default=""> 
		<cfargument name="ShippingMethod" type="string" required="no" default="Default"> 
		<cfargument name="TrackingNumber" type="string" required="no" default="">
		<cfargument name="FormOfPayment" type="numeric" required="no">
		<cfargument name="IPAddress" type="string" required="no" default="">
		
		<cfquery name="insertOrder" datasource="#variables.dsn#">
			INSERT INTO	Orders
					( 
					SiteID,
					OrderID,
					CustomerID,
					OrderStatus, 
					BillingStatus, 
					ShipDate, 
					Phone, 
					DateUpdated, 
					UpdatedBy,
					OShipFirstName, 
					OShipLastName, 
					OShipCompanyName, 
					OShipAddress1, 
					OShipAddress2, 
					OShipCity, 
					OShipState, 
					OShipZip, 
					OShipCountry,
					CCName, 
					CCNum, 
					CCExpDate, 
					CCCVV,
					PaymentVerified, 
					CustomerComments, 
					Comments, 
					ShippingMethod, 
					TrackingNumber,
					FormOfPayment,
					IPAddress
					)
			VALUES	( 
					#arguments.SiteID#,
					#arguments.OrderID#,
					'#arguments.CustomerID#',
					'#arguments.OrderStatus#', 
					'#arguments.BillingStatus#', 
					'#arguments.ShipDate#', 
					'#arguments.Phone#', 
					'#arguments.DateUpdated#', 
					'#arguments.UpdatedBy#', 
					'#arguments.oShipFirstName#', 
					'#arguments.oShipLastName#', 
					'#arguments.oShipCompanyName#', 
					'#arguments.oShipAddress1#', 
					'#arguments.oShipAddress2#', 
					'#arguments.oShipCity#', 
					'#arguments.oShipState#', 
					'#arguments.oShipZip#', 
					'#arguments.oShipCountry#', 
					'#arguments.CCName#', 
					'#arguments.CCNum#', 
					'#arguments.CCExpDate#', 
					'#arguments.CCCVV#',
					#arguments.PaymentVerified#,
					'#arguments.CustomerComments#', 
					'#arguments.Comments#', 
					'#arguments.ShippingMethod#', 
					'#arguments.TrackingNumber#',
					#arguments.FormOfPayment#,
					'#arguments.IPAddress#'
					)
		</cfquery>
				
	</cffunction>
	
</cfcomponent>



