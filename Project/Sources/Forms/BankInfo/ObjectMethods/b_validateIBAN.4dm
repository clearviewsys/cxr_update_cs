C_TEXT:C284($errorCode; $checkSum; $vCountryCode; $vBankCity; $vAddress)
C_TEXT:C284(vBankName; vSwift)

If (vAccountNo#"")
	validateIBAN(vAccountNo; ->$errorCode; ->vBankName; ->$vCountryCode; ->$vBankCity; ->$vAddress; ->vSwift; ->$checkSum)
	If ($errorCode#"")
		myAlert("Error Code"+$errorCode)
	End if 
Else 
	myAlert("Please enter an IBAN to check. E.g. (FR8630004003200001019471670)")
End if 
