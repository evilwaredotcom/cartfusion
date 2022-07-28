<div class="loopForms">
	<cfform action="CA-CustomerArea.cfm" method="post">
		
			<div class="f-wrap-1">
			
				<fieldset>
					
					<h3>Shipping Information</h3>
					
					<label for="ShipNickName"><b><span class="req">*</span>Nickname:</b>
						<cfinput type="text" name="ShipNickName" value="" required="yes" message="A Nickname for the shipping address is required"><br />
					</label>
					
				</fieldset>
				
				<fieldset>
					
					<label for="ShippingFirstName"><b><span class="req">*</span>First Name:</b>
						<cfinput type="text" name="ShipFirstName" value="" required="yes" message="First Name for shipping address is required">
					</label>
					
					<label for="ShippingLastName"><b><span class="req">*</span>Last Name:</b>
						<cfinput type="text" name="ShipLastName" value="" required="yes" message="Last Name for shipping address is required">
					</label>
					
					<label for="ShipEmail"><b>Email:</b>
						<cfinput type="text" name="ShipEmail" value="" required="no" validate="email" message="Please enter a valid email address for the shipping address">
					</label>
					
					<label for="ShipCompanyName"><b>Company Name:</b>
						<cfinput type="text" name="ShipCompanyName" value="" required="no">
					</label>
					
				</fieldset>
				
				<fieldset>
					
					<label for="ShipAddress1"><b><span class="req">*</span>Address 1:</b>
						<cfinput type="text" name="ShipAddress1" value="" required="yes" message="Address Line 1 for shipping address is required">
					</label>
					
					<label for="ShipAddress2"><b>Address 2:</b>
						<cfinput type="text" name="ShipAddress2" value="" required="no">
					</label>
					
					<label for="ShipCity"><b><span class="req">*</span>City:</b>
						<cfinput type="text" name="ShipCity" value="" required="yes" message="City for shipping address is required">
					</label>
					
					<label for="ShipState"><b><span class="req">*</span>State/Prov:</b>
						<cfselect name="ShipState" size="1" query="GetStates" value="StateCode" selected="#session.CustomerArray[6]#" display="State" />
					</label>
					
					<label for="ShipZip"><b><span class="req">*</span>Zip/PostCode:</b>
						<cfinput type="text" name="ShipZip" value="" required="yes" message="ZIP or Postal Code for shipping address is required">
					</label>
					
					<label for="ShipCountry"><b><span class="req">*</span>Country:</b>
						<cfselect name="ShipCountry" size="1" query="GetCountries" value="CountryCode" selected="#session.CustomerArray[8]#" display="Country" />
					</label>
				
				</fieldset>
				
				<fieldset>
					
					<label for="ShipPhone"><b><span class="req">*</span>Phone:</b>
						<cfinput type="text" name="ShipPhone" value="" required="yes" message="Phone number for shipping address is required">
					</label>
					
				</fieldset>
				
				<fieldset>
					
					<div class="f-submit-wrap">
						<cfinput type="submit" name="AddSHID" value="Add Address" class="button" style="width:150px">
					</div>
					
				</fieldset>
				
			<cfinput type="hidden" name="CustomerID" value="#session.CustomerArray[17]#">
			
			</div>
	</cfform>
</div>
<br class="clear" />

