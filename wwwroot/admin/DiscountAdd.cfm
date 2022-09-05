<cfparam name="ErrorMsg" default="0">

<!--- BEGIN: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->
<cfif isDefined('Form.AddDiscount')>
	<cfif isUserInRole('Administrator')>
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
				Form.DateCreated = #Now()# ;
				Form.DateUpdated = #Now()# ;
				Form.UpdatedBy = #GetAuthUser()# ;
				Form.DiscountType = 1 ;
			</cfscript>
		
			<cfif ErrorMsg EQ 0 >
				<cfinsert datasource="#application.dsn#" tablename="Discounts" 
					formfields="SiteID, DiscountCode, DiscountName, DiscountDesc, DiscountValue, DiscountType, IsPercentage, 
					AutoApply, AllowMultiple, DateValidFrom, DateValidTo, UsageLimitCust, UsageLimitTotal, OrderTotalLevel, OverridesCat, 
					OverridesSec, OverridesOrd, OverridesVol, ApplyToUser, ApplyToType, ApplyTo, QtyLevel, QtyLevelHi, AddPurchaseReq, AddPurchaseVal, 
					ExcludeSelection, Expired, DateUpdated, UpdatedBy">
					
				<!--- GET NEWLY ASSIGNED SKU NUMBER --->
				<cfquery name="getAddedID" datasource="#application.dsn#">
					SELECT	MAX(DiscountID) AS DiscountID
					FROM	Discounts
				</cfquery>

				<cfif getAddedID.RecordCount NEQ 0 >				
					<cfset DiscountID = getAddedID.DiscountID >
					<cfset AdminMsg = 'Discount <cfoutput>#form.DiscountCode#</cfoutput> Added Successfully' >
					<cflocation url="DiscountDetail.cfm?DiscountID=#DiscountID#&AdminMsg=#URLEncodedFormat(AdminMsg)#" addtoken="no">
					<cfabort>
				</cfif>
			</cfif>			

			<cfcatch>
				<cfset AdminMsg = 'FAIL: Discount NOT Added - #cfcatch.Message#' >
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
<cfinvoke component="#application.Queries#" method="getSites" returnvariable="getSites"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getUsers" returnvariable="getUsers"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getSKUs" returnvariable="getSKUs"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getShippingMethods" returnvariable="getShippingMethods"></cfinvoke>
<!--- END: QUERIES --->

<cfscript>
	PageTitle = 'ADD DISCOUNT' ;
	QuickSearch = 1;
	QuickSearchPage = 'Discounts.cfm';
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
<cfform name="DiscountForm" action="DiscountAdd.cfm" method="post">
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
		<td><cfselect query="getSites" name="SiteID" value="SiteID" display="SiteName" selected="#application.SiteID#" size="1" class="cfAdminDefault" /></td>
		<td>Automatically Apply Discount:</td>
		<td><cfinput type="checkbox" name="AutoApply" checked ></td>
	</tr>
	<tr>
		<td><b>Discount Code:</b></td>
		<td><cfinput type="text" name="DiscountCode" maxlength="20" required="yes" message="Please enter a discount code(name) for this discount." size="30" class="cfAdminDefault" ></td>
		<td>Allow Other Discounts:</td>
		<td><cfinput type="checkbox" name="AllowMultiple" ></td>
	</tr>
	<tr>
		<td><b>Discount Name:</b></td>
		<td><cfinput type="text" name="DiscountName" size="30" class="cfAdminDefault" maxlength="50" required="yes" message="Please enter a discount code(name) for this discount."></td>
		<td>Customer Usage Limit:</td>
		<td><cfinput type="text" name="UsageLimitCust" value="0" size="4" class="cfAdminDefault" required="no"> (0=infinite)</td>
	</tr>
	<tr>
		<td rowspan="2">Discount Description:<br>(internal use only)</td>
		<td rowspan="2"><textarea name="DiscountDesc" cols="40" rows="3" class="cfAdminDefault"></textarea></td>
		<td valign="top">Total Usage Limit:</td>
		<td valign="top"><cfinput type="text" name="UsageLimitTotal" value="0" size="4" class="cfAdminDefault" required="no"> (0=infinite)</td>
	</tr>
	<tr>
		<td><!---Discount Overrides:---></td>
		<td><!---<cfinput type="checkbox" name="OverridesCat" >Category Discounts---></td>
	</tr>
	<tr>
		<td><b>Discount Amount:</b></td>
		<td>
			<cfinput type="text" name="DiscountValue" size="7" class="cfAdminDefault" required="yes" message="Please enter an amount for this discount.">
			<select name="IsPercentage" class="cfAdminDefault" size="1">
				<option value="0" selected >$ (fixed discount)</option>
				<option value="1" >% (percentage discount)</option>
			</select>
		</td>
		<td></td>
		<td><!---<cfinput type="checkbox" name="OverridesOrd" >Order Level Discounts---></td>
	</tr>
	<tr>
		<td>Activate when <i>order</i> reaches:</td>
		<td>$<cfinput type="text" name="OrderTotalLevel" value="0.00" size="10" class="cfAdminDefault" maxlength="20" required="no" validate="float" message="Please enter an order subtotal amount to activate this discount in 99.99 format."></td>
		<td></td>
		<td><!---<cfinput type="checkbox" name="OverridesVol" >Volume Level Discounts---></td>
	</tr>
	<tr>
		<td>Date Valid From (starts):</td>
		<td>
			<cfinput type="text" name="DateValidFrom" value="#DateFormat(Now(),'mm/dd/yyyy')#" size="15" class="cfAdminDefault" required="no" validate="date" message="Please enter a beginning date this discount is valid from in mm/dd/yyyy format.">
			<cf_cal formname="DiscountForm" target="DateValidFrom" image="images/button-calendar.gif">
		</td>
		<td></td>
		<td></td>
	</tr>
	<tr>
		<td>Date Valid To (expires):</td>
		<td>
			<cfinput type="text" name="DateValidTo" value="12/31/2030" size="15" class="cfAdminDefault" required="no" validate="date" message="Please enter an ending date this discount is valid until in mm/dd/yyyy format.">
			<cf_cal formname="DiscountForm" target="DateValidTo" image="images/button-calendar.gif">
		</td>
		<td>Expired:</td>
		<td><cfinput type="checkbox" name="Expired" ></td>
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
				<option value="0" selected >All Users</option>
			<cfloop query="getUsers">
				<option value="#UID#" >#UName#</option>
			</cfloop>	
			</select>
		</td>
	</tr>
	<tr bgcolor="FFFFFF"><td height="4" colspan="4"></td></tr>
	<tr style="background-color:##CCCCCC;"><td height="1" colspan="4"></td></tr>
	<tr>
		<td><b>Apply Discount To:</b></td>
		<td colspan="3">
			<cfinput type="radio" name="ApplyToType" value="9" checked="yes" required="yes" message="Please select what this discount applies to.">
			Order Total
		</td>
	</tr>
	<tr>
		<td></td>
		<td colspan="3">
			<cfinput type="radio" name="ApplyToType" value="0" checked="yes" required="yes" message="Please select what this discount applies to.">
			All products in order
		</td>
	</tr>
	<tr>
		<td></td>
		<td colspan="3">
			<cfinput type="radio" name="ApplyToType" value="6" required="yes" message="Please select what this discount applies to.">
			<cfinput type="text" name="QtyLevel2" value="1" size="2" class="cfAdminDefault" required="yes" message="Please enter the starting quantity where this discount will be effective."> to
			<cfinput type="text" name="QtyLevelHi2" value="1" size="2" class="cfAdminDefault" required="yes" message="Please enter the ending quantity where this discount will be effective."> of all products
		</td>
	</tr>
	<tr>
		<td></td>
		<td colspan="3">
			<cfinput type="radio" name="ApplyToType" value="1" required="yes" message="Please select what this discount applies to.">
			<cfinput type="text" name="QtyLevel1" value="1" size="2" class="cfAdminDefault" required="yes" message="Please enter the starting quantity where this discount will be effective."> to
			<cfinput type="text" name="QtyLevelHi1" value="1" size="2" class="cfAdminDefault" required="yes" message="Please enter the ending quantity where this discount will be effective."> of this product:
			<select name="ApplyTo1" size="1" class="cfAdminDefault" onchange="autoChange(this,document.DiscountForm.ApplyToType[document.DiscountForm.ApplyToType.length-7]);">
				<option value="" selected ></option>
			<cfloop query="getSKUs">
				<option value="#ItemID#" >#SKU#</option>
			</cfloop>	
			</select>
		</td>
	</tr>
	<tr>
		<td></td>
		<td colspan="3">
			<cfinput type="radio" name="ApplyToType" value="2" required="yes" message="Please select what this discount applies to.">
			All products in this category:
			<select name="ApplyTo2" size="1" class="cfAdminDefault" onchange="autoChange(this,document.DiscountForm.ApplyToType[document.DiscountForm.ApplyToType.length-6]);">
				<cfset EntryValue = '' >
				<cfinclude template="Includes/DDLCat.cfm">
				<option value="" selected ></option>
			</select>
		</td>
	</tr>
	<tr>
		<td></td>
		<td colspan="3">
			<cfinput type="radio" name="ApplyToType" value="3" required="yes" message="Please select what this discount applies to.">
			All products in this section:
			<select name="ApplyTo3" size="1" class="cfAdminDefault" onchange="autoChange(this,document.DiscountForm.ApplyToType[document.DiscountForm.ApplyToType.length-5]);">
				<cfset EntryValue = '' >
				<cfinclude template="Includes/DDLSec.cfm">
				<option value="" selected ></option>
			</select>
		</td>
	</tr>
	<tr>
		<td></td>
		<td colspan="3">
			<cfinput type="radio" name="ApplyToType" value="7" required="yes" message="Please select what this discount applies to.">
			All products EXCEPT products in this category:
			<select name="ApplyTo7" size="1" class="cfAdminDefault" onchange="autoChange(this,document.DiscountForm.ApplyToType[document.DiscountForm.ApplyToType.length-4]);">
				<cfset EntryValue = '' >
				<cfinclude template="Includes/DDLCat.cfm">
				<option value="" selected ></option>
			</select>
		</td>
	</tr>
	<tr>
		<td></td>
		<td colspan="3">
			<cfinput type="radio" name="ApplyToType" value="8" required="yes" message="Please select what this discount applies to.">
			All products EXCEPT products in this section:
			<select name="ApplyTo8" size="1" class="cfAdminDefault" onchange="autoChange(this,document.DiscountForm.ApplyToType[document.DiscountForm.ApplyToType.length-3]);">
				<cfset EntryValue = '' >
				<cfinclude template="Includes/DDLSec.cfm">
				<option value="" selected ></option>
			</select>
		</td>
	</tr>
	<tr>
		<td></td>
		<td colspan="3">
			<cfinput type="radio" name="ApplyToType" value="4" required="yes" message="Please select what this discount applies to.">
			All shipping methods
		</td>
	</tr>
	<tr>
		<td></td>
		<td colspan="3">
			<cfinput type="radio" name="ApplyToType" value="5" required="yes" message="Please select what this discount applies to.">
			This shipping method:
			<select name="ApplyTo5" size="1" class="cfAdminDefault" onchange="autoChange(this,document.DiscountForm.ApplyToType[document.DiscountForm.ApplyToType.length-1]);">
				<option value="" selected ></option>
			<cfloop query="getShippingMethods">
				<option value="#SMID#" >#ShippingMessage#</option>
			</cfloop>	
			</select>
		</td>
	</tr>
	<tr bgcolor="FFFFFF"><td height="4" colspan="4"></td></tr>
	<tr style="background-color:##CCCCCC;"><td height="1" colspan="4"></td></tr>
	<tr>
		<td><b>Additional Purchase Requirements:</b></td>
		<td colspan="3">
			<cfinput type="radio" name="AddPurchaseReq" value="0" checked="yes" required="yes" message="Please select the additional purchase requirements for this discount.">
			No additional purchase is required
		</td>
	</tr>
	<tr>
		<td></td>
		<td colspan="3">
			<cfinput type="radio" name="AddPurchaseReq" value="1" required="yes" message="Please select the additional purchase requirements for this discount.">
			Require the purchase of this product:
			<select name="AddPurchaseVal1" size="1" class="cfAdminDefault" onchange="autoChange(this,document.DiscountForm.AddPurchaseReq[document.DiscountForm.AddPurchaseReq.length-3]);">
				<option value="" selected ></option>
			<cfloop query="getSKUs">
				<option value="#ItemID#" >#SKU#</option>
			</cfloop>	
			</select>
		</td>
	</tr>
	<tr>
		<td></td>
		<td colspan="3">
			<cfinput type="radio" name="AddPurchaseReq" value="2" required="yes" message="Please select the additional purchase requirements for this discount.">
			Require the purchase of a product in this category:
			<select name="AddPurchaseVal2" size="1" class="cfAdminDefault" onchange="autoChange(this,document.DiscountForm.AddPurchaseReq[document.DiscountForm.AddPurchaseReq.length-2]);">
				<cfset EntryValue = '' >
				<cfinclude template="Includes/DDLCat.cfm">
				<option value="" selected ></option>				
			</select>
		</td>
	</tr>
	<tr>
		<td></td>
		<td colspan="3">
			<cfinput type="radio" name="AddPurchaseReq" value="3" required="yes" message="Please select the additional purchase requirements for this discount.">
			Require the purchase of a product in this section:
			<select name="AddPurchaseVal3" size="1" class="cfAdminDefault" onchange="autoChange(this,document.DiscountForm.AddPurchaseReq[document.DiscountForm.AddPurchaseReq.length-1]);">
				<cfset EntryValue = '' >
				<cfinclude template="Includes/DDLSec.cfm">
				<option value="" selected ></option>
			</select>
		</td>
	</tr>
	<tr>
		<td></td>
		<td colspan="3">
			<cfinput type="checkbox" name="ExcludeSelection" checked="no">
			Exclude selection from discount application
		</td>
	</tr>
	<tr>
		<td height="20" colspan="4"></td>
	</tr>
	<tr style="background-color:##F27028;">
		<td colspan="4" height="20" class="cfAdminHeader3" align="center">
			ADD THIS DISCOUNT
		</td>
	</tr>
	<tr>
		<td height="20" colspan="4"></td>
	</tr>
	<tr>
		<td colspan="4" align="center">
			<input type="submit" name="AddDiscount" value="ADD DISCOUNT" alt="Add This Discount" class="cfAdminButton">
		</td>
	</tr>

	<tr><td height="100%" colspan="4" style="padding-bottom:15px;"></td></tr>
</cfform>
</table>

</cfoutput>

<cfinclude template="LayoutAdminFooter.cfm">