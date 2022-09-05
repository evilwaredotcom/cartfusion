<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Fedex Registration</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="adminProStyles.css" rel="stylesheet" type="text/css">
</head>

<body>
<strong>
<div align="center" class="bodyText">* Note, on some CF Server installations
  the javascript created by the cfform tag used on this page creates a javascript
  error. Just ignore it but make sure
you have filled out all the fields below (except for the Address line 2 if not
needed) otherwise an error will be thrown and your identification number will
not be returned</div>
</strong><br>
<br>
<table width="399" border="1" align="center" cellpadding="0" cellspacing="0">
  <tr align="center" bgcolor="#333366">
	<td height="25" colspan="2" class="headerWhite"><strong>Request an Identification Number From Fedex</strong></td>
  </tr>
  <tr align="center" bgcolor="#EEEEEE">
	<td colspan="2" class="bodyText">In order to perform many requests to the
	  Fedex Servers, you require in addition to your account number a Fedex Identification
	  Number. This ID is received when you register with the Fedex Registration
	  Server. Filling out the form below when perform this function for you and
	  return to your your Fedex Identification Number for future use.<br>
	  <strong><font color="#FF0000">* Note enter the same information below that
	  you have noted on your acocunt with fedex as your accunt billing information</font></strong></td>
  </tr>
  <cfform action="register.cfm" method="post">
  <tr>
	<td width="158" class="bodyText"><strong>Your Fedex Account Number:</strong></td>
	<td width="235"><cfinput name="accountNum" type="text" size="15" maxlength="15" required="yes" message="Please enter your fedex account number" id="accountNum"></td>
  </tr>
  <tr>
	<td class="bodyText"><strong>Your Company Name:</strong></td>
	<td><cfinput name="CompanyName" type="text" required="yes" message="Please enter your company name" id="CompanyName">
	</td>
  </tr>
  <tr>
	<td class="bodyText"><strong>Contact Name:</strong></td>
	<td><cfinput name="ContactName" type="text" required="yes" message="Please enter your Contact Name" id="ContactName">
	</td>
  </tr>
  <tr>
	<td class="bodyText"><strong>Department:</strong></td>
	<td><cfinput name="Dept" type="text" value="Shipping" required="yes" message="Please enter a department" id="Dept">
	</td>
  </tr>
  <tr>
	<td class="bodyText"><strong>Phone Number:<br>
	  </strong>* Must contains numbers ONLY, no dashes or spaces!</td>
	<td><cfinput name="phoneNum" type="text" size="12" maxlength="10" required="yes" message="Please enter your Phone Number with no dashes or spaces - NUMBERS ONLY" id="phoneNum">
	</td>
  </tr>
  <tr>
	<td class="bodyText"><strong>Account Email Address:</strong></td>
	<td><cfinput name="Email" type="text" id="Email" size="20" maxlength="50"></td>
  </tr>
  <tr>
	<td class="bodyText"><strong>Street Address 1:</strong></td>
	<td><cfinput name="Street1" type="text" size="30" maxlength="50" required="yes" message="Please enter your street address" id="Street1">
	</td>
  </tr>
  <tr>
	<td class="bodyText"><strong>Street Address 2:</strong></td>
	<td><input name="Street2" type="text" id="Street2" size="10" maxlength="50">
	</td>
  </tr>
  <tr>
	<td class="bodyText"><strong>City:</strong></td>
	<td><cfinput name="City" type="text" size="25" maxlength="50" required="yes" message="Please enter your City" id="accountNum">
	</td>
  </tr>
  <tr>
	<td class="bodyText"><strong>State: (2 Digit State Code)</strong></td>
	<td><cfinput name="State" type="text" size="4" maxlength="2" required="yes" message="Please enter your 2 digit State" id="State">
	</td>
  </tr>
  <tr>
	<td class="bodyText"><strong>Zip/Postcode:</strong></td>
	<td><cfinput name="Zip" type="text" size="10" maxlength="10" required="yes" message="Please enter your zipcode" id="Zip">
	</td>
  </tr>
  <tr>
	<td class="bodyText"><strong>Country:</strong></td>
	<td>
	<select name="Country">
				  <option value="AL">Albania</option>
				  <option value="AS">American Samoa</option>
				  <option value="AD">Andorra</option>
				  <option value="AO">Angola</option>
				  <option value="AI">Anguilla</option>
				  <option value="AG">Antigua/Barbuda</option>
				  <option value="AR">Argentina</option>
				  <option value="AM">Armenia</option>
				  <option value="AW">Aruba</option>
				  <option value="AU">Australia</option>
				  <option value="AT">Austria</option>
				  <option value="AZ">Azerbaijan</option>
				  <option value="BS">Bahamas</option>
				  <option value="BH">Bahrain</option>
				  <option value="BD">Bangladesh</option>
				  <option value="BB">Barbados</option>
				  <option value="BY">Belarus</option>
				  <option value="BE">Belgium</option>
				  <option value="BZ">Belize</option>
				  <option value="BJ">Benin</option>
				  <option value="BM">Bermuda</option>
				  <option value="BT">Bhutan</option>
				  <option value="BO">Bolivia</option>
				  <option value="BA">Bosnia-Herzegovina</option>
				  <option value="BW">Botswana</option>
				  <option value="BR">Brazil</option>
				  <option value="VG">British Virgin Islands</option>
				  <option value="BN">Brunei</option>
				  <option value="BG">Bulgaria</option>
				  <option value="BF">Burkina Faso</option>
				  <option value="BI">Burundi</option>
				  <option value="KH">Cambodia</option>
				  <option value="CM">Cameroon</option>
				  <option value="CA">Canada</option>
				  <option value="CV">Cape Verde</option>
				  <option value="KY">Cayman Islands</option>
				  <option value="TD">Chad</option>
				  <option value="CL">Chile</option>
				  <option value="CN">China</option>
				  <option value="CO">Colombia</option>
				  <option value="CG">Congo Brazzaville</option>
				  <option value="CD">Congo Democratic Rep. of</option>
				  <option value="CK">Cook Islands</option>
				  <option value="CR">Costa Rica</option>
				  <option value="HR">Croatia</option>
				  <option value="CY">Cyprus</option>
				  <option value="CZ">Czech Republic</option>
				  <option value="DK">Denmark</option>
				  <option value="DJ">Djibouti</option>
				  <option value="DM">Dominica</option>
				  <option value="DO">Dominican Republic</option>
				  <option value="EC">Ecuador</option>
				  <option value="EG">Egypt</option>
				  <option value="SV">El Salvador</option>
				  <option value="GQ">Equatorial Guinea</option>
				  <option value="ER">Eritrea</option>
				  <option value="EE">Estonia</option>
				  <option value="ET">Ethiopia</option>
				  <option value="FO">Faeroe Islands</option>
				  <option value="FJ">Fiji</option>
				  <option value="FI">Finland</option>
				  <option value="FR">France</option>
				  <option value="GF">French Guiana</option>
				  <option value="PF">French Polynesia</option>
				  <option value="GA">Gabon</option>
				  <option value="GM">Gambia</option>
				  <option value="GE">Georgia</option>
				  <option value="DE">Germany</option>
				  <option value="GH">Ghana</option>
				  <option value="GI">Gibraltar</option>
				  <option value="GR">Greece</option>
				  <option value="GL">Greenland</option>
				  <option value="GD">Grenada</option>
				  <option value="GP">Guadeloupe</option>
				  <option value="GU">Guam</option>
				  <option value="GT">Guatemala</option>
				  <option value="GN">Guinea</option>
				  <option value="GY">Guyana</option>
				  <option value="HT">Haiti</option>
				  <option value="HN">Honduras</option>
				  <option value="HK">Hong Kong</option>
				  <option value="HU">Hungary</option>
				  <option value="IS">Iceland</option>
				  <option value="IN">India</option>
				  <option value="ID">Indonesia</option>
				  <option value="IE">Ireland</option>
				  <option value="IL">Israel</option>
				  <option value="IT">Italy/Vatican City</option>
				  <option value="CI">Ivory Coast</option>
				  <option value="JM">Jamaica</option>
				  <option value="JP">Japan</option>
				  <option value="JO">Jordan</option>
				  <option value="KZ">Kazakhstan</option>
				  <option value="KE">Kenya</option>
				  <option value="KW">Kuwait</option>
				  <option value="KG">Kyrgyzstan</option>
				  <option value="LA">Laos</option>
				  <option value="LV">Latvia</option>
				  <option value="LB">Lebanon</option>
				  <option value="LS">Lesotho</option>
				  <option value="LR">Liberia</option>
				  <option value="LI">Liechtenstein</option>
				  <option value="LT">Lithuania</option>
				  <option value="LU">Luxembourg</option>
				  <option value="MO">Macau</option>
				  <option value="MK">Macedonia</option>
				  <option value="MW">Malawi</option>
				  <option value="MY">Malaysia</option>
				  <option value="MV">Maldives</option>
				  <option value="ML">Mali</option>
				  <option value="MT">Malta</option>
				  <option value="MH">Marshall Islands</option>
				  <option value="MQ">Martinique</option>
				  <option value="MR">Mauritania</option>
				  <option value="MU">Mauritius</option>
				  <option value="MX">Mexico</option>
				  <option value="FM">Micronesia</option>
				  <option value="MD">Moldova</option>
				  <option value="MC">Monaco</option>
				  <option value="MN">Mongolia</option>
				  <option value="MS">Montserrat</option>
				  <option value="MA">Morocco</option>
				  <option value="MZ">Mozambique</option>
				  <option value="NA">Namibia</option>
				  <option value="NP">Nepal</option>
				  <option value="NL">Netherlands</option>
				  <option value="AN">Netherlands Antilles</option>
				  <option value="NC">New Caledonia</option>
				  <option value="NZ">New Zealand</option>
				  <option value="NI">Nicaragua</option>
				  <option value="NE">Niger</option>
				  <option value="NG">Nigeria</option>
				  <option value="NO">Norway</option>
				  <option value="OM">Oman</option>
				  <option value="PK">Pakistan</option>
				  <option value="PW">Palau</option>
				  <option value="PS">Palestine Autonomous</option>
				  <option value="PA">Panama</option>
				  <option value="PG">Papua New Guinea</option>
				  <option value="PY">Paraguay</option>
				  <option value="PE">Peru</option>
				  <option value="PH">Philippines</option>
				  <option value="PL">Poland</option>
				  <option value="PT">Portugal</option>
				  <option value="PR">Puerto Rico</option>
				  <option value="QA">Qatar</option>
				  <option value="RE">Reunion</option>
				  <option value="RO">Romania</option>
				  <option value="RU">Russian Federation</option>
				  <option value="RW">Rwanda</option>
				  <option value="MP">Saipan</option>
				  <option value="SA">Saudi Arabia</option>
				  <option value="SN">Senegal</option>
				  <option value="SC">Seychelles</option>
				  <option value="SG">Singapore</option>
				  <option value="SK">Slovak Republic</option>
				  <option value="SI">Slovenia</option>
				  <option value="ZA">South Africa</option>
				  <option value="KR">South Korea</option>
				  <option value="ES">Spain</option>
				  <option value="LK">Sri Lanka</option>
				  <option value="KN">St. Kitts/Nevis</option>
				  <option value="LC">St. Lucia</option>
				  <option value="VC">St. Vincent</option>
				  <option value="SR">Suriname</option>
				  <option value="SZ">Swaziland</option>
				  <option value="SE">Sweden</option>
				  <option value="CH">Switzerland</option>
				  <option value="SY">Syria</option>
				  <option value="TW">Taiwan</option>
				  <option value="TZ">Tanzania</option>
				  <option value="TH">Thailand</option>
				  <option value="TG">Togo</option>
				  <option value="TT">Trinidad/Tobago</option>
				  <option value="TN">Tunisia</option>
				  <option value="TR">Turkey</option>
				  <option value="TM">Turkmenistan</option>
				  <option value="TC">Turks &amp; Caicos Islands</option>
				  <option value="VI">U.S. Virgin Islands</option>
				  <option value="US" selected="selected">U.S.A.</option>
				  <option value="UG">Uganda</option>
				  <option value="UA">Ukraine</option>
				  <option value="AE">United Arab Emirates</option>
				  <option value="GB">United Kingdom</option>
				  <option value="UY">Uruguay</option>
				  <option value="UZ">Uzbekistan</option>
				  <option value="VU">Vanuatu</option>
				  <option value="VE">Venezuela</option>
				  <option value="VN">Vietnam</option>
				  <option value="WF">Wallis &amp; Futuna</option>
				  <option value="YE">Yemen</option>
				  <option value="YU">Yugoslavia</option>
				  <option value="ZM">Zambia</option>
				  <option value="ZW">Zimbabwe</option>
		</select>
	</td>
  </tr>
  <tr align="center">
	<td colspan="2"><input type="submit" name="Submit" value="Submit"></td>
  </tr>
  </cfform>
</table>

<cfif cgi.request_method eq "POST">
<cf_TagFedex 
	function="RegisterRequest"
	accountnumber="#accountNum#"	
	shippercontactname="#ContactName#"
	shippercompany="#CompanyName#"
	shipperdept="#Dept#"
	shipperphone="#phoneNum#"
	shipperpager=""
	shipperfax=""
	shipperemail="#Email#"
	shipperstreet="#Street1#"
	shipperstreet2="#Street2#"
	shippercity="#City#"
	shipperstate="#State#"
	shipperzip="#Zip#"
	shippercountry="#Country#"
	TestingEnvironment="False"
	debug="False"
	>

  <cfoutput>
		<cfdump var="#stFedexRegister#">
  </cfoutput>

<hr>
<cfif IsDefined("FedexError") AND FedexError eq 0>
	<cfoutput>	
		<strong><span class="bodyText">Your Fedex Identifier: <font color="##330066">#FedexIdentifier#</font></span></strong>
		<hr>
</cfoutput>
  <cfelse>
  	<cfoutput>
	Fedex Error Severity: #FedexError#<br>
	Fedex Error Description: #FedexErrorDesc#
	</cfoutput>
  </cfif>
</cfif>
</body>
</html>
