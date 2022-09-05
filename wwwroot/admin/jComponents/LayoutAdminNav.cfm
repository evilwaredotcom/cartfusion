<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<!--- Create a tree --->
<cf_jComponentSkin>

<table width="100%" border="0" cellpadding="5" cellspacing="0">
	<tr valign="top">
		<td width="100%" class="cfAdminLeftNav" valign="top" style="padding-left:14px;">
			<cf_jAccordian width="100%" skin="default">
				<cf_jAccordianPane label="<a href='Home.cfm' class='cfAdminLeftNav' target='main'>HOME</a><br>"></cf_jAccordianPane>
				<cf_jAccordianPane label="ORDERS" link="Orders.cfm">
					<a href="OrderAdd.cfm" class="cfAdminLeftNav2" target="main">- ADD ORDER</a><br><img src="images/spacer.gif" height="5" width="1"><br>
					<a href="BackOrders.cfm" class="cfAdminLeftNav2" target="main">- BACK ORDERS</a><br><img src="images/spacer.gif" height="5" width="1"><br>
					<a href="OrderReturns.cfm" class="cfAdminLeftNav2" target="main">- RETURNS</a><br><img src="images/spacer.gif" height="5" width="1"><br>
				</cf_jAccordianPane>
				<cf_jAccordianPane label="PRODUCTS" link="Products.cfm">
					<a href="ProductAdd.cfm" class="cfAdminLeftNav2" target="main">- ADD PRODUCT</a><br><img src="images/spacer.gif" height="5" width="1"><br>
					<a href="ProductClasses.cfm" class="cfAdminLeftNav2" target="main">- PRODUCT CLASSES</a><br><img src="images/spacer.gif" height="5" width="1"><br>
					<cfif isUserInRole('Administrator')>
					<a href="Prices.cfm" class="cfAdminLeftNav2" target="main">- PRODUCT PRICES</a><br><img src="images/spacer.gif" height="5" width="1"><br>
					</cfif>
					<a href="ProductReviews.cfm" class="cfAdminLeftNav2" target="main">- PRODUCT REVIEWS</a><br><img src="images/spacer.gif" height="5" width="1"><br>
					<a href="ProductTypes.cfm" class="cfAdminLeftNav2" target="main">- PRODUCT SPECS</a><br><img src="images/spacer.gif" height="5" width="1"><br>
				</cf_jAccordianPane>
				<cf_jAccordianPane label="CUSTOMERS" link="Customers.cfm">
					<a href="CustomerAdd.cfm" class="cfAdminLeftNav2" target="main">- ADD CUSTOMER</a><br><img src="images/spacer.gif" height="5" width="1"><br>
				</cf_jAccordianPane>
				<cf_jAccordianPane label="CATEGORIES" link="Categories.cfm">
					<a href="CategoryAdd.cfm" class="cfAdminLeftNav2" target="main">- ADD CATEGORY</a><br><img src="images/spacer.gif" height="5" width="1"><br>
				</cf_jAccordianPane>
				<cf_jAccordianPane label="SECTIONS" link="Sections.cfm">
					<a href="SectionAdd.cfm" class="cfAdminLeftNav2" target="main">- ADD SECTION</a><br><img src="images/spacer.gif" height="5" width="1"><br>
				</cf_jAccordianPane>
				<cf_jAccordianPane label="DISTRIBUTORS" link="Distributors.cfm">
					<a href="DistributorAdd.cfm" class="cfAdminLeftNav2" target="main">- ADD DISTRIBUTOR</a><br><img src="images/spacer.gif" height="5" width="1"><br>
				</cf_jAccordianPane>
				<cf_jAccordianPane label="AFFILIATES" link="Affiliates.cfm">
					<a href="AffiliateAdd.cfm" class="cfAdminLeftNav2" target="main">- ADD AFFILIATE</a><br><img src="images/spacer.gif" height="5" width="1"><br>
					<a href="AffiliateLevels.cfm" class="cfAdminLeftNav2" target="main">- AFFILIATE LEVELS</a><br><img src="images/spacer.gif" height="5" width="1"><br>
				</cf_jAccordianPane>
				<cf_jAccordianPane label="MESSAGE CENTER">
					<a href="MC-Messages.cfm" class="cfAdminLeftNav2" target="main">- INTERNAL</a><br><img src="images/spacer.gif" height="5" width="1"><br>
					<a href="MC-Main.cfm" class="cfAdminLeftNav2" target="main">- TO CUSTOMERS</a><br><img src="images/spacer.gif" height="5" width="1"><br>
				</cf_jAccordianPane>
				<cf_jAccordianPane label="WIZARDS">
					<a href="MWP-Home.cfm" class="cfAdminLeftNav2" target="main">- MAIL WIZARD</a><br><img src="images/spacer.gif" height="5" width="1"><br>
					<a href="RWP-ReportWizard.cfm" class="cfAdminLeftNav2" target="main">- REPORT WIZARD</a><br><img src="images/spacer.gif" height="5" width="1"><br>
					<a href="Shipping/index.cfm" class="cfAdminLeftNav2" target="main">- SHIP WIZARD</a><br><img src="images/spacer.gif" height="5" width="1"><br>
				</cf_jAccordianPane>
				<cf_jAccordianPane label="MISCELLANEOUS">
					<a href="Search.cfm" class="cfAdminLeftNav2" target="main">- SEARCH</a><br><img src="images/spacer.gif" height="5" width="1"><br>
					<a href="http://support.tradestudios.com" class="cfAdminLeftNav2" target="main">- HELP DESK</a><br><img src="images/spacer.gif" height="5" width="1"><br>
					<a href="Dictionary.cfm" class="cfAdminLeftNav2" target="main">- DICTIONARY</a><br><img src="images/spacer.gif" height="5" width="1"><br>
				</cf_jAccordianPane>
				<!---<cfif isUserInRole('Administrator')>--->
				<cf_jAccordianPane label="DISCOUNTS" link="Discounts.cfm">
					<a href="DiscountAdd.cfm" class="cfAdminLeftNav2" target="main">- ADD DISCOUNT</a><br><img src="images/spacer.gif" height="5" width="1"><br>
				</cf_jAccordianPane>
				<cf_jAccordianPane label="USERS">
					<a href="AdminUsers.cfm" class="cfAdminLeftNav2" target="main">- ADMIN USERS</a><br><img src="images/spacer.gif" height="5" width="1"><br>
					<a href="AdminUserAdd.cfm" class="cfAdminLeftNav2" target="main">- ADD ADMIN USER</a><br><img src="images/spacer.gif" height="5" width="1"><br>
					<a href="Users.cfm" class="cfAdminLeftNav2" target="main">- USERS/TIERS</a><br><img src="images/spacer.gif" height="5" width="1"><br>
				</cf_jAccordianPane>
				<cf_jAccordianPane label="FILES">
					<a href="FileImporter.cfm" class="cfAdminLeftNav2" target="main">- FILE IMPORTER</a><br><img src="images/spacer.gif" height="5" width="1"><br>
					<a href="FileExporter.cfm" class="cfAdminLeftNav2" target="main">- FILE EXPORTER</a><br><img src="images/spacer.gif" height="5" width="1"><br>
				</cf_jAccordianPane>
				<cf_jAccordianPane label="QUICKBOOKS">
					<a href="QB/QB-ImportFrom.cfm" class="cfAdminLeftNav2" target="main">- IMPORT FROM QB</a><br><img src="images/spacer.gif" height="5" width="1"><br>
					<a href="QB/QB-ExportTo.cfm" class="cfAdminLeftNav2" target="main">- EXPORT TO QB</a><br><img src="images/spacer.gif" height="5" width="1"><br>
				</cf_jAccordianPane>
				<cf_jAccordianPane label="<a href='PayPal/index.cfm' class='cfAdminLeftNav' target='main'>PAYPAL PRO</a><br>"></cf_jAccordianPane>
				<cf_jAccordianPane label="<a href='#application.StatsURL#' class='cfAdminLeftNav' target='main'>SITE STATISTICS</a><br>"></cf_jAccordianPane>
				<!---<cf_jAccordianPane label="<a href='Layout.cfm' class='cfAdminLeftNav' target='main'>LAYOUT</a><br>"></cf_jAccordianPane>--->
				<cf_jAccordianPane label="CONFIGURATION" link="Configuration.cfm">
					<a href="Config-Shipping.cfm" class="cfAdminLeftNav2" target="main">- SETUP SHIPPING</a><br><img src="images/spacer.gif" height="5" width="1"><br>
					<a href="Config-Tax.cfm" class="cfAdminLeftNav2" target="main">- SETUP TAX</a><br><img src="images/spacer.gif" height="5" width="1"><br>
				</cf_jAccordianPane>
				<!---</cfif>--->
			</cf_jAccordian>
			
			<!--- QUICK LINKS
			<form method="post" name="navigation" id="navigation">
			<SELECT ID="SmartNav" NAME="SmartNav" onChange='smartNavigation(document.navigation);' class="cfAdminDefault">
				<OPTION SELECTED VALUE="">-- Quick Links --
				<OPTION VALUE="Orders.cfm">Orders
				<OPTION VALUE="OrderAdd.cfm">-- Add Order
				<OPTION VALUE="Products.cfm">Products
				<OPTION VALUE="ProductAdd.cfm">-- Add Product
				<OPTION VALUE="ProductClasses.cfm">-- Product Classes
				<OPTION VALUE="Prices.cfm">-- Product Prices
				<OPTION VALUE="ProductReviews.cfm">-- Product Reviews
				<OPTION VALUE="ProductTypes.cfm">-- Product Specs
				<OPTION VALUE="Customers.cfm">Customers
				<OPTION VALUE="CustomerAdd.cfm">-- Add Customer
				<OPTION VALUE="Categories.cfm">Categories
				<OPTION VALUE="CategoryAdd.cfm">-- Add Category
				<OPTION VALUE="Sections.cfm">Sections
				<OPTION VALUE="SectionAdd.cfm">-- Add Sections
			</SELECT>
			</form>
			--->
		</td>
	</tr>
</table>