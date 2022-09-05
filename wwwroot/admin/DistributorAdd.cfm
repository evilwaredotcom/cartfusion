<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<cfif isDefined('URL.ErrorMsg') AND URL.ErrorMsg EQ 1>
	<script language="JavaScript">
		{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
	</script>
</cfif>

<!--- BEGIN: QUERIES ------------------------------------->

<cfinvoke component="#application.Queries#" method="getStates" returnvariable="getStates"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getCountries" returnvariable="getCountries"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getPaymentTypes" returnvariable="getPaymentTypes"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getUsers" returnvariable="getUsers"></cfinvoke>

<!--- END: QUERIES ------------------------------------->

<!--- BEGIN: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<cfif isDefined('form.AddDistributorInfo') AND isDefined('Form.DistributorName') AND Form.DistributorName NEQ '' >
	<cfif isUserInRole('Administrator')>
	
		<!--- PREVENT DUPLICATE USERNAME --->
		<cfquery name="preventDuplicate" datasource="#application.dsn#">
			SELECT	DistributorName
			FROM	Distributors
			WHERE	DistributorName = '#Form.DistributorName#'
		</cfquery>
		
		<cfif preventDuplicate.RecordCount NEQ 0 >
			<cfset AdminMsg = 'ERROR: Distributor Name Already Taken.  Please choose an alternate.' >
		<cfelse>
			<cftry>
				<cfscript>
					Form.DateUpdated = #Now()# ;
					Form.UpdatedBy = #GetAuthUser()# ;
				</cfscript>
			
				<cfinsert datasource="#application.dsn#" tablename="Distributors" 
					formfields="DistributorName, RepName, Address1, Address2, City, State, ZipCode, Country, 
					Phone, AltPhone, Fax, Email, Comments, OrdersAcceptedBy, POFormat, DateUpdated, UpdatedBy, Deleted">
				
				<!--- GET NEWLY ASSIGNED SKU NUMBER --->
				<cfquery name="getAddedDID" datasource="#application.dsn#">
					SELECT	MAX(DistributorID) AS DistributorID
					FROM	Distributors
					WHERE	DistributorName = '#Form.DistributorName#'
				</cfquery>

				<cfif getAddedDID.RecordCount NEQ 0>				
					<cfset DistributorID = getAddedDID.DistributorID>
					<cfset AdminMsg = 'Distributor Added Successfully' >
					<cflocation url="DistributorDetail.cfm?DistributorID=#DistributorID#&AdminMsg=#URLEncodedFormat(AdminMsg)#" addtoken="no">
					<cfabort>
				</cfif>
			
				<cfcatch>
					<cfset AdminMsg = 'FAIL: Distributor NOT Added - #cfcatch.Message#' >
				</cfcatch>
			</cftry>
		</cfif>
	<cfelse>
		<script language="JavaScript">
			{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
		</script>	
	</cfif>
</cfif>
			
<!--- END: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<cfinvoke component="#application.Queries#" method="getStates" returnvariable="getStates"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getCountries" returnvariable="getCountries"></cfinvoke>

<!--- BEGIN: HEADER --->
<cfscript>
	PageTitle = 'ADD DISTRIBUTOR';
	QuickSearch = 1;
	QuickSearchPage = 'Distributors.cfm';
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">
<!--- END: HEADER --->

<cfoutput>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr style="background-color:##65ADF1;">
		<td width="49%" colspan="2" height="20" class="cfAdminHeader1">&nbsp; DISTRIBUTOR INFORMATION</td>
		<td width="1%"  rowspan="26" style="background-color:##FFFFFF;">&nbsp;</td>
		<td width="50%" colspan="2" class="cfAdminHeader1">&nbsp; CONTACT INFORMATION</td>
	</tr>
	<tr>
		<td colspan="5" height="5"></td>
	</tr>
<cfform action="DistributorAdd.cfm" method="post">
	<tr>
		<td width="10%" height="20">Distributor ID:</td>
		<td width="39%">TBD</td>
		<td width="10%"></td>
		<td width="40%"></td>
	</tr>
	<tr>
		<td>Distributor Name:</td>
		<td><cfinput type="text" name="DistributorName" size="40" class="cfAdminDefault" required="yes" message="Distributor Name Required"></td>
		<td>Rep Name:</td>
		<td><input type="text" name="RepName" size="40" class="cfAdminDefault"></td>
	</tr>
	<tr>
		<td>Address 1:</td>
		<td><input type="text" name="Address1" size="40" class="cfAdminDefault"></td>
		<td>Email:</td>
		<td><input type="text" name="Email" size="40" class="cfAdminDefault"></td>
	</tr>
	<tr>
		<td>Address 2:</td>
		<td><input type="text" name="Address2" size="40" class="cfAdminDefault"></td>
		<td>Orders Accepted By:</td>
		<td><input type="text" name="OrdersAcceptedBy" size="20" class="cfAdminDefault"></td>
	</tr>
	<tr>

		<td>City:</td>
		<td><input type="text" name="City" size="40" class="cfAdminDefault"></td>
		<td>PO Format:</td>
		<td>
			<select name="POFormat" size="1" class="cfAdminDefault">
				<option value="0">Default</option>
			</select>
		</td>
	</tr>
	<tr>
		<td>State:</td>
		<td>
			<cfselect name="State" query="getStates" size="1"  value="StateCode" display="State" selected="#application.CompanyState#" class="cfAdminDefault">

			</cfselect>
		</td>
		<td>Disabled:</td>
		<td><input type="checkbox" name="Deleted" ></td>
	</tr>
	<tr>
		<td>ZipCode/Postal Code:</td>
		<td><input type="text" name="ZipCode" size="20" class="cfAdminDefault"></td>
		<td></td>
		<td></td>
	</tr>
	<tr>
		<td>Country:</td>
		<td>
			<cfselect name="Country" query="getCountries" size="1" value="CountryCode" display="Country" selected="#application.CompanyCountry#" class="cfAdminDefault">

			</cfselect>
		</td>
		<td colspan="2" rowspan="3">
			Internal Comments:<br>
			<textarea name="Comments" cols="50" rows="3" class="cfAdminDefault"></textarea>
		</td>
	</tr>
	<tr>
		<td>Phone:</td>
		<td><input type="text" name="Phone" size="20" class="cfAdminDefault"></td>
	</tr>
	<tr>
		<td>Alt. Phone:</td>
		<td><input type="text" name="AltPhone" size="20" class="cfAdminDefault"></td>
	</tr>
	<tr>
		<td>Fax:</td>
		<td><input type="text" name="Fax" size="20" class="cfAdminDefault"></td>
	</tr>
	<tr>
		<td colspan="5" height="5"></td>
	</tr>
	<tr style="background-color:##F27028;">
		<td colspan="5" height="20" class="cfAdminHeader3" align="center">
			ADD THIS DISTRIBUTOR
		</td>
	</tr>
	<tr>
		<td height="20" colspan="5"></td>
	</tr>
	<tr>
		<td colspan="5" align="center">
			<input type="submit" name="AddDistributorInfo" value="ADD DISTRIBUTOR" alt="Add This Distributor" class="cfAdminButton">
		</td>
	</tr>
	<tr>
		<td height="20" colspan="5"></td>
	</tr>
</table>
</cfform>
</cfoutput>

<br><br><br>

<cfinclude template="LayoutAdminFooter.cfm">