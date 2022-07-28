<div id="formContainer">

<cfform action="CA-LoginCheck.cfm?goToPage=#goToPage#" method="post" class="f-wrap-1">
	
	<fieldset>
		<h3>Registered Customers</h3>If you have already purchased with us and have a unique username and password, please login here.
		
		<label for="username"><b><span class="req">*</span>Username:</b>
			<cfinput type="text" Name="CustUser" size="30" maxlength="20" required="yes" message="Username is required"><br />
		</label>
		
		<label for="password"><b><span class="req">*</span>Password:</b>
			<cfinput type="password" Name="CustPassword" size="30" maxlength="20" required="yes" message="Password is required"><br />
		</label>
	</fieldset>
	
	<fieldset>
	
	<div class="f-submit-wrap">
		<cfinput type="submit" name="LoginButton" value="Login" class="button" style="width:100px;"><br />
	</div>
	
	</fieldset>
	
	
</cfform>

</div>


<!--- Old Code --->

<!--- <cfform action="CA-LoginCheck.cfm?goToPage=#goToPage#" METHOD="Post">
	<table width="100%" border=0>
		<cfif IsDefined('loginErrorMsg')>
			<cfif loginErrorMsg EQ 1>
			<tr>
				<td width="30%">&nbsp;</td>
				<td class="cfErrorMsg" colspan="2">Username Incorrect</td>
			</tr>
			</cfif>
			<cfif loginErrorMsg EQ 2>
			<tr>
				<td width="30%">&nbsp;</td>
				<td class="cfErrorMsg" colspan="2">Password Incorrect</td>
			</tr>
			</cfif>
		</cfif>
		<cfif session.CustomerArray[26] NEQ ''>
			<tr>
				<td colspan="2" class="cfMessageThree" align="center">
					Currently signed in as <b><cfoutput>#session.CustomerArray[26]#</cfoutput></b><br>
					<a href="CA-LoginCheck.cfm?Logout=1"><img src="images/button-logout.gif" border="0" align="absmiddle" vspace="5"></a>
				</td>
			</tr>
		</cfif>
		<cfif session.CustomerArray[26] EQ '' AND session.CustomerArray[28] GT 1 >
			<cfquery name="getUserID" datasource="#application.dsn#">
				SELECT 	UName
				FROM	Users
				WHERE	UID = #session.CustomerArray[28]#
			</cfquery>
			<cfif getUserID.RecordCount NEQ 0 >
			<tr>
				<td colspan="2" align="center">
					Currently signed in as <b><cfoutput>#getUserID.UName#</cfoutput></b><br><br>
					<table>
						<tr>
							<td class="cfMessageThree" align="center">
								Please create a<br><b>unique username and password</b><br>on the right to continue.<br><br>
							</td>
							<td>
								<img src="images/image-ArrowRight.gif" hspace="5">
							</td>
					</table>
					<a href="CA-LoginCheck.cfm?Logout=1"><img src="images/button-logout.gif" border="0" align="absmiddle" vspace="5"></a>
				</td>
			</tr>
			</cfif>
		</table>
		<cfelse><!--- SHOW LOGIN FORM --->
			<tr>
				<td width="30%" class="cfFormLabel">Username:</td>
				<td>
					<cfinput class="cfFormField" type="text" Name="CustUser" size="30" maxlength="20" required="yes" message="Username is required">
				</td>
			</tr>
			<tr>
				<td width="30%" class="cfFormLabel">Password:</td>
				<td>
					<cfinput class="cfFormField" type="password" Name="CustPassword" size="30" maxlength="20" required="yes" message="Password is required">
				</td>
			</tr>
		</table>
		<cfinput type="submit" name="LoginButton" value="Login" class="cfButton" style="width:200px;">
	</cfif>
</cfform> --->