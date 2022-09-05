



<cfmodule template="templates/#application.SiteTemplate#/layout.cfm" currenttab="CustomerService" pagetitle="Store Disclaimer">

<!--- Start Breadcrumb --->
<cfmodule template="tags/breadCrumbs.cfm" crumblevel='1' showlinkcrumb="Store Disclaimer" />
<!--- End BreadCrumb --->

<cfoutput>
<h3>Store Disclaimer</h3>

<div align="justify"> 
	<p><strong>
	  Please read the following terms of use and disclaimer carefully 
	  before using this website (this "site").</strong> </p>		  
	<p>By using this site, you agree to these terms of use. If you do not 
	  agree to these terms, you may not use this site. #application.StoreName# reserves the right, at any time, to modify, alter, or update these 
	  Terms of Use, and you agree to be bound by such modifications, alterations, 
	  or updates. </p>
	<p><strong>Copyright</strong>: All 
	  site design, text, graphics, interfaces, and the selection and 
	  arrangements thereof are (c) #application.StoreName# ALL RIGHTS RESERVED. Any other use of materials on this 
	  site, including reproduction for purposes other than those noted 
	  above, modification, distribution, or republication, without 
	  prior written permission of #application.StoreName# is strictly 
	  prohibited. </p>
	<p><strong>Trademarks</strong>: 
	  All trademarks, service marks, and trade names (collectively 
	  the "Marks") are proprietary to #application.StoreName# 
	  or other respective owners that have granted #application.StoreName# the right and license to use such Marks. </p>
	<p><strong>Disclaimer</strong>: 
	  THE INFORMATION, SERVICES, PRODUCTS, AND MATERIALS CONTAINED 
	  IN THIS SITE, INCLUDING, WITHOUT LIMITATION, TEXT, GRAPHICS, 
	  AND LINKS, ARE PROVIDED ON AN "AS IS" BASIS WITH NO WARRANTY. 
	  TO THE MAXIMUM EXTENT PERMITTED BY LAW, #application.StoreName# DISCLAIMS ALL REPRESENTATIONS AND WARRANTIES, EXPRESS 
	  OR IMPLIED, WITH RESPECT TO SUCH INFORMATION, SERVICES, PRODUCTS, 
	  AND MATERIALS, INCLUDING BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, 
	  FITNESS FOR A PARTICULAR PURPOSE, TITLE, NONINFRINGEMENT, FREEDOM 
	  FROM COMPUTER VIRUS, AND IMPLIED WARRANTIES ARISING FROM COURSE 
	  OF DEALING OR COURSE OF PERFORMANCE. IN ADDITION, TACTICA INTERNATIONAL 
	  DOES NOT REPRESENT OR WARRANT THAT THE INFORMATION ACCESSIBLE 
	  VIA THIS SITE IS ACCURATE, COMPLETE OR CURRENT. #application.StoreName# RESERVES THE RIGHT TO SHARE CUSTOMER CONTACT 
	  INFORMATION, EXCLUDING PAYMENT INFORMATION, WITH SELECTED THIRD 
	  PARTIES. </p>
	<p><strong>Limitation on Liability</strong>: 
	  IN NO EVENT SHALL #application.StoreName# BE LIABLE FOR 
	  ANY DIRECT, INDIRECT, SPECIAL, PUNITIVE, INCIDENTAL, EXEMPLARY 
	  OR CONSEQUENTIAL DAMAGES, OR ANY DAMAGES WHATSOEVER, EVEN IF 
	  TACTICA INTERNATIONAL HAS BEEN PREVIOUSLY ADVISED OF THE POSSIBILITY 
	  OF SUCH DAMAGES, WHETHER IN AN ACTION UNDER CONTRACT, NEGLIGENCE, 
	  OR ANY OTHER THEORY, ARISING OUT OF OR IN CONNECTION WITH THE 
	  USE, INABILITY TO USE, OR PERFORMANCE OF THE INFORMATION, SERVICES, 
	  PRODUCTS, AND MATERIALS AVAILABLE FROM THIS SITE. THESE LIMITATIONS 
	  SHALL APPLY NOTWITHSTANDING ANY FAILURE OF ESSENTIAL PURPOSE 
	  OF ANY LIMITED REMEDY. BECAUSE SOME JURISDICTIONS DO NOT ALLOW 
	  LIMITATIONS ON HOW LONG AN IMPLIED WARRANTY LASTS, OR THE EXCLUSION 
	  OR LIMITATION OF LIABILITY FOR CONSEQUENTIAL OR INCIDENTAL DAMAGES, 
	  THE ABOVE LIMITATIONS MAY NOT APPLY TO YOU. </p>
	<p><strong>External Sites</strong>: 
	  This site may contain links to other sites on the Internet that 
	  are owned and operated by third party vendors and other third 
	  parties (the "External Sites"). You acknowledge that #application.StoreName# is not responsible for the availability of, 
	  or the content located on or through, any External Site. You 
	  should contact the site administrator or Webmaster for those 
	  External Sites if you have any concerns regarding such links 
	  or the content located on such External Sites.</p>
</div>

<div align="center">
	<br/>
	<hr class="snip" />
	<br/>
	<input type="button" name="GoBack" value="&lt; BACK" class="button2" onclick="javascript:history.back();"> 
	<input type="button" name="GoHome" value="HOME &gt;" class="button2" onclick="javascript:document.location.href='index.cfm';">
</div>
</cfoutput>

</cfmodule>
