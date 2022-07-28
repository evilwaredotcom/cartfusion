<!--- THIS IS THE START OF THE PRODUCT REVIEWS TABLE SET --->

<cfinvoke component="#application.Queries#" method="getProductReviewsFive" returnvariable="getProductReviewsFive">
	<cfinvokeargument name="ItemID" value="#ItemID#">
</cfinvoke>

<table border=0 <!--- style="border-color:<cfoutput>#layout.TableHeadingBGColor#</cfoutput>;" ---> cellpadding="3" cellspacing="0" width="100%">
	<tr>
		<td class="cfDefault" width="10%" valign="middle"> 
			<b>Avg. Rating:</b><br>
			<cfif getProductReviewsFive.AvgRating LTE 0.1 >
				<img src="images/pics/stars/stars_1.gif" align="absmiddle">
			<cfelseif getProductReviewsFive.AvgRating LTE 0.5 >
				<img src="images/pics/stars/stars_2.gif" align="absmiddle">
			<cfelseif getProductReviewsFive.AvgRating LTE 1 >
				<img src="images/pics/stars/stars_3.gif" align="absmiddle">
			<cfelseif getProductReviewsFive.AvgRating LTE 1.5 >
				<img src="images/pics/stars/stars_4.gif" align="absmiddle">	
			<cfelseif getProductReviewsFive.AvgRating LTE 2 >
				<img src="images/pics/stars/stars_5.gif" align="absmiddle">
			<cfelseif getProductReviewsFive.AvgRating LTE 2.5 >
				<img src="images/pics/stars/stars_6.gif" align="absmiddle">
			<cfelseif getProductReviewsFive.AvgRating LTE 3 >
				<img src="images/pics/stars/stars_7.gif" align="absmiddle">
			<cfelseif getProductReviewsFive.AvgRating LTE 3.5 >
				<img src="images/pics/stars/stars_8.gif" align="absmiddle">
			<cfelseif getProductReviewsFive.AvgRating LTE 4 >
				<img src="images/pics/stars/stars_9.gif" align="absmiddle">
			<cfelseif getProductReviewsFive.AvgRating LTE 4.5 >
				<img src="images/pics/stars/stars_10.gif" align="absmiddle">
			<cfelseif getProductReviewsFive.AvgRating LTE 5 >
				<img src="images/pics/stars/stars_11.gif" align="absmiddle">
			</cfif>
		</td>
		<td width="70%" nowrap valign="bottom"  colspan="2">
			
		</td>
		<td class="cfDefault" width="20%" valign="middle" align="right">
			<a href="##" onClick="window.open('Includes/ProductReviewAdd.cfm?ItemID=<cfoutput>#ItemID#</cfoutput>','ProductReviewAdd','width=450,height=400,resizable=1,scrollbars=yes')"><b><u>Add a Review</u></b></a>
		</td>
	</tr>
	<tr><td width="90%" colspan="4" height="1" <!--- bgcolor="<cfoutput>#layout.TableHeadingBGColor#</cfoutput>" --->></td></tr>
	<tr><td width="90%" colspan="4" height="1" <!--- bgcolor="<cfoutput>#layout.PrimaryBGColor#</cfoutput>" --->></td></tr>
	<tr><td width="90%" colspan="4" height="1" <!--- bgcolor="<cfoutput>#layout.TableHeadingBGColor#</cfoutput>" --->></td></tr>
<cfif getProductReviewsFive.RecordCount NEQ 0>	
	<cfoutput query="getProductReviewsFive">
	<tr>
		<td class="cfDefault" width="10%" valign="top"> 
			<b>Rating:</b><br>
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
		<td class="cfDefault" width="90%" valign="top" colspan="3"> 
			<a href="##" onClick="window.open('Includes/ProductReviewDetail.cfm?ItemID=#ItemID#','ProductReview','width=450,height=450,resizable=1,scrollbars=yes')"><b><u>Review:</u></b></a>&nbsp; "#Review#"
		</td>
	</tr>
	<tr><td width="90%" colspan="4" height="1" <!--- bgcolor="#layout.TableHeadingBGColor#" --->></td></tr>
	</cfoutput>
<cfelse>
	<tr>
		<td class="cfErrorMsg" colspan="4">There are no reviews for this product</td>
	</tr>
</cfif><!--- getProductReviews.RecordCount NEQ 0 --->
</table>
<!--- THIS IS THE END OF THE PRODUCT REVIEWS TABLE SET --->