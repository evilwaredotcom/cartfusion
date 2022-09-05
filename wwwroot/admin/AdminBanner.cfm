<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<cfparam name="Mode" default="0">

<script language="JavaScript">
	function resetBox()
	{ document.QuickSearch.string.value = ""; }
</script>

<cfoutput>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td width="60%" height="20" align="left" class="cfAdminTitle">
			<cfif isDefined('BannerTitle') AND BannerTitle NEQ ''><img src="images/banner-#BannerTitle#.gif">
			<cfelseif isDefined('PageTitle') AND PageTitle NEQ ''>#UCASE(PageTitle)#
			<cfelse>CARTFUSION
			</cfif>
			<cfif isDefined('AdminMsg')>&nbsp; <img src="images/image-Message.gif"> <font class="cfAdminError">#AdminMsg#</font></cfif>
		</td>
		<cfif isDefined('QuickSearch') AND QuickSearch EQ 1 >
			<form name="QuickSearch" action="#QuickSearchPage#" method="GET">
			<td width="40%" align="right">			
				<!--- MODE --->
				<cfif isDefined('ModeAllow')>
					<cfif Mode EQ 0 >
						<input type="button" name="QuickEditMode" value="QUICK EDIT MODE" alt="Edit in Quick Edit Mode" class="cfAdminButton"
							onClick="document.location.href='#CGI.SCRIPT_NAME#?Mode=1<cfif isDefined('StartRow')>&StartRow=#StartRow#</cfif>&SortOption=#SortOption#&SortAscending=#SortAscending#<cfif isDefined('field')>&field=#field#&string=#string#</cfif><cfif isDefined('PageRows')>&PageRows=#PageRows#</cfif>'">
					<cfelseif Mode EQ 1 >
						<input type="button" name="RegularMode" value="REGULAR MODE" alt="View in Regular Mode" class="cfAdminButton"
							onClick="document.location.href='#CGI.SCRIPT_NAME#?Mode=0<cfif isDefined('StartRow')>&StartRow=#StartRow#</cfif>&SortOption=#SortOption#&SortAscending=#SortAscending#<cfif isDefined('field')>&field=#field#&string=#string#</cfif><cfif isDefined('PageRows')>&PageRows=#PageRows#</cfif>'">
					</cfif>
				</cfif>
				
				<cfif isDefined('AddAButton') AND isDefined('AddAButtonLoc') >
					<input type="button" name="AddThisButton" value="#AddAButton#" class="cfAdminButton"
						onClick="document.location.href='#AddAButtonLoc#'">
				</cfif>
				<cfif isDefined('AddPage') AND AddPage NEQ ''>
					<input type="button" name="AddNew" value="ADD" alt="ADD NEW" class="cfAdminButton"
						onClick="document.location.href='#AddPage#'">
				</cfif>
				
					<input type="button" name="Search" value="SEARCH" alt="SEARCH" class="cfAdminButton"
						onClick="document.location.href='Search.cfm'">
					<input type="button" name="Help" value="HELP" alt="CartFusion Help Desk" class="cfAdminButton"
						onClick="document.location.href='http://support.tradestudios.com'">
					<input type="hidden" name="field" value="AllFields">
					<input type="text" name="string" value="- QUICK SEARCH -" size="15" class="cfAdminButton" align="absmiddle" onClick="resetBox();">
					<input type="submit" name="GO" value="GO" class="cfAdminButton">				
			</td>
			</form>
		<cfelse>
			<td width="40%" align="right">	
				<!--- MODE --->
				<cfif isDefined('ModeAllow')>
					<cfif Mode EQ 0 >
						<input type="button" name="QuickEditMode" value="QUICK EDIT MODE" alt="Edit in Quick Edit Mode" class="cfAdminButton"
							onClick="document.location.href='#CGI.SCRIPT_NAME#?Mode=1'">
					<cfelseif Mode EQ 1 >
						<input type="button" name="RegularMode" value="REGULAR MODE" alt="View in Regular Mode" class="cfAdminButton"
							onClick="document.location.href='#CGI.SCRIPT_NAME#?Mode=0'">
					</cfif>
				</cfif>
				
				<cfif isDefined('AddAButton') AND isDefined('AddAButtonLoc') >
					<input type="button" name="AddThisButton" value="#AddAButton#" class="cfAdminButton"
						onClick="document.location.href='#AddAButtonLoc#'">
				</cfif>		
				<cfif isDefined('AddPage') AND AddPage NEQ ''>
					<input type="button" name="AddNew" value="ADD" alt="ADD NEW" class="cfAdminButton"
						onClick="document.location.href='#AddPage#'">
				</cfif>
					<input type="button" name="Search" value="SEARCH" alt="SEARCH" class="cfAdminButton"
						onClick="document.location.href='Search.cfm'">
					<input type="button" name="Help" value="HELP" alt="CartFusion Help Desk" class="cfAdminButton"
						onClick="document.location.href='http://support.tradestudios.com'">
			</td>
		</cfif>
	</tr>
	<tr><td height="1" colspan="2"><img src="images/image-LineGray.gif" width="100%" height="1"></td></tr>
	<tr><td height="1" colspan="2"><img src="images/image-LineWhite.gif" width="100%" height="1"></td></tr>
	<tr><td height="1" colspan="2"><img src="images/image-LineGray.gif" width="100%" height="1"></td></tr>
</table>
</cfoutput>