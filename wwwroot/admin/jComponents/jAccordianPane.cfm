
<cfswitch expression="#thisTag.executionMode#">
<cfcase value="start">
  <cfsilent>
	<cfif not thisTag.hasEndTag>
	  <cfthrow message="jAccordianPane requires an end tag.">
	</cfif>

	<cfif not listFindNoCase(getBaseTagList(), "cf_jAccordian")>
	  <cfthrow message="jAccordianPane must be run inside of a jAccordian tag.">
	</cfif>
	
	<cfset baseData = getBaseTagData("cf_jAccordian")>
	
	<!--- Skin --->
	<cfparam name="attributes.skin" default="#baseData.attributes.skin#">
	<cfif structKeyExists(request, "jComponent") AND structKeyExists(request.jComponent, "skins") AND structKeyExists (request.jComponent.skins, attributes.skin)>
	  <cfloop collection="#request.jComponent.skins[attributes.skin]#" item="i">
  	  <cfif not structKeyExists(attributes, i)>
  		<cfset attributes[i] = request.jComponent.skins[attributes.skin][i]>
  	  </cfif>
	  </cfloop>
	</cfif>
	
	<cfparam name="attributes.name" default="#createUuid()#">
	<cfparam name="attributes.label" default="Pane #evaluate(arrayLen(baseData.paneNames) + 1)#">
	<cfparam name="attributes.border" default="1">
	<cfparam name="attributes.borderHighlight" default="1">
	<cfparam name="attributes.borderHighlightColor" default="FFFFFF">
	<cfparam name="attributes.borderLowlightColor" default="CCCCCC">
	<cfparam name="attributes.bgColor" default="#baseData.attributes.bgColor#">
	<cfparam name="attributes.fgColor" default="000000">
	<cfparam name="attributes.titleBgColor" default="EAEAEA">
	<cfparam name="attributes.titleFgColor" default="000000">
	<cfparam name="attributes.rollOverBgColor" default="ffffff">
	<cfparam name="attributes.rollOverFgColor" default="0066FF">
	<cfparam name="attributes.multiple" default="true">
	<cfparam name="attributes.underline" default="false">
	<cfparam name="attributes.font" default="Verdana">
	<cfparam name="attributes.fontSize" default="12">
	<cfparam name="attributes.underline" default="false">
	<cfparam name="attributes.bold" default="true">
	<cfparam name="attributes.open" default="false">
	<cfparam name="attributes.height" default="0">
	<cfparam name="attributes.icon" default="">
	<cfparam name="attributes.iconClosed" default="">
	
	
	<cfif not attributes.height>
	  <cfset attributes.height = baseData.attributes.height>
	</cfif>

	<cfset arrayAppend(baseData.paneNames, attributes.name)>
	
	<cfif attributes.open>
	  <cfset baseData.activeFlag = true>
	  <cfset baseData.openIndexes = listAppend(baseData.openIndexes, arrayLen(baseData.paneNames) - 1)>
	</cfif>
  </cfsilent>
  <cfoutput>
  <script>
	jComponents["#baseData.attributes.name#"].panes[jComponents["#baseData.attributes.name#"].panes.length] = "#attributes.name#";
	<cfif attributes.open>
	 jComponents["#baseData.attributes.name#"].defaultPanes[jComponents["#baseData.attributes.name#"].defaultPanes.length] = "#attributes.name#";
	</cfif>
  </script>
  <table width="100%" cellpadding="0" cellspacing="0" border="0" id="p#attributes.name#"
	
	style="cursor:hand;" <!--- border-top:#attributes.borderHighlight#px ###attributes.borderHighlightColor# Solid;
		   border-bottom:#basedata.attributes.border#px ###basedata.attributes.borderColor# Solid; --->
	<!---
	onMouseOver="jComponents.setBarColor(['b#attributes.name#','b1#attributes.name#','b2#attributes.name#'], ['a#attributes.name#'])" <!--- , '###attributes.rollOverBgColor#', '###attributes.rollOverFgColor#' --->
	onMouseOut="jComponents.setBarColor(['b#attributes.name#','b1#attributes.name#','b2#attributes.name#'], ['a#attributes.name#'], '###attributes.titleBgColor#', '###attributes.titleFgColor#')"
	--->
  >
	<tr>
	  <td id="b#attributes.name#"
	  	  <!---
		  style="background:###attributes.titleBgColor#;border-left:#attributes.borderHighlight#px ###attributes.borderHighlightColor# Solid;
		   border-right:#attributes.borderHighlight#px ###attributes.borderLowlightColor# Solid;
		   border-bottom:#attributes.borderHighlight#px ###attributes.borderLowlightColor# Solid;
		   cursor:hand"
		  --->
		  onClick="var result = jComponents.setAccordian('#baseData.attributes.name#', #evaluate(arrayLen(baseData.paneNames) - 1)#)"
	  >
	  <table cellpadding="0" cellspacing="0" border="0">
	  <tr>
		<!---
		<cfif len(attributes.icon) or len(attributes.iconClosed)>
		<td id="b1#attributes.name#" style="background:###attributes.titleBgColor#;padding-left:2px;padding-right:4px;" valign="top" style="font-family:#attributes.font#;font-size:#attributes.fontSize#px;cursor:hand;">
		  <!---
		  <cfif len(attributes.icon)><img id="i#attributes.name#" src="#attributes.icon#" border="0" onClick="var result = jComponents.setAccordian('#baseData.attributes.name#', #evaluate(arrayLen(baseData.paneNames) - 1)#)" style="cursor:hand;<cfif not attributes.open>display:none</cfif>"></cfif><cfif len(attributes.iconClosed)><img id="ic#attributes.name#" src="#attributes.iconClosed#" border="0" onClick="var result = jComponents.setAccordian('#baseData.attributes.name#', #evaluate(arrayLen(baseData.paneNames) - 1)#)" style="cursor:hand;<cfif attributes.open>display:none</cfif>"></cfif><cfif len(attributes.icon) and not len(attributes.iconClosed)><img id="ic#attributes.name#" src="#attributes.icon#" border="0" onClick="var result = jComponents.setAccordian('#baseData.attributes.name#', #evaluate(arrayLen(baseData.paneNames) - 1)#)" style="cursor:hand;<cfif attributes.open>display:none</cfif>"></cfif><cfif len(attributes.iconClosed) and not len(attributes.icon)><img id="i#attributes.name#" src="#attributes.iconClosed#" border="0" onClick="var result = jComponents.setAccordian('#baseData.attributes.name#', #evaluate(arrayLen(baseData.paneNames) - 1)#)" style="cursor:hand;<cfif attributes.open>display:none</cfif>"></cfif>
		  --->
		  <cfif len(attributes.icon)><img id="i#attributes.name#" src="#attributes.icon#" border="0" onClick="jComponents.go()" style="cursor:hand;<cfif not attributes.open>display:none</cfif>"></cfif><cfif len(attributes.iconClosed)><img id="ic#attributes.name#" src="#attributes.iconClosed#" border="0" onClick="jComponents.go()" style="cursor:hand;<cfif attributes.open>display:none</cfif>"></cfif><cfif len(attributes.icon) and not len(attributes.iconClosed)><img id="ic#attributes.name#" src="#attributes.icon#" border="0" onClick="jComponents.go()" style="cursor:hand;<cfif attributes.open>display:none</cfif>"></cfif><cfif len(attributes.iconClosed) and not len(attributes.icon)><img id="i#attributes.name#" src="#attributes.iconClosed#" border="0" onClick="jComponents.go()" style="cursor:hand;<cfif attributes.open>display:none</cfif>"></cfif>
		</td>
		</cfif>
		--->
		<td id="b2#attributes.name#" valign="top" style=""><!--- background:###attributes.titleBgColor#; --->
		<a <cfif isDefined('attributes.link')> href="#attributes.link#"
		   <cfelse> href="javascript:jComponents.go();"
		   </cfif>			
		   id="a#attributes.name#"
		   style="cursor:hand;"
		   class="cfAdminLeftNav"
		   target="main"
		   >
		   <div style="width:100%;padding-bottom:5px;">#attributes.label#</div>
		</a>
		</td>
	  </tr>
	  </table>
	  </td>
	</tr>
  </table>
  <table width="100%" cellpadding="0" cellspacing="0" border="0" id="#attributes.name#" style="display:none;border-bottom:#basedata.attributes.border#px ###basedata.attributes.borderColor# Solid;height:#attributes.height#<cfif attributes.height does not contain "%">px</cfif>;">
  <tr>
	<td valign="top" style=""><!--- background:###attributes.bgColor#; --->
  </cfoutput>
</cfcase>
<cfcase value="end">
	</td>
  </tr>
  </table>
</cfcase>
</cfswitch>
