<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<!--- BEGIN: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->
<cfif isDefined('form.UpdateDistributorInfo') AND IsDefined("form.DistributorID")>
	<!--- PREVENT DUPLICATE USERNAME --->
	<cfif IsUserInRole('Administrator')>
		<cftry>
			<cfscript>
				Form.DateUpdated = #Now()# ;
				Form.UpdatedBy = #GetAuthUser()# ;
			</cfscript>
			
			<cfupdate datasource="#application.dsn#" tablename="Distributors" 
				formfields="DistributorID, DistributorName, RepName, Address1, Address2, City, State, ZipCode, Country, 
							Phone, AltPhone, Fax, Email, Comments, OrdersAcceptedBy, POFormat, DateUpdated, UpdatedBy, Deleted">
				<cfset AdminMsg = 'Distributor <cfoutput>#DistributorID#</cfoutput> Information Updated' >

			<cfcatch>
				<cfset AdminMsg = 'FAIL: Distributor NOT Updated.' >
			</cfcatch>
		</cftry>
	<cfelse>
		<script language="JavaScript">
			{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
		</script>
	</cfif>
</cfif>
<!--- END: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<cfinvoke component="#application.Queries#" method="getDistributor" returnvariable="getDistributor">
	<cfinvokeargument name="DistributorID" value="#DistributorID#">
</cfinvoke>
<cfinvoke component="#application.Queries#" method="getOrdersDist" returnvariable="getOrdersDist">
	<cfinvokeargument name="DistributorID" value="#DistributorID#">
</cfinvoke>

<!---
<cfinvoke component="#application.Queries#" method="getDistributorOrders" returnvariable="getDistributorOrders">
	<cfinvokeargument name="DistributorID" value="#DistributorID#">
</cfinvoke>
--->

<cfinvoke component="#application.Queries#" method="getStates" returnvariable="getStates"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getCountries" returnvariable="getCountries"></cfinvoke>

<!--- BEGIN: HEADER --->
<cfscript>
	PageTitle = 'DISTRIBUTOR DETAIL';
	QuickSearch = 1;
	QuickSearchPage = 'Distributors.cfm';
	AddPage = 'DistributorAdd.cfm';
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
</cfoutput>

<cfoutput query="getDistributor">	
<cfform action="DistributorDetail.cfm" method="post">
	<tr>
		<td width="10%" height="20">Distributor ID:</td>
		<td width="39%">#DistributorID#</td>
		<td width="10%"></td>
		<td width="40%"></td>
	</tr>
	<tr>
		<td>Distributor Name:</td>
		<td><input type="text" name="DistributorName" value="#DistributorName#" size="40" class="cfAdminDefault"></td>
		<td>Rep Name:</td>
		<td><input type="text" name="RepName" value="#RepName#" size="40" class="cfAdminDefault"></td>
	</tr>
	<tr>
		<td>Address 1:</td>
		<td><input type="text" name="Address1" value="#Address1#" size="40" class="cfAdminDefault"></td>
		<td>Email:</td>
		<td><input type="text" name="Email" value="#Email#" size="40" class="cfAdminDefault"></td>
	</tr>
	<tr>
		<td>Address 2:</td>
		<td><input type="text" name="Address2" value="#Address2#" size="40" class="cfAdminDefault"></td>
		<td>Orders Accepted By:</td>
		<td><input type="text" name="OrdersAcceptedBy" value="#OrdersAcceptedBy#" size="20" class="cfAdminDefault"></td>
	</tr>
	<tr>
		<td>City:</td>
		<td><input type="text" name="City" value="#City#" size="40" class="cfAdminDefault"></td>
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
			<cfselect name="State" query="getStates" size="1"  value="StateCode" display="State" selected="#State#" class="cfAdminDefault">
				<cfif State EQ ''>
					<option value="" selected>-- SELECT STATE --</option>
				<cfelse>
					<option value="">-- SELECT STATE --</option>
				</cfif>
			</cfselect>
		</td>
		<td>Disabled:</td>
		<td><input type="checkbox" name="Deleted" <cfif Deleted EQ 1 > checked </cfif> ></td>
	</tr>
	<tr>
		<td>ZipCode/Postal Code:</td>
		<td><input type="text" name="ZipCode" value="#ZipCode#" size="20" class="cfAdminDefault"></td>
		<td></td>
		<td></td>
	</tr>
	<tr>
		<td>Country:</td>
		<td>
			<cfselect name="Country" query="getCountries" size="1" value="CountryCode" display="Country" selected="#Country#" class="cfAdminDefault">
				<cfif Country EQ ''>
					<option value="" selected>-- SELECT COUNTRY --</option>
				<cfelse>
					<option value="">-- SELECT COUNTRY --</option>
				</cfif>
			</cfselect>
		</td>
		<td colspan="2" rowspan="3">
			Internal Comments:<br>
			<textarea name="Comments" cols="50" rows="3" class="cfAdminDefault">#Comments#</textarea>
		</td>
	</tr>
	<tr>
		<td>Phone:</td>
		<td><input type="text" name="Phone" value="#Phone#" size="20" class="cfAdminDefault"></td>
	</tr>
	<tr>
		<td>Alt. Phone:</td>
		<td><input type="text" name="AltPhone" value="#AltPhone#" size="20" class="cfAdminDefault"></td>
	</tr>
	<tr>
		<td>Fax:</td>
		<td><input type="text" name="Fax" value="#Fax#" size="20" class="cfAdminDefault"></td>
	</tr>
	<tr>
		<td colspan="5" height="5"></td>
	</tr>
	<tr style="background-color:##F27028;">
		<td colspan="5" height="20" class="cfAdminHeader3" align="center">
			UPDATE ABOVE INFORMATION
		</td>
	</tr>
	<tr>
		<td height="20" colspan="5"></td>
	</tr>
	<tr>
		<td colspan="5" align="center">
			<input type="submit" name="UpdateDistributorInfo" value="UPDATE CHANGES" alt="Update Distributor Information" class="cfAdminButton">
		</td>
	</tr>
	<tr>
		<td height="20" colspan="5"></td>
	</tr>
</table>
<input type="hidden" name="DistributorID" value="#DistributorID#">	
</cfform>
</cfoutput>

<!--- SET DEFAULT PARAMETERS --->
<cfparam name="URL.StartRow" default="1" type="numeric">
<cfparam name="URL.PageRows" default="0" type="numeric">
<cfparam name="URL.SortOption" default="LastName" type="string">
<cfparam name="URL.SortAscending" default="1" type="numeric">

<!--- NEXT N VALUES --->
<cfscript>
	PageRows = 0;
	RowsPerPage = 10;
	TotalRows = getOrdersDist.RecordCount;
	// FIND THESE STATEMENTS AFTER PROCESSING PAGE
	// EndRow = Min(URL.StartRow + RowsPerPage - 1, TotalRows);
 	// StartRowNext = EndRow + 1;
 	// StartRowBack = URL.StartRow - RowsPerPage;
</cfscript>

<!--- DISTRIBUTOR ORDERS --->

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td height="20" width="33%" class="cfAdminTitle">DISTRIBUTOR ORDERS</td>
		<td width="33%" align="center"></td>
		<td width="33%" align="right">
			<cfoutput>
			<input type="submit" name="SendOrdersDist" value="SEND ORDERS TO DISTRIBUTOR" alt="Send Open Orders to Distributor" class="cfAdminButton"
				onclick="document.location.href='DistOrdersSend.cfm?DistributorID=#DistributorID#'">
			</cfoutput>
		</td>
	</tr>
</table>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr style="background-color:##65ADF1;">
		<td width="10%" height="20" class="cfAdminHeader2" nowrap>&nbsp; OrderID</td>
		<td width="10%" height="20" class="cfAdminHeader2" nowrap>CustomerID</td>
		<td width="10%" height="20" class="cfAdminHeader2" align="center" nowrap># of Products</td>
		<td width="10%" height="20" class="cfAdminHeader2" align="right" nowrap>Product Costs</td>
		<td width="10%" height="20" class="cfAdminHeader2" align="center" nowrap>Date</td>
		<td width="50%" height="20" class="cfAdminHeader2" nowrap>Shipped</td>
	</tr>
<cfoutput query="getOrdersDist" group="OrderID" startrow="#StartRow#" maxrows="#RowsPerPage#">
	<cfscript>
		// IMPORTANT ROW COUNTER - MUST GO HERE
		PageRows = PageRows + QtySum ;
	</cfscript>
	<tr>
		<td height="20">&nbsp; <a href="OrderDetail.cfm?OrderID=#OrderID#">#OrderID#</a></td>
		<td><a href="CustomerDetail.cfm?CustomerID=#CustomerID#">#CustomerID#</a></td>
		<td align="center">#QtySum#</td>
		<td align="right">#LSCurrencyFormat(CostSum)#</td>
		<td align="center">#DateFormat(DateEntered, 'mm/dd/yy')#</td>
		<td>
			<!--- GET ALL ITEMS FROM ORDER - IF ALL SHIPPED, THEN SHOW CHECKED --->
			<cfquery name="checkIfShipped" datasource="#application.dsn#">
				SELECT	OrderItemsID
				FROM	OrderItems
				WHERE	OrderID = #OrderID#
				AND		(StatusCode = 'PR'
				OR		 StatusCode = 'BP')
			</cfquery>
			Y<input type="radio" name="DistShipped#CurrentRow#" value="SH" <cfif checkIfShipped.RecordCount EQ 0 >checked</cfif>
				onclick="updateInfo(#OrderID#,this.value,#getDistributor.DistributorID#,'DistShipped');" >&nbsp;
			N<input type="radio" name="DistShipped#CurrentRow#" value="PR" <cfif checkIfShipped.RecordCount GT 0 >checked</cfif>
				onclick="updateInfo(#OrderID#,this.value,#getDistributor.DistributorID#,'DistShipped');" >
		</td>
	</tr>
	<tr>
		<td colspan="6" height="1" style="background-color:##CCCCCC;"></td>
	</tr>
</cfoutput>

<!--- PROCESS THIS STATEMENT AFTER PROCESSING QUERIES AND LOOPS TO GET TOTAL ITEMS, NOT ORDERS, FOR NEXT/PREV NAVIGATION --->
<cfscript>
	EndRow = Min(URL.StartRow + PageRows - 1, TotalRows);
	StartRowNext = EndRow + 1;
	StartRowBack = URL.StartRow - URL.PageRows;
</cfscript>
<!--- NAVIGATION ------------------------------------->
	<tr>
		<td class="cfAdminDefault" colspan="2"><cfoutput>Displaying <b>#URL.StartRow#</b> to <b>#EndRow#</b> of <b>#TotalRows#</b> Ordered Products</cfoutput></td>
		<td align="right" colspan="4"><cfinclude template="NextNButtons.cfm"></td>
	</tr>
<!--- NAVIGATION ------------------------------------->
</table>

<br><br><br>

<cfinclude template="LayoutAdminFooter.cfm">