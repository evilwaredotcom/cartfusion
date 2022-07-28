<cfoutput>

<cfif FormOfPayment EQ 4 >

	<!--- BEGIN: SHOW INFORMATION THUS FAR --->
	<table width="98%" border="1" bordercolor="###layout.TableHeadingBGColor#" cellpadding="7" cellspacing="0"><tr bordercolor="###layout.PrimaryBGColor#"><td>
		<cfinclude template="CO-InfoThusFar.cfm">
	</td></tr></table><br>
	<!--- END: INFORMATION THUS FAR --->
	
	<!--- CUSTOMER CHOOSES TO PRINT AND SEND ORDER FORM --->
	<br><br>
	<div align="center" class="cfHeading">
		THANK YOU !! Your order number is #OrderID#<br><br>
		Please PRINT this order form and SEND WITH PAYMENT to our mailing address.<br><br>
		
		<a href="OrderForm.cfm?OrderID=#OrderID#" target="_blank"><img src="images/button-OrderFormPrint.gif" border="0"></a><br><br>
		<a href="index.cfm"><img src="images/button-home.gif" border="0"></a><br><br>
		<a href="mailto:#config.EmailSupport#?Subject=Help%20Printing%20Online%20Order%20Form%20#OrderID#">Need Help? Contact us here</a>
			
	</div>
	
<cfelse>
	<!--- DISPLAY SUCCESSFUL TRANSACTION INFORMATION AND CONFIRMATION NUMBER --->
	<div align="center" class="cfMessageTwo">
		
		<img src="images/design/dash.gif" width="550" height="1"><br><br>
		<font class="cfHeading">TRANSACTION SUCCESSFUL!<br />ORDER ###OrderID#</font><br><br>
		<img src="images/design/dash.gif" width="550" height="1"><br><br>
	
		Please print this page for your records.<br><br>
		<div class="cfDefault">
			Registered As: #session.CustomerArray[26]#<br>
			You can view the status of your order by logging in<br>
			at #config.DomainName# with your registered login information.			
		</div>
		 
	</div>
	<br>		
	<div align="center">
		<form action="#application.RootURL#/CA-OrderDetail.cfm" method="post" target="_blank">
			<input type="hidden" name="OrderID" value="#OrderID#">
			<input type="submit" name="Print" value="Printable Version" alt="Print Order Detail" class="cfButton" style="width:150px; height:18px; padding-bottom:3px;">
		</form>
		<form action="#application.RootURL#/index.cfm" method="post">
			<input type="submit" name="ReturnHome" value="Return Home" class="cfButton">
		</form>
	</div>
	<!--- END: DISPLAY SUCCESSFUL TRANSACTION INFORMATION AND CONFIRMATION NUMBER --->
	
	<!--- BEGIN: SHOW INFORMATION THUS FAR --->
	<table width="98%" border="1" bordercolor="###layout.TableHeadingBGColor#" cellpadding="7" cellspacing="0"><tr bordercolor="###layout.PrimaryBGColor#"><td>
		<cfinclude template="CO-InfoThusFar.cfm">
	</td></tr></table><br>
	<!--- END: INFORMATION THUS FAR --->

	<!--- SHOW SHOPPING CART --->
	<table width="98%" border="0" align="center">
		<tr><td align="center"><cfinclude template="CartView.cfm"></td></tr>
	</table>
	
	<!--- LOGOUT AFTER ORDER PLACED 
	<cfif session.CustomerArray[28] EQ 2>
		<cfset UseWholesalePrice = 1>
	</cfif>
	<cfloop index="loopcount" from=1 to="#ArrayLen(session.CustomerArray)#">	
		<cfset session.CustomerArray[loopcount] = ''>
	</cfloop>
	--->

</cfif>

</cfoutput>