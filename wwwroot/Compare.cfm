<cfscript>
	PageTitle = 'COMPARE PRODUCTS' ;
	BannerTitle = 'Catalog' ;
	HideLeftNav = 1 ;
</cfscript>
<cfinclude template="LayoutGlobalHeader.cfm">

<cfparam name="URL.PT" default="0">
<cfparam name="URL.ID" default="0">

<cfquery name="getComparables" datasource="#application.dsn#">
	SELECT	p.ItemID, p.SKU, p.ItemName, p.ImageSmall, p.ImageDir, p.Price#session.CustomerArray[28]# AS PriceToUse,
			p.ItemDescription, p.ItemDetails, p.CompareType,
			( SELECT COUNT(ItemID) FROM ProductSpecs WHERE ItemID = p.ItemID ) AS HasSpecs
	FROM	Products p
	WHERE 	(
			<cfloop index="i" list="#URL.ID#" delimiters="," > ItemID = #i# <cfif i NEQ ListLast(URL.ID)> OR </cfif> </cfloop>
			)
	ORDER BY HasSpecs DESC, CompareType DESC
</cfquery>

<table cellpadding="0" cellspacing="0" border="0" width="100%">
	<tr valign="top">
		<td class="sub_pagehead"><span class="sub_pagetitle">Product Comparisons<br></span></td>
	</tr>
</table>

<img src="images/spacer.gif" height="3" width="1"><br>

<cfoutput>
<table width="#Evaluate(getComparables.RecordCount * 150)#" border="0" bordercolor="###layout.PrimaryBGColor#" cellpadding="1" cellspacing="0">

	<cfset TitlesSet = 0 >
	<tr>
	<cfloop query="getComparables">
							
		<cfquery name="getProdSpecs" datasource="#application.dsn#">
			SELECT	*
			FROM	ProductSpecs
			WHERE	ItemID = #ItemID#
		</cfquery>
	
		<cfif getProdSpecs.RecordCount NEQ 0 >

			<cfinvoke component="#application.Queries#" method="getProductType" returnvariable="getProductType">
				<cfinvokeargument name="TypeID" value="#getComparables.CompareType#">
			</cfinvoke>
			
			<cfif TitlesSet EQ 0 >
			<!--- SPEC TITLES --->
			<td class="cfDefault" width="150" valign="top"> 
				<table width="150" border="1" cellpadding="7" cellspacing="0" bordercolor="###layout.TableHeadingBGColor#">
					<tr bordercolor="###layout.PrimaryBGColor#"><td class="cfDefault" height="120" nowrap><img src="images/spacer.gif" height="120" width="150" /></td></tr>
					<tr bordercolor="###layout.TableHeadingBGColor#"><td class="cfDefault" bgcolor="#layout.TableHeadingBGColor#"><font class="cfTableHeading">Name</font></td></tr>
					<tr bordercolor="###layout.PrimaryBGColor#"><td class="cfDefault" ><a>SKU</a></td></tr>
					<tr bordercolor="###layout.TableHeadingBGColor#"><td class="cfAttract" bgcolor="#layout.TableHeadingBGColor#"><font class="cfTableHeading">Price</font></td></tr>
					<cfloop from="1" to="#getProductType.SpecCount#" index="i">
						<cfset ThisSpecTitle = Evaluate("getProductType.SpecTitle" & i) >
					<tr bordercolor="###layout.PrimaryBGColor#">
						<td class="cfMini" bgcolor="#IIF(((i MOD 2) is 0),de('E9E9E9'),de('FFFFFF'))#" nowrap >
							#ThisSpecTitle#&nbsp;
						</td>
					</tr>
					</cfloop>
				</table>
			</td>
			</cfif>
			<cfset TitlesSet = 1 >
			
			<!--- SPEC VALUES --->
			<cfloop query="getProdSpecs">
				<!--- GET PRODUCT IMAGE & INFO --->
				<cfquery name="getProductInfo" dbtype="query">
					SELECT	*
					FROM	getComparables
					WHERE	ItemID = #getProdSpecs.ItemID#
				</cfquery>
				<td class="cfDefault" width="150" valign="top"> 
					<table width="100%" border="1" cellpadding="7" bordercolor="###layout.TableHeadingBGColor#">
						<tr bordercolor="###layout.PrimaryBGColor#"><td class="cfDefault" align="center" height="120" nowrap>
							<table width="150" border="0" cellpadding="0" cellspacing="0" align="center">
								<tr><td align="center">
									<a href="ProductDetail.cfm?ItemID=#getProductInfo.ItemID#">
									<cfif getProductInfo.ImageSmall IS ''>
										<cfif FileExists(#config.IU_VirtualPathDIR# & '\' & #getProductInfo.ImageDir# & '\' & #getProductInfo.SKU# & 'sm.jpg')>
											<img src="images/#getProductInfo.ImageDir#/#getProductInfo.SKU#sm.jpg" border="0" align="middle" alt='#getProductInfo.ItemName#'></a>&nbsp;&nbsp;
										<cfelse>
											<img src="images/image-EMPTY.gif" border="0" align="middle" alt='#getProductInfo.ItemName#'></a>&nbsp;&nbsp;
										</cfif>
									<cfelse>
										<cfif FileExists(#config.IU_VirtualPathDIR# & '\' & #getProductInfo.ImageDir# & '\' & #getProductInfo.ImageSmall#)>
											<img src="images/#getProductInfo.ImageDir#/#getProductInfo.ImageSmall#" border="0" align="middle" alt='#getProductInfo.ItemName#'></a>&nbsp;&nbsp;
										<cfelse>								
											<img src="images/image-EMPTY.gif" border="0" align="middle" alt='#getProductInfo.ItemName#'></a>&nbsp;&nbsp;
										</cfif>
									</cfif>
								</td></tr>
							</table></td></tr>
						<tr bordercolor="###layout.TableHeadingBGColor#"><td class="cfDefault" align="center" bgcolor="#layout.TableHeadingBGColor#" nowrap>
							<a href="ProductDetail.cfm?ItemID=#getProductInfo.ItemID#"><font class="cfTableHeading">#getProductInfo.ItemName#</font></a></td></tr>
						<tr bordercolor="###layout.PrimaryBGColor#"><td class="cfDefault" align="center">
							<a href="ProductDetail.cfm?ItemID=#getProductInfo.ItemID#" nowrap>#getProductInfo.SKU#</a></td></tr>
						<tr bordercolor="###layout.TableHeadingBGColor#"><td class="cfAttract" align="center" bgcolor="#layout.TableHeadingBGColor#" nowrap>
							<font class="cfTableHeading">#LSCurrencyFormat(getProductInfo.PriceToUse)#</font></td></tr>
						
						<cfloop from="1" to="#getProductType.SpecCount#" index="i">
							<cfset ThisSpecValue = Evaluate("getProdSpecs.Spec" & i) >
							<tr bordercolor="###layout.PrimaryBGColor#">
								<td class="cfMini" align="center" bgcolor="#IIF(((i MOD 2) is 0),de('E9E9E9'),de('FFFFFF'))#" nowrap >
									#ThisSpecValue#&nbsp;
								</td>
							</tr>		
						</cfloop>
						<tr bordercolor="###layout.PrimaryBGColor#"><td class="cfMini" >
							#getProductInfo.ItemDescription#</td></tr>
						<tr bordercolor="###layout.PrimaryBGColor#"><td class="cfMini" rowspan="20" >
							#getProductInfo.ItemDetails#</td></tr>	
					</table>
				</td>
			</cfloop>

		<cfelse>
			<!--- GET PRODUCT IMAGE & INFO --->
			<cfquery name="getProductInfo" dbtype="query">
				SELECT	*
				FROM	getComparables
				WHERE	ItemID = #getComparables.ItemID#
			</cfquery>
			<td class="cfDefault" width="150" valign="top"> 
				<table width="100%" border="1" cellpadding="7" cellspacing="0" bordercolor="###layout.TableHeadingBGColor#">
					<tr bordercolor="###layout.PrimaryBGColor#"><td class="cfDefault" align="center" height="120" nowrap>
						<table width="150" border="0" cellpadding="0" cellspacing="0" align="center">
							<tr><td align="center">
								<a href="ProductDetail.cfm?ItemID=#getProductInfo.ItemID#">
								<cfif getProductInfo.ImageSmall IS ''>
									<cfif FileExists(#config.IU_VirtualPathDIR# & '\' & #getProductInfo.ImageDir# & '\' & #getProductInfo.SKU# & 'sm.jpg')>
										<img src="images/#getProductInfo.ImageDir#/#getProductInfo.SKU#sm.jpg" border="0" align="middle" alt='#getProductInfo.ItemName#'></a>&nbsp;&nbsp;
									<cfelse>
										<img src="images/image-EMPTY.gif" border="0" align="middle" alt='#getProductInfo.ItemName#'></a>&nbsp;&nbsp;
									</cfif>
								<cfelse>
									<cfif FileExists(#config.IU_VirtualPathDIR# & '\' & #getProductInfo.ImageDir# & '\' & #getProductInfo.ImageSmall#)>
										<img src="images/#getProductInfo.ImageDir#/#getProductInfo.ImageSmall#" border="0" align="middle" alt='#getProductInfo.ItemName#'></a>&nbsp;&nbsp;
									<cfelse>								
										<img src="images/image-EMPTY.gif" border="0" align="middle" alt='#getProductInfo.ItemName#'></a>&nbsp;&nbsp;
									</cfif>
								</cfif>
							</td></tr>
						</table></td></tr>
					<tr bordercolor="###layout.TableHeadingBGColor#"><td class="cfDefault" align="center" bgcolor="#layout.TableHeadingBGColor#" nowrap>
						<a href="ProductDetail.cfm?ItemID=#getProductInfo.ItemID#"><font class="cfTableHeading">#getProductInfo.ItemName#</font></a></td></tr>
					<tr bordercolor="###layout.PrimaryBGColor#"><td class="cfDefault" align="center" nowrap>
						<a href="ProductDetail.cfm?ItemID=#getProductInfo.ItemID#">#getProductInfo.SKU#</a></td></tr>
					<tr bordercolor="###layout.TableHeadingBGColor#"><td class="cfAttract" align="center" bgcolor="#layout.TableHeadingBGColor#" nowrap>
						<font class="cfTableHeading">#LSCurrencyFormat(getProductInfo.PriceToUse)#</font></td></tr>
					<tr bordercolor="###layout.PrimaryBGColor#"><td class="cfMini" >
						#getProductInfo.ItemDescription#</td></tr>
					<tr bordercolor="###layout.PrimaryBGColor#"><td class="cfMini" rowspan="20" >
						#getProductInfo.ItemDetails#</td></tr>	
				</table>
			</td>
		</cfif>
		
		<cfif CurrentRow NEQ RecordCount AND NOT CurrentRow MOD RecordCount >
		</tr>
		<tr>
		</cfif>

	</cfloop>
	</tr>
</table>
</cfoutput>

<div align="center">
	<br>
	<br>
	<a href="javascript:history.back()"><img src="images/button-back.gif" border="0"></a> 
	<a href="index.cfm"><img src="images/button-home.gif" border="0"></a> 
	<br>
	<br>
</div>

<cfinclude template="LayoutGlobalFooter.cfm">