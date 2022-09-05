


<cfmodule template="templates/#application.SiteTemplate#/layout.cfm" CurrentTab="Home" PageTitle="No Cookies Enabled">

<!--- Start Breadcrumb --->
<cfmodule template="tags/breadCrumbs.cfm" CrumbLevel='1' showLinkCrumb="No Cookies Enabled" />
<!--- End BreadCrumb --->

	<h3>You Must Enable Your Browser To Accept Cookies To Use This Site</h3>

<br/>
<div id="Content">

	<h4>COOKIES</h4>
	<p>A cookie is a small data file that websites often store on your computer's hard drive when you visit their websites. A cookie may contain 
	information (such as a unique user ID) that is used to track the pages of the websites you've visited. This information is stored in a 
	safe and secure database.</p>
	
	<p>We use cookies in order to improve your shopping experience. When you visit our site, your cookie helps us keep track of your order 
	as you shop at our website. If you have saved your information with us, your cookie allows us to recognize you when you return to our 
	website and provides you with access to your account information. If you saved your information with or order from us, we also use cookies 
	to monitor and maintain information about your use of our website. If you have not saved your information with or ordered from us, we may 
	monitor and maintain information about your use of our website in a manner that does not identify you. In either case, this information 
	helps us serve you better by improving our website design, as well as our products, services and promotions.</p>
	
	<p>We also may use cookies to track and maintain the identity of the website you visited immediately prior to ours to further improve our 
	website design and to fulfill contracts with our business partners. We do not otherwise track any information about your use of other 
	websites.</p>
	
	<p>You can refuse cookies by turning them off in your browser. If you turn off cookies, though, we will not be able to track your order or 
	enable you to make a purchase from our website. Nor will we be able to recognize you as a signed up user to allow you access to your 
	account information.</p>
	
	<p><strong>A note to our customers using Internet Explorer 6.0</strong></p>
	
	<p>If you are shopping on our site using Internet Explorer 6.0 and are having difficulty accessing the website, please check your 
	privacy settings in your browser and set them to "Medium". If you do not wish to change your privacy settings to "Medium" and you are 
	currently using the "Medium High" or "High" settings, you may choose to override your current cookie handling practices for individual 
	websites that you specify.</p>
	
	<p><strong>How to enable cookies on your browser for:</strong></p>
	
	<strong>AOL 8.0, Internet Explorer 5.0</strong>
	<ul>
		<li>Go to "My Computer."</li>
		<li>Select "Control Panel."</li>
		<li>Select "Internet Options."</li>
		<li>Select the "Security" tab.</li>
		<li>Click "Custom Level."</li>
		<li>Under "Allow cookies that are stored on your computer," click "Enable."</li>
		<li>Click "OK."</li>
	</ul>
	 
	<strong>AOL 8.0, Internet Explorer 6.0</strong>
	<ul>
		<li>Go to "My Computer."</li>
		<li>Select "Control Panel."</li>
		<li>Select "Internet Options."</li>
		<li>Select the "Privacy" tab.</li>
		<li>Set the Privacy Slider to "Medium."</li>
		<li>Click "OK."</li>
	</ul>
	
	<strong>AOL 5.0</strong>
	<ul>
		<li>Select "Preferences."</li>
		<li>Click on "WWW."</li>
		<li>Select the "Security" tab.</li>
		<li>Click on "Custom Level."</li>
		<li>Scroll down to "Cookies" and select "Enable."</li>
	</ul>
	
	<strong>Internet Explorer 5.0 for PC</strong>
	<ul>
		<li>Select "Internet Options" from the "Tools" menu.</li>
		<li>Click the "Security" tab.</li>
		<li>Click "Custom Level" at the bottom of the window.</li>
		<li>Scroll down to "Cookies"</li>
		<li>Under "Allow cookies that are stored on your computer," click "Enable."</li>
		<li>Click "OK."</li>
	</ul>
	
	<strong>Internet Explorer 5.0 for Mac OS9</strong>
	<ul>	
		<li>Select "Preferences" from the "Edit" menu.</li>
		<li>Select "Receiving Files."</li>
		<li>Select "Cookies."</li>
		<li>Select the option "Never ask" under "When receiving cookies."</li>
		<li>Click "OK."</li>
	</ul>
	
	<strong>Internet Explorer 5.0 for MAC OS10</strong> 
	<ul>
		<li>Select "Preferences" from the "Explorer" menu.</li>
		<li>Select "Receiving Files."</li>
		<li>Select "Cookies."</li>
		<li>Select the option "Never ask" under "When receiving cookies."</li> 
		<li>Click "OK."</li>
	</ul>
	
	<strong>Internet Explorer 6.0 for PC</strong><br>
	To change your privacy settings to medium:
	<ul>
		<li>Select "Internet Options" from the "Tools" menu.
		<li>Click the "Privacy" tab.</li>
		<li>Set the slider to "Medium."</li>
		<li>Click "OK."</li>
	</ul>
	
	<strong>To override your current cookie handling practices for individual websites:</strong>
	<ul>
		<li>Select "Internet Options" from the "Tools" menu.</li>
		<li>Click the "Edit" button in the "Override cookie handling for individual websites" section.</li>
		<li>This will open the "Per Site Privacy Actions" dialogue box.</li>
		<li>Type <cfoutput>#cgi.HTTP_HOST#</cfoutput> in the "Address of Website" box and click the "Allow" button.</li> 
		<li>Click the "OK" button, then close the "Per Site Privacy Actions" dialogue box.</li>
		<li>Click the "OK" button to close the "Internet Options" dialogue box and apply your changes.</li>
	</ul>
	
	<strong>Netscape Navigator/Communicator:  Select "Preferences" from the "Edit" menu.</strong>
	<ul>
		<li>Select "Advanced" from the left-hand menu.</li>
		<li>Select "Accept All Cookies."</li>
		<li>Click "OK."</li>
	</ul>

</div>

</cfmodule>
