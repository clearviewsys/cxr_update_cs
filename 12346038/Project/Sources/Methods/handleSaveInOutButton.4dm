//%attributes = {}
// handleSaveInOutButton 
// this method is called from the save button for PAY/RECEIVE forms in [InOutS]
checkInit
validateAccountInOuts
validateAccountPickedInInvoice

If (isValidationConfirmed)
	If (Is new record:C668([AccountInOuts:37]))
		[AccountInOuts:37]BranchID:18:=getBranchID
	Else 
		[AccountInOuts:37]modBranchID:26:=getBranchID
	End if 
	// do other things before save
	createRegisterOfAccountInOuts
	clearInvoiceEnterableVars
Else 
	REJECT:C38
End if 