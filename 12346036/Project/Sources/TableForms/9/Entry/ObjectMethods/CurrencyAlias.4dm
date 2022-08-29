If (Form event code:C388=On Data Change:K2:15)
	pickCurrency(Self:C308)
	selectCurrencyByAlias(Self:C308->)
	If (Records in selection:C76([Currencies:6])=1)
		Self:C308->:=[Currencies:6]CurrencyCode:1
		[Accounts:9]Currency:6:=[Currencies:6]ISO4217:31
	Else 
		Self:C308->:=""
	End if 
End if 