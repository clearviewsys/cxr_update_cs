C_TEXT:C284(vCounterAccount)

checkInit
//checkIfAccountIDExists (->vCounterAccount;"Counter Account")
//checkifAccountisOfCurrency (vCounterAccount;pdCurrencies{pdCurrencies})
If (isValidationConfirmed)
	handleSaveAdjustments2
	ACCEPT:C269
Else 
	REJECT:C38
End if 

