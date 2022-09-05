<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<cfinclude template="CartTotals.cfm">

<cfoutput>
	<font class="cfWhite">
	<img src="images/image-BoxWhite.jpg" hspace="2" align="absmiddle"> <a href="#application.RootURL#/CartEdit.cfm"><font class="cfWhite">Items In Cart:</font></a> <a href="#application.RootURL#/CartEdit.cfm"><font class="cfWhite">#numberformat(Cart.CartQty,"9999")#</font></a>
	|
	<a href="#application.RootURL#/CartEdit.cfm"><font class="cfWhite">Cart Total:</font></a> <a href="#application.RootURL#/CartEdit.cfm"><font class="cfWhite">#LSCurrencyFormat(Cart.CartTotal, "local")#</font></a>
	<!---<cfif Cart.CartQty GT 0>&nbsp;<a href="#application.RootURL#/CartEdit.cfm"><img src="images/button-checkout.gif" border="0" align="absmiddle"></a></cfif>--->
	</font>
</cfoutput>