<cfif getCategories.RecordCount>

<cfoutput>
	
	<form action="ProductList.cfm" method="get">
		
		<div class="pageSectionHeader">Categories</div>
			<br/>
			<div id="categoryList">
			
				<cfloop query="getCategories">
					<div class="thumbnail">
					
					<cfif CatFeaturedID EQ ''>	
						<a href="ProductList.cfm?CatDisplay=#CatID#&start=1"><img src="images/image-empty.gif" align="absmiddle" alt="#CatName#"></a>
					<cfelse>
						<cfif FileExists(application.ImageServerPath & '\' & CatFeaturedDir & '\' & CatFeaturedID)>
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
			<br/>
			<hr class="snip" />
			<p align="right"><input type="submit" value="Show Me These Categories" class="button2"></p>
	</form>
</cfoutput>	


</cfif>