<cfprocessingdirective suppresswhitespace="Yes">
<cfif NOT isDefined("LoadedGlobalFooter")>
<cfset LoadedGlobalFooter = True>
<cfoutput>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table width="1020" align="center" border="0" cellspacing="0" cellpadding="0">	
	<tr>
		<td width="1020" align="center" valign="top">
			<img src="images/image-PageBackgroundFooter.jpg" border="0"><br>
			<table width="1000" border="0" cellpadding="0" cellspacing="3" align="center" style="padding-left:10px;">
				<tr> 					
					<td width="70%" class="cfDefault">
						We Kindly Accept: 
						<cfscript>
							if ( config.AllowCreditCards EQ 1 )
							{
								if ( config.AcceptVISA eq 1 )
									WriteOutput("<img src='images/logos/logo-VISA.gif' border='0' alt='We Accept VISA' align='absmiddle'>&nbsp;"); 
								if ( config.AcceptMC eq 1 )
									WriteOutput("<img src='images/logos/logo-MC.gif' border='0' alt='We Accept MasterCard' align='absmiddle'>&nbsp;");
								if ( config.AcceptDISC eq 1 )
									WriteOutput("<img src='images/logos/logo-DISC.gif' border='0' alt='We Accept Discover' align='absmiddle'>&nbsp;");
								if ( config.AcceptAMEX eq 1 )
									WriteOutput("<img src='images/logos/logo-AMEX.gif' border='0' alt='We Accept American Express' align='absmiddle'>&nbsp;");
							}
							if ( config.AllowECheck eq 1 )
								WriteOutput("<img src='images/logos/logo-ECheck.gif' border='0' alt='We Accept E-Checks' align='absmiddle'>&nbsp;");
							if ( config.AllowPayPal eq 1 )
								WriteOutput("<img src='images/logos/logo-PayPal.gif' border='0' alt='We Accept PayPal' align='absmiddle'>");
						</cfscript>
					</td>									
					<td width="30%" align="right" class="cfDefault">
						Copyright &copy; #Year(config.DateOfInception)#-#Year(NOW())# - #config.CompanyName#
                        <!--- Today's Date: #DateFormat(now(),"mmmm dd, yyyy")# --->
					</td>
				</tr>
			</table>
			
			<table width="1000" border="0" cellpadding="0" cellspacing="3" align="center" style="padding-left:10px;">
				<tr>					
					<td width="70%" class="cfDefault">
						<a href="#config.RootURL#/StorePolicies.cfm">Store Policy</a> | 
						<a href="#config.RootURL#/StorePrivacy.cfm">Privacy Policy</a> |
						<a href="#config.RootURL#/StoreDisclaimer.cfm">Disclaimer</a> |
						<a href="#config.RootURL#/StoreHelp.cfm">Ordering Help</a> |
						<cfif config.AllowAffiliates EQ 1 >
							<a href="#config.RootURL#/AF-Login.cfm">Affiliates</a> |
						</cfif>
						<a href="javascript:NewWindow('#config.RootURL#/Suggestions.cfm','Suggestions','425','375','yes');">Make A Suggestion</a>
					</td>
					<td width="30%" class="cfDefault" align="right"> 
						Site Designed By: <a href="http://www.tradestudios.com">Trade Studios</a>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<br /><br />

</body>
</html>
</cfoutput> 
</cfif>
</cfprocessingdirective>