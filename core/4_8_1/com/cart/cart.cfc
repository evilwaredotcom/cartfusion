<!--- 
|| LEGAL ||
$CartFusion - Copyright � 2001-2007 Trade Studios, LLC.$
$This copyright notice MUST stay intact for use (see license.txt).$
$It is against the law to copy, distribute, gift, bundle or give away this code$
$without written consent from Trade Studios, LLC.$

|| VERSION CONTROL ||
$Id: 4.7.0.3b $
$Date: 26-Mar-07 $
$Revision: 1.0.0 $

|| DESCRIPTION ||
$Description: CARTFUSION 4.7 - CART CFC $
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

<!--- *CARTFUSION 4.7 - CART CFC* --->
<cfcomponent displayname="Shopping Cart Module" hint="This component handles the shopping cart of a CartFusion site.">

	<cfscript>
		variables.dsn = "";
		// variables.instance = structNew();
	</cfscript>

	<cffunction name="init" returntype="Cart" output="no">
		<cfargument name="dsn" required="true">
	
		<cfscript>
			variables.dsn = arguments.dsn ;
			// variables.instance.cartItems = arrayNew(1) ;
		</cfscript>
		
		<cfreturn this />
	</cffunction>
	
	
	<!--- *CARTFUSION 4.6 - CART ITEMS CFC* --->
	<cffunction name="getCartItems" displayname="Get Cart Items" hint="Function to retrieve all cart items information." output="no">
		<cfargument name="UserID" displayname="UserID" hint="The Price and Hide Columns of the Products to get, depending on User" type="numeric" required="yes">
		<cfargument name="SiteID" displayname="SiteID" hint="The CartFusion Site ID of the Products to get" type="numeric" required="yes">
		<cfargument name="SessionID" displayname="SessionID" hint="The CartFusion Session ID of the current customer linked to the cart" type="string" required="yes">
		<cfargument name="ItemID" displayname="ItemID" hint="For checking for this product in the cart" type="numeric" required="no">
		<cfargument name="CatID" displayname="Category ID" hint="For checking for a product in this category" type="numeric" required="no">
		<cfargument name="SectionID" displayname="Section ID" hint="For checking for a product in this section" type="numeric" required="no">
		<cfargument name="Qty" displayname="Quantity" hint="For Quantity Level Checking" type="numeric" required="no">
		<cfargument name="ShippingID" displayname="ShippingID" hint="Return only cart items going to this address (multiple shipping addresses feature)" type="numeric" required="no">
		<cfargument name="ShippingMethod" required="no">
		<cfargument name="OptionName1" required="no">
		<cfargument name="OptionName2" required="no">
		<cfargument name="OptionName3" required="no">
		<cfargument name="OptionName4" required="no">
		<cfargument name="OptionName5" required="no">
		<cfargument name="OptionName6" required="no">
		<cfargument name="OptionName7" required="no">
		<cfargument name="OptionName8" required="no">
		<cfargument name="OptionName9" required="no">
		<cfargument name="OptionName10" required="no">
		
		<!--- Initialize variables --->
		<cfscript>
			var data = StructNew() ;
			var stReturn = StructNew() ;
			stReturn.bSuccess = True ;
			stReturn.message = "" ;
			stReturn.data = StructNew() ;
			stReturn.stError = StructNew() ;
		</cfscript>
		
		<cftry>
		
			<cfquery name="data" datasource="#variables.dsn#">
				SELECT 		c.CartItemID, c.SiteID, c.CustomerID, c.SessionID, c.ItemID, c.Qty, 
							c.OptionName1, c.OptionName2, c.OptionName3, c.OptionName4, c.OptionName5, 
							c.OptionName6, c.OptionName7, c.OptionName8, c.OptionName9, c.OptionName10,
							c.AffiliateID, c.BackOrdered, c.ShippingID, c.ShippingMethod, c.DateEntered,
							p.SKU, p.ItemName, p.Weight, p.Taxable, p.ImageDir, p.ImageSmall,
							p.Price#arguments.UserID# AS PriceUsed,
							<!--- *CARTFUSION 4.6 - INDIVIDUAL PRODUCT SHIPPING PRICES* --->
							p.fldShipAmount, p.fldHandAmount, p.fldShipCode, p.fldShipWeight, p.fldOverSize,
							<!--- !CARTFUSION 4.6 - INDIVIDUAL PRODUCT SHIPPING PRICES! ---> 
							c.Qty AS CartTotalQtyLine,
							c.Qty * p.Price#arguments.UserID# AS CartTotalPriceLine,
							c.Qty * p.Weight AS CartTotalWeightLine,
							(
								SELECT 	SUM(Qty)
								FROM 	Cart
								WHERE 	sessionID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.SessionID#">
								AND		SiteID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.SiteID#">
							) AS CartTotalQty,
							(
								SELECT 	SUM(Qty) 
								FROM 	Cart
								WHERE 	sessionID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.SessionID#">
								AND		SiteID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.SiteID#">
								AND		ItemID = p.ItemID
							)
							*
							(
								SELECT 	SUM(Price#arguments.UserID#) 
								FROM 	Products
								WHERE 	sessionID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.SessionID#">
								AND		SiteID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.SiteID#">
								AND		ItemID = p.ItemID
							) AS CartTotalPrice,
							(
								SELECT 	SUM(Qty)
								FROM 	Cart
								WHERE 	sessionID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.SessionID#">
								AND		SiteID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.SiteID#">
								AND		ItemID = p.ItemID
							) 
							*
							(
								SELECT 	SUM(Weight)
								FROM 	Products
								WHERE 	sessionID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.SessionID#">
								AND		SiteID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.SiteID#">
								AND		ItemID = p.ItemID
							) AS CartTotalWeight
				FROM 		Cart c, Products p
				WHERE 		c.ItemID = p.ItemID
				AND			c.SiteID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.SiteID#">
				AND 		c.sessionID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.SessionID#">
				<cfif StructKeyExists(arguments,'ItemID') AND arguments.ItemID NEQ ''>
				AND			c.ItemID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ItemID#">
				</cfif>
				<cfif StructKeyExists(arguments,'Qty') AND arguments.Qty NEQ ''>
				AND			c.Qty >= <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.Qty#">
				</cfif>
				<cfif StructKeyExists(arguments,'CatID') AND arguments.CatID NEQ ''>
				AND			p.Category IN
							(
								SELECT	CatID
								FROM	Categories
								WHERE	CatID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.CatID#">
							)
				</cfif>
				<cfif StructKeyExists(arguments,'SectionID') AND arguments.SectionID NEQ ''>
				AND			p.SectionID IN
							(
								SELECT	SectionID
								FROM	Sections
								WHERE	SectionID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.SectionID#">
							)
				</cfif>
				<!--- *CARTFUSION 4.6 - RETURN CART ITEMS FOR THIS SHIPMENT/PACKAGE ONLY, AND ORDER RECORDSET BY PACKAGE* --->
				<cfif StructKeyExists(arguments,'ShippingID') AND arguments.ShippingID NEQ ''>
				AND			c.ShippingID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ShippingID#">
				</cfif>
				ORDER BY 	c.ShippingID, c.ItemID
				<!--- !CARTFUSION 4.6 - RETURN CART ITEMS FOR THIS SHIPMENT/PACKAGE ONLY, AND ORDER RECORDSET BY PACKAGE! --->
			</cfquery>
			
			<cfscript>
				if ( NOT data.RecordCount )
				{
					stReturn.bSuccess = False ;
					stReturn.data = data ;
					stReturn.message = "No information was available for that criteria" ;
				}
				else
				{
					stReturn.bSuccess = True ;
					stReturn.data = data ;
					stReturn.message = "Success" ;
				}
			</cfscript>
			
			<cfcatch>
				<cfscript>
					stReturn.bSuccess = False ;
					stReturn.message = cfcatch.message & "<br><br>" & cfcatch.detail ;
					stReturn.stError = cfcatch ;
				</cfscript>
			</cfcatch>
			
		</cftry>
				
		<cfreturn stReturn >
	</cffunction>
	
	
	<!--- *CARTFUSION 4.7 - getCART CFC* --->
	<cffunction name="getCart" output="no">
		<cfargument name="UserID" displayname="UserID" hint="The Price and Hide Columns of the Products to get, depending on User" type="numeric" required="yes">
		<cfargument name="SiteID" displayname="SiteID" hint="The CartFusion Site ID of the Products to get" type="numeric" required="yes">
		<cfargument name="SessionID" displayname="SessionID" hint="The CartFusion Session ID of the current customer linked to the cart" type="string" required="yes">
		<cfargument name="ItemID" displayname="ItemID" hint="For checking for this product in the cart" type="numeric" required="no">
		<cfargument name="CatID" displayname="Category ID" hint="For checking for a product in this category" type="numeric" required="no">
		<cfargument name="SectionID" displayname="Section ID" hint="For checking for a product in this section" type="numeric" required="no">
		<cfargument name="Qty" displayname="Quantity" hint="For Quantity Level Checking" type="numeric" required="no">
		<cfargument name="ShippingID" displayname="ShippingID" hint="Return only cart items going to this address (multiple shipping addresses feature)" type="numeric" required="no">
		<cfargument name="ShippingMethod" required="no">
		<cfargument name="AffiliateID" required="no">
		<cfargument name="OptionName1" required="no">
		<cfargument name="OptionName2" required="no">
		<cfargument name="OptionName3" required="no">
		<cfargument name="OptionName4" required="no">
		<cfargument name="OptionName5" required="no">
		<cfargument name="OptionName6" required="no">
		<cfargument name="OptionName7" required="no">
		<cfargument name="OptionName8" required="no">
		<cfargument name="OptionName9" required="no">
		<cfargument name="OptionName10" required="no">
		
		<!--- Initialize variables --->
		<cfscript>
			var data = StructNew() ;
			var data2 = StructNew() ;
			var stReturn = StructNew() ;
			stReturn.bSuccess = True ;
			stReturn.message = "" ;
			stReturn.data = StructNew() ;
			stReturn.data2 = StructNew() ;
			stReturn.stError = StructNew() ;
		</cfscript>
		
		<cftry>
		
			<cfquery name="data" datasource="#variables.dsn#">
				SELECT 		<!--- c.*, and some info from item table --->
							c.CartItemID, c.SiteID, c.CustomerID, c.SessionID, c.ItemID, c.Qty, 
							c.OptionName1, c.OptionName2, c.OptionName3, c.OptionName4, c.OptionName5, 
							c.OptionName6, c.OptionName7, c.OptionName8, c.OptionName9, c.OptionName10,
							c.AffiliateID, c.BackOrdered, c.ShippingID, c.ShippingMethod, c.DateEntered,
							p.SKU, p.ItemName, p.Weight, p.Taxable, p.ImageDir, p.ImageSmall,
							p.Price#arguments.UserID# AS PriceUsed,
							<!--- *CARTFUSION 4.6 - INDIVIDUAL PRODUCT SHIPPING PRICES* --->
							p.fldShipAmount, p.fldHandAmount, p.fldShipCode, p.fldShipWeight, p.fldOverSize,
							<!--- !CARTFUSION 4.6 - INDIVIDUAL PRODUCT SHIPPING PRICES! ---> 
							<!--- *CARTFUSION 4.7 - CART TOTALS USING SQL* --->
							p.DimLength, p.DimWidth, p.DimHeighth,
							c.Qty AS CartTotalQtyLine,
							c.Qty * p.Price#arguments.UserID# AS CartTotalPriceLine,
							c.Qty * p.Weight AS CartTotalWeightLine,
							c.Qty * p.fldShipAmount AS CartTotalShipAmountLine,
							c.Qty * p.fldHandAmount AS CartTotalHandAmountLine
							<!--- !CARTFUSION 4.7 - CART TOTALS USING SQL! --->
				FROM 		Cart c, Products p
				WHERE 		c.ItemID = p.ItemID
				AND			c.SiteID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.SiteID#">
				AND 		c.sessionID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.SessionID#">
				<cfif StructKeyExists(arguments,'ItemID') AND arguments.ItemID NEQ ''>
				AND			c.ItemID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ItemID#">
				</cfif>
				<cfif StructKeyExists(arguments,'Qty') AND arguments.Qty NEQ ''>
				AND			c.Qty >= <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.Qty#">
				</cfif>
				<cfif StructKeyExists(arguments,'CatID') AND arguments.CatID NEQ ''>
				AND			p.Category IN
							(
								SELECT	CatID
								FROM	Categories
								WHERE	CatID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.CatID#">
							)
				</cfif>
				<cfif StructKeyExists(arguments,'SectionID') AND arguments.SectionID NEQ ''>
				AND			p.SectionID IN
							(
								SELECT	SectionID
								FROM	Sections
								WHERE	SectionID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.SectionID#">
							)
				</cfif>
				<!--- *CARTFUSION 4.6 - RETURN CART ITEMS FOR THIS SHIPMENT/PACKAGE ONLY, AND ORDER RECORDSET BY PACKAGE* --->
				<cfif StructKeyExists(arguments,'ShippingID') AND arguments.ShippingID NEQ ''>
				AND			c.ShippingID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ShippingID#">
				</cfif>
				ORDER BY 	c.ShippingID, c.ItemID
				<!--- !CARTFUSION 4.6 - RETURN CART ITEMS FOR THIS SHIPMENT/PACKAGE ONLY, AND ORDER RECORDSET BY PACKAGE! --->
			</cfquery>
			
			<!--- *CARTFUSION 4.7 - CART TOTALS USING SQL* --->
			<cfquery name="data2" dbtype="query">
				SELECT 		SUM(CartTotalQtyLine) AS CartTotalQty,
							SUM(CartTotalPriceLine) AS CartTotalPrice,
							SUM(CartTotalWeightLine) AS CartTotalWeight,
							SUM(CartTotalShipAmountLine) AS CartTotalShipAmount,
							SUM(CartTotalHandAmountLine) AS CartTotalHandAmount,
							SUM(CartTotalShipAmountLine) + SUM(CartTotalHandAmountLine) AS CartTotalAddAmount,
							MAX(DimLength) AS CartTotalDimLength,
							MAX(DimWidth) AS CartTotalDimWidth,
							SUM(DimHeighth) AS CartTotalDimHeighth,
							SUM(CartItemID) AS CartItemIDs
				FROM 		data
			</cfquery>
			<!--- !CARTFUSION 4.7 - CART TOTALS USING SQL! --->
			
			<cfscript>
				if ( NOT data.RecordCount )
				{
					stReturn.bSuccess = False ;
					stReturn.data = data ;
					stReturn.data2 = data2 ;
					stReturn.message = "No information was available for that criteria" ;
				}
				else
				{
					stReturn.bSuccess = True ;
					stReturn.data = data ;
					stReturn.data2 = data2 ;
					stReturn.message = "Success" ;
				}
			</cfscript>
			
			<cfcatch>
				<cfscript>
					stReturn.bSuccess = False ;
					stReturn.message = cfcatch.message & "<br><br>" & cfcatch.detail ;
					stReturn.stError = cfcatch ;
				</cfscript>
			</cfcatch>
			
		</cftry>
				
		<cfreturn stReturn >
	</cffunction>
	
	
	
	<!--- *CARTFUSION 4.7 - getPACKAGE CFC* --->
	<cffunction name="getPackages" output="no" >
		<cfargument name="SessionID" required="yes">
		<cfargument name="UserID" required="yes">
		<cfargument name="SiteID" required="yes">
		<cfargument name="ShipBy" required="yes">
		<cfargument name="Weight" required="no">
		<cfargument name="DimLength" required="no">
		<cfargument name="DimWidth" required="no">
		<cfargument name="DimHeighth" required="no">

		<!--- Initialize variables --->
		<cfscript>
			var data = QueryNew("ShippingID,CartItemIDs,ItemQty,Value,Weight,Method,TotalDimLength,TotalDimWidth,TotalDimHeighth,PackagingType,AmountToAdd,UseDim,Oversize,CustomerID,ShipNickName,ShipFirstName,ShipLastName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipCompanyName,ShipEmail",
								"Integer,VarChar,Decimal,Decimal,Decimal,VarChar,Decimal,Decimal,Decimal,Integer,Decimal,Bit,Bit,VarChar,VarChar,VarChar,VarChar,VarChar,VarChar,VarChar,VarChar,VarChar,VarChar,VarChar,VarChar,VarChar") ;
			var data2 = StructNew() ;
			var getPackages = StructNew() ;
			var getPackageItems = StructNew() ;
			var getPackageItemTotals = StructNew() ;
			var preventDuplicate = StructNew() ;
			var getCustomerSH = StructNew() ;
			var getCustomer = StructNew() ;
			var CartItemIDs = '' ;
			var stReturn = StructNew() ;
			stReturn.bSuccess = True ;
			stReturn.message = "" ;
			stReturn.data = StructNew() ;
			// stReturn.data2 = StructNew() ;
			stReturn.stError = StructNew() ;
		</cfscript>
		
		<cftry>

			<cfscript>
				data2 = application.Cart.getCart(
							UserID = arguments.UserID,
							SiteID = arguments.SiteID,
							SessionID = arguments.SessionID
							) ;
			</cfscript>
			<cfif ( data2.bSuccess ) >
				<cfquery name="getPackages" dbtype="query">
					SELECT		DISTINCT ShippingID
					FROM		data2.data
				</cfquery>
				<cfloop query="getPackages">
					<cfquery name="getPackageItems" dbtype="query">
						SELECT		*
						FROM		data2.data
						WHERE		ShippingID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ShippingID#">
					</cfquery>
					<cfquery name="getPackageItemTotals" dbtype="query">
						SELECT 		SUM(CartTotalQtyLine) AS CartTotalQty,
									SUM(CartTotalPriceLine) AS CartTotalPrice,
									SUM(CartTotalWeightLine) AS CartTotalWeight,
									SUM(CartTotalShipAmountLine) AS CartTotalShipAmount,
									SUM(CartTotalHandAmountLine) AS CartTotalHandAmount,
									SUM(CartTotalShipAmountLine) + SUM(CartTotalHandAmountLine) AS CartTotalAddAmount,
									MAX(DimLength) AS CartTotalDimLength,
									MAX(DimWidth) AS CartTotalDimWidth,
									SUM(DimHeighth) AS CartTotalDimHeighth
						FROM 		getPackageItems
					</cfquery>
					<cfloop query="getPackageItems">
						<cfscript>
							CartItemIDs = ValueList(getPackageItems.CartItemID) ;
						</cfscript>
						<cfquery name="preventDuplicate" dbtype="query">
							SELECT		*
							FROM		data
							WHERE		ShippingID = <cfqueryparam cfsqltype="cf_sql_integer" value="#getPackageItems.ShippingID#">
						</cfquery>
						<cfif preventDuplicate.RecordCount EQ 0 >
							<cfquery name="getCustomerSH" datasource="#variables.dsn#">
								SELECT		CustomerID, ShipNickName, ShipFirstName, ShipLastName, ShipCompanyName, 
											ShipAddress1, ShipAddress2, ShipCity, ShipState, ShipZip, ShipCountry, ShipPhone, ShipEmail
								FROM		CustomerSH
								WHERE		SHID = <cfqueryparam cfsqltype="cf_sql_integer" value="#getPackageItems.ShippingID#">
							</cfquery>
							<cfquery name="getCustomer" datasource="#variables.dsn#">
								SELECT		CustomerID, 'Myself' AS ShipNickName, ShipFirstName, ShipLastName, ShipCompanyName, 
											ShipAddress1, ShipAddress2, ShipCity, ShipState, ShipZip, ShipCountry, ShipPhone, ShipEmail
								FROM		Customers
								WHERE		CustomerID = <cfqueryparam cfsqltype="cf_sql_integer" value="#getPackageItems.CustomerID#">
							</cfquery>
							<cfscript>
								QueryAddRow(data,1) ;
								QuerySetCell(data, "ShippingID", getPackageItems.ShippingID, getPackages.CurrentRow) ;
								QuerySetCell(data, "CartItemIDs", CartItemIDs, getPackages.CurrentRow) ;
								QuerySetCell(data, "ItemQty", getPackageItemTotals.CartTotalQty, getPackages.CurrentRow) ;
								QuerySetCell(data, "Value", getPackageItemTotals.CartTotalPrice, getPackages.CurrentRow) ;
								QuerySetCell(data, "Weight", getPackageItemTotals.CartTotalWeight, getPackages.CurrentRow) ;
								QuerySetCell(data, "Method", getPackageItems.ShippingMethod, getPackages.CurrentRow) ;
								QuerySetCell(data, "TotalDimLength", getPackageItemTotals.CartTotalDimLength, getPackages.CurrentRow) ;
								QuerySetCell(data, "TotalDimWidth", getPackageItemTotals.CartTotalDimWidth, getPackages.CurrentRow) ;
								QuerySetCell(data, "TotalDimHeighth", getPackageItemTotals.CartTotalDimHeighth, getPackages.CurrentRow) ;
								QuerySetCell(data, "PackagingType", 1, getPackages.CurrentRow) ;
								QuerySetCell(data, "AmountToAdd", getPackageItemTotals.CartTotalAddAmount, getPackages.CurrentRow) ;
								QuerySetCell(data, "UseDim", 0, getPackages.CurrentRow) ;
								QuerySetCell(data, "Oversize", getPackageItems.fldOversize, getPackages.CurrentRow) ;
								// RECEIVER INFO
								if ( TRIM(getCustomerSH.ShipNickname) NEQ '' ) {
									QuerySetCell(data, "CustomerID", getCustomerSH.CustomerID, getPackages.CurrentRow) ;
									QuerySetCell(data, "ShipNickName", getCustomerSH.ShipNickName, getPackages.CurrentRow) ;
									QuerySetCell(data, "ShipFirstName", getCustomerSH.ShipFirstName, getPackages.CurrentRow) ;
									QuerySetCell(data, "ShipLastName", getCustomerSH.ShipLastName, getPackages.CurrentRow) ;
									QuerySetCell(data, "ShipAddress1", getCustomerSH.ShipAddress1, getPackages.CurrentRow) ;
									QuerySetCell(data, "ShipAddress2", getCustomerSH.ShipAddress2, getPackages.CurrentRow) ;
									QuerySetCell(data, "ShipCity", getCustomerSH.ShipCity, getPackages.CurrentRow) ;
									QuerySetCell(data, "ShipState", getCustomerSH.ShipState, getPackages.CurrentRow) ;
									QuerySetCell(data, "ShipZip", getCustomerSH.ShipZip, getPackages.CurrentRow) ;
									QuerySetCell(data, "ShipCountry", getCustomerSH.ShipCountry, getPackages.CurrentRow) ;
									QuerySetCell(data, "ShipPhone", getCustomerSH.ShipPhone, getPackages.CurrentRow) ;
									QuerySetCell(data, "ShipCompanyName", getCustomerSH.ShipCompanyName, getPackages.CurrentRow) ;
									QuerySetCell(data, "ShipEmail", getCustomerSH.ShipEmail, getPackages.CurrentRow) ;
									
								} else {
									QuerySetCell(data, "CustomerID", getCustomer.CustomerID, getPackages.CurrentRow) ;
									QuerySetCell(data, "ShipNickName", getCustomer.ShipNickName, getPackages.CurrentRow) ;
									QuerySetCell(data, "ShipFirstName", getCustomer.ShipFirstName, getPackages.CurrentRow) ;
									QuerySetCell(data, "ShipLastName", getCustomer.ShipLastName, getPackages.CurrentRow) ;
									QuerySetCell(data, "ShipAddress1", getCustomer.ShipAddress1, getPackages.CurrentRow) ;
									QuerySetCell(data, "ShipAddress2", getCustomer.ShipAddress2, getPackages.CurrentRow) ;
									QuerySetCell(data, "ShipCity", getCustomer.ShipCity, getPackages.CurrentRow) ;
									QuerySetCell(data, "ShipState", getCustomer.ShipState, getPackages.CurrentRow) ;
									QuerySetCell(data, "ShipZip", getCustomer.ShipZip, getPackages.CurrentRow) ;
									QuerySetCell(data, "ShipCountry", getCustomer.ShipCountry, getPackages.CurrentRow) ;
									QuerySetCell(data, "ShipPhone", getCustomer.ShipPhone, getPackages.CurrentRow) ;
									QuerySetCell(data, "ShipCompanyName", getCustomer.ShipCompanyName, getPackages.CurrentRow) ;
									QuerySetCell(data, "ShipEmail", getCustomer.ShipEmail, getPackages.CurrentRow) ;
								}
							</cfscript>
						</cfif>
					</cfloop>
				</cfloop>
			</cfif>
			
			<cfscript>
				/* NEXT
					getShipping = application.Shipping.CalculateShipping(
									UserID = UserID,
									SiteID = application.SiteID,
									SessionID = SessionID,
									ShipBy = 3
									) ; */
				if ( NOT data.RecordCount )
				{
					stReturn.bSuccess = False ;
					stReturn.data = data ;
					// stReturn.data2 = data2 ;
					stReturn.message = "No information was available for that criteria" ;
				}
				else
				{
					stReturn.bSuccess = True ;
					stReturn.data = data ;
					// stReturn.data2 = data2 ;
					stReturn.message = "Success" ;
				}
			</cfscript>
			
			<cfcatch>
				<cfscript>
					stReturn.bSuccess = False ;
					stReturn.message = cfcatch.message & "<br><br>" & cfcatch.detail ;
					stReturn.stError = cfcatch ;
				</cfscript>
			</cfcatch>
			
		</cftry>
				
		<cfreturn stReturn >
	</cffunction>
	
	
	
	<!--- *CARTFUSION 4.7 - getCARTTOTAL CFC* --->
	<cffunction name="getCartTotal" displayname="Get Cart Total" hint="Function to retrieve total value of cart items." output="no" >
		<cfargument name="UserID" displayname="UserID" hint="The Price and Hide Columns of the Products to get, depending on User" type="numeric" required="yes">
		<cfargument name="SiteID" displayname="SiteID" hint="The CartFusion Site ID of the Products to get" type="numeric" required="yes">
		<cfargument name="SessionID" displayname="SessionID" hint="The CartFusion Session ID of the current customer linked to the cart" type="string" required="yes">
		
		<!--- OLD --->
		<cfquery name="getCartTotal" datasource="#variables.dsn#">
			SELECT 	SUM(c.Qty * p.Price#arguments.UserID#) AS CartTotal
			FROM 	Cart c, Products p
			WHERE 	c.ItemID = p.ItemID
			AND		c.SiteID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.SiteID#">
			AND 	c.sessionID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.SessionID#">
		</cfquery>
		
		<!--- *CARTFUSION 4.7 - CALCULATE AVAILABLE SHIPPING, TAX, DISCOUNTS, CREDIT FOR FINAL CART TOTAL* --->
		
		
		<!--- !CARTFUSION 4.7 - CALCULATE AVAILABLE SHIPPING, TAX, DISCOUNTS, CREDIT FOR FINAL CART TOTAL! --->
		
		<cfset CartTotal = NumberFormat(getCartTotal.CartTotal,0.00) >

		<cfreturn CartTotal >
	</cffunction>
	<!--- !CARTFUSION 4.7 - getCART TOTAL CFC! --->


	<!--- 
		FIND PRODUCT IN CATEGORY
		Used in: 
	--->
	<cffunction name="findProdInCat" displayname="Find Product in Category" hint="Returns a 1 if product is found in category" access="public" returntype="numeric">
		<cfargument name="ItemID" displayname="ItemID" hint="The Item ID to look for in category" type="numeric" required="yes">
		<cfargument name="CatID" displayname="Category ID" hint="The Category ID where the product should be located" type="numeric" required="yes">

		<cfquery name="findProdInCat" datasource="#variables.dsn#">
			SELECT 	ItemID
			FROM 	Products
			WHERE 	ItemID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ItemID#">
			AND		(Category = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.CatID#">
			OR 		OtherCategories LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="'%,#arguments.CatID#,%'"> )
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

		<cfquery name="findProdInSec" datasource="#variables.dsn#">
			SELECT 	ItemID
			FROM 	Products
			WHERE 	ItemID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ItemID#">
			AND		(SectionID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.SectionID#">
			OR 		OtherSections LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="'%,#arguments.SectionID#,%'"> )
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

		<cfquery name="getDiscountUsage" datasource="#variables.dsn#">
			SELECT 	COUNT(*) AS DiscountUsage
			FROM 	DiscountUsage
			WHERE 	DiscountID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.DiscountID#">
			<cfif StructKeyExists(arguments,'CustomerID') AND arguments.CustomerID NEQ ''>
			AND		CustomerID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.CustomerID#">
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
		
		<cfquery name="getItemPrice" datasource="#variables.dsn#">
			SELECT 	Price#arguments.UserID# AS ItemPrice
			FROM 	Products
			WHERE 	ItemID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ItemID#">
		</cfquery>
		
		<cfif getItemPrice.RecordCount NEQ 0 >
	
			<!--- RETURN THE PRICE FOUND IN TABLE.PRODUCTS --->
			<cfscript>
				UseThisPrice = getItemPrice.ItemPrice ;
			</cfscript>
			
			<!---
				CALCULATE PRODUCT OPTION PRICES
			 --->
			<cfif (StructKeyExists(arguments,'OptionName1') AND arguments.OptionName1 NEQ '')>
			
				<!--- CHECK OPTION PRICES FIRST --->
				<cfquery name="getOptionPrice" datasource="#variables.dsn#">
					SELECT 	OptionPrice
					FROM 	ProductOptions
					WHERE 	ItemID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ItemID#">
					AND		OptionName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.OptionName1#">
				</cfquery>
				
				<cfif getOptionPrice.RecordCount NEQ 0 >
					<cfset UseThisPrice = UseThisPrice + getOptionPrice.OptionPrice >
				
				<!--- OTHERWISE, CHECK MATRIX PRICES SECOND --->
				<cfelse>
					<cfquery name="getCompPrice" datasource="#variables.dsn#">
						SELECT 	CompPrice
						FROM 	ItemClassComponents
						WHERE 	ItemID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ItemID#">
						AND		Detail1 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.OptionName1#">
						<cfif (StructKeyExists(arguments,'OptionName2') AND arguments.OptionName2 NEQ '')>
						AND		Detail2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.OptionName2#">
						</cfif>
						<cfif (StructKeyExists(arguments,'OptionName3') AND arguments.OptionName3 NEQ '')>
						AND		Detail3 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.OptionName3#">
						</cfif>
					</cfquery>
					
					<cfif getCompPrice.RecordCount NEQ 0 >
						<cfset UseThisPrice = UseThisPrice + getCompPrice.CompPrice >
					</cfif>
					
				</cfif>
				
			</cfif>
			<cfif (StructKeyExists(arguments,'OptionName2') AND arguments.OptionName2 NEQ '')>
			
				<cfquery name="getOptionPrice" datasource="#variables.dsn#">
					SELECT 	OptionPrice
					FROM 	ProductOptions
					WHERE 	ItemID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ItemID#">
					AND		OptionName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.OptionName2#">
				</cfquery>
				
				<cfif getOptionPrice.RecordCount NEQ 0 >
					<cfset UseThisPrice = UseThisPrice + getOptionPrice.OptionPrice >
				</cfif>
				
			</cfif>
			<cfif (StructKeyExists(arguments,'OptionName3') AND arguments.OptionName3 NEQ '')>
			
				<cfquery name="getOptionPrice" datasource="#variables.dsn#">
					SELECT 	OptionPrice
					FROM 	ProductOptions
					WHERE 	ItemID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ItemID#">
					AND		OptionName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.OptionName3#">
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
		
		<cfif StructKeyExists(arguments,'ShippingMethod') >
			<cfquery name="getShipID" datasource="#variables.dsn#">
				SELECT	SMID
				FROM	ShippingMethods
				WHERE	ShippingCode = '#arguments.ShippingMethod#'
			</cfquery>		
		</cfif>
		
		<cfquery name="getDiscounts" datasource="#variables.dsn#">
			SELECT	*
			FROM	Discounts d
			WHERE   d.DateValidFrom <= <cfqueryparam cfsqltype="cf_sql_date" value="#Now()#" >
			AND 	d.DateValidTo >= <cfqueryparam cfsqltype="cf_sql_date" value="#Now()#" >
			AND		(d.Expired = 0 or d.Expired IS NULL)
			AND 	d.SiteID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.SiteID#">
			AND 	d.AutoApply = 1
			AND	(d.ApplyToUser = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.UserID#" > OR d.ApplyToUser = 0)
			<cfif isDefined('getShipID') AND getShipID.RecordCount NEQ 0 >
			AND		d.ApplyTo = <cfqueryparam cfsqltype="cf_sql_integer" value="#getShipID.SMID#">
			AND		d.ApplyToType = <cfqueryparam cfsqltype="cf_sql_integer" value="5">
			<cfelse>
			AND 	d.ApplyToType = <cfqueryparam cfsqltype="cf_sql_integer" value="4">
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
							
				<cfscript>
					// SET DEFAULT VARIABLE TO CONTINUE WITH DISCOUNT
					GoAhead = 1 ;
					// CHECK FOR CUSTOMER USAGE LIMITS & TOTAL USAGE LIMITS
					if ( UsageLimitCust GT 0 ) {
						// CHECK FOR A PRODUCT IN THE REQUIRED SECTION
						DiscountUsage = application.Cart.getDiscountUsage(DiscountID=getDiscounts.DiscountID,CustomerID=session.CustomerArray[17]) ;
						if ( UsageLimitCust LTE DiscountUsage ) {
							GoAhead = 0 ;
						}
					}
					if ( UsageLimitTotal GT 0 ) {
						// CHECK FOR A PRODUCT IN THE REQUIRED SECTION
						DiscountUsage = application.Cart.getDiscountUsage(DiscountID=getDiscounts.DiscountID) ;
						if ( UsageLimitTotal LTE DiscountUsage ) {
							GoAhead = 0 ;
						}
					}
					if ( GoAhead EQ 1 ) {
						// CHECK FOR REQUIRED PRODUCT
						if ( AddPurchaseReq EQ 0 ) {
							// DO NOTHING
						// CHECK FOR A CERTAIN REQUIRED PRODUCT IN THE CART
						} else if ( AddPurchaseReq EQ 1 ) {
							getCartItems = application.Cart.getCartItems(UserID=arguments.UserID,SiteID=arguments.SiteID,SessionID=arguments.SessionID,ItemID=AddPurchaseVal) ;
							if ( getCartItems.data.RecordCount EQ 0 ) {
								GoAhead = 0 ;
							}
						// CHECK FOR A PRODUCT IN THE REQUIRED CATEGORY
						} else if ( AddPurchaseReq EQ 2 ) {
							getCartItems = application.Cart.getCartItems(UserID=arguments.UserID,SiteID=arguments.SiteID,SessionID=arguments.SessionID,CatID=AddPurchaseVal) ;
							if ( getCartItems.data.RecordCount EQ 0 ) {
								GoAhead = 0 ;
							}
						// CHECK FOR A PRODUCT IN THE REQUIRED SECTION
						} else if ( AddPurchaseReq EQ 3 ) {
							getCartItems = application.Cart.getCartItems(UserID=arguments.UserID,SiteID=arguments.SiteID,SessionID=arguments.SessionID,SectionID=AddPurchaseVal) ;
							if ( getCartItems.data.RecordCount EQ 0 ) {
								GoAhead = 0 ;
							}
						}
						if ( GoAhead EQ 1 ) {
							// CHECK FOR ALLOW MULTIPLES
							// ONLY APPLY ONCE TO A PRODUCT
							
							// GET CART TOTAL
							getCartTotal = application.Cart.getCartTotal(UserID=arguments.UserID,SiteID=arguments.SiteID,SessionID=arguments.SessionID) ;
							CartTotal = getCartTotal.CartTotal ;
							if ( CartTotal LT OrderTotalLevel ) {
								GoAhead = 0 ;
							}
							if ( GoAhead EQ 1 ) {
								// ALL SHIPPING METHODS
								if ( ApplyToType EQ 4 ) {
									ShippingDiscount.All = 1 ;
									ShippingDiscount.ID = getDiscounts.DiscountID ;
									ShippingDiscount.Value = getDiscounts.DiscountValue ;
									ShippingDiscount.ShipMethod = '' ;
									ShippingDiscount.DiscountMessage = getDiscounts.DiscountName ;
									if ( IsPercentage EQ 1 )
										ShippingDiscount.Type = 1 ;
									else
										ShippingDiscount.Type = 0 ;
								}
								// SPECIFIC SHIPPING METHOD
								if ( ApplyToType EQ 5 ) {
									ShippingDiscount.All = 0 ;
									ShippingDiscount.ID = getDiscounts.DiscountID ;
									ShippingDiscount.Value = getDiscounts.DiscountValue ;
									ShippingDiscount.DiscountMessage = getDiscounts.DiscountName ;
									if ( StructKeyExists(arguments,'ShippingMethod') )
										ShippingDiscount.ShipMethod = arguments.ShippingMethod ;
									else
										ShippingDiscount.ShipMethod = '' ;
									if ( IsPercentage EQ 1 )
										ShippingDiscount.Type = 1 ;
									else
										ShippingDiscount.Type = 0 ;
								}
							}
						}
					}
				</cfscript>

			</cfoutput>
		</cfif>
		
		<cfreturn ShippingDiscount >
	</cffunction>
	
</cfcomponent>
<!--- !CARTFUSION 4.7 - CART CFC! --->