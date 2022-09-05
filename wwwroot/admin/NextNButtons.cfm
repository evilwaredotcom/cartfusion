<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<!--- ONLY SHOW ON BACKORDERS PAGE --->
<cfif NOT findnocase('BackOrders',CGI.SCRIPT_NAME) AND NOT findnocase('DistributorDetail',CGI.SCRIPT_NAME) >
	<cfoutput>
	<cfif StartRowBack GT 0><a href="#CGI.SCRIPT_NAME#?StartRow=#StartRowBack#&SortOption=#SortOption#&SortAscending=#SortAscending#<cfif isDefined('field')>&field=#field#&string=#string#</cfif><cfif isDefined('PageRows')>&PageRows=#PageRows#</cfif><cfif isDefined('Mode')>&Mode=#Mode#</cfif>" class="cfAdminDefault" >&lt;&lt;</a>&nbsp;</cfif>
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
	<cfif StartPage GT 1><a href="#CGI.SCRIPT_NAME#?StartRow=1&SortOption=#SortOption#&SortAscending=#SortAscending#<cfif isDefined('field')>&field=#field#&string=#string#</cfif><cfif isDefined('PageRows')>&PageRows=#PageRows#</cfif><cfif isDefined('Mode')>&Mode=#Mode#</cfif>" class="cfAdminDefault">1...</a></cfif>
	<cfloop index="Pagenum" from="#StartPage#" to="#EndPage#">
	   <!--- If Pagenum is current page then show without link --->
	   <cfif Pagenum EQ currentPage>
			<b>#Pagenum#</b>
	   <cfelse>
			<cfset Row = ((Pagenum - 1) * RowsPerPage) + 1>
			<a href="#CGI.SCRIPT_NAME#?StartRow=#Row#&SortOption=#SortOption#&SortAscending=#SortAscending#<cfif isDefined('field')>&field=#field#&string=#string#</cfif><cfif isDefined('PageRows')>&PageRows=#PageRows#</cfif><cfif isDefined('Mode')>&Mode=#Mode#</cfif>" class="cfAdminDefault">#Pagenum#</a>
	   </cfif>
	</cfloop>
	<cfif EndPage LT TotalPages><a href="#CGI.SCRIPT_NAME#?StartRow=#Val(TotalRows-RowsPerPage+1)#&SortOption=#SortOption#&SortAscending=#SortAscending#<cfif isDefined('field')>&field=#field#&string=#string#</cfif><cfif isDefined('PageRows')>&PageRows=#PageRows#</cfif><cfif isDefined('Mode')>&Mode=#Mode#</cfif>" class="cfAdminDefault">...#TotalPages#</a></cfif>
	<cfif StartRowNext LTE TotalRows>&nbsp;<a href="#CGI.SCRIPT_NAME#?StartRow=#StartRowNext#&SortOption=#SortOption#&SortAscending=#SortAscending#<cfif isDefined('field')>&field=#field#&string=#string#</cfif><cfif isDefined('PageRows')>&PageRows=#PageRows#</cfif><cfif isDefined('Mode')>&Mode=#Mode#</cfif>" class="cfAdminDefault" >&gt;&gt;</a></cfif>
	</cfoutput>

<cfelse><!--- ONLY SHOW ON BACKORDERS PAGE --->
	<cfoutput>
		<a href="#CGI.SCRIPT_NAME#?StartRow=1&SortOption=#SortOption#&SortAscending=#SortAscending#<cfif isDefined('field')>&field=#field#&string=#string#</cfif><cfif isDefined('PageRows')>&PageRows=#PageRows#</cfif><cfif isDefined('DistributorID')>&DistributorID=#DistributorID#</cfif>" class="cfAdminDefault" >
			&lt;&lt; FIRST</a>
	<cfif StartRowBack GT 0>
		<a href="#CGI.SCRIPT_NAME#?StartRow=#StartRowBack#&SortOption=#SortOption#&SortAscending=#SortAscending#<cfif isDefined('field')>&field=#field#&string=#string#</cfif><cfif isDefined('PageRows')>&PageRows=#PageRows#</cfif><cfif isDefined('DistributorID')>&DistributorID=#DistributorID#</cfif>" class="cfAdminDefault" >
			&lt; PREV &lt;</a>
	</cfif>
	<cfif StartRowNext LTE TotalRows>
		<a href="#CGI.SCRIPT_NAME#?StartRow=#StartRowNext#&SortOption=#SortOption#&SortAscending=#SortAscending#<cfif isDefined('field')>&field=#field#&string=#string#</cfif><cfif isDefined('PageRows')>&PageRows=#PageRows#</cfif><cfif isDefined('DistributorID')>&DistributorID=#DistributorID#</cfif>" class="cfAdminDefault" >
			&gt; NEXT &gt;</a>
	</cfif>
	<cfif StartRowNext LTE TotalRows>
		<a href="#CGI.SCRIPT_NAME#?StartRow=#Val(TotalRows-RowsPerPage+1)#&SortOption=#SortOption#&SortAscending=#SortAscending#<cfif isDefined('field')>&field=#field#&string=#string#</cfif><cfif isDefined('PageRows')>&PageRows=#PageRows#</cfif><cfif isDefined('DistributorID')>&DistributorID=#DistributorID#</cfif>" class="cfAdminDefault" >
			LAST &gt;&gt;</a>
	</cfif>
	</cfoutput>
</cfif>

<!--- OLD
<cfoutput>
	<a href="#CGI.SCRIPT_NAME#?StartRow=1&SortOption=#SortOption#&SortAscending=#SortAscending#<cfif isDefined('field')>&field=#field#&string=#string#</cfif><cfif isDefined('PageRows')>&PageRows=#PageRows#</cfif>" class="cfAdminDefault" >
		<img src="images/iconnav-backall.gif" alt="First #RowsPerPage# Records" border="0"></a>
<cfif StartRowBack GT 0>
	<a href="#CGI.SCRIPT_NAME#?StartRow=#StartRowBack#&SortOption=#SortOption#&SortAscending=#SortAscending#<cfif isDefined('field')>&field=#field#&string=#string#</cfif><cfif isDefined('PageRows')>&PageRows=#PageRows#</cfif>" class="cfAdminDefault" >
		<img src="images/iconnav-back1.gif" alt="Previous #RowsPerPage# Records" border="0"></a>
</cfif>
<cfif StartRowNext LTE TotalRows>
	<a href="#CGI.SCRIPT_NAME#?StartRow=#StartRowNext#&SortOption=#SortOption#&SortAscending=#SortAscending#<cfif isDefined('field')>&field=#field#&string=#string#</cfif><cfif isDefined('PageRows')>&PageRows=#PageRows#</cfif>" class="cfAdminDefault" >
		<img src="images/iconnav-next1.gif" alt="Next #RowsPerPage# Records" border="0"></a>
</cfif>
<cfif StartRowNext LTE TotalRows>
	<a href="#CGI.SCRIPT_NAME#?StartRow=#Val(TotalRows-RowsPerPage+1)#&SortOption=#SortOption#&SortAscending=#SortAscending#<cfif isDefined('field')>&field=#field#&string=#string#</cfif><cfif isDefined('PageRows')>&PageRows=#PageRows#</cfif>" class="cfAdminDefault" >
		<img src="images/iconnav-nextall.gif" alt="Last #RowsPerPage# Records" border="0"></a>
</cfif>
</cfoutput>

<!---
&lt;&lt; FIRST
&lt; PREV &lt;
&gt; NEXT &gt;
LAST &gt;&gt;
--->
--->