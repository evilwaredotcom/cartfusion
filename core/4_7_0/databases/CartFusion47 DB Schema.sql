/******************************************************
  Tables  Begin
******************************************************/
GO
----------------------------------------------------
-- dbo.AdminUsers
----------------------------------------------------
CREATE TABLE dbo.AdminUsers
(
UserID                              INT IDENTITY(1,1) NOT NULL,
UserName                            NVARCHAR(50),
Password                            NVARCHAR(100),
Roles                               NVARCHAR(50),
FirstName                           NVARCHAR(50),
LastName                            NVARCHAR(50),
CompanyName                         NVARCHAR(50),
Department                          NVARCHAR(50),
Address1                            NVARCHAR(50),
Address2                            NVARCHAR(50),
City                                NVARCHAR(50),
State                               NVARCHAR(50),
Zip                                 NVARCHAR(50),
Country                             NVARCHAR(50),
Phone                               NVARCHAR(50),
Fax                                 NVARCHAR(50),
Email                               NVARCHAR(50),
Comments                            TEXT,
Disabled                            BIT DEFAULT ((0)),
DateCreated                         SMALLDATETIME DEFAULT (getdate()),
DateUpdated                         SMALLDATETIME,
UpdatedBy                           NVARCHAR(50),
CONSTRAINT PK_AdminUsers_1 PRIMARY KEY CLUSTERED ( UserID )
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.AffiliateCommissions
----------------------------------------------------
CREATE TABLE dbo.AffiliateCommissions
(
CommID                              SMALLINT IDENTITY(1,1) NOT NULL,
LevelName                           NVARCHAR(50),
L1                                  SMALLMONEY DEFAULT ((0)),
L2                                  SMALLMONEY DEFAULT ((0)),
L3                                  SMALLMONEY DEFAULT ((0)),
CONSTRAINT PK_AffiliateCommissions PRIMARY KEY CLUSTERED ( CommID )
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.AffiliateHistory
----------------------------------------------------
CREATE TABLE dbo.AffiliateHistory
(
AHID                                INT IDENTITY(1,1) NOT NULL,
AFID                                INT,
L1                                  SMALLMONEY DEFAULT ((0)),
L2                                  SMALLMONEY DEFAULT ((0)),
L3                                  SMALLMONEY DEFAULT ((0)),
DateEntered                         SMALLDATETIME DEFAULT (getdate()),
CONSTRAINT PK_AffiliateHistory PRIMARY KEY CLUSTERED ( AHID )
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.AffiliateOrders
----------------------------------------------------
CREATE TABLE dbo.AffiliateOrders
(
AFOID                               INT IDENTITY(1,1) NOT NULL,
OrderID                             INT,
AFIDL1                              INT,
AFIDL2                              INT,
AFIDL3                              INT,
AFTotalL1                           SMALLMONEY,
AFTotalL2                           SMALLMONEY,
AFTotalL3                           SMALLMONEY,
AFPaidL1                            BIT,
AFPaidL2                            BIT,
AFPaidL3                            BIT,
CONSTRAINT PK_AffiliateOrders PRIMARY KEY CLUSTERED ( AFOID )
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.AffiliatePayments
----------------------------------------------------
CREATE TABLE dbo.AffiliatePayments
(
AFPID                               INT IDENTITY(1,1) NOT NULL,
AFID                                INT,
AFPDate                             SMALLDATETIME DEFAULT (getdate()),
AFPAmount                           SMALLMONEY DEFAULT ((0)),
AFPCheck                            SMALLINT,
AFPComments                         NTEXT,
CONSTRAINT PK_AffiliatePayments PRIMARY KEY CLUSTERED ( AFPID )
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.Affiliates
----------------------------------------------------
CREATE TABLE dbo.Affiliates
(
AFID                                INT IDENTITY(7000,7) NOT NULL,
AffiliateName                       NVARCHAR(200),
CompanyName                         NVARCHAR(100),
FirstName                           NVARCHAR(50),
LastName                            NVARCHAR(50),
Address1                            NVARCHAR(50),
Address2                            NVARCHAR(50),
City                                NVARCHAR(50),
State                               NVARCHAR(50),
Zip                                 NVARCHAR(50),
Country                             NVARCHAR(50),
Email                               NVARCHAR(50),
EmailOK                             BIT DEFAULT ((1)),
Phone                               NVARCHAR(50),
AltPhone                            NVARCHAR(50),
Fax                                 NVARCHAR(50),
WebSiteName                         NVARCHAR(50),
WebSiteURL                          NVARCHAR(100),
WebSiteCategory                     NVARCHAR(35),
OrdersAcceptedBy                    NVARCHAR(10),
ReferralRate                        SMALLMONEY,
CustomerDiscount                    SMALLMONEY DEFAULT ((0)),
Disabled                            BIT DEFAULT ((0)),
IPAddress                           NVARCHAR(50),
Password                            NVARCHAR(50),
Authenticated                       BIT DEFAULT ((0)),
Comments                            NTEXT,
TaxID                               NVARCHAR(50),
SubAffiliateOf                      INT,
CustomerID                          NVARCHAR(50),
MemberType                          SMALLINT DEFAULT ((1)),
PaymentFrequency                    SMALLINT DEFAULT ((1)),
EmailPayPal                         BIT DEFAULT ((0)),
DateInactive                        SMALLDATETIME,
AffiliateCode                       NVARCHAR(50),
Deleted                             BIT DEFAULT ((0)),
DateCreated                         SMALLDATETIME DEFAULT (getdate()),
DateUpdated                         SMALLDATETIME,
UpdatedBy                           NVARCHAR(50),
QB                                  NVARCHAR(50),
QB_LIMIT                            NVARCHAR(200),
QB_TERMS                            NVARCHAR(200),
QB_VTYPE                            NVARCHAR(200),
QB_1099                             NVARCHAR(200),
CONSTRAINT PK_affiliates PRIMARY KEY CLUSTERED ( AFID )
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.AuthorizeNet
----------------------------------------------------
CREATE TABLE dbo.AuthorizeNet
(
ID                                  SMALLINT IDENTITY(1,1) NOT NULL,
Login                               NVARCHAR(100),
Hash                                NVARCHAR(250),
CONSTRAINT PK_authorizenet PRIMARY KEY CLUSTERED ( ID )
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.AuthorizeNetTK
----------------------------------------------------
CREATE TABLE dbo.AuthorizeNetTK
(
ID                                  SMALLINT IDENTITY(1,1) NOT NULL,
TransKey                            NVARCHAR(250),
Password                            NVARCHAR(100),
CONSTRAINT PK_AuthorizeNetTK PRIMARY KEY CLUSTERED ( ID )
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.BackOrderItems
----------------------------------------------------
CREATE TABLE dbo.BackOrderItems
(
BOIID                               INT IDENTITY(1,1) NOT NULL,
BOID                                INT,
BOItemID                            INT,
BOQty                               INT,
BOItemPrice                         MONEY,
CONSTRAINT PK_BackOrderItems PRIMARY KEY CLUSTERED ( BOIID )
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.BackOrders
----------------------------------------------------
CREATE TABLE dbo.BackOrders
(
BOUniqueID                          INT IDENTITY(1,1) NOT NULL,
BOID                                INT,
BOOrderID                           INT,
BODateEntered                       SMALLDATETIME DEFAULT (getdate()),
BOTransID                           INT,
BOTotal                             MONEY,
BOCredit                            MONEY DEFAULT ((0)),
BODiscount                          MONEY DEFAULT ((0)),
CONSTRAINT PK_BackOrders PRIMARY KEY CLUSTERED ( BOUniqueID )
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.BillingStatusCodes
----------------------------------------------------
CREATE TABLE dbo.BillingStatusCodes
(
StatusCode                          NVARCHAR(50) NOT NULL,
StatusMessage                       NVARCHAR(20) NOT NULL
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.Cart
----------------------------------------------------
CREATE TABLE dbo.Cart
(
CartItemID                          INT IDENTITY(1,1) NOT NULL,
SiteID                              SMALLINT DEFAULT ((1)),
CustomerID                          NVARCHAR(20),
SessionID                           NVARCHAR(50),
ItemID                              INT,
Qty                                 INT,
OptionName1                         NVARCHAR(100),
OptionName2                         NVARCHAR(100),
OptionName3                         NVARCHAR(100),
OptionName4                         NVARCHAR(100),
OptionName5                         NVARCHAR(100),
OptionName6                         NVARCHAR(100),
OptionName7                         NVARCHAR(100),
OptionName8                         NVARCHAR(100),
OptionName9                         NVARCHAR(100),
OptionName10                        NVARCHAR(100),
AffiliateID                         NVARCHAR(10),
BackOrdered                         BIT DEFAULT ((0)),
ShippingID                          INT DEFAULT ((0)),
ShippingMethod                      NVARCHAR(100),
ShippingCodesAvailable              NVARCHAR(100),
ShippingCodesUsed                   NVARCHAR(100),
ShippingCodeAmount                  SMALLMONEY,
ShippingAmount                      SMALLMONEY,
HandlingAmount                      SMALLMONEY,
DateEntered                         SMALLDATETIME DEFAULT (getdate()),
CONSTRAINT PK_Cart PRIMARY KEY CLUSTERED ( CartItemID )
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.Categories
----------------------------------------------------
CREATE TABLE dbo.Categories
(
CatID                               INT IDENTITY(1,1) NOT NULL,
SiteID                              SMALLINT DEFAULT ((1)),
CatName                             NVARCHAR(100),
CatSummary                          NVARCHAR(2000),
CatDescription                      NVARCHAR(2000),
CatImage                            NVARCHAR(100),
CatImageDir                         NVARCHAR(100),
CatFeaturedID                       NVARCHAR(100),
CatFeaturedDir                      NVARCHAR(100),
CatBanner                           NVARCHAR(100),
CKeywords                           NVARCHAR(255),
CDescription                        NVARCHAR(255),
ShowColumns                         SMALLINT DEFAULT ((4)),
ShowRows                            SMALLINT DEFAULT ((4)),
DisplayPrefix                       NVARCHAR(100),
SortByLooks                         BIT,
DisplayOrder                        INT DEFAULT ((1)),
CategoryDisplayFormatID             INT,
AllowCategoryFiltering              BIT,
AllowManufacturerFiltering          BIT,
AllowProductTypeFiltering           BIT,
Published                           BIT,
Comments                            NVARCHAR(1000),
AvailableSections                   NVARCHAR(500),
SubCategoryOf                       SMALLINT,
Featured                            BIT DEFAULT ((0)),
RProSID                             VARCHAR(50),
rdi_date_removed                    DATETIME,
Hide1                               BIT DEFAULT ((0)),
Hide2                               BIT DEFAULT ((0)),
CatMetaTitle                        NVARCHAR(max),
CatMetaDescription                  NVARCHAR(max),
CatMetaKeywords                     NVARCHAR(max),
CatMetaKeyphrases                   NVARCHAR(max),
Deleted                             BIT DEFAULT ((0)),
DateCreated                         SMALLDATETIME DEFAULT (getdate()),
DateUpdated                         SMALLDATETIME,
UpdatedBy                           NVARCHAR(50),
CONSTRAINT PK_Categories PRIMARY KEY CLUSTERED ( CatID )
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.Config
----------------------------------------------------
CREATE TABLE dbo.Config
(
SiteID                              SMALLINT NOT NULL,
StoreName                           NVARCHAR(50),
StoreNameShort                      NVARCHAR(50),
CompanyName                         NVARCHAR(50),
CompanyAddress1                     NVARCHAR(50),
CompanyAddress2                     NVARCHAR(50),
CompanyCity                         NVARCHAR(50),
CompanyState                        NVARCHAR(2),
CompanyZip                          NVARCHAR(10),
CompanyCountry                      NVARCHAR(2),
CompanyPhone                        NVARCHAR(20),
CompanyAltPhone                     NVARCHAR(20),
CompanyFax                          NVARCHAR(20),
EmailInfo                           NVARCHAR(100),
EmailSales                          NVARCHAR(100),
EmailSupport                        NVARCHAR(100),
CompanyDescription                  NTEXT,
DateOfInception                     SMALLDATETIME,
DomainName                          NVARCHAR(200),
RootURL                             NVARCHAR(200),
EnableSSL                           BIT DEFAULT ((0)),
SSL_Path                            NVARCHAR(250),
ImagePathURL                        NVARCHAR(200),
IU_VirtualPathDIR                   NVARCHAR(250),
IU_URLDir                           NVARCHAR(250),
DocsDirectory                       NVARCHAR(200),
AppDirectory                        NVARCHAR(200),
MailServer                          NVARCHAR(200),
NotifyEmail                         NVARCHAR(200),
DBIsMySQL                           BIT DEFAULT ((0)),
HandlingFee                         FLOAT DEFAULT ((0)),
HandlingType                        SMALLINT DEFAULT ((1)),
BaseCountry                         NVARCHAR(2) DEFAULT (N'US'),
DefaultOriginZipcode                NVARCHAR(10),
BeginZiptoAccept                    NVARCHAR(10),
EndZiptoAccept                      NVARCHAR(10),
CheckZipCode                        BIT DEFAULT ((0)),
ShipBy                              SMALLINT,
UseFedEx                            BIT DEFAULT ((0)),
UseUPS                              BIT DEFAULT ((0)),
UseUSPS                             BIT DEFAULT ((0)),
DefaultShipRateDom                  FLOAT DEFAULT ((0)),
DefaultShipRateInt                  FLOAT DEFAULT ((0)),
DefaultShipRateOver                 FLOAT DEFAULT ((0)),
PaymentSystem                       SMALLINT DEFAULT ((1)),
RealtimePayments                    SMALLINT DEFAULT ((0)),
CurrencyName                        NVARCHAR(25),
AllowOrderForm                      BIT DEFAULT ((0)),
AllowStoreCredit                    BIT DEFAULT ((0)),
AllowECheck                         BIT DEFAULT ((0)),
AllowPayPal                         BIT DEFAULT ((0)),
AllowCreditCards                    BIT DEFAULT ((1)),
AcceptVISA                          BIT DEFAULT ((1)),
AcceptMC                            BIT DEFAULT ((1)),
AcceptAMEX                          BIT DEFAULT ((1)),
AcceptDISC                          BIT DEFAULT ((1)),
EmailInvoiceToCustomer              BIT DEFAULT ((1)),
EnableCustLogin                     BIT DEFAULT ((1)),
EnableMultiShip                     BIT DEFAULT ((1)),
EnableRelated                       BIT DEFAULT ((1)),
AllowAffiliates                     BIT DEFAULT ((0)),
AffiliateToCustomer                 BIT DEFAULT ((0)),
UseFlatTaxRate                      BIT DEFAULT ((0)),
FlatTaxRate                         FLOAT,
AddTaxToProdPrice                   BIT DEFAULT ((0)),
AcceptIntOrders                     BIT DEFAULT ((0)),
AcceptIntShipment                   BIT DEFAULT ((0)),
IntTaxCharge                        BIT DEFAULT ((1)),
DateUpdated                         SMALLDATETIME,
UpdatedBy                           NVARCHAR(50),
CFVersion                           NVARCHAR(50),
CryptKey                            NVARCHAR(50),
TaxID                               NVARCHAR(20),
UseBreadCrumbs                      BIT DEFAULT ((1)),
StatsURL                            NVARCHAR(500),
ShippingNotes                       NTEXT,
SaveCreditCard                      BIT DEFAULT ((0)),
ShowCreditCard                      BIT DEFAULT ((0)),
CONSTRAINT PK_Config PRIMARY KEY CLUSTERED ( SiteID )
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.Countries
----------------------------------------------------
CREATE TABLE dbo.Countries
(
Country                             NVARCHAR(50) NOT NULL,
CountryCode                         NVARCHAR(2) NOT NULL,
S_Rate                              MONEY
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.Currencies
----------------------------------------------------
CREATE TABLE dbo.Currencies
(
Locale                              NVARCHAR(50) NOT NULL,
CurrencyMessage                     NVARCHAR(50) NOT NULL
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.CustomerCC
----------------------------------------------------
CREATE TABLE dbo.CustomerCC
(
CustomerCCID                        INT IDENTITY(1,1) NOT NULL,
CustomerID                          NVARCHAR(10) NOT NULL,
CardOwner                           NVARCHAR(150) NOT NULL,
CardName                            NVARCHAR(50) NOT NULL,
CardNum                             NVARCHAR(50) NOT NULL,
ExpDate                             NVARCHAR(10) NOT NULL,
CONSTRAINT PK_CustomerCC PRIMARY KEY CLUSTERED ( CustomerCCID )
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.Customers
----------------------------------------------------
CREATE TABLE dbo.Customers
(
CustomerID                          NVARCHAR(20) NOT NULL,
CustomerName                        NVARCHAR(100),
FirstName                           NVARCHAR(50),
MiddleName                          NVARCHAR(50),
LastName                            NVARCHAR(50),
Address1                            NVARCHAR(50),
Address2                            NVARCHAR(50),
City                                NVARCHAR(50),
State                               NVARCHAR(50),
Zip                                 NVARCHAR(50),
Country                             NVARCHAR(50),
Phone                               NVARCHAR(50),
Phone2                              NVARCHAR(50),
Fax                                 NVARCHAR(50),
Email                               NVARCHAR(100),
CompanyName                         NVARCHAR(50),
CardName                            NVARCHAR(2),
CardNum                             NVARCHAR(50),
ExpDate                             NVARCHAR(20),
CardCVV                             NVARCHAR(4),
ShipFirstName                       NVARCHAR(50),
ShipLastName                        NVARCHAR(50),
ShipCompanyName                     NVARCHAR(50),
ShipAddress1                        NVARCHAR(50),
ShipAddress2                        NVARCHAR(50),
ShipCity                            NVARCHAR(50),
ShipState                           NVARCHAR(50),
ShipZip                             NVARCHAR(50),
ShipCountry                         NVARCHAR(50),
ShipPhone                           NVARCHAR(50),
ShipEmail                           NVARCHAR(100),
UserName                            NVARCHAR(100),
Password                            NVARCHAR(200),
PriceToUse                          SMALLINT DEFAULT ((0)),
EmailOK                             BIT DEFAULT ((1)),
Discount                            SMALLINT DEFAULT ((0)),
Credit                              MONEY DEFAULT ((0)),
Comments                            NTEXT,
IPAddress                           NVARCHAR(50),
AffiliateID                         INT,
RProSID                             VARCHAR(50),
PaymentTerms                        NVARCHAR(50),
CreditLimit                         MONEY,
AffiliateCode                       NVARCHAR(50),
EmailCompany                        NVARCHAR(100),
Website                             NVARCHAR(50),
EmailCompanyOK                      BIT,
Deleted                             BIT DEFAULT ((0)),
DateCreated                         SMALLDATETIME DEFAULT (getdate()),
DateUpdated                         SMALLDATETIME,
UpdatedBy                           NVARCHAR(20),
QB                                  NVARCHAR(50),
QB_CONT1                            NVARCHAR(200),
QB_CONT2                            NVARCHAR(200),
QB_CTYPE                            NVARCHAR(200),
QB_TAXABLE                          NVARCHAR(1),
QB_SALESTAXCODE                     NVARCHAR(200),
QB_RESALENUM                        NVARCHAR(200),
QB_REP                              NVARCHAR(200),
QB_TAXITEM                          NVARCHAR(200),
QB_JOBDESC                          NVARCHAR(200),
QB_JOBTYPE                          NVARCHAR(200),
QB_JOBSTATUS                        NVARCHAR(200),
QB_JOBSTART                         NVARCHAR(200),
QB_JOBPROJEND                       NVARCHAR(200),
QB_JOBEND                           NVARCHAR(200),
CONSTRAINT PK_Customers PRIMARY KEY CLUSTERED ( CustomerID )
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.CustomerSH
----------------------------------------------------
CREATE TABLE dbo.CustomerSH
(
SHID                                INT IDENTITY(1,1) NOT NULL,
CustomerID                          NVARCHAR(20),
ShipNickName                        NVARCHAR(50),
ShipFirstName                       NVARCHAR(50),
ShipLastName                        NVARCHAR(50),
ShipAddress1                        NVARCHAR(50),
ShipAddress2                        NVARCHAR(50),
ShipCity                            NVARCHAR(50),
ShipState                           NVARCHAR(3),
ShipZip                             NVARCHAR(10),
ShipCountry                         NVARCHAR(2),
ShipPhone                           NVARCHAR(25),
ShipCompanyName                     NVARCHAR(50),
ShipEmail                           NVARCHAR(100),
CONSTRAINT PK_CustomerSH PRIMARY KEY CLUSTERED ( SHID )
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.Days
----------------------------------------------------
CREATE TABLE dbo.Days
(
DayCode                             INT
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.Dictionary
----------------------------------------------------
CREATE TABLE dbo.Dictionary
(
DID                                 INT IDENTITY(1,1) NOT NULL,
Term                                NVARCHAR(50) NOT NULL,
Definition                          TEXT NOT NULL,
Keywords                            NVARCHAR(500),
CONSTRAINT PK_Dictionary PRIMARY KEY CLUSTERED ( DID )
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.Discounts
----------------------------------------------------
CREATE TABLE dbo.Discounts
(
DiscountID                          INT IDENTITY(1,1) NOT NULL,
SiteID                              SMALLINT DEFAULT ((1)),
DiscountCode                        NVARCHAR(20),
DiscountName                        NVARCHAR(50) DEFAULT ('Discount'),
DiscountDesc                        NVARCHAR(200),
DiscountValue                       SMALLMONEY DEFAULT ((0)),
DiscountType                        SMALLINT DEFAULT ((1)),
IsPercentage                        BIT DEFAULT ((0)),
AutoApply                           BIT DEFAULT ((0)),
AllowMultiple                       BIT DEFAULT ((1)),
DateValidFrom                       SMALLDATETIME DEFAULT (getdate()-(1)),
DateValidTo                         SMALLDATETIME DEFAULT (((12)/(31))/(2030)),
UsageLimitCust                      SMALLINT DEFAULT ((0)),
UsageLimitTotal                     SMALLINT DEFAULT ((0)),
OrderTotalLevel                     SMALLMONEY DEFAULT ((0)),
OverridesCat                        BIT DEFAULT ((0)),
OverridesSec                        BIT DEFAULT ((0)),
OverridesOrd                        BIT DEFAULT ((0)),
OverridesVol                        BIT DEFAULT ((0)),
ApplyToUser                         SMALLINT DEFAULT ((0)),
ApplyToType                         SMALLINT DEFAULT ((0)),
ApplyTo                             INT DEFAULT ((0)),
QtyLevel                            SMALLINT DEFAULT ((1)),
QtyLevelHi                          SMALLINT DEFAULT ((1)),
AddPurchaseReq                      SMALLINT DEFAULT ((0)),
AddPurchaseVal                      INT DEFAULT ((0)),
ExcludeSelection                    BIT DEFAULT ((0)),
Expired                             BIT DEFAULT ((0)),
DateCreated                         SMALLDATETIME DEFAULT (getdate()),
DateUpdated                         SMALLDATETIME,
UpdatedBy                           NVARCHAR(20),
CONSTRAINT PK_Discounts PRIMARY KEY CLUSTERED ( DiscountID )
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.DiscountUsage
----------------------------------------------------
CREATE TABLE dbo.DiscountUsage
(
DUID                                INT IDENTITY(1,1) NOT NULL,
CustomerID                          NVARCHAR(20) NOT NULL,
DiscountID                          INT NOT NULL,
CONSTRAINT PK_DiscountUsage PRIMARY KEY CLUSTERED ( DUID )
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.Distributors
----------------------------------------------------
CREATE TABLE dbo.Distributors
(
DistributorID                       SMALLINT IDENTITY(1,1) NOT NULL,
DistributorName                     NVARCHAR(200),
CompanyName                         NVARCHAR(200),
FirstName                           NVARCHAR(50),
LastName                            NVARCHAR(50),
Address1                            NVARCHAR(50),
Address2                            NVARCHAR(50),
City                                NVARCHAR(50),
State                               NVARCHAR(50),
Country                             NVARCHAR(50),
Zipcode                             NVARCHAR(50),
RepName                             NVARCHAR(50),
Email                               NVARCHAR(50),
Phone                               NVARCHAR(50),
AltPhone                            NVARCHAR(50),
Fax                                 NVARCHAR(50),
WebSiteURL                          NVARCHAR(500),
TaxID                               NVARCHAR(50),
POFormat                            NVARCHAR(50),
OrdersAcceptedBy                    NVARCHAR(50),
Comments                            NVARCHAR(4000),
DateCreated                         SMALLDATETIME DEFAULT (getdate()),
DateUpdated                         SMALLDATETIME,
UpdatedBy                           NVARCHAR(50),
Deleted                             BIT DEFAULT ((0)),
QB                                  NVARCHAR(50),
QB_LIMIT                            NVARCHAR(200),
QB_TERMS                            NVARCHAR(200),
QB_VTYPE                            NVARCHAR(200),
QB_1099                             NVARCHAR(200),
CONSTRAINT PK_Distributors PRIMARY KEY CLUSTERED ( DistributorID )
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.dtproperties
----------------------------------------------------
CREATE TABLE dbo.dtproperties
(
id                                  INT IDENTITY(1,1) NOT NULL,
objectid                            INT,
property                            VARCHAR(64) NOT NULL,
value                               VARCHAR(255),
uvalue                              NVARCHAR(255),
lvalue                              IMAGE,
version                             INT DEFAULT ((0)) NOT NULL,
CONSTRAINT pk_dtproperties PRIMARY KEY CLUSTERED ( id,property )
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.FormsOfPayment
----------------------------------------------------
CREATE TABLE dbo.FormsOfPayment
(
FOPID                               SMALLINT IDENTITY(1,1) NOT NULL,
FOPCode                             SMALLINT NOT NULL,
FOPMessage                          NVARCHAR(100) NOT NULL,
FOPDesc                             NVARCHAR(500),
CONSTRAINT PK_FormsOfPayment PRIMARY KEY CLUSTERED ( FOPID )
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.ItemClassComponents
----------------------------------------------------
CREATE TABLE dbo.ItemClassComponents
(
ICCID                               INT IDENTITY(1,1) NOT NULL,
ItemClassID                         INT,
ItemID                              INT,
Detail1                             NVARCHAR(30),
Detail2                             NVARCHAR(30),
Detail3                             NVARCHAR(30),
CompPrice                           SMALLMONEY DEFAULT ((0)),
CompQuantity                        INT,
CompStatus                          NVARCHAR(2),
CompSellByStock                     BIT,
Image                               NVARCHAR(100),
QB                                  NVARCHAR(50),
CONSTRAINT PK_ItemClassComponents PRIMARY KEY CLUSTERED ( ICCID )
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.ItemClasses
----------------------------------------------------
CREATE TABLE dbo.ItemClasses
(
ICID                                INT IDENTITY(1,1) NOT NULL,
Description                         NVARCHAR(30),
Dimensions                          SMALLINT DEFAULT ((0)),
Title1                              NVARCHAR(20),
Title2                              NVARCHAR(20),
Title3                              NVARCHAR(20),
ClassType                           SMALLINT,
ItemCode                            NVARCHAR(25),
CONSTRAINT PK_ItemClasses PRIMARY KEY CLUSTERED ( ICID )
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.ItemStatusCodes
----------------------------------------------------
CREATE TABLE dbo.ItemStatusCodes
(
StatusCode                          NVARCHAR(3) NOT NULL,
StatusMessage                       NVARCHAR(50) NOT NULL
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.Layout
----------------------------------------------------
CREATE TABLE dbo.Layout
(
LayoutID                            INT NOT NULL,
SiteID                              SMALLINT DEFAULT ((1)),
PrimaryFontFamily                   NVARCHAR(100),
PrimaryBGColor                      NVARCHAR(20),
PrimaryBGImage                      NVARCHAR(200),
PrimaryLinkColor                    NVARCHAR(20),
PrimaryALinkColor                   NVARCHAR(20),
PrimaryVLinkColor                   NVARCHAR(20),
PrimaryHLinkColor                   NVARCHAR(20),
PrimaryLinkDecor                    NVARCHAR(20),
PrimaryALinkDecor                   NVARCHAR(20),
PrimaryVLinkDecor                   NVARCHAR(20),
PrimaryHLinkDecor                   NVARCHAR(20),
ButtonSize                          SMALLINT,
ButtonColor                         NVARCHAR(20),
ButtonDecor                         NVARCHAR(20),
ButtonWeight                        NVARCHAR(20),
FormFieldSize                       SMALLINT,
FormFieldColor                      NVARCHAR(20),
FormFieldDecor                      NVARCHAR(20),
FormFieldWeight                     NVARCHAR(20),
FormLabelSize                       SMALLINT,
FormLabelColor                      NVARCHAR(20),
FormLabelDecor                      NVARCHAR(20),
FormLabelWeight                     NVARCHAR(20),
HeadingFontFamily                   NVARCHAR(100),
HeadingSize                         SMALLINT,
HeadingColor                        NVARCHAR(20),
HeadingDecor                        NVARCHAR(20),
HeadingWeight                       NVARCHAR(20),
HomeHeadingSize                     SMALLINT,
HomeHeadingColor                    NVARCHAR(20),
HomeHeadingDecor                    NVARCHAR(20),
HomeHeadingWeight                   NVARCHAR(20),
TableHeadingSize                    SMALLINT,
TableHeadingColor                   NVARCHAR(20),
TableHeadingDecor                   NVARCHAR(20),
TableHeadingBGColor                 NVARCHAR(20),
TableHeadingWeight                  NVARCHAR(20),
MessageSize                         SMALLINT,
MessageColor                        NVARCHAR(20),
MessageDecor                        NVARCHAR(20),
MessageWeight                       NVARCHAR(20),
ErrorMsgSize                        SMALLINT,
ErrorMsgColor                       NVARCHAR(20),
ErrorMsgDecor                       NVARCHAR(20),
ErrorMsgWeight                      NVARCHAR(20),
DefaultSize                         SMALLINT,
DefaultColor                        NVARCHAR(20),
DefaultDecor                        NVARCHAR(20),
DefaultWeight                       NVARCHAR(20),
PrimaryLinkWeight                   NVARCHAR(20),
PrimaryALinkWeight                  NVARCHAR(20),
PrimaryVLinkWeight                  NVARCHAR(20),
PrimaryHLinkWeight                  NVARCHAR(20),
MessageTwoSize                      SMALLINT,
MessageTwoColor                     NVARCHAR(20),
MessageTwoDecor                     NVARCHAR(20),
MessageTwoWeight                    NVARCHAR(20),
MessageThreeSize                    SMALLINT,
MessageThreeColor                   NVARCHAR(20),
MessageThreeDecor                   NVARCHAR(20),
MessageThreeWeight                  NVARCHAR(20),
AttractSize                         SMALLINT,
AttractColor                        NVARCHAR(20),
AttractDecor                        NVARCHAR(20),
AttractWeight                       NVARCHAR(20),
MiniSize                            SMALLINT,
MiniColor                           NVARCHAR(20),
MiniDecor                           NVARCHAR(20),
MiniWeight                          NVARCHAR(20),
HomeSize                            SMALLINT,
HomeColor                           NVARCHAR(20),
HomeDecor                           NVARCHAR(20),
HomeWeight                          NVARCHAR(20),
DateUpdated                         SMALLDATETIME,
UpdatedBy                           NVARCHAR(20),
CONSTRAINT PK_Layout PRIMARY KEY CLUSTERED ( LayoutID )
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.LayoutStyles
----------------------------------------------------
CREATE TABLE dbo.LayoutStyles
(
StyleName                           NVARCHAR(10) NOT NULL,
StyleValue                          NVARCHAR(20) NOT NULL
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.Manufacturers
----------------------------------------------------
CREATE TABLE dbo.Manufacturers
(
ManufacturerID                      INT IDENTITY(1,1) NOT NULL,
ManName                             NVARCHAR(100),
Address1                            NVARCHAR(100),
Address2                            NVARCHAR(100),
City                                NVARCHAR(100),
State                               NVARCHAR(2),
ZipCode                             NVARCHAR(10),
Country                             NVARCHAR(100),
Phone                               NVARCHAR(20),
FAX                                 NVARCHAR(20),
URL                                 NVARCHAR(255),
Email                               NVARCHAR(100),
Summary                             TEXT,
Description                         TEXT,
Notes                               NVARCHAR(255),
ManufacturerDisplayFormatID         INT,
ColWidth                            INT,
DisplayOrder                        INT,
Deleted                             BIT,
DateCreated                         SMALLDATETIME,
DateUpdated                         SMALLDATETIME,
UpdatedBy                           NVARCHAR(50),
CONSTRAINT PK_Manufacturers PRIMARY KEY CLUSTERED ( ManufacturerID )
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.MessageCenter
----------------------------------------------------
CREATE TABLE dbo.MessageCenter
(
MCID                                INT IDENTITY(1,1) NOT NULL,
Message                             NTEXT,
Customers                           NTEXT,
DateCreated                         SMALLDATETIME DEFAULT (getdate()),
ValidFrom                           SMALLDATETIME DEFAULT (getdate()),
ValidTo                             SMALLDATETIME,
CreatedBy                           NVARCHAR(50),
UpdatedBy                           NVARCHAR(50),
CONSTRAINT PK_MessageCenter PRIMARY KEY CLUSTERED ( MCID )
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.MessageCodes
----------------------------------------------------
CREATE TABLE dbo.MessageCodes
(
MCID                                SMALLINT IDENTITY(1,1) NOT NULL,
MessageCode                         NVARCHAR(20) NOT NULL,
CONSTRAINT PK_MessageCodes PRIMARY KEY CLUSTERED ( MCID )
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.Messages
----------------------------------------------------
CREATE TABLE dbo.Messages
(
MessageID                           INT IDENTITY(1,1) NOT NULL,
Message                             NVARCHAR(1000),
Urgency                             SMALLINT,
Done                                BIT DEFAULT ((0)),
DateCreated                         SMALLDATETIME DEFAULT (getdate()),
CreatedBy                           NVARCHAR(50),
DateUpdated                         SMALLDATETIME,
UpdatedBy                           NVARCHAR(50),
CONSTRAINT PK_Messages PRIMARY KEY CLUSTERED ( MessageID )
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.Months
----------------------------------------------------
CREATE TABLE dbo.Months
(
MonthCode                           INT,
MonthDisplay                        NVARCHAR(15)
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.OrderItems
----------------------------------------------------
CREATE TABLE dbo.OrderItems
(
OrderItemsID                        INT IDENTITY(1,1) NOT NULL,
OrderID                             INT,
Qty                                 INT,
ItemID                              INT,
ItemPrice                           SMALLMONEY,
DateEntered                         SMALLDATETIME DEFAULT (getdate()),
OptionName1                         NVARCHAR(100),
OptionName2                         NVARCHAR(100),
OptionName3                         NVARCHAR(100),
Deleted                             BIT DEFAULT ((0)),
StatusCode                          NVARCHAR(2),
DateUpdated                         SMALLDATETIME,
UpdatedBy                           NVARCHAR(50),
OITrackingNumber                    NVARCHAR(50),
ShippingID                          INT DEFAULT ((0)),
orderitems_FirstName                NVARCHAR(50),
orderitems_LastName                 NVARCHAR(50),
orderitems_CompanyName              NVARCHAR(50),
orderitems_Address1                 NVARCHAR(50),
orderitems_Address2                 NVARCHAR(50),
orderitems_City                     NVARCHAR(50),
orderitems_State                    NVARCHAR(50),
orderitems_Zip                      NVARCHAR(50),
orderitems_Country                  NVARCHAR(50),
orderitems_Phone                    NVARCHAR(50),
orderitems_Email                    NVARCHAR(100),
orderitems_ShipMethod               NVARCHAR(50),
CONSTRAINT PK_OrderItems PRIMARY KEY CLUSTERED ( OrderItemsID )
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.OrderItemsStatusCodes
----------------------------------------------------
CREATE TABLE dbo.OrderItemsStatusCodes
(
StatusCode                          NVARCHAR(3) NOT NULL,
StatusMessage                       NVARCHAR(50) NOT NULL
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.OrderReturnItems
----------------------------------------------------
CREATE TABLE dbo.OrderReturnItems
(
ORIID                               INT IDENTITY(1,1) NOT NULL,
OrderReturnID                       INT,
OrderReturnItemID                   INT,
QtyReturned                         INT,
CONSTRAINT PK_OrderReturnItems PRIMARY KEY CLUSTERED ( ORIID )
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.OrderReturns
----------------------------------------------------
CREATE TABLE dbo.OrderReturns
(
OrderReturnID                       INT IDENTITY(1,1) NOT NULL,
OrderID                             INT,
RMA                                 INT,
RMADate                             SMALLDATETIME DEFAULT (getdate()),
DateReceived                        SMALLDATETIME,
ReceivedTo                          NVARCHAR(50),
RMAComplete                         BIT DEFAULT ((0)),
CreatedBy                           NVARCHAR(50),
ChargeReturnTo                      NVARCHAR(50),
TaxReturned                         SMALLMONEY DEFAULT ((0)),
ShippingReturned                    SMALLMONEY DEFAULT ((0)),
CONSTRAINT PK_OrderReturns PRIMARY KEY CLUSTERED ( OrderReturnID )
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.Orders
----------------------------------------------------
CREATE TABLE dbo.Orders
(
OrderID                             INT NOT NULL,
DateEntered                         SMALLDATETIME DEFAULT (getdate()),
SiteID                              SMALLINT DEFAULT ((1)),
CustomerID                          NVARCHAR(50),
IPAddress                           NVARCHAR(50),
CCName                              NVARCHAR(2),
CCNum                               NVARCHAR(60),
CCExpDate                           NVARCHAR(21),
CCCVV                               NVARCHAR(4),
PaymentVerified                     BIT DEFAULT ((0)),
ShippingMethod                      NVARCHAR(50),
TrackingNumber                      NVARCHAR(50),
AffiliateID                         INT,
AffiliatePaid                       BIT DEFAULT ((0)),
AffiliateTotal                      SMALLMONEY DEFAULT ((0)),
orders_FirstName                    NVARCHAR(50),
orders_LastName                     NVARCHAR(50),
orders_CompanyName                  NVARCHAR(50),
orders_Address1                     NVARCHAR(50),
orders_Address2                     NVARCHAR(50),
orders_City                         NVARCHAR(50),
orders_State                        NVARCHAR(50),
orders_Zip                          NVARCHAR(50),
orders_Country                      NVARCHAR(50),
orders_Phone                        NVARCHAR(50),
orders_Email                        NVARCHAR(100),
Phone                               NVARCHAR(50),
ShipToMultiple                      BIT DEFAULT ((0)),
oShipFirstName                      NVARCHAR(50),
oShipLastName                       NVARCHAR(50),
oShipCompanyName                    NVARCHAR(50),
oShipAddress1                       NVARCHAR(50),
oShipAddress2                       NVARCHAR(50),
oShipCity                           NVARCHAR(50),
oShipState                          NVARCHAR(50),
oShipZip                            NVARCHAR(50),
oShipCountry                        NVARCHAR(50),
oShipPhone                          NVARCHAR(50),
oShipEmail                          NVARCHAR(100),
ShipDate                            SMALLDATETIME,
BillingStatus                       NVARCHAR(2),
OrderStatus                         NVARCHAR(2),
CustomerComments                    NTEXT,
Comments                            NTEXT,
ShippingTotal                       SMALLMONEY DEFAULT ((0)),
TaxTotal                            SMALLMONEY DEFAULT ((0)),
DiscountTotal                       SMALLMONEY DEFAULT ((0)),
DiscountUsed                        INT,
CreditApplied                       SMALLMONEY DEFAULT ((0)),
TransactionID                       NVARCHAR(100),
FormOfPayment                       SMALLINT,
Downloaded                          DATETIME,
Terms                               NVARCHAR(50),
Reference                           NVARCHAR(50),
DateInvoiced                        SMALLDATETIME DEFAULT (getdate()),
DatePaid                            SMALLDATETIME,
DateUpdated                         SMALLDATETIME,
UpdatedBy                           NVARCHAR(50),
Deleted                             BIT DEFAULT ((0)),
CONSTRAINT PK_Orders PRIMARY KEY CLUSTERED ( OrderID )
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.OrderStatusCodes
----------------------------------------------------
CREATE TABLE dbo.OrderStatusCodes
(
StatusCode                          NVARCHAR(3) NOT NULL,
StatusMessage                       NVARCHAR(50) NOT NULL
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.PayFlowLink
----------------------------------------------------
CREATE TABLE dbo.PayFlowLink
(
ID                                  SMALLINT IDENTITY(1,1) NOT NULL,
Login                               NVARCHAR(100) NOT NULL,
Partner                             NVARCHAR(100) NOT NULL,
CONSTRAINT PK_PayFlowLink PRIMARY KEY CLUSTERED ( ID )
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.Payment
----------------------------------------------------
CREATE TABLE dbo.Payment
(
Type                                NVARCHAR(2),
Display                             NVARCHAR(50),
Allow                               BIT DEFAULT ((1))
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.PaymentSystems
----------------------------------------------------
CREATE TABLE dbo.PaymentSystems
(
PSID                                SMALLINT IDENTITY(1,1) NOT NULL,
PaymentSystemCode                   NVARCHAR(2),
PaymentSystemMessage                NVARCHAR(50),
PSLogo                              NVARCHAR(100),
DisplayOrder                        SMALLINT DEFAULT ((1)),
CONSTRAINT PK_PaymentSystems PRIMARY KEY CLUSTERED ( PSID )
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.PGPayPal
----------------------------------------------------
CREATE TABLE dbo.PGPayPal
(
PPID                                SMALLINT IDENTITY(1,1) NOT NULL,
PayPalAccount                       NVARCHAR(100) NOT NULL,
PayPalLogo                          NVARCHAR(250),
IDToken                             NVARCHAR(100),
CONSTRAINT PK_PGPayPal PRIMARY KEY CLUSTERED ( PPID )
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.PGYourPayAPI
----------------------------------------------------
CREATE TABLE dbo.PGYourPayAPI
(
ID                                  SMALLINT IDENTITY(1,1) NOT NULL,
StoreNumber                         NVARCHAR(50) NOT NULL,
PEMFileLocation                     NVARCHAR(500) NOT NULL,
LiveMode                            BIT DEFAULT ((0)) NOT NULL,
InUse                               BIT DEFAULT ((0)) NOT NULL,
CONSTRAINT PK_PGYourPayAPI PRIMARY KEY CLUSTERED ( ID )
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.ProductOptions
----------------------------------------------------
CREATE TABLE dbo.ProductOptions
(
ItemAltID                           INT IDENTITY(1,1) NOT NULL,
ItemID                              INT,
OptionName                          NVARCHAR(100),
OptionColumn                        SMALLINT,
OptionPrice                         SMALLMONEY DEFAULT ((0)),
StockQuantity                       INT,
ItemStatus                          NVARCHAR(2),
OptionSellByStock                   BIT DEFAULT ((0)),
Hide                                BIT,
Comments                            NVARCHAR(1000),
DateCreated                         SMALLDATETIME,
DateUpdated                         SMALLDATETIME,
UpdatedBy                           NVARCHAR(50),
ImageProduct                        NVARCHAR(100),
ImageColor                          NVARCHAR(100),
RProItem                            VARCHAR(50),
RProSID                             VARCHAR(50),
rdi_date_removed                    DATETIME,
Item_fldShipAmount                  SMALLMONEY DEFAULT ((0)),
Item_fldShipWeight                  SMALLMONEY DEFAULT ((0)),
Item_fldHandAmount                  SMALLMONEY DEFAULT ((0)),
Item_fldOversize                    BIT DEFAULT ((0)),
Item_fldShipByWeight                BIT DEFAULT ((1)),
CONSTRAINT PK_ProductOptions PRIMARY KEY CLUSTERED ( ItemAltID )
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.ProductReviews
----------------------------------------------------
CREATE TABLE dbo.ProductReviews
(
PRID                                INT IDENTITY(1,1) NOT NULL,
ItemID                              INT,
Review                              TEXT,
Rating                              SMALLINT DEFAULT ((0)),
DateCreated                         SMALLDATETIME DEFAULT (getdate()),
CONSTRAINT PK_UserReviews PRIMARY KEY CLUSTERED ( PRID )
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.Products
----------------------------------------------------
CREATE TABLE dbo.Products
(
ItemID                              INT IDENTITY(1,1) NOT NULL,
SiteID                              SMALLINT DEFAULT ((1)),
SKU                                 NVARCHAR(50),
ManufacturerID                      NVARCHAR(50),
ItemName                            NVARCHAR(100),
ItemDescription                     NTEXT,
ItemDetails                         NTEXT,
ShortDescription                    NVARCHAR(500),
Comments                            NVARCHAR(1000),
Category                            INT DEFAULT ((0)),
OtherCategories                     NVARCHAR(100),
SectionID                           INT DEFAULT ((0)),
OtherSections                       NVARCHAR(100),
CompareType                         SMALLINT DEFAULT ((0)),
ImageDir                            NVARCHAR(100),
Image                               NVARCHAR(100) DEFAULT (N'products'),
ImageSmall                          NVARCHAR(100),
ImageLarge                          NVARCHAR(100),
ImageAlt                            NVARCHAR(100),
ImageAltLarge                       NVARCHAR(100),
Attribute1                          NVARCHAR(100),
Attribute2                          NVARCHAR(100),
Attribute3                          NVARCHAR(100),
OptionName1                         NVARCHAR(100),
OptionName2                         NVARCHAR(100),
OptionName3                         NVARCHAR(100),
OptionName4                         NVARCHAR(100),
OptionName5                         NVARCHAR(100),
OptionName6                         NVARCHAR(100),
OptionName7                         NVARCHAR(100),
OptionName8                         NVARCHAR(100),
OptionName9                         NVARCHAR(100),
OptionName10                        NVARCHAR(100),
Option1Optional                     BIT DEFAULT ((0)),
Option2Optional                     BIT DEFAULT ((0)),
Option3Optional                     BIT DEFAULT ((0)),
Option4Optional                     BIT DEFAULT ((0)),
Option5Optional                     BIT DEFAULT ((0)),
Option6Optional                     BIT DEFAULT ((0)),
Option7Optional                     BIT DEFAULT ((0)),
Option8Optional                     BIT DEFAULT ((0)),
Option9Optional                     BIT DEFAULT ((0)),
Option10Optional                    BIT DEFAULT ((0)),
Weight                              FLOAT DEFAULT ((1)),
DimLength                           FLOAT DEFAULT ((1)),
DimWidth                            FLOAT DEFAULT ((1)),
DimHeighth                          FLOAT DEFAULT ((1)),
CostPrice                           MONEY DEFAULT ((0)),
ListPrice                           MONEY DEFAULT ((0)),
SalePrice                           MONEY DEFAULT ((0)),
Price1                              MONEY DEFAULT ((0)),
Price2                              MONEY DEFAULT ((0)),
Hide1                               BIT DEFAULT ((0)),
Hide2                               BIT DEFAULT ((0)),
Taxable                             BIT DEFAULT ((1)),
StockQuantity                       INT,
SellByStock                         BIT DEFAULT ((0)),
ItemStatus                          NVARCHAR(2),
DisplayOrder                        INT DEFAULT ((1)),
Featured                            BIT DEFAULT ((0)),
SoftwareDownload                    BIT,
SoftwareAttachment                  BIT,
DaysAvailable                       SMALLINT,
DownloadLocation                    NVARCHAR(500),
DistributorID                       NVARCHAR(8),
ItemClassID                         INT,
UseMatrix                           BIT DEFAULT ((0)),
RProSID                             VARCHAR(50),
rdi_date_removed                    DATETIME,
fldShipByWeight                     BIT DEFAULT ((1)),
fldShipWeight                       FLOAT DEFAULT ((0)),
fldShipAmount                       SMALLMONEY DEFAULT ((0)),
fldHandAmount                       SMALLMONEY DEFAULT ((0)),
fldOversize                         BIT DEFAULT ((0)),
fldShipCode                         NVARCHAR(50),
Deleted                             BIT DEFAULT ((0)),
DateCreated                         SMALLDATETIME DEFAULT (getdate()),
DateUpdated                         SMALLDATETIME DEFAULT (getdate()),
UpdatedBy                           NVARCHAR(50),
Volume                              MONEY DEFAULT ((0)),
QB                                  NVARCHAR(50),
QB_ACCNT                            NVARCHAR(200),
QB_ASSETACCNT                       NVARCHAR(200),
QB_COGSACCNT                        NVARCHAR(200),
QB_SALESTAXCODE                     NVARCHAR(200),
QB_PREFVEND                         NVARCHAR(200),
QB_SUBITEM                          NVARCHAR(200),
QB_REORDERPOINT                     INT,
QB_PAYMETH                          NVARCHAR(200),
QB_TAXVEND                          NVARCHAR(200),
CONSTRAINT PK_Products PRIMARY KEY CLUSTERED ( ItemID )
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.ProductSpecs
----------------------------------------------------
CREATE TABLE dbo.ProductSpecs
(
SpecID                              INT IDENTITY(1,1) NOT NULL,
ItemID                              INT,
ProductType                         INT,
Spec1                               NVARCHAR(250),
Spec2                               NVARCHAR(250),
Spec3                               NVARCHAR(250),
Spec4                               NVARCHAR(250),
Spec5                               NVARCHAR(250),
Spec6                               NVARCHAR(250),
Spec7                               NVARCHAR(250),
Spec8                               NVARCHAR(250),
Spec9                               NVARCHAR(250),
Spec10                              NVARCHAR(250),
Spec11                              NVARCHAR(250),
Spec12                              NVARCHAR(250),
Spec13                              NVARCHAR(250),
Spec14                              NVARCHAR(250),
Spec15                              NVARCHAR(250),
Spec16                              NVARCHAR(250),
Spec17                              NVARCHAR(250),
Spec18                              NVARCHAR(250),
Spec19                              NVARCHAR(250),
Spec20                              NVARCHAR(250),
CONSTRAINT PK_ProductSpecs PRIMARY KEY CLUSTERED ( SpecID )
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.ProductTypes
----------------------------------------------------
CREATE TABLE dbo.ProductTypes
(
TypeID                              INT IDENTITY(1,1) NOT NULL,
TypeName                            NVARCHAR(100),
SpecCount                           SMALLINT DEFAULT ((0)),
SpecTitle1                          NVARCHAR(100),
SpecTitle2                          NVARCHAR(100),
SpecTitle3                          NVARCHAR(100),
SpecTitle4                          NVARCHAR(100),
SpecTitle5                          NVARCHAR(100),
SpecTitle6                          NVARCHAR(100),
SpecTitle7                          NVARCHAR(100),
SpecTitle8                          NVARCHAR(100),
SpecTitle9                          NVARCHAR(100),
SpecTitle10                         NVARCHAR(100),
SpecTitle11                         NVARCHAR(100),
SpecTitle12                         NVARCHAR(100),
SpecTitle13                         NVARCHAR(100),
SpecTitle14                         NVARCHAR(100),
SpecTitle15                         NVARCHAR(100),
SpecTitle16                         NVARCHAR(100),
SpecTitle17                         NVARCHAR(100),
SpecTitle18                         NVARCHAR(100),
SpecTitle19                         NVARCHAR(100),
SpecTitle20                         NVARCHAR(100),
CONSTRAINT PK_ProductTypes PRIMARY KEY CLUSTERED ( TypeID )
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.RDI_Items
----------------------------------------------------
CREATE TABLE dbo.RDI_Items
(
StyleSID                            VARCHAR(50),
ItemSID                             VARCHAR(50),
ItemNum                             VARCHAR(50),
ItemAttr                            VARCHAR(100),
ItemSize                            VARCHAR(100),
ItemID                              INT,
ItemAltID_attr                      INT,
ItemAltID_size                      INT
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.RDI_Prefs_Scales
----------------------------------------------------
CREATE TABLE dbo.RDI_Prefs_Scales
(
Scale_No                            VARCHAR(50),
Scale_Name                          VARCHAR(50),
ScaleItem_No                        VARCHAR(50),
ScaleItem_Value                     VARCHAR(50),
ScaleItem_Type                      VARCHAR(50)
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.RelatedItems
----------------------------------------------------
CREATE TABLE dbo.RelatedItems
(
RelatedID                           INT IDENTITY(1,1) NOT NULL,
ItemID                              INT NOT NULL,
RelatedItemID                       INT NOT NULL,
RelatedType                         NVARCHAR(20),
DateCreated                         SMALLDATETIME DEFAULT (getdate()),
DateUpdated                         SMALLDATETIME,
UpdatedBy                           NVARCHAR(50),
CONSTRAINT PK_RelatedItems PRIMARY KEY CLUSTERED ( RelatedID )
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.Roles
----------------------------------------------------
CREATE TABLE dbo.Roles
(
RID                                 INT IDENTITY(1,1) NOT NULL,
Role                                NVARCHAR(20) NOT NULL,
CONSTRAINT PK_Roles PRIMARY KEY CLUSTERED ( RID )
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.RPro_In_Catalog
----------------------------------------------------
CREATE TABLE dbo.RPro_In_Catalog
(
Parent_SID                          VARCHAR(50),
SID                                 VARCHAR(50),
Caption                             VARCHAR(50),
ShortDesc                           VARCHAR(255),
LongDesc                            VARCHAR(4000),
OrderNo                             INT,
Picture                             VARCHAR(50),
Thumbnail                           VARCHAR(50),
TreeLevel                           INT,
Style_SID                           VARCHAR(50),
Style_OrderNo                       INT,
Spotlight_SID                       VARCHAR(50),
Spotlight_OrderNo                   INT,
Upsell_SID                          VARCHAR(50),
Upsell_OrderNo                      INT
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.RPro_In_Catalog_log
----------------------------------------------------
CREATE TABLE dbo.RPro_In_Catalog_log
(
Parent_SID                          VARCHAR(50),
SID                                 VARCHAR(50),
Caption                             VARCHAR(50),
ShortDesc                           VARCHAR(255),
LongDesc                            VARCHAR(4000),
OrderNo                             INT,
Picture                             VARCHAR(50),
Thumbnail                           VARCHAR(50),
TreeLevel                           INT,
Style_SID                           VARCHAR(50),
Style_OrderNo                       INT,
Spotlight_SID                       VARCHAR(50),
Spotlight_OrderNo                   INT,
Upsell_SID                          VARCHAR(50),
Upsell_OrderNo                      INT,
rdi_import_date                     DATETIME NOT NULL
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.RPro_In_Customers
----------------------------------------------------
CREATE TABLE dbo.RPro_In_Customers
(
fldCustSID                          VARCHAR(50),
fldFName                            VARCHAR(50),
fldLName                            VARCHAR(50),
fldAddr1                            VARCHAR(50),
fldAddr2                            VARCHAR(50),
fldAddr3                            VARCHAR(50),
fldZIP                              VARCHAR(50),
fldPhone1                           VARCHAR(50),
fldCustID                           VARCHAR(50),
web_cust_sid                        VARCHAR(50),
email                               VARCHAR(100),
fldPrcLvl                           VARCHAR(50),
fldPrcLvl_i                         VARCHAR(50)
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.RPro_in_Customers_log
----------------------------------------------------
CREATE TABLE dbo.RPro_in_Customers_log
(
fldCustSID                          VARCHAR(50),
fldFName                            VARCHAR(50),
fldLName                            VARCHAR(50),
fldAddr1                            VARCHAR(50),
fldAddr2                            VARCHAR(50),
fldAddr3                            VARCHAR(50),
fldZIP                              VARCHAR(50),
fldPhone1                           VARCHAR(50),
fldCustID                           VARCHAR(50),
web_cust_sid                        VARCHAR(50),
email                               VARCHAR(100),
fldPrcLvl                           VARCHAR(50),
fldPrcLvl_i                         VARCHAR(50),
rdi_import_date                     DATETIME NOT NULL
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.rpro_in_prefs
----------------------------------------------------
CREATE TABLE dbo.rpro_in_prefs
(
ShippingParams_ShippingTypeIndex    VARCHAR(50),
ShippingParams_ShippingCalcIndex    VARCHAR(50),
ShippingParams_HandlingAmount       VARCHAR(50),
OnlineCCProcess_ProcessMethod       VARCHAR(50)
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.rpro_in_prefs_DefPriceLevels
----------------------------------------------------
CREATE TABLE dbo.rpro_in_prefs_DefPriceLevels
(
Level                               VARCHAR(50),
Type                                VARCHAR(50)
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.rpro_in_prefs_InStockMessages
----------------------------------------------------
CREATE TABLE dbo.rpro_in_prefs_InStockMessages
(
Msg_No                              VARCHAR(50),
Msg_Text                            VARCHAR(255)
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.rpro_in_prefs_InvenPreferences
----------------------------------------------------
CREATE TABLE dbo.rpro_in_prefs_InvenPreferences
(
DisplayItem_Name                    VARCHAR(50),
DisplayItem_Code                    VARCHAR(50),
DisplayItem_Default                 VARCHAR(50),
AvailableThreshold_Name             VARCHAR(50),
AvailableThreshold_Code             VARCHAR(50),
AvailableThreshold_Default          VARCHAR(50),
AvailableAtStore_Name               VARCHAR(50),
AvailableAtStore_Code               VARCHAR(50),
AvailableAtStore_Default            VARCHAR(50)
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.rpro_in_prefs_OrderStatuses
----------------------------------------------------
CREATE TABLE dbo.rpro_in_prefs_OrderStatuses
(
Item_No                             VARCHAR(50),
Action                              VARCHAR(50),
Descript                            VARCHAR(50)
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.rpro_in_prefs_OutOfStockMessages
----------------------------------------------------
CREATE TABLE dbo.rpro_in_prefs_OutOfStockMessages
(
Msg_No                              VARCHAR(50),
Msg_Text                            VARCHAR(50)
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.rpro_in_prefs_ProdAvailability
----------------------------------------------------
CREATE TABLE dbo.rpro_in_prefs_ProdAvailability
(
Item_No                             VARCHAR(50),
Item_Default                        VARCHAR(50),
Value                               VARCHAR(50)
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.rpro_in_prefs_QtySource
----------------------------------------------------
CREATE TABLE dbo.rpro_in_prefs_QtySource
(
Item_No                             VARCHAR(50),
Item_Default                        VARCHAR(50),
Value                               VARCHAR(50)
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.rpro_in_prefs_Scales
----------------------------------------------------
CREATE TABLE dbo.rpro_in_prefs_Scales
(
Scale_No                            VARCHAR(50),
Scale_Name                          VARCHAR(50),
ScaleItem_No                        VARCHAR(50),
ScaleItem_Value                     VARCHAR(50),
ScaleItem_Type                      VARCHAR(50)
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.rpro_in_prefs_ShippingWeightTable
----------------------------------------------------
CREATE TABLE dbo.rpro_in_prefs_ShippingWeightTable
(
ShippingWeightTableItem_No          VARCHAR(10),
Weight_Min                          VARCHAR(50),
Weight_Max                          VARCHAR(50),
Shipping_Price                      VARCHAR(50)
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.rpro_in_prefs_ShipProviders
----------------------------------------------------
CREATE TABLE dbo.rpro_in_prefs_ShipProviders
(
ShipProvider_No                     VARCHAR(50),
ShipProvider_Name                   VARCHAR(50),
ShipProvider_Default                VARCHAR(50),
ShipType_No                         VARCHAR(50),
ShipType_Name                       VARCHAR(50),
ShipType_Amount                     VARCHAR(50),
ShipType_Description                VARCHAR(255),
ShipType_Default                    VARCHAR(50)
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.rpro_in_prefs_ShipUnits
----------------------------------------------------
CREATE TABLE dbo.rpro_in_prefs_ShipUnits
(
Unit_No                             VARCHAR(50),
Name                                VARCHAR(50),
Abbr                                VARCHAR(50)
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.rpro_in_prefs_TaxAreas
----------------------------------------------------
CREATE TABLE dbo.rpro_in_prefs_TaxAreas
(
Code                                VARCHAR(50),
Country                             VARCHAR(50),
CountryCode                         VARCHAR(50),
Region                              VARCHAR(50),
RegionCode                          VARCHAR(50),
City                                VARCHAR(50),
RproTaxArea                         VARCHAR(50),
ZipCodes                            VARCHAR(1000)
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.rpro_in_prefs_TaxCodes
----------------------------------------------------
CREATE TABLE dbo.rpro_in_prefs_TaxCodes
(
TaxCode_No                          VARCHAR(50),
Name                                VARCHAR(50)
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.RPro_In_Receipts
----------------------------------------------------
CREATE TABLE dbo.RPro_In_Receipts
(
so_number                           VARCHAR(50),
Receipt_Number                      VARCHAR(50),
Receipt_SID                         VARCHAR(50),
StoreStation                        VARCHAR(50),
Receipt_Date                        VARCHAR(50),
Receipt_Subtotal                    VARCHAR(50),
Receipt_ShipAmount                  VARCHAR(50),
Receipt_FeeAmount                   VARCHAR(50),
Receipt_TaxArea                     VARCHAR(50),
Receipt_TotalTax                    VARCHAR(50),
Receipt_Total                       VARCHAR(50),
receipt_item_number                 VARCHAR(50),
sid                                 VARCHAR(50),
qty                                 VARCHAR(50),
extprc                              VARCHAR(50),
extpwt                              VARCHAR(50)
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.RPro_In_SO
----------------------------------------------------
CREATE TABLE dbo.RPro_In_SO
(
SO_Number                           VARCHAR(50),
SID                                 VARCHAR(50),
Status                              VARCHAR(50),
Total                               VARCHAR(50),
CaptureFund                         VARCHAR(50),
Item_Number                         VARCHAR(50),
Item_SID                            VARCHAR(50),
QtyShipped                          VARCHAR(50),
ShipDate                            VARCHAR(50),
ShipNumber                          VARCHAR(50),
ShipDescript                        VARCHAR(50),
ShipProvider                        VARCHAR(50)
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.RPro_in_SO_log
----------------------------------------------------
CREATE TABLE dbo.RPro_in_SO_log
(
SO_Number                           VARCHAR(50),
SID                                 VARCHAR(50),
Status                              VARCHAR(50),
Total                               VARCHAR(50),
CaptureFund                         VARCHAR(50),
Item_Number                         VARCHAR(50),
Item_SID                            VARCHAR(50),
QtyShipped                          VARCHAR(50),
ShipDate                            VARCHAR(50),
ShipNumber                          VARCHAR(50),
ShipDescript                        VARCHAR(50),
ShipProvider                        VARCHAR(50),
rdi_import_date                     DATETIME NOT NULL
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.Rpro_In_Styles
----------------------------------------------------
CREATE TABLE dbo.Rpro_In_Styles
(
fldStyleSID                         VARCHAR(30),
fldDCS                              VARCHAR(30),
fldDCSName                          VARCHAR(50),
fldDesc1                            VARCHAR(50),
fldDesc2                            VARCHAR(50),
fldDesc3                            VARCHAR(50),
fldDesc4                            VARCHAR(50),
fldInvnAUX0                         VARCHAR(50),
fldInvnAUX1                         VARCHAR(50),
fldInvnAUX2                         VARCHAR(50),
fldInvnAUX3                         VARCHAR(50),
fldInvnAUX4                         VARCHAR(50),
fldInvnAUX5                         VARCHAR(50),
fldInvnAUX6                         VARCHAR(50),
fldInvnAUX7                         VARCHAR(50),
fldStyleName                        VARCHAR(50),
fldStyleShortDesc                   VARCHAR(500),
fldStyleLongDesc                    VARCHAR(6000),
fldShipByWeight                     VARCHAR(20),
fldShipAmount                       VARCHAR(10),
fldShipWeight                       VARCHAR(10),
fldHandAmount                       VARCHAR(10),
fldOversize                         VARCHAR(10),
fldAvailDate                        VARCHAR(20),
fldDisplay                          VARCHAR(50),
fldAvailThreshold                   VARCHAR(10),
fldAvailAtStore                     VARCHAR(10),
fldProdAvail                        VARCHAR(10),
fldQtySource                        VARCHAR(10),
fldInStockMsg                       VARCHAR(50),
fldOutStockMsg                      VARCHAR(50),
fldShipProvider                     VARCHAR(50),
fldShipType                         VARCHAR(20),
fldShipUnit                         VARCHAR(10),
fldTaxCd                            VARCHAR(10),
fldProdAvail_i                      VARCHAR(10),
fldQtySource_i                      VARCHAR(10),
fldInStockMsg_i                     VARCHAR(10),
fldOutStockMsg_i                    VARCHAR(10),
fldShipProvider_i                   VARCHAR(10),
fldShipType_i                       VARCHAR(10),
fldShipUnit_i                       VARCHAR(10),
fldTaxCd_i                          VARCHAR(10),
fldStylePicture                     VARCHAR(30),
fldStyleThumbnail                   VARCHAR(30),
fldAvailDateFormat                  VARCHAR(20),
spotlight                           VARCHAR(30),
fldVendor                           VARCHAR(30),
fldVendorCode                       VARCHAR(20),
fldItemScale                        VARCHAR(30),
fldItemScale_i                      VARCHAR(10),
Item_fldItemNum                     VARCHAR(20),
Item_fldItemSID                     VARCHAR(30),
Item_fldUPC                         VARCHAR(20),
Item_fldALU                         VARCHAR(20),
Item_fldCaseQty                     VARCHAR(10),
Item_fldQty                         VARCHAR(10),
Item_fldTotOnHnd                    VARCHAR(10),
Item_fldCost                        VARCHAR(10),
Item_fldAttr                        VARCHAR(60),
Item_fldUDF0                        VARCHAR(50),
Item_fldUDF1                        VARCHAR(50),
Item_fldUDF2                        VARCHAR(50),
Item_fldUDF3                        VARCHAR(50),
Item_fldDscSch                      VARCHAR(50),
Item_fldSize                        VARCHAR(20),
Item_fldBackorder                   VARCHAR(20),
Item_fldDecimals                    VARCHAR(10),
Item_AvailQuantity                  VARCHAR(10),
Item_Availability                   VARCHAR(10),
Item_fldShipByWeight                VARCHAR(10),
Item_fldShipAmount                  VARCHAR(10),
Item_fldShipWeight                  VARCHAR(10),
Item_fldHandAmount                  VARCHAR(10),
Item_fldOversize                    VARCHAR(10),
Item_Price1                         VARCHAR(10),
Item_Price2                         VARCHAR(10),
Item_Price3                         VARCHAR(10),
Item_Price4                         VARCHAR(10),
Item_Price9                         VARCHAR(10),
Item_Price10                        VARCHAR(10),
Record_Type                         CHAR(10)
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.RPro_In_Styles_log
----------------------------------------------------
CREATE TABLE dbo.RPro_In_Styles_log
(
fldStyleSID                         VARCHAR(30),
fldDCS                              VARCHAR(30),
fldDCSName                          VARCHAR(50),
fldDesc1                            VARCHAR(50),
fldDesc2                            VARCHAR(50),
fldDesc3                            VARCHAR(50),
fldDesc4                            VARCHAR(50),
fldInvnAUX0                         VARCHAR(50),
fldInvnAUX1                         VARCHAR(50),
fldInvnAUX2                         VARCHAR(50),
fldInvnAUX3                         VARCHAR(50),
fldInvnAUX4                         VARCHAR(50),
fldInvnAUX5                         VARCHAR(50),
fldInvnAUX6                         VARCHAR(50),
fldInvnAUX7                         VARCHAR(50),
fldStyleName                        VARCHAR(50),
fldStyleShortDesc                   VARCHAR(500),
fldStyleLongDesc                    VARCHAR(6000),
fldShipByWeight                     VARCHAR(20),
fldShipAmount                       VARCHAR(10),
fldShipWeight                       VARCHAR(10),
fldHandAmount                       VARCHAR(10),
fldOversize                         VARCHAR(10),
fldAvailDate                        VARCHAR(20),
fldDisplay                          VARCHAR(50),
fldAvailThreshold                   VARCHAR(10),
fldAvailAtStore                     VARCHAR(10),
fldProdAvail                        VARCHAR(10),
fldQtySource                        VARCHAR(10),
fldInStockMsg                       VARCHAR(50),
fldOutStockMsg                      VARCHAR(50),
fldShipProvider                     VARCHAR(50),
fldShipType                         VARCHAR(20),
fldShipUnit                         VARCHAR(10),
fldTaxCd                            VARCHAR(10),
fldProdAvail_i                      VARCHAR(10),
fldQtySource_i                      VARCHAR(10),
fldInStockMsg_i                     VARCHAR(10),
fldOutStockMsg_i                    VARCHAR(10),
fldShipProvider_i                   VARCHAR(10),
fldShipType_i                       VARCHAR(10),
fldShipUnit_i                       VARCHAR(10),
fldTaxCd_i                          VARCHAR(10),
fldStylePicture                     VARCHAR(30),
fldStyleThumbnail                   VARCHAR(30),
fldAvailDateFormat                  VARCHAR(20),
spotlight                           VARCHAR(30),
fldVendor                           VARCHAR(30),
fldVendorCode                       VARCHAR(20),
fldItemScale                        VARCHAR(30),
fldItemScale_i                      VARCHAR(10),
Item_fldItemNum                     VARCHAR(20),
Item_fldItemSID                     VARCHAR(30),
Item_fldUPC                         VARCHAR(20),
Item_fldALU                         VARCHAR(20),
Item_fldCaseQty                     VARCHAR(10),
Item_fldQty                         VARCHAR(10),
Item_fldTotOnHnd                    VARCHAR(10),
Item_fldCost                        VARCHAR(10),
Item_fldAttr                        VARCHAR(60),
Item_fldUDF0                        VARCHAR(50),
Item_fldUDF1                        VARCHAR(50),
Item_fldUDF2                        VARCHAR(50),
Item_fldUDF3                        VARCHAR(50),
Item_fldDscSch                      VARCHAR(50),
Item_fldSize                        VARCHAR(20),
Item_fldBackorder                   VARCHAR(20),
Item_fldDecimals                    VARCHAR(10),
Item_AvailQuantity                  VARCHAR(10),
Item_Availability                   VARCHAR(10),
Item_fldShipByWeight                VARCHAR(10),
Item_fldShipAmount                  VARCHAR(10),
Item_fldShipWeight                  VARCHAR(10),
Item_fldHandAmount                  VARCHAR(10),
Item_fldOversize                    VARCHAR(10),
Item_Price1                         VARCHAR(10),
Item_Price2                         VARCHAR(10),
Item_Price3                         VARCHAR(10),
Item_Price4                         VARCHAR(10),
Item_Price9                         VARCHAR(10),
Item_Price10                        VARCHAR(10),
Record_Type                         CHAR(10),
rdi_import_date                     DATETIME NOT NULL
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.RPro_in_upsell_item
----------------------------------------------------
CREATE TABLE dbo.RPro_in_upsell_item
(
fldStyleSID                         VARCHAR(50),
fldUpsellSID                        VARCHAR(50),
fldOrderNo                          VARCHAR(50)
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.rpro_in_upsell_item_ddd
----------------------------------------------------
CREATE TABLE dbo.rpro_in_upsell_item_ddd
(
fldStyleSID                         VARCHAR(50),
fldUpsellSID                        VARCHAR(50),
fldOrderNo                          VARCHAR(50)
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.RPro_Out_Customers
----------------------------------------------------
CREATE TABLE dbo.RPro_Out_Customers
(
Customer_ID                         BIGINT,
RPro_Cust_SID                       NVARCHAR(100) NOT NULL,
First_Name                          NVARCHAR(100) NOT NULL,
Last_Name                           NVARCHAR(100) NOT NULL,
Address1                            NVARCHAR(200) NOT NULL,
Address2                            NVARCHAR(200) NOT NULL,
City                                NVARCHAR(200) NOT NULL,
State                               NVARCHAR(50),
Region                              NVARCHAR(200) NOT NULL,
Zip                                 NVARCHAR(20) NOT NULL,
Country                             NVARCHAR(200) NOT NULL,
Country_Code                        NVARCHAR(20) NOT NULL,
Phone                               NVARCHAR(30) NOT NULL,
Email                               NVARCHAR(100) NOT NULL,
Login_ID                            NVARCHAR(100),
Password                            NVARCHAR(100),
Orders_num                          INT,
has_so                              INT,
Company                             NVARCHAR(100)
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.RPro_Out_Customers_log
----------------------------------------------------
CREATE TABLE dbo.RPro_Out_Customers_log
(
Customer_ID                         BIGINT,
RPro_Cust_SID                       NVARCHAR(100) NOT NULL,
First_Name                          NVARCHAR(100) NOT NULL,
Last_Name                           NVARCHAR(100) NOT NULL,
Address1                            NVARCHAR(200) NOT NULL,
Address2                            NVARCHAR(200) NOT NULL,
City                                NVARCHAR(200) NOT NULL,
State                               NVARCHAR(50),
Region                              NVARCHAR(200) NOT NULL,
Zip                                 NVARCHAR(20) NOT NULL,
Country                             NVARCHAR(200) NOT NULL,
Country_Code                        NVARCHAR(20) NOT NULL,
Phone                               NVARCHAR(30) NOT NULL,
Email                               NVARCHAR(100) NOT NULL,
Login_ID                            NVARCHAR(100),
Password                            NVARCHAR(100),
Orders_num                          INT,
has_so                              INT,
Company                             NVARCHAR(100),
rdi_export_date                     DATETIME NOT NULL
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.RPro_Out_SO
----------------------------------------------------
CREATE TABLE dbo.RPro_Out_SO
(
date_inserted                       DATETIME,
order_sid                           NVARCHAR(40),
so_number                           NVARCHAR(40),
date_ordered                        DATETIME,
so_billto_cust_sid                  NVARCHAR(40),
so_billto_rpro_cust_sid             NVARCHAR(40),
so_billto_date_created              NVARCHAR(20),
so_billto_first_name                NVARCHAR(80),
so_billto_last_name                 NVARCHAR(80),
so_billto_address1                  NVARCHAR(80),
so_billto_address2                  NVARCHAR(80),
so_billto_city                      NVARCHAR(80),
so_billto_state_or_province         NVARCHAR(20),
so_billto_state_short               NVARCHAR(20),
so_billto_country                   NVARCHAR(80),
so_billto_country_short             NVARCHAR(80),
so_billto_postal_code               NVARCHAR(20),
so_billto_phone1                    NVARCHAR(30),
so_billto_phone2                    NVARCHAR(30),
so_billto_email                     NVARCHAR(100),
so_billto_language                  NVARCHAR(20),
so_billto_price_level               NVARCHAR(20),
so_shipto_cust_sid                  NVARCHAR(40),
so_shipto_rpro_cust_sid             NVARCHAR(40),
so_shipto_date_created              DATETIME,
so_shipto_title                     NVARCHAR(80),
so_shipto_first_name                NVARCHAR(80),
so_shipto_last_name                 NVARCHAR(80),
so_shipto_address1                  NVARCHAR(80),
so_shipto_address2                  NVARCHAR(80),
so_shipto_city                      NVARCHAR(80),
so_shipto_state_or_province         NVARCHAR(80),
so_shipto_state_short               NVARCHAR(20),
so_shipto_country                   NVARCHAR(40),
so_shipto_country_short             NVARCHAR(40),
so_shipto_postal_code               NVARCHAR(20),
so_shipto_phone1                    NVARCHAR(20),
so_shipto_phone2                    NVARCHAR(20),
so_shipto_email                     NVARCHAR(100),
so_shipto_language                  NVARCHAR(20),
so_shipto_price_level               NVARCHAR(20),
shipping_method                     NVARCHAR(80),
shipping_provider                   NVARCHAR(80),
cc_type                             NVARCHAR(30),
cc_name                             NVARCHAR(80),
cc_number                           NVARCHAR(80),
cc_expire                           NVARCHAR(20),
cc_expireformat                     NVARCHAR(20),
so_dateformat                       NVARCHAR(20),
so_ref                              NVARCHAR(200),
avs_code                            NVARCHAR(80),
disc_percent                        NVARCHAR(20),
ship_percent                        NVARCHAR(20),
disc_amount                         NVARCHAR(20),
ship_amount                         NVARCHAR(20),
total_tax                           NVARCHAR(20),
subtotal_used                       NVARCHAR(20),
tax_area                            NVARCHAR(20),
instruction                         NVARCHAR(800),
gift_slip                           NVARCHAR(20),
status                              NVARCHAR(20),
items_in                            INT,
SO_Origin                           CHAR(10),
uid                                 INT,
so_billto_company                   VARCHAR(40),
so_shipto_company                   VARCHAR(40)
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.RPro_Out_SO_Items
----------------------------------------------------
CREATE TABLE dbo.RPro_Out_SO_Items
(
Order_Sid                           NVARCHAR(50),
item_sid                            NVARCHAR(50),
item_no                             NVARCHAR(200),
ProductName                         NVARCHAR(200),
tax_code                            INT NOT NULL,
price                               NVARCHAR(30),
orig_price                          NVARCHAR(30),
qty_ordered                         INT,
tax_amount                          NVARCHAR(10) NOT NULL,
orig_tax_amount                     NVARCHAR(10) NOT NULL,
tax_percent                         NVARCHAR(10) NOT NULL,
uid                                 INT
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.RPro_Out_SO_Items_log
----------------------------------------------------
CREATE TABLE dbo.RPro_Out_SO_Items_log
(
Order_Sid                           NVARCHAR(50),
item_sid                            NVARCHAR(50),
item_no                             NVARCHAR(200),
ProductName                         NVARCHAR(200),
tax_code                            INT NOT NULL,
price                               NVARCHAR(30),
orig_price                          NVARCHAR(30),
qty_ordered                         INT,
tax_amount                          NVARCHAR(10) NOT NULL,
orig_tax_amount                     NVARCHAR(10) NOT NULL,
tax_percent                         NVARCHAR(10) NOT NULL,
uid                                 INT,
rdi_export_date                     DATETIME NOT NULL
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.RPro_Out_SO_log
----------------------------------------------------
CREATE TABLE dbo.RPro_Out_SO_log
(
date_inserted                       DATETIME,
order_sid                           NVARCHAR(40),
so_number                           NVARCHAR(40),
date_ordered                        DATETIME,
so_billto_cust_sid                  NVARCHAR(40),
so_billto_rpro_cust_sid             NVARCHAR(40),
so_billto_date_created              NVARCHAR(20),
so_billto_first_name                NVARCHAR(80),
so_billto_last_name                 NVARCHAR(80),
so_billto_address1                  NVARCHAR(80),
so_billto_address2                  NVARCHAR(80),
so_billto_city                      NVARCHAR(80),
so_billto_state_or_province         NVARCHAR(20),
so_billto_state_short               NVARCHAR(20),
so_billto_country                   NVARCHAR(80),
so_billto_country_short             NVARCHAR(80),
so_billto_postal_code               NVARCHAR(20),
so_billto_phone1                    NVARCHAR(30),
so_billto_phone2                    NVARCHAR(30),
so_billto_email                     NVARCHAR(100),
so_billto_language                  NVARCHAR(20),
so_billto_price_level               NVARCHAR(20),
so_shipto_cust_sid                  NVARCHAR(40),
so_shipto_rpro_cust_sid             NVARCHAR(40),
so_shipto_date_created              DATETIME,
so_shipto_title                     NVARCHAR(80),
so_shipto_first_name                NVARCHAR(80),
so_shipto_last_name                 NVARCHAR(80),
so_shipto_address1                  NVARCHAR(80),
so_shipto_address2                  NVARCHAR(80),
so_shipto_city                      NVARCHAR(80),
so_shipto_state_or_province         NVARCHAR(80),
so_shipto_state_short               NVARCHAR(20),
so_shipto_country                   NVARCHAR(40),
so_shipto_country_short             NVARCHAR(40),
so_shipto_postal_code               NVARCHAR(20),
so_shipto_phone1                    NVARCHAR(20),
so_shipto_phone2                    NVARCHAR(20),
so_shipto_email                     NVARCHAR(100),
so_shipto_language                  NVARCHAR(20),
so_shipto_price_level               NVARCHAR(20),
shipping_method                     NVARCHAR(80),
shipping_provider                   NVARCHAR(80),
cc_type                             NVARCHAR(30),
cc_name                             NVARCHAR(80),
cc_number                           NVARCHAR(80),
cc_expire                           NVARCHAR(20),
cc_expireformat                     NVARCHAR(20),
so_dateformat                       NVARCHAR(20),
so_ref                              NVARCHAR(200),
avs_code                            NVARCHAR(80),
disc_percent                        NVARCHAR(20),
ship_percent                        NVARCHAR(20),
disc_amount                         NVARCHAR(20),
ship_amount                         NVARCHAR(20),
total_tax                           NVARCHAR(20),
subtotal_used                       NVARCHAR(20),
tax_area                            NVARCHAR(20),
instruction                         NVARCHAR(800),
gift_slip                           NVARCHAR(20),
status                              NVARCHAR(20),
items_in                            INT,
SO_Origin                           CHAR(10),
uid                                 INT,
rdi_export_date                     DATETIME NOT NULL,
so_billto_company                   VARCHAR(40)
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.Sections
----------------------------------------------------
CREATE TABLE dbo.Sections
(
SectionID                           INT IDENTITY(1,1) NOT NULL,
SiteID                              SMALLINT DEFAULT ((1)),
SecName                             NVARCHAR(100),
SecSummary                          NVARCHAR(2000),
SecDescription                      NVARCHAR(2000),
SecImage                            NVARCHAR(100),
SecImageDir                         NVARCHAR(100),
SecFeaturedID                       NVARCHAR(100),
SecFeaturedDir                      NVARCHAR(100),
SecBanner                           NVARCHAR(100),
SEKeywords                          NVARCHAR(255),
SEDescription                       NVARCHAR(255),
ShowColumns                         SMALLINT DEFAULT ((4)),
ShowRows                            SMALLINT DEFAULT ((4)),
DisplayPrefix                       NVARCHAR(100),
SortByLooks                         BIT,
DisplayOrder                        INT DEFAULT ((1)),
CategoryDisplayFormatID             INT,
AllowCategoryFiltering              BIT,
AllowManufacturerFiltering          BIT,
AllowProductTypeFiltering           BIT,
Published                           BIT,
Comments                            TEXT,
AvailableCats                       NVARCHAR(500),
SubSectionOf                        SMALLINT,
Featured                            BIT DEFAULT ((0)),
RProVendorCode                      VARCHAR(50),
Hide1                               BIT DEFAULT ((0)),
Hide2                               BIT DEFAULT ((0)),
SecMetaTitle                        NVARCHAR(max),
SecMetaDescription                  NVARCHAR(max),
SecMetaKeywords                     NVARCHAR(max),
SecMetaKeyphrases                   NVARCHAR(max),
Deleted                             BIT DEFAULT ((0)),
DateCreated                         DATETIME DEFAULT (getdate()),
DateUpdated                         DATETIME,
UpdatedBy                           NVARCHAR(50),
CONSTRAINT PK_Sections PRIMARY KEY CLUSTERED ( SectionID )
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.ShippingCodes
----------------------------------------------------
CREATE TABLE dbo.ShippingCodes
(
ShippingCode                        SMALLINT NOT NULL,
ShippingMessage                     NVARCHAR(200) NOT NULL,
CONSTRAINT PK_ShippingCodes PRIMARY KEY CLUSTERED ( ShippingCode )
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.ShippingCompanies
----------------------------------------------------
CREATE TABLE dbo.ShippingCompanies
(
SCID                                SMALLINT NOT NULL,
SiteID                              SMALLINT DEFAULT ((1)),
FedexAccountNum                     NVARCHAR(50),
FedexIdentifier                     NVARCHAR(50),
FedexTestGateway                    NVARCHAR(200),
FedexProdGateway                    NVARCHAR(200),
UPSAccountNum                       NVARCHAR(50),
UPSAccessKey                        NVARCHAR(50),
UPSUserID                           NVARCHAR(50),
UPSPassword                         NVARCHAR(50),
USPSUserID                          NVARCHAR(50),
USPSPassword                        NVARCHAR(50),
CONSTRAINT PK_ShippingCompanies PRIMARY KEY CLUSTERED ( SCID )
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.ShippingMethods
----------------------------------------------------
CREATE TABLE dbo.ShippingMethods
(
SMID                                SMALLINT NOT NULL,
SiteID                              SMALLINT DEFAULT ((1)) NOT NULL,
ShippingCode                        NVARCHAR(100) NOT NULL,
ShippingMessage                     NVARCHAR(100) NOT NULL,
Allow                               BIT,
ShippingCompany                     NVARCHAR(10),
ShipPrice                           SMALLMONEY DEFAULT ((0)),
ShipWeightLo                        FLOAT DEFAULT ((0)),
ShipWeightHi                        FLOAT DEFAULT ((0)),
ShipPriceLo                         FLOAT DEFAULT ((0)),
ShipPriceHi                         FLOAT DEFAULT ((0)),
International                       BIT DEFAULT ((0)),
CONSTRAINT PK_ShippingMethods PRIMARY KEY CLUSTERED ( SMID )
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.ShipPrice
----------------------------------------------------
CREATE TABLE dbo.ShipPrice
(
ShipPriceID                         SMALLINT IDENTITY(1,1) NOT NULL,
SiteID                              SMALLINT DEFAULT ((1)) NOT NULL,
Start                               MONEY NOT NULL,
Finish                              MONEY NOT NULL,
DomesticRate                        MONEY NOT NULL,
InternationalRate                   MONEY NOT NULL,
CONSTRAINT PK_ShipPrice PRIMARY KEY CLUSTERED ( ShipPriceID )
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.ShipWeight
----------------------------------------------------
CREATE TABLE dbo.ShipWeight
(
ShipWeightID                        SMALLINT IDENTITY(1,1) NOT NULL,
SiteID                              SMALLINT DEFAULT ((1)) NOT NULL,
Start                               FLOAT NOT NULL,
Finish                              FLOAT NOT NULL,
DomesticRate                        MONEY NOT NULL,
InternationalRate                   MONEY NOT NULL,
CONSTRAINT PK_ShipWeight PRIMARY KEY CLUSTERED ( ShipWeightID )
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.States
----------------------------------------------------
CREATE TABLE dbo.States
(
SID                                 SMALLINT NOT NULL,
State                               NVARCHAR(30) NOT NULL,
StateCode                           NVARCHAR(2) NOT NULL,
T_Rate                              FLOAT,
S_Rate                              SMALLMONEY,
CONSTRAINT PK_States PRIMARY KEY CLUSTERED ( SID )
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.USAePay
----------------------------------------------------
CREATE TABLE dbo.USAePay
(
ID                                  SMALLINT IDENTITY(1,1) NOT NULL,
TransKey                            NVARCHAR(250) NOT NULL,
CONSTRAINT PK_USAePay PRIMARY KEY CLUSTERED ( ID )
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.Users
----------------------------------------------------
CREATE TABLE dbo.Users
(
UID                                 INT NOT NULL,
UUserName                           NVARCHAR(50),
UPassword                           NVARCHAR(50),
UName                               NVARCHAR(50),
UMinimum                            SMALLMONEY DEFAULT ((0)),
UMinimumFirst                       SMALLMONEY DEFAULT ((0)),
UTaxable                            BIT DEFAULT ((1)),
DateCreated                         SMALLDATETIME DEFAULT (getdate()),
DateUpdated                         SMALLDATETIME,
UpdatedBy                           NVARCHAR(50),
CONSTRAINT PK_Users PRIMARY KEY CLUSTERED ( UID )
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.Wishlist
----------------------------------------------------
CREATE TABLE dbo.Wishlist
(
WishListItemID                      INT IDENTITY(1,1) NOT NULL,
SiteID                              SMALLINT DEFAULT ((1)),
CustomerID                          FLOAT,
SessionID                           NVARCHAR(50),
ItemID                              INT,
Qty                                 INT,
OptionName1                         NVARCHAR(100),
OptionName2                         NVARCHAR(100),
OptionName3                         NVARCHAR(100),
DateEntered                         SMALLDATETIME DEFAULT (getdate()),
AffiliateID                         NVARCHAR(10),
BackOrdered                         BIT DEFAULT ((0)),
UseWholesalePrice                   BIT DEFAULT ((0)),
CONSTRAINT PK_Wishlist PRIMARY KEY CLUSTERED ( WishListItemID )
)
ON [PRIMARY]

GO
----------------------------------------------------
-- dbo.Years
----------------------------------------------------
CREATE TABLE dbo.Years
(
YearCode                            INT
)
ON [PRIMARY]

GO

/******************************************************
  Tables  End
******************************************************/
GO
/******************************************************
  Insert data   Begin
******************************************************/
GO
-----------------------------------------------------------
--Insert data into dbo.AdminUsers
-----------------------------------------------------------
ALTER TABLE dbo.AdminUsers NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.AdminUsers
GO

IF (IDENT_SEED('dbo.AdminUsers') IS NOT NULL )	SET IDENTITY_INSERT dbo.AdminUsers ON
INSERT INTO dbo.AdminUsers (UserID,UserName,Password,Roles,FirstName,LastName,CompanyName,Department,Address1,Address2,City,State,Zip,Country,Phone,Fax,Email,Comments,Disabled,DateCreated,DateUpdated,UpdatedBy) VALUES('1','Admin','password','Administrator',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'CA',NULL,'US',NULL,NULL,NULL,NULL,0,'2005-1-1 0:0:0',NULL,NULL)
INSERT INTO dbo.AdminUsers (UserID,UserName,Password,Roles,FirstName,LastName,CompanyName,Department,Address1,Address2,City,State,Zip,Country,Phone,Fax,Email,Comments,Disabled,DateCreated,DateUpdated,UpdatedBy) VALUES('2','Demo','demo','User',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'CA',NULL,'US',NULL,NULL,NULL,NULL,0,'2005-1-1 0:0:0','2006-12-9 22:25:0','ADMIN')
IF (IDENT_SEED('dbo.AdminUsers') IS NOT NULL )	SET IDENTITY_INSERT dbo.AdminUsers OFF
GO
GO
ALTER TABLE dbo.AdminUsers CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.AffiliateCommissions
-----------------------------------------------------------
ALTER TABLE dbo.AffiliateCommissions NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.AffiliateCommissions
GO

IF (IDENT_SEED('dbo.AffiliateCommissions') IS NOT NULL )	SET IDENTITY_INSERT dbo.AffiliateCommissions ON
INSERT INTO dbo.AffiliateCommissions (CommID,LevelName,L1,L2,L3) VALUES('1','Silver',4,6,1)
INSERT INTO dbo.AffiliateCommissions (CommID,LevelName,L1,L2,L3) VALUES('2','Gold',8,10,3)
INSERT INTO dbo.AffiliateCommissions (CommID,LevelName,L1,L2,L3) VALUES('3','Platinum',15,20,5)
INSERT INTO dbo.AffiliateCommissions (CommID,LevelName,L1,L2,L3) VALUES('5','Titanium',20,25,10)
IF (IDENT_SEED('dbo.AffiliateCommissions') IS NOT NULL )	SET IDENTITY_INSERT dbo.AffiliateCommissions OFF
GO
GO
ALTER TABLE dbo.AffiliateCommissions CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.BillingStatusCodes
-----------------------------------------------------------
ALTER TABLE dbo.BillingStatusCodes NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.BillingStatusCodes
GO

IF (IDENT_SEED('dbo.BillingStatusCodes') IS NOT NULL )	SET IDENTITY_INSERT dbo.BillingStatusCodes ON
INSERT INTO dbo.BillingStatusCodes (StatusCode,StatusMessage) VALUES('BI','Billed-In Process')
INSERT INTO dbo.BillingStatusCodes (StatusCode,StatusMessage) VALUES('NB','Not Paid')
INSERT INTO dbo.BillingStatusCodes (StatusCode,StatusMessage) VALUES('PA','Paid')
INSERT INTO dbo.BillingStatusCodes (StatusCode,StatusMessage) VALUES('PP','Paid-Partial')
INSERT INTO dbo.BillingStatusCodes (StatusCode,StatusMessage) VALUES('CA','Canceled')
INSERT INTO dbo.BillingStatusCodes (StatusCode,StatusMessage) VALUES('RE','Refunded')
INSERT INTO dbo.BillingStatusCodes (StatusCode,StatusMessage) VALUES('DE','Payment Declined')
INSERT INTO dbo.BillingStatusCodes (StatusCode,StatusMessage) VALUES('BC','Billed-COD')
INSERT INTO dbo.BillingStatusCodes (StatusCode,StatusMessage) VALUES('PC','Paid-COD')
INSERT INTO dbo.BillingStatusCodes (StatusCode,StatusMessage) VALUES('PK','Paid By Check/MO')
INSERT INTO dbo.BillingStatusCodes (StatusCode,StatusMessage) VALUES('BK','Billed By Invoice')
INSERT INTO dbo.BillingStatusCodes (StatusCode,StatusMessage) VALUES('AU','Payment Authorized')
INSERT INTO dbo.BillingStatusCodes (StatusCode,StatusMessage) VALUES('VO','Transaction Voided')
IF (IDENT_SEED('dbo.BillingStatusCodes') IS NOT NULL )	SET IDENTITY_INSERT dbo.BillingStatusCodes OFF
GO
GO
ALTER TABLE dbo.BillingStatusCodes CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.Config
-----------------------------------------------------------
ALTER TABLE dbo.Config NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.Config
GO

IF (IDENT_SEED('dbo.Config') IS NOT NULL )	SET IDENTITY_INSERT dbo.Config ON
INSERT INTO dbo.Config (SiteID,StoreName,StoreNameShort,CompanyName,CompanyAddress1,CompanyAddress2,CompanyCity,CompanyState,CompanyZip,CompanyCountry,CompanyPhone,CompanyAltPhone,CompanyFax,EmailInfo,EmailSales,EmailSupport,CompanyDescription,DateOfInception,DomainName,RootURL,EnableSSL,SSL_Path,ImagePathURL,IU_VirtualPathDIR,IU_URLDir,DocsDirectory,AppDirectory,MailServer,NotifyEmail,DBIsMySQL,HandlingFee,HandlingType,BaseCountry,DefaultOriginZipcode,BeginZiptoAccept,EndZiptoAccept,CheckZipCode,ShipBy,UseFedEx,UseUPS,UseUSPS,DefaultShipRateDom,DefaultShipRateInt,DefaultShipRateOver,PaymentSystem,RealtimePayments,CurrencyName,AllowOrderForm,AllowStoreCredit,AllowECheck,AllowPayPal,AllowCreditCards,AcceptVISA,AcceptMC,AcceptAMEX,AcceptDISC,EmailInvoiceToCustomer,EnableCustLogin,EnableMultiShip,EnableRelated,AllowAffiliates,AffiliateToCustomer,UseFlatTaxRate,FlatTaxRate,AddTaxToProdPrice,AcceptIntOrders,AcceptIntShipment,IntTaxCharge,DateUpdated,UpdatedBy,CFVersion,CryptKey,TaxID,UseBreadCrumbs,StatsURL,ShippingNotes,SaveCreditCard,ShowCreditCard) VALUES('1','CartFusion Ecommerce Software Demo','CartFusion Demo','CartFusion','123 ABC Blvd.','Suite 100','Rancho Cucamonga','CA','91730','US','866-855-CART (2278)','909-980-5281','480-287-8981','info@CartFusion.net','sales@CartFusion.net','support@CartFusion.net','Trade Studios announces the release of the all new CartFusion 5.0, a robust, highly versatile and customizable E-commerce solution software package. Ahead of all its competitors in class, price, ease-of-use, speed, and stability, CartFusion 5.0 will revolutionize the way small-to-medium-size businesses do business online. Front end features include an appealing, saveable shopping cart, wishlists, gift certificates, an advanced customer area which includes registration, order tracking, multiple, updateable billing and shipping info, smart searching, and rapid checkout. Back end features include credit card processing, order tracking and status settings, back orders handling, add/edit/delete products, categories, customers, orders, back orders, affiliates, distributors, a helpful message center to keep you and your customers on track, email marketing wizard, downloadable revenue and inventory reports... The list goes on and on...','1999-1-1 0:0:0','CartFusion.net','http://localhost:81/CartFusion460',0,'https://www.cartfusion.net','http://localhost:81/CartFusion460/images','C:\CFusionMX7\wwwroot\CartFusion46\wwwroot\images','http://localhost:81/CartFusion460/images','http://localhost:81/CartFusion460/docs',NULL,'mail.cartfusion.net','orders@cartfusion.net',0,10,'1','US','91730','00401','99950',0,'3',1,1,1,6.95,13.95,199,'2','1',NULL,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,0,8.25,0,1,1,1,'2007-3-25 13:50:0','ADMIN','4.703','CBDE3FA0-3048-87FC-EE80FD70DE5C0861',NULL,1,'http://cp.tradestudios.com:9999/Login.aspx?txtSiteID=cartfusion.net&txtUser=SITEADMIN','<font color="##CC0000"><b>SHIPPING NOTES:<br />Orders take 1-6 days to process before they are shipped.<br />Call us if you would like us to ship for delivery on a specific date.</b></font>',1,NULL)
IF (IDENT_SEED('dbo.Config') IS NOT NULL )	SET IDENTITY_INSERT dbo.Config OFF
GO
GO
ALTER TABLE dbo.Config CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.Countries
-----------------------------------------------------------
ALTER TABLE dbo.Countries NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.Countries
GO

IF (IDENT_SEED('dbo.Countries') IS NOT NULL )	SET IDENTITY_INSERT dbo.Countries ON
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Andorra','AD',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('United Arab Emirates','AE',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Afghanistan','AF',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Antigua and Barbuda','AG',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Anguilla','AI',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Albania','AL',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Armenia','AM',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Netherlands Antilles','AN',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Angola','AO',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Antarctica','AQ',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Argentina','AR',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('American Samoa','AS',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Austria','AT',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Australia','AU',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Aruba','AW',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Azerbaidjan','AZ',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Bosnia-Herzegovina','BA',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Barbados','BB',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Bangladesh','BD',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Belgium','BE',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Burkina Faso','BF',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Bulgaria','BG',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Bahrain','BH',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Burundi','BI',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Benin','BJ',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Bermuda','BM',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Brunei Darussalam','BN',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Bolivia','BO',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Brazil','BR',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Bahamas','BS',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Bhutan','BT',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Bouvet Island','BV',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Botswana','BW',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Belarus','BY',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Belize','BZ',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Canada','CA',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Cocos Islands','CC',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Central African Republic','CF',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Congo','CG',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Switzerland','CH',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Ivory Coast','CI',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Cook Islands','CK',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Chile','CL',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Cameroon','CM',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('China','CN',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Colombia','CO',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Costa Rica','CR',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Former Czechoslovakia','CS',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Cuba','CU',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Cape Verde','CV',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Christmas Island','CX',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Cyprus','CY',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Czech Republic','CZ',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Germany','DE',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Djibouti','DJ',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Denmark','DK',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Dominica','DM',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Dominican Republic','DO',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Algeria','DZ',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Ecuador','EC',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Estonia','EE',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Egypt','EG',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Western Sahara','EH',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Spain','ES',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Ethiopia','ET',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Finland','FI',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Fiji','FJ',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Falkland Islands','FK',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Micronesia','FM',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Faroe Islands','FO',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('France','FR',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Gabon','GA',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Great Britain','GB',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Grenada','GD',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Georgia','GE',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('French Guyana','GF',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Ghana','GH',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Gibraltar','GI',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Greenland','GL',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Gambia','GM',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Guinea','GN',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Guadeloupe','GP',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Equatorial Guinea','GQ',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Greece','GR',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Guatemala','GT',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Guam','GU',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Guinea Bissau','GW',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Guyana','GY',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Hong Kong','HK',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Honduras','HN',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Croatia','HR',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Haiti','HT',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Hungary','HU',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Indonesia','ID',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Ireland','IE',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Israel','IL',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('India','IN',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Iraq','IQ',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Iran','IR',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Iceland','IS',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Italy','IT',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Jamaica','JM',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Jordan','JO',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Japan','JP',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Kenya','KE',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Kyrgyzstan','KG',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Cambodia','KH',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Kiribati','KI',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Comoros','KM',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('North Korea','KP',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('South Korea','KR',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Kuwait','KW',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Cayman Islands','KY',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Kazakhstan','KZ',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Laos','LA',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Lebanon','LB',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Saint Lucia','LC',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Liechtenstein','LI',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Sri Lanka','LK',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Liberia','LR',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Lesotho','LS',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Lithuania','LT',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Luxembourg','LU',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Latvia','LV',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Libya','LY',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Morocco','MA',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Monaco','MC',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Moldavia','MD',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Madagascar','MG',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Marshall Islands','MH',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Macedonia','MK',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Mali','ML',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Myanmar','MM',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Mongolia','MN',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Macau','MO',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Martinique','MQ',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Mauritania','MR',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Montserrat','MS',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Malta','MT',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Mauritius','MU',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Maldives','MV',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Malawi','MW',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Mexico','MX',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Malaysia','MY',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Mozambique','MZ',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Namibia','NA',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('New Caledonia','NC',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Niger','NE',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Norfolk Island','NF',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Nigeria','NG',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Nicaragua','NI',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Netherlands','NL',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Norway','NO',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Nepal','NP',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Nauru','NR',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Neutral Zone','NT',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Niue','NU',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('New Zealand','NZ',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Oman','OM',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Panama','PA',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Peru','PE',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Polynesia','PF',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Papua New Guinea','PG',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Philippines','PH',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Pakistan','PK',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Poland','PL',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Pitcairn Island','PN',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Puerto Rico','PR',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Portugal','PT',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Palau','PW',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Paraguay','PY',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Qatar','QA',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Reunion','RE',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Romania','RO',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Russian Federation','RU',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Rwanda','RW',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Saudi Arabia','SA',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Solomon Islands','SB',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Seychelles','SC',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Sudan','SD',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Sweden','SE',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Singapore','SG',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Saint Helena','SH',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Slovenia','SI',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Slovak Republic','SK',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Sierra Leone','SL',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('San Marino','SM',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Senegal','SN',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Somalia','SO',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Suriname','SR',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('El Salvador','SV',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Syria','SY',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Swaziland','SZ',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Chad','TD',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Togo','TG',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Thailand','TH',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Tadjikistan','TJ',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Tokelau','TK',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Turkmenistan','TM',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Tunisia','TN',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Tonga','TO',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('East Timor','TP',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Turkey','TR',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Trinidad and Tobago','TT',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Tuvalu','TV',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Taiwan','TW',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Tanzania','TZ',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Ukraine','UA',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Uganda','UG',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('United Kingdom','UK',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('United States','US',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Uruguay','UY',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Uzbekistan','UZ',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Vatican City State','VA',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('St Vincent & Grenadines','VC',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Venezuela','VE',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Virgin Islands (British)','VG',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Virgin Islands (USA)','VI',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Vietnam','VN',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Vanuatu','VU',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Wallis and Futuna Islands','WF',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Samoa','WS',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Yemen','YE',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Mayotte','YT',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Yugoslavia','YU',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('South Africa','ZA',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Zambia','ZM',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Zaire','ZR',0)
INSERT INTO dbo.Countries (Country,CountryCode,S_Rate) VALUES('Zimbabwe','ZW',0)
IF (IDENT_SEED('dbo.Countries') IS NOT NULL )	SET IDENTITY_INSERT dbo.Countries OFF
GO
GO
ALTER TABLE dbo.Countries CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.Currencies
-----------------------------------------------------------
ALTER TABLE dbo.Currencies NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.Currencies
GO

IF (IDENT_SEED('dbo.Currencies') IS NOT NULL )	SET IDENTITY_INSERT dbo.Currencies ON
INSERT INTO dbo.Currencies (Locale,CurrencyMessage) VALUES('Dutch (Standard)','Netherlands Guilders')
INSERT INTO dbo.Currencies (Locale,CurrencyMessage) VALUES('English (Australian)','Australian Dollars')
INSERT INTO dbo.Currencies (Locale,CurrencyMessage) VALUES('English (Canadian)','Canadian Dollars')
INSERT INTO dbo.Currencies (Locale,CurrencyMessage) VALUES('English (New Zealand)','New Zealand Dollars')
INSERT INTO dbo.Currencies (Locale,CurrencyMessage) VALUES('English (UK)','United Kingdom Pounds')
INSERT INTO dbo.Currencies (Locale,CurrencyMessage) VALUES('English (US)','United States Dollars')
INSERT INTO dbo.Currencies (Locale,CurrencyMessage) VALUES('French (Belgian)','Belgian Francs')
INSERT INTO dbo.Currencies (Locale,CurrencyMessage) VALUES('French (Standard)','French Francs')
INSERT INTO dbo.Currencies (Locale,CurrencyMessage) VALUES('French (Swiss)','Swiss Francs')
INSERT INTO dbo.Currencies (Locale,CurrencyMessage) VALUES('German (Austrian)','Austrian Schillings')
INSERT INTO dbo.Currencies (Locale,CurrencyMessage) VALUES('German (Standard)','German Deutsche Marks')
INSERT INTO dbo.Currencies (Locale,CurrencyMessage) VALUES('Italian (Standard)','Italian Lira')
INSERT INTO dbo.Currencies (Locale,CurrencyMessage) VALUES('Norwegian (Nynorski)','Norwegian Kroner')
INSERT INTO dbo.Currencies (Locale,CurrencyMessage) VALUES('Portuguese (Brazilian)','Brazilian Real')
INSERT INTO dbo.Currencies (Locale,CurrencyMessage) VALUES('Portuguese (Standard)','Portuguese Escudo')
INSERT INTO dbo.Currencies (Locale,CurrencyMessage) VALUES('Spanish (Mexican)','Mexican Pesos')
INSERT INTO dbo.Currencies (Locale,CurrencyMessage) VALUES('Spanish (Standard)','Spanish Pesetas')
INSERT INTO dbo.Currencies (Locale,CurrencyMessage) VALUES('Swedish','Swedish Krona')
IF (IDENT_SEED('dbo.Currencies') IS NOT NULL )	SET IDENTITY_INSERT dbo.Currencies OFF
GO
GO
ALTER TABLE dbo.Currencies CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.Days
-----------------------------------------------------------
ALTER TABLE dbo.Days NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.Days
GO

IF (IDENT_SEED('dbo.Days') IS NOT NULL )	SET IDENTITY_INSERT dbo.Days ON
INSERT INTO dbo.Days (DayCode) VALUES('1')
INSERT INTO dbo.Days (DayCode) VALUES('2')
INSERT INTO dbo.Days (DayCode) VALUES('3')
INSERT INTO dbo.Days (DayCode) VALUES('4')
INSERT INTO dbo.Days (DayCode) VALUES('5')
INSERT INTO dbo.Days (DayCode) VALUES('6')
INSERT INTO dbo.Days (DayCode) VALUES('7')
INSERT INTO dbo.Days (DayCode) VALUES('8')
INSERT INTO dbo.Days (DayCode) VALUES('9')
INSERT INTO dbo.Days (DayCode) VALUES('10')
INSERT INTO dbo.Days (DayCode) VALUES('11')
INSERT INTO dbo.Days (DayCode) VALUES('12')
INSERT INTO dbo.Days (DayCode) VALUES('13')
INSERT INTO dbo.Days (DayCode) VALUES('14')
INSERT INTO dbo.Days (DayCode) VALUES('15')
INSERT INTO dbo.Days (DayCode) VALUES('16')
INSERT INTO dbo.Days (DayCode) VALUES('17')
INSERT INTO dbo.Days (DayCode) VALUES('18')
INSERT INTO dbo.Days (DayCode) VALUES('19')
INSERT INTO dbo.Days (DayCode) VALUES('20')
INSERT INTO dbo.Days (DayCode) VALUES('21')
INSERT INTO dbo.Days (DayCode) VALUES('22')
INSERT INTO dbo.Days (DayCode) VALUES('23')
INSERT INTO dbo.Days (DayCode) VALUES('24')
INSERT INTO dbo.Days (DayCode) VALUES('25')
INSERT INTO dbo.Days (DayCode) VALUES('26')
INSERT INTO dbo.Days (DayCode) VALUES('27')
INSERT INTO dbo.Days (DayCode) VALUES('28')
INSERT INTO dbo.Days (DayCode) VALUES('29')
INSERT INTO dbo.Days (DayCode) VALUES('30')
INSERT INTO dbo.Days (DayCode) VALUES('31')
IF (IDENT_SEED('dbo.Days') IS NOT NULL )	SET IDENTITY_INSERT dbo.Days OFF
GO
GO
ALTER TABLE dbo.Days CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.dtproperties
-----------------------------------------------------------
ALTER TABLE dbo.dtproperties NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.dtproperties
GO

IF (IDENT_SEED('dbo.dtproperties') IS NOT NULL )	SET IDENTITY_INSERT dbo.dtproperties ON
IF (IDENT_SEED('dbo.dtproperties') IS NOT NULL )	SET IDENTITY_INSERT dbo.dtproperties OFF
GO
GO
ALTER TABLE dbo.dtproperties CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.FormsOfPayment
-----------------------------------------------------------
ALTER TABLE dbo.FormsOfPayment NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.FormsOfPayment
GO

IF (IDENT_SEED('dbo.FormsOfPayment') IS NOT NULL )	SET IDENTITY_INSERT dbo.FormsOfPayment ON
INSERT INTO dbo.FormsOfPayment (FOPID,FOPCode,FOPMessage,FOPDesc) VALUES('1','1','Credit Card','Allow customers to use their credit card as a method of payment')
INSERT INTO dbo.FormsOfPayment (FOPID,FOPCode,FOPMessage,FOPDesc) VALUES('2','2','PayPal','Allow customers to submit payment to your PayPal account using their PayPal account')
INSERT INTO dbo.FormsOfPayment (FOPID,FOPCode,FOPMessage,FOPDesc) VALUES('3','3','E-Check','Allow customers to submit direct payment using their bank account')
INSERT INTO dbo.FormsOfPayment (FOPID,FOPCode,FOPMessage,FOPDesc) VALUES('4','4','Order Form','Allow customers to print their order and send it to you.')
IF (IDENT_SEED('dbo.FormsOfPayment') IS NOT NULL )	SET IDENTITY_INSERT dbo.FormsOfPayment OFF
GO
GO
ALTER TABLE dbo.FormsOfPayment CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.ItemStatusCodes
-----------------------------------------------------------
ALTER TABLE dbo.ItemStatusCodes NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.ItemStatusCodes
GO

IF (IDENT_SEED('dbo.ItemStatusCodes') IS NOT NULL )	SET IDENTITY_INSERT dbo.ItemStatusCodes ON
INSERT INTO dbo.ItemStatusCodes (StatusCode,StatusMessage) VALUES('BO','Back Ordered')
INSERT INTO dbo.ItemStatusCodes (StatusCode,StatusMessage) VALUES('DI','Discontinued')
INSERT INTO dbo.ItemStatusCodes (StatusCode,StatusMessage) VALUES('IS','In Stock')
INSERT INTO dbo.ItemStatusCodes (StatusCode,StatusMessage) VALUES('OS','Out of Stock')
IF (IDENT_SEED('dbo.ItemStatusCodes') IS NOT NULL )	SET IDENTITY_INSERT dbo.ItemStatusCodes OFF
GO
GO
ALTER TABLE dbo.ItemStatusCodes CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.Layout
-----------------------------------------------------------
ALTER TABLE dbo.Layout NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.Layout
GO

IF (IDENT_SEED('dbo.Layout') IS NOT NULL )	SET IDENTITY_INSERT dbo.Layout ON
INSERT INTO dbo.Layout (LayoutID,SiteID,PrimaryFontFamily,PrimaryBGColor,PrimaryBGImage,PrimaryLinkColor,PrimaryALinkColor,PrimaryVLinkColor,PrimaryHLinkColor,PrimaryLinkDecor,PrimaryALinkDecor,PrimaryVLinkDecor,PrimaryHLinkDecor,ButtonSize,ButtonColor,ButtonDecor,ButtonWeight,FormFieldSize,FormFieldColor,FormFieldDecor,FormFieldWeight,FormLabelSize,FormLabelColor,FormLabelDecor,FormLabelWeight,HeadingFontFamily,HeadingSize,HeadingColor,HeadingDecor,HeadingWeight,HomeHeadingSize,HomeHeadingColor,HomeHeadingDecor,HomeHeadingWeight,TableHeadingSize,TableHeadingColor,TableHeadingDecor,TableHeadingBGColor,TableHeadingWeight,MessageSize,MessageColor,MessageDecor,MessageWeight,ErrorMsgSize,ErrorMsgColor,ErrorMsgDecor,ErrorMsgWeight,DefaultSize,DefaultColor,DefaultDecor,DefaultWeight,PrimaryLinkWeight,PrimaryALinkWeight,PrimaryVLinkWeight,PrimaryHLinkWeight,MessageTwoSize,MessageTwoColor,MessageTwoDecor,MessageTwoWeight,MessageThreeSize,MessageThreeColor,MessageThreeDecor,MessageThreeWeight,AttractSize,AttractColor,AttractDecor,AttractWeight,MiniSize,MiniColor,MiniDecor,MiniWeight,HomeSize,HomeColor,HomeDecor,HomeWeight,DateUpdated,UpdatedBy) VALUES('1','1','Tahoma, Arial, sans-serif, Verdana','FFFFFF',NULL,'75C918','75C918','75C918','4DA0CA','none','none','none','underline','11','555555','none','normal','11','555555','none','normal','11','777777','none','normal','Tahoma, Arial, sans-serif, Verdana','13','025AB4','none','bold','13','4DA0CA','none','bold','11','FFFFFF','none','4DA0CA','bold','11','025AB4','none','normal','11','FF6600','none','bold','11','777777','none','normal','normal','normal','normal','normal','11','4DA0CA','none','bold','11','777777','none','bold','11','75C918','none','bold','10','777777','none','normal','11','777777','none','normal','2006-8-27 21:11:0','ADMIN')
IF (IDENT_SEED('dbo.Layout') IS NOT NULL )	SET IDENTITY_INSERT dbo.Layout OFF
GO
GO
ALTER TABLE dbo.Layout CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.LayoutStyles
-----------------------------------------------------------
ALTER TABLE dbo.LayoutStyles NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.LayoutStyles
GO

IF (IDENT_SEED('dbo.LayoutStyles') IS NOT NULL )	SET IDENTITY_INSERT dbo.LayoutStyles ON
INSERT INTO dbo.LayoutStyles (StyleName,StyleValue) VALUES('decor','blink')
INSERT INTO dbo.LayoutStyles (StyleName,StyleValue) VALUES('decor','line-through')
INSERT INTO dbo.LayoutStyles (StyleName,StyleValue) VALUES('decor','none')
INSERT INTO dbo.LayoutStyles (StyleName,StyleValue) VALUES('decor','overline')
INSERT INTO dbo.LayoutStyles (StyleName,StyleValue) VALUES('decor','underline')
INSERT INTO dbo.LayoutStyles (StyleName,StyleValue) VALUES('weight','bold')
INSERT INTO dbo.LayoutStyles (StyleName,StyleValue) VALUES('weight','bolder')
INSERT INTO dbo.LayoutStyles (StyleName,StyleValue) VALUES('weight','lighter')
INSERT INTO dbo.LayoutStyles (StyleName,StyleValue) VALUES('weight','normal')
IF (IDENT_SEED('dbo.LayoutStyles') IS NOT NULL )	SET IDENTITY_INSERT dbo.LayoutStyles OFF
GO
GO
ALTER TABLE dbo.LayoutStyles CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.MessageCodes
-----------------------------------------------------------
ALTER TABLE dbo.MessageCodes NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.MessageCodes
GO

IF (IDENT_SEED('dbo.MessageCodes') IS NOT NULL )	SET IDENTITY_INSERT dbo.MessageCodes ON
INSERT INTO dbo.MessageCodes (MCID,MessageCode) VALUES('1','Note')
INSERT INTO dbo.MessageCodes (MCID,MessageCode) VALUES('2','Important')
INSERT INTO dbo.MessageCodes (MCID,MessageCode) VALUES('3','Urgent')
IF (IDENT_SEED('dbo.MessageCodes') IS NOT NULL )	SET IDENTITY_INSERT dbo.MessageCodes OFF
GO
GO
ALTER TABLE dbo.MessageCodes CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.Months
-----------------------------------------------------------
ALTER TABLE dbo.Months NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.Months
GO

IF (IDENT_SEED('dbo.Months') IS NOT NULL )	SET IDENTITY_INSERT dbo.Months ON
INSERT INTO dbo.Months (MonthCode,MonthDisplay) VALUES('1','January')
INSERT INTO dbo.Months (MonthCode,MonthDisplay) VALUES('2','February')
INSERT INTO dbo.Months (MonthCode,MonthDisplay) VALUES('3','March')
INSERT INTO dbo.Months (MonthCode,MonthDisplay) VALUES('4','April')
INSERT INTO dbo.Months (MonthCode,MonthDisplay) VALUES('5','May')
INSERT INTO dbo.Months (MonthCode,MonthDisplay) VALUES('6','June')
INSERT INTO dbo.Months (MonthCode,MonthDisplay) VALUES('7','July')
INSERT INTO dbo.Months (MonthCode,MonthDisplay) VALUES('8','August')
INSERT INTO dbo.Months (MonthCode,MonthDisplay) VALUES('9','September')
INSERT INTO dbo.Months (MonthCode,MonthDisplay) VALUES('10','October')
INSERT INTO dbo.Months (MonthCode,MonthDisplay) VALUES('11','November')
INSERT INTO dbo.Months (MonthCode,MonthDisplay) VALUES('12','December')
IF (IDENT_SEED('dbo.Months') IS NOT NULL )	SET IDENTITY_INSERT dbo.Months OFF
GO
GO
ALTER TABLE dbo.Months CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.OrderItemsStatusCodes
-----------------------------------------------------------
ALTER TABLE dbo.OrderItemsStatusCodes NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.OrderItemsStatusCodes
GO

IF (IDENT_SEED('dbo.OrderItemsStatusCodes') IS NOT NULL )	SET IDENTITY_INSERT dbo.OrderItemsStatusCodes ON
INSERT INTO dbo.OrderItemsStatusCodes (StatusCode,StatusMessage) VALUES('BO','Back Ordered')
INSERT INTO dbo.OrderItemsStatusCodes (StatusCode,StatusMessage) VALUES('CA','Canceled')
INSERT INTO dbo.OrderItemsStatusCodes (StatusCode,StatusMessage) VALUES('OD','Ordered')
INSERT INTO dbo.OrderItemsStatusCodes (StatusCode,StatusMessage) VALUES('SH','Shipped')
INSERT INTO dbo.OrderItemsStatusCodes (StatusCode,StatusMessage) VALUES('BP','Back Order Processed')
INSERT INTO dbo.OrderItemsStatusCodes (StatusCode,StatusMessage) VALUES('RE','Returned')
INSERT INTO dbo.OrderItemsStatusCodes (StatusCode,StatusMessage) VALUES('PR','Processing')
INSERT INTO dbo.OrderItemsStatusCodes (StatusCode,StatusMessage) VALUES('RM','Processing Return')
IF (IDENT_SEED('dbo.OrderItemsStatusCodes') IS NOT NULL )	SET IDENTITY_INSERT dbo.OrderItemsStatusCodes OFF
GO
GO
ALTER TABLE dbo.OrderItemsStatusCodes CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.OrderStatusCodes
-----------------------------------------------------------
ALTER TABLE dbo.OrderStatusCodes NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.OrderStatusCodes
GO

IF (IDENT_SEED('dbo.OrderStatusCodes') IS NOT NULL )	SET IDENTITY_INSERT dbo.OrderStatusCodes ON
INSERT INTO dbo.OrderStatusCodes (StatusCode,StatusMessage) VALUES('BO','Back Ordered')
INSERT INTO dbo.OrderStatusCodes (StatusCode,StatusMessage) VALUES('CA','Canceled')
INSERT INTO dbo.OrderStatusCodes (StatusCode,StatusMessage) VALUES('IT','In Transit')
INSERT INTO dbo.OrderStatusCodes (StatusCode,StatusMessage) VALUES('OD','Ordered')
INSERT INTO dbo.OrderStatusCodes (StatusCode,StatusMessage) VALUES('SH','Shipped')
INSERT INTO dbo.OrderStatusCodes (StatusCode,StatusMessage) VALUES('SP','Shipped-Partial')
INSERT INTO dbo.OrderStatusCodes (StatusCode,StatusMessage) VALUES('RE','Returned')
INSERT INTO dbo.OrderStatusCodes (StatusCode,StatusMessage) VALUES('PR','Processing')
INSERT INTO dbo.OrderStatusCodes (StatusCode,StatusMessage) VALUES('RM','Processing Return')
IF (IDENT_SEED('dbo.OrderStatusCodes') IS NOT NULL )	SET IDENTITY_INSERT dbo.OrderStatusCodes OFF
GO
GO
ALTER TABLE dbo.OrderStatusCodes CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.Payment
-----------------------------------------------------------
ALTER TABLE dbo.Payment NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.Payment
GO

IF (IDENT_SEED('dbo.Payment') IS NOT NULL )	SET IDENTITY_INSERT dbo.Payment ON
INSERT INTO dbo.Payment (Type,Display,Allow) VALUES('AE','American Express',1)
INSERT INTO dbo.Payment (Type,Display,Allow) VALUES('DI','Discover',1)
INSERT INTO dbo.Payment (Type,Display,Allow) VALUES('MC','Master Card',1)
INSERT INTO dbo.Payment (Type,Display,Allow) VALUES('VI','Visa',1)
IF (IDENT_SEED('dbo.Payment') IS NOT NULL )	SET IDENTITY_INSERT dbo.Payment OFF
GO
GO
ALTER TABLE dbo.Payment CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.PaymentSystems
-----------------------------------------------------------
ALTER TABLE dbo.PaymentSystems NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.PaymentSystems
GO

IF (IDENT_SEED('dbo.PaymentSystems') IS NOT NULL )	SET IDENTITY_INSERT dbo.PaymentSystems ON
INSERT INTO dbo.PaymentSystems (PSID,PaymentSystemCode,PaymentSystemMessage,PSLogo,DisplayOrder) VALUES('1','NO','None/Manual Order Handling',NULL,'1')
INSERT INTO dbo.PaymentSystems (PSID,PaymentSystemCode,PaymentSystemMessage,PSLogo,DisplayOrder) VALUES('2','AN','Authorize.net 3.1','logo-pgAuthorizeNet.gif','2')
INSERT INTO dbo.PaymentSystems (PSID,PaymentSystemCode,PaymentSystemMessage,PSLogo,DisplayOrder) VALUES('3','US','USA ePay','logo-pgUSAePay.gif','5')
INSERT INTO dbo.PaymentSystems (PSID,PaymentSystemCode,PaymentSystemMessage,PSLogo,DisplayOrder) VALUES('4','PL','PayFlow Link','logo-pgPayFlowLink.gif','3')
INSERT INTO dbo.PaymentSystems (PSID,PaymentSystemCode,PaymentSystemMessage,PSLogo,DisplayOrder) VALUES('5','PP','PayPal Pro','logo-pgPayPal.gif','4')
INSERT INTO dbo.PaymentSystems (PSID,PaymentSystemCode,PaymentSystemMessage,PSLogo,DisplayOrder) VALUES('6','WP','WorldPay','logo-pgWorldPay.gif','6')
INSERT INTO dbo.PaymentSystems (PSID,PaymentSystemCode,PaymentSystemMessage,PSLogo,DisplayOrder) VALUES('7','LP','LinkPoint/YourPay API','logo-pgYourPay.gif','2')
IF (IDENT_SEED('dbo.PaymentSystems') IS NOT NULL )	SET IDENTITY_INSERT dbo.PaymentSystems OFF
GO
GO
ALTER TABLE dbo.PaymentSystems CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.Roles
-----------------------------------------------------------
ALTER TABLE dbo.Roles NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.Roles
GO

IF (IDENT_SEED('dbo.Roles') IS NOT NULL )	SET IDENTITY_INSERT dbo.Roles ON
INSERT INTO dbo.Roles (RID,Role) VALUES('1','Administrator')
INSERT INTO dbo.Roles (RID,Role) VALUES('2','User')
IF (IDENT_SEED('dbo.Roles') IS NOT NULL )	SET IDENTITY_INSERT dbo.Roles OFF
GO
GO
ALTER TABLE dbo.Roles CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.ShippingMethods
-----------------------------------------------------------
ALTER TABLE dbo.ShippingMethods NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.ShippingMethods
GO

IF (IDENT_SEED('dbo.ShippingMethods') IS NOT NULL )	SET IDENTITY_INSERT dbo.ShippingMethods ON
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('1','1','01','UPS Next Day Air',1,'UPS',0,0,0,0,0,0)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('2','1','02','UPS 2nd Day Air',1,'UPS',0,0,0,0,0,0)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('3','1','03','UPS Ground',1,'UPS',0,0,0,0,0,0)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('4','1','07','UPS Worldwide Express',1,'UPS',0,0,0,0,0,1)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('5','1','08','UPS Worldwide Expedited',0,'UPS',0,0,0,0,0,1)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('6','1','11','UPS Ground Service to Canada',1,'UPS',0,0,0,0,0,1)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('7','1','12','UPS 3-Day Select',0,'UPS',0,0,0,0,0,0)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('8','1','13','UPS Next Day Air Saver',0,'UPS',0,0,0,0,0,0)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('9','1','14','UPS Next Day Air Early AM',0,'UPS',0,0,0,0,0,0)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('10','1','54','UPS Worldwide Express Plus',0,'UPS',0,0,0,0,0,1)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('11','1','59','UPS 2nd Day Air AM',0,'UPS',0,0,0,0,0,0)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('12','1','65','UPS Express Saver',0,'UPS',0,0,0,0,0,0)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('13','1','Priority','USPS Priority Mail',1,'USPS',0,0,0,0,0,0)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('14','1','Express','USPS Express Mail',1,'USPS',0,0,0,0,0,0)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('15','1','First Class','USPS First Class Mail',0,'USPS',0,0,0,0,0,0)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('16','1','Parcel','USPS Parcel Post',0,'USPS',0,0,0,0,0,0)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('17','1','BPM','USPS Bound Printed Matter',0,'USPS',0,0,0,0,0,0)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('18','1','Library','USPS Library Mail Service',0,'USPS',0,0,0,0,0,0)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('19','1','Media','USPS Media Mail',0,'USPS',0,0,0,0,0,0)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('20','1','STANDARDOVERNIGHT','FedEx Standard Overnight',0,'FedEx',0,0,0,0,0,0)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('21','1','PRIORITYOVERNIGHT','FedEx Priority Overnight',1,'FedEx',0,0,0,0,0,0)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('22','1','FIRSTOVERNIGHT','FedEx First Overnight',0,'FedEx',0,0,0,0,0,0)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('23','1','FEDEX2DAY','FedEx 2 Day',1,'FedEx',0,0,0,0,0,0)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('24','1','FEDEXEXPRESSSAVER','FedEx 3 Day Express Saver',0,'FedEx',0,0,0,0,0,0)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('25','1','FEDEXGROUND','FedEx Ground',1,'FedEx',0,0,0,0,0,0)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('26','1','GROUNDHOMEDELIVERY','FedEx Ground Home Delivery',0,'FedEx',0,0,0,0,0,0)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('27','1','FEDEX1DAYFREIGHT','FedEx 1 Day Freight',0,'FedEx',0,0,0,0,0,0)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('29','1','FEDEX2DAYFREIGHT','FedEx 2 Day Freight',0,'FedEx',0,0,0,0,0,0)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('30','1','FEDEX3DAYFREIGHT','FedEx 3 Day Freight',1,'FedEx',0,0,0,0,0,0)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('31','1','INTERNATIONALPRIORITY','FedEx Int''l Priority',1,'FedEx',0,0,0,0,0,1)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('32','1','INTERNATIONALECONOMY','FedEx Int''l Economy',1,'FedEx',0,0,0,0,0,1)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('33','1','INTERNATIONALFIRST','FedEx Int''l First',0,'FedEx',0,0,0,0,0,1)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('34','1','INTERNATIONALPRIORITYFREIGHT','FedEx Int''l Priority Freight',0,'FedEx',0,0,0,0,0,1)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('35','1','INTERNATIONALECONOMYFREIGHT','FedEx Int''l Economy Freight',0,'FedEx',0,0,0,0,0,1)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('36','1','Location','By Location',1,'Location',0,0,0,0,0,0)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('37','1','Price','By Price',1,'Price',0,0,0,0,0,0)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('38','1','Weight','By Weight',1,'Weight',0,0,0,0,0,0)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('39','1','Default','Default Shipping',1,'Default',0,0,0,0,0,0)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('40','1','Global Express Guaranteed Document Service','USPS Gbl XP Guar. Doc Svc',0,'USPS',0,0,0,0,0,1)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('41','1','Global Express Guaranteed Non-Document Service','USPS Gbl XP Guar. Non-Doc Svc',0,'USPS',0,0,0,0,0,1)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('42','1','Global Express Mail (EMS)','USPS Global Express Mail (EMS)',1,'USPS',0,0,0,0,0,1)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('43','1','Global Priority Mail - Flat-rate Envelope (Large)','USPS GPM - Flat-rate Env. (Lg)',0,'USPS',0,0,0,0,0,1)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('44','1','Global Priority Mail - Flat-rate Envelope (Small)','USPS GPM - Flat-rate Env. (Sm)',0,'USPS',0,0,0,0,0,1)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('45','1','Global Priority Mail - Variable Weight Envelope (Single)','USPS GPM - Envelope (Single)',0,'USPS',0,0,0,0,0,1)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('46','1','Airmail Letter-post','USPS Airmail Letter-post',0,'USPS',0,0,0,0,0,1)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('47','1','Airmail Parcel Post','USPS Airmail Parcel Post',1,'USPS',0,0,0,0,0,1)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('48','1','Economy (Surface) Letter-post','USPS Surface Letter-post',0,'USPS',0,0,0,0,0,1)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('49','1','Economy (Surface) Parcel Post','USPS Surface Parcel Post',1,'USPS',0,0,0,0,0,1)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('50','1','Custom1','USPS First Class',1,'Custom',3.85,0,4,0,0,0)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('51','1','Custom2','USPS Priority Mail',1,'Custom',7.95,4,10,0,0,0)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('52','1','Custom3','FedEx 2-Day',1,'Custom',14,0,5,0,0,0)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('53','1','Custom4','FedEx Standard Overnight',1,'Custom',20,0,5,0,0,0)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('54','1','Custom5','FedEx 2-Day',1,'Custom',18,5,20,0,0,0)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('55','1','Custom6','FedEx Priority Overnight',1,'Custom',26,5,20,0,0,0)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('56','1','Custom7','Default Shipping',1,'Custom',29.95,20,100000,0,0,0)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('57','1','Custom8','International Shipping',1,'Custom',12.95,0,100000,0,0,1)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('58','1','Custom9','FedEx 3-Day',1,'Custom',9,0,5,0,0,0)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('59','1','Custom10','FedEx 3-Day',1,'Custom',12,5,20,0,0,0)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('60','1','Custom11','USPS Priority Mail',1,'Custom',14.95,10,20,0,0,0)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('61','1','CustomP1','Default Shipping',1,'Custom',7.95,0,0,0,100000,0)
INSERT INTO dbo.ShippingMethods (SMID,SiteID,ShippingCode,ShippingMessage,Allow,ShippingCompany,ShipPrice,ShipWeightLo,ShipWeightHi,ShipPriceLo,ShipPriceHi,International) VALUES('62','1','CustomP2','Default Int''l Shipping',1,'Custom',15.95,0,0,0,100000,1)
IF (IDENT_SEED('dbo.ShippingMethods') IS NOT NULL )	SET IDENTITY_INSERT dbo.ShippingMethods OFF
GO
GO
ALTER TABLE dbo.ShippingMethods CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.ShipPrice
-----------------------------------------------------------
ALTER TABLE dbo.ShipPrice NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.ShipPrice
GO

IF (IDENT_SEED('dbo.ShipPrice') IS NOT NULL )	SET IDENTITY_INSERT dbo.ShipPrice ON
INSERT INTO dbo.ShipPrice (ShipPriceID,SiteID,Start,Finish,DomesticRate,InternationalRate) VALUES('1','1',0,250,7.95,13.95)
INSERT INTO dbo.ShipPrice (ShipPriceID,SiteID,Start,Finish,DomesticRate,InternationalRate) VALUES('2','1',250.01,500,13.95,20.95)
INSERT INTO dbo.ShipPrice (ShipPriceID,SiteID,Start,Finish,DomesticRate,InternationalRate) VALUES('3','1',500.01,1000,19.95,30.95)
INSERT INTO dbo.ShipPrice (ShipPriceID,SiteID,Start,Finish,DomesticRate,InternationalRate) VALUES('4','1',1000.01,1500,26.95,40.95)
INSERT INTO dbo.ShipPrice (ShipPriceID,SiteID,Start,Finish,DomesticRate,InternationalRate) VALUES('5','1',1500.01,2000,35.95,50.95)
INSERT INTO dbo.ShipPrice (ShipPriceID,SiteID,Start,Finish,DomesticRate,InternationalRate) VALUES('6','1',2000.01,100000,50.95,80.95)
IF (IDENT_SEED('dbo.ShipPrice') IS NOT NULL )	SET IDENTITY_INSERT dbo.ShipPrice OFF
GO
GO
ALTER TABLE dbo.ShipPrice CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.ShipWeight
-----------------------------------------------------------
ALTER TABLE dbo.ShipWeight NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.ShipWeight
GO

IF (IDENT_SEED('dbo.ShipWeight') IS NOT NULL )	SET IDENTITY_INSERT dbo.ShipWeight ON
INSERT INTO dbo.ShipWeight (ShipWeightID,SiteID,Start,Finish,DomesticRate,InternationalRate) VALUES('1','1',0,2,6.95,11.95)
INSERT INTO dbo.ShipWeight (ShipWeightID,SiteID,Start,Finish,DomesticRate,InternationalRate) VALUES('2','1',2,3,8.45,15.95)
INSERT INTO dbo.ShipWeight (ShipWeightID,SiteID,Start,Finish,DomesticRate,InternationalRate) VALUES('3','1',3,4,9.95,18.95)
INSERT INTO dbo.ShipWeight (ShipWeightID,SiteID,Start,Finish,DomesticRate,InternationalRate) VALUES('4','1',4,5,10.45,21.95)
INSERT INTO dbo.ShipWeight (ShipWeightID,SiteID,Start,Finish,DomesticRate,InternationalRate) VALUES('5','1',5,6,11.95,24.95)
INSERT INTO dbo.ShipWeight (ShipWeightID,SiteID,Start,Finish,DomesticRate,InternationalRate) VALUES('6','1',6,10,12.95,26.95)
INSERT INTO dbo.ShipWeight (ShipWeightID,SiteID,Start,Finish,DomesticRate,InternationalRate) VALUES('7','1',10,15,13.45,29.95)
INSERT INTO dbo.ShipWeight (ShipWeightID,SiteID,Start,Finish,DomesticRate,InternationalRate) VALUES('8','1',15,30,15.95,34.95)
INSERT INTO dbo.ShipWeight (ShipWeightID,SiteID,Start,Finish,DomesticRate,InternationalRate) VALUES('9','1',30,150,30.95,60.95)
INSERT INTO dbo.ShipWeight (ShipWeightID,SiteID,Start,Finish,DomesticRate,InternationalRate) VALUES('10','1',150.01,1000000,199,299)
IF (IDENT_SEED('dbo.ShipWeight') IS NOT NULL )	SET IDENTITY_INSERT dbo.ShipWeight OFF
GO
GO
ALTER TABLE dbo.ShipWeight CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.States
-----------------------------------------------------------
ALTER TABLE dbo.States NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.States
GO

IF (IDENT_SEED('dbo.States') IS NOT NULL )	SET IDENTITY_INSERT dbo.States ON
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('0','--- UNITED STATES ---','',0,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('1','Alabama','AL',4,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('2','Alaska','AK',0,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('3','Arizona','AZ',5.6,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('4','Arkansas','AR',6,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('5','California','CA',7.25,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('6','Colorado','CO',2.9,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('7','Connecticut','CT',6,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('8','Delaware','DE',0,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('9','District of Columbia','DC',5.75,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('10','Florida','FL',6,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('11','Georgia','GA',4,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('12','Hawaii','HI',4,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('13','Idaho','ID',5,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('14','Illinois','IL',6.25,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('15','Indiana','IN',6,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('16','Iowa','IA',5,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('17','Kansas','KS',5.3,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('18','Kentucky','KY',6,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('19','Louisiana','LA',4,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('20','Maine','ME',5,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('21','Maryland','MD',5,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('22','Massachusetts','MA',5,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('23','Michigan','MI',6,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('24','Minnesota','MN',6.5,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('25','Mississippi','MS',7,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('26','Missouri','MO',4.225,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('27','Montana','MT',0,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('28','Nebraska','NE',5.5,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('29','Nevada','NV',6.5,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('30','New Hampshire','NH',0,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('31','New Jersey','NJ',6,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('32','New Mexico','NM',5,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('33','New York','NY',4,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('34','North Carolina','NC',4.5,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('35','North Dakota','ND',5,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('36','Ohio','OH',5.5,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('37','Oklahoma','OK',1,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('38','Oregon','OR',0,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('39','Pennsylvania','PA',6,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('40','Rhode Island','RI',7,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('41','South Carolina','SC',5,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('42','South Dakota','SD',4,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('43','Tennessee','TN',7,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('44','Texas','TX',6.25,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('45','Utah','UT',4.75,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('46','Vermont','VT',6,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('47','Virginia','VA',5,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('48','Washington','WA',6.5,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('49','West Virginia','WV',6,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('50','Wisconsin','WI',5,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('51','Wyoming','WY',4,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('53','--- CANADA ---','',0,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('54','Alberta','AB',0,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('55','British Columbia','BC',7,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('56','Manitoba','MB',7,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('57','New Brunswick','NB',15,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('58','Newfoundland','NF',15,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('59','Northwest Territories','NT',0,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('60','Nova Scotia','NS',15,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('61','Ontario','ON',8,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('62','Prince Edward Island','PE',10,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('63','Quebec','QC',7.5,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('64','Saskatchewan','SK',7,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('65','Yukon','YT',0,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('66','--- US TERRITORIES ---','',0,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('67','American Samoa','AS',5.5,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('68','Fed. Micronesia','FM',5.5,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('69','Guam','GU',5.5,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('70','Marshall Island','MH',5.5,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('71','N. Mariana Is.','MP',5.5,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('72','Palau Island','PW',5.5,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('73','Puerto Rico','PR',5.5,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('74','U.S. Virgin Islands','VI',5.5,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('75','--- INTERNATIONAL ---','',0,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('76','Int''l State/Province','-',0,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('77','--- MILITARY ---','',0,0)
INSERT INTO dbo.States (SID,State,StateCode,T_Rate,S_Rate) VALUES('78','AP - Military Base','AP',0,0)
IF (IDENT_SEED('dbo.States') IS NOT NULL )	SET IDENTITY_INSERT dbo.States OFF
GO
GO
ALTER TABLE dbo.States CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.Users
-----------------------------------------------------------
ALTER TABLE dbo.Users NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.Users
GO

IF (IDENT_SEED('dbo.Users') IS NOT NULL )	SET IDENTITY_INSERT dbo.Users ON
INSERT INTO dbo.Users (UID,UUserName,UPassword,UName,UMinimum,UMinimumFirst,UTaxable,DateCreated,DateUpdated,UpdatedBy) VALUES('1','retail','retail','Retail',0,0,1,'2004-11-21 0:0:0',NULL,NULL)
INSERT INTO dbo.Users (UID,UUserName,UPassword,UName,UMinimum,UMinimumFirst,UTaxable,DateCreated,DateUpdated,UpdatedBy) VALUES('2','wholesaler','cartfusion','Wholesale',500,1000,0,'2005-8-28 8:30:0','2005-8-28 8:30:0','ADMIN')
IF (IDENT_SEED('dbo.Users') IS NOT NULL )	SET IDENTITY_INSERT dbo.Users OFF
GO
GO
ALTER TABLE dbo.Users CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.Years
-----------------------------------------------------------
ALTER TABLE dbo.Years NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.Years
GO

IF (IDENT_SEED('dbo.Years') IS NOT NULL )	SET IDENTITY_INSERT dbo.Years ON
INSERT INTO dbo.Years (YearCode) VALUES('2000')
INSERT INTO dbo.Years (YearCode) VALUES('2001')
INSERT INTO dbo.Years (YearCode) VALUES('2002')
INSERT INTO dbo.Years (YearCode) VALUES('2003')
INSERT INTO dbo.Years (YearCode) VALUES('2004')
INSERT INTO dbo.Years (YearCode) VALUES('2005')
IF (IDENT_SEED('dbo.Years') IS NOT NULL )	SET IDENTITY_INSERT dbo.Years OFF
GO
GO
ALTER TABLE dbo.Years CHECK CONSTRAINT ALL
GO



/******************************************************
  Insert data  End
******************************************************/
GO
/******************************************************
  Foreign keys  Begin
******************************************************/
GO

/******************************************************
  Foreign keys  End
******************************************************/
GO
/******************************************************
  Stored procedures  Begin
******************************************************/
GO
----------------------------------------------------
-- dbo.SP_RPro_Export
----------------------------------------------------
GO
CREATE          PROC SP_RPro_Export
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
----------------------------------------------------
-- dbo.SP_RPro_Export_Customers
----------------------------------------------------
GO
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
----------------------------------------------------
-- dbo.SP_RPro_Export_Orders
----------------------------------------------------
GO
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
----------------------------------------------------
-- dbo.SP_RPro_Load
----------------------------------------------------
GO
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
----------------------------------------------------
-- dbo.SP_RPro_Load_Catalog
----------------------------------------------------
GO
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
----------------------------------------------------
-- dbo.SP_RPro_Load_Customers
----------------------------------------------------
GO
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
----------------------------------------------------
-- dbo.SP_RPro_Load_Scales
----------------------------------------------------
GO
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
----------------------------------------------------
-- dbo.SP_RPro_Load_SOStatus
----------------------------------------------------
GO
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

/******************************************************
  Stored procedures  End
******************************************************/
GO
/******************************************************
  Views  Begin
******************************************************/
GO
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

/******************************************************
  Views  End
******************************************************/
GO
