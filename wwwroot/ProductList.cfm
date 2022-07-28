<!--- NEXT N VARIABLES: What row to start at? Assume first by default --->
<cfparam name="url.StartRow" default="1" type="numeric">
<cfparam name="url.SortOption" default="SKU" type="string">
<cfparam name="url.SortAscending" default="1" type="numeric">
<cfparam name="url.Field" default="ALL" type="string">
<cfparam name="url.String" default="" type="string">
<cfset String = Trim(string)>

<cfparam name="PageTitle" default="">

<!--- QUERY Products --->

<cfinvoke component="#application.Common#" method="getAllProducts" returnvariable="getProducts">
	<cfinvokeargument name="UserID" value="#session.CustomerArray[28]#">
	<cfinvokeargument name="SiteID" value="#application.siteConfig.data.SiteID#">
	
	<cfif structKeyExists(url, 'CatDisplay') AND url.CatDisplay NEQ ''>
		<cfinvokeargument name="CatDisplay" value="#url.CatDisplay#">
	<cfelseif structKeyExists(url, 'SecDisplay') AND url.SecDisplay NEQ ''>
		<cfinvokeargument name="SecDisplay" value="#url.SecDisplay#">
	</cfif>
	<cfif structKeyExists(url, 'CatFilter') AND url.CatFilter NEQ ''>
		<cfinvokeargument name="CatFilter" value="#url.CatFilter#">
	<cfelseif structKeyExists(url, 'SecFilter') AND url.SecFilter NEQ ''>
		<cfinvokeargument name="SecFilter" value="#url.SecFilter#">
	</cfif>
	<cfif isDefined('SMC') AND SMC NEQ ''>
		<cfinvokeargument name="SMC" value="#SMC#">
	<cfelseif isDefined('SMS') AND SMS NEQ ''>
		<cfinvokeargument name="SMS" value="#SMS#">
	</cfif>
	<cfinvokeargument name="SortOption" value="#url.SortOption#">
	<cfinvokeargument name="SortAscending" value="#url.SortAscending#">	
</cfinvoke>


	<cfscript>
		if( structKeyExists(url, 'CatDisplay'))	{
			// Get Category Detail
			getCategory = application.common.getCategoryDetail(CatID=url.CatDisplay);
			// Get Categories
			getCategories = application.Common.getCategories(
				UserID=session.CustomerArray[28], 
				SiteID=application.siteConfig.data.SiteID, 
				CatID=url.CatDisplay);
		}
		
		// If CatDisplay has been passed
		if( structKeyExists(url, 'CatDisplay'))	{
			myCrumb = 'Category Display';
		}
		else	{
			myCrumb = 'Product List';
		}
		
		// If Cat Name is defined
		if ( isDefined('getCategory.CatName') and getCategory.CatName NEQ '' )	{
			PageTitle = getCategory.CatName;
		}
		else if ( isDefined('getSection.SecName') AND getSection.SecName NEQ '' )	{
			PageTitle = getSection.SecName;
		}
		else	{
			PageTitle = 'Product List';
		}
			
			
		
		// if SecDisplay exists
		if( structKeyExists(url, 'SecDisplay'))	{
			// BreadCrumbs = 10;
			// Get Section Details
			getSection = application.Common.getSectionDetail(SectionID=url.SecDisplay);
			// Get Sections
			getSections = application.Common.getSections(
				UserID=session.CustomerArray[28], 
				SiteID=application.siteConfig.data.SiteID, 
				SectionID=url.SecDisplay);
		}
		
		// SMC
		if( isDefined('SMC') AND SMC NEQ '')	{
			BreadCrumbs = 18;
			getCategory = application.Common.getTheseCategories(smc='#smc#');
		}
		
		// SMS
		if( isDefined('SMS') AND SMS NEQ '')	{
			BreadCrumbs = 19;
			getSection = application.Common.getTheseSections(sms='#sms#');
		}
		
		// NEXT N VALUES AND RESULTS PER PAGE VALUES
		if ( isDefined('getCategory') )	{
		if ( NOT isDefined('url.ShowRows') )	{
			url.ShowRows = getCategory.ShowColumns * getCategory.ShowRows ;
			Rows1 = url.ShowRows / getCategory.ShowColumns * getCategory.ShowRows ;
		}
		else
			Rows1 = getCategory.ShowColumns * getCategory.ShowRows ;
		}
		else if ( isDefined('getSection') )	{
			if ( not isDefined('url.ShowRows') )
			{
				url.ShowRows = getSection.ShowColumns * getSection.ShowRows ;
				Rows1 = url.ShowRows / getSection.ShowColumns * getSection.ShowRows ;
			}
			else
				Rows1 = getSection.ShowColumns * getSection.ShowRows ;
		}
		else
		{
			if ( NOT isDefined('url.ShowRows') )
			{
				url.ShowRows = 20 ;
				Rows1 = url.ShowRows ;
			}
			else
				Rows1 = url.ShowRows ;
		}
	
		RowsPerPage = url.ShowRows;
		TotalRows = getProducts.RecordCount;
		EndRow = Min(url.StartRow + RowsPerPage - 1, TotalRows);
		StartRowNext = EndRow + 1;
		StartRowBack = url.StartRow - RowsPerPage;
	</cfscript>


<cfmodule template="tags/layout.cfm" PageTitle="#PageTitle#" CurrentTab="Products">

<!--- Start Breadcrumb --->
<cfmodule template="tags/breadCrumbs.cfm" CrumbLevel='2' showLinkCrumb="#myCrumb#" />
<!--- End BreadCrumb --->

<!--- Start Product List --->
<!--- <cfdump var="#application#"> --->

<!--- End Product List --->

<table width="98%" align="center" border="0" cellpadding="0" cellspacing="0">
	
	
	<!--- CATEGORY IMAGE & DESCRIPTION --->
	<cfif isDefined('url.CatDisplay') >
	<tr> 
		<td class="cfHeading" align="center" valign="middle" width="100%">
			<cfoutput query="getCategory">
			<table width="100%" align="center" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<cfif CatImage NEQ '' AND CatImageDir NEQ ''>
					<td width="10%">
						<img src="images/#CatImageDir#/#CatImage#" border="0" align="absmiddle" hspace="15">
					</td>
					<td class="cfHeading">
						#CatName#
						<cfif CatDescription NEQ ''>
							<br><font class="cfDefault">#CatDescription#</font>
						</cfif>
					</td>
					<cfelse>
					<td width="100%" align="center" class="cfHeading">
						#CatName#
						<cfif CatDescription NEQ ''>
							<br><font class="cfDefault">#CatDescription#</font>
						</cfif>
					</td>
					</cfif>
				</tr>
			</table>
			</cfoutput>
		</td>
	</tr>
	
	
	<!--- SECTION IMAGE & DESCRIPTION --->
	<cfelseif isDefined('url.SecDisplay') >
	<tr> 
		<td class="cfHeading" align="center" valign="middle" width="100%">
			<cfoutput query="getSection">
			<table width="100%" align="center" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<cfif SecImage NEQ '' AND SecImageDir NEQ ''>
					<td width="10%">
						<img src="images/#SecImageDir#/#SecImage#" border="0" align="absmiddle" hspace="15">
					</td>
					<td class="cfHeading">
						#SecName#
						<cfif SecDescription NEQ ''>
							<br><font class="cfDefault">#SecDescription#</font>
						</cfif>
					</td>
					<cfelse>
					<td width="100%" align="center" class="cfHeading">
						#SecName#
						<cfif SecDescription NEQ ''>
							<br><font class="cfDefault">#SecDescription#</font>
						</cfif>
					</td>
					</cfif>
				</tr>
			</table>	
			</cfoutput>
		</td>
	</tr>
	
	<!--- SHOW ME CATEGORIES LIST --->
	<cfelseif isDefined('SMC') AND SMC NEQ '' >
	<tr> 
		<td class="cfHeading" valign="middle" colspan="2" style="padding-left:15px;">
			<img src="images/spacer.gif" width="17" height="1">
			<b>Showing:</b>&nbsp;
			<font class="cfDefault">
			<cfoutput>
			<cfloop list="#SMC#" index="i" delimiters=",">
				<CFQUERY NAME="getCatName" DATASOURCE="#application.dsn#">
					SELECT 		CatName 
					FROM 		Categories
					WHERE		CatID = #i#
					ORDER BY 	CatName
				</CFQUERY>
				#getCatName.CatName# &nbsp;
			</cfloop>
			</cfoutput>
			</font>
		</td>
	</tr>
	<!--- SHOW ME SECTIONS LIST --->
	<cfelseif isDefined('SMS') AND SMS NEQ '' >
	<tr> 
		<td class="cfHeading" valign="middle" colspan="2" style="padding-left:15px;">
			<b>Showing:</b>&nbsp;
			<font class="cfDefault">
			<cfoutput>
			<cfloop list="#SMS#" index="i" delimiters=","> 
				<CFQUERY NAME="getSecName" DATASOURCE="#application.dsn#">
					SELECT 		SecName 
					FROM 		Sections
					WHERE		SectionID = #i#
					ORDER BY 	SecName
				</CFQUERY>
				#getSecName.SecName# &nbsp;
			</cfloop>
			</cfoutput>
			</font>
		</td>
	</tr>
	</cfif>
	
	<!--- DROP DOWN MENUS --->
	<tr>
	<form action="ProductList.cfm" method="get">
		<td class="cfDefault" align="center" colspan="2" style="padding-top:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="productlist">
				<tr>
					<td width="100%" align="center">
						<cfif isDefined('url.CatDisplay') OR ( isDefined('SMC') AND SMC NEQ '' )>
							<cfinclude template="Includes/DDLCat.cfm">
							<cfif isDefined('SMC') AND SMC NEQ '' >
								<input type="hidden" name="SMC" value="<cfoutput>#SMC#</cfoutput>" >
							</cfif>
						<cfelseif isDefined('url.SecDisplay') OR ( isDefined('SMS') AND SMS NEQ '' )>
							<cfinclude template="Includes/DDLSec.cfm">
							<cfif isDefined('SMS') AND SMS NEQ '' >
								<input type="hidden" name="SMS" value="<cfoutput>#SMS#</cfoutput>" >
							</cfif>
						</cfif>
						&nbsp;&nbsp;
						Results Per Page: 
						<select name="ShowRows" class="cfFormField" onChange="this.form.submit();">
							<cfoutput>
							<option value="#Rows1#" <cfif url.ShowRows EQ Rows1 >selected</cfif>>#Rows1#</option>
							<option value="#(Rows1 * 2)#" <cfif url.ShowRows EQ (Rows1 * 2)>selected</cfif>>#(Rows1 * 2)#</option>
							<option value="#(Rows1 * 4)#" <cfif url.ShowRows EQ (Rows1 * 4)>selected</cfif>>#(Rows1 * 4)#</option>
							<option value="#(Rows1 * 100)#" <cfif url.ShowRows EQ (Rows1 * 100)>selected</cfif>>ALL</option>
							</cfoutput>
						</select>
						&nbsp;&nbsp;
						<input type="submit" value="GO" align="absmiddle" class="button" style="width:27px;">
					</td>
				</tr>
			</table>
		</td>
		</form>
	</tr>
	
	<!--- PRODUCT LIST --->
	<tr> 
		<td valign="top" colspan="2">
		<cfinclude template="Includes/ProductListDisplay.cfm">
			<!--- <table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">
				<tr>
					<td>
						<cfinclude template="Includes/ProductListDisplay.cfm">
					</td>
				</tr>
			</table> --->			
		</td>
	</tr>
	
	<!--- SUB-CATEGORIES --->
	<cfif isDefined('getCategories') AND getCategories.RecordCount GT 0 >
	<tr>
		<td valign="top" colspan="2" align="center">
			<cfinclude template="Includes/CategoryDisplay.cfm">
		</td>
	</tr>
	</cfif>
	
	<!--- SUB-SECTIONS --->
	<cfif isDefined('getSections') AND getSections.RecordCount GT 0 >
	<tr>
		<td valign="top" colspan="2" align="center">
			<cfinclude template="Includes/SectionDisplay.cfm">
		</td>
	</tr>
	</cfif>

	<!--- NAVIGATION --->
	<tr>
		<td valign="top" colspan="2">
			<cfif TotalRows GT 0 >
			
			<!--- Pagination --->
			
			<div id="pagination">
				<p><strong><!--- <cfif Previous> ---><a href="index.cfm?go=purchase&StartRow=#PreviousStart#&PageNum=#DecrementValue(PageNum)#">Previous</a><!--- <cfelse><span>Previous</span></cfif> ---></strong>
				<cfloop from="1" to="7" index="i">
					<cfoutput><a href="">#i#</a></cfoutput>
				</cfloop>
			<strong><a href="index.cfm?go=purchase&StartRow=#NextStart#&PageNum=#IncrementValue(PageNum)#">Next</a></strong>
			
			</p>
			</div>
			
			<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="productlist">
				<tr>
					<td class="cfDefault" width="33%"><cfoutput>Displaying <B>#url.StartRow#</B> to <B>#EndRow#</B> of <B>#TotalRows#</B> Products</cfoutput></td>
					<td align="center" width="33%">
						<a href="javascript:history.back()"><img src="images/button-back.gif" border="0"></a> 
						<a href="index.cfm"><img src="images/button-home.gif" border="0"></a>
					</td>
					<td align="right" width="33%"><cfinclude template="Includes/NextNButtons.cfm"></td>
				</tr>
			</table>
			
			
			
			
			
			</cfif>
		</td>
	</tr>
    
    <!--- CATEGORY DETAIL --->
	<cfif isDefined('url.CatDisplay') AND isDefined('getCategory.CatSummary') AND TRIM(getCategory.CatSummary) NEQ '' >
	<tr>
		<td valign="top" colspan="2" align="center">
			<cfoutput>#getCategory.CatSummary#</cfoutput>
		</td>
	</tr>
	</cfif>
	<!--- SECTION DETAIL --->
	<cfif isDefined('url.SecDisplay') AND isDefined('getSection.SecSummary') AND TRIM(getSection.SecSummary) NEQ '' >
	<tr>
		<td valign="top" colspan="2" align="center">
			<cfoutput>#getSection.SecSummary#</cfoutput>
		</td>
	</tr>
	</cfif>
	
</table>

</cfmodule>



<!--- <cfinclude template="LayoutGlobalHeader.cfm">

<img src="images/spacer.gif" width="1" height="5"><br>

<table width="98%" align="center" border="0" cellpadding="0" cellspacing="0">
	
	<!--- CATEGORY IMAGE & DESCRIPTION --->
	<cfif isDefined('url.CatDisplay') >
	<tr> 
		<td class="cfHeading" align="center" valign="middle" width="100%">
			<cfoutput query="getCategory">
			<table width="100%" align="center" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<cfif CatImage NEQ '' AND CatImageDir NEQ ''>
					<td width="10%">
						<img src="images/#CatImageDir#/#CatImage#" border="0" align="absmiddle" hspace="15">
					</td>
					<td class="cfHeading">
						#CatName#
						<cfif CatDescription NEQ ''>
							<br><font class="cfDefault">#CatDescription#</font>
						</cfif>
					</td>
					<cfelse>
					<td width="100%" align="center" class="cfHeading">
						#CatName#
						<cfif CatDescription NEQ ''>
							<br><font class="cfDefault">#CatDescription#</font>
						</cfif>
					</td>
					</cfif>
				</tr>
			</table>
			</cfoutput>
		</td>
	</tr>
	<!--- SECTION IMAGE & DESCRIPTION --->
	<cfelseif isDefined('url.SecDisplay') >
	<tr> 
		<td class="cfHeading" align="center" valign="middle" width="100%">
			<cfoutput query="getSection">
			<table width="100%" align="center" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<cfif SecImage NEQ '' AND SecImageDir NEQ ''>
					<td width="10%">
						<img src="images/#SecImageDir#/#SecImage#" border="0" align="absmiddle" hspace="15">
					</td>
					<td class="cfHeading">
						#SecName#
						<cfif SecDescription NEQ ''>
							<br><font class="cfDefault">#SecDescription#</font>
						</cfif>
					</td>
					<cfelse>
					<td width="100%" align="center" class="cfHeading">
						#SecName#
						<cfif SecDescription NEQ ''>
							<br><font class="cfDefault">#SecDescription#</font>
						</cfif>
					</td>
					</cfif>
				</tr>
			</table>	
			</cfoutput>
		</td>
	</tr>
	<!--- SHOW ME CATEGORIES LIST --->
	<cfelseif isDefined('SMC') AND SMC NEQ '' >
	<tr> 
		<td class="cfHeading" valign="middle" colspan="2" style="padding-left:15px;">
			<img src="images/spacer.gif" width="17" height="1">
			<b>Showing:</b>&nbsp;
			<font class="cfDefault">
			<cfoutput>
			<cfloop list="#SMC#" index="i" delimiters=",">
				<CFQUERY NAME="getCatName" DATASOURCE="#application.dsn#">
					SELECT 		CatName 
					FROM 		Categories
					WHERE		CatID = #i#
					ORDER BY 	CatName
				</CFQUERY>
				#getCatName.CatName# &nbsp;
			</cfloop>
			</cfoutput>
			</font>
		</td>
	</tr>
	<!--- SHOW ME SECTIONS LIST --->
	<cfelseif isDefined('SMS') AND SMS NEQ '' >
	<tr> 
		<td class="cfHeading" valign="middle" colspan="2" style="padding-left:15px;">
			<b>Showing:</b>&nbsp;
			<font class="cfDefault">
			<cfoutput>
			<cfloop list="#SMS#" index="i" delimiters=","> 
				<CFQUERY NAME="getSecName" DATASOURCE="#application.dsn#">
					SELECT 		SecName 
					FROM 		Sections
					WHERE		SectionID = #i#
					ORDER BY 	SecName
				</CFQUERY>
				#getSecName.SecName# &nbsp;
			</cfloop>
			</cfoutput>
			</font>
		</td>
	</tr>
	</cfif>
	
	<!--- DROP DOWN MENUS --->
	<tr>
	<form action="ProductList.cfm" method="get">
		<td class="cfDefault" align="center" colspan="2" style="padding-top:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="productlist">
				<tr>
					<td width="100%" align="center">
						<cfif isDefined('url.CatDisplay') OR ( isDefined('SMC') AND SMC NEQ '' )>
							<cfinclude template="Includes/DDLCat.cfm">
							<cfif isDefined('SMC') AND SMC NEQ '' >
								<input type="hidden" name="SMC" value="<cfoutput>#SMC#</cfoutput>" >
							</cfif>
						<cfelseif isDefined('url.SecDisplay') OR ( isDefined('SMS') AND SMS NEQ '' )>
							<cfinclude template="Includes/DDLSec.cfm">
							<cfif isDefined('SMS') AND SMS NEQ '' >
								<input type="hidden" name="SMS" value="<cfoutput>#SMS#</cfoutput>" >
							</cfif>
						</cfif>
						&nbsp;&nbsp;
						Results Per Page: 
						<select name="ShowRows" class="cfFormField" onChange="this.form.submit();">
							<cfoutput>
							<option value="#Rows1#" <cfif url.ShowRows EQ Rows1 >selected</cfif>>#Rows1#</option>
							<option value="#(Rows1 * 2)#" <cfif url.ShowRows EQ (Rows1 * 2)>selected</cfif>>#(Rows1 * 2)#</option>
							<option value="#(Rows1 * 4)#" <cfif url.ShowRows EQ (Rows1 * 4)>selected</cfif>>#(Rows1 * 4)#</option>
							<option value="#(Rows1 * 100)#" <cfif url.ShowRows EQ (Rows1 * 100)>selected</cfif>>ALL</option>
							</cfoutput>
						</select>
						&nbsp;&nbsp;
						<input type="submit" value="GO" align="absmiddle" class="cfButton" style="width:27px;">
					</td>
				</tr>
			</table>
		</td>
		</form>
	</tr>
	
	<!--- PRODUCT LIST --->
	<tr> 
		<td valign="top" colspan="2">
			<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">
				<tr>
					<td>
						<cfinclude template="Includes/ProductListDisplay.cfm">
					</td>
				</tr>
			</table>			
		</td>
	</tr>
	
	<!--- SUB-CATEGORIES --->
	<cfif isDefined('getCategories') AND getCategories.RecordCount GT 0 >
	<tr>
		<td valign="top" colspan="2" align="center">
			<cfinclude template="Includes/CategoryDisplay.cfm">
		</td>
	</tr>
	</cfif>
	
	<!--- SUB-SECTIONS --->
	<cfif isDefined('getSections') AND getSections.RecordCount GT 0 >
	<tr>
		<td valign="top" colspan="2" align="center">
			<cfinclude template="Includes/SectionDisplay.cfm">
		</td>
	</tr>
	</cfif>

	<!--- NAVIGATION --->
	<tr>
		<td valign="top" colspan="2">
			<cfif TotalRows GT 0 >
			<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="productlist">
				<tr>
					<td class="cfDefault" width="33%"><cfoutput>Displaying <B>#url.StartRow#</B> to <B>#EndRow#</B> of <B>#TotalRows#</B> Products</cfoutput></td>
					<td align="center" width="33%">
						<a href="javascript:history.back()"><img src="images/button-back.gif" border="0"></a> 
						<a href="index.cfm"><img src="images/button-home.gif" border="0"></a>
					</td>
					<td align="right" width="33%"><cfinclude template="Includes/NextNButtons.cfm"></td>
				</tr>
			</table>
			</cfif>
		</td>
	</tr>
    
    <!--- CATEGORY DETAIL --->
	<cfif isDefined('url.CatDisplay') AND isDefined('getCategory.CatSummary') AND TRIM(getCategory.CatSummary) NEQ '' >
	<tr>
		<td valign="top" colspan="2" align="center">
			<cfoutput>#getCategory.CatSummary#</cfoutput>
		</td>
	</tr>
	</cfif>
	<!--- SECTION DETAIL --->
	<cfif isDefined('url.SecDisplay') AND isDefined('getSection.SecSummary') AND TRIM(getSection.SecSummary) NEQ '' >
	<tr>
		<td valign="top" colspan="2" align="center">
			<cfoutput>#getSection.SecSummary#</cfoutput>
		</td>
	</tr>
	</cfif>
	
</table>

<cfinclude template="LayoutGlobalFooter.cfm"> --->