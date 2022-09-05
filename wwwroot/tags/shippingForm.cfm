<!--- 
|| MIT LICENSE ||
$Copyright: (c) FreeEnterprise.com.au 2007 $

|| VERSION CONTROL ||
$Id: $
$Date: $
$Revision: $

|| DESCRIPTION || 
$Description: $
$TODO: $

|| DEVELOPER ||
$Developer: Carl Vanderpal (carl@freeenterprise.com.au)$

|| ATTRIBUTES ||
$in: $
$out:$
--->

<div class="loopForms">
	<cfform action="CA-CustomerArea.cfm" method="post">
		
			<div class="formWrap1">
			
				<fieldset>
					
					<h3>Shipping Information</h3>
					
					<label for="ShipNickName"><b><span class="req">*</span>Nickname:</b>
						<cfinput type="text" name="ShipNickName" value="" required="yes" message="Required: Shipping Nickname"><br/>
					</label>
					
				</fieldset>
				
				<fieldset>
					
					<label for="ShippingFirstName"><b><span class="req">*</span>First Name:</b>
						<cfinput type="text" name="ShipFirstName" value="" required="yes" message="Required: Shipping First Name">
					</label>
					
					<label for="ShippingLastName"><b><span class="req">*</span>Last Name:</b>
						<cfinput type="text" name="ShipLastName" value="" required="yes" message="Required: Shipping Last Name">
					</label>
					
					<label for="ShipEmail"><b>Email:</b>
						<cfinput type="text" name="ShipEmail" value="" required="no" validate="email" message="Required: Valid Shipping Email Address">
					</label>
					
					<label for="ShipCompanyName"><b>Company Name:</b>
						<cfinput type="text" name="ShipCompanyName" value="" required="no">
					</label>
					
				</fieldset>
				
				<fieldset>
					
					<label for="ShipAddress1"><b><span class="req">*</span>Address 1:</b>
						<cfinput type="text" name="ShipAddress1" value="" required="yes" message="Required: Shipping Address Line 1">
					</label>
					
					<label for="ShipAddress2"><b>Address 2:</b>
						<cfinput type="text" name="ShipAddress2" value="" required="no">
					</label>
					
					<label for="ShipCity"><b><span class="req">*</span>City:</b>
						<cfinput type="text" name="ShipCity" value="" required="yes" message="Required: Shipping City">
					</label>
					
					<label for="ShipState"><b><span class="req">*</span>State/Prov:</b>
						<cfselect name="ShipState" query="GetStates" value="StateCode" display="State" required="yes" message="Required: Shipping State/Province"
							selected="#IIf(session.CustomerArray[6] EQ '', 'application.CompanyState', 'session.CustomerArray[6]')#" />
					</label>
					
					<label for="ShipZip"><b><span class="req">*</span>Zip/PostCode:</b>
						<cfinput type="text" name="ShipZip" value="" required="yes" message="Required: Shipping ZIP/Postal Code">
					</label>
					
					<label for="ShipCountry"><b><span class="req">*</span>Country:</b>
						<cfselect name="ShipCountry" query="GetCountries" value="CountryCode" display="Country" required="yes" message="Required: Shipping Country"
							selected="#IIf(session.CustomerArray[8] EQ '', 'application.BaseCountry', 'session.CustomerArray[8]')#" />
					</label>
				
				</fieldset>
				
				<fieldset>
					
					<label for="ShipPhone"><b><span class="req">*</span>Phone:</b>
						<cfinput type="text" name="ShipPhone" value="" required="yes" message="Required: Shipping Phone Number">
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
<!--- <br class="clear" /> --->

