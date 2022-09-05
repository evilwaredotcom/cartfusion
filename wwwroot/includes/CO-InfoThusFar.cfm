<cfoutput>
<table width="100%" border="0" cellpadding="10" cellspacing="0" align="center">
	<tr>
		<td width="33%" class="cfDefault" valign="top">
			<b>Billing Information: <a href="CO-Billing.cfm?errorBilling=0" class="cfMini">(Edit)</a></b><br/>
			#session.CustomerArray[1]# #session.CustomerArray[2]#<br/>
			#session.CustomerArray[3]#<br/>
			<cfif trim(session.CustomerArray[4]) NEQ '' >#session.CustomerArray[4]#<br/></cfif>
			#session.CustomerArray[5]#, #session.CustomerArray[6]# #session.CustomerArray[7]#<br/>
			#session.CustomerArray[8]#<br/>
			#session.CustomerArray[9]#<br/>
			#session.CustomerArray[11]#<br/>
		</td>
		<td width="33%" class="cfDefault" valign="top">
			<b>Shipping Information: <a href="CO-Billing.cfm?errorBilling=0" class="cfMini">(Edit)</a></b><br/>
			<!--- CARTFUSION 4.5 - MULTIPLE SHIPPING ADDRESSES --->
			<cfif application.EnableMultiShip EQ 1 >
				Please See Order Summary...
			<cfelse>
				#session.CustomerArray[18]# #session.CustomerArray[19]#<br/>
				#session.CustomerArray[20]#<br/>
				<cfif TRIM(session.CustomerArray[21]) NEQ '' >#session.CustomerArray[21]#<br/></cfif>
				#session.CustomerArray[22]#, #session.CustomerArray[23]# #session.CustomerArray[24]#<br/>
				#session.CustomerArray[25]#
			</cfif>
		</td>
		<td width="33%" class="cfDefault" valign="top">
			<b>Shipping Method(s): <a href="CO-Options.cfm?errorOptions=0" class="cfMini">(Edit)</a></b><br/>
			<!--- CARTFUSION 4.5 - MULTIPLE SHIPPING ADDRESSES --->	
			<cfloop from="1" to="#Cart.Packages#" index="cpi">
				<cfinvoke component="#Queries#" method="getShippingMethod" returnvariable="getShippingMethod">
					<cfinvokeargument name="ShippingCode" value="#Evaluate('Form.ShippingMethod' & cpi)#">
				</cfinvoke>
				<cfif isDefined('getShippingMethod')>
					#cpi# - #getShippingMethod.ShippingMessage#<br/>
				</cfif>
			</cfloop>
			<br/>
			<!--- CALCULATE AND SHOW DISCOUNT, IF ENTERED --->
			<b>Discount or Gift Certificate Codes:</b><br/>
			<cfset DisplayType = 4 >
			<cfinclude template="CalculateDiscounts.cfm">
		</td>
	</tr>
</table>
</cfoutput>
