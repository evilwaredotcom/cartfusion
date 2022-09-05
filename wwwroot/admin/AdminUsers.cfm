<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<cfif isDefined('Form.DeleteAdminUser') AND isDefined('Form.UserID') >
	<cfif Form.UserID EQ 1 ><!--- CANNOT DELETE ADMIN --->
		<cfset AdminMsg = 'ERROR: You cannot delete the main admin user.' >
	<cfelseif isUserInRole('Administrator') AND Form.UserName NEQ GetAuthUser() >
		<cfinvoke component="#application.Queries#" method="deleteAdminUser" returnvariable="deleteAdminUser">
			<cfinvokeargument name="UserID" value="#Form.UserID#">
		</cfinvoke>
		<cfset AdminMsg = 'Admin User Deleted Successfully' >
	<cfelse>			
		<script language="JavaScript">
			{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
		</script>
	</cfif>
</cfif>

<!--- BEGIN: QUERIES -------------------------------------------------->
<cfinvoke component="#application.Queries#" method="getAdminUsers" returnvariable="getAdminUsers"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getRoles" returnvariable="getRoles"></cfinvoke>
<!--- END: QUERIES -------------------------------------------------->

<!--- BEGIN: HEADER --->
<cfscript>
	PageTitle = 'ADMIN USERS';
	QuickSearch = 1;
	QuickSearchPage = 'AdminUsers.cfm';
	AddPage = 'AdminUserAdd.cfm';
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">
<!--- END: HEADER --->

<cfoutput>

<table width="100%" cellpadding="2" cellspacing="0" border="0">
	<tr style="background-color:##7DBF0E;">
		<td width="4%"  class="cfAdminHeader2" height="20" nowrap></td><!--- VIEW --->
		<td width="1%"  class="cfAdminHeader2" height="20" nowrap></td><!--- DELETE --->
		<td width="8%"  class="cfAdminHeader2" align="center" nowrap>User ID</td>
		<td width="10%" class="cfAdminHeader2" nowrap>UserName</td>
		<td width="15%" class="cfAdminHeader2" nowrap>Role</td>
		<td width="15%" class="cfAdminHeader2" nowrap>Name</td>
		<td width="5%"  class="cfAdminHeader2" align="center" nowrap>Disabled</td>
		<td width="*"   class="cfAdminHeader2" nowrap></td>
	</tr>
</cfoutput>
	
<cfif isUserInRole('Administrator')>		
	<cfoutput query="getAdminUsers">
	<cfform action="AdminUsers.cfm" method="post">
	
	<tr>
		<td>
			<input type="button" name="ViewAdminUser" value="VIEW" alt="View Admin User" class="cfAdminButton"
				onclick="document.location.href='AdminUserDetail.cfm?UserID=#UserID#'">
		</td>
		<td>
			<input type="submit" name="DeleteAdminUser" value="X" alt="Delete Admin User" class="cfAdminButton"
				onclick="return confirm('Are you sure you want to DELETE ADMIN USER #UserName# COMPLETELY ?')">
		</td>
		<td align="center">#UserID#</td>
		<td><cfinput type="text" name="UserName" value="#UserName#" size="20" maxlength="20" class="cfAdminDefault" required="yes" message="UserName Required" onchange="updateInfo(#UserID#,this.value,'Username','AdminUsers');"></td>
		<td>
			<cfselect query="getRoles" name="Roles" value="Role" display="Role" selected="#Roles#" size="1" class="cfAdminDefault"
				onChange="updateInfo(#UserID#,this.value,'Roles','AdminUsers');" />
		</td>
		<td>#FirstName# #LastName#</td>
		<td align="center">
			<input type="checkbox" name="Disabled" <cfif Disabled EQ 1> checked </cfif> onclick="updateInfo(#UserID#,this.value,'Disabled','AdminUsers');">
		</td>
	</tr>
	<!--- DIVIDER --->
	<tr><td height="1" colspan="8"><img src="images/image-LineGray.gif" width="100%" height="1"></td></tr>
		<input type="hidden" name="UserID" value="#UserID#">
	</cfform>
	</cfoutput>	
<cfelse>	
	<tr>
		<td colspan="8" class="cfAdminError">USER - <cfoutput>#GetAuthUser()#</cfoutput> - NOT PERMITTED TO VIEW THIS INFORMATION</td>
	</tr>	
</cfif>
</table>

<cfinclude template="LayoutAdminFooter.cfm">
