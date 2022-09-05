<!----------------------------------------------------------------------
USA ePay ColdFusion Library.
v0.2 - October 13th, 2001
v1.0 - September 15, 2002
v1.2 - October 15, 2003 (Added new fields)
v1.3 - April 2004 (Independent Result Variables)

Copyright © 2001 USA Merchant Center
v0.2 Written by Tim McEwen (tem@usamerchant.com)
v1.0 Written by Mind2Web (mind2webinfo@yahoo.com)
v1.2 - Written by Mind2Web (mind2webinfo@yahoo.com)
v1.3 - Written by Mind2Web (mind2webinfo@yahoo.com)

See http://www.usaepay.com


Parameters:
attributes.QueryName (defaults to q_auth)
attributes.key
attributes.cardnum
attributes.expdate
attributes.amount
attributes.custid
attributes.invoice
attributes.description
attributes.cvv
attributes.email
attributes.emailcustomer (FALSE)
attributes.custname
attributes.avsstreet
attributes.avszip
attributes.clientip
attributes.TestRequest (TRUE, FALSE)


creates:
Creates a query object with response fields. The name of the
query object is defined by the value of "attributes.QueryName"
The query will contain the following columns:

1. x_response_code
Indicates the result of the transaction.
Approved,
Declined,
Error
2. x_auth_code
6 digit approval code
3. x_response_reason_text
Brief description of result
4. x_avs_code

5. x_cvv_code

6. x_trans_id
(Transaction reference number)

------------------------------------------------------------------------>

<!----------------------------------------------------------------------
Set defaults for common parameters

You can find definition of all these parameters on http://www.usaepay.com
---------------------------------------------------------------------->
<cfparam name="attributes.queryname" default="q_auth">
<cfparam name="attributes.key" default="">
<cfparam name="attributes.refNum" default="">
<cfparam Name="attributes.cardnum" default="">
<cfparam Name="attributes.expdate" default="">
<cfparam name="attributes.amount" default="">
<cfparam name="attributes.tax" default="">
<cfparam Name="attributes.custid" default="">
<cfparam Name="attributes.invoice" default="">
<cfparam name="attributes.ponum" default="">
<cfparam name="attributes.description" default="Online Order">
<cfparam Name="attributes.cvv" default="">
<cfparam name="attributes.email" Default="">
<cfparam name="attributes.EmailCustomer" default="FALSE">
<cfparam name="attributes.custReceipt" default="">
<cfparam Name="attributes.custname" default="">
<cfparam Name="attributes.avsstreet" default="">
<cfparam Name="attributes.avszip" default="">
<cfparam Name="attributes.clientip" default="">
<cfparam name="attributes.TestRequest" default="FALSE">

<cfparam name="attributes.authCode" default="">
<cfparam name="attributes.routing" default="">
<cfparam name="attributes.account" default="">
<cfparam name="attributes.ticket" default="">
<cfparam name="attributes.ssn" default="">
<cfparam name="attributes.dlnum" default="">
<cfparam name="attributes.dlstate" default="">
<cfparam name="attributes.command" default="">
<cfparam name="attributes.redir" default="">
<cfparam name="attributes.redirApproved" default="">
<cfparam name="attributes.redirDeclined" default="">
<cfparam name="attributes.echofields" default="">
<cfparam name="attributes.recurring" default="">
<cfparam name="attributes.billAmount" default="">
<cfparam name="attributes.schedule" default="">
<cfparam name="attributes.numleft" default="">
<cfparam name="attributes.start" default="">
<cfparam name="attributes.expire" default="">
<cfparam name="attributes.billfname" default="">
<cfparam name="attributes.billlname" default="">
<cfparam name="attributes.billcompany" default="">
<cfparam name="attributes.billstreet" default="">
<cfparam name="attributes.billstreet2" default="">
<cfparam name="attributes.billcity" default="">
<cfparam name="attributes.billstate" default="">
<cfparam name="attributes.billzip" default="">
<cfparam name="attributes.billcountry" default="">
<cfparam name="attributes.billphone" default="">
<cfparam name="attributes.billemail" default="">
<cfparam name="attributes.fax" default="">
<cfparam name="attributes.website" default="">
<cfparam name="attributes.shipfname" default="">
<cfparam name="attributes.shiplname" default="">
<cfparam name="attributes.shipcompany" default="">
<cfparam name="attributes.shipstreet" default="">
<cfparam name="attributes.shipstreet2" default="">
<cfparam name="attributes.shipcity" default="">
<cfparam name="attributes.shipstate" default="">
<cfparam name="attributes.shipzip" default="">
<cfparam name="attributes.shipcountry" default="">
<cfparam name="attributes.shipphone" default="">
<cfparam name="attributes.cardauth" default="">
<cfparam name="attributes.pares" default="">
<cfparam name="attributes.xid" default="">
<cfparam name="attributes.cavv" default="">
<cfparam name="attributes.eci" default="">

<!----------------------------------------------------------------------
Format variables to ePay specs before validating.
---------------------------------------------------------------------->

<cfset attributes.cardnum = REreplace(attributes.cardnum, "[^0-9]", "", "ALL")>
<cfset attributes.expdate = REreplace(attributes.expdate, "[^0-9]", "", "ALL")>


<!----------------------------------------------------------------------
Check for required variables before sending to ePay
---------------------------------------------------------------------->
<cfset required = 0>
<cfif (attributes.command IS "check" OR attributes.command IS "checkcredit")>

<cfif attributes.routing LTE " " OR
attributes.account LTE " " OR
attributes.ssn LTE " " OR
attributes.dlnum LTE " " OR
attributes.dlstate LTE " ">
<cfset required = 1>
</cfif>

<cfelse>
<cfif attributes.cardnum LTE " " OR
attributes.expdate LTE " ">
<cfset required = 2>
</cfif>
</cfif>

<cfif required IS 1 OR required IS 2 OR
attributes.amount LTE " " OR
attributes.invoice LTE " " OR
attributes.custname LTE " " OR
attributes.avsstreet LTE " " OR
attributes.avszip LTE " ">

<!----------------------------------------------------------------------
All required fields have not been filled out.
You might want to insert your own error handling script below to
give your users a more pleasing and helpfull error message.
---------------------------------------------------------------------->

<center><font color=\"red\" size=\"3\">Error missing parameter</font></center><br>
Click on your browser's back button and fill out all required fields.

<cfabort>

</cfif>

<!----------------------------------------------------------------------
Post to USA ePay
---------------------------------------------------------------------->

<CFHTTP METHOD="Post" URL="https://www.usaepay.com/gate.php">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.key#"
NAME="UMkey">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.refNum#"
NAME="UMrefNum">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.cardnum#"
NAME="UMcard">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.expdate#"
NAME="UMexpir">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.amount#"
NAME="UMamount">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.tax#"
NAME="UMtax">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.custid#"
NAME="UMcustid">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.invoice#"
NAME="UMinvoice">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.ponum#"
NAME="UMponum">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.description#"
NAME="UMdescription">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.cvv#"
NAME="UMcvv2">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.email#"
NAME="UMcustemail">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.custname#"
NAME="UMname">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.custReceipt#"
NAME="UMcustreceipt">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.avsstreet#"
NAME="UMstreet">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.avszip#"
NAME="UMzip">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.clientip#"
NAME="UMip">

<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.authCode#"
NAME="UMauthCode">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.routing#"
NAME="UMrouting">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.account#"
NAME="UMaccount">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.ticket#"
NAME="UMticket">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.ssn#"
NAME="UMssn">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.dlnum#"
NAME="UMdlnum">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.dlstate#"
NAME="UMdlstate">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.command#"
NAME="UMcommand">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.redir#"
NAME="UMredir">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.redirApproved#"
NAME="UMredirApproved">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.redirDeclined#"
NAME="UMredirDeclined">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.echofields#"
NAME="UMechofields">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.recurring#"
NAME="UMrecurring">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.billAmount#"
NAME="UMbillamount">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.schedule#"
NAME="UMschedule">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.numleft#"
NAME="UMnumleft">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.start#"
NAME="UMstart">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.expire#"
NAME="UMexpire">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.billfname#"
NAME="UMbillfname">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.billlname#"
NAME="UMbilllname">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.billcompany#"
NAME="UMbillcompany">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.billstreet#"
NAME="UMbillstreet">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.billstreet2#"
NAME="UMbillstreet2">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.billcity#"
NAME="UMbillcity">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.billstate#"
NAME="UMbillstate">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.billzip#"
NAME="UMbillzip">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.billcountry#"
NAME="UMbillcountry">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.billphone#"
NAME="UMbillphone">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.billAmount#"
NAME="UMbillamount">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.billemail#"
NAME="UMemail">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.fax#"
NAME="UMfax">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.website#"
NAME="UMwebsite">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.shipfname#"
NAME="UMshipfanme">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.shiplname#"
NAME="UMshiplname">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.shipcompany#"
NAME="UMshipcompany">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.shipstreet#"
NAME="UMshipstreet">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.shipstreet2#"
NAME="UMshipstreet2">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.shipcity#"
NAME="UMshipcity">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.shipstate#"
NAME="UMshipstate">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.shipzip#"
NAME="UMshipzip">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.shipcountry#"
NAME="UMshipcountry">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.shipphone#"
NAME="UMshipphone">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.cardauth#"
NAME="UMcardauth">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.pares#"
NAME="UMpares">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.xid#"
NAME="UMxid">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.cavv#"
NAME="UMcavv">
<CFHTTPPARAM TYPE="Formfield"
VALUE="#attributes.eci#"
NAME="UMeci">
</CFHTTP>

<!----------------------------------------------------------------------
Create a local query object for result
---------------------------------------------------------------------->

<cfset q_auth =QueryNew("UMversion,UMstatus,UMauthCode,UMrefNum,UMavsResult,UMavsResultCode,
UMcvv2Result,UMcvv2ResultCode,UMresult,UMerror,UMfiller")>
<cfset nil = QueryAddRow(q_auth)>

<cfif ListLen(cfhttp.FileContent,",") IS 0>
<cfset nil = QuerySetCell( q_auth, "UMstatus", "Error")>
<cfset nil = QuerySetCell( q_auth, "UMauthCode", "000000")>
<cfset nil = QuerySetCell( q_auth, "UMavsResult", "Invalid Response from USA ePay")>
<cfset nil = QuerySetCell( q_auth, "UMavsResultCode", "n/a")>
<cfset nil = QuerySetCell( q_auth, "UMcvv2Result", "n/a")>
<cfset nil = QuerySetCell( q_auth, "UMcvv2ResultCode", "n/a")>
<cfset nil = QuerySetCell( q_auth, "UMrefNum", "000000")>
<cfset nil = QuerySetCell( q_auth, "UMversion", "n/a")>
<cfset nil = QuerySetCell( q_auth, "UMresult", "n/a")>
<cfset nil = QuerySetCell( q_auth, "UMerror", "n/a")>
<cfset nil = QuerySetCell( q_auth, "UMfiller", "n/a")>
<cfelse>
<cfloop index = "i" list = "#cfhttp.FileContent#" delimiters = "&">
<cfset responseHash = ArrayNew(1)>
<cfset responseHash = ListToArray(i,"=")>
<cfif responseHash[1] IS "UMstatus">
<cftry>
<cfset nil = QuerySetCell( q_auth, "UMstatus", URLDecode(responseHash[2]))>
<cfcatch>
<cfset nil = QuerySetCell( q_auth, "UMstatus","Error")>
</cfcatch>
</cftry>
</cfif>

<cfif responseHash[1] IS "UMauthCode">
<cftry>
<cfset nil = QuerySetCell( q_auth, "UMauthCode", URLDecode(responseHash[2]))>
<cfcatch>
<cfset nil = QuerySetCell( q_auth, "UMauthCode","000000")>
</cfcatch>
</cftry>
</cfif>

<cfif responseHash[1] IS "UMavsResult">
<cftry>
<cfset nil = QuerySetCell( q_auth, "UMavsResult", URLDecode(responseHash[2]))>
<cfcatch>
<cfset nil = QuerySetCell( q_auth, "UMavsResult","Invalid Response from USA ePay")>
</cfcatch>
</cftry>
</cfif>

<cfif responseHash[1] IS "UMavsResultCode">
<cftry>
<cfset nil = QuerySetCell( q_auth, "UMavsResultCode", URLDecode(responseHash[2]))>
<cfcatch>
<cfset nil = QuerySetCell( q_auth, "UMavsResultCode","n/a")>
</cfcatch>
</cftry>
</cfif>

<cfif responseHash[1] IS "UMcvv2Result">
<cftry>
<cfset nil = QuerySetCell( q_auth, "UMcvv2Result", URLDecode(responseHash[2]))>
<cfcatch>
<cfset nil = QuerySetCell( q_auth, "UMcvv2Result","n/a")>
</cfcatch>
</cftry>
</cfif>

<cfif responseHash[1] IS "UMcvv2ResultCode">
<cftry>
<cfset nil = QuerySetCell( q_auth, "UMcvv2ResultCode", URLDecode(responseHash[2]))>
<cfcatch>
<cfset nil = QuerySetCell( q_auth, "UMcvv2ResultCode","n/a")>
</cfcatch>
</cftry>
</cfif>

<cfif responseHash[1] IS "UMrefNum">
<cftry>
<cfset nil = QuerySetCell( q_auth, "UMrefNum", URLDecode(responseHash[2]))>
<cfcatch>
<cfset nil = QuerySetCell( q_auth, "UMrefNum","000000")>
</cfcatch>
</cftry>
</cfif>

<cfif responseHash[1] IS "UMversion">
<cftry>
<cfset nil = QuerySetCell( q_auth, "UMversion", URLDecode(responseHash[2]))>
<cfcatch>
<cfset nil = QuerySetCell( q_auth, "UMversion","n/a")>
</cfcatch>
</cftry>
</cfif>

<cfif responseHash[1] IS "UMresult">
<cftry>
<cfset nil = QuerySetCell( q_auth, "UMresult", URLDecode(responseHash[2]))>
<cfcatch>
<cfset nil = QuerySetCell( q_auth, "UMresult","n/a")>
</cfcatch>
</cftry>
</cfif>

<cfif responseHash[1] IS "UMerror">
<cftry>
<cfset nil = QuerySetCell( q_auth, "UMerror", URLDecode(responseHash[2]))>
<cfcatch>
<cfset nil = QuerySetCell( q_auth, "UMerror","n/a")>
</cfcatch>
</cftry>
</cfif>

<cfif responseHash[1] IS "UMfiller">
<cftry>
<cfset nil = QuerySetCell( q_auth, "UMfiller", URLDecode(responseHash[2]))>
<cfcatch>
<cfset nil = QuerySetCell( q_auth, "UMfiller","n/a")>
</cfcatch>
</cftry>
</cfif>
</cfloop>
</cfif>

<!----------------------------------------------------------------------
Set caller query object
---------------------------------------------------------------------->
<CFSET "Caller.#attributes.queryname#" = #q_auth#>