<cfquery name="getAllProducts" datasource="#application.dsn#">
	SELECT	ItemID, SKU
	FROM	Products
	WHERE	Deleted = 0 OR Deleted IS NULL
</cfquery>

<cfscript>
	PageTitle = 'CartFusion File Exporter';
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">
<br>

<table width="50%" border="1" bordercolor="#EFEFEF" cellpadding="7" cellspacing="0" align="center">
	<tr>
		<!--- QUICKBOOKS
		<cfform name="CreateQBFiles" action="FileExporter.cfm" method="post">
		<td width="33%" align="center">
			<img src="images/logos/logo-QuickBooksLogo.jpg" border="0"><br><br>
			
			<table width="100%">
				<tr>
					<td width="50%" align="right">
						From Date: &nbsp;
					</td>
					<td width="50%" align="left">
						<cfinput type="text" name="FromDate" size="15" class="cfAdminDefault" value="#DateFormat(Now(),'mm/dd/yyyy')#" required="no" validate="date" message="Please enter a FROM DATE in mm/dd/yyyy format\nClick the calendar for easy date selection">
							<cf_cal formname="CreateQBFiles" target="FromDate" image="images/button-calendar.gif">
					</td>
				</tr>
				<tr>
					<td width="50%" align="right">
						To Date: &nbsp;
					</td>
					<td width="50%" align="left">
						<cfinput type="text" name="ToDate" size="15" class="cfAdminDefault" value="#DateFormat(Now(),'mm/dd/yyyy')#" required="no" validate="date" message="Please enter a TO DATE in mm/dd/yyyy format\nClick the calendar for easy date selection">
							<cf_cal formname="CreateQBFiles" target="ToDate" image="images/button-calendar.gif">
					</td>
				</tr>
				<tr>
					<td align="center" colspan="2"><br>OR<br><br></td>
				</tr>
				<tr>
					<td width="50%" align="right">
						From Order ID: &nbsp;
					</td>
					<td width="50%" align="left">
						<cfinput type="text" name="FromOrderID" size="15" class="cfAdminDefault" required="no" validate="integer" message="Invalid FROM ORDER ID value.">
					</td>
				</tr>
				<tr>
					<td width="50%" align="right">
						To Order ID: &nbsp;
					</td>
					<td width="50%" align="left">
						<cfinput type="text" name="ToOrderID" size="15" class="cfAdminDefault" required="no" validate="integer" message="Invalid TO ORDER ID value.">
					</td>
				</tr>
			</table>

			<br><br>
			<input type="submit" name="CreateQBFile" value="GENERATE FILE" alt="Create QuickBooks File" class="cfAdminButton">
		</td>
		</cfform>
		 --->
		 
		<!--- UPS WORLDSHIP --->
		<cfform name="CreateWSFiles" action="FileExporter.cfm" method="post">
		<td width="33%" align="center">
			<img src="images/logos/logo-WorldShipLogo.jpg" border="0"><br><br>
			
			<table width="100%">
				<tr>
					<td width="50%" align="right">
						From Date: &nbsp;
					</td>
					<td width="50%" align="left">
						<cfinput type="text" name="FromDate" size="15" class="cfAdminDefault" value="#DateFormat(Now(),'mm/dd/yyyy')#" required="no" validate="date" message="Please enter a FROM DATE in mm/dd/yyyy format\nClick the calendar for easy date selection">
							<cf_cal formname="CreateWSFiles" target="FromDate" image="images/button-calendar.gif">
					</td>
				</tr>
				<tr>
					<td width="50%" align="right">
						To Date: &nbsp;
					</td>
					<td width="50%" align="left">
						<cfinput type="text" name="ToDate" size="15" class="cfAdminDefault" value="#DateFormat(Now(),'mm/dd/yyyy')#" required="no" validate="date" message="Please enter a TO DATE in mm/dd/yyyy format\nClick the calendar for easy date selection">
							<cf_cal formname="CreateWSFiles" target="ToDate" image="images/button-calendar.gif">
					</td>
				</tr>
				<tr>
					<td align="center" colspan="2"><br>OR<br><br></td>
				</tr>
				<tr>
					<td width="50%" align="right">
						From Order ID: &nbsp;
					</td>
					<td width="50%" align="left">
						<cfinput type="text" name="FromOrderID" size="15" class="cfAdminDefault" required="no" validate="integer" message="Invalid FROM ORDER ID value.">
					</td>
				</tr>
				<tr>
					<td width="50%" align="right">
						To Order ID: &nbsp;
					</td>
					<td width="50%" align="left">
						<cfinput type="text" name="ToOrderID" size="15" class="cfAdminDefault" required="no" validate="integer" message="Invalid TO ORDER ID value.">
					</td>
				</tr>
			</table>
			
			<br><br>
			<input type="submit" name="CreateWSFile" value="GENERATE FILE" alt="Create UPS WorldShip File" class="cfAdminButton">
		</td>
		</cfform>
		
		<!--- MERCHANT ADVANTAGE --->
		<cfform name="CreateMAFiles" action="FileExporter.cfm" method="post">
		<td width="33%" align="center">
			<br/><br/><img src="images/logos/logo-MerchantAdvantage.gif" border="0"><br/><br/><br/><br/>
			
			<table width="100%">
				<tr>
					<td width="50%" align="right">
						All Products: &nbsp;
					</td>
					<td width="50%" align="left">
						<cfinput type="checkbox" name="AllProducts">
					</td>
				</tr>
				<tr>
					<td align="center" colspan="2"><br>OR<br><br></td>
				</tr>
				<tr>
					<td width="50%" align="right">
						From Product ID: &nbsp;
					</td>
					<td width="50%" align="left">
						<select name="FromProduct" class="cfAdminDefault" size="1">
							<cfoutput query="getAllProducts">
							<option value="#ItemID#">#ItemID#: #SKU#</option>
							</cfoutput>
						</select>
					</td>
				</tr>
				<tr>
					<td width="50%" align="right">
						To Product ID: &nbsp;
					</td>
					<td width="50%" align="left">
						<select name="ToProduct" class="cfAdminDefault" size="1">
							<cfoutput query="getAllProducts">
							<option value="#ItemID#" <cfif CurrentRow EQ RecordCount>selected</cfif>>#ItemID#: #SKU#</option>
							</cfoutput>
						</select>
					</td>
				</tr>
			</table>
			
			<br><br>
			<input type="submit" name="CreateMAFiles" value="GENERATE FILE" alt="Create Merchant Advantage File" class="cfAdminButton">
		</td>
		</cfform>
	</tr>
</table>

<br>

<!--- --->

<!--- QUICKBOOKS TEXT FILE --->
<cfif isDefined('Form.CreateQBFile')>
	<!--- GET ORDERS --->
	<cfquery name="getQBOrders" datasource="#application.dsn#">
		SELECT	o.OrderID, o.PaymentVerified, o.CCName, o.CCNum, o.CCExpDate, o.CCCVV, o.ShippingTotal, o.TaxTotal, o.DiscountTotal, o.CreditApplied,
				o.ShippingMethod, o.TrackingNumber, o.AffiliateID, o.BillingStatus, o.OrderStatus, o.ShipDate, o.TransactionID,
				o.oShipFirstName, o.oShipLastName, o.oShipCompanyName, o.oShipAddress1, o.oShipAddress2,
				o.oShipCity, o.oShipState, o.oShipZip, o.oShipCountry,
				o.CustomerComments, o.Phone AS OrderPhone, o.Comments AS OrderComments, o.DateEntered AS OrderDate, 
				o.DateUpdated AS OrderUpdated, o.UpdatedBy AS OrderUpdatedBy, o.FormOfPayment, o.CustomerID,
				
				c.FirstName, c.LastName, c.CompanyName,	c.Address1, c.Address2, c.City, c.State, c.Zip, c.Country,
				c.Email, c.Credit, c.PriceToUse, c.Phone AS CustomerPhone, c.Comments AS CustDetailComments,
				
				oi.OrderItemsID, oi.Qty, oi.ItemPrice, oi.StatusCode, oi.OptionName1, oi.OptionName2, oi.OptionName3, 
				oi.DateEntered AS OrderItemDate, oi.oiTrackingNumber,
				
				p.ItemID, p.SKU, p.ItemName
					
		FROM 	Orders o, Customers c, Products p, OrderItems oi
		WHERE	o.CustomerID = c.CustomerID
		AND		o.OrderID = oi.OrderID
		AND		oi.ItemID = p.ItemID
		<cfif isDefined('Form.FromDate') AND Form.FromDate NEQ '' AND isDefined('Form.ToDate') AND Form.ToDate NEQ '' >
		AND		o.DateEntered >= '#Form.FromDate#'
		AND		o.DateEntered <= '#Form.ToDate#'
		<cfelseif isDefined('Form.FromOrderID') AND Form.FromOrderID NEQ '' AND isDefined('Form.ToOrderID') AND Form.ToOrderID NEQ '' >
		AND		o.OrderID >= #Form.FromOrderID#
		AND		o.OrderID <= #Form.ToOrderID#
		</cfif>
	</cfquery>
	
	<!--- ONLY CREATE FILE IF RECORDS ARE RETURNED --->
	<cfif getQBOrders.RecordCount NEQ 0 >
	
		<!--- SET FILENAME FOR USE --->
		<cfscript>
			CF2QBfile = 'CFII#DateFormat(Now(),'yymmddHHmmss')#.xls' ;
			CF2QBpath = '#getDirectoryFromPath(getCurrentTemplatePath())#\docs\' ;
		</cfscript>
		
		<!--- CREATE BLANK FILE --->
		<cffile action="write" file="#CF2QBpath##CF2QBfile#" output="" addnewline="no">
		
		<!--- CREATE FILE HEADERS --->
		<cfset FileHeader = '"OrderID"	"PaymentVerified"	"CCName"	"CCNum"	"CCExpDate"	"CCCVV"	"ShippingTotal"	"TaxTotal"	"DiscountTotal"	"CreditApplied"	"ShippingMethod"	"TrackingNumber"	"AffiliateID"	"BillingStatus"	"OrderStatus"	"ShipDate"	"TransactionID"	"oShipFirstName"	"oShipLastName"	"oShipCompanyName"	"oShipAddress1"	"oShipAddress2"	"oShipCity"	"oShipState"	"oShipZip"	"oShipCountry"	"CustomerComments"	"OrderPhone"	"OrderComments"	"OrderDate"	"OrderUpdated"	"OrderUpdatedBy"	"FormOfPayment"	"CustomerID"	"FirstName"	"LastName"	"CompanyName"	"Address1"	"Address2"	"City"	"State"	"Zip"	"Country"	"Email"	"Credit"	"PriceToUse"	"CustomerPhone"	"CustDetailComments"	"OrderItemsID"	"Qty"	"ItemPrice"	"StatusCode"	"OptionName1"	"OptionName2"	"OptionName3"	"OrderItemDate"	"oiTrackingNumber"	"ItemID"	"SKU"	"ItemName"'>
		<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="#FileHeader#">
			
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
					
				if ( CCNum NEQ '' ) 
					Decrypted_CCNum = DECRYPT(CCNum, application.CryptKey, "CFMX_COMPAT", "Hex") ;
				else 
					Decrypted_CCNum = '' ;
				if ( CCExpDate NEQ '' ) 
					Decrypted_CCExpDate = DECRYPT(CCExpDate, application.CryptKey, "CFMX_COMPAT", "Hex") ;
				else 
					Decrypted_CCExpDate = '' ;
			</cfscript>
			
			<!--- MUST CREATE STRING SO QUOTES CAN BE USED --->
			
			<cfset LineOrder = '"#OrderID#"	"#PaymentVerified#"	"#CCName#"	"#Decrypted_CCNum#"	"#Decrypted_CCExpDate#"	"#CCCVV#"	"#DecimalFormat(ShippingTotal)#"	"#DecimalFormat(TaxTotal)#"	"#DecimalFormat(DiscountTotal)#"	"#DecimalFormat(CreditApplied)#"	"#ShippingMethod#"	"#TrackingNumber#"	"#AffiliateID#"	"#BillingStatus#"	"#OrderStatus#"	"#DateFormat(ShipDate,"mm/dd/yyyy")#"	"#TransactionID#"	"#oShipFirstName#"	"#oShipLastName#"	"#oShipCompanyName#"	"#oShipAddress1#"	"#oShipAddress2#"	"#oShipCity#"	"#oShipState#"	"#oShipZip#"	"#oShipCountry#"	"#CustomerComments#"	"#OrderPhone#"	"#OrderComments#"	"#DateFormat(OrderDate,"mm/dd/yyyy")#"	"#DateFormat(OrderUpdated,"mm/dd/yyyy")#"	"#OrderUpdatedBy#"	"#FormOfPayment#"	"#CustomerID#"	"#FirstName#"	"#LastName#"	"#CompanyName#"	"#Address1#"	"#Address2#"	"#City#"	"#State#"	"#Zip#"	"#Country#"	"#Email#"	"#DecimalFormat(Credit)#"	"#PriceToUse#"	"#CustomerPhone#"	"#CustDetailComments#"	"#OrderItemsID#"	"#Qty#"	"#DecimalFormat(ItemPrice)#"	"#StatusCode#"	"#OptionName1#"	"#OptionName2#"	"#OptionName3#"	"#DateFormat(OrderItemDate,"mm/dd/yyyy")#"	"#oiTrackingNumber#"	"#ItemID#"	"#SKU#"	"#ItemName#"'>
			
			<!--- APPEND ORDERS & ORDER ITEMS TO TEXT FILE --->
			<cffile action="append" file="#CF2QBpath##CF2QBfile#" addnewline="yes" output="#LineOrder#">
			
		</cfoutput>
		
		
		<cfoutput>
		<table width="50%" border="1" bordercolor="006600" cellpadding="7" cellspacing="0">
			<tr>
				<td width="100%" align="center" class="cfAdminDefault">
					<b>Your CartFusion-2-QuickBooks text file has been created and is located here:</b><br>
					<a href="#application.RootURL#/admin/docs/#CF2QBfile#"><font color="006600"><u>#application.RootURL#/admin/docs/#CF2QBfile#</u></font></a><br><br>
					Right click the link and click "Save Target As...", then save the file to your computer.
				</td>
			</tr>
		</table>
		</cfoutput>
	<cfelse>
		<table width="50%" border="1" bordercolor="006600" cellpadding="7" cellspacing="0">
			<tr>
				<td width="100%" align="center" class="cfAdminError">
					<b>No orders were found matching the selection criteria.</b>
				</td>
			</tr>
		</table>
	</cfif>


<!--- UPS WORLDSHIP CSV FILE --->
<cfelseif isDefined('Form.CreateWSFile')>
	<!--- GET ORDERS --->
	<cfquery name="getWSOrders" datasource="#application.dsn#">
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
				o.ShippingMethod AS ShipMethod
					
		FROM 	Orders o, Customers c
		WHERE	o.CustomerID = c.CustomerID
		AND		(o.OrderStatus = 'OD' OR o.OrderStatus = 'SP' OR o.OrderStatus = 'PR')
		<cfif isDefined('Form.FromOrderID') AND Form.FromOrderID NEQ '' AND isDefined('Form.ToOrderID') AND Form.ToOrderID NEQ '' >
		AND		o.OrderID >= #Form.FromOrderID#
		AND		o.OrderID <= #Form.ToOrderID#
		<cfelseif isDefined('Form.FromDate') AND Form.FromDate NEQ '' AND isDefined('Form.ToDate') AND Form.ToDate NEQ '' >
		AND		o.DateEntered >= '#Form.FromDate#'
		AND		o.DateEntered <= '#Form.ToDate#'
		</cfif>
	</cfquery>
	
	<!--- ONLY CREATE FILE IF RECORDS ARE RETURNED --->
	<cfif getWSOrders.RecordCount NEQ 0 >
	
		<!--- SET FILENAME FOR USE --->
		<cfscript>
			CF2WSfile = 'CFII#DateFormat(Now(),'yymmddHHmmss')#.csv' ;
			CF2WSpath = '#getDirectoryFromPath(getCurrentTemplatePath())#\docs\' ;
		</cfscript>
		
		<!--- CREATE BLANK FILE --->
		<cffile action="write" file="#CF2WSpath##CF2WSfile#" output="invoice,ShipType,company,name,address1,address2,city,state,country,zip,phone,po" addnewline="yes">
		
		<cfoutput query="getWSOrders" group="PONumber">
			
			<!--- MUST CREATE STRING SO QUOTES CAN BE USED --->
			<cfset LineOrder = "#TRIM(Replace(PONumber,',',''))#,#TRIM(Replace(ShipMethod,',',''))#,#TRIM(Replace(ShipAddr1,',',''))#,#TRIM(Replace(ShipName,',',''))#,#TRIM(Replace(ShipAddr2,',',''))#,#TRIM(Replace(ShipAddr3,',',''))#,#TRIM(Replace(ShipCity,',',''))#,#TRIM(Replace(ShipState,',',''))#,#TRIM(Replace(ShipCntry,',',''))#,#TRIM(Replace(ShipPostal,',',''))#,#TRIM(Replace(Phone,',',''))#,#TRIM(Replace(PONumber,',',''))#">
			
			<!--- APPEND ORDERS & ORDER ITEMS TO TEXT FILE --->
			<cffile action="append" file="#CF2WSpath##CF2WSfile#" addnewline="yes" output="#LineOrder#">
			
		</cfoutput>
		
		
		<cfoutput>
		<table width="50%" border="1" bordercolor="330000" cellpadding="7" cellspacing="0">
			<tr>
				<td width="100%" align="center" class="cfAdminDefault">
					<b>Your CartFusion-2-WorldShip CSV file has been created and is located here:</b><br>
					<a href="#application.RootURL#/admin/docs/#CF2WSfile#"><font color="006600"><u>#application.RootURL#/admin/docs/#CF2WSfile#</u></font></a><br><br>
					Right click the link and click "Save Target As...", then save the file to your computer as a .CSV file.
				</td>
			</tr>
		</table>
		</cfoutput>
	<cfelse>
		<table width="50%" border="1" bordercolor="330000" cellpadding="7" cellspacing="0">
			<tr>
				<td width="100%" align="center" class="cfAdminError">
					<b>No orders were found matching the selection criteria.</b>
				</td>
			</tr>
		</table>
	</cfif>
	

<!--- MERCHANT ADVANTAGE CSV FILE --->
<cfelseif isDefined('Form.CreateMAFiles')>
	<!--- GET ORDERS --->
	<cfquery name="getMAProducts" datasource="#application.dsn#">
		SELECT	ItemID, ItemName, ItemDescription, ImageDir, Image, Weight, Price1, ListPrice,
				(
					SELECT	CatName
					FROM	Categories
					WHERE	CatID = Products.Category
				) AS Category
					
		FROM 	Products
		WHERE	(Deleted = 0 OR Deleted IS NULL)
		AND		ItemName != ''
		AND		ItemName IS NOT NULL
		<cfif NOT isDefined('FORM.AllProducts') AND Form.FromProduct LTE Form.ToProduct >
		AND		ItemID >= #Form.FromProduct#
		AND		ItemID <= #Form.ToProduct#
		</cfif>
	</cfquery>
	
	<!--- ONLY CREATE FILE IF RECORDS ARE RETURNED --->
	<cfif getMAProducts.RecordCount NEQ 0 >
	
		<!--- SET FILENAME FOR USE --->
		<cfscript>
			CF2WSfile = 'MA_#application.DomainName#.csv' ;
			CF2WSpath = '#getDirectoryFromPath(getCurrentTemplatePath())#\docs\' ;
		</cfscript>
		
		<!--- CREATE BLANK FILE --->
		<cffile action="write" file="#CF2WSpath##CF2WSfile#" output="Category,Manufacturer,Product Name,Description,Product URL,Image URL,Product Code,Quantity,Condition,Ship Weight,Ship Cost,Bid per product,UPC,SalePrice,Price" addnewline="yes">
		
		<cfoutput query="getMAProducts">
			<cfscript>
				ProductURL = application.RootURL & '/ProductDetail.cfm?ItemID=' & ItemID ;
				if ( Image NEQ '' )
					ImageURL = application.ImagePath & '/' & ImageDir & '/' & Image ;
				else
					ImageURL = '' ;
				// Add Line to File
				LineOrder = "#TRIM(Replace(Category,',','','ALL'))#,,#TRIM(Replace(ItemName,',','','ALL'))#,#TRIM(Replace(Replace(ItemDescription,chr(13) & chr(10),' ','ALL'),',','','ALL'))#,#TRIM(Replace(ProductURL,',','','ALL'))#,#TRIM(Replace(ImageURL,',','','ALL'))#,#TRIM(Replace(ItemID,',','','ALL'))#,10000,NEW,#TRIM(Replace(Weight,',','','ALL'))#,,,,#TRIM(Replace(Price1,',','','ALL'))#,#TRIM(Replace(ListPrice,',','','ALL'))#" ;
			</cfscript>
			<!--- APPEND ORDERS & ORDER ITEMS TO TEXT FILE --->
			<cffile action="append" file="#CF2WSpath##CF2WSfile#" addnewline="yes" output="#LineOrder#">
		</cfoutput>
		
		
		<cfoutput>
		<table width="100%" border="1" bordercolor="330000" cellpadding="7" cellspacing="0">
			<tr>
				<td width="100%" align="center" class="cfAdminDefault">
					<b>Your CartFusion-2-MerchantAdvantage CSV file has been created and is located here:</b><br>
					<a href="#application.RootURL#/admin/docs/#CF2WSfile#"><font color="006600"><u>#application.RootURL#/admin/docs/#CF2WSfile#</u></font></a><br><br>
					Right click the link and click "Save Target As...", then save the file to your computer as a .CSV file.
				</td>
			</tr>
		</table>
		</cfoutput>
	<cfelse>
		<table width="100%" border="1" bordercolor="330000" cellpadding="7" cellspacing="0">
			<tr>
				<td width="100%" align="center" class="cfAdminError">
					<b>No products were found matching the selection criteria.</b>
				</td>
			</tr>
		</table>
	</cfif>
	

</cfif>

<cfinclude template="LayoutAdminFooter.cfm">