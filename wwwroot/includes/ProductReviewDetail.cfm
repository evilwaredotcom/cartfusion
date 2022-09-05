<html>
<head>
	<title><cfoutput>#application.StoreNameShort#</cfoutput> Product Review</title>
	<link rel="stylesheet" type="text/css" href="/templates/#application.SiteTemplate#/screen_layout.css">
	<link rel="stylesheet" type="text/css" href="/templates/#application.SiteTemplate#/screen_formatting.css">
	<link rel="stylesheet" type="text/css" href="/templates/#application.SiteTemplate#/screen_design.css">
</head>

<body>

<cfif structKeyExists(url, 'ItemID')>
	
	<cfscript>
		getProductReviews = application.Queries.getProductReviews(ItemID=ItemID);
		getProduct = application.Queries.getProduct(ItemID=ItemID);
	</cfscript>
	
	<cfif getProductReviews.RecordCount>
		<table border=0 cellpadding="7" cellspacing="0" width="100%">
			<tr>
				<td colspan="4">
				<cfoutput query="getProduct">
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td width="50%" align="center">
								<cfif TRIM(getProduct.Image) NEQ '' AND FileExists(application.ImageServerPath & '\' & getProduct.ImageDir & '\' & getProduct.Image) >
									<img src="/images/#getProduct.ImageDir#/#getProduct.Image#" id="img1" align="top" alt='#getProduct.ItemName#'><br><br>
								<cfelseif FileExists(application.ImageServerPath & '\' & getProduct.ImageDir & '\' & getProduct.SKU & '.jpg') >
									<img src="/images/#getProduct.ImageDir#/#getProduct.SKU#.jpg" id="img1" align="top" alt='#getProduct.ItemName#'><br><br>
								<cfelseif FileExists(application.ImageServerPath & '\' & getProduct.ImageDir & '\' & getProduct.SKU & '.gif') >
									<img src="/images/#getProduct.ImageDir#/#getProduct.SKU#.gif" id="img1" align="top" alt='#getProduct.ItemName#'><br><br>
								<cfelse>
									<img src="/images/image-EMPTY.gif" id="img1" align="top" alt='#getProduct.ItemName#'><br><br>
								</cfif>
							</td>
							<td width="50%">
								<div class="cfMessageThree"><b>#ItemName#</b></div>
								<div class="cfMessage">SKU: #SKU#</div><br><br>
								<div>Description: #ItemDescription#</div><br>
							</td>
						</tr>
					</table>
				</cfoutput>	
				</td>
			</tr>
			<tr><td colspan="4"><hr class="snip"></td></tr>
			<tr>
				<td class="cfDefault" width="10%" valign="middle"> 
					<b>Avg. Rating:</b><br>
					<cfif getProductReviews.AvgRating EQ 0 >
						<img src="/images/pics/stars/stars_1.gif" align="absmiddle">
					<cfelseif getProductReviews.AvgRating LTE 0.5 >
						<img src="/images/pics/stars/stars_2.gif" align="absmiddle">
					<cfelseif getProductReviews.AvgRating LTE 1 >
						<img src="/images/pics/stars/stars_3.gif" align="absmiddle">
					<cfelseif getProductReviews.AvgRating LTE 1.5 >
						<img src="/images/pics/stars/stars_4.gif" align="absmiddle">	
					<cfelseif getProductReviews.AvgRating LTE 2 >
						<img src="/images/pics/stars/stars_5.gif" align="absmiddle">
					<cfelseif getProductReviews.AvgRating LTE 2.5 >
						<img src="/images/pics/stars/stars_6.gif" align="absmiddle">
					<cfelseif getProductReviews.AvgRating LTE 3 >
						<img src="/images/pics/stars/stars_7.gif" align="absmiddle">
					<cfelseif getProductReviews.AvgRating LTE 3.5 >
						<img src="/images/pics/stars/stars_8.gif" align="absmiddle">
					<cfelseif getProductReviews.AvgRating LTE 4 >
						<img src="/images/pics/stars/stars_9.gif" align="absmiddle">
					<cfelseif getProductReviews.AvgRating LTE 4.5 >
						<img src="/images/pics/stars/stars_10.gif" align="absmiddle">
					<cfelseif getProductReviews.AvgRating LTE 5 >
						<img src="/images/pics/stars/stars_11.gif" align="absmiddle">
					</cfif>
				</td>
				<td width="70%" nowrap valign="bottom"  colspan="2">
					
				</td>
				<td class="cfDefault" width="20%" valign="middle">
					
				</td>
			</tr>
			<tr><td width="90%" colspan="4" height="1"></td></tr>
			<tr><td width="90%" colspan="4" height="1"></td></tr>
			<tr><td width="90%" colspan="4" height="1"></td></tr>
		<cfoutput query="getProductReviews">
			<tr>
				<td class="cfDefault" width="10%" valign="top"> 
					<b>Rating:</b><br>
					<cfif Rating EQ 0 >
						<img src="/images/pics/stars/stars_1.gif" align="absmiddle">
					<cfelseif Rating LTE 0.5 >
						<img src="/images/pics/stars/stars_2.gif" align="absmiddle">
					<cfelseif Rating LTE 1 >
						<img src="/images/pics/stars/stars_3.gif" align="absmiddle">
					<cfelseif Rating LTE 1.5 >
						<img src="/images/pics/stars/stars_4.gif" align="absmiddle">	
					<cfelseif Rating LTE 2 >
						<img src="/images/pics/stars/stars_5.gif" align="absmiddle">
					<cfelseif Rating LTE 2.5 >
						<img src="/images/pics/stars/stars_6.gif" align="absmiddle">
					<cfelseif Rating LTE 3 >
						<img src="/images/pics/stars/stars_7.gif" align="absmiddle">
					<cfelseif Rating LTE 3.5 >
						<img src="/images/pics/stars/stars_8.gif" align="absmiddle">
					<cfelseif Rating LTE 4 >
						<img src="/images/pics/stars/stars_9.gif" align="absmiddle">
					<cfelseif Rating LTE 4.5 >
						<img src="/images/pics/stars/stars_10.gif" align="absmiddle">
					<cfelseif Rating LTE 5 >
						<img src="/images/pics/stars/stars_11.gif" align="absmiddle">
					</cfif>
				</td>
				<td class="cfDefault" width="90%" valign="top" colspan="3"> 
					<b><u>Review:</u></b>&nbsp; "#Review#"
				</td>
			</tr>
			<tr><td colspan="4"><hr class="snip"></td></tr>
		</cfoutput>
		</table>
	<cfelse>
		<cfoutput>
		<table border=0 cellpadding="7" cellspacing="0">
			<tr>
				<td class="cfErrorMsg"><a href="ProductReviewAdd.cfm?ItemID=#ItemID#">Be the first to write a review for this item.</a></td>
			</tr>
		</table>
		</cfoutput>
	</cfif><!--- getProductReviews.RecordCount NEQ 0 --->
</cfif>
</body>
</html>
