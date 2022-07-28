<cfscript>
	RunningWeight = RunningWeight + (Weight * Qty);
	TotalPrice = UseThisPrice * Qty;		
	FinalDesc = '<b>' & ItemName & '</b>';
	if (OptionName1 NEQ '')
		FinalDesc = '#FinalDesc#<br>#OptionName1#';
	if (OptionName2 NEQ '')
		FinalDesc = '#FinalDesc#, #OptionName2#';
	if (OptionName3 NEQ '')
		FinalDesc = '#FinalDesc#, #OptionName3#';
	if (BackOrdered EQ 1)
	{
		BackOrdersPrice = BackOrdersPrice + (UseThisPrice * Qty) ;
		FinalDesc = '#FinalDesc# (BACK ORDERED)';
	}
	NormalPrice = TotalPrice;
</cfscript>