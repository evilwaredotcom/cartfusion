<cfif getCategories.RecordCount>
<!--- <cfif getSections.RecordCount NEQ 0> --->
	
	<cfscript>
		if ( isDefined('getSection') )
			ColsToShow = getSection.ShowColumns ;
		else
			ColsToShow = 3 ;
	</cfscript>
	
	<form action="ProductList.cfm" method="get">
	<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center" class="cart">
		<tr>
			<th>Sections</th>
		</tr>
	</table>

	<table width="98%" border="0" cellpadding="3" cellspacing="0" align="center">
	
		<!--- BEGIN COLUMNAR OUTPUT --->
		<tr><!--- bgcolor="#Iif(((CurrentRow MOD 2) is 0),de('Gainsboro'),"application.siteConfig.data.standardbgcolor")#"--->
		
		<cfoutput query="getSections">
			<td class="cfDefault" width="#Val(100 / ColsToShow)#%" valign="middle" align="center"> 
				<table border="0" width="100%" cellpadding="3" cellspacing="0">
					<tr>
						<td class="cfDefault" valign="middle" align="center">
							<cfif SecFeaturedID EQ ''>	
								<a href="ProductList.cfm?SecDisplay=#SectionID#&start=1"><img src="images/image-empty.gif" BORDER="0" align="absmiddle" alt="#SecName#"></a>
							<cfelse>
								<cfif FileExists(#application.siteConfig.data.IU_VirtualPathDIR# & '\' & #SecFeaturedDir# & '\' & #SecFeaturedID#)>
									<a href="ProductList.cfm?SecDisplay=#SectionID#&start=1"><img src="images/#SecFeaturedDir#/#SecFeaturedID#" BORDER="0" align="absmiddle" alt="#SecName#"></a>
								<cfelse>											
									<a href="ProductList.cfm?SecDisplay=#SectionID#&start=1"><img src="images/image-empty.gif" BORDER="0" align="absmiddle" alt="#SecName#"></a>
								</cfif>
							</cfif>
						</td>
					</tr>
					<tr>
						<td class="cfDefault" valign="middle" align="center">
							 <input type="checkbox" name="SMC" value="#SectionID#">&nbsp; <a href="ProductList.cfm?SecDisplay=#SectionID#&start=1">#SecName#</a>
						</td>
					</tr>
				</table>
			</td>
			
		<cfif CurrentRow NEQ RecordCount AND NOT CurrentRow MOD #ColsToShow# >
		</tr>
		<tr>
		</cfif>
			
		</cfoutput>
		</tr>
	</table>

	<table width="98%" border="0" cellpadding="0" cellspacing="0" align="center">
		<tr><td><hr width="100%" size="1" color="<cfoutput>#layout.TableHeadingBGColor#</cfoutput>" ></td></tr>
		<tr><td align="right"><input type="image" src="images/button-ShowMe.gif" alt="Show Me These Sections"></td></tr>
	</table>
	</form>

</cfif>