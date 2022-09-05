<cfparam name="url.pt" default="1">

<cfscript>
	/*
		THIS IS THE START OF THE PRODUCT SPECIFICATIONS TABLE SET
		Added By Carl Vanderpal 20 June 2007
	*/
	getProductSpecs = application.Queries.getProductSpecs(ItemID=ItemID);
		if( getProductSpecs.RecordCount )	{
			getProductTypes = application.Queries.getProductTypes(TypeID=getProductSpecs.ProductType);
		}
</cfscript>

<cfoutput>

<cfif getProductSpecs.RecordCount and isDefined('getProductTypes') and getProductTypes.RecordCount>
	
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<cfloop query="getProductTypes">
		
		<!--- SPEC TITLES --->
		<tr>
			<td class="cfDefault" width="15%" valign="bottom"> 
				<table width="100%" border="0" cellpadding="3" cellspacing="1">					
					<cfloop from="1" to="#getProductTypes.SpecCount#" index="i">
						<cfset ThisSpecTitle = Evaluate("getProductTypes.SpecTitle" & i) >
					<tr>
						<td class="cfMini" nowrap >
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
							<td class="cfMini" nowrap >
								#ThisSpecValue#&nbsp;
							</td>
						</tr>		
					</cfloop>
				</table>
			</td>
		</cfloop>				
		</tr>
		
		</cfloop>
	</table>
	
	<cfelse>
	
		<div align="center">
			<p>There are no additional specifications for this product</p>
		</div>

</cfif>

</cfoutput>
<br/>