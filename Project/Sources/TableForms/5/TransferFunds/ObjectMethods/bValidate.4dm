// Data Checking Procedure
// This code must be placed in the SAVE button script
// Always assign the shortcut (Enter) to your SAVE button
C_TEXT:C284(vFromAccount; vToAccount; vCurrency; vInvoiceNumber)
C_REAL:C285(vAmount)
C_REAL:C285($vMaximumTransferOut)

applyFocusRect
If (Form event code:C388=On Clicked:K2:4)
	checkInit
	checkIfAccountIDExists(->vFromAccount; "Transfer from account")
	checkIfAccountIDExists(->vToAccount; "Transfer to account")
	checkGreaterThan(->vAmount; "Transfer Amount"; 0)  // for mandatory numbers
	checkAddErrorIf((vFromAccount=vToAccount); "Cannot transfer into same account")
	checkifRecordExists(->[Currencies:6]; ->[Currencies:6]ISO4217:31; ->vCurrency; "Currency")
	checkifAccountisOfCurrency(vFromAccount; vCurrency)
	checkifAccountisOfCurrency(vToAccount; vCurrency)
	checkIfNullString(->vInvoiceNumber; "Invoice Number")
	checkIfValidDate(->vFromDate; "Transfer Date")
	checkIfValidDate(->vToDate; "Deposit Date")
	checkAddWarningOnTrue((vFromDate>vToDate); "Transfer date is greater than deposit date")
	queryByID(->[Accounts:9]; vFromAccount)
	$vMaximumTransferOut:=[Accounts:9]maxTransferOutAllowed:32
	
	checkAddErrorIf(($vMaximumTransferOut>0) & (vAMount>$vMaximumTransferOut); "The maximum allowed transfer for "+vFromAccount+" is "+String:C10($vMaximumTransferOut))
	
	
	
	If (isValidationConfirmed)
		handleTransferButton
	Else 
		REJECT:C38
	End if 
End if 

