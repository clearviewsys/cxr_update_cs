// Data Checking Procedure
// This code must be placed in the SAVE button script
// Always assign the shortcut (Enter) to your SAVE button
C_TEXT:C284(vFromAccount; vToAccount; vCurrency)

checkInit
checkIfNullString(->vFromAccount; "Transfer From Account")  // for mandatory strings
checkIfNullString(->vToAccount; "Transfer To Account")  // for mandatory strings
checkGreaterThan(->vExchangeRate; "Exchange Rate"; 0)  // for mandatory numbers
checkLowerBound(->vFromAmount; "Transfer Amount"; 1)  // for mandatory numbers

If (vWarning#"")
	checkAddWarning(vWarning)
End if 

If (isValidationConfirmed)
	handleTransferButton
Else 
	REJECT:C38
End if 

