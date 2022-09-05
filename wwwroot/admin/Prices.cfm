<!--- SET DEFAULT PARAMETERS --->
<cfparam name="URL.Category" default="">
<cfparam name="URL.Section" default="">
<cfparam name="URL.Show" default="">
<cfparam name="URL.DistributorID" default="">
<cfparam name="URL.PrintCategory" default="">
<cfparam name="URL.PrintSection" default="">
<cfparam name="URL.PrintShow" default="">
<cfparam name="URL.PrintDistributorID" default="">

<!--- BEGIN: SEARCH CRITERIA -------------------------------------------------->
<cfinvoke component="#application.Queries#" method="getUsers" returnvariable="getUsers"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getDistributors" returnvariable="getDistributors"></cfinvoke>
<!--- END: SEARCH CRITERIA -------------------------------------------------->

<!--- HEADER --->
<cfscript>
	PageTitle = 'PRICES' ;
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">

<cfoutput>

<table width="100%" border="0" cellpadding="3" cellspacing="0">
	<tr style="background-color:##65ADF1;">
		<td width="49%" colspan="2" height="20" class="cfAdminHeader1">&nbsp; PRODUCT PRICES &amp; VISIBILITY</td>
		<td width="1%"  rowspan="20" style="background-color:##FFFFFF;">&nbsp;</td>
		<td width="50%" colspan="2" class="cfAdminHeader1">&nbsp; PRINT PRODUCT PRICES</td>
	</tr>
	<!--- DROP DOWN MENU SELECTIONS --->
	<cfform action="Prices.cfm?#CGI.QUERY_STRING#" method="get">
	<tr>
		<td width="15%" nowrap>
			Select Products In This Category:
		<td width="35%">
			<select name="Category" size="1" class="cfAdminDefault" onchange="this.form.Section.value=''">
				<cfif URL.Category EQ ''>
					<cfset EntryValue = '' >
				<cfelse>
					<cfset EntryValue = URL.Category >
				</cfif>
				<cfinclude template="Includes/DDLCat.cfm">
			</select>
		</td>
		<td width="15%" nowrap>
			Print Products In This Category:
		<td width="35%">
			<select name="PrintCategory" size="1" class="cfAdminDefault" onchange="this.form.PrintSection.value=''">
				<cfif URL.PrintCategory EQ ''>
					<cfset EntryValue = '' >
				<cfelse>
					<cfset EntryValue = URL.PrintCategory >
				</cfif>
				<cfinclude template="Includes/DDLCat.cfm">
			</select>
		</td>
	</tr>
	<tr>
		<td>
			Select Products In This Section:
		</td>
		<td>
			<select name="Section" size="1" class="cfAdminDefault" onchange="this.form.Category.value=''">
				<cfif URL.Section EQ ''>
					<cfset EntryValue = '' >
				<cfelse>
					<cfset EntryValue = URL.Section >
				</cfif>
				<cfinclude template="Includes/DDLSec.cfm">
			</select>
		</td>
		<td>
			Print Products In This Section:
		</td>
		<td>
			<select name="PrintSection" size="1" class="cfAdminDefault" onchange="this.form.PrintCategory.value=''">
				<cfif URL.PrintSection EQ ''>
					<cfset EntryValue = '' >
				<cfelse>
					<cfset EntryValue = URL.PrintSection >
				</cfif>
				<cfinclude template="Includes/DDLSec.cfm">
			</select>
		</td>

	</tr>
	<tr>
		<td>
			Show:
		</td>
		<td>
			<select name="Show" size="1" class="cfAdminDefault">
				<option value="All" <cfif URL.Show EQ 'All' > selected </cfif> >All Products In Selection</option>
				<option value="Just" <cfif URL.Show EQ 'Just' > selected </cfif> >Just Products In This Selection</option>
			</select>
		</td>
		<td>
			Print:
		</td>
		<td>
			<select name="PrintShow" size="1" class="cfAdminDefault">
				<option value="All" <cfif URL.PrintShow EQ 'All' > selected </cfif> >All Products In Selection</option>
				<option value="Just" <cfif URL.PrintShow EQ 'Just' > selected </cfif> >Just Products In This Selection</option>
			</select>
		</td>
	</tr>
	<tr>
		<td>
			Filter By This Distributor:
		</td>
		<td>
			<cfselect name="DistributorID" query="getDistributors" size="1" 
				value="DistributorID" display="DistributorName" selected="#URL.DistributorID#" class="cfAdminDefault">
				<option value="" <cfif URL.DistributorID EQ '' OR URL.DistributorID EQ 0 > selected </cfif> >-- ALL DISTRIBUTORS --</option>
			</cfselect>
		</td>
		<td>
			Filter By This Distributor:
		</td>
		<td>
			<cfselect name="PrintDistributorID" query="getDistributors" size="1" 
				value="DistributorID" display="DistributorName" selected="#URL.PrintDistributorID#" class="cfAdminDefault">
				<option value="" <cfif URL.PrintDistributorID EQ '' OR URL.PrintDistributorID EQ 0 > selected </cfif> >-- ALL DISTRIBUTORS --</option>
			</cfselect>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="submit" name="ViewPrices" value="VIEW PRODUCTS >>" class="cfAdminButton" onclick="SubmitFormTo('Prices.cfm','GET')">
		</td>
		<td colspan="2">
			<input type="submit" name="PrintPrices" value="PRINT PRICES >>" class="cfAdminButton" onclick="SubmitFormTo('PrintPrices.cfm','GET')">
		</td>
	</tr>
	<tr><td height="20" colspan="5"></td></tr>
	</cfform>
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr><td height="1" colspan="5"><img src="images/image-LineGray.gif" width="100%" height="1"></td></tr>
	<tr><td height="1" colspan="5"><img src="images/image-LineWhite.gif" width="100%" height="1"></td></tr>
	<tr><td height="1" colspan="5"><img src="images/image-LineGray.gif" width="100%" height="1"></td></tr>
</table>

</cfoutput>

<cfif URL.Category NEQ '' OR URL.Section NEQ '' OR URL.DistributorID NEQ ''>
<table border="0" cellpadding="0" cellspacing="0">	
	<tr>
		<td height="20" class="cfAdminHeader2"></td>
		<td width="300" class="cfAdminHeader2">

		</td>		
		<cfoutput query="getUsers">
		<td width="100" align="center" colspan="2" class="cfAdminHeader2">
			#UName#
		</td>
		</cfoutput>
	</tr>

	<tr>
		<td height="20"></td>
		<td width="300"></td>
		<cfloop from="1" to="#getUsers.RecordCount#" index="i">
		<td align="center" bgcolor="<cfoutput>#IIF(((i MOD 2) is 0),DE('FFFFFF'),DE('E3E3E3'))#</cfoutput>">Print</td>
		<td align="center" bgcolor="<cfoutput>#IIF(((i MOD 2) is 0),DE('FFFFFF'),DE('E3E3E3'))#</cfoutput>">
			<a href="PrintPrices.cfm?UID=<cfoutput>#i#</cfoutput>&Print=C"><img src="images/icon-PrintSingle.gif" border="0" alt="Print Category Prices"></a>&nbsp;
			<a href="PrintPrices.cfm?UID=<cfoutput>#i#</cfoutput>&Print=P"><img src="images/icon-PrintMult.gif" border="0" alt="Print All Product Prices"></a>
		</td>
		</cfloop>
	</tr>
	<tr>
		<td height="20"></td>
		<td width="300" class="cfAdminLink">
			<cfif URL.Category NEQ ''>
				&nbsp; Category
			<cfelseif URL.Section NEQ ''>
				&nbsp; Section
			</cfif>
		</td>
		<cfloop from="1" to="#getUsers.RecordCount#" index="i">
		<td align="center" bgcolor="<cfoutput>#IIF(((i MOD 2) is 0),DE('FFFFFF'),DE('E3E3E3'))#</cfoutput>">Price</td>
		<td align="center" bgcolor="<cfoutput>#IIF(((i MOD 2) is 0),DE('FFFFFF'),DE('E3E3E3'))#</cfoutput>">Hide</td>
		</cfloop>
	</tr>
	

<!--- SHOW BY CATEGORY --->
<cfif URL.Category NEQ ''>
	
	
	<!--- GET CATEGORIES --->
	<cfquery name="getCategory" datasource="#application.dsn#">
		SELECT 		*
		FROM 		Categories
		WHERE		CatID = #URL.Category#
		ORDER BY 	CatName
	</cfquery>
	
	<!--- OUTPUT CATEGORIES --->
	<cfoutput query="getCategory">
		
		<tr style="background-color:##7DBF0E;">
			<td height="20" colspan="2" class="cfAdminHeader4">&nbsp; #CatName#<a name="CatAnchor#CatID#"></a></td>

			<cfloop from="1" to="#getUsers.RecordCount#" index="i">
				<!--- GET AVERAGE PRICE AND COMPARE TO SINGLE PRICE --->
				<cfquery name="getMinMax" datasource="#application.dsn#">
					SELECT 	MIN(Price#i#) AS MinPrice, MAX(Price#i#) AS MaxPrice
					FROM	Products
					WHERE	(Category = #URL.Category#
					OR 		OtherCategories LIKE '%,#URL.Category#,%')
					<cfif URL.DistributorID NEQ ''>
					AND		DistributorID = #URL.DistributorID#
					</cfif>
				</cfquery>
				<cfscript>
					ThisHide  = #Evaluate("Hide" & i)#;
				</cfscript>										
				<td align="center" class="cfAdminDefault" bgcolor="#IIF(((i MOD 2) is 0),DE('FFFFFF'),DE('E3E3E3'))#">
					<b>$</b><input type="text" name="Price#i#" value="<cfif getMinMax.MinPrice EQ getMinMax.MaxPrice>#DecimalFormat(getMinMax.MaxPrice)#</cfif>" size="7" maxlength="10" class="cfAdminDefault" onchange="updateCategory('#CatID#',this.value,'Price#i#','Categories');">
				</td>
				<td align="center" bgcolor="#IIF(((i MOD 2) is 0),DE('FFFFFF'),DE('E3E3E3'))#">
					<input type="checkbox" name="Hide#i#" onclick="updateCategory('#CatID#',this.value,'Hide#i#','Categories');" <cfif ThisHide EQ 1> checked </cfif> >
				</td>
			</cfloop>
		</tr>
		
		<!--- GET PRODUCTS IN THIS CATEGORY --->
		<cfquery name="ProductsInCat" datasource="#application.dsn#">
			SELECT	ItemID, SKU, ItemName, <cfloop from="1" to="#getUsers.RecordCount#" index="i">Price#i#, Hide#i#, </cfloop> Category
			FROM	Products
			<cfif URL.Show EQ 'Just' OR URL.Show EQ '' >
				WHERE  (Category = #URL.Category#
				OR 		OtherCategories LIKE '%,#URL.Category#,%')
			<cfelseif URL.Show EQ 'All'>
				WHERE  ((Category = #URL.Category#
				OR 		OtherCategories LIKE '%,#URL.Category#,%'
				OR		Category IN
					   (SELECT  CatID
						FROM	Categories
						WHERE	SubCategoryOf = #URL.Category# ))
				OR		Category IN
					   (SELECT  CatID
						FROM	Categories
						WHERE	SubCategoryOf IN
					   (SELECT  CatID
						FROM	Categories
						WHERE	SubCategoryOf = #URL.Category# ))
				OR		Category IN
					   (SELECT  CatID
						FROM	Categories
						WHERE	SubCategoryOf IN
					   (SELECT  CatID
						FROM	Categories
						WHERE	SubCategoryOf IN
					   (SELECT  CatID
						FROM	Categories
						WHERE	SubCategoryOf = #URL.Category# )))
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
						WHERE	SubCategoryOf = #URL.Category# ))))
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
						WHERE	SubCategoryOf = #URL.Category# ))))))	
			</cfif>
			<cfif URL.DistributorID NEQ ''>
				AND		DistributorID = #URL.DistributorID#
			</cfif>
			ORDER BY SKU
		</cfquery>
		
		<cfif ProductsInCat.RecordCount EQ 0>
			<tr>
				<td colspan="#Val(2 + getUsers.RecordCount)#" class="cfAdminError"><br>&nbsp; No products available based on your selections</td>
			</tr>
		<cfelse>
			<!--- OUTPUT THE PRODUCTS IN THIS CATEGORY --->
			<cfloop query="ProductsInCat">
				<tr>
					<td></td>
					<td width="300" class="cfAdminDefault">
						<img src="images/spacer.gif" width="3" height="1">
						<a href="ProductDetail.cfm?ItemID=#ItemID#">#SKU#: #ItemName#</a>
					</td>
					<form action="#CGI.SCRIPT_NAME#" method="post">
					<cfloop from="1" to="#getUsers.RecordCount#" index="i">
						<cfscript>
							ThisPrice = #DecimalFormat(Evaluate("Price" & i))#;
							ThisHide  = #Evaluate("Hide" & i)#;
						</cfscript>										
						<td align="center" class="cfAdminDefault" bgcolor="#IIF(((i MOD 2) is 0),DE('FFFFFF'),DE('E3E3E3'))#">
							$<input type="text" name="Price#i#" value="#ThisPrice#" size="7" maxlength="10" class="cfAdminDefault" onchange="updateInfo(#ItemID#,this.value,'Price#i#','Products');">
						</td>
						<td align="center" bgcolor="#IIF(((i MOD 2) is 0),DE('FFFFFF'),DE('E3E3E3'))#">
							<input type="checkbox" name="Hide#i#" onclick="updateInfo(#ItemID#,this.value,'Hide#i#','Products');" <cfif ThisHide EQ 1> checked </cfif> >
						</td>
					</cfloop>
					</form>
				</tr>
			</cfloop>
		</cfif>
	</cfoutput>
	
<!--- SHOW BY SECTION --->
<cfelseif URL.Section NEQ ''>
	
	
	<!--- GET SECTIONS --->
	<cfquery name="getSection" datasource="#application.dsn#">
		SELECT 		*
		FROM 		Sections
		WHERE		SectionID = #URL.Section#
		ORDER BY 	SecName
	</cfquery>
	
	<!--- OUTPUT SECTIONS --->
	<cfoutput query="getSection">
		
		<tr style="background-color:##7DBF0E;">
			<td height="20" colspan="2" class="cfAdminHeader4">&nbsp; #SecName#<a name="SecAnchor#SectionID#"></a></td>

			<cfloop from="1" to="#getUsers.RecordCount#" index="i">
				<!--- GET AVERAGE PRICE AND COMPARE TO SINGLE PRICE --->
				<cfquery name="getMinMax" datasource="#application.dsn#">
					SELECT 	MIN(Price#i#) AS MinPrice, MAX(Price#i#) AS MaxPrice
					FROM	Products
					WHERE	SectionID = #URL.Section#
					OR 		OtherSections LIKE '%,#URL.Section#,%'
					<cfif URL.DistributorID NEQ ''>
					AND		DistributorID = #URL.DistributorID#
					</cfif>
				</cfquery>
				<cfscript>
					ThisHide  = #Evaluate("Hide" & i)#;
				</cfscript>										
				<td align="center" class="cfAdminDefault" bgcolor="#IIF(((i MOD 2) is 0),DE('FFFFFF'),DE('E3E3E3'))#">
					<b>$</b><input type="text" name="Price#i#" value="<cfif getMinMax.MinPrice EQ getMinMax.MaxPrice>#DecimalFormat(getMinMax.MaxPrice)#</cfif>" size="7" maxlength="10" class="cfAdminDefault" onchange="updateSection('#SectionID#',this.value,'Price#i#','Sections');">
				</td>
				<td align="center" bgcolor="#IIF(((i MOD 2) is 0),DE('FFFFFF'),DE('E3E3E3'))#">
					<input type="checkbox" name="Hide#i#" onclick="updateSection('#SectionID#',this.value,'Hide#i#','Sections');" <cfif ThisHide EQ 1> checked </cfif> >
				</td>
			</cfloop>
		</tr>
		
		<!--- GET PRODUCTS IN THIS SECTION --->
		<cfquery name="ProductsInSec" datasource="#application.dsn#">
			SELECT	ItemID, SKU, ItemName, <cfloop from="1" to="#getUsers.RecordCount#" index="i">Price#i#, Hide#i#, </cfloop> SectionID
			FROM	Products
			<cfif URL.Show EQ 'Just' OR URL.Show EQ '' >
				WHERE  (SectionID = #URL.Section#
				OR 		OtherSections LIKE '%,#URL.Section#,%')
			<cfelseif URL.Show EQ 'All'>
				WHERE  ((SectionID = #URL.Section#
				OR 		OtherSections LIKE '%,#URL.Section#,%'
				OR		SectionID IN
					   (SELECT  SectionID
						FROM	Sections
						WHERE	SubSectionOf = #URL.Section# ))
				OR		SectionID IN
					   (SELECT  SectionID
						FROM	Sections
						WHERE	SubSectionOf IN
					   (SELECT  SectionID
						FROM	Sections
						WHERE	SubSectionOf = #URL.Section# ))
				OR		SectionID IN
					   (SELECT  SectionID
						FROM	Sections
						WHERE	SubSectionOf IN
					   (SELECT  SectionID
						FROM	Sections
						WHERE	SubSectionOf IN
					   (SELECT  SectionID
						FROM	Sections
						WHERE	SubSectionOf = #URL.Section# )))
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
						WHERE	SubSectionOf = #URL.Section# ))))
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
						WHERE	SubSectionOf = #URL.Section# ))))))	
			</cfif>
			<cfif URL.DistributorID NEQ ''>
			AND		DistributorID = #URL.DistributorID#
			</cfif>
			ORDER BY SKU
		</cfquery>
		
		<cfif ProductsInSec.RecordCount EQ 0>
			<tr>
				<td colspan="#Val(2 + getUsers.RecordCount)#" class="cfAdminError"><br>&nbsp; No products available based on your selections</td>
			</tr>
		<cfelse>
			<!--- OUTPUT THE PRODUCTS IN THIS SECTION --->
			<cfloop query="ProductsInSec">
				<tr>
					<td></td>
					<td width="300" class="cfAdminDefault">
						<img src="images/spacer.gif" width="3" height="1">
						<a href="ProductDetail.cfm?ItemID=#ItemID#">#SKU#: #ItemName#</a>
					</td>
					<form action="#CGI.SCRIPT_NAME#" method="post">
					<cfloop from="1" to="#getUsers.RecordCount#" index="i">
						<cfscript>
							ThisPrice = #DecimalFormat(Evaluate("Price" & i))#;
							ThisHide  = #Evaluate("Hide" & i)#;
						</cfscript>										
						<td align="center" class="cfAdminDefault" bgcolor="#IIF(((i MOD 2) is 0),DE('FFFFFF'),DE('E3E3E3'))#">
							$<input type="text" name="Price#i#" value="#ThisPrice#" size="7" maxlength="10" class="cfAdminDefault" onchange="updateInfo(#ItemID#,this.value,'Price#i#','Products');">
						</td>
						<td align="center" bgcolor="#IIF(((i MOD 2) is 0),DE('FFFFFF'),DE('E3E3E3'))#">
							<input type="checkbox" name="Hide#i#" onclick="updateInfo(#ItemID#,this.value,'Hide#i#','Products');" <cfif ThisHide EQ 1> checked </cfif> >
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

<br><br>
<cfinclude template="LayoutAdminFooter.cfm">