<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<cfparam name="EntryValue" default="">

<cfinvoke component="#application.Queries#" method="getSites" returnvariable="getSites"></cfinvoke>

<!--- GET Sections --->
<cfquery name="getAllSections" datasource="#application.dsn#" cachedwithin="#CreateTimeSpan(0,0,0,5)#">
	SELECT 		SiteID, SectionID, SecName, SubSectionOf
	FROM 		Sections
	ORDER BY 	SecName
</cfquery>
		
<cfoutput query="getSites">
	
	<!--- GET MAIN Sections (AFTER getAllSections) --->
	<cfquery name="getAllMainSections" dbtype="query">
		SELECT 	*
		FROM 	getAllSections
		WHERE	(SubSectionOf = 0
		OR		 SubSectionOf IS NULL)
		AND		SiteID = #getSites.SiteID#
	</cfquery>

	<!--- LEVEL 1 --->
	<option value="" <cfif EntryValue EQ '' > selected </cfif> >#getSites.SiteID#: MAIN SECTION/NONE</option>

	<cfloop query="getAllMainSections">
									
		<cfquery name="getAllSections1" dbtype="query">
			SELECT 	*
			FROM 	getAllSections
			WHERE	SubSectionOf = #getAllMainSections.SectionID#
		</cfquery>
		
		<!--- LEVEL 2 --->
		<option value="#getAllMainSections.SectionID#" style="color:014589;" <cfif getAllMainSections.SectionID EQ EntryValue > selected </cfif> >&nbsp;&nbsp;&nbsp;#UCASE(getAllMainSections.SecName)#</option>
		
		<!--- LEVEL 3 --->
		<cfif getAllSections1.RecordCount GTE 1 >
			<cfloop query="getAllSections1">
				<option value="#getAllSections1.SectionID#" style="color:000000;" <cfif getAllSections1.SectionID EQ EntryValue > selected </cfif> >&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp; #SecName#</option>
				
				<cfquery name="getAllSections2" dbtype="query">
					SELECT 	*
					FROM 	getAllSections
					WHERE	SubSectionOf = #getAllSections1.SectionID#
				</cfquery>
				
				<!--- LEVEL 4 --->
				<cfif getAllSections2.RecordCount GTE 1 >
					<cfloop query="getAllSections2">
						<option value="#getAllSections2.SectionID#" style="color:555555;" <cfif getAllSections2.SectionID EQ EntryValue > selected </cfif> >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp; #SecName#</option>
						
						<cfquery name="getAllSections3" dbtype="query">
							SELECT 	*
							FROM 	getAllSections
							WHERE	SubSectionOf = #getAllSections2.SectionID#
						</cfquery>
						
						<!--- LEVEL 5 --->
						<cfif getAllSections3.RecordCount GTE 1 >
							<cfloop query="getAllSections3">
								<option value="#getAllSections3.SectionID#" style="color:999999;" <cfif getAllSections3.SectionID EQ EntryValue > selected </cfif> >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp; #SecName#</option>
								
								<cfquery name="getAllSections4" dbtype="query">
									SELECT 	*
									FROM 	getAllSections
									WHERE	SubSectionOf = #getAllSections2.SectionID#
								</cfquery>
								
								<!--- LEVEL 6 --->
								<cfif getAllSections4.RecordCount GTE 1 >
									<cfloop query="getAllSections4">
										<option value="#getAllSections4.SectionID#" style="color:CCCCCC;" <cfif getAllSections4.SectionID EQ EntryValue > selected </cfif> >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp; #SecName#</option>
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