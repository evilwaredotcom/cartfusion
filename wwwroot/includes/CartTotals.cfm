<!--- INVOKE INSTANCE OF OBJECT - GET CART ITEMS --->
<cfscript>
	if ( TRIM(session.CustomerArray[28]) NEQ '' ) {
		UserID = session.CustomerArray[28] ;
	} else {
		UserID = 1 ;
	}
	getCartItems = application.Cart.getCartItems(
		UserID=UserID,
		SiteID=application.SiteID,
		SessionID=SessionID) ;
</cfscript>

<!--- CARTFUSION 4.5 - MULTIPLE SHIPPING ADDRESSES --->	
<cfquery name="getDistinctAddresses" dbtype="query">
	SELECT 	DISTINCT ShippingID
	FROM	getCartItems.data
</cfquery>
<cfscript>
	Cart = StructNew() ;
	if ( getDistinctAddresses.RecordCount LTE 0 ) {
		Cart.Packages = 1 ;
	} 
	else {
		Cart.Packages = getDistinctAddresses.RecordCount ;
	}
	Cart.CartTotal = 0 ;
	Cart.CartWeight = 0 ;
	Cart.CartQty = 0 ;
	localTotalPrice = 0 ;
	localTotalWeight = 0 ;
</cfscript>

<cfif getDistinctAddresses.RecordCount >
	<cfloop query="getDistinctAddresses">
		
		<cfset cpi = CurrentRow >
		<cfset 'Cart.CartQty#cpi#' = 0 >
		
		<cfquery name="getPackageItems" dbtype="query">
			SELECT	*
			FROM	getCartItems.data
			WHERE	ShippingID = #getDistinctAddresses.ShippingID#
		</cfquery>
		
		<cfloop query="getPackageItems">
			<cfset ThisQty = getPackageItems.Qty >
			<!--- INVOKE INSTANCE OF OBJECT - GET PRODUCT PRICE, INCLUDING ANY DISCOUNTS --->
			<cfscript>
				UseThisPrice = application.Cart.getItemPrice(
					UserID=UserID,
					SiteID=application.SiteID,
					ItemID=ItemID,
					SessionID=SessionID,
					OptionName1=OptionName1,
					OptionName2=OptionName2,
					OptionName3=OptionName3
					) ;
				localTotalPrice = localTotalPrice + (UseThisPrice * ThisQty) ;
				localTotalWeight = localTotalWeight + (getPackageItems.Weight * ThisQty) ;
				'Cart.CartQty#cpi#' = Evaluate('Cart.CartQty' & cpi) + ThisQty ;
				Cart.CartQty = Cart.CartQty + ThisQty ;
			</cfscript>
		</cfloop>

		<cfscript>
			'Cart.CartTotal#cpi#' = localTotalPrice ;
			'Cart.CartWeight#cpi#' = localTotalWeight ;				
			Cart.CartTotal = Cart.CartTotal + localTotalPrice ;
			Cart.CartWeight = Cart.CartWeight + localTotalWeight ;
			localTotalPrice = 0 ;
			localTotalWeight = 0 ;
		</cfscript>

	</cfloop>
</cfif>

