


<!--- What row to start at? Assume first by default --->
<cfparam name="url.StartRow" default="1" type="numeric">
<cfparam name="url.SortOption" default="SignID" type="string">
<cfparam name="url.SortAscending" default="0" type="numeric">
<cfparam name="form.field" default="ALL" type="string">
<cfparam name="form.string" default="" type="string">

<cfscript>
	string = Trim(string);
</cfscript>


<cfif field is "Category">
	<cfquery name="GetCategories" datasource="#application.dsn#">
		SELECT 		CatName
		FROM 		categories
		WHERE 		categories.CatName like '%#string#%'
		AND			Hide#session.CustomerArray[28]# != 1
		AND			SiteID = #application.SiteID#
		ORDER BY 	CatName
	</cfquery>
	
</cfif>

<!--- Convert to cfc --->

<cfquery name="getProducts" datasource="#application.dsn#">
	SELECT 	* 
	FROM 	Products 
	WHERE	Hide#session.CustomerArray[28]# != 1
	AND		SiteID = #application.SiteID#
	AND		(Deleted = 0 OR Deleted IS NULL)
	AND		Category IN (SELECT CatID FROM Categories WHERE Hide#session.CustomerArray[28]# != 1)
<cfif field EQ 'All'>
	AND 	(SKU like '%'
	OR 		ItemName like '%#string#%'
	OR 		ItemDescription like '%#string#%')
<cfelseif field EQ "Category">
	AND		Category IN (SELECT CatID FROM Categories WHERE CatName LIKE '%#string#%')
<cfelseif field EQ "ProductPrice">
	<cfif string IS "">
		<cfset string = '0'>
	</cfif>
	AND 	#field# <= #string# 			
<cfelseif field EQ "ItemAndID">
	AND 	(SKU like '%#string#%'
	OR 		ItemName like '%#string#%'
	OR 		ItemDescription like '%#string#%'
	OR		Comments like '%#string#%'
	OR		Category IN (SELECT CatID FROM Categories WHERE CatName LIKE '%#string#%')
	)
<cfelseif field EQ "Price">
	AND 	Price#session.CustomerArray[28]# <= CONVERT(money, '#string#')
<cfelse>
	AND #field# like '%#string#%' 
</cfif>		
	ORDER BY ItemName
</cfquery>

	<cfscript>
		// Search Categories
		//searchCategories = application.Queries.getCategories();
		// Next N values
		RowsPerPage = 8;
		TotalRows = getProducts.RecordCount;
		EndRow = Min(url.StartRow + RowsPerPage - 1, TotalRows);
		StartRowNext = EndRow + 1;
		StartRowBack = url.StartRow - RowsPerPage;
	</cfscript>


<cfoutput>
	<cfmodule template="templates/#application.SiteTemplate#/layout.cfm" currenttab="Home" pagetitle="Search Results">
	
	<!--- Start Breadcrumb --->
	<cfmodule template="tags/breadCrumbs.cfm" crumblevel='1' showlinkcrumb="Search Results" />
	<!--- End BreadCrumb --->
	
		
		<!--- Display Results --->
		<div align="center">
			Your search for <cfif isDefined('string') neq ''><strong>"#string#"</strong></cfif> produced <strong>#getProducts.RecordCount#</strong> results...
			<hr class="snip" />
		</div>
	
		<!--- <cfinclude template="includes/ProductListDisplay.cfm"> --->
		<!--- Start Category Container --->
	
	<cfif getProducts.RecordCount>
	
	<div id="categoryList">
	
	<cfloop query="getProducts" startrow="#StartRow#" endrow="#EndRow#">
	<!--- <cfoutput query="getProducts" startrow="#URL.StartRow#"> --->
				
			<!--- CARTFUSION 4.6 - CART CFC --->
			<cfscript>
				if ( trim(session.CustomerArray[28]) NEQ '' ) {
					UserID = session.CustomerArray[28] ;
				} else {
					UserID = 1 ;
				}
				UseThisPrice = application.Cart.getItemPrice(
					UserID=UserID,
					SiteID=application.SiteID,
					ItemID=ItemID,
					SessionID=SessionID);
			</cfscript>
			
	
	
		<a href="ProductDetail.cfm?ItemID=#ItemID#">
			<div class="thumbnail">
				<cfif getProducts.ImageSmall IS ''>
					<cfif FileExists(#application.ImageServerPath# & '\' & #ImageDir# & '\' & #SKU# & 'sm.jpg')>
						<img src="images/#ImageDir#/#SKU#sm.jpg" align="middle" alt="#ItemName#" width="75"><br>
						<!---<img src="images/button-detail.gif" border="0" align="middle">---></a>
					<cfelse>
						<img src="images/image-EMPTY.gif" align="middle" alt="#ItemName#"><br>
						<!---<img src="images/button-detail.gif" border="0" align="middle">---></a>
					</cfif>
				<cfelse>
					<cfif FileExists(#application.ImageServerPath# & '\' & #ImageDir# & '\' & #ImageSmall#)>
						<img src="images/#ImageDir#/#ImageSmall#" align="middle" alt="#ItemName#" width="75"><br>
						<!---<img src="images/button-detail.gif" border="0" align="middle">---></a>
					<cfelse>											
						<img src="images/image-EMPTY.gif" align="middle" alt="#ItemName#"><br>
						<!---<img src="images/button-detail.gif" border="0" align="middle">---></a>
					</cfif>
				</cfif>
					<p>
						<!--- Text Link and form elements --->
						<a href="ProductDetail.cfm?ItemID=#ItemID#">#ItemName#</a><br/>
						<!--- SHOW SKU --->
						SKU: #SKU#<br/>
						#LSCurrencyFormat(UseThisPrice, "local")#<br/><br/>
						<!--- OPTIONAL COMPARE PRODUCTS FORM --->
						<input type="checkbox" name="ID" value="#ItemID#"><input type="button" value="compare" class="button" onclick="submit();"><br><br>
					</p>
				
			</div>
			
			</a>
	</cfloop><!--- </cfoutput> --->

	</div>
	<!--- End Category Container --->
	</cfif>
	
	<!--- NAVIGATION --->
	<cfif TotalRows GT 0>
	<!--- Pagination --->		
	<div id="pagination">
		<p>Displaying <b>#StartRow#-#EndRow#</b> of <b>#TotalRows#</b> results. <cfinclude template="tags/pagination.cfm"></p>
	</div>
	</cfif>
	<!--- End NAVIGATION --->	
	
	<div align="center">
		<cfform action="SearchResults.cfm" method="get">
			<br/>
			<div class="cfHeading">ADVANCED SEARCH</div><br/>
			<input type="radio" name="field" value="SKU" checked>Product ID &nbsp;
			<input type="radio" name="field" value="ItemName">Product Name &nbsp;
			<input type="radio" name="field" value="Price">Price Limit<br>
			<input class="cfFormField" type="text" name="string" size="50"><br><br>
			<input type="hidden" name="start" value="1">
			<input type="submit" name="button" value="Search" class="button" style="width:150px;">
		</cfform>
	</div>
	
	</cfmodule>
</cfoutput>
