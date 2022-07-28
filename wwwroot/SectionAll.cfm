<cfmodule template="tags/layout.cfm" CurrentTab="Products" PageTitle="All Sections">

<!--- Start Breadcrumb --->
<cfmodule template="tags/breadCrumbs.cfm" CrumbLevel='1' showLinkCrumb="All Departments" />
<!--- End BreadCrumb --->

	<cfinclude Template="MainSectionList.cfm">

</cfmodule>
