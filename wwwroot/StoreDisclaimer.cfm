<cfmodule template="tags/layout.cfm" CurrentTab="CustomerService" PageTitle="Store Disclaimer">

<!--- Start Breadcrumb --->
<cfmodule template="tags/breadCrumbs.cfm" CrumbLevel='1' showLinkCrumb="Store Disclaimer" />
<!--- End BreadCrumb --->

<cfoutput>
<h3>Store Disclaimer</h3>

	<div align="justify"> 
		<p><strong>
		  Please read the following terms of use and disclaimer carefully 
		  before using this website (this "site").</strong> </p>          
		<p>By using this site, you agree to these terms of use. If you do not 
		  agree to these terms, you may not use this site. #application.siteConfig.data.StoreName# reserves the right, at any time, to modify, alter, or update these 
		  Terms of Use, and you agree to be bound by such modifications, alterations, 
		  or updates. </p>
		<p><strong>Copyright</strong>: All 
		  site design, text, graphics, interfaces, and the selection and 
		  arrangements thereof are (c) #application.siteConfig.data.StoreName# ALL RIGHTS RESERVED. Any other use of materials on this 
		  site, including reproduction for purposes other than those noted 
		  above, modification, distribution, or republication, without 
		  prior written permission of #application.siteConfig.data.StoreName# is strictly 
		  prohibited. </p>
		<p><strong>Trademarks</strong>: 
		  All trademarks, service marks, and trade names (collectively 
		  the "Marks") are proprietary to #application.siteConfig.data.StoreName# 
		  or other respective owners that have granted #application.siteConfig.data.StoreName# the right and license to use such Marks. </p>
		<p><strong>Disclaimer</strong>: 
		  THE INFORMATION, SERVICES, PRODUCTS, AND MATERIALS CONTAINED 
		  IN THIS SITE, INCLUDING, WITHOUT LIMITATION, TEXT, GRAPHICS, 
		  AND LINKS, ARE PROVIDED ON AN "AS IS" BASIS WITH NO WARRANTY. 
		  TO THE MAXIMUM EXTENT PERMITTED BY LAW, #application.siteConfig.data.StoreName# DISCLAIMS ALL REPRESENTATIONS AND WARRANTIES, EXPRESS 
		  OR IMPLIED, WITH RESPECT TO SUCH INFORMATION, SERVICES, PRODUCTS, 
		  AND MATERIALS, INCLUDING BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, 
		  FITNESS FOR A PARTICULAR PURPOSE, TITLE, NONINFRINGEMENT, FREEDOM 
		  FROM COMPUTER VIRUS, AND IMPLIED WARRANTIES ARISING FROM COURSE 
		  OF DEALING OR COURSE OF PERFORMANCE. IN ADDITION, TACTICA INTERNATIONAL 
		  DOES NOT REPRESENT OR WARRANT THAT THE INFORMATION ACCESSIBLE 
		  VIA THIS SITE IS ACCURATE, COMPLETE OR CURRENT. #application.siteConfig.data.StoreName# RESERVES THE RIGHT TO SHARE CUSTOMER CONTACT 
		  INFORMATION, EXCLUDING PAYMENT INFORMATION, WITH SELECTED THIRD 
		  PARTIES. </p>
		<p><strong>Limitation on Liability</strong>: 
		  IN NO EVENT SHALL #application.siteConfig.data.StoreName# BE LIABLE FOR 
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
		  parties (the "External Sites"). You acknowledge that #application.siteConfig.data.StoreName# is not responsible for the availability of, 
		  or the content located on or through, any External Site. You 
		  should contact the site administrator or Webmaster for those 
		  External Sites if you have any concerns regarding such links 
		  or the content located on such External Sites.</p>
	</div>
<br />
<div align="center">
	<hr class="snip" />
	<br />
	<a href="javascript:history.back()"><img src="images/button-back.gif"></a>
	<a href="index.cfm"><img src="images/button-home.gif"></a>
</div>
</cfoutput>

</cfmodule>
