<cfscript>
	PageTitle = 'REPORT WIZARD PRO: Revenue' ;
	BannerTitle = 'ReportWizard' ;
	AddAButton = 'RETURN TO REPORT WIZARD' ;
	AddAButtonLoc = 'RWP-ReportWizard.cfm' ;
	ReportPage = 'RWP-Revenue.cfm' ;
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">

<cfscript>
	if (NOT isDefined('ChartType'))
		ChartType = 'bar';
	if (NOT isDefined('Frequency'))
		Frequency = 'Total';
</cfscript>

<!--- ORDERS REPORT --->
<cfif Form.ReportType NEQ 'Other'>

	<cfquery name="getRevData" datasource="#application.dsn#">
		SELECT 	SUM(oi.ItemPrice * oi.Qty) AS GrossIncome, SUM(oi.ItemPrice * oi.Qty) - SUM(oi.Qty * p.CostPrice) AS NetIncome,
				COUNT(oi.OrderItemsID) AS TotalUnits, 
				
			<cfif Form.Frequency EQ 'Monthly'>
				DatePart(mm, o.DateEntered) AS MonthOrdered,
				DateName(mm, o.DateEntered) AS MonthOrdName,
				DatePart(yy, o.DateEntered) AS YearOrdered,
			<cfelseif Form.Frequency EQ 'Yearly'>
				DatePart(yy, o.DateEntered) AS YearOrdered,
			</cfif>
			<cfif NOT isDefined('Form.ExCosts')>
				SUM(oi.Qty * p.CostPrice) AS Expenses,
			</cfif>
			<cfif Form.ReportType EQ 'Detailed' >
				o.OrderID AS NumOfOrders, o.DateEntered AS OrderDate
			<cfelse>
				COUNT(DISTINCT o.OrderID) AS NumOfOrders
			</cfif>
			
		FROM	OrderItems oi, Products p, Orders o
		WHERE	oi.ItemID = p.ItemID
		AND		oi.OrderID = o.OrderID
		AND		o.DateEntered >= '#Form.FromDate#'
		AND		o.DateEntered <= '#DateFormat(DateAdd("d", 1, Form.ToDate),"mm/dd/yyyy")#'
		<cfif isDefined('FORM.ExUnbilled')>
		AND		o.OrderStatus != 'BO'
		AND		o.BillingStatus != 'NB'
		</cfif>
		<cfif isDefined('FORM.ExCanceled')>
		AND		o.OrderStatus != 'CA'
		AND		o.OrderStatus != 'RE'
		AND		o.BillingStatus != 'CA'
		AND		o.BillingStatus != 'RE'
		AND		o.BillingStatus != 'DE'
		</cfif>
		
		<cfif Form.ReportDetail IS 'ByUser' AND Form.SelectedUser NEQ ''>
		AND		o.OrderID IN
				(SELECT	oo.OrderID
				FROM 	Orders oo, Customers c
				WHERE	oo.CustomerID = c.CustomerID
				AND		c.PriceToUse = #Form.SelectedUser#
				AND		oo.DateEntered >= '#Form.FromDate#'
				AND	 	oo.DateEntered <= '#DateFormat(DateAdd("d", 1, Form.ToDate),"mm/dd/yyyy")#'
				)
		</cfif>
		<cfif Form.ReportDetail IS 'ByRegion' AND Form.SelectedRegion NEQ ''>
		AND		o.OrderID IN
				(SELECT	oo.OrderID
				FROM 	Orders oo, Customers c
				WHERE	oo.CustomerID = c.CustomerID
				AND		c.State = '#Form.SelectedRegion#'
				AND		oo.DateEntered >= '#Form.FromDate#'
				AND	 	oo.DateEntered <= '#DateFormat(DateAdd("d", 1, Form.ToDate),"mm/dd/yyyy")#'
				)
		</cfif>
		
		<cfif Form.Frequency EQ	'Monthly'>
			GROUP BY 	DatePart(mm, o.DateEntered),
						DateName(mm, o.DateEntered),
						DatePart(yy, o.DateEntered)
						<cfif Form.ReportType EQ 'Detailed' >
						, o.OrderID
						</cfif>
			ORDER BY 	DatePart(yy, o.DateEntered),
						DatePart(mm, o.DateEntered)					
		<cfelseif Form.Frequency EQ 'Yearly'>
			GROUP BY 	DatePart(yy, o.DateEntered)
						<cfif Form.ReportType EQ 'Detailed' >
						, o.OrderID
						</cfif> 
			ORDER BY 	DatePart(yy, o.DateEntered)
		<cfelseif Form.ReportType EQ 'Detailed' >
			GROUP BY 	o.OrderID, o.DateEntered
		</cfif>
	</cfquery>
	
	<!---
	<cfdump var="#getRevData#" expand="no"><cfabort>
	--->
	
	<cfif getRevData.RecordCount EQ 0 >
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
	<cfelseif Form.ChartType EQ 'none' AND isDefined('ExOrderDetails') >
		<table width="620" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td width="100%" align="center" class="cfAdminError">
					<br/><br/>
					You have chosen not to view an order chart nor order details.  Please try again.
					<br/><br/>
					<input type="button" name="GoBack" value="<< GO BACK" alt="Go Back" class="cfAdminButton"
						onClick="javascript:history.back()">
				</td>
			</tr>
		</table>
		<cfinclude template="LayoutAdminFooter.cfm">
		<cfabort>
	<CFELSE>
	
	<cfscript>
		TotalGross = 0;
		TotalExpenses = 0;
		TotalProducts = 0;
		TotalOrders = 0;
		Expenses = 0;
		
		// SET VARIABLES TO BE USED TO CREATE CHARTS
		if (Form.Frequency EQ 'Monthly')
		{
			Xaxis = 'Month';
			PieItemCol = 'MonthOrdName';
		}
		else if (Form.Frequency EQ 'Yearly')
		{
			Xaxis = 'Year';
			PieItemCol = 'YearOrdered';
		}
		else
		{
			Xaxis = 'Time';
			PieItemCol = 'NumOfOrders';
		}
	</cfscript>
	
	<cfloop query="getRevData">
		<cfscript>
			if ( NOT isDefined('getRevData.GrossIncome') OR getRevData.GrossIncome EQ '' )
				getRevData.GrossIncome = 0 ;
			if ( NOT isDefined('getRevData.Expenses') OR getRevData.Expenses EQ '' )
				getRevData.Expenses = 0 ;
			if ( NOT isDefined('getRevData.TotalUnits') OR getRevData.TotalUnits EQ '' )
				getRevData.TotalUnits = 0 ;
			if ( NOT isDefined('getRevData.NumOfOrders') OR getRevData.NumOfOrders EQ '' )
				getRevData.NumOfOrders = 0 ;
			if ( isDefined('getRevData.Expenses') AND getRevData.Expenses NEQ 0 )
				TotalExpenses	= TotalExpenses + NumberFormat(getRevData.Expenses,.99) ;
			TotalGross 		= TotalGross + NumberFormat(getRevData.GrossIncome,.99) ;
			TotalProducts	= TotalProducts + NumberFormat(getRevData.TotalUnits,.99) ;
			TotalOrders		= TotalOrders + NumberFormat(getRevData.NumOfOrders,.99) ;
		</cfscript>
	</cfloop>
	
	<!--- PDF VIEW --->
	<cfif FORM.DisplayView EQ 'PDF'>
	<cfdocument format="pdf">
		<style type="text/css">
			TD, DIV
			{ <cfif ChartType EQ 'none' >font-size:10px;<cfelse>font-size:12px;</cfif> font-family:Verdana, Arial, Helvetica, sans-serif; }
		</style>
	
	<table width="100%" border="0" bordercolor="<cfoutput>#cfAdminHeaderColor#</cfoutput>" cellpadding="3" cellspacing="0" class="cfAdminDefault">
		<cfdocumentitem type="header">
		<tr>
			<td align="center" height="25">
				<div align="center">
				<cfoutput>
					<b>ORDERS SUMMARY</b>
					<cfif Form.ReportDetail IS 'ByUser'>
						<cfinvoke component="#application.Queries#" method="getUser" returnvariable="getUser">
							<cfinvokeargument name="UID" value="#Form.SelectedUser#">
						</cfinvoke>
						| BY USER: <b>#getUser.UName#</b>
					<cfelseif Form.ReportDetail IS 'ByRegion'>
						<cfquery name="getState" datasource="#application.dsn#">
							SELECT	State
							FROM	States
							WHERE	StateCode = '#Form.SelectedRegion#'
						</cfquery>
						| BY REGION: <b>#getState.State#</b>
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
		
		<!--- BEGIN: CHART --->
		<cfif ChartType NEQ 'none' >
		<tr>
			<td>
				<cfif ChartType NEQ 'PIE'>		
					<cfchart 
						labelformat="currency" 
						xaxistitle="#Xaxis#" 
						yaxistitle="Amount"
						chartheight="400" 
						chartwidth="800" 
						markersize="2"
						databackgroundcolor="#cfAdminHeaderColor#"
						seriesplacement="Default" 
						showygridlines="yes" 
						format="png" 
						showlegend="no" 
						showmarkers="yes" 
						show3d="yes" >
						<!--- CFMX 7: title="Revenue: #DateFormat(FromDate, 'mmm dd, yyyy')# to #DateFormat(ToDate, 'mmm dd, yyyy')#" --->
				
						<!--- BEGIN: CHART SERIES --->
						<cfoutput query="getRevData">
							<cfif NOT isDefined('ExCosts')>
								<cfchartseries 
									type="#ChartType#" 
									paintstyle="light" 
									serieslabel="Cost" 
									markerstyle="diamond">
									<cfif Frequency EQ 'Monthly'>
										<cfchartdata item="#Left(MonthOrdName,3)# '#Right(YearOrdered,2)#" value="#Expenses#">		
									<cfelseif Frequency EQ 'Yearly'>
										<cfchartdata item="#YearOrdered#" value="#Expenses#">		
									<cfelse>
										<cfchartdata item="#DateFormat(FromDate, 'mmm dd, yyyy')# to #DateFormat(ToDate, 'mmm dd, yyyy')#" value="#Expenses#">	
									</cfif>
								</cfchartseries>
							</cfif>
							<cfchartseries 
								type="#ChartType#" 
								paintstyle="light" 
								serieslabel="Revenue"
								markerstyle="diamond">
								<cfif Frequency EQ 'Monthly'>
									<cfchartdata item="#Left(MonthOrdName,3)# '#Right(YearOrdered,2)#" value="#GrossIncome#">
								<cfelseif Frequency EQ 'Yearly'>
									<cfchartdata item="#YearOrdered#" value="#GrossIncome#">		
								<cfelse>
									<cfchartdata item="#DateFormat(FromDate, 'mmm dd, yyyy')# to #DateFormat(ToDate, 'mmm dd, yyyy')#" value="#GrossIncome#">	
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
						yaxistitle="Amount" 
						chartheight="400" 
						chartwidth="800" 
						seriesplacement="Default" 
						format="png" 
						pieslicestyle="#PieStyle#" 
						show3D="Yes" >
						<!--- CFMX 7: title="Revenue: #DateFormat(FromDate, 'mmm dd, yyyy')# to #DateFormat(ToDate, 'mmm dd, yyyy')#" --->
						
						<!--- BEGIN: CHART SERIES --->
						<cfif isDefined('Form.ExCosts')>
							<cfchartseries 
								query="getRevData"
								itemcolumn="#PieItemCol#" 
								valuecolumn="GrossIncome"
								type="pie"
								paintstyle="raise"			 
								seriescolor="FF0000" 
								serieslabel="Cost" />
						<cfelse>
							<cfchartseries
								query="getRevData" 
								itemcolumn="#PieItemCol#" 
								valuecolumn="GrossIncome" 
								type="pie"
								paintstyle="light" 
								seriescolor="FF0000" 
								serieslabel="Cost" >
								<cfchartdata item="Expenses" value="#TotalExpenses#">
							</cfchartseries>
						</cfif>
						<!--- END: CHART SERIES --->
					</cfchart>
				</cfif>
				
			</td>
		</tr>
		</cfif>
		<!--- END: CHART --->
		
		<cfif NOT isDefined('FORM.ExOrderDetails')>
		<!------------------------- BEGIN: DISPLAY RESULTS ------------------------->
		<tr>
			<td width="100%">
				<table width="100%" border="0" cellpadding="3" cellspacing="0" class="cfAdminDefault">
					<tr style="background-color:##65ADF1;">
						<cfif Form.Frequency EQ 'Monthly'>
						<td class="cfAdminHeader1"><b>Month</b></td>
						<td class="cfAdminHeader1"><b>Year</b></td>
						<cfelseif Form.Frequency EQ 'Yearly'>
						<td class="cfAdminHeader1"><b>Year</b></td>
						</cfif>
						<td align="right" class="cfAdminHeader1"><b>Orders</b></td>
						<cfif Form.ReportType EQ 'Detailed' >
						<td align="right" class="cfAdminHeader1"><b>Date</b></td>
						</cfif>
						<td align="right" class="cfAdminHeader1"><b>Products Sold</b></td>
						<td align="right" class="cfAdminHeader1"><b>Gross Revenue</b></td>
						<cfif NOT isDefined('Form.ExCosts')>
						<td align="right" class="cfAdminHeader1">Expenses</td>
						<td align="right" class="cfAdminHeader1">Net Revenue</td>
						</cfif>
					</tr>
					<cfoutput query="getRevData">
					<tr>
						<cfif Form.Frequency EQ 'Monthly'>
						<td>#MonthOrdName#</td>
						<td>#YearOrdered#</td>
						<cfelseif Form.Frequency EQ 'Yearly'>
						<td>#YearOrdered#</td>
						</cfif>
						<td align="right">#NumOfOrders#</td>
						<cfif Form.ReportType EQ 'Detailed' >
						<td align="right">#DateFormat(OrderDate,'mm/dd/yyyy')#</td>
						</cfif>
						<td align="right">#TotalUnits#</td>
						<td align="right">#LSCurrencyFormat(GrossIncome)#</td>
						<cfif NOT isDefined('Form.ExCosts')>
						<td align="right">#LSCurrencyFormat(Expenses)#</td>
						<td align="right">#LSCurrencyFormat(GrossIncome - Expenses)#</td><!--- NetIncome miscalculated on null --->
						</cfif>
					</tr>
					</cfoutput>
					<cfoutput>
					<tr><td colspan="8" height="1" bgcolor="#cfAdminHeaderColor#"></td></tr>	
					<tr>
						<cfif Form.Frequency EQ 'Monthly'>
						<td></td>
						<td></td>
						<cfelseif Form.Frequency EQ 'Yearly'>
						<td></td>
						</cfif>
						<cfif Form.ReportType EQ 'Detailed' >
						<td align="right"><b>#getRevData.RecordCount#</b></td>
						<td align="right"></td>
						<cfelse>
						<td align="right"><b>#TotalOrders#</b></td>
						</cfif>
						<td align="right"><b>#TotalProducts#</b></td>
						<td align="right"><b>#LSCurrencyFormat(TotalGross)#</b></td>
						<cfif NOT isDefined('Form.ExCosts')>
						<td align="right"><b>#LSCurrencyFormat(TotalExpenses)#</b></td>
						<td align="right"><b>#LSCurrencyFormat(TotalGross - TotalExpenses)#</b></td>
						</cfif>
					</tr>
					</cfoutput>
				</table>
			</td>
		</tr>
		</cfif><!--- SHOW ORDER DETAILS --->
		<cfdocumentitem type="footer">
		<tr>
			<td align="center">	
				<div align="center">
					<cfoutput>
					Page <b>#cfdocument.currentpagenumber#</b> of <b>#cfdocument.totalpagecount#</b>
					</cfoutput>
				</div>
			</td>
		</tr>
		</cfdocumentitem>
	</table>
	<!------------------------- END: DISPLAY RESULTS ------------------------->
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
					<b>ORDERS SUMMARY</b>
					<cfif Form.ReportDetail IS 'ByUser'>
						<cfinvoke component="#application.Queries#" method="getUser" returnvariable="getUser">
							<cfinvokeargument name="UID" value="#Form.SelectedUser#">
						</cfinvoke>
						| BY USER: <b>#getUser.UName#</b>
					<cfelseif Form.ReportDetail IS 'ByRegion'>
						<cfquery name="getState" datasource="#application.dsn#">
							SELECT	State
							FROM	States
							WHERE	StateCode = '#Form.SelectedRegion#'
						</cfquery>
						| BY REGION: <b>#getState.State#</b>
					</cfif>
					<cfif Form.FromDate NEQ '' AND Form.ToDate NEQ '' >
						| FROM: <b>#DateFormat(Form.FromDate,"mmm dd, yyyy")#</b> 
						  TO: <b>#DateFormat(Form.ToDate,"mmm dd, yyyy")#</b>
					</cfif>
				</cfoutput>
				</div>
			</td>
		</tr>
		
		<!--- BEGIN: CHART --->
		<cfif ChartType NEQ 'none' >
		<tr>
			<td>
				<cfif ChartType NEQ 'PIE'>		
					<cfchart 
						labelformat="currency" 
						xaxistitle="#Xaxis#" 
						yaxistitle="Amount"
						chartheight="400" 
						chartwidth="800" 
						markersize="2"
						databackgroundcolor="#cfAdminHeaderColor#"
						seriesplacement="Default" 
						showygridlines="yes" 
						format="png" 
						showlegend="no" 
						showmarkers="yes" 
						show3d="yes" >
						<!--- CFMX 7: title="Revenue: #DateFormat(FromDate, 'mmm dd, yyyy')# to #DateFormat(ToDate, 'mmm dd, yyyy')#" --->
				
						<!--- BEGIN: CHART SERIES --->
						<cfoutput query="getRevData">
							<cfif NOT isDefined('ExCosts')>
								<cfchartseries 
									type="#ChartType#" 
									paintstyle="light" 
									serieslabel="Cost" 
									markerstyle="diamond">
									<cfif Frequency EQ 'Monthly'>
										<cfchartdata item="#Left(MonthOrdName,3)# '#Right(YearOrdered,2)#" value="#Expenses#">		
									<cfelseif Frequency EQ 'Yearly'>
										<cfchartdata item="#YearOrdered#" value="#Expenses#">		
									<cfelse>
										<cfchartdata item="#DateFormat(FromDate, 'mmm dd, yyyy')# to #DateFormat(ToDate, 'mmm dd, yyyy')#" value="#Expenses#">	
									</cfif>
								</cfchartseries>
							</cfif>
							<cfchartseries 
								type="#ChartType#" 
								paintstyle="light" 
								serieslabel="Revenue"
								markerstyle="diamond">
								<cfif Frequency EQ 'Monthly'>
									<cfchartdata item="#Left(MonthOrdName,3)# '#Right(YearOrdered,2)#" value="#GrossIncome#">
								<cfelseif Frequency EQ 'Yearly'>
									<cfchartdata item="#YearOrdered#" value="#GrossIncome#">		
								<cfelse>
									<cfchartdata item="#DateFormat(FromDate, 'mmm dd, yyyy')# to #DateFormat(ToDate, 'mmm dd, yyyy')#" value="#GrossIncome#">	
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
						yaxistitle="Amount" 
						chartheight="400" 
						chartwidth="800" 
						seriesplacement="Default" 
						format="png" 
						pieslicestyle="#PieStyle#" 
						show3D="Yes" >
						<!--- CFMX 7: title="Revenue: #DateFormat(FromDate, 'mmm dd, yyyy')# to #DateFormat(ToDate, 'mmm dd, yyyy')#" --->
						
						<!--- BEGIN: CHART SERIES --->
						<cfif isDefined('Form.ExCosts')>
							<cfchartseries 
								query="getRevData" 
								itemcolumn="#PieItemCol#" 
								valuecolumn="GrossIncome" 
								type="pie" 
								paintstyle="raise"				 
								seriescolor="FF0000" 
								serieslabel="Cost" />
						<cfelse>
							<cfchartseries
								query="getRevData" 
								itemcolumn="#PieItemCol#" 
								valuecolumn="GrossIncome" 
								type="pie"
								paintstyle="light" 
								seriescolor="FF0000" 
								serieslabel="Cost" >
								<cfchartdata item="Expenses" value="#TotalExpenses#">
							</cfchartseries>
						</cfif>
						<!--- END: CHART SERIES --->
					</cfchart>
				</cfif>
	
			</td>
		</tr>
		</cfif>
		<!--- END: CHART --->
	
		<cfif NOT isDefined('FORM.ExOrderDetails')>	
		<!------------------------- BEGIN: DISPLAY RESULTS ------------------------->
		<tr>
			<td width="100%">
				<table width="100%" border="0" cellpadding="3" cellspacing="0" class="cfAdminDefault">
					<tr style="background-color:##65ADF1;">
						<cfif Form.Frequency EQ 'Monthly'>
						<td class="cfAdminHeader1"><b>Month</b></td>
						<td class="cfAdminHeader1"><b>Year</b></td>
						<cfelseif Form.Frequency EQ 'Yearly'>
						<td class="cfAdminHeader1"><b>Year</b></td>
						</cfif>
						<td align="right" class="cfAdminHeader1"><b>Orders</b></td>
						<cfif Form.ReportType EQ 'Detailed' >
						<td align="right" class="cfAdminHeader1"><b>Date</b></td>
						</cfif>
						<td align="right" class="cfAdminHeader1"><b>Products Sold</b></td>
						<td align="right" class="cfAdminHeader1"><b>Gross Revenue</b></td>
						<cfif NOT isDefined('Form.ExCosts')>
						<td align="right" class="cfAdminHeader1">Expenses</td>
						<td align="right" class="cfAdminHeader1">Net Revenue</td>
						</cfif>
					</tr>
					<cfoutput query="getRevData">
					<tr>
						<cfif Form.Frequency EQ 'Monthly'>
						<td>#MonthOrdName#</td>
						<td>#YearOrdered#</td>
						<cfelseif Form.Frequency EQ 'Yearly'>
						<td>#YearOrdered#</td>
						</cfif>
						<td align="right">#NumOfOrders#</td>
						<cfif Form.ReportType EQ 'Detailed' >
						<td align="right">#DateFormat(OrderDate,'mm/dd/yyyy')#</td>
						</cfif>
						<td align="right">#TotalUnits#</td>
						<td align="right">#LSCurrencyFormat(GrossIncome)#</td>
						<cfif NOT isDefined('Form.ExCosts')>
						<td align="right">#LSCurrencyFormat(Expenses)#</td>
						<td align="right">#LSCurrencyFormat(GrossIncome - Expenses)#</td><!--- NetIncome miscalculated on null --->
						</cfif>
					</tr>
					</cfoutput>
					<cfoutput>
					<tr><td colspan="8" height="1" bgcolor="#cfAdminHeaderColor#"></td></tr>	
					<tr>
						<cfif Form.Frequency EQ 'Monthly'>
						<td></td>
						<td></td>
						<cfelseif Form.Frequency EQ 'Yearly'>
						<td></td>
						</cfif>
						<cfif Form.ReportType EQ 'Detailed' >
						<td align="right"><b>#getRevData.RecordCount#</b></td>
						<td align="right"></td>
						<cfelse>
						<td align="right"><b>#TotalOrders#</b></td>
						</cfif>
						<td align="right"><b>#TotalProducts#</b></td>
						<td align="right"><b>#LSCurrencyFormat(TotalGross)#</b></td>
						<cfif NOT isDefined('Form.ExCosts')>
						<td align="right"><b>#LSCurrencyFormat(TotalExpenses)#</b></td>
						<td align="right"><b>#LSCurrencyFormat(TotalGross - TotalExpenses)#</b></td>
						</cfif>
					</tr>
					</cfoutput>
				</table>
			</td>
		</tr>
		</cfif><!--- SHOW ORDER DETAILS --->
	</table>
	<!------------------------- END: DISPLAY RESULTS ------------------------->
	
	</cfif><!--- VIEWING - ONLINE OR PDF --->
	</CFIF><!--- IF QUERY RETURNS AT LEAST ONE RESULT --->












<!--- TAXES, SHIPPING, DISCOUNTS REPORT --->
<cfelse>
	
	<cfquery name="getRevData" datasource="#application.dsn#">
		SELECT 	SUM(oi.ItemPrice * oi.Qty) AS GrossIncome, SUM(oi.ItemPrice * oi.Qty) - SUM(oi.Qty * p.CostPrice) AS NetIncome,
				COUNT(oi.OrderItemsID) AS TotalUnits,
				
			<cfif Form.Frequency EQ 'Monthly'>
				DatePart(mm, o.DateEntered) AS MonthOrdered,
				DateName(mm, o.DateEntered) AS MonthOrdName,
				DatePart(yy, o.DateEntered) AS YearOrdered,
			<cfelseif Form.Frequency EQ 'Yearly'>
				DatePart(yy, o.DateEntered) AS YearOrdered,
			</cfif>
			o.OrderID AS NumOfOrders, o.TaxTotal, o.ShippingTotal, (o.DiscountTotal + o.CreditApplied) AS DiscountTotal, o.DateEntered AS OrderDate
			
		FROM	OrderItems oi, Products p, Orders o
		WHERE	oi.ItemID = p.ItemID
		AND		oi.OrderID = o.OrderID
		AND		o.DateEntered >= '#Form.FromDate#'
		AND		o.DateEntered <= '#DateFormat(DateAdd("d", 1, Form.ToDate),"mm/dd/yyyy")#'
		<cfif isDefined('FORM.ExUnbilled')>
		AND		o.OrderStatus != 'BO'
		AND		o.BillingStatus != 'NB'
		</cfif>
		<cfif isDefined('FORM.ExCanceled')>
		AND		o.OrderStatus != 'CA'
		AND		o.OrderStatus != 'RE'
		AND		o.BillingStatus != 'CA'
		AND		o.BillingStatus != 'RE'
		AND		o.BillingStatus != 'DE'
		</cfif>
		
		<cfif Form.ReportDetail IS 'ByUser' AND Form.SelectedUser NEQ ''>
		AND		o.OrderID IN
				(SELECT	oo.OrderID
				FROM 	Orders oo, Customers c
				WHERE	oo.CustomerID = c.CustomerID
				AND		c.PriceToUse = #Form.SelectedUser#
				AND		oo.DateEntered >= '#Form.FromDate#'
				AND	 	oo.DateEntered <= '#DateFormat(DateAdd("d", 1, Form.ToDate),"mm/dd/yyyy")#'
				)
		</cfif>
		<cfif Form.ReportDetail IS 'ByRegion' AND Form.SelectedRegion NEQ ''>
		AND		o.OrderID IN
				(SELECT	oo.OrderID
				FROM 	Orders oo, Customers c
				WHERE	oo.CustomerID = c.CustomerID
				AND		c.State = '#Form.SelectedRegion#'
				AND		oo.DateEntered >= '#Form.FromDate#'
				AND	 	oo.DateEntered <= '#DateFormat(DateAdd("d", 1, Form.ToDate),"mm/dd/yyyy")#'
				)
		</cfif>
		
		<cfif Form.Frequency EQ	'Monthly'>
			GROUP BY 	DatePart(mm, o.DateEntered),
						DateName(mm, o.DateEntered),
						DatePart(yy, o.DateEntered),
						o.OrderID, o.TaxTotal, o.ShippingTotal, o.DiscountTotal, o.CreditApplied, o.DateEntered
			ORDER BY 	DatePart(yy, o.DateEntered),
						DatePart(mm, o.DateEntered)					
		<cfelseif Form.Frequency EQ 'Yearly'>
			GROUP BY 	DatePart(yy, o.DateEntered),
						o.OrderID, o.TaxTotal, o.ShippingTotal, o.DiscountTotal, o.CreditApplied, o.DateEntered
			ORDER BY 	DatePart(yy, o.DateEntered)
		<cfelse>
			GROUP BY 	o.OrderID, o.TaxTotal, o.ShippingTotal, o.DiscountTotal, o.CreditApplied, o.DateEntered
		</cfif>
	</cfquery>
	
	<!---
	<cfdump var="#getRevData#" expand="no"><cfabort>
	--->
	
	<cfif getRevData.RecordCount EQ 0 >
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
	<cfelseif Form.ChartType EQ 'none' AND isDefined('ExOrderDetails') >
		<table width="620" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td width="100%" align="center" class="cfAdminError">
					<br/><br/>
					You have chosen not to view an order chart nor order details.  Please try again.
					<br/><br/>
					<input type="button" name="GoBack" value="<< GO BACK" alt="Go Back" class="cfAdminButton"
						onClick="javascript:history.back()">
				</td>
			</tr>
		</table>
		<cfinclude template="LayoutAdminFooter.cfm">
		<cfabort>
	<CFELSE>
	
	<cfscript>
		TotalGross = 0;
		TotalExpenses = 0;
		TotalProducts = 0;
		TotalTax = 0 ;
		TotalShipping = 0 ;
		TotalDiscount = 0 ;
		Expenses = 0;
		
		// SET VARIABLES TO BE USED TO CREATE CHARTS
		if (Form.Frequency EQ 'Monthly')
		{
			Xaxis = 'Month';
			PieItemCol = 'MonthOrdName';
		}
		else if (Form.Frequency EQ 'Yearly')
		{
			Xaxis = 'Year';
			PieItemCol = 'YearOrdered';
		}
		else
		{
			Xaxis = 'Time';
			PieItemCol = 'NumOfOrders';
		}
	</cfscript>
	
	<cfloop query="getRevData">
		<cfscript>
			if ( NOT isDefined('getRevData.GrossIncome') OR getRevData.GrossIncome EQ '' )
				getRevData.GrossIncome = 0 ;
			if ( NOT isDefined('getRevData.TotalUnits') OR getRevData.TotalUnits EQ '' )
				getRevData.TotalUnits = 0 ;
			if ( NOT isDefined('getRevData.NumOfOrders') OR getRevData.NumOfOrders EQ '' )
				getRevData.NumOfOrders = 0 ;
			if ( NOT isDefined('getRevData.TaxTotal') OR getRevData.TaxTotal EQ '' )
				getRevData.TaxTotal = 0 ;
			if ( NOT isDefined('getRevData.ShippingTotal') OR getRevData.ShippingTotal EQ '' )
				getRevData.ShippingTotal = 0 ;
			if ( NOT isDefined('getRevData.DiscountTotal') OR getRevData.DiscountTotal EQ '' )
				getRevData.DiscountTotal = 0 ;
			TotalGross 		= TotalGross + NumberFormat(getRevData.GrossIncome,.99) ;
			TotalProducts	= TotalProducts + NumberFormat(getRevData.TotalUnits,.99) ;
			TotalTax		= TotalTax + NumberFormat(getRevData.TaxTotal,.99) ;
			TotalShipping	= TotalShipping + NumberFormat(getRevData.ShippingTotal,.99) ;
			TotalDiscount	= TotalDiscount + NumberFormat(getRevData.DiscountTotal,.99) ;
		</cfscript>
	</cfloop>
	
	<!--- PDF VIEW --->
	<cfif FORM.DisplayView EQ 'PDF'>
	<cfdocument format="pdf">
		<style type="text/css">
			TD, DIV
			{ <cfif ChartType EQ 'none' >font-size:10px;<cfelse>font-size:14px;</cfif> font-family:Verdana, Arial, Helvetica, sans-serif; }
		</style>
	
	<table width="100%" border="0" bordercolor="<cfoutput>#cfAdminHeaderColor#</cfoutput>" cellpadding="3" cellspacing="0" class="cfAdminDefault">
		<cfdocumentitem type="header">
		<tr>
			<td align="center" height="25">
				<div align="center">
				<cfoutput>
					<b>ORDERS SUMMARY</b>
					<cfif Form.ReportDetail IS 'ByUser'>
						<cfinvoke component="#application.Queries#" method="getUser" returnvariable="getUser">
							<cfinvokeargument name="UID" value="#Form.SelectedUser#">
						</cfinvoke>
						| BY USER: <b>#getUser.UName#</b>
					<cfelseif Form.ReportDetail IS 'ByRegion'>
						<cfquery name="getState" datasource="#application.dsn#">
							SELECT	State
							FROM	States
							WHERE	StateCode = '#Form.SelectedRegion#'
						</cfquery>
						| BY REGION: <b>#getState.State#</b>
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
		
		<!--- BEGIN: CHART --->
		<cfif ChartType NEQ 'none' >
		<tr>
			<td>
				<cfif ChartType NEQ 'PIE'>		
					<cfchart 
						labelformat="currency" 
						xaxistitle="Details" 
						yaxistitle="Amount"
						chartheight="400" 
						chartwidth="800" 
						markersize="2"
						databackgroundcolor="#cfAdminHeaderColor#"
						seriesplacement="Default" 
						showygridlines="yes" 
						format="png" 
						showlegend="no" 
						showmarkers="yes" 
						show3d="yes" >
				
						<!--- BEGIN: CHART SERIES --->
						<cfchartseries 
							type="#ChartType#" 
							paintstyle="light" 
							serieslabel="Revenue"
							markerstyle="diamond">
							<cfchartdata item="Gross Revenue" value="#TotalGross#">
							<cfchartdata item="Discounts" value="#TotalDiscount#">
							<cfchartdata item="Shipping" value="#TotalShipping#">
							<cfchartdata item="Tax" value="#TotalTax#">
						</cfchartseries>
						<!--- END: CHART SERIES --->
					</cfchart>
				</cfif>
				
				<cfif ChartType EQ 'Pie'>
					<cfchart 
						labelformat="currency"
						xaxistitle="Time Interval" 
						yaxistitle="Amount" 
						chartheight="400" 
						chartwidth="800" 
						seriesplacement="Default" 
						format="png" 
						pieslicestyle="#PieStyle#" 
						show3D="Yes" >
						
						<!--- BEGIN: CHART SERIES --->
						<cfchartseries
							type="pie"
							paintstyle="raise"			 
							seriescolor="FF0000" 
							serieslabel="Cost" >
								<cfchartdata item="Gross Revenue" value="#TotalGross#">
								<cfchartdata item="Discounts" value="#TotalDiscount#">
								<cfchartdata item="Shipping" value="#TotalShipping#">
								<cfchartdata item="Tax" value="#TotalTax#">
							</cfchartseries>						
						<!--- END: CHART SERIES --->
					</cfchart>
				</cfif>
				
			</td>
		</tr>
		</cfif>
		<!--- END: CHART --->
		
		<cfif NOT isDefined('FORM.ExOrderDetails')>	
		<!------------------------- BEGIN: DISPLAY RESULTS ------------------------->
		<tr>
			<td width="100%">
				<table width="100%" border="0" cellpadding="3" cellspacing="0" class="cfAdminDefault">
					<tr style="background-color:##65ADF1;">
						<cfif Form.Frequency EQ 'Monthly'>
						<td class="cfAdminHeader1">Month</td>
						<td class="cfAdminHeader1">Year</td>
						<cfelseif Form.Frequency EQ 'Yearly'>
						<td class="cfAdminHeader1">Year</td>
						</cfif>
						<td align="right" class="cfAdminHeader1">Orders</td>
						<td align="right" class="cfAdminHeader1">Date</td>
						<td align="right" class="cfAdminHeader1">Products Sold</td>
						<td align="right" class="cfAdminHeader1">Product Revenue</td>
						<td align="right" class="cfAdminHeader1">Discounts</td>
						<td align="right" class="cfAdminHeader1">Shipping</td>
						<td align="right" class="cfAdminHeader1">Tax Collected</td>
						<td align="right" class="cfAdminHeader1">Order Total</td>
					</tr>
					<cfoutput query="getRevData">
					<tr>
						<cfif Form.Frequency EQ 'Monthly'>
						<td>#MonthOrdName#</td>
						<td>#YearOrdered#</td>
						<cfelseif Form.Frequency EQ 'Yearly'>
						<td>#YearOrdered#</td>
						</cfif>
						<td align="right">#NumOfOrders#</td>
						<td align="right">#DateFormat(OrderDate,'mm/dd/yyyy')#</td>
						<td align="right">#TotalUnits#</td>
						<td align="right">#LSCurrencyFormat(GrossIncome)#</td>
						<td align="right">#LSCurrencyFormat(DiscountTotal)#</td>
						<td align="right">#LSCurrencyFormat(ShippingTotal)#</td>
						<td align="right">#LSCurrencyFormat(TaxTotal)#</td>
						<td align="right">#LSCurrencyFormat(GrossIncome - DiscountTotal + ShippingTotal + TaxTotal)#</td>
					</tr>
					</cfoutput>
					<cfoutput>
					<tr><td colspan="9" height="1" bgcolor="#cfAdminHeaderColor#"></td></tr>
					<tr>
						<cfif Form.Frequency EQ 'Monthly'>
						<td></td>
						<td></td>
						<cfelseif Form.Frequency EQ 'Yearly'>
						<td></td>
						</cfif>
						<td align="right"><b>#getRevData.RecordCount#</b></td>
						<td align="right"><b>#TotalProducts#</b></td>
						<td align="right"></td>
						<td align="right"><b>#LSCurrencyFormat(TotalGross)#</b></td>
						<td align="right"><b>#LSCurrencyFormat(TotalDiscount)#</b></td>
						<td align="right"><b>#LSCurrencyFormat(TotalShipping)#</b></td>
						<td align="right"><b>#LSCurrencyFormat(TotalTax)#</b></td>
						<td align="right"><b>#LSCurrencyFormat(TotalGross - TotalDiscount + TotalShipping + TotalTax)#</b></td>
					</tr>
					</cfoutput>
				</table>
			</td>
		</tr>
		</cfif><!--- SHOW ORDER DETAILS --->
		<cfdocumentitem type="footer">
		<tr>
			<td align="center">	
				<div align="center">
					<cfoutput>
					Page <b>#cfdocument.currentpagenumber#</b> of <b>#cfdocument.totalpagecount#</b>
					</cfoutput>
				</div>
			</td>
		</tr>
		</cfdocumentitem>
	</table>
	<!------------------------- END: DISPLAY RESULTS ------------------------->
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
					<b>ORDERS SUMMARY</b>
					<cfif Form.ReportDetail IS 'ByUser'>
						<cfinvoke component="#application.Queries#" method="getUser" returnvariable="getUser">
							<cfinvokeargument name="UID" value="#Form.SelectedUser#">
						</cfinvoke>
						| BY USER: <b>#getUser.UName#</b>
					<cfelseif Form.ReportDetail IS 'ByRegion'>
						<cfquery name="getState" datasource="#application.dsn#">
							SELECT	State
							FROM	States
							WHERE	StateCode = '#Form.SelectedRegion#'
						</cfquery>
						| BY REGION: <b>#getState.State#</b>
					</cfif>
					<cfif Form.FromDate NEQ '' AND Form.ToDate NEQ '' >
						| FROM: <b>#DateFormat(Form.FromDate,"mmm dd, yyyy")#</b> 
						  TO: <b>#DateFormat(Form.ToDate,"mmm dd, yyyy")#</b>
					</cfif>
				</cfoutput>
				</div>
			</td>
		</tr>
		
		<!--- BEGIN: CHART --->
		<cfif ChartType NEQ 'none' >
		<tr>
			<td>
				<cfif ChartType NEQ 'PIE'>		
					<cfchart 
						labelformat="currency" 
						xaxistitle="Details" 
						yaxistitle="Amount"
						chartheight="400" 
						chartwidth="800" 
						markersize="2"
						databackgroundcolor="#cfAdminHeaderColor#"
						seriesplacement="Default" 
						showygridlines="yes" 
						format="png" 
						showlegend="no" 
						showmarkers="yes" 
						show3d="yes" >
				
						<!--- BEGIN: CHART SERIES --->
						<cfchartseries 
							type="#ChartType#" 
							paintstyle="light" 
							serieslabel="Revenue"
							markerstyle="diamond">
							<cfchartdata item="Gross Revenue" value="#TotalGross#">
							<cfchartdata item="Discounts" value="#TotalDiscount#">
							<cfchartdata item="Shipping" value="#TotalShipping#">
							<cfchartdata item="Tax" value="#TotalTax#">
						</cfchartseries>
						<!--- END: CHART SERIES --->
					</cfchart>
				</cfif>
				
				<cfif ChartType EQ 'Pie'>
					<cfchart 
						labelformat="currency"
						xaxistitle="Time Interval" 
						yaxistitle="Amount" 
						chartheight="400" 
						chartwidth="800" 
						seriesplacement="Default" 
						format="png" 
						pieslicestyle="#PieStyle#" 
						show3D="Yes" >
						
						<!--- BEGIN: CHART SERIES --->
						<cfchartseries
							type="pie"
							paintstyle="raise"			 
							seriescolor="FF0000" 
							serieslabel="Cost" >
								<cfchartdata item="Gross Revenue" value="#TotalGross#">
								<cfchartdata item="Discounts" value="#TotalDiscount#">
								<cfchartdata item="Shipping" value="#TotalShipping#">
								<cfchartdata item="Tax" value="#TotalTax#">
							</cfchartseries>						
						<!--- END: CHART SERIES --->
					</cfchart>
				</cfif>
				
			</td>
		</tr>
		</cfif>
		<!--- END: CHART --->
		
		<cfif NOT isDefined('FORM.ExOrderDetails')>	
		<!------------------------- BEGIN: DISPLAY RESULTS ------------------------->
		<tr>
			<td width="100%">
				<table width="100%" border="0" cellpadding="3" cellspacing="0" class="cfAdminDefault">
					<tr style="background-color:##65ADF1;">
						<cfif Form.Frequency EQ 'Monthly'>
						<td class="cfAdminHeader1">Month</td>
						<td class="cfAdminHeader1">Year</td>
						<cfelseif Form.Frequency EQ 'Yearly'>
						<td class="cfAdminHeader1">Year</td>
						</cfif>
						<td align="right" class="cfAdminHeader1">Orders</td>
						<td align="right" class="cfAdminHeader1">Date</td>
						<td align="right" class="cfAdminHeader1">Products Sold</td>
						<td align="right" class="cfAdminHeader1">Product Revenue</td>
						<td align="right" class="cfAdminHeader1">Discounts</td>
						<td align="right" class="cfAdminHeader1">Shipping</td>
						<td align="right" class="cfAdminHeader1">Tax Collected</td>
						<td align="right" class="cfAdminHeader1">Order Total</td>
					</tr>
					<cfoutput query="getRevData">
					<tr>
						<cfif Form.Frequency EQ 'Monthly'>
						<td>#MonthOrdName#</td>
						<td>#YearOrdered#</td>
						<cfelseif Form.Frequency EQ 'Yearly'>
						<td>#YearOrdered#</td>
						</cfif>
						<td align="right">#NumOfOrders#</td>
						<td align="right">#DateFormat(OrderDate,'mm/dd/yyyy')#</td>
						<td align="right">#TotalUnits#</td>
						<td align="right">#LSCurrencyFormat(GrossIncome)#</td>
						<td align="right">#LSCurrencyFormat(DiscountTotal)#</td>
						<td align="right">#LSCurrencyFormat(ShippingTotal)#</td>
						<td align="right">#LSCurrencyFormat(TaxTotal)#</td>
						<td align="right">#LSCurrencyFormat(GrossIncome - DiscountTotal + ShippingTotal + TaxTotal)#</td>
					</tr>
					</cfoutput>
					<cfoutput>
					<tr><td colspan="9" height="1" bgcolor="#cfAdminHeaderColor#"></td></tr>
					<tr>
						<cfif Form.Frequency EQ 'Monthly'>
						<td></td>
						<td></td>
						<cfelseif Form.Frequency EQ 'Yearly'>
						<td></td>
						</cfif>
						<td align="right"><b>#getRevData.RecordCount#</b></td>
						<td align="right"><b>#TotalProducts#</b></td>
						<td align="right"></td>
						<td align="right"><b>#LSCurrencyFormat(TotalGross)#</b></td>
						<td align="right"><b>#LSCurrencyFormat(TotalDiscount)#</b></td>
						<td align="right"><b>#LSCurrencyFormat(TotalShipping)#</b></td>
						<td align="right"><b>#LSCurrencyFormat(TotalTax)#</b></td>
						<td align="right"><b>#LSCurrencyFormat(TotalGross - TotalDiscount + TotalShipping + TotalTax)#</b></td>
					</tr>
					</cfoutput>
				</table>
			</td>
		</tr>
		</cfif><!--- SHOW ORDER DETAILS --->
	</table>
	<!------------------------- END: DISPLAY RESULTS ------------------------->
	
	</cfif><!--- VIEWING - ONLINE OR PDF --->
	</CFIF><!--- IF QUERY RETURNS AT LEAST ONE RESULT --->




</cfif>

<cfinclude template="LayoutAdminFooter.cfm">