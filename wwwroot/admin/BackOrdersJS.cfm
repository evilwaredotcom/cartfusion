<script language="JavaScript">
<!-- Begin
	function CheckChoice(whichbox,LocalValue)
	{
		with (whichbox.form)
		{
			//Handle differently, depending on type of input box.
			if (whichbox.type == "radio")
			{
				//First, back out the prior radio selection's price from the total:
				hiddentotal.value = eval(hiddentotal.value) - eval(hiddenpriorradio.value);
				//Then, save the current radio selection's price:
				hiddenpriorradio.value = eval(whichbox.price);
				//Now, apply the current radio selection's price to the total:
				hiddentotal.value = eval(hiddentotal.value) + eval(whichbox.price);
			}
			else
			{
				//If box was checked, accumulate the checkbox value as the form total,
				//Otherwise, reduce the form total by the checkbox value:
				if (whichbox.checked == false)
					{ hiddentotal.value = eval(hiddentotal.value) - eval(LocalValue); }
				else 	
					{ hiddentotal.value = eval(hiddentotal.value) + eval(LocalValue); }
			}

			//Ensure the total never goes negative (some browsers allow radiobutton to be deselected):
			if (hiddentotal.value < 0)
				{
				InitForm();
				}
		
			//Now, return with formatted total:
			return(formatCurrency(hiddentotal.value));
			
		}
	}

	//Define function to format a value as currency:
	function formatCurrency(num)
	{
	   // Courtesy of http://www7.brinkster.com/cyanide7/
		num = num.toString().replace(/\$|\,/g,'');
		if(isNaN(num))
		   num = "0";
		sign = (num == (num = Math.abs(num)));
		num = Math.floor(num*100+0.50000000001);
		cents = num%100;
		num = Math.floor(num/100).toString();
		if(cents<10)
			cents = "0" + cents;
		for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)
			num = num.substring(0,num.length-(4*i+3))+','+
				  num.substring(num.length-(4*i+3));
  		return (((sign)?'':'-') + num + '.' + cents);
	}

	//Define function to init the form on reload:
	function InitForm()
		{
		//Reset the displayed total on form:
		document.formProcessPayment.LocalTotal.value=0;
		document.formProcessPayment.hiddentotal.value=0;
		document.formProcessPayment.hiddenpriorradio.value=0;

		//Set all checkboxes and radio buttons on form-1 to unchecked:
		for (xx=0; xx < document.formProcessPayment.elements.length; xx++)
		{
		   if (document.formProcessPayment.elements[xx].type == 'checkbox' | document.formProcessPayment.elements[xx].type == 'radio')
			{
			document.formProcessPayment.elements[xx].checked = false;
			}
		}
	}

//  End -->
</script>