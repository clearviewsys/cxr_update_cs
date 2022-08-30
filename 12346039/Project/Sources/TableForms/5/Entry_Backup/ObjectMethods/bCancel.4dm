If (Is new record:C668([Invoices:5]))
	checkInit
	checkAddWarningOnTrue(((vSumDebitsLocal>0) | (vSumCreditsLocal>0)); "This invoice is not blank. Are you sure you want to discard the changes?")
	If (isValidationConfirmed)
		//canceltransaction
		// Modified by: Tiran Behrouz (2/18/13)
		CANCEL:C270
	Else 
		REJECT:C38
	End if 
Else 
	//canceltransaction
	// Modified by: Tiran Behrouz (2/18/13)
	CANCEL:C270
End if 
