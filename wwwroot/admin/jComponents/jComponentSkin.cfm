<cfsilent>
<cfif thisTag.executionMode eq "start">
  <cfif not structKeyExists(request, "jComponent")>
	<cfset request.jComponent = structNew() >
  </cfif>
  <cfif not structKeyExists(request.jComponent, "skin")>
	<cfset request.jComponent.skins = structNew() >
  </cfif>
  
  <!--- DEFAULT SKIN --->
  <cfset Request.jComponent.skins.default = structNew()>
  <!--- Border around the component --->
  <cfset Request.jComponent.skins.default.border = "0">
  <cfset Request.jComponent.skins.default.borderColor = "666666">
  <cfset Request.jComponent.skins.default.borderHighlight = "1">
  <cfset Request.jComponent.skins.default.borderHighlightColor = "FFFFFF">
  <cfset Request.jComponent.skins.default.borderLowlightColor = "CCCCCC">
  
  <!--- Component background / foreground colors.  Foreground will most likely do nothing. --->
  <!---<cfset Request.jComponent.skins.default.bgColor = "FFFFFF">--->
  <cfset Request.jComponent.skins.default.fgColor = "000000">
  
  <!--- Foreground / Background for title bars --->
  <cfset Request.jComponent.skins.default.titleBgColor = "e0e0e0">
  <cfset Request.jComponent.skins.default.titleFgColor = "000000">

  <!--- Foreground / Background for inactive tabs --->
  <cfset Request.jComponent.skins.default.inactiveBgColor = "e0e0e0">
  <cfset Request.jComponent.skins.default.inactiveFgColor = "333333">
  
  <!--- Background and Foreground (font) color for the tabs / title bars / tree node text when rolled over --->
  <cfset Request.jComponent.skins.default.rollOverBgColor = "000000">
  <cfset Request.jComponent.skins.default.rollOverFgColor = "000000">
  
  <!--- Font size, face, underline, and bold for the title bars / tree node text --->
  <cfset Request.jComponent.skins.default.font = "Tahoma">
  <cfset Request.jComponent.skins.default.fontSize = "11">
  <cfset Request.jComponent.skins.default.underline = "false">
  <cfset Request.jComponent.skins.default.bold = "false">
  
  <!--- Amound to indent tree nodes --->
  <cfset Request.jComponent.skins.default.indent = "8">
  
  <!--- Icon used in title bars --->
  <cfset Request.jComponent.skins.default.icon = ""><!--- ../images/arrowdownpic.gif  |  jComponents/opentriangle.gif --->
  <cfset Request.jComponent.skins.default.iconClosed = ""><!--- ../images/arrowrightpic.gif  |  jComponents/triangle.gif --->
  <!--- /DEFAULT SKIN --->
  
  <!--- Add on for the default jTreeLink skin --->
  <cfset Request.jComponent.skins.defaultJTreeLink = structCopy(Request.jComponent.skins.default) />
  <cfset Request.jComponent.skins.defaultJTreeLink.icon = "">
  <cfset Request.jComponent.skins.defaultJTreeLink.iconClosed = "">
  <cfset Request.jComponent.skins.defaultJTreeLink.font = "Tahoma">
  <cfset Request.jComponent.skins.defaultJTreeLink.fontSize = "11">
  <cfset Request.jComponent.skins.defaultJTreeLink.bold = "false">
  <cfset Request.jComponent.skins.defaultJTreeLink.underline = "true">
  <cfset Request.jComponent.skins.defaultJTreeLink.titleFgColor = "000000"><!--- 6B97FF --->
  
  
  <!--- ADDITIONAL SKIN --->
  <!--- 
	additionalSkin is an example of how to add an additional skin, specified
	by the "skin" attribute on a given base tag
  --->
  <!--- Set the skin name --->
  <cfset skinName="additionalSkin">
  
  <!--- Define the skin --->
  <cfset Request.jComponent.skins[skinName] = structNew()>

  <!--- Border around the component --->
  <cfset Request.jComponent.skins[skinName].border = "0">
  <cfset Request.jComponent.skins[skinName].borderColor = "666666">
  <cfset Request.jComponent.skins[skinName].borderHighlight = "1">
  <cfset Request.jComponent.skins[skinName].borderHighlightColor = "FFFFFF">
  <cfset Request.jComponent.skins[skinName].borderLowlightColor = "CCCCCC">
  
  <!--- Component background / foreground colors.  Foreground will most likely do nothing. --->
  <!---<cfset Request.jComponent.skins[skinName].bgColor = "EFEFEF">--->
  <cfset Request.jComponent.skins[skinName].fgColor = "1269DD">
  
  <!--- Foreground / Background for title bars --->
  <cfset Request.jComponent.skins[skinName].titleBgColor = "e0e0e0">
  <cfset Request.jComponent.skins[skinName].titleFgColor = "1269DD">

  <!--- Foreground / Background for inactive tabs --->
  <cfset Request.jComponent.skins[skinName].inactiveBgColor = "e0e0e0">
  <cfset Request.jComponent.skins[skinName].inactiveFgColor = "333333">
  
  <!--- Background and Foreground (font) color for the tabs / title bars / tree node text when rolled over --->
  <cfset Request.jComponent.skins[skinName].rollOverBgColor = "F0F0F0">
  <cfset Request.jComponent.skins[skinName].rollOverFgColor = "0066FF">
  
  <!--- Font size, face, underline, and bold for the title bars / tree node text --->
  <cfset Request.jComponent.skins[skinName].font = "Arial">
  <cfset Request.jComponent.skins[skinName].fontSize = "8">
  <cfset Request.jComponent.skins[skinName].underline = "false">
  <cfset Request.jComponent.skins[skinName].bold = "true">
  
  <!--- Amound to indent tree nodes --->
  <cfset Request.jComponent.skins[skinName].indent = "10">
  
  <!--- Icon used in title bars --->
  <cfset Request.jComponent.skins[skinName].icon = "">
  <cfset Request.jComponent.skins[skinName].iconClosed = "">
  <!--- /ADDTIONAL SKIN --->

  <!--- Backwards compatibility --->
  <cfset Request.jComponent.skin = Request.jComponent.skins.default />
</cfif>
</cfsilent>
