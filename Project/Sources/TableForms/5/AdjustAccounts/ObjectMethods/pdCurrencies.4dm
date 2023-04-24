//
//If (Form event=On Load )
//ARRAY TEXT(pdCurrencies;0)
//ALL RECORDS([Accounts])
//handleCurrencyPullDown (Self;->[Accounts];->[Accounts]Currency)
//  `Self->{Self->}:=◊baseCurrency
//End if 
//
//
//If (Form event=On Clicked )
//handleCurrencyPullDown (Self;->[Accounts];->[Accounts]Currency)
//If (pdCurrencies=1)
//fillAdjustmentArrays2   ` all 
//Else 
//fillAdjustmentArrays2 (pdCurrencies{pdCurrencies})
//End if 
//End if 

If (Form event code:C388=On Load:K2:1)
	ARRAY TEXT:C222(pdCurrencies; 0)
	ALL RECORDS:C47([Accounts:9])
End if 

handleCurrencyPullDown(Self:C308; ->[Accounts:9]; ->[Accounts:9]Currency:6)

