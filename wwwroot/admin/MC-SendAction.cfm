<cfinclude template="MC-ErrorChecking.cfm">
<cfinclude template="MC-QueryCode.cfm">

<cfif getMC.RecordCount NEQ 0>
	<cfset Customers = ValueList(getMC.CustomerID)>  <!--- CREATE LIST FROM QUERY --->
<cfelse>
	<!--- NO LIST CAN BE CREATED --->
	<cflocation url="MC-Send.cfm?ErrorMsg=8" addtoken="no">
	<cfabort>
</cfif>

<cfscript>
	PageTitle = 'CARTFUSION MESSAGE CENTER - PREPARE MESSAGE' ;
	BannerTitle = 'MessageCenterc' ;
	AddAButton = 'RETURN TO MESSAGE CENTER' ;
	AddAButtonLoc = 'MC-Home.cfm' ;
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">

<cfoutput>

<table width="100%" border="0" cellpadding="3" cellspacing="0" align="center">
<cfform name="MessageForm" action="MC-SendAction2.cfm" method="post">
	<tr style="background-color:##65ADF1;">
		<td colspan="2" class="cfAdminHeader1"><b>PREPARE MESSAGE FOR CUSTOMERS</b></td>
	</tr>
	<tr><td colspan="2" height="20"></td></tr>
	<cfif isDefined('ErrorMsg') AND ErrorMsg EQ 7>
	<tr>
		<td colspan="2" height="20" class="red" align="center">
			ERROR: Please fill in all fields.
		</td>		
	</tr>
	<tr><td colspan="2" height="20"></td></tr>
	</cfif>
	<tr>
		<td width="10%" align="right"><b>To: </b></td>
		<td><cfselect query="getMC" name="CustomerList" value="CustomerInfo" display="CustomerInfo" size="3" class="cfAdminDefault" /></td>
	</tr>
	<tr>
		<td width="10%" align="right" class="cfAdminDefault" valign="top"><b>Message: </b></td>
		<td>
			<cfmodule 
				template="FCKeditor/fckeditor.cfm"
				basepath="FCKeditor/"
				instancename="Message"
				value=''
				width="610"
				height="300"
				toolbarset="CartFusion"
			>
		</td>
	</tr>
	<tr>
		<td width="10%" align="right" valign="middle"><b>Valid From: </b></td>
		<td valign="top">
				<input type="text" name="ValidFromDate" value="<cfoutput>#DateFormat(Now(), "mm/dd/yyyy")#</cfoutput>" size="12" class="cfAdminDefault" align="top">
				<cf_cal formname="MessageForm" target="ValidFromDate" image="images/button-calendar.gif">&nbsp;&nbsp;
				<select name="ValidFromHour" class="cfAdminDefault" align="absmiddle">
					<option>1</option><option>2</option><option>3</option><option>4</option><option>5</option><option>6</option>
					<option>7</option><option>8</option><option>9</option><option>10</option><option>11</option><option selected>12</option>
				</select>:
				<select name="ValidFromMin" class="cfAdminDefault" align="absmiddle">
					<option selected>00</option><option>15</option><option>30</option><option>45</option><option>59</option>
				</select>
				<select name="ValidFromAMPM" class="cfAdminDefault" align="absmiddle">
					<option selected>AM</option><option>PM</option>
				</select>
		</td>
	</tr>
	<tr>
		<td width="10%" align="right" valign="middle"><b>Valid To: </b></td>
		<td valign="top">
				<input type="text" name="ValidToDate" size="12" class="cfAdminDefault" align="top">
				<cf_cal formname="MessageForm" target="ValidToDate" image="images/button-calendar.gif">&nbsp;&nbsp;
				<select name="ValidToHour" class="cfAdminDefault" align="absmiddle">
					<option>1</option><option>2</option><option>3</option><option>4</option><option>5</option><option>6</option>
					<option>7</option><option>8</option><option>9</option><option>10</option><option selected>11</option><option>12</option>
				</select>:
				<select name="ValidToMin" class="cfAdminDefault" align="absmiddle">
					<option>00</option><option>15</option><option>30</option><option>45</option><option selected>59</option>
				</select>
				<select name="ValidToAMPM" class="cfAdminDefault" align="absmiddle">
					<option>AM</option><option selected>PM</option>
				</select>
 		</td>
	</tr>
	<tr><td colspan="2" height="20"></td></tr>	
	<tr>
		<td></td>
		<td style="padding-bottom:15px;">
			<input type="hidden" name="Customers" value="<cfoutput>#Customers#</cfoutput>">
			<input type="button" name="GoBack" value="<< GO BACK" alt="Go back to previous page" class="cfAdminButton"
				onclick="document.location.href='MC-Send.cfm'">
			<input type="reset" name="ResetMessage" value="RESET" alt="Reset this message" class="cfAdminButton">
			<input type="submit" name="SubmitMessage" value="SEND THIS MESSAGE >>" style="color:FF6600;" alt="Send this message to selected customers" class="cfAdminButton">
		</td>
	</tr>
</table>
</cfform>
</cfoutput>

<cfinclude template="LayoutAdminFooter.cfm">