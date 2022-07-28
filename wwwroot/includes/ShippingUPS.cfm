<cfquery name="getShippingUPS" datasource="#datasource#">
	SELECT	ShippingCode, ShippingMessage
	FROM	ShippingMethods
	WHERE	ShippingCompany = 'UPS'
	AND		Allow = 1
	<cfif session.CustomerArray[25] NEQ config.BaseCountry >
	AND		International = 1
	<cfelse>
	AND		(International = 0 OR International IS NULL)
	</cfif>
</cfquery>

<cfif getShippingUPS.RecordCount GT 0 >

	<cfscript>
		if ( TRIM(session.CustomerArray[28]) NEQ '' ) {
			UserID = session.CustomerArray[28] ;
		} else {
			UserID = 1 ;
		}
		// CALCULATE TOTAL WEIGHT & TOTAL PRICE OF ORDER
		// Cart = application.Cart.getCartTotal(UserID=UserID,SiteID=config.SiteID,SessionID=SessionID) ;
		// LOOK FOR AN ALL-METHODS SHIPPING DISCOUNT
		ShippingDiscount = application.Cart.getShipDiscount(UserID=UserID,SiteID=config.SiteID,SessionID=SessionID) ;
		if ( ShippingDiscount.All EQ 1 ) {
			GlobalShipDiscount = 1 ;
			UsedShipDiscounts = ListAppend(UsedShipDiscounts,ShippingDiscount.ID) ;
		} else {
			GlobalShipDiscount = 0 ;
		}
		UPSAccessKey = getShippingCos.UPSAccessKey ;
		UPSUserID    = getShippingCos.UPSUserID ;
		UPSPassword  = getShippingCos.UPSPassword ;
	</cfscript>
	
	<cfloop query="getShippingUPS">
	<cfscript>
		ThisShippingCode = getShippingUPS.ShippingCode ;
		ThisShippingMessage = getShippingUPS.ShippingMessage ;
		AllShippingPrices = 0 ;
	</cfscript>
	
	<cf_TagUPS
		function="rateRequest"
		UPSAccessKey="#UPSAccessKey#"
		UPSUserID="#UPSUserID#"
		UPSPassword="#UPSPassword#"
		PickUpType="03"
		ServiceType="#ThisShippingCode#"
		ShipperCity="#config.CompanyCity#"
		ShipperState="#config.CompanyState#"
		ShipperZip="#config.CompanyZip#"
		ShipperCountry="#config.CompanyCountry#"
		ShipToCity="#session.CustomerArray[22]#"
		ShipToState="#session.CustomerArray[23]#"
		ShipToZip="#session.CustomerArray[24]#"
		ShipToCountry="#session.CustomerArray[25]#"
		PackageWeight ="#Cart.CartWeight#"
		PackageType="02"
		ResidentialAddress="1" >

	<cfif IsDefined("rateQuery")>
		<cfoutput query="rateQuery">
            <cfscript>
				ShippingPrice = TotalCharges ;
				AllShippingPrices = AllShippingPrices + ShippingPrice ;
				// SHIPPING DISCOUNT
				// NO AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS
				if ( GlobalShipDiscount EQ 0 ) {
					// INVOKE INSTANCE OF OBJECT - GET PRODUCT PRICE, INCLUDING ANY DISCOUNTS
					ShippingDiscount = application.Cart.getShipDiscount(UserID=UserID,SiteID=config.SiteID,SessionID=SessionID,ShippingMethod=ThisShippingCode) ;
					if ( ShippingDiscount.ShipMethod EQ ThisShippingCode )
					{
						UsedShipDiscounts = ListAppend(UsedShipDiscounts,ShippingDiscount.ID) ;
						if ( ShippingDiscount.Type EQ 1 ) {
							ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
						} else {
							ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
						}
						if ( config.HandlingType EQ 1 ) {
							ShippingPrice = NumberFormat(ShippingPrice + (ShippingPrice * (config.HandlingFee/100)),0.00) ;
						} else {
							ShippingPrice = NumberFormat(ShippingPrice + config.HandlingFee,0.00) ;
						}
					}
				// THERE IS AN AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS
				} else {
					if ( ShippingDiscount.Type EQ 1 ) {
						ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
					} else {
						ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
					}
					if ( config.HandlingType EQ 1 ) {
						ShippingPrice = NumberFormat(ShippingPrice + (ShippingPrice * (config.HandlingFee/100)),0.00) ;
					} else {
						ShippingPrice = NumberFormat(ShippingPrice + config.HandlingFee,0.00) ;
					}
				}
			</cfscript>
            
			<!--- DISPLAY SHIPPING METHOD --->
			<cfinput type="radio" name="ShippingMethod#cpi#" value="#ThisShippingCode#" required="yes" message="Please select a shipping method"> #ThisShippingMessage#<cfif ScheduledDelivTime NEQ ''> (by #ScheduledDelivTime#)</cfif>: <b>#LSCurrencyFormat(ShippingPrice)#</b><cfif isDefined('ShippingDiscount.DiscountMessage') AND ShippingDiscount.DiscountMessage NEQ '' > <font class="cfAttract">#ShippingDiscount.DiscountMessage#</font></cfif><br />
			
		</cfoutput>
	</cfif>
	</cfloop>
	
	<!--- NO METHODS WORTH MONEY WERE RETURNED --->
	<cfif AllShippingPrices LTE 0 >
		<cfset errorShippingUPS = 1 >
	</cfif>

<cfelse>
	<cfset errorShippingUPS = 1 >
</cfif>