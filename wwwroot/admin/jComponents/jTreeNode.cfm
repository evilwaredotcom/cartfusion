<cfswitch expression="#thisTag.executionMode#">
<cfcase value="start">
  <cfsilent>
	<cfif not thisTag.hasEndTag>
	  <cfthrow message="jTreeNode requires an end tag.">
	</cfif>

	<cfif not listFindNoCase(getBaseTagList(), "cf_jTree")>
	  <cfthrow message="jTreeNode must be run inside of a jTree tag.">
	</cfif>
	
	<cfset baseData = getBaseTagData("cf_jTree")>
	
	<!--- Skin --->
	<cfparam name="attributes.skin" default="#baseData.attributes.skin#">
	<cfif structKeyExists(request, "jComponent") AND structKeyExists(request.jComponent, "skins") AND structKeyExists (request.jComponent.skins, attributes.skin)>
	  <cfloop collection="#request.jComponent.skins[attributes.skin]#" item="i">
  	  <cfif not structKeyExists(attributes, i)>
  		<cfset attributes[i] = request.jComponent.skins[attributes.skin][i]>
  	  </cfif>
	  </cfloop>
	</cfif>
	
	<cfparam name="attributes.label" default="jTreeNode#replaceNoCase(createUuid(), "-", "", "all")#">
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
	<cfparam name="attributes.icon" default="">
	<cfparam name="attributes.iconClosed" default="">
	<cfset child = "j" & replaceNoCase(createUuid(), "-", "", "all")>
	
	<cfset attributes.titleBgColor = baseData.attributes.bgColor>
	<cfset attributes.border = 0>
	<cfset attributes.borderHighlightColor = attributes.bgColor>
  </cfsilent>
  <cfoutput>
  <script>
	jComponents["#basedata.attributes.name#"].items["#attributes.data#"] = {id:"#child#",isOpen:false};
  </script>
  <table width="#attributes.width#" cellpadding="0" cellspacing="0" border="0"
	style="cursor:hand"
	<!---
	onMouseOver="this.style.background = '###attributes.rollOverBgColor#';document.getElementById('t#child#').style.color = '###attributes.rollOverFgColor#'"
	onMouseOut="this.style.background = '###attributes.titleBgColor#';document.getElementById('t#child#').style.color = '###attributes.titleFgColor#'"
	--->
	onClick="<cfif attributes.closeable>var result=jComponents.setTree('#baseData.attributes.name#', '#attributes.data#', (document.getElementById('#child#').style.display == 'none') ? true : false);var data = jComponents['#baseData.attributes.name#'].data = '#attributes.data#';<cfif len(baseData.attributes.onChange)>#baseData.attributes.onChange#()</cfif><cfelse>0</cfif>"
  >
	<tr>
	  <td style=""><!--- background:###attributes.titleBgColor#; --->
	  <table cellpadding="0" cellspacing="0" border="0">
	  <tr>
	  	<!---
		<cfif len(attributes.icon) or len(attributes.iconClosed)>
		<td style="padding-left:0px;padding-right:0px;color:###attributes.titleFgColor#;font-family:#attributes.font#;font-size:#attributes.fontSize#px;cursor:hand;"><!--- background:###attributes.titleBgColor#; --->
		  <cfif len(attributes.icon)><img id="i#child#" src="#attributes.icon#" border="0" <cfif not attributes.open>style="display:none"</cfif>></cfif><cfif len(attributes.iconClosed)><img id="ic#child#" src="#attributes.iconClosed#" border="0" <cfif attributes.open>style="display:none"</cfif>></cfif><cfif len(attributes.icon) and not len(attributes.iconClosed)><img id="ic#child#" src="#attributes.icon#" border="0" <cfif attributes.open>style="display:none"</cfif>></cfif><cfif len(attributes.iconClosed) and not len(attributes.icon)><img id="i#child#" src="#attributes.iconClosed#" border="0" <cfif not attributes.open>style="display:none"</cfif>></cfif>
		</td>
		</cfif>
		--->
		<td valign="top">
		  <a href="Javascript:jComponents.go()"
			 id = "t#child#"
			 style="cursor:hand;"
			 class="cfAdminLeftNav"
			 target="main"
			 >
			  <div style="width:100%;padding-bottom:5px;">#attributes.label#</div><!--- background:###attributes.titleBgColor#; --->
		  </a>
		</td>
	  </tr>
	  </table>
	  </td>
	</tr>
  </table>
  <table width="#attributes.width#" cellpadding="0" cellspacing="0" border="0" id="#child#" style="
	display:none;
  ">
  <tr>
	<td></td><!--- style="width:#attributes.indent#px background:###attributes.titleBgColor#;" --->
	<td valign="top">
  </cfoutput>
</cfcase>
<cfcase value="end">
	</td>
  </tr>
  </table>
  <cfoutput>
  <script>
  <cfif attributes.open>
	jComponents["#basedata.attributes.name#"].data = '#attributes.data#';
	jComponents.setTree("#basedata.attributes.name#", "#attributes.data#", true);
  </cfif>
  </script>
  </cfoutput>
</cfcase>
</cfswitch>

	  