<cfcomponent displayname="Locale" output="false">
	<!--- Default locale --->
	<cfset loadLocale()>
	
	<cffunction name="dateLocaleFormat" access="public" returnType="string" output="false"
				hint="locale version of dateFormat">
		<cfargument name="date" type="date" required="true">
		<cfargument name="style" type="string" required="false" default="LONG">

		<cfscript>
//		var utcDate=dateConvert("local2Utc",arguments.date);
		var utcDate = arguments.date;
		return variables.aDateFormat.getDateInstance(variables.aDateFormat[arguments.style],variables.thisLocale).format(utcDate);
		</cfscript>
		
	</cffunction>

	<cffunction name="getAvailableLocales" access="public" returnType="array" output="false"
				hint="Returns an array of locales.">
		<cfscript>
		var i=0;
		var orgLocales=createObject("java","java.util.Locale").getAvailableLocales();
		var theseLocales=arrayNew(1);
		for (i=1; i LTE arrayLen(orgLocales); i=i+1) {
			if (listLen(orgLocales[i],"_") GT 1) {
			arrayAppend(theseLocales,orgLocales[i]);
			}
		} //for  
		return theseLocales;
		</cfscript>
	</cffunction>

	<cffunction name="getLocalizedDays" access="public" returnType="array" output="false"
				hint="Returns localized days">
		<cfscript>
		var localizedShortDays="";
		var i=0;
		var tmp=variables.dateSymbols.getShortWeekdays();
		// kludge java returns NULL first element in array so can't use arrayDeleteAt
		tmp=listToArray(arrayToList(tmp));
		// more kludge, fixup days to match week start
		switch (weekStarts()) {
			case 1:  //starts on sunday, just return day names
				localizedShortDays=tmp;
			break;

			case 2: // euro dates, starts on monday needs kludge
				localizedShortDays=arrayNew(1);
				localizedShortDays[7]=tmp[1]; //move sunday to last
				for (i=1; i LTE 6; i=i+1) {
					localizedShortDays[i]=tmp[i+1];
				}
			break;
			
			case 7: // starts saturday, usually arabic, needs kludge
				localizedShortDays=arrayNew(1);
				localizedShortDays[1]=tmp[7]; //move saturday to first
				for (i=1; i LTE 6; i=i+1) {
					localizedShortDays[i+1]=tmp[i];	
				}
			break;
		}
		return localizedShortDays;
		</cfscript>
	</cffunction>
	
	<cffunction name="getLocalizedMonth" access="public" returnType="string" output="false"
				hint="Returns localized month">
		<cfargument name="month" type="numeric" required="true">
		<cfscript>		
		variables.sDateFormat.init("MMMM",variables.thisLocale);
		return variables.sDateFormat.format(createDate(1999,arguments.month,1));
		</cfscript>
		
	</cffunction>

	<cffunction name="getLocalizedName" access="public" returnType="string" output="false"
				hint="Returns locale name from code">
		<cfargument name="thisLocale" type="string" required="true">
		<cfscript>
		var lang=listFirst(arguments.thisLocale,"_");
		var country=listLast(arguments.thisLocale,"_");
		var aLocale=createObject("java","java.util.Locale").init(lang,country);
		return aLocale.getDisplayName();
		</cfscript>
	</cffunction>

	<cffunction name="getLocalizedYear" access="public" returnType="string" output="false"
				hint="Returns localized year, probably only useful for BE calendars like in thailand, etc.">
		<cfargument name="thisYear" type="numeric" required="true">
		<cfscript>
		variables.sDateFormat.init("yyyy",variables.thisLocale);
		return variables.sDateFormat.init("yyyy",aLocale).format(createDate(arguments.thisYear,1,1));
		</cfscript>
	</cffunction>
	
	<cffunction name="isBIDI" access="public" returnType="boolean" output="false">
		<cfreturn variables.lang eq "ar" or variables.lang eq "iw">
	</cffunction>
	
	<cffunction name="loadLocale" access="public" returnType="void" output="false"
				hint="Loads a locale.">
		<cfargument name="locale" type="string" default="en_US" required="false">
		
		<cfif not listLen(arguments.locale,"_") is 2 or
			  not len(listFirst(arguments.locale,"_")) is 2 or
			  not len(listLast(arguments.locale,"_")) is 2>
			<cfthrow message="Specified locale must be of the form lang_country where lang and country are 2 characters each.">
		</cfif>
		
		<cfset variables.lang = listFirst(arguments.locale,"_")>
		<cfset variables.country = listLast(arguments.locale,"_")>

		<cfset variables.aLocale = createObject("java","java.util.Locale")>
		<cfset variables.thisLocale = variables.aLocale.init(variables.lang, variables.country)>
		<cfset variables.aDateFormat = createObject("java","java.text.DateFormat")>
		<cfset variables.sDateFormat = createObject("java","java.text.SimpleDateFormat")>
		<cfset variables.aCalendar = createObject("java","java.util.GregorianCalendar").init(variables.aLocale)>
		<cfset variables.dateSymbols=createObject("java","java.text.DateFormatSymbols").init(variables.aLocale)>
			
	</cffunction>

	<cffunction name="timeLocaleFormat" access="public" returnType="string" output="false"
				hint="locale version of timeFormat">
		<cfargument name="date" type="date" required="true">
		<cfargument name="style" type="string" required="false" default="SHORT">

		<cfscript>
//		var utcDate=dateConvert("local2Utc",arguments.date);
		var utcDate = arguments.date;
		return variables.aDateFormat.getTimeInstance(variables.aDateFormat[arguments.style],variables.thisLocale).format(utcDate);
		</cfscript>
		
	</cffunction>

	<cffunction name="weekStarts" access="public" returnType="string" output="false"
				hint="Determines the first DOW">
		<cfscript>	
		return variables.aCalendar.getFirstDayOfWeek();
		</cfscript>
	</cffunction>

</cfcomponent>