<cfif getSections.RecordCount>

<cfoutput>
	
	<form action="ProductList.cfm" method="get">
		
		<div class="pageSectionHeader">Sections</div>
			<br/>
			<div id="categoryList">
			
				<cfloop query="getSections">
					<div class="thumbnail">
					
					<cfif SecFeaturedID EQ ''>	
						<a href="ProductList.cfm?SecDisplay=#SectionID#&start=1"><img src="images/image-empty.gif" align="absmiddle" alt="#SecName#"></a>
					<cfelse>
						<cfif FileExists(application.ImageServerPath & '\' & SecFeaturedDir & '\' & SecFeaturedID)>
							<a href="ProductList.cfm?SecDisplay=#SectionID#&start=1"><img src="images/#SecFeaturedDir#/#SecFeaturedID#" align="absmiddle" alt="#SecName#"></a>
						<cfelse>											
							<a href="ProductList.cfm?SecDisplay=#SectionID#&start=1"><img src="images/image-empty.gif" align="absmiddle" alt="#SecName#"></a>
						</cfif>
					</cfif>
						<p><input type="checkbox" name="SMS" value="#SectionID#">&nbsp; <a href="ProductList.cfm?SecDisplay=#SectionID#&start=1">#SecName#</a></p>
					</div>
				</cfloop>
			</div>
			
			<br class="clear" />
			<br/>
			<hr class="snip" />
			<p align="right"><input type="submit" value="Show Me These Sections" class="button2"></p>
	</form>
</cfoutput>	


</cfif>