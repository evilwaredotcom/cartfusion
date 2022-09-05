<cfswitch expression="#thisTag.executionMode#">
<cfcase value="start">
  <cfsilent>
	<cfif not listFindNoCase(getBaseTagList(), "cf_jTree")>
	  <cfthrow message="jTreeLink must be run inside of a jTree tag.">
	</cfif>
	
	<cfset baseData = getBaseTagData("cf_jTree")>
	
	<!--- Skin --->
	<cfif baseData.attributes.skin eq "default">
	  <cfparam name="attributes.skin" default="defaultJTreeLink">
	<cfelse>
	  <cfparam name="attributes.skin" default="#baseData.attributes.skin#">
	</cfif>
	
	<cfif structKeyExists(request, "jComponent") AND structKeyExists(request.jComponent, "skins") AND structKeyExists (request.jComponent.skins, attributes.skin)>
	  <cfloop collection="#request.jComponent.skins[attributes.skin]#" item="i">
  	  <cfif not structKeyExists(attributes, i)>
  		<cfset attributes[i] = request.jComponent.skins[attributes.skin][i]>
  	  </cfif>
	  </cfloop>
	</cfif>
	
	<cfparam name="attributes.label" default="jTreeLink">
	<cfparam name="attributes.width" default="100%">
	<cfparam name="attributes.bgColor" default="ffffff">
	<cfparam name="attributes.fgColor" default="000000">
	<cfparam name="attributes.titleBgColor" default="eaeaea">
	<cfparam name="attributes.titleFgColor" default="000000">
	<cfparam name="attributes.rollOverBgColor" default="ffffff">
	<cfparam name="attributes.rollOverFgColor" default="0066FF">
	<cfparam name="attributes.underline" default="false">
	<cfparam name="attributes.font" default="Verdana">
	<cfparam name="attributes.fontSize" default="12">
	<cfparam name="attributes.bold" default="false">
	<cfparam name="attributes.open" default="false">
	<cfparam name="attributes.indent" default="0">
	<cfparam name="attributes.closeable" default="true">
	<cfparam name="attributes.height" default="0">
	<cfparam name="attributes.data" default="#attributes.label#">
	<cfparam name="attributes.script" default="" />
	<cfparam name="attributes.icon" default="">
	<cfparam name="attributes.iconClosed" default="">
	<cfset child = "j" & replaceNoCase(createUuid(), "-", "", "all")>
	
	<cfset attributes.titleBgColor = baseData.attributes.bgColor>
	<cfset attributes.border = 0>
	<cfset attributes.borderHighlightColor = attributes.bgColor>
  </cfsilent>
  <cfoutput>
  <script>
	jComponents["#basedata.attributes.name#"].items["#attributes.data#"] = {id:"#child#",isOpen:true};
  </script>
  <table width="#attributes.width#" cellpadding="0" cellspacing="0" border="0"
	style="cursor:hand"
	<!---
	onMouseOver="this.style.background = '###attributes.rollOverBgColor#';document.getElementById('t#child#').style.color = '###attributes.rollOverFgColor#'"
	onMouseOut="this.style.background = '###attributes.titleBgColor#';document.getElementById('t#child#').style.color = '###attributes.titleFgColor#'"
	--->
	<!---
	<cfif len(attributes.script)>
		onClick="#attributes.script#"
	<cfelse>
		onClick="<cfif attributes.closeable>var data = jComponents['#baseData.attributes.name#'].data = '#attributes.data#';<cfif len(baseData.attributes.onChange)>#baseData.attributes.onChange#()</cfif><cfelse>0</cfif>"
	</cfif>
	--->
  >
	<tr>
	  <td style=""><!---background:###attributes.titleBgColor#;--->
	  <table cellpadding="0" cellspacing="0" border="0">
	  <tr>
		<!---
		<cfif len(attributes.icon)>
		<td style="padding-left:2px;padding-right:2px;padding-top:2px;font-family:#attributes.font#;font-size:#attributes.fontSize#px;cursor:hand;" valign="top"><!---background:###attributes.titleBgColor#;--->
		  <img src="#attributes.icon#" border="0">
		</td>
		<cfelseif len(attributes.iconClosed)>
		<td style="padding-left:2px;padding-right:2px;padding-top:2px;font-family:#attributes.font#;font-size:#attributes.fontSize#px;cursor:hand;" valign="top"><!---background:###attributes.titleBgColor#;--->
		  <img src="#attributes.iconClosed#" border="0">
		</td>
		</cfif>
		--->
		<td valign="top"><!--- Javascript:jComponents.go() --->
		  <a href="#attributes.data#"
			 id = "t#child#"
			 style="cursor:hand;"
			 class="cfAdminLeftNav"
			 target="main"
			 >
			  <div style="width:100%;padding-bottom:5px;">#attributes.label#</div><!---background:###attributes.titleBgColor#;--->
		  </a>
		</td>
	  </tr>
	  </table>
	  </td>
	</tr>
  </table>
  </cfoutput>
  <cfoutput>
  <script>
  <cfif attributes.open>
	jComponents["#basedata.attributes.name#"].data = '#attributes.data#';
  </cfif>
  </script>
  </cfoutput>
</cfcase>
<cfcase value="end">
</cfcase>
</cfswitch>

	  