<!--- UPS Date Convert YYYYMMDD --->

<cfparam name="ATTRIBUTES.DateValue" default="">
<cfparam name="ATTRIBUTES.DateType" default="">

<!--- Date YYYYMMDD --->
<cfif Len(ATTRIBUTES.DateTimeValue) eq 8 AND (ATTRIBUTES.DateTimeType eq "YYYYMMDD")>
	<cfset CALLER.DateTimeConvertError = 0>
	<cfset CALLER.YearValue = Left(ATTRIBUTES.DateTimeValue, 4)>
	<cfset CALLER.MonthValue = Mid(ATTRIBUTES.DateTimeValue, 5, 2)>
	<cfset CALLER.DayValue = Mid(ATTRIBUTES.DateTimeValue, 7, 2)>
	<cfset CALLER.DateTimeConverted = #CreateDate(CALLER.YearValue, CALLER.MonthValue, CALLER.DayValue)#>

<!--- Time HHMMSS --->
<cfelseif Len(ATTRIBUTES.DateTimeValue) eq 6 AND (ATTRIBUTES.DateTimeType eq "HHMMSS")>
	<cfset CALLER.DateTimeConvertError = 0>
	<cfset CALLER.HourValue = Left(ATTRIBUTES.DateTimeValue, 2)>
	<cfset CALLER.MinValue = Mid(ATTRIBUTES.DateTimeValue, 3, 2)>
	<cfset CALLER.SecValue = Mid(ATTRIBUTES.DateTimeValue, 5, 2)>
	<cfset CALLER.DateTimeConverted = #CreateTime(CALLER.HourValue, CALLER.MinValue, CALLER.SecValue)#>

<!--- Date YYYY-MM-DD --->
<cfelseif Len(ATTRIBUTES.DateTimeValue) eq 10 AND (ATTRIBUTES.DateTimeType eq "YYYY-MM-DD")>
	<cfset CALLER.DateTimeConvertError = 0>
	<cfset CALLER.YearValue = Left(ATTRIBUTES.DateTimeValue, 4)>
	<cfset CALLER.MonthValue = Mid(ATTRIBUTES.DateTimeValue, 6, 2)>
	<cfset CALLER.DayValue = Mid(ATTRIBUTES.DateTimeValue, 9, 2)>
	<cfset CALLER.DateTimeConverted = #CreateDate(CALLER.YearValue, CALLER.MonthValue, CALLER.DayValue)#>

<!--- Time HH:MM:SS --->
<cfelseif Len(ATTRIBUTES.DateTimeValue) eq 8 AND (ATTRIBUTES.DateTimeType eq "HH:MM:SS")>
	<cfset CALLER.DateTimeConvertError = 0>
	<cfset CALLER.HourValue = Left(ATTRIBUTES.DateTimeValue, 2)>
	<cfset CALLER.MinValue = Mid(ATTRIBUTES.DateTimeValue, 4, 2)>
	<cfset CALLER.SecValue = Mid(ATTRIBUTES.DateTimeValue, 6, 2)>
	<cfset CALLER.DateTimeConverted = #CreateTime(CALLER.HourValue, CALLER.MinValue, CALLER.SecValue)#>

<cfelse>
	<cfset CALLER.DateTimeConvertError = 1>
</cfif>
