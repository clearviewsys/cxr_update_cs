validateTellerProofForm

If (isValidationConfirmed)
	saveTellerProofLines
	//clearTellerProofArrarys 
	handleNextCurrBInTP
	SAVE RECORD:C53([TellerProof:78])
	
Else 
	BEEP:C151
	REJECT:C38
End if 
