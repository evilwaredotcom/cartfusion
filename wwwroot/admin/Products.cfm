<!--- BEGIN: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<cfif isDefined('form.UpdateProduct') AND IsDefined("form.ItemID")>
	<cfif isUserInRole('Administrator')>
		<cfset form.DateUpdated = #Now()#>
		<cfset form.UpdatedBy = #GetAuthUser()#>	
		<cfupdate datasource="#application.dsn#" tablename="Products" 
			formfields="ItemID, SKU, ItemName, Category, Price1, StockQuantity, ItemStatus, DateUpdated, UpdatedBy, Hide1, DisplayOrder ">
		<cfset AdminMsg = 'Item <cfoutput>#form.SKU#</cfoutput> Updated Successfully' >
	<cfelse>			
		<script language="JavaScript">
			{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
		</script>
	</cfif>
</cfif>

<cfif isDefined('form.DeleteProduct') AND IsDefined("form.ItemID")>
	<cfif isUserInRole('Administrator')>
		<cfset form.Deleted = 1 >
		<cfset form.DateUpdated = #Now()# >
		<cfset form.UpdatedBy = #GetAuthUser()# >	
		<cfupdate datasource="#application.dsn#" tablename="Products" 
			formfields="ItemID, Deleted, DateUpdated, UpdatedBy ">
		<cfset AdminMsg = 'Item (Soft) Deleted Successfully' >
	<cfelse>			
		<script language="JavaScript">
			{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
		</script>
	</cfif>
</cfif>

<!--- END: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<!--- SET DEFAULT PARAMETERS --->
<cfparam name="URL.StartRow" default="1" type="numeric">
<cfparam name="URL.SortOption" default="SKU" type="string">
<cfparam name="URL.SortAscending" default="1" type="numeric">
<cfparam name="Form.Field" default="ALL" type="string">
<cfparam name="Form.string" default="" type="string">
<cfset string = Trim(string)>

<!--- BEGIN: SEARCH CRITERIA -------------------------------------------------->

<cfquery name="getProducts" datasource="#application.dsn#">	
	SELECT 	SiteID, ItemID, SKU, ItemName, Category, ItemStatus, StockQuantity, Price1, Hide1, DisplayOrder
	FROM 	Products
	<cfif FIELD IS 'All'>
	WHERE	ItemID = ItemID
	<cfelseif FIELD IS 'AllFields'>
	WHERE 	(SKU like '%#string#%'
	OR 		ItemName like '%#string#%'
	OR 		ItemDescription like '%#string#%'
	OR 		Attribute1 like '%#string#%'
	OR 		Attribute2 like '%#string#%'
	OR 		Attribute3 like '%#string#%'
	OR 		Comments like '%#string#%')
	<cfelseif FIELD IS 'LowInventory'>
	WHERE  (StockQuantity <= 10
	AND		SellByStock = 1 )
	OR		ItemStatus = 'OS'
	OR		ItemStatus = 'BO'
	<cfelseif FIELD IS 'ActiveProducts'>
	WHERE  (Hide1 = 0 OR Hide1 IS NULL)
	<cfelseif FIELD IS 'HiddenProducts'>
	WHERE  Hide1 = 1
	<cfelse>
	WHERE 	#field# like '%#string#%'
	</cfif>
	AND		(Deleted = 0 OR Deleted IS NULL)
	ORDER BY
	<cfif isDefined('URL.SortOption')> #URL.SortOption# <cfelse> SKU </cfif>
	<cfif SortAscending EQ 1> ASC <cfelse> DESC </cfif>
</cfquery>

<cfinvoke component="#application.Queries#" method="getSites" returnvariable="getSites"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getItemStatusCodes" returnvariable="getItemStatusCodes"></cfinvoke>

<!--- END: SEARCH CRITERIA -------------------------------------------------->

<!--- NEXT N VALUES --->
<cfscript>
	RowsPerPage = 15;
	TotalRows = getProducts.RecordCount;
	EndRow = Min(URL.StartRow + RowsPerPage - 1, TotalRows);
 	StartRowNext = EndRow + 1;
 	StartRowBack = URL.StartRow - RowsPerPage;
</cfscript>

<!--- BEGIN: HEADER --->
<cfscript>
	PageTitle = 'PRODUCT CATALOG';
	ModeAllow = 1 ;
	QuickSearch = 1;
	QuickSearchPage = 'Products.cfm';
	AddPage = 'ProductAdd.cfm';
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">
<!--- END: HEADER --->

<cfoutput>

<!--- BEGIN PRODUCTS TABLE --->
<table border="0" cellpadding="2" cellspacing="0" width="100%">
	<tr style="background-color:##7DBF0E;">
		<td align="left" width="4%"  class="cfAdminHeader2" height="20"></td><!--- EDIT --->
		<td align="left" width="1%"  class="cfAdminHeader2" height="20"></td><!--- DELETE --->
		<td align="left" width="10%" class="cfAdminHeader2" nowrap>
			SKU
			<a href="Products.cfm?SortOption=SKU&SortAscending=1&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="Products.cfm?SortOption=SKU&SortAscending=0&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td align="left" width="20%" class="cfAdminHeader2" nowrap>
			Item Name
			<a href="Products.cfm?SortOption=ItemName&SortAscending=1&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="Products.cfm?SortOption=ItemName&SortAscending=0&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td align="left" width="20%" class="cfAdminHeader2" nowrap>
			Category
			<a href="Products.cfm?SortOption=Category&SortAscending=1&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="Products.cfm?SortOption=Category&SortAscending=0&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td align="left" width="10%" class="cfAdminHeader2" nowrap>
			Price
			<a href="Products.cfm?SortOption=Price1&SortAscending=1&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="Products.cfm?SortOption=Price1&SortAscending=0&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td align="left" width="10%" class="cfAdminHeader2" nowrap>
			Stock Qty
		</td>
		<td align="left" width="15%" class="cfAdminHeader2" nowrap>
			Item Status
			<a href="Products.cfm?SortOption=ItemStatus&SortAscending=1&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="Products.cfm?SortOption=ItemStatus&SortAscending=0&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td align="center" width="10%" class="cfAdminHeader2" nowrap>
			Display Order
		</td>
	</tr>
</cfoutput>

<!--- START: REGULAR MODE --------------------------------------------------------------------------------------------------->
<cfif Mode EQ 0 >
	<cfoutput query="getProducts" startrow="#StartRow#" maxrows="#RowsPerPage#">
		<cfform action="Products.cfm?StartRow=#StartRow#&SortOption=#SortOption#&SortAscending=#SortAscending#&field=#field#&string=#string#" method="post" passthrough="class=""10pxdarkgray""">
		<tr>
			<td>
				<input type="button" name="ViewProductInfo" value="VIEW" alt="View Product Information" class="cfAdminButton"
					onclick="document.location.href='ProductDetail.cfm?ItemID=#ItemID#'">
			</td>
			<td>
				<input type="submit" name="DeleteProduct" value="X" alt="Delete Product (soft delete)" class="cfAdminButton"
					onclick="return confirm('Are you sure you want to DELETE PRODUCT &quot;#ItemName#&quot; ?')">
			</td>
			<td>#SKU#</td>
			<td>#ItemName#</td>
			<td>
				<cfif TRIM(Category) NEQ '' > 
					<cfquery name="thisCatName" datasource="#application.dsn#">
						SELECT	CatName
						FROM	Categories
						WHERE	CatID = <cfqueryparam value="#Category#" cfsqltype="cf_sql_integer">
					</cfquery>
					#thisCatName.CatName#
				</cfif>
			</td>
			<td>#DecimalFormat(Price1)#</td>
			<td>#StockQuantity#</td>
			<td>
				<cfquery name="thisItemStatus" dbtype="query">
					SELECT	StatusMessage
					FROM	getItemStatusCodes
					WHERE	StatusCode = '#ItemStatus#'
				</cfquery>
				#thisItemStatus.StatusMessage#
			</td>
			<td align="center">#DisplayOrder#</td>
			<!---
			<td>
				<input type="image" src="images/updatebutton.gif" name="UpdateProduct" value="UpdateProduct" border="0" alt="Update Changes">
			</td>
			--->
			<input type="hidden" name="ItemID" value="#ItemID#">
		</tr>	
		</cfform>
		<!--- DIVIDER --->
		<tr><td height="1" colspan="10"><img src="images/image-LineGray.gif" width="100%" height="1"></td></tr>
	</cfoutput>
<!--- END: REGULAR MODE --------------------------------------------------------------------------------------------------->
<!--- START: QUICK EDIT MODE --------------------------------------------------------------------------------------------------->
<cfelseif Mode EQ 1 >
	<cfoutput query="getProducts" startrow="#StartRow#" maxrows="#RowsPerPage#">
		<cfform action="Products.cfm?StartRow=#StartRow#&SortOption=#SortOption#&SortAscending=#SortAscending#&field=#field#&string=#string#" method="post" passthrough="class=""10pxdarkgray""">
		<tr>
			<td>
				<input type="button" name="ViewProductInfo" value="VIEW" alt="View Product Information" class="cfAdminButton"
					onclick="document.location.href='ProductDetail.cfm?ItemID=#ItemID#'">
			</td>
			<td>
				<input type="submit" name="DeleteProduct" value="X" alt="Delete Product (soft delete)" class="cfAdminButton"
					onclick="return confirm('Are you sure you want to DELETE PRODUCT &quot;#ItemName#&quot; ?')">
			</td>
			<td><cfinput type="text" name="SKU" value="#SKU#" size="10" class="cfAdminDefault" onchange="updateInfo(#ItemID#,this.value,'SKU','Products');"></td>
			<td><cfinput type="text" name="ItemName" value="#ItemName#" size="33" class="cfAdminDefault" onchange="updateInfo(#ItemID#,this.value,'ItemName','Products');"></td>
			<td>
				<select name="Category" size="1" class="cfAdminDefault" onchange="updateInfo('#ItemID#',this.value,'Category','Products');">
					<cfset EntryValue = Category >
					<cfinclude template="Includes/DDLCat.cfm">
				</select>
			</td>
			<td><input type="text" name="Price1" value="#DecimalFormat(Price1)#" size="7" class="cfAdminDefault" onchange="updateInfo(#ItemID#,this.value,'Price1','Products');"></td>
			<td><input type="text" name="StockQuantity" value="#StockQuantity#" size="7" class="cfAdminDefault" onchange="updateInfo(#ItemID#,this.value,'StockQuantity','Products');"></td>
			<td>
				<cfselect name="ItemStatus" query="getItemStatusCodes" size="1" onChange="updateInfo(#ItemID#,this.value,'ItemStatus','Products');"
					value="StatusCode" display="StatusMessage" selected="#ItemStatus#" class="cfAdminDefault" />
			</td>
			<td align="center"><input type="text" name="DisplayOrder" value="#DisplayOrder#" size="3" class="cfAdminDefault" onchange="updateInfo(#ItemID#,this.value,'DisplayOrder','Products');"></td>
			<!---
			<td>
				<input type="image" src="images/updatebutton.gif" name="UpdateProduct" value="UpdateProduct" border="0" alt="Update Changes">
			</td>
			--->
			<input type="hidden" name="ItemID" value="#ItemID#">
		</tr>	
		</cfform>
		<!--- DIVIDER --->
		<tr><td height="1" colspan="10"><img src="images/image-LineGray.gif" width="100%" height="1"></td></tr>
	</cfoutput>
</cfif>
<!--- END: QUICK EDIT MODE --------------------------------------------------------------------------------------------------->

<!--- NAVIGATION ------------------------------------->
	<tr>
		<td class="cfAdminDefault" colspan="5"><cfoutput>Displaying <b>#URL.StartRow#</b> to <b>#EndRow#</b> of <b>#TotalRows#</b> Products</cfoutput></td>
		<td align="right" colspan="5"><cfinclude template="NextNButtons.cfm"></td>
	</tr>
	<!---
	<tr>
		<td class="cfAdminDefault" colspan="11"><cfoutput>It took #getOrderExecutionTime# milliseconds to execute this query</cfoutput></td>
	</tr>
	--->
<!--- NAVIGATION ------------------------------------->
</table>
<br/><br/>

<!--- QUICK LINKS --->
<table width="700" border="1" cellpadding="3" cellspacing="0" align="center">
	<tr>
		<td class="cfAdminHeader1" style="border:1px; border-color:000000;" align="center">
			QUICK LINKS
		</td>
	</tr>
	<tr>
		<td style="border:1px; border-color:000000;" align="center">
			Show Only: 
			<input type="button" name="LowInventory" value="LOW INVENTORY" alt="Show Only Products Low on Inventory" class="cfAdminButton"
				onclick="document.location.href='Products.cfm?Field=LowInventory'">
			<input type="button" name="ActiveProducts" value="ACTIVE PRODUCTS" alt="Show Only Active Products" class="cfAdminButton"
				onclick="document.location.href='Products.cfm?Field=ActiveProducts'">
			<input type="button" name="HiddenProducts" value="HIDDEN PRODUCTS" alt="Show Only Hidden Products" class="cfAdminButton"
				onclick="document.location.href='Products.cfm?Field=HiddenProducts'">
			<input type="button" name="AllProducts" value="ALL PRODUCTS" alt="Show All Products" class="cfAdminButton"
				onclick="document.location.href='Products.cfm'">
		</td>
	</tr>
</table>
<!--- QUICK LINKS --->

<cfinclude template="LayoutAdminFooter.cfm">