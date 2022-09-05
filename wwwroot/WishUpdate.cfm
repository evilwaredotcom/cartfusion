


<!--- BEGIN: CLEAN WISHLIST--->
<cfif isDefined('CleanWish') AND CleanWish EQ 'Yes'>
	<cfscript>
		application.Common.deleteWishList(CustomerID=session.CustomerArray[17],SiteID=application.SiteID);
	</cfscript>
	
	<cfoutput><cflocation url="#CGI.HTTP_REFERER#" addtoken="no"></cfoutput>
</cfif>
<!--- END: CLEAN WISHLIST --->


<!--- BEGIN: SAVE CART as wishlist --->
<cfif isDefined('SaveCart') AND SaveCart EQ 'Yes'>
	
	<!--- INVOKE INSTANCE OF OBJECT - GET CART ITEMS --->
	<!--- CARTFUSION 4.6 - CART CFC --->
	<cfscript>
		if ( TRIM(session.CustomerArray[28]) NEQ '' ) {
			UserID = session.CustomerArray[28] ;
		} else {
			UserID = 1 ;
		}
		getCartItems = application.Cart.getCartItems(UserID=UserID,SiteID=application.SiteID,SessionID=SessionID) ;
	</cfscript>
	
	<!--- IF CART IS EMPTY --->
	<cfif not getCartItems.data.RecordCount>
	
		<cfmodule template="templates/#application.SiteTemplate#/layout.cfm" currenttab="MyAccount" pagetitle="Update Wishlist">
			<br/>
			<br/>
			<div class="cfErrorMsg" align="center">There are no items in your cart.</div>
			<div align="center">
				<br/>
				<hr class="snip" />
				<br/>
				<input type="button" name="GoBack" value="&lt; BACK" class="button2" onclick="javascript:history.back();"> 
				<input type="button" name="GoHome" value="HOME &gt;" class="button2" onclick="javascript:document.location.href='index.cfm';">
			</div>
		
		</cfmodule>
		
	 	<cfabort>
	</cfif>
	
	<cfoutput query="getCartItems.data">
		<!--- GET WISHLIST --->
		<cfinvoke component="#application.Common#" method="getCustomerWishList" returnvariable="getWishList">
			<cfinvokeargument name="CustomerID" value="#session.CustomerArray[17]#">
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
		<cfif getWishList.RecordCount EQ 0 >
			
			<!--- INSERT INTO WISHLIST --->
			<cfinvoke component="#application.Common#" method="insertWishList">
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
				<cfif isDefined("ItemStatus") AND ItemStatus IS 'BO'>
					<cfinvokeargument name="BackOrdered" value="1">
				</cfif>
			</cfinvoke>
			
		<cfelse>
		
			<!--- UPDATE WISHLIST --->
			<cfinvoke component="#application.Common#" method="updateWishlist">
				<cfinvokeargument name="CustomerID" value="#session.CustomerArray[17]#">
				<cfinvokeargument name="SiteID" value="#application.SiteID#">
				<cfinvokeargument name="Quantity" value="#Qty#">
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
			
		</cfif>
	</cfoutput>

	<cfoutput><cflocation url="CA-CustomerArea.cfm?show1=1" addtoken="no"></cfoutput>
</cfif>
<!--- END: SAVE CART as wishlist--->

<!--- BEGIN: ADD TO WISHLIST AFTER SIGNING IN --->
<cfif isDefined('session.TempWishlist') AND NOT StructIsEmpty(session.TempWishlist)>
	<cfscript>
		variables.ItemID = session.TempWishlist.ItemID;
		variables.Quantity = session.TempWishlist.Quantity;
		if (isDefined('session.TempWishlist.OptionName1') AND session.TempWishlist.OptionName1 NEQ '')
			variables.OptionName1 = session.TempWishlist.OptionName1;
		if (isDefined('session.TempWishlist.OptionName2') AND session.TempWishlist.OptionName2 NEQ '')
			variables.OptionName2 = session.TempWishlist.OptionName2;
		if (isDefined('session.TempWishlist.OptionName3') AND session.TempWishlist.OptionName3 NEQ '')
			variables.OptionName3 = session.TempWishlist.OptionName3;
	</cfscript>
	<cfscript>StructDelete(session, "TempWishlist");</cfscript>
</cfif>
<!--- END: ADD TO WISHLIST AFTER SIGNING IN --->
	

<cfif Quantity GT 0>

	<!--- QUERIES --->
	<!--- Added 20 May 2007 --->
	<cfscript>
		getProduct = application.Common.getProductDetail(itemid=ItemID);
	</cfscript>
	
	<!--- BEGIN: CHECK STOCK QUANTITIES AND DISPLAY OPTIONS --->
	<!--- BackOrders NOT allowed: ORDER MAXIMUM NUMBER or RETURN TO STORE --->
	<cfif getProduct.StockQuantity LT Quantity >
		<cfif getProduct.ItemStatus EQ 'IS' OR getProduct.ItemStatus EQ 'BO'>
			<cfset QtyIsEnough = 1 >
		<cfelse>
			<cfset QtyIsEnough = 0 >
			<!--- <cfset PageTitle = 'Update Wishlist'> --->
			
			<!--- Added 20 May 2007 --->
			<cfmodule template="templates/#application.SiteTemplate#/layout.cfm" currenttab="MyAccount" pagetitle="Update Wishlist">
				
				<div class="cfHeading" align="center"><cfoutput>#application.Storename#</cfoutput> Item Details</div>
				<div align="center"><img src="images/design/dash.gif" width="550" height="1"></div>
				<div class="cfErrorMsg" align="center">We are sorry, but the Quantity in stock of this item is insufficient for this order.</div>
				<div align="center">
				<cfoutput query="getProduct">
					<form action="WishUpdate.cfm" method="post">
						<input class="cfButton" type="submit" name="button" value="Order Max. Number">
						<input type="hidden" name="Quantity" value="#StockQuantity#">
						<input type="hidden" name="ItemID" value="#ItemID#">
					</form>				
					<form action="index.cfm" method="Post">
						<input class="cfButton" type="submit" name="button" value="Return to Store">
					</form>
				</cfoutput>
				</div>
			
			</cfmodule>
			
			<cfabort>
		</cfif>
	<cfelse>
		<cfset QtyIsEnough = 1>
	</cfif>	
		
	
	<!--- END: CHECK STOCK QUANTITIES AND DISPLAY OPTIONS --->
	
<!---
Keep adding records into the shopping cart for the number of items.
--->

	<cfif QtyIsEnough EQ 1>
		
		<cfif IsDefined("AddButton")>
			
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
					<cfinvokeargument name="SessionID" value="#SessionID#">
					<cfinvokeargument name="SiteID" value="#application.SiteID#">
					<cfinvokeargument name="ItemID" value="#ItemID#">
					<cfinvokeargument name="Quantity" value="#Quantity#">
					<cfif isDefined("OptionName1") AND OptionName1 NEQ ''>
						<cfinvokeargument name="OptionName1" value="#OptionName1#">
					</cfif>
					<cfif isDefined("OptionName2") AND OptionName2 NEQ ''>
						<cfinvokeargument name="OptionName2" value="#OptionName2#">
					</cfif>
					<cfif isDefined("OptionName3") AND OptionName3 NEQ ''>
						<cfinvokeargument name="OptionName3" value="#OptionName3#">
					</cfif>
					<cfif getProduct.ItemStatus IS 'BO'>
						<cfinvokeargument name="BackOrdered" value="1">
					</cfif>
				</cfinvoke>
				
			<cfelse>		
				<cfoutput query="getCart">
					<cfset newQuantity = Qty + Quantity >
				</cfoutput>	
				
				<!--- UPDATE CART --->
				<cfinvoke component="#application.Common#" method="updateCart">
					<cfinvokeargument name="SessionID" value="#SessionID#">
					<cfinvokeargument name="SiteID" value="#application.SiteID#">
					<cfinvokeargument name="ItemID" value="#ItemID#">
					<cfinvokeargument name="Quantity" value="#newQuantity#">
					<cfif session.CustomerArray[17] NEQ ''>
						<cfinvokeargument name="CustomerID" value="#session.CustomerArray[17]#">
					</cfif>
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

			</cfif>
			<cflocation url="CartEdit.cfm" addtoken="no">							
		</cfif>
		
		<!--- Check if there is another record in the cart table that contains the same ItemID --->
		<cfinvoke component="#application.Common#" method="getCustomerWishList" returnvariable="getWishList">
			<cfinvokeargument name="CustomerID" value="#session.CustomerArray[17]#">
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
		<cfif getWishList.RecordCount EQ 0 >
		
			<!--- INSERT INTO WISHLIST --->
			<cfinvoke component="#application.Common#" method="insertWishList">
				<cfinvokeargument name="CustomerID" value="#session.CustomerArray[17]#">
				<cfinvokeargument name="SiteID" value="#application.SiteID#">
				<cfinvokeargument name="ItemID" value="#ItemID#">
				<cfinvokeargument name="Quantity" value="#Quantity#">
				<cfif isDefined("OptionName1") AND OptionName1 NEQ ''>
					<cfinvokeargument name="OptionName1" value="#OptionName1#">
				</cfif>
				<cfif isDefined("OptionName2") AND OptionName2 NEQ ''>
					<cfinvokeargument name="OptionName2" value="#OptionName2#">
				</cfif>
				<cfif isDefined("OptionName3") AND OptionName3 NEQ ''>
					<cfinvokeargument name="OptionName3" value="#OptionName3#">
				</cfif>
				<cfif isDefined("getProduct.ItemStatus") AND getProduct.ItemStatus IS 'BO'>
					<cfinvokeargument name="BackOrdered" value="1">
				</cfif>
			</cfinvoke>

		<!--- Else, calculate the new Quantity and update the cart table --->
		<cfelseif isDefined("RemoveButton")>
			<!--- Added 20 May 2007 --->
			<cfscript>
				deleteWishlist = application.Common.deleteWishList(
					CustomerID=session.CustomerArray[17],
					SiteID=application.SiteID,
					WishlistItemID=getWishList.WishlistItemID);
			</cfscript>
			
		<cfelseif isDefined("UpdateButton")>
			<cfif Quantity GT 0 >
				
				<!--- UPDATE WISHLIST --->
				<!--- Added 20 May 2007 --->
				<cfscript>
					updateWishlist = application.Common.updateWishlist(
						CustomerID=session.CustomerArray[17],
						SiteID=application.SiteID,
						Quantity=Quantity,
						WishlistItemID=getWishList.WishlistItemID);
				</cfscript>
				
			</cfif>
		<cfelse>			
			<cfoutput query="getWishList">
				<cfset newQuantity = Qty + Quantity >
			</cfoutput>
			
			<!--- UPDATE WISHLIST --->
			<!--- Added 20 May 2007 --->
			<cfscript>
				updateWishlist = application.Common.updateWishlist(
					CustomerID=session.CustomerArray[17],
					SiteID=application.SiteID,
					Quantity=newQuantity,
					WishlistItemID=getWishList.WishlistItemID);
			</cfscript>
							
		</cfif><!--- END: <cfif #productAlreadyExists# eq 0> --->
	</cfif><!--- END: <cfif #QtyIsEnough# EQ 1> --->
</cfif><!--- END: <cfif #Quantity# LTE 0> --->

<cflocation url="CA-CustomerArea.cfm?show1=1" addtoken="no">