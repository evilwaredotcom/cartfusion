<!--- GET FEATURED CATEGORIES --->
<cfscript>
	getFeaturedCategories = application.Common.getFeaturedCategories(SiteID=application.SiteID);
</cfscript>
<!--- DISPLAY FEATURED CATEGORIES --->
<cfoutput>
<cfif getFeaturedCategories.RecordCount>
	<h3>Featured Categories</h3>
	<cfloop query="getFeaturedCategories">
		<div class="featuredItem">
			<a href="ProductList.cfm?CatDisplay=#CatID#"><img src="#application.ImagePath#/#CatFeaturedDir#/#CatFeaturedID#" width="75" alt="#CatName#" /></a>
			<p><strong>#CatName#</strong><br/> #Left(TRIM(CatDescription),80)#... <a href="ProductList.cfm?CatDisplay=#CatID#">&lt;more&gt;</a></p>
			<p><a href="ProductList.cfm?CatDisplay=#CatID#" alt="#CatName#" title="#CatName#">See and compare #CatName#</a></p>
		</div>
	</cfloop>
</cfif>
</cfoutput>