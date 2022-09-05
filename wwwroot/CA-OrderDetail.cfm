


<cfif session.CustomerArray[26] EQ ''>
	<script language="javascript" type="text/javascript">
		self.close();
	</script>
</cfif>


<!--- BEGIN: QUERIES --->
<cflock timeout="20">
	<cfscript>
		getOrder = application.Queries.getOrder(OrderID=form.OrderID);
		getOrderItems = application.Queries.getOrderItems(OrderID=form.OrderID);
		getBackOrders = application.Queries.getBackOrders(OrderID=form.OrderID);
		getShippingMethod = application.Queries.getShippingMethod(ShippingCode=getOrder.ShippingMethod);
	</cfscript>
</cflock>
<!--- END: QUERIES --->

<cfoutput>

	<cfmodule template="templates/#application.SiteTemplate#/layout.cfm" showhorizontalnav="false" showcategories="false" showcopyright="false" showcarttotals="false" layoutstyle="Full">
	
	<cfloop query="getOrder">
		<div align="center"><br><h3>#application.storename# Invoice</h3><br/></div>
		<table width="700" align="center">
			<tr>
				<td>			
					<table align="center" cellpadding="6" cellspacing="0" class="cartLayoutTable">
						<tr>
							<th><b>Invoice##: #OrderID#</b></th>
							<th><b>Invoice Date: #DateFormat(OrderDate,"dd-mmm-yyyy")#</b></th>
						</tr>
						<tr>
							<td width="300" class="cfDefault" valign="top">
								<b>Customer ID: #CustomerID#</b><br>
								#FirstName# #LastName#<br>
								#Address1#<br>
								<cfif Address2 NEQ ''>#Address2#<br></cfif>
								#City#, #State# #Zip#<br>
								#Country#<br>
								#Email#
							</td>
							
							<cfscript>
								if ( PaymentVerified EQ 1 )
									PV = 'Yes';
								else
									PV = 'No';
				
								if ( CCNum NEQ '' ) 
									Decrypted_CardNum = DECRYPT(getOrder.CCNum, application.CryptKey, "CFMX_COMPAT", "Hex") ;
								else 
									Decrypted_CardNum = '' ;
								/* if ( getOrder.CCExpDate NEQ '' ) 
									Decrypted_ExpDate = DECRYPT(getOrder.CCExpDate, application.CryptKey, "CFMX_COMPAT", "Hex") ;
								else 
									Decrypted_ExpDate = '' ; */
							</cfscript>
							
							
							<td width="300" class="cfDefault" valign="top">
								<b>Payment Method:</b><br>
								<cfswitch expression="#getOrder.FormOfPayment#">
									<cfcase value="1">
										Card Type: <img src="images/logos/icon-#CCName#.gif" border="0" alt="#CCName#" align="absmiddle" /><br>
										Card Number: XXXXXXXXXXXX#Right(decrypted_CardNum,4)#<br>
										<!---Expiration Date: #decrypted_ExpDate#<br>--->
									</cfcase>
									<cfcase value="2">
										<img src="images/Logos/logo-PayPal.gif" align="absmiddle"> <b>PayPal</b><br>
									</cfcase>
									<cfcase value="3">
										<img src="images/Logos/logo-ECheck.gif" align="absmiddle"> <b>eCheck</b><br>
									</cfcase>
									<cfcase value="4">
										<img src="images/Logos/logo-OrderForm.gif" align="absmiddle"> <b>Order Form / Invoice</b><br>
									</cfcase>
								</cfswitch>
								Payment Verified: <b>#PV#</b><br>
								Shipping Method: #getShippingMethod.ShippingMessage#<br>
							</td>
						</tr>		
					</table>
				</td>
			</tr>		
		</table>
	</cfloop>
	<br>	
	
	<cfscript>
		Quantity = 0;
		Runningweight = 0;
 		Runningtotal = 0;
 		Runningnorm = 0;
	</cfscript>
	
	<div id="OrderDetails" align="center">Order Details</div>
	<br/>
		<table width="700" align="center">
			<tr>
				<td>
					<table class="cartLayoutTable" cellspacing="0" cellpadding="6">
						<tr>
							<th align="left">Action Date</th>
							<th align="left">Status</th>
							<th align="left">SKU</th>
							<th align="left">Description</th>
							<th align="right">Qty</th>
							<th align="right">Each</th>
							<th align="right">Total</th>
						</tr>
						<cfloop query="getOrderItems">

							<cfscript>
								Quantity = Qty;
								TotalPrice = (ItemPrice * Qty);
								FinalDesc = '<b>' & ItemName & '</b>';
								if (OptionName1 NEQ '')
									FinalDesc = '#FinalDesc#<br>#OptionName1#';
								if (OptionName2 NEQ '')
									FinalDesc = '#FinalDesc#, #OptionName2#';
								if (OptionName3 NEQ '')
									FinalDesc = '#FinalDesc#, #OptionName3#';
								if (StatusCode IS 'BO')
								{
									BackOrdersPrice = (ItemPrice * Qty);
									FinalDesc = '#FinalDesc# (BACK ORDERED)';
								}
								NormalPrice = TotalPrice;
								
								// Get Order Status
								getOrderStatus = application.Queries.getOrderStatusCode(StatusCode=StatusCode);
							</cfscript>	
							
							
							<tr class="row#CurrentRow mod 2#">
								<td align="left">#DateFormat(OrderItemDate, "mm/dd/yy")#</td>
								<td align="left">#getOrderStatus.StatusMessage#</td>		
								<td align="left">#SKU#</td>
								<td align="left">#FinalDesc#</td>
								<td align="right">#Qty#</td>
								<td align="right">#LSCurrencyFormat(itemprice, "local")#</td>
								<td align="right">#LSCurrencyFormat(TotalPrice, "local")#</td>
							</tr>
							<cfset runningtotal = runningtotal + TotalPrice>
							<cfset runningnorm = runningnorm + NormalPrice>
							
							<cfif OITrackingNumber NEQ ''>
							<tr>	
								<td colspan="3" align="right">Tracking Number:</td>
								<td colspan="3">
									<cfif #Left(OITrackingNumber,2)# EQ '1Z'>
										#OITrackingNumber#
										<a target="_blank" href="http://wwwapps.ups.com/WebTracking/processInputRequest?Requester=UPSHome&tracknum=#OITrackingNumber#&AgreeToTermsAndConditions=yes">
											<img src="admin/images/button-trackups.gif" border="0"> 
										</a>					
									<cfelseif Len(OITrackingNumber) EQ 12 > 
										#OITrackingNumber#
										<a target="_blank" href="http://www.federalexpress.com/cgi-bin/tracking?tracknumbers=#OITrackingNumber#&action=track&language=english&cntry_code=us&mps=y&ascend_header=1">
											<img src="admin/images/button-trackfedex.gif" border="0"> 
										</a>
									<cfelse>
										<form action="http://trkcnfrm1.smi.usps.com/netdata-cgi/db2www/cbd_243.d2w/output" method="POST" name="getTrackNum">
											<input type="HIDDEN" name="CAMEFROM" value="OK">
											<input type="HIDDEN" name="strOrigTrackNum" id="EnterLabelNumberHere" value="#OITrackingNumber#">
											#OITrackingNumber# <input type="image" src="admin/images/button-trackusps.gif" align="absmiddle">
										</form>
									</cfif>
								</td>
							</tr>
							</cfif>
						</cfloop>
						<!--- TOTALS ---------------------------------------------------------------------->
						<cfloop query="getOrder"><!--- <cfoutput query="getOrder"> --->
							<tr>
								<td colspan="6">
								<td><hr class="snip" /></td>
							</tr>
							<tr class="subTotal">
								<td align="right" colspan="6" height="20">SubTotal:</td>
								<td align="right">#LSCurrencyFormat(runningtotal, "local")#</td>
							</tr>
							<cfif DiscountTotal NEQ ''>
							<tr>
								<td align="right" colspan="6">Discount:</td>
								<td align="right">- #LSCurrencyFormat(DiscountTotal)#</td>
							</tr>
							<cfset runningtotal = runningtotal - DiscountTotal>
							</cfif>
							<cfif TaxTotal NEQ ''>
							<tr>
								<td align="right" colspan="6">Tax:</td>
								<td align="right">#LSCurrencyFormat(TaxTotal)#</td>
							</tr>
							<cfset runningtotal = runningtotal + TaxTotal>
							</cfif>
							<cfif ShippingTotal NEQ ''>
							<tr>
								<td align="right" colspan="6">Shipping:</td>
								<td align="right">#LSCurrencyFormat(ShippingTotal)#</td>
							</tr>
							<cfset runningtotal = runningtotal + ShippingTotal>
							</cfif>
							<cfif CreditApplied NEQ '' AND CreditApplied NEQ 0>
							<tr>
								<td align="right" colspan="6">Store Credit:</td>
								<td align="right">- #LSCurrencyFormat(CreditApplied)#</td>
							</tr>
							<cfset runningtotal = runningtotal - CreditApplied>
							</cfif>
							<tr class="grandTotal">
								<td colspan="5" height="20">&nbsp;</td>
								<td align="right" valign="middle"><b>Total:</b></td>
								<td align="right" valign="middle"><b>#LSCurrencyFormat(runningtotal, "local")#</b></td>
							</tr>
						</cfloop>
					</table>
				</td>
			</tr>
		</table>
	
<br>
<br>

<cfif getOrder.TrackingNumber NEQ ''>
	<div align="center">
		
		<cfif #Left(getOrder.TrackingNumber,2)# EQ '1Z'>
			<b>Order Tracking Number:</b>
			<a target="_blank" href="http://wwwapps.ups.com/WebTracking/processInputRequest?Requester=UPSHome&tracknum=#getOrder.TrackingNumber#&AgreeToTermsAndConditions=yes">
				#getOrder.TrackingNumber# <img src="admin/images/button-trackups.gif" border="0"> 
			</a>					
		<cfelseif Len(getOrder.TrackingNumber) EQ 12 > 
			<b>Order Tracking Number:</b>
			<a target="_blank" href="http://www.federalexpress.com/cgi-bin/tracking?tracknumbers=#getOrder.TrackingNumber#&action=track&language=english&cntry_code=us&mps=y&ascend_header=1">
				#getOrder.TrackingNumber# <img src="admin/images/button-trackfedex.gif" border="0"> 
			</a>
		<cfelse>
			<form action="http://trkcnfrm1.smi.usps.com/netdata-cgi/db2www/cbd_243.d2w/output" method="POST" name="getTrackNum">
				<input type="HIDDEN" name="CAMEFROM" value="OK">
				<input type="HIDDEN" name="strOrigTrackNum" id="EnterLabelNumberHere" value="#getOrder.TrackingNumber#">
				<b>Order Tracking Number:</b> #getOrder.TrackingNumber# <input type="image" src="admin/images/button-trackusps.gif" align="absmiddle">
			</form>
		</cfif>
	</div><br><br>
</cfif>

<div align="center">
	<a href="javascript:window.print();">[print this page]</a>
</div>

<br>
	
	
	</cfmodule>
</cfoutput>
