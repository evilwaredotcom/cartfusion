<cfscript>
	// THIS IS THE START OF THE PRODUCT REVIEWS TABLE SET
	getProductReviewsFive = application.Queries.getProductReviewsFive(ItemID=ItemID);
</cfscript>

<!--- <cfscript>
	myRating = '';
	if( getProductReviewsFive.AvgRating LTE 0.1)	{
		myRating = 1;
	}
	if( getProductReviewsFive.AvgRating LTE 0.5)	{
		myRating = 2;
	}
	if( getProductReviewsFive.AvgRating LTE 1)	{
		myRating = 3;
	}
	if ( getProductReviewsFive.AvgRating LTE 1.5)	{
		myRating = 4;
	}
	if( getProductReviewsFive.AvgRating LTE 2)	{
		myRating = 5;
	}
	if( getProductReviewsFive.AvgRating LTE 2.5)	{
		myRating = 6;
	}
	if( getProductReviewsFive.AvgRating LTE 3)	{
		myRating = 7;
	}
	if( getProductReviewsFive.AvgRating LTE 3.5)	{
		myRating = 8;
	}
	if( getProductReviewsFive.AvgRating LTE 4)	{
		myRating = 9;
	}
	if( getProductReviewsFive.AvgRating LTE 4.5)	{
		myRating = 10;
	}
	if( getProductReviewsFive.AvgRating LTE 5)	{
		myRating = 11;
	}
</cfscript> --->


<cfoutput>

<div style="float:left; padding-left:10px">
<strong>Avg. Rating:</strong><br/>
	 <!--- <img src="images/pics/stars/stars_#myRating#.gif" align="absmiddle"> --->
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

</div>
<div style="float:right; padding-right:10px">
	<a href="javascript: NewWindow('Includes/ProductReviewAdd.cfm?ItemID=#ItemID#','ProductReviewAdd','600','600','yes')">Add a Review</a>
</div>
<br/>
<br clear="left" />
<hr class="divider" />

<cfif getProductReviewsFive.RecordCount>
	
	<cfloop query="getProductReviewsFive">
		<div style="float:left; padding-left:10px">
			<strong>Rating:</strong><br/>
			
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
		</div>
		<div style="float:right; padding-right:10px">
			<a href="javascript: NewWindow('Includes/ProductReviewAdd.cfm?ItemID=#ItemID#','ProductReviewAdd','600','600','yes')"><strong><u>Review:</u></strong></a>&nbsp; "#Review#"
		</div>
		<br/>
		
		<br clear="left" />
		<hr class="snip" />
	</cfloop>

<cfelse>

	<div align="center">
		Be the first to <a href="javascript: NewWindow('Includes/ProductReviewAdd.cfm?ItemID=#ItemID#','ProductReviewAdd','600','600','yes')">write a review</a> for this item!
	</div>
	<hr class="snip" />

</cfif>


<br class="clear" />

</cfoutput>
