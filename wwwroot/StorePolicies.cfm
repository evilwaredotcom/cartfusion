<cfmodule template="templates/#application.SiteTemplate#/layout.cfm" currenttab="CustomerService" pagetitle="Store Policies">

<!--- Start Breadcrumb --->
<cfmodule template="tags/breadCrumbs.cfm" crumblevel='1' showlinkcrumb="Store Policies" />
<!--- End BreadCrumb --->

<cfoutput>

<h3>Store Policies</h3>

<div align="justify"> 
	<p><strong>
	Please read the following policies before purchasing from this 
	website.</strong></p>
	<p><strong>Return Policy</strong>: At 
	#application.DomainName#, we strive for complete customer satisfaction. If 
	for any reason you not fully satisfied with your purchase, simply 
	return the product to us within 7 days of receipt of product for a 
	full refund of the purchase price, less shipping and handling. </p>
	<p>In order to facilitate the return process, please contact us by e-mail 
	at <a href="mailto:#application.EmailSales#">#application.EmailSales#</a>. 
	Please make sure to include your name, invoice number, and the reason 
	for the return.</p>
	<p>Important: Our customer service department will respond to 
	your email and send you a confirmation message and instructions 
	for your return shipment. If you do not receive a response within 
	48 hours of request, or if you have any questions regarding 
	a return, please call #application.StoreName# at #application.CompanyPhone#.</p>
	
	<p>Terms and Conditions of Product Returns:</p>
		
	<ul>
		<li> Items must not be damaged in any way</li>
		<li> Refund is credited when all items are received by #application.StoreName#</li>
		<li> Refund is amount is less shipping and handling charges</li>
		<li>Any returned items may be subject to a 15% restocking fee</li>
	</ul>
	
	<p>Every item we sell is carefully inspected before it is shipped. If 
	merchandise is defective or damaged upon receipt please contact us 
	immediately after your package arrives for directions on returning 
	the defective merchandise for a full refund or exchange. All claims 
	MUST be made within 3 days of receipt of order. Shipping and handling 
	charges will not be refunded.</p>
	
	<p><strong>Secure Online Purchasing</strong></p>
	
	<p>Ordering online with #application.DomainName# is safe and secure!</p>
	
	<p>We employ a method of interaction with our visitors that does not 
	compromise credit card information. This online system is 100% secure.</p>
	
	<p>A note about the Fair Credit Billing Act. Under this act, your bank 
	limit your total loss and cannot hold you liable for more than $50 
	of reported fraudulent charges. In the event your card is used in 
	a fraudulent manner, you must notify your bank or card issuer immediately 
	and in accordance with its reporting rules and procedures.</p>
	
	<p>We encourage you to feel comfortable using your credit card to conduct 
	commerce on our site. If you wish, you may also purchase using Money 
	Order or personal check. Personal checks will delay your order as 
	we must wait for your funds to clear before we ship any merchandise.</p>
	
	<p>Please allow an additional 7-10 business days for shipping of your 
	merchandise if paid by personal check. To order by check, just print 
	the order form with your shopping cart contents from the order confirmation 
	page and complete the necessary fields, then mail the form to the 
	address above.</p>
	
	<p><strong>Shipping Information</strong></p>
	<p>We pride ourselves in our speedy shipping procedures. Most items 
	are shipped within 48 hours of the order being placed. We use USPS 
	First Class Priority Mail as our standard shipping method. If you 
	require overnight or specialty shipping please select your desired 
	Fedex shipping method during the checkout procedure. International 
	orders will require special shipping fees which may not be calculated 
	during checkout. You will be notified if there are any additional 
	shipping fees required for your order prior to shipping.</p>
	
	<p>If any item(s) are out of stock or back-ordered we will notify you 
	prior to shipping the other portion of your order. We can choose to 
	ship what is in stock or wait until the back-ordered items arrive 
	in our facility.</p>
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
