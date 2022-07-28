<!--- ACCEPT INTERNATIONAL CHARGES ??? --->
<cfif isDefined('Form.Country') AND Form.Country NEQ config.BaseCountry>
	<cfif config.AcceptIntOrders EQ 0>
		<div class="cfDefault" align="center">
			We are sorry...<br>At this moment we are not accepting international charges.<br>
			You may change your payment information by pressing the back button, or you may cancel your order completely. Thank you.<br><br>
			<a href="javascript:history.back()"><img src="images/button-back.gif" border="0"></a>&nbsp;&nbsp;
			<a href="CartClean.cfm"><img src="images/button-cancel.gif" border="0"></a>
		</div>
		<cfinclude template="../LayoutGlobalFooter.cfm">
		<cfabort>
	<cfelse>
		<cfset IntCharge = 1>
	</cfif>
<cfelse>
	<cfset IntCharge = 0>
</cfif>
