<!--- GET FEATURED PRODUCTS --->
<cfscript>
	getFeaturedProducts = application.Queries.getFeaturedProducts(SiteID=application.siteConfig.data.SiteID,Price=session.CustomerArray[28]);
</cfscript>

<!--- <cfquery name="getFeaturedProducts" datasource="#application.dsn#">
	SELECT	ItemID, SKU, ItemName, ShortDescription, ImageSmall, ImageDir, Price#session.CustomerArray[28]#
	FROM	Products
	WHERE	Featured = 1
	AND		SiteID = #application.siteConfig.data.SiteID#
	ORDER BY DisplayOrder, SKU
</cfquery> --->

<cfoutput>
	
	<cfif getFeaturedProducts.RecordCount>
	
		<h3>Featured Products</h3>
		
		<cfloop query="getFeaturedProducts">
			<div class="featuredItem">
				<a href="ProductDetail.cfm?ItemID=#ItemID#"><img src="#application.siteConfig.data.ImagePathURL#/#ImageDir#/#ImageSmall#" width="75" alt="#ItemName#" /></a>
				<p><strong>#ItemName#</strong><br />
					#Left(TRIM(ShortDescription),80)#... <a href="ProductDetail.cfm?ItemID=#ItemID#">&lt;more&gt;</a><br />
					<a href="ProductDetail.cfm?ItemID=#ItemID#"><img src="images/button-FeaturedProductGO.gif" alt="#ItemName#" /></a></p>
			</div>
		</cfloop>

	</cfif>
	
</cfoutput>
