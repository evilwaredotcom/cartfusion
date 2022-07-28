<html>
<head>
	<title><cfoutput>#config.StoreNameShort#</cfoutput> Product Review</title>
	<cfif FindNoCase("MSIE", "#CGI.HTTP_USER_AGENT#")><cfinclude template="../css.cfm">
	<cfelse><cfinclude template="../css.cfm">
	</cfif>
</head>

<body style="BACKGROUND-COLOR: <cfoutput>#layout.PrimaryBGColor#</cfoutput>">

<cfif isDefined('URL.ItemID')>
	
	<cfinvoke component="#application.Queries#" method="getProductReviews" returnvariable="getProductReviews">
		<cfinvokeargument name="ItemID" value="#ItemID#">
	</cfinvoke>
	<cfinvoke component="#application.Queries#" method="getProduct" returnvariable="getProduct">
		<cfinvokeargument name="ItemID" value="#ItemID#">
	</cfinvoke>
	
	<cfif getProductReviews.RecordCount NEQ 0>
		<table border=0 style="border-color:<cfoutput>#layout.TableHeadingBGColor#</cfoutput>;" cellpadding="7" cellspacing="0" width="100%">
			<tr>
				<td colspan="4">
				<cfoutput query="getProduct">
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td width="50%">
								<cfif getProduct.Image IS ''>
									<cfif  FileExists(#config.IU_VirtualPathDIR# & '\' & #ImageDir# & '\' & #SKU# & '.jpg')>
										<img src="../images/#ImageDir#/#SKU#.jpg" border="0" align="middle" alt="#ItemName#"></a>&nbsp;&nbsp;
									<cfelse>
										<img src="../images/image-EMPTY.gif" border="0" align="middle" alt="#ItemName#"></a>&nbsp;&nbsp;
									</cfif>
								<cfelse>
									<cfif FileExists(#config.IU_VirtualPathDIR# & '\' & #ImageDir# & '\' & #Image#)>
										<img src="../images/#ImageDir#/#ImageSmall#" border="0" align="middle" alt="#ItemName#"></a>&nbsp;&nbsp;
									<cfelse>								
										<img src="../images/image-EMPTY.gif" border="0" align="middle" alt="#ItemName#"></a>&nbsp;&nbsp;
									</cfif>
								</cfif>
							</td>
							<td width="50%">
								<div class="cfMessageThree"><b>#ItemName#</b></div>
								<div class="cfMessage">SKU: #SKU#</div><br>
							</td>
						</tr>
					</table>
				</cfoutput>	
				</td>
			</tr>
			<tr>
				<td class="cfDefault" width="10%" valign="middle"> 
					<b>Avg. Rating:</b><br>
					<cfif getProductReviews.AvgRating EQ 0 >
						<img src="../images/pics/stars/stars_1.gif" align="absmiddle">
					<cfelseif getProductReviews.AvgRating LTE 0.5 >
						<img src="../images/pics/stars/stars_2.gif" align="absmiddle">
					<cfelseif getProductReviews.AvgRating LTE 1 >
						<img src="../images/pics/stars/stars_3.gif" align="absmiddle">
					<cfelseif getProductReviews.AvgRating LTE 1.5 >
						<img src="../images/pics/stars/stars_4.gif" align="absmiddle">	
					<cfelseif getProductReviews.AvgRating LTE 2 >
						<img src="../images/pics/stars/stars_5.gif" align="absmiddle">
					<cfelseif getProductReviews.AvgRating LTE 2.5 >
						<img src="../images/pics/stars/stars_6.gif" align="absmiddle">
					<cfelseif getProductReviews.AvgRating LTE 3 >
						<img src="../images/pics/stars/stars_7.gif" align="absmiddle">
					<cfelseif getProductReviews.AvgRating LTE 3.5 >
						<img src="../images/pics/stars/stars_8.gif" align="absmiddle">
					<cfelseif getProductReviews.AvgRating LTE 4 >
						<img src="../images/pics/stars/stars_9.gif" align="absmiddle">
					<cfelseif getProductReviews.AvgRating LTE 4.5 >
						<img src="../images/pics/stars/stars_10.gif" align="absmiddle">
					<cfelseif getProductReviews.AvgRating LTE 5 >
						<img src="../images/pics/stars/stars_11.gif" align="absmiddle">
					</cfif>
				</td>
				<td width="70%" nowrap valign="bottom"  colspan="2">
					
				</td>
				<td class="cfDefault" width="20%" valign="middle">
					
				</td>
			</tr>
			<tr><td width="90%" colspan="4" height="1" bgcolor="<cfoutput>#layout.TableHeadingBGColor#</cfoutput>"></td></tr>
			<tr><td width="90%" colspan="4" height="1" bgcolor="<cfoutput>#layout.PrimaryBGColor#</cfoutput>"></td></tr>
			<tr><td width="90%" colspan="4" height="1" bgcolor="<cfoutput>#layout.TableHeadingBGColor#</cfoutput>"></td></tr>
		<cfoutput query="getProductReviews">
			<tr>
				<td class="cfDefault" width="10%" valign="top"> 
					<b>Rating:</b><br>
					<cfif Rating EQ 0 >
						<img src="../images/pics/stars/stars_1.gif" align="absmiddle">
					<cfelseif Rating LTE 0.5 >
						<img src="../images/pics/stars/stars_2.gif" align="absmiddle">
					<cfelseif Rating LTE 1 >
						<img src="../images/pics/stars/stars_3.gif" align="absmiddle">
					<cfelseif Rating LTE 1.5 >
						<img src="../images/pics/stars/stars_4.gif" align="absmiddle">	
					<cfelseif Rating LTE 2 >
						<img src="../images/pics/stars/stars_5.gif" align="absmiddle">
					<cfelseif Rating LTE 2.5 >
						<img src="../images/pics/stars/stars_6.gif" align="absmiddle">
					<cfelseif Rating LTE 3 >
						<img src="../images/pics/stars/stars_7.gif" align="absmiddle">
					<cfelseif Rating LTE 3.5 >
						<img src="../images/pics/stars/stars_8.gif" align="absmiddle">
					<cfelseif Rating LTE 4 >
						<img src="../images/pics/stars/stars_9.gif" align="absmiddle">
					<cfelseif Rating LTE 4.5 >
						<img src="../images/pics/stars/stars_10.gif" align="absmiddle">
					<cfelseif Rating LTE 5 >
						<img src="../images/pics/stars/stars_11.gif" align="absmiddle">
					</cfif>
				</td>
				<td class="cfDefault" width="90%" valign="top" colspan="3"> 
					<b><u>Review:</u></b>&nbsp; "#Review#"
				</td>
			</tr>
			<tr><td width="90%" colspan="4" height="1" bgcolor="#layout.TableHeadingBGColor#"></td></tr>
		</cfoutput>
		</table>
	<cfelse>
		<table border=0 style="border-color:<cfoutput>#layout.TableHeadingBGColor#</cfoutput>;" cellpadding="7" cellspacing="0">
			<tr>
				<td class="cfErrorMsg">There are no reviews for this product</td>
			</tr>
		</table>	
	</cfif><!--- getProductReviews.RecordCount NEQ 0 --->
</cfif>
</body>
</html>
