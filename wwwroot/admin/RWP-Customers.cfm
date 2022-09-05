<cfinvoke component="#application.Queries#" method="getUsers" returnvariable="getUsers"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getCustomers" returnvariable="getCustomers"></cfinvoke>

<cfscript>
	PageTitle = 'REPORT WIZARD PRO: Customers' ;
	BannerTitle = 'ReportWizard' ;
	AddAButton = 'RETURN TO REPORT WIZARD' ;
	AddAButtonLoc = 'RWP-ReportWizard.cfm' ;
	ReportPage = 'RWP-Customers.cfm' ;
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">
<cfinclude template="JSCodeRWPC.cfm">

<style type="text/css">
	.small
	{ 
		font-size:9px; 
	}
</style>

<cfform method="post" action="RWP-CustomersAction.cfm" name="FCustomers">
<table width="600" cellpadding="3" cellspacing="3" border="0">
	<tr>
		<td align="center" valign="middle" width="200"><img src="images/icon-Customers.jpg" width="120" height="120" border="0"></td>
		<td align="center" valign="top" width="400">

<table width="400" cellpadding="3" cellspacing="3" border="0" align="center">
	<tr style="background-color:##65ADF1;">
		<td align="center" class="cfAdminHeader1"><b>REPORT TYPE</b></td>
	</tr>
	<tr>
		<td class="cfAdminDefault" style="PADDING: 3px;">
			<table width="100%" border="0" cellpadding="0" cellspacing="2">
				<tr>
					<td width="100%" class="cfAdminDefault">
						<input TYPE="radio" NAME="ReportType" VALUE="Summary" checked >Customer Sales Summary<br>
						<input TYPE="radio" NAME="ReportType" VALUE="Detail" >Customer Sales Detail
					</td>
				</tr>
				<tr>
					<td height="1" style="background-color:##CCCCCC;" colspan="2"></td>
				</tr>
				<tr>
					<td width="100%" class="cfAdminDefault">
						<input TYPE="radio" NAME="ReportType" VALUE="Info" >Customer Address & Phone Number List<br>
						<input TYPE="radio" NAME="ReportType" VALUE="PhoneList" >Customer Phone Number List
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr style="background-color:##65ADF1;">
		<td align="center" class="cfAdminHeader1"><b>REPORT DETAIL</b></td>
	</tr>
	<tr>
		<td class="cfAdminDefault" style="PADDING: 7px;">
			<table width="100%" border="0" cellpadding="0" cellspacing="3">
				<tr>
					<td class="small" nowrap><input TYPE="radio" NAME="ReportDetail" VALUE="All" checked >All Customers</td>
					<td class="small" nowrap><input TYPE="radio" NAME="ReportDetail" VALUE="ByUser" >By User</td>
					<td class="small" nowrap><input TYPE="radio" NAME="ReportDetail" VALUE="ThisCustomer" >This Customer</td>
				</tr>
				<tr>
					<td height="1" bgcolor="FFFFFF"></td>
					<td height="1" style="background-color:##CCCCCC;"></td>
					<td height="1" style="background-color:##CCCCCC;"></td>
				</tr>
				<tr>
					<td></td>
					<td nowrap>
						<select name="SelectedUser" size="1" class="small" >
							<option value="" selected></option>
						<cfoutput query="getUsers">
							<option value="#UID#">#UName#</option>
						</cfoutput>
						</select>
					</td>
					<td nowrap>
						<select name="SelectedCustomer" size="1" class="small" >
							<option value="" selected></option>
						<cfoutput query="getCustomers">
							<option value="#CustomerID#">#CustomerInfo#</option>
						</cfoutput>
						</select>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr style="background-color:##65ADF1;">
		<td align="center" class="cfAdminHeader1"><b>CHART TYPE</b></td>
	</tr>
	<tr>
		<td align="center" class="cfAdminDefault" style="PADDING: 7px;">
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td width="32%" class="cfAdminDefault" align="center">
						<input TYPE="radio" NAME="ChartType" VALUE="bar" CHECKED>Bar
						<img src="images/icon-barchart.gif" border="0" align="absmiddle" vspace="2">
					</td>
					<td width="2%" rowspan="3"></td>
					<td width="32%" class="cfAdminDefault" align="center">
						<input TYPE="radio" NAME="ChartType" VALUE="pie">Pie
						<img src="images/icon-piechart.gif" border="0" align="absmiddle" vspace="2"><br/>
					</td>
					<td width="2%" rowspan="3"></td>
					<td width="32%" class="cfAdminDefault" align="center">
						<input TYPE="radio" NAME="ChartType" VALUE="none">No Chart
					</td>
				</tr>
				<tr>
					<td height="1" style="background-color:##CCCCCC;"></td>
					<td height="1" style="background-color:##CCCCCC;"></td>
					<td height="1" style="background-color:##CCCCCC;"></td>
				</tr>
				<tr>
					<td width="32%" class="cfAdminDefault" align="center"></td>
					<td width="32%" class="cfAdminDefault" align="center">
						<input TYPE="radio" NAME="PieStyle" VALUE="sliced" CHECKED>Sliced
						<input TYPE="radio" NAME="PieStyle" VALUE="solid">Solid
					</td>
					<td width="32%" class="cfAdminDefault" align="center"></td>
				</tr>
			</table>			
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
							formname="FCustomers"
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
							formname="FCustomers"
							image="images/button-calendar.gif"
							initialvalue="#Month(Now())#/#Day(Now())#/#Year(Now())#" >
					</td>
				</tr>
			</table>
			--->
			From: <cfinput type="text" name="FromDate" size="15" class="cfAdminDefault" value="#Month(Now())#/01/#Year(Now())#" required="yes" validate="date" message="Please enter a FROM date in mm/dd/yyyy format\nClick the calendar for easy date selection">
				<cf_cal formname="FCustomers" target="FromDate" image="images/button-calendar.gif">&nbsp;&nbsp;
			To: <cfinput type="text" name="ToDate" size="15" class="cfAdminDefault" value="#Month(Now())#/#Day(Now())#/#Year(Now())#" required="yes" validate="date" message="Please enter a TO date in mm/dd/yyyy format\nClick the calendar for easy date selection">
				<cf_cal formname="FCustomers" target="ToDate" image="images/button-calendar.gif">
			
		</td>
	</tr>
	<tr style="background-color:##65ADF1;">
		<td class="cfAdminHeader1" align="center"><b>OPTIONS</b></td>
	</tr>
	<tr>
		<td>SORT OPTION:
			<input TYPE="radio" NAME="SortOption" VALUE="CustomerNet" CHECKED>Customer Income
			<input TYPE="radio" NAME="SortOption" VALUE="CustomerName">Customer Name
		</td>
	</tr>
	<tr>
		<td>
			<input type="checkbox" name="ExCustomerDetails">Don't Show Customer Details
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
