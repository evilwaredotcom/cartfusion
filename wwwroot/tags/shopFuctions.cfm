<!--- 
|| MIT LICENSE
|| CartFusion.com
--->



<cfscript>
	// Makes Capital First Letter of a string  
	function CapFirst(str) {
		var newstr = "";
		var word = "";
		var i = 1;
		var strlen = listlen(str," ");
		for(i=1;i lte strlen;i=i+1) {
			word = ListGetAt(str,i," ");
			newstr = newstr & UCase(Left(word,1));
			if(len(word) gt 1) newstr = newstr & Right(word,Len(word)-1);
			if(i lt strlen) newstr = newstr & " ";
		}
		return newstr;
	}
	
	// Use this price
	function UseThisPrice()	{
	
	}
	
	
	// Get Cart Contents
	function getCartContents()	{
	
	}
	
	// Get Cart Minimums
	function cartMinimums()	{
	
	}
</cfscript>
