<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<!--- BEGIN: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<cfif isDefined('form.AddTerm')>
	<cfif Form.Term EQ '' OR Form.Definition EQ ''>	
		<cfset AdminMsg = 'Term and Definition must be defined. Add Unsucessful.' >
	<cfelse>
		<cfinsert datasource="#application.dsn#" tablename="Dictionary" 
			formfields="Term, Definition, Keywords">			
		<cfset AdminMsg = 'Term Added Sucessfully' >
	</cfif>
</cfif>

<cfif isDefined('form.UpdateTerm') AND IsDefined("form.DID")>
	<cfupdate datasource="#application.dsn#" tablename="Dictionary" 
		formfields="DID, Term, Definition, Keywords">
	<cfset AdminMsg = 'Term Updated Sucessfully' >
</cfif>

<cfif isDefined('form.DeleteTerm') AND IsDefined("form.DID")>
	<cfquery name="deleteTerm" datasource="#application.dsn#">
		DELETE
		FROM 	Dictionary
		WHERE	DID = #form.DID#
	</cfquery>	
	<cfset AdminMsg = 'Term Deleted Sucessfully' >
</cfif>

<!--- END: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->


<!--- BEGIN: QUERIES --->

<cfquery name="getTerms" datasource="#application.dsn#">
	SELECT	*
	FROM	Dictionary
	ORDER BY Term
</cfquery>

<!--- END: QUERIES --->

<!--- HEADER --->
<cfscript>
	PageTitle = 'ADD DICTIONARY TERM' ;
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">

<table border="0" cellpadding="3" cellspacing="0" width="100%">
<cfform action="#CGI.SCRIPT_NAME#" method="post">
	<tr style="background-color:##65ADF1;">
		<td width="5%" class="cfAdminHeader1">&nbsp;</td>		
		<td width="20%" valign="middle" class="cfAdminHeader1" >
			Term		
		</td>
		<td width="50%" valign="middle" class="cfAdminHeader1" >
			Definition
		</td>
		<td width="20%" valign="middle" class="cfAdminHeader1" >
			Search Keywords
		</td>
		<td width="5%" class="cfAdminHeader1">&nbsp;</td>
	</tr>
	<tr>
		<td width="5%" align="center" valign="middle">
			<input type="submit" name="AddTerm" value="ADD" alt="Add Dictionary Term" class="cfAdminButton">
		</td>
		<td width="20%" valign="middle">
			<input type="text" name="Term" size="20" align="absmiddle" class="cfAdminDefault">		
		</td>
		<td width="50%" valign="middle">
			<textarea name="Definition" rows="2" class="cfAdminDefault" cols="70"></textarea>
		</td>
		<td width="20%" valign="middle">
			<input type="text" name="Keywords" size="30" align="absmiddle" class="cfAdminDefault">
		</td>
		<td width="5%">&nbsp;</td>
	</tr>
<input type="hidden" name="DID" value="">
</cfform>
	
	<tr><td width="100%" height="20" align="left" class="cfAdminHeader4" colspan="5">&nbsp;</td></tr>
	<tr><td width="100%" height="20" align="left" colspan="5">&nbsp;</td></tr>
	<tr>
		<td width="100%" height="20" align="left" class="cfAdminTitle" colspan="5">UPDATE DICTIONARY TERMS</td>
	</tr>

	<tr style="background-color:##65ADF1;">
		<td width="5%" class="cfAdminHeader1">&nbsp;</td>
		<td width="20%" class="cfAdminHeader1" >
			Term
		</td>
		<td width="50%" class="cfAdminHeader1" >
			Definition
		</td>
		<td width="20%" class="cfAdminHeader1" >
			Search Keywords
		</td>
		<td width="5%" class="cfAdminHeader1">&nbsp;</td>
	</tr>

<cfoutput query="getTerms">
	<cfform action="#CGI.SCRIPT_NAME#" method="post">
	<tr class="cfAdminDefault">
		<td align="center" valign="middle">
			<input type="submit" name="UpdateTerm" value="UPDATE" alt="Update Dictionary Term" class="cfAdminButton">
		</td>
		<td>
			<input type="text" name="Term" value="#Term#" size="20" class="cfAdminDefault"> 
		</td>
		<td>
			<textarea name="Definition" rows="2" class="cfAdminDefault" cols="70">#Definition#</textarea>
		</td>
		<td>
			<input type="text" name="Keywords" value="#Keywords#" size="30" class="cfAdminDefault">
		</td>
		<td align="center" valign="middle">
			<input type="submit" name="DeleteTerm" value="DELETE" alt="Delete Term" class="cfAdminButton"
				onClick="return confirm('Are you sure you want to DELETE THIS TERM ?')">
		</td>
	</tr>
	<input type="hidden" name="DID" value="#DID#">
	</cfform>
</cfoutput>
</table>

<cfinclude template="LayoutAdminFooter.cfm">