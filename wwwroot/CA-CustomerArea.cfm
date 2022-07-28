<cfif session.CustomerArray[26] EQ ''>
	<cflocation url="index.cfm" addtoken="no"><cfabort>
</cfif>


<!--- Update SHID --->
<cfif structKeyExists(form, 'UpdateSHID') AND structKeyExists(form, 'SHID')>
	<cftry>
		<cfupdate datasource="#application.dsn#" tablename="CustomerSH" 
			formfields="SHID, ShipNickName, ShipFirstName, ShipLastName, ShipAddress1, ShipAddress2, ShipCity, 
						ShipState, ShipZip, ShipCountry, ShipPhone, ShipCompanyName, ShipEmail">
			<cfset ErrorMsg = 'Shipping Address was updated successfully.'>
			<cfset Show5 = true >
		<cfcatch>
			<cfset ErrorMsg = 'ERROR: Your shipping address has NOT been updated.'>
			<cfset Show5 = true >
		</cfcatch>
	</cftry>
</cfif>

<!--- Delete SHID --->
<!--- <cfif structKeyExists(form, 'DeleteSHID') AND structKeyExists(form, 'SHID')> --->
	<!--- <cftry> --->
		<cfscript>
			// Delete SHID
			if( structKeyExists(form, 'DeleteSHID') AND structKeyExists(form, 'SHID'))	{
			
				try	{
					deleteCustomerShipping = application.Queries.deleteCustomerShipping(SHID=form.SHID);
					ErrorMsg = 'Shipping Address was deleted successfully.';
					Show5 = true;
				}
				catch(Any excpt)	{
					ErrorMsg = 'ERROR: Your shipping address has NOT been deleted.';
					Show5 = true;
				}
			}
		</cfscript>
		
		<!--- <cfcatch>
			<cfset ErrorMsg = 'ERROR: Your shipping address has NOT been deleted.'>
			<cfset Show5 = true >
		</cfcatch>
	</cftry> --->
<!--- </cfif> --->

<!--- Add SHID --->
<cfif structKeyExists(form, 'AddSHID')>
	<cftry>
		<cfinsert datasource="#application.dsn#" tablename="CustomerSH" 
			formfields="CustomerID, ShipNickName, ShipFirstName, ShipLastName, ShipAddress1, ShipAddress2, ShipCity, 
						ShipState, ShipZip, ShipCountry, ShipPhone, ShipCompanyName, ShipEmail">
			<cfset ErrorMsg = 'Shipping Address was added successfully.'>
			<cfset Show5 = true >
		<cfcatch>
			<cfset ErrorMsg = 'ERROR: Your shipping address has NOT been added.'>
			<cfset Show5 = true >
		</cfcatch>
	</cftry>
</cfif>

<cfoutput>

<cfmodule template="tags/layout.cfm" CurrentTab="MyAccount" PageTitle="Customer Area">

<!--- Start Breadcrumb --->
<cfmodule template="tags/breadCrumbs.cfm" CrumbLevel='1' showLinkCrumb="My Account" />
<!--- End BreadCrumb --->


<!--- BEGIN: QUERIES --->

<!--- Carl Vanderpal: Added queries for page instead of 
		calling then all thru the page, we now call them 
		from the top of the page 
--->

<cfscript>
	// Get Customer based on ID
	getCustomer = application.Queries.getCustomer(CustomerID=session.CustomerArray[17]);
	// Get Customer Orders
	getOrdersCA = application.Queries.getOrdersCA(CustomerID=session.CustomerArray[17]);
	// Standard Queries - Get States & Get Countries
	getStates = application.Queries.getStates();
	getCountries = application.Queries.getCountries();
	
	// Sets default for page	
	RunningWeight = 0;
	RunningTotal = 0;
	RunningNorm = 0;
	
	// Other Queries for the page
	//checkMessages
	
	if( application.siteConfig.data.EnableMultiShip EQ 1)	{
		getCustomerShipping = application.Queries.getCustomerShipping(CustomerID=session.CustomerArray[17]);
	}
	// Get Wish List
	getWishList = application.Common.getCustomerWishList(CustomerID=session.CustomerArray[17],SiteID=application.siteConfig.data.SiteID);
	// Get Messages
	checkMessages = application.Queries.checkMessages(Customers=session.CustomerArray[17]);
	
	
	
		
	// Get Store Credit
	getStoreCredit = application.Queries.getStoreCredit(CustomerID=session.CustomerArray[17]);
</cfscript>



<!--- FOR DOWNLOADABLE PRODUCTS 
<cfquery name="haveDownload" datasource="#application.dsn#">
	SELECT 	o.OrderID, o.DateEntered,
			oi.ItemID,
			p.ItemID, p.ItemName, p.DownloadLocation, p.DaysAvailable
	FROM	Orders o, Products p, OrderItems oi
	WHERE	o.CustomerID = '#session.CustomerArray[17]#'
	AND 	p.ItemID = oi.ItemID 
	AND 	p.SoftwareDownload = 1
	AND		p.SiteID = #config.SiteID#
	ORDER BY o.OrderID
</cfquery>
--->



<!--- DEFAULT MY ACCOUNT SECTIONS TO SHOW --->
<cfparam name="show1" default="0">
<cfparam name="show2" default="0">
<cfparam name="show3" default="0">
<cfparam name="show4" default="0">
<cfparam name="show5" default="0">


<script language="javascript">

	if (document.getElementById){ 
	document.write('<style type="text/css">\n')
	document.write('.submenu1{display: <cfif not show1 >none<cfelse>block</cfif>;}\n')
	document.write('</style>\n')
	document.write('<style type="text/css">\n')
	document.write('.submenu2{display: <cfif not show2 >none<cfelse>block</cfif>;}\n')
	document.write('</style>\n')
	document.write('<style type="text/css">\n')
	document.write('.submenu3{display: <cfif not show3 >none<cfelse>block</cfif>;}\n')
	document.write('</style>\n')
	document.write('<style type="text/css">\n')
	document.write('.submenu4{display: <cfif not show4 >none<cfelse>block</cfif>;}\n')
	document.write('</style>\n')
	<cfif application.siteConfig.data.EnableMultiShip EQ 1 >
	document.write('<style type="text/css">\n')
	document.write('.submenu5{display: <cfif not show5 >none<cfelse>block</cfif>;}\n')
	document.write('</style>\n')
	</cfif>
	}
	
	function SwitchMenu(obj){
		if(document.getElementById){
			var el = document.getElementById(obj);
			var ar = document.getElementById("MyAccount").getElementsByTagName("span"); 
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
					<cfif application.siteConfig.data.EnableMultiShip EQ 1 >
					if (ar[i].className=="submenu5") 
					ar[i].style.display = "none";
					</cfif>
				}
				el.style.display = "block";
			}else{
				el.style.display = "none";
			}
		}
	}
</script>

<div id="MyAccount">
<table cellpadding="0" cellspacing="0" border="0" width="100%">
	<tr valign="top">
		<td class="sub_pagehead"><span class="sub_pagetitle">Welcome, #getCustomer.FirstName# #getCustomer.LastName#!<br></span></td>
	</tr>
	<tr valign="top">
		<td class="cfDefault" align="center" valign="middle">[click <img src="images/icon-down.gif" align="absmiddle" /> to show/hide]<br><br></td>
	</tr>
</table>




<!--- Start of 'My Wishlist' --->
<div class="myaccount" align="left" onclick="SwitchMenu('sub1')">
	<img src="images/icon-down.gif" align="absmiddle" /> &nbsp;My Wishlist
</div>

<span class="submenu1" id="sub1" style="padding: 10px 0px 0px 0px;">
	
		
	<!--- GET WISHLIST --->
	<cfif not getWishList.RecordCount>
		<div class="cfMessageTwo" align="center">You do not have any items in your WishList.</div>
	
	<cfelse>
	<table class="cartLayoutTable">
		<tr>
			<th width="5%">&nbsp;</th>
			<th width="5%">&nbsp;</th>
			<th align="center" width="15%">SKU</th>
			<th width="45%">Description</th>
			<th align="center" width="10%">Quantity</th>
			<th align="center" width="10%">Price</th>
			<th align="center" width="10%">Total</th>
		</tr>
	
	<cfloop query="getWishList"><!--- <cfoutput query="getWishList"> --->
			
		<cfscript>
			// CARTFUSION 4.6 - CART CFC
			if ( trim(session.CustomerArray[28]) NEQ '' ) {
				UserID = session.CustomerArray[28] ;
			} else {
				UserID = 1 ;
			}
			UseThisPrice = application.Cart.getItemPrice(
				UserID=UserID,
				SiteID=application.siteConfig.data.SiteID,
				ItemID=ItemID,
				SessionID=SessionID,
				OptionName1=OptionName1,
				OptionName2=OptionName2,
				OptionName3=OptionName3);
		</cfscript>
			
		<cfinclude template="Includes/CartItemsCommon.cfm">
		
		<tr class="row#getWishList.CurrentRow mod 2#">
		 <form method="post" action="WishUpdate.cfm">
			<td align="center"> 
				<input class="button" type="submit" name="AddButton" value="Add To Cart"></td>	
			<td width="10%" align="center"> 
				<input class="button" type="submit" name="RemoveButton" value="Remove"></td>
			<td width="10%" class="cfDefault">#SKU#</td>
			<td width="35%" class="cfDefault"><a href="ProductDetail.cfm?ItemID=#ItemID#">#FinalDesc#</a></td>
			<td width="15%">
				<input type="text" name="quantity" size="2" value="#Qty#" onMouseDown="this.form.UpdateButton.focus();">&nbsp;
				<input class="button" type="submit" name="UpdateButton" value="Update"></td>
			<td width="10%" class="cfDefault" align="right">#LSCurrencyFormat(UseThisPrice, "local")#</td>
			<td width="10%" class="cfDefault" align="right">#LSCurrencyFormat(TotalPrice, "local")#</td>
				<input type="hidden" name="getWishListItemID" value="#WishListItemID#">		
				<input type="hidden" name="ItemID" value="#ItemID#">
				<cfif isDefined("OptionName1") AND OptionName1 NEQ ''><input type="hidden" name="OptionName1" value="#OptionName1#"></cfif>
				<cfif isDefined("OptionName2") AND OptionName2 NEQ ''><input type="hidden" name="OptionName2" value="#OptionName2#"></cfif>
				<cfif isDefined("OptionName3") AND OptionName3 NEQ ''><input type="hidden" name="OptionName3" value="#OptionName3#"></cfif>
		 </form>
		</tr>
	</cfloop><!--- </cfoutput> --->
	</table>
	
	<br>
	<div align="center">
		<a href="WishUpdate.cfm?CleanWish=Yes" onClick="return confirm('Are you sure you want to REMOVE ALL ITEMS from your WishList?')"><img src="images/button-empty.gif" border="0"></a>&nbsp;&nbsp;	
		<a href="WishToCart.cfm"><img src="images/button-placeall.gif" border="0"></a>
	</div>
	
	</cfif>
</span>
<!--- End of 'My Wishlist' --->

<br>


<!--- Start Sub 2 - My Account --->
<div class="myaccount" align="left" onclick="SwitchMenu('sub2')">
	<img src="images/icon-down.gif" align="absmiddle" /> &nbsp;My Orders
</div>

<span class="submenu2" id="sub2" style="padding: 10px 0px 0px 0px;">
	
	<cfif getStoreCredit.Credit>
		<div align="center">*** You have <u>$<cfoutput>#DecimalFormat(getStoreCredit.Credit)#</cfoutput></u> in available store credit. ***</div><br />
	</cfif>
	
	<cfif not getOrdersCA.RecordCount>
		<div align="center">You do not have any existing orders.</div>
	<cfelse>				
		<table class="cartLayoutTable">
			<tr>
				<th width="1%">&nbsp;</th>
				<th align="center" width="19%">Order&nbsp;ID</th>
				<th align="center" width="20%">Order&nbsp;Date</th>
				<th align="center" width="20%">Billing&nbsp;Status</th>
				<th align="center" width="20%">Order&nbsp;Status</th>
				<th align="center" width="20%">Ship&nbsp;Date</th>
			</tr>
			<cfloop query="getOrdersCA">
				
				<cfscript>
					// Get Billing Status Code
					getBillingStatus = application.Queries.getBillingStatusCode(StatusCode=getOrdersCA.BillingStatus);
					// Get Order Status Code
					getOrderStatus = application.Queries.getOrderStatusCode(StatusCode=getOrdersCA.OrderStatus);
				</cfscript>
				
				
			<tr class="row#getOrdersCA.CurrentRow mod 2#">
				<form action="CA-OrderDetail.cfm" method="post" target="_blank">
				<td width="1%">
					<input type="hidden" name="OrderID" value="#OrderID#">
					<input type="submit" name="View" value="View Order Detail" alt="View Order Detail" class="button">
				</td>
				</form>
				<td align="center" width="19%">#OrderID#</td>
				<td align="center" width="20%">#DateFormat(OrderDate,"dd-mmm-yyyy")#</td>
				<td align="center" width="20%">#getBillingStatus.StatusMessage#</td>
				<td align="center" width="20%">#getOrderStatus.StatusMessage#</td>
				<td align="center" width="20%">#DateFormat(ShipDate,"dd-mmm-yyyy")#</td>
			</tr>
			</cfloop>
		</table>				
	</cfif>
</span>
<!--- End Sub 2 - My Account --->
<br>

<!--- Start Sub 3 - My Profile --->
<div class="myaccount" align="left" onclick="SwitchMenu('sub3')">
	<img src="images/icon-down.gif" align="absmiddle" /> &nbsp;My Profile
</div>
<span class="submenu3" id="sub3" style="padding: 10px 0px 0px 0px;">
	<cfloop query="getCustomer">
	<table border="0" cellpadding="2" cellspacing="0" align="center" width="100%">
		<tr>
			<td width="100%" align="right" class="cfMessage" style="padding-right:10px;">
				<strong>Customer ID:</strong> #CustomerID# &nbsp; <strong>Customer Since: #DateFormat(DateCreated,"dd-mmm-yyyy")#</strong>
			</td>
		</tr>
		<tr>
			<td style="PADDING: 10px">
				<table border="0" cellpadding="2" cellspacing="0" align="center" width="100%">
					<tr>
						<td width="50%" colspan="2"><b>Billing Information</b></td>
						<td width="50%" colspan="2"><b>Shipping Information</b></td>
					</tr>
					<!--- <tr>
						<td colspan="4" height="5"></td>
					</tr> --->
					<tr>
						<td>First Name:</td>
						<td>#FirstName#</td>
						<td>First Name:</td>
						<td>#ShipFirstName#</td>
					</tr>
					<tr>
						<td>Last Name:</td>
						<td>#LastName#</td>
						<td>Last Name:</td>
						<td>#ShipLastName#</td>
					</tr>
					<tr>
						<td>Company Name:</td>
						<td>#CompanyName#</td>
						<td>Company Name:</td>
						<td>#ShipCompanyName#</td>
					</tr>
					<tr>
						<td>Address 1:</td>
						<td>#Address1#</td>
						<td>Address 1:</td>
						<td>#ShipAddress1#</td>
					</tr>
					<tr>
						<td>Address 2:</td>
						<td>#Address2#</td>
						<td>Address 2:</td>
						<td>#ShipAddress2#</td>
					</tr>
					<tr>	
						<td>City:</td>
						<td>#City#</td>
						<td>City:</td>
						<td>#ShipCity#</td>
					</tr>
					<tr>	
						<td>State:</td>
						<td>#State#</td>
						<td>State:</td>
						<td>#ShipState#</td>
					</tr>
					<tr>	
						<td>ZIP/Postal Code:</td>
						<td>#Zip#</td>
						<td>ZIP/Postal Code:</td>
						<td>#ShipZip#</td>
					</tr>
					<tr>	
						<td>Country:</td>
						<td>#Country#</td>
						<td>Country:</td>
						<td>#ShipCountry#</td>
					</tr>	
				</table>
			</td>
		</tr>			
		
		<tr>
			<td colspan="4" height="5"></td>
		</tr>
		
		<tr>	
			<td align="center" colspan="4" style="PADDING: 10px">
			<a href="CA-CustomerUpdate.cfm"><img src="images/button-update.gif" border="0"></a>
			</td>
		</tr>
	</table>
	</cfloop>
</span>
<!--- End Sub 3 - My Profile --->
<br>



<!--- Start Sub 5 - My Account --->
<cfif application.siteConfig.data.EnableMultiShip EQ 1 >
	<div class="myaccount" align="left" onclick="SwitchMenu('sub5')">
		<img src="images/icon-down.gif" align="absmiddle" /> &nbsp;My Shipping Addresses
	</div>
	<span class="submenu5" id="sub5" style="padding: 10px 0px 0px 0px;">
	
		<div class="cfMessageTwo" align="center">You may add shipping addresses below.</div>
			<!--- ADD ADDRESS --->
			<div align="center">
				<form action="CartEdit.cfm" method="post">
					<input type="submit" name="ViewCart" value="View Shopping Cart" class="button">
				</form>
				
				<hr class="snip" />
				
			</div>
	
	<cfif not getCustomerShipping.RecordCount>
		
		<div id="formContainer">
		
			<table width="100%" border="0" cellpadding="3" cellspacing="0">
				<tr>
					<td>
						<cfinclude template="tags/shippingForm.cfm">
					</td>
				</tr>
			</table>
		</div>
	<cfelse>
		<div id="formContainer">
			
			<cfif isDefined('ErrorMsg')>
				<br />
					<div class="cfErrorMsg" align="center">#ErrorMsg#</div>
				<br />
			</cfif>
			
			<cfloop query="getCustomerShipping">		
				<div class="loopForms">
					
					<cfform action="CA-CustomerArea.cfm" method="post">
						<div class="f-wrap-1">
											
							<fieldset>
								
								<h3>Shipping Information</h3>
								
								<label for="ShipNickName#CurrentRow#"><b><span class="req">*</span>###CurrentRow# Nickname:</b>
									<cfinput type="text" name="ShipNickName" value="#ShipNickName#" required="yes" message="A Nickname for the shipping address is required"><br />
								</label>
								
							</fieldset>
							
							<fieldset>
								
								<label for="ShippingFirstName#CurrentRow#"><b><span class="req">*</span>First Name:</b>
									<cfinput type="text" name="ShipFirstName" value="#ShipFirstName#" required="yes" message="First Name for shipping address is required">
								</label>
								
								<label for="ShippingLastName#CurrentRow#"><b><span class="req">*</span>Last Name:</b>
									<cfinput type="text" name="ShipLastName" value="#ShipLastName#" required="yes" message="Last Name for shipping address is required">
								</label>
								
								<label for="ShipEmail#CurrentRow#"><b>Email:</b>
									<cfinput type="text" name="ShipEmail" value="#ShipEmail#" required="no" validate="email" message="Please enter a valid email address for the shipping address">
								</label>
								
								<label for="ShipCompanyName#CurrentRow#"><b>Company Name:</b>
									<cfinput type="text" name="ShipCompanyName" value="#ShipCompanyName#" required="no">
								</label>
								
							</fieldset>
							
							<fieldset>
								
								<label for="ShipAddress1#CurrentRow#"><b><span class="req">*</span>Address 1:</b>
									<cfinput type="text" name="ShipAddress1" value="#ShipAddress1#" required="yes" message="Address Line 1 for shipping address is required">
								</label>
								
								<label for="ShipAddress2#CurrentRow#"><b>Address 2:</b>
									<cfinput type="text" name="ShipAddress2" value="#ShipAddress2#" required="no">
								</label>
								
								<label for="ShipCity#CurrentRow#"><b><span class="req">*</span>City:</b>
									<cfinput type="text" name="ShipCity" value="#ShipCity#" required="yes" message="City for shipping address is required">
								</label>
								
								<label for="ShipState#CurrentRow#"><b><span class="req">*</span>State/Prov:</b>
									<cfselect name="ShipState" size="1" query="GetStates" value="StateCode" selected="#session.CustomerArray[6]#" display="State" />
								</label>
								
								<label for="ShipZip#CurrentRow#"><b><span class="req">*</span>Zip/PostCode:</b>
									<cfinput type="text" name="ShipZip" value="#ShipZip#" required="yes" message="ZIP or Postal Code for shipping address is required">
								</label>
								
								<label for="ShipCountry#CurrentRow#"><b><span class="req">*</span>Country:</b>
									<cfselect name="ShipCountry" size="1" query="GetCountries" value="CountryCode" selected="#session.CustomerArray[8]#" display="Country" />
								</label>
							
							</fieldset>
							
							<fieldset>
								
								<label for="ShipPhone#CurrentRow#"><b><span class="req">*</span>Phone:</b>
									<cfinput type="text" name="ShipPhone" value="#ShipPhone#" required="yes" message="Phone number for shipping address is required">
								</label>
								
							</fieldset>
							
							<fieldset>
								
								<div class="f-submit-wrap">
									<cfinput type="submit" name="UpdateSHID" value="Update" class="button"> 
									<cfinput type="submit" name="DeleteSHID" value="Delete" class="button" onClick="return confirm('Are you sure you want to DELETE this shipping address?')">
									<!--- <cfinput type="submit" name="AddSHID" value="Add Address" class="button" style="width:150px"> --->
								</div>
								
							</fieldset>
							
						<cfinput type="hidden" name="CustomerID" value="#session.CustomerArray[17]#">
						<cfinput type="hidden" name="SHID" value="#SHID#">											
					</div>
						
						
					</cfform>
					
				</div>
			</cfloop>
			
		<cfinclude template="tags/shippingForm.cfm">
	</div>
</cfif>
	
</span>
<br>
</cfif>

<div class="myaccount" align="left" onclick="SwitchMenu('sub4')">
	<img src="images/icon-down.gif" align="absmiddle" /> &nbsp;My Messages
</div>
<span class="submenu4" id="sub4" style="padding: 10px 0px 0px 0px;">
	<cfif not checkMessages.RecordCount><!--- AND haveDownload.RecordCount EQ 0 --->
		<div class="cfMessageTwo" align="center">You have no new messages</div>
	<cfelseif not checkMessages.RecordCount>
		
		<table width="98%" border="0" align="center" cellpadding"3" cellspacing="0">
		<cfloop query="checkMessages">
			<tr>
				<td align="center">
					#Message#
				</td>
			</tr>
			<tr>
				<td>
					<hr class="snip" />
				</td>
			</tr>
		</cfloop>
		</table>
		
	<!---
	<cfelseif haveDownload.RecordCount NEQ 0 >
		<cfoutput query="haveDownload" group="OrderID">
			<cfif DateDiff("d", DateEntered, Now()) lte DaysAvailable>
				<form action="CA-Download.cfm" Method="Post">
					<input type="hidden" Name="InvoiceNumber" Value="#haveDownLoad.Order_ID#">
					<input class="cfButton" type="submit" Value="Download for Invoice: #haveDownLoad.Order_ID#">
				</form>
			</cfif>
		</cfoutput>
	--->
	</cfif>
</span>
<br />
</div>

<br />
<br />
<div align="center">
<hr class="snip" />
<br />
	<a href="CA-Logout.cfm"><img src="images/button-logout.gif"></a>&nbsp;&nbsp;
	<a href="index.cfm"><img src="images/button-home.gif"></a>	
</div>

<br><br>

</cfmodule>

</cfoutput>
