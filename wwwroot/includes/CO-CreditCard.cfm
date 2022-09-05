<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<cfscript>
	Decrypted_CardNum = '' ;
	Decrypted_ExpDate = '' ;
	// CARTFUSION 4.6
	if ( application.SaveCreditCard EQ 1 and application.ShowCreditCard EQ 1 )
	{
		if ( TRIM(session.CustomerArray[14]) NEQ '' ) Decrypted_CardNum = DECRYPT(session.CustomerArray[14], application.CryptKey, "CFMX_COMPAT", "Hex");
		if ( TRIM(session.CustomerArray[15]) NEQ '' ) Decrypted_ExpDate = DECRYPT(session.CustomerArray[15], application.CryptKey, "CFMX_COMPAT", "Hex");
	}
</cfscript>

<cfoutput>

<div class="cfMessageThree" style="padding:0px 0px 5px 5px;">CREDIT CARD INFORMATION</div>

<table width="100%" border="0" cellpadding="5" cellspacing="0">
	<cfif isDefined('errorPayment') AND errorPayment EQ 1 >
		<tr><td colspan="4" class="cfErrorMsg" height="24" valign="top">ERROR: INVALID CREDIT CARD NUMBER</td></tr>
	<cfelseif isDefined('errorPayment') AND errorPayment EQ 2 >
		<tr><td colspan="4" class="cfErrorMsg" height="24" valign="top">ERROR: INVALID CREDIT CARD NAME &amp; NUMBER COMBINATION</td></tr>
	</cfif>	
	<tr>
		<td class="cfFormLabel" nowrap="nowrap"><u>Credit Card Type:</u></td>
		<td class="cfFormLabel" nowrap="nowrap"><u>Card Number:</u></td>
		<td class="cfFormLabel" nowrap="nowrap"><u>Expiration Date:</u></td>
		<td class="cfFormLabel" nowrap="nowrap"><u>Card Code:</u></td>	
	</tr>
	<tr>
		<td class="cfFormLabel" nowrap="nowrap">
			<cfinvoke component="#application.Queries#" method="getPaymentTypes" returnvariable="getPaymentTypes"></cfinvoke>
			<cfselect query="getPaymentTypes" class="cfFormField" name="CardName" value="Type" display="Display" selected="#session.CustomerArray[13]#"
				required="yes" message="Please select a credit card type" />
		</td>
		<td class="cfFormLabel" nowrap="nowrap">
			<cfinput type="text" name="CardNum" size="25" maxlength="20" class="cfFormField" value="#Decrypted_CardNum#"
				required="yes" message="Please enter a valid credit card number, with NO spaces or hyphens." validate="regular_expression" pattern="^((4\d{3})|(5[1-5]\d{2})|(6011))-?\d{4}-?\d{4}-?\d{4}|3[4,7]\d{13}$">
		</td>
		<td class="cfFormLabel" nowrap="nowrap">
			<cfinput type="text" name="ExpDate" size="10" maxlength="5" class="cfFormField" value="#Decrypted_ExpDate#"
				required="yes" message="Please enter a valid expiration date in mm/yy format" validate="regular_expression" pattern="^((0[1-9])|(1[0-2]))\/(\d{2})$"> MM/YY
		</td>
		<td class="cfFormLabel" nowrap="nowrap">
			<cfinput type="text" name="CardCVV" size="4" maxlength="4" class="cfFormField" value="#session.CustomerArray[37]#"
				required="yes" message="Please enter a valid 3 or 4 digit CVV number"> <a href="javascript:NewWindow('images/logos/image-CVV.jpg','CVV','250','400','no');"><img src="images/logos/icon-cvv.gif" border="0" alt="Click here for more information" align="absmiddle"></a>
		</td>
	</tr>
</table>

</cfoutput>