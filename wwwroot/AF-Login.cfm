<cfmodule template="tags/layout.cfm" PageTitle="Affiliate Login" CurrentTab="Affiliates">

<!--- Start Breadcrumb --->
<cfmodule template="tags/breadCrumbs.cfm" CrumbLevel='1' showLinkCrumb="Affiliate Login" />
<!--- End BreadCrumb --->


<!--- <br> --->
<cfif isDefined("errorLogin")>		
	<div align="center" class="cfErrorMsg">
		ERROR:
		<cfswitch expression="#errorLogin#">
			<cfcase value="1">Password incorrect.<br>Please try again.</cfcase>
			<cfcase value="2">The Password and its confirmation don't match.<br>Please try again.</cfcase>
			<cfcase value="3">The password cannot be empty.<br>Please try again.</cfcase>
			<cfcase value="4">The Affiliate ID cannot be empty.<br>Please try again.</cfcase>
			<cfcase value="5">The Affiliate ID cannot be found in our system.<br>Please try again.</cfcase>
			<cfcase value="6">The Affiliate ID has not been authenticated yet.<br>Please check your email and follow the authentication process.</cfcase>		
		</cfswitch>	
	</div><br><br>
</cfif>

<div id="formContainer">
	<div id="column-A">
		<!--- Include Login Form for affiliates --->
		<cfinclude template="AF-LoginForm.cfm">
		<br />
		
		<cfform method="post" action="AF-EmailLogin.cfm" class="f-wrap-1">
			<fieldset>
				<h3>Forgot Your Password?</h3>
		
				<label for="email"><b>Email address:</b>
					<cfinput type="text" name="EmailAddress" size="30" required="Yes" message="Email Address Is Required"><br />
				</label>
				
			</fieldset>
	
			<fieldset>
			
				<div class="f-submit-wrap">
					<cfinput type="submit" name="LoginButton" value="Email My Login Information" class="button" style="width:200px;"><br />
				</div>
			
			</fieldset>
	</cfform>
	</div>
	
	<div id="column-B">
		<cfform name="NewAffiliates" class="f-wrap-1">
			<fieldset>
				<h3>New Affiliates</h3> If you would like to sign up as an affiliate of <cfoutput>#application.siteConfig.data.domainname#</cfoutput>, please sign up for an account here.<br /><br />
				
				<div class="f-submit-wrap">
					<input type="button" name="button" value="Sign Up Now" class="button" style="width:200px;" onclick="document.location.href='AF-Signup.cfm'">
				</div>
		
		</cfform>
	</div>

</div>

<br class="clear" />

<div align="center">
	<br />
	<br />
	<hr class="snip" />
	<br />
	<a href="javascript:history.back()"><img src="images/button-back.gif"></a>
	<a href="index.cfm"><img src="images/button-home.gif"></a>
</div>

</cfmodule>
