<!--- BEGIN: ORDER MINIMUM & FIRST ORDER MINIMUM VALUE CHECK --->
<cfparam name="MinNotReached" default="0" type="boolean">
<cfparam name="FirstOrder" default="0" type="boolean">

<cfif session.CustomerArray[28] NEQ ''><!--- PriceToUse --->
	
	<cfquery name="checkForMin" datasource="#datasource#" cachedwithin="#CreateTimeSpan(7,0,0,0)#">
		SELECT	UMinimum, UMinimumFirst, UName
		FROM	Users
		WHERE	UID = #session.CustomerArray[28]#
	</cfquery>
	
	<cfif NOT isDefined('Cart.CartTotal')>
		<cfinclude template="CartTotals.cfm">
	</cfif>
	
	<cfif checkForMin.RecordCount NEQ 0 >
		<!--- IF CART TOTAL IS LESS THAN THE ORDER MINIMUM --->
		<cfif Cart.CartTotal LT checkForMin.UMinimum >
			<cfset MinNotReached = 1 >
		</cfif>
		<!--- IF CART TOTAL IS LESS THAN FIRST ORDER MINIMUM, CONTINUE TO SEE IF IT'S THE CUSTOMER'S FIRST ORDER --->
		<cfif checkForMin.UMinimumFirst NEQ 0 AND Cart.CartTotal LT checkForMin.UMinimumFirst >
			<cfset FirstOrder = 1 >
			<cfif session.CustomerArray[17] NEQ '' >
				<cfquery name="checkPrevOrders" datasource="#datasource#">
					SELECT 	MIN(OrderID) AS OrderID
					FROM	Orders
					WHERE	CustomerID = '#session.CustomerArray[17]#'
				</cfquery>
				<cfif checkPrevOrders.OrderID NEQ '' >
					<cfset FirstOrder = 0 >
				</cfif>
			</cfif>
		</cfif>
	</cfif>
	
</cfif>
<!--- END: ORDER MINIMUM & FIRST ORDER MINIMUM VALUE CHECK --->