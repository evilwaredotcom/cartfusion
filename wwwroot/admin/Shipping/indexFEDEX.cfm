<!--- HEADER --->
<cfscript>
	PageTitle = 'FEDEX SHIPPING' ;
	BannerTitle = 'ShipWizard' ;
	AddAButton = 'RETURN TO SHIP WIZARD' ;
	AddAButtonLoc = 'index.cfm' ;
</cfscript>
<cfinclude template="LayoutShipHeader.cfm">
<cfinclude template="LayoutShipBanner.cfm">

<cfinvoke component="#application.Queries#" method="getStates" returnvariable="getStates"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getCountries" returnvariable="getCountries"></cfinvoke>

<cfscript>
	zipRequiredCtryList = ArrayNew(1); //Create array to hold list of countires that require a zip
	zipRequiredCtryList[56] = "AR";
	zipRequiredCtryList[1] = "AU";
	zipRequiredCtryList[2] = "AT";
	zipRequiredCtryList[3] = "BE";
	zipRequiredCtryList[4] = "BR";
	zipRequiredCtryList[5] = "BG";
	zipRequiredCtryList[6] = "CA";
	zipRequiredCtryList[7] = "CN";
	zipRequiredCtryList[8] = "CZ";
	zipRequiredCtryList[9] = "DK";
	zipRequiredCtryList[10] = "FO";
	zipRequiredCtryList[11] = "FI";
	zipRequiredCtryList[12] = "FR";
	zipRequiredCtryList[13] = "DE";
	zipRequiredCtryList[14] = "GR";
	zipRequiredCtryList[15] = "GL";
	zipRequiredCtryList[16] = "GU";
	zipRequiredCtryList[17] = "HU";
	zipRequiredCtryList[18] = "IN";
	zipRequiredCtryList[19] = "ID";
	zipRequiredCtryList[20] = "IL";
	zipRequiredCtryList[21] = "IT";
	zipRequiredCtryList[22] = "JP";
	zipRequiredCtryList[23] = "KR";
	zipRequiredCtryList[24] = "LA";
	zipRequiredCtryList[25] = "LI";
	zipRequiredCtryList[26] = "MY";
	zipRequiredCtryList[27] = "MH";
	zipRequiredCtryList[28] = "MX";
	zipRequiredCtryList[29] = "FM";
	zipRequiredCtryList[30] = "MC";
	zipRequiredCtryList[31] = "MN";
	zipRequiredCtryList[32] = "NL";
	zipRequiredCtryList[33] = "NC";
	zipRequiredCtryList[34] = "NZ";
	zipRequiredCtryList[35] = "NO";
	zipRequiredCtryList[36] = "PW";
	zipRequiredCtryList[37] = "PH";
	zipRequiredCtryList[38] = "PT";
	zipRequiredCtryList[39] = "RU";
	zipRequiredCtryList[40] = "SM";
	zipRequiredCtryList[41] = "SG";
	zipRequiredCtryList[42] = "SK";
	zipRequiredCtryList[43] = "ZA";
	zipRequiredCtryList[44] = "ES";
	zipRequiredCtryList[45] = "LK";
	zipRequiredCtryList[46] = "SE";
	zipRequiredCtryList[47] = "CH";
	zipRequiredCtryList[48] = "TW";
	zipRequiredCtryList[49] = "TH";
	zipRequiredCtryList[50] = "GB";
	zipRequiredCtryList[51] = "US";
	zipRequiredCtryList[52] = "UY";
	zipRequiredCtryList[53] = "VN";
	zipRequiredCtryList[54] = "WF";
	zipRequiredCtryList[55] = "PR";
	zipRequiredList = ArrayToList(zipRequiredCtryList);
</cfscript>

<br>
<table width="80%" border="0" align="center" cellpadding="1" cellspacing="0" bgcolor="660099">
  	<cfif NOT isDefined('identifier') OR identifier EQ '' >
	<tr>
		<td align="center" class="cfAdminError" bgcolor="FFFFFF">
			<b>In order to use this feature, you must have a FedEx Online Tools account, with it setup in <a href="../Config-ShipByCalc.cfm">Configuration</a>.</b><br/><br/>
		</td>
	</tr>
	</cfif>
	<tr>
		<td>
			<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0">
	  			<tr align="center">
					<td height="30" colspan="3" bgcolor="FFFFFF">
						<img src="images/Logos/logo-FEDEX.gif" vspace="5" border="0" align="absmiddle">&nbsp;&nbsp;
						<font style="font-size:14px"><b>CartFusion Fedex Tracking &amp; Rate Request Form</b></font>
					</td>
	  			</tr>
				<tr align="center">
	   				<td height="1" colspan="3" bgcolor="663399"></td>
	  			</tr>
	  			<tr>
					<td width="50%" height="20" align="center" class="cfAdminHeaderFEDEX1">Rate Shop / Service Availability Request</td>
					<td width="1" align="center" bgcolor="663399" class="cfAdminHeaderFEDEX1"></td>
					<td width="49%" height="20" align="center" class="cfAdminHeaderFEDEX1">Tracking Request</td>
	  			</tr>
				<tr>
					<td valign="top" bgcolor="FFFFFF">
						<table width="100%" border="0" cellspacing="0" cellpadding="1">
							<cfform name="RateShop" id="RateShop" method="post" action="indexFEDEX.cfm">
		  						<input type="hidden" name="Request" value="RateShop" class="cfAdminDefault" >
							<tr>
								<td>
				  					<b>Origin Country:</b><br/>			  
			  						<cfselect query="getCountries" name="originCountry" value="CountryCode" display="Country" selected="US" size="1" class="cfAdminDefault" />
			  					</td>
								<td valign="top">
									<b>Destination Country:</b><br/>
			  						<cfselect query="getCountries" name="destCountry" value="CountryCode" display="Country" selected="US" size="1" class="cfAdminDefault" />
								</td>
							</tr>
							<tr valign="top">
								<td> 
									<b>Origin State:</b><br/>
			  						<cfselect query="getStates" name="OriginState" value="StateCode" display="State" selected="CA" size="1" class="cfAdminDefault" />
								</td>
								<td>
									<b>Destination State:</b><br/>
			  						<cfinput name="DestinationState" type="text" id="DestinationState" value="" size="10" maxlength="10" class="cfAdminDefault" />
									<!---<cfselect query="getStates" name="DestinationState" value="StateCode" display="State" size="1" class="cfAdminDefault" />--->
								</td>
							</tr>
		  					<tr>
								<td valign="top">
									<b>Origin Zip/Postcode:</b><br/>			  
									<cfinput name="originZip" type="text" id="originZip" value="#application.DefaultOriginZipCode#" size="10" maxlength="10" class="cfAdminDefault" />
								</td>
								<td valign="top">
									<b>Destination Zip/Postcode:</b><br/>			  
									<cfinput name="destZip" type="text" id="destZip" value="" size="10" maxlength="10" class="cfAdminDefault" />
								</td>
		  					</tr>
		  					<tr>
								<td colspan="2">
									<b>Package Weight:</b> 
				  					<cfinput name="weight" type="text" id="originZip4" value="1" size="3" maxlength="3" class="cfAdminDefault" />
									<br/>  
									<b>Packaging Type: </b>
									<cfselect name="packageType" class="cfAdminDefault" >
										<option value="YOURPACKAGING" selected>Your Packaging</option>
										<option value="FEDEXBOX">FedEx Box</option>
										<option value="FEDEXENVELOPE">FedEx Envelope</option>
										<option value="FEDEXPAK">FedEx Pak</option>
										<option value="FEDEXTUBE">FedEx Tube</option>
										<!--- <option value="Fedex 10kg Box">Fedex 10kg Box</option>
										<option value="FedEx 25kg Box">FedEx 25kg Box</option> --->
									</cfselect>
									<br/>
				  				</td>
							</tr>
		  					<tr>
								<td colspan="2">
									<b>Service Type:</b>
			  						<cfselect name="ServiceType" class="cfAdminDefault" >
										<option value="FDXE" selected="selected">Fedex Express</option>
										<option value="FDXG">FedEx Ground</option>
			  						</cfselect>
								</td>
		  					</tr>
		  					<tr align="center">
								<td colspan="2"><cfinput name="rateRequest" type="submit" id="rateRequest" value="Get All Rates" class="cfAdminDefault" /></td>
							</tr>
							<tr align="center">
								<td colspan="2">&nbsp;</td>
		  					</tr>
		   					</cfform>
		  					<tr align="center" bgcolor="#660099">
								<td height="22" colspan="2" class="cfAdminHeaderFEDEX2">
									Specific Rate Request
								</td>
		  					</tr>
		  					<cfform name="Rate" id="Rate" method="post" action="indexFEDEX.cfm">
		  						<input type="hidden" name="Request" value="RateSpecific" class="cfAdminDefault" >
		  					<tr>
								<td>
				  					<b>Origin Country:</b><br/>			  
			  						<cfselect query="getCountries" name="originCountry" value="CountryCode" display="Country" selected="US" size="1" class="cfAdminDefault" />
			  					</td>
								<td valign="top">
									<b>Destination Country:</b><br/>
			  						<cfselect query="getCountries" name="destCountry" value="CountryCode" display="Country" selected="US" size="1" class="cfAdminDefault" />
								</td>
							</tr>
							<tr valign="top">
								<td> 
									<b>Origin State:</b><br/>
			  						<cfselect query="getStates" name="OriginState" value="StateCode" display="State" selected="CA" size="1" class="cfAdminDefault" />
								</td>
								<td>
									<b>Destination State:</b><br/>
			  						<cfselect query="getStates" name="DestinationState" value="StateCode" display="State" size="1" class="cfAdminDefault" />
								</td>
							</tr>
		  					<tr>
								<td valign="top">
									<b>Origin Zip/Postcode:</b><br/>
									<cfinput name="originZip" type="text" id="originZip" value="#application.DefaultOriginZipCode#" size="10" maxlength="10" class="cfAdminDefault" />
								</td>
								<td valign="top">
									<b>Destination Zip/Postcode:</b><br/>
									<cfinput name="destZip" type="text" id="destZip" value="" size="10" maxlength="10" class="cfAdminDefault" />
								</td>
		  					</tr>
		  					<tr>
								<td colspan="2">
									<b>Package Weight:</b>
				  					<cfinput name="weight" type="text" id="originZip4" value="1" size="3" maxlength="3" class="cfAdminDefault" />
				  					<br/>
				  					<b>Packaging Type:</b>
									<cfselect name="packageType" class="cfAdminDefault" >
										<option value="YOURPACKAGING" selected="selected">Your Packaging</option>
										<option value="FEDEXBOX">FedEx Box</option>
										<option value="FEDEXENVELOPE">FedEx Envelope</option>
										<option value="FEDEXPAK">FedEx Pak</option>
										<option value="FEDEXTUBE">FedEx Tube</option>
										<!--- <option value="Fedex 10kg Box">Fedex 10kg Box</option>
											<option value="FedEx 25kg Box">FedEx 25kg Box</option> --->
									</cfselect>
									<br/>
									<b>Service Level:</b>
									<cfselect name="Service" class="cfAdminDefault" >
										<option value="STANDARDOVERNIGHT" selected="selected">FedEx Standard Overnight</option>
										<option value="PRIORITYOVERNIGHT">FedEx Priority Overnight</option>
										<option value="FIRSTOVERNIGHT">FedEx First Overnight</option>
										<option value="FEDEX2DAY">FedEx 2nd Day Air</option>
										<option value="FEDEXEXPRESSSAVER">FedEx Express Saver</option>
										<option value="FEDEXGROUND">FedEx Ground</option>
										<option value="GROUNDHOMEDELIVERY">FedEx Ground Home Delivery</option>
									</cfselect>
								</td>
							</tr>
							<tr align="center" bgcolor="#CCCCCC">
								<td height="18" colspan="2" class="cfAdminHeader4">
									Special Services:
								</td>
							</tr>
							<tr align="center">
								<td align="right">
									Saturday Delivery 
									<cfinput name="ssSatDeliv" type="checkbox" id="ssSatDeliv5" value="1" class="cfAdminDefault" />		  
									<br/>
									Residential Delivery
									<cfinput name="ssResDeliv" type="checkbox" id="ssResDeliv" value="1" class="cfAdminDefault" />
									<br/>
								</td>
								<td>&nbsp;</td>
							</tr>
							<tr align="center">
								<td colspan="2">
									<cfinput name="rateSpecific" type="submit" id="rateSpecific" value="Get Rate" class="cfAdminDefault" />
								</td>
							</tr>
							</cfform>
						</table>
					</td>
					<td width="1" bgcolor="663399"></td>
					<td bgcolor="FFFFFF" align="center" valign="top">
						<br/><br/>
						<cfform name="form1" id="form1" method="post" action="indexFEDEX.cfm">
		  					<u>Type Tracking Number(s) below</u>:<br/>
							(One number per line)<br/>
							<textarea name="trackingNum" cols="25" rows="4" class="cfAdminDefault" ></textarea><br>
							<cfinput name="TrackRequest" type="submit" id="TrackRequest" value="Track" class="cfAdminDefault" />
						</cfform>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<br/>

<cfif IsDefined("trackingNum") AND IsDefined("TrackRequest")>
  
  	<cfscript>	
		tmpTrackNumberList = #Trim(trackingNum)#;
		tmpTrackNumberList = #ReReplace(tmpTrackNumberList, "[[:space:]]", ",", "all")#;
		tmpTrackNumberList = #ReReplace(tmpTrackNumberList, ",,", ",", "all")#;
		TrackNumberListLen = #ListLen(tmpTrackNumberList)#;
		vTrackNumberArray = ArrayNew(1);
		vTrackNumberArray = ListToArray(tmpTrackNumberList, ",");
		tmpArrayLen = ArrayLen(vTrackNumberArray);
	</cfscript>	
   
   
   	<cfif TrackNumberListLen eq 1>	
		<cf_TagFedex 
			function="trackByNumber"
			trackingnumber="#Trim(trackingNum)#"
			>
		<!--- <cfdump var="#stFedexTrackingResponse#"> --->
		<!--- Start display Tracking Results single tracking number --->
		<cfif IsDefined("FedexError") AND FedexError neq 0>
			Error Occurred 
			<cfif IsDefined("FedexErrorDesc")>
				<font color="#FF0000">: <cfoutput>#FedexErrorDesc#</cfoutput>
			</cfif>		
		<cfelse>
	   		<cfif ISDefined("scanQuery")>	
				<cfquery dbtype="query" name="scanQuerySortedDesc">
					SELECT * FROM scanQuery
					ORDER BY ScanDate DESC
				</cfquery>
	   		</cfif>
			<table width="80%" border="0" align="center" cellpadding="1" cellspacing="0" bgcolor="#666666">
	 			<tr>
					<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
		  					<tr bgcolor="#339933">
								<td height="20" colspan="2" class="cfAdminHeader2">Tracking Results</td>
							</tr>
		  					<tr>
								<td width="32%" height="18" align="right">Tracking Number: </td>
								<td width="68%"><cfoutput>#trackingNum#</cfoutput> 
									<!--- <cfif IsDefined("DeliveryDate")>
									<img src="SEARCH.GIF" width="11" height="11" /> 
									<a href="fedex-pod-example.cfm?trackingNumber=<cfoutput>#trackingNum#</cfoutput>&dateShipped=<cfoutput>#shipDate#</cfoutput>">View Proof of Delivery</a>
									</cfif> --->
								</td>
		  					</tr>
							<tr>
								<td height="18" align="right">Ship Date:</td>
								<td><cfoutput>#DateFormat(shipDate, "mm-dd-yyyy")#</cfoutput></td>
		  					</tr>
		  					<tr>
								<td height="18" align="right">Estimated Delivery Date:</td>
								<td><cfif IsDefined("ESTDeliveryDate")><cfoutput>#DateFormat(ESTDeliveryDate, "mm-dd-yyyy")#</cfoutput></cfif></td>
							</tr>
		  					<tr>
								<td height="18" align="right" nowrap="nowrap">Actual Delivery Date/Time:&nbsp;</td>
								<td><cfif IsDefined("DeliveryDate")><cfoutput>#DateFormat(DeliveryDate, "mm-dd-yyyy")#</cfoutput></cfif></td>
		  					</tr>
		  					<tr>
								<td height="18" align="right">Delivery City/State/Zip:&nbsp;</td>
								<td><cfif IsDefined("DESTCity")><cfoutput>#DESTCity#</cfoutput></cfif><cfif IsDefined("DESTState")>, <cfoutput>#DESTState#</cfoutput></cfif> <cfoutput>#DESTZip# (#DESTCountry#)</cfoutput></td>
		  					</tr>
		  					<tr>
								<td height="18" align="right">Service Level:&nbsp;</td>
								<td><cfif IsDefined("service")><cfoutput>#service#</cfoutput></cfif></td>
		  					</tr>
							<tr>
								<td height="18" align="right">Signed for by:&nbsp;</td>
								<td><cfif IsDefined("SignedBy")><cfoutput>#SignedBy#</cfoutput></cfif></td>
		  					</tr>
		  					<tr>
								<td height="18" align="right">Shipment Weight:&nbsp;</td>
								<td><cfif IsDefined("Weight")><cfoutput>#NumberFormat(Weight, "999")# #WeightUnits#</cfoutput></cfif><br/></td>
		  					</tr>
		  					<tr bgcolor="#336600">
								<td height="20" colspan="2" class="cfAdminHeader2">Package transit activity</td>
		  					</tr>
		  			<cfif IsDefined("scanQuerySortedDesc")>
		  				<cfoutput query="scanQuerySortedDesc">
		  					<tr>
								<td height="19" align="right" <cfif (scanQuerySortedDesc.CurrentRow MOD 2) gt 0>bgcolor="##EEEEEE"</cfif>>#DateFormat(ScanDate, "MM/DD/YYYY")# #TimeFormat(ScanTime, "HH:MM")#:&nbsp;</td>
								<td height="19" <cfif (scanQuerySortedDesc.CurrentRow MOD 2) gt 0>bgcolor="##EEEEEE"</cfif>>#ScanDesc# [ #ScanCity#, #ScanState# ] #ScanDeliveryInfo# <cfif Len(StatusDesc) neq 0> <em><font color="##006600">*#StatusDesc#</font></em></cfif></td>
		  					</tr>
		  				</cfoutput>
		  			<cfelseif IsDefined("scanSingleStruct")>
						<cfoutput>
							<tr>
								<td align="right">#DateFormat(scanSingleDate, "MM/DD/YYYY")# #scanSingleTime#:&nbsp;</td>
								<td>#scanSingleCity# [ #scanSingleDesc# ] #scanSingleDelivInfo#</td>
							</tr>
		  				</cfoutput>
					</cfif>
						</table>
					</td>
	  			</tr>
			</table>
		</cfif>
	<cfelse>
 	<!--- Start tracking results multiple numbers --->
		<table width="80%" border="0" align="center" cellpadding="1" cellspacing="0" bgcolor="#660099">
		  	<tr>
				<td>
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
			  			<tr>
							<td height="20" class="cfAdminHeader2">Tracking Number</td>
							<td class="cfAdminHeader2">Delivery Status</td>
							<td class="cfAdminHeader2">Destination</td>
							<td class="cfAdminHeader2">Date/Time</td>
						</tr>
					<cfloop from="1" to="#tmpArrayLen#" index="i">
						<cfset currTrackingNum = #vTrackNumberArray[i]#>
						<cf_TagFedex 
							function="trackByNumber"
							trackingnumber="#currTrackingNum#"
							>
						<!--- <cfdump var="#stFedexTrackingResponse#"> --->
			  			<tr>
							<td bgcolor="White">&nbsp;<a href="indexFEDEX.cfm?TrackRequest=1&TrackingNum=<cfoutput>#currTrackingNum#</cfoutput>"><cfoutput>#currTrackingNum#</cfoutput></a></td>
							<td bgcolor="White">&nbsp;
							<cfif IsDefined("DeliveryDate")>Delivered</cfif></td>
							<td bgcolor="White">&nbsp;
							<cfif IsDefined("DESTCity")><cfoutput>#DESTCity#</cfoutput></cfif><cfif IsDefined("DESTState")>, <cfoutput>#DESTState#</cfoutput></cfif> <cfoutput>#DESTZip# (#DESTCountry#)</cfoutput></td>
							<td bgcolor="White">&nbsp;
							<cfif IsDefined("DeliveryDate")><cfoutput>#DateFormat(DeliveryDate, "mm-dd-yyyy")#</cfoutput></cfif></td>
						</tr>			  
					</cfloop>
					</table>
				</td>
			</tr>
		</table>
  
	<!--- End Tracking results for multiple tracking numbers --->
	</cfif>
	<!--- <cfoutput><cfdump var="#stFedexTrackingResponse#"></cfoutput> --->
	<!--- End display Tracking Results single tracking number --->





<cfelseif IsDefined("originZip") AND IsDefined("destZip") AND IsDefined("rateRequest")>
 	<cfif ( (Len(destZip) gt 3 AND ListContains(zipRequiredList, destZip)) 
 			OR NOT ListContains(zipRequiredList, destZip)
			AND (Len(originZip) gt 3 AND ListContains(zipRequiredList, originZip)) 
 			OR NOT ListContains(zipRequiredList, originZip) )>
	
		<!--- <cfoutput><cfdump var="#stFedexRate#"></cfoutput> --->
		<table width="80%" border="0" align="center" cellpadding="1" cellspacing="0" bgcolor="#666666">
	  		<tr>
				<td>
					<table width="100%" border="0" cellspacing="0" cellpadding="4">
						<tr>
							<td width="41%" height="20" bgcolor="#CCCCCC"><b>Service Type</b></td>
							<td nowrap="nowrap" bgcolor="#CCCCCC"><b>Service Charge (USD)</b></td>
							<td bgcolor="#CCCCCC"><b>Sur Charges (USD)</b></td>
							<td nowrap="nowrap" bgcolor="#CCCCCC"><b>Total Charge (USD)</b></td>
		  				</tr>
						<cf_TagFedex 
							function="ServicesAvailRequest"
							fedexindentifier="#identifier#"
							accountnumber="#fedexAcNum#"
							raterequesttype="#ServiceType#"
							shipperzip="#originZip#"
							shipperstate="#originState#"
							shippercountry="#Trim(originCountry)#"
							shiptozip="#destZip#"
							shiptostate="#destinationState#"
							shiptocountry="GB"
							packageweight="#NumberFormat(weight, 999.9)#"
							packaging="#packageType#"
							packagecount="1"
							requestlistrates="1"
							debug="False"
							>
				<cfif IsDefined("qAvailServices")>
					<cfoutput query="qAvailServices">
						<cfquery dbtype="query" name="qServiceDesc">
							SELECT * FROM qServiceLevelFdx 
							WHERE (ServiceLevelCode = '#Service#')
						</cfquery>
						<tr>
							<td height="18" bgcolor="White">&nbsp; #qServiceDesc.ServiceLevelDesc#</td>
							<td nowrap="nowrap" bgcolor="White">&nbsp;
								<cfif Len(ListBaseFreightCharges) neq 0>#DollarFormat(ListBaseFreightCharges)#<cfelse>#DollarFormat(DiscBaseFreightCharges)#</cfif> <cfif Len(CurrencyCode) neq 0>(#CurrencyCode#)</cfif>
							</td>
							<td nowrap="nowrap" bgcolor="White">&nbsp;
								<cfif Len(ListSurchargeTotal) neq 0>#DollarFormat(ListSurchargeTotal)#<cfelse>#DollarFormat(DiscSurchargeTotal)#</cfif>
							</td>
							<td nowrap="nowrap" bgcolor="White">
								<cfif Len(ListNetTotalCharge) gt 0>#DollarFormat(ListNetTotalCharge)#<cfelse>#DollarFormat(DiscBaseTotalCharges)#</cfif>
							</td>
						</tr>
					</cfoutput>
				<cfelse>
			  	<!--- Check if weight is over 150 lbs and domestic then it is fedex freight --->
					<cfif ( (weight gt 150) AND (originCountry eq "US" AND destCountry eq "US") )>
						<cfset serviceList = "FEDEX1DAYFREIGHT,FEDEX2DAYFREIGHT,FEDEX3DAYFREIGHT">
						<cfset vServiceArray = ListToArray(serviceList)>
						<cfset vServiceArrayLen = ArrayLen(vServiceArray)>
					
						<cfloop from="1" to="#vServiceArrayLen#" index="i">
							<cf_TagFedex 
								function="RateRequest"
								fedexindentifier="#identifier#"
								accountnumber="#fedexAcNum#"
								servicelevel="#vServiceArray[i]#"
								shipperzip="#originZip#"
								shipperstate="#originState#"
								shippercountry="#Trim(originCountry)#"
								shiptozip="#destZip#"
								shiptostate="#destinationState#"
								shiptocountry="#Trim(destCountry)#"
								packageweight="#NumberFormat(weight, 999.9)#"
								packagelength="10"
								packagewidth="10"
								packageheight="10"
								packaging="#packageType#"
								debug="False"
								>
							<!--- <cfoutput><cfdump var="#stFedexRate#"></cfoutput> --->
				   			<cfif IsDefined("qFedexRateQuery")>
								<cfquery dbtype="query" name="qServiceDesc">
									SELECT * FROM qServiceLevelFdx 
									WHERE (ServiceLevelCode = '#vServiceArray[i]#')
								</cfquery>
				   				<cfoutput>
				   				<tr>
									<td height="18" bgcolor="White">&nbsp; #qServiceDesc.ServiceLevelDesc#</td>
									<td nowrap="nowrap" bgcolor="White">&nbsp; #DollarFormat(qFedexRateQuery.DiscBaseFreightCharges)#</td>
									<td nowrap="nowrap" bgcolor="White">&nbsp; #DollarFormat(qFedexRateQuery.DiscSurchargeTotal)#</td>
									<td nowrap="nowrap" bgcolor="White">#DollarFormat(qFedexRateQuery.DiscBaseTotalCharges)#</td>
				   				</tr>
				   				</cfoutput>
							</cfif>					
				  		</cfloop>
				
				 	<!--- Check if weight is over 150 lbs and international then it is fedex freight --->
					<cfelseif ( (weight gt 150) AND (originCountry neq "US" OR destCountry neq "US") )>
						<cfset serviceList = "INTERNATIONALPRIORITYFREIGHT,INTERNATIONALECONOMYFREIGHT">
						<cfset vServiceArray = ListToArray(serviceList)>
						<cfset vServiceArrayLen = ArrayLen(vServiceArray)>
					
						<cfloop from="1" to="#vServiceArrayLen#" index="i">
							<cf_TagFedex 
								function="RateRequest"
								fedexindentifier="#identifier#"
								accountnumber="#fedexAcNum#"
								servicelevel="#vServiceArray[i]#"
								shipperzip="#originZip#"
								shipperstate="#originState#"
								shippercountry="#Trim(originCountry)#"
								shiptozip="#destZip#"
								shiptostate="#destinationState#"
								shiptocountry="#Trim(destCountry)#"
								packageweight="#NumberFormat(weight, 999.9)#"
								packagelength="10"
								packagewidth="10"
								packageheight="10"
								packaging="#packageType#"
								debug="False"
								>
							
							<!--- <cfoutput><cfdump var="#stFedexRate#"></cfoutput> --->
						
							<cfif IsDefined("qFedexRateQuery")>
								<cfquery dbtype="query" name="qServiceDesc">
									SELECT * FROM qServiceLevelFdx 
									WHERE (ServiceLevelCode = '#vServiceArray[i]#')
								</cfquery>
								<cfoutput>
								<tr>
									<td height="18" bgcolor="White">&nbsp; #qServiceDesc.ServiceLevelDesc#</td>
									<td nowrap="nowrap" bgcolor="White">&nbsp; #DollarFormat(qFedexRateQuery.DiscBaseFreightCharges)#</td>
									<td nowrap="nowrap" bgcolor="White">&nbsp; #DollarFormat(qFedexRateQuery.DiscSurchargeTotal)#</td>
									<td nowrap="nowrap" bgcolor="White">#DollarFormat(qFedexRateQuery.DiscBaseTotalCharges)#</td>
							   </tr>
							   </cfoutput>
							</cfif>					
						</cfloop>
					<cfelse>
					</cfif>
				</cfif>
						<tr>
							<td colspan="4" bgcolor="#CCCCCC"></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>

	<cfelse>
		Country requires a zipcode
	</cfif>
	
<cfelseif IsDefined("originZip") AND IsDefined("destZip") AND IsDefined("rateSpecific")>
 	<cfif ( (Len(destZip) gt 3 AND ListContains(zipRequiredList, destZip)) 
 			OR NOT ListContains(zipRequiredList, destZip)
			AND (Len(originZip) gt 3 AND ListContains(zipRequiredList, originZip)) 
 			OR NOT ListContains(zipRequiredList, originZip) )>
		<cfscript>
			if ( IsDefined("ssSatDeliv") ) {
				ssSatDeliv = 1;
			}
			else {
				ssSatDeliv = 0;
			}
			if ( IsDefined("ssResDeliv") ) {
				ssResDeliv = 1;
			}
			else {
				ssResDeliv = 0;
			}
		</cfscript>
		<!--- <cfoutput><cfdump var="#stFedexRate#"></cfoutput> --->
	
		<table width="80%" border="0" align="center" cellpadding="1" cellspacing="0" bgcolor="#666666">
	 		<tr>
				<td>
					<table width="100%" border="0" cellspacing="0" cellpadding="4">
		  				<tr>
							<td width="41%" height="20" bgcolor="#CCCCCC">Service Type</td>
							<td nowrap="nowrap" bgcolor="#CCCCCC">Service Charge (USD)</td>
							<td bgcolor="#CCCCCC">Sur Charges (USD)</td>
							<td nowrap="nowrap" bgcolor="#CCCCCC">Total Charge (USD)</td>
		 				</tr>
						<cf_TagFedex 
							function="rateRequest"
							fedexindentifier="#identifier#"
							accountnumber="#fedexAcNum#"
							servicelevel="#Service#"
							raterequesttype="FDXG"
							shipperzip="#originZip#"
							shipperstate="#originState#"
							shippercountry="#Trim(originCountry)#"
							shiptozip="#destZip#"
							shiptostate="#destinationState#"
							shiptocountry="#Trim(destCountry)#"
							packageweight="#NumberFormat(weight, 999.9)#"
							packagelength="10"
							packagewidth="10"
							packageheight="10"
							packaging="#packageType#"
							requestlistrates="1"
							sssatdelivery="#ssSatDeliv#"
							ssresdelivery="#ssResDeliv#"
							debug="False"
							>	
	
						<!--- <cfoutput><cfdump var="#stFedexRate#"></cfoutput> --->
						<cfif IsDefined("qFedexRateQuery")>
							<cfquery dbtype="query" name="qServiceDesc">
								SELECT * FROM qServiceLevelFdx 
								WHERE (ServiceLevelCode = '#Service#')
							</cfquery>
							<cfoutput query="qFedexRateQuery">
				   			<tr>
								<td height="18" bgcolor="White">&nbsp; #qServiceDesc.ServiceLevelDesc#</td>
								<td nowrap="nowrap" bgcolor="White">&nbsp;
					 				<cfif Len(ListBaseFreightCharges) neq 0>#DollarFormat(ListBaseFreightCharges)#<cfelse>#DollarFormat(DiscBaseFreightCharges)#</cfif> <cfif Len(CurrencyCode) neq 0>(#CurrencyCode#)</cfif>
								</td>
								<td nowrap="nowrap" bgcolor="White">&nbsp;
					 				<cfif Len(ListSurchargeTotal) neq 0>#DollarFormat(ListSurchargeTotal)#<cfelse>#DollarFormat(DiscSurchargeTotal)#</cfif>
								</td>
								<td nowrap="nowrap" bgcolor="White">
									<cfif Len(ListNetTotalCharge) gt 0>#DollarFormat(ListNetTotalCharge)#<cfelse>#DollarFormat(DiscBaseTotalCharges)#</cfif>
								</td>
							</tr>
							</cfoutput>
						</cfif>
				   </table>
				</td>
			</tr>
		</table>
	<cfelse>
  		Country requires a zipcode
  	</cfif>
  
<cfelse>
</cfif>


<cfinclude template="LayoutShipFooter.cfm">
