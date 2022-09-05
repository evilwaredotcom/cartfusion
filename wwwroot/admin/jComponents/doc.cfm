<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
  <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body style="margin:10px">

<div class="pageTitle">jComponents Documentation</div>

<h3>Table of Contents</h3>

<ol>
  <li><a href="#Installation">Installation</a></li>
  <li><a href="#new1_0">New in 1.0</a></li>
  <li><a href="#Introduction">Introduction</a></li>
  <li><a href="#skinning">Skinning - jComponentSkin</a></li>
  <li><a href="#Universal">Universal Attributes</a></li>
  <li><a href="#jTab">jTab</a></li>
  <li><a href="#jTree">jTree</a></li>
  <li><a href="#jAccordian">jAccordian</a></li>
  <li><a href="#jContainer">jContainer</a></li>
  <li><a href="#jsIntegration">JavaScript Integration</a></li>
</ol>

<a name="new1_0">
<h3>1. New in 1.0</h3>
<p>
<ul>
  <li>jTreeLink tag
  <li><font color="red"><strong>ICON attribute</strong></font> for jAccordianPane, jContainer, jTabItem, jTreeNode, and jTreeLink
  <li><font color="red"><strong>ICONCLOSED attribute</strong></font> for jAccordianPane, jContainer, jTabItem, jTreeNode, and jTreeLink
  <li><font color="red"><strong>JavaScript integration</strong></font> - <font color="red"><strong>events</strong></font> and component <font color="red"><strong>state polling / setting</strong></font>
  <li><font color="red"><strong>Percentage widths</strong></font> supported in all tags
  <li><font color="red"><strong>Percentage heights</strong></font> for jTree and jContainer
  <li><font color="red"><strong>Multiple Skin</strong></font> support
  <li>Simplified jAccordian height settings
  <li>Simplified / Clarified Attribute Inheiritance
</ul>
</p>

<a name="Installation">
<h3>2. Installation</h3>
<p>
If you're reading this, you've probably browsed to index.cfm.  If you've opened up doc.cfm, 
try browsing to index.cfm (included in this zip file).
</p>
<p>
Installation is simple:  Copy every file from the zip that starts with "j" to your custom tags
directory, or just put them in the same folder as the code you're going to be using them with.
</p>
<p>
If you ever need to make a new "skin," copy a jComponentSkin file into the same folder 
as the template calling the skin and edit away.
</p>

<a name="Introduction">
<h3>3. Introduction</h3>

<p>The jComponent set is a series of ColdFusion custom tags that emulate desktop-style interfaces
through the use of HTML, JavaScript, and CSS.</p>

<p>They've been created with developers in mind, but have followed the "everyman" tenet of ColdFusion:
anyone who's ever written anything in ColdFusion should be able to use them!</p>

<a name="skinning">
<h3>4. Skinning - jComponentSkin</h3>

<strong>How to turn skinning on:</strong>
<p>Put this line of code in your template before calling any of the jComponent custom tags:
<pre>
&lt;cf_jComponentSkin&gt;
</pre>
It's that easy!
</p>

<strong>How to edit the skin:</strong>
<p>The entire jComponent set can be "skinned" by editing the (unencrypted) jComponentSkin.cfm file.
Inside, you'll find documentation on what each setting does.</p>

<p>By editing this file, you'll be able to change every default attribute of all of the components 
you use, including, but not limited to, background colors, fonts, rollover colors, and borders.</p>

<strong>How to add additional skins:</strong>

<p>Copy / paste from the &lt;--- ADDITIONAL SKIN ---> to the &lt;--- /ADDITIONAL SKIN ---> comment in the 
jComponent skin file to just below itself.  Then, edit the &lt;cfset skinName="additionalSkin"> line 
in your new skin.  Last, change the values of the attributes in the new skin.  You're ready to go!</p>

<strong>How to use additional skins:</strong>

<p>Add SKIN="skinName", where skinName is your custom skin, to any jComponent tag that supports multiple skins.</p>

<p><em>For more help with using multiple skins, see the "Advanced Examples -> Skinning -> Using Multiple Skins"
demo included with jComponents.</em></p>

<a name="universal">
<h3>5. Universal Attributes</h3>

<p>Every tag in the jComponent is designed to have <strong>no</strong> required attributes.  This makes
it <strong>extremely easy</strong> to get working with the tags very quickly.<p>

<p>However, if you want to have more control over what you're creating, there are some basic attributes 
you'll want to be aware of that almost all of the tags you'll be using support.  Almost all of them can be controlled by using <a href="#skinning">component skinning</a>:
  <br/><br/>
  <strong>Font Attributes:</strong>
  <ul>
	<li>Font - The name of the font to use for labels.</li>
	<li>FontSize - The size of the font to use for labels (in px).</li>
	<li>Underline (True/False) - Should clickable labels be underlined?</li>
	<li>Bold (True/False) - Should clickable labels be bold?</li>
  </ul>
  <strong>"Title Bar" Attributes:</strong><br><br>
  "Title Bars" are the areas you click - the leaves of the tree, the titles of the accordian panes, etc.
  <ul>
	<li>TitleBgColor - Color (i.e. "FF0000", <strong>no # symbol!</strong>) of the background.</li>
	<li>TitleFgColor - Color (i.e. "FF0000", <strong>no # symbol!</strong>) of the text.</li>
	<li>RollOverBgColor - Color (i.e. "FF0000", <strong>no # symbol!</strong>) of the background when the mouse is over the bar.</li>
	<li>RollOverFgColor - Color (i.e. "FF0000", <strong>no # symbol!</strong>) of the text when the mouse is over the bar.</li>
	<li>Icon - (jAccordianPane, jContainer, jTabItem, jTreeNode, jTreeLink) defines the path to an image file for use as an icon to the left of the label similar to &lt;IMG SRC="" /&gt;.  If ICONCLOSED is also defined, this will switch to the iconClosed value when the item is in a closed state.
	<li>IconClosed - (jAccordianPane, jContainer, jTabItem, jTreeNode, jTreeLink) defines the path to an image file for use as an icon to the left of the label when the given item is closed, similar to &lt;IMG SRC="" /&gt;
  </ul>  

  <strong>General Layout Attributes:</strong><br><br>
  <ul>
	<li>Height - Height (in px) of the component. Note: jTree and jContainer will accept percentage.</li>
	<li>Width - Width (in px or percentage) of the component.</li>
	<li>BgColor - Color of the components's background.</li>
	<li>Border - Thickness of the components' border.</li>
	<li>BorderColor - Color (i.e. "FF0000", <strong>no # symbol!</strong>) of the component's border.</li>
	<li>BorderHighlight - Thickness of the 3-d "highlight" around the component's title bars.</li>
	<li>BorderHighlightColor - Color (i.e. "FF0000", <strong>no # symbol!</strong>) top and left 3-d "highlights".</li>
	<li>BorderLowlightColor - Color (i.e. "FF0000", <strong>no # symbol!</strong>) bottom and right 3-d "highlights".</li>
  </ul>  

  <strong>State and JavaScript Integration Attributes:</strong><br><br>
  <ul>
	<li><strong>Open</strong> - (true / false) (forgotten in original docs!) The OPEN attribute applies to jTabItem, jAccordianPane, jTreeNode, and jContainer, and controls its original state.</li>
	<li>Name - (valid JavaScript variable name) - used as a unique identifier for this component.  Applies to jTab, jTabItem, jAccordian, jAccordianPane, jContainer, and jTree.</li>
	<li>onChange - Name of a JavaScript function to call when state changes.  Applies to the base tags only (jTab, jAccordian, jTree, and jContainer).</li>
	<li>Data - Data stored by a jTreeNode or jTreeLink.</li>
  </ul>
</p>

<a name="jTab">
<h3>6. jTab</h3>

<p>jTab is used to quickly create tabbed interfaces, and can be aligned horizontally or vertically.</p>

<p>Tags involved: <em>cf_jTab, cf_jTabNavigation, cf_jTabItem, cf_jTabPane</em></p>

<p><strong>Quick Start Example:</strong>

<pre>
&lt;cf_jComponentSkin&gt;

&lt;cf_jTab width="200" height="150"&gt;
  &lt;cf_jTabNavigation&gt;
	&lt;cf_jTabItem label="One"&gt;
	&lt;cf_jTabItem label="Two" open="true"&gt;
	&lt;cf_jTabItem label="Three" icon="/images/demo.gif"&gt;
  &lt;/cf_jTabNavigation&gt;
  &lt;cf_jTabPane&gt;
	&lt;div style="padding:2px"&gt;Tab one content.&lt;/div&gt;
  &lt;/cf_jTabPane&gt;
  &lt;cf_jTabPane&gt;
	&lt;div style="padding:2px"&gt;Tab two content.&lt;/div&gt;
  &lt;/cf_jTabPane&gt;
  &lt;cf_jTabPane&gt;
	&lt;div style="padding:2px"&gt;Tab three content.&lt;/div&gt;
  &lt;/cf_jTabPane&gt;
&lt;/cf_jTab&gt;
</pre>

</p>

<p>
<strong>Explanation:</strong>
<pre>
<strong>Apply the jComponent skin.</strong>
&lt;cf_jComponentSkin&gt;

<strong>A jTab starts with a cf_jTab tag.</strong>
&lt;cf_jTab width="200" height="150"&gt;
  <strong>Then, you use cf_jTabNavigation to start defining tabs.</strong>
  &lt;cf_jTabNavigation&gt;
	<strong>Add a cf_jTabItem for each tab.</strong>
	&lt;cf_jTabItem label="One"&gt;
	<strong>Use open="true" to set the default tab.</strong>
	&lt;cf_jTabItem label="Two" open="true"&gt;
	<strong>Any tab can have an icon; let's use one called "demo" for the third tab.</strong>
	&lt;cf_jTabItem label="Three" icon="/images/demo.gif"&gt;
  <strong>When you're done adding tabs, close the cf_jTabNavigation.</strong>
  &lt;/cf_jTabNavigation&gt;


  <strong>You put your content inside of cf_jTabPane tags, in the same order as your cf_jTabItems.</strong>
  &lt;cf_jTabPane&gt;
	<strong>Simply place the content of the pane between the cf_jTabPane tags.</strong>
	&lt;div style="padding:2px"&gt;Tab one content.&lt;/div&gt;
  <strong>Just close each pane when you're done with its content.</strong>
  &lt;/cf_jTabPane&gt;
  &lt;cf_jTabPane&gt;
	&lt;div style="padding:2px"&gt;Tab two content.&lt;/div&gt;
  &lt;/cf_jTabPane&gt;
  &lt;cf_jTabPane&gt;
	&lt;div style="padding:2px"&gt;Tab three content.&lt;/div&gt;
  &lt;/cf_jTabPane&gt;
<strong>When you're done with your last pane, close the cf_jTab tag.</strong>
&lt;/cf_jTab&gt;
</pre>

<strong>Extra attributes for <strong>cf_jTab</strong>:</strong>
<ul>
  <li>Orientation (Horizontal/Vertical)  - Put the tabs on the top (vertical), or down the left side (horizontal)</li>
</ul>

<strong>Extra attributes for <strong>cf_jTabNavigation</strong>:</strong>
<ul>
  <li><em>None</em></li>
</ul>

<strong>Extra attributes for <strong>cf_jTabItem</strong>:</strong>
<ul>
  <li>Label - Text to be displayer on the tab.</li>
  <li>Open (True/False) - Is this the default tab.</li>
  <li>InactiveBgColor - Color (i.e. "FF0000", <strong>no # symbol!</strong>) of the tab's background when it's not active.</li>
  <li>InactiveFgColor - Color (i.e. "FF0000", <strong>no # symbol!</strong>) of the tab's text when it's not active.</li>
  <li>Icon - Defines an image file to use as an icon
</ul>

<a name="jTree">
<h3>7. jTree</h3>

<p>jTree is used to create trees that act like "explorer-style" interfaces.</p>

<p>Tags involved: <em>cf_jTree, cf_jTreeNode, cf_jTreeLink</em></p>

<p><strong>Quick Start Example:</strong>

<pre>
&lt;cf_jComponentSkin&gt;

&lt;cf_jTree height="250"&gt;
  &lt;cf_jTreeNode label="Node 1" open="true"&gt;
	&lt;cf_jTreeLink label="Link 1_1"&gt;
	&lt;cf_jTreeNode label="Node 1_1" open="true"&gt;
	  &lt;cf_jTreeLink label="Link 1_1_1" href="http://www.google.com"&gt;
	&lt;/cf_jTreeNode&gt;
	&lt;cf_jTreeNode label="Node 1_2" open="true"&gt;
	  &lt;cf_jTreeLink label="Link 1_2_1"&gt;
	  &lt;cf_jTreeLink label="Link 1_2_2"&gt;
	  &lt;cf_jTreeLink label="Link 1_2_3"&gt;
	&lt;/cf_jTreeNode&gt;
  &lt;/cf_jTreeNode&gt;
  &lt;cf_jTreeNode label="Node 2"&gt;
	&lt;cf_jTreeNode label="Node 2_1"&gt;
	  &lt;cf_jTreeLink label="Link 2_1_1"&gt;
	  &lt;cf_jTreeLink label="Link 2_1_2"&gt;
	  &lt;cf_jTreeLink label="Link 2_1_3"&gt;
	&lt;/cf_jTreeNode&gt;
  &lt;/cf_jTreeNode&gt;
</pre>

<p><strong>Explanation:</strong>

<pre>
<strong>Apply the jComponent skin.</strong>
&lt;cf_jComponentSkin&gt;

<strong>Create the tree with the cf_jTree tag.</strong>
&lt;cf_jTree height="250"&gt;
  <strong>Add a branch (or "node") with the cf_jTreeNode tag.</strong>
  &lt;cf_jTreeNode label="Node 1" open="true"&gt;
	<strong>You can put jTreeLinks, free-form content, links, images, or anything else inside 
	the node.  Here, we'll put a first put a jTreeLink:</strong>
	  &lt;cf_jTreeLink label="Link 1_1"&gt;
	<strong>And then we'll add another node inside!</strong>
	&lt;cf_jTreeNode label="Sub Node 1_1" open="true"&gt;
	  <strong>We can add things inside this new "sub-"node just like we did
	  in the first.</strong>
	  &lt;cf_jTreeLink label="Link 1_1_1"&gt;
	  &lt;cf_jTreeLink label="Link 1_1_2"&gt;
	  <strong>This one links to another page.</strong>
	  &lt;cf_jTreeLink label="Link 1_1_3" href="http://www.google.com"&gt;
	<strong>Close the sub-node</strong>
	&lt;/cf_jTreeNode&gt;
	<strong>Create another sub-node</strong>
	&lt;cf_jTreeNode label="Sub Node 1_2" open="true"&gt;
	  &lt;cf_jTreeLink label="Link 1_2_1"&gt;
	  &lt;cf_jTreeLink label="Link 1_2_2"&gt;
	  &lt;cf_jTreeLink label="Link 1_2_3"&gt;
	&lt;/cf_jTreeNode&gt;
  <strong>Close the first node</strong>
  &lt;/cf_jTreeNode&gt;
  <strong>Add another node (why not?)</strong>
  &lt;cf_jTreeNode label="Node 2"&gt;
	<strong>Give it a sub-node (see how easy this is?)</strong>
	&lt;cf_jTreeNode label="Sub Node 2_1"&gt;
	  &lt;cf_jTreeLink label="Link 2_2_1"&gt;
	  &lt;cf_jTreeLink label="Link 2_2_2"&gt;
	  &lt;cf_jTreeLink label="Link 2_2_3"&gt;
	&lt;/cf_jTreeNode&gt;
  <strong>Close the second node.</strong>
  &lt;/cf_jTreeNode&gt;
<strong>And close the tree!</strong>
&lt;/cf_jTree&gt;
</pre>

<strong>Extra attributes for <strong>cf_jTree</strong>:</strong>
<ul>
  <li><em>None</em></li>
</ul>

<strong>Extra attributes for <strong>cf_jTreeNode</strong>:</strong>
<ul>
  <li>Indent - How far, in pixels, to indent child items.</li>
  <li>Icon - Defines an image file to use as an icon
  <li>Data - defines the value returned by this jTree's getTree() function.  Defaults to the label value.
</ul>

<strong>Extra attributes for <strong>cf_jTreeLink</strong>:</strong>
<ul>
  <li>Indent - How far, in pixels, to indent child items.</li>
  <li>Icon - Defines an image file to use as an icon
  <li>Data - defines the value returned by this jTree's getTree() function.  Defaults to the label value.
</ul>

<a name="jAccordian">
<h3>8. jAccordian</h3>

<p>jAccordian is used to create vertically expanding/contracting palettes, menus, and whatever else you see fit.  It's basically a different take on the a tab interface, and sometimes allows more than one "tab" to be shown at once.</p>

<p>Tags involved: <em>cf_jAccordian, cf_jAccordianPane</em></p>

<p><strong>Quick Start Example:</strong>

<pre>
&lt;cf_jComponentSkin&gt;

&lt;cf_jAccordian bgColor="FFFFFF" height="300" width="200"&gt;
  &lt;cf_jAccordianPane label="One"&gt;
	Content for pane one.
  &lt;/cf_jAccordianPane&gt;
  &lt;cf_jAccordianPane label="Two" icon="images/demo.gif"&gt;
	Content for pane two.
  &lt;/cf_jAccordianPane&gt;
  &lt;cf_jAccordianPane label="Three"&gt;
	Content for pane three.
  &lt;/cf_jAccordianPane&gt;
&lt;/cf_jAccordian&gt;
</pre>

<p><strong>Explanation:</strong>

<pre>
<strong>Apply the jComponent skin.</strong>
&lt;cf_jComponentSkin&gt;

<strong>Create the jAccordian by using the cf_jAccordian tag.</strong>
&lt;cf_jAccordian bgColor="FFFFFF" height="300" width="200"&gt;
  <strong>Add panes to the jAccordian with the cf_jAccordianPane tag.</strong>
  &lt;cf_jAccordianPane label="One"&gt;
	<strong>Simply place the content of the pane between the cf_jAccordianPane tags.</strong>
	Content for pane one.
  <strong>Just close each pane when you're done with its content.</strong>
  &lt;/cf_jAccordianPane&gt;
  <strong>This pane deserves an icon.</strong>
  &lt;cf_jAccordianPane label="Two" icon="images/demo.gif"&gt;
	Content for pane two.
  &lt;/cf_jAccordianPane&gt;
  &lt;cf_jAccordianPane label="Three"&gt;
	Content for pane three.
  &lt;/cf_jAccordianPane&gt;
<strong>When you're done adding panes, close the cf_jAccordian tag.</strong>
&lt;/cf_jAccordian&gt;
</pre>

<strong>Extra attributes for <strong>cf_Accordian</strong>:</strong>
<ul>
  <li>Multiple (True/False) - Allow more than one pane to be open at once</li>
</ul>

<strong>Extra attributes for <strong>cf_AccordianPane</strong>:</strong>
<ul>
  <li>Height (True/False) - Explicitly give this pane a height, overriding the height set in the parent cf_jAccordian.</li>
  <li>Icon - Defines an image file to use as an icon
</ul>
</strong>

<a name="jContainer">
<h3>9. jContainer</h3>

<p>jContainer just creates a box with a title bar.  When the title bar is clicked, the content area either goes away or shows itself.</p>

<p>Tags involved: <em>cf_jContainer</em></p>

<p><strong>Quick Start Example:</strong>

<pre>
&lt;cf_jComponentSkin&gt;

&lt;cf_jContainer label="Container 1" icon="images/demo.gif"&gt;
  &lt;div style="padding:5px"&gt;
	Hi, I'm a jContainer.
  &lt;/div&gt;
&lt;/cf_jContainer&gt;
</pre>

<p><strong>Explanation:</strong>

<pre>
<strong>Apply the jComponent skin.</strong>
&lt;cf_jComponentSkin&gt;

<strong>Create the container with the cf_jContainer tag.  Giving it an icon is optional.</strong>
&lt;cf_jContainer label="Container 1" icon="images/demo.gif"&gt;
  <strong>Put whatever content you'd like inside of it.</strong>
  &lt;div style="padding:5px"&gt;
	Hi, I'm a jContainer.
  &lt;/div&gt;
<strong>Then close it.  Simple, no?</strong>
&lt;/cf_jContainer&gt;

</pre>

<strong>Extra attributes for <strong>cf_jContainer</strong>:</strong>
<ul>
  <li>Icon - Defines an image file to use as an icon
</ul>

<a name="jsIntegration">
<h3>10. JavaScript Integration</h3>

<p>Version 1.0 of the jComponents introduces JavaScript integration.
This allows for the creation of much richer interfaces, allowing you to trap events
from the components and get/set their current state.</p>

<h4>Trapping Events</h4>
<p>Each of the base tags (jTab, jTree, jAccordianPane, and jContainer) now support
an ONCHANGE attribute.  Simply put the name of a JavaScript function in this attribute,
and it'll call that function when state changes.</p>

<p><strong>Note</strong></p>
<p>Except for the tree, components call their onChange event when they're first rendered, as they now set their initial
state through JavaScript.</p>

<p><strong>Example</strong></p>
<p>This example will cause a popup to happen whenever a user changes the visible
pane of our jAccordian.</p>

<pre>
&lt;cf_jComponentSkin&gt;

&lt;script>
function myAccordianChanged() {
  alert('You changed the accordian!');
}
&lt;/script>
&lt;cf_jAccordian bgColor="FFFFFF" height="300" width="200" onChange="myAccordianChanged"&gt;
  &lt;cf_jAccordianPane label="One"&gt;
	Content for pane one.
  &lt;/cf_jAccordianPane&gt;
  &lt;cf_jAccordianPane label="Two" icon="images/demo.gif"&gt;
	Content for pane two.
  &lt;/cf_jAccordianPane&gt;
  &lt;cf_jAccordianPane label="Three"&gt;
	Content for pane three.
  &lt;/cf_jAccordianPane&gt;
&lt;/cf_jAccordian&gt;


</pre>

<h4>Polling State</h4>
<p>You can ask any jComponent what its current "state" is.  This means that you can find
out what tab / pane is selected, what tree node has been clicked, or whether a jContainer
is open or closed.</p>
<p>Combining this with an onChanged function can be very powerful.</p>
<p>To do this, add the NAME attribute to a base tag, then call jComponents.getComponent("<em>name</em>").</p>
<p>This function will return the entire component's object to you.  Feel free to explore what it contains, but
the most relevant members are the following:
<ul>
  <li>jTab / jAccordian - <em>componentObject</em>.selectedIndex : Integer : what tab or pane is selected.  To maintain consistency with other JavaScript interactions, 0 = the first tab/pane.</li>
  <li>jTree - <em>componentObject</em>.data : String : the data (defaults to same value as label) of the node just clicked.</li>
  <li>jContainer - <em>componentObject</em> : Boolean : is the container open or closed?
</ul>
</p>

<b>Tab Example:</b>

<pre>
&lt;script>
function myTabChanged() {
  var myTab = jComponents.getComponent("myTab");
  alert("Selected tab index: " + myTab.selectedIndex);
}
&lt;/script>

&lt;cf_jComponentSkin&gt;

&lt;cf_jTab width="200" height="150" name="myTab" onChange="myTabChanged"&gt;
  &lt;cf_jTabNavigation&gt;
	&lt;cf_jTabItem label="One"&gt;
	&lt;cf_jTabItem label="Two" open="true"&gt;
	&lt;cf_jTabItem label="Three" icon="/images/demo.gif"&gt;
  &lt;/cf_jTabNavigation&gt;
  &lt;cf_jTabPane&gt;
	&lt;div style="padding:2px"&gt;Tab one content.&lt;/div&gt;
  &lt;/cf_jTabPane&gt;
  &lt;cf_jTabPane&gt;
	&lt;div style="padding:2px"&gt;Tab two content.&lt;/div&gt;
  &lt;/cf_jTabPane&gt;
  &lt;cf_jTabPane&gt;
	&lt;div style="padding:2px"&gt;Tab three content.&lt;/div&gt;
  &lt;/cf_jTabPane&gt;
&lt;/cf_jTab&gt;
</pre>

<b>Pane Example:</b>

<pre>
&lt;script>
function myAccordianChanged() {
  var myAccordian = jComponents.getComponent("myAccordian");
  alert("Selected pane index: " + myAccordian.selectedIndex);
}
&lt;/script>

&lt;cf_jComponentSkin&gt;

&lt;cf_jAccordian bgColor="FFFFFF" height="300" width="200" name="myAccordian" onChange="myAccordianChanged"&gt;
  &lt;cf_jAccordianPane label="One"&gt;
	Content for pane one.
  &lt;/cf_jAccordianPane&gt;
  &lt;cf_jAccordianPane label="Two" icon="images/demo.gif"&gt;
	Content for pane two.
  &lt;/cf_jAccordianPane&gt;
  &lt;cf_jAccordianPane label="Three"&gt;
	Content for pane three.
  &lt;/cf_jAccordianPane&gt;
&lt;/cf_jAccordian&gt;
</pre>

<b>Tree Example:</b>
<pre>
&lt;script>
function myTreeChanged() {
  var myTree = jComponents.getComponent("myTree");
  alert("Open nodes array: " + myAccordian.openNodes);
  alert("Tree data: " + myTree.data);
}
&lt;/script>

&lt;cf_jComponentSkin&gt;

&lt;cf_jTree height="250" name="myTree" onChange="myTreeChanged"&gt;
  &lt;cf_jTreeNode label="Node 1" open="true"&gt;
	&lt;cf_jTreeNode label="Node 1_1" open="true"&gt;
	  &lt;cf_jTreeLink label="Link 1_1_1"&gt;
	  &lt;cf_jTreeLink label="Link 1_1_2"&gt;
	  &lt;cf_jTreeLink label="Link 1_1_3"&gt;
	&lt;/cf_jTreeNode&gt;
	&lt;cf_jTreeNode label="Node 1_2" open="true"&gt;
	  &lt;cf_jTreeLink label="Link 1_2_1"&gt;
	  &lt;cf_jTreeLink label="Link 1_2_2"&gt;
	  &lt;cf_jTreeLink label="Link 1_2_2"&gt;
	&lt;/cf_jTreeNode&gt;
  &lt;/cf_jTreeNode&gt;
  &lt;cf_jTreeNode label="Node 2"&gt;
	&lt;cf_jTreeNode label="Node 2_1"&gt;
	  &lt;cf_jTreeLink label="Link 2_1_1"&gt;
	&lt;/cf_jTreeNode&gt;
  &lt;/cf_jTreeNode&gt;
  &lt;cf_jTreeNode label="Other Sites"&gt;
	&lt;cf_jTreeNode label="Search Engines"&gt;
	  &lt;cf_jTreeLink label="Google" href="http://www.google.com"&gt;
	&lt;/cf_jTreeNode&gt;
  &lt;/cf_jTreeNode&gt;
&lt;/cf_jTree&gt;
</pre>


<b>Container Example:</b>
<pre>
&lt;script>
function myContainerChanged() {
  var myContainer = jComponents.getComponent("myContainer");
  alert("Container open: " + myContainer.isOpen);
}
&lt;/script>

&lt;cf_jComponentSkin&gt;

&lt;cf_jContainer label="Container 1" name="myContainer" onChange="myContainerChanged"&gt;
  &lt;div style="padding:5px"&gt;
	Hi, I'm a jContainer.
  &lt;/div&gt;
&lt;/cf_jContainer&gt;
</pre>
</body>
</html>
