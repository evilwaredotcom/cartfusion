<!--- DEBUGGING
<style type="text/css">
	BODY, DIV
	{ font-family:Arial, Helvetica, sans-serif; font-size:11px; }
</style>
--->

<cfif not isDefined('Cart.CartTotal')>
	<cfinclude template="CartTotals.cfm">
</cfif>
<!--- DEBUGGING
<b>CART: <cfoutput>$#DecimalFormat(Cart.CartTotal)#</cfoutput><br/><br/></b>
--->

<cfscript>
	ThisQty = 0 ;
	ThisItemID = 0 ;
	ThisItemQty = 0 ;
	ThisDiscount = 0 ;
	DiscountTotal = 0 ;
	UsedDiscounts = '' ;
</cfscript>
<cfparam name="DisplayType" default="0">

<cfquery name="getDiscounts" datasource="#application.dsn#">
	SELECT	*
	FROM	Discounts
	WHERE   <!--- DateValidFrom <= #CreateODBCDate(Now())#
	AND 	DateValidTo >= #CreateODBCDate(Now())#
	AND		--->(Expired = 0 OR Expired IS NULL)
	AND 	SiteID = #application.SiteID#
	AND	(ApplyToUser = #session.CustomerArray[28]# OR ApplyToUser = 0)
	AND		OrderTotalLevel <= #Cart.CartTotal#
	AND	   (AutoApply = 1
	<cfif structKeyExists(form, 'DiscountCode') AND form.DiscountCode NEQ '' >
	OR		DiscountCode = '#Form.DiscountCode#'
	<cfelseif structKeyExists(form, 'DiscountUsed') AND form.DiscountUsed NEQ '' >
	OR		DiscountID = #Form.DiscountUsed#
	</cfif>)
	ORDER BY QtyLevel ASC, OrderTotalLevel DESC, ApplyToType ASC
</cfquery>

<!--- DEBUGGING
QUERIED --<br/>
<cfoutput query="getDiscounts">#DiscountID#: #DiscountCode# (#ApplyToType#) <br/></cfoutput>
<br/><hr />
 --->

<!--- CHECK THE CART ITEMS TO SEE IF THEY APPLY TO THE ENTERED DISCOUNT --->
<cfloop query="getCartItems.data">
	<cfscript>
		ThisItemID = getCartItems.data.ItemID ;
		ThisItemQty = getCartItems.data.Qty ;
		ApplyMultiple = 1 ;
	</cfscript>
	
	<!--- DEBUGGING
	<b>CART ITEM: <cfoutput>#getCartItems.data.CartItemID#</cfoutput></b>
	<cfquery name="itemName" datasource="#application.dsn#">
		SELECT	ItemName
		FROM	Products
		WHERE	ItemID = #getCartItems.data.ItemID#
	</cfquery>
	<cfoutput>#itemName.itemName#</cfoutput>
	<br/><hr />
	<div style="padding-left:30px;">
	--->
	
	<cfoutput query="getDiscounts">
		<!--- IF DISCOUNT IS NOT FOR WHOLE ORDER OR SHIPPING METHODS, AND MULTIPLE DISCOUNTS STILL ALLOWED --->
		<cfif ApplyToType NEQ 4 AND ApplyToType NEQ 5 AND ApplyToType NEQ 9 AND ApplyMultiple EQ 1 >
			
			<!--- DEBUGGING
			ITEM: <b>#ThisItemID#</b><br/>
			NOT SHIPPING DISCOUNT --
			#DiscountID#: #DiscountCode# (#ApplyToType#) (#ApplyTo#) <br/><hr />
			--->
			
			<!--- CHECK EACH CART ITEM --->
			<cfquery name="checkDiscount" datasource="#application.dsn#">
				SELECT	*
				FROM	Discounts
				WHERE	DiscountID = #getDiscounts.DiscountID#
				<!--- QUANTITY OF PRODUCTS --->
				<cfif getDiscounts.ApplyToType EQ 1 >
					AND		ApplyTo = #ThisItemID#
					AND		QtyLevel <= #ThisItemQty#
				<!--- PRODUCTS IN CATEGORY --->
				<cfelseif getDiscounts.ApplyToType EQ 2 >
					AND		ApplyTo IN
							(
								SELECT	c.CatID
								FROM	Categories c, Products p
								WHERE	c.CatID = #getDiscounts.ApplyTo#
								AND		p.ItemID = #ThisItemID#
								AND		p.Category = #getDiscounts.ApplyTo#
							)
				<!--- PRODUCTS IN SECTION --->
				<cfelseif getDiscounts.ApplyToType EQ 3 >
					AND		ApplyTo IN
							(
								SELECT	s.SectionID
								FROM	Sections s, Products p
								WHERE	s.SectionID = #getDiscounts.ApplyTo#
								AND		p.ItemID = #ThisItemID#
								AND		p.SectionID = #getDiscounts.ApplyTo#
							)
				<!--- NOTHING <cfelseif getDiscounts.ApplyToType EQ 6 >--->
				<!--- PRODUCTS NOT IN CATEGORY --->
				<cfelseif getDiscounts.ApplyToType EQ 7 >
					AND		ApplyTo NOT IN
							(
								SELECT	c.CatID
								FROM	Categories c, Products p
								WHERE	c.CatID = #getDiscounts.ApplyTo#
								AND		p.ItemID = #ThisItemID#
								AND		p.Category = #getDiscounts.ApplyTo#
							)
				<!--- PRODUCTS NOT IN SECTION --->
				<cfelseif getDiscounts.ApplyToType EQ 8 >
					AND		ApplyTo NOT IN
							(
								SELECT	s.SectionID
								FROM	Sections s, Products p
								WHERE	s.SectionID = #getDiscounts.ApplyTo#
								AND		p.ItemID = #ThisItemID#
								AND		p.SectionID = #getDiscounts.ApplyTo#
							)
				</cfif>
			</cfquery>
						
			<!--- IF DISCOUNT APPLIES TO THIS CART ITEM, CALCULATE IT'S DISCOUNT VALUE
				  AND ADD IT TO THE DISCOUNT TOTAL --->
			<cfif checkDiscount.RecordCount NEQ 0 >
				
				<!--- CARTFUSION 4.6 - CART CFC --->
				<cfscript>
					if ( TRIM(session.CustomerArray[28]) NEQ '' ) {
						UserID = session.CustomerArray[28] ;
					} else {
						UserID = 1 ;
					}
					UseThisPrice = application.Cart.getItemPrice(
						UserID=UserID,
						SiteID=application.SiteID,
						ItemID=ThisItemID,
						SessionID=SessionID,
						OptionName1=getCartItems.data.OptionName1,
						OptionName2=getCartItems.data.OptionName2,
						OptionName3=getCartItems.data.OptionName3);
				</cfscript>
				
				<!--- PURCHASE REQUIREMENTS & EXCLUSION OPTION --->
				<cfif checkDiscount.AddPurchaseReq GT 0 >
					<!--- LOOK FOR A PRODUCT IN CART THAT IS AddPurchaseVal --->
					<cfif checkDiscount.AddPurchaseReq EQ 1 >
						<cfquery name="checkRequirement" dbtype="query">
							SELECT	ItemID
							FROM	getCartItems.data
							WHERE	ItemID = #checkDiscount.AddPurchaseVal#
						</cfquery>
						<cfif checkRequirement.RecordCount GT 0 >
							<cfif checkDiscount.AddPurchaseVal EQ ThisItemID >
								<cfset ContinueDiscount = 0 >
							<cfelse>
								<cfset ContinueDiscount = 1 >
							</cfif>
						<cfelse>
							<cfset ContinueDiscount = 0 >
						</cfif>
					<!--- LOOK FOR A PRODUCT IN CART THAT IS IN CATEGORY OF AddPurchaseVal --->
					<cfelseif checkDiscount.AddPurchaseReq EQ 2 >
						<cfset ContinueDiscount = 0 >
						<cfloop query="getCartItems.data">
							<cfquery name="checkRequirement" datasource="#application.dsn#">
								SELECT	Category
								FROM	Products
								WHERE	ItemID = #ItemID#
							</cfquery>
							<cfif checkRequirement.Category EQ checkDiscount.AddPurchaseVal >
								<cfset ContinueDiscount = 1 >
							</cfif>
						</cfloop>
						<cfif ContinueDiscount EQ 1 >
							<cfquery name="checkCategory" datasource="#application.dsn#">
								SELECT	Category
								FROM	Products
								WHERE	ItemID = #ThisItemID#
								AND	   (Category = #checkDiscount.AddPurchaseVal#
								OR 		OtherCategories LIKE '%,#checkDiscount.AddPurchaseVal#,%')
							</cfquery>							
							<cfif checkCategory.RecordCount GT 0 AND checkDiscount.ExcludeSelection EQ 1 >
								<cfset ContinueDiscount = 0 >
							<cfelse>
								<cfset ContinueDiscount = 1 >
							</cfif>
						</cfif>
					<!--- LOOK FOR A PRODUCT IN CART THAT IS IN SECTION OF AddPurchaseVal --->
					<cfelseif checkDiscount.AddPurchaseReq EQ 3 >
						<cfset ContinueDiscount = 0 >
						<cfloop query="getCartItems.data">
							<cfquery name="checkRequirement" datasource="#application.dsn#">
								SELECT	SectionID
								FROM	Products
								WHERE	ItemID = #ItemID#
							</cfquery>
							<cfif checkRequirement.SectionID EQ checkDiscount.AddPurchaseVal >
								<cfset ContinueDiscount = 1 >
							</cfif>
						</cfloop>
						<cfif ContinueDiscount EQ 1 >
							<cfquery name="checkSection" datasource="#application.dsn#">
								SELECT	SectionID
								FROM	Products
								WHERE	ItemID = #ThisItemID#
								AND	   (SectionID = #checkDiscount.AddPurchaseVal#
								OR 		OtherSections LIKE '%,#checkDiscount.AddPurchaseVal#,%')
							</cfquery>						
							<cfif checkSection.RecordCount GT 0 AND checkDiscount.ExcludeSelection EQ 1 >
								<cfset ContinueDiscount = 0 >
							<cfelse>
								<cfset ContinueDiscount = 1 >
							</cfif>
						</cfif>
					</cfif>
				<cfelse>
					<cfset ContinueDiscount = 1 >
				</cfif>
				
				<!--- PURCHASE REQUIREMENT FULFILLED OR NOT APPLICABLE --->
				<cfif ContinueDiscount EQ 1 >
					<cfscript>
						// QUANTITY OF PRODUCTS
						if ( checkDiscount.ApplyToType EQ 1 OR checkDiscount.ApplyToType EQ 6 )
						{
							if ( ThisItemQty GTE checkDiscount.QtyLevel AND ThisItemQty LTE checkDiscount.QtyLevelHi )
								ThisQty = ThisItemQty ;
							else if ( ThisItemQty GTE checkDiscount.QtyLevel AND ThisItemQty GT checkDiscount.QtyLevelHi )
								ThisQty = checkDiscount.QtyLevelHi ;
							else if ( ThisItemQty GT checkDiscount.QtyLevelHi )
								ThisQty = 1 ;
							else
								ThisQty = 0 ;
						}
						else
						{
							ThisQty = ThisItemQty ;
						}
						// PERCENTAGE OR DOLLAR VALUE
						if ( checkDiscount.IsPercentage EQ 1 )
						{	
							DiscountTotal = DiscountTotal + DecimalFormat(UseThisPrice * ThisQty * 0.01 * checkDiscount.DiscountValue) ;
							ThisDiscount = DecimalFormat(UseThisPrice * ThisQty * 0.01 * checkDiscount.DiscountValue) ;
						}
						else
						{
							DiscountTotal = DiscountTotal + DecimalFormat(ThisQty * checkDiscount.DiscountValue) ;
							ThisDiscount = DecimalFormat(ThisQty * checkDiscount.DiscountValue) ;
						}
					</cfscript>				
					
					<cfif ThisQty GT 0 >
						<!--- CartEdit.cfm --->
						<cfif DisplayType EQ 1 >
						<tr>
							<td class="subTotal" align="right" colspan="5">#checkDiscount.DiscountName#:</td>
							<td class="subTotal" align="right" nowrap="nowrap">- #LSCurrencyFormat(ThisDiscount, "local")#</td>
						</tr>
						<!--- CartView.cfm --->
						<cfelseif DisplayType EQ 2 >
						<tr>
							<td class="subTotal" align="right" <cfif application.EnableMultiShip EQ 1 >colspan="5"<cfelse>colspan="4"</cfif>>#checkDiscount.DiscountName#:</td>
							<td class="subTotal" align="right" nowrap="nowrap">- #LSCurrencyFormat(ThisDiscount, "local")#</td>
						</tr>
						<!--- CartViewMini.cfm --->
						<cfelseif DisplayType EQ 3 >
						<tr>
							<td class="cfMini" align="right" colspan="3">#DiscountName#:</td>
							<td class="cfMini" align="right" nowrap="nowrap">- #LSCurrencyFormat(ThisDiscount, "local")#</td>
						</tr>
						<cfelseif DisplayType EQ 4 >
							#DiscountName#: #LSCurrencyFormat(ThisDiscount, "local")#<br/>
						</cfif>
						<!--- DEBUGGING
						DISCOUNT APPLIED --<br/>
						ITEM: <b>#ThisItemID#</b><br/>
						Name: #checkDiscount.DiscountName#<br/>
						Discount: <cfif checkDiscount.IsPercentage EQ 1 >#checkDiscount.DiscountValue#%<cfelse>$#checkDiscount.DiscountValue#</cfif><br/>
						Qty = #ThisQty#<br/>
						Value = #ThisDiscount#<br/>
						Total = #DiscountTotal#<br/><hr />
						--->
						<cfset ThisDiscount = 0 >
						
					</cfif>					
				</cfif>
			</cfif>
			<!---
			<cfloop from="1" to="#getCartItems.data.Qty#" index="i">
				<cfset UsedDiscounts = ListAppend(UsedDiscounts,checkDiscount.DiscountID) >
			</cfloop>
			--->
		</cfif>
		<cfif AllowMultiple NEQ 1 >
			<cfset ApplyMultiple = 0 >
		</cfif>
	</cfoutput>
	<!---</div>--->
</cfloop>





<!--- WHOLE ORDER DISCOUNTS: ApplyToType EQ 9 --->
<cfoutput query="getDiscounts">
	<cfscript>
		ApplyMultiple = 1 ;
	</cfscript>
	<cfif ApplyToType EQ 9 AND ApplyMultiple EQ 1 >
			
		<cfquery name="checkDiscount" dbtype="query">
			SELECT	*
			FROM	getDiscounts
			WHERE	DiscountID = #getDiscounts.DiscountID#
		</cfquery>
		
		<!--- PURCHASE REQUIREMENTS & EXCLUSION OPTION --->
		<cfif checkDiscount.AddPurchaseReq GT 0 >
			<!--- LOOK FOR A PRODUCT IN CART THAT IS AddPurchaseVal --->
			<cfif checkDiscount.AddPurchaseReq EQ 1 >
				<cfquery name="checkRequirement" dbtype="query">
					SELECT	ItemID
					FROM	getCartItems.data
					WHERE	ItemID = #checkDiscount.AddPurchaseVal#
				</cfquery>
				<cfif checkRequirement.RecordCount GT 0 >
					<cfset ContinueDiscount = 1 >
				<cfelse>
					<cfset ContinueDiscount = 0 >
				</cfif>
			<!--- LOOK FOR A PRODUCT IN CART THAT IS IN CATEGORY OF AddPurchaseVal --->
			<cfelseif checkDiscount.AddPurchaseReq EQ 2 >
				<cfset ContinueDiscount = 0 >
				<cfloop query="getCartItems.data">
					<cfquery name="checkRequirement" datasource="#application.dsn#">
						SELECT	Category
						FROM	Products


						WHERE	ItemID = #getCartItems.data.ItemID#
					</cfquery>
					<cfif checkRequirement.Category EQ checkDiscount.AddPurchaseVal >

						<cfset ContinueDiscount = 1 >
					</cfif>
				</cfloop>
			<!--- LOOK FOR A PRODUCT IN CART THAT IS IN SECTION OF AddPurchaseVal --->
			<cfelseif checkDiscount.AddPurchaseReq EQ 3 >
				<cfset ContinueDiscount = 0 >
				<cfloop query="getCartItems.data">
					<cfquery name="checkRequirement" datasource="#application.dsn#">
						SELECT	SectionID
						FROM	Products
						WHERE	ItemID = #getCartItems.data.ItemID#
					</cfquery>
					<cfif checkRequirement.SectionID EQ checkDiscount.AddPurchaseVal >
						<cfset ContinueDiscount = 1 >
					</cfif>
				</cfloop>
			</cfif>
		<cfelse>
			<cfset ContinueDiscount = 1 >
		</cfif>
		
		<!--- PURCHASE REQUIREMENT FULFILLED OR NOT APPLICABLE --->
		<cfif ContinueDiscount EQ 1 >
			<cfscript>
				//
				ThisQty = 1 ;
				// PERCENTAGE OR DOLLAR VALUE
				if ( checkDiscount.IsPercentage EQ 1 )
				{	
					DiscountTotal = DiscountTotal + DecimalFormat(Cart.CartTotal * 0.01 * checkDiscount.DiscountValue) ;
					ThisDiscount = DecimalFormat(Cart.CartTotal * 0.01 * checkDiscount.DiscountValue) ;
				}
				else
				{
					DiscountTotal = DiscountTotal + DecimalFormat(checkDiscount.DiscountValue) ;
					ThisDiscount = DecimalFormat(checkDiscount.DiscountValue) ;
				}
			</cfscript>				
			
			<cfif ThisQty GT 0 >
				<!--- CartEdit.cfm --->
				<cfif DisplayType EQ 1 >
				<tr>
					<td class="subTotal" align="right" colspan="5">#checkDiscount.DiscountName#:</td>
					<td class="subTotal" align="right" nowrap="nowrap">- #LSCurrencyFormat(ThisDiscount, "local")#</td>
				</tr>
				<!--- CartView.cfm --->
				<cfelseif DisplayType EQ 2 >
				<tr>
					<td class="subTotal" align="right" <cfif application.EnableMultiShip EQ 1 >colspan="5"<cfelse>colspan="4"</cfif>>#checkDiscount.DiscountName#:</td>
					<td class="subTotal" align="right" nowrap="nowrap">- #LSCurrencyFormat(ThisDiscount, "local")#</td>
				</tr>
				<!--- CartViewMini.cfm --->
				<cfelseif DisplayType EQ 3 >
				<tr>
					<td class="cfMini" align="right" colspan="3">#DiscountName#:</td>
					<td class="cfMini" align="right" nowrap="nowrap">- #LSCurrencyFormat(ThisDiscount, "local")#</td>
				</tr>
				<cfelseif DisplayType EQ 4 >
					#DiscountName#: #LSCurrencyFormat(ThisDiscount, "local")#<br/>
				</cfif>
				<!--- DEBUGGING
				DISCOUNT APPLIED --<br/>
				ITEM: <b>#ThisItemID#</b><br/>
				Name: #checkDiscount.DiscountName#<br/>
				Discount: <cfif checkDiscount.IsPercentage EQ 1 >#checkDiscount.DiscountValue#%<cfelse>$#checkDiscount.DiscountValue#</cfif><br/>
				Qty = #ThisQty#<br/>
				Value = #ThisDiscount#<br/>
				Total = #DiscountTotal#<br/><hr />
				--->
				<cfset ThisDiscount = 0 >
			</cfif>
		</cfif>
		<!---
		<cfloop from="1" to="#getCartItems.data.Qty#" index="i">
			<cfset UsedDiscounts = ListAppend(UsedDiscounts,checkDiscount.DiscountID) >
		</cfloop>
		--->
	</cfif>
	<cfif AllowMultiple NEQ 1 >
		<cfset ApplyMultiple = 0 >
	</cfif>
</cfoutput>


<!--- DEBUGGING
<b>DISCOUNT: <cfoutput>$#DecimalFormat(DiscountTotal)#</cfoutput><br/></b>
<b>TOTAL: <cfoutput>$#DecimalFormat(Cart.CartTotal - DiscountTotal)#</cfoutput><br/><br/></b>
<cfabort>
--->
