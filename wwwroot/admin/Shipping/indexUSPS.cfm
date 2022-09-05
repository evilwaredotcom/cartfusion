<cfinvoke component="#application.Queries#" method="getStates" returnvariable="getStates"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getCountries" returnvariable="getCountries"></cfinvoke>

<!--- HEADER --->
<cfscript>
	PageTitle = 'USPS SHIPPING' ;
	BannerTitle = 'ShipWizard' ;
	AddAButton = 'RETURN TO SHIP WIZARD' ;
	AddAButtonLoc = 'index.cfm' ;
</cfscript>
<cfinclude template="LayoutShipHeader.cfm">
<cfinclude template="LayoutShipBanner.cfm">

<br>
<table width="80%" border="0" align="center" cellpadding="1" cellspacing="0" bgcolor="000099">
  	<cfif NOT isDefined('UserID') OR UserID EQ '' >
	<tr>
		<td align="center" class="cfAdminError" bgcolor="FFFFFF">
			<b>In order to use this feature, you must have a USPS Online Account, with it setup in <a href="../Config-ShipByCalc.cfm">Configuration</a>.</b><br/><br/>
		</td>
	</tr>
	</cfif>
	<tr>
		<td>
			<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
				<tr align="center">
					<td height="30" width="80%" colspan="4" bgcolor="0066CC" class="cfAdminHeaderUSPS1" align="center">
						<img src="images/Logos/logo-USPS.jpg" vspace="5" border="1" align="absmiddle">&nbsp;&nbsp;
						<font style="font-size:14px">CartFusion USPS Tracking &amp; Rate Request Form</font>
					</td>
				</tr>
				<tr align="center">
		  			<td height="1" colspan="4" bgcolor="000099"></td>
				</tr>
				<tr>
		  			<td width="50%" height="20" align="center" class="cfAdminHeaderUSPS2" bgcolor="9EB5C2"><b>Rate Request</b></td>
		  			<td width="1" rowspan="2" align="center" background="../images/borderDashes.gif" class="cfAdminHeader4"><img src="images/spacer.gif"></td>
		  			<td width="1" align="center" bgcolor="9EB5C2"></td>
		  			<td width="50%" height="20" align="center" class="cfAdminHeaderUSPS2" bgcolor="9EB5C2"><b>Tracking Request</b></td>
				</tr>
				<tr>
					<td valign="top" bgcolor="FFFFFF">
						<table width="100%" border="0" cellspacing="0" cellpadding="3">
						<cfform name="rates" id="rates" method="post" action="indexUSPS.cfm">
							<input type="hidden" name="function" value="RateDomesticRequest" />
							<tr bgcolor="003366">
								<td colspan="2" class="cfAdminHeader4">Address Information</td>
							</tr>
							<tr>
								<td bgcolor="#CCCCCC"> <b>Origin Country:</b><br>
									<select name="originCountry" class="cfAdminDefault" id="originCountry">
										<option value="US" selected="selected">United States</option>
									</select>
									<br>								</td>
								<td valign="top" bgcolor="#999999"><b>Destination Country:</b><br>
									<select name="destCountry" class="cfAdminDefault">
										<option selected="selected">United States</option>
										<cfoutput query="getCountries">
											<option value="#Country#">#Country#</option>
										</cfoutput>
									</select>								
								</td>
							</tr>
							<tr valign="top">
								<td colspan="2" class="cfAdminDefault" height="1"></td>
							</tr>
							<tr>
								<td valign="top" bgcolor="#CCCCCC"><b>Origin Zip/Postcode:</b><br>
									<cfinput name="originZip" type="text" value="#application.DefaultOriginZipCode#" size="10" maxlength="9" required="yes" message="Please enter an origin Zip/Post code" class="cfAdminDefault" id="originZip" />								</td>
								<td valign="top" bgcolor="#999999"><b>Destination Zip/Postcode:</b><br>
									<cfinput name="destZip" type="text" value="" size="10" maxlength="9" required="yes" message="Please enter an destination Zip/Post code" class="cfAdminDefault" id="destZip" />								</td>
							</tr>
							<tr valign="top">
								<td colspan="2" class="cfAdminDefault" height="1"></td>
							</tr>

							<tr bgcolor="003366">
								<td colspan="2" class="cfAdminHeader4">Shipment Information</td>
							</tr>
							<tr>
								<td colspan="2" bgcolor="EEEEEE" class="cfAdminDefault"><b>Package Weight:
									<cfinput name="weightLb" type="text" value="0" size="3" maxlength="3" required="yes" message="Package weight must be a valid number 1 through 150" validate="integer" id="weight" class="cfAdminDefault" />
										Pounds 
										<input name="weightOz" type="text" value="1" size="3" maxlength="3" required="yes" message="Package weight must be a valid number 1 through 150" validate="integer" id="weight" class="cfAdminDefault" />
										Ounces</b>
								</td>
							</tr>
							<tr valign="top">
								<td colspan="2" class="cfAdminDefault" height="1"></td>
							</tr>
							<tr>
								<td colspan="2" bgcolor="EEEEEE" class="cfAdminDefault"><b>Service
									Level:</b>
									<select name="Service" class="cfAdminDefault">
										<option value="Priority" selected="selected">Priority Mail</option>
										<option value="First Class">First Class Mail</option>
										<option value="Express">Express Mail</option>
										<option value="Parcel">Parcel Mail</option>
										<option value="BPM">Bound Printed Matter</option>
										<option value="Library">Library Mail</option>
										<option value="Media">Media Mail</option>
									</select>
								</td>
							</tr>
							<tr valign="top">
								<td colspan="2" class="cfAdminDefault" height="1"></td>
							</tr>
							<tr>
								<td colspan="2" bgcolor="EEEEEE" class="cfAdminDefault"><b>Packaging Type: </b>
									<select name="packageType" class="cfAdminDefault">
										<option value="Regular" selected="selected">Regular Package</option>
										<option value="Large">Large Package</option>
										<option value="Oversize">Oversize Package</option>
									</select>
								</td>
							</tr>
							<tr valign="top">
								<td colspan="2" class="cfAdminDefault" height="1"></td>
							</tr>
							<tr valign="top">
								<td colspan="2" class="cfAdminDefault" height="1"></td>
							</tr>
							<tr align="center" bgcolor="003366">
								<td colspan="2" class="cfAdminHeaderUSPS1">
									<input name="rateRequest" type="submit" id="rateRequest2" value="GET RATES" class="cfAdminButton" />
								</td>
							</tr>
							</cfform>
						</table>
					</td>
					
					<td width="1" bgcolor="000099"></td>
					
					<td valign="top" bgcolor="FFFFFF" style="padding:3px">
						<cfform name="form1" id="form1" method="post" action="#CGI.SCRIPT_NAME#">
							<u>Type Tracking Number below</u>:<br>
							<input type="hidden" name="function" value="trackRequest">								
							<input name="trackingNum" type="text" class="cfAdminDefault" value="" size="25" maxlength="24"><br/>
							<input name="TrackRequest" type="submit" id="TrackRequest" value="Track" class="cfAdminDefault">
						</cfform>
						<!---
						<table width="280" border="0" cellpadding="3" cellspacing="0">
  							<tr>
								<td>
									<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
	  									<tr>
											<td colspan="2" class="cfAdminDefault"><b>Address Validation HTML (USA Only)</b></td>
	  									</tr>
										<form action="indexUSPS.cfm" method="post">
	  										<input type="hidden" name="function" value="validateH" />
	  									<tr>
											<td class="cfAdminDefault">Street Address</td>
											<td>
												<input name="street" type="text" class="cfAdminDefault" id="street4" value="100 Peachtree Street" />
											</td>
										</tr>
										<tr>
											<td class="cfAdminDefault">City</td>
											<td>
												<input name="city" type="text" class="cfAdminDefault" id="city2" value="Atl" />
											</td>
	  									</tr>
	  									<tr>
											<td class="cfAdminDefault">State</td>
											<td>
												<select name="state" class="cfAdminDefault">
												<cfoutput query="getStates">
													<option value="#StateCode#" <cfif StateCode eq "GA">selected</cfif>>#State#</option>
												</cfoutput>
		 										</select>
												<!--- <input name="state" type="text" class="cfAdminDefault" /> --->
											</td>
	  									</tr>
	  									<tr>
											<td class="cfAdminDefault">Zipcode</td>
											<td>
												<input name="zip" type="text" class="cfAdminDefault" id="zip" size="10" maxlength="10" />
											</td>
										</tr>
										<tr align="center">
											<td colspan="2" class="cfAdminDefault">
												<input type="submit" name="Submit" value="Validate Address" class="cfAdminDefault" />
											</td>
										</tr>
										</form>
									</table>
								</td>
							</tr>
						</table>
						<br>
						<table width="280" border="0" cellpadding="1" cellspacing="0">
  							<tr>
								<td>
									<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
										<tr>
		  									<td colspan="2" class="cfAdminDefault"><b>Address Validation XML (USA Only)</b></td>
										</tr>
										<form action="indexUSPS.cfm" method="post">
											<input type="hidden" name="function" value="addressValidation" />
										<tr>
											<td class="cfAdminDefault">Street Address</td>
											<td>
												<input name="street" type="text" id="street" class="cfAdminDefault" />
											</td>
										</tr>
										<tr>
											<td class="cfAdminDefault">City</td>
											<td>
												<input name="city" type="text" id="city" class="cfAdminDefault" />
											</td>
										</tr>
										<tr>
											<td class="cfAdminDefault">State</td>
											<td>
												<select name="state" class="cfAdminDefault">
												<cfoutput query="getStates">
													<option value="#stateCode#" <cfif stateCode eq "GA">selected</cfif>>#State#</option>
												</cfoutput>
												</select>
											</td>
										</tr>
										<tr>
											<td class="cfAdminDefault">Zipcode</td>
											<td>
												<input name="zip" type="text" class="cfAdminDefault" id="zip2" size="10" maxlength="10" />
											</td>
										</tr>
										<tr align="center">
											<td colspan="2" class="cfAdminDefault">
												<input type="submit" name="Submit" value="Validate Address" class="cfAdminDefault" />
											</td>
										</tr>
										</form>
									</table>
								</td>
							</tr>
						</table>
						<br>
						<table width="280" border="0" cellpadding="1" cellspacing="0">
							<tr>
								<td>
									<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
										<tr>
											<td colspan="2" class="cfAdminDefault"><b>Zipcode Lookup XML (USA Only)</b></td>
										</tr>
										<form action="indexUSPS.cfm" method="post">
											<input type="hidden" name="function" value="addressCityStateLookup" />
										<cfloop from="1" to="5" index="i">
										<tr>
											<td class="cfAdminDefault">Zipcode <cfoutput>#i#</cfoutput></td>
											<td>
												<input name="zip" type="text" class="cfAdminDefault" id="zip<cfoutput>#i#</cfoutput>" size="10" maxlength="5" />
											</td>
										</tr>
										</cfloop>
										<tr align="center">
											<td colspan="2" class="cfAdminDefault">
												<input name="Submit" type="submit" class="cfAdminDefault" id="Submit" value="Zip Lookup" />
											</td>
										</tr>
										</form>
									</table>
									
								</td>
							</tr>
						</table>
						--->
					</td>					
				</tr>
			</table>
		</td>
	</tr>
</table>

<br>

<cfif IsDefined("function") AND function eq "validateH">
	<cf_TagAddrValidateHTML Address1="#street#"
		Address2=""
		City="#City#"
		state="#State#"
		zipcode="#Zip#">
		
	<cfif IsDefined("AddrValidateError") AND AddrValidateError eq 1>
		Address Validation Error!
	<cfelse>
		<table width="80%" border="1" align="center" cellpadding="0" cellspacing="0">
			<tr>
				<td height="20" colspan="4" bgcolor="#CCCCCC" class="cfAdminDefault"><b>Validation Results</b></td>
			</tr>
			<tr>
				<td bgcolor="EEEEEE" class="cfAdminDefault">Street Address</td>
				<td bgcolor="EEEEEE" class="cfAdminDefault">City</td>
				<td bgcolor="EEEEEE" class="cfAdminDefault">State</td>
				<td bgcolor="EEEEEE" class="cfAdminDefault">Zipcode + 4</td>
			</tr>
			<tr>
				<td height="17" class="cfAdminDefault"><cfoutput>#vAddrLine1#</cfoutput></td>
				<td class="cfAdminDefault"><cfoutput>#vCity#</cfoutput></td>
				<td class="cfAdminDefault"><cfoutput>#vState#</cfoutput></td>
				<td class="cfAdminDefault"><cfoutput>#vZip#</cfoutput></td>
			</tr>
		</table>
	</cfif>

<cfelseif IsDefined("function") AND function eq "addressValidation">
	<cf_TagUSPS
		function="addressValidation"
		USPSUserID="#Userid#"
		USPSPassword="#Password#"
		ShipToAddress1="#street#"
		ShipToCity="#City#"
		ShipToState="#State#"
		ShipToZip5="#Zip#"
		TestingEnvironment="False">

		<cfif IsDefined("USPSError") AND USPSError gt 0>
			<br>
			<table width="80%" border="0" align="center" cellpadding="1" cellspacing="0" bgcolor="#009900">
				<tr>
					<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td colspan="2" nowrap="nowrap">&nbsp;<font color="#FFFFFF" size="2" face="tahoma, verdana, sans-serif"><b>Returned Error Variables</b></td>
							</tr>
							<tr>
								<td nowrap="nowrap"><u>Error Severity:</u></td>
								<td align="left"><cfoutput>#USPSError#</cfoutput></td>
							</tr>
							<tr>
								<td valign="top" nowrap="nowrap" bgcolor="EEEEEE"><u>Error Description:</u></td>
								<td align="left" nowrap="nowrap" bgcolor="EEEEEE"><cfoutput>#USPSAddrValidateErrorDesc#</cfoutput></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<br>
		<cfelseif IsDefined("USPSError") AND USPSError eq 0>
			<table width="80%" border="1" align="center" cellpadding="0" cellspacing="0">
				<tr>
					<td height="20" colspan="4" bgcolor="#CCCCCC" class="cfAdminDefault"><b>Validation Results</b></td>
				</tr>
				<tr>
					<td bgcolor="EEEEEE" class="cfAdminDefault">Street Address</td>
					<td bgcolor="EEEEEE" class="cfAdminDefault">City</td>
					<td bgcolor="EEEEEE" class="cfAdminDefault">State</td>
					<td bgcolor="EEEEEE" class="cfAdminDefault">Zipcode + 4</td>
				</tr>
				<tr>
					<td height="17" class="cfAdminDefault"><cfoutput>#ValidatedStreet1# #ValidatedStreet2#</cfoutput></td>
					<td class="cfAdminDefault"><cfoutput>#ValidatedCity#</cfoutput></td>
					<td class="cfAdminDefault"><cfoutput>#ValidatedState#</cfoutput></td>
					<td class="cfAdminDefault"><cfoutput>#ValidatedZipcode5# - #ValidatedZipcodePlus4#</cfoutput></td>
				</tr>
			</table>
		</cfif>

	<cfelseif IsDefined("function") AND function eq "addressCityStateLookup">
	<cf_TagUSPS
		function="addressCityStateLookup"
		USPSUserID="#Userid#"
		USPSPassword="#Password#"
		ShipToZip5="#Zip#"
		TestingEnvironment="False"
		Debug="False">
		<!--- <cfoutput>
		<cf_objectdump object="#stUSPSAddrCityStateLookup#">
		<cfabort>
		</cfoutput> --->
		<cfif IsDefined("USPSError") AND USPSError gt 0>
			<br>
			<table width="80%" border="0" align="center" cellpadding="1" cellspacing="0" bgcolor="#009900">
			<tr>
				<td>
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td colspan="2" nowrap="nowrap">&nbsp;<b>Returned Error Variables</b></td>
						</tr>
						<tr>
							<td nowrap="nowrap"><u>Error Severity:</u></td>
							<td align="left"><cfoutput>#USPSError#</cfoutput></td>
						</tr>
						<tr>
							<td valign="top" nowrap="nowrap" bgcolor="EEEEEE"><u>Error Description:</u></td>
							<td align="left" nowrap="nowrap" bgcolor="EEEEEE"><cfoutput>#USPSCityStateErrorDesc#</cfoutput></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<br>
	<cfelseif IsDefined("USPSError") AND USPSError eq 0>
		<table width="80%" border="1" align="center" cellpadding="0" cellspacing="0">
			<tr>
				<td height="20" colspan="4" bgcolor="#CCCCCC" class="cfAdminDefault"><b>Validation Results</b></td>
			</tr>
			<tr>
				<td bgcolor="EEEEEE" class="cfAdminDefault">City/Error</td>
				<td bgcolor="EEEEEE" class="cfAdminDefault">State</td>
				<td bgcolor="EEEEEE" class="cfAdminDefault">Zipcode</td>
			</tr>
			<cfoutput query="USPSCityStateQuery">
			<tr>
				<td class="cfAdminDefault">#Error##ValidatedCity#</td>
				<td class="cfAdminDefault">#ValidatedState#</td>
				<td class="cfAdminDefault">#ValidatedZip5#</td>
			</tr>
			</cfoutput>
		</table>
	</cfif>

<cfelseif IsDefined("function") AND function eq "RateDomesticRequest">

	<cfif destCountry eq 'United States'>
		<cf_TagUSPS
			function="RateDomesticRequest"
			USPSUserID="#Userid#"
			USPSPassword="#Password#"
			ShipFromZip5="#originZip#"
			ShipToZip5="#destZip#"
			PackageWeightLB="#weightLb#"
			PackageWeightOZ="#weightOz#"
			PackageSize="#packageType#"
			ServiceLevel="#Service#"
			TestingEnvironment="False">

	<cfelse>

		<cf_TagUSPS
			function="RateIntlRequest"
			USPSUserID="#Userid#"
			USPSPassword="#Password#"
			ShipToCountry="#destCountry#"
			PackageWeightLB="#weightLb#"
			PackageWeightOZ="#weightOz#"
			PackageType="Package"
			TestingEnvironment="False">

	</cfif>

	<cfif IsDefined("USPSError") AND USPSError gt 0>
		<br>
		<table width="80%" border="0" align="center" cellpadding="1" cellspacing="0" bgcolor="#009900">
			<tr>
				<td>
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td colspan="2" nowrap="nowrap">&nbsp;<b>Returned Error Variables</b></td>
						</tr>
						<tr>
							<td nowrap="nowrap"><u>Error Severity:</u></td>
							<td align="left"><cfoutput>#USPSError#</cfoutput></td>
						</tr>
						<tr>
							<td valign="top" nowrap="nowrap" bgcolor="EEEEEE"><u>Error Description:</u></td>
							<td align="left" nowrap="nowrap" bgcolor="EEEEEE"><cfoutput>#USPSErrorDesc#</cfoutput></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<br>
	</cfif>
	
	<cfif IsDefined("USPSDomesticRateQuery")>
	
		<table width="80%" border="1" align="center" cellpadding="2" cellspacing="0">
			<tr bgcolor="#CCCCCC">
				<td height="20" colspan="2" class="cfAdminDefault"><b>Domestic Rate Results</b></td>
			</tr>
			<!--- 
			FreightCharges, Pounds, Ounces, Service, Size, ZipDestination, ZipOrigin, Zone
			--->
			<cfoutput query="USPSDomesticRateQuery">
			<tr>
				<td width="20%" height="20" class="cfAdminDefault">Postage Service:</td>
				<td width="80%" class="cfAdminDefault">#Service#</td>
			</tr>
			<tr>
				<td height="20" class="cfAdminDefault">Postage Charges:</td>
				<td class="cfAdminDefault">#FreightCharges#</td>
			</tr>
			<tr>
				<td height="20" class="cfAdminDefault">Package Size:</td>
				<td class="cfAdminDefault">#Size#</td>
			</tr>
			<tr>
				<td height="20" class="cfAdminDefault">Package Weight:</td>
				<td class="cfAdminDefault">#Pounds# LBS (#Ounces# Oz)</td>
			</tr>
			<tr>
				<td height="20" class="cfAdminDefault">Origin Zip:</td>
				<td class="cfAdminDefault">#ZipOrigin#</td>
			</tr>
			<tr>
				<td height="20" class="cfAdminDefault">Destination Zip:</td>
				<td class="cfAdminDefault">#ZipDestination#</td>
			</tr>
			<tr>
				<td height="20" class="cfAdminDefault">USPS Zone:</td>
				<td class="cfAdminDefault">#Zone#</td>
			</tr>
			</cfoutput>
		</table>
		
		<!--- 
		<cfif Service eq "Priority">
			<cf_TagUSPS
				function="PriorityTransitTimeRequest"
				USPSUserID="#Userid#"
				USPSPassword="#Password#"
				ShipFromZip5="500"
				ShipToZip5="90210"
				TestingEnvironment="False"
				Debug="True">
		
			<cfoutput>
				<cf_objectdump object="#stUSPSPryTransitTime#">
			</cfoutput>
		</cfif> 
		--->
		<!--- 
		<cfoutput>
			<cf_objectdump object="#stUSPSRateDomestic#">
		</cfoutput> 
		--->
	</cfif>
	
	<cfif IsDefined("USPSIntlRateServicesQuery")>
		<table width="80%" border="1" align="center" cellpadding="2" cellspacing="0">
			<tr bgcolor="#CCCCCC">
				<td height="20" colspan="7" class="cfAdminDefault"><b>International Rate Results</b></td>
			</tr>
			<tr bgcolor="EEEEEE">
				<td class="cfAdminDefault">Service</td>
				<td class="cfAdminDefault">Postage</td>
				<td class="cfAdminDefault">Package Type</td>
				<td class="cfAdminDefault">Billable Weight</td>
				<td class="cfAdminDefault">Max Dimensions</td>
				<td class="cfAdminDefault">Max Weight</td>
				<td class="cfAdminDefault">Service Updatement</td>
			</tr>
			<cfoutput query="USPSIntlRateServicesQuery">
			<tr>
				<td class="cfAdminDefault">#ServiceDescription#</td>
				<td class="cfAdminDefault">#DollarFormat(Postage)#</td>
				<td class="cfAdminDefault">#MailType#</td>
				<td class="cfAdminDefault" nowrap="nowrap">#Pounds# LBS #Ounces# Ounces</td>
				<td class="cfAdminDefault">#MaxDimensions#</td>
				<td class="cfAdminDefault">#MaxWeight#</td>
				<td class="cfAdminDefault">#ServiceUpdatements#</td>
			</tr>
			</cfoutput>
		</table>
	</cfif>

<cfelseif IsDefined("function") AND function eq "trackRequest">
	<cfparam name="Test" default="False">
	<cfif trackingNum eq "EJ958088694US">
		<cfset Test = "True">
	</cfif>
	<cf_TagUSPS
		function="TrackRequest"
		USPSUserID="#Userid#"
		USPSPassword="#Password#"
		TrackingNumber="#trackingNum#"
		TestingEnvironment="#Test#">

	<!--- 
	<cfoutput>
		<cf_objectdump object="#stUSPSTrack#">
	</cfoutput> 
	--->

	<cfif IsDefined("USPSError") AND USPSError EQ 0>
		<cfif IsDefined("USPSTrackQuery")>
			<table width="80%" border="1" align="center" cellpadding="2" cellspacing="0">
				<tr bgcolor="#CCCCCC">
					<td height="20" class="cfAdminDefault"><b>Tracking Results</b></td>
				</tr>
				<tr bgcolor="EEEEEE">
					<td bgcolor="#DDE8FF" class="cfAdminDefault"><u>Tracking Summary</u>:<br>
						<cfoutput>#TrackSummary#</cfoutput>		  
					</td>
				</tr>
				<tr bgcolor="EEEEEE">
					<td class="cfAdminDefault">Track Activity</td>
				</tr>
				<cfoutput query="USPSTrackQuery">
				<tr>
					<td class="cfAdminDefault">#ActivityScan#</td>
				</tr>
				</cfoutput>
			</table>
		</cfif> 

	<cfelse>
		<table width="80%" border="0" align="center" cellpadding="1" cellspacing="0" bgcolor="#009900">
			<tr>
				<td>
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td colspan="2" nowrap="nowrap">&nbsp;<b>Returned Error Variables</b></td>
						</tr>
						<tr>
							<td nowrap="nowrap"><u>Error Severity:</u></td>
							<td align="left"><cfoutput>#USPSError#</cfoutput></td>
						</tr>
						<tr>
							<td valign="top" nowrap="nowrap" bgcolor="EEEEEE"><u>Error Description:</u></td>
							<td align="left" nowrap="nowrap" bgcolor="EEEEEE"><cfoutput>#USPSTrackErrorDesc#</cfoutput></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</cfif>		
	
</cfif>

<cfinclude template="LayoutShipFooter.cfm">
