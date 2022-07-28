<!--- MAKE SURE ITEMID AND EMAIL ADDRESS ARE POSTED FROM FORM --->
<cfif isDefined('ItemID') and ItemID neq '' >
	<!--- GET ITEM FROM POSTED FORM --->
	<cfscript>
		getProduct = application.Common.getProductDetail(ItemID=ItemID);
	</cfscript>
	
	<!--- <cfinvoke component="#application.Common#" method="getProductDetail" returnvariable="getProduct" ItemID="#ItemID#"> --->
		
	<cfif structKeyExists(form, 'YourEmail') AND structKeyExists(form, 'RecipientEmail') AND form.YourEmail neq '' and form.RecipientEmail neq '' >
	
		<!--- CREATE EMAIL USING EMAIL ADDRESS FROM POSTED FORM AND ITEM RETRIEVED --->
		<cfmail query="getProduct" group="SKU" to="#form.RecipientEmail#" from="#form.YourEmail#" subject="Check out #getProduct.ItemName# at #application.siteConfig.data.DomainName#" type="html">
			<html>
			<head></head>
			
			<body style="margin:0px;">
			<table width="700" cellpadding="3" cellspacing="0" border="0">
				<tr>
					<td><a href="#application.siteConfig.data.RootURL#/ProductDetail.cfm?ItemID=#ItemID#"><img src="#application.RootURL#/images/image-CompanyLogo.gif" border="0" alt='#application.siteConfig.data.CompanyName#'></a></td>
					<td align="right"><a href="#application.RootURL#/ProductDetail.cfm?ItemID=#ItemID#"><img src="#application.RootURL#/images/image-TellAFriend.gif" border="0" alt='#application.siteConfig.data.CompanyName#'></a></td>
				</tr>
				<tr>
					<td colspan="2" height="7"><img src="#application.siteConfig.data.RootURL#/images/image-spacer.gif" height="7" width="1"></td>
				</tr>
				<tr>
					<td class="cfMessageTwo" align="center">
						<br>
						<!--- CARTFUSION 4.6 - CART CFC --->
						<cfscript>
							if ( TRIM(session.CustomerArray[28]) NEQ '' ) {
								UserID = session.CustomerArray[28] ;
							} else {
								UserID = 1 ;
							}
                            UseThisPrice = application.Cart.getItemPrice(
								UserID=UserID,
								SiteID=application.siteConfig.data.SiteID,
								ItemID=ItemID,
								SessionID=SessionID,
								OptionName1=OptionName1,
								OptionName2=OptionName2,
								OptionName3=OptionName3);
                        </cfscript>
						
						<!--- ITEM IMAGE --->
						<a href="#application.siteConfig.data.RootURL#/ProductDetail.cfm?ItemID=#ItemID#">
						<cfif getProduct.Image IS ''>
							<cfif FileExists(#application.siteConfig.data.IU_VirtualPathDIR# & '\' & #ImageDir# & '\' & #SKU# & '.jpg')>
								<img src="#application.siteConfig.data.RootURL#/images/#ImageDir#/#SKU#.jpg" id="img1" border="0" align="middle" alt='#ItemName#'>
							<cfelse>
								<img src="#application.siteConfig.data.RootURL#/images/image-EMPTY.gif" id="img1" border="0" align="middle" alt='#ItemName#'>
							</cfif>
						<cfelse>
							<cfif FileExists(#application.siteConfig.data.IU_VirtualPathDIR# & '\' & #ImageDir# & '\' & #Image#)>
								<img src="#application.siteConfig.data.RootURL#/images/#ImageDir#/#Image#" id="img1" border="0" align="middle" alt='#ItemName#'>
							<cfelse>								
								<img src="#application.siteConfig.data.RootURL#/images/image-EMPTY.gif" id="img1" border="0" align="middle" alt='#ItemName#'>
							</cfif>
						</cfif>
						</a>
						<br>
					</td>
					<td class="cfDefault" valign="top">
						<br>
						<font class="cfMessageTwo"><b>Check this out...</b></font>
						<br><hr size="1" width="100%" class="cfMessageTwo"><br>
						#form.Message#
						<br><br>
						<b>#ItemName#</b>
						<br>						
						Click here: <a href="#application.siteConfig.data.RootURL#/ProductDetail.cfm?ItemID=#ItemID#">#application.siteConfig.data.RootURL#/ProductDetail.cfm?ItemID=#ItemID#</a>
						<br><br>
						- #form.YourName#
						<br><br>
					</td>
				</tr>
				<tr>
					<td colspan="2" height="7"><img src="#application.siteConfig.data.RootURL#/images/image-spacer.gif" height="7" width="1"></td>
				</tr>
			</table>
			</body>
			</html>
		</cfmail>
		
		<div class="cfErrorMsg" align="center">
			<b>THANK YOU!</b> We have successfully emailed your friend about this product.
		</div>
	
		<script language="javascript">
			window.close();
		</script>
		<cfabort>

	</cfif>

	<html>
	<head>
		<title>TELL A FRIEND</title>
		<!--- <cfinclude template="css.cfm"> --->
	</head>
	
	<body>
	
	<CFOUTPUT QUERY="getProduct" GROUP="SKU">
	<table width="700" cellpadding="3" cellspacing="0" border="0" align="center">
	<cfform name="TellAFriend" action="TellAFriend.cfm" method="post" preservedata="yes">
		<tr>
			<td width="280" class="cfMessageTwo" rowspan="100" align="center">
				<!--- CARTFUSION 4.6 - CART CFC --->
				<cfscript>
					if ( TRIM(session.CustomerArray[28]) NEQ '' ) {
						UserID = session.CustomerArray[28] ;
					} else {
						UserID = 1 ;
					}
                    UseThisPrice = application.Cart.getItemPrice(
                                        UserID=UserID,
                                        SiteID=application.siteConfig.data.SiteID,
                                        ItemID=ItemID,
                                        SessionID=SessionID,
                                        OptionName1=OptionName1,
                                        OptionName2=OptionName2,
                                        OptionName3=OptionName3
                                        ) ;
                </cfscript>
				
				<!--- ITEM IMAGE --->
				<cfif getProduct.Image IS ''>
					<cfif FileExists(#application.siteConfig.data.IU_VirtualPathDIR# & '\' & #ImageDir# & '\' & #SKU# & '.jpg')>
						<img src="images/#ImageDir#/#SKU#.jpg" id="img1" border="0" align="middle" alt='#ItemName#'>
					<cfelse>
						<img src="images/image-EMPTY.gif" id="img1" border="0" align="middle" alt='#ItemName#'>
					</cfif>
				<cfelse>
					<cfif FileExists(#application.siteConfig.data.IU_VirtualPathDIR# & '\' & #ImageDir# & '\' & #Image#)>
						<img src="images/#ImageDir#/#Image#" id="img1" border="0" align="middle" alt='#ItemName#'>
					<cfelse>								
						<img src="images/image-EMPTY.gif" id="img1" border="0" align="middle" alt='#ItemName#'>
					</cfif>
				</cfif>
				
				<br><br>
				
				<b>#ItemName#</b>
			</td>
			<td class="cfFormLabel" colspan="2">
				<font class="cfMessageTwo"><b>E-mail a Friend</b></font>
				<br><hr size="1" width="100%" class="cfMessageTwo"><br>
				Tell a friend about this product on #application.siteConfig.data.DomainName#:
				<br><br>
				<a href="#application.siteConfig.data.RootURL#/ProductDetail.cfm?ItemID=#ItemID#">#application.siteConfig.data.RootURL#/ProductDetail.cfm?ItemID=#ItemID#</a>
				<br><br>
				Simply fill in the fields below and we'll send an email link to this product along with your personal message.
				<br><br>
			</td>
		</tr>
		<tr>
			<td class="cfFormLabel" nowrap="nowrap">
				<b>Your Name:</b>
			</td>
			<td class="cfFormLabel">
				<cfinput type="text" name="YourName" size="40" class="cfFormField" required="yes" message="Your name is required.">
			</td>
		</tr>
		<tr>
			<td class="cfFormLabel" nowrap="nowrap">
				<b>Your Email Address:</b>
			</td>
			<td class="cfFormLabel">
				<cfinput type="text" name="YourEmail" size="40" class="cfFormField" required="yes" message="Your email address is required." validate="email">
			</td>
		</tr>
		<tr>
			<td class="cfFormLabel" nowrap="nowrap">
				<b>Recipient's Email Address:</b>
			</td>
			<td class="cfFormLabel">
				<cfinput type="text" name="RecipientEmail" size="40" class="cfFormField" required="yes" message="Recipient's email address is required." validate="email">
			</td>
		</tr>
		<tr>
			<td class="cfFormLabel" nowrap="nowrap">
				<b>Add a personal message:</b>
			</td>
			<td class="cfFormLabel">
				<cftextarea name="Message" style="width:250px; height:100px;" width="250" height="100" class="cfFormField">Hey! I thought you might be interested in this product at #application.siteConfig.data.RootURL#, they've got all sorts of stuff like this. You should check them out.</cftextarea>
			</td>
		</tr>
		<tr>
			<td class="cfFormLabel" colspan="2" align="center">
				<cfinput type="submit" name="TellAFriend" value="Email a Friend" class="cfButton">
				<input type="hidden" name="ItemID" value="#ItemID#">
			</td>
		</tr>
		<tr>
			<td class="cfFormLabel" colspan="2">
				<br>
				<div align="center"><b>Don't worry!</b></div>
				These email addresses will be used to send a link on your behalf.
				This information is not saved, and you are not subscribing to any mailings.
			</td>
		</tr>
	</cfform>	
	</table>
	</cfoutput>
	</body>
	</html>

<cfelse>
	<div class="cfErrorMsg" align="center">TELL-A-FRIEND FEATURE FAILED:</b> An item and/or email address have not been provided.</div>
</cfif>