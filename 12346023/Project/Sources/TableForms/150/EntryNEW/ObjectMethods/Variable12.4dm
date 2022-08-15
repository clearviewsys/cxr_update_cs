If (Form event code:C388=On Data Change:K2:15)
	C_TEXT:C284($curr)
	$curr:=Form:C1466.Rule.ifCurrency
	pickCurrencyISOCode(->$curr)
	Form:C1466.Rule.ifCurrency:=$curr
End if 

