<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<!--- BEGIN: SEARCH CRITERIA -------------------------------------------------->
<cfinvoke component="#application.Queries#" method="getUsers" returnvariable="getUsers"></cfinvoke>
<!---
<cfinvoke component="#application.Queries#" method="getUser" returnvariable="getUser">
	<cfinvokeargument name="UID" value="#URL.UID#">
</cfinvoke>
--->
<!--- END: SEARCH CRITERIA -------------------------------------------------->

<html>
<head>
	<title><cfoutput>#Ucase(application.StoreName)# <!---#Ucase(getUser.UName)#---> PRICE LIST</cfoutput></title>
	<cfinclude template="css.cfm">
</head>
<body>

<cfoutput>
<table width="600" border="0" cellpadding="0" cellspacing="0" align="center">
	<tr><td width="100%" class="cfAdminTitle" align="center"><b>#Ucase(application.StoreName)# <!---#Ucase(getUser.UName)#---> PRICE LIST</b></td></tr>
	<!---<tr><td width="100%" class="cfAdminDefault" align="center">*** PLEASE NOTE: PRODUCTS AND PRICES ARE SUBJECT TO CHANGE ***</td></tr>--->
	<cfif URL.PrintDistributorID NEQ ''>
	<cfquery name="getDistributorName" datasource="#application.dsn#">
		SELECT	DistributorName
		FROM	Distributors
		WHERE	DistributorID = #URL.PrintDistributorID#
	</cfquery>
	<tr><td width="100%" class="cfAdminDefault" align="center"><b>Distributor: #getDistributorName.DistributorName#</b></td></tr>
	</cfif>
	<tr><td width="100%" height="20">&nbsp;</td></tr>
</table>
</cfoutput>

<cfif URL.PrintCategory NEQ '' OR URL.PrintSection NEQ '' OR URL.PrintDistributorID NEQ ''>
<table width="600" border="0" cellpadding="3" cellspacing="0" align="center">
		
<!--- SHOW BY CATEGORY --->
<cfif URL.PrintCategory NEQ ''>
	
	
	<!--- GET CATEGORIES --->
	<cfquery name="getCategory" datasource="#application.dsn#">
		SELECT 		*
		FROM 		Categories
		WHERE		CatID = #URL.PrintCategory#
		ORDER BY 	CatName
	</cfquery>
	
	<!--- OUTPUT CATEGORIES --->
	<cfoutput query="getCategory">
		
		<tr style="background-color:##7DBF0E;">
			<td width="300" height="20" style="padding-left:5px;" class="cfAdminHeader4">#CatName#</td>	
			<cfloop query="getUsers">
			<td width="100" align="center" class="cfAdminHeader2">
				#UName#
			</td>
			</cfloop>
		</tr>
		
		<!--- GET PRODUCTS IN THIS CATEGORY --->
		<cfquery name="ProductsInCat" datasource="#application.dsn#">
			SELECT	ItemID, SKU, ItemName, <cfloop from="1" to="#getUsers.RecordCount#" index="i">Price#i#, Hide#i#, </cfloop> Category
			FROM	Products
			<cfif URL.PrintShow EQ 'Just' OR URL.PrintShow EQ '' >
				WHERE  (Category = #URL.PrintCategory#
				OR 		OtherCategories LIKE '%,#URL.PrintCategory#,%')
			<cfelseif URL.PrintShow EQ 'All'>
				WHERE  ((Category = #URL.PrintCategory#
				OR 		OtherCategories LIKE '%,#URL.PrintCategory#,%'
				OR		Category IN
					   (SELECT  CatID
						FROM	Categories
						WHERE	SubCategoryOf = #URL.PrintCategory# ))
				OR		Category IN
					   (SELECT  CatID
						FROM	Categories
						WHERE	SubCategoryOf IN
					   (SELECT  CatID
						FROM	Categories
						WHERE	SubCategoryOf = #URL.PrintCategory# ))
				OR		Category IN
					   (SELECT  CatID
						FROM	Categories
						WHERE	SubCategoryOf IN
					   (SELECT  CatID
						FROM	Categories
						WHERE	SubCategoryOf IN
					   (SELECT  CatID
						FROM	Categories
						WHERE	SubCategoryOf = #URL.PrintCategory# )))
				OR		Category IN
					   (SELECT  CatID
						FROM	Categories
						WHERE	SubCategoryOf IN
					   (SELECT  CatID
						FROM	Categories
						WHERE	SubCategoryOf IN
					   (SELECT  CatID
						FROM	Categories
						WHERE	SubCategoryOf IN
					   (SELECT  CatID
						FROM	Categories
						WHERE	SubCategoryOf = #URL.PrintCategory# ))))
				OR		Category IN
					   (SELECT  CatID
						FROM	Categories
						WHERE	SubCategoryOf IN
					   (SELECT  CatID
						FROM	Categories
						WHERE	SubCategoryOf IN
					   (SELECT  CatID
						FROM	Categories
						WHERE	SubCategoryOf IN
					   (SELECT  CatID
						FROM	Categories
						WHERE	SubCategoryOf IN
					   (SELECT  CatID
						FROM	Categories
						WHERE	SubCategoryOf = #URL.PrintCategory# ))))))
			</cfif>
			<cfif URL.PrintDistributorID NEQ ''>
				AND		DistributorID = #URL.PrintDistributorID#
			</cfif>
			ORDER BY SKU
		</cfquery>
		
		<cfif ProductsInCat.RecordCount EQ 0>
			<tr>
				<td colspan="#Val(1 + getUsers.RecordCount)#" style="padding-left:5px;" class="cfAdminError"><br>No products available based on your selections</td>
			</tr>
		<cfelse>
			<!--- OUTPUT THE PRODUCTS IN THIS CATEGORY --->
			<cfloop query="ProductsInCat">
				<tr>
					<td width="350" style="padding-left:5px;" class="cfAdminDefault">
						#SKU#: #ItemName#
					</td>
					<cfloop from="1" to="#getUsers.RecordCount#" index="i">
						<cfscript>
							ThisPrice = NumberFormat(Evaluate("Price" & i),9.99) ;
							ThisHide  = Evaluate("Hide" & i) ;
						</cfscript>										
						<td width="100" align="right" class="cfAdminDefault" bgcolor="#IIF(((i MOD 2) is 0),DE('FFFFFF'),DE('EAEAEA'))#">
							$#ThisPrice#
						</td>
					</cfloop>
				</tr>
			</cfloop>
		</cfif>
	</cfoutput>
	
<!--- SHOW BY SECTION --->
<cfelseif URL.PrintSection NEQ ''>
	
	
	<!--- GET SECTIONS --->
	<cfquery name="getSection" datasource="#application.dsn#">
		SELECT 		*
		FROM 		Sections
		WHERE		SectionID = #URL.PrintSection#
		ORDER BY 	SecName
	</cfquery>
	
	<!--- OUTPUT SECTIONS --->
	<cfoutput query="getSection">
		
		<tr style="background-color:##7DBF0E;">
			<td height="20" style="padding-left:5px;" class="cfAdminHeader4">#SecName#</td>	
			<cfloop query="getUsers">
			<td width="100" align="center" class="cfAdminHeader2">
				#UName#
			</td>
			</cfloop>
		</tr>
		
		<!--- GET PRODUCTS IN THIS SECTION --->
		<cfquery name="ProductsInSec" datasource="#application.dsn#">
			SELECT	ItemID, SKU, ItemName, <cfloop from="1" to="#getUsers.RecordCount#" index="i">Price#i#, Hide#i#, </cfloop> SectionID
			FROM	Products
			<cfif URL.PrintShow EQ 'Just' OR URL.PrintShow EQ '' >
				WHERE  (SectionID = #URL.PrintSection#
				OR 		OtherSections LIKE '%,#URL.PrintSection#,%')
			<cfelseif URL.PrintShow EQ 'All'>
				WHERE  ((SectionID = #URL.PrintSection#
				OR 		OtherSections LIKE '%,#URL.PrintSection#,%'
				OR		SectionID IN
					   (SELECT  SectionID
						FROM	Sections
						WHERE	SubSectionOf = #URL.PrintSection# ))
				OR		SectionID IN
					   (SELECT  SectionID
						FROM	Sections
						WHERE	SubSectionOf IN
					   (SELECT  SectionID
						FROM	Sections
						WHERE	SubSectionOf = #URL.PrintSection# ))
				OR		SectionID IN
					   (SELECT  SectionID
						FROM	Sections
						WHERE	SubSectionOf IN
					   (SELECT  SectionID
						FROM	Sections
						WHERE	SubSectionOf IN
					   (SELECT  SectionID
						FROM	Sections
						WHERE	SubSectionOf = #URL.PrintSection# )))
				OR		SectionID IN
					   (SELECT  SectionID
						FROM	Sections
						WHERE	SubSectionOf IN
					   (SELECT  SectionID
						FROM	Sections
						WHERE	SubSectionOf IN
					   (SELECT  SectionID
						FROM	Sections
						WHERE	SubSectionOf IN
					   (SELECT  SectionID
						FROM	Sections
						WHERE	SubSectionOf = #URL.PrintSection# ))))
				OR		SectionID IN
					   (SELECT  SectionID
						FROM	Sections
						WHERE	SubSectionOf IN
					   (SELECT  SectionID
						FROM	Sections
						WHERE	SubSectionOf IN
					   (SELECT  SectionID
						FROM	Sections
						WHERE	SubSectionOf IN
					   (SELECT  SectionID
						FROM	Sections
						WHERE	SubSectionOf IN
					   (SELECT  SectionID
						FROM	Sections
						WHERE	SubSectionOf = #URL.PrintSection# ))))))
			</cfif>
			<cfif URL.PrintDistributorID NEQ ''>
			AND		DistributorID = #URL.PrintDistributorID#
			</cfif>
			ORDER BY SKU
		</cfquery>
		
		<cfif ProductsInSec.RecordCount EQ 0>
			<tr>
				<td colspan="#Val(1 + getUsers.RecordCount)#" class="cfAdminError"><br>&nbsp; No products available based on your selections</td>
			</tr>
		<cfelse>
			<!--- OUTPUT THE PRODUCTS IN THIS SECTION --->
			<cfloop query="ProductsInSec">
				<tr>
					<td width="350" style="padding-left:5px;" class="cfAdminDefault">
						#SKU#: #ItemName#
					</td>
					<form action="#CGI.SCRIPT_NAME#" method="post">
					<cfloop from="1" to="#getUsers.RecordCount#" index="i">
						<cfscript>
							ThisPrice = NumberFormat(Evaluate("Price" & i),9.99) ;
							ThisHide  = Evaluate("Hide" & i) ;
						</cfscript>										
						<td width="100" align="right" class="cfAdminDefault" bgcolor="#IIF(((i MOD 2) is 0),DE('FFFFFF'),DE('EAEAEA'))#">
							$#ThisPrice#
						</td>
					</cfloop>
					</form>
				</tr>
			</cfloop>
		</cfif>
	</cfoutput>
</cfif>
</cfif>
</table>