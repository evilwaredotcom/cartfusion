<cfset BreadCrumbsList = '' >


<cfswitch expression="#BreadCrumbs#">
	<!--- HOME PAGE --->
	<cfcase value="1"><cfset BreadCrumbsList = '<a href="index.cfm">Home</a>' ></cfcase>
	<!--- LOGIN --->
	<cfcase value="2"><cfset BreadCrumbsList = '<a href="index.cfm">Home</a> > Login' ></cfcase>
	<!--- ABOUT US --->
	<cfcase value="3"><cfset BreadCrumbsList = '<a href="index.cfm">Home</a> > About Us' ></cfcase>
	<!--- CONTACT US --->
	<cfcase value="4"><cfset BreadCrumbsList = '<a href="index.cfm">Home</a> > Contact Us' ></cfcase>
	<!--- MY ACCOUNT --->
	<cfcase value="5"><cfset BreadCrumbsList = '<a href="index.cfm">Home</a> > My Account' ></cfcase>
	<!--- SHOPPING CART --->
	<cfcase value="6"><cfset BreadCrumbsList = '<a href="index.cfm">Home</a> > <a href="javascript:history.back();">Previous Page</a> > Shopping Cart' ></cfcase>
	<!--- ALL CATEGORIES --->
	<cfcase value="7"><cfset BreadCrumbsList = '<a href="index.cfm">Home</a> > All Categories' ></cfcase>
	<!--- ALL SECTIONS --->
	<cfcase value="8"><cfset BreadCrumbsList = '<a href="index.cfm">Home</a> > All Departments' ></cfcase>
	<!--- CATEGORY --->
	<cfcase value="9">
		<!--- GET ALL CATEGORIES --->
		<CFQUERY NAME="getSubCategories" DATASOURCE="#datasource#" cachedwithin="#CreateTimeSpan(0,0,10,0)#">
			SELECT 		CatID, CatName, SubCategoryOf
			FROM 		Categories
			WHERE		Hide#session.CustomerArray[28]# != 1
			AND			SiteID = #config.SiteID#
			ORDER BY 	DisplayOrder, CatName
		</CFQUERY>		
		<!--- GET THIS CATEGORY (AFTER getSubCategories) --->
		<cfquery name="getBCCatName1" dbtype="query">
			SELECT 	*
			FROM 	getSubCategories
			WHERE	CatID = #URL.CatDisplay#
		</cfquery>
		<cfset BCCatName = '#getBCCatName1.CatName#' >
		<cfif getBCCatName1.SubCategoryOf NEQ '' AND getBCCatName1.SubCategoryOf NEQ 0 >
			<cfquery name="getBCCatName2" dbtype="query">
				SELECT 	*
				FROM 	getSubCategories
				WHERE	CatID = #getBCCatName1.SubCategoryOf#
			</cfquery>
			<cfset BCCatName = '<a href="ProductList.cfm?CatDisplay=#getBCCatName2.CatID#">#getBCCatName2.CatName#</a> > ' & BCCatName >	
			<cfif getBCCatName2.SubCategoryOf NEQ '' AND getBCCatName2.SubCategoryOf NEQ 0 >
				<cfquery name="getBCCatName3" dbtype="query">
					SELECT 	*
					FROM 	getSubCategories
					WHERE	CatID = #getBCCatName2.SubCategoryOf#
				</cfquery>
				<cfset BCCatName = '<a href="ProductList.cfm?CatDisplay=#getBCCatName3.CatID#">#getBCCatName3.CatName#</a> > ' & BCCatName >
				<cfif getBCCatName3.SubCategoryOf NEQ '' AND getBCCatName3.SubCategoryOf NEQ 0 >
					<cfquery name="getBCCatName4" dbtype="query">
						SELECT 	*
						FROM 	getSubCategories
						WHERE	CatID = #getBCCatName3.SubCategoryOf#
					</cfquery>
					<cfset BCCatName = '<a href="ProductList.cfm?CatDisplay=#getBCCatName4.CatID#">#getBCCatName4.CatName#</a> > ' & BCCatName >
					<cfif getBCCatName4.SubCategoryOf NEQ '' AND getBCCatName4.SubCategoryOf NEQ 0 >
						<cfquery name="getBCCatName5" dbtype="query">
							SELECT 	*
							FROM 	getSubCategories
							WHERE	CatID = #getBCCatName4.SubCategoryOf#
						</cfquery>
						<cfset BCCatName = '<a href="ProductList.cfm?CatDisplay=#getBCCatName5.CatID#">#getBCCatName5.CatName#</a> > ' & BCCatName >
						<cfif getBCCatName5.SubCategoryOf NEQ '' AND getBCCatName5.SubCategoryOf NEQ 0 >
							<cfquery name="getBCCatName6" dbtype="query">
								SELECT 	*
								FROM 	getSubCategories
								WHERE	CatID = #getBCCatName5.SubCategoryOf#
							</cfquery>
							<cfset BCCatName = '<a href="ProductList.cfm?CatDisplay=#getBCCatName6.CatID#">#getBCCatName6.CatName#</a> > ' & BCCatName >
						</cfif>
					</cfif>
				</cfif>
			</cfif>
		</cfif>
		<cfset BreadCrumbsList = '<a href="index.cfm">Home</a> > <a href="CategoryAll.cfm">All Categories</a> > ' & BCCatName >
	</cfcase>
	<!--- SECTION/DEPARTMENT --->
	<cfcase value="10">
		<!--- GET ALL SECTIONS --->
		<CFQUERY NAME="getSubSections" DATASOURCE="#datasource#" cachedwithin="#CreateTimeSpan(0,0,10,0)#">
			SELECT 		SectionID, SecName, SubSectionOf
			FROM 		Sections
			WHERE		Hide#session.CustomerArray[28]# != 1
			AND			SiteID = #config.SiteID#
			ORDER BY 	DisplayOrder, SecName
		</CFQUERY>		
		<!--- GET THIS SECTION (AFTER getSubSections) --->
		<cfquery name="getBCSecName1" dbtype="query">
			SELECT 	*
			FROM 	getSubSections
			WHERE	SectionID = #URL.SecDisplay#
		</cfquery>
		<cfset BCSecName = '#getBCSecName1.SecName#' >
		<cfif getBCSecName1.SubSectionOf NEQ '' AND getBCSecName1.SubSectionOf NEQ 0 >
			<cfquery name="getBCSecName2" dbtype="query">
				SELECT 	*
				FROM 	getSubSections
				WHERE	SectionID = #getBCSecName1.SubSectionOf#
			</cfquery>
			<cfset BCSecName = '<a href="ProductList.cfm?SecDisplay=#getBCSecName2.SectionID#">#getBCSecName2.SecName#</a> > ' & BCSecName >	
			<cfif getBCSecName2.SubSectionOf NEQ '' AND getBCSecName2.SubSectionOf NEQ 0 >
				<cfquery name="getBCSecName3" dbtype="query">
					SELECT 	*
					FROM 	getSubSections
					WHERE	SectionID = #getBCSecName2.SubSectionOf#
				</cfquery>
				<cfset BCSecName = '<a href="ProductList.cfm?SecDisplay=#getBCSecName3.SectionID#">#getBCSecName3.SecName#</a> > ' & BCSecName >
				<cfif getBCSecName3.SubSectionOf NEQ '' AND getBCSecName3.SubSectionOf NEQ 0 >
					<cfquery name="getBCSecName4" dbtype="query">
						SELECT 	*
						FROM 	getSubSections
						WHERE	SectionID = #getBCSecName3.SubSectionOf#
					</cfquery>
					<cfset BCSecName = '<a href="ProductList.cfm?SecDisplay=#getBCSecName4.SectionID#">#getBCSecName4.SecName#</a> > ' & BCSecName >
					<cfif getBCSecName4.SubSectionOf NEQ '' AND getBCSecName4.SubSectionOf NEQ 0 >
						<cfquery name="getBCSecName5" dbtype="query">
							SELECT 	*
							FROM 	getSubSections
							WHERE	SectionID = #getBCSecName4.SubSectionOf#
						</cfquery>
						<cfset BCSecName = '<a href="ProductList.cfm?SecDisplay=#getBCSecName5.SectionID#">#getBCSecName5.SecName#</a> > ' & BCSecName >
						<cfif getBCSecName5.SubSectionOf NEQ '' AND getBCSecName5.SubSectionOf NEQ 0 >
							<cfquery name="getBCSecName6" dbtype="query">
								SELECT 	*
								FROM 	getSubSections
								WHERE	SectionID = #getBCSecName5.SubSectionOf#
							</cfquery>
							<cfset BCSecName = '<a href="ProductList.cfm?SecDisplay=#getBCSecName6.SectionID#">#getBCSecName6.SecName#</a> > ' & BCSecName >
						</cfif>
					</cfif>
				</cfif>
			</cfif>
		</cfif>
		<cfset BreadCrumbsList = '<a href="index.cfm">Home</a> > <a href="SectionAll.cfm">All Departments</a> > ' & BCSecName >
	</cfcase>
	<!--- PRODUCT FROM CATEGORY --->
	<cfcase value="11">
		<!--- GET PRODUCT'S CATEGORY ID --->
		<CFQUERY NAME="getBCItemInfo" DATASOURCE="#datasource#" cachedwithin="#CreateTimeSpan(0,0,10,0)#">
			SELECT 		Category, ItemName
			FROM 		Products
			WHERE		ItemID = #ItemID#
		</CFQUERY>		
		<cfset BCCatName = '#getBCItemInfo.ItemName#' >
		<!--- GET CATEGORIES --->
		<CFQUERY NAME="getSubCategories" DATASOURCE="#datasource#" cachedwithin="#CreateTimeSpan(0,0,10,0)#">
			SELECT 		CatID, CatName, SubCategoryOf
			FROM 		Categories
			WHERE		Hide#session.CustomerArray[28]# != 1
			AND			SiteID = #config.SiteID#
			ORDER BY 	DisplayOrder, CatName
		</CFQUERY>		
		<!--- GET MAIN CATEGORIES (AFTER getSubCategories) --->
		<cfquery name="getBCCatName1" dbtype="query">
			SELECT 	*
			FROM 	getSubCategories
			<cfif getBCItemInfo.Category NEQ '' >
            WHERE	CatID = #getBCItemInfo.Category#
            <cfelse>
            WHERE	CatID = 0
            </cfif>
		</cfquery>
		<cfset BCCatName = '<a href="ProductList.cfm?CatDisplay=#getBCCatName1.CatID#">#getBCCatName1.CatName#</a> > ' & BCCatName >
		<cfif getBCCatName1.SubCategoryOf NEQ '' AND getBCCatName1.SubCategoryOf NEQ 0 >
			<cfquery name="getBCCatName2" dbtype="query">
				SELECT 	*
				FROM 	getSubCategories
				WHERE	CatID = #getBCCatName1.SubCategoryOf#
			</cfquery>
			<cfset BCCatName = '<a href="ProductList.cfm?CatDisplay=#getBCCatName2.CatID#">#getBCCatName2.CatName#</a> > ' & BCCatName >
			<cfif getBCCatName2.SubCategoryOf NEQ '' AND getBCCatName2.SubCategoryOf NEQ 0 >
				<cfquery name="getBCCatName3" dbtype="query">
					SELECT 	*
					FROM 	getSubCategories
					WHERE	CatID = #getBCCatName2.SubCategoryOf#
				</cfquery>
				<cfset BCCatName = '<a href="ProductList.cfm?CatDisplay=#getBCCatName3.CatID#">#getBCCatName3.CatName#</a> > ' & BCCatName >
				<cfif getBCCatName3.SubCategoryOf NEQ '' AND getBCCatName3.SubCategoryOf NEQ 0 >
					<cfquery name="getBCCatName4" dbtype="query">
						SELECT 	*
						FROM 	getSubCategories
						WHERE	CatID = #getBCCatName3.SubCategoryOf#
					</cfquery>
					<cfset BCCatName = '<a href="ProductList.cfm?CatDisplay=#getBCCatName4.CatID#">#getBCCatName4.CatName#</a> > ' & BCCatName >
					<cfif getBCCatName4.SubCategoryOf NEQ '' AND getBCCatName4.SubCategoryOf NEQ 0 >
						<cfquery name="getBCCatName5" dbtype="query">
							SELECT 	*
							FROM 	getSubCategories
							WHERE	CatID = #getBCCatName4.SubCategoryOf#
						</cfquery>
						<cfset BCCatName = '<a href="ProductList.cfm?CatDisplay=#getBCCatName5.CatID#">#getBCCatName5.CatName#</a> > ' & BCCatName >
						<cfif getBCCatName5.SubCategoryOf NEQ '' AND getBCCatName5.SubCategoryOf NEQ 0 >
							<cfquery name="getBCCatName6" dbtype="query">
								SELECT 	*
								FROM 	getSubCategories
								WHERE	CatID = #getBCCatName5.SubCategoryOf#
							</cfquery>
							<cfset BCCatName = '<a href="ProductList.cfm?CatDisplay=#getBCCatName6.CatID#">#getBCCatName6.CatName#</a> > ' & BCCatName >
						</cfif>
					</cfif>
				</cfif>
			</cfif>
		</cfif>
		<cfset BreadCrumbsList = '<a href="index.cfm">Home</a> > <a href="CategoryAll.cfm">All Categories</a> > ' & BCCatName >
	</cfcase>
	<!--- PRODUCT FROM DEPARTMENT --->
	<cfcase value="12">
		<!--- GET PRODUCT'S SECTION ID --->
		<CFQUERY NAME="getBCItemInfo" DATASOURCE="#datasource#" cachedwithin="#CreateTimeSpan(0,0,10,0)#">
			SELECT 		SectionID, ItemName
			FROM 		Products
			WHERE		ItemID = #ItemID#
		</CFQUERY>		
		<cfset BCSecName = '#getBCItemInfo.ItemName#' >
		<!--- GET ALL SECTIONS --->
		<CFQUERY NAME="getSubSections" DATASOURCE="#datasource#" cachedwithin="#CreateTimeSpan(0,0,10,0)#">
			SELECT 		SectionID, SecName, SubSectionOf
			FROM 		Sections
			WHERE		Hide#session.CustomerArray[28]# != 1
			AND			SiteID = #config.SiteID#
			ORDER BY 	DisplayOrder, SecName
		</CFQUERY>		
		<!--- GET THIS SECTION (AFTER getSubSections) --->
		<cfquery name="getBCSecName1" dbtype="query">
			SELECT 	*
			FROM 	getSubSections
			<cfif getBCItemInfo.SectionID NEQ '' >
            WHERE	SectionID = #getBCItemInfo.SectionID#
            <cfelse>
            WHERE	SectionID = 0
            </cfif>
		</cfquery>
		<cfset BCSecName = '<a href="ProductList.cfm?SecDisplay=#getBCSecName1.SectionID#">#getBCSecName1.SecName#</a> > ' & BCSecName >
		<cfif getBCSecName1.SubSectionOf NEQ '' AND getBCSecName1.SubSectionOf NEQ 0 >
			<cfquery name="getBCSecName2" dbtype="query">
				SELECT 	*
				FROM 	getSubSections
				WHERE	SectionID = #getBCSecName1.SubSectionOf#
			</cfquery>
			<cfset BCSecName = '<a href="ProductList.cfm?SecDisplay=#getBCSecName2.SectionID#">#getBCSecName2.SecName#</a> > ' & BCSecName >	
			<cfif getBCSecName2.SubSectionOf NEQ '' AND getBCSecName2.SubSectionOf NEQ 0 >
				<cfquery name="getBCSecName3" dbtype="query">
					SELECT 	*
					FROM 	getSubSections
					WHERE	SectionID = #getBCSecName2.SubSectionOf#
				</cfquery>
				<cfset BCSecName = '<a href="ProductList.cfm?SecDisplay=#getBCSecName3.SectionID#">#getBCSecName3.SecName#</a> > ' & BCSecName >
				<cfif getBCSecName3.SubSectionOf NEQ '' AND getBCSecName3.SubSectionOf NEQ 0 >
					<cfquery name="getBCSecName4" dbtype="query">
						SELECT 	*
						FROM 	getSubSections
						WHERE	SectionID = #getBCSecName3.SubSectionOf#
					</cfquery>
					<cfset BCSecName = '<a href="ProductList.cfm?SecDisplay=#getBCSecName4.SectionID#">#getBCSecName4.SecName#</a> > ' & BCSecName >
					<cfif getBCSecName4.SubSectionOf NEQ '' AND getBCSecName4.SubSectionOf NEQ 0 >
						<cfquery name="getBCSecName5" dbtype="query">
							SELECT 	*
							FROM 	getSubSections
							WHERE	SectionID = #getBCSecName4.SubSectionOf#
						</cfquery>
						<cfset BCSecName = '<a href="ProductList.cfm?SecDisplay=#getBCSecName5.SectionID#">#getBCSecName5.SecName#</a> > ' & BCSecName >
						<cfif getBCSecName5.SubSectionOf NEQ '' AND getBCSecName5.SubSectionOf NEQ 0 >
							<cfquery name="getBCSecName6" dbtype="query">
								SELECT 	*
								FROM 	getSubSections
								WHERE	SectionID = #getBCSecName5.SubSectionOf#
							</cfquery>
							<cfset BCSecName = '<a href="ProductList.cfm?SecDisplay=#getBCSecName6.SectionID#">#getBCSecName6.SecName#</a> > ' & BCSecName >
						</cfif>
					</cfif>
				</cfif>
			</cfif>
		</cfif>
		<cfset BreadCrumbsList = '<a href="index.cfm">Home</a> > <a href="SectionAll.cfm">All Departments</a> > ' & BCSecName >
	</cfcase>
	<!--- SEARCH RESULTS --->
	<cfcase value="13"><cfset BreadCrumbsList = '<a href="index.cfm">Home</a> > <a href="javascript:history.back();">Previous Page</a> > Search Results' ></cfcase>
	<!--- PRODUCT FROM SEARCH --->
	<cfcase value="14"></cfcase>
	<!--- MY ACCOUNT UPDATE --->
	<cfcase value="15"><cfset BreadCrumbsList = '<a href="index.cfm">Home</a> > <a href="CA-CustomerArea.cfm">My Account</a> > Update My Account' ></cfcase>
	<!--- MY ACCOUNT ORDER DETAIL --->
	<cfcase value="16"><cfset BreadCrumbsList = '<a href="index.cfm">Home</a> > <a href="CA-CustomerArea.cfm">My Account</a> > Order Detail' ></cfcase>
	<!--- EMAIL LOGIN INFO --->
	<cfcase value="17"></cfcase>
	<!--- MULTIPLE CATEGORIES SELECTED --->
	<cfcase value="18"><cfset BreadCrumbsList = '<a href="index.cfm">Home</a> > <a href="CategoryAll.cfm">All Categories</a> > Selected Categories'></cfcase>
	<!--- MULTIPLE DEPARTMENTS SELECTED --->
	<cfcase value="19"><cfset BreadCrumbsList = '<a href="index.cfm">Home</a> > <a href="SectionAll.cfm">All Departments</a> > Selected Departments'></cfcase>
	<!--- AFFILIATE LOGIN --->
	<cfcase value="20"><cfset BreadCrumbsList = '<a href="index.cfm">Home</a> > Affiliate Login' ></cfcase>
	<!--- AFFILIATE MAIN PAGE --->
	<cfcase value="21"><cfset BreadCrumbsList = '<a href="index.cfm">Home</a> > <a href="AF-Main.cfm">Affiliate Login</a> > Affiliate Home' ></cfcase>
	<!--- AFFILIATE ACCOUNT UPDATE --->
	<cfcase value="22"><cfset BreadCrumbsList = '<a href="index.cfm">Home</a> > <a href="AF-Main.cfm">Affiliate Account</a> > Update My Account' ></cfcase>
</cfswitch>

<!--- OUTPUT BREADCRUMBS --->
<cfoutput>#BreadCrumbsList#</cfoutput>

<!---
<cfscript>
	tmt_crumb_separator=" >> ";
	tmt_crumb_ucase=0;
	tmt_crumb_count=0;
	tmt_current_file=REReplace(PageTitle,"\.cfm$","");
	tmt_crumb=REReplace(cgi.script_name,"/[^/]*$","");
	tmt_crumb_link="http://"&cgi.http_host;
	tmt_crumb_limit=ListLen(tmt_crumb,"/")+1;
	if(tmt_crumb_ucase){tmt_current_file=UCase(tmt_current_file);}
	for(i=tmt_crumb_count+1;i LT tmt_crumb_limit;i=i+1){
		tmt_crumb_name=listGetAt(tmt_crumb, i,"/");
		tmt_crumb_link=tmt_crumb_link&"/"&tmt_crumb_name;
		if(tmt_crumb_ucase){tmt_crumb_name=UCase(tmt_crumb_name);}
		WriteOutPut('<a href="'&tmt_crumb_link&'">'&tmt_crumb_name&'</a>');
		if(i+1 LT tmt_crumb_limit){WriteOutPut(tmt_crumb_separator);}
		else{WriteOutPut(tmt_crumb_separator&' '&tmt_current_file);}}
</cfscript>
--->