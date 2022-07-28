<cfoutput>
<cfif session.CustomerArray[26] NEQ ''>
	<font class="cfWhite">
	<img src="images/image-BoxWhite.jpg" hspace="2" align="absmiddle"> Welcome #session.CustomerArray[1]#! (<a href="#config.RootURL#/CA-LoginCheck.cfm?Logout=1"><font class="cfWhite">logout</font></a>)
	</font>
<cfelseif session.CustomerArray[28] NEQ '' AND session.CustomerArray[28] NEQ 1>
	<cfquery name="getUser" datasource="#datasource#" cachedwithin="#CreateTimeSpan(0,0,10,0)#">
		SELECT 	UName
		FROM	Users
		WHERE	UID = #session.CustomerArray[28]#
	</cfquery>
	<cfif getUser.RecordCount NEQ 0>
	<font class="cfWhite">
	<img src="images/image-BoxWhite.jpg" hspace="2" align="absmiddle"> Welcome #getUser.UName#! (<a href="#config.RootURL#/CA-LoginCheck.cfm?Logout=1"><font class="cfWhite">logout</font></a>)
	</font>
	</cfif>
<cfelse>
	&nbsp;
</cfif>
</cfoutput>