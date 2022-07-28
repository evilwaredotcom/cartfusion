<script language="javascript" type="text/javascript">
  // Is the browser accepting cookies?
  if(!navigator.cookieEnabled){
	alert("NO COOKIES");
	location.replace("../NoCookies.cfm");
  } 
	
  // IMAGE SWAPPER
  if(document.images) {
    pics = new Array();
    pics[1] = new Image();
    pics[1].src = "images/topnav-welcome.gif";
    pics[2] = new Image();
    pics[2].src = "images/topnav-welcomeOver.gif";
    pics[3] = new Image();
    pics[3].src = "images/topnav-categories.gif";
    pics[4] = new Image();
    pics[4].src = "images/topnav-categoriesOver.gif";
    pics[5] = new Image();
    pics[5].src = "images/topnav-viewcart.gif";
    pics[6] = new Image();
    pics[6].src = "images/topnav-viewcartOver.gif";
    pics[7] = new Image();
    pics[7].src = "images/topnav-myaccount.gif";
    pics[8] = new Image();
    pics[8].src = "images/topnav-myaccountOver.gif";
    pics[9] = new Image();
    pics[9].src = "images/topnav-service.gif";
    pics[10] = new Image();
    pics[10].src = "images/topnav-serviceOver.gif";
    pics[11] = new Image();
    pics[11].src = "images/topnav-login.gif";
    pics[12] = new Image();
    pics[12].src = "images/topnav-loginOver.gif";
    pics[13] = new Image();
    pics[13].src = "images/topnav-departments.gif";
    pics[14] = new Image();
    pics[14].src = "images/topnav-departmentsOver.gif";

  }
  
  // IMAGE SWAPPER
  function changer(from,to) {
    if(document.images) {
    document.images[from].src = pics[to].src;
    }
  }
  
  // TEXTAREA CHARACTER COUNTER
  function TrackCount(fieldObj,maxChars)
	{
	  var diff = maxChars - fieldObj.value.length;
	
	  // Need to check & enforce limit here also in case user pastes data
	  if (diff < 0)
	  {
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