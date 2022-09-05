
<!---<cfmodule showExpireHeaders	False					
		showHorizontalNav	True					
		showPrimaryNav		True					
		showPrimaryNavLine	True	
		showCategories		True					
		showBreadCrumb 		False	
		showFooter			True	
		showCopyright		True	
>--->
<cfmodule template="templates/#application.SiteTemplate#/layout.cfm" currenttab="AboutUs" pagetitle="About Us">

<!--- Start Breadcrumb --->
<cfmodule template="tags/breadCrumbs.cfm" crumblevel='2' showlinkcrumb="#application.StoreName# | About Us" />
<!--- End BreadCrumb --->

<h3>About Us</h3>

<p>
	<img src="images/image-CompanyLogo.gif" class="right" />
	<cfif application.CompanyDescription NEQ '' >
		<cfoutput>#application.CompanyDescription#</cfoutput>
	<cfelse>
		<!--- PUT "ABOUT US" CONTENT HERE --->
		rotiueriou ertioeur toierut eoritu eroitu eroitu ertiuer oti ertioeru toieru tioerut eoriut eroitu 
		eriot eroit uerotiuer toierutoeru rotiueriou tioerut oiertu rotiueriou eroitu eroitu eroitu rotiueriou 
		eriotu eroitu eroitu eroitu eroitu ertoiuer toieru tioeru toieru toieru teriotu eoriut ioert ueroitu eroitu 
		oeri tuioeru teirurotiueriou ertioeur toierut eoritu eroitu eroitu ertiuer oti ertioeru toieru tioerut eoriut 
		eroitu eriot eroit uerotiuer toierutoeru tioeru tioerut oiertu eroitu eroitu eroitu eroitu eroit eriotu eroitu 
		eroitu eroitu eroitu ertoiuer toieru tioeru toieru toieru teriotu eoriut ioert ueroitu eroitu oeri tuioeru 
		teirurotiueriou ertioeur toierut eoritu eroitu eroitu ertiuer oti ertioeru toieru tioerut eoriut eroitu eriot 
		eroit uerotiuer toierutoeru tioeru tioerut oiertu eroitu eroitu eroitu eroitu eroit eriotu eroitu eroitu eroitu 
		eroitu ertoiuer toieru tioeru toieru toieru teriotu eoriut ioert ueroitu eroitu oeri tuioeru teirurotiueriou 
		ertioeur toierut eoritu eroitu eroitu ertiuer oti ertioeru toieru tioerut eoriut eroitu eriot eroit uerotiuer 
		<a href="">toierutoeru tioeru tioerut oiertu eroitu eroitu</a> eroitu eroitu eroit eriotu eroitu eroitu eroitu 
		eroitu ertoiuer toieru tioeru toieru toieru teriotu eoriut ioert ueroitu eroitu oeri tuioeru teiru
	</cfif>
</p>

<div align="center">
	<br/>
	<br/>
	<hr class="snip" />
	<br/>
	<input type="button" name="GoBack" value="&lt; BACK" class="button2" onclick="javascript:history.back();"> 
	<input type="button" name="GoHome" value="HOME &gt;" class="button2" onclick="javascript:document.location.href='index.cfm';">
</div>

</cfmodule>
