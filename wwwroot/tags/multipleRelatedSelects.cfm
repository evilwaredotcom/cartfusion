<cfparam name="attributes.Query">
<cfparam name="attributes.SelectBoxes" default=0>
<cfparam name="msg" default="">
<cfparam name="attributes.FunctionName" default="Sel">

<cfscript>
	if ( len(attributes.Query) eq 0 )
		msg= msg & "<br>Please specify a query to be processed." ;
	if ( not isnumeric(attributes.SelectBoxes) or attributes.SelectBoxes eq 0 )
		msg= msg & "<br>Please enter a positive integer for the number of select boxes you want." ;
	if ( not isdefined("attributes.FormName") )
		msg= msg & "<br>Please specify a form name." ;
</cfscript>
<cfloop from="1" to="#attributes.SelectBoxes#" index="sel">
  <cfif not isdefined("attributes.Value#sel#")>
	 <cfset msg=msg & "<br>Please specify the value attribute for each select box. For eg. Value1, Value2 .....till the number of SelectBoxes">
  </cfif>
  <cfif not isdefined("attributes.FieldName#sel#")>
	 <cfset msg=msg & "<br>Please specify the form field name attribute for each select box. For eg. FieldName1, FieldName1 .....till the number of SelectBoxes">
  </cfif>
</cfloop>

<cfif len(msg) eq 0>
<!---Tag Code--->
<cfset qry=#evaluate("caller." & attributes.Query)#>

<cfloop from="1" to="#attributes.SelectBoxes#" index="SelBox">
<cfquery name="getDetail#SelBox#" dbtype="query">
	SELECT 	#evaluate("attributes.Value" & SelBox)#, OptionImage
	FROM	qry
	GROUP BY #evaluate("attributes.Value" & SelBox)#, OptionImage
	ORDER BY ICCID
</cfquery>
</cfloop>

<!---
<SCRIPT LANGUAGE="JavaScript">
<!--
	if(document.images) {
		colors = new Array();
		<cfif attributes.SelectBoxes GTE 1 >
		<cfoutput query="getDetail1">
		colors['#DETAIL1#'] = new Image();
		colors['#DETAIL1#'].src = "images/products/#OptionImage#";
		</cfoutput>
		</cfif>
	}
	function swapper(from,to) {
		if (to != 0){
			if(document.images) {
			document.images[from].src = colors[to].src;
			}
		}
	}
//-->
</SCRIPT>
--->

<!---
<cfif attributes.SelectBoxes GTE 2 >
<cfoutput query="getDetail2">
colors['#DETAIL2#'] = new Image();
colors['#DETAIL2#'].src = "images/products/#OptionImage#";
</cfoutput>
</cfif>
<cfif attributes.SelectBoxes GTE 3 >
<cfoutput query="getDetail3">
colors['#DETAIL3#'] = new Image();
colors['#DETAIL3#'].src = "images/products/#OptionImage#";
</cfoutput>
</cfif>
--->

<!---
<cfdump var="#getDetail1#">
<cfdump var="#getDetail2#">
<cfdump var="#getDetail3#">
--->

<cfloop from="1" to="#attributes.SelectBoxes#" index="SelBox">
<cfoutput>
   <select name="#evaluate("attributes.FieldName" & SelBox)#" class="cfFormField" 
   	onchange="<!---<cfif SelBox EQ 1 >swapper('img1',this.options[this.selectedIndex].value);</cfif>---> <cfif SelBox lt attributes.SelectBoxes>#attributes.FunctionName#(this,#evaluate(SelBox-1)#,this.form.#evaluate("attributes.FieldName" & (SelBox+1))#,new Array(<cfloop from="#(SelBox+1)#" to="#attributes.SelectBoxes#" index="nextSel">this.form.#evaluate("attributes.FieldName" & (nextSel))#<cfif nextSel lt attributes.SelectBoxes>,</cfif></cfloop>))</cfif>;">
</cfoutput>
	<option value="">Choose ---</option>
	<cfoutput query="getDetail#SelBox#" Group="#evaluate("attributes.Value" & SelBox)#">
		<cfif evaluate("attributes.value" & SelBox) NEQ 1 >
		<option value="#evaluate(evaluate("attributes.value" & SelBox))#" <cfif isdefined("attributes.SelectedValue" & SelBox) and evaluate("attributes.SelectedValue" & SelBox) eq evaluate(evaluate("attributes.value" & SelBox))>SELECTED</cfif>><cfif isdefined("attributes.Display#SelBox#")>#evaluate(evaluate("attributes.Display" & SelBox))#<cfelse>#evaluate(evaluate("attributes.Value" & SelBox))#</cfif></option>
		</cfif>
	</cfoutput>
</select>
<cfoutput>
	<cfif isdefined("attributes.HtmlAfter#SelBox#")>#evaluate("attributes.HtmlAfter" & SelBox)#</cfif></cfoutput>
</cfloop>


			
<script language="JavaScript">
	var optValArr = new Array();
	<cfset loopCtr = 0>

	<cfoutput query="qry">
		optValArr[#loopCtr#] = new Array(<cfloop from="1" to="#attributes.Selectboxes#" index="item">new Array("<cfif isdefined("attributes.Display#item#")>#evaluate(evaluate("attributes.Display" & item))#<cfelse>#evaluate(evaluate("attributes.Value" & item))#</cfif>","#evaluate(evaluate("attributes.Value" & item))#") <cfif item lt attributes.Selectboxes>,</cfif></cfloop>);
		<cfset loopCtr=incrementValue(loopCtr)>
	</cfoutput>

	<cfoutput>
	
	<cfset selList="">
	<cfloop from="1" to="#attributes.SelectBoxes#" index="item">
		<cfset selList=ListAppend(selList,"Sel" & item)>
	</cfloop>

   	function #attributes.FunctionName#(thisSel,pos,nextSel,subNodes) {
	   for (i = 0; i < subNodes.length; i++) {
				  subNodes[i].options.length=0;
				  subNodes[i].options[0]=new Option(" ","");
	   }
	   if(thisSel.options[thisSel.selectedIndex].value != "") {
				  optPos=1;
				  lastVal="";
				  for (i = 0; i < optValArr.length; i++) {
							 if(optValArr[i][pos][1]==thisSel.options[thisSel.selectedIndex].value){
								if(optValArr[i][eval(pos+1)][1]!=lastVal){
										lastVal=optValArr[i][eval(pos+1)][1];
										subNodes[0].options[optPos]=new Option(optValArr[i][eval(pos+1)][0],optValArr[i][eval(pos+1)][1]);
										optPos++;
								}
							}
				  }
		}
	}
	</cfoutput>
</script>

<!---tag code ends--->
<cfelse>
	<CFTHROW detail="#msg#" message="Error encountered while processing.">
</cfif>