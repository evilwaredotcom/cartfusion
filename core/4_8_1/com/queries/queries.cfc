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
		<cfargument name="ItemID" type="numeric" required="true">
		<cfargument name="Rating" type="numeric" required="true">
		<cfargument name="Review" type="string" required="true">
		
		<cfscript>
			var addProductReview = "";
		</cfscript>
		
		<cfquery name="addProductReview" datasource="#variables.dsn#">
			INSERT INTO	ProductReviews
				( ItemID, Rating, Review )
			VALUES	
				( <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ItemID#">, 
				<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.Rating#">, 
				<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#arguments.Review#"> )
		</cfquery>
		
	</cffunction>
	
	<!---
		expireDiscountID
		Used in:
			CO-PlaceOrder.cfm
	--->
	<cffunction name="expireDiscountID" access="public">
		<cfargument name="DiscountID" type="numeric" required="true">
		
		<cfscript>
			var expireDiscountID = "";
		</cfscript>
		
		<cfquery name="expireDiscountID" datasource="#variables.dsn#">
			UPDATE	Discounts
			SET		Expired = <cfqueryparam cfsqltype="cf_sql_bit" value="1">
			WHERE	DiscountID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.DiscountID#">
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
		<cfargument name="AFID" type="numeric" required="true">
		
		<cfscript>
			var getAffiliate = "";
		</cfscript>
		
		<cfquery name="getAffiliate" datasource="#variables.dsn#">
			SELECT 	*
			FROM 	Affiliates
			WHERE	AFID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.AFID#">
		</cfquery>
		
		<cfreturn getAffiliate >
	</cffunction>
	
	<!--- 
		Added By Carl Vanderpal 
		joint with getAffiiate later on
	--->
	<cffunction name="getAffiliateInfo" access="public" hint="Checks to see if person is an affilaite">
		<cfargument name="afid" required="false">
		<cfargument name="email" required="true">
		
		<cfscript>
			var getAffiliateInfo = "";
		</cfscript>
	
	
		<cfquery name="getAffiliateInfo" datasource="#variables.dsn#">
			SELECT	*
			FROM	Affiliates
			WHERE	Email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.email#">
			<cfif structKeyExists(arguments, "afid")>
				AND AFID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.afid#">
			</cfif>		
		</cfquery>
	
	
		<cfreturn getAffiliateInfo>
		
	</cffunction>
	
	
	<!--- Added By Carl Vanderpal --->
	<cffunction name="authenticateAffiliate">
		<cfargument name="afid" required="true">
		<cfargument name="email" required="true">
	
		
		<cfscript>
			var authenticateAffiliate = "";
		</cfscript>
	
		<cfquery name="authenticateAffiliate" datasource="#variables.dsn#">
			UPDATE	Affiliates
			SET		Authenticated = <cfqueryparam cfsqltype="cf_sql_bit" value="1">
			WHERE	AFID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.afid#">
			AND		Email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.email#">
		</cfquery>
	
	
		<cfreturn authenticateAffiliate>
	</cffunction>
	
	
	<!---
		getAFLevel
		Used in:
			admin/RWP-AffiliatesAction.cfm
			OTHERS
	--->
	<cffunction name="getAFLevel" access="public">
		<cfargument name="CommID" type="numeric" required="true">
		
		<cfscript>
			var getAFLevel = "";
		</cfscript>
		
		<cfquery name="getAFLevel" datasource="#variables.dsn#">
			SELECT	*
			FROM	AffiliateCommissions
			WHERE 	CommID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.CommID#">
		</cfquery>
		
		<cfreturn getAFLevel >
	</cffunction>
	
	<!---
		getAFLevels
		Used in:
			AF-Signup.cfm
	--->
	<cffunction name="getAFLevels" access="public">
		
		<cfscript>
			var getAFLevels = "";
		</cfscript>
		
		<cfquery name="getAFLevels" datasource="#variables.dsn#">
			SELECT	*
			FROM	AffiliateCommissions
			ORDER BY CommID
		</cfquery>
		
		<cfreturn getAFLevels >
	</cffunction>
	
	<!--- Added By Carl Vanderpal 22 May 2007 --->
	<cffunction name="getAffiliateHistory" access="public">
		<cfargument name="afid" required="true">
		
		<cfscript>
			var getAffiliateHistory = "";
		</cfscript>
		
		<cfquery name="getAffiliateHistory" datasource="#variables.dsn#">
			SELECT	*
			FROM	AffiliateHistory
			WHERE	AFID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.AFID#">
			ORDER BY DateEntered DESC
		</cfquery>


		<cfreturn getAffiliateHistory>	
	</cffunction>
	
	<!---
		getAN
		Used in:
			CO-Payment.cfm
	--->
	<cffunction name="getAN" access="public">
		<cfargument name="SiteID" type="numeric" required="true">
		
		<cfscript>
			var getAN = "";
		</cfscript>
		
		<cfquery name="getAN" datasource="#variables.dsn#">
			SELECT	*
			FROM	AuthorizeNet
			WHERE	ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.SiteID#">
		</cfquery>
		
		<cfreturn getAN >		
	</cffunction>
	
	<!---
		getANTK
		Used in:
			CO-Payment.cfm
	--->
	<cffunction name="getANTK" access="public">
		<cfargument name="SiteID" type="numeric" required="true">
		
		<cfscript>
			var getANTK = "";
		</cfscript>
		
		<cfquery name="getANTK" datasource="#variables.dsn#">
			SELECT	*
			FROM	AuthorizeNetTK
			WHERE	ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.SiteID#">
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
		<cfargument name="OrderID" type="numeric" required="true">
		
		<cfscript>
			var getBackOrders = "";
		</cfscript>
		
		<cfquery name="getBackOrders" datasource="#variables.dsn#">
			SELECT	*
			FROM 	BackOrders
			WHERE	BOOrderID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.OrderID#">
		</cfquery>
		
		<cfreturn getBackOrders >
	</cffunction>
	
	<!---
		getBillingStatusCode
		Used in:
			CA-CustomerArea.cfm
	--->
	<cffunction name="getBillingStatusCode" access="public">
		<cfargument name="StatusCode" type="string" required="true">
		
		<cfscript>
			var getBillingStatusCode = "";
		</cfscript>
		
		<cfquery name="getBillingStatusCode" datasource="#variables.dsn#">
			SELECT	*
			FROM	BillingStatusCodes
			WHERE	StatusCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.StatusCode#">
		</cfquery>
		
		<cfreturn getBillingStatusCode >		
	</cffunction>
	
	<!---
		getCountries
		Used in:
			A LOT
	--->
	<cffunction name="getCountries" access="public">
		
		<cfscript>
			var getCountries = "";
		</cfscript>
		
		<cfquery name="getCountries" datasource="#variables.dsn#">
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
		<cfargument name="CountryCode" type="string" required="true">
		
		<cfscript>
			var getCountry = "";
		</cfscript>
		
		<cfquery name="getCountry" datasource="#variables.dsn#">
			SELECT 	*
			FROM	Countries
			WHERE	CountryCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.CountryCode#">
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
		<cfargument name="CustomerID" type="string" required="true">
		
		<cfscript>
			var getCustomer = "";
		</cfscript>
		
		<cfquery name="getCustomer" datasource="#variables.dsn#">
			SELECT	*
			FROM	Customers
			WHERE	CustomerID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.CustomerID#">
		</cfquery>
		
		<cfreturn getCustomer >		
	</cffunction>
	
	<!--- Added by Carl Vanderpal 25 May 2007 --->
	<cffunction name="getCustomerInfo" access="public">
		<cfargument name="CustUser" required="true">
		
		<cfscript>
			var getCustomerInfo = "";
		</cfscript>
	
	
	<!--- GET PASSWORD AND CUSTOMERID FOR ID CHECK --->
	<cfquery name="getCustomerInfo" datasource="#variables.dsn#">
		SELECT 	*
		FROM	Customers
		WHERE 	UserName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.CustUser#">
		AND		(Deleted = 0 OR Deleted IS NULL)
	</cfquery>
	
		<cfreturn getCustomerInfo>
	</cffunction>
	
	<!--- Get User Added by Carl Vanderpal 25 Mat 2007 --->
	<cffunction name="getUser" access="public">
		<cfargument name="UUserName" required="true">
		
		<cfscript>
			var getUser = "";
		</cfscript>
		
		<cfquery name="getUser" datasource="#variables.dsn#">
			SELECT 	*
			FROM	Users
			WHERE	UUserName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.UUserName#">
		</cfquery>
	
		<cfreturn getUser>
	</cffunction>
	
	<!--- Added by Carl Vanderpal May 24, 2007 --->
	<cffunction name="updateCustomerShipping" access="public">
		<cfargument name="ShippingID" required="true">
		<cfargument name="CartItemID" required="true">
		
		<cfscript>
			var updateCustomerSH = "";
		</cfscript>
		
		<cfquery name="updateCustomerSH" datasource="#variables.dsn#">
			UPDATE	Cart
			SET		ShippingID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ShippingID#">
			WHERE	CartItemID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.CartItemID#">
		</cfquery>
		
	</cffunction>
	
	<!--- Added by Carl Vanderpal May 24, 2007 --->
	<cffunction name="getCustomerShipping" access="public">
		<cfargument name="CustomerID" required="true">
		
		<cfscript>
			var getCustomerShipping = "";
		</cfscript>
		
		<cfquery name="getCustomerShipping" datasource="#variables.dsn#">
		SELECT	*
		FROM	CustomerSH
		WHERE	CustomerID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.CustomerID#">
	</cfquery>
	
		<cfreturn getCustomerShipping>
	</cffunction>
	
	<!--- Added by Carl Vanderpal 25 May 2007 --->
	<cffunction name="deleteCustomerShipping" access="public">
		<cfargument name="SHID" required="true">
		
		<cfscript>
			var deleteCustomerShipping = "";
		</cfscript>
		
		<cfquery name="deleteCustomerShipping" datasource="#variables.dsn#">
			DELETE 
			FROM	CustomerSH
			WHERE	SHID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.SHID#">
		</cfquery>
	
		
	</cffunction>
	
	
	
	<!---
		getFeaturedProducts
		Used in:
			LayoutLeftBrowser.cfm
	--->
	<cffunction name="getFeaturedProducts" access="public">
		<cfargument name="SiteID" type="numeric" required="true">
		<cfargument name="Price" type="string" required="true">
		
		<cfscript>
			var getFeaturedProducts = "";
		</cfscript>
		
		<cfquery name="getFeaturedProducts" datasource="#variables.dsn#">
			SELECT	ItemID, SKU, ItemName, ShortDescription, ImageSmall, ImageDir, #arguments.Price#
			FROM	Products
			WHERE	Featured = <cfqueryparam cfsqltype="cf_sql_bit" value="1">
			AND		SiteID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.SiteID#">
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
		<cfargument name="ICID" type="numeric" required="true">
		
		<cfscript>
			var getItemClass = "";
		</cfscript>
		
		<cfquery name="getItemClass" datasource="#variables.dsn#">
			SELECT	*
			FROM	ItemClasses
			WHERE	ICID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ICID#">
		</cfquery>
		
		<cfreturn getItemClass >
	</cffunction>
	
	<!---
		getLastOrderID
		Used in:
			CO-PlaceOrder.cfm
	--->
	<cffunction name="getLastOrderID" access="public">
		
		<cfscript>
			var getLastOrderID = "";
		</cfscript>
		
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
		<cfargument name="OrderID" type="numeric" required="true">
		
		<cfscript>
			var getOrder = "";
		</cfscript>
		
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
			AND		o.OrderID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.OrderID#">
		</cfquery>
		
		<cfreturn getOrder >
	</cffunction>
	
	<!---
		getOrderInfo
		Used in:
			EmailOrder.cfm
	--->
	<cffunction name="getOrderInfo" access="public">
		<cfargument name="OrderID" type="numeric" required="true">
		
		<cfscript>
			var getOrderInfo = "";
		</cfscript>
		
		<cfquery name="getOrderInfo" datasource="#variables.dsn#">
			SELECT	o.OrderID, o.Phone AS OrderPhone, o.DateEntered, o.oShipFirstName, o.oShipLastName, o.oShipCompanyName, 
					o.oShipAddress1, o.oShipAddress2, o.oShipCity, o.oShipState, o.oShipZip, o.oShipCountry, o.ShippingMethod
			FROM	Orders o
			WHERE	o.OrderID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.OrderID#">
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
		<cfargument name="OrderID" type="numeric" required="true">
		
		<cfscript>
			var getOrderItems = "";
		</cfscript>
		
		<cfquery name="getOrderItems" datasource="#variables.dsn#">
			SELECT	oi.OrderItemsID, oi.Qty, oi.ItemPrice, oi.StatusCode, oi.OptionName1, oi.OptionName2, oi.OptionName3, 
					oi.DateEntered AS OrderItemDate, oi.OITrackingNumber,
					p.ItemID, p.SKU, p.ItemName
			FROM	OrderItems oi, Products p
			WHERE	oi.OrderID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.OrderID#">
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
		<cfargument name="StatusCode" type="string" required="true">
		
		<cfscript>
			var getOrderItemsStatusCode = "";
		</cfscript>
		
		<cfquery name="getOrderItemsStatusCode" datasource="#variables.dsn#">
			SELECT	StatusMessage
			FROM	OrderItemsStatusCodes
			WHERE	StatusCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.StatusCode#">
		</cfquery>
		
		<cfreturn getOrderItemsStatusCode >
	</cffunction>
	
	<!---
		getOrdersAF
		Used in:
			AF-Main.cfm
	--->
	<cffunction name="getOrdersAF" access="public">
		<cfargument name="AffiliateID" type="numeric" required="true">
		
		<cfscript>
			var getOrdersAF = "";
		</cfscript>
		
		<cfquery name="getOrdersAF" datasource="#variables.dsn#">
			SELECT		OrderID, BillingStatus, DateEntered AS OrderDate, DiscountTotal, CreditApplied, 
						AffiliatePaid, AffiliateTotal
			FROM 		Orders
			WHERE 		AffiliateID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.AffiliateID#">
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
		<cfargument name="CustomerID" type="string" required="true">
		
		<cfscript>
			var getOrdersCA = "";
		</cfscript>
		
		<cfquery name="getOrdersCA" datasource="#variables.dsn#">
			SELECT 		OrderID, BillingStatus, OrderStatus, ShipDate, DateEntered AS OrderDate
			FROM 		Orders
			WHERE 		CustomerID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.CustomerID#">
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
		<cfargument name="DistributorID" type="numeric" required="true">
		<cfargument name="OrderID" type="numeric" required="true">
		
		<cfscript>
			var getOrderDistSend = "";
		</cfscript>
		
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
			WHERE	p.DistributorID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.DistributorID#">
			AND		(
					oi.StatusCode = 'OD' OR
					oi.StatusCode = 'BO'
					)
			AND		oi.ItemID = p.ItemID
			AND		oi.OrderID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.OrderID#">
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
		<cfargument name="StatusCode" type="string" required="true">
		
		<cfscript>
			var getOrderStatusCode = "";
		</cfscript>
		
		<cfquery name="getOrderStatusCode" datasource="#variables.dsn#">
			SELECT	StatusMessage
			FROM	OrderStatusCodes
			WHERE	StatusCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.StatusCode#">
		</cfquery>
		
		<cfreturn getOrderStatusCode >
	</cffunction>
	
	<!---
		getOrderTotal
		Used in:
			AF-Main.cfm
	--->
	<cffunction name="getOrderTotal" access="public">
		<cfargument name="OrderID" type="numeric" required="true">
		
		<cfscript>
			var getOrderTotal = "";
		</cfscript>
		
		<cfquery name="getOrderTotal" datasource="#variables.dsn#">
			SELECT	SUM( ItemPrice * Qty ) AS RunningTotal, SUM(Qty) AS Items
			FROM	OrderItems
			WHERE	OrderID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.OrderID#">
			AND		StatusCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="BO">
			AND		StatusCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="CA">
		</cfquery>
		
		<cfreturn getOrderTotal >
	</cffunction>
	
	<!---
		getPaymentsAF
		Used in:
			AF-Main.cfm
	--->
	<cffunction name="getPaymentsAF" access="public">
		<cfargument name="AFID" type="numeric" required="true">
		
		<cfscript>
			var getPaymentsAF = "";
		</cfscript>
		
		<cfquery name="getPaymentsAF" datasource="#variables.dsn#">
			SELECT	*
			FROM	AffiliatePayments
			WHERE	AFID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.AFID#">
		</cfquery>
		
		<cfreturn getPaymentsAF >
	</cffunction>
	
	<!---
		getPaymentType
		Used in:
			OrderForm.cfm
	--->
	<cffunction name="getPaymentType" access="public">
		<cfargument name="Type" type="string" required="true">
		
		<cfscript>
			var getPaymentType = "";
		</cfscript>
		
		<cfquery name="getPaymentType" datasource="#variables.dsn#">
			SELECT 	Display
			FROM	Payment	
			WHERE	Type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.Type#">
		</cfquery>
		
		<cfreturn getPaymentType >
	</cffunction>
	
	<!---
		getPaymentTypes
		Used in:
			Includes/CO-CreditCard.cfm
	--->
	<cffunction name="getPaymentTypes" access="public">
		
		<cfscript>
			var getPaymentTypes = "";
		</cfscript>
		
		<cfquery name="getPaymentTypes" datasource="#variables.dsn#">
			SELECT		*
			FROM		Payment
			WHERE		Allow = <cfqueryparam cfsqltype="cf_sql_bit" value="1">
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
		<cfargument name="ItemID" type="numeric" required="true">
		
		<cfscript>
			var getProduct = "";
		</cfscript>
		
		<cfquery name="getProduct" datasource="#variables.dsn#">
			SELECT	*
			FROM	Products
			WHERE	ItemID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ItemID#">
		</cfquery>
		
		<cfreturn getProduct >		
	</cffunction>
	
	<!---
		getProductOptions1
		Used in:
			ProductDetail.cfm
	--->
	<cffunction name="getProductOptions1" access="public">
		<cfargument name="ItemID" type="numeric" required="true">
		
		<cfscript>
			var getProductOptions1 = "";
		</cfscript>
		
		<cfquery name="getProductOptions1" datasource="#variables.dsn#">
			SELECT 	*
			FROM	ProductOptions
			WHERE	ItemID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ItemID#">
			AND		OptionColumn = <cfqueryparam cfsqltype="cf_sql_integer" value="1">
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
		<cfargument name="ItemID" type="numeric" required="true">
		
		<cfscript>
			var getProductOptions2 = "";
		</cfscript>
		
		<cfquery name="getProductOptions2" datasource="#variables.dsn#">
			SELECT 	*
			FROM	ProductOptions
			WHERE	ItemID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ItemID#">
			AND		OptionColumn = <cfqueryparam cfsqltype="cf_sql_integer" value="2">
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
		<cfargument name="ItemID" type="numeric" required="true">
		
		<cfscript>
			var getProductOptions3 = "";
		</cfscript>
		
		<cfquery name="getProductOptions3" datasource="#variables.dsn#">
			SELECT 	*
			FROM	ProductOptions
			WHERE	ItemID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ItemID#">
			AND		OptionColumn = <cfqueryparam cfsqltype="cf_sql_integer" value="3">
			AND		(Hide = 0 OR Hide IS NULL)
		</cfquery>
		
		<cfreturn getProductOptions3 >		
	</cffunction>
	
	<!--- Product Options 4-10, if needed --->
	<!---
		getProductOptions4
		Used in:
			ProductDetail.cfm
	--->
	<cffunction name="getProductOptions4" access="public">
		<cfargument name="ItemID" type="numeric" required="true">
		
		<cfquery name="getProductOptions4" datasource="#variables.dsn#">
			SELECT 	*
			FROM	ProductOptions
			WHERE	ItemID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ItemID#">
			AND		OptionColumn = <cfqueryparam cfsqltype="cf_sql_integer" value="4">
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
		<cfargument name="ItemID" type="numeric" required="true">
		
		<cfquery name="getProductOptions5" datasource="#variables.dsn#">
			SELECT 	*
			FROM	ProductOptions
			WHERE	ItemID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ItemID#">
			AND		OptionColumn = <cfqueryparam cfsqltype="cf_sql_integer" value="5">
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
		<cfargument name="ItemID" type="numeric" required="true">
		
		<cfquery name="getProductOptions6" datasource="#variables.dsn#">
			SELECT 	*
			FROM	ProductOptions
			WHERE	ItemID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ItemID#">
			AND		OptionColumn = <cfqueryparam cfsqltype="cf_sql_integer" value="6">
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
		<cfargument name="ItemID" type="numeric" required="true">
		
		<cfquery name="getProductOptions7" datasource="#variables.dsn#">
			SELECT 	*
			FROM	ProductOptions
			WHERE	ItemID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ItemID#">
			AND		OptionColumn = <cfqueryparam cfsqltype="cf_sql_integer" value="7">
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
		<cfargument name="ItemID" type="numeric" required="true">
		
		<cfquery name="getProductOptions8" datasource="#variables.dsn#">
			SELECT 	*
			FROM	ProductOptions
			WHERE	ItemID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ItemID#">
			AND		OptionColumn = <cfqueryparam cfsqltype="cf_sql_integer" value="8">
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
		<cfargument name="ItemID" type="numeric" required="true">
		
		<cfquery name="getProductOptions9" datasource="#variables.dsn#">
			SELECT 	*
			FROM	ProductOptions
			WHERE	ItemID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ItemID#">
			AND		OptionColumn = <cfqueryparam cfsqltype="cf_sql_integer" value="9">
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
		<cfargument name="ItemID" type="numeric" required="true">
		
		<cfquery name="getProductOptions103" datasource="#variables.dsn#">
			SELECT 	*
			FROM	ProductOptions
			WHERE	ItemID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ItemID#">
			AND		OptionColumn = <cfqueryparam cfsqltype="cf_sql_integer" value="10">
			AND		(Hide = 0 OR Hide IS NULL)
		</cfquery>
		
		<cfreturn getProductOptions10 >		
	</cffunction>
	
	<!---
		getProductOptionsCount
		Used in:
			Includes/ProductListDisplay.cfm
			Includes/ProductRelated.cfm
	--->
	<cffunction name="getProductOptionsCount" access="public">
		<cfargument name="ItemID" type="numeric" required="true">
		
		<cfscript>
			var getProductOptionsCount = "";
		</cfscript>
		
		<cfquery name="getProductOptionsCount" datasource="#variables.dsn#">
			SELECT 	COUNT(*) AS POCount
			FROM	ProductOptions
			WHERE	ItemID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ItemID#">
		</cfquery>
		
		<cfreturn getProductOptionsCount >		
	</cffunction>
	
	<!---
		getProductReviews
		Used in:
			Includes/ProductReviewDetail.cfm
	--->
	<cffunction name="getProductReviews" access="public">
		<cfargument name="ItemID" type="numeric" required="true">
		
		<cfscript>
			var getProductReviews = "";
		</cfscript>
		
		<cfquery name="getProductReviews" datasource="#variables.dsn#">
			SELECT 		Review, Rating, 
						( SELECT avg(convert(float, Rating)) FROM ProductReviews WHERE ItemID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ItemID#"> ) AS AvgRating
			FROM		ProductReviews
			WHERE		ItemID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ItemID#">
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
		<cfargument name="ItemID" type="numeric" required="true">
		
		<cfscript>
			var getProductReviewsFive = "";
		</cfscript>
		
		<cfquery name="getProductReviewsFive" datasource="#variables.dsn#">
			SELECT 		TOP 5 Review, Rating, 
						( SELECT avg(convert(float, Rating)) FROM ProductReviews WHERE ItemID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ItemID#"> ) AS AvgRating
			FROM		ProductReviews
			WHERE		ItemID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ItemID#">
			ORDER BY	DateCreated DESC
		</cfquery>
		
		<cfreturn getProductReviewsFive >		
	</cffunction>
	
	<!---
		getProductType
		Used in:
			Compare.cfm
	--->
	<cffunction name="getProductType" access="public">
		<cfargument name="TypeID" type="numeric" required="true">
		
		<cfscript>
			var getProductType = "";
		</cfscript>
		
		<cfquery name="getProductType" datasource="#variables.dsn#">
			SELECT 	*
			FROM	ProductTypes
			WHERE	TypeID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.TypeID#">
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
		<cfargument name="SiteID" type="numeric" required="true">
		
		<cfscript>
			var getShippingCos = "";
		</cfscript>
		
		<cfquery name="getShippingCos" datasource="#variables.dsn#">
			SELECT	*
			FROM	ShippingCompanies
			WHERE	SCID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.SiteID#">
		</cfquery>
		
		<cfreturn getShippingCos >		
	</cffunction>
	
	<!--- Added by Carl Vanderpal 18 June 2007 --->
	<cffunction name="getShippingCodes" access="public">
	
		<cfscript>
			var getShippingCodes = "";
		</cfscript>
	
	
		<!--- CARTFUSION 4.6 - SHIPPING CODES --->
		<cfquery name="getShippingCodes" datasource="#variables.dsn#" >
			SELECT	*
			FROM	ShippingCodes
		</cfquery>
		
		<cfreturn getShippingCodes>
			
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
		<cfargument name="ShippingCode" type="string" required="true">
		
		<cfscript>
			var getShippingMethod = "";
		</cfscript>
		
		<cfquery name="getShippingMethod" datasource="#variables.dsn#">
			SELECT	*
			FROM	ShippingMethods
			WHERE	ShippingCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.ShippingCode#">
		</cfquery>
		
		<cfreturn getShippingMethod >		
	</cffunction>
	
	<!---
		getShippingMethods
		Used in:
			Includes/CO-OptionsShipping.cfm
	--->
	<cffunction name="getShippingMethods" access="public">
		
		<cfscript>
			var getShippingMethods = "";
		</cfscript>
		
		<cfquery name="getShippingMethods" datasource="#variables.dsn#">
			SELECT	*
			FROM	ShippingMethods
			WHERE	Allow = <cfqueryparam cfsqltype="cf_sql_bit" value="1">
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
		
		<cfscript>
			var getSites = "";
		</cfscript>
		
		<cfquery name="getSites" datasource="#variables.dsn#">
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
		
		<cfscript>
			var getStates = "";
		</cfscript>
		
		<cfquery name="getStates" datasource="#variables.dsn#">
			SELECT		*
			FROM		States
		</cfquery>
		
		<cfreturn getStates >		
	</cffunction>
	
	<!--- Added by Carl Vanderpal 25 May 2007 --->
	<cffunction name="checkMessages" access="public" hint="Returns message for customer">
		<cfargument name="Customers" required="true">
		
		<cfscript>
			var checkMessages = "";
		</cfscript>
		
		
		<cfquery name="checkMessages" datasource="#variables.dsn#">
			SELECT 	*
			FROM 	MessageCenter
			WHERE 	Customers LIKE <cfqueryparam cfsqltype="cf_sql_longvarchar" value="%#arguments.Customers#%">
		</cfquery>
	
		<cfreturn checkMessages>
	</cffunction>
	
	<!--- Added by Carl Vanderpal 25 May 2007 --->
	<cffunction name="getStoreCredit" access="public">
		<cfargument name="CustomerID" required="true">
		
		<cfscript>
			var getStoreCredit = "";
		</cfscript>
		
		<cfquery name="getStoreCredit" datasource="#variables.dsn#">
			SELECT	Credit
			FROM	Customers
			WHERE	CustomerID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.CustomerID#">
		</cfquery>
		
		<cfreturn getStoreCredit>
	</cffunction>
	
	<!--- Added by Carl Vanderpal 20 June 2007 --->
	<cffunction name="getProductSpecs" access="public">
		<cfargument name="ItemID" required="true">
		
		<cfscript>
			var getProductSpecs = "";
		</cfscript>
	
		<cfquery name="getProductSpecs" datasource="#variables.dsn#">
			SELECT	*
			FROM	ProductSpecs
			WHERE	ItemID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ItemID#">
		</cfquery>
		
		<cfreturn getProductSpecs>
		
	</cffunction>
	
	<!--- Added by Carl Vanderpal 20 June 2007 --->
	<cffunction name="getProductTypes">
		<cfargument name="TypeID" required="true">
		
		<cfscript>
			var getProductTypes = "";
		</cfscript>
		
		<cfquery name="getProductTypes" datasource="#variables.dsn#">
			SELECT	*
			FROM	ProductTypes
			WHERE	TypeID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.TypeID#">
		</cfquery>
		
		
		<cfreturn getProductTypes>
		
	</cffunction>

</cfcomponent>
