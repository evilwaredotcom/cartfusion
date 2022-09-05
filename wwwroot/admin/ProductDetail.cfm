<cfif isDefined('URL.ErrorMsg')>
	<cfif URL.ErrorMsg EQ 1 >
		<script language="JavaScript">
			alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action.") ;
		</script>
	<cfelseif URL.ErrorMsg EQ 2 >
		<script language="JavaScript">
			{ alert ("An error has occurred trying to upload the image. Please try again or contact CartFusion technical support."); }
		</script>
	</cfif>
</cfif>

<!--- DATABASE UPDATES - COMMIT CHANGES ------------------------------------->
<cfif StructKeyExists(Form,'UpdateItemInfo') AND StructKeyExists(Form,'ItemID') AND Form.ItemID NEQ '' AND StructKeyExists(Form,'SKU') AND Form.SKU NEQ '' >
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
				
			<cfupdate datasource="#application.dsn#" tablename="Products"
				formfields="SiteID, ItemID, SKU, ManufacturerID, ItemName, ItemDescription, ItemDetails, Attribute1, Attribute2, 
							Category, OtherCategories, SectionID, OtherSections, CompareType, CostPrice, ListPrice, Weight,
							DimLength, DimWidth, DimHeighth,
							fldShipWeight, fldShipAmount, fldHandAmount, fldShipByWeight, fldOversize, fldShipCode,
							Image, ImageLarge, ImageSmall, ImageAlt, ImageAltLarge, ImageDir, Featured, Taxable, UseMatrix, ItemClassID,
							StockQuantity, ItemStatus, SellByStock, Comments, DistributorID, DisplayOrder, DateUpdated, UpdatedBy">
			
			<cfset AdminMsg = 'Item "#Form.ItemName#" Updated Successfully' >

			<cfcatch>
				<cfset AdminMsg = 'FAIL: Item NOT Updated - #cfcatch#' >
			</cfcatch>
		</cftry>
	<cfelse>			
		<script language="JavaScript">
			alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action.") ;
		</script>
	</cfif>
</cfif>

<cfif StructKeyExists(Form,'UpdateRelatedItem') AND StructKeyExists(Form,'RelatedID') AND StructKeyExists(Form,'ItemID') AND Form.RelatedItemID NEQ ''>
	<cfif isUserInRole('Administrator')>
		<cfquery name="preventDuplicate" datasource="#application.dsn#">
			SELECT  *
			FROM	RelatedItems
			WHERE	ItemID = #Form.ItemID#
			AND		RelatedItemID = #Form.RelatedItemID#
		</cfquery>
		<cfif preventDuplicate.RecordCount EQ 0 AND Form.ItemID NEQ Form.RelatedItemID >
			<cfset Form.DateUpdated = Now() >
			<cfset Form.UpdatedBy = GetAuthUser() >
			<cfupdate datasource="#application.dsn#" tablename="RelatedItems" 
				formfields="RelatedID, ItemID, RelatedItemID, DateUpdated, UpdatedBy">			
			<cfset AdminMsg = 'Related Item Updated Successfully' >
		<cfelse>
			<cfset AdminMsg = 'ERROR OCCURED.  Duplicate Related Item Exists' >
		</cfif>
	<cfelse>
		<script language="JavaScript">
			alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action.") ;
		</script>
	</cfif>
</cfif>

<cfif StructKeyExists(Form,'AddRelatedItem') AND StructKeyExists(Form,'ItemID') AND Form.RelatedItemID NEQ ''>
	<cfif isUserInRole('Administrator')>
		<cfquery name="preventDuplicate" datasource="#application.dsn#">
			SELECT  *
			FROM	RelatedItems
			WHERE	ItemID = #Form.ItemID#
			AND		RelatedItemID = #Form.RelatedItemID#
		</cfquery>
		<cfif preventDuplicate.RecordCount EQ 0 AND Form.ItemID NEQ Form.RelatedItemID >	
			<cfset Form.DateUpdated = Now() >
			<cfset Form.UpdatedBy = GetAuthUser() >
			<cfinsert datasource="#application.dsn#" tablename="RelatedItems" 
				formfields="ItemID, RelatedItemID, DateUpdated, UpdatedBy">			
			<cfset AdminMsg = 'Related Item Added Successfully' >
		<cfelse>
			<cfset AdminMsg = 'ERROR OCCURED.  Duplicate Related Item Exists' >
		</cfif>
	<cfelse>
		<script language="JavaScript">
			alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action.") ;
		</script>
	</cfif>
</cfif>

<cfif StructKeyExists(Form,'DeleteRelatedItem') AND StructKeyExists(Form,'ItemID') AND StructKeyExists(Form,'RelatedItemID')>
	<cfif isUserInRole('Administrator')>
		<cfquery name="deleteRelatedItem" datasource="#application.dsn#">
			DELETE
			FROM 	RelatedItems
			WHERE	RelatedID = #Form.RelatedID#
			AND		ItemID = #Form.ItemID#
			AND		RelatedItemID = #Form.RelatedItemID#
		</cfquery>			
		<cfset AdminMsg = 'Related Item Deleted Successfully' >
	<cfelse>
		<script language="JavaScript">
			alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action.") ;
		</script>
	</cfif>
</cfif>
<!--- !DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<!--- QUERIES ------------------------------------->
<cfinvoke component="#application.Queries#" method="getProduct" returnvariable="getProduct">
	<cfinvokeargument name="ItemID" value="#ItemID#">
</cfinvoke>
<cfinvoke component="#application.Queries#" method="getRelatedItems" returnvariable="getRelatedItems">
	<cfinvokeargument name="ItemID" value="#ItemID#">
</cfinvoke>
<cfinvoke component="#application.Queries#" method="getOptionCategories" returnvariable="getOptionCategories">
	<cfinvokeargument name="ItemID" value="#ItemID#">
</cfinvoke>
<cfinvoke component="#application.Queries#" method="getOptions" returnvariable="getOptions">
	<cfinvokeargument name="ItemID" value="#ItemID#">
</cfinvoke>
<cfinvoke component="#application.Queries#" method="getSites" returnvariable="getSites"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getSKUs" returnvariable="getSKUs"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getItemStatusCodes" returnvariable="getItemStatusCodes"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getUsers" returnvariable="getUsers"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getDistributors" returnvariable="getDistributors"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getProductTypes" returnvariable="getProductTypes"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getItemClasses" returnvariable="getItemClasses"></cfinvoke>
<!--- CARTFUSION 4.6 - Other Categories/Sections Multiple-Select List --->
<cfinvoke component="#application.Queries#" method="getCategories" returnvariable="getCategories"></cfinvoke>
<cfinvoke component="#application.Queries#" method="getSections" returnvariable="getSections"></cfinvoke>
<!--- !QUERIES ------------------------------------->

<!--- BEGIN: HEADER --->
<cfscript>
	PageTitle = 'PRODUCT DETAIL';
	QuickSearch = 1;
	QuickSearchPage = 'Products.cfm';
	AddPage = 'ProductAdd.cfm';
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">
<!--- END: HEADER --->

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<cfoutput query="getProduct">			
<cfform action="ProductDetail.cfm" method="post">
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
				value="SiteID" display="SiteName" selected="#SiteID#" class="cfAdminDefault" />
		</td>
		<td><b>Weight:</b></td>
		<td><cfinput type="text" name="fldShipWeight" value="#NumberFormat(fldShipWeight,0.000)#" size="15" class="cfAdminDefault" tabindex="17" required="yes" message="Required: Weight (in pounds)"> lbs.</td>
	</tr>
	<tr>
		<td><b>SKU:</b></td>
		<td><cfinput type="text" name="SKU" value="#Ucase(SKU)#" size="20" maxlength="20" class="cfAdminDefault" tabindex="2" required="yes" message="Required: SKU">
			&nbsp;&nbsp; <a href="ProductDetail.cfm?ItemID=#ItemID#"><font color="##CCCCCC">ItemID: #ItemID#</font></a>
		</td>
		<td>Ship By Weight?</td>
		<td><input type="checkbox" name="fldShipByWeight" <cfif fldShipByWeight EQ 1>checked</cfif> tabindex="17"></td>
	</tr>
	<tr>
		<td>Manufacturer No:</td>
		<td><cfinput type="text" name="ManufacturerID" value="#UCASE(ManufacturerID)#" size="20" maxlength="20" class="cfAdminDefault" tabindex="2" required="no" message="Required: Manufacturer Number"></td>
		<td>Shipping Amount:</td>
		<td><cfinput type="text" name="fldShipAmount" value="#NumberFormat(fldShipAmount,0.00)#" size="15" class="cfAdminDefault" tabindex="17" required="no" message="Required: Shipping Amount" validate="float"></td>
	</tr>
	<tr>
		<td><b>Item Name:</b></td>
		<td><cfinput type="text" name="ItemName" value="#ItemName#" size="40" class="cfAdminDefault" tabindex="3" required="yes" message="Required: Item Name"></td>
		<td>Handling Amount:</td>
		<td><cfinput type="text" name="fldHandAmount" value="#NumberFormat(fldHandAmount,0.00)#" size="15" class="cfAdminDefault" tabindex="17" required="no" message="Required: Handling Amount" validate="float"></td>
	</tr>
	<tr>
		<td>Attribute 1:</td>
		<td><cfinput type="text" name="Attribute1" value="#Attribute1#" size="40" class="cfAdminDefault" tabindex="4"></td>
		<td>Shipping Code</td>
		<td><cfinput type="text" name="fldShipCode" value="#TRIM(fldShipCode)#" size="15" class="cfAdminDefault" tabindex="18" required="no" message="Required: Shipping Code" validate="integer"> <a href="Config-ShipCodes.cfm">View Codes</a></td>
	</tr>
	<tr>
		<td>Attribute 2:</td>
		<td><cfinput type="text" name="Attribute2" value="#Attribute2#" size="40" class="cfAdminDefault" tabindex="5"></td>
		<td>Oversize?</td>
		<td><input type="checkbox" name="fldOversize" <cfif fldOversize EQ 1>checked</cfif> tabindex="18"></td>
	</tr>
	<tr>
		<td>Compare Type:</td>
		<td>
			<cfselect name="CompareType" query="getProductTypes" size="1"
				value="TypeID" display="TypeName" selected="#CompareType#" class="cfAdminDefault" tabindex="10">
				<option value="0" <cfif CompareType EQ '' OR CompareType EQ 0>selected</cfif>>-- SELECT TYPE --</option>
			</cfselect>
		</td>
		<td>Shipping Dimensions:</td>
		<td><cfinput type="text" name="DimLength" value="#NumberFormat(DimLength,0.00)#" size="3" class="cfAdminDefault" tabindex="18" required="yes" message="Required: Shipping Dimension - Length" validate="float"> in. L &times;
			<cfinput type="text" name="DimWidth" value="#NumberFormat(DimWidth,0.00)#" size="3" class="cfAdminDefault" tabindex="18" required="yes" message="Required: Shipping Dimension - Width" validate="float"> in. W &times;
			<cfinput type="text" name="DimHeighth" value="#NumberFormat(DimHeighth,0.00)#" size="3" class="cfAdminDefault" tabindex="18" required="yes" message="Required: Shipping Dimension - Height" validate="float"> in. H
		</td>
	</tr>
	<tr>
		<td><b>Main Category:</b></td>
		<td>
			<cfselect name="Category" size="1" class="cfAdminDefault" tabindex="6" required="yes" message="Required: Main Category">
				<cfset EntryValue = Category >
				<cfinclude template="Includes/DDLCat.cfm">
			</cfselect>
		</td>
		<td colspan="2" height="20" class="cfAdminHeader1">&nbsp; COST INFORMATION</td>
	</tr>
	<tr>
		<td><b>Main Section:</b></td>
		<td>
			<cfselect name="SectionID" size="1" class="cfAdminDefault" tabindex="8" required="no" message="Required: Main Section">
				<cfset EntryValue = SectionID >
				<cfinclude template="Includes/DDLSec.cfm">
			</cfselect>
		</td>
		<td>Cost Price:</td>
		<td><cfinput type="text" name="CostPrice" value="#NumberFormat(CostPrice,0.00)#" size="15" class="cfAdminDefault" tabindex="15" required="yes" message="Required: Cost Price (zero value ok)" validate="float"></td>
	</tr>
	<tr>
		<td rowspan="4" valign="top">Other Categories:</td>
		<td rowspan="4" valign="top">
			<cfselect query="getCategories" name="OtherCategories" value="CatID" selected="#OtherCategories#" display="CatName" multiple="yes" size="5" class="cfAdminDefault" style="width:222px;" ></cfselect>
			<!---
			<cfset OtherCats = Replace(Replace(OtherCategories, "X," , "" , "ALL") , ",X" , "" , "ALL") >
			<cfinput type="text" name="OtherCategories" value="#OtherCats#" size="20" class="cfAdminDefault" tabindex="7"> 
			<a href="##" onClick="window.open('CategoryList.cfm','CategoryList','width=425,height=375,resizable=1,scrollbars=1')">View List</a>
			--->
		</td>
		<td>List Price (MSRP):</td>
		<td><cfinput type="text" name="ListPrice" value="#NumberFormat(ListPrice,0.00)#" size="15" class="cfAdminDefault" tabindex="16" required="no" message="Required: List Price" validate="float"></td>
	</tr>
	<tr>
		<td>Taxable:</td>
		<td><input type="checkbox" name="Taxable" <cfif Taxable EQ 1>checked</cfif> tabindex="17"></td>
	</tr>
	<tr>
		<td>Distributor ID:</td>
		<td>
			<cfselect name="DistributorID" query="getDistributors" size="1" tabindex="17" 
				value="DistributorID" display="DistributorName" selected="#DistributorID#" class="cfAdminDefault">
				<option value="" <cfif DistributorID EQ '' OR DistributorID EQ 0 > selected </cfif> >-- Select Distributor --</option>
			</cfselect>
		</td>
	</tr>
	<tr>
		<td colspan="2" height="20" class="cfAdminHeader1">&nbsp; ONLINE PRICING & VISIBILITY</td>
	</tr>
	<tr>
		<td rowspan="2" valign="top">Other Sections</td>
		<td rowspan="2" valign="top">
			<cfselect query="getSections" name="OtherSections" value="SectionID" selected="#OtherSections#" display="SecName" multiple="yes" size="5" class="cfAdminDefault" style="width:222px;" ></cfselect>
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
			<a id="PRICES"></a>			
			<table width="100%" border="0" cellpadding="3" cellspacing="0">	
				<tr style="background-color:##7DBF0E;">
					<cfloop query="getUsers">
						<td align="center" colspan="2" height="20" class="cfAdminHeader2" >
							<b>#UName#</b>
						</td>
					</cfloop>
						<td width="100%" class="cfAdminHeader2">&nbsp;</td>
				</tr>
				<tr class="cfAdminHeader1" bgcolor="#cfAdminHeaderColor#">
					<cfloop from="1" to="#getUsers.RecordCount#" index="i">
						<td align="center" bgcolor="<cfoutput>#IIF(((i MOD 2) is 0),DE('FFFFFF'),DE('E3E3E3'))#</cfoutput>" ><b>Price</b></td>
						<td align="center" bgcolor="<cfoutput>#IIF(((i MOD 2) is 0),DE('FFFFFF'),DE('E3E3E3'))#</cfoutput>" >Hide</td>
					</cfloop>
						<td width="100%" bgcolor="FFFFFF">&nbsp;</td>
				</tr>
				<tr class="cfAdminHeader1" bgcolor="#cfAdminHeaderColor#">
					<cfloop from="1" to="#getUsers.RecordCount#" index="i">
						<cfscript>
							ThisPrice = NumberFormat(Evaluate("Price" & i),0.00) ;
							ThisHide  = Evaluate("Hide" & i) ;
						</cfscript>										
						<td align="center" class="cfAdminDefault" bgcolor="#IIF(((i MOD 2) is 0),DE('FFFFFF'),DE('E3E3E3'))#" nowrap>
							$<cfinput type="text" name="Price#i#" value="#ThisPrice#" size="6" maxlength="10" class="cfAdminDefault"
								onchange="updateInfo(#ItemID#,this.value,'Price#i#','Products');" required="yes" message="All Prices Are Required">
						</td>
						<td align="center" bgcolor="#IIF(((i MOD 2) is 0),DE('FFFFFF'),DE('E3E3E3'))#">
							<input type="checkbox" name="Hide#i#" onclick="updateInfo(#ItemID#,this.value,'Hide#i#','Products');" <cfif ThisHide EQ 1>checked</cfif> >
						</td>
					</cfloop>
						<td width="100%" bgcolor="FFFFFF">&nbsp;</td>
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
		<td colspan="2" height="20" class="cfAdminHeader1">&nbsp; PRODUCT OPTIONS & INVENTORY MATRIX</td>
		<td colspan="2" height="20" class="cfAdminHeader1">&nbsp; STATUS & DISPLAY INFORMATION</td>
	</tr>
	<tr>
		<td nowrap>Product Options:</td>
		<td><cfinput type="button" name="ViewOptionInfo" value="VIEW/EDIT" alt="View Product Option Information" class="cfAdminButton"
				onclick="document.location.href='ProductOptions.cfm?ItemID=#ItemID#'" tabindex="11"></td>
		<td nowrap><b>Stock Quantity:</b></td>
		<td><cfinput type="text" name="StockQuantity" value="#StockQuantity#" size="15" class="cfAdminDefault" tabindex="20" required="yes" message="Stock Quantity Required"></td>
	</tr>
	<tr style="background-color:##CCCCCC;">
		<td height="1" colspan="2"></td>
		<td bgcolor="FFFFFF" height="1" colspan="2"></td>
	</tr>
	<tr>
		<td></td>
		<td></td>
		<td><b>Item Status:</b></td>
		<td><cfselect name="ItemStatus" query="getItemStatusCodes" size="1" tabindex="21" 
				value="StatusCode" display="StatusMessage" selected="#ItemStatus#" class="cfAdminDefault" />
		</td>
	</tr>
	<tr>
		<td nowrap>Use Inventory Matrix?</td>
		<td><input type="checkbox" name="UseMatrix" <cfif UseMatrix EQ 1>checked</cfif> tabindex="12"></td>
		<td nowrap>Use Stock Qty:</td>
		<td><input type="checkbox" name="SellByStock" <cfif SellByStock EQ 1>checked</cfif> tabindex="21"></td>
	</tr>
	<tr>
		<td nowrap>Matrix Class:</td>
		<td>
			<cfselect name="ItemClassID" query="getItemClasses" size="1" tabindex="13" 
				value="ICID" display="ICDescription" selected="#ItemClassID#" class="cfAdminDefault">
				<option value="" <cfif ItemClassID EQ '' OR ItemClassID EQ 0 >selected</cfif>>-- NO ITEM CLASS --</option>
			</cfselect>
		</td>
		<td>Display Order:</td>
		<td><cfinput type="text" name="DisplayOrder" value="#DisplayOrder#" size="5" class="cfAdminDefault" tabindex="22"></td>
	</tr>
	<tr>
		<td nowrap>Inventory Matrix:</td>
		<td><cfinput type="button" name="ViewComponentInfo" value="VIEW/EDIT" alt="View Inventory Matrix Information" class="cfAdminButton"
				onclick="document.location.href='ProductMatrix.cfm?ItemID=#ItemID#'" tabindex="14"></td>
		<td valign="top">Search Keywords:
		<td valign="top"><cfinput type="text" name="Comments" value="#Comments#" size="40" class="cfAdminDefault" tabindex="23"></td>
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
				value='#ItemDescription#'
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
				value='#ItemDetails#'
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
			HINT: Before uploading any product images, please specify an Image Path (for example "products") and Update Changes.
		</td>
		<td colspan="2" rowspan="10">
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td align="center">
						<cfif Image IS ''><b>NO MAIN IMAGE SET</b>
						<cfelse>
							<img src="#application.ImagePath#/#ImageDir#/#Image#" border="0" vspace="3" hspace="3"><br>
							Main Image
						</cfif>
					</td>
					<td align="center">
						<cfif ImageSmall IS ''><b>NO SMALL IMAGE SET</b>
						<cfelse>
							<img src="#application.ImagePath#/#ImageDir#/#ImageSmall#" border="0" vspace="3" hspace="3"><br>
							Small Image
						</cfif>
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
			#application.ImagePath#/<br>
			<cfinput type="text" name="ImageDir" value="#ImageDir#" size="20" class="cfAdminDefault" tabindex="24">/ImageFiles
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
			<cfinput type="text" name="Image" value="#Image#" size="25" class="cfAdminDefault" tabindex="25">
			<cfinput type="button" name="NewMainImage" value="UPLOAD" alt="Upload New Main Image" class="cfAdminButton"
				onclick="document.location.href='ImageUpload.cfm?Image=Image&ImageDir=#URLEncodedFormat(ImageDir)#&ImageID=#ItemID#&SiteID=#SiteID#&Table=Products&ColumnID=ItemID'">
		</td>
	</tr>
	<tr>
		<td nowrap>Large Image File:</td>
		<td>
			<cfinput type="text" name="ImageLarge" value="#ImageLarge#" size="25" class="cfAdminDefault" tabindex="26">
			<cfinput type="button" name="NewLargeImage" value="UPLOAD" alt="Upload New Large Image" class="cfAdminButton"
				onclick="document.location.href='ImageUpload.cfm?Image=ImageLarge&ImageDir=#URLEncodedFormat(ImageDir)#&ImageID=#ItemID#&SiteID=#SiteID#&Table=Products&ColumnID=ItemID'">
		</td>
	</tr>
	<tr>	
		<td nowrap>Small Image File:</td>
		<td>
			<cfinput type="text" name="ImageSmall" value="#ImageSmall#" size="25" class="cfAdminDefault" tabindex="27">
			<cfinput type="button" name="NewSmallImage" value="UPLOAD" alt="Upload New Small Image" class="cfAdminButton"
				onclick="document.location.href='ImageUpload.cfm?Image=ImageSmall&ImageDir=#URLEncodedFormat(ImageDir)#&ImageID=#ItemID#&SiteID=#SiteID#&Table=Products&ColumnID=ItemID'">
		</td>
	</tr>
	<tr>	
		<td nowrap>Alternate Image File:</td>
		<td>
			<cfinput type="text" name="ImageAlt" value="#ImageAlt#" size="25" class="cfAdminDefault" tabindex="27">
			<cfinput type="button" name="NewAltImage" value="UPLOAD" alt="Upload New Alternate Image" class="cfAdminButton"
				onclick="document.location.href='ImageUpload.cfm?Image=ImageAlt&ImageDir=#URLEncodedFormat(ImageDir)#&ImageID=#ItemID#&SiteID=#SiteID#&Table=Products&ColumnID=ItemID'">
		</td>
	</tr>
	<tr>	
		<td nowrap>Alternate Large Image File:</td>
		<td>
			<cfinput type="text" name="ImageAltLarge" value="#ImageAltLarge#" size="25" class="cfAdminDefault" tabindex="27">
			<cfinput type="button" name="NewAltLargeImage" value="UPLOAD" alt="Upload New Alternate Image" class="cfAdminButton"
				onclick="document.location.href='ImageUpload.cfm?Image=ImageAltLarge&ImageDir=#URLEncodedFormat(ImageDir)#&ImageID=#ItemID#&SiteID=#SiteID#&Table=Products&ColumnID=ItemID'">
		</td>
	</tr>
	<tr>
		<td nowrap>Feature Product On Site?</td>
		<td><input type="checkbox" name="Featured" <cfif Featured EQ 1>checked</cfif> tabindex="28"></td>
	</tr>
	<tr>
		<td height="20" colspan="8"></td>
	</tr>
	<tr style="background-color:##F27028;">
		<td colspan="8" height="20" class="cfAdminHeader3" align="center">
			UPDATE ABOVE INFORMATION
		</td>
	</tr>
	<tr>
		<td height="20" colspan="8"></td>
	</tr>
	<tr>
		<td colspan="8" align="center">
			<cfinput type="submit" name="UpdateItemInfo" value="UPDATE CHANGES" alt="Update Changes" class="cfAdminButton" tabindex="29">
		</td>
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

<cfinput type="hidden" name="ItemID" value="#ItemID#">	
</cfform>
</cfoutput>


<!--- RELATED ITEMS --->
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td height="20" width="49%" class="cfAdminTitle">RELATED PRODUCTS</td>
		<td rowspan="20" width="1%" bgcolor="FFFFFF">&nbsp;</td>
		<td height="20" width="50%" class="cfAdminTitle">PRODUCT SPECIFICATIONS</td>
	</tr>
	<tr style="background-color:##CCCCCC;"><td height="1"></td><td height="1"></td></tr>
	<tr><td height="2" colspan="6"></td></tr>
	<tr>
		<td valign="top">
			<table border="0" cellpadding="0" cellspacing="0" width="100%">	
				<tr style="background-color:##65ADF1;">
					<td width="1%"  class="cfAdminHeader1" height="20" align="center"></td><!--- DELETE/ADD --->
					<td width="15%" class="cfAdminHeader1">Related SKU</td>
					<td width="*"   class="cfAdminHeader1"></td><!--- SPACE --->
				</tr>
				<tr>
					<td height="5" colspan="3"></td>
				</tr>
				
				<!--- DISPLAY CURRENT RELATED ITEMS --->
				<cfoutput query="getRelatedItems">			
				<cfform action="ProductDetail.cfm" method="post">
				<tr>
					<td align="center">
						<cfinput type="submit" name="DeleteRelatedItem" value="X" alt="Delete Related Item" class="cfAdminButton"
							onclick="return confirm('Are you sure you want to DELETE THIS RELATED ITEM?')">&nbsp;
					</td>
					<td>
						<cfselect query="getSKUs" name="RelatedItemID" value="ItemID" display="SKUItemName" selected="#RelatedItemID#" size="1" class="cfAdminDefault"></cfselect>
					</td>
					<td>
						<cfinput type="submit" name="UpdateRelatedItem" value="UPDATE" alt="Update Related Item" class="cfAdminButton">
					</td>
				</tr>
				<tr>
					<td height="2" colspan="3"></td>
				</tr>
				<tr style="background-color:##CCCCCC;">
					<td height="1" colspan="3"></td>
				</tr>
				<tr>
					<td height="2" colspan="3"></td>
				</tr>
				<cfinput type="hidden" name="RelatedID" value="#RelatedID#">
				<cfinput type="hidden" name="ItemID" value="#ItemID#">	
				</cfform>
				</cfoutput>

				<!--- ADD NEW RELATED ITEM --->
				<cfform action="ProductDetail.cfm" method="post">
				<tr>
					<td align="center">
						<cfinput type="submit" name="AddRelatedItem" value="ADD" alt="Add Related Item" class="cfAdminButton">&nbsp;
					</td>
					<td>
						<cfselect query="getSKUs" name="RelatedItemID" value="ItemID" display="SKUItemName" size="1" class="cfAdminDefault">
							<option value="" selected></option>
						</cfselect>
					</td>
					<td></td><!--- SPACE --->
				</tr>
					<cfinput type="hidden" name="ItemID" value="#getProduct.ItemID#">	
				</cfform>
			</table>
		</td>
		<td valign="top">
			<table border="0" cellpadding="0" cellspacing="0" width="100%">	
				<tr style="background-color:##65ADF1;">
					<td height="20" class="cfAdminHeader1"></td>
				</tr>
				<tr>
					<td height="20" align="center">
						<cfif getProduct.CompareType NEQ '' AND getProduct.CompareType NEQ 0 >
							<a href="ProductSpecs.cfm?ItemID=<cfoutput>#getProduct.ItemID#</cfoutput>">Setup Product Specifications</a>
						<cfelse>
							To edit Product Specifications, you must set a<br>Compare Type above and Update Changes.
						</cfif>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<br><br>
<cfinclude template="LayoutAdminFooter.cfm">