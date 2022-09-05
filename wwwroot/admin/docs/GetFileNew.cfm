<!--- GET ORDERS --->
<cfquery name="getQBOrders" datasource="#application.dsn#">
	SELECT	o.DateEntered AS OrderDate, 
			o.OrderID AS PONumber, 
			o.CustomerID AS Customer,
			o.PaymentVerified AS PayStatus, <!--- or BillingStatus --->
			o.oShipFirstName + ' ' + o.oShipLastName AS ShipName,
			o.oShipCompanyName AS ShipAddr1,			
			o.oShipAddress1 AS ShipAddr2,
			o.oShipAddress2 AS ShipAddr3,
			o.oShipCity AS ShipCity,
			o.oShipState AS ShipState,
			o.oShipZip AS ShipPostal,
			o.oShipCountry AS ShipCntry,
			o.Phone AS Phone,
			c.Fax AS Fax,
			c.FirstName + ' ' + c.LastName AS BillName,
			c.CompanyName AS BillAddr1,			
			c.Address1 AS BillAddr2,
			c.Address2 AS BillAddr3,
			c.City AS BillCity,
			c.State AS BillState,
			c.Zip AS BillPostal,
			c.Country AS BillCntry,
			c.Email AS Email,
			o.FormOfPayment AS PayMethod,
			o.ShippingMethod AS ShipMethod,
			
			p.SKU AS ItemCode, 
			p.ItemName AS ItemDesc,
			oi.Qty AS Quantity,
			oi.ItemPrice AS Price,
			oi.Qty * oi.ItemPrice AS Total,
			(
				SELECT	pp.Taxable
				FROM	Products pp
				WHERE	pp.ItemID = oi.ItemID
			) AS ProductTaxable
				
			FROM Orders o, Customers c, Products p, OrderItems oi
			WHERE	o.CustomerID = c.CustomerID
			AND		o.OrderID = oi.OrderID
			AND		oi.ItemID = p.ItemID
			<!--- AND		o.DateEntered >= '11/01/2004' --->
</cfquery>


<!--- SET FILENAME FOR USE --->
<cfscript>
	CF2QBfile = 'CFII#DateFormat(Now(),'yymmddHHmmss')#.txt' ;
	CF2QBpath = '#getDirectoryFromPath(getCurrentTemplatePath())#\' ;
</cfscript>

<!--- CREATE BLANK FILE --->
<cffile action="write" file="#CF2QBpath##CF2QBfile#" output="" addnewline="no">

<cfoutput query="getQBOrders">
		
	<cfscript>
		TaxCode = '' ; // Default = None
		DepositAcct = '' ; // Default = None
		DocType = 'I' ; // Default = I (Invoice)
		DocNum = '' ; // Default = None
		if ( isDefined('Form.UseTax') AND Form.UseTax NEQ '' )
		{
			if ( ProductTaxable EQ 1 )
				TaxCode = 'Tax' ;
			else
				TaxCode = 'Non' ;
		}
		if ( isDefined('Form.DepositAccount') AND Form.DepositAccount NEQ '' )
			DepositAcct = Form.DepositAccount ;
		if ( isDefined('Form.DocumentType') AND Form.DocumentType NEQ '' AND (Form.DocumentType EQ 'I' OR Form.DocumentType EQ 'S') )
			DocType = Form.DocumentType ;
	</cfscript>
	
	<!--- MUST CREATE STRING SO QUOTES CAN BE USED --->
	<cfset LineOrder = "#DateFormat(OrderDate,'mm/dd/yyyy')# 	""#PONumber#""	""#Customer#""	""#PayStatus#""		""#ShipName#""		""#ShipAddr1#""		""#ShipAddr2#""		""#ShipAddr3#""		"""" 	""#ShipCity#""		""#ShipState#""		""#ShipPostal#""	""#ShipCntry#""		""#Phone#""		""#Fax#""		""#BillName#""		""#BillAddr1#""		""#BillAddr2#""		""#BillAddr3#""		""""	""#BillCity#""		""#BillState#""		""#BillPostal#""	""#BillCntry#""		""#Email#""		""#PayMethod#""		""#ShipMethod#""	""#ItemCode#""		""#ItemDesc#""		""#Quantity#""		""#Price#""		""#Total#""		""#TaxCode#""		""#DepositAcct#""	""#DocType#""	""#DocNum#""	">
	
	<!--- APPEND ORDERS & ORDER ITEMS TO TEXT FILE --->
	<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="#LineOrder#">
	
</cfoutput>


<cfoutput>
	Your CartFusion-2-QuickBooks text file is located here: <a href="http://dm30.temp.tradestudios.com/admin/docs/#CF2QBfile#">http://dm30.temp.tradestudios.com/admin/docs/#CF2QBfile#</a><br><br>
	Right click the link and click "Save Target As...", then save the file to your computer.
</cfoutput>
	

