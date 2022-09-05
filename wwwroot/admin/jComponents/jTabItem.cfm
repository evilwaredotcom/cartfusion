<cfsilent>
  <cfif not listFindNoCase(getBaseTagList(), "cf_jTabNavigation")>
	<cfthrow message="jTab must be run inside of a jTabNavigation tag.">
  </cfif>
  <cfset baseData = getBaseTagData("cf_jTabNavigation")>

  <!--- Skin --->
  <cfparam name="attributes.skin" default="#basedata.basedata.attributes.skin#">
  <cfif structKeyExists(request, "jComponent") AND structKeyExists(request.jComponent, "skins") AND structKeyExists (request.jComponent.skins, attributes.skin)>
	<cfloop collection="#request.jComponent.skins[attributes.skin]#" item="i">
	  <cfif not structKeyExists(attributes, i)>
		<cfset attributes[i] = request.jComponent.skins[attributes.skin][i]>
	  </cfif>
	</cfloop>
  </cfif>
	  
  <cfparam name="attributes.label" default="jTabItem">
  <cfparam name="attributes.width" default="100">
  <cfparam name="attributes.borderHighlightColor" default="FFFFFF">
  <cfparam name="attributes.borderColor" default="666666">
  <cfparam name="attributes.bgColor" default="FFFFFF">
  <cfparam name="attributes.fgColor" default="000000">
  <cfparam name="attributes.titleBgColor" default="e0e0e0">
  <cfparam name="attributes.titleFgColor" default="000000">
  <cfparam name="attributes.rollOverBgColor" default="ffffff">
  <cfparam name="attributes.rollOverFgColor" default="0066FF">
  <cfparam name="attributes.inactiveBgColor" default="EAEAEA">
  <cfparam name="attributes.inactiveFgColor" default="666666">
  <cfparam name="attributes.underline" default="false">
  <cfparam name="attributes.font" default="Verdana">
  <cfparam name="attributes.fontSize" default="12">
  <cfparam name="attributes.bold" default="true">
  <cfparam name="attributes.open" default="false">
  <cfparam name="attributes.icon" default="">
  <cfparam name="attributes.iconClosed" default="">
  <cfset attributes.name=replaceNoCase(createUuid(), "-", "", "all")>

  <cfif attributes.open>
	<cfset baseData.openTab = attributes.name>
	<cfset baseData.basedata.openTabIndex = arrayLen(baseData.baseData.items)>
  </cfif>
  <cfset baseData.tabStruct[attributes.name] = attributes>
  <cfset arrayAppend(baseData.baseData.items, attributes.name)>
  <cfset child = attributes.name>
</cfsilent>
<cfoutput>
  <script>
	jComponents["#baseData.baseData.attributes.name#"].panes[jComponents["#baseData.baseData.attributes.name#"].panes.length] = "#attributes.name#";
	jComponents["#baseData.baseData.attributes.name#"]["#attributes.name#"] = {
	  inactiveFgColor:"#attributes.inactiveFgColor#",inactiveBgColor:"#attributes.inactiveBgColor#",titleFgColor:"#attributes.titleFgColor#",titleBgColor:"#attributes.titleBgColor#",borderColor:"#attributes.borderColor#",bgColor:"#attributes.bgColor#"
	}
  </script>
  <cfif baseData.baseData.attributes.orientation neq "horizontal">
	<tr>
  </cfif>
  <td id="tab#child#" style="
			 <cfif baseData.baseData.attributes.orientation eq "horizontal" or (baseData.baseData.attributes.orientation neq "horizontal" and structCount(baseData.tabStruct) gt 1)>border-top:1px ###attributes.borderColor# Solid;</cfif>
			 <cfif baseData.baseData.attributes.orientation eq "horizontal">border-bottom:1px ###attributes.borderColor# Solid;</cfif>
			 border-right:1px ###attributes.borderColor# Solid;
			 cursor:hand;
			 background:###attributes.inactiveBgColor#;"
	onMouseOver="if (jComponents['#baseData.baseData.attributes.name#'].activePane != '#child#') {jComponents.setBarColor(['tab#child#','tab1#child#','tab2#child#'], ['t#child#'], '###attributes.rollOverBgColor#', '###attributes.rollOverFgColor#')}"
	onMouseOut="if (jComponents['#baseData.baseData.attributes.name#'].activePane != '#child#') {jComponents.setBarColor(['tab#child#','tab1#child#','tab2#child#'], ['t#child#'], '###attributes.inactiveBgColor#', '###attributes.inactiveFgColor#')}"
	onClick="Javascript:jComponents.setTab('#baseData.basedata.attributes.name#', #evaluate(arrayLen(baseData.baseData.items)- 1)#);"
	nowrap="true"
	valign="top"
  >
  <table cellpadding="0" cellspacing="0" border="0" width="100%">
	<tr>
		<cfif len(attributes.icon) or len(attributes.iconClosed)>
		<td id="tab1#child#" valign="top" style="background:###attributes.inactiveBgColor#;border-top:1px ###attributes.borderHighlightColor# Solid;font-family:#attributes.font#;font-size:#attributes.fontSize#px;cursor:hand;padding-left:4px;padding-bottom:2px;padding-top:2px;">
			<cfif len(attributes.icon)><img id="i#child#" src="#attributes.icon#" border="0" style="cursor:hand;display:none"></cfif><cfif len(attributes.iconClosed)><img id="ic#child#" src="#attributes.iconClosed#" border="0" style="cursor:hand;display:none"></cfif><cfif len(attributes.icon) and not len(attributes.iconClosed)><img id="ic#child#" src="#attributes.icon#" border="0" style="cursor:hand;display:none"></cfif><cfif len(attributes.iconClosed) and not len(attributes.icon)><img id="i#child#" src="#attributes.iconClosed#" border="0" style="cursor:hand;display:none"></cfif>
		</td>
		</cfif>
	  <td id="tab2#child#" valign="top" nowrap="true" style="background:###attributes.inactiveBgColor#;"><a href="Javascript:jComponents.go()"
			   id = "t#child#"
			   style="color:###attributes.inactiveFgColor#;
					  font-family:#attributes.font#; 
					  font-size:#attributes.fontSize#px;
					  cursor:hand;
					  <cfif attributes.bold>font-weight:bold;</cfif>
					  <cfif not attributes.underline>text-decoration:none;</cfif>
					  color:###attributes.inactiveFgColor#"
			   ><div style="width:100%;border-top:1px ###attributes.borderHighlightColor# Solid"><div style="padding-top:2px;padding-bottom:2px;padding-left:<cfif len(attributes.icon)>4<cfelse>10</cfif>px;padding-right:10px;width:100%">#attributes.label#</div></div></a>
	  </td>
	</tr>
  </table>
  </td>
  <cfif baseData.baseData.attributes.orientation neq "horizontal">
	</tr>
  </cfif>
 </cfoutput>
