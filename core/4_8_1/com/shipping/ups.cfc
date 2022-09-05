<!--- 
|| LEGAL ||
$CartFusion - Copyright � 2001-2007 Trade Studios, LLC.$
$This copyright notice MUST stay intact for use (see license.txt).$
$It is against the law to copy, distribute, gift, bundle or give away this code$
$without written consent from Trade Studios, LLC.$

|| VERSION CONTROL ||
$Id: 4.7.0.3b $
$Date: 26-Mar-07 $
$Revision: 1.0.0 $

|| DESCRIPTION ||
$Description: CARTFUSION 4.7 - CART CFC $
$TODO: $

|| DEVELOPER ||
$Developer: Trade Studios, LLC (webmaster@tradestudios.com)$

|| SUPPORT ||
$Support Email: support@tradestudios.com$
$Support Website: http://support.tradestudios.com$

|| ATTRIBUTES ||
$in: $
$out:$
--->

<!--- *CARTFUSION 4.7 - UPS Online Tools CFC* --->
<cfcomponent displayname="UPS Online Tools Module">

	<cfscript>
		variables.dsn = "" ;
		// variables.fedexAcNum   = "" ;
		// variables.identifier   = "" ;
		variables.UPSAccessKey = "" ;
		variables.UPSUserID	= "" ;
		variables.UPSPassword  = "" ;
		// variables.USPSUserID   = "" ;
		// variables.USPSPassword = "" ;
		variables.ShippingPrice = 0 ;
		variables.TotalShippingPrice = 0 ;
		variables.IntShip = 0 ;
		variables.getShippingCos = StructNew() ;
	</cfscript>

	<cffunction name="init" returntype="UPS" output="no">
		<cfargument name="dsn" required="yes">
		<cfargument name="SiteID" required="yes">
		
		<!--- Initialize variables --->
		<cfscript>
			variables.dsn = arguments.dsn ;
			variables.SiteID = arguments.SiteID ;
			// QUERY - GET SHIPPING ACCOUNT SETTINGS
			variables.getShippingCos = application.Queries.getShippingCos(SiteID=variables.SiteID) ;
			// variables.fedexAcNum   = getShippingCos.FedexAccountNum ;
			// variables.identifier   = getShippingCos.FedexIdentifier ;
			variables.UPSAccessKey = getShippingCos.UPSAccessKey ;
			variables.UPSUserID	= getShippingCos.UPSUserID ;
			variables.UPSPassword  = getShippingCos.UPSPassword ;
			// variables.USPSUserID   = getShippingCos.USPSUserID ;
			// variables.USPSPassword = getShippingCos.USPSPassword ;
		</cfscript><!--- CARTFUSION 4.6 - SHIPPING CODES --->
		<cfquery name="getShippingCodes" datasource="#variables.dsn#" >
			SELECT	*
			FROM	ShippingCodes
		</cfquery>
		
		<cfreturn this />
	</cffunction>


	<!--- UPS XML Scripts CFMX VERSION - Andrew --->
	<!--- PREMIUM VARIABLES NEEDED/OPTIONAL --->
	<cffunction name="getUPS" output="no">
		<cfargument name="RequestType" required="no" default="rateRequest">
		<cfargument name="TestingEnvironment" required="no" default="FALSE">
		<cfargument name="ShipperAccountNumber" required="no" default=""><!--- ** PREMIUM ** required for Shipping request --->
		<cfargument name="LabelPrintMethod" required="no" default="GIF"><!--- GIF or EPL --->
		<cfargument name="LabelSizeHeight" required="no" default="4"><!--- valid value is 4 --->
		<cfargument name="LabelSizeWidth" required="no" default="6"><!--- valid values are 6 or 8 --->
		<cfargument name="ShipmentDescription" required="no" default="Description of item contents"><!--- required for international shipping label --->
		<cfargument name="PackageReferenceCode" required="no" default=""><!--- IK: Invoice Number --->
		<cfargument name="PackageReferenceValue" required="no" default="">
		<cfargument name="PackageReferenceCode2" required="no" default=""><!--- IK: Invoice Number --->
		<cfargument name="PackageReferenceValue2" required="no" default="">
		<cfargument name="PackageReferenceCode3" required="no" default=""><!--- IK: Invoice Number --->
		<cfargument name="PackageReferenceValue3" required="no" default="">
		<cfargument name="InvoiceCurrencyCode" required="no" default="USD"><!--- Packages to PR OR CA Only --->
		<cfargument name="InvoiceAmount" required="no" default="0"><!--- Packages to PR OR CA Only --->
		<cfargument name="SignatureTrackingOption" required="no" default="15">
		<cfargument name="PaymentType" required="no" default="BillShipperAccount">
		<cfargument name="PaymentCreditCardType" required="no" default="">
		<cfargument name="PaymentCreditCardNumber" required="no" default="">
		<cfargument name="PaymentCreditCardExpiration" required="no" default="">
		<cfargument name="PaymentBillThirdPartyAccount" required="no" default="">
		<cfargument name="PaymentBillThirdPartyAddr" required="no" default="">
		<cfargument name="PaymentBillThirdPartyZip" required="no" default="">
		<cfargument name="PaymentBillThirdPartyCountry" required="no" default="US">
		<cfargument name="PaymentFreightCollectAccount" required="no" default="">
		<cfargument name="PaymentFreightCollectAddr" required="no" default="">
		<cfargument name="PaymentFreightCollectZip" required="no" default="">
		<cfargument name="NotificationCode" required="no" default="6">
		<cfargument name="NotificationEmailAddress" required="no" default="">
		<cfargument name="NotificationUndelivAddress" required="no" default="">
		<cfargument name="NotificationFromName" required="no" default="">
		<cfargument name="NotificationMemo" required="no" default="">
		<cfargument name="NotificationSubjectCode" required="no" default=""><!--- END PREMIUM VARIABLES NEEDED/OPTIONAL --->
		<cfargument name="UPSAccessKey" required="no" default="#variables.UPSAccessKey#">
		<cfargument name="UPSUserID" required="no" default="#variables.UPSUserID#">
		<cfargument name="UPSPassword" required="no" default="#variables.UPSPassword#">
		<cfargument name="XMLVersion" required="no" default="1.0">
		<cfargument name="XPCIVersion" required="no" default="1.0002">
		<cfargument name="XPCIVersionAV" required="no" default="1.0001">
		<cfargument name="XPCIVersionPremium" required="no" default="1.0001">
		<cfargument name="PickUpType" required="no" default="01"><!--- required Daily Pickup --->
		<cfargument name="ShipperCompanyName" required="no" default="">
		<cfargument name="ShipperAttentionName" required="no" default="">
		<cfargument name="ShipperAddress1" required="no" default="">
		<cfargument name="ShipperAddress2" required="no" default="">
		<cfargument name="ShipperAddress3" required="no" default="">
		<cfargument name="ShipperCity" required="no" default=""><!--- optional --->
		<cfargument name="ShipperState" required="no" default=""><!--- optional --->
		<cfargument name="ShipperZip" required="no" default=""><!--- required --->
		<cfargument name="ShipperCountry" required="no" default="US"><!--- required 2 digit country code --->
		<cfargument name="ShipperPhoneCountryCode" required="no" default="1"><!--- (USA = 1) The prefix to the phone number indicating which country the phone is located. --->
		<cfargument name="ShipperPhoneAreaCode" required="no" default=""><!--- Ship Request optional ---><!--- Depends upon the location of the phone,  in North America the Dial plan uses area code, other parts of the world use a phone number prefix according to the city. --->
		<cfargument name="ShipperPhoneNumber" required="no" default=""><!--- Ship Request optional ---><!--- For the US it is the seven digits, in all other locations the numbers would include the remaining numbers excluding the Area Code. --->
		<cfargument name="ShipperPhoneExtension" required="no" default=""><!--- Ship Request optional --->
		<cfargument name="ShipToCompanyName" required="no" default="">
		<cfargument name="ShipToAttentionName" required="no" default="">
		<cfargument name="ShipToAddress1" required="no" default="">
		<cfargument name="ShipToAddress2" required="no" default="">
		<cfargument name="ShipToAddress3" required="no" default="">
		<cfargument name="ShipToCity" required="no" default=""><!--- Required if country does not have postcode --->
		<cfargument name="ShipToState" required="no" default=""><!--- optional --->
		<cfargument name="ShipToZip" required="no" default=""><!--- required --->
		<cfargument name="ShipToCountry" required="no" default="US"><!--- required 2 digit country code --->
		<cfargument name="ShipToPhoneAreaCode" required="no" default="">
		<cfargument name="ShipToPhoneNumber" required="no" default="">
		<cfargument name="ShipToPhoneExtension" required="no" default="">
		<cfargument name="ResidentialAddress" required="no" default="0"><!--- Residential delivery address 1 - YES, 0 - No --->
		<cfargument name="ShipFromCompanyName" required="no" default="">
		<cfargument name="ShipFromAttentionName" required="no" default="">
		<cfargument name="ShipFromAddress1" required="no" default="">
		<cfargument name="ShipFromAddress2" required="no" default="">
		<cfargument name="ShipFromAddress3" required="no" default="">
		<cfargument name="ShipFromCity" required="no" default="">
		<cfargument name="ShipFromState" required="no" default="">
		<cfargument name="ShipFromZip" required="no" default="">
		<cfargument name="ShipFromCountry" required="no" default="US">
		<cfargument name="ShipFromPhoneAreaCode" required="no" default="">
		<cfargument name="ShipFromPhoneNumber" required="no" default="">
		<cfargument name="ShipFromPhoneExtension" required="no" default="">
		<cfargument name="ServiceType" required="no" default="03"><!--- Default: Ground --->
		<cfargument name="PackageCode" required="no" default="02"><!--- Required --->
		<cfargument name="PackageDesc" required="no" default="Package">
		<cfargument name="PackageUnitOfMeasurement" required="no" default="IN"><!--- Inches --->
		<cfargument name="PackageLength" required="no" default="10.0"><!--- valid values 1 - 108.00 only --->
		<cfargument name="PackageWidth" required="no" default="10.0"><!--- valid values 1 - 108.00 only --->
		<cfargument name="PackageHeight" required="no" default="10.0"><!--- valid values 1 - 108.00 only --->
		<cfargument name="PackageWeightUnit" required="no" default="LBS"><!--- LBS | KGS --->
		<cfargument name="PackageWeight" required="no" default="1"><!--- 0.0  if PackagingType = Letter, Otherwise 0.1 - 150.0 --->
		<cfargument name="PackageOversize" required="no" default="">
		<cfargument name="CurrencyCode" required="no" default="USD">
		<cfargument name="InsuredValue" required="no" default="99.0"><!--- Value between 0.0  and 999.00 valid for Domestic shipments Only --->
		<cfargument name="CODCode" required="no" default="">
		<cfargument name="CODCurrencyCode" required="no" default="USD">
		<cfargument name="CODAmount" required="no" default="0">
		<cfargument name="CODFundsAcceptedCode" required="no" default="0">
		<cfargument name="SaturdayPickup" required="no" default="0">
		<cfargument name="SaturdayDelivery" required="no" default="0">
		<cfargument name="TrackingNumber" required="no" default="">
		<cfargument name="TrackingReference" required="no" default="">
		<cfargument name="CertificationRequest" required="no" default="FALSE">
		<cfargument name="SuppressWhiteSpace" required="no" default="TRUE">
		<cfargument name="Debug" required="no" default="FALSE">
		<cfargument name="TimeOut" required="no" default="90">
		<cfargument name="negotiatedRates" required="no" default="0"> <!--- [0 = Do not requeste negotiated rates | 1 = request negotiated rates if available] --->
		
		<cfscript>
			currPath = ExpandPath("*.*");
			tempCurrDir = GetDirectoryFromPath(currPath);
			if ( find('\', tempCurrDir, 1) GTE 1 ) { 
				trailingSlash = '\'; 
				dirPathLen = Len(tempCurrDir) - 1;
				currentWorkingDir = Left(tempCurrDir, dirPathLen);
			} else { 
				trailingSlash = '/';
				dirPathLen = Len(tempCurrDir) - 1;
				currentWorkingDir = Left(tempCurrDir, dirPathLen);
			}
			ServerFilePath = currentWorkingDir ;
			if ( arguments.TestingEnvironment EQ "TRUE" ) { 
				arguments.tntServer = "https://wwwcie.ups.com/ups.app/xml/TimeInTransit" ; 
				arguments.rateServer = "https://wwwcie.ups.com/ups.app/xml/Rate" ;
				arguments.trackServer = "https://wwwcie.ups.com/ups.app/xml/Track" ;
				arguments.AVServer = "https://wwwcie.ups.com/ups.app/xml/AV" ;
			} else { 
				arguments.tntServer = "https://www.ups.com/ups.app/xml/TimeInTransit" ; 
				arguments.rateServer = "https://www.ups.com/ups.app/xml/Rate" ;
				arguments.trackServer = "https://www.ups.com/ups.app/xml/Track" ;
				arguments.AVServer = "https://www.ups.com/ups.app/xml/AV" ;
			}
		/*
		</cfscript>
		<cfparam name="ServerFilePath" default="#currentWorkingDir#"> --->
		<cfscript>
			 ;
			 ;
			 ;
			 ;
			 ;
		*/
			// Ignored when requesting rate shop
			data.ServiceLevelQuery = QueryNew("ServiceLevelCode, ServiceLevelDesc") ;
			QueryAddRow(data.ServiceLevelQuery, 1) ;
			QuerySetCell(data.ServiceLevelQuery, "ServiceLevelCode", "01") ;
			QuerySetCell(data.ServiceLevelQuery, "ServiceLevelDesc", "Next Day Air") ;
			QueryAddRow(data.ServiceLevelQuery, 1) ;
			QuerySetCell(data.ServiceLevelQuery, "ServiceLevelCode", "02") ;
			QuerySetCell(data.ServiceLevelQuery, "ServiceLevelDesc", "2nd Day Air") ;
			QueryAddRow(data.ServiceLevelQuery, 1) ;
			QuerySetCell(data.ServiceLevelQuery, "ServiceLevelCode", "03") ;
			QuerySetCell(data.ServiceLevelQuery, "ServiceLevelDesc", "Ground") ;
			QueryAddRow(data.ServiceLevelQuery, 1) ;
			QuerySetCell(data.ServiceLevelQuery, "ServiceLevelCode", "07") ;
			QuerySetCell(data.ServiceLevelQuery, "ServiceLevelDesc", "Worldwide Express") ;
			QueryAddRow(data.ServiceLevelQuery, 1) ;
			QuerySetCell(data.ServiceLevelQuery, "ServiceLevelCode", "08") ;
			QuerySetCell(data.ServiceLevelQuery, "ServiceLevelDesc", "Worldwide Expedited") ;
			QueryAddRow(data.ServiceLevelQuery, 1) ;
			QuerySetCell(data.ServiceLevelQuery, "ServiceLevelCode", "11") ;
			QuerySetCell(data.ServiceLevelQuery, "ServiceLevelDesc", "Ground Service to Canada") ;
			QueryAddRow(data.ServiceLevelQuery, 1) ;
			QuerySetCell(data.ServiceLevelQuery, "ServiceLevelCode", "12") ;
			QuerySetCell(data.ServiceLevelQuery, "ServiceLevelDesc", "3-Day Select") ;
			QueryAddRow(data.ServiceLevelQuery, 1) ;
			QuerySetCell(data.ServiceLevelQuery, "ServiceLevelCode", "13") ;
			QuerySetCell(data.ServiceLevelQuery, "ServiceLevelDesc", "Next Day Air Saver") ;
			QueryAddRow(data.ServiceLevelQuery, 1) ;
			QuerySetCell(data.ServiceLevelQuery, "ServiceLevelCode", "14") ;
			QuerySetCell(data.ServiceLevelQuery, "ServiceLevelDesc", "Next Day Air Early AM") ;
			QueryAddRow(data.ServiceLevelQuery, 1) ;
			QuerySetCell(data.ServiceLevelQuery, "ServiceLevelCode", "54") ;
			QuerySetCell(data.ServiceLevelQuery, "ServiceLevelDesc", "Worldwide Express Plus") ;
			QueryAddRow(data.ServiceLevelQuery, 1) ;
			QuerySetCell(data.ServiceLevelQuery, "ServiceLevelCode", "59") ;
			QuerySetCell(data.ServiceLevelQuery, "ServiceLevelDesc", "2nd Day Air AM") ;
			QueryAddRow(data.ServiceLevelQuery, 1) ;
			QuerySetCell(data.ServiceLevelQuery, "ServiceLevelCode", "65") ;
			QuerySetCell(data.ServiceLevelQuery, "ServiceLevelDesc", "Express Saver") ;
		</cfscript>
		
		<!--- WHICH REQUEST TYPE TO USE (RATES, TRACKING, TIME IN TRANSIT, ETC.) --->
		<cfswitch expression="#arguments.RequestType#">
		  <!--- UPS Rates Availability Check --->
		  <cfcase value="rateAvailabilityRequest">
			  <cfhttp method="get" url="#arguments.rateServer#" resolveurl="yes" port="443" timeout="#arguments.TimeOut#" />
				<cfscript>
					data.RateAvail = 0 ;
					if ( StructKeyExists(cfhttp,"fileContent") ) {
						data.RateAvailResponse = cfhttp.fileContent ;
						data.ServiceName = FindNoCase("Service Name: Rate", data.RateAvailResponse, 1) ;
						if ( data.ServiceName GT 0 ) {
							data.RateAvailCheck1 = 1 ;
						} else {
							data.RateAvailCheck1 = 0 ;
						}
						data.RemoteUser = FindNoCase("Remote User: null", data.RateAvailResponse, 1) ;
						if ( data.RemoteUser GT 0 ) {
							data.RateAvailCheck2 = 1 ;
						} else {
							data.RateAvailCheck2 = 0 ;
						}
						data.ServerPort = FindNoCase("Server Port: 443", data.RateAvailResponse, 1) ;
						if ( data.ServerPort GT 0 ) {
							data.RateAvailCheck3 = 1 ;
						} else {
							data.RateAvailCheck3 = 0 ;
						}
						if ( arguments.TestingEnvironment EQ "True" ) {
							data.ServerName = FindNoCase("Server Name: wwwcie.ups.com", data.RateAvailResponse, 1) ;
						} else {
							data.ServerName = FindNoCase("Server Name: www.ups.com", data.RateAvailResponse, 1) ;
						}
						if ( data.ServerName GT 0 ) {
							data.RateAvailCheck4 = 1 ;
						} else {
							data.RateAvailCheck4 = 0 ;
						}
						data.ServletPath = FindNoCase("Servlet Path: /Rate", data.RateAvailResponse, 1) ;
						if ( data.ServerName GT 0 ) {
							data.RateAvailCheck5 = 1 ;
						} else {
							data.RateAvailCheck5 = 0 ;
						}
						if ( data.RateAvailCheck1 EQ 1 
						 AND data.RateAvailCheck2 EQ 1
						 AND data.RateAvailCheck3 EQ 1 
						 AND data.RateAvailCheck4 EQ 1 
						 AND data.RateAvailCheck5 EQ 1 ) {
							data.RateAvail = 1 ;
						} else {
							data.RateAvail = 0 ;
						}
					}
				</cfscript>
		  </cfcase>
		  <!--- End UPS Rates Availability Check --->
		  
		  <!--- UPS Track Availability Check --->
		  <cfcase value="trackAvailabilityRequest">
			  <cfhttp method="get" url="#arguments.trackServer#" resolveurl="yes" port="443" timeout="#arguments.TimeOut#" />
				<cfscript>
					data.TrackAvail = 0 ;
					if ( StructKeyExists(cfhttp,"fileContent") ) {
						data.TrackAvailResponse = cfhttp.fileContent ;
						data.ServiceName = FindNoCase("Service Name: Track", data.TrackAvailResponse, 1) ;
						if ( data.ServiceName GT 0 ) {
							data.TrackAvailCheck1 = 1 ;
						} else {
							data.TrackAvailCheck1 = 0 ;
						}
						data.RemoteUser = FindNoCase("Remote User: null", data.TrackAvailResponse, 1) ;
						if ( data.RemoteUser GT 0 ) {
							data.TrackAvailCheck2 = 1 ;
						} else {
							data.TrackAvailCheck2 = 0 ;
						}
						data.ServerPort = FindNoCase("Server Port: 443", data.TrackAvailResponse, 1) ;
						if ( data.ServerPort GT 0 ) {
							data.TrackAvailCheck3 = 1 ;
						} else {
							data.TrackAvailCheck3 = 0 ;
						}
						if ( arguments.TestingEnvironment EQ "True" ) {
							data.ServerName = FindNoCase("Server Name: wwwcie.ups.com", data.TrackAvailResponse, 1) ;
						} else {
							data.ServerName = FindNoCase("Server Name: www.ups.com", data.TrackAvailResponse, 1) ;
						}
						if ( data.ServerName GT 0 ) {
							data.TrackAvailCheck4 = 1 ;
						} else {
							data.TrackAvailCheck4 = 0 ;
						}
						data.ServletPath = FindNoCase("Servlet Path: /Track", data.TrackAvailResponse, 1) ;
						if ( data.ServerName GT 0 ) {
							data.TrackAvailCheck5 = 1 ;
						} else {
							data.TrackAvailCheck5 = 0 ;
						}
						if ( data.TrackAvailCheck1 EQ 1 
						 AND data.TrackAvailCheck2 EQ 1
						 AND data.TrackAvailCheck3 EQ 1 
						 AND data.TrackAvailCheck4 EQ 1 
						 AND data.TrackAvailCheck5 EQ 1 ) {
							data.TrackAvail = 1 ;
						} else {
							data.TrackAvail = 0 ;
						}
					}
				</cfscript>
		  </cfcase>
		  <!--- End UPS Track Availability Check --->
		  
		  <!--- UPS TNT Availability Check --->
		  <cfcase value="tntAvailabilityRequest">
			  <cfhttp method="get" url="#arguments.tntServer#" resolveurl="yes" port="443" timeout="#arguments.TimeOut#" />
				<cfscript>
					data.tntAvail = 0 ;
					if ( StructKeyExists(cfhttp,"fileContent") ) {
						data.tntAvailResponse = cfhttp.fileContent ;
						data.ServiceName = FindNoCase("Service Name: TimeInTransit", data.tntAvailResponse, 1) ;
						if ( data.ServiceName GT 0 ) {
							data.tntAvailCheck1 = 1 ;
						} else {
							data.tntAvailCheck1 = 0 ;
						}
						data.RemoteUser = FindNoCase("Remote User: null", data.tntAvailResponse, 1) ;
						if ( data.RemoteUser GT 0 ) {
							data.tntAvailCheck2 = 1 ;
						} else {
							data.tntAvailCheck2 = 0 ;
						}
						data.ServerPort = FindNoCase("Server Port: 443", data.tntAvailResponse, 1) ;
						if ( data.ServerPort GT 0 ) {
							data.tntAvailCheck3 = 1 ;
						} else {
							data.tntAvailCheck3 = 0 ;
						}
						if ( arguments.TestingEnvironment EQ "True" ) {
							data.ServerName = FindNoCase("Server Name: wwwcie.ups.com", data.tntAvailResponse, 1) ;
						} else {
							data.ServerName = FindNoCase("Server Name: www.ups.com", data.tntAvailResponse, 1) ;
						}
						if ( data.ServerName GT 0 ) {
							data.tntAvailCheck4 = 1 ;
						} else {
							data.tntAvailCheck4 = 0 ;
						}
						data.ServletPath = FindNoCase("Servlet Path: /TimeInTransit", data.tntAvailResponse, 1) ;
						if ( data.ServerName GT 0 ) {
							data.tntAvailCheck5 = 1 ;
						} else {
							data.tntAvailCheck5 = 0 ;
						}
						if ( data.tntAvailCheck1 EQ 1 
						 AND data.tntAvailCheck2 EQ 1
						 AND data.tntAvailCheck3 EQ 1 
						 AND data.tntAvailCheck4 EQ 1 
						 AND data.tntAvailCheck5 EQ 1 ) {
							data.tntAvail = 1 ;
						} else {
							data.tntAvail = 0 ;
						}
					}
				</cfscript>
		  </cfcase>
		  <!--- End UPS TNT Availability Check --->
		  
		  <!--- UPS Shop Rates and Service --->
		  <cfcase value="rateShopRequest">
		  <cftry>
		  <cfif ( ListLen(arguments.PackageLength) EQ ListLen(arguments.PackageWeight)
			  AND ListLen(arguments.PackageWidth) EQ ListLen(arguments.PackageHeight)
			  AND ListLen(arguments.PackageLength) EQ ListLen(arguments.PackageWidth) ) >
		  <cfelse>
			<cfset data.UPSRateShopError = 2>
			<cfset data.UPSResponseDesc = "Error: You must enter pass an equal number of weight and dimensions package elements for Multi-Piece shipments">
			<cfset data.UPSErrorCode = "">
			<cfabort>
		  </cfif>
		  
		  <cfscript>
			if ( arguments.SaturdayPickup EQ 1 ) {
				SatPickupIndicator = '<SaturdayPickup/>';
			} else {
				SatPickupIndicator = '';
			}
			if ( arguments.SaturdayDelivery EQ 1 ) {
				SatDeliveryIndicator = '<SaturdayDelivery/>';
			} else {
				SatDeliveryIndicator = '';
			}
			if ( arguments.ResidentialAddress EQ 1 ) {
				ResidentialIndicator = '<ResidentialAddressIndicator/>';
			} else {
				ResidentialIndicator = '';
			}
			if ( listLen(arguments.PackageWeight) GT 1 ) {
				PackageIndicator = '' ;
				 for ( idx = 1 ; idx LTE ListLen(arguments.PackageWeight); idx = idx + 1 ) {
					 PackageIndicator = '#PackageIndicator#
				 <Package>
				  <PackagingType>
					<Code>#arguments.PackageCode#</Code>
					<Description>#arguments.PackageDesc#</Description>
				  </PackagingType>
				  <Dimensions>
					<UnitOfMeasurement>
						<Code>#arguments.PackageUnitOfMeasurement#</Code>
					</UnitOfMeasurement>
					<Length>#Trim(NumberFormat(ListGetAt(arguments.PackageLength, idx), "999.9"))#</Length>
					<Width>#Trim(NumberFormat(ListGetAt(arguments.PackageWidth, idx), "999.9"))#</Width>
					<Height>#Trim(NumberFormat(ListGetAt(arguments.PackageHeight, idx), "999.9"))#</Height>
				  </Dimensions>
				  <PackageWeight>
					<UnitOfMeasurement>
						<Code>#arguments.PackageWeightUnit#</Code>
					</UnitOfMeasurement>
					<Weight>#Trim(ListGetAt(arguments.PackageWeight, idx))#</Weight>
				  </PackageWeight>
				  <PackageServiceOptions>
					<InsuredValue>
					  <CurrencyCode>#arguments.CurrencyCode#</CurrencyCode>
					  <MonetaryValue>#Trim(NumberFormat(ListGetAt(arguments.InsuredValue, idx), "999.99"))#</MonetaryValue>
					</InsuredValue>
				  </PackageServiceOptions>
				</Package>';
				}
			} else {
					
				PackageIndicator = '<Package>
				  <PackagingType>
					<Code>#arguments.PackageCode#</Code>
					<Description>#arguments.PackageDesc#</Description>
				  </PackagingType>
				  <Dimensions>
					<UnitOfMeasurement>
						<Code>#arguments.PackageUnitOfMeasurement#</Code>
					</UnitOfMeasurement>
					<Length>#NumberFormat(arguments.PackageLength, "999.9")#</Length>
					<Width>#NumberFormat(arguments.PackageWidth, "999.9")#</Width>
					<Height>#NumberFormat(arguments.PackageHeight, "999.9")#</Height>
				  </Dimensions>
				  <PackageWeight>
					<UnitOfMeasurement>
						<Code>#arguments.PackageWeightUnit#</Code>
					</UnitOfMeasurement>
					<Weight>#arguments.PackageWeight#</Weight>
				  </PackageWeight>
				  <PackageServiceOptions>
					<InsuredValue>
					  <CurrencyCode>#arguments.CurrencyCode#</CurrencyCode>
					  <MonetaryValue>#NumberFormat(arguments.InsuredValue, "999.99")#</MonetaryValue>
					</InsuredValue>
				  </PackageServiceOptions>
				 </Package>';
			}
			
			// CustomerTypeIndicator
			switch (arguments.PickUpType) {
				case "01" :
					CustomerTypeIndicator = "01";
					break;
				case "03" :
					CustomerTypeIndicator = "03";
					break;
				case "11" :
					CustomerTypeIndicator = "04";
					break;
				default :
					CustomerTypeIndicator = "01";
			}
			// Negotiated/Discount Rate Request indiciator
			negotiatedRateIndicator = '' ;
			if ( isDefined("arguments.negotiatedRates") AND arguments.negotiatedRates EQ 1 ) {
				negotiatedRateIndicator = '<RateInformation>
					<NegotiatedRatesIndicator/>
				</RateInformation>';
			}
				
			arguments.RateShopAccess = '<?xml version="#arguments.XMLVersion#"?>
			<AccessRequest xml:lang="en-US">
			<AccessLicenseNumber>#arguments.UPSAccessKey#</AccessLicenseNumber>
				<UserId>#arguments.UPSUserID#</UserId>
				<Password>#arguments.UPSPassword#</Password>
			</AccessRequest>';
		
			arguments.RateShopRequest='<?xml version="#arguments.XMLVersion#"?>
			<RatingServiceSelectionRequest xml:lang="en-US">
			  <Request>
				<TransactionReference>
				  <CustomerContext>Rating and Service</CustomerContext>
				  <XpciVersion>#arguments.XPCIVersion#</XpciVersion>
				</TransactionReference>
				<RequestAction>Rate</RequestAction>
				<RequestOption>shop</RequestOption>
			  </Request>
			  <PickupType>
				<Code>#arguments.PickUpType#</Code>
			  </PickupType>
			  <CustomerClassification>
				<Code>#CustomerTypeIndicator#</Code>
			  </CustomerClassification>
			  <Shipment>
				<Shipper>
				  <ShipperNumber>#arguments.ShipperAccountNumber#</ShipperNumber>
				  <Address>
					<StateProvinceCode>#arguments.ShipperState#</StateProvinceCode>
					<PostalCode>#arguments.ShipperZip#</PostalCode>
					<CountryCode>#arguments.ShipperCountry#</CountryCode>
				  </Address>
				</Shipper>
				<ShipTo>
				  <Address>
					<AddressLine1>#arguments.ShipToAddress1#</AddressLine1>
					<AddressLine2>#arguments.ShipToAddress2#</AddressLine2>
					<AddressLine3>#arguments.ShipToAddress3#</AddressLine3>
					<City>#arguments.ShipToCity#</City>
					<StateProvinceCode>#arguments.ShipToState#</StateProvinceCode>
					<PostalCode>#arguments.ShipToZip#</PostalCode>
					<CountryCode>#arguments.ShipToCountry#</CountryCode>
					#ResidentialIndicator#
				  </Address>
				</ShipTo>
				#PackageIndicator#
				 <ShipmentServiceOptions>
					#SatPickupIndicator#
					#SatDeliveryIndicator#
				 </ShipmentServiceOptions>
				 #negotiatedRateIndicator#
			  </Shipment>
			</RatingServiceSelectionRequest>';
		
			arguments.XMLRequestInput = '#arguments.RateShopAccess#
			#arguments.RateShopRequest#';
		  </cfscript>
			
		  <cfhttp method="post" url="#arguments.rateServer#" resolveurl="yes" port="443" timeout="#arguments.TimeOut#">
			<cfhttpparam name="XML" type="xml" value="#arguments.XMLRequestInput#">
		  </cfhttp>
		  
		  <cfif isDefined("cfhttp.FileContent") AND Len(Trim(cfhttp.FileContent)) GT 10 >
				<cfset data.stUpsRatesShop = XmlParse(Trim(cfhttp.FileContent))>
				<!--- <cfdump var="#data.stUpsRatesShop#"> --->
				<cfif IsDefined("arguments.Debug") AND arguments.Debug EQ "TRUE">
					<cffile action="WRITE" file="#arguments.ServerFilePath##trailingSlash#Debug#trailingSlash#RateShopAccess.xml" output="#arguments.RateShopAccess#" addnewline="No" nameconflict="overwrite">
					<cffile action="WRITE" file="#arguments.ServerFilePath##trailingSlash#Debug#trailingSlash#RateShopRequest.xml" output="#arguments.RateShopRequest#" addnewline="No" nameconflict="overwrite">
					<cfoutput>
					  <cfdump var="#data.stUpsRatesShop#">
					  <a href="Debug#trailingSlash#RateShopAccess.xml" target="_blank">View XML Access File</a>
					  <a href="Debug#trailingSlash#RateShopRequest.xml" target="_blank">View XML Request File</a>
					</cfoutput>
					<cfabort>
				</cfif>
			  
				<!--- NEW CODE START HERE --->
				<cfscript>
					if ( isDefined("data.stUpsRatesShop.RatingServiceSelectionResponse.Response.RESPONSESTATUSCODE.XMLText")
						AND data.stUpsRatesShop.RatingServiceSelectionResponse.Response.RESPONSESTATUSCODE.XMLText EQ 1 ) {
						// Success
						data.UPSRateShopError = 0 ;
						// Transaction successful
						data.UPSResponseDesc = data.stUpsRatesShop.RatingServiceSelectionResponse.Response.RESPONSESTATUSDESCRIPTION.XMLText ;
						if ( isArray(data.stUpsRatesShop.RatingServiceSelectionResponse.RatedShipment.xmlChildren) ) {
							if ( isArray(data.stUpsRatesShop.RatingServiceSelectionResponse.RatedShipment[1].RatedPackage.xmlChildren) ) {
								// Check if Package response is not an array, it will be an array if multi-piece shipment
								// Loop through the shipping rate results and the package results
								data.rateShopQuery = queryNew("PackageID, GuaranteedDTD, BillableWeight, WeightUnit, ScheduledDelivTime, OptionCharges, OptionChargesCurrency, PackageTotalCharges, PackageChargesCurrency, ServiceLevel, TotalCharges, TotalChargesCurrency, OriginalWeight, NegotiatedCharges, NegotiatedChargesCurrency") ;
								data.aRateShopQuery = data.stUpsRatesShop.RatingServiceSelectionResponse.RatedShipment ;
								qCount = 1 ;
								FOR ( idxRates = 1 ; idxRates LTE ArrayLen(data.aRateShopQuery); idxRates = idxRates + 1 ) {
								//// <cfloop index="idxRates" from="1" to="#ArrayLen(data.aRateShopQuery)#" ;
									data.aRatePackage = data.stUpsRatesShop.RatingServiceSelectionResponse.RatedShipment[idxRates].RatedPackage ;
									FOR ( idxPackages = 1 ; idxPackages LTE ArrayLen(data.aRatePackage); idxPackages = idxPackages + 1 ) {
									//// <cfloop index="idxPackages" from="1" to="#ArrayLen(data.aRatePackage)#" ;
										QueryAddRow(data.rateShopQuery, 1) ;
										QuerySetCell(data.rateShopQuery, "PackageID", "#idxPackages#") ;
										if ( StructKeyExists(data.aRateShopQuery[idxRates], "GuaranteedDaysToDelivery") ) {
										  QuerySetCell(data.rateShopQuery, "GuaranteedDTD", data.aRateShopQuery[idxRates].GuaranteedDaysToDelivery.XMLText, qCount) ;
										} else {
										  QuerySetCell(data.rateShopQuery, "GuaranteedDTD", "") ;
										}
										if ( StructKeyExists(data.aRateShopQuery[idxRates].RatedPackage[idxPackages].BillingWeight, "Weight") ) {
										  QuerySetCell(data.rateShopQuery, "BillableWeight", data.aRateShopQuery[idxRates].RatedPackage[idxPackages].BillingWeight.Weight.XMLText, qCount) ;
										} else {
										  QuerySetCell(data.rateShopQuery, "BillableWeight", "") ;
										}
										if ( StructKeyExists(data.aRateShopQuery[idxRates].RatedPackage[idxPackages].BillingWeight.UnitOfMeasurement, "Code") ) {
										  QuerySetCell(data.rateShopQuery, "WeightUnit", data.aRateShopQuery[idxRates].RatedPackage[idxPackages].BillingWeight.UnitOfMeasurement.Code.XMLText, qCount) ;
										} else {
										  QuerySetCell(data.rateShopQuery, "WeightUnit", "") ;
										}
										if ( StructKeyExists(data.aRateShopQuery[idxRates], "ScheduledDeliveryTime") ) {
										  QuerySetCell(data.rateShopQuery, "ScheduledDelivTime", data.aRateShopQuery[idxRates].ScheduledDeliveryTime.XMLText, qCount) ;
										} else {
										  QuerySetCell(data.rateShopQuery, "ScheduledDelivTime", "") ;
										}
										if ( StructKeyExists(data.aRateShopQuery[idxRates].RatedPackage[idxPackages].ServiceOptionsCharges, "MonetaryValue") ) {
										  QuerySetCell(data.rateShopQuery, "OptionCharges", data.aRateShopQuery[idxRates].RatedPackage[idxPackages].ServiceOptionsCharges.MonetaryValue.XMLText, qCount) ;
										} else {
										  QuerySetCell(data.rateShopQuery, "OptionCharges", "") ;
										}
										if ( StructKeyExists(data.aRateShopQuery[idxRates].RatedPackage[idxPackages].ServiceOptionsCharges, "CurrencyCode") ) {
										  QuerySetCell(data.rateShopQuery, "OptionChargesCurrency", data.aRateShopQuery[idxRates].RatedPackage[idxPackages].ServiceOptionsCharges.CurrencyCode.XMLText, qCount) ;
										} else {
										  QuerySetCell(data.rateShopQuery, "OptionChargesCurrency", "") ;
										}
										if ( StructKeyExists(data.aRateShopQuery[idxRates].RatedPackage[idxPackages].TotalCharges, "MonetaryValue") ) {
										  QuerySetCell(data.rateShopQuery, "PackageTotalCharges", data.aRateShopQuery[idxRates].RatedPackage[idxPackages].TotalCharges.MonetaryValue.XMLText, qCount) ;
										} else {
										  QuerySetCell(data.rateShopQuery, "PackageTotalCharges", "") ;
										}
										if ( StructKeyExists(data.aRateShopQuery[idxRates].RatedPackage[idxPackages].TotalCharges, "CurrencyCode") ) {
										  QuerySetCell(data.rateShopQuery, "PackageChargesCurrency", data.aRateShopQuery[idxRates].RatedPackage[idxPackages].TotalCharges.CurrencyCode.XMLText, qCount) ;
										} else {
										  QuerySetCell(data.rateShopQuery, "PackageChargesCurrency", "") ;
										}
										if ( StructKeyExists(data.aRateShopQuery[idxRates].Service, "Code") ) {
										  QuerySetCell(data.rateShopQuery, "ServiceLevel", data.aRateShopQuery[idxRates].Service.Code.XMLText, qCount) ;
										} else {
										  QuerySetCell(data.rateShopQuery, "ServiceLevel", "") ;
										}
										if ( StructKeyExists(data.aRateShopQuery[idxRates].TotalCharges, "MonetaryValue") ) {
										  QuerySetCell(data.rateShopQuery, "TotalCharges", data.aRateShopQuery[idxRates].TotalCharges.MonetaryValue.xmlText, qCount) ;
										  QuerySetCell(data.rateShopQuery, "NegotiatedCharges", data.aRateShopQuery[idxRates].TotalCharges.MonetaryValue.xmlText, qCount) ;
										} else {
										  QuerySetCell(data.rateShopQuery, "TotalCharges", "0") ;
										}
										if ( StructKeyExists(data.aRateShopQuery[idxRates].TotalCharges, "CurrencyCode") ) {
										  QuerySetCell(data.rateShopQuery, "TotalChargesCurrency", data.aRateShopQuery[idxRates].TotalCharges.CurrencyCode.xmlText, qCount) ;
										  QuerySetCell(data.rateShopQuery, "NegotiatedChargesCurrency", data.aRateShopQuery[idxRates].TotalCharges.CurrencyCode.xmlText, qCount) ;
										} else {
										  QuerySetCell(data.rateShopQuery, "TotalChargesCurrency", "") ;
										}
										if ( StructKeyExists(data.aRateShopQuery[idxRates].RatedPackage[idxPackages], "Weight") ) {
										  QuerySetCell(data.rateShopQuery, "OriginalWeight", data.aRateShopQuery[idxRates].RatedPackage[idxPackages].Weight.XMLText, qCount) ;
										} else {
										  QuerySetCell(data.rateShopQuery, "OriginalWeight", "") ;
										}
										aNegotiatedRates = xmlSearch(data.aRateShopQuery[idxRates], "NegotiatedRates/NetSummaryCharges/GrandTotal") ;
										if ( arrayLen(aNegotiatedRates) EQ 1 ) {
											negotiatedRates_Amount = aNegotiatedRates[1].CurrencyCode.xmlText ;
											negotiatedRates_CurrenycCode = aNegotiatedRates[1].CurrencyCode.xmlText ;
											QuerySetCell(data.rateShopQuery, "NegotiatedCharges", negotiatedRates_Amount, qCount) ;
											QuerySetCell(data.rateShopQuery, "NegotiatedChargesCurrency", negotiatedRates_CurrenycCode, qCount) ;
										}
										qCount = qCount + 1 ;
									}
									//// </cfloop>
								}
								//// </cfloop>
							} else {
								// Loop through the shipping rate results
								data.rateShopQuery = queryNew("PackageID, GuaranteedDTD, BillableWeight, WeightUnit, ScheduledDelivTime, OptionCharges, OptionChargesCurrency, PackageTotalCharges, PackageChargesCurrency, ServiceLevel, TotalCharges, TotalChargesCurrency, OriginalWeight, NegotiatedCharges, NegotiatedChargesCurrency") ;
								data.aRateShopQuery = data.stUpsRatesShop.RatingServiceSelectionResponse.RatedShipment ;
								FOR ( idxRates = 1 ; idxRates LTE ArrayLen(data.aRateShopQuery); idxRates = idxRates + 1 ) {
								//// <cfloop index="idxRates" from="1" to="#ArrayLen(data.aRateShopQuery)#" ;
									QueryAddRow(data.rateShopQuery, 1) ;
									QuerySetCell(data.rateShopQuery, "PackageID", "1") ;
									if ( StructKeyExists(data.aRateShopQuery[idxRates], "GuaranteedDaysToDelivery") ) {
										QuerySetCell(data.rateShopQuery, "GuaranteedDTD", data.aRateShopQuery[idxRates].GuaranteedDaysToDelivery.XMLText, idxRates) ;
									} else {
										QuerySetCell(data.rateShopQuery, "GuaranteedDTD", "") ;
									}
									if ( StructKeyExists(data.aRateShopQuery[idxRates].RatedPackage.BillingWeight, "Weight") ) {
										QuerySetCell(data.rateShopQuery, "BillableWeight", data.aRateShopQuery[idxRates].RatedPackage.BillingWeight.Weight.XMLText, idxRates) ;
									} else {
										QuerySetCell(data.rateShopQuery, "BillableWeight", "") ;
									}
									if ( StructKeyExists(data.aRateShopQuery[idxRates].RatedPackage.BillingWeight.UnitOfMeasurement, "Code") ) {
										QuerySetCell(data.rateShopQuery, "WeightUnit", data.aRateShopQuery[idxRates].RatedPackage.BillingWeight.UnitOfMeasurement.Code.XMLText, idxRates) ;
									} else {
										QuerySetCell(data.rateShopQuery, "WeightUnit", "") ;
									}
									if ( StructKeyExists(data.aRateShopQuery[idxRates], "ScheduledDeliveryTime") ) {
										QuerySetCell(data.rateShopQuery, "ScheduledDelivTime", data.aRateShopQuery[idxRates].ScheduledDeliveryTime.XMLText, idxRates) ;
									} else {
										QuerySetCell(data.rateShopQuery, "ScheduledDelivTime", "") ;
									}
									if ( StructKeyExists(data.aRateShopQuery[idxRates].RatedPackage.ServiceOptionsCharges, "MonetaryValue") ) {
										QuerySetCell(data.rateShopQuery, "OptionCharges", data.aRateShopQuery[idxRates].RatedPackage.ServiceOptionsCharges.MonetaryValue.XMLText, idxRates) ;
									} else {
										QuerySetCell(data.rateShopQuery, "OptionCharges", "") ;
									}
									if ( StructKeyExists(data.aRateShopQuery[idxRates].RatedPackage.ServiceOptionsCharges, "CurrencyCode") ) {
										QuerySetCell(data.rateShopQuery, "OptionChargesCurrency", data.aRateShopQuery[idxRates].RatedPackage.ServiceOptionsCharges.CurrencyCode.XMLText, idxRates) ;
									} else {
										QuerySetCell(data.rateShopQuery, "OptionChargesCurrency", "") ;
									}
									if ( StructKeyExists(data.aRateShopQuery[idxRates].Service, "Code") ) {
										QuerySetCell(data.rateShopQuery, "ServiceLevel", data.aRateShopQuery[idxRates].Service.Code.XMLText, idxRates) ;
									} else {
										QuerySetCell(data.rateShopQuery, "ServiceLevel", "") ;
									}
									if ( StructKeyExists(data.aRateShopQuery[idxRates].TotalCharges, "MonetaryValue") ) {
										QuerySetCell(data.rateShopQuery, "TotalCharges", data.aRateShopQuery[idxRates].TotalCharges.MonetaryValue.XMLText, idxRates) ;
										QuerySetCell(data.rateShopQuery, "PackageTotalCharges", data.aRateShopQuery[idxRates].TotalCharges.MonetaryValue.XMLText, idxRates) ;
										QuerySetCell(data.rateShopQuery, "NegotiatedCharges", data.aRateShopQuery[idxRates].TotalCharges.MonetaryValue.XMLText, idxRates) ;
									} else {
										QuerySetCell(data.rateShopQuery, "TotalCharges", "") ;
										QuerySetCell(data.rateShopQuery, "PackageTotalCharges", "") ;
									}
									if ( StructKeyExists(data.aRateShopQuery[idxRates].TotalCharges, "CurrencyCode") ) {
										QuerySetCell(data.rateShopQuery, "TotalChargesCurrency", data.aRateShopQuery[idxRates].TotalCharges.CurrencyCode.XMLText, idxRates) ;
										QuerySetCell(data.rateShopQuery, "PackageChargesCurrency", data.aRateShopQuery[idxRates].TotalCharges.CurrencyCode.XMLText, idxRates) ;
										QuerySetCell(data.rateShopQuery, "NegotiatedChargesCurrency", data.aRateShopQuery[idxRates].TotalCharges.CurrencyCode.XMLText, idxRates) ;
									} else {
										QuerySetCell(data.rateShopQuery, "TotalChargesCurrency", "") ;
										QuerySetCell(data.rateShopQuery, "PackageChargesCurrency", "") ;
									}
									if ( StructKeyExists(data.aRateShopQuery[idxRates].RatedPackage, "Weight") ) {
										QuerySetCell(data.rateShopQuery, "OriginalWeight", data.aRateShopQuery[idxRates].RatedPackage.Weight.XMLText, idxRates) ;
									} else {
										QuerySetCell(data.rateShopQuery, "OriginalWeight", "") ;
									}
									aNegotiatedRates = xmlSearch(data.aRateShopQuery[idxRates], "NegotiatedRates/NetSummaryCharges/GrandTotal") ;
									if ( arrayLen(aNegotiatedRates) EQ 1 ) {
										negotiatedRates_Amount = aNegotiatedRates[1].CurrencyCode.xmlText ;
										negotiatedRates_CurrenycCode = aNegotiatedRates[1].CurrencyCode.xmlText ;
										QuerySetCell(data.rateShopQuery, "NegotiatedCharges", negotiatedRates_Amount, qCount) ;
										QuerySetCell(data.rateShopQuery, "NegotiatedChargesCurrency", negotiatedRates_CurrenycCode, qCount) ;
									}
								}
								//// </cfloop>
							}
							// End Check if Package response is not an array, it will be an array if multi-piece shipment
						} else if ( StructKeyExists(data.stUpsRatesShop.RatingServiceSelectionResponse.RatedShipment.TotalCharges, "MonetaryValue") ) {
							data.aRateShopQuery = data.stUpsRatesShop.RatingServiceSelectionResponse.RatedShipment ;
								data.rateShopQuery = queryNew("PackageID, GuaranteedDTD, BillableWeight, WeightUnit, ScheduledDelivTime, OptionCharges, OptionChargesCurrency, PackageTotalCharges, PackageChargesCurrency, ServiceLevel, TotalCharges, TotalChargesCurrency, OriginalWeight, NegotiatedCharges, NegotiatedChargesCurrency") ;
								QueryAddRow(data.rateShopQuery, 1) ;
								QuerySetCell(data.rateShopQuery, "PackageID", "1") ;
								if ( StructKeyExists(data.aRateShopQuery, "GuaranteedDaysToDelivery") ) {
									QuerySetCell(data.rateShopQuery, "GuaranteedDTD", data.aRateShopQuery.GuaranteedDaysToDelivery.XMLText, 1) ;
								} else {
									QuerySetCell(data.rateShopQuery, "GuaranteedDTD", "") ;
								}
								if ( StructKeyExists(data.aRateShopQuery.RatedPackage.BillingWeight, "Weight") ) {
									QuerySetCell(data.rateShopQuery, "BillableWeight", data.aRateShopQuery.RatedPackage.BillingWeight.Weight.XMLText, 1) ;
								} else {
									QuerySetCell(data.rateShopQuery, "BillableWeight", "") ;
								}
								if ( StructKeyExists(data.aRateShopQuery.RatedPackage.BillingWeight.UnitOfMeasurement, "Code") ) {
									QuerySetCell(data.rateShopQuery, "WeightUnit", data.aRateShopQuery.RatedPackage.BillingWeight.UnitOfMeasurement.Code.XMLText, 1) ;
								} else {
									QuerySetCell(data.rateShopQuery, "WeightUnit", "") ;
								}
								if ( StructKeyExists(data.aRateShopQuery, "ScheduledDeliveryTime") ) {
									QuerySetCell(data.rateShopQuery, "ScheduledDelivTime", data.aRateShopQuery.ScheduledDeliveryTime.XMLText, 1) ;
								} else {
									QuerySetCell(data.rateShopQuery, "ScheduledDelivTime", "") ;
								}
								if ( StructKeyExists(data.aRateShopQuery.RatedPackage.ServiceOptionsCharges, "MonetaryValue") ) {
									QuerySetCell(data.rateShopQuery, "OptionCharges", data.aRateShopQuery.RatedPackage.ServiceOptionsCharges.MonetaryValue.XMLText, 1) ;
								} else {
									QuerySetCell(data.rateShopQuery, "OptionCharges", "") ;
								}
								if ( StructKeyExists(data.aRateShopQuery.RatedPackage.ServiceOptionsCharges, "CurrencyCode") ) {
									QuerySetCell(data.rateShopQuery, "OptionChargesCurrency", data.aRateShopQuery.RatedPackage.ServiceOptionsCharges.CurrencyCode.XMLText, 1) ;
								} else {
									QuerySetCell(data.rateShopQuery, "OptionChargesCurrency", "") ;
								}
								if ( StructKeyExists(data.aRateShopQuery.Service, "Code") ) {
									QuerySetCell(data.rateShopQuery, "ServiceLevel", data.aRateShopQuery.Service.Code.XMLText, 1) ;
								} else {
									QuerySetCell(data.rateShopQuery, "ServiceLevel", "") ;
								}
								if ( StructKeyExists(data.aRateShopQuery.TotalCharges, "MonetaryValue") ) {
									QuerySetCell(data.rateShopQuery, "TotalCharges", data.aRateShopQuery.TotalCharges.MonetaryValue.XMLText, 1) ;
									QuerySetCell(data.rateShopQuery, "PackageTotalCharges", data.aRateShopQuery.TotalCharges.MonetaryValue.XMLText, 1) ;
									QuerySetCell(data.rateShopQuery, "NegotiatedCharges", data.aRateShopQuery.TotalCharges.MonetaryValue.XMLText, 1) ;
								} else {
									QuerySetCell(data.rateShopQuery, "TotalCharges", "") ;
									QuerySetCell(data.rateShopQuery, "PackageTotalCharges", "") ;
								}
								if ( StructKeyExists(data.aRateShopQuery.TotalCharges, "CurrencyCode") ) {
									QuerySetCell(data.rateShopQuery, "TotalChargesCurrency", data.aRateShopQuery.TotalCharges.CurrencyCode.XMLText, 1) ;
									QuerySetCell(data.rateShopQuery, "PackageChargesCurrency", data.aRateShopQuery.TotalCharges.CurrencyCode.XMLText, 1) ;
									QuerySetCell(data.rateShopQuery, "NegotiatedChargesCurrency", data.aRateShopQuery.TotalCharges.CurrencyCode.XMLText, 1) ;
								} else {
									QuerySetCell(data.rateShopQuery, "TotalChargesCurrency", "") ;
									QuerySetCell(data.rateShopQuery, "PackageChargesCurrency", "") ;
								}
								if ( StructKeyExists(data.aRateShopQuery.RatedPackage, "Weight") ) {
									QuerySetCell(data.rateShopQuery, "OriginalWeight", data.aRateShopQuery.RatedPackage.Weight.XMLText, 1) ;
								} else {
									QuerySetCell(data.rateShopQuery, "OriginalWeight", "") ;
								}
								aNegotiatedRates = xmlSearch(data.aRateShopQuery, "NegotiatedRates/NetSummaryCharges/GrandTotal") ;
								if ( arrayLen(aNegotiatedRates) EQ 1 ) {
									negotiatedRates_Amount = aNegotiatedRates[1].CurrencyCode.xmlText ;
									negotiatedRates_CurrenycCode = aNegotiatedRates[1].CurrencyCode.xmlText ;
									QuerySetCell(data.rateShopQuery, "NegotiatedCharges", negotiatedRates_Amount, qCount) ;
									QuerySetCell(data.rateShopQuery, "NegotiatedChargesCurrency", negotiatedRates_CurrenycCode, qCount) ;
								}
						} else {
							// unexpected response
						}
					} else if ( IsDefined("data.stUpsRatesShop.RatingServiceSelectionResponse.Response.RESPONSESTATUSCODE.XmlText")
						AND data.stUpsRatesShop.RatingServiceSelectionResponse.Response.RESPONSESTATUSCODE.XmlText EQ 0 ) {
						// Failure
						data.UPSRateShopError = 1 ;
						data.UPSResponseDesc = data.stUpsRatesShop.RatingServiceSelectionResponse.Response.RESPONSESTATUSDESCRIPTION.XmlText ;
						if ( IsDefined("data.stUpsRatesShop.RatingServiceSelectionResponse.Response.Error.ErrorCode.XmlText") ) {
							data.UPSErrorCode = data.stUpsRatesShop.RatingServiceSelectionResponse.Response.Error.ErrorCode.XmlText ;
						}
						if ( IsDefined("data.stUpsRatesShop.RatingServiceSelectionResponse.Response.Error.ErrorDescription.XmlText") ) {
							data.UPSErrorDescription = data.stUpsRatesShop.RatingServiceSelectionResponse.Response.Error.ErrorDescription.XmlText ;
						}
					} else {
						data.UPSRateShopError = 2 ;
						// Error Retrieving rates or communication failure to UPS
					}
				</cfscript>
				
				<!--- OLD, NOT NEEDED
				<cfif isDefined("data.stUpsRatesShop.RatingServiceSelectionResponse.Response.RESPONSESTATUSCODE.XMLText") AND 
					data.stUpsRatesShop.RatingServiceSelectionResponse.Response.RESPONSESTATUSCODE.XMLText EQ 1>
					<!--- Success --->
					<cfset data.UPSRateShopError = 0>
					<!--- Transaction successful --->
					<cfset data.UPSResponseDesc = data.stUpsRatesShop.RatingServiceSelectionResponse.Response.RESPONSESTATUSDESCRIPTION.XMLText>
					<cfif #isArray(data.stUpsRatesShop.RatingServiceSelectionResponse.RatedShipment.xmlChildren)#>
					  <cfif #isArray(data.stUpsRatesShop.RatingServiceSelectionResponse.RatedShipment[1].RatedPackage.xmlChildren)#>
						<!--- Check if Package response is not an array, it will be an array if multi-piece shipment --->
						<!--- Loop through the shipping rate results and the package results --->
						<cfset data.rateShopQuery = queryNew("PackageID, GuaranteedDTD, BillableWeight, WeightUnit, ScheduledDelivTime, OptionCharges, OptionChargesCurrency, PackageTotalCharges, PackageChargesCurrency, ServiceLevel, TotalCharges, TotalChargesCurrency, OriginalWeight, NegotiatedCharges, NegotiatedChargesCurrency")>
						<cfset data.aRateShopQuery = data.stUpsRatesShop.RatingServiceSelectionResponse.RatedShipment>
						<cfset qCount = 1>
						<cfloop index="idxRates" from="1" to="#ArrayLen(data.aRateShopQuery)#">
						  <cfset data.aRatePackage = data.stUpsRatesShop.RatingServiceSelectionResponse.RatedShipment[idxRates].RatedPackage>
						  <cfloop index="idxPackages" from="1" to="#ArrayLen(data.aRatePackage)#">
							<cfset newRow  = QueryAddRow(data.rateShopQuery, 1)>
							<cfset temp = QuerySetCell(data.rateShopQuery, "PackageID", "#idxPackages#")>
							<cfif StructKeyExists(data.aRateShopQuery[idxRates], "GuaranteedDaysToDelivery")>
							  <cfset temp = QuerySetCell(data.rateShopQuery, "GuaranteedDTD", data.aRateShopQuery[idxRates].GuaranteedDaysToDelivery.XMLText, qCount)>
							  <cfelse>
							  <cfset temp = QuerySetCell(data.rateShopQuery, "GuaranteedDTD", "")>
							</cfif>
							<cfif StructKeyExists(data.aRateShopQuery[idxRates].RatedPackage[idxPackages].BillingWeight, "Weight")>
							  <cfset temp = QuerySetCell(data.rateShopQuery, "BillableWeight", data.aRateShopQuery[idxRates].RatedPackage[idxPackages].BillingWeight.Weight.XMLText, qCount)>
							  <cfelse>
							  <cfset temp = QuerySetCell(data.rateShopQuery, "BillableWeight", "")>
							</cfif>
							<cfif StructKeyExists(data.aRateShopQuery[idxRates].RatedPackage[idxPackages].BillingWeight.UnitOfMeasurement, "Code")>
							  <cfset temp = QuerySetCell(data.rateShopQuery, "WeightUnit", data.aRateShopQuery[idxRates].RatedPackage[idxPackages].BillingWeight.UnitOfMeasurement.Code.XMLText, qCount)>
							  <cfelse>
							  <cfset temp = QuerySetCell(data.rateShopQuery, "WeightUnit", "")>
							</cfif>
							<cfif StructKeyExists(data.aRateShopQuery[idxRates], "ScheduledDeliveryTime")>
							  <cfset temp = QuerySetCell(data.rateShopQuery, "ScheduledDelivTime", data.aRateShopQuery[idxRates].ScheduledDeliveryTime.XMLText, qCount)>
							  <cfelse>
							  <cfset temp = QuerySetCell(data.rateShopQuery, "ScheduledDelivTime", "")>
							</cfif>
							<cfif StructKeyExists(data.aRateShopQuery[idxRates].RatedPackage[idxPackages].ServiceOptionsCharges, "MonetaryValue")>
							  <cfset temp = QuerySetCell(data.rateShopQuery, "OptionCharges", data.aRateShopQuery[idxRates].RatedPackage[idxPackages].ServiceOptionsCharges.MonetaryValue.XMLText, qCount)>
							  <cfelse>
							  <cfset temp = QuerySetCell(data.rateShopQuery, "OptionCharges", "")>
							</cfif>
							<cfif StructKeyExists(data.aRateShopQuery[idxRates].RatedPackage[idxPackages].ServiceOptionsCharges, "CurrencyCode")>
							  <cfset temp = QuerySetCell(data.rateShopQuery, "OptionChargesCurrency", data.aRateShopQuery[idxRates].RatedPackage[idxPackages].ServiceOptionsCharges.CurrencyCode.XMLText, qCount)>
							  <cfelse>
							  <cfset temp = QuerySetCell(data.rateShopQuery, "OptionChargesCurrency", "")>
							</cfif>
							<cfif StructKeyExists(data.aRateShopQuery[idxRates].RatedPackage[idxPackages].TotalCharges, "MonetaryValue")>
							  <cfset temp = QuerySetCell(data.rateShopQuery, "PackageTotalCharges", data.aRateShopQuery[idxRates].RatedPackage[idxPackages].TotalCharges.MonetaryValue.XMLText, qCount)>
							  <cfelse>
							  <cfset temp = QuerySetCell(data.rateShopQuery, "PackageTotalCharges", "")>
							</cfif>
							<cfif StructKeyExists(data.aRateShopQuery[idxRates].RatedPackage[idxPackages].TotalCharges, "CurrencyCode")>
							  <cfset temp = QuerySetCell(data.rateShopQuery, "PackageChargesCurrency", data.aRateShopQuery[idxRates].RatedPackage[idxPackages].TotalCharges.CurrencyCode.XMLText, qCount)>
							  <cfelse>
							  <cfset temp = QuerySetCell(data.rateShopQuery, "PackageChargesCurrency", "")>
							</cfif>
							<cfif StructKeyExists(data.aRateShopQuery[idxRates].Service, "Code")>
							  <cfset temp = QuerySetCell(data.rateShopQuery, "ServiceLevel", data.aRateShopQuery[idxRates].Service.Code.XMLText, qCount)>
							  <cfelse>
							  <cfset temp = QuerySetCell(data.rateShopQuery, "ServiceLevel", "")>
							</cfif>
							<cfif StructKeyExists(data.aRateShopQuery[idxRates].TotalCharges, "MonetaryValue")>
							  <cfset temp = QuerySetCell(data.rateShopQuery, "TotalCharges", data.aRateShopQuery[idxRates].TotalCharges.MonetaryValue.xmlText, qCount)>
							  <cfset temp = QuerySetCell(data.rateShopQuery, "NegotiatedCharges", data.aRateShopQuery[idxRates].TotalCharges.MonetaryValue.xmlText, qCount)>
							<cfelse>
							  <cfset temp = QuerySetCell(data.rateShopQuery, "TotalCharges", "0")>
							</cfif>
							<cfif StructKeyExists(data.aRateShopQuery[idxRates].TotalCharges, "CurrencyCode")>
							  <cfset temp = QuerySetCell(data.rateShopQuery, "TotalChargesCurrency", data.aRateShopQuery[idxRates].TotalCharges.CurrencyCode.xmlText, qCount)>
							  <cfset temp = QuerySetCell(data.rateShopQuery, "NegotiatedChargesCurrency", data.aRateShopQuery[idxRates].TotalCharges.CurrencyCode.xmlText, qCount)>
							<cfelse>
							  <cfset temp = QuerySetCell(data.rateShopQuery, "TotalChargesCurrency", "")>
							</cfif>
							<cfif StructKeyExists(data.aRateShopQuery[idxRates].RatedPackage[idxPackages], "Weight")>
							  <cfset temp = QuerySetCell(data.rateShopQuery, "OriginalWeight", data.aRateShopQuery[idxRates].RatedPackage[idxPackages].Weight.XMLText, qCount)>
							  <cfelse>
							  <cfset temp = QuerySetCell(data.rateShopQuery, "OriginalWeight", "")>
							</cfif>
							<cfset aNegotiatedRates = xmlSearch(data.aRateShopQuery[idxRates], "NegotiatedRates/NetSummaryCharges/GrandTotal")>
							<cfif arrayLen(aNegotiatedRates) EQ 1>
								<cfset negotiatedRates_Amount = aNegotiatedRates[1].CurrencyCode.xmlText>
								<cfset negotiatedRates_CurrenycCode = aNegotiatedRates[1].CurrencyCode.xmlText>
								<cfset temp = QuerySetCell(data.rateShopQuery, "NegotiatedCharges", negotiatedRates_Amount, qCount)>
								<cfset temp = QuerySetCell(data.rateShopQuery, "NegotiatedChargesCurrency", negotiatedRates_CurrenycCode, qCount)>
							</cfif>
							<cfset qCount = qCount + 1>
						  </cfloop>
						</cfloop>
					   <cfelse>
						<!--- Loop through the shipping rate results --->
						<cfset data.rateShopQuery = queryNew("PackageID, GuaranteedDTD, BillableWeight, WeightUnit, ScheduledDelivTime, OptionCharges, OptionChargesCurrency, PackageTotalCharges, PackageChargesCurrency, ServiceLevel, TotalCharges, TotalChargesCurrency, OriginalWeight, NegotiatedCharges, NegotiatedChargesCurrency")>
						<cfset data.aRateShopQuery = data.stUpsRatesShop.RatingServiceSelectionResponse.RatedShipment>
						<cfloop index="idxRates" from="1" to="#ArrayLen(data.aRateShopQuery)#">
						  <cfset newRow  = QueryAddRow(data.rateShopQuery, 1)>
						  <cfset temp = QuerySetCell(data.rateShopQuery, "PackageID", "1")>
						  <cfif StructKeyExists(data.aRateShopQuery[idxRates], "GuaranteedDaysToDelivery")>
							<cfset temp = QuerySetCell(data.rateShopQuery, "GuaranteedDTD", data.aRateShopQuery[idxRates].GuaranteedDaysToDelivery.XMLText, idxRates)>
							<cfelse>
							<cfset temp = QuerySetCell(data.rateShopQuery, "GuaranteedDTD", "")>
						  </cfif>
						  <cfif StructKeyExists(data.aRateShopQuery[idxRates].RatedPackage.BillingWeight, "Weight")>
							<cfset temp = QuerySetCell(data.rateShopQuery, "BillableWeight", data.aRateShopQuery[idxRates].RatedPackage.BillingWeight.Weight.XMLText, idxRates)>
							<cfelse>
							<cfset temp = QuerySetCell(data.rateShopQuery, "BillableWeight", "")>
						  </cfif>
						  <cfif StructKeyExists(data.aRateShopQuery[idxRates].RatedPackage.BillingWeight.UnitOfMeasurement, "Code")>
							<cfset temp = QuerySetCell(data.rateShopQuery, "WeightUnit", data.aRateShopQuery[idxRates].RatedPackage.BillingWeight.UnitOfMeasurement.Code.XMLText, idxRates)>
							<cfelse>
							<cfset temp = QuerySetCell(data.rateShopQuery, "WeightUnit", "")>
						  </cfif>
						  <cfif StructKeyExists(data.aRateShopQuery[idxRates], "ScheduledDeliveryTime")>
							<cfset temp = QuerySetCell(data.rateShopQuery, "ScheduledDelivTime", data.aRateShopQuery[idxRates].ScheduledDeliveryTime.XMLText, idxRates)>
							<cfelse>
							<cfset temp = QuerySetCell(data.rateShopQuery, "ScheduledDelivTime", "")>
						  </cfif>
						  <cfif StructKeyExists(data.aRateShopQuery[idxRates].RatedPackage.ServiceOptionsCharges, "MonetaryValue")>
							<cfset temp = QuerySetCell(data.rateShopQuery, "OptionCharges", data.aRateShopQuery[idxRates].RatedPackage.ServiceOptionsCharges.MonetaryValue.XMLText, idxRates)>
							<cfelse>
							<cfset temp = QuerySetCell(data.rateShopQuery, "OptionCharges", "")>
						  </cfif>
						  <cfif StructKeyExists(data.aRateShopQuery[idxRates].RatedPackage.ServiceOptionsCharges, "CurrencyCode")>
							<cfset temp = QuerySetCell(data.rateShopQuery, "OptionChargesCurrency", data.aRateShopQuery[idxRates].RatedPackage.ServiceOptionsCharges.CurrencyCode.XMLText, idxRates)>
							<cfelse>
							<cfset temp = QuerySetCell(data.rateShopQuery, "OptionChargesCurrency", "")>
						  </cfif>
						  <cfif StructKeyExists(data.aRateShopQuery[idxRates].Service, "Code")>
							<cfset temp = QuerySetCell(data.rateShopQuery, "ServiceLevel", data.aRateShopQuery[idxRates].Service.Code.XMLText, idxRates)>
							<cfelse>
							<cfset temp = QuerySetCell(data.rateShopQuery, "ServiceLevel", "")>
						  </cfif>
						  <cfif StructKeyExists(data.aRateShopQuery[idxRates].TotalCharges, "MonetaryValue")>
							<cfset temp = QuerySetCell(data.rateShopQuery, "TotalCharges", data.aRateShopQuery[idxRates].TotalCharges.MonetaryValue.XMLText, idxRates)>
							<cfset temp = QuerySetCell(data.rateShopQuery, "PackageTotalCharges", data.aRateShopQuery[idxRates].TotalCharges.MonetaryValue.XMLText, idxRates)>
							<cfset temp = QuerySetCell(data.rateShopQuery, "NegotiatedCharges", data.aRateShopQuery[idxRates].TotalCharges.MonetaryValue.XMLText, idxRates)>
						  <cfelse>
							<cfset temp = QuerySetCell(data.rateShopQuery, "TotalCharges", "")>
							<cfset temp = QuerySetCell(data.rateShopQuery, "PackageTotalCharges", "")>
						  </cfif>
						  <cfif StructKeyExists(data.aRateShopQuery[idxRates].TotalCharges, "CurrencyCode")>
							<cfset temp = QuerySetCell(data.rateShopQuery, "TotalChargesCurrency", data.aRateShopQuery[idxRates].TotalCharges.CurrencyCode.XMLText, idxRates)>
							<cfset temp = QuerySetCell(data.rateShopQuery, "PackageChargesCurrency", data.aRateShopQuery[idxRates].TotalCharges.CurrencyCode.XMLText, idxRates)>
							<cfset temp = QuerySetCell(data.rateShopQuery, "NegotiatedChargesCurrency", data.aRateShopQuery[idxRates].TotalCharges.CurrencyCode.XMLText, idxRates)>
						  <cfelse>
							<cfset temp = QuerySetCell(data.rateShopQuery, "TotalChargesCurrency", "")>
							<cfset temp = QuerySetCell(data.rateShopQuery, "PackageChargesCurrency", "")>
						  </cfif>
						  <cfif StructKeyExists(data.aRateShopQuery[idxRates].RatedPackage, "Weight")>
							<cfset temp = QuerySetCell(data.rateShopQuery, "OriginalWeight", data.aRateShopQuery[idxRates].RatedPackage.Weight.XMLText, idxRates)>
							<cfelse>
							<cfset temp = QuerySetCell(data.rateShopQuery, "OriginalWeight", "")>
						  </cfif>
						  <cfset aNegotiatedRates = xmlSearch(data.aRateShopQuery[idxRates], "NegotiatedRates/NetSummaryCharges/GrandTotal")>
						  <cfif arrayLen(aNegotiatedRates) EQ 1>
								<cfset negotiatedRates_Amount = aNegotiatedRates[1].CurrencyCode.xmlText>
								<cfset negotiatedRates_CurrenycCode = aNegotiatedRates[1].CurrencyCode.xmlText>
								<cfset temp = QuerySetCell(data.rateShopQuery, "NegotiatedCharges", negotiatedRates_Amount, qCount)>
								<cfset temp = QuerySetCell(data.rateShopQuery, "NegotiatedChargesCurrency", negotiatedRates_CurrenycCode, qCount)>
						  </cfif>
						</cfloop>
					  </cfif>
					  <!--- End Check if Package response is not an array, it will be an array if multi-piece shipment --->
					<cfelseif StructKeyExists(data.stUpsRatesShop.RatingServiceSelectionResponse.RatedShipment.TotalCharges, "MonetaryValue")>
						  <cfset data.aRateShopQuery = data.stUpsRatesShop.RatingServiceSelectionResponse.RatedShipment>
						  <cfset data.rateShopQuery = queryNew("PackageID, GuaranteedDTD, BillableWeight, WeightUnit, ScheduledDelivTime, OptionCharges, OptionChargesCurrency, PackageTotalCharges, PackageChargesCurrency, ServiceLevel, TotalCharges, TotalChargesCurrency, OriginalWeight, NegotiatedCharges, NegotiatedChargesCurrency")>
						  <cfset newRow  = QueryAddRow(data.rateShopQuery, 1)>
						  <cfset temp = QuerySetCell(data.rateShopQuery, "PackageID", "1")>
						  <cfif StructKeyExists(data.aRateShopQuery, "GuaranteedDaysToDelivery")>
							<cfset temp = QuerySetCell(data.rateShopQuery, "GuaranteedDTD", data.aRateShopQuery.GuaranteedDaysToDelivery.XMLText, 1)>
							<cfelse>
							<cfset temp = QuerySetCell(data.rateShopQuery, "GuaranteedDTD", "")>
						  </cfif>
						  <cfif StructKeyExists(data.aRateShopQuery.RatedPackage.BillingWeight, "Weight")>
							<cfset temp = QuerySetCell(data.rateShopQuery, "BillableWeight", data.aRateShopQuery.RatedPackage.BillingWeight.Weight.XMLText, 1)>
							<cfelse>
							<cfset temp = QuerySetCell(data.rateShopQuery, "BillableWeight", "")>
						  </cfif>
						  <cfif StructKeyExists(data.aRateShopQuery.RatedPackage.BillingWeight.UnitOfMeasurement, "Code")>
							<cfset temp = QuerySetCell(data.rateShopQuery, "WeightUnit", data.aRateShopQuery.RatedPackage.BillingWeight.UnitOfMeasurement.Code.XMLText, 1)>
							<cfelse>
							<cfset temp = QuerySetCell(data.rateShopQuery, "WeightUnit", "")>
						  </cfif>
						  <cfif StructKeyExists(data.aRateShopQuery, "ScheduledDeliveryTime")>
							<cfset temp = QuerySetCell(data.rateShopQuery, "ScheduledDelivTime", data.aRateShopQuery.ScheduledDeliveryTime.XMLText, 1)>
							<cfelse>
							<cfset temp = QuerySetCell(data.rateShopQuery, "ScheduledDelivTime", "")>
						  </cfif>
						  <cfif StructKeyExists(data.aRateShopQuery.RatedPackage.ServiceOptionsCharges, "MonetaryValue")>
							<cfset temp = QuerySetCell(data.rateShopQuery, "OptionCharges", data.aRateShopQuery.RatedPackage.ServiceOptionsCharges.MonetaryValue.XMLText, 1)>
							<cfelse>
							<cfset temp = QuerySetCell(data.rateShopQuery, "OptionCharges", "")>
						  </cfif>
						  <cfif StructKeyExists(data.aRateShopQuery.RatedPackage.ServiceOptionsCharges, "CurrencyCode")>
							<cfset temp = QuerySetCell(data.rateShopQuery, "OptionChargesCurrency", data.aRateShopQuery.RatedPackage.ServiceOptionsCharges.CurrencyCode.XMLText, 1)>
							<cfelse>
							<cfset temp = QuerySetCell(data.rateShopQuery, "OptionChargesCurrency", "")>
						  </cfif>
						  <cfif StructKeyExists(data.aRateShopQuery.Service, "Code")>
							<cfset temp = QuerySetCell(data.rateShopQuery, "ServiceLevel", data.aRateShopQuery.Service.Code.XMLText, 1)>
							<cfelse>
							<cfset temp = QuerySetCell(data.rateShopQuery, "ServiceLevel", "")>
						  </cfif>
						  <cfif StructKeyExists(data.aRateShopQuery.TotalCharges, "MonetaryValue")>
							<cfset temp = QuerySetCell(data.rateShopQuery, "TotalCharges", data.aRateShopQuery.TotalCharges.MonetaryValue.XMLText, 1)>
							<cfset temp = QuerySetCell(data.rateShopQuery, "PackageTotalCharges", data.aRateShopQuery.TotalCharges.MonetaryValue.XMLText, 1)>
							<cfset temp = QuerySetCell(data.rateShopQuery, "NegotiatedCharges", data.aRateShopQuery.TotalCharges.MonetaryValue.XMLText, 1)>
						  <cfelse>
							<cfset temp = QuerySetCell(data.rateShopQuery, "TotalCharges", "")>
							<cfset temp = QuerySetCell(data.rateShopQuery, "PackageTotalCharges", "")>
						  </cfif>
						  <cfif StructKeyExists(data.aRateShopQuery.TotalCharges, "CurrencyCode")>
							<cfset temp = QuerySetCell(data.rateShopQuery, "TotalChargesCurrency", data.aRateShopQuery.TotalCharges.CurrencyCode.XMLText, 1)>
							<cfset temp = QuerySetCell(data.rateShopQuery, "PackageChargesCurrency", data.aRateShopQuery.TotalCharges.CurrencyCode.XMLText, 1)>
							<cfset temp = QuerySetCell(data.rateShopQuery, "NegotiatedChargesCurrency", data.aRateShopQuery.TotalCharges.CurrencyCode.XMLText, 1)>
						  <cfelse>
							<cfset temp = QuerySetCell(data.rateShopQuery, "TotalChargesCurrency", "")>
							<cfset temp = QuerySetCell(data.rateShopQuery, "PackageChargesCurrency", "")>
						  </cfif>
						  <cfif StructKeyExists(data.aRateShopQuery.RatedPackage, "Weight")>
							<cfset temp = QuerySetCell(data.rateShopQuery, "OriginalWeight", data.aRateShopQuery.RatedPackage.Weight.XMLText, 1)>
							<cfelse>
							<cfset temp = QuerySetCell(data.rateShopQuery, "OriginalWeight", "")>
						  </cfif>
						  <cfset aNegotiatedRates = xmlSearch(data.aRateShopQuery, "NegotiatedRates/NetSummaryCharges/GrandTotal")>
						  <cfif arrayLen(aNegotiatedRates) EQ 1>
								<cfset negotiatedRates_Amount = aNegotiatedRates[1].CurrencyCode.xmlText>
								<cfset negotiatedRates_CurrenycCode = aNegotiatedRates[1].CurrencyCode.xmlText>
								<cfset temp = QuerySetCell(data.rateShopQuery, "NegotiatedCharges", negotiatedRates_Amount, qCount)>
								<cfset temp = QuerySetCell(data.rateShopQuery, "NegotiatedChargesCurrency", negotiatedRates_CurrenycCode, qCount)>
						  </cfif>
					  <cfelse>
						<!--- unexpected response --->
					  </cfif>
					<cfelseif IsDefined("data.stUpsRatesShop.RatingServiceSelectionResponse.Response.RESPONSESTATUSCODE.XmlText") AND 
						data.stUpsRatesShop.RatingServiceSelectionResponse.Response.RESPONSESTATUSCODE.XmlText EQ 0>
						<!--- Failure --->
						<cfset data.UPSRateShopError = 1>
						<cfset data.UPSResponseDesc = data.stUpsRatesShop.RatingServiceSelectionResponse.Response.RESPONSESTATUSDESCRIPTION.XmlText>
						<cfif IsDefined("data.stUpsRatesShop.RatingServiceSelectionResponse.Response.Error.ErrorCode.XmlText")>
						  <cfset data.UPSErrorCode = data.stUpsRatesShop.RatingServiceSelectionResponse.Response.Error.ErrorCode.XmlText>
						</cfif>
						<cfif IsDefined("data.stUpsRatesShop.RatingServiceSelectionResponse.Response.Error.ErrorDescription.XmlText")>
						  <cfset data.UPSErrorDescription = data.stUpsRatesShop.RatingServiceSelectionResponse.Response.Error.ErrorDescription.XmlText>
						</cfif>
					
					<cfelse>
						<cfset data.UPSRateShopError = 2>
						<!--- Error Retrieving rates or communication failure to UPS --->
					</cfif> --->
				
			<cfelse>
				<cfset data.UPSRateShopError = 2>
				<!--- ///////// no valid response received back from ups ///////// --->
			</cfif>
			<cfcatch type="any">
			 <cfset data.UPSRateShopError = 2>
			</cfcatch>
		   </cftry>
		  </cfcase>
		  <!--- END UPS Rate and Service Shop Request --->
		  <!--- UPS Rate for specific Service --->
		  <cfcase value="rateRequest">
		  <cftry>
		  <cfif ( ListLen(arguments.PackageLength) EQ ListLen(arguments.PackageWeight)
			  AND ListLen(arguments.PackageWidth) EQ ListLen(arguments.PackageHeight)
			  AND ListLen(arguments.PackageLength) EQ ListLen(arguments.PackageWidth) )>
		  <cfelse>
			<cfset data.UPSRateError = 2>
			<cfset data.UPSResponseDesc = "Error: You must enter pass an equal number of weight and dimensions package elements for Multi-Piece shipments">
			<cfset data.UPSErrorCode = "">
			<cfabort>
		  </cfif>
		  <cfscript>
			if ( arguments.SaturdayPickup EQ 1 ) {
				SatPickupIndicator = '<SaturdayPickup/>';
			} else {
				SatPickupIndicator = '';
			}
			if ( arguments.SaturdayDelivery EQ 1 ) {
				SatDeliveryIndicator = '<SaturdayDelivery/>';
			} else {
				SatDeliveryIndicator = '';
			}
			if ( arguments.ResidentialAddress EQ 1 ) {
				ResidentialIndicator = '<ResidentialAddressIndicator/>';
			} else {
				ResidentialIndicator = '';
			}
			if ( ListLen(arguments.PackageWeight) GT 1 ) {
				PackageIndicator = '';
				 FOR ( idx = 1 ; idx LTE ListLen(arguments.PackageWeight); idx = idx + 1 ) {
					 PackageIndicator = '#PackageIndicator#
					 <Package>
				  <PackagingType>
					<Code>#arguments.PackageCode#</Code>
					<Description>#arguments.PackageDesc#</Description>
				  </PackagingType>
				  <Dimensions>
					<UnitOfMeasurement>
						<Code>#arguments.PackageUnitOfMeasurement#</Code>
					</UnitOfMeasurement>
					<Length>#NumberFormat(ListGetAt(arguments.PackageLength, idx), "999.9")#</Length>
					<Width>#NumberFormat(ListGetAt(arguments.PackageWidth, idx), "999.9")#</Width>
					<Height>#NumberFormat(ListGetAt(arguments.PackageHeight, idx), "999.9")#</Height>
				  </Dimensions>
				  <PackageWeight>
					<UnitOfMeasurement>
						<Code>#arguments.PackageWeightUnit#</Code>
					</UnitOfMeasurement>
					<Weight>#ListGetAt(arguments.PackageWeight, idx)#</Weight>
				  </PackageWeight>
				  <PackageServiceOptions>
					<InsuredValue>
					  <CurrencyCode>#arguments.CurrencyCode#</CurrencyCode>
					  <MonetaryValue>#NumberFormat(ListGetAt(arguments.InsuredValue, idx), "999.99")#</MonetaryValue>
					</InsuredValue>
				  </PackageServiceOptions>
				  <OversizePackage>#arguments.PackageOversize#</OversizePackage>
				 </Package>';
				  }
			}
		
			else {
				PackageIndicator = '<Package>
				  <PackagingType>
					<Code>#arguments.PackageCode#</Code>
					<Description>#arguments.PackageDesc#</Description>
				  </PackagingType>
				  <Dimensions>
					<UnitOfMeasurement>
						<Code>#arguments.PackageUnitOfMeasurement#</Code>
					</UnitOfMeasurement>
					<Length>#NumberFormat(arguments.PackageLength, "999.9")#</Length>
					<Width>#NumberFormat(arguments.PackageWidth, "999.9")#</Width>
					<Height>#NumberFormat(arguments.PackageHeight, "999.9")#</Height>
				  </Dimensions>
				  <PackageWeight>
					<UnitOfMeasurement>
						<Code>#arguments.PackageWeightUnit#</Code>
					</UnitOfMeasurement>
					<Weight>#arguments.PackageWeight#</Weight>
				  </PackageWeight>
				  <PackageServiceOptions>
					<InsuredValue>
					  <CurrencyCode>#arguments.CurrencyCode#</CurrencyCode>
					  <MonetaryValue>#NumberFormat(arguments.InsuredValue, "999.99")#</MonetaryValue>
					</InsuredValue>
				  </PackageServiceOptions>
				  <OversizePackage>#arguments.PackageOversize#</OversizePackage>
				 </Package>';
			}
			// Negotiated/Discount Rate Request indiciator
			negotiatedRateIndicator = '';
			if ( isDefined("arguments.negotiatedRates") AND arguments.negotiatedRates EQ 1 ) {
				negotiatedRateIndicator = '<RateInformation>
					<NegotiatedRatesIndicator/>
				</RateInformation>';
			}
			
			arguments.RateAccess = '<?xml version="#arguments.XMLVersion#"?>
			<AccessRequest xml:lang="en-US">
			<AccessLicenseNumber>#arguments.UPSAccessKey#</AccessLicenseNumber>
				<UserId>#arguments.UPSUserID#</UserId>
				<Password>#arguments.UPSPassword#</Password>
			</AccessRequest>';
		
			arguments.RateRequest = '<?xml version="#arguments.XMLVersion#"?>
			<RatingServiceSelectionRequest xml:lang="en-US">
			  <Request>
				<TransactionReference>
				  <CustomerContext>Rating and Service</CustomerContext>
				  <XpciVersion>#arguments.XPCIVersion#</XpciVersion>
				</TransactionReference>
				<RequestAction>Rate</RequestAction>
				<RequestOption>rate</RequestOption>
			  </Request>
			  <PickupType>
				<Code>#arguments.PickUpType#</Code>
			  </PickupType>
			  <Shipment>
				<Shipper>
				  <Address>
					<City>#arguments.ShipperCity#</City>
					<StateProvinceCode>#arguments.ShipperState#</StateProvinceCode>
					<PostalCode>#arguments.ShipperZip#</PostalCode>
					<CountryCode>#arguments.ShipperCountry#</CountryCode>
				  </Address>
				</Shipper>
				<ShipTo>
				  <Address>
					<AddressLine1>#arguments.ShipToAddress1#</AddressLine1>
					<AddressLine2>#arguments.ShipToAddress2#</AddressLine2>
					<AddressLine3>#arguments.ShipToAddress3#</AddressLine3>
					<City>#arguments.ShipToCity#</City>
					<StateProvinceCode>#arguments.ShipToState#</StateProvinceCode>		
					<PostalCode>#arguments.ShipToZip#</PostalCode>
					<CountryCode>#arguments.ShipToCountry#</CountryCode>
					#ResidentialIndicator#
				  </Address>
				</ShipTo>
				<Service>
					<Code>#arguments.ServiceType#</Code>
				</Service>
				#PackageIndicator#
				 <ShipmentServiceOptions>
					#SatPickupIndicator#
					#SatDeliveryIndicator#
				 </ShipmentServiceOptions>
				 #negotiatedRateIndicator#
			  </Shipment>
			</RatingServiceSelectionRequest>';
		
			arguments.XMLRequestInput = '#arguments.RateAccess#
			#arguments.RateRequest#';
		
			</cfscript>
		  <cfhttp method="post" url="#arguments.rateServer#" resolveurl="yes" port="443" timeout="#arguments.TimeOut#">
			<cfhttpparam name="XML" type="xml" value="#arguments.XMLRequestInput#">
		  </cfhttp>
		  
		  <cfif IsDefined("cfhttp.FileContent") AND Len(Trim(cfhttp.FileContent)) GT 10>
			  <cfset data.stUpsRate = XmlParse(Trim(cfhttp.FileContent))>
			  <cfif IsDefined("arguments.Debug") AND arguments.Debug EQ "TRUE">
				<cffile action="WRITE" file="#arguments.ServerFilePath##trailingSlash#Debug#trailingSlash#RateAccess.xml" output="#arguments.RateAccess#" addnewline="No" nameconflict="overwrite">
				<cffile action="WRITE" file="#arguments.ServerFilePath##trailingSlash#Debug#trailingSlash#RateRequest.xml" output="#arguments.RateRequest#" addnewline="No" nameconflict="overwrite">
				<cfoutput>
				  <cfdump var="#data.stUpsRate#">
				  <a href="Debug#trailingSlash#RateAccess.xml" target="_blank">View XML Access File</a> <a href="Debug#trailingSlash#RateRequest.xml" target="_blank">View XML Request File</a> </cfoutput>
				<cfabort>
			  </cfif>
			  <cfif IsDefined("data.stUpsRate.RatingServiceSelectionResponse.Response.RESPONSESTATUSCODE.XMLText") AND 
			
					#data.stUpsRate.RatingServiceSelectionResponse.Response.RESPONSESTATUSCODE.XMLText# EQ 1>
				<!--- Success --->
				<cfset data.UPSRateError = 0>
				<!--- Transaction successful --->
				<cfset data.UPSResponseDesc = data.stUpsRate.RatingServiceSelectionResponse.Response.RESPONSESTATUSDESCRIPTION.XMLText>
				<!--- Check if multi-piece shipment and a rates array was returned --->
				<cfif #isArray(data.stUpsRate.RatingServiceSelectionResponse.RatedShipment.RatedPackage.XMLChildren)#>
				  <!--- Loop through the shipping rate results and the package results --->
				  <cfset data.rateQuery = QueryNew("PackageID, GuaranteedDTD, BillableWeight, WeightUnit, ScheduledDelivTime, OptionCharges, OptionChargesCurrency, PackageOptionCharges, PackageOptionChargesCurrency, PackageTotalCharges, PackageChargesCurrency, ServiceLevel, TotalCharges, TotalChargesCurrency, OriginalWeight, NegotiatedCharges, NegotiatedChargesCurrency")>
				  <cfset data.aRateQuery = data.stUpsRate.RatingServiceSelectionResponse.RatedShipment>
				  <cfset qCount = 1>
				  <cfloop index="idxRates" from="1" to="#ArrayLen(data.aRateQuery.RatedPackage)#">
					<cfset newRow  = QueryAddRow(data.rateQuery, 1)>
					<cfset temp = QuerySetCell(data.rateQuery, "PackageID", "1")>
					<cfif StructKeyExists(data.aRateQuery.RatedPackage[idxRates], "GuaranteedDaysToDelivery")>
					  <cfset temp = QuerySetCell(data.rateQuery, "GuaranteedDTD", data.aRateQuery.RatedPackage[idxRates].GuaranteedDaysToDelivery.XMLText, qCount)>
					  <cfelse>
					  <cfset temp = QuerySetCell(data.rateQuery, "GuaranteedDTD", "")>
					</cfif>
					<cfif StructKeyExists(data.aRateQuery.RatedPackage[idxRates].BillingWeight, "Weight")>
					  <cfset temp = QuerySetCell(data.rateQuery, "BillableWeight", data.aRateQuery.RatedPackage[idxRates].BillingWeight.Weight.XMLText, qCount)>
					  <cfelse>
					  <cfset temp = QuerySetCell(data.rateQuery, "BillableWeight", "")>
					</cfif>
					<cfif StructKeyExists(data.aRateQuery.RatedPackage[idxRates].BillingWeight.UnitOfMeasurement, "Code")>
					  <cfset temp = QuerySetCell(data.rateQuery, "WeightUnit", data.aRateQuery.RatedPackage[idxRates].BillingWeight.UnitOfMeasurement.Code.XMLText, qCount)>
					  <cfelse>
					  <cfset temp = QuerySetCell(data.rateQuery, "WeightUnit", "")>
					</cfif>
					<cfif StructKeyExists(data.aRateQuery, "ScheduledDeliveryTime")>
					  <cfset temp = QuerySetCell(data.rateQuery, "ScheduledDelivTime", data.aRateQuery.ScheduledDeliveryTime.XMLText, qCount)>
					  <cfelse>
					  <cfset temp = QuerySetCell(data.rateQuery, "ScheduledDelivTime", "")>
					</cfif>
					<cfif StructKeyExists(data.aRateQuery.RatedPackage[idxRates].ServiceOptionsCharges, "MonetaryValue")>
					  <cfset temp = QuerySetCell(data.rateQuery, "PackageOptionCharges", data.aRateQuery.RatedPackage[idxRates].ServiceOptionsCharges.MonetaryValue.XMLText, qCount)>
					  <cfelse>
					  <cfset temp = QuerySetCell(data.rateQuery, "PackageOptionCharges", "")>
					</cfif>
					<cfif StructKeyExists(data.aRateQuery.RatedPackage[idxRates].ServiceOptionsCharges, "CurrencyCode")>
					  <cfset temp = QuerySetCell(data.rateQuery, "PackageOptionChargesCurrency", data.aRateQuery.RatedPackage[idxRates].ServiceOptionsCharges.CurrencyCode.XMLText, qCount)>
					  <cfelse>
					  <cfset temp = QuerySetCell(data.rateQuery, "PackageOptionChargesCurrency", "")>
					</cfif>
					<cfif StructKeyExists(data.aRateQuery.RatedPackage[idxRates].TotalCharges, "MonetaryValue")>
					  <cfset temp = QuerySetCell(data.rateQuery, "PackageTotalCharges", data.aRateQuery.RatedPackage[idxRates].TotalCharges.MonetaryValue.XMLText, qCount)>
					  <cfelse>
					  <cfset temp = QuerySetCell(data.rateQuery, "PackageTotalCharges", "")>
					</cfif>
					<cfif StructKeyExists(data.aRateQuery.RatedPackage[idxRates].TotalCharges, "CurrencyCode")>
					  <cfset temp = QuerySetCell(data.rateQuery, "PackageChargesCurrency", data.aRateQuery.RatedPackage[idxRates].TotalCharges.CurrencyCode.XMLText, qCount)>
					  <cfelse>
					  <cfset temp = QuerySetCell(data.rateQuery, "PackageChargesCurrency", "")>
					</cfif>
					<cfif StructKeyExists(data.aRateQuery.Service, "Code")>
					  <cfset temp = QuerySetCell(data.rateQuery, "ServiceLevel", data.aRateQuery.Service.Code.XMLText, qCount)>
					  <cfelse>
					  <cfset temp = QuerySetCell(data.rateQuery, "ServiceLevel", "")>
					</cfif>
					<cfif StructKeyExists(data.aRateQuery.ServiceOptionsCharges, "MonetaryValue")>
					  <cfset temp = QuerySetCell(data.rateQuery, "OptionCharges", data.aRateQuery.ServiceOptionsCharges.MonetaryValue.XMLText, qCount)>
					  <cfelse>
					  <cfset temp = QuerySetCell(data.rateQuery, "OptionCharges", "")>
					</cfif>
					<cfif StructKeyExists(data.aRateQuery.ServiceOptionsCharges, "CurrencyCode")>
					  <cfset temp = QuerySetCell(data.rateQuery, "OptionChargesCurrency", data.aRateQuery.ServiceOptionsCharges.CurrencyCode.XMLText, qCount)>
					  <cfelse>
					  <cfset temp = QuerySetCell(data.rateQuery, "OptionChargesCurrency", "")>
					</cfif>
					<cfif StructKeyExists(data.aRateQuery.TotalCharges, "MonetaryValue")>
					  <cfset temp = QuerySetCell(data.rateQuery, "TotalCharges", data.aRateQuery.TotalCharges.MonetaryValue.XMLText, qCount)>
					  <cfset temp = QuerySetCell(data.rateQuery, "NegotiatedCharges", data.aRateQuery.TotalCharges.MonetaryValue.XMLText, qCount)>
					<cfelse>
					  <cfset temp = QuerySetCell(data.rateQuery, "TotalCharges", "")>
					</cfif>
					<cfif StructKeyExists(data.aRateQuery.TotalCharges, "CurrencyCode")>
					  <cfset temp = QuerySetCell(data.rateQuery, "TotalChargesCurrency", data.aRateQuery.TotalCharges.CurrencyCode.XMLText, qCount)>
					  <cfset temp = QuerySetCell(data.rateQuery, "NegotiatedChargesCurrency", data.aRateQuery.TotalCharges.CurrencyCode.XMLText, qCount)>
					<cfelse>
					  <cfset temp = QuerySetCell(data.rateQuery, "TotalChargesCurrency", "")>
					</cfif>
					<cfif StructKeyExists(data.aRateQuery.RatedPackage[idxRates], "Weight")>
					  <cfset temp = QuerySetCell(data.rateQuery, "OriginalWeight", data.aRateQuery.RatedPackage[idxRates].Weight.XMLText, qCount)>
					  <cfelse>
					  <cfset temp = QuerySetCell(data.rateQuery, "OriginalWeight", "")>
					</cfif>
					<cfset aNegotiatedRates = xmlSearch(data.aRateQuery, "NegotiatedRates/NetSummaryCharges/GrandTotal")>
					  <cfif arrayLen(aNegotiatedRates) EQ 1>
							<cfset negotiatedRates_Amount = aNegotiatedRates[1].CurrencyCode.xmlText>
							<cfset negotiatedRates_CurrenycCode = aNegotiatedRates[1].CurrencyCode.xmlText>
							<cfset temp = QuerySetCell(data.rateQuery, "NegotiatedCharges", negotiatedRates_Amount, qCount)>
							<cfset temp = QuerySetCell(data.rateQuery, "NegotiatedChargesCurrency", negotiatedRates_CurrenycCode, qCount)>
					  </cfif>
					<cfset qCount = qCount + 1>
				  </cfloop>
				<cfelse>
				  <!--- rates returned for 1 package only --->
				  <cfset data.rateQuery = QueryNew("PackageID, GuaranteedDTD, BillableWeight, WeightUnit, ScheduledDelivTime, OptionCharges, OptionChargesCurrency, PackageTotalCharges, PackageChargesCurrency, ServiceLevel, TotalCharges, TotalChargesCurrency, OriginalWeight")>
				  <cfset data.sRateQuery = data.stUpsRate.RatingServiceSelectionResponse.RatedShipment>
				  <cfset newRow  = QueryAddRow(data.rateQuery, 1)>
				  <cfset temp = QuerySetCell(data.rateQuery, "PackageID", "1")>
				  <cfif StructKeyExists(data.sRateQuery, "GuaranteedDaysToDelivery")>
					<cfset temp = QuerySetCell(data.rateQuery, "GuaranteedDTD", data.sRateQuery.GuaranteedDaysToDelivery.XMLText, 1)>
					<cfelse>
					<cfset temp = QuerySetCell(data.rateQuery, "GuaranteedDTD", "")>
				  </cfif>
				  <cfif StructKeyExists(data.sRateQuery.RatedPackage.BillingWeight, "Weight")>
					<cfset temp = QuerySetCell(data.rateQuery, "BillableWeight", data.sRateQuery.RatedPackage.BillingWeight.Weight.XMLText, 1)>
					<cfelse>
					<cfset temp = QuerySetCell(data.rateQuery, "BillableWeight", "")>
				  </cfif>
				  <cfif StructKeyExists(data.sRateQuery.RatedPackage.BillingWeight.UnitOfMeasurement, "Code")>
					<cfset temp = QuerySetCell(data.rateQuery, "WeightUnit", data.sRateQuery.RatedPackage.BillingWeight.UnitOfMeasurement.Code.XMLText, 1)>
					<cfelse>
					<cfset temp = QuerySetCell(data.rateQuery, "WeightUnit", "")>
				  </cfif>
				  <cfif StructKeyExists(data.sRateQuery, "ScheduledDeliveryTime")>
					<cfset temp = QuerySetCell(data.rateQuery, "ScheduledDelivTime", data.sRateQuery.ScheduledDeliveryTime.XMLText, 1)>
					<cfelse>
					<cfset temp = QuerySetCell(data.rateQuery, "ScheduledDelivTime", "")>
				  </cfif>
				  <cfif StructKeyExists(data.sRateQuery.RatedPackage.ServiceOptionsCharges, "MonetaryValue")>
					<cfset temp = QuerySetCell(data.rateQuery, "OptionCharges", data.sRateQuery.ServiceOptionsCharges.MonetaryValue.XMLText, 1)>
					<cfelse>
					<cfset temp = QuerySetCell(data.rateQuery, "OptionCharges", "")>
				  </cfif>
				  <cfif StructKeyExists(data.sRateQuery.RatedPackage.ServiceOptionsCharges, "CurrencyCode")>
					<cfset temp = QuerySetCell(data.rateQuery, "OptionChargesCurrency", data.sRateQuery.ServiceOptionsCharges.CurrencyCode.XMLText, 1)>
					<cfelse>
					<cfset temp = QuerySetCell(data.rateQuery, "OptionChargesCurrency", "")>
				  </cfif>
				  <cfif StructKeyExists(data.sRateQuery.Service, "Code")>
					<cfset temp = QuerySetCell(data.rateQuery, "ServiceLevel", data.sRateQuery.Service.Code.XMLText, 1)>
					<cfelse>
					<cfset temp = QuerySetCell(data.rateQuery, "ServiceLevel", "")>
				  </cfif>
				  <cfif StructKeyExists(data.sRateQuery.RatedPackage.TotalCharges, "MonetaryValue")>
					<cfset temp = QuerySetCell(data.rateQuery, "PackageTotalCharges", data.sRateQuery.RatedPackage.TotalCharges.MonetaryValue.XMLText, qCount)>
					<cfelse>
					<cfset temp = QuerySetCell(data.rateQuery, "PackageTotalCharges", "")>
				  </cfif>
				  <cfif StructKeyExists(data.sRateQuery.RatedPackage.TotalCharges, "CurrencyCode")>
					<cfset temp = QuerySetCell(data.rateQuery, "PackageChargesCurrency", data.sRateQuery.RatedPackage.TotalCharges.CurrencyCode.XMLText, qCount)>
					<cfelse>
					<cfset temp = QuerySetCell(data.rateQuery, "PackageChargesCurrency", "")>
				  </cfif>
				  <cfif StructKeyExists(data.sRateQuery.TotalCharges, "MonetaryValue")>
					<cfset temp = QuerySetCell(data.rateQuery, "TotalCharges", data.sRateQuery.TotalCharges.MonetaryValue.XMLText, 1)>
					<cfset temp = QuerySetCell(data.rateQuery, "NegotiatedCharges", data.sRateQuery.TotalCharges.MonetaryValue.XMLText, 1)>
					<cfelse>
					<cfset temp = QuerySetCell(data.rateQuery, "TotalCharges", "")>
				  </cfif>
				  <cfif StructKeyExists(data.sRateQuery.TotalCharges, "CurrencyCode")>
					<cfset temp = QuerySetCell(data.rateQuery, "TotalChargesCurrency", data.sRateQuery.TotalCharges.CurrencyCode.XMLText, 1)>
					<cfset temp = QuerySetCell(data.rateQuery, "NegotiatedChargesCurrency", data.sRateQuery.TotalCharges.CurrencyCode.XMLText, 1)>
				  <cfelse>
					<cfset temp = QuerySetCell(data.rateQuery, "TotalChargesCurrency", "")>
				  </cfif>
				  <cfif StructKeyExists(data.sRateQuery.RatedPackage, "Weight")>
					<cfset temp = QuerySetCell(data.rateQuery, "OriginalWeight", data.sRateQuery.RatedPackage.Weight.XMLText, 1)>
					<cfelse>
					<cfset temp = QuerySetCell(data.rateQuery, "OriginalWeight", "")>
				  </cfif>
				  <cfset aNegotiatedRates = xmlSearch(data.sRateQuery, "NegotiatedRates/NetSummaryCharges/GrandTotal")>
					  <cfif arrayLen(aNegotiatedRates) EQ 1>
							<cfset negotiatedRates_Amount = aNegotiatedRates[1].CurrencyCode.xmlText>
							<cfset negotiatedRates_CurrenycCode = aNegotiatedRates[1].CurrencyCode.xmlText>
							<cfset temp = QuerySetCell(data.rateQuery, "NegotiatedCharges", negotiatedRates_Amount, 1)>
							<cfset temp = QuerySetCell(data.rateQuery, "NegotiatedChargesCurrency", negotiatedRates_CurrenycCode, 1)>
					  </cfif>
				</cfif>
				<!--- Transaction Failure --->
				<cfelseif isDefined("data.stUpsRate.RatingServiceSelectionResponse.Response.RESPONSESTATUSCODE.XmlText") AND 
			
					#data.stUpsRate.RatingServiceSelectionResponse.Response.RESPONSESTATUSCODE.XmlText# EQ 0>
				<!--- Failure --->
				<cfset data.UPSRateError = 1>
				<cfset data.UPSResponseDesc = data.stUpsRate.RatingServiceSelectionResponse.Response.RESPONSESTATUSDESCRIPTION.XmlText>
				<cfif IsDefined("data.stUpsRate.RatingServiceSelectionResponse.Response.Error.ErrorCode.XmlText")>
				  <cfset data.UPSErrorCode = data.stUpsRate.RatingServiceSelectionResponse.Response.Error.ErrorCode.XmlText>
				</cfif>
				<cfif IsDefined("data.stUpsRate.RatingServiceSelectionResponse.Response.Error.ErrorDescription.XmlText")>
				  <cfset data.UPSErrorDescription = data.stUpsRate.RatingServiceSelectionResponse.Response.Error.ErrorDescription.XmlText>
				</cfif>
				<cfelse>
				<cfset data.UPSRateError = 2>
				<!--- Error Retrieving rates or communication failure to UPS --->
			  </cfif>
			  
			<cfelse>
				<cfset data.UPSRateError = 2>
				<!--- Error Retrieving rates or communication failure to UPS --->
			</cfif>
			<cfcatch type="any">
			 <cfset data.UPSRateError = 2>
			</cfcatch>
		   </cftry>
		  </cfcase>
		  <!--- UPS Rate for specific Service --->
		  <!--- UPS Time In Transit --->
		  <cfcase value="TntRequest">
		  <cftry>
		  <cfscript>
		
			todaysDate = Now();
			currentDay = DatePart( "d", todaysDate);
			currentDayNum = DayOfWeek(todaysDate);
		
			if (currentDayNum EQ 1) {
				//Sunday
				todaysDate = todaysDate + 1;
			} else if (currentDayNum EQ 7) {
				//Saturday
				todaysDate = todaysDate + 2;
			}
				pickupDateYear = DatePart("yyyy",todaysDate);
				pickupDateMonth = DatePart("m",todaysDate);
				if ( Len(pickupDateMonth) EQ 1 )
					pickupDateMonth = "0"&#pickupDateMonth#;
				pickupDateDay = DatePart("d",todaysDate);
				if ( Len(pickupDateDay) EQ 1 ) {
					pickupDateDay = "0"&#pickupDateDay#;
				}
				arguments.pickupDate = #pickupDateYear#&#pickupDateMonth#&#pickupDateDay#;
		
			arguments.TNTAccess = '<?xml version="#arguments.XMLVersion#"?>
			<AccessRequest xml:lang="en-US">
			<AccessLicenseNumber>#arguments.UPSAccessKey#</AccessLicenseNumber>
			<UserId>#arguments.UPSUserID#</UserId>
			<Password>#arguments.UPSPassword#</Password>
			</AccessRequest>';
		
			arguments.TNTRequest = '<?xml version="#arguments.XMLVersion#"?>
			<TimeInTransitRequest xml:lang="en-US">
				<Request>
				<TransactionReference>
					<CustomerContext>Time In Transit Customer Request</CustomerContext>
					<XpciVersion>#arguments.XPCIVersion#</XpciVersion>
				</TransactionReference>
				<RequestAction>TimeInTransit</RequestAction>
				</Request>
				<TransitFrom>
				<AddressArtifactFormat>
					<CountryCode>#arguments.ShipperCountry#</CountryCode>
					<PoliticalDivision1>#arguments.ShipperState#</PoliticalDivision1>
					<PoliticalDivision2>#arguments.ShipperCity#</PoliticalDivision2>
					<PostcodePrimaryLow>#arguments.ShipperZip#</PostcodePrimaryLow>
				</AddressArtifactFormat>
				</TransitFrom>
				<TransitTo>
				<AddressArtifactFormat>
					<CountryCode>#arguments.ShipToCountry#</CountryCode>
					<PoliticalDivision1>#arguments.ShipToState#</PoliticalDivision1>
					<PoliticalDivision2>#arguments.ShipToCity#</PoliticalDivision2>
					<PostcodePrimaryLow>#arguments.ShipToZip#</PostcodePrimaryLow>
					<ResidentialAddressIndicator>#arguments.ResidentialAddress#</ResidentialAddressIndicator>
				</AddressArtifactFormat>
				</TransitTo>
				<ShipmentWeight>
				<UnitOfMeasurement>
					<Code>#arguments.PackageWeightUnit#</Code>
				</UnitOfMeasurement>
					<Weight>#arguments.PackageWeight#</Weight>
				</ShipmentWeight>
				<InvoiceLineTotal>
					<CurrencyCode>#arguments.CurrencyCode#</CurrencyCode>
					<MonetaryValue>#NumberFormat(arguments.InsuredValue, "999.99")#</MonetaryValue>
				</InvoiceLineTotal>
				<PickupDate>#arguments.pickupDate#</PickupDate>
				<DocumentsOnlyIndicator/>
			</TimeInTransitRequest>';
		
		
			arguments.XMLRequestInput = '#arguments.TNTAccess#
			#arguments.TNTRequest#';
		
			</cfscript>
		  <cfhttp method="post" url="#arguments.tntServer#" resolveurl="yes" port="443" timeout="#arguments.TimeOut#">
			<cfhttpparam name="XML" type="xml" value="#arguments.XMLRequestInput#">
		  </cfhttp>
		  <cfset data.stUpsTNT = XmlParse(cfhttp.FileContent)>
		  <cfif IsDefined("arguments.Debug") AND arguments.Debug EQ "TRUE">
			<cffile action="WRITE" file="#arguments.ServerFilePath##trailingSlash#Debug#trailingSlash#TNTAccess.xml" output="#arguments.TNTAccess#" addnewline="No" nameconflict="overwrite">
			<cffile action="WRITE" file="#arguments.ServerFilePath##trailingSlash#Debug#trailingSlash#TNTRequest.xml" output="#arguments.TNTRequest#" addnewline="No" nameconflict="overwrite">
			<cfoutput>
			  <cfdump var="#data.stUpsTNT#">
			  <a href="Debug#trailingSlash#TNTAccess.xml" target="_blank">View XML Access File</a> <a href="Debug#trailingSlash#TNTRequest.xml" target="_blank">View XML Request File</a> </cfoutput>
			<cfabort>
		  </cfif>
		  <cfif IsDefined("data.stUpsTNT.TimeInTransitResponse.Response.RESPONSESTATUSCODE.XmlText") AND #data.stUpsTNT.TimeInTransitResponse.Response.RESPONSESTATUSCODE.XmlText# EQ 1>
			<!--- If multiple cities match supplied zip for origin or destination
		
			structure is returned with potential Address Artifact array --->
			<cfif IsDefined("data.stUpsTNT.TimeInTransitResponse.TransitFromList.Candidate") AND #IsArray(data.stUpsTNT.TimeInTransitResponse.TransitFromList.Candidate.XmlChildren)#>
			  <!--- Candidate from addresses returned --->
			  <cfset data.AddressFromCandidateQuery = QueryNew("CandidateCity, CandidateTown, CandidateState, CandidateZipLow, CandidateZipHigh")>
			  <cfset data.aAddressFromCandidateQuery = data.stUpsTNT.TimeInTransitResponse.TransitFromList.Candidate>
			  <cfloop index="idx" from="1" to="#ArrayLen(data.aAddressFromCandidateQuery)#">
				<cfset newRow  = QueryAddRow(data.AddressFromCandidateQuery, 1)>
				<cfif StructKeyExists(data.aAddressFromCandidateQuery[idx].AddressArtifactFormat, "PoliticalDivision2")>
				  <cfset temp = QuerySetCell(data.AddressFromCandidateQuery, "CandidateCity", data.aAddressFromCandidateQuery[idx].AddressArtifactFormat.PoliticalDivision2.XmlText, idx)>
				  <cfelse>
				  <cfset temp = QuerySetCell(data.AddressFromCandidateQuery, "CandidateCity", "")>
				</cfif>
				<cfif StructKeyExists(data.aAddressFromCandidateQuery[idx].AddressArtifactFormat, "PoliticalDivision3")>
				  <cfset temp = QuerySetCell(data.AddressFromCandidateQuery, "CandidateTown", data.aAddressFromCandidateQuery[idx].AddressArtifactFormat.PoliticalDivision3.XmlText, idx)>
				  <cfelse>
				  <cfset temp = QuerySetCell(data.AddressFromCandidateQuery, "CandidateTown", "")>
				</cfif>
				<cfif StructKeyExists(data.aAddressFromCandidateQuery[idx].AddressArtifactFormat, "PoliticalDivision1")>
				  <cfset temp = QuerySetCell(data.AddressFromCandidateQuery, "CandidateState", data.aAddressFromCandidateQuery[idx].AddressArtifactFormat.PoliticalDivision1.XmlText, idx)>
				  <cfelse>
				  <cfset temp = QuerySetCell(data.AddressFromCandidateQuery, "CandidateState", "")>
				</cfif>
				<cfif StructKeyExists(data.aAddressFromCandidateQuery[idx].AddressArtifactFormat, "PostcodePrimaryLow")>
				  <cfset temp = QuerySetCell(data.AddressFromCandidateQuery, "CandidateZipLow", data.aAddressFromCandidateQuery[idx].AddressArtifactFormat.PostcodePrimaryLow.XmlText, idx)>
				  <cfelse>
				  <cfset temp = QuerySetCell(data.AddressFromCandidateQuery, "CandidateZipLow", "")>
				</cfif>
				<cfif StructKeyExists(data.aAddressFromCandidateQuery[idx].AddressArtifactFormat, "PostcodePrimaryHigh")>
				  <cfset temp = QuerySetCell(data.AddressFromCandidateQuery, "CandidateZipHigh", data.aAddressFromCandidateQuery[idx].AddressArtifactFormat.PostcodePrimaryHigh.XmlText, idx)>
				  <cfelse>
				  <cfset temp = QuerySetCell(data.AddressFromCandidateQuery, "CandidateZipHigh", "")>
				</cfif>
			  </cfloop>
			</cfif>
			<cfif IsDefined("data.stUpsTNT.TimeInTransitResponse.TransitToList.Candidate") AND #IsArray(data.stUpsTNT.TimeInTransitResponse.TransitToList.Candidate.XmlChildren)#>
			  <!--- Candidate to addresses returned --->
			  <cfset data.AddressToCandidateQuery = QueryNew("CandidateCity, CandidateTown, CandidateState, CandidateZipLow, CandidateZipHigh")>
			  <cfset data.aAddressToCandidateQuery = data.stUpsTNT.TimeInTransitResponse.TransitToList.Candidate>
			  <cfloop index="idx" from="1" to="#ArrayLen(data.aAddressToCandidateQuery)#">
				<cfset newRow  = QueryAddRow(data.AddressToCandidateQuery, 1)>
				<cfif StructKeyExists(data.aAddressToCandidateQuery[idx].AddressArtifactFormat, "PoliticalDivision2")>
				  <cfset temp = QuerySetCell(data.AddressToCandidateQuery, "CandidateCity", data.aAddressToCandidateQuery[idx].AddressArtifactFormat.PoliticalDivision2.XmlText, idx)>
				  <cfelse>
				  <cfset temp = QuerySetCell(data.AddressToCandidateQuery, "CandidateCity", "")>
				</cfif>
				<cfif StructKeyExists(data.aAddressToCandidateQuery[idx].AddressArtifactFormat, "PoliticalDivision3")>
				  <cfset temp = QuerySetCell(data.AddressToCandidateQuery, "CandidateTown", data.aAddressToCandidateQuery[idx].AddressArtifactFormat.PoliticalDivision3.XmlText, idx)>
				  <cfelse>
				  <cfset temp = QuerySetCell(data.AddressToCandidateQuery, "CandidateTown", "")>
				</cfif>
				<cfif StructKeyExists(data.aAddressToCandidateQuery[idx].AddressArtifactFormat, "PoliticalDivision1")>
				  <cfset temp = QuerySetCell(data.AddressToCandidateQuery, "CandidateState", data.aAddressToCandidateQuery[idx].AddressArtifactFormat.PoliticalDivision1.XmlText, idx)>
				  <cfelse>
				  <cfset temp = QuerySetCell(data.AddressToCandidateQuery, "CandidateState", "")>
				</cfif>
				<cfif StructKeyExists(data.aAddressToCandidateQuery[idx].AddressArtifactFormat, "PostcodePrimaryLow")>
				  <cfset temp = QuerySetCell(data.AddressToCandidateQuery, "CandidateZipLow", data.aAddressToCandidateQuery[idx].AddressArtifactFormat.PostcodePrimaryLow.XmlText, idx)>
				  <cfelse>
				  <cfset temp = QuerySetCell(data.AddressToCandidateQuery, "CandidateZipLow", "")>
				</cfif>
				<cfif StructKeyExists(data.aAddressToCandidateQuery[idx].AddressArtifactFormat, "PostcodePrimaryHigh")>
				  <cfset temp = QuerySetCell(data.AddressToCandidateQuery, "CandidateZipHigh", data.aAddressToCandidateQuery[idx].AddressArtifactFormat.PostcodePrimaryHigh.XmlText, idx)>
				  <cfelse>
				  <cfset temp = QuerySetCell(data.AddressToCandidateQuery, "CandidateZipHigh", "")>
				</cfif>
			  </cfloop>
			</cfif>
			<cfif IsDefined("data.stUpsTNT.TIMEINTRANSITRESPONSE.TRANSITRESPONSE.SERVICESUMMARY") AND #IsArray(data.stUpsTNT.TimeInTransitResponse.TransitResponse.ServiceSummary.XmlChildren)#>
			  <cfif IsDefined("data.stUpsTNT.TIMEINTRANSITRESPONSE.TransitResponse.DISCLAIMER.XmlText")>
				<cfset data.UPSDisclaimer = data.stUpsTNT.TIMEINTRANSITRESPONSE.TransitResponse.DISCLAIMER.XmlText>
			  </cfif>
			  <!--- Loop through the transit time results --->
			  <cfset data.TntQuery = QueryNew("BusinessDays, EstDelivDate, EstDelivDay, EstDelivTime, CorrectedPickupDate, ServiceGuaranteed, ServiceCode, ServiceDesc")>
			  <cfset data.aTntQuery = data.stUpsTNT.TimeInTransitResponse.TransitResponse.ServiceSummary>
			  <cfloop index="idx" from="1" to="#ArrayLen(data.aTntQuery)#">
				<cfset newRow  = QueryAddRow(data.TntQuery, 1)>
				<cfif StructKeyExists(data.aTntQuery[idx].EstimatedArrival, "BusinessTransitDays")>
				  <cfset temp = QuerySetCell(data.TntQuery, "BusinessDays", data.aTntQuery[idx].EstimatedArrival.BusinessTransitDays.XmlText, idx)>
				  <cfelse>
				  <cfset temp = QuerySetCell(data.TntQuery, "BusinessDays", "")>
				</cfif>
				<cfif StructKeyExists(data.aTntQuery[idx].EstimatedArrival, "Date")>
				  <cfset temp = QuerySetCell(data.TntQuery, "EstDelivDate", data.aTntQuery[idx].EstimatedArrival.Date.XmlText, idx)>
				  <cfelse>
				  <cfset temp = QuerySetCell(data.TntQuery, "EstDelivDate", "")>
				</cfif>
				<cfif StructKeyExists(data.aTntQuery[idx].EstimatedArrival, "DayOfWeek")>
				  <cfset temp = QuerySetCell(data.TntQuery, "EstDelivDay", data.aTntQuery[idx].EstimatedArrival.DayOfWeek.XmlText, idx)>
				  <cfelse>
				  <cfset temp = QuerySetCell(data.TntQuery, "EstDelivDay", "")>
				</cfif>
				<cfif StructKeyExists(data.aTntQuery[idx].EstimatedArrival, "Time")>
				  <cfset temp = QuerySetCell(data.TntQuery, "EstDelivTime", data.aTntQuery[idx].EstimatedArrival.Time.XmlText, idx)>
				  <cfelse>
				  <cfset temp = QuerySetCell(data.TntQuery, "EstDelivTime", "")>
				</cfif>
				<cfif StructKeyExists(data.aTntQuery[idx].EstimatedArrival, "PICKUPDATE")>
				  <cfset temp = QuerySetCell(data.TntQuery, "CorrectedPickupDate", data.aTntQuery[idx].EstimatedArrival.PICKUPDATE.XmlText, idx)>
				  <cfelse>
				  <cfset temp = QuerySetCell(data.TntQuery, "CorrectedPickupDate", "")>
				</cfif>
				<cfif StructKeyExists(data.aTntQuery[idx].Guaranteed, "Code")>
				  <cfset temp = QuerySetCell(data.TntQuery, "ServiceGuaranteed", data.aTntQuery[idx].Guaranteed.Code.XmlText, idx)>
				  <cfelse>
				  <cfset temp = QuerySetCell(data.TntQuery, "ServiceGuaranteed", "")>
				</cfif>
				<cfif StructKeyExists(data.aTntQuery[idx].Service, "Code")>
				  <cfset temp = QuerySetCell(data.TntQuery, "ServiceCode", data.aTntQuery[idx].Service.Code.XmlText, idx)>
				  <cfelse>
				  <cfset temp = QuerySetCell(data.TntQuery, "ServiceCode", "")>
				</cfif>
				<cfif StructKeyExists(data.aTntQuery[idx].Service, "Description")>
				  <cfset temp = QuerySetCell(data.TntQuery, "ServiceDesc", data.aTntQuery[idx].Service.Description.XmlText, idx)>
				  <cfelse>
				  <cfset temp = QuerySetCell(data.TntQuery, "ServiceDesc", "")>
				</cfif>
			  </cfloop>
			  <cfelse>
			  <!--- Structure returned is invalid --->
			  <cfset data.UPSTNTError = 3>
			</cfif>
			<cfelseif IsDefined("data.stUpsTNT.TimeInTransitResponse.Response.RESPONSESTATUSCODE.XmlText") AND
		
				data.stUpsTNT.TimeInTransitResponse.Response.RESPONSESTATUSCODE.XmlText EQ 0>
			<cfset UPSTNTError = 1>
			<!--- Response fine, transaction failed however --->
			<cfif IsDefined("data.stUpsTNT.TimeInTransitResponse.Response.Error.ErrorCode.XmlText")>
			  <cfset data.UPSErrorCode = data.stUpsTNT.TimeInTransitResponse.Response.Error.ErrorCode.XmlText>
			</cfif>
			<cfif IsDefined("data.stUpsTNT.TimeInTransitResponse.Response.Error.ErrorDescription.XmlText")>
			  <cfset data.UPSErrorDescription = data.stUpsTNT.TimeInTransitResponse.Response.Error.ErrorDescription.XmlText>
			</cfif>
			<cfelse>
			<cfset data.UPSTNTError = 2>
		  </cfif>
			<cfcatch type="any">
			 <cfset data.UPSTNTError = 2>
			</cfcatch>
		   </cftry>
		  </cfcase>
		  <!--- END UPS Time In Transit --->
		  
		  <!--- UPS Address Validation Open --->
		  <cfcase value="AVRequest">
		  <cftry>
		  <cfscript>
			AVAccess = '<?xml version="#arguments.XMLVersion#"?>
				<AccessRequest xml:lang="en-US">
				<AccessLicenseNumber>#arguments.UPSAccessKey#</AccessLicenseNumber>
				<UserId>#arguments.UPSUserID#</UserId>
				<Password>#arguments.UPSPassword#</Password>
			</AccessRequest>';
			
			AVRequest = '<?xml version="#arguments.XMLVersion#"?>
			<AddressValidationRequest xml:lang="en-US">
				<Request>
					<TransactionReference>
						<CustomerContext>APT Address Validation Request</CustomerContext>
						<XpciVersion>#arguments.XPCIVersionAV#</XpciVersion>
					</TransactionReference>
					<RequestAction>AV</RequestAction>
				</Request>
				<Address>
					<City>#arguments.ShipToCity#</City>
					<StateProvinceCode>#arguments.ShipToState#</StateProvinceCode>
					<PostalCode>#arguments.ShipToZip#</PostalCode>
				</Address>
			</AddressValidationRequest>';
				
			arguments.XMLRequestInput = '#AVAccess#
				#AVRequest#';
			</cfscript>
		
		  <cfhttp method="post" url="#arguments.AVServer#" resolveurl="yes" port="443" timeout="#arguments.TimeOut#">
			<cfhttpparam name="XML" type="xml" value="#arguments.XMLRequestInput#">
		  </cfhttp>
		  
		  <cfif IsDefined("cfhttp.FileContent") AND Len(Trim(cfhttp.FileContent)) GT 10>
		  
			  <cfset data.stUpsAV = XmlParse(Trim(cfhttp.FileContent))>
			  
			  <cfif IsDefined("arguments.Debug") AND arguments.Debug EQ "TRUE">
				<cffile action="WRITE" file="#arguments.ServerFilePath##trailingSlash#Debug#trailingSlash#AVAccess.xml" output="#AVAccess#" addnewline="No" nameconflict="overwrite">
				<cffile action="WRITE" file="#arguments.ServerFilePath##trailingSlash#Debug#trailingSlash#AVRequest.xml" output="#AVRequest#" addnewline="No" nameconflict="overwrite">
				<cfoutput>
				  <cfdump var="#data.stUpsAV#">
				  <a href="Debug#trailingSlash#AVAccess.xml" target="_blank">View XML Access File</a> <a href="Debug#trailingSlash#AVRequest.xml" target="_blank">View XML Request File</a> </cfoutput>
				<cfabort>
			  </cfif>
			  
			  <cfif IsDefined("data.stUpsAV.AddressValidationResponse.Response.RESPONSESTATUSCODE.XmlText") AND #data.stUpsAV.AddressValidationResponse.Response.RESPONSESTATUSCODE.XmlText# EQ 1>
				<!--- ///// If multiple AddressValidationResult structures are returned then array and city, state zip are not an exact match ///// --->
				<cfif IsDefined("data.stUpsAV.AddressValidationResponse.AddressValidationResult") AND #IsArray(data.stUpsAV.AddressValidationResponse.AddressValidationResult.XmlChildren)#>
				  <!--- Candidate to address array returned --->
				  <cfset data.qCandidateQuery = QueryNew("Rank, Quality, CandidateCity, CandidateState, CandidateZipLow, CandidateZipHigh")>
				  <cfset data.aQCandidateQuery = data.stUpsAV.AddressValidationResponse.AddressValidationResult>
				  <cfloop index="idx" from="1" to="#ArrayLen(data.aQCandidateQuery)#">
					<cfset newRow  = QueryAddRow(data.qCandidateQuery, 1)>
					<cfif StructKeyExists(data.aQCandidateQuery[idx], "Rank")>
					  <cfset temp = QuerySetCell(data.qCandidateQuery, "Rank", data.aQCandidateQuery[idx].Rank.XmlText, idx)>
					  <cfelse>
					  <cfset temp = QuerySetCell(data.qCandidateQuery, "Rank", "")>
					</cfif>
					<cfif StructKeyExists(data.aQCandidateQuery[idx], "Quality")>
					  <cfset temp = QuerySetCell(data.qCandidateQuery, "Quality", data.aQCandidateQuery[idx].Quality.XmlText, idx)>
					  <cfelse>
					  <cfset temp = QuerySetCell(data.qCandidateQuery, "Quality", "")>
					</cfif>
					<cfif StructKeyExists(data.aQCandidateQuery[idx], "Address")>
					  <cfif StructKeyExists(data.aQCandidateQuery[idx].Address, "City")>
						  <cfset temp = QuerySetCell(data.qCandidateQuery, "CandidateCity", data.aQCandidateQuery[idx].Address.City.XmlText, idx)>
					  <cfelse>
						  <cfset temp = QuerySetCell(data.qCandidateQuery, "CandidateCity", "")>
					  </cfif>
					  <cfif StructKeyExists(data.aQCandidateQuery[idx].Address, "StateProvinceCode")>
						  <cfset temp = QuerySetCell(data.qCandidateQuery, "CandidateState", data.aQCandidateQuery[idx].Address.StateProvinceCode.XmlText, idx)>
					  <cfelse>
						  <cfset temp = QuerySetCell(data.qCandidateQuery, "CandidateState", "")>
					  </cfif>
					</cfif>
					<cfif StructKeyExists(data.aQCandidateQuery[idx], "PostalCodeLowEnd")>
					  <cfset temp = QuerySetCell(data.qCandidateQuery, "CandidateZipLow", data.aQCandidateQuery[idx].PostalCodeLowEnd.XmlText, idx)>
					  <cfelse>
					  <cfset temp = QuerySetCell(data.qCandidateQuery, "CandidateZipLow", "")>
					</cfif>
					<cfif StructKeyExists(data.aQCandidateQuery[idx], "PostalCodeHighEnd")>
					  <cfset temp = QuerySetCell(data.qCandidateQuery, "CandidateZipHigh", data.aQCandidateQuery[idx].PostalCodeHighEnd.XmlText, idx)>
					  <cfelse>
					  <cfset temp = QuerySetCell(data.qCandidateQuery, "CandidateZipHigh", "")>
					</cfif>
				  </cfloop>
				
				<cfelseif IsDefined("data.stUpsAV.AddressValidationResponse.AddressValidationResult")>
					<!--- // Single element AddressValidationResult - ADDRESS IS VALID // --->
				<cfelse>
					<!--- // Hard Error no valid AddressValidationResult element found // --->
					<cfset data.UPSAVError = 2>
				</cfif>
				
			   <cfelseif IsDefined("data.stUpsAV.AddressValidationResponse.Response.RESPONSESTATUSCODE.XmlText") AND data.stUpsAV.AddressValidationResponse.Response.RESPONSESTATUSCODE.XmlText EQ 0>
				<cfset data.UPSAVError = 1>
				<!--- Response fine, transaction failed however --->
				<cfif IsDefined("data.stUpsAV.AddressValidationResponse.Response.Error.ErrorCode.XmlText")>
				  <cfset data.UPSErrorCode = data.stUpsAV.AddressValidationResponse.Response.Error.ErrorCode.XmlText>
				</cfif>
				<cfif IsDefined("data.stUpsAV.AddressValidationResponse.Response.Error.ErrorDescription.XmlText")>
				  <cfset data.UPSErrorDescription = data.stUpsAV.AddressValidationResponse.Response.Error.ErrorDescription.XmlText>
				</cfif>
			  
			  <cfelse>
				<!--- // Hard Error no valid response element found // --->
				<cfset data.UPSAVError = 2>
			  </cfif>
			  
			 <cfelse>
				<cfset data.UPSAVError = 2>
				<!--- ///////// no valid response received back from ups ///////// --->
			</cfif>
			<cfcatch type="any">
			 <cfset data.UPSAVError = 2>
			</cfcatch>
		   </cftry>
		  </cfcase>
		  <!--- END UPS Address Validation --->
		
		  <!--- UPS UPS Track Request --->
		  <cfcase value="trackRequest">
		  <cftry>
		  <cfscript>	
		
			arguments.TrackAccess = '<?xml version="#arguments.XMLVersion#"?>
		
			<AccessRequest xml:lang="en-US">
			<AccessLicenseNumber>#arguments.UPSAccessKey#</AccessLicenseNumber>
				<UserId>#arguments.UPSUserID#</UserId>
				<Password>#arguments.UPSPassword#</Password>
			</AccessRequest>';
		
			arguments.TrackRequest = '<?xml version="#arguments.XMLVersion#"?>
			<TrackRequest xml:lang="en-US">
				<Request>
					<TransactionReference>
						<CustomerContext>Tracking Activity Request</CustomerContext>
						<XpciVersion>#arguments.XPCIVersion#</XpciVersion>
					</TransactionReference>
					<RequestAction>Track</RequestAction>
					<RequestOption>activity</RequestOption>
				</Request>
					<TrackingNumber>#arguments.TrackingNumber#</TrackingNumber>
			</TrackRequest>';
			arguments.XMLRequestInput = '#arguments.TrackAccess#
			#arguments.TrackRequest#';
			</cfscript>
			
		  <cf_adminpro_shipbrxml function="trackAvailabilityRequest">
		  <cfif TrackAvail EQ 1>
			<cfhttp method="post" url="#arguments.trackServer#" resolveurl="yes" port="443" timeout="#arguments.TimeOut#">
			  <cfhttpparam name="XML" type="xml" value="#arguments.XMLRequestInput#">
			</cfhttp>
			
			  <cfif IsDefined("cfhttp.FileContent") AND Len(cfhttp.FileContent) GT 0> <!--- If [1] Check for valid response --->
				<cfset data.stUpsTrack = XmlParse(Trim(cfhttp.FileContent))>
				
				<cfif IsDefined("arguments.Debug") AND arguments.Debug EQ "TRUE"> <!--- If [2] Check if debug request or No --->
				  <cffile action="WRITE" file="#arguments.ServerFilePath##trailingSlash#Debug#trailingSlash#TrackAccess.xml" output="#arguments.TrackAccess#" addnewline="No" nameconflict="overwrite">
				  <cffile action="WRITE" file="#arguments.ServerFilePath##trailingSlash#Debug#trailingSlash#TrackRequest.xml" output="#arguments.TrackRequest#" addnewline="No" nameconflict="overwrite">
				  <cfoutput>
					<cfdump var="#data.stUpsTrack#">
					<a href="Debug#trailingSlash#TrackAccess.xml" target="_blank">View XML Access File</a> <a href="Debug#trailingSlash#TrackRequest.xml" target="_blank">View XML Request File</a> </cfoutput>
				  <cfabort>
				
				<cfelse> <!--- If [2] Check if debug request or No //Not a Debug Request code below --->
				  
				  <!--- <cfoutput><cfdump var="#data.stUpsTrack#"></cfoutput> --->
				  <!-- ////////////////////// Check for Track Response element (root node) ////////////////////// -->
				  <cfif StructKeyExists(data.stUpsTrack, "TrackResponse")> <!--- If [3] Check for Track Response element (root node) --->
					  
					  <!-- /////// Check for Response element, should be present under TrackResponse element /////// -->
					  <cfif StructKeyExists(data.stUpsTrack.TrackResponse, "Response")> <!--- If [4] Check for Response element, should be present under TrackResponse element --->
					  
						  <!-- ////////////////////// Check for error code ////////////////////// -->
						  <cfif IsDefined("data.stUpsTrack.TrackResponse.Response.ResponseStatusCode.XmlText") AND data.stUpsTrack.TrackResponse.Response.ResponseStatusCode.XmlText EQ 1> <!--- If [5] Check for Error element --->
							
								<cfset data.SystemErrorCode = 0>
								<!-- ////////////////////// Check Shipment element exists before proceeding ////////////////////// -->
								<cfif StructKeyExists(data.stUpsTrack.TrackResponse, "Shipment")>
								  <!-- ============= Create Master Package details query ==================================== -->
								  <cfset data.qPackageTrackDetails = QueryNew("ServiceCode, ServiceDesc, ShipperAddress1,
											ShipperAddress2, ShipperAddress3, ShipperCity, ShipperState, ShipperZip, ShipperCountry, ShipperNumber, ShipToAddress1, ShipToAddress2, ShipToAddress3, ShipToCity, ShipToState, ShipToZip, ShipToCountry,
											EstimatedDelivDate, EstimatedDelivTime, PickupDate, Weight, WeightUnit, TrackingNumber")>
								  <cfset newRow  = QueryAddRow(data.qPackageTrackDetails, 1)>
								  <cfif StructKeyExists(data.stUpsTrack.TrackResponse.Shipment, "Service")>
									<cfif IsDefined("data.stUpsTrack.TrackResponse.Shipment.Service.Code.XmlText")>
									  <cfset temp = QuerySetCell(data.qPackageTrackDetails, "ServiceCode", data.stUpsTrack.TrackResponse.Shipment.Service.Code.XmlText)>
									</cfif>
									<cfif IsDefined("data.stUpsTrack.TrackResponse.Shipment.Service.Description.XmlText")>
									  <cfset temp = QuerySetCell(data.qPackageTrackDetails, "ServiceDesc", data.stUpsTrack.TrackResponse.Shipment.Service.Description.XmlText)>
									</cfif>
								  </cfif>
								  <cfif StructKeyExists(data.stUpsTrack.TrackResponse.Shipment, "Shipper")>
									<cfif StructKeyExists(data.stUpsTrack.TrackResponse.Shipment.Shipper, "Address")>
									  <cfif IsDefined("data.stUpsTrack.TrackResponse.Shipment.Shipper.Address.AddressLine1.XmlText")>
										<cfset temp = QuerySetCell(data.qPackageTrackDetails, "ShipperAddress1", data.stUpsTrack.TrackResponse.Shipment.Shipper.Address.AddressLine1.XmlText)>
									  </cfif>
									  <cfif IsDefined("data.stUpsTrack.TrackResponse.Shipment.Shipper.Address.AddressLine2.XmlText")>
										<cfset temp = QuerySetCell(data.qPackageTrackDetails, "ShipperAddress2", data.stUpsTrack.TrackResponse.Shipment.Shipper.Address.AddressLine2.XmlText)>
									  </cfif>
									  <cfif IsDefined("data.stUpsTrack.TrackResponse.Shipment.Shipper.Address.AddressLine3.XmlText")>
										<cfset temp = QuerySetCell(data.qPackageTrackDetails, "ShipperAddress3", data.stUpsTrack.TrackResponse.Shipment.Shipper.Address.AddressLine3.XmlText)>
									  </cfif>
									  <cfif IsDefined("data.stUpsTrack.TrackResponse.Shipment.Shipper.Address.City.XmlText")>
										<cfset temp = QuerySetCell(data.qPackageTrackDetails, "ShipperCity", data.stUpsTrack.TrackResponse.Shipment.Shipper.Address.City.XmlText)>
									  </cfif>
									  <cfif IsDefined("data.stUpsTrack.TrackResponse.Shipment.Shipper.Address.StateProvinceCode.XmlText")>
										<cfset temp = QuerySetCell(data.qPackageTrackDetails, "ShipperState", data.stUpsTrack.TrackResponse.Shipment.Shipper.Address.StateProvinceCode.XmlText)>
									  </cfif>
									  <cfif IsDefined("data.stUpsTrack.TrackResponse.Shipment.Shipper.Address.PostalCode.XmlText")>
										<cfset temp = QuerySetCell(data.qPackageTrackDetails, "ShipperZip", data.stUpsTrack.TrackResponse.Shipment.Shipper.Address.PostalCode.XmlText)>
									  </cfif>
									  <cfif IsDefined("data.stUpsTrack.TrackResponse.Shipment.Shipper.Address.CountryCode.XmlText")>
										<cfset temp = QuerySetCell(data.qPackageTrackDetails, "ShipperCountry", data.stUpsTrack.TrackResponse.Shipment.Shipper.Address.CountryCode.XmlText)>
									  </cfif>
									  <cfif IsDefined("data.stUpsTrack.TrackResponse.Shipment.Shipper.SHIPPERNUMBER.XmlText")>
										<cfset temp = QuerySetCell(data.qPackageTrackDetails, "ShipperNumber", data.stUpsTrack.TrackResponse.Shipment.Shipper.SHIPPERNUMBER.XmlText)>
									  </cfif>
									</cfif>
								  </cfif>
				
								  <cfif StructKeyExists(data.stUpsTrack.TrackResponse.Shipment, "ShipTo")>
									<cfif StructKeyExists(data.stUpsTrack.TrackResponse.Shipment.ShipTo, "Address")>
									  <cfif IsDefined("data.stUpsTrack.TrackResponse.Shipment.ShipTo.Address.AddressLine1.XmlText")>
										<cfset temp = QuerySetCell(data.qPackageTrackDetails, "ShipToAddress1", data.stUpsTrack.TrackResponse.Shipment.ShipTo.Address.AddressLine1.XmlText)>
									  </cfif>
									  <cfif IsDefined("data.stUpsTrack.TrackResponse.Shipment.ShipTo.Address.AddressLine2.XmlText")>
										<cfset temp = QuerySetCell(data.qPackageTrackDetails, "ShipToAddress2", data.stUpsTrack.TrackResponse.Shipment.ShipTo.Address.AddressLine2.XmlText)>
									  </cfif>
									  <cfif IsDefined("data.stUpsTrack.TrackResponse.Shipment.ShipTo.Address.AddressLine3.XmlText")>
										<cfset temp = QuerySetCell(data.qPackageTrackDetails, "ShipToAddress3", data.stUpsTrack.TrackResponse.Shipment.ShipTo.Address.AddressLine3.XmlText)>
									  </cfif>
									  <cfif IsDefined("data.stUpsTrack.TrackResponse.Shipment.ShipTo.Address.City.XmlText")>
						
										<cfset temp = QuerySetCell(data.qPackageTrackDetails, "ShipToCity", data.stUpsTrack.TrackResponse.Shipment.ShipTo.Address.City.XmlText)>
									  </cfif>
									  <cfif IsDefined("data.stUpsTrack.TrackResponse.Shipment.ShipTo.Address.StateProvinceCode.XmlText")>
										<cfset temp = QuerySetCell(data.qPackageTrackDetails, "ShipToState", data.stUpsTrack.TrackResponse.Shipment.ShipTo.Address.StateProvinceCode.XmlText)>
									  </cfif>
									  <cfif IsDefined("data.stUpsTrack.TrackResponse.Shipment.ShipTo.Address.PostalCode.XmlText")>
										<cfset temp = QuerySetCell(data.qPackageTrackDetails, "ShipToZip", data.stUpsTrack.TrackResponse.Shipment.ShipTo.Address.PostalCode.XmlText)>
									  </cfif>
									  <cfif IsDefined("data.stUpsTrack.TrackResponse.Shipment.ShipTo.Address.CountryCode.XmlText")>
										<cfset temp = QuerySetCell(data.qPackageTrackDetails, "ShipToCountry", data.stUpsTrack.TrackResponse.Shipment.ShipTo.Address.CountryCode.XmlText)>
									  </cfif>
									</cfif>
								  </cfif>
								  <cfif IsDefined("data.stUpsTrack.TrackResponse.Shipment.ScheduledDeliveryDate.XmlText")>
									<cfset temp = QuerySetCell(data.qPackageTrackDetails, "EstimatedDelivDate", data.stUpsTrack.TrackResponse.Shipment.ScheduledDeliveryDate.XmlText)>
								  </cfif>
								  <cfif IsDefined("data.stUpsTrack.TrackResponse.Shipment.ScheduledDeliveryTime.XmlText")>
									<cfset temp = QuerySetCell(data.qPackageTrackDetails, "EstimatedDelivTime", data.stUpsTrack.TrackResponse.Shipment.ScheduledDeliveryTime.XmlText)>
								  </cfif>
								  <cfif IsDefined("data.stUpsTrack.TrackResponse.Shipment.PICKUPDATE.XmlText")>
									<cfset temp = QuerySetCell(data.qPackageTrackDetails, "PickupDate", data.stUpsTrack.TrackResponse.Shipment.PICKUPDATE.XmlText)>
								  </cfif>
								  <cfif StructKeyExists(data.stUpsTrack.TrackResponse.Shipment, "ShipmentWeight")>
									<cfif StructKeyExists(data.stUpsTrack.TrackResponse.Shipment.ShipmentWeight, "Weight")>
									  <cfset temp = QuerySetCell(data.qPackageTrackDetails, "Weight", data.stUpsTrack.TrackResponse.Shipment.ShipmentWeight.Weight.XmlText)>
									</cfif>
									<cfif StructKeyExists(data.stUpsTrack.TrackResponse.Shipment.ShipmentWeight, "UnitOfMeasurement")>
									  <cfset temp = QuerySetCell(data.qPackageTrackDetails, "WeightUnit", data.stUpsTrack.TrackResponse.Shipment.ShipmentWeight.UnitOfMeasurement.Code.XmlText)>
									</cfif>
								  </cfif>
								  <cfif StructKeyExists(data.stUpsTrack.TrackResponse.Shipment, "ShipmentIdentificationNumber")>
									<cfset temp = QuerySetCell(data.qPackageTrackDetails, "TrackingNumber", data.stUpsTrack.TrackResponse.Shipment.ShipmentIdentificationNumber.XmlText)>
								  </cfif>
								  <!-- ============= Close Create Master Package details query ===================================== -->
								  <cfelse>
								  <!--- No shipment element present, this would indicate a hard error --->
								  <cfset data.SystemErrorCode  = 2>
								  <!-- Hard Error -->
								  <cfset data.SystemErrorDesc  = "Hard Error: UPS Server provided a response but it appears to be a malformed XML document not containing the TrackResponse/Shipment element">
								  <cfabort>
								</cfif>
								<cfif IsDefined("data.stUpsTrack.TrackResponse.Shipment.Package")>
								  <cfset data.NumberOfPackages = #ArrayLen(XmlSearch(data.stUpsTrack, '/TrackResponse/Shipment/Package'))#>
								  <!--- ======== Create package Summary query to hold header summary info for each package =========== --->
								  <cfset data.qPackageSummary = QueryNew("PackageNumber, Weight, WeightUnit, TrackingNumber")>
								  <!--- ======= Create package Track Activity query to hold scan activity for each package =========== --->
								  <cfset data.qPackageTrackActivity = QueryNew("PackageID, AddressCity, AddressCountry, AddressZip, AddressState, LocationDesc, LocationSignedBy, ActivityDate, StatusTypeDesc, StatusTypeCode, ActivityTime")>
								  <cfset nPackageTrackActivityRowCount = 0>
								  <!--- Loop through package array it may be 1 or more open --->
								  <cfloop index="i" from="1" to="#ArrayLen(data.stUpsTrack.TrackResponse.Shipment.Package)#">
									<cfset newRow  = QueryAddRow(data.qPackageSummary, 1)>
									<cfset temp = QuerySetCell(data.qPackageSummary, "PackageNumber", i, i)>
									<cfif StructKeyExists(data.stUpsTrack.TrackResponse.Shipment.Package[i], "PackageWeight")>
									  <cfset temp = QuerySetCell(data.qPackageSummary, "Weight", data.stUpsTrack.TrackResponse.Shipment.Package[i].PackageWeight.Weight.XmlText, i)>
									  <cfset temp = QuerySetCell(data.qPackageSummary, "WeightUnit", data.stUpsTrack.TrackResponse.Shipment.Package[i].PackageWeight.UnitOfMeasurement.Code.XmlText, i)>
									</cfif>
									<cfif StructKeyExists(data.stUpsTrack.TrackResponse.Shipment.Package[i], "TrackingNumber")>
									  <cfset temp = QuerySetCell(data.qPackageSummary, "TrackingNumber", data.stUpsTrack.TrackResponse.Shipment.Package[i].TrackingNumber.XmlText, i)>
									</cfif>
									<!--- ===== Create package Summary query to hold header summary info for each package close==== --->
									<cfset data.aTrackActivity = data.stUpsTrack.TrackResponse.Shipment.Package[i].Activity>
									<!--- Loop through the activity results open --->
									<cfset data.ActivityCount = ArrayLen(XmlSearch(data.stUpsTrack.TrackResponse.Shipment.Package[i], "Activity"))>
									<cfloop index="idx" from="1" to="#ArrayLen(XmlSearch(data.stUpsTrack.TrackResponse.Shipment.Package[i], 'Activity'))#">
									  <cfset newRow  = QueryAddRow(data.qPackageTrackActivity)>
									  <cfset nPackageTrackActivityRowCount = nPackageTrackActivityRowCount + 1>
									  <!--- Keeps track of rows in this activity query as the loop may exit and then start again in case of multi-piece shipments --->
									  <cfif StructKeyExists(data.aTrackActivity[idx].ActivityLocation.Address, "City")>
										<cfset temp = QuerySetCell(data.qPackageTrackActivity, "AddressCity", data.aTrackActivity[idx].ActivityLocation.Address.City.XmlText, nPackageTrackActivityRowCount)>
										<cfelse>
									  </cfif>
									  <cfif StructKeyExists(data.aTrackActivity[idx].ActivityLocation.Address, "CountryCode")>
										<cfset temp = QuerySetCell(data.qPackageTrackActivity, "AddressCountry", data.aTrackActivity[idx].ActivityLocation.Address.CountryCode.XmlText, nPackageTrackActivityRowCount)>
										<cfelse>
									  </cfif>
									  <cfif StructKeyExists(data.aTrackActivity[idx].ActivityLocation.Address, "PostalCode")>
										<cfset temp = QuerySetCell(data.qPackageTrackActivity, "AddressZip", data.aTrackActivity[idx].ActivityLocation.Address.PostalCode.XmlText, nPackageTrackActivityRowCount)>
										<cfelse>
									  </cfif>
									  <cfif StructKeyExists(data.aTrackActivity[idx].ActivityLocation.Address, "StateProvinceCode")>
										<cfset temp = QuerySetCell(data.qPackageTrackActivity, "AddressState", data.aTrackActivity[idx].ActivityLocation.Address.StateProvinceCode.XmlText, nPackageTrackActivityRowCount)>
										<cfelse>
									  </cfif>
									  <cfif StructKeyExists(data.aTrackActivity[idx].ActivityLocation, "Description")>
										<cfset temp = QuerySetCell(data.qPackageTrackActivity, "LocationDesc", data.aTrackActivity[idx].ActivityLocation.Description.XmlText, nPackageTrackActivityRowCount)>
										<cfelse>
									  </cfif>
									  <cfif StructKeyExists(data.aTrackActivity[idx].ActivityLocation, "SignedForByName")>
										<cfset temp = QuerySetCell(data.qPackageTrackActivity, "LocationSignedBy", data.aTrackActivity[idx].ActivityLocation.SignedForByName.XmlText, nPackageTrackActivityRowCount)>
										<cfelse>
									  </cfif>
									  <cfif StructKeyExists(data.aTrackActivity[idx], "Date")>
										<cfset temp = QuerySetCell(data.qPackageTrackActivity, "ActivityDate", data.aTrackActivity[idx].Date.XmlText, nPackageTrackActivityRowCount)>
										<cfelse>
									  </cfif>
									  <!--- Documentation incorrectly states value of zero to one for this element but it may be an array --->
									  <cfif #IsArray(data.aTrackActivity[idx].Status.StatusType.Description.XmlChildren)#>
										<cfset StatusTypeDescList = "">
										<cfloop index="j" from="1" to="#ArrayLen(data.aTrackActivity[idx].Status.StatusType.Description)#">
										  <cfset StatusTypeDescList = data.aTrackActivity[idx].Status.StatusType.Description[j].XmlText&",">
										</cfloop>
										<cfif Right(StatusTypeDescList, 1) EQ ",">
										  <cfset vLen = Len(StatusTypeDescList)>
										  <cfset StatusTypeDescList = Left(StatusTypeDescList, (vLen - 1))>
										</cfif>
										<cfset temp = QuerySetCell(data.qPackageTrackActivity, "StatusTypeDesc", "#StatusTypeDescList#", nPackageTrackActivityRowCount)>
										<cfelseif StructKeyExists(data.aTrackActivity[idx].Status.StatusType, "Description")>
										<cfset temp = QuerySetCell(data.qPackageTrackActivity, "StatusTypeDesc", data.aTrackActivity[idx].Status.StatusType.Description.XmlText, nPackageTrackActivityRowCount)>
										<cfelse>
										<cfset temp = QuerySetCell(data.qPackageTrackActivity, "StatusTypeDesc", "")>
									  </cfif>
									  <cfif StructKeyExists(data.aTrackActivity[idx].Status.StatusType, "Code")>
										<cfset temp = QuerySetCell(data.qPackageTrackActivity, "StatusTypeCode", data.aTrackActivity[idx].Status.StatusType.Code.XmlText, nPackageTrackActivityRowCount)>
										<cfelse>
									  </cfif>
									  <cfif StructKeyExists(data.aTrackActivity[idx], "Time")>
										<cfset temp = QuerySetCell(data.qPackageTrackActivity, "ActivityTime", data.aTrackActivity[idx].Time.XmlText, nPackageTrackActivityRowCount)>
										<cfelse>
									  </cfif>
									  <cfset temp = QuerySetCell(data.qPackageTrackActivity, "PackageID", i, nPackageTrackActivityRowCount)>
									</cfloop>
									<!--- Loop through the activity results close --->
								  </cfloop>
								  <!--- Loop through package array it may be 1 or more close --->
								  <cfelse>
								  <!--- No package Element returned --->
								</cfif>
							
							<cfelseif IsDefined("data.stUpsTrack.TrackResponse.Response.ResponseStatusCode.XmlText") AND data.stUpsTrack.TrackResponse.Response.ResponseStatusCode.XmlText EQ 0>
							<!--- Else-If [5] Check for Error element --->
							
								<cfset data.SystemErrorCode = 1>
								<!--- Response fine, transaction failed however --->
								<cfset data.SystemErrorDesc = "Valid Response, Tracking number related error">
								<cfif StructKeyExists(data.stUpsTrack.TrackResponse.Response, "Error")>
								  <cfif IsDefined("data.stUpsTrack.TrackResponse.Response.Error.ErrorCode.XmlText")>
									<cfset data.UPSErrorCode = data.stUpsTrack.TrackResponse.Response.Error.ErrorCode.XmlText>
								  </cfif>
								  <cfif IsDefined("data.stUpsTrack.TrackResponse.Response.Error.ErrorDescription.XmlText")>
									<cfset data.UPSErrorDescription = data.stUpsTrack.TrackResponse.Response.Error.ErrorDescription.XmlText>
								  </cfif>
								</cfif>
						  
						  <cfelse> <!--- If [5] Check for Error element --->
							<cfset data.SystemErrorCode = 2>
							<cfset data.SystemErrorDesc = "Hard Error: Hard Error: UPS Server provided a response but it appears to be a malformed XML document">
						  </cfif> <!--- EndIf [5] Check for Error element --->	
		
					  <cfelse> <!--- If [4] Check for Response element, should be present under TrackResponse element --->
						<!-- No valid response received - abort now -->
						<cfset data.SystemErrorCode  = 2>
						<!-- Hard Error -->
						<cfset data.SystemErrorDesc  = "Hard Error: UPS Server provided a response but it appears to be a malformed XML document not containing the TrackResponse/Response element">
					  </cfif> <!--- EndIf [4] Check for Response element, should be present under TrackResponse element --->
								
				  <cfelse> <!--- If [3] Check for Track Response element (root node) --->
					<!-- No valid response received - abort now -->
					<cfset data.SystemErrorCode  = 2>
					<!-- Hard Error -->
					<cfset data.SystemErrorDesc  = "Hard Error: UPS Server provided a response but it appears to be a malformed XML document not containing the TrackResponse root node">
					<cfabort>
				  </cfif> <!--- EndIf [3] Check for Track Response element (root node) --->
		
				</cfif> <!--- EndIf [2] Check if debug request or No --->
			  
			  <cfelse> <!--- If [1] Check for valid response --->
				<!-- No valid response received - abort now -->
				<cfset data.SystemErrorCode  = 2>
				<!-- Hard Error -->
				<cfset data.SystemErrorDesc  = "Hard Error: No valid response was received from UPS Servers, the response received was an empty file">
				<!-- Hard Error -->
				<cffile action="WRITE" file="#arguments.ServerFilePath##trailingSlash#Debug#trailingSlash#TrackOutput.xml" output="#cfhttp.FileContent#" addnewline="No" nameconflict="overwrite">
			  </cfif> <!--- EndIf [1] Check for valid response --->
			  
			
		  <cfelse> <!--- ****//// Tracking Server Unavailable ////**** --->
			<cfset data.stUpsTrack = XmlParse(Trim(cfhttp.FileContent))>
			<cfdump var="#data.stUpsTrack#">
			<!-- No valid response received - abort now -->
			<cfset data.SystemErrorCode  = 2>
			<!-- Hard Error -->
			<cfset data.SystemErrorDesc  = "Hard Error: UPS Servers appear to be unavailable right now, please try request again later">
			<!-- Hard Error -->
		  </cfif> <!--- ****//// Tracking Server Availability Check close ////**** --->
			<cfcatch type="any">
			 <cfset data.UPSAVError = 2>
			</cfcatch>
		   </cftry>
		  </cfcase>
		  <!--- END UPS Track Request --->
		  <!--- UPS Track No Activity Request --->
		  <cfcase value="trackNoActivityRequest">
		  <cfscript>	
		
			arguments.TrackNoAccess = '<?xml version="#arguments.XMLVersion#"?>
			<AccessRequest xml:lang="en-US">
			<AccessLicenseNumber>#arguments.UPSAccessKey#</AccessLicenseNumber>
				<UserId>#arguments.UPSUserID#</UserId>
				<Password>#arguments.UPSPassword#</Password>
			</AccessRequest>';
		
			
			arguments.TrackNoRequest='<?xml version="#arguments.XMLVersion#"?>
			<TrackRequest xml:lang="en-US">
				<Request>
					<TransactionReference>
						<CustomerContext>Tracking Activity Request</CustomerContext>
						<XpciVersion>#arguments.XPCIVersion#</XpciVersion>
					</TransactionReference>
					<RequestAction>Track</RequestAction>
					<RequestOption>none</RequestOption>
				</Request>
					<TrackingNumber>#arguments.TrackingNumber#</TrackingNumber>
			</TrackRequest>';
			arguments.XMLRequestInput = '#arguments.TrackNoAccess#
			#arguments.TrackNoRequest#';
			</cfscript>
		  <cfhttp method="post" url="#arguments.trackServer#" resolveurl="yes" port="443" timeout="#arguments.TimeOut#">
			<cfhttpparam name="XML" type="xml" value="#arguments.XMLRequestInput#">
		  </cfhttp>
		  <cfset data.stUpsTrack = XmlParse(Trim(cfhttp.FileContent))>
		  <cfif IsDefined("arguments.Debug") AND arguments.Debug EQ "TRUE">
			<cffile action="WRITE" file="#arguments.ServerFilePath##trailingSlash#Debug#trailingSlash#TrackNoAccess.xml" output="#arguments.TrackNoAccess#" addnewline="No" nameconflict="overwrite">
			<cffile action="WRITE" file="#arguments.ServerFilePath##trailingSlash#Debug#trailingSlash#TrackNoRequest.xml" output="#arguments.TrackNoRequest#" addnewline="No" nameconflict="overwrite">
			<cfoutput>
			  <cfdump var="#data.stUpsTrack#">
			  <a href="Debug#trailingSlash#TrackNoAccess.xml" target="_blank">View XML Access File</a> <a href="Debug#trailingSlash#TrackNoRequest.xml" target="_blank">View XML Request File</a> </cfoutput>
			<cfabort>
		  </cfif>
		  <!--- <cfoutput><cfdump var="#data.stUpsTrack#"></cfoutput> --->
		  <cfif IsDefined("data.stUpsTrack.TrackResponse.Response.ResponseStatusCode.XmlText") AND #data.stUpsTrack.TrackResponse.Response.ResponseStatusCode.XmlText# EQ 1>
			<cfset data.UPSTrackError = 0>
			<!--- package element structure only --->
			<cfif IsDefined("data.stUpsTrack.TrackResponse.Shipment.Package")>
			  <cfset data.TrackActivityQueryMultiple = 0>
			  <!--- There will be only 1 activity query returned --->
			  <cfif IsDefined("data.stUpsTrack.TrackResponse.Shipment.Package.PackageWeight.Weight.XmlText")>
				<cfset data.UPSPackageWeight = data.stUpsTrack.TrackResponse.Shipment.Package.PackageWeight.Weight.XmlText>
			  </cfif>
			  <cfif IsDefined("data.stUpsTrack.TrackResponse.Shipment.Package.PackageWeight.UnitOfMeasurement.Code.XmlText")>
				<cfset data.UPSPackageWeightUnit = data.stUpsTrack.TrackResponse.Shipment.Package.PackageWeight.UnitOfMeasurement.Code.XmlText>
			  </cfif>
			  <cfif IsDefined("data.stUpsTrack.TrackResponse.Shipment.Package.TRACKINGNUMBER.XmlText")>
				<cfset data.UPSTrackingNumber = data.stUpsTrack.TrackResponse.Shipment.Package.TRACKINGNUMBER.XmlText>
			  </cfif>
			  <cfif IsDefined("data.stUpsTrack.TrackResponse.Shipment.Service.Code.XmlText")>
				<cfset data.UPSServiceCode = data.stUpsTrack.TrackResponse.Shipment.Service.Code.XmlText>
			  </cfif>
			  <cfif IsDefined("data.stUpsTrack.TrackResponse.Shipment.Service.Description.XmlText")>
				<cfset data.UPSServiceDesc = data.stUpsTrack.TrackResponse.Shipment.Service.Description.XmlText>
			  </cfif>
			  <cfif IsDefined("data.stUpsTrack.TrackResponse.Shipment.Shipper.Address.AddressLine1.XmlText")>
				<cfset data.UPSShipperAddress1 = data.stUpsTrack.TrackResponse.Shipment.Shipper.Address.AddressLine1.XmlText>
			  </cfif>
			  <cfif IsDefined("data.stUpsTrack.TrackResponse.Shipment.Shipper.Address.AddressLine2.XmlText")>
				<cfset data.UPSShipperAddress2 = data.stUpsTrack.TrackResponse.Shipment.Shipper.Address.AddressLine2.XmlText>
			  </cfif>
			  <cfif IsDefined("data.stUpsTrack.TrackResponse.Shipment.Shipper.Address.AddressLine3.XmlText")>
				<cfset data.UPSShipperAddress3 = data.stUpsTrack.TrackResponse.Shipment.Shipper.Address.AddressLine3.XmlText>
			  </cfif>
			  <cfif IsDefined("data.stUpsTrack.TrackResponse.Shipment.Shipper.Address.City.XmlText")>
				<cfset data.UPSShipperCity = data.stUpsTrack.TrackResponse.Shipment.Shipper.Address.City.XmlText>
			  </cfif>
			  <cfif IsDefined("data.stUpsTrack.TrackResponse.Shipment.Shipper.Address.StateProvinceCode.XmlText")>
				<cfset data.UPSShipperState = data.stUpsTrack.TrackResponse.Shipment.Shipper.Address.StateProvinceCode.XmlText>
			  </cfif>
			  <cfif IsDefined("data.stUpsTrack.TrackResponse.Shipment.Shipper.Address.PostalCode.XmlText")>
				<cfset data.UPSShipperZip = data.stUpsTrack.TrackResponse.Shipment.Shipper.Address.PostalCode.XmlText>
			  </cfif>
			  <cfif IsDefined("data.stUpsTrack.TrackResponse.Shipment.Shipper.Address.CountryCode.XmlText")>
				<cfset data.UPSShipperCountry = data.stUpsTrack.TrackResponse.Shipment.Shipper.Address.CountryCode.XmlText>
			  </cfif>
			  <cfif IsDefined("data.stUpsTrack.TrackResponse.Shipment.Shipper.SHIPPERNUMBER.XmlText")>
				<cfset data.UPSShipperNumber = data.stUpsTrack.TrackResponse.Shipment.Shipper.SHIPPERNUMBER.XmlText>
			  </cfif>
			  <cfif IsDefined("data.stUpsTrack.TrackResponse.Shipment.ScheduledDeliveryDate.XmlText")>
				<cfset data.UPSEstimatedDelivDate = data.stUpsTrack.TrackResponse.Shipment.ScheduledDeliveryDate.XmlText>
			  </cfif>
			  <cfif IsDefined("data.stUpsTrack.TrackResponse.Shipment.ScheduledDeliveryTime.XmlText")>
				<cfset data.UPSEstimatedDelivTime = data.stUpsTrack.TrackResponse.Shipment.ScheduledDeliveryTime.XmlText>
			  </cfif>
			  <cfif IsDefined("data.stUpsTrack.TrackResponse.Shipment.PICKUPDATE.XmlText")>
				<cfset data.UPSPickupDate = data.stUpsTrack.TrackResponse.Shipment.PICKUPDATE.XmlText>
			  </cfif>
			</cfif>
			<cfif IsDefined("data.stUpsTrack.TrackResponse.Shipment.Package.Activity")>
			  <!--- Structure returned only no array --->
			  <cfset data.UPSTrackError = 0>
			  <cfset data.TrackActivityQuery = QueryNew("AddressCity, AddressCountry, AddressZip, AddressState, LocationDesc, LocationSignedBy, ActivityDate, StatusTypeDesc, StatusTypeCode, ActivityTime")>
			  <cfset data.aTrackActivityQuery = data.stUpsTrack.TrackResponse.Shipment.Package.Activity>
			  <cfset newRow  = QueryAddRow(data.TrackActivityQuery, 1)>
			  <cfif StructKeyExists(data.aTrackActivityQuery.ActivityLocation.Address, "City")>
				<cfset temp = QuerySetCell(data.TrackActivityQuery, "AddressCity", data.aTrackActivityQuery.ActivityLocation.Address.City.XmlText, 1)>
				<cfelse>
				<cfset temp = QuerySetCell(data.TrackActivityQuery, "AddressCity", "")>
			  </cfif>
			  <cfif StructKeyExists(data.aTrackActivityQuery.ActivityLocation.Address, "CountryCode")>
				<cfset temp = QuerySetCell(data.TrackActivityQuery, "AddressCountry", data.aTrackActivityQuery.ActivityLocation.Address.CountryCode.XmlText, 1)>
				<cfelse>
				<cfset temp = QuerySetCell(data.TrackActivityQuery, "AddressCountry", "")>
			  </cfif>
			  <cfif StructKeyExists(data.aTrackActivityQuery.ActivityLocation.Address, "PostalCode")>
				<cfset temp = QuerySetCell(data.TrackActivityQuery, "AddressZip", data.aTrackActivityQuery.ActivityLocation.Address.PostalCode.XmlText, 1)>
				<cfelse>
				<cfset temp = QuerySetCell(data.TrackActivityQuery, "AddressZip", "")>
			  </cfif>
			  <cfif StructKeyExists(data.aTrackActivityQuery.ActivityLocation.Address, "StateProvinceCode")>
				<cfset temp = QuerySetCell(data.TrackActivityQuery, "AddressState", data.aTrackActivityQuery.ActivityLocation.Address.StateProvinceCode.XmlText, 1)>
				<cfelse>
				<cfset temp = QuerySetCell(data.TrackActivityQuery, "AddressState", "")>
			  </cfif>
			  <cfif StructKeyExists(data.aTrackActivityQuery.ActivityLocation, "Description")>
				<cfset temp = QuerySetCell(data.TrackActivityQuery, "LocationDesc", data.aTrackActivityQuery.ActivityLocation.Description.XmlText, 1)>
				<cfelse>
				<cfset temp = QuerySetCell(data.TrackActivityQuery, "LocationDesc", "")>
			  </cfif>
			  <cfif StructKeyExists(data.aTrackActivityQuery.ActivityLocation, "SignedForByName")>
				<cfset temp = QuerySetCell(data.TrackActivityQuery, "LocationSignedBy", data.aTrackActivityQuery.ActivityLocation.SignedForByName.XmlText, 1)>
				<cfelse>
				<cfset temp = QuerySetCell(data.TrackActivityQuery, "LocationSignedBy", "")>
			  </cfif>
			  <cfif StructKeyExists(data.aTrackActivityQuery, "Date")>
				<cfset temp = QuerySetCell(data.TrackActivityQuery, "ActivityDate", data.aTrackActivityQuery.Date.XmlText, 1)>
				<cfelse>
				<cfset temp = QuerySetCell(data.TrackActivityQuery, "ActivityDate", "")>
			  </cfif>
			  <!--- Documentation incorrectly states value of zero to one for this element but it may be an array --->
			  <cfif #IsArray(data.aTrackActivityQuery.Status.StatusType.Description.XmlChildren)#>
				<cfset StatusTypeDescList = "">
				<cfloop index="j" from="1" to="#ArrayLen(data.aTrackActivityQuery.Status.StatusType.Description)#">
				  <cfset StatusTypeDescList = data.aTrackActivityQuery.Status.StatusType.Description[j].XmlText&",">
				</cfloop>
				<cfif Right(StatusTypeDescList, 1) EQ ",">
				  <cfset vLen = Len(StatusTypeDescList)>
				  <cfset StatusTypeDescList = Left(StatusTypeDescList, (vLen - 1))>
				</cfif>
				<cfset temp = QuerySetCell(data.TrackActivityQuery, "StatusTypeDesc", "#StatusTypeDescList#")>
				<cfelseif StructKeyExists(data.aTrackActivityQuery.Status.StatusType, "Description")>
				<cfset temp = QuerySetCell(data.TrackActivityQuery, "StatusTypeDesc", data.aTrackActivityQuery.Status.StatusType.Description.XmlText, 1)>
				<cfelse>
				<cfset temp = QuerySetCell(data.TrackActivityQuery, "StatusTypeDesc", "")>
			  </cfif>
			  <cfif StructKeyExists(data.aTrackActivityQuery.Status.StatusType, "Code")>
				<cfset temp = QuerySetCell(data.TrackActivityQuery, "StatusTypeCode", data.aTrackActivityQuery.Status.StatusType.Code.XmlText, 1)>
				<cfelse>
				<cfset temp = QuerySetCell(data.TrackActivityQuery, "StatusTypeCode", "")>
			  </cfif>
			  <cfif StructKeyExists(data.aTrackActivityQuery, "Time")>
				<cfset temp = QuerySetCell(data.TrackActivityQuery, "ActivityTime", data.aTrackActivityQuery.Time.XmlText, 1)>
				<cfelse>
				<cfset temp = QuerySetCell(data.TrackActivityQuery, "ActivityTime", "")>
			  </cfif>
			  <cfelse>
			  <!--- Package Activity structure check --->
			  <!--- Unhandled response received --->
			</cfif>
			<!--- Package Activity structure check --->
			<cfelseif IsDefined("data.stUpsTrack.TrackResponse.Response.ResponseStatusCode.XmlText") AND
		
				data.stUpsTrack.TrackResponse.Response.ResponseStatusCode.XmlText EQ 0>
			<cfset data.UPSTrackError = 1>
			<!--- Response fine, transaction failed however --->
			<cfif IsDefined("data.stUpsTrack.TrackResponse.Response.Error.ErrorCode.XmlText")>
			  <cfset data.UPSErrorCode = data.stUpsTrack.TrackResponse.Response.Error.ErrorCode.XmlText>
			</cfif>
			<cfif IsDefined("data.stUpsTrack.TrackResponse.Response.Error.ErrorDescription.XmlText")>
			  <cfset data.UPSErrorDescription = data.stUpsTrack.TrackResponse.Response.Error.ErrorDescription.XmlText>
			</cfif>
			<cfelse>
			<cfset data.UPSTrackError = 2>
		  </cfif>
		  </cfcase>
		  <!--- END UPS Track No Activity Request --->
		</cfswitch><!--- End UPS XML Scripts - Andrew --->

		
		
		
		<cfreturn data >
	</cffunction>
</cfcomponent>