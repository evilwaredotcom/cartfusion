<html>
<head>
  <link rel="stylesheet" type="text/css" href="styles.css">
  <title>jComponents 1.0</title>
  
  <script>
	function onNav () {
	  var tree = jComponents.getComponent("nav");
	  var viewFrame = document.getElementById("view");
	  
	  if (tree.items[tree.data].isOpen && tree.data.substring(0, 8) != "section_") {
		try { 
		  if (tree.data != 'doc.cfm') 
			viewFrame.src = tree.data;
		  else
			var foo = window.open("doc.cfm");
		} catch(e) {
		};
	  }
	}
  </script>
</head>
<body style="margin:0px">
<cf_jComponentSkin>

<div id="banner">
<h1>jComponents</h1>
a ColdFusion interface toolkit - version 1.0, build 09172004, <br>
<cfoutput>&copy; #datePart("yyyy", now())# <a href="mailto:joe.rinehart@gmail.com" style="color:##fff">joe rinehart</a>, all rights reserved. available at <a href="http://clearsoftware.net" style="color:##fff">http://clearsoftware.net</a>.</cfoutput>
</div>
<div id="nav">
	<cf_jTree name="nav" onChange="onNav" width="150" border="0" height="450" bgColor="FFC202">
	  <cf_jTreeNode label="About" data="section_about" open="true">
		<cf_jTreeLink label="Introduction" data="about.cfm">
		<cf_jTreeLink label="License" data="license.cfm">
		<cf_jTreeLink Label="About the Author" data="author.cfm">
	  </cf_jTreeNode>
	  <cf_jTreeLink label="Documentation" bold="true" icon="triangle.gif" data="doc.cfm">
	  <cf_jTreeNode label="Examples" data="section_examples" open="true">
		<cf_jTreeLink label="jTab" data="info.jTab.cfm">
		<cf_jTreeLink label="jAccordian" data="info.jAccordian.cfm">
		<cf_jTreeLink label="jTree" data="info.jTree.cfm">
		<cf_jTreeLink label="jContainer" data="info.jContainer.cfm">
	  </cf_jTreeNode>
	  <cf_jTreeNode label="Advanced Examples" data="section_advancedExamples" open="true">
		<cf_jTreeNode label="Skinning" data="section_skin" open="false">
		  <cf_jTreeLink label="Using Multiple Skins" data="ex.multipleSkins.cfm">
		</cf_jTreeNode>
		<cf_jTreeNode label="JavaScript Integration" data="section_javascript" open="false">
		  <cf_jTreeLink label="jTree As Navigation" data="ex.treeAndIFrame.cfm">
		  <cf_jTreeLink label="Binding Two Components" data="ex.componentBinding.cfm">
		  <cf_jTreeLink label="Saving Tree State" data="ex.saveTreeState.cfm">
		</cf_jTreeNode>
	  </cf_jTreeNode>
	  <cf_jTreeNode label="Sample Applications" data="section_demoApps" open="true">
		<cf_jTreeLink label="Contact Manager" data="ex.contactManager.cfm">
		<cf_jTreeLink label="Cold Baked Beans" data="ex.coldBakedBeans.cfm">
	  </cf_jTreeNode>
	</cf_jTree>
</div>
<div id="content">
	<iframe id="view" width="80%" height="100%" src="about.cfm" frameborder="0"></iframe>
</div>
</body>
