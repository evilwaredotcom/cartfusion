<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<cfparam name="EntryValue" default="">

<cfinvoke component="#application.Queries#" method="getSites" returnvariable="getSites"></cfinvoke>

<!--- GET CATEGORIES --->
<cfquery name="getAllCategories" datasource="#application.dsn#" cachedwithin="#CreateTimeSpan(0,0,0,30)#">
	SELECT 		SiteID, CatID, CatName, SubCategoryOf
	FROM 		Categories
	ORDER BY 	CatName
</cfquery>
		
<cfoutput query="getSites">

	<!--- GET MAIN CATEGORIES (AFTER getAllCategories) --->
	<cfquery name="getAllMainCategories" dbtype="query">
		SELECT 	*
		FROM 	getAllCategories
		WHERE	(SubCategoryOf = 0
		OR		 SubCategoryOf IS NULL)
		AND		SiteID = #getSites.SiteID#
	</cfquery>
	
	<!--- LEVEL 1 --->
	<option value="" <cfif EntryValue EQ '' > selected </cfif> >#getSites.SiteID#: MAIN CATEGORY/NONE</option>

	<cfloop query="getAllMainCategories">
									
		<cfquery name="getAllCategories1" dbtype="query">
			SELECT 	*
			FROM 	getAllCategories
			WHERE	SubCategoryOf = #getAllMainCategories.CatID#
		</cfquery>
		
		<!--- LEVEL 2 --->
		<option value="#getAllMainCategories.CatID#" style="color:014589;" <cfif getAllMainCategories.CatID EQ EntryValue > selected </cfif> >&nbsp;&nbsp;&nbsp;#UCASE(getAllMainCategories.CatName)#</option>
		
		<!--- LEVEL 3 --->
		<cfif getAllCategories1.RecordCount GTE 1 >
			<cfloop query="getAllCategories1">
				<option value="#getAllCategories1.CatID#" style="color:000000;" <cfif getAllCategories1.CatID EQ EntryValue > selected </cfif> >&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp; #CatName#</option>
				
				<cfquery name="getAllCategories2" dbtype="query">
					SELECT 	*
					FROM 	getAllCategories
					WHERE	SubCategoryOf = #getAllCategories1.CatID#
				</cfquery>
				
				<!--- LEVEL 4 --->
				<cfif getAllCategories2.RecordCount GTE 1 >
					<cfloop query="getAllCategories2">
						<option value="#getAllCategories2.CatID#" style="color:555555;" <cfif getAllCategories2.CatID EQ EntryValue > selected </cfif> >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp; #CatName#</option>
						
						<cfquery name="getAllCategories3" dbtype="query">
							SELECT 	*
							FROM 	getAllCategories
							WHERE	SubCategoryOf = #getAllCategories2.CatID#
						</cfquery>
						
						<!--- LEVEL 5 --->
						<cfif getAllCategories3.RecordCount GTE 1 >
							<cfloop query="getAllCategories3">
								<option value="#getAllCategories3.CatID#" style="color:999999;" <cfif getAllCategories3.CatID EQ EntryValue > selected </cfif> >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp; #CatName#</option>
								
								<cfquery name="getAllCategories4" dbtype="query">
									SELECT 	*
									FROM 	getAllCategories
									WHERE	SubCategoryOf = #getAllCategories2.CatID#
								</cfquery>
								
								<!--- LEVEL 6 --->
								<cfif getAllCategories4.RecordCount GTE 1 >
									<cfloop query="getAllCategories4">
										<option value="#getAllCategories4.CatID#" style="color:CCCCCC;" <cfif getAllCategories4.CatID EQ EntryValue > selected </cfif> >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp; #CatName#</option>
									</cfloop>
								</cfif>
								
							</cfloop>
						</cfif>
						
					</cfloop>
				</cfif>
				
			</cfloop>
		</cfif>
		
	</cfloop>
</cfoutput>