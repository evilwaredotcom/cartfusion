<cfif (isDefined('Form.ByProd') AND Form.ByProd EQ 'on') OR (isDefined('Form.ByProdNot') AND Form.ByProdNot EQ 'on')>
	<cfinvoke component="#application.Queries#" method="getSKUs" returnvariable="getSKUs"></cfinvoke>
</cfif>

<!--- AFFILIATES --->
<cfif Form.SearchCriteria EQ 'AllAffiliates' OR Form.SearchCriteria EQ 'AffiliateLevel' >
	<cfquery name="getMWP" datasource="#application.dsn#">
		<cfif isDefined('Form.submitBulkEmails')>
			SELECT 	a.Email, a.FirstName, a.LastName, a.CompanyName, a.DateCreated, a.City, a.State, a.Country
			FROM	Affiliates a
			WHERE	a.EmailOK = 1
			AND		a.Email != ''
		<cfelseif isDefined('Form.submitMailingLabels')>
			SELECT 	a.FirstName, a.LastName, a.CompanyName, a.Address1, a.Address2, a.City, a.State, a.Zip, a.Country
			FROM	Affiliates a
			WHERE	a.Address1 != ''
			AND		a.City != ''
		<cfelseif isDefined('Form.submitCustomerList')>
			SELECT 	a.FirstName, a.LastName, a.CompanyName, a.Address1, a.Address2, a.City, a.State, a.Zip, a.Country, 
					a.Phone, a.Fax, a.Email, a.DateCreated
			FROM	Affiliates a
			WHERE	a.Address1 != ''
		</cfif>
		<cfif Form.SearchCriteria EQ 'AffiliateLevel' AND isDefined('Form.Level') AND Form.Level NEQ '' >
			AND		a.MemberType = #Form.Level#
		</cfif>
			AND		a.Deleted != 1
			ORDER BY a.LastName		
	</cfquery>
	
	
<!--- CUSTOMERS --->
<!--- DO NOT PERFORM QUERY IF USER INPUTS EMAIL ADDRESSES MANUALLY --->
<cfelseif NOT isDefined('Form.EmailsProvided') OR Form.EmailsProvided EQ ''>
	<cfquery name="getMWP" datasource="#application.dsn#">
		<cfif isDefined('Form.submitBulkEmails')>
			SELECT 	C.Email, C.FirstName, C.LastName, C.CompanyName, C.DateCreated, C.City, C.State, C.Country
			FROM	Customers C
			WHERE	C.EmailOK = 1
			AND		C.Email != ''
		<cfelseif isDefined('Form.submitMailingLabels')>
			SELECT 	C.FirstName, C.LastName, C.CompanyName, C.Address1, C.Address2, C.City, C.State, C.Zip, C.Country
			FROM	Customers C
			WHERE	C.ShipAddress1 != ''
			AND		C.ShipCity != ''
		<cfelseif isDefined('Form.submitCustomerList')>
			SELECT 	C.FirstName, C.LastName, C.CompanyName, C.Address1, C.Address2, C.City, C.State, C.Zip, C.Country, 
					C.Phone, C.Fax, C.Email, C.DateCreated
			FROM	Customers C
			WHERE	C.Address1 != ''
		</cfif>
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
			AND		C.Deleted != 1
			ORDER BY C.LastName		
	</cfquery>
</cfif>
