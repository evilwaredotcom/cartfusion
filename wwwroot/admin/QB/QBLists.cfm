<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
	<title>QODBC ColdFusion DCOM Access Test Page</title>
</head>
<body topmargin="3" leftmargin="3" marginheight="0" marginwidth="0" bgcolor="#ffffff" link="#000066" vlink="#000000" alink="#0000ff" text="#000000">

<table border="0" bgcolor="lightgreen" bordercolor="black" cellpadding="0" cellspacing="0">
	<tr>
		<td>
			<table border="2" bordercolor="black" bgcolor="white" cellpadding="5" cellspacing="0">
				<caption align="top">QODBC ColdFusion DCOM Access Test Page</caption>
				<thead>
					<tr>
						<th>QB2002</th>
						<th>QB2003</th>
						<th>QB2004</th>
						<th>QB2005</th>
						<th>DCOM</th>
						<th>COM</th>
						<th>Object Name</th>
						<th>Status</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td align="center">�</td>
						<td align="center">�</td>
						<td align="center">�</td>
						<td align="center">�</td>
						<td align="center">�</td>
						<td align="center">�</td>
						<td>QBXMLRPEQODBCInteractive.exe</td>
<cftry>
	<cfobject type="COM" action="create" name="oInteractive" Class="QBXMLRPEQODBCInteractive.RequestProcessor">
	<cfoutput>
						<td align="center">Success</td>
	</cfoutput>
	<cfcatch>
		<cfoutput>
						<td align="center">Failed</td>
		</cfoutput>
	</cfcatch>
</cftry>
					</tr>

					<tr>
						<td align="center">�</td>
						<td align="center">�</td>
						<td align="center">�</td>
						<td align="center">�</td>
						<td align="center">�</td>
						<td align="center">�</td>
						<td>QBXMLRP.dll</td>
<cftry>
	<cfobject type="COM" action="create" name="oQBXMLRP" Class="QBXMLRP.RequestProcessor">
	<cfoutput>
						<td align="center">Success</td>
	</cfoutput>
	<cfcatch>
		<cfoutput>
						<td align="center">Failed</td>
		</cfoutput>
	</cfcatch>
</cftry>
					</tr>

					<tr>
						<td align="center">�</td>
						<td align="center">�</td>
						<td align="center">�</td>
						<td align="center">�</td>
						<td align="center">�</td>
						<td align="center">�</td>
						<td>QBXMLRP2EQODBCInteractive.exe</td>
<cftry>
	<cfobject type="COM" action="create" name="oInteractive" Class="QBXMLRP2EQODBCInteractive.RequestProcessor">
	<cfoutput>
						<td align="center">Success</td>
	</cfoutput>
	<cfcatch>
		<cfoutput>
						<td align="center">Failed</td>
		</cfoutput>
	</cfcatch>
</cftry>
					</tr>

					<tr>
						<td align="center">�</td>
						<td align="center">�</td>
						<td align="center">�</td>
						<td align="center">�</td>
						<td align="center">�</td>
						<td align="center">�</td>
						<td>QBXMLRP2.dll</td>
<cftry>
	<cfobject type="COM" action="create" name="oQBXMLRP" Class="QBXMLRP2.RequestProcessor">
	<cfoutput>
						<td align="center">Success</td>
	</cfoutput>
	<cfcatch>
		<cfoutput>
						<td align="center">Failed</td>
		</cfoutput>
	</cfcatch>
</cftry>
					</tr>

					<tr>
						<td align="center">�</td>
						<td align="center">�</td>
						<td align="center">�</td>
						<td align="center">�</td>
						<td align="center">�</td>
						<td align="center">�</td>
						<td>XERCES-COM.dll</td>
<cftry>
	<cfobject type="COM" action="create" name="oXERCES" Class="Xerces.DOMDocument">
	<cfoutput>
						<td align="center">Success</td>
	</cfoutput>
	<cfcatch>
		<cfoutput>
						<td align="center">Failed</td>
		</cfoutput>
	</cfcatch>
</cftry>
					</tr>
				</tbody>
			</table>
		</td>
	</tr>
</table>

<table border="0" bgcolor="lightgreen" bordercolor="black" cellpadding="0" cellspacing="0">
	<cfquery name="CustomerList" datasource="QBs">
		SELECT 	TOP 50 ListID, FullName, CompanyName 
		FROM 	Customer
	</cfquery>
	<tr><td><cfdump var="#CustomerList#"></td></tr>
</table>
</body>
</html>
<cfabort>

<!---
<cfquery name="CustomerAll" datasource="#QBDSN#">
	SELECT 	ACCOUNTNUMBER, BALANCE,
			CONTACT, FULLNAME, FIRSTNAME, LASTNAME, COMPANYNAME, MIDDLENAME, NAME, EMAIL, PHONE, FAX, ALTCONTACT, ALTPHONE, 
			BILLADDRESSADDR1, BILLADDRESSADDR2, BILLADDRESSADDR3, BILLADDRESSADDR4, BILLADDRESSCITY, 
			BILLADDRESSCOUNTRY, BILLADDRESSPOSTALCODE, BILLADDRESSSTATE, 			
			CREDITCARDINFOCREDITCARDADDRESS, CREDITCARDINFOCREDITCARDNUMBER, CREDITCARDINFOCREDITCARDPOSTALCODE, CREDITCARDINFOEXPIRATIONMONTH, 
			CREDITCARDINFOEXPIRATIONYEAR, CREDITCARDINFONAMEONCARD, CREDITLIMIT, 
			CUSTOMERTYPEREFFULLNAME, CUSTOMERTYPEREFLISTID, CUSTOMFIELDASI, CUSTOMFIELDFREESAMPLEYN, CUSTOMFIELDOTHER, CUSTOMFIELDPPAI, 
			CUSTOMFIELDVENDORIDCODE, EDITSEQUENCE, ISACTIVE, ITEMSALESTAXREFFULLNAME, ITEMSALESTAXREFLISTID, 
			JOBDESC, JOBENDDATE, JOBPROJECTEDENDDATE, JOBSTARTDATE, JOBSTATUS, JOBTYPEREFFULLNAME, JOBTYPEREFLISTID, 
			LISTID, NOTES, OPENBALANCE, OPENBALANCEDATE, PARENTREFFULLNAME, PARENTREFLISTID,  
			PREFERREDPAYMENTMETHODREFFULLNAME, PREFERREDPAYMENTMETHODREFLISTID, PRICELEVELREFFULLNAME, PRICELEVELREFLISTID, RESALENUMBER, 
			SALESREPREFFULLNAME, SALESREPREFLISTID, SALESTAXCODEREFFULLNAME, SALESTAXCODEREFLISTID, SALUTATION, 
			SHIPADDRESSADDR1, SHIPADDRESSADDR2, SHIPADDRESSADDR3, SHIPADDRESSADDR4, SHIPADDRESSCITY, 
			SHIPADDRESSCOUNTRY, SHIPADDRESSPOSTALCODE, SHIPADDRESSSTATE, 
			SUBLEVEL, TERMSREFFULLNAME, TERMSREFLISTID, TIMECREATED, TIMEMODIFIED, TOTALBALANCE
	FROM 	Customer
</cfquery>

<cfdump var="#CustomerAll#">--->

<!---
<cfquery name="CustomerList" datasource="#QBDSN#">
	SELECT 	CONTACT, FULLNAME, FIRSTNAME, LASTNAME, COMPANYNAME, MIDDLENAME, NAME, EMAIL, PHONE, FAX, ALTCONTACT, ALTPHONE, 
			BILLADDRESSADDR1, BILLADDRESSADDR2, BILLADDRESSADDR3, BILLADDRESSADDR4, BILLADDRESSCITY, 
			BILLADDRESSSTATE, BILLADDRESSPOSTALCODE, BILLADDRESSCOUNTRY, ISACTIVE
	FROM 	Customer
</cfquery>

<cfdump var="#CustomerList#" expand="no">--->

<!---
<cfquery name="VendorAll" datasource="#QBDSN#">
	SELECT 	ACCOUNTNUMBER, ALTCONTACT, ALTPHONE, BALANCE, COMPANYNAME, CONTACT, CREDITLIMIT, 
			CUSTOMFIELDOTHER, CUSTOMFIELDVENDORIDCODE, EDITSEQUENCE, EMAIL, FAX, FIRSTNAME, ISACTIVE, ISVENDORELIGIBLEFOR1099, 
			LASTNAME, LISTID, MIDDLENAME, NAME, NAMEONCHECK, NOTES, OPENBALANCE, OPENBALANCEDATE, PHONE, SALUTATION, 
			TERMSREFFULLNAME, TERMSREFLISTID, TIMECREATED, TIMEMODIFIED, 
			VENDORADDRESSADDR1, VENDORADDRESSADDR2, VENDORADDRESSADDR3, VENDORADDRESSADDR4, VENDORADDRESSCITY, 
			VENDORADDRESSCOUNTRY, VENDORADDRESSPOSTALCODE, VENDORADDRESSSTATE, 
			VENDORTAXIDENT, VENDORTYPEREFFULLNAME, VENDORTYPEREFLISTID 
	FROM 	Vendor
</cfquery>

<cfdump var="#VendorAll#" expand="no">--->

<!---
<cfquery name="VendorList" datasource="#QBDSN#">
	SELECT 	CONTACT, FIRSTNAME, LASTNAME, COMPANYNAME, MIDDLENAME, NAME, EMAIL, PHONE, FAX, ALTCONTACT, ALTPHONE, 
			VENDORADDRESSADDR1, VENDORADDRESSADDR2, VENDORADDRESSADDR3, VENDORADDRESSADDR4, VENDORADDRESSCITY, 
			VENDORADDRESSSTATE, VENDORADDRESSPOSTALCODE, VENDORADDRESSCOUNTRY, ISACTIVE
	FROM 	Vendor
</cfquery>

<cfdump var="#VendorList#" expand="no">--->

<!------>
<cfquery name="ItemsAll" datasource="#QBDSN#">
	SELECT 	Top 3
			ASSETACCOUNTREFFULLNAME, ASSETACCOUNTREFLISTID, COGSACCOUNTREFFULLNAME, COGSACCOUNTREFLISTID, 
			CUSTOMFIELDDIVISION, CUSTOMFIELDINTERNETDESCRIPTION, CUSTOMFIELDRETAILPRICE, CUSTOMFIELDVOLUMEPTS, CUSTOMFIELDWEIGHTLBS, 
			DEPOSITTOACCOUNTREFFULLNAME, DEPOSITTOACCOUNTREFLISTID, DESCRIPTION, EDITSEQUENCE, FULLNAME, 
			INCOMEACCOUNTREFFULLNAME, INCOMEACCOUNTREFLISTID, INVENTORYDATE, ISACTIVE, LISTID, NAME, PARENTREFFULLNAME, PARENTREFLISTID, 
			PAYMENTMETHODREFFULLNAME, PAYMENTMETHODREFLISTID, PREFVENDORREFFULLNAME, PREFVENDORREFLISTID, PURCHASECOST, PURCHASEDESC, REORDERBUILDPOINT, 
			SALESANDPURCHASEEXPENSEACCOUNTREFFULLNAME, SALESANDPURCHASEEXPENSEACCOUNTREFLISTID, SALESANDPURCHASEINCOMEACCOUNTREFFULLNAME, 
			SALESANDPURCHASEINCOMEACCOUNTREFLISTID, SALESANDPURCHASEPREFVENDORREFFULLNAME, SALESANDPURCHASEPREFVENDORREFLISTID, 
			SALESANDPURCHASEPURCHASECOST, SALESANDPURCHASEPURCHASEDESC, SALESANDPURCHASESALESDESC, SALESANDPURCHASESALESPRICE, 
			SALESDESC, SALESORPURCHASEACCOUNTREFFULLNAME, SALESORPURCHASEACCOUNTREFLISTID, SALESORPURCHASEDESC, SALESORPURCHASEPRICE, 
			SALESORPURCHASEPRICEPERCENT, SALESPRICE, SALESTAXCODEREFFULLNAME, SALESTAXCODEREFLISTID, SUBLEVEL, 
			TAXRATE, TAXVENDORREFFULLNAME, TAXVENDORREFLISTID, TIMECREATED, TIMEMODIFIED, TYPE
	FROM 	Item
</cfquery>

<cfdump var="#ItemsAll#" expand="no">

<!--- 
<cfquery name="ItemsList" datasource="#QBDSN#">
	SELECT 	TOP 10 
			NAME, FULLNAME, PARENTREFFULLNAME, ASSETACCOUNTREFFULLNAME, COGSACCOUNTREFFULLNAME,
			CUSTOMFIELDDIVISION, CUSTOMFIELDINTERNETDESCRIPTION, CUSTOMFIELDRETAILPRICE, CUSTOMFIELDVOLUMEPTS, CUSTOMFIELDWEIGHTLBS, 
			DESCRIPTION, EDITSEQUENCE, 
			INCOMEACCOUNTREFFULLNAME, INCOMEACCOUNTREFLISTID, INVENTORYDATE, ISACTIVE, LISTID, 
			PREFVENDORREFFULLNAME, PURCHASECOST, PURCHASEDESC,
			SALESDESC, SALESPRICE, SUBLEVEL, TYPE
	FROM 	Item
	<!---WHERE	EDITSEQUENCE >= '1146517700'--->
</cfquery>
--->

<!---
<cfquery name="ItemsList" datasource="#QBDSN#">
	SELECT 	<!---TOP 500--->
			NAME AS SKU, 
			FULLNAME AS QB, 
			PARENTREFFULLNAME, ASSETACCOUNTREFFULLNAME, COGSACCOUNTREFFULLNAME,
			CUSTOMFIELDDIVISION AS CustomDivision, 
			CUSTOMFIELDINTERNETDESCRIPTION AS ItemDescription, 
			CUSTOMFIELDRETAILPRICE AS Price1Jarpy, 
			CUSTOMFIELDVOLUMEPTS AS Volume, 
			CUSTOMFIELDWEIGHTLBS AS Weight, 
			CUSTOMFIELDWEIGHTLBS AS fldShipWeight, 
			DESCRIPTION AS Comments, 
			EDITSEQUENCE, 
			INCOMEACCOUNTREFFULLNAME, 
			ISACTIVE AS Deleted, 
			LISTID, 
			PREFVENDORREFFULLNAME AS Category, 
			PURCHASECOST AS CostPrice, 
			PURCHASEDESC AS ItemDetails,
			SALESDESC AS ItemName, 
			SALESPRICE AS Price1Ponsard, 
			SUBLEVEL, TYPE
	FROM 	Item
</cfquery>
--->

<!---<cfdump var="#ItemsList#" expand="no"><cfabort>--->

<!---
<cfquery name="ItemInventory" datasource="#QBDSN#">
	SELECT 	FULLNAME AS QB, NAME AS SKU, QUANTITYONHAND AS StockQuantity, ISACTIVE AS Active
	FROM 	ItemInventory
</cfquery>

<cfoutput>

<font style="font-size:8px;">
<cfloop query="ItemsList">
	<cfquery name="ItemInventoryList" dbtype="query">
		SELECT 	*
		FROM 	ItemInventory
		WHERE	QB = '#ItemsList.QB#'
	</cfquery>
	#ItemInventoryList.QB#: #NumberFormat(ItemInventoryList.StockQuantity,9)# (#ItemInventoryList.Active#)<br/>
</cfloop>
</font>

</cfoutput>
--->