<!--- BEGIN: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<!--- ORDER INFO UPDATE --->
<cfif isDefined('form.UpdateOrderInfo') AND IsDefined("form.OrderID")>
	<cftry>
		<!--- ADMINISTRATOR UPDATE --->
		<cfif isUserInRole('Administrator')>
			<cfscript>	
				if ( isDefined('form.PaymentVerified') )
					Form.PaymentVerified = 1;
				else
					Form.PaymentVerified = 0;
				if ( Form.CCNum NEQ '' ) 
					Form.CCNum = TRIM(ENCRYPT(Form.CCNum, application.CryptKey, "CFMX_COMPAT", "Hex")) ;
				if ( Form.CCexpdate NEQ '' ) 
					Form.CCexpdate = TRIM(ENCRYPT(Form.CCexpdate, application.CryptKey, "CFMX_COMPAT", "Hex")) ;
				Form.DateUpdated = #Now()#;
				Form.UpdatedBy = #GetAuthUser()#;
			</cfscript>
			
			<cfupdate datasource="#application.dsn#" tablename="Orders" 
				formfields="SiteID, OrderID, OrderStatus, BillingStatus, ShipDate, AffiliateID, Phone, DateUpdated, UpdatedBy, FormOfPayment,
				OShipFirstName, OShipLastName, OShipCompanyName, OShipAddress1, OShipAddress2, OShipCity, OShipState, OShipZip, OShipCountry,
				CCName, CCNum, CCExpDate, CCCVV, PaymentVerified, CustomerComments, Comments, ShippingMethod, TrackingNumber">
		<!--- USER UPDATE --->
		<cfelse>
			<cfscript>	
				if ( isDefined('form.PaymentVerified') )
					Form.PaymentVerified = 1;
				else
					Form.PaymentVerified = 0;
				Form.DateUpdated = #Now()#;
				Form.UpdatedBy = #GetAuthUser()#;
			</cfscript>
			
			<cfupdate datasource="#application.dsn#" tablename="Orders" 
				formfields="SiteID, OrderID, OrderStatus, BillingStatus, ShipDate, AffiliateID, Phone, DateUpdated, UpdatedBy, FormOfPayment,
				OShipFirstName, OShipLastName, OShipCompanyName, OShipAddress1, OShipAddress2, OShipCity, OShipState, OShipZip, OShipCountry,
				PaymentVerified, CustomerComments, Comments, ShippingMethod, TrackingNumber">
		</cfif>
		
		<cfset AdminMsg = 'Order #form.OrderID# Information Updated Successfully' >
		
		<cfcatch>
			<cfset AdminMsg = 'FAIL: Order NOT Updated. #cfcatch.Message#' >
		</cfcatch>
	</cftry>
</cfif>

<!--- DELETE ORDER ITEM --->
<cfif isDefined('form.DeleteOrderItem') AND IsDefined("form.OrderItemsID") AND IsDefined("form.ItemID")>
	<cftry>
		<cflock timeout="20">
			<cfinvoke component="#application.Queries#" method="deleteOrderItem" returnvariable="deleteOrderItem">
				<cfinvokeargument name="OrderItemsID" value="#Form.OrderItemsID#">
				<cfinvokeargument name="ItemID" value="#Form.ItemID#">
			</cfinvoke>
		</cflock>
		<cfset AdminMsg = 'Order Item Deleted Successfully' >

		<cfcatch>
			<cfset AdminMsg = 'FAIL: Item NOT Deleted' >
		</cfcatch>
	</cftry>
</cfif>

<!--- END: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<!--- BEGIN: QUERIES ------------------------------------------------------------->

<cflock timeout="20">
	<cfinvoke component="#application.Queries#" method="getOrder" returnvariable="getOrder">
		<cfinvokeargument name="OrderID" value="#OrderID#">
	</cfinvoke>
	<cfinvoke component="#application.Queries#" method="getOrderItems" returnvariable="getOrderItems">
		<cfinvokeargument name="OrderID" value="#OrderID#">
	</cfinvoke>
	<cfinvoke component="#application.Queries#" method="getBackOrders" returnvariable="getBackOrders">
		<cfinvokeargument name="OrderID" value="#OrderID#">
	</cfinvoke>
</cflock>
<!---<cfset getOrderExecutionTime = #cfstoredproc.ExecutionTime# >--->

<cfinvoke component="#application.Queries#" method="getOrderStatusCodes" returnvariable="getOrderStatusCodes"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getBillingStatusCodes" returnvariable="getBillingStatusCodes"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getOrderItemsStatusCodes" returnvariable="getOrderItemsStatusCodes"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getStates" returnvariable="getStates"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getCountries" returnvariable="getCountries"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getPaymentTypes" returnvariable="getPaymentTypes"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getUsers" returnvariable="getUsers"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getShippingMethods" returnvariable="getShippingMethods"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getAffiliatesDDL" returnvariable="getAffiliatesDDL"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getSites" returnvariable="getSites"></cfinvoke>

<cfquery name="getOrderReturns" datasource="#application.dsn#">
	SELECT	*
	FROM	OrderReturns
	WHERE	OrderID = #OrderID#
</cfquery>
<!--- END: QUERIES ------------------------------------------------------------->

<!--- BEGIN: HEADER --->
<cfscript>
	PageTitle = 'ORDER DETAIL';
	QuickSearch = 1;
	QuickSearchPage = 'Orders.cfm';
	AddPage = 'OrderAdd.cfm';
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfscript>
	if ( isDefined('RefreshPage') AND RefreshPage EQ 1 )
	{
		BodyOptions = 'history.go();' ;
		RefreshPage = 0 ;
	}
	if ( isDefined('EmailMsg') AND EmailMsg EQ 1 )
		AdminMsg = 'Email Sent Successfully' ;
</cfscript>
<cfinclude template="AdminBanner.cfm">

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<cfoutput query="getOrder">
		<td width="33%" height="20">
			Invoice ##<a href="OrderDetail.cfm?OrderID=#OrderID#">#OrderID#</a><br>
			CustomerID: <a href="CustomerDetail.cfm?CustomerID=#CustomerID#">#CustomerID#</a><br>
			Order Date: #DateFormat(OrderDate, "d-mmm-yyyy")#
		</td>
		<td width="33%" align="center" valign="middle" class="cfAdminDefault">
			<cfquery name="getThisUser" dbtype="query">
				SELECT	UName
				FROM	getUsers
				WHERE	UID = #PriceToUse#
			</cfquery>
			User Type: <b>#getThisUser.UName#</b>
		</td>
		</cfoutput>
		
<cfform action="OrderDetail.cfm?OrderID=#OrderID#" method="post">
		<td width="33%" align="right">
			Order from Site ID: 
			<cfselect name="SiteID" query="getSites" size="1"
				value="SiteID" display="SiteName" selected="#getOrder.SiteID#" class="cfAdminDefault" />
			<!---It took #getOrderExecutionTime# milliseconds to execute this query&nbsp;--->
		</td>		
	</tr>
</table>


<cfoutput query="getOrder">

	<cfscript>
		if ( getOrder.CCNum NEQ '' ) 
			Decrypted_CCNum = DECRYPT(getOrder.CCNum, application.CryptKey, "CFMX_COMPAT", "Hex") ;
		else 
			Decrypted_CCNum = '' ;
		if ( getOrder.CCExpDate NEQ '' ) 
			Decrypted_CCExpDate = DECRYPT(getOrder.CCExpDate, application.CryptKey, "CFMX_COMPAT", "Hex") ;
		else 
			Decrypted_CCExpDate = '' ;
	</cfscript>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr><td align="left" colspan="5"></td></tr>
	<tr><td height="3"></td></tr>
	<tr style="background-color:##65ADF1;">
		<td width="32%" colspan="2" height="20" class="cfAdminHeader1" >&nbsp;&nbsp;&nbsp; BILLING INFORMATION&nbsp;
			<input type="button" name="ViewCustomerInfo" value="VIEW" alt="Edit Customer Information" class="cfAdminButton"
				onclick="document.location.href='CustomerDetail.cfm?CustomerID=#CustomerID#'">
		</td>
		<td rowspan="20" width="1%" style="background-color:##FFFFFF;">&nbsp;</td>
		<td width="32%" colspan="2" class="cfAdminHeader1" >&nbsp;&nbsp;&nbsp; SHIPPING INFORMATION</td>
		<td rowspan="20" width="1%" style="background-color:##FFFFFF;">&nbsp;</td>
		<td width="34%" colspan="2" class="cfAdminHeader1" >&nbsp;&nbsp;&nbsp; PAYMENT INFORMATION</td>
	</tr>
	<tr style="background-color:##CCCCCC;">
		<td height="1" colspan="2"></td>
		<td height="1" colspan="2"></td>
		<td height="1" colspan="2"></td>
	</tr>
	<tr>
		<td colspan="8" height="5">&nbsp;</td>
	</tr>
	<tr>
		<td width="10%">First Name:</td>
		<td width="23%">#FirstName#</td>
		<td width="10%">First Name:</td>
		<td width="23%"><cfinput type="text" name="OShipFirstName" value="#OShipFirstName#" size="30" class="cfAdminDefault" required="yes"></td>
		<cfif FormOfPayment EQ 1 >
			<td width="10%">Card Name:</td>
			<td width="24%">
				<cfif isUserInRole('Administrator')>
					<cfselect name="CCName" query="getPaymentTypes" size="1" value="Type" display="Display" selected="#getOrder.CCname#" class="cfAdminDefault">
						<option value="" <cfif getOrder.CCname EQ ''> selected </cfif> >-- Select --</option>
					</cfselect>
				<cfelse>
					<cfinvoke component="#application.Queries#" method="getPaymentType" returnvariable="getPaymentType">
						<cfinvokeargument name="Type" value="#getOrder.CCname#">
					</cfinvoke>
					#getPaymentType.Display#
				</cfif>
			</td>
		<cfelse>
			<input type="hidden" name="CCName" value="#getOrder.CCname#"> <!--- SET Form.CCName TO BLANK FOR DATABASE UPDATE --->
			<td colspan="2" rowspan="3" align="center" valign="middle">
				<cfscript>
					if ( FormOfPayment EQ 2 )
						WriteOutput('<img src="images/Logos/logo-PayPal.gif" align="absmiddle"> <b>PayPal</b>');
					else if ( FormOfPayment EQ 3 )
						WriteOutput('<img src="images/Logos/logo-ECheck.gif" align="absmiddle"> <b>eCheck</b>');
					else if ( FormOfPayment EQ 4 )
						WriteOutput('<img src="images/Logos/logo-OrderForm.gif" align="absmiddle"> <b>Order Form / Invoice</b>');
				</cfscript>
			</td>
		</cfif>
	</tr>
	<tr>
		<td>Last Name:</td>
		<td>#LastName#</td>
		<td>Last Name:</td>
		<td><cfinput type="text" name="OShipLastName" value="#OShipLastName#" size="30" class="cfAdminDefault" required="yes"></td>
		<cfif FormOfPayment EQ 1 >
			<td>Card Number:</td>
			<td>
				<cfif isUserInRole('Administrator')>
					<cfinput type="text" name="CCnum" value="#decrypted_CCnum#" size="30" class="cfAdminDefault" required="no"
						message="Please enter a valid credit card number">
				<cfelse>
					XXXXXXXXXXXX#Right(decrypted_CCnum,4)#
				</cfif>
			</td>
		<cfelse>
			<input type="hidden" name="CCnum" value="#decrypted_CCnum#"> <!--- SET Form.CCnum TO BLANK FOR DATABASE UPDATE --->
		</cfif>
	</tr>
	<tr>
		<td>Company Name:</td>
		<td>#CompanyName#</td>
		<td>Company Name:</td>
		<td><input type="text" name="OShipCompanyName" value="#OShipCompanyName#" size="30" class="cfAdminDefault"></td>
		<cfif FormOfPayment EQ 1 >
			<td>Exp. Date:</td>
			<td>
				<cfif isUserInRole('Administrator')>
					<cfinput type="text" name="CCexpdate" value="#decrypted_CCexpdate#" size="10" maxlength="5" class="cfAdminDefault" required="no"
						message="Please enter a valid expiration date in mm/yy format">&nbsp;&nbsp;
						<!--- validate="regular_expression" pattern="^((0[1-9])|(1[0-2]))\/(\d{2})$" --->
					CVV ##:
					<cfinput type="text" name="CCCVV" value="#getOrder.CCCVV#" size="5" class="cfAdminDefault" maxlength="4"
						required="no" message="Please enter a valid 3 or 4 digit CVV number">
				<cfelse>
					#decrypted_CCexpdate# &nbsp;&nbsp;&nbsp; CVV ##: XXXX
				</cfif>
			</td>
		<cfelse>
			<input type="hidden" name="CCexpdate" value="#decrypted_CCexpdate#"> <!--- SET Form.CCexpdate TO BLANK FOR DATABASE UPDATE --->
			<input type="hidden" name="CCCVV" value="#getOrder.CCCVV#"> <!--- SET Form.CCCVV TO BLANK FOR DATABASE UPDATE --->
		</cfif>
	</tr>
	<tr>
		<td>Address 1:</td>
		<td>#Address1#</td>
		<td>Address 1:</td>
		<td><cfinput type="text" name="OShipAddress1" value="#OShipAddress1#" size="30" class="cfAdminDefault" required="yes"></td>
		<td>Payment Processed:</td>
		<td valign="middle">
			<cfif PaymentVerified EQ 1><input type="checkbox" name="PaymentVerified" checked>
			<cfelse><input type="checkbox" name="PaymentVerified">
			</cfif>
			<cfif isDefined('TransactionID') AND TransactionID NEQ ''>Trans ID: #TransactionID#</cfif>
		</td>
	</tr>
	<tr>
		<td>Address 2:</td>
		<td>#Address2#</td>
		<td>Address 2:</td>
		<td><input type="text" name="OShipAddress2" value="#OShipAddress2#" size="30" class="cfAdminDefault"></td>
		<td>Form of Payment:</td>
		<td valign="top">
			<input type="radio" name="FormOfPayment" value="1" <cfif application.AllowCreditCards NEQ 1> disabled </cfif><cfif getOrder.FormofPayment EQ 1> checked </cfif> ><img src="images/logos/logo-CreditCards.gif">
			<input type="radio" name="FormOfPayment" value="2" <cfif application.AllowPayPal NEQ 1> disabled </cfif><cfif getOrder.FormofPayment EQ 2> checked </cfif> ><img src="images/logos/logo-ODPayPal.gif">
			<input type="radio" name="FormOfPayment" value="3" <cfif application.AllowECheck NEQ 1> disabled </cfif><cfif getOrder.FormofPayment EQ 3> checked </cfif> ><img src="images/logos/logo-ODECheck.gif">
			<input type="radio" name="FormOfPayment" value="4" <cfif application.AllowOrderForm NEQ 1> disabled </cfif><cfif getOrder.FormofPayment EQ 4> checked </cfif> ><img src="images/logos/logo-ODOrderForm.gif">
		</td>
	</tr>
	<tr>	
		<td>City:</td>
		<td>#City#</td>
		<td>City:</td>
		<td><cfinput type="text" name="OShipCity" value="#OShipCity#" size="30" class="cfAdminDefault" required="yes"></td>
		<td class="cfAdminHeader1" style="background-color:##65ADF1;" colspan="2">&nbsp;&nbsp;&nbsp; STATUS INFORMATION</td>
	</tr>
	<tr>	
		<td>State:</td>
		<td>#State#</td>
		<td>State:</td>
		<td><cfselect query="getStates" name="OShipState" value="StateCode" display="State" selected="#OShipState#" size="1" class="cfAdminDefault" /></td>
		<td>Order Status:</td>
		<td><cfselect name="OrderStatus" query="getOrderStatusCodes" size="1" 
				value="StatusCode" display="StatusMessage" selected="#OrderStatus#" class="cfAdminDefault" />
		</td>
	</tr>
	<tr>	
		<td>Zip/Postal:</td>
		<td>#Zip#</td>
		<td>Zip/Postal:</td>
		<td><cfinput type="text" name="OShipZip" value="#OShipZip#" size="30" class="cfAdminDefault" required="yes"></td>
		<td>Ship Date:</td>
		<td>
			<cfinput type="text" validate="date" name="ShipDate" value="#DateFormat(ShipDate, "mm/dd/yy")#" size="10" class="cfAdminDefault">
		</td>
	</tr>
	<tr>	
		<td>Country:</td>
		<td>#Country#</td>
		<td>Country:</td>
		<td><cfselect query="getCountries" name="OShipCountry" value="CountryCode" display="Country" selected="#OShipCountry#" size="1" class="cfAdminDefault" /></td>
		<td>Billing Status:</td>
		<td><cfselect name="BillingStatus" query="getBillingStatusCodes" size="1" 
				value="StatusCode" display="StatusMessage" selected="#BillingStatus#" class="cfAdminDefault" />
		</td>
	</tr>
	<tr>	
		<td>Phone:</td>
		<td>#CustomerPhone#</td>
		<td>Phone:</td>
		<td><cfinput type="text" name="Phone" value="#OrderPhone#" size="30" class="cfAdminDefault" required="yes"></td>
		<td></td>
		<td></td>
	</tr>
	<tr>	
		<td></td>
		<td></td>
		<td>Shipping Method:</td>
		<td><cfselect query="getShippingMethods" name="ShippingMethod" value="ShippingCode" display="ShippingMessage" selected="#ShippingMethod#" size="1" class="cfAdminDefault" /></td>
		<td rowspan="2">Affiliate ID:</td>
		<td rowspan="2">
			<cfif AffiliateID EQ ''>
				No Affiliate ID Used
			<cfelse>
				<a href="AffiliateDetail.cfm?AFID=#AffiliateID#">#AffiliateID#</a>
			</cfif>
		<!--- WHY WOULD YOU WANT TO CHANGE THE AFFILIATE ID ??? --->
			<cfif IsUserInRole('Administrator')>
				<br>
				<cfselect query="getAffiliatesDDL" name="AffiliateID" value="AFID" display="AffiliateName" selected="#AffiliateID#" size="1" class="cfAdminDefault">
					<option value="" <cfif AffiliateID EQ ''>selected</cfif>>--- Apply Affiliate ---</option>
				</cfselect>
			</cfif>
		
		</td>
	</tr>
	<tr>
		<td></td>	
		<td></td>
		<td>Tracking ##:</td>
		<td>
			<cfinput type="text" name="TrackingNumber" value="#TrackingNumber#" size="30" class="cfAdminDefault">
			<cfif TrackingNumber NEQ ''>
				<cfif #Left(TrackingNumber,2)# EQ '1Z' >
					<a href="Shipping/indexUPS.cfm?function=trackRequest&trackingNum=#TrackingNumber#&trackDetail=Activity">
						<img src="images/button-trackups.gif" border="0">
					</a>					
				<cfelseif Len(TrackingNumber) EQ 12 > 
					<a target="_blank" href="http://www.federalexpress.com/cgi-bin/tracking?tracknumbers=#TrackingNumber#&action=track&language=english&cntry_code=us&mps=y&ascend_header=1">
						<img src="images/button-trackfedex.gif" border="0">
					</a>
				<cfelse>
					<a href="Shipping/indexUSPS.cfm?function=trackRequest&trackingNum=#TrackingNumber#">
						<img src="images/button-trackusps.gif" border="0">
					</a>
				</cfif>
			</cfif>
		</td>
	</tr>
	<tr>
		<td height="20" colspan="8"></td>
	</tr>
	<tr style="background-color:##65ADF1;">
		<td colspan="2" height="20" class="cfAdminHeader1">&nbsp;&nbsp;&nbsp; CUSTOMER COMMENTS</td>
		<td colspan="2" class="cfAdminHeader1">&nbsp;&nbsp;&nbsp; STORE COMMENTS</td>
		<td colspan="2" class="cfAdminHeader1">&nbsp;&nbsp;&nbsp; AUDIT TRAIL</td>
	</tr>
	<tr>	
		<td colspan="2" rowspan="2">
			<textarea name="CustomerComments" rows="4" cols="45" class="cfAdminDefault">#CustomerComments#</textarea></td>	
		<td colspan="2" rowspan="2">
			<textarea name="Comments" rows="4" cols="45" class="cfAdminDefault">#OrderComments#</textarea></td>
		<td>Last Updated:</td>
		<td height="22">#DateFormat(OrderUpdated, "d-mmm-yyyy")# #TimeFormat(OrderUpdated, "@ hh:mm tt")#</td>
	</tr>
	<tr>
		<td>Last Updated By:</td>
		<td height="22">#OrderUpdatedBy#</td>
	</tr>
	<tr>
		<td height="20" colspan="8"></td>
	</tr>
	<tr style="background-color:##F27028;">
		<td colspan="8" height="20" class="cfAdminHeader3" align="center">
			UPDATE ABOVE INFORMATION
		</td>
	</tr>
	<tr>
		<td height="20" colspan="8"></td>
	</tr>
	<tr>
		<td colspan="8" align="center">
			<input type="submit" name="UpdateOrderInfo" value="UPDATE CHANGES" alt="Update Changes" class="cfAdminButton">
		</td>
	</tr>

	<cfif isDefined('CustDetailComments') AND CustDetailComments NEQ ''>
	<tr>
		<td class="cfAdminHeader1" style="background-color:##65ADF1;" colspan="8" height="20">NOTES ON CUSTOMER</td>
	</tr>
	<tr class="cfAdminError" style="PADDING: 4px">	
		<td colspan="8">#CustDetailComments#</td>	
	</tr>
	</cfif>
</table>
<input type="hidden" name="OrderID" value="#OrderID#">	
</cfoutput>
</cfform>

<!----------------------------------------------------------------- ORDERED ITEMS ----------------------------------------------------------------->

<cfoutput>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td class="cfAdminTitle">ORDERED ITEMS</td>
		<!--- ADD ITEMS --->
		<td align="right">
			<input type="button" name="AddItems" value="ADD ITEMS" alt="Click here to add items to this order" class="cfAdminButton"
				onclick="NewWindow('OrderItemAdd.cfm?OrderID=#OrderID#&CustomerID=#getOrder.CustomerID#','ADDITEMS','760','333','yes');">
		</td>
	</tr>
	<tr style="background-color:##CCCCCC;"><td height="1" colspan="2"></td></tr>
	<tr><td height="1" colspan="2"></td></tr>
	<tr style="background-color:##CCCCCC;"><td height="1" colspan="2"></td></tr>
</table>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr class="cfAdminHeader2" style="background-color:##7DBF0E;">		
		<td width="1%"  class="cfAdminHeader2" align="center"></td>
		<td width="9%"  class="cfAdminHeader2" nowrap height="20">SKU</td>
		<td width="25%" class="cfAdminHeader2" nowrap>Item Name/Description</td>
		<td width="5%"  class="cfAdminHeader2" nowrap>Qty</td>
		<td width="8%"  class="cfAdminHeader2" nowrap>Unit Price</td>
		<td width="20%" class="cfAdminHeader2" nowrap>Item Status</td>
		<td width="12%" class="cfAdminHeader2" nowrap>Tracking ##</td>
		<td width="10%" class="cfAdminHeader2" nowrap>Action Date</td>
		<td width="10%" class="cfAdminHeader2" nowrap align="right">Total&nbsp;</td>
	</tr>
</cfoutput>

<cfset RunningTotal = 0>
	
<cfoutput query="getOrderItems">
	<cfform action="OrderDetail.cfm" method="post">
		<input type="hidden" name="OrderItemsID" value="#OrderItemsID#">
		<input type="hidden" name="ItemID" value="#ItemID#">
	<tr>
		<td>
			<input type="submit" name="DeleteOrderItem" value="X" alt="Delete item from order" class="cfAdminButton"
				onclick="return confirm('For record-keeping purposes, it is encouraged that you set unwanted items to ~Canceled~.  Are you sure you want to DELETE ITEM #SKU# ?')">&nbsp;
		</td>
		<td><a href="ProductDetail.cfm?ItemID=#ItemID#" class="cfAdminDefault">#SKU#</a>&nbsp;</td>
		<td><a href="ProductDetail.cfm?ItemID=#ItemID#" class="cfAdminDefault">#ItemName#</a>
			
			<!--- CUSTOM FILE ONLY ---
			<cfinclude template="CustomFiles/OrderDetail.cfm">
			--->
			<!--- CARTFUSION DEFAULT --->
			<!-------------- BEGIN: ITEM OPTIONS --------------->
			<cfif OptionName1 NEQ '' OR OptionName2 NEQ '' OR OptionName3 NEQ '' >			
				<cfif isDefined('OptionName1') AND OptionName1 NEQ ''>
					:<br><b>#OptionName1#</b>
				</cfif>
				<cfif isDefined('OptionName2') AND OptionName2 NEQ ''>
					<b>; #OptionName2#</b>
				</cfif>
				<cfif isDefined('OptionName3') AND OptionName3 NEQ ''>
					<b>; #OptionName3#</b>
				</cfif>			
			</cfif>	
			<!-------------- END: ITEM OPTIONS --------------->
			
			<!--- CARTFUSION ALTERNATE ---
			<!-------------- BEGIN: ITEM OPTIONS --------------->
			<cfif OptionName1 NEQ '' OR OptionName2 NEQ '' OR OptionName3 NEQ '' >
				<cfinvoke component="#application.Queries#" method="getProductOptions1" returnvariable="getProductOptions1">
					<cfinvokeargument name="ItemID" value="#ItemID#">
				</cfinvoke>
				<cfinvoke component="#application.Queries#" method="getProductOptions2" returnvariable="getProductOptions2">
					<cfinvokeargument name="ItemID" value="#ItemID#">
				</cfinvoke>
				<cfinvoke component="#application.Queries#" method="getProductOptions3" returnvariable="getProductOptions3">
					<cfinvokeargument name="ItemID" value="#ItemID#">
				</cfinvoke>
			
				<cfif isDefined('OptionName1') AND OptionName1 NEQ ''>
					<b>:</b><br>
					<cfselect name="OptionName1" query="getProductOptions1" size="1" class="cfAdminDefault" onChange="updateInfo(#OrderItemsID#,this.value,'OptionName1','OrderItems');"
						value="OptionName" display="OptionName" selected="#OptionName1#" />
				</cfif>
				<cfif isDefined('OptionName2') AND OptionName2 NEQ ''>
					<cfselect name="OptionName2" query="getProductOptions2" size="1" class="cfAdminDefault" onChange="updateInfo(#OrderItemsID#,this.value,'OptionName2','OrderItems');"
						value="OptionName" display="OptionName" selected="#OptionName2#" />
				</cfif>
				<cfif isDefined('OptionName3') AND OptionName3 NEQ ''>
					<cfselect name="OptionName3" query="getProductOptions3" size="1" class="cfAdminDefault" onChange="updateInfo(#OrderItemsID#,this.value,'OptionName3','OrderItems');"
						value="OptionName" display="OptionName" selected="#OptionName3#" />
				</cfif>
			
			</cfif>	
			<!-------------- END: ITEM OPTIONS --------------->
			--->
			
		</td>
		<td nowrap>
			<a name="Anc"></a>
			<cfinput type="text" validate="integer" name="Qty" value="#Qty#" size="2" class="cfAdminDefault" 
				onchange="updateInfo(#OrderItemsID#,this.value,'Qty','OrderItems');">&nbsp;
		</td>
		<td nowrap>
			$<cfinput type="text" validate="float" name="ItemPrice" value="#DecimalFormat(ItemPrice)#" size="7" class="cfAdminDefault" 
				onchange="updateInfo(#OrderItemsID#,this.value,'ItemPrice','OrderItems');">&nbsp;
		</td>			
			<cfscript>
				if (StatusCode IS 'BO' OR StatusCode IS 'CA' OR StatusCode IS 'BP' OR StatusCode IS 'RE')
					ExtPrice = 0;
					// RunningTotal = RunningTotal;
				else
				{
					ExtPrice = Val(ItemPrice * Qty);
					RunningTotal = RunningTotal + Val(ItemPrice * Qty);
				}
			</cfscript>
		<td nowrap>
			<cfselect name="StatusCode" query="getOrderItemsStatusCodes" size="1" onChange="updateInfo(#OrderItemsID#,this.value,'StatusCode','OrderItems');"
				value="StatusCode" display="StatusMessage" selected="#StatusCode#" class="cfAdminDefault" />&nbsp;</td>
		<td nowrap>
			<cfinput type="text" name="OITrackingNumber" value="#OITrackingNumber#" size="20" class="cfAdminDefault" 
				onchange="updateInfo(#OrderItemsID#,this.value,'OITrackingNumber','OrderItems');">&nbsp;</td>
		<td nowrap>
			<cfinput type="text" name="OrderItemDate" required="no" validate="date" message="Please enter a date in mm/dd/yyyy format" 
				value="#DateFormat(OrderItemDate, "mm/dd/yy")#" size="8" class="cfAdminDefault" onchange="updateInfo(#OrderItemsID#,this.value,'DateEntered','OrderItems');">&nbsp;</td>
		<td align="right">#LSCurrencyFormat(ExtPrice, "local")#</td>
		<!---
		<td align="center">&nbsp;
			<input type="image" src="images/updatebutton.gif" name="UpdateItemChange" value="UpdateItemChange" border="0" alt="Update Changes">
		</td>
		--->
	</tr>
	<input type="hidden" name="OrderID" value="#OrderID#">
	</cfform>
	<!--- DIVIDER --->
	<tr style="background-color:##CCCCCC;">
		<td height="1" colspan="9"></td>
	</tr>
</cfoutput>


<!--- TOTALS ---------------------------------------------------------------------->
<cfoutput query="getOrder">
<cfform action="OrderDetail.cfm" method="post" name="Totals">
	<tr>
		<td align="right" colspan="8" height="20">SubTotal: </td>
		<td align="right" nowrap>#LSCurrencyFormat(RunningTotal, "local")#</td>
		<td align="center"></td>
	</tr>
	<tr>
		<td align="right" colspan="8">Discount:</td>
		<td align="right" nowrap>$
			<cfinput type="text" name="DiscountTotal" value="#DecimalFormat(DiscountTotal)#" validate="float" size="5" class="cfAdminDefault" align="right"
				onchange="updateInfo(#OrderID#,this.value,'DiscountTotal','Orders');">
		</td>
	</tr>
	<cfset RunningTotal = RunningTotal - DiscountTotal >
	<tr>
		<td align="right" colspan="8">Credit (Available: #LSCurrencyFormat(getOrder.Credit)#):</td>
		<td align="right" nowrap>$
			<cfinput type="text" name="CreditApplied" value="#DecimalFormat(CreditApplied)#" validate="float" size="5" class="cfAdminDefault" align="right"
				onchange="updateInfo(#OrderID#,this.value,'CreditApplied','Orders');">
		</td>
	</tr>
	<cfset RunningTotal = RunningTotal - CreditApplied >
	<tr>
		<td align="right" colspan="8">
			<script language="javascript">
				var TaxCalculated = 0
				function CalculateTax(amount,tax)
				{
					TaxCalculated = amount * (tax/100) ;
					document.Totals.TaxTotal.value = TaxCalculated ;
					updateInfo(#OrderID#,TaxCalculated,'TaxTotal','Orders');
				}
			</script>
			<cfif application.UseFlatTaxRate EQ 1 >
				<cfset TaxRateToUse = application.FlatTaxRate >
				#DecimalFormat(application.FlatTaxRate)#%
			<cfelse>
				<cfquery name="getTaxRate" datasource="#application.dsn#">
					SELECT	T_Rate
					FROM	States
					WHERE	StateCode = '#getOrder.OShipState#'
				</cfquery>
				<cfset TaxRateToUse = getTaxRate.T_Rate >
				#DecimalFormat(getTaxRate.T_Rate)#%
			</cfif>
			Tax <input type="button" name="CalcTax" value=">" alt="Calculate Tax" class="cfAdminButton"
					onclick="CalculateTax(#RunningTotal#,#TaxRateToUse#);">:
		</td>
		<td align="right" nowrap>$
			<cfinput type="text" name="TaxTotal" value="#DecimalFormat(TaxTotal)#" validate="float" size="5" class="cfAdminDefault" align="right"
				onchange="updateInfo(#OrderID#,this.value,'TaxTotal','Orders');">
		</td>
	</tr>
	<cfset RunningTotal = RunningTotal + TaxTotal >
	<tr>
		<td align="right" colspan="8">Shipping:</td>
		<td align="right" nowrap>$
			<cfinput type="text" name="ShippingTotal" value="#DecimalFormat(ShippingTotal)#" validate="float" size="5" class="cfAdminDefault" align="right"
				onchange="updateInfo(#OrderID#,this.value,'ShippingTotal','Orders');">
		</td>
	</tr>
	<cfset RunningTotal = RunningTotal + ShippingTotal >

	<input type="hidden" name="Credit" value="#Credit#"><!--- ONLY ONCE IN FORM --->
	<input type="hidden" name="OrderID" value="#OrderID#"><!--- ONLY ONCE IN FORM --->
</cfform>
	<tr>
		<td height="5" colspan="9" ></td>
	</tr>
	<tr class="cfAdminDefault" style="background-color:##7DBF0E;">
		<!--- REFRESH TOTAL --->
		<td align="right" colspan="7" height="20" class="cfAdminHeader4">
			<input type="button" value="REFRESH TOTAL >>" class="cfAdminButton" onclick="refreshPage('#CGI.SCRIPT_NAME#?OrderID=#OrderID#');">&nbsp;
		</td>
		<td align="right" valign="middle" class="cfAdminHeader4"><b>Total:</b></td>
		<td align="right" valign="middle" class="cfAdminHeader4"><b>#LSCurrencyFormat(RunningTotal, "local")#</b>&nbsp;</td>
	</tr>
</table>
</cfoutput>

<br><br>

<!--- OPTIONS ---------------------------------------------------------------------------->
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr><td class="cfAdminTitle">OPTIONS</td></tr>
	<tr style="background-color:#CCCCCC;"><td height="1" colspan="8"></td></tr>
	<tr><td height="1" colspan="8"></td></tr>
	<tr style="background-color:#CCCCCC;"><td height="1" colspan="8"></td></tr>	
</table>
<br>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		
		<cfoutput query="getOrder" group="OrderID">
		
			<!--- PROCESS PAYMENT BUTTON --->
			<cfif FormOfPayment EQ 1 >
				
				<!--- MANUAL ORDER HANDLING --->
				<cfif application.PaymentSystem EQ 1 AND getOrder.PaymentVerified NEQ 1 >
					<!--- DO NOTHING --->
				
				<!--- AUTHORIZE.NET --->
				<cfelseif application.PaymentSystem EQ 2 >
					<cfinclude template="Includes/PG-AuthorizeNet.cfm">
				
				<!--- USAePay --->
				<cfelseif application.PaymentSystem EQ 3 AND getOrder.PaymentVerified NEQ 1 >
					<cfinclude template="Includes/PG-USAePay.cfm">
					
				<!--- PAYFLOW LINK --->
				<cfelseif application.PaymentSystem EQ 4 AND getOrder.PaymentVerified NEQ 1 >
					<cfinclude template="Includes/PG-PayFlowLink.cfm">
				
				<!--- WORLDPAY --->
				<cfelseif application.PaymentSystem EQ 6 AND getOrder.PaymentVerified NEQ 1 >
					<cfinclude template="Includes/PG-WorldPay.cfm">
					
				<!--- YOURPAY API --->
				<cfelseif application.PaymentSystem EQ 7 >
					<cfinclude template="Includes/PG-YourPayAPI.cfm">

				</cfif>
			</cfif>
			
			<cfform method="post" action="OrderEmail.cfm?OrderID=#OrderID#">
			<td>
				<img src="images/spacer.gif" border="0" width="1" height="1">
				<input type="button" name="PrintInvoice" value="PRINT INVOICE" alt="Print Invoice" class="cfAdminButton"
					onclick="NewWindow('OrderPrint.cfm?OrderID=#OrderID#','INVOICE','760','600','yes');">
				<input type="submit" name="EmailInvoice" value="EMAIL INVOICE TO:" alt="Email Invoice" class="cfAdminButton">
				<cfinput type="text" class="cfAdminDefault" name="EmailInvoiceTo" value="#Email#" required="yes" size="30">
				<input type="hidden" name="OrderID" value="#OrderID#">
				<input type="hidden" name="FromBackEnd" value="1">
			</td>	
			</cfform>
		</cfoutput>
	</tr>
</table><br><br>

<!--- BACK ORDERS -------------------------------------------------------------->

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr><td class="cfAdminTitle">BACK ORDERS PROCESSED</td></tr>
	<tr style="background-color:##CCCCCC;"><td height="1" colspan="8"></td></tr>
	<tr><td height="1" colspan="8"></td></tr>
	<tr style="background-color:##CCCCCC;"><td height="1" colspan="8"></td></tr>	
</table>
<cfif getBackOrders.RecordCount EQ 0>
	<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr>
			<td colspan="9" class="cfAdminDefault"><br>No Back Orders have been processed for this order.</td>
		</tr>
	</table>
	<br>

<cfelse>
	<br>
	<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<cfoutput query="getBackOrders" group="BOID">
		<tr style="background-color:##CCCCCC;">
			<td height="1" colspan="9"></td>
		</tr>
		<tr style="background-color:##65ADF1;">
			<td width="25%" colspan="2" height="20" class="cfAdminHeader1">
				&nbsp; DATE: <b>#DateFormat(BODateEntered)#</b>
			</td>
			<td width="40%" colspan="4" class="cfAdminHeader1">
				Transaction ID: <b>#BOTransID#</b>
			</td>
			<td width="35%" colspan="3" align="right" class="cfAdminHeader1"></td>
		</tr>
		<tr style="background-color:##CCCCCC;"><td height="1" colspan="9"></td></tr>	
		<tr>
			<td width="1%" align="center"></td>
			<td width="9%"  class="cfAdminDefault" height="20"><b>SKU</b></td>
			<td width="25%" class="cfAdminDefault"><b>Item Name/Description</b></td>
			<td width="5%"  class="cfAdminDefault"><b>Qty</b></td>
			<td width="8%"  class="cfAdminDefault"><b>Unit Price</b></td>
			<td width="20%" class="cfAdminDefault"></td>
			<td width="12%" class="cfAdminDefault"></td>
			<td width="20%"	class="cfAdminDefault" align="right" colspan="2"><b>Ext Price</b></td>
		</tr>
		<tr style="background-color:##CCCCCC;"><td height="1" colspan="9"></td></tr>
		<cfinvoke component="#application.Queries#" method="getBackOrderItems" returnvariable="getBackOrderItems">
			<cfinvokeargument name="BOID" value="#BOID#">
		</cfinvoke>
	
		<cfloop query="getBackOrderItems">
			<cfinvoke component="#application.Queries#" method="getItemNames" returnvariable="getItemNames">
				<cfinvokeargument name="ItemID" value="#BOItemID#">
			</cfinvoke>
			<tr class="cfDefault">
				<td height="20">&nbsp;</td>
				<td><a href="ProductDetail.cfm?ItemID=#BOItemID#" class="cfMessageThree">#getItemNames.SKU#</a></td>
				<td><a href="ProductDetail.cfm?ItemID=#BOItemID#" class="cfMessageThree">#getItemNames.ItemName#</a></td>
				<td>#BOQty#</td>
				<td>#LSCurrencyFormat(BOItemPrice)#</td>
				<td></td>
				<td></td>
				<td align="right">#LSCurrencyFormat(Val(BOQty * BOItemPrice))#</td>
				<td></td>
			</tr>
			<!--- DIVIDER --->
			<tr style="background-color:##CCCCCC;">
				<td height="1" colspan="9"></td>
			</tr>
		</cfloop>
		
		<cfif BODiscount NEQ '' AND BODiscount NEQ 0>
		<tr>
			<td width="100%" colspan="9" align="right" height="20">
				Discount: <b>#LSCurrencyFormat(BODiscount)#</b>
			</td>
		</tr>
		</cfif>
		<cfif BOCredit NEQ '' AND BOCredit NEQ 0>
		<tr>
			<td width="100%" colspan="9" align="right" height="20">
				Credit Applied: <b>#LSCurrencyFormat(BOCredit)#</b>
			</td>
		</tr>
		</cfif>
		<!--- DIVIDER --->
		<tr style="background-color:##CCCCCC;"><td height="1" colspan="9"></td></tr>
		
		<tr class="cfAdminDefault" style="background-color:##65ADF1;">
			<td width="100%" colspan="9" align="right" height="20" class="cfAdminHeader4">
				Total: <b>#LSCurrencyFormat(BOTotal)#</b>
			</td>
		</tr>
		
		<!--- DIVIDER --->
		<tr style="background-color:##CCCCCC;"><td height="1" colspan="9"></td></tr>
		<!--- SPACE BETWEEN BACK ORDERS PROCESSED --->
		<tr><td height="20" colspan="9">&nbsp;</td></tr>	
		</cfoutput>
	</table>
</cfif>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td>
			<input type="button" name="ProcessBOs" value="PROCESS BACK ORDERS" alt="Process back orders for this order" class="cfAdminButton"
				onclick="document.location.href='BackOrders.cfm?field=AllFields&string=<cfoutput>#getOrder.CustomerID#</cfoutput>'">
			<input type="button" name="ViewAllBOs" value="VIEW ALL BACK ORDERS" alt="View all back orders for all orders" class="cfAdminButton"
				onclick="document.location.href='BackOrders.cfm'">
		</td>
	</tr>
</table>
<br/><br/>





<!--- RETURN AUTHORIZATIONS -------------------------------------------------------------->

<table border="0" cellpadding="0" cellspacing="0" width="700">
	<tr><td class="cfAdminTitle">RETURN AUTHORIZATIONS (RMAs)</td></tr>
	<tr style="background-color:##CCCCCC;"><td height="1" colspan="8"></td></tr>
	<tr><td height="1" colspan="8"></td></tr>
	<tr style="background-color:##CCCCCC;"><td height="1" colspan="8"></td></tr>	
</table>
<table border="0" cellpadding="0" cellspacing="0" width="700">
	<tr>
		<td height="25">
			<input type="button" name="ProcessReturn" value="PROCESS A RETURN" alt="Process return authorization for this order" class="cfAdminButton"
				onclick="document.location.href='OrderReturnDetail.cfm?OrderID=<cfoutput>#getOrder.OrderID#</cfoutput>'">
			<input type="button" name="ViewAllReturns" value="VIEW ALL RETURNS" alt="View all Return Authorizations for all orders" class="cfAdminButton"
				onclick="document.location.href='OrderReturns.cfm'">
		</td>
	</tr>
</table>
<cfif getOrderReturns.RecordCount EQ 0>
	<table border="0" cellpadding="0" cellspacing="0" width="700">
		<tr>
			<td colspan="5" class="cfAdminDefault"><br>No Return Authorizations have been created or processed for this order.</td>
		</tr>
	</table>
	<br>
<cfelse>
	<table border="0" cellpadding="3" cellspacing="0" width="700">
		<cfoutput query="getOrderReturns" group="OrderReturnID">
		<cfset ReturnTotal = 0 >
		<tr>
			<td width="45%" colspan="2" height="20" class="cfAdminHeader1" nowrap="nowrap">
				RMA ##: <a href="OrderReturnDetail.cfm?OrderID=#OrderID#"><b><u>#RMA#</u></b></a>
			</td>
			<td width="35%" colspan="2" class="cfAdminHeader1" nowrap="nowrap">
				DATE: <b>#DateFormat(RMADate,"mm/dd/yyyy")#</b>
			</td>
			<td width="20%" colspan="1" align="right" class="cfAdminHeader1" nowrap="nowrap">
				STATUS: <b><cfif RMAComplete EQ 1 >Complete<cfelse>Incomplete</cfif></b>
			</td>
		</tr>
		<tr style="background-color:##CCCCCC;">
			<td height="1" colspan="5"></td>
		</tr>
		<tr>
			<td width="45%" colspan="2" height="20" nowrap="nowrap">
				CREATED BY: <b>#CreatedBy#</b> <img src="images/spacer.gif" width="30" height="1" /> RECEIVED TO: <b>#ReceivedTo#</b>
			</td>
			<td width="35%" colspan="2" nowrap="nowrap">
				CHARGE RETURN TO: <b>#ChargeReturnTo#</b>
			</td>
			<td width="20%" colspan="1" align="right" nowrap="nowrap">
				DATE RECEIVED: <cfif RMAComplete EQ 1 ><b>#DateFormat(DateReceived,"mm/dd/yyyy")#</b><cfelse><b>Not Received Yet</b></cfif>
			</td>
		</tr>
		<tr style="background-color:##CCCCCC;"><td height="1" colspan="5"></td></tr>	
		<tr style="background-color:##65ADF1;">
			<td width="10%" class="cfAdminHeader4" height="20"><b>SKU</b></td>
			<td width="35%" class="cfAdminHeader4"><b>Item Name/Description</b></td>
			<td width="15%" class="cfAdminHeader4" align="center"><b>Qty</b></td>
			<td width="20%" class="cfAdminHeader4" align="right"><b>Unit Price</b></td>
			<td width="20%"	class="cfAdminHeader4" align="right"><b>Ext Price</b></td>
		</tr>
		<tr style="background-color:##CCCCCC;"><td height="1" colspan="5"></td></tr>
		<cfquery name="getOrderReturnItems" datasource="#application.dsn#">
			SELECT	*
			FROM	OrderReturnItems
			WHERE	OrderReturnID = #getOrderReturns.OrderReturnID#
		</cfquery>
		
		<cfloop query="getOrderReturnItems">
			<cfinvoke component="#application.Queries#" method="getItemNames" returnvariable="getItemNames">
				<cfinvokeargument name="ItemID" value="#OrderReturnItemID#">
			</cfinvoke>
			<cfquery name="getItemPrice" datasource="#application.dsn#">
				SELECT	ItemPrice
				FROM	OrderItems
				WHERE	OrderID = #getOrderReturns.OrderID#
				AND		ItemID = #getOrderReturnItems.OrderReturnItemID#
			</cfquery>
			<tr class="cfDefault">
				<td height="20"><a href="ProductDetail.cfm?ItemID=#OrderReturnItemID#" class="cfMessageThree">#getItemNames.SKU#</a></td>
				<td><a href="ProductDetail.cfm?ItemID=#OrderReturnItemID#" class="cfMessageThree">#getItemNames.ItemName#</a></td>
				<td align="center">#QtyReturned#</td>
				<td align="right">$#NumberFormat(getItemPrice.ItemPrice,0.00)#</td>
				<td align="right">#NumberFormat(NumberFormat(QtyReturned,0.00) * NumberFormat(getItemPrice.ItemPrice,0.00),0.00)#</td>
				<cfset ReturnTotal = ReturnTotal + NumberFormat(NumberFormat(QtyReturned,0.00) * NumberFormat(getItemPrice.ItemPrice,0.00),0.00) >
			</tr>
			<!--- DIVIDER --->
			<tr style="background-color:##CCCCCC;">
				<td height="1" colspan="5"></td>
			</tr>
		</cfloop>
		
		<cfif TaxReturned NEQ '' AND TaxReturned NEQ 0 >
		<tr>
			<td width="100%" colspan="5" align="right" height="20">
				Tax Returned: &nbsp; #LSCurrencyFormat(TaxReturned)#
				<cfset ReturnTotal = ReturnTotal + TaxReturned >
			</td>
		</tr>
		</cfif>
		<cfif ShippingReturned NEQ '' AND ShippingReturned NEQ 0 >
		<tr>
			<td width="100%" colspan="5" align="right" height="20">
				Shipping Returned: &nbsp; #LSCurrencyFormat(ShippingReturned)#
				<cfset ReturnTotal = ReturnTotal + ShippingReturned >
			</td>
		</tr>
		</cfif>
		<!--- DIVIDER --->
		<tr style="background-color:##CCCCCC;"><td height="1" colspan="5"></td></tr>
		
		<tr class="cfAdminDefault" style="background-color:##65ADF1;">
			<td width="100%" colspan="5" align="right" height="20" class="cfAdminHeader4">
				Return Total: &nbsp; <b>#LSCurrencyFormat(ReturnTotal)#</b>
			</td>
		</tr>
		
		<!--- DIVIDER --->
		<tr style="background-color:##CCCCCC;"><td height="1" colspan="5"></td></tr>
		<!--- SPACE BETWEEN BACK ORDERS PROCESSED --->
		<tr><td height="20" colspan="5">&nbsp;</td></tr>	
		</cfoutput>
	</table>
</cfif>
	

<br><br><br>
<cfinclude template="LayoutAdminFooter.cfm">