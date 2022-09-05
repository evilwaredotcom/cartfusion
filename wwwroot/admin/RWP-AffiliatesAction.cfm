<cfscript>
	PageTitle = 'REPORT WIZARD PRO: Affiliates' ;
	BannerTitle = 'ReportWizard' ;
	AddAButton = 'RETURN TO REPORT WIZARD' ;
	AddAButtonLoc = 'RWP-ReportWizard.cfm' ;
	ReportPage = 'RWP-Affiliates.cfm' ;
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">


<cfquery name="getAffiliateData" datasource="#application.dsn#">
	SELECT		AFID, LastName + ', ' + FirstName AS AffiliateName, MemberType
	FROM		Affiliates
	WHERE		(Deleted = 0 OR Deleted IS NULL)
	<cfif Form.SortOption EQ 'ID'>
	ORDER BY 	AFID, LastName, FirstName
	<cfelseif Form.SortOption EQ 'Level'>
	ORDER BY 	MemberType, LastName, FirstName
	<cfelse>
	ORDER BY 	LastName, FirstName, AFID
	</cfif>
</cfquery>

<!---<cfdump var="#getAffiliateData#"><cfabort>--->

<cfif getAffiliateData.RecordCount EQ 0 >
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

<!--- PDF VIEW --->
<cfif FORM.DisplayView EQ 'PDF'>
<cfdocument format="PDF">
	<style type="text/css">
		TD, DIV
		{ font-size:10px; font-family:Verdana, Arial, Helvetica, sans-serif; }
	</style>
	<cfif Form.ReportType IS 'Summary' OR Form.ReportType IS 'Detail'>
	<cfscript>
		TotalAFOrders = 0;
		TotalAffiliates = 0;
		SubTotal = 0 ;
		AffiliateCommission = 0 ;
		CommissionTotal = 0 ;
		AFPaidTotal = 0 ;
		AFUnpaidTotal = 0 ;
	</cfscript>
	
	<table width="100%" border="0" bordercolor="<cfoutput>#cfAdminHeaderColor#</cfoutput>" cellpadding="3" cellspacing="0" class="cfAdminDefault">
		<cfdocumentitem type="header">
		<tr>
			<td align="center">
				<div align="center">
				<font style="font-size:10px; font-family:Verdana, Arial, Helvetica, sans-serif;">
				<cfoutput>
					<b>AFFILIATE REPORT #UCASE(Form.ReportType)#</b>
					<cfif Form.FromDate NEQ '' AND Form.ToDate NEQ '' >
						| FROM: <b>#DateFormat(Form.FromDate,"mmm dd, yyyy")#</b> 
						  TO: <b>#DateFormat(Form.ToDate,"mmm dd, yyyy")#</b>
					</cfif>				
				</cfoutput>
				</font>
				</div>
			</td>
		</tr>
		</cfdocumentitem>
		
	<!------------------------- BEGIN: DISPLAY RESULTS ------------------------->
		<tr>
			<td width="100%">
				<table width="100%" border="0" cellpadding="3" cellspacing="0" class="cfAdminDefault">
					<cfif Form.ReportType EQ 'Detail'>
					<tr style="background-color:##65ADF1;">
						<td width="5%"  class="cfAdminHeader1">AFID</td>
						<td width="10%" class="cfAdminHeader1" nowrap>Orders</td>
						<td width="10%" class="cfAdminHeader1" nowrap>Order Date</td>
						<td width="12%" class="cfAdminHeader1" nowrap>Cust. Billing Status</td>
						<td width="5%"  class="cfAdminHeader1" align="center">Level</td>
						<td width="10%" class="cfAdminHeader1" align="right">Order Total</td>
						<td width="10%" class="cfAdminHeader1" align="right" nowrap>Commission %</td>
						<td width="15%" class="cfAdminHeader1" align="right" nowrap>Commission Total</td>
					</tr>
					<cfelse>
					<tr style="background-color:##65ADF1;">
						<td width="10%" class="cfAdminHeader1">AFID</td>
						<td width="30%" class="cfAdminHeader1">Name</td>
						<td width="15%" class="cfAdminHeader1">Membership</td>
						<td width="15%" class="cfAdminHeader1" align="center">Orders</td>
						<td width="15%" class="cfAdminHeader1" align="right">Order Total</td>
						<td width="15%" class="cfAdminHeader1" align="right" nowrap>Commission Total</td>
					</tr>
					</cfif>
					
					<cfoutput query="getAffiliateData">
	
						<cfquery name="getOrdersAF" datasource="#application.dsn#">
							SELECT		OrderID, BillingStatus, DateEntered AS OrderDate, DiscountTotal, CreditApplied, 
										AffiliatePaid, AffiliateTotal
							FROM 		Orders
							WHERE 		AffiliateID = #AFID#
							<cfif Form.FromDate NEQ '' AND Form.ToDate NEQ '' >
							AND		DateEntered >= '#Form.FromDate#'
							AND	 	DateEntered <= '#DateFormat(DateAdd("d", 1, Form.ToDate),"mm/dd/yyyy")#'
							</cfif>
							
							<!--- INCLUDE UNPAID/CANCELLED ??? --->
							<cfif isDefined('FORM.ExUnbilled')>
							AND		OrderStatus != 'BO'
							AND		BillingStatus != 'NB'
							</cfif>
							<cfif isDefined('FORM.ExCanceled')>
							AND		OrderStatus != 'CA'
							AND		OrderStatus != 'RE'
							AND		BillingStatus != 'CA'
							AND		BillingStatus != 'RE'
							AND		BillingStatus != 'DE'
							</cfif>
							
							ORDER BY OrderID
						</cfquery>
						<cfquery name="getAFHistory" datasource="#application.dsn#">
							SELECT	*
							FROM	AffiliateHistory
							WHERE	AFID = #AFID#
							ORDER BY DateEntered DESC
						</cfquery>
						
						<cfscript>
							AffiliateID = AFID ;
							AffiliateSubTotal = 0 ;
							AffiliateCommTotal = 0 ;
							AffiliateOrders = 0 ;
						</cfscript>
						
						<cfloop QUERY="getOrdersAF">
						<cfset RunningTotal = 0 >
							<!--- GET ORDER TOTAL --->
							<cfinvoke component="#application.Queries#" method="getOrderTotal" returnvariable="getOrderTotal">
								<cfinvokeargument name="OrderID" value="#getOrdersAF.OrderID#">
							</cfinvoke>
							<cfquery name="getCommLevel1" dbtype="query" maxrows="1">
								SELECT 	L1
								FROM	getAFHistory
								WHERE	DateEntered <= '#OrderDate#'
							</cfquery>
							
							<cfif getCommLevel1.RecordCount EQ 0 >
								<cfset L1 = 0 >
							<cfelse>
								<cfset L1 = getCommLevel1.L1 >
							</cfif>
							
							<cfscript>
								if ( getOrderTotal.RunningTotal EQ '' )
									getOrderTotal.RunningTotal = 0 ;
								RunningTotal = getOrderTotal.RunningTotal - DiscountTotal - CreditApplied ;
								SubTotal = SubTotal + RunningTotal ;
								AffiliateSubTotal = AffiliateSubTotal + RunningTotal ;
								CommissionTotal = NumberFormat((L1 / 100) * RunningTotal,9.99) ;
								AffiliateCommission = AffiliateCommission + CommissionTotal ;
								AffiliateCommTotal = AffiliateCommTotal + CommissionTotal ;
								TotalAFOrders = TotalAFOrders + 1 ;
								AffiliateOrders = AffiliateOrders + 1 ;
							</cfscript>
						<cfif Form.ReportType EQ 'Detail'>
						<tr>
							<td>#AffiliateID#</td>
							<td>#OrderID#</td>
							<td>#DateFormat(OrderDate,"dd-mmm-yyyy")#</td>
							<cfinvoke component="#application.Queries#" method="getBillingStatusCode" returnvariable="getBillingStatus">
								<cfinvokeargument name="StatusCode" value="#getOrdersAF.BillingStatus#">
							</cfinvoke>
							<td>#getBillingStatus.StatusMessage#</td>
							<!--- AFFILIATE COMMISSION LEVEL --->
							<td align="center">1</td>
							<!--- ORDER TOTAL --->
							<td align="right">#LSCurrencyFormat(RunningTotal, "local")#</td>
							<!--- COMMISSION LEVEL PERCENTAGE --->
							<td align="right">#DecimalFormat(L1)#%</td>
							<!--- COMMISSION TOTAL --->
							<td align="right">#LSCurrencyFormat(CommissionTotal, "local")#</td>
						</tr>
						</cfif>
						</cfloop>
						<!--- LEVEL 2 AFFILIATE ORDERS --->
						<cfquery name="getAffiliatesL2" datasource="#application.dsn#">
							SELECT	AFID
							FROM	Affiliates
							WHERE	SubAffiliateOf = #AFID#
						</cfquery>
						<cfif getAffiliatesL2.RecordCount NEQ 0 >
							<cfloop query="getAffiliatesL2">
								<cfquery name="getOrdersAF" datasource="#application.dsn#">
									SELECT		OrderID, BillingStatus, DateEntered AS OrderDate, DiscountTotal, CreditApplied, 
												AffiliatePaid, AffiliateTotal
									FROM 		Orders
									WHERE 		AffiliateID = #getAffiliatesL2.AFID#
									<cfif Form.FromDate NEQ '' AND Form.ToDate NEQ '' >
									AND		DateEntered >= '#Form.FromDate#'
									AND	 	DateEntered <= '#DateFormat(DateAdd("d", 1, Form.ToDate),"mm/dd/yyyy")#'
									</cfif>
									
									<!--- INCLUDE UNPAID/CANCELLED ??? --->
									<cfif isDefined('FORM.ExUnbilled')>
									AND		OrderStatus != 'BO'
									AND		BillingStatus != 'NB'
									</cfif>
									<cfif isDefined('FORM.ExCanceled')>
									AND		OrderStatus != 'CA'
									AND		OrderStatus != 'RE'
									AND		BillingStatus != 'CA'
									AND		BillingStatus != 'RE'
									AND		BillingStatus != 'DE'
									</cfif>
									
									ORDER BY OrderID
								</cfquery>
								
								<cfloop QUERY="getOrdersAF">
								<cfset RunningTotal = 0 >
									<!--- GET ORDER TOTAL --->
									<cfinvoke component="#application.Queries#" method="getOrderTotal" returnvariable="getOrderTotal">
										<cfinvokeargument name="OrderID" value="#getOrdersAF.OrderID#">
									</cfinvoke>
									<cfquery name="getCommLevel2" dbtype="query" maxrows="1">
										SELECT 	L2
										FROM	getAFHistory
										WHERE	DateEntered <= '#OrderDate#'
									</cfquery>
									
									<cfif getCommLevel2.RecordCount EQ 0 >
										<cfset L2 = 0 >
									<cfelse>
										<cfset L2 = getCommLevel2.L2 >
									</cfif>
									
									<cfscript>
										if ( getOrderTotal.RunningTotal EQ '' )
											getOrderTotal.RunningTotal = 0 ;
										RunningTotal = getOrderTotal.RunningTotal - DiscountTotal - CreditApplied ;
										SubTotal = SubTotal + RunningTotal ;
										AffiliateSubTotal = AffiliateSubTotal + RunningTotal ;
										CommissionTotal = NumberFormat((L2 / 100) * RunningTotal,9.99) ;
										AffiliateCommission = AffiliateCommission + CommissionTotal ;
										AffiliateCommTotal = AffiliateCommTotal + CommissionTotal ;
										TotalAFOrders = TotalAFOrders + 1 ;
										AffiliateOrders = AffiliateOrders + 1 ;
									</cfscript>
								<cfif Form.ReportType EQ 'Detail'>
								<tr>
									<td>#AffiliateID#</td>
									<td>#OrderID#</td>
									<td>#DateFormat(OrderDate,"dd-mmm-yyyy")#</td>
									<cfinvoke component="#application.Queries#" method="getBillingStatusCode" returnvariable="getBillingStatus">
										<cfinvokeargument name="StatusCode" value="#getOrdersAF.BillingStatus#">
									</cfinvoke>
									<td>#getBillingStatus.StatusMessage#</td>
									<!--- AFFILIATE COMMISSION LEVEL --->
									<td align="center">2</td>
									<!--- ORDER TOTAL --->
									<td align="right">#LSCurrencyFormat(RunningTotal, "local")#</td>
									<!--- COMMISSION LEVEL PERCENTAGE --->
									<td align="right">#DecimalFormat(L2)#%</td>
									<!--- COMMISSION TOTAL --->
									<td align="right">#LSCurrencyFormat(CommissionTotal, "local")#</td>
								</tr>
								</cfif>
								</cfloop>
								<!--- LEVEL 3 AFFILIATE ORDERS --->
								<cfquery name="getAffiliatesL3" datasource="#application.dsn#">
									SELECT	AFID
									FROM	Affiliates
									WHERE	SubAffiliateOf = #AFID#
								</cfquery>
								<cfif getAffiliatesL3.RecordCount NEQ 0 >
									<cfloop query="getAffiliatesL3">
										<cfquery name="getOrdersAF" datasource="#application.dsn#">
											SELECT		OrderID, BillingStatus, DateEntered AS OrderDate, DiscountTotal, CreditApplied, 
														AffiliatePaid, AffiliateTotal
											FROM 		Orders
											WHERE 		AffiliateID = #getAffiliatesL3.AFID#
											<cfif Form.FromDate NEQ '' AND Form.ToDate NEQ '' >
											AND		DateEntered >= '#Form.FromDate#'
											AND	 	DateEntered <= '#DateFormat(DateAdd("d", 1, Form.ToDate),"mm/dd/yyyy")#'
											</cfif>
											
											<!--- INCLUDE UNPAID/CANCELLED ??? --->
											<cfif isDefined('FORM.ExUnbilled')>
											AND		OrderStatus != 'BO'
											AND		BillingStatus != 'NB'
											</cfif>
											<cfif isDefined('FORM.ExCanceled')>
											AND		OrderStatus != 'CA'
											AND		OrderStatus != 'RE'
											AND		BillingStatus != 'CA'
											AND		BillingStatus != 'RE'
											AND		BillingStatus != 'DE'
											</cfif>
											
											ORDER BY OrderID
										</cfquery>
										
										<cfloop QUERY="getOrdersAF">
										<cfset RunningTotal = 0 >
											<!--- GET ORDER TOTAL --->
											<cfinvoke component="#application.Queries#" method="getOrderTotal" returnvariable="getOrderTotal">
												<cfinvokeargument name="OrderID" value="#getOrdersAF.OrderID#">
											</cfinvoke>
											<cfquery name="getCommLevel3" dbtype="query" maxrows="1">
												SELECT 	L3
												FROM	getAFHistory
												WHERE	DateEntered <= '#OrderDate#'
											</cfquery>
											
											<cfif getCommLevel3.RecordCount EQ 0 >
												<cfset L3 = 0 >
											<cfelse>
												<cfset L3 = getCommLevel3.L3 >
											</cfif>
											
											<cfscript>
												if ( getOrderTotal.RunningTotal EQ '' )
													getOrderTotal.RunningTotal = 0 ;
												RunningTotal = getOrderTotal.RunningTotal - DiscountTotal - CreditApplied ;
												SubTotal = SubTotal + RunningTotal ;
												AffiliateSubTotal = AffiliateSubTotal + RunningTotal ;
												CommissionTotal = NumberFormat((L3 / 100) * RunningTotal,9.99) ;
												AffiliateCommission = AffiliateCommission + CommissionTotal ;
												AFUnpaidTotal = AFUnpaidTotal + AffiliateCommTotal - AFPaidTotal ;
												TotalAFOrders = TotalAFOrders + 1 ;
												AffiliateOrders = AffiliateOrders + 1 ;											
											</cfscript>
										<cfif Form.ReportType EQ 'Detail'>
										<tr>
											<td>#AffiliateID#</td>
											<td>#OrderID#</td>
											<td>#DateFormat(OrderDate,"dd-mmm-yyyy")#</td>
											<cfinvoke component="#application.Queries#" method="getBillingStatusCode" returnvariable="getBillingStatus">
												<cfinvokeargument name="StatusCode" value="#getOrdersAF.BillingStatus#">
											</cfinvoke>
											<td>#getBillingStatus.StatusMessage#</td>
											<!--- AFFILIATE COMMISSION LEVEL --->
											<td align="center">3</td>
											<!--- ORDER TOTAL --->
											<td align="right">#LSCurrencyFormat(RunningTotal, "local")#</td>
											<!--- COMMISSION LEVEL PERCENTAGE --->
											<td align="right">#DecimalFormat(L3)#%</td>
											<!--- COMMISSION TOTAL --->
											<td align="right">#LSCurrencyFormat(CommissionTotal, "local")#</td>
										</tr>
										</cfif>
										</cfloop>
									</cfloop>
								</cfif>
							</cfloop>
						</cfif>
						<cfif Form.ReportType EQ 'Summary'>
							<cfinvoke component="#application.Queries#" method="getAFLevel" returnvariable="getAFLevel">
								<cfinvokeargument name="CommID" value="#MemberType#">
							</cfinvoke>
						<tr>
							<td>#AffiliateID#</td>						
							<td>#AffiliateName#</td>
							<td>#getAFLevel.LevelName#</td>
							<td align="center">#AffiliateOrders#</td>
							<td align="right">#LSCurrencyFormat(AffiliateSubTotal, "local")#</td>
							<td align="right">#LSCurrencyFormat(AffiliateCommTotal, "local")#</td>
						</tr>
						<cfscript>
							AffiliateSubTotal = 0 ;
							AffiliateCommTotal = 0 ;
							AffiliateOrders = 0 ;
						</cfscript>
						</cfif>
					</cfoutput>
					<cfoutput>
					<cfif Form.ReportType EQ 'Detail'>
					<tr><td colspan="8" height="1" bgcolor="#cfAdminHeaderColor#"></td></tr>
					<tr>
						<td><b>#getAffiliateData.RecordCount#</b></td>
						<td><b>#TotalAFOrders# Orders</b></td>
						<td></td>
						<td></td>
						<td></td>
						<td align="right"><b>#LSCurrencyFormat(SubTotal, "local")#</b></td>
						<td></td>
						<td align="right"><b>#LSCurrencyFormat(AffiliateCommission, "local")#</b></td>
					</tr>
					<cfelse>
					<tr><td colspan="6" height="1" bgcolor="#cfAdminHeaderColor#"></td></tr>
					<tr>
						<td><b>#getAffiliateData.RecordCount#</b></td>
						<td></td>
						<td></td>
						<td align="center"><b>#TotalAFOrders# Orders</b></td>
						<td align="right"><b>#LSCurrencyFormat(SubTotal, "local")#</b></td>
						<td align="right"><b>#LSCurrencyFormat(AffiliateCommission, "local")#</b></td>
					</tr>
					</cfif>
					</cfoutput>
				</table>
			</td>
		</tr>
		<cfdocumentitem type="footer">
		<tr>
			<td align="center" height="30">	
				<div align="center">
				<font style="font-size:10px; font-family:Verdana, Arial, Helvetica, sans-serif;">
					<cfoutput>
					Page <b>#cfdocument.currentpagenumber#</b> of <b>#cfdocument.totalpagecount#</b>
					</cfoutput>
				</font>
				</div>
			</td>
		</tr>
		</cfdocumentitem>
	</table>
	<!------------------------- END: DISPLAY RESULTS ------------------------->
	
	
	
	<cfelseif Form.ReportType IS 'Payments'>
	<cfscript>
		AFPaidTotal = 0 ;
		AFUnpaidTotal = 0 ;
		AFChecks = 0 ;
	</cfscript>
	
	<table width="100%" border="0" bordercolor="<cfoutput>#cfAdminHeaderColor#</cfoutput>" cellpadding="3" cellspacing="0" class="cfAdminDefault">
		<cfdocumentitem type="header">
		<tr>
			<td align="center" height="25">
				<div align="center">
				<font style="font-size:12px; font-family:Verdana, Arial, Helvetica, sans-serif;">
				<cfoutput>
					<b>PAYMENTS MADE TO AFFILIATES</b>
					<cfif Form.FromDate NEQ '' AND Form.ToDate NEQ '' >
						| FROM: <b>#DateFormat(Form.FromDate,"mmm dd, yyyy")#</b> 
						  TO: <b>#DateFormat(Form.ToDate,"mmm dd, yyyy")#</b>
					</cfif>				
				</cfoutput>
				</font>
				</div>
			</td>
		</tr>
		</cfdocumentitem>
		<!------------------------- BEGIN: DISPLAY RESULTS ------------------------->
		<tr>
			<td width="100%">
				<table width="100%" border="0" cellpadding="3" cellspacing="0" class="cfAdminDefault">
					<tr style="background-color:##65ADF1;">
						<td width="10%"  class="cfAdminHeader1">AFID</td>
						<td width="20%" class="cfAdminHeader1">Name</td>
						<td width="15%" class="cfAdminHeader1">Date</td>
						<td width="15%" class="cfAdminHeader1">Amount</td>
						<td width="15%" class="cfAdminHeader1">Check No.</td>
						<td width="25%" class="cfAdminHeader1">Comments</td>
					</tr>
					
					<cfoutput query="getAffiliateData">
						
						<cfquery name="getPaymentsAF" datasource="#application.dsn#">
							SELECT	*
							FROM	AffiliatePayments
							WHERE	AFID = #AFID#
							<cfif Form.FromDate NEQ '' AND Form.ToDate NEQ '' >
							AND		AFPDate >= '#Form.FromDate#'
							AND	 	AFPDate <= '#DateFormat(DateAdd("d", 1, Form.ToDate),"mm/dd/yyyy")#'
							</cfif>
						</cfquery>
						
						<cfscript>
							AffiliateID = AFID ;
							AFName = AffiliateName ;
						</cfscript>
						
						<cfloop QUERY="getPaymentsAF">
							<tr>
								<td>#AffiliateID#</td>
								<td>#AFName#</td>
								<td>#DateFormat(AFPDate,'mm/dd/yyyy')#</td>
								<td>$#DecimalFormat(AFPAmount)#</td>
								<td>#AFPCheck#</td>
								<td>#AFPComments#</td>
							</tr>
							<cfscript>
								AFPaidTotal = AFPaidTotal + AFPAmount ;
								AFChecks = AFChecks + 1 ;
							</cfscript>
						</cfloop>
					</cfoutput>
					<cfoutput>
					<tr><td colspan="6" height="1" bgcolor="#cfAdminHeaderColor#"></td></tr>
					<tr>
						<td><b>TOTALS</b></td>
						<td></td>
						<td></td>
						<td><b>#LSCurrencyFormat(AFPaidTotal, "local")#</b></td>
						<td><b>#AFChecks#</b></td>
						<td></td>
					</tr>
					</cfoutput>
				</table>
			</td>
		</tr>
		<cfdocumentitem type="footer">
		<tr>
			<td align="center" height="30">	
				<div align="center">
				<font style="font-size:12px; font-family:Verdana, Arial, Helvetica, sans-serif;">
					<cfoutput>
					Page <b>#cfdocument.currentpagenumber#</b> of <b>#cfdocument.totalpagecount#</b>
					</cfoutput>
				</font>
				</div>
			</td>
		</tr>
		</cfdocumentitem>
	</table>
	
	
	
	<cfelseif Form.ReportType IS 'PaymentsDue'>
	<cfscript>
		TotalAFOrders = 0;
		TotalAffiliates = 0;
		SubTotal = 0 ;
		AffiliateCommission = 0 ;
		CommissionTotal = 0 ;
		AFPaidTotal = 0 ;
		AFUnpaidTotal = 0 ;
		AFChecks = 0 ;
	</cfscript>
	
	<table width="100%" border="0" bordercolor="<cfoutput>#cfAdminHeaderColor#</cfoutput>" cellpadding="3" cellspacing="0" class="cfAdminDefault">
		<cfdocumentitem type="header">
		<tr>
			<td align="center" height="25">
				<div align="center">
				<font style="font-size:12px; font-family:Verdana, Arial, Helvetica, sans-serif;">
				<cfoutput>
					<b>PAYMENTS DUE AFFILIATES</b>
					<cfif Form.FromDate NEQ '' AND Form.ToDate NEQ '' >
						| FROM: <b>#DateFormat(Form.FromDate,"mmm dd, yyyy")#</b> 
						  TO: <b>#DateFormat(Form.ToDate,"mmm dd, yyyy")#</b>
					</cfif>				
				</cfoutput>
				</font>
				</div>
			</td>
		</tr>
		</cfdocumentitem>
		<!------------------------- BEGIN: DISPLAY RESULTS ------------------------->
		<tr>
			<td width="100%">
				<table width="100%" border="0" cellpadding="3" cellspacing="0" class="cfAdminDefault">
					<tr style="background-color:##65ADF1;">
						<td width="10%"  class="cfAdminHeader1">AFID</td>
						<td width="20%" class="cfAdminHeader1">Name</td>
						<td width="20%" class="cfAdminHeader1">Last Date Paid</td>
						<td width="15%" class="cfAdminHeader1" align="right">Order Totals</td>
						<td width="15%" class="cfAdminHeader1" align="right">Comm. Totals</td>
						<td width="15%" class="cfAdminHeader1" align="right">Amount Due</td>
					</tr>
					
					<cfscript>
						OrderTotals = 0 ;
						CommTotals = 0 ;
						PaidTotals = 0 ;
					</cfscript>
						
					<cfoutput query="getAffiliateData">
							
						<cfscript>
							SubTotal = 0 ;
							AFPaidTotal = 0 ;
							AFUnpaidTotal = 0 ;
							AffiliateCommission = 0 ;
							CommissionTotal = 0 ;
						</cfscript>
						
						<cfinvoke component="#application.Queries#" method="getPaymentsAF" returnvariable="getPaymentsAF">
							<cfinvokeargument name="AFID" value="#AFID#">
						</cfinvoke>
						<cfquery name="getAFHistory" datasource="#application.dsn#">
							SELECT	*
							FROM	AffiliateHistory
							WHERE	AFID = #AFID#
							ORDER BY DateEntered DESC
						</cfquery>
						<!--- LEVEL 1 AFFILIATE ORDERS --->
						<cfquery name="getOrdersAF" datasource="#application.dsn#">
							SELECT		OrderID, BillingStatus, DateEntered AS OrderDate, DiscountTotal, CreditApplied, 
										AffiliatePaid, AffiliateTotal
							FROM 		Orders
							WHERE 		AffiliateID = #AFID#
							<cfif Form.FromDate NEQ '' AND Form.ToDate NEQ '' >
							AND		DateEntered >= '#Form.FromDate#'
							AND	 	DateEntered <= '#DateFormat(DateAdd("d", 1, Form.ToDate),"mm/dd/yyyy")#'
							</cfif>
							
							<!--- INCLUDE UNPAID/CANCELLED ??? --->
							<cfif isDefined('FORM.ExUnbilled')>
							AND		OrderStatus != 'BO'
							AND		BillingStatus != 'NB'
							</cfif>
							<cfif isDefined('FORM.ExCanceled')>
							AND		OrderStatus != 'CA'
							AND		OrderStatus != 'RE'
							AND		BillingStatus != 'CA'
							AND		BillingStatus != 'RE'
							AND		BillingStatus != 'DE'
							</cfif>
							
							ORDER BY OrderID
						</cfquery>
						<cfloop QUERY="getOrdersAF">
							<!--- GET ORDER TOTAL --->		
							<cfinvoke component="#application.Queries#" method="getOrderTotal" returnvariable="getOrderTotal">
								<cfinvokeargument name="OrderID" value="#getOrdersAF.OrderID#">
							</cfinvoke>								
							<cfquery name="getCommLevel1" dbtype="query" maxrows="1">
								SELECT 	L1
								FROM	getAFHistory
								WHERE	DateEntered <= '#OrderDate#'
							</cfquery>
							
							<cfif getCommLevel1.RecordCount EQ 0 >
								<cfset L1 = 0 >
							<cfelse>
								<cfset L1 = getCommLevel1.L1 >
							</cfif>
									
							<cfscript>
								RunningTotal = 0 ;
								if ( getOrderTotal.RunningTotal EQ '' )
									getOrderTotal.RunningTotal = 0 ;					
								RunningTotal = getOrderTotal.RunningTotal - DiscountTotal - CreditApplied ;
								SubTotal = SubTotal + RunningTotal ;
								CommissionTotal = NumberFormat((L1 / 100) * RunningTotal,9.99) ;
								AffiliateCommission = AffiliateCommission + CommissionTotal ;
								OrderTotals = OrderTotals + RunningTotal ;
								CommTotals = CommTotals + CommissionTotal ;
							</cfscript>
						</cfloop>
						
						<!--- LEVEL 2 AFFILIATE ORDERS --->
						<cfquery name="getAffiliatesL2" datasource="#application.dsn#">
							SELECT	AFID
							FROM	Affiliates
							WHERE	SubAffiliateOf = #AFID#
						</cfquery>
						<cfif getAffiliatesL2.RecordCount NEQ 0 >
							<cfloop query="getAffiliatesL2">
								<cfquery name="getOrdersAF" datasource="#application.dsn#">
									SELECT		OrderID, BillingStatus, DateEntered AS OrderDate, DiscountTotal, CreditApplied, 
												AffiliatePaid, AffiliateTotal
									FROM 		Orders
									WHERE 		AffiliateID = #getAffiliatesL2.AFID#
									<cfif Form.FromDate NEQ '' AND Form.ToDate NEQ '' >
									AND		DateEntered >= '#Form.FromDate#'
									AND	 	DateEntered <= '#DateFormat(DateAdd("d", 1, Form.ToDate),"mm/dd/yyyy")#'
									</cfif>
									
									<!--- INCLUDE UNPAID/CANCELLED ??? --->
									<cfif isDefined('FORM.ExUnbilled')>
									AND		OrderStatus != 'BO'
									AND		BillingStatus != 'NB'
									</cfif>
									<cfif isDefined('FORM.ExCanceled')>
									AND		OrderStatus != 'CA'
									AND		OrderStatus != 'RE'
									AND		BillingStatus != 'CA'
									AND		BillingStatus != 'RE'
									AND		BillingStatus != 'DE'
									</cfif>
									
									ORDER BY OrderID
								</cfquery>
								<cfloop QUERY="getOrdersAF">
									<!--- GET ORDER TOTAL --->		
									<cfinvoke component="#application.Queries#" method="getOrderTotal" returnvariable="getOrderTotal">
										<cfinvokeargument name="OrderID" value="#getOrdersAF.OrderID#">
									</cfinvoke>								
									<cfquery name="getCommLevel2" dbtype="query" maxrows="1">
										SELECT 	L2
										FROM	getAFHistory
										WHERE	DateEntered <= '#OrderDate#'
									</cfquery>
									
									<cfif getCommLevel2.RecordCount EQ 0 >
										<cfset L2 = 0 >
									<cfelse>
										<cfset L2 = getCommLevel2.L2 >
									</cfif>
									
									<cfscript>
										RunningTotal = 0 ;
										if ( getOrderTotal.RunningTotal EQ '' )
											getOrderTotal.RunningTotal = 0 ;					
										RunningTotal = getOrderTotal.RunningTotal - DiscountTotal - CreditApplied ;
										SubTotal = SubTotal + RunningTotal ;
										CommissionTotal = NumberFormat((L2 / 100) * RunningTotal,9.99) ;
										AffiliateCommission = AffiliateCommission + CommissionTotal ;
										OrderTotals = OrderTotals + RunningTotal ;
										CommTotals = CommTotals + CommissionTotal ;
									</cfscript>
								</cfloop>
								
								<!--- LEVEL 3 AFFILIATE ORDERS --->
								<cfquery name="getAffiliatesL3" datasource="#application.dsn#">
									SELECT	AFID
									FROM	Affiliates
									WHERE	SubAffiliateOf = #AFID#
								</cfquery>
								<cfif getAffiliatesL3.RecordCount NEQ 0 >
									<cfloop query="getAffiliatesL3">
										<cfquery name="getOrdersAF" datasource="#application.dsn#">
											SELECT		OrderID, BillingStatus, DateEntered AS OrderDate, DiscountTotal, CreditApplied, 
														AffiliatePaid, AffiliateTotal
											FROM 		Orders
											WHERE 		AffiliateID = #getAffiliatesL3.AFID#
											<cfif Form.FromDate NEQ '' AND Form.ToDate NEQ '' >
											AND		DateEntered >= '#Form.FromDate#'
											AND	 	DateEntered <= '#DateFormat(DateAdd("d", 1, Form.ToDate),"mm/dd/yyyy")#'

											</cfif>
											
											<!--- INCLUDE UNPAID/CANCELLED ??? --->
											<cfif isDefined('FORM.ExUnbilled')>
											AND		OrderStatus != 'BO'
											AND		BillingStatus != 'NB'
											</cfif>
											<cfif isDefined('FORM.ExCanceled')>
											AND		OrderStatus != 'CA'
											AND		OrderStatus != 'RE'
											AND		BillingStatus != 'CA'
											AND		BillingStatus != 'RE'
											AND		BillingStatus != 'DE'
											</cfif>
											
											ORDER BY OrderID
										</cfquery>
										<cfloop QUERY="getOrdersAF">
											<!--- GET ORDER TOTAL --->		
											<cfinvoke component="#application.Queries#" method="getOrderTotal" returnvariable="getOrderTotal">
												<cfinvokeargument name="OrderID" value="#getOrdersAF.OrderID#">
											</cfinvoke>
											<cfquery name="getCommLevel3" dbtype="query" maxrows="1">
												SELECT 	L3
												FROM	getAFHistory
												WHERE	DateEntered <= '#OrderDate#'
											</cfquery>
											
											<cfif getCommLevel3.RecordCount EQ 0 >
												<cfset L3 = 0 >
											<cfelse>
												<cfset L3 = getCommLevel3.L3 >
											</cfif>
											
											<cfscript>
												RunningTotal = 0 ;
												if ( getOrderTotal.RunningTotal EQ '' )
													getOrderTotal.RunningTotal = 0 ;					
												RunningTotal = getOrderTotal.RunningTotal - DiscountTotal - CreditApplied ;
												SubTotal = SubTotal + RunningTotal ;
												CommissionTotal = NumberFormat((L3 / 100) * RunningTotal,9.99) ;
												AffiliateCommission = AffiliateCommission + CommissionTotal ;
												OrderTotals = OrderTotals + RunningTotal ;
												CommTotals = CommTotals + CommissionTotal ;
											</cfscript>
										</cfloop>
									</cfloop>				
								</cfif>
							</cfloop>
						</cfif>
						<tr>
							<td>#AFID#</td>
							<td>#AffiliateName#</td>
							<td>
								<cfif getPaymentsAF.AFPDate EQ ''>
									---
								<cfelse>
									#DateFormat(getPaymentsAF.AFPDate,"mm/dd/yyyy")#
								</cfif>
							</td>
							<td align="right">#LSCurrencyFormat(SubTotal, "local")#</td>
							<cfloop query="getPaymentsAF">
								<cfscript>
									AFPaidTotal = AFPaidTotal + AFPAmount ;
									PaidTotals = PaidTotals + AFPaidTotal ;
								</cfscript>
							</cfloop>
							<td align="right">#LSCurrencyFormat(AffiliateCommission, "local")#</td>
							<td align="right">#LSCurrencyFormat(AffiliateCommission - AFPaidTotal, "local")#</td>
						</tr>
					</cfoutput>
					<cfoutput>
					<tr><td colspan="6" height="1" bgcolor="#cfAdminHeaderColor#"></td></tr>
					<tr>
						<td><b>TOTALS</b></td>
						<td></td>
						<td></td>
						<td align="right"><b>#LSCurrencyFormat(OrderTotals, "local")#</b></td>
						<td align="right"><b>#LSCurrencyFormat(CommTotals, "local")#</b></td>
						<td align="right" class="cfAdminError"><b>#LSCurrencyFormat(CommTotals - PaidTotals, "local")#</b></td>
					</tr>
					</cfoutput>
					
				</table>
			</td>
		</tr>
		<cfdocumentitem type="footer">
		<tr>
			<td align="center" height="30">	
				<div align="center">
				<font style="font-size:12px; font-family:Verdana, Arial, Helvetica, sans-serif;">
					<cfoutput>
					Page <b>#cfdocument.currentpagenumber#</b> of <b>#cfdocument.totalpagecount#</b>
					</cfoutput>
				</font>
				</div>
			</td>
		</tr>
		</cfdocumentitem>
	</table>


	</cfif><!--- REPORT TYPE --->
</cfdocument>
	
<cfelse><!--- ONLINE VIEWING --->
	<cfif Form.ReportType IS 'Summary' OR Form.ReportType IS 'Detail'>
	<cfscript>
		TotalAFOrders = 0;
		TotalAffiliates = 0;
		SubTotal = 0 ;
		AffiliateCommission = 0 ;
		CommissionTotal = 0 ;
		AFPaidTotal = 0 ;
		AFUnpaidTotal = 0 ;
	</cfscript>
	
	<br>
	<table width="820" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td width="100%" align="center">
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
					<b>AFFILIATE REPORT #UCASE(Form.ReportType)#</b>
					<cfif Form.FromDate NEQ '' AND Form.ToDate NEQ '' >
						| FROM: <b>#DateFormat(Form.FromDate,"mmm dd, yyyy")#</b> 
						  TO: <b>#DateFormat(Form.ToDate,"mmm dd, yyyy")#</b>
					</cfif>				
				</cfoutput>
				</div>
			</td>
		</tr>
		
	<!------------------------- BEGIN: DISPLAY RESULTS ------------------------->
		<tr>
			<td width="100%">
				<table width="100%" border="0" cellpadding="3" cellspacing="0" class="cfAdminDefault">
					<cfif Form.ReportType EQ 'Detail'>
					<tr style="background-color:##65ADF1;">
						<td width="5%"  class="cfAdminHeader1">AFID</td>
						<td width="10%" class="cfAdminHeader1" nowrap>Orders</td>
						<td width="10%" class="cfAdminHeader1" nowrap>Order Date</td>
						<td width="12%" class="cfAdminHeader1" nowrap>Cust. Billing Status</td>
						<td width="5%"  class="cfAdminHeader1" align="center">Level</td>
						<td width="10%" class="cfAdminHeader1" align="right">Order Total</td>
						<td width="10%" class="cfAdminHeader1" align="right" nowrap>Commission %</td>
						<td width="15%" class="cfAdminHeader1" align="right" nowrap>Commission Total</td>
					</tr>
					<cfelse>
					<tr style="background-color:##65ADF1;">
						<td width="10%" class="cfAdminHeader1">AFID</td>
						<td width="30%" class="cfAdminHeader1">Name</td>
						<td width="15%" class="cfAdminHeader1">Membership</td>
						<td width="15%" class="cfAdminHeader1" align="center">Orders</td>
						<td width="15%" class="cfAdminHeader1" align="right">Order Total</td>
						<td width="15%" class="cfAdminHeader1" align="right" nowrap>Commission Total</td>
					</tr>
					</cfif>
					
					<cfoutput query="getAffiliateData">
	
						<cfquery name="getOrdersAF" datasource="#application.dsn#">
							SELECT		OrderID, BillingStatus, DateEntered AS OrderDate, DiscountTotal, CreditApplied, 
										AffiliatePaid, AffiliateTotal
							FROM 		Orders
							WHERE 		AffiliateID = #AFID#
							<cfif Form.FromDate NEQ '' AND Form.ToDate NEQ '' >
							AND		DateEntered >= '#Form.FromDate#'
							AND	 	DateEntered <= '#DateFormat(DateAdd("d", 1, Form.ToDate),"mm/dd/yyyy")#'
							</cfif>
							
							<!--- INCLUDE UNPAID/CANCELLED ??? --->
							<cfif isDefined('FORM.ExUnbilled')>
							AND		OrderStatus != 'BO'
							AND		BillingStatus != 'NB'
							</cfif>
							<cfif isDefined('FORM.ExCanceled')>
							AND		OrderStatus != 'CA'
							AND		OrderStatus != 'RE'
							AND		BillingStatus != 'CA'
							AND		BillingStatus != 'RE'
							AND		BillingStatus != 'DE'
							</cfif>
							
							ORDER BY OrderID
						</cfquery>
						<cfquery name="getAFHistory" datasource="#application.dsn#">
							SELECT	*
							FROM	AffiliateHistory
							WHERE	AFID = #AFID#
							ORDER BY DateEntered DESC
						</cfquery>
						
						<cfscript>
							AffiliateID = AFID ;
							AffiliateSubTotal = 0 ;
							AffiliateCommTotal = 0 ;
							AffiliateOrders = 0 ;
						</cfscript>
						
						<cfloop QUERY="getOrdersAF">
						<cfset RunningTotal = 0 >
							<!--- GET ORDER TOTAL --->
							<cfinvoke component="#application.Queries#" method="getOrderTotal" returnvariable="getOrderTotal">
								<cfinvokeargument name="OrderID" value="#getOrdersAF.OrderID#">
							</cfinvoke>
							<cfquery name="getCommLevel1" dbtype="query" maxrows="1">
								SELECT 	L1
								FROM	getAFHistory
								WHERE	DateEntered <= '#OrderDate#'
							</cfquery>
							
							<cfif getCommLevel1.RecordCount EQ 0 >
								<cfset L1 = 0 >
							<cfelse>
								<cfset L1 = getCommLevel1.L1 >
							</cfif>
							
							<cfscript>
								if ( getOrderTotal.RunningTotal EQ '' )
									getOrderTotal.RunningTotal = 0 ;
								RunningTotal = getOrderTotal.RunningTotal - DiscountTotal - CreditApplied ;
								SubTotal = SubTotal + RunningTotal ;
								AffiliateSubTotal = AffiliateSubTotal + RunningTotal ;
								CommissionTotal = NumberFormat((L1 / 100) * RunningTotal,9.99) ;
								AffiliateCommission = AffiliateCommission + CommissionTotal ;
								AffiliateCommTotal = AffiliateCommTotal + CommissionTotal ;
								TotalAFOrders = TotalAFOrders + 1 ;
								AffiliateOrders = AffiliateOrders + 1 ;
							</cfscript>
						<cfif Form.ReportType EQ 'Detail'>
						<tr>
							<td>#AffiliateID#</td>
							<td>#OrderID#</td>
							<td>#DateFormat(OrderDate,"dd-mmm-yyyy")#</td>
							<cfinvoke component="#application.Queries#" method="getBillingStatusCode" returnvariable="getBillingStatus">
								<cfinvokeargument name="StatusCode" value="#getOrdersAF.BillingStatus#">
							</cfinvoke>
							<td>#getBillingStatus.StatusMessage#</td>
							<!--- AFFILIATE COMMISSION LEVEL --->
							<td align="center">1</td>
							<!--- ORDER TOTAL --->
							<td align="right">#LSCurrencyFormat(RunningTotal, "local")#</td>
							<!--- COMMISSION LEVEL PERCENTAGE --->
							<td align="right">#DecimalFormat(L1)#%</td>
							<!--- COMMISSION TOTAL --->
							<td align="right">#LSCurrencyFormat(CommissionTotal, "local")#</td>
						</tr>
						</cfif>
						</cfloop>
						<!--- LEVEL 2 AFFILIATE ORDERS --->
						<cfquery name="getAffiliatesL2" datasource="#application.dsn#">
							SELECT	AFID
							FROM	Affiliates
							WHERE	SubAffiliateOf = #AFID#
						</cfquery>
						<cfif getAffiliatesL2.RecordCount NEQ 0 >
							<cfloop query="getAffiliatesL2">
								<cfquery name="getOrdersAF" datasource="#application.dsn#">
									SELECT		OrderID, BillingStatus, DateEntered AS OrderDate, DiscountTotal, CreditApplied, 
												AffiliatePaid, AffiliateTotal
									FROM 		Orders
									WHERE 		AffiliateID = #getAffiliatesL2.AFID#
									<cfif Form.FromDate NEQ '' AND Form.ToDate NEQ '' >
									AND		DateEntered >= '#Form.FromDate#'
									AND	 	DateEntered <= '#DateFormat(DateAdd("d", 1, Form.ToDate),"mm/dd/yyyy")#'
									</cfif>
									
									<!--- INCLUDE UNPAID/CANCELLED ??? --->
									<cfif isDefined('FORM.ExUnbilled')>
									AND		OrderStatus != 'BO'
									AND		BillingStatus != 'NB'
									</cfif>
									<cfif isDefined('FORM.ExCanceled')>
									AND		OrderStatus != 'CA'
									AND		OrderStatus != 'RE'
									AND		BillingStatus != 'CA'
									AND		BillingStatus != 'RE'
									AND		BillingStatus != 'DE'
									</cfif>
									
									ORDER BY OrderID
								</cfquery>
								
								<cfloop QUERY="getOrdersAF">
								<cfset RunningTotal = 0 >
									<!--- GET ORDER TOTAL --->
									<cfinvoke component="#application.Queries#" method="getOrderTotal" returnvariable="getOrderTotal">
										<cfinvokeargument name="OrderID" value="#getOrdersAF.OrderID#">
									</cfinvoke>
									<cfquery name="getCommLevel2" dbtype="query" maxrows="1">
										SELECT 	L2
										FROM	getAFHistory
										WHERE	DateEntered <= '#OrderDate#'
									</cfquery>
									
									<cfif getCommLevel2.RecordCount EQ 0 >
										<cfset L2 = 0 >
									<cfelse>
										<cfset L2 = getCommLevel2.L2 >
									</cfif>
									
									<cfscript>
										if ( getOrderTotal.RunningTotal EQ '' )
											getOrderTotal.RunningTotal = 0 ;
										RunningTotal = getOrderTotal.RunningTotal - DiscountTotal - CreditApplied ;
										SubTotal = SubTotal + RunningTotal ;
										AffiliateSubTotal = AffiliateSubTotal + RunningTotal ;
										CommissionTotal = NumberFormat((L2 / 100) * RunningTotal,9.99) ;
										AffiliateCommission = AffiliateCommission + CommissionTotal ;
										AffiliateCommTotal = AffiliateCommTotal + CommissionTotal ;
										TotalAFOrders = TotalAFOrders + 1 ;
										AffiliateOrders = AffiliateOrders + 1 ;
									</cfscript>
								<cfif Form.ReportType EQ 'Detail'>
								<tr>
									<td>#AffiliateID#</td>
									<td>#OrderID#</td>
									<td>#DateFormat(OrderDate,"dd-mmm-yyyy")#</td>
									<cfinvoke component="#application.Queries#" method="getBillingStatusCode" returnvariable="getBillingStatus">
										<cfinvokeargument name="StatusCode" value="#getOrdersAF.BillingStatus#">
									</cfinvoke>
									<td>#getBillingStatus.StatusMessage#</td>
									<!--- AFFILIATE COMMISSION LEVEL --->
									<td align="center">2</td>
									<!--- ORDER TOTAL --->
									<td align="right">#LSCurrencyFormat(RunningTotal, "local")#</td>
									<!--- COMMISSION LEVEL PERCENTAGE --->
									<td align="right">#DecimalFormat(L2)#%</td>
									<!--- COMMISSION TOTAL --->
									<td align="right">#LSCurrencyFormat(CommissionTotal, "local")#</td>
								</tr>
								</cfif>
								</cfloop>
								<!--- LEVEL 3 AFFILIATE ORDERS --->
								<cfquery name="getAffiliatesL3" datasource="#application.dsn#">
									SELECT	AFID
									FROM	Affiliates
									WHERE	SubAffiliateOf = #AFID#
								</cfquery>
								<cfif getAffiliatesL3.RecordCount NEQ 0 >
									<cfloop query="getAffiliatesL3">
										<cfquery name="getOrdersAF" datasource="#application.dsn#">
											SELECT		OrderID, BillingStatus, DateEntered AS OrderDate, DiscountTotal, CreditApplied, 
														AffiliatePaid, AffiliateTotal
											FROM 		Orders
											WHERE 		AffiliateID = #getAffiliatesL3.AFID#
											<cfif Form.FromDate NEQ '' AND Form.ToDate NEQ '' >
											AND		DateEntered >= '#Form.FromDate#'
											AND	 	DateEntered <= '#DateFormat(DateAdd("d", 1, Form.ToDate),"mm/dd/yyyy")#'
											</cfif>
											
											<!--- INCLUDE UNPAID/CANCELLED ??? --->
											<cfif isDefined('FORM.ExUnbilled')>
											AND		OrderStatus != 'BO'
											AND		BillingStatus != 'NB'
											</cfif>
											<cfif isDefined('FORM.ExCanceled')>
											AND		OrderStatus != 'CA'
											AND		OrderStatus != 'RE'
											AND		BillingStatus != 'CA'
											AND		BillingStatus != 'RE'
											AND		BillingStatus != 'DE'
											</cfif>
											
											ORDER BY OrderID
										</cfquery>
										
										<cfloop QUERY="getOrdersAF">
										<cfset RunningTotal = 0 >
											<!--- GET ORDER TOTAL --->
											<cfinvoke component="#application.Queries#" method="getOrderTotal" returnvariable="getOrderTotal">
												<cfinvokeargument name="OrderID" value="#getOrdersAF.OrderID#">
											</cfinvoke>
											<cfquery name="getCommLevel3" dbtype="query" maxrows="1">
												SELECT 	L3
												FROM	getAFHistory
												WHERE	DateEntered <= '#OrderDate#'
											</cfquery>
											
											<cfif getCommLevel3.RecordCount EQ 0 >
												<cfset L3 = 0 >
											<cfelse>
												<cfset L3 = getCommLevel3.L3 >
											</cfif>
											
											<cfscript>
												if ( getOrderTotal.RunningTotal EQ '' )
													getOrderTotal.RunningTotal = 0 ;
												RunningTotal = getOrderTotal.RunningTotal - DiscountTotal - CreditApplied ;
												SubTotal = SubTotal + RunningTotal ;
												AffiliateSubTotal = AffiliateSubTotal + RunningTotal ;
												CommissionTotal = NumberFormat((L3 / 100) * RunningTotal,9.99) ;
												AffiliateCommission = AffiliateCommission + CommissionTotal ;
												AFUnpaidTotal = AFUnpaidTotal + AffiliateCommTotal - AFPaidTotal ;
												TotalAFOrders = TotalAFOrders + 1 ;
												AffiliateOrders = AffiliateOrders + 1 ;											
											</cfscript>
										<cfif Form.ReportType EQ 'Detail'>
										<tr>
											<td>#AffiliateID#</td>
											<td>#OrderID#</td>
											<td>#DateFormat(OrderDate,"dd-mmm-yyyy")#</td>
											<cfinvoke component="#application.Queries#" method="getBillingStatusCode" returnvariable="getBillingStatus">
												<cfinvokeargument name="StatusCode" value="#getOrdersAF.BillingStatus#">
											</cfinvoke>
											<td>#getBillingStatus.StatusMessage#</td>
											<!--- AFFILIATE COMMISSION LEVEL --->
											<td align="center">3</td>
											<!--- ORDER TOTAL --->
											<td align="right">#LSCurrencyFormat(RunningTotal, "local")#</td>
											<!--- COMMISSION LEVEL PERCENTAGE --->
											<td align="right">#DecimalFormat(L3)#%</td>
											<!--- COMMISSION TOTAL --->
											<td align="right">#LSCurrencyFormat(CommissionTotal, "local")#</td>
										</tr>
										</cfif>
										</cfloop>
									</cfloop>
								</cfif>
							</cfloop>
						</cfif>
						<cfif Form.ReportType EQ 'Summary'>
							<cfinvoke component="#application.Queries#" method="getAFLevel" returnvariable="getAFLevel">
								<cfinvokeargument name="CommID" value="#MemberType#">
							</cfinvoke>
						<tr>
							<td>#AffiliateID#</td>						
							<td>#AffiliateName#</td>
							<td>#getAFLevel.LevelName#</td>
							<td align="center">#AffiliateOrders#</td>
							<td align="right">#LSCurrencyFormat(AffiliateSubTotal, "local")#</td>
							<td align="right">#LSCurrencyFormat(AffiliateCommTotal, "local")#</td>
						</tr>
						<cfscript>
							AffiliateSubTotal = 0 ;
							AffiliateCommTotal = 0 ;
							AffiliateOrders = 0 ;
						</cfscript>
						</cfif>
					</cfoutput>
					<cfoutput>
					<cfif Form.ReportType EQ 'Detail'>
					<tr><td colspan="9" height="1" bgcolor="#cfAdminHeaderColor#"></td></tr>
					<tr>
						<td><b>#getAffiliateData.RecordCount#</b></td>
						<td><b>#TotalAFOrders# Orders</b></td>
						<td></td>
						<td></td>
						<td></td>
						<td align="right"><b>#LSCurrencyFormat(SubTotal, "local")#</b></td>
						<td></td>
						<td align="right"><b>#LSCurrencyFormat(AffiliateCommission, "local")#</b></td>
					</tr>
					<cfelse>
					<tr><td colspan="9" height="1" bgcolor="#cfAdminHeaderColor#"></td></tr>
					<tr>
						<td><b>#getAffiliateData.RecordCount#</b></td>
						<td></td>
						<td></td>
						<td align="center"><b>#TotalAFOrders# Orders</b></td>
						<td align="right"><b>#LSCurrencyFormat(SubTotal, "local")#</b></td>
						<td align="right"><b>#LSCurrencyFormat(AffiliateCommission, "local")#</b></td>
					</tr>
					</cfif>
					</cfoutput>
				</table>
			</td>
		</tr>
	</table>
	<!------------------------- END: DISPLAY RESULTS ------------------------->
	
	
	
	<cfelseif Form.ReportType IS 'Payments'>
	<cfscript>
		AFPaidTotal = 0 ;
		AFUnpaidTotal = 0 ;
		AFChecks = 0 ;
	</cfscript>
	
	<br>
	<table width="820" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td width="100%" align="center">
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
					<b>PAYMENTS MADE TO AFFILIATES</b>
					<cfif Form.FromDate NEQ '' AND Form.ToDate NEQ '' >
						| FROM: <b>#DateFormat(Form.FromDate,"mmm dd, yyyy")#</b> 
						  TO: <b>#DateFormat(Form.ToDate,"mmm dd, yyyy")#</b>
					</cfif>				
				</cfoutput>
				</div>
			</td>
		</tr>
		<!------------------------- BEGIN: DISPLAY RESULTS ------------------------->
		<tr>
			<td width="100%">
				<table width="100%" border="0" cellpadding="3" cellspacing="0" class="cfAdminDefault">
					<tr style="background-color:##7DBF0E;">
						<td width="10%"  class="cfAdminHeader1">AFID</td>
						<td width="20%" class="cfAdminHeader1">Name</td>
						<td width="15%" class="cfAdminHeader1">Date</td>
						<td width="15%" class="cfAdminHeader1">Amount</td>
						<td width="15%" class="cfAdminHeader1">Check No.</td>
						<td width="25%" class="cfAdminHeader1">Comments</td>
					</tr>
					
					<cfoutput query="getAffiliateData">
						
						<cfquery name="getPaymentsAF" datasource="#application.dsn#">
							SELECT	*
							FROM	AffiliatePayments
							WHERE	AFID = #AFID#
							<cfif Form.FromDate NEQ '' AND Form.ToDate NEQ '' >
							AND		AFPDate >= '#Form.FromDate#'
							AND	 	AFPDate <= '#DateFormat(DateAdd("d", 1, Form.ToDate),"mm/dd/yyyy")#'
							</cfif>
						</cfquery>
						
						<cfscript>
							AffiliateID = AFID ;
							AFName = AffiliateName ;
						</cfscript>
						
						<cfloop QUERY="getPaymentsAF">
							<tr>
								<td>#AffiliateID#</td>
								<td>#AFName#</td>
								<td>#DateFormat(AFPDate,'mm/dd/yyyy')#</td>
								<td>$#DecimalFormat(AFPAmount)#</td>
								<td>#AFPCheck#</td>
								<td>#AFPComments#</td>
							</tr>
							<cfscript>
								AFPaidTotal = AFPaidTotal + AFPAmount ;
								AFChecks = AFChecks + 1 ;
							</cfscript>
						</cfloop>
					</cfoutput>
					<cfoutput>
					<tr><td colspan="9" height="1" bgcolor="#cfAdminHeaderColor#"></td></tr>
					<tr>
						<td><b>TOTALS</b></td>
						<td></td>
						<td></td>
						<td><b>#LSCurrencyFormat(AFPaidTotal, "local")#</b></td>
						<td><b>#AFChecks# Payments</b></td>
						<td></td>
					</tr>
					</cfoutput>
				</table>
			</td>
		</tr>
	</table>
	
	
	
	<cfelseif Form.ReportType IS 'PaymentsDue'>
	<cfscript>
		TotalAFOrders = 0;
		TotalAffiliates = 0;
		SubTotal = 0 ;
		AffiliateCommission = 0 ;
		CommissionTotal = 0 ;
		AFPaidTotal = 0 ;
		AFUnpaidTotal = 0 ;
		AFChecks = 0 ;
	</cfscript>
	
	<br>
	<table width="820" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td width="100%" align="center">
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
					<b>PAYMENTS DUE AFFILIATES</b>
					<cfif Form.FromDate NEQ '' AND Form.ToDate NEQ '' >
						| FROM: <b>#DateFormat(Form.FromDate,"mmm dd, yyyy")#</b> 
						  TO: <b>#DateFormat(Form.ToDate,"mmm dd, yyyy")#</b>
					</cfif>				
				</cfoutput>
				</div>
			</td>
		</tr>
		<!------------------------- BEGIN: DISPLAY RESULTS ------------------------->
		<tr>
			<td width="100%">
				<table width="100%" border="0" cellpadding="3" cellspacing="0" class="cfAdminDefault">
					<tr style="background-color:##7DBF0E;">
						<td width="10%"  class="cfAdminHeader1">AFID</td>
						<td width="20%" class="cfAdminHeader1">Name</td>
						<td width="20%" class="cfAdminHeader1">Last Date Paid</td>
						<td width="15%" class="cfAdminHeader1" align="right">Order Totals</td>
						<td width="15%" class="cfAdminHeader1" align="right">Comm. Totals</td>
						<td width="15%" class="cfAdminHeader1" align="right">Amount Due</td>
					</tr>
					
					<cfscript>
						OrderTotals = 0 ;
						CommTotals = 0 ;
						PaidTotals = 0 ;
					</cfscript>
						
					<cfoutput query="getAffiliateData">
							
						<cfscript>
							SubTotal = 0 ;
							AFPaidTotal = 0 ;
							AFUnpaidTotal = 0 ;
							AffiliateCommission = 0 ;
							CommissionTotal = 0 ;
						</cfscript>
						
						<cfinvoke component="#application.Queries#" method="getPaymentsAF" returnvariable="getPaymentsAF">
							<cfinvokeargument name="AFID" value="#AFID#">
						</cfinvoke>
						<cfquery name="getAFHistory" datasource="#application.dsn#">
							SELECT	*
							FROM	AffiliateHistory
							WHERE	AFID = #AFID#
							ORDER BY DateEntered DESC
						</cfquery>
						<!--- LEVEL 1 AFFILIATE ORDERS --->
						<cfquery name="getOrdersAF" datasource="#application.dsn#">
							SELECT		OrderID, BillingStatus, DateEntered AS OrderDate, DiscountTotal, CreditApplied, 
										AffiliatePaid, AffiliateTotal
							FROM 		Orders
							WHERE 		AffiliateID = #AFID#
							<cfif Form.FromDate NEQ '' AND Form.ToDate NEQ '' >
							AND		DateEntered >= '#Form.FromDate#'
							AND	 	DateEntered <= '#DateFormat(DateAdd("d", 1, Form.ToDate),"mm/dd/yyyy")#'
							</cfif>
							
							<!--- INCLUDE UNPAID/CANCELLED ??? --->
							<cfif isDefined('FORM.ExUnbilled')>
							AND		OrderStatus != 'BO'
							AND		BillingStatus != 'NB'
							</cfif>
							<cfif isDefined('FORM.ExCanceled')>
							AND		OrderStatus != 'CA'
							AND		OrderStatus != 'RE'
							AND		BillingStatus != 'CA'
							AND		BillingStatus != 'RE'
							AND		BillingStatus != 'DE'
							</cfif>
							
							ORDER BY OrderID
						</cfquery>
						<cfloop QUERY="getOrdersAF">
							<!--- GET ORDER TOTAL --->		
							<cfinvoke component="#application.Queries#" method="getOrderTotal" returnvariable="getOrderTotal">
								<cfinvokeargument name="OrderID" value="#getOrdersAF.OrderID#">
							</cfinvoke>								
							<cfquery name="getCommLevel1" dbtype="query" maxrows="1">
								SELECT 	L1
								FROM	getAFHistory
								WHERE	DateEntered <= '#OrderDate#'
							</cfquery>
							
							<cfif getCommLevel1.RecordCount EQ 0 >
								<cfset L1 = 0 >
							<cfelse>
								<cfset L1 = getCommLevel1.L1 >
							</cfif>
									
							<cfscript>
								RunningTotal = 0 ;
								if ( getOrderTotal.RunningTotal EQ '' )
									getOrderTotal.RunningTotal = 0 ;					
								RunningTotal = getOrderTotal.RunningTotal - DiscountTotal - CreditApplied ;
								SubTotal = SubTotal + RunningTotal ;
								CommissionTotal = NumberFormat((L1 / 100) * RunningTotal,9.99) ;
								AffiliateCommission = AffiliateCommission + CommissionTotal ;
								OrderTotals = OrderTotals + RunningTotal ;
								CommTotals = CommTotals + CommissionTotal ;
							</cfscript>
						</cfloop>
						
						<!--- LEVEL 2 AFFILIATE ORDERS --->
						<cfquery name="getAffiliatesL2" datasource="#application.dsn#">
							SELECT	AFID
							FROM	Affiliates
							WHERE	SubAffiliateOf = #AFID#
						</cfquery>
						<cfif getAffiliatesL2.RecordCount NEQ 0 >
							<cfloop query="getAffiliatesL2">
								<cfquery name="getOrdersAF" datasource="#application.dsn#">
									SELECT		OrderID, BillingStatus, DateEntered AS OrderDate, DiscountTotal, CreditApplied, 
												AffiliatePaid, AffiliateTotal
									FROM 		Orders
									WHERE 		AffiliateID = #getAffiliatesL2.AFID#
									<cfif Form.FromDate NEQ '' AND Form.ToDate NEQ '' >
									AND		DateEntered >= '#Form.FromDate#'
									AND	 	DateEntered <= '#DateFormat(DateAdd("d", 1, Form.ToDate),"mm/dd/yyyy")#'
									</cfif>
									
									<!--- INCLUDE UNPAID/CANCELLED ??? --->
									<cfif isDefined('FORM.ExUnbilled')>
									AND		OrderStatus != 'BO'
									AND		BillingStatus != 'NB'
									</cfif>
									<cfif isDefined('FORM.ExCanceled')>
									AND		OrderStatus != 'CA'
									AND		OrderStatus != 'RE'
									AND		BillingStatus != 'CA'
									AND		BillingStatus != 'RE'
									AND		BillingStatus != 'DE'
									</cfif>
									
									ORDER BY OrderID
								</cfquery>
								<cfloop QUERY="getOrdersAF">
									<!--- GET ORDER TOTAL --->		
									<cfinvoke component="#application.Queries#" method="getOrderTotal" returnvariable="getOrderTotal">
										<cfinvokeargument name="OrderID" value="#getOrdersAF.OrderID#">
									</cfinvoke>								
									<cfquery name="getCommLevel2" dbtype="query" maxrows="1">
										SELECT 	L2
										FROM	getAFHistory
										WHERE	DateEntered <= '#OrderDate#'
									</cfquery>
									
									<cfif getCommLevel2.RecordCount EQ 0 >
										<cfset L2 = 0 >
									<cfelse>
										<cfset L2 = getCommLevel2.L2 >
									</cfif>
									
									<cfscript>
										RunningTotal = 0 ;
										if ( getOrderTotal.RunningTotal EQ '' )
											getOrderTotal.RunningTotal = 0 ;					
										RunningTotal = getOrderTotal.RunningTotal - DiscountTotal - CreditApplied ;
										SubTotal = SubTotal + RunningTotal ;
										CommissionTotal = NumberFormat((L2 / 100) * RunningTotal,9.99) ;
										AffiliateCommission = AffiliateCommission + CommissionTotal ;
										OrderTotals = OrderTotals + RunningTotal ;
										CommTotals = CommTotals + CommissionTotal ;
									</cfscript>
								</cfloop>
								
								<!--- LEVEL 3 AFFILIATE ORDERS --->
								<cfquery name="getAffiliatesL3" datasource="#application.dsn#">
									SELECT	AFID
									FROM	Affiliates
									WHERE	SubAffiliateOf = #AFID#
								</cfquery>
								<cfif getAffiliatesL3.RecordCount NEQ 0 >
									<cfloop query="getAffiliatesL3">
										<cfquery name="getOrdersAF" datasource="#application.dsn#">
											SELECT		OrderID, BillingStatus, DateEntered AS OrderDate, DiscountTotal, CreditApplied, 
														AffiliatePaid, AffiliateTotal
											FROM 		Orders
											WHERE 		AffiliateID = #getAffiliatesL3.AFID#
											<cfif Form.FromDate NEQ '' AND Form.ToDate NEQ '' >
											AND		DateEntered >= '#Form.FromDate#'
											AND	 	DateEntered <= '#DateFormat(DateAdd("d", 1, Form.ToDate),"mm/dd/yyyy")#'
											</cfif>
											
											<!--- INCLUDE UNPAID/CANCELLED ??? --->
											<cfif isDefined('FORM.ExUnbilled')>
											AND		OrderStatus != 'BO'
											AND		BillingStatus != 'NB'
											</cfif>
											<cfif isDefined('FORM.ExCanceled')>
											AND		OrderStatus != 'CA'
											AND		OrderStatus != 'RE'
											AND		BillingStatus != 'CA'
											AND		BillingStatus != 'RE'
											AND		BillingStatus != 'DE'
											</cfif>
											
											ORDER BY OrderID
										</cfquery>
										<cfloop QUERY="getOrdersAF">
											<!--- GET ORDER TOTAL --->		
											<cfinvoke component="#application.Queries#" method="getOrderTotal" returnvariable="getOrderTotal">
												<cfinvokeargument name="OrderID" value="#getOrdersAF.OrderID#">
											</cfinvoke>
											<cfquery name="getCommLevel3" dbtype="query" maxrows="1">
												SELECT 	L3
												FROM	getAFHistory
												WHERE	DateEntered <= '#OrderDate#'
											</cfquery>
											
											<cfif getCommLevel3.RecordCount EQ 0 >
												<cfset L3 = 0 >
											<cfelse>
												<cfset L3 = getCommLevel3.L3 >
											</cfif>
											
											<cfscript>
												RunningTotal = 0 ;
												if ( getOrderTotal.RunningTotal EQ '' )
													getOrderTotal.RunningTotal = 0 ;					
												RunningTotal = getOrderTotal.RunningTotal - DiscountTotal - CreditApplied ;
												SubTotal = SubTotal + RunningTotal ;
												CommissionTotal = NumberFormat((L3 / 100) * RunningTotal,9.99) ;
												AffiliateCommission = AffiliateCommission + CommissionTotal ;
												OrderTotals = OrderTotals + RunningTotal ;
												CommTotals = CommTotals + CommissionTotal ;
											</cfscript>
										</cfloop>
									</cfloop>				
								</cfif>
							</cfloop>
						</cfif>
						<tr>
							<td>#AFID#</td>
							<td>#AffiliateName#</td>
							<td>
								<cfif getPaymentsAF.AFPDate EQ ''>
									---
								<cfelse>
									#DateFormat(getPaymentsAF.AFPDate,"mm/dd/yyyy")#
								</cfif>
							</td>
							<td align="right">#LSCurrencyFormat(SubTotal, "local")#</td>
							<cfloop query="getPaymentsAF">
								<cfscript>
									AFPaidTotal = AFPaidTotal + AFPAmount ;
									PaidTotals = PaidTotals + AFPaidTotal ;
								</cfscript>
							</cfloop>
							<td align="right">#LSCurrencyFormat(AffiliateCommission, "local")#</td>
							<td align="right">#LSCurrencyFormat(AffiliateCommission - AFPaidTotal, "local")#</td>
						</tr>
					</cfoutput>
					<cfoutput>
					<tr><td colspan="9" height="1" bgcolor="#cfAdminHeaderColor#"></td></tr>
					<tr>
						<td><b>TOTALS</b></td>
						<td></td>
						<td></td>
						<td align="right"><b>#LSCurrencyFormat(OrderTotals, "local")#</b></td>
						<td align="right"><b>#LSCurrencyFormat(CommTotals, "local")#</b></td>
						<td align="right" class="cfAdminError"><b>#LSCurrencyFormat(CommTotals - PaidTotals, "local")#</b></td>
					</tr>
					</cfoutput>
					
				</table>
			</td>
		</tr>
	</table>


	</cfif><!--- REPORT TYPE --->
</cfif><!--- VIEWING - ONLINE OR PDF --->

<cfinclude template="LayoutAdminFooter.cfm">