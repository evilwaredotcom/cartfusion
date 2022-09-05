<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<!--- BEGIN: HEADER --->
<cfscript>
	PageTitle = 'ADD PRODUCT COMPARISON TYPE';
	AddPage = 'ProductTypeAdd.cfm';
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">
<!--- END: HEADER --->

<cfif isDefined('URL.ErrorMsg') AND URL.ErrorMsg EQ 1>
	<script language="JavaScript">
		{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
	</script>
</cfif>

<!--- BEGIN: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<cfif isDefined('form.AddProductType') AND IsDefined("form.TypeName") AND form.TypeName NEQ ''>
	<cfif isUserInRole('Administrator')>
		<!--- PREVENT DUPLICATE --->
		<cfquery name="preventDuplicates" datasource="#application.dsn#">
			SELECT 	TypeName
			FROM	ProductTypes	
			WHERE	TypeName = '#Form.TypeName#'
		</cfquery>
		<cfif preventDuplicates.RecordCount EQ 0>
			<cftry>
			
				<cfinsert datasource="#application.dsn#" tablename="ProductTypes" 
					formfields="TypeName, SpecCount,
					SpecTitle1, SpecTitle2, SpecTitle3, SpecTitle4, SpecTitle5, SpecTitle6, SpecTitle7, SpecTitle8, SpecTitle9, SpecTitle10,
					SpecTitle11, SpecTitle12, SpecTitle13, SpecTitle14, SpecTitle15, SpecTitle16, SpecTitle17, SpecTitle18, SpecTitle19, SpecTitle20 ">
					
				<!--- GET NEWLY ASSIGNED SKU NUMBER --->
				<cfquery name="getAddedTypeID" datasource="#application.dsn#">
					SELECT	MAX(TypeID) AS TypeID
					FROM	ProductTypes
				</cfquery>
				
				<cfif getAddedTypeID.RecordCount NEQ 0>				
					<cfset TypeID = getAddedTypeID.TypeID>
					<cfset AdminMsg = 'Product Comparison Type Added Successfully' >
					<cflocation url="ProductTypeDetail.cfm?TypeID=#TypeID#&AdminMsg=#URLEncodedFormat(AdminMsg)#" addtoken="no">
					<cfabort>
				</cfif>	
					
				<cfcatch>
					<cfset AdminMsg = 'FAIL: Product Comparison Type NOT Added - #cfcatch.Message#' >
				</cfcatch>	
			</cftry>
		<cfelse>
			<cfset AdminMsg = 'Product Comparison Type "<cfoutput>#Form.TypeName#</cfoutput>" Already Taken' >
		</cfif>
		
		
	<cfelse>			
		<script language="JavaScript">
			{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
		</script>
	</cfif>
</cfif>

<!--- END: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<cfoutput>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr style="background-color:##65ADF1;">
		<td width="50" height="20" class="cfAdminHeader1">&nbsp; SPEC</td>
		<td width="200" height="20" class="cfAdminHeader1">TITLE</td>
		<td width="350" class="cfAdminHeader1"></td>
	</tr>
	<tr>
		<td colspan="3" height="5"></td>
	</tr>
	
<cfform action="ProductTypeAdd.cfm" method="post">
		<tr>
			<td nowrap><b>Compare Type Name:</b></td>
			<td><input type="text" name="TypeName" size="70" class="cfAdminDefault"></td>
			<td></td>
		</tr>
		<tr>
			<td><b>Number of Specs:</b></td>
			<td><input type="text" name="SpecCount" size="10" class="cfAdminDefault"> (number of specifications titles below)</td>
			<td></td>
		</tr>
		<tr><td colspan="3" height="5"></td></tr>
		<tr><td colspan="3" height="1" style="background-color:##CCCCCC;"></td></tr>
		<tr><td colspan="3" height="5"></td></tr>
	<cfloop from="1" to="20" index="i">
		<tr>
			<td>Spec Title #i#:</td>
			<td><input type="text" name="SpecTitle#i#"  size="70" class="cfAdminDefault"></td>
			<td></td>
		</tr>
	</cfloop>
	<tr>
		<td height="20" colspan="3"></td>
	</tr>
	<tr style="background-color:##F27028;">
		<td colspan="3" height="20" class="cfAdminHeader3" align="center">
			ADD THIS PRODUCT COMPARISON TYPE
		</td>
	</tr>
	<tr>
		<td height="20" colspan="3"></td>
	</tr>
	<tr>
		<td colspan="3" align="center">
			<input type="submit" name="AddProductType" value="ADD PRODUCT TYPE" alt="Add Product Type" class="cfAdminButton">
		</td>
	</tr>
	<tr>
		<td height="20" colspan="8"></td>
	</tr>
</cfform>
</table>

</cfoutput>


<cfinclude template="LayoutAdminFooter.cfm">