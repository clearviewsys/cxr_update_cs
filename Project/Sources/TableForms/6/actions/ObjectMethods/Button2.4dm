C_REAL:C285($percent)

If (Records in set:C195("$Currencies_LBSet")=0)
	ALERT:C41("Please highlight some records first.")
Else 
	$percent:=Num:C11(Request:C163("Increase buy margins by %?"))
	READ WRITE:C146([Currencies:6])
	USE SET:C118("$Currencies_LBSet")
	If ($percent>0)
		APPLY TO SELECTION:C70([Currencies:6]; [Currencies:6]MinusPctFromMarketBuy:11:=[Currencies:6]MinusPctFromMarketBuy:11+$percent)
		handleFetchCurrencyRatesButton("$Currencies_LBSet")
	End if 
	READ ONLY:C145([Currencies:6])
End if 