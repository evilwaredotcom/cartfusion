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

<cfif isDefined('form.UpdateOptionInfo') AND IsDefined("form.ItemAltID") AND IsDefined("form.ItemID")>
	<cfif isUserInRole('Administrator')>
		<cfset form.DateUpdated = #Now()#>
		<cfset form.UpdatedBy = #GetAuthUser()#>
		<cfupdate datasource="#application.dsn#" tablename="ProductOptions" 
			formfields="ItemAltID, OptionName, OptionColumn, OptionPrice, OptionSellByStock, StockQuantity, ItemStatus">			
		<cfset AdminMsg = 'Option Updated Successfully' >
	<cfelse>
		<script language="JavaScript">
			{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
		</script>
	</cfif>
</cfif>

<cfif isDefined('form.AddOptionInfo') AND IsDefined("form.ItemID") AND form.OptionName NEQ ''>
	<cfif isUserInRole('Administrator')>
		<cfquery name="preventDuplicate" datasource="#application.dsn#">
			SELECT  *
			FROM	ProductOptions
			WHERE	ItemID = #Form.ItemID#
			AND		OptionName = '#Form.OptionName#'
			AND		OptionColumn = '#Form.OptionColumn#'
		</cfquery>
		<cfif preventDuplicate.RecordCount EQ 0>
			<cfinsert datasource="#application.dsn#" tablename="ProductOptions" 
				formfields="ItemID, OptionName, OptionColumn, OptionPrice, OptionSellByStock, StockQuantity, ItemStatus">			
			<cfset AdminMsg = 'Option Added Successfully' >
		<cfelse>
			<cfset AdminMsg = 'ERROR OCCURED.  Duplicate Option Exists' >
		</cfif>
	<cfelse>
		<script language="JavaScript">
			{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
		</script>
	</cfif>
</cfif>

<cfif isDefined('form.DeleteOptionInfo') AND IsDefined("form.ItemAltID") AND IsDefined("form.ItemID")>
	<cfif isUserInRole('Administrator')>
		<cfquery name="deleteAltStyle" datasource="#application.dsn#">
			DELETE
			FROM 	ProductOptions
			WHERE	ItemAltID = #form.ItemAltID#
			AND		ItemID = #Form.ItemID#
			AND		OptionName = '#Form.OptionName#'
			AND		OptionColumn = '#Form.OptionColumn#'
		</cfquery>			
		<cfset AdminMsg = 'Option Deleted Successfully' >
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
</cfinvoke><cfinvoke component="#application.Queries#" method="getOptionCategories" returnvariable="getOptionCategories">
	<cfinvokeargument name="ItemID" value="#ItemID#">
</cfinvoke>
<cfinvoke component="#application.Queries#" method="getOptions" returnvariable="getOptions">
	<cfinvokeargument name="ItemID" value="#ItemID#">
</cfinvoke>
<cfinvoke component="#application.Queries#" method="getItemStatusCodes" returnvariable="getItemStatusCodes"></cfinvoke>

<!--- END: QUERIES ------------------------------------->

<!--- BEGIN: HEADER --->
<cfscript>
	PageTitle = 'PRODUCT OPTIONS';
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


<!--- PRODUCT OPTIONS --->
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td height="20" width="100%" class="cfAdminTitle">OPTION CATEGORIES</td>
	</tr>
	<tr style="background-color:##CCCCCC;"><td height="1"></td></tr>
	<tr><td height="2"></td></tr>
	<tr>
		<td  valign="top">
			<table border="0" cellpadding="0" cellspacing="0" width="100%">
				<tr style="background-color:##7DBF0E;">
					<td width="15%" class="cfAdminHeader2">&nbsp;Option Category</td>
					<td width="15%" class="cfAdminHeader2">Option Name</td>
					<td width="15%" class="cfAdminHeader2">Optional</td>
					<td width="55%" class="cfAdminHeader2" height="20" align="right">* NOTE: Option Categories must be setup before assigning options &nbsp;</td>
				</tr>	
				<tr>
					<td height="5" colspan="4"></td>
				</tr>
				<cfoutput query="getProduct" group="ItemID">			
				<cfform action="ProductOptions.cfm" method="post">
				<tr>
					<td>&nbsp;Option Category 1:</td>
					<td><cfinput type="text" name="OptionName1" value="#getProduct.OptionName1#" size="20" 
							class="cfAdminDefault" onchange="updateInfo(#ItemID#,this.value,'OptionName1','Products');"></td>
					<td><input type="checkbox" name="Option1Optional" onclick="updateInfo(#ItemID#,this.value,'Option1Optional','Products');" <cfif Option1Optional EQ 1>checked</cfif> ></td>
					<td></td>
				</tr>
				<tr>
					<td>&nbsp;Option Category 2:</td>
					<td><cfinput type="text" name="OptionName2" value="#getProduct.OptionName2#" size="20" 
							class="cfAdminDefault" onchange="updateInfo(#ItemID#,this.value,'OptionName2','Products');"></td>
					<td><input type="checkbox" name="Option2Optional" onclick="updateInfo(#ItemID#,this.value,'Option2Optional','Products');" <cfif Option2Optional EQ 1>checked</cfif> ></td>
					<td></td>
				</tr>
				<tr>
					<td>&nbsp;Option Category 3:</td>
					<td><cfinput type="text" name="OptionName3" value="#getProduct.OptionName3#" size="20" 
							class="cfAdminDefault" onchange="updateInfo(#ItemID#,this.value,'OptionName3','Products');"></td>
					<td><input type="checkbox" name="Option3Optional" onclick="updateInfo(#ItemID#,this.value,'Option3Optional','Products');" <cfif Option3Optional EQ 1>checked</cfif> ></td>
					<td></td>
				</tr>
				</cfform>
				</cfoutput>
			</table>
		</td>
	</tr>
</table>
<br>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td height="20" width="100%" class="cfAdminTitle">OPTIONS</td>
	</tr>
	<tr style="background-color:##CCCCCC;"><td height="1"></td></tr>
	<tr><td height="2"></td></tr>
	<tr>
		<td valign="top">
			<table border="0" cellpadding="0" cellspacing="0" width="100%">	
				<tr style="background-color:##65ADF1;">
					<td width="1%"  class="cfAdminHeader1" height="20" align="center"></td><!--- ADD/DELETE --->
					<td width="10%" class="cfAdminHeader1" nowrap>Option Category</td>
					<td width="15%" class="cfAdminHeader1">Option Description</td>
					<td width="10%" class="cfAdminHeader1">Price +/-</td>
					<td width="10%" class="cfAdminHeader1">Stock Qty</td>
					<td width="10%" class="cfAdminHeader1">Item Status</td>
					<td width="10%" class="cfAdminHeader1" align="center">Use Stock Qty</td>
					<td width="30%" class="cfAdminHeader1"></td><!--- UPDATE --->
				</tr>
				<tr>
					<td height="5" colspan="8"></td>
				</tr>
				<cfoutput query="getOptions">			
				<cfform action="ProductOptions.cfm" method="post">
				<tr>
					<td align="center">
						<input type="submit" name="DeleteOptionInfo" value="X" alt="Delete Option" class="cfAdminButton"
							onclick="return confirm('Are you sure you want to DELETE THIS OPTION?')">&nbsp;
					</td>
					<td>
						<select name="OptionColumn" size="1" class="cfAdminDefault">
							<cfloop from="1" to="3" index="i">
								<cfif OptionColumn EQ i >
									<option value="#i#" selected>#i#</option>
								<cfelse>
									<option value="#i#">#i#</option>
								</cfif>
							</cfloop>
						</select>
					</td>
					<td><input type="text" name="OptionName" value="#OptionName#" size="20" class="cfAdminDefault"></td>
					<td nowrap>$<cfinput type="text" name="OptionPrice" value="#DecimalFormat(OptionPrice)#" size="5" class="cfAdminDefault" validate="float" required="yes" message="Please enter a price for this option. (Enter 0 for no additional price.)"></td>
					<td><cfinput type="text" name="StockQuantity" value="#StockQuantity#" size="4" class="cfAdminDefault" validate="integer" required="yes" message="Please enter an inventory stock quantity for this option."></td>
					<td><cfselect name="ItemStatus" query="getItemStatusCodes" size="1" 
							value="StatusCode" display="StatusMessage" selected="#ItemStatus#" class="cfAdminDefault" />
					</td>
					<td align="center"><input type="checkbox" name="OptionSellByStock" <cfif OptionSellByStock EQ 1>checked</cfif> ></td>
					<td>
						<input type="submit" name="UpdateOptionInfo" value="UPDATE" alt="Update Option" class="cfAdminButton">
					</td>
				</tr>
				<tr>
					<td height="2" colspan="8"></td>
				</tr>
				<tr style="background-color:##CCCCCC;">
					<td height="1" colspan="8"></td>
				</tr>
				<tr>
					<td height="2" colspan="8"></td>
				</tr>
				<input type="hidden" name="ItemAltID" value="#ItemAltID#">
				<input type="hidden" name="ItemID" value="#ItemID#">	
				</cfform>
				</cfoutput>

				<!--- ADD NEW OPTION --->
				<cfform action="ProductOptions.cfm" method="post">
				<tr>
					<td align="center">
						<input type="submit" name="AddOptionInfo" value="ADD" alt="Add Option" class="cfAdminButton">&nbsp;
					</td>
					<td>
						<select name="OptionColumn" size="1" class="cfAdminDefault">
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
						</select>
					</td>
					<td><input type="text" name="OptionName" size="20" class="cfAdminDefault"></td>
					<td nowrap>$ <cfinput type="text" name="OptionPrice" value="0.00" size="5" class="cfAdminDefault" validate="float" required="yes" message="Please enter a price for this option. (Enter 0 for no additional price.)"></td>
					<td><cfinput type="text" name="StockQuantity" size="4" class="cfAdminDefault" validate="integer" required="yes" message="Please enter an inventory stock quantity for this option."></td>
					<td><cfselect name="ItemStatus" query="getItemStatusCodes" size="1" 
							value="StatusCode" display="StatusMessage" selected="IS" class="cfAdminDefault" />
					</td>
					<td align="center"><input type="checkbox" name="OptionSellByStock"></td>
					<td></td><!--- SPACE --->
				</tr>
					<input type="hidden" name="ItemID" value="<cfoutput>#getProduct.ItemID#</cfoutput>">	
				</cfform>
			</table>
		</td>
	</tr>
</table>

<br><br>
<cfinclude template="LayoutAdminFooter.cfm">