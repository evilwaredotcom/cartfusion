   
<!--- Initialize variables --->
<cfscript>
	TaxRate = 0 ;
	TaxPrice = 0 ;
	QueryForTax = 0 ;
	TaxableTotal = 0 ;
</cfscript>

<cfquery name="getUTaxable" datasource="#application.dsn#">
	SELECT	UTaxable
	FROM	Users
	WHERE	UID = #session.CustomerArray[28]#
</cfquery>

<cfif getUTaxable.UTaxable EQ 1 ><!--- APPLY TO TAXABLE USERS --->
	
	<cfscript>
		// DOMESTIC CUSTOMERS
		if ( application.BaseCountry EQ session.CustomerArray[8] )	{
			if ( application.UseFlatTaxRate EQ 1 )
				TaxRate = application.FlatTaxRate ;
			else
				QueryForTax = 1 ;
		}
		// INTERNATIONAL CUSTOMERS
		else if ( application.IntTaxCharge EQ 1 )
		{
			TaxRate = application.FlatTaxRate ;
		}
		else	{
			TaxRate = 0 ;
		}		
	</cfscript>
	
	<cfif QueryForTax EQ 1 >
		<cfquery name="GetTaxRate" datasource="#application.dsn#" cachedwithin="#CreateTimeSpan(0,0,30,0)#">
			SELECT	T_Rate
			FROM 	States
			WHERE 	StateCode = '#session.CustomerArray[6]#'
		</cfquery>
		<cfset TaxRate = NumberFormat(GetTaxRate.T_Rate,0.00) >
	</cfif>
	
	<!--- APPLY TAX RATE TO TAXABLE TOTAL IN CART --->
	<cfif TaxRate NEQ 0 >
		
		<!--- INVOKE INSTANCE OF OBJECT - GET CART ITEMS --->
		<!--- CARTFUSION 4.6 - CART CFC --->
		<cfscript>
			if ( TRIM(session.CustomerArray[28]) NEQ '' ) {
				UserID = session.CustomerArray[28] ;
			} else {
				UserID = 1 ;
			}
			getCartItems = application.Cart.getCartItems(UserID=UserID,SiteID=application.SiteID,SessionID=SessionID) ;
		</cfscript>
		
		<cfloop query="getCartItems.data">		
			<cfscript>
				UseThisPrice = application.Cart.getItemPrice(
					UserID=UserID,
					SiteID=application.SiteID,
					ItemID=ItemID,
					SessionID=SessionID,
					OptionName1=OptionName1,
					OptionName2=OptionName2,
					OptionName3=OptionName3);
			
				// NEED TO EVALUATE ANY APPLICABLE DISCOUNTS FOR THIS (LOOPED) PRODUCT HERE --->

				// CALCULATE THE TAXABLE TOTAL AMOUNT
				if ( Taxable EQ 1 )
					TaxableTotal = TaxableTotal + ( Qty * Evaluate(UseThisPrice) ) ;
			</cfscript>
		</cfloop>
		
		<!--- CALCULATE TOTAL TAX VALUE BY MULTIPLYING TAX RATE * TAXABLE TOTAL AMOUNT --->
		<cfset TaxPrice = TaxableTotal * (TaxRate/100) >
		
	<cfelse>
		<cfset TaxPrice = 0 >
	</cfif>

<cfelse><!--- DO NOT APPLY TAX TO USER --->
	<cfset TaxPrice = 0 >
</cfif>

