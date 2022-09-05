<cfparam name="ErrorMsg" default="0">

<!--- BEGIN: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->
<cfif isDefined('form.UpdateDiscountInfo') AND IsDefined("form.DiscountID")>
	<cfif IsUserInRole('Administrator')>
		<cftry>
			<cfscript>				
				// CHECKBOXES
				if ( isDefined('Form.AutoApply') AND Form.AutoApply EQ 'on' ) Form.AutoApply = 1 ;
				else Form.AutoApply = 0 ;
				if ( isDefined('Form.AllowMultiple') AND Form.AllowMultiple EQ 'on' ) Form.AllowMultiple = 1 ;
				else Form.AllowMultiple = 0 ;
				if ( isDefined('Form.OverridesCat') AND Form.OverridesCat EQ 'on' ) Form.OverridesCat = 1 ;
				else Form.OverridesCat = 0 ;
				if ( isDefined('Form.OverridesSec') AND Form.OverridesSec EQ 'on' ) Form.OverridesSec = 1 ;
				else Form.OverridesSec = 0 ;
				if ( isDefined('Form.OverridesOrd') AND Form.OverridesOrd EQ 'on' ) Form.OverridesOrd = 1 ;
				else Form.OverridesOrd = 0 ;
				if ( isDefined('Form.OverridesVol') AND Form.OverridesVol EQ 'on' ) Form.OverridesVol = 1 ;
				else Form.OverridesVol = 0 ;
				if ( isDefined('Form.Expired') AND Form.Expired EQ 'on' ) Form.Expired = 1 ;
				else Form.Expired = 0 ;
				if ( isDefined('Form.ExcludeSelection') AND Form.ExcludeSelection EQ 'on' ) Form.ExcludeSelection = 1 ;
				else Form.ExcludeSelection = 0 ;
				
				if ( Form.IsPercentage EQ 1 AND Form.DiscountValue GT 100 )
					Form.DiscountValue = 100 ;
				
				// VALIDATE DISCOUNT APPLICATION VALUES
				if ( Form.ApplyToType EQ 1 )
				{
					if ( Form.ApplyTo1 EQ '' )
						ErrorMsg = 1 ;
					else if ( Form.QtyLevel1 EQ '' )
						ErrorMsg = 9 ;
					else
						Form.ApplyTo = Form.ApplyTo1 ;
						Form.QtyLevel = Form.QtyLevel1 ;
						Form.QtyLevelHi = Form.QtyLevelHi1 ;
				}
				if ( Form.ApplyToType EQ 2 )
				{
					if ( Form.ApplyTo2 EQ '' )
						ErrorMsg = 2 ;
					else
						Form.ApplyTo = Form.ApplyTo2 ;
				}
				if ( Form.ApplyToType EQ 3 )
				{
					if ( Form.ApplyTo3 EQ '' )
						ErrorMsg = 3 ;
					else
						Form.ApplyTo = Form.ApplyTo3 ;
				}
				if ( Form.ApplyToType EQ 5 )
				{
					if ( Form.ApplyTo5 EQ '' )
						ErrorMsg = 5 ;
					else
						Form.ApplyTo = Form.ApplyTo5 ;
				}
				if ( Form.ApplyToType EQ 6 )
				{
					if ( Form.QtyLevel2 EQ '' )
						ErrorMsg = 10 ;
					else
						Form.ApplyTo = 0 ;
						Form.QtyLevel = Form.QtyLevel2 ;
						Form.QtyLevelHi = Form.QtyLevelHi2 ;
				}
				if ( Form.ApplyToType EQ 7 )
				{
					if ( Form.ApplyTo7 EQ '' )
						ErrorMsg = 11 ;
					else
						Form.ApplyTo = Form.ApplyTo7 ;
				}
				if ( Form.ApplyToType EQ 8 )
				{
					if ( Form.ApplyTo8 EQ '' )
						ErrorMsg = 12 ;
					else
						Form.ApplyTo = Form.ApplyTo8 ;
				}
				// VALIDATE ADDITIONAL PURCHASE REQUIREMENTS
				if ( Form.AddPurchaseReq EQ 1 )
				{
					if ( Form.AddPurchaseVal1 EQ '' )
						ErrorMsg = 6 ;
					else
						Form.AddPurchaseVal = Form.AddPurchaseVal1 ;
				}
				if ( Form.AddPurchaseReq EQ 2 )
				{
					if ( Form.AddPurchaseVal2 EQ '' )
						ErrorMsg = 7 ;
					else
						Form.AddPurchaseVal = Form.AddPurchaseVal2 ;
				}
				if ( Form.AddPurchaseReq EQ 3 )
				{
					if ( Form.AddPurchaseVal3 EQ '' )
						ErrorMsg = 8 ;
					else
						Form.AddPurchaseVal = Form.AddPurchaseVal3 ;
				}
				
				if ( Form.ApplyToType EQ 0 OR Form.ApplyToType EQ 4 OR Form.ApplyToType EQ 9 OR Form.ApplyTo EQ '' )
				{
					Form.ApplyTo = 0 ;
					Form.QtyLevel = 1 ;
				}
				
				Form.OrderTotalLevel = Replace(Form.OrderTotalLevel, "," , "", "ALL") ;
				if ( isDefined('Form.QtyLevel') )
					Form.QtyLevel = Replace(Form.QtyLevel, "," , "", "ALL") ;
				else
					Form.QtyLevel = 1 ;
				Form.DateUpdated = #Now()# ;
				Form.UpdatedBy = #GetAuthUser()# ;
				Form.DiscountType = 1 ;
			</cfscript>	

			<cfif ErrorMsg EQ 0 >
				<cfupdate datasource="#application.dsn#" tablename="Discounts" 
					formfields="DiscountID, SiteID, DiscountCode, DiscountName, DiscountDesc, DiscountValue, DiscountType, IsPercentage, 
					AutoApply, AllowMultiple, DateValidFrom, DateValidTo, UsageLimitCust, UsageLimitTotal, OrderTotalLevel, OverridesCat, 
					OverridesSec, OverridesOrd, OverridesVol, ApplyToUser, ApplyToType, ApplyTo, QtyLevel, QtyLevelHi, AddPurchaseReq, AddPurchaseVal, 
					ExcludeSelection, Expired, DateUpdated, UpdatedBy">
				<cfset AdminMsg = 'Discount <cfoutput>#form.DiscountCode#</cfoutput> Updated Successfully' >
			<cfelse>
				<cfset AdminMsg = 'FAILED: Discount <cfoutput>#form.DiscountCode#</cfoutput> NOT Updated' >
			</cfif>
			
			<cfcatch>
				<cfset AdminMsg = 'FAIL: Discount NOT Updated - #cfcatch.Message#' >
			</cfcatch>
		</cftry>	
	<cfelse>			
		<script language="JavaScript">
			{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
		</script>
	</cfif>
</cfif>

<!--- END: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<!--- BEGIN: QUERIES --->
<cfinvoke component="#application.Queries#" method="getDiscount" returnvariable="getDiscount">
	<cfinvokeargument name="DiscountID" value="#DiscountID#">
</cfinvoke>
<cfinvoke component="#application.Queries#" method="getSites" returnvariable="getSites"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getUsers" returnvariable="getUsers"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getSKUs" returnvariable="getSKUs"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getShippingMethods" returnvariable="getShippingMethods"></cfinvoke>
<!--- END: QUERIES --->

<cfscript>
	PageTitle = 'DISCOUNT DETAIL' ;
	QuickSearch = 1;
	QuickSearchPage = 'Discounts.cfm';
	AddPage = 'DiscountAdd.cfm' ;
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">

<cfoutput>

<table width="100%" border="0" cellpadding="2" cellspacing="0">
	<cfif ErrorMsg NEQ 0 >
	<tr>
		<td colspan="4" height="24" class="cfAdminError">
			<b>
			<cfif	 ErrorMsg EQ 1>ERROR: When applying the discount to a specific product, you must select a product from the dropdown list.
			<cfelseif ErrorMsg EQ 2>ERROR: When applying the discount to any product in a category, you must select a category from the dropdown list.
			<cfelseif ErrorMsg EQ 3>ERROR: When applying the discount to any product in a section, you must select a section from the dropdown list.
			<cfelseif ErrorMsg EQ 5>ERROR: When applying the discount to a specific shipping method, you must select a shipping method from the dropdown list.
			<cfelseif ErrorMsg EQ 6>ERROR: When requiring the purchase of a specific product, you must select a product from the dropdown list.
			<cfelseif ErrorMsg EQ 7>ERROR: When requiring the purchase of any product in a category, you must select a category from the dropdown list.
			<cfelseif ErrorMsg EQ 8>ERROR: When requiring the purchase of any product in a section, you must select a section from the dropdown list.
			<cfelseif ErrorMsg EQ 9>ERROR: When applying the discount to a quantity of a certain product, you must enter a threshold of the product.
			<cfelseif ErrorMsg EQ 10>ERROR: When applying the discount to a quantity of all products, you must enter a threshold of products.
			<cfelseif ErrorMsg EQ 11>ERROR: When applying the discount to any product EXCEPT products in a category, you must select a category from the dropdown list.
			<cfelseif ErrorMsg EQ 12>ERROR: When applying the discount to any product EXCEPT products in a section, you must select a section from the dropdown list.
			</cfif>
			</b>
		</td>		
	</tr>
	</cfif>
</cfoutput>

<cfoutput query="getDiscount">
<cfform name="DiscountForm" action="DiscountDetail.cfm" method="post">
	<tr style="background-color:##65ADF1;">
		<td colspan="4" class="cfAdminHeader1" height="20">DISCOUNT INFORMATION</td>
	</tr>
	<tr>
		<td width="20%" height="5"></td>
		<td width="35%" height="5"></td>
		<td width="15%" height="5"></td>
		<td width="30%" height="5"></td>
	</tr>
	<tr>
		<td><b>Site ID:</b></td>
		<td><cfselect query="getSites" name="SiteID" value="SiteID" display="SiteName" selected="#SiteID#" size="1" class="cfAdminDefault" /></td>
		<td>Automatically Apply Discount:</td>
		<td><input type="checkbox" name="AutoApply" <cfif AutoApply EQ 1 > checked </cfif> ></td>
	</tr>
	<tr>
		<td><b>Discount Code:</b></td>
		<td><cfinput type="text" name="DiscountCode" value="#DiscountCode#" maxlength="20" required="yes" message="Please enter a discount code(name) for this discount." size="30" class="cfAdminDefault" ></td>
		<td>Allow Other Discounts:</td>
		<td><input type="checkbox" name="AllowMultiple" <cfif AllowMultiple EQ 1 > checked </cfif> ></td>
	</tr>
	<tr>
		<td><b>Discount Name:</b></td>
		<td><cfinput type="text" name="DiscountName" value="#DiscountName#" size="30" class="cfAdminDefault" maxlength="50" required="yes" message="Please enter a discount code(name) for this discount."></td>
		<td>Customer Usage Limit:</td>
		<td><cfinput type="text" name="UsageLimitCust" value="#UsageLimitCust#" size="4" class="cfAdminDefault" required="no"> (0=infinite)</td>
	</tr>
	<tr>
		<td rowspan="2">Discount Description:<br>(internal use only)</td>
		<td rowspan="2"><textarea name="DiscountDesc" cols="40" rows="3" class="cfAdminDefault">#DiscountDesc#</textarea></td>
		<td valign="top">Total Usage Limit:</td>
		<td valign="top"><cfinput type="text" name="UsageLimitTotal" value="#UsageLimitTotal#" size="4" class="cfAdminDefault" required="no"> (0=infinite)</td>
	</tr>
	<tr>
		<td><!---Discount Overrides:---></td>
		<td><!---<input type="checkbox" name="OverridesCat" <cfif OverridesCat EQ 1 > checked </cfif> >Category Discounts---></td>
	</tr>
	<tr>
		<td><b>Discount Amount:</b></td>
		<td>
			<cfinput type="text" name="DiscountValue" value="#DecimalFormat(DiscountValue)#" size="7" class="cfAdminDefault" required="yes" message="Please enter an amount for this discount.">
			<select name="IsPercentage" class="cfAdminDefault" size="1">
				<option value="0" <cfif IsPercentage NEQ 1 > selected </cfif> >$ (fixed discount)</option>
				<option value="1" <cfif IsPercentage  EQ 1 > selected </cfif> >% (percentage discount)</option>
			</select>
		</td>
		<td></td>
		<td><!---<input type="checkbox" name="OverridesOrd" <cfif OverridesOrd EQ 1 > checked </cfif> >Order Level Discounts---></td>
	</tr>
	<tr>
		<td>Activate when <i>order</i> reaches:</td>
		<td>$<cfinput type="text" name="OrderTotalLevel" value="#NumberFormat(OrderTotalLevel,9.99)#" size="10" class="cfAdminDefault" maxlength="20" required="no" validate="float" message="Please enter an order subtotal amount to activate this discount in 99.99 format."></td>
		<td></td>
		<td><!---<input type="checkbox" name="OverridesVol" <cfif OverridesVol EQ 1 > checked </cfif> >Volume Level Discounts---></td>
	</tr>
	<tr>
		<td>Date Valid From (starts):</td>
		<td>
			<cfinput type="text" name="DateValidFrom" value="#DateFormat(DateValidFrom,'mm/dd/yyyy')#" size="15" class="cfAdminDefault" required="no" validate="date" message="Please enter a beginning date this discount is valid from in mm/dd/yyyy format.">
			<cf_cal formname="DiscountForm" target="DateValidFrom" image="images/button-calendar.gif">
		</td>
		<td></td>
		<td></td>
	</tr>
	<tr>
		<td>Date Valid To (expires):</td>
		<td>
			<cfinput type="text" name="DateValidTo" value="#DateFormat(DateValidTo,'mm/dd/yyyy')#" size="15" class="cfAdminDefault" required="no" validate="date" message="Please enter an ending date this discount is valid until in mm/dd/yyyy format.">
			<cf_cal formname="DiscountForm" target="DateValidTo" image="images/button-calendar.gif">
		</td>
		<td>Expired:</td>
		<td><input type="checkbox" name="Expired" <cfif Expired EQ 1 > checked </cfif> ></td>
	</tr>
	<tr>
		<td colspan="4" height="20"></td>
	</tr>
	<tr style="background-color:##65ADF1;">
		<td colspan="4" class="cfAdminHeader1" height="20">DISCOUNT APPLICATION</td>
	</tr>
	<tr>
		<td colspan="4" height="5"></td>
	</tr>

	<tr>
		<td><b>Apply Discount To This User:</b></td>
		<td colspan="3">
			<select name="ApplyToUser" size="1" class="cfAdminDefault">
				<option value="0" <cfif getDiscount.ApplyToUser EQ 0 OR getDiscount.ApplyToUser EQ ''> selected </cfif> >All Users</option>
			<cfloop query="getUsers">
				<option value="#UID#" <cfif getDiscount.ApplyToUser EQ UID > selected </cfif> >#UName#</option>
			</cfloop>	
			</select>
		</td>
	</tr>
	<tr bgcolor="FFFFFF"><td height="4" colspan="4"></td></tr>
	<tr style="background-color:##CCCCCC;"><td height="1" colspan="4"></td></tr>
	<tr>
		<td><b>Apply Discount To:</b></td>
		<td colspan="3">
			<cfif ApplyToType EQ 9 ><cfinput type="radio" name="ApplyToType" value="9" checked="yes" required="yes" message="Please select what this discount applies to.">
			<cfelse><cfinput type="radio" name="ApplyToType" value="9" required="yes" message="Please select what this discount applies to.">
			</cfif>
			Order Total
		</td>
	</tr>
	<tr>
		<td></td>
		<td colspan="3">
			<cfif ApplyToType EQ 0 OR ApplyToType EQ '' ><cfinput type="radio" name="ApplyToType" value="0" checked="yes" required="yes" message="Please select what this discount applies to.">
			<cfelse><cfinput type="radio" name="ApplyToType" value="0" required="yes" message="Please select what this discount applies to.">
			</cfif>
			All products in order
		</td>
	</tr>
	<tr>
		<td></td>
		<td colspan="3">
			<cfif ApplyToType EQ 6 >
				<cfinput type="radio" name="ApplyToType" value="6" checked="yes" required="yes" message="Please select what this discount applies to.">
				<cfinput type="text" name="QtyLevel2" value="#QtyLevel#" size="2" class="cfAdminDefault" required="yes" message="Please enter the starting quantity where this discount will be effective."> to 
				<cfinput type="text" name="QtyLevelHi2" value="#QtyLevelHi#" size="2" class="cfAdminDefault" required="no"> of all products
			<cfelse>
				<cfinput type="radio" name="ApplyToType" value="6" required="yes" message="Please select what this discount applies to.">
				<cfinput type="text" name="QtyLevel2" value="1" size="2" class="cfAdminDefault" required="yes" message="Please enter the starting quantity where this discount will be effective."> to 
				<cfinput type="text" name="QtyLevelHi2" value="1" size="2" class="cfAdminDefault" required="yes" message="Please enter the ending quantity where this discount will be effective."> of all products
			</cfif>
		</td>
	</tr>
	<tr>
		<td></td>
		<td colspan="3">
			<cfif ApplyToType EQ 1 >
				<cfinput type="radio" name="ApplyToType" value="1" checked="yes" required="yes" message="Please select what this discount applies to.">
				<cfinput type="text" name="QtyLevel1" value="#QtyLevel#" size="2" class="cfAdminDefault" required="yes" message="Please enter the starting quantity where this discount will be effective."> to
				<cfinput type="text" name="QtyLevelHi1" value="#QtyLevelHi#" size="2" class="cfAdminDefault" required="yes" message="Please enter the ending quantity where this discount will be effective."> of this product:
			<cfelse>
				<cfinput type="radio" name="ApplyToType" value="1" required="yes" message="Please select what this discount applies to.">
				<cfinput type="text" name="QtyLevel1" value="1" size="2" class="cfAdminDefault" required="yes" message="Please enter the starting quantity where this discount will be effective."> to
				<cfinput type="text" name="QtyLevelHi1" value="1" size="2" class="cfAdminDefault" required="yes" message="Please enter the ending quantity where this discount will be effective."> of this product:
			</cfif>
			
			<select name="ApplyTo1" size="1" class="cfAdminDefault" onchange="autoChange(this,document.DiscountForm.ApplyToType[document.DiscountForm.ApplyToType.length-7]);">
				<option value="" <cfif getDiscount.ApplyTo EQ ''> selected </cfif> ></option>
			<cfloop query="getSKUs">
				<option value="#ItemID#" <cfif getDiscount.ApplyToType EQ 1 AND getDiscount.ApplyTo EQ ItemID > selected </cfif> >#SKU#</option>
			</cfloop>	
			</select>
		</td>
	</tr>
	<tr>
		<td></td>
		<td colspan="3">
			<cfif ApplyToType EQ 2 ><cfinput type="radio" name="ApplyToType" value="2" checked="yes" required="yes" message="Please select what this discount applies to.">
			<cfelse><cfinput type="radio" name="ApplyToType" value="2" required="yes" message="Please select what this discount applies to.">
			</cfif>
			All products in this category:
			<select name="ApplyTo2" size="1" class="cfAdminDefault" onchange="autoChange(this,document.DiscountForm.ApplyToType[document.DiscountForm.ApplyToType.length-6]);">
				<cfset EntryValue = ApplyTo >
				<cfinclude template="Includes/DDLCat.cfm">
				<option value="" <cfif ApplyToType NEQ 2 OR ApplyTo EQ ''> selected </cfif> ></option>
			</select>
		</td>
	</tr>
	<tr>
		<td></td>
		<td colspan="3">
			<cfif ApplyToType EQ 3 ><cfinput type="radio" name="ApplyToType" value="3" checked="yes" required="yes" message="Please select what this discount applies to.">
			<cfelse><cfinput type="radio" name="ApplyToType" value="3" required="yes" message="Please select what this discount applies to.">
			</cfif>
			All products in this section:
			<select name="ApplyTo3" size="1" class="cfAdminDefault" onchange="autoChange(this,document.DiscountForm.ApplyToType[document.DiscountForm.ApplyToType.length-5]);">
				<cfset EntryValue = ApplyTo >
				<cfinclude template="Includes/DDLSec.cfm">
				<option value="" <cfif ApplyToType NEQ 3 OR ApplyTo EQ ''> selected </cfif> ></option>
			</select>
		</td>
	</tr>
	<tr>
		<td></td>
		<td colspan="3">
			<cfif ApplyToType EQ 7 ><cfinput type="radio" name="ApplyToType" value="7" checked="yes" required="yes" message="Please select what this discount applies to.">
			<cfelse><cfinput type="radio" name="ApplyToType" value="7" required="yes" message="Please select what this discount applies to.">
			</cfif>
			All products EXCEPT products in this category:
			<select name="ApplyTo7" size="1" class="cfAdminDefault" onchange="autoChange(this,document.DiscountForm.ApplyToType[document.DiscountForm.ApplyToType.length-4]);">
				<cfset EntryValue = ApplyTo >
				<cfinclude template="Includes/DDLCat.cfm">
				<option value="" <cfif ApplyToType NEQ 7 OR ApplyTo EQ ''> selected </cfif> ></option>
			</select>
		</td>
	</tr>
	<tr>
		<td></td>
		<td colspan="3">
			<cfif ApplyToType EQ 8 ><cfinput type="radio" name="ApplyToType" value="8" checked="yes" required="yes" message="Please select what this discount applies to.">
			<cfelse><cfinput type="radio" name="ApplyToType" value="8" required="yes" message="Please select what this discount applies to.">
			</cfif>
			All products EXCEPT products in this section:
			<select name="ApplyTo8" size="1" class="cfAdminDefault" onchange="autoChange(this,document.DiscountForm.ApplyToType[document.DiscountForm.ApplyToType.length-3]);">
				<cfset EntryValue = ApplyTo >
				<cfinclude template="Includes/DDLSec.cfm">
				<option value="" <cfif ApplyToType NEQ 8 OR ApplyTo EQ ''> selected </cfif> ></option>
			</select>
		</td>
	</tr>
	<tr>
		<td></td>
		<td colspan="3">
			<cfif ApplyToType EQ 4 ><cfinput type="radio" name="ApplyToType" value="4" checked="yes" required="yes" message="Please select what this discount applies to.">
			<cfelse><cfinput type="radio" name="ApplyToType" value="4" required="yes" message="Please select what this discount applies to.">
			</cfif>
			All shipping methods
		</td>
	</tr>
	<tr>
		<td></td>
		<td colspan="3">
			<cfif ApplyToType EQ 5 ><cfinput type="radio" name="ApplyToType" value="5" checked="yes" required="yes" message="Please select what this discount applies to.">
			<cfelse><cfinput type="radio" name="ApplyToType" value="5" required="yes" message="Please select what this discount applies to.">
			</cfif>
			This shipping method:
			<select name="ApplyTo5" size="1" class="cfAdminDefault" onchange="autoChange(this,document.DiscountForm.ApplyToType[document.DiscountForm.ApplyToType.length-1]);">
				<option value="" <cfif ApplyTo EQ ''> selected </cfif> ></option>
			<cfloop query="getShippingMethods">
				<option value="#SMID#" <cfif getDiscount.ApplyToType EQ 5 AND getDiscount.ApplyTo EQ SMID > selected </cfif> >#ShippingMessage#</option>
			</cfloop>	
			</select>
		</td>
	</tr>
	<tr bgcolor="FFFFFF"><td height="4" colspan="4"></td></tr>
	<tr style="background-color:##CCCCCC;"><td height="1" colspan="4"></td></tr>
	<tr>
		<td><b>Additional Purchase Requirements:</b></td>
		<td colspan="3">
			<cfif AddPurchaseReq EQ 0 OR AddPurchaseReq EQ '' ><cfinput type="radio" name="AddPurchaseReq" value="0" checked="yes" required="yes" message="Please select the additional purchase requirements for this discount.">
			<cfelse><cfinput type="radio" name="AddPurchaseReq" value="0" required="yes" message="Please select the additional purchase requirements for this discount.">
			</cfif>
			No additional purchase is required
		</td>
	</tr>
	<tr>
		<td></td>
		<td colspan="3">
			<cfif AddPurchaseReq EQ 1 ><cfinput type="radio" name="AddPurchaseReq" value="1" checked="yes" required="yes" message="Please select the additional purchase requirements for this discount.">
			<cfelse><cfinput type="radio" name="AddPurchaseReq" value="1" required="yes" message="Please select the additional purchase requirements for this discount.">
			</cfif>
			Require the purchase of this product:
			<select name="AddPurchaseVal1" size="1" class="cfAdminDefault" onchange="autoChange(this,document.DiscountForm.AddPurchaseReq[document.DiscountForm.AddPurchaseReq.length-3]);">
				<option value="" <cfif getDiscount.AddPurchaseVal EQ ''> selected </cfif> ></option>
			<cfloop query="getSKUs">
				<option value="#ItemID#" <cfif getDiscount.AddPurchaseReq EQ 1 AND getDiscount.AddPurchaseVal EQ ItemID > selected </cfif> >#SKU#</option>
			</cfloop>	
			</select>
		</td>
	</tr>
	<tr>
		<td></td>
		<td colspan="3">
			<cfif AddPurchaseReq EQ 2 ><cfinput type="radio" name="AddPurchaseReq" value="2" checked="yes" required="yes" message="Please select the additional purchase requirements for this discount.">
			<cfelse><cfinput type="radio" name="AddPurchaseReq" value="2" required="yes" message="Please select the additional purchase requirements for this discount.">
			</cfif>
			Require the purchase of a product in this category:
			<select name="AddPurchaseVal2" size="1" class="cfAdminDefault" onchange="autoChange(this,document.DiscountForm.AddPurchaseReq[document.DiscountForm.AddPurchaseReq.length-2]);">
				<cfset EntryValue = AddPurchaseVal >
				<cfinclude template="Includes/DDLCat.cfm">
				<option value="" <cfif AddPurchaseReq NEQ 2 OR AddPurchaseVal EQ ''> selected </cfif> ></option>				
			</select>
		</td>
	</tr>
	<tr>
		<td></td>
		<td colspan="3">
			<cfif AddPurchaseReq EQ 3 ><cfinput type="radio" name="AddPurchaseReq" value="3" checked="yes" required="yes" message="Please select the additional purchase requirements for this discount.">
			<cfelse><cfinput type="radio" name="AddPurchaseReq" value="3" required="yes" message="Please select the additional purchase requirements for this discount.">
			</cfif>
			Require the purchase of a product in this section:
			<select name="AddPurchaseVal3" size="1" class="cfAdminDefault" onchange="autoChange(this,document.DiscountForm.AddPurchaseReq[document.DiscountForm.AddPurchaseReq.length-1]);">
				<cfset EntryValue = AddPurchaseVal >
				<cfinclude template="Includes/DDLSec.cfm">
				<option value="" <cfif AddPurchaseReq NEQ 3 OR AddPurchaseVal EQ ''> selected </cfif> ></option>
			</select>
		</td>
	</tr>
	<tr>
		<td></td>
		<td colspan="3">
			<cfif ExcludeSelection EQ 1 ><cfinput type="checkbox" name="ExcludeSelection" checked="yes">
			<cfelse><cfinput type="checkbox" name="ExcludeSelection" checked="no">
			</cfif>
			Exclude selection from discount application
		</td>
	</tr>
	<tr>
		<td height="20" colspan="4"></td>
	</tr>
	<tr style="background-color:##F27028;">
		<td colspan="4" height="20" class="cfAdminHeader3" align="center">
			UPDATE ABOVE INFORMATION
		</td>
	</tr>
	<tr>
		<td height="20" colspan="4"></td>
	</tr>
	<tr>
		<td colspan="4" align="center">
			<input type="submit" name="UpdateDiscountInfo" value="UPDATE CHANGES" alt="Update Changes" class="cfAdminButton">
		</td>
	</tr>

	<tr><td height="100%" colspan="4" style="padding-bottom:15px;"></td></tr>
	<input type="hidden" name="DiscountID" value="#DiscountID#">
</cfform>
</cfoutput>
</table>

<cfinclude template="LayoutAdminFooter.cfm">