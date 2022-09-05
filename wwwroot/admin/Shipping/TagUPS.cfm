<!--- XML Scripts CFMX VERSION --->

<!--- PREMIUM VARIABLES NEEDED/OPTIONAL --->
<cfscript>
	currPath = ExpandPath("*.*");
	tempCurrDir = GetDirectoryFromPath(currPath);
	if ( CGI.SERVER_SOFTWARE CONTAINS "Microsoft" ) { 
		trailingSlash = '\'; 
		dirPathLen = Len(tempCurrDir) - 1;
		currentWorkingDir = Left(tempCurrDir, dirPathLen);
	}
	else { 
		trailingSlash = '/';
		dirPathLen = Len(tempCurrDir) - 1;
		currentWorkingDir = Left(tempCurrDir, dirPathLen);
	}
</cfscript>
<cfparam name="ATTRIBUTES.ServerFilePath" default="#currentWorkingDir#">
<cfparam name="ATTRIBUTES.TestingEnvironment" default="TRUE">
<cfif ATTRIBUTES.TestingEnvironment eq "TRUE">
	<cfset ATTRIBUTES.tntServer = "https://wwwcie.ups.com/ups.app/xml/TimeInTransit">
	<cfset ATTRIBUTES.rateServer = "https://wwwcie.ups.com/ups.app/xml/Rate">
	<cfset ATTRIBUTES.trackServer = "https://wwwcie.ups.com/ups.app/xml/Track">
<cfelse>
	<cfset ATTRIBUTES.tntServer = "https://www.ups.com/ups.app/xml/TimeInTransit">
	<cfset ATTRIBUTES.rateServer = "https://www.ups.com/ups.app/xml/Rate">
	<cfset ATTRIBUTES.trackServer = "https://www.ups.com/ups.app/xml/Track">
</cfif>

<cfparam name="ATTRIBUTES.ShipperAccountNumber" default=""> <!--- ** PREMIUM ** required for Shipping request --->
<cfparam name="ATTRIBUTES.LabelPrintMethod" default="GIF"> <!--- GIF or EPL --->
<cfparam name="ATTRIBUTES.LabelSizeHeight" default="4"> <!--- valid value is 4 --->
<cfparam name="ATTRIBUTES.LabelSizeWidth" default="6"> <!--- valid values are 6 or 8 --->
<cfparam name="ATTRIBUTES.ShipmentDescription" default="Description of item contents"> <!--- required for international shipping label --->
<cfparam name="ATTRIBUTES.PackageReferenceCode" default=""> <!--- IK: Invoice Number --->
<cfparam name="ATTRIBUTES.PackageReferenceValue" default="">
<cfparam name="ATTRIBUTES.PackageReferenceCode2" default=""> <!--- IK: Invoice Number --->
<cfparam name="ATTRIBUTES.PackageReferenceValue2" default="">
<cfparam name="ATTRIBUTES.PackageReferenceCode3" default=""> <!--- IK: Invoice Number --->
<cfparam name="ATTRIBUTES.PackageReferenceValue3" default="">
<cfparam name="ATTRIBUTES.InvoiceCurrencyCode" default="USD"> <!--- Packages to PR OR CA Only --->
<cfparam name="ATTRIBUTES.InvoiceAmount" default="0"> <!--- Packages to PR OR CA Only --->
<cfparam name="ATTRIBUTES.SignatureTrackingOption" default="15">
<cfparam name="ATTRIBUTES.PaymentType" default="BillShipperAccount">
<cfparam name="ATTRIBUTES.PaymentCreditCardType" default="">
<cfparam name="ATTRIBUTES.PaymentCreditCardNumber" default="">
<cfparam name="ATTRIBUTES.PaymentCreditCardExpiration" default="">
<cfparam name="ATTRIBUTES.PaymentBillThirdPartyAccount" default="">
<cfparam name="ATTRIBUTES.PaymentBillThirdPartyAddr" default="">
<cfparam name="ATTRIBUTES.PaymentBillThirdPartyZip" default="">
<cfparam name="ATTRIBUTES.PaymentBillThirdPartyCountry" default="US">
<cfparam name="ATTRIBUTES.PaymentFreightCollectAccount" default="">
<cfparam name="ATTRIBUTES.PaymentFreightCollectAddr" default="">
<cfparam name="ATTRIBUTES.PaymentFreightCollectZip" default="">
<cfparam name="ATTRIBUTES.NotificationCode" default="6">
<cfparam name="ATTRIBUTES.NotificationEmailAddress" default="">
<cfparam name="ATTRIBUTES.NotificationUndelivAddress" default="">
<cfparam name="ATTRIBUTES.NotificationFromName" default="">
<cfparam name="ATTRIBUTES.NotificationMemo" default="">
<cfparam name="ATTRIBUTES.NotificationSubjectCode" default="">
<!--- END PREMIUM VARIABLES NEEDED/OPTIONAL --->

<cfparam name="ATTRIBUTES.UPSAccessKey" default="">
<cfparam name="ATTRIBUTES.UPSUserID" default="">
<cfparam name="ATTRIBUTES.UPSPassword" default="">
<cfparam name="ATTRIBUTES.XMLVersion" default="1.0">
<cfparam name="ATTRIBUTES.XPCIVersion" default="1.0002">
<cfparam name="ATTRIBUTES.XPCIVersionPremium" default="1.0001">

<cfparam name="ATTRIBUTES.PickUpType" default="01"> <!--- required Daily Pickup --->
<cfparam name="ATTRIBUTES.ShipperCompanyName" default="">
<cfparam name="ATTRIBUTES.ShipperAttentionName" default="">
<cfparam name="ATTRIBUTES.ShipperAddress1" default="">
<cfparam name="ATTRIBUTES.ShipperAddress2" default="">
<cfparam name="ATTRIBUTES.ShipperAddress3" default="">
<cfparam name="ATTRIBUTES.ShipperCity" default=""> <!--- optional --->
<cfparam name="ATTRIBUTES.ShipperState" default=""> <!--- optional --->
<cfparam name="ATTRIBUTES.ShipperZip" default=""> <!--- required --->
<cfparam name="ATTRIBUTES.ShipperCountry" default="US"> <!--- required 2 digit country code --->
<cfparam name="ATTRIBUTES.ShipperPhoneCountryCode" default="1"> <!--- (USA = 1) The prefix to the phone number indicating which country the phone is located. --->
<cfparam name="ATTRIBUTES.ShipperPhoneAreaCode" default=""> <!--- Ship Request optional --->
<!--- Depends upon the location of the phone,  in North America the Dial 
plan uses area code, other parts of the world use a phone number 
prefix according to the city. --->
<cfparam name="ATTRIBUTES.ShipperPhoneNumber" default=""> <!--- Ship Request optional --->
<!--- For the US it is the seven digits, in all other locations the numbers 
would include the remaining numbers excluding the Area Code. --->
<cfparam name="ATTRIBUTES.ShipperPhoneExtension" default=""> <!--- Ship Request optional --->

<cfparam name="ATTRIBUTES.ShipToCompanyName" default="">
<cfparam name="ATTRIBUTES.ShipToAttentionName" default="">
<cfparam name="ATTRIBUTES.ShipToAddress1" default="">
<cfparam name="ATTRIBUTES.ShipToAddress2" default="">
<cfparam name="ATTRIBUTES.ShipToAddress3" default="">
<cfparam name="ATTRIBUTES.ShipToCity" default=""> <!--- Required if country does not have postcode --->
<cfparam name="ATTRIBUTES.ShipToState" default=""> <!--- optional --->
<cfparam name="ATTRIBUTES.ShipToZip" default=""> <!--- required --->
<cfparam name="ATTRIBUTES.ShipToCountry" default="US"> <!--- required 2 digit country code --->
<cfparam name="ATTRIBUTES.ShipToPhoneAreaCode" default="">
<cfparam name="ATTRIBUTES.ShipToPhoneNumber" default="">
<cfparam name="ATTRIBUTES.ShipToPhoneExtension" default="">
<cfparam name="ATTRIBUTES.ResidentialAddress" default="0"> <!--- Residential delivery address 1 - YES, 0 - No --->
<cfparam name="ATTRIBUTES.ShipFromCompanyName" default="">
<cfparam name="ATTRIBUTES.ShipFromAttentionName" default="">
<cfparam name="ATTRIBUTES.ShipFromAddress1" default="">
<cfparam name="ATTRIBUTES.ShipFromAddress2" default="">
<cfparam name="ATTRIBUTES.ShipFromAddress3" default="">
<cfparam name="ATTRIBUTES.ShipFromCity" default="">
<cfparam name="ATTRIBUTES.ShipFromState" default="">
<cfparam name="ATTRIBUTES.ShipFromZip" default="">
<cfparam name="ATTRIBUTES.ShipFromCountry" default="US">
<cfparam name="ATTRIBUTES.ShipFromPhoneAreaCode" default="">
<cfparam name="ATTRIBUTES.ShipFromPhoneNumber" default="">
<cfparam name="ATTRIBUTES.ShipFromPhoneExtension" default="">
<cfparam name="ATTRIBUTES.ServiceType" default="03"> <!--- Ignored when requesting rate shop --->
<cfset CALLER.ServiceLevelQuery = QueryNew("ServiceLevelCode, ServiceLevelDesc")>
<cfset newRow  = QueryAddRow(CALLER.ServiceLevelQuery, 1)>
<cfset temp = QuerySetCell(CALLER.ServiceLevelQuery, "ServiceLevelCode", "01")>
<cfset temp = QuerySetCell(CALLER.ServiceLevelQuery, "ServiceLevelDesc", "Next Day Air")>
<cfset newRow  = QueryAddRow(CALLER.ServiceLevelQuery, 1)>
<cfset temp = QuerySetCell(CALLER.ServiceLevelQuery, "ServiceLevelCode", "02")>
<cfset temp = QuerySetCell(CALLER.ServiceLevelQuery, "ServiceLevelDesc", "2nd Day Air")>
<cfset newRow  = QueryAddRow(CALLER.ServiceLevelQuery, 1)>
<cfset temp = QuerySetCell(CALLER.ServiceLevelQuery, "ServiceLevelCode", "03")>
<cfset temp = QuerySetCell(CALLER.ServiceLevelQuery, "ServiceLevelDesc", "Ground")>
<cfset newRow  = QueryAddRow(CALLER.ServiceLevelQuery, 1)>
<cfset temp = QuerySetCell(CALLER.ServiceLevelQuery, "ServiceLevelCode", "07")>
<cfset temp = QuerySetCell(CALLER.ServiceLevelQuery, "ServiceLevelDesc", "Worldwide Express")>
<cfset newRow  = QueryAddRow(CALLER.ServiceLevelQuery, 1)>
<cfset temp = QuerySetCell(CALLER.ServiceLevelQuery, "ServiceLevelCode", "08")>
<cfset temp = QuerySetCell(CALLER.ServiceLevelQuery, "ServiceLevelDesc", "Worldwide Expedited")>
<cfset newRow  = QueryAddRow(CALLER.ServiceLevelQuery, 1)>
<cfset temp = QuerySetCell(CALLER.ServiceLevelQuery, "ServiceLevelCode", "11")>
<cfset temp = QuerySetCell(CALLER.ServiceLevelQuery, "ServiceLevelDesc", "Ground Service to Canada")>
<cfset newRow  = QueryAddRow(CALLER.ServiceLevelQuery, 1)>
<cfset temp = QuerySetCell(CALLER.ServiceLevelQuery, "ServiceLevelCode", "12")>
<cfset temp = QuerySetCell(CALLER.ServiceLevelQuery, "ServiceLevelDesc", "3-Day Select")>
<cfset newRow  = QueryAddRow(CALLER.ServiceLevelQuery, 1)>
<cfset temp = QuerySetCell(CALLER.ServiceLevelQuery, "ServiceLevelCode", "13")>
<cfset temp = QuerySetCell(CALLER.ServiceLevelQuery, "ServiceLevelDesc", "Next Day Air Saver")>
<cfset newRow  = QueryAddRow(CALLER.ServiceLevelQuery, 1)>
<cfset temp = QuerySetCell(CALLER.ServiceLevelQuery, "ServiceLevelCode", "14")>
<cfset temp = QuerySetCell(CALLER.ServiceLevelQuery, "ServiceLevelDesc", "Next Day Air Early AM")>
<cfset newRow  = QueryAddRow(CALLER.ServiceLevelQuery, 1)>
<cfset temp = QuerySetCell(CALLER.ServiceLevelQuery, "ServiceLevelCode", "54")>
<cfset temp = QuerySetCell(CALLER.ServiceLevelQuery, "ServiceLevelDesc", "Worldwide Express Plus")>
<cfset newRow  = QueryAddRow(CALLER.ServiceLevelQuery, 1)>
<cfset temp = QuerySetCell(CALLER.ServiceLevelQuery, "ServiceLevelCode", "59")>
<cfset temp = QuerySetCell(CALLER.ServiceLevelQuery, "ServiceLevelDesc", "2nd Day Air AM")>
<cfset newRow  = QueryAddRow(CALLER.ServiceLevelQuery, 1)>
<cfset temp = QuerySetCell(CALLER.ServiceLevelQuery, "ServiceLevelCode", "65")>
<cfset temp = QuerySetCell(CALLER.ServiceLevelQuery, "ServiceLevelDesc", "Express Saver")>

<cfparam name="ATTRIBUTES.PackageCode" default="02"> <!--- Required --->
<cfparam name="ATTRIBUTES.PackageDesc" default="Package">
<cfparam name="ATTRIBUTES.PackageUnitOfMeasurement" default="IN"> <!--- Inches --->
<cfparam name="ATTRIBUTES.PackageLength" default="10.0"> <!--- valid values 1 - 108.00 only --->
<cfparam name="ATTRIBUTES.PackageWidth" default="10.0"> <!--- valid values 1 - 108.00 only --->
<cfparam name="ATTRIBUTES.PackageHeight" default="10.0"> <!--- valid values 1 - 108.00 only --->
<cfparam name="ATTRIBUTES.PackageWeightUnit" default="LBS"> <!--- LBS | KGS --->
<cfparam name="ATTRIBUTES.PackageWeight" default="1"> <!--- 0.0  if PackagingType = Letter, Otherwise 0.1 - 150.0 --->
<cfparam name="ATTRIBUTES.PackageOversize" default="0">
<cfparam name="ATTRIBUTES.CurrencyCode" default="USD">
<cfparam name="ATTRIBUTES.InsuredValue" default="99.0">
<!--- Value between 0.0  and 999.00 valid for Domestic shipments Only --->
<cfparam name="ATTRIBUTES.CODCode" default="">
<cfparam name="ATTRIBUTES.CODCurrencyCode" default="USD">
<cfparam name="ATTRIBUTES.CODAmount" default="0">
<cfparam name="ATTRIBUTES.CODFundsAcceptedCode" default="0">
<cfparam name="ATTRIBUTES.SaturdayPickup" default="0">
<cfparam name="ATTRIBUTES.SaturdayDelivery" default="0">
<cfparam name="ATTRIBUTES.TrackingNumber" default="">
<cfparam name="ATTRIBUTES.TrackingReference" default="">

<cfparam name="ATTRIBUTES.CertificationRequest" default="FALSE">
<cfparam name="ATTRIBUTES.SuppressWhiteSpace" default="TRUE">
<cfparam name="ATTRIBUTES.Debug" default="FALSE">
<cfparam name="ATTRIBUTES.TimeOut" default="90">
			   
	
<!--- 	 
	Time In Transit
	===============
	The character length limits for submitting PoliticalDivision3, PoliticalDivision2, 
	and PoliticalDivision1 elements is 30 characters.
 --->

<cfswitch expression="#ATTRIBUTES.function#">

 <!--- UPS Rates Availability Check --->
 <cfcase value="rateAvailabilityRequest">
	<cfhttp method="get" url="https://www.ups.com/ups.app/xml/Rate" resolveurl="yes" port="443" timeout="#ATTRIBUTES.TimeOut#">
	</cfhttp>
	<cfset CALLER.RateAvailResponse = #cfhttp.fileContent#>
	<cfset CALLER.ServiceName = FindNoCase("Service Name: Rate", CALLER.RateAvailResponse, 1)>
	<cfif CALLER.ServiceName gt 0>
		<cfset CALLER.RateAvailCheck1 = 1>
	<cfelse>
		<cfset CALLER.RateAvailCheck1 = 0>
	</cfif>
	<cfset CALLER.RemoteUser = FindNoCase("Remote User: null", CALLER.RateAvailResponse, 1)>
	<cfif CALLER.RemoteUser gt 0>
		<cfset CALLER.RateAvailCheck2 = 1>
	<cfelse>
		<cfset CALLER.RateAvailCheck2 = 0>
	</cfif>
	<cfset CALLER.ServerPort = FindNoCase("Server Port: 443", CALLER.RateAvailResponse, 1)>
	<cfif CALLER.ServerPort gt 0>
		<cfset CALLER.RateAvailCheck3 = 1>
	<cfelse>
		<cfset CALLER.RateAvailCheck3 = 0>
	</cfif>
	<cfset CALLER.ServerName = FindNoCase("Server Name: www.ups.com", CALLER.RateAvailResponse, 1)>
	<cfif CALLER.ServerName gt 0>
		<cfset CALLER.RateAvailCheck4 = 1>
	<cfelse>
		<cfset CALLER.RateAvailCheck4 = 0>
	</cfif>
	<cfset CALLER.ServletPath = FindNoCase("Servlet Path: /Rate", CALLER.RateAvailResponse, 1)>
	<cfif CALLER.ServletPath gt 0>
		<cfset CALLER.RateAvailCheck5 = 1>
	<cfelse>
		<cfset CALLER.RateAvailCheck5 = 0>
	</cfif>
	<cfif CALLER.RateAvailCheck1 eq 1 AND CALLER.RateAvailCheck2 eq 1
		AND CALLER.RateAvailCheck3 eq 1 AND CALLER.RateAvailCheck4 eq 1 AND CALLER.RateAvailCheck5 eq 1>
		<cfset CALLER.RateAvail = 1>
	<cfelse>
		<cfset CALLER.RateAvail = 0>
	</cfif>
 </cfcase>
 <!--- End UPS Rates Availability Check --->
 
  <!--- UPS Track Availability Check --->
 <cfcase value="trackAvailabilityRequest">
	<cfhttp method="get" url="https://www.ups.com/ups.app/xml/Track" resolveurl="yes" port="443" timeout="#ATTRIBUTES.TimeOut#">
	</cfhttp>
	<cfset CALLER.TrackAvailResponse = #cfhttp.fileContent#>
	<cfset CALLER.ServiceName = FindNoCase("Service Name: Track", CALLER.TrackAvailResponse, 1)>
	<cfif CALLER.ServiceName gt 0>
		<cfset CALLER.TrackAvailCheck1 = 1>
	<cfelse>
		<cfset CALLER.TrackAvailCheck1 = 0>
	</cfif>
	<cfset CALLER.RemoteUser = FindNoCase("Remote User: null", CALLER.TrackAvailResponse, 1)>
	<cfif CALLER.RemoteUser gt 0>
		<cfset CALLER.TrackAvailCheck2 = 1>
	<cfelse>
		<cfset CALLER.TrackAvailCheck2 = 0>
	</cfif>
	<cfset CALLER.ServerPort = FindNoCase("Server Port: 443", CALLER.TrackAvailResponse, 1)>
	<cfif CALLER.ServerPort gt 0>
		<cfset CALLER.TrackAvailCheck3 = 1>
	<cfelse>
		<cfset CALLER.TrackAvailCheck3 = 0>
	</cfif>
	<cfset CALLER.ServerName = FindNoCase("Server Name: www.ups.com", CALLER.TrackAvailResponse, 1)>
	<cfif CALLER.ServerName gt 0>
		<cfset CALLER.TrackAvailCheck4 = 1>
	<cfelse>
		<cfset CALLER.TrackAvailCheck4 = 0>
	</cfif>
	<cfset CALLER.ServletPath = FindNoCase("Servlet Path: /Track", CALLER.TrackAvailResponse, 1)>
	<cfif CALLER.ServletPath gt 0>
		<cfset CALLER.TrackAvailCheck5 = 1>
	<cfelse>
		<cfset CALLER.TrackAvailCheck5 = 0>
	</cfif>
	<cfif CALLER.TrackAvailCheck1 eq 1 AND CALLER.TrackAvailCheck2 eq 1
		AND CALLER.TrackAvailCheck3 eq 1 AND CALLER.TrackAvailCheck4 eq 1 AND CALLER.TrackAvailCheck5 eq 1>
		<cfset CALLER.TrackAvail = 1>
	<cfelse>
		<cfset CALLER.TrackAvail = 0>
	</cfif>
 </cfcase>
 <!--- End UPS Track Availability Check --->
 
   <!--- UPS TNT Availability Check --->
 <cfcase value="tntAvailabilityRequest">
	<cfhttp method="get" url="https://www.ups.com/ups.app/xml/TimeInTransit" resolveurl="yes" port="443" timeout="#ATTRIBUTES.TimeOut#">
	</cfhttp>
	<cfset CALLER.tntAvailResponse = #cfhttp.fileContent#>
	<cfset CALLER.ServiceName = FindNoCase("Service Name: TimeInTransit", CALLER.tntAvailResponse, 1)>
	<cfif CALLER.ServiceName gt 0>
		<cfset CALLER.tntAvailCheck1 = 1>
	<cfelse>
		<cfset CALLER.tntAvailCheck1 = 0>
	</cfif>
	<cfset CALLER.RemoteUser = FindNoCase("Remote User: null", CALLER.tntAvailResponse, 1)>
	<cfif CALLER.RemoteUser gt 0>
		<cfset CALLER.tntAvailCheck2 = 1>
	<cfelse>
		<cfset CALLER.tntAvailCheck2 = 0>
	</cfif>
	<cfset CALLER.ServerPort = FindNoCase("Server Port: 443", CALLER.tntAvailResponse, 1)>
	<cfif CALLER.ServerPort gt 0>
		<cfset CALLER.tntAvailCheck3 = 1>
	<cfelse>
		<cfset CALLER.tntAvailCheck3 = 0>
	</cfif>
	<cfset CALLER.ServerName = FindNoCase("Server Name: www.ups.com", CALLER.tntAvailResponse, 1)>
	<cfif CALLER.ServerName gt 0>
		<cfset CALLER.tntAvailCheck4 = 1>
	<cfelse>
		<cfset CALLER.tntAvailCheck4 = 0>
	</cfif>
	<cfset CALLER.ServletPath = FindNoCase("Servlet Path: /TimeInTransit", CALLER.tntAvailResponse, 1)>
	<cfif CALLER.ServletPath gt 0>
		<cfset CALLER.tntAvailCheck5 = 1>
	<cfelse>
		<cfset CALLER.tntAvailCheck5 = 0>
	</cfif>
	<cfif CALLER.tntAvailCheck1 eq 1 AND CALLER.tntAvailCheck2 eq 1
		AND CALLER.tntAvailCheck3 eq 1 AND CALLER.tntAvailCheck4 eq 1 AND CALLER.tntAvailCheck5 eq 1>
		<cfset CALLER.tntAvail = 1>
	<cfelse>
		<cfset CALLER.tntAvail = 0>
	</cfif>
 </cfcase>
 <!--- End UPS TNT Availability Check --->
 
 <!--- UPS Shop Rates and Service --->
 <cfcase value="rateShopRequest">
	
	<cfif ( #ListLen(ATTRIBUTES.PackageLength)# eq #ListLen(ATTRIBUTES.PackageWeight)# 
			AND #ListLen(ATTRIBUTES.PackageWidth)# eq #ListLen(ATTRIBUTES.PackageHeight)#
			AND #ListLen(ATTRIBUTES.PackageLength)# eq #ListLen(ATTRIBUTES.PackageWidth)#)>
	<cfelse>
		<cfset CALLER.UPSRateShopError = 2>
		<cfset CALLER.UPSResponseDesc = "Error: You must enter pass an equal number of weight and dimensions package elements for Multi-Piece shipments">
		<cfset CALLER.UPSErrorCode = "">
		<cfabort>
	</cfif>
	 
	<cfscript>
	if (#ATTRIBUTES.SaturdayPickup# eq 1) {
		SatPickupIndicator = '<SaturdayPickup/>';
	}
	else {
		SatPickupIndicator = '';
	}
	if (#ATTRIBUTES.SaturdayDelivery# eq 1) {
		SatDeliveryIndicator = '<SaturdayDelivery/>';
	}
	else {
		SatDeliveryIndicator = '';
	}
	if (#ATTRIBUTES.ResidentialAddress# eq 1) {
		ResidentialIndicator = '<ResidentialAddress/>';
	}
	else {
		ResidentialIndicator = '';
	}
	if ( #ListLen(ATTRIBUTES.PackageWeight)# gt 1 ) {
	  	
		PackageIndicator = '';
		 
		 for ( idx = 1 ; idx lte ListLen(ATTRIBUTES.PackageWeight); idx = idx + 1 ) {
			 PackageIndicator = '#PackageIndicator#
			 <Package>
		  <PackagingType>
			<Code>#ATTRIBUTES.PackageCode#</Code>
			<Description>#ATTRIBUTES.PackageDesc#</Description>
		  </PackagingType>
		  <Dimensions>
		  	<UnitOfMeasurement>
				<Code>#ATTRIBUTES.PackageUnitOfMeasurement#</Code>
			</UnitOfMeasurement>
			<Length>#NumberFormat(ListGetAt(ATTRIBUTES.PackageLength, idx), "999.99")#</Length>
			<Width>#NumberFormat(ListGetAt(ATTRIBUTES.PackageWidth, idx), "999.99")#</Width>
			<Height>#NumberFormat(ListGetAt(ATTRIBUTES.PackageHeight, idx), "999.99")#</Height>
		  </Dimensions>
		  <PackageWeight>
			<UnitOfMeasurement>
				<Code>#ATTRIBUTES.PackageWeightUnit#</Code>
			</UnitOfMeasurement>
			<Weight>#ListGetAt(ATTRIBUTES.PackageWeight, idx)#</Weight>
		  </PackageWeight>
		  <PackageServiceOptions>
			<InsuredValue>
			  <CurrencyCode>#ATTRIBUTES.CurrencyCode#</CurrencyCode>
			  <MonetaryValue>#NumberFormat(ListGetAt(ATTRIBUTES.InsuredValue, idx), "999.99")#</MonetaryValue>
			</InsuredValue>
		  </PackageServiceOptions>
		  <OversizePackage>#ATTRIBUTES.PackageOversize#</OversizePackage>
		 </Package>';
		  }
	  
	}
	else {
		PackageIndicator = '<Package>
		  <PackagingType>
			<Code>#ATTRIBUTES.PackageCode#</Code>
			<Description>#ATTRIBUTES.PackageDesc#</Description>
		  </PackagingType>
		  <Dimensions>
		  	<UnitOfMeasurement>
				<Code>#ATTRIBUTES.PackageUnitOfMeasurement#</Code>
			</UnitOfMeasurement>
			<Length>#NumberFormat(ATTRIBUTES.PackageLength, "999.99")#</Length>
			<Width>#NumberFormat(ATTRIBUTES.PackageWidth, "999.99")#</Width>
			<Height>#NumberFormat(ATTRIBUTES.PackageHeight, "999.99")#</Height>
		  </Dimensions>
		  <PackageWeight>
			<UnitOfMeasurement>
				<Code>#ATTRIBUTES.PackageWeightUnit#</Code>
			</UnitOfMeasurement>
			<Weight>#ATTRIBUTES.PackageWeight#</Weight>
		  </PackageWeight>
		  <PackageServiceOptions>
			<InsuredValue>
			  <CurrencyCode>#ATTRIBUTES.CurrencyCode#</CurrencyCode>
			  <MonetaryValue>#NumberFormat(ATTRIBUTES.InsuredValue, "999.99")#</MonetaryValue>
			</InsuredValue>
		  </PackageServiceOptions>
		  <OversizePackage>#ATTRIBUTES.PackageOversize#</OversizePackage>
		 </Package>';
	}
	ATTRIBUTES.RateShopAccess = '<?xml version="#ATTRIBUTES.XMLVersion#"?>
	<AccessRequest xml:lang="en-US">
	<AccessLicenseNumber>#ATTRIBUTES.UPSAccessKey#</AccessLicenseNumber>
		<UserId>#ATTRIBUTES.UPSUserID#</UserId>
		<Password>#ATTRIBUTES.UPSPassword#</Password>
	</AccessRequest>';
	
	ATTRIBUTES.RateShopRequest='<?xml version="#ATTRIBUTES.XMLVersion#"?>
	<RatingServiceSelectionRequest xml:lang="en-US">
	  <Request>
		<TransactionReference>
		  <CustomerContext>Rating and Service</CustomerContext>
		  <XpciVersion>#ATTRIBUTES.XPCIVersion#</XpciVersion>
		</TransactionReference>
		<RequestAction>Rate</RequestAction>
		<RequestOption>shop</RequestOption>
	  </Request>
	  <PickupType>
	  	<Code>#ATTRIBUTES.PickUpType#</Code>
	  </PickupType>
	  <Shipment>
		<Shipper>
		  <Address>
			<City>#ATTRIBUTES.ShipperCity#</City>
			<StateProvinceCode>#ATTRIBUTES.ShipperState#</StateProvinceCode>
			<PostalCode>#ATTRIBUTES.ShipperZip#</PostalCode>
			<CountryCode>#ATTRIBUTES.ShipperCountry#</CountryCode>
		  </Address>
		</Shipper>
		<ShipTo>
		  <Address>
			<City>#ATTRIBUTES.ShipToCity#</City>
			<StateProvinceCode>#ATTRIBUTES.ShipToState#</StateProvinceCode>			
			<PostalCode>#ATTRIBUTES.ShipToZip#</PostalCode>
			<CountryCode>#ATTRIBUTES.ShipToCountry#</CountryCode>
			#ResidentialIndicator#
		  </Address>
		</ShipTo>
		#PackageIndicator#
		 <ShipmentServiceOptions>
		 	#SatPickupIndicator#
			#SatDeliveryIndicator#
		 </ShipmentServiceOptions>
	  </Shipment>
	</RatingServiceSelectionRequest>';
	
	ATTRIBUTES.XMLRequestInput = '#ATTRIBUTES.RateShopAccess#
	#ATTRIBUTES.RateShopRequest#';
	</cfscript>
	
	<cfhttp method="post" url="#ATTRIBUTES.rateServer#" resolveurl="yes" port="443" timeout="#ATTRIBUTES.TimeOut#">
		<cfhttpparam name="XML" type="xml" value="#ATTRIBUTES.XMLRequestInput#">
	</cfhttp>
	
	<cfset CALLER.stUpsRatesShop = XmlParse(Trim(cfhttp.FileContent))>
	
	<cfif IsDefined("ATTRIBUTES.Debug") AND ATTRIBUTES.Debug eq "TRUE">	
		<cffile action="WRITE" file="#ATTRIBUTES.ServerFilePath##trailingSlash#Debug#trailingSlash#RateShopAccess.xml" output="#ATTRIBUTES.RateShopAccess#" addnewline="No" nameconflict="overwrite">
		<cffile action="WRITE" file="#ATTRIBUTES.ServerFilePath##trailingSlash#Debug#trailingSlash#RateShopRequest.xml" output="#ATTRIBUTES.RateShopRequest#" addnewline="No" nameconflict="overwrite">
		<cfoutput><cfdump var="#CALLER.stUpsRatesShop#">
		<a href="Debug#trailingSlash#RateShopAccess.xml" target="_blank">View XML Access File</a>
		<a href="Debug#trailingSlash#RateShopRequest.xml" target="_blank">View XML Request File</a>
		</cfoutput>
		<cfabort>
	</cfif>
	
	<cfif IsDefined("CALLER.stUpsRatesShop.RatingServiceSelectionResponse.Response.RESPONSESTATUSCODE.XMLText") AND 
		#CALLER.stUpsRatesShop.RatingServiceSelectionResponse.Response.RESPONSESTATUSCODE.XMLText# eq 1> <!--- Success --->
		<cfset CALLER.UPSRateShopError = 0> <!--- Transaction successful --->	
	 	<cfset CALLER.UPSResponseDesc = CALLER.stUpsRatesShop.RatingServiceSelectionResponse.Response.RESPONSESTATUSDESCRIPTION.XMLText>
	 <cfif #isArray(CALLER.stUpsRatesShop.RatingServiceSelectionResponse.RatedShipment.XmlChildren)#>
	  
	  <cfif #isArray(CALLER.stUpsRatesShop.RatingServiceSelectionResponse.RatedShipment[1].RatedPackage.XmlChildren)#>
	  	<!--- Check if Package response is not an array, it will be an array is multi-piece shipment --->
		
		<!--- Loop through the shipping rate results and the package results --->
		  <cfset CALLER.rateShopQuery = QueryNew("PackageID, GuaranteedDTD, BillableWeight, WeightUnit, ScheduledDelivTime, OptionCharges, OptionChargesCurrency, PackageTotalCharges, PackageChargesCurrency, ServiceLevel, TotalCharges, TotalChargesCurrency, OriginalWeight")>
		  <cfset CALLER.aRateShopQuery = CALLER.stUpsRatesShop.RatingServiceSelectionResponse.RatedShipment>
		  <cfset qCount = 1>	
			<cfloop index="idxRates" from="1" to="#ArrayLen(CALLER.aRateShopQuery)#">
				   <cfset CALLER.aRatePackage = CALLER.stUpsRatesShop.RatingServiceSelectionResponse.RatedShipment[idxRates].RatedPackage>
				<cfloop index="idxPackages" from="1" to="#ArrayLen(CALLER.aRatePackage)#">
					<cfset newRow  = QueryAddRow(CALLER.rateShopQuery, 1)>
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "PackageID", "#idxPackages#")>
				   <cfif StructKeyExists(CALLER.aRateShopQuery[idxRates], "GuaranteedDaysToDelivery")>	
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "GuaranteedDTD", CALLER.aRateShopQuery[idxRates].GuaranteedDaysToDelivery.XMLText, qCount)>
				   <cfelse>
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "GuaranteedDTD", "")>
				   </cfif>
				   <cfif StructKeyExists(CALLER.aRateShopQuery[idxRates].RatedPackage[idxPackages].BillingWeight, "Weight")>
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "BillableWeight", CALLER.aRateShopQuery[idxRates].RatedPackage[idxPackages].BillingWeight.Weight.XMLText, qCount)>
				   <cfelse>
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "BillableWeight", "")>
				   </cfif>
				   <cfif StructKeyExists(CALLER.aRateShopQuery[idxRates].RatedPackage[idxPackages].BillingWeight.UnitOfMeasurement, "Code")>	
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "WeightUnit", CALLER.aRateShopQuery[idxRates].RatedPackage[idxPackages].BillingWeight.UnitOfMeasurement.Code.XMLText, qCount)>
				   <cfelse>
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "WeightUnit", "")>
				   </cfif>
				   <cfif StructKeyExists(CALLER.aRateShopQuery[idxRates], "ScheduledDeliveryTime")>	
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "ScheduledDelivTime", CALLER.aRateShopQuery[idxRates].ScheduledDeliveryTime.XMLText, qCount)>
				   <cfelse>
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "ScheduledDelivTime", "")>
				   </cfif>
				   <cfif StructKeyExists(CALLER.aRateShopQuery[idxRates].RatedPackage[idxPackages].ServiceOptionsCharges, "MonetaryValue")>	
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "OptionCharges", CALLER.aRateShopQuery[idxRates].RatedPackage[idxPackages].ServiceOptionsCharges.MonetaryValue.XMLText, qCount)>
				   <cfelse>
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "OptionCharges", "")>
				   </cfif>
				   <cfif StructKeyExists(CALLER.aRateShopQuery[idxRates].RatedPackage[idxPackages].ServiceOptionsCharges, "CurrencyCode")>	
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "OptionChargesCurrency", CALLER.aRateShopQuery[idxRates].RatedPackage[idxPackages].ServiceOptionsCharges.CurrencyCode.XMLText, qCount)>
				   <cfelse>
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "OptionChargesCurrency", "")>
				   </cfif>
				   <cfif StructKeyExists(CALLER.aRateShopQuery[idxRates].RatedPackage[idxPackages].TotalCharges, "MonetaryValue")>	
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "PackageTotalCharges", CALLER.aRateShopQuery[idxRates].RatedPackage[idxPackages].TotalCharges.MonetaryValue.XMLText, qCount)>
				   <cfelse>
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "PackageTotalCharges", "")>
				   </cfif>
				   <cfif StructKeyExists(CALLER.aRateShopQuery[idxRates].RatedPackage[idxPackages].TotalCharges, "CurrencyCode")>	
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "PackageChargesCurrency", CALLER.aRateShopQuery[idxRates].RatedPackage[idxPackages].TotalCharges.CurrencyCode.XMLText, qCount)>
				   <cfelse>
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "PackageChargesCurrency", "")>
				   </cfif>
				   <cfif StructKeyExists(CALLER.aRateShopQuery[idxRates].Service, "Code")>	
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "ServiceLevel", CALLER.aRateShopQuery[idxRates].Service.Code.XMLText, qCount)>
				   <cfelse>
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "ServiceLevel", "")>
				   </cfif>
				   <cfif StructKeyExists(CALLER.aRateShopQuery[idxRates].TotalCharges, "MonetaryValue")>	
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "TotalCharges", CALLER.aRateShopQuery[idxRates].TotalCharges.MonetaryValue.XMLText, qCount)>
				   <cfelse>
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "TotalCharges", "")>
				   </cfif>
				   <cfif StructKeyExists(CALLER.aRateShopQuery[idxRates].TotalCharges, "CurrencyCode")>	
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "TotalChargesCurrency", CALLER.aRateShopQuery[idxRates].TotalCharges.CurrencyCode.XMLText, qCount)>
				   <cfelse>
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "TotalChargesCurrency", "")>
				   </cfif>
				   <cfif StructKeyExists(CALLER.aRateShopQuery[idxRates].RatedPackage[idxPackages], "Weight")>
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "OriginalWeight", CALLER.aRateShopQuery[idxRates].RatedPackage[idxPackages].Weight.XMLText, qCount)>
				   <cfelse>
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "OriginalWeight", "")>
				   </cfif>
				   
				   <cfset qCount = qCount + 1>
				   			   
				</cfloop>
			  </cfloop>
	  
		<cfelse>
		  <!--- Loop through the shipping rate results --->
		  <cfset CALLER.rateShopQuery = QueryNew("PackageID, GuaranteedDTD, BillableWeight, WeightUnit, ScheduledDelivTime, OptionCharges, OptionChargesCurrency, PackageTotalCharges, PackageChargesCurrency, ServiceLevel, TotalCharges, TotalChargesCurrency, OriginalWeight")>
		  <cfset CALLER.aRateShopQuery = CALLER.stUpsRatesShop.RatingServiceSelectionResponse.RatedShipment>
			<cfloop index="idxRates" from="1" to="#ArrayLen(CALLER.aRateShopQuery)#">
					<cfset newRow  = QueryAddRow(CALLER.rateShopQuery, 1)>
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "PackageID", "1")>
				   <cfif StructKeyExists(CALLER.aRateShopQuery[idxRates], "GuaranteedDaysToDelivery")>	
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "GuaranteedDTD", CALLER.aRateShopQuery[idxRates].GuaranteedDaysToDelivery.XMLText, idxRates)>
				   <cfelse>
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "GuaranteedDTD", "")>
				   </cfif>
				   <cfif StructKeyExists(CALLER.aRateShopQuery[idxRates].RatedPackage.BillingWeight, "Weight")>	
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "BillableWeight", CALLER.aRateShopQuery[idxRates].RatedPackage.BillingWeight.Weight.XMLText, idxRates)>
				   <cfelse>
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "BillableWeight", "")>
				   </cfif>
				   <cfif StructKeyExists(CALLER.aRateShopQuery[idxRates].RatedPackage.BillingWeight.UnitOfMeasurement, "Code")>	
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "WeightUnit", CALLER.aRateShopQuery[idxRates].RatedPackage.BillingWeight.UnitOfMeasurement.Code.XMLText, idxRates)>
				   <cfelse>
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "WeightUnit", "")>
				   </cfif>
				   <cfif StructKeyExists(CALLER.aRateShopQuery[idxRates], "ScheduledDeliveryTime")>	
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "ScheduledDelivTime", CALLER.aRateShopQuery[idxRates].ScheduledDeliveryTime.XMLText, idxRates)>
				   <cfelse>
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "ScheduledDelivTime", "")>
				   </cfif>
				   <cfif StructKeyExists(CALLER.aRateShopQuery[idxRates].RatedPackage.ServiceOptionsCharges, "MonetaryValue")>	
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "OptionCharges", CALLER.aRateShopQuery[idxRates].RatedPackage.ServiceOptionsCharges.MonetaryValue.XMLText, idxRates)>
				   <cfelse>
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "OptionCharges", "")>
				   </cfif>
				   <cfif StructKeyExists(CALLER.aRateShopQuery[idxRates].RatedPackage.ServiceOptionsCharges, "CurrencyCode")>	
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "OptionChargesCurrency", CALLER.aRateShopQuery[idxRates].RatedPackage.ServiceOptionsCharges.CurrencyCode.XMLText, idxRates)>
				   <cfelse>
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "OptionChargesCurrency", "")>
				   </cfif>
				   <cfif StructKeyExists(CALLER.aRateShopQuery[idxRates].Service, "Code")>	
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "ServiceLevel", CALLER.aRateShopQuery[idxRates].Service.Code.XMLText, idxRates)>
				   <cfelse>
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "ServiceLevel", "")>
				   </cfif>
				   <cfif StructKeyExists(CALLER.aRateShopQuery[idxRates].TotalCharges, "MonetaryValue")>
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "TotalCharges", CALLER.aRateShopQuery[idxRates].TotalCharges.MonetaryValue.XMLText, idxRates)>
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "PackageTotalCharges", CALLER.aRateShopQuery[idxRates].TotalCharges.MonetaryValue.XMLText, idxRates)>
				   <cfelse>
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "TotalCharges", "")>
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "PackageTotalCharges", "")>
				   </cfif>
				   <cfif StructKeyExists(CALLER.aRateShopQuery[idxRates].TotalCharges, "CurrencyCode")>	
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "TotalChargesCurrency", CALLER.aRateShopQuery[idxRates].TotalCharges.CurrencyCode.XMLText, idxRates)>
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "PackageChargesCurrency", CALLER.aRateShopQuery[idxRates].TotalCharges.CurrencyCode.XMLText, idxRates)>
				   <cfelse>
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "TotalChargesCurrency", "")>
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "PackageChargesCurrency", "")>
				   </cfif>
				   <cfif StructKeyExists(CALLER.aRateShopQuery[idxRates].RatedPackage, "Weight")>	
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "OriginalWeight", CALLER.aRateShopQuery[idxRates].RatedPackage.Weight.XMLText, idxRates)>
				   <cfelse>
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "OriginalWeight", "")>
				   </cfif>
			</cfloop>
			
		</cfif><!--- End Check if Package response is not an array, it will be an array if multi-piece shipment --->
		
	<cfelseif StructKeyExists(CALLER.stUpsRatesShop.RatingServiceSelectionResponse.RatedShipment.TotalCharges, "MonetaryValue")>
					<cfset CALLER.aRateShopQuery = CALLER.stUpsRatesShop.RatingServiceSelectionResponse.RatedShipment>		
					<cfset CALLER.rateShopQuery = QueryNew("PackageID, GuaranteedDTD, BillableWeight, WeightUnit, ScheduledDelivTime, OptionCharges, OptionChargesCurrency, PackageTotalCharges, PackageChargesCurrency, ServiceLevel, TotalCharges, TotalChargesCurrency, OriginalWeight")>
					<cfset newRow  = QueryAddRow(CALLER.rateShopQuery, 1)>
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "PackageID", "1")>
				   <cfif StructKeyExists(CALLER.aRateShopQuery, "GuaranteedDaysToDelivery")>	
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "GuaranteedDTD", CALLER.aRateShopQuery.GuaranteedDaysToDelivery.XMLText, 1)>
				   <cfelse>
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "GuaranteedDTD", "")>
				   </cfif>
				   <cfif StructKeyExists(CALLER.aRateShopQuery.RatedPackage.BillingWeight, "Weight")>	
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "BillableWeight", CALLER.aRateShopQuery.RatedPackage.BillingWeight.Weight.XMLText, 1)>
				   <cfelse>
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "BillableWeight", "")>
				   </cfif>
				   <cfif StructKeyExists(CALLER.aRateShopQuery.RatedPackage.BillingWeight.UnitOfMeasurement, "Code")>	
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "WeightUnit", CALLER.aRateShopQuery.RatedPackage.BillingWeight.UnitOfMeasurement.Code.XMLText, 1)>
				   <cfelse>
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "WeightUnit", "")>
				   </cfif>
				   <cfif StructKeyExists(CALLER.aRateShopQuery, "ScheduledDeliveryTime")>	
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "ScheduledDelivTime", CALLER.aRateShopQuery.ScheduledDeliveryTime.XMLText, 1)>
				   <cfelse>
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "ScheduledDelivTime", "")>
				   </cfif>
				   <cfif StructKeyExists(CALLER.aRateShopQuery.RatedPackage.ServiceOptionsCharges, "MonetaryValue")>	
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "OptionCharges", CALLER.aRateShopQuery.RatedPackage.ServiceOptionsCharges.MonetaryValue.XMLText, 1)>
				   <cfelse>
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "OptionCharges", "")>
				   </cfif>
				   <cfif StructKeyExists(CALLER.aRateShopQuery.RatedPackage.ServiceOptionsCharges, "CurrencyCode")>	
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "OptionChargesCurrency", CALLER.aRateShopQuery.RatedPackage.ServiceOptionsCharges.CurrencyCode.XMLText, 1)>
				   <cfelse>
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "OptionChargesCurrency", "")>
				   </cfif>
				   <cfif StructKeyExists(CALLER.aRateShopQuery.Service, "Code")>	
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "ServiceLevel", CALLER.aRateShopQuery.Service.Code.XMLText, 1)>
				   <cfelse>
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "ServiceLevel", "")>
				   </cfif>
				   <cfif StructKeyExists(CALLER.aRateShopQuery.TotalCharges, "MonetaryValue")>
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "TotalCharges", CALLER.aRateShopQuery.TotalCharges.MonetaryValue.XMLText, 1)>
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "PackageTotalCharges", CALLER.aRateShopQuery.TotalCharges.MonetaryValue.XMLText, 1)>
				   <cfelse>
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "TotalCharges", "")>
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "PackageTotalCharges", "")>
				   </cfif>
				   <cfif StructKeyExists(CALLER.aRateShopQuery.TotalCharges, "CurrencyCode")>	
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "TotalChargesCurrency", CALLER.aRateShopQuery.TotalCharges.CurrencyCode.XMLText, 1)>
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "PackageChargesCurrency", CALLER.aRateShopQuery.TotalCharges.CurrencyCode.XMLText, 1)>
				   <cfelse>
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "TotalChargesCurrency", "")>
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "PackageChargesCurrency", "")>
				   </cfif>
				   <cfif StructKeyExists(CALLER.aRateShopQuery.RatedPackage, "Weight")>	
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "OriginalWeight", CALLER.aRateShopQuery.RatedPackage.Weight.XMLText, 1)>
				   <cfelse>
					<cfset temp = QuerySetCell(CALLER.rateShopQuery, "OriginalWeight", "")>
				   </cfif>
	
		 <cfelse>
			<!--- unexpected response --->
	 </cfif>
	  
	<cfelseif IsDefined("CALLER.stUpsRatesShop.RatingServiceSelectionResponse.Response.RESPONSESTATUSCODE.XmlText") AND 
		#CALLER.stUpsRatesShop.RatingServiceSelectionResponse.Response.RESPONSESTATUSCODE.XmlText# eq 0> <!--- Failure --->
		<cfset CALLER.UPSRateShopError = 1>
		<cfset CALLER.UPSResponseDesc = CALLER.stUpsRatesShop.RatingServiceSelectionResponse.Response.RESPONSESTATUSDESCRIPTION.XmlText>
		<cfif IsDefined("CALLER.stUpsRatesShop.RatingServiceSelectionResponse.Response.Error.ErrorCode.XmlText")>
			<cfset CALLER.UPSErrorCode = CALLER.stUpsRatesShop.RatingServiceSelectionResponse.Response.Error.ErrorCode.XmlText>
		</cfif>
		<cfif IsDefined("CALLER.stUpsRatesShop.RatingServiceSelectionResponse.Response.Error.ErrorDescription.XmlText")>
			<cfset CALLER.UPSErrorDescription = CALLER.stUpsRatesShop.RatingServiceSelectionResponse.Response.Error.ErrorDescription.XmlText>
		</cfif>
	<cfelse>
	 	<cfset CALLER.UPSRateShopError = 2>	
		<!--- Error Retrieving rates or communication failure to UPS --->
	</cfif>

 </cfcase>
 <!--- END UPS Rate and Service Shop Request --->
 
 <!--- UPS Rate for specific Service --->
 <cfcase value="rateRequest">
	
	<cfif ( #ListLen(ATTRIBUTES.PackageLength)# eq #ListLen(ATTRIBUTES.PackageWeight)# 
			AND #ListLen(ATTRIBUTES.PackageWidth)# eq #ListLen(ATTRIBUTES.PackageHeight)#
			AND #ListLen(ATTRIBUTES.PackageLength)# eq #ListLen(ATTRIBUTES.PackageWidth)#)>
	<cfelse>
		<cfset CALLER.UPSRateError = 2>
		<cfset CALLER.UPSResponseDesc = "Error: You must enter pass an equal number of weight and dimensions package elements for Multi-Piece shipments">
		<cfset CALLER.UPSErrorCode = "">
		<cfabort>
	</cfif>
		
	<cfscript>
	if (#ATTRIBUTES.SaturdayPickup# eq 1) {
		SatPickupIndicator = '<SaturdayPickup/>';
	}
	else {
		SatPickupIndicator = '';
	}
	if (#ATTRIBUTES.SaturdayDelivery# eq 1) {
		SatDeliveryIndicator = '<SaturdayDelivery/>';
	}
	else {
		SatDeliveryIndicator = '';
	}
	if (#ATTRIBUTES.ResidentialAddress# eq 1) {
		ResidentialIndicator = '<ResidentialAddress/>';
	}
	else {
		ResidentialIndicator = '';
	}
	if ( #ListLen(ATTRIBUTES.PackageWeight)# gt 1 ) {
	  	
		PackageIndicator = '';
		 
		 for ( idx = 1 ; idx lte ListLen(ATTRIBUTES.PackageWeight); idx = idx + 1 ) {
			 PackageIndicator = '#PackageIndicator#
			 <Package>
		  <PackagingType>
			<Code>#ATTRIBUTES.PackageCode#</Code>
			<Description>#ATTRIBUTES.PackageDesc#</Description>
		  </PackagingType>
		  <Dimensions>
		  	<UnitOfMeasurement>
				<Code>#ATTRIBUTES.PackageUnitOfMeasurement#</Code>
			</UnitOfMeasurement>
			<Length>#NumberFormat(ListGetAt(ATTRIBUTES.PackageLength, idx), "999.99")#</Length>
			<Width>#NumberFormat(ListGetAt(ATTRIBUTES.PackageWidth, idx), "999.99")#</Width>
			<Height>#NumberFormat(ListGetAt(ATTRIBUTES.PackageHeight, idx), "999.99")#</Height>
		  </Dimensions>
		  <PackageWeight>
			<UnitOfMeasurement>
				<Code>#ATTRIBUTES.PackageWeightUnit#</Code>
			</UnitOfMeasurement>
			<Weight>#ListGetAt(ATTRIBUTES.PackageWeight, idx)#</Weight>
		  </PackageWeight>
		  <PackageServiceOptions>
			<InsuredValue>
			  <CurrencyCode>#ATTRIBUTES.CurrencyCode#</CurrencyCode>
			  <MonetaryValue>#NumberFormat(ListGetAt(ATTRIBUTES.InsuredValue, idx), "999.99")#</MonetaryValue>
			</InsuredValue>
		  </PackageServiceOptions>
		  <OversizePackage>#ATTRIBUTES.PackageOversize#</OversizePackage>
		 </Package>';
		  }
	  
	}
	else {
		PackageIndicator = '<Package>
		  <PackagingType>
			<Code>#ATTRIBUTES.PackageCode#</Code>
			<Description>#ATTRIBUTES.PackageDesc#</Description>
		  </PackagingType>
		  <Dimensions>
		  	<UnitOfMeasurement>
				<Code>#ATTRIBUTES.PackageUnitOfMeasurement#</Code>
			</UnitOfMeasurement>
			<Length>#NumberFormat(ATTRIBUTES.PackageLength, "999.99")#</Length>
			<Width>#NumberFormat(ATTRIBUTES.PackageWidth, "999.99")#</Width>
			<Height>#NumberFormat(ATTRIBUTES.PackageHeight, "999.99")#</Height>
		  </Dimensions>
		  <PackageWeight>
			<UnitOfMeasurement>
				<Code>#ATTRIBUTES.PackageWeightUnit#</Code>
			</UnitOfMeasurement>
			<Weight>#ATTRIBUTES.PackageWeight#</Weight>
		  </PackageWeight>
		  <PackageServiceOptions>
			<InsuredValue>
			  <CurrencyCode>#ATTRIBUTES.CurrencyCode#</CurrencyCode>
			  <MonetaryValue>#NumberFormat(ATTRIBUTES.InsuredValue, "999.99")#</MonetaryValue>
			</InsuredValue>
		  </PackageServiceOptions>
		  <OversizePackage>#ATTRIBUTES.PackageOversize#</OversizePackage>
		 </Package>';
	}
	
	ATTRIBUTES.RateAccess = '<?xml version="#ATTRIBUTES.XMLVersion#"?>
	<AccessRequest xml:lang="en-US">
	<AccessLicenseNumber>#ATTRIBUTES.UPSAccessKey#</AccessLicenseNumber>
		<UserId>#ATTRIBUTES.UPSUserID#</UserId>
		<Password>#ATTRIBUTES.UPSPassword#</Password>
	</AccessRequest>';
	
	ATTRIBUTES.RateRequest = '<?xml version="#ATTRIBUTES.XMLVersion#"?>
	<RatingServiceSelectionRequest xml:lang="en-US">
	  <Request>
		<TransactionReference>
		  <CustomerContext>Rating and Service</CustomerContext>
		  <XpciVersion>#ATTRIBUTES.XPCIVersion#</XpciVersion>
		</TransactionReference>
		<RequestAction>Rate</RequestAction>
		<RequestOption>rate</RequestOption>
	  </Request>
	  <PickupType>
	  	<Code>#ATTRIBUTES.PickUpType#</Code>
	  </PickupType>
	  <Shipment>
		<Shipper>
		  <Address>
			<City>#ATTRIBUTES.ShipperCity#</City>
			<StateProvinceCode>#ATTRIBUTES.ShipperState#</StateProvinceCode>
			<PostalCode>#ATTRIBUTES.ShipperZip#</PostalCode>
			<CountryCode>#ATTRIBUTES.ShipperCountry#</CountryCode>
		  </Address>
		</Shipper>
		<ShipTo>
		  <Address>
			<City>#ATTRIBUTES.ShipToCity#</City>
			<StateProvinceCode>#ATTRIBUTES.ShipToState#</StateProvinceCode>			
			<PostalCode>#ATTRIBUTES.ShipToZip#</PostalCode>
			<CountryCode>#ATTRIBUTES.ShipToCountry#</CountryCode>
			#ResidentialIndicator#
		  </Address>
		</ShipTo>
		<Service>
			<Code>#ATTRIBUTES.ServiceType#</Code>
		</Service>
		#PackageIndicator#
		 <ShipmentServiceOptions>
			#SatPickupIndicator#
			#SatDeliveryIndicator#
		 </ShipmentServiceOptions>
	  </Shipment>
	</RatingServiceSelectionRequest>';
	
	ATTRIBUTES.XMLRequestInput = '#ATTRIBUTES.RateAccess#
	#ATTRIBUTES.RateRequest#';
	</cfscript>
	
	<cfhttp method="post" url="#ATTRIBUTES.rateServer#" resolveurl="yes" port="443" timeout="#ATTRIBUTES.TimeOut#">
		<cfhttpparam name="XML" type="xml" value="#ATTRIBUTES.XMLRequestInput#">
	</cfhttp>
	
	<cfset CALLER.stUpsRate = XmlParse(Trim(cfhttp.FileContent))>
	
	<cfif IsDefined("ATTRIBUTES.Debug") AND ATTRIBUTES.Debug eq "TRUE">	
		<cffile action="WRITE" file="#ATTRIBUTES.ServerFilePath##trailingSlash#Debug#trailingSlash#RateAccess.xml" output="#ATTRIBUTES.RateAccess#" addnewline="No" nameconflict="overwrite">
		<cffile action="WRITE" file="#ATTRIBUTES.ServerFilePath##trailingSlash#Debug#trailingSlash#RateRequest.xml" output="#ATTRIBUTES.RateRequest#" addnewline="No" nameconflict="overwrite">
		<cfoutput>
		<cfdump var="#CALLER.stUpsRate#">
		<a href="Debug#trailingSlash#RateAccess.xml" target="_blank">View XML Access File</a>
		<a href="Debug#trailingSlash#RateRequest.xml" target="_blank">View XML Request File</a>
		</cfoutput>
		<cfabort>
	</cfif>
	
	<cfif IsDefined("CALLER.stUpsRate.RatingServiceSelectionResponse.Response.RESPONSESTATUSCODE.XMLText") AND 
		#CALLER.stUpsRate.RatingServiceSelectionResponse.Response.RESPONSESTATUSCODE.XMLText# eq 1> <!--- Success --->
		<cfset CALLER.UPSRateError = 0> <!--- Transaction successful --->	
	 	<cfset CALLER.UPSResponseDesc = CALLER.stUpsRate.RatingServiceSelectionResponse.Response.RESPONSESTATUSDESCRIPTION.XMLText>
 		
		<!--- Check if multi-piece shipment and a rates array was returned --->
		<cfif #isArray(CALLER.stUpsRate.RatingServiceSelectionResponse.RatedShipment.RatedPackage.XMLChildren)#>
		
		<!--- Loop through the shipping rate results and the package results --->
		  <cfset CALLER.rateQuery = QueryNew("PackageID, GuaranteedDTD, BillableWeight, WeightUnit, ScheduledDelivTime, OptionCharges, OptionChargesCurrency, PackageTotalCharges, PackageChargesCurrency, ServiceLevel, TotalCharges, TotalChargesCurrency, OriginalWeight")>
		  <cfset CALLER.aRateQuery = CALLER.stUpsRate.RatingServiceSelectionResponse.RatedShipment>
			<cfset qCount = 1>	
			<cfloop index="idxRates" from="1" to="#ArrayLen(CALLER.aRateQuery.RatedPackage)#">
					<cfset newRow  = QueryAddRow(CALLER.rateQuery, 1)>
					<cfset temp = QuerySetCell(CALLER.rateQuery, "PackageID", "1")>
				   <cfif StructKeyExists(CALLER.aRateQuery.RatedPackage[idxRates], "GuaranteedDaysToDelivery")>	
					<cfset temp = QuerySetCell(CALLER.rateQuery, "GuaranteedDTD", CALLER.aRateQuery.RatedPackage[idxRates].GuaranteedDaysToDelivery.XMLText, qCount)>
				   <cfelse>
					<cfset temp = QuerySetCell(CALLER.rateQuery, "GuaranteedDTD", "")>
				   </cfif>
				   <cfif StructKeyExists(CALLER.aRateQuery.RatedPackage[idxRates].BillingWeight, "Weight")>
					<cfset temp = QuerySetCell(CALLER.rateQuery, "BillableWeight", CALLER.aRateQuery.RatedPackage[idxRates].BillingWeight.Weight.XMLText, qCount)>
				   <cfelse>
					<cfset temp = QuerySetCell(CALLER.rateQuery, "BillableWeight", "")>
				   </cfif>
				   <cfif StructKeyExists(CALLER.aRateQuery.RatedPackage[idxRates].BillingWeight.UnitOfMeasurement, "Code")>	
					<cfset temp = QuerySetCell(CALLER.rateQuery, "WeightUnit", CALLER.aRateQuery.RatedPackage[idxRates].BillingWeight.UnitOfMeasurement.Code.XMLText, qCount)>
				   <cfelse>
					<cfset temp = QuerySetCell(CALLER.rateQuery, "WeightUnit", "")>
				   </cfif>
				   <cfif StructKeyExists(CALLER.aRateQuery, "ScheduledDeliveryTime")>	
					<cfset temp = QuerySetCell(CALLER.rateQuery, "ScheduledDelivTime", CALLER.aRateQuery.ScheduledDeliveryTime.XMLText, qCount)>
				   <cfelse>
					<cfset temp = QuerySetCell(CALLER.rateQuery, "ScheduledDelivTime", "")>
				   </cfif>
				   <cfif StructKeyExists(CALLER.aRateQuery.RatedPackage[idxRates].ServiceOptionsCharges, "MonetaryValue")>	
					<cfset temp = QuerySetCell(CALLER.rateQuery, "OptionCharges", CALLER.aRateQuery.RatedPackage[idxRates].ServiceOptionsCharges.MonetaryValue.XMLText, qCount)>
				   <cfelse>
					<cfset temp = QuerySetCell(CALLER.rateQuery, "OptionCharges", "")>
				   </cfif>
				   <cfif StructKeyExists(CALLER.aRateQuery.RatedPackage[idxRates].ServiceOptionsCharges, "CurrencyCode")>	
					<cfset temp = QuerySetCell(CALLER.rateQuery, "OptionChargesCurrency", CALLER.aRateQuery.RatedPackage[idxRates].ServiceOptionsCharges.CurrencyCode.XMLText, qCount)>
				   <cfelse>
					<cfset temp = QuerySetCell(CALLER.rateQuery, "OptionChargesCurrency", "")>
				   </cfif>
				   <cfif StructKeyExists(CALLER.aRateQuery.RatedPackage[idxRates].TotalCharges, "MonetaryValue")>	
					<cfset temp = QuerySetCell(CALLER.rateQuery, "PackageTotalCharges", CALLER.aRateQuery.RatedPackage[idxRates].TotalCharges.MonetaryValue.XMLText, qCount)>
				   <cfelse>
					<cfset temp = QuerySetCell(CALLER.rateQuery, "PackageTotalCharges", "")>
				   </cfif>
				   <cfif StructKeyExists(CALLER.aRateQuery.RatedPackage[idxRates].TotalCharges, "CurrencyCode")>	
					<cfset temp = QuerySetCell(CALLER.rateQuery, "PackageChargesCurrency", CALLER.aRateQuery.RatedPackage[idxRates].TotalCharges.CurrencyCode.XMLText, qCount)>
				   <cfelse>
					<cfset temp = QuerySetCell(CALLER.rateQuery, "PackageChargesCurrency", "")>
				   </cfif>
				   <cfif StructKeyExists(CALLER.aRateQuery.Service, "Code")>	
					<cfset temp = QuerySetCell(CALLER.rateQuery, "ServiceLevel", CALLER.aRateQuery.Service.Code.XMLText, qCount)>
				   <cfelse>
					<cfset temp = QuerySetCell(CALLER.rateQuery, "ServiceLevel", "")>
				   </cfif>
				   <cfif StructKeyExists(CALLER.aRateQuery.RatedPackage[idxRates].TotalCharges, "MonetaryValue")>	
					<cfset temp = QuerySetCell(CALLER.rateQuery, "TotalCharges", CALLER.aRateQuery.RatedPackage[idxRates].TotalCharges.MonetaryValue.XMLText, qCount)>
				   <cfelse>
					<cfset temp = QuerySetCell(CALLER.rateQuery, "TotalCharges", "")>
				   </cfif>
				   <cfif StructKeyExists(CALLER.aRateQuery.RatedPackage[idxRates].TotalCharges, "CurrencyCode")>	
					<cfset temp = QuerySetCell(CALLER.rateQuery, "TotalChargesCurrency", CALLER.aRateQuery.RatedPackage[idxRates].TotalCharges.CurrencyCode.XMLText, qCount)>
				   <cfelse>
					<cfset temp = QuerySetCell(CALLER.rateQuery, "TotalChargesCurrency", "")>
				   </cfif>
				   <cfif StructKeyExists(CALLER.aRateQuery.RatedPackage[idxRates], "Weight")>
					<cfset temp = QuerySetCell(CALLER.rateQuery, "OriginalWeight", CALLER.aRateQuery.RatedPackage[idxRates].Weight.XMLText, qCount)>
				   <cfelse>
					<cfset temp = QuerySetCell(CALLER.rateQuery, "OriginalWeight", "")>
				   </cfif>
				   
				   <cfset qCount = qCount + 1>
				   			
			  </cfloop>
			  
		<cfelse> <!--- rates returned for 1 package only --->
			   <cfset CALLER.rateQuery = QueryNew("PackageID, GuaranteedDTD, BillableWeight, WeightUnit, ScheduledDelivTime, OptionCharges, OptionChargesCurrency, ServiceLevel, TotalCharges, TotalChargesCurrency, OriginalWeight")>	
			   <cfset CALLER.sRateQuery = CALLER.stUpsRate.RatingServiceSelectionResponse.RatedShipment>
			   <cfset newRow  = QueryAddRow(CALLER.rateQuery, 1)>
				<cfset temp = QuerySetCell(CALLER.rateQuery, "PackageID", "1")>
			   <cfif StructKeyExists(CALLER.sRateQuery, "GuaranteedDaysToDelivery")>	
				<cfset temp = QuerySetCell(CALLER.rateQuery, "GuaranteedDTD", CALLER.sRateQuery.GuaranteedDaysToDelivery.XMLText, 1)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.rateQuery, "GuaranteedDTD", "")>
			   </cfif>
			   <cfif StructKeyExists(CALLER.sRateQuery.RatedPackage.BillingWeight, "Weight")>	
				<cfset temp = QuerySetCell(CALLER.rateQuery, "BillableWeight", CALLER.sRateQuery.RatedPackage.BillingWeight.Weight.XMLText, 1)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.rateQuery, "BillableWeight", "")>
			   </cfif>
			   <cfif StructKeyExists(CALLER.sRateQuery.RatedPackage.BillingWeight.UnitOfMeasurement, "Code")>	
				<cfset temp = QuerySetCell(CALLER.rateQuery, "WeightUnit", CALLER.sRateQuery.RatedPackage.BillingWeight.UnitOfMeasurement.Code.XMLText, 1)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.rateQuery, "WeightUnit", "")>
			   </cfif>
			   <cfif StructKeyExists(CALLER.sRateQuery, "ScheduledDeliveryTime")>	
				<cfset temp = QuerySetCell(CALLER.rateQuery, "ScheduledDelivTime", CALLER.sRateQuery.ScheduledDeliveryTime.XMLText, 1)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.rateQuery, "ScheduledDelivTime", "")>
			   </cfif>
			   <cfif StructKeyExists(CALLER.sRateQuery.RatedPackage.ServiceOptionsCharges, "MonetaryValue")>	
				<cfset temp = QuerySetCell(CALLER.rateQuery, "OptionCharges", CALLER.sRateQuery.RatedPackage.ServiceOptionsCharges.MonetaryValue.XMLText, 1)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.rateQuery, "OptionCharges", "")>
			   </cfif>
			   <cfif StructKeyExists(CALLER.sRateQuery.RatedPackage.ServiceOptionsCharges, "CurrencyCode")>	
				<cfset temp = QuerySetCell(CALLER.rateQuery, "OptionChargesCurrency", CALLER.sRateQuery.RatedPackage.ServiceOptionsCharges.CurrencyCode.XMLText, 1)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.rateQuery, "OptionChargesCurrency", "")>
			   </cfif>
			   <cfif StructKeyExists(CALLER.sRateQuery.Service, "Code")>	
				<cfset temp = QuerySetCell(CALLER.rateQuery, "ServiceLevel", CALLER.sRateQuery.Service.Code.XMLText, 1)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.rateQuery, "ServiceLevel", "")>
			   </cfif>
			   <cfif StructKeyExists(CALLER.sRateQuery.TotalCharges, "MonetaryValue")>	
				<cfset temp = QuerySetCell(CALLER.rateQuery, "TotalCharges", CALLER.sRateQuery.TotalCharges.MonetaryValue.XMLText, 1)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.rateQuery, "TotalCharges", "")>
			   </cfif>
			   <cfif StructKeyExists(CALLER.sRateQuery.TotalCharges, "CurrencyCode")>	
				<cfset temp = QuerySetCell(CALLER.rateQuery, "TotalChargesCurrency", CALLER.sRateQuery.TotalCharges.CurrencyCode.XMLText, 1)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.rateQuery, "TotalChargesCurrency", "")>
			   </cfif>
			   <cfif StructKeyExists(CALLER.sRateQuery.RatedPackage, "Weight")>	
				<cfset temp = QuerySetCell(CALLER.rateQuery, "OriginalWeight", CALLER.sRateQuery.RatedPackage.Weight.XMLText, 1)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.rateQuery, "OriginalWeight", "")>
			   </cfif>
		</cfif>
			   	
	<!--- Transaction Failure --->
	<cfelseif IsDefined("CALLER.stUpsRate.RatingServiceSelectionResponse.Response.RESPONSESTATUSCODE.XmlText") AND 
		#CALLER.stUpsRate.RatingServiceSelectionResponse.Response.RESPONSESTATUSCODE.XmlText# eq 0> <!--- Failure --->
		<cfset CALLER.UPSRateError = 1>
		<cfset CALLER.UPSResponseDesc = CALLER.stUpsRate.RatingServiceSelectionResponse.Response.RESPONSESTATUSDESCRIPTION.XmlText>
		<cfif IsDefined("CALLER.stUpsRate.RatingServiceSelectionResponse.Response.Error.ErrorCode.XmlText")>
			<cfset CALLER.UPSErrorCode = CALLER.stUpsRate.RatingServiceSelectionResponse.Response.Error.ErrorCode.XmlText>
		</cfif>
		<cfif IsDefined("CALLER.stUpsRate.RatingServiceSelectionResponse.Response.Error.ErrorDescription.XmlText")>
			<cfset CALLER.UPSErrorDescription = CALLER.stUpsRate.RatingServiceSelectionResponse.Response.Error.ErrorDescription.XmlText>
		</cfif>
	<cfelse>
	 	<cfset CALLER.UPSRateError = 2>	
		<!--- Error Retrieving rates or communication failure to UPS --->
	</cfif>
	
 </cfcase>
 <!--- UPS Rate for specific Service --->
 
 <!--- UPS Time In Transit --->
 <cfcase value="tntRequest">
 	
	<cfscript>
	todaysDate = Now();
	currentDay = DatePart( "d", todaysDate);
	currentDayNum = DayOfWeek(todaysDate);
	if (currentDayNum eq 1) {
		//Sunday
		todaysDate = todaysDate + 1;
	}
	else if (currentDayNum eq 7) {
		//Saturday
		todaysDate = todaysDate + 2;
	}
		
		pickupDateYear = DatePart("yyyy",todaysDate);
		pickupDateMonth = DatePart("m",todaysDate);
		if ( Len(pickupDateMonth) eq 1 )
			pickupDateMonth = "0"&#pickupDateMonth#;
		pickupDateDay = DatePart("d",todaysDate);
		if ( Len(pickupDateDay) eq 1 ) {
			pickupDateDay = "0"&#pickupDateDay#;
		}
		ATTRIBUTES.pickupDate = #pickupDateYear#&#pickupDateMonth#&#pickupDateDay#;
	
	ATTRIBUTES.TNTAccess = '<?xml version="#ATTRIBUTES.XMLVersion#"?>
	<AccessRequest xml:lang="en-US">
	<AccessLicenseNumber>#ATTRIBUTES.UPSAccessKey#</AccessLicenseNumber>
	<UserId>#ATTRIBUTES.UPSUserID#</UserId>
	<Password>#ATTRIBUTES.UPSPassword#</Password>
	</AccessRequest>';
	ATTRIBUTES.TNTRequest = '<?xml version="#ATTRIBUTES.XMLVersion#"?>
	<TimeInTransitRequest xml:lang="en-US">
		<Request>
		<TransactionReference>
			<CustomerContext>Time In Transit Customer Request</CustomerContext>
			<XpciVersion>#ATTRIBUTES.XPCIVersion#</XpciVersion>
		</TransactionReference>
		<RequestAction>TimeInTransit</RequestAction>
		</Request>
		<TransitFrom>
		<AddressArtifactFormat>
			<CountryCode>#ATTRIBUTES.ShipperCountry#</CountryCode>
			<PoliticalDivision1>#ATTRIBUTES.ShipperState#</PoliticalDivision1>
			<PoliticalDivision2>#ATTRIBUTES.ShipperCity#</PoliticalDivision2>
			<PostcodePrimaryLow>#ATTRIBUTES.ShipperZip#</PostcodePrimaryLow>
		</AddressArtifactFormat>
		</TransitFrom>
		<TransitTo>
		<AddressArtifactFormat>
			<CountryCode>#ATTRIBUTES.ShipToCountry#</CountryCode>
			<PoliticalDivision1>#ATTRIBUTES.ShipToState#</PoliticalDivision1>
			<PoliticalDivision2>#ATTRIBUTES.ShipToCity#</PoliticalDivision2>
			<PostcodePrimaryLow>#ATTRIBUTES.ShipToZip#</PostcodePrimaryLow>
			<ResidentialAddressIndicator>#ATTRIBUTES.ResidentialAddress#</ResidentialAddressIndicator>
		</AddressArtifactFormat>
		</TransitTo>
		<ShipmentWeight>
		<UnitOfMeasurement>
			<Code>#ATTRIBUTES.PackageWeightUnit#</Code>
		</UnitOfMeasurement>
			<Weight>#ATTRIBUTES.PackageWeight#</Weight>
		</ShipmentWeight>
		<InvoiceLineTotal>
			<CurrencyCode>#ATTRIBUTES.CurrencyCode#</CurrencyCode>
			<MonetaryValue>#NumberFormat(ATTRIBUTES.InsuredValue, "999.99")#</MonetaryValue>
		</InvoiceLineTotal>
		<PickupDate>#ATTRIBUTES.pickupDate#</PickupDate>
		<DocumentsOnlyIndicator/>
	</TimeInTransitRequest>';
	
	ATTRIBUTES.XMLRequestInput = '#ATTRIBUTES.TNTAccess#
	#ATTRIBUTES.TNTRequest#';
	</cfscript>
	
	<cfhttp method="post" url="#ATTRIBUTES.tntServer#" resolveurl="yes" port="443" timeout="#ATTRIBUTES.TimeOut#">
		<cfhttpparam name="XML" type="xml" value="#ATTRIBUTES.XMLRequestInput#">
	</cfhttp>
	
	<cfset CALLER.stUpsTNT = XmlParse(cfhttp.FileContent)>
	
	
	<cfif IsDefined("ATTRIBUTES.Debug") AND ATTRIBUTES.Debug eq "TRUE">	
		<cffile action="WRITE" file="#ATTRIBUTES.ServerFilePath##trailingSlash#Debug#trailingSlash#TNTAccess.xml" output="#ATTRIBUTES.TNTAccess#" addnewline="No" nameconflict="overwrite">
		<cffile action="WRITE" file="#ATTRIBUTES.ServerFilePath##trailingSlash#Debug#trailingSlash#TNTRequest.xml" output="#ATTRIBUTES.TNTRequest#" addnewline="No" nameconflict="overwrite">
		<cfoutput><cfdump var="#CALLER.stUpsTNT#">
		<a href="Debug#trailingSlash#TNTAccess.xml" target="_blank">View XML Access File</a>
		<a href="Debug#trailingSlash#TNTRequest.xml" target="_blank">View XML Request File</a>
		</cfoutput>
		<cfabort>
	</cfif>
	
	<cfif IsDefined("CALLER.stUpsTNT.TimeInTransitResponse.Response.RESPONSESTATUSCODE.XmlText") AND #CALLER.stUpsTNT.TimeInTransitResponse.Response.RESPONSESTATUSCODE.XmlText# eq 1> 
	<!--- If multiple cities match supplied zip for origin or destination
	structure is returned with potential Address Artifact array --->
			<cfif IsDefined("CALLER.stUpsTNT.TimeInTransitResponse.TransitFromList.Candidate") AND #IsArray(CALLER.stUpsTNT.TimeInTransitResponse.TransitFromList.Candidate.XmlChildren)#>
		  		<!--- Candidate from addresses returned --->
		  		<cfset CALLER.AddressFromCandidateQuery = QueryNew("CandidateCity, CandidateTown, CandidateState, CandidateZipLow, CandidateZipHigh")>
	  	  		<cfset CALLER.aAddressFromCandidateQuery = CALLER.stUpsTNT.TimeInTransitResponse.TransitFromList.Candidate>
	 	 	 <cfloop index="idx" from="1" to="#ArrayLen(CALLER.aAddressFromCandidateQuery)#">
		   		<cfset newRow  = QueryAddRow(CALLER.AddressFromCandidateQuery, 1)>
			   <cfif StructKeyExists(CALLER.aAddressFromCandidateQuery[idx].AddressArtifactFormat, "PoliticalDivision2")>	
				<cfset temp = QuerySetCell(CALLER.AddressFromCandidateQuery, "CandidateCity", CALLER.aAddressFromCandidateQuery[idx].AddressArtifactFormat.PoliticalDivision2.XmlText, idx)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.AddressFromCandidateQuery, "CandidateCity", "")>
			   </cfif>
			   <cfif StructKeyExists(CALLER.aAddressFromCandidateQuery[idx].AddressArtifactFormat, "PoliticalDivision3")>	
				<cfset temp = QuerySetCell(CALLER.AddressFromCandidateQuery, "CandidateTown", CALLER.aAddressFromCandidateQuery[idx].AddressArtifactFormat.PoliticalDivision3.XmlText, idx)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.AddressFromCandidateQuery, "CandidateTown", "")>
			   </cfif>
			   <cfif StructKeyExists(CALLER.aAddressFromCandidateQuery[idx].AddressArtifactFormat, "PoliticalDivision1")>	
				<cfset temp = QuerySetCell(CALLER.AddressFromCandidateQuery, "CandidateState", CALLER.aAddressFromCandidateQuery[idx].AddressArtifactFormat.PoliticalDivision1.XmlText, idx)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.AddressFromCandidateQuery, "CandidateState", "")>
			   </cfif>
			   <cfif StructKeyExists(CALLER.aAddressFromCandidateQuery[idx].AddressArtifactFormat, "PostcodePrimaryLow")>	
				<cfset temp = QuerySetCell(CALLER.AddressFromCandidateQuery, "CandidateZipLow", CALLER.aAddressFromCandidateQuery[idx].AddressArtifactFormat.PostcodePrimaryLow.XmlText, idx)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.AddressFromCandidateQuery, "CandidateZipLow", "")>
			   </cfif>
			   <cfif StructKeyExists(CALLER.aAddressFromCandidateQuery[idx].AddressArtifactFormat, "PostcodePrimaryHigh")>	
				<cfset temp = QuerySetCell(CALLER.AddressFromCandidateQuery, "CandidateZipHigh", CALLER.aAddressFromCandidateQuery[idx].AddressArtifactFormat.PostcodePrimaryHigh.XmlText, idx)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.AddressFromCandidateQuery, "CandidateZipHigh", "")>
			   </cfif>
			</cfloop>
			</cfif>

			<cfif IsDefined("CALLER.stUpsTNT.TimeInTransitResponse.TransitToList.Candidate") AND #IsArray(CALLER.stUpsTNT.TimeInTransitResponse.TransitToList.Candidate.XmlChildren)#>
		  		<!--- Candidate to addresses returned --->
		  		<cfset CALLER.AddressToCandidateQuery = QueryNew("CandidateCity, CandidateTown, CandidateState, CandidateZipLow, CandidateZipHigh")>
	  	  		<cfset CALLER.aAddressToCandidateQuery = CALLER.stUpsTNT.TimeInTransitResponse.TransitToList.Candidate>
	 	 	 <cfloop index="idx" from="1" to="#ArrayLen(CALLER.aAddressToCandidateQuery)#">
		   		<cfset newRow  = QueryAddRow(CALLER.AddressToCandidateQuery, 1)>
			   <cfif StructKeyExists(CALLER.aAddressToCandidateQuery[idx].AddressArtifactFormat, "PoliticalDivision2")>	
				<cfset temp = QuerySetCell(CALLER.AddressToCandidateQuery, "CandidateCity", CALLER.aAddressToCandidateQuery[idx].AddressArtifactFormat.PoliticalDivision2.XmlText, idx)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.AddressToCandidateQuery, "CandidateCity", "")>
			   </cfif>
			   <cfif StructKeyExists(CALLER.aAddressToCandidateQuery[idx].AddressArtifactFormat, "PoliticalDivision3")>	
				<cfset temp = QuerySetCell(CALLER.AddressToCandidateQuery, "CandidateTown", CALLER.aAddressToCandidateQuery[idx].AddressArtifactFormat.PoliticalDivision3.XmlText, idx)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.AddressToCandidateQuery, "CandidateTown", "")>
			   </cfif>
			   <cfif StructKeyExists(CALLER.aAddressToCandidateQuery[idx].AddressArtifactFormat, "PoliticalDivision1")>	
				<cfset temp = QuerySetCell(CALLER.AddressToCandidateQuery, "CandidateState", CALLER.aAddressToCandidateQuery[idx].AddressArtifactFormat.PoliticalDivision1.XmlText, idx)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.AddressToCandidateQuery, "CandidateState", "")>
			   </cfif>
			   <cfif StructKeyExists(CALLER.aAddressToCandidateQuery[idx].AddressArtifactFormat, "PostcodePrimaryLow")>	
				<cfset temp = QuerySetCell(CALLER.AddressToCandidateQuery, "CandidateZipLow", CALLER.aAddressToCandidateQuery[idx].AddressArtifactFormat.PostcodePrimaryLow.XmlText, idx)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.AddressToCandidateQuery, "CandidateZipLow", "")>
			   </cfif>
			   <cfif StructKeyExists(CALLER.aAddressToCandidateQuery[idx].AddressArtifactFormat, "PostcodePrimaryHigh")>	
				<cfset temp = QuerySetCell(CALLER.AddressToCandidateQuery, "CandidateZipHigh", CALLER.aAddressToCandidateQuery[idx].AddressArtifactFormat.PostcodePrimaryHigh.XmlText, idx)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.AddressToCandidateQuery, "CandidateZipHigh", "")>
			   </cfif>
			</cfloop>
			</cfif>

	 <cfif IsDefined("CALLER.stUpsTNT.TIMEINTRANSITRESPONSE.TRANSITRESPONSE.SERVICESUMMARY") AND #IsArray(CALLER.stUpsTNT.TimeInTransitResponse.TransitResponse.ServiceSummary.XmlChildren)#>
		<cfif IsDefined("CALLER.stUpsTNT.TIMEINTRANSITRESPONSE.TransitResponse.DISCLAIMER.XmlText")>
			<cfset CALLER.UPSDisclaimer = CALLER.stUpsTNT.TIMEINTRANSITRESPONSE.TransitResponse.DISCLAIMER.XmlText>
		</cfif>
	  <!--- Loop through the transit time results --->
	  <cfset CALLER.TntQuery = QueryNew("BusinessDays, EstDelivDate, EstDelivDay, EstDelivTime, CorrectedPickupDate, ServiceGuaranteed, ServiceCode, ServiceDesc")>
	  <cfset CALLER.aTntQuery = CALLER.stUpsTNT.TimeInTransitResponse.TransitResponse.ServiceSummary>
	 	<cfloop index="idx" from="1" to="#ArrayLen(CALLER.aTntQuery)#">
		   		<cfset newRow  = QueryAddRow(CALLER.TntQuery, 1)>
 			   <cfif StructKeyExists(CALLER.aTntQuery[idx].EstimatedArrival, "BusinessTransitDays")>	
				<cfset temp = QuerySetCell(CALLER.TntQuery, "BusinessDays", CALLER.aTntQuery[idx].EstimatedArrival.BusinessTransitDays.XmlText, idx)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.TntQuery, "BusinessDays", "")>
			   </cfif>
			   <cfif StructKeyExists(CALLER.aTntQuery[idx].EstimatedArrival, "Date")>	
				<cfset temp = QuerySetCell(CALLER.TntQuery, "EstDelivDate", CALLER.aTntQuery[idx].EstimatedArrival.Date.XmlText, idx)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.TntQuery, "EstDelivDate", "")>
			   </cfif>
			   <cfif StructKeyExists(CALLER.aTntQuery[idx].EstimatedArrival, "DayOfWeek")>	
				<cfset temp = QuerySetCell(CALLER.TntQuery, "EstDelivDay", CALLER.aTntQuery[idx].EstimatedArrival.DayOfWeek.XmlText, idx)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.TntQuery, "EstDelivDay", "")>
			   </cfif>
			   <cfif StructKeyExists(CALLER.aTntQuery[idx].EstimatedArrival, "Time")>	
				<cfset temp = QuerySetCell(CALLER.TntQuery, "EstDelivTime", CALLER.aTntQuery[idx].EstimatedArrival.Time.XmlText, idx)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.TntQuery, "EstDelivTime", "")>
			   </cfif>
			   <cfif StructKeyExists(CALLER.aTntQuery[idx].EstimatedArrival, "PICKUPDATE")>	
				<cfset temp = QuerySetCell(CALLER.TntQuery, "CorrectedPickupDate", CALLER.aTntQuery[idx].EstimatedArrival.PICKUPDATE.XmlText, idx)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.TntQuery, "CorrectedPickupDate", "")>
			   </cfif>
			   <cfif StructKeyExists(CALLER.aTntQuery[idx].Guaranteed, "Code")>	
				<cfset temp = QuerySetCell(CALLER.TntQuery, "ServiceGuaranteed", CALLER.aTntQuery[idx].Guaranteed.Code.XmlText, idx)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.TntQuery, "ServiceGuaranteed", "")>
			   </cfif>
			   <cfif StructKeyExists(CALLER.aTntQuery[idx].Service, "Code")>	
				<cfset temp = QuerySetCell(CALLER.TntQuery, "ServiceCode", CALLER.aTntQuery[idx].Service.Code.XmlText, idx)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.TntQuery, "ServiceCode", "")>
			   </cfif>
			   <cfif StructKeyExists(CALLER.aTntQuery[idx].Service, "Description")>	
				<cfset temp = QuerySetCell(CALLER.TntQuery, "ServiceDesc", CALLER.aTntQuery[idx].Service.Description.XmlText, idx)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.TntQuery, "ServiceDesc", "")>
			   </cfif>			   
		</cfloop>
			
		<cfelse>
			<!--- Structure returned is invalid --->
			<cfset UPSTNTError = 3>
		</cfif>
		
	<cfelseif IsDefined("CALLER.stUpsTNT.TimeInTransitResponse.Response.RESPONSESTATUSCODE.XmlText") AND
		CALLER.stUpsTNT.TimeInTransitResponse.Response.RESPONSESTATUSCODE.XmlText eq 0>
		<cfset UPSTNTError = 1> <!--- Response fine, transaction failed however --->
		<cfif IsDefined("CALLER.stUpsTNT.TimeInTransitResponse.Response.Error.ErrorCode.XmlText")>
			<cfset CALLER.UPSErrorCode = CALLER.stUpsTNT.TimeInTransitResponse.Response.Error.ErrorCode.XmlText>
		</cfif>
		<cfif IsDefined("CALLER.stUpsTNT.TimeInTransitResponse.Response.Error.ErrorDescription.XmlText")>
			<cfset CALLER.UPSErrorDescription = CALLER.stUpsTNT.TimeInTransitResponse.Response.Error.ErrorDescription.XmlText>
		</cfif>
	
	<cfelse>
		<cfset UPSTNTError = 2>
	</cfif>
	
 </cfcase>
 <!--- END UPS Time In Transit --->
 
 <!--- UPS UPS Track Request --->
 <cfcase value="trackRequest">
 	
	<cfscript>	
	ATTRIBUTES.TrackAccess = '<?xml version="#ATTRIBUTES.XMLVersion#"?>
	<AccessRequest xml:lang="en-US">
	<AccessLicenseNumber>#ATTRIBUTES.UPSAccessKey#</AccessLicenseNumber>
		<UserId>#ATTRIBUTES.UPSUserID#</UserId>
		<Password>#ATTRIBUTES.UPSPassword#</Password>
	</AccessRequest>';
	
	ATTRIBUTES.TrackRequest = '<?xml version="#ATTRIBUTES.XMLVersion#"?>
	<TrackRequest xml:lang="en-US">
		<Request>
			<TransactionReference>
				<CustomerContext>Tracking Activity Request</CustomerContext>
				<XpciVersion>#ATTRIBUTES.XPCIVersion#</XpciVersion>
			</TransactionReference>
			<RequestAction>Track</RequestAction>
			<RequestOption>activity</RequestOption>
		</Request>
			<TrackingNumber>#ATTRIBUTES.TrackingNumber#</TrackingNumber>
	</TrackRequest>';
	
	ATTRIBUTES.XMLRequestInput = '#ATTRIBUTES.TrackAccess#
	#ATTRIBUTES.TrackRequest#';
	
	</cfscript>
	
	<cfhttp method="post" url="#ATTRIBUTES.trackServer#" resolveurl="yes" port="443" timeout="#ATTRIBUTES.TimeOut#">
		<cfhttpparam name="XML" type="xml" value="#ATTRIBUTES.XMLRequestInput#">
	</cfhttp>
	
	<cfset CALLER.stUpsTrack = XmlParse(Trim(cfhttp.FileContent))>
	
	<cfif IsDefined("ATTRIBUTES.Debug") AND ATTRIBUTES.Debug eq "TRUE">	
		<cffile action="WRITE" file="#ATTRIBUTES.ServerFilePath##trailingSlash#Debug#trailingSlash#TrackAccess.xml" output="#ATTRIBUTES.TrackAccess#" addnewline="No" nameconflict="overwrite">
		<cffile action="WRITE" file="#ATTRIBUTES.ServerFilePath##trailingSlash#Debug#trailingSlash#TrackRequest.xml" output="#ATTRIBUTES.TrackRequest#" addnewline="No" nameconflict="overwrite">
		<cfoutput><cfdump var="#CALLER.stUpsTrack#">
		<a href="Debug#trailingSlash#TrackAccess.xml" target="_blank">View XML Access File</a>
		<a href="Debug#trailingSlash#TrackRequest.xml" target="_blank">View XML Request File</a>
		</cfoutput>
		<cfabort>
	</cfif>
	
		<!--- <cfoutput><cfdump var="#CALLER.stUpsTrack#"></cfoutput> --->
	<cfif IsDefined("CALLER.stUpsTrack.TrackResponse.Response.ResponseStatusCode.XmlText") AND #CALLER.stUpsTrack.TrackResponse.Response.ResponseStatusCode.XmlText# eq 1> 
		<cfset CALLER.UPSTrackError = 0>	
 	 
	 <cfif IsDefined("CALLER.stUpsTrack.TrackResponse.Shipment.Package") AND ( ArrayLen(XmlSearch(CALLER.stUpsTrack, "/TrackResponse/Shipment/Package")) gt 1)>	 
		<cfset CALLER.TrackActivityQueryMultiple = #ArrayLen(CALLER.stUpsTrack.TrackResponse.Shipment.Package)#> <!--- There will be multiple activity queries returned --->
		<!--- Package Element is an array --->
		   <cfset CALLER.PackageListQuery = QueryNew("Weight, WeightUnit, TrackingNumber, ActivityQuery")>
		   <cfloop index="i" from="1" to="#ArrayLen(CALLER.stUpsTrack.TrackResponse.Shipment.Package)#">
				<cfset newRow  = QueryAddRow(CALLER.PackageListQuery, 1)>
				<cfset temp = QuerySetCell(CALLER.PackageListQuery, "Weight", #CALLER.stUpsTrack.TrackResponse.Shipment.Package[i].PackageWeight.Weight.XmlText#, #i#)>
				<cfset temp = QuerySetCell(CALLER.PackageListQuery, "WeightUnit", #CALLER.stUpsTrack.TrackResponse.Shipment.Package[i].PackageWeight.UnitOfMeasurement.Code.XmlText#, #i#)>
				<cfset temp = QuerySetCell(CALLER.PackageListQuery, "TrackingNumber", #CALLER.stUpsTrack.TrackResponse.Shipment.Package[i].TRACKINGNUMBER.XmlText#, #i#)>
		   		 
				 <cfif #IsArray(CALLER.stUpsTrack.TrackResponse.Shipment.Package[i].Activity.XmlChildren)#>
				  <!--- Loop through the activity results --->
				  <cfset CALLER.TrackActivityQuery = QueryNew("AddressCity, AddressCountry, AddressZip, AddressState, LocationDesc, LocationSignedBy, ActivityDate, StatusTypeDesc, StatusTypeCode, ActivityTime")>
				  <cfset CALLER.aTrackActivityQuery = CALLER.stUpsTrack.TrackResponse.Shipment.Package[i].Activity>
					<cfloop index="idx" from="1" to="#ArrayLen(CALLER.aTrackActivityQuery)#">
							<cfset newRow  = QueryAddRow(CALLER.TrackActivityQuery, 1)>
						   <cfif StructKeyExists(CALLER.aTrackActivityQuery[idx].ActivityLocation.Address, "City")>	
							<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "AddressCity", CALLER.aTrackActivityQuery[idx].ActivityLocation.Address.City.XmlText, idx)>
						   <cfelse>
							<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "AddressCity", "")>
						   </cfif>
						   <cfif StructKeyExists(CALLER.aTrackActivityQuery[idx].ActivityLocation.Address, "CountryCode")>	
							<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "AddressCountry", CALLER.aTrackActivityQuery[idx].ActivityLocation.Address.CountryCode.XmlText, idx)>
						   <cfelse>
							<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "AddressCountry", "")>
						   </cfif>
						   <cfif StructKeyExists(CALLER.aTrackActivityQuery[idx].ActivityLocation.Address, "PostalCode")>	
							<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "AddressZip", CALLER.aTrackActivityQuery[idx].ActivityLocation.Address.PostalCode.XmlText, idx)>
						   <cfelse>
							<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "AddressZip", "")>
						   </cfif>
						   <cfif StructKeyExists(CALLER.aTrackActivityQuery[idx].ActivityLocation.Address, "StateProvinceCode")>	
							<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "AddressState", CALLER.aTrackActivityQuery[idx].ActivityLocation.Address.StateProvinceCode.XmlText, idx)>
						   <cfelse>
							<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "AddressState", "")>
						   </cfif>
						   <cfif StructKeyExists(CALLER.aTrackActivityQuery[idx].ActivityLocation, "Description")>	
							<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "LocationDesc", CALLER.aTrackActivityQuery[idx].ActivityLocation.Description.XmlText, idx)>
						   <cfelse>
							<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "LocationDesc", "")>
						   </cfif>
						   <cfif StructKeyExists(CALLER.aTrackActivityQuery[idx].ActivityLocation, "SignedForByName")>	
							<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "LocationSignedBy", CALLER.aTrackActivityQuery[idx].ActivityLocation.SignedForByName.XmlText, idx)>
						   <cfelse>
							<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "LocationSignedBy", "")>
						   </cfif>
						   <cfif StructKeyExists(CALLER.aTrackActivityQuery[idx], "Date")>	
							<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "ActivityDate", CALLER.aTrackActivityQuery[idx].Date.XmlText, idx)>
						   <cfelse>
							<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "ActivityDate", "")>
						   </cfif>
						   <!--- Documentation incorrectly states value of zero to one for this element but it may be an array --->
						   <cfif #IsArray(CALLER.aTrackActivityQuery[idx].Status.StatusType.Description.XmlChildren)#>
							 <cfset StatusTypeDescList = "">
							<cfloop index="j" from="1" to="#ArrayLen(CALLER.aTrackActivityQuery[idx].Status.StatusType.Description)#">
							 <cfset StatusTypeDescList = CALLER.aTrackActivityQuery[idx].Status.StatusType.Description[j].XmlText&",">
							</cfloop>
							 <cfif Right(StatusTypeDescList, 1) eq ",">
								<cfset vLen = Len(StatusTypeDescList)>
								<cfset StatusTypeDescList = Left(StatusTypeDescList, (vLen - 1))>
							 </cfif>
							 <cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "StatusTypeDesc", "#StatusTypeDescList#")>			 
						   <cfelseif StructKeyExists(CALLER.aTrackActivityQuery[idx].Status.StatusType, "Description")>	
							<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "StatusTypeDesc", CALLER.aTrackActivityQuery[idx].Status.StatusType.Description.XmlText, idx)>
						   <cfelse>
							<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "StatusTypeDesc", "")>
						   </cfif>
						   <cfif StructKeyExists(CALLER.aTrackActivityQuery[idx].Status.StatusType, "Code")>	
							<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "StatusTypeCode", CALLER.aTrackActivityQuery[idx].Status.StatusType.Code.XmlText, idx)>
						   <cfelse>
							<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "StatusTypeCode", "")>
						   </cfif>
						   <cfif StructKeyExists(CALLER.aTrackActivityQuery[idx], "Time")>	
							<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "ActivityTime", CALLER.aTrackActivityQuery[idx].Time.XmlText, idx)>
						   <cfelse>
							<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "ActivityTime", "")>
						   </cfif>
					</cfloop>
					<cfwddx action="cfml2wddx" input="#CALLER.TrackActivityQuery#" output="wddxActivityQuery">
					<cfset temp = QuerySetCell(CALLER.PackageListQuery, "ActivityQuery", #wddxActivityQuery#, #i#)>
				 
				 <cfelse>
				 <!--- Not a activity array, simply a structure --->
				 		<cfset CALLER.UPSTrackError = 0>
						<cfset CALLER.TrackActivityQuery = QueryNew("AddressCity, AddressCountry, AddressZip, AddressState, LocationDesc, LocationSignedBy, ActivityDate, StatusTypeDesc, StatusTypeCode, ActivityTime")>
	  					<cfset CALLER.aTrackActivityQuery = CALLER.stUpsTrack.TrackResponse.Shipment.Package[i].Activity>
						<cfset newRow  = QueryAddRow(CALLER.TrackActivityQuery, 1)>
					   <cfif StructKeyExists(CALLER.aTrackActivityQuery.ActivityLocation.Address, "City")>	
						<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "AddressCity", CALLER.aTrackActivityQuery.ActivityLocation.Address.City.XmlText, 1)>
					   <cfelse>
						<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "AddressCity", "")>
					   </cfif>
					   <cfif StructKeyExists(CALLER.aTrackActivityQuery.ActivityLocation.Address, "CountryCode")>	
						<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "AddressCountry", CALLER.aTrackActivityQuery.ActivityLocation.Address.CountryCode.XmlText, 1)>
					   <cfelse>
						<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "AddressCountry", "")>
					   </cfif>
					   <cfif StructKeyExists(CALLER.aTrackActivityQuery.ActivityLocation.Address, "PostalCode")>	
						<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "AddressZip", CALLER.aTrackActivityQuery.ActivityLocation.Address.PostalCode.XmlText, 1)>
					   <cfelse>
						<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "AddressZip", "")>
					   </cfif>
					   <cfif StructKeyExists(CALLER.aTrackActivityQuery.ActivityLocation.Address, "StateProvinceCode")>	
						<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "AddressState", CALLER.aTrackActivityQuery.ActivityLocation.Address.StateProvinceCode.XmlText, 1)>
					   <cfelse>
						<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "AddressState", "")>
					   </cfif>
					   <cfif StructKeyExists(CALLER.aTrackActivityQuery.ActivityLocation, "Description")>	
						<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "LocationDesc", CALLER.aTrackActivityQuery.ActivityLocation.Description.XmlText, 1)>
					   <cfelse>
						<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "LocationDesc", "")>
					   </cfif>
					   <cfif StructKeyExists(CALLER.aTrackActivityQuery.ActivityLocation, "SignedForByName")>	
						<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "LocationSignedBy", CALLER.aTrackActivityQuery.ActivityLocation.SignedForByName.XmlText, 1)>
					   <cfelse>
						<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "LocationSignedBy", "")>
					   </cfif>
					   <cfif StructKeyExists(CALLER.aTrackActivityQuery, "Date")>	
						<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "ActivityDate", CALLER.aTrackActivityQuery.Date.XmlText, 1)>
					   <cfelse>
						<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "ActivityDate", "")>
					   </cfif>
					   <!--- Documentation incorrectly states value of zero to one for this element but it may be an array --->
					   <cfif #IsArray(CALLER.aTrackActivityQuery.Status.StatusType.Description.XmlChildren)#>
						 <cfset StatusTypeDescList = "">
						<cfloop index="j" from="1" to="#ArrayLen(CALLER.aTrackActivityQuery.Status.StatusType.Description)#">
						 <cfset StatusTypeDescList = CALLER.aTrackActivityQuery.Status.StatusType.Description[j].XmlText&",">
						</cfloop>
						 <cfif Right(StatusTypeDescList, 1) eq ",">
							<cfset vLen = Len(StatusTypeDescList)>
							<cfset StatusTypeDescList = Left(StatusTypeDescList, (vLen - 1))>
						 </cfif>
						 <cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "StatusTypeDesc", "#StatusTypeDescList#")>			 			   
					   <cfelseif StructKeyExists(CALLER.aTrackActivityQuery.Status.StatusType, "Description")>	
						<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "StatusTypeDesc", CALLER.aTrackActivityQuery.Status.StatusType.Description.XmlText, 1)>
					   <cfelse>
						<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "StatusTypeDesc", "")>
					   </cfif>
					   <cfif StructKeyExists(CALLER.aTrackActivityQuery.Status.StatusType, "Code")>	
						<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "StatusTypeCode", CALLER.aTrackActivityQuery.Status.StatusType.Code.XmlText, 1)>
					   <cfelse>
						<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "StatusTypeCode", "")>
					   </cfif>
					   <cfif StructKeyExists(CALLER.aTrackActivityQuery, "Time")>	
						<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "ActivityTime", CALLER.aTrackActivityQuery.Time.XmlText, 1)>
					   <cfelse>
						<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "ActivityTime", "")>
					   </cfif>

					<cfwddx action="cfml2wddx" input="#CALLER.TrackActivityQuery#" output="wddxActivityQuery">
					<cfset temp = QuerySetCell(CALLER.PackageListQuery, "ActivityQuery", #wddxActivityQuery#, #i#)>
				 
				 </cfif>
				 
		   </cfloop>
			<cfif IsDefined("CALLER.stUpsTrack.TrackResponse.Shipment.Service.Code.XmlText")>
				<cfset CALLER.UPSServiceCode = CALLER.stUpsTrack.TrackResponse.Shipment.Service.Code.XmlText>
			</cfif>
			<cfif IsDefined("CALLER.stUpsTrack.TrackResponse.Shipment.Service.Description.XmlText")>
				<cfset CALLER.UPSServiceDesc = CALLER.stUpsTrack.TrackResponse.Shipment.Service.Description.XmlText>
			</cfif>
			<cfif IsDefined("CALLER.stUpsTrack.TrackResponse.Shipment.Shipper.Address.AddressLine1.XmlText")>
				<cfset CALLER.UPSShipperAddress1 = CALLER.stUpsTrack.TrackResponse.Shipment.Shipper.Address.AddressLine1.XmlText>
			</cfif>
			<cfif IsDefined("CALLER.stUpsTrack.TrackResponse.Shipment.Shipper.Address.AddressLine2.XmlText")>
				<cfset CALLER.UPSShipperAddress2 = CALLER.stUpsTrack.TrackResponse.Shipment.Shipper.Address.AddressLine2.XmlText>
			</cfif>
			<cfif IsDefined("CALLER.stUpsTrack.TrackResponse.Shipment.Shipper.Address.AddressLine3.XmlText")>
				<cfset CALLER.UPSShipperAddress3 = CALLER.stUpsTrack.TrackResponse.Shipment.Shipper.Address.AddressLine3.XmlText>
			</cfif>
			<cfif IsDefined("CALLER.stUpsTrack.TrackResponse.Shipment.Shipper.Address.City.XmlText")>
				<cfset CALLER.UPSShipperCity = CALLER.stUpsTrack.TrackResponse.Shipment.Shipper.Address.City.XmlText>
			</cfif>
			<cfif IsDefined("CALLER.stUpsTrack.TrackResponse.Shipment.Shipper.Address.StateProvinceCode.XmlText")>
				<cfset CALLER.UPSShipperState = CALLER.stUpsTrack.TrackResponse.Shipment.Shipper.Address.StateProvinceCode.XmlText>
			</cfif>
			<cfif IsDefined("CALLER.stUpsTrack.TrackResponse.Shipment.Shipper.Address.PostalCode.XmlText")>
				<cfset CALLER.UPSShipperZip = CALLER.stUpsTrack.TrackResponse.Shipment.Shipper.Address.PostalCode.XmlText>
			</cfif>
			<cfif IsDefined("CALLER.stUpsTrack.TrackResponse.Shipment.Shipper.Address.CountryCode.XmlText")>
				<cfset CALLER.UPSShipperCountry = CALLER.stUpsTrack.TrackResponse.Shipment.Shipper.Address.CountryCode.XmlText>
			</cfif>
			<cfif IsDefined("CALLER.stUpsTrack.TrackResponse.Shipment.Shipper.SHIPPERNUMBER.XmlText")>
				<cfset CALLER.UPSShipperNumber = CALLER.stUpsTrack.TrackResponse.Shipment.Shipper.SHIPPERNUMBER.XmlText>
			</cfif>
			<cfif IsDefined("CALLER.stUpsTrack.TrackResponse.Shipment.ScheduledDeliveryDate.XmlText")>
				<cfset CALLER.UPSEstimatedDelivDate = CALLER.stUpsTrack.TrackResponse.Shipment.ScheduledDeliveryDate.XmlText>
			</cfif>
			<cfif IsDefined("CALLER.stUpsTrack.TrackResponse.Shipment.ScheduledDeliveryTime.XmlText")>
				<cfset CALLER.UPSEstimatedDelivTime = CALLER.stUpsTrack.TrackResponse.Shipment.ScheduledDeliveryTime.XmlText>
			</cfif>
			<cfif IsDefined("CALLER.stUpsTrack.TrackResponse.Shipment.PICKUPDATE.XmlText")>
				<cfset CALLER.UPSPickupDate = CALLER.stUpsTrack.TrackResponse.Shipment.PICKUPDATE.XmlText>
			</cfif>
	
		<!--- package element structure only --->
		<cfelseif IsDefined("CALLER.stUpsTrack.TrackResponse.Shipment.Package")>
				<cfset CALLER.TrackActivityQueryMultiple = 0> <!--- There will be only 1 activity query returned --->
	
			<cfif IsDefined("CALLER.stUpsTrack.TrackResponse.Shipment.Package.PackageWeight.Weight.XmlText")>
				<cfset CALLER.UPSPackageWeight = CALLER.stUpsTrack.TrackResponse.Shipment.Package.PackageWeight.Weight.XmlText>
			</cfif>
			<cfif IsDefined("CALLER.stUpsTrack.TrackResponse.Shipment.Package.PackageWeight.UnitOfMeasurement.Code.XmlText")>
				<cfset CALLER.UPSPackageWeightUnit = CALLER.stUpsTrack.TrackResponse.Shipment.Package.PackageWeight.UnitOfMeasurement.Code.XmlText>
			</cfif>
			<cfif IsDefined("CALLER.stUpsTrack.TrackResponse.Shipment.Package.TRACKINGNUMBER.XmlText")>
				<cfset CALLER.UPSTrackingNumber = CALLER.stUpsTrack.TrackResponse.Shipment.Package.TRACKINGNUMBER.XmlText>
			</cfif>
			<cfif IsDefined("CALLER.stUpsTrack.TrackResponse.Shipment.Service.Code.XmlText")>
				<cfset CALLER.UPSServiceCode = CALLER.stUpsTrack.TrackResponse.Shipment.Service.Code.XmlText>
			</cfif>
			<cfif IsDefined("CALLER.stUpsTrack.TrackResponse.Shipment.Service.Description.XmlText")>
				<cfset CALLER.UPSServiceDesc = CALLER.stUpsTrack.TrackResponse.Shipment.Service.Description.XmlText>
			</cfif>
			<cfif IsDefined("CALLER.stUpsTrack.TrackResponse.Shipment.Shipper.Address.AddressLine1.XmlText")>
				<cfset CALLER.UPSShipperAddress1 = CALLER.stUpsTrack.TrackResponse.Shipment.Shipper.Address.AddressLine1.XmlText>
			</cfif>
			<cfif IsDefined("CALLER.stUpsTrack.TrackResponse.Shipment.Shipper.Address.AddressLine2.XmlText")>
				<cfset CALLER.UPSShipperAddress2 = CALLER.stUpsTrack.TrackResponse.Shipment.Shipper.Address.AddressLine2.XmlText>
			</cfif>
			<cfif IsDefined("CALLER.stUpsTrack.TrackResponse.Shipment.Shipper.Address.AddressLine3.XmlText")>
				<cfset CALLER.UPSShipperAddress3 = CALLER.stUpsTrack.TrackResponse.Shipment.Shipper.Address.AddressLine3.XmlText>
			</cfif>
			<cfif IsDefined("CALLER.stUpsTrack.TrackResponse.Shipment.Shipper.Address.City.XmlText")>
				<cfset CALLER.UPSShipperCity = CALLER.stUpsTrack.TrackResponse.Shipment.Shipper.Address.City.XmlText>
			</cfif>
			<cfif IsDefined("CALLER.stUpsTrack.TrackResponse.Shipment.Shipper.Address.StateProvinceCode.XmlText")>
				<cfset CALLER.UPSShipperState = CALLER.stUpsTrack.TrackResponse.Shipment.Shipper.Address.StateProvinceCode.XmlText>
			</cfif>
			<cfif IsDefined("CALLER.stUpsTrack.TrackResponse.Shipment.Shipper.Address.PostalCode.XmlText")>
				<cfset CALLER.UPSShipperZip = CALLER.stUpsTrack.TrackResponse.Shipment.Shipper.Address.PostalCode.XmlText>
			</cfif>
			<cfif IsDefined("CALLER.stUpsTrack.TrackResponse.Shipment.Shipper.Address.CountryCode.XmlText")>
				<cfset CALLER.UPSShipperCountry = CALLER.stUpsTrack.TrackResponse.Shipment.Shipper.Address.CountryCode.XmlText>
			</cfif>
			<cfif IsDefined("CALLER.stUpsTrack.TrackResponse.Shipment.Shipper.SHIPPERNUMBER.XmlText")>
				<cfset CALLER.UPSShipperNumber = CALLER.stUpsTrack.TrackResponse.Shipment.Shipper.SHIPPERNUMBER.XmlText>
			</cfif>
			<cfif IsDefined("CALLER.stUpsTrack.TrackResponse.Shipment.ScheduledDeliveryDate.XmlText")>
				<cfset CALLER.UPSEstimatedDelivDate = CALLER.stUpsTrack.TrackResponse.Shipment.ScheduledDeliveryDate.XmlText>
			</cfif>
			<cfif IsDefined("CALLER.stUpsTrack.TrackResponse.Shipment.ScheduledDeliveryTime.XmlText")>
				<cfset CALLER.UPSEstimatedDelivTime = CALLER.stUpsTrack.TrackResponse.Shipment.ScheduledDeliveryTime.XmlText>
			</cfif>
			<cfif IsDefined("CALLER.stUpsTrack.TrackResponse.Shipment.PICKUPDATE.XmlText")>
				<cfset CALLER.UPSPickupDate = CALLER.stUpsTrack.TrackResponse.Shipment.PICKUPDATE.XmlText>
			</cfif>
			 
	 <!--- If activity array was returned --->
	 <cfif IsDefined("CALLER.stUpsTrack.TrackResponse.Shipment.Package.Activity") AND #IsArray(CALLER.stUpsTrack.TrackResponse.Shipment.Package.Activity.XmlChildren)#>
	
	  <!--- Loop through the activity results --->
	  <cfset CALLER.TrackActivityQuery = QueryNew("AddressCity, AddressCountry, AddressZip, AddressState, LocationDesc, LocationSignedBy, ActivityDate, StatusTypeDesc, StatusTypeCode, ActivityTime")>
	  <cfset CALLER.aTrackActivityQuery = CALLER.stUpsTrack.TrackResponse.Shipment.Package.Activity>
		<cfloop index="idx" from="1" to="#ArrayLen(CALLER.aTrackActivityQuery)#">
		   		<cfset newRow  = QueryAddRow(CALLER.TrackActivityQuery, 1)>
 			   <cfif StructKeyExists(CALLER.aTrackActivityQuery[idx].ActivityLocation.Address, "City")>	
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "AddressCity", CALLER.aTrackActivityQuery[idx].ActivityLocation.Address.City.XmlText, idx)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "AddressCity", "")>
			   </cfif>
			   <cfif StructKeyExists(CALLER.aTrackActivityQuery[idx].ActivityLocation.Address, "CountryCode")>	
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "AddressCountry", CALLER.aTrackActivityQuery[idx].ActivityLocation.Address.CountryCode.XmlText, idx)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "AddressCountry", "")>
			   </cfif>
			   <cfif StructKeyExists(CALLER.aTrackActivityQuery[idx].ActivityLocation.Address, "PostalCode")>	
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "AddressZip", CALLER.aTrackActivityQuery[idx].ActivityLocation.Address.PostalCode.XmlText, idx)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "AddressZip", "")>
			   </cfif>
			   <cfif StructKeyExists(CALLER.aTrackActivityQuery[idx].ActivityLocation.Address, "StateProvinceCode")>	
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "AddressState", CALLER.aTrackActivityQuery[idx].ActivityLocation.Address.StateProvinceCode.XmlText, idx)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "AddressState", "")>
			   </cfif>
			   <cfif StructKeyExists(CALLER.aTrackActivityQuery[idx].ActivityLocation, "Description")>	
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "LocationDesc", CALLER.aTrackActivityQuery[idx].ActivityLocation.Description.XmlText, idx)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "LocationDesc", "")>
			   </cfif>
			   <cfif StructKeyExists(CALLER.aTrackActivityQuery[idx].ActivityLocation, "SignedForByName")>	
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "LocationSignedBy", CALLER.aTrackActivityQuery[idx].ActivityLocation.SignedForByName.XmlText, idx)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "LocationSignedBy", "")>
			   </cfif>
			   <cfif StructKeyExists(CALLER.aTrackActivityQuery[idx], "Date")>	
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "ActivityDate", CALLER.aTrackActivityQuery[idx].Date.XmlText, idx)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "ActivityDate", "")>
			   </cfif>
			   <!--- Documentation incorrectly states value of zero to one for this element but it may be an array --->
			   <cfif #IsArray(CALLER.aTrackActivityQuery[idx].Status.StatusType.Description.XmlChildren)#>
			   	 <cfset StatusTypeDescList = "">
				<cfloop index="j" from="1" to="#ArrayLen(CALLER.aTrackActivityQuery[idx].Status.StatusType.Description)#">
				 <cfset StatusTypeDescList = CALLER.aTrackActivityQuery[idx].Status.StatusType.Description[j].XmlText&",">
				</cfloop>
				 <cfif Right(StatusTypeDescList, 1) eq ",">
				 	<cfset vLen = Len(StatusTypeDescList)>
					<cfset StatusTypeDescList = Left(StatusTypeDescList, (vLen - 1))>
				 </cfif>
				 <cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "StatusTypeDesc", "#StatusTypeDescList#")>			 
			   <cfelseif StructKeyExists(CALLER.aTrackActivityQuery[idx].Status.StatusType, "Description")>	
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "StatusTypeDesc", CALLER.aTrackActivityQuery[idx].Status.StatusType.Description.XmlText, idx)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "StatusTypeDesc", "")>
			   </cfif>
			   <cfif StructKeyExists(CALLER.aTrackActivityQuery[idx].Status.StatusType, "Code")>	
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "StatusTypeCode", CALLER.aTrackActivityQuery[idx].Status.StatusType.Code.XmlText, idx)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "StatusTypeCode", "")>
			   </cfif>
			   <cfif StructKeyExists(CALLER.aTrackActivityQuery[idx], "Time")>	
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "ActivityTime", CALLER.aTrackActivityQuery[idx].Time.XmlText, idx)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "ActivityTime", "")>
			   </cfif>
		</cfloop>
			
	 <cfelseif IsDefined("CALLER.stUpsTrack.TrackResponse.Shipment.Package.Activity")>
			<!--- Structure returned only no array --->
			<cfset CALLER.UPSTrackError = 0>
			<cfset CALLER.TrackActivityQuery = QueryNew("AddressCity, AddressCountry, AddressZip, AddressState, LocationDesc, LocationSignedBy, ActivityDate, StatusTypeDesc, StatusTypeCode, ActivityTime")>
	  		<cfset CALLER.aTrackActivityQuery = CALLER.stUpsTrack.TrackResponse.Shipment.Package.Activity>
		   		<cfset newRow  = QueryAddRow(CALLER.TrackActivityQuery, 1)>
 			   <cfif StructKeyExists(CALLER.aTrackActivityQuery.ActivityLocation.Address, "City")>	
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "AddressCity", CALLER.aTrackActivityQuery.ActivityLocation.Address.City.XmlText, 1)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "AddressCity", "")>
			   </cfif>
			   <cfif StructKeyExists(CALLER.aTrackActivityQuery.ActivityLocation.Address, "CountryCode")>	
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "AddressCountry", CALLER.aTrackActivityQuery.ActivityLocation.Address.CountryCode.XmlText, 1)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "AddressCountry", "")>
			   </cfif>
			   <cfif StructKeyExists(CALLER.aTrackActivityQuery.ActivityLocation.Address, "PostalCode")>	
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "AddressZip", CALLER.aTrackActivityQuery.ActivityLocation.Address.PostalCode.XmlText, 1)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "AddressZip", "")>
			   </cfif>
			   <cfif StructKeyExists(CALLER.aTrackActivityQuery.ActivityLocation.Address, "StateProvinceCode")>	
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "AddressState", CALLER.aTrackActivityQuery.ActivityLocation.Address.StateProvinceCode.XmlText, 1)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "AddressState", "")>
			   </cfif>
			   <cfif StructKeyExists(CALLER.aTrackActivityQuery.ActivityLocation, "Description")>	
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "LocationDesc", CALLER.aTrackActivityQuery.ActivityLocation.Description.XmlText, 1)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "LocationDesc", "")>
			   </cfif>
			   <cfif StructKeyExists(CALLER.aTrackActivityQuery.ActivityLocation, "SignedForByName")>	
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "LocationSignedBy", CALLER.aTrackActivityQuery.ActivityLocation.SignedForByName.XmlText, 1)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "LocationSignedBy", "")>
			   </cfif>
			   <cfif StructKeyExists(CALLER.aTrackActivityQuery, "Date")>	
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "ActivityDate", CALLER.aTrackActivityQuery.Date.XmlText, 1)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "ActivityDate", "")>
			   </cfif>
			   <!--- Documentation incorrectly states value of zero to one for this element but it may be an array --->
			   <cfif #IsArray(CALLER.aTrackActivityQuery.Status.StatusType.Description.XmlChildren)#>
			   	 <cfset StatusTypeDescList = "">
				<cfloop index="j" from="1" to="#ArrayLen(CALLER.aTrackActivityQuery.Status.StatusType.Description)#">
				 <cfset StatusTypeDescList = CALLER.aTrackActivityQuery.Status.StatusType.Description[j].XmlText&",">
				</cfloop>
				 <cfif Right(StatusTypeDescList, 1) eq ",">
				 	<cfset vLen = Len(StatusTypeDescList)>
					<cfset StatusTypeDescList = Left(StatusTypeDescList, (vLen - 1))>
				 </cfif>
				 <cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "StatusTypeDesc", "#StatusTypeDescList#")>			 			   
			   <cfelseif StructKeyExists(CALLER.aTrackActivityQuery.Status.StatusType, "Description")>	
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "StatusTypeDesc", CALLER.aTrackActivityQuery.Status.StatusType.Description.XmlText, 1)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "StatusTypeDesc", "")>
			   </cfif>
			   <cfif StructKeyExists(CALLER.aTrackActivityQuery.Status.StatusType, "Code")>	
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "StatusTypeCode", CALLER.aTrackActivityQuery.Status.StatusType.Code.XmlText, 1)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "StatusTypeCode", "")>
			   </cfif>
			   <cfif StructKeyExists(CALLER.aTrackActivityQuery, "Time")>	
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "ActivityTime", CALLER.aTrackActivityQuery.Time.XmlText, 1)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "ActivityTime", "")>
			   </cfif>
	  <cfelse>
	  	<!--- Unhandled response received --->
	  </cfif>
	 </cfif> <!--- End Package array check --->
		
	<cfelseif IsDefined("CALLER.stUpsTrack.TrackResponse.Response.ResponseStatusCode.XmlText") AND
		CALLER.stUpsTrack.TrackResponse.Response.ResponseStatusCode.XmlText eq 0>
		<cfset CALLER.UPSTrackError = 1> <!--- Response fine, transaction failed however --->
		<cfif IsDefined("CALLER.stUpsTrack.TrackResponse.Response.Error.ErrorCode.XmlText")>
			<cfset CALLER.UPSErrorCode = CALLER.stUpsTrack.TrackResponse.Response.Error.ErrorCode.XmlText>
		</cfif>
		<cfif IsDefined("CALLER.stUpsTrack.TrackResponse.Response.Error.ErrorDescription.XmlText")>
			<cfset CALLER.UPSErrorDescription = CALLER.stUpsTrack.TrackResponse.Response.Error.ErrorDescription.XmlText>
		</cfif>
	<cfelse>
		<cfset CALLER.UPSTrackError = 2>
	</cfif>
	
 </cfcase>
 <!--- END UPS Track Request --->

 <!--- UPS Track No Activity Request --->
 <cfcase value="trackNoActivityRequest">
 	
	<cfscript>	
	ATTRIBUTES.TrackNoAccess = '<?xml version="#ATTRIBUTES.XMLVersion#"?>
	<AccessRequest xml:lang="en-US">
	<AccessLicenseNumber>#ATTRIBUTES.UPSAccessKey#</AccessLicenseNumber>
		<UserId>#ATTRIBUTES.UPSUserID#</UserId>
		<Password>#ATTRIBUTES.UPSPassword#</Password>
	</AccessRequest>';
	
	ATTRIBUTES.TrackNoRequest='<?xml version="#ATTRIBUTES.XMLVersion#"?>
	<TrackRequest xml:lang="en-US">
		<Request>
			<TransactionReference>
				<CustomerContext>Tracking Activity Request</CustomerContext>
				<XpciVersion>#ATTRIBUTES.XPCIVersion#</XpciVersion>
			</TransactionReference>
			<RequestAction>Track</RequestAction>
			<RequestOption>none</RequestOption>
		</Request>
			<TrackingNumber>#ATTRIBUTES.TrackingNumber#</TrackingNumber>
	</TrackRequest>';
	
	ATTRIBUTES.XMLRequestInput = '#ATTRIBUTES.TrackNoAccess#
	#ATTRIBUTES.TrackNoRequest#';
	
	</cfscript>
	
	<cfhttp method="post" url="#ATTRIBUTES.trackServer#" resolveurl="yes" port="443" timeout="#ATTRIBUTES.TimeOut#">
		<cfhttpparam name="XML" type="xml" value="#ATTRIBUTES.XMLRequestInput#">
	</cfhttp>
	
	<cfset CALLER.stUpsTrack = XmlParse(Trim(cfhttp.FileContent))>
	
	
	<cfif IsDefined("ATTRIBUTES.Debug") AND ATTRIBUTES.Debug eq "TRUE">	
		<cffile action="WRITE" file="#ATTRIBUTES.ServerFilePath##trailingSlash#Debug#trailingSlash#TrackNoAccess.xml" output="#ATTRIBUTES.TrackNoAccess#" addnewline="No" nameconflict="overwrite">
		<cffile action="WRITE" file="#ATTRIBUTES.ServerFilePath##trailingSlash#Debug#trailingSlash#TrackNoRequest.xml" output="#ATTRIBUTES.TrackNoRequest#" addnewline="No" nameconflict="overwrite">
		<cfoutput><cfdump var="#CALLER.stUpsTrack#">
		<a href="Debug#trailingSlash#TrackNoAccess.xml" target="_blank">View XML Access File</a>
		<a href="Debug#trailingSlash#TrackNoRequest.xml" target="_blank">View XML Request File</a>
		</cfoutput>
		<cfabort>
	</cfif>
	
		<!--- <cfoutput><cfdump var="#CALLER.stUpsTrack#"></cfoutput> --->
 	<cfif IsDefined("CALLER.stUpsTrack.TrackResponse.Response.ResponseStatusCode.XmlText") AND #CALLER.stUpsTrack.TrackResponse.Response.ResponseStatusCode.XmlText# eq 1> 
		<cfset CALLER.UPSTrackError = 0>	
	
		<!--- package element structure only --->
		 <cfif IsDefined("CALLER.stUpsTrack.TrackResponse.Shipment.Package")>
				<cfset CALLER.TrackActivityQueryMultiple = 0> <!--- There will be only 1 activity query returned --->
	
			<cfif IsDefined("CALLER.stUpsTrack.TrackResponse.Shipment.Package.PackageWeight.Weight.XmlText")>
				<cfset CALLER.UPSPackageWeight = CALLER.stUpsTrack.TrackResponse.Shipment.Package.PackageWeight.Weight.XmlText>
			</cfif>
			<cfif IsDefined("CALLER.stUpsTrack.TrackResponse.Shipment.Package.PackageWeight.UnitOfMeasurement.Code.XmlText")>
				<cfset CALLER.UPSPackageWeightUnit = CALLER.stUpsTrack.TrackResponse.Shipment.Package.PackageWeight.UnitOfMeasurement.Code.XmlText>
			</cfif>
			<cfif IsDefined("CALLER.stUpsTrack.TrackResponse.Shipment.Package.TRACKINGNUMBER.XmlText")>
				<cfset CALLER.UPSTrackingNumber = CALLER.stUpsTrack.TrackResponse.Shipment.Package.TRACKINGNUMBER.XmlText>
			</cfif>
			<cfif IsDefined("CALLER.stUpsTrack.TrackResponse.Shipment.Service.Code.XmlText")>
				<cfset CALLER.UPSServiceCode = CALLER.stUpsTrack.TrackResponse.Shipment.Service.Code.XmlText>
			</cfif>
			<cfif IsDefined("CALLER.stUpsTrack.TrackResponse.Shipment.Service.Description.XmlText")>
				<cfset CALLER.UPSServiceDesc = CALLER.stUpsTrack.TrackResponse.Shipment.Service.Description.XmlText>
			</cfif>
			<cfif IsDefined("CALLER.stUpsTrack.TrackResponse.Shipment.Shipper.Address.AddressLine1.XmlText")>
				<cfset CALLER.UPSShipperAddress1 = CALLER.stUpsTrack.TrackResponse.Shipment.Shipper.Address.AddressLine1.XmlText>
			</cfif>
			<cfif IsDefined("CALLER.stUpsTrack.TrackResponse.Shipment.Shipper.Address.AddressLine2.XmlText")>
				<cfset CALLER.UPSShipperAddress2 = CALLER.stUpsTrack.TrackResponse.Shipment.Shipper.Address.AddressLine2.XmlText>
			</cfif>
			<cfif IsDefined("CALLER.stUpsTrack.TrackResponse.Shipment.Shipper.Address.AddressLine3.XmlText")>
				<cfset CALLER.UPSShipperAddress3 = CALLER.stUpsTrack.TrackResponse.Shipment.Shipper.Address.AddressLine3.XmlText>
			</cfif>
			<cfif IsDefined("CALLER.stUpsTrack.TrackResponse.Shipment.Shipper.Address.City.XmlText")>
				<cfset CALLER.UPSShipperCity = CALLER.stUpsTrack.TrackResponse.Shipment.Shipper.Address.City.XmlText>
			</cfif>
			<cfif IsDefined("CALLER.stUpsTrack.TrackResponse.Shipment.Shipper.Address.StateProvinceCode.XmlText")>
				<cfset CALLER.UPSShipperState = CALLER.stUpsTrack.TrackResponse.Shipment.Shipper.Address.StateProvinceCode.XmlText>
			</cfif>
			<cfif IsDefined("CALLER.stUpsTrack.TrackResponse.Shipment.Shipper.Address.PostalCode.XmlText")>
				<cfset CALLER.UPSShipperZip = CALLER.stUpsTrack.TrackResponse.Shipment.Shipper.Address.PostalCode.XmlText>
			</cfif>
			<cfif IsDefined("CALLER.stUpsTrack.TrackResponse.Shipment.Shipper.Address.CountryCode.XmlText")>
				<cfset CALLER.UPSShipperCountry = CALLER.stUpsTrack.TrackResponse.Shipment.Shipper.Address.CountryCode.XmlText>
			</cfif>
			<cfif IsDefined("CALLER.stUpsTrack.TrackResponse.Shipment.Shipper.SHIPPERNUMBER.XmlText")>
				<cfset CALLER.UPSShipperNumber = CALLER.stUpsTrack.TrackResponse.Shipment.Shipper.SHIPPERNUMBER.XmlText>
			</cfif>
			<cfif IsDefined("CALLER.stUpsTrack.TrackResponse.Shipment.ScheduledDeliveryDate.XmlText")>
				<cfset CALLER.UPSEstimatedDelivDate = CALLER.stUpsTrack.TrackResponse.Shipment.ScheduledDeliveryDate.XmlText>
			</cfif>
			<cfif IsDefined("CALLER.stUpsTrack.TrackResponse.Shipment.ScheduledDeliveryTime.XmlText")>
				<cfset CALLER.UPSEstimatedDelivTime = CALLER.stUpsTrack.TrackResponse.Shipment.ScheduledDeliveryTime.XmlText>
			</cfif>
			<cfif IsDefined("CALLER.stUpsTrack.TrackResponse.Shipment.PICKUPDATE.XmlText")>
				<cfset CALLER.UPSPickupDate = CALLER.stUpsTrack.TrackResponse.Shipment.PICKUPDATE.XmlText>
			</cfif>
		</cfif>
		
		<cfif IsDefined("CALLER.stUpsTrack.TrackResponse.Shipment.Package.Activity")>
			<!--- Structure returned only no array --->
			<cfset CALLER.UPSTrackError = 0>
			<cfset CALLER.TrackActivityQuery = QueryNew("AddressCity, AddressCountry, AddressZip, AddressState, LocationDesc, LocationSignedBy, ActivityDate, StatusTypeDesc, StatusTypeCode, ActivityTime")>
	  		<cfset CALLER.aTrackActivityQuery = CALLER.stUpsTrack.TrackResponse.Shipment.Package.Activity>
		   		<cfset newRow  = QueryAddRow(CALLER.TrackActivityQuery, 1)>
 			   <cfif StructKeyExists(CALLER.aTrackActivityQuery.ActivityLocation.Address, "City")>	
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "AddressCity", CALLER.aTrackActivityQuery.ActivityLocation.Address.City.XmlText, 1)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "AddressCity", "")>
			   </cfif>
			   <cfif StructKeyExists(CALLER.aTrackActivityQuery.ActivityLocation.Address, "CountryCode")>	
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "AddressCountry", CALLER.aTrackActivityQuery.ActivityLocation.Address.CountryCode.XmlText, 1)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "AddressCountry", "")>
			   </cfif>
			   <cfif StructKeyExists(CALLER.aTrackActivityQuery.ActivityLocation.Address, "PostalCode")>	
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "AddressZip", CALLER.aTrackActivityQuery.ActivityLocation.Address.PostalCode.XmlText, 1)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "AddressZip", "")>
			   </cfif>
			   <cfif StructKeyExists(CALLER.aTrackActivityQuery.ActivityLocation.Address, "StateProvinceCode")>	
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "AddressState", CALLER.aTrackActivityQuery.ActivityLocation.Address.StateProvinceCode.XmlText, 1)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "AddressState", "")>
			   </cfif>
			   <cfif StructKeyExists(CALLER.aTrackActivityQuery.ActivityLocation, "Description")>	
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "LocationDesc", CALLER.aTrackActivityQuery.ActivityLocation.Description.XmlText, 1)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "LocationDesc", "")>
			   </cfif>
			   <cfif StructKeyExists(CALLER.aTrackActivityQuery.ActivityLocation, "SignedForByName")>	
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "LocationSignedBy", CALLER.aTrackActivityQuery.ActivityLocation.SignedForByName.XmlText, 1)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "LocationSignedBy", "")>
			   </cfif>
			   <cfif StructKeyExists(CALLER.aTrackActivityQuery, "Date")>	
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "ActivityDate", CALLER.aTrackActivityQuery.Date.XmlText, 1)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "ActivityDate", "")>
			   </cfif>
			   <!--- Documentation incorrectly states value of zero to one for this element but it may be an array --->
			   <cfif #IsArray(CALLER.aTrackActivityQuery.Status.StatusType.Description.XmlChildren)#>
			   	 <cfset StatusTypeDescList = "">
				<cfloop index="j" from="1" to="#ArrayLen(CALLER.aTrackActivityQuery.Status.StatusType.Description)#">
				 <cfset StatusTypeDescList = CALLER.aTrackActivityQuery.Status.StatusType.Description[j].XmlText&",">
				</cfloop>
				 <cfif Right(StatusTypeDescList, 1) eq ",">
				 	<cfset vLen = Len(StatusTypeDescList)>
					<cfset StatusTypeDescList = Left(StatusTypeDescList, (vLen - 1))>
				 </cfif>
				 <cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "StatusTypeDesc", "#StatusTypeDescList#")>			 			   
			   <cfelseif StructKeyExists(CALLER.aTrackActivityQuery.Status.StatusType, "Description")>	
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "StatusTypeDesc", CALLER.aTrackActivityQuery.Status.StatusType.Description.XmlText, 1)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "StatusTypeDesc", "")>
			   </cfif>
			   <cfif StructKeyExists(CALLER.aTrackActivityQuery.Status.StatusType, "Code")>	
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "StatusTypeCode", CALLER.aTrackActivityQuery.Status.StatusType.Code.XmlText, 1)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "StatusTypeCode", "")>
			   </cfif>
			   <cfif StructKeyExists(CALLER.aTrackActivityQuery, "Time")>	
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "ActivityTime", CALLER.aTrackActivityQuery.Time.XmlText, 1)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.TrackActivityQuery, "ActivityTime", "")>
			   </cfif>
		<cfelse> <!--- Package Activity structure check --->
	  	<!--- Unhandled response received --->
		</cfif> <!--- Package Activity structure check --->
		
	<cfelseif IsDefined("CALLER.stUpsTrack.TrackResponse.Response.ResponseStatusCode.XmlText") AND
		CALLER.stUpsTrack.TrackResponse.Response.ResponseStatusCode.XmlText eq 0>
		<cfset CALLER.UPSTrackError = 1> <!--- Response fine, transaction failed however --->
		<cfif IsDefined("CALLER.stUpsTrack.TrackResponse.Response.Error.ErrorCode.XmlText")>
			<cfset CALLER.UPSErrorCode = CALLER.stUpsTrack.TrackResponse.Response.Error.ErrorCode.XmlText>
		</cfif>
		<cfif IsDefined("CALLER.stUpsTrack.TrackResponse.Response.Error.ErrorDescription.XmlText")>
			<cfset CALLER.UPSErrorDescription = CALLER.stUpsTrack.TrackResponse.Response.Error.ErrorDescription.XmlText>
		</cfif>
	<cfelse>
		<cfset CALLER.UPSTrackError = 2>
	</cfif>
	
 </cfcase>
 <!--- END UPS Track No Activity Request --->
  
</cfswitch>
<!--- End XML Scripts --->