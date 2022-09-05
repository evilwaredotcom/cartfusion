

<cfif session.CustomerArray[26] eq ''>
	<cflocation url="#application.RootURL#/CartEdit.cfm" addtoken="no">
</cfif>

<cfif not isDefined('Cart.CartTotal1')>
	<cfinclude template="includes/CartTotals.cfm">
</cfif>
						
<cfoutput>

<cfmodule template="templates/#application.SiteTemplate#/layout.cfm" currenttab="MyAccount" layoutstyle="Full" pagetitle="Check Out - Step 2 of 4" showcategories="false">

<!--- Start Breadcrumb --->
<cfmodule template="tags/breadCrumbs.cfm" crumblevel='2' showlinkcrumb="<a href=cartedit.cfm>Cart</a> | <a href=co-billing.cfm>Check Out</a> - Step 2 of 4" />
<!--- End BreadCrumb --->

<!--- BEGIN: CLICK BUTTON - GO TO STEP 4 --->
<cfif structKeyExists(form, "Step3")>
	<!--- <cfinclude template="CO-Payment.cfm">
	<cfabort> --->

<!--- MAKE SURE BILLING & SHIPPING INFO IS THERE --->
<cfelseif NOT isDefined('ErrorOptions') >
	<cfscript>
		if (isDefined('form.FirstName') and (
			trim(form.FirstName) eq '' or
			trim(form.LastName) eq '' or
			trim(form.Address1) eq '' or
			trim(form.City) eq '' or
			trim(form.State) eq '' or
			trim(form.Zip) eq '' or
			trim(form.Country) eq '' or
			trim(form.Phone) eq '' or
			trim(form.Email) eq '' ) )
		{
			ErrorBilling = 1 ;
		}
		if (isDefined('form.shippingFirstName') and (
			trim(form.shippingFirstName) eq '' or
			trim(form.shippingLastName) eq '' or
			trim(form.shippingAddress1) eq '' or
			trim(form.shippingCity) eq '' or
			trim(form.shippingState) eq '' or
			trim(form.shippingZip) eq '' or
			trim(form.shippingCountry) eq '' or
			trim(form.shippingPhone) eq '' ) )
		{
			ErrorShipping = 1 ;
		}
		if (isDefined('form.shippingZip') and 
			isNumeric(form.shippingZip) and 
		   (form.shippingZip LT application.BeginZipToAccept or
			form.shippingZip GT application.EndZipToAccept) )
		{
			ErrorBilling = 3 ;
		}
	</cfscript>
</cfif>

<cfif isDefined('ErrorBilling')>
	<cflocation url="CO-Billing.cfm?ErrorBilling=#ErrorBilling#" addtoken="no">
	<cfabort>
</cfif>	

<!--- APPLY SHIPPING FORM INFORMATION TO CUSTOMER ARRAY --->
<!--- ASSIGN FORM VARIABLES TO SESSION.CUSTOMERARRAY --->
<cfscript>
	// JUST IN CASE OF PREVIOUS ERROR
	if ( not isDefined('ErrorOptions') )
	{
		if ( isDefined('FirstName') )
		{
			session.CustomerArray[1]  = FirstName;
			session.CustomerArray[2]  = LastName;
			session.CustomerArray[3]  = Address1;
			session.CustomerArray[4]  = Address2;
			session.CustomerArray[5]  = City;
			session.CustomerArray[6]  = State;
			session.CustomerArray[7]  = Zip;
			session.CustomerArray[8]  = Country;
			session.CustomerArray[9]  = Phone;
			session.CustomerArray[10] = Fax;
			session.CustomerArray[11] = Email;
			session.CustomerArray[12] = CompanyName;
			session.CustomerArray[16] = 0;
			session.CustomerArray[29] = sessionID;
		}
		if ( isDefined('shippingFirstName') )
		{
			session.CustomerArray[18] = shippingFirstName;
			session.CustomerArray[19] = shippingLastName;
			session.CustomerArray[34] = shippingCompanyName;
			session.CustomerArray[20] = shippingAddress1;
			session.CustomerArray[21] = shippingAddress2;
			session.CustomerArray[22] = shippingCity;
			session.CustomerArray[23] = shippingState;
			session.CustomerArray[24] = shippingZip;
			session.CustomerArray[25] = shippingCountry;
			session.CustomerArray[35] = shippingPhone;
		}
	}
</cfscript>


<cfparam name="ErrorOptions" default="0">
<cfparam name="ErrorShippingUSPS" default="0">
<cfparam name="ErrorShippingFedex" default="0">
<cfparam name="ErrorShippingUPS" default="0">
<cfparam name="ShippingChoices" default="0">
<cfparam name="ShippingMethod" default="0">

<!--- CARTFUSION 4.6 - CART CFC --->
<cfscript>
	// CALCULATE TOTAL WEIGHT & TOTAL PRICE OF ORDER
	if ( trim(session.CustomerArray[28]) Neq '' ) {
		UserID = session.CustomerArray[28] ;
	} else {
		UserID = 1 ;
	}
	// Cart = application.Cart.getCartItems(UserID=UserID,SiteID=application.SiteID,SessionID=SessionID) ;
	// LOOK FOR AN ALL-METHODS SHIPPING DISCOUNT
	ShippingDiscount = application.Cart.getShipDiscount(UserID=UserID,SiteID=application.SiteID,SessionID=SessionID) ;
	if ( ShippingDiscount.All eq 1 )
		GlobalShipDiscount = 1 ;
	else
		GlobalShipDiscount = 0 ;
</cfscript>



<!---<div align="right"><img src="images/image-CheckoutProcess2.gif" border="0" hspace="3" align="absmiddle"></div>--->



<!--- Errors --->
<!--- IS INTERNATIONAL SHIPPING ALLOWED? --->
<!--- NO --->
<cfif session.CustomerArray[25] neq application.BaseCountry and application.AcceptIntShipment neq 1 >
	<div class="cfErrorMsg">I'm sorry, but we're not accepting orders for international shipments at this time.</div>
	<cfif ErrorOptions eq 1 >
		<div class="cfErrorMsg">ERROR: Please enter a domestic shipping address before proceeding.</div>
	</cfif>
<!--- YES --->
<cfelseif ErrorOptions eq 1 >
	<div class="cfErrorMsg">ERROR: Please select a Shipping Method.</div>
</cfif>

<cfform method="post" action="CO-Payment.cfm" name="OrderForm">
<div id="formContainer">
	<table width="100%" align="center">
		<tr>
			<!--- SHIPPING METHODS --->
			<td width="50%" valign="top">
				
				<div class="formWrap1">
				
				<div class="req"><b>*</b> Indicates required field</div>
				
				<h3>Shipping Options</h3>
				
					<table width="100%">
						<!--- SHIPMENT METHOD --->
						<cfinclude template="Includes/CO-OptionsShipping.cfm">
					</table>
					
				</div>
	
			</td>
			
			
			
			<!--- DISCOUNTS & GIFT CARDS --->
			<td width="50%" valign="top">
				
				<div class="formWrap1">
				
				<div class="req"><b>*</b> Indicates required field</div>
				
				<h3>Discounts & Gift Certificates</h3>
				
					<fieldset>
				
						<label for="discountCode"><b>Code:</b>
							<cfinput type="text" name="DiscountCode" size="20"><br/><br/>
							<div style="font-weight:normal;">If code is valid, you will see it reflected on the next page.  You may also enter a code given to you by a company affiliate here.</div>
						</label>
						
					</fieldset>
				
				</div>
	
			</td>
		</tr>
	</table>
</div>

<div align="center">
	
	<input type="submit" name="Step3" value=" Proceed to Step 3 >>" class="button">
	<!--- Set default payment type to credit card so 
		  credit card form automatically shows up on next page --->
	<input type="hidden" name="FormOfPayment" value="1" />
	
	<!--- CARTFUSION 4.6 --->
	<br/><br/>
	<hr class="snip" /><br/>
	#application.ShippingNotes#
	<!--- CARTFUSION 4.6 --->
	
</div>
</cfform>

</cfmodule>
</cfoutput>