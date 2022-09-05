<!--- 
|| MIT LICENSE
|| CartFusion.com
--->


<cfmodule template="templates/#application.SiteTemplate#/layout.cfm" CurrentTab="MyAccount" LayoutStyle="Full" PageTitle="Check Out - Step 5 of 5" showCategories="false">

<!--- Start Breadcrumb --->
<cfmodule template="tags/breadCrumbs.cfm" CrumbLevel='2' showLinkCrumb="Cart|Check Out - Step 5 of 5" />
<!--- End BreadCrumb --->

<table width="100%" cellpadding="3" cellspacing="0" border="0" align="center">
	<tr> 
		<td width="100%" align="center" valign="top">
			<br>
			<p><h3>CANCELLED PAYPAL PAYMENT<cfif isDefined('URL.OrderID')><br>Order #<cfoutput>#URL.OrderID#</cfoutput></cfif></h3></p>
			<div align="center" class="cfErrorMsg">
				<b>You have requested to cancel payment for your order via PayPal.<br>
				We will keep your order on record if you'd like to submit payment via check or money order.<br><br>
				You may send payment to the following address.<br>
				Please be sure to include your order number and date of purchase.</b>
			</div>
			
			<table width="100%" cellpadding="10" cellspacing="0" align="center">
				<tr>
					<td width="50%" align="right" valign="middle">
						<img src="images/image-CompanyLogo.gif" border="0">&nbsp;&nbsp;
					</td>
					<td width="50%" align="left" class="cfDefault">
						<cfoutput>
						<b>
						#application.CompanyName#<br>
						#application.CompanyAddress1#<br>
						<cfif application.CompanyAddress2 neq ''>
						#application.CompanyAddress2#<br>
						</cfif>
						#application.CompanyCity#, #application.CompanyState#, #application.CompanyZip#<br>
						#application.CompanyCountry#<br>
						#application.CompanyPhone#
						</b>
						</cfoutput>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

</cfmodule>
