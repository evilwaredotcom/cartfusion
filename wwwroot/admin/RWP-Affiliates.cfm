<cfscript>
	PageTitle = 'REPORT WIZARD PRO: Affiliates' ;
	BannerTitle = 'ReportWizard' ;
	AddAButton = 'RETURN TO REPORT WIZARD' ;
	AddAButtonLoc = 'RWP-ReportWizard.cfm' ;
	ReportPage = 'RWP-Affiliates.cfm' ;
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">

<style type="text/css">
	.small
	{ 
		font-size:9px; 
	}
</style>

<cfform method="post" action="RWP-AffiliatesAction.cfm" name="FAffiliates">
<table width="600" cellpadding="3" cellspacing="3" border="0">
	<tr>
		<td align="center" valign="middle" width="200"><img src="images/icon-Affiliates.jpg" width="120" height="120" border="0"></td>
		<td align="center" valign="top" width="400">

<table width="400" cellpadding="3" cellspacing="3" border="0" align="center">
	<tr style="background-color:##65ADF1;">
		<td align="center" class="cfAdminHeader1"><b>REPORT TYPE</b></td>
	</tr>
	<tr>
		<td class="cfAdminDefault" style="PADDING: 7px;">
			<input TYPE="radio" NAME="ReportType" VALUE="Summary" checked >Affiliate Sales/Expenses Summary<br/>
			<input TYPE="radio" NAME="ReportType" VALUE="Detail" >Affiliate Sales/Expenses Detail<br/>
			<input TYPE="radio" NAME="ReportType" VALUE="Payments" >Affiliate Payments Made<br/>
			<input TYPE="radio" NAME="ReportType" VALUE="PaymentsDue" >Affiliate Payments Due
		</td>
	</tr>
	<tr style="background-color:##65ADF1;">
		<td align="center" class="cfAdminHeader1"><b>TIME INTERVAL</b></td>
	</tr>
	<tr>
		<td align="center">
			<!---
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td width="50%" class="cfAdminDefault" align="right" style="padding-right:2px;">
						<cf_datepicker
							label="From:"
							textboxname="FromDate"
							formname="FAffiliates"
							image="images/button-calendar.gif"
							font="Tahoma" 
							fontcolor="black" 
							dayheadercolor="990000" 
							monthcolor="FFFFFF" 
							othermonthscolor="81C0EF" 
							backcolor="EEEEEE" 
							first_use_on_page="yes" 
							dateorder="mm/dd/yyyy"
							initialvalue="#DateFormat(application.DateOfInception,'mm/dd/yyyy')#" >
					</td>
					<td width="50%" class="cfAdminDefault" style="padding-left:2px;">
						<cf_datepicker
							label="To:"
							textboxname="ToDate"
							formname="FAffiliates"
							image="images/button-calendar.gif"
							initialvalue="#Month(Now())#/#Day(Now())#/#Year(Now())#" >
					</td>
				</tr>
			</table>
			--->
			From: <cfinput type="text" name="FromDate" size="15" class="cfAdminDefault" value="#Month(Now())#/01/#Year(Now())#" required="yes" validate="date" message="Please enter a FROM date in mm/dd/yyyy format\nClick the calendar for easy date selection">
				<cf_cal formname="FAffiliates" target="FromDate" image="images/button-calendar.gif">&nbsp;&nbsp;
			To: <cfinput type="text" name="ToDate" size="15" class="cfAdminDefault" value="#Month(Now())#/#Day(Now())#/#Year(Now())#" required="yes" validate="date" message="Please enter a TO date in mm/dd/yyyy format\nClick the calendar for easy date selection">
				<cf_cal formname="FAffiliates" target="ToDate" image="images/button-calendar.gif">
			
		</td>
	</tr>
	<tr style="background-color:##65ADF1;">
		<td class="cfAdminHeader1" align="center"><b>OPTIONS</b></td>
	</tr>
	<tr>
		<td>
			<table>
				<tr>
					<td valign="top" style="padding-top:4px;">SORT OPTION:</td>
					<td>
						<input TYPE="radio" NAME="SortOption" VALUE="ID" checked="checked">Affiliate ID<br/>
						<input TYPE="radio" NAME="SortOption" VALUE="Name">Affiliate Name<br/>
						<input TYPE="radio" NAME="SortOption" VALUE="Level">Affiliate Level/Membership
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td>
			<input type="checkbox" name="ExUnbilled">Don't Show Back Ordered and Unbilled Orders	 
		</td>
	</tr>
	<tr>
		<td>
			<input type="checkbox" name="ExCanceled">Don't Show Unpaid, Incomplete, Canceled, and Refunded Orders 
		</td>
	</tr>
	<tr style="background-color:##65ADF1;">
		<td align="center" class="cfAdminHeader1"><b>DISPLAY</b></td>
	</tr>
	<tr>
		<td align="center" class="cfAdminDefault" style="PADDING: 7px;">
			<input TYPE="radio" NAME="DisplayView" VALUE="screen" CHECKED>Online Viewing
			<img src="images/icon-IE.gif" border="0" align="absmiddle">&nbsp;
			<input TYPE="radio" NAME="DisplayView" VALUE="pdf">PDF/Print
			<img src="images/icon-PDF.gif" border="0" align="absmiddle">&nbsp;
		</td>
	</tr>
	<tr>
		<td class="cfAdminDefault" align="center"><br>
			<input TYPE="submit" NAME="build" VALUE="BUILD REPORT" class="cfAdminButton">
			<input TYPE="reset" NAME="reset" VALUE="RESET" class="cfAdminButton">
		</td>
	</tr>
</table>

		</td>
	</tr>
</table>
</cfform> 

<cfinclude template="LayoutAdminFooter.cfm">
