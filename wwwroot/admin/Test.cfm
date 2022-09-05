<cfquery name="getOrders" datasource="#application.dsn#">
	SELECT	*
	FROM	Orders
	WHERE	DateEntered >= '12/1/2006'
	AND		DateEntered <= '12/31/2006'
</cfquery>		
		
<cfset AllOrderTotals = 0 >

<cfoutput query="getOrders">
	<cfquery name="getOrderTotal" datasource="#application.dsn#">
		SELECT	SUM( ItemPrice * Qty ) AS RunningTotal
		FROM	OrderItems
		WHERE	OrderID = #OrderID#
		AND		StatusCode != 'BO'
		AND		StatusCode != 'CA'
	</cfquery>
	
	<cfset AllOrderTotals = AllOrderTotals + getOrderTotal.RunningTotal >
	OrderID: <cfdump var="#OrderID#">
	RunningTotal: <cfdump var="#getOrderTotal.RunningTotal#">
	CompleteTotal: <cfdump var="#AllOrderTotals#"><br/><br/>
	
</cfoutput>