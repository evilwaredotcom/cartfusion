<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<cfif isDefined('Form.DeleteDiscount') AND isDefined('Form.DiscountID') >
	<cfif isUserInRole('Administrator')>
		<cfquery name="DeleteDiscount" datasource="#application.dsn#">
			DELETE 
			FROM 	Discounts
			WHERE	DiscountID = #Form.DiscountID#			
		</cfquery>
		<cfset AdminMsg = 'Discount Deleted Successfully' >
	<cfelse>			
		<script language="JavaScript">
			{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
		</script>
	</cfif>
</cfif>

<!--- SET DEFAULT PARAMETERS --->
<cfparam name="URL.StartRow" default="1" type="numeric">
<cfparam name="URL.SortOption" default="DiscountID" type="string">
<cfparam name="URL.SortAscending" default="0" type="numeric">
<cfparam name="Form.Field" default="ALL" type="string">
<cfparam name="Form.string" default="" type="string">	
<cfset string = Trim(string)>

<!--- BEGIN: SEARCH CRITERIA -------------------------------------------------->
	
<cflock timeout="10">	
	<cfquery name="getDiscounts" datasource="#application.dsn#">	
		SELECT 	*
		FROM 	Discounts
		<CFIF Field IS 'All'>
		WHERE 	DiscountID = DiscountID
		<CFELSEIF Field IS 'AllFields'>
		WHERE (DiscountCode like '%#string#%'
		OR 		DiscountName like '%#string#%'
		OR 		DiscountDesc like '%#string#%'
		OR 		DateValidFrom like '%#string#%'
		OR 		DateValidTo like '%#string#%')
		<CFELSE>
		WHERE 	#Field# like '%#string#%'
		</CFIF>
		ORDER BY
		<cfif isDefined('URL.SortOption')> #URL.SortOption# <cfelse> DiscountID </cfif>
		<cfif SortAscending EQ 1> ASC <cfelse> DESC </cfif>
	</cfquery>
</cflock>

<cfinvoke component="#application.Queries#" method="getUsers" returnvariable="getUsers"></cfinvoke>

<!--- END: SEARCH CRITERIA -------------------------------------------------->

<!--- NEXT N VALUES --->
<cfscript>
	RowsPerPage = 15;
	TotalRows = getDiscounts.RecordCount;
	EndRow = Min(URL.StartRow + RowsPerPage - 1, TotalRows);
 	StartRowNext = EndRow + 1;
 	StartRowBack = URL.StartRow - RowsPerPage;
</cfscript>
		
<!--- BEGIN: HEADER --->
<cfscript>
	PageTitle = 'DISCOUNTS';
	ModeAllow = 1 ;
	QuickSearch = 1;
	QuickSearchPage = 'Discounts.cfm';
	AddPage = 'DiscountAdd.cfm';
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">
<!--- END: HEADER --->

<cfoutput>

<table border="0" cellpadding="2" cellspacing="0" width="100%">
	<tr style="background-color:##7DBF0E;">
		<td width="3%" class="cfAdminHeader2" height="20"></td><!--- EDIT --->
		<td width="1%" class="cfAdminHeader2"></td><!--- Process --->
		<td width="5%" class="cfAdminHeader2" nowrap>
			ID
			<a href="Discounts.cfm?SortOption=DiscountID&SortAscending=1&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="Discounts.cfm?SortOption=DiscountID&SortAscending=0&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td width="13%" class="cfAdminHeader2" nowrap>
			Code
			<a href="Discounts.cfm?SortOption=DiscountCode&SortAscending=1&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="Discounts.cfm?SortOption=DiscountCode&SortAscending=0&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td width="12%" class="cfAdminHeader2" nowrap>
			Value
			<a href="Discounts.cfm?SortOption=DiscountValue,IsPercentage&SortAscending=1&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="Discounts.cfm?SortOption=DiscountValue,IsPercentage&SortAscending=0&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td width="20%" class="cfAdminHeader2" nowrap>
			Valid Dates
			<a href="Discounts.cfm?SortOption=DateValidTo&SortAscending=1&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="Discounts.cfm?SortOption=DateValidTo&SortAscending=0&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td width="10%" class="cfAdminHeader2" nowrap>
			Threshold
			<a href="Discounts.cfm?SortOption=OrderTotalLevel&SortAscending=1&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="Discounts.cfm?SortOption=OrderTotalLevel&SortAscending=0&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td width="15%" class="cfAdminHeader2" nowrap>
			Applies To
			<a href="Discounts.cfm?SortOption=ApplyToType,ApplyTo&SortAscending=1&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="Discounts.cfm?SortOption=ApplyToType,ApplyTo&SortAscending=0&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td width="10%" class="cfAdminHeader2" nowrap>
			User
			<a href="Discounts.cfm?SortOption=ApplyToUser&SortAscending=1&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="Discounts.cfm?SortOption=ApplyToUser&SortAscending=0&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td width="10%" class="cfAdminHeader2" align="center" nowrap>
			Expired
			<a href="Discounts.cfm?SortOption=Expired&SortAscending=1&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="Discounts.cfm?SortOption=Expired&SortAscending=0&field=#field#&string=#string#<cfif isDefined('Mode')>&Mode=#Mode#</cfif>"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
	</tr>
</cfoutput>

<!--- START: REGULAR MODE --------------------------------------------------------------------------------------------------->
<cfif Mode EQ 0 >
	<cfoutput query="getDiscounts" startrow="#StartRow#" maxrows="#RowsPerPage#">
		<cfform action="Discounts.cfm?StartRow=#StartRow#&SortOption=#SortOption#&SortAscending=#SortAscending#&field=#field#&string=#string#" method="post">
		<tr>
			<td>
				<input type="button" name="ViewDiscountInfo" value="VIEW" alt="View Discount Information" class="cfAdminButton"
					onclick="document.location.href='DiscountDetail.cfm?DiscountID=#DiscountID#'">
			</td>
			<td>
				<input type="submit" name="DeleteDiscount" value="X" alt="Delete Discount" class="cfAdminButton"
					onclick="return confirm('Are you sure you want to DELETE DISCOUNT CODE &quot;#DiscountCode#&quot; ?')">
			</td>
			<td>#DiscountID#</td>
			<td>#DiscountCode#</td>
			<td><cfif IsPercentage NEQ 1 >$</cfif>#DecimalFormat(DiscountValue)#<cfif IsPercentage EQ 1 >%</cfif></td>
			<td>#DateFormat(DateValidFrom,"mm/dd/yy")# - #DateFormat(DateValidTo,"mm/dd/yy")#</td>
			<td>$#DecimalFormat(OrderTotalLevel)#</td>		
			<td>
				<cfif ApplyToType EQ 0 >All Products
				<cfelseif ApplyToType EQ 1 >
					<cfquery name="getThisProduct" datasource="#application.dsn#">
						SELECT	ItemName
						FROM	Products
						WHERE	ItemID = #ApplyTo#
					</cfquery>
					<a href="ProductDetail.cfm?ItemID=#ApplyTo#">#getThisProduct.ItemName#</a>
				<cfelseif ApplyToType EQ 2 >
					<cfquery name="getThisCat" datasource="#application.dsn#">
						SELECT	CatName
						FROM	Categories
						WHERE	CatID = #ApplyTo#
					</cfquery>
					<a href="CategoryDetail.cfm?CatID=#ApplyTo#">#getThisCat.CatName#</a>
				<cfelseif ApplyToType EQ 3 >
					<cfquery name="getThisSec" datasource="#application.dsn#">
						SELECT	SecName
						FROM	Sections
						WHERE	SectionID = #ApplyTo#
					</cfquery>
					<a href="SectionDetail.cfm?SectionID=#ApplyTo#">#getThisSec.SecName#</a>
				<cfelseif ApplyToType EQ 4 >All Ship Methods
				<cfelseif ApplyToType EQ 5 >
					<cfquery name="getThisShipMethod" datasource="#application.dsn#">
						SELECT	ShippingMessage
						FROM	ShippingMethods
						WHERE	SMID = #ApplyTo#
					</cfquery>
					#getThisShipMethod.ShippingMessage#
				</cfif>
			</td>
			<td>
				<cfquery name="getThisUser" dbtype="query">
					SELECT	UName
					FROM	getUsers
					WHERE	UID = #ApplyToUser#
				</cfquery>
				<cfif getThisUser.RecordCount NEQ 0 >
					#getThisUser.UName#
				<cfelse>
					All Users
				</cfif>
			</td>
			<td align="center"><cfif Expired EQ 1 > Y <cfelse> N </cfif></td>
		</tr>	
		<input type="hidden" name="DiscountID" value="#DiscountID#">
		</cfform>
		<!--- DIVIDER --->
		<tr><td height="1" colspan="11"><img src="images/image-LineGray.gif" width="100%" height="1"></td></tr>
	</cfoutput>
<!--- END: REGULAR MODE --------------------------------------------------------------------------------------------------->
<!--- START: QUICK EDIT MODE --------------------------------------------------------------------------------------------------->
<cfelseif Mode EQ 1 >
	<cfoutput query="getDiscounts" startrow="#StartRow#" maxrows="#RowsPerPage#">
		<cfform action="Discounts.cfm?StartRow=#StartRow#&SortOption=#SortOption#&SortAscending=#SortAscending#&field=#field#&string=#string#" method="post">
		<tr>
			<td>
				<input type="button" name="ViewDiscountInfo" value="VIEW" alt="View Discount Information" class="cfAdminButton"
					onclick="document.location.href='DiscountDetail.cfm?DiscountID=#DiscountID#'">
			</td>
			<td>
				<input type="submit" name="DeleteDiscount" value="X" alt="Delete Discount" class="cfAdminButton"
					onclick="return confirm('Are you sure you want to DELETE DISCOUNT CODE &quot;#DiscountCode#&quot; ?')">
			</td>
			<td>#DiscountID#</td>
			<td><cfinput type="text" name="DiscountCode" value="#DiscountCode#" class="cfAdminDefault" size="15" onchange="updateInfo(#DiscountID#,this.value,'DiscountCode','Discounts');"></td>
			<td><cfif IsPercentage NEQ 1 >$</cfif>#DecimalFormat(DiscountValue)#<cfif IsPercentage EQ 1 >%</cfif></td>
			<td>#DateFormat(DateValidFrom,"mm/dd/yy")# - #DateFormat(DateValidTo,"mm/dd/yy")#</td>
			<td>$#DecimalFormat(OrderTotalLevel)#</td>		
			<td>
				<cfif ApplyToType EQ 0 >All Products
				<cfelseif ApplyToType EQ 1 >
					<cfquery name="getThisProduct" datasource="#application.dsn#">
						SELECT	ItemName
						FROM	Products
						WHERE	ItemID = #ApplyTo#
					</cfquery>
					<a href="ProductDetail.cfm?ItemID=#ApplyTo#">#getThisProduct.ItemName#</a>
				<cfelseif ApplyToType EQ 2 >
					<cfquery name="getThisCat" datasource="#application.dsn#">
						SELECT	CatName
						FROM	Categories
						WHERE	CatID = #ApplyTo#
					</cfquery>
					<a href="CategoryDetail.cfm?CatID=#ApplyTo#">#getThisCat.CatName#</a>
				<cfelseif ApplyToType EQ 3 >
					<cfquery name="getThisSec" datasource="#application.dsn#">
						SELECT	SecName
						FROM	Sections
						WHERE	SectionID = #ApplyTo#
					</cfquery>
					<a href="SectionDetail.cfm?SectionID=#ApplyTo#">#getThisSec.SecName#</a>
				<cfelseif ApplyToType EQ 4 >All Ship Methods
				<cfelseif ApplyToType EQ 5 >
					<cfquery name="getThisShipMethod" datasource="#application.dsn#">
						SELECT	ShippingMessage
						FROM	ShippingMethods
						WHERE	SMID = #ApplyTo#
					</cfquery>
					#getThisShipMethod.ShippingMessage#
				</cfif>
			</td>
			<td>
				<!---
				<select name="ApplyToUser" size="1" class="cfAdminDefault" onChange="updateInfo(#DiscountID#,this.value,'ApplyToUser','Discounts');">
					<option value="0" <cfif ApplyToUser EQ 0 OR ApplyToUser EQ ''> selected </cfif> >All Users</option>
				<cfloop query="getUsers">
					<option value="#UID#" <cfif getDiscounts.ApplyToUser EQ UID > selected </cfif> >#UName#</option>
				</cfloop>	
				</select>
				--->
				<cfselect query="getUsers" name="ApplyToUser" value="UID" display="UName" selected="#ApplyToUser#" size="1" class="cfAdminDefault" onChange="updateInfo(#DiscountID#,this.value,'ApplyToUser','Discounts');">
					<option value="0" <cfif ApplyToUser EQ 0 OR ApplyToUser EQ ''> selected </cfif> >All Users</option>
				</cfselect>
			</td>
			<td align="center"><input type="checkbox" name="Expired" <cfif Expired EQ 1 > checked </cfif> onchange="updateInfo(#DiscountID#,this.value,'Expired','Discounts');"></td>
			<!---
			<td>
				<input type="image" onClick="submit" src="images/updatebutton.gif" name="Update" 
					value="Update" border="0" alt="Update Changes">
			</td>
			--->
		</tr>	
		<input type="hidden" name="DiscountID" value="#DiscountID#">
		</cfform>
		<!--- DIVIDER --->
		<tr><td height="1" colspan="11"><img src="images/image-LineGray.gif" width="100%" height="1"></td></tr>
	</cfoutput>
</cfif>
<!--- END: QUICK EDIT MODE --------------------------------------------------------------------------------------------------->

<!--- NAVIGATION ------------------------------------->
	<tr>
		<td colspan="7"><cfoutput>Displaying <b>#URL.StartRow#</b> to <b>#EndRow#</b> of <b>#TotalRows#</b> Discounts</cfoutput></td>
		<td align="right" colspan="4">		
			<cfinclude template="NextNButtons.cfm">		
		</td>
	</tr>
<!--- NAVIGATION ------------------------------------->
</table>

<cfinclude template="LayoutAdminFooter.cfm">