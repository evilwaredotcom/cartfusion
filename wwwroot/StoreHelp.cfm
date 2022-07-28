<cfmodule template="tags/layout.cfm" CurrentTab="CustomerService" PageTitle="Store Help">

<!--- Start Breadcrumb --->
<cfmodule template="tags/breadCrumbs.cfm" CrumbLevel='1' showLinkCrumb="Store Help" />

  <cfoutput>
  <h3>Store Help</h3>
  </cfoutput>

</cfmodule>
<!--- End BreadCrumb --->

<cfscript>
	PageTitle = 'SHOPPING CART' ;
	BannerTitle = 'Help' ;
	HideLeftNav = 0 ;
</cfscript>
<cfinclude template="LayoutGlobalHeader.cfm">

<table cellpadding="0" cellspacing="0" border="0" width="100%">
	<tr valign="top">
		<td class="sub_pagehead"><span class="sub_pagetitle">Site Helpdesk</span></td>
	</tr>
</table>

<cfoutput>
<table width="98%" border=0 cellspacing=0 cellpadding=0>
<tr valign=top>
<td width="100%">
  <table border="0" cellpadding="0" width="100%" cellspacing="0">
    <tr>
      <td>
          <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr>
              <td width="100%" class="help"><a name="HOW TO PLACE YOUR ORDER"><b>HOW TO PLACE YOUR ORDER</b></a></th>
            </tr>          
			<tr>
              <td width="100%" class="cfDefault" style="padding-left:10px;padding-right:10px;padding-top:10px;">
			  	Our How-to-Order guide will tell you everything you need to know to place an order on 
			  	<a href="#config.RootURL#">#config.DomainName#</a>
                . . . it's easy and completely secure and if you get stuck simply call up customer service at 
				<b>#config.CompanyPhone#</b> and we will assist you with your order.
			  </td>
            </tr>
			<tr>
              <td width="100%" height="25" style="padding-left:10px;padding-right:10px;padding-top:10px;">
			    <ul>
                  <li><b><a href="##SHOPPING AND EXPLORING OUR SITE">Shopping and exploring our site</a></b></li>
                  <li><b><a href="##REVIEWING A PRODUCT ITEM">Reviewing a product</a></b></font></li>
                  <li><b><a href="##ADDING AN ITEM TO YOUR SHOPPING BAG AND CHECKING OUT">Adding an item to your shopping cart and checkout</a></b></li>
                  <li><b><a href="##ORDER COMPLETED">Complete your order</a></b></li>
                  <li><b><a href="##Help">Additional Help</a></b></li>
                </ul>
			  </td>
            </tr>
            <tr>
              <td width="100%" height="20"></td>
            </tr>
            <tr>
              <td width="100%" class="help"><b>1. <a name="SHOPPING AND EXPLORING OUR SITE" class="cfDefault">SHOPPING AND EXPLORING OUR SITE</a></b></td>
            </tr>
            <tr>
              <td width="100%" class="cfDefault" style="padding-left:10px;padding-right:10px;padding-top:10px;">
                <ul>
					<li>Use our top navigation buttons or side navigation buttons to visit a category or section of your choosing.</li>
					<li>When in a particular section continue your shopping by clicking on a product image or link to find out more details 
						and/or to visit another page.</li>
					<li>You can also use our website's <b>QUICK SEARCH</b> function to quickly find what you are looking for.</li>
					<li>Once you have found an item of jewelry you would like to consider purchasing, simply click on the item's <b>ADD TO CART</b></li>
					<li>This Item of choice will be displayed in your shopping bag. You are free to remove 
						this and any other items in your shopping bag at any time you wish. Until you complete your checkout process,
						you have not purchased these items. Click on the <b>CONTINUE SHOPPING</b> 
						button to resume shopping.</li>
                </ul>                
				<p align="center"><a href="##Top">Back to Top</a></p>
			  </td>
            </tr>
            <tr>
              <td width="100%" height="15"></td>
            </tr>
            <tr>
              <td width="100%" class="help"><b>2. <a name="REVIEWING A PRODUCT ITEM" class="cfDefault">REVIEWING A PRODUCT ITEM</a></b></td>
            </tr>
            <tr>
              <td width="100%" class="cfDefault" style="padding-left:10px;padding-right:10px;padding-top:10px;">
			  	When on an product item page you will be able to review all the details related to this item before you make your purchase.
                <ul>
                  <li>Detailed item image.</li>
                  <li>Key features and specifications.</li>
                  <li>Item price and availability</li>
                  <li>Other related items.</li>
                </ul>                
				<p align="center"><a href="##Top">Back to Top</a></p>
			  </td>
            </tr>
            <tr>
              <td width="100%" height="15"></td>
            </tr>
            <tr>
              <td width="100%" class="help"><b>3. <a name="ADDING AN ITEM TO YOUR SHOPPING BAG AND CHECKING OUT" class="cfDefault">ADDING AN ITEM TO YOUR SHOPPING BAG AND CHECKING OUT</a></font></b></td>
            </tr>
            <tr>
              <td width="100%" class="cfDefault" style="padding-left:10px;padding-right:10px;padding-top:10px;">
			    On completion of reviewing your selected item details,
                <ul>
                  <li>Select from the available sizes, and color options presented to you in the form of drop down menus</li>
                  <li>Once completed click on the item's <b>ADD TO SHOPPING BAG</b> button.</li>
                  <li>You will now be take to view the contents of your shopping bag. Should you wish to continue shopping, simply click on the 
				  	<b>CONTINUE SHOPPING</b> button.</li>
                  <li>Should you wish to complete your purchase you can add additional quantity to an item or
                    remove one or more of the items in your shopping bag. When you are satisfied with the contents of your shopping
                    bag and are to checkout simply click on the <b>SECURE CHECKOUT</b> button.</li>
                  <li>Fill out all the necessary fields with your contact, shipping, billing and payment
                    information. Please rest assured that you are now in a secured environment and you personal information will not be
                    released or get in the hands of any third party. (If you look at the URL of your browser window you will see you are
                    in a https:// page and not the regular http:// page which is unsecured.)</li>
                  <li>Once you submit your information and your order has been submitted you will
                    receive an order confirmation on screen. You can print this page out for your records. You will also receive an
                    email within moments with all your order details which is your receipt and proof of purchase.</li>
                </ul>                
				<p align="center"><a href="##Top">Back to Top</a></p>
			  </td>
            </tr>
            <tr>
              <td width="100%" height="15"></td>
            </tr>
            <tr>
              <td width="100%" class="help"><b>4. <a name="ORDER COMPLETED" class="cfDefault">ORDER COMPLETED</a></b></td>
            </tr>
            <tr>
              <td width="100%" class="cfDefault" style="padding-left:10px;padding-right:10px;padding-top:10px;">
                <ul>
					<li>We will e-mail you once your order has been shipped (usually within 2-3 business days of having placed your order).</li>
					<li>Your order will be beautifully packed in our complementary gift box and wrapped in a silk
						ribbon and shipped out enclosed in a protective shipping box with a copy of a packing list of what is enclosed.</li>
					<li>To check on you order status you can either go to your shipment confirmation email and
						click on your track shipment link, or visit <a href="http://www.usps.com">www.usps.com</a>
						(the US Postal Service Website) and enter in your tracking number listed in your confirmation email or call our
						customer service department at #config.CompanyPhone# and we will be happy to assist you.</li>
                </ul>                
				<p align="center"><a href="##Top">Back to Top</a><br><br></p>
              </td>
            </tr>
            <tr>
              <td width="100%" class="help"><b>5. <a name="Help" class="cfDefault">ADDITIONAL HELP</a></b></td>
            </tr>
            <tr>
              <td width="100%" class="cfDefault" style="padding-left:10px;padding-right:10px;padding-top:10px;">
			  	If you are in any way confused or facing difficulty in placing your order online,
                please feel free to place your order over the phone by calling us.
                <p>Our customer service department will be very happy to assist you place your order and answer any questions you may have about our products and service.</p>
                <p>Call Us: #config.CompanyPhone#<br>
                <p>Customer Service Hours: Monday - Friday, 9am - 6pm</p>
              </td>
            </tr>
            <tr>
              <td width="100%"><br>
                <p align="center"><a href="##Top">Back to Top</a> | <a href="index.cfm">Continue Shopping</a></p></td>
            </tr>
          </table>
      </td>
    </tr>
  </table>
  </td></tr></table>
</cfoutput>
<cfinclude template="LayoutGlobalFooter.cfm">