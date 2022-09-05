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

<cfcomponent displayname="Shopping Cart Module" hint="This component handles the shopping cart of a CartFusion site.">
	
	<cfscript>
		variables.dsn = "";
	</cfscript>
	
	<cffunction name="init" returntype="Cart" output="false">
		<cfargument name="dsn" required="true">
	
		<cfscript>
			variables.dsn = arguments.dsn;
		</cfscript>
		
		<cfreturn this />
	</cffunction>
	
	<!--- 
		GET CART ITEMS
		Used in: 
	--->
	<cffunction name="getCartItems" displayname="Get Cart Items" hint="Function to retrieve all cart items information." access="public" returntype="query">
		<cfargument name="UserID" displayname="UserID" hint="The Price and Hide Columns of the Products to get, depending on User" type="numeric" required="yes">
		<cfargument name="SiteID" displayname="SiteID" hint="The CartFusion Site ID of the Products to get" type="numeric" required="yes">
		<cfargument name="SessionID" displayname="SessionID" hint="The CartFusion Session ID of the current customer linked to the cart" type="string" required="yes">
		<cfargument name="ItemID" displayname="ItemID" hint="For checking for this product in the cart" type="numeric" required="no">
		<cfargument name="CatID" displayname="Category ID" hint="For checking for a product in this category" type="numeric" required="no">
		<cfargument name="SectionID" displayname="Section ID" hint="For checking for a product in this section" type="numeric" required="no">
		<cfargument name="Qty" displayname="Quantity" hint="For Quantity Level Checking" type="numeric" required="no">

		<cfquery name="getCartItems" datasource="#application.dsn#">
			SELECT 	c.CartItemID, c.CustomerID, c.SessionID, c.ItemID, c.Qty, c.OptionName1, c.OptionName2, c.OptionName3,
					c.DateEntered, c.AffiliateID, c.BackOrdered, c.SiteID, c.ShippingID,
					p.SKU, p.ItemName, p.Weight, p.Taxable, p.ImageDir, p.ImageSmall,
					p.Price#arguments.UserID# AS PriceUsed,
					<!--- CARTFUSION 4.6 - INDIVIDUAL PRODUCT SHIPPING PRICES --->p.fldShipAmount, p.fldHandAmount, p.fldShipCode, p.fldShipWeight, 
					c.Qty * p.Price#arguments.UserID# AS CartTotalLine,
					(
						SELECT 	SUM(Qty) 
						FROM 	Cart
						WHERE 	sessionID = '#arguments.SessionID#'
						AND		SiteID = #arguments.SiteID#
					) AS GetQty
			FROM 	Cart c, Products p
			WHERE 	c.ItemID = p.ItemID
			AND		c.SiteID = #arguments.SiteID#
			AND 	c.sessionID = '#arguments.SessionID#'
			<cfif isDefined('arguments.ItemID') AND arguments.ItemID NEQ ''>
			AND		c.ItemID = #arguments.ItemID#
			</cfif>
			<cfif isDefined('arguments.Qty') AND arguments.Qty NEQ ''>
			AND		c.Qty >= #arguments.Qty#
			</cfif>
			<cfif isDefined('arguments.CatID') AND arguments.CatID NEQ ''>
			AND		p.Category IN
					(
						SELECT	CatID
						FROM	Categories
						WHERE	CatID = #arguments.CatID#
					)
			</cfif>
			<cfif isDefined('arguments.SectionID') AND arguments.SectionID NEQ ''>
			AND		p.SectionID IN
					(
						SELECT	SectionID
						FROM	Sections
						WHERE	SectionID = #arguments.SectionID#
					)
			</cfif>
			ORDER BY c.ItemID
		</cfquery>
				
		<cfreturn getCartItems >
	</cffunction>
	
	<!--- 
		GET CART TOTAL
		Used in: 
	--->
	<cffunction name="getCartTotal" displayname="Get Cart Total" hint="Function to retrieve total value of cart items." access="public" returntype="string">
		<cfargument name="UserID" displayname="UserID" hint="The Price and Hide Columns of the Products to get, depending on User" type="numeric" required="yes">
		<cfargument name="SiteID" displayname="SiteID" hint="The CartFusion Site ID of the Products to get" type="numeric" required="yes">
		<cfargument name="SessionID" displayname="SessionID" hint="The CartFusion Session ID of the current customer linked to the cart" type="string" required="yes">

		<cfquery name="getCartTotal" datasource="#application.dsn#">
			SELECT 	c.Qty * p.Price#arguments.UserID# AS CartTotalLine
			FROM 	Cart c, Products p
			WHERE 	c.ItemID = p.ItemID
			AND		c.SiteID = #arguments.SiteID#
			AND 	c.sessionID = '#arguments.SessionID#'
			ORDER BY c.ItemID
		</cfquery>
		
		<cfset CartTotal = 0 >
		<cfif getCartTotal.RecordCount NEQ 0 >
			<cfloop query="getCartTotal">
				<cfset CartTotal = CartTotal + getCartTotal.CartTotalLine >
			</cfloop>
		</cfif>
		
		<cfreturn CartTotal >
	</cffunction>
	
	
	<!--- 
		FIND PRODUCT IN CATEGORY
		Used in: 
	--->
	<cffunction name="findProdInCat" displayname="Find Product in Category" hint="Returns a 1 if product is found in category" access="public" returntype="numeric">
		<cfargument name="ItemID" displayname="ItemID" hint="The Item ID to look for in category" type="numeric" required="yes">
		<cfargument name="CatID" displayname="Category ID" hint="The Category ID where the product should be located" type="numeric" required="yes">

		<cfquery name="findProdInCat" datasource="#application.dsn#">
			SELECT 	ItemID
			FROM 	Products
			WHERE 	ItemID = #arguments.ItemID#
			AND		(Category = #arguments.CatID#
			OR 		OtherCategories LIKE '%,#arguments.CatID#,%' )
		</cfquery>
		
		<cfscript>
			if ( findProdInCat.RecordCount NEQ 0 )
				ProductInCat = 1 ;
			else
				ProductInCat = 0 ;
		</cfscript>
	
		<cfreturn ProductInCat >
	</cffunction>
	
	
	<!--- 
		FIND PRODUCT IN SECTION
		Used in: 
	--->
	<cffunction name="findProdInSec" displayname="Find Product in Section" hint="Returns a 1 if product is found in section" access="public" returntype="numeric">
		<cfargument name="ItemID" displayname="ItemID" hint="The Item ID to look for in section" type="numeric" required="yes">
		<cfargument name="SectionID" displayname="Category ID" hint="The Section ID where the product should be located" type="numeric" required="yes">

		<cfquery name="findProdInSec" datasource="#application.dsn#">
			SELECT 	ItemID
			FROM 	Products
			WHERE 	ItemID = #arguments.ItemID#
			AND		(SectionID = #arguments.SectionID#
			OR 		OtherSections LIKE '%,#arguments.SectionID#,%' )
		</cfquery>
		
		<cfscript>
			if ( findProdInSec.RecordCount NEQ 0 )
				ProductInSec = 1 ;
			else
				ProductInSec = 0 ;
		</cfscript>
	
		<cfreturn ProductInSec >
	</cffunction>
	
	
	
	<!--- 
		GET DISCOUNT USAGE TOTAL OR BY CUSTOMER
		Used in: 
	--->
	<cffunction name="getDiscountUsage" displayname="Get Discount Usage Stats" hint="Returns the amount of times a discount has been used by customer or total" access="public" returntype="numeric">
		<cfargument name="DiscountID" displayname="DiscountID" hint="The Discount ID of the discount to look for" type="numeric" required="yes">
		<cfargument name="CustomerID" displayname="CustomerID" hint="The Customer ID that has used the discount" type="string" required="no">

		<cfquery name="getDiscountUsage" datasource="#application.dsn#">
			SELECT 	COUNT(*) AS DiscountUsage
			FROM 	DiscountUsage
			WHERE 	DiscountID = #arguments.DiscountID#
			<cfif isDefined('arguments.CustomerID') AND arguments.CustomerID NEQ ''>
			AND		CustomerID = '#arguments.CustomerID#'
			</cfif>
		</cfquery>
		
		<cfscript>
			if ( getDiscountUsage.RecordCount NEQ 0 )
				DiscountUsage = getDiscountUsage.DiscountUsage ;
			else
				DiscountUsage = 0 ;
		</cfscript>
	
		<cfreturn DiscountUsage >
	</cffunction>
	
	
	<!--- 
		GET ITEM PRICE
		Used in: 
	--->
	<cffunction name="getItemPrice" displayname="Get Item Price" hint="Function to retrieve item price, after calculating discounts, sales, etc." access="public">
		<cfargument name="UserID" displayname="UserID" hint="The price column of the product to get, depending on user" type="numeric" required="yes">
		<cfargument name="SiteID" displayname="SiteID" hint="The CartFusion Site ID of the Products to get" type="numeric" required="yes">
		<cfargument name="ItemID" displayname="ItemID" hint="The Item ID of the price to get" type="numeric" required="yes">
		<cfargument name="SessionID" displayname="SessionID" hint="The CartFusion Session ID of the current customer linked to the cart" type="string" required="yes">
		<cfargument name="CustomerID" displayname="CustomerID" hint="The Customer ID of the Products to get" type="string" required="no">
		<cfargument name="OptionName1" displayname="Option Name 1" hint="Product option value 1 in Cart" type="string" required="no">
		<cfargument name="OptionName2" displayname="Option Name 2" hint="Product option value 2 in Cart" type="string" required="no">
		<cfargument name="OptionName3" displayname="Option Name 3" hint="Product option value 3 in Cart" type="string" required="no">
		
		<cfquery name="getItemPrice" datasource="#application.dsn#">
			SELECT 	Price#arguments.UserID# AS ItemPrice
			FROM 	Products
			WHERE 	ItemID = #arguments.ItemID#
		</cfquery>
		
		<cfif getItemPrice.RecordCount NEQ 0 >
	
			<!--- RETURN THE PRICE FOUND IN TABLE.PRODUCTS --->
			<cfscript>
				UseThisPrice = getItemPrice.ItemPrice ;
			</cfscript>
			
			<!---
				CALCULATE PRODUCT OPTION PRICES
			 --->
			<cfif (isDefined('arguments.OptionName1') AND arguments.OptionName1 NEQ '')>
			
				<!--- CHECK OPTION PRICES FIRST --->
				<cfquery name="getOptionPrice" datasource="#application.dsn#">
					SELECT 	OptionPrice
					FROM 	ProductOptions
					WHERE 	ItemID = #arguments.ItemID#
					AND		OptionName = '#arguments.OptionName1#'
				</cfquery>
				
				<cfif getOptionPrice.RecordCount NEQ 0 >
					<cfset UseThisPrice = UseThisPrice + getOptionPrice.OptionPrice >
				
				<!--- OTHERWISE, CHECK MATRIX PRICES SECOND --->
				<cfelse>
					<cfquery name="getCompPrice" datasource="#application.dsn#">
						SELECT 	CompPrice
						FROM 	ItemClassComponents
						WHERE 	ItemID = #arguments.ItemID#
						AND		Detail1 = '#arguments.OptionName1#'
						<cfif (isDefined('arguments.OptionName2') AND arguments.OptionName2 NEQ '')>
						AND		Detail2 = '#arguments.OptionName2#'
						</cfif>
						<cfif (isDefined('arguments.OptionName3') AND arguments.OptionName3 NEQ '')>
						AND		Detail3 = '#arguments.OptionName3#'
						</cfif>
					</cfquery>
					
					<cfif getCompPrice.RecordCount NEQ 0 >
						<cfset UseThisPrice = UseThisPrice + getCompPrice.CompPrice >
					</cfif>
					
				</cfif>
				
			</cfif>
			<cfif (isDefined('arguments.OptionName2') AND arguments.OptionName2 NEQ '')>
			
				<cfquery name="getOptionPrice" datasource="#application.dsn#">
					SELECT 	OptionPrice
					FROM 	ProductOptions
					WHERE 	ItemID = #arguments.ItemID#
					AND		OptionName = '#arguments.OptionName2#'
				</cfquery>
				
				<cfif getOptionPrice.RecordCount NEQ 0 >
					<cfset UseThisPrice = UseThisPrice + getOptionPrice.OptionPrice >
				</cfif>
				
			</cfif>
			<cfif (isDefined('arguments.OptionName3') AND arguments.OptionName3 NEQ '')>
			
				<cfquery name="getOptionPrice" datasource="#application.dsn#">
					SELECT 	OptionPrice
					FROM 	ProductOptions
					WHERE 	ItemID = #arguments.ItemID#
					AND		OptionName = '#arguments.OptionName3#'
				</cfquery>
				
				<cfif getOptionPrice.RecordCount NEQ 0 >
					<cfset UseThisPrice = UseThisPrice + getOptionPrice.OptionPrice >
				</cfif>
				
			</cfif>
		<cfelse>
			<cfset UseThisPrice = 0 >
		</cfif>
		
		
		<cfreturn UseThisPrice >
	</cffunction>


	<!--- 
		GET SHIPPING DISCOUNT
		Used in: 
	--->
	<cffunction name="getShipDiscount" access="public" displayname="Get Shipping Discount" hint="Retrieves information about a global or specific shipping discount" returntype="struct">
		<cfargument name="UserID" displayname="UserID" hint="The user the discount relates to" type="numeric" required="yes">
		<cfargument name="SiteID" displayname="SiteID" hint="The CartFusion Site ID the discount relates to" type="numeric" required="yes">
		<cfargument name="SessionID" displayname="SessionID" hint="The SessionID the discount relates to" type="string" required="yes">
		<cfargument name="ShippingMethod" displayname="Shipping Method" hint="Optional: Shipping Method to check if discounts are available for" type="string" required="no"> 
		
		<cfif isDefined('arguments.ShippingMethod') >
			<cfquery name="getShipID" datasource="#application.dsn#">
				SELECT	SMID
				FROM	ShippingMethods
				WHERE	ShippingCode = '#arguments.ShippingMethod#'
			</cfquery>		
		</cfif>
		
		<cfquery name="getDiscounts" datasource="#application.dsn#" cachedwithin="#CreateTimeSpan(0,0,-30,0)#">
			SELECT	*
			FROM	Discounts d
			WHERE   d.DateValidFrom <= #CreateODBCDate(Now())#
			AND 	d.DateValidTo >= #CreateODBCDate(Now())#
			AND		d.Expired != 1
			AND 	d.SiteID = #arguments.SiteID#
			AND 	d.AutoApply = 1
			AND	(d.ApplyToUser = #arguments.UserID# OR d.ApplyToUser = 0)
			<cfif isDefined('getShipID') AND getShipID.RecordCount NEQ 0 >
			AND		d.ApplyTo = #getShipID.SMID#
			AND		d.ApplyToType = 5
			<cfelse>
			AND 	d.ApplyToType = 4
			</cfif>
			ORDER BY d.QtyLevel ASC, d.OrderTotalLevel DESC, d.ApplyToType ASC
		</cfquery>
			
		<cfscript>
			ShippingDiscount = StructNew() ;
			ShippingDiscount.ID = 0 ;
			ShippingDiscount.All = 0 ;
			ShippingDiscount.Value = 0 ;
			ShippingDiscount.Type = 0 ;
			ShippingDiscount.ShipMethod = '' ;
			ShippingDiscount.DiscountMessage = '' ;
		</cfscript>
		
		<cfif getDiscounts.RecordCount NEQ 0 >
			
			<!--- RETURN DISCOUNT FOUND IN QUERY --->
			<cfoutput query="getDiscounts">
							
				<!--- SET DEFAULT VARIABLE TO CONTINUE WITH DISCOUNT --->
				<cfset GoAhead = 1 >
				
				<!--- CHECK FOR CUSTOMER USAGE LIMITS & TOTAL USAGE LIMITS --->
				<cfif UsageLimitCust GT 0 >
					<!--- CHECK FOR A PRODUCT IN THE REQUIRED SECTION --->
					<cfscript>
						DiscountUsage = CreateObject("component", "Cart").getDiscountUsage(DiscountID=getDiscounts.DiscountID,CustomerID=session.CustomerArray[17]) ;
					</cfscript>
					<cfif UsageLimitCust LTE DiscountUsage >
						<cfset GoAhead = 0 >
					</cfif>
				</cfif>
				
				<cfif UsageLimitTotal GT 0 >
					<!--- CHECK FOR A PRODUCT IN THE REQUIRED SECTION --->
					<cfscript>
						DiscountUsage = CreateObject("component", "Cart").getDiscountUsage(DiscountID=getDiscounts.DiscountID) ;
					</cfscript>
					<cfif UsageLimitTotal LTE DiscountUsage >
						<cfset GoAhead = 0 >
					</cfif>
				</cfif>
				
				<cfif GoAhead EQ 1 >
										
					<!--- CHECK FOR REQUIRED PRODUCT --->
					<cfif AddPurchaseReq EQ 0 >
						<!--- DO NOTHING --->
					<cfelseif AddPurchaseReq EQ 1 >
						<!--- CHECK FOR A CERTAIN REQUIRED PRODUCT IN THE CART --->
						<cfscript>
							getCartItems = CreateObject("component", "Cart").getCartItems(UserID=arguments.UserID,SiteID=arguments.SiteID,SessionID=arguments.SessionID,ItemID=AddPurchaseVal) ;
						</cfscript>
						<cfif getCartItems.data.RecordCount EQ 0 >
							<cfset GoAhead = 0 >
						</cfif>
					<cfelseif AddPurchaseReq EQ 2 >
						<!--- CHECK FOR A PRODUCT IN THE REQUIRED CATEGORY --->
						<cfscript>
							getCartItems = CreateObject("component", "Cart").getCartItems(UserID=arguments.UserID,SiteID=arguments.SiteID,SessionID=arguments.SessionID,CatID=AddPurchaseVal) ;
						</cfscript>
						<cfif getCartItems.data.RecordCount EQ 0 >
							<cfset GoAhead = 0 >
						</cfif>
					<cfelseif AddPurchaseReq EQ 3 >
						<!--- CHECK FOR A PRODUCT IN THE REQUIRED SECTION --->
						<cfscript>
							getCartItems = CreateObject("component", "Cart").getCartItems(UserID=arguments.UserID,SiteID=arguments.SiteID,SessionID=arguments.SessionID,SectionID=AddPurchaseVal) ;
						</cfscript>
						<cfif getCartItems.data.RecordCount EQ 0 >
							<cfset GoAhead = 0 >
						</cfif>
					</cfif>
					
					
					<cfif GoAhead EQ 1 >
					
						<!--- CHECK FOR ALLOW MULTIPLES --->
						<!--- ONLY APPLY ONCE TO A PRODUCT --->
						
						<!--- GET CART TOTAL --->
						<cfscript>
							CartTotal = CreateObject("component", "Cart").getCartTotal(UserID=arguments.UserID,SiteID=arguments.SiteID,SessionID=arguments.SessionID) ;
						</cfscript>
						<cfif CartTotal LT OrderTotalLevel >
							<cfset GoAhead = 0 >
						</cfif>							
						
						<cfif GoAhead EQ 1 >	

							<!--- ALL SHIPPING METHODS --->
							<cfif ApplyToType EQ 4 >
								<cfscript>
									ShippingDiscount.All = 1 ;
									ShippingDiscount.ID = getDiscounts.DiscountID ;
									ShippingDiscount.Value = getDiscounts.DiscountValue ;
									ShippingDiscount.ShipMethod = '' ;
									ShippingDiscount.DiscountMessage = getDiscounts.DiscountName ;
									if ( IsPercentage EQ 1 )
										ShippingDiscount.Type = 1 ;
									else
										ShippingDiscount.Type = 0 ;											
								</cfscript>
								
							<!--- SPECIFIC SHIPPING METHOD --->
							<cfelseif ApplyToType EQ 5 >
								<cfscript>
									ShippingDiscount.All = 0 ;
									ShippingDiscount.ID = getDiscounts.DiscountID ;
									ShippingDiscount.Value = getDiscounts.DiscountValue ;
									ShippingDiscount.DiscountMessage = getDiscounts.DiscountName ;
									if ( isDefined('arguments.ShippingMethod') )
										ShippingDiscount.ShipMethod = arguments.ShippingMethod ;
									else
										ShippingDiscount.ShipMethod = '' ;
									if ( IsPercentage EQ 1 )
										ShippingDiscount.Type = 1 ;
									else
										ShippingDiscount.Type = 0 ;											
								</cfscript>
							</cfif>	
						</cfif>						
					</cfif>						
				</cfif>
			</cfoutput>
		</cfif>
		
		<cfreturn ShippingDiscount >
	</cffunction>

	
</cfcomponent>