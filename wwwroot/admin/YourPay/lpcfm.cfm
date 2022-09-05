<!---
	--------------------------------------------------------------------------------

	 Copyright 2003 LinkPoint International, Inc. All Rights Reserved.

	 This software is the proprietary information of LinkPoint International, Inc.
	 Use is subject to license terms.


	### YOU REALLY DO NOT NEED TO EDIT THIS FILE! ###


	lpcfm.cfm - LinkPoint API ColdFusion module
	REVISION =  lpcfm.cfm, v 3.0 12/30/03 08:22:13 cgebert
	VERSION  =  3.0.020
	---------------------------------------------------------------------------------
--->

		<!--- THERE IS NO NEED TO EDIT THIS FILE. DOING SO WOULD BE BAD --->

<!--- INCLUDE STORE SPECIFIC SETTINGS FILE --->
<CFINCLUDE TEMPLATE = "application.inc">

<!--- BUILD XML STRING --->

<!--- ORDER OPTIONS NODE --->
<CFSET outXML = "<order><orderoptions>">

	<CFIF isDefined('ordertype')>
		<CFSET outXML = "#outXML#<ordertype>#ordertype#</ordertype>">
	</CFIF>

	<CFIF isDefined('result')>
		<CFSET outXML = "#outXML#<result>#result#</result>">
	</CFIF>

<CFSET outXML = "#outXML#</orderoptions>">

<!--- CREDIT CARD NODE --->


<CFSET outXML = "#outXML#<creditcard>">

	<CFIF isDefined('cardnumber')>
		<CFSET outXML = "#outXML#<cardnumber>#cardnumber#</cardnumber>">
	</CFIF>

	<CFIF isDefined('cardexpmonth')>
		<CFSET outXML = "#outXML#<cardexpmonth>#cardexpmonth#</cardexpmonth>">
	</CFIF>

	<CFIF isDefined('cardexpyear')>
		<CFSET outXML = "#outXML#<cardexpyear>#cardexpyear#</cardexpyear>">
	</CFIF>

	<CFIF isDefined('cvmvalue')>
		<CFSET outXML = "#outXML#<cvmvalue>#cvmvalue#</cvmvalue>">
	</CFIF>
	
	<CFIF isDefined('cvmindicator')>
		<CFSET outXML = "#outXML#<cvmindicator>#cvmindicator#</cvmindicator>">
	</CFIF>

	<CFIF isDefined('track')>
		<CFSET outXML = "#outXML#<track>#track#</track>">
	</CFIF>

<CFSET outXML = "#outXML#</creditcard>">

<!--- BILLING NODE --->

<CFSET outXML = "#outXML#<billing>">

	<CFIF isDefined('name')>
		<CFSET outXML = "#outxml#<name>#name#</name>">
	</CFIF>
	
	<CFIF isDefined('company')>
		<CFSET outXML = "#outxml#<company>#company#</company>">
	</CFIF>

	<CFIF isDefined('address')>
		<CFSET outXML = "#outxml#<address1>#address#</address1>">
	
	<CFELSEIF isDefined('address1')>
		<CFSET outXML = "#outxml#<address1>#address1#</address1>">
	</CFIF>

	<CFIF isDefined('address2')>
		<CFSET outXML = "#outxml#<address2>#address2#</address2>">
	</CFIF>

	<CFIF isDefined('city')>
		<CFSET outXML = "#outxml#<city>#city#</city>">
	</CFIF>

	<CFIF isDefined('state')>
		<CFSET outXML = "#outxml#<state>#state#</state>">
	</CFIF>

	<CFIF isDefined('zip')>
		<CFSET outXML = "#outxml#<zip>#zip#</zip>">
	</CFIF>

	<CFIF isDefined('country')>
		<CFSET outXML = "#outxml#<country>#country#</country>">
	</CFIF>

	<CFIF isDefined('userid')>
		<CFSET outXML = "#outxml#<userid>#userid#</userid>">
	</CFIF>

	<CFIF isDefined('email')>
		<CFSET outXML = "#outxml#<email>#email#</email>">
	</CFIF>

	<CFIF isDefined('phone')>
		<CFSET outXML = "#outxml#<phone>#phone#</phone>">
	</CFIF>

	<CFIF isDefined('fax')>
		<CFSET outXML = "#outxml#<fax>#fax#</fax>">
	</CFIF>

	<CFIF isDefined('addrnum')>
		<CFSET outXML = "#outxml#<addrnum>#addrnum#</addrnum>">
	</CFIF>

<CFSET outXML = "#outXML#</billing>">

<!--- SHIPPING NODE --->

<CFSET outXML = "#outXML#<shipping>">

	<CFIF isDefined('sname')>
		<CFSET outXML = "#outxml#<name>#sname#</name>">
	</CFIF>
	
	<CFIF isDefined('saddress')>
		<CFSET outXML = "#outxml#<address1>#saddress#</address1>">
	
	<CFELSEIF isDefined('saddress1')>
		<CFSET outXML = "#outxml#<address1>#saddress1#</address1>">
	</CFIF>

	<CFIF isDefined('saddress2')>
		<CFSET outXML = "#outxml#<address2>#saddress2#</address2>">
	</CFIF>

	<CFIF isDefined('scity')>
		<CFSET outXML = "#outxml#<city>#scity#</city>">
	</CFIF>

	<CFIF isDefined('sstate')>
		<CFSET outXML = "#outxml#<state>#sstate#</state>">
	<CFELSEIF isDefined('state')>
		<CFSET outXML = "#outXML#<state>#state#</state>">
	</CFIF>

	<CFIF isDefined('szip')>
		<CFSET outXML = "#outxml#<zip>#szip#</zip>">
	</CFIF>

	<CFIF isDefined('scountry')>
		<CFSET outXML = "#outxml#<country>#scountry#</country>">
	</CFIF>

	<CFIF isDefined('scarrier')>
		<CFSET outXML = "#outxml#<carrier>#scarrier#</carrier>">
	</CFIF>

	<CFIF isDefined('sitems')>
		<CFSET outXML = "#outxml#<items>#sitems#</items>">
	</CFIF>

	<CFIF isDefined('sweight')>
		<CFSET outXML = "#outxml#<weight>#sweight#</weight>">
	</CFIF>

	<CFIF isDefined('stotal')>
		<CFSET outXML = "#outxml#<total>#stotal#</total>">
	</CFIF>

<CFSET outXML = "#outXML#</shipping>">

<!--- TRANSACTION NODE --->

<CFSET outXML = "#outXML#<transactiondetails>">

	<CFIF isDefined('oid')>
		<CFSET outXML = "#outXML#<oid>#oid#</oid>">
	</CFIF>

	<CFIF isDefined('ponumber')>
		<CFSET outXML = "#outXML#<ponumber>#ponumber#</ponumber>">
	</CFIF>

	<CFIF isDefined('recurring')>
		<CFSET outXML = "#outXML#<recurring>#recurring#</recurring>">
	</CFIF>

	<CFIF isDefined('taxexempt')>
		<CFSET outXML = "#outXML#<taxexempt>#taxexempt#</taxexempt>">
	</CFIF>

	<CFIF isDefined('terminaltype')>
		<CFSET outXML = "#outXML#<terminaltype>#terminaltype#</terminaltype>">
	</CFIF>

	<CFIF isDefined('ip')>
		<CFSET outXML = "#outXML#<ip>#ip#</ip>">
	</CFIF>

	<CFIF isDefined('reference_number')>
		<CFSET outXML = "#outXML#<reference_number>#reference_number#</reference_number>">
	</CFIF>

	<CFIF isDefined('transactionorigin')>
		<CFSET outXML = "#outXML#<transactionorigin>#transactionorigin#</transactionorigin>">
	</CFIF>

	<CFIF isDefined('tdate')>
		<CFSET outXML = "#outXML#<tdate>#tdate#</tdate>">
	</CFIF>

<CFSET outXML = "#outXML#</transactiondetails>">

<!--- MERCHANT INFO NODE --->

<CFSET outXML = "#outXML#<merchantinfo>">

	<CFIF isDefined('configfile')>
		<CFSET outXML = "#outXML#<configfile>#configfile#</configfile>">
	</CFIF>

	<CFIF isDefined('keyfile')>
		<CFSET outXML = "#outXML#<keyfile>#keyfile#</keyfile>">
	</CFIF>

	<CFIF isDefined('host')>
		<CFSET outXML = "#outXML#<host>#host#</host>">
	</CFIF>

	<CFIF isDefined('port')>
		<CFSET outXML = "#outXML#<port>#port#</port>">
	</CFIF>

	<CFIF isDefined('appname')>
		<CFSET outXML = "#outXML#<appname>#appname#</appname>">
	</CFIF>

<CFSET outXML = "#outXML#</merchantinfo>">

<!--- PAYMENT NODE --->

<CFSET outXML = "#outXML#<payment>">

	<CFIF isDefined('chargetotal')>
		<CFSET outXML = "#outXML#<chargetotal>#chargetotal#</chargetotal>">
	</CFIF>

	<CFIF isDefined('tax')>
		<CFSET outXML = "#outXML#<tax>#tax#</tax>">
	</CFIF>

	<CFIF isDefined('vattax')>
		<CFSET outXML = "#outXML#<vattax>#vattax#</vattax>">
	</CFIF>

	<CFIF isDefined('shipping')>
		<CFSET outXML = "#outXML#<shipping>#shipping#</shipping>">
	</CFIF>

	<CFIF isDefined('subtotal')>
		<CFSET outXML = "#outXML#<subtotal>#subtotal#</subtotal>">
	</CFIF>

<CFSET outXML = "#outXML#</payment>">

<!--- CHECK NODE --->

	<CFIF isDefined('voidcheck')>
		<CFSET outXML = "#outXML#<telecheck><void>1</void></telecheck>">
	<CFELSEIF isDefined('routing')>
		<CFSET outXML = "#outXML#<telecheck>">
		<CFSET outXML = "#outXML#<routing>#routing#</routing>">


	<CFIF isDefined('account')>
		<CFSET outXML = "#outXML#<account>#account#</account>">
	</CFIF>

	<CFIF isDefined('bankname')>
		<CFSET outXML = "#outXML#<bankname>#bankname#</bankname>">
	</CFIF>
	
	<CFIF isDefined('bankstate')>
		<CFSET outXML = "#outXML#<bankstate>#bankstate#</bankstate>">
	</CFIF>

	<CFIF isDefined('ssn')>
		<CFSET outXML = "#outXML#<ssn>#ssn#</ssn>">
	</CFIF>

	<CFIF isDefined('dl')>
		<CFSET outXML = "#outXML#<dl>#dl#</dl>">
	</CFIF>

	<CFIF isDefined('dlstate')>
		<CFSET outXML = "#outXML#<dlstate>#dlstate#</dlstate>">
	</CFIF>

	<CFIF isDefined('checknumber')>
		<CFSET outXML = "#outXML#<checknumber>#checknumber#</checknumber>">
	</CFIF>

	<CFIF isDefined('accounttype')>
		<CFSET outXML = "#outXML#<accounttype>#accounttype#</accounttype>">
	</CFIF>

<CFSET outXML = "#outXML#</telecheck>">

</CFIF>

<!--- PERIODIC NODE --->

	<CFIF isDefined('startdate')>
		<CFSET outXML = "#outXML#<periodic>">	
	
		<CFSET outXML = "#outXML#<startdate>#startdate#</startdate>">
	
			
	<CFIF isDefined('installments')>
		<CFSET outXML = "#outXML#<installments>#installments#</installments>">
	</CFIF>
	
	<CFIF isDefined('threshold')>
		<CFSET outXML = "#outXML#<threshold>#threshold#</threshold>">
	</CFIF>

	<CFIF isDefined('periodicity')>
		<CFSET outXML = "#outXML#<periodicity>#periodicity#</periodicity>">
	</CFIF>
		
	<CFIF isDefined('pbcomments')>
		<CFSET outXML = "#outXML#<pbcomments>#pbcomments#</pbcomments>">
	</CFIF>
	
	<CFIF isDefined('action')>
		<CFSET outXML = "#outXML#<action>#action#</action>">
	</CFIF>

<CFSET outXML = "#outXML#</periodic>">

</CFIF>

<!--- NOTES NODE --->

<CFIF isDefined('comments') OR isDefined('referred')>

<CFSET outXML = "#outXML#<notes>">

	<CFIF isDefined('comments')>
		<CFSET outXML = "#outXML#<comments>#comments#</comments>">
	</CFIF>
	
	<CFIF isDefined('referred')>
		<CFSET outXML = "#outXML#<referred>#referred#</referred>">
	</CFIF>

<CFSET outXML = "#outXML#</notes>">
</CFIF>

<!--- ITEMS AND OPTIONS NODE --->

<CFSET outXML = "#outXML#<items>">

	<CFIF isDefined('item_id')>

<CFLOOP FROM = "1" TO = "#arrayLen(items)#" Index = "Idx">
		<CFSET outXML = "#outXML#<item>">
		<CFSET outXML = "#outXML#<id>#items[Idx][1]#</id>">

	<CFIF isDefined('item_description')>
		<CFSET outXML = "#outXML#<description>#items[Idx][2]#</description>">
	</CFIF>

	<CFIF isDefined('item_quantity')>
		<CFSET outXML = "#outXML#<quantity>#items[Idx][3]#</quantity>">
	</CFIF>

	<CFIF isDefined('item_price')>
		<CFSET outXML = "#outXML#<price>#items[Idx][4]#</price>">
	</CFIF>

	<CFIF isDefined('item_serial')>
		<CFSET outXML = "#outXML#<serial>#items[Idx][5]#</serial>">
	</CFIF>

		<CFSET outXML = "#outXML#</item>">
	
</CFLOOP>

</CFIF>

<CFSET outXML = "#outXML#</items>">

<CFSET outXML = "#outXML#</order>">
<!--- DONE BUILDING XML STRING --->
<!--- SET THE API VERSION --->
	<!--- DO NOT EDIT IF YOU NEED ACCURATE SUPPORT ON THIS PRODUCT --->
		<CFSET APIVERSION = "CF - v3.0.020 12/2003">
<!--- PROCESS THE ORDER AND SET THE ORDER RESULTS --->
<CFINCLUDE TEMPLATE = "status.cfm">

<!--- USED TO SEE THE OUTGOING XML STRING FOR DEBUGGING 
<CFOUTPUT>
#htmleditformat(outXML)#
</CFOUTPUT>
--->