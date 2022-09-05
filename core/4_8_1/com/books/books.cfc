<!--- 
|| LEGAL ||
$CartFusion - Copyright � 2001-2007 Trade Studios, LLC.$
$This copyright notice MUST stay intact for use (see license.txt).$
$It is against the law to copy, distribute, gift, bundle or give away this code$
$without written consent from Trade Studios, LLC.$

|| VERSION CONTROL ||
$Id: $
$Date: $
$Revision: $

|| DESCRIPTION || 
$Description: $
$TODO: $

|| DEVELOPER ||
$Developer: Trade Studios, LLC (webmaster@tradestudios.com)$

|| SUPPORT ||
$Support Email: support@tradestudios.com$
$Support Website: http://support.tradestudios.com$

|| ATTRIBUTES ||
$in: $
$out:$
--->

<!--- 
	init
	AddSchool
	EditSchool
	DeleteSchool
	GetSchool
	ViewAllSchools
	GetSchoolCount
	
	GetClass
	GetClasses
 --->

<cfcomponent displayname="Books Module">
	
	<cfscript>
		variables.dsn = "";
	</cfscript>

	<cffunction name="init" returntype="Books" output="false">
		<cfargument name="dsn" required="true">
	
		<cfscript>
			variables.dsn = arguments.dsn;
		</cfscript>
		
		<cfreturn this />
	</cffunction>
	
	
	
	<cffunction name="GetBooks" output="false">
		<cfargument name="Classes_ID" required="yes">
		
		<cfscript>
			var data = ""; 
			var stReturn = StructNew();
			stReturn.bSuccess = True;
			stReturn.message = "";
			stReturn.data = "";
			stReturn.stError = structNew();
		</cfscript>
		
		<cftry>
		
			<cfquery name="data" datasource="#variables.dsn#">
				SELECT 		* 
				FROM 		barket_Books b, barket_ClassBooks cb
				WHERE		cb.ClassBooks_Class = #arguments.Classes_ID#
				AND			cb.ClassBooks_Book = b.Books_ID
				ORDER BY 	b.Books_Title, b.Books_Edition
			</cfquery>
			
			<cfscript>
				if ( NOT data.RecordCount )
				{
					stReturn.bSuccess = False ;
					stReturn.Message = "I am sorry but no books were found" ;
				}
				else
				{
					stReturn.bSuccess = True ;
					stReturn.data = data ;
				}
			</cfscript>
			
			<cfcatch>
				<cfscript>
					stReturn.bSuccess = False ;
					stReturn.message = cfcatch.message & "<br><br>" & cfcatch.detail ;
					stReturn.stError = cfcatch ;
				</cfscript>
			</cfcatch>
			
		</cftry>

		<cfreturn stReturn>
	</cffunction>
	
	
	
	<cffunction name="GetAllBooks" output="false">
		
		<cfscript>
			var data = ""; 
			var stReturn = StructNew();
			stReturn.bSuccess = True;
			stReturn.message = "";
			stReturn.data = "";
			stReturn.stError = structNew();
		</cfscript>
		
		<cftry>
		
			<cfquery name="data" datasource="#variables.dsn#">
				SELECT 		*
				FROM 		barket_Books
				ORDER BY 	Books_Title
			</cfquery>
			
			<cfscript>
				if ( NOT data.RecordCount )
				{
					stReturn.bSuccess = False ;
					stReturn.Message = "I am sorry but no books were found" ;
				}
				else
				{
					stReturn.bSuccess = True ;
					stReturn.data = data ;
				}
			</cfscript>
			
			<cfcatch>
				<cfscript>
					stReturn.bSuccess = False ;
					stReturn.message = cfcatch.message & "<br><br>" & cfcatch.detail ;
					stReturn.stError = cfcatch ;
				</cfscript>
			</cfcatch>
			
		</cftry>
		
		<cfreturn stReturn>
	</cffunction>
	
	
	
	<cffunction name="SearchForBooks" output="false">
		<cfargument name="SearchBookID" required="no">
		<cfargument name="SearchBookTitle" required="no">
		<cfargument name="SearchBookAuthorLast" required="no">
		<cfargument name="SearchBookAuthorFirst" required="no">
		<cfargument name="SearchBookISBN" required="no">
		<cfargument name="SearchBookKeywords" required="no">
		<cfargument name="Listings_ID" required="no">
		
		<cfscript>
			var data = ""; 
			var stReturn = StructNew();
			stReturn.bSuccess = True;
			stReturn.message = "";
			stReturn.data = "";
			stReturn.stError = structNew();
		</cfscript>
		
		<cftry>
		
			<cfquery name="data" datasource="#variables.dsn#">
				SELECT 		*,
						   (SELECT Customers_Rating
							FROM barket_Customers
							WHERE Customers_CustomerID = l.Listings_CustomerID ) AS SellerRating,
						   (SELECT Customers_Comments
							FROM barket_Customers
							WHERE Customers_CustomerID = l.Listings_CustomerID ) AS Customers_Comments
				FROM 		barket_Books b, barket_Listings l
				WHERE		b.Books_ID = l.Listings_BookID
				AND			l.Listings_Status = 1
				AND			l.Listings_SaleTo = 2
				<cfif isDefined('arguments.SearchBookID') AND arguments.SearchBookID NEQ '' >
				AND			b.Books_ID = #arguments.SearchBookID#
				<cfelseif isDefined('arguments.Listings_ID') AND arguments.Listings_ID NEQ '' >
				AND			l.Listings_ID = #arguments.Listings_ID#
				</cfif>
				<cfif isDefined('arguments.SearchBookTitle') AND arguments.SearchBookTitle NEQ '' >
				<!--- needs work --->
				AND			b.Books_Title LIKE '%#arguments.SearchBookTitle#%'
				</cfif>
				<cfif isDefined('arguments.SearchBookAuthorLast') AND arguments.SearchBookAuthorLast NEQ '' >
				AND		   (b.Books_AuthorLastName  LIKE '%#arguments.SearchBookAuthorLast#%'
				OR			b.Books_AuthorLastName2 LIKE '%#arguments.SearchBookAuthorLast#%'
				OR			b.Books_AuthorLastName3 LIKE '%#arguments.SearchBookAuthorLast#%'
				OR			b.Books_AuthorLastName4 LIKE '%#arguments.SearchBookAuthorLast#%')
				</cfif>
				<cfif isDefined('arguments.SearchBookAuthorFirst') AND arguments.SearchBookAuthorFirst NEQ '' >
				AND		   (b.Books_AuthorFirstName  LIKE '%#arguments.SearchBookAuthorFirst#%'
				OR			b.Books_AuthorFirstName2 LIKE '%#arguments.SearchBookAuthorFirst#%'
				OR			b.Books_AuthorFirstName3 LIKE '%#arguments.SearchBookAuthorFirst#%'
				OR			b.Books_AuthorFirstName4 LIKE '%#arguments.SearchBookAuthorFirst#%')
				</cfif>
				<cfif isDefined('arguments.SearchBookISBN') AND arguments.SearchBookISBN NEQ '' >
				AND			b.Books_ISBN = '#arguments.SearchBookISBN#'
				</cfif>
				<cfif isDefined('arguments.SearchBookKeyword') AND arguments.SearchBookKeyword NEQ '' >
				<!--- needs work --->
				AND			b.Books_Keywords LIKE '%#arguments.SearchBookKeywords#%'
				</cfif>
				ORDER BY 	l.Listings_SchoolID DESC, l.Listings_SellingPrice, b.Books_Title, b.Books_Edition
			</cfquery>
			
			<cfscript>
				if ( NOT data.RecordCount )
				{
					stReturn.bSuccess = False ;
					stReturn.Message = "I am sorry but no books were found matching that criteria" ;
				}
				else
				{
					stReturn.bSuccess = True ;
					stReturn.data = data ;
				}
			</cfscript>
			
			<cfcatch>
				<cfscript>
					stReturn.bSuccess = False ;
					stReturn.message = cfcatch.message & "<br><br>" & cfcatch.detail ;
					stReturn.stError = cfcatch ;
				</cfscript>
			</cfcatch>
			
		</cftry>

		<cfreturn stReturn>
	</cffunction>
	
	
	
	<cffunction name="GetAvailableBooks" output="false">
		
		<cfscript>
			var data = ""; 
			var stReturn = StructNew();
			stReturn.bSuccess = True;
			stReturn.message = "";
			stReturn.data = "";
			stReturn.stError = structNew();
		</cfscript>
		
		<cftry>
		
			<cfquery name="data" datasource="#variables.dsn#">
				SELECT 		DISTINCT b.Books_ID, b.Books_Title, b.Books_AuthorLastName, b.Books_AuthorFirstName, b.Books_ISBN
				FROM 		barket_Books b, barket_Listings l
				WHERE		b.Books_ID = l.Listings_BookID
				AND			l.Listings_Status = 1
				AND			l.Listings_SaleTo = 2
				ORDER BY	b.Books_Title, b.Books_AuthorLastName, b.Books_AuthorFirstName, b.Books_ISBN, b.Books_ID
			</cfquery>
			
			<cfscript>
				if ( NOT data.RecordCount )
				{
					stReturn.bSuccess = False ;
					stReturn.Message = "I am sorry but no books were found matching that criteria" ;
				}
				else
				{
					stReturn.bSuccess = True ;
					stReturn.data = data ;
				}
			</cfscript>
			
			<cfcatch>
				<cfscript>
					stReturn.bSuccess = False ;
					stReturn.message = cfcatch.message & "<br><br>" & cfcatch.detail ;
					stReturn.stError = cfcatch ;
				</cfscript>
			</cfcatch>
			
		</cftry>

		<cfreturn stReturn>
	</cffunction>
	
	
	
	<cffunction name="LookupBooks" output="false">
		<cfargument name="SellBookISBN" required="no">
		<cfargument name="SellBookISBNSelect" required="no">
		
		<cfscript>
			var data = StructNew();
			var xmlFile = '' ;
			var Authors = ArrayNew(1) ;
			var Count = '' ;
			var stReturn = StructNew();
			stReturn.bSuccess = True;
			stReturn.message = "";
			stReturn.data = "";
			stReturn.stError = structNew();
			if ( isDefined('arguments.SellBookISBN') AND arguments.SellBookISBN NEQ '' )
			{
				ISBN = arguments.SellBookISBN ;
			}
			else if ( isDefined('arguments.SellBookISBNSelect') AND arguments.SellBookISBNSelect NEQ '' )
			{
				ISBN = arguments.SellBookISBNSelect ;
			}
			else
			{
				ISBN = 0 ;
			}
		</cfscript>
		
		<cftry>
		
			<cfscript>
				// look for book in the Barket DB first
				findThisBook = application.Books.SearchForBooks(SearchBookISBN=ISBN);
			</cfscript>
			
			<cfif findThisBook.bSuccess >
				<cfoutput query="findThisBook.data">
					<cfscript>
						data.Books_ISBN = findThisBook.data.Books_ISBN ;
						data.Books_Title = findThisBook.data.Books_Title ;
						data.Books_AuthorLastName = findThisBook.data.Books_AuthorLastName ;
						data.Books_AuthorFirstName = findThisBook.data.Books_AuthorFirstName ;
						data.Books_AuthorLastName2 = findThisBook.data.Books_AuthorLastName2 ;
						data.Books_AuthorFirstName2 = findThisBook.data.Books_AuthorFirstName2 ;
						data.Books_AuthorLastName3 = findThisBook.data.Books_AuthorLastName3 ;
						data.Books_AuthorFirstName3 = findThisBook.data.Books_AuthorFirstName3 ;
						data.Books_AuthorLastName4 = findThisBook.data.Books_AuthorLastName4 ;
						data.Books_AuthorFirstName4 = findThisBook.data.Books_AuthorFirstName4 ;
						data.Books_ListPrice = NumberFormat(findThisBook.data.Books_ListPrice,9.99) ;
						data.Books_Media = findThisBook.data.Books_Media ;
						data.Books_Publisher = findThisBook.data.Books_Publisher ;
						data.Books_PublishDate = findThisBook.data.Books_PublishDate ;
						data.Books_ImageSmall = findThisBook.data.Books_ImageSmall ;
						data.Books_ImageMedium = findThisBook.data.Books_ImageMedium ;
						data.Books_ImageLarge = findThisBook.data.Books_ImageLarge ;
						stReturn.bSuccess = True ;
						stReturn.data = data ;
					</cfscript>
				</cfoutput>
			
			<cfelse>
				
				<cfhttp url="http://xml.amazon.com/onca/xml3?PowerSearch=ISBN:#ISBN#&mode=books&t=#application.associatekey#&dev-t=#application.developerkey#&type=heavy&f=xml" method="get" throwonerror="yes" />
				
				<cfscript>
					// Parse XML File
					xmlFile = xmlParse(cfhttp.FileContent) ;
					// Function Return Info
					if ( NOT isDefined('xmlFile.ProductInfo.Details.ProductName') )
					{
						stReturn.bSuccess = False ;
						stReturn.Message = "I am sorry but no books were found matching that criteria" ;
					}
					else
					{
						data.Books_AuthorFirstName = '' ;
						data.Books_AuthorLastName = '' ;
						data.Books_AuthorFirstName2 = '' ;
						data.Books_AuthorLastName2 = '' ;
						data.Books_AuthorFirstName3 = '' ;
						data.Books_AuthorLastName3 = '' ;
						data.Books_AuthorFirstName4 = '' ;
						data.Books_AuthorLastName4 = '' ;
						// Number of authors in xml file
						Count = ArrayLen(xmlFile.ProductInfo.Details.Authors.XmlChildren) ;
						// Loop through up to 4 authors
						for (i = 1; i LTE 4; i = i + 1)
						{
							if ( i LTE Count )
								Authors[i] = xmlFile.ProductInfo.Details.Authors.XmlChildren[i].xmlText ;
							else
								Authors[i] = '';
						}
						// Separate authors first and last names
						if ( Authors[1] NEQ '' )
						{
							data.Books_AuthorFirstName = Left(Authors[1],(IIF(Find(' ',Authors[1])-1 EQ -1,1,Find(' ',Authors[1])-1))) ;
							data.Books_AuthorLastName = Mid(Authors[1],Find(' ',Authors[1])+1,Len(Authors[1])) ;
						}
						if ( Authors[2] NEQ '' )
						{
							data.Books_AuthorFirstName2 = Left(Authors[2],(IIF(Find(' ',Authors[2])-1 EQ -1,1,Find(' ',Authors[2])-1))) ;
							data.Books_AuthorLastName2 = Mid(Authors[2],Find(' ',Authors[2])+1,Len(Authors[2])) ;
						}
						if ( Authors[3] NEQ '' )
						{	
							data.Books_AuthorFirstName3 = Left(Authors[3],(IIF(Find(' ',Authors[3])-1 EQ -1,1,Find(' ',Authors[3])-1))) ;
							data.Books_AuthorLastName3 = Mid(Authors[3],Find(' ',Authors[3])+1,Len(Authors[3])) ;
						}
						if ( Authors[4] NEQ '' )
						{	
							data.Books_AuthorFirstName4 = Left(Authors[4],(IIF(Find(' ',Authors[4])-1 EQ -1,1,Find(' ',Authors[4])-1))) ;
							data.Books_AuthorLastName4 = Mid(Authors[4],Find(' ',Authors[4])+1,Len(Authors[4])) ;
						}
						data.Books_ISBN = xmlFile.ProductInfo.Details.Asin.xmlText ;
						data.Books_Title = xmlFile.ProductInfo.Details.ProductName.xmlText ;
						if ( isDefined('xmlFile.ProductInfo.Details.ListPrice.xmlText') )
							data.Books_ListPrice = NumberFormat(Replace(xmlFile.ProductInfo.Details.ListPrice.xmlText,'$','','ALL'),9.99) ;
						else
							data.Books_ListPrice = 0.00 ;
						data.Books_Media = xmlFile.ProductInfo.Details.Media.xmlText ;
						data.Books_Publisher = xmlFile.ProductInfo.Details.Manufacturer.xmlText ;
						data.Books_PublishDate = xmlFile.ProductInfo.Details.ReleaseDate.xmlText ;
						data.Books_ImageSmall = xmlFile.ProductInfo.Details.ImageUrlSmall.xmlText ;
						data.Books_ImageMedium = xmlFile.ProductInfo.Details.ImageUrlMedium.xmlText ;
						data.Books_ImageLarge = xmlFile.ProductInfo.Details.ImageUrlLarge.xmlText ;
						stReturn.bSuccess = True ;
						stReturn.data = data ;
					}
				</cfscript>
			</cfif>
			
			<cfcatch>
				<cfscript>
					stReturn.bSuccess = False ;
					stReturn.message = cfcatch.message & "<br><br>" & cfcatch.detail ;
					stReturn.stError = cfcatch ;
				</cfscript>
			</cfcatch>
			
		</cftry>

		<cfreturn stReturn>
	</cffunction>
	
	
	
	<cffunction name="SellBook" output="false">
		<cfargument name="Books_ISBN" required="yes">
		<cfargument name="Books_Title" required="yes">
		<cfargument name="Books_AuthorLastName" required="yes">
		<cfargument name="Books_AuthorFirstName" required="yes">
		<cfargument name="Books_AuthorLastName2" required="yes">
		<cfargument name="Books_AuthorFirstName2" required="yes">
		<cfargument name="Books_AuthorLastName3" required="yes">
		<cfargument name="Books_AuthorFirstName3" required="yes">
		<cfargument name="Books_AuthorLastName4" required="yes">
		<cfargument name="Books_AuthorFirstName4" required="yes">
		<cfargument name="Books_ListPrice" required="yes">
		<cfargument name="Books_Media" required="yes">
		<cfargument name="Books_Publisher" required="yes">
		<cfargument name="Books_PublishDate" required="yes">
		<cfargument name="Books_ImageSmall" required="yes">
		<cfargument name="Books_ImageMedium" required="yes">
		<cfargument name="Books_ImageLarge" required="yes">
		<cfargument name="Listings_SchoolID" required="yes">
		<cfargument name="Listings_CustomerID" required="yes">
		<cfargument name="Listings_SellingPrice" required="yes">
		<cfargument name="Listings_Condition" required="yes">
		<cfargument name="Listings_DispersalMethod" required="yes">
		<cfargument name="Listings_ProposedShipDate" required="yes">
		<cfargument name="Listings_SaleTo" required="yes">
		<cfargument name="Listings_SaleToID" required="no">
		<cfargument name="Listings_BuyBackPrice" required="no">
		<cfargument name="Listings_BuyBackExpires" required="no">
		
		<cfscript>
			// initialize a variable to hold the query
			var insertBook = ""; 
			var insertListing = ""; 
			// initialize a structure to hold the returned information
			var stReturn = StructNew();
			// This structure key is used to indicate if the operation completed successfully
			stReturn.bSuccess = True;
			// This structure key is used to pass messages back to the caller of the
			// function. It should be used for passing developer messages to assist debugging
			stReturn.message = "";
			// This structure key is used to hold any data which the function returns
			stReturn.data = "";
			// This structure key is used to hold any error information generated by the function
			stReturn.stError = structNew();
		</cfscript>
		
		
			<cftransaction>
				<cfscript>
					// look for book in the Barket DB first
					findThisBook = application.Books.SearchForBooks(SearchBookISBN=arguments.Books_ISBN);
				</cfscript>
				
				<cfif NOT findThisBook.bSuccess >
					<cfquery name="insertBook" datasource="#variables.dsn#">
						SET NOCOUNT ON
						INSERT INTO barket_Books
								   (Books_OID,
									Books_ISBN,
									Books_Title,
									Books_AuthorLastName,
									Books_AuthorFirstName,
									Books_AuthorLastName2,
									Books_AuthorFirstName2,
									Books_AuthorLastName3,
									Books_AuthorFirstName3,
									Books_AuthorLastName4,
									Books_AuthorFirstName4,
									Books_ListPrice,
									Books_Media,
									Books_Publisher,
									Books_PublishDate,
									Books_ImageSmall,
									Books_ImageMedium,
									Books_ImageLarge,
									Books_DateEntered )
						VALUES	   ('#CreateUUID()#',
									'#arguments.Books_ISBN#',
									'#arguments.Books_Title#',
									'#arguments.Books_AuthorLastName#',
									'#arguments.Books_AuthorFirstName#',
									'#arguments.Books_AuthorLastName2#',
									'#arguments.Books_AuthorFirstName2#',
									'#arguments.Books_AuthorLastName3#',
									'#arguments.Books_AuthorFirstName3#',
									'#arguments.Books_AuthorLastName4#',
									'#arguments.Books_AuthorFirstName4#',
									'#arguments.Books_ListPrice#',
									'#arguments.Books_Media#',
									'#arguments.Books_Publisher#',
									'#arguments.Books_PublishDate#',
									'#arguments.Books_ImageSmall#',
									'#arguments.Books_ImageMedium#',
									'#arguments.Books_ImageLarge#',
									'#DateFormat(NOW(),"mm/dd/yyyy")#' )
						SELECT @@Identity AS Books_ID
						SET NOCOUNT OFF
					</cfquery>
					<cfset insertThisBookID = insertBook.Books_ID >
				<cfelse>
					<cfset insertThisBookID = findThisBook.data.Books_ID >
				</cfif>
				
				<cfif arguments.Listings_SaleTo EQ 1 AND isDefined('arguments.Listings_SaleToID') AND arguments.Listings_SaleToID NEQ '' >
					<cfquery name="getWholesaleBuyer" datasource="#variables.dsn#">
						SELECT	*
						FROM	barket_Customers
						WHERE	Customers_CustomerID = '#arguments.Listings_SaleToID#'
					</cfquery>
					<cfif getWholesaleBuyer.RecordCount NEQ 0 >
						<cfset insertWholesaleBuyer = true >
					<cfelse>
						<cfset insertWholesaleBuyer = false >
					</cfif>
				<cfelse>
					<cfset insertWholesaleBuyer = false >
				</cfif>
				
				<cfquery name="insertListing" datasource="#variables.dsn#">
					SET NOCOUNT ON
					INSERT INTO barket_Listings
							   (Listings_OID,
								Listings_BookID,
								Listings_SchoolID,
								Listings_CustomerID,
								Listings_Status,
								Listings_SellingPrice,
								Listings_Condition,
								Listings_DispersalMethod,
								Listings_DateEntered,
								Listings_ProposedShipDate,
								Listings_SaleTo 
								<cfif insertWholesaleBuyer >
								, Listings_BuyerCustomerID
								, Listings_BuyerPaymentType1
								, Listings_BuyerPaymentAmount1
								</cfif>
								<!--- BUY BACK GUARANTEE --->
								<cfif isDefined('arguments.Listings_BuyBackPrice') AND isDefined('arguments.Listings_BuyBackExpires')
								  AND arguments.Listings_BuyBackPrice NEQ '' AND arguments.Listings_BuyBackExpires NEQ '' >
								, Listings_BuyBackPrice
								, Listings_BuyBackExpires
								</cfif>
								 )
					VALUES	   ('#CreateUUID()#',
								#insertThisBookID#,
								<cfif arguments.Listings_SchoolID EQ '' >
								0,
								<cfelse>
								#arguments.Listings_SchoolID#,
								</cfif>
								'#arguments.Listings_CustomerID#',
								<cfif arguments.Listings_SaleTo EQ 1 >
								2,
								<cfelse>
								1,
								</cfif>
								#arguments.Listings_SellingPrice#,
								'#arguments.Listings_Condition#',
								#arguments.Listings_DispersalMethod#,
								'#DateFormat(NOW(),"mm/dd/yyyy")#',
								'#arguments.Listings_ProposedShipDate#',
								#arguments.Listings_SaleTo#
								<cfif insertWholesaleBuyer >
								, '#arguments.Listings_SaleToID#'
								, 1
								, #arguments.Listings_SellingPrice#
								</cfif>								
								<!--- BUY BACK GUARANTEE --->
								<cfif isDefined('arguments.Listings_BuyBackPrice') AND isDefined('arguments.Listings_BuyBackExpires')
								  AND arguments.Listings_BuyBackPrice NEQ '' AND arguments.Listings_BuyBackExpires NEQ '' >
								, #arguments.Listings_BuyBackPrice#
								, '#arguments.Listings_BuyBackExpires#'
								</cfif>
								 )
					SELECT @@Identity AS Listings_ID
					SET NOCOUNT OFF
				</cfquery>
			</cftransaction>
						
			<cfscript>
				if ( NOT insertListing.RecordCount )
				{
					stReturn.bSuccess = False ;
					stReturn.Message = "An error has occurred inserting the listing" ;
				}
				else
				{
					// DELETE SESSION VARIABLES RELATED TO THIS POSTING ONCE SUCCESSFUL
					session[application.SessionVar].ConfirmedSaleBookImage = "" ;
					session[application.SessionVar].ConfirmedSaleBookTitle = "" ;
					session[application.SessionVar].ConfirmedSaleBookISBN = "" ;
					session[application.SessionVar].ConfirmedSalePrice = "" ;
					session[application.SessionVar].ConfirmedSaleTo = "" ;
					session[application.SessionVar].ConfirmedSaleToID = "" ;
					session[application.SessionVar].ConfirmedSaleCondition = "" ;
					session[application.SessionVar].ConfirmedSaleDateAvailable = "" ;
					session[application.SessionVar].ConfirmedSaleFundsDispersal = "" ;
					// BUY BACK GUARANTEE
					session[application.SessionVar].ConfirmedSaleBuyBackPrice = "" ;
					session[application.SessionVar].ConfirmedSaleBuyBackExpires = "" ;

					stReturn.bSuccess = True ;
					stReturn.data = insertListing ;
				}
			</cfscript>
				
			

		<cfreturn stReturn>
	</cffunction>
	
	
	
	<cffunction name="BuyBook" output="false">
		<cfargument name="Listings_ID" required="yes">
		<cfargument name="Listings_BuyerCustomerID" required="yes">
		<cfargument name="Listings_BuyerPaymentType1" required="yes">
		<cfargument name="Listings_BuyerPaymentAmount1" required="yes">
		<cfargument name="Listings_BuyerPaymentType2" required="no">
		<cfargument name="Listings_BuyerPaymentAmount2" required="no">
		<cfargument name="Listings_BuyerPaymentType3" required="no">
		<cfargument name="Listings_BuyerPaymentAmount3" required="no">
		<cfargument name="Listings_TransactionID" required="no">
		
		<cfscript>
			var data = ""; 
			var stReturn = StructNew();
			stReturn.bSuccess = True;
			stReturn.message = "";
			stReturn.data = "";
			stReturn.stError = structNew();
		</cfscript>
		
		<cftry>
			<cftransaction>
				<cfscript>
					// make sure listing is still there first
					findThisListing = application.Books.SearchForBooks(Listings_ID=arguments.Listings_ID);
				</cfscript>
				
				<cfif findThisListing.bSuccess AND arguments.Listings_BuyerPaymentType1 >
					<cfquery name="data" datasource="#variables.dsn#">
						UPDATE		barket_Listings
						SET			Listings_BuyerCustomerID = '#arguments.Listings_BuyerCustomerID#',
									Listings_BuyerPaymentType1 = #arguments.Listings_BuyerPaymentType1#,
									Listings_BuyerPaymentAmount1 = #arguments.Listings_BuyerPaymentAmount1#,
									<cfif isDefined('arguments.Listings_BuyerPaymentType2') AND isDefined('arguments.Listings_BuyerPaymentAmount2')
									  AND arguments.Listings_BuyerPaymentType2 NEQ '' AND arguments.Listings_BuyerPaymentAmount2 NEQ '' >
										Listings_BuyerPaymentType2 = #arguments.Listings_BuyerCustomerID#,
										Listings_BuyerPaymentAmount2 = #arguments.Listings_BuyerCustomerID#,
									</cfif>
									<cfif isDefined('arguments.Listings_BuyerPaymentType3') AND isDefined('arguments.Listings_BuyerPaymentAmount3')
									  AND arguments.Listings_BuyerPaymentType3 NEQ '' AND arguments.Listings_BuyerPaymentAmount3 NEQ '' >
										Listings_BuyerPaymentType3 = #arguments.Listings_BuyerPaymentType3#,
										Listings_BuyerPaymentAmount3 = #arguments.Listings_BuyerPaymentAmount3#,
									</cfif>
									<cfif arguments.Listings_BuyerPaymentType1 EQ 5 AND isDefined('arguments.Listings_TransactionID') >
										Listings_TransactionID = '#arguments.Listings_TransactionID#',
									</cfif>
									Listings_Status = 2
						WHERE		Listings_ID = #arguments.Listings_ID#
						AND			Listings_OID = '#findThisListing.data.Listings_OID#'
						
						<!--- deduct from cash account --->
						<cfif arguments.Listings_BuyerPaymentType1 EQ 1 >
						UPDATE		barket_Customers
						SET			Customers_CashAccount = (Customers_CashAccount - #arguments.Listings_BuyerPaymentAmount1#)
						WHERE		Customers_CustomerID = '#arguments.Listings_BuyerCustomerID#'
						
						<!--- deduct from barketbucks account --->
						<cfelseif arguments.Listings_BuyerPaymentType1 EQ 2 >
						UPDATE		barket_Customers
						SET			Customers_BarketBucks = (Customers_BarketBucks - #arguments.Listings_BuyerPaymentAmount1#)
						WHERE		Customers_CustomerID = '#arguments.Listings_BuyerCustomerID#'
						</cfif>
					</cfquery>
					
					<cfscript>
						// DELETE SESSION VARIABLES RELATED TO THIS PURCHASE ONCE SUCCESSFUL
						session[application.SessionVar].ConfirmedBuyListingID = "" ;
						session[application.SessionVar].ConfirmedBuyPaymentType = "" ;
						session[application.SessionVar].ConfirmedBuyListingPrice = "" ;
						// update customer's session variables with new cash account amount
						if ( arguments.Listings_BuyerPaymentType1 EQ 1 )
							session[application.SessionVar].Customers_CashAccount = session[application.SessionVar].Customers_CashAccount - arguments.Listings_BuyerPaymentAmount1 ;
						// update customer's session variables with new barketbucks amount
						else if ( arguments.Listings_BuyerPaymentType1 EQ 2 )
							session[application.SessionVar].Customers_BarketBucks = session[application.SessionVar].Customers_BarketBucks - arguments.Listings_BuyerPaymentAmount1 ;
	
						stReturn.bSuccess = True ;
						stReturn.Message = "Successful" ;
					</cfscript>
					
				<cfelse>
					<cfscript>
						stReturn.bSuccess = False ;
						stReturn.Message = "I am sorry but this listing does not exist anymore.  It may have been purchased already or removed from available listings." ;
					</cfscript>
				</cfif>
				
			</cftransaction>
				
			<cfcatch>
				<cfscript>
					stReturn.bSuccess = False ;
					stReturn.message = cfcatch.message & "<br><br>" & cfcatch.detail ;
					stReturn.stError = cfcatch ;
				</cfscript>
			</cfcatch>
			
		</cftry>

		<cfreturn stReturn>
	</cffunction>
	
	
	<cffunction name="ConvertListing" output="false">
		<cfargument name="Listings_ID" required="yes">
		<cfargument name="Listings_CustomerID" required="yes">

		<cfscript>
			var convertListing = ""; 
			var stReturn = StructNew();
			stReturn.bSuccess = True;
			stReturn.message = "";
			stReturn.data = "";
			stReturn.stError = structNew();
		</cfscript>
		
		<cftry>
			<cfquery name="convertListing" datasource="#variables.dsn#">
				UPDATE		barket_Listings
				SET			Listings_Status = 2,
							Listings_SellingPrice = Listings_BuyBackPrice,
							Listings_SaleTo = 1,
							Listings_DateUpdated = #DateFormat(NOW(),"mm/dd/yyyy")#,
							Listings_UpdatedBy = 'CUSTOMER'
				WHERE		Listings_ID = #arguments.Listings_ID#
				AND			Listings_CustomerID = '#arguments.Listings_CustomerID#'
			</cfquery>
						
			<cfscript>
				stReturn.bSuccess = True ;
				stReturn.Message = '--- Your listing has been sold to The Barket successfully ---' ;
			</cfscript>
				
			<cfcatch>
				<cfscript>
					stReturn.bSuccess = False ;
					stReturn.Message = '--- ERROR: We were unable to sell your listing to The Barket. Please contact our support team. ---' ;
					stReturn.stError = cfcatch ;
				</cfscript>
			</cfcatch>
			
		</cftry>

		<cfreturn stReturn>
	</cffunction>
	
</cfcomponent>