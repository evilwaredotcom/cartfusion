<!--- GET FEATURED CATEGORIES --->

<!--- TODO: Convert to CFC - Carl Vanderpal - 19 May 2007 --->
<cfquery name="getFeaturedCategories" datasource="#application.dsn#">
	SELECT	CatID, CatName, CatDescription, CatFeaturedID, CatFeaturedDir
	FROM	Categories
	WHERE	Featured = 1
	AND		SiteID = #application.siteConfig.data.SiteID#
	ORDER BY DisplayOrder
</cfquery>


<cfoutput>

	<cfif getFeaturedCategories.RecordCount>

		<h3>Featured Categories</h3>
		
		<cfloop query="getFeaturedCategories">
			<div class="featuredItem">
				<a href="ProductList.cfm?CatDisplay=#CatID#"><img src="#application.siteConfig.data.ImagePathURL#/#CatFeaturedDir#/#CatFeaturedID#" width="75" alt="#CatName#" /></a>
				<!--- CARTFUSION --->
				<p><strong>#CatName#</strong><br /> #Left(TRIM(CatDescription),80)#... <a href="ProductList.cfm?CatDisplay=#CatID#">&lt;more&gt;</a><br />
				<a href="ProductList.cfm?CatDisplay=#CatID#"><img src="images/button-FeaturedProductGO.gif" alt="#CatName#" title="#CatName#" /></a></p>
			</div>
		</cfloop>
	
	</cfif>
	
</cfoutput>
