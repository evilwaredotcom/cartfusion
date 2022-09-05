<cfscript>
	getShippingCos = application.Queries.getShippingCos(SiteID=application.SiteID);
	// CARTFUSION 4.6 - SHIPPING CODES
	getShippingCodes = application.Queries.getShippingCodes();

	// Initialize variables
	fedexAcNum   = getShippingCos.FedexAccountNum ;
	identifier   = getShippingCos.FedexIdentifier ;
	UPSAccessKey = getShippingCos.UPSAccessKey ;
	UPSUserID	= getShippingCos.UPSUserID ;
	UPSPassword  = getShippingCos.UPSPassword ;
	USPSUserID   = getShippingCos.USPSUserID ;
	USPSPassword = getShippingCos.USPSPassword ;
	
	UsedShipDiscounts = '' ;
	ShippingPrice = 0 ;
	TotalShippingPrice = 0 ;
	for (cpi = 1; cpi LT (Cart.Packages+1); cpi = cpi + 1){
		'ShippingPrice#cpi#' = 0 ;
	}
	IntShip = 0 ;
	if ( session.CustomerArray[25] NEQ application.BaseCountry ) // Verify if Shipping is International or not
		IntShip = 1 ;
</cfscript>

<!--- BEGIN: CALCULATE TOTAL WEIGHT & TOTAL PRICE OF ORDER --->
<cfif not isDefined('Cart.CartTotal') >
	<cfinclude template="CartTotals.cfm">
</cfif>
<!--- END: CALCULATE TOTAL WEIGHT & TOTAL PRICE OF ORDER --->


<!--- BEGIN: LOOK FOR AN ALL-METHODS SHIPPING DISCOUNT --->
<!--- INVOKE INSTANCE OF OBJECT - GET SHIPPING DISCOUNT --->
<cfinvoke component="#application.Cart#" method="getShipDiscount" returnvariable="ShippingDiscount">
	<cfif session.CustomerArray[28] EQ '' >
		<cfinvokeargument name="UserID" value="1">
	<cfelse>
		<cfinvokeargument name="UserID" value="#session.CustomerArray[28]#">
	</cfif>
	<cfinvokeargument name="SiteID" value="#application.SiteID#">
	<cfinvokeargument name="SessionID" value="#SessionID#">
</cfinvoke>

<cfscript>
	if ( isDefined('ShippingDiscount.All') AND ShippingDiscount.All EQ 1 )
	{
		GlobalShipDiscount = 1 ;
		UsedShipDiscounts = ListAppend(UsedShipDiscounts,ShippingDiscount.ID) ;
	}
	else
		GlobalShipDiscount = 0 ;
</cfscript>
<!--- END: LOOK FOR AN ALL-METHODS SHIPPING DISCOUNT --->


<!--- *** BEGIN: SHIPPING CALCULATIONS *** --->
	

<!--- CARTFUSION 4.5 - MULTIPLE SHIPPING ADDRESSES --->	
<cfloop from="1" to="#Cart.Packages#" index="cpi">
	<!--- CARTFUSION 4.6 - PRODUCT-SPECIFIC SHIPPING PRICE ADJUSTMENTS --->
	
	<cfscript>
		ShippingMethod = Evaluate('ShippingMethod' & cpi) ;
		ShippingPrice = ShippingPrice + Evaluate('ShippingPrice' & cpi) ;
		PSTotalWeight = 0 ;
		PSShipCodeUsed = 0 ;
	</cfscript>
	<cfloop query="getCartItems.data">
		
		<cfscript>
			ShippingPrice = ShippingPrice + NumberFormat(fldShipAmount,0.00) + NumberFormat(fldHandAmount,0.00) ;
			PSTotalWeight = PSTotalWeight + (NumberFormat(fldShipWeight,0.000) * Qty) ;
		</cfscript>
		
		
		<!--- CARTFUSION 4.6 - CUSTOM SHIPPING CODES 
		<cfquery name="checkShippingCode" dbtype="query" >
			SELECT	*
			FROM	getShippingCodes
			WHERE	ShippingCode = #fldShipCode# <!--- previous CF code: #fldShipAmount#, field fldShipCode added 22-Mar-07 --->
		</cfquery>		
		<!--- CUSTOM SHIPPING CODE/MESSAGE IS APPLICABLE --->
		<cfif checkShippingCode.RecordCount NEQ 0 >
			<cfif RPShipCodeUsed NEQ 1 >
				<cfscript>
					PSShipCodeUsed = 1 ;
					PSShipCode = checkShippingCode.ShippingCode ;
				</cfscript>
			</cfif>
		</cfif>
		--->
		<!--- <cfoutput><b style="color:green">#ShippingPrice#</b><br></cfoutput> --->
	</cfloop>
	

<!--- SHIPBY PRICE --->
<cfif application.ShipBy EQ 1>

	<cfquery name="getShipPrice" datasource="#application.dsn#">				
		SELECT	InternationalRate, DomesticRate
		FROM	ShipPrice
		WHERE	Start	<	#Cart.CartTotal#
		AND		Finish	>=	#Cart.CartTotal#
		AND		SiteID = #application.SiteID#
	</cfquery>
		
	<cfscript>
		if (getShipPrice.RecordCount)
		{
			if (IntShip EQ 1) // Apply International Rate
			{
				if (getShipPrice.InternationalRate NEQ '')
					ShippingPrice = ShippingPrice + getShipPrice.InternationalRate ;
				else
					ShippingPrice = ShippingPrice + application.DefaultShipRateInt ;
			}
			else
			{
				if (getShipPrice.DomesticRate NEQ '')
					ShippingPrice = ShippingPrice + getShipPrice.DomesticRate ;
				else
					ShippingPrice = ShippingPrice + application.DefaultShipRateDom ;
			}
		}
		else if (IntShip EQ 1)
			ShippingPrice = ShippingPrice + application.DefaultShipRateInt ;
		else
			ShippingPrice = ShippingPrice + application.DefaultShipRateDom ;
	</cfscript>
	
	<!--- BEGIN: GET SHIPPING DISCOUNT --->
	
	<!--- Converted to CFSCRIPT by Carl Vanderpal 18 June 2007 --->
	<cfscript>
		if( GlobalShipDiscount EQ 0 )	{
			if( session.CustomerArray[28] EQ '')	{
				UserId = 1;
			}
			else	{
				UserID = session.CustomerArray[28];
			}
			ShippingDiscount = application.Cart.getShipDiscount(
				UserID=UserID, 
				SiteID=application.SiteID,
				ShippingMethod='Price',
				SessionID=SessionID);
		
		
			if ( ShippingDiscount.ShipMethod EQ 'Price' )
			{
				UsedShipDiscounts = ListAppend(UsedShipDiscounts,ShippingDiscount.ID) ;
				if ( ShippingDiscount.Type EQ 1 )
					ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
				else
					ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
			}
		}
		else	{
			if ( ShippingDiscount.Type EQ 1 )
				ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
			else
				ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
		}
	
	</cfscript>
	
	
	<!--- <cfif GlobalShipDiscount EQ 0 >
		<!--- INVOKE INSTANCE OF OBJECT - GET PRODUCT PRICE, INCLUDING ANY DISCOUNTS --->
		<!--- <cfinvoke component="#application.Cart#" method="getShipDiscount" returnvariable="ShippingDiscount">
			<cfif session.CustomerArray[28] EQ '' >
				<cfinvokeargument name="UserID" value="1">
			<cfelse>
				<cfinvokeargument name="UserID" value="#session.CustomerArray[28]#">
			</cfif>
			<cfinvokeargument name="SiteID" value="#application.SiteID#">
			<cfinvokeargument name="ShippingMethod" value="Price">
			<cfinvokeargument name="SessionID" value="#SessionID#">
		</cfinvoke> --->
		
		<cfscript>
			if( session.CustomerArray[28] EQ '')	{
				UserId = 1;
			}
			else	{
				UserID = session.CustomerArray[28];
			}
			ShippingDiscount = application.Cart.getShipDiscount(
				UserID=UserID, 
				SiteID=application.SiteID,
				ShippingMethod='Price',
				SessionID=SessionID);
		
		
			if ( ShippingDiscount.ShipMethod EQ 'Price' )
			{
				UsedShipDiscounts = ListAppend(UsedShipDiscounts,ShippingDiscount.ID) ;
				if ( ShippingDiscount.Type EQ 1 )
					ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
				else
					ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
			}
		</cfscript>
	<cfelse><!--- THERE IS AN AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS ---> 
		<cfscript>
			if ( ShippingDiscount.Type EQ 1 )
				ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
			else
				ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
		</cfscript>
	</cfif> --->
	<!--- END: GET SHIPPING DISCOUNT --->

<!--- SHIPBY WEIGHT --->	
<cfelseif application.ShipBy EQ 2>

	<cfquery name="getShipPrice" datasource="#application.dsn#">				
		SELECT	InternationalRate, DomesticRate
		FROM	ShipWeight
		WHERE	Start	<	#Cart.CartWeight#
		AND		Finish	>=	#Cart.CartWeight#
		AND		SiteID = #application.SiteID#
	</cfquery>
	
	<cfscript>
		if (getShipPrice.RecordCount NEQ 0)
		{
			if (IntShip EQ 1) // Apply International Rate
			{
				if (getShipPrice.InternationalRate NEQ '')
					ShippingPrice = ShippingPrice + getShipPrice.InternationalRate;
				else
					ShippingPrice = ShippingPrice + application.DefaultShipRateInt ;
			}
			else
			{
				if (getShipPrice.DomesticRate NEQ '')
					ShippingPrice = ShippingPrice + getShipPrice.DomesticRate;
				else
					ShippingPrice = ShippingPrice + application.DefaultShipRateDom ;
			}
		}
		else if (IntShip EQ 1)
			ShippingPrice = ShippingPrice + application.DefaultShipRateInt ;
		else
			ShippingPrice = ShippingPrice + application.DefaultShipRateDom ;
	</cfscript>		
	
	<!--- BEGIN: GET SHIPPING DISCOUNT --->
	
	<cfif GlobalShipDiscount EQ 0 >
		<!--- INVOKE INSTANCE OF OBJECT - GET PRODUCT PRICE, INCLUDING ANY DISCOUNTS --->
		<cfinvoke component="#application.Cart#" method="getShipDiscount" returnvariable="ShippingDiscount">
			<cfif session.CustomerArray[28] EQ '' >
				<cfinvokeargument name="UserID" value="1">
			<cfelse>
				<cfinvokeargument name="UserID" value="#session.CustomerArray[28]#">
			</cfif>
			<cfinvokeargument name="SiteID" value="#application.SiteID#">
			<cfinvokeargument name="ShippingMethod" value="Weight">
			<cfinvokeargument name="SessionID" value="#SessionID#">
		</cfinvoke>
		
		<cfscript>
			if ( ShippingDiscount.ShipMethod EQ 'Weight' )
			{
				UsedShipDiscounts = ListAppend(UsedShipDiscounts,ShippingDiscount.ID) ;
				if ( ShippingDiscount.Type EQ 1 )
					ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
				else
					ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
			}
		</cfscript>
	<cfelse><!--- THERE IS AN AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS ---> 
		<cfscript>
			if ( ShippingDiscount.Type EQ 1 )
				ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
			else
				ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
		</cfscript>
	</cfif>
	<!--- END: GET SHIPPING DISCOUNT --->


<!--- SHIPBY AUTOMATED --->
<cfelseif application.ShipBy EQ 3>

	<cfparam name="ShippingMethod" default="">
	
	<cfif ShippingMethod neq 'Default' and ShippingMethod neq '' >
	
		<!--- OVERWEIGHT --->
		<cfif ShippingMethod EQ 'OverWeight'>
			<cfset ShippingPrice = ShippingPrice + application.DefaultShipRateOver >
			
		
		<!--- UPS --->	
		<cfelseif ShippingMethod GTE '1' AND ShippingMethod LTE '65'>
			
			<cf_TagUPS
				function="rateRequest"
				UPSAccessKey="#UPSAccessKey#"
				UPSUserID="#UPSUserID#"
				UPSPassword="#UPSPassword#"
				PickUpType="03"
				ServiceType="#ShippingMethod#"
				ShipperCity="#application.CompanyCity#"
				ShipperState="#application.CompanyState#"
				ShipperZip="#application.CompanyZip#"
				ShipperCountry="#application.CompanyCountry#"
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
						if ( TotalCharges EQ 0 )
						{
							if ( session.CustomerArray[25] NEQ application.BaseCountry )
								TotalCharges = application.DefaultShipRateInt;
							else
								TotalCharges = application.DefaultShipRateDom;
						}
						ShippingPrice = ShippingPrice + TotalCharges ;
					</cfscript>

					<!--- BEGIN: GET SHIPPING DISCOUNTS --->
					<cfif GlobalShipDiscount EQ 0 >
						<!--- INVOKE INSTANCE OF OBJECT - GET SHIPPING DISCOUNT --->
						
						<!--- <cfinvoke component="#application.Cart#" method="getShipDiscount" returnvariable="ShippingDiscount">
							<cfif session.CustomerArray[28] EQ '' >
								<cfinvokeargument name="UserID" value="1">
							<cfelse>
								<cfinvokeargument name="UserID" value="#session.CustomerArray[28]#">
							</cfif>
							<cfinvokeargument name="SiteID" value="#application.SiteID#">
							<cfinvokeargument name="ShippingMethod" value="#ShippingMethod#">
							<cfinvokeargument name="SessionID" value="#SessionID#">
						</cfinvoke> --->
						
						<cfscript>
							if( session.CustomerArray[28] EQ '')	{
								UserId = 1;
							}
							else	{
								UserID = session.CustomerArray[28];
							}
							ShippingDiscount = application.Cart.getShipDiscount(
								UserID=UserID, 
								SiteID=application.SiteID,
								ShippingMethod=ShippingMethod,
								SessionID=SessionID);
						
						// Shipping
							if ( ShippingDiscount.ShipMethod EQ ShippingMethod )
							{
								UsedShipDiscounts = ListAppend(UsedShipDiscounts,ShippingDiscount.ID) ;
								if ( ShippingDiscount.Type EQ 1 )
									ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
								else
									ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
							}
						</cfscript>
					<cfelseif GlobalShipDiscount EQ 1 ><!--- THERE IS AN AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS ---> 
						<cfscript>
							if ( ShippingDiscount.Type EQ 1 )
								ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
							else
								ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
						</cfscript>
					</cfif>
					<!--- END: GET SHIPPING DISCOUNT --->
					
				</cfoutput>
			<cfelse>
				<cfscript>
					if ( session.CustomerArray[25] NEQ application.BaseCountry )
						ShippingPrice = ShippingPrice + application.DefaultShipRateInt;
					else
						ShippingPrice = ShippingPrice + application.DefaultShipRateDom;
				</cfscript>
			</cfif>
		
		
		<!--- USPS/POSTAL --->
		<cfelseif ShippingMethod EQ 'Express'
		   OR ShippingMethod EQ 'First Class'
		   OR ShippingMethod EQ 'Priority'
		   OR ShippingMethod EQ 'Parcel'
		   OR ShippingMethod EQ 'BPM'
		   OR ShippingMethod EQ 'Library'
		   OR ShippingMethod EQ 'Media'>
			
			<cfscript> 
				pounds = int(Cart.CartWeight); 
				ounces = (Cart.CartWeight - pounds) * 16; 
				ounces = round(ounces * 100) / 100; 	// round ounces off at 2 decimal places - UNNECESSARY REALLY
				decimal = (int(ounces) + 1) - ounces; 	// create decimal value to check to round up
				if ( decimal LT 1 ) 					// if there is a decimal value, round up 1
					ounces = int(ounces) + 1;
				else									// otherwise, set to ounces integer
					ounces = int(ounces);
			</cfscript> 
			
			<cfif session.CustomerArray[25] NEQ application.BaseCountry >
				<!--- INTERNATIONAL RATE --->
				<cf_TagUSPS
					function="RateIntlRequest"
					USPSUserID="#USPSUserID#"
					USPSPassword="#USPSPassword#"
					ShipToCountry="#session.CustomerArray[25]#"
					PackageWeightLB="#pounds#"
					PackageWeightOZ="#ounces#"
					PackageType="Package"
					TestingEnvironment="False" >
			<cfelse>
				<!--- DOMESTIC RATES --->
				<cf_TagUSPS
					function="RateDomesticRequest"
					USPSUserID="#USPSUserID#"
					USPSPassword="#USPSPassword#"
					ShipFromZip5="#application.DefaultOriginZipCode#"
					ShipToZip5="#session.CustomerArray[24]#"
					PackageWeightLB="#pounds#"
					PackageWeightOZ="#ounces#"
					PackageSize="Regular"
					ServiceLevel="#ShippingMethod#"
					TestingEnvironment="False" >
			</cfif>
			
			<cfif IsDefined("USPSDomesticRateQuery") AND isDefined('USPSError') AND USPSError EQ 0 >
				<cfoutput query="USPSDomesticRateQuery">
					<cfscript>
						if ( FreightCharges EQ 0 )
							FreightCharges = application.DefaultShipRateDom;
						ShippingPrice = ShippingPrice + FreightCharges ;
					</cfscript>
					
					<!--- BEGIN: GET SHIPPING DISCOUNTS --->
					<cfif GlobalShipDiscount EQ 0 >
						<!--- INVOKE INSTANCE OF OBJECT - GET SHIPPING DISCOUNT --->
						<cfinvoke component="#application.Cart#" method="getShipDiscount" returnvariable="ShippingDiscount">
							<cfif session.CustomerArray[28] EQ '' >
								<cfinvokeargument name="UserID" value="1">
							<cfelse>
								<cfinvokeargument name="UserID" value="#session.CustomerArray[28]#">
							</cfif>
							<cfinvokeargument name="SiteID" value="#application.SiteID#">
							<cfinvokeargument name="ShippingMethod" value="#ShippingMethod#">
							<cfinvokeargument name="SessionID" value="#SessionID#">
						</cfinvoke>
						
						<cfscript>
							if ( ShippingDiscount.ShipMethod EQ ShippingMethod )
							{
								UsedShipDiscounts = ListAppend(UsedShipDiscounts,ShippingDiscount.ID) ;
								if ( ShippingDiscount.Type EQ 1 )
									ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
								else
									ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
							}
						</cfscript>
					<cfelseif GlobalShipDiscount EQ 1 ><!--- THERE IS AN AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS --->
						<cfscript>
							if ( ShippingDiscount.Type EQ 1 )
								ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
							else
								ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
						</cfscript>
					</cfif>
					<!--- END: GET SHIPPING DISCOUNT --->
					
				</cfoutput>
			<cfelseif IsDefined("USPSIntlRateServicesQuery") AND isDefined('USPSError') AND USPSError EQ 0 >
				<cfoutput query="USPSIntlRateServicesQuery">
					<cfscript>
						if ( FreightCharges EQ 0 )
							FreightCharges = application.DefaultShipRateInt;
						ShippingPrice = ShippingPrice + FreightCharges ;
					</cfscript>
					
					<!--- BEGIN: GET SHIPPING DISCOUNTS --->
					<cfif GlobalShipDiscount EQ 0 >
						<!--- INVOKE INSTANCE OF OBJECT - GET SHIPPING DISCOUNT --->
						<cfinvoke component="#application.Cart#" method="getShipDiscount" returnvariable="ShippingDiscount">
							<cfif session.CustomerArray[28] EQ '' >
								<cfinvokeargument name="UserID" value="1">
							<cfelse>
								<cfinvokeargument name="UserID" value="#session.CustomerArray[28]#">
							</cfif>
							<cfinvokeargument name="SiteID" value="#application.SiteID#">
							<cfinvokeargument name="ShippingMethod" value="#ShippingMethod#">
							<cfinvokeargument name="SessionID" value="#SessionID#">
						</cfinvoke>
						
						<cfscript>
							if ( ShippingDiscount.ShipMethod EQ ShippingMethod )
							{
								UsedShipDiscounts = ListAppend(UsedShipDiscounts,ShippingDiscount.ID) ;
								if ( ShippingDiscount.Type EQ 1 )
									ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
								else
									ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
							}
						</cfscript>
					<cfelseif GlobalShipDiscount EQ 1 ><!--- THERE IS AN AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS --->
						<cfscript>
							if ( ShippingDiscount.Type EQ 1 )
								ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
							else
								ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
						</cfscript>
					</cfif>
					<!--- END: GET SHIPPING DISCOUNT --->
					
				</cfoutput>
			<cfelse>
				<cfscript>
					if ( session.CustomerArray[25] NEQ application.BaseCountry )
						ShippingPrice = ShippingPrice + application.DefaultShipRateInt;
					else
						ShippingPrice = ShippingPrice + application.DefaultShipRateDom;
				</cfscript>
			</cfif>
			
			
		<!--- FEDEX --->
		<cfelseif ShippingMethod EQ 'STANDARDOVERNIGHT'
		   OR ShippingMethod EQ 'PRIORITYOVERNIGHT'
		   OR ShippingMethod EQ 'FIRSTOVERNIGHT'
		   OR ShippingMethod EQ 'FEDEX2DAY'
		   OR ShippingMethod EQ 'FEDEXEXPRESSSAVER'
		   OR ShippingMethod EQ 'FEDEXGROUND'
		   OR ShippingMethod EQ 'GROUNDHOMEDELIVERY'
		   OR ShippingMethod EQ 'INTERNATIONALPRIORITY'
		   OR ShippingMethod EQ 'INTERNATIONALECONOMY'
		   OR ShippingMethod EQ 'INTERNATIONALFIRST' 
		   OR ShippingMethod EQ 'FEDEX1DAYFREIGHT'
		   OR ShippingMethod EQ 'FEDEX2DAYFREIGHT'
		   OR ShippingMethod EQ 'FEDEX3DAYFREIGHT'
		   OR ShippingMethod EQ 'INTERNATIONALPRIORITYFREIGHT'
		   OR ShippingMethod EQ 'INTERNATIONALECONOMYFREIGHT' >
			
			<cf_TagFedex 
				function="rateRequest"
				fedexindentifier="#identifier#"
				accountnumber="#fedexAcNum#"
				servicelevel="#ShippingMethod#"
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
					
					<!--- <b style="color:blue">#ShippingPrice#</b><br> --->
					
					<cfscript>
						if ( Len(ListNetTotalCharge) GT 0 )
							ShippingPrice = ShippingPrice + ListNetTotalCharge ;
						else
							ShippingPrice = ShippingPrice + DiscBaseTotalCharges ;
					
						if ( ShippingPrice EQ 0 )
						{
							if ( session.CustomerArray[25] NEQ application.BaseCountry )
								ShippingPrice = ShippingPrice + application.DefaultShipRateInt;
							else
								ShippingPrice = ShippingPrice + application.DefaultShipRateDom;
						}
					</cfscript>
					
					<!--- <b style="color:green">#ShippingPrice#</b><br> --->
					
					<!--- BEGIN: GET SHIPPING DISCOUNTS --->
					<cfif GlobalShipDiscount EQ 0 >
						<!--- INVOKE INSTANCE OF OBJECT - GET SHIPPING DISCOUNT --->
						<cfinvoke component="#application.Cart#" method="getShipDiscount" returnvariable="ShippingDiscount">
							<cfif session.CustomerArray[28] EQ '' >
								<cfinvokeargument name="UserID" value="1">
							<cfelse>
								<cfinvokeargument name="UserID" value="#session.CustomerArray[28]#">
							</cfif>
							<cfinvokeargument name="SiteID" value="#application.SiteID#">
							<cfinvokeargument name="ShippingMethod" value="#ShippingMethod#">
							<cfinvokeargument name="SessionID" value="#SessionID#">
						</cfinvoke>
						
						<cfscript>
							if ( ShippingDiscount.ShipMethod EQ ShippingMethod )
							{
								UsedShipDiscounts = ListAppend(UsedShipDiscounts,ShippingDiscount.ID) ;
								if ( ShippingDiscount.Type EQ 1 )
									ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
								else
									ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
							}
						</cfscript>
					<cfelseif GlobalShipDiscount EQ 1 ><!--- THERE IS AN AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS ---> 
						<cfscript>
							if ( ShippingDiscount.Type EQ 1 )
								ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
							else
								ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
						</cfscript>
					</cfif>
					<!--- END: GET SHIPPING DISCOUNT --->					
					
					<!--- <b style="color:black">#ShippingPrice#</b><br> --->
					
				</cfoutput>
			<cfelse>
				<cfscript>
					if ( session.CustomerArray[25] NEQ application.BaseCountry )
						ShippingPrice = ShippingPrice + application.DefaultShipRateInt;
					else
						ShippingPrice = ShippingPrice + application.DefaultShipRateDom;
				</cfscript>
			</cfif>
		
		
		<!--- INTERNATIONAL: AND NO OTHER SHIPPING METHOD SELECTED --->
		<cfelseif session.CustomerArray[25] NEQ application.BaseCountry >
			<cfset ShippingPrice = application.DefaultShipRateInt >	

		</cfif>
		<!--- END: SHIPPINGMETHOD --->
		
	<!--- SHIPPINGMETHOD IS 'Default' --->
	<cfelseif session.CustomerArray[25] NEQ application.BaseCountry >
		<!--- INTERNATIONAL --->
		<cfset ShippingPrice = ShippingPrice + application.DefaultShipRateInt >
	<cfelse>
		<cfset ShippingPrice = ShippingPrice + application.DefaultShipRateDom >
	</cfif>


<!--- SHIPBY REGION/GEOGRAPHY --->	
<cfelseif application.ShipBy EQ 4 >

	<cfif session.CustomerArray[25] EQ application.BaseCountry >
		<cfquery name="getRate" datasource="#application.dsn#">
			SELECT 	*
			FROM 	States
			WHERE 	StateCode = '#session.CustomerArray[23]#'
		</cfquery>
		<cfscript>
			if ( GetRate.S_Rate EQ '' OR GetRate.S_Rate EQ 0 )
				ShippingPrice = ShippingPrice + application.DefaultShipRateDom ;
			else
				ShippingPrice = ShippingPrice + GetRate.S_Rate ;
		</cfscript>
	<cfelse>
		<cfquery name="getRate" datasource="#application.dsn#">
			SELECT 	*
			FROM	countries
			WHERE	Country = '#session.CustomerArray[25]#'
		</cfquery>
		<cfscript>
			if ( GetRate.S_Rate EQ '' OR GetRate.S_Rate EQ 0 )
				ShippingPrice = ShippingPrice + application.DefaultShipRateInt ;
			else
				ShippingPrice = ShippingPrice + GetRate.S_Rate ;
		</cfscript>
	</cfif>
	
	<!--- BEGIN: GET SHIPPING DISCOUNT --->
	<cfif GlobalShipDiscount EQ 0 >
		<!--- INVOKE INSTANCE OF OBJECT - GET PRODUCT PRICE, INCLUDING ANY DISCOUNTS --->
		<cfinvoke component="#application.Cart#" method="getShipDiscount" returnvariable="ShippingDiscount">
			<cfif session.CustomerArray[28] EQ '' >
				<cfinvokeargument name="UserID" value="1">
			<cfelse>
				<cfinvokeargument name="UserID" value="#session.CustomerArray[28]#">
			</cfif>
			<cfinvokeargument name="SiteID" value="#application.SiteID#">
			<cfinvokeargument name="ShippingMethod" value="Location">
			<cfinvokeargument name="SessionID" value="#SessionID#">
		</cfinvoke>
		
		<cfscript>
			if ( ShippingDiscount.ShipMethod EQ 'Location' )
			{
				UsedShipDiscounts = ListAppend(UsedShipDiscounts,ShippingDiscount.ID) ;
				if ( ShippingDiscount.Type EQ 1 )
					ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
				else
					ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
			}
		</cfscript>
	<cfelse><!--- THERE IS AN AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS ---> 
		<cfscript>
			if ( ShippingDiscount.Type EQ 1 )
				ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
			else
				ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
		</cfscript>
	</cfif>
	<!--- END: GET SHIPPING DISCOUNT --->



<!--- SHIPBY CUSTOM SHIPPING OPTIONS: WEIGHT --->	
<cfelseif application.ShipBy EQ 5 >
	
	<cfquery name="getCustomShipping" datasource="#application.dsn#">
		SELECT 	ShipPrice
		FROM	ShippingMethods
		WHERE	SiteID = #application.SiteID#
		AND		ShippingCode = '#ShippingMethod#'
	</cfquery>
	
	<cfif getCustomShipping.RecordCount NEQ 0 AND getCustomShipping.ShipPrice NEQ ''>
		<cfset ShippingPrice = ShippingPrice + getCustomShipping.ShipPrice >
	</cfif>	
	
	<!--- --->	
	<!--- BEGIN: GET SHIPPING DISCOUNT --->
	<cfif GlobalShipDiscount EQ 0 >
		<!--- INVOKE INSTANCE OF OBJECT - GET PRODUCT PRICE, INCLUDING ANY DISCOUNTS --->
		<cfinvoke component="#application.Cart#" method="getShipDiscount" returnvariable="ShippingDiscount">
			<cfif session.CustomerArray[28] EQ '' >
				<cfinvokeargument name="UserID" value="1">
			<cfelse>
				<cfinvokeargument name="UserID" value="#session.CustomerArray[28]#">
			</cfif>
			<cfinvokeargument name="SiteID" value="#application.SiteID#">
			<cfinvokeargument name="ShippingMethod" value="Weight">
			<cfinvokeargument name="SessionID" value="#SessionID#">
		</cfinvoke>
		
		<cfscript>
			if ( ShippingDiscount.ShipMethod EQ 'Weight' )
			{
				UsedShipDiscounts = ListAppend(UsedShipDiscounts,ShippingDiscount.ID) ;
				if ( ShippingDiscount.Type EQ 1 )
					ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
				else
					ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
			}
		</cfscript>
	<cfelse><!--- THERE IS AN AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS ---> 
		<cfscript>
			if ( ShippingDiscount.Type EQ 1 )
				ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
			else
				ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
		</cfscript>
	</cfif>
	<!--- END: GET SHIPPING DISCOUNT --->
	
	
<!--- SHIPBY CUSTOM SHIPPING OPTIONS: PRICE --->	
<cfelseif application.ShipBy EQ 6 >
	
	<cfquery name="getCustomShipping" datasource="#application.dsn#">
		SELECT 	ShipPrice
		FROM	ShippingMethods
		WHERE	SiteID = #application.SiteID#
		AND		ShippingCode = '#ShippingMethod#'
	</cfquery>
	
	<cfif getCustomShipping.RecordCount NEQ 0 AND getCustomShipping.ShipPrice NEQ ''>
		<cfset ShippingPrice = ShippingPrice + getCustomShipping.ShipPrice >
	</cfif>	
	
	<!--- --->	
	<!--- BEGIN: GET SHIPPING DISCOUNT --->
	<cfif GlobalShipDiscount EQ 0 >
		<!--- INVOKE INSTANCE OF OBJECT - GET PRODUCT PRICE, INCLUDING ANY DISCOUNTS --->
		<cfinvoke component="#application.Cart#" method="getShipDiscount" returnvariable="ShippingDiscount">
			<cfif session.CustomerArray[28] EQ '' >
				<cfinvokeargument name="UserID" value="1">
			<cfelse>
				<cfinvokeargument name="UserID" value="#session.CustomerArray[28]#">
			</cfif>
			<cfinvokeargument name="SiteID" value="#application.SiteID#">
			<cfinvokeargument name="ShippingMethod" value="Price">
			<cfinvokeargument name="SessionID" value="#SessionID#">
		</cfinvoke>
		
		<cfscript>
			if ( ShippingDiscount.ShipMethod EQ 'Price' )
			{
				UsedShipDiscounts = ListAppend(UsedShipDiscounts,ShippingDiscount.ID) ;
				if ( ShippingDiscount.Type EQ 1 )
					ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
				else
					ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
			}
		</cfscript>
	<cfelse><!--- THERE IS AN AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS ---> 
		<cfscript>
			if ( ShippingDiscount.Type EQ 1 )
				ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
			else
				ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
		</cfscript>
	</cfif>
	<!--- END: GET SHIPPING DISCOUNT --->


<!--- SHIPBY RETAIL PRO --->
<cfelseif application.ShipBy EQ 7 >
	
	<!--- <cfquery name="getShippingCodes" datasource="#application.dsn#" >
		SELECT	*
		FROM	ShippingCodes
	</cfquery> --->
	<cfscript>
		RPTotalWeight = 0 ;
		RPShipPriceAdd = 0 ;
		RPShipCodeUsed = 0 ;
	</cfscript>
	
	<cfloop query="getCartItems.data">
		<cfif fldShipByWeight EQ true >
			<cfscript>
				RPTotalWeight = RPTotalWeight + (DecimalFormat(fldShipWeight) * Qty) ;
			</cfscript>
		<cfelse>
			<!--- CUSTOM SHIPPING CODES --->
			<cfquery name="checkShippingCode" dbtype="query" >
				SELECT	*
				FROM	getShippingCodes
				WHERE	ShippingCode = #fldShipCode# <!--- previous CF code: #fldShipAmount#, field fldShipCode added 22-Mar-07 --->
			</cfquery>
			
			<!--- CUSTOM MESSAGE IS APPLICABLE --->
			<cfif checkShippingCode.RecordCount NEQ 0 >
				<cfif RPShipCodeUsed NEQ 1 >
					<cfscript>
						RPShipCodeUsed = 1 ;
						RPShipCode = checkShippingCode.ShippingCode ;
					</cfscript>
				</cfif>
			<!--- NO MESSAGE, CONTINUE ADDING ADDITIONAL SHIPPING/HANDLING --->
			<cfelse>
				<cfscript>
					RPShipPriceAdd = RPShipPriceAdd + (DecimalFormat(fldShipAmount) + DecimalFormat(fldHandAmount)) ;
				</cfscript>
			</cfif>
		</cfif>
	</cfloop>
	
	<cfif ShippingMethod NEQ 'Default'>
		<cfquery name="getCustomShipping" datasource="#application.dsn#">
			SELECT 	ShipPrice
			FROM	ShippingMethods
			WHERE	SiteID = #application.SiteID#
			AND		ShippingCode = '#ShippingMethod#'
		</cfquery>
		<cfscript>
			if ( getCustomShipping.RecordCount NEQ 0 AND getCustomShipping.ShipPrice NEQ '' )
				ShippingPrice = ShippingPrice + getCustomShipping.ShipPrice + RPShipPriceAdd ;
			else if ( RPShipPriceAdd GT 0 )
				ShippingPrice = ShippingPrice + RPShipPriceAdd ;
		</cfscript>
	<cfelseif RPShipCodeUsed EQ 1 >
		<cfscript>
			ShippingPrice = ShippingPrice + 0 ;
		</cfscript>
	<cfelse>
		<cfscript>
			if ( session.CustomerArray[25] NEQ application.BaseCountry AND application.AcceptIntShipment EQ 1 )
				ShippingPrice = ShippingPrice + application.DefaultShipRateInt ;
			else
				ShippingPrice = ShippingPrice + application.DefaultShipRateDom ;
		</cfscript>
	</cfif>
		
	<!--- BEGIN: GET SHIPPING DISCOUNT --->
	<cfif GlobalShipDiscount EQ 0 >
		<!--- INVOKE INSTANCE OF OBJECT - GET PRODUCT PRICE, INCLUDING ANY DISCOUNTS --->
		<cfinvoke component="#application.Cart#" method="getShipDiscount" returnvariable="ShippingDiscount">
			<cfif session.CustomerArray[28] EQ '' >
				<cfinvokeargument name="UserID" value="1">
			<cfelse>
				<cfinvokeargument name="UserID" value="#session.CustomerArray[28]#">
			</cfif>
			<cfinvokeargument name="SiteID" value="#application.SiteID#">
			<cfinvokeargument name="ShippingMethod" value="Weight">
			<cfinvokeargument name="SessionID" value="#SessionID#">
		</cfinvoke>
		
		<cfscript>
			if ( ShippingDiscount.ShipMethod EQ 'Weight' )
			{
				UsedShipDiscounts = ListAppend(UsedShipDiscounts,ShippingDiscount.ID) ;
				if ( ShippingDiscount.Type EQ 1 )
					ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
				else
					ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
			}
		</cfscript>
	<cfelse><!--- THERE IS AN AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS ---> 
		<cfscript>
			if ( ShippingDiscount.Type EQ 1 )
				ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
			else
				ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
		</cfscript>
	</cfif>
	<!--- END: GET SHIPPING DISCOUNT --->
		
<!--- FALLBACK --->
<cfelse>
	<cfset ShippingPrice = ShippingPrice + application.DefaultShipRateDom >
</cfif>
	
	<!--- CARTFUSION 4.6 - APPLY HANDLING FEE TO SHIPPING PRICE --->
	<!--- (previously only applied to automated realtime shipping) --->
	<cfscript>
		if ( application.HandlingType EQ 1 ) {
			ShippingPrice = NumberFormat(ShippingPrice + (ShippingPrice * (application.HandlingFee/100)),0.00) ;
		} else {
			ShippingPrice = NumberFormat(ShippingPrice + application.HandlingFee,0.00) ;
		}
	</cfscript>
	
	<!--- <cfoutput><b style="color:maroon">#ShippingPrice#</b><br></cfoutput> --->
		
	<cfscript>
		'ShippingPrice#cpi#' = NumberFormat(ShippingPrice,0.00) ;
		TotalShippingPrice = TotalShippingPrice + Evaluate('ShippingPrice' & cpi) ;
		ShippingPrice = 0 ;
	</cfscript>
</cfloop>

<cfset ShippingPrice = TotalShippingPrice >
<!--- CARTFUSION 4.5 - MULTIPLE SHIPPING ADDRESSES --->
<!--- *** END: SHIPPING CALCULATIONS *** --->
