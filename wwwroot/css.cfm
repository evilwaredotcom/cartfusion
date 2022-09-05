<cfprocessingdirective suppresswhitespace="Yes">


<style type="text/css">

/*  BEGIN: Text Styles  ***/
<cfoutput>

BODY 
{ font-family: #layout.PrimaryFontFamily#; font-size:#layout.DefaultSize#px; text-decoration: #layout.DefaultDecor#; 
  color: #layout.DefaultColor#; bgcolor: #layout.PrimaryBGColor#; background: #application.ImagePath#/#layout.PrimaryBGImage#; }

B
{ font-weight: bold; }

TD 
{ font-family: #layout.PrimaryFontFamily#; font-size: #layout.DefaultSize#px; font-weight: #layout.DefaultWeight#;
  text-decoration: #layout.DefaultDecor#; color: #layout.DefaultColor#; }
  
A
{ font-family: #layout.PrimaryFontFamily#; font-weight: #layout.PrimaryLinkWeight#; 
  text-decoration: #layout.PrimaryLinkDecor#; color: #layout.PrimaryLinkColor#; }

A:alink
{ font-family: #layout.PrimaryFontFamily#; font-weight: #layout.PrimaryALinkWeight#;
  text-decoration: #layout.PrimaryALinkDecor#; color: #layout.PrimaryALinkColor#; }

A:vlink
{ font-family: #layout.PrimaryFontFamily#; font-weight: #layout.PrimaryVLinkWeight#;
  text-decoration: #layout.PrimaryVLinkDecor#; color: #layout.PrimaryVLinkColor#; }

A:hover
{ font-family: #layout.PrimaryFontFamily#; font-weight: #layout.PrimaryHLinkWeight#;
  text-decoration: #layout.PrimaryHLinkDecor#; color: #layout.PrimaryHLinkColor#; }
  
LI
{ font-family: #layout.PrimaryFontFamily#; font-size: #layout.DefaultSize#px; font-weight: #layout.DefaultWeight#;
  text-decoration: #layout.DefaultDecor#; color: #layout.DefaultColor#; }

.cfAttract
{ font-family: #layout.PrimaryFontFamily#; font-size: #layout.AttractSize#px; font-weight: #layout.AttractWeight#; 
  text-decoration: #layout.AttractDecor#; color: #layout.AttractColor#; }
  
.cfButton
{ background-color:##fff; color:###layout.ButtonColor#;
  font-family: #layout.PrimaryFontFamily#; font-size: #layout.ButtonSize#px; font-weight: #layout.ButtonWeight#;
  border:1px solid; border-top-color:###layout.ButtonColor#; border-left-color:###layout.ButtonColor#;
  border-right-color:###layout.ButtonColor#; border-bottom-color:###layout.ButtonColor#;
  text-decoration: #layout.ButtonDecor#; height:20px; cursor:hand; padding-bottom:1px;
  filter:progid:DXImageTransform.Microsoft.Gradient(GradientType=0,StartColorStr='##ffffff',EndColorStr='##E9E9E9'); }
  
.cfButtonRemove
{ background-color:##fff; color:###layout.ButtonColor#;
  font-family: #layout.PrimaryFontFamily#; font-size: #layout.ButtonSize#px; font-weight: #layout.ButtonWeight#;
  border:0px solid; border-top-color:###layout.ButtonColor#; border-left-color:###layout.ButtonColor#;
  border-right-color:###layout.ButtonColor#; border-bottom-color:###layout.ButtonColor#;
  text-decoration: #layout.ButtonDecor#; height:16px; cursor:hand;
  filter:progid:DXImageTransform.Microsoft.Gradient(GradientType=0,StartColorStr='##ffffff',EndColorStr='##E9E9E9'); }
					  
.cfDefault 
{ font-family: #layout.PrimaryFontFamily#; font-size: #layout.DefaultSize#px; font-weight: #layout.DefaultWeight#;
  text-decoration: #layout.DefaultDecor#; color: #layout.DefaultColor#; }

.cfErrorMsg
{ font-family: #layout.PrimaryFontFamily#; font-size: #layout.ErrorMsgSize#px; font-weight: #layout.ErrorMsgWeight#; 
  text-decoration: #layout.ErrorMsgDecor#; color: #layout.ErrorMsgColor#; }
  
.cfFormField
{ font-family: #layout.PrimaryFontFamily#; font-size: #layout.FormFieldSize#px; font-weight: #layout.FormFieldWeight#; 
  text-decoration: #layout.FormFieldDecor#; color: #layout.FormFieldColor#;
  height:20px; }

.cfFormLabel
{ font-family: #layout.PrimaryFontFamily#; font-size: #layout.FormLabelSize#px; font-weight: #layout.FormLabelWeight#; 
  text-decoration: #layout.FormLabelDecor#; color: #layout.FormLabelColor#; }
  
.cfHeading
{ font-family: #layout.HeadingFontFamily#; font-size: #layout.HeadingSize#px; font-weight: #layout.HeadingWeight#; 
  text-decoration: #layout.HeadingDecor#; color: #layout.HeadingColor#; }

.cfHome
{ font-family: #layout.PrimaryFontFamily#; font-size: #layout.HomeSize#px; font-weight: #layout.HomeWeight#; 
  text-decoration: #layout.HomeDecor#; color: #layout.HomeColor#; }
  
.cfHomeHeading 
{ font-family: #layout.HeadingFontFamily#; font-size: #layout.HomeHeadingSize#px; font-weight: #layout.HomeHeadingWeight#; 
  text-decoration: #layout.HomeHeadingDecor#; color: #layout.HomeHeadingColor#; }

.cfMessage 
{ font-family: #layout.PrimaryFontFamily#; font-size: #layout.MessageSize#px; font-weight: #layout.MessageWeight#; 
  text-decoration: #layout.MessageDecor#; color: #layout.MessageColor#; }

.cfMessageTwo 
{ font-family: #layout.PrimaryFontFamily#; font-size: #layout.MessageTwoSize#px; font-weight: #layout.MessageTwoWeight#; 
  text-decoration: #layout.MessageTwoDecor#; color: #layout.MessageTwoColor#; } 

.cfMessageThree
{ font-family: #layout.PrimaryFontFamily#; font-size: #layout.MessageThreeSize#px; font-weight: #layout.MessageThreeWeight#; 
  text-decoration: #layout.MessageThreeDecor#; color: #layout.MessageThreeColor#; } 

.cfMini
{ font-family: #layout.PrimaryFontFamily#; font-size: #layout.MiniSize#px; font-weight: #layout.MiniWeight#; 
  text-decoration: #layout.MiniDecor#; color: #layout.MiniColor#; } 

.cfRetail
{ font-family: #layout.PrimaryFontFamily#; font-size: #layout.DefaultSize#px; font-weight: #layout.DefaultWeight#;
  text-decoration: line-through; color: #layout.DefaultColor#; }
	  
.cfTableHeading
{ font-family: #layout.PrimaryFontFamily#; font-size: #layout.TableHeadingSize#px; font-weight: #layout.TableHeadingWeight#; 
  text-decoration: #layout.TableHeadingDecor#; color: #layout.TableHeadingColor#; } 

.cfWhite
{ font-family: #layout.PrimaryFontFamily#; font-size: 11px; font-weight: bold; color: FFFFFF; } 

.cfMiniWhite
{ font-family: #layout.PrimaryFontFamily#; font-size: 10px; font-weight: bold; color: FFFFFF; } 


div.myaccount	
{ width:800px; height:21px; margin: 0px; padding: 2px 0px 0px 0px;
  background-color:###layout.TableHeadingBGColor#; color:###layout.MessageColor#; 
  text-align:left; text-decoration:none; font-weight:bold; text-indent:7px; cursor:hand;							  
  border:1px solid; border-top-color:###layout.TableHeadingBGColor#; border-left-color:###layout.TableHeadingBGColor#; 
  border-right-color:###layout.TableHeadingBGColor#; border-bottom-color:###layout.TableHeadingBGColor#;
  filter:progid:DXImageTransform.Microsoft.Gradient(GradientType=0,StartColorStr='##ffffffff',EndColorStr='###layout.TableHeadingBGColor#'); }




input.search_textbox { border: 1px solid ##666666; background-color: ##DEDEDE; font-family: arial; font-size: 11px; font-weight: bold; color: ##666666; padding-left: 4px; padding-right: 4px; }
input.search_button { border: 0px; width: 47px; height: 18px; margin-left: 10px; background-image: url(images/framework/top_search.gif); background-repeat: no-repeat; background-position: left top; cursor: hand; }
input.common_button { font-family: arial; font-weight: bold; font-size: 11px; color: ##5b77ad; border: 1px solid ##AEBDD8; margin-right: 3px; margin-top: 8px; margin-bottom: 3px; height: 20px; background-color: ##E8ECF2; background-image: url(images/framework/btn_common_bg.gif); background-position: bottom; background-repeat: repeat-x; cursor: hand; }

/* Link Classes */
.td15 a, .product_detail_cell a 
{ font-family: #layout.PrimaryFontFamily#; font-weight: #layout.PrimaryLinkWeight#; text-decoration: #layout.PrimaryLinkDecor#; color: ###layout.PrimaryLinkColor#; }

.cartm td a, .cartm_checkout a, .cart td a, .cart_checkout a, .cart_checkout td, .product_pageanchor a,
.system_message a, .p15_message a, .p15_margin a, .next_n a, .co_infothusfar a,
.co_creditcard a, .product_info_span a,.product_feature_cell, .product_feature_cell a,.cart_checkout span 
{ font-family: #layout.PrimaryFontFamily#; font-weight: #layout.PrimaryLinkWeight#; text-decoration: #layout.PrimaryLinkDecor#; color: ###layout.PrimaryLinkColor#; }

.td15 a, .system_message a, .p15_message a, .next_n a, .co_infothusfar a, .p15_margin a,
.cartm td a:hover, .cartm_checkout a:hover, .cart td a:hover, .cart_checkout a:hover,
.co_creditcard a, .blue_span a, .product_feature_cell a:hover 
{ font-family: #layout.PrimaryFontFamily#; font-weight: #layout.PrimaryHLinkWeight#; text-decoration: #layout.PrimaryHLinkDecor#; color: #layout.PrimaryHLinkColor#; }

.td15 a:hover, .system_message a:hover, .p15_message a:hover, .next_n a:hover, .product_topanchor a:hover,
.co_infothusfar a:hover, .p15_margin a:hover, .product_pageanchor a:hover, .blue_span a:hover,
.co_creditcard a:hover, .product_info_span a:hover, .blue_span a:hover,
.product_feature_cell a, .product_detail_cell a:hover 
{ font-family: #layout.PrimaryFontFamily#; font-weight: #layout.PrimaryHLinkWeight#; text-decoration: #layout.PrimaryHLinkDecor#; color: #layout.PrimaryHLinkColor#; }


/* Global Classes */
.sub_pagetitle { font-family: #layout.HeadingFontFamily#; font-weight: #layout.HeadingWeight#; font-size: #layout.HeadingSize#px; color: ###layout.HeadingColor#; text-align: center; text-decoration: #layout.HeadingDecor#; }
.sub_pagetitle img { margin: 0px 0px 15px 0px; }
.sub_pagehead { border: 0px solid ###layout.TableHeadingBGColor#; padding: 10px 10px 10px 10px; text-align:center; }

/* Product List Styles */
.productlist td 
{ border: 1px solid ###layout.PrimaryBGColor#; border-collapse: collapse; padding: 5px 5px 5px 5px; vertical-align:middle;
  border-top-color:###layout.TableHeadingBGColor#; border-left-color:###layout.PrimaryBGColor#; 
  border-right-color:###layout.PrimaryBGColor#; border-bottom-color:###layout.TableHeadingBGColor#;
  background-color: ###layout.PrimaryBGColor#; font-family: #layout.PrimaryFontFamily#; font-weight: #layout.DefaultWeight#; 
  font-size: #layout.DefaultSize#px; color: ###layout.DefaultColor#; text-decoration: #layout.DefaultDecor#; }
.productlist select, .productlist input { vertical-align:middle; }

.help, .help a, .help a:hover
{ padding: 5px 5px 5px 5px; background-color: ###layout.TableHeadingBGColor#; font-family: #layout.PrimaryFontFamily#; 
  font-weight: #layout.TableHeadingWeight#; font-size: #layout.TableHeadingSize#px; color: ###layout.TableHeadingColor#; 
  text-decoration: #layout.TableHeadingDecor#; }
.help select, .help input { vertical-align:middle; }

/* Shopping Cart Styles */
.cart th, .cart td { border: 1px solid ###layout.PrimaryBGColor#; border-collapse: collapse; }
.cart th, .cart_footer td, .cart_tally td { padding: 5px 5px 5px 5px; background-color: ###layout.TableHeadingBGColor#; font-family: #layout.PrimaryFontFamily#; font-weight: #layout.TableHeadingWeight#; font-size: #layout.TableHeadingSize#px; color: ###layout.TableHeadingColor#; text-decoration: #layout.TableHeadingDecor#; }
.cart td { padding: 5px 5px 5px 5px; }
.cart_tally td { background-color: ##E9E9E9; font-size: #layout.TableHeadingSize#px; color:###layout.TableHeadingBGColor#; }
.cart_footer td  { font-size: #layout.TableHeadingSize#px; }
.cart_altrow_a { background-color: <!---###layout.TableHeadingColor#--->##F7F7F7; }
.cart_altrow_b { background-color: <!---###layout.TableHeadingColor#--->##F0F0F0;; }
.cart_img_button { border: 0px; }
.cart_checkout a, .cart_checkout td { font-family: #layout.PrimaryFontFamily#; font-weight: bold; text-decoration: #layout.PrimaryLinkDecor#; color: ###layout.PrimaryLinkColor#; }
.cart_checkout a:hover { font-family: #layout.PrimaryFontFamily#; font-weight: bold; text-decoration: #layout.PrimaryHLinkDecor#; color: ###layout.PrimaryHLinkColor#; }
.cart_checkout span { font-weight: normal; }
.cart_checkout input { margin: 5px 0px 0px 0px; }
.cart_image { width: 50px; border: 0px solid ###layout.TableHeadingBGColor#; }
.cartview th, .cartview td { border: 1px solid ###layout.PrimaryBGColor#; border-collapse: collapse; }
.cartview th, .cartview_footer td, .cartview_tally td { padding: 5px 5px 5px 5px; background-color: ###layout.PrimaryBGColor#; font-family: #layout.PrimaryFontFamily#; font-weight: #layout.TableHeadingWeight#; font-size: #layout.TableHeadingSize#px; color: ###layout.TableHeadingBGColor#; text-decoration: #layout.TableHeadingDecor#; }
.cartview td { padding: 5px 5px 5px 5px; }
.cartview_tally td { background-color: ##E9E9E9; font-size: #layout.TableHeadingSize#px; }
.cartview_footer td  { font-size: #layout.TableHeadingSize#px; }
.cartview_altrow_a { background-color: <!---###layout.TableHeadingColor#--->##F7F7F7; }
.cartview_altrow_b { background-color: <!---###layout.TableHeadingColor#--->##F0F0F0; }

<!---
input.button 		{ background-color:##fed; color:###ColorHeader#; 
					  font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; 
					  border:1px solid; border-top-color:###ColorFooter#; border-left-color:###ColorFooter#;
					  border-right-color:###ColorFooter#; border-bottom-color:###ColorFooter#;
					  filter:progid:DXImageTransform.Microsoft.Gradient(GradientType=0,StartColorStr='##ffffffff',EndColorStr='##ffeeddaa'); }

input.button:hover 	{ background-color:##fed; color:###ColorLink#; 
					  font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; 
					  border:1px solid; border-top-color:###ColorLink#; border-left-color:###ColorLink#; 
					  border-right-color:###ColorLink#; border-bottom-color:###ColorLink#;
					  filter:progid:DXImageTransform.Microsoft.Gradient(GradientType=0,StartColorStr='##ffffffff',EndColorStr='##ffeedd77'); }
--->
							  
/* cart Mini Styles */
.cartm { background-color: ##FFFFFF; }
.cartm th, .cartm_footer td, .cartm_tally td { padding: 2px 2px 2px 2px; background-color: ##5B77AD; font-family: arial; font-weight: bold; font-size: 11px; color: ##ffffff; }
.cartm td { font-size: 11px; padding: 2px 2px 2px 2px; }
.cartm .cart_tally td { font-size: 11px; }
.cartm .cart_footer td  { font-size: 11px; }

</cfoutput>

/***  BEGIN: CALENDAR Styles  */
#calendar {position:absolute; 
		   left:0px; 
		   top:0px; 
		   visibility:hidden
		  }
th {background-color:#ccffcc; 
	text-align:center; 
	font-size:10px; 
	width:26px
   }
#tableHeader {background-color:#ffcccc; 
			  width:100%
			 }

#tableBody tr td {width:26px}
#today {background-color:#ffcc33}
/***  END: CALENDAR Styles  */

/***  END: Text Styles  */
</style>
</cfprocessingdirective>