

<cfif structKeyExists(form, 'ShippingID') AND NOT structKeyExists(form, 'UpdateButton') AND not isDefined('RemoveButton')>

	<cfif form.ShippingID EQ 'add' >
		<cflocation url="CA-CustomerArea.cfm?Show5=1" addtoken="no">
	<cfelse>
		
		<cfscript>
			updateCustomerSH = application.Queries.updateCustomerShipping(ShippingID=form.ShippingID, CartItemID=form.CartItemID);
		</cfscript>
		
		<cflocation url="CartEdit.cfm" addtoken="no">
	</cfif>
<!--- CARTFUSION 4.5 - MULTIPLE SHIPPING ADDRESSES --->

<cfelse>
<!---
   Verify if the Quantity in stock is QtyIsEnough to this order
   If not and you cannot sell items out of stock, edit or cancel the order for this item.
--->
<cfif isDefined('Quantity') AND Quantity GT 0 >

	<!--- QUERIES --->
	<cfscript>
		getProduct = application.common.getProductDetail(ItemID=ItemID);
		QtyIsEnough = 1;
	</cfscript>
	
	<!--- BEGIN: CHECK STOCK QUANTITIES AND DISPLAY OPTIONS --->
	<cfif not isDefined('RemoveButton') >
		<!--- INVENTORY MATRIX (ACCURATE) --->
		<cfif getProduct.UseMatrix EQ 1 >
			<cfquery name="checkInventory" datasource="#application.dsn#">
				SELECT	CompQuantity AS QtyAvailable, CompSellByStock
				FROM	ItemClassComponents
				WHERE	ItemID = #ItemID#
				AND	   ((CompSellByStock = 1 AND CompQuantity > 0)
				OR	   ((CompSellByStock = 0 OR CompSellByStock IS NULL) AND (CompStatus = 'IS' OR CompStatus = 'BO')))
				<cfif isDefined("OptionName1") AND OptionName1 NEQ ''>
					AND Detail1 = '#OptionName1#'
				</cfif>
				<cfif isDefined("OptionName2") AND OptionName2 NEQ ''>
					AND Detail2 = '#OptionName2#'
				</cfif>
				<cfif isDefined("OptionName3") AND OptionName3 NEQ ''>
					AND Detail3 = '#OptionName3#'
				</cfif>
			</cfquery>
			
			<!--- Start BackOrders NOT allowed: ORDER MAXIMUM NUMBER or RETURN TO STORE --->
			<cfif checkInventory.CompSellByStock EQ 1 AND checkInventory.QtyAvailable LT Quantity >
				<cfmodule template="templates/#application.SiteTemplate#/layout.cfm" currenttab="ViewCart" pagetitle="Update Cart">	

				<!--- Start Breadcrumb --->
				<cfmodule template="tags/breadCrumbs.cfm" crumblevel='1' showlinkcrumb="Update Cart" />
				<!--- End BreadCrumb --->
				
					<cfoutput>
					<div class="cfHeading" align="center">#application.Storename# Item Details</div>
					<!--- <div align="center"><hr width="70%" size="1"></div> --->
					<br/>
					<div class="cfErrorMsg" align="center">We are sorry, but the quantity in stock for this item is insufficient for this order.</div>
					<br/>
					<div id="formContainer">
					<form action="CartUpdate.cfm" method="post">
						<input type="submit" name="button" value="Order Maximum Quantity Available (#checkInventory.QtyAvailable#)" class="button2">
						<input type="button" name="button" value="Return to Item" onclick="javascript:history.back();" class="button">
						<input type="hidden" name="Quantity" value="#checkInventory.QtyAvailable#">
						<input type="hidden" name="ItemID" value="#ItemID#">
						<cfif isDefined("OptionName1") AND OptionName1 NEQ ''>
							<input type="hidden" name="OptionName1" value="#OptionName1#">
						</cfif>
						<cfif isDefined("OptionName2") AND OptionName2 NEQ ''>
							<input type="hidden" name="OptionName2" value="#OptionName2#">
						</cfif>
						<cfif isDefined("OptionName3") AND OptionName3 NEQ ''>
							<input type="hidden" name="OptionName3" value="#OptionName3#">
						</cfif>
					</form>
					</div>
					</cfoutput>
				</cfmodule>
				
				<cfabort>
			
			<cfelse>
				<cfset QtyIsEnough = 1>
			</cfif>
			<!--- End BackOrders NOT allowed: ORDER MAXIMUM NUMBER or RETURN TO STORE --->
			
			
		<!--- NO PRODUCT OPTIONS OR INVENTORY MATRIX ITEMS --->
		<!--- BackOrders NOT allowed: ORDER MAXIMUM NUMBER or RETURN TO STORE --->
		<cfelseif getProduct.SellByStock EQ 1 AND getProduct.StockQuantity LT Quantity >
			<cfset QtyIsEnough = 0 >
			
			<cfmodule template="templates/#application.SiteTemplate#/layout.cfm" currenttab="ViewCart" pagetitle="Update Cart">	

				<!--- Start Breadcrumb --->
				<cfmodule template="tags/breadCrumbs.cfm" crumblevel='1' showlinkcrumb="Update Cart" />
				<!--- End BreadCrumb --->
			
			
				<cfoutput>
				<div class="cfHeading" align="center">#application.Storename# Item Details</div>
				<br/>
				<!--- <div align="center"><hr width="70%" size="1"></div> --->
				<div class="cfErrorMsg" align="center">We are sorry, but the quantity in stock for this item is insufficient for this order.</div>
				<br/>
				<div id="formContainer">
					<form action="CartUpdate.cfm" method="post">
						<input type="submit" name="UpdateButton" value="Order Maximum Quantity Available (#getProduct.StockQuantity#)" class="button2">
						<input type="button" name="button" value="Return to Item" onclick="javascript:history.back();" class="button">
						<input type="hidden" name="Quantity" value="#getProduct.StockQuantity#">
						<input type="hidden" name="ItemID" value="#ItemID#">
						<cfif isDefined("OptionName1") AND OptionName1 NEQ ''>
							<input type="hidden" name="OptionName1" value="#OptionName1#">
						</cfif>
						<cfif isDefined("OptionName2") AND OptionName2 NEQ ''>
							<input type="hidden" name="OptionName2" value="#OptionName2#">
						</cfif>
						<cfif isDefined("OptionName3") AND OptionName3 NEQ ''>
							<input type="hidden" name="OptionName3" value="#OptionName3#">
						</cfif>
					</form>
				</div>
				</cfoutput>
			</cfmodule>
			<cfabort>		
		<cfelse>
			<cfset QtyIsEnough = 1>
		</cfif>
	</cfif>
	<!--- END: CHECK STOCK QUANTITIES AND DISPLAY OPTIONS --->

<!---
Keep adding records into the shopping cart for the number of items.
--->
	
	<cfif QtyIsEnough EQ 1>
	
		<!--- BEGIN: ADD ITEMS TO WISHLIST --->
		<cfif IsDefined("AddButton")>
			<cfif session.CustomerArray[17] EQ ''>
				<cflocation url="CA-Login.cfm?goToPage=CartUpdate.cfm?SaveCart=Yes" addtoken="no">
			<cfelse>
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
				<cfif not getWishList.RecordCount>
				
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
						<cfif getProduct.ItemStatus IS 'BO'>
							<cfinvokeargument name="BackOrdered" value="1">
						</cfif>
					</cfinvoke>
					
				<cfelse>		
					<cfoutput query="getWishList">
						<cfset newQuantity = Qty + Quantity >
					</cfoutput>
					
					<!--- UPDATE WISHLIST --->
					<cfinvoke component="#application.Common#" method="updateWishlist">
						<cfinvokeargument name="CustomerID" value="#session.CustomerArray[17]#">
						<cfinvokeargument name="SiteID" value="#application.SiteID#">
						<cfinvokeargument name="Quantity" value="#newQuantity#">
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
				<cflocation url="CA-CustomerArea.cfm" addtoken="no">							
			</cfif>
		</cfif>
		<!--- END: ADD ITEMS TO WISHLIST --->
		
		<!--- Check if there is another record in the cart table that contains the same ItemID --->
		<!--- LOOKUP PRODUCT IN CART --->
		<cfinvoke component="#application.Common#" method="getCart" returnvariable="getCart">
			<cfinvokeargument name="SessionID" value="#SessionID#">
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
		<cfif not getCart.RecordCount>
			
			<!--- INSERT INTO CART --->
			<cfinvoke component="#application.Common#" method="insertCart">
				<cfinvokeargument name="SessionID" value="#SessionID#">
				<cfinvokeargument name="SiteID" value="#application.SiteID#">
				<cfinvokeargument name="ItemID" value="#ItemID#">
				<cfinvokeargument name="Quantity" value="#Quantity#">
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
				<cfif isDefined('BackOrdered') AND BackOrdered IS 1 >
					<cfinvokeargument name="BackOrdered" value="1">
				</cfif>				
				<!--- *CARTFUSION 4.6 - PRODUCT-SPECIFIC SHIPPING* --->
				<cfif isDefined("ShippingCodesAvailable") AND ShippingCodesAvailable NEQ ''>
					<cfinvokeargument name="ShippingCodesAvailable" value="#ShippingCodesAvailable#">
				</cfif>
				<cfif isDefined("ShippingCodesUsed") AND ShippingCodesUsed NEQ ''>
					<cfinvokeargument name="ShippingCodesUsed" value="#ShippingCodesUsed#">
				</cfif>
				<cfif isDefined("ShippingCodeAmount") AND ShippingCodeAmount NEQ ''>
					<cfinvokeargument name="ShippingCodeAmount" value="#ShippingCodeAmount#">
				</cfif>
				<cfif isDefined("ShippingAmount") AND ShippingAmount NEQ ''>
					<cfinvokeargument name="ShippingAmount" value="#ShippingAmount#">
				</cfif>
				<cfif isDefined("HandlingAmount") AND HandlingAmount NEQ ''>
					<cfinvokeargument name="HandlingAmount" value="#HandlingAmount#">
				</cfif>
				<!--- !CARTFUSION 4.6 - PRODUCT-SPECIFIC SHIPPING! --->
			</cfinvoke>
			
		<!--- Else, if customer clicked the Remove button, delete item from cart --->
		<cfelseif IsDefined("RemoveButton")>
			
			<!--- DELETE ITEM IN CART --->
			<cfinvoke component="#application.Common#" method="deleteCart">
				<cfinvokeargument name="SessionID" value="#SessionID#">
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
			
		<!--- Else, if customer hit the Update button, update item Quantity in cart --->
		<cfelseif IsDefined("UpdateButton")>

			<!--- UPDATE CART --->
			<cfinvoke component="#application.Common#" method="updateCart">
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
			</cfinvoke>
				
		<!--- ELSE, if customer added another identical item, update item Quantity in cart --->
		<cfelse>			
			<cfoutput query="getCart">
				<!--- BackOrders NOT allowed: ORDER MAXIMUM NUMBER or RETURN TO STORE --->
				<cfif (isDefined('checkInventory.QtyAvailable') AND checkInventory.CompSellByStock eq 1 AND checkInventory.QtyAvailable LT (Qty + Quantity))
				   OR (not isDefined('checkInventory.QtyAvailable') AND getProduct.SellByStock EQ 1 AND getProduct.StockQuantity LT (Qty + Quantity)) >
					<cfset QtyIsEnough = 0 >
					
					
					<cfmodule template="templates/#application.SiteTemplate#/layout.cfm" currenttab="ViewCart" pagetitle="Update Cart">	

						<!--- Start Breadcrumb --->
						<cfmodule template="tags/breadCrumbs.cfm" crumblevel='1' showlinkcrumb="Update Cart" />
						<!--- End BreadCrumb --->
					
					<div class="cfHeading" align="center">#application.Storename# Item Details</div>
					<!--- <div align="center"><hr width="70%" size="1"></div> --->
					<br/>
					<div class="cfErrorMsg" align="center">We are sorry, but the quantity in stock for this item is insufficient for this order.</div>
					<br/>
					<div id="formContainer">
					<form action="CartUpdate.cfm" method="post">
						<cfif isDefined('checkInventory.QtyAvailable') AND checkInventory.QtyAvailable LT (Qty + Quantity) >
						<input type="submit" name="UpdateButton" value="Order Maximum Quantity Available (#checkInventory.QtyAvailable#)" class="button2">
						<input type="button" name="button" value="Return to Item" onclick="javascript:history.back();" class="button">
						<input type="hidden" name="Quantity" value="#checkInventory.QtyAvailable#">
						<cfelse>
						<input type="submit" name="UpdateButton" value="Order Maximum Quantity Available (#getProduct.StockQuantity#)" class="button2">
						<input type="button" name="button" value="Return to Item" onclick="javascript:history.back();" class="button">
						<input type="hidden" name="Quantity" value="#getProduct.StockQuantity#">
						</cfif>
						<input type="hidden" name="ItemID" value="#ItemID#">
						<cfif isDefined("OptionName1") AND OptionName1 NEQ ''>
							<input type="hidden" name="OptionName1" value="#OptionName1#">
						</cfif>
						<cfif isDefined("OptionName2") AND OptionName2 NEQ ''>
							<input type="hidden" name="OptionName2" value="#OptionName2#">
						</cfif>
						<cfif isDefined("OptionName3") AND OptionName3 NEQ ''>
							<input type="hidden" name="OptionName3" value="#OptionName3#">
						</cfif>
					</form>
					
					<form action="index.cfm" method="Post">
						<input class="cfButton" type="submit" name="button" value="Return to Store">
					</form>
					</div>
					</cfmodule>
					<cfabort>
				<cfelse>
					<cfset newQuantity = Qty + Quantity >
				</cfif>
			</cfoutput>
			
			<!--- UPDATE CART --->
			<cfinvoke component="#application.Common#" method="updateCart">
				<cfinvokeargument name="SessionID" value="#SessionID#">
				<cfinvokeargument name="SiteID" value="#application.SiteID#">
				<cfinvokeargument name="ItemID" value="#ItemID#">
				<cfinvokeargument name="Quantity" value="#newQuantity#">
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
							
		</cfif><!--- END: <cfif productAlreadyExists eq 0> --->
	</cfif><!--- END: <cfif QtyIsEnough EQ 1> --->
</cfif><!--- END: <cfif isDefined('Quantity') AND Quantity LTE 0> --->	 
</cfif><!--- END: <cfif isDefined('FORM.ShippingID') AND NOT isDefined('FORM.UpdateButton') AND NOT isDefined('RemoveButton')> --->



<!--- DON'T SHOW CART AFTER PRODUCT ADDED TO CART --->
<!---
<cfif CGI.HTTP_REFERER CONTAINS 'CartUpdate.cfm' >
--->
	<cflocation url="CartEdit.cfm" addtoken="no">
<!---
<cfelse>
	<cflocation url="#CGI.HTTP_REFERER#" addtoken="no">
</cfif>
--->