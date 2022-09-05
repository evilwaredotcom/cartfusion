-- SQL Manager 2005 for SQL Server (2.6.0.1)
-- ---------------------------------------
-- Host      : (local)
-- Database  : cartfusion481
-- Version   : Microsoft SQL Server  9.00.3042.00


--
-- Definition for table AdminUsers : 
--

CREATE TABLE [dbo].[AdminUsers] (
  [UserID]int IDENTITY(1, 1) NOT NULL,
  [UserName]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Password]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Roles]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [FirstName]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [LastName]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [CompanyName]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Department]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Address1]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Address2]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [City]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [State]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Zip]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Country]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Phone]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Fax]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Email]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Comments]text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Disabled]bit CONSTRAINT [DF__AdminUser__Disab__7D78A4E7] DEFAULT (0) NULL,
  [DateCreated]smalldatetime CONSTRAINT [DF__AdminUser__DateC__7E6CC920] DEFAULT getdate() NULL,
  [DateUpdated]smalldatetime NULL,
  [UpdatedBy]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

--
-- Definition for table AffiliateCommissions : 
--

CREATE TABLE [dbo].[AffiliateCommissions] (
  [CommID]smallint IDENTITY(1, 1) NOT NULL,
  [LevelName]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [L1]smallmoney CONSTRAINT [DF__AffiliateCom__L1__014935CB] DEFAULT (0) NULL,
  [L2]smallmoney CONSTRAINT [DF__AffiliateCom__L2__023D5A04] DEFAULT (0) NULL,
  [L3]smallmoney CONSTRAINT [DF__AffiliateCom__L3__03317E3D] DEFAULT (0) NULL
)
ON [PRIMARY]
GO

--
-- Definition for table AffiliateHistory : 
--

CREATE TABLE [dbo].[AffiliateHistory] (
  [AHID]int IDENTITY(1, 1) NOT NULL,
  [AFID]int NULL,
  [L1]smallmoney CONSTRAINT [DF__AffiliateHis__L1__060DEAE8] DEFAULT (0) NULL,
  [L2]smallmoney CONSTRAINT [DF__AffiliateHis__L2__07020F21] DEFAULT (0) NULL,
  [L3]smallmoney CONSTRAINT [DF__AffiliateHis__L3__07F6335A] DEFAULT (0) NULL,
  [DateEntered]smalldatetime CONSTRAINT [DF__Affiliate__DateE__08EA5793] DEFAULT getdate() NULL
)
ON [PRIMARY]
GO

--
-- Definition for table AffiliateOrders : 
--

CREATE TABLE [dbo].[AffiliateOrders] (
  [AFOID]int IDENTITY(1, 1) NOT NULL,
  [OrderID]int NULL,
  [AFIDL1]int NULL,
  [AFIDL2]int NULL,
  [AFIDL3]int NULL,
  [AFTotalL1]smallmoney NULL,
  [AFTotalL2]smallmoney NULL,
  [AFTotalL3]smallmoney NULL,
  [AFPaidL1]bit NULL,
  [AFPaidL2]bit NULL,
  [AFPaidL3]bit NULL
)
ON [PRIMARY]
GO

--
-- Definition for table AffiliatePayments : 
--

CREATE TABLE [dbo].[AffiliatePayments] (
  [AFPID]int IDENTITY(1, 1) NOT NULL,
  [AFID]int NULL,
  [AFPDate]smalldatetime CONSTRAINT [DF__Affiliate__AFPDa__0DAF0CB0] DEFAULT getdate() NULL,
  [AFPAmount]smallmoney CONSTRAINT [DF__Affiliate__AFPAm__0EA330E9] DEFAULT (0) NULL,
  [AFPCheck]smallint NULL,
  [AFPComments]ntext COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

--
-- Definition for table Affiliates : 
--

CREATE TABLE [dbo].[Affiliates] (
  [AFID]int IDENTITY(7000, 7) NOT NULL,
  [AffiliateName]nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [CompanyName]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [FirstName]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [LastName]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Address1]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Address2]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [City]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [State]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Zip]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Country]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Email]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [EmailOK]bit CONSTRAINT [DF__Affiliate__Email__117F9D94] DEFAULT (1) NULL,
  [Phone]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [AltPhone]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Fax]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [WebSiteName]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [WebSiteURL]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [WebSiteCategory]nvarchar(35) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OrdersAcceptedBy]nvarchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ReferralRate]smallmoney NULL,
  [CustomerDiscount]smallmoney CONSTRAINT [DF__Affiliate__Custo__1273C1CD] DEFAULT (0) NULL,
  [Disabled]bit CONSTRAINT [DF__Affiliate__Disab__1367E606] DEFAULT (0) NULL,
  [IPAddress]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Password]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Authenticated]bit CONSTRAINT [DF__Affiliate__Authe__145C0A3F] DEFAULT (0) NULL,
  [Comments]ntext COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [TaxID]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [SubAffiliateOf]int NULL,
  [CustomerID]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [MemberType]smallint CONSTRAINT [DF__Affiliate__Membe__15502E78] DEFAULT (1) NULL,
  [PaymentFrequency]smallint CONSTRAINT [DF__Affiliate__Payme__164452B1] DEFAULT (1) NULL,
  [EmailPayPal]bit CONSTRAINT [DF__Affiliate__Email__173876EA] DEFAULT (0) NULL,
  [DateInactive]smalldatetime NULL,
  [AffiliateCode]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Deleted]bit CONSTRAINT [DF__Affiliate__Delet__182C9B23] DEFAULT (0) NULL,
  [DateCreated]smalldatetime CONSTRAINT [DF__Affiliate__DateC__1920BF5C] DEFAULT getdate() NULL,
  [DateUpdated]smalldatetime NULL,
  [UpdatedBy]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [QB]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [QB_LIMIT]nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [QB_TERMS]nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [QB_VTYPE]nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [QB_1099]nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

--
-- Definition for table AuthorizeNet : 
--

CREATE TABLE [dbo].[AuthorizeNet] (
  [ID]smallint IDENTITY(1, 1) NOT NULL,
  [Login]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Hash]nvarchar(250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO

--
-- Definition for table AuthorizeNetTK : 
--

CREATE TABLE [dbo].[AuthorizeNetTK] (
  [ID]smallint IDENTITY(1, 1) NOT NULL,
  [TransKey]nvarchar(250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Password]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO

--
-- Definition for table BackOrderItems : 
--

CREATE TABLE [dbo].[BackOrderItems] (
  [BOIID]int IDENTITY(1, 1) NOT NULL,
  [BOID]int NULL,
  [BOItemID]int NULL,
  [BOQty]int NULL,
  [BOItemPrice]money NULL
)
ON [PRIMARY]
GO

--
-- Definition for table BackOrders : 
--

CREATE TABLE [dbo].[BackOrders] (
  [BOUniqueID]int IDENTITY(1, 1) NOT NULL,
  [BOID]int NULL,
  [BOOrderID]int NULL,
  [BODateEntered]smalldatetime CONSTRAINT [DF__BackOrder__BODat__21B6055D] DEFAULT getdate() NULL,
  [BOTransID]int NULL,
  [BOTotal]money NULL,
  [BOCredit]money CONSTRAINT [DF__BackOrder__BOCre__22AA2996] DEFAULT (0) NULL,
  [BODiscount]money CONSTRAINT [DF__BackOrder__BODis__239E4DCF] DEFAULT (0) NULL
)
ON [PRIMARY]
GO

--
-- Definition for table BillingStatusCodes : 
--

CREATE TABLE [dbo].[BillingStatusCodes] (
  [StatusCode]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [StatusMessage]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
ON [PRIMARY]
GO

--
-- Definition for table Cart : 
--

CREATE TABLE [dbo].[Cart] (
  [CartItemID]int IDENTITY(1, 1) NOT NULL,
  [SiteID]smallint DEFAULT (1) NULL,
  [CustomerID]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [SessionID]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ItemID]int NULL,
  [Qty]int NULL,
  [OptionName1]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName2]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName3]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName4]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName5]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName6]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName7]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName8]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName9]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName10]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName11]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName12]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName13]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName14]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName15]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName16]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName17]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName18]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName19]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName20]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [AffiliateID]nvarchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BackOrdered]bit DEFAULT (0) NULL,
  [ShippingID]int DEFAULT (0) NULL,
  [ShippingMethod]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShippingCodesAvailable]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShippingCodesUsed]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShippingCodeAmount]smallmoney NULL,
  [ShippingAmount]smallmoney NULL,
  [HandlingAmount]smallmoney NULL,
  [DateEntered]smalldatetime DEFAULT getdate() NULL
)
ON [PRIMARY]
GO

--
-- Definition for table Categories : 
--

CREATE TABLE [dbo].[Categories] (
  [CatID]int IDENTITY(1, 1) NOT NULL,
  [SiteID]smallint CONSTRAINT [DF__Categorie__SiteI__2D27B809] DEFAULT (1) NULL,
  [CatName]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [CatSummary]nvarchar(2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [CatDescription]nvarchar(2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [CatImage]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [CatImageDir]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [CatFeaturedID]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [CatFeaturedDir]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [CatBanner]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [CKeywords]nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [CDescription]nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShowColumns]smallint CONSTRAINT [DF__Categorie__ShowC__2E1BDC42] DEFAULT (4) NULL,
  [ShowRows]smallint CONSTRAINT [DF__Categorie__ShowR__2F10007B] DEFAULT (4) NULL,
  [DisplayPrefix]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [SortByLooks]bit NULL,
  [DisplayOrder]int CONSTRAINT [DF__Categorie__Displ__300424B4] DEFAULT (1) NULL,
  [CategoryDisplayFormatID]int NULL,
  [AllowCategoryFiltering]bit NULL,
  [AllowManufacturerFiltering]bit NULL,
  [AllowProductTypeFiltering]bit NULL,
  [Published]bit NULL,
  [Comments]nvarchar(1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [AvailableSections]nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [SubCategoryOf]smallint NULL,
  [Featured]bit CONSTRAINT [DF__Categorie__Featu__30F848ED] DEFAULT (0) NULL,
  [RProSID]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [rdi_date_removed]datetime NULL,
  [Hide1]bit CONSTRAINT [DF__Categorie__Hide1__31EC6D26] DEFAULT (0) NULL,
  [Hide2]bit CONSTRAINT [DF__Categorie__Hide2__32E0915F] DEFAULT (0) NULL,
  [CatMetaTitle]nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [CatMetaDescription]nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [CatMetaKeywords]nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [CatMetaKeyphrases]nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Deleted]bit CONSTRAINT [DF__Categorie__Delet__33D4B598] DEFAULT (0) NULL,
  [DateCreated]smalldatetime CONSTRAINT [DF__Categorie__DateC__34C8D9D1] DEFAULT getdate() NULL,
  [DateUpdated]smalldatetime NULL,
  [UpdatedBy]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO

--
-- Definition for table Countries : 
--

CREATE TABLE [dbo].[Countries] (
  [Country]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [CountryCode]nvarchar(2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [S_Rate]money NULL
)
ON [PRIMARY]
GO

--
-- Definition for table Currencies : 
--

CREATE TABLE [dbo].[Currencies] (
  [Locale]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [CurrencyMessage]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
ON [PRIMARY]
GO

--
-- Definition for table CustomerCC : 
--

CREATE TABLE [dbo].[CustomerCC] (
  [CustomerCCID]int IDENTITY(1, 1) NOT NULL,
  [CustomerID]nvarchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [CardOwner]nvarchar(150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [CardName]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [CardNum]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [ExpDate]nvarchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
ON [PRIMARY]
GO

--
-- Definition for table Customers : 
--

CREATE TABLE [dbo].[Customers] (
  [CustomerID]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [CustomerName]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [FirstName]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [MiddleName]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [LastName]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Address1]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Address2]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [City]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [State]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Zip]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Country]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Phone]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Phone2]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Fax]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Email]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [CompanyName]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [CardName]nvarchar(2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [CardNum]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ExpDate]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [CardCVV]nvarchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipFirstName]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipLastName]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipCompanyName]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipAddress1]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipAddress2]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipCity]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipState]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipZip]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipCountry]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipPhone]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipEmail]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [UserName]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Password]nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [PriceToUse]smallint DEFAULT (0) NULL,
  [EmailOK]bit DEFAULT (1) NULL,
  [Discount]smallint DEFAULT (0) NULL,
  [Credit]money DEFAULT (0) NULL,
  [Comments]ntext COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [IPAddress]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [AffiliateID]int NULL,
  [RProSID]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [PaymentTerms]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [CreditLimit]money NULL,
  [AffiliateCode]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [EmailCompany]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Website]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [EmailCompanyOK]bit NULL,
  [Deleted]bit DEFAULT (0) NULL,
  [DateCreated]smalldatetime DEFAULT getdate() NULL,
  [DateUpdated]smalldatetime NULL,
  [UpdatedBy]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [QB]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [QB_CONT1]nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [QB_CONT2]nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [QB_CTYPE]nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [QB_TAXABLE]nvarchar(1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [QB_SALESTAXCODE]nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [QB_RESALENUM]nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [QB_REP]nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [QB_TAXITEM]nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [QB_JOBDESC]nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [QB_JOBTYPE]nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [QB_JOBSTATUS]nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [QB_JOBSTART]nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [QB_JOBPROJEND]nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [QB_JOBEND]nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

--
-- Definition for table CustomerSH : 
--

CREATE TABLE [dbo].[CustomerSH] (
  [SHID]int IDENTITY(1, 1) NOT NULL,
  [CustomerID]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipNickName]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipFirstName]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipLastName]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipAddress1]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipAddress2]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipCity]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipState]nvarchar(3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipZip]nvarchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipCountry]nvarchar(2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipPhone]nvarchar(25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipCompanyName]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipEmail]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO

--
-- Definition for table Days : 
--

CREATE TABLE [dbo].[Days] (
  [DayCode]int NULL
)
ON [PRIMARY]
GO

--
-- Definition for table Dictionary : 
--

CREATE TABLE [dbo].[Dictionary] (
  [DID]int IDENTITY(1, 1) NOT NULL,
  [Term]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [Definition]text COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [Keywords]nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

--
-- Definition for table Discounts : 
--

CREATE TABLE [dbo].[Discounts] (
  [DiscountID]int IDENTITY(1, 1) NOT NULL,
  [SiteID]smallint DEFAULT (1) NULL,
  [DiscountCode]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [DiscountName]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT 'Discount' NULL,
  [DiscountDesc]nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [DiscountValue]smallmoney DEFAULT (0) NULL,
  [DiscountType]smallint DEFAULT (1) NULL,
  [IsPercentage]bit DEFAULT (0) NULL,
  [AutoApply]bit DEFAULT (0) NULL,
  [AllowMultiple]bit DEFAULT (1) NULL,
  [DateValidFrom]smalldatetime DEFAULT getdate()-(1) NULL,
  [DateValidTo]smalldatetime DEFAULT ((12)/(31))/(2030) NULL,
  [UsageLimitCust]smallint DEFAULT (0) NULL,
  [UsageLimitTotal]smallint DEFAULT (0) NULL,
  [OrderTotalLevel]smallmoney DEFAULT (0) NULL,
  [OverridesCat]bit DEFAULT (0) NULL,
  [OverridesSec]bit DEFAULT (0) NULL,
  [OverridesOrd]bit DEFAULT (0) NULL,
  [OverridesVol]bit DEFAULT (0) NULL,
  [ApplyToUser]smallint DEFAULT (0) NULL,
  [ApplyToType]smallint DEFAULT (0) NULL,
  [ApplyTo]int DEFAULT (0) NULL,
  [QtyLevel]smallint DEFAULT (1) NULL,
  [QtyLevelHi]smallint DEFAULT (1) NULL,
  [AddPurchaseReq]smallint DEFAULT (0) NULL,
  [AddPurchaseVal]int DEFAULT (0) NULL,
  [ExcludeSelection]bit DEFAULT (0) NULL,
  [Expired]bit DEFAULT (0) NULL,
  [DateCreated]smalldatetime DEFAULT getdate() NULL,
  [DateUpdated]smalldatetime NULL,
  [UpdatedBy]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO

--
-- Definition for table DiscountUsage : 
--

CREATE TABLE [dbo].[DiscountUsage] (
  [DUID]int IDENTITY(1, 1) NOT NULL,
  [CustomerID]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [DiscountID]int NOT NULL
)
ON [PRIMARY]
GO

--
-- Definition for table Distributors : 
--

CREATE TABLE [dbo].[Distributors] (
  [DistributorID]smallint IDENTITY(1, 1) NOT NULL,
  [DistributorName]nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [CompanyName]nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [FirstName]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [LastName]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Address1]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Address2]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [City]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [State]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Country]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Zipcode]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [RepName]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Email]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Phone]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [AltPhone]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Fax]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [WebSiteURL]nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [TaxID]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [POFormat]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OrdersAcceptedBy]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Comments]nvarchar(4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [DateCreated]smalldatetime CONSTRAINT [DF__Distribut__DateC__09A971A2] DEFAULT getdate() NULL,
  [DateUpdated]smalldatetime NULL,
  [UpdatedBy]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Deleted]bit CONSTRAINT [DF__Distribut__Delet__0A9D95DB] DEFAULT (0) NULL,
  [QB]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [QB_LIMIT]nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [QB_TERMS]nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [QB_VTYPE]nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [QB_1099]nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO

--
-- Definition for table FormsOfPayment : 
--

CREATE TABLE [dbo].[FormsOfPayment] (
  [FOPID]smallint IDENTITY(1, 1) NOT NULL,
  [FOPCode]smallint NOT NULL,
  [FOPMessage]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [FOPDesc]nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO

--
-- Definition for table ItemClassComponents : 
--

CREATE TABLE [dbo].[ItemClassComponents] (
  [ICCID]int IDENTITY(1, 1) NOT NULL,
  [ItemClassID]int NULL,
  [ItemID]int NULL,
  [Detail1]nvarchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Detail2]nvarchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Detail3]nvarchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [CompPrice]smallmoney CONSTRAINT [DF__ItemClass__CompP__123EB7A3] DEFAULT (0) NULL,
  [CompQuantity]int NULL,
  [CompStatus]nvarchar(2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [CompSellByStock]bit NULL,
  [Image]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [QB]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO

--
-- Definition for table ItemClasses : 
--

CREATE TABLE [dbo].[ItemClasses] (
  [ICID]int IDENTITY(1, 1) NOT NULL,
  [Description]nvarchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Dimensions]smallint CONSTRAINT [DF__ItemClass__Dimen__151B244E] DEFAULT (0) NULL,
  [Title1]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Title2]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Title3]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ClassType]smallint NULL,
  [ItemCode]nvarchar(25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO

--
-- Definition for table ItemStatusCodes : 
--

CREATE TABLE [dbo].[ItemStatusCodes] (
  [StatusCode]nvarchar(3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [StatusMessage]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
ON [PRIMARY]
GO

--
-- Definition for table Manufacturers : 
--

CREATE TABLE [dbo].[Manufacturers] (
  [ManufacturerID]int IDENTITY(1, 1) NOT NULL,
  [ManName]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Address1]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Address2]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [City]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [State]nvarchar(2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ZipCode]nvarchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Country]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Phone]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [FAX]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [URL]nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Email]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Summary]text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Description]text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Notes]nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ManufacturerDisplayFormatID]int NULL,
  [ColWidth]int NULL,
  [DisplayOrder]int NULL,
  [Deleted]bit NULL,
  [DateCreated]smalldatetime NULL,
  [DateUpdated]smalldatetime NULL,
  [UpdatedBy]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

--
-- Definition for table MessageCenter : 
--

CREATE TABLE [dbo].[MessageCenter] (
  [MCID]int IDENTITY(1, 1) NOT NULL,
  [Message]ntext COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Customers]ntext COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [DateCreated]smalldatetime CONSTRAINT [DF__MessageCe__DateC__1EA48E88] DEFAULT getdate() NULL,
  [ValidFrom]smalldatetime CONSTRAINT [DF__MessageCe__Valid__1F98B2C1] DEFAULT getdate() NULL,
  [ValidTo]smalldatetime NULL,
  [CreatedBy]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [UpdatedBy]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

--
-- Definition for table MessageCodes : 
--

CREATE TABLE [dbo].[MessageCodes] (
  [MCID]smallint IDENTITY(1, 1) NOT NULL,
  [MessageCode]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
ON [PRIMARY]
GO

--
-- Definition for table Messages : 
--

CREATE TABLE [dbo].[Messages] (
  [MessageID]int IDENTITY(1, 1) NOT NULL,
  [Message]nvarchar(1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Urgency]smallint NULL,
  [Done]bit DEFAULT (0) NULL,
  [DateCreated]smalldatetime DEFAULT getdate() NULL,
  [CreatedBy]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [DateUpdated]smalldatetime NULL,
  [UpdatedBy]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO

--
-- Definition for table module_Sites : 
--

CREATE TABLE [dbo].[module_Sites] (
  [Sites_ID]int IDENTITY(1, 1) NOT NULL,
  [Sites_Name]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Sites_Data]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO

--
-- Definition for table Months : 
--

CREATE TABLE [dbo].[Months] (
  [MonthCode]int NULL,
  [MonthDisplay]nvarchar(15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO

--
-- Definition for table OrderItems : 
--

CREATE TABLE [dbo].[OrderItems] (
  [OrderItemsID]int IDENTITY(1, 1) NOT NULL,
  [OrderID]int NULL,
  [Qty]int NULL,
  [ItemID]int NULL,
  [ItemPrice]smallmoney NULL,
  [DateEntered]smalldatetime CONSTRAINT [DF__OrderItem__DateE__29221CFB] DEFAULT getdate() NULL,
  [OptionName1]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName2]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName3]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName4]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName5]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName6]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName7]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName8]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName9]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName10]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName11]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName12]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName13]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName14]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName15]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName16]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName17]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName18]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName19]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName20]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Deleted]bit CONSTRAINT [DF__OrderItem__Delet__2A164134] DEFAULT (0) NULL,
  [StatusCode]nvarchar(2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [DateUpdated]smalldatetime NULL,
  [UpdatedBy]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OITrackingNumber]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShippingID]int CONSTRAINT [DF__OrderItem__Shipp__2B0A656D] DEFAULT (0) NULL,
  [orderitems_FirstName]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [orderitems_LastName]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [orderitems_CompanyName]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [orderitems_Address1]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [orderitems_Address2]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [orderitems_City]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [orderitems_State]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [orderitems_Zip]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [orderitems_Country]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [orderitems_Phone]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [orderitems_Email]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [orderitems_ShipMethod]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO

--
-- Definition for table OrderItemsStatusCodes : 
--

CREATE TABLE [dbo].[OrderItemsStatusCodes] (
  [StatusCode]nvarchar(3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [StatusMessage]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
ON [PRIMARY]
GO

--
-- Definition for table OrderReturnItems : 
--

CREATE TABLE [dbo].[OrderReturnItems] (
  [ORIID]int IDENTITY(1, 1) NOT NULL,
  [OrderReturnID]int NULL,
  [OrderReturnItemID]int NULL,
  [QtyReturned]int NULL
)
ON [PRIMARY]
GO

--
-- Definition for table OrderReturns : 
--

CREATE TABLE [dbo].[OrderReturns] (
  [OrderReturnID]int IDENTITY(1, 1) NOT NULL,
  [OrderID]int NULL,
  [RMA]int NULL,
  [RMADate]smalldatetime CONSTRAINT [DF__OrderRetu__RMADa__30C33EC3] DEFAULT getdate() NULL,
  [DateReceived]smalldatetime NULL,
  [ReceivedTo]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [RMAComplete]bit CONSTRAINT [DF__OrderRetu__RMACo__31B762FC] DEFAULT (0) NULL,
  [CreatedBy]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ChargeReturnTo]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [TaxReturned]smallmoney CONSTRAINT [DF__OrderRetu__TaxRe__32AB8735] DEFAULT (0) NULL,
  [ShippingReturned]smallmoney CONSTRAINT [DF__OrderRetu__Shipp__339FAB6E] DEFAULT (0) NULL
)
ON [PRIMARY]
GO

--
-- Definition for table Orders : 
--

CREATE TABLE [dbo].[Orders] (
  [OrderID]int NOT NULL,
  [DateEntered]smalldatetime DEFAULT getdate() NULL,
  [SiteID]smallint DEFAULT (1) NULL,
  [CustomerID]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [IPAddress]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [CCName]nvarchar(2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [CCNum]nvarchar(60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [CCExpDate]nvarchar(21) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [CCCVV]nvarchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [PaymentVerified]bit DEFAULT (0) NULL,
  [ShippingMethod]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [TrackingNumber]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [AffiliateID]int NULL,
  [AffiliatePaid]bit DEFAULT (0) NULL,
  [AffiliateTotal]smallmoney DEFAULT (0) NULL,
  [orders_FirstName]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [orders_LastName]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [orders_CompanyName]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [orders_Address1]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [orders_Address2]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [orders_City]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [orders_State]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [orders_Zip]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [orders_Country]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [orders_Phone]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [orders_Email]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Phone]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipToMultiple]bit DEFAULT (0) NULL,
  [oShipFirstName]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [oShipLastName]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [oShipCompanyName]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [oShipAddress1]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [oShipAddress2]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [oShipCity]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [oShipState]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [oShipZip]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [oShipCountry]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [oShipPhone]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [oShipEmail]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipDate]smalldatetime NULL,
  [BillingStatus]nvarchar(2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OrderStatus]nvarchar(2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [CustomerComments]ntext COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Comments]ntext COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShippingTotal]smallmoney DEFAULT (0) NULL,
  [TaxTotal]smallmoney DEFAULT (0) NULL,
  [DiscountTotal]smallmoney DEFAULT (0) NULL,
  [DiscountUsed]int NULL,
  [CreditApplied]smallmoney DEFAULT (0) NULL,
  [TransactionID]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [FormOfPayment]smallint NULL,
  [Downloaded]datetime NULL,
  [Terms]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Reference]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [DateInvoiced]smalldatetime DEFAULT getdate() NULL,
  [DatePaid]smalldatetime NULL,
  [DateUpdated]smalldatetime NULL,
  [UpdatedBy]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Deleted]bit DEFAULT (0) NULL
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

--
-- Definition for table OrderStatusCodes : 
--

CREATE TABLE [dbo].[OrderStatusCodes] (
  [StatusCode]nvarchar(3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [StatusMessage]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
ON [PRIMARY]
GO

--
-- Definition for table PayFlowLink : 
--

CREATE TABLE [dbo].[PayFlowLink] (
  [ID]smallint IDENTITY(1, 1) NOT NULL,
  [Login]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [Partner]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
ON [PRIMARY]
GO

--
-- Definition for table Payment : 
--

CREATE TABLE [dbo].[Payment] (
  [Type]nvarchar(2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Display]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Allow]bit DEFAULT (1) NULL
)
ON [PRIMARY]
GO

--
-- Definition for table PaymentSystems : 
--

CREATE TABLE [dbo].[PaymentSystems] (
  [PSID]smallint IDENTITY(1, 1) NOT NULL,
  [PaymentSystemCode]nvarchar(2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [PaymentSystemMessage]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [PSLogo]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [DisplayOrder]smallint CONSTRAINT [DF__PaymentSy__Displ__489AC854] DEFAULT (1) NULL
)
ON [PRIMARY]
GO

--
-- Definition for table PGPayPal : 
--

CREATE TABLE [dbo].[PGPayPal] (
  [PPID]smallint IDENTITY(1, 1) NOT NULL,
  [PayPalAccount]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [PayPalLogo]nvarchar(250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [IDToken]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO

--
-- Definition for table PGYourPayAPI : 
--

CREATE TABLE [dbo].[PGYourPayAPI] (
  [ID]smallint IDENTITY(1, 1) NOT NULL,
  [StoreNumber]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [PEMFileLocation]nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [LiveMode]bit CONSTRAINT [DF__PGYourPay__LiveM__4D5F7D71] DEFAULT (0) NOT NULL,
  [InUse]bit CONSTRAINT [DF__PGYourPay__InUse__4E53A1AA] DEFAULT (0) NOT NULL
)
ON [PRIMARY]
GO

--
-- Definition for table ProductOptions : 
--

CREATE TABLE [dbo].[ProductOptions] (
  [ItemAltID]int IDENTITY(1, 1) NOT NULL,
  [ItemID]int NULL,
  [OptionName]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionColumn]smallint NULL,
  [OptionPrice]smallmoney CONSTRAINT [DF__ProductOp__Optio__51300E55] DEFAULT (0) NULL,
  [StockQuantity]int NULL,
  [ItemStatus]nvarchar(2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionSellByStock]bit CONSTRAINT [DF__ProductOp__Optio__5224328E] DEFAULT (0) NULL,
  [Hide]bit NULL,
  [Comments]nvarchar(1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [DateCreated]smalldatetime NULL,
  [DateUpdated]smalldatetime NULL,
  [UpdatedBy]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ImageProduct]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ImageColor]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [RProItem]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [RProSID]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [rdi_date_removed]datetime NULL,
  [Item_fldShipAmount]smallmoney CONSTRAINT [DF__ProductOp__Item___531856C7] DEFAULT (0) NULL,
  [Item_fldShipWeight]smallmoney CONSTRAINT [DF__ProductOp__Item___540C7B00] DEFAULT (0) NULL,
  [Item_fldHandAmount]smallmoney CONSTRAINT [DF__ProductOp__Item___55009F39] DEFAULT (0) NULL,
  [Item_fldOversize]bit CONSTRAINT [DF__ProductOp__Item___55F4C372] DEFAULT (0) NULL,
  [Item_fldShipByWeight]bit CONSTRAINT [DF__ProductOp__Item___56E8E7AB] DEFAULT (1) NULL
)
ON [PRIMARY]
GO

--
-- Definition for table ProductReviews : 
--

CREATE TABLE [dbo].[ProductReviews] (
  [PRID]int IDENTITY(1, 1) NOT NULL,
  [ItemID]int NULL,
  [Review]text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Rating]smallint CONSTRAINT [DF__ProductRe__Ratin__59C55456] DEFAULT (0) NULL,
  [DateCreated]smalldatetime CONSTRAINT [DF__ProductRe__DateC__5AB9788F] DEFAULT getdate() NULL
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

--
-- Definition for table Products : 
--

CREATE TABLE [dbo].[Products] (
  [ItemID]int IDENTITY(1, 1) NOT NULL,
  [SiteID]smallint DEFAULT (1) NULL,
  [SKU]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ManufacturerID]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ItemName]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ItemDescription]ntext COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ItemDetails]ntext COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShortDescription]nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Comments]nvarchar(1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Category]int DEFAULT (0) NULL,
  [OtherCategories]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [SectionID]int DEFAULT (0) NULL,
  [OtherSections]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [CompareType]smallint DEFAULT (0) NULL,
  [ImageDir]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Image]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT N'products' NULL,
  [ImageSmall]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ImageLarge]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ImageAlt]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ImageAltLarge]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Attribute1]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Attribute2]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Attribute3]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName1]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName2]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName3]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName4]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName5]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName6]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName7]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName8]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName9]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName10]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName11]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName12]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName13]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName14]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName15]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName16]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName17]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName18]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName19]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName20]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Option1Optional]bit DEFAULT (0) NULL,
  [Option2Optional]bit DEFAULT (0) NULL,
  [Option3Optional]bit DEFAULT (0) NULL,
  [Option4Optional]bit DEFAULT (0) NULL,
  [Option5Optional]bit DEFAULT (0) NULL,
  [Option6Optional]bit DEFAULT (0) NULL,
  [Option7Optional]bit DEFAULT (0) NULL,
  [Option8Optional]bit DEFAULT (0) NULL,
  [Option9Optional]bit DEFAULT (0) NULL,
  [Option10Optional]bit DEFAULT (0) NULL,
  [Option11Optional]bit CONSTRAINT [DF_Products_Option11Optional] DEFAULT (0) NULL,
  [Option12Optional]bit CONSTRAINT [DF_Products_Option12Optional] DEFAULT (0) NULL,
  [Option13Optional]bit CONSTRAINT [DF_Products_Option13Optional] DEFAULT (0) NULL,
  [Option14Optional]bit CONSTRAINT [DF_Products_Option14Optional] DEFAULT (0) NULL,
  [Option15Optional]bit CONSTRAINT [DF_Products_Option15Optional] DEFAULT (0) NULL,
  [Option16Optional]bit CONSTRAINT [DF_Products_Option16Optional] DEFAULT (0) NULL,
  [Option17Optional]bit CONSTRAINT [DF_Products_Option17Optional] DEFAULT (0) NULL,
  [Option18Optional]bit CONSTRAINT [DF_Products_Option18Optional] DEFAULT (0) NULL,
  [Option19Optional]bit CONSTRAINT [DF_Products_Option19Optional] DEFAULT (0) NULL,
  [Option20Optional]bit CONSTRAINT [DF_Products_Option20Optional] DEFAULT (0) NULL,
  [Weight]float DEFAULT (1) NULL,
  [DimLength]float DEFAULT (1) NULL,
  [DimWidth]float DEFAULT (1) NULL,
  [DimHeighth]float DEFAULT (1) NULL,
  [CostPrice]money DEFAULT (0) NULL,
  [ListPrice]money DEFAULT (0) NULL,
  [SalePrice]money DEFAULT (0) NULL,
  [Price1]money DEFAULT (0) NULL,
  [Price2]money DEFAULT (0) NULL,
  [Hide1]bit DEFAULT (0) NULL,
  [Hide2]bit DEFAULT (0) NULL,
  [Taxable]bit DEFAULT (1) NULL,
  [StockQuantity]int NULL,
  [SellByStock]bit DEFAULT (0) NULL,
  [ItemStatus]nvarchar(2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [DisplayOrder]int DEFAULT (1) NULL,
  [Featured]bit DEFAULT (0) NULL,
  [SoftwareDownload]bit NULL,
  [SoftwareAttachment]bit NULL,
  [DaysAvailable]smallint NULL,
  [DownloadLocation]nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [DistributorID]nvarchar(8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ItemClassID]int NULL,
  [UseMatrix]bit DEFAULT (0) NULL,
  [RProSID]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [rdi_date_removed]datetime NULL,
  [fldShipByWeight]bit DEFAULT (1) NULL,
  [fldShipWeight]float DEFAULT (0) NULL,
  [fldShipAmount]smallmoney DEFAULT (0) NULL,
  [fldHandAmount]smallmoney DEFAULT (0) NULL,
  [fldOversize]bit DEFAULT (0) NULL,
  [fldShipCode]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Deleted]bit DEFAULT (0) NULL,
  [DateCreated]smalldatetime DEFAULT getdate() NULL,
  [DateUpdated]smalldatetime DEFAULT getdate() NULL,
  [UpdatedBy]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Volume]money DEFAULT (0) NULL,
  [QB]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [QB_ACCNT]nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [QB_ASSETACCNT]nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [QB_COGSACCNT]nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [QB_SALESTAXCODE]nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [QB_PREFVEND]nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [QB_SUBITEM]nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [QB_REORDERPOINT]int NULL,
  [QB_PAYMETH]nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [QB_TAXVEND]nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

--
-- Definition for table ProductSpecs : 
--

CREATE TABLE [dbo].[ProductSpecs] (
  [SpecID]int IDENTITY(1, 1) NOT NULL,
  [ItemID]int NULL,
  [ProductType]int NULL,
  [Spec1]nvarchar(250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Spec2]nvarchar(250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Spec3]nvarchar(250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Spec4]nvarchar(250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Spec5]nvarchar(250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Spec6]nvarchar(250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Spec7]nvarchar(250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Spec8]nvarchar(250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Spec9]nvarchar(250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Spec10]nvarchar(250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Spec11]nvarchar(250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Spec12]nvarchar(250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Spec13]nvarchar(250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Spec14]nvarchar(250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Spec15]nvarchar(250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Spec16]nvarchar(250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Spec17]nvarchar(250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Spec18]nvarchar(250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Spec19]nvarchar(250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Spec20]nvarchar(250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO

--
-- Definition for table ProductTypes : 
--

CREATE TABLE [dbo].[ProductTypes] (
  [TypeID]int IDENTITY(1, 1) NOT NULL,
  [TypeName]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [SpecCount]smallint CONSTRAINT [DF__ProductTy__SpecC__078C1F06] DEFAULT (0) NULL,
  [SpecTitle1]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [SpecTitle2]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [SpecTitle3]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [SpecTitle4]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [SpecTitle5]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [SpecTitle6]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [SpecTitle7]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [SpecTitle8]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [SpecTitle9]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [SpecTitle10]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [SpecTitle11]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [SpecTitle12]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [SpecTitle13]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [SpecTitle14]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [SpecTitle15]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [SpecTitle16]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [SpecTitle17]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [SpecTitle18]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [SpecTitle19]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [SpecTitle20]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO

--
-- Definition for table RDI_Items : 
--

CREATE TABLE [dbo].[RDI_Items] (
  [StyleSID]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ItemSID]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ItemNum]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ItemAttr]varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ItemSize]varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ItemID]int NULL,
  [ItemAltID_attr]int NULL,
  [ItemAltID_size]int NULL
)
ON [PRIMARY]
GO

--
-- Definition for table RDI_Prefs_Scales : 
--

CREATE TABLE [dbo].[RDI_Prefs_Scales] (
  [Scale_No]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Scale_Name]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ScaleItem_No]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ScaleItem_Value]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ScaleItem_Type]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO

--
-- Definition for table RelatedItems : 
--

CREATE TABLE [dbo].[RelatedItems] (
  [RelatedID]int IDENTITY(1, 1) NOT NULL,
  [ItemID]int NOT NULL,
  [RelatedItemID]int NOT NULL,
  [RelatedType]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [DateCreated]smalldatetime CONSTRAINT [DF__RelatedIt__DateC__0C50D423] DEFAULT getdate() NULL,
  [DateUpdated]smalldatetime NULL,
  [UpdatedBy]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO

--
-- Definition for table Roles : 
--

CREATE TABLE [dbo].[Roles] (
  [RID]int IDENTITY(1, 1) NOT NULL,
  [Role]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
ON [PRIMARY]
GO

--
-- Definition for table RPro_In_Catalog : 
--

CREATE TABLE [dbo].[RPro_In_Catalog] (
  [Parent_SID]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [SID]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Caption]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShortDesc]varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [LongDesc]varchar(4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OrderNo]int NULL,
  [Picture]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Thumbnail]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [TreeLevel]int NULL,
  [Style_SID]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Style_OrderNo]int NULL,
  [Spotlight_SID]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Spotlight_OrderNo]int NULL,
  [Upsell_SID]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Upsell_OrderNo]int NULL
)
ON [PRIMARY]
GO

--
-- Definition for table RPro_In_Catalog_log : 
--

CREATE TABLE [dbo].[RPro_In_Catalog_log] (
  [Parent_SID]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [SID]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Caption]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShortDesc]varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [LongDesc]varchar(4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OrderNo]int NULL,
  [Picture]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Thumbnail]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [TreeLevel]int NULL,
  [Style_SID]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Style_OrderNo]int NULL,
  [Spotlight_SID]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Spotlight_OrderNo]int NULL,
  [Upsell_SID]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Upsell_OrderNo]int NULL,
  [rdi_import_date]datetime NOT NULL
)
ON [PRIMARY]
GO

--
-- Definition for table RPro_In_Customers : 
--

CREATE TABLE [dbo].[RPro_In_Customers] (
  [fldCustSID]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldFName]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldLName]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldAddr1]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldAddr2]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldAddr3]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldZIP]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldPhone1]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldCustID]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [web_cust_sid]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [email]varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldPrcLvl]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldPrcLvl_i]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO

--
-- Definition for table RPro_in_Customers_log : 
--

CREATE TABLE [dbo].[RPro_in_Customers_log] (
  [fldCustSID]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldFName]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldLName]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldAddr1]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldAddr2]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldAddr3]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldZIP]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldPhone1]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldCustID]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [web_cust_sid]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [email]varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldPrcLvl]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldPrcLvl_i]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [rdi_import_date]datetime NOT NULL
)
ON [PRIMARY]
GO

--
-- Definition for table rpro_in_prefs : 
--

CREATE TABLE [dbo].[rpro_in_prefs] (
  [ShippingParams_ShippingTypeIndex]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShippingParams_ShippingCalcIndex]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShippingParams_HandlingAmount]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OnlineCCProcess_ProcessMethod]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO

--
-- Definition for table rpro_in_prefs_DefPriceLevels : 
--

CREATE TABLE [dbo].[rpro_in_prefs_DefPriceLevels] (
  [Level]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Type]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO

--
-- Definition for table rpro_in_prefs_InStockMessages : 
--

CREATE TABLE [dbo].[rpro_in_prefs_InStockMessages] (
  [Msg_No]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Msg_Text]varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO

--
-- Definition for table rpro_in_prefs_InvenPreferences : 
--

CREATE TABLE [dbo].[rpro_in_prefs_InvenPreferences] (
  [DisplayItem_Name]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [DisplayItem_Code]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [DisplayItem_Default]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [AvailableThreshold_Name]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [AvailableThreshold_Code]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [AvailableThreshold_Default]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [AvailableAtStore_Name]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [AvailableAtStore_Code]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [AvailableAtStore_Default]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO

--
-- Definition for table rpro_in_prefs_OrderStatuses : 
--

CREATE TABLE [dbo].[rpro_in_prefs_OrderStatuses] (
  [Item_No]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Action]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Descript]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO

--
-- Definition for table rpro_in_prefs_OutOfStockMessages : 
--

CREATE TABLE [dbo].[rpro_in_prefs_OutOfStockMessages] (
  [Msg_No]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Msg_Text]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO

--
-- Definition for table rpro_in_prefs_ProdAvailability : 
--

CREATE TABLE [dbo].[rpro_in_prefs_ProdAvailability] (
  [Item_No]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_Default]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Value]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO

--
-- Definition for table rpro_in_prefs_QtySource : 
--

CREATE TABLE [dbo].[rpro_in_prefs_QtySource] (
  [Item_No]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_Default]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Value]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO

--
-- Definition for table rpro_in_prefs_Scales : 
--

CREATE TABLE [dbo].[rpro_in_prefs_Scales] (
  [Scale_No]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Scale_Name]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ScaleItem_No]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ScaleItem_Value]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ScaleItem_Type]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO

--
-- Definition for table rpro_in_prefs_ShippingWeightTable : 
--

CREATE TABLE [dbo].[rpro_in_prefs_ShippingWeightTable] (
  [ShippingWeightTableItem_No]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Weight_Min]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Weight_Max]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Shipping_Price]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO

--
-- Definition for table rpro_in_prefs_ShipProviders : 
--

CREATE TABLE [dbo].[rpro_in_prefs_ShipProviders] (
  [ShipProvider_No]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipProvider_Name]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipProvider_Default]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipType_No]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipType_Name]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipType_Amount]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipType_Description]varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipType_Default]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO

--
-- Definition for table rpro_in_prefs_ShipUnits : 
--

CREATE TABLE [dbo].[rpro_in_prefs_ShipUnits] (
  [Unit_No]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Name]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Abbr]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO

--
-- Definition for table rpro_in_prefs_TaxAreas : 
--

CREATE TABLE [dbo].[rpro_in_prefs_TaxAreas] (
  [Code]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Country]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [CountryCode]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Region]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [RegionCode]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [City]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [RproTaxArea]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ZipCodes]varchar(1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO

--
-- Definition for table rpro_in_prefs_TaxCodes : 
--

CREATE TABLE [dbo].[rpro_in_prefs_TaxCodes] (
  [TaxCode_No]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Name]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO

--
-- Definition for table RPro_In_Receipts : 
--

CREATE TABLE [dbo].[RPro_In_Receipts] (
  [so_number]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Receipt_Number]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Receipt_SID]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [StoreStation]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Receipt_Date]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Receipt_Subtotal]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Receipt_ShipAmount]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Receipt_FeeAmount]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Receipt_TaxArea]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Receipt_TotalTax]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Receipt_Total]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [receipt_item_number]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [sid]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [qty]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [extprc]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [extpwt]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO

--
-- Definition for table RPro_In_SO : 
--

CREATE TABLE [dbo].[RPro_In_SO] (
  [SO_Number]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [SID]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Status]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Total]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [CaptureFund]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_Number]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_SID]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [QtyShipped]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipDate]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipNumber]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipDescript]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipProvider]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO

--
-- Definition for table RPro_in_SO_log : 
--

CREATE TABLE [dbo].[RPro_in_SO_log] (
  [SO_Number]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [SID]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Status]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Total]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [CaptureFund]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_Number]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_SID]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [QtyShipped]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipDate]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipNumber]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipDescript]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipProvider]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [rdi_import_date]datetime NOT NULL
)
ON [PRIMARY]
GO

--
-- Definition for table Rpro_In_Styles : 
--

CREATE TABLE [dbo].[Rpro_In_Styles] (
  [fldStyleSID]varchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldDCS]varchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldDCSName]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldDesc1]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldDesc2]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldDesc3]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldDesc4]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldInvnAUX0]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldInvnAUX1]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldInvnAUX2]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldInvnAUX3]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldInvnAUX4]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldInvnAUX5]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldInvnAUX6]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldInvnAUX7]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldStyleName]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldStyleShortDesc]varchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldStyleLongDesc]varchar(6000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldShipByWeight]varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldShipAmount]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldShipWeight]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldHandAmount]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldOversize]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldAvailDate]varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldDisplay]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldAvailThreshold]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldAvailAtStore]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldProdAvail]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldQtySource]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldInStockMsg]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldOutStockMsg]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldShipProvider]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldShipType]varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldShipUnit]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldTaxCd]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldProdAvail_i]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldQtySource_i]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldInStockMsg_i]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldOutStockMsg_i]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldShipProvider_i]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldShipType_i]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldShipUnit_i]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldTaxCd_i]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldStylePicture]varchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldStyleThumbnail]varchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldAvailDateFormat]varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [spotlight]varchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldVendor]varchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldVendorCode]varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldItemScale]varchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldItemScale_i]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_fldItemNum]varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_fldItemSID]varchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_fldUPC]varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_fldALU]varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_fldCaseQty]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_fldQty]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_fldTotOnHnd]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_fldCost]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_fldAttr]varchar(60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_fldUDF0]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_fldUDF1]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_fldUDF2]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_fldUDF3]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_fldDscSch]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_fldSize]varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_fldBackorder]varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_fldDecimals]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_AvailQuantity]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_Availability]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_fldShipByWeight]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_fldShipAmount]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_fldShipWeight]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_fldHandAmount]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_fldOversize]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_Price1]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_Price2]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_Price3]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_Price4]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_Price9]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_Price10]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Record_Type]char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO

--
-- Definition for table RPro_In_Styles_log : 
--

CREATE TABLE [dbo].[RPro_In_Styles_log] (
  [fldStyleSID]varchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldDCS]varchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldDCSName]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldDesc1]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldDesc2]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldDesc3]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldDesc4]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldInvnAUX0]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldInvnAUX1]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldInvnAUX2]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldInvnAUX3]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldInvnAUX4]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldInvnAUX5]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldInvnAUX6]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldInvnAUX7]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldStyleName]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldStyleShortDesc]varchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldStyleLongDesc]varchar(6000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldShipByWeight]varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldShipAmount]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldShipWeight]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldHandAmount]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldOversize]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldAvailDate]varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldDisplay]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldAvailThreshold]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldAvailAtStore]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldProdAvail]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldQtySource]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldInStockMsg]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldOutStockMsg]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldShipProvider]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldShipType]varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldShipUnit]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldTaxCd]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldProdAvail_i]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldQtySource_i]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldInStockMsg_i]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldOutStockMsg_i]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldShipProvider_i]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldShipType_i]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldShipUnit_i]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldTaxCd_i]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldStylePicture]varchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldStyleThumbnail]varchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldAvailDateFormat]varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [spotlight]varchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldVendor]varchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldVendorCode]varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldItemScale]varchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldItemScale_i]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_fldItemNum]varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_fldItemSID]varchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_fldUPC]varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_fldALU]varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_fldCaseQty]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_fldQty]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_fldTotOnHnd]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_fldCost]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_fldAttr]varchar(60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_fldUDF0]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_fldUDF1]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_fldUDF2]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_fldUDF3]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_fldDscSch]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_fldSize]varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_fldBackorder]varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_fldDecimals]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_AvailQuantity]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_Availability]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_fldShipByWeight]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_fldShipAmount]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_fldShipWeight]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_fldHandAmount]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_fldOversize]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_Price1]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_Price2]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_Price3]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_Price4]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_Price9]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Item_Price10]varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Record_Type]char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [rdi_import_date]datetime NOT NULL
)
ON [PRIMARY]
GO

--
-- Definition for table RPro_in_upsell_item : 
--

CREATE TABLE [dbo].[RPro_in_upsell_item] (
  [fldStyleSID]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldUpsellSID]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldOrderNo]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO

--
-- Definition for table rpro_in_upsell_item_ddd : 
--

CREATE TABLE [dbo].[rpro_in_upsell_item_ddd] (
  [fldStyleSID]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldUpsellSID]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [fldOrderNo]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO

--
-- Definition for table RPro_Out_Customers : 
--

CREATE TABLE [dbo].[RPro_Out_Customers] (
  [Customer_ID]bigint NULL,
  [RPro_Cust_SID]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [First_Name]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [Last_Name]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [Address1]nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [Address2]nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [City]nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [State]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Region]nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [Zip]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [Country]nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [Country_Code]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [Phone]nvarchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [Email]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [Login_ID]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Password]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Orders_num]int NULL,
  [has_so]int NULL,
  [Company]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO

--
-- Definition for table RPro_Out_Customers_log : 
--

CREATE TABLE [dbo].[RPro_Out_Customers_log] (
  [Customer_ID]bigint NULL,
  [RPro_Cust_SID]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [First_Name]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [Last_Name]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [Address1]nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [Address2]nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [City]nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [State]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Region]nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [Zip]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [Country]nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [Country_Code]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [Phone]nvarchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [Email]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [Login_ID]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Password]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Orders_num]int NULL,
  [has_so]int NULL,
  [Company]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [rdi_export_date]datetime NOT NULL
)
ON [PRIMARY]
GO

--
-- Definition for table RPro_Out_SO : 
--

CREATE TABLE [dbo].[RPro_Out_SO] (
  [date_inserted]datetime NULL,
  [order_sid]nvarchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_number]nvarchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [date_ordered]datetime NULL,
  [so_billto_cust_sid]nvarchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_billto_rpro_cust_sid]nvarchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_billto_date_created]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_billto_first_name]nvarchar(80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_billto_last_name]nvarchar(80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_billto_address1]nvarchar(80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_billto_address2]nvarchar(80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_billto_city]nvarchar(80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_billto_state_or_province]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_billto_state_short]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_billto_country]nvarchar(80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_billto_country_short]nvarchar(80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_billto_postal_code]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_billto_phone1]nvarchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_billto_phone2]nvarchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_billto_email]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_billto_language]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_billto_price_level]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_shipto_cust_sid]nvarchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_shipto_rpro_cust_sid]nvarchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_shipto_date_created]datetime NULL,
  [so_shipto_title]nvarchar(80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_shipto_first_name]nvarchar(80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_shipto_last_name]nvarchar(80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_shipto_address1]nvarchar(80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_shipto_address2]nvarchar(80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_shipto_city]nvarchar(80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_shipto_state_or_province]nvarchar(80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_shipto_state_short]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_shipto_country]nvarchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_shipto_country_short]nvarchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_shipto_postal_code]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_shipto_phone1]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_shipto_phone2]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_shipto_email]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_shipto_language]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_shipto_price_level]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [shipping_method]nvarchar(80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [shipping_provider]nvarchar(80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [cc_type]nvarchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [cc_name]nvarchar(80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [cc_number]nvarchar(80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [cc_expire]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [cc_expireformat]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_dateformat]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_ref]nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [avs_code]nvarchar(80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [disc_percent]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ship_percent]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [disc_amount]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ship_amount]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [total_tax]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [subtotal_used]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [tax_area]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [instruction]nvarchar(800) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [gift_slip]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [status]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [items_in]int NULL,
  [SO_Origin]char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [uid]int NULL,
  [so_billto_company]varchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_shipto_company]varchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO

--
-- Definition for table RPro_Out_SO_Items : 
--

CREATE TABLE [dbo].[RPro_Out_SO_Items] (
  [Order_Sid]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [item_sid]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [item_no]nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ProductName]nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [tax_code]int NOT NULL,
  [price]nvarchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [orig_price]nvarchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [qty_ordered]int NULL,
  [tax_amount]nvarchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [orig_tax_amount]nvarchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [tax_percent]nvarchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [uid]int NULL
)
ON [PRIMARY]
GO

--
-- Definition for table RPro_Out_SO_Items_log : 
--

CREATE TABLE [dbo].[RPro_Out_SO_Items_log] (
  [Order_Sid]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [item_sid]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [item_no]nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ProductName]nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [tax_code]int NOT NULL,
  [price]nvarchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [orig_price]nvarchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [qty_ordered]int NULL,
  [tax_amount]nvarchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [orig_tax_amount]nvarchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [tax_percent]nvarchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [uid]int NULL,
  [rdi_export_date]datetime NOT NULL
)
ON [PRIMARY]
GO

--
-- Definition for table RPro_Out_SO_log : 
--

CREATE TABLE [dbo].[RPro_Out_SO_log] (
  [date_inserted]datetime NULL,
  [order_sid]nvarchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_number]nvarchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [date_ordered]datetime NULL,
  [so_billto_cust_sid]nvarchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_billto_rpro_cust_sid]nvarchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_billto_date_created]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_billto_first_name]nvarchar(80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_billto_last_name]nvarchar(80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_billto_address1]nvarchar(80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_billto_address2]nvarchar(80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_billto_city]nvarchar(80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_billto_state_or_province]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_billto_state_short]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_billto_country]nvarchar(80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_billto_country_short]nvarchar(80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_billto_postal_code]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_billto_phone1]nvarchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_billto_phone2]nvarchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_billto_email]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_billto_language]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_billto_price_level]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_shipto_cust_sid]nvarchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_shipto_rpro_cust_sid]nvarchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_shipto_date_created]datetime NULL,
  [so_shipto_title]nvarchar(80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_shipto_first_name]nvarchar(80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_shipto_last_name]nvarchar(80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_shipto_address1]nvarchar(80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_shipto_address2]nvarchar(80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_shipto_city]nvarchar(80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_shipto_state_or_province]nvarchar(80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_shipto_state_short]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_shipto_country]nvarchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_shipto_country_short]nvarchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_shipto_postal_code]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_shipto_phone1]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_shipto_phone2]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_shipto_email]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_shipto_language]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_shipto_price_level]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [shipping_method]nvarchar(80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [shipping_provider]nvarchar(80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [cc_type]nvarchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [cc_name]nvarchar(80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [cc_number]nvarchar(80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [cc_expire]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [cc_expireformat]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_dateformat]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [so_ref]nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [avs_code]nvarchar(80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [disc_percent]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ship_percent]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [disc_amount]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ship_amount]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [total_tax]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [subtotal_used]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [tax_area]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [instruction]nvarchar(800) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [gift_slip]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [status]nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [items_in]int NULL,
  [SO_Origin]char(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [uid]int NULL,
  [rdi_export_date]datetime NOT NULL,
  [so_billto_company]varchar(40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO

--
-- Definition for table Sections : 
--

CREATE TABLE [dbo].[Sections] (
  [SectionID]int IDENTITY(1, 1) NOT NULL,
  [SiteID]smallint DEFAULT (1) NULL,
  [SecName]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [SecSummary]nvarchar(2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [SecDescription]nvarchar(2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [SecImage]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [SecImageDir]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [SecFeaturedID]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [SecFeaturedDir]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [SecBanner]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [SEKeywords]nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [SEDescription]nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShowColumns]smallint DEFAULT (4) NULL,
  [ShowRows]smallint DEFAULT (4) NULL,
  [DisplayPrefix]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [SortByLooks]bit NULL,
  [DisplayOrder]int DEFAULT (1) NULL,
  [CategoryDisplayFormatID]int NULL,
  [AllowCategoryFiltering]bit NULL,
  [AllowManufacturerFiltering]bit NULL,
  [AllowProductTypeFiltering]bit NULL,
  [Published]bit NULL,
  [Comments]text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [AvailableCats]nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [SubSectionOf]smallint NULL,
  [Featured]bit DEFAULT (0) NULL,
  [RProVendorCode]varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Hide1]bit DEFAULT (0) NULL,
  [Hide2]bit DEFAULT (0) NULL,
  [SecMetaTitle]nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [SecMetaDescription]nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [SecMetaKeywords]nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [SecMetaKeyphrases]nvarchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [Deleted]bit DEFAULT (0) NULL,
  [DateCreated]datetime DEFAULT getdate() NULL,
  [DateUpdated]datetime NULL,
  [UpdatedBy]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

--
-- Definition for table ShippingCodes : 
--

CREATE TABLE [dbo].[ShippingCodes] (
  [ShippingCode]smallint NOT NULL,
  [ShippingMessage]nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
ON [PRIMARY]
GO

--
-- Definition for table ShippingCompanies : 
--

CREATE TABLE [dbo].[ShippingCompanies] (
  [SCID]smallint NOT NULL,
  [SiteID]smallint CONSTRAINT [DF__ShippingC__SiteI__3B0BC30C] DEFAULT (1) NULL,
  [FedexAccountNum]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [FedexIdentifier]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [FedexTestGateway]nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [FedexProdGateway]nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [UPSAccountNum]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [UPSAccessKey]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [UPSUserID]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [UPSPassword]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [USPSUserID]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [USPSPassword]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO

--
-- Definition for table ShippingMethods : 
--

CREATE TABLE [dbo].[ShippingMethods] (
  [SMID]smallint NOT NULL,
  [SiteID]smallint CONSTRAINT [DF__ShippingM__SiteI__3DE82FB7] DEFAULT (1) NOT NULL,
  [ShippingCode]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [ShippingMessage]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [Allow]bit NULL,
  [ShippingCompany]nvarchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ShipPrice]smallmoney CONSTRAINT [DF__ShippingM__ShipP__3EDC53F0] DEFAULT (0) NULL,
  [ShipWeightLo]float CONSTRAINT [DF__ShippingM__ShipW__3FD07829] DEFAULT (0) NULL,
  [ShipWeightHi]float CONSTRAINT [DF__ShippingM__ShipW__40C49C62] DEFAULT (0) NULL,
  [ShipPriceLo]float CONSTRAINT [DF__ShippingM__ShipP__41B8C09B] DEFAULT (0) NULL,
  [ShipPriceHi]float CONSTRAINT [DF__ShippingM__ShipP__42ACE4D4] DEFAULT (0) NULL,
  [International]bit CONSTRAINT [DF__ShippingM__Inter__43A1090D] DEFAULT (0) NULL
)
ON [PRIMARY]
GO

--
-- Definition for table ShipPrice : 
--

CREATE TABLE [dbo].[ShipPrice] (
  [ShipPriceID]smallint IDENTITY(1, 1) NOT NULL,
  [SiteID]smallint DEFAULT (1) NOT NULL,
  [Start]money NOT NULL,
  [Finish]money NOT NULL,
  [DomesticRate]money NOT NULL,
  [InternationalRate]money NOT NULL
)
ON [PRIMARY]
GO

--
-- Definition for table ShipWeight : 
--

CREATE TABLE [dbo].[ShipWeight] (
  [ShipWeightID]smallint IDENTITY(1, 1) NOT NULL,
  [SiteID]smallint CONSTRAINT [DF__ShipWeigh__SiteI__4959E263] DEFAULT (1) NOT NULL,
  [Start]float NOT NULL,
  [Finish]float NOT NULL,
  [DomesticRate]money NOT NULL,
  [InternationalRate]money NOT NULL
)
ON [PRIMARY]
GO

--
-- Definition for table States : 
--

CREATE TABLE [dbo].[States] (
  [SID]smallint NOT NULL,
  [State]nvarchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [StateCode]nvarchar(2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
  [T_Rate]float NULL,
  [S_Rate]smallmoney NULL
)
ON [PRIMARY]
GO

--
-- Definition for table USAePay : 
--

CREATE TABLE [dbo].[USAePay] (
  [ID]smallint IDENTITY(1, 1) NOT NULL,
  [TransKey]nvarchar(250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
ON [PRIMARY]
GO

--
-- Definition for table Users : 
--

CREATE TABLE [dbo].[Users] (
  [UID]int NOT NULL,
  [UUserName]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [UPassword]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [UName]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [UMinimum]smallmoney DEFAULT (0) NULL,
  [UMinimumFirst]smallmoney DEFAULT (0) NULL,
  [UTaxable]bit DEFAULT (1) NULL,
  [DateCreated]smalldatetime DEFAULT getdate() NULL,
  [DateUpdated]smalldatetime NULL,
  [UpdatedBy]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
ON [PRIMARY]
GO

--
-- Definition for table Wishlist : 
--

CREATE TABLE [dbo].[Wishlist] (
  [WishListItemID]int IDENTITY(1, 1) NOT NULL,
  [SiteID]smallint DEFAULT (1) NULL,
  [CustomerID]float NULL,
  [SessionID]nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [ItemID]int NULL,
  [Qty]int NULL,
  [OptionName1]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName2]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [OptionName3]nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [DateEntered]smalldatetime DEFAULT getdate() NULL,
  [AffiliateID]nvarchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  [BackOrdered]bit DEFAULT (0) NULL,
  [UseWholesalePrice]bit DEFAULT (0) NULL
)
ON [PRIMARY]
GO

--
-- Definition for table Years : 
--

CREATE TABLE [dbo].[Years] (
  [YearCode]int NULL
)
ON [PRIMARY]
GO

--
-- Data for table AdminUsers  (LIMIT 0,500)
--

SET IDENTITY_INSERT [dbo].[AdminUsers] ON
GO

INSERT INTO [dbo].[AdminUsers] ([UserID], [UserName], [Password], [Roles], [FirstName], [LastName], [CompanyName], [Department], [Address1], [Address2], [City], [State], [Zip], [Country], [Phone], [Fax], [Email], [Comments], [Disabled], [DateCreated], [DateUpdated], [UpdatedBy])
VALUES 
  (1, 'Admin', 'password', 'Administrator', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'CA', NULL, 'US', NULL, NULL, NULL, NULL, 0, '20050101', NULL, NULL)
GO

--
-- 1 record(s) inserted to [dbo].[AdminUsers]
--



SET IDENTITY_INSERT [dbo].[AdminUsers] OFF
GO

--
-- Data for table AffiliateCommissions  (LIMIT 0,500)
--

SET IDENTITY_INSERT [dbo].[AffiliateCommissions] ON
GO

INSERT INTO [dbo].[AffiliateCommissions] ([CommID], [LevelName], [L1], [L2], [L3])
VALUES 
  (1, 'Silver', 4, 6, 1)
GO

INSERT INTO [dbo].[AffiliateCommissions] ([CommID], [LevelName], [L1], [L2], [L3])
VALUES 
  (2, 'Gold', 8, 10, 3)
GO

INSERT INTO [dbo].[AffiliateCommissions] ([CommID], [LevelName], [L1], [L2], [L3])
VALUES 
  (3, 'Platinum', 15, 20, 5)
GO

INSERT INTO [dbo].[AffiliateCommissions] ([CommID], [LevelName], [L1], [L2], [L3])
VALUES 
  (5, 'Titanium', 20, 25, 10)
GO

--
-- 4 record(s) inserted to [dbo].[AffiliateCommissions]
--



SET IDENTITY_INSERT [dbo].[AffiliateCommissions] OFF
GO

--
-- Data for table BillingStatusCodes  (LIMIT 0,500)
--

INSERT INTO [dbo].[BillingStatusCodes] ([StatusCode], [StatusMessage])
VALUES 
  ('BI', 'Billed-In Process')
GO

INSERT INTO [dbo].[BillingStatusCodes] ([StatusCode], [StatusMessage])
VALUES 
  ('NB', 'Not Paid')
GO

INSERT INTO [dbo].[BillingStatusCodes] ([StatusCode], [StatusMessage])
VALUES 
  ('PA', 'Paid')
GO

INSERT INTO [dbo].[BillingStatusCodes] ([StatusCode], [StatusMessage])
VALUES 
  ('PP', 'Paid-Partial')
GO

INSERT INTO [dbo].[BillingStatusCodes] ([StatusCode], [StatusMessage])
VALUES 
  ('CA', 'Canceled')
GO

INSERT INTO [dbo].[BillingStatusCodes] ([StatusCode], [StatusMessage])
VALUES 
  ('RE', 'Refunded')
GO

INSERT INTO [dbo].[BillingStatusCodes] ([StatusCode], [StatusMessage])
VALUES 
  ('DE', 'Payment Declined')
GO

INSERT INTO [dbo].[BillingStatusCodes] ([StatusCode], [StatusMessage])
VALUES 
  ('BC', 'Billed-COD')
GO

INSERT INTO [dbo].[BillingStatusCodes] ([StatusCode], [StatusMessage])
VALUES 
  ('PC', 'Paid-COD')
GO

INSERT INTO [dbo].[BillingStatusCodes] ([StatusCode], [StatusMessage])
VALUES 
  ('PK', 'Paid By Check/MO')
GO

INSERT INTO [dbo].[BillingStatusCodes] ([StatusCode], [StatusMessage])
VALUES 
  ('BK', 'Billed By Invoice')
GO

INSERT INTO [dbo].[BillingStatusCodes] ([StatusCode], [StatusMessage])
VALUES 
  ('AU', 'Payment Authorized')
GO

INSERT INTO [dbo].[BillingStatusCodes] ([StatusCode], [StatusMessage])
VALUES 
  ('VO', 'Transaction Voided')
GO

--
-- 13 record(s) inserted to [dbo].[BillingStatusCodes]
--



--
-- Data for table Countries  (LIMIT 0,500)
--

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Andorra', 'AD', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('United Arab Emirates', 'AE', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Afghanistan', 'AF', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Antigua and Barbuda', 'AG', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Anguilla', 'AI', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Albania', 'AL', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Armenia', 'AM', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Netherlands Antilles', 'AN', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Angola', 'AO', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Antarctica', 'AQ', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Argentina', 'AR', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('American Samoa', 'AS', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Austria', 'AT', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Australia', 'AU', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Aruba', 'AW', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Azerbaidjan', 'AZ', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Bosnia-Herzegovina', 'BA', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Barbados', 'BB', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Bangladesh', 'BD', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Belgium', 'BE', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Burkina Faso', 'BF', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Bulgaria', 'BG', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Bahrain', 'BH', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Burundi', 'BI', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Benin', 'BJ', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Bermuda', 'BM', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Brunei Darussalam', 'BN', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Bolivia', 'BO', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Brazil', 'BR', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Bahamas', 'BS', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Bhutan', 'BT', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Bouvet Island', 'BV', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Botswana', 'BW', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Belarus', 'BY', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Belize', 'BZ', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Canada', 'CA', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Cocos Islands', 'CC', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Central African Republic', 'CF', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Congo', 'CG', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Switzerland', 'CH', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Ivory Coast', 'CI', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Cook Islands', 'CK', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Chile', 'CL', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Cameroon', 'CM', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('China', 'CN', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Colombia', 'CO', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Costa Rica', 'CR', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Former Czechoslovakia', 'CS', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Cuba', 'CU', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Cape Verde', 'CV', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Christmas Island', 'CX', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Cyprus', 'CY', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Czech Republic', 'CZ', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Germany', 'DE', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Djibouti', 'DJ', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Denmark', 'DK', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Dominica', 'DM', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Dominican Republic', 'DO', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Algeria', 'DZ', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Ecuador', 'EC', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Estonia', 'EE', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Egypt', 'EG', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Western Sahara', 'EH', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Spain', 'ES', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Ethiopia', 'ET', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Finland', 'FI', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Fiji', 'FJ', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Falkland Islands', 'FK', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Micronesia', 'FM', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Faroe Islands', 'FO', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('France', 'FR', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Gabon', 'GA', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Great Britain', 'GB', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Grenada', 'GD', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Georgia', 'GE', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('French Guyana', 'GF', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Ghana', 'GH', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Gibraltar', 'GI', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Greenland', 'GL', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Gambia', 'GM', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Guinea', 'GN', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Guadeloupe', 'GP', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Equatorial Guinea', 'GQ', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Greece', 'GR', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Guatemala', 'GT', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Guam', 'GU', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Guinea Bissau', 'GW', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Guyana', 'GY', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Hong Kong', 'HK', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Honduras', 'HN', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Croatia', 'HR', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Haiti', 'HT', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Hungary', 'HU', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Indonesia', 'ID', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Ireland', 'IE', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Israel', 'IL', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('India', 'IN', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Iraq', 'IQ', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Iran', 'IR', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Iceland', 'IS', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Italy', 'IT', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Jamaica', 'JM', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Jordan', 'JO', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Japan', 'JP', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Kenya', 'KE', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Kyrgyzstan', 'KG', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Cambodia', 'KH', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Kiribati', 'KI', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Comoros', 'KM', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('North Korea', 'KP', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('South Korea', 'KR', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Kuwait', 'KW', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Cayman Islands', 'KY', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Kazakhstan', 'KZ', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Laos', 'LA', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Lebanon', 'LB', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Saint Lucia', 'LC', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Liechtenstein', 'LI', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Sri Lanka', 'LK', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Liberia', 'LR', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Lesotho', 'LS', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Lithuania', 'LT', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Luxembourg', 'LU', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Latvia', 'LV', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Libya', 'LY', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Morocco', 'MA', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Monaco', 'MC', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Moldavia', 'MD', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Madagascar', 'MG', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Marshall Islands', 'MH', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Macedonia', 'MK', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Mali', 'ML', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Myanmar', 'MM', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Mongolia', 'MN', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Macau', 'MO', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Martinique', 'MQ', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Mauritania', 'MR', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Montserrat', 'MS', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Malta', 'MT', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Mauritius', 'MU', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Maldives', 'MV', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Malawi', 'MW', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Mexico', 'MX', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Malaysia', 'MY', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Mozambique', 'MZ', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Namibia', 'NA', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('New Caledonia', 'NC', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Niger', 'NE', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Norfolk Island', 'NF', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Nigeria', 'NG', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Nicaragua', 'NI', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Netherlands', 'NL', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Norway', 'NO', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Nepal', 'NP', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Nauru', 'NR', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Neutral Zone', 'NT', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Niue', 'NU', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('New Zealand', 'NZ', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Oman', 'OM', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Panama', 'PA', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Peru', 'PE', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Polynesia', 'PF', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Papua New Guinea', 'PG', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Philippines', 'PH', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Pakistan', 'PK', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Poland', 'PL', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Pitcairn Island', 'PN', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Puerto Rico', 'PR', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Portugal', 'PT', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Palau', 'PW', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Paraguay', 'PY', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Qatar', 'QA', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Reunion', 'RE', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Romania', 'RO', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Russian Federation', 'RU', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Rwanda', 'RW', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Saudi Arabia', 'SA', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Solomon Islands', 'SB', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Seychelles', 'SC', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Sudan', 'SD', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Sweden', 'SE', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Singapore', 'SG', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Saint Helena', 'SH', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Slovenia', 'SI', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Slovak Republic', 'SK', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Sierra Leone', 'SL', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('San Marino', 'SM', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Senegal', 'SN', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Somalia', 'SO', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Suriname', 'SR', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('El Salvador', 'SV', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Syria', 'SY', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Swaziland', 'SZ', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Chad', 'TD', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Togo', 'TG', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Thailand', 'TH', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Tadjikistan', 'TJ', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Tokelau', 'TK', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Turkmenistan', 'TM', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Tunisia', 'TN', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Tonga', 'TO', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('East Timor', 'TP', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Turkey', 'TR', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Trinidad and Tobago', 'TT', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Tuvalu', 'TV', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Taiwan', 'TW', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Tanzania', 'TZ', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Ukraine', 'UA', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Uganda', 'UG', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('United Kingdom', 'GB', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('United States', 'US', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Uruguay', 'UY', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Uzbekistan', 'UZ', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Vatican City State', 'VA', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('St Vincent & Grenadines', 'VC', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Venezuela', 'VE', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Virgin Islands (British)', 'VG', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Virgin Islands (USA)', 'VI', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Vietnam', 'VN', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Vanuatu', 'VU', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Wallis and Futuna Islands', 'WF', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Samoa', 'WS', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Yemen', 'YE', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Mayotte', 'YT', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Yugoslavia', 'YU', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('South Africa', 'ZA', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Zambia', 'ZM', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Zaire', 'ZR', 0)
GO

INSERT INTO [dbo].[Countries] ([Country], [CountryCode], [S_Rate])
VALUES 
  ('Zimbabwe', 'ZW', 0)
GO

--
-- 229 record(s) inserted to [dbo].[Countries]
--



--
-- Data for table Currencies  (LIMIT 0,500)
--

INSERT INTO [dbo].[Currencies] ([Locale], [CurrencyMessage])
VALUES 
  ('Dutch (Standard)', 'Netherlands Guilders')
GO

INSERT INTO [dbo].[Currencies] ([Locale], [CurrencyMessage])
VALUES 
  ('English (Australian)', 'Australian Dollars')
GO

INSERT INTO [dbo].[Currencies] ([Locale], [CurrencyMessage])
VALUES 
  ('English (Canadian)', 'Canadian Dollars')
GO

INSERT INTO [dbo].[Currencies] ([Locale], [CurrencyMessage])
VALUES 
  ('English (New Zealand)', 'New Zealand Dollars')
GO

INSERT INTO [dbo].[Currencies] ([Locale], [CurrencyMessage])
VALUES 
  ('English (UK)', 'United Kingdom Pounds')
GO

INSERT INTO [dbo].[Currencies] ([Locale], [CurrencyMessage])
VALUES 
  ('English (US)', 'United States Dollars')
GO

INSERT INTO [dbo].[Currencies] ([Locale], [CurrencyMessage])
VALUES 
  ('French (Belgian)', 'Belgian Francs')
GO

INSERT INTO [dbo].[Currencies] ([Locale], [CurrencyMessage])
VALUES 
  ('French (Standard)', 'French Francs')
GO

INSERT INTO [dbo].[Currencies] ([Locale], [CurrencyMessage])
VALUES 
  ('French (Swiss)', 'Swiss Francs')
GO

INSERT INTO [dbo].[Currencies] ([Locale], [CurrencyMessage])
VALUES 
  ('German (Austrian)', 'Austrian Schillings')
GO

INSERT INTO [dbo].[Currencies] ([Locale], [CurrencyMessage])
VALUES 
  ('German (Standard)', 'German Deutsche Marks')
GO

INSERT INTO [dbo].[Currencies] ([Locale], [CurrencyMessage])
VALUES 
  ('Italian (Standard)', 'Italian Lira')
GO

INSERT INTO [dbo].[Currencies] ([Locale], [CurrencyMessage])
VALUES 
  ('Norwegian (Nynorski)', 'Norwegian Kroner')
GO

INSERT INTO [dbo].[Currencies] ([Locale], [CurrencyMessage])
VALUES 
  ('Portuguese (Brazilian)', 'Brazilian Real')
GO

INSERT INTO [dbo].[Currencies] ([Locale], [CurrencyMessage])
VALUES 
  ('Portuguese (Standard)', 'Portuguese Escudo')
GO

INSERT INTO [dbo].[Currencies] ([Locale], [CurrencyMessage])
VALUES 
  ('Spanish (Mexican)', 'Mexican Pesos')
GO

INSERT INTO [dbo].[Currencies] ([Locale], [CurrencyMessage])
VALUES 
  ('Spanish (Standard)', 'Spanish Pesetas')
GO

INSERT INTO [dbo].[Currencies] ([Locale], [CurrencyMessage])
VALUES 
  ('Swedish', 'Swedish Krona')
GO

--
-- 18 record(s) inserted to [dbo].[Currencies]
--



--
-- Data for table Days  (LIMIT 0,500)
--

INSERT INTO [dbo].[Days] ([DayCode])
VALUES 
  (1)
GO

INSERT INTO [dbo].[Days] ([DayCode])
VALUES 
  (2)
GO

INSERT INTO [dbo].[Days] ([DayCode])
VALUES 
  (3)
GO

INSERT INTO [dbo].[Days] ([DayCode])
VALUES 
  (4)
GO

INSERT INTO [dbo].[Days] ([DayCode])
VALUES 
  (5)
GO

INSERT INTO [dbo].[Days] ([DayCode])
VALUES 
  (6)
GO

INSERT INTO [dbo].[Days] ([DayCode])
VALUES 
  (7)
GO

INSERT INTO [dbo].[Days] ([DayCode])
VALUES 
  (8)
GO

INSERT INTO [dbo].[Days] ([DayCode])
VALUES 
  (9)
GO

INSERT INTO [dbo].[Days] ([DayCode])
VALUES 
  (10)
GO

INSERT INTO [dbo].[Days] ([DayCode])
VALUES 
  (11)
GO

INSERT INTO [dbo].[Days] ([DayCode])
VALUES 
  (12)
GO

INSERT INTO [dbo].[Days] ([DayCode])
VALUES 
  (13)
GO

INSERT INTO [dbo].[Days] ([DayCode])
VALUES 
  (14)
GO

INSERT INTO [dbo].[Days] ([DayCode])
VALUES 
  (15)
GO

INSERT INTO [dbo].[Days] ([DayCode])
VALUES 
  (16)
GO

INSERT INTO [dbo].[Days] ([DayCode])
VALUES 
  (17)
GO

INSERT INTO [dbo].[Days] ([DayCode])
VALUES 
  (18)
GO

INSERT INTO [dbo].[Days] ([DayCode])
VALUES 
  (19)
GO

INSERT INTO [dbo].[Days] ([DayCode])
VALUES 
  (20)
GO

INSERT INTO [dbo].[Days] ([DayCode])
VALUES 
  (21)
GO

INSERT INTO [dbo].[Days] ([DayCode])
VALUES 
  (22)
GO

INSERT INTO [dbo].[Days] ([DayCode])
VALUES 
  (23)
GO

INSERT INTO [dbo].[Days] ([DayCode])
VALUES 
  (24)
GO

INSERT INTO [dbo].[Days] ([DayCode])
VALUES 
  (25)
GO

INSERT INTO [dbo].[Days] ([DayCode])
VALUES 
  (26)
GO

INSERT INTO [dbo].[Days] ([DayCode])
VALUES 
  (27)
GO

INSERT INTO [dbo].[Days] ([DayCode])
VALUES 
  (28)
GO

INSERT INTO [dbo].[Days] ([DayCode])
VALUES 
  (29)
GO

INSERT INTO [dbo].[Days] ([DayCode])
VALUES 
  (30)
GO

INSERT INTO [dbo].[Days] ([DayCode])
VALUES 
  (31)
GO

--
-- 31 record(s) inserted to [dbo].[Days]
--



--
-- Data for table FormsOfPayment  (LIMIT 0,500)
--

SET IDENTITY_INSERT [dbo].[FormsOfPayment] ON
GO

INSERT INTO [dbo].[FormsOfPayment] ([FOPID], [FOPCode], [FOPMessage], [FOPDesc])
VALUES 
  (1, 1, 'Credit Card', 'Allow customers to use their credit card as a method of payment')
GO

INSERT INTO [dbo].[FormsOfPayment] ([FOPID], [FOPCode], [FOPMessage], [FOPDesc])
VALUES 
  (2, 2, 'PayPal', 'Allow customers to submit payment to your PayPal account using their PayPal account')
GO

INSERT INTO [dbo].[FormsOfPayment] ([FOPID], [FOPCode], [FOPMessage], [FOPDesc])
VALUES 
  (3, 3, 'E-Check', 'Allow customers to submit direct payment using their bank account')
GO

INSERT INTO [dbo].[FormsOfPayment] ([FOPID], [FOPCode], [FOPMessage], [FOPDesc])
VALUES 
  (4, 4, 'Order Form', 'Allow customers to print their order and send it to you.')
GO

--
-- 4 record(s) inserted to [dbo].[FormsOfPayment]
--



SET IDENTITY_INSERT [dbo].[FormsOfPayment] OFF
GO

--
-- Data for table ItemStatusCodes  (LIMIT 0,500)
--

INSERT INTO [dbo].[ItemStatusCodes] ([StatusCode], [StatusMessage])
VALUES 
  ('BO', 'Back Ordered')
GO

INSERT INTO [dbo].[ItemStatusCodes] ([StatusCode], [StatusMessage])
VALUES 
  ('DI', 'Discontinued')
GO

INSERT INTO [dbo].[ItemStatusCodes] ([StatusCode], [StatusMessage])
VALUES 
  ('IS', 'In Stock')
GO

INSERT INTO [dbo].[ItemStatusCodes] ([StatusCode], [StatusMessage])
VALUES 
  ('OS', 'Out of Stock')
GO

--
-- 4 record(s) inserted to [dbo].[ItemStatusCodes]
--



--
-- Data for table MessageCodes  (LIMIT 0,500)
--

SET IDENTITY_INSERT [dbo].[MessageCodes] ON
GO

INSERT INTO [dbo].[MessageCodes] ([MCID], [MessageCode])
VALUES 
  (1, 'Note')
GO

INSERT INTO [dbo].[MessageCodes] ([MCID], [MessageCode])
VALUES 
  (2, 'Important')
GO

INSERT INTO [dbo].[MessageCodes] ([MCID], [MessageCode])
VALUES 
  (3, 'Urgent')
GO

--
-- 3 record(s) inserted to [dbo].[MessageCodes]
--



SET IDENTITY_INSERT [dbo].[MessageCodes] OFF
GO

--
-- Data for table module_Sites  (LIMIT 0,500)
--

SET IDENTITY_INSERT [dbo].[module_Sites] ON
GO

INSERT INTO [dbo].[module_Sites] ([Sites_ID], [Sites_Name], [Sites_Data])
VALUES 
  (1, 'CartFusion Site 1', '_serverSpecificVars.xml.cfm')
GO

--
-- 1 record(s) inserted to [dbo].[module_Sites]
--



SET IDENTITY_INSERT [dbo].[module_Sites] OFF
GO

--
-- Data for table Months  (LIMIT 0,500)
--

INSERT INTO [dbo].[Months] ([MonthCode], [MonthDisplay])
VALUES 
  (1, 'January')
GO

INSERT INTO [dbo].[Months] ([MonthCode], [MonthDisplay])
VALUES 
  (2, 'February')
GO

INSERT INTO [dbo].[Months] ([MonthCode], [MonthDisplay])
VALUES 
  (3, 'March')
GO

INSERT INTO [dbo].[Months] ([MonthCode], [MonthDisplay])
VALUES 
  (4, 'April')
GO

INSERT INTO [dbo].[Months] ([MonthCode], [MonthDisplay])
VALUES 
  (5, 'May')
GO

INSERT INTO [dbo].[Months] ([MonthCode], [MonthDisplay])
VALUES 
  (6, 'June')
GO

INSERT INTO [dbo].[Months] ([MonthCode], [MonthDisplay])
VALUES 
  (7, 'July')
GO

INSERT INTO [dbo].[Months] ([MonthCode], [MonthDisplay])
VALUES 
  (8, 'August')
GO

INSERT INTO [dbo].[Months] ([MonthCode], [MonthDisplay])
VALUES 
  (9, 'September')
GO

INSERT INTO [dbo].[Months] ([MonthCode], [MonthDisplay])
VALUES 
  (10, 'October')
GO

INSERT INTO [dbo].[Months] ([MonthCode], [MonthDisplay])
VALUES 
  (11, 'November')
GO

INSERT INTO [dbo].[Months] ([MonthCode], [MonthDisplay])
VALUES 
  (12, 'December')
GO

--
-- 12 record(s) inserted to [dbo].[Months]
--



--
-- Data for table OrderItemsStatusCodes  (LIMIT 0,500)
--

INSERT INTO [dbo].[OrderItemsStatusCodes] ([StatusCode], [StatusMessage])
VALUES 
  ('BO', 'Back Ordered')
GO

INSERT INTO [dbo].[OrderItemsStatusCodes] ([StatusCode], [StatusMessage])
VALUES 
  ('CA', 'Canceled')
GO

INSERT INTO [dbo].[OrderItemsStatusCodes] ([StatusCode], [StatusMessage])
VALUES 
  ('OD', 'Ordered')
GO

INSERT INTO [dbo].[OrderItemsStatusCodes] ([StatusCode], [StatusMessage])
VALUES 
  ('SH', 'Shipped')
GO

INSERT INTO [dbo].[OrderItemsStatusCodes] ([StatusCode], [StatusMessage])
VALUES 
  ('BP', 'Back Order Processed')
GO

INSERT INTO [dbo].[OrderItemsStatusCodes] ([StatusCode], [StatusMessage])
VALUES 
  ('RE', 'Returned')
GO

INSERT INTO [dbo].[OrderItemsStatusCodes] ([StatusCode], [StatusMessage])
VALUES 
  ('PR', 'Processing')
GO

INSERT INTO [dbo].[OrderItemsStatusCodes] ([StatusCode], [StatusMessage])
VALUES 
  ('RM', 'Processing Return')
GO

--
-- 8 record(s) inserted to [dbo].[OrderItemsStatusCodes]
--



--
-- Data for table OrderStatusCodes  (LIMIT 0,500)
--

INSERT INTO [dbo].[OrderStatusCodes] ([StatusCode], [StatusMessage])
VALUES 
  ('BO', 'Back Ordered')
GO

INSERT INTO [dbo].[OrderStatusCodes] ([StatusCode], [StatusMessage])
VALUES 
  ('CA', 'Canceled')
GO

INSERT INTO [dbo].[OrderStatusCodes] ([StatusCode], [StatusMessage])
VALUES 
  ('IT', 'In Transit')
GO

INSERT INTO [dbo].[OrderStatusCodes] ([StatusCode], [StatusMessage])
VALUES 
  ('OD', 'Ordered')
GO

INSERT INTO [dbo].[OrderStatusCodes] ([StatusCode], [StatusMessage])
VALUES 
  ('SH', 'Shipped')
GO

INSERT INTO [dbo].[OrderStatusCodes] ([StatusCode], [StatusMessage])
VALUES 
  ('SP', 'Shipped-Partial')
GO

INSERT INTO [dbo].[OrderStatusCodes] ([StatusCode], [StatusMessage])
VALUES 
  ('RE', 'Returned')
GO

INSERT INTO [dbo].[OrderStatusCodes] ([StatusCode], [StatusMessage])
VALUES 
  ('PR', 'Processing')
GO

INSERT INTO [dbo].[OrderStatusCodes] ([StatusCode], [StatusMessage])
VALUES 
  ('RM', 'Processing Return')
GO

--
-- 9 record(s) inserted to [dbo].[OrderStatusCodes]
--



--
-- Data for table Payment  (LIMIT 0,500)
--

INSERT INTO [dbo].[Payment] ([Type], [Display], [Allow])
VALUES 
  ('AE', 'American Express', 1)
GO

INSERT INTO [dbo].[Payment] ([Type], [Display], [Allow])
VALUES 
  ('DI', 'Discover', 0)
GO

INSERT INTO [dbo].[Payment] ([Type], [Display], [Allow])
VALUES 
  ('MC', 'Master Card', 1)
GO

INSERT INTO [dbo].[Payment] ([Type], [Display], [Allow])
VALUES 
  ('VI', 'Visa', 1)
GO

--
-- 4 record(s) inserted to [dbo].[Payment]
--



--
-- Data for table PaymentSystems  (LIMIT 0,500)
--

SET IDENTITY_INSERT [dbo].[PaymentSystems] ON
GO

INSERT INTO [dbo].[PaymentSystems] ([PSID], [PaymentSystemCode], [PaymentSystemMessage], [PSLogo], [DisplayOrder])
VALUES 
  (1, 'NO', 'None/Manual Order Handling', NULL, 1)
GO

INSERT INTO [dbo].[PaymentSystems] ([PSID], [PaymentSystemCode], [PaymentSystemMessage], [PSLogo], [DisplayOrder])
VALUES 
  (2, 'AN', 'Authorize.net 3.1', 'logo-pgAuthorizeNet.gif', 2)
GO

INSERT INTO [dbo].[PaymentSystems] ([PSID], [PaymentSystemCode], [PaymentSystemMessage], [PSLogo], [DisplayOrder])
VALUES 
  (3, 'US', 'USA ePay', 'logo-pgUSAePay.gif', 5)
GO

INSERT INTO [dbo].[PaymentSystems] ([PSID], [PaymentSystemCode], [PaymentSystemMessage], [PSLogo], [DisplayOrder])
VALUES 
  (4, 'PL', 'PayFlow Link', 'logo-pgPayFlowLink.gif', 3)
GO

INSERT INTO [dbo].[PaymentSystems] ([PSID], [PaymentSystemCode], [PaymentSystemMessage], [PSLogo], [DisplayOrder])
VALUES 
  (5, 'PP', 'PayPal Pro', 'logo-pgPayPal.gif', 4)
GO

INSERT INTO [dbo].[PaymentSystems] ([PSID], [PaymentSystemCode], [PaymentSystemMessage], [PSLogo], [DisplayOrder])
VALUES 
  (6, 'WP', 'WorldPay', 'logo-pgWorldPay.gif', 6)
GO

INSERT INTO [dbo].[PaymentSystems] ([PSID], [PaymentSystemCode], [PaymentSystemMessage], [PSLogo], [DisplayOrder])
VALUES 
  (7, 'LP', 'LinkPoint/YourPay API', 'logo-pgYourPay.gif', 2)
GO

--
-- 7 record(s) inserted to [dbo].[PaymentSystems]
--



SET IDENTITY_INSERT [dbo].[PaymentSystems] OFF
GO

--
-- Data for table Roles  (LIMIT 0,500)
--

SET IDENTITY_INSERT [dbo].[Roles] ON
GO

INSERT INTO [dbo].[Roles] ([RID], [Role])
VALUES 
  (1, 'Administrator')
GO

INSERT INTO [dbo].[Roles] ([RID], [Role])
VALUES 
  (2, 'User')
GO

--
-- 2 record(s) inserted to [dbo].[Roles]
--



SET IDENTITY_INSERT [dbo].[Roles] OFF
GO

--
-- Data for table ShippingMethods  (LIMIT 0,500)
--

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (1, 1, '01', 'UPS Next Day Air', 1, 'UPS', 0, 0, 0, 0, 0, 0)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (2, 1, '02', 'UPS 2nd Day Air', 1, 'UPS', 0, 0, 0, 0, 0, 0)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (3, 1, '03', 'UPS Ground', 1, 'UPS', 0, 0, 0, 0, 0, 0)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (4, 1, '07', 'UPS Worldwide Express', 1, 'UPS', 0, 0, 0, 0, 0, 1)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (5, 1, '08', 'UPS Worldwide Expedited', 0, 'UPS', 0, 0, 0, 0, 0, 1)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (6, 1, '11', 'UPS Ground Service to Canada', 1, 'UPS', 0, 0, 0, 0, 0, 1)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (7, 1, '12', 'UPS 3-Day Select', 0, 'UPS', 0, 0, 0, 0, 0, 0)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (8, 1, '13', 'UPS Next Day Air Saver', 0, 'UPS', 0, 0, 0, 0, 0, 0)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (9, 1, '14', 'UPS Next Day Air Early AM', 0, 'UPS', 0, 0, 0, 0, 0, 0)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (10, 1, '54', 'UPS Worldwide Express Plus', 0, 'UPS', 0, 0, 0, 0, 0, 1)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (11, 1, '59', 'UPS 2nd Day Air AM', 0, 'UPS', 0, 0, 0, 0, 0, 0)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (12, 1, '65', 'UPS Express Saver', 0, 'UPS', 0, 0, 0, 0, 0, 0)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (13, 1, 'Priority', 'USPS Priority Mail', 1, 'USPS', 0, 0, 0, 0, 0, 0)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (14, 1, 'Express', 'USPS Express Mail', 1, 'USPS', 0, 0, 0, 0, 0, 0)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (15, 1, 'First Class', 'USPS First Class Mail', 0, 'USPS', 0, 0, 0, 0, 0, 0)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (16, 1, 'Parcel', 'USPS Parcel Post', 0, 'USPS', 0, 0, 0, 0, 0, 0)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (17, 1, 'BPM', 'USPS Bound Printed Matter', 0, 'USPS', 0, 0, 0, 0, 0, 0)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (18, 1, 'Library', 'USPS Library Mail Service', 0, 'USPS', 0, 0, 0, 0, 0, 0)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (19, 1, 'Media', 'USPS Media Mail', 0, 'USPS', 0, 0, 0, 0, 0, 0)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (20, 1, 'STANDARDOVERNIGHT', 'FedEx Standard Overnight', 0, 'FedEx', 0, 0, 0, 0, 0, 0)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (21, 1, 'PRIORITYOVERNIGHT', 'FedEx Priority Overnight', 1, 'FedEx', 0, 0, 0, 0, 0, 0)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (22, 1, 'FIRSTOVERNIGHT', 'FedEx First Overnight', 0, 'FedEx', 0, 0, 0, 0, 0, 0)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (23, 1, 'FEDEX2DAY', 'FedEx 2 Day', 1, 'FedEx', 0, 0, 0, 0, 0, 0)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (24, 1, 'FEDEXEXPRESSSAVER', 'FedEx 3 Day Express Saver', 0, 'FedEx', 0, 0, 0, 0, 0, 0)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (25, 1, 'FEDEXGROUND', 'FedEx Ground', 1, 'FedEx', 0, 0, 0, 0, 0, 0)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (26, 1, 'GROUNDHOMEDELIVERY', 'FedEx Ground Home Delivery', 0, 'FedEx', 0, 0, 0, 0, 0, 0)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (27, 1, 'FEDEX1DAYFREIGHT', 'FedEx 1 Day Freight', 0, 'FedEx', 0, 0, 0, 0, 0, 0)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (29, 1, 'FEDEX2DAYFREIGHT', 'FedEx 2 Day Freight', 0, 'FedEx', 0, 0, 0, 0, 0, 0)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (30, 1, 'FEDEX3DAYFREIGHT', 'FedEx 3 Day Freight', 0, 'FedEx', 0, 0, 0, 0, 0, 0)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (31, 1, 'INTERNATIONALPRIORITY', 'FedEx Int''l Priority', 1, 'FedEx', 0, 0, 0, 0, 0, 1)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (32, 1, 'INTERNATIONALECONOMY', 'FedEx Int''l Economy', 1, 'FedEx', 0, 0, 0, 0, 0, 1)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (33, 1, 'INTERNATIONALFIRST', 'FedEx Int''l First', 0, 'FedEx', 0, 0, 0, 0, 0, 1)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (34, 1, 'INTERNATIONALPRIORITYFREIGHT', 'FedEx Int''l Priority Freight', 0, 'FedEx', 0, 0, 0, 0, 0, 1)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (35, 1, 'INTERNATIONALECONOMYFREIGHT', 'FedEx Int''l Economy Freight', 0, 'FedEx', 0, 0, 0, 0, 0, 1)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (36, 1, 'Location', 'By Location', 1, 'Location', 0, 0, 0, 0, 0, 0)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (37, 1, 'Price', 'By Price', 1, 'Price', 0, 0, 0, 0, 0, 0)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (38, 1, 'Weight', 'By Weight', 1, 'Weight', 0, 0, 0, 0, 0, 0)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (39, 1, 'Default', 'Default Shipping', 1, 'Default', 0, 0, 0, 0, 0, 0)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (40, 1, 'Global Express Guaranteed Document Service', 'USPS Gbl XP Guar. Doc Svc', 0, 'USPS', 0, 0, 0, 0, 0, 1)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (41, 1, 'Global Express Guaranteed Non-Document Service', 'USPS Gbl XP Guar. Non-Doc Svc', 0, 'USPS', 0, 0, 0, 0, 0, 1)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (42, 1, 'Global Express Mail (EMS)', 'USPS Global Express Mail (EMS)', 1, 'USPS', 0, 0, 0, 0, 0, 1)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (43, 1, 'Global Priority Mail - Flat-rate Envelope (Large)', 'USPS GPM - Flat-rate Env. (Lg)', 0, 'USPS', 0, 0, 0, 0, 0, 1)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (44, 1, 'Global Priority Mail - Flat-rate Envelope (Small)', 'USPS GPM - Flat-rate Env. (Sm)', 0, 'USPS', 0, 0, 0, 0, 0, 1)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (45, 1, 'Global Priority Mail - Variable Weight Envelope (Single)', 'USPS GPM - Envelope (Single)', 0, 'USPS', 0, 0, 0, 0, 0, 1)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (46, 1, 'Airmail Letter-post', 'USPS Airmail Letter-post', 0, 'USPS', 0, 0, 0, 0, 0, 1)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (47, 1, 'Airmail Parcel Post', 'USPS Airmail Parcel Post', 1, 'USPS', 0, 0, 0, 0, 0, 1)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (48, 1, 'Economy (Surface) Letter-post', 'USPS Surface Letter-post', 0, 'USPS', 0, 0, 0, 0, 0, 1)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (49, 1, 'Economy (Surface) Parcel Post', 'USPS Surface Parcel Post', 1, 'USPS', 0, 0, 0, 0, 0, 1)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (50, 1, 'Custom1', 'USPS First Class', 1, 'Custom', 3.85, 0, 4, 0, 0, 0)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (51, 1, 'Custom2', 'USPS Priority Mail', 1, 'Custom', 7.95, 4, 10, 0, 0, 0)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (52, 1, 'Custom3', 'FedEx 2-Day', 1, 'Custom', 14, 0, 5, 0, 0, 0)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (53, 1, 'Custom4', 'FedEx Standard Overnight', 1, 'Custom', 20, 0, 5, 0, 0, 0)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (54, 1, 'Custom5', 'FedEx 2-Day', 1, 'Custom', 18, 5, 20, 0, 0, 0)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (55, 1, 'Custom6', 'FedEx Priority Overnight', 1, 'Custom', 26, 5, 20, 0, 0, 0)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (56, 1, 'Custom7', 'Default Shipping', 1, 'Custom', 29.95, 20, 100000, 0, 0, 0)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (57, 1, 'Custom8', 'International Shipping', 1, 'Custom', 12.95, 0, 100000, 0, 0, 1)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (58, 1, 'Custom9', 'FedEx 3-Day', 1, 'Custom', 9, 0, 5, 0, 0, 0)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (59, 1, 'Custom10', 'FedEx 3-Day', 1, 'Custom', 12, 5, 20, 0, 0, 0)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (60, 1, 'Custom11', 'USPS Priority Mail', 1, 'Custom', 14.95, 10, 20, 0, 0, 0)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (61, 1, 'CustomP1', 'Default Shipping', 1, 'Custom', 7.95, 0, 0, 0, 100000, 0)
GO

INSERT INTO [dbo].[ShippingMethods] ([SMID], [SiteID], [ShippingCode], [ShippingMessage], [Allow], [ShippingCompany], [ShipPrice], [ShipWeightLo], [ShipWeightHi], [ShipPriceLo], [ShipPriceHi], [International])
VALUES 
  (62, 1, 'CustomP2', 'Default Int''l Shipping', 1, 'Custom', 15.95, 0, 0, 0, 100000, 1)
GO

--
-- 61 record(s) inserted to [dbo].[ShippingMethods]
--



--
-- Data for table ShipPrice  (LIMIT 0,500)
--

SET IDENTITY_INSERT [dbo].[ShipPrice] ON
GO

INSERT INTO [dbo].[ShipPrice] ([ShipPriceID], [SiteID], [Start], [Finish], [DomesticRate], [InternationalRate])
VALUES 
  (1, 1, 0, 250, 7.95, 13.95)
GO

INSERT INTO [dbo].[ShipPrice] ([ShipPriceID], [SiteID], [Start], [Finish], [DomesticRate], [InternationalRate])
VALUES 
  (2, 1, 250.01, 500, 13.95, 20.95)
GO

INSERT INTO [dbo].[ShipPrice] ([ShipPriceID], [SiteID], [Start], [Finish], [DomesticRate], [InternationalRate])
VALUES 
  (3, 1, 500.01, 1000, 19.95, 30.95)
GO

INSERT INTO [dbo].[ShipPrice] ([ShipPriceID], [SiteID], [Start], [Finish], [DomesticRate], [InternationalRate])
VALUES 
  (4, 1, 1000.01, 1500, 26.95, 40.95)
GO

INSERT INTO [dbo].[ShipPrice] ([ShipPriceID], [SiteID], [Start], [Finish], [DomesticRate], [InternationalRate])
VALUES 
  (5, 1, 1500.01, 2000, 35.95, 50.95)
GO

INSERT INTO [dbo].[ShipPrice] ([ShipPriceID], [SiteID], [Start], [Finish], [DomesticRate], [InternationalRate])
VALUES 
  (6, 1, 2000.01, 100000, 50.95, 80.95)
GO

--
-- 6 record(s) inserted to [dbo].[ShipPrice]
--



SET IDENTITY_INSERT [dbo].[ShipPrice] OFF
GO

--
-- Data for table ShipWeight  (LIMIT 0,500)
--

SET IDENTITY_INSERT [dbo].[ShipWeight] ON
GO

INSERT INTO [dbo].[ShipWeight] ([ShipWeightID], [SiteID], [Start], [Finish], [DomesticRate], [InternationalRate])
VALUES 
  (1, 1, 0, 2, 6.95, 11.95)
GO

INSERT INTO [dbo].[ShipWeight] ([ShipWeightID], [SiteID], [Start], [Finish], [DomesticRate], [InternationalRate])
VALUES 
  (2, 1, 2, 3, 8.45, 15.95)
GO

INSERT INTO [dbo].[ShipWeight] ([ShipWeightID], [SiteID], [Start], [Finish], [DomesticRate], [InternationalRate])
VALUES 
  (3, 1, 3, 4, 9.95, 18.95)
GO

INSERT INTO [dbo].[ShipWeight] ([ShipWeightID], [SiteID], [Start], [Finish], [DomesticRate], [InternationalRate])
VALUES 
  (4, 1, 4, 5, 10.45, 21.95)
GO

INSERT INTO [dbo].[ShipWeight] ([ShipWeightID], [SiteID], [Start], [Finish], [DomesticRate], [InternationalRate])
VALUES 
  (5, 1, 5, 6, 11.95, 24.95)
GO

INSERT INTO [dbo].[ShipWeight] ([ShipWeightID], [SiteID], [Start], [Finish], [DomesticRate], [InternationalRate])
VALUES 
  (6, 1, 6, 10, 12.95, 26.95)
GO

INSERT INTO [dbo].[ShipWeight] ([ShipWeightID], [SiteID], [Start], [Finish], [DomesticRate], [InternationalRate])
VALUES 
  (7, 1, 10, 15, 13.45, 29.95)
GO

INSERT INTO [dbo].[ShipWeight] ([ShipWeightID], [SiteID], [Start], [Finish], [DomesticRate], [InternationalRate])
VALUES 
  (8, 1, 15, 30, 15.95, 34.95)
GO

INSERT INTO [dbo].[ShipWeight] ([ShipWeightID], [SiteID], [Start], [Finish], [DomesticRate], [InternationalRate])
VALUES 
  (9, 1, 30, 150, 30.95, 60.95)
GO

INSERT INTO [dbo].[ShipWeight] ([ShipWeightID], [SiteID], [Start], [Finish], [DomesticRate], [InternationalRate])
VALUES 
  (10, 1, 150.01, 1000000, 199, 299)
GO

--
-- 10 record(s) inserted to [dbo].[ShipWeight]
--



SET IDENTITY_INSERT [dbo].[ShipWeight] OFF
GO

--
-- Data for table States  (LIMIT 0,500)
--

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (0, '--- UNITED STATES ---', '', 0, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (1, 'Alabama', 'AL', 4, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (2, 'Alaska', 'AK', 0, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (3, 'Arizona', 'AZ', 5.6, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (4, 'Arkansas', 'AR', 6, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (5, 'California', 'CA', 7.25, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (6, 'Colorado', 'CO', 2.9, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (7, 'Connecticut', 'CT', 6, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (8, 'Delaware', 'DE', 0, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (9, 'District of Columbia', 'DC', 5.75, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (10, 'Florida', 'FL', 6, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (11, 'Georgia', 'GA', 4, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (12, 'Hawaii', 'HI', 4, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (13, 'Idaho', 'ID', 5, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (14, 'Illinois', 'IL', 6.25, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (15, 'Indiana', 'IN', 6, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (16, 'Iowa', 'IA', 5, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (17, 'Kansas', 'KS', 5.3, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (18, 'Kentucky', 'KY', 6, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (19, 'Louisiana', 'LA', 4, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (20, 'Maine', 'ME', 5, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (21, 'Maryland', 'MD', 5, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (22, 'Massachusetts', 'MA', 5, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (23, 'Michigan', 'MI', 6, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (24, 'Minnesota', 'MN', 6.5, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (25, 'Mississippi', 'MS', 7, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (26, 'Missouri', 'MO', 4.225, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (27, 'Montana', 'MT', 0, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (28, 'Nebraska', 'NE', 5.5, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (29, 'Nevada', 'NV', 6.5, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (30, 'New Hampshire', 'NH', 0, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (31, 'New Jersey', 'NJ', 6, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (32, 'New Mexico', 'NM', 5, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (33, 'New York', 'NY', 4, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (34, 'North Carolina', 'NC', 4.5, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (35, 'North Dakota', 'ND', 5, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (36, 'Ohio', 'OH', 5.5, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (37, 'Oklahoma', 'OK', 1, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (38, 'Oregon', 'OR', 0, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (39, 'Pennsylvania', 'PA', 6, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (40, 'Rhode Island', 'RI', 7, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (41, 'South Carolina', 'SC', 5, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (42, 'South Dakota', 'SD', 4, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (43, 'Tennessee', 'TN', 7, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (44, 'Texas', 'TX', 6.25, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (45, 'Utah', 'UT', 4.75, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (46, 'Vermont', 'VT', 6, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (47, 'Virginia', 'VA', 5, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (48, 'Washington', 'WA', 6.5, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (49, 'West Virginia', 'WV', 6, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (50, 'Wisconsin', 'WI', 5, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (51, 'Wyoming', 'WY', 4, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (53, '--- CANADA ---', '', 0, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (54, 'Alberta', 'AB', 0, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (55, 'British Columbia', 'BC', 7, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (56, 'Manitoba', 'MB', 7, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (57, 'New Brunswick', 'NB', 15, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (58, 'Newfoundland', 'NF', 15, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (59, 'Northwest Territories', 'NT', 0, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (60, 'Nova Scotia', 'NS', 15, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (61, 'Ontario', 'ON', 8, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (62, 'Prince Edward Island', 'PE', 10, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (63, 'Quebec', 'QC', 7.5, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (64, 'Saskatchewan', 'SK', 7, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (65, 'Yukon', 'YT', 0, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (66, '--- US TERRITORIES ---', '', 0, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (67, 'American Samoa', 'AS', 5.5, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (68, 'Fed. Micronesia', 'FM', 5.5, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (69, 'Guam', 'GU', 5.5, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (70, 'Marshall Island', 'MH', 5.5, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (71, 'N. Mariana Is.', 'MP', 5.5, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (72, 'Palau Island', 'PW', 5.5, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (73, 'Puerto Rico', 'PR', 5.5, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (74, 'U.S. Virgin Islands', 'VI', 5.5, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (75, 'AA - Military Base', 'AA', 0, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (76, 'AE - Military Base', 'AE', 0, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (77, 'AP - Military Base', 'AP', 0, 0)
GO

INSERT INTO [dbo].[States] ([SID], [State], [StateCode], [T_Rate], [S_Rate])
VALUES 
  (78, '- International/Other', '-', 0, 0)
GO

--
-- 78 record(s) inserted to [dbo].[States]
--



--
-- Data for table Users  (LIMIT 0,500)
--

INSERT INTO [dbo].[Users] ([UID], [UUserName], [UPassword], [UName], [UMinimum], [UMinimumFirst], [UTaxable], [DateCreated], [DateUpdated], [UpdatedBy])
VALUES 
  (1, 'retail', 'retail', 'Retail', 0, 0, 1, '20041121', NULL, NULL)
GO

INSERT INTO [dbo].[Users] ([UID], [UUserName], [UPassword], [UName], [UMinimum], [UMinimumFirst], [UTaxable], [DateCreated], [DateUpdated], [UpdatedBy])
VALUES 
  (2, 'wholesaler', 'cartfusion', 'Wholesale', 500, 1000, 0, '20050828 08:30:00', '20050828 08:30:00', 'ADMIN')
GO

--
-- 2 record(s) inserted to [dbo].[Users]
--



--
-- Data for table Years  (LIMIT 0,500)
--

INSERT INTO [dbo].[Years] ([YearCode])
VALUES 
  (2000)
GO

INSERT INTO [dbo].[Years] ([YearCode])
VALUES 
  (2001)
GO

INSERT INTO [dbo].[Years] ([YearCode])
VALUES 
  (2002)
GO

INSERT INTO [dbo].[Years] ([YearCode])
VALUES 
  (2003)
GO

INSERT INTO [dbo].[Years] ([YearCode])
VALUES 
  (2004)
GO

INSERT INTO [dbo].[Years] ([YearCode])
VALUES 
  (2005)
GO

--
-- 6 record(s) inserted to [dbo].[Years]
--



--
-- Definition for indices : 
--

ALTER TABLE [dbo].[AdminUsers]
ADD CONSTRAINT [PK_AdminUsers_1] 
PRIMARY KEY CLUSTERED ([UserID])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[AffiliateCommissions]
ADD CONSTRAINT [PK_AffiliateCommissions] 
PRIMARY KEY CLUSTERED ([CommID])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[AffiliateHistory]
ADD CONSTRAINT [PK_AffiliateHistory] 
PRIMARY KEY CLUSTERED ([AHID])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[AffiliateOrders]
ADD CONSTRAINT [PK_AffiliateOrders] 
PRIMARY KEY CLUSTERED ([AFOID])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[AffiliatePayments]
ADD CONSTRAINT [PK_AffiliatePayments] 
PRIMARY KEY CLUSTERED ([AFPID])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[Affiliates]
ADD CONSTRAINT [PK_affiliates] 
PRIMARY KEY CLUSTERED ([AFID])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[AuthorizeNet]
ADD CONSTRAINT [PK_authorizenet] 
PRIMARY KEY CLUSTERED ([ID])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[AuthorizeNetTK]
ADD CONSTRAINT [PK_AuthorizeNetTK] 
PRIMARY KEY CLUSTERED ([ID])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[BackOrderItems]
ADD CONSTRAINT [PK_BackOrderItems] 
PRIMARY KEY CLUSTERED ([BOIID])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[BackOrders]
ADD CONSTRAINT [PK_BackOrders] 
PRIMARY KEY CLUSTERED ([BOUniqueID])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[Cart]
ADD CONSTRAINT [PK_Cart] 
PRIMARY KEY CLUSTERED ([CartItemID])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[Categories]
ADD CONSTRAINT [PK_Categories] 
PRIMARY KEY CLUSTERED ([CatID])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[CustomerCC]
ADD CONSTRAINT [PK_CustomerCC] 
PRIMARY KEY CLUSTERED ([CustomerCCID])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[Customers]
ADD CONSTRAINT [PK_Customers] 
PRIMARY KEY CLUSTERED ([CustomerID])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[CustomerSH]
ADD CONSTRAINT [PK_CustomerSH] 
PRIMARY KEY CLUSTERED ([SHID])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[Dictionary]
ADD CONSTRAINT [PK_Dictionary] 
PRIMARY KEY CLUSTERED ([DID])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[Discounts]
ADD CONSTRAINT [PK_Discounts] 
PRIMARY KEY CLUSTERED ([DiscountID])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[DiscountUsage]
ADD CONSTRAINT [PK_DiscountUsage] 
PRIMARY KEY CLUSTERED ([DUID])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[Distributors]
ADD CONSTRAINT [PK_Distributors] 
PRIMARY KEY CLUSTERED ([DistributorID])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[FormsOfPayment]
ADD CONSTRAINT [PK_FormsOfPayment] 
PRIMARY KEY CLUSTERED ([FOPID])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[ItemClassComponents]
ADD CONSTRAINT [PK_ItemClassComponents] 
PRIMARY KEY CLUSTERED ([ICCID])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[ItemClasses]
ADD CONSTRAINT [PK_ItemClasses] 
PRIMARY KEY CLUSTERED ([ICID])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[Manufacturers]
ADD CONSTRAINT [PK_Manufacturers] 
PRIMARY KEY CLUSTERED ([ManufacturerID])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[MessageCenter]
ADD CONSTRAINT [PK_MessageCenter] 
PRIMARY KEY CLUSTERED ([MCID])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[MessageCodes]
ADD CONSTRAINT [PK_MessageCodes] 
PRIMARY KEY CLUSTERED ([MCID])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[Messages]
ADD CONSTRAINT [PK_Messages] 
PRIMARY KEY CLUSTERED ([MessageID])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[module_Sites]
ADD CONSTRAINT [PK_module_Sites] 
PRIMARY KEY CLUSTERED ([Sites_ID])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[OrderItems]
ADD CONSTRAINT [PK_OrderItems] 
PRIMARY KEY CLUSTERED ([OrderItemsID])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[OrderReturnItems]
ADD CONSTRAINT [PK_OrderReturnItems] 
PRIMARY KEY CLUSTERED ([ORIID])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[OrderReturns]
ADD CONSTRAINT [PK_OrderReturns] 
PRIMARY KEY CLUSTERED ([OrderReturnID])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[Orders]
ADD CONSTRAINT [PK_Orders] 
PRIMARY KEY CLUSTERED ([OrderID])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[PayFlowLink]
ADD CONSTRAINT [PK_PayFlowLink] 
PRIMARY KEY CLUSTERED ([ID])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[PaymentSystems]
ADD CONSTRAINT [PK_PaymentSystems] 
PRIMARY KEY CLUSTERED ([PSID])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[PGPayPal]
ADD CONSTRAINT [PK_PGPayPal] 
PRIMARY KEY CLUSTERED ([PPID])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[PGYourPayAPI]
ADD CONSTRAINT [PK_PGYourPayAPI] 
PRIMARY KEY CLUSTERED ([ID])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[ProductOptions]
ADD CONSTRAINT [PK_ProductOptions] 
PRIMARY KEY CLUSTERED ([ItemAltID])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[ProductReviews]
ADD CONSTRAINT [PK_UserReviews] 
PRIMARY KEY CLUSTERED ([PRID])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[Products]
ADD CONSTRAINT [PK_Products] 
PRIMARY KEY CLUSTERED ([ItemID])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[ProductSpecs]
ADD CONSTRAINT [PK_ProductSpecs] 
PRIMARY KEY CLUSTERED ([SpecID])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[ProductTypes]
ADD CONSTRAINT [PK_ProductTypes] 
PRIMARY KEY CLUSTERED ([TypeID])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[RelatedItems]
ADD CONSTRAINT [PK_RelatedItems] 
PRIMARY KEY CLUSTERED ([RelatedID])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[Roles]
ADD CONSTRAINT [PK_Roles] 
PRIMARY KEY CLUSTERED ([RID])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[Sections]
ADD CONSTRAINT [PK_Sections] 
PRIMARY KEY CLUSTERED ([SectionID])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[ShippingCodes]
ADD CONSTRAINT [PK_ShippingCodes] 
PRIMARY KEY CLUSTERED ([ShippingCode])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[ShippingCompanies]
ADD CONSTRAINT [PK_ShippingCompanies] 
PRIMARY KEY CLUSTERED ([SCID])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[ShippingMethods]
ADD CONSTRAINT [PK_ShippingMethods] 
PRIMARY KEY CLUSTERED ([SMID])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[ShipPrice]
ADD CONSTRAINT [PK_ShipPrice] 
PRIMARY KEY CLUSTERED ([ShipPriceID])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[ShipWeight]
ADD CONSTRAINT [PK_ShipWeight] 
PRIMARY KEY CLUSTERED ([ShipWeightID])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[States]
ADD CONSTRAINT [PK_States] 
PRIMARY KEY CLUSTERED ([SID])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[USAePay]
ADD CONSTRAINT [PK_USAePay] 
PRIMARY KEY CLUSTERED ([ID])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[Users]
ADD CONSTRAINT [PK_Users] 
PRIMARY KEY CLUSTERED ([UID])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

ALTER TABLE [dbo].[Wishlist]
ADD CONSTRAINT [PK_Wishlist] 
PRIMARY KEY CLUSTERED ([WishListItemID])
WITH (
  PAD_INDEX = OFF,
  IGNORE_DUP_KEY = OFF,
  STATISTICS_NORECOMPUTE = OFF,
  ALLOW_ROW_LOCKS = ON,
  ALLOW_PAGE_LOCKS = ON)
ON [PRIMARY]
GO

--
-- Definition for view vw_RPro_Attributes : 
--

--
-- Definition for view vw_RPro_Attributes : 
--

--
-- Definition for view vw_RPro_Attributes : 
--

----------------------------------------------------
-- dbo.vw_RPro_Attributes
----------------------------------------------------
----------------------------------------------------
-- dbo.vw_RPro_Attributes
----------------------------------------------------
----------------------------------------------------
-- dbo.vw_RPro_Attributes
----------------------------------------------------
----------------------------------------------------
-- dbo.vw_RPro_Attributes
----------------------------------------------------
----------------------------------------------------
-- dbo.vw_RPro_Attributes
----------------------------------------------------
----------------------------------------------------
-- dbo.vw_RPro_Attributes
----------------------------------------------------
CREATE VIEW dbo.vw_RPro_Attributes AS
SELECT DISTINCT FldStyleSID,Item_fldSize  ,Item_fldAttr
FROM Rpro_In_Styles
WHERE Record_Type = 'Item'
GO

--
-- Definition for view vw_RPro_In_Price : 
--

--
-- Definition for view vw_RPro_In_Price : 
--

--
-- Definition for view vw_RPro_In_Price : 
--

----------------------------------------------------
-- dbo.vw_RPro_In_Price
----------------------------------------------------
----------------------------------------------------
-- dbo.vw_RPro_In_Price
----------------------------------------------------
----------------------------------------------------
-- dbo.vw_RPro_In_Price
----------------------------------------------------
----------------------------------------------------
-- dbo.vw_RPro_In_Price
----------------------------------------------------
----------------------------------------------------
-- dbo.vw_RPro_In_Price
----------------------------------------------------
----------------------------------------------------
-- dbo.vw_RPro_In_Price
----------------------------------------------------
--	4/6/2005 b
--	ddolph - Query changed to better handle pricing for the purepaddlesports.com site.
CREATE   VIEW dbo.vw_RPro_In_Price AS 
-- This view is used to calcualte the mean price for Products
-- It is used in the SP_RPro_Load_Styles Stored Proc
	SELECT
		fldStyleSID
		, Price = MAX(ISNULL(CAST(item_Price1 AS MONEY), 0))
		, SalePrice = MAX(ISNULL(CAST(item_Price1 AS MONEY), 0))
	FROM
		RPro_In_Styles (NOLOCK)
	WHERE
		Record_Type = 'Item'
	GROUP BY
		fldStyleSID
-- SELECT fldStyleSID, Price = CAST(item_Price1 as MONEY),SalePrice =
-- CAST(item_Price1 as MONEY), Counts = Count(*)
-- FROM Rpro_in_Styles
-- WHERE item_Price1 is not null
-- GROUP BY fldStyleSID,item_Price1,item_Price1
GO

--
-- Definition for stored procedure SP_RPro_Export : 
--

--
-- Definition for stored procedure SP_RPro_Export : 
--

--
-- Definition for stored procedure SP_RPro_Export : 
--

CREATE          PROC [dbo].SP_RPro_Export
AS
BEGIN
/****************************************************************************
			Written by Paul Duncan
			Retail Dimensions Inc
			www.retaildimensions.com
			January 20th 2005
Called from the RTI COMM object
This Stored Procedure is used to call the Exports for Retail Pro
Developers can add calls to their own Stored Procs from within this SP
********************************************************************************/
-- Clear out the staging tables so we are ready to receive new orders
TRUNCATE TABLE RPro_Out_SO
TRUNCATE TABLE RPRo_Out_SO_Items
TRUNCATE TABLE RPRo_Out_Customers
--Call the Orders Export  to send to Retail Pro
EXEC  SP_RPro_Export_Orders
--Call the Customer Export to send to Retail Pro
EXEC SP_RPro_Export_Customers
/********************************************************************************
Add additional code here for Custom Code
********************************************************************************/
END
GO

--
-- Definition for stored procedure SP_RPro_Export_Customers : 
--

--
-- Definition for stored procedure SP_RPro_Export_Customers : 
--

--
-- Definition for stored procedure SP_RPro_Export_Customers : 
--

--	3/24/2005 a
CREATE     PROC dbo.SP_RPro_Export_Customers AS
BEGIN
--The Customer Table needs to be modified.
--ALTER TABLE dbo.Customers ADD RProSID varchar(50) NULL
/****************************************************************************
			Written by Paul Duncan
			Retail Dimensions Inc
			www.retaildimensions.com
			January 20th 2005
Called from SP_RPro_Export
This Stored Procedure is used to Export the Customers with Orders to RPro
Once the Staging tables has been populated with orders.
If the Customer has a RPRo_ Customer_SID we know it is an existing Customer
********************************************************************************/
--TRUNCATE TABLE RPRo_Out_Customers
INSERT INTO RPRo_Out_Customers(
Customer_ID
, RPRo_Cust_SID 
, First_Name 
, Last_Name
, Address1
, Address2
, City 
, State 
, Region 
, Zip 
, Country 
, Country_Code 
, Phone 
, Email 
, Login_ID
, Password
, Orders_num 
, has_so 
,Company
) SELECT DISTINCT 
	Customer_ID = c.CustomerID
	, RPRo_Cust_SID = ISNULL(C.RProSID,ISNULL(C.Email,' '))
	, First_Name = ISNULL(C.FirstName,' ')
	, Last_Name = ISNULL(C.LastName,' ')
	, Address1 = ISNULL(C.Address1,' ')
	, Address2 = ISNULL(C.Address2,' ')
	, City = ISNULL(C.City,' ')
	, State = ISNULL(C.State,' ')
	, Region = ISNULL(C.State,' ')
	, Zip = ISNULL(C.Zip,' ')
	, Country = ISNULL(C.Country,' ')
	, Country_Code = ' '
	, Phone = ISNULL(C.Phone,' ')
	, Email = ISNULL(C.Email,' ')
	, Login_ID = ISNULL(C.Email,' ')
	, Password = C.Password
	, Orders_num = 1
	, has_so = '0'
	,Company = C.CompanyName
FROM 
	Customers C
	JOIN RPro_Out_SO ROS ON  ROS.so_billto_cust_sid= C.CustomerID
-- Write to the log table
	INSERT RPro_Out_Customers_log (
		Customer_ID
		, RPro_Cust_SID
		, First_Name
		, Last_Name
		, Address1
		, Address2
		, City
		, State
		, Region
		, Zip
		, Country
		, Country_Code
		, Phone
		, Email
		, Login_ID
		, Password
		, Orders_num
		, has_so
		, Company
		, rdi_export_date
	) SELECT
		Customer_ID
		, RPro_Cust_SID
		, First_Name
		, Last_Name
		, Address1
		, Address2
		, City
		, State
		, Region
		, Zip
		, Country
		, Country_Code
		, Phone
		, Email
		, Login_ID
		, Password
		, Orders_num
		, has_so
		, Company
		, rdi_export_date = GETDATE()
	FROM
		RPro_Out_Customers (NOLOCK)
END
GO

--
-- Definition for stored procedure SP_RPro_Export_Orders : 
--

--
-- Definition for stored procedure SP_RPro_Export_Orders : 
--

--
-- Definition for stored procedure SP_RPro_Export_Orders : 
--

--	3/24/2005 a
--	ALTER TABLE Orders ADD Downloaded DATETIME
CREATE   PROC dbo.SP_RPro_Export_Orders
AS BEGIN
/****************************************************************************
			Written by Paul Duncan
			Retail Dimensions Inc
			www.retaildimensions.com
			January 20th 2005
Called from SP_RPro_Export
This Stored Procedure is used to Export the  Orders to RPro
We only want Orders that have a Status of 1
********************************************************************************/
-- Get any new orders that have a status of 1. (We will update the Status)
--This indicates they have been approved
INSERT INTO RPro_Out_SO(
  date_inserted 
 ,order_sid 
 ,so_number 
 ,date_ordered 
 ,so_billto_cust_sid 
 ,so_billto_rpro_cust_sid 
 ,so_billto_date_created
 ,so_billto_first_name 
 ,so_billto_last_name 
 ,so_billto_address1 
 ,so_billto_address2 
 ,so_billto_city 
 ,so_billto_state_or_province 
 ,so_billto_state_short 
 ,so_billto_country 
 ,so_billto_country_short 
 ,so_billto_postal_code 
 ,so_billto_phone1 
 ,so_billto_phone2 
 ,so_billto_email 
 ,so_billto_language 
 ,so_billto_price_level 
 ,so_shipto_cust_sid 
 ,so_shipto_rpro_cust_sid 
 ,so_shipto_date_created 
 ,so_shipto_title 
 ,so_shipto_first_name 
 ,so_shipto_last_name 
 ,so_shipto_address1 
 ,so_shipto_address2 
 ,so_shipto_city 
 ,so_shipto_state_or_province 
 ,so_shipto_state_short 
 ,so_shipto_country 
 ,so_shipto_country_short 
 ,so_shipto_postal_code 
 ,so_shipto_phone1 
 ,so_shipto_phone2 
 ,so_shipto_email 
 ,so_shipto_language 
 ,so_shipto_price_level 
 ,shipping_method 
 ,shipping_provider 
 ,cc_type 
 ,cc_name 
 ,cc_number 
 ,cc_expire 
 ,cc_expireformat 
 ,so_dateformat 
 ,so_ref 
 ,avs_code 
 ,disc_percent 
 ,ship_percent 
 ,disc_amount 
 ,ship_amount 
 ,total_tax 
-- ,subtotal_used 
 ,tax_area 
 ,instruction 
 ,gift_slip 
 ,status 
 ,items_in 
 ,SO_Origin 
 ,uid
 ) SELECT   DISTINCT 
 date_inserted = Getdate()
 ,order_sid = CAST(O.OrderID AS VARCHAR(10))
 ,so_number = CAST(O.OrderID AS VARCHAR(10))
 ,date_ordered = O.DateEntered
 ,so_billto_cust_sid = O.CustomerID --ISNULL(C.RProSID,' ')
 ,so_billto_rpro_cust_sid = ISNULL(C.RProSID,' ')
 ,so_billto_date_created = GETDATE()
 ,so_billto_first_name = C.FirstName
 ,so_billto_last_name = C.LastName
 ,so_billto_address1 = C.Address1
 ,so_billto_address2 = C.Address2
 ,so_billto_city = C.City
 ,so_billto_state_or_province = C.State 
 ,so_billto_state_short = C.State
 ,so_billto_country = C.Country
 ,so_billto_country_short = C.Country
 ,so_billto_postal_code = C.Zip
 ,so_billto_phone1 = C.Phone
 ,so_billto_phone2 = ISNULL(C.Fax,'')
 ,so_billto_email = C.Email
 ,so_billto_language = ' '
 ,so_billto_price_level = ' '
 ,so_shipto_cust_sid =  O.CustomerID --ISNULL(C.RProSID,' ')
 ,so_shipto_rpro_cust_sid = ISNULL(C.RProSID,' ')
 ,so_shipto_date_created = GETDATE()
 ,so_shipto_title = '' 
 ,so_shipto_first_name = O.OShipFirstName
 ,so_shipto_last_name = O.OShipLastName
 ,so_shipto_address1 = O.OShipAddress1
 ,so_shipto_address2 = O.OShipAddress2
 ,so_shipto_city = O.OShipCity
 ,so_shipto_state_or_province = O.OShipState
 ,so_shipto_state_short = O.OShipState
 ,so_shipto_country = O.OShipCountry
 ,so_shipto_country_short = O.OShipCountry
 ,so_shipto_postal_code = O.OShipZip
 ,so_shipto_phone1 = O.Phone
 ,so_shipto_phone2 = ''
 ,so_shipto_email = ''
 ,so_shipto_language = ''
 ,so_shipto_price_level = '' 
 ,shipping_method = '1' 
 ,shipping_provider = '1'
 ,cc_type = O.CCName
 ,cc_name = RTRIM(C.FirstName) +' ' + RTRIM(C.LastName)
 ,cc_number = 'XXXX'
 ,cc_expire = '' --OP.ExpireMonth +'/'+ OP.ExpireYear
 ,cc_expireformat = 'mm/yyyy'
 ,so_dateformat = 'dd/mm/yy'
 ,so_ref = O.OrderID
 ,avs_code = 'No AVS'
 ,disc_percent = 0 
 ,ship_percent = 0
 ,disc_amount = CAST(O.DiscountTotal AS NVARCHAR)
 ,ship_amount = CAST(O.ShippingTotal AS NVARCHAR)
 ,total_tax = CAST(O.TaxTotal AS NVARCHAR)
-- ,subtotal_used = O.GrandTotal 
 ,tax_area = ' '
 ,instruction = LEFT(ISNULL(CAST(O.Comments as varchar(250)),' ')+ SPACE(250),250)
 ,gift_slip = ' '
 ,status = ' '
 ,items_in = 1
 ,SO_Origin = 0
 ,uid = O.OrderID
FROM Orders O 
JOIN Customers C on  C.CustomerID = O.CustomerID
WHERE OrderStatus = 'OD'
--	Need to set the subtotal_used field
UPDATE
	RPro_Out_SO
SET
	subtotal_used = CAST((SELECT SUM(ISNULL(Qty, 0) * ISNULL(ItemPrice, 0)) FROM OrderItems WHERE OrderID = ROS.uid) AS NVARCHAR)
FROM
	RPro_Out_SO ROS
-- Now update the Status of these orders to 2 to indicate they are downloaded
UPDATE Orders
SET OrderStatus = 'PR'
,Downloaded = GETDATE()
FROM RPro_Out_SO ROO 
JOIN ORders O ON ROO.uid = o.OrderID
-- Get the line items for each order and write these to the RPRO_Out_SO_Items table
INSERT INTO RPRO_Out_SO_Items(
Order_SID 
,Item_SID 
,Item_no 
,ProductName
,Tax_code 
,Price  
,Orig_Price 
,Qty_Ordered 
,tax_amount 
,orig_tax_amount 
,tax_percent 
,uid
) SELECT 
Order_SID =  CAST(O.OrderID AS Varchar (10))
,Item_SID = ISNULL(PO.RProItem,P.SKU)
,Item_no = ISNULL(PO.RProItem,P.SKU)
,ProductName = P.ItemName
,Tax_code = P.Taxable
,Price  =  CAST(OI.ItemPrice AS NVARCHAR)
,Orig_Price = CAST(P.Price1 AS NVARCHAR)
,Qty_Ordered = CAST(OI.Qty AS NVARCHAR)
,tax_amount = 0
,orig_tax_amount = 0
,tax_percent = 0
,uid = O.OrderID
FROM 
	OrderItems OI
		JOIN Orders O ON OI.OrderID = O.OrderID
		JOIN Products P ON OI.ItemID = P.ItemID
		LEFT JOIN ProductOptions PO (NOLOCK) ON OI.ItemID = PO.ItemID AND OI.OptionName1 = PO.OptionName
		JOIN RPRO_Out_SO ROS ON ROS.uid = O.OrderID
-- End of Process
--	Write to the log table
	INSERT RPro_Out_SO_log (
		date_inserted
		, order_sid
		, so_number
		, date_ordered
		, so_billto_cust_sid
		, so_billto_rpro_cust_sid
		, so_billto_date_created
		, so_billto_first_name
		, so_billto_last_name
		, so_billto_address1
		, so_billto_address2
		, so_billto_city
		, so_billto_state_or_province
		, so_billto_state_short
		, so_billto_country
		, so_billto_country_short
		, so_billto_postal_code
		, so_billto_phone1
		, so_billto_phone2
		, so_billto_email
		, so_billto_language
		, so_billto_price_level
		, so_shipto_cust_sid
		, so_shipto_rpro_cust_sid
		, so_shipto_date_created
		, so_shipto_title
		, so_shipto_first_name
		, so_shipto_last_name
		, so_shipto_address1
		, so_shipto_address2
		, so_shipto_city
		, so_shipto_state_or_province
		, so_shipto_state_short
		, so_shipto_country
		, so_shipto_country_short
		, so_shipto_postal_code
		, so_shipto_phone1
		, so_shipto_phone2
		, so_shipto_email
		, so_shipto_language
		, so_shipto_price_level
		, shipping_method
		, shipping_provider
		, cc_type
		, cc_name
		, cc_number
		, cc_expire
		, cc_expireformat
		, so_dateformat
		, so_ref
		, avs_code
		, disc_percent
		, ship_percent
		, disc_amount
		, ship_amount
		, total_tax
		, subtotal_used
		, tax_area
		, instruction
		, gift_slip
		, status
		, items_in
		, SO_Origin
		, uid
		, rdi_export_date
	) SELECT
		date_inserted
		, order_sid
		, so_number
		, date_ordered
		, so_billto_cust_sid
		, so_billto_rpro_cust_sid
		, so_billto_date_created
		, so_billto_first_name
		, so_billto_last_name
		, so_billto_address1
		, so_billto_address2
		, so_billto_city
		, so_billto_state_or_province
		, so_billto_state_short
		, so_billto_country
		, so_billto_country_short
		, so_billto_postal_code
		, so_billto_phone1
		, so_billto_phone2
		, so_billto_email
		, so_billto_language
		, so_billto_price_level
		, so_shipto_cust_sid
		, so_shipto_rpro_cust_sid
		, so_shipto_date_created
		, so_shipto_title
		, so_shipto_first_name
		, so_shipto_last_name
		, so_shipto_address1
		, so_shipto_address2
		, so_shipto_city
		, so_shipto_state_or_province
		, so_shipto_state_short
		, so_shipto_country
		, so_shipto_country_short
		, so_shipto_postal_code
		, so_shipto_phone1
		, so_shipto_phone2
		, so_shipto_email
		, so_shipto_language
		, so_shipto_price_level
		, shipping_method
		, shipping_provider
		, cc_type
		, cc_name
		, cc_number
		, cc_expire
		, cc_expireformat
		, so_dateformat
		, so_ref
		, avs_code
		, disc_percent
		, ship_percent
		, disc_amount
		, ship_amount
		, total_tax
		, subtotal_used
		, tax_area
		, instruction
		, gift_slip
		, status
		, items_in
		, SO_Origin
		, uid
		, rdi_export_date = GETDATE()
	FROM
		RPro_Out_SO (NOLOCK)
	INSERT RPro_Out_SO_Items_log (
		Order_Sid
		, item_sid
		, item_no
		, ProductName
		, tax_code
		, price
		, orig_price
		, qty_ordered
		, tax_amount
		, orig_tax_amount
		, tax_percent
		, uid
		, rdi_export_date
	) SELECT
		Order_Sid
		, item_sid
		, item_no
		, ProductName
		, tax_code
		, price
		, orig_price
		, qty_ordered
		, tax_amount
		, orig_tax_amount
		, tax_percent
		, uid
		, rdi_export_date = GETDATE()
	FROM
		RPro_Out_SO_Items (NOLOCK)
END
GO

--
-- Definition for stored procedure SP_RPro_Load : 
--

--
-- Definition for stored procedure SP_RPro_Load : 
--

--
-- Definition for stored procedure SP_RPro_Load : 
--

--	2/22/2005 a
CREATE PROC dbo.SP_RPro_Load
AS
BEGIN
/****************************************************************************
			Written by Paul Duncan
			Retail Dimensions Inc
			www.retaildimensions.com
			January 25th 2005
Called from the RTI COMM object
This Stored Procedure is used to call the Stored Procedure to Load the data into the Website database
Developers can add calls to their own Stored Procs from within this SP
********************************************************************************
		L O A D    F R O M    R E T A I L   P R O  
********************************************************************************/
--Call the Catalog Load
EXEC SP_RPro_Load_Catalog
--Call the Style Load
EXEC SP_RPro_Load_Styles
--Call the Customer Load
EXEC SP_RPro_Load_Customers
--Call the Sales Order Load
EXEC SP_RPro_Load_SOStatus
--Select GETDATE()
-- End of Process
/********************************************************************************
Add additional code here for Custom Code
********************************************************************************/
END
GO

--
-- Definition for stored procedure SP_RPro_Load_Catalog : 
--

--
-- Definition for stored procedure SP_RPro_Load_Catalog : 
--

--
-- Definition for stored procedure SP_RPro_Load_Catalog : 
--

--	11/22/2005 a
--ALTER TABLE Categories Add  RProSID varchar(50) NULL
CREATE            PROC dbo.SP_RPro_Load_Catalog AS
BEGIN
/****************************************************************************
			Written by Paul Duncan
			Retail Dimensions Inc
			www.retaildimensions.com
			January 25th 2005
			
Called from SP_RPro_Load
This Stored Procedure is used to repopulate the Categories table
After an initial load from Retail Pro.
Only when the Catqalog changes will a file be loaded into RPro_In_Catalog
Therefore we will look to see if there have been any changes and update the Categories.
These Categories can be nested unlimited times, hence the cursor to loop through
We also need to update the ProductCategory table to maintain the relationships.
We set the isActive flaf to 0 for items that are no longer in the catalog.
********************************************************************************/
-- Decalre variables we will need
DECLARE @CatCount as int
DECLARE @TreeLevel as int
-- See if there are any records to process
SELECT @CatCount =  COUNT(*) FROM RPro_In_Catalog
IF @CatCount > 0
BEGIN
--If there are records in the RPro_In_Catalog table we will rebuild 
-- the Categories table and update the ProductCategory table accordingly
--	create the working table
CREATE TABLE #tmp_cat(
	CatID INT
	, SiteID		INT
	, CatName		VARCHAR(100)
	, CatSummary		VARCHAR(3000)
	, CatDescription	VARCHAR(4000)
	, CatImage		VARCHAR(100)
	, CatFeaturedID		VARCHAR(100)
	, Hide1			BIT
	, DisplayOrder		INT
	, ShowColumns		SMALLINT
	, SubCategoryOf		INT
	, RProSID		VARCHAR(50)
	, Parent_SID 		VARCHAR(50)
)		
--	fill the working table
INSERT INTO #tmp_cat(
	CatID
	, SiteID
	, CatName
	, CatSummary
	, CatDescription
	, CatImage
	, CatFeaturedID
	, Hide1
	, DisplayOrder
	, ShowColumns
	, SubCategoryOf
	, RProSID
	, Parent_SID
) SELECT  
	CatID = NULL
	, SiteID = 1
	, CatName = Caption
	, CatSummary = LongDesc
	, CatDescription = ShortDesc
	, CatImage = Picture
	, CatFeaturedID = Thumbnail
	, Hide1 = 0
	, DisplayOrder = OrderNo
	, ShowColumns = TreeLevel
	, SubCategoryOf = NULL
	, SID
	, Parent_SID = Parent_SID
FROM 
	RPro_In_Catalog (NOLOCK)
WHERE 
	Caption IS NOT NULL
	--AND RProSID = Parent_SID
ORDER BY 
	OrderNo
UPDATE
	Categories
SET
	Hide1 = 1
WHERE
	RProSID NOT IN (SELECT RProSID FROM #tmp_cat)
--	insert any new catagories which are not in categories but are in rpro_in_catalog.
INSERT Categories (
	SiteID
	, CatName
	, CatSummary
	, CatDescription
	, CatImage
	, CatFeaturedID
	, Hide1
	, DisplayOrder
	, ShowColumns
	, SubCategoryOf
	, RProSID
) SELECT
	SiteID
	, CatName
	, CatSummary
	, CatDescription
	, CatImage
	, CatFeaturedID
	, Hide1
	, DisplayOrder
	, ShowColumns
	, SubCategoryOf
	, RProSID
FROM
	#tmp_cat
WHERE
	RProSID NOT IN (SELECT RProSID FROM Categories (NOLOCK)WHERE RProSID IS NOT NULL)
--	set the uid field in the working table
UPDATE
	#tmp_cat
SET
	CatID = c.CatID
FROM
	#tmp_cat t
		JOIN Categories c (NOLOCK) ON t.RProSID = c.RProSID
--	set the parentid field in the working table
UPDATE
	#tmp_cat
SET
	SubCategoryOf = c.CatID
FROM
	#tmp_cat t
		JOIN Categories c (NOLOCK) ON t.parent_sid = c.RProSID
WHERE
	t.RProSID != t.parent_sid
--	update the categories table with the new data
UPDATE
	categories
SET
	Hide1 = t.Hide1
	, SubCategoryOf = t.SubCategoryOf
	, CatName = t.CatName
	, CatDescription = t.CatDescription
	, CatSummary = t.CatSummary
	, CatImage = t.CatImage
	, CatFeaturedID = t.CatFeaturedID
	, CatImageDir = 'products'
	, DisplayOrder = t.DisplayOrder
--	, ShowColumns = t.ShowColumns
	, rdi_date_removed = NULL
FROM
	categories
		JOIN #tmp_cat t ON categories.CatID = t.CatID
DROP TABLE #tmp_cat
-- 	ddolph - Remove/Hide categories which do not show up in the catalog
UPDATE
	categories
SET
	Hide1 = 1
	, rdi_date_removed = GETDATE()
	, DateUpdated = GETDATE()
FROM
	categories c (NOLOCK)
		LEFT JOIN RPro_In_Catalog r (NOLOCK) ON c.RProSID = r.SID
WHERE
	r.SID IS NULL
	AND rdi_date_removed IS NULL
DELETE
	categories
WHERE
	rdi_date_removed IS NOT NULL 
	AND DATEDIFF(dd, rdi_date_removed, GETDATE()) > 60
END
-- Paul D 10/24/05 Set the Display order of the products
	UPDATE Products
	SET DisplayOrder = Style_OrderNo
	FROM RPro_In_Catalog RIC 
	JOIN Products P ON RIC.Style_SID = P.RproSID
	WHERE Style_SID IS NOT NULL
	AND DisplayOrder <> Style_OrderNo
/**************************************************/
--		Write to the log table
/**************************************************/
	INSERT RPro_In_Catalog_log (
		Parent_SID
		, SID
		, Caption
		, ShortDesc
		, LongDesc
		, OrderNo
		, Picture
		, Thumbnail
		, TreeLevel
		, Style_SID
		, Style_OrderNo
		, Spotlight_SID
		, Spotlight_OrderNo
		, Upsell_SID
		, Upsell_OrderNo
		, rdi_import_date
	) SELECT
		Parent_SID
		, SID
		, Caption
		, ShortDesc
		, LongDesc
		, OrderNo
		, Picture
		, Thumbnail
		, TreeLevel
		, Style_SID
		, Style_OrderNo
		, Spotlight_SID
		, Spotlight_OrderNo
		, Upsell_SID
		, Upsell_OrderNo
		, rdi_import_date = GETDATE()
	FROM
		RPro_In_Catalog (NOLOCK)
END
GO

--
-- Definition for stored procedure SP_RPro_Load_Customers : 
--

--
-- Definition for stored procedure SP_RPro_Load_Customers : 
--

--
-- Definition for stored procedure SP_RPro_Load_Customers : 
--

--	10/5/2005 a
--	ALTER TABLE Customers ADD RProSID VARCHAR(50)
CREATE     PROC dbo.SP_RPro_Load_Customers AS
BEGIN
/****************************************************************************
			Written by Paul Duncan
			Retail Dimensions Inc
			www.retaildimensions.com
			January 25th 2005
Called from SP_RPro_Load
This Stored Procedure is used to repopulate the Customers tables
After an initial load from Retail Pro.
Only when the Customer is updated will a file be loaded into RPro_In_Customer
********************************************************************************/
	-- Update any existing customer records with the RProSID value.
	UPDATE
		Customers
	SET
		RProSID = fldCustSID
	FROM
		Customers C
			JOIN RPro_In_Customers RIC ON C.CustomerID = RIC.web_Cust_SID
	CREATE TABLE #tmp (
		CustomerID	INT IDENTITY
		, RProSID	VARCHAR(50)
	)
	INSERT INTO #tmp (
		RProSID
	) SELECT
		RProSID = ric.fldCustSID
	FROM 
		RPro_in_Customers RIC
			LEFT JOIN Customers C ON C.RProSID = RIC.fldCustSID
	WHERE 
		C.RProSID IS NULL
	DECLARE @max_id INT
	SELECT @max_id = ISNULL(MAX(CAST(CustomerID AS BIGINT)), 0) FROM Customers WHERE CAST(CustomerID AS BIGINT) < 1000000
	--Insert new Customers 
	INSERT INTO Customers (
		CustomerID
		, FirstName
		, LastName
		, Address1
		, Address2
		, City
		, State
		, Zip
		, Phone
		, Email
		, RProSID
	) SELECT 
		CustomerID = CAST((t.CustomerID + @max_id) AS VARCHAR)
		, FirstName = RIC.fldFName
		, LastName = RIC.fldLName
		, Address1 = RIC.fldAddr1
		, Address2 = RIC.fldAddr2
		, City = SUBSTRING(RIC.fldAddr3, 1, LEN(fldAddr3) -2)
		, State = RIGHT(RIC.fldAddr3, 2)
		, Zip = RIC.fldZIP
		, Phone = RIC.fldPhone1
		, Email = RIC.email
		, RProSID = RIC.fldCustSID
	FROM 
		RPro_in_Customers RIC
			JOIN #tmp t ON ric.fldCustSID = t.RProSID
			LEFT JOIN Customers C ON C.RProSID = RIC.fldCustSID
	WHERE 
		C.RProSID IS NULL
/********************************************/
--		Write to the log table
/********************************************/
	INSERT RPro_in_Customers_log (
		fldCustSID
		, fldFName
		, fldLName
		, fldAddr1
		, fldAddr2
		, fldAddr3
		, fldZIP
		, fldPhone1
		, fldCustID
		, web_cust_sid
		, email
		, fldPrcLvl
		, fldPrcLvl_i
		, rdi_import_date
	) SELECT
		fldCustSID
		, fldFName
		, fldLName
		, fldAddr1
		, fldAddr2
		, fldAddr3
		, fldZIP
		, fldPhone1
		, fldCustID
		, web_cust_sid
		, email
		, fldPrcLvl
		, fldPrcLvl_i
		, rdi_import_date = GETDATE()
	FROM
		RPro_in_Customers (NOLOCK)
END
GO

--
-- Definition for stored procedure SP_RPro_Load_Scales : 
--

--
-- Definition for stored procedure SP_RPro_Load_Scales : 
--

--
-- Definition for stored procedure SP_RPro_Load_Scales : 
--

CREATE         PROC dbo.SP_RPro_Load_Scales AS
BEGIN
/****************************************************************************
			Written by Paul Duncan
			Retail Dimensions Inc
			www.retaildimensions.com
			August 17th 2005
			
Called from SP_RPro_Load
This Stored Procedure is used to repopulate the RDI_Prefs_Scales table
/**********************************************/
 --		 Scale Preferences
/**********************************************/
********************************************************************************/
-- Decalre variables we will need
DECLARE @ScaleCount as int
-- See if there are any records to process
SELECT @ScaleCount =  COUNT(*) FROM rpro_in_prefs_Scales
IF @ScaleCount > 0
BEGIN
--If there are records in the rpro_in_prefs_Scales table we will rebuild 
-- the rdi_scales  table 
TRUNCATE TABLE RDI_Prefs_Scales
		INSERT RDI_Prefs_Scales (
			Scale_No
			, Scale_Name
			, ScaleItem_No
			, ScaleItem_Value
			, ScaleItem_Type
		) SELECT 
			Scale_No
			, Scale_Name
			, ScaleItem_No
			, ScaleItem_Value
			, ScaleItem_Type
		FROM 
			RPro_In_prefs_Scales (NOLOCK)
	END
END
GO

--
-- Definition for stored procedure SP_RPro_Load_SOStatus : 
--

--
-- Definition for stored procedure SP_RPro_Load_SOStatus : 
--

--
-- Definition for stored procedure SP_RPro_Load_SOStatus : 
--

--	3/24/2005 a
CREATE    PROC dbo.SP_RPro_Load_SOStatus AS
BEGIN
/****************************************************************************
			Written by Paul Duncan
			Retail Dimensions Inc
			www.retaildimensions.com
			January 25th 2005
Called from SP_RPro_Load
This Stored Procedure is used to Update the Sales Order table
Once the order has been fulfilled in Retail Pro we will receive an Update
We can set the flags on the Order as shipped.
1. Pending - to be exported to Retail Pro
2. Exported - Retail Pro is processing it
3. Shipped - Retail Pro has returned with updated SO status - OK to bill
4. Finalized - Billed and finalized
********************************************************************************/
	-- Set the status
	UPDATE 
		Orders
	SET 
		OrderStatus = 'SH'
		, TrackingNumber = ShipNumber
	FROM 
		Orders O
			JOIN RPRO_in_SO RIO on O.OrderID = RIO.SID
	WHERE 
		RIO.Status = 10
		AND ISNUMERIC(SID) = 1 
	-- This completes the load of the Sales Order Status
	-- Write to the log table
	INSERT RPro_in_SO_log (
		SO_Number
		, SID
		, Status
		, Total
		, CaptureFund
		, Item_Number
		, Item_SID
		, QtyShipped
		, ShipDate
		, ShipNumber
		, ShipDescript
		, ShipProvider
		, rdi_import_date
	) SELECT
		SO_Number
		, SID
		, Status
		, Total
		, CaptureFund
		, Item_Number
		, Item_SID
		, QtyShipped
		, ShipDate
		, ShipNumber
		, ShipDescript
		, ShipProvider
		, rdi_import_date = GETDATE()
	FROM
		RPro_in_SO (NOLOCK)
END
GO

