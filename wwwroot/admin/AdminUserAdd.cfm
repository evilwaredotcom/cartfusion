<!--- BEGIN: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<cfif isDefined('Form.AddAdminUserInfo') AND isDefined('Form.UserName') AND Form.UserName NEQ ''>
	<cfif IsUserInRole('Administrator')>
	
		<!--- PREVENT DUPLICATE USERNAME --->
		<cfquery name="preventDuplicate" datasource="#application.dsn#">
			SELECT	UserName
			FROM	AdminUsers
			WHERE	UserName = '#Form.UserName#'
		</cfquery>
	
		<cfif preventDuplicate.RecordCount NEQ 0 >
			<cfset AdminMsg = 'ERROR: UserName Already Taken.  Please choose an alternate username.' >
		<cfelseif form.PasswordCheck NEQ form.Password >
			<cfset AdminMsg = 'ERROR: Confirm Password does not match Password' >
		<cfelse>
			<cftry>
		
				<cfinsert datasource="#application.dsn#" tablename="AdminUsers" 
					formfields="UserName, Password, Roles, FirstName, LastName, CompanyName, Department, 
					Address1, Address2, City, State, Zip, Country, Phone, Fax, Email, Comments, Disabled, DateUpdated, UpdatedBy ">
					
				<!--- GET NEWLY ASSIGNED UserID NUMBER --->
				<cfquery name="getAddedUserID" datasource="#application.dsn#">
					SELECT	MAX(UserID) AS UserID
					FROM	AdminUsers
				</cfquery>
				
				<cfset UserID = getAddedUserID.UserID>
				<cfset AdminMsg = 'Admin User <cfoutput>"#UserName#"</cfoutput> Added Successfully' >
				<cflocation url="AdminUserDetail.cfm?UserID=#UserID#&AdminMsg=#URLEncodedFormat(AdminMsg)#" addtoken="no">
				<cfabort>
				
				<cfcatch>
					<cfset AdminMsg = 'FAIL: Admin User NOT Updated - #cfcatch.Message#' >
				</cfcatch>
			</cftry>
		</cfif>
	</cfif>
</cfif>
<!--- END: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<!--- BEGIN: QUERIES -------------------------------------------------->
<cfinvoke component="#application.Queries#" method="getStates" returnvariable="getStates"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getCountries" returnvariable="getCountries"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getRoles" returnvariable="getRoles"></cfinvoke>
<!--- END: QUERIES -------------------------------------------------->

<!--- BEGIN: HEADER --->
<cfscript>
	PageTitle = 'ADD ADMIN USER';
	QuickSearch = 1;
	QuickSearchPage = 'AdminUsers.cfm';
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">
<!--- END: HEADER --->

<cfoutput>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr style="background-color:##65ADF1;">
		<td width="49%" colspan="2" height="20" class="cfAdminHeader1">&nbsp; ADMIN USER INFORMATION</td>
		<td width="1%"  rowspan="26" style="background-color:##FFFFFF;">&nbsp;</td>
		<td width="50%" colspan="2" class="cfAdminHeader1">&nbsp; CONTACT INFORMATION</td>
	</tr>
	<tr>
		<td colspan="5" height="5"></td>
	</tr>
<cfform action="AdminUserAdd.cfm" method="post">
	<tr>
		<td width="10%" height="20">User ID:</td>
		<td width="39%">TBD</td>
		<td width="10%"></td>
		<td width="40%"></td>
	</tr>
	<tr>
		<td><b>UserName:</b></td>
		<td><cfinput type="text" name="UserName" size="40" class="cfAdminDefault" required="yes" message="Please assign a UserName"></td>
		<td>First Name:</td>
		<td><cfinput type="text" name="FirstName" size="40" class="cfAdminDefault"></td>
	</tr>
	<tr>
		<td><b>Password:</b></td>
		<td><cfinput type="text" name="Password" size="40" maxlength="16" class="cfAdminDefault" required="yes" message="Please assign a Password"></td>
		<td>Last Name:</td>
		<td><cfinput type="text" name="LastName" size="40" class="cfAdminDefault"></td>
	</tr>
	<tr>
		<td><b>Confirm Password:</b></td>
		<td><cfinput type="text" name="PasswordCheck" size="40" maxlength="16" class="cfAdminDefault" required="yes" message="Please confirm the Password"></td>
		<td>Company Name:</td>
		<td><cfinput type="text" name="CompanyName" size="40" class="cfAdminDefault"></td>
	</tr>
	<tr>
		<td><b>Role:</b></td>
		<td><cfselect query="getRoles" name="Roles" value="Role" display="Role" selected="User" size="1" class="cfAdminDefault" required="yes" message="Please assign a Role for this user" /></td>
		<td>Department:</td>
		<td><cfinput type="text" name="Department" size="40" class="cfAdminDefault"></td>
	</tr>
	<tr>
		<td>Disable User?</td>
		<td><cfinput type="checkbox" name="Disabled"></td>
		<td>Address 1:</td>
		<td><cfinput type="text" name="Address1" size="40" class="cfAdminDefault"></td>
	</tr>
	<tr>
		<td></td>
		<td></td>
		<td>Address 2:</td>
		<td><cfinput type="text" name="Address2" size="40" class="cfAdminDefault"></td>
	</tr>
	<tr>
		<td>Phone:</td>
		<td><cfinput type="text" name="Phone" size="40" class="cfAdminDefault"></td>
		<td>City:</td>
		<td><cfinput type="text" name="City" size="40" class="cfAdminDefault"></td>
	</tr>
	<tr>
		<td>Fax:</td>
		<td><cfinput type="text" name="Fax" size="40" class="cfAdminDefault"></td>
		<td>State:</td>
		<td><cfselect name="State" query="getStates" size="1" value="StateCode" display="State" selected="#application.CompanyState#" class="cfAdminDefault" /></td>
	</tr>
	<tr>
		<td>Email:</td>
		<td><cfinput type="text" name="Email" size="40" class="cfAdminDefault"></td>
		<td>ZIP/Postal Code:</td>
		<td><cfinput type="text" name="Zip" size="20" class="cfAdminDefault"></td>
	</tr>
	<tr>
		<td rowspan="4">Comments:</td>
		<td rowspan="4"><textarea name="Comments" cols="40" rows="5" class="cfAdminDefault"><cfif isDefined('Form.Comments') AND Form.Comments NEQ ''>#Comments#</cfif></textarea></td>
		<td>Country:</td>
		<td><cfselect name="Country" query="getCountries" size="1" value="CountryCode" display="Country" selected="#application.CompanyCountry#" class="cfAdminDefault" /></td>
	</tr>
	<tr>
		<td height="20"></td>
		<td></td>
	</tr>
	<tr>
		<td height="20">Date Created:</td>
		<td><cfoutput>#DateFormat(Now(), "d-mmm-yyyy")# #TimeFormat(Now(), "@ hh:mm tt")#</cfoutput></td>
	</tr>
	<tr>
		<td height="20">Created By:</td>
		<td><cfoutput>#GetAuthUser()#</cfoutput></td>
	</tr>
	<tr>
		<td colspan="5" height="20"></td>
	</tr>
	<tr style="background-color:##F27028;">
		<td colspan="5" height="20" class="cfAdminHeader3" align="center">
			ADD THIS ADMINISTRATIVE USER
		</td>
	</tr>
	<tr>
		<td height="20" colspan="5"></td>
	</tr>
	<tr>
		<td colspan="5" align="center">
			<input type="submit" name="AddAdminUserInfo" value="ADD ADMIN USER" alt="Add Administrative User" class="cfAdminButton">
		</td>
	</tr>
	<tr>
		<td height="20" colspan="5"></td>
	</tr>
</table>
</cfform>
</cfoutput>

<br><br><br>

<cfinclude template="LayoutAdminFooter.cfm">