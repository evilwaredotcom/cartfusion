<cfsetting enablecfoutputonly=true>
<cfprocessingdirective pageencoding="utf-8">
<!---
	Attribute Name		Default (False/True)	Description
	showProductExtras	True					Show and hide ProductExtras (default is show)
	showDescription		True					Show and hide Description (default is show)
	showDetails			True					Show and hide Details (default is show)
	showRelatedItems	True					Show and hide RelatedItems (default is show)
	showReviews			True					Show and hide Reviews (default is show)
	showSpecifications	True					Show and hide Specifications (default is show)
--->
<cfparam name="attributes.productLayout" default="A">

<!--- IF YOU WANT TO SHOW RETAIL PRICE (MSRP) --->
<cfparam name="ShowRetailPrice" default="1">
<!--- DEFAULT PRODUCT EXTRAS SECTION TO SHOW --->
<cfparam name="show1" default="1">
<cfparam name="show2" default="0">
<cfparam name="show3" default="0">
<cfparam name="show4" default="0">
<cfparam name="show5" default="0">

<!--- <CFOUTPUT QUERY="getProduct" GROUP="SKU"> --->

<!--- CARTFUSION 4.6 - CART CFC --->
<cfscript>
	// AVAILABILITY OF ITEM
	// defaults
	ItemAvailable = 1;
	BackOrdered = 0;
	ShowAvailability = 1;
	StockMessage = 'IN STOCK';
	
	// set user
	if (TRIM(session.CustomerArray[28]) NEQ '') {
		UserID = session.CustomerArray[28];
	} else {
		UserID = 1;
	}
	// get price for this user
	useThisPrice = application.Cart.getItemPrice(
		UserID = UserID,
		SiteID = application.SiteID,
		ItemID = ItemID,
		SessionID = caller.SessionID
	);
	
	// get product details for the page
	getProduct = application.Queries.getProduct(
		ItemID = ItemID
	);
</cfscript>


<!--- PRODUCT USES INVENTORY MATRIX --->
<cfif getProduct.UseMatrix EQ 1>

	<cfscript>
		ShowAvailability = 0;
		// SEE IF ANY MATRIX ITEMS ARE AVAILABLE
		getItemClass = application.Queries.getItemClass(ICID=VAL(getProduct.ItemClassID));
	</cfscript>

	
	<!--- <cfinvoke component="#application.Queries#" method="getItemClass" returnvariable="getItemClass">
		<cfinvokeargument name="ICID" value="#VAL(getProduct.ItemClassID)#">
	</cfinvoke> --->
	
	
	<cfif getItemClass.RecordCount>
		<cfquery name="getMatrixItems" datasource="#application.dsn#">
			SELECT	ICCID, Detail1, 
			<cfif getItemClass.Dimensions EQ 2>
				Detail2,
			<cfelseif getItemClass.Dimensions EQ 3>
				Detail2, Detail3,
			</cfif>
					Image AS OptionImage
			FROM	ItemClassComponents
			WHERE	ItemID = #getProduct.ItemID#
			AND	   ((CompSellByStock = 1 AND CompQuantity > 0)
			OR	   ((CompSellByStock = 0 OR CompSellByStock IS NULL) AND (CompStatus = 'IS' OR CompStatus = 'BO')))
			GROUP BY ICCID, Detail1,
			<cfif getItemClass.Dimensions EQ 2>
				Detail2,
			<cfelseif getItemClass.Dimensions EQ 3>
				Detail2, Detail3,
			</cfif>
				Image
		</cfquery>
		
		<cfscript>
			if(getMatrixItems.RecordCount) {
				ShowAvailability = 1;
			} else {
				ItemAvailable = 0;
				ShowAvailability = 0;
				StockMessage = 'OUT OF STOCK';
			}
		</cfscript>
		
	<cfelse>
		<cfscript>
			ItemAvailable = 0;
			ShowAvailability = 0;
			StockMessage = 'OUT OF STOCK';
		</cfscript>
	</cfif>
<!--- PRODUCT DOES NOT USE INVENTORY MATRIX --->
<cfelse>
	<cfscript>
		// SELLING BY STOCK
		if (getProduct.SellByStock EQ 1) {
			if (getProduct.StockQuantity LTE 0) {	
				ItemAvailable = 0;
				StockMessage = 'ON ORDER';
			} else {
				ItemAvailable = 1;
				StockMessage = 'IN STOCK';
			}
		// SELLING BY STATUS
		} else {
			if (getProduct.ItemStatus IS 'IS') {
				ItemAvailable = 1;
				StockMessage = 'IN STOCK';
			} else if (getProduct.ItemStatus IS 'BO') {
				ItemAvailable = 1;
				StockMessage = 'ON ORDER';
				BackOrdered = 1;
			} else if (getProduct.ItemStatus IS 'OS') {
				ItemAvailable = 0;
				StockMessage = 'OUT OF STOCK';
			} else if (getProduct.ItemStatus IS 'DI') {
				ItemAvailable = 0;
				StockMessage = 'DISCONTINUED';
			}
		}
	</cfscript>
</cfif>
<!--- CHECK AVAILABILITY OF ITEM --->



<cfoutput>
<cfif thisTag.executionMode is "start">
<!--- <cfdump var="#variables#"> --->
<!--- Start productContent --->
	<div id="productContent">
	
	<!--- Start Product Show Image --->
	<div id="showProductImage-#attributes.productLayout#">
		<!--- CARTFUSION 4.7 - ITEM IMAGES --->
		<!--- MAIN IMAGE --->
		<cfif TRIM(getProduct.Image) NEQ '' AND FileExists(application.ImageServerPath & '\' & getProduct.ImageDir & '\' & getProduct.Image)>
			<img src="images/#getProduct.ImageDir#/#getProduct.Image#" id="img1" align="top" alt='#getProduct.ItemName#'><br><br>
		<cfelseif FileExists(application.ImageServerPath & '\' & getProduct.ImageDir & '\' & getProduct.SKU & '.jpg')>
			<img src="images/#getProduct.ImageDir#/#getProduct.SKU#.jpg" id="img1" align="top" alt='#getProduct.ItemName#'><br><br>
		<cfelseif FileExists(application.ImageServerPath & '\' & getProduct.ImageDir & '\' & getProduct.SKU & '.gif')>
			<img src="images/#getProduct.ImageDir#/#getProduct.SKU#.gif" id="img1" align="top" alt='#getProduct.ItemName#'><br><br>
		<cfelse>
			<img src="images/image-EMPTY.gif" id="img1" align="top" alt='#getProduct.ItemName#'><br><br>
		</cfif>
		<!--- IMAGE LARGE VIEW --->
		<cfif TRIM(getProduct.ImageLarge) NEQ '' AND FileExists(application.ImageServerPath & '\' & getProduct.ImageDir & '\' & getProduct.ImageLarge)>
			<img src="images/button-LargeView.gif" align="top"> 
			<a href="javascript: NewWindow('LargeView.cfm?id=#getProduct.ImageDir#&i=#getProduct.ImageLarge#','LargeImage','600','600','no')">View Large Image</a><br><br>
		</cfif>
				
			<!--- CARTFUSION 4.5 IMAGE SWATCHER --->
			<cfif isDefined('getMatrixItems') AND getProduct.UseMatrix EQ 1>
				<cfquery name="getOptionImages" dbtype="query">
					SELECT	DISTINCT (OptionImage)
					FROM	getMatrixItems
					WHERE	OptionImage != '' 
					AND 	OptionImage IS NOT NULL
				</cfquery>

				<script language="JavaScript">
					if(document.images) {
						swatches = new Array();
						<cfloop query="getOptionImages">
						swatches[#CurrentRow#] = new Image();
						swatches[#CurrentRow#].src = "images/#getProduct.ImageDir#/#getOptionImages.OptionImage#";
						</cfloop>
					}
					function swapper(from,to) {
						if (to != 0) {
							if(document.images) {
							document.images[from].src = swatches[to].src;
							}
						}
					}
				</script>
				
				<cfif getOptionImages.RecordCount NEQ 0>
					<table width="100%" cellpadding="3" cellspacing="0" border="0">
						<tr>
							<td class="cfMessage" colspan="#getOptionImages.RecordCount#"><b>PRODUCT PHOTOS</b><br/>(mouse over to view)</td>
						</tr>
						<tr>
						<cfloop query="getOptionImages">
							<cfquery name="getDistinctOptions" dbtype="query">
								SELECT	DISTINCT Detail1
										<cfif getItemClass.Dimensions EQ 2>
											, Detail2
										<cfelseif getItemClass.Dimensions EQ 3>
											, Detail2, Detail3
										</cfif>
								FROM	getMatrixItems
								WHERE	OptionImage = '#getOptionImages.OptionImage#'
								ORDER BY ICCID
							</cfquery>
							<td class="cfDefault" valign="top">
								<table border="0" cellpadding="3">
									<tr>
										<td valign="top">
											<cfif FileExists(application.ImageServerPath & '\' & getProduct.ImageDir & '\' & getOptionImages.OptionImage)>
												<cfset LargePhoto = ReplaceNoCase(getOptionImages.OptionImage,'.jpg','') & '-lg.jpg'>
												<cfif FileExists(application.ImageServerPath & '\' & getProduct.ImageDir & '\' & LargePhoto)>
													<a href="javascript: NewWindow('LargeView.cfm?id=#getProduct.ImageDir#&i=#LargePhoto#','LargeImage','600','600','no')"
														><img src="images/#getProduct.ImageDir#/#getOptionImages.OptionImage#" id="img2" 
															border="0" width="50" align="middle" alt='#getProduct.ItemName#' 
															onmouseover="swapper('img1',#CurrentRow#);"></a><br/>
												<cfelse>
													<img src="images/#getProduct.ImageDir#/#getOptionImages.OptionImage#" id="img2" 
														border="0" width="50" align="middle" alt='#getProduct.ItemName#' 
														onmouseover="swapper('img1',#CurrentRow#);"><br/>
												</cfif>
											<cfelse>
												<img src="images/image-EMPTY.gif" id="img2" border="0" width="50" align="middle" alt='#getProduct.ItemName#'>
											</cfif>
										</td>
									</tr>
									<tr>
										<td valign="top">
											<cfloop query="getDistinctOptions">
												#getDistinctOptions.Detail1#
												<cfif getItemClass.Dimensions EQ 2>, #getDistinctOptions.Detail2#
												<cfelseif getItemClass.Dimensions EQ 3>, #getDistinctOptions.Detail2#, #getDistinctOptions.Detail3#
												</cfif>
												<br/>
											</cfloop>
										</td>
									</tr>
								</table>
							</td>
						<cfif CurrentRow NEQ RecordCount AND NOT CurrentRow MOD 3>
						</tr>
						<tr>
						</tr></cfif>
						</cfloop>
														
				  </table>
				</cfif>
			</cfif>
			<!--- CARTFUSION 4.5 IMAGE SWATCHER --->
			
			<!--- ALTERNATE IMAGE --->
			<cfif TRIM(getProduct.ImageAlt) NEQ '' AND FileExists(application.ImageServerPath & '\' & getProduct.ImageDir & '\' & getProduct.ImageAlt)>
				<img src="images/#getProduct.ImageDir#/#getProduct.ImageAlt#" id="img2" border="0" align="middle" alt='#getProduct.ItemName#'><br><br>
			</cfif>
			<!--- ALTERNATE IMAGE LARGE VIEW --->
			<cfif TRIM(getProduct.ImageAltLarge) NEQ '' AND FileExists(application.ImageServerPath & '\' & getProduct.ImageDir & '\' & getProduct.ImageAltLarge)>
				<img src="images/button-LargeView.gif" border="0" align="top">
				<a href="javascript: NewWindow('LargeView.cfm?id=#getProduct.ImageDir#&i=#getProduct.ImageAltLarge#','LargeImage','600','600','no')"
					>View Large Image</a><br><br>
			</cfif>
		
	</div>
	<!--- End Product Show Image --->
	
	<!--- Start Product Options --->
	<div id="productShowOptions-#attributes.productLayout#">
		
		
		<cfform action="ProductDetail.cfm" method="post">
			
			<table width="100%" cellpadding="2" cellspacing="0">
				<!--- ITEM NAME --->
				<tr>
					<td width="100%" colspan="2" class="cfMessageThree">
						#getProduct.ItemName#
					</td>
				</tr>
				<!--- ITEM ATTRIBUTES 1-3 --->
				<cfif getProduct.Attribute1 NEQ ''>
				<tr>
					<td width="100%" colspan="2" class="cfDefault">
						#getProduct.Attribute1#
					</td>
				</tr>
				</cfif>
				<cfif getProduct.Attribute2 NEQ ''>
				<tr>
					<td width="100%" colspan="2" class="cfDefault">
						#getProduct.Attribute2#
					</td>
				</tr>
				</cfif>
				<cfif getProduct.Attribute3 NEQ ''>
				<tr>
					<td width="100%" colspan="2" class="cfDefault">
						#getProduct.Attribute3#
					</td>
				</tr>
				</cfif>
				<!--- MANUFACTURER'S ITEM ID/SKU --->
				<cfif getProduct.ManufacturerID NEQ ''>
				<tr>
					<td width="100%" colspan="2" class="cfMessageTwo">
						MFR## #getProduct.ManufacturerID#
					</td>
				</tr>
				</cfif>
				<!--- STORE'S ITEM ID/SKU --->
				<cfif getProduct.SKU NEQ ''>
				<tr>
					<td width="100%" colspan="2" class="cfMessageTwo">
						SKU## #getProduct.SKU#
					</td>
				</tr>
				</cfif>
				
				<!--- MATRIX ITEMS --->
				<cfif getProduct.UseMatrix EQ 1 AND ShowAvailability EQ 1>
					<cfquery name="getICC" dbtype="query">
						SELECT	*
						FROM	getMatrixItems
					</cfquery>
					<cfif getItemClass.Dimensions EQ 1>
						<tr>
							<td width="51%">#getItemClass.Title1#:</td>
							<td width="49%" align="right">
							   <cfmodule template="multipleRelatedSelects.cfm"
								  selectboxes="1"
								  query="getICC"
								  formname="Components"
								  fieldname1="OptionName1"
								  display1="Detail1"
								  value1="Detail1">
								<input type="hidden" name="Option1Optional" value="<cfif getProduct.Option1Optional EQ 1>1<cfelse>0</cfif>">
							</td>
					   </tr>
					<cfelseif getItemClass.Dimensions EQ 2>
						<tr>
							<td width="51%">#getItemClass.Title1#:</td>
							<td width="49%" align="right">
							   <cfmodule template="multipleRelatedSelects.cfm"
								  selectboxes="2"
								  query="getICC"
								  formname="Components"
								  fieldname1="OptionName1"
								  fieldname2="OptionName2"
								  display1="Detail1"
								  display2="Detail2"
								  value1="Detail1"
								  value2="Detail2"
								  htmlafter1="<tr><td>#getItemClass.Title2#:</td><td align=right>"
								>
								<input type="hidden" name="Option1Optional" value="<cfif getProduct.Option1Optional EQ 1>1<cfelse>0</cfif>">
								<input type="hidden" name="Option2Optional" value="<cfif getProduct.Option2Optional EQ 1>1<cfelse>0</cfif>">
							</td>
						</tr>					
					<cfelseif getItemClass.Dimensions EQ 3>
						<tr>
							<td width="51%">#getItemClass.Title1#:</td>
							<td width="49%" align="right">
							   <cfmodule template="multipleRelatedSelects.cfm"
								  selectboxes="3"
								  query="getICC"
								  formname="Components"
								  fieldname1="OptionName1"
								  fieldname2="OptionName2"
								  fieldname3="OptionName3"
								  display1="Detail1"
								  display2="Detail2"
								  display3="Detail3"
								  value1="Detail1"
								  value2="Detail2"
								  value3="Detail3"
								  htmlafter1="<tr><td>#getItemClass.Title2#:</td><td align=right>"
								  htmlafter2="<tr><td>#getItemClass.Title3#:</td><td align=right>"
								>
								<input type="hidden" name="Option1Optional" value="<cfif getProduct.Option1Optional EQ 1>1<cfelse>0</cfif>">
								<input type="hidden" name="Option2Optional" value="<cfif getProduct.Option2Optional EQ 1>1<cfelse>0</cfif>">
								<input type="hidden" name="Option3Optional" value="<cfif getProduct.Option3Optional EQ 1>1<cfelse>0</cfif>">
							</td>
					   	</tr>
					</cfif>
				</cfif>
			
				<!--- CUSTOM FILE 
				<cfinclude template="/CustomFiles/ProductDetailDisplay.cfm">
				--->
				
				<!--- BEGIN: OPTIONAL DESCRIPTIONS --->
				<cfif  caller.getProductOptions1.RecordCount NEQ 0 
					OR caller.getProductOptions2.RecordCount NEQ 0 
					OR caller.getProductOptions3.RecordCount NEQ 0>
					<!---
					OR caller.getProductOptions4.RecordCount NEQ 0 
					OR caller.getProductOptions5.RecordCount NEQ 0
					OR caller.getProductOptions6.RecordCount NEQ 0 
					OR caller.getProductOptions7.RecordCount NEQ 0
					OR caller.getProductOptions8.RecordCount NEQ 0 
					OR caller.getProductOptions9.RecordCount NEQ 0
					OR caller.getProductOptions10.RecordCount NEQ 0
					--->
					
					<!--- UPDATED 2007/02/05 START --->
					<cfloop from="1" to="3" index="i">
						<cfif Evaluate("getProduct.OptionName#i#") NEQ ''>
							<tr>
								<td width="100%" colspan="2" class="cfMessage">
									<table width="100%" cellpadding="0" cellspacing="0">
										<tr>
											<td align="left" class="cfDefault"><b>#Evaluate("getProduct.OptionName#i#")#: &nbsp;</b></td>
											<td align="right">
												<cfif Evaluate("getProduct.Option#i#Optional") EQ 0>
													<cfselect class="cfFormField" name="OptionName#i#" required="yes" message="Required: #Evaluate('getProduct.OptionName#i#')#">
														<option value="">Select #Evaluate("getProduct.OptionName#i#")# --</option>
													<cfloop query="caller.getProductOptions#i#">
														<cfif OptionSellByStock EQ 1>
															<cfif StockQuantity GT 0>
															<option value="#OptionName#">#OptionName#
																<!--- SHOW OPTION PRICE --->
																<cfif OptionPrice LT 0> [subtract $#DecimalFormat(OptionPrice * (-1))#] 
																<cfelseif OptionPrice GT 0> [add $#DecimalFormat(OptionPrice)#] 
																</cfif>
															</option>
															</cfif>
														<cfelseif ItemStatus EQ 'IS' OR ItemStatus EQ 'BA'>
															<option value="#OptionName#">#OptionName#
																<!--- SHOW OPTION PRICE --->
																<cfif OptionPrice LT 0> [subtract $#DecimalFormat(OptionPrice * (-1))#] 
																<cfelseif OptionPrice GT 0> [add $#DecimalFormat(OptionPrice)#] 
																</cfif>
															</option>
														</cfif>
													</cfloop>
													</cfselect>
													<input type="hidden" name="Option#i#Optional" value="0">
												<cfelse>
													<cfselect class="cfFormField" name="OptionName#i#" required="no">
														<option value="">Select #Evaluate("getProduct.OptionName#i#")# --</option>
													<cfloop query="caller.getProductOptions#i#">
														<cfif OptionSellByStock EQ 1>
															<cfif StockQuantity GT 0>
															<option value="#OptionName#">#OptionName#
																<!--- SHOW OPTION PRICE --->
																<cfif OptionPrice LT 0> [subtract $#DecimalFormat(OptionPrice * (-1))#] 
																<cfelseif OptionPrice GT 0> [add $#DecimalFormat(OptionPrice)#] 
																</cfif>
															</option>
															</cfif>
														<cfelseif ItemStatus EQ 'IS' OR ItemStatus EQ 'BA'>
															<option value="#OptionName#">#OptionName#
																<!--- SHOW OPTION PRICE --->
																<cfif OptionPrice LT 0> [subtract $#DecimalFormat(OptionPrice * (-1))#] 
																<cfelseif OptionPrice GT 0> [add $#DecimalFormat(OptionPrice)#] 
																</cfif>
															</option>
														</cfif>
													</cfloop>
													</cfselect>
													<input type="hidden" name="Option#i#Optional" value="1">
												</cfif>
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</cfif>
					</cfloop>
					<!--- UPDATED 2007/02/05 FINISH --->
				</cfif>
				<!--- END: OPTIONAL DESCRIPTIONS --->
				
				<!--- SHOW AVAILABILITY INFO --->
				<cfif ShowAvailability EQ 1>
				<tr>
					<td width="51%" class="cfMessageThree" height="20">
						Availability
					</td>
					<td width="49%" class="cfAttract" align="right">
						#StockMessage#
					</td>
				</tr>
				</cfif>
				
				<!--- SHOW RETAIL PRICE --->
				<cfif isDefined('ShowRetailPrice') AND ShowRetailPrice NEQ ''>
					<cfquery name="getRetailPrice" datasource="#application.dsn#">
						SELECT	ListPrice
						FROM	Products
						WHERE	ItemID = #ItemID#
					</cfquery>
					<cfif getRetailPrice.RecordCount NEQ 0 AND getRetailPrice.ListPrice GT 0>
					<tr>
						<td width="51%" class="cfMessageThree" height="20">Retail Price</td>
						<td width="49%" class="cfRetail" align="right">#LSCurrencyFormat(getRetailPrice.ListPrice, "local")#</td>
					</tr>
					</cfif>
				</cfif>
				<!--- SHOW STORE AND SALE PRICES --->
				<cfquery name="getPrice" datasource="#application.dsn#">
					SELECT	Price<cfif session.CustomerArray[28] EQ ''>1<cfelse>#session.CustomerArray[28]#</cfif> AS ThisPrice
					FROM	Products
					WHERE	ItemID = #ItemID#
				</cfquery>
				<cfif getPrice.RecordCount NEQ 0 AND getPrice.ThisPrice GT useThisPrice>
					<tr>
						<td width="51%" class="cfMessageThree" height="20">Our Price</td>
						<td width="49%" class="cfRetail" align="right">#LSCurrencyFormat(getPrice.ThisPrice, "local")#</td>
					</tr>
					<tr>
						<td width="51%" class="cfAttract" height="20">SALE PRICE</td>
						<td width="49%" class="cfAttract" align="right">#LSCurrencyFormat(useThisPrice, "local")#</td>
					</tr>
				<cfelse>
					<tr>
						<td width="51%" class="cfAttract" height="20">Our Price</td>
						<td width="49%" class="cfAttract" align="right">#LSCurrencyFormat(useThisPrice, "local")#</td>
					</tr>
				</cfif>
			
				<cfif ItemAvailable EQ 1>
					<tr>
						<td width="51%" class="cfMessageThree" height="20">
							Quantity
						</td>
						<td width="49%" class="cfAttract" align="right">
							<cfinput class="cfFormField" type="text" name="quantity" value="1" size="2" required="yes" message="Please enter a quantity">
						</td>
					</tr>
					<tr>
						<td width="100%" colspan="2" class="cfMessage" align="right" nowrap valign="bottom">
							
							
							
							
							<cfif isDefined('BackOrdered') AND BackOrdered EQ 1>
								<input type="hidden" name="BackOrdered" value="1">
								<input type="submit" name="AddToWishlist" value="Add To Wishlist" class="button gray small"
									onclick="return confirm('This item is back-ordered.  Would you like to add it to your wishlist anyway?')">
								<input type="submit" name="AddToCart" value="Add To Cart" class="button green large"
									onclick="return confirm('This item is back-ordered.  Would you like to add it to your cart anyway?\nWe will ship the item to you as soon as it becomes available.\nAlso, we will NOT charge you until the item is shipped.')">
							<cfelse>
							
							
								<input type="submit" name="AddToWishlist" value="Add To Wishlist" class="button gray small">
								<input type="submit" name="AddToCart" value="Add To Cart" class="button green large">
								
								
							</cfif>
							
							
							
							
						</td>
					</tr>
				<cfelse>	
					<tr>
						<td width="100%" colspan="2" class="cfMessageThree" align="center" height="20">
							#StockMessage#
						</td>
					</tr>
				</cfif>
			
				<!--- CARTFUSION 4.5 TELL-A-FRIEND FEATURE --->
				<cfset UseTellAFriend = 1>
				<cfif UseTellAFriend EQ 1>
					<tr>
						<td width="100%" colspan="2" class="cfDefault" align="center" height="30">
							<a href="javascript:NewWindow('#application.RootURL#/tellafriend.cfm?ItemID=#ItemID#','TellAFriend','820','500','yes');">Tell a friend about this product.</a>
						</td>
					</tr>
				</cfif>
				<!--- CARTFUSION 4.5 TELL-A-FRIEND FEATURE --->
			</table>
				
				<input type="hidden" name="ItemID" value="#ItemID#">
			</cfform>


<!--- </cfoutput> --->
<!--- END: productList OUTPUT QUERY --->

	</div><!--- End Product Options --->
	
<!--- START: productExtras (tabs) --->
					
	<cfif not structKeyExists(attributes, 'showProductExtras')>
	
	<!--- Start Product Extras --->
	<div id="productExtras">
		
		<!--- Start Product Extras Headers --->
		<div id="productExtrasHeaders">
			<ul>
				<cfif not structKeyExists(attributes, 'showDescription')>
					<li onclick="SwitchMenu('sub1')" style="margin-left: 1px" id="current"><a href="##" title="Description"><span>Description</span></a></li>
				</cfif>
				
				<cfif not structKeyExists(attributes, 'showDetails')>
					<li onclick="SwitchMenu('sub2')"><a href="##" title="Details"><span>Details</span></a></li>
				</cfif>
				
				<cfif not structKeyExists(attributes, 'showRelatedItems')>
					<li onclick="SwitchMenu('sub3')"><a href="##" title="Related Items"><span>Related Items</span></a></li>
				</cfif>
				
				<cfif not structKeyExists(attributes, 'showReviews')>
					<li onclick="SwitchMenu('sub4')"><a href="##" title="Reviews"><span>Reviews</span></a></li>	
				</cfif>
				
				<cfif not structKeyExists(attributes, 'showSpecifications')>
					<li onclick="SwitchMenu('sub5')"><a href="##" title="Specifications"><span>Specifications</span></a></li>
				</cfif>
			</ul>
		</div>
		<!--- End Product Extras Headers --->
		
		<div id="productExtrasHeadersline">&nbsp;</div>
		<!--- End Product Extras Headers and Line --->
	
		
		<!--- Start Product Extras Content --->
		<div id="productExtrasContent">
			
			<cfif not structKeyExists(attributes, 'showDescription')>
				<span class="submenu1" id="sub1">
					<p><cfif getProduct.ItemDescription EQ ''><div align="center">No product description available</div><br><cfelse>#getProduct.ItemDescription#</cfif></p>
				</span>
			</cfif>
			
			<cfif not structKeyExists(attributes, 'showDetails')>
				<span class="submenu2" id="sub2">
					<p><cfif getProduct.ItemDetails EQ ''><div align="center">No additional product details</div><br><cfelse>#getProduct.ItemDetails#</cfif></p>
				</span>
			</cfif>
			
			<cfif not structKeyExists(attributes, 'showRelatedItems')>
				<span class="submenu3" id="sub3">
					<p><cfinclude template="/includes/ProductRelated.cfm"></p>
				</span>
			</cfif>
			
			<cfif not structKeyExists(attributes, 'showReviews')>
				<span class="submenu4" id="sub4">
					<p><cfinclude template="/includes/ProductReviews.cfm"></p>
				</span>
			</cfif>
			
			<cfif not structKeyExists(attributes, 'showSpecifications')>
				<span class="submenu5" id="sub5">
					<p><cfinclude template="/includes/ProductSpecs.cfm"></p>
				</span>
			</cfif>
			
		</div>
		<!--- End Product Extras Content --->
		
	</div>
	<!--- End Product Extras --->
	</cfif>
	
	</div>
	<!--- End Show Product --->

</cfif>
</cfoutput>
<cfsetting enablecfoutputonly=false>