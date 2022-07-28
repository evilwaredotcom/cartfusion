<cfif getProducts.RecordCount>

	<!--- <cfscript>
		if ( isDefined('getCategory') )
			ColsToShow = getCategory.ShowColumns ;
		else if ( isDefined('getSection') )
			ColsToShow = getSection.ShowColumns ;
		else
			ColsToShow = 4 ;
	</cfscript> --->

	<cfif (isDefined('getCategories') AND not getCategories.RecordCount)
	   OR (isDefined('getSections') AND not getSections.RecordCount) >
		
		<div id="CategoryHeader">Products</div>
	</cfif>
	
	<br />
	
	<!--- Start Category Container --->
	<div id="categoryList">
	
	<cfoutput query="getProducts" startrow="#URL.StartRow#" maxrows="#RowsPerPage#">
				
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
					SessionID=SessionID
					) ;
            </cfscript>
			
	
	
		<a href="ProductDetail.cfm?ItemID=#ItemID#">
			<div class="thumbnail">
				<cfif getProducts.ImageSmall IS ''>
					<cfif FileExists(#application.siteConfig.data.IU_VirtualPathDIR# & '\' & #ImageDir# & '\' & #SKU# & 'sm.jpg')>
						<img src="images/#ImageDir#/#SKU#sm.jpg" align="middle" alt="#ItemName#" width="75"><br>
						<!---<img src="images/button-detail.gif" border="0" align="middle">---></a>
					<cfelse>
						<img src="images/image-EMPTY.gif" align="middle" alt="#ItemName#"><br>
						<!---<img src="images/button-detail.gif" border="0" align="middle">---></a>
					</cfif>
				<cfelse>
					<cfif FileExists(#application.siteConfig.data.IU_VirtualPathDIR# & '\' & #ImageDir# & '\' & #ImageSmall#)>
						<img src="images/#ImageDir#/#ImageSmall#" align="middle" alt="#ItemName#" width="75"><br>
						<!---<img src="images/button-detail.gif" border="0" align="middle">---></a>
					<cfelse>											
						<img src="images/image-EMPTY.gif" align="middle" alt="#ItemName#"><br>
						<!---<img src="images/button-detail.gif" border="0" align="middle">---></a>
					</cfif>
				</cfif>
					<p>
						<!--- Text Link and form elements --->
						<a href="ProductDetail.cfm?ItemID=#ItemID#">#ItemName#</a><br />
						<!--- SHOW SKU --->
						SKU: #SKU#<br />
						#LSCurrencyFormat(UseThisPrice, "local")#<br /><br />
						<!--- OPTIONAL COMPARE PRODUCTS FORM --->
						<input type="checkbox" name="ID" value="#ItemID#"><input type="button" value="compare" class="button" onClick="submit();"><br><br>
					</p>
				
			</div>
			
			</a>
	</cfoutput>
	
	</div>
	<!--- End Category Container --->


<cfelseif (NOT isDefined('getCategories') OR getCategories.RecordCount EQ 0)
	  AND (NOT isDefined('getSections') OR getSections.RecordCount EQ 0) >
	<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">	
		<tr><td class="cfErrorMsg" align="center" style="padding:10px">There are no products in this category</td></tr>
		<tr><td><hr width="100%" size="1" color="<cfoutput>#layout.TableHeadingBGColor#</cfoutput>" ></td></tr>
	</table>
</cfif>