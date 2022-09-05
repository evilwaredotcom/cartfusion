<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<cfif isDefined('URL.ErrorMsg')>
	<cfif URL.ErrorMsg EQ 1 >
		<script language="JavaScript">
			{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
		</script>
	<cfelseif URL.ErrorMsg EQ 2 >
		<script language="JavaScript">
			{ alert ("An error has occurred trying to upload the image. Please try again or contact CartFusion technical support."); }
		</script>
	</cfif>
</cfif>

<!--- BEGIN: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<cfif isDefined('form.UpdateClassInfo') AND IsDefined("form.ItemID") AND IsDefined("form.ItemClassID")>
	<cfif isUserInRole('Administrator')>
		<cfupdate datasource="#application.dsn#" tablename="Products" 
			formfields="ItemID, ItemClassID">			
		<cfset AdminMsg = 'Item Class Updated Successfully' >
	<cfelse>
		<script language="JavaScript">
			{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
		</script>
	</cfif>
</cfif>

<cfif isDefined('form.UpdateComponentInfo') AND IsDefined("form.ICCID") AND IsDefined("form.ItemClassID")>
	<cfif isUserInRole('Administrator')>
		<cfscript>
			if ( NOT isDefined('FORM.CompSellByStock') )
				FORM.CompSellByStock = 0 ;
		</cfscript>
		<cfupdate datasource="#application.dsn#" tablename="ItemClassComponents" 
			formfields="ICCID, ItemClassID, ItemID, Detail1, Detail2, Detail3, CompPrice, CompQuantity, CompStatus, CompSellByStock, Image">			
		<cfset AdminMsg = 'Component Updated Successfully' >
	<cfelse>
		<script language="JavaScript">
			{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
		</script>
	</cfif>
</cfif>

<cfif isDefined('form.AddComponentInfo') AND IsDefined("form.ItemClassID") AND form.ItemClassID NEQ ''>
	<cfif isUserInRole('Administrator')>
		<cfscript>
			if ( NOT isDefined('FORM.CompSellByStock') )
				FORM.CompSellByStock = 0 ;
			if ( NOT isDefined('FORM.Detail1') )
				FORM.Detail1 = '' ;
			if ( NOT isDefined('FORM.Detail2') )
				FORM.Detail2 = '' ;
			if ( NOT isDefined('FORM.Detail3') )
				FORM.Detail3 = '' ;
		</cfscript>
				
		<cfquery name="preventDuplicate" datasource="#application.dsn#">
			SELECT  *
			FROM	ItemClassComponents
			WHERE	ItemClassID = #Form.ItemClassID#
			AND		Detail1 = '#Form.Detail1#'
			AND		Detail2 = '#Form.Detail2#'
			AND		Detail3 = '#Form.Detail3#'
		</cfquery>
		
		<cfif preventDuplicate.RecordCount EQ 0>
			<cfinsert datasource="#application.dsn#" tablename="ItemClassComponents" 
				formfields="ItemClassID, ItemID, Detail1, Detail2, Detail3, CompPrice, CompQuantity, CompStatus, CompSellByStock, Image, QB">
			<cfset AdminMsg = 'Component Added Successfully' >
		<cfelse>
			<cfset AdminMsg = 'ERROR: Duplicate Component Exists' >
		</cfif>
	<cfelse>
		<script language="JavaScript">
			{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
		</script>
	</cfif>
</cfif>

<cfif isDefined('form.DeleteComponentInfo') AND IsDefined("form.ICCID") AND IsDefined("form.ItemClassID")>
	<cfif isUserInRole('Administrator')>
		<cfquery name="deleteComponent" datasource="#application.dsn#">
			DELETE
			FROM 	ItemClassComponents
			WHERE	ICCID = #form.ICCID#
			AND		ItemClassID = #Form.ItemClassID#
		</cfquery>			
		<cfset AdminMsg = 'Component Deleted Successfully' >
	<cfelse>
		<script language="JavaScript">
			{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
		</script>
	</cfif>
</cfif>


<!--- END: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<!--- BEGIN: QUERIES ------------------------------------->
<cfinvoke component="#application.Queries#" method="getProduct" returnvariable="getProduct">
	<cfinvokeargument name="ItemID" value="#ItemID#">
</cfinvoke><cfinvoke component="#application.Queries#" method="getItemClassComponents" returnvariable="getItemClassComponents">
	<cfinvokeargument name="ItemID" value="#ItemID#">
</cfinvoke>
<cfinvoke component="#application.Queries#" method="getItemStatusCodes" returnvariable="getItemStatusCodes"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getItemClasses" returnvariable="getItemClasses"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getItemClass" returnvariable="getItemClass">
	<cfinvokeargument name="ICID" value="#VAL(getProduct.ItemClassID)#">
</cfinvoke>
<!--- END: QUERIES ------------------------------------->

<!--- BEGIN: HEADER --->
<cfscript>
	PageTitle = 'INVENTORY MATRIX';
	QuickSearch = 1;
	QuickSearchPage = 'Products.cfm';
	AddPage = 'ProductAdd.cfm';
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">
<!--- END: HEADER --->

<cfoutput query="getProduct" group="ItemID">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td width="15%">
			<cfif ImageSmall NEQ ''>
				<img src="#application.ImagePath#/#ImageDir#/#ImageSmall#" border="0" vspace="5" hspace="10">
			</cfif>
		</td>
		<td width="*" valign="top"><br>
			<table border="0" cellpadding="0" cellspacing="0" width="100%">
				<tr><td width="5%" nowrap><font color="4DA0CA">Item Name:&nbsp;&nbsp;</font></td><td width="*"><font color="4DA0CA">#ItemName#</font></td></tr>
				<tr><td width="5%" nowrap><font color="014589">SKU:&nbsp;&nbsp;</font></td><td width="*"><font color="014589">#Ucase(SKU)#</font></td></tr>
				<tr><td width="5%" nowrap><font color="##CCCCCC">ItemID:&nbsp;&nbsp;</font></td><td width="*" class="cfAdminHome1"><font color="##CCCCCC">#ItemID#</font></td></tr>
				<tr><td width="100%" nowrap colspan="2">
					<br>
					<input type="button" name="ReturnToProduct" value="RETURN TO PRODUCT" alt="Return to Product Detail Page" class="cfAdminButton"
						onclick="document.location.href='ProductDetail.cfm?ItemID=<cfoutput>#ItemID#</cfoutput>'">
				</td></tr>
			</table>
		</td>
	</tr>
</table>
</cfoutput>

<!--- INVENTORY MATRIX - ITEM CLASS & ITEM CLASS COMPONENTS --->
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td height="20" width="100%" class="cfAdminTitle">ITEM CLASS MATRIX</td>
	</tr>
	<tr style="background-color:##CCCCCC;"><td height="1"></td></tr>
	<tr><td height="2"></td></tr>
	<tr>
		<td  valign="top">
			<table border="0" cellpadding="0" cellspacing="0" width="100%">
				<tr style="background-color:##7DBF0E;">
					<td width="20%" class="cfAdminHeader1" height="20">&nbsp;Item Class</td>
					<td width="20%" class="cfAdminHeader1">Description</td>
					<td width="10%" class="cfAdminHeader1">Dimensions</td>
					<td width="*"   class="cfAdminHeader1"><!--- UPDATE ---></td>
				</tr>	
				<tr>
					<td height="5" colspan="4"></td>
				</tr>
				<cfoutput>
				<cfform action="ProductMatrix.cfm" method="post">
				<tr>
					<td>
						<cfselect name="ItemClassID" query="getItemClasses" size="1" 
							value="ICID" display="ICDescription" selected="#getProduct.ItemClassID#" class="cfAdminDefault">
							<option value="" <cfif getProduct.ItemClassID EQ '' OR getProduct.ItemClassID EQ 0 >selected</cfif>>-- SELECT ITEM CLASS --</option>
						</cfselect>
					</td>
					<td>
						<cfif getItemClass.RecordCount NEQ 0 >
							#getItemClass.Description#
						</cfif>
					</td>
					<td>
						<cfif getItemClass.RecordCount NEQ 0 >
							#getItemClass.Dimensions#
						</cfif>
					</td>
					<td>
						<input type="submit" name="UpdateClassInfo" value="UPDATE" alt="Update Class Changes" class="cfAdminButton">
					</td>
				</tr>
				<input type="hidden" name="ItemID" value="#getProduct.ItemID#">
				</cfform>
				</cfoutput>
			</table>
		</td>
	</tr>
</table>

<br>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td height="20" width="100%" class="cfAdminTitle">ITEM CLASS COMPONENTS</td>
	</tr>
	<tr style="background-color:##CCCCCC;"><td height="1"></td></tr>
	<tr><td height="2"></td></tr>
	<cfif getItemClass.ICID LTE 0 >
	<tr>
		<td valign="top">
			To set item class components, please SELECT an item class for this product above and click UPDATE.
		</td>
	</tr>
	<cfelse>
	<tr>
		<td valign="top">
			<table border="0" cellpadding="0" cellspacing="0" width="100%">	
				<tr style="background-color:##65ADF1;">
					<td width="1%"  class="cfAdminHeader1" height="20" align="center"></td><!--- ADD/DELETE --->
					<td width="4%" class="cfAdminHeader1" nowrap>QB #</td>
					<cfoutput>
					<cfif getItemClass.Dimensions GT 0 >
					<td width="15%" class="cfAdminHeader1" nowrap>#getItemClass.Title1#</td>
					</cfif>
					<cfif getItemClass.Dimensions GT 1 >
					<td width="15%" class="cfAdminHeader1" nowrap>#getItemClass.Title2#</td>
					</cfif>
					<cfif getItemClass.Dimensions GT 2 >
					<td width="15%" class="cfAdminHeader1" nowrap>#getItemClass.Title3#</td>
					</cfif>
					</cfoutput>
					<td width="7%" class="cfAdminHeader1" nowrap>Price +/-</td>
					<td width="7%" class="cfAdminHeader1" nowrap>Stock Qty</td>
					<td width="10%" class="cfAdminHeader1" nowrap>Item Status</td>
					<td width="10%" class="cfAdminHeader1" nowrap align="center">Use Stock Qty</td>
					<td width="10%" class="cfAdminHeader1" nowrap align="center">Image</td>
					<td width="*" class="cfAdminHeader1"></td><!--- UPDATE --->
				</tr>
				<tr>
					<td height="5" colspan="11"></td>
				</tr>
				<cfoutput query="getItemClassComponents">			
				<cfform action="ProductMatrix.cfm" method="post">
				<tr>
					<td align="center">
						<input type="submit" name="DeleteComponentInfo" value="X" alt="Delete Component" class="cfAdminButton"
							onclick="return confirm('Are you sure you want to DELETE THIS COMPONENT?')">&nbsp;
					</td>
					<td>#QB#</td>
					<cfif getItemClass.Dimensions GT 0 >
					<td><input type="text" name="Detail1" value="#Detail1#" size="20" class="cfAdminDefault"></td>
					</cfif>
					<cfif getItemClass.Dimensions GT 1 >
					<td><input type="text" name="Detail2" value="#Detail2#" size="20" class="cfAdminDefault"></td>
					</cfif>
					<cfif getItemClass.Dimensions GT 2 >
					<td><input type="text" name="Detail3" value="#Detail3#" size="20" class="cfAdminDefault"></td>
					</cfif>
					<td nowrap>$ <cfinput type="text" name="CompPrice" value="#DecimalFormat(CompPrice)#" size="5" class="cfAdminDefault" validate="float" required="yes" message="Please enter a price for this component. (Enter 0 for no additional price.)"></td>
					<td><cfinput type="text" name="CompQuantity" value="#CompQuantity#" size="4" class="cfAdminDefault" validate="integer" required="yes" message="Please enter an inventory stock quantity for this component."></td>
					<td><cfselect name="CompStatus" query="getItemStatusCodes" size="1" 
							value="StatusCode" display="StatusMessage" selected="#CompStatus#" class="cfAdminDefault" />
					</td>
					<td align="center"><input type="checkbox" name="CompSellByStock" <cfif CompSellByStock EQ 1>checked</cfif> ></td>
					<td><input type="text" name="Image" value="#Image#" size="20" class="cfAdminDefault"></td>
					<td>
						<input type="button" name="NewMainImage" value="UPLOAD" alt="Upload New Main Image" class="cfAdminButton"
							onclick="document.location.href='ImageUpload.cfm?ItemID=#getProduct.ItemID#&Image=Matrix&ImageDir=#getproduct.ImageDir#&ImageID=#ICCID#&SiteID=#application.SiteID#&Table=ItemClassComponents&ColumnID=ICCID'">
						&nbsp;&nbsp;
						<input type="submit" name="UpdateComponentInfo" value="UPDATE" alt="Update Component" class="cfAdminButton">
					</td>
				</tr>
				<tr>
					<td height="2" colspan="11"></td>
				</tr>
				<tr style="background-color:##CCCCCC;">
					<td height="1" colspan="11"></td>
				</tr>
				<tr>
					<td height="2" colspan="11"></td>
				</tr>
				<input type="hidden" name="ICCID" value="#ICCID#">
				<input type="hidden" name="ItemClassID" value="#ItemClassID#">
				<input type="hidden" name="ItemID" value="#ItemID#">
				</cfform>
				</cfoutput>

				<!--- ADD NEW OPTION --->
				<cfform action="ProductMatrix.cfm" method="post">
				<tr>
					<td align="center">
						<input type="submit" name="AddComponentInfo" value="ADD" alt="Add Component" class="cfAdminButton">&nbsp;
					</td>
					<td><input type="text" name="QB" size="5" class="cfAdminDefault"></td>
					<cfif getItemClass.Dimensions GT 0 >
					<td><input type="text" name="Detail1" size="20" class="cfAdminDefault"></td>
					</cfif>
					<cfif getItemClass.Dimensions GT 1 >
					<td><input type="text" name="Detail2" size="20" class="cfAdminDefault"></td>
					</cfif>
					<cfif getItemClass.Dimensions GT 2 >
					<td><input type="text" name="Detail3" size="20" class="cfAdminDefault"></td>
					</cfif>
					<td nowrap>$ <cfinput type="text" name="CompPrice" value="0.00" size="5" class="cfAdminDefault" validate="float" required="yes" message="Please enter a price for this component. (Enter 0 for no additional price.)"></td>
					<td><cfinput type="text" name="CompQuantity" size="4" class="cfAdminDefault" validate="integer" required="yes" message="Please enter an inventory stock quantity for this component."></td>
					<td><cfselect name="CompStatus" query="getItemStatusCodes" size="1" 
							value="StatusCode" display="StatusMessage" selected="IS" class="cfAdminDefault" />
					</td>
					<td align="center"><input type="checkbox" name="CompSellByStock" checked ></td>
					<td><input type="text" name="Image" size="20" class="cfAdminDefault"></td>
					<td></td>
				</tr>
					<cfoutput>
					<input type="hidden" name="ItemClassID" value="#getProduct.ItemClassID#">
					<input type="hidden" name="ItemID" value="#getProduct.ItemID#">
					</cfoutput>	
				</cfform>
			</table>
		</td>
	</tr>
	</cfif>
</table><br>


<br><br>
<cfinclude template="LayoutAdminFooter.cfm">