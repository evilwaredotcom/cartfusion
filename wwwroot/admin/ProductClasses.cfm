<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<!--- BEGIN: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<cfif isDefined('form.UpdateProductClass') AND isDefined('Form.ICID') AND Form.ICID NEQ ''>
	<cfupdate datasource="#application.dsn#" tablename="ItemClasses" 
		formfields="ICID, Description, Dimensions, Title1, Title2, Title3, ClassType, ItemCode">
	<cfset AdminMsg = 'Product Class Updated Successfully' >
</cfif>

<cfif isDefined('Form.AddProductClass') AND isDefined('Form.Dimensions') AND Form.Dimensions NEQ ''>
	<cfinsert datasource="#application.dsn#" tablename="ItemClasses" 
		formfields="Description, Dimensions, Title1, Title2, Title3, ClassType, ItemCode">			
	<cfset AdminMsg = 'Product Class Added Successfully' >
</cfif>

<cfif isDefined('Form.DeleteProductClass') AND isDefined('Form.ICID') AND Form.ICID NEQ ''>
	<cfquery name="deleteClass" datasource="#application.dsn#">
		DELETE 
		FROM 	ItemClasses
		WHERE	ICID = #Form.ICID#
	</cfquery>
	<cfset AdminMsg = 'Product Class Deleted Successfully' >
</cfif>

<!--- END: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<!--- SET DEFAULT PARAMETERS --->
<cfparam name="URL.StartRow" default="1" type="numeric">
<cfparam name="URL.SortOption" default="ICID" type="string">
<cfparam name="URL.SortAscending" default="0" type="numeric">
<cfparam name="Form.Field" default="ALL" type="string">
<cfparam name="Form.string" default="" type="string">
<cfset string = Trim(string)>

<!--- BEGIN: SEARCH CRITERIA -------------------------------------------------->
<cfinvoke component="#application.Queries#" method="getItemClasses" returnvariable="getItemClasses"></cfinvoke>
<!--- END: SEARCH CRITERIA -------------------------------------------------->

<!--- NEXT N VALUES --->
<cfscript>
	RowsPerPage = 15;
	TotalRows = getItemClasses.RecordCount;
	EndRow = Min(URL.StartRow + RowsPerPage - 1, TotalRows);
 	StartRowNext = EndRow + 1;
 	StartRowBack = URL.StartRow - RowsPerPage;
</cfscript>

<!--- HEADER --->
<cfscript>
	PageTitle = 'INVENTORY MATRICES & PRODUCT CLASSES' ;
	QuickSearch = 0 ;
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">

<cfoutput>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td height="20" class="cfAdminTitle">ADD PRODUCT CLASS</td>
	</tr>
</table>

<table border="0" cellpadding="2" cellspacing="0" width="100%">	
<cfform action="ProductClasses.cfm" method="post">
	<tr style="background-color:##65ADF1;">
		<td width="5%"  class="cfAdminHeader1" nowrap>ID</td>
		<td width="10%" class="cfAdminHeader1" nowrap>Item Code</td>
		<td width="20%" class="cfAdminHeader1" nowrap>Description</td>
		<td width="10%" class="cfAdminHeader1" nowrap>Dimensions</td>
		<td width="10%" class="cfAdminHeader1" nowrap>Title 1</td>
		<td width="10%" class="cfAdminHeader1" nowrap>Title 2</td>
		<td width="10%" class="cfAdminHeader1" nowrap>Title 3</td>
		<td width="10%" class="cfAdminHeader1" nowrap>Class Type</td>
		<td width="15%" class="cfAdminHeader1" nowrap>&nbsp;</td><!--- DELETE --->
	</tr>
	<tr>
		<td>
			TBD
		</td>
		<td>
			<cfinput type="text" name="ItemCode" size="10" maxlength="25" class="cfAdminDefault" required="yes" message="Please enter a short item code for this product class.">
		</td>
		<td>
			<cfinput type="text" name="Description" size="20" maxlength="30" class="cfAdminDefault" required="yes" message="Please enter a description for this product class.">
		</td>
		<td>
			<select name="Dimensions" size="1" class="cfAdminDefault">
				<option value="1">1</option>
				<option value="2">2</option>
				<option value="3">3</option>
			</select>
		</td>
		<td>
			<cfinput type="text" name="Title1" size="15" maxlength="30" class="cfAdminDefault" required="no">
		</td>
		<td>
			<cfinput type="text" name="Title2" size="15" maxlength="30" class="cfAdminDefault" required="no">
		</td>
		<td>
			<cfinput type="text" name="Title3" size="15" maxlength="30" class="cfAdminDefault" required="no">
		</td>
		<td>
			<cfinput type="text" name="ClassType" size="3" maxlength="3" class="cfAdminDefault" required="no">
		</td>
		<td nowrap>
			<input type="submit" name="AddProductClass" value="ADD" alt="Add Product Class" class="cfAdminButton">
		</td>
	</tr>
</cfform>
</table>

<br>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr><td height="20" class="cfAdminTitle">PRODUCT CLASSES</td></tr>
</table>

<table border="0" cellpadding="2" cellspacing="0" width="100%">	
	<tr style="background-color:##65ADF1;">
		<td width="5%"  class="cfAdminHeader1" nowrap>ID</td>
		<td width="10%" class="cfAdminHeader1" nowrap>Item Code</td>
		<td width="20%" class="cfAdminHeader1" nowrap>Description</td>
		<td width="10%" class="cfAdminHeader1" nowrap>Dimensions</td>
		<td width="10%" class="cfAdminHeader1" nowrap>Title 1</td>
		<td width="10%" class="cfAdminHeader1" nowrap>Title 2</td>
		<td width="10%" class="cfAdminHeader1" nowrap>Title 3</td>
		<td width="10%" class="cfAdminHeader1" nowrap>Class Type</td>
		<td width="15%" class="cfAdminHeader1" nowrap>&nbsp;</td><!--- DELETE --->
	</tr>
</cfoutput>

<cfoutput query="getItemClasses" startrow="#StartRow#" maxrows="#RowsPerPage#">
	<cfform action="ProductClasses.cfm" method="post">
	<tr>
		<td>
			#ICID#
		</td>
		<td>
			<cfinput type="text" name="ItemCode" value="#ItemCode#" size="10" maxlength="25" class="cfAdminDefault" required="yes" message="Please enter a short item code for this product class.">
		</td>
		<td>
			<cfinput type="text" name="Description" value="#Description#" size="20" maxlength="30" class="cfAdminDefault" required="yes" message="Please enter a description for this product class.">
		</td>
		<td>
			<select name="Dimensions" size="1" class="cfAdminDefault">
				<option value="1" <cfif Dimensions EQ 1>selected</cfif>>1</option>
				<option value="2" <cfif Dimensions EQ 2>selected</cfif>>2</option>
				<option value="3" <cfif Dimensions EQ 3>selected</cfif>>3</option>
			</select>
		</td>
		<td>
			<cfinput type="text" name="Title1" value="#Title1#" size="15" maxlength="30" class="cfAdminDefault" required="no">
		</td>
		<td>
			<cfinput type="text" name="Title2" value="#Title2#" size="15" maxlength="30" class="cfAdminDefault" required="no">
		</td>
		<td>
			<cfinput type="text" name="Title3" value="#Title3#" size="15" maxlength="30" class="cfAdminDefault" required="no">
		</td>
		<td>
			<cfinput type="text" name="ClassType" value="#ClassType#" size="3" maxlength="3" class="cfAdminDefault" required="no">
		</td>
		<td nowrap>
			<input type="submit" name="UpdateProductClass" value="UPDATE" alt="Update Product Class" class="cfAdminButton">
			<input type="submit" name="DeleteProductClass" value="DELETE" alt="Delete Product Class" class="cfAdminButton"
				onclick="return confirm('Are you sure you want to DELETE THIS PRODUCT CLASS?')">
		</td>
	</tr>
	<!--- DIVIDER --->
	<tr><td height="1" colspan="9"><img src="images/image-LineGray.gif" width="100%" height="1"></td></tr>
	<input type="hidden" name="ICID" value="#ICID#">
	</cfform>
</cfoutput>


<!--- NAVIGATION ------------------------------------->
	<tr>
		<td colspan="4"><cfoutput>Displaying <b>#URL.StartRow#</b> to <b>#EndRow#</b> of <b>#TotalRows#</b> Product Classes</cfoutput></td>
		<td align="right" colspan="5"><cfinclude template="NextNButtons.cfm"></td>
	</tr>
<!--- NAVIGATION ------------------------------------->
</table>
	
<cfinclude template="LayoutAdminFooter.cfm">