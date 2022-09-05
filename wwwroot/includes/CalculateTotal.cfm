<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<!--- BEGIN: CALCULATE TOTAL WEIGHT & TOTAL PRICE OF ORDER --->
<cfif not isDefined('Cart.CartTotal') >
	<cfinclude template="CartTotals.cfm">
</cfif>
<!--- END: CALCULATE TOTAL WEIGHT & TOTAL PRICE OF ORDER --->

<cfif getCartItems.data.RecordCount EQ 0>
	<cflocation url="#application.rootURL#/CartEdit.cfm" addtoken="no">
 	<cfabort>
</cfif>


<!--- CHECK FOR MINIMUM ORDER REQUIREMENT 
<cfinclude template="CartMinimums.cfm">
--->

<!--- CALCULATE DISCOUNT, SHIPPING & TAX --->
<cfinclude template="CalculateDiscounts.cfm">
<cfinclude template="CalculateTax.cfm">
<cfinclude template="CalculateShipping.cfm">
<cfscript>
	// SET RUNNING TOTAL START POINT
	RunningTotal = NumberFormat(Cart.CartTotal,0.00) ;
	OrderTotal = RunningTotal ;
	// DEDUCT BACK ORDERS PRICES FROM RUNNING TOTAL
	if ( isDefined('BackOrdersPrice') AND BackOrdersPrice NEQ 0 ) {
		RunningTotal = RunningTotal - BackOrdersPrice ;
	}
	if ( isDefined('DiscountTotal') AND DiscountTotal NEQ 0 ) {
		RunningTotal = RunningTotal - DiscountTotal ;
		OrderTotal = OrderTotal - DiscountTotal ;
	}
	if ( isDefined('TaxPrice') AND TaxPrice NEQ 0 ) {
		RunningTotal = RunningTotal + TaxPrice ;
	}
	if ( isDefined('ShippingPrice') AND ShippingPrice NEQ 0 ) {
		RunningTotal = RunningTotal + ShippingPrice ;
	}
	if ( isDefined('CreditToApply') AND CreditToApply NEQ 0 ) {	
		RunningTotal = RunningTotal - CreditToApply ;
	}
	if ( isDefined('UsedDiscounts') AND isDefined('UsedShipDiscounts') AND UsedDiscounts NEQ '' AND UsedShipDiscounts NEQ '' ) {
		DiscountsUsed = ListAppend(UsedDiscounts, UsedShipDiscounts) ;
	} else {
		DiscountsUsed = '' ;
	}
</cfscript>

