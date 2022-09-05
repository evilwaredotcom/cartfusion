<cfswitch expression="#thisTag.executionMode#">
<cfcase value="start">
  <cfsilent>
	<cfif not listFindNoCase(getBaseTagList(), "cf_jTab")>
	  <cfthrow message="jTabPane must be run inside of a jTab tag.">
	</cfif>
	<cfif not thisTag.hasEndTag>
	  <cfthrow message="jTabPane requires an end tag.">
	</cfif>

	<!--- Skin --->
	<cfparam name="attributes.skin" default="default">
	<cfif structKeyExists(request, "jComponent") AND structKeyExists(request.jComponent, "skins") AND structKeyExists (request.jComponent.skins, attributes.skin)>
	  <cfloop collection="#request.jComponent.skins[attributes.skin]#" item="i">
  	  <cfif not structKeyExists(attributes, i)>
  		<cfset attributes[i] = request.jComponent.skins[attributes.skin][i]>
  	  </cfif>
	  </cfloop>
	</cfif>
	
	<cfset baseData = getBaseTagData("cf_jTab")>
	<cfset itemName = baseData.items[arrayLen(baseData.panes) + 1]>
	<cfset arrayAppend(baseData.panes, itemName)>
  </cfsilent>
  <cfoutput>
  <table cellpadding="0" cellspacing="0" border="0" style="width:100%;display:<cfif not baseData.tabStruct[itemName].open>none</cfif>" id="pane#itemName#"><tr><td style="background:###baseData.attributes.bgColor#;">
  </cfoutput>
</cfcase>
<cfcase value="end">
  </td></tr></table>
</cfcase>
</cfswitch>