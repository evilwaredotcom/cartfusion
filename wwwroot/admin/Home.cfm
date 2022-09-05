<!--- BEGIN: QUERIES ------------------------------------->
<cfquery name="getNewOrders" datasource="#application.dsn#" cachedwithin="#CreateTimeSpan(0,0,1,0)#">
	SELECT	COUNT(*) AS NewOrders
	FROM	ORDERS
	WHERE  (BillingStatus = 'NB' 
	OR 		BillingStatus = 'AU')  <!--- NOT BILLED --->
	AND	   (OrderStatus = 'OD')	<!--- ORDERED ( OR OrderStatus = 'PR' ) --->
</cfquery>
<cfquery name="getPendingOrders" datasource="#application.dsn#" cachedwithin="#CreateTimeSpan(0,0,1,0)#">
	SELECT	COUNT(*) AS PendingOrders
	FROM	ORDERS
	WHERE  (BillingStatus != 'PA' 
	AND 	BillingStatus != 'CA' 
	AND 	BillingStatus != 'RE' 
	AND 	BillingStatus != 'PK'
	AND 	BillingStatus != 'PC') <!--- NOT PAID --->
	OR	   (OrderStatus != 'SH'
	AND		OrderStatus != 'CA'
	AND		OrderStatus != 'IT'
	AND		OrderStatus != 'RE')   <!--- NOT SHIPPED --->
</cfquery>
<cfquery name="getTop5Products" datasource="#application.dsn#" cachedwithin="#CreateTimeSpan(0,0,1,0)#">
	SELECT	SUM(oi.Qty) AS Qty, oi.ItemID,
		   (SELECT SKU
			FROM	Products
			WHERE	ItemID = oi.ItemID) AS SKU,
		   (SELECT ItemName
			FROM	Products
			WHERE	ItemID = oi.ItemID) AS ItemName
	FROM	OrderItems oi
	WHERE	oi.DateEntered < '#DateFormat((Now()+1),'mm/dd/yyyy')#'
	AND		oi.DateEntered >= '#DateFormat((Now()),'mm/dd/yyyy')#'
	GROUP BY ItemID
	ORDER BY Qty DESC
</cfquery>
<cfquery name="getLowInventory" datasource="#application.dsn#" cachedwithin="#CreateTimeSpan(0,0,1,0)#">
	SELECT	COUNT (*) AS LowInventory
	FROM	Products
	WHERE  (StockQuantity <= 10
	AND		SellByStock = 1 )
	OR		ItemStatus = 'OS'
	OR		ItemStatus = 'BO'
</cfquery>
<cfquery name="getActiveProducts" datasource="#application.dsn#" cachedwithin="#CreateTimeSpan(0,0,1,0)#">
	SELECT	COUNT (*) AS ActiveProducts
	FROM	Products
	WHERE   (Hide1 = 0 OR Hide1 IS NULL)
</cfquery>
<cfquery name="getHiddenProducts" datasource="#application.dsn#" cachedwithin="#CreateTimeSpan(0,0,1,0)#">
	SELECT	COUNT (*) AS HiddenProducts
	FROM	Products
	WHERE   Hide1 = 1
</cfquery>
<cfset TotalProducts = getActiveProducts.ActiveProducts + getHiddenProducts.HiddenProducts >
<cfquery name="getActiveCustomers" datasource="#application.dsn#" cachedwithin="#CreateTimeSpan(0,0,1,0)#">
	SELECT	COUNT (*) AS ActiveCustomers
	FROM	Customers c
	WHERE   (c.Deleted = 0 OR c.Deleted IS NULL)
	AND		c.CustomerID IN
		   (SELECT 	CustomerID
			FROM 	Orders
			WHERE	CustomerID = c.CustomerID )
</cfquery>
<cfquery name="getInactiveCustomers" datasource="#application.dsn#" cachedwithin="#CreateTimeSpan(0,0,1,0)#">
	SELECT	COUNT (*) AS InactiveCustomers
	FROM	Customers c
	WHERE   c.Deleted = 1
	OR		c.CustomerID NOT IN
		   (SELECT 	CustomerID
			FROM 	Orders
			WHERE	CustomerID = c.CustomerID )
</cfquery>
<cfset TotalCustomers = getActiveCustomers.ActiveCustomers + getInactiveCustomers.InactiveCustomers >
<cfquery name="getMessagesNote" datasource="#application.dsn#" cachedwithin="#CreateTimeSpan(0,0,1,0)#">
	SELECT	COUNT (*) AS MessagesNote
	FROM	Messages
	WHERE   Urgency = 1
	AND		(Done = 0 OR Done IS NULL)
</cfquery>
<cfquery name="getMessagesImp" datasource="#application.dsn#" cachedwithin="#CreateTimeSpan(0,0,1,0)#">
	SELECT	COUNT (*) AS MessagesImp
	FROM	Messages
	WHERE   Urgency = 2
	AND		(Done = 0 OR Done IS NULL)
</cfquery>
<cfquery name="getMessagesUrgent" datasource="#application.dsn#" cachedwithin="#CreateTimeSpan(0,0,1,0)#">
	SELECT	COUNT (*) AS MessagesUrgent
	FROM	Messages
	WHERE   Urgency = 3
	AND		(Done = 0 OR Done IS NULL)
</cfquery>
<!--- END: QUERIES ------------------------------------->

<!--- BEGIN: HEADER --->
<cfscript>
	PageTitle = 'CARTFUSION HOME' ;
	BannerTitle = 'CartFusion' ;
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">
<!--- END: HEADER --->

<style type="text/css">
	TD
	{ font-family: Tahoma, Arial, Sans-Serif; font-size: 12px; font-weight: bold;
	  text-decoration: none; color: 014589; }
</style>

<cfoutput>
<table width="100%" border="0" cellpadding="3" cellspacing="0">
	<tr style="background-color:##65ADF1;">
		<td width="33%" height="20" class="cfAdminHeader1">&nbsp; ORDER SUMMARY</b></td>
		<td width="1%" rowspan="17" style="background-color:##FFFFFF;">&nbsp;</td>
		<td width="33%" height="20" class="cfAdminHeader1">&nbsp; INVENTORY SUMMARY</td>
		<td width="1%" rowspan="17" style="background-color:##FFFFFF;">&nbsp;</td>
		<td width="33%" height="20" class="cfAdminHeader1">&nbsp; CUSTOMER SUMMARY</td>
	</tr>
	<tr>
		<td colspan="3" height="3"></td>
	</tr>
	<tr>
		<td width="33%">You Have <a href="Orders.cfm?field=New" class="cfAdminError">#getNewOrders.NewOrders# New Orders</a></td>
		<td width="33%">You Have <a href="Products.cfm?field=LowInventory" class="cfAdminError">#getLowInventory.LowInventory# Products Low On Inventory</a></td>
		<td width="33%">You've Had Active Customers Today</td>
	</tr>
	<tr>
		<td height="1"><img src="images/image-LineGray.gif" width="100%" height="1"></td>
		<td height="1"><img src="images/image-LineGray.gif" width="100%" height="1"></td>
		<td height="1"><img src="images/image-LineGray.gif" width="100%" height="1"></td>
	</tr>	
	<tr>
		<td>You Have <a href="Orders.cfm?field=Pending" class="cfAdminHome1">#getPendingOrders.PendingOrders# Pending Orders</a></td>
		<td>You Have <a href="Products.cfm?field=ActiveProducts" class="cfAdminHome1">#getActiveProducts.ActiveProducts# Active Products</a></td>
		<td>You Have <a href="Customers.cfm?field=ActiveCustomers" class="cfAdminHome1">#getActiveCustomers.ActiveCustomers# Active Customers</a></td>
	</tr>
	<tr>
		<td height="1"><img src="images/image-LineGray.gif" width="100%" height="1"></td>
		<td height="1"><img src="images/image-LineGray.gif" width="100%" height="1"></td>
		<td height="1"><img src="images/image-LineGray.gif" width="100%" height="1"></td>
	</tr>	
	<tr>
		<td rowspan="2">Top 5 Products Sold Today:</td>
		<td>You Have <a href="Products.cfm?field=HiddenProducts" class="cfAdminHome1">#getHiddenProducts.HiddenProducts# Hidden Products</a></td>
		<td>You Have <a href="Customers.cfm?field=InactiveCustomers" class="cfAdminHome1">#getInactiveCustomers.InactiveCustomers# Inactive Customers</a></td>
	</tr>
	<tr>
		<td height="1"><img src="images/image-LineGray.gif" width="100%" height="1"></td>
		<td height="1"><img src="images/image-LineGray.gif" width="100%" height="1"></td>
	</tr>	
	<tr>
		<td valign="top">
			<cfloop query="getTop5Products" endrow="5">
				<img src="images/spacer.gif" width="15" height="1"><font class="cfAdminError">#Qty#</font> <a href="ProductDetail.cfm?ItemID=#ItemID#">#ItemName# (#SKU#)</a><br><img src="images/spacer.gif" width="1" height="3"><br>
			</cfloop>
		</td>
		<td valign="top">You Have <a href="Products.cfm" class="cfAdminHome1">#TotalProducts# Total Products</a></td>
		<td valign="top">You Have <a href="Customers.cfm" class="cfAdminHome1">#TotalCustomers# Total Customers</a></td>
	</tr>	
</table>
<br>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr><td height="1" colspan="5"><img src="images/image-LineGray.gif" width="100%" height="1"></td></tr>
	<tr><td height="1" colspan="5"><img src="images/image-LineWhite.gif" width="100%" height="1"></td></tr>
	<tr><td height="1" colspan="5"><img src="images/image-LineGray.gif" width="100%" height="1"></td></tr>
</table>

<table width="100%" border="0" cellpadding="3" cellspacing="0">
	<tr style="background-color:##DDDDDD;">
		<td width="33%" height="20" class="cfAdminHeader1">&nbsp; MESSAGES &amp; CALENDAR</td>
		<td width="1%" rowspan="17" style="background-color:##FFFFFF;">&nbsp;</td>
		<td width="33%" height="20" class="cfAdminHeader4">&nbsp; CARTFUSION CENTER</td>
		<td width="1%"  height="20" class="cfAdminHeader4">&nbsp;</td>
		<td width="33%" height="20" class="cfAdminHeader4">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="3" height="3"></td>
		<td width="1%" rowspan="17" style="background-color:##FFFFFF;">&nbsp;</td>
		<td colspan="1" height="3"></td>
	</tr>
	<tr>
		<td>
			You Have <a href="MC-Messages.cfm?SortOption=Urgency&SortAscending=1" class="cfAdminError">#getMessagesUrgent.MessagesUrgent# Urgent Messages</a>,
			<a href="MC-Messages.cfm?SortOption=Urgency&SortAscending=1" class="cfAdminHome1">#getMessagesImp.MessagesImp# Important Messages</a>, and
			<a href="MC-Messages.cfm?SortOption=Urgency&SortAscending=0" class="cfAdminLink">#getMessagesNote.MessagesNote# Notes</a>
		</td>
		<td><img src="images/image-NewsUpdates.jpg" border="0" alt="CartFusion News & Updates"></td>
		<td><img src="images/image-DeveloperCenter.jpg" border="0" alt="CartFusion Developer Center"></td>
	</tr>
	<tr>
		<td height="1"><img src="images/image-LineGray.gif" width="100%" height="1"></td>
		<td height="1"><img src="images/image-LineGray.gif" width="100%" height="1"></td>
		<td height="1"><img src="images/image-LineGray.gif" width="100%" height="1"></td>
	</tr>
	<tr>
		<td valign="top">
			Calendar Coming Soon!
		</td>
		<td class="cfAdminDefault" valign="top">
			<cftry>
				<cfhttp url="http://www.tradestudios.com/docs/cfNews.html" method="get" throwonerror="yes" />
				#cfhttp.FileContent#
				<cfcatch>
					<font class="cfAdminError">No News & Updates Available (#cfcatch.Message#)</font>
				</cfcatch>
			</cftry>
		</td>
		<td class="cfAdminDefault" valign="top">
			<cftry>
				<cfhttp url="http://www.tradestudios.com/docs/cfDevCenter.html" method="get" throwonerror="yes" />
				#cfhttp.FileContent#
				<cfcatch>
					<font class="cfAdminError">No Developer Center Information Available (#cfcatch.Message#)</font>
				</cfcatch>
			</cftry>
		</td>
	</tr>
</table>
</cfoutput>

<cfinclude template="LayoutAdminFooter.cfm">