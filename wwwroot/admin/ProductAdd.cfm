<cfif isDefined('URL.ErrorMsg') AND URL.ErrorMsg EQ 1>
	<script language="JavaScript">
		{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
	</script>
</cfif>

<!--- QUERIES ------------------------------------->
<!--- ABOVE DATABASE UPDATES --->
<cfinvoke component="#application.Queries#" method="getSites" returnvariable="getSites"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getItemStatusCodes" returnvariable="getItemStatusCodes"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getUsers" returnvariable="getUsers"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getDistributors" returnvariable="getDistributors"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getProductTypes" returnvariable="getProductTypes"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getItemClasses" returnvariable="getItemClasses"></cfinvoke>
<!--- CARTFUSION 4.6 - Other Categories/Sections Multiple-Select List --->
<cfinvoke component="#application.Queries#" method="getCategories" returnvariable="getCategories"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getSections" returnvariable="getSections"></cfinvoke>
<!--- !QUERIES ------------------------------------->

<!--- DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<cfif StructKeyExists(Form,'AddProduct') AND StructKeyExists(Form,'ItemName') AND Form.ItemName NEQ '' AND StructKeyExists(Form,'SKU') AND Form.SKU NEQ '' >
	<cfif isUserInRole('Administrator')>
		<cftry>
			<cfscript>
				// Add X, prefix and ,X suffix to OtherCategories, and remove all whitespace
				if ( StructKeyExists(Form,'OtherCategories') )
					Form.OtherCategories = 'X,' & Form.OtherCategories & ',X' ;
				else
					Form.OtherCategories = 'X,,X' ;
				// Add X, prefix and ,X suffix to OtherSections, and remove all whitespace
				if ( StructKeyExists(Form,'OtherSections') )
					Form.OtherSections = 'X,' & Form.OtherSections & ',X' ;
				else
					Form.OtherSections = 'X,,X' ;
				if ( NOT StructKeyExists(Form,'UseMatrix') )
					Form.UseMatrix = 0 ;
				Form.CostPrice = Replace(Form.CostPrice, "," , "", "ALL") ;
				if ( Form.CostPrice EQ '' )
					Form.CostPrice = 0 ;
				Form.ListPrice = Replace(Form.ListPrice, "," , "", "ALL") ;
				Form.StockQuantity = Replace(Form.StockQuantity, "," , "", "ALL") ;
				Form.DateUpdated = Now() ;
				Form.UpdatedBy = GetAuthUser() ;
				// RETAIL PRO
				if ( StructKeyExists(Form,'fldShipWeight') AND Form.fldShipWeight NEQ '' )
				{
					Form.fldShipWeight = Replace(Form.fldShipWeight, "," , "", "ALL") ;
					Form.Weight = Form.fldShipWeight ;
				}
				else
				{
					Form.fldShipWeight = 0 ;
					Form.Weight = 0 ;
				}
				if ( StructKeyExists(Form,'fldShipAmount') AND Form.fldShipAmount NEQ '' )
					Form.fldShipAmount = Replace(Form.fldShipAmount, "," , "", "ALL") ;
				else
					Form.fldShipAmount = 0 ;
				if ( StructKeyExists(Form,'fldHandAmount') AND Form.fldHandAmount NEQ '' )
					Form.fldHandAmount = Replace(Form.fldHandAmount, "," , "", "ALL") ;
				else
					Form.fldHandAmount = 0 ;
				if ( StructKeyExists(Form,'fldShipByWeight') )
					Form.fldShipByWeight = 1;
				else
					Form.fldShipByWeight = 0;
				if ( StructKeyExists(Form,'fldOversize') )
					Form.fldOversize = 1;
				else
					Form.fldOversize = 0;
			</cfscript>

			<cfinsert datasource="#application.dsn#" tablename="Products" 
				formfields="SiteID, SKU, ManufacturerID, ItemName, ItemDescription, ItemDetails, Attribute1, Attribute2,
							Category, OtherCategories, SectionID, OtherSections, CompareType, CostPrice, ListPrice, Weight,
							DimLength, DimWidth, DimHeighth,
							fldShipWeight, fldShipAmount, fldHandAmount, fldShipByWeight, fldOversize, fldShipCode,
							Image, ImageLarge, ImageSmall, ImageAlt, ImageAltLarge, ImageDir, Featured, Taxable, UseMatrix, ItemClassID,
							StockQuantity, ItemStatus, SellByStock, Comments, DistributorID, DisplayOrder, DateUpdated, UpdatedBy">
			
			<!--- GET NEWLY ASSIGNED SKU NUMBER --->
			<cfquery name="getAddedItemID" datasource="#application.dsn#">
				SELECT	MAX(ItemID) AS ItemID
				FROM	Products
				WHERE	SKU = '#Form.SKU#'
				AND		ItemName = '#Form.ItemName#'		
			</cfquery>

			<cfif getAddedItemID.RecordCount NEQ 0>
				<!--- UPDATE PRICES NOW --->
				<!--- SET HIDES TO 0 OR 1 --->
				<cfloop from="1" to="#getUsers.RecordCount#" index="i">
					<cfif StructKeyExists(Form,'Hide#i#')><cfset 'Form.Hide#i#' = 1>
					<cfelse><cfset 'Form.Hide#i#' = 0>
					</cfif>
				</cfloop>
				<cfquery name="setProductPrices" datasource="#application.dsn#">
					UPDATE 	Products
					SET
					<cfloop from="1" to="#getUsers.RecordCount#" index="i">
						Price#i# = #Evaluate('Form.Price' & i)#, 
						Hide#i#  = #Evaluate('Form.Hide' & i)#,
					</cfloop>
						UpdatedBy = '#Form.UpdatedBy#'
					WHERE	ItemID = #getAddedItemID.ItemID#
				</cfquery>
			
				<cfset ItemID = getAddedItemID.ItemID>
				<cfset AdminMsg = 'Item "#Form.ItemName#" Added Sucessfully' >
				<cflocation url="ProductDetail.cfm?ItemID=#ItemID#&AdminMsg=#URLEncodedFormat(AdminMsg)#" addtoken="no">
				<cfabort>
			</cfif>

			<cfcatch>
				<cfset AdminMsg = 'FAIL: Item NOT Added - #cfcatch#' >
			</cfcatch>
		</cftry>
	<cfelse>
		<script language="JavaScript">
			{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
		</script>
	</cfif>
</cfif>

<!--- END: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->


<!--- HEADER --->
<cfscript>
	PageTitle = 'ADD PRODUCT';
	QuickSearch = 1;
	QuickSearchPage = 'Products.cfm';
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">
<!--- !HEADER --->

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<cfoutput>			
<cfform action="ProductAdd.cfm" method="post">
	<tr style="background-color:##65ADF1;">
		<td width="49%" colspan="2" height="20" class="cfAdminHeader1">&nbsp; PRODUCT INFORMATION</td>
		<td width="1%"  rowspan="40" style="background-color:##FFFFFF;"></td>
		<td width="50%" colspan="2" class="cfAdminHeader1">&nbsp; SHIPPING INFORMATION</td>
	</tr>
	<tr>
		<td colspan="6" height="5"></td>
	</tr>
	<tr>
		<td width="10%"><b>Site ID:</b></td>
		<td width="39%">
			<cfselect name="SiteID" query="getSites" size="1" tabindex="1"
				value="SiteID" display="SiteName" selected="#application.SiteID#" class="cfAdminDefault" />
		</td>
		<td><b>Weight:</b></td>
		<td><cfinput type="text" name="fldShipWeight" value="0.000" size="15" class="cfAdminDefault" tabindex="17" required="yes" message="Required: Weight (in pounds)"> lbs.</td>
	</tr>
	<tr>
		<td><b>SKU:</b></td>
		<td><cfinput type="text" name="SKU" value="" size="20" maxlength="20" class="cfAdminDefault" tabindex="2" required="yes" message="Required: SKU">
			&nbsp;&nbsp; <font color="##CCCCCC">ItemID: TBD</font>
		</td>
		<td>Ship By Weight?</td>
		<td><cfinput type="checkbox" name="fldShipByWeight" checked="yes" tabindex="17"></td>
	</tr>
	<tr>
		<td>Manufacturer No:</td>
		<td><cfinput type="text" name="ManufacturerID" value="" size="20" maxlength="20" class="cfAdminDefault" tabindex="2" required="no" message="Required: Manufacturer Number"></td>
		<td>Shipping Amount:</td>
		<td><cfinput type="text" name="fldShipAmount" value="0.00" size="15" class="cfAdminDefault" tabindex="17" required="no" message="Required: Shipping Amount" validate="float"></td>
	</tr>
	<tr>
		<td><b>Item Name:</b></td>
		<td><cfinput type="text" name="ItemName" value="" size="40" class="cfAdminDefault" tabindex="3" required="yes" message="Required: Item Name"></td>
		<td>Handling Amount:</td>
		<td><cfinput type="text" name="fldHandAmount" value="0.00" size="15" class="cfAdminDefault" tabindex="17" required="no" message="Required: Handling Amount" validate="float"></td>
	</tr>
	<tr>
		<td>Attribute 1:</td>
		<td><cfinput type="text" name="Attribute1" value="" size="40" class="cfAdminDefault" tabindex="4"></td>
		<td>Shipping Code</td>
		<td><cfinput type="text" name="fldShipCode" value="" size="15" class="cfAdminDefault" tabindex="18" required="no" message="Required: Shipping Code" validate="integer"> <a href="Config-ShipCodes.cfm">View Codes</a></td>
	</tr>
	<tr>
		<td>Attribute 2:</td>
		<td><cfinput type="text" name="Attribute2" value="" size="40" class="cfAdminDefault" tabindex="5"></td>
		<td>Oversize?</td>
		<td><cfinput type="checkbox" name="fldOversize" tabindex="18"></td>
	</tr>
	<tr>
		<td>Compare Type:</td>
		<td>
			<cfselect name="CompareType" query="getProductTypes" size="1"
				value="TypeID" display="TypeName" selected="" class="cfAdminDefault" tabindex="10">
				<option value="0" selected >-- SELECT TYPE --</option>
			</cfselect>
		</td>
		<td>Shipping Dimensions:</td>
		<td><cfinput type="text" name="DimLength" value="1.00" size="3" class="cfAdminDefault" tabindex="18" required="yes" message="Required: Shipping Dimension - Length" validate="float"> in. L &times;
			<cfinput type="text" name="DimWidth" value="1.00" size="3" class="cfAdminDefault" tabindex="18" required="yes" message="Required: Shipping Dimension - Width" validate="float"> in. W &times;
			<cfinput type="text" name="DimHeighth" value="1.00" size="3" class="cfAdminDefault" tabindex="18" required="yes" message="Required: Shipping Dimension - Height" validate="float"> in. H
		</td>
	</tr>
	<tr>
		<td><b>Main Category:</b></td>
		<td>
			<cfselect name="Category" size="1" class="cfAdminDefault" tabindex="6" required="yes" message="Required: Main Category">
				<cfset EntryValue = '' >
				<cfinclude template="Includes/DDLCat.cfm">
			</cfselect>
		</td>
		<td colspan="2" height="20" class="cfAdminHeader1">&nbsp; COST INFORMATION</td>
	</tr>
	<tr>
		<td><b>Main Section:</b></td>
		<td>
			<cfselect name="SectionID" size="1" class="cfAdminDefault" tabindex="8" required="no" message="Required: Main Section">
				<cfset EntryValue = '' >
				<cfinclude template="Includes/DDLSec.cfm">
			</cfselect>
		</td>
		<td>Cost Price:</td>
		<td><cfinput type="text" name="CostPrice" value="0.00" size="15" class="cfAdminDefault" tabindex="19" required="yes" message="Required: Cost Price (zero value ok)" validate="float"></td>
	</tr>
	<tr>
		<td rowspan="4" valign="top">Other Categories:</td>
		<td rowspan="4" valign="top">
			<cfselect query="getCategories" name="OtherCategories" value="CatID" selected="" display="CatName" multiple="yes" size="5" class="cfAdminDefault" style="width:222px;" ></cfselect>
			<!---
			<cfset OtherCats = Replace(Replace(OtherCategories, "X," , "" , "ALL") , ",X" , "" , "ALL") >
			<cfinput type="text" name="OtherCategories" value="#OtherCats#" size="20" class="cfAdminDefault" tabindex="7"> 
			<a href="##" onClick="window.open('CategoryList.cfm','CategoryList','width=425,height=375,resizable=1,scrollbars=1')">View List</a>
			--->
		</td>
		<td>List Price (MSRP):</td>
		<td><cfinput type="text" name="ListPrice" value="0.00" size="15" class="cfAdminDefault" tabindex="16" required="no" message="Required: List Price" validate="float"></td>
	</tr>
	<tr>
		<td>Taxable:</td>
		<td><cfinput type="checkbox" name="Taxable" checked="yes" tabindex="17"></td>
	</tr>
	<tr>
		<td>Distributor ID:</td>
		<td>
			<cfselect name="DistributorID" query="getDistributors" size="1" tabindex="17" 
				value="DistributorID" display="DistributorName" selected="" class="cfAdminDefault">
				<option value="" selected >-- Select Distributor --</option>
			</cfselect>
		</td>
	</tr>
	<tr>
		<td colspan="2" height="20" class="cfAdminHeader1">&nbsp; ONLINE PRICING & VISIBILITY</td>
	</tr>
	<tr>
		<td rowspan="2" valign="top">Other Sections</td>
		<td rowspan="2" valign="top">
			<cfselect query="getSections" name="OtherSections" value="SectionID" selected="" display="SecName" multiple="yes" size="5" class="cfAdminDefault" style="width:222px;" ></cfselect>
			<!---
			<cfset OtherSecs = Replace(Replace(OtherSections, "X," , "" , "ALL") , ",X" , "" , "ALL") >
			<cfinput type="text" name="OtherSections" value="#OtherSecs#" size="20" class="cfAdminDefault" tabindex="9"> 
			<a href="##" onClick="window.open('SectionList.cfm','SectionList','width=425,height=375,resizable=1,scrollbars=1')">View List</a>
			--->
		</td>
	</tr>
	<!--- PRICES AND HIDE --->
	<tr>
		<td colspan="2" width="100%">
			<table width="100%" border="0" cellpadding="3" cellspacing="0">	
				<tr style="background-color:##7DBF0E;">
					<cfloop query="getUsers">
						<td align="center" colspan="2" height="20" class="cfAdminHeader2" >
							<b>#UName#</b>
						</td>
					</cfloop>
						<td width="100%" class="cfAdminHeader2">&nbsp;</td>
				</tr>
				<tr style="background-color:##CCCCCC;">
					<td height="1" colspan="#Val(getUsers.RecordCount * 2 + 1)#"></td>
				</tr>
				<tr class="cfAdminHeader1" bgcolor="#cfAdminHeaderColor#">
					<cfloop from="1" to="#getUsers.RecordCount#" index="i">
						<td align="center" bgcolor="<cfoutput>#IIF(((i MOD 2) is 0),DE('FFFFFF'),DE('E3E3E3'))#</cfoutput>" ><b>Price</b></td>
						<td align="center" bgcolor="<cfoutput>#IIF(((i MOD 2) is 0),DE('FFFFFF'),DE('E3E3E3'))#</cfoutput>" >Hide</td>
					</cfloop>
						<td bgcolor="FFFFFF">&nbsp;</td>
				</tr>	
				<tr style="background-color:##CCCCCC;">
					<td height="1" colspan="#Val(getUsers.RecordCount * 2)#"></td>
				</tr>
				<tr class="cfAdminHeader1" bgcolor="#cfAdminHeaderColor#">
					<cfloop from="1" to="#getUsers.RecordCount#" index="i">									
						<td align="center" nowrap class="cfAdminDefault" bgcolor="#IIF(((i MOD 2) is 0),DE('FFFFFF'),DE('E3E3E3'))#">
							$<cfinput type="text" name="Price#i#" value="0.00" size="7" maxlength="10" required="yes" message="Required: All Online Prices Are Required" class="cfAdminDefault" />
						</td>
						<td align="center" bgcolor="#IIF(((i MOD 2) is 0),DE('FFFFFF'),DE('E3E3E3'))#">
							<cfinput type="checkbox" name="Hide#i#">
						</td>
					</cfloop>
						<td bgcolor="FFFFFF">&nbsp;</td>
				</tr>
				<tr style="background-color:##CCCCCC;">
					<td height="1" colspan="#Val(getUsers.RecordCount * 2 + 1)#"></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td height="10"></td>
		<td height="10"></td>
		<td height="10"></td>
		<td height="10"></td>
	</tr>
	<tr style="background-color:##65ADF1;">
		<td colspan="2" height="20" class="cfAdminHeader1">&nbsp; PRODUCT OPTIONS &amp; INVENTORY MATRIX</td>
		<td colspan="2" height="20" class="cfAdminHeader1">&nbsp; STATUS &amp; DISPLAY INFORMATION</td>
	</tr>
	<tr>
		<td nowrap height="20">Product Options:</td>
		<td><font style="color:##777777">Please edit product options AFTER adding product</font></td>
		<td nowrap><b>Stock Quantity:</b></td>
		<td><cfinput type="text" name="StockQuantity" value="0" size="15" class="cfAdminDefault" tabindex="20" required="yes" message="Required: Stock Quantity" validate="integer"></td>
	</tr>	
	<tr style="background-color:##CCCCCC;">
		<td height="1" colspan="2"></td>
		<td style="background-color:##FFFFFF;" height="1" colspan="2"></td>
	</tr>
	<tr>
		<td></td>
		<td></td>
		<td><b>Item Status:</b></td>
		<td><cfselect name="ItemStatus" query="getItemStatusCodes" size="1" tabindex="21" required="yes" message="Required: Item Status" 
				value="StatusCode" display="StatusMessage" selected="IS" class="cfAdminDefault" />
		</td>
	</tr>
	<tr>
		<td nowrap>Use Inventory Matrix?</td>
		<td><cfinput type="checkbox" name="UseMatrix" tabindex="12"></td>
		<td nowrap>Use Stock Qty:</td>
		<td><cfinput type="checkbox" name="SellByStock" tabindex="21"></td>
	</tr>
	<tr>
		<td nowrap>Matrix Class:</td>
		<td>
			<cfselect name="ItemClassID" query="getItemClasses" size="1" tabindex="13" 
				value="ICID" display="ICDescription" class="cfAdminDefault">
				<option value="" selected>-- NO ITEM CLASS --</option>
			</cfselect>
		</td>
		<td>Display Order:</td>
		<td><cfinput type="text" name="DisplayOrder" value="1" size="5" class="cfAdminDefault" tabindex="22" required="no" message="Required: Display Order" validate="integer"></td>
	</tr>
	<tr>
		<td nowrap height="20">Inventory Matrix:</td>
		<td><font style="color:##777777;">Please edit product components AFTER adding product</font></td>
		<td valign="top">Search Keywords:
		<td valign="top"><cfinput type="text" name="Comments" size="40" class="cfAdminDefault" tabindex="23"></td>
	</tr>
	<tr>
		<td height="20" colspan="8"></td>
	</tr>
	<tr style="background-color:##65ADF1;">
		<td colspan="2" height="20" class="cfAdminHeader1">&nbsp; ITEM DESCRIPTION</td>
		<td colspan="2" height="20" class="cfAdminHeader1">&nbsp; ITEM DETAILS</td>
	</tr>
	<tr>
		<td height="10" colspan="8"></td>
	</tr>
	<tr>
		<td colspan="2">
			<cfmodule 
				template="FCKeditor/fckeditor.cfm"
				basepath="FCKeditor/"
				instancename="ItemDescription"
				value=''
				width="410"
				height="200"
				toolbarset="CartFusion"
			>
		</td>
		<td colspan="2">
			<cfmodule 
				template="FCKeditor/fckeditor.cfm"
				basepath="FCKeditor/"
				instancename="ItemDetails"
				value=''
				width="410"
				height="200"
				toolbarset="CartFusion"
			>
		</td>
	</tr>
	<tr>
		<td height="20" colspan="8"></td>
	</tr>
	<tr style="background-color:##65ADF1;">
		<td colspan="2" height="20" class="cfAdminHeader1">&nbsp; IMAGE INFORMATION</td>
		<td colspan="2" height="20" class="cfAdminHeader1">&nbsp; IMAGES</td>
	</tr>
	<tr>
		<td height="10" colspan="8"></td>
	</tr>
	<tr>
		<td colspan="2">
			HINT: Before uploading any product images, please specify an Image Path (for example "products").
		</td>
		<td colspan="2" rowspan="10">
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td>
						<font style="color:##777777;">Please upload images AFTER adding product</font>
					</td>
				</tr>
			</table>			
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<hr>
		</td>
	</tr>
	<tr>
		<td>Image Path:</td>
		<td>
			#application.ImagePath#/
			<br>
			<cfinput type="text" name="ImageDir" value="products" size="20" class="cfAdminDefault" tabindex="24">/ImageFiles
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<hr>
		</td>
	</tr>
	<tr>	
		<td nowrap>Main Image File:</td>
		<td>
			<cfinput type="text" name="Image" value="" size="25" class="cfAdminDefault" tabindex="25">
		</td>
	</tr>
	<tr>
		<td nowrap>Large Image File:</td>
		<td>
			<cfinput type="text" name="ImageLarge" value="" size="25" class="cfAdminDefault" tabindex="26">
		</td>
	</tr>
	<tr>	
		<td nowrap>Small Image File:</td>
		<td>
			<cfinput type="text" name="ImageSmall" value="" size="25" class="cfAdminDefault" tabindex="27">
		</td>
	</tr>
	<tr>	
		<td nowrap>Alternate Image File:</td>
		<td>
			<cfinput type="text" name="ImageAlt" value="" size="25" class="cfAdminDefault" tabindex="27">
		</td>
	</tr>
	<tr>	
		<td nowrap>Alternate Large Image File:</td>
		<td>
			<cfinput type="text" name="ImageAltLarge" value="" size="25" class="cfAdminDefault" tabindex="27">
		</td>
	</tr>
	<tr>
		<td nowrap>Feature Product On Site?</td>
		<td><cfinput type="checkbox" name="Featured" tabindex="28"></td>
	</tr>
	<tr>
		<td height="20" colspan="8"></td>
	</tr>
</table>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr style="background-color:##CCCCCC;"><td height="1" colspan="8"></td></tr>
	<tr><td height="1" colspan="8"></td></tr>
	<tr style="background-color:##CCCCCC;"><td height="1" colspan="8"></td></tr>
</table><br>

<!--- PRODUCT OPTIONS 
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td height="20" width="100%" class="cfAdminTitle">OPTION CATEGORIES</td>
	</tr>
	<tr style="background-color:##CCCCCC;"><td height="1"></td></tr>
	<tr><td height="2"></td></tr>
	<tr>
		<td valign="top">
			<table border="0" cellpadding="0" cellspacing="0" width="100%">
				<tr style="background-color:##65ADF1;">
					<td width="15%" class="cfAdminHeader1">&nbsp;Option Category</td>
					<td width="15%" class="cfAdminHeader1">Option Name</td>
					<td width="15%" class="cfAdminHeader1">Optional</td>
					<td width="55%" class="cfAdminHeader1" height="20" align="right">* NOTE: Option Categories must be setup before assigning options &nbsp;</td>
				</tr>	
				<tr>
					<td height="5" colspan="4"></td>
				</tr>
				<tr>
					<td>&nbsp;Option Category 1:</td>
					<td><cfinput type="text" name="OptionName1" size="20" class="cfAdminDefault"></td>
					<td><cfinput type="checkbox" name="Option1Optional"></td>
					<td></td>
				</tr>
				<tr>
					<td>&nbsp;Option Category 2:</td>
					<td><cfinput type="text" name="OptionName2" size="20" class="cfAdminDefault"></td>
					<td><cfinput type="checkbox" name="Option2Optional"></td>
					<td></td>
				</tr>
				<tr>
					<td>&nbsp;Option Category 3:</td>
					<td><cfinput type="text" name="OptionName3" size="20" class="cfAdminDefault"></td>
					<td><cfinput type="checkbox" name="Option3Optional"></td>
					<td></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<br>
--->
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
					<td height="20" colspan="2" class="cfAdminHeader4"></td>
				</tr>	
				<tr>
					<td height="5" colspan="2"></td>
				</tr>
				<tr>
					<td colspan="2">Options may be added for this product AFTER you've added the product to the catalog.</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr><td height="10" colspan="3"></td></tr>
</table>

<br>

<!--- ADD PRODUCT BUTTON --->
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td height="20" colspan="8"></td>
	</tr>
	<tr style="background-color:##F27028;">
		<td colspan="8" height="20" class="cfAdminHeader3" align="center">
			ADD THIS PRODUCT
		</td>
	</tr>
	<tr>
		<td height="20" colspan="8"></td>
	</tr>
	<tr>
		<td align="center">
			<cfinput type="submit" name="AddProduct" value="ADD PRODUCT" alt="Add This Product to the product catalog" class="cfAdminButton">
		</td>
	</tr>
</table>
</cfform>
</cfoutput>
<br><br>

<cfinclude template="LayoutAdminFooter.cfm">