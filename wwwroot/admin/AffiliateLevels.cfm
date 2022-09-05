<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<!--- BEGIN: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<cfif isDefined('form.AddAFLevel')>
	<cfif Form.LevelName EQ '' OR Form.L1 EQ ''>	
		<cfset AdminMsg = 'Level Name and at least 1 Commission Level must be defined.' >
	<cfelse>
		<cfinsert datasource="#application.dsn#" tablename="AffiliateCommissions" 
			formfields="LevelName, L1, L2, L3">			
		<cfset AdminMsg = 'Affiliate Level Added Sucessfully' >
	</cfif>
</cfif>

<cfif isDefined('form.UpdateAFLevel') AND IsDefined("form.CommID")>
	<cfupdate datasource="#application.dsn#" tablename="AffiliateCommissions" 
		formfields="CommID, LevelName, L1, L2, L3">
	<cfset AdminMsg = 'Affiliate Level Updated Sucessfully' >
</cfif>

<cfif isDefined('form.DeleteAFLevel') AND IsDefined("form.CommID")>
	<cfquery name="deleteAffiliateLevel" datasource="#application.dsn#">
		DELETE
		FROM 	AffiliateCommissions
		WHERE	CommID = #form.CommID#
	</cfquery>	
	<cfset AdminMsg = 'Affiliate Level Deleted Sucessfully' >
</cfif>

<!--- END: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->


<!--- BEGIN: QUERIES --->
<cfinvoke component="#application.Queries#" method="getAFLevels" returnvariable="getAFLevels"></cfinvoke>
<!--- END: QUERIES --->

<!--- HEADER --->
<cfscript>
	PageTitle = 'AFFILIATE LEVELS' ;
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">

<cfoutput>

<table border="0" cellpadding="3" cellspacing="0" width="100%">
<cfform action="#CGI.SCRIPT_NAME#" method="post">
	<tr style="background-color:##65ADF1;">
		<td width="5%" class="cfAdminHeader1">&nbsp;</td>
		<td width="5%" class="cfAdminHeader1">ID</td>	
		<td width="15%" class="cfAdminHeader1" >
			Affiliate Level Name		
		</td>
		<td width="15%" class="cfAdminHeader1" >
			Level 1 Commission
		</td>
		<td width="15%" class="cfAdminHeader1" >
			Level 2 Commission
		</td>
		<td width="15%" class="cfAdminHeader1" >
			Level 3 Commission
		</td>
		<td width="30%" class="cfAdminHeader1">&nbsp;</td>
	</tr>
	<tr>
		<td align="center"><input type="submit" name="AddAFLevel" value="ADD" alt="Add Affiliate Level" class="cfAdminButton"></td>
		<td>TBD</td>
		<td><input type="text" name="LevelName" size="20" align="absmiddle" class="cfAdminDefault"></td>
		<td><input type="text" name="L1" size="5" align="absmiddle" class="cfAdminDefault">%</td>
		<td><input type="text" name="L2" size="5" align="absmiddle" class="cfAdminDefault">%</td>
		<td><input type="text" name="L3" size="5" align="absmiddle" class="cfAdminDefault">%</td>
		<td>&nbsp;</td>
	</tr>
<input type="hidden" name="CommID" value="">
</cfform>
	
	<tr><td width="100%" height="20" align="left" class="cfAdminHeader4" colspan="7">&nbsp;</td></tr>
	<tr><td width="100%" height="20" align="left" colspan="7">&nbsp;</td></tr>
	<tr>
		<td width="100%" height="20" align="left" class="cfAdminTitle" colspan="7">UPDATE AFFILIATE LEVELS</td>
	</tr>

	<tr style="background-color:##65ADF1;">
		<td class="cfAdminHeader1">&nbsp;</td>
		<td class="cfAdminHeader1" >ID</td>		
		<td class="cfAdminHeader1" >
			Affiliate Level Name		
		</td>
		<td class="cfAdminHeader1" >
			Level 1 Commission
		</td>
		<td class="cfAdminHeader1" >
			Level 2 Commission
		</td>
		<td class="cfAdminHeader1" >
			Level 3 Commission
		</td>
		<td class="cfAdminHeader1">&nbsp;</td>
	</tr>
</cfoutput>

<cfoutput query="getAFLevels">
	<cfform action="#CGI.SCRIPT_NAME#" method="post">
	<tr class="cfAdminDefault">
		<td align="center">
			<input type="submit" name="UpdateAFLevel" value="UPDATE" alt="Update Affiliate Level" class="cfAdminButton">
		</td>
		<td>#CommID#</td>
		<td><input type="text" name="LevelName" value="#LevelName#" size="20" class="cfAdminDefault"></td>
		<td><input type="text" name="L1" value="#DecimalFormat(L1)#" size="5" class="cfAdminDefault">%</td>
		<td><input type="text" name="L2" value="#DecimalFormat(L2)#" size="5" class="cfAdminDefault">%</td>
		<td><input type="text" name="L3" value="#DecimalFormat(L3)#" size="5" class="cfAdminDefault">%</td>
		<td>
			<input type="submit" name="DeleteAFLevel" value="DELETE" alt="Delete Affiliate Level" class="cfAdminButton"
				onclick="return confirm('Are you sure you want to DELETE THIS AFFILIATE LEVEL ?')">
		</td>
	</tr>
	<input type="hidden" name="CommID" value="#CommID#">
	</cfform>
</cfoutput>
</table>

<cfinclude template="LayoutAdminFooter.cfm">