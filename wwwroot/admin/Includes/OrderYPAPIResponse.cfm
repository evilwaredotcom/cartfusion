<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<cfif isDefined('R_APPROVED') >
<cfoutput>
<br><br>
<!--- Example Response page start --->
<table width="500" border="1" align="center" cellpadding="7" cellspacing="0" bordercolor="#cfAdminHeaderColor#">
	<tr> 
		<td height="18" align="right" nowrap class="cfAdminDefault" width="50%"><b>Approved Status: </b></font></td>
		<td class="cfAdminDefault" align="left">&nbsp;<b style="font-size:14px;color:990000;">#R_APPROVED#</b></td>
	</tr>
	<tr> 
		<td height="18" align="right" nowrap class="cfAdminDefault" width="50%"><b>Transaction ID: </b></font></td>
		<td class="cfAdminDefault" align="left">&nbsp;#R_ORDERNUM#</td>
	</tr>
	<cfif R_ERROR NEQ '' >
	<tr> 
		<td height="18" align="right" nowrap class="cfAdminDefault" width="50%"><b>Order Error: </b></font></td>
		<td class="cfAdminDefault" align="left">&nbsp;<b style="color:990000;">#R_ERROR#</b></td>
	</tr>
	</cfif>
	<tr>
		<td height="18" align="right" nowrap class="cfAdminDefault" width="50%"><strong>Invoice/Order ID:</strong></td>
		<td class="cfAdminDefault" align="left">&nbsp;#OrderID#</td>
	</tr>
	<tr>
		<td height="18" align="right" nowrap class="cfAdminDefault"><strong>Customer ID:</strong></td>
		<td class="cfAdminDefault" align="left">&nbsp;#CustomerID#</td>
	</tr>
	<tr> 
		<td height="18" align="right" nowrap class="cfAdminDefault" width="50%"><b>Order Code: </b></font></td>
		<td class="cfAdminDefault" align="left">&nbsp;#R_CODE#</td>
	</tr>
	<tr> 
		<td height="18" align="right" nowrap class="cfAdminDefault" width="50%"><b>Time: </b></font></td>
		<td class="cfAdminDefault" align="left">&nbsp;#R_TIME#</td>
	</tr>
	<tr> 
		<td height="18" align="right" nowrap class="cfAdminDefault" width="50%"><b>Reference Number: </b></font></td>
		<td class="cfAdminDefault" align="left">&nbsp;#R_REF#</td>
	</tr>
	<tr> 
		<td height="18" align="right" nowrap class="cfAdminDefault" width="50%"><b>AVS: </b></font></td>
		<td class="cfAdminDefault" align="left">&nbsp;#R_AVS#</td>
	</tr>
	<tr> 
		<td height="18" align="right" nowrap class="cfAdminDefault" width="50%"><b>VParse Response</b> <i>reserved</i>: </font></td>
		<td class="cfAdminDefault" align="left">&nbsp;#R_vpasresponse#</td>
	</tr>
	<tr> 
		<td height="18" align="right" nowrap class="cfAdminDefault" width="50%"><b>CSP: </b></font></td>
		<td class="cfAdminDefault" align="left">&nbsp;#R_CSP#</td>
	</tr>
	<tr> 
		<td height="18" align="right" nowrap class="cfAdminDefault" width="50%"><b>Auth Response: </b></font></td>
		<td class="cfAdminDefault" align="left">&nbsp;#R_AUTHRESPONSE#</td>
	</tr>
	<tr> 
		<td height="18" align="right" nowrap class="cfAdminDefault" width="50%"><b>Message: </b></font></td>
		<td class="cfAdminDefault" align="left">&nbsp;#R_MESSAGE#</td>
	</tr>
	<tr> 
		<td height="18" align="right" nowrap class="cfAdminDefault" width="50%"><b>API Version: </b></font></td>
		<td class="cfAdminDefault" align="left">&nbsp;#R_APIVERSION#</td>
	</tr>
	<!--- FRAUD SCORE NOT WORKING
	<tr> 
		<td height="18" align="right" nowrap class="cfAdminDefault" width="50%"><b>Fraud Score: </b></font></td>
		<td class="cfAdminDefault" align="left">&nbsp;#R_SCORE#</td>
	</tr>
	--->
	
	
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
</table>				
<!--- Example Response End --->
</cfoutput>
</cfif>