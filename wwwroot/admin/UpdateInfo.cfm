<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<cfif isDefined('URL.FTable') 
		AND isDefined('URL.FColumn') 
		AND URL.FID NEQ ''  
		AND URL.FColumn NEQ ''>		
	
	<cfscript>

		switch ( URL.FTable )
		{
			case 'Categories' :
				// UPDATE PRICES OF ALL PRODUCTS IN CATEGORY 
				if ( URL.FColumn CONTAINS 'Price' )
				{
					URL.FTable = 'Products';
					ThisColumn1 = 'Category';
					break ;
				}
				// OTHERWISE, UPDATE CATEGORY INFORMATION ONLY
				else
				{	
					ThisColumn1 = 'CatID';	
					break ;
				}
			case 'Sections' :
				// UPDATE PRICES OF ALL PRODUCTS IN SECTION 
				if ( URL.FColumn CONTAINS 'Price' )
				{
					URL.FTable = 'Products';
					ThisColumn1 = 'SectionID';
				}
				// OTHERWISE, UPDATE SECTION INFORMATION ONLY
				else
				{  
					ThisColumn1 = 'SectionID';
					break ;
				}
			case 'OrderItems' : ThisColumn1 = 'OrderItemsID'; break ;
			case 'Orders' : ThisColumn1 = 'OrderID'; break ;
			case 'Products' : ThisColumn1 = 'ItemID'; break ;
			case 'Users' : ThisColumn1 = 'UID'; break ;
			case 'Customers' : ThisColumn1 = 'CustomerID'; break ;
			case 'Messages' : ThisColumn1 = 'MessageID'; break ;
			case 'AdminUsers' : ThisColumn1 = 'UserID'; break ;
			case 'AuthorizeNet' : ThisColumn1 = 'ID'; break ;
			case 'AuthorizeNetTK' : ThisColumn1 = 'ID'; break ;
			case 'Affiliates' : ThisColumn1 = 'AFID'; break ;
			case 'AffiliatePayments' : ThisColumn1 = 'AFPID'; break ;
			case 'States' : ThisColumn1 = 'SID'; break ;
			case 'ShippingMethods' : ThisColumn1 = 'SMID'; break ;
			case 'Discounts' : ThisColumn1 = 'DiscountID'; break ;
		}
			
	</cfscript>
	
	<cfif URL.FTable EQ 'AuthorizeNet' OR URL.FTable EQ 'AuthorizeNetTK'>
		<cfset URL.FValue = ENCRYPT(URL.FValue, application.CryptKey, "CFMX_COMPAT", "Hex") >
	</cfif>
	
	<cfif isDefined('ThisColumn1')>
		
		<!--- SET HIDE/SHOW VALUES --->
		<cfif URL.FValue IS 'on'>
			<cfquery name="checkHideOnOff" datasource="#application.dsn#">
				SELECT	#URL.FColumn# AS HideValue
				FROM	#URL.FTable#
				WHERE	#ThisColumn1# = #URL.FID#
			</cfquery>
			<cfif checkHideOnOff.HideValue EQ 1><cfset URL.FValue = 0> <!--- IF HIDDEN, CHANGE TO SHOW --->
			<cfelse><cfset URL.FValue = 1> <!--- IF SHOWING, CHANGE TO HIDDEN --->
			</cfif>
		</cfif>
		
		<!--- UPDATE --->
		<cfquery name="updateDatabase" datasource="#application.dsn#">
			UPDATE 	#URL.FTable#		
			<!--- NOT A STRING --->
			<cfif  URL.FColumn CONTAINS 'Price' 
				OR URL.FColumn IS 'Qty'
				OR URL.FColumn CONTAINS 'Total'
				OR URL.FColumn CONTAINS 'Hide'
				OR URL.FColumn CONTAINS 'Amount' 
				OR URL.FColumn IS 'CreditApplied'
				OR URL.FColumn IS 'UMinimum'
				OR URL.FColumn IS 'UMinimumFirst'
				OR URL.FColumn CONTAINS '_Rate'>
				SET		#URL.FColumn# = #Replace(URL.FValue, "," , "", "ALL")#
			
			<!--- STRING --->
			<cfelse>
				SET		#URL.FColumn# = '#URL.FValue#'
				
				<!--- UPDATE ActionDate for --->
				<cfif URL.FColumn EQ 'StatusCode' AND (URL.FValue EQ 'BO' OR URL.FValue EQ 'CA')>
						, DateEntered = '#DateFormat(NOW(), 'mm/dd/yyyy')#'
				</cfif>
			</cfif>
			WHERE	#ThisColumn1# = '#URL.FID#'
		</cfquery>
	
	
	<!--- UPDATE DISTRIBUTOR SHIPPED ORDER ITEMS --->
	<cfelseif URL.FTable EQ 'DistShipped' >
		<cftransaction>
			<cfquery name="updateDatabase" datasource="#application.dsn#">
				UPDATE 	OrderItems		
				<cfif URL.FValue IS 'SH'>
				SET		StatusCode = 'SH', DateEntered = '#DateFormat(NOW(), 'mm/dd/yyyy')#'
				<cfelse>
				SET		StatusCode = 'PR', DateEntered = '#DateFormat(NOW(), 'mm/dd/yyyy')#'
				</cfif>
				WHERE	OrderID = #URL.FID#
				AND		ItemID IN
						( SELECT  ItemID
						  FROM	  Products
						  WHERE	  DistributorID = #URL.FColumn# )
			</cfquery>
			
			<!--- IF ALL ITEMS IN ORDER HAVE BEEN SHIPPED, SET ORDER STATUS TO 'SHIPPED' --->
			<cfquery name="checkIfAllShipped" datasource="#application.dsn#">
				SELECT	OrderItemsID
				FROM	OrderItems
				WHERE	OrderID = #URL.FID#
				AND		StatusCode = 'PR'
			</cfquery>		
			<cfif checkIfAllShipped.RecordCount EQ 0 >
				<cfquery name="setOrderShipped" datasource="#application.dsn#">
					UPDATE 	Orders		
					SET		OrderStatus = 'SH', DateUpdated = '#DateFormat(NOW(), 'mm/dd/yyyy')#', UpdatedBy = '#GetAuthUser()#'
					WHERE	OrderID = #URL.FID#
				</cfquery>
			</cfif>
			<!--- IF ALL ITEMS IN ORDER ARE BEING PROCESSED, SET ORDER STATUS TO 'PROCESSING' --->
			<cfquery name="checkIfAllProcessing" datasource="#application.dsn#">
				SELECT	OrderItemsID
				FROM	OrderItems
				WHERE	OrderID = #URL.FID#
				AND		StatusCode != 'PR'
			</cfquery>		
			<cfif checkIfAllProcessing.RecordCount EQ 0 >
				<cfquery name="setOrderProcessing" datasource="#application.dsn#">
					UPDATE 	Orders		
					SET		OrderStatus = 'PR', DateUpdated = '#DateFormat(NOW(), 'mm/dd/yyyy')#', UpdatedBy = '#GetAuthUser()#'
					WHERE	OrderID = #URL.FID#
				</cfquery>
			</cfif>
		</cftransaction>
		
	</cfif>
	
</cfif>