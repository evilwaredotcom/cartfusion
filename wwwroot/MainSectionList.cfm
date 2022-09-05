<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<cfscript>
	getSections = application.Common.getSections(
		UserID=session.CustomerArray[28], 
		SiteID=application.SiteID, 
		OnlyMainSections=1);
</cfscript>


<cfif getSections.RecordCount>



</cfif>



<!--- Old Code --->

<!--- GET MAIN SECTIONS --->
<!--- <cfinvoke component="#application.Common#" method="getSections" returnvariable="getSections">
	<cfinvokeargument name="UserID" value="#session.CustomerArray[28]#">
	<cfinvokeargument name="SiteID" value="#application.SiteID#">
	<cfinvokeargument name="OnlyMainSections" value="1">
</cfinvoke>

<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">
	<tr> 
		<td width="100%" valign="top">  
			<table width="100%" border="0" cellpadding="7" cellspacing="0">
			<cfif getSections.RecordCount NEQ 0>				
				<!--- BEGIN COLUMNAR OUTPUT --->
				<tr>
				<cfoutput query="getSections">
					<td class="cfDefault" width="50%" valign="middle" align="center"> 
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td align="center" valign="middle" class="cfDefault"> 
									<cfif SecFeaturedID EQ ''>	
										<a href="ProductList.cfm?SecDisplay=#SectionID#&start=1">#SecName#</a>
									<cfelseif FileExists(#application.ImageServerPath# & '\' & #SecFeaturedDir# & '\' & #SecFeaturedID#)>
										<a href="ProductList.cfm?SecDisplay=#SectionID#&start=1"><img src="images/#SecFeaturedDir#/#SecFeaturedID#" BORDER="0" align="absmiddle" alt="#SecName#"></a><br>
										<a href="ProductList.cfm?SecDisplay=#SectionID#&start=1">#SecName#</a>
									<cfelse>
										<a href="ProductList.cfm?SecDisplay=#SectionID#&start=1">#SecName#</a>
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