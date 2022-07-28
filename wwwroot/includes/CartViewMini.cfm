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

<cfif getCartItems.data.RecordCount eq 0 or MinNotReached eq 1 or FirstOrder eq 1 >
	<cflocation url="../CartEdit.cfm" addtoken="no">
	
<!--- IF CART HAS STUFF... --->
<cfelse>
	
	<cfscript>
		RunningWeight = 0;
		RunningTotal = 0;
		RunningNorm = 0;
		BackOrdersPrice = 0 ;
	</cfscript>

	<table border="0" style="border-color:<cfoutput>#layout.TableHeadingBGColor#</cfoutput>;" cellpadding="2" cellspacing="0" width="225" align="center">
		<tr>
			<td class="cfHeading" colspan="4" align="center">Cart Contents<br></td>
		</tr>
		<tr bgcolor="<cfoutput>#layout.TableHeadingBGColor#</cfoutput>">
			<td class="cfMini" width="25%" ><b>SKU</b></td>
			<td class="cfMini" width="25%" ><b>Quantity</b></td>
			<td class="cfMini" width="25%" ><b>Price</b></td>
			<td class="cfMini" width="25%" align="right"><b>Total</b></td>
		</tr>
	
		<cfoutput query="getCartItems.data">
		
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
			
			<cfinclude template="CartItemsCommon.cfm">
	
			<tr>
				<td class="cfMini" width="25%" >#SKU#</td>
				<td class="cfMini" width="25%" >#Qty#</td>
				<td class="cfMini" width="25%" >#LSCurrencyFormat(UseThisPrice, "local")#</td>
				<td class="cfMini" width="25%" align="right">#LSCurrencyFormat(TotalPrice, "local")#</td>
			</tr>
			<cfscript>
				RunningTotal = RunningTotal + TotalPrice;
				RunningNorm = RunningNorm + NormalPrice;
				RunningWeight = RunningWeight + (Weight * Qty);
			</cfscript>
		</cfoutput>
	  
		<cfoutput>
		<tr>
			<td colspan="3">
			<td><hr></td>
		</tr>
		<tr>
			<td class="cfMini" align="right" colspan="3">Subtotal:</td>
			<td class="cfMini" align="right">#LSCurrencyFormat(runningnorm, "local")#</td>
		</tr>
		<!--- SUBTRACT BACK ORDERS --->
		<cfif IsDefined("backOrdersPrice") AND backOrdersPrice NEQ 0>
			<tr>
				<td class="cfMini" align="right" colspan="3">Back Orders:</td>
				<td class="cfMini" align="right">- #LSCurrencyFormat(backOrdersPrice, "local")#</td>
				<cfset runningtotal = runningtotal - backOrdersPrice>
			</tr>
		</cfif>

		<!--- DISPLAY DISCOUNT --->
		<cfset DisplayType = 3 >
		<cfinclude template="CalculateDiscounts.cfm">
		<cfset RunningTotal = RunningTotal - DiscountTotal >

		<!--- CALCULATE TAX --->
		<cfinclude template="CalculateTax.cfm">		
		<cfif IsDefined("TaxPrice")>
			<tr>
				<td class="cfMini" align="right" colspan="3">Tax:</td>
				<td class="cfMini" align="right">#LSCurrencyFormat(TaxPrice, "local")#</td>
			<cfset runningtotal = runningtotal + TaxPrice>
			</tr>
		</cfif>
		<!--- NOT WISE TO CALCULATE SHIPPING HERE BECAUSE OF POSTBACKS/INACCURACIES --->
		<!--- CALCULATE SHIPPING 
		<cfif isDefined('Form.ShippingMethod') OR config.ShipBy EQ 1 OR config.ShipBy EQ 2 OR config.ShipBy EQ 4 OR RunningWeight GT 150>		
			<cfinclude template="Includes/CalculateShipping.cfm">		
			<cfif isDefined("ShippingPrice") AND ShippingPrice NEQ 0>
				<tr>
					<td class="cfMini" align="right" colspan="3">Shipping:</td>
					<td class="cfMini" align="right">#LSCurrencyFormat(ShippingPrice, "local")#</td>
				<cfset runningtotal = runningtotal + ShippingPrice>
				</tr>
			</cfif>
		</cfif>
		--->
		<tr>
			<td class="cfMini" align="right" colspan="3"><b>Total:</b></td>
			<td class="cfMini" align="right"><b>#LSCurrencyFormat(RunningTotal, "local")#</b></td>
		</tr>
	</table>
	</cfoutput>
</cfif><!--- CART HAS STUFF IN IT --->