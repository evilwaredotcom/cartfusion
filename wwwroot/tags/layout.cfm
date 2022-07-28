<cfsetting enablecfoutputonly=true>
<cfprocessingdirective pageencoding="utf-8">
<!---
	Name         	: Layout.cfm
	History      	: Created, for the purpose of 
				   				calling everything from one page
	Purpose		 		: Layout
	Main Elements	: 
		Attribute Name		Default (False/True)	Description
		showExpireHeaders		False					Show and hide ExpireHeaders (default is not show)
		showCartTotals			True					Show and hide CartTotals (default is show)
		showHorizontalNav		True					Show and hide HorizontalNav (default is show)
		showPrimaryNav			True					Show and hide PrimaryNav (default is show)
		showPrimaryNavLine	True					Show and hide rimaryNavLine (default is show)
		showCategories			True					Show and hide Categories (default is show)
		showBreadCrumb 			False					Show and hide breadcrumb links (default is not show)
		showFooter					True					Show and hide footer (default is show)
		showCopyright				True					Show and hide Copyright (default is show)
--->

<!--- 
	Attribute Name		Description
	LayoutStyle			A/B (a = cats on left content on right) (b = cats on right content on left)
 --->

<cfparam name="attributes.LayoutStyle" default="A">
<cfparam name="attributes.CurrentTab" default="Home">
<!--- <cfparam name="attributes.pageType" default="">
<cfparam name="attributes.productLayout" default="A"> --->

<cfif thisTag.executionMode is "start">

<cfscript>
	/* Dont get Categories for page if showCategories variable is passed 
	   that means the calling pages does not need categories shown
	*/
	if ( trim(session.CustomerArray[28]) NEQ '' ) {
				UserID = session.CustomerArray[28] ;
	} 
	else {
		UserID = 1 ;
	}
	
	if( not isDefined('attributes.showCategories'))	{
		// Get main categories
		getMainCategories = application.Common.getCategories(
			UserID=UserID, 
			SiteID=application.SiteID,
			OnlyMainCategories='true');		
	
		// This is for the LayoutGlobalMeta.cfm file
		getCategory = application.Common.getCategories(
			UserID=UserID, 
			SiteID=application.SiteID);
	}
	
	// Get Cart Items
	getCartItems = application.Cart.getCartItems(UserID=UserID,SiteID=application.siteConfig.data.SiteID,SessionID=caller.SessionID) ;
</cfscript>

<cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<cfinclude template="../LayoutGlobalMeta.cfm">
	<link rel="shortcut icon" href="images/favicon.ico" />
	<link rel="stylesheet" type="text/css" href="css/cartfusion_screen_layout.css">
	<link rel="stylesheet" type="text/css" href="css/cartfusion_screen_formatting.css">
	<link rel="stylesheet" type="text/css" href="css/cartfusion_screen_design.css">

<cfinclude template="../includes/JSCode.cfm">

<cfif structKeyExists(attributes, 'showExpireHeaders')>
<!--- Header Info To Stay Logged Out --->
	<CFHEADER NAME="Expires" VALUE="Tue, 01 Jan 1985 00:00:01 GMT">
	<CFHEADER NAME="Pragma" VALUE="no-cache">
	<CFHEADER NAME="cache-control" VALUE="no-cache, no-store, must-revalidate">

<!--- Header Info To Stay Logged Out --->
	<META HTTP-EQUIV="Expires" CONTENT="Tue, 01 Jan 1985 00:00:01 GMT">
	<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
	<META HTTP-EQUIV="cache-control" CONTENT="no-cache, no-store, must-revalidate">
	<META NAME="ROBOTS" CONTENT="NOINDEX, NOFOLLOW">
</cfif>

</head>

<body onload="if(top != self) top.location.replace(self.location.href);">
<!--- <cfdump var="#getmyCartItems#"> --->

	<!--- Start Container --->
	<div id="container">
	
		<!--- Start Header --->
		<div id="header">
			
			<!--- Start Logo --->
			<div id="logo">
				<img src="images/pics/pic-AboutUs.gif" />
			</div>
			<!--- End Logo --->
			
			<!--- Start Header Links --->
			<cfif not structKeyExists(attributes, 'showCartTotals')>
				<div id="headerlinks">
				
					| Cart (<cfif getCartItems.data.CartTotalQty eq ''>0<cfelse>#getCartItems.data.CartTotalQty#</cfif> Items)<!--- Welcome FirstName | Items In Cart: 0 | Cart Total: $0.00 --->
				</div>
			</cfif>
			<!--- End Header Links --->
			
		</div>
		<!--- End Header --->
		
		<br class="clear" />
		<!--- End Header --->
		
		
		<!--- Start horizontalNav Container --->
		<cfif not structKeyExists(attributes, 'showHorizontalNav')>
		
		<div id="horizontalNav">
		
		<!--- Start Primary Nav Tabs --->
		<cfif not structKeyExists(attributes, 'showPrimaryNav')>
		
			<div id="primaryNavTabs">
				<ul>
					<li style="margin-left: 1px" <cfif attributes.CurrentTab eq "Home">id="pnt-current"</cfif>><a href="index.cfm" title="Home"><span>Home</span></a></li>
					<li <cfif attributes.CurrentTab eq "Products">id="pnt-current"</cfif> ><a href="CategoryAll.cfm" title="Products"><span>Products</span></a></li>
					<li <cfif attributes.CurrentTab eq "MyAccount">id="pnt-current"</cfif>><a href="CA-Login.cfm?goToPage=CA-CustomerArea.cfm" title="My Account"><span>My Account</span></a></li>	
					<li <cfif attributes.CurrentTab eq "ViewCart">id="pnt-current"</cfif>><a href="CartEdit.cfm" title="View Cart"><span>View Cart</span></a></li>
					<li <cfif attributes.CurrentTab eq "CustomerService">id="pnt-current"</cfif>><a href="ContactUs.cfm" title="Customer Service"><span>Customer Service</span></a></li>
					<li <cfif attributes.CurrentTab eq "AboutUs">id="pnt-current"</cfif>><a href="AboutUs.cfm"  title="About Us"><span>About Us</span></a></li>
					<cfif application.siteconfig.data.AllowAffiliates eq 1 >
						<li <cfif attributes.CurrentTab eq "Affiliates">id="pnt-current"</cfif>><a href="AF-Main.cfm" title="Affiliate Program"><span>Affiliate Program</span></a></li>
					</cfif>
				</ul>		
			</div>
		</cfif>
		<!--- End Primary Nav Tabs --->
		
		<!--- Start Primary Nav Tabs Line --->
			<cfif not structKeyExists(attributes, 'showPrimaryNavLine')>
				<div id="primaryNavTabsline">
					<div id="primarySearch">
						<cfform name="search" class="search" action="searchResults.cfm" method="GET">
							Search: <cfinput name="string" value=" -- Keyword or SKU -- " onfocus="this.value=''">&nbsp;&nbsp;
							<input type="submit" name="GoSearch" value="Go" class="button"><!--- <cfinput name="button" type="submit" value="Go" class="button"> --->
							<input type="hidden" name="start" value="1">
							<input type="hidden" name="field" value="ItemAndID">
						</cfform>
					</div>
				</div>
			</cfif>
		<!--- End Primary Nav Tabs Line --->
		
		</div>
		</cfif>
		<!--- End HorizontalNav Container --->

		<!--- Start Page Container --->
		<div id="pageContainer">
		
			<!--- Start categoryNavContainer --->
			<cfif not structKeyExists(attributes, 'showCategories')>
			
			<div id="categoryNavContainer-#attributes.LayoutStyle#">
			<div class="first"><br />&nbsp;Categories<br />&nbsp;</div>
			
			<!--- Start categoryNav --->
			<div id="categoryNavContent">
			
			<cfloop query="getMainCategories">
				<cfset getSubCategories = application.Common.getCategories(UserID=UserID, SiteID=application.SiteID,CatID=getMainCategories.CatID)>
				<h1><a href="ProductList.cfm?CatDisplay=#getMainCategories.CatID#">#getMainCategories.CatName#</a></h1>
				
				<!--- If Query has a record count then show list --->
				<cfif getSubCategories.RecordCount>
					<ul class="categories">
						<cfloop query="getSubCategories">
							<li><a href="ProductList.cfm?CatDisplay=#getSubCategories.CatID#">#getSubCategories.CatName#</a></li>
						</cfloop>
					</ul>
				</cfif>
					
			</cfloop>
			
			<!--- End of category list --->

			<br />
				<div align="center">
					<img src="images/pic-FreeShipping.jpg" />
					<br />
				</div>	
			
			<!--- <h1>Information</h1>
				<ul class="categories">
					<li><a href="">Shipping, Handling & Returns</a></li>
					<li><a href="">Privacy Policy</a></li>
				</ul> --->
			
				<br />
			</div><div class="last">&nbsp;</div>
			<!--- End categoryNav --->
			</div>
			</cfif>
			<!--- End categoryNavContainer --->
			


			<!--- Start Page Content --->
			<div id="pageContent-#attributes.LayoutStyle#">
				
</cfoutput>
<!--- After else is not thisTag.executionMode 'start' --->
<cfelse>


<cfoutput>

			</div>
			<!--- End Page Content --->
			
		</div>
		<!--- End Page Container --->
		<br class="clear" /><br /><br />
	</div>
	<!--- End Container --->
	
	<!--- Start Footer --->
	
	<cfif not structKeyExists(attributes, 'showFooter')>
		<div id="footer">
			&nbsp;
		</div>
	</cfif>
	<!--- End Footer --->
	
	<!--- Start Copyright & Links --->
	
	
	<div id="copyright">
		<cfif not structKeyExists(attributes, 'showCopyright')>
			&copy; Site Name.com #DateFormat(Now(), "yyyy")#
			<ul>
				<li><a href="">Home</a></li>
				<li><a href="StorePolicies.cfm">Store Policy</a></li>
				<li><a href="StorePrivacy.cfm">Privacy Policy</a></li>
				<li><a href="StoreDisclaimer.cfm">Disclaimer</a></li>
				<li><a href="StoreHelp.cfm">Ordering Help</a></li>
				<cfif application.siteconfig.data.AllowAffiliates EQ 1 >
					<li><a href="AF-Login.cfm">Affiliates</a></li>
				</cfif>
				<li><a href="javascript:NewWindow('Suggestions.cfm','Suggestions','475','375','yes');">Make A Suggestion</a></li>
			</ul>
			<br />
			<br />
			We Kindly Accept: 
			<cfscript>
				if ( config.AllowCreditCards EQ 1 )
				{
					if ( config.AcceptVISA eq 1 )
						WriteOutput("<img src='images/logos/logo-VISA.gif' border='0' alt='We Accept VISA' align='absmiddle'>&nbsp;"); 
					if ( config.AcceptMC eq 1 )
						WriteOutput("<img src='images/logos/logo-MC.gif' border='0' alt='We Accept MasterCard' align='absmiddle'>&nbsp;");
					if ( config.AcceptDISC eq 1 )
						WriteOutput("<img src='images/logos/logo-DISC.gif' border='0' alt='We Accept Discover' align='absmiddle'>&nbsp;");
					if ( config.AcceptAMEX eq 1 )
						WriteOutput("<img src='images/logos/logo-AMEX.gif' border='0' alt='We Accept American Express' align='absmiddle'>&nbsp;");
				}
				if ( config.AllowECheck eq 1 )
					WriteOutput("<img src='images/logos/logo-ECheck.gif' border='0' alt='We Accept E-Checks' align='absmiddle'>&nbsp;");
				if ( config.AllowPayPal eq 1 )
					WriteOutput("<img src='images/logos/logo-PayPal.gif' border='0' alt='We Accept PayPal' align='absmiddle'>");
			</cfscript>

			<cfelse>&nbsp;
		</cfif>
	</div>
	<!--- End Copyright & Links --->

</div>

</body>
</html>
</cfoutput>
</cfif>
<cfsetting enablecfoutputonly=false>