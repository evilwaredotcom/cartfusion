<!--- <cfsetting enablecfoutputonly="Yes">
<cfsilent>
	<CFQUERY NAME="getAddresses" DATASOURCE="#application.dsn#">
		SELECT 	o.OrderID,o.OShipFirstName,o.OShipLastName,o.OShipAddress1,o.OShipAddress2,o.OShipCity,o.OShipState,o.OShipZip
		FROM 	Orders o
		WHERE	0=1
		<cfloop index="OrderID" list="#ExportList#">
		OR		OrderID = #OrderID#
		</cfloop>
	</CFQUERY>
	<cffunction name="OrderWeight" returntype="numeric">
		<cfargument name="oID" type="numeric" required="yes">
		<CFQUERY NAME="getOrderWeight" DATASOURCE="#application.dsn#">
			SELECT		SUM(p.Weight) AS OrderWeight
			FROM		OrderItems oi
			INNER JOIN	Products p ON oi.ItemID = p.ItemID
			WHERE		(oi.OrderID = #oID#)
		</CFQUERY>
		<cfif isDefined("getOrderWeight.OrderWeight") and getOrderWeight.OrderWeight neq ""><cfreturn getOrderWeight.OrderWeight>
		<cfelse><cfreturn 0></cfif>
	</cffunction>
<cfcontent type="text/csv"><cfheader name="Content-Disposition" value="filename=ASCShippingAddresses.csv">
</cfsilent><cfprocessingdirective suppresswhitespace="Yes"><cfoutput>Ship Name#chr(9)#Ship Address 1#chr(9)#Ship Address 2#chr(9)#Ship City#chr(9)#Ship State#chr(9)#Ship Zip#chr(9)#Ship Weight#Chr(13)##Chr(10)#</cfoutput>
<cfoutput query="getAddresses">#OShipFirstName# #OShipLastName##chr(9)##OShipAddress1##chr(9)##OShipAddress2##chr(9)##OShipCity##chr(9)##OShipState##chr(9)##OShipZip##chr(9)##OrderWeight(OrderID)##Chr(13)##Chr(10)#</cfoutput></cfprocessingdirective>
 --->
<cfscript>
	PageTitle = 'CartFusion Address CSV File Exporter';
</cfscript>

<html>
<head>
<META NAME="Author" CONTENT="Trade Studios - www.tradestudios.com">
<title><CFIF isDefined('PageTitle')><CFOUTPUT>#application.DomainName#: #PageTitle#</CFOUTPUT></CFIF></title>

<cfinclude template="css.cfm">

</head>


<body style="margin:0px;" onLoad="resizeTo(550,350); moveTo(50,50);">

<table border="0" cellpadding="0" cellspacing="0" width="100%" align="left" style="padding:10px;">
	<tr valign="top">
		<td>
		
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td  height="20" align="left" class="cfAdminTitle">
						<cfoutput>#UCASE(PageTitle)#</cfoutput>
					</td>
				</tr>
				<tr><td height="1"><img src="images/image-LineGray.gif" width="100%" height="1"></td></tr>
				<tr><td height="1"><img src="images/image-LineWhite.gif" width="100%" height="1"></td></tr>
				<tr><td height="1"><img src="images/image-LineGray.gif" width="100%" height="1"></td></tr>
				<tr><td>&nbsp;</td></tr>
			</table>
			
			<cfif isDefined("form.ExportList") and form.ExportList neq "">
					
				<cfsilent>
					<CFQUERY NAME="getAddresses" DATASOURCE="#application.dsn#">
						SELECT 	o.OrderID,o.OShipFirstName,o.OShipLastName,o.OShipAddress1,o.OShipAddress2,o.OShipCity,o.OShipState,o.OShipZip,o.Phone
						FROM 	Orders o
						WHERE	0=1
						<cfloop index="OrderID" list="#Form.ExportList#">
						OR		OrderID = #OrderID#
						</cfloop>
					</CFQUERY>
					<cffunction name="OrderWeight" returntype="numeric">
						<cfargument name="oID" type="numeric" required="yes">
						<CFQUERY NAME="getOrderWeight" DATASOURCE="#application.dsn#">
							SELECT		SUM(p.Weight) AS OrderWeight
							FROM		OrderItems oi
							INNER JOIN	Products p ON oi.ItemID = p.ItemID
							WHERE		(oi.OrderID = #oID#)
						</CFQUERY>
						<cfif isDefined("getOrderWeight.OrderWeight") and getOrderWeight.OrderWeight neq ""><cfreturn getOrderWeight.OrderWeight>
						<cfelse><cfreturn 0></cfif>
					</cffunction>
				</cfsilent>
				
					<cfif getAddresses.RecordCount neq 0>
						<!--- SET FILENAME FOR USE --->
						<cfscript>
							CF2WSfile = 'CF_#DateFormat(Now(),'yymmddHHmmss')#.csv' ;
							CF2WSpath = '#getDirectoryFromPath(getCurrentTemplatePath())#\docs\' ;
						</cfscript>
						
						<!--- CREATE BLANK FILE --->
						<cffile action="write" file="#CF2WSpath##CF2WSfile#" output="Name,Address1,Address2,City,State,Zip,Phone,Weight,OrderNumber" addnewline="yes">
						
						<cfoutput query="getAddresses">
							
							<!--- MUST CREATE STRING SO QUOTES CAN BE USED --->
							<cfset oShipName = OShipFirstName & " " & OShipLastName>
							<cfset LineOrder = "#TRIM(Replace(oShipName,',',''))#,#TRIM(Replace(OShipAddress1,',',''))#,#TRIM(Replace(OShipAddress2,',',''))#,#TRIM(Replace(OShipCity,',',''))#,#TRIM(Replace(OShipState,',',''))#,#TRIM(Replace(OShipZip,',',''))#,#TRIM(Replace(Phone,',',''))#,#TRIM(Replace(OrderWeight(OrderID),',',''))#,#TRIM(Replace(OrderID,',',''))#">
							
							<!--- APPEND ORDERS & ORDER ITEMS TO TEXT FILE --->
							<cffile action="append" file="#CF2WSpath##CF2WSfile#" addnewline="yes" output="#LineOrder#">
							
						</cfoutput>
						
						
						<cfoutput>
						<table width="100%" border="1" bordercolor="330000" cellpadding="7" cellspacing="0">
							<tr>
								<td width="100%" align="center" class="cfAdminDefault">
									<b>Your Shipping Order List CSV file has been created and is located here:</b><br>
									<a href="#application.RootURL#/admin/docs/#CF2WSfile#"><font color="006600"><u>#application.RootURL#/admin/docs/#CF2WSfile#</u></font></a><br><br>
									Right click the link and click "Save Target As...", then save the file to your computer as a .CSV file.<br><br>
									<a href="javascript:window.close();"><font color="006600"><u>Close This Window</u></font></a>
								</td>
							</tr>
						</table>
						</cfoutput>
					<cfelse>
						<table width="50%" border="1" bordercolor="330000" cellpadding="7" cellspacing="0">
							<tr>
								<td width="100%" align="center" class="cfAdminError">
									<b>No orders were found matching the selection criteria.</b><br><br>
									<a href="javascript:window.close();"><font color="006600"><u>Close This Window</u></font></a>
								</td>
							</tr>
						</table>
					</cfif>	
						
				
			<cfelse>
					ERROR<br>
					Address Listing not received.  Please notify website administrator.<br><br>
					<a href="Orders.cfm"><font color="006600"><u>Return to Orders</u></font></a>
			</cfif>
		</td>
	</tr>
</table>

</font> 
</body>
</html> 