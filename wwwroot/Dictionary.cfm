<cfoutput>
<cfmodule template="tags/layout.cfm" CurrentTab="Home" PageTitle="Dictionary">

<!--- Start Breadcrumb --->
<cfmodule template="tags/breadCrumbs.cfm" CrumbLevel='1' showLinkCrumb="Dictionary" />
<!--- End BreadCrumb --->

<!--- <img src="#application.RootUrl#/images/logos/logo-CompanyLogo.jpg"><br>
<img src="#application.RootUrl#/images/spacer.gif" height="7" width="1"><br> --->

<table width="100%" cellpadding="3" cellspacing="0" border="0">
<form name="Dictionary" method="post" action="Dictionary.cfm">
	<tr>
		<td class="cfFormLabel" colspan="2">
			Search Term: 
				<input type="text" name="SearchTerm" size="15" class="cfFormField" align="absmiddle" 
				<cfif isDefined('Form.SearchTerm') AND Form.SearchTerm NEQ ''>
					value="#form.SearchTerm#"
				</cfif>
				>&nbsp;&nbsp;
			Look in Definition? 
				<input type="checkbox" name="SearchFilter" value="Def" align="absmiddle"
				<cfif isDefined('Form.SearchFilter') AND Form.SearchFilter EQ 'Def'>
					checked
				</cfif>
				>
			<input type="submit" value="GO" size="10" class="button" align="absmiddle">
		</td>
	</tr>
</form>
</table>

<cfif structKeyExists(form, 'SearchTerm') AND form.SearchTerm NEQ ''>
	
	<cfquery name="getTerm" datasource="#application.dsn#">
		SELECT	Term, Definition
		FROM	Dictionary
		WHERE	Term LIKE '%#Form.SearchTerm#%'
		OR		Keywords LIKE '%#form.SearchTerm#%'
		<cfif isDefined('Form.SearchFilter') AND Form.SearchFilter EQ 'Def'>
		OR		Definition LIKE '%#Form.SearchTerm#%'
		</cfif>
		ORDER BY Term
	</cfquery>
	<br />
	<br />
	<cfif getTerm.RecordCount>
	
	<table class="cartLayoutTable">
		<tr>
			<th align="center" width="79">Term</th>
			<th align="center">Definition</th>
		</tr>
		<cfloop query="getTerm">
		<tr class="row#CurrentRow mod 2#">
			<td align="center">#Term#</td>
			<td>#Definition#</td>
		</tr>
		</cfloop>
	</table>
	
	<cfelse>
		<div class="cfErrorMsg">Your search returned 0 results.</div>
	</cfif>
	
</cfif>

</cfmodule>

</cfoutput>