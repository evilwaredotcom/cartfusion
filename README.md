# CartFusion 4.8
ColdFusion Ecommerce + Shopping Cart on SQL: MSSQL Server, MySQL, Postgres

## Installation

### Database
1. Create a blank database in Microsoft SQL Server, MySQL, or PostgreSQL
2. Use the provided SQL scripts to create the tables, stored procedures, and data for this database
- This is usually handled with the accompanying SQL 2000 Query Analyzer or SQL 2005 Management Studio
- You may see a few warnings about maximum row sizes, but don't worry about them.
3. Make sure to create a SQL username and password for this database.

### ColdFusion
4. Setup a datasource in ColdFusion that connects to this database, something like "CartFusion".
5. Create a CF Mapping
- Logical Path: CartFusion_Core
- Directory Path: C:\<ServerRootFolder>\<YourDomainFolder>\<MappedFolder>
- (for example: C:\Domains\CartFusion.net\CartFusion_Core)

### Files
6. Put all files that are in the "cartfusion.net" folder into your test/live site's primary root folder.  Make sure also to change the name of the "wwwroot" folder to whatever your site's web root folder is.
7. In a code editing program, open the file "_serverSpecificVars.xml.cfm" in folder "CartFusion_Core/4_8_0/_config/", and change these values to fit your company's settings.
8. In a code editing program, open the file "Application.cfm" in folder "wwwroot/admin/" and the one in folder "wwwroot/", and set variables to:
- SoftwareVersion = '4_8_0';
- CoreFolder = '<YourCFMappingLogicalPath>';

### Site
9. In a web browser (on your test or live site), run the administration index.cfm page located at "wwwroot/admin/index.cfm"
- Example 1: http://localhost:8500/wwwroot/CartFusion/wwwroot/admin/index.cfm
- Example 2: http://www.cartfusion.net/admin/index.cfm
10. Sign in with the following administrative information (change these soon after installing):
- Username: admin
- Password: password
11. Click on Configuration in the left navigation panel.
12. Update your configuration variables for the CartFusion site you are using.
13. Start adding categories, sections, distributors, and products…
14. To see the results, run the front end index.cfm page located at "wwwroot/index.cfm"
- Example 1: http://localhost:8500/wwwroot/CartFusion/wwwroot/index.cfm
- Example 2: http://www.cartfusion.net/index.cfm
