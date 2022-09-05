<cfsetting enablecfoutputonly=true>
<cfprocessingdirective pageencoding="utf-8">
<!---
	Attribute Name		Default (False/True)	Description
	showExpireHeaders	False					Show and hide ExpireHeaders (default is not show)
	showCartTotals		True					Show and hide CartTotals (default is show)
	showHorizontalNav	True					Show and hide HorizontalNav (default is show)
	showPrimaryNav		True					Show and hide PrimaryNav (default is show)
	showPrimaryNavLine	True					Show and hide rimaryNavLine (default is show)
	showCategories		True					Show and hide Categories (default is show)
	showBreadCrumb 		False					Show and hide breadcrumb links (default is not show)
	showFooter			True					Show and hide footer (default is show)
	showCopyright		True					Show and hide Copyright (default is show)
--->
<cfparam name="attributes.LayoutStyle" default="A">
<cfparam name="attributes.CurrentTab" default="Home">
<!--- <cfparam name="attributes.pageType" default="">
<cfparam name="attributes.productLayout" default="A"> --->

<!---<cfdump var="#thisTag#">--->

<cfif thisTag.executionMode is "start">

<cfscript>
	// do we have a user logged in?
	if (trim(session.CustomerArray[28]) NEQ '') {
		UserID = session.CustomerArray[28];
	} else {
		UserID = 1;
	}
	// show categories?
	if(not isDefined('attributes.showCategories')){
		// Get main categories
		getMainCategories = application.Common.getCategories(
			UserID = UserID, 
			SiteID = application.SiteID,
			OnlyMainCategories = true
		);
		// This is for the LayoutGlobalMeta.cfm file
		getCategory = application.Common.getCategories(
			UserID = UserID, 
			SiteID = application.SiteID
		);
	}
	// show sections?
	if(not isDefined('attributes.showSections')){
		// Get main sections
		getMainSections = application.Common.getSections(
			UserID = UserID, 
			SiteID = application.SiteID,
			OnlyMainSections = true
		);
		// This is for the LayoutGlobalMeta.cfm file
		getSection = application.Common.getSections(
			UserID = UserID, 
			SiteID = application.SiteID
		);
	}
	// Get Cart Items
	getCartItems = application.Cart.getCartItems(
		UserID = UserID,
		SiteID = application.SiteID,
		SessionID = caller.SessionID
	);
</cfscript>

<cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<cfinclude template="/LayoutGlobalMeta.cfm">
	<link rel="shortcut icon" href="/images/favicon.ico" />
	<link rel="stylesheet" type="text/css" href="/templates/#application.SiteTemplate#/layout.css">
	<cfinclude template="/includes/JSCode.cfm">
</head>
<body onload="if(top != self) top.location.replace(self.location.href);">
<!---<cfdump var="#getmyCartItems#">--->
<div id="container">
	<div id="header">
		<div id="logo">
			<a href="index.cfm" title="#application.StoreNameShort# Home Page"><img src="/images/logo.png" title="#application.StoreNameShort#"></a>
			<!---<br/>
			<a href="index.cfm" title="#application.StoreTagline#">#application.StoreTagline#</a>--->
		</div>
		<cfif not structKeyExists(attributes, 'showCartTotals')>
			<div id="headerlinks" align="center">
				<cfinclude template="../../tags/welcomeUser.cfm">
				| 
				<a href="/CartEdit.cfm" title="View your shopping cart"
					>Shopping Cart (<cfif getCartItems.data.CartTotalQty eq ''>0<cfelse>#getCartItems.data.CartTotalQty#</cfif>)</a>
			</div>
		</cfif>
	</div>
	<br class="clear" />
	<!--- show horizontal navigation? --->
	<cfif not structKeyExists(attributes, 'showHorizontalNav')>
		<div id="horizontalNav">
			<!--- show primary navigation tabs? --->
			<cfif not structKeyExists(attributes, 'showPrimaryNav')>
				<div id="primaryNavTabs">
					<ul>
						<li style="margin-left: 1px" <cfif attributes.CurrentTab eq "Home">id="pnt-current"</cfif>><a href="index.cfm" title="Home"><span>Home</span></a></li>
						<li <cfif attributes.CurrentTab eq "Products">id="pnt-current"</cfif> ><a href="CategoryAll.cfm" title="Products"><span>Products</span></a></li>
						<li <cfif attributes.CurrentTab eq "MyAccount">id="pnt-current"</cfif>><a href="CA-Login.cfm?goToPage=CA-CustomerArea.cfm" title="My Account"><span>My Account</span></a></li>	
						<li <cfif attributes.CurrentTab eq "ViewCart">id="pnt-current"</cfif>><a href="CartEdit.cfm" title="View Cart"><span>View Cart</span></a></li>
						<li <cfif attributes.CurrentTab eq "CustomerService">id="pnt-current"</cfif>><a href="ContactUs.cfm" title="Customer Service"><span>Customer Service</span></a></li>
						<li <cfif attributes.CurrentTab eq "AboutUs">id="pnt-current"</cfif>><a href="AboutUs.cfm"  title="About Us"><span>About Us</span></a></li>
						<cfif application.AllowAffiliates eq 1 >
							<li <cfif attributes.CurrentTab eq "Affiliates">id="pnt-current"</cfif>><a href="AF-Main.cfm" title="Affiliate Program"><span>Affiliate Program</span></a></li>
						</cfif>
					</ul>		
				</div>
			</cfif>
			<!--- show primary navigation line? --->
			<cfif not structKeyExists(attributes, 'showPrimaryNavLine')>
				<div id="primaryNavTabsline" class="box grad">
			  		<img src="images/style/grad_white_sm.png" />
					<div id="primarySearch">
						<form name="search" class="search" action="searchResults.cfm" method="post">
							<input type="text" name="string" value="-- search for products --" onfocus="this.value='';" class="searchstring">
							<input type="submit" name="GoSearch" value="SEARCH" class="button smaller green">
							<input type="hidden" name="start" value="1">
							<input type="hidden" name="field" value="ItemAndID">
						</form>
					</div>
				</div>
			</cfif>
		</div>
	</cfif>

	<!--- this page container --->
	<div id="pageContainer">
		
		<!--- show categories? --->
		<cfif not structKeyExists(attributes, 'showCategories')>
		
			<div id="categoryNavContainer-#attributes.LayoutStyle#">
				<div class="first box grad"><img src="images/style/grad_white_sm.png" />Categories</div>
			
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
					<cfloop query="getMainSections">
						<cfset getSubSections = application.Common.getSections(UserID=UserID, SiteID=application.SiteID,SectionID=getMainSections.SectionID)>
						<h1><a href="ProductList.cfm?SecDisplay=#getMainSections.SectionID#">#getMainSections.SecName#</a></h1>
						<!--- If Query has a record count then show list --->
						<cfif getSubSections.RecordCount>
							<ul class="categories">
								<cfloop query="getSubSections">
									<li><a href="ProductList.cfm?SecDisplay=#getSubSections.SectionID#">#getSubSections.SecName#</a></li>
								</cfloop>
							</ul>
						</cfif>
					</cfloop>
					<!--- End of category list --->
					<br/>
					<div align="center">
						<img src="/images/pic-FreeShipping.png" />
						<br/>
					</div>
					<h3>Information</h3>
					<ul class="categories">
						<li><a href="http://www.trackdragon.com/" target="_blank">Hear from the GPS owner</a></li>
						<li><a href="http://www.greensupply.com/index.cfm" target="_blank">See much more at GreenSupply.com</a></li>
					</ul>
					<br/>
				</div>
				<div class="last box grad"><img src="images/style/grad_white_sm.png" />&nbsp;</div>
				<!--- End categoryNav --->
			</div>
			</cfif><!--- End categoryNavContainer --->		

			<!--- Start Page Content --->
			<div id="pageContent-#attributes.LayoutStyle#">
				
</cfoutput>
<!--- After else is not thisTag.executionMode 'start' --->
<cfelse>
<cfoutput>

			</div><!--- End Page Content --->
		</div><!--- End Page Container --->
		<br class="clear" /><br/><br/>
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
			&copy; #DateFormat(Now(), "yyyy")# #application.CompanyName#, all rights reserved.
			<ul>
				<li><a href="">Home</a></li>
				<li><a href="StorePolicies.cfm">Store Policy</a></li>
				<li><a href="StorePrivacy.cfm">Privacy Policy</a></li>
				<li><a href="StoreDisclaimer.cfm">Disclaimer</a></li>
				<li><a href="StoreHelp.cfm">Ordering Help</a></li>
				<cfif application.AllowAffiliates EQ 1 >
					<li><a href="AF-Login.cfm">Affiliates</a></li>
				</cfif>
				<li><a href="javascript:NewWindow('Suggestions.cfm','Suggestions','475','375','yes');">Make A Suggestion</a></li>
			</ul>
			<br/>
			<br/>
			We Kindly Accept: 
			<cfscript>
				if (application.AllowCreditCards EQ 1){
					if (application.AcceptVISA eq 1)
						WriteOutput("<img src='images/logos/icon-VI.gif' border='0' alt='We Accept VISA' align='absmiddle'>&nbsp;"); 
					if (application.AcceptMC eq 1)
						WriteOutput("<img src='images/logos/icon-MC.gif' border='0' alt='We Accept MasterCard' align='absmiddle'>&nbsp;");
					if (application.AcceptDISC eq 1)
						WriteOutput("<img src='images/logos/icon-DI.gif' border='0' alt='We Accept Discover' align='absmiddle'>&nbsp;");
					if (application.AcceptAMEX eq 1)
						WriteOutput("<img src='images/logos/icon-AE.gif' border='0' alt='We Accept American Express' align='absmiddle'>&nbsp;");
				}
				/*  if (application.AllowECheck eq 1)
					WriteOutput("<img src='images/logos/logo-ECheck.gif' border='0' alt='We Accept E-Checks' align='absmiddle'>&nbsp;"); */
				if (application.AllowPayPal eq 1)
					WriteOutput("<img src='images/logos/logo-PayPal.gif' border='0' alt='We Accept PayPal' align='absmiddle'>");
			</cfscript>

		<cfelse>&nbsp;
		</cfif>
		<br/>
		<br/>
	</div><!--- End Copyright & Links --->

</div>

</body>
</html>
</cfoutput>
</cfif>
</cfprocessingdirective>
<cfsetting enablecfoutputonly=false>