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

<BODY onLoad="return confirm('Customer List: <cfoutput>#getMWP.RecordCount#</cfoutput> customers have been selected.')">

<h2>CUSTOMER LIST</h2>

<TABLE WIDTH=795 CELLSPACING=0 CELLPADDING=0 BORDER=0>
<!--- BEGIN COLUMNAR OUTPUT --->
<cfoutput query="getMWP">
	<cfif CurrentRow MOD 3 IS 1>
		<tr><!--- bgcolor="#Iif(((CurrentRow MOD 2) is 0),de('Gainsboro'),"application.standardbgcolor")#"--->
	</cfif>
			<td class="cfAdminDefault" width="265" valign="top">
				<table border="0" height="96.5" cellpadding="0" cellspacing="0">
					<tr>
						<td>
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
								<cfif Address2 NEQ ''>
								<TR>
									<TD nowrap><font face="arial" size=2>#Address2#</font></TD>
								</TR>
								</cfif>
								<TR>
									<TD nowrap><font face="arial" size=2>#City#, #State# #Zip#</font></TD>
								</TR>
								<TR>
									<TD nowrap><font face="arial" size=2>Phone: #Phone#</font></TD>
								</TR>
								<cfif Fax NEQ ''>
								<TR>
									<TD nowrap><font face="arial" size=2>Fax: #Fax#</font></TD>
								</TR>
								</cfif>
								<TR>
									<TD nowrap><font face="arial" size=2>Date Created: #DateFormat(DateCreated, 'mm-dd-yyyy')#</font></TD>
								</TR>
								<TR>
									<TD nowrap>&nbsp;</TD>
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