<!--- PUT IN SHOP FUNCTIONS
|| MIT LICENSE
|| CartFusion.com
--->

<!--- ACCEPT INTERNATIONAL CHARGES --->
<cfif structKeyExists(form, 'Country') and form.Country neq application.BaseCountry>
	<cfif application.AcceptIntOrders eq 0>
	
		<div class="cfDefault" align="center">
			We are sorry...<br>At this moment we are not accepting international charges.<br>
			You may change your payment information by pressing the back button, or you may cancel your order completely. Thank you.<br><br>
			<a href="javascript:history.back()"><img src="images/button-back.gif"></a>&nbsp;&nbsp;
			<a href="CartClean.cfm"><img src="images/button-cancel.gif"></a>
		</div>
		
	<cfelse>
		<cfset IntCharge = 1>
	</cfif>
<cfelse>
	<cfset IntCharge = 0>
</cfif>
