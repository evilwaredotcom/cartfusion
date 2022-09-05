<script language="JavaScript" type="text/javascript">
var strCode = new Array("000000","000000","000000","000000","003300","006600","009900","00CC00","00FF00","330000","333300","336600","339900","33CC00","33FF00","660000","663300","666600","669900","66CC00","66FF00",
"000000","333333","000000","000033","003333","006633","009933","00CC33","00FF33","330033","333333","336633","339933","33CC33","33FF33","660033","663333","666633","669933","66CC33","66FF33",
"000000","666666","000000","000066","003366","006666","009966","00CC66","00FF66","330066","333366","336666","339966","33CC66","33FF66","660066","663366","666666","669966","66CC66","66FF66",
"000000","999999","000000","000099","003399","006699","009999","00CC99","00FF99","330099","333399","336699","339999","33CC99","33FF99","660099","663399","666699","669999","66CC99","66FF99",
"000000","CCCCCC","000000","0000CC","0033CC","0066CC","0099CC","00CCCC","00FFCC","3300CC","3333CC","3366CC","3399CC","33CCCC","33FFCC","6600CC","6633CC","6666CC","6699CC","66CCCC","66FFCC",
"000000","FFFFFF","000000","0000FF","0033FF","0066FF","0099FF","00CCFF","00FFFF","3300FF","3333FF","3366FF","3399FF","33CCFF","33FFFF","6600FF","6633FF","6666FF","6699FF","66CCFF","66FFFF",
"000000","FF0000","000000","990000","993300","996600","999900","99CC00","99FF00","CC0000","CC3300","CC6600","CC9900","CCCC00","CCFF00","FF0000","FF3300","FF6600","FF9900","FFCC00","FFFF00",
"000000","00FF00","000000","990033","993333","996633","999933","99CC33","99FF33","CC0033","CC3333","CC6633","CC9933","CCCC33","CCFF33","FF0033","FF3333","FF6633","FF9933","FFCC33","FFFF33",
"000000","0000FF","000000","990066","993366","996666","999966","99CC66","99FF66","CC0066","CC3366","CC6666","CC9966","CCCC66","CCFF66","FF0066","FF3366","FF6666","FF9966","FFCC66","FFFF66",
"000000","FFFF00","000000","990099","993399","996699","999999","99CC99","99FF99","CC0099","CC3399","CC6699","CC9999","CCCC99","CCFF99","FF0099","FF3399","FF6699","FF9999","FFCC99","FFFF99",
"000000","00FFFF","000000","9900CC","9933CC","9966CC","9999CC","99CCCC","99FFCC","CC00CC","CC33CC","CC66CC","CC99CC","CCCCCC","CCFFCC","FF00CC","FF33CC","FF66CC","FF99CC","FFCCCC","FFFFCC",
"000000","FF00FF","000000","9900FF","9933FF","9966FF","9999FF","99CCFF","99FFFF","CC00FF","CC33FF","CC66FF","CC99FF","CCCCFF","CCFFFF","FF00FF","FF33FF","FF66FF","FF99FF","FFCCFF","FFFFFF")

var showPound<cfoutput>#val(attributes.elementnumber)#</cfoutput> = '<cfif attributes.hex eq "yes">#<cfelse></cfif>';

function newColor<cfoutput>#val(attributes.elementnumber)#</cfoutput>(hexcolor){
	var	newColor = hexcolor	 
	document.<cfoutput>#JSStringFormat(attributes.formname)#</cfoutput>.<cfoutput>#JSStringFormat(attributes.textfieldname)#</cfoutput>.value = showPound<cfoutput>#val(attributes.elementnumber)#</cfoutput> + hexcolor
	if(document.all){
		document.all.showcolor<cfoutput>#val(attributes.elementnumber)#</cfoutput>.style.backgroundColor = hexcolor
		document.all.colorpicker<cfoutput>#val(attributes.elementnumber)#</cfoutput>.style.backgroundColor = hexcolor
		}
	else if(document.layers){
		document.showcolor<cfoutput>#val(attributes.elementnumber)#</cfoutput>.backgroundColor = hexcolor
		document.colorpicker<cfoutput>#val(attributes.elementnumber)#</cfoutput>.backgroundColor = hexcolor
		}
}
function clearColor<cfoutput>#val(attributes.elementnumber)#</cfoutput>(hexcolor){
	var	newColor = hexcolor	 
	document.<cfoutput>#JSStringFormat(attributes.formname)#</cfoutput>.<cfoutput>#JSStringFormat(attributes.textfieldname)#</cfoutput>.value = ''
	if(document.all){
		document.all.colorpicker<cfoutput>#val(attributes.elementnumber)#</cfoutput>.style.backgroundColor = ''
		}
	else if(document.layers){
		document.colorpicker<cfoutput>#val(attributes.elementnumber)#</cfoutput>.backgroundColor = ''
		}
}
//-->
</script>
<script language="JavaScript" type="text/JavaScript">
<!--
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
	document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
	d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_showHideLayers() { //v6.0
  var i,p,v,obj,args=MM_showHideLayers.arguments;
  for (i=0; i<(args.length-2); i+=3) if ((obj=MM_findObj(args[i]))!=null) { v=args[i+2];
	if (obj.style) { obj=obj.style; v=(v=='show')?'visible':(v=='hide')?'hidden':v; }
	obj.visibility=v; }
}
//-->
</script>
<style type="text/css">
<!--
.colorpicker {
	cursor: hand;
	font-family: Arial, Verdana, Helvetica, sans-serif;
	font-size: 8px;
}
-->
</style>

<input name="<cfoutput>#attributes.textfieldname#" type="text" value="<cfif attributes.hex eq "yes">##</cfif>#attributes.textfielddefault#</cfoutput>" size="9" maxlength="9" class="cfAdminDefault">
<div id="colorpicker<cfoutput>#val(attributes.elementnumber)#</cfoutput>" style="position:absolute; width:18; height:19; visibility: visible; background-color: <cfoutput>#attributes.textfielddefault#</cfoutput>; layer-background-color: <cfoutput>#attributes.textfielddefault#</cfoutput>; border: 1px none #000000; z-index: 98;"><a href="javascript:void(0)" onClick="MM_showHideLayers(<cfif isDefined("attributes.hideformelement") and len(attributes.hideformelement)>'<cfoutput>#attributes.hideformelement#</cfoutput>','','hide',</cfif>'colorchart<cfoutput>#val(attributes.elementnumber)#</cfoutput>','','show')">
<cfif attributes.ezColorPickerIcon eq "yes"><img src="images/ezcolorpicker/ezcolorpickertool.gif" width="18" height="19" border="0"><cfelse><img src="images/ezcolorpicker/trans.gif" width="18" height="19" border="0"></cfif></a></div>
<div id="colorchart<cfoutput>#val(attributes.elementnumber)#</cfoutput>" style="position:absolute; width:200px; height:115px; visibility: hidden; z-index: 99;" class="colorpicker"> 
  <table border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="000000">
	<tr> 
	  <td style="background-color:##CCCCCC;">
	  <table width="100%" height="25" border="0" cellpadding="0" cellspacing="0">
  <tr> 
	<td height="1" colspan="5" bgcolor="#000000" class="colorpicker"><img src="images/ezcolorpicker/trans.gif" width="1" height="1"></td>
  </tr>
  <tr> 
	<td width="1" bgcolor="#000000" class="colorpicker"><img src="images/ezcolorpicker/trans.gif" width="1" height="1"></td>
	<td class="colorpicker"><a href="javascript:void(0)" onMouseOut="clearColor<cfoutput>#val(attributes.elementnumber)#</cfoutput>('')" onClick="MM_showHideLayers(<cfif isDefined("attributes.hideformelement") and len(attributes.hideformelement)>'<cfoutput>#attributes.hideformelement#</cfoutput>','','show',</cfif>'colorpicker<cfoutput>#val(attributes.elementnumber)#</cfoutput>','','show','colorchart<cfoutput>#val(attributes.elementnumber)#</cfoutput>','','hide')"><cfif attributes.ezColorPickerIcon eq "yes"><img src="images/ezcolorpicker/ezcolorpickertool.gif" alt="Close" width="18" height="19" border="0"><cfelse><img src="images/ezcolorpicker/trans.gif" width="18" height="18" border="0" alt="close"></cfif></a></td>
	<td class="colorpicker"><div align="center"> 
		<div id="showcolor<cfoutput>#val(attributes.elementnumber)#</cfoutput>" style="position:absolute; width: 79; height: 23; visibility: inherit; z-index: 1; left: 91px; top: 2px;" align="center"> 
		  <table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr> 
			  <td width="1" rowspan="3" bgcolor="#000000"><img src="images/ezcolorpicker/trans.gif" width="1" height="1"></td>
			  <td height="1" bgcolor="#000000"><img src="images/ezcolorpicker/trans.gif" width="1" height="1"></td>
			  <td width="1" rowspan="3" bgcolor="#000000"><img src="images/ezcolorpicker/trans.gif" width="1" height="1"></td>
			</tr>
			<tr> 
			  <td><img src="images/ezcolorpicker/trans.gif" width="73" height="21"></td>
			</tr>
			<tr> 
			  <td height="1" bgcolor="#000000"><img src="images/ezcolorpicker/trans.gif" width="1" height="1"></td>
			</tr>
		  </table>
		</div>
	  </div></td>
	<td class="colorpicker"><div align="right"><a href="javascript:void(0)" onMouseOut="clearColor<cfoutput>#val(attributes.elementnumber)#</cfoutput>('')" onClick="MM_showHideLayers(<cfif isDefined("attributes.hideformelement") and len(attributes.hideformelement)>'<cfoutput>#attributes.hideformelement#</cfoutput>','','show',</cfif>'colorpicker<cfoutput>#val(attributes.elementnumber)#</cfoutput>','','show','colorchart<cfoutput>#val(attributes.elementnumber)#</cfoutput>','','hide')">close</a>&nbsp;</div></td>
	<td width="1" bgcolor="#000000" class="colorpicker"><img src="images/ezcolorpicker/trans.gif" width="1" height="1"></td>
  </tr>
</table></td>
	</tr>
	<tr> 
	  <td><script language="JavaScript">
			var cc=0;
			document.write("<table  border='0' align='center' cellpadding='1' cellspacing='1'>");
	
			//start table row
			for (var i=0; i < 12; i++) {
			document.write("<tr>")
	
			//create tale cell
			for (var td=0; td < 21; td++) { 
			var tableCell="<td bgcolor=" + strCode[cc] + "><a href='javascript:void(0)' onMouseOut=newColor<cfoutput>#val(attributes.elementnumber)#</cfoutput>('" + strCode[cc] + "') onClick=MM_showHideLayers(<cfif isDefined("attributes.hideformelement") and len(attributes.hideformelement)>'<cfoutput>#attributes.hideformelement#</cfoutput>','','show',</cfif>'colorpicker<cfoutput>#val(attributes.elementnumber)#</cfoutput>','','show','colorchart<cfoutput>#val(attributes.elementnumber)#</cfoutput>','','hide')><img src='trans.gif' width='10' height='10' border='0'></a></td>"
				document.write(tableCell);
				cc++;
			}
			document.write("</tr>")
			}
			document.write('</table>')
		</script></td>
	</tr>
  </table>
</div>