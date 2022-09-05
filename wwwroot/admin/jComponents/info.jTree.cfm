<link rel="stylesheet" type="text/css" href="styles.css">
<script src="events.js"></script>

<cf_jComponentSkin>
<body>
<div class="pageTitle">jTree Tag</div>
<table cellpadding="0" cellspacing="0" border="0">
<tr>
  <td colspan="3"><p>jTree and its child tag, jTreeNode, can be used to quickly create expanding/shrinking trees controls.  They're intentionally void of graphics so that you can create whatever look you want.</p><br></td>
</tr>
<tr>
  <td>
	<cf_jAccordian bgColor="FFFFFF" width="99%" skin="default" height="342">
	  <cf_jAccordianPane label="jTree Demo">
		<div style="padding:20px">
		<cf_jTree height="250" name="treeDemo" onChange="treeDemoChanged">
		  <cf_jTreeNode label="Node 1" open="true">
			<cf_jTreeNode label="Node 1_1" open="true">
			  <cf_jTreeLink label="Link 1_1_1">
			  <cf_jTreeLink label="Link 1_1_2">
			  <cf_jTreeLink label="Link 1_1_3">
			</cf_jTreeNode>
			<cf_jTreeNode label="Node 1_2" open="true">
			  <cf_jTreeLink label="Link 1_2_1">
			  <cf_jTreeLink label="Link 1_2_2">
			  <cf_jTreeLink label="Link 1_2_3">
			</cf_jTreeNode>
		  </cf_jTreeNode>
		  <cf_jTreeNode label="Node 2">
			<cf_jTreeNode label="Node 2_1">
			  <cf_jTreeLink label="Link 2_1_1">
			</cf_jTreeNode>
		  </cf_jTreeNode>
		  <cf_jTreeNode label="Other Sites">
			<cf_jTreeNode label="Search Engines">
			  <cf_jTreeLink label="Google" href="http://www.google.com">
			</cf_jTreeNode>
		  </cf_jTreeNode>
		</cf_jTree>
		</div>
	  </cf_jAccordianPane>
	  <cf_jAccordianPane label="jTree Demo Source Code">
<pre>
&lt;cf_jTree height="250"&gt;
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
	  </cf_jAccordianPane>
	</cf_jAccordian>
  </td>
  <td width="5%">&nbsp;</td>
  <td width="20%" valign="top">
	<cf_jTab width="100%" bgcolor="FFFFFF" height="200">
	  <cf_jTabNavigation>
		<cf_jTabItem label="Last Event" open="true">
	  </cf_jTabNavigation>
	  <cf_jTabPane>
		<textarea style="width:100%;height:300px;border:0px #AEAEAE Solid;padding:4px" id="events"></textarea>
	  </cf_jTabPane>
	</cf_jtab>  
  </td>
</tr>
</table>
</body>
