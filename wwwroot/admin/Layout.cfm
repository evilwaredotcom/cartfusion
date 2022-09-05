<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<cfscript>
	if ( IsDefined("Form.SelectSiteID") )
		application.SiteID = Form.SelectSiteID ;
	else if ( IsDefined("form.SiteID") )
		application.SiteID = Form.SiteID ;
	else
		application.SiteID = 1 ;
</cfscript>

<!--- BEGIN: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->
<cfif isDefined('Form.UpdateLayoutInfo') AND IsDefined("Form.SiteID")>
	<cfif IsUserInRole('Administrator')>
		
		<cfscript>				
			Form.DateUpdated = Now() ;
			Form.UpdatedBy = GetAuthUser() ;
		</cfscript>
		
		<cftry>
		<cfupdate datasource="#application.dsn#" tablename="layout" 
			formfields="LayoutID, SiteID,
				ATTRACTCOLOR, ATTRACTDECOR, ATTRACTSIZE, ATTRACTWEIGHT, BUTTONCOLOR, BUTTONDECOR, BUTTONSIZE, BUTTONWEIGHT, 
				DEFAULTCOLOR, DEFAULTDECOR, DEFAULTSIZE, DEFAULTWEIGHT, ERRORMSGCOLOR, ERRORMSGDECOR, ERRORMSGSIZE, ERRORMSGWEIGHT, 
				FORMFIELDCOLOR, FORMFIELDDECOR, FORMFIELDSIZE, FORMFIELDWEIGHT, FORMLABELCOLOR, FORMLABELDECOR, FORMLABELSIZE, FORMLABELWEIGHT, 
				HEADINGCOLOR, HEADINGDECOR, HEADINGFONTFAMILY, HEADINGSIZE, HEADINGWEIGHT, 
				HOMECOLOR, HOMEDECOR, HOMEHEADINGCOLOR, HOMEHEADINGDECOR, HOMEHEADINGSIZE, HOMEHEADINGWEIGHT, HOMESIZE, HOMEWEIGHT, 
				MESSAGECOLOR, MESSAGEDECOR, MESSAGESIZE, MESSAGETHREECOLOR, MESSAGETHREEDECOR, MESSAGETHREESIZE, MESSAGETHREEWEIGHT, 
				MESSAGETWOCOLOR, MESSAGETWODECOR, MESSAGETWOSIZE, MESSAGETWOWEIGHT, MESSAGEWEIGHT, MINICOLOR, MINIDECOR, MINISIZE, MINIWEIGHT, 
				PRIMARYALINKCOLOR, PRIMARYALINKDECOR, PRIMARYALINKWEIGHT, PRIMARYBGCOLOR, PRIMARYBGIMAGE, PRIMARYFONTFAMILY, 
				PRIMARYHLINKCOLOR, PRIMARYHLINKDECOR, PRIMARYHLINKWEIGHT, PRIMARYLINKCOLOR, PRIMARYLINKDECOR, PRIMARYLINKWEIGHT, 
				PRIMARYVLINKCOLOR, PRIMARYVLINKDECOR, PRIMARYVLINKWEIGHT, 
				TABLEHEADINGBGCOLOR, TABLEHEADINGCOLOR, TABLEHEADINGDECOR, TABLEHEADINGSIZE, TABLEHEADINGWEIGHT,
				DATEUPDATED, UPDATEDBY ">
					
			<cfset AdminMsg = 'Site Layout Updated Successfully' >
			
			<cfcatch>
				<cfset AdminMsg = 'FAILED: Site Layout NOT Updated - #cfcatch.Message#' >
			</cfcatch>
		</cftry>
	<cfelse>			
		<SCRIPT LANGUAGE="JavaScript">
			{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
		</SCRIPT>
	</cfif>
</cfif>
<!--- END: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->


<!--- BEGIN: QUERIES ------------------------------------------------------------->
<!--- RE-QUERY layout --->
<cfquery name="layout" datasource="#application.dsn#" cachedwithin="#CreateTimeSpan(-7,0,0,0)#">
	SELECT 	*
	FROM	Layout
	WHERE	SiteID = #application.SiteID#
</cfquery>
<!--- RE-QUERY layout --->
<cfquery name="config" datasource="#application.dsn#" cachedwithin="#CreateTimeSpan(7,0,0,0)#">
	SELECT 	*
	FROM	Config
	WHERE	SiteID = #application.SiteID#
</cfquery>
<cfinvoke component="#application.Queries#" method="getSites" returnvariable="getSites"></cfinvoke>
<cfquery name="getDecorStyles" datasource="#application.dsn#" cachedwithin="#CreateTimeSpan(7,0,0,0)#">
	SELECT	*
	FROM	LayoutStyles
	WHERE	StyleName = 'decor'
</cfquery>
<cfquery name="getWeightStyles" datasource="#application.dsn#" cachedwithin="#CreateTimeSpan(7,0,0,0)#">
	SELECT	*
	FROM	LayoutStyles
	WHERE	StyleName = 'weight'
</cfquery>
<!--- END: QUERIES ------------------------------------------------------------->


<cfscript>
	PageTitle = 'SITE LAYOUT';
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">

<style>
	.popstyle{
		visibility:hidden;
		position:absolute;
		background-color:silver;
		border : 3px ridge Blue;
		padding : 5px;
	}
</style>

<table border="0" cellpadding="7" cellspacing="0" width="100%">
	<tr>
		<cfform action="Layout.cfm" method="post">
			<td width="30%" class="cfAdminDefault">
				SiteID: <cfselect query="getSites" name="SelectSiteID" size="1" value="SiteID" display="SiteName" selected="#application.SiteID#" class="cfAdminDefault" onChange="this.form.submit();" />
			</td>
			<td width="70%" class="cfAdminLink" align="right">
				* You must click the UPDATE CHANGES button for any changes to take effect.
			</td>
		</cfform>
	</tr>
</table>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
<cfoutput query="layout" group="SiteID">
<cfform name="Form" action="Layout.cfm" method="post">
	<tr style="background-color:##65ADF1;">
		<td width="33%" colspan="2" height="20" class="cfAdminHeader1">&nbsp; FONTS, BACKGROUND, & ATTRACT</b></td>
		<td width="1%" rowspan="17" style="background-color:##FFFFFF;">&nbsp;</td>
		<td width="33%" colspan="2" class="cfAdminHeader1">&nbsp; LINKS</td>
		<td width="1%" rowspan="17" style="background-color:##FFFFFF;">&nbsp;</td>
		<td width="33%" colspan="2" class="cfAdminHeader1">&nbsp; FORM LABELS, FIELDS, & BUTTONS</td>
	</tr>
	<tr>
		<td colspan="6" height="5"><img src="images/spacer.gif" width="1" height="5"></td>
	</tr>
	<tr>
		<td width="17%">Primary Font Family:</td>
		<td width="17%"><cfinput type="text" name="PrimaryFontFamily" value="#PrimaryFontFamily#" size="15" class="cfAdminDefault" required="yes"></td>
		<td width="17%">Default Link Color:</td>
		<td width="17%"><cf_ezcolorpicker formname="Form" textfieldname="PrimaryLinkColor" textfielddefault="#PrimaryLinkColor#" hex="no" elementnumber="1" ezColorPickerIcon="yes"></td>
		<td width="16%">Form Label Color:</td>
		<td width="16%"><cf_ezcolorpicker formname="Form" textfieldname="FormLabelColor" textfielddefault="#FormLabelColor#" hex="no" elementnumber="2" ezColorPickerIcon="yes"></td>
	</tr>
	<tr>
		<td>Site BG Color:</td>
		<td><cf_ezcolorpicker formname="Form" textfieldname="PrimaryBGColor" textfielddefault="#PrimaryBGColor#" hex="no" elementnumber="3" ezColorPickerIcon="yes"></td>
		<td>Default Link Weight:</td>
		<td><cfselect query="getWeightStyles" name="PrimaryLinkWeight" value="StyleValue" display="StyleValue" selected="#PrimaryLinkWeight#" class="cfAdminDefault" /></td>
		<td>Form Label Size:</td>
		<td><cfinput type="text" name="FormLabelSize" value="#FormLabelSize#" size="15" class="cfAdminDefault" required="yes"></td>
	</tr>
	<tr>
		<td>Site BG Image:</td>
		<td><cfinput type="text" name="PrimaryBGImage" value="#PrimaryBGImage#" size="15" class="cfAdminDefault" required="no"></td>
		<td>Default Link Decor:</td>
		<td><cfselect query="getDecorStyles" name="PrimaryLinkDecor" value="StyleValue" display="StyleValue" selected="#PrimaryLinkDecor#" class="cfAdminDefault" /></td>	
		<td>Form Label Weight:</td>
		<td><cfselect query="getWeightStyles" name="FormLabelWeight" value="StyleValue" display="StyleValue" selected="#FormLabelWeight#" class="cfAdminDefault" /></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>Form Label Decor:</td>
		<td><cfselect query="getDecorStyles" name="FormLabelDecor" value="StyleValue" display="StyleValue" selected="#FormLabelDecor#" class="cfAdminDefault" /></td>	
	</tr>
	<tr>
		<td>Default Font Color:</td>
		<td><cf_ezcolorpicker formname="Form" textfieldname="DefaultColor" textfielddefault="#DefaultColor#" hex="no" elementnumber="4" ezColorPickerIcon="yes"></td>
		<td>Active Link Color:</td>
		<td><cf_ezcolorpicker formname="Form" textfieldname="PrimaryALinkColor" textfielddefault="#PrimaryALinkColor#" hex="no" elementnumber="5" ezColorPickerIcon="yes"></td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>Default Font Size:</td>
		<td><cfinput type="text" name="DefaultSize" value="#DefaultSize#" size="15" class="cfAdminDefault" required="yes"></td>
		<td>Active Link Weight:</td>
		<td><cfselect query="getWeightStyles" name="PrimaryALinkWeight" value="StyleValue" display="StyleValue" selected="#PrimaryALinkWeight#" class="cfAdminDefault" /></td>
		<td>Form Field Color:</td>
		<td><cf_ezcolorpicker formname="Form" textfieldname="FormFieldColor" textfielddefault="#FormFieldColor#" hex="no" elementnumber="6" ezColorPickerIcon="yes"></td>
	</tr>
	<tr>
		<td>Default Font Weight:</td>
		<td><cfselect query="getWeightStyles" name="DefaultWeight" value="StyleValue" display="StyleValue" selected="#DefaultWeight#" class="cfAdminDefault" /></td>
		<td>Active Link Decor:</td>
		<td><cfselect query="getDecorStyles" name="PrimaryALinkDecor" value="StyleValue" display="StyleValue" selected="#PrimaryALinkDecor#" class="cfAdminDefault" /></td>	
		<td>Form Field Size:</td>
		<td><cfinput type="text" name="FormFieldSize" value="#FormFieldSize#" size="15" class="cfAdminDefault" required="yes"></td>
	</tr>
	<tr>
		<td>Default Font Decor:</td>
		<td><cfselect query="getDecorStyles" name="DefaultDecor" value="StyleValue" display="StyleValue" selected="#DefaultDecor#" class="cfAdminDefault" /></td>	
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>Form Field Weight:</td>
		<td><cfselect query="getWeightStyles" name="FormFieldWeight" value="StyleValue" display="StyleValue" selected="#FormFieldWeight#" class="cfAdminDefault" /></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>Hover Link Color:</td>
		<td><cf_ezcolorpicker formname="Form" textfieldname="PrimaryHLinkColor" textfielddefault="#PrimaryHLinkColor#" hex="no" elementnumber="7" ezColorPickerIcon="yes"></td>
		<td>Form Field Decor:</td>
		<td><cfselect query="getDecorStyles" name="FormFieldDecor" value="StyleValue" display="StyleValue" selected="#FormFieldDecor#" class="cfAdminDefault" /></td>	
	</tr>
	<tr>
		<td>Attract/Price Color:</td>
		<td><cf_ezcolorpicker formname="Form" textfieldname="AttractColor" textfielddefault="#AttractColor#" hex="no" elementnumber="8" ezColorPickerIcon="yes"></td>
		<td>Hover Link Weight:</td>
		<td><cfselect query="getWeightStyles" name="PrimaryHLinkWeight" value="StyleValue" display="StyleValue" selected="#PrimaryHLinkWeight#" class="cfAdminDefault" /></td>	
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>Attract/Price Size:</td>
		<td><cfinput type="text" name="AttractSize" value="#AttractSize#" size="15" class="cfAdminDefault" required="yes"></td>
		<td>Hover Link Decor:</td>
		<td><cfselect query="getDecorStyles" name="PrimaryHLinkDecor" value="StyleValue" display="StyleValue" selected="#PrimaryHLinkDecor#" class="cfAdminDefault" /></td>	
		<td>Button Font Color:</td>
		<td><cf_ezcolorpicker formname="Form" textfieldname="ButtonColor" textfielddefault="#ButtonColor#" hex="no" elementnumber="9" ezColorPickerIcon="yes"></td>
	</tr>
	<tr>
		<td>Attract/Price Weight:</td>
		<td><cfselect query="getWeightStyles" name="AttractWeight" value="StyleValue" display="StyleValue" selected="#AttractWeight#" class="cfAdminDefault" /></td>	
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>Button Font Size:</td>
		<td><cfinput type="text" name="ButtonSize" value="#ButtonSize#" size="15" class="cfAdminDefault" required="yes"></td>
	</tr>
	<tr>
		<td>Attract/Price Decor:</td>
		<td><cfselect query="getDecorStyles" name="AttractDecor" value="StyleValue" display="StyleValue" selected="#AttractDecor#" class="cfAdminDefault" /></td>	
		<td>Visited Link Color:</td>
		<td><cf_ezcolorpicker formname="Form" textfieldname="PrimaryVLinkColor" textfielddefault="#PrimaryVLinkColor#" hex="no" elementnumber="10" ezColorPickerIcon="yes"></td>
		<td>Button Font Weight:</td>
		<td><cfselect query="getWeightStyles" name="ButtonWeight" value="StyleValue" display="StyleValue" selected="#ButtonWeight#" class="cfAdminDefault" /></td>	
	</tr>
	<tr>
		<td></td>
		<td></td>
		<td>Visited Link Weight:</td>
		<td><cfselect query="getWeightStyles" name="PrimaryVLinkWeight" value="StyleValue" display="StyleValue" selected="#PrimaryVLinkWeight#" class="cfAdminDefault" /></td>	
		<td>Button Font Decor:</td>
		<td><cfselect query="getDecorStyles" name="ButtonDecor" value="StyleValue" display="StyleValue" selected="#ButtonDecor#" class="cfAdminDefault" /></td>	
	</tr>
	<tr>
		<td></td>
		<td></td>
		<td>Visited Link Decor:</td>
		<td><cfselect query="getDecorStyles" name="PrimaryVLinkDecor" value="StyleValue" display="StyleValue" selected="#PrimaryVLinkDecor#" class="cfAdminDefault" /></td>	
		<td></td>
		<td></td>
	</tr>
	<tr>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
	</tr>
</table>

<br>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr style="background-color:##65ADF1;">
		<td width="33%" colspan="2" height="20" class="cfAdminHeader1">&nbsp; TABLES & HEADINGS</b></td>
		<td width="1%" rowspan="17" style="background-color:##FFFFFF;">&nbsp;</td>
		<td width="33%" colspan="2" class="cfAdminHeader1">&nbsp; ERRORS, HOMEPAGE, & MINI</td>
		<td width="1%" rowspan="17" style="background-color:##FFFFFF;">&nbsp;</td>
		<td width="33%" colspan="2" class="cfAdminHeader1">&nbsp; MESSAGES/CUSTOM STYLES</td>
	</tr>
	<tr>
		<td colspan="6" height="5"><img src="images/spacer.gif" width="1" height="5"></td>
	</tr>
	<tr>
		<td width="17%">Table Font Color:</td>
		<td width="17%"><cf_ezcolorpicker formname="Form" textfieldname="TableHeadingColor" textfielddefault="#TableHeadingColor#" hex="no" elementnumber="11" ezColorPickerIcon="yes"></td>
		<td width="17%">Error Message Color:</td>
		<td width="17%"><cf_ezcolorpicker formname="Form" textfieldname="ErrorMsgColor" textfielddefault="#ErrorMsgColor#" hex="no" elementnumber="12" ezColorPickerIcon="yes"></td>
		<td width="16%">Message 1 Color:</td>
		<td width="16%"><cf_ezcolorpicker formname="Form" textfieldname="MessageColor" textfielddefault="#MessageColor#" hex="no" elementnumber="13" ezColorPickerIcon="yes"></td>
	</tr>
	<tr>
		<td>Table Font Size:</td>
		<td><cfinput type="text" name="TableHeadingSize" value="#TableHeadingSize#" size="15" class="cfAdminDefault" required="yes"></td>
		<td>Error Message Size:</td>
		<td><cfinput type="text" name="ErrorMsgSize" value="#ErrorMsgSize#" size="15" class="cfAdminDefault" required="yes"></td>
		<td>Message 1 Size:</td>
		<td><cfinput type="text" name="MessageSize" value="#MessageSize#" size="15" class="cfAdminDefault" required="yes"></td>
	</tr>
	<tr>
		<td>Table Font Weight:</td>
		<td><cfselect query="getWeightStyles" name="TableHeadingWeight" value="StyleValue" display="StyleValue" selected="#TableHeadingWeight#" class="cfAdminDefault" /></td>	
		<td>Error Message Weight:</td>
		<td><cfselect query="getWeightStyles" name="ErrorMsgWeight" value="StyleValue" display="StyleValue" selected="#ErrorMsgWeight#" class="cfAdminDefault" /></td>	
		<td>Message 1 Weight:</td>
		<td><cfselect query="getWeightStyles" name="MessageWeight" value="StyleValue" display="StyleValue" selected="#MessageWeight#" class="cfAdminDefault" /></td>	
	</tr>
	<tr>
		<td>Table Font Decor:</td>
		<td><cfselect query="getDecorStyles" name="TableHeadingDecor" value="StyleValue" display="StyleValue" selected="#TableHeadingDecor#" class="cfAdminDefault" /></td>	
		<td>Error Message Decor:</td>
		<td><cfselect query="getDecorStyles" name="ErrorMsgDecor" value="StyleValue" display="StyleValue" selected="#ErrorMsgDecor#" class="cfAdminDefault" /></td>	
		<td>Message 1 Decor:</td>
		<td><cfselect query="getDecorStyles" name="MessageDecor" value="StyleValue" display="StyleValue" selected="#MessageDecor#" class="cfAdminDefault" /></td>	
	</tr>
	<tr>
		<td>Table Heading BG Color:</td>
		<td><cf_ezcolorpicker formname="Form" textfieldname="TableHeadingBGColor" textfielddefault="#TableHeadingBGColor#" hex="no" elementnumber="14" ezColorPickerIcon="yes"></td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>Home Heading Color:</td>
		<td><cf_ezcolorpicker formname="Form" textfieldname="HomeHeadingColor" textfielddefault="#HomeHeadingColor#" hex="no" elementnumber="15" ezColorPickerIcon="yes"></td>
		<td>Message 2 Color:</td>
		<td><cf_ezcolorpicker formname="Form" textfieldname="MessageTwoColor" textfielddefault="#MessageTwoColor#" hex="no" elementnumber="16" ezColorPickerIcon="yes"></td>
	</tr>
	<tr>
		<td>Heading Font Family:</td>
		<td><cfinput type="text" name="HeadingFontFamily" value="#HeadingFontFamily#" size="15" class="cfAdminDefault" required="yes"></td>
		<td>Home Heading Size:</td>
		<td><cfinput type="text" name="HomeHeadingSize" value="#HomeHeadingSize#" size="15" class="cfAdminDefault" required="yes"></td>
		<td>Message 2 Size:</td>
		<td><cfinput type="text" name="MessageTwoSize" value="#MessageTwoSize#" size="15" class="cfAdminDefault" required="yes"></td>
	</tr>
	<tr>
		<td>Heading Font Color:</td>
		<td><cf_ezcolorpicker formname="Form" textfieldname="HeadingColor" textfielddefault="#HeadingColor#" hex="no" elementnumber="17" ezColorPickerIcon="yes"></td>
		<td>Home Heading Weight:</td>
		<td><cfselect query="getWeightStyles" name="HomeHeadingWeight" value="StyleValue" display="StyleValue" selected="#HomeHeadingWeight#" class="cfAdminDefault" /></td>	
		<td>Message 2 Weight:</td>
		<td><cfselect query="getWeightStyles" name="MessageTwoWeight" value="StyleValue" display="StyleValue" selected="#MessageTwoWeight#" class="cfAdminDefault" /></td>
	</tr>
	<tr>
		<td>Heading Font Size:</td>
		<td><cfinput type="text" name="HeadingSize" value="#HeadingSize#" size="15" class="cfAdminDefault" required="yes"></td>
		<td>Home Heading Decor:</td>
		<td><cfselect query="getDecorStyles" name="HomeHeadingDecor" value="StyleValue" display="StyleValue" selected="#HomeHeadingDecor#" class="cfAdminDefault" /></td>	
		<td>Message 2 Decor:</td>
		<td><cfselect query="getDecorStyles" name="MessageTwoDecor" value="StyleValue" display="StyleValue" selected="#MessageTwoDecor#" class="cfAdminDefault" /></td>	
	</tr>
	<tr>
		<td>Heading Font Weight:</td>
		<td><cfselect query="getWeightStyles" name="HeadingWeight" value="StyleValue" display="StyleValue" selected="#HeadingWeight#" class="cfAdminDefault" /></td>	
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>Heading Font Decor:</td>
		<td><cfselect query="getDecorStyles" name="HeadingDecor" value="StyleValue" display="StyleValue" selected="#HeadingDecor#" class="cfAdminDefault" /></td>	
		<td>Home Font Color:</td>
		<td><cf_ezcolorpicker formname="Form" textfieldname="HomeColor" textfielddefault="#HomeColor#" hex="no" elementnumber="18" ezColorPickerIcon="yes"></td>
		<td>Message 3 Color:</td>
		<td><cf_ezcolorpicker formname="Form" textfieldname="MessageThreeColor" textfielddefault="#MessageThreeColor#" hex="no" elementnumber="19" ezColorPickerIcon="yes"></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>Home Font Size:</td>
		<td><cfinput type="text" name="HomeSize" value="#HomeSize#" size="15" class="cfAdminDefault" required="yes"></td>
		<td>Message 3 Size:</td>
		<td><cfinput type="text" name="MessageThreeSize" value="#MessageThreeSize#" size="15" class="cfAdminDefault" required="yes"></td>
	</tr>
	<tr>
		<td>Mini Font Color:</td>
		<td><cf_ezcolorpicker formname="Form" textfieldname="MiniColor" textfielddefault="#MiniColor#" hex="no" elementnumber="20" ezColorPickerIcon="yes"></td>
		<td>Home Font Weight:</td>
		<td><cfselect query="getWeightStyles" name="HomeWeight" value="StyleValue" display="StyleValue" selected="#HomeWeight#" class="cfAdminDefault" /></td>	
		<td>Message 3 Weight:</td>
		<td><cfselect query="getWeightStyles" name="MessageThreeWeight" value="StyleValue" display="StyleValue" selected="#MessageThreeWeight#" class="cfAdminDefault" /></td>	
	</tr>
	<tr>
		<td>Mini Size:</td>
		<td><cfinput type="text" name="MiniSize" value="#MiniSize#" size="15" class="cfAdminDefault" required="yes"></td>
		<td>Home Font Decor:</td>
		<td><cfselect query="getDecorStyles" name="HomeDecor" value="StyleValue" display="StyleValue" selected="#HomeDecor#" class="cfAdminDefault" /></td>
		<td>Message 3 Decor:</td>
		<td><cfselect query="getDecorStyles" name="MessageThreeDecor" value="StyleValue" display="StyleValue" selected="#MessageThreeDecor#" class="cfAdminDefault" /></td>	
	</tr>
	<tr>
		<td>Mini Weight:</td>
		<td><cfselect query="getWeightStyles" name="MiniWeight" value="StyleValue" display="StyleValue" selected="#MiniWeight#" class="cfAdminDefault" /></td>	
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>Mini Decor:</td>
		<td><cfselect query="getDecorStyles" name="MiniDecor" value="StyleValue" display="StyleValue" selected="#MiniDecor#" class="cfAdminDefault" /></td>	
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
</table>

<br>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr style="background-color:##65ADF1;">
		<td colspan="2" width="100%" height="20" class="cfAdminHeader1">&nbsp; AUDIT TRAIL</b></td>
	</tr>
	<tr>
		<td colspan="2" height="5"><img src="images/spacer.gif" width="1" height="5"></td>
	</tr>
	<tr>	
		<td width="15%" height="20">Last Updated:</td>
		<td width="85%">#DateFormat(DateUpdated, 'mmmm dd yyyy')# @ #TimeFormat(DateUpdated, 'hh:mmtt')#</td>	
	</tr>
	<tr>	
		<td height="20">Last Updated By:</td>
		<td>#UCASE(GetAuthUser())#</td>	
	</tr>
	<tr>
		<td colspan="2" height="5"><img src="images/spacer.gif" width="1" height="5"></td>
	</tr>
</table>

<br>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr style="background-color:##F27028;">
		<td colspan="4" height="20" class="cfAdminHeader3" align="center">
			UPDATE ABOVE INFORMATION
		</td>
	</tr>
	<tr>
		<td colspan="4" height="10"><img src="images/spacer.gif" width="1" height="10"></td>
	</tr>
	<tr>
		<td colspan="4" align="center">
			<input type="submit" name="UpdateLayoutInfo" value="UPDATE CHANGES" alt="Update Site Layout Changes" class="cfAdminButton"
				onClick="return confirm('Are you sure you want to UPDATE LAYOUT with the changes you have made?')">
		</td>
	</tr>
</table>
<br>
<input type="hidden" name="SiteID" value="#SiteID#">
<input type="hidden" name="LayoutID" value="#SiteID#">
</cfform>
</cfoutput>

<cfinclude template="LayoutAdminFooter.cfm">