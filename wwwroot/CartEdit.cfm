<cfscript>
	// Cart Variables
	RunningWeight = 0;
	RunningTotal = 0;
	RunningNorm = 0;
	BackOrdersPrice = 0 ;
	GiftCertTotal = 0;
</cfscript>


<cfoutput>

<cfmodule template="tags/layout.cfm" CurrentTab="ViewCart" PageTitle="Cart Edit">

<!--- Start Breadcrumb --->
<cfmodule template="tags/breadCrumbs.cfm" CrumbLevel='1' showLinkCrumb="Cart Edit" />
<!--- End BreadCrumb --->

<!--- CARTFUSION 4.5 - MULTIPLE SHIPPING ADDRESSES --->	
	<cfscript>
		// If multiship is enabled in application the get customer shipping from database
		if( application.siteConfig.data.EnableMultiShip EQ 1 AND session.CustomerArray[17] NEQ '')	{
			getCustomerShipping = application.Queries.getCustomerShipping(CustomerID=session.CustomerArray[17]);
		}
		
		// CARTFUSION 4.6 - CART CFC
		if( trim(session.CustomerArray[28]) NEQ '' ) {
			UserID = session.CustomerArray[28] ;
		} else {
			UserID = 1 ;
		}
		getCartItems = application.Cart.getCartItems(UserID=UserID,SiteID=application.siteConfig.data.SiteID,SessionID=SessionID) ;
	</cfscript>

<cfif not getCartItems.data.RecordCount>
	<div align="center">
	<br />
	<br />
	<div class="cfErrorMsg">There are no items in your cart.</div>
	<br />
	<br />
	<hr class="snip" />
	<br />
		<a href="javascript:history.back()"><img src="images/button-back.gif"></a>
		<a href="index.cfm"><img src="images/button-home.gif"></a>
	</div>
	
<cfelse><!--- IF CART HAS STUFF... --->

	<!------------------------------ BEGIN: CHECK MINIMUM ORDERS  --------------------------->
	<!--- CHECK FOR MINIMUM ORDER REQUIREMENT --->
	<cfinclude template="Includes/CartMinimums.cfm">
<!--- <cfdump var="#variables#"> --->
	<cfif isDefined('FirstOrder') AND FirstOrder EQ 1>
		<cfloop query="checkForMin">
		
		<!--- <cfoutput query="checkForMin" maxrows="1"> --->
		<div class="cfErrorMsg"><b>Welcome #UName# Patrons! To continue checkout, there is a #LSCurrencyFormat(UMinimumFirst)# FIRST ORDER MINIMUM.</b></div>
		
		<!--- <table width="98%" border="1" cellpadding="3" cellspacing="0">
			<tr><td valign="top" align="center"><a><b>Welcome #UName# Patrons! To continue checkout, there is a #LSCurrencyFormat(UMinimumFirst)# FIRST ORDER MINIMUM.</b></a></td></tr>
		</table> ---><br>
		<!--- </cfoutput> --->
		</cfloop>
	<cfelseif isDefined('MinNotReached') AND MinNotReached EQ 1>
		<cfloop query="checkForMin">
		<!--- <cfoutput query="checkForMin" maxrows="1"> --->
		<div class="cfErrorMsg"><b>Welcome #UName# Patrons! To continue checkout, there is a #LSCurrencyFormat(UMinimum)# MINIMUM ORDER</b></div>
		
		<!--- <table width="98%" border="1" cellpadding="3" cellspacing="0">
			<tr><td valign="top" align="center"><a><b>Welcome #UName# Patrons! To continue checkout, there is a #LSCurrencyFormat(UMinimum)# MINIMUM ORDER</b></a></td></tr>
		</table> ---><br>
		<!--- </cfoutput> --->
		</cfloop>
	</cfif>
	<!------------------------------ END: CHECK MINIMUM ORDERS  --------------------------->
	
	<!------------------------------ BEGIN REAL CART VIEW --------------------------->
	<table class="cartLayoutTable">
	<!--- <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center"> --->
		<tr>
			<th>&nbsp;</th>
			<th align="center">SKU</th>
			<th align="center">Description</th>
			<th align="center">Quantity</th>
			<th align="center">Price</th>
			<th align="center">Total</th>
		</tr>
	
		<cfloop query="getCartItems.data">
		<!--- <cfoutput query="getCartItems.data"> --->
			
			<!--- CARTFUSION 4.6 - CART CFC --->
            <cfscript>
				UseThisPrice = application.Cart.getItemPrice(
					UserID=UserID,
					SiteID=application.siteConfig.data.SiteID,
					ItemID=ItemID,
					SessionID=SessionID,
					OptionName1=OptionName1,
					OptionName2=OptionName2,
					OptionName3=OptionName3);
            </cfscript>
			
			<cfinclude template="Includes/CartItemsCommon.cfm">
			
			<!--- <cfset row_class="cart_altrow_a">
			<cfif getCartItems.data.CurrentRow MOD 2><cfset row_class="cart_altrow_b"></cfif> --->
			
			<tr class="row#getCartItems.data.CurrentRow MOD 2#">
				
				<form method="post" action="CartUpdate.cfm">
				<td align="center">
					<cfscript>
						if ( ImageSmall IS '' )
						{
							if ( FileExists(#application.siteConfig.data.IU_VirtualPathDIR# & '\' & #ImageDir# & '\' & #SKU# & 'sm.jpg') )
								WriteOutput('<img src="images/#ImageDir#/#SKU#sm.jpg" align="absmiddle" class="cartImage">') ;
							else
								WriteOutput('<img src="images/image-EMPTY.gif" align="absmiddle" class="cart_image">') ;
						} else  {
							WriteOutput('<img src="images/#ImageDir#/#ImageSmall#" align="absmiddle" class="cartImage">') ;
						}
					</cfscript>
					<br /><input type="submit" name="RemoveButton" value="Remove" class="button">
				</td>
				<td align="center">#SKU#</td>
				<td>
					<a href="ProductDetail.cfm?ItemID=#ItemID#">#FinalDesc#</a>
					<!--- CARTFUSION 4.5 - MULTIPLE SHIPPING ADDRESSES --->
					<cfif application.siteCOnfig.data.EnableMultiShip EQ 1 >
						<br />
						<cfif session.CustomerArray[17] EQ '' OR NOT isDefined('getCustomerShipping') OR getCustomerShipping.RecordCount EQ 0 >
							
							ship to: <a href="CA-Login.cfm?goToPage=CA-CustomerArea.cfm?show5=1">[add shipping address]</a>

						<cfelseif isDefined('getCustomerShipping') AND getCustomerShipping.RecordCount>
							<cfset ThisShippingID = getCartItems.data.ShippingID >
							
							ship to:<select name="ShippingID" class="cfFormField" onchange="this.form.submit();">
								
								<option value="0" <cfif getCartItems.data.ShippingID EQ 0>selected</cfif>>myself</option>
								<cfloop query="getCustomerShipping">
								<option value="#getCustomerShipping.SHID#" <cfif ThisShippingID EQ getCustomerShipping.SHID>selected</cfif>>#getCustomerShipping.ShipNickName#</option>	
								</cfloop>
								<option value="add">-- add address</option>
							</select>
							
						</cfif>
					</cfif>
					<!--- CARTFUSION 4.5 - MULTIPLE SHIPPING ADDRESSES --->
				</td>
				<td align="center" nowrap="nowrap">
					<input type="text" name="Quantity" size="1" value="#Qty#" onMouseDown="this.form.UpdateButton.focus();">&nbsp;
					<input class="button" type="submit" name="UpdateButton" value="Update" tabindex="1"></td>
				<td align="center">#LSCurrencyFormat(UseThisPrice, "local")#</td><!--- DisplayPrice --->
				<td  align="center">#LSCurrencyFormat(TotalPrice, "local")#</td><!--- TotalPrice --->
					<input type="hidden" name="ItemID" value="#ItemID#">
					<input type="hidden" name="CartItemID" value="#CartItemID#">
					<cfif OptionName1 NEQ ''><input type="hidden" name="OptionName1" value="#OptionName1#"></cfif>
					<cfif OptionName2 NEQ ''><input type="hidden" name="OptionName2" value="#OptionName2#"></cfif>
					<cfif OptionName3 NEQ ''><input type="hidden" name="OptionName3" value="#OptionName3#"></cfif>
				</form>
			</tr>
			
			<cfscript>
				if (SKU eq "GIFTCERT") GiftCertTotal = GiftCertTotal + (TotalPrice);
				RunningTotal = RunningTotal + TotalPrice;
				RunningNorm = RunningNorm + NormalPrice;
			</cfscript>
			
		<!--- </cfoutput> --->
		</cfloop>
		
		<cfoutput>
		
			<!--- Get the Gift Certificate Total to adjust for shipping... gift certs don't affect shipping costs --->
			<cfif GiftCertTotal neq 0><cfset session.GiftCertTotal = GiftCertTotal></cfif>
			
			<tr>
				<td class="product_button_bg_cell" colspan="2"><p class="p20"><a href="CartClean.cfm" onClick="return confirm('Are you sure you want to EMPTY YOUR SHOPPING CART?')">Remove ALL Items From Cart</a></p></td>
				<!--- <td class="product_button_bg_cell">&nbsp;</td>
				<td class="product_button_bg_cell">&nbsp;</td>
				<td class="product_button_bg_cell">&nbsp;</td>
				<td class="product_button_bg_cell">&nbsp;</td> --->
			</tr>
			
			<tr class="subTotal">
				<td colspan="5" align="right">Subtotal:</td>
				<td align="right">#LSCurrencyFormat(RunningNorm, "local")#</td>
			</tr>
		
			<!--- SUBTRACT BACK ORDERS --->
			<cfif IsDefined("BackOrdersPrice") AND BackOrdersPrice NEQ 0 >
				<tr class="subTotal">
					<td colspan="5" align="right">Back Orders</td>
					<td align="right">- #LSCurrencyFormat(BackOrdersPrice, "local")#</td>
					<cfset RunningTotal = RunningTotal - BackOrdersPrice >
				</tr>
			</cfif>
			
			<!--- DISPLAY DISCOUNT --->
			<cfset DisplayType = 1 >
			<cfinclude template="Includes/CalculateDiscounts.cfm">
			<cfset RunningTotal = RunningTotal - DiscountTotal >
			
			<!--- DISPLAY TAX --->
			<cfif IsDefined("TaxPrice") AND TaxPrice NEQ 0 >
				<tr class="subTotal">
					<td colspan="5" align="right"><b>Tax</b></td>
					<td align="right">#LSCurrencyFormat(TaxPrice, "local")#</td>
					<cfset RunningTotal = RunningTotal + TaxPrice >
			   </tr>
			</cfif>
			
			<!--- DISPLAY SHIPPING --->
			<cfif IsDefined("ShippingPrice") AND ShippingPrice NEQ 0 >
				<tr class="subTotal">
					<td colspan="5" align="right"><b>Shipping</b></td>
					<td align="right">#LSCurrencyFormat(ShippingPrice, "local")#</td>
					<cfset RunningTotal = RunningTotal + ShippingPrice >
			   </tr>
			</cfif>
		
			<!--- DISPLAY TOTAL --->
			<tr class="grandTotal">
				<td colspan="5" align="right"><b>Total:</b></td>
				<td align="right"><b>#LSCurrencyFormat(RunningTotal, "local")#</b></td>
			</tr>		
		</table>
		
		<table cellpadding="10" cellspacing="0" border="0" width="100%">
			<form action="CA-Login.cfm?goToPage=CO-Billing.cfm" method="POST">
				<tr valign="top">
					<td>
						<b>Gift Certificate or Discount Code</b><br>
						<input type="text" name="DiscountCode" size="20" class="cfFormField" value="<cfif isDefined('session.DiscountCode')><cfoutput>#session.DiscountCode#</cfoutput></cfif>"><br><br>
						<cfif session.CustomerArray[17] EQ ''><a href="CA-Login.cfm?goToPage=WishUpdate.cfm?SaveCart=Yes" onClick="return confirm('Your cart will be saved as a WISHLIST for future retrieval.\nYou may access it by signing into MY ACCOUNT at the top of each page.\nCONTINUE?')">Save Cart to Wishlist</a><br/>
						<cfelse><a href="WishUpdate.cfm?SaveCart=Yes" onClick="return confirm('Your cart will be saved as a WISHLIST for future retrieval.\nYou may access it by signing into MY ACCOUNT at the top of each page.\nCONTINUE?')">Save Cart to Wishlist</a><br/></cfif>
						<a href="#application.siteConfig.data.RootURL#">Continue Shopping</a><br/>
					</td>
					<td align="right">
						<cfif MinNotReached EQ 0 AND FirstOrder EQ 0 >
							<input type="image" name="checkout" value="checkout" src="images/button-Checkout.gif" class="no-border">	
						</cfif>
					</td>
				</tr>
				<cfif isDefined('application.siteConfig.data.ShippingMessage') >
				<tr>
					<td colspan="2">
						#application.siteConfig.data.ShippingMessage#
					</td>
				</tr>
				</cfif>
			</form>
		</table>
	</cfoutput>
</cfif>

</cfmodule>
</cfoutput>
