<!--- 
|| MIT LICENSE
|| CartFusion.com
--->


<cfmodule template="templates/#application.SiteTemplate#/layout.cfm" currenttab="Home" pagetitle="Store Home">


	<!--- SHOW CUSTOM BANNER --->
	<!--- <div align="left" style="margin:0px; padding:0px;">
		<a href="http://www.tradestudios.com" target="_blank"><img src="images/home-CartFusion5.jpg" border="0" alt=""></a><br>
		<img src="images/spacer.gif" width="1" height="10"><br>
	</div> --->
	
	<!--- SHOW FEATURED PRODUCTS --->
	<cfinclude template="Includes/ProductsFeatured.cfm">
	
	<!--- SHOW FEATURED CATEGORIES --->
	<cfinclude template="Includes/CategoriesFeatured.cfm">
	
	<!--- SHOW FEATURED SECTIONS --->
	<cfinclude template="Includes/SectionsFeatured.cfm">
	
	<!--- SHOW CUSTOM BANNER --->
	<!--- <div align="left" style="margin:0px; padding:0px;">
		<a href="http://www.tradestudios.com" target="_blank"><img src="images/home-CartFusion4.jpg" border="0" alt=""></a>
	</div> --->
	
	
	
	<!--- SHOW SHORT STORE NAME ---
	<font class="cfHomeHeading">#application.StoreNameShort#</font><br>
	--->
	
	<!--- SHOW COMPANY DESCRIPTION ---
	#application.CompanyDescription#<br><br>
	--->
	
	<!--- SHOW MAIN CATEGORIES ---
	<cfinclude TEMPLATE="MainCategoryList.cfm">
	--->

</cfmodule>
