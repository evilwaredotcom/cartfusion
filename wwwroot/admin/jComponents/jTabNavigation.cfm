<cfswitch expression="#thisTag.executionMode#">
<cfcase value="start">
  <cfsilent>
	<cfif not thisTag.hasEndTag and not isDefined("attributes.skipEnd")>
	  <cfthrow message="jtabNavigation requires an end tag.">
	</cfif>
	<cfset baseData = getBaseTagData("cf_jTab")>
	
	<!--- Skin --->
	<cfparam name="attributes.skin" default="#basedata.attributes.skin#">
	<cfif structKeyExists(request, "jComponent") AND structKeyExists(request.jComponent, "skins") AND structKeyExists (request.jComponent.skins, attributes.skin)>
	  <cfloop collection="#request.jComponent.skins[attributes.skin]#" item="i">
  	  <cfif not structKeyExists(attributes, i)>
  		<cfset attributes[i] = request.jComponent.skins[attributes.skin][i]>
  	  </cfif>
	  </cfloop>
	</cfif>
	
	<cfset attributes.name = baseData.uniqueNav>
	<cfparam name="attributes.border" default="1">
	<cfparam name="attributes.borderColor" default="666666">
	<cfparam name="attributes.bgColor" default="FFFFFF">
	<cfif baseData.attributes.orientation neq "horizontal">
	  <cfparam name="attributes.openSide" default="right">
	<cfelse>
	  <cfparam name="attributes.openSide" default="bottom">
	</cfif>
	
	<cfset openTab = "">
	<cfset tabStruct = structNew()>
	<cfset baseData.tabStruct = tabStruct>
	<cfset baseData.uniqueNav = attributes.name>
  </cfsilent>
  <cfoutput>
  <table cellpadding="0" cellspacing="0" border="0" style="
	<cfif baseData.attributes.orientation eq "horizontal">width:#baseData.attributes.width#<cfif not baseData.attributes.width contains "%">px</cfif>;</cfif>
	<cfif baseData.attributes.orientation neq "horizontal">height:100%;</cfif>
	<cfif baseData.attributes.orientation eq "horizontal">border-left:#attributes.border#px ###attributes.borderColor# Solid;</cfif>
  ">
  <cfif baseData.attributes.orientation eq "horizontal">
	<tr>
  </cfif>
  </cfoutput>
</cfcase>
<cfcase value="end">
  <cfoutput>
  <cfif baseData.attributes.orientation eq "horizontal">
	  <td style="font-size:1px;width:100%;border-bottom:#baseData.attributes.border#px ###basedata.attributes.borderColor# Solid">&nbsp;</td>
	  </tr>
  <cfelse>
	<Tr><td style="height:100%;border-right:#baseData.attributes.border#px ###basedata.attributes.borderColor# Solid;border-top:#baseData.attributes.border#px ###basedata.attributes.borderColor# Solid">&nbsp;</td></tr>
  </cfif>
  </table>
  </td>
  <cfif baseData.attributes.orientation eq "horizontal">
	</tr>
	<tr>
  </cfif>
  <td>  
	<table cellpadding="0" cellspacing="0" border="0" style="width:#baseData.attributes.width#<cfif not baseData.attributes.width contains "%">px</cfif>;height:#baseData.attributes.height#px;border-right:#baseData.attributes.border#px ###basedata.attributes.borderColor# Solid;<cfif baseData.attributes.orientation eq "horizontal">border-left:#baseData.attributes.border#px ###basedata.attributes.borderColor# Solid;</cfif>border-bottom:#baseData.attributes.border#px ###basedata.attributes.borderColor# Solid;">
	<tr><td valign="top" style="background:###baseData.attributes.bgColor#;">
  </cfoutput>
  <cfset baseData.openTab = openTab>
</cfcase>
</cfswitch>
