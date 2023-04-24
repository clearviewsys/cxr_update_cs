C_TEXT:C284($errorCode; $checkSum)

If ([Wires:8]BeneficiaryAccountNo:9#"")
	validateIBAN([Wires:8]BeneficiaryAccountNo:9; ->$errorCode; ->[Wires:8]BeneficiaryBankName:3; ->[Wires:8]BeneficiaryBankCountry:6; ->[Wires:8]BeneficiaryBankCityState:5; ->[Wires:8]BeneficiaryBankAddress:4; ->[Wires:8]BeneficiarySWIFT:28; ->$checkSum)
	If ($errorCode#"")
		myAlert("Error Code"+$errorCode)
	Else 
		pickCountry(->[Wires:8]BeneficiaryBankCountry:6)
	End if 
	
Else 
	myAlert("Please enter an IBAN to check. E.g. (FR8630004003200001019471670)")
End if 
