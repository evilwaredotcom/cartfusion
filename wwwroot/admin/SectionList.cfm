<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<cfinvoke component="#application.Queries#" method="getSections" returnvariable="getSections"></cfinvoke>

<html>
<head>
	<title>Section ID List</title>
	<cfinclude template="css.cfm">
</head>

<body>

<div class="cfAdminTitle">SECTION ID LIST</div><br>

<table width="100%" cellpadding="3" cellspacing="0" border="0">
	<tr> 
		<td width="50%" valign="top">  
			<table width="100%" border="0" cellpadding="3" cellspacing="0">
			<cfif getSections.RecordCount NEQ 0>
				<cfoutput query="getSections" maxrows="#((getSections.RecordCount / 2) + 1)#" startrow="1">
				<tr>
					<td class="cfDefault" align="right">#SectionID#: </td>
					<td>#SecName#</td>
				</tr>
				</cfoutput>
			</cfif>
			</table>
		</td>
		<td width="50%" valign="top">  
			<table width="100%" border="0" cellpadding="3" cellspacing="0">
			<cfif getSections.RecordCount NEQ 0>
				<cfoutput query="getSections" maxrows="#(getSections.RecordCount / 2)#" startrow="#((getSections.RecordCount / 2) + 2)#"> 				
				<tr>
					<td class="cfDefault" align="right">#SectionID#: </td>
					<td>#SecName#</td>
				</tr>
				</cfoutput>
			</cfif>
			</table>
		</td>
	</tr>
</table>	

</body>
</html>
