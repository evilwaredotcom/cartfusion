<cfoutput>

<table width="100%" cellpadding="0" cellspacing="0" border="1" bordercolor="#layout.TableHeadingBGColor#">
	<tr bordercolor="#layout.PrimaryBGColor#">
		<td style="padding-left:5px;" bgcolor="#layout.TableHeadingBGColor#">
			<div class="cfTableHeading" style="padding:5px;">Order Summary</div>
		</td>
	</tr>
	<tr bgcolor="#layout.TableHeadingBGColor#"><td height="1"><img src="images/spacer.gif" height="1" width="1" /></td></tr>
	<tr bordercolor="#layout.PrimaryBGColor#">
		<td align="center">
	
<!--- INVOKE INSTANCE OF OBJECT - GET CART ITEMS --->
<!--- CARTFUSION 4.6 - CART CFC --->
<cfscript>
	if ( TRIM(session.CustomerArray[28]) NEQ '' ) {
		UserID = session.CustomerArray[28] ;
	} else {
		UserID = 1 ;
	}
	getCartItems = application.Cart.getCartItems(UserID=UserID,SiteID=config.SiteID,SessionID=SessionID) ;
</cfscript>

<!--- CHECK FOR MINIMUM ORDER REQUIREMENT --->
<cfinclude template="CartMinimums.cfm">

<cfif getCartItems.data.RecordCount EQ 0 OR MinNotReached EQ 1 OR FirstOrder EQ 1 >
	<cflocation url="CartEdit.cfm" addtoken="no">
	
<!--- IF CART HAS STUFF... --->
<cfelse>
	
	<cfscript>
		RunningWeight = 0;
		RunningTotal = 0;
		RunningNorm = 0;
		BackOrdersPrice = 0 ;
		if ( config.EnableMultiShip EQ 1 )
			TheColSpan = 5 ;
		else
			TheColSpan = 4 ;
	</cfscript>

	<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="cartview">
		<tr>
			<!--- CARTFUSION 4.5 - MULTIPLE SHIPPING ADDRESSES --->
			<cfif config.EnableMultiShip EQ 1 >
				<th width="20%">Ship&nbsp;To</th>
				<th width="10%">SKU</th>
				<th width="40%">Description</th>
			<cfelse>
				<th width="10%">SKU</th>
				<th width="60%">Description</th>
			</cfif>
			<th width="10%" align="center">Quantity</th>
			<th width="10%" align="right">Price</th>
			<th width="10%" align="right">Total</th>
		</tr>
	
	<cfloop query="getCartItems.data">
		
		<!--- CARTFUSION 4.6 - CART CFC --->
        <cfscript>
			UseThisPrice = application.Cart.getItemPrice(
								UserID=UserID,
								SiteID=config.SiteID,
								ItemID=ItemID,
								SessionID=SessionID,
								OptionName1=OptionName1,
								OptionName2=OptionName2,
								OptionName3=OptionName3
								) ;
		</cfscript>
		
		<!--- SHOW QB NUMBER AS SKU 
		<cfinvoke component="#theCustom#" method="getItemSKU" returnvariable="UseThisSKU">
			<cfinvokeargument name="ItemID" value="#ItemID#">
			<cfinvokeargument name="ItemSKU" value="#SKU#">
			<cfif OptionName1 NEQ ''><cfinvokeargument name="OptionName1" value="#OptionName1#"></cfif>
		</cfinvoke>
		--->
		<cfset UseThisSKU = SKU >
		
		<cfinclude template="CartItemsCommon.cfm">

		<cfset row_class="cartview_altrow_a">
		<cfif getCartItems.data.CurrentRow MOD 2><cfset row_class="cartview_altrow_b"></cfif>
		
		<tr class="#row_class#">
			<!--- CARTFUSION 4.5 - MULTIPLE SHIPPING ADDRESSES --->
			<cfif config.EnableMultiShip EQ 1 >
				<cfquery name="getCustomerSH" datasource="#datasource#">
					SELECT	*
					FROM	CustomerSH
					WHERE	CustomerID = '#session.CustomerArray[17]#'
					AND		SHID = #getCartItems.data.ShippingID#
				</cfquery>
				<td width="20%">
					<cfif getCustomerSH.RecordCount NEQ 0 >
						<b>#getCustomerSH.ShipFirstName# #getCustomerSH.ShipLastName#</b><br />
						#getCustomerSH.ShipPhone#<br />
						<cfif getCustomerSH.ShipCompanyName NEQ '' >
						#getCustomerSH.ShipCompanyName#<br />
						</cfif>
						#getCustomerSH.ShipAddress1#<br />
						<cfif getCustomerSH.ShipAddress2 NEQ '' >
						#getCustomerSH.ShipAddress2#<br />
						</cfif>
						#getCustomerSH.ShipCity#, #getCustomerSH.ShipState# #getCustomerSH.ShipZip# #getCustomerSH.ShipCountry#
					<cfelse>
						<b>#session.CustomerArray[18]# #session.CustomerArray[19]#</b><br />
						#session.CustomerArray[35]#<br />
						<cfif session.CustomerArray[34] NEQ '' >
						#session.CustomerArray[34]#<br />
						</cfif>
						#session.CustomerArray[20]#<br />
						<cfif session.CustomerArray[21] NEQ '' >
						#session.CustomerArray[21]#<br />
						</cfif>
						#session.CustomerArray[22]#, #session.CustomerArray[23]# #session.CustomerArray[24]# #session.CustomerArray[25]#
					</cfif>
				</td>
				<td width="10%">#UseThisSKU#</td>
				<td width="40%">#FinalDesc#</td>
			<cfelse>
				<td width="10%">#UseThisSKU#</td>
				<td width="60%">#FinalDesc#</td>
			</cfif>
			<!--- CARTFUSION 4.5 - MULTIPLE SHIPPING ADDRESSES --->
			<td width="10%" align="center">#Qty#</td>
			<td width="10%" align="right">#LSCurrencyFormat(UseThisPrice, "local")#</td>
			<td width="10%" align="right">#LSCurrencyFormat(TotalPrice, "local")#</td>
		</tr>
		<cfscript>
			RunningTotal = RunningTotal + TotalPrice;
			RunningNorm = RunningNorm + NormalPrice;
			if (not isDefined("Weight") or Weight eq "") RunningWeight = RunningWeight + (0 * Qty);
			else RunningWeight = RunningWeight + (Weight * Qty);
		</cfscript>
	</cfloop>
	  
		<!--- SUBTOTAL --->
		<tr class="cartview_tally">
			<td align="right" colspan="#TheColSpan#">Subtotal</td>
			<td align="right">#LSCurrencyFormat(RunningNorm, "local")#</td>
		</tr>
		
		<!--- SUBTRACT BACK ORDERS --->
		<cfif isDefined('BackOrdersPrice') AND BackOrdersPrice NEQ 0>
			<tr>
				<td class="cfAttract" align="right" colspan="#TheColSpan#">Back Orders</td>
				<td class="cfAttract" align="right">- #LSCurrencyFormat(BackOrdersPrice, "local")#</td>
				<cfset RunningTotal = RunningTotal - BackOrdersPrice >
			</tr>
		</cfif>
		
		<!--- 
			DISPLAY DISCOUNT CODE OR GIFT CERTIFICATE 
			OR APPLY AND DISPLAY AFFILIATE ID
		--->
		
		<!--- DISPLAY DISCOUNT --->
		<cfset DisplayType = 2 >
		<cfinclude template="CalculateDiscounts.cfm">
		<cfset RunningTotal = RunningTotal - DiscountTotal >
		
		<!---
		<cfif isDefined('DiscountCode') AND DiscountCode NEQ ''>
			<!--- DISPLAY SHIPPING OR PRICE DISCOUNT --->
			<cfif isDefined('getDiscount') AND getDiscount.RecordCount EQ 1 AND RunningDiscount GT 0 AND getDiscount.DiscountName neq "Gift Certificate">				
				<tr class="cartview_tally">
					<td align="right" colspan="#TheColSpan#"><b>#getDiscount.DiscountName#</b></td>
					<td align="right"><b>- #LSCurrencyFormat(RunningDiscount, "local")#</b></td>
					<input type="hidden" name="DiscountCode" value="#Form.DiscountCode#">
					<cfset RunningTotal = RunningTotal - RunningDiscount >
				</tr>
			</cfif>
		</cfif>
		--->
		
		<!--- CALCULATE TAX --->
		<cfinclude template="CalculateTax.cfm">		
		<cfif IsDefined("TaxPrice")>
			<tr class="cfDefault">
				<td align="right" colspan="#TheColSpan#">Tax:</td>
				<td align="right">#LSCurrencyFormat(TaxPrice, "local")#</td>
				<cfset RunningTotal = RunningTotal + TaxPrice >
		   </tr>
		</cfif>
		
		<!--- CALCULATE SHIPPING --->
		<!--- CARTFUSION 4.5 - MULTIPLE SHIPPING ADDRESSES --->
		<cfif config.EnableMultiShip EQ 1 >
			<cfloop from="1" to="#Cart.Packages#" index="i">
			<cfif isDefined('Form.ShippingMethod#i#')>		
				<cfinclude template="CalculateShipping.cfm">
				<cfif isDefined('ShippingPrice#i#')>
					<tr class="cfDefault">
						<td align="right" colspan="#TheColSpan#"><cfif isDefined('ShippingDiscount.DiscountMessage') AND ShippingDiscount.DiscountMessage NEQ '' ><font class="cfAttract">#ShippingDiscount.DiscountMessage#:</font><cfelse>Package ###i# Shipping:</cfif></td>
						<td align="right">#LSCurrencyFormat(Evaluate('ShippingPrice' & i), "local")#</td>
						<cfset RunningTotal = RunningTotal + Evaluate('ShippingPrice' & i) >
				   </tr>
			    <cfelse>
					#i#
				</cfif>
			</cfif>
			</cfloop>
		<cfelse>
			<cfif isDefined('Form.ShippingMethod1')>		
				<cfinclude template="CalculateShipping.cfm">
				<cfif isDefined("ShippingPrice")>
					<tr class="cfDefault">
						<td align="right" colspan="#TheColSpan#"><cfif isDefined('ShippingDiscount.DiscountMessage') AND ShippingDiscount.DiscountMessage NEQ '' ><font class="cfAttract">#ShippingDiscount.DiscountMessage#:</font><cfelse>Package ##1 Shipping:</cfif></td>
						<td align="right">#LSCurrencyFormat(ShippingPrice, "local")#</td>
						<cfset RunningTotal = RunningTotal + ShippingPrice >
				   </tr>
			    </cfif>
			</cfif>
		</cfif>
		
		<!--- STORE CREDIT --->
		<cfif IsDefined("CreditToApply") AND CreditToApply NEQ 0 >
			<tr>
				<td class="cfAttract" align="right" colspan="#TheColSpan#">Store Credit:</td>
				<td class="cfAttract" align="right">- #LSCurrencyFormat(CreditToApply, "local")#</td>
				<cfset RunningTotal = RunningTotal - CreditToApply >
		    </tr>
		</cfif>
		
		<!--- TOTAL --->
		<tr class="cartview_tally">
			<td align="right" colspan="#TheColSpan#"><b>Total:</b></td>
			<td align="right"><b>#LSCurrencyFormat(RunningTotal, "local")#</b></td>
	   	</tr>
	</table>
</cfif>

		</td>
	</tr>
</table>
</cfoutput>