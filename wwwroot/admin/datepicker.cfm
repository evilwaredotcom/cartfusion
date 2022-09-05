<!--- *********************************************************************************
cf_datepicker  - Custom Tag 

Description: Inserts a textbox and an optional image into your form. When you 
			 click on the image a calendar layer drops down (like on expedia.com) that 
			 allows the user to select a date. The selected date is then transfered to 
			 the textbox. You can click from month to month and from year to year without 
			 refreshing the browser. Several different date formats are supported as 
			 well as localization in English, Spanish and German.  

Copyright: (c) 2001 sconklin.com all rights reserved.

Author/History:
Date			Author			 version	   contact   
---------------------------------------------------------------------------------
2002.03.15	  Scott Conklin	  v1.0.1		scott@sconklin.com 
---------------------------------------------------------------------------------

License information: 
---------------------
	Shareware - $10.00 If you like this tag and want to use it, then please go to my site at
			  http://www.sconklin.com/default.cfm?fuseaction=software.dsp_datepickerex 
			  and click on the PayPal icon to make a small payment of $10.00. You will then
			  be able to download the unencrypted version.
	
Required Fields																																		
---------------
	textboxname:			The name of the textbox which the tag creates. do not pass 
								  the name of an existing textbox.
	formname:				  The name of the form that will contain the textbox control
  first_use_on_page:  (default = no) must be set to yes if :
						 1) the tag is called only once on a page	
			  					 2) or is the first of multipe usages on a page.

						 
Optional Fields																																		
---------------
	initialvalue: The initial date as it appears in the textbox of the form on page load.
				Supported date delimeters are "/" and "-". Curently only numerical formats
				are supported. You may use d, m, y to build date format strings and 
				should match the mask that is specified in the "dateformat" attribute. 
				default: todays date in the form of mm/dd/yyyy. valid entries include 
				numerical date values in the form of: 
				dd/mm/yy, d/m/yy, dd/mm/yyyy, mm/dd/yyyy, m/d/yy, yyyy/mm/dd, yy/mm/dd
				etc..
  
  image:  An image to be used as the click area to trigger the dropdown the calendar. if 
		  omitted, then an outlined div area is inserted to represent click area. 
  
  backcolor: Sets the backgroundcolor of the calendar (layer) Hexadeciaml color values.	
			 default: white

  hidedivname: the name of a div that you must define on the page where the datepicker is
			   called. This div should surround all of the controls where the "floating-above"
			   clipping problem is occuring. The datepicker will hide the div 
			   (and all of it's contents) while it is visible and will again make it visible when it 
			   is closed.
	   

  displayorientation: Defines the orientation in respect to the textbox of how the datepicker is displayed.
  					  values are left and right. Default is right  	
			 
 *** the following display attributes can only be set when first_use_on_page = yes.
	 In other words, these values set the look and feel for ALL instances of the tag on the
	 same page. The javascript is shared amongst these instances and subsequent usage of 
	 these attributes in other calls to the tag are ignored. see sample usage ex.
	 
 dateorder:	 Specifies the date mask of the date returned to the textbox. 
				Common delimeters are "/" and "-", but is optional. Curently only numerical formats
				are supported. You may you use d, m, y to represent the day, month and year
				in any of the following combinations with 1 or 2 digits for the day and month 
				and 2 or 4 digits for the year:
				mmddyy, d-m-yy, yy/mm/dd, 
				Default: mm/dd/yyyy.
  
  font:		 Sets the font for the text. default: Verdanna,Geneva,Arial,Helvetica,sans-serif
  
  fontcolor:	Sets the font color for the font in the font parameter. Hexadeciaml color values. 
				default: black
				
  dayheadercolor: Sets the font color for days of the week abbreviations. (su, mo, ...etc.) 
				  Hexadeciaml color values. default: #4F4FFB
				  
  monthcolor: Sets the cell color of the current month Hexadeciaml color values.	
			  default: #EFEFEF
			  
  othermonthscolor: Sets the cell color of the previous and next months. Hexadeciaml color values.	
					default: #COCOCO
  
  selecteddaycolor: Sets the cell color of the selected/current date. Hexadeciaml color values. 
					default: #FFFFF0

  language:  Sets the language. german, english, spanish are valid values.
					default: english
					
			  
   
Output																																		
---------------
	  outputs a textbox and an optional image into your form. When you click on the 
 			image a scrollable calendar layer drops down.  The tag enters the selected
	  date into the textbox.

Sample Usage (output): 
-----------------
  simple:
  
   header color: <cf_datepicker textboxname="txtdate" formname="form1" first_use_on_page="yes">
   <p>
   footer color: <cf_datepicker textboxname="txtdate2" formname="form1">
   <p>
 
  with display atrributes:
 
   Date 1: <cf_datepicker textboxname="txtcolor2" formname="frm1" image="./software/arrow_down.gif"
				 font="arial" fontcolor="gray" dayheadercolor="990000" monthcolor="81C0EF" 
				 othermonthscolor="white" backcolor="EFEFEF" first_use_on_page="yes" > 
				 
   Date 2:   <cf_datepicker textboxname="txtcolor" formname="frm1" dayheadercolor="999933" >			   

   ** in the above example, the dayheadercolor attr set to verdanna is ignored  
********************************************************************************* --->

<!-----------------------------
  default variables
------------------------------>
<cfset tagname = "cf_datepicker">
<cfparam name="attributes.first_use_on_page" default="no">
<cfparam name="attributes.label" default="">
<cfparam name="attributes.font" default="Verdanna,Geneva,Arial,Helvetica,sans-serif"> 
<cfparam name="attributes.fontcolor" default="black">
<cfparam name="attributes.dayheadercolor" default="4F4FFB">
<cfparam name="attributes.monthcolor" default="EFEFEF">
<cfparam name="attributes.othermonthscolor" default="COCOCO">
<cfparam name="attributes.selecteddaycolor" default="FFFFF0">
<cfparam name="attributes.backcolor" default="white">
<cfparam name="attributes.language" default="english">
<cfparam name="attributes.hidedivname" default="">
<cfparam name="attributes.displayorientation" default="right">
<!--- <cfparam name="attributes.initialvalue" default=""> --->

<cfif attributes.language neq "english" and attributes.language neq "german" and attributes.language neq "spanish">
  <cfset attributes.language = "english">
</cfif>

<cfparam name="attributes.image" default="">
<!--- ymd, dmy, myd  --->
<cfparam name="attributes.dateorder" default="mm/dd/yyyy">
<cfparam name="attributes.initialvalue" default=""><!--- #dateformat(now(), '#attributes.dateorder#')# --->

<!------------------------------------------------- 
Check that the required attributes have been passed
-------------------------------------------------->
<cfloop index="attribute" list="formname,textboxname">
	<cfif not isdefined("attributes." & attribute)>
		<hr>
		<h4>Missing Attribute</h4>
		The <b><cfoutput>#tagName#</cfoutput></b> tag requires the attribute 
		<b><cfoutput>#attribute#</cfoutput></b>.<br>
		<hr>
		<cfabort>
	</cfif>
</cfloop>



<!--- ********************************************
		display text box with image for popup
**********************************************--->
<cfif attributes.first_use_on_page eq "yes">
  
  <cfoutput>

   <STYLE type="text/css">	
  
  	.dpCPa {
  		font-family:#attributes.font#;
  		color:#attributes.fontcolor#;
  		font-size:8pt;
  		font-weight:normal;
  		text-decoration: none;
  	}
	.dpCa:hover{
  		color:#attributes.fontcolor#;
		font-size:8pt;
  	}
  	.dpCa:active{
  		color:#attributes.fontcolor#;
		font-size:8pt;
  	}
	
	.enterbox {background-color: ##FFFFF0; color:##000000; font-size:8pt; }
	.leavebox {background-color: ; font-size:8pt; }
 
   </STYLE>   

  </cfoutput>


 <script language="JavaScript">
<!--
	 
		<cfoutput>
	
	   function wstyletbl(){   
	   
		if(document.getElementById) {
		 document.write('<style type="text/css"> .tblayer  { position:absolute; left:100px; top:100px; background-color: #attributes.backcolor#; visibility: hidden; border: 1px solid black; width: 185px;} </style>  ')
		 }
	   else if(document.all) {
		 document.write('<style type="text/css"> .tblayer  { position:absolute; left:100px; top:100px; background-color: #attributes.backcolor#; visibility: hidden; border: 1px solid black; width: 185px; } </style>  ')
		 }
	   else if(document.layers)
		 { 
		  var html = '<style type="text/css"> .tblayer  { position:absolute; left:100px; top:100px; background-color: aqua; visibility: hidden; width: 185px; } </style>  ';	  
		 //	html =  html + ' .dpC1 { font-family:#attributes.font#;	color:#attributes.fontcolor#; font-size:8pt;	font-weight:normal;	text-decoration: none;	}	.dpCPa:hover{ color:#attributes.fontcolor#; } .dpCPa:active{ color:#attributes.fontcolor#; }  </style>  ';		 
		  document.write(html);   
		  document.close();
		 }
	 }
	  
	 wstyletbl();
	
	 function wdps2(){   
	   
		if(document.getElementById) {
		 document.write('<style type="text/css"> .tbmain  { position: relative; top: 0px; left: 0px; <cfif attributes.image eq "">border: 1px solid Black; </cfif> } .hs {text-decoration: none;} </style>  ')
		 }
	   else if(document.all) {
		 document.write('<style type="text/css"> .tbmain  { position: relative; top: 0px; left: 0px; <cfif attributes.image eq "">border: 1px solid Black; </cfif> } .hs {text-decoration: none;} </style>  ')
		 }
	   else if(document.layers)
		 { 
		  var html = '<style type="text/css"> .tbmain  {  position: relative; top: 0px; left: 0px; } .hs {text-decoration: none;} </style>  ';	
		  document.write(html);   
		  document.close();
		 }
	 }
	  
	 wdps2();
	
	
	 </cfoutput>
	 
	
//-->
</script>

</cfif> 
 
 
<cfoutput>
<table border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>
			#attributes.label# <input id="#attributes.textboxname#" type="text" name="#attributes.textboxname#" value="#attributes.initialvalue#" size="10" onFocus="this.className ='enterbox'" onBlur="isDate(this,'#attributes.dateorder#');this.className ='leavebox'" class="cfAdminDefault">
		</td>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" >
				<tr>
					<td width=18 height=18 align="left" class="tbmain" id="topdatelayer#attributes.textboxname#" <cfif attributes.image eq ""> bgcolor="white"</cfif>>
						<layer name="topdatelayer#attributes.textboxname#" class="tbmain" width="18" height="18">
						<a href="javascript:void(0)" class="hs" onclick="dpToggleLayer('dp_layer01','','show', '#attributes.textboxname#','','#attributes.formname#', '#attributes.hidedivname#')"><font face="Arial,Helvetica,sans-serif" size="4">
						<cfif attributes.image neq "">
						<img src="#attributes.image#" border="0" alt="" align="absmiddle" hspace="2">
						<cfelse>
						&nbsp;&nbsp;&nbsp;&nbsp;
						</cfif>
						</font></a></layer>
					</td>
				</tr> 
			</table>	   
		</td>
	</tr>
</table>
</cfoutput>

 
<!----------------------------------------------------------
  if more than one control on page we only need to
  load the javascript and the color pallette layer once.
 ------------------------------------------------------------->
<cfif attributes.first_use_on_page eq "yes">

<script language="JavaScript1.2">
  var layerRef, styleRef, is, slayer, layername
  var dptop, dpfrm, dphidediv
  layername = 'topdatelayer';

 <cfoutput>
 <cfif attributes.language eq "english">
	 var monName = new Array ("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec");
	 var daysoftheweek = new Array ("Su", "Mo", "Tu", "We", "Th", "Fr", "Sa");
	 var dayName = new Array ("Sun", "Mon", "Tues", "Wed", "Thurs", "Fri", "Sat");
	 var Today = "Today";
	 var strexit = "close";
  <cfelseif attributes.language eq "german"> 
	 var dayName = new Array ("Son", "Mon", "Die", "Mit", "Don", "Fre", "Sam");
	 var daysoftheweek = new Array ("So", "Mo", "Di", "Mi", "Do", "Fr", "Sa");
	 var monName = new Array ("Jan", "Feb", "M&##228;r", "Apr", "Mai", "Jun", "Jul", "Aug", "Sep", "Okt", "Nov", "Dez");
	 var Today = "Heute";
	 var strexit = "schliessen";
  <cfelseif attributes.language eq "spanish"> 
	 var dayName = new Array ("dom", "lun", "mar", "mi�", "jue", "vie", "s�b");
	 var daysoftheweek = new Array ("do", "lu", "ma", "mi", "ju", "vi", "sa");
	 var monName = new Array ("Ene", "Feb", "Mar", "Abr", "May", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dic");
	 var Today = "hoy";
	 var strexit = "cerrar";
  </cfif> 
</cfoutput>

  today = new Date();
 // var today_date = dayName[today.getDay()] + '. ' + monName[today.getMonth()] + ' ' + today.getDate() +  ', ' + today.getFullYear(); 
  var today_date = dayName[today.getDay()] + '. '; 
  today_date = today_date + monName[today.getMonth()] + ' '; 
  today_date = today_date + today.getDate() +  ', '; 
  today_date = today_date + today.getFullYear(); 
  <cfoutput>var dateformat = '#attributes.dateorder#';</cfoutput>
 
  if ((navigator.appVersion.indexOf("Mac")!=-1) 
		  && (navigator.userAgent.indexOf("MSIE")!=-1) 
				 && (parseInt(navigator.appVersion)==3))
	 {
		alert("browser does not support this javascript");
		
	  }  

  else
  { 
		  is = new Is(); 
		  // 6.0 and up use dom
		  if (is.ie6up || is.nav6up) {  
			
			 layerRef="document.getElementById"
			 styleRef=".style"
			 openparen = '("'
			 closeparen = '")'
			 t = '.offsetTop'
			 l = '.offsetLeft'
			 backgroundColorRef=".backgroundColor"
		   } 
		   // netscape
		  else if (is.nav && is.nav4up) {  
		  
	  			layerRef="document.layers"
			  styleRef=""
			 openparen = '["'
			 closeparen = '"]'
			 t = '.pageY'
			 l = '.pageX'
			 backgroundColorRef=".bgColor"
	   
			}
		  // explorer
		  else if (is.ie && is.ie4up ) {  
			 	layerRef="document.all"
	  		 	styleRef=".style"
			  openparen = '["'
			  closeparen = '"]'
			  t = '.offsetTop'
			  l = '.offsetLeft'
			  backgroundColorRef=".backgroundColor"
		   }   
		  // aol
		  else if (is.aol5 ||  is.aol6) {  
			 	layerRef="document.all"
	  		 	styleRef=".style"
 				openparen = '["'
			  closeparen = '"]'
			  t = '.offsetTop'
			  l = '.offsetLeft'
			  backgroundColorRef=".backgroundColor"
			 }		
		  
		  else {
			 alert("browser doesn't support this javascript")
		
		  }  
	
  }
		 
function Is ()
  { 
   
	var agt=navigator.userAgent.toLowerCase();
	this.major = parseInt(navigator.appVersion);
	this.minor = parseFloat(navigator.appVersion);
	this.nav  = ((agt.indexOf('mozilla')!=-1) && (agt.indexOf('spoofer')==-1)
				&& (agt.indexOf('compatible') == -1) && (agt.indexOf('opera')==-1)
				&& (agt.indexOf('webtv')==-1) && (agt.indexOf('hotjava')==-1));
	this.nav2 = (this.nav && (this.major == 2));
	this.nav3 = (this.nav && (this.major == 3));
	this.nav4 = (this.nav && (this.major == 4));
	this.nav4up = (this.nav && (this.major >= 4));
	this.navonly	  = (this.nav && ((agt.indexOf(";nav") != -1) ||
						  (agt.indexOf("; nav") != -1)) );
	this.nav6 = (this.nav && (this.major == 5));
	this.nav6up = (this.nav && (this.major >= 5));
	this.gecko = (agt.indexOf('gecko') != -1);
	this.ie	 = ((agt.indexOf("msie") != -1) && (agt.indexOf("opera") == -1));
	this.ie3	= (this.ie && (this.major < 4));
	this.ie4	= (this.ie && (this.major == 4) && (agt.indexOf("msie 4")!=-1) );
	this.ie4up  = (this.ie  && (this.major >= 4));
	this.ie5	= (this.ie && (this.major == 4) && (agt.indexOf("msie 5.0")!=-1) );
	this.ie5_5  = (this.ie && (this.major == 4) && (agt.indexOf("msie 5.5") !=-1));
	this.ie5up  = (this.ie  && !this.ie3 && !this.ie4);
	this.ie5_5up =(this.ie && !this.ie3 && !this.ie4 && !this.ie5);
	this.ie6	= (this.ie && (this.major == 4) && (agt.indexOf("msie 6.")!=-1) );
	this.ie6up  = (this.ie  && !this.ie3 && !this.ie4 && !this.ie5 && !this.ie5_5);
	this.aol   = (agt.indexOf("aol") != -1);
	this.aol3  = (this.aol && this.ie3);
	this.aol4  = (this.aol && this.ie4);
	this.aol5  = (agt.indexOf("aol 5") != -1);
	this.aol6  = (agt.indexOf("aol 6") != -1);
	this.opera = (agt.indexOf("opera") != -1);
	this.opera2 = (agt.indexOf("opera 2") != -1 || agt.indexOf("opera/2") != -1);
	this.opera3 = (agt.indexOf("opera 3") != -1 || agt.indexOf("opera/3") != -1);
	this.opera4 = (agt.indexOf("opera 4") != -1 || agt.indexOf("opera/4") != -1);
	this.opera5 = (agt.indexOf("opera 5") != -1 || agt.indexOf("opera/5") != -1);
	this.opera5up = (this.opera && !this.opera2 && !this.opera3 && !this.opera4);
	this.webtv = (agt.indexOf("webtv") != -1); 
	this.TVNavigator = ((agt.indexOf("navio") != -1) || (agt.indexOf("navio_aoltv") != -1)); 
	this.AOLTV = this.TVNavigator;
	this.hotjava = (agt.indexOf("hotjava") != -1);
	this.hotjava3 = (this.hotjava && (this.major == 3));
	this.hotjava3up = (this.hotjava && (this.major >= 3));
 }


 function dpToggleLayer() { 
	var elm, elmcp, v,args=dpToggleLayer.arguments;
	  v=args[2];
	slayer = args[0];
	sdate=args[4];
		if(args[3])
   		dptop=args[3];	
	if(args[5])  
 		 dpfrm=args[5];	
		dphidediv=args[6];	
		   
  elm = layerRef + openparen + layername + dptop +  closeparen
  elmcp = layerRef + openparen + 'dp_layer01' +  closeparen + styleRef
  if(v == 'show')
	 {
 
	  hval = '<cfoutput>#attributes.selecteddaycolor#</cfoutput>';
	 eval(layerRef + openparen + dptop +  closeparen + styleRef + backgroundColorRef + ' = "' + hval + '"')
	 
	  writelayer(); 
	 
	  var leftpos = '+19';
	  <cfif attributes.displayorientation eq "left">
	   leftpos = '-185';
	  </cfif>
	 
	  eval(elmcp + '.left =' + elm + l + leftpos) 
	  eval(elmcp + '.top =' + elm + t + '+24') 
   }else
   {
		hval = '';
		eval(layerRef + openparen + dptop +  closeparen + styleRef + backgroundColorRef + ' = "' + hval + '"')
		if(sdate){
			 eval('document.' + dpfrm + '.' + dptop + '.value = sdate');
		  }
		  
		
	}
	
   if (dphidediv) var vo=(v=='show')?'hidden':(v=='hide')?'visible':v;
   v=(v=='show')?'visible':(v=='hide')?'hidden':v;
   if (dphidediv)   eval(layerRef + openparen + dphidediv +  closeparen + styleRef +'.visibility = vo')
   eval(layerRef + openparen + 'dp_layer01' +  closeparen + styleRef +'.visibility = v')
	
}
		 
function getDays(date)
{
  if (date == null) return -1;
  array_month = Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
  if ((date.getFullYear() % 4 == 0) && (!(date.getFullYear() % 100 == 0) || (date.getFullYear() % 400 == 0))) array_month[1] = 29;
  return array_month[date.getMonth()];  
}

/* function isDate(sDate) {

  var datePat = /^([0-9]+)[-\/]([0-9]+)[-\/]([0-9]+)$/;
  var dateArray = sDate.match(datePat);
  
	  
  if (dateArray == null) {
	  alert("You entered invalid date. Please try again...");	
	 return false;
   }

   if (dateformat == 'mdy') {
		  var monthValue = dateArray[1]-1;
		  var dayValue = dateArray[2];
		  var yearValue = dateArray[3];
	}else if (dateformat == 'dmy') {
		  var dayValue = dateArray[1];
		  var monthValue = dateArray[2]-1;
		  var yearValue = dateArray[3];
   }else if (dateformat == 'ymd') {
		  var yearValue = dateArray[1];
		  var monthValue = dateArray[2]-1;
		  var dayValue = dateArray[3];
	}	  

 
  if (yearValue<1000) {
		  yearValue= yearValue -0; 
		  yearValue+=1900; 
   }
 

testDate = new Date(yearValue, monthValue, dayValue)

y = testDate.getYear()
 if (y<1000) y+=1900; 

 
 if ((yearValue == y) && (monthValue == testDate.getMonth()) && dayValue == testDate.getDate())
  return testDate;
else
  return false;	

}*/ 

// ------------------------------------------------------------------
// isDate ( date_string, format_string )
//
// Returns true if date string matches format of format string and
// is a valid date. Else returns false.
//
// It is recommended that you trim whitespace around the value before
// passing it to this function, as whitespace is NOT ignored!
// ------------------------------------------------------------------
function isDate(obj, format) {
	
   
	val = obj.value;
	 if (val == "")
		  return;
  
	val = val+"";
	
	var date = getDateFromFormat(val,format);
	
	if (date == 0) 
	  {
		alert ("invalid date");
		obj.focus();
		return false; 
	   }
 
	obj.value = formatDate(date, format); 
   	return true;
	}


// ------------------------------------------------------------------
// formatDate (date_object, format)
//
// Returns a date in the output format specified.
// The format string uses the same abbreviations as in getDateFromFormat()
// ------------------------------------------------------------------
function formatDate(date,format) {
	format = format+"";
	var result = "";
	var i_format = 0;
	var c = "";
	var token = "";
	var y = date.getYear()+"";
	var m = date.getMonth()+1;
	var d = date.getDate();
	var nday = date.getDay();
	var H = date.getHours();
	var M = date.getMinutes();
	var s = date.getSeconds();
	var yyyy,yy,MMM,MM,dd,hh,h,mm,ss,ampm,HH,H,KK,K,kk,k;
	// Convert real date parts into formatted versions
	// Year
	if (y.length < 4) {
  		y = y-0+1900;
	  }
	
	yyyy = ""+y;
	y = ""+y;
	//yy = ""+y;
   	if (y < 10) { yy = "0"+y; }
		else { yy = y; }
	
	
	y = y.substring(2,4);
	yy = yy.substring(2,4);

	// Month
	if (m < 10) { mm = "0"+m; }
		else { mm = m; }
	
	ddd = daysoftheweek[nday];
	dddd = daysoftheweek[nday];
		
	mmm = monName[m-1];
	mmmm = monName[m-1];
	
	// Date
	if (d < 10) { dd = "0"+d; }
		else { dd = d; }

	// Hour
	h=H+1;
	K=H;
	k=H+1;
	if (h > 12) { h-=12; }
	if (h == 0) { h=12; }
	if (h < 10) { hh = "0"+h; }
		else { hh = h; }
	if (H < 10) { HH = "0"+K; }
		else { HH = H; }
	if (K > 11) { K-=12; }
	if (K < 10) { KK = "0"+K; }
		else { KK = K; }
	if (k < 10) { kk = "0"+k; }
		else { kk = k; }
	// AM/PM
	if (H > 11) { ampm="PM"; }
	else { ampm="AM"; }
	// Minute
	if (m < 10) { mm = "0"+m; }
		else { mm = m; }
	// Second
	if (s < 10) { ss = "0"+s; }
		else { ss = s; }
	// Now put them all into an object!
	
	var value = new Object();
	value["yyyy"] = yyyy;
	value["yy"] = yy;
	value["y"] = parseInt(y);
	value["mmm"] = mmm;
	value["mmmm"] = mmmm;
	value["mm"] = mm;
	value["m"] = m;
	value["dddd"] = dddd;
	value["ddd"] = ddd;
	value["dd"] = dd;
	value["d"] = d;
	value["hh"] = hh;
	value["h"] = h;
	value["HH"] = HH;
	value["H"] = H;
	value["KK"] = KK;
	value["K"] = K;
	value["kk"] = kk;
	value["k"] = k;
	value["MM"] = MM;
	value["m"] = m;
	value["ss"] = ss;
	value["s"] = s;
	value["a"] = ampm;
	value["/"] = '/';
	value["-"] = '-';
   
	
	while (i_format < format.length) {
		// Get next token from format string
		c = format.charAt(i_format);
		token = "";
		 
		while ((format.charAt(i_format) == c) && (i_format < format.length)) {
			token += format.charAt(i_format);
			i_format++;
			}
		if (value[token] != null) {
			result = result + value[token];
			}
		else {
			result = result + token;
			}
		}
		
	return result;
	}
	

// ------------------------------------------------------------------
// Utility functions for parsing in getDateFromFormat()
// ------------------------------------------------------------------
function _isInteger(val) {
	var digits = "1234567890";
	for (var i=0; i < val.length; i++) {
		if (digits.indexOf(val.charAt(i)) == -1) { return false; }
		}
	return true;
	}
function _getInt(str,i,minlength,maxlength) {
	for (x=maxlength; x>=minlength; x--) {
		var token = str.substring(i,i+x);
		if (token.length < minlength) {
			return null;
			}
		if (_isInteger(token)) { 
			return token;
			}
		}
	return null;
	}
// ------------------------------------------------------------------
// END Utility Functions
// ------------------------------------------------------------------
	

// ------------------------------------------------------------------
// getDateFromFormat( date_string , format_string )
//
// This function takes a date string and a format string. It matches
// If the date string matches the format string, it returns the 
// getTime() of the date. If it does not match, it returns 0.
// 
// This function uses the same format strings as the 
// java.text.SimpleDateFormat class, with minor exceptions.
// 
// The format string consists of the following abbreviations:
// 
// Field		| Full Form		  | Short Form
// -------------+--------------------+-----------------------
// Year		 | yyyy (4 digits)	| yy (2 digits), y (2 or 4 digits)
// Month		| MMM (name or abbr.)| MM (2 digits), M (1 or 2 digits)
// Day of Month | dd (2 digits)	  | d (1 or 2 digits)
// Hour (1-12)  | hh (2 digits)	  | h (1 or 2 digits)
// Hour (0-23)  | HH (2 digits)	  | H (1 or 2 digits)
// Hour (0-11)  | KK (2 digits)	  | K (1 or 2 digits)
// Hour (1-24)  | kk (2 digits)	  | k (1 or 2 digits)
// Minute	   | mm (2 digits)	  | m (1 or 2 digits)
// Second	   | ss (2 digits)	  | s (1 or 2 digits)
// AM/PM		| a				  |
//
// d -- Day of the month as digits with no leading zero for single-digit days. 
// dd -- Day of the month as digits with a leading zero for single-digit days. 
// ddd -- Day of the week as a three-letter abbreviation. 
// dddd -- Day of the week as its full name. 
// m -- Month as digits with no leading zero for single-digit months. 
// mm -- Month as digits with a leading zero for single-digit months. 
// mmm -- Month as a three-letter abbreviation. 
// mmmm -- Month as its full name. 
// y -- Year as last two digits with no leading zero for years less than 10. 
// yy -- Year as last two digits with a leading zero for years less than 10. 
// yyyy -- Year represented by four digits. 
// gg -- Period/era string. Currently ignored, but reserved for future use. 
// Examples:
//  "MMM d, y" matches: January 01, 2000
//					  Dec 1, 1900
//					  Nov 20, 00
//  "m/d/yy"   matches: 01/20/00
//					  9/2/00
//  "MMM dd, yyyy hh:mm:ssa" matches: "January 01, 2000 12:30:45AM"
// ------------------------------------------------------------------

function getDateFromFormat(val,format) {
	
	// val = obj.value+"";
  
	val = val+"";
	format = format+"";
	var i_val = 0;
	var i_format = 0;
	var c = "";
	var token = "";
	var token2= "";
	var x,y;
	var now   = new Date();
	var year  = now.getYear();
	var month = now.getMonth()+1;
	var date  = now.getDate();
	var hh	= now.getHours();
	var MM	= now.getMinutes();
	var ss	= now.getSeconds();
	var ampm  = "";
	
	while (i_format < format.length) {
		// Get next token from format string
		c = format.charAt(i_format);
		token = "";
		while ((format.charAt(i_format) == c) && (i_format < format.length)) {
			token += format.charAt(i_format);
			i_format++;
			
			}
		// Extract contents of value based on format token
		
		if (token=="yyyy" || token=="yy" || token=="y") {
			if (token=="yyyy") { x=4;y=4; }// 4-digit year
			if (token=="yy")   { x=2;y=2; }// 2-digit year
			if (token=="y")	{ x=1;y=2; }// 2-or-4-digit year
			year = _getInt(val,i_val,x,y);
			//alert(year);
			if (year == null) 
			 {  x=1; y=1;
				year = _getInt(val,i_val,x,y);		 
			 }
			if (year == null) { return 0; }
			
			i_val += year.length;
			if (year.length == 2) {
				if (year > 70) {
					year = 1900+(year-0);
					}
				else {
					year = 2000+(year-0);
					}
				}
			}
		else if (token=="mmm"){// Month name abbreviaton
			month = 0;
			
			for (var i=0; i<monName.length; i++) {
				var month_name = monName[i];
				if (val.substring(i_val,i_val+month_name.length).toLowerCase() == month_name.toLowerCase()) {
					month = i+1;
					if (month>12) { month -= 12; }
					i_val += month_name.length;
					break;
					}
				}
			if (month == 0) { return 0; }
			if ((month < 1) || (month>12)) { return 0; }
			
			}
		/* else if (token=="mmmm"){// Month name long
			month = 0;
			
			for (var i=0; i<monName.length; i++) {
				var month_name = MONTH_NAMES[i];
				if (val.substring(i_val,i_val+month_name.length).toLowerCase() == month_name.toLowerCase()) {
					month = i+1;
					if (month>12) { month -= 12; }
					i_val += month_name.length;
					break;
					}
				}
			if (month == 0) { return 0; }
			if ((month < 1) || (month>12)) { return 0; }
			
			}*/ 

		else if (token=="mm" || token=="m") {
			x=token.length; y=2;
			month = _getInt(val,i_val,x,y);
			if (month == null) 
			 {  x=1; y=1;
				month = _getInt(val,i_val,x,y);		 
			 }
			if (month == null) { return 0; }
			if ((month < 1) || (month > 12)) { return 0; }
			i_val += month.length;
 			
			}
		else if (token=="dd"  || token=="d") {
			x=token.length; y=2;
			date = _getInt(val,i_val,x,y);
			
			if (date == null) 
			 {  x=1; y=1;
				date = _getInt(val,i_val,x,y);		 
			 }
			
			if (date == null) 
				 { return 0; }
			
			if ((date < 1) || (date>31)) { return 0; }
			i_val += date.length;
			}
			
		else if (token=="ddd"){// day name abbreviaton
			nday = 0;
			
			for (var i=7; i<DAYS_OF_WEEK.length; i++) {
				var day_name = DAYS_OF_WEEK[i];
				if (val.substring(i_val,i_val+day_name.length).toLowerCase() == day_name.toLowerCase()) {
					nday = i+1;
					if (nday>14) { nday -= 14; }
					i_val += day_name.length;
					//alert(day_name);
					break;
					}
				}
			if (nday == 0) { return 0; }
			if ((nday < 1) || (nday>14)) { return 0; }
			
			}
		else if (token=="dddd"){// day name long
			nday = 0;
			
			for (var i=0; i<DAYS_OF_WEEK.length; i++) {
				var day_name = DAYS_OF_WEEK[i];
				if (val.substring(i_val,i_val+day_name.length).toLowerCase() == day_name.toLowerCase()) {
					nday = i+1;
					if (nday>7) { nday -= 7; }
					i_val += day_name.length;
					break;
					}
				}
			if (nday == 0) { return 0; }
			if ((nday < 1) || (nday>7)) { return 0; }
			
			}	
		else if (token=="hh" || token=="h") {
			x=token.length; y=2;
			hh = _getInt(val,i_val,x,y);
			if (hh == null) { return 0; }
			if ((hh < 1) || (hh > 12)) { return 0; }
			i_val += hh.length;
			hh--;
			}
		else if (token=="HH" || token=="H") {
			x=token.length; y=2;
			hh = _getInt(val,i_val,x,y);
			if (hh == null) { return 0; }
			if ((hh < 0) || (hh > 23)) { return 0; }
			i_val += hh.length;
			}
		else if (token=="KK" || token=="K") {
			x=token.length; y=2;
			hh = _getInt(val,i_val,x,y);
			if (hh == null) { return 0; }
			if ((hh < 0) || (hh > 11)) { return 0; }
			i_val += hh.length;
			}
		else if (token=="kk" || token=="k") {
			x=token.length; y=2;
			hh = _getInt(val,i_val,x,y);
			if (hh == null) { return 0; }
			if ((hh < 1) || (hh > 24)) { return 0; }
			i_val += hh.length;
			h--;
			}
		else if (token=="MM" || token=="M") {
			x=token.length; y=2;
			mm = _getInt(val,i_val,x,y);
			if (mm == null) { return 0; }
			if ((mm < 0) || (mm > 59)) { return 0; }
			i_val += mm.length;
			}
		else if (token=="ss" || token=="s") {
			x=token.length; y=2;
			ss = _getInt(val,i_val,x,y);
			if (ss == null) { return 0; }
			if ((ss < 0) || (ss > 59)) { return 0; }
			i_val += ss.length;
			}
		else if (token=="a") {
			if (val.substring(i_val,i_val+2).toLowerCase() == "am") {
				ampm = "AM";
				}
			else if (val.substring(i_val,i_val+2).toLowerCase() == "pm") {
				ampm = "PM";
				}
			else {
				return 0;
				}
			}
		else {
			if (val.substring(i_val,i_val+token.length) != token) {
				return 0;
				}
			else {
				i_val += token.length;
				}
			}
		}
	// If there are any trailing characters left in the value, it doesn't match
	if (i_val != val.length) {
		return 0;
		}
	// Is date valid for month?
	if (month == 2) {
		// Check for leap year
		if ( ( (year%4 == 0)&&(year%100 != 0) ) || (year%400 == 0) ) { // leap year
			if (date > 29){ return false; }
			}
		else {
			if (date > 28) { return false; }
			}
		}
	if ((month==4)||(month==6)||(month==9)||(month==11)) {
		if (date > 30) { return false; }
		}
	// Correct hours value
	if (hh<12 && ampm=="PM") {
		hh+=12;
		}
	else if (hh>11 && ampm=="AM") {
		hh-=12;
	
		}
	var newdate = new Date(year,month-1,date,hh,MM,ss);
	return newdate;
	// alert (newdate.getTime());
	
	
	}
	
function writelayer() {	
  var content;
  var v,args=writelayer.arguments;
  var now,day,month,year,dayofweek;
  currDate = eval('document.' + dpfrm + '.' + dptop + '.value'); 
  
  // var tbDate = isDate(currDate, dateformat);
  
   var tbDate = getDateFromFormat(currDate, dateformat);
  
   if (!tbDate){
	  tbDate= new Date();
	  dayofweek = tbDate.getDay();
	  day = tbDate.getDate();
	  month = tbDate.getMonth();
	  year = tbDate.getFullYear(); 
	 }
	
   if (args.length > 0){
	   
	  now= new Date(args[0], args[1], args[2]);   
	  dayofweek = now.getDay();
	  day = now.getDate();
	  month = now.getMonth();
	  year = now.getFullYear(); 
			   
   }else{ 
   
   if (tbDate){
		 now = new Date(tbDate); 
	 }
	else
	  now= new Date();
			
	  dayofweek = now.getDay();
	  day = now.getDate();
	  month = now.getMonth();
	  year = now.getFullYear(); 
		
  } 
 
  
   // var strdate =   month+'/'+day+'/'+year;
   var start_day = new Date(year, month, "1");
	   start_day =  start_day.getDay();
	   
   var total_days_in_month = new Date(year, month, "1");
	   total_days_in_month =  getDays(total_days_in_month); 
  
   var lastmonth = (month-1 == -1)?11:(month-1);
   var lastyear = year -1;
 
   var nextmonth = (month+1 == 12)?0:(month+1);
   var nextyear = year + 1;
  
   var total_days_in_lastmonth = new Date((lastmonth == 11)?lastyear:year, lastmonth, "1");
	   total_days_in_lastmonth =  getDays(total_days_in_lastmonth); 
   
   var yearoflastmonth = (lastmonth == 11)?lastyear:year;
   var yearofnextmonth = (nextmonth == 0)?nextyear:year;	 
	  
   var end_day = new Date(year, month, total_days_in_month);
	   end_day = end_day.getDay();
  
  var rightnow = formatDate(new Date(tbDate.getFullYear(), tbDate.getMonth(), tbDate.getDate()),dateformat)		 

 <!---  build on the output to string  --->
 <!--- start table--->  
<cfoutput>
 content='<table width="170" cellpadding="2" border="0" cellspacing="0" bgcolor="#attributes.backcolor#">';
 content+='<tr><td align="left" colspan="3" height="10"></td></tr>';
 content+='<tr><td align="left" width="30%">';
  
  <!--- previous month  --->
  content+='<a class="dpCPa" href="javascript:void(0)" onclick="writelayer(\'' +yearoflastmonth+  '\',\'' +lastmonth+ '\',\'01\'); return false;">';
  content+='<strong>&laquo;&nbsp;'+monName[lastmonth]+'&nbsp;</strong></a>';

  <!--- current month  --->
  content+='</td><td width="30%" align="center" nowrap><strong>';
  content+='<font size="2" face="#attributes.font#" color="#attributes.fontcolor#">'+monName[month]+'&nbsp;'+year+'</strong></font>';
  content+='</strong></td><td width = "30%" align="right">';
	
  <!--- next month --->	
  content+='<a class="dpCPa" href="javascript:void(0)" onclick="writelayer(\'' +yearofnextmonth+  '\',\'' +nextmonth+ '\',\'01\'); return false;">';
  content+='<strong>&nbsp;'+monName[nextmonth]+'&nbsp;&raquo;</strong></a>';
					 
  <!--- close table--->  
  content+='</td></tr>'
  //content+='<tr><td colspan="3" align="left" height="5">&nbsp;';</td></tr>'
  content+='</table>';

  <!--- start calendar--->  
  content+='<table border="0" cellspacing="0" cellpadding="0" width="170" bgcolor="#attributes.backcolor#"><tr>';
 
  <!--- days of the week headings --->	  
  for (i=0; i<daysoftheweek.length; i++){
	 content+='<td height="18" align="center" width="16">';
	 content+='<font size="1" face="#attributes.font#" color="#attributes.dayheadercolor#"><strong>'+daysoftheweek[i]+'</strong></font></td>';
  }

  content+='</tr></table>';   
  content+='<table width="170" border="0" cellspacing="0" cellpadding="0" bgcolor="gray"><tr><td>';
  content+='<table border="0" cellspacing="1" cellpadding="0" width="100%" >';					  
	  
	var week_day = start_day;
  var display_day	=1;  
  
   <!--- loop through all the days in the current month --->	  
   while (display_day <= total_days_in_month){
	content+='<tr>';
	   
	  <!--- fill in the days of the PREVIOUS month --->
	  while (start_day > 0) {
		var currday = (total_days_in_lastmonth - start_day + 1);
		 var tstrdate = formatDate(new Date(yearoflastmonth, lastmonth, currday),dateformat)
		  /* if (dateformat == 'mdy') {
			 var tstrdate= (lastmonth+1)+'/'+currday+'/'+yearoflastmonth;
			}else if (dateformat == 'dmy') {
			 var tstrdate= currday+'/'+(lastmonth+1)+'/'+yearoflastmonth;
			}else if (dateformat == 'ymd') {
			 var tstrdate= yearoflastmonth+'/'+(lastmonth+1)+'/'+currday;
			}  */	 
		
		content+='<td bgcolor="#attributes.othermonthscolor#" align="right" height="18" width="16">';
				content+='<font size="1" face="#attributes.font#">';
  			content+='<a class="dpCPa" href="javascript:void(0);" onclick="dpToggleLayer(\'dp_layer01\', \'\', \'hide\', \'\', \''+tstrdate+'\', \'\', dphidediv);">';
		content+= currday;				  			
		content+='</a></font></td>' ;  
		start_day = --start_day;
		
	  }
   
	  <!--- write one week (7 days) on one line --->				  
	  while (week_day <= 6) {
	
	  //var tstrdate= today.getMonth()+'/'+today.getDate()+'/'+today.getFullYear();
	
		<!--- fill in the days of the CURRENT month --->
		if(display_day <= total_days_in_month) {
			
		 var tstrdate = formatDate(new Date(year, month, display_day),dateformat)
		 
	   /*  if (dateformat == 'mdy') {
			var tstrdate= (month+1)+'/'+display_day+'/'+year;
			var rightnow = (tbDate.getMonth()+1)+'/'+tbDate.getDate()+'/'+tbDate.getFullYear();
		  }else if (dateformat == 'dmy') {
			var tstrdate= display_day+'/'+(month+1)+'/'+year;
			var rightnow = tbDate.getDate()+'/'+(tbDate.getMonth()+1)+'/'+tbDate.getFullYear();
			}else if (dateformat == 'ymd') {
			 var tstrdate= year+'/'+(month+1)+'/'+display_day;
			 var rightnow = tbDate.getFullYear()+'/'+(tbDate.getMonth()+1)+'/'+tbDate.getDate();			 
			}   */	
			 	 			
	
		   
			if(rightnow == tstrdate) {		
				sbgcolor='###attributes.selecteddaycolor#';
			   }
			else
				sbgcolor='###attributes.monthcolor#';
				  
			content+='<td bgcolor="' + sbgcolor +'" align="right" height="18" width="16">'
			content+='<font size="1" face="#attributes.font#">'
	  			content+='<a class="dpCPa" href="javascript:void(0);" onclick="dpToggleLayer(\'dp_layer01\', \'\', \'hide\', \'\', \''+tstrdate+'\', \'\', dphidediv);">'
			content+= display_day				  			
			content+='</a></font></td>'   
			
		} 
		else {
		
			 <!--- fill in the days of the NEXT month --->
			var currday = 0; 
			while(end_day < 6) {
			  currday = ++currday;
				var tstrdate = formatDate(new Date(yearofnextmonth, nextmonth, currday),dateformat)				
	
			/*  if (dateformat == 'mdy') {
			   var tstrdate= (nextmonth+1)+'/'+currday+'/'+yearofnextmonth
			  }else if (dateformat == 'dmy') {
			   var tstrdate= currday+'/'+(nextmonth+1)+'/'+yearofnextmonth
			  }else if (dateformat == 'ymd') {
			   var tstrdate= yearofnextmonth+'/'+(nextmonth+1)+'/'+currday
			  }   */ 
			 
			  content+='<td bgcolor="#attributes.othermonthscolor#" align="right" height="18" width="16">'
	  				content+='<font size="1" face="#attributes.font#">'
					content+='<a class="dpCPa" href="javascript:void(0);" onclick="dpToggleLayer(\'dp_layer01\', \'\', \'hide\', \'\', \''+tstrdate+'\', \'\', dphidediv);">'
			  content+= currday				  			
			  content+='</a></font></td>'  
			  end_day = ++end_day;
			}  
		 }
		   
	  week_day = ++week_day;
	  display_day = ++display_day;
	 
	 } // week per row
	content+='</tr>';	
	 	
   week_day = 0; 
  }// display <= total_days_in_month
  
   <!--- close calendar table --->  
  content+='</table></td></tr></table>'		

  var tstrdate = formatDate(new Date(today.getFullYear(), today.getMonth(), today.getDate()),dateformat)	
  
 /*  if (dateformat == 'mdy') {
	 var tstrdate= (today.getMonth()+1) +'/'+today.getDate()+'/'+today.getFullYear();
  }else if (dateformat == 'dmy') {
	 var tstrdate=  today.getDate()+'/'+(today.getMonth()+1)+'/'+today.getFullYear();
  }else if (dateformat == 'ymd') {
	 var tstrdate=  today.getFullYear()+'/'+(today.getMonth()+1)+'/'+today.getDate();
  }  */				


 <!--- build on the output to string --->  
 content+='<table cellpadding="2" border="0" cellspacing="0" width="170" bgcolor="#attributes.backcolor#"><tr><td align="center"><font face="#attributes.font#" size="1" color="#attributes.dayheadercolor#"><b>'+Today+'</b><br>'
 content+='<a class="dpCPa" href="javascript:void(0);" onclick="dpToggleLayer(\'dp_layer01\', \'\', \'hide\', \'\', \''+tstrdate+'\', \'\', dphidediv);" >'
 content+=today_date+'</a>'
 content+='</font></td></tr><tr><td align="center">'
 content+='<a href="javascript:void(0)" onClick="dpToggleLayer(\'dp_layer01\', \'\', \'hide\', \'\', \'\', \'\', dphidediv)"><font face="#attributes.font#" size="1" color="000000">' +strexit +'</FONT></a>'
 content+='</td></tr></table>'
</cfoutput>
  
//----------------------------------------- 
// write the layer  
//-----------------------------------------
 if(document.getElementById)
   {
	 document.getElementById("dp_layer01").innerHTML=content;
	 } 
   else if(document.all)
	{
  	  document.all["dp_layer01"].innerHTML=content;
   	}
   else if(document.layers)
	{
	 with(document.layers["dp_layer01"].document){
			 open();
			 write(content);
			 close();
		}
	 }
}
 
  
 </script> 

<div id="dp_layer01" align="center" class="tblayer"></div>


</cfif>




