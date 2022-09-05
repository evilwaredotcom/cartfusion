<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<!--- BEGIN: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<cfif isDefined('form.DeleteAffiliate') AND IsDefined("form.AFID")>
	<cfif isUserInRole('Administrator')>
		<cfset form.Deleted = 1 >
		<cfset form.DateUpdated = #Now()# >
		<cfset form.UpdatedBy = #GetAuthUser()# >	
		<cfupdate datasource="#application.dsn#" tablename="Affiliates" 
			formfields="AFID, Deleted, DateUpdated, UpdatedBy ">
		<cfset AdminMsg = 'Affiliate <cfoutput>#form.AFID#</cfoutput> (Soft) Deleted Successfully' >
	<cfelse>			
		<script language="JavaScript">
			{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
		</script>
	</cfif>
</cfif>

<!--- END: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<!--- SET DEFAULT PARAMETERS --->
<cfparam name="URL.StartRow" default="1" type="numeric">
<cfparam name="URL.SortOption" default="AFID" type="string">
<cfparam name="URL.SortAscending" default="1" type="numeric">
<cfparam name="Form.Field" default="ALL" type="string">
<cfparam name="Form.string" default="" type="string">	
<cfset string = Trim(string)>

<!--- BEGIN: SEARCH CRITERIA -------------------------------------------------->
<cflock timeout="10">	
	<cfquery name="getAffiliates" datasource="#application.dsn#">	
		SELECT 	*
		FROM 	Affiliates
		<CFIF Field IS 'All'>
		WHERE 	LastName like '%'
		<CFELSEIF Field IS 'AllFields'>
		WHERE 	(AFID like '%#string#%'
		OR 		FirstName like '%#string#%'
		OR 		LastName like '%#string#%'
		OR 		Address1 like '%#string#%'
		OR 		City like '%#string#%'
		OR 		State like '%#string#%'
		OR 		Country like '%#string#%'
		OR 		Phone like '%#string#%'
		OR 		Fax like '%#string#%'
		OR 		Email like '%#string#%'
		OR 		CompanyName like '%#string#%')
		<CFELSE>
		WHERE 	#Field# like '%#string#%'
		</CFIF>
		AND		(Deleted = 0 OR Deleted IS NULL)
		ORDER BY
		<cfif isDefined('URL.SortOption')> #URL.SortOption# <cfelse> AFID </cfif>
		<cfif SortAscending EQ 1> ASC <cfelse> DESC </cfif>
	</cfquery>
</cflock>
<!--- END: SEARCH CRITERIA -------------------------------------------------->

<!--- NEXT N VALUES --->
<cfscript>
	RowsPerPage = 15;
	TotalRows = getAffiliates.RecordCount;
	EndRow = Min(URL.StartRow + RowsPerPage - 1, TotalRows);
 	StartRowNext = EndRow + 1;
 	StartRowBack = URL.StartRow - RowsPerPage;
</cfscript>

<!--- BEGIN: HEADER --->
<cfscript>
	PageTitle = 'AFFILIATES';
	QuickSearch = 1;
	QuickSearchPage = 'Affiliates.cfm';
	AddPage = 'AffiliateAdd.cfm';
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">
<!--- END: HEADER --->

<cfoutput>

<table border="0" cellpadding="2" cellspacing="0" width="100%">
	<tr style="background-color:##65ADF1;">
		<td width="3%"  class="cfAdminHeader1" height="20"></td><!--- EDIT --->
		<td width="1%"  class="cfAdminHeader1"></td><!--- Process --->
		<td width="10%" class="cfAdminHeader1">
			Affiliate ID
			<a href="Affiliates.cfm?SortOption=AFID&SortAscending=1&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="Affiliates.cfm?SortOption=AFID&SortAscending=0&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td width="15%" class="cfAdminHeader1">
			Name
			<a href="Affiliates.cfm?SortOption=LastName,FirstName&SortAscending=1&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="Affiliates.cfm?SortOption=LastName,FirstName&SortAscending=0&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td width="21%" class="cfAdminHeader1">
			Location
			<a href="Affiliates.cfm?SortOption=City,State&SortAscending=1&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="Affiliates.cfm?SortOption=City,State&SortAscending=0&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td width="10%" class="cfAdminHeader1">
			Created
			<a href="Affiliates.cfm?SortOption=DateCreated&SortAscending=1&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="Affiliates.cfm?SortOption=DateCreated&SortAscending=0&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td width="10%" class="cfAdminHeader1" align="center">
			Orders
		</td>
		<td width="10%" class="cfAdminHeader1" align="right">
			Totals
		</td>
		<td width="10%" class="cfAdminHeader1" align="right">
			Earned
		</td>
		<td width="10%" class="cfAdminHeader1" align="right">
			Unpaid
		</td>
	</tr>
</cfoutput>

<!--- START LOOPING Affiliates AND OUTPUTING THEIR ROWS --------------------->
<cfoutput query="getAffiliates" startrow="#StartRow#" maxrows="#RowsPerPage#">
	<cfform action="Affiliates.cfm?StartRow=#StartRow#&SortOption=#SortOption#&SortAscending=#SortAscending#&field=#field#&string=#string#" method="post">
	<tr>
		<td>
			<input type="button" name="ViewAffiliate" value="VIEW" alt="View Affiliate Information" class="cfAdminButton"
				onclick="document.location.href='AffiliateDetail.cfm?AFID=#AFID#'">
		</td>
		<td>
			<input type="submit" name="DeleteAffiliate" value="X" alt="Delete Affiliate (soft delete)" class="cfAdminButton"
				onclick="return confirm('Are you sure you want to DELETE AFFILIATE ID #AFID# ?')">
		</td>
		<td><a href="AffiliateDetail.cfm?AFID=#AFID#" class="cfAdminDefault">#AFID#</a></td>
		<td><a href="AffiliateDetail.cfm?AFID=#AFID#" class="cfAdminDefault">#LastName#</a>, #FirstName#</td>
		<td>#City#, #State#</td>
		<td>#DateFormat(DateCreated, "mm/dd/yy")#</td>		
		
		<cfscript>
			AFOrders = 0 ;
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
		<cfinvoke component="#application.Queries#" method="getOrdersAF" returnvariable="getOrdersAF">
			<cfinvokeargument name="AffiliateID" value="#AFID#">
		</cfinvoke>
		<cfloop query="getOrdersAF">
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
		</cfloop>
		
		<!--- LEVEL 2 AFFILIATE ORDERS --->
		<cfquery name="getAffiliatesL2" datasource="#application.dsn#">
			SELECT	AFID
			FROM	Affiliates
			WHERE	SubAffiliateOf = #AFID#
		</cfquery>
		<cfif getAffiliatesL2.RecordCount NEQ 0 >
			<cfloop query="getAffiliatesL2">
				<cfinvoke component="#application.Queries#" method="getOrdersAF" returnvariable="getOrdersAF">
					<cfinvokeargument name="AffiliateID" value="#getAffiliatesL2.AFID#">
				</cfinvoke>
				<cfloop query="getOrdersAF">
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
				</cfloop>
				
				<!--- LEVEL 3 AFFILIATE ORDERS --->
				<cfquery name="getAffiliatesL3" datasource="#application.dsn#">
					SELECT	AFID
					FROM	Affiliates
					WHERE	SubAffiliateOf = #AFID#
				</cfquery>
				<cfif getAffiliatesL3.RecordCount NEQ 0 >
					<cfloop query="getAffiliatesL3">
						<cfinvoke component="#application.Queries#" method="getOrdersAF" returnvariable="getOrdersAF">
							<cfinvokeargument name="AffiliateID" value="#getAffiliatesL3.AFID#">
						</cfinvoke>
						<cfloop query="getOrdersAF">
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
						</cfloop>
					</cfloop>				
				</cfif>
			</cfloop>
		</cfif>
		<td align="center">#AFOrders#</td>
		<td align="right">#LSCurrencyFormat(SubTotal, "local")#</td>
		<cfloop query="getPaymentsAF">
			<cfscript>
				AFPaidTotal = AFPaidTotal + AFPAmount ;
			</cfscript>
		</cfloop>
		<td align="right">#LSCurrencyFormat(AffiliateCommission, "local")#</td>
		<td align="right">#LSCurrencyFormat(AffiliateCommission - AFPaidTotal, "local")#</td>
	</tr>
	<input type="hidden" name="AFID" value="#AFID#">
	</cfform>
	<!--- DIVIDER --->
	<tr><td height="1" colspan="10"><img src="images/image-LineGray.gif" width="100%" height="1"></td></tr>
</cfoutput>

<!--- NAVIGATION ------------------------------------->
	<tr>
		<td colspan="5"><cfoutput>Displaying <b>#URL.StartRow#</b> to <b>#EndRow#</b> of <b>#TotalRows#</b> Affiliates</cfoutput></td>
		<td align="right" colspan="5"><cfinclude template="NextNButtons.cfm"></td>
	</tr>
<!--- NAVIGATION ------------------------------------->
</table>

<cfinclude template="LayoutAdminFooter.cfm">