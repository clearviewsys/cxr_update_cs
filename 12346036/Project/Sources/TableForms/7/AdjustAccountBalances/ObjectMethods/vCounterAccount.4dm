//C_REAL(vFrombalance)
//
C_TEXT:C284(vCounterAccount)

If (pdCurrencies>0)
	C_TEXT:C284($currency)
	$currency:=pdCurrencies{pdCurrencies}
	pickAccountsOfCurrency(Self:C308; $currency; "Choose an adjuster account:")
Else 
	ALERT:C41("Please choose a currency first")
End if 