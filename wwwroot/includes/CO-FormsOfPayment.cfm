<cfoutput>

<!--- CHECK IF CLIENT IS ALLOWING MULTIPLE FORMS OF PAYMENT --->
<cfset formSofPayment = application.AllowCreditCards + application.AllowPayPal + application.AllowOrderForm ><!--- + application.AllowECheck --->

<!--- 
	IF MULTIPLE FORMS OF PAYMENT ARE ACCEPTED, LIST THEM AS A RADIO BUTTON THAT CUSTOMER MUST SELECT FROM.
	OTHERWISE, SET FORM OF PAYMENT AS A HIDDEN FIELD.
--->

<table border="0" cellpadding="10" cellspacing="0" align="center">
<tr>
	<cfif application.AllowCreditCards EQ 1>
		<td class="cfMessageThree">
			<cfif FormSofPayment GT 1 >
				<cfinput type="radio" name="FormOfPayment" value="1" required="no" message="Please select a FORM OF PAYMENT before proceeding." onclick="this.form.submit()" >
			<cfelse>
				<cfset Form.FormOfPayment = 1 ><!--- TO SHOW CO-CreditCard.cfm --->
				<input type="hidden" name="FormOfPayment" value="1">
			</cfif>	
			Credit Card
			<cfscript>
				if ( application.AcceptVISA EQ 1 )
					WriteOutput("<img src='images/logos/icon-VI.gif' align='absmiddle' vspace='3'>&nbsp;");
				if ( application.AcceptMC EQ 1 )
					WriteOutput("<img src='images/logos/icon-MC.gif' align='absmiddle' vspace='3'>&nbsp;");
				if ( application.AcceptDISC EQ 1 )
					WriteOutput("<img src='images/logos/icon-DI.gif' align='absmiddle' vspace='3'>&nbsp;");
				if ( application.AcceptAMEX EQ 1 )
					WriteOutput("<img src='images/logos/icon-AE.gif' align='absmiddle' vspace='3'>&nbsp;");
			</cfscript><br>
		</td>
	</cfif>
	<cfif application.AllowPayPal EQ 1>
		<td class="cfMessageThree">
			<cfquery name="getPayPal" datasource="#application.dsn#">
				SELECT	PayPalAccount
				FROM	PGPayPal
				WHERE	PPID = 1
			</cfquery>
			<cfif getPayPal.RecordCount NEQ 0 AND getPayPal.PayPalAccount NEQ ''>
				<cfif FormSofPayment GT 1 >
					<cfinput type="radio" name="FormOfPayment" value="2" required="no" message="Please select a FORM OF PAYMENT before proceeding." onclick="this.form.submit()" >
				<cfelse>
					<input type="hidden" name="FormOfPayment" value="2">
				</cfif>
				PayPal <img src='images/logos/logo-PayPal.gif' align='absmiddle' vspace='3'><br>
			</cfif>
		</td>
	</cfif>
	<!---<cfif application.AllowECheck EQ 1>	
		<cfif FormSofPayment GT 1 >
			<cfinput type="radio" name="FormOfPayment" value="3" required="no" message="Please select a FORM OF PAYMENT before proceeding." onclick="this.form.submit()" >
		<cfelse>
			<input type="hidden" name="FormOfPayment" value="3">
		</cfif>
		E-Check <img src='images/logos/logo-ECheck.gif' align='absmiddle' vspace='3'><br>
	</cfif>--->
	<cfif application.AllowOrderForm EQ 1>
		<td class="cfMessageThree">
			<cfif FormSofPayment GT 1 >
				<cfinput type="radio" name="FormOfPayment" value="4" required="no" message="Please select a FORM OF PAYMENT before proceeding." onclick="this.form.submit()" >
			<cfelse>
				<input type="hidden" name="FormOfPayment" value="4">
			</cfif>
			Online Order Form <img src='images/logos/logo-OrderForm.gif' align='absmiddle' vspace='3'>
		</td>
	</cfif>
	<cfif application.AllowStoreCredit EQ 1>
		<cfquery name="getStoreCredit" datasource="#application.dsn#">
			SELECT	Credit
			FROM	Customers
			WHERE	CustomerID = '#session.CustomerArray[17]#'
		</cfquery>
		<cfif getStoreCredit.Credit GT 0 >
			<td style="padding-left:5px;">
				<div class="cfMessageThree" style="padding:0px 0px 5px 5px;">STORE CREDIT</div>
				<table width="100%" border="0" cellpadding="5" cellspacing="0">
					<tr>
						<td width="30" class="cfDefault"><img src='images/logos/logo-StoreCredit.gif' align='absmiddle' vspace='3'></td>
						<td width="*" class="cfDefault" style="padding-left:5px;">
							<cfset DisplayType = 0 >
							<cfinclude template="CalculateTotal.cfm">
							I have <u>$#DecimalFormat(getStoreCredit.Credit)#</u> in available store credit.<br/>
							I would like to apply
							$<cfinput type="text" name="CreditToApply" value="0.00" size="5" maxlength="10" class="cfFormField" required="no" validate="float" message="Please enter a dollar amount for the store credit you'd like to apply.\nDo not use a $ sign." />
							to my order total of <cfif isDefined('FORM.CreditToApply') AND FORM.CreditToApply GT 0 >$#DecimalFormat(RunningTotal + FORM.CreditToApply)#<cfelse><u>$#DecimalFormat(RunningTotal)#</u></cfif>.
							<input type="hidden" name="AvailableCredit" value="#Replace(getStoreCredit.Credit,',','','ALL')#">
						</td>
					</tr>
				</table>
			</td>
		</cfif>
	</cfif>

</tr>

<!--- CREDIT CARD FORM --->
<cfif application.AllowCreditCards EQ 1 AND isDefined('Form.FormOfPayment') AND Form.FormOfPayment EQ 1 >
	<tr><td colspan="4"><hr class="snip"></td></tr>
	<tr>
		<td colspan="4" class="cfTableHeading">
			<table width="70%" border="0" cellpadding="5" cellspacing="0">
				<tr>
					<td width="100%" class="cfDefault" style="padding-left:5px;">
						<cfinclude template="CO-CreditCard.cfm">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</cfif>
</table>

</cfoutput>