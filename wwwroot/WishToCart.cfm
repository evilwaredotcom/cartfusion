<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<!--- Get all products from Wishlist to add to cart --->
<cfif session.CustomerArray[17] NEQ '' >
	
	<cfscript>
		getWishList = application.Common.getCustomerWishList(CustomerID=session.CustomerArray[17],SiteID=application.SiteID);
	</cfscript>
	
	<!--- BEGIN: SAVE WISHLIST INTO CART --->
	
	<cfoutput query="getWishlist">
		
		<!--- LOOKUP PRODUCT IN CART --->
		<cfinvoke component="#application.Common#" method="getCart" returnvariable="getCart">
			<cfinvokeargument name="SessionID" value="#Variables.SessionID#">
			<cfinvokeargument name="SiteID" value="#application.SiteID#">
			<cfinvokeargument name="ItemID" value="#ItemID#">
			<cfif isDefined("OptionName1") AND OptionName1 NEQ ''>
				<cfinvokeargument name="OptionName1" value="#OptionName1#">
			</cfif>
			<cfif isDefined("OptionName2") AND OptionName2 NEQ ''>
				<cfinvokeargument name="OptionName2" value="#OptionName2#">
			</cfif>
			<cfif isDefined("OptionName3") AND OptionName3 NEQ ''>
				<cfinvokeargument name="OptionName3" value="#OptionName3#">
			</cfif>
		</cfinvoke>
				
		<!--- If there is no other record with the same combo --->
		<cfif getCart.RecordCount EQ 0 >
			
			<!--- INSERT INTO CART --->
			<cfinvoke component="#application.Common#" method="insertCart">
				<cfinvokeargument name="SessionID" value="#Variables.SessionID#">
				<cfinvokeargument name="CustomerID" value="#session.CustomerArray[17]#">
				<cfinvokeargument name="SiteID" value="#application.SiteID#">
				<cfinvokeargument name="ItemID" value="#ItemID#">
				<cfinvokeargument name="Quantity" value="#Qty#">
				<cfif isDefined("OptionName1") AND OptionName1 NEQ ''>
					<cfinvokeargument name="OptionName1" value="#OptionName1#">
				</cfif>
				<cfif isDefined("OptionName2") AND OptionName2 NEQ ''>
					<cfinvokeargument name="OptionName2" value="#OptionName2#">
				</cfif>
				<cfif isDefined("OptionName3") AND OptionName3 NEQ ''>
					<cfinvokeargument name="OptionName3" value="#OptionName3#">
				</cfif>
				<cfif BackOrdered IS 1 >
					<cfinvokeargument name="BackOrdered" value="1">
				</cfif>
			</cfinvoke>

		<cfelse><!--- ALREADY EXISTS --->
		
			<cftry>
				
				<!--- UPDATE CART --->
				<cfscript>
					updateCart = application.Common.updateCart(
						SessionID=Variables.SessionID,
						SiteID=application.SiteID,
						ItemID=getWishlist.ItemID,
						Quantity=getWishlist.Qty,
						CartItemID=getCart.CartItemID,
						CustomerID=session.CustomerArray[17]);
				</cfscript>
				
				<cfcatch>
					<div class="cfErrorMsg" align="center">NOT UPDATED</div>
				</cfcatch>
			</cftry>
		</cfif>
	</cfoutput>
	
	<cflocation url="CartEdit.cfm" addtoken="no">

<!--- END: SAVE WISHLIST INTO CART --->

<cfelse>
	NOT SIGNED IN <cflocation url="CA-Login.cfm" addtoken="no">
</cfif>