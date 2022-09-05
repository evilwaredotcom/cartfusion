<!--- 
|| MIT LICENSE
|| CartFusion.com
--->


<cfset WeekAgo = DateAdd("d", -7, Now()) >

<!--- DELETE ALL ITEMS IN CART OLDER THAN 1 WEEK --->
<cfquery name="clearCart" datasource="#application.dsn#">
	DELETE
	FROM	Cart
	WHERE	DateEntered <= #WeekAgo#
</cfquery>
