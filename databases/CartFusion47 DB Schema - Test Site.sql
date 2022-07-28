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
--Insert data into dbo.AffiliateHistory
-----------------------------------------------------------
ALTER TABLE dbo.AffiliateHistory NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.AffiliateHistory
GO

IF (IDENT_SEED('dbo.AffiliateHistory') IS NOT NULL )	SET IDENTITY_INSERT dbo.AffiliateHistory ON
INSERT INTO dbo.AffiliateHistory (AHID,AFID,L1,L2,L3,DateEntered) VALUES('1','7000',8,10,3,'2004-7-4 22:39:0')
INSERT INTO dbo.AffiliateHistory (AHID,AFID,L1,L2,L3,DateEntered) VALUES('2','7007',8,10,3,'2004-7-4 22:39:0')
INSERT INTO dbo.AffiliateHistory (AHID,AFID,L1,L2,L3,DateEntered) VALUES('3','7014',8,10,3,'2004-7-4 22:39:0')
INSERT INTO dbo.AffiliateHistory (AHID,AFID,L1,L2,L3,DateEntered) VALUES('4','7021',5,7,1,'2004-7-4 22:39:0')
INSERT INTO dbo.AffiliateHistory (AHID,AFID,L1,L2,L3,DateEntered) VALUES('5','7028',5,7,1,'2004-7-4 22:39:0')
INSERT INTO dbo.AffiliateHistory (AHID,AFID,L1,L2,L3,DateEntered) VALUES('6','7000',4,6,1,'2005-12-5 8:46:0')
INSERT INTO dbo.AffiliateHistory (AHID,AFID,L1,L2,L3,DateEntered) VALUES('7','7000',15,20,5,'2005-12-5 8:47:0')
INSERT INTO dbo.AffiliateHistory (AHID,AFID,L1,L2,L3,DateEntered) VALUES('8','7000',8,10,3,'2005-12-5 8:47:0')
INSERT INTO dbo.AffiliateHistory (AHID,AFID,L1,L2,L3,DateEntered) VALUES('9','7000',4,6,1,'2005-12-5 8:47:0')
INSERT INTO dbo.AffiliateHistory (AHID,AFID,L1,L2,L3,DateEntered) VALUES('10','7035',15,20,5,'2005-12-2 9:47:0')
INSERT INTO dbo.AffiliateHistory (AHID,AFID,L1,L2,L3,DateEntered) VALUES('11','7000',8,10,3,'2005-12-5 9:47:0')
INSERT INTO dbo.AffiliateHistory (AHID,AFID,L1,L2,L3,DateEntered) VALUES('12','7000',15,20,5,'2005-12-5 9:49:0')
INSERT INTO dbo.AffiliateHistory (AHID,AFID,L1,L2,L3,DateEntered) VALUES('13','7042',8,10,3,'2005-12-5 9:58:0')
INSERT INTO dbo.AffiliateHistory (AHID,AFID,L1,L2,L3,DateEntered) VALUES('14','7028',4,6,1,'2005-12-5 20:59:0')
INSERT INTO dbo.AffiliateHistory (AHID,AFID,L1,L2,L3,DateEntered) VALUES('15','7049',4,6,1,'2005-12-5 20:59:0')
INSERT INTO dbo.AffiliateHistory (AHID,AFID,L1,L2,L3,DateEntered) VALUES('16','7070',4,6,1,'2005-12-5 21:16:0')
INSERT INTO dbo.AffiliateHistory (AHID,AFID,L1,L2,L3,DateEntered) VALUES('17','7077',20,25,10,'2005-12-13 17:32:0')
INSERT INTO dbo.AffiliateHistory (AHID,AFID,L1,L2,L3,DateEntered) VALUES('18','7077',8,10,3,'2005-12-13 17:37:0')
INSERT INTO dbo.AffiliateHistory (AHID,AFID,L1,L2,L3,DateEntered) VALUES('19','7084',4,6,1,'2006-6-13 11:41:0')
INSERT INTO dbo.AffiliateHistory (AHID,AFID,L1,L2,L3,DateEntered) VALUES('20','7014',15,20,5,'2007-2-16 12:13:0')
IF (IDENT_SEED('dbo.AffiliateHistory') IS NOT NULL )	SET IDENTITY_INSERT dbo.AffiliateHistory OFF
GO
GO
ALTER TABLE dbo.AffiliateHistory CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.AffiliateOrders
-----------------------------------------------------------
ALTER TABLE dbo.AffiliateOrders NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.AffiliateOrders
GO

IF (IDENT_SEED('dbo.AffiliateOrders') IS NOT NULL )	SET IDENTITY_INSERT dbo.AffiliateOrders ON
IF (IDENT_SEED('dbo.AffiliateOrders') IS NOT NULL )	SET IDENTITY_INSERT dbo.AffiliateOrders OFF
GO
GO
ALTER TABLE dbo.AffiliateOrders CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.AffiliatePayments
-----------------------------------------------------------
ALTER TABLE dbo.AffiliatePayments NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.AffiliatePayments
GO

IF (IDENT_SEED('dbo.AffiliatePayments') IS NOT NULL )	SET IDENTITY_INSERT dbo.AffiliatePayments ON
INSERT INTO dbo.AffiliatePayments (AFPID,AFID,AFPDate,AFPAmount,AFPCheck,AFPComments) VALUES('1','7000','2005-2-5 0:0:0',9.37,'1340',NULL)
INSERT INTO dbo.AffiliatePayments (AFPID,AFID,AFPDate,AFPAmount,AFPCheck,AFPComments) VALUES('2','7007','2005-8-20 0:0:0',12,'1350',NULL)
INSERT INTO dbo.AffiliatePayments (AFPID,AFID,AFPDate,AFPAmount,AFPCheck,AFPComments) VALUES('3','7000','2005-2-6 0:0:0',371.19,'12346','Payment for affiliate blah')
INSERT INTO dbo.AffiliatePayments (AFPID,AFID,AFPDate,AFPAmount,AFPCheck,AFPComments) VALUES('4','7014','2005-12-3 0:0:0',360,'1499',NULL)
INSERT INTO dbo.AffiliatePayments (AFPID,AFID,AFPDate,AFPAmount,AFPCheck,AFPComments) VALUES('5','7035','2005-12-13 0:0:0',400,'1510',NULL)
INSERT INTO dbo.AffiliatePayments (AFPID,AFID,AFPDate,AFPAmount,AFPCheck,AFPComments) VALUES('6','7014','2007-2-16 0:0:0',118.72,'4583',NULL)
IF (IDENT_SEED('dbo.AffiliatePayments') IS NOT NULL )	SET IDENTITY_INSERT dbo.AffiliatePayments OFF
GO
GO
ALTER TABLE dbo.AffiliatePayments CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.Affiliates
-----------------------------------------------------------
ALTER TABLE dbo.Affiliates NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.Affiliates
GO

IF (IDENT_SEED('dbo.Affiliates') IS NOT NULL )	SET IDENTITY_INSERT dbo.Affiliates ON
INSERT INTO dbo.Affiliates (AFID,AffiliateName,CompanyName,FirstName,LastName,Address1,Address2,City,State,Zip,Country,Email,EmailOK,Phone,AltPhone,Fax,WebSiteName,WebSiteURL,WebSiteCategory,OrdersAcceptedBy,ReferralRate,CustomerDiscount,Disabled,IPAddress,Password,Authenticated,Comments,TaxID,SubAffiliateOf,CustomerID,MemberType,PaymentFrequency,EmailPayPal,DateInactive,AffiliateCode,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_LIMIT,QB_TERMS,QB_VTYPE,QB_1099) VALUES('7000',NULL,'MegaColor','Ray','Anderson','4400 Sharon Rd',NULL,'Lake Zurich','FL','33454','US','randerson@meggacolorr.net',1,'580-252-2252',NULL,NULL,'MegaColor','http://www.MeggaColorr.net','Online Store',NULL,0,0,0,'127.0.0.1','6BE1639DFCF18BD295',1,NULL,'20-0210298',NULL,'3843586823','3',NULL,NULL,NULL,NULL,0,'2005-5-4 21:16:0','2006-8-27 23:50:0','Affiliate',NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Affiliates (AFID,AffiliateName,CompanyName,FirstName,LastName,Address1,Address2,City,State,Zip,Country,Email,EmailOK,Phone,AltPhone,Fax,WebSiteName,WebSiteURL,WebSiteCategory,OrdersAcceptedBy,ReferralRate,CustomerDiscount,Disabled,IPAddress,Password,Authenticated,Comments,TaxID,SubAffiliateOf,CustomerID,MemberType,PaymentFrequency,EmailPayPal,DateInactive,AffiliateCode,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_LIMIT,QB_TERMS,QB_VTYPE,QB_1099) VALUES('7007',NULL,'Gourmet Food Corp.','Bill','Scicchitano','9288 State St.',NULL,'Washington','OH','63728','US','orders@cartfusion.net',1,'727-517-0431',NULL,NULL,'Gourmet Food Corp.','http://www.GourmetFoodCorp.com','Retail Store',NULL,0,5,0,NULL,'61EB718EF2FB93',1,NULL,'20-0216967','7000','3868938560','1',NULL,NULL,NULL,NULL,0,'2005-5-7 8:33:0','2005-12-4 22:38:0','MARTY',NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Affiliates (AFID,AffiliateName,CompanyName,FirstName,LastName,Address1,Address2,City,State,Zip,Country,Email,EmailOK,Phone,AltPhone,Fax,WebSiteName,WebSiteURL,WebSiteCategory,OrdersAcceptedBy,ReferralRate,CustomerDiscount,Disabled,IPAddress,Password,Authenticated,Comments,TaxID,SubAffiliateOf,CustomerID,MemberType,PaymentFrequency,EmailPayPal,DateInactive,AffiliateCode,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_LIMIT,QB_TERMS,QB_VTYPE,QB_1099) VALUES('7014',NULL,NULL,'Jim','Cartwright','556 Mountain Ave.',NULL,'Upland','CA','91724','US','marty@tradestudios.com',0,'909-758-8491',NULL,NULL,'Cartwright Professionals','http://www.cartwrightpros.com','Retail Store',NULL,0,0,0,'71.104.14.155','65E57688E8EC8EDA8F2B',1,NULL,NULL,NULL,'3858155224','3',NULL,NULL,NULL,NULL,0,'2005-8-20 19:24:0','2007-2-16 12:13:0','ADMIN',NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Affiliates (AFID,AffiliateName,CompanyName,FirstName,LastName,Address1,Address2,City,State,Zip,Country,Email,EmailOK,Phone,AltPhone,Fax,WebSiteName,WebSiteURL,WebSiteCategory,OrdersAcceptedBy,ReferralRate,CustomerDiscount,Disabled,IPAddress,Password,Authenticated,Comments,TaxID,SubAffiliateOf,CustomerID,MemberType,PaymentFrequency,EmailPayPal,DateInactive,AffiliateCode,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_LIMIT,QB_TERMS,QB_VTYPE,QB_1099) VALUES('7021',NULL,NULL,'Jenny','Summers','409 W. 38th St. #201',NULL,'Michelin','AL','30291','US','jenny@summersaremine.org',1,'283-992-8298',NULL,NULL,NULL,'http://','Online Store',NULL,0,0,0,'71.104.14.155','75F16991FAEC94',1,NULL,NULL,'7000',NULL,'1',NULL,NULL,NULL,NULL,0,'2005-8-20 19:48:0','2005-12-3 9:45:0','ADMIN',NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Affiliates (AFID,AffiliateName,CompanyName,FirstName,LastName,Address1,Address2,City,State,Zip,Country,Email,EmailOK,Phone,AltPhone,Fax,WebSiteName,WebSiteURL,WebSiteCategory,OrdersAcceptedBy,ReferralRate,CustomerDiscount,Disabled,IPAddress,Password,Authenticated,Comments,TaxID,SubAffiliateOf,CustomerID,MemberType,PaymentFrequency,EmailPayPal,DateInactive,AffiliateCode,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_LIMIT,QB_TERMS,QB_VTYPE,QB_1099) VALUES('7028',NULL,'FIRST PAYMENT SOURCE','SHANE','SMITH','145 BAYRIDGE DRIVE',NULL,'WESTON','FL','33326','US','shane@firstpaymentsource.com',0,'954-384-1044',NULL,NULL,'firstpaymentsource.com','http://www.firstpaymentsource.com','Other',NULL,0,0,0,'70.146.103.195','67E86184FCF1D7',0,NULL,NULL,'7035',NULL,'1',NULL,NULL,NULL,NULL,0,'2005-11-22 13:28:0','2005-12-5 21:0:0','MARTY',NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Affiliates (AFID,AffiliateName,CompanyName,FirstName,LastName,Address1,Address2,City,State,Zip,Country,Email,EmailOK,Phone,AltPhone,Fax,WebSiteName,WebSiteURL,WebSiteCategory,OrdersAcceptedBy,ReferralRate,CustomerDiscount,Disabled,IPAddress,Password,Authenticated,Comments,TaxID,SubAffiliateOf,CustomerID,MemberType,PaymentFrequency,EmailPayPal,DateInactive,AffiliateCode,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_LIMIT,QB_TERMS,QB_VTYPE,QB_1099) VALUES('7035',NULL,NULL,'Matthew','Ledger','7 Skyline Drive',NULL,'Pittsburgh','PA','31293','US','mattledger@tradestudios.com',1,'419-261-4897',NULL,NULL,NULL,'http://',NULL,NULL,0,0,0,NULL,'6AE1609BFAEC',1,NULL,NULL,'7000','3868938560','3','0',1,NULL,NULL,0,'2005-12-5 9:7:0','2005-12-5 9:7:0','MARTY',NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Affiliates (AFID,AffiliateName,CompanyName,FirstName,LastName,Address1,Address2,City,State,Zip,Country,Email,EmailOK,Phone,AltPhone,Fax,WebSiteName,WebSiteURL,WebSiteCategory,OrdersAcceptedBy,ReferralRate,CustomerDiscount,Disabled,IPAddress,Password,Authenticated,Comments,TaxID,SubAffiliateOf,CustomerID,MemberType,PaymentFrequency,EmailPayPal,DateInactive,AffiliateCode,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_LIMIT,QB_TERMS,QB_VTYPE,QB_1099) VALUES('7042',NULL,NULL,'Hillary','Hodges','39 A West Bull Blvd.',NULL,'West Hollywood','CA','90209','US','hillaryhodges@tradestudios.com',1,'818-555-5555',NULL,NULL,NULL,'http://',NULL,NULL,0,0,0,NULL,'6EEB609BFAED',1,NULL,NULL,'7035','3847978053','2',NULL,NULL,NULL,NULL,0,'2005-12-5 9:58:0','2005-12-5 22:11:0','MARTY',NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Affiliates (AFID,AffiliateName,CompanyName,FirstName,LastName,Address1,Address2,City,State,Zip,Country,Email,EmailOK,Phone,AltPhone,Fax,WebSiteName,WebSiteURL,WebSiteCategory,OrdersAcceptedBy,ReferralRate,CustomerDiscount,Disabled,IPAddress,Password,Authenticated,Comments,TaxID,SubAffiliateOf,CustomerID,MemberType,PaymentFrequency,EmailPayPal,DateInactive,AffiliateCode,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_LIMIT,QB_TERMS,QB_VTYPE,QB_1099) VALUES('7049',NULL,NULL,'Sheryl','Wayne','900 Municipal Court',NULL,'Los Angeles','CA','90045','US','sheryl@tradestudios.com',1,'310-427-9087',NULL,NULL,NULL,'http://','Online Store',NULL,0,0,0,'127.0.0.1','71E57D92FA',1,NULL,'20-0210297','7021',NULL,'1',NULL,NULL,NULL,NULL,0,'2005-12-5 20:59:0','2005-12-5 21:0:0','MARTY',NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Affiliates (AFID,AffiliateName,CompanyName,FirstName,LastName,Address1,Address2,City,State,Zip,Country,Email,EmailOK,Phone,AltPhone,Fax,WebSiteName,WebSiteURL,WebSiteCategory,OrdersAcceptedBy,ReferralRate,CustomerDiscount,Disabled,IPAddress,Password,Authenticated,Comments,TaxID,SubAffiliateOf,CustomerID,MemberType,PaymentFrequency,EmailPayPal,DateInactive,AffiliateCode,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_LIMIT,QB_TERMS,QB_VTYPE,QB_1099) VALUES('7070',NULL,NULL,'Heidi','Kinta','771 21st Ave.',NULL,'Upland','CA','91784','US','kinta@cartfusion.net',0,'909-758-8492',NULL,NULL,NULL,'http://','Online Store',NULL,0,NULL,0,NULL,'6DED6A88FE',0,NULL,NULL,'7049',NULL,'1','0',1,NULL,NULL,0,'2005-12-5 21:16:0','2005-12-5 21:16:0',NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Affiliates (AFID,AffiliateName,CompanyName,FirstName,LastName,Address1,Address2,City,State,Zip,Country,Email,EmailOK,Phone,AltPhone,Fax,WebSiteName,WebSiteURL,WebSiteCategory,OrdersAcceptedBy,ReferralRate,CustomerDiscount,Disabled,IPAddress,Password,Authenticated,Comments,TaxID,SubAffiliateOf,CustomerID,MemberType,PaymentFrequency,EmailPayPal,DateInactive,AffiliateCode,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_LIMIT,QB_TERMS,QB_VTYPE,QB_1099) VALUES('7077',NULL,'Animated Kid''s Bible','Carl','Vanderpal','133 Hancock Ave.',NULL,'New South Wales','-','5021','AU','carl@cartfusion.net',0,'0112115442938',NULL,NULL,'Animated Kid''s Bible','http://www.animatedkidsbible.com','Online Store',NULL,0,0,0,NULL,'4DF267BFC6ECA685D009B9C3',1,NULL,NULL,'7049','3856057054','2',NULL,NULL,NULL,NULL,0,'2005-12-13 17:32:0','2005-12-13 17:39:0','MARTY',NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Affiliates (AFID,AffiliateName,CompanyName,FirstName,LastName,Address1,Address2,City,State,Zip,Country,Email,EmailOK,Phone,AltPhone,Fax,WebSiteName,WebSiteURL,WebSiteCategory,OrdersAcceptedBy,ReferralRate,CustomerDiscount,Disabled,IPAddress,Password,Authenticated,Comments,TaxID,SubAffiliateOf,CustomerID,MemberType,PaymentFrequency,EmailPayPal,DateInactive,AffiliateCode,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_LIMIT,QB_TERMS,QB_VTYPE,QB_1099) VALUES('7084',NULL,NULL,'Martin','Pearce','1234 Happy Street',NULL,'Orlando','FL','32809','US','tambanadza@yahoo.com',1,'407-123-1458',NULL,NULL,NULL,'http://',NULL,NULL,0,0,0,NULL,'6BEB7D99ECE6948C',1,NULL,NULL,NULL,'3887311854','1',NULL,NULL,NULL,NULL,0,'2006-6-13 11:41:0','2006-8-27 23:21:0','ADMIN',NULL,NULL,NULL,NULL,NULL)
IF (IDENT_SEED('dbo.Affiliates') IS NOT NULL )	SET IDENTITY_INSERT dbo.Affiliates OFF
GO
GO
ALTER TABLE dbo.Affiliates CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.AuthorizeNet
-----------------------------------------------------------
ALTER TABLE dbo.AuthorizeNet NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.AuthorizeNet
GO

IF (IDENT_SEED('dbo.AuthorizeNet') IS NOT NULL )	SET IDENTITY_INSERT dbo.AuthorizeNet ON
INSERT INTO dbo.AuthorizeNet (ID,Login,Hash) VALUES('1','55C747A3EBFB94C9D56EC0','65E57688F9EB94D48831C0C1')
IF (IDENT_SEED('dbo.AuthorizeNet') IS NOT NULL )	SET IDENTITY_INSERT dbo.AuthorizeNet OFF
GO
GO
ALTER TABLE dbo.AuthorizeNet CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.AuthorizeNetTK
-----------------------------------------------------------
ALTER TABLE dbo.AuthorizeNetTK NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.AuthorizeNetTK
GO

IF (IDENT_SEED('dbo.AuthorizeNetTK') IS NOT NULL )	SET IDENTITY_INSERT dbo.AuthorizeNetTK ON
INSERT INTO dbo.AuthorizeNetTK (ID,TransKey,Password) VALUES('1','34C237A9DDFA93DC810EC7C242EFEC90',NULL)
IF (IDENT_SEED('dbo.AuthorizeNetTK') IS NOT NULL )	SET IDENTITY_INSERT dbo.AuthorizeNetTK OFF
GO
GO
ALTER TABLE dbo.AuthorizeNetTK CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.BackOrderItems
-----------------------------------------------------------
ALTER TABLE dbo.BackOrderItems NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.BackOrderItems
GO

IF (IDENT_SEED('dbo.BackOrderItems') IS NOT NULL )	SET IDENTITY_INSERT dbo.BackOrderItems ON
INSERT INTO dbo.BackOrderItems (BOIID,BOID,BOItemID,BOQty,BOItemPrice) VALUES('1','1','23','1',89.99)
INSERT INTO dbo.BackOrderItems (BOIID,BOID,BOItemID,BOQty,BOItemPrice) VALUES('2','2','23','1',89.99)
INSERT INTO dbo.BackOrderItems (BOIID,BOID,BOItemID,BOQty,BOItemPrice) VALUES('3','3','2','1',699.95)
INSERT INTO dbo.BackOrderItems (BOIID,BOID,BOItemID,BOQty,BOItemPrice) VALUES('4','3','5','1',449.99)
INSERT INTO dbo.BackOrderItems (BOIID,BOID,BOItemID,BOQty,BOItemPrice) VALUES('5','4','23','1',89.99)
INSERT INTO dbo.BackOrderItems (BOIID,BOID,BOItemID,BOQty,BOItemPrice) VALUES('6','5','4','1',349.99)
INSERT INTO dbo.BackOrderItems (BOIID,BOID,BOItemID,BOQty,BOItemPrice) VALUES('7','6','4','2',349.99)
INSERT INTO dbo.BackOrderItems (BOIID,BOID,BOItemID,BOQty,BOItemPrice) VALUES('8','7','4','1',349.99)
INSERT INTO dbo.BackOrderItems (BOIID,BOID,BOItemID,BOQty,BOItemPrice) VALUES('9','8','24','2',197.95)
IF (IDENT_SEED('dbo.BackOrderItems') IS NOT NULL )	SET IDENTITY_INSERT dbo.BackOrderItems OFF
GO
GO
ALTER TABLE dbo.BackOrderItems CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.BackOrders
-----------------------------------------------------------
ALTER TABLE dbo.BackOrders NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.BackOrders
GO

IF (IDENT_SEED('dbo.BackOrders') IS NOT NULL )	SET IDENTITY_INSERT dbo.BackOrders ON
INSERT INTO dbo.BackOrders (BOUniqueID,BOID,BOOrderID,BODateEntered,BOTransID,BOTotal,BOCredit,BODiscount) VALUES('1','1','1002707','2005-5-6 0:0:0','1',89.99,0,0)
INSERT INTO dbo.BackOrders (BOUniqueID,BOID,BOOrderID,BODateEntered,BOTransID,BOTotal,BOCredit,BODiscount) VALUES('2','2','1002707','2005-5-6 0:0:0','0',89.99,0,0)
INSERT INTO dbo.BackOrders (BOUniqueID,BOID,BOOrderID,BODateEntered,BOTransID,BOTotal,BOCredit,BODiscount) VALUES('3','3','1002706','2005-5-6 0:0:0','0',1149.94,0,0)
INSERT INTO dbo.BackOrders (BOUniqueID,BOID,BOOrderID,BODateEntered,BOTransID,BOTotal,BOCredit,BODiscount) VALUES('4','4','1002705','2005-5-6 0:0:0','0',76.99,4,8.999)
INSERT INTO dbo.BackOrders (BOUniqueID,BOID,BOOrderID,BODateEntered,BOTransID,BOTotal,BOCredit,BODiscount) VALUES('5','5','1002738','2005-8-22 0:0:0','0',314.99,0,34.999)
INSERT INTO dbo.BackOrders (BOUniqueID,BOID,BOOrderID,BODateEntered,BOTransID,BOTotal,BOCredit,BODiscount) VALUES('6','6','1002759','2005-10-13 0:0:0','0',699.98,0,0)
INSERT INTO dbo.BackOrders (BOUniqueID,BOID,BOOrderID,BODateEntered,BOTransID,BOTotal,BOCredit,BODiscount) VALUES('7','7','1002770','2005-12-3 0:0:0','0',313.99,1,35)
INSERT INTO dbo.BackOrders (BOUniqueID,BOID,BOOrderID,BODateEntered,BOTransID,BOTotal,BOCredit,BODiscount) VALUES('8','8','1002715','2005-12-13 0:0:0','0',356.31,0,39.59)
IF (IDENT_SEED('dbo.BackOrders') IS NOT NULL )	SET IDENTITY_INSERT dbo.BackOrders OFF
GO
GO
ALTER TABLE dbo.BackOrders CHECK CONSTRAINT ALL
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
--Insert data into dbo.Cart
-----------------------------------------------------------
ALTER TABLE dbo.Cart NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.Cart
GO

IF (IDENT_SEED('dbo.Cart') IS NOT NULL )	SET IDENTITY_INSERT dbo.Cart ON
INSERT INTO dbo.Cart (CartItemID,SiteID,CustomerID,SessionID,ItemID,Qty,OptionName1,OptionName2,OptionName3,OptionName4,OptionName5,OptionName6,OptionName7,OptionName8,OptionName9,OptionName10,AffiliateID,BackOrdered,ShippingID,ShippingMethod,ShippingCodesAvailable,ShippingCodesUsed,ShippingCodeAmount,ShippingAmount,HandlingAmount,DateEntered) VALUES('660','1','3917045461','21138117','15','1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'0',NULL,NULL,NULL,NULL,NULL,NULL,'2007-3-29 18:15:0')
INSERT INTO dbo.Cart (CartItemID,SiteID,CustomerID,SessionID,ItemID,Qty,OptionName1,OptionName2,OptionName3,OptionName4,OptionName5,OptionName6,OptionName7,OptionName8,OptionName9,OptionName10,AffiliateID,BackOrdered,ShippingID,ShippingMethod,ShippingCodesAvailable,ShippingCodesUsed,ShippingCodeAmount,ShippingAmount,HandlingAmount,DateEntered) VALUES('661','1','3917045461','21138117','33','1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'45',NULL,NULL,NULL,NULL,NULL,NULL,'2007-3-29 18:16:0')
INSERT INTO dbo.Cart (CartItemID,SiteID,CustomerID,SessionID,ItemID,Qty,OptionName1,OptionName2,OptionName3,OptionName4,OptionName5,OptionName6,OptionName7,OptionName8,OptionName9,OptionName10,AffiliateID,BackOrdered,ShippingID,ShippingMethod,ShippingCodesAvailable,ShippingCodesUsed,ShippingCodeAmount,ShippingAmount,HandlingAmount,DateEntered) VALUES('662','1','3917045461','21138117','28','1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'47',NULL,NULL,NULL,NULL,NULL,NULL,'2007-3-29 18:16:0')
INSERT INTO dbo.Cart (CartItemID,SiteID,CustomerID,SessionID,ItemID,Qty,OptionName1,OptionName2,OptionName3,OptionName4,OptionName5,OptionName6,OptionName7,OptionName8,OptionName9,OptionName10,AffiliateID,BackOrdered,ShippingID,ShippingMethod,ShippingCodesAvailable,ShippingCodesUsed,ShippingCodeAmount,ShippingAmount,HandlingAmount,DateEntered) VALUES('663','1','3917045461','21138117','29','1','Black','Medium',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'46',NULL,NULL,NULL,NULL,NULL,NULL,'2007-3-29 18:16:0')
INSERT INTO dbo.Cart (CartItemID,SiteID,CustomerID,SessionID,ItemID,Qty,OptionName1,OptionName2,OptionName3,OptionName4,OptionName5,OptionName6,OptionName7,OptionName8,OptionName9,OptionName10,AffiliateID,BackOrdered,ShippingID,ShippingMethod,ShippingCodesAvailable,ShippingCodesUsed,ShippingCodeAmount,ShippingAmount,HandlingAmount,DateEntered) VALUES('664','1','3917045461','21138117','31','1','Olive','One Size Fits All',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'0',NULL,NULL,NULL,NULL,NULL,NULL,'2007-3-29 18:40:0')
INSERT INTO dbo.Cart (CartItemID,SiteID,CustomerID,SessionID,ItemID,Qty,OptionName1,OptionName2,OptionName3,OptionName4,OptionName5,OptionName6,OptionName7,OptionName8,OptionName9,OptionName10,AffiliateID,BackOrdered,ShippingID,ShippingMethod,ShippingCodesAvailable,ShippingCodesUsed,ShippingCodeAmount,ShippingAmount,HandlingAmount,DateEntered) VALUES('665','1','3917045461','21138117','30','1','Black','Small',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'45',NULL,NULL,NULL,NULL,NULL,NULL,'2007-3-29 18:40:0')
INSERT INTO dbo.Cart (CartItemID,SiteID,CustomerID,SessionID,ItemID,Qty,OptionName1,OptionName2,OptionName3,OptionName4,OptionName5,OptionName6,OptionName7,OptionName8,OptionName9,OptionName10,AffiliateID,BackOrdered,ShippingID,ShippingMethod,ShippingCodesAvailable,ShippingCodesUsed,ShippingCodeAmount,ShippingAmount,HandlingAmount,DateEntered) VALUES('666','1','3917017733','21118516','20','1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'51',NULL,NULL,NULL,NULL,NULL,NULL,'2007-3-30 11:28:0')
INSERT INTO dbo.Cart (CartItemID,SiteID,CustomerID,SessionID,ItemID,Qty,OptionName1,OptionName2,OptionName3,OptionName4,OptionName5,OptionName6,OptionName7,OptionName8,OptionName9,OptionName10,AffiliateID,BackOrdered,ShippingID,ShippingMethod,ShippingCodesAvailable,ShippingCodesUsed,ShippingCodeAmount,ShippingAmount,HandlingAmount,DateEntered) VALUES('667','1','3917017733','21118516','8','1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'48',NULL,NULL,NULL,NULL,NULL,NULL,'2007-3-30 11:52:0')
INSERT INTO dbo.Cart (CartItemID,SiteID,CustomerID,SessionID,ItemID,Qty,OptionName1,OptionName2,OptionName3,OptionName4,OptionName5,OptionName6,OptionName7,OptionName8,OptionName9,OptionName10,AffiliateID,BackOrdered,ShippingID,ShippingMethod,ShippingCodesAvailable,ShippingCodesUsed,ShippingCodeAmount,ShippingAmount,HandlingAmount,DateEntered) VALUES('668','1','3917017733','21118516','32','1','Forest Green',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'49',NULL,NULL,NULL,NULL,NULL,NULL,'2007-3-30 11:53:0')
INSERT INTO dbo.Cart (CartItemID,SiteID,CustomerID,SessionID,ItemID,Qty,OptionName1,OptionName2,OptionName3,OptionName4,OptionName5,OptionName6,OptionName7,OptionName8,OptionName9,OptionName10,AffiliateID,BackOrdered,ShippingID,ShippingMethod,ShippingCodesAvailable,ShippingCodesUsed,ShippingCodeAmount,ShippingAmount,HandlingAmount,DateEntered) VALUES('669','1','3917017733','21118516','32','1','Red',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'50',NULL,NULL,NULL,NULL,NULL,NULL,'2007-3-30 11:53:0')
INSERT INTO dbo.Cart (CartItemID,SiteID,CustomerID,SessionID,ItemID,Qty,OptionName1,OptionName2,OptionName3,OptionName4,OptionName5,OptionName6,OptionName7,OptionName8,OptionName9,OptionName10,AffiliateID,BackOrdered,ShippingID,ShippingMethod,ShippingCodesAvailable,ShippingCodesUsed,ShippingCodeAmount,ShippingAmount,HandlingAmount,DateEntered) VALUES('670','1',NULL,'75757505','33','1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'0',NULL,NULL,NULL,NULL,NULL,NULL,'2007-4-18 9:20:0')
INSERT INTO dbo.Cart (CartItemID,SiteID,CustomerID,SessionID,ItemID,Qty,OptionName1,OptionName2,OptionName3,OptionName4,OptionName5,OptionName6,OptionName7,OptionName8,OptionName9,OptionName10,AffiliateID,BackOrdered,ShippingID,ShippingMethod,ShippingCodesAvailable,ShippingCodesUsed,ShippingCodeAmount,ShippingAmount,HandlingAmount,DateEntered) VALUES('671','1',NULL,'96704762','29','1','Brown','Small',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'0',NULL,NULL,NULL,NULL,NULL,NULL,'2007-4-19 11:59:0')
INSERT INTO dbo.Cart (CartItemID,SiteID,CustomerID,SessionID,ItemID,Qty,OptionName1,OptionName2,OptionName3,OptionName4,OptionName5,OptionName6,OptionName7,OptionName8,OptionName9,OptionName10,AffiliateID,BackOrdered,ShippingID,ShippingMethod,ShippingCodesAvailable,ShippingCodesUsed,ShippingCodeAmount,ShippingAmount,HandlingAmount,DateEntered) VALUES('672','1',NULL,'12425182','32','1','Black',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'0',NULL,NULL,NULL,NULL,NULL,NULL,'2007-5-7 7:31:0')
INSERT INTO dbo.Cart (CartItemID,SiteID,CustomerID,SessionID,ItemID,Qty,OptionName1,OptionName2,OptionName3,OptionName4,OptionName5,OptionName6,OptionName7,OptionName8,OptionName9,OptionName10,AffiliateID,BackOrdered,ShippingID,ShippingMethod,ShippingCodesAvailable,ShippingCodesUsed,ShippingCodeAmount,ShippingAmount,HandlingAmount,DateEntered) VALUES('673','1',NULL,'51235043','33','1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'0',NULL,NULL,NULL,NULL,NULL,NULL,'2007-5-8 10:21:0')
IF (IDENT_SEED('dbo.Cart') IS NOT NULL )	SET IDENTITY_INSERT dbo.Cart OFF
GO
GO
ALTER TABLE dbo.Cart CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.Categories
-----------------------------------------------------------
ALTER TABLE dbo.Categories NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.Categories
GO

IF (IDENT_SEED('dbo.Categories') IS NOT NULL )	SET IDENTITY_INSERT dbo.Categories ON
INSERT INTO dbo.Categories (CatID,SiteID,CatName,CatSummary,CatDescription,CatImage,CatImageDir,CatFeaturedID,CatFeaturedDir,CatBanner,CKeywords,CDescription,ShowColumns,ShowRows,DisplayPrefix,SortByLooks,DisplayOrder,CategoryDisplayFormatID,AllowCategoryFiltering,AllowManufacturerFiltering,AllowProductTypeFiltering,Published,Comments,AvailableSections,SubCategoryOf,Featured,RProSID,rdi_date_removed,Hide1,Hide2,CatMetaTitle,CatMetaDescription,CatMetaKeywords,CatMetaKeyphrases,Deleted,DateCreated,DateUpdated,UpdatedBy) VALUES('1','1','Camera Brands',NULL,NULL,NULL,NULL,NULL,'categories',NULL,NULL,NULL,'3','5',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,0,NULL,NULL,NULL,NULL,0,'2005-3-24 14:37:0',NULL,'ADMIN')
INSERT INTO dbo.Categories (CatID,SiteID,CatName,CatSummary,CatDescription,CatImage,CatImageDir,CatFeaturedID,CatFeaturedDir,CatBanner,CKeywords,CDescription,ShowColumns,ShowRows,DisplayPrefix,SortByLooks,DisplayOrder,CategoryDisplayFormatID,AllowCategoryFiltering,AllowManufacturerFiltering,AllowProductTypeFiltering,Published,Comments,AvailableSections,SubCategoryOf,Featured,RProSID,rdi_date_removed,Hide1,Hide2,CatMetaTitle,CatMetaDescription,CatMetaKeywords,CatMetaKeyphrases,Deleted,DateCreated,DateUpdated,UpdatedBy) VALUES('2','1','Canon',NULL,NULL,NULL,NULL,'canon.gif','categories',NULL,NULL,NULL,'3','5',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1',0,NULL,NULL,0,0,NULL,NULL,NULL,NULL,0,'2005-3-24 14:37:0','2005-5-1 21:50:0','ADMIN')
INSERT INTO dbo.Categories (CatID,SiteID,CatName,CatSummary,CatDescription,CatImage,CatImageDir,CatFeaturedID,CatFeaturedDir,CatBanner,CKeywords,CDescription,ShowColumns,ShowRows,DisplayPrefix,SortByLooks,DisplayOrder,CategoryDisplayFormatID,AllowCategoryFiltering,AllowManufacturerFiltering,AllowProductTypeFiltering,Published,Comments,AvailableSections,SubCategoryOf,Featured,RProSID,rdi_date_removed,Hide1,Hide2,CatMetaTitle,CatMetaDescription,CatMetaKeywords,CatMetaKeyphrases,Deleted,DateCreated,DateUpdated,UpdatedBy) VALUES('3','1','Casio',NULL,NULL,NULL,NULL,'casio.gif','categories',NULL,NULL,NULL,'3','5',NULL,NULL,'2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1',0,NULL,NULL,0,0,NULL,NULL,NULL,NULL,0,'2005-3-24 14:37:0','2005-5-1 22:16:0','ADMIN')
INSERT INTO dbo.Categories (CatID,SiteID,CatName,CatSummary,CatDescription,CatImage,CatImageDir,CatFeaturedID,CatFeaturedDir,CatBanner,CKeywords,CDescription,ShowColumns,ShowRows,DisplayPrefix,SortByLooks,DisplayOrder,CategoryDisplayFormatID,AllowCategoryFiltering,AllowManufacturerFiltering,AllowProductTypeFiltering,Published,Comments,AvailableSections,SubCategoryOf,Featured,RProSID,rdi_date_removed,Hide1,Hide2,CatMetaTitle,CatMetaDescription,CatMetaKeywords,CatMetaKeyphrases,Deleted,DateCreated,DateUpdated,UpdatedBy) VALUES('4','1','Fuji',NULL,NULL,NULL,NULL,'fuji.gif','categories',NULL,NULL,NULL,'3','5',NULL,NULL,'3',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1',0,NULL,NULL,0,0,NULL,NULL,NULL,NULL,0,'2005-3-24 14:38:0',NULL,'ADMIN')
INSERT INTO dbo.Categories (CatID,SiteID,CatName,CatSummary,CatDescription,CatImage,CatImageDir,CatFeaturedID,CatFeaturedDir,CatBanner,CKeywords,CDescription,ShowColumns,ShowRows,DisplayPrefix,SortByLooks,DisplayOrder,CategoryDisplayFormatID,AllowCategoryFiltering,AllowManufacturerFiltering,AllowProductTypeFiltering,Published,Comments,AvailableSections,SubCategoryOf,Featured,RProSID,rdi_date_removed,Hide1,Hide2,CatMetaTitle,CatMetaDescription,CatMetaKeywords,CatMetaKeyphrases,Deleted,DateCreated,DateUpdated,UpdatedBy) VALUES('5','1','Hewlett Packard',NULL,NULL,NULL,NULL,'hewlettpackard.gif','categories',NULL,NULL,NULL,'3','5',NULL,NULL,'4',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1',0,NULL,NULL,0,0,NULL,NULL,NULL,NULL,0,'2005-3-24 14:39:0',NULL,'ADMIN')
INSERT INTO dbo.Categories (CatID,SiteID,CatName,CatSummary,CatDescription,CatImage,CatImageDir,CatFeaturedID,CatFeaturedDir,CatBanner,CKeywords,CDescription,ShowColumns,ShowRows,DisplayPrefix,SortByLooks,DisplayOrder,CategoryDisplayFormatID,AllowCategoryFiltering,AllowManufacturerFiltering,AllowProductTypeFiltering,Published,Comments,AvailableSections,SubCategoryOf,Featured,RProSID,rdi_date_removed,Hide1,Hide2,CatMetaTitle,CatMetaDescription,CatMetaKeywords,CatMetaKeyphrases,Deleted,DateCreated,DateUpdated,UpdatedBy) VALUES('6','1','Kodak',NULL,NULL,NULL,NULL,'kodak.gif','categories',NULL,NULL,NULL,'3','5',NULL,NULL,'5',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1',0,NULL,NULL,0,0,NULL,NULL,NULL,NULL,0,'2005-3-24 14:39:0',NULL,'ADMIN')
INSERT INTO dbo.Categories (CatID,SiteID,CatName,CatSummary,CatDescription,CatImage,CatImageDir,CatFeaturedID,CatFeaturedDir,CatBanner,CKeywords,CDescription,ShowColumns,ShowRows,DisplayPrefix,SortByLooks,DisplayOrder,CategoryDisplayFormatID,AllowCategoryFiltering,AllowManufacturerFiltering,AllowProductTypeFiltering,Published,Comments,AvailableSections,SubCategoryOf,Featured,RProSID,rdi_date_removed,Hide1,Hide2,CatMetaTitle,CatMetaDescription,CatMetaKeywords,CatMetaKeyphrases,Deleted,DateCreated,DateUpdated,UpdatedBy) VALUES('7','1','Konica Minolta',NULL,NULL,NULL,NULL,'konicaminolta.gif','categories',NULL,NULL,NULL,'3','5',NULL,NULL,'6',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1',0,NULL,NULL,0,0,NULL,NULL,NULL,NULL,0,'2005-3-24 14:40:0',NULL,'ADMIN')
INSERT INTO dbo.Categories (CatID,SiteID,CatName,CatSummary,CatDescription,CatImage,CatImageDir,CatFeaturedID,CatFeaturedDir,CatBanner,CKeywords,CDescription,ShowColumns,ShowRows,DisplayPrefix,SortByLooks,DisplayOrder,CategoryDisplayFormatID,AllowCategoryFiltering,AllowManufacturerFiltering,AllowProductTypeFiltering,Published,Comments,AvailableSections,SubCategoryOf,Featured,RProSID,rdi_date_removed,Hide1,Hide2,CatMetaTitle,CatMetaDescription,CatMetaKeywords,CatMetaKeyphrases,Deleted,DateCreated,DateUpdated,UpdatedBy) VALUES('8','1','Nikon',NULL,NULL,NULL,NULL,'nikon.gif','categories',NULL,NULL,NULL,'3','5',NULL,NULL,'7',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1',0,NULL,NULL,0,0,NULL,NULL,NULL,NULL,0,'2005-3-24 14:40:0','2005-5-1 22:18:0','ADMIN')
INSERT INTO dbo.Categories (CatID,SiteID,CatName,CatSummary,CatDescription,CatImage,CatImageDir,CatFeaturedID,CatFeaturedDir,CatBanner,CKeywords,CDescription,ShowColumns,ShowRows,DisplayPrefix,SortByLooks,DisplayOrder,CategoryDisplayFormatID,AllowCategoryFiltering,AllowManufacturerFiltering,AllowProductTypeFiltering,Published,Comments,AvailableSections,SubCategoryOf,Featured,RProSID,rdi_date_removed,Hide1,Hide2,CatMetaTitle,CatMetaDescription,CatMetaKeywords,CatMetaKeyphrases,Deleted,DateCreated,DateUpdated,UpdatedBy) VALUES('9','1','Olympus',NULL,NULL,NULL,NULL,'olympus.gif','categories',NULL,NULL,NULL,'3','5',NULL,NULL,'8',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1',0,NULL,NULL,0,0,NULL,NULL,NULL,NULL,0,'2005-3-24 14:41:0',NULL,'ADMIN')
INSERT INTO dbo.Categories (CatID,SiteID,CatName,CatSummary,CatDescription,CatImage,CatImageDir,CatFeaturedID,CatFeaturedDir,CatBanner,CKeywords,CDescription,ShowColumns,ShowRows,DisplayPrefix,SortByLooks,DisplayOrder,CategoryDisplayFormatID,AllowCategoryFiltering,AllowManufacturerFiltering,AllowProductTypeFiltering,Published,Comments,AvailableSections,SubCategoryOf,Featured,RProSID,rdi_date_removed,Hide1,Hide2,CatMetaTitle,CatMetaDescription,CatMetaKeywords,CatMetaKeyphrases,Deleted,DateCreated,DateUpdated,UpdatedBy) VALUES('10','1','Pentax',NULL,NULL,NULL,NULL,'pentax.gif','categories',NULL,NULL,NULL,'3','5',NULL,NULL,'9',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1',0,NULL,NULL,0,0,NULL,NULL,NULL,NULL,0,'2005-3-24 14:41:0','2005-5-1 22:18:0','ADMIN')
INSERT INTO dbo.Categories (CatID,SiteID,CatName,CatSummary,CatDescription,CatImage,CatImageDir,CatFeaturedID,CatFeaturedDir,CatBanner,CKeywords,CDescription,ShowColumns,ShowRows,DisplayPrefix,SortByLooks,DisplayOrder,CategoryDisplayFormatID,AllowCategoryFiltering,AllowManufacturerFiltering,AllowProductTypeFiltering,Published,Comments,AvailableSections,SubCategoryOf,Featured,RProSID,rdi_date_removed,Hide1,Hide2,CatMetaTitle,CatMetaDescription,CatMetaKeywords,CatMetaKeyphrases,Deleted,DateCreated,DateUpdated,UpdatedBy) VALUES('11','1','Sony',NULL,NULL,NULL,NULL,'sony.gif','categories',NULL,NULL,NULL,'3','5',NULL,NULL,'10',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1',0,NULL,NULL,0,0,NULL,NULL,NULL,NULL,0,'2005-3-24 14:41:0','2005-5-1 22:17:0','ADMIN')
INSERT INTO dbo.Categories (CatID,SiteID,CatName,CatSummary,CatDescription,CatImage,CatImageDir,CatFeaturedID,CatFeaturedDir,CatBanner,CKeywords,CDescription,ShowColumns,ShowRows,DisplayPrefix,SortByLooks,DisplayOrder,CategoryDisplayFormatID,AllowCategoryFiltering,AllowManufacturerFiltering,AllowProductTypeFiltering,Published,Comments,AvailableSections,SubCategoryOf,Featured,RProSID,rdi_date_removed,Hide1,Hide2,CatMetaTitle,CatMetaDescription,CatMetaKeywords,CatMetaKeyphrases,Deleted,DateCreated,DateUpdated,UpdatedBy) VALUES('12','1','Price Range',NULL,NULL,NULL,NULL,NULL,'categories',NULL,NULL,NULL,'3','5',NULL,NULL,'2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0',0,NULL,NULL,0,0,NULL,NULL,NULL,NULL,0,'2005-3-24 14:42:0',NULL,'ADMIN')
INSERT INTO dbo.Categories (CatID,SiteID,CatName,CatSummary,CatDescription,CatImage,CatImageDir,CatFeaturedID,CatFeaturedDir,CatBanner,CKeywords,CDescription,ShowColumns,ShowRows,DisplayPrefix,SortByLooks,DisplayOrder,CategoryDisplayFormatID,AllowCategoryFiltering,AllowManufacturerFiltering,AllowProductTypeFiltering,Published,Comments,AvailableSections,SubCategoryOf,Featured,RProSID,rdi_date_removed,Hide1,Hide2,CatMetaTitle,CatMetaDescription,CatMetaKeywords,CatMetaKeyphrases,Deleted,DateCreated,DateUpdated,UpdatedBy) VALUES('13','1','Under $200',NULL,'Only the finest beers from one of the finest beer-making countries -- Germany',NULL,NULL,NULL,'categories',NULL,NULL,NULL,'3','5',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'12',0,NULL,NULL,0,0,NULL,NULL,NULL,NULL,0,'2005-3-24 14:42:0','2005-3-24 21:0:0','ADMIN')
INSERT INTO dbo.Categories (CatID,SiteID,CatName,CatSummary,CatDescription,CatImage,CatImageDir,CatFeaturedID,CatFeaturedDir,CatBanner,CKeywords,CDescription,ShowColumns,ShowRows,DisplayPrefix,SortByLooks,DisplayOrder,CategoryDisplayFormatID,AllowCategoryFiltering,AllowManufacturerFiltering,AllowProductTypeFiltering,Published,Comments,AvailableSections,SubCategoryOf,Featured,RProSID,rdi_date_removed,Hide1,Hide2,CatMetaTitle,CatMetaDescription,CatMetaKeywords,CatMetaKeyphrases,Deleted,DateCreated,DateUpdated,UpdatedBy) VALUES('14','1','$200-$300',NULL,'<p>Affordable Digital Cameras between $200 and $300</p>',NULL,NULL,NULL,'categories',NULL,NULL,NULL,'3','5',NULL,NULL,'2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'12',NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,0,'2005-3-24 14:42:0','2006-12-9 19:26:0','ADMIN')
INSERT INTO dbo.Categories (CatID,SiteID,CatName,CatSummary,CatDescription,CatImage,CatImageDir,CatFeaturedID,CatFeaturedDir,CatBanner,CKeywords,CDescription,ShowColumns,ShowRows,DisplayPrefix,SortByLooks,DisplayOrder,CategoryDisplayFormatID,AllowCategoryFiltering,AllowManufacturerFiltering,AllowProductTypeFiltering,Published,Comments,AvailableSections,SubCategoryOf,Featured,RProSID,rdi_date_removed,Hide1,Hide2,CatMetaTitle,CatMetaDescription,CatMetaKeywords,CatMetaKeyphrases,Deleted,DateCreated,DateUpdated,UpdatedBy) VALUES('15','1','$300-$400',NULL,NULL,NULL,NULL,NULL,'categories',NULL,NULL,NULL,'3','5',NULL,NULL,'3',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'12',0,NULL,NULL,0,0,NULL,NULL,NULL,NULL,0,'2005-3-24 14:43:0',NULL,'ADMIN')
INSERT INTO dbo.Categories (CatID,SiteID,CatName,CatSummary,CatDescription,CatImage,CatImageDir,CatFeaturedID,CatFeaturedDir,CatBanner,CKeywords,CDescription,ShowColumns,ShowRows,DisplayPrefix,SortByLooks,DisplayOrder,CategoryDisplayFormatID,AllowCategoryFiltering,AllowManufacturerFiltering,AllowProductTypeFiltering,Published,Comments,AvailableSections,SubCategoryOf,Featured,RProSID,rdi_date_removed,Hide1,Hide2,CatMetaTitle,CatMetaDescription,CatMetaKeywords,CatMetaKeyphrases,Deleted,DateCreated,DateUpdated,UpdatedBy) VALUES('16','1','$400-$500',NULL,NULL,NULL,NULL,NULL,'categories',NULL,NULL,NULL,'3','5',NULL,NULL,'3',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'12',0,NULL,NULL,0,0,NULL,NULL,NULL,NULL,0,'2005-3-24 14:43:0','2005-12-9 15:43:0','MARTY')
INSERT INTO dbo.Categories (CatID,SiteID,CatName,CatSummary,CatDescription,CatImage,CatImageDir,CatFeaturedID,CatFeaturedDir,CatBanner,CKeywords,CDescription,ShowColumns,ShowRows,DisplayPrefix,SortByLooks,DisplayOrder,CategoryDisplayFormatID,AllowCategoryFiltering,AllowManufacturerFiltering,AllowProductTypeFiltering,Published,Comments,AvailableSections,SubCategoryOf,Featured,RProSID,rdi_date_removed,Hide1,Hide2,CatMetaTitle,CatMetaDescription,CatMetaKeywords,CatMetaKeyphrases,Deleted,DateCreated,DateUpdated,UpdatedBy) VALUES('17','1','$500-$600',NULL,NULL,NULL,NULL,NULL,'categories',NULL,NULL,NULL,'3','5',NULL,NULL,'4',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'12',0,NULL,NULL,0,0,NULL,NULL,NULL,NULL,0,'2005-3-24 14:43:0',NULL,'ADMIN')
INSERT INTO dbo.Categories (CatID,SiteID,CatName,CatSummary,CatDescription,CatImage,CatImageDir,CatFeaturedID,CatFeaturedDir,CatBanner,CKeywords,CDescription,ShowColumns,ShowRows,DisplayPrefix,SortByLooks,DisplayOrder,CategoryDisplayFormatID,AllowCategoryFiltering,AllowManufacturerFiltering,AllowProductTypeFiltering,Published,Comments,AvailableSections,SubCategoryOf,Featured,RProSID,rdi_date_removed,Hide1,Hide2,CatMetaTitle,CatMetaDescription,CatMetaKeywords,CatMetaKeyphrases,Deleted,DateCreated,DateUpdated,UpdatedBy) VALUES('18','1','$600-$750',NULL,NULL,NULL,NULL,NULL,'categories',NULL,NULL,NULL,'3','5',NULL,NULL,'5',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'12',0,NULL,NULL,0,0,NULL,NULL,NULL,NULL,0,'2005-3-24 14:44:0','2005-5-1 21:49:0','ADMIN')
INSERT INTO dbo.Categories (CatID,SiteID,CatName,CatSummary,CatDescription,CatImage,CatImageDir,CatFeaturedID,CatFeaturedDir,CatBanner,CKeywords,CDescription,ShowColumns,ShowRows,DisplayPrefix,SortByLooks,DisplayOrder,CategoryDisplayFormatID,AllowCategoryFiltering,AllowManufacturerFiltering,AllowProductTypeFiltering,Published,Comments,AvailableSections,SubCategoryOf,Featured,RProSID,rdi_date_removed,Hide1,Hide2,CatMetaTitle,CatMetaDescription,CatMetaKeywords,CatMetaKeyphrases,Deleted,DateCreated,DateUpdated,UpdatedBy) VALUES('19','1','Over $750',NULL,NULL,NULL,NULL,NULL,'categories',NULL,NULL,NULL,'3','5',NULL,NULL,'6',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'12',0,NULL,NULL,0,0,NULL,NULL,NULL,NULL,0,'2005-3-24 14:44:0',NULL,'ADMIN')
INSERT INTO dbo.Categories (CatID,SiteID,CatName,CatSummary,CatDescription,CatImage,CatImageDir,CatFeaturedID,CatFeaturedDir,CatBanner,CKeywords,CDescription,ShowColumns,ShowRows,DisplayPrefix,SortByLooks,DisplayOrder,CategoryDisplayFormatID,AllowCategoryFiltering,AllowManufacturerFiltering,AllowProductTypeFiltering,Published,Comments,AvailableSections,SubCategoryOf,Featured,RProSID,rdi_date_removed,Hide1,Hide2,CatMetaTitle,CatMetaDescription,CatMetaKeywords,CatMetaKeyphrases,Deleted,DateCreated,DateUpdated,UpdatedBy) VALUES('20','1','ELPH',NULL,NULL,NULL,NULL,'elph.jpg','categories',NULL,NULL,NULL,'3','5',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2',0,NULL,NULL,0,0,NULL,NULL,NULL,NULL,0,'2005-3-24 14:45:0','2005-5-1 22:16:0','ADMIN')
INSERT INTO dbo.Categories (CatID,SiteID,CatName,CatSummary,CatDescription,CatImage,CatImageDir,CatFeaturedID,CatFeaturedDir,CatBanner,CKeywords,CDescription,ShowColumns,ShowRows,DisplayPrefix,SortByLooks,DisplayOrder,CategoryDisplayFormatID,AllowCategoryFiltering,AllowManufacturerFiltering,AllowProductTypeFiltering,Published,Comments,AvailableSections,SubCategoryOf,Featured,RProSID,rdi_date_removed,Hide1,Hide2,CatMetaTitle,CatMetaDescription,CatMetaKeywords,CatMetaKeyphrases,Deleted,DateCreated,DateUpdated,UpdatedBy) VALUES('21','1','EOS',NULL,NULL,NULL,NULL,'eos.gif','categories',NULL,NULL,NULL,'3','5',NULL,NULL,'2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2',0,NULL,NULL,0,0,NULL,NULL,NULL,NULL,0,'2005-3-24 14:45:0','2005-5-1 22:17:0','ADMIN')
INSERT INTO dbo.Categories (CatID,SiteID,CatName,CatSummary,CatDescription,CatImage,CatImageDir,CatFeaturedID,CatFeaturedDir,CatBanner,CKeywords,CDescription,ShowColumns,ShowRows,DisplayPrefix,SortByLooks,DisplayOrder,CategoryDisplayFormatID,AllowCategoryFiltering,AllowManufacturerFiltering,AllowProductTypeFiltering,Published,Comments,AvailableSections,SubCategoryOf,Featured,RProSID,rdi_date_removed,Hide1,Hide2,CatMetaTitle,CatMetaDescription,CatMetaKeywords,CatMetaKeyphrases,Deleted,DateCreated,DateUpdated,UpdatedBy) VALUES('22','1','PowerShot',NULL,NULL,NULL,NULL,'powershot.jpg','categories',NULL,NULL,NULL,'3','5',NULL,NULL,'3',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2',0,NULL,NULL,0,0,NULL,NULL,NULL,NULL,0,'2005-3-24 14:46:0','2005-5-1 22:17:0','ADMIN')
INSERT INTO dbo.Categories (CatID,SiteID,CatName,CatSummary,CatDescription,CatImage,CatImageDir,CatFeaturedID,CatFeaturedDir,CatBanner,CKeywords,CDescription,ShowColumns,ShowRows,DisplayPrefix,SortByLooks,DisplayOrder,CategoryDisplayFormatID,AllowCategoryFiltering,AllowManufacturerFiltering,AllowProductTypeFiltering,Published,Comments,AvailableSections,SubCategoryOf,Featured,RProSID,rdi_date_removed,Hide1,Hide2,CatMetaTitle,CatMetaDescription,CatMetaKeywords,CatMetaKeyphrases,Deleted,DateCreated,DateUpdated,UpdatedBy) VALUES('23','1','Megapixels',NULL,NULL,NULL,NULL,NULL,'categories',NULL,NULL,NULL,'3','5',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,0,0,NULL,NULL,NULL,NULL,0,'2005-4-29 15:58:0',NULL,'ADMIN')
INSERT INTO dbo.Categories (CatID,SiteID,CatName,CatSummary,CatDescription,CatImage,CatImageDir,CatFeaturedID,CatFeaturedDir,CatBanner,CKeywords,CDescription,ShowColumns,ShowRows,DisplayPrefix,SortByLooks,DisplayOrder,CategoryDisplayFormatID,AllowCategoryFiltering,AllowManufacturerFiltering,AllowProductTypeFiltering,Published,Comments,AvailableSections,SubCategoryOf,Featured,RProSID,rdi_date_removed,Hide1,Hide2,CatMetaTitle,CatMetaDescription,CatMetaKeywords,CatMetaKeyphrases,Deleted,DateCreated,DateUpdated,UpdatedBy) VALUES('24','1','2 Megapixels',NULL,NULL,NULL,NULL,NULL,'categories',NULL,NULL,NULL,'3','5',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'23',0,NULL,NULL,0,0,NULL,NULL,NULL,NULL,0,'2005-4-29 15:58:0',NULL,'ADMIN')
INSERT INTO dbo.Categories (CatID,SiteID,CatName,CatSummary,CatDescription,CatImage,CatImageDir,CatFeaturedID,CatFeaturedDir,CatBanner,CKeywords,CDescription,ShowColumns,ShowRows,DisplayPrefix,SortByLooks,DisplayOrder,CategoryDisplayFormatID,AllowCategoryFiltering,AllowManufacturerFiltering,AllowProductTypeFiltering,Published,Comments,AvailableSections,SubCategoryOf,Featured,RProSID,rdi_date_removed,Hide1,Hide2,CatMetaTitle,CatMetaDescription,CatMetaKeywords,CatMetaKeyphrases,Deleted,DateCreated,DateUpdated,UpdatedBy) VALUES('25','1','3 Megapixels',NULL,NULL,NULL,NULL,NULL,'categories',NULL,NULL,NULL,'3','5',NULL,NULL,'2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'23',NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,0,'2005-4-29 15:59:0','2006-12-9 19:47:0','ADMIN')
INSERT INTO dbo.Categories (CatID,SiteID,CatName,CatSummary,CatDescription,CatImage,CatImageDir,CatFeaturedID,CatFeaturedDir,CatBanner,CKeywords,CDescription,ShowColumns,ShowRows,DisplayPrefix,SortByLooks,DisplayOrder,CategoryDisplayFormatID,AllowCategoryFiltering,AllowManufacturerFiltering,AllowProductTypeFiltering,Published,Comments,AvailableSections,SubCategoryOf,Featured,RProSID,rdi_date_removed,Hide1,Hide2,CatMetaTitle,CatMetaDescription,CatMetaKeywords,CatMetaKeyphrases,Deleted,DateCreated,DateUpdated,UpdatedBy) VALUES('26','1','4 Megapixels',NULL,NULL,NULL,NULL,NULL,'categories',NULL,NULL,NULL,'3','5',NULL,NULL,'3',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'23',0,NULL,NULL,0,0,NULL,NULL,NULL,NULL,0,'2005-4-29 15:59:0',NULL,'ADMIN')
INSERT INTO dbo.Categories (CatID,SiteID,CatName,CatSummary,CatDescription,CatImage,CatImageDir,CatFeaturedID,CatFeaturedDir,CatBanner,CKeywords,CDescription,ShowColumns,ShowRows,DisplayPrefix,SortByLooks,DisplayOrder,CategoryDisplayFormatID,AllowCategoryFiltering,AllowManufacturerFiltering,AllowProductTypeFiltering,Published,Comments,AvailableSections,SubCategoryOf,Featured,RProSID,rdi_date_removed,Hide1,Hide2,CatMetaTitle,CatMetaDescription,CatMetaKeywords,CatMetaKeyphrases,Deleted,DateCreated,DateUpdated,UpdatedBy) VALUES('27','1','5 Megapixels',NULL,NULL,NULL,NULL,NULL,'categories',NULL,NULL,NULL,'3','5',NULL,NULL,'4',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'23',0,NULL,NULL,0,0,NULL,NULL,NULL,NULL,0,'2005-4-29 16:0:0',NULL,'ADMIN')
INSERT INTO dbo.Categories (CatID,SiteID,CatName,CatSummary,CatDescription,CatImage,CatImageDir,CatFeaturedID,CatFeaturedDir,CatBanner,CKeywords,CDescription,ShowColumns,ShowRows,DisplayPrefix,SortByLooks,DisplayOrder,CategoryDisplayFormatID,AllowCategoryFiltering,AllowManufacturerFiltering,AllowProductTypeFiltering,Published,Comments,AvailableSections,SubCategoryOf,Featured,RProSID,rdi_date_removed,Hide1,Hide2,CatMetaTitle,CatMetaDescription,CatMetaKeywords,CatMetaKeyphrases,Deleted,DateCreated,DateUpdated,UpdatedBy) VALUES('28','1','6 Megapixels +',NULL,NULL,NULL,NULL,NULL,'categories',NULL,NULL,NULL,'3','5',NULL,NULL,'5',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'23',0,NULL,NULL,0,0,NULL,NULL,NULL,NULL,0,'2005-4-29 16:0:0',NULL,'ADMIN')
INSERT INTO dbo.Categories (CatID,SiteID,CatName,CatSummary,CatDescription,CatImage,CatImageDir,CatFeaturedID,CatFeaturedDir,CatBanner,CKeywords,CDescription,ShowColumns,ShowRows,DisplayPrefix,SortByLooks,DisplayOrder,CategoryDisplayFormatID,AllowCategoryFiltering,AllowManufacturerFiltering,AllowProductTypeFiltering,Published,Comments,AvailableSections,SubCategoryOf,Featured,RProSID,rdi_date_removed,Hide1,Hide2,CatMetaTitle,CatMetaDescription,CatMetaKeywords,CatMetaKeyphrases,Deleted,DateCreated,DateUpdated,UpdatedBy) VALUES('29','1','Canon 300D Series',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'3','5',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'21',0,NULL,NULL,0,0,NULL,NULL,NULL,NULL,0,'2005-5-9 14:35:0',NULL,'ADMIN')
INSERT INTO dbo.Categories (CatID,SiteID,CatName,CatSummary,CatDescription,CatImage,CatImageDir,CatFeaturedID,CatFeaturedDir,CatBanner,CKeywords,CDescription,ShowColumns,ShowRows,DisplayPrefix,SortByLooks,DisplayOrder,CategoryDisplayFormatID,AllowCategoryFiltering,AllowManufacturerFiltering,AllowProductTypeFiltering,Published,Comments,AvailableSections,SubCategoryOf,Featured,RProSID,rdi_date_removed,Hide1,Hide2,CatMetaTitle,CatMetaDescription,CatMetaKeywords,CatMetaKeyphrases,Deleted,DateCreated,DateUpdated,UpdatedBy) VALUES('30','1','Canon 350D Series',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'3','5',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'21',0,NULL,NULL,0,0,NULL,NULL,NULL,NULL,0,'2005-5-9 14:36:0',NULL,'ADMIN')
INSERT INTO dbo.Categories (CatID,SiteID,CatName,CatSummary,CatDescription,CatImage,CatImageDir,CatFeaturedID,CatFeaturedDir,CatBanner,CKeywords,CDescription,ShowColumns,ShowRows,DisplayPrefix,SortByLooks,DisplayOrder,CategoryDisplayFormatID,AllowCategoryFiltering,AllowManufacturerFiltering,AllowProductTypeFiltering,Published,Comments,AvailableSections,SubCategoryOf,Featured,RProSID,rdi_date_removed,Hide1,Hide2,CatMetaTitle,CatMetaDescription,CatMetaKeywords,CatMetaKeyphrases,Deleted,DateCreated,DateUpdated,UpdatedBy) VALUES('31','1','S- Series',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'3','5',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'4',0,NULL,NULL,0,0,NULL,NULL,NULL,NULL,0,'2005-5-9 14:53:0',NULL,'ADMIN')
INSERT INTO dbo.Categories (CatID,SiteID,CatName,CatSummary,CatDescription,CatImage,CatImageDir,CatFeaturedID,CatFeaturedDir,CatBanner,CKeywords,CDescription,ShowColumns,ShowRows,DisplayPrefix,SortByLooks,DisplayOrder,CategoryDisplayFormatID,AllowCategoryFiltering,AllowManufacturerFiltering,AllowProductTypeFiltering,Published,Comments,AvailableSections,SubCategoryOf,Featured,RProSID,rdi_date_removed,Hide1,Hide2,CatMetaTitle,CatMetaDescription,CatMetaKeywords,CatMetaKeyphrases,Deleted,DateCreated,DateUpdated,UpdatedBy) VALUES('32','1','Camera Bags',NULL,NULL,NULL,NULL,NULL,'products',NULL,NULL,NULL,'3','5',NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,0,'2005-12-4 21:2:0','2007-3-25 13:51:0','ADMIN')
IF (IDENT_SEED('dbo.Categories') IS NOT NULL )	SET IDENTITY_INSERT dbo.Categories OFF
GO
GO
ALTER TABLE dbo.Categories CHECK CONSTRAINT ALL
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
--Insert data into dbo.CustomerCC
-----------------------------------------------------------
ALTER TABLE dbo.CustomerCC NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.CustomerCC
GO

IF (IDENT_SEED('dbo.CustomerCC') IS NOT NULL )	SET IDENTITY_INSERT dbo.CustomerCC ON
IF (IDENT_SEED('dbo.CustomerCC') IS NOT NULL )	SET IDENTITY_INSERT dbo.CustomerCC OFF
GO
GO
ALTER TABLE dbo.CustomerCC CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.Customers
-----------------------------------------------------------
ALTER TABLE dbo.Customers NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.Customers
GO

IF (IDENT_SEED('dbo.Customers') IS NOT NULL )	SET IDENTITY_INSERT dbo.Customers ON
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3843586823',NULL,'Martin',NULL,'McGee','7350 Greenhaven Ave. #55',NULL,'Rancho Cucamonga','CA','91730','US','909-980-5281',NULL,'909-481-9632','marty@tradestudios.com','Trade Studios, LLC','MC','33B036C8AFAED78DD76FC4C746E9E893','36B52BCCA6','123','Martin','McGee','Trade Studios, LLC','7350 Greenhaven Ave. #55',NULL,'Rancho Cucamonga','CA','91730','US','909-980-5281','webmaster@tradestudios.com','damartman','62E5699DEDEA8ADC89','1',1,'0',474.78,NULL,'127.0.0.1','7014',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2005-3-24 15:5:0','2007-3-26 16:17:0','ADMIN',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3847456123',NULL,'Jack',NULL,'Riley','3121 34th St.',NULL,'Dammeron Valley','ID','80501','US','912-829-3874',NULL,NULL,'jriley@specialcircumstances.net',NULL,'MC','33B036C8AFAED78DD76FC4C746E9E893','36B72BCCA6','909','Jack','Riley',NULL,'3121 34th St.',NULL,'Dammeron Valley','ID','80501','US',NULL,NULL,'jriley','6CF66D90FAE7','1',0,'0',-52,NULL,'127.0.0.1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2005-5-2 21:6:0','2005-5-10 6:9:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3847830514',NULL,'Mel',NULL,'Jackson','2000 South IH-35',NULL,'Gable','AL','29928','US','203-392-0388',NULL,NULL,NULL,NULL,'VI','32B636CEADACD58FD56DC6C544',NULL,NULL,'Mel','Jackson',NULL,'2000 South IH-35',NULL,'Gable','AL','29928','US',NULL,NULL,NULL,NULL,'1',0,'0',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2005-5-6 17:50:0','2005-5-6 12:0:0','ADMIN',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3847833836',NULL,'Hilton',NULL,'Farler','21 SE Court Ave.',NULL,'Chicago','IL','60601','US','737-920-9388',NULL,NULL,'hilton@farler.com','Mass Storage Chicago','VI','32B434CBAFAED78DD76FC4C540','36BD2BCCAA','909','Hilton','Farler','Mass Storage Chicago','21 SE Court Ave.',NULL,'Chicago','IL','60601','US',NULL,NULL,'Hilton','4EED6888F0F0','2',0,'0',0,NULL,'71.104.30.186',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2005-5-6 18:44:0','2005-12-5 15:9:0','MARTY',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3847838015',NULL,'Gene',NULL,'Gallant','415 Makeshift Rd.',NULL,'Charlotte','NC','30333','US','493-290-0309',NULL,NULL,'george@zalesgroup.com',NULL,'VI','32B435CEA7A6DF85D667CCCF4E','36B62BCCA7','891','Gene','Gallant',NULL,'414 Makeshift Rd.',NULL,'Charlotte','NC','30333','US',NULL,NULL,'gene','61E16A99','1',0,'0',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2005-5-6 9:51:0','2005-12-5 15:9:0','MARTY',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3847934049',NULL,'Barbara',NULL,'Beal','8190 Vargas Lane',NULL,'Henderson','NV','89134','US','203-392-0388',NULL,NULL,'barbarabeal@bealingwithme.com',NULL,'MC','33B036C8AFAED78DD76FC4C746E9E893','37B42BCCA8','001','Barbara','Beal',NULL,'8190 Vargas Lane',NULL,'Henderson','NV','89134','US',NULL,NULL,'Beal','44E16591','1',0,'0',0,NULL,'69.231.131.193',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2005-5-7 7:55:0','2005-6-23 18:32:0','ADMIN',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3847940047',NULL,'Joanne',NULL,'Marquez','9000 Crow Cedar Way',NULL,'Granite Bay','CA','95978','US','916-858-1452',NULL,NULL,'marquez@globalfinishings.org',NULL,'MC','33B036C8AFAED78DD76FC4C746E9E893','37B52BCCA7','822','Joanne','Marquez',NULL,'9000 Crow Cedar Way',NULL,'Granite Bay','CA','95978','US',NULL,NULL,'jmarquez','65E1609DED','1',0,'0',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2005-5-7 7:47:0','2005-5-7 7:47:0','ADMIN',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3847978053',NULL,'Hillary',NULL,'Hodges','39 A West Bull Blvd.',NULL,'West Hollywood','CA','90209','US','818-555-5555',NULL,NULL,NULL,NULL,'VI','32B434CBAFAED78DD76FC4C540',NULL,NULL,'Hillary','Hodges',NULL,'39 A West Bull Blvd.',NULL,'West Hollywood','CA','90209','US',NULL,NULL,NULL,NULL,'1',0,'0',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2005-5-7 7:50:0','2005-5-7 0:0:0','ADMIN',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3848174746',NULL,'Meg',NULL,'Johnson','2290 E. Flaming Ave.',NULL,'Riverside','CA','91627','US','909-289-3982',NULL,NULL,NULL,'Calliber Extract','VI','32B434CBAFAED78DD76FC4C540','3FAB34C5',NULL,'Meg','Johnson','Calliber Extract','2290 E. Flaming Ave.',NULL,'Riverside','CA','91627','US',NULL,NULL,NULL,NULL,'1',0,'0',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2005-5-9 9:11:0','2005-5-9 0:0:0','ADMIN',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3848236344',NULL,'Mike',NULL,'Gallagher','556 Yellow Rd.','','Minneapolis','MN','44333','US','815-634-4102',NULL,'','mglaughter@minnesotansrule.net','','MC','33B036C8AFAED78DD76FC4C746E9E893','37B52BCCA6','598','Mike','Gallagher',NULL,'556 Yellow Rd.','','Minneapolis','MN','44333','US',NULL,NULL,'mglaughter','6BE3','1',0,'0',-1,NULL,'127.0.0.1','7021',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2005-5-10 15:24:0','2006-8-28 2:12:0','Customer',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3849132039',NULL,'John',NULL,'Pusey',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'johnp@g3group.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'sleeping','75E86199EFF789DA','1',0,'0',0,NULL,'209.49.11.38',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2005-5-19 13:33:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3851911567',NULL,'Mike',NULL,'Harrison','4140 NW 27th Lane','','Los Angeles','CA','91405','US','818-625-3987',NULL,'','renix@comcast.net','','MC','33B036C8AFAED78DD76FC4C746E9E893','37B42BCCA7','123','Mike','Harrison',NULL,'4140 NW 27th Lane','','Los Angeles','CA','91405','US',NULL,NULL,'mike','72EB768DEAFB','1',0,'0',20,NULL,'71.104.15.158',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2005-6-16 9:9:0','2006-3-20 23:31:0','ADMIN',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3851997224',NULL,'Maintain',NULL,'Net',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'m@n.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'maintainnet','6BE56D92EBFF8ED3893A80','1',0,'0',0,NULL,'216.204.105.226',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2005-6-16 9:30:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3852374610',NULL,'Joe',NULL,'shmoe',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'loony2nz@gmail.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Loony2nz','64ED709FF7FF94CE','1',0,'0',0,NULL,'67.174.235.9',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2005-6-20 23:13:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3852512316',NULL,'test',NULL,'AKARD','1234 MAIN',NULL,'GALVESTON','TX','77550','US','555-555-5555',NULL,NULL,'TEST@TESTMERCHANT.COM',NULL,'VI','32B535CDAEAFD68CD66EC5C647E8E897','37B52BCCA7','123','TEST','AKARD',NULL,'123 MAIN ST',NULL,'GALVESTON','TX','77550','US',NULL,NULL,'TESTING123','72E17788','1',NULL,'0',0,NULL,'221.237.5.78',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2005-6-22 21:31:0','2007-1-1 21:38:0','DEMO',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3852573025',NULL,'Mark',NULL,'Morley',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'fdsjkl@fjdslk.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'mmorley','45E2348EFAED9385','1',0,'0',0,NULL,'24.8.189.141',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2005-6-22 8:10:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3852576845',NULL,'test',NULL,'test','1234 main st',NULL,'galveston','TX','77550','US','555-555-5555',NULL,NULL,'test@test.com',NULL,'VI','32B535CDAEAFD68CD66EC5C647E8E897','36B52BCCA9','458','test','test',NULL,'123 main st',NULL,'galveston','TX','77550','US',NULL,NULL,'test','72E17788AD','1',0,'0',0,NULL,'24.173.1.237',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2005-6-22 21:21:0','2005-6-22 21:22:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3852591016',NULL,'test',NULL,'test',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'test@aol.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'terst','72E17789','1',0,'0',0,NULL,'68.84.193.133',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2005-6-22 19:29:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3853410725',NULL,'Caimy',NULL,'Mues',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'cmues@isp.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'cmues','6EEB7499F9EB8BD38829','1',0,'0',0,NULL,'24.11.6.50',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2005-7-1 8:18:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3853491333',NULL,'dubya',NULL,'bush',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'dubya@whitehouse.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'dubya','62E5548EFAE4','1',0,'0',0,NULL,'65.6.2.20',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2005-7-1 13:8:0','2005-12-3 9:44:0','ADMIN',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3853694638',NULL,'bnejay',NULL,'john',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'benjay4christ@yahoo.co.uk',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'benjay','67E8659EF6AA928CD56D','1',0,'0',0,NULL,'84.254.188.2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2005-7-3 11:6:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3853780763',NULL,'MELANIE',NULL,'HOPEWELL',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'MELLO1972_2000@YAHOO.COM',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'MELANIE','31BD35C4A6AAD58B','1',0,'0',0,NULL,'65.60.154.40',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2005-7-4 9:25:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3856057054',NULL,'Carl',NULL,'Vanderpal','133 Hancock Ave.','','New South Wales','-','5021','US','0112115442938',NULL,'','carl@cartfusion.net','Animated Kids Bible','MC','33B036C8AFAED78DD76FC4C746E9E893','37B42BCCA7','111','Carl','Vanderpal',NULL,'133 Hancock Ave.','','New South Wales','-','5021','US',NULL,NULL,'cvanderpal','4DF267BFC6ECA685D009B9C3','1',0,'0',0,NULL,'127.0.0.1','7077',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2005-7-27 17:51:0','2005-12-13 17:38:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3856067242',NULL,'mary',NULL,'bullard',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'marybullard2000@aol.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'astonishing','6BE67084ADAED789','1',0,'0',0,NULL,'205.188.117.13',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2005-7-27 8:36:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3856859826',NULL,'Allan',NULL,'Curran','2 Sunnyside Drive',NULL,'Yonkers','NY','10705','US','9145509872',NULL,NULL,'nyconsultants2k@yahoo.com',NULL,'VI','32B735CFAFADD28ED66CC4C144EFE091','36B52BCCA9','443','Helene','Curran',NULL,'17100 Brannon Fork Road',NULL,'Citronelle','AL','36522','US',NULL,NULL,'nyconsultant','68ED6188ECFD8F','1',0,'0',0,NULL,'161.58.49.73',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2005-8-4 21:10:0','2005-8-4 21:12:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3857398150',NULL,'test',NULL,'Apellido',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1234567@hotmail.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'admin','37B637C8AAA8','1',0,'0',0,NULL,'24.27.220.121',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2005-8-9 22:10:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3858155224',NULL,'Terry',NULL,'Clancy',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'terryclancy@att.net',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'tc2323','72E736CFADAD','1',0,'0',0,NULL,'24.227.32.222',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2005-8-17 9:0:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3858645240',NULL,'Chris',NULL,'Yager','111 Fantasy Lane',NULL,'Miami','FL','32771','US','5617026343',NULL,NULL,'cayager@gmail.com',NULL,'VI','32B535CDAEAFD68CD66EC5C647E8E897','36B62BCCA6','247','Chris','Yager',NULL,'111 Fantasy Lane',NULL,'Miami','FL','32771','US',NULL,NULL,'cayager','69F66193ADACD08F','1',0,'0',0,NULL,'64.240.212.206',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2005-8-22 11:38:0','2005-8-22 11:43:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3859625961',NULL,'rty',NULL,'yrtyry',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'test@test.test',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'ryrtyr','67F7609AF8','1',0,'0',0,NULL,'208.181.142.161',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2005-9-1 16:2:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3861230228',NULL,'Brian',NULL,'Bobay',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'brian@bobayweb.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'brianbobay','76E5778FE8F195D9','1',0,'0',0,NULL,'71.97.129.162',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2005-9-17 1:21:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3861847459',NULL,'Sammy',NULL,'Sosa','1234 hallow dr',NULL,'jackson','AP','83001','US','307-733-2706',NULL,NULL,'shawn@twenty-two.com',NULL,'VI','32B535CDAEAFD68CD66EC5C647E8E897','36B52BCCA9','386','Sammy','Sosa',NULL,'1234 hallow dr',NULL,'jackson','AP','83001','US',NULL,NULL,'sss','36B036CFA9A9','2',NULL,'0',0,NULL,'63.164.105.135',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2005-9-23 23:5:0','2005-12-3 21:10:0','MARTY',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3862557823',NULL,'ok',NULL,'ok',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'ok@aol.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'ok','69EF','1',0,'0',0,NULL,'69.161.18.182',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2005-9-30 19:7:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3862954627',NULL,'test',NULL,'test','34 eill st',NULL,'amityville','NY','11071','US','7183333333',NULL,NULL,'test@31test.com',NULL,'VI','32B535CDAEAFD68CD66EC5C647E8E897','36BD2BCCA9','313','t','t',NULL,'wet12',NULL,'35t6ewtwe','NJ','07624','US',NULL,NULL,'test31','72E17789','1',0,'0',0,NULL,'24.187.93.14',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2005-10-4 14:57:0','2005-10-4 14:59:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3862978410',NULL,'Test',NULL,'Ing',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'jnkacct@hotmail.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'testingThis','72E17788F6F0808BD3','1',0,'0',0,NULL,'24.220.51.162',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2005-10-4 14:52:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3863425226',NULL,'pete',NULL,'tester',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'peter@n.con',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'pete','76E17099','1',0,'0',0,NULL,'66.219.150.19',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2005-10-9 21:36:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3863674855',NULL,'Realtime',NULL,'Processing','7350 Greenhaven Ave.','#55','Rancho Cucamonga','CA','91730','US','909-980-5281',NULL,'909-481-9632','realtime@tradestudios.com',NULL,'MC','33B036C8AFAED78DD76FC4C746E9E893','37B42BCCA8','000','Realtime','Processing',NULL,'7350 Greenhaven Ave.','#55','Rancho Cucamonga','CA','91730','US',NULL,NULL,'realtime','74E16590EBF78AD8','1',0,'0',0,NULL,'71.104.39.164',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2005-10-11 19:8:0','2005-10-11 20:46:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3864483853',NULL,'sanjeev',NULL,'dhillon','10944 160th street',NULL,'surrey','BC','v3w4g3','CA','6046712100',NULL,NULL,'shinvestor2@yahoo.com',NULL,NULL,NULL,NULL,NULL,'sanjeev','dhillon',NULL,'10944 160th street',NULL,'surrey','BC','v3w4g3','CA',NULL,NULL,'sambasa','72F17697FEF087','1',0,'0',0,NULL,'24.81.238.5',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2005-10-19 22:18:0','2005-10-19 22:19:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3864732812',NULL,'Nancy',NULL,'Valler',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'nlvaller@aol.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'nlvaller','76E5778FE8F195D9','1',0,'0',0,NULL,'69.163.24.5',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2005-10-22 15:9:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3865875645',NULL,'William',NULL,'Brashears',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'billbrashears@sbcglobal.net',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'billbra','60F66198FBAF','1',0,'0',0,NULL,'12.108.23.4',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2005-11-2 22:10:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3866797750',NULL,'test test',NULL,'test test',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'nobodyuz@mail.ru',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'tarcos','67EF6D90FDF185','1',0,'0',0,NULL,'67.15.118.232',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2005-11-11 3:18:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3867153145',NULL,'lkhb',NULL,'lklkh',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'lkjh',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'lhg','36B434CD','1',0,'0',0,NULL,'84.13.248.77',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2005-11-15 3:56:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3868460148',NULL,'Brian',NULL,'West',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'testuser@testzombie.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'elogic','30B133C4A6','1',0,'0',0,NULL,'67.164.26.30',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2005-11-28 22:50:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3868915517',NULL,'Nathan',NULL,'Gibbons','891 Forest Ave.','','Cannon','RI','21320','US','210-392-3938',NULL,'',NULL,'','MC','33B036C8AFAED78DD76FC4C746E9E893','37B52BCCAA','111','Nathan','Gibbons','','891 Forest Ave.','','Cannon','RI','21320','US',NULL,NULL,NULL,NULL,'1',0,'0',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2005-12-3 17:56:0','2005-12-3 17:56:0','MARTY',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3868938560',NULL,'Matthew',NULL,'Ledger','7 Skyline Drive',NULL,'Pittsburgh','PA','31293','US','419-261-4897',NULL,NULL,'ledger@tradestudios.com',NULL,'MC','33B036C8AFAED78DD76FC4C746E9E893','37B42BCCA8','111','Matthew','Ledger',NULL,'7 Skyline Drive',NULL,'Pittsburgh','PA','31293','US',NULL,NULL,'ledger','6AE1609BFAEC','2',0,'0',0,NULL,'127.0.0.1','7028',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2005-12-3 18:29:0','2005-12-9 8:59:0','MARTY',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3869042235',NULL,'Shannon',NULL,'Clemens','2740 Old Crow Canyon Road','Building 4, Suite 200','San Ramon','CA','94583','US','925-836-9949',NULL,'925-836-9948','sclemens@googlemail.com','Real Image','MC','33B036C8AFAED78DD76FC4C746E9E893','37B42BCCA8','111','Shannon','Clemens',NULL,'2740 Old Crow Canyon Road','Building 4, Suite 200','San Ramon','CA','94583','US',NULL,NULL,'shannon','75EC6592F1F189','1',0,'0',0,NULL,'208.54.15.1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2005-12-4 22:6:0','2006-3-28 17:7:0','ADMIN',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3881984524',NULL,'My Name Is',NULL,'Test','123 Anystreet Blvd.','','Buffalo','NY','10045','US','210-928-4938',NULL,'','engaged@thehotspotz.com','','MC','33B036C8AFAED78DD76FC4C746E9E893','37B62BCEAF','203','My Name Is','Test',NULL,'123 Anystreet Blvd.','','Buffalo','NY','10045','US',NULL,NULL,'Last Name:','4AE57788BFD086D08265','1',0,'0',0,NULL,'71.104.11.163',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2006-4-12 6:52:0','2006-6-13 21:29:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3885461340',NULL,'k',NULL,'k',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'kkkk',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'kk','6DEF6F97F4','1',0,'0',0,NULL,'209.33.228.195',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2006-5-17 21:44:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3886386129',NULL,'admin',NULL,'admin',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'admin@admin.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'admin168','67E06995F1','1',0,'0',0,NULL,'66.173.238.122',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2006-5-26 10:45:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3887311854',NULL,'Martin',NULL,'Pearce','1234 Happy Street',NULL,'Orlando','FL','32809','US','407-123-1458',NULL,NULL,'tambanadza@yahoo.com',NULL,'VI','32B535CDAEAFD68CD66EC5C647E8E897','36B32BCCA6','742','Martin','Pearce',NULL,'1234 Happy Street',NULL,'Orlando','FL','32809','US',NULL,NULL,'tambanadza','6BEB7D99ECE6948C','2',0,'0',0,NULL,'65.33.142.157',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2006-6-5 4:8:0','2006-6-13 19:40:0','DEMO',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3892472449',NULL,'Alex',NULL,'oddjob','22523 Dolorosa Street','','Woodland Hills','CA','91367','US','866-855-2278',NULL,'','oddjob@screamstudios.com','Trade Studios, LLC','MC','33B036C8AFAED78DD76FC4C746E9E893','37B52BCCA8','698','Alex','oddjob',NULL,'22523 Dolorosa Street','','Woodland Hills','CA','91367','US',NULL,NULL,'oddjob007','6BEB6A97FAE7','1',1,'0',0,NULL,'71.104.10.249',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2006-7-26 9:34:0','2006-7-27 13:11:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3893187915',NULL,'dick',NULL,'tracy','666 main st.','','canoga park','','91364','US','818-505-0755',NULL,'',NULL,'','DI','3FBC33CDADADD385D069C1C345EBEE9E','37B52BCCA8','321','dick','tracy','','666 main st.','','canoga park','','91364','US',NULL,NULL,NULL,NULL,'1',1,'0',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2006-8-2 14:40:0','2006-8-2 14:41:0','ADMIN',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3906022540',NULL,'Bill',NULL,'College','7350 Greenhaven Ave. #55','','Rancho Cucamonga','CA','91730','US','909-622-5042',NULL,'','billcollege@collegepresents.com','',NULL,NULL,NULL,NULL,'Bill','College','','7350 Greenhaven Ave. #55','','Rancho Cucamonga','CA','91730','US','909-622-5042','','billcollege','64ED6890FCF18BD1823891','1',0,'0',0,NULL,'24.180.54.61',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2006-12-9 23:32:0','2006-12-9 23:37:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3909011320',NULL,'Alex',NULL,'Oddjob','11616 Ventura Blvd.','','Studio City','CA','91604','US','(818) 505-0755',NULL,'',NULL,'','VI','3FB434C5A6A7D78DD766','37B42BCDAF','321','Alex','Oddjob','','11616 Ventura Blvd.','','Studio City','CA','91604','US',NULL,NULL,NULL,NULL,'1',1,'0',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2007-1-8 15:46:0','2007-1-8 15:46:0','ADMIN',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3909024949',NULL,'Alex',NULL,'Oddjob','11616 Ventura Blvd.','','Studio City','CA','91604','US','(818) 505-0755',NULL,'',NULL,'','VI','3FB434C5A6A7D78DD766','37B42BCDAF','321','Alex','Oddjob','','11616 Ventura Blvd.','','Studio City','CA','91604','US',NULL,NULL,NULL,NULL,'1',1,'0',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2007-1-8 15:46:0','2007-1-8 15:46:0','ADMIN',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3909774919',NULL,'Todd',NULL,'Currie','test','','Irvine','NY','33009','US','555-555-1212',NULL,'','todd@voyantmedia.com','',NULL,NULL,NULL,NULL,'Todd','Currie','','555 test','','Irvine','CA','92614','US','555-555-1212','','voyant2','61E57E93EA','1',0,'0',0,NULL,'24.80.237.206',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2007-1-15 14:56:0','2007-1-15 15:5:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3910787225',NULL,'jkl;lkj',NULL,'j;lkj;lkj',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'j;lkj;lkj;lkj',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'jjkl;','6CEF6E97','1',0,'0',0,NULL,'72.26.146.214',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2007-1-25 22:53:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3911436833',NULL,'tom',NULL,'degrezia','14702 Central','','Chino','CA','91710','US','909-973-8573',NULL,'','tom@degrezia.com','',NULL,NULL,NULL,NULL,'tom','degrezia','','14702 Central','','Chino','CA','91710','US','909-973-8573','','tom','71ED6A88FAEC','1',0,'0',0,NULL,'76.175.231.37',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2007-2-1 20:27:0','2007-2-2 1:10:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3912713545',NULL,'Test',NULL,'User','..','..','..','CA','90210','US','90909090',NULL,'','test@user.com','..',NULL,NULL,NULL,NULL,'90','90','90','90','90','90','CA','90210','US','sdfadf','','testuser','72E17788EAED82CF','1',1,'0',0,NULL,'203.214.8.233',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2007-2-14 11:25:0','2007-2-14 11:32:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3912812957',NULL,'Odysseus',NULL,'Eko','78 Mason St.',NULL,'Boston','MA','02108','US','(888) 678-7456',NULL,NULL,NULL,NULL,'DI','36BC33C5A6A6D68ED56BC7C242EDEC93','36B22BCDAF','001','Odysseus','Eko',NULL,'78 Mason St.',NULL,'Boston','MA','02108','US',NULL,NULL,NULL,NULL,'1',NULL,'0',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2007-2-15 15:57:0','2007-2-15 15:57:0','ADMIN',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3912820824',NULL,'Alma',NULL,'Ulrike','265 Winston ST.',NULL,'Winter Park','FL','32789','US','(768) 786-8456',NULL,NULL,NULL,NULL,'VI','37BD3CCBA9ABD58AD266C4C745EAED91','36B12BCCA7','123','Alma','Ulrike',NULL,'265 Winston ST.',NULL,'Winter Park','FL','32789','US',NULL,NULL,NULL,NULL,'1',NULL,'0',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2007-2-15 16:48:0','2007-2-15 16:48:0','ADMIN',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3912834357',NULL,'Seneca',NULL,'Kasper','2435 Willow Dr.',NULL,'Tucson','AZ','85701','US','(818) 555-5555',NULL,NULL,NULL,NULL,'MC','34BD34C4A9A8D688D46DC0C04EEFEA95','37B42BCDAF','321','Seneca','Kasper',NULL,'2435 Willow Dr.',NULL,'Tucson','AZ','85701','US',NULL,NULL,NULL,NULL,'1',NULL,'0',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2007-2-15 15:44:0','2007-2-15 15:44:0','ADMIN',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3912846435',NULL,'Omar',NULL,'Sten','4545 Maple Ave',NULL,'Walnut','CA','91789','US','(765) 765-6525',NULL,NULL,NULL,NULL,'AE','36BC3DC4AEACD188D06BCCC440ECED95','36BD2BCCA6','756','Omar','Sten',NULL,'4545 Maple Ave',NULL,'Walnut','CA','91789','US',NULL,NULL,NULL,NULL,'1',NULL,'0',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2007-2-15 15:49:0','2007-2-15 15:49:0','ADMIN',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3912850149',NULL,'Cal',NULL,'Karim','47567 Northeast Dr.',NULL,'Van Nuys','CA','91401','US','(987) 678-4545',NULL,NULL,NULL,NULL,'DI','37B637CCA6A7DF8BD06AC1C240EEE19F','36B22BCCA6','777','Cal','Karim',NULL,'47567 Northeast Dr.',NULL,'Van Nuys','CA','91401','US',NULL,NULL,NULL,NULL,'0',NULL,'0',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2007-2-15 18:19:0','2007-2-15 18:19:0','ADMIN',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3912855328',NULL,'August',NULL,'Suibne','87689 Lake Ave.',NULL,'Studio City','CA','91604','US',NULL,NULL,NULL,NULL,NULL,'DI','37B63CC5A9A9D48DD766CCCF4EEEEF95','37B52BCDAE','465','August','Suibne',NULL,'87689 Lake Ave.',NULL,'Studio City','CA','91604','US',NULL,NULL,NULL,NULL,'1',NULL,'0',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2007-2-15 15:52:0','2007-2-15 15:52:0','ADMIN',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3912863569',NULL,'Herman',NULL,'Eitan','22435 Capistrano St.',NULL,'Woodland Hills','CA','91367','US','(818) 555-8976',NULL,NULL,NULL,NULL,'VI','34B630C8A6A6D188D76FC4CE4EEEEF93','37B42BCDAF',NULL,'Herman','Eitan',NULL,'22435 Capistrano St.',NULL,'Woodland Hills','CA','91367','US',NULL,NULL,NULL,NULL,'1',NULL,'0',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2007-2-15 17:32:0','2007-2-15 17:32:0','ADMIN',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3912864238',NULL,'Harald',NULL,'Helmuth','90088 Apache St.',NULL,'Beverly Hills','CA','90210','US','(310) 765-0098',NULL,NULL,NULL,NULL,'AE','37B637C9A9ADD288DF67C1CF46E0E197','36BD2BCCA6','567','Harald','Helmuth',NULL,'90088 Apache St.',NULL,'Beverly Hills','CA','90210','US',NULL,NULL,NULL,NULL,'2',NULL,'0',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2007-2-15 17:9:0','2007-2-15 17:9:0','ADMIN',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3912867331',NULL,'Varinius',NULL,'Phocas','1234 Belt Drive',NULL,'Houston','TX','77002','US','(789) 765-9008',NULL,NULL,NULL,NULL,'MC','36BD3CCDADADD18BD36BC3CF4FE9E09E','37B62BCCA6','130','Varinius','Phocas',NULL,'1234 Belt Drive',NULL,'Houston','TX','77002','US','(789) 765-9008',NULL,NULL,NULL,'2',NULL,'0',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2007-2-15 18:15:0','2007-2-15 18:17:0','ADMIN',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3912871017',NULL,'Carmel',NULL,'Godfried','314566 Alameda St.',NULL,'Los Angeles','CA','90026','US',NULL,NULL,NULL,NULL,NULL,'MC','37BD37CBA9ABD38AD467CDC746E0E19E','36B62BCCA6','789','Carmel','Godfried',NULL,'314566 Alameda St.',NULL,'Los Angeles','CA','90026','US',NULL,NULL,NULL,NULL,'2',NULL,'0',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2007-2-15 16:51:0','2007-2-15 16:51:0','ADMIN',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3912877121',NULL,'Avi',NULL,'Irving','55764 Washington Ave.',NULL,'San Antonio','TX','78201','US','(876) 767-8766',NULL,NULL,NULL,NULL,'MC','3EB33CC8ABAAD189D16FC4C744EAED95','37B52BCCA8','350','Avi','Irving',NULL,'55764 Washington Ave.',NULL,'San Antonio','TX','78201','US',NULL,NULL,NULL,NULL,'1',NULL,'0',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2007-2-15 18:10:0','2007-2-15 18:10:0','ADMIN',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3912927327',NULL,'Gerry',NULL,'Rafiq','4545 Washington Ave.','','Los Angeles','CA','90028','US','(323) 867-1279',NULL,'','jk@yahoo.com','','MC','33B036C8AEA6D78BD56DC0C54EEBEE97','36BC2BCCA7','456','Gerry','Rafiq','','4545 Washington Ave.','','Los Angeles','CA','90028','US','(323) 867-1279','','rafiq','63E86993','1',1,'0',0,NULL,'24.24.129.189',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2007-2-16 15:58:0','2007-2-16 16:1:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3912929219',NULL,'Art',NULL,'Vandalay','789 Kramer St.','','New York','NY','10002','US','(212) 876-6743',NULL,'','artv@vandalayind.com','Vandalay Insdustries','MC','33B036C8AEA6D78BD56DC0C54EEBEE97','36B02BCCA7','006','Krystyn','Maximus','','345 Day Dr.','','Phoenix','AZ','90087','US','(877) 787-0098','','artcore','69EF6F93F0','1',0,'0',0,NULL,'24.24.129.189',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2007-2-16 12:40:0','2007-2-16 12:46:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3912930955',NULL,'Horacio',NULL,'Daniel','866 Turtle Dr.','','Hartford','CT','06106','US','(908) 567-1212',NULL,'','Hor@yahoo.com','',NULL,NULL,NULL,NULL,'Horacio','Daniel','','866 Turtle Dr.','','Hartford','CT','06106','US','(908) 567-1212','','horacio123','70F1688AFE','1',0,'0',0,NULL,'24.24.129.189',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2007-2-16 15:6:0','2007-2-16 15:10:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3912932935',NULL,'Wasswa',NULL,'Flynn','4678 Donna Dr.','','Mercury','RI','90076','US','(345) 567-1234',NULL,'','flynn@sbcglobal.net','',NULL,NULL,NULL,NULL,'Wasswa','Flynn','','4678 Donna Dr.','','Mercury','RI','90076','US','(345) 567-1234','','flynn','36BD34C5','1',1,'0',0,NULL,'24.24.129.189',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2007-2-16 15:25:0','2007-2-16 15:30:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3912937612',NULL,'Gregorios',NULL,'Jesper','6665 Mulberry Lane',NULL,'Springfield','MO','38863','US','(989) 423-8856',NULL,NULL,'jesper@jpds.com',NULL,'MC','33B036C8AEA6D78BD56DC0C54EEBEE97','36BC2BCCA7','456','Gregorios','Jesper',NULL,'6665 Mulberry Lane',NULL,'Springfield','MO','38863','US','(989) 423-8856',NULL,'Gregorios','6DE56099','1',NULL,'0',0,NULL,'24.24.129.189',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2007-2-16 10:25:0','2007-2-16 12:10:0','ADMIN',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3912944313',NULL,'Gheorghe',NULL,'Patxi','1234 89th St.','','Pasadena','CA','91103','US','(774) 678-1264',NULL,'','patxi@hotmail.com','','VI','32B535CDAEAFD68CD66EC5C647E8E897','36BD2BCCA6','678','Gheorghe','Patxi','','1234 89th St.','','Pasadena','CA','91103','US','(774) 678-1264','','patxi','31BC33C4','1',0,'0',0,NULL,'24.24.129.189',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2007-2-16 15:18:0','2007-2-16 15:22:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3912944350',NULL,'Yankel',NULL,'Yoram','876 Kane Dr.','','Beverly Hills','CA','90210','US','(310) 765-3377',NULL,'','yokie@yahoo.com','','VI','32B535CDAEAFD68CD66EC5C647E8E897','36B22BCDAF','001','Yankel','Yoram','','876 Kane Dr.','','Beverly Hills','CA','90210','US','(310) 765-3377','','yoram','3EB33CCB','1',0,'0',0,NULL,'24.24.129.189',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2007-2-16 14:2:0','2007-2-16 14:7:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3912947747',NULL,'Sharon',NULL,'Temple','2829 Sunset Dr.','','Hollywood','CA','90495','US','213-758-1362',NULL,'','stemple@regardedbymany.org','','MC','33B036C8AFAED78DD76FC4C746E9E893','37B52BCCA6','987','Sharon','Temple','','2829 Sunset Dr.','','Hollywood','CA','90495','US','213-758-1362','','stemple','75F06191EFF282','1',0,'0',0,NULL,'68.190.206.216',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2007-2-16 13:21:0','2007-2-16 13:26:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3912950543',NULL,'Margareta',NULL,'Astraea','909 Flummer Dr.','','Kansas City','MO','64102','US','(876) 456-1212',NULL,'','astreea@monkey.net','',NULL,NULL,NULL,NULL,'Margareta','Astraea','','909 Flummer Dr.','','Kansas City','MO','64102','US','(876) 456-1212','','jkju','6FEB6D93','1',1,'0',0,NULL,'24.24.129.189',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2007-2-16 13:21:0','2007-2-16 13:24:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3912953013',NULL,'Albert',NULL,'Teodor','898 Serenity Dr.','','Woodland Hills','CA','91367','US','(898) 767-0045',NULL,'','teodor@monkey.net','',NULL,NULL,NULL,NULL,'Felix','Havock','','668 Red Rock Ave.','','Berkeley','CA','90087','US','(787) 789-0098','','chocolate','75E17C89FEF2','1',1,'0',0,NULL,'24.24.129.189',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2007-2-16 12:49:0','2007-2-16 12:53:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3912955515',NULL,'Hyun',NULL,'Jung','123 Buena Ave.','','Coco Beach','FL','32931','US','(657) 126-0075',NULL,'','jung@hotmail.com','',NULL,NULL,NULL,NULL,'Hyun','Jung','','123 Buena Ave.','','Coco Beach','FL','32931','US','(657) 126-0075','','hungjung','72EB7093','1',0,'0',0,NULL,'24.24.129.189',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2007-2-16 14:22:0','2007-2-16 14:28:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3912969416',NULL,'Cadence',NULL,'Jan','555 Hazel St.','','Punxsutawny','PA','15767','US','(868) 367-1199',NULL,'','cade@yahoo.com','',NULL,NULL,NULL,NULL,'Cadence','Jan','','555 Hazel St.','','Punxsutawny','PA','15767','US','(868) 367-1199','','cadence','73EB7193','1',1,'0',0,NULL,'24.24.129.189',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2007-2-16 16:2:0','2007-2-16 16:6:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3912971559',NULL,'Gabriel',NULL,'Robert','345 Nathan St.','','Denver','CO','80014','US','(733) 655-6437',NULL,'','robby@dover.net','','MC','33B036C8AFAED78DD76FC4C746E9E893','37B52BCCA7','123','Gabriel','Robert','','345 Nathan St.','','Denver','CO','80014','US','(733) 655-6437','','robbi','6EE56C9D','1',1,'0',0,NULL,'24.24.129.189',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2007-2-16 15:45:0','2007-2-16 15:48:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3912982564',NULL,'alex',NULL,'ocuna','909 Train Rd','','Tucson','AZ','85704','US','(715) 768-0098',NULL,'','bullwinke@yahoo.com','','VI','32B535CDAEAFD68CD66EC5C647E8E897','37B42BCDAF','321','alex','ocuna','','909 Train Rd','','Tucson','AZ','85704','US','(715) 768-0098','','bull','71ED6A97F3FB','1',1,'0',0,NULL,'24.24.129.189',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2007-2-16 13:25:0','2007-2-16 13:51:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3912988721',NULL,'Milburn',NULL,'Vitaly','678 Walnut Dr.','','Lodi','CA','88001','US','(898) 678-9876',NULL,'','Milt@vitaly.com','',NULL,NULL,NULL,NULL,'Milburn','Vitaly','','678 Walnut Dr.','','Lodi','CA','88001','US','(898) 678-9876','','nerve','3FBC3DC4','1',0,'0',0,NULL,'24.24.129.189',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2007-2-16 12:55:0','2007-2-16 13:9:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3912995630',NULL,'Hikaru',NULL,'Kazuo','4142 Lake Dr.','','Lake Forrest','ME','90035','US','(131) 789-0098',NULL,'','kazuo@hotmail.com','',NULL,NULL,NULL,NULL,'Hikaru','Kazuo','','4142 Lake Dr.','','Lake Forrest','ME','90035','US','(131) 789-0098','','hikaru','6AEB6893','1',0,'0',0,NULL,'24.24.129.189',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2007-2-16 13:56:0','2007-2-16 13:59:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3913225613',NULL,'Foster',NULL,'Maitland','300 Waterfront Rd.','','kansas city','MO','64112','US','(787) 546-8822',NULL,'','amare@gmail.com','','VI','32B735CFAFADD28ED66CC4C144EFE091','36B52BCCA6','436','Foster','Maitland','','300 Waterfront Rd.','','kansas city','MO','64112','US','(787) 546-8822','','Maity','6AE5689D','1',0,'0',0,NULL,'24.24.129.189',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2007-2-19 15:13:0','2007-2-19 15:15:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3913229655',NULL,'Javier',NULL,'Uinseann','3131 Lake Ave.','','Santa Clara','CA','95054','US','(898) 565-0044',NULL,'','javi@gmail.com','',NULL,NULL,NULL,NULL,'Javier','Uinseann','','3131 Lake Ave.','','Santa Clara','MS','95054','US','(898) 565-0044','','javi','6CE56E9D','1',1,'0',0,NULL,'24.24.129.189',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2007-2-19 13:43:0','2007-2-19 13:51:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3913231112',NULL,'Lemmy',NULL,'Isocrates','1236 Maple St.','','Johnson','MN','56236','US','(887) 353-7562',NULL,'','iso@hotmail.com','','VI','32B735CFAFADD28ED66CC4C144EFE091','36B52BCCA7','321','Lemmy','Isocrates','','1236 Maple St.','','Johnson','MN','56236','US','(887) 353-7562','','Lemmy','68EB6A93','1',0,'0',0,NULL,'24.24.129.189',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2007-2-19 10:53:0','2007-2-19 11:47:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3913253837',NULL,'Sean',NULL,'Elias','3131 Orange Grove Ave.','','Anaheim','CA','92805','US','(562) 789-3287',NULL,'','eli@yahoo.com','','VI','32B735CFAFADD28ED66CC4C144EFE091','36BC2BCCA7','321','Sean','Elias','','3131 Orange Grove Ave.','','Anaheim','CA','92805','US','(562) 789-3287','','elias','6EEB6C93','1',0,'0',0,NULL,'24.24.129.189',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2007-2-19 12:13:0','2007-2-19 12:17:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3913272243',NULL,'Daniel',NULL,'Johan','8907 Stern St.','','Longport','NJ','08403','US','(212) 780-7865',NULL,'','johan@sbcglobal.net','','VI','32B735CFAFADD28ED66CC4C144EFE091','36B52BCCA7','443','Daniel','Johan','','8907 Stern St.','','Longport','NJ','08403','US','(212) 780-7865','','johan','62E56A92E6','1',1,'0',0,NULL,'24.24.129.189',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2007-2-19 10:30:0','2007-2-19 10:33:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3913285427',NULL,'Christiaan',NULL,'Thorvald','5685 Glen St.','','Fort Lauderdale','FL','33304','US','(678) 345-0090',NULL,'','thorvald@yahoo.com','',NULL,NULL,NULL,NULL,'Christiaan','Thorvald','','5685 Glen St.','','Fort Lauderdale','FL','33304','US','(678) 345-0090','','thor','70E56898','1',1,'0',0,NULL,'24.24.129.189',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2007-2-19 10:1:0','2007-2-19 10:5:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3913287262',NULL,'Carol',NULL,'Marcial','67 Dexter Ave.','','New Orleans','LA','70116','US','(980) 878-4545',NULL,'','cm@hotmail.com','',NULL,NULL,NULL,NULL,'Carol','Marcial','','67 Dexter Ave.','','New Orleans','LA','70116','US','(980) 878-4545','','marical','7FE57D9D','1',1,'0',0,NULL,'24.24.129.189',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2007-2-19 13:19:0','2007-2-19 13:22:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3913293550',NULL,'Gino',NULL,'Emil','8989 Crestview Ln.','','Dayton','OH','45405','US','(787) 576-0011',NULL,'','emil@hotmail.com','','VI','32B735CFAFADD28ED66CC4C144EFE091','36B52BCCA7','321','Gino','Emil','','8989 Crestview Ln.','','Dayton','OH','45405','US','(787) 576-0011','','emil','61ED6A93','1',1,'0',0,NULL,'24.24.129.189',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2007-2-19 10:7:0','2007-2-19 10:16:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3913362445',NULL,'Murphey',NULL,'McIntyre',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'murpheymac@gmail.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'murpheymac','6BE56791EAEC97D58226','1',0,'0',0,NULL,'216.128.228.227',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2007-2-20 19:22:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3913427040',NULL,'gh',NULL,'dfg','cvcx','','cvcx','DE','11214','US','32232323',NULL,'','gfdg@tt.com','',NULL,NULL,NULL,NULL,'dg','gdf','','vcx','','cvxcv','CA','11214','US','1111222333','','rok','74EB6F','1',1,'0',0,NULL,'61.95.72.202',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2007-2-21 19:52:0','2007-2-21 19:53:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3913785652',NULL,'ads',NULL,'dsa',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'asd@yahoo.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'asd','37B637C8AAA8','1',0,'0',0,NULL,'125.235.145.150',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2007-2-24 14:12:0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3917017733',NULL,'James',NULL,'McQuarry','7350 Greenhaven Ave. #55',NULL,'Rancho Cucamonga','CA','91730','US','866-855-2278',NULL,'480-287-8981','mcQ@donaldsemp.com','Trade Studios, LLC',NULL,NULL,NULL,NULL,'James','McQuarry','Trade Studios, LLC','7350 Greenhaven Ave. #55',NULL,'Rancho Cucamonga','CA','91730','US',NULL,NULL,'mcQ','6BE755','1',1,'0',0,NULL,'127.0.0.1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2007-3-29 18:46:0','2007-3-30 10:27:0','Customer',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Customers (CustomerID,CustomerName,FirstName,MiddleName,LastName,Address1,Address2,City,State,Zip,Country,Phone,Phone2,Fax,Email,CompanyName,CardName,CardNum,ExpDate,CardCVV,ShipFirstName,ShipLastName,ShipCompanyName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipEmail,UserName,Password,PriceToUse,EmailOK,Discount,Credit,Comments,IPAddress,AffiliateID,RProSID,PaymentTerms,CreditLimit,AffiliateCode,EmailCompany,Website,EmailCompanyOK,Deleted,DateCreated,DateUpdated,UpdatedBy,QB,QB_CONT1,QB_CONT2,QB_CTYPE,QB_TAXABLE,QB_SALESTAXCODE,QB_RESALENUM,QB_REP,QB_TAXITEM,QB_JOBDESC,QB_JOBTYPE,QB_JOBSTATUS,QB_JOBSTART,QB_JOBPROJEND,QB_JOBEND) VALUES('3917045461',NULL,'Martin',NULL,'McGee','7350 Greenhaven Ave. #55',NULL,'Rancho Cucamonga','CA','91730','US','866-855-2278',NULL,'480-287-8981','webmaster@tradestudios.com','Trade Studios, LLC',NULL,NULL,NULL,NULL,'Martin','McGee','Trade Studios, LLC','7350 Greenhaven Ave. #55',NULL,'Rancho Cucamonga','CA','91730','US',NULL,NULL,'sa','76F66B92F0EB89DE82','1',1,'0',0,NULL,'127.0.0.1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2007-3-29 15:28:0','2007-3-29 14:35:0','Customer',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
IF (IDENT_SEED('dbo.Customers') IS NOT NULL )	SET IDENTITY_INSERT dbo.Customers OFF
GO
GO
ALTER TABLE dbo.Customers CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.CustomerSH
-----------------------------------------------------------
ALTER TABLE dbo.CustomerSH NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.CustomerSH
GO

IF (IDENT_SEED('dbo.CustomerSH') IS NOT NULL )	SET IDENTITY_INSERT dbo.CustomerSH ON
INSERT INTO dbo.CustomerSH (SHID,CustomerID,ShipNickName,ShipFirstName,ShipLastName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipCompanyName,ShipEmail) VALUES('14','3843586823','Bobby''s Work','Bobby','McFarrin','1312 Hemmingway Drive',NULL,'Burbank','CA','91408','US','818-745-8749',NULL,'webmaster@tradestudios.com')
INSERT INTO dbo.CustomerSH (SHID,CustomerID,ShipNickName,ShipFirstName,ShipLastName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipCompanyName,ShipEmail) VALUES('16','3843586823','damartman','Martin','McGee','7350 Greenhaven Ave. #55',NULL,'Rancho Cucamonga','CA','91730','US','909-980-5281','Trade Studios, LLC','marty@tradestudios.com')
INSERT INTO dbo.CustomerSH (SHID,CustomerID,ShipNickName,ShipFirstName,ShipLastName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipCompanyName,ShipEmail) VALUES('17','3843586823','Potter','Harry','Potter','Wizard School Blvd.',NULL,'England','UT','85134','US','512-491-7637',NULL,NULL)
INSERT INTO dbo.CustomerSH (SHID,CustomerID,ShipNickName,ShipFirstName,ShipLastName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipCompanyName,ShipEmail) VALUES('18','3843586823','The Mayor','Jerry','Brown','One Market Street',NULL,'San Francisco','CA','94108','US','415-529-7874',NULL,NULL)
INSERT INTO dbo.CustomerSH (SHID,CustomerID,ShipNickName,ShipFirstName,ShipLastName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipCompanyName,ShipEmail) VALUES('19','3909774919','addr2-ship','test','test','555 test',NULL,'test','IL','33009','US','555-121-1212',NULL,NULL)
INSERT INTO dbo.CustomerSH (SHID,CustomerID,ShipNickName,ShipFirstName,ShipLastName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipCompanyName,ShipEmail) VALUES('20','3909774919','addr1-ship','tewt','asfdasdf','dasfadsf',NULL,'asdfdsf','NY','33333','US','55555555',NULL,NULL)
INSERT INTO dbo.CustomerSH (SHID,CustomerID,ShipNickName,ShipFirstName,ShipLastName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipCompanyName,ShipEmail) VALUES('21','3912713545','bla','jack','jack','jkl','jkl','jkl','CA','90210','US','32902','jkl',NULL)
INSERT INTO dbo.CustomerSH (SHID,CustomerID,ShipNickName,ShipFirstName,ShipLastName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipCompanyName,ShipEmail) VALUES('22','3912953013','Ronny Boosh','Ronny','Booshay','787 Walton Dr.',NULL,'Canoga Park','CA','91301','US','(818) 786-6767',NULL,NULL)
INSERT INTO dbo.CustomerSH (SHID,CustomerID,ShipNickName,ShipFirstName,ShipLastName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipCompanyName,ShipEmail) VALUES('23','3912953013','Felix','Felix','Havock','668 Red Rock Ave.',NULL,'Berkeley','CA','90087','US','(787) 789-0098',NULL,NULL)
INSERT INTO dbo.CustomerSH (SHID,CustomerID,ShipNickName,ShipFirstName,ShipLastName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipCompanyName,ShipEmail) VALUES('24','3912988721','Horace','Horacio','Panter','876 Destiny Ave',NULL,'Bisbee','AZ','97897','US','(789) 777-5643',NULL,NULL)
INSERT INTO dbo.CustomerSH (SHID,CustomerID,ShipNickName,ShipFirstName,ShipLastName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipCompanyName,ShipEmail) VALUES('25','3912950543','Jonny','Jonathan','Blitz','7878 Texas Dr.',NULL,'Houston','TX','77002','US','(878) 909-0076',NULL,NULL)
INSERT INTO dbo.CustomerSH (SHID,CustomerID,ShipNickName,ShipFirstName,ShipLastName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipCompanyName,ShipEmail) VALUES('26','3912947747','Darcy','Darcy','Asby','6 Grow St.',NULL,'Dallas',NULL,'78645','US','5122617845',NULL,NULL)
INSERT INTO dbo.CustomerSH (SHID,CustomerID,ShipNickName,ShipFirstName,ShipLastName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipCompanyName,ShipEmail) VALUES('27','3912982564','Rocky','alvin','Monk','1212 Waldorf St.',NULL,'San Francisco','CA','94102','US','(818) 123-4567',NULL,NULL)
INSERT INTO dbo.CustomerSH (SHID,CustomerID,ShipNickName,ShipFirstName,ShipLastName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipCompanyName,ShipEmail) VALUES('28','3912995630','Kramer','Mike','Park','897 Walken Ave',NULL,'Orlando','FL','90087','US','(909) 876-0000',NULL,NULL)
INSERT INTO dbo.CustomerSH (SHID,CustomerID,ShipNickName,ShipFirstName,ShipLastName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipCompanyName,ShipEmail) VALUES('29','3912944350','Woody','Woodrow','Guthrie','787 Mole Dr.',NULL,'Miami','FL','96678','US','(121) 345-9987',NULL,NULL)
INSERT INTO dbo.CustomerSH (SHID,CustomerID,ShipNickName,ShipFirstName,ShipLastName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipCompanyName,ShipEmail) VALUES('30','3912955515','Jojo','Joeseph','Glenn','678 Running Dear Dr.',NULL,'milwaukee','WI','53204','US','(567) 123-5555',NULL,NULL)
INSERT INTO dbo.CustomerSH (SHID,CustomerID,ShipNickName,ShipFirstName,ShipLastName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipCompanyName,ShipEmail) VALUES('31','3912930955','Roy','Roy','Baker','654 31st St.',NULL,'Des Moines','IA','50307','US','(534) 899-6612',NULL,NULL)
INSERT INTO dbo.CustomerSH (SHID,CustomerID,ShipNickName,ShipFirstName,ShipLastName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipCompanyName,ShipEmail) VALUES('32','3912944313','Lance','Lance','Bass','3543 Bristol St.',NULL,'Red Rock','UT','87776','US','(787) 765-1276',NULL,NULL)
INSERT INTO dbo.CustomerSH (SHID,CustomerID,ShipNickName,ShipFirstName,ShipLastName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipCompanyName,ShipEmail) VALUES('33','3912932935','Mikey','Johnny','Lydon','567 Pistol Dr.',NULL,'Peekskill','NY','08876','US','(212) 756-7845',NULL,NULL)
INSERT INTO dbo.CustomerSH (SHID,CustomerID,ShipNickName,ShipFirstName,ShipLastName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipCompanyName,ShipEmail) VALUES('34','3912971559','Jesus','Jesus','Montoya','876 13th St.',NULL,'Denver','CO','80014','US','(987) 567-3246',NULL,NULL)
INSERT INTO dbo.CustomerSH (SHID,CustomerID,ShipNickName,ShipFirstName,ShipLastName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipCompanyName,ShipEmail) VALUES('35','3912927327','Harry','Harold','Palm','22523 Dolorosa St.',NULL,'Woodland Hills','CA','91367','US','(818) 716-2875',NULL,NULL)
INSERT INTO dbo.CustomerSH (SHID,CustomerID,ShipNickName,ShipFirstName,ShipLastName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipCompanyName,ShipEmail) VALUES('36','3912969416','K Kid','Daniel','Lanois','67 Ft. Meyers',NULL,'Chicago','IL','60604','US','(657) 678-3411',NULL,NULL)
INSERT INTO dbo.CustomerSH (SHID,CustomerID,ShipNickName,ShipFirstName,ShipLastName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipCompanyName,ShipEmail) VALUES('37','3913285427','Pete','Pete','Ferguson','6786 Winchester Dr.',NULL,'Fort Worth','TX','76137','US','(789) 456-3214',NULL,NULL)
INSERT INTO dbo.CustomerSH (SHID,CustomerID,ShipNickName,ShipFirstName,ShipLastName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipCompanyName,ShipEmail) VALUES('38','3913293550','Jose','Jose','Cruz','19428 Dawson Creek Pl',NULL,'Walnut','CA','91789','US','(818) 912-5110',NULL,NULL)
INSERT INTO dbo.CustomerSH (SHID,CustomerID,ShipNickName,ShipFirstName,ShipLastName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipCompanyName,ShipEmail) VALUES('39','3913272243','Bugger','Larry','Parker','1313 Bristol Dr.',NULL,'Canoga Park','CA','91301','US','(818) 710-2435',NULL,NULL)
INSERT INTO dbo.CustomerSH (SHID,CustomerID,ShipNickName,ShipFirstName,ShipLastName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipCompanyName,ShipEmail) VALUES('40','3913231112','Killmeister','Brent','Arrowood','22523 Dolorosa St.',NULL,'Woodland Hills','CA','91367','US','(818) 716-2875',NULL,NULL)
INSERT INTO dbo.CustomerSH (SHID,CustomerID,ShipNickName,ShipFirstName,ShipLastName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipCompanyName,ShipEmail) VALUES('41','3913253837','Donny','Donald','Johnson','45 Oak Hills Rd.',NULL,'Rancho Cucamonga','CA','91730','US','(909) 567-5454',NULL,NULL)
INSERT INTO dbo.CustomerSH (SHID,CustomerID,ShipNickName,ShipFirstName,ShipLastName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipCompanyName,ShipEmail) VALUES('42','3913287262','Cece','Clarence','Deville','667 Culotta St',NULL,'Baltimore','MD','21204','US','(787) 546-1248',NULL,NULL)
INSERT INTO dbo.CustomerSH (SHID,CustomerID,ShipNickName,ShipFirstName,ShipLastName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipCompanyName,ShipEmail) VALUES('43','3913229655','Willie','William','Wonder','546 N. Roseland Blvd',NULL,'Biloxi','MS','39531','US','(878) 676-0000',NULL,NULL)
INSERT INTO dbo.CustomerSH (SHID,CustomerID,ShipNickName,ShipFirstName,ShipLastName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipCompanyName,ShipEmail) VALUES('44','3913229655','randomtask','Alex','uychocde','22523 dolorosa st.',NULL,'woodland hills','CA','91367','US','(818) 445-7878',NULL,NULL)
INSERT INTO dbo.CustomerSH (SHID,CustomerID,ShipNickName,ShipFirstName,ShipLastName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipCompanyName,ShipEmail) VALUES('45','3917045461','Gary Donald','Gary','Donald','17 Genesis Blvd.',NULL,'Seattle','WA','98734','US','866-855-2278','Rackspace Inc.','garydonald@directthenet.com')
INSERT INTO dbo.CustomerSH (SHID,CustomerID,ShipNickName,ShipFirstName,ShipLastName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipCompanyName,ShipEmail) VALUES('46','3917045461','Bill College','Bill','College','1 Cable Road',NULL,'Lake Forest','CA','91641','US','866-855-2278','Intuit','billcollege@coldfusioncenter.com')
INSERT INTO dbo.CustomerSH (SHID,CustomerID,ShipNickName,ShipFirstName,ShipLastName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipCompanyName,ShipEmail) VALUES('47','3917045461','Fred Frasier','Fred','Frasier','829 Intermediate Street',NULL,'Daytona','OH','31630','US','866-855-2278','Blastoff Productions','ffrasier@blastoffproductions.com')
INSERT INTO dbo.CustomerSH (SHID,CustomerID,ShipNickName,ShipFirstName,ShipLastName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipCompanyName,ShipEmail) VALUES('48','3917017733','damartman1','Martin','McGee','7350 Greenhaven Ave. #55',NULL,'Rancho Cucamonga','CA','91730','US','866-855-2278','Trade Studios, LLC','marty@tradestudios.com')
INSERT INTO dbo.CustomerSH (SHID,CustomerID,ShipNickName,ShipFirstName,ShipLastName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipCompanyName,ShipEmail) VALUES('49','3917017733','damartman2','Martin','McGee','7350 Greenhaven Ave. #55',NULL,'Rancho Cucamonga','CA','91730','US','866-855-2278','Trade Studios, LLC','marty@tradestudios.com')
INSERT INTO dbo.CustomerSH (SHID,CustomerID,ShipNickName,ShipFirstName,ShipLastName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipCompanyName,ShipEmail) VALUES('50','3917017733','damartman3','Martin','McGee','7350 Greenhaven Ave. #55',NULL,'Rancho Cucamonga','CA','91730','US','866-855-2278','Trade Studios, LLC','marty@tradestudios.com')
INSERT INTO dbo.CustomerSH (SHID,CustomerID,ShipNickName,ShipFirstName,ShipLastName,ShipAddress1,ShipAddress2,ShipCity,ShipState,ShipZip,ShipCountry,ShipPhone,ShipCompanyName,ShipEmail) VALUES('51','3917017733','damartman4','Martin','McGee','7350 Greenhaven Ave. #55',NULL,'Rancho Cucamonga','CA','91730','US','866-855-2278','Trade Studios, LLC','marty@tradestudios.com')
IF (IDENT_SEED('dbo.CustomerSH') IS NOT NULL )	SET IDENTITY_INSERT dbo.CustomerSH OFF
GO
GO
ALTER TABLE dbo.CustomerSH CHECK CONSTRAINT ALL
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
--Insert data into dbo.Dictionary
-----------------------------------------------------------
ALTER TABLE dbo.Dictionary NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.Dictionary
GO

IF (IDENT_SEED('dbo.Dictionary') IS NOT NULL )	SET IDENTITY_INSERT dbo.Dictionary ON
INSERT INTO dbo.Dictionary (DID,Term,Definition,Keywords) VALUES('1','Megapixel','A unit of graphic resolution, 1,048,576 or 220 pixels, the speed at which a graphics card can display data','mega pixel')
INSERT INTO dbo.Dictionary (DID,Term,Definition,Keywords) VALUES('2','shutter','A mechanical device of a camera that controls the duration of a photographic exposure, as by opening and closing to allow light coming through the lens to expose a plate or film.','speed')
IF (IDENT_SEED('dbo.Dictionary') IS NOT NULL )	SET IDENTITY_INSERT dbo.Dictionary OFF
GO
GO
ALTER TABLE dbo.Dictionary CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.Discounts
-----------------------------------------------------------
ALTER TABLE dbo.Discounts NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.Discounts
GO

IF (IDENT_SEED('dbo.Discounts') IS NOT NULL )	SET IDENTITY_INSERT dbo.Discounts ON
INSERT INTO dbo.Discounts (DiscountID,SiteID,DiscountCode,DiscountName,DiscountDesc,DiscountValue,DiscountType,IsPercentage,AutoApply,AllowMultiple,DateValidFrom,DateValidTo,UsageLimitCust,UsageLimitTotal,OrderTotalLevel,OverridesCat,OverridesSec,OverridesOrd,OverridesVol,ApplyToUser,ApplyToType,ApplyTo,QtyLevel,QtyLevelHi,AddPurchaseReq,AddPurchaseVal,ExcludeSelection,Expired,DateCreated,DateUpdated,UpdatedBy) VALUES('1','1','NEW410','10% Off','10% Off for new customers',10,'1',1,1,1,'2005-5-4 0:0:0','2030-12-31 0:0:0','1','0',0,0,0,0,0,'0','2','3','1',NULL,'0',NULL,0,0,'2005-5-4 20:5:0','2006-3-28 11:35:0','ADMIN')
INSERT INTO dbo.Discounts (DiscountID,SiteID,DiscountCode,DiscountName,DiscountDesc,DiscountValue,DiscountType,IsPercentage,AutoApply,AllowMultiple,DateValidFrom,DateValidTo,UsageLimitCust,UsageLimitTotal,OrderTotalLevel,OverridesCat,OverridesSec,OverridesOrd,OverridesVol,ApplyToUser,ApplyToType,ApplyTo,QtyLevel,QtyLevelHi,AddPurchaseReq,AddPurchaseVal,ExcludeSelection,Expired,DateCreated,DateUpdated,UpdatedBy) VALUES('2','1','GIMME20','$20 OFF',NULL,20,'1',0,0,1,'2005-5-4 0:0:0','2007-9-20 0:0:0','0','0',299,0,0,0,0,'0','9','0','1',NULL,'2','11',0,0,'2005-5-4 20:14:0','2006-3-28 15:28:0','ADMIN')
INSERT INTO dbo.Discounts (DiscountID,SiteID,DiscountCode,DiscountName,DiscountDesc,DiscountValue,DiscountType,IsPercentage,AutoApply,AllowMultiple,DateValidFrom,DateValidTo,UsageLimitCust,UsageLimitTotal,OrderTotalLevel,OverridesCat,OverridesSec,OverridesOrd,OverridesVol,ApplyToUser,ApplyToType,ApplyTo,QtyLevel,QtyLevelHi,AddPurchaseReq,AddPurchaseVal,ExcludeSelection,Expired,DateCreated,DateUpdated,UpdatedBy) VALUES('3','1','FREESHIP299','FREE GROUND SHIPPING','Free Shipping for orders over $299',100,'1',1,1,1,'2006-3-20 0:0:0','2006-10-31 0:0:0','0','0',299,0,0,0,0,'0','5','3','1',NULL,'0',NULL,0,0,'2005-5-7 12:1:0','2006-8-28 4:18:0','ADMIN')
INSERT INTO dbo.Discounts (DiscountID,SiteID,DiscountCode,DiscountName,DiscountDesc,DiscountValue,DiscountType,IsPercentage,AutoApply,AllowMultiple,DateValidFrom,DateValidTo,UsageLimitCust,UsageLimitTotal,OrderTotalLevel,OverridesCat,OverridesSec,OverridesOrd,OverridesVol,ApplyToUser,ApplyToType,ApplyTo,QtyLevel,QtyLevelHi,AddPurchaseReq,AddPurchaseVal,ExcludeSelection,Expired,DateCreated,DateUpdated,UpdatedBy) VALUES('4','1','WHOLE10','Wholesale 10%',NULL,10,'1',1,1,1,'2005-1-1 0:0:0','2030-12-31 0:0:0','0','0',0,0,0,0,0,'2','9','0','1',NULL,'0',NULL,0,0,'2005-12-9 8:42:0','2006-3-28 17:16:0','ADMIN')
INSERT INTO dbo.Discounts (DiscountID,SiteID,DiscountCode,DiscountName,DiscountDesc,DiscountValue,DiscountType,IsPercentage,AutoApply,AllowMultiple,DateValidFrom,DateValidTo,UsageLimitCust,UsageLimitTotal,OrderTotalLevel,OverridesCat,OverridesSec,OverridesOrd,OverridesVol,ApplyToUser,ApplyToType,ApplyTo,QtyLevel,QtyLevelHi,AddPurchaseReq,AddPurchaseVal,ExcludeSelection,Expired,DateCreated,DateUpdated,UpdatedBy) VALUES('5','1','Canon350','10% Off ~ SLR',NULL,10,'1',1,0,1,'2006-1-20 0:0:0','2030-12-31 0:0:0','0','0',0,0,0,0,0,'0','3','7','1',NULL,'3','7',0,0,'2006-3-20 23:20:0','2007-3-25 12:51:0','ADMIN')
IF (IDENT_SEED('dbo.Discounts') IS NOT NULL )	SET IDENTITY_INSERT dbo.Discounts OFF
GO
GO
ALTER TABLE dbo.Discounts CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.DiscountUsage
-----------------------------------------------------------
ALTER TABLE dbo.DiscountUsage NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.DiscountUsage
GO

IF (IDENT_SEED('dbo.DiscountUsage') IS NOT NULL )	SET IDENTITY_INSERT dbo.DiscountUsage ON
IF (IDENT_SEED('dbo.DiscountUsage') IS NOT NULL )	SET IDENTITY_INSERT dbo.DiscountUsage OFF
GO
GO
ALTER TABLE dbo.DiscountUsage CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.Distributors
-----------------------------------------------------------
ALTER TABLE dbo.Distributors NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.Distributors
GO

IF (IDENT_SEED('dbo.Distributors') IS NOT NULL )	SET IDENTITY_INSERT dbo.Distributors ON
INSERT INTO dbo.Distributors (DistributorID,DistributorName,CompanyName,FirstName,LastName,Address1,Address2,City,State,Country,Zipcode,RepName,Email,Phone,AltPhone,Fax,WebSiteURL,TaxID,POFormat,OrdersAcceptedBy,Comments,DateCreated,DateUpdated,UpdatedBy,Deleted,QB,QB_LIMIT,QB_TERMS,QB_VTYPE,QB_1099) VALUES('1','B&H Photo',NULL,NULL,NULL,'420 Ninth Avenue',NULL,'New York','NY','US','10001','Chuck Capriola','orders@cartfusion.net','800.688.9421','212.444.5014','800.947.7008',NULL,NULL,'0','1:30 pm',NULL,'2005-5-1 20:10:0','2006-5-24 14:48:0','ADMIN',NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Distributors (DistributorID,DistributorName,CompanyName,FirstName,LastName,Address1,Address2,City,State,Country,Zipcode,RepName,Email,Phone,AltPhone,Fax,WebSiteURL,TaxID,POFormat,OrdersAcceptedBy,Comments,DateCreated,DateUpdated,UpdatedBy,Deleted,QB,QB_LIMIT,QB_TERMS,QB_VTYPE,QB_1099) VALUES('2','Tri-State Camera',NULL,NULL,NULL,'483 Highland Ct.',NULL,'Longmont','DE','US','20147','Mark Ressinger','orders@cartfusion.net','245-298-3763',NULL,'245-298-3764',NULL,NULL,'0','4:00 pm',NULL,'2005-5-2 21:20:0','2005-5-2 21:20:0','ADMIN',NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Distributors (DistributorID,DistributorName,CompanyName,FirstName,LastName,Address1,Address2,City,State,Country,Zipcode,RepName,Email,Phone,AltPhone,Fax,WebSiteURL,TaxID,POFormat,OrdersAcceptedBy,Comments,DateCreated,DateUpdated,UpdatedBy,Deleted,QB,QB_LIMIT,QB_TERMS,QB_VTYPE,QB_1099) VALUES('3','Wolf Camera',NULL,NULL,NULL,'483 Highland Ct.','Suite 108','San Francisco','CA','US','94105','Pete Wolf','orders@cartfusion.net','800-495-0976','415-495-0976','800-495-0977',NULL,NULL,'0','2:00 pm',NULL,'2005-5-6 18:41:0','2006-5-24 14:49:0','ADMIN',NULL,NULL,NULL,NULL,NULL,NULL)
IF (IDENT_SEED('dbo.Distributors') IS NOT NULL )	SET IDENTITY_INSERT dbo.Distributors OFF
GO
GO
ALTER TABLE dbo.Distributors CHECK CONSTRAINT ALL
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
--Insert data into dbo.ItemClassComponents
-----------------------------------------------------------
ALTER TABLE dbo.ItemClassComponents NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.ItemClassComponents
GO

IF (IDENT_SEED('dbo.ItemClassComponents') IS NOT NULL )	SET IDENTITY_INSERT dbo.ItemClassComponents ON
INSERT INTO dbo.ItemClassComponents (ICCID,ItemClassID,ItemID,Detail1,Detail2,Detail3,CompPrice,CompQuantity,CompStatus,CompSellByStock,Image,QB) VALUES('2360','2','29','Black',NULL,NULL,0,'1000','IS',1,'B0000TMP2M.jpg',NULL)
INSERT INTO dbo.ItemClassComponents (ICCID,ItemClassID,ItemID,Detail1,Detail2,Detail3,CompPrice,CompQuantity,CompStatus,CompSellByStock,Image,QB) VALUES('2362','1','30','Black','Small',NULL,0,'1','IS',1,'B0009B1ZP4.jpg',NULL)
INSERT INTO dbo.ItemClassComponents (ICCID,ItemClassID,ItemID,Detail1,Detail2,Detail3,CompPrice,CompQuantity,CompStatus,CompSellByStock,Image,QB) VALUES('2363','1','30','Black','Medium',NULL,1,'3','BO',1,'B0009B1ZP4.jpg',NULL)
INSERT INTO dbo.ItemClassComponents (ICCID,ItemClassID,ItemID,Detail1,Detail2,Detail3,CompPrice,CompQuantity,CompStatus,CompSellByStock,Image,QB) VALUES('2364','1','30','Black','Large',NULL,2,'0','IS',1,'B0009B1ZP4.jpg',NULL)
INSERT INTO dbo.ItemClassComponents (ICCID,ItemClassID,ItemID,Detail1,Detail2,Detail3,CompPrice,CompQuantity,CompStatus,CompSellByStock,Image,QB) VALUES('2365','1','30','Brown','Small',NULL,0,'0','OS',0,'B0009B1ZPO.jpg',NULL)
INSERT INTO dbo.ItemClassComponents (ICCID,ItemClassID,ItemID,Detail1,Detail2,Detail3,CompPrice,CompQuantity,CompStatus,CompSellByStock,Image,QB) VALUES('2366','1','30','Brown','Medium',NULL,1,'-10','IS',0,'B0009B1ZPO.jpg',NULL)
INSERT INTO dbo.ItemClassComponents (ICCID,ItemClassID,ItemID,Detail1,Detail2,Detail3,CompPrice,CompQuantity,CompStatus,CompSellByStock,Image,QB) VALUES('2367','1','30','Brown','Large',NULL,2,'14','IS',1,'B0009B1ZPO.jpg',NULL)
INSERT INTO dbo.ItemClassComponents (ICCID,ItemClassID,ItemID,Detail1,Detail2,Detail3,CompPrice,CompQuantity,CompStatus,CompSellByStock,Image,QB) VALUES('2368','1','31','Black','One Size Fits All',NULL,0,'96','IS',1,'16009.jpg',NULL)
INSERT INTO dbo.ItemClassComponents (ICCID,ItemClassID,ItemID,Detail1,Detail2,Detail3,CompPrice,CompQuantity,CompStatus,CompSellByStock,Image,QB) VALUES('2369','1','31','Navy','One Size Fits All',NULL,0,'97','IS',1,'16011.jpg',NULL)
INSERT INTO dbo.ItemClassComponents (ICCID,ItemClassID,ItemID,Detail1,Detail2,Detail3,CompPrice,CompQuantity,CompStatus,CompSellByStock,Image,QB) VALUES('2370','1','31','Olive','One Size Fits All',NULL,0,'99','IS',1,'257990.jpg',NULL)
INSERT INTO dbo.ItemClassComponents (ICCID,ItemClassID,ItemID,Detail1,Detail2,Detail3,CompPrice,CompQuantity,CompStatus,CompSellByStock,Image,QB) VALUES('2371','1','31','Sand','One Size Fits All',NULL,0,'96','IS',1,'16012.jpg',NULL)
INSERT INTO dbo.ItemClassComponents (ICCID,ItemClassID,ItemID,Detail1,Detail2,Detail3,CompPrice,CompQuantity,CompStatus,CompSellByStock,Image,QB) VALUES('2372','2','32','Black',NULL,NULL,0,'10','IS',1,NULL,NULL)
INSERT INTO dbo.ItemClassComponents (ICCID,ItemClassID,ItemID,Detail1,Detail2,Detail3,CompPrice,CompQuantity,CompStatus,CompSellByStock,Image,QB) VALUES('2373','2','32','Forest Green',NULL,NULL,0,'10','IS',1,NULL,NULL)
INSERT INTO dbo.ItemClassComponents (ICCID,ItemClassID,ItemID,Detail1,Detail2,Detail3,CompPrice,CompQuantity,CompStatus,CompSellByStock,Image,QB) VALUES('2374','2','32','Royal Blue',NULL,NULL,0,'9','IS',1,NULL,NULL)
INSERT INTO dbo.ItemClassComponents (ICCID,ItemClassID,ItemID,Detail1,Detail2,Detail3,CompPrice,CompQuantity,CompStatus,CompSellByStock,Image,QB) VALUES('2375','2','32','Red',NULL,NULL,0,'10','IS',1,NULL,NULL)
IF (IDENT_SEED('dbo.ItemClassComponents') IS NOT NULL )	SET IDENTITY_INSERT dbo.ItemClassComponents OFF
GO
GO
ALTER TABLE dbo.ItemClassComponents CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.ItemClasses
-----------------------------------------------------------
ALTER TABLE dbo.ItemClasses NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.ItemClasses
GO

IF (IDENT_SEED('dbo.ItemClasses') IS NOT NULL )	SET IDENTITY_INSERT dbo.ItemClasses ON
INSERT INTO dbo.ItemClasses (ICID,Description,Dimensions,Title1,Title2,Title3,ClassType,ItemCode) VALUES('1','Color & Size','2','Color','Size',NULL,'1','CS2')
INSERT INTO dbo.ItemClasses (ICID,Description,Dimensions,Title1,Title2,Title3,ClassType,ItemCode) VALUES('2','Color','1','Color',NULL,NULL,'2','CLR1')
INSERT INTO dbo.ItemClasses (ICID,Description,Dimensions,Title1,Title2,Title3,ClassType,ItemCode) VALUES('3','Size','1','Size',NULL,NULL,'3','SZ1')
INSERT INTO dbo.ItemClasses (ICID,Description,Dimensions,Title1,Title2,Title3,ClassType,ItemCode) VALUES('4','Style','1','Style',NULL,NULL,'4','ST1')
INSERT INTO dbo.ItemClasses (ICID,Description,Dimensions,Title1,Title2,Title3,ClassType,ItemCode) VALUES('5','Style & Color','2','Style','Color',NULL,'5','SC2')
INSERT INTO dbo.ItemClasses (ICID,Description,Dimensions,Title1,Title2,Title3,ClassType,ItemCode) VALUES('6','Style & Size','2','Style','Size',NULL,'6','SS2')
IF (IDENT_SEED('dbo.ItemClasses') IS NOT NULL )	SET IDENTITY_INSERT dbo.ItemClasses OFF
GO
GO
ALTER TABLE dbo.ItemClasses CHECK CONSTRAINT ALL
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
--Insert data into dbo.Manufacturers
-----------------------------------------------------------
ALTER TABLE dbo.Manufacturers NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.Manufacturers
GO

IF (IDENT_SEED('dbo.Manufacturers') IS NOT NULL )	SET IDENTITY_INSERT dbo.Manufacturers ON
IF (IDENT_SEED('dbo.Manufacturers') IS NOT NULL )	SET IDENTITY_INSERT dbo.Manufacturers OFF
GO
GO
ALTER TABLE dbo.Manufacturers CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.MessageCenter
-----------------------------------------------------------
ALTER TABLE dbo.MessageCenter NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.MessageCenter
GO

IF (IDENT_SEED('dbo.MessageCenter') IS NOT NULL )	SET IDENTITY_INSERT dbo.MessageCenter ON
INSERT INTO dbo.MessageCenter (MCID,Message,Customers,DateCreated,ValidFrom,ValidTo,CreatedBy,UpdatedBy) VALUES('3','<p>Hello Marty!</p>
<p>Thank you for shopping with CartFusion.net</p>','3843586823','2005-5-7 9:26:0','2005-5-7 0:0:0','2005-8-7 23:59:0','ADMIN',NULL)
INSERT INTO dbo.MessageCenter (MCID,Message,Customers,DateCreated,ValidFrom,ValidTo,CreatedBy,UpdatedBy) VALUES('4','Hey Budd','3887311854','2006-6-5 4:35:0','2006-6-5 0:0:0',NULL,'DEMO',NULL)
IF (IDENT_SEED('dbo.MessageCenter') IS NOT NULL )	SET IDENTITY_INSERT dbo.MessageCenter OFF
GO
GO
ALTER TABLE dbo.MessageCenter CHECK CONSTRAINT ALL
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
--Insert data into dbo.Messages
-----------------------------------------------------------
ALTER TABLE dbo.Messages NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.Messages
GO

IF (IDENT_SEED('dbo.Messages') IS NOT NULL )	SET IDENTITY_INSERT dbo.Messages ON
INSERT INTO dbo.Messages (MessageID,Message,Urgency,Done,DateCreated,CreatedBy,DateUpdated,UpdatedBy) VALUES('1','Remember to send lense to Richard Parsons','2',1,'2005-5-7 9:40:0','ADMIN',NULL,'ADMIN')
INSERT INTO dbo.Messages (MessageID,Message,Urgency,Done,DateCreated,CreatedBy,DateUpdated,UpdatedBy) VALUES('2','Pat - please remember to credit James Milner''s credit card $46.51 for the tax discount.','1',0,'2005-5-7 9:56:0','ADMIN',NULL,'ADMIN')
INSERT INTO dbo.Messages (MessageID,Message,Urgency,Done,DateCreated,CreatedBy,DateUpdated,UpdatedBy) VALUES('3','Just a note to pick up coffee for the office!','3',0,'2005-5-7 10:1:0','ADMIN',NULL,NULL)
INSERT INTO dbo.Messages (MessageID,Message,Urgency,Done,DateCreated,CreatedBy,DateUpdated,UpdatedBy) VALUES('5','test note!','3',0,'2006-3-28 5:50:0','DEMO',NULL,NULL)
IF (IDENT_SEED('dbo.Messages') IS NOT NULL )	SET IDENTITY_INSERT dbo.Messages OFF
GO
GO
ALTER TABLE dbo.Messages CHECK CONSTRAINT ALL
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
--Insert data into dbo.OrderItems
-----------------------------------------------------------
ALTER TABLE dbo.OrderItems NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.OrderItems
GO

IF (IDENT_SEED('dbo.OrderItems') IS NOT NULL )	SET IDENTITY_INSERT dbo.OrderItems ON
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('2','1002766','1','3',849.95,'2005-12-2 22:35:0','','','',0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('3','1002767','1','5',449.99,'2005-12-2 22:39:0','','','',0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('4','1002768','1','3',849.95,'2005-12-2 22:43:0','','','',0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('5','1002769','1','2',699.95,'2005-12-2 22:47:0','','','',0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('6','1002730','1','2',699.95,'2005-6-3 9:39:0',NULL,NULL,NULL,0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('7','1002730','1','15',149.99,'2005-6-3 9:40:0',NULL,NULL,NULL,0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('8','1002701','1','1',269.95,'2005-5-6 0:0:0',NULL,NULL,NULL,0,'SH',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('9','1002702','1','9',529.99,'2005-5-2 21:12:0',NULL,NULL,NULL,0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('10','1002703','1','6',329.95,'2005-5-6 0:0:0',NULL,NULL,NULL,0,'SH',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('11','1002703','1','12',199.95,'2005-5-6 0:0:0',NULL,NULL,NULL,0,'SH',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('12','1002700','2','15',149.99,'2005-5-2 21:33:0',NULL,NULL,NULL,0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('13','1002704','1','24',197.95,'2005-5-4 20:7:0',NULL,NULL,NULL,0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('14','1002705','1','23',89.99,'2005-5-6 0:0:0',NULL,NULL,NULL,0,'SH','2005-5-6 14:43:0','ADMIN',NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('15','1002706','1','2',699.95,'2005-5-6 0:0:0',NULL,NULL,NULL,0,'PR','2005-5-6 9:2:0','ADMIN',NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('16','1002706','1','5',449.99,'2005-5-6 0:0:0',NULL,NULL,NULL,0,'SH','2005-5-6 9:2:0','ADMIN',NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('17','1002707','1','22',269.95,'2005-5-5 20:28:0',NULL,NULL,NULL,0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('18','1002707','2','23',89.99,'2005-5-6 8:2:0',NULL,NULL,NULL,0,'RE','2005-5-6 8:2:0','ADMIN',NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('19','1002708','1','21',187.49,'2005-5-13 0:0:0',NULL,NULL,NULL,0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('20','1002709','1','10',349.99,'2005-5-6 0:0:0',NULL,NULL,NULL,0,'SH',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('21','1002709','1','16',199.95,'2005-5-6 0:0:0',NULL,NULL,NULL,0,'SH',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('22','1002709','1','28',599.95,'2005-5-13 0:0:0',NULL,NULL,NULL,0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('23','1002709','1','7',899.95,'2005-5-6 0:0:0',NULL,NULL,NULL,0,'SH',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('24','1002710','3','19',399.95,'2005-5-6 0:0:0',NULL,NULL,NULL,0,'SH',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('25','1002711','1','23',89.99,'2006-5-24 0:0:0',NULL,NULL,NULL,0,'SH',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('26','1002712','1','13',399.95,'2005-5-7 0:0:0',NULL,NULL,NULL,0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('27','1002713','1','28',599.95,'2005-5-7 8:25:0',NULL,NULL,NULL,0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('28','1002714','1','8',239.99,'2005-5-9 0:0:0',NULL,NULL,NULL,0,'SH',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('29','1002715','3','5',449.99,'2005-5-13 0:0:0',NULL,NULL,NULL,0,'SH',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('30','1002715','1','12',199.95,'2005-5-13 0:0:0',NULL,NULL,NULL,0,'SH',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('31','1002715','1','17',229.95,'2005-5-13 0:0:0',NULL,NULL,NULL,0,'SH',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('32','1002715','1','19',399.99,'2005-5-10 6:9:0',NULL,NULL,NULL,0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('33','1002715','2','24',197.95,'2005-12-13 18:13:0',NULL,NULL,NULL,0,'BP','2005-12-13 18:13:0','MARTY',NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('34','1002716','1','23',89.99,'2005-5-10 15:26:0',NULL,NULL,NULL,0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('35','1002712','1','23',89.99,'2005-5-10 17:56:0',NULL,NULL,NULL,0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('36','1002717','1','5',0,'2005-6-15 15:15:0',NULL,NULL,NULL,0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('37','1002717','1','3',0,'2005-6-15 15:16:0',NULL,NULL,NULL,0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('38','1002717','1','18',224.99,'2005-6-20 23:19:0',NULL,NULL,NULL,0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('39','1002719','1','22',269.95,'2005-6-21 14:42:0','16MB Memory Stick',NULL,NULL,0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('40','1002718','1','20',299.99,'2005-6-21 14:42:0',NULL,NULL,NULL,0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('41','1002720','1','3',849.95,'2005-6-21 14:57:0',NULL,NULL,NULL,0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('42','1002721','1','5',449.99,'2005-6-21 14:58:0',NULL,NULL,NULL,0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('43','1002721','1','19',399.99,'2006-5-24 0:0:0',NULL,NULL,NULL,0,'SH',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('44','1002722','1','2',699.95,'2005-6-21 15:39:0',NULL,NULL,NULL,0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('45','1002722','1','15',149.99,'2005-6-21 15:39:0',NULL,NULL,NULL,0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('46','1002723','1','3',849.95,'2005-6-21 15:43:0',NULL,NULL,NULL,0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('47','1002725','10','2',699.95,'2005-6-22 8:20:0',NULL,NULL,NULL,0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('48','1002726','3','3',849.95,'2005-6-22 13:58:0',NULL,NULL,NULL,0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('49','1002727','1','3',849.95,'2005-6-22 21:22:0',NULL,NULL,NULL,0,'SH',NULL,NULL,'65464132132','0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('50','1002728','1','3',849.95,'2005-6-22 21:33:0',NULL,NULL,NULL,0,'SH',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('51','1002729','1','18',299.99,'2005-6-23 15:57:0',NULL,NULL,NULL,0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('52','1002730','10','19',399.99,'2005-6-23 15:58:0',NULL,NULL,NULL,0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('53','1002731','1','3',849.95,'2005-6-23 18:27:0',NULL,NULL,NULL,0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('54','1002732','1','19',399.99,'2006-5-24 0:0:0',NULL,NULL,NULL,0,'SH',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('55','1002733','1','3',849.95,'2005-6-24 2:42:0',NULL,NULL,NULL,0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('56','1002734','1','3',849.95,'2005-6-30 16:3:0',NULL,NULL,NULL,0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('57','1002735','1','1',269.95,'2005-8-4 21:12:0',NULL,NULL,NULL,0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('58','1002736','1','2',699.95,'2005-8-20 19:43:0',NULL,NULL,NULL,0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('59','1002737','2','22',358.95,'2005-8-22 11:40:0','256MB Memory Stick',NULL,NULL,0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('60','1002738','1','4',349.99,'2005-9-19 0:0:0',NULL,NULL,NULL,0,'PR','2005-8-22 11:45:0','DEMO',NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('61','1002738','1','6',329.95,'2005-9-19 0:0:0',NULL,NULL,NULL,0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('62','1002737','1','16',199.95,'2005-8-24 15:9:0',NULL,NULL,NULL,0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('63','1002739','1','22',269.95,'2005-9-6 15:8:0','128MB Memory Stick',NULL,NULL,0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('64','1002740','1','17',229.95,'2005-9-24 17:5:0',NULL,NULL,NULL,0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('65','1002741','1','10',349.99,'2005-9-27 15:45:0',NULL,NULL,NULL,0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('66','1002742','1','10',349.99,'2005-9-27 15:47:0',NULL,NULL,NULL,0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('67','1002743','1','19',399.99,'2006-5-24 0:0:0',NULL,NULL,NULL,0,'SH',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('68','1002744','1','5',449.99,'2005-9-27 16:34:0',NULL,NULL,NULL,0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('69','1002745','1','2',699.95,'2005-9-27 16:39:0',NULL,NULL,NULL,0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('70','1002745','1','5',449.99,'2005-9-27 16:39:0',NULL,NULL,NULL,0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('71','1002746','1','2',699.95,'2005-9-27 16:40:0',NULL,NULL,NULL,0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('72','1002746','1','5',449.99,'2005-9-27 16:40:0',NULL,NULL,NULL,0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('73','1002747','1','9',529.99,'2005-9-27 16:43:0',NULL,NULL,NULL,0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('74','1002748','1','1',269.95,'2005-10-4 14:59:0',NULL,NULL,NULL,0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('75','1002749','1','9',529.99,'2005-10-5 9:1:0',NULL,NULL,NULL,0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('76','1002750','1','9',529.99,'2005-10-5 9:4:0',NULL,NULL,NULL,0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('77','1002751','1','5',350,'2005-10-5 9:7:0',NULL,NULL,NULL,0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('78','1002752','3','6',247.4625,'2005-10-5 9:17:0',NULL,NULL,NULL,0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('79','1002752','2','15',112.4925,'2005-10-5 9:17:0',NULL,NULL,NULL,0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('80','1002753','1','5',449.99,'2005-10-11 19:44:0',NULL,NULL,NULL,0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('81','1002754','1','3',849.95,'2005-10-11 19:46:0',NULL,NULL,NULL,0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('82','1002755','1','3',849.95,'2005-10-11 19:48:0',NULL,NULL,NULL,0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('83','1002756','1','2',699.95,'2005-10-11 19:56:0',NULL,NULL,NULL,0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('84','1002757','1','2',699.95,'2005-10-11 20:3:0',NULL,NULL,NULL,0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('85','1002758','1','4',349.99,'2005-10-11 20:4:0',NULL,NULL,NULL,0,'SH',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('86','1002759','2','4',349.99,'2005-10-13 10:34:0',NULL,NULL,NULL,0,'BP','2005-10-13 10:34:0','DEMO',NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('87','1002760','1','2',699.95,'2005-10-11 20:34:0',NULL,NULL,NULL,0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('88','1002761','1','2',699.95,'2005-10-11 20:46:0',NULL,NULL,NULL,0,'BP',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('89','1002762','1','3',849.95,'2005-10-19 22:19:0',NULL,NULL,NULL,0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('90','1002763','1','3',849.95,'2005-10-25 20:14:0',NULL,NULL,NULL,0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('91','1002764','1','1',269.95,'2005-11-30 15:43:0',NULL,NULL,NULL,0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('92','1002770','1','2',699.95,'2005-12-3 9:45:0','','','',0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('93','1002770','1','4',349.99,'2005-12-3 19:2:0','','','',0,'PR','2005-12-3 19:2:0','MARTY',NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('94','1002771','1','2',699.95,'2005-12-3 11:31:0','','','',0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('95','1002774','1','2',1048.95,'2005-12-4 22:9:0','Black','55-85mm Lens','Leather Case',0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('96','1002774','1','2',1058.95,'2005-12-4 22:9:0','Black / Silver','55-85mm Lens','Leather Case',0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('97','1002774','1','29',11.99,'2006-5-24 0:0:0','Black','','',0,'SH',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('98','1002774','1','30',7.49,'2005-12-4 22:9:0','Brown','Small','',0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('99','1002774','1','30',8.49,'2005-12-4 22:9:0','Black','Medium','',0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('100','1002774','1','30',9.49,'2005-12-4 22:9:0','Brown','Large','',0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('101','1002773','1','22',269.95,'2005-12-5 9:42:0',NULL,NULL,NULL,0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('102','1002773','1','13',399.99,'2005-12-5 9:42:0',NULL,NULL,NULL,0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('103','1002773','2','29',11.99,'2005-12-5 9:42:0',NULL,NULL,NULL,0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('104','1002775','1','3',849.95,'2005-12-5 9:48:0','','','',0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('105','1002775','1','30',8.49,'2005-12-5 9:48:0','Brown','Medium','',0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('106','1002776','1','3',849.95,'2005-12-5 9:50:0','','','',0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('107','1002724','1','13',399.99,'2005-12-6 23:2:0',NULL,NULL,NULL,0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('108','1002777','1','2',1048.95,'2005-12-13 17:36:0','Black','55-85mm Lens','Leather Case',0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('109','1002777','1','18',299.99,'2005-12-13 17:36:0','','','',0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('110','1002778','1','23',89.99,'2005-12-13 17:38:0','','','',0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('111','1002778','1','23',89.99,'2006-3-18 2:38:0',NULL,NULL,NULL,0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('112','1002778','1','18',299.99,'2006-3-18 2:38:0',NULL,NULL,NULL,0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('113','1002779','1','5',404.99,'2006-3-20 23:31:0','','','',0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('114','1002780','1','5',314.99,'2006-3-20 23:31:0','','','',0,'SH',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('115','1002780','1','10',244.99,'2006-3-20 23:31:0','','','',0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('116','1002781','4','5',314.99,'2006-3-21 10:17:0','','','',0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('117','1002782','1','3',849.95,'2006-3-28 16:37:0','','','',0,'SH',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('118','1002782','3','8',239.99,'2006-3-28 16:37:0','','','',0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('119','1002782','1','11',419.99,'2006-3-28 16:37:0','','','',0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('120','1002782','1','13',399.99,'2006-3-28 16:37:0','','','',0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('121','1002783','1','3',849.95,'2006-3-28 16:55:0','','','',0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('122','1002783','1','6',329.95,'2006-3-28 16:55:0','','','',0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('123','1002784','1','3',849.95,'2006-5-24 0:0:0','','','',0,'SH',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('124','1002784','1','8',239.99,'2006-5-24 0:0:0','','','',0,'SH',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('125','1002784','1','11',419.99,'2006-5-24 0:0:0','','','',0,'SH',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('126','1002784','1','13',399.99,'2006-5-24 0:0:0','','','',0,'SH',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('127','1002785','1','2',999.95,'2006-5-24 0:0:0','Black','55-85mm Lens','',0,'SH',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('128','1002785','1','11',419.99,'2006-5-24 0:0:0','','','',0,'SH',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('129','1002786','1','3',849.95,'2006-5-24 0:0:0','','','',0,'SH',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('130','1002786','1','6',329.95,'2006-5-24 0:0:0','','','',0,'SH',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('131','1002786','1','7',899.95,'2006-5-24 0:0:0','','','',0,'SH',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('132','1002786','1','14',299.99,'2006-5-24 0:0:0','','','',0,'SH',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('133','1002786','1','18',299.99,'2006-5-24 0:0:0','','','',0,'SH',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('134','1002787','4','3',849.95,'2006-5-24 0:0:0','','','',0,'SH',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('135','1002787','1','4',349.99,'2006-5-24 0:0:0','','','',0,'SH',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('136','1002787','1','6',329.95,'2006-5-24 0:0:0','','','',0,'SH',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('137','1002787','1','13',399.99,'2006-5-24 0:0:0','','','',0,'SH',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('138','1002787','1','17',229.95,'2006-5-24 0:0:0','','','',0,'SH',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('139','1002787','1','29',11.99,'2006-4-6 21:33:0',NULL,NULL,NULL,0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('140','1002787','1','17',229.95,'2006-5-24 0:0:0',NULL,NULL,NULL,0,'SH',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('141','1002789','5','5',449.99,'2006-5-24 0:0:0','','','',0,'SH',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('142','1002790','8','8',239.99,'2006-5-24 0:0:0','','','',0,'SH',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('143','1002790','1','23',89.99,'2006-5-24 0:0:0',NULL,NULL,NULL,0,'SH',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('144','1002778','1','27',899.95,'2006-5-2 17:58:0',NULL,NULL,NULL,0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('145','1002778','1','5',449.99,'2006-5-2 17:58:0',NULL,NULL,NULL,0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('146','1002785','1','2',699.95,'2006-5-24 0:0:0','Black','55-85mm Lens','Leather Case',0,'SH',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('147','1002785','1','30',7.49,'2006-5-24 0:0:0',NULL,NULL,NULL,0,'SH',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('148','1002781','1','3',849.95,'2006-5-4 8:28:0',NULL,NULL,NULL,0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('149','1002792','1','15',149.99,'2006-5-24 0:0:0',NULL,NULL,NULL,0,'SH',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('150','1002792','1','11',419.99,'2006-5-24 0:0:0',NULL,NULL,NULL,0,'SH',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('151','1002793','4','1',269.95,'2006-5-24 0:0:0',NULL,NULL,NULL,0,'SH',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('152','1002794','1','3',849.95,'2006-5-24 0:0:0','','','',0,'SH',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('153','1002794','1','13',399.99,'2006-5-24 0:0:0','','','',0,'SH',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('154','1002794','1','20',299.99,'2006-5-24 14:21:0','','','',0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('155','1002794','1','29',11.99,'2006-5-24 0:0:0','Black','','',0,'SH',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('156','1002795','1','3',849.95,'2006-5-24 0:0:0','','','',0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('157','1002795','1','5',449.99,'2006-5-24 0:0:0','','','',0,'SH',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('158','1002795','1','11',419.99,'2006-5-24 0:0:0','','','',0,'SH',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('159','1002795','1','16',199.95,'2006-5-24 0:0:0','','','',0,'SH',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('160','1002795','1','20',299.99,'2006-5-24 14:32:0','','','',0,'SH',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('161','1002796','1','24',197.95,'2006-6-5 4:13:0','','','',0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('162','1002797','1','3',849.95,'2006-7-28 0:0:0',NULL,NULL,NULL,0,'CA',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('163','1002797','1','22',269.95,'2006-6-13 11:36:0',NULL,NULL,NULL,0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('164','1002798','1','24',197.95,'2006-6-13 11:48:0',NULL,NULL,NULL,0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('166','1002798','1','25',220,'2006-6-13 11:50:0',NULL,NULL,NULL,0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('167','1002799','1','1',269.95,'2006-6-13 18:50:0','','','',0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('168','1002800','1','2',699.95,'2006-6-13 19:33:0','Black','55-85mm Lens','Leather Case',0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('169','1002800','1','25',220,'2006-6-13 19:33:0',NULL,NULL,NULL,0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('170','1002801','1','15',149.99,'2006-6-13 19:43:0','','','',0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('171','1002791','1','26',279.99,'2006-6-13 19:53:0',NULL,NULL,NULL,0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('172','1002802','1','28',599.95,'2006-6-13 20:30:0','','','',0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('173','1002803','1','2',1058.95,'2006-6-13 20:39:0','Black / Silver','55-85mm Lens','Leather Case',0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('174','1002804','1','19',399.99,'2006-6-13 0:0:0','','','',0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('175','1002805','1','4',349.99,'2006-6-13 20:56:0','','','',0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('176','1002805','1','12',199.95,'2006-6-13 20:56:0','','','',0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('177','1002806','1','14',299.99,'2006-6-13 21:28:0','','','',0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('178','1002807','3','5',449.99,'2006-7-26 17:59:0','','','',0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('179','1002808','1','1',269.95,'2006-7-27 13:11:0','','','',0,'PR',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('180','1002810','1','3',849.95,'2006-8-27 3:53:0','','','',0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('181','1002810','2','23',89.99,'2006-8-27 3:53:0','','','',0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('182','1002810','4','31',29.95,'2006-8-27 3:53:0','Sand','One Size Fits All','',0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('184','1002811','1','7',899.95,'2006-8-28 0:47:0','','','',0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('185','1002812','1','19',399.99,'2006-8-28 1:18:0','','','',0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('186','1002813','1','10',349.99,'2006-8-28 1:23:0','','','',0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('187','1002814','1','10',349.99,'2006-8-28 1:24:0','','','',0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('188','1002815','1','4',349.99,'2006-8-28 1:25:0','','','',0,'BO',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('189','1002816','1','31',59.95,'2006-8-28 0:0:0','Olive','One Size Fits All','',0,'BO',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('190','1002817','1','9',529.99,'2006-8-28 2:12:0','','','',0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('191','1002817','1','27',899.95,'2006-8-28 2:12:0','','','',0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('192','1002818','1','7',899.95,'2006-8-28 4:39:0','','','',0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('193','1002818','1','21',249.99,'2006-8-28 4:39:0','','','',0,'RE',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('196','1002819','1','29',11.99,'2006-8-28 10:19:0','Black','','',0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('197','1002820','1','29',11.99,'2006-8-28 10:20:0','Black','','',0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('198','1002821','1','4',349.99,'2006-9-11 17:2:0','','','',0,'BO',NULL,NULL,NULL,'14','Bobby','McFarrin','','1312 Hemmingway Drive','','Burbank','CA','91408','US','818-745-8749','webmaster@tradestudios.com',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('199','1002821','1','8',239.99,'2006-9-11 17:2:0','','','',0,'OD',NULL,NULL,NULL,'16','Martin','McGee','Trade Studios, LLC','7350 Greenhaven Ave. #55','','Rancho Cucamonga','CA','91730','US','909-980-5281','marty@tradestudios.com',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('200','1002821','1','28',599.95,'2006-9-11 17:2:0','','','',0,'OD',NULL,NULL,NULL,'16','Martin','McGee','Trade Studios, LLC','7350 Greenhaven Ave. #55','','Rancho Cucamonga','CA','91730','US','909-980-5281','marty@tradestudios.com',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('201','1002821','1','29',11.99,'2006-9-11 17:2:0','Black','','',0,'OD',NULL,NULL,NULL,'0','Martin','McGee','Trade Studios, LLC','7350 Greenhaven Ave. #55','','Rancho Cucamonga','CA','91730','US','909-980-5281','webmaster@tradestudios.com',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('202','1002821','1','30',7.49,'2006-9-11 17:2:0','Black','Small','',0,'OD',NULL,NULL,NULL,'16','Martin','McGee','Trade Studios, LLC','7350 Greenhaven Ave. #55','','Rancho Cucamonga','CA','91730','US','909-980-5281','marty@tradestudios.com',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('203','1002821','1','31',59.95,'2006-9-11 17:2:0','Black','One Size Fits All','',0,'OD',NULL,NULL,NULL,'0','Martin','McGee','Trade Studios, LLC','7350 Greenhaven Ave. #55','','Rancho Cucamonga','CA','91730','US','909-980-5281','webmaster@tradestudios.com',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('205','1002822','1','14',299.99,'2006-9-11 17:49:0','','','',0,'OD',NULL,NULL,NULL,'0','Martin','McGee','Trade Studios, LLC','7350 Greenhaven Ave. #55','','Rancho Cucamonga','CA','91730','US','909-980-5281','webmaster@tradestudios.com',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('206','1002822','1','23',89.99,'2006-9-11 17:49:0','','','',0,'OD',NULL,NULL,NULL,'17','Harry','Potter','','Wizard School Blvd.','','England','UT','85134','US','512-491-7637','',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('207','1002822','1','29',11.99,'2006-9-11 17:49:0','Black','','',0,'OD',NULL,NULL,NULL,'14','Bobby','McFarrin','','1312 Hemmingway Drive','','Burbank','CA','91408','US','818-745-8749','webmaster@tradestudios.com',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('208','1002823','1','31',59.95,'2006-12-9 23:33:0','Black','One Size Fits All','',0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('209','1002824','1','3',849.95,'2006-12-9 23:37:0','','','',0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('210','1002827','1','3',849.95,'2007-1-15 15:5:0','','','',0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('211','1002827','1','12',199.95,'2007-1-31 0:1:0',NULL,NULL,NULL,0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('212','1002823','1','3',849.95,'2007-2-1 20:30:0',NULL,NULL,NULL,0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('213','1002829','1','19',399.99,'2007-2-2 1:9:0','','','',0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('214','1002830','1','19',399.99,'2007-2-2 1:10:0','','','',0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('215','1002830','1','29',11.99,'2007-2-2 1:12:0',NULL,NULL,NULL,0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('216','1002830','1','6',329.95,'2007-2-5 15:36:0',NULL,NULL,NULL,0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('217','1002831','3','7',899.95,'2007-2-14 11:0:0',NULL,NULL,NULL,0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('218','1002831','1','28',599.95,'2007-2-14 11:0:0',NULL,NULL,NULL,0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('219','1002832','1','4',349.99,'2007-2-14 11:32:0','','','',0,'BO',NULL,NULL,NULL,'21','jack','jack','jkl','jkl','jkl','jkl','CA','90210','US','32902','',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('220','1002832','2','22',269.95,'2007-2-14 11:32:0','','','',0,'OD',NULL,NULL,NULL,'0','90','90','90','90','90','90','CA','90210','US','sdfadf','',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('221','1002833','1','4',349.99,'2007-2-14 11:32:0','','','',0,'BO',NULL,NULL,NULL,'21','jack','jack','jkl','jkl','jkl','jkl','CA','90210','US','32902','',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('222','1002833','2','22',269.95,'2007-2-14 11:32:0','','','',0,'OD',NULL,NULL,NULL,'0','90','90','90','90','90','90','CA','90210','US','sdfadf','',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('223','1002834','1','8',239.99,'2007-2-15 15:45:0',NULL,NULL,NULL,0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('225','1002835','1','14',329.95,'2007-2-15 15:50:0',NULL,NULL,NULL,0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('226','1002835','1','1',269.95,'2007-2-15 15:50:0',NULL,NULL,NULL,0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('227','1002836','1','11',419.99,'2007-2-15 15:54:0',NULL,NULL,NULL,0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('228','1002837','1','29',11.99,'2007-2-15 15:58:0',NULL,NULL,NULL,0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('229','1002837','1','16',199.95,'2007-2-15 15:58:0',NULL,NULL,NULL,0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('230','1002837','1','11',419.99,'2007-2-15 15:58:0',NULL,NULL,NULL,0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('231','1002838','1','6',329.95,'2007-2-15 16:49:0',NULL,NULL,NULL,0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('232','1002839','1','29',12.99,'2007-2-15 16:51:0',NULL,NULL,NULL,0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('233','1002840','1','14',299.99,'2007-2-15 17:10:0',NULL,NULL,NULL,0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('234','1002840','2','12',199.95,'2007-2-15 17:10:0',NULL,NULL,NULL,0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('235','1002841','1','7',899.95,'2007-2-15 17:33:0',NULL,NULL,NULL,0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('236','1002842','1','30',7.49,'2007-2-15 18:11:0',NULL,NULL,NULL,0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('237','1002842','1','21',249.99,'2007-2-15 18:11:0',NULL,NULL,NULL,0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('238','1002843','1','20',299.99,'2007-2-15 18:17:0',NULL,NULL,NULL,0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('239','1002850','1','3',849.95,'2007-2-16 10:32:0','','','',0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('240','1002851','1','27',899.95,'2007-2-16 11:19:0','','','',0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('241','1002852','1','3',849.95,'2007-2-16 11:23:0','','','',0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('242','1002853','1','26',279.99,'2007-2-16 12:26:0','','','',0,'BO',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('243','1002854','1','3',849.95,'2007-2-16 12:46:0','','','',0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('244','1002854','2','10',349.99,'2007-2-16 12:46:0','','','',0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('245','1002855','1','7',899.95,'2007-2-16 12:53:0','','','',0,'OD',NULL,NULL,NULL,'22','Ronny','Booshay','','787 Walton Dr.','','Canoga Park','CA','91301','US','(818) 786-6767','',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('246','1002855','1','30',9.49,'2007-2-16 12:53:0','Black','Large','',0,'OD',NULL,NULL,NULL,'23','Felix','Havock','','668 Red Rock Ave.','','Berkeley','CA','90087','US','(787) 789-0098','',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('247','1002856','1','5',449.99,'2007-2-16 13:9:0','','','',0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('248','1002856','1','17',229.95,'2007-2-16 13:9:0','','','',0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('249','1002857','1','18',299.99,'2007-2-16 13:24:0','','','',0,'OD',NULL,NULL,NULL,'0','Margareta','Astraea','','909 Flummer Dr.','','Kansas City','MO','64102','US','(876) 456-1212','',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('250','1002857','1','19',399.99,'2007-2-16 13:24:0','','','',0,'OD',NULL,NULL,NULL,'25','Jonathan','Blitz','','7878 Texas Dr.','','Houston','TX','77002','US','(878) 909-0076','',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('251','1002858','1','21',249.99,'2007-2-16 13:26:0','','','',0,'OD',NULL,NULL,NULL,'0','Sharon','Temple','','2829 Sunset Dr.','','Hollywood','CA','90495','US','213-758-1362','',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('252','1002858','1','23',89.99,'2007-2-16 13:26:0','','','',0,'OD',NULL,NULL,NULL,'26','Darcy','Asby','','6 Grow St.','','Dallas','','78645','US','5122617845','',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('253','1002859','1','3',849.95,'2007-2-16 13:51:0','','','',0,'OD',NULL,NULL,NULL,'27','alvin','Monk','','1212 Waldorf St.','','San Francisco','CA','94102','US','(818) 123-4567','',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('254','1002859','1','30',7.49,'2007-2-16 13:51:0','Black','Small','',0,'OD',NULL,NULL,NULL,'0','alex','ocuna','','909 Train Rd','','Tucson','AZ','85704','US','(715) 768-0098','',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('255','1002860','1','8',239.99,'2007-2-16 13:59:0','','','',0,'OD',NULL,NULL,NULL,'28','Mike','Park','','897 Walken Ave','','Orlando','FL','90087','US','(909) 876-0000','',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('256','1002860','1','28',599.95,'2007-2-16 13:59:0','','','',0,'OD',NULL,NULL,NULL,'0','Hikaru','Kazuo','','4142 Lake Dr.','','Lake Forrest','ME','90035','US','(131) 789-0098','',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('257','1002861','1','6',329.95,'2007-2-16 14:7:0','','','',0,'OD',NULL,NULL,NULL,'29','Woodrow','Guthrie','','787 Mole Dr.','','Miami','FL','96678','US','(121) 345-9987','',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('258','1002861','1','10',349.99,'2007-2-16 14:7:0','','','',0,'OD',NULL,NULL,NULL,'0','Yankel','Yoram','','876 Kane Dr.','','Beverly Hills','CA','90210','US','(310) 765-3377','',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('259','1002861','1','24',197.95,'2007-2-16 14:7:0','','','',0,'OD',NULL,NULL,NULL,'29','Woodrow','Guthrie','','787 Mole Dr.','','Miami','FL','96678','US','(121) 345-9987','',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('260','1002862','1','3',849.95,'2007-2-16 14:28:0','','','',0,'OD',NULL,NULL,NULL,'0','Hyun','Jung','','123 Buena Ave.','','Coco Beach','FL','32931','US','(657) 126-0075','',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('261','1002862','1','9',529.99,'2007-2-16 14:28:0','','','',0,'OD',NULL,NULL,NULL,'30','Joeseph','Glenn','','678 Running Dear Dr.','','milwaukee','WI','53204','US','(567) 123-5555','',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('262','1002863','1','22',269.95,'2007-2-16 15:10:0','','','',0,'OD',NULL,NULL,NULL,'0','Horacio','Daniel','','866 Turtle Dr.','','Hartford','CT','06106','US','(908) 567-1212','',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('263','1002863','1','28',599.95,'2007-2-16 15:10:0','','','',0,'OD',NULL,NULL,NULL,'31','Roy','Baker','','654 31st St.','','Des Moines','IA','50307','US','(534) 899-6612','',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('264','1002863','1','30',9.49,'2007-2-16 15:10:0','Brown','Large','',0,'OD',NULL,NULL,NULL,'31','Roy','Baker','','654 31st St.','','Des Moines','IA','50307','US','(534) 899-6612','',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('265','1002864','1','27',899.95,'2007-2-16 15:22:0','','','',0,'OD',NULL,NULL,NULL,'32','Lance','Bass','','3543 Bristol St.','','Red Rock','UT','87776','US','(787) 765-1276','',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('266','1002864','1','31',59.95,'2007-2-16 15:22:0','Navy','One Size Fits All','',0,'OD',NULL,NULL,NULL,'0','Gheorghe','Patxi','','1234 89th St.','','Pasadena','CA','91103','US','(774) 678-1264','',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('267','1002865','1','1',269.95,'2007-2-16 15:30:0','','','',0,'OD',NULL,NULL,NULL,'33','Johnny','Lydon','','567 Pistol Dr.','','Peekskill','NY','08876','US','(212) 756-7845','',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('268','1002865','1','16',199.95,'2007-2-16 15:30:0','','','',0,'OD',NULL,NULL,NULL,'0','Wasswa','Flynn','','4678 Donna Dr.','','Mercury','RI','90076','US','(345) 567-1234','',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('269','1002866','1','5',449.99,'2007-2-16 15:48:0','','','',0,'OD',NULL,NULL,NULL,'0','Gabriel','Robert','','345 Nathan St.','','Denver','CO','80014','US','(733) 655-6437','',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('270','1002866','1','6',329.95,'2007-2-16 15:48:0','','','',0,'OD',NULL,NULL,NULL,'34','Jesus','Montoya','','876 13th St.','','Denver','CO','80014','US','(987) 567-3246','',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('271','1002866','1','20',299.99,'2007-2-16 15:48:0','','','',0,'OD',NULL,NULL,NULL,'34','Jesus','Montoya','','876 13th St.','','Denver','CO','80014','US','(987) 567-3246','',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('272','1002867','1','7',899.95,'2007-2-16 16:1:0','','','',0,'OD',NULL,NULL,NULL,'35','Harold','Palm','','22523 Dolorosa St.','','Woodland Hills','CA','91367','US','(818) 716-2875','',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('273','1002867','1','9',529.99,'2007-2-16 16:1:0','','','',0,'OD',NULL,NULL,NULL,'0','Gerry','Rafiq','','4545 Washington Ave.','','Los Angeles','CA','90028','US','(323) 867-1279','',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('274','1002868','1','6',329.95,'2007-2-16 16:6:0','','','',0,'OD',NULL,NULL,NULL,'36','Daniel','Lanois','','67 Ft. Meyers','','Chicago','IL','60604','US','(657) 678-3411','',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('275','1002868','1','8',239.99,'2007-2-16 16:6:0','','','',0,'OD',NULL,NULL,NULL,'0','Cadence','Jan','','555 Hazel St.','','Punxsutawny','PA','15767','US','(868) 367-1199','',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('276','1002868','1','10',349.99,'2007-2-16 16:6:0','','','',0,'OD',NULL,NULL,NULL,'36','Daniel','Lanois','','67 Ft. Meyers','','Chicago','IL','60604','US','(657) 678-3411','',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('277','1002869','1','5',449.99,'2007-2-19 10:5:0','','','',0,'OD',NULL,NULL,NULL,'37','Pete','Ferguson','','6786 Winchester Dr.','','Fort Worth','TX','76137','US','(789) 456-3214','',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('278','1002869','1','9',529.99,'2007-2-19 10:5:0','','','',0,'OD',NULL,NULL,NULL,'0','Christiaan','Thorvald','','5685 Glen St.','','Fort Lauderdale','FL','33304','US','(678) 345-0090','',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('279','1002870','1','26',279.99,'2007-2-19 10:16:0','','','',0,'BO',NULL,NULL,NULL,'0','Gino','Emil','','8989 Crestview Ln.','','Dayton','OH','45405','US','(787) 576-0011','',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('280','1002870','1','30',8.49,'2007-2-19 10:16:0','Black','Medium','',0,'OD',NULL,NULL,NULL,'38','Jose','Cruz','','19428 Dawson Creek Pl','','Walnut','CA','91789','US','(818) 912-5110','',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('281','1002871','1','3',849.95,'2007-2-19 10:33:0','','','',0,'OD',NULL,NULL,NULL,'39','Larry','Parker','','1313 Bristol Dr.','','Canoga Park','CA','91301','US','(818) 710-2435','',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('282','1002871','1','8',239.99,'2007-2-19 10:33:0','','','',0,'OD',NULL,NULL,NULL,'0','Daniel','Johan','','8907 Stern St.','','Longport','NJ','08403','US','(212) 780-7865','',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('283','1002871','1','12',199.95,'2007-2-19 10:33:0','','','',0,'OD',NULL,NULL,NULL,'39','Larry','Parker','','1313 Bristol Dr.','','Canoga Park','CA','91301','US','(818) 710-2435','',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('284','1002872','1','24',197.95,'2007-2-19 11:47:0','','','',0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('285','1002873','1','15',149.99,'2007-2-19 12:17:0','','','',0,'OD',NULL,NULL,NULL,'0','Sean','Elias','','3131 Orange Grove Ave.','','Anaheim','CA','92805','US','(562) 789-3287','',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('286','1002873','1','31',59.95,'2007-2-19 12:17:0','Navy','One Size Fits All','',0,'OD',NULL,NULL,NULL,'41','Donald','Johnson','','45 Oak Hills Rd.','','Rancho Cucamonga','CA','91730','US','(909) 567-5454','',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('287','1002874','1','17',229.95,'2007-2-19 13:22:0','','','',0,'OD',NULL,NULL,NULL,'42','Clarence','Deville','','667 Culotta St','','Baltimore','MD','21204','US','(787) 546-1248','',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('288','1002874','1','20',299.99,'2007-2-19 13:22:0','','','',0,'OD',NULL,NULL,NULL,'0','Carol','Marcial','','67 Dexter Ave.','','New Orleans','LA','70116','US','(980) 878-4545','',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('289','1002874','1','23',89.99,'2007-2-19 13:22:0','','','',0,'OD',NULL,NULL,NULL,'42','Clarence','Deville','','667 Culotta St','','Baltimore','MD','21204','US','(787) 546-1248','',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('290','1002875','3','21',249.99,'2007-2-19 13:51:0','','','',0,'OD',NULL,NULL,NULL,'43','William','Wonder','','546 N. Roseland Blvd','','Biloxi','MS','39531','US','(878) 676-0000','',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('291','1002876','1','25',329.95,'2007-2-19 15:15:0','','','',0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('292','1002877','1','3',849.95,'2007-2-21 19:53:0','','','',0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('293','1002878','1','31',59.95,'2007-3-10 14:18:0','Navy','One Size Fits All','',0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('294','1002878','1','28',599.95,'2007-3-22 17:3:0',NULL,NULL,NULL,0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('295','1002879','2','14',299.99,'2007-3-25 11:47:0','','','',0,'OD',NULL,NULL,NULL,'18','Martin','McGee','Trade Studios, LLC','7350 Greenhaven Ave. #55','','Rancho Cucamonga','CA','91730','US','909-980-5281','webmaster@tradestudios.com',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('296','1002879','1','32',22,'2007-3-25 11:47:0','Royal Blue','','',0,'OD',NULL,NULL,NULL,'17','Martin','McGee','Trade Studios, LLC','7350 Greenhaven Ave. #55','','Rancho Cucamonga','CA','91730','US','909-980-5281','webmaster@tradestudios.com',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('297','1002880','1','19',399.99,'2007-3-25 14:0:0','','','',0,'OD',NULL,NULL,NULL,'0','Martin','McGee','Trade Studios, LLC','7350 Greenhaven Ave. #55','','Rancho Cucamonga','CA','91730','US','909-980-5281','webmaster@tradestudios.com',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('298','1002880','1','24',197.95,'2007-3-25 14:0:0','','','',0,'OD',NULL,NULL,NULL,'14','Bobby','McFarrin','','1312 Hemmingway Drive','','Burbank','CA','91408','US','818-745-8749','webmaster@tradestudios.com',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('299','1002880','1','27',899.95,'2007-3-25 14:0:0','','','',0,'OD',NULL,NULL,NULL,'16','Martin','McGee','Trade Studios, LLC','7350 Greenhaven Ave. #55','','Rancho Cucamonga','CA','91730','US','909-980-5281','marty@tradestudios.com',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('300','1002880','1','29',12,'2007-3-25 14:0:0','Black','Medium','',0,'OD',NULL,NULL,NULL,'17','Harry','Potter','','Wizard School Blvd.','','England','UT','85134','US','512-491-7637','',NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('301','1002881','1','3',849.95,'2007-3-25 14:7:0','','','',0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.OrderItems (OrderItemsID,OrderID,Qty,ItemID,ItemPrice,DateEntered,OptionName1,OptionName2,OptionName3,Deleted,StatusCode,DateUpdated,UpdatedBy,OITrackingNumber,ShippingID,orderitems_FirstName,orderitems_LastName,orderitems_CompanyName,orderitems_Address1,orderitems_Address2,orderitems_City,orderitems_State,orderitems_Zip,orderitems_Country,orderitems_Phone,orderitems_Email,orderitems_ShipMethod) VALUES('302','1002881','1','29',17,'2007-3-25 14:7:0','Black','Large','',0,'OD',NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
IF (IDENT_SEED('dbo.OrderItems') IS NOT NULL )	SET IDENTITY_INSERT dbo.OrderItems OFF
GO
GO
ALTER TABLE dbo.OrderItems CHECK CONSTRAINT ALL
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
--Insert data into dbo.OrderReturnItems
-----------------------------------------------------------
ALTER TABLE dbo.OrderReturnItems NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.OrderReturnItems
GO

IF (IDENT_SEED('dbo.OrderReturnItems') IS NOT NULL )	SET IDENTITY_INSERT dbo.OrderReturnItems ON
INSERT INTO dbo.OrderReturnItems (ORIID,OrderReturnID,OrderReturnItemID,QtyReturned) VALUES('1','1','21','1')
IF (IDENT_SEED('dbo.OrderReturnItems') IS NOT NULL )	SET IDENTITY_INSERT dbo.OrderReturnItems OFF
GO
GO
ALTER TABLE dbo.OrderReturnItems CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.OrderReturns
-----------------------------------------------------------
ALTER TABLE dbo.OrderReturns NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.OrderReturns
GO

IF (IDENT_SEED('dbo.OrderReturns') IS NOT NULL )	SET IDENTITY_INSERT dbo.OrderReturns ON
INSERT INTO dbo.OrderReturns (OrderReturnID,OrderID,RMA,RMADate,DateReceived,ReceivedTo,RMAComplete,CreatedBy,ChargeReturnTo,TaxReturned,ShippingReturned) VALUES('1','1002818','1002818001','2006-8-28 9:45:0',NULL,'Distributor',0,'ADMIN','Marketing',20.6242,0)
IF (IDENT_SEED('dbo.OrderReturns') IS NOT NULL )	SET IDENTITY_INSERT dbo.OrderReturns OFF
GO
GO
ALTER TABLE dbo.OrderReturns CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.Orders
-----------------------------------------------------------
ALTER TABLE dbo.Orders NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.Orders
GO

IF (IDENT_SEED('dbo.Orders') IS NOT NULL )	SET IDENTITY_INSERT dbo.Orders ON
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002700','2003-3-24 15:9:0','1','3843586823','127.0.0.1','MC','33B036C8AFAED78DD76FC4C746E9E893','37B42BCCA7','909',0,'3',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'818-786-4642',0,'Marty','McGee','Trade Studios, LLC','13560 Wyandotte St.','Suite 1','Van Nuys','CA','91405','US',NULL,NULL,'2005-3-24 0:0:0','CA','RE','TEST ORDER',NULL,7.48,0.81,0,NULL,0,NULL,'1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2005-5-2 21:34:0','ADMIN',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002701','2003-3-24 15:10:0','1','3843586823','127.0.0.1','MC','33B036C8AFAED78DD76FC4C746E9E893','37B42BCCA7','909',0,'Default',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'818-786-4642',0,'Marty','McGee','Trade Studios, LLC','13560 Wyandotte St.','Suite 1','Van Nuys','CA','91405','US',NULL,NULL,'2005-3-25 0:0:0','PK','SH','TEST ORDER #2',NULL,6.95,0.81,0,NULL,0,NULL,'1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2005-5-6 0:0:0','ADMIN',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002702','2005-3-24 15:10:0','1','3843586823','127.0.0.1','MC','33B036C8AFAED78DD76FC4C746E9E893','37B42BCCA7','909',1,'3',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'818-786-4642',0,'Marty','McGee','Trade Studios, LLC','13560 Wyandotte St.','Suite 1','Van Nuys','CA','91405','US',NULL,NULL,'2005-3-25 0:0:0','PA','SH','TEST ORDER #3',NULL,6.95,8.08,0,NULL,0,NULL,'1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2005-5-2 21:13:0','ADMIN',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002703','2004-5-2 21:32:0','1','3847456123','127.0.0.1','MC','33B036C8AFAED78DD76FC4C746E9E893','36B72BCCA6','738',1,'Default',NULL,'7035',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'912-829-3874',0,'Jack','Riley',NULL,'3121 34th St.',NULL,'Dammeron Valley','ID','80501','US',NULL,NULL,'2004-5-2 21:32:0','PA','SH',NULL,NULL,6.95,18.895,100,NULL,52,'0','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2005-12-5 10:6:0','MARTY',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002704','2004-5-4 20:7:0','1','3843586823','127.0.0.1','MC','33B036C8AFAED78DD76FC4C746E9E893','37B42BCCA7','909',1,'Default',NULL,'7000',0,8.91,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'818-786-4642',0,'Marty','McGee','Trade Studios, LLC','13560 Wyandotte St.','Suite 1','Van Nuys','CA','91405','US',NULL,NULL,'2005-5-7 0:0:0','PA','IT','Please make sure I get the 10% OFF on this order.',NULL,6.95,16.33,19.795,NULL,0,'0','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2005-5-6 9:48:0','ADMIN',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002705','2004-5-4 20:10:0','1','3843586823','127.0.0.1','MC','33B036C8AFAED78DD76FC4C746E9E893','37B42BCCA7','909',0,'12',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'818-786-4642',0,'Marty','McGee','Trade Studios, LLC','13560 Wyandotte St.','Suite 1','Van Nuys','CA','91405','US',NULL,NULL,'2005-5-8 0:0:0','PA','SH',NULL,NULL,11.55,7.42,0,NULL,0,NULL,'1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2005-5-6 0:0:0','ADMIN',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002706','2005-5-4 20:37:0','1','3843586823','127.0.0.1','VI','32B434CBAFAED78DD76FC4C540','37B42BCCA8','909',1,'Weight',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'818-786-4642',0,'Marty','McGee','Trade Studios, LLC','13560 Wyandotte St.','Suite 1','Van Nuys','CA','91405','US',NULL,NULL,NULL,'PA','PR',NULL,NULL,12.95,57.75,139.99,NULL,0,'0','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2005-5-6 0:0:0','ADMIN',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002707','2005-5-5 20:15:0','1','3847456123','127.0.0.1','MC','33B036C8AFAED78DD76FC4C746E9E893','36B72BCCA6','738',1,'13',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'912-829-3874',0,'Jack','Riley',NULL,'3121 34th St.',NULL,'Dammeron Valley','ID','80501','US',NULL,NULL,'2005-5-6 0:0:0','PA','SH',NULL,NULL,0,0,0,NULL,0,'0','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2005-5-6 9:43:0','ADMIN',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002708','2005-5-6 9:52:0','1','3847838015','127.0.0.1','VI','32B435CEA7A6DF85D667CCCF4E','36B62BCCA7','891',1,'Priority',NULL,'7000',1,9.37,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'493-290-0309',0,'Gene','Gallant',NULL,'414 Makeshift Rd.',NULL,'Charlotte','NC','30333','US',NULL,NULL,NULL,'PA','PR',NULL,NULL,0,0,0,NULL,0,'0','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2005-6-13 0:0:0','DEMO',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002709','2005-5-6 17:50:0','1','3847830514','127.0.0.1','VI','32B636CEADACD58FD56DC6C544','36B62BCCAA',NULL,0,'FEDEX2DAY',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'203-392-0388',0,'Mel','Jackson',NULL,'2000 South IH-35',NULL,'Gable','AR','29928','US',NULL,NULL,'2005-5-6 17:50:0','DE','SH',NULL,NULL,38,105.0543,0,NULL,0,NULL,'1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2005-5-31 3:0:0','DEMO',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002710','2005-5-6 18:44:0','1','3847833836','127.0.0.1','VI','32B434CBAFAED78DD76FC4C540','3FAB34C5','8299',1,'1',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'737-920-9388',0,'Hilton','Farler','Mass Storage Chicago','21 SE Court Ave.',NULL,'Chicago','IL','60601','US',NULL,NULL,'2005-5-6 18:44:0','PA','SH',NULL,NULL,77.78,68.7406,100,NULL,0,'0','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2005-5-6 0:0:0','ADMIN',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002711','2005-5-7 7:48:0','1','3847940047','127.0.0.1','MC','33B036C8AFAED78DD76FC4C746E9E893','37B52BCCA7','822',1,'3',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'916-858-1452',0,'Joanne','Marquez',NULL,'9000 Crow Cedar Way',NULL,'Granite Bay','CA','95978','US',NULL,NULL,'2005-5-7 7:48:0','PA','SH',NULL,NULL,6.95,7.4242,0,NULL,0,'0','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2006-5-24 0:0:0','ADMIN',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002712','2005-5-7 7:50:0','1','3847978053','127.0.0.1','VI','32B434CBAFAED78DD76FC4C540','36BD2BCCA9','019',0,'PRIORITYOVERNIGHT',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'818-555-5555',0,'Hillary','Hodges',NULL,'39 A West Bull Blvd.',NULL,'West Hollywood','CA','90209','US',NULL,NULL,NULL,'BI','PR',NULL,NULL,8.95,40.4201,0,NULL,0,NULL,'1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2005-5-10 17:57:0','DEMO',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002713','2005-5-7 7:55:0','1','3847934049','127.0.0.1','VI','32B53CC9A7A9D588DE67C6CF40E0E895','37B42BCCA8','001',1,'3',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'203-392-0388',0,'Barbara','Beal',NULL,'8190 Vargas Lane',NULL,'Henderson','NV','89134','US',NULL,NULL,NULL,'PA','OD',NULL,NULL,0,0,0,NULL,0,'0','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2005-5-7 0:0:0','ADMIN',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002714','2005-5-9 9:11:0','1','3848174746','127.0.0.1','VI','32B434CBAFAED78DD76FC4C540','3FAB34C5',NULL,1,'1',NULL,'7007',0,24,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'909-289-3982',0,'Meg','Johnson','Calliber Extract','2290 E. Flaming Ave.',NULL,'Riverside','CA','91627','US',NULL,NULL,'2005-5-9 0:0:0','PA','SH',NULL,NULL,24.99,19.7992,0,NULL,0,'0','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2005-5-9 10:20:0','ADMIN',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002715','2005-5-10 6:9:0','1','3847456123','127.0.0.1','MC','33B036C8AFAED78DD76FC4C746E9E893','36B72BCCA6','909',1,'Weight',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'912-829-3874',0,'Jack','Riley',NULL,'3121 34th St.',NULL,'Dammeron Valley','ID','80501','US',NULL,NULL,'2005-5-10 6:9:0','PA','SH',NULL,NULL,30.95,61.2895,0,NULL,0,'0','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2005-6-13 0:0:0','DEMO',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002716','2005-5-10 15:26:0','1','3848236344','69.231.145.156','MC','33B036C8AFAED78DD76FC4C746E9E893','36B72BCCA9','777',1,'Weight',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'815-634-4102',0,'Mike','Gallagher',NULL,'556 Yellow Rd.',NULL,'Minneapolis','MN','44333','US',NULL,NULL,'2005-5-10 0:0:0','PA','SH',NULL,NULL,8.45,5.85,0,NULL,0,'0','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2005-5-10 15:29:0','ADMIN',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002717','2005-6-15 15:15:0','1','3847838015','216.204.105.226','VI','32B435CEA7A6DF85D667CCCF4E','36B62BCCA7','891',1,'3',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'493-290-0309',0,'Gene','Gallant',NULL,'414 Makeshift Rd.',NULL,'Charlotte','NC','30333','US',NULL,NULL,NULL,'PA','OD',NULL,NULL,0,10.1246,0,NULL,0,'0','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2005-6-20 23:20:0','DEMO',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002718','2005-6-21 14:41:0','1','3847833836','24.8.189.141','MC','33B036C8AFAED78DD76FC4C746E9E893','36BD2BCCA9','909',1,'3',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'737-920-9388',0,'Hilton','Farler','Mass Storage Chicago','21 SE Court Ave.',NULL,'Chicago','IL','60601','US',NULL,NULL,NULL,'PA','OD',NULL,NULL,0,18.7494,0,NULL,0,'0','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2006-4-13 13:46:0','ADMIN',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002719','2005-6-21 14:42:0','1','3848236344','69.231.131.193','MC','33B036C8AFAED78DD76FC4C746E9E893','36B72BCCA9','777',0,'3',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'815-634-4102',0,'Mike','Gallagher',NULL,'556 Yellow Rd.',NULL,'Minneapolis','MN','44333','US',NULL,NULL,NULL,'NB','OD',NULL,NULL,0,17.5468,0,NULL,0,NULL,'1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2005-6-21 12:0:0','DEMO',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002720','2005-6-21 14:57:0','1','3843586823','24.8.189.141','MC','33B036C8AFAED78DD76FC4C746E9E893','37B42BCCA7','324',0,'Weight',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'818-786-4642',0,'Marty','McGee','Trade Studios, LLC','13560 Wyandotte St.','Suite 1','Van Nuys','CA','91405','US',NULL,NULL,NULL,'NB','OD',NULL,NULL,13.45,70.12,0,NULL,0,NULL,'1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002721','2005-6-21 14:58:0','1','3843586823','69.231.131.193','MC','33B036C8AFAED78DD76FC4C746E9E893','37B42BCCA7','909',0,'Weight',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'818-786-4642',0,'Marty','McGee','Trade Studios, LLC','13560 Wyandotte St.','Suite 1','Van Nuys','CA','91405','US',NULL,NULL,NULL,'NB','OD',NULL,NULL,15.95,70.12,170,NULL,0,NULL,'1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002722','2005-6-21 15:38:0','1','3843586823','24.8.189.141','MC','33B036C8AFAED78DD76FC4C746E9E893','37B42BCCA7','909',1,'3',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'818-786-4642',0,'Marty','McGee','Trade Studios, LLC','13560 Wyandotte St.','Suite 1','Van Nuys','CA','91405','US',NULL,NULL,NULL,'PA','OD',NULL,NULL,0,70.1201,0,NULL,0,'0','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2005-6-21 12:0:0','DEMO',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002723','2005-6-21 15:43:0','1','3843586823','24.8.189.141','MC','33B036C8AFAED78DD76FC4C746E9E893','37B42BCCA7','324',0,'Weight',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'818-786-4642',0,'Marty','McGee','Trade Studios, LLC','13560 Wyandotte St.','Suite 1','Van Nuys','CA','91405','US',NULL,NULL,NULL,'NB','OD',NULL,NULL,13.45,70.1209,0,NULL,0,NULL,'1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002724','2005-6-22 8:16:0','1','3843586823','24.8.189.141','MC','33B036C8AFAED78DD76FC4C746E9E893','37B42BCCA7','324',0,'3',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'818-786-4642',0,'Marty','McGee',NULL,'13560 Wyandotte St.','Suite 1','Van Nuys','CA','91405','US',NULL,NULL,NULL,'NB','OD',NULL,NULL,0,0,0,NULL,0,NULL,'1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2005-6-22 0:0:0','DEMO',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002725','2005-6-22 8:16:0','1','3843586823','24.8.189.141','MC','33B036C8AFAED78DD76FC4C746E9E893','37B42BCCA7','324',1,'3',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'818-786-4642',0,'Marty','McGee',NULL,'13560 Wyandotte St.','Suite 1','Van Nuys','CA','91405','US',NULL,NULL,NULL,'PA','OD',NULL,NULL,0,577.4588,0,NULL,0,'0','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2005-6-22 0:0:0','DEMO',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002726','2005-6-22 8:16:0','1','3843586823','24.8.189.141','MC','33B036C8AFAED78DD76FC4C746E9E893','37B42BCCA7','973',0,'Weight',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'818-786-4642',0,'Marty','McGee','Trade Studios, LLC','13560 Wyandotte St.','Suite 1','Van Nuys','CA','91405','US',NULL,NULL,NULL,'NB','OD',NULL,NULL,30.95,168.2901,509.97,NULL,0,NULL,'1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002727','2005-7-22 8:16:0','1','3852576845','24.173.1.237','VI','32B535CDAEAFD68CD66EC5C647E8E897','36B52BCCA9','458',0,'Weight',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'555-555-5555',0,'test','test',NULL,'123 main st',NULL,'galveston','TX','77550','US',NULL,NULL,'2005-6-23 0:0:0','PA','SH',NULL,NULL,13.45,53.12,0,NULL,0,NULL,'1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2005-6-22 21:59:0','DEMO',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002728','2005-7-22 8:16:0','1','3852512316','24.173.1.237','VI','32B535CDAEAFD68CD66EC5C647E8E897','36B52BCCA9','749',1,'Weight',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'555-555-5555',0,'TEST','AKARD',NULL,'123 MAIN ST',NULL,'GALVESTON','TX','77550','US',NULL,NULL,NULL,'NB','PR',NULL,NULL,13.45,53.12,0,NULL,0,NULL,'1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2005-6-22 21:57:0','DEMO',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002729','2005-7-23 15:57:0','1','3843586823','69.231.131.193','MC','33B036C8AFAED78DD76FC4C746E9E893','37B42BCCA7','909',0,'Custom6',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'818-786-4642',0,'Marty','McGee','Trade Studios, LLC','13560 Wyandotte St.','Suite 1','Van Nuys','CA','91405','US',NULL,NULL,NULL,'NB','OD','CUSTOM SHIPPING ORDER',NULL,26,24.75,0,NULL,0,NULL,'1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002730','2005-7-23 15:58:0','1','3843586823','69.231.131.193','MC','33B036C8AFAED78DD76FC4C746E9E893','37B42BCCA7','909',1,'Custom7',NULL,'7000',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'818-786-4642',0,'Marty','McGee','Trade Studios, LLC','13560 Wyandotte St.','Suite 1','Van Nuys','CA','91405','US',NULL,NULL,'2005-6-24 0:0:0','PA','SH','CUSTOM SHIPPING TEST',NULL,29.95,4.1217,0,NULL,0,'0','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2005-6-23 18:3:0','ADMIN',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002731','2005-7-23 18:27:0','1','3847934049','69.231.131.193','MC','33B036C8AFAED78DD76FC4C746E9E893','37B42BCCA8','001',0,'CustomP1',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'203-392-0388',0,'Barbara','Beal',NULL,'8190 Vargas Lane',NULL,'Henderson','NV','89134','US',NULL,NULL,NULL,'NB','OD',NULL,NULL,7.95,55.25,0,NULL,0,NULL,'1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002732','2005-7-23 18:32:0','1','3847934049','69.231.131.193','MC','33B036C8AFAED78DD76FC4C746E9E893','37B42BCCA8','001',0,'Custom11',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'203-392-0388',0,'Barbara','Beal',NULL,'8190 Vargas Lane',NULL,'Henderson','NV','89134','US',NULL,NULL,'2005-7-23 18:32:0','NB','SH',NULL,NULL,14.95,26,0,NULL,0,NULL,'1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2006-5-24 0:0:0','ADMIN',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002733','2005-7-24 2:42:0','1','3852512316','221.237.5.78','VI','32B535CDAEAFD68CD66EC5C647E8E897','36B52BCCA9','123',0,'Custom5',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'555-555-5555',0,'TEST','AKARD',NULL,'123 MAIN ST',NULL,'GALVESTON','TX','77550','US',NULL,NULL,NULL,'NB','OD','how are you ??',NULL,18,53.12,0,NULL,0,NULL,'1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002734','2005-7-30 16:3:0','1','3843586823','24.8.189.141','MC','33B036C8AFAED78DD76FC4C746E9E893','37B42BCCA7','909',1,'3',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'818-786-4642',0,'Marty','McGee',NULL,'13560 Wyandotte St.','Suite 1','Van Nuys','CA','91405','US',NULL,NULL,NULL,'PA','OD',NULL,NULL,0,70.1209,0,NULL,0,'0','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2005-6-30 12:0:0','DEMO',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002735','2005-8-4 21:12:0','1','3856859826','161.58.49.73','MC','33B036C8AFAED78DD76FC4C746E9E893','36B52BCCA8','444',0,'Custom10',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'9145509872',0,'Helene','Curran',NULL,'17100 Brannon Fork Road',NULL,'Citronelle','AL','36522','US',NULL,NULL,NULL,'NB','OD',NULL,NULL,12,10.8,0,NULL,0,NULL,'1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2005-8-20 19:0:0','DEMO',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002736','2005-8-20 19:43:0','1','3843586823','71.104.14.155','MC','33B036C8AFAED78DD76FC4C746E9E893','37B42BCCA7','909',0,'Custom5',NULL,'7014',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'909-758-8492',0,'Marty','McGee','Trade Studios, LLC','7350 Greenhaven Ave.','Suite 55','Rancho Cucamonga','CA','91730','US',NULL,NULL,NULL,'NB','OD',NULL,NULL,18,57.75,0,NULL,0,NULL,'1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002737','2005-8-22 11:40:0','1','3858645240','64.240.212.206','VI','32B535CDAEAFD68CD66EC5C647E8E897','36B62BCCA6','247',0,'Custom2',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'5617026343',0,'Chris','Yager',NULL,'111 Fantasy Lane',NULL,'Miami','FL','32771','US',NULL,NULL,NULL,'NB','OD',NULL,NULL,7.95,34.4592,143.58,NULL,0,NULL,'1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002738','2005-8-22 11:43:0','1','3858645240','64.240.212.206','VI','32B535CDAEAFD68CD66EC5C647E8E897','36B62BCCA6','247',1,'Custom2',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'5617026343',0,'Chris','Yager',NULL,'111 Fantasy Lane',NULL,'Miami','FL','32771','US',NULL,NULL,NULL,'PA','PR',NULL,NULL,7.95,40.8,0,NULL,0,'0','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2005-9-19 0:0:0','DEMO',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002739','2005-9-6 15:8:0','1','3848174746','68.167.189.96','VI','32B434CBAFAED78DD76FC4C540','3FAB34C5',NULL,0,'3',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'909-289-3982',0,'Meg','Johnson','Calliber Extract','2290 E. Flaming Ave.',NULL,'Riverside','CA','91627','US',NULL,NULL,NULL,'NB','OD',NULL,NULL,0,0,0,NULL,0,NULL,'1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2005-9-6 15:9:0','DEMO',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002740','2005-9-24 17:5:0','1','3861847459','63.164.105.135','VI','32B535CDAEAFD68CD66EC5C647E8E897','36B52BCCA9','386',0,'Custom5',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'307-733-2706',0,'s','s',NULL,'1234 hallow dr',NULL,'jackson','','83001','US',NULL,NULL,NULL,'NB','OD',NULL,NULL,18,0,0,NULL,0,NULL,'1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002741','2005-9-27 15:45:0','1','3843586823','71.104.32.149',NULL,NULL,NULL,NULL,0,'Custom3',NULL,'7014',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'909-758-8492',0,'Marty','McGee','Trade Studios, LLC','7350 Greenhaven Ave.','Suite 55','Rancho Cucamonga','CA','91730','US',NULL,NULL,NULL,'NB','OD',NULL,NULL,14,28.87,0,NULL,0,NULL,'2',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002744','2005-9-27 16:34:0','1','3843586823','71.104.32.149',NULL,NULL,NULL,NULL,0,'Custom1',NULL,'7014',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'909-758-8492',0,'Marty','McGee','Trade Studios, LLC','7350 Greenhaven Ave.','Suite 55','Rancho Cucamonga','CA','91730','US',NULL,NULL,NULL,'NB','OD',NULL,NULL,3.85,37.12,0,NULL,0,NULL,'2',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002745','2005-9-27 16:39:0','1','3843586823','71.104.32.149',NULL,NULL,NULL,NULL,0,'Custom6',NULL,'7014',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'909-758-8492',0,'Marty','McGee','Trade Studios, LLC','7350 Greenhaven Ave.','Suite 55','Rancho Cucamonga','CA','91730','US',NULL,NULL,NULL,'NB','OD',NULL,NULL,26,94.87,229.99,NULL,0,NULL,'2',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002747','2005-9-27 16:43:0','1','3843586823','71.104.32.149',NULL,NULL,NULL,NULL,0,'Custom2',NULL,'7014',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'909-758-8492',0,'Marty','McGee','Trade Studios, LLC','7350 Greenhaven Ave.','Suite 55','Rancho Cucamonga','CA','91730','US',NULL,NULL,NULL,'NB','OD',NULL,NULL,7.95,43.72,0,NULL,0,NULL,'2',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002748','2005-10-4 14:59:0','1','3862954627','24.187.93.14','VI','32B535CDAEAFD68CD66EC5C647E8E897','36BD2BCCA9','313',0,'Custom11',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'7183333333',0,'t','t',NULL,'wet12',NULL,'35t6ewtwe','NJ','07624','US',NULL,NULL,NULL,'PC','OD',NULL,NULL,14.95,16.2,0,NULL,0,NULL,'1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002749','2005-10-5 9:1:0','1','3843586823','71.104.30.186',NULL,NULL,NULL,NULL,0,'Custom2',NULL,'7014',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'909-758-8492',0,'Marty','McGee','Trade Studios, LLC','7350 Greenhaven Ave.','Suite 55','Rancho Cucamonga','CA','91730','US',NULL,NULL,NULL,'BC','IT',NULL,NULL,7.95,43.72,0,NULL,0,NULL,'2',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002753','2005-10-11 19:44:0','1','3863674855','71.104.39.164','MC','33B036C8AFAED78DD76FC4C746E9E893','37B42BCCA8','000',0,'Custom1',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'909-980-5281',0,'Realtime','Processing',NULL,'7350 Greenhaven Ave.','#55','Rancho Cucamonga','CA','91730','US',NULL,NULL,NULL,'NB','OD','TEST',NULL,3.85,37.12,0,NULL,0,NULL,'1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002754','2005-10-11 19:46:0','1','3863674855','71.104.39.164','MC','33B036C8AFAED78DD76FC4C746E9E893','37B42BCCA8','000',0,'Custom11',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'909-980-5281',0,'Realtime','Processing',NULL,'7350 Greenhaven Ave.','#55','Rancho Cucamonga','CA','91730','US',NULL,NULL,NULL,'NB','OD',NULL,NULL,14.95,70.12,0,NULL,0,NULL,'1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002755','2005-10-11 19:48:0','1','3863674855','71.104.39.164','MC','33B036C8AFAED78DD76FC4C746E9E893','37B42BCCA8','000',0,'Custom5',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'909-980-5281',0,'Realtime','Processing',NULL,'7350 Greenhaven Ave.','#55','Rancho Cucamonga','CA','91730','US',NULL,NULL,NULL,'NB','OD',NULL,NULL,18,70.12,0,NULL,0,NULL,'1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002756','2005-10-11 19:56:0','1','3863674855','71.104.39.164','MC','33B036C8AFAED78DD76FC4C746E9E893','37B42BCCA8','000',1,'Custom2',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'909-980-5281',0,'Realtime','Processing',NULL,'7350 Greenhaven Ave.','#55','Rancho Cucamonga','CA','91730','US',NULL,NULL,NULL,'PA','OD',NULL,NULL,7.95,57.75,0,NULL,0,'0','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002757','2005-10-11 20:3:0','1','3863674855','71.104.39.164',NULL,NULL,NULL,NULL,0,'Custom2',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'909-980-5281',0,'Realtime','Processing',NULL,'7350 Greenhaven Ave.','#55','Rancho Cucamonga','CA','91730','US',NULL,NULL,NULL,'NB','OD',NULL,NULL,7.95,57.75,0,NULL,0,NULL,'4',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002758','2005-10-11 20:4:0','1','3863674855','71.104.39.164',NULL,NULL,NULL,NULL,0,'Custom2',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'909-980-5281',0,'Realtime','Processing',NULL,'7350 Greenhaven Ave.','#55','Rancho Cucamonga','CA','91730','US',NULL,NULL,NULL,'NB','PR',NULL,'fytfyfyt',7.95,28.87,0,NULL,0,NULL,'2',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2005-11-5 1:10:0','DEMO',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002759','2005-10-11 20:32:0','1','3863674855','71.104.39.164','MC','33B036C8AFAED78DD76FC4C746E9E893','37B42BCCA8','000',1,'Custom2',NULL,'7042',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'909-980-5281',0,'Realtime','Processing',NULL,'7350 Greenhaven Ave.','#55','Rancho Cucamonga','CA','91730','US',NULL,NULL,NULL,'PA','OD',NULL,NULL,7.95,57.75,140,NULL,0,'0','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2005-12-5 9:59:0','MARTY',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002761','2005-10-11 20:46:0','1','3863674855','71.104.39.164','MC','33B036C8AFAED78DD76FC4C746E9E893','37B42BCCA8','000',1,'Custom5',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'909-980-5281',0,'Realtime','Processing',NULL,'7350 Greenhaven Ave.','#55','Rancho Cucamonga','CA','91730','US',NULL,NULL,NULL,'PA','OD',NULL,NULL,18,57.75,0,NULL,0,'0','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002762','2005-10-19 22:19:0','1','3864483853','24.81.238.5',NULL,NULL,NULL,NULL,0,'Custom8',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'6046712100',0,'sanjeev','dhillon',NULL,'10944 160th street',NULL,'surrey','BC','v3w4g3','CA',NULL,NULL,NULL,'NB','BO',NULL,'order processed and shipped',12.95,70.12,0,NULL,0,NULL,'4',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2005-11-2 15:57:0','DEMO',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002763','2005-10-25 20:14:0','1','3843586823','71.104.13.145','MC','33B036C8AFAED78DD76FC4C746E9E893','37B42BCCA7','111',1,'Custom5',NULL,'7014',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'909-758-8492',0,'Marty','McGee','Trade Studios, LLC','7350 Greenhaven Ave.','Suite 55','Rancho Cucamonga','CA','91730','US',NULL,NULL,NULL,'PA','OD',NULL,NULL,18,70.12,0,NULL,0,'0','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002764','2005-11-1 15:43:0','1','3843586823','69.107.74.48','MC','33B036C8AFAED78DD76FC4C746E9E893','37B42BCCA7','111',1,'Custom11',NULL,'7014',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'909-758-8492',0,'Marty','McGee','Trade Studios, LLC','7350 Greenhaven Ave.','Suite 55','Rancho Cucamonga','CA','91730','US',NULL,NULL,NULL,'PA','OD',NULL,NULL,14.95,22.27,0,NULL,0,'0','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002766','2005-11-2 22:35:0','1','3843586823','127.0.0.1','MC','33B036C8AFAED78DD76FC4C746E9E893','37B42BCCA7','111',1,'Custom11',NULL,'7014',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'909-758-8492',0,'Marty','McGee','Trade Studios, LLC','7350 Greenhaven Ave.','Suite 55','Rancho Cucamonga','CA','91730','US',NULL,NULL,NULL,'PA','OD','TEST',NULL,14.95,70.12,0,NULL,0,'0','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002767','2005-11-2 22:39:0','1','3843586823','127.0.0.1','MC','33B036C8AFAED78DD76FC4C746E9E893','37B42BCCA7','111',1,'Custom4',NULL,'7014',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'909-758-8492',0,'Marty','McGee','Trade Studios, LLC','7350 Greenhaven Ave.','Suite 55','Rancho Cucamonga','CA','91730','US',NULL,NULL,NULL,'PA','OD',NULL,NULL,20,37.12,0,NULL,0,'0','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002768','2005-11-2 22:43:0','1','3843586823','127.0.0.1','MC','33B036C8AFAED78DD76FC4C746E9E893','37B42BCCA7','111',1,'Custom11',NULL,'7014',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'909-758-8492',0,'Marty','McGee','Trade Studios, LLC','7350 Greenhaven Ave.','Suite 55','Rancho Cucamonga','CA','91730','US',NULL,NULL,NULL,'PA','OD',NULL,NULL,14.95,70.12,0,NULL,0,'0','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002769','2005-11-2 22:47:0','1','3843586823','127.0.0.1','VI','32B530CBADAED58DD66BCCC744E9EA93','37B52BCCA8','937',0,'Default',NULL,'7014',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'909-758-8492',0,'Marty','McGee','Trade Studios, LLC','7350 Greenhaven Ave.','Suite 55','Rancho Cucamonga','CA','91730','US',NULL,NULL,NULL,'AU','OD',NULL,NULL,0,57.75,0,NULL,0,'0','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2005-12-15 18:35:0','ADMIN',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002770','2005-12-3 9:45:0','1','3848236344','127.0.0.1','MC','33B036C8AFAED78DD76FC4C746E9E893','36B72BCCA9','111',1,'Custom9',NULL,'7021',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'815-634-4102',0,'Mike','Gallagher',NULL,'556 Yellow Rd.',NULL,'Minneapolis','MN','44333','US',NULL,NULL,NULL,'PA','OD',NULL,NULL,9,68.25,209.99,NULL,0,'0','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2005-12-3 11:29:0','MARTY',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002771','2005-12-3 11:31:0','1','3848236344','127.0.0.1','MC','33B036C8AFAED78DD76FC4C746E9E893','36B72BCCA9','111',1,'Default',NULL,'7021',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'815-634-4102',0,'Mike','Gallagher','','556 Yellow Rd.','','Minneapolis','MN','44333','US',NULL,NULL,NULL,'PA','OD',NULL,NULL,0,45.5,0,NULL,0,'0','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002773','2005-12-3 18:29:0','1','3868938560','127.0.0.1','MC','33B036C8AFAED78DD76FC4C746E9E893','37B42BCCA8','111',1,'3',NULL,'7028',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'419-261-4897',0,'Matthew','Ledger',NULL,'7 Skyline Drive',NULL,'Pittsburgh','PA','31293','US',NULL,NULL,'2005-12-3 0:0:0','PA','SH',NULL,NULL,18.95,41.6352,0,NULL,0,NULL,'1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2005-12-5 9:44:0','MARTY',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002774','2005-12-4 22:9:0','1','3869042235','127.0.0.1','MC','33B036C8AFAED78DD76FC4C746E9E893','37B42BCCA8','111',1,'Custom6',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'925-836-9949',0,'Shannon','Clemens','Real Image','2740 Old Crow Canyon Road','Building 4, Suite 200','San Ramon','CA','94583','US',NULL,NULL,NULL,'PA','OD',NULL,NULL,26,118.33,429.07,NULL,0,'0','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002775','2005-12-5 9:48:0','1','3868938560','127.0.0.1','MC','33B036C8AFAED78DD76FC4C746E9E893','37B42BCCA8','111',1,'Custom11',NULL,'7028',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'419-261-4897',0,'Matthew','Ledger','','7 Skyline Drive','','Pittsburgh','PA','31293','US',NULL,NULL,NULL,'PA','OD',NULL,NULL,14.95,51.45,171.69,NULL,0,'0','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002776','2005-12-5 9:50:0','1','3868938560','127.0.0.1','MC','33B036C8AFAED78DD76FC4C746E9E893','37B42BCCA8','111',1,'Custom11',NULL,'7028',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'419-261-4897',0,'Matthew','Ledger','','7 Skyline Drive','','Pittsburgh','PA','31293','US',NULL,NULL,NULL,'PA','OD',NULL,NULL,14.95,51,0,NULL,0,'0','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002777','2005-12-13 17:36:0','1','3856057054','127.0.0.1','MC','33B036C8AFAED78DD76FC4C746E9E893','37B42BCCA7','111',1,'Custom2',NULL,'7077',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0112115442938',0,'Carl','Vanderpal','Animated Kids Bible','133 Hancock Ave.','','New South Wales','-','5021','US',NULL,NULL,NULL,'PA','OD',NULL,NULL,7.95,0,269.79,NULL,0,'0','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002778','2005-12-13 17:38:0','1','3856057054','127.0.0.1','VI','33B036C8AFAED78DD76FC4C746E9E893','37B42BCCA8','111',0,'Custom1',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0112115442938',0,'Carl','Vanderpal','Animated Kids Bible','133 Hancock Ave.',NULL,'New South Wales','-','5021','US',NULL,NULL,'2006-3-20 0:0:0','PA','SH',NULL,NULL,3.85,0,0,NULL,0,'0','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2006-5-2 18:0:0','DEMO',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002779','2006-3-20 23:31:0','1','3851911567','207.200.116.9','MC','33B036C8AFAED78DD76FC4C746E9E893','37B42BCCA7','123',0,'Custom9',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'818-625-3987',0,'Mike','Harrison','','4140 NW 27th Lane','','Los Angeles','CA','91405','US',NULL,NULL,NULL,'AU','OD',NULL,NULL,9,33.41,0,NULL,20,'0','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002780','2006-3-20 23:31:0','1','3851911567','71.104.15.158','MC','33B036C8AFAED78DD76FC4C746E9E893','37B42BCCA7','123',1,'Custom5',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'818-625-3987',0,'Mike','Harrison',NULL,'4140 NW 27th Lane',NULL,'Los Angeles','CA','91405','US',NULL,NULL,'2006-3-20 0:0:0','PA','SH','This is cool!',NULL,18,46.2,0,NULL,10,'0','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2006-3-20 23:35:0','ADMIN',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002781','2006-3-21 10:17:0','1','3843586823','208.54.15.129','MC','33B036C8AFAED78DD76FC4C746E9E893','37B42BCCA7','111',0,'Custom5',NULL,'7014',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'909-758-8492',0,'Marty','McGee','Trade Studios, LLC','7350 Greenhaven Ave.','Suite 55','Rancho Cucamonga','CA','91730','US',NULL,NULL,NULL,'AU','OD',NULL,NULL,18,0,0,NULL,0,'0','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002782','2006-3-28 16:37:0','1','3869042235','208.54.15.1','MC','33B036C8AFAED78DD76FC4C746E9E893','37B42BCCA8','111',0,'Custom7',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'925-836-9949',0,'Shannon','Clemens','Real Image','2740 Old Crow Canyon Road','Building 4, Suite 200','San Ramon','CA','94583','US',NULL,NULL,NULL,'AU','OD',NULL,NULL,29.95,197.17,0,NULL,0,'0','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2006-3-29 18:10:0','DEMO',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002783','2006-3-28 16:55:0','1','3869042235','208.54.15.1','MC','33B036C8AFAED78DD76FC4C746E9E893','37B42BCCA8','111',0,'Custom11',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'925-836-9949',0,'Shannon','Clemens','Real Image','2740 Old Crow Canyon Road','Building 4, Suite 200','San Ramon','CA','94583','US',NULL,NULL,NULL,'AU','OD',NULL,NULL,14.95,97.34,53,NULL,0,'0','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002784','2006-3-28 17:7:0','1','3869042235','208.54.15.1','MC','33B036C8AFAED78DD76FC4C746E9E893','37B42BCCA8','111',0,'Custom7',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'925-836-9949',0,'Shannon','Clemens','Real Image','2740 Old Crow Canyon Road','Building 4, Suite 200','San Ramon','CA','94583','US',NULL,NULL,'2006-3-28 17:7:0','AU','SH',NULL,NULL,29.95,157.57,126,NULL,0,'0','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2006-5-24 0:0:0','ADMIN',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002785','2006-3-28 17:17:0','1','3843586823','208.54.15.1','MC','33B036C8AFAED78DD76FC4C746E9E893','37B42BCCA7','222',0,'Custom2',NULL,'7014',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'909-758-8492',0,'Marty','McGee','Trade Studios, LLC','7350 Greenhaven Ave.','Suite 55','Rancho Cucamonga','CA','91730','US',NULL,NULL,'2006-3-28 17:17:0','AU','SH',NULL,NULL,7.95,0,203.99,NULL,0,'0','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2006-5-24 0:0:0','ADMIN',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002786','2006-4-2 21:9:0','1','3843586823','67.164.114.192','MC','33B036C8AFAED78DD76FC4C746E9E893','37B42BCCA7','123',0,'Custom7',NULL,'7014',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'909-758-8492',0,'Marty','McGee','Trade Studios, LLC','7350 Greenhaven Ave.','Suite 55','Rancho Cucamonga','CA','91730','US',NULL,NULL,'2006-4-2 21:9:0','AU','SH',NULL,NULL,29.95,0,360.98,NULL,0,'0','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2006-5-24 0:0:0','ADMIN',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002787','2006-4-2 21:14:0','1','3843586823','67.164.114.192','MC','33B036C8AFAED78DD76FC4C746E9E893','37B52BCCA7','111',0,'Custom7',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'909-758-8492',0,'Marty','McGee','Trade Studios, LLC','7350 Greenhaven Ave.','Suite 55','Rancho Cucamonga','CA','91730','US',NULL,NULL,'2006-4-2 21:14:0','NB','SH',NULL,NULL,29.95,0,346.98,NULL,0,'1','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2006-5-24 0:0:0','ADMIN',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002788','2006-4-12 18:53:0','1','3847830514','70.243.39.118','VI','32B636CEADACD58FD56DC6C544','37B52BCCA7','111',1,'3',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'203-392-0388',0,'Mel','Jackson',NULL,'2000 South IH-35',NULL,'Gable','AL','29928','US',NULL,NULL,NULL,'PA','OD',NULL,NULL,0,0,0,NULL,0,'1','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2006-4-13 13:44:0','ADMIN',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002789','2006-4-13 13:5:0','1','3843586823','71.104.53.109','MC','33B036C8AFAED78DD76FC4C746E9E893','37B42BCCA7','111',0,'Custom2',NULL,'7014',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'909-758-8492',0,'Jim','Warholic','Trade Studios, LLC','13560 Wyandotte St.','2nd Floor','Van Nuys','CA','91405','US',NULL,NULL,'2006-4-13 13:5:0','AU','SH',NULL,NULL,7.95,0,224.99,NULL,0,'0','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2006-5-24 0:0:0','ADMIN',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002790','2006-4-13 13:12:0','1','3843586823','71.104.53.109','MC','33B036C8AFAED78DD76FC4C746E9E893','37B42BCCA7','111',0,'Custom6',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'909-758-8492',0,'Jim','Warholic','Trade Studios, LLC','13560 Wyandotte St.','2nd Floor','Van Nuys','CA','91405','US',NULL,NULL,'2006-4-13 13:12:0','AU','SH',NULL,NULL,0,134.1392,383.98,NULL,0,'0','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2006-5-24 0:0:0','ADMIN',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002791','2006-4-23 1:23:0','1','3863425226','217.16.75.139','AE','34B636CEADACD58FD56DC6DA','','',0,'FEDEX2DAYFREIGHT','',NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'345345345',0,'pete','tester','345','345','345','345','','454545','AF',NULL,NULL,NULL,'NB','OD','','',0,0,0,NULL,0,NULL,'1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2006-4-23 1:26:0','DEMO',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002792','2006-5-18 12:0:0','1','3852512316','66.118.202.132','VI','32B535CDAEAFD68CD66EC5C647E8E897','37B52BCCA7','123',0,'3','',NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'555-555-5555',0,'TEST','AKARD','','123 MAIN ST','','GALVESTON','TX','77550','US',NULL,NULL,'2006-5-18 12:0:0','NB','SH','','',0,0,0,NULL,0,NULL,'1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2006-5-24 0:0:0','ADMIN',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002793','2006-5-18 14:34:0','1','3862954627','71.9.147.236','VI','32B535CDAEAFD68CD66EC5C647E8E897','36BD2BCCA9','313',1,'3',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'7183333333',0,'t','t',NULL,'wet12',NULL,'35t6ewtwe','NJ','07624','US',NULL,NULL,'2006-5-18 14:34:0','PA','SH',NULL,NULL,0,0,0,NULL,0,'0','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2006-5-24 0:0:0','ADMIN',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002794','2006-5-24 14:21:0','1','3843586823','71.104.11.163','MC','33B036C8AFAED78DD76FC4C746E9E893','37B42BCCA7','111',0,'Custom7',NULL,'7014',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'909-758-8492',0,'Marty','McGee','Trade Studios, LLC','7350 Greenhaven Ave.','Suite 55','Rancho Cucamonga','CA','91730','US',NULL,NULL,NULL,'AU','PR',NULL,NULL,29.95,0,227.39,NULL,0,'0','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002795','2006-5-24 14:32:0','1','3843586823','71.104.11.163','MC','33B036C8AFAED78DD76FC4C746E9E893','37B42BCCA7','111',0,'Custom7',NULL,'7014',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'909-758-8492',0,'Marty','McGee','Trade Studios, LLC','7350 Greenhaven Ave.','Suite 55','Rancho Cucamonga','CA','91730','US',NULL,NULL,'2006-5-28 0:0:0','AU','IT',NULL,NULL,29.95,0,358.98,NULL,0,'0','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2006-5-24 14:44:0','ADMIN',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002796','2006-6-5 4:13:0','1','3887311854','65.33.142.157','VI','32B535CDAEAFD68CD66EC5C647E8E897','36B32BCCA6','742',0,'Custom10',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'407-123-1458',0,'Martin','Pearce','','1234 Happy Street','','Orlando','FL','32809','US',NULL,NULL,NULL,'AU','PR',NULL,NULL,12,11.88,0,NULL,0,'1','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002797','2006-6-13 11:36:0','1','3887311854','65.33.142.157','VI','32B535CDAEAFD68CD66EC5C647E8E897','36B32BCCA6','742',1,'3',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'407-123-1458',0,'Martin','Pearce',NULL,'1234 Happy Street',NULL,'Orlando','FL','32809','US',NULL,NULL,'2006-6-14 0:0:0','PA','SH',NULL,NULL,0,67.194,0,NULL,0,'48128BC2-44CABBC1-501-11A5FE','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2006-6-13 11:38:0','DEMO',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002798','2006-6-13 11:48:0','1','3887311854','65.33.142.157','VI','32B535CDAEAFD68CD66EC5C647E8E897','36B32BCCA6','742',1,'3',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'407-123-1458',0,'Martin','Pearce',NULL,'1234 Happy Street',NULL,'Orlando','FL','32809','US',NULL,NULL,'2006-6-13 11:48:0','PA','SH',NULL,NULL,0,0,0,NULL,0,'48128BC2-448F62EC-698-DD938','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2006-6-13 19:39:0','DEMO',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002799','2006-6-13 18:50:0','1','3881984524','71.104.11.163','MC','33B036C8AFAED78DD76FC4C746E9E893','37B62BCEAF','203',0,'Custom11',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'210-928-4938',0,'My Name Is','Test',NULL,'123 Anystreet Blvd.',NULL,'Buffalo','NY','10045','US',NULL,NULL,'2006-6-14 0:0:0','PA','SH','TEST',NULL,9.95,10.8,0,NULL,0,'48128BC2-448F5F42-953-DD938','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2006-6-13 19:15:0','ADMIN',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002800','2006-6-13 19:32:0','1','3887311854','65.33.142.157','VI','32B535CDAEAFD68CD66EC5C647E8E897','36B32BCCA6','742',1,'3',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'407-123-1458',0,'Martin','Pearce',NULL,'1234 Happy Street',NULL,'Orlando','FL','32809','US',NULL,NULL,'2006-6-13 19:32:0','PA','SH',NULL,NULL,0,0,0,NULL,0,'48128BC2-448F6761-382-DD938','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2006-6-13 19:37:0','DEMO',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002801','2006-6-13 19:43:0','1','3881984524','71.104.11.163','MC','33B036C8AFAED78DD76FC4C746E9E893','37B62BCEAF','203',1,'Custom4',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'210-928-4938',0,'My Name Is','Test',NULL,'123 Anystreet Blvd.',NULL,'Buffalo','NY','10045','US',NULL,NULL,'2006-6-13 0:0:0','PA','SH',NULL,NULL,20,6,0,NULL,0,'48128BC2-448F6B49-070-DD938','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2006-6-13 19:50:0','ADMIN',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002802','2006-6-13 20:30:0','1','3881984524','71.104.11.163','MC','33B036C8AFAED78DD76FC4C746E9E893','37B62BCEAF','203',0,'Custom2',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'210-928-4938',0,'My Name Is','Test','','123 Anystreet Blvd.','','Buffalo','NY','10045','US',NULL,NULL,'2006-6-15 0:0:0','PP','PR',NULL,NULL,7.95,24,0,NULL,0,NULL,'1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002803','2006-6-13 20:39:0','1','3881984524','71.104.11.163','MC','33B036C8AFAED78DD76FC4C746E9E893','37B62BCEAF','203',1,'Custom4',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'210-928-4938',0,'My Name Is','Test','','123 Anystreet Blvd.','','Buffalo','NY','10045','US',NULL,NULL,'2006-6-15 0:0:0','PA','SH',NULL,NULL,20,28,0,NULL,0,'48128BC2-448F774B-379-DD938','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002804','2006-6-13 20:42:0','1','3881984524','71.104.11.163','MC','33B036C8AFAED78DD76FC4C746E9E893','37B62BCEAF','203',0,'Custom11',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'210-928-4938',0,'My Name Is','Test',NULL,'123 Anystreet Blvd.',NULL,'Buffalo','NY','10045','US',NULL,NULL,NULL,'VO','CA',NULL,NULL,14.95,16,0,NULL,0,NULL,'1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2006-6-13 20:43:0','ADMIN',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002805','2006-6-13 20:56:0','1','3881984524','71.104.11.163','MC','33B036C8AFAED78DD76FC4C746E9E893','37B62BCEAF','203',0,'Custom5',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'210-928-4938',0,'My Name Is','Test','','123 Anystreet Blvd.','','Buffalo','NY','10045','US',NULL,NULL,NULL,'AU','PR',NULL,NULL,18,22,0,NULL,0,'48128BC2-448F7AC8-589-DD938','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002806','2006-6-13 21:28:0','1','3881984524','71.104.11.163','MC','33B036C8AFAED78DD76FC4C746E9E893','37B62BCEAF','203',1,'Custom2',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'210-928-4938',0,'My Name Is','Test','','123 Anystreet Blvd.','','Buffalo','NY','10045','US',NULL,NULL,'2006-6-16 0:0:0','PA','SH',NULL,NULL,7.95,12,0,NULL,0,'48128BC2-448F823F-250-DD938','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002807','2006-7-26 17:59:0','1','3843586823','71.104.10.249','MC','33B036C8AFAED78DD76FC4C746E9E893','37B42BCCA7','1147',1,'Custom2',NULL,'7014',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'909-758-8492',0,'Marty','McGee','Trade Studios, LLC','7350 Greenhaven Ave.','Suite 55','Rancho Cucamonga','CA','91730','US',NULL,NULL,'2006-7-27 0:0:0','PA','SH',NULL,NULL,7.95,0,135,NULL,0,'48128BC2-44C801F2-571-117AC2','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2006-9-11 17:6:0','ADMIN',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002808','2006-7-27 13:11:0','1','3892472449','71.104.10.249','MC','33B036C8AFAED78DD76FC4C746E9E893','37B52BCCA8','698',1,'Custom10',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'866-855-2278',0,'Alex','oddjob','Trade Studios, LLC','22523 Dolorosa Street','','Woodland Hills','CA','91367','US',NULL,NULL,'2006-7-27 0:0:0','PA','SH',NULL,NULL,12,22.27,0,NULL,0,'48128BC2-44C90FE5-221-119060','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002809','2006-8-2 14:40:0','1','3893187915','75.19.46.119','DI','3FBC33CDADADD385D069C1C345EBEE9E','37B52BCCA8','321',0,'3','',NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'818-505-0755',0,'dick','tracy','','666 main st.','','canoga park','','91364','US',NULL,NULL,NULL,'CA','CA','','',0,0,0,NULL,0,NULL,'1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,'2006-8-2 14:41:0','ADMIN',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002810','2006-8-27 3:53:0','1','3843586823','71.104.46.224','MC','33B036C8AFAED78DD76FC4C746E9E893','37B42BCCA7','111',0,'Priority',NULL,'7014',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'909-758-8492',0,'Marty','McGee','Trade Studios, LLC','7350 Greenhaven Ave.','Suite 55','Rancho Cucamonga','CA','91730','US',NULL,NULL,NULL,'NB','BO',NULL,NULL,29.05,0,199.97,NULL,28.81,NULL,'1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002811','2006-8-28 0:47:0','1','3848236344','127.0.0.1','MC','33B036C8AFAED78DD76FC4C746E9E893','37B52BCCA8','111',0,'Custom3',NULL,'7021',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'815-634-4102',0,'Mike','Gallagher','','556 Yellow Rd.','','Minneapolis','MN','44333','US',NULL,NULL,'2006-8-30 0:0:0','PA','SH','Could you pack this with extra bubble wrap?  Our postman is a bit mean to packages.
Thanks',NULL,14,58.5,90,NULL,0,NULL,'1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002812','2006-8-28 1:18:0','1','3848236344','127.0.0.1','MC','33B036C8AFAED78DD76FC4C746E9E893','37B52BCCA8','111',0,'Custom1',NULL,'7021',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'815-634-4102',0,'Mike','Gallagher','','556 Yellow Rd.','','Minneapolis','MN','44333','US',NULL,NULL,'2006-8-30 0:0:0','PA','SH',NULL,NULL,3.85,26,0,NULL,0,NULL,'1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002813','2006-8-28 1:23:0','1','3848236344','127.0.0.1','MC','33B036C8AFAED78DD76FC4C746E9E893','37B42BCCA7','166',0,'Custom1',NULL,'7021',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'815-634-4102',0,'Mike','Gallagher','','556 Yellow Rd.','','Minneapolis','MN','44333','US',NULL,NULL,NULL,'AU','PR',NULL,NULL,3.85,22.75,0,NULL,0,NULL,'1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002814','2006-8-28 1:24:0','1','3848236344','127.0.0.1','MC','33B036C8AFAED78DD76FC4C746E9E893','37B42BCCA7','166',0,'Custom1',NULL,'7021',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'815-634-4102',0,'Mike','Gallagher','','556 Yellow Rd.','','Minneapolis','MN','44333','US',NULL,NULL,NULL,'AU','PR',NULL,NULL,3.85,22.75,0,NULL,0,NULL,'1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002815','2006-8-28 1:25:0','1','3848236344','127.0.0.1','MC','33B036C8AFAED78DD76FC4C746E9E893','37B52BCCA8','147',0,'Custom9',NULL,'7021',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'815-634-4102',0,'Mike','Gallagher','','556 Yellow Rd.','','Minneapolis','MN','44333','US',NULL,NULL,'2006-8-30 0:0:0','PA','SH',NULL,NULL,9,22.75,0,NULL,0,NULL,'1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002816','2006-8-28 1:27:0','1','3848236344','127.0.0.1','MC','33B036C8AFAED78DD76FC4C746E9E893','37B62BCEAF','111',0,'Custom1',NULL,'7021',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'815-634-4102',0,'Mike','Gallagher','','556 Yellow Rd.','','Minneapolis','MN','44333','US',NULL,NULL,'2006-8-31 0:0:0','PK','SH',NULL,NULL,3.85,3.9,0,NULL,0,NULL,'1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002817','2006-8-28 2:12:0','1','3848236344','127.0.0.1','MC','33B036C8AFAED78DD76FC4C746E9E893','37B52BCCA6','598',0,'Custom1',NULL,'7021',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'815-634-4102',0,'Mike','Gallagher','','556 Yellow Rd.','','Minneapolis','MN','44333','US',NULL,NULL,'2006-8-30 0:0:0','PA','SH',NULL,NULL,3.85,92.95,90,NULL,0,NULL,'1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002818','2006-8-28 4:39:0','1','3843586823','127.0.0.1','MC','33B036C8AFAED78DD76FC4C746E9E893','37B52BCCA8','1654',0,'03',NULL,'7014',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'909-980-5281',0,'Martin','McGee','Trade Studios, LLC','7350 Greenhaven Ave. #55','','Rancho Cucamonga','CA','91730','US',NULL,NULL,'2006-8-30 0:0:0','PA','SH',NULL,NULL,0,0,204.99,NULL,0,NULL,'1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002819','2006-8-28 10:19:0','1','3843586823','127.0.0.1',NULL,NULL,NULL,NULL,0,'Priority',NULL,'7014',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'909-980-5281',0,'Martin','McGee','Trade Studios, LLC','7350 Greenhaven Ave. #55','','Rancho Cucamonga','CA','91730','US',NULL,NULL,'2006-8-30 0:0:0','PA','SH',NULL,NULL,4.05,0.99,0,NULL,0,NULL,'2',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002820','2006-8-28 10:20:0','1','3843586823','127.0.0.1',NULL,NULL,NULL,NULL,0,'Priority',NULL,'7014',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'909-980-5281',0,'Martin','McGee','Trade Studios, LLC','7350 Greenhaven Ave. #55','','Rancho Cucamonga','CA','91730','US',NULL,NULL,'2006-8-30 0:0:0','PA','SH',NULL,NULL,4.05,0.99,0,NULL,0,NULL,'2',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002821','2006-9-11 17:2:0','1','3843586823','127.0.0.1','VI','32B535CDAEAFD68CD66EC5C647E8E897','37B62BCEAF','156',0,'Custom6',NULL,'7014',0,0,'Martin','McGee','Trade Studios, LLC','7350 Greenhaven Ave. #55','','Rancho Cucamonga','CA','91730','US','909-980-5281',NULL,'909-980-5281',0,'Martin','McGee','Trade Studios, LLC','7350 Greenhaven Ave. #55','','Rancho Cucamonga','CA','91730','US','909-980-5281','webmaster@tradestudios.com',NULL,'AU','PR',NULL,NULL,12,104.72,24,NULL,0,'0','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002822','2006-9-11 17:49:0','1','3843586823','127.0.0.1','MC','33B036C8AFAED78DD76FC4C746E9E893','37B52BCCA6','134',0,'Custom9',NULL,'7014',0,0,'Martin','McGee','Trade Studios, LLC','7350 Greenhaven Ave. #55','','Rancho Cucamonga','CA','91730','US','909-980-5281',NULL,'909-980-5281',0,'Martin','McGee','Trade Studios, LLC','7350 Greenhaven Ave. #55','','Rancho Cucamonga','CA','91730','US','909-980-5281','webmaster@tradestudios.com',NULL,'AU','OD',NULL,NULL,30.95,33.16,0,NULL,0,'0','1',NULL,NULL,NULL,'2006-12-8 13:22:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002823','2006-12-9 23:33:0','1','3906022540','24.180.54.61',NULL,NULL,NULL,NULL,0,'FEDEX2DAY',NULL,NULL,0,0,'Bill','College','','7350 Greenhaven Ave. #55','','Rancho Cucamonga','CA','91730','US','909-622-5042',NULL,'909-622-5042',0,'Bill','College','','7350 Greenhaven Ave. #55','','Rancho Cucamonga','CA','91730','US','909-622-5042','',NULL,'NB','OD',NULL,NULL,11.24,4.35,0,NULL,0,NULL,'4',NULL,NULL,NULL,'2006-12-9 23:33:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002824','2006-12-9 23:37:0','1','3906022540','24.180.54.61',NULL,'36B434CCAFAEDE84DE67','37B42BCDAF','321',0,'Priority',NULL,NULL,0,0,'Bill','College','','7350 Greenhaven Ave. #55','','Rancho Cucamonga','CA','91730','US','909-622-5042',NULL,'909-622-5042',0,'Bill','College',NULL,'7350 Greenhaven Ave. #55',NULL,'Rancho Cucamonga','CA','91730','US','909-622-5042','',NULL,'NB','OD',NULL,NULL,4.05,61.62,85,NULL,0,NULL,'4',NULL,NULL,NULL,'2006-12-9 23:37:0',NULL,'2007-1-8 16:12:0','ADMIN',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002826','2007-1-8 15:46:0','1','3909011320','24.24.129.189','VI','3FB434C5A6A7D78DD766','37B42BCDAF','321',0,'01','',NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'(818) 505-0755',0,'Alex','Oddjob','','11616 Ventura Blvd.','','Studio City','CA','91604','US',NULL,NULL,NULL,'NB','OD','','',0,0,0,NULL,0,NULL,'1',NULL,NULL,NULL,'2007-1-8 15:46:0',NULL,'2007-1-8 15:46:0','ADMIN',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002827','2007-1-15 15:5:0','1','3909774919','24.80.237.206',NULL,NULL,NULL,NULL,0,'PRIORITYOVERNIGHT',NULL,NULL,0,0,'Todd','Currie','','test','','Irvine','NY','33009','US','555-555-1212',NULL,'555-555-1212',0,'Todd','Currie','','555 test','','Irvine','CA','92614','US','555-555-1212','',NULL,'NB','OD',NULL,NULL,29.24,33.998,10,NULL,0,NULL,'4',NULL,NULL,NULL,'2007-1-15 15:5:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002828','2007-2-1 12:11:0','1','3893187915','24.137.123.119','DI','3FBC33CDADADD385D069C1C345EBEE9E','37B52BCCA8','321',0,'01','',NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'818-505-0755',0,'dick','tracy','','666 main st.','','canoga park','','91364','US',NULL,NULL,NULL,'NB','OD','','',0,0,0,NULL,0,NULL,'2',NULL,NULL,NULL,'2007-2-1 12:11:0',NULL,'2007-2-1 12:11:0','DEMO',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002829','2007-2-2 1:9:0','1','3911436833','76.175.231.37',NULL,NULL,NULL,NULL,0,'PRIORITYOVERNIGHT',NULL,NULL,0,0,'tom','degrezia','','14702 Central','','Chino','CA','91710','US','909-973-8573',NULL,'909-973-8573',0,'tom','degrezia','','14702 Central','','Chino','CA','91710','US','909-973-8573','',NULL,'NB','OD',NULL,NULL,28.91,28.9993,0,NULL,0,NULL,'2',NULL,NULL,NULL,'2007-2-2 1:9:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002830','2007-2-2 1:10:0','1','3911436833','76.175.231.37',NULL,NULL,NULL,NULL,0,'PRIORITYOVERNIGHT',NULL,NULL,0,0,'tom','degrezia','','14702 Central','','Chino','CA','91710','US','909-973-8573',NULL,'909-973-8573',0,'tom','degrezia','','14702 Central','','Chino','CA','91710','US','909-973-8573','',NULL,'NB','OD',NULL,NULL,28.91,28.9993,0,NULL,0,NULL,'4',NULL,NULL,NULL,'2007-2-2 1:10:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002831','2007-2-14 11:0:0','1','3861847459','203.214.8.233','VI','32B535CDAEAFD68CD66EC5C647E8E897','36B52BCCA9','386',0,'01','',NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'307-733-2706',0,'Sammy','Sosa','','1234 hallow dr','','jackson','AP','83001','US',NULL,NULL,NULL,'NB','OD','','',0,0,0,NULL,0,NULL,'1',NULL,NULL,NULL,'2007-2-14 11:0:0',NULL,'2007-2-14 11:0:0','DEMO',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002832','2007-2-14 11:32:0','1','3912713545','203.214.8.233',NULL,NULL,NULL,NULL,0,'FEDEX2DAY',NULL,NULL,0,0,'Test','User','..','..','..','..','CA','90210','US','90909090',NULL,'90909090',0,'90','90','90','90','90','90','CA','90210','US','sdfadf','',NULL,'NB','OD',NULL,NULL,20.54,64.517,0,NULL,0,NULL,'2',NULL,NULL,NULL,'2007-2-14 11:32:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002833','2007-2-14 11:32:0','1','3912713545','203.214.8.233',NULL,NULL,NULL,NULL,0,'FEDEX2DAY',NULL,NULL,0,0,'Test','User','..','..','..','..','CA','90210','US','90909090',NULL,'90909090',0,'90','90','90','90','90','90','CA','90210','US','sdfadf','',NULL,'NB','OD',NULL,NULL,20.54,64.517,0,NULL,0,NULL,'4',NULL,NULL,NULL,'2007-2-14 11:32:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002834','2007-2-15 15:45:0','1','3912834357','24.24.129.189','MC','34BD34C4A9A8D688D46DC0C04EEFEA95','37B42BCDAF','321',0,'01','',NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'(818) 555-5555',0,'Seneca','Kasper','','2435 Willow Dr.','','Tucson','AZ','85701','US',NULL,NULL,NULL,'NB','OD','','',0,0,0,NULL,0,NULL,'1',NULL,NULL,NULL,'2007-2-15 15:45:0',NULL,'2007-2-15 15:45:0','ADMIN',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002835','2007-2-15 15:49:0','1','3912846435','24.24.129.189','AE','36BC3DC4AEACD188D06BCCC440ECED95','36BD2BCCA6','756',0,'01',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'(765) 765-6525',0,'Omar','Sten',NULL,'4545 Maple Ave',NULL,'Walnut','CA','91789','US',NULL,NULL,NULL,'NB','OD',NULL,NULL,0,0,0,NULL,0,NULL,'1',NULL,NULL,NULL,'2007-2-15 15:49:0',NULL,'2007-2-15 15:50:0','ADMIN',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002836','2007-2-15 15:53:0','1','3912855328','24.24.129.189','DI','37B63CC5A9A9D48DD766CCCF4EEEEF95','37B52BCDAE','465',0,'01',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'(909) 765-8765',0,'August','Suibne',NULL,'87689 Lake Ave.',NULL,'Studio City','CA','91604','US',NULL,NULL,NULL,'NB','OD',NULL,NULL,0,0,0,NULL,0,NULL,'1',NULL,NULL,NULL,'2007-2-15 15:53:0',NULL,'2007-2-15 15:54:0','ADMIN',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002837','2007-2-15 15:58:0','1','3912812957','24.24.129.189','DI','36BC33C5A6A6D68ED56BC7C242EDEC93','36B22BCDAF','001',0,'01',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'(888) 678-7456',0,'Odysseus','Eko',NULL,'78 Mason St.',NULL,'Boston','MA','02108','US',NULL,NULL,NULL,'NB','OD',NULL,NULL,0,0,0,NULL,0,NULL,'1',NULL,NULL,NULL,'2007-2-15 15:58:0',NULL,'2007-2-15 15:58:0','ADMIN',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002838','2007-2-15 16:48:0','1','3912820824','24.24.129.189','VI','37BD3CCBA9ABD58AD266C4C745EAED91','36B12BCCA7','123',0,'01',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'(768) 786-8456',0,'Alma','Ulrike',NULL,'265 Winston ST.',NULL,'Winter Park','FL','32789','US',NULL,NULL,NULL,'NB','OD',NULL,NULL,0,0,0,NULL,0,NULL,'1',NULL,NULL,NULL,'2007-2-15 16:48:0',NULL,'2007-2-15 16:49:0','ADMIN',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002839','2007-2-15 16:51:0','1','3912871017','24.24.129.189','MC','37BD37CBA9ABD38AD467CDC746E0E19E','36B62BCCA6','789',0,'01',NULL,'7014',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'(213) 874-8989',0,'Carmel','Godfried',NULL,'314566 Alameda St.',NULL,'Los Angeles','CA','90026','US',NULL,NULL,NULL,'NB','OD',NULL,NULL,0,0,0,NULL,0,NULL,'1',NULL,NULL,NULL,'2007-2-15 16:51:0',NULL,'2007-2-16 12:12:0','ADMIN',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002840','2007-2-15 17:10:0','1','3912864238','24.24.129.189','AE','37B637C9A9ADD288DF67C1CF46E0E197','36BD2BCCA6','567',0,'01',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'(310) 765-0098',0,'Harald','Helmuth',NULL,'90088 Apache St.',NULL,'Beverly Hills','CA','90210','US',NULL,NULL,NULL,'NB','OD',NULL,NULL,0,0,0,NULL,0,NULL,'1',NULL,NULL,NULL,'2007-2-15 17:10:0',NULL,'2007-2-15 17:10:0','ADMIN',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002841','2007-2-15 17:33:0','1','3912863569','24.24.129.189','VI','34B630C8A6A6D188D76FC4CE4EEEEF93','37B42BCDAF',NULL,0,'01',NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'(818) 555-8976',0,'Herman','Eitan',NULL,'22435 Capistrano St.',NULL,'Woodland Hills','CA','91367','US',NULL,NULL,NULL,'NB','OD',NULL,NULL,0,0,0,NULL,0,NULL,'1',NULL,NULL,NULL,'2007-2-15 17:33:0',NULL,'2007-2-15 17:33:0','ADMIN',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002842','2007-2-15 18:10:0','1','3912877121','24.24.129.189','MC','3EB33CC8ABAAD189D16FC4C744EAED95','37B52BCCA8','350',0,'01','',NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'(876) 767-8766',0,'Avi','Irving','','55764 Washington Ave.','','San Antonio','TX','78201','US',NULL,NULL,NULL,'NB','OD','','',0,0,0,NULL,0,NULL,'1',NULL,NULL,NULL,'2007-2-15 18:10:0',NULL,'2007-2-15 18:10:0','ADMIN',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002843','2007-2-15 18:17:0','1','3912867331','24.24.129.189','MC','36BD3CCDADADD18BD36BC3CF4FE9E09E','37B62BCCA6','130',0,'01','',NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'(789) 765-9008',0,'Varinius','Phocas','','1234 Belt Drive','','Houston','TX','77002','US',NULL,NULL,NULL,'NB','OD','','',0,0,0,NULL,0,NULL,'1',NULL,NULL,NULL,'2007-2-15 18:17:0',NULL,'2007-2-15 18:17:0','ADMIN',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002847','2007-2-15 19:33:0','1','3912850149','24.24.129.189','DI','37B637CCA6A7DF8BD06AC1C240EEE19F','36B22BCCA6','777',0,'01','',NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'(987) 678-4545',0,'Cal','Karim','','47567 Northeast Dr.','','Van Nuys','CA','91401','US',NULL,NULL,NULL,'NB','OD','','',0,0,0,NULL,0,NULL,'1',NULL,NULL,NULL,'2007-2-15 19:33:0',NULL,'2007-2-15 19:33:0','ADMIN',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002848','2007-2-16 9:59:0','1','3912850149','24.24.129.189','DI','37B637CCA6A7DF8BD06AC1C240EEE19F','36B22BCCA6','777',0,'01','',NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'(987) 678-4545',0,'Cal','Karim','','47567 Northeast Dr.','','Van Nuys','CA','91401','US',NULL,NULL,NULL,'NB','OD','','',0,0,0,NULL,0,NULL,'1',NULL,NULL,NULL,'2007-2-16 9:59:0',NULL,'2007-2-16 9:59:0','ADMIN',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002849','2007-2-16 10:12:0','1','3912850149','24.24.129.189','DI','37B637CCA6A7DF8BD06AC1C240EEE19F','36B22BCCA6','777',0,'01','',NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'(987) 678-4545',0,'Cal','Karim','','47567 Northeast Dr.','','Van Nuys','CA','91401','US',NULL,NULL,NULL,'NB','OD','','',0,0,0,NULL,0,NULL,'1',NULL,NULL,NULL,'2007-2-16 10:12:0',NULL,'2007-2-16 10:12:0','ADMIN',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002850','2007-2-16 10:32:0','1','3912937612','24.24.129.189',NULL,NULL,NULL,NULL,0,'FEDEX3DAYFREIGHT',NULL,NULL,0,0,'Gregorios','Jesper','','6665 Mulberry Lane','','Springfield','MO','38863','US','(989) 423-8856',NULL,'(989) 423-8856',0,'Gregorios','Jesper','','6665 Mulberry Lane','','Springfield','MO','38863','US','(989) 423-8856','',NULL,'NB','OD',NULL,NULL,6.95,35.9529,85,NULL,0,NULL,'2',NULL,NULL,NULL,'2007-2-16 10:32:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002851','2007-2-16 11:19:0','1','3843586823','68.190.206.216','MC','33B036C8AFAED78DD76FC4C746E9E893','37B52BCCA7','123',0,'PRIORITYOVERNIGHT',NULL,'7014',0,0,'Martin','McGee','Trade Studios, LLC','7350 Greenhaven Ave. #55','','Rancho Cucamonga','CA','91730','US','909-980-5281',NULL,'909-980-5281',0,'Martin','McGee','Trade Studios, LLC','7350 Greenhaven Ave. #55','','Rancho Cucamonga','CA','91730','US','909-980-5281','webmaster@tradestudios.com',NULL,'NB','OD',NULL,NULL,29.17,65.2464,90,NULL,0,NULL,'1',NULL,NULL,NULL,'2007-2-16 11:19:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002852','2007-2-16 11:23:0','1','3912937612','24.24.129.189','MC','33B036C8AEA6D78BD56DC0C54EEBEE97','36BC2BCCA7','456',0,'FEDEXGROUND',NULL,NULL,0,0,'Gregorios','Jesper','','6665 Mulberry Lane','','Springfield','MO','38863','US','(989) 423-8856',NULL,'(989) 423-8856',0,'Gregorios','Jesper',NULL,'6665 Mulberry Lane',NULL,'Springfield','MO','38863','US','(989) 423-8856','',NULL,'NB','OD',NULL,NULL,9.45,35.9529,85,NULL,0,NULL,'1',NULL,NULL,NULL,'2007-2-16 11:23:0',NULL,'2007-2-16 12:9:0','ADMIN',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002853','2007-2-16 12:26:0','1','3843586823','68.190.206.216','MC','33B036C8AFAED78DD76FC4C746E9E893','36B52BCCA6','123',0,'FEDEXGROUND',NULL,'7014',0,0,'Martin','McGee','Trade Studios, LLC','7350 Greenhaven Ave. #55','','Rancho Cucamonga','CA','91730','US','909-980-5281',NULL,'909-980-5281',0,'Martin','McGee','Trade Studios, LLC','7350 Greenhaven Ave. #55','','Rancho Cucamonga','CA','91730','US','909-980-5281','webmaster@tradestudios.com',NULL,'AU','OD',NULL,NULL,6.43,20.2993,0,NULL,0,'0','1',NULL,NULL,NULL,'2007-2-16 12:26:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002854','2007-2-16 12:46:0','1','3912929219','24.24.129.189','MC','33B036C8AEA6D78BD56DC0C54EEBEE97','36B02BCCA7','006',0,'FEDEXGROUND',NULL,NULL,0,0,'Art','Vandalay','Vandalay Insdustries','789 Kramer St.','','New York','NY','10002','US','(212) 876-6743',NULL,'(212) 876-6743',0,'Krystyn','Maximus','','345 Day Dr.','','Phoenix','AZ','90087','US','(877) 787-0098','',NULL,'AU','OD',NULL,NULL,6.51,61.9972,85,NULL,0,'0','1',NULL,NULL,NULL,'2007-2-16 12:46:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002855','2007-2-16 12:53:0','1','3912953013','24.24.129.189',NULL,NULL,NULL,NULL,0,'PRIORITYOVERNIGHT',NULL,NULL,0,0,'Albert','Teodor','','898 Serenity Dr.','','Woodland Hills','CA','91367','US','(898) 767-0045',NULL,'(898) 767-0045',0,'Felix','Havock','','668 Red Rock Ave.','','Berkeley','CA','90087','US','(787) 789-0098','',NULL,'NB','OD',NULL,NULL,43.2,65.9344,90,NULL,0,NULL,'4',NULL,NULL,NULL,'2007-2-16 12:53:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002856','2007-2-16 13:9:0','1','3912988721','24.24.129.189',NULL,NULL,NULL,NULL,0,'Default',NULL,NULL,0,0,'Milburn','Vitaly','','678 Walnut Dr.','','Lodi','CA','88001','US','(898) 678-9876',NULL,'(898) 678-9876',0,'Milburn','Vitaly','','678 Walnut Dr.','','Lodi','CA','88001','US','(898) 678-9876','',NULL,'NB','OD',NULL,NULL,6.95,49.2957,0,NULL,0,NULL,'4',NULL,NULL,NULL,'2007-2-16 13:9:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002857','2007-2-16 13:24:0','1','3912950543','24.24.129.189',NULL,NULL,NULL,NULL,0,'PRIORITYOVERNIGHT',NULL,NULL,0,0,'Margareta','Astraea','','909 Flummer Dr.','','Kansas City','MO','64102','US','(876) 456-1212',NULL,'(876) 456-1212',0,'Margareta','Astraea','','909 Flummer Dr.','','Kansas City','MO','64102','US','(876) 456-1212','',NULL,'NB','OD',NULL,NULL,88.51,29.6092,0,NULL,0,NULL,'4',NULL,NULL,NULL,'2007-2-16 13:24:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002858','2007-2-16 13:26:0','1','3912947747','68.190.206.216','MC','33B036C8AFAED78DD76FC4C746E9E893','37B52BCCA6','987',0,'FEDEXGROUND',NULL,NULL,0,0,'Sharon','Temple','','2829 Sunset Dr.','','Hollywood','CA','90495','US','213-758-1362',NULL,'213-758-1362',0,'Sharon','Temple','','2829 Sunset Dr.','','Hollywood','CA','90495','US','213-758-1362','',NULL,'AU','OD',NULL,NULL,13.26,24.6486,0,NULL,0,'0','1',NULL,NULL,NULL,'2007-2-16 13:26:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002859','2007-2-16 13:51:0','1','3912982564','24.24.129.189','VI','32B535CDAEAFD68CD66EC5C647E8E897','37B42BCDAF','321',0,'FEDEX3DAYFREIGHT',NULL,NULL,0,0,'alex','ocuna','','909 Train Rd','','Tucson','AZ','85704','US','(715) 768-0098',NULL,'(715) 768-0098',0,'alex','ocuna','','909 Train Rd','','Tucson','AZ','85704','US','(715) 768-0098','',NULL,'AU','OD',NULL,NULL,34.14,48.0166,85,NULL,0,'0','1',NULL,NULL,NULL,'2007-2-16 13:51:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002860','2007-2-16 13:59:0','1','3912995630','24.24.129.189',NULL,NULL,NULL,NULL,0,'FEDEXGROUND',NULL,NULL,0,0,'Hikaru','Kazuo','','4142 Lake Dr.','','Lake Forrest','ME','90035','US','(131) 789-0098',NULL,'(131) 789-0098',0,'Hikaru','Kazuo','','4142 Lake Dr.','','Lake Forrest','ME','90035','US','(131) 789-0098','',NULL,'NB','OD',NULL,NULL,12.94,41.997,24,NULL,0,NULL,'4',NULL,NULL,NULL,'2007-2-16 13:59:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002861','2007-2-16 14:7:0','1','3912944350','24.24.129.189','VI','32B535CDAEAFD68CD66EC5C647E8E897','36B22BCDAF','001',0,'PRIORITYOVERNIGHT',NULL,NULL,0,0,'Yankel','Yoram','','876 Kane Dr.','','Beverly Hills','CA','90210','US','(310) 765-3377',NULL,'(310) 765-3377',0,'Yankel','Yoram','','876 Kane Dr.','','Beverly Hills','CA','90210','US','(310) 765-3377','',NULL,'AU','OD',NULL,NULL,58.34,63.647,0,NULL,0,'0','1',NULL,NULL,NULL,'2007-2-16 14:7:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002862','2007-2-16 14:28:0','1','3912955515','24.24.129.189',NULL,NULL,NULL,NULL,0,'FEDEX2DAY',NULL,NULL,0,0,'Hyun','Jung','','123 Buena Ave.','','Coco Beach','FL','32931','US','(657) 126-0075',NULL,'(657) 126-0075',0,'Hyun','Jung','','123 Buena Ave.','','Coco Beach','FL','32931','US','(657) 126-0075','',NULL,'NB','OD',NULL,NULL,61.22,82.7964,85,NULL,0,NULL,'4',NULL,NULL,NULL,'2007-2-16 14:28:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002863','2007-2-16 15:10:0','1','3912930955','24.24.129.189',NULL,NULL,NULL,NULL,0,'PRIORITYOVERNIGHT',NULL,NULL,0,0,'Horacio','Daniel','','866 Turtle Dr.','','Hartford','CT','06106','US','(908) 567-1212',NULL,'(908) 567-1212',0,'Horacio','Daniel','','866 Turtle Dr.','','Hartford','CT','06106','US','(908) 567-1212','',NULL,'NB','OD',NULL,NULL,126.74,52.7634,0,NULL,0,NULL,'4',NULL,NULL,NULL,'2007-2-16 15:10:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002864','2007-2-16 15:22:0','1','3912944313','24.24.129.189','VI','32B535CDAEAFD68CD66EC5C647E8E897','36BD2BCCA6','678',0,'FEDEXGROUND',NULL,NULL,0,0,'Gheorghe','Patxi','','1234 89th St.','','Pasadena','CA','91103','US','(774) 678-1264',NULL,'(774) 678-1264',0,'Gheorghe','Patxi','','1234 89th St.','','Pasadena','CA','91103','US','(774) 678-1264','',NULL,'AU','OD',NULL,NULL,13.26,69.5928,90,NULL,0,'0','1',NULL,NULL,NULL,'2007-2-16 15:22:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002865','2007-2-16 15:30:0','1','3912932935','24.24.129.189',NULL,NULL,NULL,NULL,0,'FEDEX3DAYFREIGHT',NULL,NULL,0,0,'Wasswa','Flynn','','4678 Donna Dr.','','Mercury','RI','90076','US','(345) 567-1234',NULL,'(345) 567-1234',0,'Wasswa','Flynn','','4678 Donna Dr.','','Mercury','RI','90076','US','(345) 567-1234','',NULL,'NB','OD',NULL,NULL,13.42,32.893,0,NULL,0,NULL,'4',NULL,NULL,NULL,'2007-2-16 15:30:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002866','2007-2-16 15:48:0','1','3912971559','24.24.129.189','MC','33B036C8AFAED78DD76FC4C746E9E893','37B52BCCA7','123',0,'PRIORITYOVERNIGHT',NULL,NULL,0,0,'Gabriel','Robert','','345 Nathan St.','','Denver','CO','80014','US','(733) 655-6437',NULL,'(733) 655-6437',0,'Gabriel','Robert','','345 Nathan St.','','Denver','CO','80014','US','(733) 655-6437','',NULL,'AU','OD',NULL,NULL,111.82,31.318,0,NULL,0,'0','1',NULL,NULL,NULL,'2007-2-16 15:48:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002867','2007-2-16 16:1:0','1','3912927327','24.24.129.189','MC','33B036C8AEA6D78BD56DC0C54EEBEE97','36BC2BCCA7','456',0,'FEDEX3DAYFREIGHT',NULL,NULL,0,0,'Gerry','Rafiq','','4545 Washington Ave.','','Los Angeles','CA','90028','US','(323) 867-1279',NULL,'(323) 867-1279',0,'Gerry','Rafiq','','4545 Washington Ave.','','Los Angeles','CA','90028','US','(323) 867-1279','',NULL,'AU','OD',NULL,NULL,13.9,103.6707,90,NULL,0,'0','1',NULL,NULL,NULL,'2007-2-16 16:1:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002868','2007-2-16 16:6:0','1','3912969416','24.24.129.189',NULL,NULL,NULL,NULL,0,'FEDEX2DAY',NULL,NULL,0,0,'Cadence','Jan','','555 Hazel St.','','Punxsutawny','PA','15767','US','(868) 367-1199',NULL,'(868) 367-1199',0,'Cadence','Jan','','555 Hazel St.','','Punxsutawny','PA','15767','US','(868) 367-1199','',NULL,'NB','OD',NULL,NULL,66.08,55.1958,24,NULL,0,NULL,'4',NULL,NULL,NULL,'2007-2-16 16:6:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002869','2007-2-19 10:5:0','1','3913285427','24.24.129.189',NULL,NULL,NULL,NULL,0,'FEDEXGROUND',NULL,NULL,0,0,'Christiaan','Thorvald','','5685 Glen St.','','Fort Lauderdale','FL','33304','US','(678) 345-0090',NULL,'(678) 345-0090',0,'Christiaan','Thorvald','','5685 Glen St.','','Fort Lauderdale','FL','33304','US','(678) 345-0090','',NULL,'NB','OD',NULL,NULL,72.51,58.7988,0,NULL,0,NULL,'4',NULL,NULL,NULL,'2007-2-19 10:5:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002870','2007-2-19 10:16:0','1','3913293550','24.24.129.189','VI','32B735CFAFADD28ED66CC4C144EFE091','36B52BCCA7','321',0,'FEDEX3DAYFREIGHT',NULL,NULL,0,0,'Gino','Emil','','8989 Crestview Ln.','','Dayton','OH','45405','US','(787) 576-0011',NULL,'(787) 576-0011',0,'Gino','Emil','','8989 Crestview Ln.','','Dayton','OH','45405','US','(787) 576-0011','',NULL,'AU','OD',NULL,NULL,61.22,15.8664,0,NULL,0,'0','1',NULL,NULL,NULL,'2007-2-19 10:16:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002871','2007-2-19 10:33:0','1','3913272243','24.24.129.189','VI','32B735CFAFADD28ED66CC4C144EFE091','36B52BCCA7','443',0,'FEDEX3DAYFREIGHT',NULL,NULL,0,0,'Daniel','Johan','','8907 Stern St.','','Longport','NJ','08403','US','(212) 780-7865',NULL,'(212) 780-7865',0,'Daniel','Johan','','8907 Stern St.','','Longport','NJ','08403','US','(212) 780-7865','',NULL,'AU','OD',NULL,NULL,13.9,77.3934,109,NULL,0,'0','1',NULL,NULL,NULL,'2007-2-19 10:33:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002872','2007-2-19 11:47:0','1','3913231112','24.24.129.189','VI','32B735CFAFADD28ED66CC4C144EFE091','36B52BCCA7','321',0,'FEDEXGROUND',NULL,NULL,0,0,'Lemmy','Isocrates','','1236 Maple St.','','Johnson','MN','56236','US','(887) 353-7562',NULL,'(887) 353-7562',0,'Lemmy','Isocrates','','1236 Maple St.','','Johnson','MN','56236','US','(887) 353-7562','',NULL,'AU','OD',NULL,NULL,6.95,12.8668,0,NULL,0,'0','1',NULL,NULL,NULL,'2007-2-19 11:47:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002873','2007-2-19 12:17:0','1','3913253837','24.24.129.189','VI','32B735CFAFADD28ED66CC4C144EFE091','36BC2BCCA7','321',0,'FEDEXGROUND',NULL,NULL,0,0,'Sean','Elias','','3131 Orange Grove Ave.','','Anaheim','CA','92805','US','(562) 789-3287',NULL,'(562) 789-3287',0,'Sean','Elias','','3131 Orange Grove Ave.','','Anaheim','CA','92805','US','(562) 789-3287','',NULL,'AU','OD',NULL,NULL,13.9,15.2207,0,NULL,0,'0','1',NULL,NULL,NULL,'2007-2-19 12:17:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002874','2007-2-19 13:22:0','1','3913287262','24.24.129.189',NULL,NULL,NULL,NULL,0,'PRIORITYOVERNIGHT',NULL,NULL,0,0,'Carol','Marcial','','67 Dexter Ave.','','New Orleans','LA','70116','US','(980) 878-4545',NULL,'(980) 878-4545',0,'Carol','Marcial','','67 Dexter Ave.','','New Orleans','LA','70116','US','(980) 878-4545','',NULL,'NB','OD',NULL,NULL,91.1,24.7972,0,NULL,0,NULL,'4',NULL,NULL,NULL,'2007-2-19 13:22:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002875','2007-2-19 13:51:0','1','3913229655','24.24.129.189',NULL,NULL,NULL,NULL,0,'Default',NULL,NULL,0,0,'Javier','Uinseann','','3131 Lake Ave.','','Santa Clara','CA','95054','US','(898) 565-0044',NULL,'(898) 565-0044',0,'Javier','Uinseann','','3131 Lake Ave.','','Santa Clara','MS','95054','US','(898) 565-0044','',NULL,'NB','OD',NULL,NULL,6.95,54.3728,0,NULL,0,NULL,'4',NULL,NULL,NULL,'2007-2-19 13:51:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002876','2007-2-19 15:15:0','1','3913225613','24.24.129.189','VI','32B735CFAFADD28ED66CC4C144EFE091','36B52BCCA6','436',0,'FEDEXGROUND',NULL,NULL,0,0,'Foster','Maitland','','300 Waterfront Rd.','','kansas city','MO','64112','US','(787) 546-8822',NULL,'(787) 546-8822',0,'Foster','Maitland','','300 Waterfront Rd.','','kansas city','MO','64112','US','(787) 546-8822','',NULL,'AU','OD',NULL,NULL,6.95,13.9569,0,NULL,0,'0','1',NULL,NULL,NULL,'2007-2-19 15:15:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002877','2007-2-21 19:53:0','1','3913427040','61.95.72.202',NULL,NULL,NULL,NULL,0,'FEDEXGROUND',NULL,NULL,0,0,'gh','dfg','','cvcx','','cvcx','DE','11214','US','32232323',NULL,'32232323',0,'dg','gdf','','vcx','','cvxcv','CA','11214','US','1111222333','',NULL,'NB','OD',NULL,NULL,7.27,0,85,NULL,0,NULL,'4',NULL,NULL,NULL,'2007-2-21 19:53:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002878','2007-3-10 14:18:0','1','3843586823','127.0.0.1','MC',NULL,NULL,NULL,1,'01',NULL,'7014',0,0,'Martin','McGee','Trade Studios, LLC','7350 Greenhaven Ave. #55','','Rancho Cucamonga','CA','91730','US','909-980-5281',NULL,'909-980-5281',0,'Martin','McGee','Trade Studios, LLC','7350 Greenhaven Ave. #55',NULL,'Rancho Cucamonga','CA','91730','US','909-980-5281','webmaster@tradestudios.com',NULL,'PA','OD',NULL,NULL,32.11,40.8533,0,NULL,96.4064,NULL,'4',NULL,NULL,NULL,'2007-3-10 14:18:0',NULL,'2007-3-22 16:4:0','ADMIN',0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002879','2007-3-25 11:47:0','1','3843586823','127.0.0.1',NULL,NULL,NULL,NULL,0,'Custom5',NULL,'7014',0,0,'Martin','McGee','Trade Studios, LLC','7350 Greenhaven Ave. #55','','Rancho Cucamonga','CA','91730','US','909-980-5281',NULL,'909-980-5281',0,'Martin','McGee','Trade Studios, LLC','7350 Greenhaven Ave. #55','','Rancho Cucamonga','CA','91730','US','909-980-5281','webmaster@tradestudios.com',NULL,'NB','OD',NULL,NULL,369.6,0,62.2,NULL,0,NULL,'4',NULL,NULL,NULL,'2007-3-25 11:47:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002880','2007-3-25 14:0:0','1','3843586823','127.0.0.1',NULL,NULL,NULL,NULL,0,'CustomP1',NULL,'7014',0,0,'Martin','McGee','Trade Studios, LLC','7350 Greenhaven Ave. #55','','Rancho Cucamonga','CA','91730','US','909-980-5281',NULL,'909-980-5281',0,'Martin','McGee','Trade Studios, LLC','7350 Greenhaven Ave. #55','','Rancho Cucamonga','CA','91730','US','909-980-5281','webmaster@tradestudios.com',NULL,'NB','OD',NULL,NULL,35,0,240.99,NULL,0,NULL,'4',NULL,NULL,NULL,'2007-3-25 14:0:0',NULL,NULL,NULL,0)
INSERT INTO dbo.Orders (OrderID,DateEntered,SiteID,CustomerID,IPAddress,CCName,CCNum,CCExpDate,CCCVV,PaymentVerified,ShippingMethod,TrackingNumber,AffiliateID,AffiliatePaid,AffiliateTotal,orders_FirstName,orders_LastName,orders_CompanyName,orders_Address1,orders_Address2,orders_City,orders_State,orders_Zip,orders_Country,orders_Phone,orders_Email,Phone,ShipToMultiple,oShipFirstName,oShipLastName,oShipCompanyName,oShipAddress1,oShipAddress2,oShipCity,oShipState,oShipZip,oShipCountry,oShipPhone,oShipEmail,ShipDate,BillingStatus,OrderStatus,CustomerComments,Comments,ShippingTotal,TaxTotal,DiscountTotal,DiscountUsed,CreditApplied,TransactionID,FormOfPayment,Downloaded,Terms,Reference,DateInvoiced,DatePaid,DateUpdated,UpdatedBy,Deleted) VALUES('1002881','2007-3-25 14:7:0','1','3843586823','127.0.0.1',NULL,NULL,NULL,NULL,0,'Custom9',NULL,'7014',0,0,'Martin','McGee','Trade Studios, LLC','7350 Greenhaven Ave. #55','','Rancho Cucamonga','CA','91730','US','909-980-5281',NULL,'909-980-5281',0,'Martin','McGee','Trade Studios, LLC','7350 Greenhaven Ave. #55','','Rancho Cucamonga','CA','91730','US','909-980-5281','webmaster@tradestudios.com',NULL,'NB','OD',NULL,NULL,9.9,0,86.7,NULL,0,NULL,'4',NULL,NULL,NULL,'2007-3-25 14:7:0',NULL,NULL,NULL,0)
IF (IDENT_SEED('dbo.Orders') IS NOT NULL )	SET IDENTITY_INSERT dbo.Orders OFF
GO
GO
ALTER TABLE dbo.Orders CHECK CONSTRAINT ALL
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
--Insert data into dbo.PayFlowLink
-----------------------------------------------------------
ALTER TABLE dbo.PayFlowLink NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.PayFlowLink
GO

IF (IDENT_SEED('dbo.PayFlowLink') IS NOT NULL )	SET IDENTITY_INSERT dbo.PayFlowLink ON
IF (IDENT_SEED('dbo.PayFlowLink') IS NOT NULL )	SET IDENTITY_INSERT dbo.PayFlowLink OFF
GO
GO
ALTER TABLE dbo.PayFlowLink CHECK CONSTRAINT ALL
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
--Insert data into dbo.PGPayPal
-----------------------------------------------------------
ALTER TABLE dbo.PGPayPal NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.PGPayPal
GO

IF (IDENT_SEED('dbo.PGPayPal') IS NOT NULL )	SET IDENTITY_INSERT dbo.PGPayPal ON
INSERT INTO dbo.PGPayPal (PPID,PayPalAccount,PayPalLogo,IDToken) VALUES('1','billing@tradestudios.com',NULL,NULL)
IF (IDENT_SEED('dbo.PGPayPal') IS NOT NULL )	SET IDENTITY_INSERT dbo.PGPayPal OFF
GO
GO
ALTER TABLE dbo.PGPayPal CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.PGYourPayAPI
-----------------------------------------------------------
ALTER TABLE dbo.PGYourPayAPI NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.PGYourPayAPI
GO

IF (IDENT_SEED('dbo.PGYourPayAPI') IS NOT NULL )	SET IDENTITY_INSERT dbo.PGYourPayAPI ON
INSERT INTO dbo.PGYourPayAPI (ID,StoreNumber,PEMFileLocation,LiveMode,InUse) VALUES('1','1909943620','C:\Domains\cartfusion.net\wwwroot\admin\yourpay\1909943620.pem',1,1)
IF (IDENT_SEED('dbo.PGYourPayAPI') IS NOT NULL )	SET IDENTITY_INSERT dbo.PGYourPayAPI OFF
GO
GO
ALTER TABLE dbo.PGYourPayAPI CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.ProductOptions
-----------------------------------------------------------
ALTER TABLE dbo.ProductOptions NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.ProductOptions
GO

IF (IDENT_SEED('dbo.ProductOptions') IS NOT NULL )	SET IDENTITY_INSERT dbo.ProductOptions ON
INSERT INTO dbo.ProductOptions (ItemAltID,ItemID,OptionName,OptionColumn,OptionPrice,StockQuantity,ItemStatus,OptionSellByStock,Hide,Comments,DateCreated,DateUpdated,UpdatedBy,ImageProduct,ImageColor,RProItem,RProSID,rdi_date_removed,Item_fldShipAmount,Item_fldShipWeight,Item_fldHandAmount,Item_fldOversize,Item_fldShipByWeight) VALUES('1','2','Black','1',0,'97','IS',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,1)
INSERT INTO dbo.ProductOptions (ItemAltID,ItemID,OptionName,OptionColumn,OptionPrice,StockQuantity,ItemStatus,OptionSellByStock,Hide,Comments,DateCreated,DateUpdated,UpdatedBy,ImageProduct,ImageColor,RProItem,RProSID,rdi_date_removed,Item_fldShipAmount,Item_fldShipWeight,Item_fldHandAmount,Item_fldOversize,Item_fldShipByWeight) VALUES('3','2','Black / Silver','1',10,'98','IS',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,1)
INSERT INTO dbo.ProductOptions (ItemAltID,ItemID,OptionName,OptionColumn,OptionPrice,StockQuantity,ItemStatus,OptionSellByStock,Hide,Comments,DateCreated,DateUpdated,UpdatedBy,ImageProduct,ImageColor,RProItem,RProSID,rdi_date_removed,Item_fldShipAmount,Item_fldShipWeight,Item_fldHandAmount,Item_fldOversize,Item_fldShipByWeight) VALUES('4','2','55-85mm Lens','2',300,'15','IS',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,1)
INSERT INTO dbo.ProductOptions (ItemAltID,ItemID,OptionName,OptionColumn,OptionPrice,StockQuantity,ItemStatus,OptionSellByStock,Hide,Comments,DateCreated,DateUpdated,UpdatedBy,ImageProduct,ImageColor,RProItem,RProSID,rdi_date_removed,Item_fldShipAmount,Item_fldShipWeight,Item_fldHandAmount,Item_fldOversize,Item_fldShipByWeight) VALUES('5','2','Leather Case','3',49,'296','IS',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,1)
INSERT INTO dbo.ProductOptions (ItemAltID,ItemID,OptionName,OptionColumn,OptionPrice,StockQuantity,ItemStatus,OptionSellByStock,Hide,Comments,DateCreated,DateUpdated,UpdatedBy,ImageProduct,ImageColor,RProItem,RProSID,rdi_date_removed,Item_fldShipAmount,Item_fldShipWeight,Item_fldHandAmount,Item_fldOversize,Item_fldShipByWeight) VALUES('6','29','Black','1',2,'998','IS',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,1)
INSERT INTO dbo.ProductOptions (ItemAltID,ItemID,OptionName,OptionColumn,OptionPrice,StockQuantity,ItemStatus,OptionSellByStock,Hide,Comments,DateCreated,DateUpdated,UpdatedBy,ImageProduct,ImageColor,RProItem,RProSID,rdi_date_removed,Item_fldShipAmount,Item_fldShipWeight,Item_fldHandAmount,Item_fldOversize,Item_fldShipByWeight) VALUES('7','29','Brown','1',0,'1000','IS',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,1)
INSERT INTO dbo.ProductOptions (ItemAltID,ItemID,OptionName,OptionColumn,OptionPrice,StockQuantity,ItemStatus,OptionSellByStock,Hide,Comments,DateCreated,DateUpdated,UpdatedBy,ImageProduct,ImageColor,RProItem,RProSID,rdi_date_removed,Item_fldShipAmount,Item_fldShipWeight,Item_fldHandAmount,Item_fldOversize,Item_fldShipByWeight) VALUES('8','29','Small','2',0,'1000','IS',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,1)
INSERT INTO dbo.ProductOptions (ItemAltID,ItemID,OptionName,OptionColumn,OptionPrice,StockQuantity,ItemStatus,OptionSellByStock,Hide,Comments,DateCreated,DateUpdated,UpdatedBy,ImageProduct,ImageColor,RProItem,RProSID,rdi_date_removed,Item_fldShipAmount,Item_fldShipWeight,Item_fldHandAmount,Item_fldOversize,Item_fldShipByWeight) VALUES('9','29','Medium','2',5,'999','IS',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,1)
INSERT INTO dbo.ProductOptions (ItemAltID,ItemID,OptionName,OptionColumn,OptionPrice,StockQuantity,ItemStatus,OptionSellByStock,Hide,Comments,DateCreated,DateUpdated,UpdatedBy,ImageProduct,ImageColor,RProItem,RProSID,rdi_date_removed,Item_fldShipAmount,Item_fldShipWeight,Item_fldHandAmount,Item_fldOversize,Item_fldShipByWeight) VALUES('10','29','Large','2',10,'999','IS',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,1)
IF (IDENT_SEED('dbo.ProductOptions') IS NOT NULL )	SET IDENTITY_INSERT dbo.ProductOptions OFF
GO
GO
ALTER TABLE dbo.ProductOptions CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.ProductReviews
-----------------------------------------------------------
ALTER TABLE dbo.ProductReviews NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.ProductReviews
GO

IF (IDENT_SEED('dbo.ProductReviews') IS NOT NULL )	SET IDENTITY_INSERT dbo.ProductReviews ON
INSERT INTO dbo.ProductReviews (PRID,ItemID,Review,Rating,DateCreated) VALUES('1','1','This camera produces excellent quality photos. In fact, the results are much better than I expected. Ergonomics are extremely good, too. The 4x zoom lens is very sharp. AF is very quick and accurate. Low light performance has been much better than expected. This camera is much better than Canon G3 I have in almost every way. I have been able to take outstanding pictures with this camera -- better than the ones that come out of my Minolta SLR with prime lenses. Wow!','5','2005-4-29 20:43:0')
INSERT INTO dbo.ProductReviews (PRID,ItemID,Review,Rating,DateCreated) VALUES('2','1','I just took this out of the box, have never owned a digital camera before; I read the quick-start brochure, and after putting in the batteries was snapping pictures of all my co-workers. The color, and clarity is brilliant. I also plugged it right into my computer and the pictures came right up! AMAZING is all I can say - an overall wonderful camera - can''t wait to see what else it does.','5','2005-4-29 20:43:0')
INSERT INTO dbo.ProductReviews (PRID,ItemID,Review,Rating,DateCreated) VALUES('3','1','Needed to get some landscaping shots and bought the Canon PowerShot A510 because it was under $200 (all I could afford). Read the easy instructions and it was up and running within 5 minutes! I was taking great shots and was amazed when I printed them out! Clear and beautiful. I''m just an amateur but this camera is perfect when you''re on a budget but still want great shots. Recommend highly!','5','2005-4-29 20:44:0')
INSERT INTO dbo.ProductReviews (PRID,ItemID,Review,Rating,DateCreated) VALUES('4','1','I bought the G6 at the same time as the new A510 (the 510 was a gift)compared shots taken in identical situations-indoor with flash, on auto and the 510 pix came out sharper and more vibrant. With my new baby due to arrive any day and anticipating a lot of indoor pix the G6 is a major disappointment especially with the $350 price difference. I returned it and got another 510 for myself.','4','2005-4-29 20:44:0')
INSERT INTO dbo.ProductReviews (PRID,ItemID,Review,Rating,DateCreated) VALUES('5','26','Pretty cool, but not as many features as expected, and sometimes out of focus.','4','2005-5-2 21:5:0')
INSERT INTO dbo.ProductReviews (PRID,ItemID,Review,Rating,DateCreated) VALUES('7','7','One of the best!!!','5','2005-5-3 20:41:0')
INSERT INTO dbo.ProductReviews (PRID,ItemID,Review,Rating,DateCreated) VALUES('8','5','If the A95 proves anything it is that you don''t need to spend a huge amount of money to get stunning results','5','2005-5-4 19:52:0')
INSERT INTO dbo.ProductReviews (PRID,ItemID,Review,Rating,DateCreated) VALUES('9','5','The PowerShot A95 is one of the few digital cameras that just seem to get everything right, with very few weaknesses','5','2005-5-4 19:52:0')
INSERT INTO dbo.ProductReviews (PRID,ItemID,Review,Rating,DateCreated) VALUES('10','5','I took it on a two week trip to Italy and I was amazed at its performance. I have owned 3 digital and 5 or 6 good SLR cameras and this is the best. Can not say enough good things about it. Only caution I have is not related to the camera but to the memory card. Get a fast card. Spend the money, it is worth it.','5','2005-5-4 19:52:0')
INSERT INTO dbo.ProductReviews (PRID,ItemID,Review,Rating,DateCreated) VALUES('11','5','This camera is perfect. It has everything you need. It doesn''t have a lot of wasted features on it to just make it look better like the more expensive ones do. The quality is phenomenal.','5','2005-5-4 19:53:0')
INSERT INTO dbo.ProductReviews (PRID,ItemID,Review,Rating,DateCreated) VALUES('12','5','I bought the A95 as a Christmas present for my son, a high school senior and soon-to-be design student in college. I''ve been amazed at what he''s done with it, with the quality of images, and with the playback mode. He''s been photo stitching beautiful panoramas, experimenting with low light shots, reflections, black and white, manual settings, you name it. He goes on trips, brings the camera back, plugs it into the TV, and wow, what slide shows! I''ve been especially impressed with the zoom feature. It''s extremely easy to zoom in and out (to 10x) and move around within the frame. Frankly, it puts my Nikon D70 to shame in this regard. For the price, I don''t see how you could get a better camera. I would add that I''ve been surprised with the quality of the 400 ISO shots. There is some graininess of course, but you can get useable 4x6 shots, but at ISO 100 and 50, the pictures are very smooth. I also don''t understand complaints about build quality. No doubt there are lemons out there just like every other model camera on the market, but I''ve seen nothing to complain about on quality. Both he and I have been thoroughly impressed with this little camera.','4','2005-5-4 19:53:0')
INSERT INTO dbo.ProductReviews (PRID,ItemID,Review,Rating,DateCreated) VALUES('13','5','I''ve been doing amateur level photography for five years with Canon SLRs. What a revolution we have here! The camera not only matches (or very closely matches) the quality of SLRs in up to 10x12 prints, it can handle quite a pounding. Have dropped my camera twice on cement pavement from up high. Have thoroughly inspected numerous large prints for any signs of lens and/or focusing errors and have found NONE! WOW.
Am even considering camera for my head-shots, with a little software brushing. Very Satisfied.!','5','2005-5-4 19:53:0')
INSERT INTO dbo.ProductReviews (PRID,ItemID,Review,Rating,DateCreated) VALUES('14','23','I had one for about a year until I found the Canon A95.  Make the switch if you get the chance!','3','2005-5-10 14:57:0')
INSERT INTO dbo.ProductReviews (PRID,ItemID,Review,Rating,DateCreated) VALUES('15','3','Excellent SLR.','5','2005-6-14 5:34:0')
INSERT INTO dbo.ProductReviews (PRID,ItemID,Review,Rating,DateCreated) VALUES('17','3','sweet!','5','2005-7-12 20:38:0')
INSERT INTO dbo.ProductReviews (PRID,ItemID,Review,Rating,DateCreated) VALUES('20','20','Highly Recommended','5','2005-9-9 12:55:0')
INSERT INTO dbo.ProductReviews (PRID,ItemID,Review,Rating,DateCreated) VALUES('23','2','In focus every time!','5','2005-12-3 10:31:0')
INSERT INTO dbo.ProductReviews (PRID,ItemID,Review,Rating,DateCreated) VALUES('24','2','Just bought one at Costco.  It''s absolutely brilliant.','5','2005-12-3 10:33:0')
INSERT INTO dbo.ProductReviews (PRID,ItemID,Review,Rating,DateCreated) VALUES('25','29','Very good!!!','5','2006-8-3 15:58:0')
IF (IDENT_SEED('dbo.ProductReviews') IS NOT NULL )	SET IDENTITY_INSERT dbo.ProductReviews OFF
GO
GO
ALTER TABLE dbo.ProductReviews CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.Products
-----------------------------------------------------------
ALTER TABLE dbo.Products NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.Products
GO

IF (IDENT_SEED('dbo.Products') IS NOT NULL )	SET IDENTITY_INSERT dbo.Products ON
INSERT INTO dbo.Products (ItemID,SiteID,SKU,ManufacturerID,ItemName,ItemDescription,ItemDetails,ShortDescription,Comments,Category,OtherCategories,SectionID,OtherSections,CompareType,ImageDir,Image,ImageSmall,ImageLarge,ImageAlt,ImageAltLarge,Attribute1,Attribute2,Attribute3,OptionName1,OptionName2,OptionName3,OptionName4,OptionName5,OptionName6,OptionName7,OptionName8,OptionName9,OptionName10,Option1Optional,Option2Optional,Option3Optional,Option4Optional,Option5Optional,Option6Optional,Option7Optional,Option8Optional,Option9Optional,Option10Optional,Weight,DimLength,DimWidth,DimHeighth,CostPrice,ListPrice,SalePrice,Price1,Price2,Hide1,Hide2,Taxable,StockQuantity,SellByStock,ItemStatus,DisplayOrder,Featured,SoftwareDownload,SoftwareAttachment,DaysAvailable,DownloadLocation,DistributorID,ItemClassID,UseMatrix,RProSID,rdi_date_removed,fldShipByWeight,fldShipWeight,fldShipAmount,fldHandAmount,fldOversize,fldShipCode,Deleted,DateCreated,DateUpdated,UpdatedBy,Volume,QB,QB_ACCNT,QB_ASSETACCNT,QB_COGSACCNT,QB_SALESTAXCODE,QB_PREFVEND,QB_SUBITEM,QB_REORDERPOINT,QB_PAYMETH,QB_TAXVEND) VALUES('1','1','CAPSA95',NULL,'Canon PowerShot A95',NULL,NULL,'5.0 megapixels (effective), 3x optical zoom/3.6x digital zoom, auto and manual focus, program and manual exposure, JPEG file format only, ISO range 50-400, 4 AA batteries, movie mode with sound.',NULL,'22','X,14,27,X','3','X,,X','0','products','Canon-PowerShot-A95.gif','Canon-PowerShot-A95-sm.gif','Canon-PowerShot-A95-lg.jpg',NULL,NULL,'5.0 Megapixel, 3x Optical/4.1x Digital Zoom','Digital Camera',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,0,0,0,0,1,10,10,4,229,309.95,0,269.95,269.95,0,0,1,'74',1,'IS','4',NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,1,1,0,0,0,NULL,0,'2005-3-24 14:59:0','2005-5-5 21:26:0','ADMIN',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Products (ItemID,SiteID,SKU,ManufacturerID,ItemName,ItemDescription,ItemDetails,ShortDescription,Comments,Category,OtherCategories,SectionID,OtherSections,CompareType,ImageDir,Image,ImageSmall,ImageLarge,ImageAlt,ImageAltLarge,Attribute1,Attribute2,Attribute3,OptionName1,OptionName2,OptionName3,OptionName4,OptionName5,OptionName6,OptionName7,OptionName8,OptionName9,OptionName10,Option1Optional,Option2Optional,Option3Optional,Option4Optional,Option5Optional,Option6Optional,Option7Optional,Option8Optional,Option9Optional,Option10Optional,Weight,DimLength,DimWidth,DimHeighth,CostPrice,ListPrice,SalePrice,Price1,Price2,Hide1,Hide2,Taxable,StockQuantity,SellByStock,ItemStatus,DisplayOrder,Featured,SoftwareDownload,SoftwareAttachment,DaysAvailable,DownloadLocation,DistributorID,ItemClassID,UseMatrix,RProSID,rdi_date_removed,fldShipByWeight,fldShipWeight,fldShipAmount,fldHandAmount,fldOversize,fldShipCode,Deleted,DateCreated,DateUpdated,UpdatedBy,Volume,QB,QB_ACCNT,QB_ASSETACCNT,QB_COGSACCNT,QB_SALESTAXCODE,QB_PREFVEND,QB_SUBITEM,QB_REORDERPOINT,QB_PAYMETH,QB_TAXVEND) VALUES('2','1','CAEDR',NULL,'Canon EOS Digital Rebel 300D',NULL,'<font size="2">6.3 megapixels (effective), auto and manual focus, program and manual exposure, JPEG and RAW file format, ISO range 100 - 1600, proprietary Lithium-Ion battery. Accepts interchangeable Canon EF lenses -- lens not included.</font>','6.3 megapixels (effective), auto and manual focus, program and manual exposure, JPEG and RAW file format, ISO range 100 - 1600, proprietary Lithium-Ion battery. Accepts interchangeable Canon EF lenses -- lens not included.',NULL,'29','X,18,28,X','7','X,,X','0','products','canon-rebel-300d.gif','canon-rebel-300d-sm.gif','canon-rebel-300d-lg.jpg',NULL,NULL,'6.3 Megapixel, SLR, Digital Camera (Camera Body)',NULL,NULL,'Color','Lenses','Bags',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,1,0,0,0,0,0,0,0,2,10,10,4,549,799.95,0,699.95,699.95,0,0,1,'80',1,'IS','2',NULL,NULL,NULL,NULL,NULL,'1',NULL,0,NULL,NULL,1,2,0,0,0,NULL,0,'2005-5-1 20:38:0','2005-12-3 18:36:0','MARTY',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Products (ItemID,SiteID,SKU,ManufacturerID,ItemName,ItemDescription,ItemDetails,ShortDescription,Comments,Category,OtherCategories,SectionID,OtherSections,CompareType,ImageDir,Image,ImageSmall,ImageLarge,ImageAlt,ImageAltLarge,Attribute1,Attribute2,Attribute3,OptionName1,OptionName2,OptionName3,OptionName4,OptionName5,OptionName6,OptionName7,OptionName8,OptionName9,OptionName10,Option1Optional,Option2Optional,Option3Optional,Option4Optional,Option5Optional,Option6Optional,Option7Optional,Option8Optional,Option9Optional,Option10Optional,Weight,DimLength,DimWidth,DimHeighth,CostPrice,ListPrice,SalePrice,Price1,Price2,Hide1,Hide2,Taxable,StockQuantity,SellByStock,ItemStatus,DisplayOrder,Featured,SoftwareDownload,SoftwareAttachment,DaysAvailable,DownloadLocation,DistributorID,ItemClassID,UseMatrix,RProSID,rdi_date_removed,fldShipByWeight,fldShipWeight,fldShipAmount,fldHandAmount,fldOversize,fldShipCode,Deleted,DateCreated,DateUpdated,UpdatedBy,Volume,QB,QB_ACCNT,QB_ASSETACCNT,QB_COGSACCNT,QB_SALESTAXCODE,QB_PREFVEND,QB_SUBITEM,QB_REORDERPOINT,QB_PAYMETH,QB_TAXVEND) VALUES('3','1','CAEDRXTS','0206B001','Canon EOS Digital Rebel XT (350D)',NULL,'<FONT size=2>8.0 megapixels (effective), auto and manual focus, program and manual exposure, JPEG and RAW file format, ISO range 100 - 1600, proprietary Lithium-Ion battery. Accepts interchangeable Canon EF lenses -- lens not included.</FONT>','8.0 megapixels (effective), auto and manual focus, program and manual exposure, JPEG and RAW file format, ISO range 100 - 1600, proprietary Lithium-Ion battery. Accepts interchangeable Canon EF lenses -- lens not included.',NULL,'30','X,19,28,X','7','X,,X','0','products','canon-rebel-350d.gif','canon-rebel-350d-sm.gif','canon-rebel-350d-lg.jpg',NULL,NULL,'8.0 Megapixel, SLR','Digital Camera (Silver)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,0,0,0,0,1,10,10,4,750,999.95,0,849.95,849.95,0,0,1,'64',1,'IS','3',1,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,1,1,0,0,0,NULL,0,'2005-5-1 20:39:0','2005-5-6 20:35:0','ADMIN',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Products (ItemID,SiteID,SKU,ManufacturerID,ItemName,ItemDescription,ItemDetails,ShortDescription,Comments,Category,OtherCategories,SectionID,OtherSections,CompareType,ImageDir,Image,ImageSmall,ImageLarge,ImageAlt,ImageAltLarge,Attribute1,Attribute2,Attribute3,OptionName1,OptionName2,OptionName3,OptionName4,OptionName5,OptionName6,OptionName7,OptionName8,OptionName9,OptionName10,Option1Optional,Option2Optional,Option3Optional,Option4Optional,Option5Optional,Option6Optional,Option7Optional,Option8Optional,Option9Optional,Option10Optional,Weight,DimLength,DimWidth,DimHeighth,CostPrice,ListPrice,SalePrice,Price1,Price2,Hide1,Hide2,Taxable,StockQuantity,SellByStock,ItemStatus,DisplayOrder,Featured,SoftwareDownload,SoftwareAttachment,DaysAvailable,DownloadLocation,DistributorID,ItemClassID,UseMatrix,RProSID,rdi_date_removed,fldShipByWeight,fldShipWeight,fldShipAmount,fldHandAmount,fldOversize,fldShipCode,Deleted,DateCreated,DateUpdated,UpdatedBy,Volume,QB,QB_ACCNT,QB_ASSETACCNT,QB_COGSACCNT,QB_SALESTAXCODE,QB_PREFVEND,QB_SUBITEM,QB_REORDERPOINT,QB_PAYMETH,QB_TAXVEND) VALUES('4','1','PENOPWP',NULL,'Pentax Optio WP','<FONT size=2>There''s no need to leave the Pentax Optio WP at home when the weather gets bad: This 5-megapixel point &amp; shoot can withstand rain, snow, and even a half-hour swim! Sporting a thin metal body and a large 2" LCD screen, the Pentax WP looks just as good above the water as it does below. Perfect for active photographers who never know what the next day will bring, the WP will withstand whatever conditions you throw at it and still turn out great pictures.</FONT>','<DIV class=mediumtxt><FONT size=2>5.0 megapixels (effective), 3x optical zoom/4x digital zoom, auto and manual focus, program exposure only, JPEG file format, ISO range 50-400, proprietary Lithium-Ion battery, movie mode with sound. Waterproof to 3 feet for up to 30 minutes.</FONT></DIV>','5.0 megapixels (effective), 3x optical zoom/4x digital zoom, auto and manual focus, program exposure only, JPEG file format, ISO range 50-400, proprietary Lithium-Ion battery, movie mode with sound. Waterproof to 3 feet for up to 30 minutes.',NULL,'10','X,15,27,X','6','X,,X','0','products','pentax-optio-wp.gif','pentax-optio-wp-sm.gif','pentax-optio-wp-lg.jpg',NULL,NULL,'Digital Camera',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,0,0,0,0,1,10,10,4,250,399.99,0,349.99,349.99,0,0,1,'4',0,'BO','28',0,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,1,1,0,0,0,NULL,0,'2005-5-1 21:8:0','2005-5-2 18:43:0','ADMIN',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Products (ItemID,SiteID,SKU,ManufacturerID,ItemName,ItemDescription,ItemDetails,ShortDescription,Comments,Category,OtherCategories,SectionID,OtherSections,CompareType,ImageDir,Image,ImageSmall,ImageLarge,ImageAlt,ImageAltLarge,Attribute1,Attribute2,Attribute3,OptionName1,OptionName2,OptionName3,OptionName4,OptionName5,OptionName6,OptionName7,OptionName8,OptionName9,OptionName10,Option1Optional,Option2Optional,Option3Optional,Option4Optional,Option5Optional,Option6Optional,Option7Optional,Option8Optional,Option9Optional,Option10Optional,Weight,DimLength,DimWidth,DimHeighth,CostPrice,ListPrice,SalePrice,Price1,Price2,Hide1,Hide2,Taxable,StockQuantity,SellByStock,ItemStatus,DisplayOrder,Featured,SoftwareDownload,SoftwareAttachment,DaysAvailable,DownloadLocation,DistributorID,ItemClassID,UseMatrix,RProSID,rdi_date_removed,fldShipByWeight,fldShipWeight,fldShipAmount,fldHandAmount,fldOversize,fldShipCode,Deleted,DateCreated,DateUpdated,UpdatedBy,Volume,QB,QB_ACCNT,QB_ASSETACCNT,QB_COGSACCNT,QB_SALESTAXCODE,QB_PREFVEND,QB_SUBITEM,QB_REORDERPOINT,QB_PAYMETH,QB_TAXVEND) VALUES('5','1','CAPSSD500','9885A001','Canon PowerShot SD500','<font size="2">The Canon PowerShot SD500 brings 7-megapixel resolution to Canon''s wildly popular ELPH series of ultra compact digital cameras. Small enough to fit in a pocket, yet sporting enough resolution to create poster size prints with ease, the Canon SD500 packs a great deal of photographic punch into a tiny body. Whether or not the average photographer needs this punch is another matter -- if you''re not going to be printing images larger than 8x10, or you don''t anticipate cropping your pictures extensively on a computer, then you''re better off saving money and getting a lower-resolution ELPH. If poster-size prints are your thing, however, the SD500 will deliver the resolution you need.</font>','<div class="mediumtxt"><font size="2">7.1 megapixels (effective), 3x optical zoom/4x digital zoom, autofocus only, program exposure, JPEG file format, ISO range 50-400, proprietary Lithium-Ion battery, movie mode with sound.</font></div>','7.1 megapixels (effective), 3x optical zoom/4x digital zoom, autofocus only, program exposure, JPEG file format, ISO range 50-400, proprietary Lithium-Ion battery, movie mode with sound.',NULL,'20','X,16,28,X','3','X,,X','0','products','canon-powershot-sd500.gif','canon-powershot-sd500-sm.gif','canon-powershot-sd500-lg.jpg',NULL,NULL,'7.1 Megapixel, 3x Optical/4x Digital Zoom, Digital Camera',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,0,0,0,0,2,10,10,4,400,499.99,0,449.99,449.99,0,0,1,'-8',0,'IS','5',NULL,NULL,NULL,NULL,NULL,'1','5',0,NULL,NULL,1,2,0,0,0,NULL,0,'2005-5-1 21:14:0','2005-12-4 22:12:0','MARTY',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Products (ItemID,SiteID,SKU,ManufacturerID,ItemName,ItemDescription,ItemDetails,ShortDescription,Comments,Category,OtherCategories,SectionID,OtherSections,CompareType,ImageDir,Image,ImageSmall,ImageLarge,ImageAlt,ImageAltLarge,Attribute1,Attribute2,Attribute3,OptionName1,OptionName2,OptionName3,OptionName4,OptionName5,OptionName6,OptionName7,OptionName8,OptionName9,OptionName10,Option1Optional,Option2Optional,Option3Optional,Option4Optional,Option5Optional,Option6Optional,Option7Optional,Option8Optional,Option9Optional,Option10Optional,Weight,DimLength,DimWidth,DimHeighth,CostPrice,ListPrice,SalePrice,Price1,Price2,Hide1,Hide2,Taxable,StockQuantity,SellByStock,ItemStatus,DisplayOrder,Featured,SoftwareDownload,SoftwareAttachment,DaysAvailable,DownloadLocation,DistributorID,ItemClassID,UseMatrix,RProSID,rdi_date_removed,fldShipByWeight,fldShipWeight,fldShipAmount,fldHandAmount,fldOversize,fldShipCode,Deleted,DateCreated,DateUpdated,UpdatedBy,Volume,QB,QB_ACCNT,QB_ASSETACCNT,QB_COGSACCNT,QB_SALESTAXCODE,QB_PREFVEND,QB_SUBITEM,QB_REORDERPOINT,QB_PAYMETH,QB_TAXVEND) VALUES('6','1','SODSCP150B','DSCP150B','Sony Cybershot DSC-P150','<FONT size=2>The groundbreaking Sony CyberShot DSC-P150 is the world''s smallest 7.2 megapixel digital camera. Set for release in September of 2004, the Sony DSC-P150 looks similar to previous CyberShot models, but offers substantially higher resolution. For photographers who wish to create large prints, the DSC-P150 could be the ideal fusion of power and size.</FONT>','<FONT size=2>7.2 megapixels (effective), 3x optical zoom, autofocus only, program and manual exposure, JPEG file formats, proprietary Lithium-Ion battery.</FONT>','7.2 megapixels (effective), 3x optical zoom, autofocus only, program and manual exposure, JPEG file formats, proprietary Lithium-Ion battery.',NULL,'11','X,15,28,X','2','X,,X','0','products','sony-cybershot-dscp150.gif','sony-cybershot-dscp150-sm.gif','sony-cybershot-dscp150-lg.jpg',NULL,NULL,'7.2 Megapixel, 3x Optical/2x Digital Zoom, Digital Camera (Black)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,0,0,0,0,1,10,10,4,289.95,369.95,0,329.95,329.95,0,0,1,'5',0,'IS','29',NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,1,1,0,0,0,NULL,0,'2005-5-1 21:17:0','2005-5-1 21:17:0','ADMIN',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Products (ItemID,SiteID,SKU,ManufacturerID,ItemName,ItemDescription,ItemDetails,ShortDescription,Comments,Category,OtherCategories,SectionID,OtherSections,CompareType,ImageDir,Image,ImageSmall,ImageLarge,ImageAlt,ImageAltLarge,Attribute1,Attribute2,Attribute3,OptionName1,OptionName2,OptionName3,OptionName4,OptionName5,OptionName6,OptionName7,OptionName8,OptionName9,OptionName10,Option1Optional,Option2Optional,Option3Optional,Option4Optional,Option5Optional,Option6Optional,Option7Optional,Option8Optional,Option9Optional,Option10Optional,Weight,DimLength,DimWidth,DimHeighth,CostPrice,ListPrice,SalePrice,Price1,Price2,Hide1,Hide2,Taxable,StockQuantity,SellByStock,ItemStatus,DisplayOrder,Featured,SoftwareDownload,SoftwareAttachment,DaysAvailable,DownloadLocation,DistributorID,ItemClassID,UseMatrix,RProSID,rdi_date_removed,fldShipByWeight,fldShipWeight,fldShipAmount,fldHandAmount,fldOversize,fldShipCode,Deleted,DateCreated,DateUpdated,UpdatedBy,Volume,QB,QB_ACCNT,QB_ASSETACCNT,QB_COGSACCNT,QB_SALESTAXCODE,QB_PREFVEND,QB_SUBITEM,QB_REORDERPOINT,QB_PAYMETH,QB_TAXVEND) VALUES('7','1','NIKD70','25212','Nikon D70','<div class="mediumtxt"><font size="2">The Nikon D70 is Nikon''s answer to the immensely popular Canon 300D -- when it was released in March 2004, the D70 became the second digital SLR to cost less than $1000.</font></div>','<div class="mediumtxt"><font size="2">6.1 megapixels (effective), auto and manual focus, program and manual exposure, JPEG and RAW file formats, ISO range 200-1600, proprietary Lithium-Ion battery. Accepts interchangeable Nikkor lenses -- lens not included.</font></div>','6.1 megapixels (effective), auto and manual focus, program and manual exposure, JPEG and RAW file formats, ISO range 200-1600, proprietary Lithium-Ion battery. Accepts interchangeable Nikkor lenses -- lens not included.',NULL,'8','X,28,19,X','7','X,,X','0','products','nikon-d70.gif','nikon-d70-sm.gif','nikon-d70-lg.jpg',NULL,NULL,'6.1 Megapixel, SLR, Digital Camera (Camera Body)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,0,0,0,0,2,10,10,4,699.95,999.95,0,899.95,899.95,0,0,1,'19',NULL,'IS','23',NULL,NULL,NULL,NULL,NULL,'1',NULL,0,NULL,NULL,1,2,0,0,0,NULL,0,'2005-5-1 21:29:0','2007-3-29 9:31:0','ADMIN',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Products (ItemID,SiteID,SKU,ManufacturerID,ItemName,ItemDescription,ItemDetails,ShortDescription,Comments,Category,OtherCategories,SectionID,OtherSections,CompareType,ImageDir,Image,ImageSmall,ImageLarge,ImageAlt,ImageAltLarge,Attribute1,Attribute2,Attribute3,OptionName1,OptionName2,OptionName3,OptionName4,OptionName5,OptionName6,OptionName7,OptionName8,OptionName9,OptionName10,Option1Optional,Option2Optional,Option3Optional,Option4Optional,Option5Optional,Option6Optional,Option7Optional,Option8Optional,Option9Optional,Option10Optional,Weight,DimLength,DimWidth,DimHeighth,CostPrice,ListPrice,SalePrice,Price1,Price2,Hide1,Hide2,Taxable,StockQuantity,SellByStock,ItemStatus,DisplayOrder,Featured,SoftwareDownload,SoftwareAttachment,DaysAvailable,DownloadLocation,DistributorID,ItemClassID,UseMatrix,RProSID,rdi_date_removed,fldShipByWeight,fldShipWeight,fldShipAmount,fldHandAmount,fldOversize,fldShipCode,Deleted,DateCreated,DateUpdated,UpdatedBy,Volume,QB,QB_ACCNT,QB_ASSETACCNT,QB_COGSACCNT,QB_SALESTAXCODE,QB_PREFVEND,QB_SUBITEM,QB_REORDERPOINT,QB_PAYMETH,QB_TAXVEND) VALUES('8','1','CASEXZ4U','EXZ4U','Casio Exilim EX-Z4U','<FONT size=2>Though the Casio Exilim EX-Z4U is barely bigger than a credit card (its 0.9-inch width excluded), it offers a 3x optical zoom, 2" LCD screen, and 4-megapixel resolution. Casio''s Exilim line of cameras is well-known for its tiny dimensions, and the Z4U is no exception -- measuring just 3.43" (W) x 2.24" (H) x .93" (D), this camera can slide into a pocket almost unnoticed. While the Z4U''s size is undoubtedly its greatest selling point, its impressive images and the included camera docking station both help make this tiny Casio an appealing choice for casual snapshooters.</FONT>','<FONT size=2>4.0 megapixels (effective), 3x optical zoom/4x digital zoom, auto and manual focus, program exposure only, JPEG file format, ISO range 50-400, proprietary Lithium-Ion battery, no movie mode. Includes docking cradle.</FONT>','4.0 megapixels (effective), 3x optical zoom/4x digital zoom, auto and manual focus, program exposure only, JPEG file format, ISO range 50-400, proprietary Lithium-Ion battery, no movie mode. Includes docking cradle.',NULL,'3','X,14,26,X','2','X,,X','0','products','casio-exilim-exz4u.gif','casio-exilim-exz4u-sm.gif','CASEXZ4U-lg.jpg',NULL,NULL,'4.0 MEGAPIXEL 3X OPTICAL/4X DIGITAL ZOOM DIGITAL CAMERA',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,0,0,0,0,1,10,10,4,149,399.99,0,239.99,239.99,0,0,1,'-6',0,'IS','6',NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,1,1,0,0,0,NULL,0,'2005-5-1 21:34:0','2005-5-1 21:34:0','ADMIN',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Products (ItemID,SiteID,SKU,ManufacturerID,ItemName,ItemDescription,ItemDetails,ShortDescription,Comments,Category,OtherCategories,SectionID,OtherSections,CompareType,ImageDir,Image,ImageSmall,ImageLarge,ImageAlt,ImageAltLarge,Attribute1,Attribute2,Attribute3,OptionName1,OptionName2,OptionName3,OptionName4,OptionName5,OptionName6,OptionName7,OptionName8,OptionName9,OptionName10,Option1Optional,Option2Optional,Option3Optional,Option4Optional,Option5Optional,Option6Optional,Option7Optional,Option8Optional,Option9Optional,Option10Optional,Weight,DimLength,DimWidth,DimHeighth,CostPrice,ListPrice,SalePrice,Price1,Price2,Hide1,Hide2,Taxable,StockQuantity,SellByStock,ItemStatus,DisplayOrder,Featured,SoftwareDownload,SoftwareAttachment,DaysAvailable,DownloadLocation,DistributorID,ItemClassID,UseMatrix,RProSID,rdi_date_removed,fldShipByWeight,fldShipWeight,fldShipAmount,fldHandAmount,fldOversize,fldShipCode,Deleted,DateCreated,DateUpdated,UpdatedBy,Volume,QB,QB_ACCNT,QB_ASSETACCNT,QB_COGSACCNT,QB_SALESTAXCODE,QB_PREFVEND,QB_SUBITEM,QB_REORDERPOINT,QB_PAYMETH,QB_TAXVEND) VALUES('9','1','FUJFPS7000','43860800','Fuji FinePix S-7000',NULL,'<DIV class=mediumtxt><FONT size=2>6.3 megapixels (effective), 6x optical zoom/variable digital zoom, auto and manual focus, program and manual exposure, JPEG and RAW file format, ISO 160 - 800, 4 AA batteries, movie mode with sound.</FONT></DIV>','6.3 megapixels (effective), 6x optical zoom/variable digital zoom, auto and manual focus, program and manual exposure, JPEG and RAW file format, ISO 160 - 800, 4 AA batteries, movie mode with sound.',NULL,'31','X,17,28,X','5','X,,X','0','products','fuji-finepix-s7000.gif','fuji-finepix-s7000-sm.gif','fuji-finepix-s7000-lg.jpg',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,0,0,0,0,2,10,10,4,400,599.95,0,529.99,529.99,0,0,1,'73',0,'IS','14',NULL,NULL,NULL,NULL,NULL,'2',NULL,NULL,NULL,NULL,1,2,0,0,0,NULL,0,'2005-5-1 21:39:0','2005-5-3 11:57:0','ADMIN',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Products (ItemID,SiteID,SKU,ManufacturerID,ItemName,ItemDescription,ItemDetails,ShortDescription,Comments,Category,OtherCategories,SectionID,OtherSections,CompareType,ImageDir,Image,ImageSmall,ImageLarge,ImageAlt,ImageAltLarge,Attribute1,Attribute2,Attribute3,OptionName1,OptionName2,OptionName3,OptionName4,OptionName5,OptionName6,OptionName7,OptionName8,OptionName9,OptionName10,Option1Optional,Option2Optional,Option3Optional,Option4Optional,Option5Optional,Option6Optional,Option7Optional,Option8Optional,Option9Optional,Option10Optional,Weight,DimLength,DimWidth,DimHeighth,CostPrice,ListPrice,SalePrice,Price1,Price2,Hide1,Hide2,Taxable,StockQuantity,SellByStock,ItemStatus,DisplayOrder,Featured,SoftwareDownload,SoftwareAttachment,DaysAvailable,DownloadLocation,DistributorID,ItemClassID,UseMatrix,RProSID,rdi_date_removed,fldShipByWeight,fldShipWeight,fldShipAmount,fldHandAmount,fldOversize,fldShipCode,Deleted,DateCreated,DateUpdated,UpdatedBy,Volume,QB,QB_ACCNT,QB_ASSETACCNT,QB_COGSACCNT,QB_SALESTAXCODE,QB_PREFVEND,QB_SUBITEM,QB_REORDERPOINT,QB_PAYMETH,QB_TAXVEND) VALUES('10','1','SODSCP200','S08-3164','Sony CyberShot DSC-P200','<font size="2">The Sony DSC-P200 packs 7 megapixels of resolution into an ultra compact body that slips easily into a pocket. Those looking for differences from the Sony P150 will immediately notice the large 2&quot; LCD screen on the back, which makes framing and reviewing pictures easier than before. Sony also claims that the CyberShot P200 has better battery life than its predecessor, noting that it can shoot up to 370 images on a single charge of its InfoLithium battery.</font>','<div class="mediumtxt"><font size="2">7.1 megapixels (effective), 3x optical zoom, 2x digital zoom, autofocus only, program and manual exposure, JPEG file formats, proprietary Lithium-Ion battery.</font></div>','7.1 megapixels (effective), 3x optical zoom, 2x digital zoom, autofocus only, program and manual exposure, JPEG file formats, proprietary Lithium-Ion battery.',NULL,'11','X,15,28,X','2','X,,X','0','products','sony-cybershot-dscp200.gif','sony-cybershot-dscp200-sm.gif','sony-cybershot-dscp200-lg.jpg',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,0,0,0,0,1,10,10,4,300,399,0,349.99,349.99,0,0,1,'-2',0,'IS','30',1,NULL,NULL,NULL,NULL,'1',NULL,0,NULL,NULL,1,1,0,0,0,NULL,0,'2005-5-2 17:57:0','2006-3-15 12:15:0','ADMIN',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Products (ItemID,SiteID,SKU,ManufacturerID,ItemName,ItemDescription,ItemDetails,ShortDescription,Comments,Category,OtherCategories,SectionID,OtherSections,CompareType,ImageDir,Image,ImageSmall,ImageLarge,ImageAlt,ImageAltLarge,Attribute1,Attribute2,Attribute3,OptionName1,OptionName2,OptionName3,OptionName4,OptionName5,OptionName6,OptionName7,OptionName8,OptionName9,OptionName10,Option1Optional,Option2Optional,Option3Optional,Option4Optional,Option5Optional,Option6Optional,Option7Optional,Option8Optional,Option9Optional,Option10Optional,Weight,DimLength,DimWidth,DimHeighth,CostPrice,ListPrice,SalePrice,Price1,Price2,Hide1,Hide2,Taxable,StockQuantity,SellByStock,ItemStatus,DisplayOrder,Featured,SoftwareDownload,SoftwareAttachment,DaysAvailable,DownloadLocation,DistributorID,ItemClassID,UseMatrix,RProSID,rdi_date_removed,fldShipByWeight,fldShipWeight,fldShipAmount,fldHandAmount,fldOversize,fldShipCode,Deleted,DateCreated,DateUpdated,UpdatedBy,Volume,QB,QB_ACCNT,QB_ASSETACCNT,QB_COGSACCNT,QB_SALESTAXCODE,QB_PREFVEND,QB_SUBITEM,QB_REORDERPOINT,QB_PAYMETH,QB_TAXVEND) VALUES('11','1','SODSCW7','S08-3158','Sony Cybershot DSC-W7','<DIV class=mediumtxt><FONT size=2>Rumors are swirling of a Sony CyberShot DSC-W7, which would offer 7-megapixel resolution and a 3x optical zoom. Though there has been no word from Sony, photography message boards are buzzing, and at least one Canadian website is already featuring the camera.</FONT></DIV>','<DIV class=mediumtxt><FONT size=2>7.2 Megapixels, 3x Optical Zoom, other specs not yet released.</FONT></DIV>','7.2 Megapixels, 3x Optical Zoom, other specs not yet released.',NULL,'11','X,16,28,X','3','X,,X','1','products','sony-cybershot-dscw7.gif','sony-cybershot-dscw7-sm.gif','sony-cybershot-dscw7-lg.jpg',NULL,NULL,'7.2 Megapixel, 3x Optical Zoom','2x Digital Zoom, Digital Camera',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,0,0,0,0,2,10,10,4,320,450,0,419.99,419.99,0,0,1,'15',0,'IS','31',NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,1,2,0,0,0,NULL,0,'2005-5-2 18:6:0','2005-5-2 21:27:0','ADMIN',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Products (ItemID,SiteID,SKU,ManufacturerID,ItemName,ItemDescription,ItemDetails,ShortDescription,Comments,Category,OtherCategories,SectionID,OtherSections,CompareType,ImageDir,Image,ImageSmall,ImageLarge,ImageAlt,ImageAltLarge,Attribute1,Attribute2,Attribute3,OptionName1,OptionName2,OptionName3,OptionName4,OptionName5,OptionName6,OptionName7,OptionName8,OptionName9,OptionName10,Option1Optional,Option2Optional,Option3Optional,Option4Optional,Option5Optional,Option6Optional,Option7Optional,Option8Optional,Option9Optional,Option10Optional,Weight,DimLength,DimWidth,DimHeighth,CostPrice,ListPrice,SalePrice,Price1,Price2,Hide1,Hide2,Taxable,StockQuantity,SellByStock,ItemStatus,DisplayOrder,Featured,SoftwareDownload,SoftwareAttachment,DaysAvailable,DownloadLocation,DistributorID,ItemClassID,UseMatrix,RProSID,rdi_date_removed,fldShipByWeight,fldShipWeight,fldShipAmount,fldHandAmount,fldOversize,fldShipCode,Deleted,DateCreated,DateUpdated,UpdatedBy,Volume,QB,QB_ACCNT,QB_ASSETACCNT,QB_COGSACCNT,QB_SALESTAXCODE,QB_PREFVEND,QB_SUBITEM,QB_REORDERPOINT,QB_PAYMETH,QB_TAXVEND) VALUES('12','1','OLM-S410','225465','Olympus Stylus 410','<DIV class=mediumtxt><FONT size=2>The sleek Olympus Stylus 410 is the latest addition to Olympus'' popular line of rugged, weather-resistant digital cameras.</FONT></DIV>','<DIV class=mediumtxt><FONT size=2>4.0 megapixels (effective), 3x optical/4x digital zoom, autofocus only, program exposure only, JPEG file format, ISO range 64-480, proprietary Lithium-Ion battery, movie mode with sound.</FONT></DIV>','4.0 megapixels (effective), 3x optical/4x digital zoom, autofocus only, program exposure only, JPEG file format, ISO range 64-480, proprietary Lithium-Ion battery, movie mode with sound.',NULL,'9','X,13,26,X','6','X,,X','0','products','olympus-stylus-410.gif','olympus-stylus-410-sm.gif','olympus-stylus-410-lg.jpg',NULL,NULL,'4.0 Megapixel, 3x Optical/4x Digital Zoom','Point-and-shoot, Digital Camera',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,0,0,0,0,1,10,10,4,189,309.95,0,199.95,199.95,0,0,1,'45',0,'IS','27',1,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,1,1,0,0,0,NULL,0,'2005-5-2 18:12:0','2005-5-2 18:12:0','ADMIN',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Products (ItemID,SiteID,SKU,ManufacturerID,ItemName,ItemDescription,ItemDetails,ShortDescription,Comments,Category,OtherCategories,SectionID,OtherSections,CompareType,ImageDir,Image,ImageSmall,ImageLarge,ImageAlt,ImageAltLarge,Attribute1,Attribute2,Attribute3,OptionName1,OptionName2,OptionName3,OptionName4,OptionName5,OptionName6,OptionName7,OptionName8,OptionName9,OptionName10,Option1Optional,Option2Optional,Option3Optional,Option4Optional,Option5Optional,Option6Optional,Option7Optional,Option8Optional,Option9Optional,Option10Optional,Weight,DimLength,DimWidth,DimHeighth,CostPrice,ListPrice,SalePrice,Price1,Price2,Hide1,Hide2,Taxable,StockQuantity,SellByStock,ItemStatus,DisplayOrder,Featured,SoftwareDownload,SoftwareAttachment,DaysAvailable,DownloadLocation,DistributorID,ItemClassID,UseMatrix,RProSID,rdi_date_removed,fldShipByWeight,fldShipWeight,fldShipAmount,fldHandAmount,fldOversize,fldShipCode,Deleted,DateCreated,DateUpdated,UpdatedBy,Volume,QB,QB_ACCNT,QB_ASSETACCNT,QB_COGSACCNT,QB_SALESTAXCODE,QB_PREFVEND,QB_SUBITEM,QB_REORDERPOINT,QB_PAYMETH,QB_TAXVEND) VALUES('13','1','KODZ740','8582553','Kodak EasyShare Z740','<SPAN class=desc><FONT size=2>The Kodak EasyShare Z740 Digital Camera lets you get close to your subjects with a 10X Retinar optical zoom lens, and even closer with its 5X advanced digital zoom (50X total zoom). Furthermore, Using dual-sensing auto-focus system technologies, the Z740 digital camera will capture consistently crisp, precise pictures - even in low light with the auto-focus assist lamp. With it''s 5.0 Megapixel Resolution, you''ll be able to create unbelievable-quality prints and you''ll get rich, vibrant color under a variety of lighting conditions with the exclusive KODAK Color Science Image Processing Chip.</FONT></SPAN>',NULL,'5.0 megapixels (effective), 10x optical zoom/5x digital zoom, autofocus only, program and manual exposure, JPEG file format, ISO range 80-400, 2 AA batteries, movie mode with sound.',NULL,'6','X,15,27,X','4','X,,X','0','products','kodak-easyshare-z740.gif','kodak-easyshare-z740-sm.gif','kodak-easyshare-z740-lg.jpg',NULL,NULL,'5.0 Megapixel','10x Optical/5x Digital Zoom, Digital Camera',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,0,0,0,0,2,10,10,4,320,449.95,0,399.99,399.99,0,0,1,'21',0,'IS','19',NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,1,2,0,0,0,NULL,0,'2005-5-2 18:17:0','2005-5-5 22:20:0','ADMIN',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Products (ItemID,SiteID,SKU,ManufacturerID,ItemName,ItemDescription,ItemDetails,ShortDescription,Comments,Category,OtherCategories,SectionID,OtherSections,CompareType,ImageDir,Image,ImageSmall,ImageLarge,ImageAlt,ImageAltLarge,Attribute1,Attribute2,Attribute3,OptionName1,OptionName2,OptionName3,OptionName4,OptionName5,OptionName6,OptionName7,OptionName8,OptionName9,OptionName10,Option1Optional,Option2Optional,Option3Optional,Option4Optional,Option5Optional,Option6Optional,Option7Optional,Option8Optional,Option9Optional,Option10Optional,Weight,DimLength,DimWidth,DimHeighth,CostPrice,ListPrice,SalePrice,Price1,Price2,Hide1,Hide2,Taxable,StockQuantity,SellByStock,ItemStatus,DisplayOrder,Featured,SoftwareDownload,SoftwareAttachment,DaysAvailable,DownloadLocation,DistributorID,ItemClassID,UseMatrix,RProSID,rdi_date_removed,fldShipByWeight,fldShipWeight,fldShipAmount,fldHandAmount,fldOversize,fldShipCode,Deleted,DateCreated,DateUpdated,UpdatedBy,Volume,QB,QB_ACCNT,QB_ASSETACCNT,QB_COGSACCNT,QB_SALESTAXCODE,QB_PREFVEND,QB_SUBITEM,QB_REORDERPOINT,QB_PAYMETH,QB_TAXVEND) VALUES('14','1','OLM-C765UZ','OLM225485','Olympus C-765',NULL,NULL,'4.0 megapixels (effective), 10x optical zoom/4x digital zoom, auto and manual focus, program and manual exposure, JPEG and TIFF file format, ISO range 64 - 400, proprietary Lithium-Ion battery, movie mode with sound.',NULL,'9','X,14,26,X','5','X,,X','0','products','olympus-c765uz.gif','olympus-c765uz-sm.gif','olympus-c765uz-lg.jpg',NULL,NULL,'Ultra Zoom, 4-Megapixel, Digital Camera',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,0,0,0,0,1,10,10,4,242,349.99,0,299.99,299.99,0,0,1,'175',1,'IS','24',1,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,1,1,0,0,0,NULL,0,'2005-5-2 18:23:0','2005-5-2 18:23:0','ADMIN',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Products (ItemID,SiteID,SKU,ManufacturerID,ItemName,ItemDescription,ItemDetails,ShortDescription,Comments,Category,OtherCategories,SectionID,OtherSections,CompareType,ImageDir,Image,ImageSmall,ImageLarge,ImageAlt,ImageAltLarge,Attribute1,Attribute2,Attribute3,OptionName1,OptionName2,OptionName3,OptionName4,OptionName5,OptionName6,OptionName7,OptionName8,OptionName9,OptionName10,Option1Optional,Option2Optional,Option3Optional,Option4Optional,Option5Optional,Option6Optional,Option7Optional,Option8Optional,Option9Optional,Option10Optional,Weight,DimLength,DimWidth,DimHeighth,CostPrice,ListPrice,SalePrice,Price1,Price2,Hide1,Hide2,Taxable,StockQuantity,SellByStock,ItemStatus,DisplayOrder,Featured,SoftwareDownload,SoftwareAttachment,DaysAvailable,DownloadLocation,DistributorID,ItemClassID,UseMatrix,RProSID,rdi_date_removed,fldShipByWeight,fldShipWeight,fldShipAmount,fldHandAmount,fldOversize,fldShipCode,Deleted,DateCreated,DateUpdated,UpdatedBy,Volume,QB,QB_ACCNT,QB_ASSETACCNT,QB_COGSACCNT,QB_SALESTAXCODE,QB_PREFVEND,QB_SUBITEM,QB_REORDERPOINT,QB_PAYMETH,QB_TAXVEND) VALUES('15','1','MINDX20','2787-301','Konica Minolta DiMAGE X20','<FONT size=2>An Ultra-Slim, Compact Digital Camera with Easy-to-Use Operation and Fun, Creative Features </FONT>
<P><FONT size=2>The DiMAGE X20 is the world?s smallest and lightest 2 megapixel camera with a 3X optical zoom*, and it?s built for a life on-the-go. This camera is so small and light it can be slipped into a pocket or bag as easily as a wallet, yet Minolta has packed it with creative features that make digital photography fun for everyone. Whether you are heading out for an evening of dancing, trekking though some exotic location, or dropping in on a close friend, the DiMAGE X20 can go right along with you. </FONT></P>',NULL,'2.0 megapixels (effective), 3x optical zoom/4x digital zoom, autofocus only, program exposure, JPEG file format, ISO range 64-400, 2 AA batteries, movie mode with sound.',NULL,'7','X,13,24,X','2','X,,X','0','products','minolta-dimage-x20.gif','minolta-dimage-x20-sm.gif','minolta-dimage-x20-lg.jpg',NULL,NULL,'2.0 MEGAPIXEL, 3X OPTICAL/4X DIGITAL ZOOM, DIGITAL CAMERA',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,0,0,0,0,2,10,10,4,99,220,0,149.99,149.99,0,0,1,'76',0,'IS','21',NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,1,2,0,0,0,NULL,0,'2005-5-2 18:40:0','2005-5-2 18:40:0','ADMIN',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Products (ItemID,SiteID,SKU,ManufacturerID,ItemName,ItemDescription,ItemDetails,ShortDescription,Comments,Category,OtherCategories,SectionID,OtherSections,CompareType,ImageDir,Image,ImageSmall,ImageLarge,ImageAlt,ImageAltLarge,Attribute1,Attribute2,Attribute3,OptionName1,OptionName2,OptionName3,OptionName4,OptionName5,OptionName6,OptionName7,OptionName8,OptionName9,OptionName10,Option1Optional,Option2Optional,Option3Optional,Option4Optional,Option5Optional,Option6Optional,Option7Optional,Option8Optional,Option9Optional,Option10Optional,Weight,DimLength,DimWidth,DimHeighth,CostPrice,ListPrice,SalePrice,Price1,Price2,Hide1,Hide2,Taxable,StockQuantity,SellByStock,ItemStatus,DisplayOrder,Featured,SoftwareDownload,SoftwareAttachment,DaysAvailable,DownloadLocation,DistributorID,ItemClassID,UseMatrix,RProSID,rdi_date_removed,fldShipByWeight,fldShipWeight,fldShipAmount,fldHandAmount,fldOversize,fldShipCode,Deleted,DateCreated,DateUpdated,UpdatedBy,Volume,QB,QB_ACCNT,QB_ASSETACCNT,QB_COGSACCNT,QB_SALESTAXCODE,QB_PREFVEND,QB_SUBITEM,QB_REORDERPOINT,QB_PAYMETH,QB_TAXVEND) VALUES('16','1','NIKCP3700',NULL,'Nikon Coolpix 3700','<FONT size=2>Key Features: </FONT>
<UL>
<LI><FONT size=2>3.2 effective Megapixels for photo-quality prints up to 11" x 14". </FONT>
<LI><FONT size=2>3x Optical Zoom-Nikkor Lens (35mm equiv of 35mm - 105mm) for sharp, clear images. </FONT>
<LI><FONT size=2>Close-ups to 1.6 inches in macro mode. </FONT>
<LI><FONT size=2>Voice Recording of up to 5 hours plus 20 seconds per image voice memos for recording all the</FONT></LI></UL>',NULL,'3.2 megapixels (effective), 3x optical/4x digital zoom, autofocus only, program exposure only, JPEG file format, ISO range 50-200, proprietary Lithium-Ion battery, movie mode with sound.',NULL,'8','X,13,25,X','3','X,,X','0','products','nikon-coolpix-3700.gif','nikon-coolpix-3700-sm.gif','nikon-coolpix-3700-lg.jpg',NULL,NULL,'3MP Digital Camera, 3x Optical Zoom',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,0,0,0,0,1,10,10,4,150,299.95,0,199.95,199.95,0,0,1,'22',0,'IS','22',NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,1,1,0,0,0,NULL,0,'2005-5-2 18:50:0','2005-5-2 18:50:0','ADMIN',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Products (ItemID,SiteID,SKU,ManufacturerID,ItemName,ItemDescription,ItemDetails,ShortDescription,Comments,Category,OtherCategories,SectionID,OtherSections,CompareType,ImageDir,Image,ImageSmall,ImageLarge,ImageAlt,ImageAltLarge,Attribute1,Attribute2,Attribute3,OptionName1,OptionName2,OptionName3,OptionName4,OptionName5,OptionName6,OptionName7,OptionName8,OptionName9,OptionName10,Option1Optional,Option2Optional,Option3Optional,Option4Optional,Option5Optional,Option6Optional,Option7Optional,Option8Optional,Option9Optional,Option10Optional,Weight,DimLength,DimWidth,DimHeighth,CostPrice,ListPrice,SalePrice,Price1,Price2,Hide1,Hide2,Taxable,StockQuantity,SellByStock,ItemStatus,DisplayOrder,Featured,SoftwareDownload,SoftwareAttachment,DaysAvailable,DownloadLocation,DistributorID,ItemClassID,UseMatrix,RProSID,rdi_date_removed,fldShipByWeight,fldShipWeight,fldShipAmount,fldHandAmount,fldOversize,fldShipCode,Deleted,DateCreated,DateUpdated,UpdatedBy,Volume,QB,QB_ACCNT,QB_ASSETACCNT,QB_COGSACCNT,QB_SALESTAXCODE,QB_PREFVEND,QB_SUBITEM,QB_REORDERPOINT,QB_PAYMETH,QB_TAXVEND) VALUES('17','1','MINDG500','2731-131','Konica Minolta DiMAGE G-500','<FONT size=2>Dressed in an elegant metal case, the DiMAGE G500 is a stylish and versatile companion, packing high-quality 5 megapixel images and powerful imaging controls in a compact body. Measuring only 3.7 x 2.2 x 1.2 inches, the G500 can be easily slipped into a pocket, purse, or fanny pack. And weighing a mere 7 ounces, this camera will not be a burden. </FONT>
<P><FONT size=2>Despite its small size, the DiMAGE G500 is packed with image-making features. Exposures can be set manually. Color saturation, contrast, and sharpness can be controlled to create the picture you want. And a maximum 9X zoom ratio provides powerful photographic potential.</FONT></P>',NULL,'5.0 megapixels (effective), 3x optical/3x digital zoom, autofocus only, auto and manual exposure, JPEG file format only, ISO range 50 - 400, proprietary Lithium-Ion battery, movie mode with sound.',NULL,'7','X,14,27,X','4','X,,X','0','products','minolta-dimage-g500.gif','minolta-dimage-g500-sm.gif','minolta-dimage-g500-lg.jpg',NULL,NULL,'5.0 MEGAPIXEL,3X OPTICAL/4X DIGITAL ZOOM, DIGITAL CAMERA',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,0,0,0,0,2,10,10,4,170,279.95,0,229.95,229.95,0,0,1,'73',0,'IS','20',NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,1,2,0,0,0,NULL,0,'2005-5-2 18:55:0','2005-5-2 18:55:0','ADMIN',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Products (ItemID,SiteID,SKU,ManufacturerID,ItemName,ItemDescription,ItemDetails,ShortDescription,Comments,Category,OtherCategories,SectionID,OtherSections,CompareType,ImageDir,Image,ImageSmall,ImageLarge,ImageAlt,ImageAltLarge,Attribute1,Attribute2,Attribute3,OptionName1,OptionName2,OptionName3,OptionName4,OptionName5,OptionName6,OptionName7,OptionName8,OptionName9,OptionName10,Option1Optional,Option2Optional,Option3Optional,Option4Optional,Option5Optional,Option6Optional,Option7Optional,Option8Optional,Option9Optional,Option10Optional,Weight,DimLength,DimWidth,DimHeighth,CostPrice,ListPrice,SalePrice,Price1,Price2,Hide1,Hide2,Taxable,StockQuantity,SellByStock,ItemStatus,DisplayOrder,Featured,SoftwareDownload,SoftwareAttachment,DaysAvailable,DownloadLocation,DistributorID,ItemClassID,UseMatrix,RProSID,rdi_date_removed,fldShipByWeight,fldShipWeight,fldShipAmount,fldHandAmount,fldOversize,fldShipCode,Deleted,DateCreated,DateUpdated,UpdatedBy,Volume,QB,QB_ACCNT,QB_ASSETACCNT,QB_COGSACCNT,QB_SALESTAXCODE,QB_PREFVEND,QB_SUBITEM,QB_REORDERPOINT,QB_PAYMETH,QB_TAXVEND) VALUES('18','1','KODLS420',NULL,'Kodak EasyShare LS420',NULL,NULL,'4.0 megapixels (effective), 4x optical zoom/3.8x digital zoom, autofocus only, program and manual exposure, JPEG file format, ISO range 100-400, proprietary Lithium-Ion battery, movie mode with sound, includes EasyShare camera dock.',NULL,'6','X,14,24,X','3','X,,X','0','products','Kodak_LS420.jpg','Kodak_LS420-sm.jpg',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,0,0,0,0,1,10,10,4,200,359.95,0,299.99,299.99,0,0,1,'6',0,'IS','17',NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,1,1,0,0,0,NULL,0,'2005-5-2 19:3:0','2005-5-2 19:3:0','ADMIN',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Products (ItemID,SiteID,SKU,ManufacturerID,ItemName,ItemDescription,ItemDetails,ShortDescription,Comments,Category,OtherCategories,SectionID,OtherSections,CompareType,ImageDir,Image,ImageSmall,ImageLarge,ImageAlt,ImageAltLarge,Attribute1,Attribute2,Attribute3,OptionName1,OptionName2,OptionName3,OptionName4,OptionName5,OptionName6,OptionName7,OptionName8,OptionName9,OptionName10,Option1Optional,Option2Optional,Option3Optional,Option4Optional,Option5Optional,Option6Optional,Option7Optional,Option8Optional,Option9Optional,Option10Optional,Weight,DimLength,DimWidth,DimHeighth,CostPrice,ListPrice,SalePrice,Price1,Price2,Hide1,Hide2,Taxable,StockQuantity,SellByStock,ItemStatus,DisplayOrder,Featured,SoftwareDownload,SoftwareAttachment,DaysAvailable,DownloadLocation,DistributorID,ItemClassID,UseMatrix,RProSID,rdi_date_removed,fldShipByWeight,fldShipWeight,fldShipAmount,fldHandAmount,fldOversize,fldShipCode,Deleted,DateCreated,DateUpdated,UpdatedBy,Volume,QB,QB_ACCNT,QB_ASSETACCNT,QB_COGSACCNT,QB_SALESTAXCODE,QB_PREFVEND,QB_SUBITEM,QB_REORDERPOINT,QB_PAYMETH,QB_TAXVEND) VALUES('19','1','HPPS850',NULL,'HP Photosmart 850','<p><font size="2">Get brilliant photos near and far with the HP Photosmart 850 digital camera. With 56x total zoom (8x optical, 7x digital) and 4.1 MP resolution you will get outstanding close-ups and beautiful quality for prints up to 20x30-inches. Then use HP Instant Share to select on your camera where photos will go- including e-mail addresses, printers and more. Choose the automatic mode or manual controls to select camera setting for ISO exposure, white balance, and more. And you can capture moments in sound and motion using the video clip with audio feature! </font></p>',NULL,'3.2 megapixels (effective), 3x optical zoom, 5x digital zoom, autofocus only, program exposure only, JPEG file format, ISO range 100 - 400, 2 AA batteries, movie mode with sound.',NULL,'5','X,15,26,X','4','X,,X','0','products','HPPhotoSmart850.gif','HPPhotoSmart850-sm.jpg',NULL,NULL,NULL,'(4.1MP, 2384x1734, 8x Opt, 16MB SD Card)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,0,0,0,0,2,10,10,4,346,449.95,0,399.99,399.99,0,0,1,'23',0,'IS','15',1,NULL,NULL,NULL,NULL,'3',NULL,NULL,NULL,NULL,1,2,0,0,0,NULL,0,'2005-5-2 19:10:0','2005-5-6 18:42:0','ADMIN',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Products (ItemID,SiteID,SKU,ManufacturerID,ItemName,ItemDescription,ItemDetails,ShortDescription,Comments,Category,OtherCategories,SectionID,OtherSections,CompareType,ImageDir,Image,ImageSmall,ImageLarge,ImageAlt,ImageAltLarge,Attribute1,Attribute2,Attribute3,OptionName1,OptionName2,OptionName3,OptionName4,OptionName5,OptionName6,OptionName7,OptionName8,OptionName9,OptionName10,Option1Optional,Option2Optional,Option3Optional,Option4Optional,Option5Optional,Option6Optional,Option7Optional,Option8Optional,Option9Optional,Option10Optional,Weight,DimLength,DimWidth,DimHeighth,CostPrice,ListPrice,SalePrice,Price1,Price2,Hide1,Hide2,Taxable,StockQuantity,SellByStock,ItemStatus,DisplayOrder,Featured,SoftwareDownload,SoftwareAttachment,DaysAvailable,DownloadLocation,DistributorID,ItemClassID,UseMatrix,RProSID,rdi_date_removed,fldShipByWeight,fldShipWeight,fldShipAmount,fldHandAmount,fldOversize,fldShipCode,Deleted,DateCreated,DateUpdated,UpdatedBy,Volume,QB,QB_ACCNT,QB_ASSETACCNT,QB_COGSACCNT,QB_SALESTAXCODE,QB_PREFVEND,QB_SUBITEM,QB_REORDERPOINT,QB_PAYMETH,QB_TAXVEND) VALUES('20','1','HPPS945',NULL,'HP PhotoSmart 945',NULL,NULL,'5.3 megapixels (effective), 8x optical zoom, 7x digital zoom, auto and manual focus, program and manual exposure only, JPEG file format, ISO range 100 - 400, 4 AA batteries, movie mode with sound.',NULL,'5','X,14,27,X','5','X,,X','0','products','hp-photosmart-945.gif','hp-photosmart-945-sm.gif','hp-photosmart-945-lg.gif',NULL,NULL,'5.3 Megapixel Digital Camera',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,0,0,0,0,1,10,10,4,200,359.95,0,299.99,299.99,0,0,1,'7',1,'IS','16',NULL,NULL,NULL,NULL,NULL,'2',NULL,0,NULL,NULL,1,1,0,0,0,NULL,0,'2005-5-2 19:16:0','2006-5-24 14:19:0','ADMIN',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Products (ItemID,SiteID,SKU,ManufacturerID,ItemName,ItemDescription,ItemDetails,ShortDescription,Comments,Category,OtherCategories,SectionID,OtherSections,CompareType,ImageDir,Image,ImageSmall,ImageLarge,ImageAlt,ImageAltLarge,Attribute1,Attribute2,Attribute3,OptionName1,OptionName2,OptionName3,OptionName4,OptionName5,OptionName6,OptionName7,OptionName8,OptionName9,OptionName10,Option1Optional,Option2Optional,Option3Optional,Option4Optional,Option5Optional,Option6Optional,Option7Optional,Option8Optional,Option9Optional,Option10Optional,Weight,DimLength,DimWidth,DimHeighth,CostPrice,ListPrice,SalePrice,Price1,Price2,Hide1,Hide2,Taxable,StockQuantity,SellByStock,ItemStatus,DisplayOrder,Featured,SoftwareDownload,SoftwareAttachment,DaysAvailable,DownloadLocation,DistributorID,ItemClassID,UseMatrix,RProSID,rdi_date_removed,fldShipByWeight,fldShipWeight,fldShipAmount,fldHandAmount,fldOversize,fldShipCode,Deleted,DateCreated,DateUpdated,UpdatedBy,Volume,QB,QB_ACCNT,QB_ASSETACCNT,QB_COGSACCNT,QB_SALESTAXCODE,QB_PREFVEND,QB_SUBITEM,QB_REORDERPOINT,QB_PAYMETH,QB_TAXVEND) VALUES('21','1','FUJFPS5000','43860875','Fuji FinePix S-5000',NULL,NULL,'3.1 megapixels (effective), 10x optical/2.2x digital zoom, auto and manual focus, program and manual exposure, JPEG file format, ISO range 160-400, 4 AA batteries, movie mode with sound.',NULL,'31','X,14,25,X','5','X,,X','0','products','fuji-finepix-s5000.gif','fuji-finepix-s5000-sm.gif','fuji-finepix-s5000-lg.jpg',NULL,NULL,'3.1 MEGAPIXEL, 10X OPTICAL/2.2X DIGITAL ZOOM, DIGITAL CAMERA',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,0,0,0,0,2,10,10,4,180,299.95,0,249.99,249.99,0,0,1,'50',0,'IS','13',1,NULL,NULL,NULL,NULL,'2',NULL,NULL,NULL,NULL,1,2,0,0,0,NULL,0,'2005-5-2 20:34:0','2005-5-2 21:20:0','ADMIN',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Products (ItemID,SiteID,SKU,ManufacturerID,ItemName,ItemDescription,ItemDetails,ShortDescription,Comments,Category,OtherCategories,SectionID,OtherSections,CompareType,ImageDir,Image,ImageSmall,ImageLarge,ImageAlt,ImageAltLarge,Attribute1,Attribute2,Attribute3,OptionName1,OptionName2,OptionName3,OptionName4,OptionName5,OptionName6,OptionName7,OptionName8,OptionName9,OptionName10,Option1Optional,Option2Optional,Option3Optional,Option4Optional,Option5Optional,Option6Optional,Option7Optional,Option8Optional,Option9Optional,Option10Optional,Weight,DimLength,DimWidth,DimHeighth,CostPrice,ListPrice,SalePrice,Price1,Price2,Hide1,Hide2,Taxable,StockQuantity,SellByStock,ItemStatus,DisplayOrder,Featured,SoftwareDownload,SoftwareAttachment,DaysAvailable,DownloadLocation,DistributorID,ItemClassID,UseMatrix,RProSID,rdi_date_removed,fldShipByWeight,fldShipWeight,fldShipAmount,fldHandAmount,fldOversize,fldShipCode,Deleted,DateCreated,DateUpdated,UpdatedBy,Volume,QB,QB_ACCNT,QB_ASSETACCNT,QB_COGSACCNT,QB_SALESTAXCODE,QB_PREFVEND,QB_SUBITEM,QB_REORDERPOINT,QB_PAYMETH,QB_TAXVEND) VALUES('22','1','FUJFPF410','43860820','Fuji FinePix F410','<font size="2">The first Digital Camera to Carry Fujifilm''s fourth-generation Super CCD hr (High Resolution) sensor, The FinePix F410. The Camera, which has 3.1 million effective pixels, provides first-time Digital Camera Users with increased Resolution sensitivity and Color reproduction, and produces High quality images with 2,816 x 2,120 (6.0 million) recorded pixels. The FinePix F410 zoom integrates full Digital Multi-Media Video and sound. a Sharp 3X optical zoom fits into Fujifilm''s stunning trademark Square Palm sized design. It''s a great choice for low light photography with its 1 megapixel 800 ISO mode. The F410 records movies with sound. Downloading files Is simple with Fujifilm''s New FinePix Viewer ver. 4.0.</font>','<div class="mediumtxt"><font size="2">3.1 megapixels (effective), 3x optical/4.4x digital zoom, autofocus only, program exposure only, JPEG file format only, ISO range 200-400 (800 if set at 1MP resolution), proprietary Lithium-Ion battery, movie mode with sound.</font></div>','3.1 megapixels (effective), 3x optical/4.4x digital zoom, autofocus only, program exposure only, JPEG file format only, ISO range 200-400 (800 if set at 1MP resolution), proprietary Lithium-Ion battery, movie mode with sound.',NULL,'4','X,14,25,X','2','X,,X','0','products','fuji-finepix-f410.gif','fuji-finepix-f410-sm.gif','fuji-finepix-f410-lg.jpg',NULL,NULL,NULL,NULL,NULL,'Memory Card',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,0,0,0,0,0,0,0,1,10,10,4,200,409,0,269.95,269.95,0,0,1,'53',0,'IS','11',NULL,NULL,NULL,NULL,NULL,'2',NULL,NULL,NULL,NULL,1,1,0,0,0,NULL,0,'2005-5-2 20:42:0','2005-6-29 11:32:0','ADMIN',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Products (ItemID,SiteID,SKU,ManufacturerID,ItemName,ItemDescription,ItemDetails,ShortDescription,Comments,Category,OtherCategories,SectionID,OtherSections,CompareType,ImageDir,Image,ImageSmall,ImageLarge,ImageAlt,ImageAltLarge,Attribute1,Attribute2,Attribute3,OptionName1,OptionName2,OptionName3,OptionName4,OptionName5,OptionName6,OptionName7,OptionName8,OptionName9,OptionName10,Option1Optional,Option2Optional,Option3Optional,Option4Optional,Option5Optional,Option6Optional,Option7Optional,Option8Optional,Option9Optional,Option10Optional,Weight,DimLength,DimWidth,DimHeighth,CostPrice,ListPrice,SalePrice,Price1,Price2,Hide1,Hide2,Taxable,StockQuantity,SellByStock,ItemStatus,DisplayOrder,Featured,SoftwareDownload,SoftwareAttachment,DaysAvailable,DownloadLocation,DistributorID,ItemClassID,UseMatrix,RProSID,rdi_date_removed,fldShipByWeight,fldShipWeight,fldShipAmount,fldHandAmount,fldOversize,fldShipCode,Deleted,DateCreated,DateUpdated,UpdatedBy,Volume,QB,QB_ACCNT,QB_ASSETACCNT,QB_COGSACCNT,QB_SALESTAXCODE,QB_PREFVEND,QB_SUBITEM,QB_REORDERPOINT,QB_PAYMETH,QB_TAXVEND) VALUES('23','1','FUJFPA205',NULL,'Fuji FinePix A205','<font size="2">The Fuji FinePix A205 offers a low price, simple controls, and compatibility with Fuji''s optional camera docking cradle. While its 2-megapixel resolution will not allow for printing much larger than postcard size, the A205 should appeal to shoppers in search of a reasonably-priced camera for casual snapshots. </font>',NULL,'2.0 megapixels (effective), 3x optical/2.5x digital zoom, autofocus only, auto and manual exposure, JPEG file format only, ISO 100 only, 2 AA batteries, movie mode (no sound).',NULL,'4','X,13,24,X','3','X,,X','1','products','fuji-finepix-a205.gif','fuji-finepix-a205-sm.gif',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,0,0,0,0,2,10,10,4,0,199.99,0,89.99,89.99,0,0,1,'-2',NULL,'IS','9',NULL,NULL,NULL,NULL,NULL,'3',NULL,0,NULL,NULL,1,2,0,0,0,NULL,0,'2005-5-2 20:45:0','2006-8-28 8:7:0','ADMIN',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Products (ItemID,SiteID,SKU,ManufacturerID,ItemName,ItemDescription,ItemDetails,ShortDescription,Comments,Category,OtherCategories,SectionID,OtherSections,CompareType,ImageDir,Image,ImageSmall,ImageLarge,ImageAlt,ImageAltLarge,Attribute1,Attribute2,Attribute3,OptionName1,OptionName2,OptionName3,OptionName4,OptionName5,OptionName6,OptionName7,OptionName8,OptionName9,OptionName10,Option1Optional,Option2Optional,Option3Optional,Option4Optional,Option5Optional,Option6Optional,Option7Optional,Option8Optional,Option9Optional,Option10Optional,Weight,DimLength,DimWidth,DimHeighth,CostPrice,ListPrice,SalePrice,Price1,Price2,Hide1,Hide2,Taxable,StockQuantity,SellByStock,ItemStatus,DisplayOrder,Featured,SoftwareDownload,SoftwareAttachment,DaysAvailable,DownloadLocation,DistributorID,ItemClassID,UseMatrix,RProSID,rdi_date_removed,fldShipByWeight,fldShipWeight,fldShipAmount,fldHandAmount,fldOversize,fldShipCode,Deleted,DateCreated,DateUpdated,UpdatedBy,Volume,QB,QB_ACCNT,QB_ASSETACCNT,QB_COGSACCNT,QB_SALESTAXCODE,QB_PREFVEND,QB_SUBITEM,QB_REORDERPOINT,QB_PAYMETH,QB_TAXVEND) VALUES('24','1','FUJFPS3000','43860780','Fuji FinePix S-3000','<FONT size=2>The FinePix S3000 offers 3.2 million effective pixels, which can produce images of 2048 x 1536 (3.15 million) recorded pixels for best-quality prints up to 8 x 10 inches in size. The camera also offers 6x optical and 3.2x digital zooms, movie recording without sound and several scene positioning modes.</FONT>',NULL,'3.2 megapixels (effective), 6x optical/3.2x digital zoom, auto focus only, program and manual exposure, JPEG file format, ISO range 100 - 200, 4 AA batteries, movie mode (no sound).',NULL,'31','X,13,25,X','3','X,,X','0','products','fuji-finepix-s3000.gif','fuji-finepix-s3000-sm.gif','fuji-finepix-s3000-lg.jpg',NULL,NULL,'3.2 MEGAPIXEL, 6X OPTICAL/3.2X DIGITAL ZOOM, DIGITAL CAMERA',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,0,0,0,0,1,10,10,4,130,249.99,0,197.95,197.95,0,0,1,'39',0,'IS','12',NULL,NULL,NULL,NULL,NULL,'2',NULL,NULL,NULL,NULL,1,1,0,0,0,NULL,0,'2005-5-2 20:50:0','2005-5-2 21:20:0','ADMIN',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Products (ItemID,SiteID,SKU,ManufacturerID,ItemName,ItemDescription,ItemDetails,ShortDescription,Comments,Category,OtherCategories,SectionID,OtherSections,CompareType,ImageDir,Image,ImageSmall,ImageLarge,ImageAlt,ImageAltLarge,Attribute1,Attribute2,Attribute3,OptionName1,OptionName2,OptionName3,OptionName4,OptionName5,OptionName6,OptionName7,OptionName8,OptionName9,OptionName10,Option1Optional,Option2Optional,Option3Optional,Option4Optional,Option5Optional,Option6Optional,Option7Optional,Option8Optional,Option9Optional,Option10Optional,Weight,DimLength,DimWidth,DimHeighth,CostPrice,ListPrice,SalePrice,Price1,Price2,Hide1,Hide2,Taxable,StockQuantity,SellByStock,ItemStatus,DisplayOrder,Featured,SoftwareDownload,SoftwareAttachment,DaysAvailable,DownloadLocation,DistributorID,ItemClassID,UseMatrix,RProSID,rdi_date_removed,fldShipByWeight,fldShipWeight,fldShipAmount,fldHandAmount,fldOversize,fldShipCode,Deleted,DateCreated,DateUpdated,UpdatedBy,Volume,QB,QB_ACCNT,QB_ASSETACCNT,QB_COGSACCNT,QB_SALESTAXCODE,QB_PREFVEND,QB_SUBITEM,QB_REORDERPOINT,QB_PAYMETH,QB_TAXVEND) VALUES('25','1','FUJFPF10',NULL,'Fuji FinePix F10',NULL,NULL,'6.3 megapixels (effective), 3x optical zoom/6.2x digital zoom, autofocus only, program and manual exposure, JPE file format, ISO 80 - 1600, proprietary lithium-ion battery, movie mode with sound.',NULL,'4','X,15,28,X','3','X,,X','0','products','fuji-finepix-f10.gif','fuji-finepix-f10-sm.gif','fuji-finepix-f10-lg.jpg',NULL,NULL,'Digital Camera',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,0,0,0,0,2,10,10,4,250,399,0,329.95,329.95,0,0,1,'31',0,'IS','10',NULL,NULL,NULL,NULL,NULL,'2',NULL,NULL,NULL,NULL,1,2,0,0,0,NULL,0,'2005-5-2 20:54:0','2005-7-5 17:28:0','ADMIN',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Products (ItemID,SiteID,SKU,ManufacturerID,ItemName,ItemDescription,ItemDetails,ShortDescription,Comments,Category,OtherCategories,SectionID,OtherSections,CompareType,ImageDir,Image,ImageSmall,ImageLarge,ImageAlt,ImageAltLarge,Attribute1,Attribute2,Attribute3,OptionName1,OptionName2,OptionName3,OptionName4,OptionName5,OptionName6,OptionName7,OptionName8,OptionName9,OptionName10,Option1Optional,Option2Optional,Option3Optional,Option4Optional,Option5Optional,Option6Optional,Option7Optional,Option8Optional,Option9Optional,Option10Optional,Weight,DimLength,DimWidth,DimHeighth,CostPrice,ListPrice,SalePrice,Price1,Price2,Hide1,Hide2,Taxable,StockQuantity,SellByStock,ItemStatus,DisplayOrder,Featured,SoftwareDownload,SoftwareAttachment,DaysAvailable,DownloadLocation,DistributorID,ItemClassID,UseMatrix,RProSID,rdi_date_removed,fldShipByWeight,fldShipWeight,fldShipAmount,fldHandAmount,fldOversize,fldShipCode,Deleted,DateCreated,DateUpdated,UpdatedBy,Volume,QB,QB_ACCNT,QB_ASSETACCNT,QB_COGSACCNT,QB_SALESTAXCODE,QB_PREFVEND,QB_SUBITEM,QB_REORDERPOINT,QB_PAYMETH,QB_TAXVEND) VALUES('26','1','KODZ700','8047615','Kodak EasyShare Z700',NULL,NULL,'4.0 megapixels (effective), 5x optical zoom/4x digital zoom, autofocus only, program and manual exposure, JPEG file format, ISO range 80-400, 2 AA batteries, movie mode with sound.',NULL,'6','X,14,26,X','2','X,,X','0','products','kodak-easyshare-z700.gif','kodak-easyshare-z700-sm.gif','kodak-easyshare-z700-lg.jpg',NULL,NULL,'4 Megapixel / 5x Optical Zoom / 4x Digital Zoom /','Kodak Color Science Chip for magnificent imaging / Still and Movie / SD Memory / 1.6" Color LCD',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,0,0,0,0,1,10,10,4,220,399.99,0,279.99,279.99,0,0,1,'-2',NULL,'BO','18',1,NULL,NULL,NULL,NULL,'1',NULL,0,NULL,NULL,1,1,0,0,0,NULL,0,'2005-5-2 21:3:0','2007-2-16 12:25:0','ADMIN',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Products (ItemID,SiteID,SKU,ManufacturerID,ItemName,ItemDescription,ItemDetails,ShortDescription,Comments,Category,OtherCategories,SectionID,OtherSections,CompareType,ImageDir,Image,ImageSmall,ImageLarge,ImageAlt,ImageAltLarge,Attribute1,Attribute2,Attribute3,OptionName1,OptionName2,OptionName3,OptionName4,OptionName5,OptionName6,OptionName7,OptionName8,OptionName9,OptionName10,Option1Optional,Option2Optional,Option3Optional,Option4Optional,Option5Optional,Option6Optional,Option7Optional,Option8Optional,Option9Optional,Option10Optional,Weight,DimLength,DimWidth,DimHeighth,CostPrice,ListPrice,SalePrice,Price1,Price2,Hide1,Hide2,Taxable,StockQuantity,SellByStock,ItemStatus,DisplayOrder,Featured,SoftwareDownload,SoftwareAttachment,DaysAvailable,DownloadLocation,DistributorID,ItemClassID,UseMatrix,RProSID,rdi_date_removed,fldShipByWeight,fldShipWeight,fldShipAmount,fldHandAmount,fldOversize,fldShipCode,Deleted,DateCreated,DateUpdated,UpdatedBy,Volume,QB,QB_ACCNT,QB_ASSETACCNT,QB_COGSACCNT,QB_SALESTAXCODE,QB_PREFVEND,QB_SUBITEM,QB_REORDERPOINT,QB_PAYMETH,QB_TAXVEND) VALUES('27','1','OLM-E300',NULL,'Olympus E-300 EVOLT','<FONT size=2>The EVOLT E-300 is a 100% digital SLR camera with great possibilities for first-time users and extraordinary options for the advanced photographer! Durable and portable compact camera with fast shooting and operating speeds so that you never miss an amazing shot!</FONT>',NULL,'8.0 megapixels (effective), auto and manual focus, program and manual exposure, JPEG, TIFF, and RAW file format, ISO range 100-1600, proprietary Lithium-Ion battery. Accepts interchangeable Zuiko digital lenses, comes standard with a 14-45mm lens.',NULL,'9','X,19,28,X','7','X,,X','0','products','olympus-e300.gif','olympus-e300-sm.gif','olympus-e300-lg.gif',NULL,NULL,'Digital SLR 8.0 Megapixel, Digital Camera',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,0,0,0,0,2,10,10,4,800,999.95,0,899.95,899.95,0,0,1,'1',0,'IS','26',1,NULL,NULL,NULL,NULL,'2',NULL,NULL,NULL,NULL,1,2,0,0,0,NULL,0,'2005-5-3 10:37:0','2005-5-3 10:37:0','ADMIN',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Products (ItemID,SiteID,SKU,ManufacturerID,ItemName,ItemDescription,ItemDetails,ShortDescription,Comments,Category,OtherCategories,SectionID,OtherSections,CompareType,ImageDir,Image,ImageSmall,ImageLarge,ImageAlt,ImageAltLarge,Attribute1,Attribute2,Attribute3,OptionName1,OptionName2,OptionName3,OptionName4,OptionName5,OptionName6,OptionName7,OptionName8,OptionName9,OptionName10,Option1Optional,Option2Optional,Option3Optional,Option4Optional,Option5Optional,Option6Optional,Option7Optional,Option8Optional,Option9Optional,Option10Optional,Weight,DimLength,DimWidth,DimHeighth,CostPrice,ListPrice,SalePrice,Price1,Price2,Hide1,Hide2,Taxable,StockQuantity,SellByStock,ItemStatus,DisplayOrder,Featured,SoftwareDownload,SoftwareAttachment,DaysAvailable,DownloadLocation,DistributorID,ItemClassID,UseMatrix,RProSID,rdi_date_removed,fldShipByWeight,fldShipWeight,fldShipAmount,fldHandAmount,fldOversize,fldShipCode,Deleted,DateCreated,DateUpdated,UpdatedBy,Volume,QB,QB_ACCNT,QB_ASSETACCNT,QB_COGSACCNT,QB_SALESTAXCODE,QB_PREFVEND,QB_SUBITEM,QB_REORDERPOINT,QB_PAYMETH,QB_TAXVEND) VALUES('28','1','OLM-C8080',NULL,'Olympus C-8080','<FONT size=2>Amazing Resolution, World Class Optics<BR><BR>8 megapixel prosumer camera captures the highest quality TIFF image with a staggering 3264 x 2448 pixels.<BR><BR>Super-bright, ED glass 5x "wide angle" optical zoom lens to catch the tough shots.<BR><BR>Equivalent to 28-140mm lens in 35mm photography.<BR></FONT>',NULL,'8.0 megapixels (effective), 5x optical zoom/3x digital zoom, auto and manual focus, program and manual exposure, JPEG, TIFF, and RAW file formats, ISO range 50 - 400, proprietary Lithium-Ion battery, movie mode with sound.',NULL,'9','X,17,28,X','4','X,,X','0','products','olympus-c8080wz.gif','olympus-c8080wz-sm.gif','olympus-c8080wz-lg.jpg',NULL,NULL,'Wide Zoom','8.0 Megapixel Digital Camera',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,0,0,0,0,1,10,10,4,500,899.99,0,599.95,599.95,0,0,1,'16',0,'IS','25',NULL,NULL,NULL,NULL,NULL,'2',NULL,NULL,NULL,NULL,1,1,0,0,0,NULL,0,'2005-5-3 10:41:0','2005-5-3 10:41:0','ADMIN',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Products (ItemID,SiteID,SKU,ManufacturerID,ItemName,ItemDescription,ItemDetails,ShortDescription,Comments,Category,OtherCategories,SectionID,OtherSections,CompareType,ImageDir,Image,ImageSmall,ImageLarge,ImageAlt,ImageAltLarge,Attribute1,Attribute2,Attribute3,OptionName1,OptionName2,OptionName3,OptionName4,OptionName5,OptionName6,OptionName7,OptionName8,OptionName9,OptionName10,Option1Optional,Option2Optional,Option3Optional,Option4Optional,Option5Optional,Option6Optional,Option7Optional,Option8Optional,Option9Optional,Option10Optional,Weight,DimLength,DimWidth,DimHeighth,CostPrice,ListPrice,SalePrice,Price1,Price2,Hide1,Hide2,Taxable,StockQuantity,SellByStock,ItemStatus,DisplayOrder,Featured,SoftwareDownload,SoftwareAttachment,DaysAvailable,DownloadLocation,DistributorID,ItemClassID,UseMatrix,RProSID,rdi_date_removed,fldShipByWeight,fldShipWeight,fldShipAmount,fldHandAmount,fldOversize,fldShipCode,Deleted,DateCreated,DateUpdated,UpdatedBy,Volume,QB,QB_ACCNT,QB_ASSETACCNT,QB_COGSACCNT,QB_SALESTAXCODE,QB_PREFVEND,QB_SUBITEM,QB_REORDERPOINT,QB_PAYMETH,QB_TAXVEND) VALUES('29','1','B0000TMP2M',NULL,'Black Universal Camera Case','&bull;&nbsp; Black case with platinum trim fits most medium- to large-size cameras<br />
&bull;&nbsp; Quality construction offers maximum protection for your camera <br />
&bull;&nbsp; Front zippered pocket for film and media storage <br />
&bull;&nbsp; Detachable shoulder strap plus nylon belt loop for easy transporting <br />
&bull;&nbsp; Exterior: 4.5Lx2.5Wx6.25H&quot;; interior: 4Lx1.75Wx5.75H&quot;',NULL,'Carry everything that came with your camera in this stylish leather bag','cases, bags','32','X,19,X',NULL,'X,1,3,X','0','products','B0000TMP2M.jpg','B0000TMP2Msm.jpg','B0000TMP2Mlg.jpg',NULL,NULL,NULL,NULL,NULL,'Color','Size',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,0,0,0,0,2,9,6,4,2.35,19.99,0,11.99,5,0,0,1,'698',1,'IS','1',1,NULL,NULL,NULL,NULL,'3','2',0,NULL,NULL,1,2,-5,100,0,'987',0,'2005-12-4 21:14:0','2007-3-29 10:20:0','ADMIN',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Products (ItemID,SiteID,SKU,ManufacturerID,ItemName,ItemDescription,ItemDetails,ShortDescription,Comments,Category,OtherCategories,SectionID,OtherSections,CompareType,ImageDir,Image,ImageSmall,ImageLarge,ImageAlt,ImageAltLarge,Attribute1,Attribute2,Attribute3,OptionName1,OptionName2,OptionName3,OptionName4,OptionName5,OptionName6,OptionName7,OptionName8,OptionName9,OptionName10,Option1Optional,Option2Optional,Option3Optional,Option4Optional,Option5Optional,Option6Optional,Option7Optional,Option8Optional,Option9Optional,Option10Optional,Weight,DimLength,DimWidth,DimHeighth,CostPrice,ListPrice,SalePrice,Price1,Price2,Hide1,Hide2,Taxable,StockQuantity,SellByStock,ItemStatus,DisplayOrder,Featured,SoftwareDownload,SoftwareAttachment,DaysAvailable,DownloadLocation,DistributorID,ItemClassID,UseMatrix,RProSID,rdi_date_removed,fldShipByWeight,fldShipWeight,fldShipAmount,fldHandAmount,fldOversize,fldShipCode,Deleted,DateCreated,DateUpdated,UpdatedBy,Volume,QB,QB_ACCNT,QB_ASSETACCNT,QB_COGSACCNT,QB_SALESTAXCODE,QB_PREFVEND,QB_SUBITEM,QB_REORDERPOINT,QB_PAYMETH,QB_TAXVEND) VALUES('30','1','B0009B1ZP4','619427CB','Cherokee(r) Camera Bag','<div id="div0" style="DISPLAY: block">&bull;&nbsp; You''ll love having this convenient camera bag with you whenever you travel <br />
&bull;&nbsp; Camera bag has slots for your credit cards and ID and includes an internal cell phone case <br />
&bull;&nbsp; Zipper pockets give you instant access to your items on the front, back and inside of this bag <br />
&bull;&nbsp; Petite bag has a total of 19 separate compartments and organizational features <br />
&bull;&nbsp; Bag measures 9.5x4x7&quot;; made of pebble-textured vinyl</div>',NULL,'Enough room for all of your cords, cards, and camera lenses.',NULL,'32','X,32,13,X',NULL,'X,8,6,X','0','products','B0009B1ZP4.jpg','B0009B1ZP4sm.jpg','B0009B1ZP4lg.jpg','B0009B1ZP4alt.jpg','B0009B1ZP4altlg.jpg',NULL,NULL,NULL,'color',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,0,0,0,0,1,10,10,4,3.13,26.99,0,7.49,5.19,0,0,1,'58',1,'IS','7',1,NULL,NULL,NULL,NULL,'1','1',1,NULL,NULL,1,1,0,0,0,NULL,0,'2005-12-4 21:30:0','2007-3-29 8:54:0','ADMIN',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Products (ItemID,SiteID,SKU,ManufacturerID,ItemName,ItemDescription,ItemDetails,ShortDescription,Comments,Category,OtherCategories,SectionID,OtherSections,CompareType,ImageDir,Image,ImageSmall,ImageLarge,ImageAlt,ImageAltLarge,Attribute1,Attribute2,Attribute3,OptionName1,OptionName2,OptionName3,OptionName4,OptionName5,OptionName6,OptionName7,OptionName8,OptionName9,OptionName10,Option1Optional,Option2Optional,Option3Optional,Option4Optional,Option5Optional,Option6Optional,Option7Optional,Option8Optional,Option9Optional,Option10Optional,Weight,DimLength,DimWidth,DimHeighth,CostPrice,ListPrice,SalePrice,Price1,Price2,Hide1,Hide2,Taxable,StockQuantity,SellByStock,ItemStatus,DisplayOrder,Featured,SoftwareDownload,SoftwareAttachment,DaysAvailable,DownloadLocation,DistributorID,ItemClassID,UseMatrix,RProSID,rdi_date_removed,fldShipByWeight,fldShipWeight,fldShipAmount,fldHandAmount,fldOversize,fldShipCode,Deleted,DateCreated,DateUpdated,UpdatedBy,Volume,QB,QB_ACCNT,QB_ASSETACCNT,QB_COGSACCNT,QB_SALESTAXCODE,QB_PREFVEND,QB_SUBITEM,QB_REORDERPOINT,QB_PAYMETH,QB_TAXVEND) VALUES('31','1','DOF5XBB',NULL,'Domke F-5XB Shoulder/Belt Bag','<font size="2">The <strong>Domke F-5XB Shoulder/Belt Bag</strong> can be used as a camera bag, or remove the <strong>Gripper</strong> shoulder strap and thread a belt through for an instant waist/Hip pack. The bag can hold an SLR or rangefinder camera, 1 or 2 lenses, filters, film and accessories. There are seven compartments and pockets, with the main compartment padded and lined with a soft knit material. A heavy-duty zipper closes the main compartment, and double pull tabs regulate size and location of openings. All compartments are covered and protected by oversized weather flaps.</font>',NULL,'Waterproof Kevlar camera bags that last through the worst of it.',NULL,'32','X,,X',NULL,'X,,X','0','products','16009.jpg','16009-sm.jpg','16009-lg.jpg',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,0,0,0,0,2,10,10,4,19.27,69.95,0,59.95,59.95,0,0,1,'0',NULL,'IS','8',1,NULL,NULL,NULL,NULL,'1','1',1,NULL,NULL,1,2,0,0,0,NULL,0,'2006-7-20 11:31:0','2006-7-20 11:35:0','ADMIN',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Products (ItemID,SiteID,SKU,ManufacturerID,ItemName,ItemDescription,ItemDetails,ShortDescription,Comments,Category,OtherCategories,SectionID,OtherSections,CompareType,ImageDir,Image,ImageSmall,ImageLarge,ImageAlt,ImageAltLarge,Attribute1,Attribute2,Attribute3,OptionName1,OptionName2,OptionName3,OptionName4,OptionName5,OptionName6,OptionName7,OptionName8,OptionName9,OptionName10,Option1Optional,Option2Optional,Option3Optional,Option4Optional,Option5Optional,Option6Optional,Option7Optional,Option8Optional,Option9Optional,Option10Optional,Weight,DimLength,DimWidth,DimHeighth,CostPrice,ListPrice,SalePrice,Price1,Price2,Hide1,Hide2,Taxable,StockQuantity,SellByStock,ItemStatus,DisplayOrder,Featured,SoftwareDownload,SoftwareAttachment,DaysAvailable,DownloadLocation,DistributorID,ItemClassID,UseMatrix,RProSID,rdi_date_removed,fldShipByWeight,fldShipWeight,fldShipAmount,fldHandAmount,fldOversize,fldShipCode,Deleted,DateCreated,DateUpdated,UpdatedBy,Volume,QB,QB_ACCNT,QB_ASSETACCNT,QB_COGSACCNT,QB_SALESTAXCODE,QB_PREFVEND,QB_SUBITEM,QB_REORDERPOINT,QB_PAYMETH,QB_TAXVEND) VALUES('32','1','2012440',NULL,'Lowepro Orion Mini Camera Beltpack','The Orion Mini is perfect for day trips. Fits one SLR, two lenses, flash and accessories, or a medium format SLR with lens. Features include a reverse open lid for fast convenient access to equipment, a built-in adjustable waistbelt, a breathable mesh lumbar pad to prevent back fatigue, and an overlap zipper (easier to open than a standard zipper) for better protection. Batwing straps secure and compress the load to your body.','<table cellspacing="0" cellpadding="3" bgcolor="#ffffff" border="0">
    <tbody>
        <tr>
            <td class="desc" valign="top" width="5">&bull;<img height="1" alt="" width="1" border="0" src="http://www.bhphotovideo.com/images/shim.gif" /></td>
            <td align="left">
            <p>Perfect for day trips </p>
            </td>
        </tr>
        <tr>
            <td class="desc" valign="top" width="5">&bull;<img height="1" alt="" width="1" border="0" src="http://www.bhphotovideo.com/images/shim.gif" /></td>
            <td align="left">
            <p>Fits one SLR, two lenses, flash and accessories, or a medium format SLR with lens </p>
            </td>
        </tr>
        <tr>
            <td class="desc" valign="top" width="5">&bull;<img height="1" alt="" width="1" border="0" src="http://www.bhphotovideo.com/images/shim.gif" /></td>
            <td align="left">
            <p>Adjustable waistbelt </p>
            </td>
        </tr>
    </tbody>
</table>',NULL,NULL,'32','X,13,X',NULL,'X,1,X','0','products','147539.jpg','147539-sm.jpg','147539-lg.jpg','135109.jpg','135109-lg.jpg','Comes in Black, Forest Green, Royal Blue, and Red',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,0,0,0,0,4.5,10,10,4,18,49.95,0,31.95,22,0,0,1,'39',1,'IS','1',NULL,NULL,NULL,NULL,NULL,'1','2',1,NULL,NULL,1,4.5,100,50,0,NULL,0,'2007-3-22 19:2:0','2007-3-23 14:31:0','ADMIN',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.Products (ItemID,SiteID,SKU,ManufacturerID,ItemName,ItemDescription,ItemDetails,ShortDescription,Comments,Category,OtherCategories,SectionID,OtherSections,CompareType,ImageDir,Image,ImageSmall,ImageLarge,ImageAlt,ImageAltLarge,Attribute1,Attribute2,Attribute3,OptionName1,OptionName2,OptionName3,OptionName4,OptionName5,OptionName6,OptionName7,OptionName8,OptionName9,OptionName10,Option1Optional,Option2Optional,Option3Optional,Option4Optional,Option5Optional,Option6Optional,Option7Optional,Option8Optional,Option9Optional,Option10Optional,Weight,DimLength,DimWidth,DimHeighth,CostPrice,ListPrice,SalePrice,Price1,Price2,Hide1,Hide2,Taxable,StockQuantity,SellByStock,ItemStatus,DisplayOrder,Featured,SoftwareDownload,SoftwareAttachment,DaysAvailable,DownloadLocation,DistributorID,ItemClassID,UseMatrix,RProSID,rdi_date_removed,fldShipByWeight,fldShipWeight,fldShipAmount,fldHandAmount,fldOversize,fldShipCode,Deleted,DateCreated,DateUpdated,UpdatedBy,Volume,QB,QB_ACCNT,QB_ASSETACCNT,QB_COGSACCNT,QB_SALESTAXCODE,QB_PREFVEND,QB_SUBITEM,QB_REORDERPOINT,QB_PAYMETH,QB_TAXVEND) VALUES('33','1','7989901','1236B002','Canon EOS Digital Rebel XTi 10.1-Megapixel Digital SLR Camera','<span class="midblack"><span class="vbigblackbold"><strong><font size="4">Incredibly Advanced. Remarkably Simple.<br />
</font></strong></span>The Canon EOS Digital Rebel XTi offers an unbeatable combination of performance, ease-of-use and value. It has a newly designed 10.1 MP Canon CMOS sensor plus a host of new features including a 2.5-inch LCD monitor, the exclusive EOS Integrated Cleaning System featuring a Self Cleaning Sensor and Canon''s Picture Style technology, all in a lightweight, ergonomic body. The Digital Rebel XTi is proof positive that Canon continues to lead the way with their phenomenal digital SLRs.</span>','<table cellspacing="0" cellpadding="0" width="300" border="0">
    <tbody>
        <tr>
            <td valign="top" width="10"><img height="5" alt="" width="5" border="0" src="http://images.bestbuy.com/BestBuy_US/images/global/misc/misc_bullet_ccccff.gif" /></td>
            <td width="5">&nbsp;</td>
            <td width="280">0.2-second start-up time, so you never miss a shot; shutter release lag of 0.01 sec.</td>
            <td width="5"><SCRIPT>wS(''5'',''1'')</SCRIPT><img height="1" alt="" width="5" border="0" src="http://images.bestbuy.com/BestBuy_US/images/global/misc/spacer.gif" /><br />
            </td>
        </tr>
        <tr>
            <td colspan="4"><SCRIPT>wS(''1'',''5'')</SCRIPT><img height="5" alt="" width="1" border="0" src="http://images.bestbuy.com/BestBuy_US/images/global/misc/spacer.gif" /><br />
            </td>
        </tr>
        <tr>
            <td valign="top" width="10"><SCRIPT>wS(''5'',''4'')</SCRIPT><img height="4" alt="" width="5" border="0" src="http://images.bestbuy.com/BestBuy_US/images/global/misc/spacer.gif" /><br />
            <img height="5" alt="" width="5" border="0" src="http://images.bestbuy.com/BestBuy_US/images/global/misc/misc_bullet_ccccff.gif" /></td>
            <td width="5">&nbsp;</td>
            <td width="280">DIGIC II image processor for precise, natural color and accurate white balance in varying lighting situations; sophisticated signal-processing algorithms for fast image capture and processing and low energy consumption</td>
            <td width="5"><SCRIPT>wS(''5'',''1'')</SCRIPT><img height="1" alt="" width="5" border="0" src="http://images.bestbuy.com/BestBuy_US/images/global/misc/spacer.gif" /><br />
            </td>
        </tr>
        <tr>
            <td colspan="4"><SCRIPT>wS(''1'',''5'')</SCRIPT><img height="5" alt="" width="1" border="0" src="http://images.bestbuy.com/BestBuy_US/images/global/misc/spacer.gif" /><br />
            </td>
        </tr>
        <tr>
            <td valign="top" width="10"><SCRIPT>wS(''5'',''4'')</SCRIPT><img height="4" alt="" width="5" border="0" src="http://images.bestbuy.com/BestBuy_US/images/global/misc/spacer.gif" /><br />
            <img height="5" alt="" width="5" border="0" src="http://images.bestbuy.com/BestBuy_US/images/global/misc/misc_bullet_ccccff.gif" /></td>
            <td width="5">&nbsp;</td>
            <td width="280">Picture style settings include standard, landscape, portrait, neutral, faithful and monochrome; contrast, sharpening, color saturation and color tone for creative images</td>
            <td width="5"><SCRIPT>wS(''5'',''1'')</SCRIPT><img height="1" alt="" width="5" border="0" src="http://images.bestbuy.com/BestBuy_US/images/global/misc/spacer.gif" /><br />
            </td>
        </tr>
        <tr>
            <td colspan="4"><SCRIPT>wS(''1'',''5'')</SCRIPT><img height="5" alt="" width="1" border="0" src="http://images.bestbuy.com/BestBuy_US/images/global/misc/spacer.gif" /><br />
            </td>
        </tr>
        <tr>
            <td valign="top" width="10"><SCRIPT>wS(''5'',''4'')</SCRIPT><img height="4" alt="" width="5" border="0" src="http://images.bestbuy.com/BestBuy_US/images/global/misc/spacer.gif" /><br />
            <img height="5" alt="" width="5" border="0" src="http://images.bestbuy.com/BestBuy_US/images/global/misc/misc_bullet_ccccff.gif" /></td>
            <td width="5">&nbsp;</td>
            <td width="280">Auto and manual exposure modes; program (full auto, portrait, landscape, close-up, sports, night portrait, flash off), shutter- and aperture-priority and depth-of-field AE</td>
            <td width="5"><SCRIPT>wS(''5'',''1'')</SCRIPT><img height="1" alt="" width="5" border="0" src="http://images.bestbuy.com/BestBuy_US/images/global/misc/spacer.gif" /><br />
            </td>
        </tr>
        <tr>
            <td colspan="4"><SCRIPT>wS(''1'',''5'')</SCRIPT><img height="5" alt="" width="1" border="0" src="http://images.bestbuy.com/BestBuy_US/images/global/misc/spacer.gif" /><br />
            </td>
        </tr>
        <tr>
            <td valign="top" width="10"><SCRIPT>wS(''5'',''4'')</SCRIPT><img height="4" alt="" width="5" border="0" src="http://images.bestbuy.com/BestBuy_US/images/global/misc/spacer.gif" /><br />
            <img height="5" alt="" width="5" border="0" src="http://images.bestbuy.com/BestBuy_US/images/global/misc/misc_bullet_ccccff.gif" /></td>
            <td width="5">&nbsp;</td>
            <td width="280">9-point, cross-pattern, wide-area autofocus with auto and manual point selection; modes include one-shot, AI servo and AI focus</td>
            <td width="5"><SCRIPT>wS(''5'',''1'')</SCRIPT><img height="1" alt="" width="5" border="0" src="http://images.bestbuy.com/BestBuy_US/images/global/misc/spacer.gif" /><br />
            </td>
        </tr>
        <tr>
            <td colspan="4"><SCRIPT>wS(''1'',''5'')</SCRIPT><img height="5" alt="" width="1" border="0" src="http://images.bestbuy.com/BestBuy_US/images/global/misc/spacer.gif" /><br />
            </td>
        </tr>
        <tr>
            <td valign="top" width="10"><SCRIPT>wS(''5'',''4'')</SCRIPT><img height="4" alt="" width="5" border="0" src="http://images.bestbuy.com/BestBuy_US/images/global/misc/spacer.gif" /><br />
            <img height="5" alt="" width="5" border="0" src="http://images.bestbuy.com/BestBuy_US/images/global/misc/misc_bullet_ccccff.gif" /></td>
            <td width="5">&nbsp;</td>
            <td width="280">AE lock, standard auto exposure bracketing; 35-zone evaluative, partial and center-weighted average exposure</td>
            <td width="5"><SCRIPT>wS(''5'',''1'')</SCRIPT><img height="1" alt="" width="5" border="0" src="http://images.bestbuy.com/BestBuy_US/images/global/misc/spacer.gif" /><br />
            </td>
        </tr>
        <tr>
            <td colspan="4"><SCRIPT>wS(''1'',''5'')</SCRIPT><img height="5" alt="" width="1" border="0" src="http://images.bestbuy.com/BestBuy_US/images/global/misc/spacer.gif" /><br />
            </td>
        </tr>
        <tr>
            <td valign="top" width="10"><SCRIPT>wS(''5'',''4'')</SCRIPT><img height="4" alt="" width="5" border="0" src="http://images.bestbuy.com/BestBuy_US/images/global/misc/spacer.gif" /><br />
            <img height="5" alt="" width="5" border="0" src="http://images.bestbuy.com/BestBuy_US/images/global/misc/misc_bullet_ccccff.gif" /></td>
            <td width="5">&nbsp;</td>
            <td width="280">3 fps continuous shooting with a maximum burst of 27 frames</td>
            <td width="5"><SCRIPT>wS(''5'',''1'')</SCRIPT><img height="1" alt="" width="5" border="0" src="http://images.bestbuy.com/BestBuy_US/images/global/misc/spacer.gif" /><br />
            </td>
        </tr>
        <tr>
            <td colspan="4"><SCRIPT>wS(''1'',''5'')</SCRIPT><img height="5" alt="" width="1" border="0" src="http://images.bestbuy.com/BestBuy_US/images/global/misc/spacer.gif" /><br />
            </td>
        </tr>
        <tr>
            <td valign="top" width="10"><SCRIPT>wS(''5'',''4'')</SCRIPT><img height="4" alt="" width="5" border="0" src="http://images.bestbuy.com/BestBuy_US/images/global/misc/spacer.gif" /><br />
            <img height="5" alt="" width="5" border="0" src="http://images.bestbuy.com/BestBuy_US/images/global/misc/misc_bullet_ccccff.gif" /></td>
            <td width="5">&nbsp;</td>
            <td width="280">White balance settings include auto, daylight, shade, cloudy, tungsten, fluorescent, flash and manual; built-in, pop-up E-TTL II auto flash; compatible with EX-series Speedlite external flashes</td>
            <td width="5"><SCRIPT>wS(''5'',''1'')</SCRIPT><img height="1" alt="" width="5" border="0" src="http://images.bestbuy.com/BestBuy_US/images/global/misc/spacer.gif" /><br />
            </td>
        </tr>
        <tr>
            <td colspan="4"><SCRIPT>wS(''1'',''5'')</SCRIPT><img height="5" alt="" width="1" border="0" src="http://images.bestbuy.com/BestBuy_US/images/global/misc/spacer.gif" /><br />
            </td>
        </tr>
        <tr>
            <td valign="top" width="10"><SCRIPT>wS(''5'',''4'')</SCRIPT><img height="4" alt="" width="5" border="0" src="http://images.bestbuy.com/BestBuy_US/images/global/misc/spacer.gif" /><br />
            <img height="5" alt="" width="5" border="0" src="http://images.bestbuy.com/BestBuy_US/images/global/misc/misc_bullet_ccccff.gif" /></td>
            <td width="5">&nbsp;</td>
            <td width="280">CompactFlash card slot supports CompactFlash Type I/II cards (media not included)<br />
            &gt;&gt; <strong>Store more photos!</strong> Find compatible memory cards in our <a href="javascript:popUpRawURL(''http://bestbuy.upgradebase.com'','''',''6'',''1'');">Memory Center</a>!</td>
            <td width="5"><SCRIPT>wS(''5'',''1'')</SCRIPT><img height="1" alt="" width="5" border="0" src="http://images.bestbuy.com/BestBuy_US/images/global/misc/spacer.gif" /><br />
            </td>
        </tr>
        <tr>
            <td colspan="4"><SCRIPT>wS(''1'',''5'')</SCRIPT><img height="5" alt="" width="1" border="0" src="http://images.bestbuy.com/BestBuy_US/images/global/misc/spacer.gif" /><br />
            </td>
        </tr>
        <tr>
            <td valign="top" width="10"><SCRIPT>wS(''5'',''4'')</SCRIPT><img height="4" alt="" width="5" border="0" src="http://images.bestbuy.com/BestBuy_US/images/global/misc/spacer.gif" /><br />
            <img height="5" alt="" width="5" border="0" src="http://images.bestbuy.com/BestBuy_US/images/global/misc/misc_bullet_ccccff.gif" /></td>
            <td width="5">&nbsp;</td>
            <td width="280">Playback modes include single image, 9-image index, magnified zoom, auto play and auto play after shooting</td>
            <td width="5"><SCRIPT>wS(''5'',''1'')</SCRIPT><img height="1" alt="" width="5" border="0" src="http://images.bestbuy.com/BestBuy_US/images/global/misc/spacer.gif" /><br />
            </td>
        </tr>
        <tr>
            <td colspan="4"><SCRIPT>wS(''1'',''5'')</SCRIPT><img height="5" alt="" width="1" border="0" src="http://images.bestbuy.com/BestBuy_US/images/global/misc/spacer.gif" /><br />
            </td>
        </tr>
        <tr>
            <td valign="top" width="10"><SCRIPT>wS(''5'',''4'')</SCRIPT><img height="4" alt="" width="5" border="0" src="http://images.bestbuy.com/BestBuy_US/images/global/misc/spacer.gif" /><br />
            <img height="5" alt="" width="5" border="0" src="http://images.bestbuy.com/BestBuy_US/images/global/misc/misc_bullet_ccccff.gif" /></td>
            <td width="5">&nbsp;</td>
            <td width="280">USB 2.0 interface and A/V outputs; direct-print support with a compatible Canon direct photo printer or any PictBridge-enabled printer (not included), to print photos without a PC</td>
            <td width="5"><SCRIPT>wS(''5'',''1'')</SCRIPT><img height="1" alt="" width="5" border="0" src="http://images.bestbuy.com/BestBuy_US/images/global/misc/spacer.gif" /><br />
            </td>
        </tr>
        <tr>
            <td colspan="4"><SCRIPT>wS(''1'',''5'')</SCRIPT><img height="5" alt="" width="1" border="0" src="http://images.bestbuy.com/BestBuy_US/images/global/misc/spacer.gif" /><br />
            </td>
        </tr>
        <tr>
            <td valign="top" width="10"><SCRIPT>wS(''5'',''4'')</SCRIPT><img height="4" alt="" width="5" border="0" src="http://images.bestbuy.com/BestBuy_US/images/global/misc/spacer.gif" /><br />
            <img height="5" alt="" width="5" border="0" src="http://images.bestbuy.com/BestBuy_US/images/global/misc/misc_bullet_ccccff.gif" /></td>
            <td width="5">&nbsp;</td>
            <td width="280">Compact, lightweight design weighs 1.1 lbs.</td>
            <td width="5"><SCRIPT>wS(''5'',''1'')</SCRIPT><img height="1" alt="" width="5" border="0" src="http://images.bestbuy.com/BestBuy_US/images/global/misc/spacer.gif" /><br />
            </td>
        </tr>
        <tr>
            <td colspan="4"><SCRIPT>wS(''1'',''5'')</SCRIPT><img height="5" alt="" width="1" border="0" src="http://images.bestbuy.com/BestBuy_US/images/global/misc/spacer.gif" /><br />
            </td>
        </tr>
        <tr>
            <td valign="top" width="10"><SCRIPT>wS(''5'',''4'')</SCRIPT><img height="4" alt="" width="5" border="0" src="http://images.bestbuy.com/BestBuy_US/images/global/misc/spacer.gif" /><br />
            <img height="5" alt="" width="5" border="0" src="http://images.bestbuy.com/BestBuy_US/images/global/misc/misc_bullet_ccccff.gif" /></td>
            <td width="5">&nbsp;</td>
            <td width="280">Auto power off turns the camera off after a selectable period of inactivity up to 30 minutes, conserving battery power</td>
        </tr>
    </tbody>
</table>',NULL,NULL,'21','X,28,19,X','7','X,4,X','4','products','7989901.jpg','7989901_rc.jpg','7989901_ra.jpg','7989901_ba.jpg','7989901cv1a.jpg',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,0,0,0,0,11,10,10,4,720,899.99,0,854.99,819,0,0,1,'200',1,'IS','1',1,NULL,NULL,NULL,NULL,'2',NULL,0,NULL,NULL,1,11,5,25,0,'987',0,'2007-3-29 10:11:0','2007-3-29 9:20:0','ADMIN',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
IF (IDENT_SEED('dbo.Products') IS NOT NULL )	SET IDENTITY_INSERT dbo.Products OFF
GO
GO
ALTER TABLE dbo.Products CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.ProductSpecs
-----------------------------------------------------------
ALTER TABLE dbo.ProductSpecs NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.ProductSpecs
GO

IF (IDENT_SEED('dbo.ProductSpecs') IS NOT NULL )	SET IDENTITY_INSERT dbo.ProductSpecs ON
INSERT INTO dbo.ProductSpecs (SpecID,ItemID,ProductType,Spec1,Spec2,Spec3,Spec4,Spec5,Spec6,Spec7,Spec8,Spec9,Spec10,Spec11,Spec12,Spec13,Spec14,Spec15,Spec16,Spec17,Spec18,Spec19,Spec20) VALUES('1','11','1','7.2 Megapixel','1/1.8-inch','3x','2x','6x','2.5-inch','1/8 - 1/2000 sec.','30 fps','32MB Memory Stick Duo','Memory Stick or Memory Stick Pro',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.ProductSpecs (SpecID,ItemID,ProductType,Spec1,Spec2,Spec3,Spec4,Spec5,Spec6,Spec7,Spec8,Spec9,Spec10,Spec11,Spec12,Spec13,Spec14,Spec15,Spec16,Spec17,Spec18,Spec19,Spec20) VALUES('2','23','1',NULL,NULL,'4x','10x','10x','yes','1/1000','mpg','16MB','CompactFlash',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
IF (IDENT_SEED('dbo.ProductSpecs') IS NOT NULL )	SET IDENTITY_INSERT dbo.ProductSpecs OFF
GO
GO
ALTER TABLE dbo.ProductSpecs CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.ProductTypes
-----------------------------------------------------------
ALTER TABLE dbo.ProductTypes NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.ProductTypes
GO

IF (IDENT_SEED('dbo.ProductTypes') IS NOT NULL )	SET IDENTITY_INSERT dbo.ProductTypes ON
INSERT INTO dbo.ProductTypes (TypeID,TypeName,SpecCount,SpecTitle1,SpecTitle2,SpecTitle3,SpecTitle4,SpecTitle5,SpecTitle6,SpecTitle7,SpecTitle8,SpecTitle9,SpecTitle10,SpecTitle11,SpecTitle12,SpecTitle13,SpecTitle14,SpecTitle15,SpecTitle16,SpecTitle17,SpecTitle18,SpecTitle19,SpecTitle20) VALUES('1','Point & Shoot','10','Sensor','Size','Optical Zoom','Digital Zoom','Combined Zoom','LCD Monitor','Shutter Speed','Movie Mode','Memory Included','Storage Media',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.ProductTypes (TypeID,TypeName,SpecCount,SpecTitle1,SpecTitle2,SpecTitle3,SpecTitle4,SpecTitle5,SpecTitle6,SpecTitle7,SpecTitle8,SpecTitle9,SpecTitle10,SpecTitle11,SpecTitle12,SpecTitle13,SpecTitle14,SpecTitle15,SpecTitle16,SpecTitle17,SpecTitle18,SpecTitle19,SpecTitle20) VALUES('3','Ultra Compact','0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
INSERT INTO dbo.ProductTypes (TypeID,TypeName,SpecCount,SpecTitle1,SpecTitle2,SpecTitle3,SpecTitle4,SpecTitle5,SpecTitle6,SpecTitle7,SpecTitle8,SpecTitle9,SpecTitle10,SpecTitle11,SpecTitle12,SpecTitle13,SpecTitle14,SpecTitle15,SpecTitle16,SpecTitle17,SpecTitle18,SpecTitle19,SpecTitle20) VALUES('4','Advanced','0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
IF (IDENT_SEED('dbo.ProductTypes') IS NOT NULL )	SET IDENTITY_INSERT dbo.ProductTypes OFF
GO
GO
ALTER TABLE dbo.ProductTypes CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.RDI_Items
-----------------------------------------------------------
ALTER TABLE dbo.RDI_Items NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.RDI_Items
GO

IF (IDENT_SEED('dbo.RDI_Items') IS NOT NULL )	SET IDENTITY_INSERT dbo.RDI_Items ON
IF (IDENT_SEED('dbo.RDI_Items') IS NOT NULL )	SET IDENTITY_INSERT dbo.RDI_Items OFF
GO
GO
ALTER TABLE dbo.RDI_Items CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.RDI_Prefs_Scales
-----------------------------------------------------------
ALTER TABLE dbo.RDI_Prefs_Scales NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.RDI_Prefs_Scales
GO

IF (IDENT_SEED('dbo.RDI_Prefs_Scales') IS NOT NULL )	SET IDENTITY_INSERT dbo.RDI_Prefs_Scales ON
IF (IDENT_SEED('dbo.RDI_Prefs_Scales') IS NOT NULL )	SET IDENTITY_INSERT dbo.RDI_Prefs_Scales OFF
GO
GO
ALTER TABLE dbo.RDI_Prefs_Scales CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.RelatedItems
-----------------------------------------------------------
ALTER TABLE dbo.RelatedItems NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.RelatedItems
GO

IF (IDENT_SEED('dbo.RelatedItems') IS NOT NULL )	SET IDENTITY_INSERT dbo.RelatedItems ON
INSERT INTO dbo.RelatedItems (RelatedID,ItemID,RelatedItemID,RelatedType,DateCreated,DateUpdated,UpdatedBy) VALUES('1','2','3',NULL,'2005-12-4 20:18:0',NULL,NULL)
INSERT INTO dbo.RelatedItems (RelatedID,ItemID,RelatedItemID,RelatedType,DateCreated,DateUpdated,UpdatedBy) VALUES('2','30','31',NULL,'2005-12-4 21:41:0','2007-3-28 16:30:0','ADMIN')
INSERT INTO dbo.RelatedItems (RelatedID,ItemID,RelatedItemID,RelatedType,DateCreated,DateUpdated,UpdatedBy) VALUES('4','30','29',NULL,'2007-3-28 17:31:0','2007-3-28 16:31:0','ADMIN')
INSERT INTO dbo.RelatedItems (RelatedID,ItemID,RelatedItemID,RelatedType,DateCreated,DateUpdated,UpdatedBy) VALUES('7','33','30',NULL,'2007-3-29 10:21:0','2007-3-29 9:21:0','ADMIN')
INSERT INTO dbo.RelatedItems (RelatedID,ItemID,RelatedItemID,RelatedType,DateCreated,DateUpdated,UpdatedBy) VALUES('8','33','31',NULL,'2007-3-29 10:21:0','2007-3-29 9:21:0','ADMIN')
IF (IDENT_SEED('dbo.RelatedItems') IS NOT NULL )	SET IDENTITY_INSERT dbo.RelatedItems OFF
GO
GO
ALTER TABLE dbo.RelatedItems CHECK CONSTRAINT ALL
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
--Insert data into dbo.RPro_In_Catalog
-----------------------------------------------------------
ALTER TABLE dbo.RPro_In_Catalog NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.RPro_In_Catalog
GO

IF (IDENT_SEED('dbo.RPro_In_Catalog') IS NOT NULL )	SET IDENTITY_INSERT dbo.RPro_In_Catalog ON
IF (IDENT_SEED('dbo.RPro_In_Catalog') IS NOT NULL )	SET IDENTITY_INSERT dbo.RPro_In_Catalog OFF
GO
GO
ALTER TABLE dbo.RPro_In_Catalog CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.RPro_In_Catalog_log
-----------------------------------------------------------
ALTER TABLE dbo.RPro_In_Catalog_log NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.RPro_In_Catalog_log
GO

IF (IDENT_SEED('dbo.RPro_In_Catalog_log') IS NOT NULL )	SET IDENTITY_INSERT dbo.RPro_In_Catalog_log ON
IF (IDENT_SEED('dbo.RPro_In_Catalog_log') IS NOT NULL )	SET IDENTITY_INSERT dbo.RPro_In_Catalog_log OFF
GO
GO
ALTER TABLE dbo.RPro_In_Catalog_log CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.RPro_In_Customers
-----------------------------------------------------------
ALTER TABLE dbo.RPro_In_Customers NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.RPro_In_Customers
GO

IF (IDENT_SEED('dbo.RPro_In_Customers') IS NOT NULL )	SET IDENTITY_INSERT dbo.RPro_In_Customers ON
IF (IDENT_SEED('dbo.RPro_In_Customers') IS NOT NULL )	SET IDENTITY_INSERT dbo.RPro_In_Customers OFF
GO
GO
ALTER TABLE dbo.RPro_In_Customers CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.RPro_in_Customers_log
-----------------------------------------------------------
ALTER TABLE dbo.RPro_in_Customers_log NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.RPro_in_Customers_log
GO

IF (IDENT_SEED('dbo.RPro_in_Customers_log') IS NOT NULL )	SET IDENTITY_INSERT dbo.RPro_in_Customers_log ON
IF (IDENT_SEED('dbo.RPro_in_Customers_log') IS NOT NULL )	SET IDENTITY_INSERT dbo.RPro_in_Customers_log OFF
GO
GO
ALTER TABLE dbo.RPro_in_Customers_log CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.rpro_in_prefs
-----------------------------------------------------------
ALTER TABLE dbo.rpro_in_prefs NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.rpro_in_prefs
GO

IF (IDENT_SEED('dbo.rpro_in_prefs') IS NOT NULL )	SET IDENTITY_INSERT dbo.rpro_in_prefs ON
IF (IDENT_SEED('dbo.rpro_in_prefs') IS NOT NULL )	SET IDENTITY_INSERT dbo.rpro_in_prefs OFF
GO
GO
ALTER TABLE dbo.rpro_in_prefs CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.rpro_in_prefs_DefPriceLevels
-----------------------------------------------------------
ALTER TABLE dbo.rpro_in_prefs_DefPriceLevels NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.rpro_in_prefs_DefPriceLevels
GO

IF (IDENT_SEED('dbo.rpro_in_prefs_DefPriceLevels') IS NOT NULL )	SET IDENTITY_INSERT dbo.rpro_in_prefs_DefPriceLevels ON
IF (IDENT_SEED('dbo.rpro_in_prefs_DefPriceLevels') IS NOT NULL )	SET IDENTITY_INSERT dbo.rpro_in_prefs_DefPriceLevels OFF
GO
GO
ALTER TABLE dbo.rpro_in_prefs_DefPriceLevels CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.rpro_in_prefs_InStockMessages
-----------------------------------------------------------
ALTER TABLE dbo.rpro_in_prefs_InStockMessages NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.rpro_in_prefs_InStockMessages
GO

IF (IDENT_SEED('dbo.rpro_in_prefs_InStockMessages') IS NOT NULL )	SET IDENTITY_INSERT dbo.rpro_in_prefs_InStockMessages ON
IF (IDENT_SEED('dbo.rpro_in_prefs_InStockMessages') IS NOT NULL )	SET IDENTITY_INSERT dbo.rpro_in_prefs_InStockMessages OFF
GO
GO
ALTER TABLE dbo.rpro_in_prefs_InStockMessages CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.rpro_in_prefs_InvenPreferences
-----------------------------------------------------------
ALTER TABLE dbo.rpro_in_prefs_InvenPreferences NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.rpro_in_prefs_InvenPreferences
GO

IF (IDENT_SEED('dbo.rpro_in_prefs_InvenPreferences') IS NOT NULL )	SET IDENTITY_INSERT dbo.rpro_in_prefs_InvenPreferences ON
IF (IDENT_SEED('dbo.rpro_in_prefs_InvenPreferences') IS NOT NULL )	SET IDENTITY_INSERT dbo.rpro_in_prefs_InvenPreferences OFF
GO
GO
ALTER TABLE dbo.rpro_in_prefs_InvenPreferences CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.rpro_in_prefs_OrderStatuses
-----------------------------------------------------------
ALTER TABLE dbo.rpro_in_prefs_OrderStatuses NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.rpro_in_prefs_OrderStatuses
GO

IF (IDENT_SEED('dbo.rpro_in_prefs_OrderStatuses') IS NOT NULL )	SET IDENTITY_INSERT dbo.rpro_in_prefs_OrderStatuses ON
IF (IDENT_SEED('dbo.rpro_in_prefs_OrderStatuses') IS NOT NULL )	SET IDENTITY_INSERT dbo.rpro_in_prefs_OrderStatuses OFF
GO
GO
ALTER TABLE dbo.rpro_in_prefs_OrderStatuses CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.rpro_in_prefs_OutOfStockMessages
-----------------------------------------------------------
ALTER TABLE dbo.rpro_in_prefs_OutOfStockMessages NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.rpro_in_prefs_OutOfStockMessages
GO

IF (IDENT_SEED('dbo.rpro_in_prefs_OutOfStockMessages') IS NOT NULL )	SET IDENTITY_INSERT dbo.rpro_in_prefs_OutOfStockMessages ON
IF (IDENT_SEED('dbo.rpro_in_prefs_OutOfStockMessages') IS NOT NULL )	SET IDENTITY_INSERT dbo.rpro_in_prefs_OutOfStockMessages OFF
GO
GO
ALTER TABLE dbo.rpro_in_prefs_OutOfStockMessages CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.rpro_in_prefs_ProdAvailability
-----------------------------------------------------------
ALTER TABLE dbo.rpro_in_prefs_ProdAvailability NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.rpro_in_prefs_ProdAvailability
GO

IF (IDENT_SEED('dbo.rpro_in_prefs_ProdAvailability') IS NOT NULL )	SET IDENTITY_INSERT dbo.rpro_in_prefs_ProdAvailability ON
IF (IDENT_SEED('dbo.rpro_in_prefs_ProdAvailability') IS NOT NULL )	SET IDENTITY_INSERT dbo.rpro_in_prefs_ProdAvailability OFF
GO
GO
ALTER TABLE dbo.rpro_in_prefs_ProdAvailability CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.rpro_in_prefs_QtySource
-----------------------------------------------------------
ALTER TABLE dbo.rpro_in_prefs_QtySource NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.rpro_in_prefs_QtySource
GO

IF (IDENT_SEED('dbo.rpro_in_prefs_QtySource') IS NOT NULL )	SET IDENTITY_INSERT dbo.rpro_in_prefs_QtySource ON
IF (IDENT_SEED('dbo.rpro_in_prefs_QtySource') IS NOT NULL )	SET IDENTITY_INSERT dbo.rpro_in_prefs_QtySource OFF
GO
GO
ALTER TABLE dbo.rpro_in_prefs_QtySource CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.rpro_in_prefs_Scales
-----------------------------------------------------------
ALTER TABLE dbo.rpro_in_prefs_Scales NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.rpro_in_prefs_Scales
GO

IF (IDENT_SEED('dbo.rpro_in_prefs_Scales') IS NOT NULL )	SET IDENTITY_INSERT dbo.rpro_in_prefs_Scales ON
IF (IDENT_SEED('dbo.rpro_in_prefs_Scales') IS NOT NULL )	SET IDENTITY_INSERT dbo.rpro_in_prefs_Scales OFF
GO
GO
ALTER TABLE dbo.rpro_in_prefs_Scales CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.rpro_in_prefs_ShippingWeightTable
-----------------------------------------------------------
ALTER TABLE dbo.rpro_in_prefs_ShippingWeightTable NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.rpro_in_prefs_ShippingWeightTable
GO

IF (IDENT_SEED('dbo.rpro_in_prefs_ShippingWeightTable') IS NOT NULL )	SET IDENTITY_INSERT dbo.rpro_in_prefs_ShippingWeightTable ON
IF (IDENT_SEED('dbo.rpro_in_prefs_ShippingWeightTable') IS NOT NULL )	SET IDENTITY_INSERT dbo.rpro_in_prefs_ShippingWeightTable OFF
GO
GO
ALTER TABLE dbo.rpro_in_prefs_ShippingWeightTable CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.rpro_in_prefs_ShipProviders
-----------------------------------------------------------
ALTER TABLE dbo.rpro_in_prefs_ShipProviders NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.rpro_in_prefs_ShipProviders
GO

IF (IDENT_SEED('dbo.rpro_in_prefs_ShipProviders') IS NOT NULL )	SET IDENTITY_INSERT dbo.rpro_in_prefs_ShipProviders ON
IF (IDENT_SEED('dbo.rpro_in_prefs_ShipProviders') IS NOT NULL )	SET IDENTITY_INSERT dbo.rpro_in_prefs_ShipProviders OFF
GO
GO
ALTER TABLE dbo.rpro_in_prefs_ShipProviders CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.rpro_in_prefs_ShipUnits
-----------------------------------------------------------
ALTER TABLE dbo.rpro_in_prefs_ShipUnits NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.rpro_in_prefs_ShipUnits
GO

IF (IDENT_SEED('dbo.rpro_in_prefs_ShipUnits') IS NOT NULL )	SET IDENTITY_INSERT dbo.rpro_in_prefs_ShipUnits ON
IF (IDENT_SEED('dbo.rpro_in_prefs_ShipUnits') IS NOT NULL )	SET IDENTITY_INSERT dbo.rpro_in_prefs_ShipUnits OFF
GO
GO
ALTER TABLE dbo.rpro_in_prefs_ShipUnits CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.rpro_in_prefs_TaxAreas
-----------------------------------------------------------
ALTER TABLE dbo.rpro_in_prefs_TaxAreas NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.rpro_in_prefs_TaxAreas
GO

IF (IDENT_SEED('dbo.rpro_in_prefs_TaxAreas') IS NOT NULL )	SET IDENTITY_INSERT dbo.rpro_in_prefs_TaxAreas ON
IF (IDENT_SEED('dbo.rpro_in_prefs_TaxAreas') IS NOT NULL )	SET IDENTITY_INSERT dbo.rpro_in_prefs_TaxAreas OFF
GO
GO
ALTER TABLE dbo.rpro_in_prefs_TaxAreas CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.rpro_in_prefs_TaxCodes
-----------------------------------------------------------
ALTER TABLE dbo.rpro_in_prefs_TaxCodes NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.rpro_in_prefs_TaxCodes
GO

IF (IDENT_SEED('dbo.rpro_in_prefs_TaxCodes') IS NOT NULL )	SET IDENTITY_INSERT dbo.rpro_in_prefs_TaxCodes ON
IF (IDENT_SEED('dbo.rpro_in_prefs_TaxCodes') IS NOT NULL )	SET IDENTITY_INSERT dbo.rpro_in_prefs_TaxCodes OFF
GO
GO
ALTER TABLE dbo.rpro_in_prefs_TaxCodes CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.RPro_In_Receipts
-----------------------------------------------------------
ALTER TABLE dbo.RPro_In_Receipts NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.RPro_In_Receipts
GO

IF (IDENT_SEED('dbo.RPro_In_Receipts') IS NOT NULL )	SET IDENTITY_INSERT dbo.RPro_In_Receipts ON
IF (IDENT_SEED('dbo.RPro_In_Receipts') IS NOT NULL )	SET IDENTITY_INSERT dbo.RPro_In_Receipts OFF
GO
GO
ALTER TABLE dbo.RPro_In_Receipts CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.RPro_In_SO
-----------------------------------------------------------
ALTER TABLE dbo.RPro_In_SO NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.RPro_In_SO
GO

IF (IDENT_SEED('dbo.RPro_In_SO') IS NOT NULL )	SET IDENTITY_INSERT dbo.RPro_In_SO ON
IF (IDENT_SEED('dbo.RPro_In_SO') IS NOT NULL )	SET IDENTITY_INSERT dbo.RPro_In_SO OFF
GO
GO
ALTER TABLE dbo.RPro_In_SO CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.RPro_in_SO_log
-----------------------------------------------------------
ALTER TABLE dbo.RPro_in_SO_log NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.RPro_in_SO_log
GO

IF (IDENT_SEED('dbo.RPro_in_SO_log') IS NOT NULL )	SET IDENTITY_INSERT dbo.RPro_in_SO_log ON
IF (IDENT_SEED('dbo.RPro_in_SO_log') IS NOT NULL )	SET IDENTITY_INSERT dbo.RPro_in_SO_log OFF
GO
GO
ALTER TABLE dbo.RPro_in_SO_log CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.Rpro_In_Styles
-----------------------------------------------------------
ALTER TABLE dbo.Rpro_In_Styles NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.Rpro_In_Styles
GO

IF (IDENT_SEED('dbo.Rpro_In_Styles') IS NOT NULL )	SET IDENTITY_INSERT dbo.Rpro_In_Styles ON
IF (IDENT_SEED('dbo.Rpro_In_Styles') IS NOT NULL )	SET IDENTITY_INSERT dbo.Rpro_In_Styles OFF
GO
GO
ALTER TABLE dbo.Rpro_In_Styles CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.RPro_In_Styles_log
-----------------------------------------------------------
ALTER TABLE dbo.RPro_In_Styles_log NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.RPro_In_Styles_log
GO

IF (IDENT_SEED('dbo.RPro_In_Styles_log') IS NOT NULL )	SET IDENTITY_INSERT dbo.RPro_In_Styles_log ON
IF (IDENT_SEED('dbo.RPro_In_Styles_log') IS NOT NULL )	SET IDENTITY_INSERT dbo.RPro_In_Styles_log OFF
GO
GO
ALTER TABLE dbo.RPro_In_Styles_log CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.RPro_in_upsell_item
-----------------------------------------------------------
ALTER TABLE dbo.RPro_in_upsell_item NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.RPro_in_upsell_item
GO

IF (IDENT_SEED('dbo.RPro_in_upsell_item') IS NOT NULL )	SET IDENTITY_INSERT dbo.RPro_in_upsell_item ON
IF (IDENT_SEED('dbo.RPro_in_upsell_item') IS NOT NULL )	SET IDENTITY_INSERT dbo.RPro_in_upsell_item OFF
GO
GO
ALTER TABLE dbo.RPro_in_upsell_item CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.rpro_in_upsell_item_ddd
-----------------------------------------------------------
ALTER TABLE dbo.rpro_in_upsell_item_ddd NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.rpro_in_upsell_item_ddd
GO

IF (IDENT_SEED('dbo.rpro_in_upsell_item_ddd') IS NOT NULL )	SET IDENTITY_INSERT dbo.rpro_in_upsell_item_ddd ON
IF (IDENT_SEED('dbo.rpro_in_upsell_item_ddd') IS NOT NULL )	SET IDENTITY_INSERT dbo.rpro_in_upsell_item_ddd OFF
GO
GO
ALTER TABLE dbo.rpro_in_upsell_item_ddd CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.RPro_Out_Customers
-----------------------------------------------------------
ALTER TABLE dbo.RPro_Out_Customers NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.RPro_Out_Customers
GO

IF (IDENT_SEED('dbo.RPro_Out_Customers') IS NOT NULL )	SET IDENTITY_INSERT dbo.RPro_Out_Customers ON
IF (IDENT_SEED('dbo.RPro_Out_Customers') IS NOT NULL )	SET IDENTITY_INSERT dbo.RPro_Out_Customers OFF
GO
GO
ALTER TABLE dbo.RPro_Out_Customers CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.RPro_Out_Customers_log
-----------------------------------------------------------
ALTER TABLE dbo.RPro_Out_Customers_log NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.RPro_Out_Customers_log
GO

IF (IDENT_SEED('dbo.RPro_Out_Customers_log') IS NOT NULL )	SET IDENTITY_INSERT dbo.RPro_Out_Customers_log ON
IF (IDENT_SEED('dbo.RPro_Out_Customers_log') IS NOT NULL )	SET IDENTITY_INSERT dbo.RPro_Out_Customers_log OFF
GO
GO
ALTER TABLE dbo.RPro_Out_Customers_log CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.RPro_Out_SO
-----------------------------------------------------------
ALTER TABLE dbo.RPro_Out_SO NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.RPro_Out_SO
GO

IF (IDENT_SEED('dbo.RPro_Out_SO') IS NOT NULL )	SET IDENTITY_INSERT dbo.RPro_Out_SO ON
IF (IDENT_SEED('dbo.RPro_Out_SO') IS NOT NULL )	SET IDENTITY_INSERT dbo.RPro_Out_SO OFF
GO
GO
ALTER TABLE dbo.RPro_Out_SO CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.RPro_Out_SO_Items
-----------------------------------------------------------
ALTER TABLE dbo.RPro_Out_SO_Items NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.RPro_Out_SO_Items
GO

IF (IDENT_SEED('dbo.RPro_Out_SO_Items') IS NOT NULL )	SET IDENTITY_INSERT dbo.RPro_Out_SO_Items ON
IF (IDENT_SEED('dbo.RPro_Out_SO_Items') IS NOT NULL )	SET IDENTITY_INSERT dbo.RPro_Out_SO_Items OFF
GO
GO
ALTER TABLE dbo.RPro_Out_SO_Items CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.RPro_Out_SO_Items_log
-----------------------------------------------------------
ALTER TABLE dbo.RPro_Out_SO_Items_log NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.RPro_Out_SO_Items_log
GO

IF (IDENT_SEED('dbo.RPro_Out_SO_Items_log') IS NOT NULL )	SET IDENTITY_INSERT dbo.RPro_Out_SO_Items_log ON
IF (IDENT_SEED('dbo.RPro_Out_SO_Items_log') IS NOT NULL )	SET IDENTITY_INSERT dbo.RPro_Out_SO_Items_log OFF
GO
GO
ALTER TABLE dbo.RPro_Out_SO_Items_log CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.RPro_Out_SO_log
-----------------------------------------------------------
ALTER TABLE dbo.RPro_Out_SO_log NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.RPro_Out_SO_log
GO

IF (IDENT_SEED('dbo.RPro_Out_SO_log') IS NOT NULL )	SET IDENTITY_INSERT dbo.RPro_Out_SO_log ON
IF (IDENT_SEED('dbo.RPro_Out_SO_log') IS NOT NULL )	SET IDENTITY_INSERT dbo.RPro_Out_SO_log OFF
GO
GO
ALTER TABLE dbo.RPro_Out_SO_log CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.Sections
-----------------------------------------------------------
ALTER TABLE dbo.Sections NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.Sections
GO

IF (IDENT_SEED('dbo.Sections') IS NOT NULL )	SET IDENTITY_INSERT dbo.Sections ON
INSERT INTO dbo.Sections (SectionID,SiteID,SecName,SecSummary,SecDescription,SecImage,SecImageDir,SecFeaturedID,SecFeaturedDir,SecBanner,SEKeywords,SEDescription,ShowColumns,ShowRows,DisplayPrefix,SortByLooks,DisplayOrder,CategoryDisplayFormatID,AllowCategoryFiltering,AllowManufacturerFiltering,AllowProductTypeFiltering,Published,Comments,AvailableCats,SubSectionOf,Featured,RProVendorCode,Hide1,Hide2,SecMetaTitle,SecMetaDescription,SecMetaKeywords,SecMetaKeyphrases,Deleted,DateCreated,DateUpdated,UpdatedBy) VALUES('1','1','Camera Type',NULL,NULL,NULL,NULL,NULL,'categories',NULL,NULL,NULL,'3','5',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,0,'2005-4-29 15:53:57','2006-12-9 19:36:37','ADMIN')
INSERT INTO dbo.Sections (SectionID,SiteID,SecName,SecSummary,SecDescription,SecImage,SecImageDir,SecFeaturedID,SecFeaturedDir,SecBanner,SEKeywords,SEDescription,ShowColumns,ShowRows,DisplayPrefix,SortByLooks,DisplayOrder,CategoryDisplayFormatID,AllowCategoryFiltering,AllowManufacturerFiltering,AllowProductTypeFiltering,Published,Comments,AvailableCats,SubSectionOf,Featured,RProVendorCode,Hide1,Hide2,SecMetaTitle,SecMetaDescription,SecMetaKeywords,SecMetaKeyphrases,Deleted,DateCreated,DateUpdated,UpdatedBy) VALUES('2','1','Ultra Compact',NULL,NULL,NULL,NULL,NULL,'categories',NULL,NULL,NULL,'3','5',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1',0,NULL,0,0,NULL,NULL,NULL,NULL,0,'2005-4-29 15:54:32',NULL,'ADMIN')
INSERT INTO dbo.Sections (SectionID,SiteID,SecName,SecSummary,SecDescription,SecImage,SecImageDir,SecFeaturedID,SecFeaturedDir,SecBanner,SEKeywords,SEDescription,ShowColumns,ShowRows,DisplayPrefix,SortByLooks,DisplayOrder,CategoryDisplayFormatID,AllowCategoryFiltering,AllowManufacturerFiltering,AllowProductTypeFiltering,Published,Comments,AvailableCats,SubSectionOf,Featured,RProVendorCode,Hide1,Hide2,SecMetaTitle,SecMetaDescription,SecMetaKeywords,SecMetaKeyphrases,Deleted,DateCreated,DateUpdated,UpdatedBy) VALUES('3','1','Point and Shoot',NULL,NULL,NULL,NULL,NULL,'categories',NULL,NULL,NULL,'3','5',NULL,NULL,'2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1',0,NULL,0,0,NULL,NULL,NULL,NULL,0,'2005-4-29 15:54:50',NULL,'ADMIN')
INSERT INTO dbo.Sections (SectionID,SiteID,SecName,SecSummary,SecDescription,SecImage,SecImageDir,SecFeaturedID,SecFeaturedDir,SecBanner,SEKeywords,SEDescription,ShowColumns,ShowRows,DisplayPrefix,SortByLooks,DisplayOrder,CategoryDisplayFormatID,AllowCategoryFiltering,AllowManufacturerFiltering,AllowProductTypeFiltering,Published,Comments,AvailableCats,SubSectionOf,Featured,RProVendorCode,Hide1,Hide2,SecMetaTitle,SecMetaDescription,SecMetaKeywords,SecMetaKeyphrases,Deleted,DateCreated,DateUpdated,UpdatedBy) VALUES('4','1','Advanced',NULL,NULL,NULL,NULL,NULL,'categories',NULL,NULL,NULL,'3','5',NULL,NULL,'3',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1',0,NULL,0,0,NULL,NULL,NULL,NULL,0,'2005-4-29 15:55:4',NULL,'ADMIN')
INSERT INTO dbo.Sections (SectionID,SiteID,SecName,SecSummary,SecDescription,SecImage,SecImageDir,SecFeaturedID,SecFeaturedDir,SecBanner,SEKeywords,SEDescription,ShowColumns,ShowRows,DisplayPrefix,SortByLooks,DisplayOrder,CategoryDisplayFormatID,AllowCategoryFiltering,AllowManufacturerFiltering,AllowProductTypeFiltering,Published,Comments,AvailableCats,SubSectionOf,Featured,RProVendorCode,Hide1,Hide2,SecMetaTitle,SecMetaDescription,SecMetaKeywords,SecMetaKeyphrases,Deleted,DateCreated,DateUpdated,UpdatedBy) VALUES('5','1','Extended Zoom',NULL,NULL,NULL,NULL,NULL,'categories',NULL,NULL,NULL,'3','5',NULL,NULL,'4',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,0,0,NULL,NULL,NULL,NULL,0,'2005-4-29 15:55:18','2006-12-9 19:45:43','ADMIN')
INSERT INTO dbo.Sections (SectionID,SiteID,SecName,SecSummary,SecDescription,SecImage,SecImageDir,SecFeaturedID,SecFeaturedDir,SecBanner,SEKeywords,SEDescription,ShowColumns,ShowRows,DisplayPrefix,SortByLooks,DisplayOrder,CategoryDisplayFormatID,AllowCategoryFiltering,AllowManufacturerFiltering,AllowProductTypeFiltering,Published,Comments,AvailableCats,SubSectionOf,Featured,RProVendorCode,Hide1,Hide2,SecMetaTitle,SecMetaDescription,SecMetaKeywords,SecMetaKeyphrases,Deleted,DateCreated,DateUpdated,UpdatedBy) VALUES('6','1','All-Weather',NULL,NULL,NULL,NULL,NULL,'categories',NULL,NULL,NULL,'3','5',NULL,NULL,'5',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1',0,NULL,0,0,NULL,NULL,NULL,NULL,0,'2005-4-29 15:55:33',NULL,'ADMIN')
INSERT INTO dbo.Sections (SectionID,SiteID,SecName,SecSummary,SecDescription,SecImage,SecImageDir,SecFeaturedID,SecFeaturedDir,SecBanner,SEKeywords,SEDescription,ShowColumns,ShowRows,DisplayPrefix,SortByLooks,DisplayOrder,CategoryDisplayFormatID,AllowCategoryFiltering,AllowManufacturerFiltering,AllowProductTypeFiltering,Published,Comments,AvailableCats,SubSectionOf,Featured,RProVendorCode,Hide1,Hide2,SecMetaTitle,SecMetaDescription,SecMetaKeywords,SecMetaKeyphrases,Deleted,DateCreated,DateUpdated,UpdatedBy) VALUES('7','1','SLR/Professional',NULL,NULL,NULL,NULL,NULL,'categories',NULL,NULL,NULL,'3','5',NULL,NULL,'6',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1',0,NULL,0,0,NULL,NULL,NULL,NULL,0,'2005-4-29 15:57:5',NULL,'ADMIN')
INSERT INTO dbo.Sections (SectionID,SiteID,SecName,SecSummary,SecDescription,SecImage,SecImageDir,SecFeaturedID,SecFeaturedDir,SecBanner,SEKeywords,SEDescription,ShowColumns,ShowRows,DisplayPrefix,SortByLooks,DisplayOrder,CategoryDisplayFormatID,AllowCategoryFiltering,AllowManufacturerFiltering,AllowProductTypeFiltering,Published,Comments,AvailableCats,SubSectionOf,Featured,RProVendorCode,Hide1,Hide2,SecMetaTitle,SecMetaDescription,SecMetaKeywords,SecMetaKeyphrases,Deleted,DateCreated,DateUpdated,UpdatedBy) VALUES('8','1','Newest Arrivals',NULL,'The Hot Spot for the newest arrivals in digital photography technology.','casio-exilim-exz4u.gif','products','casio-exilim-exz4u.gif','products',NULL,NULL,NULL,'4','5',NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,0,0,NULL,NULL,NULL,NULL,0,'2006-12-9 19:38:48','2006-12-9 19:46:16','ADMIN')
IF (IDENT_SEED('dbo.Sections') IS NOT NULL )	SET IDENTITY_INSERT dbo.Sections OFF
GO
GO
ALTER TABLE dbo.Sections CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.ShippingCodes
-----------------------------------------------------------
ALTER TABLE dbo.ShippingCodes NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.ShippingCodes
GO

IF (IDENT_SEED('dbo.ShippingCodes') IS NOT NULL )	SET IDENTITY_INSERT dbo.ShippingCodes ON
INSERT INTO dbo.ShippingCodes (ShippingCode,ShippingMessage) VALUES('987','White Glove Service')
INSERT INTO dbo.ShippingCodes (ShippingCode,ShippingMessage) VALUES('998','This item is for pickup only.  Please contact us to schedule a pickup.')
INSERT INTO dbo.ShippingCodes (ShippingCode,ShippingMessage) VALUES('999','An item in your cart requires a special shipping rate. We will contact you to discuss the additional shipping rate for this product.')
IF (IDENT_SEED('dbo.ShippingCodes') IS NOT NULL )	SET IDENTITY_INSERT dbo.ShippingCodes OFF
GO
GO
ALTER TABLE dbo.ShippingCodes CHECK CONSTRAINT ALL
GO


-----------------------------------------------------------
--Insert data into dbo.ShippingCompanies
-----------------------------------------------------------
ALTER TABLE dbo.ShippingCompanies NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.ShippingCompanies
GO

IF (IDENT_SEED('dbo.ShippingCompanies') IS NOT NULL )	SET IDENTITY_INSERT dbo.ShippingCompanies ON
INSERT INTO dbo.ShippingCompanies (SCID,SiteID,FedexAccountNum,FedexIdentifier,FedexTestGateway,FedexProdGateway,UPSAccountNum,UPSAccessKey,UPSUserID,UPSPassword,USPSUserID,USPSPassword) VALUES('1','1','281581481','1035396','https://gatewaybeta.fedex.com/GatewayDC','https://','862463','9c077c7c78e6a9ec','rhtraeger','tackle829','174TRADE5223','998YU90SU507')
IF (IDENT_SEED('dbo.ShippingCompanies') IS NOT NULL )	SET IDENTITY_INSERT dbo.ShippingCompanies OFF
GO
GO
ALTER TABLE dbo.ShippingCompanies CHECK CONSTRAINT ALL
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
--Insert data into dbo.USAePay
-----------------------------------------------------------
ALTER TABLE dbo.USAePay NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.USAePay
GO

IF (IDENT_SEED('dbo.USAePay') IS NOT NULL )	SET IDENTITY_INSERT dbo.USAePay ON
IF (IDENT_SEED('dbo.USAePay') IS NOT NULL )	SET IDENTITY_INSERT dbo.USAePay OFF
GO
GO
ALTER TABLE dbo.USAePay CHECK CONSTRAINT ALL
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
--Insert data into dbo.Wishlist
-----------------------------------------------------------
ALTER TABLE dbo.Wishlist NOCHECK CONSTRAINT ALL
GO

TRUNCATE TABLE dbo.Wishlist
GO

IF (IDENT_SEED('dbo.Wishlist') IS NOT NULL )	SET IDENTITY_INSERT dbo.Wishlist ON
INSERT INTO dbo.Wishlist (WishListItemID,SiteID,CustomerID,SessionID,ItemID,Qty,OptionName1,OptionName2,OptionName3,DateEntered,AffiliateID,BackOrdered,UseWholesalePrice) VALUES('3','1',3861230228,NULL,'4','1',NULL,NULL,NULL,'2005-9-17 1:24:0',NULL,0,0)
INSERT INTO dbo.Wishlist (WishListItemID,SiteID,CustomerID,SessionID,ItemID,Qty,OptionName1,OptionName2,OptionName3,DateEntered,AffiliateID,BackOrdered,UseWholesalePrice) VALUES('4','1',3861847459,NULL,'3','1',NULL,NULL,NULL,'2005-9-26 18:25:0',NULL,0,0)
INSERT INTO dbo.Wishlist (WishListItemID,SiteID,CustomerID,SessionID,ItemID,Qty,OptionName1,OptionName2,OptionName3,DateEntered,AffiliateID,BackOrdered,UseWholesalePrice) VALUES('8','1',3912713545,NULL,'23','3',NULL,NULL,NULL,'2007-2-14 11:26:0',NULL,0,0)
INSERT INTO dbo.Wishlist (WishListItemID,SiteID,CustomerID,SessionID,ItemID,Qty,OptionName1,OptionName2,OptionName3,DateEntered,AffiliateID,BackOrdered,UseWholesalePrice) VALUES('13','1',3843586823,NULL,'29','1','Black','Large',NULL,'2007-3-25 14:52:0',NULL,0,0)
INSERT INTO dbo.Wishlist (WishListItemID,SiteID,CustomerID,SessionID,ItemID,Qty,OptionName1,OptionName2,OptionName3,DateEntered,AffiliateID,BackOrdered,UseWholesalePrice) VALUES('14','1',3843586823,NULL,'30','1','Black','Medium',NULL,'2007-3-25 14:52:0',NULL,0,0)
IF (IDENT_SEED('dbo.Wishlist') IS NOT NULL )	SET IDENTITY_INSERT dbo.Wishlist OFF
GO
GO
ALTER TABLE dbo.Wishlist CHECK CONSTRAINT ALL
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
