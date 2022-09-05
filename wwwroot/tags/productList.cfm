<cfsetting enablecfoutputonly=true>
<cfprocessingdirective pageencoding="utf-8">

<cfif (isDefined('getCategories') and not getCategories.RecordCount) OR (isDefined('getSections') and not getSections.RecordCount)>

<cfoutput>
	
	<cfform action="Compare.cfm" method="get">
		
		<div class="pageSectionHeader">Products</div>
			<br/>
			<div id="categoryList">
			
				<cfloop query="getProducts" endrow="20">
				
				<cfscript>
					if ( TRIM(session.CustomerArray[28]) NEQ '' ) {
						UserID = session.CustomerArray[28] ;
					} else {
						UserID = 1 ;
					}
					UseThisPrice = application.Cart.getItemPrice(
						UserID=UserID,
						SiteID=application.SiteID,
						ItemID=ItemID,
						SessionID=SessionID
						) ;
				</cfscript>
				
					
					<div class="thumbnail">
					<a href="ProductDetail.cfm?ItemID=#ItemID#">
						<!---<cfif getProducts.ImageSmall IS ''>
							<cfif FileExists(application.ImageServerPath & '\' & ImageDir & '\' & SKU & 'sm.jpg')>
								<img src="images/#ImageDir#/#SKU#sm.jpg" align="middle" alt="#ItemName#" height="80"><br/>
							<cfelse>
								<img src="images/image-EMPTY.gif" align="middle" alt="#ItemName#"><br/>
							</cfif>
						<cfelse>--->
							<!---<cfif FileExists(application.ImageServerPath & '\' & ImageDir & '\' & ImageSmall)>--->
								<img src="images/#ImageDir#/#ImageSmall#" align="middle" alt="#ItemName#" height="50"><br/>
							<!---<cfelse>
								<img src="images/image-EMPTY.gif" align="middle" alt="#ItemName#"><br/>
							</cfif>--->
						<!---</cfif>--->
					</a>
					<p>
						<!--- Text Link and form elements --->
						<a href="ProductDetail.cfm?ItemID=#ItemID#">#ItemName#</a><br/>
						<!--- SHOW SKU --->
						SKU: #SKU#<br/>
						#LSCurrencyFormat(UseThisPrice, "local")#<br/><br/>
						<!--- OPTIONAL COMPARE PRODUCTS FORM --->
						<input type="checkbox" name="ID" value="#ItemID#"><input type="button" value="compare" class="button" onclick="submit();"><br/><br/>
					</p>
					</div>
				</cfloop>
			</div>
			
			<br class="clear" />
			<br/>
	</cfform>
</cfoutput>	

</cfif>

<cfsetting enablecfoutputonly=false>