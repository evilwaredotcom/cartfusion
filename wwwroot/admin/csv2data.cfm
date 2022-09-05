<!------------------------------------------------------------------------------------------
Topic Custom Tag(CSV2DATA)
Created By Nischal Pathania
email nischal@shaktimedia.com
Update Date : November 16, 2002
Version 2.1
Visit our site www.shaktimedia.com
Description: This is a simple tag to store CSV file to data base. It is tested in Cold Fusion 4.5
with MS Access At windows 95 platform. But it has a capabilty of converting CSV file in any other
database too. Please try it and send your valueable comments to me for improving it.

Updation: Allow to enter empty data in between

Syntax:
<CF_CSV2DATA 
datasource="csv2data"
file="C:\file.csv"
table="plan"
column="field1,field2,field3,feild4,feild5"
columnhead="no"
datatype="CF_SQL_INTEGER,CF_SQL_VARCHAR,CF_SQL_VARCHAR,CF_SQL_INTEGER,CF_SQL_DOUBLE"
append="no"
>
Parameters Summary:
1. datasource(Required) :Datasource name of the database.
2. file(Required)		:CSV File name.
3. table(Required)		:Name of the table where CSV file to inserted.
4. column(Required/Optional): Column name in sequence as it is in CSV file.
5. columnhead(Optional)	: yes, if column name are listed in the first line of the CSV file. by default is no.
6. datatype(Optional)	: datatype of the column in same sequence. default CF_SQL_VARCHAR.
7. append(Optional)		: yes, if you wish to append CSV file into database	default is no.

Value of the datatype could be one of the following:
CF_SQL_BIGINT  		CF_SQL_IDSTAMP  	CF_SQL_REFCURSOR  		CF_SQL_BIT  	CF_SQL_INTEGER  
CF_SQL_SMALLINT  	CF_SQL_CHAR  		CF_SQL_LONGVARCHAR  	CF_SQL_TIME  	CF_SQL_DATE  
CF_SQL_MONEY  		CF_SQL_TIMESTAMP  	CF_SQL_DECIMAL  		CF_SQL_MONEY4  	CF_SQL_TINYINT  
CF_SQL_DOUBLE  		CF_SQL_NUMERIC  	CF_SQL_VARCHAR  		CF_SQL_FLOAT  	CF_SQL_REAL 
------------------------------------------------------------------------------------------>
<!--- Declaring optional parameter --->
<cfsetting enablecfoutputonly="Yes">

<cfparam name="attributes.append" default="no" type="boolean">
<cfparam name="attributes.columnhead" default="no" type="boolean">
<cfparam name="attributes.datatype" default="" type="string">
<cfparam name="attributes.columnnumber" type="numeric" default="1">

 <cftry>
	<cfif not parameterexists(attributes.datasource)>
		<cfthrow message="Custom tag CSV2DATA must contains <b>datasource</b> parameter">
	<cfelseif not parameterexists(attributes.file)>	
		<cfthrow message="Custom tag CSV2DATA must contains <b>file</b> parameter">
	<cfelseif not parameterexists(attributes.file)>	
		<cfthrow message="Custom tag CSV2DATA must contains <b>table</b> parameter">
	<cfelseif not attributes.columnhead>
		<cfif not parameterexists(attributes.column)>
			<cfthrow message="Custom tag CSV2DATA must contains <b>column</b> parameter">
		</cfif>
	</cfif>
	<cfif not FileExists(attributes.file)>
		<cfthrow message="please provide a valid path for the CSV file.">
	<cfelse>
		<!--- Reading File and storing in variable read_file --->
		<cffile action="READ" file="#attributes.file#" variable="read_file">
	</cfif>

<!--- Delete all records from the table if append is off --->
	<cfif not attributes.append>
		<cfquery datasource="#attributes.datasource#">
			delete from #attributes.table#
		</cfquery>
	</cfif>
	<cftransaction>
<!--- Loop for each line of the file --->	
	<cfset full_line = "">
	<cfloop index="line" list="#read_file#" delimiters="#chr(13)#">	
	<!--- Works only if line contains some character --->
		<cfif trim(line) is not "">
			<cfset quote_count = 0>
			<cfset search_word = """">
			<cfset full_line = full_line & line>
			<!--- Script for calculating number of double quote in full_word variable--->
			<cfscript>			
				for(i=1;i LTE len(full_line); i = i + 1){
					if(mid(full_line, i, len(search_word)) EQ search_word){
						quote_count = quote_count + 1;
					}					
				}		
			</cfscript>
			<cfif (quote_count MOD 2) EQ 1>
				<cfset full_line = full_line & chr(13) & chr(10)>
			<cfelse>
				<!--- Initilizing variables --->
				<cfset line = full_line>
				<cfset full_line = "">
				<cfset full_word = "">			
				<!--- 
					Putting a pair of double quotes at the first and last position if there is no data
					also in between if field is empty
				 --->
				 <!--- ADDING DOUBLE QOUTE IN BETWEEN --->
				<cfloop condition="#Find(',,',line)#">
					<cfset line=Rereplace(line,",,",","""",","ALL")>
				</cfloop>
				<cfset line=ReReplace(line,"^,",""""",","ALL")>
				<cfset line=ReReplace(line,",$",",""""","ALL")>
				
				<cfset quote_search =false>
				<cfset value_array = ArrayNew(1)>
				<!--- Loop for each field data separated by comma --->
				<cfloop index="word" list="#line#" delimiters=",">
					<!--- 
							Checking for first character whether it is double quote or not,
						If it is double quote then check how many double quotes are in this word
						if odd then add it to next elements else add it to array
					--->
					<cfset word = trim(word)>
					<cfif left(word,1) is """" or quote_search>				
						<cfset full_word = full_word & word>
						<!--- Initilizing quote_count --->
						<cfset quote_count = 0>
						<cfset search_word = """">
						<!--- Script for calculating number of double quote in full_word variable--->
						<cfscript>			
							for(i=1;i LTE len(full_word); i = i + 1){
								if(mid(full_word, i, len(search_word)) EQ search_word){
									quote_count = quote_count + 1;
								}					
							}		
						</cfscript>
						<cfif (quote_count MOD 2) EQ 0>				
							<cfset temp = ArrayAppend(value_array,replace(mid(full_word,2,len(full_word) - 2),"""""","""","ALL"))>							
							<cfset quote_search = false>
							<cfset full_word = "">							
						<cfelse>
							<cfset quote_search = true>
							<cfset full_word = full_word &	 ",">
						</cfif>
						
					<cfelse>
						<cfset temp = ArrayAppend(value_array, word)>
					</cfif>
				</cfloop>
				<!--- If columnhead is defined in CSV file then initilize column --->
				
				<cfif attributes.columnhead>			
					<cfset attributes.column = ArraytoList(value_array)>
					<cfset attributes.columnhead = "no">				
				<cfelse>
				<!--- Statement to insert in the database --->
					<cfif right(attributes.column,1) is ",">
						<cfset attributes.column = Left(attributes.column, Len(attributes.column) - 1)>
					</cfif>				
						<cfquery datasource="#attributes.datasource#">
							insert into #attributes.table# (#attributes.column#) values(
							<cfloop index="ele" from="1" to="#ListLen(attributes.column)#">
								<cfif trim(value_array[ele]) is "">
									<cfqueryparam null="Yes">					
								<cfelseif attributes.datatype is not "">
									<cfqueryparam value="#trim(value_array[ele])#" cfsqltype="CF_SQL_VARCHAR">
								<cfelse>
									<cfqueryparam value="#trim(value_array[ele])#" cfsqltype="CF_SQL_VARCHAR">
								</cfif>
								<cfif ele NEQ ListLen(attributes.column)>,</cfif>
							</cfloop>			
							)
						 </cfquery>
				</cfif>	
			</cfif>
		</cfif>
	</cfloop>
	</cftransaction>

<cfcatch type="Any">
	<font face="Arial">
		<b>Error in the Custom Tag &lt;CSV2DATA&gt;</b><br>
	</font>
	<font face="Arial" size="-1">
		<cfoutput>
			<u>#cfcatch.message#</u>
			#cfcatch.detail#
		</cfoutput>		
	</font>
<pre>
Syntax:
&lt;CF_CSV2DATA 
datasource="csv2data"
file="C:\file.csv"
table="plan"
column="field1,field2,field3,feild4,feild5"
columnhead="no"
datatype="CF_SQL_INTEGER,CF_SQL_VARCHAR,CF_SQL_VARCHAR,CF_SQL_INTEGER,CF_SQL_DOUBLE"
append="no"
&gt;
Parameters Summary:
1. datasource(Required)	 :Datasource name of the database.
2. file(Required)		   :CSV File name.
3. table(Required)		  :Name of the table where CSV file to inserted.
4. column(Required/Optional):Column name in sequence as it is in CSV file.
5. columnhead(Optional)	 :yes, if column name are listed in the first line of the CSV file. by default is no.
6. datatype(Optional)	   :datatype of the column in same sequence. default CF_SQL_VARCHAR.
7. append(Optional)		 :yes, if you wish to append CSV file into database	default is no.
</pre>
<cfabort>
</cfcatch>
</cftry>
<cfsetting enablecfoutputonly="No">