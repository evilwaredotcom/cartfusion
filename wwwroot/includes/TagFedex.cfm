<!--- Fedex Gateway common error code: 16437 --->

<cfscript>
	// 2.0
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
	
	todaysDateOrig = Now();
	currentDay = DatePart( "d", todaysDateOrig);
	nCurrentDay = DayOfWeek(todaysDateOrig);
	if (nCurrentDay eq 1) {
		//Sunday
		todaysDate = DateAdd("d", 1, todaysDateOrig);
	}
	else if (nCurrentDay eq 7) {
		//Saturday
		todaysDate = DateAdd("d", 2, todaysDateOrig);
	}
	else {
		todaysDate = todaysDateOrig;
	}
		
		pickupDateYear = DatePart("yyyy",todaysDate);
		pickupDateMonth = DatePart("m",todaysDate);
		if ( Len(pickupDateMonth) eq 1 )
			pickupDateMonth = "0"&#pickupDateMonth#;
		pickupDateDay = DatePart("d",todaysDate);
		if ( Len(pickupDateDay) eq 1 ) {
			pickupDateDay = "0"&#pickupDateDay#;
		}
		pickupDate = #pickupDateYear#&"-"&#pickupDateMonth#&"-"&#pickupDateDay#;
</cfscript>

<cfparam name="ATTRIBUTES.pickupDate" default="#pickupDate#">

<cfparam name="ATTRIBUTES.ServerFilePath" default="#currentWorkingDir#">

<cfparam name="ATTRIBUTES.TestingEnvironment" default="TRUE">
<cfif ATTRIBUTES.TestingEnvironment eq "TRUE">
	<cfset ATTRIBUTES.FedexServer = "https://gatewaybeta.fedex.com:443/GatewayDC/">
<cfelse>
	<cfset ATTRIBUTES.FedexServer = "https://gateway.fedex.com:443/GatewayDC/">
</cfif>
<cfparam name="ATTRIBUTES.Debug" default="FALSE">
<cfparam name="ATTRIBUTES.TimeOut" default="60">

<cfparam name="ATTRIBUTES.AccountNumber" default="">
<cfparam name="ATTRIBUTES.FedexIndentifier" default="">
<cfparam name="ATTRIBUTES.RateVersion" default="1.0">
<cfparam name="ATTRIBUTES.TrackVersion" default="1.0">
<cfparam name="ATTRIBUTES.PODVersion" default="1.0">
<cfparam name="ATTRIBUTES.RegisterVersion" default="1.0">
<cfparam name="ATTRIBUTES.XMLVersion" default="1.0">
<cfparam name="ATTRIBUTES.CustTransactionString" default="CustString">
<cfparam name="ATTRIBUTES.DeleteShipmentTransactionString" default="FdxDeleteShipment">

<cfparam name="ATTRIBUTES.PackageWeight" default="1">
<cfparam name="ATTRIBUTES.PackageWeightUnit" default="LBS">
<cfparam name="ATTRIBUTES.PackageLength" default="10"> <!--- optional --->
<cfparam name="ATTRIBUTES.PackageWidth" default="10"> <!--- optional --->
<cfparam name="ATTRIBUTES.PackageHeight" default="10"> <!--- optional --->
<cfparam name="ATTRIBUTES.PackageUnitOfMeasurement" default="IN"> <!--- Inches --->
<cfparam name="ATTRIBUTES.HandlingCharge" default="0">
<cfparam name="ATTRIBUTES.PackageCount" default="1">
<cfparam name="ATTRIBUTES.Packaging" default="YOURPACKAGING">
<cfparam name="ATTRIBUTES.DropOffType" default="REGULARPICKUP">
<cfparam name="ATTRIBUTES.DeclaredValue" default="">
<cfparam name="ATTRIBUTES.CurrencyCode" default="USD">
<cfparam name="ATTRIBUTES.PayorAccountNumber" default="">
<cfparam name="ATTRIBUTES.PayorCountryCode" default="US">
<cfparam name="ATTRIBUTES.ReferenceCustomerNote" default="">
<cfparam name="ATTRIBUTES.ReferencePONumber" default="">
<cfparam name="ATTRIBUTES.ReferenceInvoiceNumber" default="">
			
<cfparam name="ATTRIBUTES.ShipperCompany" default="">
<cfparam name="ATTRIBUTES.ShipperContactName" default="">
<cfparam name="ATTRIBUTES.ShipperDept" default="Shipping">
<cfparam name="ATTRIBUTES.ShipperPhone" default="">
<cfparam name="ATTRIBUTES.ShipperPager" default="">
<cfparam name="ATTRIBUTES.ShipperFax" default="">
<cfparam name="ATTRIBUTES.ShipperEmail" default="">
<cfparam name="ATTRIBUTES.ShipperStreet" default="">
<cfparam name="ATTRIBUTES.ShipperStreet2" default="">
<cfparam name="ATTRIBUTES.ShipperCity" default="">
<cfparam name="ATTRIBUTES.ShipperState" default="">
<cfparam name="ATTRIBUTES.ShipperZip" default="">
<cfparam name="ATTRIBUTES.ShipperCountry" default="US"> <!--- required 2 digit country code --->

<cfparam name="ATTRIBUTES.ShipToCompany" default="">
<cfparam name="ATTRIBUTES.ShipToContactName" default="">
<cfparam name="ATTRIBUTES.ShipToDept" default="">
<cfparam name="ATTRIBUTES.ShipToPhone" default="">
<cfparam name="ATTRIBUTES.ShipToPager" default="">
<cfparam name="ATTRIBUTES.ShipToFax" default="">
<cfparam name="ATTRIBUTES.ShipToEmail" default="">
<cfparam name="ATTRIBUTES.ShipToStreet" default="">
<cfparam name="ATTRIBUTES.ShipToStreet2" default="">
<cfparam name="ATTRIBUTES.ShipToCity" default="">
<cfparam name="ATTRIBUTES.ShipToState" default="">
<cfparam name="ATTRIBUTES.ShipToZip" default="">
<cfparam name="ATTRIBUTES.ShipToCountry" default="">

<cfparam name="ATTRIBUTES.TrackingNumber" default="">
<cfparam name="ATTRIBUTES.TrackingServiceType" default="Express">
<cfparam name="ATTRIBUTES.TrackingSearchType" default="TrackingNumber">
<cfparam name="ATTRIBUTES.TrackStartDate" default=""> <!--- Format: YYYY-MM-DD --->
<cfparam name="ATTRIBUTES.TrackEndDate" default=""> <!--- Format: YYYY-MM-DD --->
<cfparam name="ATTRIBUTES.DateShipped" default="#pickupDate#"> <!--- Format: YYYY-MM-DD --->
<cfparam name="ATTRIBUTES.TimeShipped" default="#TimeFormat(Now(),'HH:MM:SS')#"> <!--- Format: HH:MM:SS --->
<cfparam name="ATTRIBUTES.PayorType" default="SENDER">
<cfparam name="ATTRIBUTES.ServiceLevel" default="PRIORITYOVERNIGHT">

<!--- Special Services --->
<cfparam name="ATTRIBUTES.SSCODType" default=""> <!--- ANY | GUARANTEEDFUNDS | CASH --->
<cfparam name="ATTRIBUTES.SSCodAmount" default="">
<cfparam name="ATTRIBUTES.SSCODReturnContactName" default="">
<cfparam name="ATTRIBUTES.SSCODReturnCompany" default="">
<cfparam name="ATTRIBUTES.SSCODReturnDept" default="">
<cfparam name="ATTRIBUTES.SSCODReturnPhone" default="">
<cfparam name="ATTRIBUTES.SSCODReturnStreet1" default="">
<cfparam name="ATTRIBUTES.SSCODReturnStreet2" default="">
<cfparam name="ATTRIBUTES.SSCODReturnCity" default="">
<cfparam name="ATTRIBUTES.SSCODReturnState" default="">
<cfparam name="ATTRIBUTES.SSCODReturnZip" default="">
<cfparam name="ATTRIBUTES.SSCODReturnTracking" default=""> <!--- Multi-piece COD shipments only, the tracking number of the first piece is added to the last piece in the shipment --->
<cfparam name="ATTRIBUTES.SSCODReturnReferenceType" default="">
<cfparam name="ATTRIBUTES.SSFutureDayDelivery" default="">
<cfparam name="ATTRIBUTES.SSFutureDayShipment" default="0">
<cfparam name="ATTRIBUTES.SSHoldAtLocation" default=""> <!--- FDXE Only --->
<cfparam name="ATTRIBUTES.SSHoldAtLocationPhone" default="">
<cfparam name="ATTRIBUTES.SSHoldAtLocationStreet1" default="">
<cfparam name="ATTRIBUTES.SSHoldAtLocationCity" default="">
<cfparam name="ATTRIBUTES.SSHoldAtLocationState" default="">
<cfparam name="ATTRIBUTES.SSHoldAtLocationZip" default="">
<cfparam name="ATTRIBUTES.SSDangerousGoods" default="">
<cfparam name="ATTRIBUTES.SSDryIce" default="0"> <!--- FDXE Only --->
<cfparam name="ATTRIBUTES.SSResDelivery" default="0"> <!--- FDXE / FDXG Only --->
<cfparam name="ATTRIBUTES.SSInsidePickup" default="0"> <!--- FDXE Only --->
<cfparam name="ATTRIBUTES.SSInsideDelivery" default="0"> <!--- FDXE Only --->
<cfparam name="ATTRIBUTES.SSSatPickup" default="0"> <!--- FDXE Only --->
<cfparam name="ATTRIBUTES.SSSatDelivery" default="0"> <!--- FDXE Only --->
<cfparam name="ATTRIBUTES.SSAOD" default="0"> <!--- FDXG Only --->
<cfparam name="ATTRIBUTES.SSAutoPOD" default="0"> <!--- FDXG Only --->
<cfparam name="ATTRIBUTES.SSNonStdContainer" default="0"> <!--- FDXG Only --->
<cfparam name="ATTRIBUTES.UseCustomerBroker" default="0"> <!--- INTL only --->
<cfparam name="ATTRIBUTES.RequestListRates" default="0">
<cfparam name="ATTRIBUTES.RateRequestType" default="FDXE">

<cfparam name="ATTRIBUTES.ReturnShipment" default="">

<!--- Ground Home Delivery --->
<cfparam name="ATTRIBUTES.HomeDeliveryType" default=""> <!--- DATECERTAIN | EVENING | APPOINTMENT --->
<cfparam name="ATTRIBUTES.HomeDeliverySigRequired" default="0"> <!--- 0 | 1 --->
<cfparam name="ATTRIBUTES.HomeDeliveryDate" default="">
<cfparam name="ATTRIBUTES.HomeDeliveryInstructions" default="">
<cfparam name="ATTRIBUTES.HomeDeliveryPhoneNumber" default="">

<!--- Shipment Alert/Notification ShipRequest --->
<cfparam name="ATTRIBUTES.ShipAlertFaxNumber" default="">
<cfparam name="ATTRIBUTES.ShipAlertOptionalMessage" default="">
<cfparam name="ATTRIBUTES.ShipperShipAlert" default="0">
<cfparam name="ATTRIBUTES.ShipperDeliveryNotification" default="0">
<cfparam name="ATTRIBUTES.ShipperLanguageCode" default="EN">
<cfparam name="ATTRIBUTES.RecipientShipAlert" default="1">
<cfparam name="ATTRIBUTES.RecipientDeliveryNotification" default="1">
<cfparam name="ATTRIBUTES.RecipientLanguageCode" default="EN">
<cfparam name="ATTRIBUTES.BrokerShipAlert" default="0">
<cfparam name="ATTRIBUTES.BrokerDeliveryNotification" default="0">
<cfparam name="ATTRIBUTES.BrokerLanguageCode" default="EN">
<cfparam name="ATTRIBUTES.OtherEmail" default="">
<cfparam name="ATTRIBUTES.OtherShipAlert" default="0">
<cfparam name="ATTRIBUTES.OtherDeliveryNotification" default="0">
<cfparam name="ATTRIBUTES.OtherLanguageCode" default="EN">

<cfparam name="ATTRIBUTES.SignatureRequired" default="1">
<cfparam name="ATTRIBUTES.SignatureRelease" default="0">

<!--- Shipping Label --->
<cfparam name="ATTRIBUTES.LabelType" default="STANDARD">
<cfparam name="ATTRIBUTES.LabelImageType" default="PNG"> <!--- PNG, ELTRON for thermal labels --->
<cfparam name="ATTRIBUTES.LabelStockOrientation" default="NONE"> <!--- LEADING, TRAILING, NONE --->
<!--- Thermal Shipping Label only --->
<cfparam name="ATTRIBUTES.ThermalLabelDocTabLocation" default=""> <!--- STANDARD | ZONE001 --->
<cfparam name="ATTRIBUTES.ThermalLabelType" default="">
<cfparam name="ATTRIBUTES.ThermalLabelZoneNumber" default="">
<cfparam name="ATTRIBUTES.ThermalLabelHeader" default="">
<cfparam name="ATTRIBUTES.ThermalLabelValue" default="">

<!--- International Shipments --->
<cfparam name="ATTRIBUTES.RecipientTIN" default="">
<cfparam name="ATTRIBUTES.BrokerAccountNumber" default="">
<cfparam name="ATTRIBUTES.BrokerTIN" default="">
<cfparam name="ATTRIBUTES.BrokerName" default="">
<cfparam name="ATTRIBUTES.BrokerCompanyName" default="">
<cfparam name="ATTRIBUTES.BrokerPhoneNumber" default="">
<cfparam name="ATTRIBUTES.BrokerPagerNumber" default="">
<cfparam name="ATTRIBUTES.BrokerFaxNumber" default="">
<cfparam name="ATTRIBUTES.BrokerEmail" default="">
<cfparam name="ATTRIBUTES.BrokerStreet" default="">
<cfparam name="ATTRIBUTES.BrokerStreet2" default="">
<cfparam name="ATTRIBUTES.BrokerCity" default="">
<cfparam name="ATTRIBUTES.BrokerState" default="">
<cfparam name="ATTRIBUTES.BrokerZip" default="">
<cfparam name="ATTRIBUTES.BrokerCountry" default="">	
<cfparam name="ATTRIBUTES.DutiesPayorAccountNumber" default=""> <!--- FDXE INTL AccountNumber, Required if Duties Pay Type is THIRDPARTY --->
<cfparam name="ATTRIBUTES.DutiesPayorCountry" default="">
<cfparam name="ATTRIBUTES.DutiesPayorType" default="RECIPIENT"> <!--- SENDER, RECIPIENT, THIRDPARTY --->
<cfparam name="ATTRIBUTES.TermsOfSale" default=""> <!--- FOB_OR_FCA, CIF_OR_CIP, CFR_OR_CPT, EXW, DDU, DDP --->
<cfparam name="ATTRIBUTES.PartiesToTransaction" default="0"> <!--- 1 is required if the exporter and the consignee of the transaction are related. --->
<cfparam name="ATTRIBUTES.IntlDocumentDesc" default=""> <!--- 148 character description of document being shipped. Required field for international document shipments. If multi-piece shipment, this field must be populated in the Master transaction and all Children transactions. --->
<cfparam name="ATTRIBUTES.NAFTA" default="0"> <!--- 1 if NAFTA shipment, else 0.if origin and destination countries are US, CA,or MX. --->
<cfparam name="ATTRIBUTES.CountryOfUltimateDestination" default="">
<cfparam name="ATTRIBUTES.TotalCustomsValue" default=""> <!--- Format: Two explicit decimal positions (e.g. 100.00). --->
<cfparam name="ATTRIBUTES.SenderTINOrDUNS" default="">
<cfparam name="ATTRIBUTES.SenderTINOrDUNSType" default=""> <!--- SSN, EIN, DUNS --->
<cfparam name="ATTRIBUTES.AESOrFTSRExemptionNumber" default="">
	
<!--- Fedex Services Global Query --->
<cfset CALLER.qServiceLevelFdx = QueryNew("ServiceLevelCode, ServiceLevelDesc")>
<cfset newRow  = QueryAddRow(CALLER.qServiceLevelFdx, 1)>
<cfset temp = QuerySetCell(CALLER.qServiceLevelFdx, "ServiceLevelCode", "PRIORITYOVERNIGHT")>
<cfset temp = QuerySetCell(CALLER.qServiceLevelFdx, "ServiceLevelDesc", "Fedex Priority Overnight")>
<cfset newRow  = QueryAddRow(CALLER.qServiceLevelFdx, 1)>
<cfset temp = QuerySetCell(CALLER.qServiceLevelFdx, "ServiceLevelCode", "STANDARDOVERNIGHT")>
<cfset temp = QuerySetCell(CALLER.qServiceLevelFdx, "ServiceLevelDesc", "Fedex Standard Overnight")>
<cfset newRow  = QueryAddRow(CALLER.qServiceLevelFdx, 1)>
<cfset temp = QuerySetCell(CALLER.qServiceLevelFdx, "ServiceLevelCode", "FIRSTOVERNIGHT")>
<cfset temp = QuerySetCell(CALLER.qServiceLevelFdx, "ServiceLevelDesc", "Fedex First Overnight")>
<cfset newRow  = QueryAddRow(CALLER.qServiceLevelFdx, 1)>
<cfset temp = QuerySetCell(CALLER.qServiceLevelFdx, "ServiceLevelCode", "FEDEX2DAY")>
<cfset temp = QuerySetCell(CALLER.qServiceLevelFdx, "ServiceLevelDesc", "Fedex 2nd Day Air")>
<cfset newRow  = QueryAddRow(CALLER.qServiceLevelFdx, 1)>
<cfset temp = QuerySetCell(CALLER.qServiceLevelFdx, "ServiceLevelCode", "FEDEXEXPRESSSAVER")>
<cfset temp = QuerySetCell(CALLER.qServiceLevelFdx, "ServiceLevelDesc", "Fedex Express Saver")>
<cfset newRow  = QueryAddRow(CALLER.qServiceLevelFdx, 1)>
<cfset temp = QuerySetCell(CALLER.qServiceLevelFdx, "ServiceLevelCode", "INTERNATIONALPRIORITY")>
<cfset temp = QuerySetCell(CALLER.qServiceLevelFdx, "ServiceLevelDesc", "Fedex International Priority")>
<cfset newRow  = QueryAddRow(CALLER.qServiceLevelFdx, 1)>
<cfset temp = QuerySetCell(CALLER.qServiceLevelFdx, "ServiceLevelCode", "INTERNATIONALECONOMY")>
<cfset temp = QuerySetCell(CALLER.qServiceLevelFdx, "ServiceLevelDesc", "Fedex International Economy")>
<cfset newRow  = QueryAddRow(CALLER.qServiceLevelFdx, 1)>
<cfset temp = QuerySetCell(CALLER.qServiceLevelFdx, "ServiceLevelCode", "INTERNATIONALFIRST")>
<cfset temp = QuerySetCell(CALLER.qServiceLevelFdx, "ServiceLevelDesc", "Fedex International First")>
<cfset newRow  = QueryAddRow(CALLER.qServiceLevelFdx, 1)>
<cfset temp = QuerySetCell(CALLER.qServiceLevelFdx, "ServiceLevelCode", "FEDEX1DAYFREIGHT")>
<cfset temp = QuerySetCell(CALLER.qServiceLevelFdx, "ServiceLevelDesc", "Fedex Next Day Freight")>
<cfset newRow  = QueryAddRow(CALLER.qServiceLevelFdx, 1)>
<cfset temp = QuerySetCell(CALLER.qServiceLevelFdx, "ServiceLevelCode", "FEDEX2DAYFREIGHT")>
<cfset temp = QuerySetCell(CALLER.qServiceLevelFdx, "ServiceLevelDesc", "Fedex 2 Day Freight")>
<cfset newRow  = QueryAddRow(CALLER.qServiceLevelFdx, 1)>
<cfset temp = QuerySetCell(CALLER.qServiceLevelFdx, "ServiceLevelCode", "FEDEX3DAYFREIGHT")>
<cfset temp = QuerySetCell(CALLER.qServiceLevelFdx, "ServiceLevelDesc", "Fedex 3 Day Freight")>
<cfset newRow  = QueryAddRow(CALLER.qServiceLevelFdx, 1)>
<cfset temp = QuerySetCell(CALLER.qServiceLevelFdx, "ServiceLevelCode", "FEDEXGROUND")>
<cfset temp = QuerySetCell(CALLER.qServiceLevelFdx, "ServiceLevelDesc", "Fedex Ground")>
<cfset newRow  = QueryAddRow(CALLER.qServiceLevelFdx, 1)>
<cfset temp = QuerySetCell(CALLER.qServiceLevelFdx, "ServiceLevelCode", "GROUNDHOMEDELIVERY")>
<cfset temp = QuerySetCell(CALLER.qServiceLevelFdx, "ServiceLevelDesc", "Fedex Ground Home Delivery")>
<cfset newRow  = QueryAddRow(CALLER.qServiceLevelFdx, 1)>
<cfset temp = QuerySetCell(CALLER.qServiceLevelFdx, "ServiceLevelCode", "INTERNATIONALPRIORITYFREIGHT")>
<cfset temp = QuerySetCell(CALLER.qServiceLevelFdx, "ServiceLevelDesc", "Fedex International Priority Freight")>
<cfset newRow  = QueryAddRow(CALLER.qServiceLevelFdx, 1)>
<cfset temp = QuerySetCell(CALLER.qServiceLevelFdx, "ServiceLevelCode", "INTERNATIONALECONOMYFREIGHT")>
<cfset temp = QuerySetCell(CALLER.qServiceLevelFdx, "ServiceLevelDesc", "Fedex International Economy Freight")>
<cfset temp = QuerySetCell(CALLER.qServiceLevelFdx, "ServiceLevelCode", "UNKNOWN")>
<cfset temp = QuerySetCell(CALLER.qServiceLevelFdx, "ServiceLevelDesc", "Fedex International Economy / Unknown")>

<cfparam name="ATTRIBUTES.SuppressWhiteSpace" default="True">
	
<cfswitch expression="#ATTRIBUTES.function#">
 
 <cfcase value="RegisterRequest">
  <!--- ***** 2.0 ****** --->
	<cfscript>
	if ( Len(ATTRIBUTES.ShipperStreet2) gte 1 ) {
		line2Indicator = '<Line2>#ATTRIBUTES.ShipperStreet2#</Line2>';
	}
	else {
		line2Indicator = '';
	}
	if ( Len(ATTRIBUTES.ShipperFax) gte 10 ) {
		faxIndicator = '<FaxNumber>#ATTRIBUTES.ShipperFax#</FaxNumber>';
	}
	else {
		faxIndicator = '';
	}
	if ( Len(ATTRIBUTES.ShipperPager) gte 10 ) {
		pagerIndicator = '<PagerNumber>#ATTRIBUTES.ShipperPager#</PagerNumber>';
	}
	else {
		pagerIndicator = '';
	}
	ATTRIBUTES.XMLRequestInput = '<?xml version="#ATTRIBUTES.XMLVersion#" encoding="UTF-8"?>
	<FDXSubscriptionRequest xmlns:api="http://www.fedex.com/fsmapi" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="FDXSubscriptionRequest.xsd">
		<RequestHeader>
			<CustomerTransactionIdentifier>CTIString</CustomerTransactionIdentifier>
			<AccountNumber>#ATTRIBUTES.AccountNumber#</AccountNumber>
		</RequestHeader>
		<Contact>
			<PersonName>#ATTRIBUTES.ShipperContactName#</PersonName>
			<CompanyName>#ATTRIBUTES.ShipperCompany#</CompanyName>
			<Department>#ATTRIBUTES.ShipperDept#</Department>
			<PhoneNumber>#ATTRIBUTES.ShipperPhone#</PhoneNumber>
			#pagerIndicator#
			#faxIndicator#
			<E-MailAddress>#ATTRIBUTES.ShipperEmail#</E-MailAddress>
		</Contact>
		<Address>
			<Line1>#ATTRIBUTES.ShipperStreet#</Line1>
			#line2Indicator#
			<City>#ATTRIBUTES.ShipperCity#</City>
			<StateOrProvinceCode>#ATTRIBUTES.ShipperState#</StateOrProvinceCode>
			<PostalCode>#ATTRIBUTES.ShipperZip#</PostalCode>
			<CountryCode>#ATTRIBUTES.ShipperCountry#</CountryCode>
		</Address>	
	</FDXSubscriptionRequest>';
	
	</cfscript>
	
	<cfhttp method="post" url="#ATTRIBUTES.FedexServer#" resolveurl="yes" port="443" timeout="#ATTRIBUTES.TimeOut#">
		<cfhttpparam name="XML" type="xml" value="#ATTRIBUTES.XMLRequestInput#">
	</cfhttp>
	
	<cfset CALLER.stFedexRegister = XmlParse(Trim(cfhttp.FileContent))>
	 
	 <!--- Debug Mode --->
	<cfif ATTRIBUTES.Debug eq "True">
		<cfoutput>
			<cfdump var="#CALLER.stFedexRegister#">
		</cfoutput>
		<cffile action="WRITE" file="#ATTRIBUTES.ServerFilePath##trailingSlash#Debug#trailingSlash#RegisterRequest.xml" output="#ATTRIBUTES.XMLRequestInput#" addnewline="No" nameconflict="overwrite">
		<cffile action="WRITE" file="#ATTRIBUTES.ServerFilePath##trailingSlash#Debug#trailingSlash#RegisterResponse.xml" output="#cfhttp.FileContent#" addnewline="No" nameconflict="overwrite">
		<cfabort>
	</cfif>
	<!--- Debug Mode --->
	
	<cfif IsDefined("CALLER.stFedexRegister.FDXSubscriptionReply.Error.Code.XmlText")>
		<!--- There was an error get default shipping rate for this service level --->
		<cfset CALLER.FedexError = "1">
		<cfset CALLER.FedexErrorDesc = "#CALLER.stFedexRegister.FDXSubscriptionReply.Error.Message.XmlText#">
	
	<cfelse>
		<cfset CALLER.FedexError = "0">
		<cfset CALLER.FedexErrorDesc = "">

		<cfif IsDefined("CALLER.stFedexRegister.FDXSubscriptionReply.MeterNumber.XmlText")>
			<cfset CALLER.FedexIdentifier = CALLER.stFedexRegister.FDXSubscriptionReply.MeterNumber.XmlText>
			
		<cfelse>
			<!--- Charge not retrieved for some reason set default --->
			<cfset CALLER.FedexError = "2">
			<cfset CALLER.FedexErrorDesc = "Fedex returned a valid response without a valid identifier enclosed, this should never happen?">
		</cfif>
		
	</cfif>
	
 </cfcase>
 
  <cfcase value="RateRequest">
  <!--- ***** 2.0 ****** --->
	<cfif (Len(ATTRIBUTES.AccountNumber) eq 0) OR (Len(ATTRIBUTES.AccountNumber) neq 9)>
		<cfabort showerror="Error: You did not provide a valid 9 digit Fedex Account Number">
	</cfif>
	
	<cfscript>
	if ( (ATTRIBUTES.ServiceLevel eq "FEDEXGROUND" OR ATTRIBUTES.ServiceLevel eq "GROUNDHOMEDELIVERY") ) {
		ATTRIBUTES.RateRequestType = 'FDXG';
	}
	else {
		ATTRIBUTES.RateRequestType = 'FDXE';
	}
	
	// Special Services
	SSOpen = '<SpecialServices>';
	SSClose = '</SpecialServices>';
	
	if ( Len(ATTRIBUTES.SSCodAmount) gt 0 AND Len(ATTRIBUTES.SSCODType) gt 0 ) {
	SSCODIndicator = '<COD>
				<CollectionAmount>#Trim(NumberFormat(ATTRIBUTES.SSCodAmount,"99999999999.99"))#</CollectionAmount>
				<CollectionType>#ATTRIBUTES.SSCODType#</CollectionType>
			</COD>';
	}
	else { SSCODIndicator = ''; }
	
	if ( ATTRIBUTES.RateRequestType eq "FDXE" AND ATTRIBUTES.SSHoldAtLocation eq "1" ) {
	SSHoldAtLocIndicator = '<HoldAtLocation>#ATTRIBUTES.SSHoldAtLocation#</HoldAtLocation>';
	}
	else { SSHoldAtLocIndicator = ''; }
	
	if ( ATTRIBUTES.SSDangerousGoods eq "ACCESSIBLE" OR ATTRIBUTES.SSDangerousGoods eq "INACCESSIBLE" ) {
	SSDangGoodsIndicator = '<DangerousGoods>
		<Accessibility>#ATTRIBUTES.SSDangerousGoods#<Accessibility>
	</DangerousGoods>';
	}
	else { SSDangGoodsIndicator = ''; }
	
	if ( ATTRIBUTES.RateRequestType eq "FDXE" AND ATTRIBUTES.SSDryIce eq "1" ) {
	SSDryIceIndicator = '<DryIce>#ATTRIBUTES.SSDryIce#</DryIce>';
	}
	else { SSDryIceIndicator = ''; }
	
	if ( ATTRIBUTES.SSResDelivery eq "1" ) {
	SSResDelivIndicator = '<ResidentialDelivery>#ATTRIBUTES.SSResDelivery#</ResidentialDelivery>';
	}
	else { SSResDelivIndicator = ''; }
	
	if ( ATTRIBUTES.RateRequestType eq "FDXE" AND ATTRIBUTES.SSInsidePickup eq "1" ) {
	SSInsidePickupIndicator = '<InsidePickup>#ATTRIBUTES.SSInsidePickup#</InsidePickup>';
	}
	else { SSInsidePickupIndicator = ''; }
	
	if ( ATTRIBUTES.RateRequestType eq "FDXE" AND ATTRIBUTES.SSInsideDelivery eq "1" ) {
	SSInsideDeliveryIndicator = '<InsideDelivery>#ATTRIBUTES.SSInsideDelivery#</InsideDelivery>';
	}
	else { SSInsideDeliveryIndicator = ''; }
	
	if ( ATTRIBUTES.RateRequestType eq "FDXE" AND ATTRIBUTES.SSSatPickup eq "1" ) {
	SSSaturdayPickupIndicator = '<SaturdayPickup>#ATTRIBUTES.SSSatPickup#</SaturdayPickup>';
	}
	else { SSSaturdayPickupIndicator = ''; }
	
	if ( ATTRIBUTES.RateRequestType eq "FDXE" AND ATTRIBUTES.SSSatDelivery eq "1" ) {
	SSSaturdayDeliveryIndicator = '<SaturdayDelivery>#ATTRIBUTES.SSSatDelivery#</SaturdayDelivery>';
	}
	else { SSSaturdayDeliveryIndicator = ''; }
	
	if ( ATTRIBUTES.RateRequestType eq "FDXG" AND ATTRIBUTES.SSAOD eq "1" ) {
	SSAODIndicator = '<AOD>#ATTRIBUTES.SSAOD#</AOD>';
	}
	else { SSAODIndicator = ''; }
	
	if ( ATTRIBUTES.RateRequestType eq "FDXG" AND ATTRIBUTES.SSAutoPOD eq "1" ) {
	SSAutoPODIndicator = '<AutoPOD>#ATTRIBUTES.SSAutoPOD#</AutoPOD>';
	}
	else { SSAutoPODIndicator = ''; }
	
	if ( ATTRIBUTES.RateRequestType eq "FDXG" AND ATTRIBUTES.SSNonStdContainer eq "1" ) {
	SSNonStandardContainerIndicator = '<NonStandardContainer>#ATTRIBUTES.SSNonStdContainer#</NonStandardContainer>';
	}
	else { SSNonStandardContainerIndicator = ''; }
	
	if ( Len(SSCODIndicator) neq 0
		OR Len(SSHoldAtLocIndicator) neq 0
		OR Len(SSDangGoodsIndicator) neq 0
		OR Len(SSDryIceIndicator) neq 0
		OR Len(SSResDelivIndicator) neq 0
		OR Len(SSInsidePickupIndicator) neq 0
		OR Len(SSInsideDeliveryIndicator) neq 0
		OR Len(SSSaturdayPickupIndicator) neq 0
		OR Len(SSSaturdayDeliveryIndicator) neq 0
		OR Len(SSAODIndicator) neq 0
		OR Len(SSAutoPODIndicator) neq 0
		OR Len(SSNonStandardContainerIndicator) neq 0 ) {
	
		SSIndicator = '#SSOpen#
			#SSCODIndicator#
			#SSHoldAtLocIndicator#
			#SSDangGoodsIndicator#
			#SSDryIceIndicator#
			#SSResDelivIndicator#
			#SSInsidePickupIndicator#
			#SSInsideDeliveryIndicator#
			#SSSaturdayPickupIndicator#
			#SSSaturdayDeliveryIndicator#
			#SSAODIndicator#
			#SSAutoPODIndicator#
			#SSNonStandardContainerIndicator#
		#SSClose#';
	}
	else {
		SSIndicator = '';
	}
	
	// Home Delivery
	if ( ATTRIBUTES.RateRequestType eq "FDXG" AND 
		( ATTRIBUTES.HomeDeliveryType eq "DATECERTAIN" OR ATTRIBUTES.HomeDeliveryType eq "EVENING" OR ATTRIBUTES.HomeDeliveryType eq "APPOINTMENT" )
	   ) 
	{
		HomeDeliveryIndicator = '<HomeDelivery>
			<Type>#ATTRIBUTES.HomeDeliveryType#</Type>
			<SignatureRequired>#ATTRIBUTES.HomeDeliverySigRequired#</SignatureRequired>
		</HomeDelivery>';
	}
	else { HomeDeliveryIndicator = ''; }
	
	if ( ATTRIBUTES.RateRequestType eq "FDXE" AND ATTRIBUTES.UseCustomerBroker eq 1 ) {
		IntlBrokerIndicator = '<International>
			<BrokerSelectOption>#ATTRIBUTES.UseCustomerBroker#</BrokerSelectOption>
		</International>';
	}
	else { IntlBrokerIndicator = ''; }
	
	VariableHandlingChargesIndicator = '';
	// <VariableHandlingCharges></VariableHandlingCharges>
	
	ATTRIBUTES.XMLRequestInput = '<?xml version="#ATTRIBUTES.XMLVersion#" encoding="UTF-8"?>
	<FDXRateRequest xmlns:api="http://www.fedex.com/fsmapi" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="FDXRateRequest.xsd">
		<RequestHeader>
			<CustomerTransactionIdentifier>AP_Fedex_Rate_Request</CustomerTransactionIdentifier>
			<MeterNumber>#ATTRIBUTES.FedexIndentifier#</MeterNumber>
			<AccountNumber>#ATTRIBUTES.AccountNumber#</AccountNumber>
			<CarrierCode>#ATTRIBUTES.RateRequestType#</CarrierCode>
		</RequestHeader>
		<ShipDate>#ATTRIBUTES.PickupDate#</ShipDate>
		<DropoffType>#ATTRIBUTES.DropOffType#</DropoffType>
		<Service>#ATTRIBUTES.ServiceLevel#</Service>
		<Packaging>#ATTRIBUTES.Packaging#</Packaging>
		<WeightUnits>#ATTRIBUTES.PackageWeightUnit#</WeightUnits>
		<Weight>#ATTRIBUTES.PackageWeight#</Weight>
		<ListRate>#ATTRIBUTES.RequestListRates#</ListRate>
		<OriginAddress>
			<StateOrProvinceCode>#ATTRIBUTES.ShipperState#</StateOrProvinceCode>
			<PostalCode>#ATTRIBUTES.ShipperZip#</PostalCode>
			<CountryCode>#ATTRIBUTES.ShipperCountry#</CountryCode>
		</OriginAddress>
		<DestinationAddress>
			<StateOrProvinceCode>#ATTRIBUTES.ShipToState#</StateOrProvinceCode>
			<PostalCode>#ATTRIBUTES.ShipToZip#</PostalCode>
			<CountryCode>#ATTRIBUTES.ShipToCountry#</CountryCode>
		</DestinationAddress>
		<Payment>
			<PayorType>#UCase(ATTRIBUTES.PayorType)#</PayorType>
		</Payment>
		<Dimensions>
			<Length>#ATTRIBUTES.PackageLength#</Length>
			<Width>#ATTRIBUTES.PackageWidth#</Width>
			<Height>#ATTRIBUTES.PackageHeight#</Height>
			<Units>#ATTRIBUTES.PackageUnitOfMeasurement#</Units>
		</Dimensions>
		<DeclaredValue>
			<Value>#Trim(NumberFormat(ATTRIBUTES.DeclaredValue,"99999.99"))#</Value>
			<CurrencyCode>#UCase(ATTRIBUTES.CurrencyCode)#</CurrencyCode>
		</DeclaredValue>
		#SSIndicator#
		#HomeDeliveryIndicator#
		#VariableHandlingChargesIndicator#
		#IntlBrokerIndicator#
		<PackageCount>#ATTRIBUTES.PackageCount#</PackageCount>
	</FDXRateRequest>';
	
	</cfscript>

	<cfhttp method="post" url="#ATTRIBUTES.FedexServer#" resolveurl="yes" port="443" timeout="#ATTRIBUTES.TimeOut#">
		<cfhttpparam name="XML" type="xml" value="#ATTRIBUTES.XMLRequestInput#">
	</cfhttp>
	
	<!--- Debug Mode --->
	<cfif ATTRIBUTES.Debug eq "True">
		<cffile action="WRITE" file="#ATTRIBUTES.ServerFilePath##trailingSlash#Debug#trailingSlash#RateRequest.xml" output="#ATTRIBUTES.XMLRequestInput#" addnewline="No" nameconflict="overwrite">
		<cffile action="WRITE" file="#ATTRIBUTES.ServerFilePath##trailingSlash#Debug#trailingSlash#RateResponse.xml" output="#cfhttp.FileContent#" addnewline="No" nameconflict="overwrite">
			<cfset CALLER.stFedexRate = XmlParse(Trim(cfhttp.FileContent))>
			<cfoutput>
				<cfdump var="#CALLER.stFedexRate#">
			</cfoutput>
		<cfabort>
	</cfif>
	<!--- Debug Mode --->
	
	<cfset CALLER.stFedexRate = XmlParse(Trim(cfhttp.FileContent))>
	
	<cfif IsDefined("CALLER.stFedexRate.FDXRateReply.Error.Code.XmlText")>
		<!--- There was an error get default shipping rate for this service level --->
		<cfset CALLER.FedexError = "1">
		<cfset CALLER.FedexErrorDesc = "#CALLER.stFedexRate.FDXRateReply.Error.Message.XmlText#">
	
	<cfelse>
		<!--- 
		** Need to account for different elements returned based on Express, Ground request **
		FDXE
		FDXG
		ALL
		 --->
		 
		<cfset CALLER.FedexError = "0">
		<cfset CALLER.FedexErrorDesc = "Success">
		<cfset CALLER.qFedexRateQuery = QueryNew("DimWeightUsed, Oversize, RateScale, RateZone, CurrencyCode, BilledWeight, DimWeight, 
		DiscBaseFreightCharges, DiscDiscountAmt, DiscNetTotalCharge, DiscBaseTotalCharges, DiscTotalRebate, DiscSurchargeCOD, DiscSurchargeSatPickup, DiscSurchargeDV, DiscSurchargeAOD, DiscSurchargeAD, DiscSurchargeAutoPOD,
			DiscSurchargeHomeDelivery, DiscSurchargeHomeDeliveryDC, DiscSurchargeHomeDeliveryEvening, DiscSurchargeHomeDeliverySig,
			DiscSurchargeNonStd, DiscSurchargeHazMat, DiscSurchargeRes, DiscSurchargeVAT, DiscSurchargeHST, DiscSurchargeGST, DiscSurchargePST,
			DiscSurchargeSatDeliv, DiscSurchargeDG, DiscSurchargeOutOfPickupArea, DiscSurchargeOutOfDeliveryArea, DiscSurchargeInsidePickup, DiscSurchargeInsideDeliv,
			DiscSurchargePryAlert, DiscSurchargeDelivArea, DiscSurchargeFuel, DiscSurchargeFICE, DiscSurchargeOffshore, DiscSurchargeOther, DiscSurchargeTotal, 
		ListBaseFreightCharges, ListDiscountAmt, ListNetTotalCharge, ListTotalRebate, ListSurchargeCOD, ListSurchargeSatPickup, ListSurchargeDV, ListSurchargeAOD, ListSurchargeAD, ListSurchargeAutoPOD,
			ListSurchargeHomeDelivery, ListSurchargeHomeDeliveryDC, ListSurchargeHomeDeliveryEvening, ListSurchargeHomeDeliverySig,
			ListSurchargeNonStd, ListSurchargeHazMat, ListSurchargeRes, ListSurchargeVAT, ListSurchargeHST, ListSurchargeGST, ListSurchargePST,
			ListSurchargeSatDeliv, ListSurchargeDG, ListSurchargeOutOfPickupArea, ListSurchargeOutOfDeliveryArea, ListSurchargeInsidePickup, ListSurchargeInsideDeliv,
			ListSurchargePryAlert, ListSurchargeDelivArea, ListSurchargeFuel, ListSurchargeFICE, ListSurchargeOffshore, ListSurchargeOther, ListSurchargeTotal,
			VariableHandling, ListVariableHandlingCharge, TotalCustomerCharge, ListTotalCustomerCharge, MultiweightVariableHandlingCharge, MultiweightTotalCustomerCharge")>
		<cfset newRow  = QueryAddRow(CALLER.qFedexRateQuery, 1)>
		
		<!--- ** Inner CP1 ** Check for existence of estimated charges element --->
		<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply, "EstimatedCharges")>

			<!--- FDXE Only --->
			<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges, "DimWeightUsed")>
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DimWeightUsed", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DimWeightUsed.XmlText, 1)>
			<cfelse>
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DimWeightUsed", "", 1)>				
			</cfif>
			<!--- FDXG Only --->
			<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges, "Oversize")>
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "Oversize", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.Oversize.XmlText, 1)>
			<cfelse>
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "Oversize", "", 1)>				
			</cfif>
			<!--- FDXE Only --->
			<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges, "RateScale")>
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "RateScale", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.RateScale.XmlText, 1)>
			<cfelse>
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "RateScale", "", 1)>				
			</cfif>
			<!--- FDXE Only --->
			<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges, "RateZone")>
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "RateZone", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.RateZone.XmlText, 1)>
			<cfelse>
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "RateZone", "", 1)>				
			</cfif>
			<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges, "CurrencyCode")>
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "CurrencyCode", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.CurrencyCode.XmlText, 1)>
			<cfelse>
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "CurrencyCode", "", 1)>				
			</cfif>
			<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges, "BilledWeight")>
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "BilledWeight", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.BilledWeight.XmlText, 1)>
			<cfelse>
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "BilledWeight", "", 1)>				
			</cfif>
			
			<!--- Discount Charges element - present in both FDXE and FDXG requests, for FDXG request this is only node returned --->
			<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges, "DiscountedCharges")>
				<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges, "BaseCharge")>
					<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscBaseFreightCharges", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.BaseCharge.XmlText, 1)>
					<cfset nBaseCharge = CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.BaseCharge.XmlText>
				<cfelse>
					<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscBaseFreightCharges", "0", 1)>				
					<cfset nBaseCharge = 0>
				</cfif>
				<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges, "TotalDiscount")>
					<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscDiscountAmt", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.TotalDiscount.XmlText, 1)>
				<cfelse>
					<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscDiscountAmt", "0", 1)>				
				</cfif>
				<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges, "NetCharge")>
					<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscNetTotalCharge", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.NetCharge.XmlText, 1)>
				<cfelse>
					<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscNetTotalCharge", "0", 1)>				
				</cfif>
				<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges, "TotalRebate")>
					<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscTotalRebate", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.TotalRebate.XmlText, 1)>
				<cfelse>
					<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscTotalRebate", "", 1)>				
				</cfif>
				<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges, "TotalSurcharge")>
					<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeTotal", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.TotalSurcharge.XmlText, 1)>
					<cfset nBaseSurCharge = CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.TotalSurcharge.XmlText>
				<cfelse>
					<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeTotal", "0", 1)>
					<cfset nBaseSurCharge = 0>		
				</cfif>
					<cfset nTotalCharge = nBaseCharge + nBaseSurCharge>
					<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscBaseTotalCharges", nTotalCharge, 1)>
					
				<!--- Anyone for a surcharge or 10 or 100!! --->
				<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges, "Surcharges")>
					<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges, "COD")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeCOD", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges.COD.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeCOD", "", 1)>				
					</cfif>
					<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges, "SaturdayPickup")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeSatPickup", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges.SaturdayPickup.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeSatPickup", "", 1)>				
					</cfif>
					<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges, "DeclaredValue")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeDV", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges.DeclaredValue.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeDV", "", 1)>				
					</cfif>
					<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges, "AOD")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeAOD", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges.AOD.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeAOD", "", 1)>				
					</cfif>
					<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges, "AppointmentDelivery")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeAD", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges.AppointmentDelivery.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeAD", "", 1)>				
					</cfif>
					<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges, "AutoPOD")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeAutoPOD", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges.AutoPOD.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeAutoPOD", "", 1)>				
					</cfif>
					<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges, "HomeDelivery")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeHomeDelivery", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges.HomeDelivery.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeHomeDelivery", "", 1)>				
					</cfif>
					<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges, "HomeDeliveryDateCertain")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeHomeDeliveryDC", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges.HomeDeliveryDateCertain.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeHomeDeliveryDC", "", 1)>				
					</cfif>
					<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges, "HomeDeliveryEveningDelivery")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeHomeDeliveryEvening", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges.HomeDeliveryEveningDelivery.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeHomeDeliveryEvening", "", 1)>				
					</cfif>
					<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges, "HomeDeliverySignature")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeHomeDeliverySig", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges.HomeDeliverySignature.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeHomeDeliverySig", "", 1)>				
					</cfif>
					<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges, "NonStandardContainer")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeNonStd", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges.NonStandardContainer.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeNonStd", "", 1)>				
					</cfif>
					<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges, "HazardousMaterials")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeHazMat", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges.HazardousMaterials.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeHazMat", "", 1)>				
					</cfif>
					<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges, "Residential")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeRes", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges.Residential.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeRes", "", 1)>				
					</cfif>
					<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges, "VAT")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeVAT", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges.VAT.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeVAT", "", 1)>				
					</cfif>
					<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges, "HSTSurcharge")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeHST", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges.HSTSurcharge.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeHST", "", 1)>				
					</cfif>
					<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges, "GSTSurcharge")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeGST", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges.GSTSurcharge.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeGST", "", 1)>				
					</cfif>
					<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges, "PSTSurcharge")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargePST", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges.PSTSurcharge.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargePST", "", 1)>				
					</cfif>
					<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges, "SaturdayDelivery")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeSatDeliv", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges.SaturdayDelivery.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeSatDeliv", "", 1)>				
					</cfif>
					<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges, "DangerousGoods")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeDG", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges.DangerousGoods.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeDG", "", 1)>				
					</cfif>
					<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges, "OutOfPickupOrH3Area")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeOutOfPickupArea", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges.OutOfPickupOrH3Area.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeOutOfPickupArea", "", 1)>				
					</cfif>
					<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges, "OutOfDeliveryOrH3Area")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeOutOfDeliveryArea", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges.OutOfDeliveryOrH3Area.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeOutOfDeliveryArea", "", 1)>				
					</cfif>
					<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges, "InsidePickup")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeInsidePickup", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges.InsidePickup.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeInsidePickup", "", 1)>				
					</cfif>
					<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges, "InsideDelivery")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeInsideDeliv", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges.InsideDelivery.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeInsideDeliv", "", 1)>				
					</cfif>
					<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges, "PriorityAlert")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargePryAlert", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges.PriorityAlert.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargePryAlert", "", 1)>				
					</cfif>
					<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges, "DeliveryArea")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeDelivArea", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges.DeliveryArea.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeDelivArea", "", 1)>				
					</cfif>
					<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges, "Fuel")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeFuel", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges.Fuel.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeFuel", "", 1)>				
					</cfif>
					<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges, "FICE")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeFICE", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges.FICE.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeFICE", "", 1)>				
					</cfif>
					<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges, "Offshore")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeOffshore", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges.Offshore.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeOffshore", "", 1)>				
					</cfif>
					<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges, "Other")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeOther", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.DiscountedCharges.Surcharges.Other.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeOther", "", 1)>				
					</cfif>
				</cfif>
				<!--- Anyone for a surcharge or 10 or 100!! CLOSE --->
				
			<cfelse>
				<!--- Discount charges element unavailable - this should not be possible as this is primary charges node --->
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscBaseFreightCharges", "", 1)>
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscDiscountAmt", "", 1)>				
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscNetTotalCharge", "", 1)>				
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscTotalRebate", "", 1)>			
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeCOD", "", 1)>				
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeSatPickup", "", 1)>				
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeDV", "", 1)>				
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeAOD", "", 1)>				
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeAD", "", 1)>				
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeAutoPOD", "", 1)>				
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeHomeDelivery", "", 1)>				
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeHomeDeliveryDC", "", 1)>				
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeHomeDeliveryEvening", "", 1)>				
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeHomeDeliverySig", "", 1)>				
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeNonStd", "", 1)>				
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeHazMat", "", 1)>				
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeRes", "", 1)>				
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeVAT", "", 1)>				
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeHST", "", 1)>				
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeGST", "", 1)>				
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargePST", "", 1)>				
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeDG", "", 1)>				
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeOutOfPickupArea", "", 1)>				
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeOutOfDeliveryArea", "", 1)>				
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeInsidePickup", "", 1)>				
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeInsideDeliv", "", 1)>				
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeDelivArea", "", 1)>				
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeFuel", "", 1)>				
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeFICE", "", 1)>				
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeOffshore", "", 1)>				
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeTotal", "", 1)>
			</cfif>
			<!--- Discount Charges element - CLOSE --->
			
			<!--- List Charges element --->
			<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges, "ListCharges")>
				<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges, "BaseCharge")>
					<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListBaseFreightCharges", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.BaseCharge.XmlText, 1)>
				<cfelse>
					<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListBaseFreightCharges", "", 1)>				
				</cfif>
				<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges, "TotalDiscount")>
					<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListDiscountAmt", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.TotalDiscount.XmlText, 1)>
				<cfelse>
					<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListDiscountAmt", "", 1)>				
				</cfif>
				<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges, "NetCharge")>
					<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListNetTotalCharge", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.NetCharge.XmlText, 1)>
				<cfelse>
					<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListNetTotalCharge", "", 1)>				
				</cfif>
				<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges, "TotalRebate")>
					<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListTotalRebate", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.TotalRebate.XmlText, 1)>
				<cfelse>
					<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListTotalRebate", "", 1)>				
				</cfif>
				<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges, "TotalSurcharge")>
					<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeTotal", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.TotalSurcharge.XmlText, 1)>
				<cfelse>
					<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeTotal", "", 1)>				
				</cfif>
				<!--- Anyone for a surcharge or 10 or 100!! --->
				<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges, "Surcharges")>
					<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges, "COD")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeCOD", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges.COD.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeCOD", "", 1)>				
					</cfif>
					<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges, "SaturdayPickup")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeSatPickup", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges.SaturdayPickup.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeSatPickup", "", 1)>				
					</cfif>
					<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges, "DeclaredValue")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeDV", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges.DeclaredValue.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeDV", "", 1)>				
					</cfif>
					<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges, "AOD")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeAOD", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges.AOD.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeAOD", "", 1)>				
					</cfif>
					<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges, "AppointmentDelivery")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeAD", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges.AppointmentDelivery.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeAD", "", 1)>				
					</cfif>
					<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges, "AutoPOD")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeAutoPOD", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges.AutoPOD.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeAutoPOD", "", 1)>				
					</cfif>
					<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges, "HomeDelivery")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeHomeDelivery", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges.HomeDelivery.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeHomeDelivery", "", 1)>				
					</cfif>
					<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges, "HomeDeliveryDateCertain")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeHomeDeliveryDC", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges.HomeDeliveryDateCertain.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeHomeDeliveryDC", "", 1)>				
					</cfif>
					<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges, "HomeDeliveryEveningDelivery")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeHomeDeliveryEvening", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges.HomeDeliveryEveningDelivery.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeHomeDeliveryEvening", "", 1)>				
					</cfif>
					<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges, "HomeDeliverySignature")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeHomeDeliverySig", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges.HomeDeliverySignature.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeHomeDeliverySig", "", 1)>				
					</cfif>
					<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges, "NonStandardContainer")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeNonStd", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges.NonStandardContainer.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeNonStd", "", 1)>				
					</cfif>
					<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges, "HazardousMaterials")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeHazMat", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges.HazardousMaterials.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeHazMat", "", 1)>				
					</cfif>
					<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges, "Residential")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeRes", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges.Residential.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeRes", "", 1)>				
					</cfif>
					<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges, "VAT")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeVAT", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges.VAT.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeVAT", "", 1)>				
					</cfif>
					<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges, "HSTSurcharge")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeHST", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges.HSTSurcharge.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeHST", "", 1)>				
					</cfif>
					<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges, "GSTSurcharge")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeGST", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges.GSTSurcharge.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeGST", "", 1)>				
					</cfif>
					<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges, "PSTSurcharge")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargePST", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges.PSTSurcharge.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargePST", "", 1)>				
					</cfif>
					<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges, "SaturdayDelivery")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeSatDeliv", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges.SaturdayDelivery.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeSatDeliv", "", 1)>				
					</cfif>
					<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges, "DangerousGoods")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeDG", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges.DangerousGoods.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeDG", "", 1)>				
					</cfif>
					<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges, "OutOfPickupOrH3Area")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeOutOfPickupArea", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges.OutOfPickupOrH3Area.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeOutOfPickupArea", "", 1)>				
					</cfif>
					<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges, "OutOfDeliveryOrH3Area")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeOutOfDeliveryArea", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges.OutOfDeliveryOrH3Area.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeOutOfDeliveryArea", "", 1)>				
					</cfif>
					<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges, "InsidePickup")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeInsidePickup", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges.InsidePickup.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeInsidePickup", "", 1)>				
					</cfif>
					<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges, "InsideDelivery")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeInsideDeliv", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges.InsideDelivery.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeInsideDeliv", "", 1)>				
					</cfif>
					<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges, "PriorityAlert")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargePryAlert", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges.PriorityAlert.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargePryAlert", "", 1)>				
					</cfif>
					<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges, "DeliveryArea")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeDelivArea", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges.DeliveryArea.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeDelivArea", "", 1)>				
					</cfif>
					<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges, "Fuel")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeFuel", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges.Fuel.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeFuel", "", 1)>				
					</cfif>
					<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges, "FICE")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeFICE", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges.FICE.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeFICE", "", 1)>				
					</cfif>
					<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges, "Offshore")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeOffshore", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges.Offshore.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeOffshore", "", 1)>				
					</cfif>
					<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges, "Other")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeOther", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.ListCharges.Surcharges.Other.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeOther", "", 1)>				
					</cfif>
				</cfif>
			
			<cfelse>
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListBaseFreightCharges", "", 1)>
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListDiscountAmt", "", 1)>				
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListNetTotalCharge", "", 1)>				
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListTotalRebate", "", 1)>				
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeCOD", "", 1)>				
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeSatPickup", "", 1)>				
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeDV", "", 1)>				
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeAOD", "", 1)>				
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeAD", "", 1)>				
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeAutoPOD", "", 1)>				
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeHomeDelivery", "", 1)>				
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeHomeDeliveryDC", "", 1)>				
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeHomeDeliveryEvening", "", 1)>				
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeHomeDeliverySig", "", 1)>				
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeNonStd", "", 1)>				
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeHazMat", "", 1)>				
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeRes", "", 1)>				
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeVAT", "", 1)>				
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeHST", "", 1)>				
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeGST", "", 1)>				
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargePST", "", 1)>				
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeDG", "", 1)>				
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeOutOfPickupArea", "", 1)>				
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeOutOfDeliveryArea", "", 1)>				
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeInsidePickup", "", 1)>				
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeInsideDeliv", "", 1)>				
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeDelivArea", "", 1)>				
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeFuel", "", 1)>				
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeFICE", "", 1)>				
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeOffshore", "", 1)>				
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeTotal", "", 1)>
			</cfif>
			<!--- List Charges element - CLOSE --->
			
			<!--- Variable Handling Elements --->
			<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges, "VariableHandling")>
				<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.VariableHandling, "VariableHandlingCharge")>
					<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "VariableHandling", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.VariableHandling.VariableHandlingCharge.XmlText, 1)>
				<cfelse>
					<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "VariableHandling", "", 1)>
				</cfif>
				<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.VariableHandling, "ListVariableHandlingCharge")>
					<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListVariableHandlingCharge", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.VariableHandling.ListVariableHandlingCharge.XmlText, 1)>
				<cfelse>
					<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListVariableHandlingCharge", "", 1)>
				</cfif>
				<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.VariableHandling, "TotalCustomerCharge")>
					<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "TotalCustomerCharge", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.VariableHandling.TotalCustomerCharge.XmlText, 1)>
				<cfelse>
					<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "TotalCustomerCharge", "", 1)>
				</cfif>
				<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.VariableHandling, "ListTotalCustomerCharge")>
					<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListTotalCustomerCharge", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.VariableHandling.ListTotalCustomerCharge.XmlText, 1)>
				<cfelse>
					<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListTotalCustomerCharge", "", 1)>
				</cfif>
				<!--- FDXG Only --->
				<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.VariableHandling, "MultiweightVariableHandlingCharge")>
					<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "MultiweightVariableHandlingCharge", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.VariableHandling.MultiweightVariableHandlingCharge.XmlText, 1)>
				<cfelse>
					<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "MultiweightVariableHandlingCharge", "", 1)>
				</cfif>
				<!--- FDXG Only --->
				<cfif StructKeyExists(CALLER.stFedexRate.FDXRateReply.EstimatedCharges.VariableHandling, "MultiweightTotalCustomerCharge")>
					<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "MultiweightTotalCustomerCharge", CALLER.stFedexRate.FDXRateReply.EstimatedCharges.VariableHandling.MultiweightTotalCustomerCharge.XmlText, 1)>
				<cfelse>
					<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "MultiweightTotalCustomerCharge", "", 1)>
				</cfif>
			<cfelse>
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "VariableHandling", "", 1)>
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListVariableHandlingCharge", "", 1)>
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "TotalCustomerCharge", "", 1)>
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListTotalCustomerCharge", "", 1)>
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "MultiweightVariableHandlingCharge", "", 1)>
				<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "MultiweightTotalCustomerCharge", "", 1)>
			</cfif>
			<!--- Variable Handling Elements CLOSE --->
			
		<cfelse> 
		<!--- ** Inner CP1 ** Check for existence of estimated charges element not successful --->
			<!--- Charge not retrieved for some reason set empty columns --->
			<cfset CALLER.FedexError = "2">
			<cfset CALLER.FedexErrorDesc = "Fedex returned a valid response without a base rate">
		</cfif>
		<!--- ** Inner CP1 ** Check for existence of estimated charges element close --->

		
	</cfif>
	
 </cfcase>
 <!--- End Fedex XML rate Request --->
 
 <!---  Fedex Available services request --->
 <cfcase value="ServicesAvailRequest">
  <!--- ***** 2.0 ****** --->
	
	<cfscript>
	if ( IsDefined("ATTRIBUTES.PackageCount") AND ATTRIBUTES.PackageCount gt 1 ) { 
		ATTRIBUTES.PackageCount = 1;
	}
	
	// Special Services
	SSOpen = '<SpecialServices>';
	SSClose = '</SpecialServices>';
	
	if ( Len(ATTRIBUTES.SSCodAmount) gt 0 AND Len(ATTRIBUTES.SSCODType) gt 0 ) {
	SSCODIndicator = '<COD>
				<CollectionAmount>#Trim(NumberFormat(ATTRIBUTES.SSCodAmount,"99999999999.99"))#</CollectionAmount>
				<CollectionType>#ATTRIBUTES.SSCODType#</CollectionType>
			</COD>';
	}
	else { SSCODIndicator = ''; }
	
	if ( ATTRIBUTES.RateRequestType eq "FDXE" AND ATTRIBUTES.SSHoldAtLocation eq "1" ) {
	SSHoldAtLocIndicator = '<HoldAtLocation>#ATTRIBUTES.SSHoldAtLocation#</HoldAtLocation>';
	}
	else { SSHoldAtLocIndicator = ''; }
	
	if ( ATTRIBUTES.SSDangerousGoods eq "ACCESSIBLE" OR ATTRIBUTES.SSDangerousGoods eq "INACCESSIBLE" ) {
	SSDangGoodsIndicator = '<DangerousGoods>
		<Accessibility>#ATTRIBUTES.SSDangerousGoods#<Accessibility>
	</DangerousGoods>';
	}
	else { SSDangGoodsIndicator = ''; }
	
	if ( ATTRIBUTES.RateRequestType eq "FDXE" AND ATTRIBUTES.SSDryIce eq "1" ) {
	SSDryIceIndicator = '<DryIce>#ATTRIBUTES.SSDryIce#</DryIce>';
	}
	else { SSDryIceIndicator = ''; }
	
	if ( ATTRIBUTES.SSResDelivery eq "1" ) {
	SSResDelivIndicator = '<ResidentialDelivery>#ATTRIBUTES.SSResDelivery#</ResidentialDelivery>';
	}
	else { SSResDelivIndicator = ''; }
	
	if ( ATTRIBUTES.RateRequestType eq "FDXE" AND ATTRIBUTES.SSInsidePickup eq "1" ) {
	SSInsidePickupIndicator = '<InsidePickup>#ATTRIBUTES.SSInsidePickup#</InsidePickup>';
	}
	else { SSInsidePickupIndicator = ''; }
	
	if ( ATTRIBUTES.RateRequestType eq "FDXE" AND ATTRIBUTES.SSInsideDelivery eq "1" ) {
	SSInsideDeliveryIndicator = '<InsideDelivery>#ATTRIBUTES.SSInsideDelivery#</InsideDelivery>';
	}
	else { SSInsideDeliveryIndicator = ''; }
	
	if ( ATTRIBUTES.RateRequestType eq "FDXE" AND ATTRIBUTES.SSSatPickup eq "1" ) {
	SSSaturdayPickupIndicator = '<SaturdayPickup>#ATTRIBUTES.SSSatPickup#</SaturdayPickup>';
	}
	else { SSSaturdayPickupIndicator = ''; }
	
	if ( ATTRIBUTES.RateRequestType eq "FDXE" AND ATTRIBUTES.SSSatDelivery eq "1" ) {
	SSSaturdayDeliveryIndicator = '<SaturdayDelivery>#ATTRIBUTES.SSSatDelivery#</SaturdayDelivery>';
	}
	else { SSSaturdayDeliveryIndicator = ''; }
	
	if ( ATTRIBUTES.RateRequestType eq "FDXG" AND ATTRIBUTES.SSAOD eq "1" ) {
	SSAODIndicator = '<AOD>#ATTRIBUTES.SSAOD#</AOD>';
	}
	else { SSAODIndicator = ''; }
	
	if ( ATTRIBUTES.RateRequestType eq "FDXG" AND ATTRIBUTES.SSAutoPOD eq "1" ) {
	SSAutoPODIndicator = '<AutoPOD>#ATTRIBUTES.SSAutoPOD#</AutoPOD>';
	}
	else { SSAutoPODIndicator = ''; }
	
	if ( ATTRIBUTES.RateRequestType eq "FDXG" AND ATTRIBUTES.SSNonStdContainer eq "1" ) {
	SSNonStandardContainerIndicator = '<NonStandardContainer>#ATTRIBUTES.SSNonStdContainer#</NonStandardContainer>';
	}
	else { SSNonStandardContainerIndicator = ''; }
	
	if ( Len(SSCODIndicator) neq 0
		OR Len(SSHoldAtLocIndicator) neq 0
		OR Len(SSDangGoodsIndicator) neq 0
		OR Len(SSDryIceIndicator) neq 0
		OR Len(SSResDelivIndicator) neq 0
		OR Len(SSInsidePickupIndicator) neq 0
		OR Len(SSInsideDeliveryIndicator) neq 0
		OR Len(SSSaturdayPickupIndicator) neq 0
		OR Len(SSSaturdayDeliveryIndicator) neq 0
		OR Len(SSAODIndicator) neq 0
		OR Len(SSAutoPODIndicator) neq 0
		OR Len(SSNonStandardContainerIndicator) neq 0 ) {
	
		SSIndicator = '#SSOpen#
			#SSCODIndicator#
			#SSHoldAtLocIndicator#
			#SSDangGoodsIndicator#
			#SSDryIceIndicator#
			#SSResDelivIndicator#
			#SSInsidePickupIndicator#
			#SSInsideDeliveryIndicator#
			#SSSaturdayPickupIndicator#
			#SSSaturdayDeliveryIndicator#
			#SSAODIndicator#
			#SSAutoPODIndicator#
			#SSNonStandardContainerIndicator#
		#SSClose#';
	}
	else {
		SSIndicator = '';
	}
	
	// Home Delivery
	if ( ATTRIBUTES.RateRequestType eq "FDXG" AND 
		( ATTRIBUTES.HomeDeliveryType eq "DATECERTAIN" OR ATTRIBUTES.HomeDeliveryType eq "EVENING" OR ATTRIBUTES.HomeDeliveryType eq "APPOINTMENT" )
	   ) 
	{
		HomeDeliveryIndicator = '<HomeDelivery>
			<Type>#ATTRIBUTES.HomeDeliveryType#</Type>
			<SignatureRequired>#ATTRIBUTES.HomeDeliverySigRequired#</SignatureRequired>
		</HomeDelivery>';
	}
	else { HomeDeliveryIndicator = ''; }
	
	// Request List Rates can only be requested with domestic
	if ( ATTRIBUTES.ShipToCountry neq "US" ) {
		ATTRIBUTES.RequestListRates = 0;
	}
	else if ( Len(ATTRIBUTES.RequestListRates) eq 0 AND ATTRIBUTES.ShipToCountry eq "US" ) {
		ATTRIBUTES.RequestListRates = 1;
	}

	</cfscript>
	<cfparam name="ATTRIBUTES.pickupDate" default="#pickupDate#">
	
	<cfscript>
	
	ATTRIBUTES.XMLRequestInput = '<?xml version="#ATTRIBUTES.XMLVersion#" encoding="UTF-8"?>
	<FDXRateAvailableServicesRequest xmlns:api="http://www.fedex.com/fsmapi" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="FDXRateAvailableServicesRequest.xsd">
		<RequestHeader>
			<CustomerTransactionIdentifier>CTIString</CustomerTransactionIdentifier>
			<MeterNumber>#ATTRIBUTES.FedexIndentifier#</MeterNumber>
			<AccountNumber>#ATTRIBUTES.AccountNumber#</AccountNumber>
			<CarrierCode>#ATTRIBUTES.RateRequestType#</CarrierCode>
		</RequestHeader>
		<ShipDate>#ATTRIBUTES.PickupDate#</ShipDate>
		<DropoffType>REGULARPICKUP</DropoffType>
		<Packaging>#ATTRIBUTES.Packaging#</Packaging>
		<WeightUnits>#ATTRIBUTES.PackageWeightUnit#</WeightUnits>
		<Weight>#ATTRIBUTES.PackageWeight#</Weight>
		<ListRate>#ATTRIBUTES.RequestListRates#</ListRate>
		<OriginAddress>
			<StateOrProvinceCode>#ATTRIBUTES.ShipperState#</StateOrProvinceCode>
			<PostalCode>#ATTRIBUTES.ShipperZip#</PostalCode>
			<CountryCode>#ATTRIBUTES.ShipperCountry#</CountryCode>
		</OriginAddress>
		<DestinationAddress>
			<StateOrProvinceCode>#ATTRIBUTES.ShipToState#</StateOrProvinceCode>
			<PostalCode>#ATTRIBUTES.ShipToZip#</PostalCode>
			<CountryCode>#ATTRIBUTES.ShipToCountry#</CountryCode>
		</DestinationAddress>
		<Payment>
			<PayorType>#UCase(ATTRIBUTES.PayorType)#</PayorType>
		</Payment>
		<Dimension>
			<Length>#ATTRIBUTES.PackageLength#</Length>
			<Width>#ATTRIBUTES.PackageWidth#</Width>
			<Height>#ATTRIBUTES.PackageHeight#</Height>
			<Units>#ATTRIBUTES.PackageUnitOfMeasurement#</Units>
		</Dimension>
		<DeclaredValue>
			<Value>#Trim(NumberFormat(ATTRIBUTES.DeclaredValue,"99999.99"))#</Value>
			<CurrencyCode>#UCase(ATTRIBUTES.CurrencyCode)#</CurrencyCode>
		</DeclaredValue>
		#SSIndicator#
		#HomeDeliveryIndicator#
		<PackageCount>#ATTRIBUTES.PackageCount#</PackageCount>
	</FDXRateAvailableServicesRequest>';
	</cfscript>
	
	<cfhttp method="post" url="#ATTRIBUTES.FedexServer#" resolveurl="yes" port="443" timeout="#ATTRIBUTES.TimeOut#">
		<cfhttpparam name="XML" type="xml" value="#ATTRIBUTES.XMLRequestInput#">
	</cfhttp>
	
	<cfset CALLER.stFedexAvailableServices = XmlParse(Trim(cfhttp.FileContent))>
	
	<!--- Debug Mode --->
	<cfif ATTRIBUTES.Debug eq "True">
		<cfoutput>
			<cfdump var="#CALLER.stFedexAvailableServices#">
		</cfoutput>
		<cffile action="WRITE" file="#ATTRIBUTES.ServerFilePath#\Debug\ServicesAvailableRequest.xml" output="#ATTRIBUTES.XMLRequestInput#" addnewline="No" nameconflict="overwrite">
		<cffile action="WRITE" file="#ATTRIBUTES.ServerFilePath#\Debug\ServicesAvailableResponse.xml" output="#cfhttp.FileContent#" addnewline="No" nameconflict="overwrite">
		<cfabort>
	</cfif>
	<!--- Debug Mode --->
	
	<cfif IsDefined("CALLER.stFedexAvailableServices.FDXRateAvailableServicesReply.Error.Code.XmlText")>
		<!--- There was an error get default shipping rate for this service level --->
		<cfset CALLER.FedexError = "1">
		<cfset CALLER.FedexErrorDesc = "#CALLER.stFedexAvailableServices.FDXRateAvailableServicesReply.Error.Message.XmlText#">
	
	<cfelse>
		<cfset CALLER.FedexError = "0">
		<cfset CALLER.FedexErrorDesc = "Success">
		
		<!--- Successful response start processing all elements --->
		<cfif IsDefined("CALLER.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry")>
		 <cfif IsArray(CALLER.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry.XmlChildren)>
		  <cfset CALLER.qAvailServices = QueryNew("Service, Packaging, DeliveryDate, DeliveryDay, TimeInTransit, DimWeightUsed,
		   Oversize, RateZone, CurrencyCode, BilledWeight, DimWeight, DiscBaseFreightCharges, DiscDiscountAmt, DiscSurchargeTotal, DiscNetTotalCharge, DiscTotalRebate, DiscBaseTotalCharges,
		   ListBaseFreightCharges, ListSurchargeTotal, ListNetTotalCharge, ListTotalRebate")>
			<cfloop index="idxAvs" from="1" to="#ArrayLen(CALLER.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry)#">
					<cfset newRow  = QueryAddRow(CALLER.qAvailServices, 1)>
				   <cfif StructKeyExists(CALLER.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs], "Service")>	
					<cfset temp = QuerySetCell(CALLER.qAvailServices, "Service", CALLER.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].Service.XmlText, idxAvs)>
				   <cfelse>
					<cfset temp = QuerySetCell(CALLER.qAvailServices, "Service", "")>
				   </cfif>
				   <cfif StructKeyExists(CALLER.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs], "Packaging")>	
					<cfset temp = QuerySetCell(CALLER.qAvailServices, "Packaging", CALLER.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].Packaging.XmlText, idxAvs)>
				   <cfelse>
					<cfset temp = QuerySetCell(CALLER.qAvailServices, "DeliveryDate", "")>
				   </cfif>
				   <cfif StructKeyExists(CALLER.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs], "DeliveryDate")>	
					<cfset temp = QuerySetCell(CALLER.qAvailServices, "DeliveryDate", CALLER.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].DeliveryDate.XmlText, idxAvs)>
				   <cfelse>
					<cfset temp = QuerySetCell(CALLER.qAvailServices, "DeliveryDate", "")>
				   </cfif>
				   <cfif StructKeyExists(CALLER.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs], "DeliveryDay")>	
					<cfset temp = QuerySetCell(CALLER.qAvailServices, "DeliveryDay", CALLER.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].DeliveryDay.XmlText, idxAvs)>
				   <cfelse>
					<cfset temp = QuerySetCell(CALLER.qAvailServices, "DeliveryDay", "")>
				   </cfif>
				   <cfif StructKeyExists(CALLER.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs], "TimeInTransit")>	
					<cfset temp = QuerySetCell(CALLER.qAvailServices, "TimeInTransit", CALLER.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].TimeInTransit.XmlText, idxAvs)>
				   <cfelse>
					<cfset temp = QuerySetCell(CALLER.qAvailServices, "TimeInTransit", "")>
				   </cfif>
				   
				   <cfif StructKeyExists(CALLER.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs], "EstimatedCharges")>
					   <cfif StructKeyExists(CALLER.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges, "DimWeightUsed")>	
						<cfset temp = QuerySetCell(CALLER.qAvailServices, "DimWeightUsed", CALLER.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges.DimWeightUsed.XmlText, idxAvs)>
					   <cfelse>
						<cfset temp = QuerySetCell(CALLER.qAvailServices, "DimWeightUsed", "")>
					   </cfif>
					   <cfif StructKeyExists(CALLER.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges, "Oversize")>	
						<cfset temp = QuerySetCell(CALLER.qAvailServices, "Oversize", CALLER.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges.Oversize.XmlText, idxAvs)>
					   <cfelse>
						<cfset temp = QuerySetCell(CALLER.qAvailServices, "Oversize", "")>
					   </cfif>
					   <cfif StructKeyExists(CALLER.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges, "RateZone")>	
						<cfset temp = QuerySetCell(CALLER.qAvailServices, "RateZone", CALLER.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges.RateZone.XmlText, idxAvs)>
					   <cfelse>
						<cfset temp = QuerySetCell(CALLER.qAvailServices, "RateZone", "")>
					   </cfif>
					   <cfif StructKeyExists(CALLER.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges, "CurrencyCode")>	
						<cfset temp = QuerySetCell(CALLER.qAvailServices, "CurrencyCode", CALLER.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges.CurrencyCode.XmlText, idxAvs)>
					   <cfelse>
						<cfset temp = QuerySetCell(CALLER.qAvailServices, "CurrencyCode", "")>
					   </cfif>
					   <cfif StructKeyExists(CALLER.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges, "BilledWeight")>	
						<cfset temp = QuerySetCell(CALLER.qAvailServices, "BilledWeight", CALLER.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges.BilledWeight.XmlText, idxAvs)>
					   <cfelse>
						<cfset temp = QuerySetCell(CALLER.qAvailServices, "BilledWeight", "")>
					   </cfif>
					   <cfif StructKeyExists(CALLER.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges, "DimWeight")>	
						<cfset temp = QuerySetCell(CALLER.qAvailServices, "DimWeight", CALLER.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges.DimWeight.XmlText, idxAvs)>
					   <cfelse>
						<cfset temp = QuerySetCell(CALLER.qAvailServices, "DimWeight", "")>
					   </cfif>
					   
					   <cfif StructKeyExists(CALLER.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges, "DiscountedCharges")>	
					   	   <cfif StructKeyExists(CALLER.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges.DiscountedCharges, "BaseCharge")>	
							<cfset temp = QuerySetCell(CALLER.qAvailServices, "DiscBaseFreightCharges", CALLER.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges.DiscountedCharges.BaseCharge.XmlText, idxAvs)>
						   	<cfset nBaseCharge = CALLER.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges.DiscountedCharges.BaseCharge.XmlText>
						   <cfelse>
							<cfset temp = QuerySetCell(CALLER.qAvailServices, "DiscBaseFreightCharges", "")>
						   	<cfset nBaseCharge = 0>
						   </cfif>	
						   <cfif StructKeyExists(CALLER.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges.DiscountedCharges, "TotalDiscount")>	
							<cfset temp = QuerySetCell(CALLER.qAvailServices, "DiscDiscountAmt", CALLER.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges.DiscountedCharges.TotalDiscount.XmlText, idxAvs)>
						   <cfelse>
							<cfset temp = QuerySetCell(CALLER.qAvailServices, "DiscDiscountAmt", "")>
						   </cfif>
						   <cfif StructKeyExists(CALLER.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges.DiscountedCharges, "TotalSurcharge")>	
							<cfset temp = QuerySetCell(CALLER.qAvailServices, "DiscSurchargeTotal", CALLER.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges.DiscountedCharges.TotalSurcharge.XmlText, idxAvs)>
						   	<cfset nSurCharge = CALLER.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges.DiscountedCharges.TotalSurcharge.XmlText>
						   <cfelse>
							<cfset temp = QuerySetCell(CALLER.qAvailServices, "DiscSurchargeTotal", "")>
							<cfset nSurCharge = 0>
						   </cfif>
						   <cfif StructKeyExists(CALLER.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges.DiscountedCharges, "NetCharge")>	
							<cfset temp = QuerySetCell(CALLER.qAvailServices, "DiscNetTotalCharge", CALLER.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges.DiscountedCharges.NetCharge.XmlText, idxAvs)>
						   <cfelse>
							<cfset temp = QuerySetCell(CALLER.qAvailServices, "DiscNetTotalCharge", "")>
						   </cfif>
						   <cfif StructKeyExists(CALLER.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges.DiscountedCharges, "TotalRebate")>	
							<cfset temp = QuerySetCell(CALLER.qAvailServices, "DiscTotalRebate", CALLER.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges.DiscountedCharges.TotalRebate.XmlText, idxAvs)>
						   <cfelse>
							<cfset temp = QuerySetCell(CALLER.qAvailServices, "DiscTotalRebate", "")>
						   </cfif>
							<cfset nTotalCharge = nBaseCharge + nSurCharge>
							<cfset temp = QuerySetCell(CALLER.qAvailServices, "DiscBaseTotalCharges", nTotalCharge, idxAvs)>
					   <cfelse>
						<!--- Discounted Charges element not present --->
					   </cfif>
					   
					   <cfif StructKeyExists(CALLER.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges, "ListCharges")>	
					   	   <cfif StructKeyExists(CALLER.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges.ListCharges, "BaseCharge")>	
							<cfset temp = QuerySetCell(CALLER.qAvailServices, "ListBaseFreightCharges", CALLER.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges.ListCharges.BaseCharge.XmlText, idxAvs)>
						   <cfelse>
							<cfset temp = QuerySetCell(CALLER.qAvailServices, "ListBaseFreightCharges", "")>
						   </cfif>	
						   <cfif StructKeyExists(CALLER.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges.ListCharges, "TotalSurcharge")>	
							<cfset temp = QuerySetCell(CALLER.qAvailServices, "ListSurchargeTotal", CALLER.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges.ListCharges.TotalSurcharge.XmlText, idxAvs)>
						   <cfelse>
							<cfset temp = QuerySetCell(CALLER.qAvailServices, "ListSurchargeTotal", "")>
						   </cfif>
						   <cfif StructKeyExists(CALLER.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges.ListCharges, "NetCharge")>	
							<cfset temp = QuerySetCell(CALLER.qAvailServices, "ListNetTotalCharge", CALLER.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges.ListCharges.NetCharge.XmlText, idxAvs)>
						   <cfelse>
							<cfset temp = QuerySetCell(CALLER.qAvailServices, "ListNetTotalCharge", "")>
						   </cfif>
						   <cfif StructKeyExists(CALLER.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges.ListCharges, "TotalRebate")>	
							<cfset temp = QuerySetCell(CALLER.qAvailServices, "ListTotalRebate", CALLER.stFedexAvailableServices.FDXRateAvailableServicesReply.Entry[idxAvs].EstimatedCharges.ListCharges.TotalRebate.XmlText, idxAvs)>
						   <cfelse>
							<cfset temp = QuerySetCell(CALLER.qAvailServices, "ListTotalRebate", "")>
						   </cfif>
						   				   
					   <cfelse>
						<!--- List Charges element not present --->
					   </cfif>
					   
				   
				   <cfelse>
				   		<!--- EstimatedCharges element not found, this should not be possible but handled anyhow --->
						
						
				   </cfif>
				   
			</cfloop>
		 <cfelse>
		 <!--- No array found --->
						<cfset temp = QuerySetCell(CALLER.qAvailServices, "Service", "")>
						<cfset temp = QuerySetCell(CALLER.qAvailServices, "DeliveryDate", "")>
						<cfset temp = QuerySetCell(CALLER.qAvailServices, "DeliveryDate", "")>
						<cfset temp = QuerySetCell(CALLER.qAvailServices, "DeliveryDay", "")>
						<cfset temp = QuerySetCell(CALLER.qAvailServices, "TimeInTransit", "")>
						<cfset temp = QuerySetCell(CALLER.qAvailServices, "DimWeightUsed", "")>
						<cfset temp = QuerySetCell(CALLER.qAvailServices, "OversizeCharge", "")>
						<cfset temp = QuerySetCell(CALLER.qAvailServices, "RateZone", "")>
						<cfset temp = QuerySetCell(CALLER.qAvailServices, "Currency", "")>
						<cfset temp = QuerySetCell(CALLER.qAvailServices, "BilledWeight", "")>
						<cfset temp = QuerySetCell(CALLER.qAvailServices, "DimWeight", "")>		 	
		 </cfif>
		<!--- Scan data may be valid but not an array --->
		
		<cfelse>
		
		 <cfif StructKeyExists(CALLER.stFedexAvailableServices.FDXRateAvailableServicesReply, "Entry")>
			<cfset CALLER.availSingleStruct = 1>
			<cfset CALLER.availSingleCity = CALLER.stFedexTrackingResponse.TrackResponse.TrackProfile.Scan.City.XmlText>
		 </cfif>
		 
		</cfif>
		<!--- Successful response start processing all elements close --->
		
	</cfif>
	
 </cfcase>
 <!---  Fedex Available services request close --->
 
 <cfcase value="TrackByNumber">
 <!--- Start track fedex tracking by number --->
	
	<cfparam name="ATTRIBUTES.trackingNumber" default="222222222222">
	
	<cfscript>
	ATTRIBUTES.XMLRequestInput = '<?xml version="#ATTRIBUTES.XMLVersion#" encoding="UTF-8"?>
	<TrackRequest xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="Tracking.xsd" Version="#ATTRIBUTES.TrackVersion#">
	<SearchValue SearchType="TrackingNumber">#ATTRIBUTES.trackingNumber#</SearchValue>
	</TrackRequest>';
	</cfscript>
	
	<cfhttp method="post" url="#ATTRIBUTES.FedexServer#" resolveurl="yes" port="443" timeout="#ATTRIBUTES.TimeOut#">
		<cfhttpparam name="XML" type="xml" value="#ATTRIBUTES.XMLRequestInput#">
	</cfhttp>
	
	<cfset CALLER.stFedexTrackingResponse = XmlParse(cfhttp.FileContent)>
	 
	 <!--- Debug Mode --->
	<cfif ATTRIBUTES.Debug eq "True">
		<cfoutput>
			<cfdump var="#CALLER.stFedexTrackingResponse#">
		</cfoutput>
		<cffile action="WRITE" file="#ATTRIBUTES.ServerFilePath##trailingSlash#Debug#trailingSlash#TrackByNumRequest.xml" output="#ATTRIBUTES.XMLRequestInput#" addnewline="No" nameconflict="overwrite">
		<cffile action="WRITE" file="#ATTRIBUTES.ServerFilePath##trailingSlash#Debug#trailingSlash#TrackByNumRequest.xml" output="#cfhttp.FileContent#" addnewline="No" nameconflict="overwrite">
		<cfabort>
	</cfif>
	<!--- Debug Mode --->
	
	<cfscript>
	if ( IsDefined("CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.Error.Code.XmlText") ) {
		CALLER.FedexError = "1";
		CALLER.FedexErrorDesc = #CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.Error.Message.XmlText#;
	}
	else {
			if ( IsDefined("CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.TRACKINGNUMBER.Number.XmlText") ) {
				CALLER.FedexError = "0";
				CALLER.FedexErrorDesc = "";
		
				CALLER.TrackingNum = #CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.TRACKINGNUMBER.Number.XmlText#;
				if ( IsDefined("CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.Service.XmlText") ) {
			  		CALLER.Service = #CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.Service.XmlText#;
				}
				else {
			  		CALLER.Service = "";
				}
				if ( IsDefined("CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.ShipDate.XmlText") ) {
			  		CALLER.ShipDate = #CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.ShipDate.XmlText#;
				}
				else {
			  		CALLER.ShipDate = "";				
				}
		       	if ( IsDefined("CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.ESTIMATEDDELIVERYDATE.XmlText") ) {
			   		CALLER.ESTDeliveryDate = #CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.EstimatedDeliveryDate.XmlText#;
				}
				else {
					CALLER.ESTDeliveryDate = "";
				}
				if ( IsDefined("CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.DestinationCity.XmlText") ) {
			  		CALLER.DESTCity = #CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.DestinationCity.XmlText#;
		    	}
				else {
					CALLER.DESTCity = "";
				}
				if ( IsDefined("CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.DestinationCountryCode.XmlText") ) {
			  		CALLER.DESTCountry = #CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.DestinationCountryCode.XmlText#;
		    	}
				else {
					CALLER.DESTCountry = "";
				}
			 	if ( IsDefined("CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.DestinationZipCode.XmlText") ) {
			  		CALLER.DESTZip = #CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.DestinationZipCode.XmlText#;
				}
				else {
					CALLER.DESTZip = "";
				}
			 	if ( IsDefined("CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.DestinationState.XmlText") ) {
			  		CALLER.DESTState = #CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.DestinationState.XmlText#;
				}
				else {
					CALLER.DESTState = "";
				}
			 	if ( IsDefined("CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.DeliveredDate.XmlText") ) {
			  		CALLER.DeliveryDate = #CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.DeliveredDate.XmlText#;
				}
				else {
					CALLER.DeliveryDate = "";
				}
			 	if ( IsDefined("CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.DeliveredTime.XmlText") ) {
			  		CALLER.DeliveryTime = #CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.DeliveredTime.XmlText#;
				}
				else {
					CALLER.DeliveryTime = "";
				}
			 	if ( IsDefined("CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.SignedForBy.XmlText") ) {
			  		CALLER.SignedBy = #CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.SignedForBy.XmlText#;
				}
				else {
					CALLER.SignedBy = "";
				}				
			 	if ( IsDefined("CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.Weight.Amount.XmlText") ) {
			  		CALLER.Weight = #CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.Weight.Amount.XmlText#;
				}
				else {
					CALLER.Weight = "";
				}
				if ( IsDefined("CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.Weight.Units.XmlText") ) {
			  		CALLER.WeightUnits = #CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.Weight.Units.XmlText#;
				}
				else {
					CALLER.WeightUnits = "";
				}			
				if ( IsDefined("CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.Reference.XmlText") ) {
			  		CALLER.Reference = #CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.Reference.XmlText#;
				}
				else {
					CALLER.Reference = "";
				}	
				
			}
			else {
				CALLER.FedexError = "1";
				CALLER.FedexErrorDesc = #CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.Error.Message.XmlText#;
			}
	}
	</cfscript>
	
	<cfif IsDefined("CALLER.stFedexTrackingResponse.TrackResponse.TrackProfile.Scan")>
	 <cfif IsArray(CALLER.stFedexTrackingResponse.TrackResponse.TrackProfile.Scan.XmlChildren)>
	  <cfset CALLER.scanQuery = QueryNew("ScanCity, ScanDesc, ScanDate, ScanTime, ScanState, ScanDeliveryInfo, ScanDelayInfo, StatusDesc")>
	  <cfset CALLER.aScans = CALLER.stFedexTrackingResponse.TrackResponse.TrackProfile.Scan>
	 	<cfloop index="idxScans" from="1" to="#ArrayLen(CALLER.aScans)#">
		   		<cfset newRow  = QueryAddRow(CALLER.scanQuery, 1)>
 			   <cfif StructKeyExists(CALLER.stFedexTrackingResponse.TrackResponse.TrackProfile.Scan[idxScans], "City")>	
				<cfset temp = QuerySetCell(CALLER.scanQuery, "ScanCity", CALLER.stFedexTrackingResponse.TrackResponse.TrackProfile.Scan[idxScans].City.XmlText, idxScans)>
			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.scanQuery, "ScanCity", "")>
			   </cfif>
				<cfset temp = QuerySetCell(CALLER.scanQuery, "ScanDesc", CALLER.stFedexTrackingResponse.TrackResponse.TrackProfile.Scan[idxScans].ScanDescription.XmlText, idxScans)>
 				<cfset temp = QuerySetCell(CALLER.scanQuery, "ScanDate", CALLER.stFedexTrackingResponse.TrackResponse.TrackProfile.Scan[idxScans].Date.XmlText, idxScans)>				
 				<cfset temp = QuerySetCell(CALLER.scanQuery, "ScanTime", CALLER.stFedexTrackingResponse.TrackResponse.TrackProfile.Scan[idxScans].Time.XmlText, idxScans)>				
 			   <cfif StructKeyExists(CALLER.stFedexTrackingResponse.TrackResponse.TrackProfile.Scan[idxScans], "State")>	
 				<cfset temp = QuerySetCell(CALLER.scanQuery, "ScanState", CALLER.stFedexTrackingResponse.TrackResponse.TrackProfile.Scan[idxScans].State.XmlText, idxScans)>
			   <cfelse>
 				<cfset temp = QuerySetCell(CALLER.scanQuery, "ScanState", "")>
			   </cfif>			
 			   <cfif StructKeyExists(CALLER.stFedexTrackingResponse.TrackResponse.TrackProfile.Scan[idxScans], "DeliveryInfo") AND NOT StructKeyExists(CALLER.stFedexTrackingResponse.TrackResponse.TrackProfile.Scan[idxScans].DeliveryInfo, "Address")>	
				<cfset temp = QuerySetCell(CALLER.scanQuery, "ScanDeliveryInfo", CALLER.stFedexTrackingResponse.TrackResponse.TrackProfile.Scan[idxScans].DeliveryInfo.XmlText, idxScans)>				
 			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.scanQuery, "ScanDeliveryInfo", CALLER.stFedexTrackingResponse.TrackResponse.TrackProfile.Scan[idxScans].DeliveryInfo.Address.XmlText, idxScans)>				
			   </cfif>	
				<cfset temp = QuerySetCell(CALLER.scanQuery, "ScanDelayInfo", CALLER.stFedexTrackingResponse.TrackResponse.TrackProfile.Scan[idxScans].ScanDelayInfo.XmlText, idxScans)>				
 			   <cfif StructKeyExists(CALLER.stFedexTrackingResponse.TrackResponse.TrackProfile.Scan[idxScans], "StatusDescription")>	
				<cfset temp = QuerySetCell(CALLER.scanQuery, "StatusDesc", CALLER.stFedexTrackingResponse.TrackResponse.TrackProfile.Scan[idxScans].StatusDescription.XmlText, idxScans)>				
 			   <cfelse>
				<cfset temp = QuerySetCell(CALLER.scanQuery, "StatusDesc", "")>				
			   </cfif>	
		</cfloop>
	 <cfelse>
	 </cfif>
	<!--- Scan data may be valid but not an array --->
	
	<cfelse>
	 <cfif StructKeyExists(CALLER.stFedexTrackingResponse.TrackResponse.TrackProfile, "Scan")>
	 	<cfset CALLER.scanSingleStruct = 1>
		<cfset CALLER.scanSingleCity = CALLER.stFedexTrackingResponse.TrackResponse.TrackProfile.Scan.City.XmlText>
	 	<cfset CALLER.scanSingleDate = CALLER.stFedexTrackingResponse.TrackResponse.TrackProfile.Scan.Date.XmlText>
	 	<cfset CALLER.scanSingleTime = CALLER.stFedexTrackingResponse.TrackResponse.TrackProfile.Scan.Time.XmlText>
	 	<cfset CALLER.scanSingleDesc = CALLER.stFedexTrackingResponse.TrackResponse.TrackProfile.Scan.ScanDescription.XmlText>
	 	<cfset CALLER.scanSingleDelivInfo = CALLER.stFedexTrackingResponse.TrackResponse.TrackProfile.Scan.DeliveryInfo.XmlText>
	 </cfif>
	 
	</cfif>
 
 <!--- End track fedex tracking by number --->
 </cfcase>
 
 <cfcase value="TrackByReference">
 <!--- Start track fedex tracking by reference --->
	
	<cfparam name="ATTRIBUTES.trackingReference" default="february">
	<cfparam name="ATTRIBUTES.trackingServiceType" default="Express">
	
	<cfscript>
	ATTRIBUTES.XMLRequestInput = '<?xml version="#ATTRIBUTES.XMLVersion#" encoding="UTF-8"?>
	<TrackRequest xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="Tracking.xsd" Version="#ATTRIBUTES.TrackVersion#">
		<SearchValue SearchType="CustomerReference" CarrierType="#ATTRIBUTES.TrackingServiceType#">#ATTRIBUTES.TrackingReference#</SearchValue>
		<ShipperAccountNumber>#ATTRIBUTES.AccountNumber#</ShipperAccountNumber>
	</TrackRequest>';
	
	</cfscript>
	
	<cfhttp method="post" url="#ATTRIBUTES.FedexServer#" resolveurl="yes" port="443" timeout="#ATTRIBUTES.TimeOut#">
		<cfhttpparam name="XML" type="xml" value="#ATTRIBUTES.XMLRequestInput#">
	</cfhttp>
	
	<cfset CALLER.stFedexTrackingResponse = XmlParse(cfhttp.FileContent)>
	 
	 <!--- Debug Mode --->
	<cfif ATTRIBUTES.Debug eq "True">
		<cfoutput>
			<cfdump var="#CALLER.stFedexTrackingResponse#">
		</cfoutput>
		<cffile action="WRITE" file="#ATTRIBUTES.ServerFilePath##trailingSlash#Debug#trailingSlash#TrackByRefRequest.xml" output="#ATTRIBUTES.XMLRequestInput#" addnewline="No" nameconflict="overwrite">
		<cffile action="WRITE" file="#ATTRIBUTES.ServerFilePath##trailingSlash#Debug#trailingSlash#TrackByRefRequest.xml" output="#cfhttp.FileContent#" addnewline="No" nameconflict="overwrite">
		<cfabort>
	</cfif>
	<!--- Debug Mode --->
	
	<cfscript>
	if ( IsDefined("CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.Error.Code.XmlText") ) {
		CALLER.FedexError = "1";
		CALLER.FedexErrorDesc = #CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.Error.Message.XmlText#;
	}
	else {
			if ( IsDefined("CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.TRACKINGNUMBER.Number.XmlText") ) {
				CALLER.FedexError = "0";
				CALLER.FedexErrorDesc = "";
		
				CALLER.TrackingNum = #CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.TRACKINGNUMBER.Number.XmlText#;
				if ( IsDefined("CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.Service.XmlText") ) {
			  		CALLER.Service = #CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.Service.XmlText#;
			  		CALLER.ShipDate = #CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.ShipDate.XmlText#;
				}
				else {
			  		CALLER.Service = "";
			  		CALLER.ShipDate = "";				
				}
		       	if ( IsDefined("CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.ESTIMATEDDELIVERYDATE.XmlText") ) {
			   		CALLER.ESTDeliveryDate = #CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.EstimatedDeliveryDate.XmlText#;
				}
				else {
					CALLER.ESTDeliveryDate = "";
				}
				if ( IsDefined("CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.DestinationCity.XmlText") ) {
			  		CALLER.DESTCity = #CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.DestinationCity.XmlText#;
		    	}
				else {
					CALLER.DESTCity = "";
				}
				if ( IsDefined("CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.DestinationCountryCode.XmlText") ) {
			  		CALLER.DESTCountry = #CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.DestinationCountryCode.XmlText#;
		    	}
				else {
					CALLER.DESTCountry = "";
				}
			 	if ( IsDefined("CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.DestinationZipCode.XmlText") ) {
			  		CALLER.DESTZip = #CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.DestinationZipCode.XmlText#;
				}
				else {
					CALLER.DESTZip = "";
				}
			 	if ( IsDefined("CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.DestinationState.XmlText") ) {
			  		CALLER.DESTState = #CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.DestinationState.XmlText#;
				}
				else {
					CALLER.DESTState = "";
				}
			 	if ( IsDefined("CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.DeliveredDate.XmlText") ) {
			  		CALLER.DeliveryDate = #CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.DeliveredDate.XmlText#;
				}
				else {
					CALLER.DeliveryDate = "";
				}
			 	if ( IsDefined("CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.DeliveredTime.XmlText") ) {
			  		CALLER.DeliveryTime = #CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.DeliveredTime.XmlText#;
				}
				else {
					CALLER.DeliveryTime = "";
				}
			 	if ( IsDefined("CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.SignedForBy.XmlText") ) {
			  		CALLER.SignedBy = #CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.SignedForBy.XmlText#;
				}
				else {
					CALLER.SignedBy = "";
				}				
			 	if ( IsDefined("CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.Weight.Amount.XmlText") ) {
			  		CALLER.Weight = #CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.Weight.Amount.XmlText#;
				}
				else {
					CALLER.Weight = "";
				}
				if ( IsDefined("CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.Weight.Units.XmlText") ) {
			  		CALLER.WeightUnits = #CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.Weight.Units.XmlText#;
				}
				else {
					CALLER.WeightUnits = "";
				}			
				if ( IsDefined("CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.Reference.XmlText") ) {
			  		CALLER.Reference = #CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.Reference.XmlText#;
				}
				else {
					CALLER.Reference = "";
				}	
				
			}
			else {
				CALLER.FedexError = "1";
				CALLER.FedexErrorDesc = #CALLER.stFedexTrackingResponse.TRACKRESPONSE.TRACKPROFILE.Error.Message.XmlText#;
			}
	}
	</cfscript>
	
 <!--- End track fedex tracking by reference --->
 </cfcase>

 <cfcase value="PODOnlineRequest">
 <!--- Start POD Request Online  --->
		
	<!--- 2003-05-06 --->
	
	<cfscript>
	ATTRIBUTES.XMLRequestInput = '<?xml version="#ATTRIBUTES.XMLVersion#" encoding="UTF-8"?>
	<SpodLetterRequest xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="SpodLetter.xsd" RequestType="OnlineLetter" LanguageIndicator="English" Version="#ATTRIBUTES.PODVersion#">
	<TrackingNumber>#ATTRIBUTES.TrackingNumber#</TrackingNumber>
	<ShipDate>#ATTRIBUTES.DateShipped#</ShipDate>
	<Recipient/>
	<FaxMailRecipient/>
	</SpodLetterRequest>';
	
	</cfscript>
	
	<cfhttp method="post" url="#ATTRIBUTES.FedexServer#" resolveurl="yes" port="443" timeout="#ATTRIBUTES.TimeOut#">
		<cfhttpparam name="XML" type="xml" value="#ATTRIBUTES.XMLRequestInput#">
	</cfhttp>
	
	<cfset CALLER.stFedexPODResponse = XmlParse(Trim(cfhttp.FileContent))>
	 
	 <!--- Debug Mode --->
	<cfif ATTRIBUTES.Debug eq "True">
		<cfoutput>
			<cfdump var="#CALLER.stFedexPODResponse#">
		</cfoutput>
		<cffile action="WRITE" file="#ATTRIBUTES.ServerFilePath##trailingSlash#Debug#trailingSlash#PODRequest.xml" output="#ATTRIBUTES.XMLRequestInput#" addnewline="No" nameconflict="overwrite">
		<cffile action="WRITE" file="#ATTRIBUTES.ServerFilePath##trailingSlash#Debug#trailingSlash#PODRequest.xml" output="#cfhttp.FileContent#" addnewline="No" nameconflict="overwrite">
		<cfabort>
	</cfif>
	<!--- Debug Mode --->
	
	<cfif StructKeyExists(CALLER.stFedexPODResponse.SPODLETTERRESPONSE, "PNGIMAGEBUFFER")>
		<cfset binary = toBinary("#CALLER.stFedexPODResponse.SPODLETTERRESPONSE.PNGIMAGEBUFFER.XmlText#")>

		<cffile action="WRITE" file="#ATTRIBUTES.ServerFilePath##trailingSlash#PODImages#trailingSlash##ATTRIBUTES.trackingNumber#.png" output="#binary#" addnewline="No" nameconflict="overwrite">
		<cfset CALLER.PODImageName = #ATTRIBUTES.trackingNumber# & ".png">
		<cfset CALLER.FedexError = 0>
		<cfset CALLER.FedexErrorDesc = "">
		
	<cfelse>
		<cfset CALLER.FedexError = 1>
		<cfset CALLER.FedexErrorDesc = "Proof Of Delivery image unavailable">
	</cfif>
 <!--- End POD Request Online --->
 </cfcase>
  
  <!--- ***** 2.0 ****** --->
 <!--- Ship Request  --->
 <cfcase value="ShipRequest">
		
	<cfscript>
	if ( (ATTRIBUTES.ServiceLevel eq "FEDEXGROUND" OR ATTRIBUTES.ServiceLevel eq "GROUNDHOMEDELIVERY") ) {
		ATTRIBUTES.RateRequestType = 'FDXG';
	}
	else {
		ATTRIBUTES.RateRequestType = 'FDXE';
	}
	
	// International shipment
	if ( ATTRIBUTES.ShipToCountry neq "US" ) {
		IntlIndicator = '<International>
		<RecipientTIN>#ATTRIBUTES.RecipientTIN#</RecipientTIN>
		<Broker>
			<AccountNumber>#ATTRIBUTES.BrokerAccountNumber#</AccountNumber>
			<TIN>#ATTRIBUTES.BrokerTIN#</TIN>
			<Contact>
				<PersonName>#ATTRIBUTES.BrokerName#</PersonName>
				<CompanyName>#ATTRIBUTES.BrokerCompanyName#</CompanyName>
				<PhoneNumber>#ATTRIBUTES.BrokerPhoneNumber#</PhoneNumber>
				<PagerNumber>#ATTRIBUTES.BrokerPagerNumber#</PagerNumber>
				<FaxNumber>#ATTRIBUTES.BrokerFaxNumber#</FaxNumber>
				<E-MailAddress>#ATTRIBUTES.BrokerEmail#</E-MailAddress>
			</Contact>
			<Address>
				<Line1>#ATTRIBUTES.BrokerStreet#</Line1>
				<Line2>#ATTRIBUTES.BrokerStreet2#</Line2>
				<City>#ATTRIBUTES.BrokerCity#</City>
				<StateOrProvinceCode>#ATTRIBUTES.BrokerState#</StateOrProvinceCode>
				<PostalCode>#ATTRIBUTES.BrokerZip#</PostalCode>
				<CountryCode>#ATTRIBUTES.BrokerCountry#</CountryCode>	
			</Address>
		</Broker>
		<DutiesPayment>
			<DutiesPayor>
				<AccountNumber>#ATTRIBUTES.DutiesPayorAccountNumber#</AccountNumber>
				<CountryCode>#ATTRIBUTES.DutiesPayorCountry#</CountryCode>
			</DutiesPayor>
			<PayorType>#ATTRIBUTES.DutiesPayorType#</PayorType>
		</DutiesPayment>
		<TermsOfSale>#ATTRIBUTES.TermsOfSale#</TermsOfSale>
		<PartiesToTransaction>#ATTRIBUTES.PartiesToTransaction#</PartiesToTransaction>
		<Document>#ATTRIBUTES.IntlDocumentDesc#</Document>
		<NAFTA>#ATTRIBUTES.NAFTA#<NAFTA>
		<CountryOfUltimateDestination>#ATTRIBUTES.CountryOfUltimateDestination#</CountryOfUltimateDestination>
		<TotalCustomsValue>#ATTRIBUTES.TotalCustomsValue#</TotalCustomsValue>
		<SED>
			<SenderTINOrDUNS>#ATTRIBUTES.SenderTINOrDUNS#</SenderTINOrDUNS>
			<SenderTINOrDUNSType>#ATTRIBUTES.SenderTINOrDUNSType#</SenderTINOrDUNSType>
			<AESOrFTSRExemptionNumber>#ATTRIBUTES.AESOrFTSRExemptionNumber#</AESOrFTSRExemptionNumber>
		</SED>
	</International>';
	}
	else {
		IntlIndicator = '';
	}
	
	// Special Services
	SSOpen = '<SpecialServices>';
	SSClose = '</SpecialServices>';
	
	if ( Len(ATTRIBUTES.SSCodAmount) gt 0 AND Len(ATTRIBUTES.SSCODType) gt 0 ) {
	SSCODIndicator = '<COD>
				<CollectionAmount>#Trim(NumberFormat(ATTRIBUTES.SSCodAmount,"99999999999.99"))#</CollectionAmount>
				<CollectionType>#ATTRIBUTES.SSCODType#</CollectionType>
			</COD>';
	}
	else { SSCODIndicator = ''; }
	
	if ( ATTRIBUTES.RateRequestType eq "FDXE" AND ATTRIBUTES.SSHoldAtLocation eq "1" ) {
	SSHoldAtLocIndicator = '<HoldAtLocation>#ATTRIBUTES.SSHoldAtLocation#</HoldAtLocation>';
	}
	else { SSHoldAtLocIndicator = ''; }
	
	if ( ATTRIBUTES.SSDangerousGoods eq "ACCESSIBLE" OR ATTRIBUTES.SSDangerousGoods eq "INACCESSIBLE" ) {
	SSDangGoodsIndicator = '<DangerousGoods>
		<Accessibility>#ATTRIBUTES.SSDangerousGoods#<Accessibility>
	</DangerousGoods>';
	}
	else { SSDangGoodsIndicator = ''; }
	
	if ( ATTRIBUTES.RateRequestType eq "FDXE" AND ATTRIBUTES.SSDryIce eq "1" ) {
	SSDryIceIndicator = '<DryIce>#ATTRIBUTES.SSDryIce#</DryIce>';
	}
	else { SSDryIceIndicator = ''; }
	
	if ( ATTRIBUTES.SSResDelivery eq "1" ) {
	SSResDelivIndicator = '<ResidentialDelivery>#ATTRIBUTES.SSResDelivery#</ResidentialDelivery>';
	}
	else { SSResDelivIndicator = ''; }
	
	if ( ATTRIBUTES.RateRequestType eq "FDXE" AND ATTRIBUTES.SSInsidePickup eq "1" ) {
	SSInsidePickupIndicator = '<InsidePickup>#ATTRIBUTES.SSInsidePickup#</InsidePickup>';
	}
	else { SSInsidePickupIndicator = ''; }
	
	if ( ATTRIBUTES.RateRequestType eq "FDXE" AND ATTRIBUTES.SSInsideDelivery eq "1" ) {
	SSInsideDeliveryIndicator = '<InsideDelivery>#ATTRIBUTES.SSInsideDelivery#</InsideDelivery>';
	}
	else { SSInsideDeliveryIndicator = ''; }
	
	if ( ATTRIBUTES.RateRequestType eq "FDXE" AND ATTRIBUTES.SSSatPickup eq "1" ) {
	SSSaturdayPickupIndicator = '<SaturdayPickup>#ATTRIBUTES.SSSatPickup#</SaturdayPickup>';
	}
	else { SSSaturdayPickupIndicator = ''; }
	
	if ( ATTRIBUTES.RateRequestType eq "FDXE" AND ATTRIBUTES.SSSatDelivery eq "1" ) {
	SSSaturdayDeliveryIndicator = '<SaturdayDelivery>#ATTRIBUTES.SSSatDelivery#</SaturdayDelivery>';
	}
	else { SSSaturdayDeliveryIndicator = ''; }
	
	if ( ATTRIBUTES.RateRequestType eq "FDXG" AND ATTRIBUTES.SSAOD eq "1" ) {
	SSAODIndicator = '<AOD>#ATTRIBUTES.SSAOD#</AOD>';
	}
	else { SSAODIndicator = ''; }
	
	if ( ATTRIBUTES.RateRequestType eq "FDXG" AND ATTRIBUTES.SSAutoPOD eq "1" ) {
	SSAutoPODIndicator = '<AutoPOD>#ATTRIBUTES.SSAutoPOD#</AutoPOD>';
	}
	else { SSAutoPODIndicator = ''; }
	
	if ( ATTRIBUTES.RateRequestType eq "FDXG" AND ATTRIBUTES.SSNonStdContainer eq "1" ) {
	SSNonStandardContainerIndicator = '<NonStandardContainer>#ATTRIBUTES.SSNonStdContainer#</NonStandardContainer>';
	}
	else { SSNonStandardContainerIndicator = ''; }
	
	if ( ATTRIBUTES.SSFutureDayShipment eq "1" ) {
	SSFutureDayIndicator = '<FutureDayShipment>1</FutureDayShipment>';
	}
	else { SSFutureDayIndicator = ''; }
	
	if ( Len(SSCODIndicator) neq 0
		OR Len(SSHoldAtLocIndicator) neq 0
		OR Len(SSDangGoodsIndicator) neq 0
		OR Len(SSDryIceIndicator) neq 0
		OR Len(SSResDelivIndicator) neq 0
		OR Len(SSInsidePickupIndicator) neq 0
		OR Len(SSInsideDeliveryIndicator) neq 0
		OR Len(SSSaturdayPickupIndicator) neq 0
		OR Len(SSSaturdayDeliveryIndicator) neq 0
		OR Len(SSAODIndicator) neq 0
		OR Len(SSAutoPODIndicator) neq 0
		OR Len(SSNonStandardContainerIndicator) neq 0 
		OR Len(SSFutureDayIndicator) neq 0 ) {
	
		SSIndicator = '#SSOpen#
			#SSCODIndicator#
			#SSHoldAtLocIndicator#
			#SSDangGoodsIndicator#
			#SSDryIceIndicator#
			#SSFutureDayIndicator#
			#SSResDelivIndicator#
			#SSInsidePickupIndicator#
			#SSInsideDeliveryIndicator#
			#SSSaturdayPickupIndicator#
			#SSSaturdayDeliveryIndicator#
			#SSAODIndicator#
			#SSAutoPODIndicator#
			#SSNonStandardContainerIndicator#
		#SSClose#';
	}
	else {
		SSIndicator = '';
	}
	
	// Home Delivery
	if ( Len(ATTRIBUTES.HomeDeliveryType) gt 0 ) {
		HomeDelivIndicator = '<HomeDelivery>
		<Date>#ATTRIBUTES.HomeDeliveryDate#</Date>
		<Instructions>#Left(ATTRIBUTES.HomeDeliveryInstructions, 74)#</Instructions>
		<Type>#ATTRIBUTES.HomeDeliveryType#</Type>
		<PhoneNumber>#ATTRIBUTES.HomeDeliveryPhoneNumber#</PhoneNumber>
		<SignatureRequired>#ATTRIBUTES.HomeDeliverySigRequired#</SignatureRequired>
	</HomeDelivery>';
	}
	else {
		HomeDelivIndicator = '';
	}
	
	//Thermal labels only
	if ( ATTRIBUTES.LabelType eq "ELTRON" ) {
		ThermalLabelIndicator = '<DocTabLocation>  
			<Type>#ATTRIBUTES.ThermalLabelType#</Type>
			<Zone001>
				<HeaderValuePair>
					<ZoneNumber>#ATTRIBUTES.ThermalLabelZoneNumber#</ZoneNumber>
					<Header>#ATTRIBUTES.ThermalLabelHeader#</Header>
					<Value>#ATTRIBUTES.ThermalLabelValue#</Value>
				</HeaderValuePair>
			</Zone001>
		</DocTabLocation>';
	}
	else {
		ThermalLabelIndicator = '';
	}
		
	// Payor Type
	if ( ATTRIBUTES.RateRequestType eq "FDXE" ) {
		if ( ATTRIBUTES.PayorType eq "RECIPIENT" OR ATTRIBUTES.PayorType eq "THIRDPARTY" ) {
			PayorIndicator = '<Payor>
				<AccountNumber>#ATTRIBUTES.PayorAccountNumber#</AccountNumber>
				<CountryCode>#ATTRIBUTES.PayorCountryCode#</CountryCode>
			</Payor>';
		}
		else {
			PayorIndicator = '';
		}
	}
	else {
		if ( ATTRIBUTES.PayorType eq "THIRDPARTY" ) {
			PayorIndicator = '<Payor>
				<AccountNumber>#ATTRIBUTES.PayorAccountNumber#</AccountNumber>
				<CountryCode>#ATTRIBUTES.PayorCountryCode#</CountryCode>
			</Payor>';
		}
		else {
			PayorIndicator = '';
		}
	}
	
	// Payment via credit card
	if ( ATTRIBUTES.PayorType eq "CREDITCARD" ) {
		CreditCardIndicator = '<CreditCard>
			<Number>#ATTRIBUTES.CreditCardNumber#</Number>
			<Type>#ATTRIBUTES.CreditCardType#</Type>
			<ExpirationDate>#ATTRIBUTES.CreditCardExpiration#</ExpirationDate>
		</CreditCard>';
	}
	else {
		CreditCardIndicator = '';
	}
	
	// Return Shipment
	if ( ATTRIBUTES.RateRequestType eq "FDXG" AND (ATTRIBUTES.ReturnShipment eq "NETRETURNORONLINELABEL" OR ATTRIBUTES.ReturnShipment eq "RETURNMANAGER") ) {
		ReturnShipmentIndicator = '<ReturnShipmentIndicator>#ATTRIBUTES.ReturnShipment#</ReturnShipmentIndicator>';
	}
	else {
		ReturnShipmentIndicator = '';
	}
	
	//Dimensions
	if ( Len(ATTRIBUTES.PackageLength) neq 0 AND Len(ATTRIBUTES.PackageWidth) neq 0 AND Len(ATTRIBUTES.PackageHeight) neq 0 ) {
		DimensionsIndicator = '<Dimensions>
		<Length>#ATTRIBUTES.PackageLength#</Length>
		<Width>#ATTRIBUTES.PackageWidth#</Width>
		<Height>#ATTRIBUTES.PackageHeight#</Height>
		<Units>#ATTRIBUTES.PackageUnitOfMeasurement#</Units>
	</Dimensions>';
	}
	else {
		DimensionsIndicator = '';
	}
	
	// Origin Address elements
	if ( Len(ATTRIBUTES.ShipperDept) neq 0 ) { ShipperDeptIndicator = '<Department>#ATTRIBUTES.ShipperDept#</Department>'; }
	else { ShipperDeptIndicator = ''; }
	if ( Len(ATTRIBUTES.ShipperPager) neq 0 ) { ShipperPagerIndicator = '<PagerNumber>#ATTRIBUTES.ShipperPager#</PagerNumber>'; }
	else { ShipperPagerIndicator = ''; }
	if ( Len(ATTRIBUTES.ShipperFax) neq 0 ) { ShipperFaxIndicator = '<FaxNumber>#ATTRIBUTES.ShipperFax#</FaxNumber>'; }
	else { ShipperFaxIndicator = ''; }
	if ( Len(ATTRIBUTES.ShipperEmail) neq 0 ) { ShipperEmailIndicator = '<E-MailAddress>#ATTRIBUTES.ShipperEmail#</E-MailAddress>'; }
	else { ShipperEmailIndicator = ''; }
	if ( Len(ATTRIBUTES.ShipperStreet2) neq 0 ) { ShipperStreet2Indicator = '<Line2>#ATTRIBUTES.ShipperStreet2#</Line2>'; }
	else { ShipperStreet2Indicator = ''; }
	
	// Declared value element
	if ( Len(ATTRIBUTES.DeclaredValue) gte 2 AND  Len(ATTRIBUTES.DeclaredValue) eq 3 ) 
	{ 
		DeclaredValueIndicator = '<DeclaredValue>
		<Value>#Trim(NumberFormat(ATTRIBUTES.DeclaredValue,"99999.99"))#</Value>
		<CurrencyCode>#UCase(ATTRIBUTES.CurrencyCode)#</CurrencyCode>
	</DeclaredValue>';
	}
	else { DeclaredValueIndicator = ''; }
	
	//Ground request elements that must not be present if empty
	// referencecustomernote="Ground Test Label"
	// referenceponumber="PO12345"
	// referenceinvoicenumber="INV12345"
	
	// Customer Reference Element
	if ( IsDefined("ATTRIBUTES.ReferenceCustomerNote") AND Len(ATTRIBUTES.ReferenceCustomerNote) gte 1 ) {
		ReferenceCustomerNoteIndicator = '<CustomerReference>#ATTRIBUTES.ReferenceCustomerNote#</CustomerReference>';
	}
	else {
		ReferenceCustomerNoteIndicator = '';
	}
	
	// PO Number Element
	if ( IsDefined("ATTRIBUTES.ReferencePONumber") AND Len(ATTRIBUTES.ReferencePONumber) gte 1 ) {
		ReferencePONumberIndicator = '<PONumber>#ATTRIBUTES.ReferencePONumber#</PONumber>';
	}
	else {
		ReferencePONumberIndicator = '';
	}
	
	// Invoice Number Element
	if ( IsDefined("ATTRIBUTES.ReferenceInvoiceNumber") AND Len(ATTRIBUTES.ReferenceInvoiceNumber) gte 1 ) {
		ReferenceInvoiceNumberIndicator = '<InvoiceNumber>#ATTRIBUTES.ReferenceInvoiceNumber#</InvoiceNumber>';
	}
	else {
		ReferenceInvoiceNumberIndicator = '';
	}
	
	// Assemble ReferenceInfo element and children
	if ( Len(ReferenceCustomerNoteIndicator) gt 0 OR Len(ReferencePONumberIndicator) gt 0 OR Len(ReferenceInvoiceNumberIndicator) gt 0 ) {
		ReferenceElementIdcicator = '<ReferenceInfo>
		#ReferenceCustomerNoteIndicator#
		#ReferencePONumberIndicator#
		#ReferenceInvoiceNumberIndicator#
	</ReferenceInfo>';
	}
	else {
		ReferenceElementIdcicator = '';
	}
	
	ATTRIBUTES.XMLRequestInput = '<?xml version="1.0" encoding="UTF-8"?>
	<FDXShipRequest xmlns:api="http://www.fedex.com/fsmapi" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="FDXShipRequest.xsd">
	<RequestHeader>
		<CustomerTransactionIdentifier>US Ship</CustomerTransactionIdentifier>
		<MeterNumber>#ATTRIBUTES.FedexIndentifier#</MeterNumber>
		<AccountNumber>#ATTRIBUTES.AccountNumber#</AccountNumber>
		<CarrierCode>#ATTRIBUTES.RateRequestType#</CarrierCode>
	</RequestHeader>		
	<RequestType>SHIP</RequestType>
	<ShipDate>#ATTRIBUTES.DateShipped#</ShipDate>
	<ShipTime>#ATTRIBUTES.TimeShipped#</ShipTime>
	<DropoffType>#ATTRIBUTES.DropOffType#</DropoffType>
	<Service>#ATTRIBUTES.ServiceLevel#</Service>
	<Packaging>#ATTRIBUTES.PackageType#</Packaging>
	<WeightUnits>#ATTRIBUTES.PackageWeightUnit#</WeightUnits>
	<Weight>#Trim(NumberFormat(ATTRIBUTES.PackageWeight,"99999.9"))#</Weight>
	<CurrencyCode>#ATTRIBUTES.CurrencyCode#</CurrencyCode>
	<ListRate>#ATTRIBUTES.RequestListRates#</ListRate>
	#ReturnShipmentIndicator#
	<Origin>
		<Contact>
			<PersonName>#ATTRIBUTES.ShipperContactName#</PersonName>
			<CompanyName>#ATTRIBUTES.ShipperCompany#</CompanyName>
			#ShipperDeptIndicator#
			<PhoneNumber>#ATTRIBUTES.ShipperPhone#</PhoneNumber>
			#ShipperPagerIndicator#
			#ShipperFaxIndicator#
			#ShipperEmailIndicator#
		</Contact>
		<Address>
			<Line1>#ATTRIBUTES.ShipperStreet#</Line1>
			#ShipperStreet2Indicator#
			<City>#ATTRIBUTES.ShipperCity#</City>
			<StateOrProvinceCode>#ATTRIBUTES.ShipperState#</StateOrProvinceCode>
			<PostalCode>#ATTRIBUTES.ShipperZip#</PostalCode>
			<CountryCode>#ATTRIBUTES.ShipperCountry#</CountryCode>
		</Address>
	</Origin>
	<Destination>
		<Contact>
			<PersonName>#ATTRIBUTES.ShipToContactName#</PersonName>
			<CompanyName>#ATTRIBUTES.ShipToCompany#</CompanyName>
			<Department>#Left(ATTRIBUTES.ShipToDept, 10)#</Department>
			<PhoneNumber>#ATTRIBUTES.ShipToPhone#</PhoneNumber>
			<PagerNumber>#ATTRIBUTES.ShipToPager#</PagerNumber>
			<FaxNumber>#ATTRIBUTES.ShipToFax#</FaxNumber>
			<E-MailAddress>#ATTRIBUTES.ShipToEmail#</E-MailAddress>
		</Contact>
		<Address>
			<Line1>#ATTRIBUTES.ShipToStreet#</Line1>
			<Line2>#ATTRIBUTES.ShipToStreet2#</Line2>
			<City>#ATTRIBUTES.ShipToCity#</City>
			<StateOrProvinceCode>#ATTRIBUTES.ShipToState#</StateOrProvinceCode>
			<PostalCode>#ATTRIBUTES.ShipToZip#</PostalCode>
			<CountryCode>#ATTRIBUTES.ShipToCountry#</CountryCode>
		</Address>
	</Destination>
	<Payment>
		<PayorType>#ATTRIBUTES.PayorType#</PayorType>
		#PayorIndicator#
		#CreditCardIndicator#
	</Payment>
	#ReferenceElementIdcicator#
	#DimensionsIndicator#
	#DeclaredValueIndicator#
	#SSIndicator#
	#HomeDelivIndicator#
	<Label>
		<Type>#ATTRIBUTES.LabelType#</Type>
		<ImageType>#ATTRIBUTES.LabelImageType#</ImageType>
		<LabelStockOrientation>#ATTRIBUTES.LabelStockOrientation#</LabelStockOrientation>
		#ThermalLabelIndicator#
	</Label>
	#IntlIndicator#
	</FDXShipRequest>';
	</cfscript>

	<cfhttp method="post" url="#ATTRIBUTES.FedexServer#" resolveurl="yes" port="443" timeout="#ATTRIBUTES.TimeOut#">
		<cfhttpparam name="XML" type="xml" value="#ATTRIBUTES.XMLRequestInput#">
	</cfhttp>
	
	<cfif IsDefined("cfhttp.FileContent") AND Len(cfhttp.FileContent) gt 0> <!--- Error check open to see if a valid content was received by cfhttp --->
		
		<!--- Debug Mode --->
		<cfif ATTRIBUTES.Debug eq "True">
			<cffile action="WRITE" file="#ATTRIBUTES.ServerFilePath##trailingSlash#Debug#trailingSlash#ShipRequest.xml" output="#ATTRIBUTES.XMLRequestInput#" addnewline="No" nameconflict="overwrite">
			<cffile action="WRITE" file="#ATTRIBUTES.ServerFilePath##trailingSlash#Debug#trailingSlash#ShipResponse.xml" output="#cfhttp.FileContent#" addnewline="No" nameconflict="overwrite">
			<cfset CALLER.stFedexShipResponse = XmlParse(Trim(cfhttp.FileContent))>
			<cfoutput>
				<cfdump var="#CALLER.stFedexShipResponse#">
			</cfoutput>
			<cfabort>
		</cfif>
		<!--- Debug Mode --->
 		
		<!--- Process live response --->
		<cfset CALLER.stFedexShipResponse = XmlParse(Trim(cfhttp.FileContent))>
		
		<cfif StructKeyExists(CALLER.stFedexShipResponse, "FDXShipReply")>
		
			<!--- Label Creation open --->
			<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply, "Labels")>
				<!--- Create label png image --->
				<cfset CALLER.TrackingNumber = #CALLER.stFedexShipResponse.FDXShipReply.Tracking.TrackingNumber.XmlText#>
				<cfset base64Label = toBinary("#CALLER.stFedexShipResponse.FDXShipReply.Labels.OutboundLabel.XmlText#")>
				<cffile action="WRITE" file="#ATTRIBUTES.ServerFilePath##trailingSlash#Labels#trailingSlash##CALLER.TrackingNumber#.png" output="#base64Label#" addnewline="No" nameconflict="overwrite">
				
				<!--- Create html page to display label image for printing --->
				<cfset CALLER.LabelPageName = #CALLER.TrackingNumber# & ".html">
			</cfif>
			<!--- Label Creation close --->
			
			<!--- Create rate query to store all rate related data for this shipment --->
			<cfif IsDefined("CALLER.stFedexShipResponse.FDXShipReply.Error.Code.XmlText")>
				<!--- There was an error get default shipping rate for this service level --->
				<cfset CALLER.FedexError = "1">
				<cfset CALLER.FedexErrorDesc = "#CALLER.stFedexShipResponse.FDXShipReply.Error.Message.XmlText#">
			
			<cfelse>
				<!--- 
				** Need to account for different elements returned based on Express, Ground request **
				FDXE
				FDXG
				ALL
				 --->
				 
				<cfset CALLER.FedexError = "0">
				<cfset CALLER.FedexErrorDesc = "Success">
				<cfset CALLER.qFedexRateQuery = QueryNew("DimWeightUsed, Oversize, RateScale, RateZone, CurrencyCode, BilledWeight, DimWeight, 
				DiscBaseFreightCharges, DiscDiscountAmt, DiscNetTotalCharge, DiscBaseTotalCharges, DiscTotalRebate, DiscSurchargeCOD, DiscSurchargeSatPickup, DiscSurchargeDV, DiscSurchargeAOD, DiscSurchargeAD, DiscSurchargeAutoPOD,
					DiscSurchargeHomeDelivery, DiscSurchargeHomeDeliveryDC, DiscSurchargeHomeDeliveryEvening, DiscSurchargeHomeDeliverySig,
					DiscSurchargeNonStd, DiscSurchargeHazMat, DiscSurchargeRes, DiscSurchargeVAT, DiscSurchargeHST, DiscSurchargeGST, DiscSurchargePST,
					DiscSurchargeSatDeliv, DiscSurchargeDG, DiscSurchargeOutOfPickupArea, DiscSurchargeOutOfDeliveryArea, DiscSurchargeInsidePickup, DiscSurchargeInsideDeliv,
					DiscSurchargePryAlert, DiscSurchargeDelivArea, DiscSurchargeFuel, DiscSurchargeFICE, DiscSurchargeOffshore, DiscSurchargeOther, DiscSurchargeTotal, 
				ListBaseFreightCharges, ListDiscountAmt, ListNetTotalCharge, ListTotalRebate, ListSurchargeCOD, ListSurchargeSatPickup, ListSurchargeDV, ListSurchargeAOD, ListSurchargeAD, ListSurchargeAutoPOD,
					ListSurchargeHomeDelivery, ListSurchargeHomeDeliveryDC, ListSurchargeHomeDeliveryEvening, ListSurchargeHomeDeliverySig,
					ListSurchargeNonStd, ListSurchargeHazMat, ListSurchargeRes, ListSurchargeVAT, ListSurchargeHST, ListSurchargeGST, ListSurchargePST,
					ListSurchargeSatDeliv, ListSurchargeDG, ListSurchargeOutOfPickupArea, ListSurchargeOutOfDeliveryArea, ListSurchargeInsidePickup, ListSurchargeInsideDeliv,
					ListSurchargePryAlert, ListSurchargeDelivArea, ListSurchargeFuel, ListSurchargeFICE, ListSurchargeOffshore, ListSurchargeOther, ListSurchargeTotal,
					VariableHandling, ListVariableHandlingCharge, TotalCustomerCharge, ListTotalCustomerCharge, MultiweightVariableHandlingCharge, MultiweightTotalCustomerCharge")>
				<cfset newRow  = QueryAddRow(CALLER.qFedexRateQuery, 1)>
				
				<!--- ** Inner CP1 ** Check for existence of estimated charges element --->
				<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply, "EstimatedCharges")>
		
					<!--- FDXE Only --->
					<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges, "DimWeightUsed")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DimWeightUsed", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DimWeightUsed.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DimWeightUsed", "", 1)>				
					</cfif>
					<!--- FDXG Only --->
					<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges, "Oversize")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "Oversize", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.Oversize.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "Oversize", "", 1)>				
					</cfif>
					<!--- FDXE Only --->
					<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges, "RateScale")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "RateScale", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.RateScale.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "RateScale", "", 1)>				
					</cfif>
					<!--- FDXE Only --->
					<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges, "RateZone")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "RateZone", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.RateZone.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "RateZone", "", 1)>				
					</cfif>
					<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges, "CurrencyCode")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "CurrencyCode", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.CurrencyCode.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "CurrencyCode", "", 1)>				
					</cfif>
					<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges, "BilledWeight")>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "BilledWeight", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.BilledWeight.XmlText, 1)>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "BilledWeight", "", 1)>				
					</cfif>
					
					<!--- Discount Charges element - present in both FDXE and FDXG requests, for FDXG request this is only node returned --->
					<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges, "DiscountedCharges")>
						<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges, "BaseCharge")>
							<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscBaseFreightCharges", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.BaseCharge.XmlText, 1)>
							<cfset nBaseCharge = CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.BaseCharge.XmlText>
						<cfelse>
							<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscBaseFreightCharges", "0", 1)>				
							<cfset nBaseCharge = 0>
						</cfif>
						<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges, "TotalDiscount")>
							<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscDiscountAmt", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.TotalDiscount.XmlText, 1)>
						<cfelse>
							<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscDiscountAmt", "0", 1)>				
						</cfif>
						<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges, "NetCharge")>
							<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscNetTotalCharge", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.NetCharge.XmlText, 1)>
						<cfelse>
							<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscNetTotalCharge", "0", 1)>				
						</cfif>
						<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges, "TotalRebate")>
							<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscTotalRebate", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.TotalRebate.XmlText, 1)>
						<cfelse>
							<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscTotalRebate", "", 1)>				
						</cfif>
						<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges, "TotalSurcharge")>
							<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeTotal", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.TotalSurcharge.XmlText, 1)>
							<cfset nBaseSurCharge = CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.TotalSurcharge.XmlText>
						<cfelse>
							<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeTotal", "0", 1)>
							<cfset nBaseSurCharge = 0>		
						</cfif>
							<cfset nTotalCharge = nBaseCharge + nBaseSurCharge>
							<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscBaseTotalCharges", nTotalCharge, 1)>
							
						<!--- Anyone for a surcharge or 10 or 100!! --->
						<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges, "Surcharges")>
							<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges, "COD")>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeCOD", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges.COD.XmlText, 1)>
							<cfelse>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeCOD", "", 1)>				
							</cfif>
							<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges, "SaturdayPickup")>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeSatPickup", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges.SaturdayPickup.XmlText, 1)>
							<cfelse>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeSatPickup", "", 1)>				
							</cfif>
							<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges, "DeclaredValue")>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeDV", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges.DeclaredValue.XmlText, 1)>
							<cfelse>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeDV", "", 1)>				
							</cfif>
							<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges, "AOD")>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeAOD", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges.AOD.XmlText, 1)>
							<cfelse>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeAOD", "", 1)>				
							</cfif>
							<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges, "AppointmentDelivery")>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeAD", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges.AppointmentDelivery.XmlText, 1)>
							<cfelse>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeAD", "", 1)>				
							</cfif>
							<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges, "AutoPOD")>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeAutoPOD", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges.AutoPOD.XmlText, 1)>
							<cfelse>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeAutoPOD", "", 1)>				
							</cfif>
							<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges, "HomeDelivery")>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeHomeDelivery", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges.HomeDelivery.XmlText, 1)>
							<cfelse>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeHomeDelivery", "", 1)>				
							</cfif>
							<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges, "HomeDeliveryDateCertain")>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeHomeDeliveryDC", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges.HomeDeliveryDateCertain.XmlText, 1)>
							<cfelse>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeHomeDeliveryDC", "", 1)>				
							</cfif>
							<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges, "HomeDeliveryEveningDelivery")>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeHomeDeliveryEvening", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges.HomeDeliveryEveningDelivery.XmlText, 1)>
							<cfelse>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeHomeDeliveryEvening", "", 1)>				
							</cfif>
							<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges, "HomeDeliverySignature")>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeHomeDeliverySig", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges.HomeDeliverySignature.XmlText, 1)>
							<cfelse>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeHomeDeliverySig", "", 1)>				
							</cfif>
							<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges, "NonStandardContainer")>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeNonStd", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges.NonStandardContainer.XmlText, 1)>
							<cfelse>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeNonStd", "", 1)>				
							</cfif>
							<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges, "HazardousMaterials")>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeHazMat", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges.HazardousMaterials.XmlText, 1)>
							<cfelse>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeHazMat", "", 1)>				
							</cfif>
							<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges, "Residential")>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeRes", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges.Residential.XmlText, 1)>
							<cfelse>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeRes", "", 1)>				
							</cfif>
							<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges, "VAT")>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeVAT", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges.VAT.XmlText, 1)>
							<cfelse>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeVAT", "", 1)>				
							</cfif>
							<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges, "HSTSurcharge")>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeHST", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges.HSTSurcharge.XmlText, 1)>
							<cfelse>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeHST", "", 1)>				
							</cfif>
							<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges, "GSTSurcharge")>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeGST", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges.GSTSurcharge.XmlText, 1)>
							<cfelse>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeGST", "", 1)>				
							</cfif>
							<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges, "PSTSurcharge")>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargePST", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges.PSTSurcharge.XmlText, 1)>
							<cfelse>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargePST", "", 1)>				
							</cfif>
							<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges, "SaturdayDelivery")>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeSatDeliv", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges.SaturdayDelivery.XmlText, 1)>
							<cfelse>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeSatDeliv", "", 1)>				
							</cfif>
							<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges, "DangerousGoods")>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeDG", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges.DangerousGoods.XmlText, 1)>
							<cfelse>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeDG", "", 1)>				
							</cfif>
							<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges, "OutOfPickupOrH3Area")>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeOutOfPickupArea", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges.OutOfPickupOrH3Area.XmlText, 1)>
							<cfelse>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeOutOfPickupArea", "", 1)>				
							</cfif>
							<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges, "OutOfDeliveryOrH3Area")>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeOutOfDeliveryArea", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges.OutOfDeliveryOrH3Area.XmlText, 1)>
							<cfelse>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeOutOfDeliveryArea", "", 1)>				
							</cfif>
							<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges, "InsidePickup")>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeInsidePickup", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges.InsidePickup.XmlText, 1)>
							<cfelse>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeInsidePickup", "", 1)>				
							</cfif>
							<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges, "InsideDelivery")>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeInsideDeliv", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges.InsideDelivery.XmlText, 1)>
							<cfelse>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeInsideDeliv", "", 1)>				
							</cfif>
							<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges, "PriorityAlert")>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargePryAlert", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges.PriorityAlert.XmlText, 1)>
							<cfelse>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargePryAlert", "", 1)>				
							</cfif>
							<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges, "DeliveryArea")>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeDelivArea", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges.DeliveryArea.XmlText, 1)>
							<cfelse>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeDelivArea", "", 1)>				
							</cfif>
							<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges, "Fuel")>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeFuel", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges.Fuel.XmlText, 1)>
							<cfelse>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeFuel", "", 1)>				
							</cfif>
							<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges, "FICE")>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeFICE", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges.FICE.XmlText, 1)>
							<cfelse>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeFICE", "", 1)>				
							</cfif>
							<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges, "Offshore")>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeOffshore", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges.Offshore.XmlText, 1)>
							<cfelse>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeOffshore", "", 1)>				
							</cfif>
		
							<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges, "Other")>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeOther", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.DiscountedCharges.Surcharges.Other.XmlText, 1)>
							<cfelse>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeOther", "", 1)>				
							</cfif>
						</cfif>
						<!--- Anyone for a surcharge or 10 or 100!! CLOSE --->
						
					<cfelse>
						<!--- Discount charges element unavailable - this should not be possible as this is primary charges node --->
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscBaseFreightCharges", "", 1)>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscDiscountAmt", "", 1)>				
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscNetTotalCharge", "", 1)>				
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscTotalRebate", "", 1)>			
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeCOD", "", 1)>				
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeSatPickup", "", 1)>				
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeDV", "", 1)>				
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeAOD", "", 1)>				
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeAD", "", 1)>				
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeAutoPOD", "", 1)>				
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeHomeDelivery", "", 1)>				
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeHomeDeliveryDC", "", 1)>				
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeHomeDeliveryEvening", "", 1)>				
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeHomeDeliverySig", "", 1)>				
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeNonStd", "", 1)>				
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeHazMat", "", 1)>				
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeRes", "", 1)>				
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeVAT", "", 1)>				
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeHST", "", 1)>				
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeGST", "", 1)>				
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargePST", "", 1)>				
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeDG", "", 1)>				
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeOutOfPickupArea", "", 1)>				
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeOutOfDeliveryArea", "", 1)>				
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeInsidePickup", "", 1)>				
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeInsideDeliv", "", 1)>				
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeDelivArea", "", 1)>				
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeFuel", "", 1)>				
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeFICE", "", 1)>				
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeOffshore", "", 1)>				
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "DiscSurchargeTotal", "", 1)>
					</cfif>
					<!--- Discount Charges element - CLOSE --->
					
					<!--- List Charges element --->
					<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges, "ListCharges")>
						<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges, "BaseCharge")>
							<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListBaseFreightCharges", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.BaseCharge.XmlText, 1)>
						<cfelse>
							<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListBaseFreightCharges", "", 1)>				
						</cfif>
						<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges, "TotalDiscount")>
							<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListDiscountAmt", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.TotalDiscount.XmlText, 1)>
						<cfelse>
							<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListDiscountAmt", "", 1)>				
						</cfif>
						<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges, "NetCharge")>
							<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListNetTotalCharge", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.NetCharge.XmlText, 1)>
						<cfelse>
							<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListNetTotalCharge", "", 1)>				
						</cfif>
						<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges, "TotalRebate")>
							<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListTotalRebate", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.TotalRebate.XmlText, 1)>
						<cfelse>
							<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListTotalRebate", "", 1)>				
						</cfif>
						<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges, "TotalSurcharge")>
							<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeTotal", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.TotalSurcharge.XmlText, 1)>
						<cfelse>
							<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeTotal", "", 1)>				
						</cfif>
						<!--- Anyone for a surcharge or 10 or 100!! --->
						<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges, "Surcharges")>
							<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges, "COD")>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeCOD", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges.COD.XmlText, 1)>
							<cfelse>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeCOD", "", 1)>				
							</cfif>
							<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges, "SaturdayPickup")>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeSatPickup", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges.SaturdayPickup.XmlText, 1)>
							<cfelse>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeSatPickup", "", 1)>				
							</cfif>
							<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges, "DeclaredValue")>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeDV", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges.DeclaredValue.XmlText, 1)>
							<cfelse>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeDV", "", 1)>				
							</cfif>
							<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges, "AOD")>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeAOD", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges.AOD.XmlText, 1)>
							<cfelse>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeAOD", "", 1)>				
							</cfif>
							<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges, "AppointmentDelivery")>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeAD", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges.AppointmentDelivery.XmlText, 1)>
							<cfelse>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeAD", "", 1)>				
							</cfif>
							<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges, "AutoPOD")>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeAutoPOD", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges.AutoPOD.XmlText, 1)>
							<cfelse>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeAutoPOD", "", 1)>				
							</cfif>
							<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges, "HomeDelivery")>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeHomeDelivery", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges.HomeDelivery.XmlText, 1)>
							<cfelse>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeHomeDelivery", "", 1)>				
							</cfif>
							<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges, "HomeDeliveryDateCertain")>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeHomeDeliveryDC", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges.HomeDeliveryDateCertain.XmlText, 1)>
							<cfelse>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeHomeDeliveryDC", "", 1)>				
							</cfif>
							<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges, "HomeDeliveryEveningDelivery")>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeHomeDeliveryEvening", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges.HomeDeliveryEveningDelivery.XmlText, 1)>
							<cfelse>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeHomeDeliveryEvening", "", 1)>				
							</cfif>
							<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges, "HomeDeliverySignature")>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeHomeDeliverySig", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges.HomeDeliverySignature.XmlText, 1)>
							<cfelse>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeHomeDeliverySig", "", 1)>				
							</cfif>
							<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges, "NonStandardContainer")>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeNonStd", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges.NonStandardContainer.XmlText, 1)>
							<cfelse>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeNonStd", "", 1)>				
							</cfif>
							<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges, "HazardousMaterials")>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeHazMat", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges.HazardousMaterials.XmlText, 1)>
							<cfelse>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeHazMat", "", 1)>				
							</cfif>
							<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges, "Residential")>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeRes", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges.Residential.XmlText, 1)>
							<cfelse>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeRes", "", 1)>				
							</cfif>
							<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges, "VAT")>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeVAT", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges.VAT.XmlText, 1)>
							<cfelse>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeVAT", "", 1)>				
							</cfif>
							<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges, "HSTSurcharge")>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeHST", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges.HSTSurcharge.XmlText, 1)>
							<cfelse>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeHST", "", 1)>				
							</cfif>
							<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges, "GSTSurcharge")>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeGST", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges.GSTSurcharge.XmlText, 1)>
							<cfelse>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeGST", "", 1)>				
							</cfif>
							<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges, "PSTSurcharge")>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargePST", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges.PSTSurcharge.XmlText, 1)>
							<cfelse>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargePST", "", 1)>				
							</cfif>
							<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges, "SaturdayDelivery")>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeSatDeliv", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges.SaturdayDelivery.XmlText, 1)>
							<cfelse>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeSatDeliv", "", 1)>				
							</cfif>
							<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges, "DangerousGoods")>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeDG", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges.DangerousGoods.XmlText, 1)>
							<cfelse>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeDG", "", 1)>				
							</cfif>
							<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges, "OutOfPickupOrH3Area")>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeOutOfPickupArea", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges.OutOfPickupOrH3Area.XmlText, 1)>
							<cfelse>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeOutOfPickupArea", "", 1)>				
							</cfif>
							<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges, "OutOfDeliveryOrH3Area")>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeOutOfDeliveryArea", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges.OutOfDeliveryOrH3Area.XmlText, 1)>
							<cfelse>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeOutOfDeliveryArea", "", 1)>				
							</cfif>
							<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges, "InsidePickup")>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeInsidePickup", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges.InsidePickup.XmlText, 1)>
							<cfelse>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeInsidePickup", "", 1)>				
							</cfif>
							<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges, "InsideDelivery")>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeInsideDeliv", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges.InsideDelivery.XmlText, 1)>
							<cfelse>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeInsideDeliv", "", 1)>				
							</cfif>
							<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges, "PriorityAlert")>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargePryAlert", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges.PriorityAlert.XmlText, 1)>
							<cfelse>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargePryAlert", "", 1)>				
							</cfif>
							<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges, "DeliveryArea")>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeDelivArea", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges.DeliveryArea.XmlText, 1)>
							<cfelse>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeDelivArea", "", 1)>				
							</cfif>
							<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges, "Fuel")>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeFuel", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges.Fuel.XmlText, 1)>
							<cfelse>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeFuel", "", 1)>				
							</cfif>
							<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges, "FICE")>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeFICE", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges.FICE.XmlText, 1)>
							<cfelse>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeFICE", "", 1)>				
							</cfif>
							<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges, "Offshore")>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeOffshore", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges.Offshore.XmlText, 1)>
							<cfelse>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeOffshore", "", 1)>				
							</cfif>
							<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges, "Other")>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeOther", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.ListCharges.Surcharges.Other.XmlText, 1)>
							<cfelse>
								<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeOther", "", 1)>				
							</cfif>
						</cfif>
					
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListBaseFreightCharges", "", 1)>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListDiscountAmt", "", 1)>				
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListNetTotalCharge", "", 1)>				
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListTotalRebate", "", 1)>				
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeCOD", "", 1)>				
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeSatPickup", "", 1)>				
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeDV", "", 1)>				
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeAOD", "", 1)>				
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeAD", "", 1)>				
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeAutoPOD", "", 1)>				
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeHomeDelivery", "", 1)>				
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeHomeDeliveryDC", "", 1)>				
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeHomeDeliveryEvening", "", 1)>				
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeHomeDeliverySig", "", 1)>				
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeNonStd", "", 1)>				
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeHazMat", "", 1)>				
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeRes", "", 1)>				
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeVAT", "", 1)>				
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeHST", "", 1)>				
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeGST", "", 1)>				
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargePST", "", 1)>				
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeDG", "", 1)>				
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeOutOfPickupArea", "", 1)>				
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeOutOfDeliveryArea", "", 1)>				
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeInsidePickup", "", 1)>				
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeInsideDeliv", "", 1)>				
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeDelivArea", "", 1)>				
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeFuel", "", 1)>				
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeFICE", "", 1)>				
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeOffshore", "", 1)>				
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListSurchargeTotal", "", 1)>
					</cfif>
					<!--- List Charges element - CLOSE --->
					
					<!--- Variable Handling Elements --->
					<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges, "VariableHandling")>
						<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.VariableHandling, "VariableHandlingCharge")>
							<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "VariableHandling", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.VariableHandling.VariableHandlingCharge.XmlText, 1)>
						<cfelse>
							<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "VariableHandling", "", 1)>
						</cfif>
						<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.VariableHandling, "ListVariableHandlingCharge")>
							<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListVariableHandlingCharge", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.VariableHandling.ListVariableHandlingCharge.XmlText, 1)>
						<cfelse>
							<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListVariableHandlingCharge", "", 1)>
						</cfif>
						<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.VariableHandling, "TotalCustomerCharge")>
							<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "TotalCustomerCharge", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.VariableHandling.TotalCustomerCharge.XmlText, 1)>
						<cfelse>
							<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "TotalCustomerCharge", "", 1)>
						</cfif>
						<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.VariableHandling, "ListTotalCustomerCharge")>
							<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListTotalCustomerCharge", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.VariableHandling.ListTotalCustomerCharge.XmlText, 1)>
						<cfelse>
							<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListTotalCustomerCharge", "", 1)>
						</cfif>
						<!--- FDXG Only --->
						<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.VariableHandling, "MultiweightVariableHandlingCharge")>
							<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "MultiweightVariableHandlingCharge", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.VariableHandling.MultiweightVariableHandlingCharge.XmlText, 1)>
						<cfelse>
							<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "MultiweightVariableHandlingCharge", "", 1)>
						</cfif>
						<!--- FDXG Only --->
						<cfif StructKeyExists(CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.VariableHandling, "MultiweightTotalCustomerCharge")>
							<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "MultiweightTotalCustomerCharge", CALLER.stFedexShipResponse.FDXShipReply.EstimatedCharges.VariableHandling.MultiweightTotalCustomerCharge.XmlText, 1)>
						<cfelse>
							<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "MultiweightTotalCustomerCharge", "", 1)>
						</cfif>
					<cfelse>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "VariableHandling", "", 1)>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListVariableHandlingCharge", "", 1)>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "TotalCustomerCharge", "", 1)>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "ListTotalCustomerCharge", "", 1)>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "MultiweightVariableHandlingCharge", "", 1)>
						<cfset temp = QuerySetCell(CALLER.qFedexRateQuery, "MultiweightTotalCustomerCharge", "", 1)>
					</cfif>
					<!--- Variable Handling Elements CLOSE --->
					
				<cfelse> 
				<!--- ** Inner CP1 ** Check for existence of estimated charges element not successful --->
					<!--- Charge not retrieved for some reason set empty columns --->
					<cfset CALLER.FedexError = "2">
					<cfset CALLER.FedexErrorDesc = "Fedex returned a valid response without a base rate">
				</cfif>
				<!--- ** Inner CP1 ** Check for existence of estimated charges element close --->
		
				
			</cfif>
			<!--- Create rate query to store all rate related data for this shipment close --->
		
		<cfelse>
			<!--- Hard error, FDXSHIPREPLY not present --->
			<cfset CALLER.FedexError = "2">
			<cfset CALLER.FedexErrorDesc = "HARD ERROR: non valid XMl response received from Fedex, check your request is valid">
		</cfif>
		
	<cfelse> <!--- Error check to see if a valid content was received by cfhttp --->
		<cfset CALLER.FedexError = "2">
		<cfset CALLER.FedexErrorDesc = "Hard Error: Custom Tag did not receive a valid response from Fedex, please check your network connections">
	</cfif> <!--- Error check close to see if a valid content was received by cfhttp --->
	
 </cfcase>
 <!--- Ship Request close  --->
 
 <!--- ***** 2.0 ****** --->
 <!--- Ship Delete Request  --->
 <cfcase value="ShipDeleteRequest">
 
 	<cfscript>
		ATTRIBUTES.XMLRequestInput = '<?xml version="1.0" encoding="UTF-8"?>
		<FDXShipDeleteRequest xmlns:api="http://www.fedex.com/fsmapi" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="FDXShipDeleteRequest.xsd">
		<RequestHeader>
			<CustomerTransactionIdentifier>#ATTRIBUTES.DeleteShipmentTransactionString#</CustomerTransactionIdentifier>
			<AccountNumber>#ATTRIBUTES.AccountNumber#</AccountNumber>
			<MeterNumber>#ATTRIBUTES.FedexIndentifier#</MeterNumber>
			<CarrierCode>#ATTRIBUTES.RateRequestType#</CarrierCode>
		</RequestHeader>
		<TrackingNumber>#ATTRIBUTES.TrackingNumber#</TrackingNumber>
		</FDXShipDeleteRequest>';
	</cfscript>
	
	<cfhttp method="post" url="#ATTRIBUTES.FedexServer#" resolveurl="yes" port="443" timeout="#ATTRIBUTES.TimeOut#">
		<cfhttpparam name="XML" type="xml" value="#ATTRIBUTES.XMLRequestInput#">
	</cfhttp>
	
	<cfif IsDefined("cfhttp.FileContent") AND Len(cfhttp.FileContent) gt 0> <!--- Error check open to see if a valid content was received by cfhttp --->
		
		<!--- Debug Mode --->
		<cfif ATTRIBUTES.Debug eq "True">
			<cffile action="WRITE" file="#ATTRIBUTES.ServerFilePath##trailingSlash#Debug#trailingSlash#ShipDeleteRequest.xml" output="#ATTRIBUTES.XMLRequestInput#" addnewline="No" nameconflict="overwrite">
			<cffile action="WRITE" file="#ATTRIBUTES.ServerFilePath##trailingSlash#Debug#trailingSlash#ShipDeleteResponse.xml" output="#cfhttp.FileContent#" addnewline="No" nameconflict="overwrite">
			<cfset CALLER.stFdxShipDeleteResponse = XmlParse(Trim(cfhttp.FileContent))>
			<cfoutput>
				<cfdump var="#CALLER.stFdxShipDeleteResponse#">
			</cfoutput>
			<cfabort>
		</cfif>
		<!--- Debug Mode --->
 		
		<!--- Process live response --->
		<cfset CALLER.stFdxShipDeleteResponse = XmlParse(Trim(cfhttp.FileContent))>
		
		<cfif StructKeyExists(CALLER.stFdxShipDeleteResponse.FDXShipDeleteReply, "Error")>
			<cfif StructKeyExists(CALLER.stFdxShipDeleteResponse.FDXShipDeleteReply.Error, "Code")>
				<cfset CALLER.FedexError = CALLER.stFdxShipDeleteResponse.FDXShipDeleteReply.Error.Code.XmlText>
				<cfset CALLER.FedexErrorDesc = CALLER.stFdxShipDeleteResponse.FDXShipDeleteReply.Error.Message.XmlText>

			<cfelse>
				<cfset CALLER.FedexError = "2">
				<cfset CALLER.FedexErrorDesc = "Hard Error: Fedex Servers returned a Malformed XML document/Invalid response">
				<!--- Error: no customer transaction identifier present in replyHeader - Malformed XML document received from Fedex --->
			</cfif>

		<cfelseif StructKeyExists(CALLER.stFdxShipDeleteResponse.FDXShipDeleteReply, "ReplyHeader")>
			<cfif StructKeyExists(CALLER.stFdxShipDeleteResponse.FDXShipDeleteReply.ReplyHeader, "CustomerTransactionIdentifier")>
				<cfset CALLER.DeleteIdentifier = CALLER.stFdxShipDeleteResponse.FDXShipDeleteReply.ReplyHeader.CustomerTransactionIdentifier.XmlText>
				<cfif CALLER.DeleteIdentifier eq ATTRIBUTES.DeleteShipmentTransactionString>
					<cfset CALLER.FedexError = "0">
					<cfset CALLER.FedexErrorDesc = "Shipment was successfully deleted from Fedex Servers">
				</cfif>
			<cfelse>
				<cfset CALLER.FedexError = "2">
				<cfset CALLER.FedexErrorDesc = "Hard Error: Fedex Servers returned a Malformed XML document/Invalid response">
				<!--- Error: no customer transaction identifier present in replyHeader - Malformed XML document received from Fedex --->
			</cfif>
		<cfelse>
			<!--- Error - no valid element received --->
			<cfset CALLER.FedexError = "2">
			<cfset CALLER.FedexErrorDesc = "Hard Error: Fedex Servers returned a Malformed XML document/Invalid response">
		</cfif>
		
	<cfelse> <!--- Error check to see if a valid content was received by cfhttp --->
		<cfset CALLER.FedexError = "2">
		<cfset CALLER.FedexErrorDesc = "Hard Error: Custom Tag did not receive a valid response from Fedex, please check your network connections">
	</cfif> <!--- Error check close to see if a valid content was received by cfhttp --->
	
 </cfcase>
 <!--- Ship Delete Request Close  --->
 
</cfswitch>