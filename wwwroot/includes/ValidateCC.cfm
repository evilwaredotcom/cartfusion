<CFSETTING ENABLECFOUTPUTONLY="YES">
<!---  
  DESCRIPTION: 
	This function validates the format of all major credit cards using the 
	most efficient and extensible algorithm.
  USAGE:
	Function returns a structure with 4 members:
	  IsValid = Boolean indicating whether the Credit Card format is valid.
	  ParsedCC = Integer contains Clean version of Credit Card (trimmed spaces, removed dashes, periods, etc..).
	  Reason = String indicating fail message.
	  Type = String indicating Credit Card Type.
	 
	  TEST CARD NUMBERS THAT ARE OK:		   
		  Visa = 4111111111111111 
		  Mastercard = 5424000000000015 
		  American Express = 370000000000002 
		  Discover/Novus = 6011000000000004 
		  Diners Club = 38000000000006 
		  Carte Blanche = 30000000000004 
		  JCB = 3088000000000017 
		  enRoute = 201400000000009
	 
	  EXAMPLE FUNCTION CALL:
	  <cfoutput>
		<cfset creditcard = request.isValidCreditCard(370000000000002)>
		<cfif(not(creditcard.isvalid))> 
		  Invalid CC
		</cfif>
		#creditcard.isvalid#<br>
		#creditcard.parsedcc#<br>
		#creditcard.reason#<br>
		#creditcard.type#
	 </cfoutput>
--->

<CFSCRIPT>

  function isValidCreditCard(strCreditCardNumber) {
	var strDefaultMsg = "Credit Card Number is invalid";
	var strParseCCNum = rereplace(strCreditCardNumber, "[\. -]", '', "all");
	var intLenCCNum = len(strParseCCNum);
	var cc = structnew();
	var aValidCCRanges = arraynew(1);
	cc.IsValid = 0;
	cc.Reason = "";
	cc.ParsedCC = strParseCCNum;
	cc.Type = "Unknown";
	if((intLenCCNum lt 13) or (intLenCCNum gt 16) or 
	  refind("[^0-9]", strParseCCNum, 1)) {
	  cc.Reason = strDefaultMsg;
	  return cc;
	}
	// arrayappend(aValidCCRanges, "3000,3059,Diners Club");
	// arrayappend(aValidCCRanges, "3600,3699,Diners Club");
	// arrayappend(aValidCCRanges, "3800,3889,Diners Club");
	arrayappend(aValidCCRanges, "3400,3499,AE");
	arrayappend(aValidCCRanges, "3700,3799,AE");
	// arrayappend(aValidCCRanges, "3528,3589,JCB");
	// arrayappend(aValidCCRanges, "3890,3899,Carte Blanche");
	arrayappend(aValidCCRanges, "4000,4999,VI");
	arrayappend(aValidCCRanges, "5100,5599,MC");
	// arrayappend(aValidCCRanges, "5610,5610,Australian BankCard");
	arrayappend(aValidCCRanges, "6011,6011,DI");
	strFirst4Digit = left(strCreditCardNumber, 4);
	blnFirst4OK = false;
	for(intI = arraylen(aValidCCRanges); intI; intI = intI - 1) {
	  if((strFirst4Digit gte listgetat(aValidCCRanges[intI], 1)) and 
		 (strFirst4Digit lte listgetat(aValidCCRanges[intI], 2))) {
		cc.Type = listgetat(aValidCCRanges[intI], 3);
		blnFirst4OK = true;
		break;
	  }
	}
	if(not blnFirst4OK) {
	  cc.Reason = strDefaultMsg;
	  return cc;
	}
	intCheckSum = 0;
	for(intPos = (1 - (intLenCCNum mod 2)); intPos lt intLenCCNum; intPos = intPos + 2)
	  intCheckSum = intCheckSum + mid(strParseCCNum, (intPos + 1), 1);
	for(intPos = (intLenCCNum mod 2); intPos lt intLenCCNum; intPos = intPos + 2) {
	  intDigit = mid(strParseCCNum, (intPos + 1), 1) * 2;
	  intCheckSum = intCheckSum + iif(intDigit lt 10, intDigit, (intDigit - 9));
	}
	if((intCheckSum mod 10) eq 0)
	  cc.IsValid = 1;
	else
	  cc.Reason = strDefaultMsg;
	return cc;
  }
  request.isValidCreditCard = isValidCreditCard;
  
  
	// PROCESS
	creditcard = request.isValidCreditCard(#Form.CardNum#);
	if ( NOT creditcard.isvalid )
  		errorPayment = 1;
	else if ( creditcard.isvalid NEQ 1 )
		errorPayment = 1;
	else if ( creditcard.type NEQ #Form.CardName# )
		errorPayment = 2;
	// else
	//	do nothing;
			
</CFSCRIPT>

<!---<cfif errorPayment NEQ 0 >
	<cfoutput><cflocation url="CO-Payment.cfm?errorPayment=#errorPayment#" addtoken="no"></cfoutput>
	<cfabort>
</cfif>--->

<!---
<cfoutput>
	#errorPayment#<br>
	#creditcard.parsedcc#<br>
	#creditcard.reason#<br>
	#Form.CardName#<br>
	#creditcard.type#
</cfoutput>
--->

<CFSETTING ENABLECFOUTPUTONLY="NO">