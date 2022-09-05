<cfsetting enablecfoutputonly=true>
<cfprocessingdirective pageencoding="utf-8">
<!--- 
|| MIT LICENSE ||
$Copyright: (c) FreeEnterprise.com.au 2007 $

|| VERSION CONTROL ||
$Id: $
$Date: $
$Revision: $

|| DESCRIPTION || 
$Description: $
$TODO: $

|| DEVELOPER ||
$Developer: Carl Vanderpal (carl@freeenterprise.com.au)$

|| ATTRIBUTES ||
$in: $
$out:$
--->

<!--- 
	CrumbLevel 1/Multi
	showLinkCrumb
 --->


<!--- <cfparam name="showLinkCrumb" default=""> --->

<cfif thisTag.executionMode is "start">

<cfoutput>
<!--- Start Breadcrumb --->
<div id="breadCrumb">
	<ul>
		<li class="first"><a href="index.cfm">Home</a>
			
				<cfif structKeyExists(attributes, 'CrumbLevel') eq 1 and structKeyExists(attributes, 'showLinkCrumb')>
					<ul>
						<cfif listlen(attributes.showLinkCrumb, '|') gt 1>
							<cfloop list="#attributes.showLinkCrumb#" delimiters="|" index="i">
								<li><strong>&##187;</strong> #i#</li>
							</cfloop>
						<cfelse>
						<li><strong>&##187;</strong> #attributes.showLinkCrumb#</li>
						</cfif>
					</ul>
				</cfif>
				<cfif structKeyExists(attributes, 'CrumbLevel') neq 1 and structKeyExists(attributes, 'CategoryDisplay')>
					<ul>
						<li><strong>&##187;</strong> All Categories</li>
					</ul>
				</cfif>
		</li>
	</ul>
</div>
</cfoutput>

</cfif>

<!--- End Breadcrumb --->
<cfsetting enablecfoutputonly=false>