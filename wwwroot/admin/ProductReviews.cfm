<!--- BEGIN: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<cfif isDefined('form.UpdateReview') AND IsDefined("form.PRID") AND Form.Review NEQ ''>
	<cfupdate datasource="#application.dsn#" tablename="ProductReviews" 
		formfields="PRID, ItemID, Review">
	<cfset AdminMsg = 'Product Review Updated Successfully' >
</cfif>

<cfif isDefined('form.AddReview') AND Form.Review NEQ '' AND Form.Rating NEQ ''>
	<cfinsert datasource="#application.dsn#" tablename="ProductReviews" 
		formfields="ItemID, Rating, Review">
	<cfset AdminMsg = 'Product Review Added Successfully' >
</cfif>

<cfif isDefined('form.DeleteReview') AND IsDefined("form.PRID")>
	<cfinvoke component="#application.Queries#" method="deleteReview" returnvariable="deleteReview">
		<cfinvokeargument name="PRID" value="#Form.PRID#">
	</cfinvoke>
	<cfset AdminMsg = 'Product Review Deleted Successfully' >
</cfif>

<!--- END: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<!--- SET DEFAULT PARAMETERS --->
<cfparam name="URL.StartRow" default="1" type="numeric">
<cfparam name="URL.SortOption" default="SKU" type="string">
<cfparam name="URL.SortAscending" default="0" type="numeric">
<cfparam name="Form.Field" default="ALL" type="string">
<cfparam name="Form.string" default="" type="string">
<cfset string = Trim(string)>

<!--- BEGIN: SEARCH CRITERIA -------------------------------------------------->
	
<cfquery name="getProductReviews" datasource="#application.dsn#">	
	SELECT 	*,
			( SELECT SKU FROM Products WHERE ItemID = pr.ItemID ) AS SKU
	FROM 	ProductReviews pr
	<cfif field EQ 'AllFields'>
	WHERE 	pr.Review LIKE '%#string#%'
	OR		pr.ItemID IN ( SELECT ItemID FROM Products WHERE SKU LIKE '%#string#%' )
	</cfif>
	ORDER BY
	<cfif isDefined('URL.SortOption')> #URL.SortOption# <cfelse> SKU </cfif>
	<cfif SortAscending EQ 1> ASC <cfelse> DESC </cfif>
</cfquery>

<cfinvoke component="#application.Queries#" method="getSKUs" returnvariable="getSKUs"></cfinvoke>

<!--- END: SEARCH CRITERIA -------------------------------------------------->

<!--- NEXT N VALUES --->
<cfscript>
	RowsPerPage = 5;
	TotalRows = getProductReviews.RecordCount;
	EndRow = Min(URL.StartRow + RowsPerPage - 1, TotalRows);
 	StartRowNext = EndRow + 1;
 	StartRowBack = URL.StartRow - RowsPerPage;
</cfscript>

<!--- HEADER --->
<cfscript>
	PageTitle = 'ADD PRODUCT REVIEW';
	QuickSearch = 1;
	QuickSearchPage = 'ProductReviews.cfm';
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">

<cfoutput>

<table border="0" cellpadding="3" cellspacing="0" width="100%">	
<cfform action="ProductReviews.cfm" method="post">
	<tr style="background-color:##65ADF1;">
		<td width="10%" class="cfAdminHeader1" nowrap>Product</td>
		<td width="20%" class="cfAdminHeader1" nowrap>Rating</td>
		<td width="35%" class="cfAdminHeader1" nowrap>Review</td>
		<td width="15%" class="cfAdminHeader1" nowrap>Date Created</td>
		<td width="30%" class="cfAdminHeader1">&nbsp;</td><!--- ADD --->
	</tr>
	<tr>
		<td>
			<cfselect name="ItemID" class="cfAdminDefault" query="getSKUs" value="ItemID" display="SKU" />	
		</td>
		<td> 
			<cfinput type="radio" name="Rating" value="0" required="yes" message="Rating is Required"><img src="images/pics/stars/stars_1.gif" align="absmiddle"><br>
			<cfinput type="radio" name="Rating" value="1" ><img src="images/pics/stars/stars_3.gif" align="absmiddle"><br>
			<cfinput type="radio" name="Rating" value="2" ><img src="images/pics/stars/stars_5.gif" align="absmiddle"><br>
			<cfinput type="radio" name="Rating" value="3" ><img src="images/pics/stars/stars_7.gif" align="absmiddle"><br>
			<cfinput type="radio" name="Rating" value="4" ><img src="images/pics/stars/stars_9.gif" align="absmiddle"><br>
			<cfinput type="radio" name="Rating" value="5" ><img src="images/pics/stars/stars_11.gif" align="absmiddle">
		</td>
		<td> 
			<textarea name="Review" cols="60" rows="4" class="cfAdminDefault"></textarea>
		</td>
		<td>#DateFormat(Now(), "mm/dd/yyyy")#<br>#TimeFormat(Now(), "@ hh:mm tt")#</td>
		<td align="center">
			<input type="submit" name="AddReview" value="ADD" alt="Add Review" class="cfAdminButton">
		</td>
	</tr>
</cfform>
</table>

<br>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr><td height="20" class="cfAdminTitle">PRODUCT REVIEWS</td></tr>
</table>

<table border="0" cellpadding="3" cellspacing="0" width="100%">	
	<tr style="background-color:##65ADF1;">
		<td width="10%" class="cfAdminHeader1" nowrap>
			Product
			<a href="ProductReviews.cfm?SortOption=SKU&SortAscending=1"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="ProductReviews.cfm?SortOption=SKU&SortAscending=0"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td width="20%" class="cfAdminHeader1" nowrap>
			Rating
			<a href="ProductReviews.cfm?SortOption=Rating&SortAscending=1"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="ProductReviews.cfm?SortOption=Rating&SortAscending=0"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td width="35%" class="cfAdminHeader1" nowrap>
			Review
		</td>
		<td width="15%" class="cfAdminHeader1" nowrap>
			Date Created
			<a href="ProductReviews.cfm?SortOption=DateCreated&SortAscending=1"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="ProductReviews.cfm?SortOption=DateCreated&SortAscending=0"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td width="30%" class="cfAdminHeader1">&nbsp;</td><!--- DELETE --->
	</tr>
</cfoutput>

<cfoutput query="getProductReviews" startrow="#StartRow#" maxrows="#RowsPerPage#">
	<cfform action="ProductReviews.cfm?StartRow=#StartRow#&SortOption=#SortOption#&SortAscending=#SortAscending#&field=#field#&string=#string#" method="post">
	<tr>
		<td>#SKU#</td>
		<td>
			<cfif Rating EQ 0 >
				<img src="images/pics/stars/stars_1.gif" align="absmiddle">
			<cfelseif Rating LTE 0.5 >
				<img src="images/pics/stars/stars_2.gif" align="absmiddle">
			<cfelseif Rating LTE 1 >
				<img src="images/pics/stars/stars_3.gif" align="absmiddle">
			<cfelseif Rating LTE 1.5 >
				<img src="images/pics/stars/stars_4.gif" align="absmiddle">	
			<cfelseif Rating LTE 2 >
				<img src="images/pics/stars/stars_5.gif" align="absmiddle">
			<cfelseif Rating LTE 2.5 >
				<img src="images/pics/stars/stars_6.gif" align="absmiddle">
			<cfelseif Rating LTE 3 >
				<img src="images/pics/stars/stars_7.gif" align="absmiddle">
			<cfelseif Rating LTE 3.5 >
				<img src="images/pics/stars/stars_8.gif" align="absmiddle">
			<cfelseif Rating LTE 4 >
				<img src="images/pics/stars/stars_9.gif" align="absmiddle">
			<cfelseif Rating LTE 4.5 >
				<img src="images/pics/stars/stars_10.gif" align="absmiddle">
			<cfelseif Rating LTE 5 >
				<img src="images/pics/stars/stars_11.gif" align="absmiddle">
			</cfif>
		</td>
		<td>
			<textarea name="Review" cols="60" rows="5" class="cfAdminDefault">#Review#</textarea>
		</td>
		<td>#DateFormat(DateCreated, "mm/dd/yyyy")#<br>#TimeFormat(DateCreated, "@ hh:mm tt")#</td>
		<td align="center">
			<input type="submit" name="UpdateReview" value="UPDATE" alt="Update Review" class="cfAdminButton">
			<input type="submit" name="DeleteReview" value="DELETE" alt="Delete Review" class="cfAdminButton"
				onclick="return confirm('Are you sure you want to DELETE THIS REVIEW ?')">
		</td>
	</tr>
	<input type="hidden" name="PRID" value="#PRID#">
	<input type="hidden" name="ItemID" value="#ItemID#">
	</cfform>
</cfoutput>

<!--- DIVIDER --->
	<tr style="background-color:##CCCCCC;">
		<td height="1" colspan="5"></td>
	</tr>

<!--- NAVIGATION ------------------------------------->
	<tr>
		<td colspan="2"><cfoutput>Displaying <b>#URL.StartRow#</b> to <b>#EndRow#</b> of <b>#TotalRows#</b> Reviews</cfoutput></td>
		<td align="right" colspan="3"><cfinclude template="NextNButtons.cfm"></td>
	</tr>
<!--- NAVIGATION ------------------------------------->
</table>
	
<cfinclude template="LayoutAdminFooter.cfm">