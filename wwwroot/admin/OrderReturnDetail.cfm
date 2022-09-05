<!--- BEGIN: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<!--- ADD RMA --->
<cfif isDefined('Form.AddRMA') AND isDefined('Form.OrderID') AND isDefined('Form.ItemsSelected') AND Form.ItemsSelected NEQ '' AND isDefined('Form.QtyReturned') AND Form.QtyReturned NEQ '' >
	<cftry>
		<cfscript>
			Form.RMADate = #Now()# ;
			Form.CreatedBy = #GetAuthUser()# ;
			Form.DateReceived = '' ;
			Form.RMAComplete = 0 ;
			if ( Form.TaxReturned EQ '' )
			Form.TaxReturned = 0 ;
			if ( Form.ShippingReturned EQ '' )
			Form.ShippingReturned = 0 ;
		</cfscript>
		
		<!---<cfdump var="#FORM#">--->
		
		<cftransaction>
			<!--- ADD ORDER RETURN --->
			<cfinsert datasource="#application.dsn#" tablename="OrderReturns" 
				formfields="OrderID, RMA, RMADate, DateReceived, ReceivedTo, RMAComplete, CreatedBy, ChargeReturnTo, TaxReturned, ShippingReturned">
			
			<!--- GET THE LAST OrderReturnID JUST ADDED --->
			<cfquery name="getLastRMA" datasource="#application.dsn#">
				SELECT 	MAX(OrderReturnID) as LastOrderReturnID
				FROM	OrderReturns
			</cfquery>
			
			<!--- LOOP THROUGH ItemsSelected AND UPDATE DB TABLES --->
			<cfloop index="ThisItemID" list="#Form.ItemsSelected#"> 
				<cfquery name="addRMAItems" datasource="#application.dsn#">	
					INSERT INTO	OrderReturnItems ( OrderReturnID, OrderReturnItemID, QtyReturned )
					VALUES ( #getLastRMA.LastOrderReturnID#, #ThisItemID#, #ListGetAt(Form.QtyReturned,ListFind(Form.ItemsSelected,ThisItemID))# )
				</cfquery>
			</cfloop>
		</cftransaction>		
		
		<cfset AdminMsg = 'RMA #form.RMA# Added Successfully' >		
		
		<cfcatch>
			<cfset AdminMsg = 'FAIL: RMA not added. #cfcatch.Message#' >
		</cfcatch>
	</cftry>
</cfif>

<!--- UPDATE RMA --->
<cfif isDefined('Form.UpdateRMAInfo') AND isDefined('Form.OrderID')>
	<cftry>
		<cfscript>
			Form.RMADate = #Now()#;
			Form.CreatedBy = #GetAuthUser()#;
		</cfscript>

		<cfupdate datasource="#application.dsn#" tablename="OrderReturns" 
			formfields="OrderReturnID, OrderID, RMA, RMADate, DateReceived, ReceivedTo, RMAComplete, CreatedBy, ChargeReturnTo, TaxReturned, ShippingReturned">

		<cfset AdminMsg = 'RMA #form.RMA# Information Updated Successfully' >

		<cfcatch>
			<cfset AdminMsg = 'FAIL: Order NOT Updated. #cfcatch.Message#' >
		</cfcatch>
	</cftry>
</cfif>

<!--- DELETE RMA --->
<cfif isDefined('form.DeleteRMA') AND IsDefined("form.OrderReturnID")>
	<cftry>
		<cftransaction>
			<cfquery name="deleteRMA" datasource="#application.dsn#">
				DELETE 
				FROM	OrderReturns
				WHERE	OrderReturnID = #Form.OrderReturnID#
			</cfquery>
			<cfquery name="deleteRMAItems" datasource="#application.dsn#">
				DELETE 
				FROM	OrderReturnItems
				WHERE	OrderReturnID = #Form.OrderReturnID#
			</cfquery>
		</cftransaction>
		
		<cfset AdminMsg = 'RMA #form.RMA# Deleted Successfully' >

		<cfcatch>
			<cfset AdminMsg = 'FAIL: RMA NOT Deleted' >
		</cfcatch>
	</cftry>
</cfif>

<!--- END: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<!--- BEGIN: QUERIES ------------------------------------------------------------->
<cfquery name="getOrderReturns" datasource="#application.dsn#">
	SELECT	*
	FROM	OrderReturns
	WHERE	OrderID = #OrderID#
</cfquery>
<cfinvoke component="#application.Queries#" method="getOrder" returnvariable="getOrder">
	<cfinvokeargument name="OrderID" value="#OrderID#">
</cfinvoke>
<cfquery name="getOrderItems" datasource="#application.dsn#">
	SELECT	oi.OrderItemsID, oi.Qty, oi.ItemPrice, oi.StatusCode, oi.OptionName1, oi.OptionName2, oi.OptionName3, 
			oi.DateEntered AS OrderItemDate, oi.OITrackingNumber,
			p.ItemID, p.SKU, p.ItemName
	FROM	OrderItems oi, Products p
	WHERE	oi.OrderID = #OrderID#
	AND		oi.ItemID = p.ItemID
	AND		oi.ItemPrice > 0 
	AND 	oi.StatusCode != 'BO' 
	AND 	oi.StatusCode != 'CA'
	AND 	oi.StatusCode != 'RE'
	ORDER BY p.SKU
</cfquery>
<cfinvoke component="#application.Queries#" method="getOrderStatusCodes" returnvariable="getOrderStatusCodes"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getBillingStatusCodes" returnvariable="getBillingStatusCodes"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getOrderItemsStatusCodes" returnvariable="getOrderItemsStatusCodes"></cfinvoke>
<!--- END: QUERIES --------------------------------------------------------------->

<!--- BEGIN: HEADER --->
<cfscript>
	PageTitle = 'RETURNS (RMAs) FOR ORDER ##' & #OrderID# ;
	QuickSearch = 0;
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfscript>
	if ( isDefined('RefreshPage') AND RefreshPage EQ 1 )
	{
		BodyOptions = 'history.go();' ;
		RefreshPage = 0 ;
	}
</cfscript>
<cfinclude template="AdminBanner.cfm">

<!--- ADD RMA SECTION --->
<cfform name="AddReturn" action="OrderReturnDetail.cfm?OrderID=#OrderID#" method="post">	
<cfoutput>
<table border="0" cellpadding="7" cellspacing="0" width="100%">
	<tr class="cfAdminHeader1" style="background-color:##7DBF0E;">
		<td class="cfAdminHeader1" colspan="3">
			NEXT RMA ## #getOrder.OrderID#00#VAL(getOrderReturns.RecordCount + 1)#<br>
			<input type="hidden" name="RMA" value="#getOrder.OrderID#00#VAL(getOrderReturns.RecordCount + 1)#" />
		</td>
	</tr>
	<cfquery name="getCustomerID" datasource="#application.dsn#">
		SELECT	c.CustomerID
		FROM	Customers c, Orders o, OrderReturns rma
		WHERE	c.CustomerID = o.CustomerID
		AND		o.OrderID = rma.OrderID
		AND		o.OrderID = #OrderID#
	</cfquery>
	<tr>
		<td width="20%" height="20" valign="top">
			Status: Not Added Yet<br/>
			Date Created: #DateFormat(Now(), "d-mmm-yyyy")#<br>
			Created By: #UCASE(GetAuthUser())#<br/>
		</td>
		<td width="20%" valign="top">
			Being Sent To: 
			<select name="ReceivedTo" class="cfAdminDefault">
				<option value="ReturnDept">Returns Dept.</option>
				<option value="Distributor">Distributor</option>
			</select>
			<br/>
			Charge Return To:
			<select name="ChargeReturnTo" class="cfAdminDefault">
				<option value="Marketing">Marketing</option>
				<option value="Distributor">Distributor</option>
			</select>
		</td>
		<td width="60%" valign="top">
			Invoice ##<a href="OrderDetail.cfm?OrderID=#OrderID#">#OrderID#</a><br>
			CustomerID: <a href="CustomerDetail.cfm?CustomerID=#getCustomerID.CustomerID#">#getCustomerID.CustomerID#</a><br>
			Order Date: #DateFormat(getOrder.OrderDate, "d-mmm-yyyy")#
		</td>	
	</tr>
</table>
</cfoutput>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr class="cfAdminHeader4" style="background-color:##65ADF1;">	
		<td width="3%"  class="cfAdminHeader4" nowrap height="20">&nbsp;Select &nbsp;</td>
		<td width="15%" class="cfAdminHeader4" nowrap>Qty to Return</td>
		<td width="10%" class="cfAdminHeader4" nowrap>SKU</td>
		<td width="27%" class="cfAdminHeader4" nowrap>Item Name/Description</td>
		<td width="15%" class="cfAdminHeader4" nowrap>Item Status</td>
		<td width="10%" class="cfAdminHeader4" nowrap>RMA Date</td>
		<td width="10%" class="cfAdminHeader4" nowrap align="right">Unit Price</td>
		<td width="10%" class="cfAdminHeader4" nowrap align="right">Total&nbsp;</td>
	</tr>
<cfoutput query="getOrderItems">
	<cfset QtyAvailable = 0 >
	<cfquery name="getProductInfo" datasource="#application.dsn#">
		SELECT  ItemID, SKU, ItemName
		FROM	Products
		WHERE	ItemID = #ItemID#
		ORDER BY SKU
	</cfquery>
	<cfquery name="getQty" datasource="#application.dsn#">
		SELECT	SUM(QtyReturned) AS QtyReturned
		FROM	OrderReturnItems ori, OrderReturns rma
		WHERE	ori.OrderReturnItemID = #ItemID#
		AND		rma.OrderReturnID = ori.OrderReturnID
		AND		rma.OrderID = #getOrder.OrderID#
	</cfquery>
	<cfquery name="getStatusCode" dbtype="query">
		SELECT	StatusMessage
		FROM	getOrderItemsStatusCodes
		WHERE	StatusCode = '#StatusCode#'
	</cfquery>
	<cfif getQty.RecordCount NEQ 0 AND getQty.QtyReturned NEQ '' >
		<cfif getQty.QtyReturned LT getOrderItems.Qty >
			<cfset QtyAvailable = getOrderItems.Qty - getQty.QtyReturned >
			<tr>
				<td height="20">
					<cfinput type="Checkbox" name="ItemsSelected" value="#getOrderItems.ItemID#">
				</td>
				<td><cfinput type="text" validate="integer" name="QtyReturned" value="" size="1" class="cfAdminDefault" style="text-align:center"> of #QtyAvailable#</td>
				<td>
					<a href="ProductDetail.cfm?ItemID=#ItemID#" class="cfAdminDefault">#getProductInfo.SKU#</a>
				</td>
				<td>
					<a href="ProductDetail.cfm?ItemID=#ItemID#" class="cfAdminDefault">#getProductInfo.ItemName#</a>
					<cfif OptionName1 NEQ ''><b>: #OptionName1#</b></cfif>
					<cfif OptionName2 NEQ ''><b>; #OptionName2#</b></cfif>
					<cfif OptionName3 NEQ ''><b>; #OptionName3#</b></cfif>
				</td>
				<td>#getStatusCode.StatusMessage#</td>
				<td>#DateFormat(NOW(), "mm/dd/yy")#</td>
				<td align="right">#LSCurrencyFormat(ItemPrice, "local")#</td>
				<td align="right">TBD</td>
			</tr>
		</cfif>
	<cfelse>
		<tr>
			<td height="20">
				<cfinput type="Checkbox" name="ItemsSelected" value="#getOrderItems.ItemID#">
			</td>
			<td><cfinput type="text" validate="integer" name="QtyReturned" value="" size="1" class="cfAdminDefault" style="text-align:center"> of #getOrderItems.Qty#</td>
			<td>
				<a href="ProductDetail.cfm?ItemID=#ItemID#" class="cfAdminDefault">#getProductInfo.SKU#</a>
			</td>
			<td>
				<a href="ProductDetail.cfm?ItemID=#ItemID#" class="cfAdminDefault">#getProductInfo.ItemName#</a>
				<cfif OptionName1 NEQ ''><b>: #OptionName1#</b></cfif>
				<cfif OptionName2 NEQ ''><b>; #OptionName2#</b></cfif>
				<cfif OptionName3 NEQ ''><b>; #OptionName3#</b></cfif>
			</td>
			<td>#getStatusCode.StatusMessage#</td>
			<td>#DateFormat(NOW(), "mm/dd/yy")#</td>
			<td align="right">#LSCurrencyFormat(getOrderItems.ItemPrice, "local")#</td>
			<td align="right">TBD</td>
		</tr>
	</cfif>
</cfoutput>
<cfoutput>
	<tr>
		<td width="100%" colspan="8" align="right" height="20">
			<cfif application.UseFlatTaxRate EQ 1 >
				<cfset TaxRateToUse = application.FlatTaxRate >
				#DecimalFormat(application.FlatTaxRate)#%
			<cfelse>
				<cfquery name="getTaxRate" datasource="#application.dsn#">
					SELECT	T_Rate
					FROM	States
					WHERE	StateCode = '#getOrder.OShipState#'
				</cfquery>
				<cfset TaxRateToUse = getTaxRate.T_Rate >
				#DecimalFormat(getTaxRate.T_Rate)#%
			</cfif>
			Tax Returned: &nbsp; $<cfinput type="text" validate="float" name="TaxReturned" value="" size="3" class="cfAdminDefault" style="text-align:right;">
		</td>
	</tr>
	<tr>
		<td width="100%" colspan="8" align="right" height="20">
			Shipping Returned: &nbsp; $<cfinput type="text" validate="float" name="ShippingReturned" value="" size="3" class="cfAdminDefault" style="text-align:right;">
		</td>
	</tr>
	<tr class="cfAdminDefault" style="background-color:##65ADF1;">
		<td width="100%" colspan="8" align="right" height="25" class="cfAdminHeader4">
			<input type="submit" name="AddRMA" value="ADD RMA" alt="Add Order Return" class="cfAdminButton">
			<input type="hidden" name="OrderID" value="#OrderID#" />
		</td>
	</tr>
	<!--- DIVIDER --->
	<tr><td height="5" colspan="9"></td></tr>
	<tr style="background-color:##CCCCCC;"><td height="1" colspan="8"></td></tr>
	<tr><td height="1" colspan="8"></td></tr>
	<tr style="background-color:##CCCCCC;"><td height="1" colspan="8"></td></tr>
</table>
</cfoutput>
</cfform>






<!--- EXISTING RMAs --->
<cfoutput query="getOrderReturns">
<cfform name="ExistingRMAs" action="OrderReturnDetail.cfm?OrderID=#OrderID#" method="post">
	<input type="hidden" name="OrderReturnID" value="#OrderReturnID#" />
	<input type="hidden" name="RMA" value="#RMA#" />
	<!--- BEGIN: QUERIES --->
	<cfinvoke component="#application.Queries#" method="getOrderItems" returnvariable="getOrderItems">
		<cfinvokeargument name="OrderID" value="#OrderID#">
	</cfinvoke>
	<cfinvoke component="#application.Queries#" method="getOrder" returnvariable="getOrder">
		<cfinvokeargument name="OrderID" value="#OrderID#">
	</cfinvoke>
	<cfquery name="getCustomerID" datasource="#application.dsn#">
		SELECT	c.CustomerID
		FROM	Customers c, Orders o, OrderReturns rma
		WHERE	c.CustomerID = o.CustomerID
		AND		o.OrderID = rma.OrderID
		AND		o.OrderID = #OrderID#
	</cfquery>
	<!--- END: QUERIES --->

	<cfset ReturnTotal = 0 >
	<cfset ThisOrderReturnID = getOrderReturns.OrderReturnID >
	<table border="0" cellpadding="7" cellspacing="0" width="100%">
		<tr class="cfAdminHeader2" style="background-color:##7DBF0E;">
			<td colspan="2" class="cfAdminHeader2">
				EXISTING RMA ## <a href="OrderReturnDetail.cfm?OrderID=#OrderID#"><b>#RMA#</b></a><br>
			</td>
			<td class="cfAdminHeader2" align="right">
				<input type="submit" name="DeleteRMA" value="DELETE RMA" alt="Delete Order Return" class="cfAdminButton"
					onClick="return confirm('Are you sure you want to DELETE ORDER RETURN #RMA# ?')">
			</td>
		</tr>
		<tr>
			<td width="20%" height="20" valign="top">
				Status: <cfif RMAComplete EQ 1 >Complete<cfelse>Incomplete</cfif><br/>
				Date Created: #DateFormat(RMADate, "d-mmm-yyyy")#<br>
				Date Received: <cfif RMAComplete EQ 1 >#DateFormat(DateReceived,"mm/dd/yyyy")#<cfelse>Not Received Yet</cfif><br/>
			</td>
			<td width="20%" valign="top">
				Being Sent To: #ReceivedTo#<br/>
				Charge Return To: #ChargeReturnTo#<br/>
				Created By: #CreatedBy#<br/>
			</td>
			<td width="60%" valign="top">
				Invoice ##<a href="OrderDetail.cfm?OrderID=#OrderID#">#OrderID#</a><br>
				CustomerID: <a href="CustomerDetail.cfm?CustomerID=#getCustomerID.CustomerID#">#getCustomerID.CustomerID#</a><br>
				Order Date: #DateFormat(getOrder.OrderDate, "d-mmm-yyyy")#
			</td>	
		</tr>
	</table>
	<!--- ORDERED ITEMS --->
	<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr class="cfAdminHeader4" style="background-color:##65ADF1;">	
			<td width="3%"  class="cfAdminHeader4" nowrap height="20">&nbsp;</td>
			<td width="15%" class="cfAdminHeader4" nowrap>Qty to Return</td>
			<td width="10%" class="cfAdminHeader4" nowrap>SKU</td>
			<td width="27%" class="cfAdminHeader4" nowrap>Item Name/Description</td>
			<td width="15%" class="cfAdminHeader4" nowrap>Item Status</td>
			<td width="10%" class="cfAdminHeader4" nowrap>RMA Date</td>
			<td width="10%" class="cfAdminHeader4" nowrap align="right">Unit Price</td>
			<td width="10%" class="cfAdminHeader4" nowrap align="right">Total&nbsp;</td>
		</tr>
		<cfloop query="getOrderItems">	
			
			<cfquery name="getProductInfo" datasource="#application.dsn#">
				SELECT  ItemID, SKU, ItemName
				FROM	Products
				WHERE	ItemID = #ItemID#
				ORDER BY SKU
			</cfquery>
			<cfquery name="getQty" datasource="#application.dsn#">
				SELECT	*
				FROM	OrderReturnItems ori, OrderReturns rma
				WHERE	ori.OrderReturnItemID = #getOrderItems.ItemID#
				AND		rma.OrderReturnID = ori.OrderReturnID
				AND		rma.OrderReturnID = #ThisOrderReturnID#
			</cfquery>
			<cfquery name="getStatusCode" dbtype="query">
				SELECT	StatusMessage
				FROM	getOrderItemsStatusCodes
				WHERE	StatusCode = '#StatusCode#'
			</cfquery>
			
			<cfif getQty.RecordCount NEQ 0 >
				<cfset ReturnTotal = ReturnTotal + (ItemPrice * getQty.QtyReturned) >
				<tr>
					<td height="20">
						
					</td>
					<td>#getQty.QtyReturned# of #Qty#</td>
					<td>
						<a href="ProductDetail.cfm?ItemID=#ItemID#" class="cfAdminDefault">#getProductInfo.SKU#</a>
					</td>
					<td>
						<a href="ProductDetail.cfm?ItemID=#ItemID#" class="cfAdminDefault">#getProductInfo.ItemName#</a>
						<cfif OptionName1 NEQ ''><b>: #OptionName1#</b></cfif>
						<cfif OptionName2 NEQ ''><b>; #OptionName2#</b></cfif>
						<cfif OptionName3 NEQ ''><b>; #OptionName3#</b></cfif>
					</td>
					<td>#getStatusCode.StatusMessage#</td>
					<td>#DateFormat(getOrderReturns.RMADate, "mm/dd/yy")#</td>
					<td align="right">#LSCurrencyFormat(ItemPrice, "local")#</td>
					<td align="right"><b>#LSCurrencyFormat(ReturnTotal, "local")#</b></td>
				</tr>
			<cfelse>
				<tr>
					<td height="20">
						
					</td>
					<td><font color="##999999"><cfif getQty.QtyReturned EQ ''>0<cfelse>#getQty.QtyReturned#</cfif> of #Qty#</font></td>
					<td>
						<a href="ProductDetail.cfm?ItemID=#ItemID#" class="cfAdminDefault"><font color="##999999">#getProductInfo.SKU#</font></a>
					</td>
					<td>
						<a href="ProductDetail.cfm?ItemID=#ItemID#" class="cfAdminDefault"><font color="##999999">#getProductInfo.ItemName#</font></a>
						<font color="##999999">
						<cfif OptionName1 NEQ ''><b>: #OptionName1#</b></cfif>
						<cfif OptionName2 NEQ ''><b>; #OptionName2#</b></cfif>
						<cfif OptionName3 NEQ ''><b>; #OptionName3#</b></cfif>
						</font>
					</td>
					<td><font color="##999999">#getStatusCode.StatusMessage#</font></td>
					<td><font color="##999999">#DateFormat(getOrderReturns.RMADate, "mm/dd/yy")#</font></td>
					<td align="right"><font color="##999999">#LSCurrencyFormat(ItemPrice, "local")#</font></td>
					<td align="right"><font color="##999999">#LSCurrencyFormat(0.00, "local")#</font></td>
				</tr>
			</cfif>
		</cfloop>
		<!--- TOTALS --->
		<cfif TaxReturned NEQ '' AND TaxReturned NEQ 0 >
		<tr>
			<td width="100%" colspan="8" align="right" height="20">
				Tax Returned: &nbsp; #LSCurrencyFormat(TaxReturned)#
				<cfset ReturnTotal = ReturnTotal + TaxReturned >
			</td>
		</tr>
		</cfif>
		<cfif ShippingReturned NEQ '' AND ShippingReturned NEQ 0 >
		<tr>
			<td width="100%" colspan="8" align="right" height="20">
				Shipping Returned: &nbsp; #LSCurrencyFormat(ShippingReturned)#
				<cfset ReturnTotal = ReturnTotal + ShippingReturned >
			</td>
		</tr>
		</cfif>
		<tr class="cfAdminDefault" style="background-color:##65ADF1;">
			<td width="100%" colspan="8" align="right" height="20" class="cfAdminHeader4">
				Return Total: &nbsp; <b>#LSCurrencyFormat(ReturnTotal)#</b>
			</td>
		</tr>	
		<!--- DIVIDER --->
		<tr><td height="5" colspan="9"></td></tr>
		<tr style="background-color:##CCCCCC;"><td height="1" colspan="8"></td></tr>
		<tr><td height="1" colspan="8"></td></tr>
		<tr style="background-color:##CCCCCC;"><td height="1" colspan="8"></td></tr>
	</table>
</cfform>
</cfoutput>

<br><br><br>
<cfinclude template="LayoutAdminFooter.cfm">