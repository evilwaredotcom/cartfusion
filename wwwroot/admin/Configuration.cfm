<cfscript>
	if ( IsDefined("Form.SelectSiteID") ) application.SiteID = Form.SelectSiteID ;
	else if ( IsDefined("form.SiteID") )  application.SiteID = Form.SiteID ;
	else application.SiteID = 1 ;
</cfscript>

<!--- BEGIN: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->
<cfif isDefined('form.UpdateConfigInfo') AND IsDefined("form.SiteID")>
	<cfif IsUserInRole('Administrator')>
		
		<!--- SET ALL BINARY DEFAULTS --->
		<cfscript>
			// SYSTEM 
			if ( isDefined('Form.EnableSSL') AND Form.EnableSSL EQ 'on' ) Form.EnableSSL = 1 ; else Form.EnableSSL = 0 ;
			// PAYMENT
			if ( isDefined('Form.AllowOrderForm') AND Form.AllowOrderForm EQ 'on' ) Form.AllowOrderForm = 1 ; else Form.AllowOrderForm = 0 ;
			if ( isDefined('Form.AllowStoreCredit') AND Form.AllowStoreCredit EQ 'on' ) Form.AllowStoreCredit = 1 ; else Form.AllowStoreCredit = 0 ;
			if ( isDefined('Form.AllowECheck') AND Form.AllowECheck EQ 'on' ) Form.AllowECheck = 1 ; else Form.AllowECheck = 0 ;
			if ( isDefined('Form.AllowPayPal') AND Form.AllowPayPal EQ 'on' ) Form.AllowPayPal = 1 ; else Form.AllowPayPal = 0 ;
			if ( isDefined('Form.AllowCreditCards') AND Form.AllowCreditCards EQ 'on' ) Form.AllowCreditCards = 1 ; else Form.AllowCreditCards = 0 ;
			if ( isDefined('Form.AcceptVISA') AND Form.AcceptVISA EQ 'on' ) Form.AcceptVISA = 1 ; else Form.AcceptVISA = 0 ;
			if ( isDefined('Form.AcceptMC') AND Form.AcceptMC EQ 'on' ) Form.AcceptMC = 1 ; else Form.AcceptMC = 0 ;
			if ( isDefined('Form.AcceptAMEX') AND Form.AcceptAMEX EQ 'on' ) Form.AcceptAMEX = 1 ; else Form.AcceptAMEX = 0 ;
			if ( isDefined('Form.AcceptDISC') AND Form.AcceptDISC EQ 'on' ) Form.AcceptDISC = 1 ; else Form.AcceptDISC = 0 ;
			// SHIPPING
			if ( isDefined('Form.CheckZipCode') AND Form.CheckZipCode EQ 'on' ) Form.CheckZipCode = 1 ; else Form.CheckZipCode = 0 ;
			if ( isDefined('Form.UseUSPS') ) { if ( Form.UseUSPS EQ 'on' OR Form.UseUSPS EQ 1 ) Form.UseUSPS = 1 ; else Form.UseUSPS = 0 ; } else Form.UseUSPS = 0 ;
			if ( isDefined('Form.UseFEDEX') ) { if ( Form.UseFEDEX EQ 'on' OR Form.UseFEDEX EQ 1 ) Form.UseFEDEX = 1 ; else Form.UseFEDEX = 0 ; } else Form.UseFEDEX = 0 ;
			if ( isDefined('Form.UseUPS') ) { if ( Form.UseUPS EQ 'on' OR Form.UseUPS EQ 1 ) Form.UseUPS = 1 ; else Form.UseUPS = 0 ; } else Form.UseUPS = 0 ;
			if ( isDefined('Form.EnableMultiShip') AND Form.EnableMultiShip EQ 'on' ) Form.EnableMultiShip = 1 ; else Form.EnableMultiShip = 0 ;
			// TAX
			if ( isDefined('Form.UseFlatTaxRate') AND Form.UseFlatTaxRate EQ 'on' ) Form.UseFlatTaxRate = 1 ; else Form.UseFlatTaxRate = 0 ;
			// INTERNATIONAL
			if ( isDefined('Form.AcceptIntOrders') AND Form.AcceptIntOrders EQ 'on' ) Form.AcceptIntOrders = 1 ; else Form.AcceptIntOrders = 0 ;
			if ( isDefined('Form.AcceptIntShipment') AND Form.AcceptIntShipment EQ 'on' ) Form.AcceptIntShipment = 1 ; else Form.AcceptIntShipment = 0 ;
			if ( isDefined('Form.IntTaxCharge') AND Form.IntTaxCharge EQ 'on' ) Form.IntTaxCharge = 1 ; else Form.IntTaxCharge = 0 ;
			// MISC
			if ( isDefined('Form.EmailInvoiceToCustomer') AND Form.EmailInvoiceToCustomer EQ 'on' ) Form.EmailInvoiceToCustomer = 1 ; else Form.EmailInvoiceToCustomer = 0 ;
			if ( isDefined('Form.EnableCustLogin') AND Form.EnableCustLogin EQ 'on' ) Form.EnableCustLogin = 1 ; else Form.EnableCustLogin = 0 ;
			if ( isDefined('Form.EnableRelated') AND Form.EnableRelated EQ 'on' ) Form.EnableRelated = 1 ; else Form.EnableRelated = 0 ;
			if ( isDefined('Form.UseBreadcrumbs') AND Form.UseBreadcrumbs EQ 'on' ) Form.UseBreadcrumbs = 1 ; else Form.UseBreadcrumbs = 0 ;
			// AFFILIATES
			if ( isDefined('Form.AllowAffiliates') AND Form.AllowAffiliates EQ 'on' ) Form.AllowAffiliates = 1 ; else Form.AllowAffiliates = 0 ;
			if ( isDefined('Form.AffiliateToCustomer') AND Form.AffiliateToCustomer EQ 'on' ) Form.AffiliateToCustomer = 1 ; else Form.AffiliateToCustomer = 0 ;
			// HIDDEN BINARY
			if ( isDefined('Form.AddTaxToProdPrice') AND Form.AddTaxToProdPrice EQ 'on' ) Form.AddTaxToProdPrice = 1 ; else Form.AddTaxToProdPrice = 0 ;
			if ( isDefined('Form.DBIsMySQL') AND Form.DBIsMySQL EQ 'on' ) Form.DBIsMySQL = 1 ; else Form.DBIsMySQL = 0 ;
			// HIDDEN VALUES
			if ( NOT isDefined('Form.BaseCountry') ) Form.BaseCountry = 'US' ;			
			
			/*
			if ( isDefined('Form.') AND Form. EQ 'on' ) Form. = 1 ; else Form. = 0 ;
			*/
				
			Form.DateUpdated = Now() ;
			Form.UpdatedBy = GetAuthUser() ;
		</cfscript>
		
		<cftry>
			<cfupdate datasource="#application.dsn#" tablename="config" 
				formfields="SiteID, StoreName, StoreNameShort, CompanyName, CompanyAddress1, CompanyAddress2, CompanyCity, CompanyState, CompanyZip, 
				CompanyCountry, CompanyPhone, CompanyAltPhone, CompanyFax, EmailInfo, EmailSales, EmailSupport, CompanyDescription, DateOfInception, 
				DomainName, RootURL, EnableSSL, SSL_Path, ImagePathURL, IU_VirtualPathDIR, IU_URLDir, DocsDirectory, AppDirectory, MailServer, NotifyEmail, 
				DBIsMySQL, HandlingFee, HandlingType, BaseCountry, DefaultOriginZipcode, BeginZiptoAccept, EndZiptoAccept, CheckZipCode, ShipBy, UseFedEx, 
				UseUPS, UseUSPS, PaymentSystem,
				AllowOrderForm, AllowStoreCredit, AllowECheck, AllowPayPal, AllowCreditCards, AcceptVISA, AcceptMC, AcceptAMEX, AcceptDISC, 
				EmailInvoiceToCustomer, EnableCustLogin, EnableMultiShip, EnableRelated, AllowAffiliates, AffiliateToCustomer, UseFlatTaxRate, FlatTaxRate, 
				AddTaxToProdPrice, AcceptIntOrders, AcceptIntShipment, IntTaxCharge, DateUpdated, UpdatedBy, TaxID, UseBreadCrumbs, 
				StatsURL, ShippingNotes, ShowCreditCard, SaveCreditCard">
			
			<cfquery name="updateCreditCards" datasource="#application.dsn#">
				UPDATE	Payment
				SET		Allow = <cfqueryparam value="#Form.AcceptAMEX#" cfsqltype="cf_sql_bit">
				WHERE	Type = 'AE'
				
				UPDATE	Payment
				SET		Allow =  <cfqueryparam value="#Form.AcceptDISC#" cfsqltype="cf_sql_bit">
				WHERE	Type = 'DI'
				
				UPDATE	Payment
				SET		Allow =  <cfqueryparam value="#Form.AcceptMC#" cfsqltype="cf_sql_bit">
				WHERE	Type = 'MC'
				
				UPDATE	Payment
				SET		Allow =  <cfqueryparam value="#Form.AcceptVISA#" cfsqltype="cf_sql_bit">
				WHERE	Type = 'VI'
			</cfquery>
			
			<cfset AdminMsg = 'System Configuration Updated Successfully' >
			
			<cfcatch>
				<cfset AdminMsg = 'FAIL: System Configuration NOT Updated - #cfcatch.Message#' >
			</cfcatch>
		</cftry>
	<cfelse>			
		<SCRIPT LANGUAGE="JavaScript">
			{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
		</SCRIPT>
	</cfif>
</cfif>
<!--- END: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<!--- BEGIN: QUERIES ------------------------------------------------------------->
<!--- RE-QUERY config --->
<cfquery name="config" datasource="#application.dsn#" cachedwithin="#CreateTimeSpan(-7,0,0,0)#">
	SELECT 	*
	FROM	Config
	WHERE	SiteID = #application.SiteID#
</cfquery>
<!--- RE-QUERY config --->
<cfinvoke component="#application.Queries#" method="getSites" returnvariable="getSites"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getOrderStatusCodes" returnvariable="getOrderStatusCodes"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getBillingStatusCodes" returnvariable="getBillingStatusCodes"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getOrderItemsStatusCodes" returnvariable="getOrderItemsStatusCodes"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getPaymentSystems" returnvariable="getPaymentSystems"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getPaymentTypes" returnvariable="getPaymentTypes"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getStates" returnvariable="getStates"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getCountries" returnvariable="getCountries"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getCurrencies" returnvariable="getCurrencies"></cfinvoke>
<!--- END: QUERIES ------------------------------------------------------------->

<cfscript>
	PageTitle = 'SITE CONFIGURATION';
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">

<style>
	.popstyle{
		visibility:hidden;
		position:absolute;
		background-color:silver;
		border : 3px ridge Blue;
		padding : 5px;
	}
</style>

<table border="0" cellpadding="7" cellspacing="0" width="100%">
	<tr>
		<cfform action="Configuration.cfm" method="post">
			<td width="30%" class="cfAdminDefault">
				SiteID: <cfselect query="getSites" name="SelectSiteID" size="1" value="SiteID" display="SiteName" selected="#application.SiteID#" class="cfAdminDefault" onChange="this.form.submit();" />
			</td>
			<td width="70%" class="cfAdminLink" align="right">
				<img src="images/image-commentpic.gif" align="absmiddle">&nbsp; You must click the UPDATE CHANGES button for any changes to take effect.
			</td>
		</cfform>
	</tr>
</table>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<cfoutput query="config">
<cfform action="Configuration.cfm" method="post">
	<tr style="background-color:##65ADF1;">
		<td width="40%" colspan="2" height="20" class="cfAdminHeader1">&nbsp; COMPANY INFORMATION</b></td>
		<td width="1%" rowspan="20" style="background-color:##FFFFFF;">&nbsp;</td>
		<td width="59%" colspan="2" class="cfAdminHeader1">&nbsp; SYSTEM CONFIGURATION</td>		
	</tr>
	<tr>
		<td colspan="4" height="5"><img src="images/spacer.gif" width="1" height="5"></td>
	</tr>
	<tr>
		<td width="15%">Store Name (full):</td>
		<td width="25%"><cfinput type="text" name="StoreName" value="#StoreName#" size="30" class="cfAdminDefault" required="yes"></td>
		<td width="20%">Domain Name:</td>
		<td width="40%"><cfinput type="text" name="DomainName" value="#DomainName#" size="50" class="cfAdminDefault" required="yes"></td>
	</tr>
	<tr>
		<td>Store Name (short):</td>
		<td><cfinput type="text" name="StoreNameShort" value="#StoreNameShort#" size="30" class="cfAdminDefault" required="yes"></td>
		<td>Root URL:</td>
		<td><cfinput type="text" name="RootURL" value="#RootURL#" size="50" class="cfAdminDefault" required="yes"></td>
	</tr>
	<tr>
		<td>Company Name:</td>
		<td><cfinput type="text" name="CompanyName" value="#CompanyName#" size="30" class="cfAdminDefault" required="yes"></td>
		<td>Enable SSL Path:</td>
		<td><input type="checkbox" name="EnableSSL" <cfif application.EnableSSL EQ 1> checked </cfif> ></td>
	</tr>
	<tr>
		<td>Address 1:</td>
		<td><cfinput type="text" name="CompanyAddress1" value="#CompanyAddress1#" size="30" class="cfAdminDefault" required="yes"></td>
		<td>SSL Path URL:</td>
		<td><cfinput type="text" name="SSL_Path" value="#SSL_Path#" size="50" class="cfAdminDefault" required="no"></td>		
	</tr>
	<tr>
		<td>Address 2:</td>
		<td><cfinput type="text" name="CompanyAddress2" value="#CompanyAddress2#" size="30" class="cfAdminDefault" required="no"></td>
		<td>Documents Directory URL:</td>
		<td><cfinput type="text" name="DocsDirectory" value="#DocsDirectory#" size="50" class="cfAdminDefault" required="yes"></td>
	</tr>
	<tr>
		<td>City:</td>
		<td><cfinput type="text" name="CompanyCity" value="#CompanyCity#" size="30" class="cfAdminDefault" required="yes"></td>
		<td>Images Directory URL:</td>
		<td><cfinput type="text" name="ImagePathURL" value="#ImagePathURL#" size="50" class="cfAdminDefault" required="yes"></td>
	</tr>
	<tr>
		<td>State:</td>
		<td><cfselect query="getStates" name="CompanyState" value="StateCode" display="State" selected="#CompanyState#" size="1" class="cfAdminDefault" /></td>
		<td>Server-Side Image Upload Path:</td>
		<td><cfinput type="text" name="IU_VirtualPathDIR" value="#IU_VirtualPathDIR#" size="50" class="cfAdminDefault" required="yes"></td>
	</tr>
	<tr>
		<td>Zip/Postal:</td>
		<td><cfinput type="text" name="CompanyZip" value="#CompanyZip#" size="30" class="cfAdminDefault" required="yes"></td>
		<td>Image Upload Directory URL:</td>
		<td><cfinput type="text" name="IU_URLDir" value="#IU_URLDir#" size="50" class="cfAdminDefault" required="yes"></td>
	<tr>
		<td>Country:</td>
		<td><cfselect query="getCountries" name="CompanyCountry" value="CountryCode" display="Country" selected="#CompanyCountry#" size="1" class="cfAdminDefault" /></td>
		<td>Outgoing Mail Server:</td>
		<td><cfinput type="text" name="MailServer" value="#MailServer#" size="50" class="cfAdminDefault" required="yes"></td>
	</tr>
	<tr>
		<td>Phone:</td>
		<td><cfinput type="text" name="CompanyPhone" value="#CompanyPhone#" size="30" class="cfAdminDefault" required="yes"></td>
		<td>Order Notification Email:</td>
		<td><cfinput type="text" name="NotifyEmail" value="#NotifyEmail#" size="50" class="cfAdminDefault" required="yes"></td>
	</tr>
	<tr>
		<td>Alt. Phone:</td>
		<td><cfinput type="text" name="CompanyAltPhone" value="#CompanyAltPhone#" size="30" class="cfAdminDefault" required="no"></td>
		<td>Statistics URL:</td>
		<td><cfinput type="text" name="StatsURL" value="#StatsURL#" size="50" class="cfAdminDefault" required="yes"></td>
	</tr>
	<tr>
		<td>Fax:</td>
		<td><cfinput type="text" name="CompanyFax" value="#CompanyFax#" size="30" class="cfAdminDefault" required="no"></td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>Sales Email:</td>
		<td><cfinput type="text" name="EmailSales" value="#EmailSales#" size="30" class="cfAdminDefault" required="yes"></td>
		<td colspan="2" rowspan="4" valign="top">
			Company Description: (shown on homepage and in meta tags)<br>
			<textarea name="CompanyDescription" cols="70" rows="5" class="cfAdminDefault">#CompanyDescription#</textarea>
		</td>
	</tr>
	<tr>
		<td>Support Email:</td>
		<td><cfinput type="text" name="EmailSupport" value="#EmailSupport#" size="30" class="cfAdminDefault" required="yes"></td>
	  </tr>
	<tr>
		<td>Info Email:</td>
		<td><cfinput type="text" name="EmailInfo" value="#EmailInfo#" size="30" class="cfAdminDefault" required="yes"></td>
	</tr>
	<tr>
	  	<td>Date of Inception:</td>
	  	<td><cfinput type="text" name="DateOfInception" value="#DateFormat(DateOfInception, "mm/dd/yy")#" size="30" class="cfAdminDefault" required="yes" validate="date"></td>
	</tr>
</table>

<br>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr style="background-color:##65ADF1;">
		<td width="40%" colspan="2" height="20" class="cfAdminHeader1">&nbsp; PAYMENT CONFIGURATION</b></td>
		<td width="1%" rowspan="20" style="background-color:##FFFFFF;">&nbsp;</td>
		<td width="59%" colspan="2" class="cfAdminHeader1">&nbsp; SHIPPING CONFIGURATION</td>		
	</tr>
	<tr>
		<td colspan="4" height="5"><img src="images/spacer.gif" width="1" height="5"></td>
	</tr>
	<tr>
		<td width="15%">Payment System: </td>
		<td width="25%">
			<cfselect name="PaymentSystem" query="getPaymentSystems" size="1" 
				value="PSID" display="PaymentSystemMessage" selected="#application.PaymentSystem#" class="cfAdminDefault" />
			<cfif PaymentSystem GT 1 AND IsUserInRole('Administrator')><!--- NOT MANUAL --->
				<a href="Config-PaymentSystem.cfm"><img src="images/setupbutton.gif" border="0" align="absmiddle"></a>
			<cfelse>
				<img src="images/setupbutton2.gif" border="0" align="absmiddle">
			</cfif>
		</td>
		<td width="20%">Shipping Origin Zipcode:</td>
		<td width="40%"><cfinput type="text" name="DefaultOriginZipcode" value="#DefaultOriginZipcode#" size="7" class="cfAdminDefault" required="yes"></td>
	</tr>
	<tr>
		<td>Allow Order Form:</td>
		<td>
			<input type="checkbox" name="AllowOrderForm" <cfif application.AllowOrderForm EQ 1> checked </cfif> >
			<img src="images/Logos/logo-ODOrderForm.gif" align="absmiddle" hspace="2">
		</td>
		<td>Zipcodes to Accept:</td>
		<td>
			<cfinput type="text" name="BeginZipToAccept" value="#BeginZipToAccept#" size="7" class="cfAdminDefault" required="yes">
			to
			<cfinput type="text" name="EndZipToAccept" value="#EndZipToAccept#" size="7" class="cfAdminDefault" required="yes">
		</td>
	</tr>
	<tr>
		<td>Allow Customer Credit:</td>
		<td>
			<input type="checkbox" name="AllowStoreCredit" <cfif application.AllowStoreCredit EQ 1> checked </cfif> >
			<img src="images/Logos/logo-StoreCredit.gif" align="absmiddle" hspace="2">
		</td>
		<td>Shipping Method: </td>
		<td>
			<select name="ShipBy" class="cfAdminDefault">
				<option value="3" <cfif ShipBy EQ 3> selected </cfif> >Real-Time Calculations</option>
				<option value="1" <cfif ShipBy EQ 1> selected </cfif> >By Price</option>
				<option value="2" <cfif ShipBy EQ 2> selected </cfif> >By Weight</option>
				<option value="4" <cfif ShipBy EQ 4> selected </cfif> >By Location</option>
				<option value="6" <cfif ShipBy EQ 6> selected </cfif> >Custom Shipping By Price</option>
				<option value="5" <cfif ShipBy EQ 5> selected </cfif> >Custom Shipping By Weight</option>
			</select>
			<cfif IsUserInRole('Administrator')>
				<a href="Config-Shipping.cfm"><img src="images/setupbutton.gif" border="0" align="absmiddle"></a>
			<cfelse>
				<img src="images/setupbutton2.gif" border="0" align="absmiddle">
			</cfif>
		</td>
	</tr>
	<tr>
		<td>Allow PayPal:</td>
		<td>
			<input type="checkbox" name="AllowPayPal" <cfif application.AllowPayPal EQ 1> checked </cfif> >
			<img src="images/Logos/logo-ODPayPal.gif" align="absmiddle" hspace="2">
			<cfif IsUserInRole('Administrator')>
				<a href="Config-PayPal.cfm"><img src="images/setupbutton.gif" border="0" align="absmiddle"></a>
			<cfelse>
				<img src="images/setupbutton2.gif" border="0" align="absmiddle">
			</cfif>
		</td>
		<cfif ShipBy EQ 3>
		<td>Shipping Companies To Use: *</td>
		<td><!-- USPS --><input type="checkbox" name="UseUSPS" <cfif application.UseUSPS EQ 1> checked </cfif> ><img src="images/Logos/logo-configUSPS.gif" align="absmiddle" hspace="2" vspace="2">
			<!-- FEDEX --><input type="checkbox" name="UseFEDEX" <cfif application.UseFEDEX EQ 1> checked </cfif> ><img src="images/Logos/logo-configFedEx.gif" align="absmiddle" hspace="2" vspace="4">
			<!-- UPS --><input type="checkbox" name="UseUPS" <cfif application.UseUPS EQ 1> checked </cfif> ><img src="images/Logos/logo-configUPS.gif" align="absmiddle" hspace="2" vspace="2">
		</td>
		<cfelse>
		<td><font color="##777777">Shipping Companies To Use: *</font></td>
		<td><!-- USPS --><input disabled="disabled" type="checkbox" name="UseUSPS" <cfif application.UseUSPS EQ 1> checked </cfif> ><img src="images/Logos/logo-configUSPS.gif" align="absmiddle" hspace="2" vspace="2">
			<!-- FEDEX --><input disabled="disabled" type="checkbox" name="UseFEDEX" <cfif application.UseFEDEX EQ 1> checked </cfif> ><img src="images/Logos/logo-configFedEx.gif" align="absmiddle" hspace="2" vspace="4">
			<!-- UPS --><input disabled="disabled" type="checkbox" name="UseUPS" <cfif application.UseUPS EQ 1> checked </cfif> ><img src="images/Logos/logo-configUPS.gif" align="absmiddle" hspace="2" vspace="2">
			<input type="hidden" name="UseUSPS" value="#application.UseUSPS#">
			<input type="hidden" name="UseFEDEX" value="#application.UseFEDEX#">
			<input type="hidden" name="UseUPS" value="#application.UseUPS#">
		</td>
		</cfif>
	</tr>
	<tr>
		<td>Allow Credit Cards:</td>
		<td>
			<input type="checkbox" name="AllowCreditCards" <cfif application.AllowCreditCards EQ 1> checked </cfif> >
			<img src="images/Logos/logo-CreditCards.gif" align="absmiddle" hspace="2">
		</td>
		<cfif ShipBy EQ 3>
		<td>Handling Fee: *</td>
		<td>
			<cfinput type="text" name="HandlingFee" value="#DecimalFormat(HandlingFee)#" size="7" class="cfAdminDefault" required="yes" validate="float" message="Please enter a handling fee in 0.00 format, with no $ or % signs">
			<select name="HandlingType" class="cfAdminDefault">
				<option value="1" <cfif application.HandlingType EQ 1> selected </cfif>>% Percentage</option>
				<option value="2" <cfif application.HandlingType EQ 2> selected </cfif>>$ Flat Fee</option>
			</select>
		</td>
		<cfelse>
		<td><font color="##777777">Handling Fee: *</font></td>
		<td>
			<cfinput disabled="disabled" type="text" name="HandlingFee" value="#DecimalFormat(HandlingFee)#" size="7" class="cfAdminDefault" required="yes" validate="float" message="Please enter a handling fee in 0.00 format, with no $ or % signs">
			<select disabled="disabled" name="HandlingType" class="cfAdminDefault">
				<option value="1" <cfif application.HandlingType EQ 1> selected </cfif>>% Percentage</option>
				<option value="2" <cfif application.HandlingType EQ 2> selected </cfif>>$ Flat Fee</option>
			</select>
			<input type="hidden" name="HandlingFee" value="#application.HandlingFee#">
			<input type="hidden" name="HandlingType" value="#application.HandlingType#">
		</td>
		</cfif>
	</tr>
	<tr>
		<td>Accept:</td>
		<td><!-- VISA --><input type="checkbox" name="AcceptVISA" <cfif application.AcceptVISA EQ 1> checked </cfif> ><img src="images/logos/icon-VI.gif" border="0" align="absmiddle" hspace="2">
			<!-- MasterCard --><input type="checkbox" name="AcceptMC" <cfif application.AcceptMC EQ 1> checked </cfif> ><img src="images/logos/icon-MC.gif" border="0" align="absmiddle" hspace="2">
			<!-- American Express --><input type="checkbox" name="AcceptAMEX" <cfif application.AcceptAMEX EQ 1> checked </cfif> ><img src="images/logos/icon-AE.gif" border="0" align="absmiddle" hspace="2">
			<!-- Discover --><input type="checkbox" name="AcceptDISC" <cfif application.AcceptDISC EQ 1> checked </cfif> ><img src="images/logos/icon-DI.gif" border="0" align="absmiddle" hspace="2">
		</td>
		<td colspan="2"><font color="##777777">* For Use With Real-Time Calculations Shipping Method Only</font></td>
	</tr>
	<tr>
		<td>Save Credit Card Info?</td>
		<td><input type="checkbox" name="SaveCreditCard" <cfif application.SaveCreditCard EQ 1> checked </cfif> ></td>
		<td rowspan="2">Allow Multiple Shipping Addresses:</td>
		<td rowspan="2"><input type="checkbox" name="EnableMultiShip" <cfif application.EnableMultiShip EQ 1> checked </cfif> ></td>
	</tr>
	<tr>
		<td>Show Credit Card Info?</td>
		<td><input type="checkbox" name="ShowCreditCard" <cfif application.ShowCreditCard EQ 1> checked </cfif> ></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td colspan="2" rowspan="3" valign="top">
			Shipping Notes: (shown on shipping selection checkout page)<br>
			<textarea name="ShippingNotes" cols="70" rows="3" class="cfAdminDefault">#ShippingNotes#</textarea>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
</table>

<br>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr style="background-color:##65ADF1;">
		<td width="40%" colspan="2" height="20" class="cfAdminHeader1">&nbsp; TAX CONFIGURATION</b></td>
		<td width="1%" rowspan="19" style="background-color:##FFFFFF;">&nbsp;</td>
		<td width="59%" colspan="2" class="cfAdminHeader1">&nbsp; INTERNATIONAL OPTIONS</td>		
	</tr>
	<tr>
		<td colspan="4" height="5"><img src="images/spacer.gif" width="1" height="5"></td>
	</tr>
	<tr>	
		<td width="15%">Use Flat Tax Rate:</td>
		<td width="25%"><input type="checkbox" name="UseFlatTaxRate" <cfif application.UseFlatTaxRate EQ 1> checked </cfif> ></td>	
		<td width="25%">Accept Int'l Charges:</td>
		<td width="35%"><input type="checkbox" name="AcceptIntOrders" <cfif application.AcceptIntOrders EQ 1> checked </cfif> ></td>
	</tr>
	<tr>	
		<td>Flat Tax Rate:</td>
		<td><cfinput type="text" name="FlatTaxRate" value="#DecimalFormat(FlatTaxRate)#" size="7" required="no" class="cfAdminDefault">%</td>	
		<td>Accept Int'l Shipments:</td>
		<td><input type="checkbox" name="AcceptIntShipment" <cfif application.AcceptIntShipment EQ 1> checked </cfif> ></td>
	</tr>
	<tr>	
		<td>Setup Tax Schedule: </td>
		<td>
			<cfif IsUserInRole('Administrator')>
				<a href="Config-Tax.cfm"><img src="images/setupbutton.gif" border="0" align="absmiddle"></a>
			<cfelse>
				<img src="images/setupbutton2.gif" border="0" align="absmiddle">
			</cfif>
		</td>	
		<td>Charge Tax on Int'l Orders:</td>
		<td><input type="checkbox" name="IntTaxCharge" <cfif application.IntTaxCharge EQ 1> checked </cfif> ></td>
	</tr>
	<tr>
		<td colspan="4" height="20"><img src="images/spacer.gif" width="1" height="20"></td>
	</tr>
</table>

<br>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr style="background-color:##65ADF1;">
		<td width="40%" colspan="2" height="20" class="cfAdminHeader1">&nbsp; MISCELLANEOUS SETTINGS</b></td>
		<td width="1%" rowspan="19" style="background-color:##FFFFFF;">&nbsp;</td>
		<td width="59%" colspan="2" class="cfAdminHeader1">&nbsp; AFFILIATE OPTIONS</td>		
	</tr>
	<tr>
		<td colspan="4" height="5"><img src="images/spacer.gif" width="1" height="5"></td>
	</tr>
	<tr>	
		<td width="15%">Email Invoice to Customer: </td>
		<td width="25%"><input type="checkbox" name="EmailInvoiceToCustomer" <cfif application.EmailInvoiceToCustomer EQ 1> checked </cfif> ></td>	
		<td width="25%">Allow Affiliates:</td>
		<td width="35%"><input type="checkbox" name="AllowAffiliates" <cfif application.AllowAffiliates EQ 1> checked </cfif> ></td>
	</tr>
	<tr>	
		<td>Enable Customer Login:</td>
		<td><input type="checkbox" name="EnableCustLogin" <cfif application.EnableCustLogin EQ 1> checked </cfif> ></td>	
		<td>Link Affiliate to Customer: </td>
		<td><input type="checkbox" name="AffiliateToCustomer" <cfif application.AffiliateToCustomer EQ 1> checked </cfif> ></td>
	</tr>
	<tr>	
		<td>Enable Related Items: </td>
		<td><input type="checkbox" name="EnableRelated" <cfif application.EnableRelated EQ 1> checked </cfif> ></td>	
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>	
		<td>Use Breadcrumbs?</td>
		<td><input type="checkbox" name="UseBreadCrumbs" <cfif application.UseBreadCrumbs EQ 1> checked </cfif> ></td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td colspan="4" height="20"><img src="images/spacer.gif" width="1" height="20"></td>
	</tr>
</table>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr style="background-color:##65ADF1;">
		<td colspan="2" width="100%" height="20" class="cfAdminHeader1">&nbsp; CARTFUSION #application.CFVersion#</b></td>
	</tr>
	<tr>
		<td colspan="2" height="5"><img src="images/spacer.gif" width="1" height="5"></td>
	</tr>
	<tr>	
		<td height="20">CartFusion Version:</td>
		<td>#CFVersion#</td>	
	</tr>	
	<tr>	
		<td width="15%" height="20">Last Updated:</td>
		<td width="85%">#DateFormat(DateUpdated, 'mmmm dd yyyy')# @ #TimeFormat(DateUpdated, 'hh:mmtt')#</td>	
	</tr>
	<tr>	
		<td height="20">Last Updated By:</td>
		<td>#UCASE(GetAuthUser())#</td>	
	</tr>
	<tr>
		<td colspan="2" height="5"><img src="images/spacer.gif" width="1" height="5"></td>
	</tr>
</table>

<br>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr style="background-color:##F27028;">
		<td colspan="4" height="20" class="cfAdminHeader3" align="center">
			UPDATE ABOVE INFORMATION
		</td>
	</tr>
	<tr>
		<td colspan="4" height="10"><img src="images/spacer.gif" width="1" height="10"></td>
	</tr>
	<tr>
		<td colspan="4" align="center">
			<input type="submit" name="UpdateConfigInfo" value="UPDATE CHANGES" alt="Update Configuration Changes" class="cfAdminButton"
				onClick="return confirm('Are you sure you want to UPDATE CONFIGURATION with the changes you have made?')">
		</td>
	</tr>
</table>
<br>
<input type="hidden" name="SiteID" value="#SiteID#">	
</cfform>
</cfoutput>

<cfinclude template="LayoutAdminFooter.cfm">