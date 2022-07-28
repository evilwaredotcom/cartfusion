<cfmodule template="tags/layout.cfm" CurrentTab="AboutUs" PageTitle="Clean Cart">

<!--- Start Breadcrumb --->
<cfmodule template="tags/breadCrumbs.cfm" CrumbLevel='1' showLinkCrumb="Clean Cart" />
<!--- End BreadCrumb --->

<h3>Shopping Cart</h3>

	<br />
	<br />
	<div class="cfErrorMsg" align="center">
		There are no items in your cart.
	</div>
	
	<br />
	<br />
	<hr class="snip" />
	<br />
	<div align="center">
		<a href="index.cfm"><img src="images/button-home.gif"></a>
	</div>


</cfmodule>

