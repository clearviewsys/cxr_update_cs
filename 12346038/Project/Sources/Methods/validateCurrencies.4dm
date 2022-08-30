//%attributes = {}
checkIfNullString(->[Currencies:6]CurrencyCode:1; "Currency Alias")  // for mandatory strings
checkIfNullString(->[Currencies:6]ISO4217:31; "Currency Code")  // for mandatory strings
checkIfNullString(->[Currencies:6]toISO4217:32; "to Currency Code")  // for mandatory strings
If ([Currencies:6]isTemp:57=False:C215)
	checkUniqueKey(->[Currencies:6]; ->[Currencies:6]CurrencyCode:1; "Currency Alias")
End if 
//checkIfNullString (->Name;"Currency Name")  ` for mandatory strings
//checkIfNullString (->Country;"Country Name")
//checkGreaterThan (->[Currencies]OurBuyRateLocal;"Our Buy Rate";0)
//checkGreaterThan (->[Currencies]OurBuyRateLocal;"Our Sell Rate";0)]

If ([Currencies:6]isDisplayOnly:33)
	checkAddWarningOnTrue([Currencies:6]hasCashAccount:23; "This currency has associated cash account(s).")
	checkAddWarningOnTrue([Currencies:6]hasChequeAccount:24; "This currency has associated chequing account")
End if 

If ([Currencies:6]minSellLocal:16>0)
	checkAddWarning("You have limited the minimum rate for selling.")
End if 

If ([Currencies:6]maxBuyLocal:15>0)
	checkAddWarning("You have limited the maximum rate for buying.")
End if 


checkAddErrorIf(([Currencies:6]toISO4217:32#<>baseCurrency) & ([Currencies:6]isDisplayOnly:33=False:C215); "You cannot trade this currency because the base is "+[Currencies:6]toISO4217:32+". Click on 'For display only' ")
checkAddErrorIf((([Currencies:6]hasCashAccount:23 | [Currencies:6]hasChequeAccount:24) & [Currencies:6]isDisplayOnly:33); "Cannot accept cash or cheque for a 'Display Only' currency.")
checkAddErrorIf(([Currencies:6]SpotRateLocal:17<=0); "Market (spot) rate must have a positive value.")
checkAddWarningOnTrue((([Currencies:6]OurBuyRateLocal:7=0) & ([Currencies:6]OurSellRateLocal:8=0)); "Your Buy and Sell rates are left at zero.")

