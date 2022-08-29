// Data Checking Procedure
// This code must be placed in the SAVE button script
// Always assign the shortcut (Enter) to your SAVE button
checkInit
validateCurrencies

If (isValidationConfirmed)
	postValidateCurrencies
	SAVE RECORD:C53([Currencies:6])
	writeCurrencyRatesAsXML
Else 
	REJECT:C38
End if 

