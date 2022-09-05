<!--- BEGIN: QUERIES --->

<cfinvoke component="#application.Queries#" method="getCities" returnvariable="getCities"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getStates" returnvariable="getStates"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getCountries" returnvariable="getCountries"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getUsers" returnvariable="getUsers"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getSKUs" returnvariable="getSKUs"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getCategories" returnvariable="getCategories"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getCustomers" returnvariable="getCustomers"></cfinvoke>

<!--- END: QUERIES --->

<cfscript>
	PageTitle = 'CARTFUSION MESSAGE CENTER';
	BannerTitle = 'MessageCenterc' ;
	AddAButton = 'RETURN TO MESSAGE CENTER' ;
	AddAButtonLoc = 'MC-Home.cfm' ;
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">

<cfoutput>

<table width="100%" cellpadding="3" cellspacing="0" border="0">
<cfform name="FForm" action="MC-SendAction.cfm" method="post">
	<cfif isDefined('ErrorMsg')>
	<tr>
		<td colspan="2" class="cfAdminError">
			<cfif ErrorMsg EQ 1>ERROR: Please select a criteria button before proceeding.
			<cfelseif ErrorMsg EQ 2>ERROR: Please select a customer from the dropdown list before proceeding.
			<cfelseif ErrorMsg EQ 3>ERROR: If specifying criteria, please check a criteria box and provide the necessary information before proceeding.
			<cfelseif ErrorMsg EQ 4>ERROR: Please provide a FROM and TO date to send by date values before proceeding.
			<cfelseif ErrorMsg EQ 5>ERROR: Please set the FROM date to less than the TO date before proceeding.
			<cfelseif ErrorMsg EQ 6>ERROR: Please provide a country before proceeding.
			<cfelseif ErrorMsg EQ 7>ERROR: You must enter the message to proceed.  Please try again.
			<cfelseif ErrorMsg EQ 8>EXCEPTION: There are no customers available based on the given criteria.  Please try again.
			</cfif>
		</td>		
	</tr>
	</cfif>
	<tr style="background-color:##65ADF1;"><td colspan="2" class="cfAdminHeader1">SEND A MESSAGE TO:</td></tr>
	<tr>
		<td><cfinput type="radio" name="SearchCriteria" value="All" checked="true"></td>
		<td>All Customers</td>
	</tr>
	<tr>
		<td><cfinput type="radio" name="SearchCriteria" value="AllOrders"></td>
		<td>Customers with orders</td>
	</tr>
	<tr>
		<td><cfinput type="radio" name="SearchCriteria" value="ByUser"></td>
		<td>
			Customers using these prices:
			<select name="User" size="1" class="cfAdminDefault" onchange="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-3]);">
				<option value="" selected></option>
				<cfloop query="getUsers">
					<option value="#UID#">#UName#</option>
				</cfloop>	
			</select>
		</td>
	</tr>
	<!--- ONLY THIS CUSTOMER --->
	<tr>
		<td><cfinput type="radio" name="SearchCriteria" value="ByCustomer"></td>
		<td>
			This customer only:
			<select name="Customer" size="1" class="cfAdminDefault" onchange="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-2]);">
				<option value="" selected></option>
				<cfloop query="getCustomers">
					<option value="#CustomerID#">#CustomerInfo#</option>
				</cfloop>	
			</select>
		</td>
	</tr>
	<!--- BY SEARCH CRITERIA --->
	<tr>
		<td><cfinput type="radio" name="SearchCriteria" value="ByCriteria" ></td>
		<td>By Criteria</td>
	</tr>
	<!--- TOTAL AMOUNTS OF ORDERS AT LEAST --->
	<tr>
		<td></td>
		<td>
			<cfinput type="checkbox" name="ByOrdAmtLeast" onclick="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]);">
			Customers who have ordered at least
			$<cfinput type="text" name="OrdAmtLeast" size="10" required="no" validate="float" message="Please enter a decimal value" class="cfAdminDefault" 
				onchange="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]); autoChange(this,document.FForm.ByOrdAmtLeast);">
		</td>
	</tr>
	<!--- TOTAL AMOUNTS OF ORDERS AT MOST --->
	<tr>
		<td></td>
		<td>
			<cfinput type="checkbox" name="ByOrdAmtMost" onclick="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]);">
			Customers who have ordered at most
			$<cfinput type="text" name="OrdAmtMost" size="10" required="no" validate="float" message="Please enter a decimal value" class="cfAdminDefault" 
				onchange="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]); autoChange(this,document.FForm.ByOrdAmtMost);">
		</td>
	</tr>
	<!--- TOTAL ORDERS AT LEAST --->
	<tr>
		<td></td>
		<td>
			<cfinput type="checkbox" name="ByOrdLeast" onclick="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]);">
			Customers who have placed at least 
			<cfinput type="text" name="OrdLeast" size="10" required="no" validate="integer" message="Please enter a whole number" class="cfAdminDefault" 
				onchange="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]); autoChange(this,document.FForm.ByOrdLeast);">
			orders
		</td>
	</tr>
	<!--- TOTAL ORDERS AT MOST --->
	<tr>
		<td></td>
		<td>
			<cfinput type="checkbox" name="ByOrdMost" onclick="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]);">
			Customers who have placed at most 
			<cfinput type="text" name="OrdMost" size="10" required="no" validate="integer" message="Please enter a whole number" class="cfAdminDefault" 
				onchange="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]); autoChange(this,document.FForm.ByOrdMost);">
			orders
		</td>
	</tr>	
	<!--- ORDERED SINCE --->
	<tr>
		<td></td>
		<td>
			<cfinput type="checkbox" name="ByOrdSince" onclick="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]);">
			Customers who have ordered since
			<cfinput type="text" name="OrdSince" size="10" required="no" validate="date" message="Please enter a date in mm/dd/yyyy format" class="cfAdminDefault" 
				onchange="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]); autoChange(this,document.FForm.ByOrdSince);">
		</td>
	</tr>
	<!--- NOT ORDERED SINCE --->
	<tr>
		<td></td>
		<td>
			<cfinput type="checkbox" name="ByOrdSinceNot" onclick="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]);">
			Customers who have <i>not</i> ordered since
			<cfinput type="text" name="OrdSinceNot" size="10" required="no" validate="date" message="Please enter a date in mm/dd/yyyy format" class="cfAdminDefault" 
				onchange="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]); autoChange(this,document.FForm.ByOrdSinceNot);">
		</td>
	</tr>	
	<!--- ORDERED BETWEEN X DATE AND Y DATE --->
	<tr>
		<td></td>
		<td>
			<cfinput type="checkbox" name="ByOrdBetween" onclick="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]);">
			Customers who have ordered between:
			<cfinput type="text" name="OrdFromDate" size="10" required="no" validate="date" message="Please enter the From Date in mm/dd/yyyy format" class="cfAdminDefault" 
				onchange="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]); autoChange(this,document.FForm.ByOrdBetween);">
			and
			<cfinput type="text" name="OrdToDate" size="10" required="no" validate="date" message="Please enter the To Date in mm/dd/yyyy format" class="cfAdminDefault"
				onchange="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]); autoChange(this,document.FForm.ByOrdBetween);">
		</td>
	</tr>
	<!--- PRODUCT ORDERED --->
	<tr>
		<td></td>
		<td>
			<cfinput type="checkbox" name="ByProd" onclick="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]);">
			Customers who have ordered this product:
			<select name="Prod" size="1" class="cfAdminDefault" onchange="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]); autoChange(this,document.FForm.ByProd);">
				<option value="" selected></option>
			<cfloop query="getSKUs">
				<option value="#ItemID#">#SKU#</option>
			</cfloop>	
			</select>
		</td>
	</tr>
	<!--- PRODUCT NOT ORDERED --->
	<tr>
		<td></td>
		<td>
			<cfinput type="checkbox" name="ByProdNot" onclick="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]);">
			Customers who have <i>not</i> ordered this product:
			<select name="ProdNot" size="1" class="cfAdminDefault" onchange="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]); autoChange(this,document.FForm.ByProdNot);">
				<option value="" selected></option>
			<cfloop query="getSKUs">
				<option value="#ItemID#">#SKU#</option>
			</cfloop>
			</select>
		</td>
	</tr>
	<!--- CATEGORY ORDERED --->
	<tr>
		<td></td>
		<td>
			<cfinput type="checkbox" name="ByCat" onclick="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]);">
			Customers who have ordered a product in this category:
			<select name="Cat" size="1" class="cfAdminDefault" onchange="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]); autoChange(this,document.FForm.ByCat);">
				<option value="" selected></option>
			<cfloop query="getCategories">
				<option value="#CatID#">#CatName#</option>
			</cfloop>	
			</select>
		</td>
	</tr>
	<!--- CATEGORY NOT ORDERED --->
	<tr>
		<td></td>
		<td>
			<cfinput type="checkbox" name="ByCatNot" onclick="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]);">
			Customers who have <i>not</i> ordered a product in this category:
			<select name="CatNot" size="1" class="cfAdminDefault" onchange="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]); autoChange(this,document.FForm.ByCatNot);">
				<option value="" selected></option>
			<cfloop query="getCategories">
				<option value="#CatID#">#CatName#</option>
			</cfloop>	
			</select>
		</td>
	</tr>

	<!--- BY CITY --->
	<tr>
		<td></td>
		<td>
			<cfinput type="checkbox" name="ByCity" onclick="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]);">
			Customers in this city:
			<cfselect name="City" size="1" query="GetCities" value="City" display="City" class="cfAdminDefault"
				onChange="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]); autoChange(this,document.FForm.ByCity);" />
		</td>
	</tr>	
	<!--- BY STATE --->
	<tr>
		<td></td>
		<td>
			<cfinput type="checkbox" name="ByState" onclick="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]);">
			Customers in this state:
			<cfselect name="State" size="1" query="GetStates" value="StateCode" display="State" class="cfAdminDefault"
				onChange="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]); autoChange(this,document.FForm.ByState);" />
		</td>
	</tr>
	<!--- BY COUNTRY --->
	<tr>
		<td></td>
		<td>
			<cfinput type="checkbox" name="ByCountry" onclick="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]);">
			Customers in this country:
			<cfselect name="Country" size="1" query="GetCountries" value="CountryCode" display="Country" class="cfAdminDefault" selected="US"
				onChange="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]); autoChange(this,document.FForm.ByCountry);" />
		</td>
	</tr>
	<tr><td colspan="2" height="10"></td></tr>	
	<tr>
		<td colspan="2">
			<input type="button" name="GoBack" value="<< GO BACK" alt="Go back to previous page" class="cfAdminButton"
					onclick="document.location.href='MC-Main.cfm'">
			<input type="reset" name="ResetMessage" value="CLEAR FORM" class="cfAdminButton">
			<input type="submit" name="PreviewMessage" value="PREPARE MESSAGE >>" style="color:FF6600;" onclick="SubmitFormTo('MC-SendAction.cfm','POST')" class="cfAdminButton">
		</td>
	</tr>
	<tr><td height="100%" colspan="2" style="padding-bottom:15px;"></td></tr>
</table>	
</cfform>
</cfoutput>

<cfinclude template="LayoutAdminFooter.cfm">