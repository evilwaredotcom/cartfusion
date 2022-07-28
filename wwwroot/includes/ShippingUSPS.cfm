<cfquery name="getShippingUSPS" datasource="#datasource#">
	SELECT	ShippingCode, ShippingMessage
	FROM	ShippingMethods
	WHERE	ShippingCompany = 'USPS'
	AND		Allow = 1
	<cfif session.CustomerArray[25] NEQ config.BaseCountry >
	AND		International = 1
	<cfelse>
	AND		(International = 0 OR International IS NULL)
	</cfif>
</cfquery>

<cfif getShippingUSPS.RecordCount GT 0 >

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
		USPSUserID   = getShippingCos.USPSUserID ;
		USPSPassword = getShippingCos.USPSPassword ;
		pounds = int(Cart.CartWeight); 
		ounces = (Cart.CartWeight - pounds) * 16; 
		ounces = round(ounces * 100) / 100; 	// round ounces off at 2 decimal places - UNNECESSARY REALLY
		decimal = (int(ounces) + 1) - ounces; 	// create decimal value to check to round up
		if ( decimal LT 1 ) 					// if there is a decimal value, round up 1
			ounces = int(ounces) + 1;
		else									// otherwise, set to ounces integer
			ounces = int(ounces);
	</cfscript>

	<cfloop query="getShippingUSPS">
	<cfscript>
		ThisShippingCode = getShippingUSPS.ShippingCode ;
		ThisShippingMessage = getShippingUSPS.ShippingMessage ;
		AllShippingPrices = 0 ;
	</cfscript>
	
	<!--- INTERNATIONAL RATE --->
	<cfif session.CustomerArray[25] NEQ config.BaseCountry >
	
		<cfinvoke component="#application.Queries#" method="getCountry" returnvariable="getCountry">
			<cfinvokeargument name="CountryCode" value="#session.CustomerArray[25]#">
		</cfinvoke>
		
		<cf_TagUSPS
			function="RateIntlRequest"
			USPSUserID="#USPSUserID#"
			USPSPassword="#USPSPassword#"
			ShipToCountry="#getCountry.Country#"
			PackageWeightLB="#pounds#"
			PackageWeightOZ="#ounces#"
			PackageType="Package"
			TestingEnvironment="False"
			>
			
		<cfif IsDefined("USPSIntlRateServicesQuery") AND isDefined('USPSError') AND USPSError EQ 0 >
			<cfoutput query="USPSIntlRateServicesQuery">
                <cfscript>
					ShippingPrice = USPSIntlRateServicesQuery.Postage ;
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
				<cfinput type="radio" name="ShippingMethod#cpi#" value="#ThisShippingCode#" required="yes" message="Please select a shipping method"> #ThisShippingMessage#<!---<cfif ScheduledDelivTime NEQ ''> (by #ScheduledDelivTime#)</cfif>--->: <b>#LSCurrencyFormat(ShippingPrice)#</b><cfif isDefined('ShippingDiscount.DiscountMessage') AND ShippingDiscount.DiscountMessage NEQ '' > <font class="cfAttract">#ShippingDiscount.DiscountMessage#</font></cfif><br />
				
			</cfoutput>
		</cfif>
	
	<!--- DOMESTIC RATE --->
	<cfelse>

		<cf_TagUSPS
			function="RateDomesticRequest"
			USPSUserID="#USPSUserID#"
			USPSPassword="#USPSPassword#"
			ShipFromZip5="#config.DefaultOriginZipCode#"
			ShipToZip5="#session.CustomerArray[24]#"
			PackageWeightLB="#pounds#"
			PackageWeightOZ="#ounces#"
			PackageSize="Regular"
			ServiceLevel="#ThisShippingCode#"
			TestingEnvironment="False" 
			>
		
		<cfif IsDefined("USPSDomesticRateQuery") AND isDefined('USPSError') AND USPSError EQ 0 >
			<cfoutput query="USPSDomesticRateQuery">
				<cfscript>
					ShippingPrice = USPSDomesticRateQuery.FreightCharges ;
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
				<cfinput type="radio" name="ShippingMethod#cpi#" value="#ThisShippingCode#" required="yes" message="Please select a shipping method"> #ThisShippingMessage#<!---<cfif ScheduledDelivTime NEQ ''> (by #ScheduledDelivTime#)</cfif>--->: <b>#LSCurrencyFormat(ShippingPrice)#</b><cfif isDefined('ShippingDiscount.DiscountMessage') AND ShippingDiscount.DiscountMessage NEQ '' > <font class="cfAttract">#ShippingDiscount.DiscountMessage#</font></cfif><br />
				
			</cfoutput>
		</cfif>
		
	</cfif>
	</cfloop>

	<!--- NO METHODS WORTH MONEY WERE RETURNED --->
	<cfif AllShippingPrices LTE 0 >
		<cfset errorShippingUSPS = 1 >
	</cfif>

<cfelse>
	<cfset errorShippingUSPS = 1 >
</cfif>	