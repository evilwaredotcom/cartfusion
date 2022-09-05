<link rel="stylesheet" type="text/css" href="styles.css">
<script src="events.js"></script>

<cf_jComponentSkin>
<body>

<div class="pageTitle">jAccordian Tag</div>
<table cellpadding="0" cellspacing="0" border="0">
<tr>
  <td colspan="3"><p>By vertically-oriented expanding and contracting "panes," the jAccordian tag can be used to create menus, multi-step forms, clusters of controls, or anything else you see fit!</p><br></td>
</tr>
<tr>
  <td>
	<cf_jAccordian bgColor="FFFFFF" width="99%" height="300">
	  <cf_jAccordianPane label="Default jAccordian Demo" open="true">
		<div style="padding:20px">
		<cf_jAccordian bgColor="FFFFFF" width="200" height="50" name="accDemo" onChange="accDemoChanged">
		  <cf_jAccordianPane label="One" icon="demo.gif">
			Content for pane one!
		  </cf_jAccordianPane>
		  <cf_jAccordianPane label="Two">
			Content for pane two.
		  </cf_jAccordianPane>
		  <cf_jAccordianPane label="Three">
			Content for pane three.
		  </cf_jAccordianPane>
		</cf_jAccordian>
		</div>
	  </cf_jAccordianPane>
	  <cf_jAccordianPane label="Default jAccordian Demo Source Code">
<pre>
&lt;cf_jAccordian bgColor="FFFFFF" width="200"&gt;
  &lt;cf_jAccordianPane label="One" icon="demo.gif"&gt;
	Content for pane one.
  &lt;/cf_jAccordianPane&gt;
  &lt;cf_jAccordianPane label="Two"&gt;
	Content for pane two.
  &lt;/cf_jAccordianPane&gt;
  &lt;cf_jAccordianPane label="Three"&gt;
	Content for pane three.
  &lt;/cf_jAccordianPane&gt;
&lt;/cf_jAccordian&gt;
</pre>
	  </cf_jAccordianPane>
	  <cf_jAccordianPane label="jAccordian MULTIPLE=""TRUE"" Demo">
		<div style="padding:20px">
		In this demo, more than one pane can be opened at a time.<br><br>
		<cf_jAccordian bgColor="FFFFFF" width="200" multiple="true" name="acc2Demo" onChange="acc2DemoChanged">
		  <cf_jAccordianPane label="One" active="true">
			Content for pane one.
		  </cf_jAccordianPane>
		  <cf_jAccordianPane label="Two" active="true">
			Content for pane two.
		  </cf_jAccordianPane>
		  <cf_jAccordianPane label="Three">
			Content for pane three.
		  </cf_jAccordianPane>
		</cf_jAccordian>
		</div>
	  </cf_jAccordianPane>
	  <cf_jAccordianPane label="jAccordian MULTIPLE=""TRUE"" Demo Source Code">
<pre>
&lt;cf_jAccordian bgColor="FFFFFF" 
  width="200" 
  multiple="true"&gt;
  &lt;cf_jAccordianPane label="One"&gt;
	Content for pane one.
  &lt;/cf_jAccordianPane&gt;
  &lt;cf_jAccordianPane label="Two"&gt;
	Content for pane two.
  &lt;/cf_jAccordianPane&gt;
  &lt;cf_jAccordianPane label="Three"&gt;
	Content for pane three.
  &lt;/cf_jAccordianPane&gt;
&lt;/cf_jAccordian&gt;
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