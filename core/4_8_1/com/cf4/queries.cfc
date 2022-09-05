<!--- 
|| LEGAL ||
$CartFusion - Copyright � 2001-2007 Trade Studios, LLC.$
$This copyright notice MUST stay intact for use (see license.txt).$
$It is against the law to copy, distribute, gift, bundle or give away this code$
$without written consent from Trade Studios, LLC.$

|| VERSION CONTROL ||
$Id: $
$Date: $
$Revision: $

|| DESCRIPTION || 
$Description: $
$TODO: $

|| DEVELOPER ||
$Developer: Trade Studios, LLC (webmaster@tradestudios.com)$

|| SUPPORT ||
$Support Email: support@tradestudios.com$
$Support Website: http://support.tradestudios.com$

|| ATTRIBUTES ||
$in: $
$out:$
--->

<cfcomponent displayname="Queries Module" hint="This component handles the DB queries throughout a CartFusion site.">
	
	<cfscript>
		variables.dsn = "";
	</cfscript>
	
	<cffunction name="init" returntype="Queries" output="false">
		<cfargument name="dsn" required="true">
	
		<cfscript>
			variables.dsn = arguments.dsn;
		</cfscript>
		
		<cfreturn this />
	</cffunction>
	
	
	
	<!---
		addProductReview
		Used in:
			Includes/ProductReviewAdd.cfm
	--->
	<cffunction name="addProductReview" access="public">
		<cfargument name="ItemID" type="numeric" required="yes">
		<cfargument name="Rating" type="numeric" required="yes">
		<cfargument name="Review" type="string" required="yes">

		<cfquery name="addProductReview" datasource="#variables.dsn#">
			INSERT INTO	ProductReviews
					( ItemID, Rating, Review )
			VALUES	( #arguments.ItemID#, '#arguments.Rating#', '#arguments.Review#' )
		</cfquery>
		
	</cffunction>
	
	<!---
		expireDiscountID
		Used in:
			CO-PlaceOrder.cfm
	--->
	<cffunction name="expireDiscountID" access="public">
		<cfargument name="DiscountID" type="numeric" required="yes">

		<cfquery name="expireDiscountID" datasource="#variables.dsn#">
			UPDATE	Discounts
			SET		Expired = 1
			WHERE	DiscountID = #arguments.DiscountID#
		</cfquery>
		
	</cffunction>
	
	<!---
		getAffiliate
		Used in:
			AF-LoginCheck.cfm
			AF-Main.cfm
			AF-Update.cfm
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
			AF-Signup.cfm
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
			CO-Payment.cfm
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
			CO-Payment.cfm
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
		getBackOrders
		Used in:
			CA-OrderDetail.cfm
			OrderForm.cfm
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
			CA-CustomerArea.cfm
	--->
	<cffunction name="getBillingStatusCode" access="public">
		<cfargument name="StatusCode" type="string" required="yes">
		
		<cfquery name="getBillingStatusCode" datasource="#variables.dsn#">
			SELECT	*
			FROM	BillingStatusCodes
			WHERE	StatusCode = '#arguments.StatusCode#'
		</cfquery>
		
		<cfreturn getBillingStatusCode >		
	</cffunction>
	
	<!---
		getCountries
		Used in:
			A LOT
	--->
	<cffunction name="getCountries" access="public">

		<cfquery name="getCountries" datasource="#variables.dsn#" cachedwithin="#CreateTimeSpan(7,0,0,0)#">
			SELECT		*
			FROM		Countries
			ORDER BY 	Country
		</cfquery>
		
		<cfreturn getCountries >
	</cffunction>
	
	<!---
		getCountry
		Used in:
			AboutUs.cfm
			ContactUs.cfm
			Includes/ShippingUSPS.cfm
	--->
	<cffunction name="getCountry" access="public">
		<cfargument name="CountryCode" type="string" required="yes">
		
		<cfquery name="getCountry" datasource="#variables.dsn#">
			SELECT 	*
			FROM	Countries
			WHERE	CountryCode = '#arguments.CountryCode#'
		</cfquery>
		
		<cfreturn getCountry >		
	</cffunction>
	
	<!---
		getCustomer
		Used in:
			CA-CustomerArea.cfm
			CA-CustomerUpdate.cfm
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
		getFeaturedProducts
		Used in:
			LayoutLeftBrowser.cfm
	--->
	<cffunction name="getFeaturedProducts" access="public">
		<cfargument name="SiteID" type="numeric" required="yes">
		<cfargument name="Price" type="string" required="yes">
		
		<cfquery name="getFeaturedProducts" datasource="#variables.dsn#">
			SELECT	ItemID, SKU, ItemName, ShortDescription, ImageSmall, ImageDir, #arguments.Price#
			FROM	Products
			WHERE	Featured = 1
			AND		SiteID = #arguments.SiteID#
			ORDER BY DisplayOrder, SKU
		</cfquery>
		
		<cfreturn getFeaturedProducts >		
	</cffunction>
	
	<!---
		getItemClass
		Used in:
			Includes/ProductDetailDisplay.cfm
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
		getLastOrderID
		Used in:
			CO-PlaceOrder.cfm
	--->
	<cffunction name="getLastOrderID" access="public">
		
		<cfquery name="getLastOrderID" datasource="#variables.dsn#">
			SELECT 	MAX(OrderID) as LastOrderID
			FROM	Orders
		</cfquery>
		
		<cfreturn getLastOrderID >
	</cffunction>
	
	<!---
		getOrder
		Used in:
			CA-OrderDetail.cfm
			OrderForm.cfm
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
			EmailOrder.cfm
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
			CA-OrderDetail.cfm
			OrderForm.cfm
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
			OrderForm.cfm
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
		getOrdersAF
		Used in:
			AF-Main.cfm
	--->
	<cffunction name="getOrdersAF" access="public">
		<cfargument name="AffiliateID" type="numeric" required="yes">
		
		<cfquery name="getOrdersAF" datasource="#variables.dsn#">
			SELECT		OrderID, BillingStatus, DateEntered AS OrderDate, DiscountTotal, CreditApplied, 
						AffiliatePaid, AffiliateTotal
			FROM 		Orders
			WHERE 		AffiliateID = #arguments.AffiliateID#
			ORDER BY 	DateEntered DESC
		</cfquery>
		
		<cfreturn getOrdersAF >
	</cffunction>
	
	<!---
		getOrdersCA
		Used in:
			CA-CustomerArea.cfm
	--->
	<cffunction name="getOrdersCA" access="public">
		<cfargument name="CustomerID" type="string" required="yes">
		
		<cfquery name="getOrdersCA" datasource="#variables.dsn#">
			SELECT 		OrderID, BillingStatus, OrderStatus, ShipDate, DateEntered AS OrderDate
			FROM 		Orders
			WHERE 		CustomerID = '#arguments.CustomerID#'
			ORDER BY 	DateEntered DESC
		</cfquery>
		
		<cfreturn getOrdersCA >
	</cffunction>
	
	<!---
		getOrderDistSend
		Used in:
			EmailOrder.cfm
	--->
	<cffunction name="getOrderDistSend" access="public">
		<cfargument name="DistributorID" type="numeric" required="yes">
		<cfargument name="OrderID" type="numeric" required="yes">
		
		<cfquery name="getOrderDistSend" datasource="#variables.dsn#">
			SELECT	oi.OrderItemsID, oi.OrderID, oi.ItemID, oi.Qty, oi.DateEntered, oi.StatusCode,
					oi.OptionName1, oi.OptionName2, oi.OptionName3,
					p.SKU, p.ItemName,
					(
					SELECT	CustomerID
					FROM	Orders
					WHERE	OrderID = oi.OrderID
					) AS CustomerID
			FROM	OrderItems oi, Products p
			WHERE	p.DistributorID = #arguments.DistributorID#
			AND		(
					oi.StatusCode = 'OD' OR
					oi.StatusCode = 'BO'
					)
			AND		oi.ItemID = p.ItemID
			AND		oi.OrderID = #arguments.OrderID#
			ORDER BY 	oi.OrderID DESC, SKU ASC
		</cfquery>
		
		<cfreturn getOrderDistSend >
	</cffunction>
	
	<!---
		getOrderStatusCode
		Used in:
			CA-CustomerArea.cfm
			CA-OrderDetail.cfm
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
		getOrderTotal
		Used in:
			AF-Main.cfm
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
		getPaymentType
		Used in:
			OrderForm.cfm
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
			Includes/CO-CreditCard.cfm
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
		getProduct
		Used in:
			Includes/ProductReviewAdd.cfm
			Includes/ProductReviewDetail.cfm
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
			ProductDetail.cfm
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
			ProductDetail.cfm
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
			ProductDetail.cfm
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
	
	<!--- Product Options 4-10, if needed 
	<!---
		getProductOptions4
		Used in:
			ProductDetail.cfm
	--->
	<cffunction name="getProductOptions4" access="public">
		<cfargument name="ItemID" type="numeric" required="yes">
		
		<cfquery name="getProductOptions4" datasource="#variables.dsn#">
			SELECT 	*
			FROM	ProductOptions
			WHERE	ItemID = #arguments.ItemID#
			AND		OptionColumn = 4
			AND		(Hide = 0 OR Hide IS NULL)
		</cfquery>
		
		<cfreturn getProductOptions4 >		
	</cffunction>
	
	<!---
		getProductOptions5
		Used in:
			ProductDetail.cfm
	--->
	<cffunction name="getProductOptions5" access="public">
		<cfargument name="ItemID" type="numeric" required="yes">
		
		<cfquery name="getProductOptions5" datasource="#variables.dsn#">
			SELECT 	*
			FROM	ProductOptions
			WHERE	ItemID = #arguments.ItemID#
			AND		OptionColumn = 5
			AND		(Hide = 0 OR Hide IS NULL)
		</cfquery>
		
		<cfreturn getProductOptions5 >		
	</cffunction>
	
	<!---
		getProductOptions6
		Used in:
			ProductDetail.cfm
	--->
	<cffunction name="getProductOptions6" access="public">
		<cfargument name="ItemID" type="numeric" required="yes">
		
		<cfquery name="getProductOptions6" datasource="#variables.dsn#">
			SELECT 	*
			FROM	ProductOptions
			WHERE	ItemID = #arguments.ItemID#
			AND		OptionColumn = 6
			AND		(Hide = 0 OR Hide IS NULL)
		</cfquery>
		
		<cfreturn getProductOptions6 >		
	</cffunction>

	<!---
		getProductOptions7
		Used in:
			ProductDetail.cfm
	--->
	<cffunction name="getProductOptions7" access="public">
		<cfargument name="ItemID" type="numeric" required="yes">
		
		<cfquery name="getProductOptions7" datasource="#variables.dsn#">
			SELECT 	*
			FROM	ProductOptions
			WHERE	ItemID = #arguments.ItemID#
			AND		OptionColumn = 7
			AND		(Hide = 0 OR Hide IS NULL)
		</cfquery>
		
		<cfreturn getProductOptions7 >		
	</cffunction>
	
	<!---
		getProductOptions8
		Used in:
			ProductDetail.cfm
	--->
	<cffunction name="getProductOptions8" access="public">
		<cfargument name="ItemID" type="numeric" required="yes">
		
		<cfquery name="getProductOptions8" datasource="#variables.dsn#">
			SELECT 	*
			FROM	ProductOptions
			WHERE	ItemID = #arguments.ItemID#
			AND		OptionColumn = 8
			AND		(Hide = 0 OR Hide IS NULL)
		</cfquery>
		
		<cfreturn getProductOptions8 >		
	</cffunction>
	
	<!---
		getProductOptions9
		Used in:
			ProductDetail.cfm
	--->
	<cffunction name="getProductOptions9" access="public">
		<cfargument name="ItemID" type="numeric" required="yes">
		
		<cfquery name="getProductOptions9" datasource="#variables.dsn#">
			SELECT 	*
			FROM	ProductOptions
			WHERE	ItemID = #arguments.ItemID#
			AND		OptionColumn = 9
			AND		(Hide = 0 OR Hide IS NULL)
		</cfquery>
		
		<cfreturn getProductOptions9 >		
	</cffunction>

	<!---
		getProductOptions10
		Used in:
			ProductDetail.cfm
	--->
	<cffunction name="getProductOptions10" access="public">
		<cfargument name="ItemID" type="numeric" required="yes">
		
		<cfquery name="getProductOptions103" datasource="#variables.dsn#">
			SELECT 	*
			FROM	ProductOptions
			WHERE	ItemID = #arguments.ItemID#
			AND		OptionColumn = 10
			AND		(Hide = 0 OR Hide IS NULL)
		</cfquery>
		
		<cfreturn getProductOptions10 >		
	</cffunction>
	--->
	
	<!---
		getProductOptionsCount
		Used in:
			Includes/ProductListDisplay.cfm
			Includes/ProductRelated.cfm
	--->
	<cffunction name="getProductOptionsCount" access="public">
		<cfargument name="ItemID" type="numeric" required="yes">
		
		<cfquery name="getProductOptionsCount" datasource="#variables.dsn#">
			SELECT 	COUNT(*) AS POCount
			FROM	ProductOptions
			WHERE	ItemID = #arguments.ItemID#
		</cfquery>
		
		<cfreturn getProductOptionsCount >		
	</cffunction>
	
	<!---
		getProductReviews
		Used in:
			Includes/ProductReviewDetail.cfm
	--->
	<cffunction name="getProductReviews" access="public">
		<cfargument name="ItemID" type="numeric" required="yes">
		
		<cfquery name="getProductReviews" datasource="#variables.dsn#">
			SELECT 		Review, Rating, 
						( SELECT avg(convert(float, Rating)) FROM ProductReviews WHERE ItemID = #arguments.ItemID# ) AS AvgRating
			FROM		ProductReviews
			WHERE		ItemID = #arguments.ItemID#
			ORDER BY	DateCreated DESC
		</cfquery>
		
		<cfreturn getProductReviews >		
	</cffunction>
	
	<!---
		getProductReviewsFive
		Used in:
			Includes/ProductReviews.cfm
	--->
	<cffunction name="getProductReviewsFive" access="public">
		<cfargument name="ItemID" type="numeric" required="yes">
		
		<cfquery name="getProductReviewsFive" datasource="#variables.dsn#">
			SELECT 		TOP 5 Review, Rating, 
						( SELECT avg(convert(float, Rating)) FROM ProductReviews WHERE ItemID = #arguments.ItemID# ) AS AvgRating
			FROM		ProductReviews
			WHERE		ItemID = #arguments.ItemID#
			ORDER BY	DateCreated DESC
		</cfquery>
		
		<cfreturn getProductReviewsFive >		
	</cffunction>
	
	<!---
		getProductSpecs
		Used in:
			Compare.cfm
	--->
	<cffunction name="getProductSpecs" access="public">
		<cfargument name="ItemID" type="numeric" required="yes">
		
		<cfquery name="getProductSpecs" datasource="#variables.dsn#">
			SELECT 	*
			FROM	ProductSpecs
			WHERE	ItemID = #arguments.ItemID#
		</cfquery>
		
		<cfreturn getProductSpecs >		
	</cffunction>
	
	<!---
		getProductType
		Used in:
			Compare.cfm
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
		getShippingCos
		Used in:
			Includes/CalculateShipping.cfm
			Includes/CO-OptionsShipping.cfm
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
			CA-OrderDetail.cfm
			OrderForm.cfm
			EmailOrder.cfm
			Includes/CO-InfoThusFar.cfm
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
			Includes/CO-OptionsShipping.cfm
	--->
	<cffunction name="getShippingMethods" access="public">
		
		<cfquery name="getShippingMethods" datasource="#variables.dsn#">
			SELECT	*
			FROM	ShippingMethods
			WHERE	Allow = 1
		</cfquery>
		
		<cfreturn getShippingMethods >		
	</cffunction>
	
	<!---
		getSites
		Used in:
			Includes/DDLCat.cfm
			Includes/DDLSec.cfm
	--->
	<cffunction name="getSites" access="public">
		
		<cfquery name="getSites" datasource="#variables.dsn#" cachedwithin="#CreateTimeSpan(7,0,0,0)#">
			SELECT		SiteID, convert(varchar, SiteID) + ': ' + StoreNameShort AS SiteName
			FROM		Config
			ORDER BY	SiteID
		</cfquery>
		
		<cfreturn getSites >		
	</cffunction>
	
	<!---
		getStates
		Used in:
			AF-SignUp.cfm
			AF-Update.cfm
			CA-CustomerUpdate.cfm
			CO-Billing.cfm
	--->
	<cffunction name="getStates" access="public">
		
		<cfquery name="getStates" datasource="#variables.dsn#" cachedwithin="#CreateTimeSpan(7,0,0,0)#">
			SELECT		*
			FROM		States
		</cfquery>
		
		<cfreturn getStates >		
	</cffunction>
	
</cfcomponent>



