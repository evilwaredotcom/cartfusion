<!--- What row to start at? Assume first by default --->
<cfparam name="url.StartRow" default="1" type="numeric">
<cfparam name="url.SortOption" default="SignID" type="string">
<cfparam name="url.SortAscending" default="0" type="numeric">
<cfparam name="form.field" default="ALL" type="string">
<cfparam name="form.string" default="camera" type="string">

<cfscript>
	string = Trim(string);
</cfscript>


<cfif field is "Category">
	<!--- Convert to cfc --->
	<cfscript>
		// Search Categories
		//searchCategories = application.Queries.getCategories();
		// Next N values
		RowsPerPage = 8;
		TotalRows = getProducts.RecordCount;
		EndRow = Min(URL.StartRow + RowsPerPage - 1, TotalRows);
		StartRowNext = EndRow + 1;
		StartRowBack = URL.StartRow - RowsPerPage;
	</cfscript>
	
	
	<cfquery name="GetCategories" datasource="#application.dsn#">
		SELECT 		CatName
		FROM 		categories
		WHERE 		categories.CatName like '%#string#%'
		AND			Hide#session.CustomerArray[28]# != 1
		AND			SiteID = #application.siteConfig.data.SiteID#
		ORDER BY 	CatName
	</cfquery>
</cfif>

<!--- Convert to cfc --->

<cfquery name="getProducts" datasource="#application.dsn#">
	SELECT 	* 
	FROM 	Products 
	WHERE	Hide#session.CustomerArray[28]# != 1
	AND		SiteID = #application.siteConfig.data.SiteID#
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



<cfmodule template="tags/layout.cfm" CurrentTab="Home" PageTitle="Search Results">

<!--- Start Breadcrumb --->
<cfmodule template="tags/breadCrumbs.cfm" CrumbLevel='1' showLinkCrumb="Search Results" />
<!--- End BreadCrumb --->

	<!--- Display Results --->
	<div align="center">
		Your search for <cfoutput><strong>"#string#"</strong> produced <strong>#getProducts.RecordCount#</strong> results...</cfoutput>
		<hr class="snip" />
	</div>

	<!--- <cfinclude template="includes/ProductListDisplay.cfm"> --->



</cfmodule>



<!--- Old Code --->

<!--- <cfscript>
	PageTitle = 'SEARCH RESULTS' ;
	BannerTitle = 'Search' ;
	HideLeftNav = 0 ;
	BreadCrumbs = 13 ;
</cfscript>

<cfinclude template="LayoutGlobalHeader.cfm">

<!--- What row to start at? Assume first by default --->
<cfparam name="URL.StartRow" default="1" type="numeric">
<cfparam name="URL.SortOption" default="SignID" type="string">
<cfparam name="URL.SortAscending" default="0" type="numeric">
<cfparam name="Form.Field" default="ALL" type="string">
<cfparam name="Form.string" default="" type="string">	

<cfscript>
	string = Trim(string);
</cfscript>

<cfif field is "Category">
	<cfquery name="GetCategories" datasource="#application.dsn#">
		SELECT 		CatName
		FROM 		categories
		WHERE 		categories.CatName like '%#string#%'
		AND			Hide#session.CustomerArray[28]# != 1
		AND			SiteID = #config.SiteID#
		ORDER BY 	CatName
	</cfquery>
</cfif>

<cfquery name="getProducts" datasource="#application.dsn#">
	SELECT 	* 
	FROM 	Products 
	WHERE	Hide#session.CustomerArray[28]# != 1
	AND		SiteID = #config.SiteID#
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
 
 <!--- NEXT N VALUES --->
<cfscript>
	RowsPerPage = 8;
	TotalRows = getProducts.RecordCount;
	EndRow = Min(URL.StartRow + RowsPerPage - 1, TotalRows);
 	StartRowNext = EndRow + 1;
 	StartRowBack = URL.StartRow - RowsPerPage;
</cfscript>
 
<table width="90%" border="1" cellspacing="0" cellpadding="0" align="center" bordercolor="<cfoutput>#layout.PrimaryBGColor#</cfoutput>">
  	<tr> 
    	<td valign="top" bordercolor="<cfoutput>#layout.PrimaryBGColor#</cfoutput>"> 
			<!--- Display Results --->
			<div align="center" class="cfMessageThree">
				<img src="images/spacer.gif" height="15" width="1" border="0">
				Your search for <cfoutput><b>"#string#"</b> produced <b>#getProducts.RecordCount#</b> results...</cfoutput>
			</div>
			<hr width="100%" size="1" color="<cfoutput>#layout.TableHeadingBGColor#</cfoutput>" align="center">
			
			<cfinclude template="Includes/ProductListDisplay.cfm">
			
			
			<cfif getProducts.RecordCount>
			<!--- NAVIGATION ------------------------------------->
			<table width="88%" border="0" cellspacing="0" cellpadding="7" align="center">	
				<tr>
					<td class="cfDefault"><cfoutput>Displaying <B>#URL.StartRow#</B> to <B>#EndRow#</B> of <B>#TotalRows#</B> Records</cfoutput></td>
					<td align="right"><cfinclude template="Includes/NextNButtons.cfm"></td>
				</tr>
			</table>
			<!--- NAVIGATION ------------------------------------->
			
			<cfelse>
				<table width="100%" border="0" cellspacing="0" cellpadding="6" align="center">
					<tr> 
						<td align="center" class="cfMessageThree"><b>Sorry... No items matched your query</b></td>
					</tr>
					<tr>
						<td align="center" class="cfDefault">Suggestions:</td>
					</tr>
					<tr> 
						<td class="cfDefault" align="center" width="95%">
							<table><tr><td class="cfDefault">
							<ul>
								<li>Try our Advanced Search below.</li>
								<li>Try typing 408 instead of SI-408</li>
								<li>Try a different spelling or just use the first few letters in the name</li>
							</ul>
							</td></tr></table>
						</td>
					</tr>
				</table>
			</cfif><!---  END <CFIF #getProducts.RecordCount# EQ 0> --->
			<br>
			<div align="center">
			<a href="javascript:history.back()"><img src="images/button-back.gif" border="0"></a> 
			<a href="index.cfm"><img src="images/button-home.gif" border="0"></a><br>
			<br>
			</div>
   		</td> 
  	</tr>
	<tr>
		<td align="center" class="cfDefault" bordercolor="<cfoutput>###layout.TableHeadingBGColor#</cfoutput>">
			<form action="SearchResults.cfm" method="GET">
				<br>
				<div class="cfHeading">ADVANCED SEARCH</div><br>
				<input type="radio" name="field" value="SKU" CHECKED>Product ID &nbsp;
				<input type="radio" name="field" value="ItemName">Product Name &nbsp;
				<input type="radio" name="field" value="Price">Price Limit<br>
				<input class="cfFormField" type="text" name="string" size="50"><br><br>
				<input type="hidden" name="start" value="1">
				<input type="submit" NAME="button" value="Search" class="cfButton" style="width:150px;">
			</form>
		</td>
	</tr>
</table>

<cfinclude template="LayoutGlobalFooter.cfm"> --->