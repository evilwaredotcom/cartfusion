
<cfif not isdefined("Attributes.method")>
<cfoutput>Attribute "Method" must be provided.</cfoutput>
<cfabort>
<cfelse>
<cfset method = Attributes.method>
</cfif>
<cfif not isdefined("Attributes.string")>
<cfoutput>Attribute "String" must be provided.</cfoutput>
<cfabort>
<cfelse>
<cfset string = Attributes.string>
</cfif>
<cfparam name="Attributes.result" default="result">
<cfif method is 'encrypt'>
		<cfset key = trim(tobase64(createuuid()))>
		<cfset newkey=left(key,5)&right(key,5)>
		<CFSET encrypted = encrypt(string, newkey)>
		<cfset enclength = len(encrypted)>
		<cfset halfone = 3>
		<cfset halftwo = enclength - halfone>
		<cfset result = left(newkey,3)&left(encrypted,3)&right(newkey,7)&right(encrypted,halftwo)>
		<cfset "Caller.#Attributes.result#" = #result#>
<cfelseif method is 'decrypt'>
		<cfset newkey = left(string,3)&mid(string,7,7)>
		<cfset length = len(string)-12>
		<cfset todecrypt = mid(string,4,3)&mid(string,14,length)>
		<cfset decrypted = decrypt(todecrypt,newkey)>
		<cfset "Caller.#Attributes.result#" = #decrypted#>
<cfelse>
		<cfoutput>Method #method# does not exist.</cfoutput>
</cfif>



