<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<cfif isDefined('URL.ErrorMsg') AND URL.ErrorMsg EQ 1>
	<script language="JavaScript">
		{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
	</script>
</cfif>

<!--- BEGIN: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<cfif isDefined('form.UpdateProductType') AND IsDefined("form.TypeID")>
	<cfif isUserInRole('Administrator')>
		<cfupdate datasource="#application.dsn#" tablename="ProductTypes" 
			formfields="TypeID, TypeName, SpecCount,
			SpecTitle1, SpecTitle2, SpecTitle3, SpecTitle4, SpecTitle5, SpecTitle6, SpecTitle7, SpecTitle8, SpecTitle9, SpecTitle10,
			SpecTitle11, SpecTitle12, SpecTitle13, SpecTitle14, SpecTitle15, SpecTitle16, SpecTitle17, SpecTitle18, SpecTitle19, SpecTitle20 ">
		<cfset AdminMsg = 'Product Comparison Type Updated Successfully' >
	<cfelse>			
		<script language="JavaScript">
			{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
		</script>
	</cfif>
</cfif>

<!--- END: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<cfinvoke component="#application.Queries#" method="getProductType" returnvariable="getProductType">
	<cfinvokeargument name="TypeID" value="#TypeID#">
</cfinvoke>

<!--- BEGIN: HEADER --->
<cfscript>
	PageTitle = 'PRODUCT COMPARISON TYPE DETAIL';
	AddPage = 'ProductTypeAdd.cfm';
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">
<!--- END: HEADER --->

<cfoutput>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr style="background-color:##65ADF1;">
		<td width="50"  height="20" class="cfAdminHeader1">&nbsp; SPEC</td>
		<td width="200" height="20" class="cfAdminHeader1">TITLE</td>
		<td width="350" class="cfAdminHeader1"></td>
	</tr>
	<tr>
		<td colspan="3" height="5"></td>
	</tr>
</cfoutput>

<cfoutput query="getProductType">
<cfform action="ProductTypeDetail.cfm" method="post">
		<tr>
			<td nowrap><b>Compare Type Name:</b></td>
			<td><input type="text" name="TypeName" value="#TypeName#" size="70" class="cfAdminDefault"></td>
			<td></td>
		</tr>
		<tr>
			<td><b>## of Specs:</b></td>
			<td><input type="text" name="SpecCount" value="#SpecCount#" size="10" class="cfAdminDefault"> (number of specifications titles below)</td>
			<td></td>
		</tr>
		<tr><td colspan="3" height="5"></td></tr>
		<tr><td colspan="3" height="1" style="background-color:##CCCCCC;"></td></tr>
		<tr><td colspan="3" height="5"></td></tr>
	<cfloop from="1" to="20" index="i">
		<cfscript>
			ThisSpecTitle  = #Evaluate("SpecTitle" & i)#;
		</cfscript>
		<tr>
			<td>Spec Title #i#:</td>
			<td><input type="text" name="SpecTitle#i#" value="#ThisSpecTitle#" size="70" class="cfAdminDefault"></td>
			<td></td>
		</tr>
	</cfloop>
<input type="hidden" name="TypeID" value="#TypeID#">

	<tr>
		<td height="20" colspan="3"></td>
	</tr>
	<tr style="background-color:##F27028;">
		<td colspan="3" height="20" class="cfAdminHeader3" align="center">
			UPDATE ABOVE INFORMATION
		</td>
	</tr>
	<tr>
		<td height="20" colspan="3"></td>
	</tr>
	<tr>
		<td colspan="8" align="center">
			<input type="submit" name="UpdateProductType" value="UPDATE CHANGES" alt="Update Product Type" class="cfAdminButton">
		</td>
	</tr>
	<tr>
		<td height="20" colspan="8"></td>
	</tr>
</cfform>
</cfoutput>
</table>


<cfinclude template="LayoutAdminFooter.cfm">