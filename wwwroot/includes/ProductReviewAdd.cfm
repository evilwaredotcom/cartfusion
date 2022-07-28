<cfif isDefined('SubmitReview')>
	<cftry>
		
		<cfinvoke component="#application.Queries#" method="addProductReview" returnvariable="addProductReview">
			<cfinvokeargument name="ItemID" value="#Form.ItemID#">
			<cfinvokeargument name="Rating" value="#Form.Rating#">
			<cfinvokeargument name="Review" value="#Form.Review#">
		</cfinvoke>
		
		<script language="javascript">
			window.close();
		</script>
		
		<cfcatch>
			ERROR: Please try again later
		</cfcatch>
	</cftry>
</cfif>
<html>
<head>
	<title><cfoutput>#config.StoreNameShort#</cfoutput> Add Product Review</title>
	<cfif FindNoCase("MSIE", "#CGI.HTTP_USER_AGENT#")><cfinclude template="../css.cfm">
	<cfelse><cfinclude template="../css.cfm">
	</cfif>
</head>

<body style="BACKGROUND-COLOR: <cfoutput>#layout.PrimaryBGColor#</cfoutput>">

<cfif isDefined('URL.ItemID')>
	
	<cfinvoke component="#application.Queries#" method="getProduct" returnvariable="getProduct">
		<cfinvokeargument name="ItemID" value="#ItemID#">
	</cfinvoke>
	
	<table border=0 style="border-color:<cfoutput>#layout.TableHeadingBGColor#</cfoutput>;" cellpadding="7" cellspacing="0" width="100%">
		<tr>
			<td colspan="2" >
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
		<tr><td width="90%" colspan="2" height="1" bgcolor="<cfoutput>#layout.TableHeadingBGColor#</cfoutput>"></td></tr>
		<tr><td width="90%" colspan="2" height="1" bgcolor="<cfoutput>#layout.PrimaryBGColor#</cfoutput>"></td></tr>
		<tr><td width="90%" colspan="2" height="1" bgcolor="<cfoutput>#layout.TableHeadingBGColor#</cfoutput>"></td></tr>
	<cfform action="#CGI.SCRIPT_NAME#?ItemID=#ItemID#" method="post" name="ProductReviewForm">	
		<tr>
			<td class="cfFormLabel" width="10%" valign="top"> 
				<b>Rating:</b><br>
				<cfinput type="radio" name="Rating" value="0" required="yes" message="Rating is Required"><img src="../images/pics/stars/stars_1.gif" align="absmiddle"><br>
				<cfinput type="radio" name="Rating" value="1" ><img src="../images/pics/stars/stars_3.gif" align="absmiddle"><br>
				<cfinput type="radio" name="Rating" value="2" ><img src="../images/pics/stars/stars_5.gif" align="absmiddle"><br>
				<cfinput type="radio" name="Rating" value="3" ><img src="../images/pics/stars/stars_7.gif" align="absmiddle"><br>
				<cfinput type="radio" name="Rating" value="4" ><img src="../images/pics/stars/stars_9.gif" align="absmiddle"><br>
				<cfinput type="radio" name="Rating" value="5" ><img src="../images/pics/stars/stars_11.gif" align="absmiddle">
			</td>
			<td class="cfFormLabel" width="90%" valign="top"> 
				<b>Review:</b><br>
				<cftextarea name="Review" cols="55" rows="8" class="cfFormField" required="yes" message="Review is Required"></cftextarea>
			</td>
		</tr>
		<tr><td width="90%" colspan="2" height="1" bgcolor="<cfoutput>#layout.TableHeadingBGColor#</cfoutput>"></td></tr>
		<tr><td width="90%" colspan="2" height="1" bgcolor="<cfoutput>#layout.PrimaryBGColor#</cfoutput>"></td></tr>
		<tr><td width="90%" colspan="2" height="1" bgcolor="<cfoutput>#layout.TableHeadingBGColor#</cfoutput>"></td></tr>
		<tr><td width="90%" colspan="2" align="center"><input type="submit" name="SubmitReview" value="Submit Review" alt="Submit this review" class="cfButton"></td></tr>
		<input type="hidden" name="ItemID" value="<cfoutput>#ItemID#</cfoutput>">
	</cfform>
	</table>
</cfif>
</body>
</html>
