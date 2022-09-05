<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<!--- BEGIN: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->
<cfif isDefined('form.UpdateShipPrice') AND IsDefined("form.SMID") >
	<cfif isUserInRole('Administrator')>
		<cfscript>
			Form.SiteID = 1 ;
			Form.Allow = 1 ;
			Form.ShipWeightLo = 0 ;
			Form.ShipWeightHi = 0 ;
			if ( isDefined('Form.International') )
				Form.International = 1 ;
			else
				Form.International = 0 ;
			Form.ShippingCompany = 'Custom' ;
			Form.ShipPriceLo = Replace(Form.ShipPriceLo, "," , "", "ALL") ;
			Form.ShipPriceHi = Replace(Form.ShipPriceHi, "," , "", "ALL") ;
			Form.ShipPrice = Replace(Form.ShipPrice, "," , "", "ALL") ;
		</cfscript>
		<cfupdate datasource="#application.dsn#" tablename="ShippingMethods" 
			formfields="SMID, SiteID, ShippingCode, ShippingMessage, Allow, ShippingCompany, ShipPrice, ShipPriceLo, ShipPriceHi, International">
		<cfset AdminMsg = 'Rate Updated Successfully' >
	<cfelse>
		<SCRIPT LANGUAGE="JavaScript">
			{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
		</SCRIPT>
	</cfif>
</cfif>

<cfif isDefined('form.AddShipPrice')>
	<cfif isUserInRole('Administrator')>
		<cfquery name="getLastSMID" datasource="#application.dsn#">
			SELECT	MAX(SMID) AS LastSMID
			FROM	ShippingMethods
		</cfquery>
		<cfscript>
			if ( getLastSMID.RecordCount GT 0 AND getLastSMID.LastSMID GT 0 )
				Form.SMID = getLastSMID.LastSMID + 1 ;
			else
				Form.SMID = 1 ;
			Form.SiteID = 1 ;
			Form.Allow = 1 ;
			Form.ShipWeightLo = 0 ;
			Form.ShipWeightHi = 0 ;
			if ( isDefined('Form.International') )
				Form.International = 1 ;
			else
				Form.International = 0 ;
			Form.ShippingCompany = 'Custom' ;
			Form.ShipPriceLo = Replace(Form.ShipPriceLo, "," , "", "ALL") ;
			Form.ShipPriceHi = Replace(Form.ShipPriceHi, "," , "", "ALL") ;
			Form.ShipPrice = Replace(Form.ShipPrice, "," , "", "ALL") ;
		</cfscript>
		<cfinsert datasource="#application.dsn#" tablename="ShippingMethods" 
			formfields="SMID, SiteID, ShippingCode, ShippingMessage, Allow, ShippingCompany, ShipPrice, ShipPriceLo, ShipPriceHi, International">
		<cfset AdminMsg = 'Rate Added Successfully' >
	<cfelse>
		<SCRIPT LANGUAGE="JavaScript">
			{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
		</SCRIPT>
	</cfif>
</cfif>

<cfif isDefined('form.DeleteShipPrice') AND IsDefined("form.SMID") >
	<cfif isUserInRole('Administrator')>
		<cfquery name="deleteAltStyle" datasource="#application.dsn#">
			DELETE
			FROM 	ShippingMethods
			WHERE	SMID = #form.SMID#
		</cfquery>			
		<cfset AdminMsg = 'Rate Deleted Successfully' >
	<cfelse>
		<SCRIPT LANGUAGE="JavaScript">
			{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
		</SCRIPT>
	</cfif>
</cfif>
<!--- END: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<cfquery name="getShippingPricesCust" datasource="#application.dsn#" cachedwithin="#CreateTimeSpan(-7,0,0,0)#">
	SELECT	*
	FROM	ShippingMethods
	WHERE	ShippingCompany = 'Custom'
	AND		(ShipPriceLo > 0 OR ShipPriceHi > 0)
	ORDER BY SMID
</cfquery>

<!--- HEADER --->
<cfscript>
	PageTitle = 'CUSTOM SHIPPING METHODS BY ORDER TOTAL';
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">

<!--- SHIPPING PRICE LEVELS --->
<table width="100%" border="0" cellpadding="0" cellspacing="0">	
	<tr style="background-color:##65ADF1;">
		<td width="5%"  class="cfAdminHeader1" height="20" align="center"></td><!--- DELETE/ADD --->
		<td width="15%" class="cfAdminHeader1">Shipping Code</td>
		<td width="20%" class="cfAdminHeader1">Method/Company</td>
		<td width="15%" class="cfAdminHeader1">From Price</td>
		<td width="15%" class="cfAdminHeader1">To Price</td>
		<td width="15%" class="cfAdminHeader1">Shipping Rate</td>
		<td width="10%" class="cfAdminHeader1">Is International?</td>
		<td width="5%"  class="cfAdminHeader1">&nbsp;</td>
	</tr>
	<tr>
		<td height="5" colspan="7"></td>
	</tr>
	<cfoutput QUERY="getShippingPricesCust">
	<cfform action="Config-ShipByCustomP.cfm" method="post">
	<tr>
		<td align="center">
			<input type="submit" name="UpdateShipPrice" value="UPDATE" alt="Update Shipping Price" class="cfAdminButton">&nbsp;&nbsp;
		</td>
		<td><cfinput type="text" name="ShippingCode" value="#ShippingCode#" size="12" class="cfAdminDefault" required="yes" message="Please enter a unique Shipping Code."></td>
		<td><cfinput type="text" name="ShippingMessage" value="#ShippingMessage#" size="25" class="cfAdminDefault" required="yes" message="Please enter a Shipping Method/Company."></td>
		<td>$<cfinput type="text" name="ShipPriceLo" value="#DecimalFormat(ShipPriceLo)#" size="12" class="cfAdminDefault" required="yes" message="Please enter a price level starting price."></td>
		<td>$<cfinput type="text" name="ShipPriceHi" value="#DecimalFormat(ShipPriceHi)#" size="12" class="cfAdminDefault" required="yes" message="Please enter a price level ending price."></td>
		<td>$<cfinput type="text" name="ShipPrice" value="#DecimalFormat(ShipPrice)#" size="12" class="cfAdminDefault" required="yes" message="Please enter a shipping rate for this price level."></td>
		<td><input type="checkbox" name="International" <cfif International EQ 1>checked</cfif> ></td>
		<td>
			<input type="submit" name="DeleteShipPrice" value="DELETE" alt="Delete Shipping Price" class="cfAdminButton"
				onClick="return confirm('Are you sure you want to DELETE THIS SHIPPING RATE LEVEL?')">
		</td>
	</tr>
	<tr>
		<td height="2" colspan="7"></td>
	</tr>
	<tr style="background-color:##CCCCCC;">
		<td height="1" colspan="7"></td>
	</tr>
	<tr>
		<td height="2" colspan="7"></td>
	</tr>
		<input type="hidden" name="SMID" value="#SMID#">
	</cfform>
	</cfoutput>

	<!--- ADD NEW RATE LEVEL --->
	<cfform action="Config-ShipByCustomP.cfm" method="post">
	<tr>
		<td align="center">
			<input type="submit" name="AddShipPrice" value="ADD" alt="Add Shipping Price" class="cfAdminButton">
		</td>
		<td><cfinput type="text" name="ShippingCode" size="12" class="cfAdminDefault" required="yes" message="Please enter a unique Shipping Code."></td>
		<td><cfinput type="text" name="ShippingMessage" size="25" class="cfAdminDefault" required="yes" message="Please enter a Shipping Method/Company."></td>
		<td>$ <cfinput type="text" name="ShipPriceLo" size="12" class="cfAdminDefault" required="yes" message="Please enter a price level starting price."></td>
		<td>$ <cfinput type="text" name="ShipPriceHi" size="12" class="cfAdminDefault" required="yes" message="Please enter a price level ending price."></td>
		<td>$ <cfinput type="text" name="ShipPrice" size="12" class="cfAdminDefault" required="yes" message="Please enter a shipping rate for this price level."></td>
		<td><input type="checkbox" name="International"></td>
		<td>&nbsp;</td>			
	</tr>
	</cfform>
	<tr>
		<td colspan="7" height="20"><img src="images/spacer.gif" width="1" height="20"></td>
	</tr>
	<tr>
		<td colspan="7" align="center">
			<input type="button" name="GoBack" value="<< GO BACK" alt="Go Back To Configuration Screen" class="cfAdminButton"
				onClick="document.location.href='Config-Shipping.cfm'">
			<input type="button" name="ReturnHome" value="RETURN HOME >>" alt="Go To Home Page" class="cfAdminButton"
				onClick="document.location.href='home.cfm'">
		</td>
	</tr>
</table>

<cfinclude template="LayoutAdminFooter.cfm">