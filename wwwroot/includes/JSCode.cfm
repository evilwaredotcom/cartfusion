<script language="javascript" type="text/javascript">
	// Is the browser accepting cookies?
	if(!navigator.cookieEnabled){
		alert("NO COOKIES");
		location.replace("../NoCookies.cfm");
	} 
	
	// TEXTAREA CHARACTER COUNTER
	function TrackCount(fieldObj,maxChars)
	{
		var diff = maxChars - fieldObj.value.length;
		// Need to check & enforce limit here also in case user pastes data
		if (diff < 0){
			fieldObj.value = fieldObj.value.substring(0,maxChars);
			diff = maxChars - fieldObj.value.length;
		}
	}
	
	// POPUP WINDOWS CENTERED
	function NewWindow(mypage, myname, w, h, scroll) {
		var winl = (screen.width - w) / 2;
		var wint = (screen.height - h) / 2;
		winprops = 'height='+h+',width='+w+',top='+wint+',left='+winl+',scrollbars='+scroll+',resizable';
		win = window.open(mypage, myname, winprops);
		if (parseInt(navigator.appVersion) >= 4) { win.window.focus(); }
	}
	
	// PRODUCTS
	if (document.getElementById) { 
		document.write('<style type="text/css">.submenu1{display: block;}');
		document.write('.submenu2,.submenu3,.submenu4,.submenu5{display: none;}\n</style>\n');
	}
	function SwitchMenu(obj) {
		if(document.getElementById) {
			var el = document.getElementById(obj);
			var ar = document.getElementById("productExtras").getElementsByTagName("span"); 
			if(el.style.display != "block") { 
				// the commented code is to hide others when one is clicked/shown
				for (var i=0; i<ar.length; i++) {
					if (ar[i].className=="submenu1") 
						ar[i].style.display = "none";
					if (ar[i].className=="submenu2") 
						ar[i].style.display = "none";
					if (ar[i].className=="submenu3") 
						ar[i].style.display = "none";
					if (ar[i].className=="submenu4") 
						ar[i].style.display = "none";
					if (ar[i].className=="submenu5") 
						ar[i].style.display = "none";
				}
				el.style.display = "block";
			}else{
				el.style.display = "none";
			}
		}
	}
</script>
<cfscript> 
	function poundsAndOuncesFormat(value) { 
		var returnString = ""; 
		var pounds = int(value); 
		var ounces = (value - pounds) * 16; 
		ounces  = round(ounces * 100) / 100; // round ounces off at 2 decimal places 
		if ( pounds ) 
			returnString = pounds & " lb"; 
		if ( ounces ) 
			returnString = listappend(returnString, ounces & " oz", " "); 
		return returnString; 
	}
</cfscript>