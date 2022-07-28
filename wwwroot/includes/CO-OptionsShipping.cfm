<!--- CARTFUSION 4.5 - MULTIPLE SHIPPING ADDRESSES --->	
<cfloop from="1" to="#Cart.Packages#" index="cpi">
<tr>
	<td width="35%" align="right" class="cfDefault"><b>Package <cfoutput>###cpi#</cfoutput><br />Shipping &amp; Handling:</b></td>
	<td width="65%" class="cfFormLabel">

<!--- IF WEIGHT IS MORE THAN ANY ALLOWABLE AMOUNT --->
<cfif Cart.CartWeight GT 150 AND config.ShipBy EQ 3 AND config.UseFedex NEQ 1 >
	<cfoutput>
	Freight: <b>#LSCurrencyFormat(config.DefaultShipRateOver)#</b>
	<input type="hidden" name="ShippingMethod#cpi#" value="Overweight">
	</cfoutput>

<!--- RETIRED IN CARTFUSION 4.5
<!--- IF SHIPBY IS PRICE --->
<cfelseif config.ShipBy EQ 1>

	<cfquery name="getShipPrice" datasource="#datasource#">				
		SELECT	InternationalRate, DomesticRate
		FROM	ShipPrice
		WHERE	Start	<	#Cart.CartTotal#
		AND		Finish	>=	#Cart.CartTotal#
		AND		SiteID = #config.SiteID#
	</cfquery>
	
	<cfoutput query="getShipPrice">
	
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
					if ( ShippingDiscount.Type EQ 1 )
					{
						if ( session.CustomerArray[25] NEQ config.BaseCountry )
							getShipPrice.InternationalRate = getShipPrice.InternationalRate - (getShipPrice.InternationalRate * ShippingDiscount.Value/100) ;
						else
							getShipPrice.DomesticRate = getShipPrice.DomesticRate - (getShipPrice.DomesticRate * ShippingDiscount.Value/100) ;
					}
					else
					{
						if ( session.CustomerArray[25] NEQ config.BaseCountry )
							getShipPrice.InternationalRate = getShipPrice.InternationalRate - ShippingDiscount.Value ;
						else
							getShipPrice.DomesticRate = getShipPrice.DomesticRate - ShippingDiscount.Value ;
					}
				}
			</cfscript>
		<cfelse><!--- THERE IS AN AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS ---> 
			<cfscript>
				if ( ShippingDiscount.Type EQ 1 )
				{
					if ( session.CustomerArray[25] NEQ config.BaseCountry )
						getShipPrice.InternationalRate = getShipPrice.InternationalRate - (getShipPrice.InternationalRate * ShippingDiscount.Value/100) ;
					else
						getShipPrice.DomesticRate = getShipPrice.DomesticRate - (getShipPrice.DomesticRate * ShippingDiscount.Value/100) ;
				}
				else
				{
					if ( session.CustomerArray[25] NEQ config.BaseCountry )
						getShipPrice.InternationalRate = getShipPrice.InternationalRate - ShippingDiscount.Value ;
					else
						getShipPrice.DomesticRate = getShipPrice.DomesticRate - ShippingDiscount.Value ;
				}
			</cfscript>
		</cfif>
		<!--- END: GET SHIPPING DISCOUNT --->
		
		<cfif session.CustomerArray[25] NEQ config.BaseCountry >
			<input type="radio" name="JustForShow" checked> #config.StoreNameShort# International Shipping: <b>#LSCurrencyFormat(InternationalRate)#</b>
		<cfelse>
			<input type="radio" name="JustForShow" checked> #config.StoreNameShort# Shipping: <b>#LSCurrencyFormat(DomesticRate)#</b>
		</cfif>
		<input type="hidden" name="ShippingMethod#cpi#" value="Price">
	</cfoutput>
<!--- IF SHIPBY IS WEIGHT --->
<cfelseif config.ShipBy EQ 2>		

	<cfquery name="getShipPrice" datasource="#datasource#">				
		SELECT	InternationalRate, DomesticRate
		FROM	ShipWeight
		WHERE	Start	<	#Cart.CartWeight#
		AND		Finish	>=	#Cart.CartWeight#
		AND		SiteID = #config.SiteID#
	</cfquery>
	
	<cfoutput query="getShipPrice">
	
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
					if ( ShippingDiscount.Type EQ 1 )
					{
						if ( session.CustomerArray[25] NEQ config.BaseCountry )
							getShipPrice.InternationalRate = getShipPrice.InternationalRate - (getShipPrice.InternationalRate * ShippingDiscount.Value/100) ;
						else
							getShipPrice.DomesticRate = getShipPrice.DomesticRate - (getShipPrice.DomesticRate * ShippingDiscount.Value/100) ;
					}
					else
					{
						if ( session.CustomerArray[25] NEQ config.BaseCountry )
							getShipPrice.InternationalRate = getShipPrice.InternationalRate - ShippingDiscount.Value ;
						else
							getShipPrice.DomesticRate = getShipPrice.DomesticRate - ShippingDiscount.Value ;
					}
				}
			</cfscript>
		<cfelse><!--- THERE IS AN AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS ---> 
			<cfscript>
				if ( ShippingDiscount.Type EQ 1 )
				{
					if ( session.CustomerArray[25] NEQ config.BaseCountry )
						getShipPrice.InternationalRate = getShipPrice.InternationalRate - (getShipPrice.InternationalRate * ShippingDiscount.Value/100) ;
					else
						getShipPrice.DomesticRate = getShipPrice.DomesticRate - (getShipPrice.DomesticRate * ShippingDiscount.Value/100) ;
				}
				else
				{
					if ( session.CustomerArray[25] NEQ config.BaseCountry )
						getShipPrice.InternationalRate = getShipPrice.InternationalRate - ShippingDiscount.Value ;
					else
						getShipPrice.DomesticRate = getShipPrice.DomesticRate - ShippingDiscount.Value ;
				}
			</cfscript>
		</cfif>
		<!--- END: GET SHIPPING DISCOUNT --->
		
		<cfif session.CustomerArray[25] NEQ config.BaseCountry >
			<input type="radio" name="JustForShow" checked> #config.StoreNameShort# International Shipping: <b>#LSCurrencyFormat(InternationalRate)#</b>
		<cfelse>
			<input type="radio" name="JustForShow" checked> #config.StoreNameShort# Shipping: <b>#LSCurrencyFormat(DomesticRate)#</b>
		</cfif>
		<input type="hidden" name="ShippingMethod#cpi#" value="Weight">
	</cfoutput>
--->

<!--- IF SHIPBY IS AUTOMATED --->
<cfelseif config.ShipBy EQ 3>
	<cfinvoke component="#application.Queries#" method="getShippingMethods" returnvariable="getShippingMethods"></cfinvoke>
	<cfinvoke component="#application.Queries#" method="getShippingCos" returnvariable="getShippingCos">
		<cfinvokeargument name="SiteID" value="#config.SiteID#">
	</cfinvoke>
	
	<!--- IF USPS --->
	<cfif config.UseUSPS EQ 1 >
		<cfset ShippingChoices = ShippingChoices + 1 >
		<cfif NOT isDefined('errorShippingUSPS') OR errorShippingUSPS NEQ 1 >
			<cftry>
				<cfinclude template="ShippingUSPS.cfm">
				<cfcatch>
					<cftry>
						<cfinclude template="ShippingUSPS.cfm">
						<cfcatch>
							<cfset errorShippingUSPS = 1 >
						</cfcatch>
					</cftry>
				</cfcatch>
			</cftry>
		</cfif>							
	</cfif>	

	<!--- IF FEDEX --->
	<cfif config.UseFedEx EQ 1 >
		<cfset ShippingChoices = ShippingChoices + 1 >
		<cfif NOT isDefined('errorShippingFEDEX') OR errorShippingFEDEX NEQ 1 >
			<cftry>
				<cfinclude template="ShippingFEDEX.cfm">
				<cfcatch>
					<cftry>
						<cfinclude template="ShippingFEDEX.cfm">
						<cfcatch>
							<cfset errorShippingFEDEX = 1 >
						</cfcatch>
					</cftry>
				</cfcatch>
			</cftry>
		</cfif>
	</cfif>
	
	<!--- IF UPS --->
	<cfif config.UseUPS EQ 1 >
		<cfset ShippingChoices = ShippingChoices + 1 >
		<cfif NOT isDefined('errorShippingUPS') OR errorShippingUPS NEQ 1 >
			<cftry>
				<cfinclude template="ShippingUPS.cfm">
				<cfcatch>
					<cftry>
						<cfinclude template="ShippingUPS.cfm">
						<cfcatch>
							<cfset errorShippingUPS = 1 >
						</cfcatch>
					</cftry>
				</cfcatch>
			</cftry>
		</cfif>			
	</cfif>
	
	<!--- 
		IF ERRORS RETURNED
	--->
	<!--- BEGIN: ERROR HANDLING --->
	<cfoutput>
	<cfif errorShippingUSPS EQ 1 
		  AND ( ShippingChoices GT 1 AND ( errorShippingFedex EQ 1 OR errorShippingUPS EQ 1 ) 
		  OR  ( ShippingChoices LTE 1 ) ) > 
		<cfif session.CustomerArray[25] NEQ config.BaseCountry >
			<cfscript>
				ShippingPrice = ShippingPrice + config.DefaultShipRateInt ;
			</cfscript>
            <cfinput type="radio" name="ShippingMethod#cpi#" value="Default" required="yes" message="Please select a shipping method" checked="yes"> Default International Shipping: <b>#LSCurrencyFormat(ShippingPrice)#</b><br />
		<cfelse>
        	<cfscript>
				ShippingPrice = ShippingPrice + config.DefaultShipRateDom ;
			</cfscript>
			<cfinput type="radio" name="ShippingMethod#cpi#" value="Default" required="yes" message="Please select a shipping method" checked="yes"> Default Shipping: <b>#LSCurrencyFormat(ShippingPrice)#</b><br />
		</cfif>
	<cfelseif errorShippingFedex EQ 1 
		  AND ( ShippingChoices GT 1 AND ( errorShippingUSPS EQ 1 OR errorShippingUPS EQ 1 ) 
		  OR  ( ShippingChoices LTE 1 ) ) > 
		<cfif session.CustomerArray[25] NEQ config.BaseCountry >
			<cfscript>
				ShippingPrice = ShippingPrice + config.DefaultShipRateInt ;
			</cfscript>
            <cfinput type="radio" name="ShippingMethod#cpi#" value="Default" required="yes" message="Please select a shipping method" checked="yes"> Default International Shipping: <b>#LSCurrencyFormat(ShippingPrice)#</b><br />
		<cfelse>
        	<cfscript>
				ShippingPrice = ShippingPrice + config.DefaultShipRateDom ;
			</cfscript>
			<cfinput type="radio" name="ShippingMethod#cpi#" value="Default" required="yes" message="Please select a shipping method" checked="yes"> Default Shipping: <b>#LSCurrencyFormat(ShippingPrice)#</b><br />
		</cfif>
	<cfelseif errorShippingUPS EQ 1 
		  AND ( ShippingChoices GT 1 AND ( errorShippingFedex EQ 1 OR errorShippingUSPS EQ 1 ) 
		  OR  ( ShippingChoices LTE 1 ) ) > 
		<cfif session.CustomerArray[25] NEQ config.BaseCountry >
			<cfscript>
				ShippingPrice = ShippingPrice + config.DefaultShipRateInt ;
			</cfscript>
            <cfinput type="radio" name="ShippingMethod#cpi#" value="Default" required="yes" message="Please select a shipping method" checked="yes"> Default International Shipping: <b>#LSCurrencyFormat(ShippingPrice)#</b><br />
		<cfelse>
        	<cfscript>
				ShippingPrice = ShippingPrice + config.DefaultShipRateDom ;
			</cfscript>
			<cfinput type="radio" name="ShippingMethod#cpi#" value="Default" required="yes" message="Please select a shipping method" checked="yes"> Default Shipping: <b>#LSCurrencyFormat(ShippingPrice)#</b><br />
		</cfif>
	</cfif>
	</cfoutput>
	<!--- END: ERROR HANDLING --->
	
	
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
		
	<cfoutput>
		<cfif session.CustomerArray[25] NEQ config.BaseCountry >
			<input type="radio" name="JustForShow" checked> #config.StoreNameShort# International Shipping: <b>#LSCurrencyFormat(ShippingPrice)#</b>
		<cfelse>
			<input type="radio" name="JustForShow" checked> #config.StoreNameShort# Shipping: <b>#LSCurrencyFormat(ShippingPrice)#</b>
		</cfif>
		<input type="hidden" name="ShippingMethod#cpi#" value="Location">
	</cfoutput>
	

<!--- SHIPBY CUSTOM SHIPPING OPTIONS: WEIGHT --->
<cfelseif config.ShipBy EQ 5 >
	<cfquery name="getCustomShipping" datasource="#datasource#">
		SELECT 	*
		FROM	ShippingMethods
		WHERE	ShipWeightLo < #Cart.CartWeight#
		AND		ShipWeightHi >=	#Cart.CartWeight#
		AND		(ShipWeightLo > 0 OR ShipWeightHi > 0)
		AND		SiteID = #config.SiteID#
		AND		ShippingCompany = 'Custom'
		<cfif   session.CustomerArray[25] EQ config.BaseCountry >
		AND		International != 1
		<cfelse>
		AND		International = 1
		</cfif>
		ORDER BY ShippingMessage
	</cfquery>
	
	<cfif getCustomShipping.RecordCount NEQ 0 >
		<cfoutput query="getCustomShipping">
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
						if ( ShippingDiscount.Type EQ 1 )
							ShipPrice = ShipPrice - (ShipPrice * ShippingDiscount.Value/100) ;
						else
							ShipPrice = ShipPrice - ShippingDiscount.Value ;		
					}
				</cfscript>
			<cfelse><!--- THERE IS AN AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS ---> 
				<cfscript>
					if ( ShippingDiscount.Type EQ 1 )
						ShipPrice = ShipPrice - (ShipPrice * ShippingDiscount.Value/100) ;
					else
						ShipPrice = ShipPrice - ShippingDiscount.Value ;
				</cfscript>
			</cfif>
			<!--- END: GET SHIPPING DISCOUNT --->
			<cfif getCustomShipping.RecordCount EQ 1>
				<cfinput type="radio" name="ShippingMethod#cpi#" value="#ShippingCode#" required="yes" message="Please select a shipping method" checked="yes"> #ShippingMessage#: <b>#LSCurrencyFormat(ShipPrice)#</b><br />
			<cfelse>
				<cfinput type="radio" name="ShippingMethod#cpi#" value="#ShippingCode#" required="yes" message="Please select a shipping method" checked="no" > #ShippingMessage#: <b>#LSCurrencyFormat(ShipPrice)#</b><br />
			</cfif>
		</cfoutput>
	<cfelse>
		<cfif session.CustomerArray[25] NEQ config.BaseCountry >
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
						if ( ShippingDiscount.Type EQ 1 )
							config.DefaultShipRateInt = config.DefaultShipRateInt - (config.DefaultShipRateInt * ShippingDiscount.Value/100) ;
						else
							config.DefaultShipRateInt = config.DefaultShipRateInt - ShippingDiscount.Value ;		
					}
				</cfscript>
			<cfelse><!--- THERE IS AN AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS ---> 
				<cfscript>
					if ( ShippingDiscount.Type EQ 1 )
						config.DefaultShipRateInt = config.DefaultShipRateInt - (config.DefaultShipRateInt * ShippingDiscount.Value/100) ;
					else
						config.DefaultShipRateInt = config.DefaultShipRateInt - ShippingDiscount.Value ;
				</cfscript>
			</cfif>
			<!--- END: GET SHIPPING DISCOUNT --->
			<cfoutput>
			<cfinput type="radio" name="ShippingMethod#cpi#" value="Default" required="yes" message="Please select a shipping method" checked="yes"> Default Int'l Shipping: <b>#LSCurrencyFormat(config.DefaultShipRateInt)#</b><br />
			</cfoutput>
		<cfelse>
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
						if ( ShippingDiscount.Type EQ 1 )
							config.DefaultShipRateDom = config.DefaultShipRateDom - (config.DefaultShipRateDom * ShippingDiscount.Value/100) ;
						else
							config.DefaultShipRateDom = config.DefaultShipRateDom - ShippingDiscount.Value ;		
					}
				</cfscript>
			<cfelse><!--- THERE IS AN AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS ---> 
				<cfscript>
					if ( ShippingDiscount.Type EQ 1 )
						config.DefaultShipRateDom = config.DefaultShipRateDom - (config.DefaultShipRateDom * ShippingDiscount.Value/100) ;
					else
						config.DefaultShipRateDom = config.DefaultShipRateDom - ShippingDiscount.Value ;
				</cfscript>
			</cfif>
			<!--- END: GET SHIPPING DISCOUNT --->
			<cfoutput>
			<cfinput type="radio" name="ShippingMethod#cpi#" value="Default" required="yes" message="Please select a shipping method" checked="yes"> Default Shipping: <b>#LSCurrencyFormat(config.DefaultShipRateDom)#</b><br />
			</cfoutput>
		</cfif>
	</cfif>
	
	
<!--- SHIPBY CUSTOM SHIPPING OPTIONS: PRICE --->	
<cfelseif config.ShipBy EQ 6 >
	<cfquery name="getCustomShipping" datasource="#datasource#">
		SELECT 	*
		FROM	ShippingMethods
		WHERE	ShipPriceLo <  #Cart.CartTotal#
		AND		ShipPriceHi >= #Cart.CartTotal#
		AND		(ShipPriceLo > 0 OR ShipPriceHi > 0)
		AND		SiteID = #config.SiteID#
		AND		ShippingCompany = 'Custom'
		<cfif   session.CustomerArray[25] EQ config.BaseCountry >
		AND		International != 1
		<cfelse>
		AND		International = 1
		</cfif>
		ORDER BY ShippingMessage
	</cfquery>
	
	<cfif getCustomShipping.RecordCount NEQ 0 >
		<cfoutput query="getCustomShipping">
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
						if ( ShippingDiscount.Type EQ 1 )
							ShipPrice = ShipPrice - (ShipPrice * ShippingDiscount.Value/100) ;
						else
							ShipPrice = ShipPrice - ShippingDiscount.Value ;		
					}
				</cfscript>
			<cfelse><!--- THERE IS AN AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS ---> 
				<cfscript>
					if ( ShippingDiscount.Type EQ 1 )
						ShipPrice = ShipPrice - (ShipPrice * ShippingDiscount.Value/100) ;
					else
						ShipPrice = ShipPrice - ShippingDiscount.Value ;
				</cfscript>
			</cfif>
			<!--- END: GET SHIPPING DISCOUNT --->
			<cfif getCustomShipping.RecordCount EQ 1>
				<cfinput type="radio" name="ShippingMethod#cpi#" value="#ShippingCode#" required="yes" message="Please select a shipping method" checked="yes"> #ShippingMessage#: <b>#LSCurrencyFormat(ShipPrice)#</b><br />
			<cfelse>
				<cfinput type="radio" name="ShippingMethod#cpi#" value="#ShippingCode#" required="yes" message="Please select a shipping method" checked="no" > #ShippingMessage#: <b>#LSCurrencyFormat(ShipPrice)#</b><br />
			</cfif>
		</cfoutput>
	<cfelse>
		<cfif session.CustomerArray[25] NEQ config.BaseCountry >
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
						if ( ShippingDiscount.Type EQ 1 )
							config.DefaultShipRateInt = config.DefaultShipRateInt - (config.DefaultShipRateInt * ShippingDiscount.Value/100) ;
						else
							config.DefaultShipRateInt = config.DefaultShipRateInt - ShippingDiscount.Value ;		
					}
				</cfscript>
			<cfelse><!--- THERE IS AN AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS ---> 
				<cfscript>
					if ( ShippingDiscount.Type EQ 1 )
						config.DefaultShipRateInt = config.DefaultShipRateInt - (config.DefaultShipRateInt * ShippingDiscount.Value/100) ;
					else
						config.DefaultShipRateInt = config.DefaultShipRateInt - ShippingDiscount.Value ;
				</cfscript>
			</cfif>
			<!--- END: GET SHIPPING DISCOUNT --->
			<cfoutput>
			<cfinput type="radio" name="ShippingMethod#cpi#" value="Default" required="yes" message="Please select a shipping method" checked="yes"> Default Int'l Shipping: <b>#LSCurrencyFormat(config.DefaultShipRateInt)#</b><br />
			</cfoutput>
		<cfelse>
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
						if ( ShippingDiscount.Type EQ 1 )
							config.DefaultShipRateDom = config.DefaultShipRateDom - (config.DefaultShipRateDom * ShippingDiscount.Value/100) ;
						else
							config.DefaultShipRateDom = config.DefaultShipRateDom - ShippingDiscount.Value ;		
					}
				</cfscript>
			<cfelse><!--- THERE IS AN AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS ---> 
				<cfscript>
					if ( ShippingDiscount.Type EQ 1 )
						config.DefaultShipRateDom = config.DefaultShipRateDom - (config.DefaultShipRateDom * ShippingDiscount.Value/100) ;
					else
						config.DefaultShipRateDom = config.DefaultShipRateDom - ShippingDiscount.Value ;
				</cfscript>
			</cfif>
			<!--- END: GET SHIPPING DISCOUNT --->
			<cfoutput>
			<cfinput type="radio" name="ShippingMethod#cpi#" value="Default" required="yes" message="Please select a shipping method" checked="yes"> Default Shipping: <b>#LSCurrencyFormat(config.DefaultShipRateDom)#</b><br />
			</cfoutput>
		</cfif>
	</cfif>


<!--- SHIPBY RETAIL PRO --->
<cfelseif config.ShipBy EQ 7 >
	
	<cfquery name="getShippingCodes" datasource="#datasource#" >
		SELECT	*
		FROM	ShippingCodes
	</cfquery>
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
				WHERE	ShippingCode = #fldShipAmount#
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
	
	<cfquery name="getCustomShipping" datasource="#datasource#">
		SELECT 	*
		FROM	ShippingMethods
		WHERE	ShipWeightLo < #RPTotalWeight#
		AND		ShipWeightHi >=	#RPTotalWeight#
		AND		(ShipWeightLo > 0 OR ShipWeightHi > 0)
		AND		SiteID = #config.SiteID#
		AND		ShippingCompany = 'Custom'
		<cfif   session.CustomerArray[25] EQ config.BaseCountry >
		AND		International != 1
		<cfelse>
		AND		International = 1
		</cfif>
		ORDER BY ShippingMessage
	</cfquery>
	
	<!--- CALCULATE SHIPPING --->
	<cfif getCustomShipping.RecordCount NEQ 0 >
		<cfoutput query="getCustomShipping">

			<cfset getCustomShipping.ShipPrice = getCustomShipping.ShipPrice + RPShipPriceAdd >

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
						if ( ShippingDiscount.Type EQ 1 )
							ShipPrice = ShipPrice - (ShipPrice * ShippingDiscount.Value/100) ;
						else
							ShipPrice = ShipPrice - ShippingDiscount.Value ;		
					}
				</cfscript>
			<cfelse><!--- THERE IS AN AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS ---> 
				<cfscript>
					if ( ShippingDiscount.Type EQ 1 )
						ShipPrice = ShipPrice - (ShipPrice * ShippingDiscount.Value/100) ;
					else
						ShipPrice = ShipPrice - ShippingDiscount.Value ;
				</cfscript>
			</cfif>
			<!--- END: GET SHIPPING DISCOUNT --->
			<cfif getCustomShipping.RecordCount EQ 1>
				<cfinput type="radio" name="ShippingMethod#cpi#" value="#ShippingCode#" required="yes" message="Please select a shipping method" checked="yes"> #ShippingMessage#: <b>#LSCurrencyFormat(ShipPrice)#</b> <cfif RPShipCodeUsed EQ 1 ><font class="cfAttract">*</font></cfif><br />
			<cfelse>
				<cfinput type="radio" name="ShippingMethod#cpi#" value="#ShippingCode#" required="yes" message="Please select a shipping method" checked="no" > #ShippingMessage#: <b>#LSCurrencyFormat(ShipPrice)#</b> <cfif RPShipCodeUsed EQ 1 ><font class="cfAttract">*</font></cfif><br />
			</cfif>
		</cfoutput>
	<!--- NO ITEMS IN CART ARE CALCULATED BY WEIGHT --->
	<cfelseif RPShipPriceAdd GT 0 >
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
					if ( ShippingDiscount.Type EQ 1 )
						RPShipPriceAdd = RPShipPriceAdd - (RPShipPriceAdd * ShippingDiscount.Value/100) ;
					else
						RPShipPriceAdd = RPShipPriceAdd - ShippingDiscount.Value ;		
				}
			</cfscript>
		<cfelse><!--- THERE IS AN AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS ---> 
			<cfscript>
				if ( ShippingDiscount.Type EQ 1 )
					RPShipPriceAdd = RPShipPriceAdd - (RPShipPriceAdd * ShippingDiscount.Value/100) ;
				else
					RPShipPriceAdd = RPShipPriceAdd - ShippingDiscount.Value ;
			</cfscript>
		</cfif>
		<!--- END: GET SHIPPING DISCOUNT --->
		<cfoutput>
		<cfinput type="radio" name="ShippingMethod#cpi#" value="Default" required="yes" message="Please select a shipping method" checked="yes"> Special Shipping: <b>#LSCurrencyFormat(RPShipPriceAdd)#</b> <cfif RPShipCodeUsed EQ 1 ><font class="cfAttract">*</font></cfif><br />
		</cfoutput>
	<!--- USE DEFAULT, AS LONG AS NO ITEMS IN CART HAVE SPECIAL SHIPPING CODE --->
	<cfelseif RPShipCodeUsed EQ 0 >
		<cfif session.CustomerArray[25] NEQ config.BaseCountry >

			<cfset config.DefaultShipRateInt = config.DefaultShipRateInt + RPShipPriceAdd >

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
						if ( ShippingDiscount.Type EQ 1 )
							config.DefaultShipRateInt = config.DefaultShipRateInt - (config.DefaultShipRateInt * ShippingDiscount.Value/100) ;
						else
							config.DefaultShipRateInt = config.DefaultShipRateInt - ShippingDiscount.Value ;		
					}
				</cfscript>
			<cfelse><!--- THERE IS AN AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS ---> 
				<cfscript>
					if ( ShippingDiscount.Type EQ 1 )
						config.DefaultShipRateInt = config.DefaultShipRateInt - (config.DefaultShipRateInt * ShippingDiscount.Value/100) ;
					else
						config.DefaultShipRateInt = config.DefaultShipRateInt - ShippingDiscount.Value ;
				</cfscript>
			</cfif>
			<!--- END: GET SHIPPING DISCOUNT --->
			<cfoutput>
			<cfinput type="radio" name="ShippingMethod#cpi#" value="Default" required="yes" message="Please select a shipping method" checked="yes"> Default Int'l Shipping: <b>#LSCurrencyFormat(config.DefaultShipRateInt)#</b> <cfif RPShipCodeUsed EQ 1 ><font class="cfAttract">*</font></cfif><br />
			</cfoutput>
		<cfelse>

			<cfset config.DefaultShipRateDom = config.DefaultShipRateDom + RPShipPriceAdd >

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
						if ( ShippingDiscount.Type EQ 1 )
							config.DefaultShipRateDom = config.DefaultShipRateDom - (config.DefaultShipRateDom * ShippingDiscount.Value/100) ;
						else
							config.DefaultShipRateDom = config.DefaultShipRateDom - ShippingDiscount.Value ;		
					}
				</cfscript>
			<cfelse><!--- THERE IS AN AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS ---> 
				<cfscript>
					if ( ShippingDiscount.Type EQ 1 )
						config.DefaultShipRateDom = config.DefaultShipRateDom - (config.DefaultShipRateDom * ShippingDiscount.Value/100) ;
					else
						config.DefaultShipRateDom = config.DefaultShipRateDom - ShippingDiscount.Value ;
				</cfscript>
			</cfif>
			<!--- END: GET SHIPPING DISCOUNT --->
			<cfoutput>
			<cfinput type="radio" name="ShippingMethod#cpi#" value="Default" required="yes" message="Please select a shipping method" checked="yes"> Default Shipping: <b>#LSCurrencyFormat(config.DefaultShipRateDom)#</b> <cfif RPShipCodeUsed EQ 1 ><font class="cfAttract">*</font></cfif><br />
			</cfoutput>
		</cfif>
	<!--- ALL ITEMS IN CART HAVE SPECIAL SHIPPING CODES --->
	<cfelse>
		<cfinput type="radio" name="ShippingMethod#cpi#" value="Default" required="yes" message="Please select a shipping method" checked="yes"> <b>Special Shipping Required...</b><br />
	</cfif>
	
	<cfif RPShipCodeUsed EQ 1 >
		<div style="padding-left:6px; padding-right:20px;" class="cfAttract">
			<br />
			<u>* SHIPPING NOTES *</u><br />
			<cfoutput>#checkShippingCode.ShippingMessage#</cfoutput>
		</div>
	</cfif>
	
</cfif><!--- config.ShipBy --->
	</td>
</tr>
<tr>
	<td colspan="2"><hr size="1" style="margin:0; padding:0; width:100%" /></td>
</tr>
</cfloop><!--- Cart.Packages --->
