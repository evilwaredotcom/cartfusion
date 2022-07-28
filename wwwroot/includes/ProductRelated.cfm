<!--- THIS IS THE START OF THE RELATED ITEMS TABLEs --->
<cfif application.siteConfig.data.EnableRelated EQ 1>

	<cfscript>
		relatedList = application.Common.getRelatedItems(UserID=session.CustomerArray[28],ItemID=ItemID);
	</cfscript>
	
	<!--- <cfinvoke component="#application.Common#" method="getRelatedItems" returnvariable="relatedList">
		<cfinvokeargument name="UserID" value="#session.CustomerArray[28]#">
		<cfinvokeargument name="ItemID" value="#ItemID#">
	</cfinvoke> --->
	
	<cfif relatedList.RecordCount>
	<!---<cfset ColsToShow = 1 >--->
	
		<table border="0" <!--- style="border-color:<cfoutput>#layout.TableHeadingBGColor#</cfoutput>;"  --->cellpadding="3" cellspacing="0" align="center">
			<!--- BEGIN COLUMNAR OUTPUT --->
			<tr>
			<cfoutput query="relatedList" group="ItemID">
			
				<!--- CARTFUSION 4.6 - CART CFC --->
				<cfscript>
					if ( TRIM(session.CustomerArray[28]) NEQ '' ) {
						UserID = session.CustomerArray[28] ;
					} else {
						UserID = 1 ;
					}
                    UseThisPrice = application.Cart.getItemPrice(
						UserID=UserID,
						SiteID=application.siteConfig.data.SiteID,
						ItemID=ItemID,
						SessionID=caller.SessionID);
                </cfscript>
								
				<td class="cfDefault" width="100%"> 
					<table width="100%" border="0" cellpadding="7" cellspacing="0">
						<tr>
							<td width="20%" align="center" class="cfDefault"> 
								<a href="ProductDetail.cfm?ItemID=#ItemID#">
								<cfif relatedList.ImageSmall IS ''>
									<cfif FileExists(#config.IU_VirtualPathDIR# & '\' & #ImageDir# & '\' & #SKU# & '.jpg')>
										<img src="images/#ImageDir#/#SKU#.jpg" border="0" align="middle" alt="#ItemName#"><br>
										<!---<img src="images/button-detail.gif" border="0" align="middle">---></a>
									<cfelse>
										<img src="images/image-empty.gif" border="0" align="middle" alt="#ItemName#"><br>
										<!---<img src="images/button-detail.gif" border="0" align="middle">---></a>
									</cfif>
								<cfelse>
									<cfif FileExists(#config.IU_VirtualPathDIR# & '\' & #ImageDir# & '\' & #ImageSmall#)>
										<img src="images/#ImageDir#/#ImageSmall#" border="0" align="middle" alt="#ItemName#"><br>
										<!---<img src="images/button-detail.gif" border="0" align="middle">---></a>
									<cfelse>											
										<img src="images/image-empty.gif" border="0" align="middle" alt="#ItemName#"><br>
										<!---<img src="images/button-detail.gif" border="0" align="middle">---></a>
									</cfif>
								</cfif>
							</td>
							<td width="55%" class="cfDefault">
								<font class="cfMessageThree"><a href="ProductDetail.cfm?ItemID=#ItemID#">#ItemName#</a></font><br>
								<!--- SHOW SKU --->
								<font class="cfMessage">SKU: #SKU#</font><br>
								<font class="cfDefault">#ShortDescription#</font><br>
								<a href="ProductDetail.cfm?ItemID=#ItemID#">more</a><br>
							</td>
							<td width="25%" class="cfDefault" align="center">
								
								<cfscript>
									getProductOptionsCount = application.Queries.getProductOptionsCount(ItemID=ItemID);
									
									// CHECK STOCK QUANTITY OF ITEM
									if ( SellByStock EQ 1 )
									{
										if ( StockQuantity LTE 0 )
											ItemAvailable = 0 ;
										else
											ItemAvailable = 1 ;
									}
									// CHECK AVAILABILITY OF ITEM
									else if ( ItemStatus IS 'DI' OR ItemStatus IS 'OS' )
										ItemAvailable = 0 ;
									else
										ItemAvailable = 1 ;
									// CHECK IF BACK ORDERED
									if ( ItemStatus EQ 'BO' )
										RelatedBackOrdered = 1;
								</cfscript>
								
								<!--- <cfinvoke component="#application.Queries#" method="getProductOptionsCount" returnvariable="getProductOptionsCount">
									<cfinvokeargument name="ItemID" value="#ItemID#">
								</cfinvoke> --->
								
								<cfif ItemAvailable EQ 1 AND getProductOptionsCount.POCount EQ 0 >
									<form action="CartUpdate.cfm" method="post">
										<font class="cfAttract">#LSCurrencyFormat(UseThisPrice, "local")#</font><br>
										<img src="images/spacer.gif" width="1" height="5"><br>
										<font class="cfMini">Qty:</font>
										<input type="hidden" name="ItemID" value="#ItemID#">										
										<input class="cfMini" type="text" name="Quantity" size="1" maxlenth="4" value="1" align="absmiddle"><br>
										<img src="images/spacer.gif" width="1" height="5"><br>
										<cfif isDefined('RelatedBackOrdered') AND RelatedBackOrdered EQ 1 >
											<input type="image" name="AddButton" src="images/button-Add.gif" align="absmiddle" 
												onClick="return confirm('This item is back-ordered.  Would you like to add it to your cart anyway?\nWe will ship the item to you as soon as it becomes available.\nAlso, we will NOT charge you until the item is shipped.')" >
											<input type="hidden" name="BackOrdered" value="1">
										<cfelse>
											<input type="image" name="AddButton" src="images/button-Add.gif" align="absmiddle" >
										</cfif>
									</form>
								<cfelse>
									<form action="ProductDetail.cfm?ItemID=#ItemID#" method="post">
										<font class="cfAttract">#LSCurrencyFormat(UseThisPrice, "local")#</font><br>
										<img src="images/spacer.gif" width="1" height="5"><br>
										<input type="image" name="MoreInfoButton" src="images/button-moreinfo.gif" align="absmiddle">
									</form>
								</cfif>
								
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr><td width="100%" height="1" <!--- style="background-color:#layout.TableHeadingBGColor#;" --->></td></tr>
			<!---
			<cfif CurrentRow NEQ RecordCount AND NOT CurrentRow MOD #ColsToShow# >
			</tr>
			<tr>
			</tr></cfif>
			--->
	
			</cfoutput>
			
		</table>
	<cfelse>
		<div align="center">No current related products</div><br />
	</cfif><!--- relatedList.RecordCount NEQ 0 --->
</cfif><!--- config.EnableRelated --->
<!--- THIS IS THE END OF THE RELATED ITEMS TABLE SET --->