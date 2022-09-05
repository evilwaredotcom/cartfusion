<cfoutput>
<!--- Checks to see if Related Products has been enabled --->
<cfif application.EnableRelated EQ 1>

	<cfscript>
		relatedList = application.Common.getRelatedItems(UserID=session.CustomerArray[28],ItemID=ItemID);
		// CARTFUSION 4.6 - CART CFC - Used further in the page
		if ( TRIM(session.CustomerArray[28]) NEQ '' ) {
			UserID = session.CustomerArray[28] ;
		} else {
			UserID = 1 ;
		}
		UseThisPrice = application.Cart.getItemPrice(
			UserID=UserID,
			SiteID=application.SiteID,
			ItemID=ItemID,
			SessionID=caller.SessionID);
		
		
		if( relatedList.RecordCount )	{
		// Get Product Options Count - Used furhter in the page
		getProductOptionsCount = application.Queries.getProductOptionsCount(ItemID=ItemID);
						
		// CHECK STOCK QUANTITY OF ITEM
		if ( relatedList.SellByStock eq 1 )
		{
			if ( relatedList.StockQuantity lte 0 )
				ItemAvailable = 0 ;
			else
				ItemAvailable = 1 ;
		}
		// CHECK AVAILABILITY OF ITEM
		else if ( relatedList.ItemStatus IS 'DI' OR relatedList.ItemStatus IS 'OS' )
			ItemAvailable = 0 ;
		else
			ItemAvailable = 1 ;
		// CHECK IF BACK ORDERED
		if ( relatedList.ItemStatus EQ 'BO' )
			RelatedBackOrdered = 1;
		
		}
	</cfscript>

	<cfif relatedList.RecordCount>
	
		<div id="categoryList">
		
			<cfloop query="relatedList">
			
				<a href="ProductDetail.cfm?ItemID=#ItemID#">
				
				<div class="thumbnail">
				<cfif relatedList.ImageSmall IS ''>
					<cfif FileExists(#application.ImageServerPath# & '\' & #ImageDir# & '\' & #SKU# & 'sm.jpg')>
						<img src="images/#ImageDir#/#SKU#sm.jpg" align="middle" alt="#ItemName#" width="75"><br>
						<!---<img src="images/button-detail.gif" border="0" align="middle">---></a>
					<cfelse>
						<img src="images/image-EMPTY.gif" align="middle" alt="#ItemName#"><br>
						<!---<img src="images/button-detail.gif" border="0" align="middle">---></a>
					</cfif>
				<cfelse>
					<cfif FileExists(#application.ImageServerPath# & '\' & #ImageDir# & '\' & #ImageSmall#)>
						<img src="images/#ImageDir#/#ImageSmall#" align="middle" alt="#ItemName#" width="75"><br>
						<!---<img src="images/button-detail.gif" border="0" align="middle">---></a>
					<cfelse>											
						<img src="images/image-EMPTY.gif" align="middle" alt="#ItemName#"><br>
						<!---<img src="images/button-detail.gif" border="0" align="middle">---></a>
					</cfif>
				</cfif>
					<p>
						<a href="ProductDetail.cfm?ItemID=#ItemID#">#ItemName#</a><br/>
						<!--- SHOW SKU --->
						SKU: #SKU#<br/>
						#ShortDescription#<br/><br/>
						<a href="ProductDetail.cfm?ItemID=#ItemID#">more</a>
					</p>
					
					
					<cfif ItemAvailable EQ 1 AND getProductOptionsCount.POCount EQ 0 >
						<cfform action="CartUpdate.cfm" method="post">
							#LSCurrencyFormat(UseThisPrice, "local")#<br>
							<img src="images/spacer.gif" width="1" height="5"><br/>
							Qty:
							<input type="hidden" name="ItemID" value="#ItemID#">										
							<input class="cfMini" type="text" name="Quantity" size="1" maxlenth="4" value="1" align="absmiddle"><br>
							<img src="images/spacer.gif" width="1" height="5"><br/>
							<cfif isDefined('RelatedBackOrdered') and RelatedBackOrdered EQ 1 >
								<input type="submit" name="AddButton" value="add to cart" align="absmiddle" class="button2"
									onclick="return confirm('This item is back-ordered.  Would you like to add it to your cart anyway?\nWe will ship the item to you as soon as it becomes available.\nAlso, we will NOT charge you until the item is shipped.')" >
								<input type="hidden" name="BackOrdered" value="1">
							<cfelse>
								<input type="submit" name="AddButton" value="add to cart" align="absmiddle" class="button2">
							</cfif>
						</cfform>
					<cfelse>
						<cfform action="ProductDetail.cfm?ItemID=#ItemID#" method="post">
							<font class="cfAttract">#LSCurrencyFormat(UseThisPrice, "local")#</font><br>
							<img src="images/spacer.gif" width="1" height="5"><br>
							<input type="submit" name="MoreInfoButton" value="MORE INFO" align="absmiddle" class="button2">
						</cfform>
					</cfif>
					
					
				
			</div>
			
			</a>
			<!--- <br clear="left" />
			<hr class="divider" /> --->
			</cfloop>
		</div>
	<cfelse>
		<div align="center">No current related products</div>
	
	</cfif>

</cfif>
</cfoutput>

<br class="clear" />
