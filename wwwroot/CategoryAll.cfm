<cfscript>
	getCategories = application.Common.getCategories(
		UserID=session.CustomerArray[28],
		SiteID=application.siteConfig.data.SiteID,
		OnlyMainCategories=1);
</cfscript>

<cfoutput>

<cfmodule template="tags/layout.cfm" CurrentTab="Products" PageTitle="All Categories">

<!--- Start Breadcrumb --->
<cfmodule template="tags/breadCrumbs.cfm" CrumbLevel='1' showLinkCrumb="All Categories" />
<!--- End BreadCrumb --->

<cfif getCategories.RecordCount>

	<div id="categoryList">
		<cfloop query="getCategories">
			<div class="thumbnail" align="center">
			
				
				<cfif FileExists(#application.siteConfig.data.IU_VirtualPathDIR# & '\' & #CatFeaturedDir# & '\' & #CatFeaturedID#)>
					<a href="ProductList.cfm?CatDisplay=#CatID#&start=1"><img src="images/#CatFeaturedDir#/#CatFeaturedID#" align="absmiddle" alt="#CatName#"></a><br>
					<a href="ProductList.cfm?CatDisplay=#CatID#&start=1">#CatName#</a>
				<cfelse>
					<a href="ProductList.cfm?CatDisplay=#CatID#&start=1"><img src="images/image-Empty.gif" /><br />#CatName#</a>
				</cfif>
				
				<!--- <cfif CatFeaturedID eq ''>	
					<a href="ProductList.cfm?CatDisplay=#CatID#&start=1">#CatName#</a>
				<cfelseif FileExists(#application.siteConfig.data.IU_VirtualPathDIR# & '\' & #CatFeaturedDir# & '\' & #CatFeaturedID#)>
					<a href="ProductList.cfm?CatDisplay=#CatID#&start=1"><img src="images/#CatFeaturedDir#/#CatFeaturedID#" align="absmiddle" alt="#CatName#"></a><br>
					<a href="ProductList.cfm?CatDisplay=#CatID#&start=1">#CatName#</a>
				<cfelse>
					<a href="ProductList.cfm?CatDisplay=#CatID#&start=1">#CatName#</a>
				</cfif> --->
			</div>
		</cfloop>
	</div>
	
</cfif>

</cfmodule>
</cfoutput>
