<cfoutput>
<cfscript>
	// If Refresh or Go Back, Delete TEMPWISHLIST Structure
	if ( isDefined('session.TempWishlist') )
		StructDelete(session, 'TempWishlist');
	
	// DEFAULT VARIABLES FOR CFLOCATION AND OPTION CHECKING
	LocateToURL = 0;
	OptionNeeded = 0;
	
	/*		 ADD TO CART		  */
	if ( isDefined('Form.AddToCart') OR isDefined('Form.AddToWishlist') )
	{	
		if ( NOT isDefined('Form.OptionName1') AND NOT isDefined('Form.OptionName2') AND NOT isDefined('Form.OptionName3') ) 
			LocateToURL = 1;
		else
		{
			if ( isDefined('Form.OptionName1') )
			{
				if ( Form.OptionName1 EQ '' AND Form.Option1Optional EQ 0 ) OptionNeeded = 1;
				else LocateToURL = 1;
			} 
			if ( isDefined('Form.OptionName2') )
			{
				if ( Form.OptionName2 EQ '' AND Form.Option2Optional EQ 0 ) OptionNeeded = 1;
				else LocateToURL = 1;
			} 
			if ( isDefined('Form.OptionName3') )
			{
				if ( Form.OptionName3 EQ '' AND Form.Option3Optional EQ 0 ) OptionNeeded = 1;
				else LocateToURL = 1;
			}
			if ( OptionNeeded EQ 1 )
			{
				ErrorMsg = 'Please select your options before proceeding' ;
				LocateToURL = 0;
			}
		}
	}
				
	/*		 ADD TO WISHLIST		  */ 
	if ( isDefined('Form.AddToWishlist') ) 
	{
		if ( OptionNeeded EQ 1 )
		{
			ErrorMsg = "Please select your options before proceeding." ;
			LocateToURL = 0;
		} else {
			// BEGIN: STRUCT
			session.TempWishlist = StructNew();
			session.TempWishlist.ItemID = form.ItemID;
			session.TempWishlist.Quantity = form.Quantity;
			if (isDefined('Form.OptionName1') AND Form.OptionName1 NEQ '') session.TempWishlist.OptionName1 = form.OptionName1;
			if (isDefined('Form.OptionName2') AND Form.OptionName2 NEQ '') session.TempWishlist.OptionName2 = form.OptionName2;
			if (isDefined('Form.OptionName3') AND Form.OptionName3 NEQ '') session.TempWishlist.OptionName3 = form.OptionName3;
			// END: STRUCT
			
			if ( session.CustomerArray[17] EQ '' ) LocateToURL = 3;
			else LocateToURL = 4;
		}
	}		
</cfscript>

<!--- IN CASE OF ERROR, LOCATE TO SPECIFIED URL --->
<cfswitch expression="#LocateToURL#">
	<cfcase value="1">
		<cfscript>
			LocateToThisURL = "CartUpdate.cfm?Quantity=" & #form.Quantity# & "&ItemID=" & #Form.ItemID# ;
			if ( isDefined('Form.OptionName1') AND Form.OptionName1 NEQ '' )
				LocateToThisURL = LocateToThisURL & "&OptionName1=" & #URLEncodedFormat(Form.OptionName1)#;
			if ( isDefined('Form.OptionName2') AND Form.OptionName2 NEQ '' )
				LocateToThisURL = LocateToThisURL & "&OptionName2=" & #URLEncodedFormat(Form.OptionName2)#;
			if ( isDefined('Form.OptionName3') AND Form.OptionName3 NEQ '' )
				LocateToThisURL = LocateToThisURL & "&OptionName3=" & #URLEncodedFormat(Form.OptionName3)#;
			if ( isDefined('Form.BackOrdered') AND Form.BackOrdered EQ 1 )
				LocateToThisURL = LocateToThisURL & "&BackOrdered=1" ;
		</cfscript>
		<cflocation url="#LocateToThisURL#" addtoken="no">
	</cfcase>
	<cfcase value="3">
		<cflocation url="CA-Login.cfm?goToPage=WishUpdate.cfm" addtoken="no">
	</cfcase>
	<cfcase value="4">
		<cflocation url="WishUpdate.cfm" addtoken="no">	
	</cfcase>
</cfswitch>

</cfoutput>

<!--- QUERIES --->
<cftry>
	<!--- Added by Carl Vanderpal - 19 May 2007 --->
	<cfscript>
		getProduct = application.Common.getProductDetail(ItemID=ItemID);
		getCategory = application.Common.getCategoryDetail(CatID=getProduct.Category);
		getProductOptions1 = application.Queries.getProductOptions1(ItemID=ItemID);
		getProductOptions2 = application.Queries.getProductOptions2(ItemID=ItemID);
		getProductOptions3 = application.Queries.getProductOptions3(ItemID=ItemID);
	</cfscript>
	
	
	<cfcatch>
		<cflocation url="index.cfm?PageNotAvailable" addtoken="no">
	</cfcatch>
</cftry>

<cfscript>
	if ( isDefined('getProduct.ItemName') AND getProduct.ItemName NEQ '' )
		PageTitle = getProduct.ItemName ;
	else
		PageTitle = 'Product Detail' ;
	BannerTitle = 'ProductDetail' ;
	/* 
		Old Code
		HideLeftNav = 0 ;
	*/
	if ( Find('Sec',CGI.HTTP_REFERER) OR isDefined('SecDisplay') )
		BreadCrumbs = 12 ;
	else
		BreadCrumbs = 11 ;  // SHOW CATEGORIES BY DEFAULT IN BREADCRUMBS
</cfscript>

<cfoutput>
<cfmodule template="templates/#application.SiteTemplate#/layout.cfm" currenttab="Products" pagetitle="#PageTitle#">

	<!--- Start Breadcrumb --->
		<cfmodule template="tags/breadCrumbs.cfm" crumblevel='2' />
	<!--- End BreadCrumb --->

	<cfif getCategory.CatBanner NEQ '' AND getCategory.CatImageDir NEQ ''>
		<img src="images/#getCategory.CatImageDir#/#getCategory.CatBanner#" align="absmiddle">
	<cfelse>
		<cfoutput><strong>#getCategory.CatName#</strong></cfoutput>
	</cfif>


	<!--- Start Product Display --->
		<cfmodule template="tags/productDisplay.cfm" />
	<!--- End Product Display --->


	<div align="center">
		<br/>
		<hr class="snip" />
		<br/>
		<input type="button" name="GoBack" value="&lt; BACK" class="button2" onclick="javascript:history.back();"> 
		<input type="button" name="GoHome" value="HOME &gt;" class="button2" onclick="javascript:document.location.href='index.cfm';">
	</div>

</cfmodule>
</cfoutput>
