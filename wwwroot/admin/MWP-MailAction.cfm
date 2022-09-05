<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<HTML>
<HEAD>
<TITLE>MAILING LABELS</TITLE>
</HEAD>

<cfinclude template="MWP-ErrorChecking.cfm">
<cfinclude template="MWP-QueryCode.cfm">

<BODY style="margin:0px;" onLoad="return confirm('Mailing Labels: <cfoutput>#getMWP.RecordCount#</cfoutput> addresses have been selected. 30 per page. \n 1) Make sure to set the optimal print settings in File > Page Setup. \n 2) Clear the Header and Footer text boxes. \n 3) Set the Margins as follows: Top: 0.55 Bottom: 0.3 Left: 0.375 Right: 0.375')">

<TABLE WIDTH=795 CELLSPACING=0 CELLPADDING=0 BORDER=0>
<!--- BEGIN COLUMNAR OUTPUT --->
<cfoutput query="getMWP">
	<cfif CurrentRow MOD 3 IS 1>
		<tr><!--- bgcolor="#Iif(((CurrentRow MOD 2) is 0),de('Gainsboro'),"application.standardbgcolor")#"--->
	</cfif>
			<td class="cfAdminDefault" width="265" valign="top">
				<table border="0" height="98" cellpadding="0" cellspacing="0">
					<tr>
						<td valign="top">
							<TABLE CELLSPACING=0 CELLPADDING=0 BORDER=0>
								<TR>
									<TD nowrap><font face="arial" size=2><b>#FirstName# #LastName#</b></font></td>
								</TR>
								<TR>
									<TD nowrap><font face="arial" size=2>#CompanyName#</font></TD>
								</TR>
								<TR>
									<TD nowrap><font face="arial" size=2>#Address1#</font></TD>
								</TR>
								<TR>
									<TD nowrap><font face="arial" size=2>#Address2#</font></TD>
								</TR>
								<TR>
									<TD nowrap><font face="arial" size=2>#City#, #State# #Zip#</font></TD>
								</TR>
							</TABLE>
						</td>
					</tr>
				</table>
			</td>
	<cfif CurrentRow MOD 3 IS 0>
		</tr>
	</cfif>
</cfoutput>
<!--- If the query record count is not equally divisible by 3, --->
<!--- the last row was not close. --->
<!--- Determine how many more columns are needed, create them --->
<!--- and close the row. --->
<cfif getMWP.RecordCount MOD 3 IS NOT 0>
	<cfset ColsLeft = 3 - (getMWP.RecordCount MOD 3)>
	<cfif ColsLeft NEQ 1 AND ColsLeft NEQ 2>
		<cfloop from="1" to="#ColsLeft#" index="i">
			<td width="265">&nbsp;</td>
		</cfloop>
	</cfif>
		</tr>
</cfif>
</table>