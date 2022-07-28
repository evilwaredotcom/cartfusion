<cfsetting enablecfoutputonly=true>
<cfprocessingdirective pageencoding="utf-8">

<!---
	Name         	: productDisplay.cfm
	History      	: Created, for the purpose of calling everything 
									from one page for product display
	Purpose		 		: Layout for product detailed display
	Main Elements	: 
		Attribute Name		Default (False/True)	Description
		showProductExtras		True					Show and hide ProductExtras (default is show)
		showDescription			True					Show and hide Description (default is show)
		showDetails					True					Show and hide Details (default is show)
		showRelatedItems		True					Show and hide RelatedItems (default is show)
		showReviews					True					Show and hide Reviews (default is show)
		showSpecifications	True					Show and hide Specifications (default is show)
--->

<!--- 
	Attribute Name		Description
	productLayout			A/B (a = product picture on left product options on right) (b = product picture on right product options on left)
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
		
	// AVAILABILITY OF ITEM
	// defaults
	ItemAvailable = 1 ;
	BackOrdered = 0 ;
	ShowAvailability = 1 ;
	StockMessage = 'IN STOCK' ;
	
	
	// Get Product Details for the page
	getProduct = application.Queries.getProduct(ItemID=ItemID);
</cfscript>


<!--- PRODUCT USES INVENTORY MATRIX --->
<cfif getProduct.UseMatrix EQ 1 >
	<cfset ShowAvailability = 0 >
	<!--- SEE IF ANY MATRIX ITEMS ARE AVAILABLE --->
	<cfscript>
		getItemClass = application.Queries.getItemClass(ICID=VAL(getProduct.ItemClassID));
	</cfscript>
	
	
	<!--- <cfinvoke component="#application.Queries#" method="getItemClass" returnvariable="getItemClass">
		<cfinvokeargument name="ICID" value="#VAL(getProduct.ItemClassID)#">
	</cfinvoke> --->
	
	
	<cfif getItemClass.RecordCount>
		<cfquery name="getMatrixItems" datasource="#application.dsn#">
			SELECT	ICCID, Detail1, 
			<cfif getItemClass.Dimensions EQ 2 >
				Detail2,
			<cfelseif getItemClass.Dimensions EQ 3 >
				Detail2, Detail3,
			</cfif>
					Image AS OptionImage
			FROM	ItemClassComponents
			WHERE	ItemID = #getProduct.ItemID#
			AND	   ((CompSellByStock = 1 AND CompQuantity > 0)
			OR	   ((CompSellByStock = 0 OR CompSellByStock IS NULL) AND (CompStatus = 'IS' OR CompStatus = 'BO')))
			GROUP BY ICCID, Detail1,
			<cfif getItemClass.Dimensions EQ 2 >
				Detail2,
			<cfelseif getItemClass.Dimensions EQ 3 >
				Detail2, Detail3,
			</cfif>
				Image
		</cfquery>
		
		<cfscript>
			if( getMatrixItems.RecordCount )	{
				// ItemAvailable = 1 ; // ItemAvailable is already 1
				ShowAvailability = 1 ;
				// StockMessage = 'IN STOCK' ; // StockMessage is already IN STOCK
			}
			else	{
				ItemAvailable = 0 ;
				ShowAvailability = 0 ;
				StockMessage = 'OUT OF STOCK' ;
			}
		</cfscript>
		
	<cfelse>						
		<cfscript>
			ItemAvailable = 0 ;
			ShowAvailability = 0 ;
			StockMessage = 'OUT OF STOCK' ;
		</cfscript>
	</cfif>
<!--- PRODUCT DOES NOT USE INVENTORY MATRIX --->
<cfelse>
	<cfscript>
		// SELLING BY STOCK
		if ( getProduct.SellByStock EQ 1 )
		{
			if ( getProduct.StockQuantity LTE 0 )
			{	
				ItemAvailable = 0 ;
				StockMessage = 'ON ORDER' ;
			}	
			else
			{
				ItemAvailable = 1 ;
				StockMessage = 'IN STOCK' ;
			}
		}
		// SELLING BY STATUS
		else
		{
			if ( getProduct.ItemStatus IS 'IS' )
			{
				ItemAvailable = 1 ;
				StockMessage = 'IN STOCK' ;
			}
			else if ( getProduct.ItemStatus IS 'BO' )
			{
				ItemAvailable = 1 ;
				StockMessage = 'ON ORDER' ;
				BackOrdered = 1 ;
			}
			else if ( getProduct.ItemStatus IS 'OS' )
			{
				ItemAvailable = 0 ;
				StockMessage = 'OUT OF STOCK' ;
			}
			else if ( getProduct.ItemStatus IS 'DI' )
			{
				ItemAvailable = 0 ;
				StockMessage = 'DISCONTINUED' ;
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
		<cfif TRIM(getProduct.Image) NEQ '' AND FileExists(application.siteConfig.data.IU_VirtualPathDIR & '\' & getProduct.ImageDir & '\' & getProduct.Image) >
			<img src="images/#getProduct.ImageDir#/#getProduct.Image#" id="img1" align="top" alt='#getProduct.ItemName#'><br><br>
		<cfelseif FileExists(application.siteConfig.data.IU_VirtualPathDIR & '\' & getProduct.ImageDir & '\' & getProduct.SKU & '.jpg') >
			<img src="images/#getProduct.ImageDir#/#getProduct.SKU#.jpg" id="img1" align="top" alt='#getProduct.ItemName#'><br><br>
		<cfelseif FileExists(application.siteConfig.data.IU_VirtualPathDIR & '\' & getProduct.ImageDir & '\' & getProduct.SKU & '.gif') >
			<img src="images/#getProduct.ImageDir#/#getProduct.SKU#.gif" id="img1" align="top" alt='#getProduct.ItemName#'><br><br>
		<cfelse>
			<img src="images/image-EMPTY.gif" id="img1" align="top" alt='#getProduct.ItemName#'><br><br>
		</cfif>
		<!--- IMAGE LARGE VIEW --->
		<cfif TRIM(getProduct.ImageLarge) NEQ '' AND FileExists(application.siteConfig.data.IU_VirtualPathDIR & '\' & getProduct.ImageDir & '\' & getProduct.ImageLarge) >
			<img src="images/button-LargeView.gif" align="top"> <a href="javascript: NewWindow('LargeView.cfm?id=#getProduct.ImageDir#&i=#getProduct.ImageLarge#','LargeImage','600','600','no')">View Large Image</a><br><br>
		</cfif>
		
	</div>
	<!--- End Product Show Image --->
	
	<!--- Start Product Options --->
	<div id="productShowOptions-#attributes.productLayout#">
		
		
		<cfform action="ProductDetail.cfm" method="post" preservedata="yes">
			<table width="100%" cellpadding="3" cellspacing="0" <!---  bordercolor="###layout.TableHeadingBGColor#" --->>
			<tr <!--- bordercolor="###layout.PrimaryBGColor#" --->>
			<td width="100%">
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
				<cfif getProduct.UseMatrix EQ 1 AND ShowAvailability EQ 1 >
					<cfquery name="getICC" dbtype="query">
						SELECT	*
						FROM	getMatrixItems
					</cfquery>
					<cfif getItemClass.Dimensions EQ 1 >
						<tr>
							<td width="70%">#getItemClass.Title1#:</td>
							<td width="30%" align="right">
							   <CF_MultipleRelatedSelects 
								  SELECTBOXES="1"
								  QUERY="getICC"
								  FORMNAME="Components"
								  FIELDNAME1="OptionName1"
								  DISPLAY1="Detail1"
								  VALUE1="Detail1"
								  >
								<input type="hidden" name="Option1Optional" value="<cfif Option1Optional EQ 1>1<cfelse>0</cfif>">
							</td>
					   </tr>
					<cfelseif getItemClass.Dimensions EQ 2 >
						<tr>
							<td width="70%">#getItemClass.Title1#:</td>
							<td width="30%" align="right">
							   <CF_MultipleRelatedSelects 
								  SELECTBOXES="2"
								  QUERY="getICC"
								  FORMNAME="Components"
								  FIELDNAME1="OptionName1"
								  FIELDNAME2="OptionName2"
								  DISPLAY1="Detail1"
								  DISPLAY2="Detail2"
								  VALUE1="Detail1"
								  VALUE2="Detail2"
								  HTMLAFTER1="<tr><td>#getItemClass.Title2#:</td><td align=right>"
								  >
								<input type="hidden" name="Option1Optional" value="<cfif Option1Optional EQ 1>1<cfelse>0</cfif>">
								<input type="hidden" name="Option2Optional" value="<cfif Option2Optional EQ 1>1<cfelse>0</cfif>">
							</td>
						</tr>					
					<cfelseif getItemClass.Dimensions EQ 3 >
						<tr>
							<td width="70%">#getItemClass.Title1#:</td>
							<td width="30%" align="right">
							   <CF_MultipleRelatedSelects 
								  SELECTBOXES="3"
								  QUERY="getICC"
								  FORMNAME="Components"
								  FIELDNAME1="OptionName1"
								  FIELDNAME2="OptionName2"
								  FIELDNAME3="OptionName3"
								  DISPLAY1="Detail1"
								  DISPLAY2="Detail2"
								  DISPLAY3="Detail3"
								  VALUE1="Detail1"
								  VALUE2="Detail2"
								  VALUE3="Detail3"
								  HTMLAFTER1="<tr><td>#getItemClass.Title2#:</td><td align=right>"
								  HTMLAFTER2="<tr><td>#getItemClass.Title3#:</td><td align=right>"
								  >
								<input type="hidden" name="Option1Optional" value="<cfif Option1Optional EQ 1>1<cfelse>0</cfif>">
								<input type="hidden" name="Option2Optional" value="<cfif Option2Optional EQ 1>1<cfelse>0</cfif>">
								<input type="hidden" name="Option3Optional" value="<cfif Option3Optional EQ 1>1<cfelse>0</cfif>">
							</td>
					   	</tr>
					</cfif>
				</cfif>
			
				<!--- CUSTOM FILE 
				<cfinclude template="../CustomFiles/ProductDetailDisplay.cfm">
				--->
				
				<!--- BEGIN: OPTIONAL DESCRIPTIONS --->
				<cfif  caller.getProductOptions1.RecordCount NEQ 0 
                    OR caller.getProductOptions2.RecordCount NEQ 0 
                    OR caller.getProductOptions3.RecordCount NEQ 0 >
                    <!---
                    OR getProductOptions4.RecordCount NEQ 0 
                    OR getProductOptions5.RecordCount NEQ 0
                    OR getProductOptions6.RecordCount NEQ 0 
                    OR getProductOptions7.RecordCount NEQ 0
                    OR getProductOptions8.RecordCount NEQ 0 
                    OR getProductOptions9.RecordCount NEQ 0
                    OR getProductOptions10.RecordCount NEQ 0
					--->
					
                    <!--- UPDATED 2007/02/05 START --->
                    <cfloop from="1" to="3" index="i">
						<cfif Evaluate("getProduct.OptionName#i#") NEQ ''>
                            <tr>
                                <td width="100%" colspan="2" class="cfMessage">
                                    <table width="100%" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td align="left" class="cfDefault" ><b>#Evaluate("getProduct.OptionName#i#")#: &nbsp;</b></td>
                                            <td align="right">
                                                <cfif Evaluate("Option#i#Optional") EQ 0 >
                                                    <cfselect class="cfFormField" name="OptionName#i#" required="yes" message="Required: #Evaluate('getProduct.OptionName#i#')#">
                                                        <option value="">Select #Evaluate("getProduct.OptionName#i#")# --</option>
                                                    <cfloop query="getProductOptions#i#">
                                                        <cfif OptionSellByStock EQ 1 >
                                                            <cfif StockQuantity GT 0 >
                                                            <option value="#OptionName#">#OptionName#
                                                                <!--- SHOW OPTION PRICE --->
                                                                <cfif OptionPrice LT 0> [subtract $#DecimalFormat(OptionPrice * (-1))#] 
                                                                <cfelseif OptionPrice GT 0> [add $#DecimalFormat(OptionPrice)#] 
                                                                </cfif>
                                                            </option>
                                                            </cfif>
                                                        <cfelseif ItemStatus EQ 'IS' OR ItemStatus EQ 'BA' >
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
                                                    <cfloop query="getProductOptions#i#">
                                                        <cfif OptionSellByStock EQ 1 >
                                                            <cfif StockQuantity GT 0 >
                                                            <option value="#OptionName#">#OptionName#
                                                                <!--- SHOW OPTION PRICE --->
                                                                <cfif OptionPrice LT 0> [subtract $#DecimalFormat(OptionPrice * (-1))#] 
                                                                <cfelseif OptionPrice GT 0> [add $#DecimalFormat(OptionPrice)#] 
                                                                </cfif>
                                                            </option>
                                                            </cfif>
                                                        <cfelseif ItemStatus EQ 'IS' OR ItemStatus EQ 'BA' >
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
				<cfif ShowAvailability EQ 1 >
				<tr>
					<td width="70%" class="cfMessageThree" height="20">
						Availability
					</td>
					<td width="30%" class="cfAttract" align="right">
						#StockMessage#
					</td>
				</tr>
				</cfif>
				
				<!--- SHOW RETAIL PRICE --->
				<cfif isDefined('ShowRetailPrice') AND ShowRetailPrice NEQ '' >
					<cfquery name="getRetailPrice" datasource="#application.dsn#">
						SELECT	ListPrice
						FROM	Products
						WHERE	ItemID = #ItemID#
					</cfquery>
					<cfif getRetailPrice.RecordCount NEQ 0 AND getRetailPrice.ListPrice GT 0 >
					<tr>
						<td width="70%" class="cfMessageThree" height="20">Retail Price</td>
						<td width="30%" class="cfRetail" align="right">#LSCurrencyFormat(getRetailPrice.ListPrice, "local")#</td>
					</tr>
					</cfif>
				</cfif>
				<!--- SHOW STORE AND SALE PRICES --->
				<cfquery name="getPrice" datasource="#application.dsn#">
					SELECT	Price<cfif session.CustomerArray[28] EQ '' >1<cfelse>#session.CustomerArray[28]#</cfif> AS ThisPrice
					FROM	Products
					WHERE	ItemID = #ItemID#
				</cfquery>
				<cfif getPrice.RecordCount NEQ 0 AND getPrice.ThisPrice GT UseThisPrice >
					<tr>
						<td width="70%" class="cfMessageThree" height="20">Our Price</td>
						<td width="30%" class="cfRetail" align="right">#LSCurrencyFormat(getPrice.ThisPrice, "local")#</td>
					</tr>
					<tr>
						<td width="70%" class="cfAttract" height="20">SALE PRICE</td>
						<td width="30%" class="cfAttract" align="right">#LSCurrencyFormat(UseThisPrice, "local")#</td>
					</tr>
				<cfelse>
					<tr>
						<td width="70%" class="cfAttract" height="20">Our Price</td>
						<td width="30%" class="cfAttract" align="right">#LSCurrencyFormat(UseThisPrice, "local")#</td>
					</tr>
				</cfif>
			
				<cfif ItemAvailable EQ 1 >
					<tr>
						<td width="70%" class="cfMessageThree" height="20">
							Quantity
						</td>
						<td width="30%" class="cfAttract" align="right">
							<cfinput class="cfFormField" type="text" name="quantity" value="1" size="2" required="yes" message="Please enter a quantity">
						</td>
					</tr>
					<tr>
						<td width="100%" colspan="2" class="cfMessage" align="right" nowrap>
							<cfif isDefined('BackOrdered') AND BackOrdered EQ 1 >
								<input type="image" name="AddToWishlist" src="images/button-AddToWishlist.gif" align="absmiddle" 
									onClick="return confirm('This item is back-ordered.  Would you like to add it to your wishlist anyway?')" >
								<input type="image" name="AddToCart" src="images/button-AddToCart.gif" align="absmiddle" 
									onClick="return confirm('This item is back-ordered.  Would you like to add it to your cart anyway?\nWe will ship the item to you as soon as it becomes available.\nAlso, we will NOT charge you until the item is shipped.')" >
								<input type="hidden" name="BackOrdered" value="1">
							<cfelse>
								<input type="image" name="AddToWishlist" src="images/button-AddToWishlist.gif" align="absmiddle">
								<input type="image" name="AddToCart" src="images/button-AddToCart.gif" align="absmiddle" class="no-border">
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
				<cfset UseTellAFriend = 1 >
				<cfif UseTellAFriend EQ 1 >
					<tr>
						<td width="100%" colspan="2" class="cfDefault" align="center" height="30">
							<a href="javascript:NewWindow('#application.siteConfig.data.RootURL#/tellafriend.cfm?ItemID=#ItemID#','TellAFriend','820','500','yes');">Tell a friend about this product.</a>
						</td>
					</tr>
				</cfif>
				<!--- CARTFUSION 4.5 TELL-A-FRIEND FEATURE --->
				
				<input type="hidden" name="ItemID" value="#ItemID#">
			</cfform>
			</table>
			</td>
			</tr>
			</table>
		</td>
	</tr>
</table>
<!--- </cfoutput> --->
<!--- END: productList OUTPUT QUERY --->

	</div>
	<!--- End Product Options --->
	
	<br class="clear" />
	<!--- <br /> --->



<script language="javascript">

	if (document.getElementById){ 
	document.write('<style type="text/css">\n')
	document.write('.submenu1{display: block;}\n')
	document.write('</style>\n')
	document.write('<style type="text/css">\n')
	document.write('.submenu2{display: none;}\n')
	document.write('</style>\n')
	document.write('<style type="text/css">\n')
	document.write('.submenu3{display: none;}\n')
	document.write('</style>\n')
	document.write('<style type="text/css">\n')
	document.write('.submenu4{display: none;}\n')
	document.write('</style>\n')
	document.write('<style type="text/css">\n')
	document.write('.submenu5{display: none;}\n')
	document.write('</style>\n')
	}
	
	function SwitchMenu(obj){
		if(document.getElementById){
			var el = document.getElementById(obj);
			var ar = document.getElementById("productExtras").getElementsByTagName("span"); 
			if(el.style.display != "block"){ 
				// the commented code is to hide others when one is clicked/shown
				for (var i=0; i<ar.length; i++){
					if (ar[i].className=="submenu1") 
					ar[i].style.display = "none";
					if (ar[i].className=="submenu2") 
					ar[i].style.display = "none";
					if (ar[i].className=="submenu3") 
					ar[i].style.display = "none";
					if (ar[i].className=="submenu4") 
					ar[i].style.display = "none";
					if (ar[i].className=="submenu5") 
					ar[i].style.display = "none";
				}
				el.style.display = "block";
			}else{
				el.style.display = "none";
			}
		}
	}
</script>

					
	<cfif not structKeyExists(attributes, 'showProductExtras')>
	
	<!--- Start Product Extras --->
	<div id="productExtras">
		
		<!--- Start Product Extras Headers --->
		<div id="productExtrasHeaders">
			<ul>
				<cfif not structKeyExists(attributes, 'showDescription')>
					<li onclick="SwitchMenu('sub1')" style="margin-left: 1px" id="current"><a href="javascript:void();" title="Description"><span>Description</span></a></li>
				</cfif>
				
				<cfif not structKeyExists(attributes, 'showDetails')>
					<li onclick="SwitchMenu('sub2')"><a href="javascript:void();" title="Details"><span>Details</span></a></li>
				</cfif>
				
				<cfif not structKeyExists(attributes, 'showRelatedItems')>
					<li onclick="SwitchMenu('sub3')"><a href="javascript:void();" title="Related Items"><span>Related Items</span></a></li>
				</cfif>
				
				<cfif not structKeyExists(attributes, 'showReviews')>
					<li onclick="SwitchMenu('sub4')"><a href="javascript:void();" title="Reviews"><span>Reviews</span></a></li>	
				</cfif>
				
				<cfif not structKeyExists(attributes, 'showSpecifications')>
					<li onclick="SwitchMenu('sub5')"><a href="javascript:void();" title="Specifications"><span>Specifications</span></a></li>
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
					<p><cfinclude template="../includes/ProductRelated.cfm"></p>
				</span>
			</cfif>
			
			<cfif not structKeyExists(attributes, 'showReviews')>
				<span class="submenu4" id="sub4">
					<p><!--- <cfinclude template="../includes/ProductReviews.cfm"> ---></p>
				</span>
			</cfif>
			
			<cfif not structKeyExists(attributes, 'showSpecifications')>
				<span class="submenu5" id="sub5">
					<p><!--- <cfinclude template="../includes/ProductSpecs.cfm"> ---></p>
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

<!--- Old Code from ProductDetailDisplay.cfm --->

<!--- 
<!--- IF YOU WANT TO SHOW RETAIL PRICE (MSRP) --->
<cfparam name="ShowRetailPrice" default="1">
<!--- DEFAULT PRODUCT EXTRAS SECTION TO SHOW --->
<cfparam name="show1" default="1">
<cfparam name="show2" default="0">
<cfparam name="show3" default="0">
<cfparam name="show4" default="0">
<cfparam name="show5" default="0">

<CFOUTPUT QUERY="getProduct" GROUP="SKU">

<!--- CARTFUSION 4.6 - CART CFC --->
<cfscript>
	if ( TRIM(session.CustomerArray[28]) NEQ '' ) {
		UserID = session.CustomerArray[28] ;
	} else {
		UserID = 1 ;
	}
	UseThisPrice = application.Cart.getItemPrice(
						UserID=UserID,
						SiteID=config.SiteID,
						ItemID=ItemID,
						SessionID=SessionID
						) ;
	// AVAILABILITY OF ITEM
	// defaults
	ItemAvailable = 1 ;
	BackOrdered = 0 ;
	ShowAvailability = 1 ;
	StockMessage = 'IN STOCK' ;
</cfscript>

<!--- PRODUCT USES INVENTORY MATRIX --->
<cfif getProduct.UseMatrix EQ 1 >
	<cfset ShowAvailability = 0 >
	<!--- SEE IF ANY MATRIX ITEMS ARE AVAILABLE --->
	<cfinvoke component="#application.Queries#" method="getItemClass" returnvariable="getItemClass">
		<cfinvokeargument name="ICID" value="#VAL(getProduct.ItemClassID)#">
	</cfinvoke>
	<cfif getItemClass.RecordCount NEQ 0 >
		<cfquery name="getMatrixItems" datasource="#application.dsn#">
			SELECT	ICCID, Detail1, 
			<cfif getItemClass.Dimensions EQ 2 >
				Detail2,
			<cfelseif getItemClass.Dimensions EQ 3 >
				Detail2, Detail3,
			</cfif>
					Image AS OptionImage
			FROM	ItemClassComponents
			WHERE	ItemID = #getProduct.ItemID#
			AND	   ((CompSellByStock = 1 AND CompQuantity > 0)
			OR	   ((CompSellByStock = 0 OR CompSellByStock IS NULL) AND (CompStatus = 'IS' OR CompStatus = 'BO')))
			GROUP BY ICCID, Detail1,
			<cfif getItemClass.Dimensions EQ 2 >
				Detail2,
			<cfelseif getItemClass.Dimensions EQ 3 >
				Detail2, Detail3,
			</cfif>
				Image
		</cfquery>
		<cfif getMatrixItems.RecordCount NEQ 0 >
			<cfscript>
				// ItemAvailable = 1 ; // ItemAvailable is already 1
				ShowAvailability = 1 ;
				// StockMessage = 'IN STOCK' ; // StockMessage is already IN STOCK
			</cfscript>
		<cfelse>						
			<cfscript>
				ItemAvailable = 0 ;
				ShowAvailability = 0 ;
				StockMessage = 'OUT OF STOCK' ;
			</cfscript>
		</cfif>
	<cfelse>						
		<cfscript>
			ItemAvailable = 0 ;
			ShowAvailability = 0 ;
			StockMessage = 'OUT OF STOCK' ;
		</cfscript>
	</cfif>
<!--- PRODUCT DOES NOT USE INVENTORY MATRIX --->
<cfelse>
	<cfscript>
		// SELLING BY STOCK
		if ( getProduct.SellByStock EQ 1 )
		{
			if ( getProduct.StockQuantity LTE 0 )
			{	
				ItemAvailable = 0 ;
				StockMessage = 'ON ORDER' ;
			}	
			else
			{
				ItemAvailable = 1 ;
				StockMessage = 'IN STOCK' ;
			}
		}
		// SELLING BY STATUS
		else
		{
			if ( getProduct.ItemStatus IS 'IS' )
			{
				ItemAvailable = 1 ;
				StockMessage = 'IN STOCK' ;
			}
			else if ( getProduct.ItemStatus IS 'BO' )
			{
				ItemAvailable = 1 ;
				StockMessage = 'ON ORDER' ;
				BackOrdered = 1 ;
			}
			else if ( getProduct.ItemStatus IS 'OS' )
			{
				ItemAvailable = 0 ;
				StockMessage = 'OUT OF STOCK' ;
			}
			else if ( getProduct.ItemStatus IS 'DI' )
			{
				ItemAvailable = 0 ;
				StockMessage = 'DISCONTINUED' ;
			}
		}
	</cfscript>
</cfif>
<!--- CHECK AVAILABILITY OF ITEM --->



<table width="100%" border="0" style="border-color:<cfoutput>#layout.TableHeadingBGColor#</cfoutput>;" cellpadding="0" cellspacing="0" align="center">
	<tr class="cfDefault"> 
		<td width="60%" align="center">
            <!--- CARTFUSION 4.7 - ITEM IMAGES --->
			<!--- MAIN IMAGE --->
			<cfif TRIM(getProduct.Image) NEQ '' AND FileExists(config.IU_VirtualPathDIR & '\' & ImageDir & '\' & Image) >
				<img src="images/#ImageDir#/#Image#" id="img1" border="0" align="top" alt='#ItemName#'><br><br>
			<cfelseif FileExists(config.IU_VirtualPathDIR & '\' & ImageDir & '\' & SKU & '.jpg') >
				<img src="images/#ImageDir#/#SKU#.jpg" id="img1" border="0" align="top" alt='#ItemName#'><br><br>
            <cfelseif FileExists(config.IU_VirtualPathDIR & '\' & ImageDir & '\' & SKU & '.gif') >
				<img src="images/#ImageDir#/#SKU#.gif" id="img1" border="0" align="top" alt='#ItemName#'><br><br>
			<cfelse>
                <img src="images/image-EMPTY.gif" id="img1" border="0" align="top" alt='#ItemName#'><br><br>
            </cfif>
			<!--- IMAGE LARGE VIEW --->
			<cfif TRIM(getProduct.ImageLarge) NEQ '' AND FileExists(config.IU_VirtualPathDIR & '\' & ImageDir & '\' & ImageLarge) >
				<img src="images/button-LargeView.gif" border="0" align="top"> <a href="javascript: NewWindow('LargeView.cfm?id=#ImageDir#&i=#ImageLarge#','LargeImage','600','600','no')">View Large Image</a><br><br>
			</cfif>
            
			<!--- CARTFUSION 4.5 IMAGE SWATCHER --->
            <cfif isDefined('getMatrixItems') AND getProduct.UseMatrix EQ 1 >
                <cfquery name="getOptionImages" dbtype="query">
                    SELECT	DISTINCT (OptionImage)
                    FROM	getMatrixItems
                    WHERE	OptionImage != '' 
                    AND 	OptionImage IS NOT NULL
                </cfquery>

                <SCRIPT LANGUAGE="JavaScript">
                    if(document.images) {
                        swatches = new Array();
                        <cfloop query="getOptionImages">
                        swatches[#CurrentRow#] = new Image();
                        swatches[#CurrentRow#].src = "images/#getProduct.ImageDir#/#getOptionImages.OptionImage#";
                        </cfloop>
                    }
                    function swapper(from,to) {
                        if (to != 0){
                            if(document.images) {
                            document.images[from].src = swatches[to].src;
                            }
                        }
                    }
                </SCRIPT>
                
                <cfif getOptionImages.RecordCount>
                    <table width="100%" cellpadding="3" cellspacing="0" border="0">
                        <tr>
                            <td class="cfMessage" colspan="#getOptionImages.RecordCount#"><b>PRODUCT PHOTOS</b><br />(mouse over to view, click to enlarge)</td>
                        </tr>
                        <tr>
                        <cfloop query="getOptionImages">
                            <cfquery name="getDistinctOptions" dbtype="query">
                                SELECT	DISTINCT Detail1
                                        <cfif getItemClass.Dimensions EQ 2 >
                                            , Detail2
                                        <cfelseif getItemClass.Dimensions EQ 3 >
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
                                            <cfif FileExists(#config.IU_VirtualPathDIR# & '\' & #getProduct.ImageDir# & '\' & #getOptionImages.OptionImage#)>
                                                <cfset LargePhoto = ReplaceNoCase(getOptionImages.OptionImage,'.jpg','') & '-lg.jpg' >
                                                <cfif FileExists(#config.IU_VirtualPathDIR# & '\' & #getProduct.ImageDir# & '\' & #LargePhoto#)>
                                                    <a href="javascript: NewWindow('LargeView.cfm?id=#getProduct.ImageDir#&i=#LargePhoto#','LargeImage','600','600','no')"><img src="images/#getProduct.ImageDir#/#getOptionImages.OptionImage#" id="img2" border="0" width="50" align="middle" alt='#getProduct.ItemName#' onmouseover="swapper('img1',#CurrentRow#);"></a><br />
                                                <cfelse>
                                                    <img src="images/#getProduct.ImageDir#/#getOptionImages.OptionImage#" id="img2" border="0" width="50" align="middle" alt='#getProduct.ItemName#' onmouseover="swapper('img1',#CurrentRow#);"><br />
                                                </cfif>
                                            <cfelse>
                                                <img src="images/image-EMPTY.gif" id="img2" border="0" width="50" align="middle" alt='#getProduct.ItemName#'>
                                            </cfif>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td valign="top">
                                            <cfloop query="getDistinctOptions">
                                                #getDistinctOptions.Detail1#<cfif getItemClass.Dimensions EQ 2 >, #getDistinctOptions.Detail2#<cfelseif getItemClass.Dimensions EQ 3 >, #getDistinctOptions.Detail2#, #getDistinctOptions.Detail3#</cfif>
                                                <br />
                                            </cfloop>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        <cfif CurrentRow NEQ RecordCount AND NOT CurrentRow MOD 3 >
                        </tr>
                        <tr>
                        </tr></cfif>
                        </cfloop>
                                                        
                  </table>
                </cfif>
            </cfif>
            <!--- CARTFUSION 4.5 IMAGE SWATCHER --->
            
            <!--- ALTERNATE IMAGE --->
			<cfif TRIM(getProduct.ImageAlt) NEQ '' AND FileExists(config.IU_VirtualPathDIR & '\' & ImageDir & '\' & ImageAlt) >
				<img src="images/#ImageDir#/#ImageAlt#" id="img2" border="0" align="middle" alt='#ItemName#'><br><br>
			</cfif>
			<!--- ALTERNATE IMAGE LARGE VIEW --->
			<cfif TRIM(getProduct.ImageAltLarge) NEQ '' AND FileExists(config.IU_VirtualPathDIR & '\' & ImageDir & '\' & ImageAltLarge) >
				<img src="images/button-LargeView.gif" border="0" align="top"> <a href="javascript: NewWindow('LargeView.cfm?id=#ImageDir#&i=#ImageAltLarge#','LargeImage','600','600','no')">View Large Image</a><br><br>
			</cfif>
		</td>
		<td width="1%" valign="top"></td>
		<td width="39%" valign="top">
			<cfform action="ProductDetail.cfm" method="post" preservedata="yes">
			<table width="100%" cellpadding="3" cellspacing="0" border="1" bordercolor="###layout.TableHeadingBGColor#">
			<tr bordercolor="###layout.PrimaryBGColor#">
			<td width="100%">
			<table width="100%" border="0" cellpadding="2" cellspacing="0">
				<!--- ITEM NAME --->
                <tr>
					<td width="100%" colspan="2" class="cfMessageThree">
						#ItemName#
					</td>
				</tr>
				<!--- ITEM ATTRIBUTES 1-3 --->
				<cfif Attribute1 NEQ ''>
				<tr>
					<td width="100%" colspan="2" class="cfDefault">
						#Attribute1#
					</td>
				</tr>
				</cfif>
				<cfif Attribute2 NEQ ''>
				<tr>
					<td width="100%" colspan="2" class="cfDefault">
						#Attribute2#
					</td>
				</tr>
				</cfif>
				<cfif Attribute3 NEQ ''>
				<tr>
					<td width="100%" colspan="2" class="cfDefault">
						#Attribute3#
					</td>
				</tr>
				</cfif>
                <!--- MANUFACTURER'S ITEM ID/SKU --->
				<cfif ManufacturerID NEQ ''>
				<tr>
					<td width="100%" colspan="2" class="cfMessageTwo">
						MFR## #ManufacturerID#
					</td>
				</tr>
                </cfif>
                <!--- STORE'S ITEM ID/SKU --->
				<cfif SKU NEQ ''>
				<tr>
					<td width="100%" colspan="2" class="cfMessageTwo">
						SKU## #SKU#
					</td>
				</tr>
                </cfif>
				
				<!--- MATRIX ITEMS --->
				<cfif getProduct.UseMatrix EQ 1 AND ShowAvailability EQ 1 >
					<cfquery name="getICC" dbtype="query">
						SELECT	*
						FROM	getMatrixItems
					</cfquery>
					<cfif getItemClass.Dimensions EQ 1 >
						<tr>
							<td width="70%">#getItemClass.Title1#:</td>
							<td width="30%" align="right">
							   <CF_MultipleRelatedSelects 
								  SELECTBOXES="1"
								  QUERY="getICC"
								  FORMNAME="Components"
								  FIELDNAME1="OptionName1"
								  DISPLAY1="Detail1"
								  VALUE1="Detail1"
								  >
								<input type="hidden" name="Option1Optional" value="<cfif Option1Optional EQ 1>1<cfelse>0</cfif>">
							</td>
					   </tr>
					<cfelseif getItemClass.Dimensions EQ 2 >
						<tr>
							<td width="70%">#getItemClass.Title1#:</td>
							<td width="30%" align="right">
							   <CF_MultipleRelatedSelects 
								  SELECTBOXES="2"
								  QUERY="getICC"
								  FORMNAME="Components"
								  FIELDNAME1="OptionName1"
								  FIELDNAME2="OptionName2"
								  DISPLAY1="Detail1"
								  DISPLAY2="Detail2"
								  VALUE1="Detail1"
								  VALUE2="Detail2"
								  HTMLAFTER1="<tr><td>#getItemClass.Title2#:</td><td align=right>"
								  >
								<input type="hidden" name="Option1Optional" value="<cfif Option1Optional EQ 1>1<cfelse>0</cfif>">
								<input type="hidden" name="Option2Optional" value="<cfif Option2Optional EQ 1>1<cfelse>0</cfif>">
							</td>
						</tr>					
					<cfelseif getItemClass.Dimensions EQ 3 >
						<tr>
							<td width="70%">#getItemClass.Title1#:</td>
							<td width="30%" align="right">
							   <CF_MultipleRelatedSelects 
								  SELECTBOXES="3"
								  QUERY="getICC"
								  FORMNAME="Components"
								  FIELDNAME1="OptionName1"
								  FIELDNAME2="OptionName2"
								  FIELDNAME3="OptionName3"
								  DISPLAY1="Detail1"
								  DISPLAY2="Detail2"
								  DISPLAY3="Detail3"
								  VALUE1="Detail1"
								  VALUE2="Detail2"
								  VALUE3="Detail3"
								  HTMLAFTER1="<tr><td>#getItemClass.Title2#:</td><td align=right>"
								  HTMLAFTER2="<tr><td>#getItemClass.Title3#:</td><td align=right>"
								  >
								<input type="hidden" name="Option1Optional" value="<cfif Option1Optional EQ 1>1<cfelse>0</cfif>">
								<input type="hidden" name="Option2Optional" value="<cfif Option2Optional EQ 1>1<cfelse>0</cfif>">
								<input type="hidden" name="Option3Optional" value="<cfif Option3Optional EQ 1>1<cfelse>0</cfif>">
							</td>
					   	</tr>
					</cfif>
				</cfif>
			
				<!--- CUSTOM FILE 
				<cfinclude template="../CustomFiles/ProductDetailDisplay.cfm">
				--->
				
				<!--- BEGIN: OPTIONAL DESCRIPTIONS --->
				<cfif  getProductOptions1.RecordCount NEQ 0 
                    OR getProductOptions2.RecordCount NEQ 0 
                    OR getProductOptions3.RecordCount NEQ 0 >
                    <!---
                    OR getProductOptions4.RecordCount NEQ 0 
                    OR getProductOptions5.RecordCount NEQ 0
                    OR getProductOptions6.RecordCount NEQ 0 
                    OR getProductOptions7.RecordCount NEQ 0
                    OR getProductOptions8.RecordCount NEQ 0 
                    OR getProductOptions9.RecordCount NEQ 0
                    OR getProductOptions10.RecordCount NEQ 0
					--->
					
                    <!--- UPDATED 2007/02/05 START --->
                    <cfloop from="1" to="3" index="i">
						<cfif Evaluate("getProduct.OptionName#i#") NEQ ''>
                            <tr>
                                <td width="100%" colspan="2" class="cfMessage">
                                    <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td align="left" class="cfDefault" ><b>#Evaluate("getProduct.OptionName#i#")#: &nbsp;</b></td>
                                            <td align="right">
                                                <cfif Evaluate("Option#i#Optional") EQ 0 >
                                                    <cfselect class="cfFormField" name="OptionName#i#" required="yes" message="Required: #Evaluate('getProduct.OptionName#i#')#">
                                                        <option value="">Select #Evaluate("getProduct.OptionName#i#")# --</option>
                                                    <cfloop query="getProductOptions#i#">
                                                        <cfif OptionSellByStock EQ 1 >
                                                            <cfif StockQuantity GT 0 >
                                                            <option value="#OptionName#">#OptionName#
                                                                <!--- SHOW OPTION PRICE --->
                                                                <cfif OptionPrice LT 0> [subtract $#DecimalFormat(OptionPrice * (-1))#] 
                                                                <cfelseif OptionPrice GT 0> [add $#DecimalFormat(OptionPrice)#] 
                                                                </cfif>
                                                            </option>
                                                            </cfif>
                                                        <cfelseif ItemStatus EQ 'IS' OR ItemStatus EQ 'BA' >
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
                                                    <cfloop query="getProductOptions#i#">
                                                        <cfif OptionSellByStock EQ 1 >
                                                            <cfif StockQuantity GT 0 >
                                                            <option value="#OptionName#">#OptionName#
                                                                <!--- SHOW OPTION PRICE --->
                                                                <cfif OptionPrice LT 0> [subtract $#DecimalFormat(OptionPrice * (-1))#] 
                                                                <cfelseif OptionPrice GT 0> [add $#DecimalFormat(OptionPrice)#] 
                                                                </cfif>
                                                            </option>
                                                            </cfif>
                                                        <cfelseif ItemStatus EQ 'IS' OR ItemStatus EQ 'BA' >
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
				<cfif ShowAvailability EQ 1 >
				<tr>
					<td width="70%" class="cfMessageThree" height="20">
						Availability
					</td>
					<td width="30%" class="cfAttract" align="right">
						#StockMessage#
					</td>
				</tr>
				</cfif>
				
				<!--- SHOW RETAIL PRICE --->
				<cfif isDefined('ShowRetailPrice') AND ShowRetailPrice NEQ '' >
					<cfquery name="getRetailPrice" datasource="#application.dsn#">
						SELECT	ListPrice
						FROM	Products
						WHERE	ItemID = #ItemID#
					</cfquery>
					<cfif getRetailPrice.RecordCount NEQ 0 AND getRetailPrice.ListPrice GT 0 >
					<tr>
						<td width="70%" class="cfMessageThree" height="20">Retail Price</td>
						<td width="30%" class="cfRetail" align="right">#LSCurrencyFormat(getRetailPrice.ListPrice, "local")#</td>
					</tr>
					</cfif>
				</cfif>
				<!--- SHOW STORE AND SALE PRICES --->
				<cfquery name="getPrice" datasource="#application.dsn#">
					SELECT	Price<cfif session.CustomerArray[28] EQ '' >1<cfelse>#session.CustomerArray[28]#</cfif> AS ThisPrice
					FROM	Products
					WHERE	ItemID = #ItemID#
				</cfquery>
				<cfif getPrice.RecordCount NEQ 0 AND getPrice.ThisPrice GT UseThisPrice >
					<tr>
						<td width="70%" class="cfMessageThree" height="20">Our Price</td>
						<td width="30%" class="cfRetail" align="right">#LSCurrencyFormat(getPrice.ThisPrice, "local")#</td>
					</tr>
					<tr>
						<td width="70%" class="cfAttract" height="20">SALE PRICE</td>
						<td width="30%" class="cfAttract" align="right">#LSCurrencyFormat(UseThisPrice, "local")#</td>
					</tr>
				<cfelse>
					<tr>
						<td width="70%" class="cfAttract" height="20">Our Price</td>
						<td width="30%" class="cfAttract" align="right">#LSCurrencyFormat(UseThisPrice, "local")#</td>
					</tr>
				</cfif>
			
				<cfif ItemAvailable EQ 1 >
					<tr>
						<td width="70%" class="cfMessageThree" height="20">
							Quantity
						</td>
						<td width="30%" class="cfAttract" align="right">
							<cfinput class="cfFormField" type="text" name="quantity" value="1" size="2" required="yes" message="Please enter a quantity">
						</td>
					</tr>
					<tr>
						<td width="100%" colspan="2" class="cfMessage" align="right" nowrap>
							<cfif isDefined('BackOrdered') AND BackOrdered EQ 1 >
								<input type="image" name="AddToWishlist" src="images/button-AddToWishlist.gif" align="absmiddle" 
									onClick="return confirm('This item is back-ordered.  Would you like to add it to your wishlist anyway?')" >
								<input type="image" name="AddToCart" src="images/button-AddToCart.gif" align="absmiddle" 
									onClick="return confirm('This item is back-ordered.  Would you like to add it to your cart anyway?\nWe will ship the item to you as soon as it becomes available.\nAlso, we will NOT charge you until the item is shipped.')" >
								<input type="hidden" name="BackOrdered" value="1">
							<cfelse>
								<input type="image" name="AddToWishlist" src="images/button-AddToWishlist.gif" align="absmiddle" >
								<input type="image" name="AddToCart" src="images/button-AddToCart.gif" align="absmiddle" >
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
				<cfset UseTellAFriend = 1 >
				<cfif UseTellAFriend EQ 1 >
					<tr>
						<td width="100%" colspan="2" class="cfDefault" align="center" height="30">
							<a href="javascript:NewWindow('#config.RootURL#/tellafriend.cfm?ItemID=#ItemID#','TellAFriend','820','500','yes');">Tell a friend about this product.</a>
						</td>
					</tr>
				</cfif>
				<!--- CARTFUSION 4.5 TELL-A-FRIEND FEATURE --->
				
				<input type="hidden" name="ItemID" value="#ItemID#">
			</cfform>
			</table>
			</td>
			</tr>
			</table>
		</td>
	</tr>
</table>
</cfoutput>
<!--- END: productList OUTPUT QUERY --->


<!--- BEGIN: PRODUCT EXTRAS --->
<cfoutput>
<script language="javascript">

	if (document.getElementById){ 
	document.write('<style type="text/css">\n')
	document.write('.submenu1{display: <cfif NOT show1 >none<cfelse>block</cfif>;}\n')
	document.write('</style>\n')
	document.write('<style type="text/css">\n')
	document.write('.submenu2{display: <cfif NOT show2 >none<cfelse>block</cfif>;}\n')
	document.write('</style>\n')
	document.write('<style type="text/css">\n')
	document.write('.submenu3{display: <cfif NOT show3 >none<cfelse>block</cfif>;}\n')
	document.write('</style>\n')
	document.write('<style type="text/css">\n')
	document.write('.submenu4{display: <cfif NOT show4 >none<cfelse>block</cfif>;}\n')
	document.write('</style>\n')
	document.write('<style type="text/css">\n')
	document.write('.submenu5{display: <cfif NOT show5 >none<cfelse>block</cfif>;}\n')
	document.write('</style>\n')
	}
	
	function SwitchMenu(obj){
		if(document.getElementById){
			var el = document.getElementById(obj);
			var ar = document.getElementById("ProductExtras").getElementsByTagName("span"); 
			if(el.style.display != "block"){ 
				// the commented code is to hide others when one is clicked/shown
				for (var i=0; i<ar.length; i++){
					if (ar[i].className=="submenu1") 
					ar[i].style.display = "none";
					if (ar[i].className=="submenu2") 
					ar[i].style.display = "none";
					if (ar[i].className=="submenu3") 
					ar[i].style.display = "none";
					if (ar[i].className=="submenu4") 
					ar[i].style.display = "none";
					if (ar[i].className=="submenu5") 
					ar[i].style.display = "none";
				}
				el.style.display = "block";
			}else{
				el.style.display = "none";
			}
		}
	}
</script>
<br>


<div id="ProductExtras">
	<table width="500" border="0" cellpadding="3" cellspacing="0">
		<tr>
			<td align="center" width="100" style="cursor:hand; background-image:url(images/button-ItemDetails.gif); background-repeat:no-repeat;" onclick="SwitchMenu('sub1')">Description</td>
			<td align="center" width="100" style="cursor:hand; background-image:url(images/button-ItemDetails.gif); background-repeat:no-repeat;" onclick="SwitchMenu('sub2')">Details</td>
			<td align="center" width="100" style="cursor:hand; background-image:url(images/button-ItemDetails.gif); background-repeat:no-repeat;" onclick="SwitchMenu('sub3')">Related Items</td>
			<td align="center" width="100" style="cursor:hand; background-image:url(images/button-ItemDetails.gif); background-repeat:no-repeat;" onclick="SwitchMenu('sub4')">Reviews</td>
			<td align="center" width="100" style="cursor:hand; background-image:url(images/button-ItemDetails.gif); background-repeat:no-repeat;" onclick="SwitchMenu('sub5')">Specifications</td>
		</tr>
	</table>	
	<table width="100%" border="1" bordercolor="D8DBDE" align="center" cellpadding="7" cellspacing="0">
		<tr bordercolor="#layout.PrimaryBGColor#">
			<td height="30">
				<span class="submenu1" id="sub1">
				<cfif getProduct.ItemDescription EQ ''><font class="cfErrorMsg">No product description available</font><cfelse>#getProduct.ItemDescription#</cfif>
				</span>
				<span class="submenu2" id="sub2">
				<cfif getProduct.ItemDetails EQ ''><font class="cfErrorMsg">No additional product details</font><cfelse>#getProduct.ItemDetails#</cfif>
				</span>
				<span class="submenu3" id="sub3">
				<cfinclude template="ProductRelated.cfm">
				</span>
				<span class="submenu4" id="sub4">
				<cfinclude template="ProductReviews.cfm">
				</span>
				<span class="submenu5" id="sub5">
				<cfinclude template="ProductSpecs.cfm">
				</span>
			</td>
		</tr>
	</table>
</div>
<br>
</cfoutput>
<!--- END: PRODUCT EXTRAS --->


 --->