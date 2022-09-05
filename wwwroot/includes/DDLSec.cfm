<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<cfparam name="SecDisplay" default="">
<cfparam name="CatFilter" default="">
<input type="hidden" name="start" value="1">

<cfif NOT isDefined('SMS')>
	Section: 
	
	<!--- GET SECTIONS --->
	<cfquery name="getSubSections" datasource="#application.dsn#" cachedwithin="#CreateTimeSpan(0,0,10,0)#">
		SELECT 		SectionID, SecName, subSectionOf
		FROM 		Sections
		WHERE		Hide#session.CustomerArray[28]# != 1
		AND			SiteID = #application.SiteID#
		ORDER BY 	DisplayOrder, SecName
	</cfquery>
	
	<!--- GET MAIN SECTIONS (AFTER getSubSections) --->
	<cfquery name="getMainSections" dbtype="query">
		SELECT 	*
		FROM 	getSubSections
		WHERE	(subSectionOf = 0
		OR		 subSectionOf IS NULL)
	</cfquery>
		
	<select name="SecDisplay" class="cfFormField" onchange="this.form.submit();">
	<cfoutput query="getMainSections" group="SectionID">
								
		<cfquery name="getSubSections1" dbtype="query">
			SELECT 	*
			FROM 	getSubSections
			WHERE	subSectionOf = #getMainSections.SectionID#
		</cfquery>
		
		<!--- LEVEL 1 --->
		<option value="#getMainSections.SectionID#" <cfif SectionID EQ SecDisplay > selected </cfif> >*** #UCASE(getMainSections.SecName)# ***</option>
		
		<!--- LEVEL 2 --->
		<cfif getSubSections1.RecordCount GTE 1 >
			<cfloop query="getSubSections1">
				<cfoutput>					
					<option value="#SectionID#" style="color:##000;" <cfif SectionID EQ SecDisplay > selected </cfif> >&nbsp;&nbsp;&nbsp; #SecName#</option>
				</cfoutput>
				
				<cfquery name="getSubSections2" dbtype="query">
					SELECT 	*
					FROM 	getSubSections
					WHERE	subSectionOf = #getSubSections1.SectionID#
				</cfquery>
				
				<!--- LEVEL 3 --->
				<cfif getSubSections2.RecordCount GTE 1 >
					<cfloop query="getSubSections2">
						<cfoutput>					
							<option value="#SectionID#" style="color:##555;" <cfif SectionID EQ SecDisplay > selected </cfif> >&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp; #SecName#</option>
						</cfoutput>
						
						<cfquery name="getSubSections3" dbtype="query">
							SELECT 	*
							FROM 	getSubSections
							WHERE	subSectionOf = #getSubSections2.SectionID#
						</cfquery>
						
						<!--- LEVEL 4 --->
						<cfif getSubSections3.RecordCount GTE 1 >
							<cfloop query="getSubSections3">
								<cfoutput>					
									<option value="#SectionID#" style="color:##999;" <cfif SectionID EQ SecDisplay > selected </cfif> >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp; #SecName#</option>
								</cfoutput>
								
								<cfquery name="getSubSections5" dbtype="query">
									SELECT 	*
									FROM 	getSubSections
									WHERE	subSectionOf = #getSubSections4.SectionID#
								</cfquery>
								
								<!--- LEVEL 5 --->
								<cfif getSubSections5.RecordCount GTE 1 >
									<cfloop query="getSubSections5">
										<cfoutput>					
											<option value="#SectionID#" style="color:##CCC;" <cfif SectionID EQ SecDisplay > selected </cfif> >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp; #SecName#</option>
										</cfoutput>
									</cfloop>
								</cfif>
								
							</cfloop>
						</cfif>
						
					</cfloop>
				</cfif>
				
			</cfloop>
		</cfif>
		
	</cfoutput>
	</select>
</cfif>

<!--- 
	OPTIONAL - FILTER BY CATEGORY
--->

<!---
&nbsp;&nbsp;

Categories:

<!--- CREATE WHERE CLAUSE --->
<cfscript>
	WCCatID = '' ;
	FirstRow = 1 ;
</cfscript>
<cfoutput query="getProducts" group="Category">
	<cfscript>
		if ( FirstRow NEQ 1 AND Category NEQ '' AND Category NEQ 0 )
			WCCatID = WCCatID & ' OR ' ;
		if ( Category NEQ '' AND Category NEQ 0 )
			FirstRow = 0 ;
		if ( Category NEQ '' AND Category NEQ 0 )
			WCCatID = WCCatID & ' CatID = ' & Category ;
	</cfscript>
</cfoutput>

<cfif getProducts.RecordCount NEQ 0 >
	<cfquery name="getCats" datasource="#application.dsn#" cachedwithin="#CreateTimeSpan(0,0,11,0)#">
		SELECT 	CatID, CatName
		FROM 	Categories
		WHERE	Hide#session.CustomerArray[28]# != 1
		AND		SiteID = #application.SiteID#
		<cfif WCCatID NEQ '' >
		AND 	(#WCCatID#)
		</cfif>
		ORDER BY DisplayOrder, CatName
	</cfquery>

	<select name="CatFilter" class="cfFormField" onChange="this.form.submit();">
		<option value="">--- ALL ---</option>
		<cfoutput query="getCats" group="CatName">
			<option value="#CatID#" <cfif CatID EQ CatFilter > selected </cfif> >#CatName#</option>
		</cfoutput>
	</select>	
<cfelse>
	<select name="CatFilter" class="cfFormField" onChange="this.form.submit();">
		<option value="">--- ALL ---</option>
	</select>
</cfif>
--->