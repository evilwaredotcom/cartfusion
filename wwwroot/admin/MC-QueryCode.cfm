<cfif (isDefined('Form.ByProd') AND Form.ByProd EQ 'on') OR (isDefined('Form.ByProdNot') AND Form.ByProdNot EQ 'on')>
	<cfinvoke component="#application.Queries#" method="getSKUs" returnvariable="getSKUs"></cfinvoke>
</cfif>

<cfif isDefined('Form.SearchCriteria')>
	<cfquery name="getMC" datasource="#application.dsn#">
		SELECT 	C.CustomerID, C.LastName + ', ' + C.FirstName + ': ' + C.CustomerID AS CustomerInfo
		FROM	Customers C
		WHERE	C.CustomerID = C.CustomerID
		<cfif Form.SearchCriteria EQ 'AllOrders'>
			AND		C.CustomerID IN
			(		
				SELECT 		CustomerID
				FROM		Orders
				GROUP BY 	CustomerID
				HAVING		COUNT(CustomerID) >= 1
			)
		<cfelseif Form.SearchCriteria EQ 'ByUser'>
			<cfif isDefined('Form.User') AND Form.User NEQ ''>
			AND		C.PriceToUse = #Form.User#
			</cfif>
		<cfelseif Form.SearchCriteria EQ 'ByCustomer'>
			<cfif isDefined('Form.Customer') AND Form.Customer NEQ ''>
			AND		C.CustomerID = #Form.Customer#
			</cfif>
		<cfelseif Form.SearchCriteria EQ 'ByCriteria'>
			<cfif isDefined('Form.ByOrdAmtLeast') AND Form.ByOrdAmtLeast EQ 'on'>
			AND		C.CustomerID IN
			(		
				SELECT 		o.CustomerID
				FROM		Orders o, OrderItems OI
				WHERE		o.OrderID = OI.OrderID
				GROUP BY	o.CustomerID
				HAVING		SUM(OI.ItemPrice) >= #OrdAmtLeast#
			)
			</cfif>
			<cfif isDefined('Form.ByOrdAmtMost') AND Form.ByOrdAmtMost EQ 'on'>
			AND		C.CustomerID IN
			(		
				SELECT 		o.CustomerID
				FROM		Orders o, OrderItems OI
				WHERE		o.OrderID = OI.OrderID
				GROUP BY	o.CustomerID
				HAVING		SUM(OI.ItemPrice) <= #OrdAmtMost#
			)
			</cfif>
			<cfif isDefined('Form.ByOrdLeast') AND Form.ByOrdLeast EQ 'on'>
			AND		C.CustomerID IN
			(		
				SELECT 		CustomerID
				FROM		Orders
				GROUP BY 	CustomerID
				HAVING		COUNT(CustomerID) >= #OrdLeast#
			)
			</cfif>
			<cfif isDefined('Form.ByOrdMost') AND Form.ByOrdMost EQ 'on'>
			AND		C.CustomerID IN
			(		
				SELECT 		CustomerID
				FROM		Orders
				GROUP BY 	CustomerID
				HAVING		COUNT(CustomerID) <= #OrdLeast#
			)
			</cfif>
			<cfif isDefined('Form.ByOrdSince') AND Form.ByOrdSince EQ 'on'>
			AND		C.CustomerID IN
			(
				SELECT		CustomerID
				FROM		Orders
				GROUP BY	CustomerID
				HAVING		MAX(DateEntered) >= #CreateODBCDate(Form.OrdSince)#
			)
			</cfif>
			<cfif isDefined('Form.ByOrdSinceNot') AND Form.ByOrdSinceNot EQ 'on'>
			AND		C.CustomerID IN
			(
				SELECT		CustomerID
				FROM		Orders
				GROUP BY	CustomerID
				HAVING		MAX(DateEntered) <= #CreateODBCDate(Form.OrdSinceNot)#
			)
			</cfif>
			<cfif isDefined('Form.ByOrdBetween') AND Form.ByOrdBetween EQ 'on'>
			AND		C.CustomerID IN
			(
				SELECT		CustomerID
				FROM		Orders
				WHERE		Orders.DateEntered >= #CreateODBCDate(Form.OrdFromDate)# 
				AND 		Orders.DateEntered <= #CreateODBCDate(Form.OrdToDate)#
			)
			</cfif>
			<cfif isDefined('Form.ByProd') AND Form.ByProd EQ 'on'>
			AND		C.CustomerID IN
			(		
				SELECT 		o.CustomerID
				FROM		Orders o, OrderItems OI
				WHERE		o.OrderID = OI.OrderID
				AND			OI.ItemID = #Form.Prod#
			)
			</cfif>
			<cfif isDefined('Form.ByProdNot') AND Form.ByProdNot EQ 'on'>
			AND		C.CustomerID IN
			(		
				SELECT 		o.CustomerID
				FROM		Orders o, OrderItems OI
				WHERE		o.OrderID = OI.OrderID
				AND			OI.ItemID != #Form.ProdNot#
			)
			</cfif>
			<cfif isDefined('Form.ByCat') AND Form.ByCat EQ 'on'>
			AND		C.CustomerID IN
			(		
				SELECT 		CustomerID
				FROM		Orders
				GROUP BY	CustomerID, OrderID 
				HAVING		OrderID IN
				(
					SELECT 	OrderID 
					FROM	OrderItems
					WHERE	ItemID IN
					(
						SELECT	ItemID
						FROM	Products
						WHERE	Category = '#Form.Cat#'
					)
				)
			)
			</cfif>
			<cfif isDefined('Form.ByCatNot') AND Form.ByCatNot EQ 'on'>
			AND		C.CustomerID NOT IN
			(		
				SELECT 		CustomerID
				FROM		Orders
				GROUP BY	CustomerID, OrderID 
				HAVING		OrderID IN
				(
					SELECT 	OrderID 
					FROM	OrderItems
					WHERE	ItemID IN
					(
						SELECT	ItemID
						FROM	Products
						WHERE	Category = '#Form.Cat#'
					)
				)
			)
			</cfif>		
		
			<cfif isDefined('Form.ByCity') AND Form.ByCity EQ 'on'>
			AND		(C.City = '#Form.City#' OR C.ShipCity = '#Form.City#')
			</cfif>
			<cfif isDefined('Form.ByState') AND Form.ByState EQ 'on'>
			AND		(C.State = '#Form.State#' OR C.ShipState = '#Form.State#')
			</cfif>
			<cfif isDefined('Form.ByCountry') AND Form.ByCountry EQ 'on'>
			AND		(C.Country = '#Form.Country#' OR C.ShipCountry = '#Form.Country#')
			</cfif>
		</cfif>	
		ORDER BY C.LastName		
	</cfquery>
<cfelse><!--- Form.SearchCriteria NOT Defined --->
	
</cfif>	
	