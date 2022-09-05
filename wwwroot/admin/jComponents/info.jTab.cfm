<link rel="stylesheet" type="text/css" href="styles.css">
<script src="events.js"></script>

<cf_jComponentSkin>

<body>
<div class="pageTitle">jTab Tag</div>
<table cellpadding="0" cellspacing="0" border="0">
<tr>
  <td colspan="3"><p>The jTab tag is used to quickly create tabbed interfaces.  In can generate both horizontally and vertically aligned interfaces, so you quickly make multi-step interfaces without needing page reloads.</p><br></td>
</tr>
<tr>
  <td>
	<cf_jAccordian bgColor="FFFFFF" width="99%">
	  <cf_jAccordianPane label=" Horizontal jTab Demo" height="300">
		<div style="padding:20px">
		<cf_jTab width="300" height="150" name="tabDemo" onChange="tabDemoChanged">
		  <cf_jTabNavigation>
			<cf_jTabItem label="One" icon="demo.gif" iconClosed="home.gif">
			<cf_jTabItem label="Two">
			<cf_jTabItem label="Three">
		  </cf_jTabNavigation>
		  <cf_jTabPane>
			<div style="padding:2px">Tab one content.</div>
		  </cf_jTabPane>
		  <cf_jTabPane>
			<div style="padding:2px">Tab two content.</div>
		  </cf_jTabPane>
		  <cf_jTabPane>
			<div style="padding:2px">Tab three content.</div>
		  </cf_jTabPane>
		</cf_jTab>
		</div>
	  </cf_jAccordianPane>
	  <cf_jAccordianPane label=" Horizontal jTab Demo Source Code" height="300">
<pre>
&lt;cf_jTab width="300" height="150"&gt;
  &lt;cf_jTabNavigation&gt;
	&lt;cf_jTabItem label="One" icon="demo.gif" iconClosed="home.gif"&gt;
	&lt;cf_jTabItem label="Two"&gt;
	&lt;cf_jTabItem label="Three"&gt;
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
	  </cf_jAccordianPane>
	  <cf_jAccordianPane label=" Vertical jTab Demo" height="300">
		<div style="padding:20px">
		<cf_jTab width="200" height="150" orientation="vertical" name="tab2Demo" onChange="tab2DemoChanged">
		  <cf_jTabNavigation>
			<cf_jTabItem label="One" icon="demo.gif">
			<cf_jTabItem label="Two">
			<cf_jTabItem label="Three">
		  </cf_jTabNavigation>
		  <cf_jTabPane>
			<div style="padding:2px">Tab one content.</div>
		  </cf_jTabPane>
		  <cf_jTabPane>
			<div style="padding:2px">Tab two content.</div>
		  </cf_jTabPane>
		  <cf_jTabPane>
			<div style="padding:2px">Tab three content.</div>
		  </cf_jTabPane>
		</cf_jTab>
		</div>
	  </cf_jAccordianPane>
	  <cf_jAccordianPane label=" Vertical jTab Demo Source Code" height="300">
<pre>
&lt;cf_jTab width="200" 
			height="150" 
			orientation="vertical"&gt;
  &lt;cf_jTabNavigation&gt;
	&lt;cf_jTabItem label="One" icon="demo.gif"&gt;
	&lt;cf_jTabItem label="Two"&gt;
	&lt;cf_jTabItem label="Three"&gt;
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
