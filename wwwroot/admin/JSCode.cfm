<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<SCRIPT LANGUAGE="JavaScript">
// Set Page Title
top.document.title = document.title;

function updateInfo(FID,FValue,FColumn,FTable)
{ magicWindow("UpdateInfo.cfm?FID=" + FID + "&FValue=" + FValue + "&FColumn=" + FColumn + "&FTable=" + FTable); }

function updateCategory(FID,FValue,FColumn,FTable)
{ if (confirm('Are you sure you want to update all product values in this category or section?'))
  magicWindow("UpdateInfo.cfm?FID=" + FID + "&FValue=" + FValue + "&FColumn=" + FColumn + "&FTable=" + FTable); }

function magicWindow(FURL)
{ top.hidden.document.location = FURL; } // window.open(FURL); top.hidden.document.location = FURL;

function refreshPage(rURL)
{ top.main.document.location.href = rURL; }

function NewWindow(mypage, myname, w, h, scroll) 
{
	var winl = (screen.width - w) / 2;
	var wint = (screen.height - h) / 2;
	winprops = 'height='+h+',width='+w+',top='+wint+',left='+winl+',scrollbars='+scroll+',resizable'
	win = window.open(mypage, myname, winprops)
	if (parseInt(navigator.appVersion) >= 4) { win.window.focus(); }
}

function selectValue(FSelectBox)
{
	if (FSelectBox.selectedIndex == -1)
		return "";
	else
		return FSelectBox.options[FSelectBox.selectedIndex].value;
}

// Multiple Submit Buttons In A Form
function SubmitFormTo(val,meth)
{ 
	document.forms[0].action = val;
	document.forms[0].method = meth;
}

function autoChange(FIsPopulated,FRadioCheckbox)
{
	if (FIsPopulated.value != "")
		FRadioCheckbox.checked = true;
}
</script>
