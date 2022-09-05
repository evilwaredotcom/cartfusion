<cfparam name="PageTitle" default="" type="string">
<cfoutput>
<cfif structKeyExists(url,'CatDisplay') AND isDefined('getCategory') >
	<cfif structKeyExists(getCategory,'CatMetaTitle') AND getCategory.CatMetaTitle NEQ '' >
		<title>#getCategory.CatMetaTitle#</title>#Chr(13)##Chr(10)#
	<cfelseif StructKeyExists(getCategory,'CatName') AND getCategory.CatName NEQ '' >
		<title>#application.StoreName#: #getCategory.CatName#</title>#Chr(13)##Chr(10)#
	<cfelse>
		<title>#application.StoreName#</title>#Chr(13)##Chr(10)#
	</cfif>
	<cfif StructKeyExists(getCategory,'CatMetaDescription') AND getCategory.CatMetaDescription NEQ '' >
		#Chr(9)#<meta name="description" content="#getCategory.CatMetaDescription#">#Chr(13)##Chr(10)#
	<cfelseif StructKeyExists(getCategory,'CatName') AND getCategory.CatName NEQ '' >
		#Chr(9)#<meta name="description" content="#getCategory.CatName#">#Chr(13)##Chr(10)#
	<cfelse>
		#Chr(9)#<meta name="description" content="#application.CompanyDescription#">#Chr(13)##Chr(10)#
	</cfif>
	<cfif StructKeyExists(getCategory,'CatMetaKeywords') AND getCategory.CatMetaKeywords NEQ '' >
		#Chr(9)#<meta name="keywords" content="#getCategory.CatMetaKeywords#">#Chr(13)##Chr(10)#
	<cfelseif StructKeyExists(getCategory,'CatName') AND getCategory.CatName NEQ '' >
		#Chr(9)#<meta name="keywords" content="#getCategory.CatName#">#Chr(13)##Chr(10)#
	<cfelse>
		#Chr(9)#<meta name="Keywords" content="#application.CompanyDescription#,#application.StoreName#,#application.StoreNameShort#,#application.DomainName#,#application.CompanyName#">#Chr(13)##Chr(10)#
	</cfif>
	<cfif StructKeyExists(getCategory,'CatMetaKeyphrases') AND getCategory.CatMetaKeyphrases NEQ '' >
		#Chr(9)#<meta name="keyphrases" content="#getCategory.CatMetaKeyphrases#">#Chr(13)##Chr(10)#
	<cfelseif StructKeyExists(getCategory,'CatName') AND getCategory.CatName NEQ '' >
		#Chr(9)#<meta name="keyphrases" content="#getCategory.CatName#">#Chr(13)##Chr(10)#
	<cfelse>
		#Chr(9)#<meta name="keyphrases" content="#application.CompanyDescription#,#application.StoreName#,#application.StoreNameShort#,#application.DomainName#,#application.CompanyName#">#Chr(13)##Chr(10)#
	</cfif>
<cfelseif StructKeyExists(url,'SecDisplay') AND isDefined('getSections') >
	<cfif StructKeyExists(getSection,'SecMetaTitle') AND getSection.SecMetaTitle NEQ '' >
		<title>#getSection.SecMetaTitle#</title>#Chr(13)##Chr(10)#
	<cfelseif StructKeyExists(getSection,'SecName') AND getSection.SecName NEQ '' >
		<title>#application.StoreName#: #getSection.SecName#</title>#Chr(13)##Chr(10)#
	<cfelse>
		<title>#application.StoreName#</title>#Chr(13)##Chr(10)#
	</cfif>
	<cfif StructKeyExists(getSection,'SecMetaDescription') AND getSection.SecMetaDescription NEQ '' >
		#Chr(9)#<meta name="description" content="#getSection.SecMetaDescription#">#Chr(13)##Chr(10)#
	<cfelseif StructKeyExists(getSection,'SecName') AND getSection.SecName NEQ '' >
		#Chr(9)#<meta name="description" content="#getSection.SecName#">#Chr(13)##Chr(10)#
	<cfelse>
		#Chr(9)#<meta name="Description" content="#application.CompanyDescription#">#Chr(13)##Chr(10)#
	</cfif>
	<cfif StructKeyExists(getSection,'SecMetaKeywords') AND getSection.SecMetaKeywords NEQ '' >
		#Chr(9)#<meta name="keywords" content="#getSection.SecMetaKeywords#">#Chr(13)##Chr(10)#
	<cfelseif StructKeyExists(getSection,'SecName') AND getSection.SecName NEQ '' >
		#Chr(9)#<meta name="keywords" content="#getSection.SecName#">#Chr(13)##Chr(10)#
	<cfelse>
		#Chr(9)#<meta name="keywords" content="#application.CompanyDescription#,#application.StoreName#,#application.StoreNameShort#,#application.DomainName#,#application.CompanyName#">#Chr(13)##Chr(10)#
	</cfif>
	<cfif StructKeyExists(getSection,'SecMetaKeyphrases') AND getSection.SecMetaKeyphrases NEQ '' >
		#Chr(9)#<meta name="keyphrases" content="#getSection.SecMetaKeyphrases#">#Chr(13)##Chr(10)#
	<cfelseif StructKeyExists(getSection,'SecName') AND getSection.SecName NEQ '' >
		#Chr(9)#<meta name="keyphrases" content="#getSection.SecName#">#Chr(13)##Chr(10)#
	<cfelse>
		#Chr(9)#<meta name="keyphrases" content="#application.CompanyDescription#,#application.StoreName#,#application.StoreNameShort#,#application.DomainName#,#application.CompanyName#">#Chr(13)##Chr(10)#
	</cfif>
<cfelse>
	<title>#application.StoreName#<cfif isDefined('attributes.PageTitle')>: #attributes.PageTitle#</cfif></title>#Chr(13)##Chr(10)#
	#Chr(9)#<meta name="description" content="#application.CompanyDescription#">#Chr(13)##Chr(10)#
	#Chr(9)#<meta name="Keywords" content="#application.CompanyDescription#,#application.StoreName#,#application.StoreNameShort#,#application.DomainName#,#application.CompanyName#">#Chr(13)##Chr(10)#
	#Chr(9)#<meta name="keyphrases" content="#application.CompanyDescription#,#application.StoreName#,#application.StoreNameShort#,#application.DomainName#,#application.CompanyName#">#Chr(13)##Chr(10)#
</cfif>
<meta name="Author" content="#application.CompanyName# - #application.DomainName#">
<meta http-equiv="Classification" content="CartFusion Site">
<!--- should we expire headers and block web crawlers? --->
<cfif structKeyExists(attributes, 'showExpireHeaders')>
	<!--- Header Info To Stay Logged Out 
	<cfheader name="Expires" value="Tue, 01 Jan 1985 00:00:01 GMT">
	<cfheader name="Pragma" value="no-cache">
	<cfheader name="cache-control" value="no-cache, no-store, must-revalidate">--->
	<meta http-equiv="Expires" content="Tue, 01 Jan 1985 00:00:01 GMT">
	<meta http-equiv="Pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache, no-store, must-revalidate">
	<meta name="ROBOTS" content="NOINDEX, NOFOLLOW">
<cfelse>
	<meta name="revisit-after" content="31 days">
	<meta name="ROBOTS" content="ALL">
	<meta name="GOOGLEBOT" content="INDEX, FOLLOW">
</cfif>
<!---<!-- #application.CompanyDescription# -->--->
</cfoutput>