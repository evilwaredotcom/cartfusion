<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<!--- DELETE ALL ITEMS IN CART --->
<cfscript>
	deleteCart = application.Common.deleteCart(SessionID=SessionID,SiteID=application.SiteID);
</cfscript>

<cfcookie name="CartFusion" value="#SessionID#" expires="now">