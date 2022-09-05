<!--
CF_CAL Custom Tag

Jason Bukowski
4 Brattle Circle
Cambridge, MA 02138
6/28/2000

UPDATED 7/11/2000
- Fixed Netscape bug
- Fixed Multiple Instances Bug
- Minor UI Improvment

jbukowski@dataware.com

CF_CAL is designed to place a button that activates a popup calendar. The user may browse though the calendar and select and date he wants by clicking on it. That date is then send back to a definded text field in a defined form in the format MM/DD/YYYY. 

To Use:
Paramteres-- formname target date image 

REQUIRED:
	formname - the name of the form you want the date inserted into
	target - the name of the text field in that form
OPTIONAL
	date - the date the calendar opens to. Default is current.
	image - the graphic to appear as the button. Default is [C] -- path is relative to calling page.
-->
<cftry>

<cfif parameterexists(attributes.target) EQ 0>
<cfthrow message="NoTarget">
<cfelseif parameterexists(attributes.formname) EQ 0>
<cfthrow message="NoTarget">
</cfif>


<cfparam name="attributes.date" default="#Now()#">
<cfparam name="attributes.image" default="0">

<cfoutput>
<script language="JavaScript">

var months = new Array("January","February","March","April","May","June","July","August","September","October","November","December")
var totalDays = new Array(31,28,31,30,31,30,31,31,30,31,30,31)


function openCalWin_#attributes.target#() { 
	var winl = (screen.width - 300) / 2;
	var wint = (screen.height - 250) / 2;
	winprops = 'height=250,width=300,top='+wint+',left='+winl+','
	winprops += 'scrollbars=no,resizable=notoolbar=no,location=no,directories=no,status=no,menubar=no'
	CalWin = window.open ("","Calendar",winprops)
	if (parseInt(navigator.appVersion) >= 4) { CalWin.window.focus(); }
	
	var calMonth = #DateFormat(attributes.date, "M")#
	var calYear = #DateFormat(attributes.date, "YYYY")#
	
	
	theDate = new Date(calYear, (calMonth - 1), 1)

	buildCal_#attributes.target#(theDate)
	
}

function buildCal_#attributes.target#(theDate) {
	
	var startDay = theDate.getDay()
	var printDays = false
	var currDay = 1
	var rowsNeeded = 5
	
	if (startDay + totalDays[theDate.getMonth()] > 35)
		rowsNeeded++
	
	CalWin.document.write('<html><head><Title>Select a Date</title>')
	CalWin.document.write('<STYLE TYPE="text/css">')
	CalWin.document.write('A { color: ##014589; font-family:Tahoma,Helvetica;font-size:8pt; font-weight: bold; text-decoration: none}')
	CalWin.document.write('A:hover { color: ##FF9900; }')
	CalWin.document.write('</STYLE></head>')
	CalWin.document.write('<body><a name="this"></a>')
	CalWin.document.write('<table align=center height=100% width=100% border=1 bordercolor=##4DA0CA cellpadding=0 cellspacing=0>')
	CalWin.document.write('<tr><th bgcolor=##4DA0CA colspan=7><font face=Tahoma color=white>' + months[theDate.getMonth()] + ' ' + theDate.getFullYear() + '</font></th></tr>')
	CalWin.document.write('<tr bgcolor="##CCCCCC"><th><font face=Tahoma color=white>Su</font></th><th><font face=Tahoma color=white>Mo</font></th><th><font face=Tahoma color=white>Tu</font></th><th><font face=Tahoma color=white>We</font></th><th><font face=Tahoma color=white>Th</font></th><th><font face=Tahoma color=white>Fr</font></th><th><font face=Tahoma color=white>Sa</font></th></tr>')
	for (x=1; x<=rowsNeeded; x++){
		CalWin.document.write('<tr>')
		for (y=0; y<=6; y++){
			if (currDay == 1 && !printDays && startDay == y)
				printDays = true
			CalWin.document.write('<td align="center" width=14.28%>')
			if (printDays){
				CalWin.document.write('<a href="javascript:opener.placeDate_#attributes.target#(' + theDate.getMonth() + ',' +  currDay + ',' + theDate.getFullYear() + ')">' + currDay++ + '</a></td>')
				if (currDay > totalDays[theDate.getMonth()])
					printDays = false
			}
			else
				CalWin.document.write('&nbsp;</td>')
		}		
		CalWin.document.write('</tr>')
	}	
	CalWin.document.write('<form><tr bgcolor="##CCCCCC"><td colspan=7 align="center"><input type="Button" size="2" name="Back" value="<<" onClick="opener.getNewCal_#attributes.target#(-1)"><font face=Tahoma color=white size="1"> Use the arrows to browse through the months.</font> <input type="Button" size="2" name="Forward" value=">>" onClick="opener.getNewCal_#attributes.target#(1)"></td></tr></form>')
	CalWin.document.write('</table></body></html>')
	CalWin.document.close()
	
}

function getNewCal_#attributes.target#(newDir) {
	if (newDir == -1){
		theDate.setMonth(theDate.getMonth() - 1)
		if (theDate.getMonth() == 0){
			theDate.setMonth(12)
			theDate.setYear(theDate.getYear() - 1)
		}
	}
	else if (newDir == 1){
		theDate.setMonth(theDate.getMonth() + 1)
		if (theDate.getMonth() == 13){
			theDate.setMonth(1)
			theDate.setYear(theDate.getYear() + 1)
		}
	}
		
		
	CalWin.document.clear();
	buildCal_#attributes.target#(theDate);

}

function placeDate_#attributes.target#(monthNum, dayNum, yearNum){
	var dateString = (monthNum + 1) + '/' + dayNum + '/' + yearNum

	document.#attributes.formname#.#attributes.target#.value = dateString
		 
	CalWin.close()
}

</script>
 
<cfif #attributes.image# NEQ 0>
<a href="javascript:openCalWin_#attributes.target#()"><img src="#attributes.image#" align="absmiddle" border=0></a>
<cfelse>
<a href="javascript:openCalWin_#attributes.target#()">[C]</a>
</cfif> 
</cfoutput>

<cfcatch type="Any">
<script language="JavaScript">
alert("You must supply a value for the FORMNAME & TARGET attributes!")
</script>
</cfcatch>
</cftry>