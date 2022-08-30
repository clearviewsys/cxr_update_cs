If (Form event code:C388=On Load:K2:1)
	ARRAY TEXT:C222(pdCurrencies; 0)
	ALL RECORDS:C47([Accounts:9])
	handleCurrencyPullDown(Self:C308; ->[Accounts:9]; ->[Accounts:9]Currency:6)
	Self:C308->{Self:C308->}:=<>baseCurrency
End if 


If (Form event code:C388=On Clicked:K2:4)
	handleCurrencyPullDown(Self:C308; ->[Accounts:9]; ->[Accounts:9]Currency:6)
	fillAdjustmentArrays(Self:C308->{Self:C308->})
End if 