<cftimer label="Script execution time" type="inline"><!--- inline|outline|comment|debug --->
<cfoutput>
<cfset startTime = DateFormat(now(),'yyyy-mm-dd') & " " & TimeFormat(now(),'HH:mm:ss:L')>
Start time: #startTime#<br/>
<cfflush>
<!---
	do ftp to get zip in some other way - SQL job or CF schedule task
--->
<!---
	once zip is downloaded, get it, unzip it (if needed), parse it, and format it for GP import
--->
<cfscript>
	//
	// variables - vendor code, file names and locations
	//	
	vendorCode = "GS";
	vendorFile = "3GreenSupply-TentsALL.csv";
	hasZipFile = false;
	vendorZipFile = "only_if_zipped_and_needs_unzipping.zip";
	if (cgi.http_host CONTAINS "local") {
		doSendMail = false;
	} else {
		doSendMail = false; //true;
	}
	
	// downloaded zip file location
	if (hasZipFile) {
		zipFileDirectory = "C:\webroot\GreenPeakSupply\wwwroot\admin\vendorInventories\#vendorCode#";
		zipFileName = vendorZipFile;
		zipFile = zipFileDirectory & "\" & zipFileName;
	}
	
	// file info for unzip
	unzipFileDirectory = "C:\webroot\GreenPeakSupply\wwwroot\admin\vendorInventories\#vendorCode#";
	unzipFileName = vendorFile; //default
	unzipFile = unzipFileDirectory & "\" & unzipFileName;
	
	// where to write the formatted file
	formatFileDirectory = "C:\webroot\GreenPeakSupply\wwwroot\admin\vendorInventories\#vendorCode#";
	formatFileName = "inventory#vendorCode#.txt"; //default
	formatFile = formatFileDirectory & "\" & formatFileName;
	
	// where to copy the formatted file for import into GP and GPIntegration
	if (cgi.http_host CONTAINS "local") {
		importFileDirectory = "C:\webroot\GreenPeakSupply\wwwroot\admin\vendorInventories\#vendorCode#"; //test
	} else {
		importFileDirectory = "C:\webroot\GreenPeakSupply\wwwroot\admin\vendorInventories\#vendorCode#"; //live
	}
	importFileName = "inventory#vendorCode#.txt";
	importFile = importFileDirectory & "\" & importFileName;
	
	archiveFileDirectory = "C:\webroot\GreenPeakSupply\wwwroot\admin\vendorInventories\archives";
	archiveFileName = "inventory#vendorCode#_#DateFormat(Now(),'mm_dd_yy')#.txt";
	archiveFile = archiveFileDirectory & "\" & archiveFileName;
	
	// file row string
	row = "";
	
</cfscript>
----------------------------------------------------------------------------------------------------<br/>
Running inventory file feed import formatting for vendor code: #vendorCode#<br/>
----------------------------------------------------------------------------------------------------<br/>
<cfflush>

<!---
	delete existing inventory file (already imported, data safe)
--->
<!--- only if you immediately move the file to this location AFTER deleting it
<cfif FileExists(zipFile)>
	<cffile action="delete" file="#zipFile#">
</cfif>
--->
<cfif hasZipFile AND FileExists(unzipFile)>
	<cffile action="delete" file="#unzipFile#">
	Deleted existing unzipFile: #unzipFile#<br/>
	<cfflush>
</cfif>
<cfif FileExists(formatFile)>
	<cffile action="delete" file="#formatFile#">
	Deleted existing formatFile: #formatFile#<br/>
	<cfflush>
</cfif>
<cfif FileExists(importFile)>
	<cffile action="delete" file="#importFile#">
	Deleted existing importFile: #importFile#<br/>
	<cfflush>
</cfif>

<!---
	unzip downloaded (via ftp) file
--->
<cfif (hasZipFile)>
	<cfzip action="unzip" destination="#unzipFileDirectory#" file="#zipFile#" overwrite="yes" />
	Unzipped zip file: #zipFile# to #unzipFile#<br/>
	<cfflush>
</cfif>

<!--- works, woohoo
<cfdump var="#unzipFile#">
--->








<!--- read vendor inventory file into a variable --->
<cffile action="read" file="#unzipFile#" variable="varInvFile" />









<!---
	Save CSV data values. Here, we are creating a CSV data
	value that has both qualified and non-qualified field
	values, populated and empty field values, and embedded
	field qualifiers and field/line delimiters.
--->
<!---<cfsavecontent variable="strCSV">
"Name","Nick Name","Age","Hair Color"
Kim,"Kim ""Hot Legs"" Smith",24,"Brunette"
"Sarah Vivenz, II","Stubs",27,"Brunette"
"Kit Williams",Kitty,34,Blonde,,,
"Even
Values With
Embedded Line Breaks"
</cfsavecontent>--->
<cfset strCSV = varInvFile>

<!--- Trim data values. --->
<cfset strCSV = Trim( strCSV ) />
<!---
	Get the regular expression to match the tokens. I have
	put the delimiter value on the first line and field value
	on the second line for easier reading.
--->
<cfset strRegEx = (
	"\G(,|\r?\n|\r|^)" &
	"(?:""([^""]*+(?>""""[^""]*+)*)""|([^"",\r\n]*+))"
	) />
<!---
	Create a compiled Java regular expression pattern object
	based on the pattern above.
--->
<cfset objPattern = CreateObject(
	"java",
	"java.util.regex.Pattern"
	).Compile(
		JavaCast( "string", strRegEx )
		)
	/>
<!---
	Get the pattern matcher for our target text (the CSV data).
	This will allows us to iterate over all the data fields.
--->
<cfset objMatcher = objPattern.Matcher(
	JavaCast( "string", strCSV )
	) />
<!---
	Create an array to hold the CSV data. We are going
	to create an array of arrays in which each nested
	array represents a row in the CSV data file.
--->
<cfset arrData = ArrayNew( 1 ) />
<!--- Start off with a new array for the new data. --->
<cfset ArrayAppend( arrData, ArrayNew( 1 ) ) />
<!---
	Here's where the magic is taking place; we are going
	to use the Java pattern matcher to iterate over each
	of the CSV data fields using the regular expression
	we defined above.
 
	Each match will have at least the field value and
	possibly an optional trailing delimiter.
--->
<cfloop condition="objMatcher.Find()">
	<!---
		Get the delimiter. We know that the delimiter will
		always be matched, but in the case that it matched
		the START expression, it will not have a length.
	--->
	<cfset REQUEST.Delimiter = objMatcher.Group(
		JavaCast( "int", 1 )
		) />
	<!---
		Check for delimiter length and is not the field
		delimiter. This is the only time we ever need to
		perform an action (adding a new line array).
	--->
	<cfif (REQUEST.Delimiter NEQ ",")>
		<!--- Start new row data array. --->
		<cfset ArrayAppend(
			arrData,
			ArrayNew( 1 )
			) />
	</cfif>
	<!---
		Get the field token value in group 2 (which may
		not exist if the field value was not qualified.
	--->
	<cfset REQUEST.Value = objMatcher.Group(
		JavaCast( "int", 2 )
		) />
	<!---
		Check to see if the value exists. If it doesn't exist,
		then we want the non-qualified field. If it does exist,
		then we want to replace any escaped embedded quotes.
	--->
	<cfif StructKeyExists( REQUEST, "Value" )>
		<!---
			Replace escpaed quotes with an unescaped double
			quote. No need to perform regex for this.
		--->
		<cfset REQUEST.Value = Replace(
			REQUEST.Value,
			"""""",
			"""",
			"all"
			) />
	<cfelse>
		<!---
			No qualified field value was found, so use group
			3 - the non-qualified alternative.
		--->
		<cfset REQUEST.Value = objMatcher.Group(
			JavaCast( "int", 3 )
			) />
	</cfif>
	<!--- Add the field value to the row array. --->
	<cfset ArrayAppend(
		arrData[ ArrayLen( arrData ) ],
		REQUEST.Value
		) />
</cfloop>
<!--- Dump out CSV data array. --->
<!---<cfdump
	var="#arrData#"
	label="CSV File Data"
	/>
<cfabort>--->






















<!--- write and apply header to a new "formatted" file --->
<cfset row = "">
<cfset row = "item,vendorcode,totalqty,status,eta">
<cffile action="WRITE" file="#formatFile#" output="#row#" addnewline="true" />
Wrote header to formatFile: #formatFile#<br/>
<cfflush>




<!---
	parse vendor inventory file and format it to "formatted" file, line by line
	: CUSTOM TO VENDOR
--->
<cfset row = "">
<cfset count = 0>
Total records formatted and written so far: #count#<br/>
<cfflush>

<cftimer label="Array dump time" type="inline"><!--- inline|outline|comment|debug --->
<!---<cfdump var="#arrData#">--->
<cfloop array="#arrData#" index="a">
<!---<cfdump var="#i#"><br/>
<cfflush>--->
<cfif IsDefined("a[1]") AND a[1] NEQ "SKU">
<cfscript>
	//<!---ItemID--->
	SiteID = 1;
	SKU = a[1];
	ManufacturerID = a[10];
	ItemName = a[3];
	ItemDescription = a[6];
	ItemDetails = "";
	ShortDescription = a[20];
	Comments = "";
	
	Category = 1;
	OtherCategories = a[12] &","& a[11];
	SectionID = 0;
	OtherSections = a[11] &","& a[12];
	
	CompareType = 0;
	
	ImageDir = "images/gs";
	Image = ReplaceNoCase(a[2],"http://www.inventorysource.com/images/gs/",""); //GS44217.jpg
	ImageSmall = ReplaceNoCase(a[13],"http://www.inventorysource.com/images/gs/",""); //t_GS44217.jpg
	ImageLarge = ReplaceNoCase(a[2],"http://www.inventorysource.com/images/gs/",""); //GS44217.jpg
	ImageAlt = "";
	ImageAltLarge = "";
	
	/*<!---
	Attribute1 = "";
	Attribute2 = "";
	Attribute3 = "";
	--->*/
	
	OptionName1 = "";
	OptionName2 = "";
	OptionName3 = "";
	/*<!---
	OptionName4 = "";
	OptionName5 = "";
	OptionName6 = "";
	OptionName7 = "";
	OptionName8 = "";
	OptionName9 = "";
	OptionName10 = "";
	OptionName11 = "";
	OptionName12 = "";
	OptionName13 = "";
	OptionName14 = "";
	OptionName15 = "";
	OptionName16 = "";
	OptionName17 = "";
	OptionName18 = "";
	OptionName19 = "";
	OptionName20 = "";
	--->*/
	Option1Optional = 0;
	Option2Optional = 0;
	Option3Optional = 0;
	/*<!---
	Option4Optional = false;
	Option5Optional = false;
	Option6Optional = false;
	Option7Optional = false;
	Option8Optional = false;
	Option9Optional = false;
	Option10Optional = false;
	Option11Optional = false;
	Option12Optional = false;
	Option13Optional = false;
	Option14Optional = false;
	Option15Optional = false;
	Option16Optional = false;
	Option17Optional = false;
	Option18Optional = false;
	Option19Optional = false;
	Option20Optional = false;
	--->*/
	
	Weight = a[14];
	DimLength = 0;
	DimWidth = 0;
	DimHeighth = 0;
	
	CostPrice = a[8];
	ListPrice = a[16];
	SalePrice = a[15];
	Price1 = a[16];
	Price2 = a[15];
	
	Hide1 = 0;
	Hide2 = 0;
	
	Taxable = 1;
	StockQuantity = a[4];
	SellByStock = 1;
	ItemStatus = "IS";
	DisplayOrder = 0;
	Featured = 0;
	
	SoftwareDownload = 0;
	SoftwareAttachment = 0;
	DaysAvailable = 0;
	DownloadLocation = "";
	
	DistributorID = 1;
	ItemClassID = 1;
	
	UseMatrix = 0; //variations
	
	//RProSID = "";
	//rdi_date_removed = "";
	
	fldShipByWeight = 1;
	fldShipWeight = a[14];
	fldShipAmount = 4.00;
	fldHandAmount = 1.00;
	fldOversize = 0;
	fldShipCode = 1;
	
	Deleted = 0;
	DateCreated = dateFormat(now(),"mm/dd/yyyy") &" "& timeFormat(now(),"HH:mm:ss");
	DateUpdated = dateFormat(now(),"mm/dd/yyyy") &" "& timeFormat(now(),"HH:mm:ss");
	UpdatedBy = "MARTY";
	
	Volume = 0;
	
	/*<!---
	QB = "";
	QB_ACCNT = "";
	QB_ASSETACCNT = "";
	QB_COGSACCNT = "";
	QB_SALESTAXCODE = "";
	QB_PREFVEND = "";
	QB_SUBITEM = "";
	QB_REORDERPOINT = 1;
	QB_PAYMETH = "";
	QB_TAXVEND = "";
	--->*/
</cfscript>
<cfquery name="insertProduct" datasource="#application.dsn#">
INSERT INTO	Products (
	<!---[ItemID]--->
	[SiteID]
	,[SKU]
	,[ManufacturerID]
	,[ItemName]
	,[ItemDescription]
	,[ItemDetails]
	,[ShortDescription]
	,[Comments]
	
	,[Category]
	,[OtherCategories]
	,[SectionID]
	,[OtherSections]
	
	,[CompareType]
	
	,[ImageDir]
	,[Image]
	,[ImageSmall]
	,[ImageLarge]
	,[ImageAlt]
	,[ImageAltLarge]
	
	<!---
	,[Attribute1]
	,[Attribute2]
	,[Attribute3]
	--->
	
	,[OptionName1]
	,[OptionName2]
	,[OptionName3]
	<!---
	,[OptionName4]
	,[OptionName5]
	,[OptionName6]
	,[OptionName7]
	,[OptionName8]
	,[OptionName9]
	,[OptionName10]
	,[OptionName11]
	,[OptionName12]
	,[OptionName13]
	,[OptionName14]
	,[OptionName15]
	,[OptionName16]
	,[OptionName17]
	,[OptionName18]
	,[OptionName19]
	,[OptionName20]
	--->
	,[Option1Optional]
	,[Option2Optional]
	,[Option3Optional]
	<!---
	,[Option4Optional]
	,[Option5Optional]
	,[Option6Optional]
	,[Option7Optional]
	,[Option8Optional]
	,[Option9Optional]
	,[Option10Optional]
	,[Option11Optional]
	,[Option12Optional]
	,[Option13Optional]
	,[Option14Optional]
	,[Option15Optional]
	,[Option16Optional]
	,[Option17Optional]
	,[Option18Optional]
	,[Option19Optional]
	,[Option20Optional]
	--->
	
	,[Weight]
	,[DimLength]
	,[DimWidth]
	,[DimHeighth]
	
	,[CostPrice]
	,[ListPrice]
	,[SalePrice]
	,[Price1]
	,[Price2]
	
	,[Hide1]
	,[Hide2]
	
	,[Taxable]
	,[StockQuantity]
	,[SellByStock]
	,[ItemStatus]
	,[DisplayOrder]
	,[Featured]
	
	,[SoftwareDownload]
	,[SoftwareAttachment]
	,[DaysAvailable]
	,[DownloadLocation]
	
	,[DistributorID]
	,[ItemClassID]
	,[UseMatrix]
	
	<!---,[RProSID]
	,[rdi_date_removed]--->
	
	,[fldShipByWeight]
	,[fldShipWeight]
	,[fldShipAmount]
	,[fldHandAmount]
	,[fldOversize]
	,[fldShipCode]
	
	,[Deleted]
	,[DateCreated]
	,[DateUpdated]
	,[UpdatedBy]
	
	,[Volume]
	
	<!---
	,[QB]
	,[QB_ACCNT]
	,[QB_ASSETACCNT]
	,[QB_COGSACCNT]
	,[QB_SALESTAXCODE]
	,[QB_PREFVEND]
	,[QB_SUBITEM]
	,[QB_REORDERPOINT]
	,[QB_PAYMETH]
	,[QB_TAXVEND]
	--->
) VALUES (
	<!---#ItemID#--->
	#SiteID#
	,'#SKU#'
	,'#ManufacturerID#'
	,'#ItemName#'
	,'#ItemDescription#'
	,'#ItemDetails#'
	,'#ShortDescription#'
	,'#Comments#'
	
	,#Category#
	,'#OtherCategories#'
	,#SectionID#
	,'#OtherSections#'
	
	,#CompareType#
	
	,'#ImageDir#'
	,'#Image#'
	,'#ImageSmall#'
	,'#ImageLarge#'
	,'#ImageAlt#'
	,'#ImageAltLarge#'
	
	<!---
	,'#Attribute1#'
	,'#Attribute2#'
	,'#Attribute3#'
	--->
	
	,'#OptionName1#'
	,'#OptionName2#'
	,'#OptionName3#'
	<!---
	,'#OptionName4#'
	,'#OptionName5#'
	,'#OptionName6#'
	,'#OptionName7#'
	,'#OptionName8#'
	,'#OptionName9#'
	,'#OptionName10#'
	,'#OptionName11#'
	,'#OptionName12#'
	,'#OptionName13#'
	,'#OptionName14#'
	,'#OptionName15#'
	,'#OptionName16#'
	,'#OptionName17#'
	,'#OptionName18#'
	,'#OptionName19#'
	,'#OptionName20#'
	--->
	,#Option1Optional#
	,#Option2Optional#
	,#Option3Optional#
	<!---
	,#Option4Optional#
	,#Option5Optional#
	,#Option6Optional#
	,#Option7Optional#
	,#Option8Optional#
	,#Option9Optional#
	,#Option10Optional#
	,#Option11Optional#
	,#Option12Optional#
	,#Option13Optional#
	,#Option14Optional#
	,#Option15Optional#
	,#Option16Optional#
	,#Option17Optional#
	,#Option18Optional#
	,#Option19Optional#
	,#Option20Optional#
	--->
	
	,#Weight#
	,#DimLength#
	,#DimWidth#
	,#DimHeighth#
	
	,#CostPrice#
	,#ListPrice#
	,#SalePrice#
	,#Price1#
	,#Price2#
	
	,#Hide1#
	,#Hide2#
	
	,#Taxable#
	,#StockQuantity#
	,#SellByStock#
	,'#ItemStatus#'
	,#DisplayOrder#
	,#Featured#
	
	,#SoftwareDownload#
	,#SoftwareAttachment#
	,#DaysAvailable#
	,'#DownloadLocation#'
	
	,#DistributorID#
	,#ItemClassID#
	,#UseMatrix#
	
	<!---,'#RProSID#'
	,'#rdi_date_removed#'--->
	
	,#fldShipByWeight#
	,#fldShipWeight#
	,#fldShipAmount#
	,#fldHandAmount#
	,#fldOversize#
	,'#fldShipCode#'
	
	,#Deleted#
	,'#DateCreated#'
	,'#DateUpdated#'
	,'#UpdatedBy#'
	
	,#Volume#
	
	<!---
	,'#QB#'
	,'#QB_ACCNT#'
	,'#QB_ASSETACCNT#'
	,'#QB_COGSACCNT#'
	,'#QB_SALESTAXCODE#'
	,'#QB_PREFVEND#'
	,'#QB_SUBITEM#'
	,#QB_REORDERPOINT#
	,'#QB_PAYMETH#'
	,'#QB_TAXVEND#'
	--->
)
</cfquery>
</cfif>
<!--- append csv string to file 
<cffile action="APPEND" file="#formatFile#" output="#row#" addnewline="true">--->


</cfloop>
</cftimer>
<cfabort>

<!---
	copy file and send to gp server so sql agent can run job
--->
<cffile action="copy" source="#formatFile#" destination="#importFile#">
	<br/><br/>Copied formatFile to: #importFile#<br/>
	<cfflush>
<!--- archive the file in the Archives folder --->
<cffile action="copy" source="#formatFile#" destination="#archiveFile#">
	<br/><br/>Archived formatFile to: #archiveFile#<br/>
	<cfflush>

<!--- send confirmation of file status --->
<!--- create customg tag or include for notification --->
<cfif (doSendMail)>
<cfmail to="mcgee.marty@gmail.com" from="mcgee.marty@gmail.com" 
		subject="#vendorCode# Vendor Inventory Processed" type="html">
	The following file was created and copied for importation:<br/>
	#formatFile#<br/>
	#count# items processed.<br/>
</cfmail>
	Sent creation notification email<br/>
	<cfflush>
</cfif>
	
	<br/>
	The following file was created and copied to GP-Shared for importation:<br/>
	<u>#formatFile#</u> to <u>#importFile#</u><br/>
	<br/>
	<b>#count# items processed. DONE!</b><br/>
	----------------------------------------------------------------------------------------------------<br/>
	Thank you for shopping S-MART.  Have an amazing day.<br/>
	----------------------------------------------------------------------------------------------------<br/>
	
<cfset endTime = DateFormat(now(),'yyyy-mm-dd') & " " & TimeFormat(now(),'HH:mm:ss:L')>
	End time: #endTime#<br/>

</cfoutput>

</cftimer>

<!---
	end
---->