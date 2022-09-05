

<cfif not structKeyExists(session, 'AffiliateArray') OR session.AffiliateArray[1] eq ''>
	<cflocation url="AF-Login.cfm" addtoken="no">
</cfif>

<cfoutput>

<cfmodule template="templates/#application.SiteTemplate#/layout.cfm" currenttab="Affiliates" pagetitle="Affiliate Area" showexpireheaders="True">
<!--- Start Breadcrumb --->
<cfmodule template="tags/breadCrumbs.cfm" crumblevel='1' showlinkcrumb="Affiliate Home" />
<!--- End BreadCrumb --->


<!--- Affiliate Queries --->
<cfscript>
	// Get Affiliate Queries
	getAffiliate = application.Queries.getAffiliate(AFID = session.AffiliateArray[1]);
	getOrdersAF = application.Queries.getOrdersAF(AffiliateID=session.AffiliateArray[1]);
	getPaymentsAF = application.Queries.getPaymentsAF(AFID = session.AffiliateArray[1]);
	//Get Affiliate History
	getAffiliateHistory = application.queries.getAffiliateHistory(afid=session.AffiliateArray[1]);
	
	// Variables Used In Page
	if ( getAffiliate.Password NEQ '') decrypted_Password = DECRYPT(getAffiliate.Password, application.CryptKey, "CFMX_COMPAT", "Hex") ;
	else decrypted_Password = '';
		SubTotal = 0 ;
		AffiliateCommission = 0 ;
		CommissionTotal = 0 ;
		AFPaidTotal = 0 ;
		AFUnpaidTotal = 0 ;
		AvailableFunds = 0 ;
		AFOrders = 0 ;
		AFAffiliates = 0 ;
</cfscript>

<!--- DEFAULT AFFILIATE SECTIONS TO SHOW --->
<cfparam name="show1" default="0">
<cfparam name="show2" default="0">
<cfparam name="show3" default="0">
<cfparam name="show4" default="0">
<cfparam name="show5" default="0">

<script language="javascript">

	if (document.getElementById){ 
	document.write('<style type="text/css">\n')
	document.write('.submenu1{display: <cfif NOT show1 >none<cfelse>block</cfif>;}\n')
	document.write('</style>\n')
	document.write('<style type="text/css">\n')
	document.write('.submenu2{display: <cfif NOT show2 >none<cfelse>block</cfif>;}\n')
	document.write('</style>\n')
	document.write('<style type="text/css">\n')
	document.write('.submenu3{display: <cfif NOT show3 >none<cfelse>block</cfif>;}\n')
	document.write('</style>\n')
	document.write('<style type="text/css">\n')
	document.write('.submenu4{display: <cfif NOT show4 >none<cfelse>block</cfif>;}\n')
	document.write('</style>\n')
	document.write('<style type="text/css">\n')
	document.write('.submenu5{display: <cfif NOT show5 >none<cfelse>block</cfif>;}\n')
	document.write('</style>\n')
	}
	
	function SwitchMenu(obj){
		if(document.getElementById){
			var el = document.getElementById(obj);
			var ar = document.getElementById("MyAccount").getElementsByTagName("span"); 
			if(el.style.display != "block"){ 
				// the commented code is to hide others when one is clicked/shown
				for (var i=0; i<ar.length; i++){
					if (ar[i].className=="submenu1") 
					ar[i].style.display = "none";
					if (ar[i].className=="submenu2") 
					ar[i].style.display = "none";
					if (ar[i].className=="submenu3") 
					ar[i].style.display = "none";
					if (ar[i].className=="submenu4") 
					ar[i].style.display = "none";
					if (ar[i].className=="submenu5") 
					ar[i].style.display = "none";
				}
				el.style.display = "block";
			}else{
				el.style.display = "none";
			}
		}
	}
</script>

<!--- <cfoutput> --->
<div id="MyAccount">
<table cellpadding="0" cellspacing="0" border="0" width="100%">
	<tr valign="top">
		<td class="sub_pagehead"><span class="sub_pagetitle">Welcome, #session.AffiliateArray[2]# #session.AffiliateArray[3]#!<br></span></td>
	</tr>
	<tr valign="top">
		<td class="cfDefault" align="center" valign="middle">[click <img src="images/icon-down.gif" align="absmiddle" /> to show/hide]<br><br></td>
	</tr>
</table>
<!--- </cfoutput> --->

<!---------------------------------------------------- AFFILIATE PAYMENTS -------------------------------------------------->
<div class="myaccount" align="left" onclick="SwitchMenu('sub1')">
	<img src="images/icon-down.gif" align="absmiddle" /> &nbsp;My Payments
</div>
<span class="submenu1" id="sub1" style="padding: 10px 0px 0px 0px;">
	<cfif not getPaymentsAF.RecordCount>
		<div class="cfMessageTwo" align="center">You have not been issued any commission payments.</div>
	<cfelse>				
		<table class="cartLayoutTable">
			<tr>
				<th align="center" width="4%">##</th>
				<th align="center" width="15%">Date</th>
				<th align="center" width="15%">Amount</th>
				<th width="*"></th>
			</tr>
			
			<cfloop query="getPaymentsAF"><!--- <cfoutput query="getPaymentsAF"> --->
				<tr class="row#CurrentRow mod 2#">
					<td align="center" width="4%">#getPaymentsAF.CurrentRow#</td>
					<td align="center" width="15%">#DateFormat(AFPDate,'dd-mmm-yyyy')#</td>
					<td align="center" width="15%" align="right">$#DecimalFormat(AFPAmount)#</td>
					<td width="*"></td>
				</tr>
				<!--- DIVIDER --->
				<!--- <tr bgcolor="##CCC">
					<td height="1" colspan="4"></td>
				</tr> --->
				<cfscript>
					AFPaidTotal = AFPaidTotal + AFPAmount ;
				</cfscript>
			</cfloop><!--- </cfoutput> --->
			<!--- TOTALS --->
			<!--- <cfoutput> --->
			<tr class="cart_footer">
				<td colspan="4" align="right">
					<strong>Payments Made:</strong> #getPaymentsAF.RecordCount#
					&nbsp;&nbsp;&nbsp;
					<strong>Total Payments:</strong> $#DecimalFormat(AFPaidTotal)#
				</td>
			</tr>
			<!--- </cfoutput> --->
		</table>
	</cfif>
</span>
<br/>


<!------------------------------------------------------------ AFFILIATE ORDERS ------------------------------------------------>
<div class="myaccount" align="left" onclick="SwitchMenu('sub2')">
	<img src="images/icon-down.gif" align="absmiddle" /> &nbsp;My Orders
</div>
<span class="submenu2" id="sub2" style="padding: 10px 0px 0px 0px;">
	<table class="cartLayoutTable">
		<tr>
			<th align="center" width="12%">Order ID</th>
			<th align="center" width="15%">Order Date</th>
			<th align="center" width="15%">Billing Status</th>
			<th align="center" width="8%" >Level</th>
			<th align="center" width="18%">Order Total</th>
			<th align="center" width="16%">Commission %</th>
			<th align="center" width="16%">Commission Total</th>
		</tr>
		<cfloop query="getOrdersAF"><!--- <cfoutput query="getOrdersAF"> --->
			<!--- Commented out bt Carl Vanderpal 22 May 2007 --->
			<!--- <cfform action="AffiliateDetail.cfm" method="post"> --->
				<tr class="row#CurrentRow mod 2#">
					<td align="center" width="12%">#OrderID#</td>
					<td align="center" width="15%">#DateFormat(OrderDate,"dd-mmm-yyyy")#</td>
					
					<!--- TODO: Convert to CFC --->
					<cfscript>
						getBillingStatus = application.Queries.getBillingStatusCode(StatusCode=getOrdersAF.BillingStatus);
					</cfscript>
					
					<td align="center" width="15%">#getBillingStatus.StatusMessage#</td>
					
					<!--- AFFILIATE COMMISSION LEVEL --->
					<td align="center" width="8%" align="center">1</td>
					
					<!--- GET ORDER TOTAL --->				
					<cfscript>
						getOrderTotal = application.Queries.getOrderTotal(OrderID=getOrdersAF.OrderID);
					</cfscript>
					
					
					<cfquery name="getCommLevel1" dbtype="query" maxrows="1">
						SELECT 	L1
						FROM	getAffiliateHistory
						WHERE	DateEntered <= '#OrderDate#'
					</cfquery>
					
					<!--- <cfif getCommLevel1.RecordCount EQ 0 >
						<cfset L1 = 0 >
					<cfelse>
						<cfset L1 = getCommLevel1.L1 >
					</cfif> --->
							
					<cfscript>
						if( getCommLevel1.RecordCount EQ 0)	{
							L1 = 0;
						}
						else	{
							L1 = getCommLevel1.L1;
						}
						
						RunningTotal = 0 ;
						if ( getOrderTotal.RunningTotal EQ '' )
							getOrderTotal.RunningTotal = 0 ;					
						// UPDATE VARIABLES
						RunningTotal = getOrderTotal.RunningTotal - DiscountTotal - CreditApplied ;
						SubTotal = SubTotal + RunningTotal ;
						// ONLY CALCULATE ORDER COMMISSION TOTAL IF ORDER HAS OR WILL BE PAID
						if ( getOrdersAF.BillingStatus EQ 'BI' OR getOrdersAF.BillingStatus EQ 'PA' OR getOrdersAF.BillingStatus EQ 'PP'
						  OR getOrdersAF.BillingStatus EQ 'BC' OR getOrdersAF.BillingStatus EQ 'PC' OR getOrdersAF.BillingStatus EQ 'PK'
						  OR getOrdersAF.BillingStatus EQ 'PK' )
							CommissionTotal = NumberFormat((L1 / 100) * RunningTotal,9.99) ;
						else
							CommissionTotal = 0.00 ;
						AffiliateCommission = AffiliateCommission + CommissionTotal ;
						AFOrders = AFOrders + 1 ;
					</cfscript>
					<!--- ORDER TOTAL --->
					<td width="18%" align="right">#LSCurrencyFormat(RunningTotal, "local")#</td>
					
					<!--- COMMISSION LEVEL PERCENTAGE --->
					<td width="16%" align="right">#DecimalFormat(L1)#%</td>
					
					<!--- COMMISSION TOTAL --->
					<td width="16%" align="right">
						$#CommissionTotal#
					</td>
				</tr>
			<!--- </cfform> --->
		</cfloop><!--- </cfoutput> --->
		
		<!--- LEVEL 2 AFFILIATE ORDERS --->
		<cfquery name="getAffiliatesL2" datasource="#application.dsn#">
			SELECT	AFID
			FROM	Affiliates
			WHERE	SubAffiliateOf = #session.AffiliateArray[1]#
		</cfquery>
		<cfif getAffiliatesL2.RecordCount>
			
			<cfloop query="getAffiliatesL2"><!--- <cfoutput query="getAffiliatesL2"> --->
				
				<cfscript>
					getOrdersAF = application.Queries.getOrdersAF(AffiliateID=getAffiliatesL2.AFID);
				</cfscript>
				
				<cfloop query="getOrdersAF">
					<cfform action="AffiliateDetail.cfm" method="post">
						<tr>
							<td width="12%">#OrderID#</td>
							<td width="15%">#DateFormat(OrderDate,"dd-mmm-yyyy")#</td>
							<cfscript>
								getBillingStatus = application.Queries.getBillingStatusCode(StatusCode=getOrdersAF.BillingStatus);
							</cfscript>
							
							<td width="15%">#getBillingStatus.StatusMessage#</td>
							
							<!--- AFFILIATE COMMISSION LEVEL --->
							<td width="8%" align="center">2</td>
							
							<!--- GET ORDER TOTAL --->		
							<cfscript>
								getOrderTotal = application.Queries.getOrderTotal(OrderID=getOrdersAF.OrderID);
							</cfscript>
							
							<cfquery name="getCommLevel2" dbtype="query" maxrows="1">
								SELECT 	L2
								FROM	getAffiliateHistory
								WHERE	DateEntered <= '#OrderDate#'
							</cfquery>
							
							<!--- <cfif not getCommLevel2.RecordCount>
								<cfset L2 = 0 >
							<cfelse>
								<cfset L2 = getCommLevel2.L2 >
							</cfif> --->
							
							<cfscript>
								if( not getCommLevel2.RecordCount)	{
									L2 = 0;
								}
								else	{
									L2 = getCommLevel2.L2;
								}
								
								RunningTotal = 0 ;
								if ( getOrderTotal.RunningTotal EQ '' )
									getOrderTotal.RunningTotal = 0 ;					
								// UPDATE VARIABLES															
								RunningTotal = getOrderTotal.RunningTotal - DiscountTotal - CreditApplied ;
								SubTotal = SubTotal + RunningTotal ;
								// ONLY CALCULATE ORDER COMMISSION TOTAL IF ORDER HAS OR WILL BE PAID
								if ( getOrdersAF.BillingStatus EQ 'BI' OR getOrdersAF.BillingStatus EQ 'PA' OR getOrdersAF.BillingStatus EQ 'PP'
								  OR getOrdersAF.BillingStatus EQ 'BC' OR getOrdersAF.BillingStatus EQ 'PC' OR getOrdersAF.BillingStatus EQ 'PK'
								  OR getOrdersAF.BillingStatus EQ 'PK' )
									CommissionTotal = NumberFormat((L2 / 100) * RunningTotal,9.99) ;
								else
									CommissionTotal = 0.00 ;
								AffiliateCommission = AffiliateCommission + CommissionTotal ;
								AFOrders = AFOrders + 1 ;
							</cfscript>
							<!--- ORDER TOTAL --->
							<td width="18%" align="right">#LSCurrencyFormat(RunningTotal, "local")#</td>
							
							<!--- COMMISSION LEVEL PERCENTAGE --->
							<td width="16%" align="right">#DecimalFormat(L2)#%</td>
							
							<!--- COMMISSION TOTAL --->
							<td width="16%" align="right">
								$#CommissionTotal#
							</td>
						</tr>
					</cfform>
				</cfloop>
				
				<!--- LEVEL 3 AFFILIATE ORDERS --->
				<cfquery name="getAffiliatesL3" datasource="#application.dsn#">
					SELECT	AFID
					FROM	Affiliates
					WHERE	SubAffiliateOf = #AFID#
				</cfquery>
				<cfif getAffiliatesL3.RecordCount>
					<cfloop query="getAffiliatesL3">
						<cfscript>
							getOrdersAF = application.Queries.getOrdersAF(AffiliateID=getAffiliatesL3.AFID);
						</cfscript>
						
						<cfloop query="getOrdersAF">
							<cfform action="AffiliateDetail.cfm" method="post">
								<tr>
									<td width="12%">#OrderID#</td>
									<td width="15%">#DateFormat(OrderDate,"dd-mmm-yyyy")#</td>
									<cfscript>
										getBillingStatus = application.Queries.getBillingStatusCode(StatusCode=getOrdersAF.BillingStatus);
									</cfscript>
									
									<td width="15%">#getBillingStatus.StatusMessage#</td>
									
									<!--- AFFILIATE COMMISSION LEVEL --->
									<td width="8%" align="center">3</td>
									
									<!--- GET ORDER TOTAL --->		
									<cfscript>
										getOrderTotal = application.Queries.getOrderTotal(OrderID=getOrdersAF.OrderID);
									</cfscript>
									
									
									<cfquery name="getCommLevel3" dbtype="query" maxrows="1">
										SELECT 	L3
										FROM	getAffiliateHistory
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
										// UPDATE VARIABLES
										RunningTotal = getOrderTotal.RunningTotal - DiscountTotal - CreditApplied ;
										SubTotal = SubTotal + RunningTotal ;
										// ONLY CALCULATE ORDER COMMISSION TOTAL IF ORDER HAS OR WILL BE PAID
										if ( getOrdersAF.BillingStatus EQ 'BI' OR getOrdersAF.BillingStatus EQ 'PA' OR getOrdersAF.BillingStatus EQ 'PP'
										  OR getOrdersAF.BillingStatus EQ 'BC' OR getOrdersAF.BillingStatus EQ 'PC' OR getOrdersAF.BillingStatus EQ 'PK'
										  OR getOrdersAF.BillingStatus EQ 'PK' )
											CommissionTotal = NumberFormat((L3 / 100) * RunningTotal,9.99) ;
										else
											CommissionTotal = 0.00 ;
										AffiliateCommission = AffiliateCommission + CommissionTotal ;
										AFOrders = AFOrders + 1 ;
									</cfscript>
									<!--- ORDER TOTAL --->
									<td width="18%" align="right">#LSCurrencyFormat(RunningTotal, "local")#</td>
									
									<!--- COMMISSION LEVEL PERCENTAGE --->
									<td width="16%" align="right">#DecimalFormat(L3)#%</td>
									
									<!--- COMMISSION TOTAL --->
									<td width="16%" align="right">
										$#CommissionTotal#
									</td>
								</tr>
							</cfform>
						</cfloop>
					</cfloop>
				</cfif>
			</cfloop><!--- </cfoutput> --->
		</cfif>	
		
		<cfif not getOrdersAF.RecordCount and not getAffiliatesL2.RecordCount and ( not isDefined('getAffiliatesL3') or not getAffiliatesL3.RecordCount ) >
			<tr height="40">
				<td width="100%" class="cfMessageTwo" align="center" colspan="7">You do not have any affiliated orders at this time.</td>
			</tr>
		<cfelse>
			<!--- TOTALS --->
			<!--- <cfoutput> --->
			<tr class="cart_footer">
				<td align="right" colspan="5">Order Totals</td>
				<td align="right" colspan="2">Commission Totals</td>
			</tr>
			<tr class="cart_tally">
				<td align="right" colspan="4"><b>Totals: ALL</b></td>
				<td align="right"><b>#LSCurrencyFormat(SubTotal, "local")#</b></td>
				<td align="right" colspan="2"><b>#LSCurrencyFormat(AffiliateCommission, "local")#</b></td>
			</tr>
			<cfscript>
				AFUnpaidTotal = AffiliateCommission - AFPaidTotal ;
			</cfscript>
			<tr class="cart_tally">
				<td align="right" colspan="4"><font class="cfAttract"><b>Totals: UNPAID</b></font></td>
				<td align="right"></td>
				<td align="right" colspan="2"><font class="cfAttract"><b>#LSCurrencyFormat(AFUnpaidTotal, "local")#</b></font></td>
			</tr>
			<!--- </cfoutput> --->
		</cfif>
	</table>
</span>
<br/>


<!---------------------------------------------------- MULTI-TIERED AFFILIATE PROGRAM -------------------------------------->
<div class="myaccount" align="left" onclick="SwitchMenu('sub3')">
	<img src="images/icon-down.gif" align="absmiddle" /> &nbsp;My Affiliates
</div>
<span class="submenu3" id="sub3" style="padding: 10px 0px 0px 0px;">
	<cfquery name="getAffiliatesL2" datasource="#application.dsn#">
		SELECT	*
		FROM	Affiliates
		WHERE	SubAffiliateOf = #session.AffiliateArray[1]#
	</cfquery>
	
	<cfif not getAffiliatesL2.RecordCount>
		<div class="cfMessageTwo" align="center">No affiliates have yet to sign up under you.</div>
	<cfelse>
		<table class="cartLayoutTable">
			<tr>
				<th align="center" width="12%">Affiliate&nbsp;ID</th>
				<th align="center" width="15%">Signup&nbsp;Date</th>
				<th align="center" width="45%">Name</th>
				<th align="center" width="8%" >Level</th>
				<th align="center" width="15%">Revenue&nbsp;Generated</th>
			</tr>
			<cfset TotalRevenueGenerated = 0 >
		<!--- LEVEL 2 AFFILIATES --->
		<cfloop query="getAffiliatesL2"><!--- <cfoutput query="getAffiliatesL2"> --->
			<tr class="row#CurrentRow mod 2#">
				<td width="12%">#AFID#</td>
				<td width="15%">#DateFormat(DateCreated, 'dd-mmm-yyyy')#</td>
				<td width="45%">#LastName#, #FirstName#</td>
				<!--- LEVEL --->
				<td width="8%" align="center">2</td>
				<td width="15%" align="right">
					
					<cfscript>
						RunningTotal = 0 ;
						RevenueGenerated = 0 ;
						AFAffiliates = AFAffiliates + 1 ;
						// Get Affiliate Orders
						getOrdersAF = application.Queries.getOrdersAF(AffiliateID=AFID);
					</cfscript>
					
					<cfloop query="getOrdersAF">
						<!--- GET ORDER TOTAL --->		
						<cfscript>
							getOrderTotal = application.Queries.getOrderTotal(OrderID=getOrdersAF.OrderID);
							// Set variables
							if ( getOrderTotal.RunningTotal EQ '' )
								getOrderTotal.RunningTotal = 0 ;
							RunningTotal = getOrderTotal.RunningTotal - DiscountTotal - CreditApplied ;
							RevenueGenerated = RevenueGenerated + RunningTotal ;
						</cfscript>
						
					</cfloop>
					<cfset TotalRevenueGenerated = TotalRevenueGenerated + RevenueGenerated >
					#LSCurrencyFormat(RevenueGenerated, "local")#
				</td>						
			</tr>

			<!--- LEVEL 3 AFFILIATES --->
			<cfquery name="getAffiliatesL3" datasource="#application.dsn#">
				SELECT	*
				FROM	Affiliates
				WHERE	SubAffiliateOf = #AFID#
			</cfquery>
			<cfif getAffiliatesL3.RecordCount>
				<cfloop query="getAffiliatesL3">
					<tr class="row#CurrentRow mod 2#">
						<td width="12%">&nbsp;&nbsp;<em>#AFID#</em></td>
						<td width="15%">&nbsp;&nbsp;<em>#DateFormat(DateCreated, 'dd-mmm-yyyy')#</em></td>
						<td width="45%">&nbsp;&nbsp;<em>#LastName#, #FirstName#</em></td>
						<!--- LEVEL --->
						<td align="center" width="8%" align="center">3</td>
						<td width="15%" align="right">
							<cfscript>
								RunningTotal = 0 ;
								RevenueGenerated = 0 ;
								AFAffiliates = AFAffiliates + 1 ;
							</cfscript>
							
							<cfscript>
								getOrdersAF = application.Queries.getOrdersAF(AffiliateID=AFID);
							</cfscript>
							
							<!--- <cfinvoke component="#application.Queries#" method="getOrdersAF" returnvariable="getOrdersAF">
								<cfinvokeargument name="AffiliateID" value="#AFID#">
							</cfinvoke> --->
							
							<cfloop query="getOrdersAF">
								<!--- GET ORDER TOTAL --->
								<cfscript>
									getOrderTotal = application.Queries.getOrderTotal(OrderID=getOrdersAF.OrderID);
								</cfscript>
								
								<!--- <cfinvoke component="#application.Queries#" method="getOrderTotal" returnvariable="getOrderTotal">
									<cfinvokeargument name="OrderID" value="#getOrdersAF.OrderID#">
								</cfinvoke> --->
								
								<cfscript>
									if ( getOrderTotal.RunningTotal EQ '' )
										getOrderTotal.RunningTotal = 0 ;
									RunningTotal = getOrderTotal.RunningTotal - DiscountTotal - CreditApplied ;
									RevenueGenerated = RevenueGenerated + RunningTotal ;
								</cfscript>
							</cfloop>
							<cfset TotalRevenueGenerated = TotalRevenueGenerated + RevenueGenerated >
							#LSCurrencyFormat(RevenueGenerated, "local")#
						</td>
					</tr>
				</cfloop>
			</cfif>
		</cfloop><!--- </cfoutput> --->
		<!--- <cfoutput> --->	
			<tr class="cart_footer">
				<td colspan="4" align="right"><b>Totals:</b></td>
				<td align="right"><b>#LSCurrencyFormat(TotalRevenueGenerated, "local")#</b></td>
			</tr>
		<!--- </cfoutput> --->
		</table>
	</cfif>
</span>
<br/>


<!---------------------------------------------------- AFFILIATE INFORMATION -------------------------------------------------->
<div class="myaccount" align="left" onclick="SwitchMenu('sub4')">
	<img src="images/icon-down.gif" align="absmiddle" /> &nbsp;My Profile
</div>
<span class="submenu4" id="sub4" style="padding: 10px 0px 0px 0px;">
	<cfloop query="getAffiliate"><!--- <cfoutput query="getAffiliate"> --->
	<table width="98%" border="0" align="center" cellpadding="3" cellspacing="0">
		<tr>
			<td width="100%" align="right" class="cfMessage" style="padding-right:10px;">
				<strong>Affiliate ID: #AFID# &nbsp; Affiliate Since: #DateFormat(DateCreated,"dd-mmm-yyyy")#</strong>
			</td>
		</tr>
		<tr>
			<td style="PADDING: 10px">
				<table border="0" cellpadding="2" cellspacing="0" align="center" width="100%">
					<tr>
						<td width="50%" colspan="2"><b>Affiliate Information</b></td>
						<td width="50%" colspan="2"></td>
					</tr>
					<tr>
						<td colspan="4" height="5"></td>
					</tr>
					<tr>
						<td>First Name:</td>
						<td>#FirstName#</td>
						<td>Website Name:</td>
						<td>#WebsiteName#</td>
					</tr>
					<tr>
						<td>Last Name:</td>
						<td>#LastName#</td>
						<td>Website URL:</td>
						<td>#WebsiteURL#</td>
					</tr>
					<tr>
						<td>Company Name:</td>
						<td>#CompanyName#</td>
						<td>Website Category:</td>
						<td>#WebsiteCategory#</td>
					</tr>
					<tr>
						<td>Address 1:</td>
						<td>#Address1#</td>
						<td></td>
						<td></td>
					</tr>
					<cfquery name="getCommLevels" dbtype="query" maxrows="1">
						SELECT 	L1, L2, L3
						FROM	getAffiliateHistory
						WHERE	DateEntered <= '#DateFormat(Now(),'mm/dd/yyyy')# #TimeFormat(Now(),'hh:mm:ss tt')#'
					</cfquery>				
					<cfif not getCommLevels.RecordCount>
						<cfset L1 = 0 >
						<cfset L2 = 0 >
						<cfset L3 = 0 >
					<cfelse>
						<cfset L1 = getCommLevels.L1 >
						<cfset L2 = getCommLevels.L2 >
						<cfset L3 = getCommLevels.L3 >
					</cfif>
					<tr>
						<td>Address 2:</td>
						<td>#Address2#</td>
						<td>Commission % Level 1:</td>
						<td>#DecimalFormat(L1)#%</td>
					</tr>
					<tr>	
						<td>City:</td>
						<td>#City#</td>
						<td>Commission % Level 2:</td>
						<td>#DecimalFormat(L2)#%</td>
					</tr>
					<tr>	
						<td>State:</td>
						<td>#State#</td>
						<td>Commission % Level 3:</td>
						<td>#DecimalFormat(L3)#%</td>
					</tr>
					<tr>	
						<td>ZIP/Postal Code:</td>
						<td>#Zip#</td>
						<td>Customer Discount Rate:</td>
						<td>#DecimalFormat(CustomerDiscount)#%</td>
					</tr>
					<tr>	
						<td>Country:</td>
						<td>#Country#</td>
						<td></td>
						<td></td>
					</tr>	
					<tr>
						<td>Phone:</td>
						<td>#Phone#</td>
						<td>Affiliates Signed Up:</td>
						<td>#AFAffiliates#</td>
					</tr>
					<tr>
						<td>Fax:</td>
						<td>#Fax#</td>
						<td>Affiliated Orders:</td>
						<td>#AFOrders#</td>
					</tr>
					<tr>
						<td>Email:</td>
						<td>#Email#</td>
						<td>Commissions Paid:</td>
						<td>#LSCurrencyFormat(AFPaidTotal)#</td>
					</tr>
					<tr>
						<td>Notify Me?:</td>
						<td><cfif EmailOK EQ 1>Yes<cfelse>No</cfif></td>
						<td>Commissions Total:</td>
						<td>#LSCurrencyFormat(AffiliateCommission)#</td>
					</tr>
				</table>
			</td>
		</tr>			
		
		<tr>
			<td colspan="4" height="5"></td>
		</tr>
		
		<tr>	
			<td align="center" colspan="4" style="PADDING: 10px">
				<input type="button" name="Update" value="UPDATE &gt;" class="button" onclick="javascript:document.location.href='AF-Update.cfm'" />
			</td>
		</tr>
	</table>
	</cfloop><!--- </cfoutput> --->
</span>
<br/>


<!---------------------------------------------------- AFFILIATE MESSAGES -------------------------------------------------->
<div class="myaccount" align="left" onclick="SwitchMenu('sub5')">
	<img src="images/icon-down.gif" align="absmiddle" /> &nbsp;My Messages
</div>
<span class="submenu5" id="sub5" style="padding: 10px 0px 0px 0px;">
	<div align="center">You have no new messages.</div>
</span>
</div>

<div align="center">
	<br/>
	<hr class="snip" />
	<br/>
	<input type="button" name="GoBack" value="&lt; LOGOUT" class="button2" onclick="javascript:document.location.href='AF-Logout.cfm';">
	<input type="button" name="GoHome" value="CONTINUE SHOPPING &gt;" class="button" onclick="javascript:document.location.href='index.cfm';">
</div>

</cfmodule>
</cfoutput>