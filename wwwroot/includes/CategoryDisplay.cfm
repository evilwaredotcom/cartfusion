<cfif getCategories.RecordCount>

	<!--- <cfscript>
		if ( isDefined('getCategory') )
			ColsToShow = getCategory.ShowColumns ;
		else
			ColsToShow = 3 ;
	</cfscript> --->

<cfoutput>
	
	<form action="ProductList.cfm" method="get">
	
		<div id="CategoryHeader">Categories</div>
		
			<div id="categoryList">
			
				<cfloop query="getCategories">
					<div class="thumbnail">
					
					<cfif CatFeaturedID EQ ''>	
						<a href="ProductList.cfm?CatDisplay=#CatID#&start=1"><img src="images/image-empty.gif" align="absmiddle" alt="#CatName#"></a>
					<cfelse>
						<cfif FileExists(#application.siteConfig.data.IU_VirtualPathDIR# & '\' & #CatFeaturedDir# & '\' & #CatFeaturedID#)>
							<a href="ProductList.cfm?CatDisplay=#CatID#&start=1"><img src="images/#CatFeaturedDir#/#CatFeaturedID#" align="absmiddle" alt="#CatName#"></a>
						<cfelse>											
							<a href="ProductList.cfm?CatDisplay=#CatID#&start=1"><img src="images/image-empty.gif" align="absmiddle" alt="#CatName#"></a>
						</cfif>
					</cfif>
						<p><input type="checkbox" name="SMC" value="#CatID#">&nbsp; <a href="ProductList.cfm?CatDisplay=#CatID#&start=1">#CatName#</a></p>
					</div>
				</cfloop>
			</div>
			
			<br class="clear" />
			<br />
			<hr />
			<p align="right"><input type="image" src="images/button-ShowMe.gif" alt="Show Me These Categories"></p>
	</form>
</cfoutput>	


</cfif>