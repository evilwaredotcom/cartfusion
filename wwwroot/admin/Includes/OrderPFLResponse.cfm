<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<cfoutput>
<br><br>
<!--- Example Response page start --->
<table width="400" border="1" align="center" cellpadding="7" cellspacing="0" bordercolor="#cfAdminHeaderColor#">
	<cfif ResponseCode NEQ 0>	
		<tr>
			<td height="18" align="right" class="cfAdminDefault" width="50%"><b style="font-size:14px;">Authorization:</b></td>
			<td class="cfAdminDefault" width="50%">
				<b style="font-size:14px;color:990000;">
				<cfif ResponseCode EQ 1>SUCCESS
				<cfelse>FAIL
				</cfif>
				</b>
			</td>
		</tr>
	</cfif>
	<cfif ResponseCode GT 1>
		<tr>
			<td height="18" colspan="2" class="cfAdminDefault" align="center">
				Unfortunately we were unable to get a verification on your credit card.<br>
				Reason: <!---<strong>#ResponseReasonText#</strong>--->
			</td>
		</tr>
		<tr>
			<td colspan="2" height="18" align="center">
				<a href="OrderDetail.cfm?OrderID=#OrderID#"><img src="images/button-ReturnToOrder.gif" border="0"></a>
				<img src="images/spacer.gif" width="5" height="1" border="0">
				<a href="Orders.cfm" class="cfAdminDefault"><img src="images/button-ReturnHome.gif" border="0"></a>
			</td>
		</tr>
	<cfelse><!--- ResponseCode EQ 0 or 1 --->
		<cfif isDefined('FORM.TYPE')>
		<tr>
			<td height="18" align="right" nowrap class="cfAdminDefault"><strong>Method:</strong></td>
			<td class="cfAdminDefault" align="left">
				<cfswitch expression = "#FORM.TYPE#">
					<cfcase value = "S">Sale/Purchase</cfcase>
					<cfcase value = "A">Authorization Only</cfcase>  
				</cfswitch>
			</td>
		</tr>
		</cfif> 
		<cfif ResponseCode EQ 1>
		<tr>
			<td height="18" align="right" class="cfAdminDefault"><strong>Approval Code:</strong></td>
			<td>#RESPMSG#</td>
		</tr>
		<tr>
			<td height="18" align="right" nowrap class="cfAdminDefault"><strong>Address Verification:</strong></td>
			<td class="cfAdminDefault" align="left">
			<!--- 
				A   =   Address (Street) matches, ZIP does not
				B   =   Address information not provided for AVS check
				E   =   AVS error
				G   =   Non-U.S. Card Issuing Bank
				N   =   No Match on Address (Street) or ZIP
				P   =   AVS not applicable for this transaction
				R   =   Retry � System unavailable or timed out
				S   =   Service not supported by issuer
				U   =   Address information is unavailable
				W   =   9 digit ZIP matches, Address (Street) does not
				X   =   Address (Street) and 9 digit ZIP match
				Y   =   Address (Street) and 5 digit ZIP match
				Z   =   5 digit ZIP matches, Address (Street) does not 
			--->
				<cfswitch expression = "#FORM.AVSDATA#">
					<cfcase value = "YYY">Success</cfcase>
					<cfcase value = "YYN">Not Valid</cfcase>  
					<cfcase value = "YNN">Not Valid</cfcase>  
					<cfcase value = "YNY">Not Valid</cfcase>  
					<cfcase value = "NYY">Not Valid</cfcase>  
					<cfcase value = "NYN">Not Valid</cfcase>  
					<cfcase value = "NNY">Not Valid</cfcase>  
					<cfcase value = "NNN">Fail</cfcase>  
					<cfdefaultcase>Not Determined</cfdefaultcase>
				</cfswitch>
			</td>
		</tr>
		<cfif isDefined('FORM.CSCMATCH')>
		<tr>
			<td height="18" align="right" nowrap class="cfAdminDefault"><strong>Card Code Result:</strong></td>
			<td class="cfAdminDefault" align="left">
				<cfswitch expression = "#FORM.CSCMATCH#">
					<cfcase value = "Y">Match</cfcase>
					<cfcase value = "N">No Match</cfcase>  
					<cfcase value = "X">Not Determined</cfcase>  
					<cfdefaultcase>Not Determined</cfdefaultcase>
				</cfswitch>
			</td>
		</tr>
		</cfif>
		<tr>
			<td height="18" align="right" nowrap class="cfAdminDefault"><strong>Authorization Code:</strong></td>
			<td class="cfDefault" align="left">#FORM.AUTHCODE#</td>
		</tr>
		<tr>
			<td height="18" align="right" nowrap class="cfAdminDefault"><strong>Transaction ID:</strong></td>
			<td class="cfAdminDefault" align="left">#TransactionID#</td>
		</tr>
		</cfif>
		<tr>
			<td height="18" align="right" nowrap class="cfAdminDefault" width="50%"><strong>Invoice/Order ID:</strong></td>
			<td class="cfAdminDefault" align="left" width="50%">#OrderID#</td>
		</tr>
		<tr>
			<td height="18" align="right" nowrap class="cfAdminDefault"><strong>Customer ID:</strong></td>
			<td class="cfAdminDefault" align="left">#CustomerID#</td>
		</tr>
		<cfif IsDefined("AFID")>
			<!--- Make the query to find the Affiliate ID number  --->
			<cfquery name="affiliate" datasource="#application.dsn#">
				SELECT 	*
				FROM 	affiliates
				WHERE 	affiliates.ID = #AFID#
			</cfquery>
			
			<cfset mailto = affiliate.Email>
			<cfset subject = "Affiliate Order Completed">
			<!---<cfinclude template="EmailOrder.cfm">--->
			<tr>
				<td colspan="2" class="cfAdminDefault" align="center">
					[<a href="#affiliate.WebSiteURL#"> Back to the #affiliate.WebSiteName# Page </a>]
				</td>
			</tr>
		<cfelse>
			<tr>
				<td colspan="2" height="18" align="center">
					<a href="OrderDetail.cfm?OrderID=#OrderID#"><img src="images/button-ReturnToOrder.gif" border="0"></a>
					<img src="images/spacer.gif" width="5" height="1" border="0">
					<a href="Orders.cfm" class="cfAdminDefault"><img src="images/button-ReturnHome.gif" border="0"></a>
				</td>
			</tr>
		</cfif>
	</cfif>
</table>				
<!--- Example Response End --->
</cfoutput>