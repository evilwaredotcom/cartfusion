<div id="formContainer">

<cfform action="AF-LoginCheck.cfm" method="post" class="f-wrap-1">
	
	<fieldset>
		<h3>Registered Affiliates</h3>If you are already a registered affiliate, welcome back!. Please login with your username and password here.
		
		<label for="firstname"><b><span class="req">*</span>Affiliate ID:</b>
			<cfinput type="text" Name="AFID" size="10" maxlength="12" required="yes" message="Required: Affiliate ID (numeric)" validate="integer"><br />
		</label>
		
		<label for="firstname"><b><span class="req">*</span>Password:</b>
			<cfinput type="password" Name="AffiliatePassword" size="10" maxlength="12" required="yes" message="Required: Password"><br />
		</label>
	</fieldset>
	
	<fieldset>
	
	<div class="f-submit-wrap">
		<cfinput type="submit" name="LoginButton" value="Login" class="button" style="width:100px;"><br />
	</div>
	
	</fieldset>
	
	
</cfform>

</div>
