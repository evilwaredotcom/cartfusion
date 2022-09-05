<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<!--- BEGIN: ORDER MINIMUM & FIRST ORDER MINIMUM VALUE CHECK --->
<cfparam name="MinNotReached" default="0" type="boolean">
<cfparam name="FirstOrder" default="0" type="boolean">

<cfif session.CustomerArray[28] NEQ ''><!--- PriceToUse --->
	
	
	<!--- Comment Added by Carl Vanderpal 9 June 2007: Convert to CFC --->
	<cfquery name="checkForMin" datasource="#application.dsn#" cachedwithin="#CreateTimeSpan(7,0,0,0)#">
		SELECT	UMinimum, UMinimumFirst, UName
		FROM	Users
		WHERE	UID = #session.CustomerArray[28]#
	</cfquery>
	
	<cfif not isDefined('Cart.CartTotal')>
		<cfinclude template="CartTotals.cfm">
	</cfif>
	
	
	<cfscript>
		if( checkForMin.RecordCount)	{
			// IF CART TOTAL IS LESS THAN THE ORDER MINIMUM 
			if( Cart.CartTotal LT checkForMin.UMinimum )	{
				MinNotReached = 1;
			}
			// IF CART TOTAL IS LESS THAN FIRST ORDER MINIMUM, CONTINUE TO SEE IF IT'S THE CUSTOMER'S FIRST ORDER
			if( checkForMin.UMinimumFirst neq 0 AND Cart.CartTotal LT checkForMin.UMinimumFirst )	{
				FirstOrder = 1;
				if( session.CustomerArray[17] neq '' )	{
					// Get Query 'CheckPrevOrders'
					checkPrevOrders = application.Cart.checkPrevOrders(CustomerID=session.CustomerArray[17]);
					// if OrderID neq ''
					if( checkPrevOrders.OrderID neq '')	{
						FirstOrder = 0;
					}
				}
			}
		}
	</cfscript>
	
	<!--- <cfif checkForMin.RecordCount>
		<!--- IF CART TOTAL IS LESS THAN THE ORDER MINIMUM --->
		<cfif Cart.CartTotal LT checkForMin.UMinimum >
			<cfset MinNotReached = 1 >
		</cfif>
		<!--- IF CART TOTAL IS LESS THAN FIRST ORDER MINIMUM, CONTINUE TO SEE IF IT'S THE CUSTOMER'S FIRST ORDER --->
		<cfif checkForMin.UMinimumFirst neq 0 AND Cart.CartTotal LT checkForMin.UMinimumFirst >
			<cfset FirstOrder = 1 >
			<cfif session.CustomerArray[17] neq '' >
				
				
				
				<!--- <cfquery name="checkPrevOrders" datasource="#application.dsn#">
					SELECT 	MIN(OrderID) AS OrderID
					FROM	Orders
					WHERE	CustomerID = '#session.CustomerArray[17]#'
				</cfquery> --->
				<cfif checkPrevOrders.OrderID neq '' >
					<cfset FirstOrder = 0 >
				</cfif>
			</cfif>
		</cfif>
	</cfif> --->
	
</cfif>
<!--- END: ORDER MINIMUM & FIRST ORDER MINIMUM VALUE CHECK --->