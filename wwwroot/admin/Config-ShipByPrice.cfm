<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<!--- BEGIN: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->
<cfif isDefined('form.UpdateShipPrice') AND IsDefined("form.ShipPriceID") >
	<cfif isUserInRole('Administrator')>
		<cfscript>
			Form.Start = Replace(Form.Start, "," , "", "ALL") ;
			Form.Finish = Replace(Form.Finish, "," , "", "ALL") ;
			Form.DomesticRate = Replace(Form.DomesticRate, "," , "", "ALL") ;
			Form.InternationalRate = Replace(Form.InternationalRate, "," , "", "ALL") ;
		</cfscript>
		<cfupdate datasource="#application.dsn#" tablename="ShipPrice" 
			formfields="ShipPriceID, Start, Finish, DomesticRate, InternationalRate">	
		<cfset AdminMsg = '"Ship By Price" Rates Updated Successfully' >
	<cfelse>
		<SCRIPT LANGUAGE="JavaScript">
			{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
		</SCRIPT>
	</cfif>
</cfif>

<cfif isDefined('form.AddShipPrice')>
	<cfif isUserInRole('Administrator')>
		<cfscript>
			Form.Start = Replace(Form.Start, "," , "", "ALL") ;
			Form.Finish = Replace(Form.Finish, "," , "", "ALL") ;
			Form.DomesticRate = Replace(Form.DomesticRate, "," , "", "ALL") ;
			Form.InternationalRate = Replace(Form.InternationalRate, "," , "", "ALL") ;
		</cfscript>
		<cfinsert datasource="#application.dsn#" tablename="ShipPrice" 
			formfields="Start, Finish, DomesticRate, InternationalRate">
		<cfset AdminMsg = '"Ship By Price" Rate Added Successfully' >
	<cfelse>
		<SCRIPT LANGUAGE="JavaScript">
			{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
		</SCRIPT>
	</cfif>
</cfif>

<cfif isDefined('form.DeleteShipPrice') AND IsDefined("form.ShipPriceID") >
	<cfif isUserInRole('Administrator')>
		<cfquery name="deleteAltStyle" datasource="#application.dsn#">
			DELETE
			FROM 	ShipPrice
			WHERE	ShipPriceID = #form.ShipPriceID#
		</cfquery>			
		<cfset AdminMsg = '"Ship By Price" Rate Deleted Successfully' >
	<cfelse>
		<SCRIPT LANGUAGE="JavaScript">
			{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
		</SCRIPT>
	</cfif>
</cfif>
<!--- END: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<cfquery name="getShippingPrices" datasource="#application.dsn#" cachedwithin="#CreateTimeSpan(-7,0,0,0)#">
	SELECT	*
	FROM	ShipPrice
	ORDER BY Start, Finish
</cfquery>

<!--- HEADER --->
<cfscript>
	PageTitle = 'SHIP BY PRICE CONFIGURATION';
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">

<!--- SHIPPING PRICE LEVELS --->
<table width="100%" border="0" cellpadding="0" cellspacing="0">	
	<tr style="background-color:##65ADF1;">
		<td width="5%"  class="cfAdminHeader1" height="20" align="center"></td><!--- DELETE/ADD --->
		<td width="15%" class="cfAdminHeader1">From Price</td>
		<td width="15%" class="cfAdminHeader1">To Price</td>
		<td width="15%" class="cfAdminHeader1">Domestic Rate</td>
		<td width="15%" class="cfAdminHeader1">Int'l Rate</td>
		<td width="5%"  class="cfAdminHeader1">&nbsp;</td>
		<td width="30%" class="cfAdminHeader1">&nbsp;</td>
	</tr>
	<tr>
		<td height="5" colspan="7"></td>
	</tr>
	<cfoutput QUERY="getShippingPrices">			
	<cfform action="Config-ShipByPrice.cfm" method="post">
	<tr>
		<td align="center">
			<input type="submit" name="UpdateShipPrice" value="UPDATE" alt="Update Shipping Price" class="cfAdminButton">&nbsp;&nbsp;
		</td>
		<td>$<cfinput type="text" name="Start" value="#DecimalFormat(Start)#" size="12" class="cfAdminDefault" required="yes" message="Please enter a price level starting price."></td>
		<td>$<cfinput type="text" name="Finish" value="#DecimalFormat(Finish)#" size="12" class="cfAdminDefault" required="yes" message="Please enter a price level ending price."></td>
		<td>$<cfinput type="text" name="DomesticRate" value="#DecimalFormat(DomesticRate)#" size="12" class="cfAdminDefault" required="yes" message="Please enter a domestic rate for this price level."></td>
		<td>$<cfinput type="text" name="InternationalRate" value="#DecimalFormat(InternationalRate)#" size="12" class="cfAdminDefault" required="yes" message="Please enter an international rate for this price level. If not applicable, enter $0.00."></td>
		<td>
			<input type="submit" name="DeleteShipPrice" value="DELETE" alt="Delete Shipping Price" class="cfAdminButton"
				onClick="return confirm('Are you sure you want to DELETE THIS SHIPPING RATE LEVEL?')">
		</td>
		<td>&nbsp;</td>			
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
		<input type="hidden" name="ShipPriceID" value="#ShipPriceID#">
	</cfform>
	</cfoutput>

	<!--- ADD NEW RATE LEVEL --->
	<cfform action="Config-ShipByPrice.cfm" method="post">
	<tr>
		<td align="center">
			<input type="submit" name="AddShipPrice" value="ADD" alt="Add Shipping Price" class="cfAdminButton">
		</td>
		<td>$<cfinput type="text" name="Start" size="12" class="cfAdminDefault" required="yes" message="Please enter a price level starting price."></td>
		<td>$<cfinput type="text" name="Finish" size="12" class="cfAdminDefault" required="yes" message="Please enter a price level ending price."></td>
		<td>$<cfinput type="text" name="DomesticRate" size="12" class="cfAdminDefault" required="yes" message="Please enter a domestic rate for this price level."></td>
		<td>$<cfinput type="text" name="InternationalRate" size="12" class="cfAdminDefault" required="yes" message="Please enter an international rate for this price level. If not applicable, enter $0.00."></td>
		<td>&nbsp;</td>			
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