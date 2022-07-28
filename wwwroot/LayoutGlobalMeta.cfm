<cfprocessingdirective suppresswhitespace="yes">

<cfscript>
	config = application.siteconfig.data;
	PageTitle = "";
</cfscript>

	<cfoutput>
	
	<cfif structKeyExists(url,'CatDisplay')>
		<cfif structKeyExists(getCategory,'CatMetaTitle') AND getCategory.CatMetaTitle NEQ '' >
        	<title>#getCategory.CatMetaTitle#</title>#Chr(13)##Chr(10)#
		<cfelseif StructKeyExists(getCategory,'CatName') AND getCategory.CatName NEQ '' >
        	<title>#config.StoreName#: #getCategory.CatName#</title>#Chr(13)##Chr(10)#
		<cfelse>
        	<title>#config.StoreName#</title>#Chr(13)##Chr(10)#
		</cfif>
		
		<cfif StructKeyExists(getCategory,'CatMetaDescription') AND getCategory.CatMetaDescription NEQ '' >
			#Chr(9)#<meta name="description" content="#getCategory.CatMetaDescription#">#Chr(13)##Chr(10)#
		<cfelseif StructKeyExists(getCategory,'CatName') AND getCategory.CatName NEQ '' >
			#Chr(9)#<meta name="description" content="#getCategory.CatName#">#Chr(13)##Chr(10)#
		<cfelse>
        	#Chr(9)#<meta name="description" content="#config.CompanyDescription#">#Chr(13)##Chr(10)#
		</cfif>
		<cfif StructKeyExists(getCategory,'CatMetaKeywords') AND getCategory.CatMetaKeywords NEQ '' >
			#Chr(9)#<meta name="keywords" content="#getCategory.CatMetaKeywords#">#Chr(13)##Chr(10)#
		<cfelseif StructKeyExists(getCategory,'CatName') AND getCategory.CatName NEQ '' >
			#Chr(9)#<meta name="keywords" content="#getCategory.CatName#">#Chr(13)##Chr(10)#
		<cfelse>
            #Chr(9)#<meta name="Keywords" content="#config.CompanyDescription#,#config.StoreName#,#config.StoreNameShort#,#config.DomainName#,#config.CompanyName#">#Chr(13)##Chr(10)#
		</cfif>
		<cfif StructKeyExists(getCategory,'CatMetaKeyphrases') AND getCategory.CatMetaKeyphrases NEQ '' >
			#Chr(9)#<meta name="keyphrases" content="#getCategory.CatMetaKeyphrases#">#Chr(13)##Chr(10)#
		<cfelseif StructKeyExists(getCategory,'CatName') AND getCategory.CatName NEQ '' >
			#Chr(9)#<meta name="keyphrases" content="#getCategory.CatName#">#Chr(13)##Chr(10)#
		<cfelse>
            #Chr(9)#<meta name="keyphrases" content="#config.CompanyDescription#,#config.StoreName#,#config.StoreNameShort#,#config.DomainName#,#config.CompanyName#">#Chr(13)##Chr(10)#
		</cfif>
	
	<cfelseif StructKeyExists(url,'SecDisplay')>
		<cfif StructKeyExists(getSection,'SecMetaTitle') or getSection.SecMetaTitle eq "">
        	<title>#getSection.SecMetaTitle#</title>#Chr(13)##Chr(10)#
		<cfelseif StructKeyExists(getSection,'SecName') AND getSection.SecName NEQ '' >
        	<title>#config.StoreName#: #getSection.SecName#</title>#Chr(13)##Chr(10)#
		<cfelse>
        	<title>#config.StoreName#</title>#Chr(13)##Chr(10)#
		</cfif>
		<cfif StructKeyExists(getSection,'SecMetaDescription') AND getSection.SecMetaDescription NEQ '' >
			#Chr(9)#<meta name="description" content="#getSection.SecMetaDescription#">#Chr(13)##Chr(10)#
		<cfelseif StructKeyExists(getSection,'SecName') AND getSection.SecName NEQ '' >
			#Chr(9)#<meta name="description" content="#getSection.SecName#">#Chr(13)##Chr(10)#
		<cfelse>
        	#Chr(9)#<meta name="Description" content="#config.CompanyDescription#">#Chr(13)##Chr(10)#
		</cfif>
		<cfif StructKeyExists(getSection,'SecMetaKeywords') AND getSection.SecMetaKeywords NEQ '' >
			#Chr(9)#<meta name="keywords" content="#getSection.SecMetaKeywords#">#Chr(13)##Chr(10)#
		<cfelseif StructKeyExists(getSection,'SecName') AND getSection.SecName NEQ '' >
			#Chr(9)#<meta name="keywords" content="#getSection.SecName#">#Chr(13)##Chr(10)#
		<cfelse>
        	#Chr(9)#<meta name="keywords" content="#config.CompanyDescription#,#config.StoreName#,#config.StoreNameShort#,#config.DomainName#,#config.CompanyName#">#Chr(13)##Chr(10)#
		</cfif>
		<cfif StructKeyExists(getSection,'SecMetaKeyphrases') AND getSection.SecMetaKeyphrases NEQ '' >
			#Chr(9)#<meta name="keyphrases" content="#getSection.SecMetaKeyphrases#">#Chr(13)##Chr(10)#
		<cfelseif StructKeyExists(getSection,'SecName') AND getSection.SecName NEQ '' >
			#Chr(9)#<meta name="keyphrases" content="#getSection.SecName#">#Chr(13)##Chr(10)#
		<cfelse>
            #Chr(9)#<meta name="keyphrases" content="#config.CompanyDescription#,#config.StoreName#,#config.StoreNameShort#,#config.DomainName#,#config.CompanyName#">#Chr(13)##Chr(10)#
		</cfif>
	<cfelse>
		<title>#config.StoreName#<cfif isDefined('attributes.PageTitle')>: #attributes.PageTitle#</cfif></title>#Chr(13)##Chr(10)#
		#Chr(9)#<meta name="description" content="#config.CompanyDescription#">#Chr(13)##Chr(10)#
		#Chr(9)#<meta name="Keywords" content="#config.CompanyDescription#,#config.StoreName#,#config.StoreNameShort#,#config.DomainName#,#config.CompanyName#">#Chr(13)##Chr(10)#
		#Chr(9)#<meta name="keyphrases" content="#config.CompanyDescription#,#config.StoreName#,#config.StoreNameShort#,#config.DomainName#,#config.CompanyName#">#Chr(13)##Chr(10)#
	</cfif>
	<meta name="Author" content="#config.CompanyName# - #config.DomainName#">
	<meta name="robots" content="index,follow">
	<meta http-equiv="Classification" content="CartFusion Site">
	<meta name="revisit-after" content="31 days">
	<meta name="ROBOTS" content="ALL" />
	<meta name="GOOGLEBOT" content="INDEX, FOLLOW" />
	<!--
	#config.CompanyDescription#
	-->
	</cfoutput>
</cfprocessingdirective>