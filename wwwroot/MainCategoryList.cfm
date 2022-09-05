


<cfscript>
	getCategories = application.Common.getCategories(
		UserID=session.CustomerArray[28],
		SiteID=application.SiteID,
		OnlyMainCategories=1);
</cfscript>

<cfloop query="getCategories">
	#CatID#<br/>
</cfloop>










<!--- Old Code --->

<!--- <!--- GET MAIN CATEGORIES --->
<cfinvoke component="#application.Common#" method="getCategories" returnvariable="getCategories">
	<cfinvokeargument name="UserID" value="#session.CustomerArray[28]#">
	<cfinvokeargument name="SiteID" value="#application.SiteID#">
	<cfinvokeargument name="OnlyMainCategories" value="1">
</cfinvoke>

<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">
	<tr> 
		<td width="100%" valign="top">  
			<table width="100%" border="0" cellpadding="7" cellspacing="0">
			<cfif getCategories.RecordCount NEQ 0>
				<!--- BEGIN COLUMNAR OUTPUT --->
				<tr>
				<cfoutput query="getCategories">
					<td class="cfDefault" width="50%" valign="middle" align="center"> 
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td align="center" valign="middle" class="cfDefault"> 
									<cfif CatFeaturedID EQ ''>	
										<a href="ProductList.cfm?CatDisplay=#CatID#&start=1">#CatName#</a>
									<cfelseif FileExists(#application.ImageServerPath# & '\' & #CatFeaturedDir# & '\' & #CatFeaturedID#)>
										<a href="ProductList.cfm?CatDisplay=#CatID#&start=1"><img src="images/#CatFeaturedDir#/#CatFeaturedID#" BORDER="0" align="absmiddle" alt="#CatName#"></a><br>
										<a href="ProductList.cfm?CatDisplay=#CatID#&start=1">#CatName#</a>
									<cfelse>
										<a href="ProductList.cfm?CatDisplay=#CatID#&start=1">#CatName#</a>
									</cfif>
								</td>
							</tr>
						</table>
					</td>
				
				<cfif CurrentRow NEQ RecordCount AND NOT CurrentRow MOD 2 >
				</tr>
				<tr>
				</cfif>
				
				</cfoutput>
				</tr>
			</cfif>
			</table>
			<br><br>
		</td>

	</tr>
</table> --->