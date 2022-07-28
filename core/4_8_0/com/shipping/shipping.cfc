<!--- *CARTFUSION 4.7 - SHIPPING CFC* --->
<cfcomponent displayname="Shipping Module">
	
	<cfscript>
		variables.dsn = "" ;
		variables.fedexAcNum   = "" ;
		variables.identifier   = "" ;
		variables.UPSAccessKey = "" ;
		variables.UPSUserID    = "" ;
		variables.UPSPassword  = "" ;
		variables.USPSUserID   = "" ;
		variables.USPSPassword = "" ;
		
		variables.UsedShipDiscounts = "" ;
		variables.ShippingPrice = 0 ;
		variables.TotalShippingPrice = 0 ;
		variables.IntShip = 0 ;
		variables.getShippingCos = StructNew() ;
		variables.getShippingCodes = StructNew() ;
		variables.config = StructNew() ;
	</cfscript>

	<cffunction name="init" returntype="Shipping" output="false">
		<cfargument name="dsn" required="yes">
		<cfargument name="SiteID" required="yes">
		
		<!--- Initialize variables --->
        <cfscript>
			variables.dsn = arguments.dsn ;
			variables.SiteID = arguments.SiteID ;
			// QUERY - GET SHIPPING ACCOUNT SETTINGS
			variables.getShippingCos = application.Queries.getShippingCos(SiteID=variables.SiteID) ;
            variables.fedexAcNum   = getShippingCos.FedexAccountNum ;
            variables.identifier   = getShippingCos.FedexIdentifier ;
            variables.UPSAccessKey = getShippingCos.UPSAccessKey ;
            variables.UPSUserID    = getShippingCos.UPSUserID ;
            variables.UPSPassword  = getShippingCos.UPSPassword ;
            variables.USPSUserID   = getShippingCos.USPSUserID ;
            variables.USPSPassword = getShippingCos.USPSPassword ;
            /* variables.UsedShipDiscounts = '' ;
            variables.ShippingPrice = 0 ;
            variables.TotalShippingPrice = 0 ;
            for (cpi = 1; cpi LT (Cart.Packages+1); cpi = cpi + 1){
            	'ShippingPrice#cpi#' = 0 ;
            }
            variables.IntShip = 0 ;
            // if ( session.CustomerArray[25] NEQ application.SiteConfig.data.BaseCountry ) // Verify if Shipping is International or not
                variables.IntShip = 1 ; */
        </cfscript>
        <!--- CARTFUSION 4.6 - SHIPPING CODES --->
        <cfquery name="getShippingCodes" datasource="#variables.dsn#" >
            SELECT	*
            FROM	ShippingCodes
        </cfquery>
        
		<cfreturn this />
	</cffunction>

    
    <cffunction name="getShipping" access="public" returntype="struct">
		<cfargument name="SessionID" required="yes">
        <cfargument name="UserID" required="yes">
        <cfargument name="SiteID" required="yes">
		<cfargument name="ShipBy" required="yes">
        <cfargument name="Weight" required="no">
        <cfargument name="DimLength" required="no">
        <cfargument name="DimWidth" required="no">
        <cfargument name="DimHeighth" required="no">
        <cfargument name="MethodsChosen" required="no" type="boolean" default="false">
        <cfargument name="MethodsAllowed" required="no">
        
		<cfscript>
			var data = QueryNew("MethodID,Method,MethodName,ShippingPrice,InsurancePrice,InsuranceAvailable,ShippingOption1,ShippingOption2,ShippingOption3,PackageRelation,PackagingType,AmountToAdd,UseDim,Oversize,Value,Weight",
								"Integer,VarChar,VarChar,Decimal,Decimal,Bit,VarChar,VarChar,VarChar,Integer,VarChar,Decimal,Bit,Bit,Decimal,Decimal") ;
			var data2 = StructNew() ;
			var stReturn = StructNew() ;
			var ShippingPrice = 0 ;
			var PackageWeight = 0 ;
			var TotalWeight = 0 ;
			var ShipCodeUsed = '' ;
			var getCart = StructNew() ;
			var getShippingDiscount = StructNew() ;
			var GlobalShipDiscount = 0 ;
			var UsedShipDiscounts = "" ;
			stReturn.bSuccess = True ;
			stReturn.message = "" ;
			stReturn.data = StructNew() ;
			stReturn.stError = StructNew() ;
		</cfscript>
		
		<!--- *** BEGIN: SHIPPING CALCULATIONS *** --->
        <cftry>   
            
            <cfscript>
				// CALCULATE TOTAL WEIGHT & TOTAL PRICE OF ORDER
				getCart = application.Cart.getCart(
							UserID = arguments.UserID,
							SiteID = arguments.SiteID,
							SessionID = arguments.SessionID
							) ;
				getPackages = application.Cart.getPackages(
							UserID = arguments.UserID,
							SiteID = arguments.SiteID,
							SessionID = arguments.SessionID,
							ShipBy = arguments.ShipBy
							) ;
				data2 = getPackages.data ;
				// LOOK FOR AN ALL-METHODS SHIPPING DISCOUNT
				getShippingDiscount = application.Cart.getShipDiscount(
							UserID = arguments.UserID,
							SiteID = arguments.SiteID,
							SessionID = arguments.SessionID
							) ;
				if ( getShippingDiscount.All EQ 1 ) {
                    GlobalShipDiscount = 1 ;
                    UsedShipDiscounts = ListAppend(UsedShipDiscounts,getShippingDiscount.ID) ;
				}
			</cfscript>
            
                
			<!--- RETIRED IN CARTFUSION 4.5
            <!--- (1) SHIPBY PRICE OR (2) SHIPBY WEIGHT --->	
                <cfif arguments.ShipBy EQ 1 OR arguments.ShipBy EQ 2 >
                    <cfscript>
                        if ( arguments.ShipBy EQ 1 ) {
                            TableToSelect = 'ShipPrice' ;
                            ThisShipMethod = 'Price' ;
                        } else {
                            TableToSelect = 'ShipWeight' ;
                            ThisShipMethod = 'Weight' ;
                        }
                    </cfscript>
                    <cfquery name="getShipPrice" datasource="#variables.dsn#">				
                        SELECT	InternationalRate, DomesticRate
                        FROM	#TableToSelect#
                        WHERE	Start	<	#Cart.CartTotal#
                        AND		Finish	>=	#Cart.CartTotal#
                        AND		SiteID = #arguments.SiteID#
                    </cfquery>
                        
                    <cfscript>
                        if (getShipPrice.RecordCount NEQ 0)
                        {
                            // Apply International Rate
                            if (IntShip EQ 1) {
                                if (getShipPrice.InternationalRate NEQ '')
                                    ShippingPrice = ShippingPrice + getShipPrice.InternationalRate ;
                                else
                                    ShippingPrice = ShippingPrice + application.SiteConfig.data.DefaultShipRateInt ;
                            } else {
                                if (getShipPrice.DomesticRate NEQ '')
                                    ShippingPrice = ShippingPrice + getShipPrice.DomesticRate ;
                                else
                                    ShippingPrice = ShippingPrice + application.SiteConfig.data.DefaultShipRateDom ;
                            }
                        } else if (IntShip EQ 1) {
                            ShippingPrice = ShippingPrice + application.SiteConfig.data.DefaultShipRateInt ;
                        } else {
                            ShippingPrice = ShippingPrice + application.SiteConfig.data.DefaultShipRateDom ;
                        }
                        // SHIPPING DISCOUNT
                        // NO AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS
                        if ( GlobalShipDiscount EQ 0 ) {
                            // INVOKE INSTANCE OF OBJECT - GET PRODUCT PRICE, INCLUDING ANY DISCOUNTS
                            ShippingDiscount = application.Cart.getShipDiscount(UserID=arguments.UserID,SiteID=arguments.SiteID,SessionID=arguments.SessionID,ShippingMethod=ThisShippingMethod) ;
                            if ( ShippingDiscount.ShipMethod EQ ThisShippingMethod )
                            {
                                UsedShipDiscounts = ListAppend(UsedShipDiscounts,ShippingDiscount.ID) ;
                                if ( ShippingDiscount.Type EQ 1 ) {
                                    ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
                                } else {
                                    ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
                                }
                            }
                        // THERE IS AN AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS
                        } else {
                            if ( ShippingDiscount.Type EQ 1 ) {
                                ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
                            } else {
                                ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
                            }
                        }
                    </cfscript>
                --->
            
            
            <!--- SHIPBY AUTOMATED --->
            <cfif arguments.ShipBy EQ 3 >
            
                <cfloop query="getPackages.data">
                    <cfscript>
						// Add Product-Specific Shipping & Handling Amounts
						ShippingPrice = ShippingPrice + getPackages.data.AmountToAdd ;
					</cfscript>
                    
					<!--- 1 --->
                    <!--- *** IF SHIPPING METHOD ALREADY CHOSEN AND PASSED TO FUNCTION (RETURN 1-ROW QUERY) *** --->
                    <cfif arguments.MethodsChosen EQ true >
                        <cfscript>
                            ShippingMethod = TRIM(getPackages.data.Method) ;
                        </cfscript>
                    
                        <cfif ShippingMethod NEQ 'Default' AND ShippingMethod NEQ '' >
                        
                            <!--- OVERWEIGHT --->
                            <cfif ShippingMethod EQ 'OverWeight'>
                                <cfset ShippingPrice = ShippingPrice + application.SiteConfig.data.DefaultShipRateOver >
                                
                            
                            <!--- UPS --->	
                            <cfelseif ShippingMethod GTE '1' AND ShippingMethod LTE '65'>
                                
                                <cf_TagUPS
                                    function="rateRequest"
                                    UPSAccessKey="#UPSAccessKey#"
                                    UPSUserID="#UPSUserID#"
                                    UPSPassword="#UPSPassword#"
                                    PickUpType="03"
                                    ServiceType="#ShippingMethod#"
                                    ShipperCity="#application.SiteConfig.data.CompanyCity#"
                                    ShipperState="#application.SiteConfig.data.CompanyState#"
                                    ShipperZip="#application.SiteConfig.data.CompanyZip#"
                                    ShipperCountry="#application.SiteConfig.data.CompanyCountry#"
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
                                                if ( session.CustomerArray[25] NEQ application.SiteConfig.data.BaseCountry )
                                                    TotalCharges = application.SiteConfig.data.DefaultShipRateInt;
                                                else
                                                    TotalCharges = application.SiteConfig.data.DefaultShipRateDom;
                                            }
                                            ShippingPrice = ShippingPrice + TotalCharges ;
                                            // SHIPPING DISCOUNT
                                            // NO AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS
                                            if ( GlobalShipDiscount EQ 0 ) {
                                                // INVOKE INSTANCE OF OBJECT - GET PRODUCT PRICE, INCLUDING ANY DISCOUNTS
                                                ShippingDiscount = application.Cart.getShipDiscount(UserID=arguments.UserID,SiteID=arguments.SiteID,SessionID=arguments.SessionID,ShippingMethod=ShippingMethod) ;
                                                if ( ShippingDiscount.ShipMethod EQ ShippingMethod )
                                                {
                                                    UsedShipDiscounts = ListAppend(UsedShipDiscounts,ShippingDiscount.ID) ;
                                                    if ( ShippingDiscount.Type EQ 1 ) {
                                                        ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
                                                    } else {
                                                        ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
                                                    }
                                                }
                                            // THERE IS AN AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS
                                            } else {
                                                if ( ShippingDiscount.Type EQ 1 ) {
                                                    ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
                                                } else {
                                                    ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
                                                }
                                            }
                                        </cfscript>
                                    </cfoutput>
                                <cfelse>
                                    <cfscript>
                                        if ( session.CustomerArray[25] NEQ application.SiteConfig.data.BaseCountry )
                                            ShippingPrice = ShippingPrice + application.SiteConfig.data.DefaultShipRateInt;
                                        else
                                            ShippingPrice = ShippingPrice + application.SiteConfig.data.DefaultShipRateDom;
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
                                
                                <cfif session.CustomerArray[25] NEQ application.SiteConfig.data.BaseCountry >
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
                                        ShipFromZip5="#application.SiteConfig.data.DefaultOriginZipCode#"
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
                                                FreightCharges = application.SiteConfig.data.DefaultShipRateDom;
                                            ShippingPrice = ShippingPrice + FreightCharges ;
                                            // SHIPPING DISCOUNT
                                            // NO AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS
                                            if ( GlobalShipDiscount EQ 0 ) {
                                                // INVOKE INSTANCE OF OBJECT - GET PRODUCT PRICE, INCLUDING ANY DISCOUNTS
                                                ShippingDiscount = application.Cart.getShipDiscount(UserID=arguments.UserID,SiteID=arguments.SiteID,SessionID=arguments.SessionID,ShippingMethod=ShippingMethod) ;
                                                if ( ShippingDiscount.ShipMethod EQ ShippingMethod )
                                                {
                                                    UsedShipDiscounts = ListAppend(UsedShipDiscounts,ShippingDiscount.ID) ;
                                                    if ( ShippingDiscount.Type EQ 1 ) {
                                                        ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
                                                    } else {
                                                        ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
                                                    }
                                                }
                                            // THERE IS AN AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS
                                            } else {
                                                if ( ShippingDiscount.Type EQ 1 ) {
                                                    ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
                                                } else {
                                                    ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
                                                }
                                            }
                                        </cfscript>
                                        
                                    </cfoutput>
                                <cfelseif IsDefined("USPSIntlRateServicesQuery") AND isDefined('USPSError') AND USPSError EQ 0 >
                                    <cfoutput query="USPSIntlRateServicesQuery">
                                        <cfscript>
                                            if ( FreightCharges EQ 0 )
                                                FreightCharges = application.SiteConfig.data.DefaultShipRateInt;
                                            ShippingPrice = ShippingPrice + FreightCharges ;
                                            // SHIPPING DISCOUNT
                                            // NO AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS
                                            if ( GlobalShipDiscount EQ 0 ) {
                                                // INVOKE INSTANCE OF OBJECT - GET PRODUCT PRICE, INCLUDING ANY DISCOUNTS
                                                ShippingDiscount = application.Cart.getShipDiscount(UserID=arguments.UserID,SiteID=arguments.SiteID,SessionID=arguments.SessionID,ShippingMethod=ShippingMethod) ;
                                                if ( ShippingDiscount.ShipMethod EQ ShippingMethod )
                                                {
                                                    UsedShipDiscounts = ListAppend(UsedShipDiscounts,ShippingDiscount.ID) ;
                                                    if ( ShippingDiscount.Type EQ 1 ) {
                                                        ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
                                                    } else {
                                                        ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
                                                    }
                                                }
                                            // THERE IS AN AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS
                                            } else {
                                                if ( ShippingDiscount.Type EQ 1 ) {
                                                    ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
                                                } else {
                                                    ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
                                                }
                                            }
                                        </cfscript>
                                        
                                    </cfoutput>
                                <cfelse>
                                    <cfscript>
                                        if ( session.CustomerArray[25] NEQ application.SiteConfig.data.BaseCountry )
                                            ShippingPrice = ShippingPrice + application.SiteConfig.data.DefaultShipRateInt;
                                        else
                                            ShippingPrice = ShippingPrice + application.SiteConfig.data.DefaultShipRateDom;
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
                                    ShipperState="#application.SiteConfig.data.CompanyState#"
                                    ShipperZip="#application.SiteConfig.data.DefaultOriginZipCode#"
                                    ShipperCountry="#application.SiteConfig.data.BaseCountry#"
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
                                                if ( session.CustomerArray[25] NEQ application.SiteConfig.data.BaseCountry )
                                                    ShippingPrice = ShippingPrice + application.SiteConfig.data.DefaultShipRateInt;
                                                else
                                                    ShippingPrice = ShippingPrice + application.SiteConfig.data.DefaultShipRateDom;
                                            }
                                            // SHIPPING DISCOUNT
                                            // NO AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS
                                            if ( GlobalShipDiscount EQ 0 ) {
                                                // INVOKE INSTANCE OF OBJECT - GET PRODUCT PRICE, INCLUDING ANY DISCOUNTS
                                                ShippingDiscount = application.Cart.getShipDiscount(UserID=arguments.UserID,SiteID=arguments.SiteID,SessionID=arguments.SessionID,ShippingMethod=ShippingMethod) ;
                                                if ( ShippingDiscount.ShipMethod EQ ShippingMethod )
                                                {
                                                    UsedShipDiscounts = ListAppend(UsedShipDiscounts,ShippingDiscount.ID) ;
                                                    if ( ShippingDiscount.Type EQ 1 ) {
                                                        ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
                                                    } else {
                                                        ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
                                                    }
                                                }
                                            // THERE IS AN AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS
                                            } else {
                                                if ( ShippingDiscount.Type EQ 1 ) {
                                                    ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
                                                } else {
                                                    ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
                                                }
                                            }
                                        </cfscript>					
                                        
                                        <!--- <b style="color:green">#ShippingPrice#</b><br> --->
                                        
                                    </cfoutput>
                                <cfelse>
                                    <cfscript>
                                        if ( session.CustomerArray[25] NEQ application.SiteConfig.data.BaseCountry )
                                            ShippingPrice = ShippingPrice + application.SiteConfig.data.DefaultShipRateInt;
                                        else
                                            ShippingPrice = ShippingPrice + application.SiteConfig.data.DefaultShipRateDom;
                                    </cfscript>
                                </cfif>
                            
                            
                            <!--- INTERNATIONAL: AND NO OTHER SHIPPING METHOD SELECTED --->
                            <cfelseif session.CustomerArray[25] NEQ application.SiteConfig.data.BaseCountry >
                                <cfset ShippingPrice = application.SiteConfig.data.DefaultShipRateInt >	
                    
                            </cfif>
                            <!--- END: SHIPPINGMETHOD --->
                            
                        <!--- INTERNATIONAL --->
                        <cfelseif session.CustomerArray[25] NEQ application.SiteConfig.data.BaseCountry >
                            <cfset ShippingPrice = ShippingPrice + application.SiteConfig.data.DefaultShipRateInt >
                        <!--- DOMESTIC --->
                        <cfelse>
                            <cfset ShippingPrice = ShippingPrice + application.SiteConfig.data.DefaultShipRateDom >
                        </cfif>
                    
                    <!--- 2+ --->
                    <!--- *** SHIPPING METHOD NOT CHOSEN, GET ALL AVAILABLE SHIPPING SERVICES (RETURN MULTI-ROW QUERY) *** --->
                    <cfelse>
                        <cfscript>
                            
                        </cfscript>
                    </cfif>
            		
                    <cfscript>
						// TEMP - needs to be queried from table ShippingMethods
						MethodID = CurrentRow ;
						Method = 'Method#CurrentRow#' ;
						MethodName = 'MethodName#CurrentRow#' ;
						InsurancePrice = 0.00 ;
						InsuranceAvailable = true ;
						ShippingOption1 = "SAT" ;
						ShippingOption2 = "COD" ;
						ShippingOption3 = "" ;
						
						// Add shipping method option to return query
						QueryAddRow(data,1) ;
						QuerySetCell(data, "MethodID", MethodID, CurrentRow) ;
						QuerySetCell(data, "Method", Method, CurrentRow) ;
						QuerySetCell(data, "MethodName", MethodName, CurrentRow) ;
						QuerySetCell(data, "ShippingPrice", ShippingPrice, CurrentRow) ;
						QuerySetCell(data, "InsurancePrice", InsurancePrice, CurrentRow) ;
						QuerySetCell(data, "InsuranceAvailable", InsuranceAvailable, CurrentRow) ;
						QuerySetCell(data, "ShippingOption1", ShippingOption1, CurrentRow) ;
						QuerySetCell(data, "ShippingOption2", ShippingOption2, CurrentRow) ;
						QuerySetCell(data, "ShippingOption3", ShippingOption3, CurrentRow) ;
						QuerySetCell(data, "PackageRelation", CurrentRow, CurrentRow) ;
						QuerySetCell(data, "PackagingType", PackagingType, CurrentRow) ;
						QuerySetCell(data, "AmountToAdd", AmountToAdd, CurrentRow) ;
						QuerySetCell(data, "UseDim", UseDim, CurrentRow) ;
						QuerySetCell(data, "Oversize", Oversize, CurrentRow) ;
						QuerySetCell(data, "Value", Value, CurrentRow) ;
						QuerySetCell(data, "Weight", Weight, CurrentRow) ;

						TotalShippingPrice = NumberFormat(TotalShippingPrice + ShippingPrice,0.00) ;
						ShippingPrice = 0 ;
					</cfscript>
					
					<!--- <cfset ShippingPrice = TotalShippingPrice > --->
                    
                </cfloop>
            
            <!--- SHIPBY REGION/GEOGRAPHY --->	
            <cfelseif arguments.ShipBy EQ 4 >
                
                <cfscript>
                    if ( session.CustomerArray[25] EQ application.SiteConfig.data.BaseCountry ) {
                        TableToSelect = 'States' ;
                        WhereClause = 'StateCode = "' & session.CustomerArray[23] & '"' ;
                    } else {
                        TableToSelect = 'Countries' ;
                        WhereClause = 'Country = "' & session.CustomerArray[25] & '"' ;
                    }
                </cfscript>
                <cfquery name="getRate" datasource="#variables.dsn#">
                    SELECT 	*
                    FROM 	#TableToSelect#
                    WHERE 	#WhereClause#
                </cfquery>
                <cfscript>
                    if ( GetRate.S_Rate EQ '' OR GetRate.S_Rate LT 0 )
                        ShippingPrice = ShippingPrice + application.SiteConfig.data.DefaultShipRateDom ;
                    else
                        ShippingPrice = ShippingPrice + GetRate.S_Rate ;
                    // SHIPPING DISCOUNT
                    // NO AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS
                    if ( GlobalShipDiscount EQ 0 ) {
                        // INVOKE INSTANCE OF OBJECT - GET PRODUCT PRICE, INCLUDING ANY DISCOUNTS
                        ShippingDiscount = application.Cart.getShipDiscount(UserID=arguments.UserID,SiteID=arguments.SiteID,SessionID=arguments.SessionID,ShippingMethod='Location') ;
                        if ( ShippingDiscount.ShipMethod EQ 'Location' )
                        {
                            UsedShipDiscounts = ListAppend(UsedShipDiscounts,ShippingDiscount.ID) ;
                            if ( ShippingDiscount.Type EQ 1 ) {
                                ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
                            } else {
                                ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
                            }
                        }
                    // THERE IS AN AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS
                    } else {
                        if ( ShippingDiscount.Type EQ 1 ) {
                            ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
                        } else {
                            ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
                        }
                    }
                </cfscript>
            
            
            <!--- SHIPBY CUSTOM SHIPPING OPTIONS: WEIGHT --->	
            <cfelseif arguments.ShipBy EQ 5 >
                
                <cfquery name="getCustomShipping" datasource="#variables.dsn#">
                    SELECT 	ShipPrice
                    FROM	ShippingMethods
                    WHERE	SiteID = #arguments.SiteID#
                    AND		ShippingCode = '#ShippingMethod#'
                </cfquery>
                
                <cfscript>
                    if ( getCustomShipping.RecordCount NEQ 0 AND getCustomShipping.ShipPrice NEQ '' )
                        ShippingPrice = NumberFormat(ShippingPrice + getCustomShipping.ShipPrice,0.00) ;
                    // SHIPPING DISCOUNT
                    // NO AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS
                    if ( GlobalShipDiscount EQ 0 ) {
                        // INVOKE INSTANCE OF OBJECT - GET PRODUCT PRICE, INCLUDING ANY DISCOUNTS
                        ShippingDiscount = application.Cart.getShipDiscount(UserID=arguments.UserID,SiteID=arguments.SiteID,SessionID=arguments.SessionID,ShippingMethod='Weight') ;
                        if ( ShippingDiscount.ShipMethod EQ 'Weight' )
                        {
                            UsedShipDiscounts = ListAppend(UsedShipDiscounts,ShippingDiscount.ID) ;
                            if ( ShippingDiscount.Type EQ 1 ) {
                                ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
                            } else {
                                ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
                            }
                        }
                    // THERE IS AN AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS
                    } else {
                        if ( ShippingDiscount.Type EQ 1 ) {
                            ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
                        } else {
                            ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
                        }
                    }
                </cfscript>
                
                
            <!--- SHIPBY CUSTOM SHIPPING OPTIONS: PRICE --->	
            <cfelseif arguments.ShipBy EQ 6 >
                
                <cfquery name="getCustomShipping" datasource="#variables.dsn#">
                    SELECT 	ShipPrice
                    FROM	ShippingMethods
                    WHERE	SiteID = #arguments.SiteID#
                    AND		ShippingCode = '#ShippingMethod#'
                </cfquery>
                
                <cfscript>
                    if ( getCustomShipping.RecordCount NEQ 0 AND getCustomShipping.ShipPrice NEQ '' )
                        ShippingPrice = NumberFormat(ShippingPrice + getCustomShipping.ShipPrice,0.00) ;
                    // SHIPPING DISCOUNT
                    // NO AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS
                    if ( GlobalShipDiscount EQ 0 ) {
                        // INVOKE INSTANCE OF OBJECT - GET PRODUCT PRICE, INCLUDING ANY DISCOUNTS
                        ShippingDiscount = application.Cart.getShipDiscount(UserID=arguments.UserID,SiteID=arguments.SiteID,SessionID=arguments.SessionID,ShippingMethod='Price') ;
                        if ( ShippingDiscount.ShipMethod EQ 'Price' )
                        {
                            UsedShipDiscounts = ListAppend(UsedShipDiscounts,ShippingDiscount.ID) ;
                            if ( ShippingDiscount.Type EQ 1 ) {
                                ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
                            } else {
                                ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
                            }
                        }
                    // THERE IS AN AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS
                    } else {
                        if ( ShippingDiscount.Type EQ 1 ) {
                            ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
                        } else {
                            ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
                        }
                    }
                </cfscript>
            
            
            <!--- SHIPBY RETAIL PRO --->
            <cfelseif arguments.ShipBy EQ 7 >
                
                <!--- <cfquery name="getShippingCodes" datasource="#variables.dsn#" >
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
                    <cfquery name="getCustomShipping" datasource="#variables.dsn#">
                        SELECT 	ShipPrice
                        FROM	ShippingMethods
                        WHERE	SiteID = #arguments.SiteID#
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
                        if ( session.CustomerArray[25] NEQ application.SiteConfig.data.BaseCountry AND application.SiteConfig.data.AcceptIntShipment EQ 1 )
                            ShippingPrice = ShippingPrice + application.SiteConfig.data.DefaultShipRateInt ;
                        else
                            ShippingPrice = ShippingPrice + application.SiteConfig.data.DefaultShipRateDom ;
                    </cfscript>
                </cfif>
                <cfscript>
                    // SHIPPING DISCOUNT
                    // NO AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS
                    if ( GlobalShipDiscount EQ 0 ) {
                        // INVOKE INSTANCE OF OBJECT - GET PRODUCT PRICE, INCLUDING ANY DISCOUNTS
                        ShippingDiscount = application.Cart.getShipDiscount(UserID=arguments.UserID,SiteID=arguments.SiteID,SessionID=arguments.SessionID,ShippingMethod='Weight') ;
                        if ( ShippingDiscount.ShipMethod EQ 'Weight' )
                        {
                            UsedShipDiscounts = ListAppend(UsedShipDiscounts,ShippingDiscount.ID) ;
                            if ( ShippingDiscount.Type EQ 1 ) {
                                ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
                            } else {
                                ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
                            }
                        }
                    // THERE IS AN AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS
                    } else {
                        if ( ShippingDiscount.Type EQ 1 ) {
                            ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
                        } else {
                            ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
                        }
                    }
                </cfscript>
                    
            <!--- FALLBACK --->
            <cfelse>
                <cfset ShippingPrice = ShippingPrice + application.SiteConfig.data.DefaultShipRateDom >
            </cfif>
            
            <!--- CARTFUSION 4.6 - APPLY HANDLING FEE TO SHIPPING PRICE --->
            <!--- (previously only applied to automated realtime shipping) --->
            <cfscript>
                if ( application.SiteConfig.data.HandlingType EQ 1 ) {
                    ShippingPrice = NumberFormat(ShippingPrice + (ShippingPrice * (application.SiteConfig.data.HandlingFee/100)),0.00) ;
                } else {
                    ShippingPrice = NumberFormat(ShippingPrice + application.SiteConfig.data.HandlingFee,0.00) ;
                }
            </cfscript>
            
            <!--- <cfoutput><b style="color:maroon">#ShippingPrice#</b><br></cfoutput> --->
                
            
            <!--- CARTFUSION 4.5 - MULTIPLE SHIPPING ADDRESSES --->
            <!--- *** END: SHIPPING CALCULATIONS *** --->
            
            
            
            
            <cfscript>
				if ( NOT data.RecordCount )
				{
					stReturn.bSuccess = False ;
					stReturn.data = data ;
					stReturn.Message = "No shipping rate information could be retrieved." ;
				}
				else
				{
					stReturn.bSuccess = True ;
					stReturn.data = data ;
					stReturn.Message = "Success" ;
				}
			</cfscript>
			
			<cfcatch>
				<cfscript>
					stReturn.bSuccess = False ;
					stReturn.Message = cfcatch.message & "<br><br>" & cfcatch.detail ;
					stReturn.stError = cfcatch ;
				</cfscript>
			</cfcatch>
        </cftry>


		<cfreturn stReturn >
	</cffunction>
        
	<cffunction name="CalculateShipping" access="public" returntype="struct">
		<cfargument name="SessionID" required="yes">
        <cfargument name="UserID" required="yes">
        <cfargument name="SiteID" required="yes">
		<cfargument name="ShipBy" required="yes">
        <cfargument name="Weight" required="no">
        <cfargument name="DimLength" required="no">
        <cfargument name="DimWidth" required="no">
        <cfargument name="DimHeighth" required="no">
        <!--- FOR SINGLE RATE RETURN (FLOAT) --->
        <cfargument name="Method" required="no">
        <!--- FOR MULTIPLE RATE RETURN (QUERY) --->
        <cfargument name="MethodsAllowed" required="no">
        
		<cfscript>
			var data = StructNew() ;
			var stReturn = StructNew() ;
			var ShippingPrice = 0 ;
			var PackageWeight = 0 ;
			var TotalWeight = 0 ;
			var ShipCodeUsed = '' ;
			var getCart = StructNew() ;
			var getShippingDiscount = StructNew() ;
			var GlobalShipDiscount = 0 ;
			var UsedShipDiscounts = "" ;
			stReturn.bSuccess = True ;
			stReturn.message = "" ;
			stReturn.data = StructNew() ;
			stReturn.stError = StructNew() ;
		</cfscript>
		
		<!--- *** BEGIN: SHIPPING CALCULATIONS *** --->
        <cftry>   
            
            <cfscript>
				// CALCULATE TOTAL WEIGHT & TOTAL PRICE OF ORDER
				getCart = application.Cart.getCartItems(UserID=arguments.UserID,SiteID=arguments.SiteID,SessionID=arguments.SessionID) ;
				// LOOK FOR AN ALL-METHODS SHIPPING DISCOUNT
				getShippingDiscount = application.Cart.getShipDiscount(UserID=arguments.UserID,SiteID=arguments.SiteID,SessionID=arguments.SessionID) ;
				if ( getShippingDiscount.All EQ 1 ) {
                    GlobalShipDiscount = 1 ;
                    UsedShipDiscounts = ListAppend(UsedShipDiscounts,ShippingDiscount.ID) ;
				}
			</cfscript>
            
            <!--- CARTFUSION 4.5 - MULTIPLE SHIPPING ADDRESSES --->
            <cfquery name="getDistinctAddresses" dbtype="query">
                SELECT 	DISTINCT ShippingID
                FROM	getCart.data
            </cfquery>
            <cfscript>
                // if ( getDistinctAddresses.RecordCount GT 1 ) {
                    Cart.Packages = getDistinctAddresses.RecordCount ;
                // }
            </cfscript>
        
            <!--- CARTFUSION 4.5 - MULTIPLE SHIPPING ADDRESSES --->	
            <cfloop query="getDistinctAddresses"><!--- from="1" to="#Cart.Packages#" index="cpi" --->
                <cfquery name="getThisPackagesItems" dbtype="query">
                    SELECT	*
                    FROM	getCart.data
                    WHERE	ShippingID = #getDistinctAddresses.ShippingID#
                </cfquery>
				<!--- CARTFUSION 4.6 - PRODUCT-SPECIFIC SHIPPING PRICE ADJUSTMENTS --->
                <cfloop query="getThisPackagesItems">
                    <cfscript>
                        ShippingPrice = ShippingPrice + NumberFormat(fldShipAmount,0.00) + NumberFormat(fldHandAmount,0.00) ;
                        PackageWeight = PackageWeight + (NumberFormat(fldShipWeight,0.000) * Qty) ;
						TotalWeight = TotalWeight + (NumberFormat(fldShipWeight,0.000) * Qty) ;
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
                    </cfif> --->
                    <!--- <cfoutput><b style="color:green">#ShippingPrice#</b><br></cfoutput> --->
                </cfloop>
                    
            <!--- RETIRED IN CARTFUSION 4.5
			<!--- (1) SHIPBY PRICE OR (2) SHIPBY WEIGHT --->	
            <cfif arguments.ShipBy EQ 1 OR arguments.ShipBy EQ 2 >
            	<cfscript>
					if ( arguments.ShipBy EQ 1 ) {
						TableToSelect = 'ShipPrice' ;
						ThisShipMethod = 'Price' ;
					} else {
						TableToSelect = 'ShipWeight' ;
						ThisShipMethod = 'Weight' ;
					}
				</cfscript>
                <cfquery name="getShipPrice" datasource="#variables.dsn#">				
                    SELECT	InternationalRate, DomesticRate
                    FROM	#TableToSelect#
                    WHERE	Start	<	#Cart.CartTotal#
                    AND		Finish	>=	#Cart.CartTotal#
                    AND		SiteID = #arguments.SiteID#
                </cfquery>
                    
				<cfscript>
                    if (getShipPrice.RecordCount NEQ 0)
                    {
						// Apply International Rate
                        if (IntShip EQ 1) {
                            if (getShipPrice.InternationalRate NEQ '')
                                ShippingPrice = ShippingPrice + getShipPrice.InternationalRate ;
                            else
                                ShippingPrice = ShippingPrice + application.SiteConfig.data.DefaultShipRateInt ;
                        } else {
                            if (getShipPrice.DomesticRate NEQ '')
                                ShippingPrice = ShippingPrice + getShipPrice.DomesticRate ;
                            else
                                ShippingPrice = ShippingPrice + application.SiteConfig.data.DefaultShipRateDom ;
                        }
                    } else if (IntShip EQ 1) {
                        ShippingPrice = ShippingPrice + application.SiteConfig.data.DefaultShipRateInt ;
                    } else {
                        ShippingPrice = ShippingPrice + application.SiteConfig.data.DefaultShipRateDom ;
                	}
                	// SHIPPING DISCOUNT
					// NO AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS
					if ( GlobalShipDiscount EQ 0 ) {
						// INVOKE INSTANCE OF OBJECT - GET PRODUCT PRICE, INCLUDING ANY DISCOUNTS
						ShippingDiscount = application.Cart.getShipDiscount(UserID=arguments.UserID,SiteID=arguments.SiteID,SessionID=arguments.SessionID,ShippingMethod=ThisShippingMethod) ;
                        if ( ShippingDiscount.ShipMethod EQ ThisShippingMethod )
                        {
                            UsedShipDiscounts = ListAppend(UsedShipDiscounts,ShippingDiscount.ID) ;
                            if ( ShippingDiscount.Type EQ 1 ) {
								ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
							} else {
								ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
							}
                        }
					// THERE IS AN AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS
					} else {
                        if ( ShippingDiscount.Type EQ 1 ) {
                            ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
                        } else {
                            ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
						}
					}
                </cfscript>
            --->
            
            
            <!--- SHIPBY AUTOMATED --->
            <cfif arguments.ShipBy EQ 3 >
            
            	<!--- IF SHIPPING METHOD ALREADY CHOSEN AND PASSED TO FUNCTION (RETURN 1-ROW QUERY) --->
                <cfif StructKeyExists(arguments,'Method') AND TRIM(arguments.Method) NEQ '' >
                	<cfset ShippingMethod = TRIM(arguments.Method) >
					<!--- <cfparam name="ShippingMethod" default=""> --->
                
					<cfif ShippingMethod NEQ 'Default' AND ShippingMethod NEQ '' >
                    
                        <!--- OVERWEIGHT --->
                        <cfif ShippingMethod EQ 'OverWeight'>
                            <cfset ShippingPrice = ShippingPrice + application.SiteConfig.data.DefaultShipRateOver >
                            
                        
                        <!--- UPS --->	
                        <cfelseif ShippingMethod GTE '1' AND ShippingMethod LTE '65'>
                            
                            <cf_TagUPS
                                function="rateRequest"
                                UPSAccessKey="#UPSAccessKey#"
                                UPSUserID="#UPSUserID#"
                                UPSPassword="#UPSPassword#"
                                PickUpType="03"
                                ServiceType="#ShippingMethod#"
                                ShipperCity="#application.SiteConfig.data.CompanyCity#"
                                ShipperState="#application.SiteConfig.data.CompanyState#"
                                ShipperZip="#application.SiteConfig.data.CompanyZip#"
                                ShipperCountry="#application.SiteConfig.data.CompanyCountry#"
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
                                            if ( session.CustomerArray[25] NEQ application.SiteConfig.data.BaseCountry )
                                                TotalCharges = application.SiteConfig.data.DefaultShipRateInt;
                                            else
                                                TotalCharges = application.SiteConfig.data.DefaultShipRateDom;
                                        }
                                        ShippingPrice = ShippingPrice + TotalCharges ;
                                        // SHIPPING DISCOUNT
                                        // NO AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS
                                        if ( GlobalShipDiscount EQ 0 ) {
                                            // INVOKE INSTANCE OF OBJECT - GET PRODUCT PRICE, INCLUDING ANY DISCOUNTS
                                            ShippingDiscount = application.Cart.getShipDiscount(UserID=arguments.UserID,SiteID=arguments.SiteID,SessionID=arguments.SessionID,ShippingMethod=ShippingMethod) ;
                                            if ( ShippingDiscount.ShipMethod EQ ShippingMethod )
                                            {
                                                UsedShipDiscounts = ListAppend(UsedShipDiscounts,ShippingDiscount.ID) ;
                                                if ( ShippingDiscount.Type EQ 1 ) {
                                                    ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
                                                } else {
                                                    ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
                                                }
                                            }
                                        // THERE IS AN AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS
                                        } else {
                                            if ( ShippingDiscount.Type EQ 1 ) {
                                                ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
                                            } else {
                                                ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
                                            }
                                        }
                                    </cfscript>
                                </cfoutput>
                            <cfelse>
                                <cfscript>
                                    if ( session.CustomerArray[25] NEQ application.SiteConfig.data.BaseCountry )
                                        ShippingPrice = ShippingPrice + application.SiteConfig.data.DefaultShipRateInt;
                                    else
                                        ShippingPrice = ShippingPrice + application.SiteConfig.data.DefaultShipRateDom;
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
                            
                            <cfif session.CustomerArray[25] NEQ application.SiteConfig.data.BaseCountry >
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
                                    ShipFromZip5="#application.SiteConfig.data.DefaultOriginZipCode#"
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
                                            FreightCharges = application.SiteConfig.data.DefaultShipRateDom;
                                        ShippingPrice = ShippingPrice + FreightCharges ;
                                        // SHIPPING DISCOUNT
                                        // NO AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS
                                        if ( GlobalShipDiscount EQ 0 ) {
                                            // INVOKE INSTANCE OF OBJECT - GET PRODUCT PRICE, INCLUDING ANY DISCOUNTS
                                            ShippingDiscount = application.Cart.getShipDiscount(UserID=arguments.UserID,SiteID=arguments.SiteID,SessionID=arguments.SessionID,ShippingMethod=ShippingMethod) ;
                                            if ( ShippingDiscount.ShipMethod EQ ShippingMethod )
                                            {
                                                UsedShipDiscounts = ListAppend(UsedShipDiscounts,ShippingDiscount.ID) ;
                                                if ( ShippingDiscount.Type EQ 1 ) {
                                                    ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
                                                } else {
                                                    ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
                                                }
                                            }
                                        // THERE IS AN AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS
                                        } else {
                                            if ( ShippingDiscount.Type EQ 1 ) {
                                                ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
                                            } else {
                                                ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
                                            }
                                        }
                                    </cfscript>
                                    
                                </cfoutput>
                            <cfelseif IsDefined("USPSIntlRateServicesQuery") AND isDefined('USPSError') AND USPSError EQ 0 >
                                <cfoutput query="USPSIntlRateServicesQuery">
                                    <cfscript>
                                        if ( FreightCharges EQ 0 )
                                            FreightCharges = application.SiteConfig.data.DefaultShipRateInt;
                                        ShippingPrice = ShippingPrice + FreightCharges ;
                                        // SHIPPING DISCOUNT
                                        // NO AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS
                                        if ( GlobalShipDiscount EQ 0 ) {
                                            // INVOKE INSTANCE OF OBJECT - GET PRODUCT PRICE, INCLUDING ANY DISCOUNTS
                                            ShippingDiscount = application.Cart.getShipDiscount(UserID=arguments.UserID,SiteID=arguments.SiteID,SessionID=arguments.SessionID,ShippingMethod=ShippingMethod) ;
                                            if ( ShippingDiscount.ShipMethod EQ ShippingMethod )
                                            {
                                                UsedShipDiscounts = ListAppend(UsedShipDiscounts,ShippingDiscount.ID) ;
                                                if ( ShippingDiscount.Type EQ 1 ) {
                                                    ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
                                                } else {
                                                    ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
                                                }
                                            }
                                        // THERE IS AN AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS
                                        } else {
                                            if ( ShippingDiscount.Type EQ 1 ) {
                                                ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
                                            } else {
                                                ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
                                            }
                                        }
                                    </cfscript>
                                    
                                </cfoutput>
                            <cfelse>
                                <cfscript>
                                    if ( session.CustomerArray[25] NEQ application.SiteConfig.data.BaseCountry )
                                        ShippingPrice = ShippingPrice + application.SiteConfig.data.DefaultShipRateInt;
                                    else
                                        ShippingPrice = ShippingPrice + application.SiteConfig.data.DefaultShipRateDom;
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
                                ShipperState="#application.SiteConfig.data.CompanyState#"
                                ShipperZip="#application.SiteConfig.data.DefaultOriginZipCode#"
                                ShipperCountry="#application.SiteConfig.data.BaseCountry#"
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
                                            if ( session.CustomerArray[25] NEQ application.SiteConfig.data.BaseCountry )
                                                ShippingPrice = ShippingPrice + application.SiteConfig.data.DefaultShipRateInt;
                                            else
                                                ShippingPrice = ShippingPrice + application.SiteConfig.data.DefaultShipRateDom;
                                        }
                                        // SHIPPING DISCOUNT
                                        // NO AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS
                                        if ( GlobalShipDiscount EQ 0 ) {
                                            // INVOKE INSTANCE OF OBJECT - GET PRODUCT PRICE, INCLUDING ANY DISCOUNTS
                                            ShippingDiscount = application.Cart.getShipDiscount(UserID=arguments.UserID,SiteID=arguments.SiteID,SessionID=arguments.SessionID,ShippingMethod=ShippingMethod) ;
                                            if ( ShippingDiscount.ShipMethod EQ ShippingMethod )
                                            {
                                                UsedShipDiscounts = ListAppend(UsedShipDiscounts,ShippingDiscount.ID) ;
                                                if ( ShippingDiscount.Type EQ 1 ) {
                                                    ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
                                                } else {
                                                    ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
                                                }
                                            }
                                        // THERE IS AN AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS
                                        } else {
                                            if ( ShippingDiscount.Type EQ 1 ) {
                                                ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
                                            } else {
                                                ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
                                            }
                                        }
                                    </cfscript>					
                                    
                                    <!--- <b style="color:green">#ShippingPrice#</b><br> --->
                                    
                                </cfoutput>
                            <cfelse>
                                <cfscript>
                                    if ( session.CustomerArray[25] NEQ application.SiteConfig.data.BaseCountry )
                                        ShippingPrice = ShippingPrice + application.SiteConfig.data.DefaultShipRateInt;
                                    else
                                        ShippingPrice = ShippingPrice + application.SiteConfig.data.DefaultShipRateDom;
                                </cfscript>
                            </cfif>
                        
                        
                        <!--- INTERNATIONAL: AND NO OTHER SHIPPING METHOD SELECTED --->
                        <cfelseif session.CustomerArray[25] NEQ application.SiteConfig.data.BaseCountry >
                            <cfset ShippingPrice = application.SiteConfig.data.DefaultShipRateInt >	
                
                        </cfif>
                        <!--- END: SHIPPINGMETHOD --->
                        
                    <!--- SHIPPINGMETHOD IS 'Default' --->
                    <cfelseif session.CustomerArray[25] NEQ application.SiteConfig.data.BaseCountry >
                        <!--- INTERNATIONAL --->
                        <cfset ShippingPrice = ShippingPrice + application.SiteConfig.data.DefaultShipRateInt >
                    <cfelse>
                        <cfset ShippingPrice = ShippingPrice + application.SiteConfig.data.DefaultShipRateDom >
                    </cfif>
            	<!--- SHIPPING METHOD NOT CHOSEN, GET ALL AVAILABLE SHIPPING SERVICES (RETURN MULTI-ROW QUERY) --->
                <cfelse>
                	<cfscript>
						// getAllShippingOptions
					</cfscript>
                </cfif>
            
            <!--- SHIPBY REGION/GEOGRAPHY --->	
            <cfelseif arguments.ShipBy EQ 4 >
            
				<cfscript>
                    if ( session.CustomerArray[25] EQ application.SiteConfig.data.BaseCountry ) {
                        TableToSelect = 'States' ;
                        WhereClause = 'StateCode = "' & session.CustomerArray[23] & '"' ;
                    } else {
                        TableToSelect = 'Countries' ;
                        WhereClause = 'Country = "' & session.CustomerArray[25] & '"' ;
                    }
                </cfscript>
                <cfquery name="getRate" datasource="#variables.dsn#">
                    SELECT 	*
                    FROM 	#TableToSelect#
                    WHERE 	#WhereClause#
                </cfquery>
				<cfscript>
                    if ( GetRate.S_Rate EQ '' OR GetRate.S_Rate LT 0 )
                        ShippingPrice = ShippingPrice + application.SiteConfig.data.DefaultShipRateDom ;
                    else
                        ShippingPrice = ShippingPrice + GetRate.S_Rate ;
					// SHIPPING DISCOUNT
					// NO AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS
					if ( GlobalShipDiscount EQ 0 ) {
						// INVOKE INSTANCE OF OBJECT - GET PRODUCT PRICE, INCLUDING ANY DISCOUNTS
						ShippingDiscount = application.Cart.getShipDiscount(UserID=arguments.UserID,SiteID=arguments.SiteID,SessionID=arguments.SessionID,ShippingMethod='Location') ;
						if ( ShippingDiscount.ShipMethod EQ 'Location' )
						{
							UsedShipDiscounts = ListAppend(UsedShipDiscounts,ShippingDiscount.ID) ;
							if ( ShippingDiscount.Type EQ 1 ) {
								ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
							} else {
								ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
							}
						}
					// THERE IS AN AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS
					} else {
						if ( ShippingDiscount.Type EQ 1 ) {
							ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
						} else {
							ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
						}
					}
				</cfscript>
            
            
            <!--- SHIPBY CUSTOM SHIPPING OPTIONS: WEIGHT --->	
            <cfelseif arguments.ShipBy EQ 5 >
                
                <cfquery name="getCustomShipping" datasource="#variables.dsn#">
                    SELECT 	ShipPrice
                    FROM	ShippingMethods
                    WHERE	SiteID = #arguments.SiteID#
                    AND		ShippingCode = '#ShippingMethod#'
                </cfquery>
                
                <cfscript>
                    if ( getCustomShipping.RecordCount NEQ 0 AND getCustomShipping.ShipPrice NEQ '' )
                        ShippingPrice = NumberFormat(ShippingPrice + getCustomShipping.ShipPrice,0.00) ;
					// SHIPPING DISCOUNT
					// NO AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS
					if ( GlobalShipDiscount EQ 0 ) {
						// INVOKE INSTANCE OF OBJECT - GET PRODUCT PRICE, INCLUDING ANY DISCOUNTS
						ShippingDiscount = application.Cart.getShipDiscount(UserID=arguments.UserID,SiteID=arguments.SiteID,SessionID=arguments.SessionID,ShippingMethod='Weight') ;
						if ( ShippingDiscount.ShipMethod EQ 'Weight' )
						{
							UsedShipDiscounts = ListAppend(UsedShipDiscounts,ShippingDiscount.ID) ;
							if ( ShippingDiscount.Type EQ 1 ) {
								ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
							} else {
								ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
							}
						}
					// THERE IS AN AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS
					} else {
						if ( ShippingDiscount.Type EQ 1 ) {
							ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
						} else {
							ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
						}
					}
				</cfscript>
                
                
            <!--- SHIPBY CUSTOM SHIPPING OPTIONS: PRICE --->	
            <cfelseif arguments.ShipBy EQ 6 >
                
                <cfquery name="getCustomShipping" datasource="#variables.dsn#">
                    SELECT 	ShipPrice
                    FROM	ShippingMethods
                    WHERE	SiteID = #arguments.SiteID#
                    AND		ShippingCode = '#ShippingMethod#'
                </cfquery>
                
                <cfscript>
                    if ( getCustomShipping.RecordCount NEQ 0 AND getCustomShipping.ShipPrice NEQ '' )
                        ShippingPrice = NumberFormat(ShippingPrice + getCustomShipping.ShipPrice,0.00) ;
					// SHIPPING DISCOUNT
					// NO AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS
					if ( GlobalShipDiscount EQ 0 ) {
						// INVOKE INSTANCE OF OBJECT - GET PRODUCT PRICE, INCLUDING ANY DISCOUNTS
						ShippingDiscount = application.Cart.getShipDiscount(UserID=arguments.UserID,SiteID=arguments.SiteID,SessionID=arguments.SessionID,ShippingMethod='Price') ;
						if ( ShippingDiscount.ShipMethod EQ 'Price' )
						{
							UsedShipDiscounts = ListAppend(UsedShipDiscounts,ShippingDiscount.ID) ;
							if ( ShippingDiscount.Type EQ 1 ) {
								ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
							} else {
								ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
							}
						}
					// THERE IS AN AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS
					} else {
						if ( ShippingDiscount.Type EQ 1 ) {
							ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
						} else {
							ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
						}
					}
				</cfscript>
            
            
            <!--- SHIPBY RETAIL PRO --->
            <cfelseif arguments.ShipBy EQ 7 >
                
                <!--- <cfquery name="getShippingCodes" datasource="#variables.dsn#" >
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
                    <cfquery name="getCustomShipping" datasource="#variables.dsn#">
                        SELECT 	ShipPrice
                        FROM	ShippingMethods
                        WHERE	SiteID = #arguments.SiteID#
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
                        if ( session.CustomerArray[25] NEQ application.SiteConfig.data.BaseCountry AND application.SiteConfig.data.AcceptIntShipment EQ 1 )
                            ShippingPrice = ShippingPrice + application.SiteConfig.data.DefaultShipRateInt ;
                        else
                            ShippingPrice = ShippingPrice + application.SiteConfig.data.DefaultShipRateDom ;
                    </cfscript>
                </cfif>
                <cfscript>
					// SHIPPING DISCOUNT
					// NO AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS
					if ( GlobalShipDiscount EQ 0 ) {
						// INVOKE INSTANCE OF OBJECT - GET PRODUCT PRICE, INCLUDING ANY DISCOUNTS
						ShippingDiscount = application.Cart.getShipDiscount(UserID=arguments.UserID,SiteID=arguments.SiteID,SessionID=arguments.SessionID,ShippingMethod='Weight') ;
						if ( ShippingDiscount.ShipMethod EQ 'Weight' )
						{
							UsedShipDiscounts = ListAppend(UsedShipDiscounts,ShippingDiscount.ID) ;
							if ( ShippingDiscount.Type EQ 1 ) {
								ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
							} else {
								ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
							}
						}
					// THERE IS AN AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS
					} else {
						if ( ShippingDiscount.Type EQ 1 ) {
							ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
						} else {
							ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
						}
					}
				</cfscript>
                    
            <!--- FALLBACK --->
            <cfelse>
                <cfset ShippingPrice = ShippingPrice + application.SiteConfig.data.DefaultShipRateDom >
            </cfif>
                
                <!--- CARTFUSION 4.6 - APPLY HANDLING FEE TO SHIPPING PRICE --->
                <!--- (previously only applied to automated realtime shipping) --->
                <cfscript>
                    if ( application.SiteConfig.data.HandlingType EQ 1 ) {
                        ShippingPrice = NumberFormat(ShippingPrice + (ShippingPrice * (application.SiteConfig.data.HandlingFee/100)),0.00) ;
                    } else {
                        ShippingPrice = NumberFormat(ShippingPrice + application.SiteConfig.data.HandlingFee,0.00) ;
                    }
                </cfscript>
                
                <!--- <cfoutput><b style="color:maroon">#ShippingPrice#</b><br></cfoutput> --->
                    
                <cfscript>
                    'ShippingPrice#CurrentRow#' = NumberFormat(ShippingPrice,0.00) ;
                    TotalShippingPrice = TotalShippingPrice + Evaluate('ShippingPrice' & CurrentRow) ;
                    ShippingPrice = 0 ;
                </cfscript>
            </cfloop>
            
            <cfset ShippingPrice = TotalShippingPrice >
            <!--- CARTFUSION 4.5 - MULTIPLE SHIPPING ADDRESSES --->
            <!--- *** END: SHIPPING CALCULATIONS *** --->
            
            
            
            
            <cfscript>
				/* if ( NOT data.RecordCount )
				{
					stReturn.bSuccess = False ;
					stReturn.data = data ;
					stReturn.Message = "No shipping rate information could be retrieved." ;
				}
				else
				{ */
					stReturn.bSuccess = True ;
					stReturn.data.ShippingPrice = ShippingPrice ;
					stReturn.Message = "Success" ;
				// }
			</cfscript>
			
			<cfcatch>
				<cfscript>
					stReturn.bSuccess = False ;
					stReturn.Message = cfcatch.message & "<br><br>" & cfcatch.detail ;
					stReturn.stError = cfcatch ;
				</cfscript>
			</cfcatch>
        </cftry>


		<cfreturn stReturn>
	</cffunction>
    
    
</cfcomponent>
<!--- !CARTFUSION 4.7 - SHIPPING CFC! --->