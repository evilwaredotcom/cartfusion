<cfscript>
	getCategories = application.Common.getCategories(
		UserID = session.CustomerArray[28],
		SiteID = application.SiteID,
		OnlyMainCategories = 1
	);
</cfscript>
<cfoutput>
<cfmodule template="templates/#application.SiteTemplate#/layout.cfm" currenttab="Products" pagetitle="All Categories">
<!--- Start Breadcrumb --->
<cfmodule template="tags/breadCrumbs.cfm" crumblevel='1' showlinkcrumb="All Categories" />
<!--- End BreadCrumb --->
<cfif getCategories.RecordCount>
	<div id="categoryList">
		<cfloop query="getCategories">
			<div class="thumbnail" align="center">
				<cfif FileExists(#application.ImageServerPath# & '\' & #CatFeaturedDir# & '\' & #CatFeaturedID#)>
					<a href="ProductList.cfm?CatDisplay=#CatID#&start=1"><img src="images/#CatFeaturedDir#/#CatFeaturedID#" align="absmiddle" alt="#CatName#"></a><br/>
				</cfif>
				<a href="ProductList.cfm?CatDisplay=#CatID#&start=1">#CatName#</a>
			</div>
		</cfloop>
	</div>
</cfif>
</cfmodule>
</cfoutput>