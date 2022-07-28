<cfif session.CustomerArray[26] eq ''>
	<cflocation url="CartEdit.cfm" addtoken="no">
</cfif>

<cfoutput>

<cfmodule template="tags/layout.cfm" CurrentTab="MyAccount" LayoutStyle="Full" PageTitle="Check Out - Step 2 of 4" showCategories="false">

<!--- Start Breadcrumb --->
<cfmodule template="tags/breadCrumbs.cfm" CrumbLevel='2' showLinkCrumb="Cart|Check Out - Step 2 of 4" />
<!--- End BreadCrumb --->
<!--- BEGIN: CLICK BUTTON - GO TO STEP 4 --->
<cfif structKeyExists(form, "Step3")>
	<cfinclude template="CO-Payment.cfm">
	<cfabort>

<!--- MAKE SURE BILLING & SHIPPING INFO IS THERE --->
<cfelseif NOT isDefined('ErrorOptions') >
	<cfscript>
		if (isDefined('FirstName') and (
			trim(FirstName) eq '' or
			trim(LastName) eq '' or
			trim(Address1) eq '' or
			trim(City) eq '' or
			trim(State) eq '' or
			trim(Zip) eq '' or
			trim(Country) eq '' or
			trim(Phone) eq '' or
			trim(Email) eq '' ) )
		{
			ErrorBilling = 1 ;
		}
		if (isDefined('shippingFirstName') and (
			trim(shippingFirstName) eq '' or
			trim(shippingLastName) eq '' or
			trim(shippingAddress1) eq '' or
			trim(shippingCity) eq '' or
			trim(shippingState) eq '' or
			trim(shippingZip) eq '' or
			trim(shippingCountry) eq '' or
			trim(shippingPhone) eq '' ) )
		{
			ErrorShipping = 1 ;
		}
		if (isDefined('shippingZip') and 
			isNumeric(shippingZip) and 
		   (shippingZip LT application.siteConfig.data.BeginZipToAccept OR
			shippingZip GT application.siteConfig.data.EndZipToAccept) )
		{
			ErrorBilling = 3 ;
		}
	</cfscript>
</cfif>

<cfif isDefined('ErrorBilling')>
	<cfoutput><cflocation url="CO-Billing.cfm?ErrorBilling=#ErrorBilling#" addtoken="no"></cfoutput>
	<cfabort>
</cfif>	

<!--- APPLY SHIPPING FORM INFORMATION TO CUSTOMER ARRAY --->
<!--- ASSIGN FORM VARIABLES TO SESSION.CUSTOMERARRAY --->
<cfscript>
	// JUST IN CASE OF PREVIOUS ERROR
	if ( NOT isDefined('ErrorOptions') )
	{
		if ( isDefined('FirstName') )
		{
			session.CustomerArray[1]  = FirstName;
			session.CustomerArray[2]  = LastName;
			session.CustomerArray[3]  = Address1;
			session.CustomerArray[4]  = Address2;
			session.CustomerArray[5]  = City;
			session.CustomerArray[6]  = State;
			session.CustomerArray[7]  = Zip;
			session.CustomerArray[8]  = Country;
			session.CustomerArray[9]  = Phone;
			session.CustomerArray[10] = Fax;
			session.CustomerArray[11] = Email;
			session.CustomerArray[12] = CompanyName;
			session.CustomerArray[16] = 0;
			session.CustomerArray[29] = sessionID;
		}
		if ( isDefined('shippingFirstName') )
		{
			session.CustomerArray[18] = shippingFirstName;
			session.CustomerArray[19] = shippingLastName;
			session.CustomerArray[34] = shippingCompanyName;
			session.CustomerArray[20] = shippingAddress1;
			session.CustomerArray[21] = shippingAddress2;
			session.CustomerArray[22] = shippingCity;
			session.CustomerArray[23] = shippingState;
			session.CustomerArray[24] = shippingZip;
			session.CustomerArray[25] = shippingCountry;
			session.CustomerArray[35] = shippingPhone;
		}
	}
</cfscript>


<cfparam name="ErrorOptions" default="0">
<cfparam name="ErrorShippingUSPS" default="0">
<cfparam name="ErrorShippingFedex" default="0">
<cfparam name="ErrorShippingUPS" default="0">
<cfparam name="ShippingChoices" default="0">
<cfparam name="ShippingMethod" default="0">

<!--- CARTFUSION 4.6 - CART CFC --->
<cfscript>
	// CALCULATE TOTAL WEIGHT & TOTAL PRICE OF ORDER
	if ( trim(session.CustomerArray[28]) Neq '' ) {
		UserID = session.CustomerArray[28] ;
	} else {
		UserID = 1 ;
	}
	// Cart = application.Cart.getCartItems(UserID=UserID,SiteID=application.siteConfig.data.SiteID,SessionID=SessionID) ;
	// LOOK FOR AN ALL-METHODS SHIPPING DISCOUNT
	ShippingDiscount = application.Cart.getShipDiscount(UserID=UserID,SiteID=application.siteConfig.data.SiteID,SessionID=SessionID) ;
	if ( ShippingDiscount.All eq 1 )
		GlobalShipDiscount = 1 ;
	else
		GlobalShipDiscount = 0 ;
</cfscript>


<table width="98%" align="center" border="0" cellpadding="0" cellspacing="0">
	<tr><td style="padding-top:10px; padding-bottom:5px;" align="right"><img src="images/image-CheckoutProcess2.gif" hspace="3" align="absmiddle"><br><br></td></tr>
</table>

<!--- Errors --->
<!--- IS INTERNATIONAL SHIPPING ALLOWED? --->
	<!--- NO --->
	<cfif session.CustomerArray[25] neq application.siteConfig.data.BaseCountry and application.siteConfig.data.AcceptIntShipment neq 1 >
		<div class="cfErrorMsg">I'm sorry, but we're not accepting orders for international shipments at this time.</div>
			<cfif ErrorOptions eq 1 >
				<div class="cfErrorMsg">ERROR: Please enter a domestic shipping address before proceeding.</div>
			</cfif>
	<!--- YES --->
	<cfelse>
		<cfif ErrorOptions eq 1 >
			<div class="cfErrorMsg">ERROR: Please select a Shipping Method.</div>
		</cfif>
	</cfif>
<br />

<table width="100%" align="center">
<cfform method="post" action="CO-Options.cfm" preservedata="yes" name="OrderForm">
	<tr>
		<!--- SHIPPING METHODS --->
		<td width="49%" valign="top">
			
			
			<table width="100%" class="cartLayoutTable">
				<tr>
					<th align="center">Shipping Methods</th>
				</tr>
				<tr>
					<td align="center" height="200" valign="top">
						<table width="100%" cellpadding="3" cellspacing="0" border="0">
				
				<!--- IS INTERNATIONAL SHIPPING ALLOWED? --->
				<!--- NO --->
				<cfif session.CustomerArray[25] neq application.siteConfig.data.BaseCountry and application.siteConfig.data.AcceptIntShipment neq 1>
					
					<cfset qCalculateShipping = application.Shipping.CalculateShipping(
						UserID = UserID,
						SiteID = application.siteConfig.data.SiteID,
						SessionID = SessionID,
						ShipBy = application.siteConfig.data.ShipBy) ><!--- Method = '' FOR SPECIFIC RATE ReqUEST --->
<cfif qCalculateShipping.bSuccess >
	<input type="hidden" name="ShippingMethod1" value="default">
    <script language="javascript">
		this.submit();
	</script>
	<!--- <cfloop query="qCalculateShipping.data" >
		<tr>
			<td width="35%" align="right" class="cfDefault"><b>Package <cfoutput>##<!--- #cpi# ---></cfoutput><br />Shipping &amp; Handling:</b></td>
			<td width="65%" class="cfFormLabel">
				| <cfinput type="radio" name="ShippingMethod#qCalculateShipping.data.Package#" value="#qCalculateShipping.data.Method#" required="yes" message="Please select a shipping method" checked="yes"> #qCalculateShipping.data.MethodName#: <b>#LSCurrencyFormat(application.siteConfig.data.DefaultShipRateInt)#</b>
				<cfif qCalculateShipping.data.ShippingMessage Neq '' ><font class="cfAttract">#qCalculateShipping.data.ShippingMessage#</font></cfif>
			</td>
		</tr>
	</cfloop> --->
<cfelse>
	<cfdump var="#qCalculateShipping#">
</cfif>


<!---
<!--- CARTFUSION 4.5 - MULTIPLE SHIPPING ADDRESSES --->	
<cfloop from="1" to="#Cart.Packages#" index="cpi">

<!--- IF WEIGHT IS MORE THAN ANY ALLOWABLE AMOUNT --->
<cfif Cart.CartWeight GT 150 and application.siteConfig.data.ShipBy eq 3 and application.siteConfig.data.UseFedex Neq 1 >
	<cfoutput>
	Freight: <b>#LSCurrencyFormat(application.siteConfig.data.DefaultShipRateOver)#</b>
	<input type="hidden" name="ShippingMethod#cpi#" value="Overweight">
	</cfoutput>

<!--- RETIRED IN CARTFUSION 4.5
<!--- IF SHIPBY IS PRICE --->
<cfelseif application.siteConfig.data.ShipBy eq 1>
	<cfquery name="getShipPrice" datasource="#application.dsn#">				
		SELECT	InternationalRate, DomesticRate
		FROM	ShipPrice
		WHERE	Start	<	#Cart.CartTotal#
		and		Finish	>=	#Cart.CartTotal#
		and		SiteID = #application.siteConfig.data.SiteID#
	</cfquery>
	
	<cfoutput query="getShipPrice">
	
		<!--- BEGIN: GET SHIPPING DISCOUNT --->
		<cfif GlobalShipDiscount eq 0 >
			<!--- INVOKE INSTANCE OF OBJECT - GET PRODUCT PRICE, INCLUDING ANY DISCOUNTS --->
			<cfinvoke component="#application.Cart#" method="getShipDiscount" returnvariable="ShippingDiscount">
				<cfif session.CustomerArray[28] eq '' >
					<cfinvokeargument name="UserID" value="1">
				<cfelse>
					<cfinvokeargument name="UserID" value="#session.CustomerArray[28]#">
				</cfif>
				<cfinvokeargument name="SiteID" value="#application.siteConfig.data.SiteID#">
				<cfinvokeargument name="ShippingMethod" value="Price">
				<cfinvokeargument name="SessionID" value="#SessionID#">
			</cfinvoke>
			
			<cfscript>
				if ( ShippingDiscount.ShipMethod eq 'Price' )
				{
					if ( ShippingDiscount.Type eq 1 )
					{
						if ( session.CustomerArray[25] Neq application.siteConfig.data.BaseCountry )
							getShipPrice.InternationalRate = getShipPrice.InternationalRate - (getShipPrice.InternationalRate * ShippingDiscount.Value/100) ;
						else
							getShipPrice.DomesticRate = getShipPrice.DomesticRate - (getShipPrice.DomesticRate * ShippingDiscount.Value/100) ;
					}
					else
					{
						if ( session.CustomerArray[25] Neq application.siteConfig.data.BaseCountry )
							getShipPrice.InternationalRate = getShipPrice.InternationalRate - ShippingDiscount.Value ;
						else
							getShipPrice.DomesticRate = getShipPrice.DomesticRate - ShippingDiscount.Value ;
					}
				}
			</cfscript>
		<cfelse><!--- THERE IS AN AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS ---> 
			<cfscript>
				if ( ShippingDiscount.Type eq 1 )
				{
					if ( session.CustomerArray[25] Neq application.siteConfig.data.BaseCountry )
						getShipPrice.InternationalRate = getShipPrice.InternationalRate - (getShipPrice.InternationalRate * ShippingDiscount.Value/100) ;
					else
						getShipPrice.DomesticRate = getShipPrice.DomesticRate - (getShipPrice.DomesticRate * ShippingDiscount.Value/100) ;
				}
				else
				{
					if ( session.CustomerArray[25] Neq application.siteConfig.data.BaseCountry )
						getShipPrice.InternationalRate = getShipPrice.InternationalRate - ShippingDiscount.Value ;
					else
						getShipPrice.DomesticRate = getShipPrice.DomesticRate - ShippingDiscount.Value ;
				}
			</cfscript>
		</cfif>
		<!--- END: GET SHIPPING DISCOUNT --->
		
		<cfif session.CustomerArray[25] Neq application.siteConfig.data.BaseCountry >
			<input type="radio" name="JustForShow" checked> #application.siteConfig.data.StoreNameShort# International Shipping: <b>#LSCurrencyFormat(InternationalRate)#</b>
		<cfelse>
			<input type="radio" name="JustForShow" checked> #application.siteConfig.data.StoreNameShort# Shipping: <b>#LSCurrencyFormat(DomesticRate)#</b>
		</cfif>
		<input type="hidden" name="ShippingMethod#cpi#" value="Price">
	</cfoutput>
<!--- IF SHIPBY IS WEIGHT --->
<cfelseif application.siteConfig.data.ShipBy eq 2>
	<cfquery name="getShipPrice" datasource="#application.dsn#">				
		SELECT	InternationalRate, DomesticRate
		FROM	ShipWeight
		WHERE	Start	<	#Cart.CartWeight#
		and		Finish	>=	#Cart.CartWeight#
		and		SiteID = #application.siteConfig.data.SiteID#
	</cfquery>
	
	<cfoutput query="getShipPrice">
	
		<!--- BEGIN: GET SHIPPING DISCOUNT --->
		<cfif GlobalShipDiscount eq 0 >
			<!--- INVOKE INSTANCE OF OBJECT - GET PRODUCT PRICE, INCLUDING ANY DISCOUNTS --->
			<cfinvoke component="#application.Cart#" method="getShipDiscount" returnvariable="ShippingDiscount">
				<cfif session.CustomerArray[28] eq '' >
					<cfinvokeargument name="UserID" value="1">
				<cfelse>
					<cfinvokeargument name="UserID" value="#session.CustomerArray[28]#">
				</cfif>
				<cfinvokeargument name="SiteID" value="#application.siteConfig.data.SiteID#">
				<cfinvokeargument name="ShippingMethod" value="Weight">
				<cfinvokeargument name="SessionID" value="#SessionID#">
			</cfinvoke>
			
			<cfscript>
				if ( ShippingDiscount.ShipMethod eq 'Weight' )
				{
					if ( ShippingDiscount.Type eq 1 )
					{
						if ( session.CustomerArray[25] Neq application.siteConfig.data.BaseCountry )
							getShipPrice.InternationalRate = getShipPrice.InternationalRate - (getShipPrice.InternationalRate * ShippingDiscount.Value/100) ;
						else
							getShipPrice.DomesticRate = getShipPrice.DomesticRate - (getShipPrice.DomesticRate * ShippingDiscount.Value/100) ;
					}
					else
					{
						if ( session.CustomerArray[25] Neq application.siteConfig.data.BaseCountry )
							getShipPrice.InternationalRate = getShipPrice.InternationalRate - ShippingDiscount.Value ;
						else
							getShipPrice.DomesticRate = getShipPrice.DomesticRate - ShippingDiscount.Value ;
					}
				}
			</cfscript>
		<cfelse><!--- THERE IS AN AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS ---> 
			<cfscript>
				if ( ShippingDiscount.Type eq 1 )
				{
					if ( session.CustomerArray[25] Neq application.siteConfig.data.BaseCountry )
						getShipPrice.InternationalRate = getShipPrice.InternationalRate - (getShipPrice.InternationalRate * ShippingDiscount.Value/100) ;
					else
						getShipPrice.DomesticRate = getShipPrice.DomesticRate - (getShipPrice.DomesticRate * ShippingDiscount.Value/100) ;
				}
				else
				{
					if ( session.CustomerArray[25] Neq application.siteConfig.data.BaseCountry )
						getShipPrice.InternationalRate = getShipPrice.InternationalRate - ShippingDiscount.Value ;
					else
						getShipPrice.DomesticRate = getShipPrice.DomesticRate - ShippingDiscount.Value ;
				}
			</cfscript>
		</cfif>
		<!--- END: GET SHIPPING DISCOUNT --->
		
		<cfif session.CustomerArray[25] Neq application.siteConfig.data.BaseCountry >
			<input type="radio" name="JustForShow" checked> #application.siteConfig.data.StoreNameShort# International Shipping: <b>#LSCurrencyFormat(InternationalRate)#</b>
		<cfelse>
			<input type="radio" name="JustForShow" checked> #application.siteConfig.data.StoreNameShort# Shipping: <b>#LSCurrencyFormat(DomesticRate)#</b>
		</cfif>
		<input type="hidden" name="ShippingMethod#cpi#" value="Weight">
	</cfoutput>
--->
 
<!--- IF SHIPBY IS AUTOMATED --->
<cfelseif application.siteConfig.data.ShipBy eq 3>
	<cfinvoke component="#application.Queries#" method="getShippingMethods" returnvariable="getShippingMethods"></cfinvoke>
	<cfinvoke component="#application.Queries#" method="getShippingCos" returnvariable="getShippingCos">
		<cfinvokeargument name="SiteID" value="#application.siteConfig.data.SiteID#">
	</cfinvoke>
	
	<!--- IF USPS --->
	<cfif application.siteConfig.data.UseUSPS eq 1 >
		<cfset ShippingChoices = ShippingChoices + 1 >
		<cfif NOT isDefined('errorShippingUSPS') OR errorShippingUSPS Neq 1 >
			<cftry>
				<cfinclude template="Includes/ShippingUSPS.cfm">
				<cfcatch>
					<cftry>
						<cfinclude template="Includes/ShippingUSPS.cfm">
						<cfcatch>
							<cfset errorShippingUSPS = 1 >
						</cfcatch>
					</cftry>
				</cfcatch>
			</cftry>
		</cfif>							
	</cfif>	

	<!--- IF FEDEX --->
	<cfif application.siteConfig.data.UseFedEx eq 1 >
		<cfset ShippingChoices = ShippingChoices + 1 >
		<cfif NOT isDefined('errorShippingFEDEX') OR errorShippingFEDEX Neq 1 >
			<cftry>
				<cfinclude template="Includes/ShippingFEDEX.cfm">
				<cfcatch>
					<cftry>
						<cfinclude template="Includes/ShippingFEDEX.cfm">
						<cfcatch>
							<cfset errorShippingFEDEX = 1 >
						</cfcatch>
					</cftry>
				</cfcatch>
			</cftry>
		</cfif>
	</cfif>
	
	<!--- IF UPS --->
	<cfif application.siteConfig.data.UseUPS eq 1 >
		<cfset ShippingChoices = ShippingChoices + 1 >
		<cfif NOT isDefined('errorShippingUPS') OR errorShippingUPS Neq 1 >
			<cftry>
				<cfinclude template="Includes/ShippingUPS.cfm">
				<cfcatch>
					<cftry>
						<cfinclude template="Includes/ShippingUPS.cfm">
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
	<!--- BEGIN: ERROR HandLING --->
	<cfoutput>
	<cfif errorShippingUSPS eq 1 
		  and ( ShippingChoices GT 1 and ( errorShippingFedex eq 1 OR errorShippingUPS eq 1 ) 
		  OR  ( ShippingChoices LTE 1 ) ) > 
		<cfif session.CustomerArray[25] Neq application.siteConfig.data.BaseCountry >
			<cfinput type="radio" name="ShippingMethod#cpi#" value="Default" required="yes" message="Please select a shipping method" checked="yes"> Default International Shipping: <b>#LSCurrencyFormat(application.siteConfig.data.DefaultShipRateInt)#</b><br />
		<cfelse>
			<cfinput type="radio" name="ShippingMethod#cpi#" value="Default" required="yes" message="Please select a shipping method" checked="yes"> Default Shipping: <b>#LSCurrencyFormat(application.siteConfig.data.DefaultShipRateDom)#</b><br />
		</cfif>
	<cfelseif errorShippingFedex eq 1 
		  and ( ShippingChoices GT 1 and ( errorShippingUSPS eq 1 OR errorShippingUPS eq 1 ) 
		  OR  ( ShippingChoices LTE 1 ) ) > 
		<cfif session.CustomerArray[25] Neq application.siteConfig.data.BaseCountry >
			<cfinput type="radio" name="ShippingMethod#cpi#" value="Default" required="yes" message="Please select a shipping method" checked="yes"> Default International Shipping: <b>#LSCurrencyFormat(application.siteConfig.data.DefaultShipRateInt)#</b><br />
		<cfelse>
			<cfinput type="radio" name="ShippingMethod#cpi#" value="Default" required="yes" message="Please select a shipping method" checked="yes"> Default Shipping: <b>#LSCurrencyFormat(application.siteConfig.data.DefaultShipRateDom)#</b><br />
		</cfif>
	<cfelseif errorShippingUPS eq 1 
		  and ( ShippingChoices GT 1 and ( errorShippingFedex eq 1 OR errorShippingUSPS eq 1 ) 
		  OR  ( ShippingChoices LTE 1 ) ) > 
		<cfif session.CustomerArray[25] Neq application.siteConfig.data.BaseCountry >
			<cfinput type="radio" name="ShippingMethod#cpi#" value="Default" required="yes" message="Please select a shipping method" checked="yes"> Default International Shipping: <b>#LSCurrencyFormat(application.siteConfig.data.DefaultShipRateInt)#</b><br />
		<cfelse>
			<cfinput type="radio" name="ShippingMethod#cpi#" value="Default" required="yes" message="Please select a shipping method" checked="yes"> Default Shipping: <b>#LSCurrencyFormat(application.siteConfig.data.DefaultShipRateDom)#</b><br />
		</cfif>
	</cfif>
	</cfoutput>
	<!--- END: ERROR HandLING --->
	
	
<!--- SHIPBY REGION/GEOGRAPHY --->	
<cfelseif application.siteConfig.data.ShipBy eq 4 >
	<cfif session.CustomerArray[25] eq application.siteConfig.data.BaseCountry >
		<cfquery name="getRate" datasource="#application.dsn#">
			SELECT 	*
			FROM 	States
			WHERE 	StateCode = '#session.CustomerArray[23]#'
		</cfquery>
		<cfscript>
			if ( GetRate.S_Rate eq '' or GetRate.S_Rate eq 0 )
				ShippingPrice = application.siteConfig.data.DefaultShipRateDom ;
			else
				ShippingPrice = GetRate.S_Rate ;
		</cfscript>
	<cfelse>
		<cfquery name="getRate" datasource="#application.dsn#">
			SELECT 	*
			FROM	countries
			WHERE	Country = '#session.CustomerArray[25]#'
		</cfquery>
		<cfscript>
			if ( GetRate.S_Rate eq '' or GetRate.S_Rate eq 0 )
				ShippingPrice = application.siteConfig.data.DefaultShipRateInt ;
			else
				ShippingPrice = GetRate.S_Rate ;
		</cfscript>
	</cfif>
	
	<!--- BEGIN: GET SHIPPING DISCOUNT --->
	<cfif GlobalShipDiscount eq 0 >
		<!--- INVOKE INSTANCE OF OBJECT - GET PRODUCT PRICE, INCLUDING ANY DISCOUNTS --->
		<cfinvoke component="#application.Cart#" method="getShipDiscount" returnvariable="ShippingDiscount">
			<cfif session.CustomerArray[28] eq '' >
				<cfinvokeargument name="UserID" value="1">
			<cfelse>
				<cfinvokeargument name="UserID" value="#session.CustomerArray[28]#">
			</cfif>
			<cfinvokeargument name="SiteID" value="#application.siteConfig.data.SiteID#">
			<cfinvokeargument name="ShippingMethod" value="Location">
			<cfinvokeargument name="SessionID" value="#SessionID#">
		</cfinvoke>
		
		<cfscript>
			if ( ShippingDiscount.ShipMethod eq 'Location' )
			{
				if ( ShippingDiscount.Type eq 1 )
					ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
				else
					ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
			}
		</cfscript>
	<cfelse><!--- THERE IS AN AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS ---> 
		<cfscript>
			if ( ShippingDiscount.Type eq 1 )
				ShippingPrice = ShippingPrice - (ShippingPrice * ShippingDiscount.Value/100) ;
			else
				ShippingPrice = ShippingPrice - ShippingDiscount.Value ;
		</cfscript>
	</cfif>
	<!--- END: GET SHIPPING DISCOUNT --->
		
	<cfoutput>
		<cfif session.CustomerArray[25] Neq application.siteConfig.data.BaseCountry >
			<input type="radio" name="JustForShow" checked> #application.siteConfig.data.StoreNameShort# International Shipping: <b>#LSCurrencyFormat(ShippingPrice)#</b>
		<cfelse>
			<input type="radio" name="JustForShow" checked> #application.siteConfig.data.StoreNameShort# Shipping: <b>#LSCurrencyFormat(ShippingPrice)#</b>
		</cfif>
		<input type="hidden" name="ShippingMethod#cpi#" value="Location">
	</cfoutput>
	

<!--- SHIPBY CUSTOM SHIPPING OPTIONS: WEIGHT --->
<cfelseif application.siteConfig.data.ShipBy eq 5 >
	<cfquery name="getCustomShipping" datasource="#application.dsn#">
		SELECT 	*
		FROM	ShippingMethods
		WHERE	ShipWeightLo < #Cart.CartWeight#
		and		ShipWeightHi >=	#Cart.CartWeight#
		and		(ShipWeightLo > 0 OR ShipWeightHi > 0)
		and		SiteID = #application.siteConfig.data.SiteID#
		and		ShippingCompany = 'Custom'
		<cfif   session.CustomerArray[25] eq application.siteConfig.data.BaseCountry >
		and		International != 1
		<cfelse>
		and		International = 1
		</cfif>
		ORDER BY ShippingMessage
	</cfquery>
	
	<cfif getCustomShipping.RecordCount Neq 0 >
		<cfoutput query="getCustomShipping">
			<!--- BEGIN: GET SHIPPING DISCOUNT --->
			<cfif GlobalShipDiscount eq 0 >
				<!--- INVOKE INSTANCE OF OBJECT - GET PRODUCT PRICE, INCLUDING ANY DISCOUNTS --->
				<cfinvoke component="#application.Cart#" method="getShipDiscount" returnvariable="ShippingDiscount">
					<cfif session.CustomerArray[28] eq '' >
						<cfinvokeargument name="UserID" value="1">
					<cfelse>
						<cfinvokeargument name="UserID" value="#session.CustomerArray[28]#">
					</cfif>
					<cfinvokeargument name="SiteID" value="#application.siteConfig.data.SiteID#">
					<cfinvokeargument name="ShippingMethod" value="Weight">
					<cfinvokeargument name="SessionID" value="#SessionID#">
				</cfinvoke>
				
				<cfscript>
					if ( ShippingDiscount.ShipMethod eq 'Weight' )
					{
						if ( ShippingDiscount.Type eq 1 )
							ShipPrice = ShipPrice - (ShipPrice * ShippingDiscount.Value/100) ;
						else
							ShipPrice = ShipPrice - ShippingDiscount.Value ;		
					}
				</cfscript>
			<cfelse><!--- THERE IS AN AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS ---> 
				<cfscript>
					if ( ShippingDiscount.Type eq 1 )
						ShipPrice = ShipPrice - (ShipPrice * ShippingDiscount.Value/100) ;
					else
						ShipPrice = ShipPrice - ShippingDiscount.Value ;
				</cfscript>
			</cfif>
			<!--- END: GET SHIPPING DISCOUNT --->
			<cfif getCustomShipping.RecordCount eq 1>
				<cfinput type="radio" name="ShippingMethod#cpi#" value="#ShippingCode#" required="yes" message="Please select a shipping method" checked="yes"> #ShippingMessage#: <b>#LSCurrencyFormat(ShipPrice)#</b><br />
			<cfelse>
				<cfinput type="radio" name="ShippingMethod#cpi#" value="#ShippingCode#" required="yes" message="Please select a shipping method" checked="no" > #ShippingMessage#: <b>#LSCurrencyFormat(ShipPrice)#</b><br />
			</cfif>
		</cfoutput>
	<cfelse>
		<cfif session.CustomerArray[25] Neq application.siteConfig.data.BaseCountry >
			<!--- BEGIN: GET SHIPPING DISCOUNT --->
			<cfif GlobalShipDiscount eq 0 >
				<!--- INVOKE INSTANCE OF OBJECT - GET PRODUCT PRICE, INCLUDING ANY DISCOUNTS --->
				<cfinvoke component="#application.Cart#" method="getShipDiscount" returnvariable="ShippingDiscount">
					<cfif session.CustomerArray[28] eq '' >
						<cfinvokeargument name="UserID" value="1">
					<cfelse>
						<cfinvokeargument name="UserID" value="#session.CustomerArray[28]#">
					</cfif>
					<cfinvokeargument name="SiteID" value="#application.siteConfig.data.SiteID#">
					<cfinvokeargument name="ShippingMethod" value="Weight">
					<cfinvokeargument name="SessionID" value="#SessionID#">
				</cfinvoke>
				
				<cfscript>
					if ( ShippingDiscount.ShipMethod eq 'Weight' )
					{
						if ( ShippingDiscount.Type eq 1 )
							application.siteConfig.data.DefaultShipRateInt = application.siteConfig.data.DefaultShipRateInt - (application.siteConfig.data.DefaultShipRateInt * ShippingDiscount.Value/100) ;
						else
							application.siteConfig.data.DefaultShipRateInt = application.siteConfig.data.DefaultShipRateInt - ShippingDiscount.Value ;		
					}
				</cfscript>
			<cfelse><!--- THERE IS AN AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS ---> 
				<cfscript>
					if ( ShippingDiscount.Type eq 1 )
						application.siteConfig.data.DefaultShipRateInt = application.siteConfig.data.DefaultShipRateInt - (application.siteConfig.data.DefaultShipRateInt * ShippingDiscount.Value/100) ;
					else
						application.siteConfig.data.DefaultShipRateInt = application.siteConfig.data.DefaultShipRateInt - ShippingDiscount.Value ;
				</cfscript>
			</cfif>
			<!--- END: GET SHIPPING DISCOUNT --->
			<cfoutput>
			<cfinput type="radio" name="ShippingMethod#cpi#" value="Default" required="yes" message="Please select a shipping method" checked="yes"> Default Int'l Shipping: <b>#LSCurrencyFormat(application.siteConfig.data.DefaultShipRateInt)#</b><br />
			</cfoutput>
		<cfelse>
			<!--- BEGIN: GET SHIPPING DISCOUNT --->
			<cfif GlobalShipDiscount eq 0 >
				<!--- INVOKE INSTANCE OF OBJECT - GET PRODUCT PRICE, INCLUDING ANY DISCOUNTS --->
				<cfinvoke component="#application.Cart#" method="getShipDiscount" returnvariable="ShippingDiscount">
					<cfif session.CustomerArray[28] eq '' >
						<cfinvokeargument name="UserID" value="1">
					<cfelse>
						<cfinvokeargument name="UserID" value="#session.CustomerArray[28]#">
					</cfif>
					<cfinvokeargument name="SiteID" value="#application.siteConfig.data.SiteID#">
					<cfinvokeargument name="ShippingMethod" value="Weight">
					<cfinvokeargument name="SessionID" value="#SessionID#">
				</cfinvoke>
				
				<cfscript>
					if ( ShippingDiscount.ShipMethod eq 'Weight' )
					{
						if ( ShippingDiscount.Type eq 1 )
							application.siteConfig.data.DefaultShipRateDom = application.siteConfig.data.DefaultShipRateDom - (application.siteConfig.data.DefaultShipRateDom * ShippingDiscount.Value/100) ;
						else
							application.siteConfig.data.DefaultShipRateDom = application.siteConfig.data.DefaultShipRateDom - ShippingDiscount.Value ;		
					}
				</cfscript>
			<cfelse><!--- THERE IS AN AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS ---> 
				<cfscript>
					if ( ShippingDiscount.Type eq 1 )
						application.siteConfig.data.DefaultShipRateDom = application.siteConfig.data.DefaultShipRateDom - (application.siteConfig.data.DefaultShipRateDom * ShippingDiscount.Value/100) ;
					else
						application.siteConfig.data.DefaultShipRateDom = application.siteConfig.data.DefaultShipRateDom - ShippingDiscount.Value ;
				</cfscript>
			</cfif>
			<!--- END: GET SHIPPING DISCOUNT --->
			<cfoutput>
			<cfinput type="radio" name="ShippingMethod#cpi#" value="Default" required="yes" message="Please select a shipping method" checked="yes"> Default Shipping: <b>#LSCurrencyFormat(application.siteConfig.data.DefaultShipRateDom)#</b><br />
			</cfoutput>
		</cfif>
	</cfif>
	
	
<!--- SHIPBY CUSTOM SHIPPING OPTIONS: PRICE --->	
<cfelseif application.siteConfig.data.ShipBy eq 6 >
	<cfquery name="getCustomShipping" datasource="#application.dsn#">
		SELECT 	*
		FROM	ShippingMethods
		WHERE	ShipPriceLo <  #Cart.CartTotal#
		and		ShipPriceHi >= #Cart.CartTotal#
		and		(ShipPriceLo > 0 OR ShipPriceHi > 0)
		and		SiteID = #application.siteConfig.data.SiteID#
		and		ShippingCompany = 'Custom'
		<cfif   session.CustomerArray[25] eq application.siteConfig.data.BaseCountry >
		and		International != 1
		<cfelse>
		and		International = 1
		</cfif>
		ORDER BY ShippingMessage
	</cfquery>
	
	<cfif getCustomShipping.RecordCount Neq 0 >
		<cfoutput query="getCustomShipping">
			<!--- BEGIN: GET SHIPPING DISCOUNT --->
			<cfif GlobalShipDiscount eq 0 >
				<!--- INVOKE INSTANCE OF OBJECT - GET PRODUCT PRICE, INCLUDING ANY DISCOUNTS --->
				<cfinvoke component="#application.Cart#" method="getShipDiscount" returnvariable="ShippingDiscount">
					<cfif session.CustomerArray[28] eq '' >
						<cfinvokeargument name="UserID" value="1">
					<cfelse>
						<cfinvokeargument name="UserID" value="#session.CustomerArray[28]#">
					</cfif>
					<cfinvokeargument name="SiteID" value="#application.siteConfig.data.SiteID#">
					<cfinvokeargument name="ShippingMethod" value="Price">
					<cfinvokeargument name="SessionID" value="#SessionID#">
				</cfinvoke>
				
				<cfscript>
					if ( ShippingDiscount.ShipMethod eq 'Price' )
					{
						if ( ShippingDiscount.Type eq 1 )
							ShipPrice = ShipPrice - (ShipPrice * ShippingDiscount.Value/100) ;
						else
							ShipPrice = ShipPrice - ShippingDiscount.Value ;		
					}
				</cfscript>
			<cfelse><!--- THERE IS AN AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS ---> 
				<cfscript>
					if ( ShippingDiscount.Type eq 1 )
						ShipPrice = ShipPrice - (ShipPrice * ShippingDiscount.Value/100) ;
					else
						ShipPrice = ShipPrice - ShippingDiscount.Value ;
				</cfscript>
			</cfif>
			<!--- END: GET SHIPPING DISCOUNT --->
			<cfif getCustomShipping.RecordCount eq 1>
				<cfinput type="radio" name="ShippingMethod#cpi#" value="#ShippingCode#" required="yes" message="Please select a shipping method" checked="yes"> #ShippingMessage#: <b>#LSCurrencyFormat(ShipPrice)#</b><br />
			<cfelse>
				<cfinput type="radio" name="ShippingMethod#cpi#" value="#ShippingCode#" required="yes" message="Please select a shipping method" checked="no" > #ShippingMessage#: <b>#LSCurrencyFormat(ShipPrice)#</b><br />
			</cfif>
		</cfoutput>
	<cfelse>
		<cfif session.CustomerArray[25] Neq application.siteConfig.data.BaseCountry >
			<!--- BEGIN: GET SHIPPING DISCOUNT --->
			<cfif GlobalShipDiscount eq 0 >
				<!--- INVOKE INSTANCE OF OBJECT - GET PRODUCT PRICE, INCLUDING ANY DISCOUNTS --->
				<cfinvoke component="#application.Cart#" method="getShipDiscount" returnvariable="ShippingDiscount">
					<cfif session.CustomerArray[28] eq '' >
						<cfinvokeargument name="UserID" value="1">
					<cfelse>
						<cfinvokeargument name="UserID" value="#session.CustomerArray[28]#">
					</cfif>
					<cfinvokeargument name="SiteID" value="#application.siteConfig.data.SiteID#">
					<cfinvokeargument name="ShippingMethod" value="Weight">
					<cfinvokeargument name="SessionID" value="#SessionID#">
				</cfinvoke>
				
				<cfscript>
					if ( ShippingDiscount.ShipMethod eq 'Weight' )
					{
						if ( ShippingDiscount.Type eq 1 )
							application.siteConfig.data.DefaultShipRateInt = application.siteConfig.data.DefaultShipRateInt - (application.siteConfig.data.DefaultShipRateInt * ShippingDiscount.Value/100) ;
						else
							application.siteConfig.data.DefaultShipRateInt = application.siteConfig.data.DefaultShipRateInt - ShippingDiscount.Value ;		
					}
				</cfscript>
			<cfelse><!--- THERE IS AN AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS ---> 
				<cfscript>
					if ( ShippingDiscount.Type eq 1 )
						application.siteConfig.data.DefaultShipRateInt = application.siteConfig.data.DefaultShipRateInt - (application.siteConfig.data.DefaultShipRateInt * ShippingDiscount.Value/100) ;
					else
						application.siteConfig.data.DefaultShipRateInt = application.siteConfig.data.DefaultShipRateInt - ShippingDiscount.Value ;
				</cfscript>
			</cfif>
			<!--- END: GET SHIPPING DISCOUNT --->
			<cfoutput>
			<cfinput type="radio" name="ShippingMethod#cpi#" value="Default" required="yes" message="Please select a shipping method" checked="yes"> Default Int'l Shipping: <b>#LSCurrencyFormat(application.siteConfig.data.DefaultShipRateInt)#</b><br />
			</cfoutput>
		<cfelse>
			<!--- BEGIN: GET SHIPPING DISCOUNT --->
			<cfif GlobalShipDiscount eq 0 >
				<!--- INVOKE INSTANCE OF OBJECT - GET PRODUCT PRICE, INCLUDING ANY DISCOUNTS --->
				<cfinvoke component="#application.Cart#" method="getShipDiscount" returnvariable="ShippingDiscount">
					<cfif session.CustomerArray[28] eq '' >
						<cfinvokeargument name="UserID" value="1">
					<cfelse>
						<cfinvokeargument name="UserID" value="#session.CustomerArray[28]#">
					</cfif>
					<cfinvokeargument name="SiteID" value="#application.siteConfig.data.SiteID#">
					<cfinvokeargument name="ShippingMethod" value="Weight">
					<cfinvokeargument name="SessionID" value="#SessionID#">
				</cfinvoke>
				
				<cfscript>
					if ( ShippingDiscount.ShipMethod eq 'Weight' )
					{
						if ( ShippingDiscount.Type eq 1 )
							application.siteConfig.data.DefaultShipRateDom = application.siteConfig.data.DefaultShipRateDom - (application.siteConfig.data.DefaultShipRateDom * ShippingDiscount.Value/100) ;
						else
							application.siteConfig.data.DefaultShipRateDom = application.siteConfig.data.DefaultShipRateDom - ShippingDiscount.Value ;		
					}
				</cfscript>
			<cfelse><!--- THERE IS AN AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS ---> 
				<cfscript>
					if ( ShippingDiscount.Type eq 1 )
						application.siteConfig.data.DefaultShipRateDom = application.siteConfig.data.DefaultShipRateDom - (application.siteConfig.data.DefaultShipRateDom * ShippingDiscount.Value/100) ;
					else
						application.siteConfig.data.DefaultShipRateDom = application.siteConfig.data.DefaultShipRateDom - ShippingDiscount.Value ;
				</cfscript>
			</cfif>
			<!--- END: GET SHIPPING DISCOUNT --->
			<cfoutput>
			<cfinput type="radio" name="ShippingMethod#cpi#" value="Default" required="yes" message="Please select a shipping method" checked="yes"> Default Shipping: <b>#LSCurrencyFormat(application.siteConfig.data.DefaultShipRateDom)#</b><br />
			</cfoutput>
		</cfif>
	</cfif>


<!--- SHIPBY RETAIL PRO --->
<cfelseif application.siteConfig.data.ShipBy eq 7 >
	
	<cfquery name="getShippingCodes" datasource="#application.dsn#" >
		SELECT	*
		FROM	ShippingCodes
	</cfquery>
	<cfscript>
		RPTotalWeight = 0 ;
		RPShipPriceAdd = 0 ;
		RPShipCodeUsed = 0 ;
	</cfscript>
	
	<cfloop query="getCartItems.data">
		<cfif fldShipByWeight eq true >
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
			<cfif checkShippingCode.RecordCount Neq 0 >
				<cfif RPShipCodeUsed Neq 1 >
					<cfscript>
						RPShipCodeUsed = 1 ;
						RPShipCode = checkShippingCode.ShippingCode ;
					</cfscript>
				</cfif>
			<!--- NO MESSAGE, CONTINUE ADDING ADDITIONAL SHIPPING/HandLING --->
			<cfelse>
				<cfscript>
					RPShipPriceAdd = RPShipPriceAdd + (DecimalFormat(fldShipAmount) + DecimalFormat(fldHandAmount)) ;
				</cfscript>
			</cfif>
		</cfif>
	</cfloop>
	
	<cfquery name="getCustomShipping" datasource="#application.dsn#">
		SELECT 	*
		FROM	ShippingMethods
		WHERE	ShipWeightLo < #RPTotalWeight#
		and		ShipWeightHi >=	#RPTotalWeight#
		and		(ShipWeightLo > 0 OR ShipWeightHi > 0)
		and		SiteID = #application.siteConfig.data.SiteID#
		and		ShippingCompany = 'Custom'
		<cfif   session.CustomerArray[25] eq application.siteConfig.data.BaseCountry >
		and		International != 1
		<cfelse>
		and		International = 1
		</cfif>
		ORDER BY ShippingMessage
	</cfquery>
	
	<!--- CALCULATE SHIPPING --->
	<cfif getCustomShipping.RecordCount Neq 0 >
		<cfoutput query="getCustomShipping">

			<cfset getCustomShipping.ShipPrice = getCustomShipping.ShipPrice + RPShipPriceAdd >

			<!--- BEGIN: GET SHIPPING DISCOUNT --->
			<cfif GlobalShipDiscount eq 0 >
				<!--- INVOKE INSTANCE OF OBJECT - GET PRODUCT PRICE, INCLUDING ANY DISCOUNTS --->
				<cfinvoke component="#application.Cart#" method="getShipDiscount" returnvariable="ShippingDiscount">
					<cfif session.CustomerArray[28] eq '' >
						<cfinvokeargument name="UserID" value="1">
					<cfelse>
						<cfinvokeargument name="UserID" value="#session.CustomerArray[28]#">
					</cfif>
					<cfinvokeargument name="SiteID" value="#application.siteConfig.data.SiteID#">
					<cfinvokeargument name="ShippingMethod" value="Weight">
					<cfinvokeargument name="SessionID" value="#SessionID#">
				</cfinvoke>
				
				<cfscript>
					if ( ShippingDiscount.ShipMethod eq 'Weight' )
					{
						if ( ShippingDiscount.Type eq 1 )
							ShipPrice = ShipPrice - (ShipPrice * ShippingDiscount.Value/100) ;
						else
							ShipPrice = ShipPrice - ShippingDiscount.Value ;		
					}
				</cfscript>
			<cfelse><!--- THERE IS AN AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS ---> 
				<cfscript>
					if ( ShippingDiscount.Type eq 1 )
						ShipPrice = ShipPrice - (ShipPrice * ShippingDiscount.Value/100) ;
					else
						ShipPrice = ShipPrice - ShippingDiscount.Value ;
				</cfscript>
			</cfif>
			<!--- END: GET SHIPPING DISCOUNT --->
			<cfif getCustomShipping.RecordCount eq 1>
				<cfinput type="radio" name="ShippingMethod#cpi#" value="#ShippingCode#" required="yes" message="Please select a shipping method" checked="yes"> #ShippingMessage#: <b>#LSCurrencyFormat(ShipPrice)#</b> <cfif RPShipCodeUsed eq 1 ><font class="cfAttract">*</font></cfif><br />
			<cfelse>
				<cfinput type="radio" name="ShippingMethod#cpi#" value="#ShippingCode#" required="yes" message="Please select a shipping method" checked="no" > #ShippingMessage#: <b>#LSCurrencyFormat(ShipPrice)#</b> <cfif RPShipCodeUsed eq 1 ><font class="cfAttract">*</font></cfif><br />
			</cfif>
		</cfoutput>
	<!--- NO ITEMS IN CART ARE CALCULATED BY WEIGHT --->
	<cfelseif RPShipPriceAdd GT 0 >
		<!--- BEGIN: GET SHIPPING DISCOUNT --->
		<cfif GlobalShipDiscount eq 0 >
			<!--- INVOKE INSTANCE OF OBJECT - GET PRODUCT PRICE, INCLUDING ANY DISCOUNTS --->
			<cfinvoke component="#application.Cart#" method="getShipDiscount" returnvariable="ShippingDiscount">
				<cfif session.CustomerArray[28] eq '' >
					<cfinvokeargument name="UserID" value="1">
				<cfelse>
					<cfinvokeargument name="UserID" value="#session.CustomerArray[28]#">
				</cfif>
				<cfinvokeargument name="SiteID" value="#application.siteConfig.data.SiteID#">
				<cfinvokeargument name="ShippingMethod" value="Weight">
				<cfinvokeargument name="SessionID" value="#SessionID#">
			</cfinvoke>
			
			<cfscript>
				if ( ShippingDiscount.ShipMethod eq 'Weight' )
				{
					if ( ShippingDiscount.Type eq 1 )
						RPShipPriceAdd = RPShipPriceAdd - (RPShipPriceAdd * ShippingDiscount.Value/100) ;
					else
						RPShipPriceAdd = RPShipPriceAdd - ShippingDiscount.Value ;		
				}
			</cfscript>
		<cfelse><!--- THERE IS AN AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS ---> 
			<cfscript>
				if ( ShippingDiscount.Type eq 1 )
					RPShipPriceAdd = RPShipPriceAdd - (RPShipPriceAdd * ShippingDiscount.Value/100) ;
				else
					RPShipPriceAdd = RPShipPriceAdd - ShippingDiscount.Value ;
			</cfscript>
		</cfif>
		<!--- END: GET SHIPPING DISCOUNT --->
		<cfoutput>
		<cfinput type="radio" name="ShippingMethod#cpi#" value="Default" required="yes" message="Please select a shipping method" checked="yes"> Special Shipping: <b>#LSCurrencyFormat(RPShipPriceAdd)#</b> <cfif RPShipCodeUsed eq 1 ><font class="cfAttract">*</font></cfif><br />
		</cfoutput>
	<!--- USE DEFAULT, AS LONG AS NO ITEMS IN CART HAVE SPECIAL SHIPPING CODE --->
	<cfelseif RPShipCodeUsed eq 0 >
		<cfif session.CustomerArray[25] Neq application.siteConfig.data.BaseCountry >

			<cfset application.siteConfig.data.DefaultShipRateInt = application.siteConfig.data.DefaultShipRateInt + RPShipPriceAdd >

			<!--- BEGIN: GET SHIPPING DISCOUNT --->
			<cfif GlobalShipDiscount eq 0 >
				<!--- INVOKE INSTANCE OF OBJECT - GET PRODUCT PRICE, INCLUDING ANY DISCOUNTS --->
				<cfinvoke component="#application.Cart#" method="getShipDiscount" returnvariable="ShippingDiscount">
					<cfif session.CustomerArray[28] eq '' >
						<cfinvokeargument name="UserID" value="1">
					<cfelse>
						<cfinvokeargument name="UserID" value="#session.CustomerArray[28]#">
					</cfif>
					<cfinvokeargument name="SiteID" value="#application.siteConfig.data.SiteID#">
					<cfinvokeargument name="ShippingMethod" value="Weight">
					<cfinvokeargument name="SessionID" value="#SessionID#">
				</cfinvoke>
				
				<cfscript>
					if ( ShippingDiscount.ShipMethod eq 'Weight' )
					{
						if ( ShippingDiscount.Type eq 1 )
							application.siteConfig.data.DefaultShipRateInt = application.siteConfig.data.DefaultShipRateInt - (application.siteConfig.data.DefaultShipRateInt * ShippingDiscount.Value/100) ;
						else
							application.siteConfig.data.DefaultShipRateInt = application.siteConfig.data.DefaultShipRateInt - ShippingDiscount.Value ;		
					}
				</cfscript>
			<cfelse><!--- THERE IS AN AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS ---> 
				<cfscript>
					if ( ShippingDiscount.Type eq 1 )
						application.siteConfig.data.DefaultShipRateInt = application.siteConfig.data.DefaultShipRateInt - (application.siteConfig.data.DefaultShipRateInt * ShippingDiscount.Value/100) ;
					else
						application.siteConfig.data.DefaultShipRateInt = application.siteConfig.data.DefaultShipRateInt - ShippingDiscount.Value ;
				</cfscript>
			</cfif>
			<!--- END: GET SHIPPING DISCOUNT --->
			<cfoutput>
			<cfinput type="radio" name="ShippingMethod#cpi#" value="Default" required="yes" message="Please select a shipping method" checked="yes"> Default Int'l Shipping: <b>#LSCurrencyFormat(application.siteConfig.data.DefaultShipRateInt)#</b> <cfif RPShipCodeUsed eq 1 ><font class="cfAttract">*</font></cfif><br />
			</cfoutput>
		<cfelse>

			<cfset application.siteConfig.data.DefaultShipRateDom = application.siteConfig.data.DefaultShipRateDom + RPShipPriceAdd >

			<!--- BEGIN: GET SHIPPING DISCOUNT --->
			<cfif GlobalShipDiscount eq 0 >
				<!--- INVOKE INSTANCE OF OBJECT - GET PRODUCT PRICE, INCLUDING ANY DISCOUNTS --->
				<cfinvoke component="#application.Cart#" method="getShipDiscount" returnvariable="ShippingDiscount">
					<cfif session.CustomerArray[28] eq '' >
						<cfinvokeargument name="UserID" value="1">
					<cfelse>
						<cfinvokeargument name="UserID" value="#session.CustomerArray[28]#">
					</cfif>
					<cfinvokeargument name="SiteID" value="#application.siteConfig.data.SiteID#">
					<cfinvokeargument name="ShippingMethod" value="Weight">
					<cfinvokeargument name="SessionID" value="#SessionID#">
				</cfinvoke>
				
				<cfscript>
					if ( ShippingDiscount.ShipMethod eq 'Weight' )
					{
						if ( ShippingDiscount.Type eq 1 )
							application.siteConfig.data.DefaultShipRateDom = application.siteConfig.data.DefaultShipRateDom - (application.siteConfig.data.DefaultShipRateDom * ShippingDiscount.Value/100) ;
						else
							application.siteConfig.data.DefaultShipRateDom = application.siteConfig.data.DefaultShipRateDom - ShippingDiscount.Value ;		
					}
				</cfscript>
			<cfelse><!--- THERE IS AN AUTOMATIC DISCOUNT FOR ALL SHIPPING METHODS ---> 
				<cfscript>
					if ( ShippingDiscount.Type eq 1 )
						application.siteConfig.data.DefaultShipRateDom = application.siteConfig.data.DefaultShipRateDom - (application.siteConfig.data.DefaultShipRateDom * ShippingDiscount.Value/100) ;
					else
						application.siteConfig.data.DefaultShipRateDom = application.siteConfig.data.DefaultShipRateDom - ShippingDiscount.Value ;
				</cfscript>
			</cfif>
			<!--- END: GET SHIPPING DISCOUNT --->
			<cfoutput>
			<cfinput type="radio" name="ShippingMethod#cpi#" value="Default" required="yes" message="Please select a shipping method" checked="yes"> Default Shipping: <b>#LSCurrencyFormat(application.siteConfig.data.DefaultShipRateDom)#</b> <cfif RPShipCodeUsed eq 1 ><font class="cfAttract">*</font></cfif><br />
			</cfoutput>
		</cfif>
	<!--- ALL ITEMS IN CART HAVE SPECIAL SHIPPING CODES --->
	<cfelse>
		<cfinput type="radio" name="ShippingMethod#cpi#" value="Default" required="yes" message="Please select a shipping method" checked="yes"> <b>Special Shipping Required...</b><br />
	</cfif>
	
	<cfif RPShipCodeUsed eq 1 >
		<div style="padding-left:6px; padding-right:20px;" class="cfAttract">
			<br />
			<u>* SHIPPING NOTES *</u><br />
			<cfoutput>#checkShippingCode.ShippingMessage#</cfoutput>
		</div>
	</cfif>
	
</cfif><!--- application.siteConfig.data.ShipBy --->
	</td>
</tr>
<tr>
	<td colspan="2"><hr size="1" style="margin:0; padding:0; width:100%" /></td>
</tr>
</cfloop><!--- Cart.Packages --->
--->


					<tr>
						<td colspan="2" height="20">&nbsp;</td>
					</tr>
				</cfif>
			</table>
			</td>
		</tr>
	</table>
</td>
		
		<td width="1%">&nbsp;</td>
		
		<!--- DISCOUNTS & GIFT CARDS --->
		<td width="50%" valign="top">
			<table width="100%" class="cartLayoutTable">
			<tr>
			<th align="center">Discounts & Gift Cards</th>
			<tr>
			<td align="center" height="200" valign="top">
			<table width="100%" cellpadding="3" cellspacing="0" border="0">	
				<!--- DISCOUNT OR GIFT CERTIFICATE CODE --->
				<tr><td colspan="2">&nbsp;</td></tr>
				<tr>
					<td class="cfFormLabel" align="right">
						<b>Discount or Gift Certificate Code:</b><br>
						(Affiliate IDs may be used here)
					</td>
					<td><input type="text" name="DiscountCode" size="20" class="cfFormField"></td>
				</tr>
				<tr><td colspan="2">&nbsp;</td></tr>
				<tr>
					<td class="cfFormLabel" colspan="2"><img src="images/spacer.gif" height="46" width="1" /></td>
				</tr>
			</table>
			</td></tr></table>
		</td>
	</tr>
</table>
<br />
<table width="98%" align="center" cellpadding="0" cellspacing="0" border="0">
	<tr>
		<td width="100%" align="center">
			<input type="submit" name="Step3" value=" Proceed to Step 3 >>" class="button">
			<!--- CARTFUSION 4.6 --->
			<cfif trim(application.siteConfig.data.ShippingNotes) Neq '' >
			<br /><br /><br />#application.siteConfig.data.ShippingNotes#
			</cfif>
			<!--- CARTFUSION 4.6 --->
		</td>
	</tr>
</table>
</cfform>

</cfmodule>
</cfoutput>