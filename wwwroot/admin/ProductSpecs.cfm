<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<!--- BEGIN: HEADER --->
<cfscript>
	PageTitle = 'PRODUCT SPECIFICATIONS';
	ModeAllow = 0 ;
	QuickSearch = 0;
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

<cfif isDefined('form.UpdateProductSpecs') AND IsDefined("form.ItemID")>
	<cfif isUserInRole('Administrator')>
		
		<cfif IsDefined("form.SpecID")>
			<cfupdate datasource="#application.dsn#" tablename="ProductSpecs" 
				formfields="SpecID, ItemID, ProductType, 
				Spec1, Spec2, Spec3, Spec4, Spec5, Spec6, Spec7, Spec8, Spec9, Spec10,
				Spec11, Spec12, Spec13, Spec14, Spec15, Spec16, Spec17, Spec18, Spec19, Spec20 ">
		<cfelse>
			<cfinsert datasource="#application.dsn#" tablename="ProductSpecs" 
				formfields="ItemID, ProductType, 
				Spec1, Spec2, Spec3, Spec4, Spec5, Spec6, Spec7, Spec8, Spec9, Spec10,
				Spec11, Spec12, Spec13, Spec14, Spec15, Spec16, Spec17, Spec18, Spec19, Spec20 ">
		</cfif>
		<cfset AdminMsg = 'Specifications Updated Successfully' >
	<cfelse>			
		<script language="JavaScript">
			{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
		</script>
	</cfif>
</cfif>

<!--- END: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<!--- GET TypeID FOR THE PRODUCT SO YOU CAN LOOKUP TO SEE IF IT HAS ANY SPECS IN Tables.ProductSpecs --->
<cfquery name="getTypeID" datasource="#application.dsn#">
	SELECT	CompareType, 
			(
			SELECT	ItemID
			FROM	ProductSpecs
			WHERE	ItemID = #ItemID#
			) AS foundItemID
	FROM	Products
	WHERE	ItemID = #ItemID#
</cfquery>

<!--- IF THE PRODUCT HAS A CompareType(TypeID), GET THE ProductType INFORMATION ---
<cfif getTypeID.RecordCount NEQ ''>
	<cfinvoke component="#application.Queries#" method="getProductType" returnvariable="getProductType">
		<cfinvokeargument name="TypeID" value="#getTypeID.CompareType#">
	</cfinvoke>
</cfif>
--->

<!--- ATTEMPT TO GET THE ProductSpecs FOR THIS PRODUCT --->
<cfif getTypeID.RecordCount NEQ 0>
	<cfquery name="getProductSpecs" datasource="#application.dsn#">
		SELECT	*
		FROM	ProductTypes pt 
		<cfif getTypeID.foundItemID NEQ ''>
				, ProductSpecs ps
		WHERE	ps.ProductType = pt.TypeID
		AND		pt.TypeID = #getTypeID.CompareType#
		AND		ps.ItemID = #ItemID#
		<cfelse>	
		WHERE	pt.TypeID = #getTypeID.CompareType#
		</cfif>
	</cfquery>
<cfelse><!--- ERROR --->
	<div align="center" class="cfAdminError">
		A Compare Type has NOT been set for this product.<br>
		Please <a href="ProductTypeDetail.cfm?TypeID=#getProductSpecs.TypeID#">go back to Product Detail</a>
		to setup a Compare Type before editing Product Specifications.
	</div><br><br>
	<cfinclude template="LayoutAdminFooter.cfm">
	<cfabort>
</cfif>

<cfoutput>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr style="background-color:##65ADF1;">
		<td width="100" height="20" class="cfAdminHeader1">&nbsp; TITLE</td>
		<td width="200" height="20" class="cfAdminHeader1">VALUE</td>
		<td width="350" height="20" class="cfAdminHeader1"></td>
	</tr>
	<tr>
		<td colspan="3" height="5"></td>
	</tr>
	<tr>
		<td height="20" colspan="2">
			<a href="ProductTypeDetail.cfm?TypeID=#getProductSpecs.TypeID#"><b>#getProductSpecs.TypeName#</b></a>&nbsp;
			<a href="ProductTypeDetail.cfm?TypeID=#getProductSpecs.TypeID#">[edit]</a>
		</td>
		<td align="right"><a href="ProductDetail.cfm?ItemID=#ItemID#"><b>Return to Product Detail</b></a>&nbsp;&nbsp;&nbsp;</td>
	</tr>
	<tr>
		<td colspan="3" height="1" style="background-color:##CCCCCC;"></td>
	</tr>
	<tr>
		<td colspan="3" height="5"></td>
	</tr>
</cfoutput>

<cfoutput query="getProductSpecs">
<cfform action="ProductSpecs.cfm" method="post">
	<cfloop from="1" to="#getProductSpecs.SpecCount#" index="i">
		<cfscript>
			ThisSpecTitle  = #Evaluate("SpecTitle" & i)#;
			if ( isDefined("Spec" & i) ) 
				ThisSpec  = #Evaluate("Spec" & i)#;
		</cfscript>
		<tr>
			<td>#ThisSpecTitle#</td>
			<td>
				<cfif isDefined("Spec" & i)><cfinput type="text" name="Spec#i#" value="#ThisSpec#" size="70" class="cfAdminDefault">
				<cfelse><cfinput type="text" name="Spec#i#" size="70" class="cfAdminDefault">
				</cfif>
			</td>
			<td></td>
		</tr>
	</cfloop>
	<input type="hidden" name="ItemID" value="#ItemID#">
	<cfif getTypeID.foundItemID NEQ ''>
	<input type="hidden" name="SpecID" value="#SpecID#">
	<input type="hidden" name="ProductType" value="#ProductType#">
	<cfelse>
	<input type="hidden" name="ProductType" value="#TypeID#">
	</cfif>
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
			<input type="submit" name="UpdateProductSpecs" value="UPDATE CHANGES" alt="Update Product Specifications" class="cfAdminButton">
		</td>
	</tr>
	<tr>
		<td height="20" colspan="3"></td>
	</tr>
</cfform>
</cfoutput>
</table>


<cfinclude template="LayoutAdminFooter.cfm">