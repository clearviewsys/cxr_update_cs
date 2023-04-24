If (Form event code:C388=On Data Change:K2:15)
	C_TEXT:C284($curr)
	$curr:=Form:C1466.Rule.toCurrency
	pickCurrencyISOCode(->$curr)
	Form:C1466.Rule.toCurrency:=$curr
End if 
