handleSaveButton
checkInit
validateAccountPickedInInvoice
validateItemInOuts

applyFocusRect
If (isValidationConfirmed)
	createRegisterOfItemInOuts
	clearInvoiceEnterableVars  // this must be the last line -- DO NOT MOVE THIS LINE BEFORE THE createRegisterFromInvoice
Else 
	REJECT:C38
End if 

