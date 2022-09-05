<cfscript>
	PageTitle = 'REPORT WIZARD PRO: Customers' ;
	BannerTitle = 'ReportWizard' ;
	AddAButton = 'RETURN TO REPORT WIZARD' ;
	AddAButtonLoc = 'RWP-ReportWizard.cfm' ;
	ReportPage = 'RWP-Customers.cfm' ;
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">

<cfscript>
	if (NOT isDefined('ChartType'))
		ChartType = 'bar';
</cfscript>

<cfif Form.ReportType IS 'Summary' OR Form.ReportType IS 'Detail'>
	<cfquery name="getCustData" datasource="#application.dsn#">
		SELECT 	c.CustomerID, c.LastName + ', ' + c.FirstName AS CustomerName, c.CompanyName, c.PriceToUse AS CustomerType,
				c.DateCreated, c.LastName, c.FirstName,
		(
			SELECT 	COUNT(*)
			FROM 	Orders o
			WHERE	o.CustomerID = c.CustomerID
			<cfif Form.FromDate NEQ '' AND Form.ToDate NEQ '' >
				AND		c.DateCreated >= '#Form.FromDate#'
				AND	 	c.DateCreated <= '#DateFormat(DateAdd("d", 1, Form.ToDate),"mm/dd/yyyy")#'
			</cfif>
		)
		AS CustomerOrders,
		(
			SELECT 	SUM(oi.ItemPrice * oi.Qty)
			FROM	OrderItems oi, Orders o
			WHERE	oi.OrderID = o.OrderID
			AND		o.CustomerID = c.CustomerID
			AND		oi.ItemPrice != 0
			AND		oi.Qty != 0
			<cfif Form.FromDate NEQ '' AND Form.ToDate NEQ '' >
				AND		c.DateCreated >= '#Form.FromDate#'
				AND	 	c.DateCreated <= '#DateFormat(DateAdd("d", 1, Form.ToDate),"mm/dd/yyyy")#'
			</cfif>
		)
		AS CustomerGross,
		(
			SELECT 	SUM(o.DiscountTotal)
			FROM	Orders o
			WHERE	o.CustomerID = c.CustomerID
			<cfif Form.FromDate NEQ '' AND Form.ToDate NEQ '' >
				AND		c.DateCreated >= '#Form.FromDate#'
				AND	 	c.DateCreated <= '#DateFormat(DateAdd("d", 1, Form.ToDate),"mm/dd/yyyy")#'
			</cfif>
		)
		AS CustomerDiscounts,
		(
			SELECT 	SUM(oi.ItemPrice * oi.Qty) - SUM(o.DiscountTotal)
			FROM	OrderItems oi, Orders o
			WHERE	oi.OrderID = o.OrderID
			AND		o.CustomerID = c.CustomerID
			AND		oi.ItemPrice != 0
			AND		oi.Qty != 0
			<cfif Form.FromDate NEQ '' AND Form.ToDate NEQ '' >
				AND		c.DateCreated >= '#Form.FromDate#'
				AND	 	c.DateCreated <= '#DateFormat(DateAdd("d", 1, Form.ToDate),"mm/dd/yyyy")#'
			</cfif>
		)
		AS CustomerNet
		FROM	Customers c
		WHERE	c.CustomerID != ''
		AND		c.CustomerID IN
				(SELECT	CustomerID
				FROM	Orders
				WHERE	CustomerID = c.CustomerID )
				
	<cfif Form.ReportDetail IS 'ByUser' AND Form.SelectedUser NEQ ''>
		AND		c.PriceToUse = #Form.SelectedUser#
	</cfif>
	<cfif Form.ReportDetail IS 'ThisCustomer' AND Form.SelectedCustomer NEQ ''>
		AND		c.CustomerID = '#Form.SelectedCustomer#'
	</cfif>
	<cfif Form.FromDate NEQ '' AND Form.ToDate NEQ '' >
		AND		c.DateCreated >= '#Form.FromDate#'
		AND	 	c.DateCreated <= '#DateFormat(DateAdd("d", 1, Form.ToDate),"mm/dd/yyyy")#'
	</cfif>
	<cfif Form.SortOption IS 'CustomerNet'>
		ORDER BY CustomerNet DESC, CustomerName
	<cfelse>
		ORDER BY CustomerName, CustomerNet DESC
	</cfif>
	</cfquery>

<cfelseif Form.ReportType IS 'Info'>
	<cfquery name="getCustData" datasource="#application.dsn#">
		SELECT 	*
		FROM	Customers
		WHERE	CustomerID != ''
		AND		(Address1 != '' OR Address2 != '')
	<cfif Form.ReportDetail IS 'ByUser' AND Form.SelectedUser NEQ ''>
		AND		PriceToUse = #Form.SelectedUser#
	</cfif>
	<cfif Form.ReportDetail IS 'ThisCustomer' AND Form.SelectedCustomer NEQ ''>
		AND		CustomerID = '#Form.SelectedCustomer#'
	</cfif>
	<cfif Form.FromDate NEQ '' AND Form.ToDate NEQ '' >
		AND		DateCreated >= '#Form.FromDate#'
		AND	 	DateCreated <= '#DateFormat(DateAdd("d", 1, Form.ToDate),"mm/dd/yyyy")#'
	</cfif>
		ORDER BY LastName
	</cfquery>

<cfelseif Form.ReportType IS 'PhoneList'>
	<cfquery name="getCustData" datasource="#application.dsn#">
		SELECT 	LastName + ', ' + FirstName AS CustomerName, LastName, FirstName, CompanyName, Phone, Fax
		FROM	Customers
		WHERE	CustomerID != ''
		AND		Phone != ''
	<cfif Form.ReportDetail IS 'ByUser' AND Form.SelectedUser NEQ ''>
		AND		PriceToUse = #Form.SelectedUser#
	</cfif>
	<cfif Form.ReportDetail IS 'ThisCustomer' AND Form.SelectedCustomer NEQ ''>
		AND		CustomerID = '#Form.SelectedCustomer#'
	</cfif>
	<cfif Form.FromDate NEQ '' AND Form.ToDate NEQ '' >
		AND		DateCreated >= '#Form.FromDate#'
		AND	 	DateCreated <= '#DateFormat(DateAdd("d", 1, Form.ToDate),"mm/dd/yyyy")#'
	</cfif>
		ORDER BY CustomerName, CompanyName
	</cfquery>
</cfif>

<cfif getCustData.RecordCount EQ 0 > 
	<table width="620" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td width="100%" align="center" class="cfAdminError">
				<br/><br/>
				Based on the criteria you've given, there is not enough information for a report to be drawn.  Please try again.
				<br/><br/>
				<input type="button" name="GoBack" value="<< GO BACK" alt="Go Back" class="cfAdminButton"
					onClick="javascript:history.back()">
			</td>
		</tr>
	</table>
	<cfinclude template="LayoutAdminFooter.cfm">
	<cfabort>
</cfif> 

<cfif Form.ReportType IS 'Summary' OR Form.ReportType IS 'Detail'>

	<cfif Form.ChartType EQ 'none' AND isDefined('ExCustomerDetails') >
		<table width="620" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td width="100%" align="center" class="cfAdminError">
					<br/><br/>
					You have chosen not to view a customer chart nor customer details.  Please try again.
					<br/><br/>
					<input type="button" name="GoBack" value="<< GO BACK" alt="Go Back" class="cfAdminButton"
						onClick="javascript:history.back()">
				</td>
			</tr>
		</table>
		<cfinclude template="LayoutAdminFooter.cfm">
		<cfabort>
	</cfif>
	
<!--- BEGIN: QUERY CRITERIA FOR YEARLY, MONTHLY, OR TOTAL --->
<cfquery name="getScaleValue" dbtype="query">
	SELECT 	MAX(CustomerGross) AS ScaleValueHi
	FROM	getCustData
</cfquery>

<cfscript>
	TotalOrders = 0;
	TotalGross = 0;
	TotalDiscounts = 0;
	TotalNet = 0;
	
	// SET VARIABLES TO BE USED TO CREATE CHARTS
	Xaxis = 'Customer';
	PieItemCol = 'CustomerName';
</cfscript>

<cfloop query="getCustData">
	<cfscript>
		TotalGross 		= TotalGross + NumberFormat(getCustData.CustomerGross,.99);
		TotalDiscounts	= TotalDiscounts + NumberFormat(CustomerDiscounts,.99);
		TotalNet		= TotalNet + NumberFormat(CustomerNet,.99);
		TotalOrders		= TotalOrders + NumberFormat(CustomerOrders,.99);
	</cfscript>
</cfloop>

	<!--- PDF VIEW --->
	<cfif FORM.DisplayView EQ 'PDF'>
		<cfdocument format="PDF">
		<style type="text/css">
			TD, DIV
			{ <cfif ChartType EQ 'none' >font-size:11px;<cfelse>font-size:15px;</cfif> font-family:Verdana, Arial, Helvetica, sans-serif; }
		</style>
		
		<table width="100%" border="0" bordercolor="<cfoutput>#cfAdminHeaderColor#</cfoutput>" cellpadding="3" cellspacing="0" class="cfAdminDefault">
			<cfdocumentitem type="header">
			<tr>
				<td align="center" height="25">
					<div align="center">
					<cfoutput>
						<b>CUSTOMER SALES</b>
						<cfif Form.ReportDetail IS 'ByUser'>
							<cfinvoke component="#application.Queries#" method="getUser" returnvariable="getUser">
								<cfinvokeargument name="UID" value="#Form.SelectedUser#">
							</cfinvoke>
							| BY USER: <b>#getUser.UName#</b>
						<cfelseif Form.ReportDetail IS 'ThisCustomer'>
							<cfinvoke component="#application.Queries#" method="getCustomer" returnvariable="getCustomer">
								<cfinvokeargument name="CustomerID" value="#Form.SelectedCustomer#">
							</cfinvoke>
							| CUSTOMER: <b>#getCustomer.FirstName# #getCustomer.LastName#</b>
						</cfif>
						<cfif Form.FromDate NEQ '' AND Form.ToDate NEQ '' >
							| FROM: <b>#DateFormat(Form.FromDate,"mmm dd, yyyy")#</b> 
							  TO: <b>#DateFormat(Form.ToDate,"mmm dd, yyyy")#</b>
						</cfif>
					</cfoutput>
					</div>
				</td>
			</tr>
			</cfdocumentitem>
			
			<cfif ChartType NEQ 'none' >
			<tr>
				<td>
					
				<!--- BEGIN: CHART --->
				<cfif ChartType NEQ 'PIE' >
					<cfchart 
						labelformat="currency" 
						xaxistitle="#Xaxis#" 
						yaxistitle="Order Totals" 
						chartheight="400" 
						chartwidth="800" 
						markersize="2"
						databackgroundcolor="#cfAdminHeaderColor#"
						seriesplacement="Default" 
						showygridlines="yes" 
						format="png" 
						showlegend="no" 
						showmarkers="yes" 
						show3d="yes">
				
						<!--- BEGIN: CHART SERIES --->
						<cfoutput query="getCustData">
							<cfchartseries 
								type="#ChartType#" 
								paintstyle="light" 
								serieslabel="Revenue"
								markerstyle="diamond">
								<cfif CustomerNet NEQ ''>
									<cfchartdata item="#getCustData.CurrentRow#" value="#CustomerNet#">
								<cfelse>
									<cfchartdata item="#getCustData.CurrentRow#" value="0">
								</cfif>								
							</cfchartseries>
						</cfoutput>
						<!--- END: CHART SERIES --->
					</cfchart>
				</cfif>
				
				<cfif ChartType EQ 'Pie'>
					<cfchart 
						labelformat="currency"
						xaxistitle="Time Interval" 
						yaxistitle="Revenue" 
						chartheight="400" 
						chartwidth="800" 
						seriesplacement="Default" 
						format="png" 
						pieslicestyle="solid" 
						show3D="Yes">			
							<cfchartseries 
								query="getCustData" 
								itemcolumn="#PieItemCol#" 
								valuecolumn="CustomerNet" 
								type="pie"
								paintstyle="light" 
								seriescolor="FF0000" 
								serieslabel="Cost" >
								<cfchartdata item="Discounts" value="#TotalDiscounts#">
							</cfchartseries>
					</cfchart>
				</cfif>
			
				</td>
			</tr>
			</cfif>
			<!--- END: CHART --->
			
			<cfif NOT isDefined('FORM.ExCustomerDetails')>
			<!------------------------- BEGIN: DISPLAY RESULTS ------------------------->
			<tr>
				<td width="100%">
					<table width="100%" border="0" cellpadding="3" cellspacing="0" class="cfAdminDefault">
						<tr style="background-color:##65ADF1;">
							<td class="cfAdminHeader1">Graph #</td>
							<td class="cfAdminHeader1">Customer Name</td>
							<td align="right" class="cfAdminHeader1">Orders</td>
							<td align="right" class="cfAdminHeader1">Gross Sales</td>
							<td align="right" class="cfAdminHeader1">Discounts</td>
							<td align="right" class="cfAdminHeader1">Net Sales</td>
						</tr>
						<cfif Form.ReportType EQ 'Summary' >
							<cfoutput query="getCustData">
							<tr>
								<td>#CurrentRow#</td>
								<td>#LastName#, #FirstName#</td>
								<td align="right">#CustomerOrders#</td>
								<td align="right">#LSCurrencyFormat(CustomerGross)#</td>
								<td align="right">#LSCurrencyFormat(CustomerDiscounts)#</td>
								<td align="right">#LSCurrencyFormat(CustomerNet)#</td>
							</tr>
							</cfoutput>
						<cfelse><!--- DETAILED CUSTOMER ORDERS --->
							<cfoutput query="getCustData">
							<tr style="background-color:##7DBF0E;">
								<td class="cfAdminHeader2">#CurrentRow#</td>
								<td class="cfAdminHeader2">#LastName#, #FirstName#</td>
								<td align="right" class="cfAdminHeader2">#CustomerOrders#</td>
								<td align="right" class="cfAdminHeader2">#LSCurrencyFormat(CustomerGross)#</td>
								<td align="right" class="cfAdminHeader2">#LSCurrencyFormat(CustomerDiscounts)#</td>
								<td align="right" class="cfAdminHeader2">#LSCurrencyFormat(CustomerNet)#</td>
							</tr>
							<tr style="background-color:EFEFEF;">
								<td class="cfAdminHeader4">##</td>
								<td class="cfAdminHeader4">Order ID</td>
								<td align="right" class="cfAdminHeader4">Items</td>
								<td align="right" class="cfAdminHeader4">Gross Total</td>
								<td align="right" class="cfAdminHeader4">Discounts</td>
								<td align="right" class="cfAdminHeader4">Net Total</td>
							</tr>
							<cfinvoke component="#application.Queries#" method="getCustomerOrders" returnvariable="getCustomerOrders">
								<cfinvokeargument name="CustomerID" value="#CustomerID#">
							</cfinvoke>
							<cfloop query="getCustomerOrders">
								<cfinvoke component="#application.Queries#" method="getOrderTotal" returnvariable="getOrderTotal">
									<cfinvokeargument name="OrderID" value="#OrderID#">
								</cfinvoke>
								<cfscript>
									if (getOrderTotal.RunningTotal EQ '')
										OrderTotal = 0 ;
									else
										OrderTotal = getOrderTotal.RunningTotal ;
								</cfscript>
								<tr>
									<td>#CurrentRow#</td>
									<td>#OrderID#</td>
									<td align="right">#getOrderTotal.Items#</td>
									<td align="right">#LSCurrencyFormat(OrderTotal)#</td>
									<td align="right">#LSCurrencyFormat(DiscountTotal)#</td>
									<td align="right">#LSCurrencyFormat(OrderTotal - DiscountTotal)#</td>
								</tr>
							</cfloop>
							<tr><td colspan="6">&nbsp;</td></tr>
							</cfoutput>
						</cfif><!--- SUMMARY/DETAILED --->
						<cfoutput>
						<tr><td colspan="6" height="1" bgcolor="#cfAdminHeaderColor#"></td></tr>	
						<tr>
							<td colspan="2"><b>TOTALS</b></td>
							<td align="right"><b>#TotalOrders#</b></td>
							<td align="right"><b>#LSCurrencyFormat(TotalGross)#</b></td>
							<td align="right" class="cfAdminError"><b>#LSCurrencyFormat(TotalDiscounts)#</b></td>
							<td align="right"><b>#LSCurrencyFormat(TotalNet)#</b></td>
						</tr>
						</cfoutput>
					</table>
				</td>
			</tr>
			<!------------------------- END: DISPLAY RESULTS ------------------------->
			</cfif>
			
			<cfdocumentitem type="footer">
			<tr>
				<td align="center" height="30">	
					<div align="center">
						<cfoutput>
						Page <b>#cfdocument.currentpagenumber#</b> of <b>#cfdocument.totalpagecount#</b>
						</cfoutput>
					</div>
				</td>
			</tr>
			</cfdocumentitem>
		</table>
		</cfdocument>
		
	<cfelse><!--- ONLINE VIEWING --->
	
		<br>
		<table width="820" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td class="cfAdminDefault" valign="middle" style="PADDING-LEFT: 10px;">
					<img src="images/image-commentpic.gif" align="absmiddle">&nbsp;&nbsp; Place your mouse over a chart segment to view details.
				</td>
				<td width="30%" align="right">
					<input type="button" name="NewReport" value="NEW REPORT" alt="Create A New Report" class="cfAdminButton"
						onClick="document.location.href='<cfoutput>#ReportPage#</cfoutput>'">
				</td>
			</tr>
		</table>		
		<br>
		
		<table width="820" border="1" bordercolor="<cfoutput>#cfAdminHeaderColor#</cfoutput>" cellpadding="3" cellspacing="0" class="cfAdminDefault">
			<tr>
				<td align="center" height="25">
					<div align="center">
					<cfoutput>
						<cfif Form.ReportType IS 'Summary'>
							<b>CUSTOMER SALES SUMMARY</b>
						<cfelseif Form.ReportType IS 'Detail'>
							<b>CUSTOMER SALES DETAIL</b>
						</cfif>
						<cfif Form.ReportDetail IS 'ByUser'>
							<cfinvoke component="#application.Queries#" method="getUser" returnvariable="getUser">
								<cfinvokeargument name="UID" value="#Form.SelectedUser#">
							</cfinvoke>
							| BY USER: <b>#getUser.UName#</b>
						<cfelseif Form.ReportDetail IS 'ThisCustomer'>
							<cfinvoke component="#application.Queries#" method="getCustomer" returnvariable="getCustomer">
								<cfinvokeargument name="CustomerID" value="#Form.SelectedCustomer#">
							</cfinvoke>
							| CUSTOMER: <b>#getCustomer.FirstName# #getCustomer.LastName#</b>
						</cfif>
						<cfif Form.FromDate NEQ '' AND Form.ToDate NEQ '' >
							| FROM: <b>#DateFormat(Form.FromDate,"mmm dd, yyyy")#</b> 
							  TO: <b>#DateFormat(Form.ToDate,"mmm dd, yyyy")#</b>
						</cfif>
					</cfoutput>
					</div>
				</td>
			</tr>
			
			<cfif ChartType NEQ 'none' >
			<tr>
				<td>
					
				<!--- BEGIN: CHART --->
				<cfif ChartType NEQ 'PIE' >
					<cfchart 
						labelformat="currency" 
						xaxistitle="#Xaxis#" 
						yaxistitle="Order Totals" 
						chartheight="400" 
						chartwidth="800" 
						markersize="2"
						databackgroundcolor="#cfAdminHeaderColor#"
						seriesplacement="Default" 
						showygridlines="yes" 
						format="png" 
						showlegend="no" 
						showmarkers="yes" 
						show3d="yes">
				
						<!--- BEGIN: CHART SERIES --->
						<cfoutput query="getCustData">
							<cfchartseries 
								type="#ChartType#" 
								paintstyle="light" 
								serieslabel="Revenue"
								markerstyle="diamond">
								<cfif CustomerNet NEQ ''>
									<cfchartdata item="#getCustData.CurrentRow#" value="#CustomerNet#">
								<cfelse>
									<cfchartdata item="#getCustData.CurrentRow#" value="0">
								</cfif>
							</cfchartseries>
						</cfoutput>
						<!--- END: CHART SERIES --->
					</cfchart>
				</cfif>
				
				<cfif ChartType EQ 'Pie'>
					<cfchart 
						labelformat="currency"
						xaxistitle="Time Interval" 
						yaxistitle="Revenue" 
						chartheight="400" 
						chartwidth="800" 
						seriesplacement="Default" 
						format="png" 
						pieslicestyle="solid" 
						show3D="Yes">			
							<cfchartseries 
								query="getCustData" 
								itemcolumn="#PieItemCol#" 
								valuecolumn="CustomerNet" 
								type="pie"
								paintstyle="light" 
								seriescolor="FF0000" 
								serieslabel="Cost" >
								<cfchartdata item="Discounts" value="#TotalDiscounts#">
							</cfchartseries>
					</cfchart>
				</cfif>
			
				</td>
			</tr>
			</cfif>
			<!--- END: CHART --->
			
			<cfif NOT isDefined('FORM.ExCustomerDetails')>
			<!------------------------- BEGIN: DISPLAY RESULTS ------------------------->
			<tr>
				<td width="100%">
					<table width="100%" border="0" cellpadding="3" cellspacing="0" class="cfAdminDefault">
						<tr style="background-color:##65ADF1;">
							<td class="cfAdminHeader1">Graph #</td>
							<td class="cfAdminHeader1">Customer Name</td>
							<td align="right" class="cfAdminHeader1">Orders</td>
							<td align="right" class="cfAdminHeader1">Gross Sales</td>
							<td align="right" class="cfAdminHeader1">Discounts</td>
							<td align="right" class="cfAdminHeader1">Net Sales</td>
						</tr>
						<cfif Form.ReportType EQ 'Summary' >
							<cfoutput query="getCustData">
							<tr>
								<td>#CurrentRow#</td>
								<td>#LastName#, #FirstName#</td>
								<td align="right">#CustomerOrders#</td>
								<td align="right">#LSCurrencyFormat(CustomerGross)#</td>
								<td align="right">#LSCurrencyFormat(CustomerDiscounts)#</td>
								<td align="right">#LSCurrencyFormat(CustomerNet)#</td>
							</tr>
							</cfoutput>
						<cfelse><!--- DETAILED CUSTOMER ORDERS --->
							<cfoutput query="getCustData">
							<tr style="background-color:##7DBF0E;">
								<td class="cfAdminHeader2">#CurrentRow#</td>
								<td class="cfAdminHeader2">#LastName#, #FirstName#</td>
								<td align="right" class="cfAdminHeader2">#CustomerOrders#</td>
								<td align="right" class="cfAdminHeader2">#LSCurrencyFormat(CustomerGross)#</td>
								<td align="right" class="cfAdminHeader2">#LSCurrencyFormat(CustomerDiscounts)#</td>
								<td align="right" class="cfAdminHeader2">#LSCurrencyFormat(CustomerNet)#</td>
							</tr>
							<tr style="background-color:EFEFEF;">
								<td class="cfAdminHeader4">##</td>
								<td class="cfAdminHeader4">Order ID</td>
								<td align="right" class="cfAdminHeader4">Items</td>
								<td align="right" class="cfAdminHeader4">Gross Total</td>
								<td align="right" class="cfAdminHeader4">Discounts</td>
								<td align="right" class="cfAdminHeader4">Net Total</td>
							</tr>
							<cfinvoke component="#application.Queries#" method="getCustomerOrders" returnvariable="getCustomerOrders">
								<cfinvokeargument name="CustomerID" value="#CustomerID#">
							</cfinvoke>
							<cfloop query="getCustomerOrders">
								<cfinvoke component="#application.Queries#" method="getOrderTotal" returnvariable="getOrderTotal">
									<cfinvokeargument name="OrderID" value="#OrderID#">
								</cfinvoke>
								<cfscript>
									if (getOrderTotal.RunningTotal EQ '')
										OrderTotal = 0 ;
									else
										OrderTotal = getOrderTotal.RunningTotal ;
								</cfscript>
								<tr>
									<td>#CurrentRow#</td>
									<td>#OrderID#</td>
									<td align="right">#getOrderTotal.Items#</td>
									<td align="right">#LSCurrencyFormat(OrderTotal)#</td>
									<td align="right">#LSCurrencyFormat(DiscountTotal)#</td>
									<td align="right">#LSCurrencyFormat(OrderTotal - DiscountTotal)#</td>
								</tr>
							</cfloop>
							<tr><td colspan="6">&nbsp;</td></tr>
							</cfoutput>
						</cfif><!--- SUMMARY/DETAILED --->
						<cfoutput>
						<tr><td colspan="8" height="1" bgcolor="#cfAdminHeaderColor#"></td></tr>	
						<tr>
							<td colspan="2"><b>TOTALS</b></td>
							<td align="right"><b>#TotalOrders#</b></td>
							<td align="right"><b>#LSCurrencyFormat(TotalGross)#</b></td>
							<td align="right" class="cfAdminError"><b>#LSCurrencyFormat(TotalDiscounts)#</b></td>
							<td align="right"><b>#LSCurrencyFormat(TotalNet)#</b></td>
						</tr>
						</cfoutput>
					</table>
				</td>
			</tr>
			<!------------------------- END: DISPLAY RESULTS ------------------------->
			</cfif>
		</table>
	</cfif><!--- VIEWING - ONLINE OR PDF --->


<cfelseif Form.ReportType IS 'Info'>

	<!--- PDF VIEW --->
	<cfif FORM.DisplayView EQ 'PDF'>
		<cfdocument format="PDF">
		<style type="text/css">
			TD, DIV
			{ font-size:10px; font-family:Verdana, Arial, Helvetica, sans-serif; }
		</style>
		
		<table width="100%" border="1" bordercolor="<cfoutput>#cfAdminHeaderColor#</cfoutput>" cellpadding="7" cellspacing="0" class="cfAdminDefault">
			<cfdocumentitem type="header">
			<tr>
				<td colspan="3" align="center" height="25"><div align="center"><b>CUSTOMER ADDRESS & PHONE NUMBER LIST</b></div></td>
			</tr>
			</cfdocumentitem>
			<tr>
			<cfoutput query="getCustData">	
				<td width="33%" valign="top">
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr><td><b>#LastName#, #FirstName#</b></td></tr>
						<cfif CompanyName NEQ ''>
						<tr><td>#CompanyName#</td></tr>
						</cfif>
						<cfif Address1 NEQ ''>
						<tr><td>#Address1#</td></tr>
						</cfif>
						<cfif Address2 NEQ ''>
						<tr><td>#Address2#</td></tr>
						</cfif>
						<cfif City NEQ ''>
						<tr><td>#City#, #State# #Zip#</td></tr>
						</cfif>
						<cfif Phone NEQ ''>
						<tr><td>Phone: #Phone#</td></tr>
						</cfif>
						<cfif Fax NEQ ''>
						<tr><td>Fax: #Fax#</td></tr>
						</cfif>
					</table>
				</td>
			<cfif CurrentRow NEQ RecordCount AND NOT CurrentRow MOD 3 >
			</tr>
			<tr>
			</tr></cfif>
			</cfoutput>
			
			<cfdocumentitem type="footer">
			<tr>
				<td align="center" height="30">	
					<div align="center">
						<cfoutput>
						Page <b>#cfdocument.currentpagenumber#</b> of <b>#cfdocument.totalpagecount#</b>
						</cfoutput>
					</div>
				</td>
			</tr>
			</cfdocumentitem>
		</table>
		</cfdocument>
		
	<cfelse><!--- ONLINE VIEWING --->
		<br>
		<table width="620" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td width="100%" align="center">
					<input type="button" name="NewReport" value="NEW REPORT" alt="Create A New Report" class="cfAdminButton"
						onClick="document.location.href='<cfoutput>#ReportPage#</cfoutput>'">
				</td>
			</tr>
		</table>		
		<br>
	
		<table width="620" border="1" bordercolor="<cfoutput>#cfAdminHeaderColor#</cfoutput>" cellpadding="7" cellspacing="0" class="cfAdminDefault">
			<tr>
				<td colspan="3" align="center" height="25"><b>CUSTOMER ADDRESS & PHONE NUMBER LIST</b></td>
			</tr>
			<tr>
			<cfoutput query="getCustData">	
				<td width="33%" valign="top">
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr><td><b>#LastName#, #FirstName#</b></td></tr>
						<cfif CompanyName NEQ ''>
						<tr><td>#CompanyName#</td></tr>
						</cfif>
						<cfif Address1 NEQ ''>
						<tr><td>#Address1#</td></tr>
						</cfif>
						<cfif Address2 NEQ ''>
						<tr><td>#Address2#</td></tr>
						</cfif>
						<cfif City NEQ ''>
						<tr><td>#City#, #State# #Zip#</td></tr>
						</cfif>
						<cfif Phone NEQ ''>
						<tr><td>Phone: #Phone#</td></tr>
						</cfif>
						<cfif Fax NEQ ''>
						<tr><td>Fax: #Fax#</td></tr>
						</cfif>
					</table>
				</td>
			<cfif CurrentRow NEQ RecordCount AND NOT CurrentRow MOD 3 >
			</tr>
			<tr>
			</tr></cfif>
			</cfoutput>
			
		</table>
	</cfif><!--- VIEWING - ONLINE OR PDF --->



<cfelseif Form.ReportType IS 'PhoneList'>

	<!--- PDF VIEW --->
	<cfif FORM.DisplayView EQ 'PDF'>
		<cfdocument format="PDF">
		<style type="text/css">
			TD, DIV
			{ font-size:10px; font-family:Verdana, Arial, Helvetica, sans-serif; }
		</style>
		
		<table width="100%" border="1" bordercolor="<cfoutput>#cfAdminHeaderColor#</cfoutput>" cellpadding="7" cellspacing="0" class="cfAdminDefault">
			<cfdocumentitem type="header">
			<tr>
				<td colspan="3" align="center" height="25"><div align="center"><b>CUSTOMER PHONE NUMBER LIST</b></div></td>
			</tr>
			</cfdocumentitem>
			<tr>
			<cfoutput query="getCustData" group="Phone">
				<td width="33%" valign="top">
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr><td width="30%">Name:</td><td><b>#LastName#, #FirstName#</b></td></tr>
						<cfif CompanyName NEQ ''>
						<tr><td nowrap="nowrap">Company: &nbsp;</td><td>#CompanyName#</td></tr>
						</cfif>
						<cfif Phone NEQ ''>
						<tr><td>Phone:</td><td>#Phone#</td></tr>
						</cfif>
						<cfif Fax NEQ ''>
						<tr><td>Fax:</td><td>#Fax#</td></tr>
						</cfif>
						<tr><td height="10" colspan="2">&nbsp;</td></tr>
					</table>
				</td>
			<cfif CurrentRow NEQ RecordCount AND NOT CurrentRow MOD 3 >
			</tr>
			<tr>
			</tr></cfif>
			</cfoutput>
			
			<cfdocumentitem type="footer">
			<tr>
				<td align="center" height="30">	
					<div align="center">
						<cfoutput>
						Page <b>#cfdocument.currentpagenumber#</b> of <b>#cfdocument.totalpagecount#</b>
						</cfoutput>
					</div>
				</td>
			</tr>
			</cfdocumentitem>
		</table>
		</cfdocument>
	
	<cfelse><!--- ONLINE VIEWING --->
		<br>
		<table width="620" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td width="100%" align="center">
					<input type="button" name="NewReport" value="NEW REPORT" alt="Create A New Report" class="cfAdminButton"
						onClick="document.location.href='<cfoutput>#ReportPage#</cfoutput>'">
				</td>
			</tr>
		</table>		
		<br>
		
		<table width="620" border="1" bordercolor="<cfoutput>#cfAdminHeaderColor#</cfoutput>" cellpadding="7" cellspacing="0" class="cfAdminDefault">
			<tr>
				<td colspan="3" align="center" height="25"><b>CUSTOMER PHONE NUMBER LIST</b></td>
			</tr>
			<tr>
			<cfoutput query="getCustData" group="Phone">
				<td width="33%" valign="top">
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr><td width="30%">Name:</td><td><b>#LastName#, #FirstName#</b></td></tr>
						<cfif CompanyName NEQ ''>
						<tr><td>Company: &nbsp;</td><td>#CompanyName#</td></tr>
						</cfif>
						<cfif Phone NEQ ''>
						<tr><td>Phone:</td><td>#Phone#</td></tr>
						</cfif>
						<cfif Fax NEQ ''>
						<tr><td>Fax:</td><td>#Fax#</td></tr>
						</cfif>
						<tr><td height="10" colspan="2">&nbsp;</td></tr>
					</table>
				</td>
			<cfif CurrentRow NEQ RecordCount AND NOT CurrentRow MOD 3 >
			</tr>
			<tr>
			</tr></cfif>
			</cfoutput>
			
		</table>
	</cfif><!--- VIEWING - ONLINE OR PDF --->

</cfif><!--- IF QUERY RETURNS AT LEAST ONE RESULT --->


<cfinclude template="LayoutAdminFooter.cfm">