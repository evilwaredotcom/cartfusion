
<cfparam name="url.PT" default="0">
<cfparam name="url.ID" default="0">

<cfoutput>
	
	<cfmodule template="templates/#application.SiteTemplate#/layout.cfm" showcategories="false" layoutstyle="full" pagetitle="Compare Products" currenttab="Products">
	
	<!--- Start Breadcrumb --->
	<cfmodule template="tags/breadCrumbs.cfm" crumblevel='2' showlinkcrumb="Selected Products|Compare" />
	<!--- End BreadCrumb --->
	
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

	<!--- Results from Compare Query go here --->
	<div class="pageSectionHeader">Product Comparisons</div>
	<div align="center">
		<cfif getComparables.RecordCount >
			<table width="#Evaluate(getComparables.RecordCount * 150)#" border="0" cellpadding="1" cellspacing="0">
				<tr>
			<cfloop query="getComparables">
				<cfscript>
					getProdSpecs = application.queries.getProductSpecs(ItemID=getComparables.ItemID);
					if( getProdSpecs.RecordCount )	{
						getProductType = application.Queries.getProductType(TypeID=getComparables.CompareType);
					}
				</cfscript>
				<cfif getProdSpecs.RecordCount >
					<cfscript>
						getProductType = application.Queries.getProductType(TypeID=getComparables.CompareType);
					</cfscript>
					<!--- SPEC VALUES --->
					<cfloop query="getProdSpecs">
						<!--- GET PRODUCT IMAGE & INFO --->
						<cfquery name="getProductInfo" dbtype="query">
							SELECT	*
							FROM	getComparables
							WHERE	ItemID = #getProdSpecs.ItemID#
						</cfquery>
						<td class="cfDefault" width="150" valign="top"><table width="100%" border="1" cellpadding="7">
								<tr>
									<td class="cfDefault" align="center" height="120" nowrap><table width="150" border="0" cellpadding="0" cellspacing="0" align="center">
											<tr>
												<td align="center"><a href="ProductDetail.cfm?ItemID=#getProductInfo.ItemID#">
													<cfif getProductInfo.ImageSmall IS ''>
														<cfif FileExists(application.ImageServerPath & '\' & getProductInfo.ImageDir & '\' & getProductInfo.SKU & 'sm.jpg')>
															<img src="images/#getProductInfo.ImageDir#/#getProductInfo.SKU#sm.jpg" border="0" align="middle" alt='#getProductInfo.ItemName#'></a>&nbsp;&nbsp;
															<cfelse>
															<img src="images/image-EMPTY.gif" border="0" align="middle" alt='#getProductInfo.ItemName#'></a>&nbsp;&nbsp;
														</cfif>
														<cfelse>
														<cfif FileExists(application.ImageServerPath & '\' & getProductInfo.ImageDir & '\' & getProductInfo.ImageSmall)>
															<img src="images/#getProductInfo.ImageDir#/#getProductInfo.ImageSmall#" border="0" align="middle" alt='#getProductInfo.ItemName#'></a>&nbsp;&nbsp;
															<cfelse>
															<img src="images/image-EMPTY.gif" border="0" align="middle" alt='#getProductInfo.ItemName#'></a>&nbsp;&nbsp;
														</cfif>
													</cfif>
												</td>
											</tr>
										</table></td>
								</tr>
								<tr>
									<td class="cfDefault" align="center" nowrap><a href="ProductDetail.cfm?ItemID=#getProductInfo.ItemID#"><font class="cfTableHeading">#getProductInfo.ItemName#</font></a></td>
								</tr>
								<tr>
									<td class="cfDefault" align="center"><a href="ProductDetail.cfm?ItemID=#getProductInfo.ItemID#" nowrap>#getProductInfo.SKU#</a></td>
								</tr>
								<tr>
									<td class="cfAttract" align="center" nowrap><font class="cfTableHeading">#LSCurrencyFormat(getProductInfo.PriceToUse)#</font></td>
								</tr>
								<cfif isDefined('getProductType') >
								<cfloop from="1" to="#NumberFormat(getProductType.SpecCount,0)#" index="i">
									<cfset ThisSpecTitle = Evaluate("getProductType.SpecTitle" & i) >
									<cfset ThisSpecValue = Evaluate("getProdSpecs.Spec" & i) >
									<tr>
										<td class="cfMini" align="center" bgcolor="###IIF(((i MOD 2) is 0),de('E9E9E9'),de('FFFFFF'))#"><b>#ThisSpecTitle#</b><br/>#ThisSpecValue#</td>
									</tr>
								</cfloop>
								</cfif>
								<tr>
									<td class="cfMini" >#getProductInfo.ItemDescription#</td>
								</tr>
								<tr>
									<td class="cfMini" rowspan="20" >#getProductInfo.ItemDetails#</td>
								</tr>
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
						<table width="100%" border="1" cellpadding="7" cellspacing="0">
							<tr><td class="cfDefault" align="center" height="120" nowrap>
								<table width="150" border="0" cellpadding="0" cellspacing="0" align="center">
									<tr><td align="center">
										<a href="ProductDetail.cfm?ItemID=#getProductInfo.ItemID#">
										<cfif getProductInfo.ImageSmall IS ''>
											<cfif FileExists(application.ImageServerPath & '\' & getProductInfo.ImageDir & '\' & getProductInfo.SKU & 'sm.jpg')>
												<img src="images/#getProductInfo.ImageDir#/#getProductInfo.SKU#sm.jpg" border="0" align="middle" alt='#getProductInfo.ItemName#'></a>&nbsp;&nbsp;
											<cfelse>
												<img src="images/image-EMPTY.gif" border="0" align="middle" alt='#getProductInfo.ItemName#'></a>&nbsp;&nbsp;
											</cfif>
										<cfelse>
											<cfif FileExists(application.ImageServerPath & '\' & getProductInfo.ImageDir & '\' & getProductInfo.ImageSmall)>
												<img src="images/#getProductInfo.ImageDir#/#getProductInfo.ImageSmall#" border="0" align="middle" alt='#getProductInfo.ItemName#'></a>&nbsp;&nbsp;
											<cfelse>								
												<img src="images/image-EMPTY.gif" border="0" align="middle" alt='#getProductInfo.ItemName#'></a>&nbsp;&nbsp;
											</cfif>
										</cfif>
									</td></tr>
								</table></td></tr>
							<tr><td class="cfDefault" align="center" nowrap>
								<a href="ProductDetail.cfm?ItemID=#getProductInfo.ItemID#"><font class="cfTableHeading">#getProductInfo.ItemName#</font></a></td></tr>
							<tr><td class="cfDefault" align="center" nowrap>
								<a href="ProductDetail.cfm?ItemID=#getProductInfo.ItemID#">#getProductInfo.SKU#</a></td></tr>
							<tr><td class="cfAttract" align="center" nowrap>
								<font class="cfTableHeading">#LSCurrencyFormat(getProductInfo.PriceToUse)#</font></td></tr>
							<tr><td class="cfMini" >
								#getProductInfo.ItemDescription#</td></tr>
							<tr><td class="cfMini" rowspan="20" >
								#getProductInfo.ItemDetails#</td></tr>	
						</table>
					</td>
				</cfif>
			</cfloop>
				</tr>
			</table>
		</cfif>
	</div>
	
	<div align="center"> <br/>
		<br/>
		<hr class="snip" />
		<br/>
		<input type="button" name="GoBack" value="&lt; BACK" class="button2" onclick="javascript:history.back();">
		<input type="button" name="GoHome" value="HOME &gt;" class="button2" onclick="javascript:document.location.href='index.cfm';">
		<br/>
		<br/>
	</div>
	
	</cfmodule>
	
</cfoutput>

