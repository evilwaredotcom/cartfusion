<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<!--- BEGIN: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->
<cfif isDefined('form.UpdateShipCode') AND IsDefined("form.ShippingCode") >
	<cfif isUserInRole('Administrator')>
		<cfquery name="updateCode" datasource="#application.dsn#">
			UPDATE	ShippingCodes
			SET		ShippingMessage = '#FORM.ShippingMessage#'
			WHERE	ShippingCode = #FORM.ShippingCode#
		</cfquery>
		<cfset AdminMsg = 'Shipping Code Updated Successfully' >
	<cfelse>
		<SCRIPT LANGUAGE="JavaScript">
			{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
		</SCRIPT>
	</cfif>
</cfif>

<cfif isDefined('form.AddShipCode') AND IsDefined("form.ShippingCode") >
	<cfif isUserInRole('Administrator')>
		<cfquery name="insertCode" datasource="#application.dsn#">
			INSERT INTO ShippingCodes
				( ShippingCode, ShippingMessage )
			VALUES 
				( #ShippingCode#, '#ShippingMessage#' )
		</cfquery>
		<cfset AdminMsg = 'Shipping Code Added Successfully' >
	<cfelse>
		<SCRIPT LANGUAGE="JavaScript">
			{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
		</SCRIPT>
	</cfif>
</cfif>

<cfif isDefined('form.DeleteShipCode') AND IsDefined("form.ShippingCode") >
	<cfif isUserInRole('Administrator')>
		<cfquery name="deleteShipCode" datasource="#application.dsn#">
			DELETE
			FROM 	ShippingCodes
			WHERE	ShippingCode = #form.ShippingCode#
		</cfquery>			
		<cfset AdminMsg = 'Shipping Code Deleted Successfully' >
	<cfelse>
		<SCRIPT LANGUAGE="JavaScript">
			{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
		</SCRIPT>
	</cfif>
</cfif>
<!--- END: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<cfquery name="getShippingCodes" datasource="#application.dsn#" cachedwithin="#CreateTimeSpan(-7,0,0,0)#">
	SELECT	*
	FROM	ShippingCodes
</cfquery>

<!--- HEADER --->
<cfscript>
	PageTitle = 'SHIPPING CODES CONFIGURATION';
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">

<!--- SHIPPING Weight LEVELS --->
<table width="100%" border="0" cellpadding="0" cellspacing="0">	
	<tr style="background-color:##65ADF1;">
		<td width="5%"  class="cfAdminHeader1" height="20" align="center"></td><!--- UPDATE/ADD --->
		<td width="8%" class="cfAdminHeader1">Shipping Code</td>
		<td width="50%" class="cfAdminHeader1">Message</td>
		<td width="*"   class="cfAdminHeader1">&nbsp;</td><!--- DELETE --->
	</tr>
	<tr>
		<td height="5" colspan="4"></td>
	</tr>
	<cfoutput QUERY="getShippingCodes">			
	<cfform action="Config-ShipCodes.cfm" method="post">
	<tr>
		<td align="center">
			<input type="submit" name="UpdateShipCode" value="UPDATE" alt="Update Shipping Code" class="cfAdminButton">&nbsp;&nbsp;
		</td>
		<td><cfinput type="text" name="ShippingCode" value="#ShippingCode#" size="3" class="cfAdminDefault" required="yes" message="Please enter a numeric shipping code." validate="integer"></td>
		<td><cfinput type="text" name="ShippingMessage" value="#ShippingMessage#" size="120" class="cfAdminDefault" required="yes" message="Please enter a message for this code."></td>
		<td>
			<input type="submit" name="DeleteShipCode" value="DELETE" alt="Delete Shipping Code" class="cfAdminButton"
				onClick="return confirm('Are you sure you want to DELETE THIS SHIPPING CODE? Products related to this code will be affected.')">
		</td>
	</tr>
	<tr>
		<td height="2" colspan="4"></td>
	</tr>
	<tr style="background-color:##CCCCCC;">
		<td height="1" colspan="4"></td>
	</tr>
	<tr>
		<td height="2" colspan="4"></td>
	</tr>
	</cfform>
	</cfoutput>

	<!--- ADD NEW RATE LEVEL --->
	<cfform action="Config-ShipCodes.cfm" method="post">
	<tr>
		<td align="center">
			<input type="submit" name="AddShipCode" value="ADD" alt="Add Shipping Code" class="cfAdminButton">
		</td>
		<td><cfinput type="text" name="ShippingCode" size="3" class="cfAdminDefault" required="yes" message="Please enter a numeric shipping code." validate="integer"></td>
		<td><cfinput type="text" name="ShippingMessage" size="120" class="cfAdminDefault" required="yes" message="Please enter a message for this code."></td>
		<td>&nbsp;</td>			
	</tr>
	</cfform>
	<tr>
		<td colspan="4" height="20"><img src="images/spacer.gif" width="1" height="20"></td>
	</tr>
	<tr>
		<td colspan="4" align="center">
			<input type="button" name="GoBack" value="<< GO BACK" alt="Go Back To Configuration Screen" class="cfAdminButton"
				onClick="javascript:history.back()">
			<input type="button" name="GoBack" value="SHIPPING HOME" alt="Go Back To Configuration Screen" class="cfAdminButton"
				onClick="document.location.href='Config-Shipping.cfm'">
			<input type="button" name="ReturnHome" value="ADMIN HOME >>" alt="Go To Home Page" class="cfAdminButton"
				onClick="document.location.href='home.cfm'">
		</td>
	</tr>
</table>

<cfinclude template="LayoutAdminFooter.cfm">