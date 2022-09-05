<!--- NEXT N VARIABLES: What row to start at? Assume first by default --->
<cfparam name="url.StartRow" default="1" type="numeric">
<cfparam name="url.SortOption" default="SKU" type="string">
<cfparam name="url.SortAscending" default="1" type="numeric">
<cfparam name="url.Field" default="ALL" type="string">
<cfparam name="url.String" default="" type="string">
<cfset String = Trim(string)>

<cfparam name="PageTitle" default="">

<!--- QUERY Products --->
<cfinvoke component="#application.Common#" method="getAllProducts" returnvariable="getProducts">
	<cfinvokeargument name="UserID" value="#session.CustomerArray[28]#">
	<cfinvokeargument name="SiteID" value="#application.SiteID#">
	
	<cfif structKeyExists(url, 'CatDisplay') AND url.CatDisplay NEQ ''>
		<cfinvokeargument name="CatDisplay" value="#url.CatDisplay#">
	<cfelseif structKeyExists(url, 'SecDisplay') AND url.SecDisplay NEQ ''>
		<cfinvokeargument name="SecDisplay" value="#url.SecDisplay#">
	</cfif>
	<cfif structKeyExists(url, 'CatFilter') AND url.CatFilter NEQ ''>
		<cfinvokeargument name="CatFilter" value="#url.CatFilter#">
	<cfelseif structKeyExists(url, 'SecFilter') AND url.SecFilter NEQ ''>
		<cfinvokeargument name="SecFilter" value="#url.SecFilter#">
	</cfif>
	<cfif isDefined('SMC') AND SMC NEQ ''>
		<cfinvokeargument name="SMC" value="#SMC#">
	<cfelseif isDefined('SMS') AND SMS NEQ ''>
		<cfinvokeargument name="SMS" value="#SMS#">
	</cfif>
	<cfinvokeargument name="SortOption" value="#url.SortOption#">
	<cfinvokeargument name="SortAscending" value="#url.SortAscending#">	
</cfinvoke>

<cfscript>
	if( structKeyExists(url, 'CatDisplay'))	{
		// Get Category Detail
		getCategory = application.common.getCategoryDetail(CatID=url.CatDisplay);
		// Get Categories
		getCategories = application.Common.getCategories(
			UserID=session.CustomerArray[28], 
			SiteID=application.SiteID, 
			CatID=url.CatDisplay);
	}
	
	// If CatDisplay has been passed
	if( structKeyExists(url, 'CatDisplay'))	{
		myCrumb = 'Category Display';
	}
	else	{
		myCrumb = 'Product List';
	}
	
	// If Cat Name is defined
	if ( isDefined('getCategory.CatName') and getCategory.CatName NEQ '' )	{
		PageTitle = getCategory.CatName;
	}
	else if ( isDefined('getSection.SecName') AND getSection.SecName NEQ '' )	{
		PageTitle = getSection.SecName;
	}
	else	{
		PageTitle = 'Product List';
	}
		
		
	
	// if SecDisplay exists
	if( structKeyExists(url, 'SecDisplay'))	{
		// BreadCrumbs = 10;
		// Get Section Details
		getSection = application.Common.getSectionDetail(SectionID=url.SecDisplay);
		// Get Sections
		getSections = application.Common.getSections(
			UserID=session.CustomerArray[28], 
			SiteID=application.SiteID, 
			SectionID=url.SecDisplay);
	}
	
	// SMC
	if( isDefined('SMC') AND SMC NEQ '')	{
		BreadCrumbs = 18;
		getCategory = application.Common.getTheseCategories(smc='#smc#');
	}
	
	// SMS
	if( isDefined('SMS') AND SMS NEQ '')	{
		BreadCrumbs = 19;
		getSection = application.Common.getTheseSections(sms='#sms#');
	}
	
	// NEXT N VALUES AND RESULTS PER PAGE VALUES
	if ( isDefined('getCategory') )	{
	if ( NOT isDefined('url.ShowRows') )	{
		url.ShowRows = getCategory.ShowColumns * getCategory.ShowRows ;
		Rows1 = url.ShowRows / getCategory.ShowColumns * getCategory.ShowRows ;
	}
	else
		Rows1 = getCategory.ShowColumns * getCategory.ShowRows ;
	}
	else if ( isDefined('getSection') )	{
		if ( not isDefined('url.ShowRows') )
		{
			url.ShowRows = getSection.ShowColumns * getSection.ShowRows ;
			Rows1 = url.ShowRows / getSection.ShowColumns * getSection.ShowRows ;
		}
		else
			Rows1 = getSection.ShowColumns * getSection.ShowRows ;
	}
	else
	{
		if ( NOT isDefined('url.ShowRows') )
		{
			url.ShowRows = 20 ;
			Rows1 = url.ShowRows ;
		}
		else
			Rows1 = url.ShowRows ;
	}

	RowsPerPage = url.ShowRows;
	TotalRows = getProducts.RecordCount;
	EndRow = Min(url.StartRow + RowsPerPage - 1, TotalRows);
	StartRowNext = EndRow + 1;
	StartRowBack = url.StartRow - RowsPerPage;
</cfscript>

<cfoutput>
<cfmodule template="templates/#application.SiteTemplate#/layout.cfm" pagetitle="#PageTitle#" currenttab="Products">

<!--- Start Breadcrumb --->
<cfmodule template="tags/breadCrumbs.cfm" crumblevel='2' showlinkcrumb="#myCrumb#" />
<!--- End BreadCrumb --->


	<!--- CATEGORY IMAGE & DESCRIPTION --->
	<cfif structKeyExists(url, 'CatDisplay') >
		
		<cfloop query="getCategory">
			<cfif CatImage NEQ '' AND CatImageDir NEQ ''>
				<img src="images/#CatImageDir#/#CatImage#" align="absmiddle" hspace="15" class="left">
			</cfif>
				
				<h3 align="center">#CatName#</h3>
				
				<cfif CatDescription neq ''>
					<p>#CatDescription#</p>
				</cfif>
		</cfloop>
	</cfif>
	
	
	<!--- SECTION IMAGE & DESCRIPTION --->
	<cfif structKeyExists(url, 'SecDisplay') >

		<cfloop query="getSection">
			<cfif SecImage NEQ '' AND SecImageDir NEQ ''>
				<img src="images/#SecImageDir#/#SecImage#" border="0" align="absmiddle" hspace="15" class="left">
			</cfif>

				<h3 align="center">#SecName#</h3>
					<cfif SecDescription NEQ ''>
						<p>#SecDescription#</p>
					</cfif>
		</cfloop>
	</cfif>
	
	<!--- SHOW ME CATEGORIES LIST --->
	<cfif isDefined('SMC') AND SMC NEQ '' >
	<div align="center"><b>Showing:</b>&nbsp;
	
			<cfloop list="#SMC#" index="i" delimiters=",">
				<cfquery name="getCatName" datasource="#application.dsn#">
					SELECT 		CatName 
					FROM 		Categories
					WHERE		CatID = #i#
					ORDER BY 	CatName
				</cfquery>
				#getCatName.CatName# &nbsp;
			</cfloop>
		</div>
	<br/>
	</cfif>
	
	<!--- SHOW ME SECTIONS LIST --->
	<cfif isDefined('SMS') AND SMS NEQ '' >
	<div align="center"><b>Showing:</b>&nbsp;
	
			<cfloop list="#SMS#" index="i" delimiters=","> 
				<cfquery name="getSecName" datasource="#application.dsn#">
					SELECT 		SecName 
					FROM 		Sections
					WHERE		SectionID = #i#
					ORDER BY 	SecName
				</cfquery>
				#getSecName.SecName# &nbsp;
			</cfloop>
		</div>
		<br/>
	</cfif>
	
	<!--- DROP DOWN MENUS --->
	<div align="center">
	
	<cfform action="ProductList.cfm" method="get">
		
		<cfif structKeyExists(url, 'CatDisplay') OR ( isDefined('SMC') AND SMC NEQ '' )>
			<cfinclude template="Includes/DDLCat.cfm">
			<cfif isDefined('SMC') AND SMC NEQ '' >
				<input type="hidden" name="SMC" value="#SMC#" >
			</cfif>
		
		<cfelseif structKeyExists(url, 'SecDisplay') OR ( isDefined('SMS') AND SMS NEQ '' )>
			<cfinclude template="Includes/DDLSec.cfm">
			<cfif isDefined('SMS') AND SMS NEQ '' >
				<input type="hidden" name="SMS" value="#SMS#" >
			</cfif>
		</cfif>
		&nbsp;&nbsp;
		Results Per Page: 
		<select name="ShowRows" class="cfFormField" onchange="this.form.submit();">
			
			<option value="#Rows1#" <cfif url.ShowRows EQ Rows1 >selected</cfif>>#Rows1#</option>
			<option value="#(Rows1 * 2)#" <cfif url.ShowRows EQ (Rows1 * 2)>selected</cfif>>#(Rows1 * 2)#</option>
			<option value="#(Rows1 * 4)#" <cfif url.ShowRows EQ (Rows1 * 4)>selected</cfif>>#(Rows1 * 4)#</option>
			<option value="#(Rows1 * 100)#" <cfif url.ShowRows EQ (Rows1 * 100)>selected</cfif>>ALL</option>
			
		</select>
		&nbsp;&nbsp;
		<input type="submit" value="GO" align="absmiddle" class="button" style="width:27px;">
		</cfform>
	</div>
	<br/>
	
	
	<!--- PRODUCT LIST --->
		<cfinclude template="tags/productList.cfm">
	
	<!--- SUB-CATEGORIES --->
	<cfif isDefined('getCategories') AND getCategories.RecordCount>
		<cfinclude template="includes/CategoryDisplay.cfm">
	</cfif>
	
	<!--- SUB-SECTIONS --->
	<cfif isDefined('getSections') AND getSections.RecordCount>
		<cfinclude template="Includes/SectionDisplay.cfm">
	</cfif>

	<!--- Pagination --->
	<cfif TotalRows GT 0 >		
		<div id="pagination">
			<p>Displaying <b>#StartRow#-#EndRow#</b> of <b>#TotalRows#</b> results. <cfinclude template="tags/pagination.cfm"></p>
		</div>
	</cfif>


</cfmodule>
</cfoutput>