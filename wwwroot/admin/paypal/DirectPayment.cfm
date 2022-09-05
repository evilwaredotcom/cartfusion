<script language="JavaScript">
	function generateCC(){
		var cc_number = new Array(16);
		var cc_len = 16;
		var start = 0;
		var rand_number = Math.random();
		
		switch(document.frmDCC.creditCardType.value)
		{
			case "Visa":
				cc_number[start++] = 4;
				break;
			case "Discover":
				cc_number[start++] = 6;
				cc_number[start++] = 0;
				cc_number[start++] = 1;
				cc_number[start++] = 1;
				break;
			case "MasterCard":
				cc_number[start++] = 5;
				cc_number[start++] = Math.floor(Math.random() * 5) + 1;
				break;
			case "Amex":
				cc_number[start++] = 3;
				cc_number[start++] = Math.round(Math.random()) ? 7 : 4 ;
				cc_len = 15;
				break;
		}
		
		for (var i = start; i < (cc_len - 1); i++) {
			cc_number[i] = Math.floor(Math.random() * 10);
		}
		
		var sum = 0;
		for (var j = 0; j < (cc_len - 1); j++) {
			var digit = cc_number[j];
			if ((j & 1) == (cc_len & 1)) digit *= 2;
			if (digit > 9) digit -= 9;
			sum += digit;
		}
		
		var check_digit = new Array(0, 9, 8, 7, 6, 5, 4, 3, 2, 1);
		cc_number[cc_len - 1] = check_digit[sum % 10];
		
		document.frmDCC.creditCardNumber.value = "";
		for (var k = 0; k < cc_len; k++) {
			document.frmDCC.creditCardNumber.value += cc_number[k];
		}
	}
</script>

<cfscript>
	PageTitle = 'DIRECT PAYMENT' ;
	BannerTitle = 'PayPal' ;
</cfscript>
<cfinclude template="LayoutPPHeader.cfm">
<cfinclude template="LayoutPPBanner.cfm">

<cfform name="frmDCC" action="Receipt.cfm" method="post">

<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="2" class="cfAdminTitle">Payment</td>
	</tr>
	<tr>
		<td width="10%">Amount: </td>
		<td><cfinput type="text" class="cfAdminDefault" name="paymentAmount" message="Please enter an amount to charge." required="Yes"> $USD <font size=-2 color=red>required</font></td>
	</tr>
	<tr><td height="20">&nbsp;</td></tr>
	<tr>
		<td colspan="2" class="cfAdminTitle">Buyer Name</td>
	</tr>
	<tr>
		<td>First Name: </td>
		<td><cfinput type="text" class="cfAdminDefault" name="buyerFirstName" message="Please enter a first name." required="Yes"> <font size=-2 color=red>required</font></td>
	</tr>
	<tr>
		<td>Last Name: </td>
		<td><cfinput type="text" class="cfAdminDefault" name="buyerLastName" message="Please enter a last name." required="Yes"> <font size=-2 color=red>required</font></td>
	</tr>
	<tr><td height="20">&nbsp;</td></tr>
	<tr>
		<td colspan="2" class="cfAdminTitle">Address</td>
	</tr>
	<tr>
		<td>Address1: </td>
		<td><cfinput type="text" class="cfAdminDefault" name="buyerAddress1" message="Please enter an address." required="Yes"> <font size=-2 color=red>required</font></td>
	</tr>
	<tr>
		<td>Address2: </td>
		<td><cfinput type="text" class="cfAdminDefault" name="buyerAddress2"></td>
	</tr>
	<tr>
		<td>City: </td>
		<td><cfinput type="text" class="cfAdminDefault" name="buyerCity" message="Please enter a city." required="Yes"> <font size=-2 color=red>required</font></td>
	</tr>
	<tr>
		<td>State: </td>
		<td><cfinput type="text" class="cfAdminDefault" name="buyerState" message="Please enter a state." required="Yes"> <font size=-2 color=red>required</font></td>
	</tr>
	<tr>	
		<td>Zip Code: </td>
		<td><cfinput type="text" class="cfAdminDefault" name="buyerZipCode" message="Please enter zip code, formatted xxxxx or xxxxx-xxxx" 
			validate="zipcode" required="Yes"> <font size=-2 color=red>required</font></td>
	</tr>
	<tr>
		<td>Country: </td>
		<td>USA</td>
	</tr>
	<tr><td height="20">&nbsp;</td></tr>
	<tr>
		<td colspan="2" class="cfAdminTitle">Credit Card</td>
	</tr>
	<tr>
		<td>Type: </td>
		<td>
			<cfselect name="creditCardType" class="cfAdminDefault" required="Yes" onChange="javascript:generateCC(); return false;">
				<option selected value="Visa">Visa</option>
				<option value="MasterCard">MasterCard</option>
				<option value="Discover">Discover</option>
				<option value="Amex">American Express</option>
			</cfselect> <font size=-2 color=red>required</font>
		</td>
	</tr>
	<tr>
		<td>Credit Card Number: </td>
		<td><cfinput type="text" class="cfAdminDefault" name="creditCardNumber" message="Please enter a correctly formatted credit card number." 
			validate="creditcard" required="Yes" value="4832419131427146"> <font size=-2 color=red>required</font></td>
	</tr>
	<tr>
		<td>Card Verification Number: </td>
		<td><cfinput type="text" class="cfAdminDefault" name="CVV2" message="Please enter a CVV2 code." required="Yes" value="000"> <font size=-2 color=red>required</font></td>
	</tr>
	<tr>
		<td>Expiration Date: </td>
		<td>
			<cfselect name="expMonth" required="Yes" class="cfAdminDefault"> 
				<option>01</option>
				<option>02</option>
				<option>03</option>
				<option>04</option>
				<option>05</option>
				<option>06</option>
				<option>07</option>
				<option>08</option>
				<option>09</option>
				<option>10</option>
				<option>11</option>
				<option>12</option>
			</cfselect>
			<cfselect name="expYear" required="Yes" class="cfAdminDefault"> 
				<option>2005</option>
				<option selected>2006</option>
				<option>2007</option>
				<option>2008</option>
				<option>2009</option>
				<option>2010</option>
				<option>2011</option>
				<option>2012</option>
				<option>2013</option>
				<option>2014</option>
				<option>2015</option>
			</cfselect> <font size=-2 color=red>required</font>
		</td>
	</tr>
</table><br>
<input type="submit" value="SUBMIT PAYMENT" class="cfAdminButton">
<input type="button" value="BACK" class="cfAdminButton" onClick="javascript:history.back()">
<input type="button" value="CANCEL" onClick="javascript:history.back()" class="cfAdminButton">
</cfform>

<script language="javascript">
	generateCC();
</script>

<cfinclude template="LayoutPPFooter.cfm">