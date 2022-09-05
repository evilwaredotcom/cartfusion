<cfif isDefined('SubmitReview')>
	<cftry>
		
		<cfscript>
			/* 	Adds Product Review In
				Added in By Carl Vanderpal - 20 June 2007
			*/
			addProductReview = application.Queries.addProductReview(
				ItemID=form.ItemID,
				Rating=form.Rating,
				Review=form.Review);
		</cfscript>
		
		<script language="javascript">
			window.close();
		</script>
		
		<cfcatch>
			ERROR: Please try again later
		</cfcatch>
	</cftry>
</cfif>

<cfoutput>
<html>
<head>
	<title>#application.StoreNameShort# Add Product Review</title>
	<link rel="stylesheet" type="text/css" href="../templates/#application.SiteTemplate#/screen_layout.css">
	<link rel="stylesheet" type="text/css" href="../templates/#application.SiteTemplate#/screen_formatting.css">
	<link rel="stylesheet" type="text/css" href="../templates/#application.SiteTemplate#/screen_design.css">
</head>

<body>

<cfif structKeyExists(url, 'ItemID')>
	
	<cfscript>
		getProduct = application.Queries.getProduct(ItemID=ItemID);
	</cfscript>
	
	<table border=0 cellpadding="7" cellspacing="0" width="100%">
		<tr>
			<td colspan="2" >
			<cfloop query="getProduct">
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td width="50%" align="center">
							<cfif TRIM(getProduct.Image) NEQ '' AND FileExists(application.ImageServerPath & '\' & getProduct.ImageDir & '\' & getProduct.Image) >
								<img src="../images/#getProduct.ImageDir#/#getProduct.Image#" id="img1" align="top" alt='#getProduct.ItemName#'><br><br>
							<cfelseif FileExists(application.ImageServerPath & '\' & getProduct.ImageDir & '\' & getProduct.SKU & '.jpg') >
								<img src="../images/#getProduct.ImageDir#/#getProduct.SKU#.jpg" id="img1" align="top" alt='#getProduct.ItemName#'><br><br>
							<cfelseif FileExists(application.ImageServerPath & '\' & getProduct.ImageDir & '\' & getProduct.SKU & '.gif') >
								<img src="../images/#getProduct.ImageDir#/#getProduct.SKU#.gif" id="img1" align="top" alt='#getProduct.ItemName#'><br><br>
							<cfelse>
								<img src="../images/image-EMPTY.gif" id="img1" align="top" alt='#getProduct.ItemName#'><br><br>
							</cfif>
						</td>
						<td width="50%">
							<div class="cfMessageThree"><b>#ItemName#</b></div>
							<div class="cfMessage">SKU: #SKU#</div><br><br>
							<div>Description: #ItemDescription#</div><br>
						</td>
					</tr>
				</table>
			</cfloop>	
			</td>
		</tr>
		<tr><td width="90%" colspan="2" height="1"></td></tr>
		<tr><td width="90%" colspan="2" height="1"></td></tr>
		<tr><td width="90%" colspan="2" height="1"></td></tr>
	<cfform action="#CGI.SCRIPT_NAME#?ItemID=#ItemID#" method="post" name="ProductReviewForm">	
		<tr>
			<td class="cfFormLabel" width="10%" valign="top"> 
				<b>Rating:</b><br>
				<cfinput type="radio" name="Rating" value="0" required="yes" message="Rating is Required"><img src="/images/pics/stars/stars_1.gif" align="absmiddle"><br>
				<cfinput type="radio" name="Rating" value="1" ><img src="/images/pics/stars/stars_3.gif" align="absmiddle"><br>
				<cfinput type="radio" name="Rating" value="2" ><img src="/images/pics/stars/stars_5.gif" align="absmiddle"><br>
				<cfinput type="radio" name="Rating" value="3" ><img src="/images/pics/stars/stars_7.gif" align="absmiddle"><br>
				<cfinput type="radio" name="Rating" value="4" ><img src="/images/pics/stars/stars_9.gif" align="absmiddle"><br>
				<cfinput type="radio" name="Rating" value="5" ><img src="/images/pics/stars/stars_11.gif" align="absmiddle">
			</td>
			<td class="cfFormLabel" width="90%" valign="top"> 
				<b>Review:</b><br>
				<textarea name="Review" cols="35" rows="8" class="cfFormField" required="yes" message="Review is Required"></textarea>
			</td>
		</tr>
		<tr><td width="90%" colspan="2" height="1"></td></tr>
		<tr><td width="90%" colspan="2" height="1"></td></tr>
		<tr><td width="90%" colspan="2" height="1"></td></tr>
		<tr><td width="90%" colspan="2" align="center"><input type="submit" name="SubmitReview" value="Submit Review" alt="Submit this review" class="button"></td></tr>
		<input type="hidden" name="ItemID" value="#ItemID#">
	</cfform>
	</table>
</cfif>
</body>
</html>
</cfoutput>