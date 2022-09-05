<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<font class="cfDefault">
<cfoutput>
<cfif StartRowBack GT 0><a href="#CGI.SCRIPT_NAME#?StartRow=#StartRowBack#&SortOption=#SortOption#&SortAscending=#SortAscending#<cfif isDefined('field')>&field=#field#&string=#string#</cfif><cfif isDefined('URL.CatDisplay')>&CatDisplay=#CatDisplay#<cfelseif isDefined('URL.SecDisplay')>&SecDisplay=#SecDisplay#</cfif><cfif isDefined('URL.CatFilter')>&CatFilter=#CatFilter#<cfelseif isDefined('URL.SecFilter')>&SecFilter=#SecFilter#</cfif><cfif isDefined('SMC') AND SMC NEQ ''>&SMC=#URLEncodedFormat(SMC)#<cfelseif isDefined('SMS') AND SMS NEQ ''>&SMS=#URLEncodedFormat(SMS)#</cfif><cfif isDefined('URL.ShowRows')>&ShowRows=#URL.ShowRows#</cfif>" class="cfDefault">&lt;&lt;</a>&nbsp;</cfif>
<cfif TotalRows GT 0>Page</cfif>
<cfset TotalPages = TotalRows \ RowsPerPage>
<cfset currentPage = ((StartRow - 1) \ RowsPerPage) + 1>
<cfif TotalRows mod RowsPerPage NEQ 0><cfset TotalPages = TotalPages + 1></cfif><!--- Add partial last page --->
<cfif TotalPages GT 10><!--- More than 20 pages of results - determine which links to show --->
   <cfset StartPage = Max(1, currentPage - 5)><!--- Show links for upto 4 pages before current page --->
   <cfset EndPage = Min(StartPage + 9, TotalPages)>
<cfelse>
   <cfset StartPage = 1>
   <cfset EndPage = TotalPages>
</cfif>
<cfif StartPage GT 1><a href="#CGI.SCRIPT_NAME#?StartRow=1&SortOption=#SortOption#&SortAscending=#SortAscending#<cfif isDefined('field')>&field=#field#&string=#string#</cfif><cfif isDefined('URL.CatDisplay')>&CatDisplay=#CatDisplay#<cfelseif isDefined('URL.SecDisplay')>&SecDisplay=#SecDisplay#</cfif><cfif isDefined('URL.CatFilter')>&CatFilter=#CatFilter#<cfelseif isDefined('URL.SecFilter')>&SecFilter=#SecFilter#</cfif><cfif isDefined('SMC') AND SMC NEQ ''>&SMC=#URLEncodedFormat(SMC)#<cfelseif isDefined('SMS') AND SMS NEQ ''>&SMS=#URLEncodedFormat(SMS)#</cfif><cfif isDefined('URL.ShowRows')>&ShowRows=#URL.ShowRows#</cfif>" class="cfDefault">1...</a></cfif>
<cfloop index="Pagenum" from="#StartPage#" to="#EndPage#">
   <!--- If Pagenum is current page then show without link --->
   <cfif Pagenum EQ currentPage>
		&nbsp;<b>#Pagenum#</b>
   <cfelse>
		<cfset Row = ((Pagenum - 1) * RowsPerPage) + 1>
		&nbsp;<a href="#CGI.SCRIPT_NAME#?StartRow=#Row#&SortOption=#SortOption#&SortAscending=#SortAscending#<cfif isDefined('field')>&field=#field#&string=#string#</cfif><cfif isDefined('URL.CatDisplay')>&CatDisplay=#CatDisplay#<cfelseif isDefined('URL.SecDisplay')>&SecDisplay=#SecDisplay#</cfif><cfif isDefined('URL.CatFilter')>&CatFilter=#CatFilter#<cfelseif isDefined('URL.SecFilter')>&SecFilter=#SecFilter#</cfif><cfif isDefined('SMC') AND SMC NEQ ''>&SMC=#URLEncodedFormat(SMC)#<cfelseif isDefined('SMS') AND SMS NEQ ''>&SMS=#URLEncodedFormat(SMS)#</cfif><cfif isDefined('URL.ShowRows')>&ShowRows=#URL.ShowRows#</cfif>" class="cfDefault">#Pagenum#</a>
   </cfif>
</cfloop>
<cfif EndPage LT TotalPages><a href="#CGI.SCRIPT_NAME#?StartRow=#Val(TotalRows-RowsPerPage+1)#&SortOption=#SortOption#&SortAscending=#SortAscending#<cfif isDefined('field')>&field=#field#&string=#string#</cfif><cfif isDefined('URL.CatDisplay')>&CatDisplay=#CatDisplay#<cfelseif isDefined('URL.SecDisplay')>&SecDisplay=#SecDisplay#</cfif><cfif isDefined('URL.CatFilter')>&CatFilter=#CatFilter#<cfelseif isDefined('URL.SecFilter')>&SecFilter=#SecFilter#</cfif><cfif isDefined('SMC') AND SMC NEQ ''>&SMC=#URLEncodedFormat(SMC)#<cfelseif isDefined('SMS') AND SMS NEQ ''>&SMS=#URLEncodedFormat(SMS)#</cfif><cfif isDefined('URL.ShowRows')>&ShowRows=#URL.ShowRows#</cfif>" class="cfDefault">...#TotalPages#</a></cfif>
<cfif StartRowNext LTE TotalRows>&nbsp;<a href="#CGI.SCRIPT_NAME#?StartRow=#StartRowNext#&SortOption=#SortOption#&SortAscending=#SortAscending#<cfif isDefined('field')>&field=#field#&string=#string#</cfif><cfif isDefined('URL.CatDisplay')>&CatDisplay=#CatDisplay#<cfelseif isDefined('URL.SecDisplay')>&SecDisplay=#SecDisplay#</cfif><cfif isDefined('URL.CatFilter')>&CatFilter=#CatFilter#<cfelseif isDefined('URL.SecFilter')>&SecFilter=#SecFilter#</cfif><cfif isDefined('SMC') AND SMC NEQ ''>&SMC=#URLEncodedFormat(SMC)#<cfelseif isDefined('SMS') AND SMS NEQ ''>&SMS=#URLEncodedFormat(SMS)#</cfif><cfif isDefined('URL.ShowRows')>&ShowRows=#URL.ShowRows#</cfif>" class="cfDefault">&gt;&gt;</a></cfif>
</cfoutput>
</font>