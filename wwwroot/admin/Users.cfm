<!--- 
|| MIT LICENSE
|| CartFusion.com
--->

<!--- BEGIN: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<!--- UPDATE USER
<cfif isDefined('Form.UpdateUser.x') AND IsDefined('Form.UID')>
	<cfupdate datasource="#application.dsn#" tablename="Users" 
		formfields="UID, UName, UUserName, UPassword, UMinimum">
	<div align="left" class="cfAdminError"><b>Discount User Updated</b></div>
</cfif>
--->

<!--- ADD USER --->
<cfif isDefined('Form.AddUser')>
	<cfif IsUserInRole('Administrator')>
		<cfscript>
			if ( isDefined('form.UTaxable') )
				Form.UTaxable = 1;
			else
				Form.UTaxable = 0;			
			// REQUIRE SELECTION OF USER IF TO BE COPIED
			if ( Form.NewUserProfile EQ 'CopyUser' AND (NOT isDefined('Form.CopyThisUser') OR Form.CopyThisUser EQ '') )
				ErrorMsg = 1 ;
			
			Form.DateCreated = Now() ;
			Form.DateUpdated = Now() ;
			Form.UpdatedBy = GetAuthUser() ;
		</cfscript>
		
		<cfif isDefined('ErrorMsg') AND ErrorMsg EQ 1 >
			<cfset AdminMsg = 'ERROR: Please select a user profile to be copied.' >
		
		<!--- BEGIN TRANSACTION --->
		<cfelse>
			<cftransaction>
				<!--- CALCULATE NEW UserID (UID) TO ADD TO DATABASE --->
				<cfquery name="getNewUID" datasource="#application.dsn#">
					SELECT	Count (*) AS UIDCount
					FROM	Users
				</cfquery>
				<cfset NewUID = getNewUID.UIDCount + 1 >
			
				<!--- INSERT USER INFORMATION FROM FORM INTO TABLE.USERS --->
				<cfquery name="insertUser" datasource="#application.dsn#">
					INSERT INTO Users
							( UID, UUserName, UPassword, UName, UMinimum, UMinimumFirst, UTaxable, DateCreated, DateUpdated, UpdatedBy )
					VALUES	( #NewUID# , '#Form.UUserName#' , '#Form.UPassword#' , '#Form.UName#' , #Form.UMinimum# , #Form.UMinimumFirst# , 
							  #Form.UTaxable# , #Form.DateCreated# , #Form.DateUpdated# , '#Form.UpdatedBy#' )
				</cfquery>
				
				<!--- ADD BLANK COLUMNS TO TABLES (FILL THEM LATER) --->
				<cfquery name="addColumns" datasource="#application.dsn#">
					ALTER TABLE Products
					ADD Price#NewUID# smallmoney DEFAULT 0

					ALTER TABLE Products
					ADD Hide#NewUID# bit DEFAULT 0

					ALTER TABLE Categories
					ADD Hide#NewUID# bit DEFAULT 0

					ALTER TABLE Sections
					ADD Hide#NewUID# bit DEFAULT 0
				</cfquery>
				
				<!--- IF COPYING DATA FROM AN EXISTING USER --->
				<cfif Form.NewUserProfile EQ 'CopyUser' AND isDefined('Form.CopyThisUser') AND Form.CopyThisUser NEQ '' >
					<cfquery name="copyUser" datasource="#application.dsn#">
						UPDATE	Products
						SET		Price#NewUID# = Price#CopyThisUser#,
								Hide#NewUID# = Hide#CopyThisUser#

						UPDATE	Categories
						SET		Hide#NewUID# = Hide#CopyThisUser#

						UPDATE	Sections
						SET		Hide#NewUID# = Hide#CopyThisUser#
					</cfquery>
				</cfif>
				
				<cfset AdminMsg = 'New User / Price Tier has been added successfully.' >
				<!--- RE-QUERY USERS --->
				<cfinvoke component="#application.Queries#" method="getUsers" returnvariable="getUsers"></cfinvoke>
			</cftransaction>
		</cfif>
		
	<cfelse>			
		<script language="JavaScript">
			{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
		</script>
	</cfif>	
</cfif>

<!--- DELETE USER --->
<cfif isDefined('Form.DeleteUser') AND IsDefined('Form.UID') AND Form.UID NEQ '' >
	<cfif IsUserInRole('Administrator')>
		
		<!--- BEGIN TRANSACTION --->
		<cftransaction>
		
			<!--- INSERT USER INFORMATION FROM FORM INTO TABLE.USERS --->
			<cfquery name="deleteUser" datasource="#application.dsn#">
				DELETE FROM	Users
				WHERE	UID = #Form.UID#
			</cfquery>
			
			<!--- DROP CONSTRAINTS --->			
			<cfquery name="dropConstraintsProductsP" datasource="#application.dsn#">
				DECLARE @defname VARCHAR(100), @cmd VARCHAR(1000)
				SET @defname = 
					(SELECT name 
					FROM sysobjects so JOIN sysconstraints sc
					ON so.id = sc.constid 
					WHERE object_name(so.parent_obj) = 'Products' 
					AND so.xtype = 'D'
					AND sc.colid = 
						(SELECT colid 
						FROM syscolumns 
						WHERE id = object_id('dbo.Products') 
						AND name = 'Price#UID#'
						)
					)
				SET @cmd = 'ALTER TABLE Products DROP CONSTRAINT ' + @defname
				EXEC(@cmd)
			</cfquery>
			
			<cfquery name="dropConstraintsProductsH" datasource="#application.dsn#">
				DECLARE @defname VARCHAR(100), @cmd VARCHAR(1000)
				SET @defname = 
					(SELECT name 
					FROM sysobjects so JOIN sysconstraints sc
					ON so.id = sc.constid 
					WHERE object_name(so.parent_obj) = 'Products' 
					AND so.xtype = 'D'
					AND sc.colid = 
						(SELECT colid 
						FROM syscolumns 
						WHERE id = object_id('dbo.Products') 
						AND name = 'Hide#UID#'
						)
					)
				SET @cmd = 'ALTER TABLE Products DROP CONSTRAINT ' + @defname
				EXEC(@cmd)
			</cfquery>
			
			<cfquery name="dropConstraintsCategories" datasource="#application.dsn#">
				DECLARE @defname VARCHAR(100), @cmd VARCHAR(1000)
				SET @defname = 
					(SELECT name 
					FROM sysobjects so JOIN sysconstraints sc
					ON so.id = sc.constid 
					WHERE object_name(so.parent_obj) = 'Categories' 
					AND so.xtype = 'D'
					AND sc.colid = 
						(SELECT colid 
						FROM syscolumns 
						WHERE id = object_id('dbo.Categories') 
						AND name = 'Hide#UID#'
						)
					)
				SET @cmd = 'ALTER TABLE Categories DROP CONSTRAINT ' + @defname
				EXEC(@cmd)
			</cfquery>

			<cfquery name="dropConstraintsSections" datasource="#application.dsn#">
				DECLARE @defname VARCHAR(100), @cmd VARCHAR(1000)
				SET @defname = 
					(SELECT name 
					FROM sysobjects so JOIN sysconstraints sc
					ON so.id = sc.constid 
					WHERE object_name(so.parent_obj) = 'Sections' 
					AND so.xtype = 'D'
					AND sc.colid = 
						(SELECT colid 
						FROM syscolumns 
						WHERE id = object_id('dbo.Sections') 
						AND name = 'Hide#UID#'
						)
					)
				SET @cmd = 'ALTER TABLE Sections DROP CONSTRAINT ' + @defname
				EXEC(@cmd)
			</cfquery>
			
			<!--- DELETE COLUMNS FROM TABLES --->
			<cfquery name="deleteColumns" datasource="#application.dsn#">
				ALTER TABLE Products
				DROP COLUMN Price#UID#

				ALTER TABLE Products
				DROP COLUMN Hide#UID#

				ALTER TABLE Categories
				DROP COLUMN Hide#UID#

				ALTER TABLE Sections
				DROP COLUMN Hide#UID#
			</cfquery>
			
			<cfset AdminMsg = 'User / Price Tier has been deleted successfully.' >
			
		</cftransaction>
		
	<cfelse>			
		<script language="JavaScript">
			{ alert ("User \"<cfoutput>#GetAuthUser()#</cfoutput>\" is not allowed to perform this administrative action."); }
		</script>
	</cfif>	
</cfif>

<!--- END: DATABASE UPDATES - COMMIT CHANGES ------------------------------------->

<!--- SET DEFAULT PARAMETERS --->
<cfparam name="URL.StartRow" default="1" type="numeric">
<cfparam name="URL.SortOption" default="UID" type="string">
<cfparam name="URL.SortAscending" default="1" type="numeric">
<cfparam name="Form.Field" default="ALL" type="string">
<cfparam name="Form.string" default="" type="string">
<cfset string = Trim(string)>

<!--- BEGIN: SEARCH CRITERIA -------------------------------------------------->
	
<cfquery name="getUsers" datasource="#application.dsn#">	
	SELECT 	*
	FROM 	Users
	ORDER BY
	<cfif isDefined('URL.SortOption')> #URL.SortOption# <cfelse> UID </cfif>
	<cfif SortAscending EQ 1> ASC <cfelse> DESC </cfif>
</cfquery>

<!--- END: SEARCH CRITERIA -------------------------------------------------->

<!--- NEXT N VALUES --->
<cfscript>
	RowsPerPage = 15;
	TotalRows = getUsers.RecordCount;
	EndRow = Min(URL.StartRow + RowsPerPage - 1, TotalRows);
 	StartRowNext = EndRow + 1;
 	StartRowBack = URL.StartRow - RowsPerPage;
</cfscript>

<!--- HEADER --->
<cfscript>
	PageTitle = 'ADD USER / PRICE TIER' ;
</cfscript>
<cfinclude template="LayoutAdminHeader.cfm">
<cfinclude template="AdminBanner.cfm">

<cfoutput>

<table border="0" cellpadding="2" cellspacing="0" width="100%">	
	<tr style="background-color:##65ADF1;">
		<td width="5%"  class="cfAdminHeader1" align="center">&nbsp;</td><!--- ADD/DELETE --->
		<td width="5%"  class="cfAdminHeader1" height="20" class="cfAdminHeader2" align="center" nowrap>ID</td>
		<td width="15%" class="cfAdminHeader1" nowrap>Name / City</td>
		<td width="15%" class="cfAdminHeader1" nowrap>Username</td>
		<td width="15%" class="cfAdminHeader1" nowrap>Password</td>
		<td width="15%" class="cfAdminHeader1" nowrap>Order Minimum</td>
		<td width="15%" class="cfAdminHeader1" nowrap>First Order Minimum</td>
		<td width="10%" class="cfAdminHeader1" align="center" nowrap>Apply Tax</td>
		<td width="5%"  class="cfAdminHeader1" align="center">&nbsp;</td><!--- UPDATE --->
	</tr>
<cfform action="#CGI.SCRIPT_NAME#" method="post">
	<tr>
		<td rowspan="3" align="center">
			<input type="submit" name="AddUser" value="ADD" alt="Add User / Price Tier" class="cfAdminButton">
		</td>
		<td rowspan="3" align="center">TBD</td>
		<td><cfinput type="text" name="UName" size="20" class="cfAdminDefault" required="yes" message="Name Required"></td>
		<td><cfinput type="text" name="UUserName" size="20" class="cfAdminDefault" required="yes" message="Username Required"></td>
		<td><cfinput type="text" name="UPassword" size="20" class="cfAdminDefault" required="yes" message="Password Required"></td>
		<td>$<cfinput type="text" name="UMinimum" size="10" class="cfAdminDefault" required="yes" validate="float" message="Please enter a MINIMUM ORDER value in 99.99 format"></td>
		<td>$<cfinput type="text" name="UMinimumFirst" size="10" class="cfAdminDefault" required="yes" validate="float" message="Please enter a MINIMUM FIRST ORDER value in 99.99 format"></td>
		<td align="center"><input type="checkbox" name="UTaxable" checked ></td>
		<td></td>
	</tr>
	<!--- DIVIDER --->
	<tr><td height="1" colspan="9"><img src="images/image-LineGray.gif" width="100%" height="1"></td></tr>
	<tr>
		<td colspan="9">
			<cfinput type="radio" name="NewUserProfile" value="BlankUser" required="yes" message="Please select whether to create a BLANK user or copy from an EXISTING user.">
			Create blank user profile &nbsp;&nbsp;&nbsp;
			<cfinput type="radio" name="NewUserProfile" value="CopyUser" required="yes" message="Please select whether to create a BLANK user or copy from an EXISTING user.">
			Copy values from this user profile:
			<cfselect query="getUsers" name="CopyThisUser" value="UID" display="UName" class="cfAdminDefault" size="1" >
				<option value="" selected></option>
			</cfselect>
		</td>
	</tr>
	</cfform>
</table>	

<br>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td height="20" class="cfAdminTitle">USERS / PRICE TIERS</td>
	</tr>
</table>

<table border="0" cellpadding="3" cellspacing="0" width="100%">	
	<tr style="background-color:##7DBF0E;">
		<td width="5%" class="cfAdminHeader2" align="center" height="20" >&nbsp;</td><!--- ADD/DELETE --->
		<td width="5%" class="cfAdminHeader2" align="center" nowrap>
			ID
			<a href="#CGI.SCRIPT_NAME#?SortOption=UID&SortAscending=1"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="#CGI.SCRIPT_NAME#?SortOption=UID&SortAscending=0"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td width="15%" class="cfAdminHeader2" nowrap>
			Name / City
			<a href="#CGI.SCRIPT_NAME#?SortOption=UName&SortAscending=1"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="#CGI.SCRIPT_NAME#?SortOption=UName&SortAscending=0"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td width="15%" class="cfAdminHeader2" nowrap>
			Username
			<a href="#CGI.SCRIPT_NAME#?SortOption=UUserName&SortAscending=1"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="#CGI.SCRIPT_NAME#?SortOption=UUserName&SortAscending=0"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td width="15%" class="cfAdminHeader2" nowrap>
			Password
			<a href="#CGI.SCRIPT_NAME#?SortOption=UPassword&SortAscending=1"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="#CGI.SCRIPT_NAME#?SortOption=UPassword&SortAscending=0"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td width="15%" class="cfAdminHeader2" nowrap>
			Order Minimum
			<a href="#CGI.SCRIPT_NAME#?SortOption=UMinimum&SortAscending=1"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="#CGI.SCRIPT_NAME#?SortOption=UMinimum&SortAscending=0"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td width="15%" class="cfAdminHeader2" nowrap>
			First Order Minimum
			<a href="#CGI.SCRIPT_NAME#?SortOption=UMinimumFirst&SortAscending=1"><img src="images/ArrowUpPic.gif" border="0" alt="Ascending"></a>
			<a href="#CGI.SCRIPT_NAME#?SortOption=UMinimumFirst&SortAscending=0"><img src="images/ArrowDownPic.gif" border="0" alt="Descending"></a>
		</td>
		<td width="10%" class="cfAdminHeader2" align="center" nowrap>
			Apply Tax
		</td>
		<td width="5%"  class="cfAdminHeader2" align="center">&nbsp;</td><!--- UPDATE --->
	</tr>
</cfoutput>

<cfoutput query="getUsers" startrow="#StartRow#" maxrows="#RowsPerPage#">
	<cfform action="#CGI.SCRIPT_NAME#?StartRow=#StartRow#&SortOption=#SortOption#&SortAscending=#SortAscending#&field=#field#&string=#string#" method="post">
	<tr>
		<td align="center">
			<input type="submit" name="DeleteUser" value="DELETE" alt="Delete User / Price Tier" class="cfAdminButton"
				onclick="return confirm('Are you sure you want to DELETE THIS USER / PRICE TIER? This is undoable.')">
		</td>
		<td align="center">#UID#</td>
		<cfif isUserInRole('Administrator')>
			<td><cfinput type="text" name="UName" value="#UName#" size="20" class="cfAdminDefault" required="yes" message="Name Required" onchange="updateInfo('#UID#',this.value,'UName','Users');"></td>
			<td><cfinput type="text" name="UUserName" value="#UUserName#" size="20" class="cfAdminDefault" required="yes" message="Username Required" onchange="updateInfo('#UID#',this.value,'UUserName','Users');"></td>
			<td><cfinput type="text" name="UPassword" value="#UPassword#" size="20" class="cfAdminDefault" required="yes" message="Password Required" onchange="updateInfo('#UID#',this.value,'UPassword','Users');"></td>
			<td>$<cfinput type="text" name="UMinimum" value="#NumberFormat(UMinimum,'9.99')#" size="10" class="cfAdminDefault" required="yes" validate="float" message="Please enter a MINIMUM ORDER value in 99.99 format" onchange="updateInfo('#UID#',this.value,'UMinimum','Users');"></td>
			<td>$<cfinput type="text" name="UMinimumFirst" value="#NumberFormat(UMinimumFirst,'9.99')#" size="10" class="cfAdminDefault" required="yes" validate="float" message="Please enter a MINIMUM FIRST ORDER value in 99.99 format" onchange="updateInfo('#UID#',this.value,'UMinimumFirst','Users');"></td>
			<td align="center"><input type="checkbox" name="UTaxable" onchange="updateInfo('#UID#',this.value,'UTaxable','Users');" <cfif UTaxable EQ 1> checked </cfif> ></td>
		<cfelse>
			<td><cfinput type="text" name="UName" value="#UName#" size="20" class="cfAdminDefault" required="yes" message="Name Required" onchange="alert('USER - #GetAuthUser()# - NOT PERMITTED TO PERFORM THE CHOSEN TASK')"></td>
			<td><cfinput type="text" name="UUserName" value="#UUserName#" size="20" class="cfAdminDefault" required="yes" message="Username Required" onchange="alert('USER - #GetAuthUser()# - NOT PERMITTED TO PERFORM THE CHOSEN TASK')"></td>
			<td><cfinput type="text" name="UPassword" value="#UPassword#" size="20" class="cfAdminDefault" required="yes" message="Password Required" onchange="alert('USER - #GetAuthUser()# - NOT PERMITTED TO PERFORM THE CHOSEN TASK')"></td>
			<td>$<cfinput type="text" name="UMinimum" value="#NumberFormat(UMinimum,'9.99')#" size="10" class="cfAdminDefault" required="yes" validate="float" message="Please enter a MINIMUM ORDER value in 99.99 format" onchange="alert('USER - #GetAuthUser()# - NOT PERMITTED TO PERFORM THE CHOSEN TASK')"></td>
			<td>$<cfinput type="text" name="UMinimumFirst" value="#NumberFormat(UMinimumFirst,'9.99')#" size="10" class="cfAdminDefault" required="yes" validate="float" message="Please enter a MINIMUM FIRST ORDER value in 99.99 format" onchange="alert('USER - #GetAuthUser()# - NOT PERMITTED TO PERFORM THE CHOSEN TASK')"></td>
			<td align="center"><input type="checkbox" name="UTaxable" onchange="alert('USER - #GetAuthUser()# - NOT PERMITTED TO PERFORM THE CHOSEN TASK')" <cfif UTaxable EQ 1> checked </cfif> ></td>
		</cfif>
		<td><!---
			<input type="image" src="images/updatebutton.gif" name="UpdateUser" value="UpdateUser" 
				border="0" alt="Update Discount User" align="absmiddle">
			--->
		</td>
	</tr>
	<input type="hidden" name="UID" value="#UID#">
	</cfform>
	<!--- DIVIDER --->
	<tr><td height="1" colspan="9"><img src="images/image-LineGray.gif" width="100%" height="1"></td></tr>
</cfoutput>

<!--- NAVIGATION ------------------------------------->
	<tr>
		<td class="cfAdminDefault" colspan="5"><cfoutput>Displaying <b>#URL.StartRow#</b> to <b>#EndRow#</b> of <b>#TotalRows#</b> Discount Users</cfoutput></td>
		<td align="right" colspan="4"><cfinclude template="NextNButtons.cfm"></td>
	</tr>
<!--- NAVIGATION ------------------------------------->
</table>
	
<cfinclude template="LayoutAdminFooter.cfm">
