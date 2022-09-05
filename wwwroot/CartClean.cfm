

<cfinclude template="includes/CartCleanPostOrder.cfm" >

<cfmodule template="templates/#application.SiteTemplate#/layout.cfm" currenttab="AboutUs" pagetitle="Clean Cart">

<!--- Start Breadcrumb --->
<cfmodule template="tags/breadCrumbs.cfm" crumblevel='1' showlinkcrumb="Clean Cart" />
<!--- End BreadCrumb --->

<h3>Shopping Cart</h3>

<br/>
<br/>
<div class="cfErrorMsg" align="center">
	There are no items in your cart.
</div>
	
<div align="center">
	<br/>
	<br/>
	<hr class="snip" />
	<br/>
	<input type="button" name="GoHome" value="CONTINUE SHOPPING &gt;" class="button2" onclick="javascript:document.location.href='index.cfm';">
</div>


</cfmodule>

