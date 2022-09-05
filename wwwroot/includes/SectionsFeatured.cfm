<!--- GET FEATURED SECTIONS --->
<cfscript>
	getFeaturedSections = application.Common.getFeaturedSections(SiteID=application.SiteID);
</cfscript>



<cfoutput>
	
	<cfif getFeaturedSections.RecordCount>
	
		<h3>Featured Sections</h3>
		
		<cfloop query="getFeaturedSections">
			<div class="featuredItem">
				<a href="ProductList.cfm?SecDisplay=#SectionID#"><img src="#application.ImagePath#/#SecFeaturedDir#/#SecFeaturedID#" width="75" alt="#SecName#" /></a>
				<p><strong>#SecName#</strong><br/><br/>
					#Left(TRIM(SecDescription),80)#... <a href="ProductList.cfm?SecDisplay=#SectionID#">&lt;more&gt;</a><br/>
					<a href="ProductList.cfm?SecDisplay=#SectionID#"><img src="images/button-FeaturedProductGO.gif" alt="#SecName#" /></a>
			</div>
		</cfloop>

	</cfif>
	
</cfoutput>

