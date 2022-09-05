<cfquery name="getShippingFEDEX" datasource="#application.dsn#">
	SELECT	ShippingCode, ShippingMessage
	FROM	ShippingMethods
	WHERE	ShippingCompany = 'FEDEX'
	AND		Allow = 1
	<cfif session.CustomerArray[25] NEQ application.BaseCountry >
	AND		International = 1
	<cfelse>
	AND		(International = 0 OR International IS NULL)
	</cfif>
</cfquery>

<cfif getShippingFEDEX.RecordCount GT 0 >
	
	<cfscript>
		if ( TRIM(session.CustomerArray[28]) NEQ '' ) {
			UserID = session.CustomerArray[28] ;
		} else {
			UserID = 1 ;
		}
		// CALCULATE TOTAL WEIGHT & TOTAL PRICE OF ORDER
		// Cart = application.Cart.getCartTotal(UserID=UserID,SiteID=application.SiteID,SessionID=SessionID) ;
		// LOOK FOR AN ALL-METHODS SHIPPING DISCOUNT
		ShippingDiscount = application.Cart.getShipDiscount(UserID=UserID,SiteID=application.SiteID,SessionID=SessionID) ;
		if ( ShippingDiscount.All EQ 1 ) {
			GlobalShipDiscount = 1 ;
			UsedShipDiscounts = ListAppend(UsedShipDiscounts,ShippingDiscount.ID) ;
		} else {
			GlobalShipDiscount = 0 ;
		}
		fedexAcNum = getShippingCos.FedexAccountNum ;
		identifier = getShippingCos.FedexIdentifier ;
	</cfscript>
	
	<cfloop query="getShippingFEDEX">
	<cfscript>
		ThisShippingCode = getShippingFEDEX.ShippingCode ;
		ThisShippingMessage = getShippingFEDEX.ShippingMessage ;
		AllShippingPrices = 0 ;
	</cfscript>
	
	<cf_TagFedex 
		function="rateRequest"
		fedexindentifier="#identifier#"
		accountnumber="#fedexAcNum#"
		servicelevel="#ThisShippingCode#"
		raterequesttype="FDXE"
		ShipperState="#application.CompanyState#"
		ShipperZip="#application.DefaultOriginZipCode#"
		ShipperCountry="#application.BaseCountry#"
		ShipToState="#session.CustomerArray[23]#"
		ShipToZip="#session.CustomerArray[24]#"
		ShipToCountry="#session.CustomerArray[25]#"
		PackageWeight ="#NumberFormat(Cart.CartWeight, 999.9)#"
		packaging="YOURPACKAGING"
		packagelength="10"
		packagewidth="10"
		packageheight="10"
		requestlistrates="1"
		sssatdelivery="0"
		ssresdelivery="1"
		DeclaredValue="99"
		debug="False"
		>

	<cfif IsDefined("qFedexRateQuery")>
		<cfoutput query="qFedexRateQuery">
			<cfscript>
				if ( Len(ListNetTotalCharge) GT 0 )
					ShippingPrice = ListNetTotalCharge ;
				else
					ShippingPrice = DiscBaseTotalCharges ;
				AllShippingPrices = AllShippingPrices + ShippingPrice ;
				// SHIPPING DISCOUNT
				// NO AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS
				if ( GlobalShipDiscount EQ 0 ) {
					// INVOKE INSTANCE OF OBJECT - GET PRODUCT PRICE, INCLUDING ANY DISCOUNTS
					ShippingDiscount = application.Cart.getShipDiscount(UserID=UserID,SiteID=application.SiteID,SessionID=SessionID,ShippingMethod=ThisShippingCode) ;
					if ( ShippingDiscount.ShipMethod EQ ThisShippingCode )
					{
						UsedShipDiscounts = ListAppend(UsedShipDiscounts,ShippingDiscount.ID) ;
						if ( ShippingDiscount.Type EQ 1 ) {
							ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
						} else {
							ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
						}
						if ( application.HandlingType EQ 1 ) {
							ShippingPrice = NumberFormat(ShippingPrice + (ShippingPrice * (application.HandlingFee/100)),0.00) ;
						} else {
							ShippingPrice = NumberFormat(ShippingPrice + application.HandlingFee,0.00) ;
						}
					}
				// THERE IS AN AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS
				} else {
					if ( ShippingDiscount.Type EQ 1 ) {
						ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
					} else {
						ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
					}
					if ( application.HandlingType EQ 1 ) {
						ShippingPrice = NumberFormat(ShippingPrice + (ShippingPrice * (application.HandlingFee/100)),0.00) ;
					} else {
						ShippingPrice = NumberFormat(ShippingPrice + application.HandlingFee,0.00) ;
					}
				}
			</cfscript>
			
			<!--- DISPLAY SHIPPING METHOD --->
			<cfinput type="radio" name="ShippingMethod#cpi#" value="#ThisShippingCode#" required="yes" message="Please select a shipping method"> #ThisShippingMessage#: <b>#LSCurrencyFormat(ShippingPrice)#</b><cfif isDefined('ShippingDiscount.DiscountMessage') AND ShippingDiscount.DiscountMessage NEQ '' > <font class="cfAttract">#ShippingDiscount.DiscountMessage#</font></cfif><br/>
			
		</cfoutput>
	</cfif>
	</cfloop>
	
	<!--- NO METHODS WORTH MONEY WERE RETURNED --->
	<cfif AllShippingPrices LTE 0 >
		<cfset errorShippingFEDEX = 1 >
	</cfif>

<cfelse>
	<cfset errorShippingFEDEX = 1 >
</cfif>