<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<cfparam name="CatDisplay" default="">
<cfparam name="SecFilter" default="">
<input type="hidden" name="start" value="1">

<cfif NOT isDefined('SMC')>
	Category: 
	
	<!--- GET CATEGORIES --->
	<cfquery name="getSubCategories" datasource="#application.dsn#" cachedwithin="#CreateTimeSpan(0,0,10,0)#">
		SELECT 		CatID, CatName, subCategoryOf
		FROM 		Categories
		WHERE		Hide#session.CustomerArray[28]# != 1
		AND			SiteID = #application.SiteID#
		ORDER BY 	DisplayOrder, CatName
	</cfquery>
	
	<!--- GET MAIN CATEGORIES (AFTER getSubCategories) --->
	<cfquery name="getMainCategories" dbtype="query">
		SELECT 	*
		FROM 	getSubCategories
		WHERE	(subCategoryOf = 0
		OR		 subCategoryOf IS NULL)
	</cfquery>
		
	<select name="CatDisplay" class="cfFormField" onchange="this.form.submit();">
	<cfoutput query="getMainCategories" group="CatID">
								
		<cfquery name="getSubCategories1" dbtype="query">
			SELECT 	*
			FROM 	getSubCategories
			WHERE	subCategoryOf = #getMainCategories.CatID#
		</cfquery>
		
		<!--- LEVEL 1 --->
		<option value="#getMainCategories.CatID#" <cfif CatID EQ CatDisplay > selected </cfif> >*** #UCASE(getMainCategories.CatName)# ***</option>
		
		<!--- LEVEL 2 --->
		<cfif getSubCategories1.RecordCount GTE 1 >
			<cfloop query="getSubCategories1">
				<cfoutput>					
					<option value="#CatID#" style="color:##000;" <cfif CatID EQ CatDisplay > selected </cfif> >&nbsp;&nbsp;&nbsp; #CatName#</option>
				</cfoutput>
				
				<cfquery name="getSubCategories2" dbtype="query">
					SELECT 	*
					FROM 	getSubCategories
					WHERE	subCategoryOf = #getSubCategories1.CatID#
				</cfquery>
				
				<!--- LEVEL 3 --->
				<cfif getSubCategories2.RecordCount GTE 1 >
					<cfloop query="getSubCategories2">
						<cfoutput>					
							<option value="#CatID#" style="color:##555;" <cfif CatID EQ CatDisplay > selected </cfif> >&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp; #CatName#</option>
						</cfoutput>
						
						<cfquery name="getSubCategories3" dbtype="query">
							SELECT 	*
							FROM 	getSubCategories
							WHERE	subCategoryOf = #getSubCategories2.CatID#
						</cfquery>
						
						<!--- LEVEL 4 --->
						<cfif getSubCategories3.RecordCount GTE 1 >
							<cfloop query="getSubCategories3">
								<cfoutput>					
									<option value="#CatID#" style="color:##999;" <cfif CatID EQ CatDisplay > selected </cfif> >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp; #CatName#</option>
								</cfoutput>
								
								<cfquery name="getSubCategories4" dbtype="query">
									SELECT 	*
									FROM 	getSubCategories
									WHERE	subCategoryOf = #getSubCategories3.CatID#
								</cfquery>
								
								<!--- LEVEL 5 --->
								<cfif getSubCategories4.RecordCount GTE 1 >
									<cfloop query="getSubCategories4">
										<cfoutput>					
											<option value="#CatID#" style="color:##CCC;" <cfif CatID EQ CatDisplay > selected </cfif> >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp; #CatName#</option>
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
	OPTIONAL - FILTER BY SECTION
--->

<!---
&nbsp;&nbsp;

Sections:

<!--- CREATE WHERE CLAUSE --->
<cfscript>
	WCSecID = '' ;
	FirstRow = 1 ;
</cfscript>
<cfoutput query="getProducts" group="SectionID">
	<cfscript>
		if ( FirstRow NEQ 1 AND SectionID NEQ '' AND SectionID NEQ 0 )
			WCSecID = WCSecID & ' OR ' ;
		if ( SectionID NEQ '' AND SectionID NEQ 0 )
			FirstRow = 0 ;
		if ( SectionID NEQ '' AND SectionID NEQ 0 )
			WCSecID = WCSecID & ' SectionID = ' & SectionID ;
	</cfscript>
</cfoutput>

<cfif getProducts.RecordCount NEQ 0 >
	<cfquery name="getSecs" datasource="#application.dsn#" cachedwithin="#CreateTimeSpan(0,0,11,0)#">
		SELECT 	SectionID, SecName
		FROM 	Sections
		WHERE	Hide#session.CustomerArray[28]# != 1
		AND		SiteID = #application.SiteID#
		<cfif WCSecID NEQ '' >
		AND 	(#WCSecID#)
		</cfif>
		ORDER BY DisplayOrder, SecName
	</cfquery>

	<select name="SecFilter" class="cfFormField" onChange="this.form.submit();">
		<option value="">--- ALL ---</option>
		<cfoutput query="getSecs" group="SecName">
			<option value="#SectionID#" <cfif SectionID EQ SecFilter > selected </cfif> >#SecName#</option>
		</cfoutput>
	</select>	
<cfelse>
	<select name="SecFilter" class="cfFormField" onChange="this.form.submit();">
		<option value="">--- ALL ---</option>
	</select>
</cfif>

--->