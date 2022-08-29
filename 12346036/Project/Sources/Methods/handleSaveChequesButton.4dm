//%attributes = {}
// handleSaveChequeButton 
// this method is called from the save button for PAY/RECEIVE forms in [CHEQUES]
checkInit
validateAccountPickedInInvoice
validatecheques

If (isValidationConfirmed)
	If (Is new record:C668([Cheques:1]))
		[Cheques:1]BranchID:25:=getBranchID
	Else 
		[Cheques:1]modBranchID:30:=getBranchID
	End if 
	
	createRegisterOfCheques
	If (getClientAutoChequePrint)
		displayPrintChequeDialog
	End if 
	
	clearInvoiceEnterableVars  // this must be the last line -- DO NOT MOVE THIS LINE BEFORE THE createRegisterFromcheque
	SAVE RECORD:C53([Cheques:1])
Else 
	REJECT:C38
End if 