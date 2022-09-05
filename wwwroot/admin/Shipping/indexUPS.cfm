<cfinvoke component="#application.Queries#" method="getStates" returnvariable="getStates"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getCountries" returnvariable="getCountries"></cfinvoke>

<cfparam name="NumOfPackages" default="1">

<!--- HEADER --->
<cfscript>
	PageTitle = 'UPS SHIPPING' ;
	BannerTitle = 'ShipWizard' ;
	AddAButton = 'RETURN TO SHIP WIZARD' ;
	AddAButtonLoc = 'index.cfm' ;
</cfscript>
<cfinclude template="LayoutShipHeader.cfm">
<cfinclude template="LayoutShipBanner.cfm">

<!--- 

Oversize Package Codes
======================
0 = Standard oversize
1 = OS1, Oversize 1 (package exceeds 84 inches and is equal to or less than 108 inches in length and girth combined and weighs less than 30 pounds)
2 = OS2, Oversize 2 (package exceeds 108 inches in length and girth combined and weighs less than 70 pounds)

Rate Shop request example usage
===============================

<cf_TagUPS function="rateShopRequest"
		PickUpType="[01 = Daily Pickup | 03 = Customer Counter | 06 = One Time Pickup | 07 = On Call Air | 19 = Letter Center | 20 = Air Service Center]" Defaults to 01
		ShipperState=""
		ShipperZip=""
		ShipperCountry=""
		ShipToCity="Los Angeles"
		ShipToState="CA"
		ShipToZip="90046"
		ShipToCountry=""
		weight=""
		packageType="[00 | 01 | 02 | 03 | 04 | 21 | 24 | 25]"
		PackageOversize="" 
		SaturdayDelivery="[0 | 1]" 0 = No, 1 = Yes
		ResidentialAddress="[0 | 1]" 0 = No, 1 = Yes
		PackageLength="20"
		PackageWidth="20"
		PackageHeight="20"
	>
 
 Returned Variables
 ==================
 
 Query: rateShopQuery
 --------------------
 GuaranteedDTD
 BillableWeight
 WeightUnit
 ScheduledDelivTime
 OptionCharges
 OptionChargesCurrency
 ServiceLevel // Service Level Code
 TotalCharges
 TotalChargesCurrency
 OriginalWeight
	
 Services Level query available
 ------------------------------
 Query Name: ServiceLevelQuery
 Columns:
 	ServiceLevelCode
	ServiceLevelDesc
	 
	 Example query to match Returned ServiceLevel (above) with matching Service Description
	 -------------------------------------------------------------------------------------- 
	 <cfquery dbtype="query" name="Services">
		SELECT ServiceLevelCode, ServiceLevelDesc 
		FROM ServiceLevelQuery 
		WHERE (ServiceLevelCode = #rateShopQuery.ServiceLevel#)
	 </cfquery>

	
 Possible Returned ERROR Variables
 =================================
 UPSRateShopError = 0 (Transaction was successful)
 UPSRateShopError = 1 (The rate request transaction failed)
 UPSRateShopError = 2 (The was a complete failure no valid XML response was received)
 
 
Time In Transit Example Usage
=============================
Pickup date format YYYYMMDD

Returned Variables
------------------
 BusinessDays
 EstDelivDate
 EstDelivDay
 EstDelivTime
 CorrectedPickupDate
 ServiceGuaranteed
 ServiceCode
 ServiceDesc

Tracking Example Usage
======================
<cf_TagUPS function="trackRequest"
		TrackingNumber="valid tracking number"
		>

Returned Variables
------------------
UPSPackageWeight
UPSPackageWeightUnit
UPSTrackingNumber
UPSServiceCode
UPSServiceDesc
UPSShipperAddress1 (conditional)
UPSShipperAddress2 (conditional)
UPSShipperAddress3 (conditional)
UPSShipperCity (conditional)
UPSShipperState (conditional)
UPSShipperZip (conditional)
UPSShipperCountry (conditional)
UPSShipperNumber (conditional)
UPSEstimatedDelivDate (conditional YYYYMMDD)
UPSEstimatedDelivTime (conditional HHMMSS)

Package Activity Query available (conditional - check for its existence)
------------------------------------------------------------------------
 Query Name: TrackActivityQuery
 Query Columns: (will all be available some may be empty strings)
 	AddressCity
	AddressState
	AddressZip
	AddressCountry
	LocationDesc
	LocationSignedBy
	ActivityDate
	ActivityTime
	StatusCode
	StatusTypeCode (see chart below)

Status Types for tracking activity
----------------------------------
I = In Transit
D = Delivered
X = Exception
P = Pickup
M = Manifest pickup

 --->

<br>
<table width="80%" border="0" align="center" cellpadding="1" cellspacing="0" bgcolor="993300">
  	<cfif NOT isDefined('AccessKey') OR AccessKey EQ '' >
	<tr>
		<td align="center" class="cfAdminError" bgcolor="FFFFFF">
			<b>In order to use this feature, you must have a UPS Online Tools account, with it setup in <a href="../Config-ShipByCalc.cfm">Configuration</a>.</b><br/><br/>
		</td>
	</tr>
	</cfif>
	<tr>
		<td>
			<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0">
				<tr>
					<td height="30" width="80%" colspan="4" bgcolor="340005" class="cfAdminHeaderUPS1" align="center">
						<img src="images/Logos/logo-UPSmed.gif" align="absmiddle">&nbsp;&nbsp;
						<font style="font-size:14px">CartFusion UPS Tracking &amp; Rate Request Form</font>
					</td>
				</tr>
				<tr align="center">
					<td height="1" colspan="4" bgcolor="993300"></td>
				</tr>
				<tr>
					<td width="50%" height="20" align="center" class="cfAdminHeaderUPS2">Rate Request</td>
					<td width="1" rowspan="2" align="center" background="../images/borderDashes.gif" class="cfAdminHeaderUPS1"><img src="images/spacer.gif"></td>
					<td width="1" align="center" bgcolor="993300" class="cfAdminHeaderUPS2"></td>
					<td width="50%" height="20" align="center" class="cfAdminHeaderUPS2">Tracking Request</td>
				</tr>
				<tr>		  			
					<td valign="top" bgcolor="FFFFFF">
		  				<table width="100%" border="0" cellspacing="0" cellpadding="1">
							<cfform name="rates" id="rates" method="post" action="#CGI.SCRIPT_NAME#">
								<input type="hidden" name="function" value="rateShopRequest">
								<input type="hidden" name="NumOfPackages" value="<cfoutput>#NumOfPackages#</cfoutput>">
							<tr>
								<td height="18" colspan="2" bgcolor="551C00" class="cfAdminHeaderUPS1">Address Information</td>
							</tr>
							<tr>
				  				<td style="background-color:##CCCCCC;"><b>Origin Country:</b><br>
								 	<cfselect name="originCountry" id="originCountry" class="cfAdminDefault" query="getCountries" value="CountryCode" display="Country" selected="#application.BaseCountry#" />
									<br>
				  				</td>
				  				<td valign="top" bgcolor="999999"><b>Destination Country:</b><br>
									<cfselect name="destCountry" class="cfAdminDefault" query="getCountries" value="CountryCode" display="Country" selected="#application.BaseCountry#" />
								</td>
							</tr>
							<tr valign="top">
				  				<td colspan="2" class="cfAdminDefault" height="1" background="../images/borderDashes.gif"><img src="../images/spacer.gif" width="1" height="1" /></td>
							</tr>
							<tr valign="top">
								<td style="background-color:##CCCCCC;" class="cfAdminDefault"><b>Origin City:</b><br>
									 <cfinput name="originCity" type="text" class="cfAdminDefault" id="originCity" value="#application.CompanyCity#" size="20" maxlength="50" required="yes" message="Please enter an origin Zip/Post code" />
				  				</td>
				  				<td bgcolor="999999" class="cfAdminDefault"><b>Destination City:</b><br>
					  				 <cfinput name="destCity" type="text" class="cfAdminDefault" id="destCity" value="" size="20" maxlength="50" required="yes" message="Please enter an origin Zip/Post code" />
				  				</td>
							</tr>
							<tr valign="top">
				  				<td colspan="2" class="cfAdminDefault" height="1" background="../images/borderDashes.gif"><img src="../images/spacer.gif" width="1" height="1" /></td>
							</tr>
							<tr valign="top">
								<td style="background-color:##CCCCCC;"> <b>Origin State:</b><br>
								  <select name="OriginState" class="cfAdminDefault">
									  <option value="">Please Choose
									  <option value="">****************
									  <option value="CA" selected>California
									<cfoutput query="getStates">
									  <option value="#stateCode#">#State#</option>
									</cfoutput>
								  </select>
								</td>
								<td bgcolor="999999"><b>Destination State:</b><br>
								  <select name="DestinationState" class="cfAdminDefault">
									  <option value="" selected>Please Choose
									  <option value="">****************
									<cfoutput query="getStates">
									  <option value="#stateCode#">#State#</option>
									</cfoutput>
								  </select>
								</td>
							</tr>
							<tr valign="top">
				  				<td colspan="2" class="cfAdminDefault" height="1" background="../images/borderDashes.gif"><img src="../images/spacer.gif" width="1" height="1" /></td>
							</tr>
							<tr>
								<td valign="top" style="background-color:##CCCCCC;"><b>Origin Zip/Postcode:</b><br>
									<cfinput name="originZip" type="text" value="#application.DefaultOriginZipcode#" size="10" maxlength="9" required="yes" message="Please enter an origin Zip/Post code" class="cfAdminDefault" id="originZip" />
								</td>
				  				<td valign="top" bgcolor="999999"><b>Destination Zip/Postcode:</b><br>
									<cfinput name="destZip" type="text" value="" size="10" maxlength="9" required="yes" message="Please enter an destination Zip/Post code" class="cfAdminDefault" id="destZip" />
				  				</td>
							</tr>
							<tr>
				  				<td height="18" colspan="2" bgcolor="551C00" class="cfAdminHeaderUPS1">Shipment Information</td>
							</tr>
							<cfif IsDefined("NumOfPackages") AND NumOfPackages gte 1>
							<cfloop from="1" to="#NumOfPackages#" index="i">
							<tr>
							  <td colspan="2" bgcolor="EEEEEE" class="cfAdminDefault">
									<b>Package Weight (<cfoutput>#i#</cfoutput>):
									<input name="weight" type="text" value="" size="3" maxlength="3" required="yes" message="Package weight must be a valid number 1 through 150" validate="integer" id="weight" class="cfAdminDefault" />
									</b>
							  </td>
							</tr>
							</cfloop>
							</cfif>
							<tr>
							  <td colspan="2" bgcolor="EEEEEE" class="cfAdminDefault">Package Weight Unit of measurement: <b>
							  <select name="weightUnit" class="cfAdminDefault">
								<option value="LBS" selected="selected">LBS</option>
								<option value="KGS">KGS</option>
							  </select>
							  </b></td>
							</tr>
							<tr valign="top">
							  <td colspan="2" class="cfAdminDefault" height="1" background="../images/borderDashes.gif"><img src="../images/spacer.gif" width="1" height="1" /></td>
							</tr>
							<cfif IsDefined("NumOfPackages") AND NumOfPackages gte 1>
								<cfloop from="1" to="#NumOfPackages#" index="j">
								<tr>
								  <td colspan="2" bgcolor="EEEEEE" class="cfAdminDefault"><b>Package Dimensions (<cfoutput>#j#</cfoutput>):
										L <input name="length" type="text" value="" size="3" maxlength="3" required="yes" message="Length dimension must be a valid number 1 through 108" validate="integer" id="length" class="cfAdminDefault" />
										W <input name="width" type="text" value="" size="3" maxlength="3" required="yes" message="Width dimension must be a valid number 1 through 108" validate="integer" id="width" class="cfAdminDefault" />
										H <input name="height" type="text" value="" size="3" maxlength="3" required="yes" message="Height dimension must be a valid number 1 through 108" validate="integer" id="height" class="cfAdminDefault" />
										</b>
								  </td>
								</tr>
								</cfloop>
							</cfif>
							<tr>
							  <td colspan="2" bgcolor="EEEEEE" class="cfAdminDefault">Package Unit Of Measurement: <b>
								<select name="PackageMeasurement" class="cfAdminDefault">
								  <option value="IN" selected="selected">Inches</option>
								  <option value="CM">Centimetres</option>
								</select>
							  </b></td>
							</tr>
							<tr valign="top">
							  <td colspan="2" class="cfAdminDefault" height="1" background="../images/borderDashes.gif"><img src="../images/spacer.gif" width="1" height="1" /></td>
							</tr>
							<cfif IsDefined("NumOfPackages") AND NumOfPackages gte 1>
							<cfloop from="1" to="#NumOfPackages#" index="k">
							<tr>
							  <td colspan="2" bgcolor="EEEEEE" class="cfAdminDefault">Insured
								Value (<cfoutput>#k#</cfoutput>):
							  <input name="insuredValue" type="text" class="cfAdminDefault" value="0" size="8" maxlength="7" /></td>
							</tr>
							</cfloop>
							</cfif>
							<tr valign="top">
							  <td colspan="2" class="cfAdminDefault" height="1" background="../images/borderDashes.gif"><img src="../images/spacer.gif" width="1" height="1" /></td>
							</tr>
							<tr>
							  <td colspan="2" bgcolor="EEEEEE" class="cfAdminDefault"><b>Packaging Type: </b>
								<select name="packageType" class="cfAdminDefault">
								  <option value="02" selected="selected">Your Packaging</option>
								  <option value="01">UPS letter</option>
								  <option value="04">UPS Pak</option>
								  <option value="03">UPS Tube</option>
								  <option value="21">UPS Express Box</option>
								  <option value="25">UPS 10kg Box</option>
								  <option value="24">UPS 25kg Box</option>
								</select></td>
							</tr>
							<tr valign="top">
							  <td colspan="2" class="cfAdminDefault" height="1" background="../images/borderDashes.gif"><img src="../images/spacer.gif" width="1" height="1" /></td>
							</tr>
							<tr>
							  <td colspan="2" bgcolor="EEEEEE" class="cfAdminDefault"><b>Special Services:</b><br>
								Sat Delivery
								  <input name="ssSatDeliv" type="checkbox" id="ssSatDeliv" value="1" />
								Residential Delivery
								<input name="ssResDeliv" type="checkbox" id="ssResDeliv" value="1" />
							  </td>
							</tr>
							<tr valign="top">
							  <td colspan="2" class="cfAdminDefault" height="1" background="../images/borderDashes.gif"><img src="../images/spacer.gif" width="1" height="1" /></td>
							</tr>
							<tr align="center">
							  <td colspan="2" bgcolor="551C00"><input name="rateRequest" type="submit" id="rateRequest" value="GET RATES" class="cfAdminDefault" />
							</td>
							</tr>
						  </cfform>
							<tr align="center">
							  <td height="18" colspan="2" bgcolor="AE3800" class="cfAdminHeader4"><b>Do you want to rate a multi-piece shipment?</b></td>
							</tr>
							<form action="<cfoutput>#CGI.SCRIPT_NAME#</cfoutput>" method="post">
							<tr align="center" bgcolor="EEEEEE">
							  <td height="18" colspan="2" class="cfAdminDefault">How many packages: 
							  <select name="NumOfPackages" class="cfAdminDefault">
								  <option value="1" selected>1
								  <option value="2">2
								  <option value="3">3
								  <option value="4">4
								  <option value="5">5
								  <option value="6">6
								  <option value="7">7
							  </select>
							  <input name="packageCount" type="submit" id="packageCount" value="Set Package Count" class="cfAdminDefault" /></td>
							</tr>
							</form>				
						</table>
		  			</td>
					<td width="1" bgcolor="993300"></td>
					<td valign="top" bgcolor="FFFFFF">
						<form name="form1" id="form1" method="post" action="indexUPS.cfm">
							<input type="hidden" name="function" value="trackRequest">
			  				<u>Type Tracking Number below</u>:<br>
						  	<input type="text" name="trackingNum" size="25" maxlength="24" class="cfAdminDefault">
						  	<select name="trackDetail" id="trackDetail" class="cfAdminDefault">
								<option value="activity">All Activity</option>
								<option value="none">No Activity</option>
						  	</select>
						  	<br>
						  	<input name="TrackRequest" type="submit" id="TrackRequest" value="Track" class="cfAdminDefault" />
						</form>
					</td>
					
				</tr>
	  		</table>
		</td>
  	</tr>
</table>


<cfscript>
		  	if ( IsDefined("ssSatDeliv") ) { SatDelivery = "1"; }
			else { SatDelivery = "0"; }
			if ( IsDefined("ssResDeliv") ) { ResDelivery = "1"; }
			else { ResDelivery = "0"; }
			if ( IsDefined("weightUnit") AND weightUnit eq "KGS" ) { PackageMeasurement = "CM"; }
			else { PackageMeasurement = "IN"; }			
</cfscript>
		
<!--- Rate shop request --->
<cfif IsDefined("originZip") AND IsDefined("destZip") AND IsDefined("function") AND function eq "rateShopRequest">
	
	<cf_TagUPS function="rateShopRequest"
		upsaccesskey="#AccessKey#"
		upsuserid="#Userid#"
		upspassword="#Password#"
		shipperstate="#OriginState#"
		shipperzip="#originZip#"
		shippercountry="#originCountry#"
		shiptostate="#DestinationState#"
		shiptozip="#destZip#"
		shiptocountry="#destCountry#"
		packageweight="#weight#"
		packageweightunit="#weightUnit#"
		packageunitofmeasurement="#PackageMeasurement#"
		packagelength="#length#"
		packagewidth="#width#"
		packageheight="#height#"
		packagecode="#packageType#"
		saturdaydelivery="#SatDelivery#"
		residentialaddress="#ResDelivery#"
		insuredvalue="#Trim(insuredValue)#"
		debug="False"
	>
	<br>
	<table width="80%" border="0" align="center" cellpadding="1" cellspacing="0" style="background-color:##CCCCCC;">
	  <tr>
		<td><table width="100%" border="0" cellspacing="0" cellpadding="0">
		  <tr>
			<td height="18" bgcolor="FFFFFF" class="cfAdminDefault">
			
			<cfif IsDefined("UPSRateShopError") AND UPSRateShopError neq 0>
				<cfif IsDefined("UPSResponseDesc")><cfoutput>#UPSResponseDesc#</cfoutput><br></cfif>
				Error Notes
				<cfif IsDefined("UPSErrorDescription")>: <font color="Red"><cfoutput>#UPSErrorDescription#</cfoutput></font>				  
				<cfif IsDefined("UPSErrorCode")>(<cfoutput>#UPSErrorCode#</cfoutput>)</cfif></cfif>
			<cfelse>
				Rate Results below:
			</cfif>
			<!--- <cfoutput><cfdump var="#stUpsRatesShop#"></cfoutput> --->
			<!--- <cf_objectdump object="#stUpsTNT#"> --->
			</td>
		  </tr>
		  <tr>
			<td>
			<!--- Rate Shop Results start --->
			<cfif IsDefined("rateShopQuery")>	
			<table width="100%" border="0" cellspacing="1" cellpadding="0">
			  <tr>
				<td bgcolor="EEEEEE" class="cfAdminDefault"><b>Package #</b></td>
				<td height="20" bgcolor="EEEEEE" class="cfAdminDefault"><b>Service</b></td>
				<td bgcolor="EEEEEE" class="cfAdminDefault"><b>Billable Weight (Orig. Weight)</b></td>
				<td bgcolor="EEEEEE" class="cfAdminDefault"><b>Guaranteed Delivery</b></td>
				<td bgcolor="EEEEEE" class="cfAdminDefault"><b>Surcharges</b></td>
				<td bgcolor="EEEEEE" class="cfAdminDefault"><b>Package Charge</b></td>
				<td bgcolor="EEEEEE" class="cfAdminDefault"><b>Total Charges</b></td>
				</tr>
			  <cfoutput query="rateShopQuery">
			  <tr>
				<td bgcolor="##FFFFFF" class="cfAdminDefault">(#PackageID# of #NumOfPackages#)</td>
				<td height="18" bgcolor="##FFFFFF" class="cfAdminDefault">
				<cfquery dbtype="query" name="Services">
						SELECT * 
						FROM ServiceLevelQuery 
						WHERE (ServiceLevelCode = #rateShopQuery.ServiceLevel#)
				</cfquery>
				#Services.ServiceLevelDesc#
				</td>
				<td bgcolor="##FFFFFF" class="cfAdminDefault"><cfif BillableWeight gt 0>#BillableWeight# #WeightUnit#</cfif> (#OriginalWeight#)</td>
				<td bgcolor="##FFFFFF" class="cfAdminDefault"><cfif Len(GuaranteedDTD) eq 0>*<cfelse>#GuaranteedDTD# Days</cfif></td>
				<td bgcolor="##FFFFFF" class="cfAdminDefault">#DollarFormat(OptionCharges)#</td>
				<td bgcolor="##FFFFFF" class="cfAdminDefault">#DollarFormat(PackageTotalCharges)#</td>
				<td bgcolor="##FFFFFF" class="cfAdminDefault">#DollarFormat(TotalCharges)# #TotalChargesCurrency#</td>
				</tr>
				</cfoutput>
			</table>
			</cfif>
			<!--- Rate Shop Results End --->
			</td>
		  </tr>
		  
		</table></td>
	  </tr>
  </table>
  <br>
  <!--- Time In Transit results start --->
  <cf_TagUPS function="tntRequest"
		upsaccesskey="#AccessKey#"
		upsuserid="#Userid#"
		upspassword="#Password#"
		shippercity="#originCity#"
		shipperstate="#OriginState#"
		shipperzip="#originZip#"
		shippercountry="#originCountry#"
		shiptocity="#destCity#"
		shiptostate="#DestinationState#"
		shiptozip="#destZip#"
		shiptocountry="#destCountry#"
		residentialaddress="#SatDelivery#"
		packageweight="#ListGetAt(weight,1)#"
		packageweightunit="#weightUnit#"
	>
	
  <table width="80%" border="0" align="center" cellpadding="1" cellspacing="0" style="background-color:##CCCCCC;">
	  <tr>
		<td><table width="100%" border="0" cellspacing="0" cellpadding="0">
		  <tr>
			<td height="18" bgcolor="FFFFFF" class="cfAdminDefault">
			
			<cfif IsDefined("UPSRateShopError") AND UPSRateShopError neq 0>
				<cfif IsDefined("UPSResponseDesc")><cfoutput>#UPSResponseDesc#</cfoutput><br></cfif>
				Error Notes
				<cfif IsDefined("UPSErrorDescription")>: <font color="Red"><cfoutput>#UPSErrorDescription#</cfoutput></font>				  
				<cfif IsDefined("UPSErrorCode")>(<cfoutput>#UPSErrorCode#</cfoutput>)</cfif></cfif>
			<cfelse>
				Time In Transit information below:
			</cfif>
			<!--- <cfoutput><cf_objectdump object="#stUpsTNT#"></cfoutput> --->
			</td>
		  </tr>
		  <tr>
			<td>
			<!--- Rate Shop Results start --->
			<cfif IsDefined("TntQuery")>
			 	
			<table width="100%" border="0" cellspacing="1" cellpadding="0">
			  <tr>
				<td height="20" bgcolor="EEEEEE" class="cfAdminDefault"><b>Service</b></td>
				<td bgcolor="EEEEEE" class="cfAdminDefault"><b>Estimated Delivery Date</b></td>
				<td bgcolor="EEEEEE" class="cfAdminDefault"><b>Service Guaranteed</b></td>
				<td bgcolor="EEEEEE" class="cfAdminDefault"><b>Delivery Days</b></td>
				</tr>
			  <cfoutput query="TntQuery">
			  
			  <tr>
				<td height="18" bgcolor="##FFFFFF" class="cfAdminDefault">
				#ServiceDesc# [#ServiceCode#]
				</td>
				<td bgcolor="##FFFFFF" class="cfAdminDefault">
				<cf_TagDateConvert datetimevalue="#EstDelivDate#" datetimetype="YYYY-MM-DD">
				   #DateFormat(DateTimeConverted, "mmm dd, yyyy")#
				</td>
				<td bgcolor="##FFFFFF" class="cfAdminDefault">#ServiceGuaranteed#</td>
				<td bgcolor="##FFFFFF" class="cfAdminDefault">#BusinessDays#</td>
				</tr>

				</cfoutput>
			</table>
			<cfelse>
				<!--- Address was not validated, candidate addresses are displayed --->
			  	<cfif IsDefined("AddressFromCandidateQuery")>
					<table width="100%" border="0" cellspacing="1" cellpadding="0">
					  <tr bgcolor="FFBBBB">
						<td height="20" colspan="4" class="cfAdminDefault"><b>Origin
						  Address</b> could not be validated, please see candidates
						  below for the zip entered</td>
					  </tr>
					  <tr>
						<td height="20" bgcolor="CECEB5" class="cfAdminDefault">City</td>
						<td bgcolor="CECEB5" class="cfAdminDefault">State</td>
						<td bgcolor="CECEB5" class="cfAdminDefault">Zipcode Low</td>
						<td bgcolor="CECEB5" class="cfAdminDefault">Zipcode High</td>
					  </tr>
					  <cfoutput query="AddressFromCandidateQuery">
					  <tr>
						<td height="18" bgcolor="##FFFFFF" class="cfAdminDefault">#CandidateCity# #CandidateTown#</td>
						<td bgcolor="##FFFFFF" class="cfAdminDefault">#CandidateState#</td>
						<td bgcolor="##FFFFFF" class="cfAdminDefault">#CandidateZipLow#</td>
						<td bgcolor="##FFFFFF" class="cfAdminDefault">#CandidateZipHigh#</td>
					  </tr>
					  </cfoutput>
					</table>
				</cfif>
				  <cfif IsDefined("AddressToCandidateQuery")>
				  	<table width="100%" border="0" cellspacing="1" cellpadding="0">
					  <tr bgcolor="FFBBBB">
						<td height="20" colspan="4" class="cfAdminDefault"><b>Destination
							Address</b> could not be validated, please see candidates below
						for the zip entered</td>
					  </tr>
					  <tr>
						<td height="20" bgcolor="CECEB5" class="cfAdminDefault">City</td>
						<td bgcolor="CECEB5" class="cfAdminDefault">State</td>
						<td bgcolor="CECEB5" class="cfAdminDefault">Zipcode Low</td>
						<td bgcolor="CECEB5" class="cfAdminDefault">Zipcode High</td>
					  </tr>
					  <cfoutput query="AddressToCandidateQuery">
					  <tr>
						<td height="18" bgcolor="##FFFFFF" class="cfAdminDefault">#CandidateCity# #CandidateTown#</td>
						<td bgcolor="##FFFFFF" class="cfAdminDefault">#CandidateState#</td>
						<td bgcolor="##FFFFFF" class="cfAdminDefault">#CandidateZipLow#</td>
						<td bgcolor="##FFFFFF" class="cfAdminDefault">#CandidateZipHigh#</td>
					  </tr>
					  </cfoutput>
					</table>
				 </cfif>
				 <!--- Address was not validated, candidate addresses are displayed --->
			</cfif>
			<!--- Rate Shop Results End --->
			</td>
		  </tr>
		  <tr>
			<td bgcolor="FFFFFF" class="cfAdminDefault">
			<cfif IsDefined("UPSDisclaimer")><cfoutput>#UPSDisclaimer#</cfoutput></cfif>
			</td>
		  </tr>
		</table></td>
	  </tr>
  </table>	
  <!--- Time In Transit results End --->

<cfelseif IsDefined("function") AND function eq "trackRequest">
	
	<cfscript>	
	trackingNum = #ReReplace(trackingNum, "[[:blank:]]", "", "all")#; // temporary to test on 1 tracking number
	tmpTrackNumberList = #Trim(trackingNum)#;
	tmpTrackNumberList = #ReReplace(tmpTrackNumberList, "[[:blank:]]", ",", "all")#;
	tmpTrackNumberList = #ReReplace(tmpTrackNumberList, "[[:space:]]", ",", "all")#;
	tmpTrackNumberList = #ReReplace(tmpTrackNumberList, ",,", ",", "all")#;
	TrackNumberListLen = #ListLen(tmpTrackNumberList)#;
	vTrackNumberArray = ArrayNew(1);
	vTrackNumberArray = ListToArray(tmpTrackNumberList, ",");
	if (TrackNumberListLen eq 1) {
		trackingNum = tmpTrackNumberList;
	}
	tmpArrayLen = ArrayLen(vTrackNumberArray);
	</cfscript>	
   
   
	<!--- <cfif TrackNumberListLen eq 1>	
		<cf_TagUPS function="trackRequest"
		TrackingNumber="#Trim(trackingNum)#"
		>
	</cfif> --->

	<cfif trackDetail eq "activity">
	 <cf_TagUPS function="trackRequest"
	 	upsaccesskey="#AccessKey#"
		upsuserid="#Userid#"
		upspassword="#Password#"
		trackingnumber="#Trim(trackingNum)#"
		debug="False"
		>
	<cfelse>
	 <cf_TagUPS function="trackNoActivityRequest"
	 	upsaccesskey="#AccessKey#"
		upsuserid="#Userid#"
		upspassword="#Password#"
		trackingnumber="#Trim(trackingNum)#"
		>
	</cfif>
	<!--- <cfoutput>
		<cf_objectdump object="#stUpsTrack#"> <hr>
	</cfoutput> --->
	<br>
	<br>
	<!--- Start Tracking Results display --->
	<cfif IsDefined("UPSTrackError") AND UPSTrackError eq 0>
		   <cfif IsDefined("PackageListQuery")>
				<cfoutput query="PackageListQuery">
				#PackageListQuery.Weight# #PackageListQuery.WeightUnit# #PackageListQuery.TrackingNumber#
				<br>
				<cfwddx action="wddx2cfml" input="#PackageListQuery.ActivityQuery#" output="MultiPackageActivityQuery">
				<!--- #MultiPackageActivityQuery.ColumnList#<br>
				ACTIVITYDATE: #MultiPackageActivityQuery.ACTIVITYDATE#<br>
				ADDRESSCITY: #MultiPackageActivityQuery.ADDRESSCITY# --->
				<hr>
				</cfoutput>
		   </cfif>
	<table width="80%" border="0" align="center" cellpadding="1" cellspacing="0" bgcolor="333333">
	  <tr>
		<td><table width="100%" border="0" cellspacing="0" cellpadding="0">
		  <tr>
			<td height="20" colspan="2" bgcolor="993300" class="cfAdminHeaderUPS1">Tracking Results</td>
		  </tr>
		  <cfoutput>
		  <tr>
			<td width="25%" valign="top" bgcolor="##FFFFFF" class="cfAdminDefault"><b>Shipper Address:</b></td>
			<td width="75%" bgcolor="##FFFFFF" class="cfAdminDefault">
			<cfif IsDefined("UPSShipperAddress1")>#UPSShipperAddress1#</cfif><br>  
			<cfif IsDefined("UPSShipperAddress2")>#UPSShipperAddress2#<br></cfif> <cfif IsDefined("UPSShipperAddress3")>#UPSShipperAddress3#<br></cfif> 
			<cfif IsDefined("UPSShipperCity")>#UPSShipperCity#<br></cfif> 
			<cfif IsDefined("UPSShipperState")>#UPSShipperState# #UPSShipperZip#<br></cfif>  
			<cfif IsDefined("UPSShipperCountry")>#UPSShipperCountry#</cfif>																																																																																																																																																																																																																																																												
			</td>
		  </tr>
		  <tr>
			<td height="18" bgcolor="##FFFFFF" class="cfAdminDefault"><b>Package Weight:</b></td>
			<td bgcolor="##FFFFFF" class="cfAdminDefault">
			<cfif IsDefined("UPSPackageWeight")>#UPSPackageWeight# (#UPSPackageWeightUnit#)</cfif>
			</td>
		  </tr>
		  <tr>
			<td height="18" bgcolor="##FFFFFF" class="cfAdminDefault"><b>Shipping
				Date:</b></td>
			<td bgcolor="##FFFFFF" class="cfAdminDefault"> 
			<cfif IsDefined("UPSPickupDate") AND Len(Trim(UPSPickupDate)) neq 0>
			<cf_TagDateConvert datetimevalue="#UPSPickupDate#" datetimetype="YYYYMMDD">
				#DateFormat(DateTimeConverted, "mmm dd, yyyy")#
			</cfif>
			</td>
			</tr>
		  <tr>
			<td height="18" bgcolor="##FFFFFF" class="cfAdminDefault"><b>Estimated
				Delivery Date:</b></td>
			<td bgcolor="##FFFFFF" class="cfAdminDefault"> 
			<cfif IsDefined("UPSEstimatedDelivDate") AND Len(Trim(UPSEstimatedDelivDate)) neq 0>
			<cf_TagDateConvert datetimevalue="#UPSEstimatedDelivDate#" datetimetype="YYYYMMDD">
				#DateFormat(DateTimeConverted, "mmm dd, yyyy")#
			</cfif>
			<cfif IsDefined("UPSEstimatedDelivTime") AND Len(Trim(UPSEstimatedDelivTime)) neq 0>
			<cf_TagDateConvert datetimevalue="#UPSEstimatedDelivTime#" datetimetype="HHMMSS">
				#TimeFormat(DateTimeConverted, "h:mm tt")#
			</cfif></td>
			</tr>
		  <!--- Delivery Date --->
		   <cfif IsDefined("TrackActivityQuery")>	
			<cfquery dbtype="query" name="DeliveryDate">
				SELECT StatusTypeCode, ActivityDate FROM TrackActivityQuery 
				WHERE (StatusTypeCode = 'D')
		  	</cfquery>
		  	<cfif DeliveryDate.RecordCount neq 0>
		   </cfif>
		  <tr>
			<td height="18" bgcolor="##FFFFFF" class="cfAdminDefault"><b>Delivery
				Date:</b></td>
			<td bgcolor="##FFFFFF" class="cfAdminDefault">
			  <cfif IsDefined("DeliveryDate.ActivityDate") AND Len(Trim(DeliveryDate.ActivityDate)) neq 0>
			  <cf_TagDateConvert datetimevalue="#DeliveryDate.ActivityDate#" datetimetype="YYYYMMDD"> #DateFormat(DateTimeConverted,
				"mmm dd, yyyy")#
			  </cfif>
			</td>
			</tr>
			</cfif>
		  <!--- End Delivery Date --->
		  <!--- Signed For By --->
		   <cfif IsDefined("TrackActivityQuery")> 
			<cfquery dbtype="query" name="SignedBy">
				SELECT StatusTypeCode, LocationSignedBy FROM TrackActivityQuery 
				WHERE (StatusTypeCode = 'D')
		  	</cfquery>
		  <tr>
			<td height="18" bgcolor="##FFFFFF" class="cfAdminDefault"><b>Signed
				For By:</b></td>
			<td bgcolor="##FFFFFF" class="cfAdminDefault">
			  #SignedBy.LocationSignedBy#
			</td>
			</tr>
		  </cfif>
		  <!--- End Signed For By --->
		  <tr>
			<td height="18" bgcolor="##FFFFFF" class="cfAdminDefault"><b>Tracking
				Number:</b></td>
			<td bgcolor="##FFFFFF" class="cfAdminDefault"><cfif IsDefined("UPSTrackingNumber")>#UPSTrackingNumber#</cfif></td>
		  </tr>
		  <cfif IsDefined("UPSServiceDesc")>
		  <tr>
			<td height="18" bgcolor="##FFFFFF" class="cfAdminDefault"><b>Service
				Level:</b></td>
			<td bgcolor="White" class="cfAdminDefault">#UPSServiceDesc#</td>
		  </tr>
		  </cfif>
		  </cfoutput>
		  <tr>
			<td height="1" colspan="2"></td>
		  </tr>
		  <cfif IsDefined("TrackActivityQuery")>
		  <tr align="left">
			<td height="20" colspan="2" class="cfAdminHeaderUPS1">Package Activity</td>
		  </tr>
		  <tr>
			<td height="20" colspan="2" class="cfAdminDefault">
			<table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="#CCCCCC">
			  <tr bgcolor="C1A2A2">
				<td height="18" class="cfAdminDefault">Date</td>
				<td class="cfAdminDefault">Time</td>
				<td class="cfAdminDefault">Location</td>
				<td class="cfAdminDefault">Activity</td>
			  </tr>
			  <!---  TrackActivityQuery
			 	Query Columns: (will all be available some may be empty strings)
				AddressCity
				AddressState
				AddressZip
				AddressCountry
				LocationDesc
				LocationSignedBy
				ActivityDate
				ActivityTime
				StatusTypeDesc
				StatusTypeCode  --->
		 
			  <cfoutput query="TrackActivityQuery">
				<tr <cfif (TrackActivityQuery.CurrentRow MOD 2) gt 0>bgcolor="##EEEEEE"<cfelse>bgcolor="White"</cfif>>
				  <td height="17" nowrap="nowrap" class="cfAdminDefault"> 
				  <cf_TagDateConvert datetimevalue="#ActivityDate#" datetimetype="YYYYMMDD">
				   #DateFormat(DateTimeConverted, "mmm dd, yyyy")#				   </td>
				  <td nowrap="nowrap" class="cfAdminDefault"> <cf_TagDateConvert datetimevalue="#ActivityTime#" datetimetype="HHMMSS"> #TimeFormat(DateTimeConverted,
					"h:mm tt")# </td>
				  <td class="cfAdminDefault"><cfif Len(AddressCity) neq 0 AND Len(AddressState) neq 0>
					  #AddressCity#, #AddressState#&nbsp;
					</cfif>
					#AddressCountry#</td>
				  <td class="cfAdminDefault">
					<cfswitch expression="#StatusTypeCode#">
					  <cfcase value="I">
					  In Transit
					  </cfcase>
					  <cfcase value="X">
					  Exception
					  </cfcase>
					  <cfcase value="P">
					  Pickup
					  </cfcase>
					  <cfcase value="M">
					  Manifest pickup
					  </cfcase>
					  <cfcase value="D">
					  Delivered
					  </cfcase>
					</cfswitch>
					<font color="##996633" size="1">[#StatusTypeDesc#]</font>
					<cfif Len(LocationSignedBy) neq 0>Signed For By: #LocationSignedBy#</cfif>
					</td>
				</tr>
			  </cfoutput>
			</table>
			</td>
		  </tr>
		  <cfelseif IsDefined("MultiPackageActivityQuery")>
		  YES
		  <cfloop query="MultiPackageActivityQuery">
		  <tr align="left">
			<td height="20" colspan="2" class="cfAdminHeaderUPS1">Package Activity</td>
		  </tr>
		  <tr>
			<td height="20" colspan="2" class="cfAdminDefault">
			<table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="#CCCCCC">
			  <tr bgcolor="C1A2A2">
				<td height="18" class="cfAdminDefault">Date</td>
				<td class="cfAdminDefault">Time</td>
				<td class="cfAdminDefault">Location</td>
				<td class="cfAdminDefault">Activity</td>
			  </tr>
			  <!---  TrackActivityQuery
			 	Query Columns: (will all be available some may be empty strings)
				AddressCity
				AddressState
				AddressZip
				AddressCountry
				LocationDesc
				LocationSignedBy
				ActivityDate
				ActivityTime
				StatusTypeDesc
				StatusTypeCode  --->
		 
			  <cfoutput query="TrackActivityQuery">
				<tr <cfif (TrackActivityQuery.CurrentRow MOD 2) gt 0>bgcolor="##EEEEEE"<cfelse>bgcolor="White"</cfif>>
				  <td height="17" nowrap="nowrap" class="cfAdminDefault"> 
				  <cf_TagDateConvert datetimevalue="#ActivityDate#" datetimetype="YYYYMMDD">
				   #DateFormat(DateTimeConverted, "mmm dd, yyyy")#				   </td>
				  <td nowrap="nowrap" class="cfAdminDefault"> <cf_TagDateConvert datetimevalue="#ActivityTime#" datetimetype="HHMMSS"> #TimeFormat(DateTimeConverted,
					"h:mm tt")# </td>
				  <td class="cfAdminDefault"><cfif Len(AddressCity) neq 0 AND Len(AddressState) neq 0>
					  #AddressCity#, #AddressState#&nbsp;
					</cfif>
					#AddressCountry#</td>
				  <td class="cfAdminDefault">
					<cfswitch expression="#StatusTypeCode#">
					  <cfcase value="I">
					  In Transit
					  </cfcase>
					  <cfcase value="X">
					  Exception
					  </cfcase>
					  <cfcase value="P">
					  Pickup
					  </cfcase>
					  <cfcase value="M">
					  Manifest pickup
					  </cfcase>
					  <cfcase value="D">
					  Delivered
					  </cfcase>
					</cfswitch>
					<font color="##996633" size="1">[#StatusTypeDesc#]</font>
					<cfif Len(LocationSignedBy) neq 0>Signed For By: #LocationSignedBy#</cfif>
					</td>
				</tr>
			  </cfoutput>
			</table>
			</td>
		  </tr>
		  </cfloop>
		  </cfif>
		</table>
		</td>
	  </tr>
  </table>
  <cfelseif IsDefined("UPSErrorDescription")><font color="Red"><img src="../images/missing-field.gif" width="24" height="25" align="absbottom" /><cfoutput>#UPSErrorDescription#</cfoutput></font>
  <cfelse>
  	<font color="Red"><img src="../images/missing-field.gif" width="24" height="25" align="absbottom" /></font>Tracking information currently available
  </cfif>
  <!--- End Tracking Results display --->	
</cfif>

<cfinclude template="LayoutShipFooter.cfm">
