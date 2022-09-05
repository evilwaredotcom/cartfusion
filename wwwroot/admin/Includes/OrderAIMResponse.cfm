<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<cfoutput>
<br><br>
<!--- Example Response page start --->
<table width="400" border="1" align="center" cellpadding="7" cellspacing="0" bordercolor="#cfAdminHeaderColor#">
	<cfif ResponseCode NEQ 0 >
		<tr>
			<td height="18" align="right" class="cfAdminDefault" width="50%"><b style="font-size:14px;">Authorization:</b></td>
			<td class="cfAdminDefault" width="50%">
				<b style="font-size:14px;color:990000;">
				<cfif ResponseCode EQ 1>APPROVED
				<cfelse>DECLINED
				</cfif>
				</b>
			</td>
		</tr>
	</cfif>
	<cfif ResponseCode GT 1>
		<tr>
			<td height="18" colspan="2" class="cfAdminDefault" align="center">
				Unfortunately we were unable to get a verification on your credit card.<br>
				<cfif isDefined('ResponseReasonText')>Reason: <strong>#ResponseReasonText#</strong></cfif>
			</td>
		</tr>
		<tr>
			<td colspan="2" height="18" align="center">
				<input type="button" name="ReturnToOrder" value="RETURN TO ORDER" alt="Return to Order Detail" class="cfAdminButton"
					onClick="document.location.href='OrderDetail.cfm?OrderID=#OrderID#'">
				<input type="button" name="ReturnHome" value="RETURN HOME" alt="Return Home" class="cfAdminButton"
					onClick="document.location.href='Orders.cfm'">
			</td>
		</tr>
	<cfelse><!--- ResponseCode EQ 0 or 1 ---> 
		<cfif ResponseCode EQ 1>
		<tr>
			<td height="18" align="right" class="cfAdminDefault"><strong>Approval Code:</strong></td>
			<td>&nbsp;#ApprovalCode#</td>
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
				<cfswitch expression = "#AVSResultCode#">
					<cfcase value = "A">Success</cfcase>
					<cfcase value = "B">Non-valid Address</cfcase>  
					<cfcase value = "E">Gateway Error</cfcase>  
					<cfcase value = "G">Non-U.S. Card Issuing Bank</cfcase>  
					<cfcase value = "N">Fail</cfcase>  
					<cfcase value = "P">Success</cfcase>  
					<cfcase value = "R">Gateway Error</cfcase>  
					<cfcase value = "S">Success</cfcase>  
					<cfcase value = "U">Fail</cfcase>  
					<cfcase value = "W">Success</cfcase>  
					<cfcase value = "X">Success</cfcase>
					<cfcase value = "Y">Success</cfcase>  
					<cfcase value = "Z">Success</cfcase>  
					<cfdefaultcase>not determined</cfdefaultcase>
				</cfswitch>
			</td>
		</tr>
		<tr>
			<td height="18" align="right" nowrap class="cfAdminDefault"><strong>Card Code Result:</strong></td>
			<td class="cfAdminDefault" align="left">&nbsp;#CardCodeResponse#</td>
		</tr>
		<tr>
			<td height="18" align="right" nowrap class="cfAdminDefault"><strong>Hash Match:</strong></td>
			<td class="cfDefault" align="left">&nbsp;<cfif isDefined('md5original') AND MD5HashCode EQ md5original>Yes<cfelse>No</cfif></td>
		</tr>
		<tr>
			<td height="18" align="right" nowrap class="cfAdminDefault"><strong>Transaction ID:</strong></td>
			<td class="cfAdminDefault" align="left">&nbsp;#TransactionID#</td>
		</tr>
		</cfif>
		<tr>
			<td height="18" align="right" nowrap class="cfAdminDefault" width="50%"><strong>Invoice/Order ID:</strong></td>
			<td class="cfAdminDefault" align="left" width="50%">&nbsp;#OrderID#</td>
		</tr>
		<tr>
			<td height="18" align="right" nowrap class="cfAdminDefault"><strong>Customer ID:</strong></td>
			<td class="cfAdminDefault" align="left">&nbsp;#CustomerID#</td>
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
					<input type="button" name="ReturnToOrder" value="RETURN TO ORDER" alt="Return to Order Detail" class="cfAdminButton"
						onClick="document.location.href='OrderDetail.cfm?OrderID=#OrderID#'">
					<input type="button" name="ReturnHome" value="RETURN HOME" alt="Return Home" class="cfAdminButton"
						onClick="document.location.href='Orders.cfm'">
				</td>
			</tr>
		</cfif>
	</cfif>
</table>				
<!--- Example Response End --->
</cfoutput>