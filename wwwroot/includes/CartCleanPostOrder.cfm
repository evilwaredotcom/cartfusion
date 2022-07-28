<!--- DELETE ALL ITEMS IN CART --->
<cfinvoke component="#application.Common#" method="deleteCart">
	<cfinvokeargument name="SessionID" value="#SessionID#">
	<cfinvokeargument name="SiteID" value="#config.SiteID#">
</cfinvoke>

<CFCOOKIE NAME="CartFusion" VALUE="#SessionID#" EXPIRES="NOW">