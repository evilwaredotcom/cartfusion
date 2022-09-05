<cfscript>
	PageTitle = 'ADVANCED SEARCH' ;
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td width="20%" height="20" align="left" class="cfAdminHeader1">
			&nbsp; ORDERS
		</td>
		<td width="20%" height="20" align="left" class="cfAdminHeader1">
			PRODUCTS
		</td>
		<td width="20%" height="20" align="left" class="cfAdminHeader1">
			CUSTOMERS
		</td>
		<td width="20%" height="20" align="left" class="cfAdminHeader1">
			CATEGORIES
		</td>
		<td width="20%" height="20" align="left" class="cfAdminHeader1">
			BACK ORDERS
		</td>
	</tr>

	<tr style="background-color:##CCCCCC;"><td height="1" colspan="5"></td></tr>
	<tr><td height="1" colspan="5"></td></tr>
	<tr style="background-color:##CCCCCC;"><td height="1" colspan="5"></td></tr>
	<tr valign="top">
		<td>
		<form name="OrderForm" ACTION="Orders.cfm" METHOD="POST">
			<input type="radio" checked name="field" value="AllFields">All Fields<br>
			<input type="radio" name="field" value="OrderID">Order ID<br>
			<input type="radio" name="field" value="CustomerID">Customer ID<br>
			<input type="radio" name="field" value="DistributorID">Distributors<br>
			<input type="radio" name="field" value="DateEntered">Date ( mm/dd/yyyy )<br>
			<input type="hidden" name="start" value="1"><br>
			<input type="text" NAME="string" size="15" class="cfAdminDefault">
			<input type="submit" value="SEARCH" class="cfAdminButton">
		</form>
		</td>
		<td>
		<form name="ProductSearchForm" ACTION="Products.cfm" METHOD="POST">
			<input type="radio" checked name="field" value="AllFields">All Fields<br>
			<input type="radio" name="field" value="SKU">SKU<br>
			<input type="radio" name="field" value="ItemName">Item Name<br>
			<input type="radio" name="field" value="ItemDescription">Item Description<br>
			<input type="radio" name="field" value="Category">Category<br>
			<input type="hidden" name="start" value="1"><br>
			<input type="text" NAME="string" size="15" class="cfAdminDefault">
			<input type="submit" value="SEARCH" class="cfAdminButton">
		</form>
		</td>
		<td>
		<form name="CustomerSearchForm" ACTION="Customers.cfm" METHOD="POST">
			<input type="radio" checked name="field" value="AllFields">All Fields<br>
			<input type="radio" name="field" value="LastName">Last Name<br>
			<input type="radio" name="field" value="CompanyName">Company Name<br>
			<input type="radio" name="field" value="City">City<br>
			<input type="radio" name="field" value="DateCreated">Date ( mm/dd/yyyy )<br>
			<input type="hidden" name="start" value="1"><br>
			<input type="text" NAME="string" size="15" class="cfAdminDefault">
			<input type="submit" value="SEARCH" class="cfAdminButton">
		</form>
		</td>
		<td>
		<form name="CategorySearchForm" ACTION="Categories.cfm" METHOD="POST">
			<input type="radio" checked name="field" value="AllFields">All Fields<br>
			<input type="radio" name="field" value="CatID">Category ID<br>
			<input type="radio" name="field" value="CatName">Cat Description<br>
			<input type="radio" name="field" value="CatFeaturedID">Featured Item<br>
			<input type="radio" name="field" value="DateCreated" disabled>Date ( mm/dd/yyyy )<br>
			<input type="hidden" name="start" value="1"><br>
			<input type="text" NAME="string" size="15" class="cfAdminDefault">
			<input type="submit" value="SEARCH" class="cfAdminButton">
		</form>
		</td>
		<td>
		<form name="BackOrderSearchForm" ACTION="BackOrders.cfm" METHOD="POST">
			<input type="radio" checked name="field" value="AllFields">All Fields<br>
			<input type="radio" name="field" value="LastName">Last Name<br>
			<input type="radio" name="field" value="CompanyName">Company Name<br>
			<input type="radio" name="field" value="City">City<br>
			<input type="radio" name="field" value="SKU" >SKU<br><br>
			<input type="text" NAME="string" size="15" class="cfAdminDefault">
			<input type="submit" value="SEARCH" class="cfAdminButton">
		</form>
		</td>
	</tr>
</table>	
<cfinclude template="LayoutAdminFooter.cfm">