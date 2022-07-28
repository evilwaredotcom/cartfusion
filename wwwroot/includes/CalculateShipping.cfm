<cfinvoke component="#application.Queries#" method="getShippingCos" returnvariable="getShippingCos">
	<cfinvokeargument name="SiteID" value="#config.SiteID#">
</cfinvoke>
<!--- CARTFUSION 4.6 - SHIPPING CODES --->
<cfquery name="getShippingCodes" datasource="#datasource#" >
    SELECT	*
    FROM	ShippingCodes
</cfquery>

<!--- Initialize variables --->
<cfscript>
	fedexAcNum   = getShippingCos.FedexAccountNum ;
	identifier   = getShippingCos.FedexIdentifier ;
	UPSAccessKey = getShippingCos.UPSAccessKey ;
	UPSUserID    = getShippingCos.UPSUserID ;
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
	if ( session.CustomerArray[25] NEQ config.BaseCountry ) // Verify if Shipping is International or not
		IntShip = 1 ;
</cfscript>

<!--- BEGIN: CALCULATE TOTAL WEIGHT & TOTAL PRICE OF ORDER --->
<cfif NOT isDefined('Cart.CartTotal') >
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
	<cfinvokeargument name="SiteID" value="#config.SiteID#">
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
        <cfoutput><b style="color:green">#ShippingPrice#</b><br></cfoutput>
    </cfloop>
    

<!--- SHIPBY PRICE --->
<cfif config.ShipBy EQ 1>

	<cfquery name="getShipPrice" datasource="#datasource#">				
		SELECT	InternationalRate, DomesticRate
		FROM	ShipPrice
		WHERE	Start	<	#Cart.CartTotal#
		AND		Finish	>=	#Cart.CartTotal#
		AND		SiteID = #config.SiteID#
	</cfquery>
		
	<cfscript>
		if (getShipPrice.RecordCount NEQ 0)
		{
			if (IntShip EQ 1) // Apply International Rate
			{
				if (getShipPrice.InternationalRate NEQ '')
					ShippingPrice = ShippingPrice + getShipPrice.InternationalRate ;
				else
					ShippingPrice = ShippingPrice + config.DefaultShipRateInt ;
			}
			else
			{
				if (getShipPrice.DomesticRate NEQ '')
					ShippingPrice = ShippingPrice + getShipPrice.DomesticRate ;
				else
					ShippingPrice = ShippingPrice + config.DefaultShipRateDom ;
			}
		}
		else if (IntShip EQ 1)
			ShippingPrice = ShippingPrice + config.DefaultShipRateInt ;
		else
			ShippingPrice = ShippingPrice + config.DefaultShipRateDom ;
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
			<cfinvokeargument name="SiteID" value="#config.SiteID#">
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

<!--- SHIPBY WEIGHT --->	
<cfelseif config.ShipBy EQ 2>

	<cfquery name="getShipPrice" datasource="#datasource#">				
		SELECT	InternationalRate, DomesticRate
		FROM	ShipWeight
		WHERE	Start	<	#Cart.CartWeight#
		AND		Finish	>=	#Cart.CartWeight#
		AND		SiteID = #config.SiteID#
	</cfquery>
	
	<cfscript>
		if (getShipPrice.RecordCount NEQ 0)
		{
			if (IntShip EQ 1) // Apply International Rate
			{
				if (getShipPrice.InternationalRate NEQ '')
					ShippingPrice = ShippingPrice + getShipPrice.InternationalRate;
				else
					ShippingPrice = ShippingPrice + config.DefaultShipRateInt ;
			}
			else
			{
				if (getShipPrice.DomesticRate NEQ '')
					ShippingPrice = ShippingPrice + getShipPrice.DomesticRate;
				else
					ShippingPrice = ShippingPrice + config.DefaultShipRateDom ;
			}
		}
		else if (IntShip EQ 1)
			ShippingPrice = ShippingPrice + config.DefaultShipRateInt ;
		else
			ShippingPrice = ShippingPrice + config.DefaultShipRateDom ;
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
			<cfinvokeargument name="SiteID" value="#config.SiteID#">
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
<cfelseif config.ShipBy EQ 3>

	<cfparam name="ShippingMethod" default="">
	
	<cfif ShippingMethod NEQ 'Default' AND ShippingMethod NEQ '' >
	
		<!--- OVERWEIGHT --->
		<cfif ShippingMethod EQ 'OverWeight'>
			<cfset ShippingPrice = ShippingPrice + config.DefaultShipRateOver >
			
		
		<!--- UPS --->	
		<cfelseif ShippingMethod GTE '1' AND ShippingMethod LTE '65'>
			
			<cf_TagUPS
				function="rateRequest"
				UPSAccessKey="#UPSAccessKey#"
				UPSUserID="#UPSUserID#"
				UPSPassword="#UPSPassword#"
				PickUpType="03"
				ServiceType="#ShippingMethod#"
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
						if ( TotalCharges EQ 0 )
						{
							if ( session.CustomerArray[25] NEQ config.BaseCountry )
								TotalCharges = config.DefaultShipRateInt;
							else
								TotalCharges = config.DefaultShipRateDom;
						}
						ShippingPrice = ShippingPrice + TotalCharges ;
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
							<cfinvokeargument name="SiteID" value="#config.SiteID#">
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
					if ( session.CustomerArray[25] NEQ config.BaseCountry )
						ShippingPrice = ShippingPrice + config.DefaultShipRateInt;
					else
						ShippingPrice = ShippingPrice + config.DefaultShipRateDom;
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
			
			<cfif session.CustomerArray[25] NEQ config.BaseCountry >
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
					ShipFromZip5="#config.DefaultOriginZipCode#"
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
							FreightCharges = config.DefaultShipRateDom;
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
							<cfinvokeargument name="SiteID" value="#config.SiteID#">
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
							FreightCharges = config.DefaultShipRateInt;
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
							<cfinvokeargument name="SiteID" value="#config.SiteID#">
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
					if ( session.CustomerArray[25] NEQ config.BaseCountry )
						ShippingPrice = ShippingPrice + config.DefaultShipRateInt;
					else
						ShippingPrice = ShippingPrice + config.DefaultShipRateDom;
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
				ShipperState="#config.CompanyState#"
				ShipperZip="#config.DefaultOriginZipCode#"
				ShipperCountry="#config.BaseCountry#"
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
							if ( session.CustomerArray[25] NEQ config.BaseCountry )
								ShippingPrice = ShippingPrice + config.DefaultShipRateInt;
							else
								ShippingPrice = ShippingPrice + config.DefaultShipRateDom;
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
							<cfinvokeargument name="SiteID" value="#config.SiteID#">
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
					if ( session.CustomerArray[25] NEQ config.BaseCountry )
						ShippingPrice = ShippingPrice + config.DefaultShipRateInt;
					else
						ShippingPrice = ShippingPrice + config.DefaultShipRateDom;
				</cfscript>
			</cfif>
		
		
		<!--- INTERNATIONAL: AND NO OTHER SHIPPING METHOD SELECTED --->
		<cfelseif session.CustomerArray[25] NEQ config.BaseCountry >
			<cfset ShippingPrice = config.DefaultShipRateInt >	

		</cfif>
		<!--- END: SHIPPINGMETHOD --->
        
	<!--- SHIPPINGMETHOD IS 'Default' --->
	<cfelseif session.CustomerArray[25] NEQ config.BaseCountry >
		<!--- INTERNATIONAL --->
		<cfset ShippingPrice = ShippingPrice + config.DefaultShipRateInt >
	<cfelse>
		<cfset ShippingPrice = ShippingPrice + config.DefaultShipRateDom >
	</cfif>


<!--- SHIPBY REGION/GEOGRAPHY --->	
<cfelseif config.ShipBy EQ 4 >

	<cfif session.CustomerArray[25] EQ config.BaseCountry >
		<cfquery name="getRate" datasource="#datasource#">
			SELECT 	*
			FROM 	States
			WHERE 	StateCode = '#session.CustomerArray[23]#'
		</cfquery>
		<cfscript>
			if ( GetRate.S_Rate EQ '' OR GetRate.S_Rate EQ 0 )
				ShippingPrice = ShippingPrice + config.DefaultShipRateDom ;
			else
				ShippingPrice = ShippingPrice + GetRate.S_Rate ;
		</cfscript>
	<cfelse>
		<cfquery name="getRate" datasource="#datasource#">
			SELECT 	*
			FROM	countries
			WHERE	Country = '#session.CustomerArray[25]#'
		</cfquery>
		<cfscript>
			if ( GetRate.S_Rate EQ '' OR GetRate.S_Rate EQ 0 )
				ShippingPrice = ShippingPrice + config.DefaultShipRateInt ;
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
			<cfinvokeargument name="SiteID" value="#config.SiteID#">
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
<cfelseif config.ShipBy EQ 5 >
	
	<cfquery name="getCustomShipping" datasource="#datasource#">
		SELECT 	ShipPrice
		FROM	ShippingMethods
		WHERE	SiteID = #config.SiteID#
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
			<cfinvokeargument name="SiteID" value="#config.SiteID#">
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
<cfelseif config.ShipBy EQ 6 >
	
	<cfquery name="getCustomShipping" datasource="#datasource#">
		SELECT 	ShipPrice
		FROM	ShippingMethods
		WHERE	SiteID = #config.SiteID#
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
			<cfinvokeargument name="SiteID" value="#config.SiteID#">
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
<cfelseif config.ShipBy EQ 7 >
	
	<!--- <cfquery name="getShippingCodes" datasource="#datasource#" >
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
		<cfquery name="getCustomShipping" datasource="#datasource#">
			SELECT 	ShipPrice
			FROM	ShippingMethods
			WHERE	SiteID = #config.SiteID#
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
			if ( session.CustomerArray[25] NEQ config.BaseCountry AND config.AcceptIntShipment EQ 1 )
				ShippingPrice = ShippingPrice + config.DefaultShipRateInt ;
			else
				ShippingPrice = ShippingPrice + config.DefaultShipRateDom ;
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
			<cfinvokeargument name="SiteID" value="#config.SiteID#">
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
	<cfset ShippingPrice = ShippingPrice + config.DefaultShipRateDom >
</cfif>
	
	<!--- CARTFUSION 4.6 - APPLY HANDLING FEE TO SHIPPING PRICE --->
	<!--- (previously only applied to automated realtime shipping) --->
    <cfscript>
        if ( config.HandlingType EQ 1 ) {
            ShippingPrice = NumberFormat(ShippingPrice + (ShippingPrice * (config.HandlingFee/100)),0.00) ;
        } else {
            ShippingPrice = NumberFormat(ShippingPrice + config.HandlingFee,0.00) ;
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
