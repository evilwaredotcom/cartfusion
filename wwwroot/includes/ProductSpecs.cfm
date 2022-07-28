<cfscript>
	/*getProductSpecs = application.Queries.getProductSpecs(ItemID=ItemID);
		if( getProductSpecs.RecordCount )	{
			getProductTypes = application.Queries.getProductTypes(TypeID=getProductSpecs.ProductType);
		}*/
</cfscript>


<!--- <!--- THIS IS THE START OF THE PRODUCT SPECIFICATIONS TABLE SET --->
<cfparam name="URL.PT" default="1">

<cfquery name="getProductSpecs" datasource="#datasource#">
	SELECT	*
	FROM	ProductSpecs
	WHERE	ItemID = #ItemID#
</cfquery>

<cfif getProductSpecs.RecordCount>
	<cfquery name="getProductTypes" datasource="#datasource#">
		SELECT	*
		FROM	ProductTypes
		WHERE	TypeID = #getProductSpecs.ProductType#
	</cfquery>
</cfif>

<cfif getProductSpecs.RecordCount AND isDefined('getProductTypes') AND getProductTypes.RecordCount>
	<table width="100%" border="0" <!--- style="border-color:<cfoutput>#layout.TableHeadingBGColor#</cfoutput>;" ---> cellpadding="0" cellspacing="0">
	<cfoutput query="getProductTypes">
	
	<!--- SPEC TITLES --->
		<tr>
			<td class="cfDefault" width="15%" valign="bottom"> 
				<table width="100%" border="0" cellpadding="3" cellspacing="1">					
					<cfloop from="1" to="#getProductTypes.SpecCount#" index="i">
						<cfset ThisSpecTitle = Evaluate("getProductTypes.SpecTitle" & i) >
					<tr>
						<td class="cfMini" bgcolor="#layout.TableHeadingBGColor#" nowrap >
							#ThisSpecTitle#&nbsp;
						</td>
					</tr>
					</cfloop>
				</table>
			</td>
	
		<!--- SPEC VALUES --->
		<cfloop query="getProductSpecs">
			<td class="cfDefault" width="85%" valign="top"> 
				<table width="100%" border="0" cellpadding="3" cellspacing="1">				
					<cfloop from="1" to="#getProductTypes.SpecCount#" index="i">
						<cfset ThisSpecValue = Evaluate("getProductSpecs.Spec" & i) >
						<tr>
							<td class="cfMini" bgcolor="#layout.PrimaryBGColor#" nowrap >
								#ThisSpecValue#&nbsp;
							</td>
						</tr>		
					</cfloop>
				</table>
			</td>
		</cfloop>				
		</tr>
	</cfoutput>
	</table>
<cfelse>
	<table border=0 <!--- style="border-color:<cfoutput>#layout.TableHeadingBGColor#</cfoutput>;" ---> cellpadding="0" cellspacing="0">
		<tr>
			<td class="cfErrorMsg">There are no additional specifications for this product</td>
		</tr>
	</table>	
</cfif>
<!--- THIS IS THE END OF THE PRODUCT SPECIFICATIONS TABLE SET ---> --->