<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<!--- BEGIN: ERROR CHECKING --->
<!--- ERRORMSG 7 COMES FROM EMAILSEND.cfm, SO IGNORE OTHER ERROR MESSAGES --->
<cfif isDefined('ErrorMsg') AND ErrorMsg EQ 7>
	
<cfelse>
	<cfif NOT isDefined('Form.SearchCriteria')>
		<cfset ErrorMsg = 1>
		<cfinclude template="MC-Send.cfm">
		<cfabort>
	<cfelseif Form.SearchCriteria EQ 'ByCustomer' AND Form.Customer EQ ''>
		<cfset ErrorMsg = 2>
		<cfinclude template="MC-Send.cfm">
		<cfabort>
	<cfelseif Form.SearchCriteria EQ 'ByCriteria'>
		<cfif NOT isDefined('ByOrdAmtLeast') AND NOT isDefined('ByOrdAmtMost') AND NOT isDefined('ByOrdLeast') AND NOT isDefined('ByOrdMost')
			AND NOT isDefined('ByOrdSince') AND NOT isDefined('ByOrdSinceNot') AND NOT isDefined('ByOrdBetween') AND NOT isDefined('ByProd')
			AND NOT isDefined('ByProdNot') AND NOT isDefined('ByCat') AND NOT isDefined('ByCatNot') AND NOT isDefined('ByCity')
			AND NOT isDefined('ByState') AND NOT isDefined('ByCountry') AND NOT isDefined('ByCustomer')>
			<cfset ErrorMsg = 3>
			<cfinclude template="MC-Send.cfm">
			<cfabort>
		<cfelseif isDefined('ByOrdAmtLeast') AND Form.OrdAmtLeast EQ ''>
			<cfset ErrorMsg = 3>
			<cfinclude template="MC-Send.cfm">
			<cfabort>
		<cfelseif isDefined('ByOrdAmtMost') AND Form.OrdAmtMost EQ ''>
			<cfset ErrorMsg = 3>
			<cfinclude template="MC-Send.cfm">
			<cfabort>
		<cfelseif isDefined('ByOrdLeast') AND Form.OrdLeast EQ ''>
			<cfset ErrorMsg = 3>
			<cfinclude template="MC-Send.cfm">
			<cfabort>
		<cfelseif isDefined('ByOrdMost') AND Form.OrdMost EQ ''>
			<cfset ErrorMsg = 3>
			<cfinclude template="MC-Send.cfm">
			<cfabort>
		<cfelseif isDefined('ByOrdSince') AND Form.OrdSince EQ ''>
			<cfset ErrorMsg = 3>
			<cfinclude template="MC-Send.cfm">
			<cfabort>
		<cfelseif isDefined('ByOrdSinceNot') AND Form.OrdSinceNot EQ ''>
			<cfset ErrorMsg = 3>
			<cfinclude template="MC-Send.cfm">
			<cfabort>
		<cfelseif isDefined('ByOrdBetween') AND (Form.OrdFromDate EQ '' OR Form.OrdToDate EQ '')>
			<cfset ErrorMsg = 3>
			<cfinclude template="MC-Send.cfm">
			<cfabort>
		<cfelseif isDefined('ByProd') AND Form.Prod EQ ''>
			<cfset ErrorMsg = 3>
			<cfinclude template="MC-Send.cfm">
			<cfabort>
		<cfelseif isDefined('ByProdNot') AND Form.ProdNot EQ ''>
			<cfset ErrorMsg = 3>
			<cfinclude template="MC-Send.cfm">
			<cfabort>
		<cfelseif isDefined('ByCat') AND Form.Cat EQ ''>
			<cfset ErrorMsg = 3>
			<cfinclude template="MC-Send.cfm">
			<cfabort>
		<cfelseif isDefined('ByCatNot') AND Form.CatNot EQ ''>
			<cfset ErrorMsg = 3>
			<cfinclude template="MC-Send.cfm">
			<cfabort>
		<cfelseif isDefined('ByCity') AND Form.City EQ ''>
			<cfset ErrorMsg = 3>
			<cfinclude template="MC-Send.cfm">
			<cfabort>
		<cfelseif isDefined('ByState') AND Form.State EQ ''>
			<cfset ErrorMsg = 3>
			<cfinclude template="MC-Send.cfm">
			<cfabort>
		<cfelseif isDefined('ByCountry') AND Form.Country EQ ''>
			<cfset ErrorMsg = 3>
			<cfinclude template="MC-Send.cfm">
			<cfabort>
		<cfelseif isDefined('ByIncludeEmails') AND Form.IncludeEmails EQ ''>
			<cfset ErrorMsg = 3>
			<cfinclude template="MC-Send.cfm">
			<cfabort>
		<cfelseif isDefined('ByOrdBetween') AND Form.OrdFromDate GT Form.OrdToDate>
			<cfset ErrorMsg = 5>
			<cfinclude template="MC-Send.cfm">
			<cfabort>
		</cfif>	
	</cfif>
</cfif>
<!--- END: ERROR CHECKING --->
