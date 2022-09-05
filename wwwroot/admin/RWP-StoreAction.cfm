<cfscript>
	PageTitle = 'REPORT WIZARD PRO: Store' ;
	BannerTitle = 'ReportWizard' ;
	AddAButton = 'RETURN TO REPORT WIZARD' ;
	AddAButtonLoc = 'RWP-ReportWizard.cfm' ;
	ReportPage = 'RWP-Store.cfm' ;
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">

<cfparam name="Form.ReportDetail" default="">
<cfparam name="Form.SortOption" default="">
<cfscript>
	if (NOT isDefined('ChartType'))
		ChartType = 'bar';
</cfscript>

<cfquery name="getProductData" datasource="#application.dsn#">
	SELECT 	p.ItemID, p.SKU, p.ItemName, p.Category, p.SectionID
	<cfif Form.ReportType NEQ 'ProductList'>
	,
	(
		SELECT 	SUM(oi.Qty )
		FROM 	OrderItems oi, Orders o
		WHERE	oi.ItemID = p.ItemID
		AND		oi.OrderID = o.OrderID
		<cfif Form.FromDate NEQ '' AND Form.ToDate NEQ '' >
		AND		o.DateEntered >= '#Form.FromDate#'
		AND	 	o.DateEntered <= '#DateFormat(DateAdd("d", 1, Form.ToDate),"mm/dd/yyyy")#'
		</cfif>
	)
	AS ProductSold,
	(
		SELECT 	COUNT(o.OrderID)
		FROM 	OrderItems oi, Orders o
		WHERE	o.OrderID = oi.OrderID
		AND		oi.ItemID = p.ItemID
		<cfif Form.FromDate NEQ '' AND Form.ToDate NEQ '' >
		AND		o.DateEntered >= '#Form.FromDate#'
		AND	 	o.DateEntered <= '#DateFormat(DateAdd("d", 1, Form.ToDate),"mm/dd/yyyy")#'
		</cfif>
	)
	AS ProductOrders,
	(
		SELECT 	SUM(oi.ItemPrice * oi.Qty)
		FROM	OrderItems oi, Orders o
		WHERE	oi.OrderID = o.OrderID
		AND		oi.ItemID = p.ItemID
		<cfif Form.FromDate NEQ '' AND Form.ToDate NEQ '' >
		AND		o.DateEntered >= '#Form.FromDate#'
		AND	 	o.DateEntered <= '#DateFormat(DateAdd("d", 1, Form.ToDate),"mm/dd/yyyy")#'
		</cfif>
	)
	AS ProductGross,
	(
		SELECT 	SUM(oi.Qty * pp.CostPrice)
		FROM	OrderItems oi, Products pp, Orders o
		WHERE	oi.ItemID = pp.ItemID
		AND		pp.ItemID = p.ItemID
		AND		oi.OrderID = o.OrderID
		<cfif Form.FromDate NEQ '' AND Form.ToDate NEQ '' >
		AND		o.DateEntered >= '#Form.FromDate#'
		AND	 	o.DateEntered <= '#DateFormat(DateAdd("d", 1, Form.ToDate),"mm/dd/yyyy")#'
		</cfif>
	)
	AS ProductExpenses,
	(
		SELECT 	SUM(oi.ItemPrice * oi.Qty)
		FROM	OrderItems oi, Orders o
		WHERE	oi.OrderID = o.OrderID
		AND		oi.ItemID = p.ItemID
		<cfif Form.FromDate NEQ '' AND Form.ToDate NEQ '' >
		AND		o.DateEntered >= '#Form.FromDate#'
		AND	 	o.DateEntered <= '#DateFormat(DateAdd("d", 1, Form.ToDate),"mm/dd/yyyy")#'
		</cfif>
	) -
	(
		SELECT 	SUM(oi.Qty * pp.CostPrice)
		FROM	OrderItems oi, Products pp, Orders o
		WHERE	oi.ItemID = pp.ItemID
		AND		pp.ItemID = p.ItemID
		AND		oi.OrderID = o.OrderID
		<cfif Form.FromDate NEQ '' AND Form.ToDate NEQ '' >
		AND		o.DateEntered >= '#Form.FromDate#'
		AND	 	o.DateEntered <= '#DateFormat(DateAdd("d", 1, Form.ToDate),"mm/dd/yyyy")#'
		</cfif>
	) AS ProductNet
	</cfif>
	
	FROM	Products p
	WHERE	p.ItemID = p.ItemID

<cfif Form.ReportType EQ 'Categories' AND Form.Category NEQ '' >
	AND		(
			p.Category = #Form.Category#
	OR		p.Category IN
		   (SELECT  CatID
			FROM	Categories
			WHERE	SubCategoryOf = #Form.Category# )
	OR		p.Category IN
		   (SELECT  CatID
			FROM	Categories
			WHERE	SubCategoryOf IN
		   (SELECT  CatID
			FROM	Categories
			WHERE	SubCategoryOf = #Form.Category# ))
	OR		p.Category IN
		   (SELECT  CatID
			FROM	Categories
			WHERE	SubCategoryOf IN
		   (SELECT  CatID
			FROM	Categories
			WHERE	SubCategoryOf IN
		   (SELECT  CatID
			FROM	Categories
			WHERE	SubCategoryOf = #Form.Category# )))
	OR		p.Category IN
		   (SELECT  CatID
			FROM	Categories
			WHERE	SubCategoryOf IN
		   (SELECT  CatID
			FROM	Categories
			WHERE	SubCategoryOf IN
		   (SELECT  CatID
			FROM	Categories
			WHERE	SubCategoryOf IN
		   (SELECT  CatID
			FROM	Categories
			WHERE	SubCategoryOf = #Form.Category# ))))
	OR		p.Category IN
		   (SELECT  CatID
			FROM	Categories
			WHERE	SubCategoryOf IN
		   (SELECT  CatID
			FROM	Categories
			WHERE	SubCategoryOf IN
		   (SELECT  CatID
			FROM	Categories
			WHERE	SubCategoryOf IN
		   (SELECT  CatID
			FROM	Categories
			WHERE	SubCategoryOf IN
		   (SELECT  CatID
			FROM	Categories
			WHERE	SubCategoryOf = #Form.Category# )))))
			)
<cfelseif Form.ReportType EQ 'Sections' AND Form.Section NEQ '' >
	AND		(
			p.SectionID = #Form.Section#
	OR		p.SectionID IN
		   (SELECT  SectionID
			FROM	Sections
			WHERE	SubSectionOf = #Form.Section# )
	OR		p.SectionID IN
		   (SELECT  SectionID
			FROM	Sections
			WHERE	SubSectionOf IN
		   (SELECT  SectionID
			FROM	Sections
			WHERE	SubSectionOf = #Form.Section# ))
	OR		p.SectionID IN
		   (SELECT  SectionID
			FROM	Sections
			WHERE	SubSectionOf IN
		   (SELECT  SectionID
			FROM	Sections
			WHERE	SubSectionOf IN
		   (SELECT  SectionID
			FROM	Sections
			WHERE	SubSectionOf = #Form.Section# )))
	OR		p.SectionID IN
		   (SELECT  SectionID
			FROM	Sections
			WHERE	SubSectionOf IN
		   (SELECT  SectionID
			FROM	Sections
			WHERE	SubSectionOf IN
		   (SELECT  SectionID
			FROM	Sections
			WHERE	SubSectionOf IN
		   (SELECT  SectionID
			FROM	Sections
			WHERE	SubSectionOf = #Form.Section# ))))
	OR		p.SectionID IN
		   (SELECT  SectionID
			FROM	Sections
			WHERE	SubSectionOf IN
		   (SELECT  SectionID
			FROM	Sections
			WHERE	SubSectionOf IN
		   (SELECT  SectionID
			FROM	Sections
			WHERE	SubSectionOf IN
		   (SELECT  SectionID
			FROM	Sections
			WHERE	SubSectionOf IN
		   (SELECT  SectionID
			FROM	Categories
			WHERE	SubSectionOf = #Form.Section# )))))
			)
</cfif>	

<!--- INCLUDE UNORDERED ITEMS ??? --->
<cfif NOT isDefined('Form.IncNoOrders')>
	AND		p.ItemID IN
			(SELECT	oi.ItemID
			FROM 	OrderItems oi, Orders o
			WHERE	oi.ItemID = p.ItemID
			AND		oi.OrderID = o.OrderID
			AND		o.DateEntered >= '#Form.FromDate#'
			AND	 	o.DateEntered <= '#DateFormat(DateAdd("d", 1, Form.ToDate),"mm/dd/yyyy")#'
			)
	<cfif Form.ReportDetail IS 'ByUser' AND Form.SelectedUser NEQ ''>
	AND		p.ItemID IN
			(SELECT	pp.ItemID
			FROM 	Products pp, OrderItems oi, Orders o, Customers c
			WHERE	pp.ItemID = p.ItemID
			AND		pp.ItemID = oi.ItemID
			AND		oi.OrderID = o.OrderID
			AND		o.CustomerID = c.CustomerID
			AND		c.PriceToUse = #Form.SelectedUser#
			AND		o.DateEntered >= '#Form.FromDate#'
			AND	 	o.DateEntered <= '#DateFormat(DateAdd("d", 1, Form.ToDate),"mm/dd/yyyy")#'
			)
	</cfif>
	<cfif Form.ReportDetail IS 'ByRegion' AND Form.SelectedRegion NEQ ''>
	AND		p.ItemID IN
			(SELECT	pp.ItemID
			FROM 	Products pp, OrderItems oi, Orders o, Customers c
			WHERE	pp.ItemID = p.ItemID
			AND		pp.ItemID = oi.ItemID
			AND		oi.OrderID = o.OrderID
			AND		o.CustomerID = c.CustomerID
			AND		c.State = '#Form.SelectedRegion#'
			AND		o.DateEntered >= '#Form.FromDate#'
			AND	 	o.DateEntered <= '#DateFormat(DateAdd("d", 1, Form.ToDate),"mm/dd/yyyy")#'
			)
	</cfif>
</cfif><!--- INCLUDE UNORDERED ITEMS ??? --->

<cfif Form.SortOption IS 'ItemName'>
	ORDER BY p.ItemName <cfif Form.ReportType NEQ 'ProductList'>, ProductSold DESC, ProductGross DESC</cfif>, p.SKU
<cfelseif Form.SortOption IS 'SKU'>
	ORDER BY p.SKU <cfif Form.ReportType NEQ 'ProductList'>, ProductSold DESC, ProductGross DESC</cfif>
<cfelseif Form.SortOption IS 'ItemID'>
	ORDER BY p.ItemID <cfif Form.ReportType NEQ 'ProductList'>, ProductSold DESC, ProductGross DESC</cfif>
<cfelseif Form.SortOption IS 'Quantity'>
	ORDER BY <cfif Form.ReportType NEQ 'ProductList'>ProductSold DESC, ProductGross DESC, </cfif> p.SKU
<cfelse>
	ORDER BY <cfif Form.ReportType NEQ 'ProductList'>ProductGross DESC, ProductSold DESC, </cfif> p.SKU
</cfif>

</cfquery>

<!---
<cfdump var="#getProductData#" expand="no"><cfabort>
--->


<cfif getProductData.RecordCount EQ 0 >
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
<cfelseif Form.ChartType EQ 'none' AND isDefined('ExProductDetails') >
	<table width="620" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td width="100%" align="center" class="cfAdminError">
				<br/><br/>
				You have chosen not to view a product chart nor product details.  Please try again.
				<br/><br/>
				<input type="button" name="GoBack" value="<< GO BACK" alt="Go Back" class="cfAdminButton"
					onClick="javascript:history.back()">
			</td>
		</tr>
	</table>
	<cfinclude template="LayoutAdminFooter.cfm">
	<cfabort>
<CFELSE>

<!---<cfdump var="#getProductData#"><cfabort>--->




<cfif Form.ReportType NEQ 'ProductList'>

	<cfscript>
		TotalGross = 0;
		TotalExpenses = 0;
		TotalProductsSold = 0;
		TotalProductOrders = 0;
		
		// SET VARIABLES TO BE USED TO CREATE CHARTS
		Xaxis = 'Product';
		if ( Form.SortOption IS 'ItemName' )
			PieItemCol = 'ItemName';
		else if ( Form.SortOption IS 'SKU' )
			PieItemCol = 'SKU';
		else if ( Form.SortOption IS 'ItemID' )
			PieItemCol = 'ItemID';
		else
			PieItemCol = 'SKU';			
	</cfscript>
	
	<cfloop query="getProductData">
		<cfscript>
			if (getProductData.ProductGross LTE 0)
				getProductData.ProductGross = 0 ;		
			if (getProductData.ProductExpenses LTE 0)
				getProductData.ProductExpenses = 0 ;
			TotalGross 		= TotalGross + NumberFormat(getProductData.ProductGross,.99);
			TotalExpenses	= TotalExpenses + NumberFormat(ProductExpenses,.99);
			TotalProductsSold		= TotalProductsSold + NumberFormat(ProductSold,9);
			TotalProductOrders		= TotalProductOrders + NumberFormat(ProductOrders,9);
		</cfscript>
	</cfloop>
	
	<!--- PDF VIEW --->
	<cfif FORM.DisplayView EQ 'PDF'>
	<cfdocument format="PDF">
		<style type="text/css">
			TD, DIV
			{ <cfif ChartType EQ 'none' >font-size:10px;<cfelse>font-size:15px;</cfif> font-family:Verdana, Arial, Helvetica, sans-serif; }
		</style>
	
	<table width="100%" border="0" bordercolor="<cfoutput>#cfAdminHeaderColor#</cfoutput>" cellpadding="3" cellspacing="0" class="cfAdminDefault">
		<cfdocumentitem type="header">
		<tr>
			<td align="center" height="25">
				<div align="center">
				<cfoutput>
					<cfif Form.ReportType IS 'Products'>
						<b>ALL PRODUCT SALES</b>
					<cfelseif Form.ReportType IS 'Categories' AND Form.Category NEQ ''>
						<cfinvoke component="#application.Queries#" method="getCategory" returnvariable="getCategory">
							<cfinvokeargument name="CatID" value="#Form.Category#">
						</cfinvoke>
						PRODUCT SALES IN CATEGORY: <b>#getCategory.CatName#</b>
					<cfelseif Form.ReportType IS 'Sections'>
						<cfinvoke component="#application.Queries#" method="getSection" returnvariable="getSection">
							<cfinvokeargument name="SectionID" value="#Form.Section#">
						</cfinvoke>
						PRODUCT SALES IN SECTION: <b>#getSection.SecName#</b>
					</cfif>
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
		
		<cfif ChartType NEQ 'none' >
		<tr>
			<td>
			
				<!--- BEGIN: CHART --->
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
						<!--- CFMX 7: title="Products: #DateFormat(FromDate, 'mmm dd, yyyy')# to #DateFormat(ToDate, 'mmm dd, yyyy')#" --->
				
						<!--- BEGIN: CHART SERIES --->
						<cfoutput query="getProductData">
							<cfif NOT isDefined('ExCosts')>
								<cfchartseries 
									type="#ChartType#" 
									paintstyle="light" 
									serieslabel="Cost" 
									markerstyle="diamond">
									<cfchartdata item="#SKU#" value="#ProductExpenses#">
								</cfchartseries>
							</cfif>
							<cfchartseries 
								type="#ChartType#" 
								paintstyle="light" 
								serieslabel="Income"
								markerstyle="diamond">
								<cfchartdata item="#SKU#" value="#ProductGross#">
							</cfchartseries>
						</cfoutput>
						<!--- END: CHART SERIES --->
					</cfchart>
				</cfif>
				
				<cfif ChartType EQ 'Pie'>
					<cfchart 
						labelformat="currency"
						xaxistitle="Product" 
						yaxistitle="Amount" 
						chartheight="400" 
						chartwidth="800" 
						seriesplacement="Default" 
						format="png" 
						pieslicestyle="#PieStyle#" 
						show3D="Yes" >
						<!--- CFMX 7: title="Products: #DateFormat(FromDate, 'mmm dd, yyyy')# to #DateFormat(ToDate, 'mmm dd, yyyy')#" --->
						
						<!--- BEGIN: CHART SERIES --->
						<cfif isDefined('Form.ExCosts')>
							<cfchartseries 
								query="getProductData" 
								itemcolumn="#PieItemCol#" 
								valuecolumn="ProductGross" 
								type="pie" 
								paintstyle="raise"				 
								seriescolor="FF0000" 
								serieslabel="Cost" />
						<cfelse>
							<cfchartseries
								query="getProductData" 
								itemcolumn="#PieItemCol#" 
								valuecolumn="ProductGross" 
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
	
	
		<cfif NOT isDefined('FORM.ExProductDetails')>
		<!------------------------- BEGIN: DISPLAY RESULTS ------------------------->
			<tr>
				<td width="100%">
					<table width="100%" border="0" cellpadding="3" cellspacing="0" class="cfAdminDefault">
						<tr style="background-color:##65ADF1;">
							<td class="cfAdminHeader1">#</td>
							<cfif Form.SortOption IS 'ItemName'>
							<td class="cfAdminHeader1">Item Name</td>
							<cfelseif Form.SortOption IS 'SKU'>
							<td class="cfAdminHeader1">Item SKU</td>
							<cfelseif Form.SortOption IS 'ItemID'>
							<td class="cfAdminHeader1">Item ID</td>
							<cfelse>
							<td class="cfAdminHeader1">Item SKU</td>
							</cfif>
							<td align="right" class="cfAdminHeader1">Orders</td>
							<td align="right" class="cfAdminHeader1">Items Sold</td>
							<td align="right" class="cfAdminHeader1">Gross Revenue</td>
							<cfif NOT isDefined('Form.ExCosts')>
							<td align="right" class="cfAdminHeader1">Expenses</td>
							<td align="right" class="cfAdminHeader1">Net Revenue</td>
							</cfif>
						</tr>
						<cfoutput query="getProductData">
						<tr>
							<td>#CurrentRow#</td>
							<cfif Form.SortOption IS 'ItemName'>
							<td>#ItemName#</td>
							<cfelseif Form.SortOption IS 'SKU'>
							<td>#SKU#</td>
							<cfelseif Form.SortOption IS 'ItemID'>
							<td>#ItemID#: #SKU#</td>
							<cfelse>
							<td>#SKU#</td>
							</cfif>					
							<td align="right">#ProductOrders#</td>
							<td align="right">#NumberFormat(ProductSold,9)#</td>
							<td align="right">#LSCurrencyFormat(ProductGross)#</td>
							<cfif NOT isDefined('Form.ExCosts')>
							<td align="right">#LSCurrencyFormat(ProductExpenses)#</td>
							<td align="right">#LSCurrencyFormat(ProductGross - ProductExpenses)#</td><!--- ProductNet miscalculated on null --->
							</cfif>
						</tr>
						</cfoutput>
						<cfoutput>
						<!--- DIVIDER --->
						<tr><td height="1" colspan="7"><img src="images/image-LineGray.gif" width="100%" height="1"></td></tr>
						<tr>
							<td><b>#getProductData.RecordCount#</b></td>
							<cfif Form.ReportType EQ 'ByMonth'>
							<td></td>
							<td></td>
							<cfelseif Form.ReportType EQ 'ByYear'>
							<td></td>
							</cfif>
							<td></td>
							<td align="right"><b>#TotalProductOrders#</b></td>
							<td align="right"><b>#TotalProductsSold#</b></td>
							<td align="right"><b>#LSCurrencyFormat(TotalGross)#</b></td>
							<cfif NOT isDefined('Form.ExCosts')>
							<td align="right" class="cfAdminError"><b>#LSCurrencyFormat(TotalExpenses)#</b></td>
							<td align="right"><b>#LSCurrencyFormat(TotalGross - TotalExpenses)#</b></td>
							</cfif>
						</tr>
						</cfoutput>
					</table>
				</td>
			</tr>
		</cfif><!--- SHOW PRODUCT DETAILS --->
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
					<cfif Form.ReportType IS 'Products'>
						<b>ALL PRODUCT SALES</b>
					<cfelseif Form.ReportType IS 'Categories' AND Form.Category NEQ ''>
						<cfinvoke component="#application.Queries#" method="getCategory" returnvariable="getCategory">
							<cfinvokeargument name="CatID" value="#Form.Category#">
						</cfinvoke>
						PRODUCT SALES IN CATEGORY: <b>#getCategory.CatName#</b>
					<cfelseif Form.ReportType IS 'Sections'>
						<cfinvoke component="#application.Queries#" method="getSection" returnvariable="getSection">
							<cfinvokeargument name="SectionID" value="#Form.Section#">
						</cfinvoke>
						PRODUCT SALES IN SECTION: <b>#getSection.SecName#</b>
					</cfif>
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
		<cfif ChartType NEQ 'none' >
		<tr>
			<td>
			
				<!--- BEGIN: CHART --->
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
						<!--- CFMX 7: title="Products: #DateFormat(FromDate, 'mmm dd, yyyy')# to #DateFormat(ToDate, 'mmm dd, yyyy')#" --->
				
						<!--- BEGIN: CHART SERIES --->
						<cfoutput query="getProductData">
							<cfif NOT isDefined('ExCosts')>
								<cfchartseries 
									type="#ChartType#" 
									paintstyle="light" 
									serieslabel="Cost" 
									markerstyle="diamond">
									<cfchartdata item="#SKU#" value="#ProductExpenses#">
								</cfchartseries>
							</cfif>
							<cfchartseries 
								type="#ChartType#" 
								paintstyle="light" 
								serieslabel="Income"
								markerstyle="diamond">
								<cfchartdata item="#SKU#" value="#ProductGross#">
							</cfchartseries>
						</cfoutput>
						<!--- END: CHART SERIES --->
					</cfchart>
				</cfif>
				
				<cfif ChartType EQ 'Pie'>
					<cfchart 
						labelformat="currency"
						xaxistitle="Product" 
						yaxistitle="Amount" 
						chartheight="400" 
						chartwidth="800" 
						seriesplacement="Default" 
						format="png" 
						pieslicestyle="#PieStyle#" 
						show3D="Yes" >
						<!--- CFMX 7: title="Products: #DateFormat(FromDate, 'mmm dd, yyyy')# to #DateFormat(ToDate, 'mmm dd, yyyy')#" --->
						
						<!--- BEGIN: CHART SERIES --->
						<cfif isDefined('Form.ExCosts')>
							<cfchartseries 
								query="getProductData" 
								itemcolumn="#PieItemCol#" 
								valuecolumn="ProductGross" 
								type="pie" 
								paintstyle="raise"				 
								seriescolor="FF0000" 
								serieslabel="Cost" />
						<cfelse>
							<cfchartseries
								query="getProductData" 
								itemcolumn="#PieItemCol#" 
								valuecolumn="ProductGross" 
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
	
	
		<cfif NOT isDefined('FORM.ExProductDetails')>
		<!------------------------- BEGIN: DISPLAY RESULTS ------------------------->
			<tr>
				<td width="100%">
					<table width="100%" border="0" cellpadding="3" cellspacing="0" class="cfAdminDefault">
						<tr style="background-color:##65ADF1;">
							<td class="cfAdminHeader1">#</td>
							<cfif Form.SortOption IS 'ItemName'>
							<td class="cfAdminHeader1">Item Name</td>
							<cfelseif Form.SortOption IS 'SKU'>
							<td class="cfAdminHeader1">Item SKU</td>
							<cfelseif Form.SortOption IS 'ItemID'>
							<td class="cfAdminHeader1">Item ID</td>
							<cfelse>
							<td class="cfAdminHeader1">Item SKU</td>
							</cfif>
							<td align="right" class="cfAdminHeader1">Orders</td>
							<td align="right" class="cfAdminHeader1">Items Sold</td>
							<td align="right" class="cfAdminHeader1">Gross Revenue</td>
							<cfif NOT isDefined('Form.ExCosts')>
							<td align="right" class="cfAdminHeader1">Expenses</td>
							<td align="right" class="cfAdminHeader1">Net Revenue</td>
							</cfif>
						</tr>
						<cfoutput query="getProductData">
						<tr>
							<td>#CurrentRow#</td>
							<cfif Form.SortOption IS 'ItemName'>
							<td>#ItemName#</td>
							<cfelseif Form.SortOption IS 'SKU'>
							<td>#SKU#</td>
							<cfelseif Form.SortOption IS 'ItemID'>
							<td>#ItemID#: #SKU#</td>
							<cfelse>
							<td>#SKU#</td>
							</cfif>					
							<td align="right">#ProductOrders#</td>
							<td align="right">#NumberFormat(ProductSold,9)#</td>
							<td align="right">#LSCurrencyFormat(ProductGross)#</td>
							<cfif NOT isDefined('Form.ExCosts')>
							<td align="right">#LSCurrencyFormat(ProductExpenses)#</td>
							<td align="right">#LSCurrencyFormat(ProductGross - ProductExpenses)#</td><!--- ProductNet miscalculated on null --->
							</cfif>
						</tr>
						</cfoutput>
						<cfoutput>
						<!--- DIVIDER --->
						<tr><td height="1" colspan="7"><img src="images/image-LineGray.gif" width="100%" height="1"></td></tr>
						<tr>
							<td><b>#getProductData.RecordCount#</b></td>
							<cfif Form.ReportType EQ 'ByMonth'>
							<td></td>
							<td></td>
							<cfelseif Form.ReportType EQ 'ByYear'>
							<td></td>
							</cfif>
							<td></td>
							<td align="right"><b>#TotalProductOrders#</b></td>
							<td align="right"><b>#TotalProductsSold#</b></td>
							<td align="right"><b>#LSCurrencyFormat(TotalGross)#</b></td>
							<cfif NOT isDefined('Form.ExCosts')>
							<td align="right" class="cfAdminError"><b>#LSCurrencyFormat(TotalExpenses)#</b></td>
							<td align="right"><b>#LSCurrencyFormat(TotalGross - TotalExpenses)#</b></td>
							</cfif>
						</tr>
						</cfoutput>
					</table>
				</td>
			</tr>
		</cfif><!--- SHOW PRODUCT DETAILS --->
	</table>
	<!------------------------- END: DISPLAY RESULTS ------------------------->
	</cfif><!--- VIEWING - ONLINE OR PDF --->











<cfelse><!--- if Form.ReportType IS 'ProductList' --->
	
	<!--- PDF VIEW --->
	<cfif FORM.DisplayView EQ 'PDF'>
	<cfdocument format="PDF">
		<style type="text/css">
			TD, DIV
			{ font-size:10px; font-family:Verdana, Arial, Helvetica, sans-serif; }
		</style>
		
		<!------------------------- BEGIN: DISPLAY RESULTS ------------------------->
		<table width="100%" border="0" bordercolor="<cfoutput>#cfAdminHeaderColor#</cfoutput>" cellpadding="3" cellspacing="0" class="cfAdminDefault">
			<tr>
				<td width="100%">
					<table width="100%" border="0" cellpadding="3" cellspacing="0" class="cfAdminDefault">
						<cfdocumentitem type="header">
						<tr>
							<td colspan="3" align="center" height="25">
								<div align="center"><b><cfoutput>#UCASE(application.StoreNameShort)#</cfoutput> PRODUCT LIST</b></div>
							</td>
						</tr>
						<!--- DIVIDER --->
						<tr><td height="1" colspan="3"><img src="images/image-LineGray.gif" width="100%" height="1"></td></tr>
						</cfdocumentitem>
						<tr bgcolor="DDDDDD">
							<td class="cfAdminHeader1">Item ID</td>
							<td class="cfAdminHeader1">Item SKU</td>
							<td class="cfAdminHeader1">Item Name</td>
						</tr>
						<cfoutput query="getProductData">
						<tr>
							<td>#ItemID#</td>
							<td>#SKU#</td>
							<td>#ItemName#</td>
						</tr>
						</cfoutput>
						<cfoutput>
						<!--- DIVIDER --->
						<tr><td height="1" colspan="3"><img src="images/image-LineGray.gif" width="100%" height="1"></td></tr>
						<tr>
							<td colspan="3"><b>#getProductData.RecordCount# Total Products</b></td>
						</tr>
						<cfdocumentitem type="footer">
						<tr>
							<td colspan="3" align="center" height="30">	
								<div align="center">
									Page <b>#cfdocument.currentpagenumber#</b> of <b>#cfdocument.totalpagecount#</b>
								</div>
							</td>
						</tr>
						</cfdocumentitem>
						</cfoutput>
					</table>
				</td>
			</tr>
		</table>
		<!------------------------- END: DISPLAY RESULTS ------------------------->
	</cfdocument>
	
	<cfelse><!--- ONLINE VIEWING --->
	
		<!------------------------- BEGIN: DISPLAY RESULTS ------------------------->
		<table width="820" border="1" bordercolor="<cfoutput>#cfAdminHeaderColor#</cfoutput>" cellpadding="3" cellspacing="0" class="cfAdminDefault">
			<tr>
				<td width="100%">
					<table width="100%" border="0" cellpadding="3" cellspacing="0" class="cfAdminDefault">
						<tr>
							<td colspan="3" align="center" height="25">
								<div align="center"><b><cfoutput>#UCASE(application.StoreNameShort)#</cfoutput> PRODUCT LIST</b></div>
							</td>
						</tr>
						<!--- DIVIDER --->
						<tr><td height="1" colspan="3"><img src="images/image-LineGray.gif" width="100%" height="1"></td></tr>
						<tr bgcolor="DDDDDD">
							<td class="cfAdminHeader1">Item ID</td>
							<td class="cfAdminHeader1">Item SKU</td>
							<td class="cfAdminHeader1">Item Name</td>
						</tr>
						<cfoutput query="getProductData">
						<tr>
							<td>#ItemID#</td>
							<td>#SKU#</td>
							<td>#ItemName#</td>
						</tr>
						</cfoutput>
						<cfoutput>
						<!--- DIVIDER --->
						<tr><td height="1" colspan="3"><img src="images/image-LineGray.gif" width="100%" height="1"></td></tr>
						<tr>
							<td colspan="3"><b>#getProductData.RecordCount# Total Products</b></td>
						</tr>
						</cfoutput>
					</table>
				</td>
			</tr>
		</table>
		<!------------------------- END: DISPLAY RESULTS ------------------------->
		
	</cfif><!--- VIEWING - ONLINE OR PDF --->

</CFIF><!--- TYPE IS PRODUCT SALES OR PRODUCT LIST --->
</CFIF><!--- IF QUERY RETURNS AT LEAST ONE RESULT --->


<cfinclude template="LayoutAdminFooter.cfm">