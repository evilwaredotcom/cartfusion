<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<cfoutput query="q_auth">
<br><br>
<!--- Example Response page start --->
<table width="400" border="1" align="center" cellpadding="7" cellspacing="0" bordercolor="#cfAdminHeaderColor#">
	<cfif ResponseCode NEQ 0 >
	<tr>
		<td height="18" align="right" class="cfAdminDefault" width="50%"><b style="font-size:14px;">Authorization:</b></td>
		<td class="cfAdminDefault" width="50%">
			<b style="font-size:14px;color:990000;">
			#UCASE(UMstatus)#
			</b>
		</td>
	</tr>
	</cfif>
	<cfif ResponseCode GT 1 >
		<tr>
			<td height="18" colspan="2" class="cfAdminDefault" align="center">
				Unfortunately we were unable to get a verification on your credit card.<br>
				Reason: <strong>#UMerror#</strong>
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
	<cfelse><!--- Response Code = 0 or 1 --->
		<tr>
			<td height="18" align="right" class="cfAdminDefault"><strong>Authorization Code:</strong></td>
			<td>&nbsp;#UMauthCode#</td>
		</tr>
		<tr>
			<td height="18" align="right" nowrap class="cfAdminDefault"><strong>Address Verification:</strong></td>
			<td class="cfAdminDefault" align="left">&nbsp;#UMavsResult#</td>
		</tr>
		<tr>
			<td height="18" align="right" nowrap class="cfAdminDefault"><strong>Card Code Result:</strong></td>
			<td class="cfAdminDefault" align="left">&nbsp;#UMcvv2Result#</td>
		</tr>
		<tr>
			<td height="18" align="right" nowrap class="cfAdminDefault"><strong>Result Code:</strong></td>
			<td class="cfDefault" align="left">&nbsp;#UMresult#</td>
		</tr>
		<tr>
			<td height="18" align="right" nowrap class="cfAdminDefault"><strong>Transaction ID:</strong></td>
			<td class="cfAdminDefault" align="left">&nbsp;#TransactionID#</td>
		</tr>
		
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