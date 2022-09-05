<cfscript>
	PageTitle = 'CARTFUSION MAIL WIZARD PRO' ;
	BannerTitle = 'MailWizardPro' ;
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">

<!--- BEGIN: QUERIES --->
<cfinvoke component="#application.Queries#" method="getCities" returnvariable="getCities"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getStates" returnvariable="getStates"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getCountries" returnvariable="getCountries"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getUsers" returnvariable="getUsers"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getSKUs" returnvariable="getSKUs"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getCategories" returnvariable="getCategories"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getAFLevels" returnvariable="getAFLevels"></cfinvoke>
<!--- END: QUERIES --->

<table cellpadding="0" cellspacing="0" border="0" width="100%">
<cfform name="FForm" action="MWP-EmailMessage.cfm" method="post">
<tr><td colspan="4" height="20" class="cfAdminHeader1">&nbsp; SEARCH CRITERIA</td></tr>
<tr>
<td width="2%">&nbsp;</td>
<td width="73%">
<table cellpadding="3" cellspacing="0" border="0">
	<cfif isDefined('ErrorMsg')>
	<tr>
		<td colspan="2" height="24" class="cfAdminError">
			<cfif ErrorMsg EQ 1>ERROR: Please select a criteria button before proceeding.
			<cfelseif ErrorMsg EQ 2>ERROR: Please provide email addresses, separated by commas, before proceeding.
			<cfelseif ErrorMsg EQ 3>ERROR: If specifying criteria, please check a criteria box and provide the necessary information before proceeding.
			<cfelseif ErrorMsg EQ 4>ERROR: Please provide a FROM and TO date to send by date values before proceeding.
			<cfelseif ErrorMsg EQ 5>ERROR: Please set the FROM date to less than the TO date before proceeding.
			<cfelseif ErrorMsg EQ 6>ERROR: Please provide a country before proceeding.
			<cfelseif ErrorMsg EQ 8>EXCEPTION: There are no email addresses available based on the given criteria.  Please try again.
			</cfif>
		</td>		
	</tr>
	</cfif>
	<tr>
		<td><cfinput type="radio" name="SearchCriteria" value="AllAffiliates"></td>
		<td>All Affiliates</td>
	</tr>
	<tr>
		<td><cfinput type="radio" name="SearchCriteria" value="AffiliateLevel"></td>
		<td>
			Affiliates at this level:
			<select name="Level" size="1" class="cfAdminDefault" onChange="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-6]);">
				<option value="" selected></option>
			<cfoutput query="getAFLevels">
				<option value="#CommID#">#LevelName#</option>
			</cfoutput>	
			</select>
		</td>
	</tr>
	<tr>
		<td colspan="2" align="left"><hr size="1" width="70%" color="silver" /></td>
	</tr>
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
			<select name="User" size="1" class="cfAdminDefault" onChange="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-3]);">
				<option value="" selected></option>
			<cfoutput query="getUsers">
				<option value="#UID#">#UName#</option>
			</cfoutput>	
			</select>
		</td>
	</tr>
	<!--- ONLY THESE EMAIL ADDRESSES --->
	<tr>
		<td><cfinput type="radio" name="SearchCriteria" value="ByEmail"></td>
		<td class="cfAdminDefault" height="50">
			Send using only these email addresses (separated by commas):<br>
			<cfinput type="text" name="EmailsProvided" size="60" class="cfAdminDefault" onChange="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-2]);">
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
			<cfinput type="checkbox" name="ByOrdAmtLeast" onClick="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]);">
			Customers who have ordered at least
			$<cfinput type="text" name="OrdAmtLeast" size="10" required="no" validate="float" message="Please enter a decimal value" class="cfAdminDefault" 
				onChange="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]); autoChange(this,document.FForm.ByOrdAmtLeast);">
		</td>
	</tr>
	<!--- TOTAL AMOUNTS OF ORDERS AT MOST --->
	<tr>
		<td></td>
		<td>
			<cfinput type="checkbox" name="ByOrdAmtMost" onClick="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]);">
			Customers who have ordered at most
			$<cfinput type="text" name="OrdAmtMost" size="10" required="no" validate="float" message="Please enter a decimal value" class="cfAdminDefault" 
				onChange="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]); autoChange(this,document.FForm.ByOrdAmtMost);">
		</td>
	</tr>
	<!--- TOTAL ORDERS AT LEAST --->
	<tr>
		<td></td>
		<td>
			<cfinput type="checkbox" name="ByOrdLeast" onClick="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]);">
			Customers who have placed at least 
			<cfinput type="text" name="OrdLeast" size="10" required="no" validate="integer" message="Please enter a whole number" class="cfAdminDefault" 
				onChange="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]); autoChange(this,document.FForm.ByOrdLeast);">
			orders
		</td>
	</tr>
	<!--- TOTAL ORDERS AT MOST --->
	<tr>
		<td></td>
		<td>
			<cfinput type="checkbox" name="ByOrdMost" onClick="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]);">
			Customers who have placed at most 
			<cfinput type="text" name="OrdMost" size="10" required="no" validate="integer" message="Please enter a whole number" class="cfAdminDefault" 
				onChange="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]); autoChange(this,document.FForm.ByOrdMost);">
			orders
		</td>
	</tr>	
	<!--- ORDERED SINCE --->
	<tr>
		<td></td>
		<td>
			<cfinput type="checkbox" name="ByOrdSince" onClick="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]);">
			Customers who have ordered since
			<cfinput type="text" name="OrdSince" size="10" required="no" validate="date" message="Please enter a date in mm/dd/yyyy format" class="cfAdminDefault" 
				onChange="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]); autoChange(this,document.FForm.ByOrdSince);">
		</td>
	</tr>
	<!--- NOT ORDERED SINCE --->
	<tr>
		<td></td>
		<td>
			<cfinput type="checkbox" name="ByOrdSinceNot" onClick="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]);">
			Customers who have <i>not</i> ordered since
			<cfinput type="text" name="OrdSinceNot" size="10" required="no" validate="date" message="Please enter a date in mm/dd/yyyy format" class="cfAdminDefault" 
				onChange="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]); autoChange(this,document.FForm.ByOrdSinceNot);">
		</td>
	</tr>	
	<!--- ORDERED BETWEEN X DATE AND Y DATE --->
	<tr>
		<td></td>
		<td>
			<cfinput type="checkbox" name="ByOrdBetween" onClick="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]);">
			Customers who have ordered between:
			<cfinput type="text" name="OrdFromDate" size="10" required="no" validate="date" message="Please enter the From Date in mm/dd/yyyy format" class="cfAdminDefault" 
				onChange="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]); autoChange(this,document.FForm.ByOrdBetween);">
			and
			<cfinput type="text" name="OrdToDate" size="10" required="no" validate="date" message="Please enter the To Date in mm/dd/yyyy format" class="cfAdminDefault"
				onChange="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]); autoChange(this,document.FForm.ByOrdBetween);">
		</td>
	</tr>
	<!--- PRODUCT ORDERED --->
	<tr>
		<td></td>
		<td>
			<cfinput type="checkbox" name="ByProd" onClick="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]);">
			Customers who have ordered this product:
			<select name="Prod" size="1" class="cfAdminDefault" onChange="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]); autoChange(this,document.FForm.ByProd);">
				<option value="" selected></option>
			<cfoutput query="getSKUs">
				<option value="#ItemID#">#SKU#</option>
			</cfoutput>	
			</select>
		</td>
	</tr>
	<!--- PRODUCT NOT ORDERED --->
	<tr>
		<td></td>
		<td>
			<cfinput type="checkbox" name="ByProdNot" onClick="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]);">
			Customers who have <i>not</i> ordered this product:
			<select name="ProdNot" size="1" class="cfAdminDefault" onChange="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]); autoChange(this,document.FForm.ByProdNot);">
				<option value="" selected></option>
			<cfoutput query="getSKUs">
				<option value="#ItemID#">#SKU#</option>
			</cfoutput>
			</select>
		</td>
	</tr>
	<!--- CATEGORY ORDERED --->
	<tr>
		<td></td>
		<td>
			<cfinput type="checkbox" name="ByCat" onClick="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]);">
			Customers who have ordered a product in this category:
			<select name="Cat" size="1" class="cfAdminDefault" onChange="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]); autoChange(this,document.FForm.ByCat);">
				<option value="" selected></option>
			<cfoutput query="getCategories">
				<option value="#CatID#">#CatName#</option>
			</cfoutput>	
			</select>
		</td>
	</tr>
	<!--- CATEGORY NOT ORDERED --->
	<tr>
		<td></td>
		<td>
			<cfinput type="checkbox" name="ByCatNot" onClick="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]);">
			Customers who have <i>not</i> ordered a product in this category:
			<select name="CatNot" size="1" class="cfAdminDefault" onChange="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]); autoChange(this,document.FForm.ByCatNot);">
				<option value="" selected></option>
			<cfoutput query="getCategories">
				<option value="#CatID#">#CatName#</option>
			</cfoutput>	
			</select>
		</td>
	</tr>

	<!--- BY CITY --->
	<tr>
		<td></td>
		<td>
			<cfinput type="checkbox" name="ByCity" onClick="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]);">
			Customers in this city:
			<cfselect name="City" size="1" query="GetCities" value="City" display="City" class="cfAdminDefault"
				onChange="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]); autoChange(this,document.FForm.ByCity);" />
		</td>
	</tr>	
	<!--- BY STATE --->
	<tr>
		<td></td>
		<td>
			<cfinput type="checkbox" name="ByState" onClick="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]);">
			Customers in this state:
			<cfselect name="State" size="1" query="GetStates" value="StateCode" display="State" class="cfAdminDefault"
				onChange="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]); autoChange(this,document.FForm.ByState);" />
		</td>
	</tr>
	<!--- BY COUNTRY --->
	<tr>
		<td></td>
		<td>
			<cfinput type="checkbox" name="ByCountry" onClick="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]);">
			Customers in this country:
			<cfselect name="Country" size="1" query="GetCountries" value="CountryCode" display="Country" class="cfAdminDefault" selected="US"
				onChange="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]); autoChange(this,document.FForm.ByCountry);" />
		</td>
	</tr>
	<!--- INCLUDE THESE EMAILS --->
	<tr>
		<td></td>
		<td>
			<cfinput type="checkbox" name="ByIncludeEmails" onClick="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]);">
			Include these email addresses (separated by commas):<br>
			<cfinput type="text" name="IncludeEmails" size="60" class="cfAdminDefault"
				onChange="autoChange(this,document.FForm.SearchCriteria[document.FForm.SearchCriteria.length-1]); autoChange(this,document.FForm.ByIncludeEmails);">
		</td>
	</tr>
	<tr><td colspan="2" height="10"></td></tr>	
	<tr>
		<td colspan="2" align="center">
			<input type="submit" name="submitMailingLabels" value="CREATE MAILING LABELS" onClick="SubmitFormTo('MWP-MailAction.cfm','POST')" class="cfAdminButton">
			<input type="submit" name="submitBulkEmails" value="SEND BULK EMAIL" onClick="SubmitFormTo('MWP-EmailMessage.cfm','POST')" class="cfAdminButton">
			<input type="submit" name="submitCustomerList" value="GET CUSTOMER LIST" onClick="SubmitFormTo('MWP-CustomerList.cfm','POST')" class="cfAdminButton">
			<input type="reset" name="resetBulk" value="CLEAR FORM" class="cfAdminButton">
		</td>
	</tr>
	<tr><td height="100%" colspan="2" style="padding-bottom:15px;"></td></tr>
</table>	
</cfform>

</td>
<td width="1" height="100%" rowspan="100"><img src="images/line-CCCCCC.gif" height="100%" width="1" border="0"></td>
<td width="25%" valign="top">

<table border="0" bordercolor="<cfoutput>#cfAdminHeaderColor#</cfoutput>" cellpadding="4" cellspacing="0" width="100%">
	<tr><td height="1" style="background-color:##CCCCCC;"></td></tr>
	<tr><td height="7"></td></tr>
	<tr><td><b>MAILING LABEL SPECIFICATIONS</b></td></tr>
	<tr class="cfAdminError"><td>Your mailing labels will open in a new window. To optimize your print settings:</td></tr>
	<tr><td>Printing: Mailing Labels are designed to be printed on pages of <b>1" x 2 5/8" labels, 30 per page</b>, (Avery Address Labels <b>5160, 5260, 5920, 8160, 8460</b>).</td></tr>
	<tr><td><b>1)</b> Choose Page Setup from your browser's File menu.</td></tr>
	<tr><td><b>2)</b> Clear the Header and Footer text boxes.</td></tr>
	<tr><td><b>3)</b> Set the Margins as follows: Top: <b>0.55"</b>&nbsp; Bottom: <b>0.3"</b>&nbsp; Left: <b>0.375"</b>&nbsp; Right: <b>0.375"</b> </td></tr>
</table>

</td>
</tr>
</table>

<cfinclude template="LayoutAdminFooter.cfm">