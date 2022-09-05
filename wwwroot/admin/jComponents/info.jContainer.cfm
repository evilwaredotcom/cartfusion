<link rel="stylesheet" type="text/css" href="styles.css">
<cf_jComponentSkin>
<body>

<div class="pageTitle">jContainer Tag</div>
<table cellpadding="0" cellspacing="0" border="0">
<tr>
  <td><p>jContainer provides a "window" that hides/shows its content when the title bar is clicked. It can be used like an "independent" accordian pane, or nested to create complex layouts.</p></td>
</tr>
<tr>
  <td>
	<cf_jAccordian bgColor="FFFFFF" width="99%">
	  <cf_jAccordianPane label="jContainer Demo" height="340">
		<div style="padding:20px">
		  <cf_jContainer label="Container 1" name="Container1" width="75%" height="50">
			<div style="padding:5px">
			  Hi, I'm a jContainer using percentage widths.
			</div>
		  </cf_jContainer>
		  <br/>
		  <cf_jContainer label="Container 2" name="Container2" height="50"  width="200" icon="home.gif">
			<div style="padding:5px">
			  Hi, I'm a another jContainer.  Click the title bar of the first
			  to check out how we stack!
			  <br/><br/>
			  <cf_jContainer label="Container 2_1" width="90%" name="Container2_1" height="50">
				<div style="padding:5px">
				  Hi, I'm a jContainer inside a jContainer.
				</div>
			  </cf_jContainer>
			</div>
		  </cf_jContainer>
		</div>
	  </cf_jAccordianPane>
	  <cf_jAccordianPane label="jContainer Demo Source Code" height="340">
<pre>
&lt;cf_jContainer label="Container 1"&gt;
  &lt;div style="padding:5px"&gt;
	Hi, I'm a jContainer.
  &lt;/div&gt;
&lt;/cf_jContainer&gt;
&lt;br /&gt;
&lt;cf_jContainer label="Container 2" icon="demo.gif"&gt;
  &lt;div style="padding:5px"&gt;
	Hi, I'm a another jContainer.  Click the title 
	bar of the first to check out how we stack!
	&lt;br /&gt;&lt;br /&gt;
	&lt;cf_jContainer label="Container 2_1" width="90%" icon="demo.gif"&gt;
	  &lt;div style="padding:5px"&gt;
		Hi, I'm a jContainer inside a jContainer.
	  &lt;/div&gt;
	&lt;/cf_jContainer&gt;
  &lt;/div&gt;
&lt;/cf_jContainer>
</pre>	  
	  </cf_jAccordianPane>
	</cf_jAccordian>
  </td>
</tr>
</table>
</body>
