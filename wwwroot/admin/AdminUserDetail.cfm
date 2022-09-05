<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<!--- BEGIN: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<cfif isDefined('Form.UpdateAdminUserInfo') AND isDefined('Form.UserID')>
	<cfif IsUserInRole('Administrator')>
		<!--- PREVENT DUPLICATE USERNAME --->
		<cfquery name="preventDuplicate" datasource="#application.dsn#">
			SELECT	UserName
			FROM	AdminUsers
			WHERE	UserName = '#Form.UserName#'
			AND		UserID != #Form.UserID#
		</cfquery>
	
		<cfif preventDuplicate.RecordCount NEQ 0 >
			<cfset AdminMsg = 'ERROR: UserName Already Taken.  Please choose an alternate username.' >
		<cfelseif form.PasswordCheck NEQ form.Password >
			<cfset AdminMsg = 'ERROR: Confirm Password does not match Password' >
		<cfelse>
			<cftry>
				<cfscript>
					Form.DateUpdated = #Now()#;
					Form.UpdatedBy = #GetAuthUser()#;
					if ( isDefined('Form.Disabled') AND Form.Disabled NEQ '' )
						Form.Disabled = 1;
					else
						Form.Disabled = 0;
				</cfscript>	
				<cfupdate datasource="#application.dsn#" tablename="AdminUsers" 
					formfields="UserID, UserName, Password, Roles, FirstName, LastName, CompanyName, Department, 
					Address1, Address2, City, State, Zip, Country, Phone, Fax, Email, Comments, Disabled, DateUpdated, UpdatedBy ">
				<cfset AdminMsg = 'Admin User <cfoutput>"#UserName#"</cfoutput> Updated Successfully' >
				<cfcatch>
					<cfset AdminMsg = 'FAIL: Admin User NOT Updated. #cfcatch.Message#' >
				</cfcatch>
			</cftry>
		</cfif>
	</cfif>
</cfif>
<!--- END: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<!--- BEGIN: QUERIES -------------------------------------------------->
<cfinvoke component="#application.Queries#" method="getAdminUser" returnvariable="getAdminUser">
	<cfinvokeargument name="UserID" value="#UserID#">
</cfinvoke>
<cfinvoke component="#application.Queries#" method="getStates" returnvariable="getStates"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getCountries" returnvariable="getCountries"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getRoles" returnvariable="getRoles"></cfinvoke>
<!--- END: QUERIES -------------------------------------------------->

<!--- BEGIN: HEADER --->
<cfscript>
	PageTitle = 'ADMIN USER DETAIL';
	QuickSearch = 1;
	QuickSearchPage = 'AdminUsers.cfm';
	AddPage = 'AdminUserAdd.cfm';
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
</cfoutput>

<cfoutput query="getAdminUser">			
<cfform action="AdminUserDetail.cfm" method="post">
	<tr>
		<td width="10%" height="20">User ID:</td>
		<td width="39%">#UserID#</td>
		<td width="10%"></td>
		<td width="40%"></td>
	</tr>
	<tr>
		<td><b>UserName:</b></td>
		<td><input type="text" name="UserName" value="#UserName#" size="40" class="cfAdminDefault"></td>
		<td>First Name:</td>
		<td><input type="text" name="FirstName" value="#FirstName#" size="40" class="cfAdminDefault"></td>
	</tr>
	<tr>
		<td><b>Password:</b></td>
		<td><input type="password" name="Password" value="#Password#" size="40" maxlength="16" class="cfAdminDefault"></td>
		<td>Last Name:</td>
		<td><input type="text" name="LastName" value="#LastName#" size="40" class="cfAdminDefault"></td>
	</tr>
	<tr>
		<td><b>Confirm Password:</b></td>
		<td><input type="password" name="PasswordCheck" value="#Password#" size="40" maxlength="16" class="cfAdminDefault"></td>
		<td>Company Name:</td>
		<td><input type="text" name="CompanyName" value="#CompanyName#" size="40" class="cfAdminDefault"></td>
	</tr>
	<tr>
		<td><b>Role:</b></td>
		<td><cfselect query="getRoles" name="Roles" value="Role" display="Role" selected="#Roles#" size="1" class="cfAdminDefault" /></td>
		<td>Department:</td>
		<td><input type="text" name="Department" value="#Department#" size="40" class="cfAdminDefault"></td>
	</tr>
	<tr>
		<td>Disable User?</td>
		<td><input type="checkbox" name="Disabled" <cfif Disabled EQ 1> checked </cfif> ></td>
		<td>Address 1:</td>
		<td><input type="text" name="Address1" value="#Address1#" size="40" class="cfAdminDefault"></td>
	</tr>
	<tr>
		<td></td>
		<td></td>
		<td>Address 2:</td>
		<td><input type="text" name="Address2" value="#Address2#" size="40" class="cfAdminDefault"></td>
	</tr>
	<tr>
		<td>Phone:</td>
		<td><input type="text" name="Phone" value="#Phone#" size="40" class="cfAdminDefault"></td>
		<td>City:</td>
		<td><input type="text" name="City" value="#City#" size="40" class="cfAdminDefault"></td>
	</tr>
	<tr>
		<td>Fax:</td>
		<td><input type="text" name="Fax" value="#Fax#" size="40" class="cfAdminDefault"></td>
		<td>State:</td>
		<td><cfselect name="State" query="getStates" size="1" value="StateCode" display="State" selected="#State#" class="cfAdminDefault" /></td>
	</tr>
	<tr>
		<td>Email:</td>
		<td><input type="text" name="Email" value="#Email#" size="40" class="cfAdminDefault"></td>
		<td>ZIP/Postal Code:</td>
		<td><input type="text" name="Zip" value="#Zip#" size="20" class="cfAdminDefault"></td>
	</tr>
	<tr>
		<td rowspan="4">Comments:</td>
		<td rowspan="4"><textarea name="Comments" cols="40" rows="5" class="cfAdminDefault">#Comments#</textarea></td>
		<td>Country:</td>
		<td><cfselect name="Country" query="getCountries" size="1" value="CountryCode" display="Country" selected="#Country#" class="cfAdminDefault" /></td>
	</tr>
	<tr>
		<td height="20"></td>
		<td></td>
	</tr>
	<tr>
		<td height="20">Last Updated:</td>
		<td>#DateFormat(DateUpdated, "d-mmm-yyyy")# #TimeFormat(DateUpdated, "@ hh:mm tt")#</td>
	</tr>
	<tr>
		<td height="20">Last Updated By:</td>
		<td>#UpdatedBy#</td>
	</tr>
	<tr>
		<td colspan="5" height="20"></td>
	</tr>
	<tr style="background-color:##F27028;">
		<td colspan="5" height="20" class="cfAdminHeader3" align="center">
			UPDATE ABOVE INFORMATION
		</td>
	</tr>
	<tr>
		<td height="20" colspan="5"></td>
	</tr>
	<tr>
		<td colspan="5" align="center">
			<input type="submit" name="UpdateAdminUserInfo" value="UPDATE CHANGES" alt="Update Admin User Information" class="cfAdminButton">
		</td>
	</tr>
	<tr>
		<td height="20" colspan="5"></td>
	</tr>
</table>
<input type="hidden" name="UserID" value="#UserID#">	
</cfform>
</cfoutput>

<br><br><br>

<cfinclude template="LayoutAdminFooter.cfm">