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
</cfscript>

<cfparam name="ATTRIBUTES.ServerFilePath" default="#currentWorkingDir#">
<cfparam name="ATTRIBUTES.XMLVersion" default="1.0">
<cfparam name="ATTRIBUTES.USPSUserID" default="">
<cfparam name="ATTRIBUTES.USPSPassword" default="">
<cfparam name="ATTRIBUTES.USPSPremiumUserID" default="">
<cfparam name="ATTRIBUTES.USPSPremiumPassword" default="">
<cfparam name="ATTRIBUTES.Debug" default="FALSE">
<cfparam name="ATTRIBUTES.TestingEnvironment" default="FALSE">
<cfif ATTRIBUTES.TestingEnvironment eq "TRUE">
	<cfset ATTRIBUTES.USPSServer = "http://testing.shippingapis.com/ShippingAPITest.dll">
<cfelse>
	<cfset ATTRIBUTES.USPSServer = "http://production.shippingapis.com/ShippingAPI.dll">
</cfif>
<cfparam name="ATTRIBUTES.CannedRequest" default="FALSE">
<cfparam name="ATTRIBUTES.TimeOut" default="60">

<!--- Rates Request --->
<cfparam name="ATTRIBUTES.ServiceLevel" default="Priority">
<!--- 
Service Levels
==============
Express
First Class
Priority
Parcel
BPM (Bound Printed Matter)
Library
Media
 --->
<cfparam name="ATTRIBUTES.PackageID" default="0">
<cfparam name="ATTRIBUTES.PackageType" default="Flat Rate Envelope"> <!--- see Table T-1 in documentation for list of options --->
<cfparam name="ATTRIBUTES.PackageWeightLB" default="0">
<cfparam name="ATTRIBUTES.PackageWeightOZ" default="0">
<cfparam name="ATTRIBUTES.PackageMachinable" default="">
<cfparam name="ATTRIBUTES.PackageSize" default="Regular"> <!--- Regular | Large | Oversize see Table T-2 in documentation for explanation --->

<cfparam name="ATTRIBUTES.ShippingLabelType" default="3">
<cfparam name="ATTRIBUTES.ShippingLabelImage" default="GIF">
<cfparam name="ATTRIBUTES.ShipFromName" default=""> <!--- max 32 chars --->

<!--- Express Mail Label --->
<cfparam name="ATTRIBUTES.ShipFromFirstName" default="">
<cfparam name="ATTRIBUTES.ShipFromLastName" default=""> <!--- max 26 chars with First and last combined --->
<cfparam name="ATTRIBUTES.ShipFromPhone" default="">
<cfparam name="ATTRIBUTES.ShipToFirstName" default="">
<cfparam name="ATTRIBUTES.ShipToLastName" default=""> <!--- max 26 chars with First and last combined --->
<cfparam name="ATTRIBUTES.ShipToPhone" default="">
<cfparam name="ATTRIBUTES.ExpressMailFlatRate" default="False">
<cfparam name="ATTRIBUTES.ExpressMailValidateAddress" default="False">
<cfparam name="ATTRIBUTES.WaiverOfSignature" default="False">
<cfparam name="ATTRIBUTES.NoDeliverOnHoliday" default="False">
<cfparam name="ATTRIBUTES.NoDeliverOnWeekend" default="False">
<cfparam name="ATTRIBUTES.PostDatedLabelDate" default="">
<cfparam name="ATTRIBUTES.ChangeOfAddressNotification" default="False">
<cfparam name="ATTRIBUTES.ReferenceNumber" default="">
<cfparam name="ATTRIBUTES.EmailSenderName" default="">
<cfparam name="ATTRIBUTES.EmailSenderAddress" default="">
<cfparam name="ATTRIBUTES.EmailRecipientName" default="">
<cfparam name="ATTRIBUTES.EmailRecipientAddress" default="">
<!--- Express Mail Label --->

<cfparam name="ATTRIBUTES.ShipFromCompany" default=""> <!--- max 32 chars --->
<cfparam name="ATTRIBUTES.ShipFromAddress1" default=""> <!--- Street address --->
<cfparam name="ATTRIBUTES.ShipFromAddress2" default=""> <!--- used for Suite Number, Apt Number --->
<cfparam name="ATTRIBUTES.ShipFromCity" default="">
<cfparam name="ATTRIBUTES.ShipFromState" default="">
<cfparam name="ATTRIBUTES.ShipFromZip5" default="">
<cfparam name="ATTRIBUTES.ShipFromZip4Extended" default="">

<cfparam name="ATTRIBUTES.ShipToAddressID" default="0"> <!--- Used for Address validation only - Validation ID up to 5 at once --->
<cfparam name="ATTRIBUTES.ZipID" default="0"> <!--- Used for Address validation only - Validation ID up to 5 at once --->
<cfparam name="ATTRIBUTES.ShipToName" default=""> <!--- max 32 chars --->
<cfparam name="ATTRIBUTES.ShipToCompany" default=""> <!--- max 32 chars --->
<cfparam name="ATTRIBUTES.ShipToAddress1" default="">
<cfparam name="ATTRIBUTES.ShipToAddress2" default="">
<cfparam name="ATTRIBUTES.ShipToCity" default="">
<cfparam name="ATTRIBUTES.ShipToState" default="">
<cfparam name="ATTRIBUTES.ShipToZip5" default="">
<cfparam name="ATTRIBUTES.ShipToZip4Extended" default="">
<cfparam name="ATTRIBUTES.ShipToCountry" default="">
<cfparam name="ATTRIBUTES.SeparateReceipt" default="False">
<cfparam name="ATTRIBUTES.POBoxZip" default="">

<!--- Track/Confirm --->
<cfparam name="ATTRIBUTES.TrackingNumber" default="">

<cfswitch expression="#ATTRIBUTES.function#">
 
 <!--- Start USPS Domestics Rate request --->
 <cfcase value="RateDomesticRequest">
	
	<cfscript>
	if ( ATTRIBUTES.ServiceLevel eq "Parcel" ) {
		machinableIndicator = '<Machinable>True</Machinable>';
	}
	else {
		machinableIndicator = '';
	}
	
	ATTRIBUTES.XMLRequestInput = '<?xml version="#ATTRIBUTES.XMLVersion#"?>
	<RateV2Request USERID="#ATTRIBUTES.USPSUserID#" PASSWORD="#ATTRIBUTES.USPSPassword#">
		<Package ID="#ATTRIBUTES.PackageID#">
			<Service>#ATTRIBUTES.ServiceLevel#</Service>
			<ZipOrigination>#ATTRIBUTES.ShipFromZip5#</ZipOrigination>
			<ZipDestination>#ATTRIBUTES.ShipToZip5#</ZipDestination>
			<Pounds>#ATTRIBUTES.PackageWeightLB#</Pounds>
			<Ounces>#ATTRIBUTES.PackageWeightOZ#</Ounces>
			<Container>#ATTRIBUTES.PackageType#</Container>
			<Size>#ATTRIBUTES.PackageSize#</Size>
			#machinableIndicator#
		</Package>
	</RateV2Request>';
	</cfscript>
	
	<cfhttp method="post" url="#ATTRIBUTES.USPSServer#" resolveurl="yes" port="80" timeout="#ATTRIBUTES.TimeOut#">
		<cfhttpparam name="XML" type="xml" value="API=RateV2&XML=#ATTRIBUTES.XMLRequestInput#">
	</cfhttp>
	
	<cfset CALLER.stUSPSRateDomestic = XmlParse(Trim(cfhttp.FileContent))>
	
	<!---
		<cfdump var="#CALLER.stUSPSRateDomestic#">
	 --->
	
	<cfif IsDefined("CALLER.stUSPSRateDomestic.RateV2Response.PACKAGE.POSTAGE.XmlText")> <!--- Successful register response --->
		<cfset CALLER.USPSError = 0> <!--- No Error --->
		<cfset CALLER.USPSErrorDesc = "Success">
		
		<cfset CALLER.USPSDomesticRateQuery = QueryNew("FreightCharges, Pounds, Ounces, Service, Size, ZipDestination, ZipOrigin, Zone")>
		<!--- Pounds, Ounces, Service, Size, ZipDestination, ZipOrigination, Zone --->
		<cfset newRow  = QueryAddRow(CALLER.USPSDomesticRateQuery, 1)>
		<cfif StructKeyExists(CALLER.stUSPSRateDomestic.RateV2Response.Package.Postage, "Rate")>	
			<cfset temp = QuerySetCell(CALLER.USPSDomesticRateQuery, "FreightCharges", CALLER.stUSPSRateDomestic.RateV2Response.Package.Postage.Rate.XmlText)>
		<cfelse>
			<cfset temp = QuerySetCell(CALLER.USPSDomesticRateQuery, "FreightCharges", "0")>
		</cfif>
		<cfif StructKeyExists(CALLER.stUSPSRateDomestic.RateV2Response.Package, "Pounds")>	
			<cfset temp = QuerySetCell(CALLER.USPSDomesticRateQuery, "Pounds", CALLER.stUSPSRateDomestic.RateV2Response.Package.Pounds.XmlText)>
		<cfelse>
			<cfset temp = QuerySetCell(CALLER.USPSDomesticRateQuery, "Pounds", "")>
		</cfif>
		<cfif StructKeyExists(CALLER.stUSPSRateDomestic.RateV2Response.Package, "Ounces")>	
			<cfset temp = QuerySetCell(CALLER.USPSDomesticRateQuery, "Ounces", CALLER.stUSPSRateDomestic.RateV2Response.Package.Ounces.XmlText)>
		<cfelse>
			<cfset temp = QuerySetCell(CALLER.USPSDomesticRateQuery, "Ounces", "")>
		</cfif>
		<cfif StructKeyExists(CALLER.stUSPSRateDomestic.RateV2Response.Package, "Size")>	
			<cfset temp = QuerySetCell(CALLER.USPSDomesticRateQuery, "Size", CALLER.stUSPSRateDomestic.RateV2Response.Package.Size.XmlText)>
		<cfelse>
			<cfset temp = QuerySetCell(CALLER.USPSDomesticRateQuery, "Size", "")>
		</cfif>
		<cfif StructKeyExists(CALLER.stUSPSRateDomestic.RateV2Response.Package.Postage, "MailService")>	
			<cfset temp = QuerySetCell(CALLER.USPSDomesticRateQuery, "Service", CALLER.stUSPSRateDomestic.RateV2Response.Package.Postage.MailService.XmlText)>
		<cfelse>
			<cfset temp = QuerySetCell(CALLER.USPSDomesticRateQuery, "Service", "")>
		</cfif>
		<cfif StructKeyExists(CALLER.stUSPSRateDomestic.RateV2Response.Package, "ZipDestination")>	
			<cfset temp = QuerySetCell(CALLER.USPSDomesticRateQuery, "ZipDestination", CALLER.stUSPSRateDomestic.RateV2Response.Package.ZipDestination.XmlText)>
		<cfelse>
			<cfset temp = QuerySetCell(CALLER.USPSDomesticRateQuery, "ZipDestination", "")>
		</cfif>
		<cfif StructKeyExists(CALLER.stUSPSRateDomestic.RateV2Response.Package, "ZipOrigination")>	
			<cfset temp = QuerySetCell(CALLER.USPSDomesticRateQuery, "ZipOrigin", CALLER.stUSPSRateDomestic.RateV2Response.Package.ZipOrigination.XmlText)>
		<cfelse>
			<cfset temp = QuerySetCell(CALLER.USPSDomesticRateQuery, "ZipOrigin", "")>
		</cfif>
		<cfif StructKeyExists(CALLER.stUSPSRateDomestic.RateV2Response.Package, "Zone")>	
			<cfset temp = QuerySetCell(CALLER.USPSDomesticRateQuery, "Zone", CALLER.stUSPSRateDomestic.RateV2Response.Package.Zone.XmlText)>
		<cfelse>
			<cfset temp = QuerySetCell(CALLER.USPSDomesticRateQuery, "Zone", "")>
		</cfif>
	<cfelseif IsDefined("CALLER.stUSPSRateDomestic.RateV2Response.PACKAGE.Error.Description.XmlText")>
		<cfset CALLER.USPSError = 1>
		<cfset CALLER.USPSErrorDesc = CALLER.stUSPSRateDomestic.RateV2Response.PACKAGE.Error.Description.XmlText>
	<cfelse>
		<cfset CALLER.USPSError = 2>
		<cfif IsDefined("CALLER.stUSPSRateDomestic.RateV2Response.PACKAGE.Error.Description.XmlText")>
			<cfset CALLER.USPSErrorDesc = CALLER.stUSPSRateDomestic.RateV2Response.PACKAGE.Error.Description.XmlText>
		</cfif>
	</cfif>
		
 </cfcase>
 <!--- End USPS Domestics Rate request --->
 
  <!--- Start USPS International Rate request --->
 <cfcase value="RateIntlRequest">
	
	<cfscript>
	ATTRIBUTES.XMLRequestInput = '<?xml version="#ATTRIBUTES.XMLVersion#"?>
	<IntlRateRequest USERID="#ATTRIBUTES.USPSUserID#" PASSWORD="#ATTRIBUTES.USPSPassword#">
		<Package ID="#ATTRIBUTES.PackageID#">
			<Pounds>#ATTRIBUTES.PackageWeightLB#</Pounds>
			<Ounces>#ATTRIBUTES.PackageWeightOZ#</Ounces>
			<MailType>#ATTRIBUTES.PackageType#</MailType>
			<Country>#ATTRIBUTES.ShipToCountry#</Country>
		</Package>
	</IntlRateRequest>';
	</cfscript>
	
	<cfhttp method="post" url="#ATTRIBUTES.USPSServer#" resolveurl="yes" port="80" timeout="#ATTRIBUTES.TimeOut#">
		<cfhttpparam name="XML" type="xml" value="API=IntlRate&XML=#ATTRIBUTES.XMLRequestInput#">
	</cfhttp>
	
	<cfset CALLER.stUSPSRateIntl = XmlParse(cfhttp.FileContent)>
	
	<cfif NOT IsDefined("CALLER.stUSPSRateIntl.IntlRateResponse.Package.Error.Description.XmlText")>
		<cfset CALLER.USPSError = 0>
		<cfset CALLER.USPSIntlRateErrorDesc = "Success">

		 <!--- Package variables query --->
		 <!--- 
		 AreasServed  	  
		 CustomsForms   	  
		 ExpressMail   	  
		 Observations   	  
		 Prohibitions   	  
		 Restrictions
		   --->
		<cfset CALLER.USPSIntlRateQuery = QueryNew("AreasServed, CustomsForms, ExpressMail, Observations, Prohibitions, Restrictions")>
		<cfset newRow  = QueryAddRow(CALLER.USPSIntlRateQuery, 1)>
		<cfif StructKeyExists(CALLER.stUSPSRateIntl.IntlRateResponse.Package, "AreasServed")>	
			<cfset temp = QuerySetCell(CALLER.USPSIntlRateQuery, "AreasServed", CALLER.stUSPSRateIntl.IntlRateResponse.Package.AreasServed.XmlText)>
		<cfelse>
			<cfset temp = QuerySetCell(CALLER.USPSIntlRateQuery, "AreasServed", "")>
		</cfif>
		<cfif StructKeyExists(CALLER.stUSPSRateIntl.IntlRateResponse.Package, "CustomsForms")>	
			<cfset temp = QuerySetCell(CALLER.USPSIntlRateQuery, "CustomsForms", CALLER.stUSPSRateIntl.IntlRateResponse.Package.CustomsForms.XmlText)>
		<cfelse>
			<cfset temp = QuerySetCell(CALLER.USPSIntlRateQuery, "CustomsForms", "")>
		</cfif>
		<cfif StructKeyExists(CALLER.stUSPSRateIntl.IntlRateResponse.Package, "ExpressMail")>	
			<cfset temp = QuerySetCell(CALLER.USPSIntlRateQuery, "ExpressMail", CALLER.stUSPSRateIntl.IntlRateResponse.Package.ExpressMail.XmlText)>
		<cfelse>
			<cfset temp = QuerySetCell(CALLER.USPSIntlRateQuery, "ExpressMail", "")>
		</cfif>
		<cfif StructKeyExists(CALLER.stUSPSRateIntl.IntlRateResponse.Package, "Observations")>	
			<cfset temp = QuerySetCell(CALLER.USPSIntlRateQuery, "Observations", CALLER.stUSPSRateIntl.IntlRateResponse.Package.Observations.XmlText)>
		<cfelse>
			<cfset temp = QuerySetCell(CALLER.USPSIntlRateQuery, "Observations", "")>
		</cfif>
		<cfif StructKeyExists(CALLER.stUSPSRateIntl.IntlRateResponse.Package, "Prohibitions")>	
			<cfset temp = QuerySetCell(CALLER.USPSIntlRateQuery, "Prohibitions", CALLER.stUSPSRateIntl.IntlRateResponse.Package.Prohibitions.XmlText)>
		<cfelse>
			<cfset temp = QuerySetCell(CALLER.USPSIntlRateQuery, "Prohibitions", "")>
		</cfif>
		<cfif StructKeyExists(CALLER.stUSPSRateIntl.IntlRateResponse.Package, "Restrictions")>	
			<cfset temp = QuerySetCell(CALLER.USPSIntlRateQuery, "Restrictions", CALLER.stUSPSRateIntl.IntlRateResponse.Package.Restrictions.XmlText)>
		<cfelse>
			<cfset temp = QuerySetCell(CALLER.USPSIntlRateQuery, "Restrictions", "")>
		</cfif>
		<!--- End Package variables query --->
	
		<!--- Available services query --->
		<!--- 
		Attributes 
		Country 
		MailType 
		MaxDimensions 
		MaxWeight 
		Ounces 
		Postage 
		Pounds 
		SvcUpdatements 
		SvcDescription
		 --->
		<cfif IsDefined("CALLER.stUSPSRateIntl.IntlRateResponse.Package.Service") AND #IsArray(CALLER.stUSPSRateIntl.IntlRateResponse.Package.Service.XmlChildren)#>
		   <cfset CALLER.USPSIntlRateServicesQuery = QueryNew("Country, MailType, MaxDimensions, MaxWeight, Ounces, Postage, Pounds, ServiceUpdatements, ServiceDescription")>
		   <cfloop index="i" from="1" to="#ArrayLen(CALLER.stUSPSRateIntl.IntlRateResponse.Package.Service)#">
		  		<cfset newRow  = QueryAddRow(CALLER.USPSIntlRateServicesQuery, 1)>
		  	<cfif StructKeyExists(CALLER.stUSPSRateIntl.IntlRateResponse.Package.Service[i], "Country")>	
				<cfset temp = QuerySetCell(CALLER.USPSIntlRateServicesQuery, "Country", CALLER.stUSPSRateIntl.IntlRateResponse.Package.Service[i].Country.XmlText, i)>
		  	<cfelse>
		  		<cfset temp = QuerySetCell(CALLER.USPSIntlRateServicesQuery, "Country", "")>
		  	</cfif>
			<cfif StructKeyExists(CALLER.stUSPSRateIntl.IntlRateResponse.Package.Service[i], "MailType")>	
				<cfset temp = QuerySetCell(CALLER.USPSIntlRateServicesQuery, "MailType", CALLER.stUSPSRateIntl.IntlRateResponse.Package.Service[i].MailType.XmlText, i)>
		  	<cfelse>
		  		<cfset temp = QuerySetCell(CALLER.USPSIntlRateServicesQuery, "MailType", "")>
		  	</cfif>
			<cfif StructKeyExists(CALLER.stUSPSRateIntl.IntlRateResponse.Package.Service[i], "MaxDimensions")>	
				<cfset temp = QuerySetCell(CALLER.USPSIntlRateServicesQuery, "MaxDimensions", CALLER.stUSPSRateIntl.IntlRateResponse.Package.Service[i].MaxDimensions.XmlText, i)>
		  	<cfelse>
		  		<cfset temp = QuerySetCell(CALLER.USPSIntlRateServicesQuery, "MaxDimensions", "")>
		  	</cfif>
			<cfif StructKeyExists(CALLER.stUSPSRateIntl.IntlRateResponse.Package.Service[i], "MaxWeight")>	
				<cfset temp = QuerySetCell(CALLER.USPSIntlRateServicesQuery, "MaxWeight", CALLER.stUSPSRateIntl.IntlRateResponse.Package.Service[i].MaxWeight.XmlText, i)>
		  	<cfelse>
		  		<cfset temp = QuerySetCell(CALLER.USPSIntlRateServicesQuery, "MaxWeight", "")>
		  	</cfif>
			<cfif StructKeyExists(CALLER.stUSPSRateIntl.IntlRateResponse.Package.Service[i], "Ounces")>	
				<cfset temp = QuerySetCell(CALLER.USPSIntlRateServicesQuery, "Ounces", CALLER.stUSPSRateIntl.IntlRateResponse.Package.Service[i].Ounces.XmlText, i)>
		  	<cfelse>
		  		<cfset temp = QuerySetCell(CALLER.USPSIntlRateServicesQuery, "Ounces", "")>
		  	</cfif>
			<cfif StructKeyExists(CALLER.stUSPSRateIntl.IntlRateResponse.Package.Service[i], "Pounds")>	
				<cfset temp = QuerySetCell(CALLER.USPSIntlRateServicesQuery, "Pounds", CALLER.stUSPSRateIntl.IntlRateResponse.Package.Service[i].Pounds.XmlText, i)>
		  	<cfelse>
		  		<cfset temp = QuerySetCell(CALLER.USPSIntlRateServicesQuery, "Pounds", "")>
		  	</cfif>
			<cfif StructKeyExists(CALLER.stUSPSRateIntl.IntlRateResponse.Package.Service[i], "Postage")>	
				<cfset temp = QuerySetCell(CALLER.USPSIntlRateServicesQuery, "Postage", CALLER.stUSPSRateIntl.IntlRateResponse.Package.Service[i].Postage.XmlText, i)>
		  	<cfelse>
		  		<cfset temp = QuerySetCell(CALLER.USPSIntlRateServicesQuery, "Postage", "")>
		  	</cfif>
			<cfif StructKeyExists(CALLER.stUSPSRateIntl.IntlRateResponse.Package.Service[i], "SvcUpdatements")>	
				<cfset temp = QuerySetCell(CALLER.USPSIntlRateServicesQuery, "ServiceUpdatements", CALLER.stUSPSRateIntl.IntlRateResponse.Package.Service[i].SvcUpdatements.XmlText, i)>
		  	<cfelse>
		  		<cfset temp = QuerySetCell(CALLER.USPSIntlRateServicesQuery, "ServiceUpdatements", "")>
		  	</cfif>
			<cfif StructKeyExists(CALLER.stUSPSRateIntl.IntlRateResponse.Package.Service[i], "SvcDescription")>	
				<cfset temp = QuerySetCell(CALLER.USPSIntlRateServicesQuery, "ServiceDescription", CALLER.stUSPSRateIntl.IntlRateResponse.Package.Service[i].SvcDescription.XmlText, i)>
		  	<cfelse>
		  		<cfset temp = QuerySetCell(CALLER.USPSIntlRateServicesQuery, "ServiceDescription", "")>
		  	</cfif>
		   </cfloop>
		</cfif>
		<!--- End available services query --->
		
	<cfelseif IsDefined("CALLER.stUSPSRateIntl.IntlRateResponse.Package.Error.Description.XmlText")>
		<cfset CALLER.USPSError = 1>
		<cfset CALLER.USPSIntlRateErrorDesc = CALLER.stUSPSRateIntl.IntlRateResponse.PACKAGE.Error.Description.XmlText>
	<cfelse>
		<cfset CALLER.USPSError = 2>
		<cfif IsDefined("CALLER.stUSPSRateIntl.IntlRateResponse.Package.Error.Description.XmlText")>
			<cfset CALLER.USPSIntlRateErrorDesc = CALLER.stUSPSRateIntl.IntlRateResponse.PACKAGE.Error.Description.XmlText>
		</cfif>
	</cfif>
		
 </cfcase>
 <!--- End USPS International Rate request --->

 <!--- Start USPS Track Confirm request --->
 <cfcase value="TrackRequest">
	
	<cfscript>
	ATTRIBUTES.XMLRequestInput = '<?xml version="#ATTRIBUTES.XMLVersion#"?>
	<TrackRequest USERID="#ATTRIBUTES.USPSUserID#" PASSWORD="#ATTRIBUTES.USPSPassword#">
		<TrackID ID="#ATTRIBUTES.TrackingNumber#"/>
	</TrackRequest>';
	</cfscript>
	
	<cfhttp method="post" url="#ATTRIBUTES.USPSServer#" resolveurl="yes" port="80" timeout="#ATTRIBUTES.TimeOut#">
		<cfhttpparam name="XML" type="xml" value="API=TrackV2&XML=#ATTRIBUTES.XMLRequestInput#">
	</cfhttp>
	
	<cfset CALLER.stUSPSTrack = XmlParse(cfhttp.FileContent)>
	
	<!--- <cfoutput>
		<cfdump var="#CALLER.stUSPSTrack#">
	</cfoutput> --->
	
	<cfif IsDefined("CALLER.stUSPSTrack.TrackResponse.TrackInfo.TrackSummary.XmlText")> <!--- Successful register response --->
	  	<cfset CALLER.USPSError = 0> <!--- No Error --->
		<cfset CALLER.USPSTrackErrorDesc = "Success">

	    <cfset CALLER.TrackSummary = CALLER.stUSPSTrack.TrackResponse.TrackInfo.TrackSummary.XmlText>	
		<cfset CALLER.USPSTrackQuery = QueryNew("ActivityScan")>
		<!--- Pounds, Ounces, Service, Size, ZipDestination, ZipOrigination, Zone --->
		<cfif IsDefined("CALLER.stUSPSTrack.TrackResponse.TrackInfo.TrackDetail") AND #IsArray(CALLER.stUSPSTrack.TrackResponse.TrackInfo.TrackDetail.XmlChildren)#>
		 
		 <cfloop index="idxTrack" from="1" to="#ArrayLen(CALLER.stUSPSTrack.TrackResponse.TrackInfo.TrackDetail)#">
			<cfset newRow  = QueryAddRow(CALLER.USPSTrackQuery, 1)>
			<cfset temp = QuerySetCell(CALLER.USPSTrackQuery, "ActivityScan", CALLER.stUSPSTrack.TrackResponse.TrackInfo.TrackDetail[idxTrack].XmlText)>
		 </cfloop>
		 
		<cfelse>
		    <cfset newRow  = QueryAddRow(CALLER.USPSTrackQuery, 1)>	
			<cfif IsDefined("CALLER.stUSPSTrack.TrackResponse.TrackInfo.TrackDetail.XmlText")>	
				<cfset temp = QuerySetCell(CALLER.USPSTrackQuery, "ActivityScan", CALLER.stUSPSTrack.TrackResponse.TrackInfo.TrackDetail.XmlText)>
			<cfelse>
				<cfset temp = QuerySetCell(CALLER.USPSTrackQuery, "ActivityScan", "")>
			</cfif>
		</cfif>
		
	<cfelseif IsDefined("CALLER.stUSPSTrack.TrackResponse.TrackInfo.Error.Description.XmlText")>
		<cfset CALLER.USPSError = 1>
		<cfset CALLER.USPSTrackErrorDesc = CALLER.stUSPSTrack.TrackResponse.TrackInfo.Error.Description.XmlText>
	
	<cfelseif IsDefined("CALLER.stUSPSTrack.Error.Description.XmlText")>
		<cfset CALLER.USPSError = 1>
		<cfset CALLER.USPSTrackErrorDesc = CALLER.stUSPSTrack.Error.Description.XmlText>
	
	<cfelse>
		<cfset CALLER.USPSError = 2>
		<cfset CALLER.USPSTrackErrorDesc = "Undefined error received">
	</cfif>
		
 </cfcase>
 <!--- End USPS Track Confirm request --->

<!--- Start USPS Track Confirm Detail request --->
 <cfcase value="TrackRequestDetail">
	
	<cfscript>
	ATTRIBUTES.XMLRequestInput = '<?xml version="#ATTRIBUTES.XMLVersion#"?>
	<TrackFieldRequest USERID="#ATTRIBUTES.USPSUserID#" PASSWORD="#ATTRIBUTES.USPSPassword#">
		<TrackID ID="#ATTRIBUTES.TrackingNumber#"/>
	</TrackFieldRequest>';
	</cfscript>
	
	<cfhttp method="post" url="#ATTRIBUTES.USPSServer#" resolveurl="yes" port="80" timeout="#ATTRIBUTES.TimeOut#">
		<cfhttpparam name="XML" type="xml" value="API=TrackV2&XML=#ATTRIBUTES.XMLRequestInput#">
	</cfhttp>
	
	<cfset CALLER.stUSPSTrackDetail = XmlParse(cfhttp.FileContent)>
	
	
	<!--- <cfoutput>
		<cfdump var="#CALLER.stUSPSTrackDetail#">
	</cfoutput> --->
	
	<!--- 
	EventTime
	EventDate
	Event
	EventCity
	EventState
	EventZIPCode
	EventCountry
	FirmName
	Name --->

	<cfif IsDefined("CALLER.stUSPSTrackDetail.TrackResponse.TrackInfo.TrackSummary")> <!--- Successful register response --->
	  	<cfset CALLER.USPSError = 0> <!--- No Error --->
		<cfset CALLER.USPSTrackDetailErrorDesc = "Success">

		<cfset CALLER.USPSTrackSummaryQuery = QueryNew("SummaryDate, SummaryTime, SummaryEvent, SummaryCity, SummaryState, SummaryZip, SummaryCountry, SignedForByName, DeliveredToCompany")>
			<cfset stSummary = CALLER.stUSPSTrackDetail.TrackResponse.TrackInfo.TrackSummary>
			<cfset newRow  = QueryAddRow(CALLER.USPSTrackSummaryQuery, 1)>
			<cfif StructKeyExists(stSummary, "EventDate")>
				<cfset temp = QuerySetCell(CALLER.USPSTrackSummaryQuery, "SummaryDate", stSummary.EventDate.XmlText)>
			<cfelse>
				<cfset temp = QuerySetCell(CALLER.USPSTrackSummaryQuery, "SummaryDate", "")>
			</cfif>
			<cfif StructKeyExists(stSummary, "EventTime")>
				<cfset temp = QuerySetCell(CALLER.USPSTrackSummaryQuery, "SummaryTime", stSummary.EventTime.XmlText)>
			<cfelse>
				<cfset temp = QuerySetCell(CALLER.USPSTrackSummaryQuery, "SummaryTime", "")>
			</cfif>
			<cfif StructKeyExists(stSummary, "Event")>
				<cfset temp = QuerySetCell(CALLER.USPSTrackSummaryQuery, "SummaryEvent", stSummary.Event.XmlText)>
			<cfelse>
				<cfset temp = QuerySetCell(CALLER.USPSTrackSummaryQuery, "SummaryEvent", "")>
			</cfif>
			<cfif StructKeyExists(stSummary, "EventCity")>
				<cfset temp = QuerySetCell(CALLER.USPSTrackSummaryQuery, "SummaryCity", stSummary.EventCity.XmlText)>
			<cfelse>
				<cfset temp = QuerySetCell(CALLER.USPSTrackSummaryQuery, "SummaryCity", "")>
			</cfif>
			<cfif StructKeyExists(stSummary, "EventState")>
				<cfset temp = QuerySetCell(CALLER.USPSTrackSummaryQuery, "SummaryState", stSummary.EventState.XmlText)>
			<cfelse>
				<cfset temp = QuerySetCell(CALLER.USPSTrackSummaryQuery, "SummaryState", "")>
			</cfif>
			<cfif StructKeyExists(stSummary, "EventZIPCode")>
				<cfset temp = QuerySetCell(CALLER.USPSTrackSummaryQuery, "SummaryZip", stSummary.EventZIPCode.XmlText)>
			<cfelse>
				<cfset temp = QuerySetCell(CALLER.USPSTrackSummaryQuery, "SummaryZip", "")>
			</cfif>
			<cfif StructKeyExists(stSummary, "EventCountry")>
				<cfset temp = QuerySetCell(CALLER.USPSTrackSummaryQuery, "SummaryCountry", stSummary.EventCountry.XmlText)>
			<cfelse>
				<cfset temp = QuerySetCell(CALLER.USPSTrackSummaryQuery, "SummaryCountry", "")>
			</cfif>
			<cfif StructKeyExists(stSummary, "Name")>
				<cfset temp = QuerySetCell(CALLER.USPSTrackSummaryQuery, "SignedForByName", stSummary.Name.XmlText)>
			<cfelse>
				<cfset temp = QuerySetCell(CALLER.USPSTrackSummaryQuery, "SignedForByName", "")>
			</cfif>
			<cfif StructKeyExists(stSummary, "FirmName")>
				<cfset temp = QuerySetCell(CALLER.USPSTrackSummaryQuery, "DeliveredToCompany", stSummary.FirmName.XmlText)>
			<cfelse>
				<cfset temp = QuerySetCell(CALLER.USPSTrackSummaryQuery, "DeliveredToCompany", "")>
			</cfif>
		
		<cfset CALLER.USPSTrackDetailQuery = QueryNew("ScanDate, ScanTime, ScanEvent, ScanCity, ScanState, ScanZip, ScanCountry, SignedForByName, DeliveredToCompany")>
		<!--- Pounds, Ounces, Service, Size, ZipDestination, ZipOrigination, Zone --->
		<cfif IsDefined("CALLER.stUSPSTrackDetail.TrackResponse.TrackInfo.TrackDetail") AND #IsArray(CALLER.stUSPSTrackDetail.TrackResponse.TrackInfo.TrackDetail.XmlChildren)#>
		 
		 <cfloop index="idxDetail" from="1" to="#ArrayLen(CALLER.stUSPSTrackDetail.TrackResponse.TrackInfo.TrackDetail)#">
			<cfset newRow  = QueryAddRow(CALLER.USPSTrackDetailQuery, 1)>
			<cfset aDetail = CALLER.stUSPSTrackDetail.TrackResponse.TrackInfo.TrackDetail>
			<cfif StructKeyExists(aDetail[idxDetail], "EventDate")>
				<cfset temp = QuerySetCell(CALLER.USPSTrackDetailQuery, "ScanDate", aDetail[idxDetail].EventDate.XmlText)>
		 	<cfelse>
				<cfset temp = QuerySetCell(CALLER.USPSTrackDetailQuery, "ScanDate", "")>
			</cfif>
			<cfif StructKeyExists(aDetail[idxDetail], "EventTime")>
				<cfset temp = QuerySetCell(CALLER.USPSTrackDetailQuery, "ScanTime", aDetail[idxDetail].EventTime.XmlText)>
		 	<cfelse>
				<cfset temp = QuerySetCell(CALLER.USPSTrackDetailQuery, "ScanTime", "")>
			</cfif>
			<cfif StructKeyExists(aDetail[idxDetail], "Event")>
				<cfset temp = QuerySetCell(CALLER.USPSTrackDetailQuery, "ScanEvent", aDetail[idxDetail].Event.XmlText)>
		 	<cfelse>
				<cfset temp = QuerySetCell(CALLER.USPSTrackDetailQuery, "ScanEvent", "")>
			</cfif>
			<cfif StructKeyExists(aDetail[idxDetail], "EventCity")>
				<cfset temp = QuerySetCell(CALLER.USPSTrackDetailQuery, "ScanCity", aDetail[idxDetail].EventCity.XmlText)>
		 	<cfelse>
				<cfset temp = QuerySetCell(CALLER.USPSTrackDetailQuery, "ScanCity", "")>
			</cfif>
			<cfif StructKeyExists(aDetail[idxDetail], "EventState")>
				<cfset temp = QuerySetCell(CALLER.USPSTrackDetailQuery, "ScanState", aDetail[idxDetail].EventState.XmlText)>
		 	<cfelse>
				<cfset temp = QuerySetCell(CALLER.USPSTrackDetailQuery, "ScanState", "")>
			</cfif>
			<cfif StructKeyExists(aDetail[idxDetail], "EventZIPCode")>
				<cfset temp = QuerySetCell(CALLER.USPSTrackDetailQuery, "ScanZip", aDetail[idxDetail].EventZIPCode.XmlText)>
		 	<cfelse>
				<cfset temp = QuerySetCell(CALLER.USPSTrackDetailQuery, "ScanZip", "")>
			</cfif>
			<cfif StructKeyExists(aDetail[idxDetail], "EventCountry")>
				<cfset temp = QuerySetCell(CALLER.USPSTrackDetailQuery, "ScanCountry", aDetail[idxDetail].EventCountry.XmlText)>
		 	<cfelse>
				<cfset temp = QuerySetCell(CALLER.USPSTrackDetailQuery, "ScanCountry", "")>
			</cfif>
			<cfif StructKeyExists(aDetail[idxDetail], "Name")>
				<cfset temp = QuerySetCell(CALLER.USPSTrackDetailQuery, "SignedForByName", aDetail[idxDetail].Name.XmlText)>
		 	<cfelse>
				<cfset temp = QuerySetCell(CALLER.USPSTrackDetailQuery, "SignedForByName", "")>
			</cfif>
			<cfif StructKeyExists(aDetail[idxDetail], "FirmName")>
				<cfset temp = QuerySetCell(CALLER.USPSTrackDetailQuery, "DeliveredToCompany", aDetail[idxDetail].FirmName.XmlText)>
		 	<cfelse>
				<cfset temp = QuerySetCell(CALLER.USPSTrackDetailQuery, "DeliveredToCompany", "")>
			</cfif>
		 </cfloop>
		 
		<cfelse>
		    <cfset newRow  = QueryAddRow(CALLER.USPSTrackDetailQuery, 1)>	
			<cfif IsDefined("CALLER.stUSPSTrackDetail.TrackResponse.TrackInfo.TrackDetail.EventDate.XmlText")>	
				<cfset temp = QuerySetCell(CALLER.USPSTrackDetailQuery, "ScanDate", CALLER.stUSPSTrackDetail.TrackResponse.TrackInfo.TrackDetail.EventDate.XmlText)>
			<cfelse>
				<cfset temp = QuerySetCell(CALLER.USPSTrackDetailQuery, "ScanDate", "")>
			</cfif>
		</cfif>
		
	<cfelseif IsDefined("CALLER.stUSPSTrackDetail.TrackResponse.TrackInfo.Error.Description.XmlText")>
		<cfset CALLER.USPSError = 1>
		<cfset CALLER.USPSTrackDetailErrorDesc = CALLER.stUSPSTrackDetail.TrackResponse.TrackInfo.Error.Description.XmlText>
	
	<cfelseif IsDefined("CALLER.stUSPSTrackDetail.Error.Description.XmlText")>
		<cfset CALLER.USPSError = 1>
		<cfset CALLER.USPSTrackDetailErrorDesc = CALLER.stUSPSTrackDetail.Error.Description.XmlText>
	
	<cfelse>
		<cfset CALLER.USPSError = 2>
		<cfset CALLER.USPSTrackDetailErrorDesc = "Undefined error received">
	</cfif>
		
 </cfcase>
 <!--- End USPS Track Confirm Detail request --->
 
 <!--- Start USPS Signature Confirmation request --->
 <cfcase value="SignatureConfirmRequest">

    <!--- 
	For “Canned” test requests the code should read:
	File = “/ShippingAPItest.dll?”
	xml = "API=SignatureConfirmation&XML=" & XMLSTRING
	
	For “Sample” test requests the code should read:
	File = “/ShippingAPI.dll?”
	xml = "API=SignatureConfirmationCertify&XML=" & XMLSTRING
	
	For “Live” requests the code should read:
	File = “/ShippingAPI.dll?”
	xml = "API=SignatureConfirmation&XML=" & XMLSTRING --->
	
	<cfscript>
	if (ATTRIBUTES.TestingEnvironment eq "True") {
		APIIndicator = 'API=SignatureConfirmationCertify&XML=';
		TopLevelElementIndicator = 'SigConfirmCertifyRequest';
		ATTRIBUTES.USPSServer = 'http://Production.ShippingAPIs.com/ShippingAPI.dll';
	}
	else {
		APIIndicator = 'API=SignatureConfirmation&XML=';
		TopLevelElementIndicator = 'SignatureConfirmationRequest';
		ATTRIBUTES.USPSServer = 'http://Production.ShippingAPIs.com/ShippingAPI.dll';
	}
	if (ATTRIBUTES.CannedRequest eq "True") {
		APIIndicator = 'API=SignatureConfirmation&XML=';
		TopLevelElementIndicator = 'SignatureConfirmationRequest';
		ATTRIBUTES.USPSServer = 'http://testing.ShippingAPIs.com/ShippingAPITest.dll';
	}
			
	ATTRIBUTES.XMLRequestInput = '<?xml version="#ATTRIBUTES.XMLVersion#"?>
	<#TopLevelElementIndicator# USERID="#ATTRIBUTES.USPSUserID#" PASSWORD="#ATTRIBUTES.USPSPassword#">
		<Option>3</Option>
		<ImageParameters></ImageParameters>
		<FromName>#ATTRIBUTES.ShipFromName#</FromName>
		<FromFirm>#ATTRIBUTES.ShipFromCompany#</FromFirm>
		<FromAddress1>#ATTRIBUTES.ShipFromAddress2#</FromAddress1>
		<FromAddress2>#ATTRIBUTES.ShipFromAddress1#</FromAddress2>
		<FromCity>#ATTRIBUTES.ShipFromCity#</FromCity>
		<FromState>#ATTRIBUTES.ShipFromState#</FromState>
		<FromZip5>#ATTRIBUTES.ShipFromZip5#</FromZip5>
		<FromZip4>#ATTRIBUTES.ShipFromZip4Extended#</FromZip4>
		<ToName>#ATTRIBUTES.ShipToName#</ToName>
		<ToFirm>#ATTRIBUTES.ShipToCompany#</ToFirm>
		<ToAddress1>#ATTRIBUTES.ShipToAddress2#</ToAddress1>
		<ToAddress2>#ATTRIBUTES.ShipToAddress1#</ToAddress2>
		<ToCity>#ATTRIBUTES.ShipToCity#</ToCity>
		<ToState>#ATTRIBUTES.ShipToState#</ToState>
		<ToZip5>#ATTRIBUTES.ShipToZip5#</ToZip5>
		<ToZip4>#ATTRIBUTES.ShipToZip4Extended#</ToZip4>
		<WeightInOunces>#ATTRIBUTES.PackageWeightOZ#</WeightInOunces>
		<ServiceType>#ATTRIBUTES.ServiceLevel#</ServiceType>
		<ImageType>#ATTRIBUTES.ShippingLabelImage#</ImageType>
	</#TopLevelElementIndicator#>';
	</cfscript>
	
	<cfset strXMLRequest = #Evaluate(DE(APIIndicator))#>
	
	<cfhttp method="post" url="#ATTRIBUTES.USPSServer#" resolveurl="yes" port="80" timeout="#ATTRIBUTES.TimeOut#">
		<cfhttpparam name="XML" type="xml" value="#strXMLRequest##ATTRIBUTES.XMLRequestInput#">
	</cfhttp>
	
	<cfif ATTRIBUTES.Debug eq "TRUE">
		<cfif IsDefined("cfhttp.FileContent")>
		  <cfif IsXmlDoc(Trim(cfhttp.FileContent))>
			<cfset CALLER.stUSPSSignatureConfirm = XmlParse(Trim(cfhttp.FileContent))>
			<cfoutput>
				<cfdump var="#CALLER.stUSPSSignatureConfirm#">
			</cfoutput>
		  <cfelse>
		  	Response Screen Dump:<br>
			<cfoutput>#cfhttp.FileContent#</cfoutput>
		  </cfif>
		</cfif>
			<cffile action="WRITE" file="#ATTRIBUTES.ServerFilePath##trailingSlash#Debug#trailingSlash#SignatureConfirmRequest.xml" output="#ATTRIBUTES.XMLRequestInput#" addnewline="No" nameconflict="overwrite">
		<cfabort>
	
	<cfelse>
	
		<cfif IsDefined("cfhttp.FileContent")>
			
			<cfset CALLER.stUSPSSignatureConfirm = XmlParse(Trim(cfhttp.FileContent))>
			
			<!--- <cfoutput>
				<cfdump var="#CALLER.stUSPSSignatureConfirm#">
			</cfoutput> --->
			
			<cfif ATTRIBUTES.TestingEnvironment eq "True">
			  <cfif IsDefined("CALLER.stUSPSSignatureConfirm.SigConfirmCertifyResponse.SignatureConfirmationLabel.XmlText")>	
				<cfset CALLER.USPSError = 0>
				<cfset CALLER.SCConfirmationNumber = CALLER.stUSPSSignatureConfirm.SigConfirmCertifyResponse.SignatureConfirmationNumber.XmlText>
				<cfset CALLER.LabelName = CALLER.stUSPSSignatureConfirm.SigConfirmCertifyResponse.SignatureConfirmationNumber.XmlText & "." & ATTRIBUTES.ShippingLabelImage>
				<cfset binary = toBinary("#CALLER.stUSPSSignatureConfirm.SigConfirmCertifyResponse.SignatureConfirmationLabel.XmlText#")>
				<cffile action="WRITE" file="#ATTRIBUTES.ServerFilePath##trailingSlash#CertificationFiles#trailingSlash##CALLER.LabelName#" output="#binary#" addnewline="No" nameconflict="overwrite">
			  <cfelseif IsDefined("CALLER.stUSPSSignatureConfirm.Error.Description.XmlText")>
				<cfset CALLER.USPSError = 1>
				<cfset CALLER.USPSSigConfirmErrorDesc = CALLER.stUSPSSignatureConfirm.Error.Description.XmlText>
			  <cfelse>
				<cfset CALLER.USPSError = 2>
				<cfset CALLER.USPSSigConfirmErrorDesc = "Error: Unexpected response received from USPS Server">	  	
			  </cfif>
			
			<cfelse>
			  <cfif IsDefined("CALLER.stUSPSSignatureConfirm.SignatureConfirmationResponse.SignatureConfirmationLabel.XmlText")>	
				<cfset CALLER.USPSError = 0>
				<cfset CALLER.SCConfirmationNumber = CALLER.stUSPSSignatureConfirm.SignatureConfirmationResponse.SignatureConfirmationNumber.XmlText>
				<cfset CALLER.LabelName = CALLER.stUSPSSignatureConfirm.SignatureConfirmationResponse.SignatureConfirmationNumber.XmlText & "." & ATTRIBUTES.ShippingLabelImage>
				<cfset binary = toBinary("#CALLER.stUSPSSignatureConfirm.SignatureConfirmationResponse.SignatureConfirmationLabel.XmlText#")>
				<cffile action="WRITE" file="#ATTRIBUTES.ServerFilePath##trailingSlash#SigConfirmLabels#trailingSlash##CALLER.LabelName#" output="#binary#" addnewline="No" nameconflict="overwrite">
			  <cfelseif IsDefined("CALLER.stUSPSSignatureConfirm.Error.Description.XmlText")>
				<cfset CALLER.USPSError = 1>
				<cfset CALLER.USPSSigConfirmErrorDesc = CALLER.stUSPSSignatureConfirm.Error.Description.XmlText>
			  <cfelse>
				<cfset CALLER.USPSError = 2>
				<cfset CALLER.USPSSigConfirmErrorDesc = "Error: Unexpected response received from USPS Server">	  	
			  </cfif>
			</cfif>
			
		<cfelse>
			<!--- no response received --->
			<cfset CALLER.USPSError = 2>
			<cfset CALLER.USPSSigConfirmErrorDesc = "Error: Unexpected response received from USPS Server">
			
		</cfif>
			
	</cfif>
	
 </cfcase>
 <!--- End USPS Signature Confirmation request --->

 <!--- Start USPS Address Validation --->
 <cfcase value="AddressValidation">
	
	<cfscript>
	ATTRIBUTES.XMLRequestInput = '<?xml version="#ATTRIBUTES.XMLVersion#"?>
	<AddressValidateRequest USERID="#ATTRIBUTES.USPSUserID#" PASSWORD="#ATTRIBUTES.USPSPassword#">
	<Address ID="#ATTRIBUTES.ShipToAddressID#">
		<Address1>#ATTRIBUTES.ShipToAddress2#</Address1>
		<Address2>#ATTRIBUTES.ShipToAddress1#</Address2>
		<City>#ATTRIBUTES.ShipToCity#</City>
		<State>#ATTRIBUTES.ShipToState#</State>
		<Zip5>#ATTRIBUTES.ShipToZip5#</Zip5>
		<Zip4>#ATTRIBUTES.ShipToZip4Extended#</Zip4>
	</Address>
	</AddressValidateRequest>';
	</cfscript>
	
	<cfhttp method="post" url="#ATTRIBUTES.USPSServer#" resolveurl="yes" port="80" timeout="#ATTRIBUTES.TimeOut#">
		<cfhttpparam name="XML" type="xml" value="API=Verify&XML=#ATTRIBUTES.XMLRequestInput#">
	</cfhttp>
	
	<cfset CALLER.stUSPSAddrValidationResponse = XmlParse(cfhttp.FileContent)>
	
	<cfif ATTRIBUTES.Debug eq "TRUE">
		<cffile action="WRITE" file="#ATTRIBUTES.ServerFilePath##trailingSlash#Debug#trailingSlash#AddressValidateRequest.xml" output="#ATTRIBUTES.XMLRequestInput#" addnewline="No" nameconflict="overwrite">
		  <cfoutput>
			<cfdump var="#CALLER.stUSPSAddrValidationResponse#">
			<cfabort>
		  </cfoutput>
		<cfabort>
	</cfif>
	
	<cfif IsDefined("CALLER.stUSPSAddrValidationResponse.Error.Description.Value")> <!--- Check hard error - usually no authorization --->
		<cfset CALLER.USPSError = 2>
		<cfset CALLER.USPSAddrValidateErrorDesc = CALLER.stUSPSAddrValidationResponse.Error.Description.Value>
	<cfelse>
	
		<cfif StructKeyExists(CALLER.stUSPSAddrValidationResponse.AddressValidateResponse, "Address")>
		
			<cfif StructKeyExists(CALLER.stUSPSAddrValidationResponse.AddressValidateResponse.Address, "Address2")>
			  <cfset CALLER.USPSError = 0>
			  <cfset CALLER.USPSAddrValidateErrorDesc = "Success">
			  
			  <cfif StructKeyExists(CALLER.stUSPSAddrValidationResponse.AddressValidateResponse.Address, "Address2")>
				<cfset CALLER.ValidatedStreet1 = "#CALLER.stUSPSAddrValidationResponse.AddressValidateResponse.Address.Address2.XmlText#">
			  <cfelse>
				<cfset CALLER.ValidatedStreet1 = "">
			  </cfif>
			  <cfif StructKeyExists(CALLER.stUSPSAddrValidationResponse.AddressValidateResponse.Address, "Address1")>
				<cfset CALLER.ValidatedStreet2 = "#CALLER.stUSPSAddrValidationResponse.AddressValidateResponse.Address.Address1.XmlText#">
			  <cfelse>
				<cfset CALLER.ValidatedStreet2 = "">
			  </cfif>
			  <cfif StructKeyExists(CALLER.stUSPSAddrValidationResponse.AddressValidateResponse.Address, "City")>
				<cfset CALLER.ValidatedCity = "#CALLER.stUSPSAddrValidationResponse.AddressValidateResponse.Address.City.XmlText#">
			  <cfelse>
				<cfset CALLER.ValidatedCity = "">
			  </cfif>
			  <cfif StructKeyExists(CALLER.stUSPSAddrValidationResponse.AddressValidateResponse.Address, "State")>
				<cfset CALLER.ValidatedState = "#CALLER.stUSPSAddrValidationResponse.AddressValidateResponse.Address.State.XmlText#">
			  <cfelse>
				<cfset CALLER.ValidatedState = "">
			  </cfif>
			  <cfif StructKeyExists(CALLER.stUSPSAddrValidationResponse.AddressValidateResponse.Address, "Zip5")>
				<cfset CALLER.ValidatedZipcode5 = "#CALLER.stUSPSAddrValidationResponse.AddressValidateResponse.Address.Zip5.XmlText#">
			  <cfelse>
				<cfset CALLER.ValidatedZipcode5 = "">
			  </cfif>
			  <cfif StructKeyExists(CALLER.stUSPSAddrValidationResponse.AddressValidateResponse.Address, "Zip4")>
				<cfset CALLER.ValidatedZipcodePlus4 = "#CALLER.stUSPSAddrValidationResponse.AddressValidateResponse.Address.Zip4.XmlText#">
			  <cfelse>
				<cfset CALLER.ValidatedZipcodePlus4 = "">
			  </cfif>
			  
			<cfelseif IsDefined("CALLER.stUSPSAddrValidationResponse.AddressValidateResponse.Address.Error.Description.XmlText")>
				<cfset CALLER.USPSError = 1>
				<cfset CALLER.USPSAddrValidateErrorDesc = CALLER.stUSPSAddrValidationResponse.AddressValidateResponse.Address.Error.Description.XmlText>
			<cfelse>
				<cfset CALLER.USPSError = 2>
				<cfset CALLER.USPSAddrValidateErrorDesc = "">
			</cfif>
			
		<cfelse>
			<!--- Error Address element should always be returned  , unexpected response --->
			<cfset CALLER.USPSError = 2>
			<cfset CALLER.USPSAddrValidateErrorDesc = "Hard Error: Response from USPS Servers is unexpected and not handled, no validation has been received">
		</cfif>
		
	</cfif>	
  
 </cfcase>
 <!--- End USPS Address Validation --->
 
  <!--- Start USPS Address City/State Lookup --->
 <cfcase value="AddressCityStateLookup">

	<cfscript>
	if ( #ListLen(ATTRIBUTES.ShipToZip5)# gt 1 ) {
	  	
		ZipIndicator = '';
		 
		 for ( idx = 1 ; idx lte ListLen(ATTRIBUTES.ShipToZip5); idx = idx + 1 ) {
             ZipIndicator = '#ZipIndicator#
	<ZipCode ID="#idx#">
		<Zip5>#ListGetAt(ATTRIBUTES.ShipToZip5, idx)#</Zip5>
	</ZipCode>';
          }
	  
	}
	else {
		ZipIndicator = '<ZipCode ID="#ATTRIBUTES.ZipID#">
		<Zip5>#ATTRIBUTES.ShipToZip5#</Zip5>
	</ZipCode>';
	}
	
	ATTRIBUTES.XMLRequestInput = '<?xml version="#ATTRIBUTES.XMLVersion#"?>
	<CityStateLookupRequest USERID="#ATTRIBUTES.USPSUserID#" PASSWORD="#ATTRIBUTES.USPSPassword#">
	#ZipIndicator#
	</CityStateLookupRequest>';
	</cfscript>
	
	<cfhttp method="post" url="#ATTRIBUTES.USPSServer#" resolveurl="yes" port="80" timeout="#ATTRIBUTES.TimeOut#">
		<cfhttpparam name="XML" type="xml" value="API=CityStateLookup&XML=#ATTRIBUTES.XMLRequestInput#">
	</cfhttp>
	
	<cfset CALLER.stUSPSAddrCityStateLookup = XmlParse(cfhttp.FileContent)>
    
	<!--- <cfoutput><cfdump var="#CALLER.stUSPSAddrCityStateLookup#"></cfoutput> --->
	
	<cfif ATTRIBUTES.Debug eq "TRUE">
		<cffile action="WRITE" file="#ATTRIBUTES.ServerFilePath##trailingSlash#Debug#trailingSlash#CityStateRequest.xml" output="#ATTRIBUTES.XMLRequestInput#" addnewline="No" nameconflict="overwrite">
		<cfoutput>
			<cfdump var="#CALLER.stUSPSAddrCityStateLookup#">
		</cfoutput>
		<cfabort>
	</cfif>

	<cfif StructKeyExists(CALLER.stUSPSAddrCityStateLookup.CityStateLookupResponse, "ZipCode")>
	
		<cfif IsDefined("CALLER.stUSPSAddrCityStateLookup.CityStateLookupResponse.ZipCode") AND IsArray(CALLER.stUSPSAddrCityStateLookup.CityStateLookupResponse.ZipCode.XmlChildren)>
			<cfset CALLER.USPSError = 0>
			<cfset CALLER.USPSCityStateErrorDesc = "Successful Request">
		  
			<cfset CALLER.USPSCityStateQuery = QueryNew("ValidatedCity, ValidatedState, ValidatedZip5, Error")>
			<cfloop index="i" from="1" to="#ArrayLen(CALLER.stUSPSAddrCityStateLookup.CityStateLookupResponse.ZipCode)#">
				<cfset newRow  = QueryAddRow(CALLER.USPSCityStateQuery, 1)>
			  <cfif StructKeyExists(CALLER.stUSPSAddrCityStateLookup.CityStateLookupResponse.ZipCode[i], "City")>	
				<cfset temp = QuerySetCell(CALLER.USPSCityStateQuery, "ValidatedCity", CALLER.stUSPSAddrCityStateLookup.CityStateLookupResponse.ZipCode[i].City.XmlText, i)>
			  <cfelse>
				<cfset temp = QuerySetCell(CALLER.USPSCityStateQuery, "ValidatedCity", "")>
			  </cfif>
			  <cfif StructKeyExists(CALLER.stUSPSAddrCityStateLookup.CityStateLookupResponse.ZipCode[i], "State")>	
				<cfset temp = QuerySetCell(CALLER.USPSCityStateQuery, "ValidatedState", CALLER.stUSPSAddrCityStateLookup.CityStateLookupResponse.ZipCode[i].State.XmlText, i)>
			  <cfelse>
				<cfset temp = QuerySetCell(CALLER.USPSCityStateQuery, "ValidatedState", "")>
			  </cfif>
			  <cfif StructKeyExists(CALLER.stUSPSAddrCityStateLookup.CityStateLookupResponse.ZipCode[i], "Zip5")>	
				<cfset temp = QuerySetCell(CALLER.USPSCityStateQuery, "ValidatedZip5", CALLER.stUSPSAddrCityStateLookup.CityStateLookupResponse.ZipCode[i].Zip5.XmlText, i)>
			  <cfelse>
				<cfset temp = QuerySetCell(CALLER.USPSCityStateQuery, "ValidatedZip5", "")>
			  </cfif>
			  
			  <cfif StructKeyExists(CALLER.stUSPSAddrCityStateLookup.CityStateLookupResponse.ZipCode[i], "Error")>	
				<cfset temp = QuerySetCell(CALLER.USPSCityStateQuery, "Error", CALLER.stUSPSAddrCityStateLookup.CityStateLookupResponse.ZipCode[i].Error.Description.XmlText, i)>
			  <cfelse>
				<cfset temp = QuerySetCell(CALLER.USPSCityStateQuery, "Error", "")>
			  </cfif>
			  
			</cfloop>
				
		<cfelseif StructKeyExists(CALLER.stUSPSAddrCityStateLookup.CityStateLookupResponse.ZipCode, "City")>
		  <cfset CALLER.USPSError = 0>
		  <cfset CALLER.USPSCityStateErrorDesc = "Successful Request">
		  
			<cfset CALLER.USPSCityStateQuery = QueryNew("ValidatedCity, ValidatedState, ValidatedZip5, Error")>
			<cfset newRow  = QueryAddRow(CALLER.USPSCityStateQuery, 1)>
		  <cfif StructKeyExists(CALLER.stUSPSAddrCityStateLookup.CityStateLookupResponse.ZipCode, "City")>
			<cfset temp = QuerySetCell(CALLER.USPSCityStateQuery, "ValidatedCity", CALLER.stUSPSAddrCityStateLookup.CityStateLookupResponse.ZipCode.City.XmlText)>
		  <cfelse>
			<cfset temp = QuerySetCell(CALLER.USPSCityStateQuery, "ValidatedCity", "")>
		  </cfif>
		  <cfif StructKeyExists(CALLER.stUSPSAddrCityStateLookup.CityStateLookupResponse.ZipCode, "State")>	
			<cfset temp = QuerySetCell(CALLER.USPSCityStateQuery, "ValidatedState", CALLER.stUSPSAddrCityStateLookup.CityStateLookupResponse.ZipCode.State.XmlText)>
		  <cfelse>
			 <cfset temp = QuerySetCell(CALLER.USPSCityStateQuery, "ValidatedState", "")>
		  </cfif>
		  <cfif StructKeyExists(CALLER.stUSPSAddrCityStateLookup.CityStateLookupResponse.ZipCode, "Zip5")>	
			 <cfset temp = QuerySetCell(CALLER.USPSCityStateQuery, "ValidatedZip5", CALLER.stUSPSAddrCityStateLookup.CityStateLookupResponse.ZipCode.Zip5.XmlText)>
		  <cfelse>
			 <cfset temp = QuerySetCell(CALLER.USPSCityStateQuery, "ValidatedZip5", "")>
		  </cfif>
		  <cfif StructKeyExists(CALLER.stUSPSAddrCityStateLookup.CityStateLookupResponse.ZipCode, "Error")>	
				<cfset temp = QuerySetCell(CALLER.USPSCityStateQuery, "Error", CALLER.stUSPSAddrCityStateLookup.CityStateLookupResponse.ZipCode.Error.Description.XmlText, i)>
		  <cfelse>
				<cfset temp = QuerySetCell(CALLER.USPSCityStateQuery, "Error", "")>
		  </cfif>
		  
		  
		<cfelseif IsDefined("CALLER.stUSPSAddrCityStateLookup.CityStateLookupResponse.ZipCode.Error.Description.XmlText")>
			<cfset CALLER.USPSError = 1>
			<cfset CALLER.USPSCityStateErrorDesc = CALLER.stUSPSAddrCityStateLookup.CityStateLookupResponse.ZipCode.Error.Description.XmlText>
		<cfelse>
			<cfset CALLER.USPSError = 2>
			<cfset CALLER.USPSCityStateErrorDesc = "Invalid Response received from USPS or there was a communication error">
		</cfif>

  	<cfelse>
		<!--- Error Address element should always be returned  , unexpected response --->
		<cfset CALLER.USPSError = 2>
		<cfset CALLER.USPSCityStateErrorDesc = "Hard Error: Response from USPS Servers is unexpected and not handled, no validation has been received">
	</cfif>

 </cfcase>
 <!--- End USPS USPS Address City/State Lookup --->
 
 <cfcase value="DeliveryConfirmation">
 
		<!--- 
	File = “/ShippingAPItest.dll?”
	= "API=DeliveryConfirmationV2&XML=" & XMLSTRING
	For “Sample” test requests the code should read:
	File = “/ShippingAPI.dll?”
	xml = "API=DelivConfirmCertify&XML=" & XMLSTRING
	For “Live” requests the code should read:
	File = “/ShippingAPI.dll?”
	xml = "API=DeliveryConfirmationV2&XML=" & XMLSTRING
	 --->
	
	<cfscript>
	
	if (ATTRIBUTES.TestingEnvironment eq "True") {
		APIIndicator = 'API=DelivConfirmCertify&XML=';
		ATTRIBUTES.USPSServer = 'http://Production.ShippingAPIs.com/ShippingAPI.dll';
		TopLevelElementIndicator = 'DelivConfirmCertifyRequest';
	}
	else {
		APIIndicator = 'API=DeliveryConfirmationPIC&XML=';
		ATTRIBUTES.USPSServer = 'http://Production.ShippingAPIs.com/ShippingAPI.dll';
		TopLevelElementIndicator = 'DeliveryConfirmationV2.0Request';
	}
	
	if (ATTRIBUTES.CannedRequest eq "True") {
		APIIndicator = 'API=DeliveryConfirmationV2&XML=';
		ATTRIBUTES.USPSServer = 'http://testing.ShippingAPIs.com/ShippingAPITest.dll';
	}
	if (ATTRIBUTES.SeparateReceipt eq "True") {
		SeparateReceiptIndicator = '<SeparateReceiptPage>True</SeparateReceiptPage>';
	}
	else {
		SeparateReceiptIndicator = '<SeparateReceiptPage>False</SeparateReceiptPage>';
	}
	if (ATTRIBUTES.POBoxZip neq "") {
		POBoxZipIndicator = '<POZipCode>#ATTRIBUTES.POBoxZip#</POZipCode>';
	}
	else { POBoxZipIndicator = ''; }
	
	if ( Len(ATTRIBUTES.PostDatedLabelDate) neq 0 ) {
		LabelDateIndicator = #ATTRIBUTES.PostDatedLabelDate#;
	}
	else { LabelDateIndicator = ''; }
	
	if ( Len(ATTRIBUTES.PostDatedLabelDate) neq 0 ) {
		LabelDateIndicator = #ATTRIBUTES.PostDatedLabelDate#;
	}
	else { LabelDateIndicator = ''; }
	
	if ( Len(ATTRIBUTES.EmailRecipientAddress) neq 0 ) {
		RecipientEmailIndicator = '<RecipientEMail>#ATTRIBUTES.EmailRecipientAddress#</RecipientEMail>';
	}
	else { RecipientEmailIndicator = ''; }
	
	if ( Len(ATTRIBUTES.EmailRecipientName) neq 0 ) {
		RecipientNameIndicator = '<RecipientName>#ATTRIBUTES.EmailRecipientName#</RecipientName>';
	}
	else { RecipientNameIndicator = ''; }
	
	if ( Len(ATTRIBUTES.EmailSenderAddress) neq 0 ) {
		SenderEmailIndicator = '<SenderEMail>#ATTRIBUTES.EmailSenderAddress#</SenderEMail>';
	}
	else { SenderEmailIndicator = ''; }
	
	if ( Len(ATTRIBUTES.EmailSenderName) neq 0 ) {
		SenderNameIndicator = '<SenderName>#ATTRIBUTES.EmailSenderName#</SenderName>';
	}
	else { SenderNameIndicator = ''; }

	ATTRIBUTES.XMLRequestInput = '<?xml version="#ATTRIBUTES.XMLVersion#"?>
	<#TopLevelElementIndicator# USERID="#ATTRIBUTES.USPSUserID#" PASSWORD="#ATTRIBUTES.USPSPassword#">
		<Option>#ATTRIBUTES.ShippingLabelType#</Option>
		<ImageParameters></ImageParameters>
		<FromName>#ATTRIBUTES.ShipFromName#</FromName>
		<FromFirm>#ATTRIBUTES.ShipFromCompany#</FromFirm>
		<FromAddress1>#ATTRIBUTES.ShipFromAddress2#</FromAddress1>
		<FromAddress2>#ATTRIBUTES.ShipFromAddress1#</FromAddress2>
		<FromCity>#ATTRIBUTES.ShipFromCity#</FromCity>
		<FromState>#ATTRIBUTES.ShipFromState#</FromState>
		<FromZip5>#ATTRIBUTES.ShipFromZip5#</FromZip5>
		<FromZip4>#ATTRIBUTES.ShipFromZip4Extended#</FromZip4>
		<ToName>#ATTRIBUTES.ShipToName#</ToName>
		<ToFirm>#ATTRIBUTES.ShipToCompany#</ToFirm>
		<ToAddress1>#ATTRIBUTES.ShipToAddress2#</ToAddress1>
		<ToAddress2>#ATTRIBUTES.ShipToAddress1#</ToAddress2>
		<ToCity>#ATTRIBUTES.ShipToCity#</ToCity>
		<ToState>#ATTRIBUTES.ShipToState#</ToState>
		<ToZip5>#ATTRIBUTES.ShipToZip5#</ToZip5>
		<ToZip4>#ATTRIBUTES.ShipToZip4Extended#</ToZip4>
		<WeightInOunces>#ATTRIBUTES.PackageWeightOZ#</WeightInOunces>
		<ServiceType>#ATTRIBUTES.ServiceLevel#</ServiceType>
		#SeparateReceiptIndicator#
		#POBoxZipIndicator#
		<ImageType>#ATTRIBUTES.ShippingLabelImage#</ImageType>
		#LabelDateIndicator#
		<CustomerRefNo>#ATTRIBUTES.ReferenceNumber#</CustomerRefNo>
		<AddressServiceRequested>#ATTRIBUTES.ChangeOfAddressNotification#</AddressServiceRequested>
		#SenderNameIndicator#
		#SenderEmailIndicator#
		#RecipientNameIndicator#
		#RecipientEmailIndicator#
	</#TopLevelElementIndicator#>';
	</cfscript>
	
	<cfset strXMLRequest = #Evaluate(DE(APIIndicator))#>

	<cfhttp method="post" url="#ATTRIBUTES.USPSServer#" resolveurl="yes" port="80" timeout="#ATTRIBUTES.TimeOut#">
		<cfhttpparam name="XML" type="xml" value="#strXMLRequest##ATTRIBUTES.XMLRequestInput#">
	</cfhttp>
	
	<cfif ATTRIBUTES.Debug eq "TRUE">
		<cfif IsDefined("cfhttp.FileContent")>
		  <cfif IsXmlDoc(Trim(cfhttp.FileContent))>
			<cfset CALLER.stUSPSDeliveryConfirm = XmlParse(Trim(cfhttp.FileContent))>
			<cfoutput>
				<cfdump var="#CALLER.stUSPSDeliveryConfirm#">
			</cfoutput>
		  <cfelse>
		  	Response Screen Dump:<br>
			<cfoutput>#cfhttp.FileContent#</cfoutput>
		  </cfif>
		</cfif>
			<cffile action="WRITE" file="#ATTRIBUTES.ServerFilePath##trailingSlash#Debug#trailingSlash#DeliveryConfirmRequest.xml" output="#ATTRIBUTES.XMLRequestInput#" addnewline="No" nameconflict="overwrite">
		<cfabort>
	
	<cfelse>
		<cfif IsDefined("cfhttp.FileContent")>
			<cfset CALLER.stUSPSDeliveryConfirm = XmlParse(Trim(cfhttp.FileContent))>
			
			<!--- <cfoutput><cfdump var="#CALLER.stUSPSDeliveryConfirm#"></cfoutput> --->
			
			<cfif ATTRIBUTES.TestingEnvironment eq "True">
			 <!--- Test response --->
				<cfset aDelivConfirmPackage = XmlSearch(CALLER.stUSPSDeliveryConfirm, "/DelivConfirmCertifyResponse/DeliveryConfirmationLabel")>
				<cfset aDelivConfirmNumber = XmlSearch(CALLER.stUSPSDeliveryConfirm, "/DelivConfirmCertifyResponse/DeliveryConfirmationNumber")>
			<cfelse>
			 <!--- Production response --->
				<cfset aDelivConfirmPackage = XmlSearch(CALLER.stUSPSDeliveryConfirm, "/DeliveryConfirmationV2.0Response/DeliveryConfirmationLabel")>
				<cfset aDelivConfirmNumber = XmlSearch(CALLER.stUSPSDeliveryConfirm, "/DeliveryConfirmationV2.0Response/DeliveryConfirmationNumber")>
			</cfif>
			
			<cfif #ArrayLen(aDelivConfirmNumber)# eq 1>
				<cfset CALLER.USPSError = 0>
				<cfset CALLER.USPSDeliveryConfirmErrorDesc = "Success">
				
				<cfset CALLER.ConfirmationNumber = #aDelivConfirmNumber[1].XmlText#>
				
				<cfif #ArrayLen(aDelivConfirmPackage)# eq 1>
					<cfset CALLER.ConfirmationLabelName = #CALLER.ConfirmationNumber#&"."&#ATTRIBUTES.ShippingLabelImage#>
					<cfset binary = toBinary("#aDelivConfirmPackage[1].XmlText#")>
					<cffile action="WRITE" file="#ATTRIBUTES.ServerFilePath##trailingSlash#Labels#trailingSlash##CALLER.ConfirmationLabelName#" output="#binary#" addnewline="No" nameconflict="overwrite">
				</cfif>
				
			<cfelseif IsDefined("CALLER.stUSPSDeliveryConfirm.Error.Description.XmlText")>
				<cfset CALLER.USPSError = 1>
				<cfset CALLER.USPSDeliveryConfirmErrorDesc = CALLER.stUSPSDeliveryConfirm.Error.Description.XmlText>
			<cfelse>
				<cfset CALLER.USPSError = 2>
				<cfset CALLER.USPSDeliveryConfirmErrorDesc = "Error: Unexpected response received from USPS servers">
			</cfif>
		
		<cfelse>
			<cfset CALLER.USPSError = 2>
			<cfset CALLER.USPSDeliveryConfirmErrorDesc = "Error: Unexpected response received from USPS servers">
			
		</cfif>
		
	</cfif>
	
 </cfcase>
 <!--- End USPS Delivery Confirmation --->

 <!--- Start USPS Express Mail Label request --->
 <cfcase value="ExpressMailLabel">
 
		<!--- 	
		For “Canned” test requests the code should read:
		-----------------------------------------------
		File = “/ShippingAPItest.dll?”
		xml = "ExpressMailLabel&XML=" & XMLSTRING
		
		For “Sample” test requests the code should read:
		------------------------------------------------
		File = “/ShippingAPI.dll?”
		xml = "API=ExpressMailLabelCertify&XML=" & XMLSTRING
		
		For “Live” requests the code should read:
		-----------------------------------------
		File = “/ShippingAPI.dll?”
		xml = "API=ExpressMailLabel&XML=" & XMLSTRING

	 --->
	
	<cfscript>
	
	if (ATTRIBUTES.TestingEnvironment eq "True") {
		APIIndicator = 'API=ExpressMailLabelCertify&XML=';
		TopLevelElementIndicator = 'ExpressMailLabelCertifyRequest';
		ATTRIBUTES.USPSServer = 'http://Production.ShippingAPIs.com/ShippingAPI.dll';
	}
	else {
		APIIndicator = 'API=ExpressMailLabel&XML=';
		TopLevelElementIndicator = 'ExpressMailLabelRequest';
		ATTRIBUTES.USPSServer = 'http://Production.ShippingAPIs.com/ShippingAPI.dll';
	}
	if (ATTRIBUTES.CannedRequest eq "True") {
		APIIndicator = 'ExpressMailLabel&XML=';
		TopLevelElementIndicator = 'ExpressMailLabelRequest';
		ATTRIBUTES.USPSServer = 'http://testing.ShippingAPIs.com/ShippingAPITest.dll';
	}
	if (ATTRIBUTES.POBoxZip neq "") {
		POBoxZipIndicator = '<POZipCode>#ATTRIBUTES.POBoxZip#</POZipCode>';
	}
	else { POBoxZipIndicator = '<POZipCode/>'; }
	
	if ( Len(ATTRIBUTES.PostDatedLabelDate) neq 0 ) {
		LabelDateIndicator = #ATTRIBUTES.PostDatedLabelDate#;
	}
	else { LabelDateIndicator = ''; }
	
	if ( Len(ATTRIBUTES.PostDatedLabelDate) neq 0 ) {
		LabelDateIndicator = #ATTRIBUTES.PostDatedLabelDate#;
	}
	else { LabelDateIndicator = ''; }
	
	if ( Len(ATTRIBUTES.EmailRecipientAddress) neq 0 ) {
		RecipientEmailIndicator = '<RecipientEMail>#ATTRIBUTES.EmailRecipientAddress#</RecipientEMail>';
	}
	else { RecipientEmailIndicator = ''; }
	
	if ( Len(ATTRIBUTES.EmailRecipientName) neq 0 ) {
		RecipientNameIndicator = '<RecipientName>#ATTRIBUTES.EmailRecipientName#</RecipientName>';
	}
	else { RecipientNameIndicator = ''; }
	
	if ( Len(ATTRIBUTES.EmailSenderAddress) neq 0 ) {
		SenderEmailIndicator = '<SenderEMail>#ATTRIBUTES.EmailSenderAddress#</SenderEMail>';
	}
	else { SenderEmailIndicator = ''; }
	
	if ( Len(ATTRIBUTES.EmailSenderName) neq 0 ) {
		SenderNameIndicator = '<SenderName>#ATTRIBUTES.EmailSenderName#</SenderName>';
	}
	else { SenderNameIndicator = ''; }
	
	ATTRIBUTES.XMLRequestInput = '<?xml version="#ATTRIBUTES.XMLVersion#"?>
	<#TopLevelElementIndicator# USERID="#ATTRIBUTES.USPSUserID#" PASSWORD="#ATTRIBUTES.USPSPassword#">
		<Option/>
		<EMCAAccount/>
		<EMCAPassword/>
		<ImageParameters/>
		<FromFirstName>#ATTRIBUTES.ShipFromFirstName#</FromFirstName>
		<FromLastName>#ATTRIBUTES.ShipFromLastName#</FromLastName>
		<FromFirm>#ATTRIBUTES.ShipFromCompany#</FromFirm>
		<FromAddress1>#ATTRIBUTES.ShipFromAddress2#</FromAddress1>
		<FromAddress2>#ATTRIBUTES.ShipFromAddress1#</FromAddress2>
		<FromCity>#ATTRIBUTES.ShipFromCity#</FromCity>
		<FromState>#ATTRIBUTES.ShipFromState#</FromState>
		<FromZip5>#ATTRIBUTES.ShipFromZip5#</FromZip5>
		<FromZip4>#ATTRIBUTES.ShipFromZip4Extended#</FromZip4>
		<FromPhone>#ATTRIBUTES.ShipFromPhone#</FromPhone>
		<ToFirstName>#ATTRIBUTES.ShipToFirstName#</ToFirstName>
		<ToLastName>#ATTRIBUTES.ShipToLastName#</ToLastName>
		<ToFirm>#ATTRIBUTES.ShipToCompany#</ToFirm>
		<ToAddress1>#ATTRIBUTES.ShipToAddress2#</ToAddress1>
		<ToAddress2>#ATTRIBUTES.ShipToAddress1#</ToAddress2>
		<ToCity>#ATTRIBUTES.ShipToCity#</ToCity>
		<ToState>#ATTRIBUTES.ShipToState#</ToState>
		<ToZip5>#ATTRIBUTES.ShipToZip5#</ToZip5>
		<ToZip4>#ATTRIBUTES.ShipToZip4Extended#</ToZip4>
		<ToPhone>#ATTRIBUTES.ShipToPhone#</ToPhone>
		<WeightInOunces>#ATTRIBUTES.PackageWeightOZ#</WeightInOunces>
		<FlatRate>#ATTRIBUTES.ExpressMailFlatRate#</FlatRate>
		<StandardizeAddress>#ATTRIBUTES.ExpressMailValidateAddress#</StandardizeAddress>
		<WaiverOfSignature>#ATTRIBUTES.WaiverOfSignature#</WaiverOfSignature>
		<NoHoliday>#ATTRIBUTES.NoDeliverOnHoliday#</NoHoliday>
		<NoWeekend>#ATTRIBUTES.NoDeliverOnWeekend#</NoWeekend>
		<SeparateReceiptPage>#ATTRIBUTES.SeparateReceipt#</SeparateReceiptPage>
		#POBoxZipIndicator#
		<ImageType>#ATTRIBUTES.ShippingLabelImage#</ImageType>
		#LabelDateIndicator#
		<CustomerRefNo>#ATTRIBUTES.ReferenceNumber#</CustomerRefNo>
		#SenderNameIndicator#
		#SenderEmailIndicator#
		#RecipientNameIndicator#
		#RecipientEmailIndicator#
	</#TopLevelElementIndicator#>';
	</cfscript>
	
	<cfset strXMLRequest = #Evaluate(DE(APIIndicator))#>
	
	<cfhttp method="post" url="#ATTRIBUTES.USPSServer#" resolveurl="yes" port="80" timeout="#ATTRIBUTES.TimeOut#">
		<cfhttpparam name="XML" type="xml" value="#strXMLRequest##ATTRIBUTES.XMLRequestInput#">
	</cfhttp>
	
	<cfset CALLER.stUSPSExpressMailLabel = XmlParse(Trim(cfhttp.FileContent))>
	
	<!--- <cfoutput>
			<cfdump var="#CALLER.stUSPSExpressMailLabel#">
			<cfdump var="#ATTRIBUTES.XMLRequestInput#">
	</cfoutput> --->
		
	<cfif ATTRIBUTES.Debug eq "TRUE">
		<cffile action="WRITE" file="#ATTRIBUTES.ServerFilePath##trailingSlash#Debug#trailingSlash#ExpressMailRequest.xml" output="#ATTRIBUTES.XMLRequestInput#" addnewline="No" nameconflict="overwrite">
		<cffile action="WRITE" file="#ATTRIBUTES.ServerFilePath##trailingSlash#Debug#trailingSlash#ExpressMailResponse.xml" output="#cfhttp.FileContent#" addnewline="No" nameconflict="overwrite">
		<cfoutput>
			<cfdump var="#CALLER.stUSPSExpressMailLabel#">
		</cfoutput>
		<cfabort>
	</cfif>
	
	<cfif ATTRIBUTES.TestingEnvironment eq "FALSE">
	
		<cfif IsDefined("CALLER.stUSPSExpressMailLabel.Error.Description.XmlText")>
			<cfset CALLER.USPSError = 1>
			<cfset CALLER.USPSEMErrorDesc = CALLER.stUSPSExpressMailLabel.Error.Description.XmlText>
		
		<cfelseif IsDefined("CALLER.stUSPSExpressMailLabel.ExpressMailLabelResponse")>	
			<cfset CALLER.USPSError = 0>
			<cfset CALLER.USPSEMErrorDesc = "">
			
			<!--- 
			POSTAGE  TOADDRESS1  TOADDRESS2  TOCITY  TOFIRM  
			TOFIRSTNAME  TOLASTNAME  TOSTATE  TOZIP4  TOZIP5
			 --->  
			<cfif StructKeyExists(CALLER.stUSPSExpressMailLabel.ExpressMailLabelResponse, "EMConfirmationNumber")>
				<cfset CALLER.EMConfirmationNumber = CALLER.stUSPSExpressMailLabel.ExpressMailLabelResponse.EMConfirmationNumber.XmlText>
				<!--- Create Shipping Label if it exists --->
				<cfif StructKeyExists(CALLER.stUSPSExpressMailLabel.ExpressMailLabelResponse, "EMLabel") >
					<cfset CALLER.EMConfirmationLabelName = #CALLER.EMConfirmationNumber#&"."&#ATTRIBUTES.ShippingLabelImage#>
					<cfset binary = toBinary("#CALLER.stUSPSExpressMailLabel.ExpressMailLabelResponse.EMLABEL.XmlText#")>
					<cffile action="WRITE" file="#ATTRIBUTES.ServerFilePath##trailingSlash#Labels#trailingSlash##CALLER.EMConfirmationLabelName#" output="#binary#" addnewline="No" nameconflict="overwrite">
				</cfif>
			<cfelse>
				<cfset CALLER.EMConfirmationNumber = "">
			</cfif>
			<cfif StructKeyExists(CALLER.stUSPSExpressMailLabel.ExpressMailLabelResponse, "Postage")>
				<cfset CALLER.EMPostage = CALLER.stUSPSExpressMailLabel.ExpressMailLabelResponse.Postage.XmlText>
			<cfelse>
				<cfset CALLER.EMPostage = "">
			</cfif>
			<cfif StructKeyExists(CALLER.stUSPSExpressMailLabel.ExpressMailLabelResponse, "ToAddress1")>
				<cfset CALLER.EMToAddress2 = CALLER.stUSPSExpressMailLabel.ExpressMailLabelResponse.ToAddress1.XmlText>
			<cfelse>
				<cfset CALLER.EMToAddress2 = "">
			</cfif>
			<cfif StructKeyExists(CALLER.stUSPSExpressMailLabel.ExpressMailLabelResponse, "ToAddress2")>
				<cfset CALLER.EMToAddress1 = CALLER.stUSPSExpressMailLabel.ExpressMailLabelResponse.ToAddress2.XmlText>
			<cfelse>
				<cfset CALLER.EMToAddress1 = "">
			</cfif>
			<cfif StructKeyExists(CALLER.stUSPSExpressMailLabel.ExpressMailLabelResponse, "ToCity")>
				<cfset CALLER.EMToCity = CALLER.stUSPSExpressMailLabel.ExpressMailLabelResponse.ToCity.XmlText>
			<cfelse>
				<cfset CALLER.EMToCity = "">
			</cfif>
			<cfif StructKeyExists(CALLER.stUSPSExpressMailLabel.ExpressMailLabelResponse, "ToState")>
				<cfset CALLER.EMToState = CALLER.stUSPSExpressMailLabel.ExpressMailLabelResponse.ToState.XmlText>
			<cfelse>
				<cfset CALLER.EMToState = "">
			</cfif>
			<cfif StructKeyExists(CALLER.stUSPSExpressMailLabel.ExpressMailLabelResponse, "ToZip5")>
				<cfset CALLER.EMToZip = CALLER.stUSPSExpressMailLabel.ExpressMailLabelResponse.ToZip5.XmlText>
			<cfelse>
				<cfset CALLER.EMToZip = "">
			</cfif>
			<cfif StructKeyExists(CALLER.stUSPSExpressMailLabel.ExpressMailLabelResponse, "ToZip4")>
				<cfset CALLER.EMToZipExtended = CALLER.stUSPSExpressMailLabel.ExpressMailLabelResponse.ToZip4.XmlText>
			<cfelse>
				<cfset CALLER.EMToZipExtended = "">
			</cfif>
			<cfif StructKeyExists(CALLER.stUSPSExpressMailLabel.ExpressMailLabelResponse, "ToFirstName")>
				<cfset CALLER.EMToFirstName = CALLER.stUSPSExpressMailLabel.ExpressMailLabelResponse.ToFirstName.XmlText>
			<cfelse>
				<cfset CALLER.EMToFirstName = "">
			</cfif>
			<cfif StructKeyExists(CALLER.stUSPSExpressMailLabel.ExpressMailLabelResponse, "ToLastName")>
				<cfset CALLER.EMToLastName = CALLER.stUSPSExpressMailLabel.ExpressMailLabelResponse.ToLastName.XmlText>
			<cfelse>
				<cfset CALLER.EMToLastName = "">
			</cfif>
			<cfif StructKeyExists(CALLER.stUSPSExpressMailLabel.ExpressMailLabelResponse, "ToFirm")>
				<cfset CALLER.EMToCompany = CALLER.stUSPSExpressMailLabel.ExpressMailLabelResponse.ToFirm.XmlText>
			<cfelse>
				<cfset CALLER.EMToCompany = "">
			</cfif>
			
		<cfelse>
			<!--- Unexpected error response --->
			<cfset CALLER.USPSError = 2>
			<cfset CALLER.USPSEMErrorDesc = "ERROR: Unexpected response received from USPS Servers">
		</cfif>
	
	<cfelse>
	<!--- Sample Label Request --->
		
		<cfif IsDefined("CALLER.stUSPSExpressMailLabel.Error.Description.XmlText")>
			<cfset CALLER.USPSError = 1>
			<cfset CALLER.USPSEMErrorDesc = CALLER.stUSPSExpressMailLabel.Error.Description.XmlText>
		
		<cfelseif IsDefined("CALLER.stUSPSExpressMailLabel.ExpressMailLabelCertifyResponse")>	
			<cfset CALLER.USPSError = 0>
			<cfset CALLER.USPSEMErrorDesc = "">
			
			<!--- 
			POSTAGE  TOADDRESS1  TOADDRESS2  TOCITY  TOFIRM  
			TOFIRSTNAME  TOLASTNAME  TOSTATE  TOZIP4  TOZIP5
			 --->  
			<cfif StructKeyExists(CALLER.stUSPSExpressMailLabel.ExpressMailLabelCertifyResponse, "EMConfirmationNumber")>
				<cfset CALLER.EMConfirmationNumber = CALLER.stUSPSExpressMailLabel.ExpressMailLabelCertifyResponse.EMConfirmationNumber.XmlText>
				<!--- Create Shipping Label if it exists --->
				<cfif StructKeyExists(CALLER.stUSPSExpressMailLabel.ExpressMailLabelCertifyResponse, "EMLabel") >
					<cfset CALLER.EMConfirmationLabelName = #CALLER.EMConfirmationNumber#&"."&#ATTRIBUTES.ShippingLabelImage#>
					<cfset binary = toBinary("#CALLER.stUSPSExpressMailLabel.ExpressMailLabelCertifyResponse.EMLABEL.XmlText#")>
					<cffile action="WRITE" file="#ATTRIBUTES.ServerFilePath##trailingSlash#Labels#trailingSlash##CALLER.EMConfirmationLabelName#" output="#binary#" addnewline="No" nameconflict="overwrite">
				</cfif>
			<cfelse>
				<cfset CALLER.EMConfirmationNumber = "">
			</cfif>
			<cfif StructKeyExists(CALLER.stUSPSExpressMailLabel.ExpressMailLabelCertifyResponse, "Postage")>
				<cfset CALLER.EMPostage = CALLER.stUSPSExpressMailLabel.ExpressMailLabelCertifyResponse.Postage.XmlText>
			<cfelse>
				<cfset CALLER.EMPostage = "">
			</cfif>
			<cfif StructKeyExists(CALLER.stUSPSExpressMailLabel.ExpressMailLabelCertifyResponse, "ToAddress1")>
				<cfset CALLER.EMToAddress2 = CALLER.stUSPSExpressMailLabel.ExpressMailLabelCertifyResponse.ToAddress1.XmlText>
			<cfelse>
				<cfset CALLER.EMToAddress2 = "">
			</cfif>
			<cfif StructKeyExists(CALLER.stUSPSExpressMailLabel.ExpressMailLabelCertifyResponse, "ToAddress2")>
				<cfset CALLER.EMToAddress1 = CALLER.stUSPSExpressMailLabel.ExpressMailLabelCertifyResponse.ToAddress2.XmlText>
			<cfelse>
				<cfset CALLER.EMToAddress1 = "">
			</cfif>
			<cfif StructKeyExists(CALLER.stUSPSExpressMailLabel.ExpressMailLabelCertifyResponse, "ToCity")>
				<cfset CALLER.EMToCity = CALLER.stUSPSExpressMailLabel.ExpressMailLabelCertifyResponse.ToCity.XmlText>
			<cfelse>
				<cfset CALLER.EMToCity = "">
			</cfif>
			<cfif StructKeyExists(CALLER.stUSPSExpressMailLabel.ExpressMailLabelCertifyResponse, "ToState")>
				<cfset CALLER.EMToState = CALLER.stUSPSExpressMailLabel.ExpressMailLabelCertifyResponse.ToState.XmlText>
			<cfelse>
				<cfset CALLER.EMToState = "">
			</cfif>
			<cfif StructKeyExists(CALLER.stUSPSExpressMailLabel.ExpressMailLabelCertifyResponse, "ToZip5")>
				<cfset CALLER.EMToZip = CALLER.stUSPSExpressMailLabel.ExpressMailLabelCertifyResponse.ToZip5.XmlText>
			<cfelse>
				<cfset CALLER.EMToZip = "">
			</cfif>
			<cfif StructKeyExists(CALLER.stUSPSExpressMailLabel.ExpressMailLabelCertifyResponse, "ToZip4")>
				<cfset CALLER.EMToZipExtended = CALLER.stUSPSExpressMailLabel.ExpressMailLabelCertifyResponse.ToZip4.XmlText>
			<cfelse>
				<cfset CALLER.EMToZipExtended = "">
			</cfif>
			<cfif StructKeyExists(CALLER.stUSPSExpressMailLabel.ExpressMailLabelCertifyResponse, "ToFirstName")>
				<cfset CALLER.EMToFirstName = CALLER.stUSPSExpressMailLabel.ExpressMailLabelCertifyResponse.ToFirstName.XmlText>
			<cfelse>
				<cfset CALLER.EMToFirstName = "">
			</cfif>
			<cfif StructKeyExists(CALLER.stUSPSExpressMailLabel.ExpressMailLabelCertifyResponse, "ToLastName")>
				<cfset CALLER.EMToLastName = CALLER.stUSPSExpressMailLabel.ExpressMailLabelCertifyResponse.ToLastName.XmlText>
			<cfelse>
				<cfset CALLER.EMToLastName = "">
			</cfif>
			<cfif StructKeyExists(CALLER.stUSPSExpressMailLabel.ExpressMailLabelCertifyResponse, "ToFirm")>
				<cfset CALLER.EMToCompany = CALLER.stUSPSExpressMailLabel.ExpressMailLabelCertifyResponse.ToFirm.XmlText>
			<cfelse>
				<cfset CALLER.EMToCompany = "">
			</cfif>
			
		<cfelse>
			<!--- Unexpected error response --->
			<cfset CALLER.USPSError = 2>
			<cfset CALLER.USPSEMErrorDesc = "ERROR: Unexpected response received from USPS Servers">
		</cfif>
	
	</cfif>
	
 </cfcase>
 <!--- End USPS Express Mail Label request --->
 
 <!--- Start USPS Priority Mail Service Standards request --->
 <cfcase value="PriorityServiceRequest">
	
	<cfscript>
	ATTRIBUTES.XMLRequestInput = '<PriorityMailRequest USERID="#ATTRIBUTES.USPSUserID#" PASSWORD="#ATTRIBUTES.USPSPassword#">
		<OriginZip>#ATTRIBUTES.ShipFromZip5#</OriginZip>
		<DestinationZip>#ATTRIBUTES.ShipToZip5#</DestinationZip>
	</PriorityMailRequest>';
	</cfscript>
	
	<cfhttp method="post" url="#ATTRIBUTES.USPSServer#" resolveurl="yes" port="80" timeout="#ATTRIBUTES.TimeOut#">
		<cfhttpparam name="XML" type="xml" value="API=PriorityMail&XML=#ATTRIBUTES.XMLRequestInput#">
	</cfhttp>
	
	<cfset CALLER.stUSPSPryMailService = XmlParse(Trim(cfhttp.FileContent))>
	
	<cfif ATTRIBUTES.Debug eq "TRUE">
		<cffile action="WRITE" file="#ATTRIBUTES.ServerFilePath##trailingSlash#Debug#trailingSlash#PriorityServiceRequest.xml" output="#ATTRIBUTES.XMLRequestInput#" addnewline="No" nameconflict="overwrite">
		  <cfoutput>
			<cfdump var="#CALLER.stUSPSPryMailService#">
			<cfabort>
		  </cfoutput>
		<cfabort>
	</cfif>
	
	<!--- 
	Error schema
	------------
	<Error>
		<Number></Number>
		<Source></Source>
		<Description></Description>
		<HelpFile></HelpFile>
		<HelpContext></HelpContext>
	</Error>
	
	Success schema
	--------------
	<PriorityMailResponse>
		<OriginZip>4</OriginZip>
		<DestinationZip>4</DestinationZip>
		<Days>1</Days>
	</PriorityMailResponse>
	 --->
	
	<cfif StructKeyExists(CALLER.stUSPSPryMailService, "Error")> <!--- Error in request --->
	  	<cfset CALLER.USPSError = 1> <!--- Error --->
		<cfset CALLER.USPSPryServiceErrorDesc = CALLER.stUSPSPryMailService.Error.Description.XmlText>
	
	<cfelseif StructKeyExists(CALLER.stUSPSPryMailService, "PriorityMailResponse")>
		<cfset CALLER.USPSError = 0> <!--- Success --->
		<cfset CALLER.USPSPryServiceErrorDesc = "Success">
		
	    <cfif StructKeyExists(CALLER.stUSPSPryMailService.PriorityMailResponse, "OriginZip")>
			<cfset CALLER.OriginZip3 = CALLER.stUSPSPryMailService.PriorityMailResponse.OriginZip.XmlText>
		<cfelse>
			<!--- invalid response received --->
			<cfset CALLER.OriginZip3 = "">
		</cfif>
		<cfif StructKeyExists(CALLER.stUSPSPryMailService.PriorityMailResponse, "DestinationZip")>
			<cfset CALLER.DestZip3 = CALLER.stUSPSPryMailService.PriorityMailResponse.DestinationZip.XmlText>
		<cfelse>
			<!--- invalid response received --->
			<cfset CALLER.DestZip3 = "">
		</cfif>
		<cfif StructKeyExists(CALLER.stUSPSPryMailService.PriorityMailResponse, "Days")>
			<cfset CALLER.DeliveryDays = CALLER.stUSPSPryMailService.PriorityMailResponse.Days.XmlText>
		<cfelse>
			<!--- invalid response received --->
			<cfset CALLER.DeliveryDays = "">
		</cfif>
	<cfelse>
		<cfset CALLER.USPSError = 2>
		<cfset CALLER.USPSPryServiceErrorDesc = "Undefined error received from USPS">
	</cfif>
		
 </cfcase>
 <!--- End USPS Priority Mail Service Standards request --->
 
  <!--- Start USPS Package Mail Service Standards request --->
 <cfcase value="PackageServiceRequest">

	<cfscript>
	ATTRIBUTES.XMLRequestInput = '<StandardBRequest USERID="#ATTRIBUTES.USPSUserID#" PASSWORD="#ATTRIBUTES.USPSPassword#">
		<OriginZip>#ATTRIBUTES.ShipFromZip5#</OriginZip>
		<DestinationZip>#ATTRIBUTES.ShipToZip5#</DestinationZip>
	</StandardBRequest>';
	</cfscript>
	
	<cfhttp method="post" url="#ATTRIBUTES.USPSServer#" resolveurl="yes" port="80" timeout="#ATTRIBUTES.TimeOut#">
		<cfhttpparam name="XML" type="xml" value="API=StandardB&XML=#ATTRIBUTES.XMLRequestInput#">
	</cfhttp>
	
	<cfset CALLER.stUSPSPackageService = XmlParse(Trim(cfhttp.FileContent))>
	
	<cfif ATTRIBUTES.Debug eq "TRUE">
		<cffile action="WRITE" file="#ATTRIBUTES.ServerFilePath##trailingSlash#Debug#trailingSlash#PackageServiceRequest.xml" output="#ATTRIBUTES.XMLRequestInput#" addnewline="No" nameconflict="overwrite">
		  <cfoutput>
			<cfdump var="#CALLER.stUSPSPackageService#">
			<cfabort>
		  </cfoutput>
		<cfabort>
	</cfif>
	
	<!--- 
	Error schema
	------------
	<Error>
		<Number></Number>
		<Source></Source>
		<Description></Description>
		<HelpFile></HelpFile>
		<HelpContext></HelpContext>
	</Error>
	
	Success schema
	--------------
	<StandardBResponse>
		<OriginZip>4</OriginZip>
		<DestinationZip>4</DestinationZip>
		<Days>1</Days>
	</StandardBResponse>
	 --->
	
	<cfif StructKeyExists(CALLER.stUSPSPackageService, "Error")> <!--- Error in request --->
	  	<cfset CALLER.USPSError = 1> <!--- Error --->
		<cfset CALLER.USPSPackageServiceErrorDesc = CALLER.stUSPSPackageService.Error.Description.XmlText>
	
	<cfelseif StructKeyExists(CALLER.stUSPSPackageService, "StandardBResponse")>
		<cfset CALLER.USPSError = 0> <!--- Success --->
		<cfset CALLER.USPSPackageServiceErrorDesc = "Success">
		
	    <cfif StructKeyExists(CALLER.stUSPSPackageService.StandardBResponse, "OriginZip")>
			<cfset CALLER.OriginZip3 = CALLER.stUSPSPackageService.StandardBResponse.OriginZip.XmlText>
		<cfelse>
			<!--- invalid response received --->
			<cfset CALLER.OriginZip3 = "">
		</cfif>
		<cfif StructKeyExists(CALLER.stUSPSPackageService.StandardBResponse, "DestinationZip")>
			<cfset CALLER.DestZip3 = CALLER.stUSPSPackageService.StandardBResponse.DestinationZip.XmlText>
		<cfelse>
			<!--- invalid response received --->
			<cfset CALLER.DestZip3 = "">
		</cfif>
		<cfif StructKeyExists(CALLER.stUSPSPackageService.StandardBResponse, "Days")>
			<cfset CALLER.DeliveryDays = CALLER.stUSPSPackageService.StandardBResponse.Days.XmlText>
		<cfelse>
			<!--- invalid response received --->
			<cfset CALLER.DeliveryDays = "">
		</cfif>
	<cfelse>
		<cfset CALLER.USPSError = 2>
		<cfset CALLER.USPSPackageServiceErrorDesc = "Undefined error received from USPS">
	</cfif>
		
 </cfcase>
 <!--- End USPS Package Service Standards request --->
 		
</cfswitch>